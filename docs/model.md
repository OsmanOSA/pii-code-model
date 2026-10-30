# Model and training

## Requirements

- Runs locally on a laptop CPU, inside Agent Privacy Guard's background service, with numpy, onnxruntime and tokenizers only.
- French, English and code; inputs up to several thousand tokens (logs, CSV extracts).
- Under 150 MB after quantization; latency compatible with an interactive coding agent.
- Weights under a permissive license (MIT or Apache 2.0), as the product's model policy requires (`evaluation/ner/licensing.md`).
- Trainable on an RTX 3050 with 4 GB of VRAM, with Kaggle GPUs for multi-seed runs.

## Base model: mmBERT-small

[mmBERT](https://arxiv.org/abs/2509.06888) (Johns Hopkins, 2025, ICML 2026) is a multilingual encoder built on the ModernBERT architecture: rotary position embeddings, attention alternating between a local window and a global layer, unpadding with FlashAttention, GeGLU layers, an 8,192-token context, and pretraining on 3T tokens covering French, English and code. The small version has 140M parameters, of which only 42M sit outside the embedding table (256,000 tokens of 384 dimensions, Gemma 2 tokenizer).

| Candidate | Size | Role |
| --- | --- | --- |
| **mmBERT-small** | 140M, 42M outside embeddings | **base**: modern architecture, French + English + code, MIT |
| mmBERT-base | 307M, 110M outside embeddings | fallback if small plateaus; possible teacher |
| [Granite Embedding Multilingual R2](https://arxiv.org/abs/2605.13521), 97M (IBM, May 2026) | 97M | bake-off only. ModernBERT architecture, 32k context, enhanced code support, Apache 2.0; but a retrieval checkpoint trained for pooled embeddings, not per-token labels |
| EuroBERT-210m (2025) | 210M | bake-off only if mmBERT-small disappoints; license to check |
| Ettin 68M (2025) | 68M | excluded: English only |
| [OpenAI Privacy Filter](https://huggingface.co/openai/privacy-filter) (April 2026) | 1.5B total, 50M active (mixture of experts) | competitor and design reference, not a base: too large on disk for the size target, not trainable on 4 GB, primarily English |
| GLiNER2-PII (Fastino) | about 0.3B | competitor. Its open-label span extraction costs compute without benefit for a fixed label set |

The choice of base is not what wins: Nym small, built on mmBERT-small, reached only 60% recall on person names in the product's comparison of 5 October 2026. Data and recipe decide.

## Architecture

### Backbone and vocabulary

The embedding table is 70% of the parameters. Reducing the vocabulary to the tokens that occur in French, English and code (measured on the training mix and a public text sample) is the main lever on size and on training memory: gradients and Adam states of the full table weigh about 1.2 GB in fp32. Reduction happens before training. The conversion script verifies on the whole corpus that offsets still restore every text exactly; a failure blocks the batch. Fallback: keep the full vocabulary and freeze the embedding table during fine-tuning.

At 60,000 kept tokens, the model has about 65M parameters, about 65 MB in int8.

mmBERT uses the Gemma 2 tokenizer, not ModernBERT's, so ModernBERT's known extra-space issue is checked rather than patched with `add_prefix_space`.

### Output head and decoding

- **Token labels**: BIOES over the eight categories, 33 labels. Explicit end and single-token tags let the decoder close spans precisely, and BILOU-style schemes outperform BIO in the NER literature (Ratinov and Roth, 2009).
- **Alignment**: when an entity border falls inside a token, the token joins the entity. Hiding one character too many is harmless; leaking one is not. The conversion script counts these cases per kind; above 1% for a kind, its tokenization is reviewed.
- **Constrained Viterbi decoding**: only valid BIOES transitions are allowed. Per-category biases on span entry and continuation set the operating point, the way OpenAI's Privacy Filter exposes precision and recall presets. These biases are tuned on validation to reach the [recall target](recall-target.md); the loss stays plain cross-entropy so probabilities stay calibrated.
- **CRF**: learning the transition scores with a linear-chain CRF is an ablation on top of the constrained decoder. It gave good results on mmBERT-base in a model published on Hugging Face.

### Post-processing

1. **Snap to whole words**: a span is extended to the whole pre-token (whitespace and punctuation boundaries, kind-aware for emails and URLs), because a partially hidden value is a leak.
2. **Propagate within the input**: every other exact occurrence of a detected value in the same input is hidden too. This mirrors the product's reuse of names already found in the session.
3. **Union with the product's rules**, which keep priority on the formats they verify.
4. **Long inputs**: windows with overlap, union of detections, so no entity is lost at a window edge. Window size is set by latency measurement.

## Training

### 1. Supervised fine-tuning

Starting points, each swept on validation:

- bf16 mixed precision on the RTX 3050 (Ampere); fp16 with loss scaling and PyTorch SDPA attention on Kaggle's T4, which supports neither bf16 nor FlashAttention 2.
- Sequences of 1,024 tokens with unpadding, gradient checkpointing, gradient accumulation to an effective batch of about 32 sequences.
- AdamW, learning rate between 3e-5 and 8e-5, 6% warmup, linear decay, weight decay 0.01, 2 to 3 epochs.
- Plain token cross-entropy. Recall is set by the decoding biases, not by class weights that would distort calibration.
- Three seeds per configuration; checkpoints saved regularly.

### 2. Reinforcement fine-tuning with a verifiable reward

DeepSeek-R1 replaced RLHF with reinforcement learning on a verifiable reward, without human preferences or a learned reward model, using GRPO from DeepSeekMath: each input gets a group of answers, each answer is scored by a rule, and its advantage is its score relative to the group mean, which removes PPO's critic network. Our synthetic data has exact labels by construction, so the reward is verifiable without a judge.

The transfer to a token-labelling encoder:

- **Policy**: the linear-chain distribution over valid BIOES sequences given by the emissions and the constrained transitions.
- **Group**: one encoder pass per text, then G = 8 labellings drawn by forward filtering and backward sampling. Every sample is a valid sequence, and a sample costs no extra encoder pass, so the group is almost free and fits in 4 GB.
- **Reward**, at character and entity level against the exact labels, reflecting what the product lives through:
  - *leak*: for each entity, the share of its characters left visible, weighted by category (start with secret 3, identifier 2, banking 2, others 1);
  - *false alarm*: a cost per span detected over no entity, heavier on recorded traps, heaviest on code identifiers since hiding them breaks the agent's work. This is the term that rules out the trivial "hide everything";
  - *over-reach*: a small cost per hidden character outside the entity a span overlaps, so the model does not learn to hide whole lines to avoid partial leaks;
  - *wrong category*: a moderate cost, high when a secret is labelled as something else, because the product would pseudonymize it instead of deleting it.
- **Advantage**: reward minus the group mean, divided by the group standard deviation. A text where every sample scores the same gives no gradient, so training concentrates on the inputs where the model hesitates.
- **Objective**: log-probability of each labelling times its advantage, plus a KL penalty toward the supervised model. One update per batch, on-policy, without PPO's clipped ratio. If the KL penalty alone lets the model drift, a small cross-entropy term is kept.

Cross-entropy scores tokens independently: a three-token name with one missed token costs a third, while for the product the name leaked. The reward measures the masking outcome directly, with asymmetric costs. This is minimum risk training (Shen et al., 2016) with GRPO's group baseline.

It starts from the best supervised model, never replaces it: an untrained head has nothing to reinforce and would get a reward of almost zero. It is an ablation, kept only under the rule at the end of this page.

### 3. Error-driven generation loop

Probably the largest gain. Each iteration:

1. the model runs on a fresh batch of evaluation templates it has never seen;
2. leaks, partial leaks, false alarms, wrong categories and doubtful decisions are grouped by cell of the coverage matrix and by appearance mode (variable, URL, nested JSON, CSV row);
3. the report, with excerpts in template form, becomes the brief of the next generation session ([error-driven-generation.md](../prompts/error-driven-generation.md));
4. the new templates join training only; the split by seed keeps validation separate, and MinHash keeps new templates away from evaluation templates;
5. the loop stops when validation F2 plateaus two iterations in a row.

The risk is that the model improves on the generator's view of its errors rather than on reality. Only the real test set judges that.

### 4. Self-evaluation head

A small head on the same encoder predicts, for each token, the probability that the main decision is wrong (leak or false alarm). It is the encoder counterpart of DeepSeekMath V2's verifier.

- **Honest errors**: it is trained on the main model's errors on seeds the main model never saw, a calibration split of about 10% of seeds kept apart from training and validation. Errors on training data would be too rare and too easy.
- **Fail-closed use**: a token the main head leaves visible but the self-evaluation head judges likely wrong is hidden, with its most probable category, extended to the whole word. The threshold is set per category on validation.
- **During the RL stage**, its accuracy can enter the reward, as DeepSeekMath V2 rewards honest self-verification.
- **Error loop**: it ranks evaluation examples by doubt, which feeds the `doubt` clusters of the report.

It is compared with a plain threshold on the main head's probability of `O`. If it brings nothing at equal precision, it is removed, since it makes the model heavier.

### What we do not do

- No self-training on unlabelled real files with the model's own labels: it would reinforce its misses, which are precisely the leaks, and it would require collecting real data, which the product exists to avoid.
- No RLHF and no learned reward model: with exact labels they only add noise.

## Export and integration

ONNX export, int8 quantization of the weights, Viterbi decoding in numpy on the service side. Every quantized graph is compared with the full-precision model before it is kept: Agent Privacy Guard found that the published quantized DistilCamemBERT graph detected none of the 19 names it should have found (`evaluation/ner/distil-artifact-check.json`). A quantized graph is rejected if any category's recall drops by more than 0.2 point on validation.

In the product, the model replaces DistilCamemBERT in the background service with the same contract: files verified by SHA-256 before every load, numpy, onnxruntime and tokenizers on the service side only, the hook in the standard library, fail closed on an invalid package. Each category other than `name` gets a kind in `core/category_policy.py`.

## Keep rule

Every addition to the supervised baseline (CRF transitions, RL stage, self-evaluation head) is an ablation: three seeds, unseen seeds for evaluation, paired bootstrap. It is kept only if F2 or the leak rate improves significantly, with precision not significantly worse. Vocabulary reduction, needed for size, is checked the other way: kept unless it costs a significant drop.
