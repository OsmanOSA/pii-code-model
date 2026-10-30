# PII code model

Training, evaluation and release of a small French and English model that finds personal data and secrets in what coding agents read. First consumer: [Agent Privacy Guard](https://github.com/OsmanOSA/agent-privacy-guard), whose background service it will serve. This repository is public: everything committed here is published.

Read first: [README.md](README.md), [docs/labels.md](docs/labels.md) (the label contract) and [docs/roadmap.md](docs/roadmap.md) (current step).

## Data rules

- Only synthetic data in Git. Templates hold tags, never a literal personal value, never a real key.
- Downloads (INSEE, SSA, Census, ONS, public corpora), filled datasets, the real annotated sets and checkpoints live under `data/` and `runs/`, which Git ignores.
- The real development and test sets are never opened in an agent session and never used for training. The test set is evaluated once, at the end.
- Public benchmarks (SPY, PIIMB, ai4privacy test splits) are a final check only: never trained on, never used to choose labels, data or settings. Their files stay under `data/eval/`.
- Templates are written with the prompts in [prompts/](prompts/), one session per cell of the coverage matrix.
- The label policy follows Agent Privacy Guard: a change lands in the product first, then in `docs/labels.md` and `schema/labels.json`, then in the data.

## Privacy Guard hook

When the hook is installed, it masks personal data the agent reads: filled examples then appear masked and are reviewed outside the agent, and a template read back may show a `⟦…⟧` token where the hook masked a trap word. Never write such a token into a template; regenerate the template instead. Without the hook, the agent may read filled synthetic examples, never the real sets.

## Code standard

- Everything in English: code, comments, docs, messages.
- One function = one task. Modules under 200 lines, split at the second responsibility.
- Every module opens with a docstring giving its role and interface. Comments explain the why.
- Run Python with the project's virtual environment: `.venv/Scripts/python.exe -m datagen ...` (the global interpreter lacks the pinned packages).
- Training code may use third-party packages, pinned in requirements files. The exported model must run with numpy, onnxruntime and tokenizers only, as the product's service requires.
- Use synthetic fixtures only in tests.

## Evaluation

- Scores are entity-level. Recall claims are per category, with a confidence bound ([docs/recall-target.md](docs/recall-target.md)).
- Every addition to the supervised baseline is an ablation over three seeds ([keep rule](docs/model.md#keep-rule)).
- A target is never written as a measured number.

## Git

No remote, push or publication (GitHub, Hugging Face) unless the maintainer asks for it.
