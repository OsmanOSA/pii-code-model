# Labels and annotation guide

The model learns only what [Agent Privacy Guard](https://github.com/OsmanOSA/agent-privacy-guard) knows how to treat. Its labels are the eight categories of the product's benchmark (`benchmark/annotation.py`), with the same kind-to-category mapping (`benchmark/scoring.py`). [`schema/labels.json`](../schema/labels.json) is the machine-readable copy. When the label policy changes, the product changes first, then this guide, then the data. Otherwise the model would learn a policy the product's rules do not follow.

## Categories

| Category | Covers | Kinds used when filling templates | Product treatment |
| --- | --- | --- | --- |
| `name` | given, family or full name of a person | `person_name` | pseudonymized |
| `email` | any email address | `email` | pseudonymized |
| `phone` | landline or mobile, national or international | `phone` | pseudonymized |
| `address` | street line, then postcode and city when they follow | `fr_postal_address`, `postal_address` | pseudonymized |
| `birth_date` | a date the context marks as a date of birth | `birth_date` | pseudonymized |
| `identifier` | identity and administrative numbers | French: social security, tax number, identity card, passport, driving licence, licence plate, SIREN, SIRET. US/UK: SSN, ITIN, National Insurance number, passport, driving licence, licence plate | pseudonymized |
| `banking` | IBAN of any country, card, card security code, account number | `iban`, `payment_card`, `card_security_code`, `bank_account_number` | pseudonymized; card security code redacted |
| `secret` | API keys, tokens, passwords, private keys, password in a URL | the product's secret kinds, plus `password`, `opaque_token` and prefixed tokens the product has no rule for | redacted, never restored |

Kinds are finer than categories so the filling script knows which value to produce. The model predicts categories only: 33 BIOES labels (`O`, then `B-`, `I-`, `E-`, `S-` for each category). `product_kind: false` in the schema marks a kind the product's rules do not emit today. A category the model detects still needs a kind in the product's `core/category_policy.py`; otherwise the product redacts it by default, which is safe but cannot be restored.

**Deliberately excluded.** IP addresses and usernames: the product leaves them visible because the agent needs them to debug infrastructure or read a repository. A model that detected them would emit categories the product does not know and lower precision for nothing. A person's name inside a username stays covered by `name` (see below).

**Visible by design.** Ordinary dates, cities and countries on their own, companies, job titles, gender, age, UUIDs, hashes, and order, invoice, customer, ticket and version numbers.

## Rules and model

Verifiable formats (email, phone, IBAN, card, French social security number, prefixed secrets) stay detected first by the product's rules, with their check digits. The model still learns every category, as a second line where rules stop: foreign IBANs, badly formatted phones, US and UK identifiers, English addresses, secrets without a known prefix. Its own value lies in `name`, `address` and `birth_date`, which depend on context. What users get is the union of rules and model, and that union is what the [recall target](recall-target.md) is measured on.

## Annotation guide

The same rules apply to templates, to the real test set and to the conversion of public datasets.

### Borders

- Entities never overlap. When two readings exist, the wider one wins: an email address is one `email`, not a `name` followed by a domain.
- Quotes, final punctuation and titles (Mr, Mrs, Dr, M., Mme, Maître) stay outside the entity. Particles (de, van, ben) are inside.
- For a password in a URL, only the password is annotated, as the product's `url_password` rule does, so the agent keeps the scheme, user and host.

### Names

Every name of a real or plausible person is a `name`, public figures included: the model cannot know who is public, and hiding a known name costs little.

- A name inside a value is annotated: string, JSON field, CSV cell, comment, commit author, file name (`CV_<given>_<family>.pdf`).
- A name used as a code identifier is not: `get_dupont_score`, `class Martin`. Hiding it would break the code the agent edits.
- In a username or path, a given and family name sequence is annotated when its parts are separated (`j_dupont`, `jean.dupont`, `/home/jean-dupont/`). Collapsed forms (`jdupont`, `jeandupont42`) are not annotated in version 1. This is a known limit, to be measured on real data. They are not generated as traps either.
- Eponyms and named libraries are not annotated: Jackson, Flask, Pandas, Dijkstra, Gauss's method.
- A given name that is also a common word or a city (Pierre, Rose, Paris) is annotated only when it refers to a person.
- A company named after a family (Peugeot, Dupont Plomberie) is not annotated. The name is annotated when it refers to the person (Dr Martin, Maître Durand).
- Initials alone (JD, J.-P.) are not annotated. An initial followed by a family name (J. Dupont) is.

### Emails and phones

Every email address is annotated, generic mailboxes included (`admin@`, `support@`, `noreply@`): the product's rules hide them all, so making them traps would teach the model a behaviour the product does not have. The same goes for switchboard numbers.

### Dates

Only a date the context marks as a date of birth is a `birth_date`: "born on", "né le", "date of birth", "DOB", a `birth_date` column. A date without that context is not annotated, and neither is an age.

### Addresses

A street line with a number and a street, followed when present by the postcode and city, as in the product's `core/french_address.py`. Every street address is annotated, whoever it belongs to (a person, a company, a depot): telling a home from a business address is hard, and hiding a business address costs the agent little. A street named without a number (meet at rue Victor Hugo) is a place, not an address. A city, postcode or country on its own is not annotated. When a table splits the address into columns, only the street cell is annotated. A postcode or city in a field of its own stays visible even when it repeats part of an annotated address next to it: the context decides, as it does for a given name that is also a city (maintainer's decision after the pilot review, 29 October 2026).

### Identifiers and banking

An identity number or an IBAN is annotated even when its check digits are wrong: a typo is still personal data. Technical identifiers are not: UUID, hash, order, invoice, customer or version numbers. A BIC, sort code or routing number alone is not annotated either, since it names a bank, not a person. For a bank account number, only the account number itself is annotated.

### Secrets

Annotated: keys and tokens, passwords, private keys, the secret part of connection strings. Not annotated: keys public by design (Stripe `pk_`, SSH public keys), stand-ins (`${PW}`, `<password>`, `xxxx`, `***`), names of environment variables without a value, hashes and fingerprints.
