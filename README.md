# PII code model

A small French and English model that finds personal data and secrets in what AI coding agents read: source code, logs, configuration files, tables, commit messages, tickets and plain text. It is built to run on a laptop CPU inside [Agent Privacy Guard](https://github.com/OsmanOSA/agent-privacy-guard), which pseudonymizes or deletes what it finds before the agent's model sees it.

**Status: design.** Nothing is trained or measured yet. Every number in this repository is a target or an estimate, never a result.

## What it detects

Eight categories, the ones Agent Privacy Guard knows how to treat: `name`, `email`, `phone`, `address`, `birth_date`, `identifier`, `banking` and `secret`. IP addresses, usernames, ordinary dates, cities, companies and technical identifiers stay visible by design, because the agent needs them to work. See [the labels and annotation guide](docs/labels.md).

## How it is built

- **Base**: [mmBERT-small](https://arxiv.org/abs/2509.06888), a multilingual encoder on the ModernBERT architecture, with a reduced vocabulary to fit under 150 MB once quantized. [Why this base](docs/model.md#base-model-mmbert-small).
- **Data**: realistic templates written by a frontier model with tags in place of sensitive values, filled by a script. Labels are exact by construction. Traps (libraries, eponyms, code identifiers, placeholders) are woven into the same files. [Data pipeline](docs/data-pipeline.md).
- **Training**: supervised fine-tuning, then reinforcement fine-tuning on a verifiable masking reward (GRPO-style group baseline), an error-driven generation loop and a self-evaluation head. Each addition is kept only if it beats the supervised model. [Model and training](docs/model.md).
- **Evaluation**: protection recall per category with confidence bounds, on hand-annotated real documents that never enter the repository. [Recall target](docs/recall-target.md).

## Repository layout

| Path | Content |
| --- | --- |
| [schema/labels.json](schema/labels.json) | categories, kinds, visible kinds and trap types, mirrored from Agent Privacy Guard |
| [docs/](docs/) | labels, data pipeline, model, recall target, [roadmap](docs/roadmap.md) |
| [prompts/](prompts/) | the template generation prompts |
| [templates/](templates/) | generated templates, tags only (committed) |
| [datagen/](datagen/) | data pipeline: template checker, filler, review page |
| [tests/](tests/) | tests, on synthetic fixtures only |
| `data/` | downloads, filled datasets, real annotated sets (never committed) |
| `runs/` | checkpoints and training logs (never committed) |

## Data pipeline

```bash
python -m venv .venv && .venv/Scripts/python -m pip install -r requirements-dev.txt
python -m datagen.sources fetch && python -m datagen.sources build   # real names and places, under data/sources/
python -m datagen progress                            # generated and validated templates per cell of templates/plan.yaml
python -m datagen check templates/raw/pilot-01        # tags, header, test fills that must still parse, near-duplicates, coverage
python -m datagen fill templates/raw/pilot-01 --out data/pilot-01 --fills 3
python -m pytest
```

`fill` writes `filled.jsonl` (the record format of the [data pipeline](docs/data-pipeline.md#record-format)) and `review.html` under `data/`. Open the page in a browser: in an agent session the Privacy Guard hook masks filled values, so review happens outside it.

## Principles

- Only synthetic data in Git. Real documents used for evaluation stay on the maintainer's machine.
- The label policy follows the product: a change lands in Agent Privacy Guard first, then here.
- Recall claims are per category, with the lower bound of their confidence interval.

## License

Code under the [MIT license](LICENSE). Model weights will also carry the notices of the base model and of the datasets used to train them.
