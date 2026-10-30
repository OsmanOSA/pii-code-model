# Template generation prompt

Version: 5 (2026-10-30)

Used in one Claude Code session per cell of [templates/plan.yaml](../templates/plan.yaml), opened in this repository. Start the session with: `Generate cell <cell_id> following prompts/template-generation.md.` From the second iteration on, use [error-driven-generation.md](error-driven-generation.md) instead, which reuses this prompt.

Operator notes, not part of the prompt:

- One session works on one cell, in batches of 20 templates, and may stop after any batch. [templates/progress.yaml](../templates/progress.yaml), written by `python -m datagen progress`, shows how far each cell is and which batch comes next; a new session resumes there.
- Bump the version line above whenever the text changes: progress records the version (and a hash of this file) for every batch. Version 1 wrote the pilot (`templates/raw/pilot-01`); version 2 added the sex marker, the date order, the `natural` family, and the plan and progress files; version 3 turned the share of entity-free templates into a count per cell that progress tracks; version 4 added names inside traps (`⦃given⦄`, `⦃family⦄`), the same words on both sides, and the rule that every street address is tagged whoever it belongs to; version 5 replaced model-chosen scenarios with drawn briefs, removed the minimum per kind and cut the examples down to syntax fragments.
- When the Privacy Guard hook is installed, it masks filled values and some trap words in the agent's view: review filled data outside the agent, and regenerate a template read back with a `⟦…⟧` token rather than editing the token.

---

## Your task

You write **templates** for training a small model that finds personal data and secrets in what AI coding agents read: source code, logs, configuration, tables, commits, tickets and plain text, in French and English. A template is a realistic file in which every sensitive value is replaced by a **tag**. A script later fills each tag with a synthetic value and records its exact position. The labels are therefore exact by construction: the quality of the model depends entirely on how realistic, varied and correctly tagged your templates are.

A value you write literally instead of tagging teaches the model to leave that kind of value visible: it becomes a leak in production. A thing you tag that is not sensitive teaches the model to hide useful code. Both errors matter; the first is worse.

## What the model must find

| Category | Tag it when you write | Kinds |
| --- | --- | --- |
| `name` | any person's given, family or full name, public figures included | `person_name` |
| `email` | any email address, generic ones included (support@, noreply@) | `email` |
| `phone` | any phone number, switchboards included | `phone` |
| `address` | a street line with number, plus postcode and city when they follow, whoever it belongs to (a person, a company, a depot) | `fr_postal_address` (France), `postal_address` (US, UK) |
| `birth_date` | a date the context marks as a date of birth | `birth_date` |
| `identifier` | identity and administrative numbers | `fr_social_security_number`, `fr_tax_number`, `fr_identity_card`, `fr_passport`, `fr_driving_licence`, `fr_license_plate`, `fr_siren`, `fr_siret`, `us_ssn`, `us_itin`, `us_passport`, `us_driver_license`, `us_license_plate`, `uk_national_insurance_number`, `uk_passport`, `uk_driving_licence`, `uk_license_plate` |
| `banking` | IBAN, card number, card security code, bank account number | `iban`, `payment_card`, `card_security_code`, `bank_account_number` |
| `secret` | keys, tokens, passwords, private keys, the password inside a URL | `private_key`, `url_password`, `stripe_secret_key`, `anthropic_api_key`, `openai_api_key`, `aws_access_key_id`, `aws_secret_access_key`, `github_token`, `gitlab_token`, `slack_token`, `google_api_key`, `huggingface_token`, `npm_token`, `sendgrid_api_key`, `jwt`, `password`, `opaque_token` |

`opaque_token` is a high-entropy secret with no recognizable prefix. Use it often: these are the secrets regex rules miss.

## What stays visible

The agent needs these to work. Never tag them as entities. When you want a realistic, varied value for one of them, use a **visible tag**; otherwise write it literally.

Visible kinds: `city`, `postcode`, `country`, `company`, `job_title`, `date`, `age`, `uuid`, `hash`, `git_sha`, `order_number`, `invoice_number`, `customer_id`, `ticket_id`, `version`, `ip_address`, `hostname`, `url`, `file_path`, `username`, `bic`, `stripe_publishable_key`, `ssh_public_key`.

`username` produces handles that contain no name (`svc-backup`, `dragonfly42`, `admin`). A handle built from a person's name is a `person_name:handle` entity instead.

## Tag syntax

- Entity tag: `⟬kind#n⟭`, for example `⟬person_name#1⟭`, `⟬iban#2⟭`.
- Variant: `⟬kind:variant#n⟭`.
  - `person_name:given`, `person_name:family`: one part of person n's name.
  - `person_name:initial`: initial and family name (`J. Dupont` style).
  - `person_name:handle`: a handle or path segment with separated parts (`j_dupont`, `jean.dupont`, `jean-dupont`).
  - `email:generic`: a role mailbox (support@, noreply@, rh@) on a fictional domain.
  - `fr_postal_address:street`, `postal_address:street`: the street line only, for tables that split the address into columns.
  - `fr_postal_address:multiline`, `postal_address:multiline`: a letter-style address over several lines, for prose formats only.
- Visible tag: `⟬visible_kind#n⟭`, for example `⟬uuid#1⟭`, `⟬city#1⟭`.
- Trap: `⟬trap:type|literal text⟭`, for example `⟬trap:library|Jackson⟭`. You write the text; the script keeps it unlabelled and records it to measure false alarms. Types:
  - `word_name`: a given name used as a word or place (Pierre the stone, Rose the colour, Paris the city).
  - `eponym`: a name used for a thing (Dijkstra's algorithm, Gauss, Levenshtein distance).
  - `library`: a library, framework or tool carrying a name (Jackson, Flask, Pandas, Sphinx, Jinja).
  - `code_identifier`: a code identifier containing a name (`get_dupont_score`, `class Martin`).
  - `company_name`: a company named after a family (Peugeot, Dupont Plomberie).
  - `initials`: initials alone (JD, J.-P.).
  - `email_lookalike`: email-shaped text that is not an email (`@app.route`, `@types/node`, `$USER@host`).
  - `indicator_non_pii`: a value after a word that usually announces personal data or a secret (`user=admin`, `TOKEN_TTL=3600`, `Bonjour à tous`, `Author: dependabot[bot]`).
  - `placeholder`: a stand-in for a secret (`${DB_PASSWORD}`, `<password>`, `xxxx`, `***`, `%(password)s`).
- Names inside traps: when a trap is built on a person's name (a code identifier, a company, a product or tool named after someone), write `⦃given⦄` or `⦃family⦄` where the name goes, and the script draws it from the same lists as the names of people: `⟬trap:code_identifier|format⦃Family⦄Ref⟭`, `⟬trap:code_identifier|get_⦃family⦄_score⟭`, `⟬trap:company_name|⦃Family⦄ Plomberie⟭`, `⟬trap:eponym|the ⦃Given⦄ chatbot⟭`. The case you write is kept (`⦃Family⦄`, `⦃family⦄`, `⦃FAMILY⦄`); in a code identifier the name loses accents and spaces. One placeholder gives one name in the whole template, so repeat it to repeat the name, and number it for a second name (`⦃family2⦄`). Keep literal text for names that matter as such: real libraries, eponyms and word names (Jackson, Dijkstra, Rose).

The number `n` links values within one template:

- The same tag repeated gives the same value: write `⟬person_name#1⟭` twice and the same name appears twice, as in real files.
- Tags with the same `n` describe the same fictional record: `⟬email#1⟭` and `⟬person_name:handle#1⟭` are derived from `⟬person_name#1⟭`; `⟬city#1⟭` and `⟬postcode#1⟭` match `⟬fr_postal_address:street#1⟭`.
- A different person or record takes a different `n`.
- When the text fixes a person's grammatical gender (Mme, Mr, née, la patiente, she), add `f` or `m` after the number of one of that person's tags: `Mme ⟬person_name#1f⟭`. The given name and the identifiers of record 1 follow it.
- Ordinary dates follow their number: `⟬date#1⟭` is the most recent date of the file and a higher number is never later. Number dates in the order the text needs, for example the email before the accident it reports.

One value is one tag. Never build an email, handle or address out of several tags, and never put a tag inside a code identifier.

## Rules you never break

1. **Every sensitive value is a tag.** Check comments, docstrings, example calls (`send_mail("…")`), sample output, test fixtures, commit trailers, file names, URLs and log lines. A placeholder person such as "John Doe" or "Jean Dupont" is still a person: tag it. A famous person mentioned as a person (an author in a citation, a quoted executive) is tagged; the same name used for a thing (an algorithm, a library, a unit) is a trap.
2. **Never write a real value.** No real person's contact details, no real key, no real company's internal hostname or credentials. Fictional values come from the filling script, not from you.
3. **Never write `⟦…⟧` or `⟪…⟫`.** The first is the product's token format, the second the benchmark's markup.
4. **The file stays valid after filling.** Put tags inside the quotes the format needs; the script escapes values for that quoting. In CSV, quote every cell that holds a full name or an address, since those values can contain commas. Keep JSON, YAML, TOML, Python, JavaScript and SQL parseable.
5. **Tag what the guide says, not more.** A city alone, a company, a job title, an ordinary date, an age, a UUID, an IP address, an order number: visible. A date of birth needs its context in the text (`date_naissance`, `dob`, "born on", "né le").

## Your cell

The operator names a cell. Read its entry in `templates/plan.yaml`:

```
cell_id:          <family>-<language>-<nn>, for example config-fr-01
family:           code | config | logs | tabular | docs | natural
formats:          file or message types to cover
language:         fr | en | mixed
fill_locale:      fr_FR | en_US | en_GB | mixed
domains:          domains to spread the templates over
templates:        number of validated templates the cell needs
pii_free_templates: how many of those templates hold no entity tag at all, about a quarter
briefs:           true: every template follows a brief drawn by the script
focus:            what this cell must stress
```

Then run `python -m datagen progress`, which names the next batch, and `python -m datagen briefs <cell_id> --batch <n>`, which prints the briefs of that batch.

`language: mixed` means what real projects look like: English code and comments with French customer data, a French ticket quoting an English stack trace, a CSV with English headers and French values.

`family: natural` means what people write to each other rather than files: LinkedIn messages, chat messages, SMS, informal emails, forum posts. The tone is informal, with typos, abbreviations and emojis; names, numbers and addresses are dropped mid-sentence, often with no announcing word. Use the format header for the message type (`format: LinkedIn message`).

## Your briefs

The script chooses what each template is about; you write it. Each slot of a batch has one brief, in order: the first template of `batch-001.tpl` follows brief 1, the first of `batch-002.tpl` brief 21. Never swap, skip or reinterpret a brief. Its fields:

- `situation`: what the text is about. Copy it word for word into the `scenario:` header.
- `format`, `domain`: copy them into the header.
- `kinds`: the exact entity kinds of the template, no more and no fewer. An empty list means no entity tag at all. Visible tags and traps stay free.
- `full_record`: true means one person carries at least four of the kinds, all with the same `n`.
- `data_role`: `accessory` means the text is about the situation and the data only passes through it, so that removing the data would not change the subject. `central` means the text exists because of the data.
- `reason`: why the data is there. Make it visible in the text, without stating it.
- `position`: where the data sits. When the format has no such place, take the nearest one.
- `indicator`: `absent` means no announcing word near the value (no `tel`, `mail`, `IBAN`, `né le`, `Bonjour`). `present` means one is there. With no kinds, `present` means an announcing word followed by a harmless value, marked as an `indicator_non_pii` trap. A birth date always needs its context: with `absent`, that context sits further away in the text, never right next to the date.
- `length`, `lines`: the number of lines the template must have. In `family: natural`, a long text is a thread of several messages.

The checker refuses a template whose format, domain, scenario, kinds, line count or full record differ from its brief.

## Diversity

Diversity of contexts is what the model learns from; volume comes later from the filling script. The brief fixes the subject, so vary everything it leaves free:

- **No shared skeleton.** No two templates with the same structure, opening lines, variable names or column order.
- **Vary how each value appears.** Plain prose, assignment, string literal, comment, docstring, URL or query string, file path, nested JSON, YAML value, CSV cell, SQL `INSERT` or `WHERE`, log field, exception message, HTTP header, curl command, commit trailer (`Signed-off-by`, `Co-authored-by`), test fixture or factory, Markdown table, email signature.
- **Vary keys and headers.** snake_case, camelCase, UPPER_CASE, French and English, abbreviations (`nom`, `prenom`, `tel`, `mail`, `adr`, `dob`, `nir`, `iban_client`, `cc`, `pwd`, `creds`), and headers that name nothing (`col3`, `field_b`, `value`).
- **Vary quality.** Production code, a quick prototype, legacy code, generated code, inconsistent spacing, typos in comments and logs, half-commented lines.
- **Vary the person's place.** Author, customer, patient, employee, on-call engineer, test user, signatory, recipient of an email.

## Breaking shortcuts

The model must not learn that whatever follows `user=`, `Bonjour` or `Author:` is personal data, nor that personal data always comes after such a word.

- When the brief says `indicator: absent`, put entities with no announcing word nearby: a CSV without header, a name in the middle of a sentence, an email inside a stack trace, a key pasted alone in a log line or a curl command, a secret under an innocuous key (`X-Client-Ref`, `sig`, `k`).
- In about 30% of templates, put announcing words followed by values that are not personal data, marked as `indicator_non_pii` traps: `user=admin`, `owner: platform-team`, `PASSWORD_MIN_LENGTH=12`, `api_key_header="X-Api-Key"`, `Bonjour à tous`, `Author: dependabot[bot]`, `dob_format="%Y-%m-%d"`.
- Put ordinary dates (`⟬date#n⟭`) next to birth dates, and cities or postcodes alone next to full addresses, so the model learns the difference from context.
- Place traps where real ones occur: libraries in imports and requirements files, eponyms in comments and docstrings, code identifiers in signatures and calls, word names in product descriptions and prose.
- Put the same words on both sides, so that only the context tells them apart: names inside traps come from `⦃given⦄` and `⦃family⦄`, drawn from the lists that fill the people; a word that is also a given name (Margaux, Rose, Pierre) is a person in one template and a wine, a colour or a stone in another.
- A street named without a number is a place, not an address (`on se retrouve rue Victor Hugo`): when it carries a person's name, mark it as a `word_name` trap. A street named after a date (rue du 8 Mai 1945) is part of an address when a number precedes it, and a place otherwise.

Templates without entity tags (`pii_free_templates`) are full, realistic files with visible tags and traps. They are not shorter or simpler than the others: a configuration with only placeholders, a log of a health check, a README of a library, a chat about a deployment. They teach the model when to hide nothing.

## Output

Write each batch of 20 templates to `templates/raw/<cell_id>/batch-<nnn>.tpl`. A file holds one or more templates in this form:

```
⟬template⟭
family: config
format: .env
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: comment, assignment, url
scenario: one sentence: who wrote this file, and why
⟬text⟭
…the file, verbatim, with tags…
⟬end⟭
```

The lines `⟬template⟭`, `⟬text⟭` and `⟬end⟭` stand alone. Everything between `⟬text⟭` and `⟬end⟭` is kept verbatim, including blank lines and indentation.

After writing each batch, run `python -m datagen check templates/raw/<cell_id>` and fix every failure, near-duplicates included. Then run `python -m datagen progress`, which records the batch and this prompt's version in `templates/progress.yaml`. Report, in two lines, the running counts of kinds per template and of empty templates. Stop when the cell reaches both of its targets, validated templates and templates without entities, or when the operator says so.

## Check each template before writing it

1. Read it line by line, as if it were a real file you were asked to anonymize. Is any name, email, phone, address, birth date, identifier, banking value or secret still literal? Look in comments, examples, file names, URLs and commit trailers.
2. Is every tag well formed, with a known kind or trap type and a consistent `n` (one person, one `n`; `email#1` belongs to `person_name#1`)?
3. Are eponyms, libraries, code identifiers, companies and initials written as traps, not as entities?
4. Would the file still parse after filling: quotes, commas in CSV, brackets in JSON, indentation in YAML and Python?
5. Do the header fields match the text and the brief (language, format, domain, scenario, appearance)?
6. Does the text show the brief's reason, position and indicator, and is it about the situation when the data is accessory?

## Tag syntax fragments

These show the syntax only.

```
# Contact : ⟬person_name#1⟭ (⟬email#1⟭, ⟬phone#1⟭)
DATABASE_URL=postgresql://app:⟬url_password#1⟭@⟬hostname#1⟭:5432/main
SMTP_PASS=⟬trap:placeholder|${SMTP_PASSWORD}⟭
SESSION_TOKEN_TTL=⟬trap:indicator_non_pii|900⟭
```

```
"full_name": "⟬person_name#2⟭",
"billing": {"line1": "⟬postal_address:street#2⟭", "city": "⟬city#2⟭"},
"payout_iban": "⟬iban#2⟭",
```

```
Mme ⟬person_name#3f⟭, née le ⟬birth_date#3⟭, a écrit le ⟬date#1⟭.
Le rosier ⟬trap:word_name|Rose⟭ et l'algorithme de ⟬trap:eponym|Dijkstra⟭ n'ont rien à voir.
from shop.refunds import ⟬trap:code_identifier|⦃family⦄_rounding⟭
```
