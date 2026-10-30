# Roadmap

Current step: **1, framing**. A pilot batch of 15 templates ([templates/raw/pilot-01](../templates/raw/pilot-01/batch-001.tpl)) and a first template checker and filler ([datagen/](../datagen/)) let the maintainer validate the guide on concrete examples. Given names follow the INSEE and SSA files by birth year, places come from GeoNames ([sources](data-pipeline.md#filling)). The maintainer kept the address rule after the pilot review.

| Step | Work | Done when |
| --- | --- | --- |
| 1. Framing | Labels and annotation guide ([labels.md](labels.md)), coverage matrix, choice of the English public dataset replacing CoNLL-2003 (Nemotron-PII is the candidate; license to confirm) | the maintainer has validated the labels and the guide |
| 2. Evaluation harness and real sets | Scorer for protection recall, typed overlap, strict exact scores, leak rate, Clopper-Pearson bounds and paired bootstrap, reusing Agent Privacy Guard's `evaluation/ner` and `benchmark/` code; first real documents annotated by hand into a development set and a test set | the scorer passes its tests on synthetic fixtures; the first 100 real test documents are annotated |
| 3. Baseline | Rules alone and every competitor on the real development set and the public benchmarks. The test set waits for the end, for every model | a per-category table shows where the margin is |
| 4. Data pipeline | Template checker, filler, transforms, public dataset conversion, first round of about 15 generation sessions, quality control, pre-training report | manual review error rate under 1 to 2%; every category and kind above its minimum |
| 5. Supervised training | Pipeline tested on a small sample locally; vocabulary reduction; full runs with three seeds | baseline scores on validation |
| 5 bis. RL stage | GRPO-style fine-tuning from the best supervised model, three seeds | kept or dropped under the keep rule |
| 6. Error loop | Iterations of error-driven generation; CRF transitions and self-evaluation head as ablations; operating points set on the real development set | validation F2 plateaus two iterations in a row, and every category reaches 99.5% protection recall on validation |
| 7. Export and integration | ONNX, int8, equivalence check against full precision; integration into Agent Privacy Guard's background service in place of DistilCamemBERT | the product's benchmark loses neither recall nor precision |
| 8. Final evaluation and release | Single evaluation on the real test set with every seed and confidence intervals; model card; publication of the model, evaluation script and, if possible, the technical benchmark | the claims in the model card match the measured bounds |

Budget: the RTX 3050 (4 GB) for local runs, Kaggle's weekly free GPU hours for multi-seed runs, paid GPU only as a last resort.

## Risks

- **Synthetic-to-real gap**: scores inflated internally, lower in real use. The real sets are the only protection.
- **Licenses** of public datasets and the frontier model provider's terms on training from its outputs, checked before any publication.
- **Competition** moving toward code (PII Engineer, OpenAI Privacy Filter with its `secret` category): timing matters.
- **Recall against false alarms**, settled by operating points per category rather than by sacrificing one blindly.
- **A gamed reward** in the RL stage: the false-alarm and over-reach terms, the KL penalty and the real sets are the guards.
- **Drift between the guide and the product**, which would teach the model a policy the rules do not follow. Policy changes land in the product first.
