# Recall target: 98% in every category

The goal is a recall of at least 98% in each of the eight categories, on real documents, for what users actually get: the product's rules and the model together. This page defines what is measured, what it takes to prove it, and the levers to get there. It is a target, not a result, and is not published before it is measured.

## What is measured

The unit is an annotated entity.

- **Protection recall** (headline): an entity counts as protected when every one of its characters is covered by spans that hide it, whatever their category. A partly hidden value is a leak.
- **Typed overlap recall**: same category and overlapping spans, the definition of the product's benchmark (`benchmark/scoring.py`), so results compare with `python -m benchmark`.
- **Exact typed precision, recall, F1 and F2** (strict mode of seqeval or nervaluate): borders and category must match, for comparison with published models.
- **Leak rate**: the share of entity characters left visible after masking.
- **Wrong-category rate**: hidden, but under another category. It matters most for secrets, which the product deletes instead of pseudonymizing.

Each is reported for three configurations, rules alone, model alone and their union, and broken down by category, language and content family (code, config, logs, tabular, docs, natural text), with micro and macro averages and false alarms per trap type.

## What it takes to prove 98%

A point estimate of 98% says little: the question is whether the lower bound of its confidence interval clears 98%. With a one-sided 95% Clopper-Pearson bound, a category's claim needs:

| Misses observed | Entities needed in that category | Observed recall |
| --- | --- | --- |
| 0 | 149 | 100% |
| 1 | 236 | 99.6% |
| 2 | 313 | 99.4% |
| 3 | 386 | 99.2% |
| 5 | 523 | 99.0% |

Three consequences:

1. **Aim at 99.5% on validation.** Real data is harder than synthetic data, and a measured 98% does not prove 98%.
2. **The real test set needs 150 to 500 entities per category.** A first set of 100 documents certifies no category. Frequent categories (names, emails) get there first; private keys, card security codes, passports or birth dates take longer. Until a category has enough real entities, the model card states that its result comes only from unseen synthetic seeds and public benchmarks.
3. **Every claim is per category.** A micro average dominated by names and emails can hide a weak category.

## Levers, in order of expected gain

1. **Union with the rules.** Emails, phones, IBANs, cards, French social security numbers and prefixed secrets are mostly caught by rules with check digits. Measuring rules alone first shows, per category, how much the model must add.
2. **Data coverage and the error loop.** The main lever for names, addresses, birth dates, secrets without prefix and US or UK identifiers ([data pipeline](data-pipeline.md), [model](model.md#3-error-driven-generation-loop)).
3. **One operating point per category.** The Viterbi decoder's entry and continuation biases are tuned so that each category reaches 99.5% protection recall. A category whose precision collapses at that point goes back to the data loop rather than shipping with a lower bar.
4. **Border safety.** Snapping spans to whole words, and extending them over the whole value for structured kinds (an email's local part and domain, an IBAN's or card's digit groups, a token's high-entropy run). Partial leaks count as leaks and are the cheapest to remove.
5. **Propagation within the input.** Every other occurrence of a detected value is hidden too, as the product already does for names within a session.
6. **Fail-closed self-evaluation.** Tokens left visible but judged likely wrong are hidden ([model](model.md#4-self-evaluation-head)).
7. **Overlapping windows** for long inputs, so no entity is lost at a window edge.
8. **The RL stage**, if its ablation keeps it.
9. **Averaging the weights** of the three seeds' models, which share their initialization: no inference cost. An ensemble of three models would triple latency and is a last resort.

### Operating points need real data

Operating points tuned on synthetic validation transfer imperfectly to real files, and the synthetic-to-real shift lands mostly on these thresholds. A small **real development set**, separate from the real test set and annotated the same way, serves only to set operating points. The test set stays untouched.

## Precision guardrail

98% recall by hiding everything is worthless: the agent can no longer read the code it works on. At every operating point:

- false alarms are counted per trap type, code identifiers and libraries first, and per 1,000 lines of code;
- the product's benchmark (`python -m benchmark --spaced`) must not lose recall or precision when the model replaces DistilCamemBERT;
- the RL reward's false-alarm term is checked against those counts, to catch a model that learned to game it.

## Test sets

| Set | Content | Use |
| --- | --- | --- |
| Validation | synthetic, split by seed | hyperparameters, ablations |
| Calibration | synthetic, about 10% of seeds | training the self-evaluation head |
| Evaluation batches | fresh synthetic templates per iteration | error loop |
| Real development set | real documents, hand annotated | operating points only |
| Real test set | real documents, hand annotated | evaluated once, at the end, with every seed |
| Public benchmarks | SPY, ai4privacy test splits, PIIMB, PIIBench, the product's French corpora | situating the model outside its own ground |

The real sets are annotated by hand with the benchmark markup `⟪category:value⟫`, which the product's `benchmark/annotation.py` reads, without any model pre-annotation, so annotators are not swayed by a model's errors. Every real value is replaced by a synthetic value of the same format (names by rare, compound or particle names of varied origins, keys by keys of the same format), keeping the layout around it intact. They live under `data/real/`, which Git ignores, and are never opened in an agent session. Synthetic templates never count as real data.

## Comparing with the best public models

- Every model runs on the same sets with the same scorer. The mapping between each competitor's labels and our categories is published, and entities a competitor cannot detect by design are reported separately rather than counted as hidden errors.
- Two comparisons: each model at its default operating point (recall, F2), and at **matched recall**: precision at 98% protection recall, for models that expose a threshold or presets. The second is the fair one for a recall-first product.
- Paired bootstrap confidence intervals; three seeds for our model.
- Competitors: DistilCamemBERT NER (in production today), Masker Mini, Nym small, GLiNER2-PII, OpenAI Privacy Filter, NVIDIA's GLiNER PII, Knowledgator's GLiNER PII models, PII Engineer Multi NER v2.1, the mmBERT-base CRF model published on Hugging Face, Presidio and spaCy.
- Efficiency: size on disk, parameters, median and 95th-percentile latency on a standard laptop CPU, tokens per second.

The final claim is published only with the model, its card, the evaluation script and, if possible, the technical benchmark itself, so anyone can verify it.
