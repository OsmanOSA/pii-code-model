# Data pipeline

Data decides the model's quality. A model built on the same base as this one, Nym small, scored 67.6 exact F1 (60.2% recall) on person names in Agent Privacy Guard's comparison of 5 October 2026, on a WikiNER-fr-gold sample, against 95.3 for the DistilCamemBERT model in production (which saw WikiNER in training, so its score is flattering). The base is not enough: data and training recipe make the difference.

The training set mixes three sources: synthetic templates (the core), programmatic transforms of those templates, and a minority of public datasets for natural text.

Real documents annotated by hand never enter training. A few hundred documents would barely weigh against 200,000 examples, and they are the only honest measure of real use ([recall target](recall-target.md#test-sets)).

## Record format

Every example is one JSONL line. Character offsets are the reference; conversion to token labels happens last, in a single script, so the model or tokenizer can change without regenerating data.

```json
{
  "id": "config-fr-01/014~t3~f07",
  "seed_id": "config-fr-01/014",
  "template_id": "config-fr-01/014~t3",
  "text": "…",
  "entities": [{"start": 57, "end": 71, "category": "name", "kind": "person_name"}],
  "traps": [{"start": 210, "end": 241, "type": "placeholder"}],
  "visible": [{"start": 300, "end": 336, "kind": "uuid"}],
  "language": "fr",
  "fill_locale": "fr_FR",
  "family": "config",
  "format": ".env",
  "domain": "healthcare",
  "appearance": ["comment", "assignment", "url"],
  "split": "train",
  "source": "synthetic"
}
```

`seed_id` identifies the template the frontier model wrote; every transform and every fill of it shares that id, and splits are made on it. Recorded traps and visible values make false alarms measurable per trap type.

Template syntax (`⟬kind#n⟭`, variants, visible tags, traps) is defined once, in [the generation prompt](../prompts/template-generation.md#tag-syntax).

## Coverage matrix

Written before any generation, with a target per cell. The shares are a starting point, adjusted after the first error analysis.

| Family | Formats | Share | Seed templates, first round |
| --- | --- | --- | --- |
| code | .py, .js, .ts, .sql, .java, notebooks | 32% | 750 |
| config | .env, .yaml, .json, .toml, docker-compose, .ini | 19% | 450 |
| logs | application logs, stack traces, test output, server logs | 19% | 450 |
| tabular | .csv, .tsv, spreadsheets as text, SQL dumps | 12% | 280 |
| docs | .md, .txt, README, tickets, emails, commit messages | 11% | 260 |
| natural | LinkedIn messages, chats, SMS, informal emails, forum posts; public datasets on top | 8% | 190 |

A cell is one family in one language; a session writes one cell, and a cell above 250 templates is split into sessions (`code-fr-01`, `code-fr-02`). The first round is 20 sessions, listed with their formats, domains and kinds to cover in [templates/plan.yaml](../templates/plan.yaml); [templates/progress.yaml](../templates/progress.yaml), rewritten by `python -m datagen progress`, records how many templates each cell has generated and validated and the prompt version of each batch, so generation can stop and resume at any batch.

About a quarter of each cell's templates hold no entity at all: `pii_free_templates` gives the count per cell, progress counts it, sessions write some in every batch, and a cell is done only when both of its targets are met. Without this count every session would write files full of entities, and the model would learn that every file holds some.

Natural text is generated, not only taken from public datasets: the real test set holds informal messages, and a model that only met them in public corpora would be measured on a kind of text it barely saw in training.

Every category appears in at least 300 seed templates and every entity kind in at least 40. The pre-training report checks this.

## Volume

Diversity of templates matters more than volume. The first round keeps few fills per template, and later rounds add seeds rather than fills:

| Step | Count |
| --- | --- |
| Seed templates written by the frontier model | about 2,400 |
| × programmatic transforms (about 4 per seed) | about 9,600 templates |
| × fills (3 to 8 per template, about 5 on average) | about 48,000 examples |
| + public datasets (10 to 20% of the mix) | about 55,000 examples |

Volume grows with new seeds, and only while the validation score still rises when the data doubles. Generating many fills from the same seeds adds no new context: the number of seeds is the real budget.

## Generation

The frontier model writes seeds, one session per cell, with [template-generation.md](../prompts/template-generation.md). From the second iteration, the error reports choose the cells ([error-driven-generation.md](../prompts/error-driven-generation.md)).

**Briefs.** The cells with `briefs: true` in the plan do not leave their subject to the writing model, which otherwise turns every template into a full record about personal data. `python -m datagen briefs` draws one brief per template from [templates/sampling.yaml](../templates/sampling.yaml) into `templates/briefs/`: situation, format, domain, entity kinds, why the data is there, where it sits, whether a word announces it, and length. Most templates hold one to three kinds, about 12% hold a full record (four kinds or more on one person), and the data is accessory in most of the rest. There is no minimum per kind in these cells: a kind appears where the format and the situation make it plausible. The checker refuses a template that departs from its brief.

The template checker runs on every batch:

- tags are well formed, use a known kind, variant or trap type, and their numbering is consistent;
- no `⟦…⟧` or `⟪…⟫` sequence;
- the file still parses after a test fill (Python, JSON, YAML, TOML, CSV, SQL where a parser exists);
- no literal value matched by the product's rules outside tags (a cheap first alarm for hard-coded personal data);
- near-duplicates (MinHash on the text with each tag reduced to its kind) are dropped, within the batch, across cells and against all evaluation templates. Templates are compared with each other, never fills, and the transforms of one seed are not compared with each other: they are alike by design.

## Filling

A local script replaces each tag with a value and records its position.

**Names.** French given names from the INSEE file, drawn for the person's sex and birth period, so a girl born in 2008 is not called Paulette; US given names from the Social Security Administration in the same way; US family names from the Census Bureau. Draws follow the square root of each name's frequency, plus 5% uniform over the list: raw frequencies let a few names eclipse the others (Jean took 1.7% of French draws and 171 names half of them; the square root brings Jean to 0.4% and half of the draws to 738 names), while common names stay more frequent than rare ones. French and UK family names, and UK given names, come from Faker until an openly licensed frequency list is found (ONS publishes given names only). A deliberate share of double-barrelled names, particles (de, van, d'), apostrophes (O'Neil) and names of every origin present in those files. Order and casing follow each country's files: `FAMILY Given` and `Family Given` in French files only, middle initials and `Jr.` in American ones. The death records file is not used: it ties names to identifiable real people. In training fills, 4% of given names and of family names are invented pronounceable words that look like no known name: the model then has only the context to find the person.

**Places.** Postcode, city and US state come from one GeoNames entry, so they always match; arrondissements, CEDEX codes and military post offices are left out because they never appear in a person's address. Street lines join a random house number to common street names of each country (rue de la Gare, Oak St, Station Road): Faker's streets and cities, built from person names, blur the very difference the model must learn.

**Names in traps.** A trap built on a person's name writes `⦃given⦄` or `⦃family⦄` where the name goes (`format⦃Family⦄Ref`, `⦃Family⦄ Plomberie`), and the filler draws it from the same lists as the names of people. The same name is then a person in one example and a function, a company or a product in another, so the list alone never decides: the context does. A placeholder keeps one value in a fill, so a class and its instance agree.

**Context.** Every fill has an anchor day, its "today". Ordinary dates fall in the months before it, `⟬date#1⟭` the most recent and a higher number never later; birth dates and ages count from it, within the ages the template's domain allows (pupils, employees, adults). Code holds ISO dates. A sex marker on a tag (`⟬person_name#1f⟭`) fixes the record's sex where the text does (Mme, née); the given name and the identifiers that encode sex follow it. Values of one record agree with each other: a Stripe secret key and its publishable key share their mode, a card and its security code their brand. Role mailboxes follow the record's language and the template's trade, and `cus_` customer ids appear only where Stripe is plausible.

**Derived values.** Emails and handles derive from person `n` in several formats (given.family, g.family, family_given42, nickname). Public mail providers are used only with a random numeric suffix in the local part, so a collision with a real mailbox stays unlikely; otherwise invented company domains and reserved domains (RFC 2606).

**Values with check digits.** Social security number, tax number, SIREN, SIRET, IBAN (every country's length and format) and cards (Luhn, brand prefixes) are generated valid and verified with the product's `core/validators.py` where it has a validator. About 5% are generated with a wrong check digit, because a typo is still annotated: the model must not learn that only valid numbers matter.

**Secrets.** One generator per format, with the right prefix, length and alphabet. Passwords mix human ones (word, year, symbol), generated ones and passphrases. Private keys are PEM blocks with a random body of realistic length.

**Formatting.** Phones with and without country code, spaces, dots or dashes; IBAN and cards grouped by four or not; dates in each locale's formats; upper and lower case where the field allows it.

**Escaping.** The filler escapes each value for the quoting around its tag: doubled apostrophes inside single quotes in SQL, escaped quotes and backslashes inside JSON, Python and JavaScript strings. The entity span covers the value as it appears in the text. The checker re-parses every filled file, and a template whose fills fail to parse is fixed or dropped.

**Fill count.** 3 to 8 fills per template in the first round, about 5 on average and more when the template holds more tags, so the model learns contexts rather than values.

Value sources and their licenses, fetched by `python -m datagen.sources fetch` and turned into tables by `python -m datagen.sources build`:

| Source | License | Use |
| --- | --- | --- |
| [INSEE, fichier des prénoms](https://www.insee.fr/fr/statistiques/8894961) (2024 edition) | Licence Ouverte 2.0 | French given names by sex and year |
| [SSA baby names](https://www.ssa.gov/oact/babynames/limits.html) | US public domain | US given names by sex and year; the site blocks scripts, so `names.zip` is saved by hand under `data/sources/raw/ssa_names/` |
| [US Census 2010 surnames](https://www.census.gov/topics/population/genealogy/data/2010_surnames.html) | US public domain | US family names |
| [GeoNames postal codes](https://download.geonames.org/export/zip/) (FR, US, GB_full) | CC BY 4.0, attribution required in the model card | postcode, city and state |
| Faker | MIT | French and UK family names, UK given names, companies, job titles; every value when tables are missing, as in tests |

Downloads live under `data/sources/`, which Git ignores; the scripts that fetch and build them are versioned.

## Transforms

Programmatic changes multiply each seed while keeping its tags: renaming variables, keys and column headers from synonym lists (French and English, abbreviated, meaningless); reordering fields, columns and JSON keys; changing indentation, quote style and CSV delimiter; inserting noise lines (unrelated code, log or table rows); cutting a log to its tail or a file to an excerpt without cutting a tag. Each transform is re-checked like a seed. Transforms of a seed share its `seed_id`.

## Public datasets

| Dataset | License | Use |
| --- | --- | --- |
| [Nemotron-PII](https://huggingface.co/datasets/nvidia/Nemotron-PII) (NVIDIA) | CC BY 4.0, per its card | English candidate replacing CoNLL-2003; synthetic, persona-grounded documents |
| ai4privacy | differs by version | each version checked separately before use |
| WikiNER French, minus WikiNER-fr-gold sentences | to be checked | French natural text |
| CoNLL-2003 | research use under signed agreement | excluded |

Public datasets stay at 10 to 20% of the mix. Their value is text written by people and by other generators: names in natural sentences, and a counterweight to the style of a single frontier model. Several PII datasets are synthetic themselves (Nemotron-PII, ai4privacy), so they add diversity, not realism. No French PII dataset under a compatible license is identified yet; French natural text comes from WikiNER minus the gold sentences.

Each dataset gets a mapping table, like the product's PIIMB scope (`benchmark/piimb/scope.py`), and every one of its labels takes one of three outcomes. Mapping everything outside our scope to `O` would be wrong: it would teach the model to leave visible what our guide hides.

| Outcome | When | Examples |
| --- | --- | --- |
| our category | the label means the same thing | PERSON → `name`, EMAIL → `email`, IBAN → `banking`, PASSWORD → `secret`, date of birth → `birth_date` |
| `O` | the label only covers what stays visible by design | city, company, job title, IP address |
| ignored in the loss | the label may or may not hold one of our entities, depending on context | username (`jean.dupont` is a `name`), a generic date (a birth date or not), URL (may hold a password), a generic ID or account number |

A category the dataset does not annotate at all (emails, phones or secrets in WikiNER, for instance): the product's rules for that category run over the text, and the tokens they match are ignored in the loss. The synthetic data alone teaches those categories; a public dataset must never contradict it.

Every training sentence is deduplicated by hash against every evaluation corpus: WikiNER-fr-gold, FENEC, Sequoia, Europeana, SPY, PIIMB and the test splits of ai4privacy. WikiNER-fr-gold stays an evaluation corpus only.

## Splits

- Training and validation are split by `seed_id`, stratified by cell: no variant of a seed lands on both sides. About 5% of seeds go to validation, chosen by a stable hash (`datagen/splits.py`), and every example records its `split`.
- Values are split too: 10% of given names, family names, communes and street names are held out and appear only in validation fills. Validation then measures two things a list cannot give: names and places never seen in training, and, with a batch of evaluation templates dense in ambiguous words (given names that are also nouns, products or places, labelled by context), whether the context outweighs the list.
- Each iteration of the error loop evaluates on a fresh batch of evaluation templates, written in a separate session, never trained on, deduplicated against training.
- The real test set is never generated, never in Git and never looked at during development ([recall target](recall-target.md#test-sets)).

French and English are trained together, close to half and half in tokens, with scores tracked per language to correct a language that falls behind.

## Quality control

1. **Automatic checks on every example.** Each span holds exactly the value it claims; entities do not overlap; the file parses.
2. **Hunt for missed entities.** The product's rules and an existing model run over a sample of filled examples; anything they flag outside annotations is reviewed. The model is an alarm, never an annotator. A fix goes into the template, which repairs every example derived from it.
3. **Manual review** of 200 to 300 random filled examples across all formats, outside the agent (the Privacy Guard hook masks filled data in the agent's view). A batch is accepted when its error rate stays under 1 to 2%.

## Against memorizing structures

The model must not learn that everything after `user=`, `Bonjour` or `Author:` is personal data.

1. At most 20 fills per template.
2. Programmatic transforms of names, order, formatting and surrounding words.
3. Broken links between signal and entity: entities with no announcing word, announcing words followed by non-personal values (both required by the generation prompt).
4. A check through the split: a score that collapses on unseen seeds reveals memorization.

## Pre-training report

Generated before every run: distribution per family, format, language, category, kind and appearance mode; entities per example; text length in tokens; share of examples without entities; traps per type. A run does not start while a category or kind is under its minimum.

## Publishing

Templates are committed; filled datasets are not. A filled dataset holds realistic-looking keys and tokens: publishing it will trigger secret scanners (GitHub push protection, Hugging Face), and checksummed formats such as GitHub tokens look valid to them. Before publishing data or a model trained on it, check the frontier model provider's terms on training models from its outputs, and the license of every public dataset in the mix.
