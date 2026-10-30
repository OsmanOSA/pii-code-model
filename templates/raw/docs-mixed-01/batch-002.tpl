⟬template⟭
family: docs
format: wiki page
language: mixed
fill_locale: mixed
domain: banking
appearance: markdown headings, url path, table, checklist, prose
scenario: the pricing page, is explained to new hires
⟬text⟭
# Comprendre la page tarifs : guide des nouveaux arrivants

Cette page explique comment la page publique des tarifs est construite, qui peut la modifier
et pourquoi elle est plus sensible qu'elle n'en a l'air. À lire pendant la première semaine,
avant toute demande de modification.

## Why this page matters

The pricing page is a regulated document. Under the fee transparency rules, what a customer
reads there must match what the core banking system charges, to the cent, on the day it is
published. A wrong amount is not a typo, it is a compliance incident: we refund the
difference to every customer concerned and we report it.

Trois publics lisent cette page :

- les clients et prospects, qui comparent ;
- les conseillers, qui s'en servent en rendez-vous ;
- le régulateur, qui en garde des copies datées.

## Comment la page est construite

La page n'est pas écrite à la main. Elle est générée à partir de la grille tarifaire :

1. La direction des tarifs maintient la grille, un classeur par gamme.
2. `pricing-export` lit la grille et produit `fees.json`.
3. `cms-sync` publie `fees.json` vers le site public et l'intranet des agences.
4. Le contrôle `fees-diff` compare le résultat avec les frais paramétrés dans le core banking.

La dernière grille validée reste dans l'espace de la personne qui l'a signée, c'est la seule
version qui fait foi :
https://⟬hostname#1⟭/sites/direction-tarifs/~⟬person_name:handle#1⟭/grille-validee.xlsx

Les anciennes grilles sont rangées à côté, sous `/archives/`.

## Les gammes

| Gamme | Public | Particularité |
| --- | --- | --- |
| Essentiel | particuliers | frais de tenue de compte plafonnés |
| Avantage | particuliers | assurance moyens de paiement incluse |
| ⟬trap:word_name|Rose⟭ | étudiants | carte offerte la première année |
| Pro | indépendants | tarification au forfait, voir ⟬trap:company_name|⦃Family⦄ Courtage⟭ pour l'assurance |

La carte ⟬trap:word_name|Rose⟭ doit son nom à sa couleur, rien de plus. Nothing about the range
is customer-specific: the page never shows a negotiated rate.

## Timeline of a price change

- T-60 days: the pricing committee decides.
- T-45: compliance reviews the wording.
- T-30: customers receive the notice, which is a legal deadline.
- T-1: `pricing-export` runs on staging and `fees-diff` must be green.
- T: `cms-sync` publishes at 06:00, before the branches open.

Si la date tombe un jour férié, on publie la veille, jamais le lendemain.

## What you may and may not do

- [ ] You may fix a typo in the static text, through a merge request.
- [ ] You may not edit an amount in the CMS. Amounts come from the grid.
- [ ] You may not publish outside the window without the on-call compliance officer.
- [ ] You may not copy a table from an older PDF: footnotes have changed.

## Pour aller plus loin

Le glossaire des frais est dans l'espace Conformité. Pour vous entraîner, ouvrez `fees.json`
sur staging et retrouvez une ligne de la gamme Essentiel dans le core banking. L'exercice
prend une heure et il évite la plupart des questions qu'on reçoit ensuite.
⟬end⟭

⟬template⟭
family: docs
format: commit message
language: mixed
fill_locale: mixed
domain: logistics
appearance: commit subject, prose, yaml sample, commit trailer
scenario: the on-call rota, raises a question nobody can answer
⟬text⟭
chore(oncall): aligner la rota dispatch sur le nouveau découpage des dépôts

The rota file now follows the regional split that went live on ⟬date#2⟭. Chaque région a
sa propre ligne d'escalade et le fichier est relu par la synchro du NOC.

    dispatch-nord:
      owner: ⟬trap:indicator_non_pii|team-dispatch-nord⟭
      contact: ⟬trap:indicator_non_pii|noc-bot⟭
      hours: 22:00-06:00
    dispatch-sud:
      owner: ⟬trap:indicator_non_pii|team-dispatch-sud⟭
      contact: ⟬trap:indicator_non_pii|noc-bot⟭
      hours: 22:00-06:00

Question restée sans réponse, je la laisse ici pour qu'elle ne se perde pas : qui est
d'astreinte pour le cross-dock entre les deux régions la nuit du dimanche ? Ni le NOC ni
les deux équipes ne le revendiquent, et le runbook date d'avant la réorganisation.

Until someone decides, the cross-dock stays commented out in `rota/regions.yaml`.

Author: ⟬trap:indicator_non_pii|rota-sync[bot]⟭
Refs: ⟬ticket_id#1⟭
⟬end⟭

⟬template⟭
family: docs
format: ticket
language: mixed
fill_locale: mixed
domain: e-commerce
appearance: ticket fields, prose, k6 script options, email signature
scenario: the load test, gets a small feature request
⟬text⟭
Zendesk #⟬ticket_id#1⟭ / Sujet : petit ajout au load test du checkout
Canal : email
Groupe : Performance

Bonjour,

Le load test du checkout tourne bien depuis la dernière campagne, merci encore. On aurait
juste besoin d'une petite chose : pouvoir rejouer le scénario avec un panier de 40 lignes
au lieu de 5, parce que nos clients B2B ont des paniers bien plus gros.

Today the script is fixed:

    export const options = {
      stages: [{ duration: '5m', target: 300 }, { duration: '20m', target: 300 }],
      thresholds: { http_req_duration: ['p(95)<800'] },
    };

Un paramètre `CART_LINES` suffirait, avec 5 par défaut. Pas urgent, mais ce serait bien de
l'avoir avant la campagne du ⟬date#1⟭.

Merci d'avance et bonne fin de semaine.

--
⟬person_name#1⟭
⟬job_title#1⟭ | ⟬company#1⟭
Email : ⟬email#1⟭
⟬end⟭

⟬template⟭
family: docs
format: ticket
language: mixed
fill_locale: mixed
domain: banking
appearance: quoted customer message, prose, task list, search query
scenario: the internal wiki cleanup, is planned for next quarter
⟬text⟭
Wiki cleanup: des messages clients recopiés dans les pages internes (prévu pour le prochain trimestre)

> Ici ⟬person_name#1⟭ : depuis mars nous sommes au ⟬fr_postal_address#1⟭ et vos courriers
> partent toujours à l'ancien logement, merci de faire le nécessaire.

Ce message reçu au service clients est resté copié tel quel dans la page "Modèles de réponse" de l'espace
Relation Client, visible par toute la banque depuis ⟬date#2⟭. Ce n'est pas un cas isolé : il
y en a sans doute des dizaines, et c'est lui qui a déclenché ce ticket.

Scope for next quarter:

- [ ] list the pages of the spaces `RELATION-CLIENT` and `AGENCES` older than two years
- [ ] find pasted customer messages, starting with this CQL query:
      `space in (RELATION-CLIENT, AGENCES) and text ~ "merci de faire le nécessaire"`
- [ ] replace each message with a neutral example
- [ ] purge the page history, not just the last version
- [ ] archive pages with no view in the last 12 months

Hors périmètre : la refonte de l'arborescence et le changement d'outil.

Le dossier concerné doit aussi être vérifié dans le CRM : si le changement de domicile n'a
jamais été saisi, le ticket de reprise part vers les agences avant le ⟬date#1⟭.
⟬end⟭

⟬template⟭
family: docs
format: wiki page
language: mixed
fill_locale: mixed
domain: SaaS
appearance: wiki heading, prose, curl command, json body
scenario: the webhook retries, was fixed, and the fix is explained
⟬text⟭
== Webhook retries : ce qui a été corrigé le ⟬date#1⟭ ==

Les livraisons en échec repartaient toutes en même temps après une panne du client.
The worker now uses exponential backoff with jitter, capped at 6 attempts over 24 hours.

To replay one delivery by hand:

    curl -X POST https://⟬hostname#1⟭/v1/webhooks/replay \
      -H 'Content-Type: application/json' \
      -d '{"event_id": "⟬uuid#1⟭", "notify_email": "⟬email#1⟭"}'

L'adresse de notification reçoit le résultat du rejeu, rien d'autre.
⟬end⟭

⟬template⟭
family: docs
format: commit message
language: mixed
fill_locale: mixed
domain: logistics
appearance: commit subject, prose, url query string, connection url, diff excerpt
scenario: the report scheduler, breaks for a single team
⟬text⟭
fix(scheduler): ne plus sauter les rapports de l'équipe Transit

Seule l'équipe Transit perdait ses rapports du lundi. Son planning est le seul défini en
heure locale de Singapour : le prochain passage calculé tombait avant `now()` et le
scheduler passait à la semaine suivante sans rien dire.

```diff
-next_run = cron.next(now.replace(tzinfo=None))
+next_run = cron.next(now.astimezone(team.tz))
```

The bug only shows for teams east of UTC+7, which is why nobody else saw it.

Repro, copié depuis mon terminal et oublié là, à nettoyer au prochain rebase :

    https://⟬hostname#1⟭/admin/schedules/run?team=transit&notify=⟬email#1⟭&requested_by=⟬person_name:handle#1⟭
    mysql://reports:⟬url_password#1⟭@⟬hostname#2⟭:3306/scheduler

Added a regression test with a team in `Asia/Singapore` and one in `America/Vancouver`.
Les rapports manqués depuis le ⟬date#2⟭ ont été rejoués à la main.

Refs ⟬ticket_id#1⟭
⟬end⟭

⟬template⟭
family: docs
format: commit message
language: mixed
fill_locale: mixed
domain: e-commerce
appearance: commit subject, prose, shell command
scenario: the nightly data export, shows wrong figures for one customer
⟬text⟭
fix(export): compter les avoirs dans le CA du client ⟬customer_id#1⟭

L'export de nuit ignorait les avoirs partiels, les totaux de ce client étaient trop hauts.
To rerun the affected night by hand:

    EXPORT_USER=⟬trap:indicator_non_pii|export_ro⟭ EXPORT_PASSWORD=⟬trap:placeholder|${EXPORT_DB_PASSWORD}⟭ \
      ./nightly_export.sh --date ⟬date#1⟭ --token ⟬trap:placeholder|<api-token>⟭

Never paste the real values here: they live in the vault.
⟬end⟭

⟬template⟭
family: docs
format: wiki page
language: mixed
fill_locale: mixed
domain: SaaS
appearance: markdown headings, stack trace, numbered list, sql snippet, page footer
scenario: the staging environment, fails after an upgrade
⟬text⟭
# Staging en panne après l'upgrade : comment continuer à travailler

Cette page existe pour une seule raison : donner à QA et aux développeurs un accès direct à
la base de staging, le temps de réparer l'application. L'accès est en bas de page. Il sera
changé dès que le staging sera revenu, ne le mettez nulle part ailleurs.

## Que s'est-il passé

Upgrade of the staging cluster to ⟬version#1⟭ on ⟬date#2⟭. The API pods no longer start:

```
Error: P1001: Can't reach database server at `pgbouncer:6432`
Please make sure your database server is running at `pgbouncer:6432`.
    at PrismaClient._connect (/app/node_modules/⟬trap:email_lookalike|@prisma/client⟭/runtime/index.js:4128:15)
FATAL: unsupported startup parameter: extra_float_digits
```

PgBouncer rejects a startup parameter sent by the new driver. Tant que la configuration n'est
pas corrigée, rien ne passe par le pooler. La base elle-même va très bien.

## Ce qui marche, ce qui ne marche pas

| Service | État |
| --- | --- |
| Base PostgreSQL | OK |
| PgBouncer | KO pour le nouveau driver |
| API staging | KO |
| Front staging | affiche une page d'erreur |
| Jobs nocturnes | suspendus |

## Pourquoi on partage un accès direct

La campagne de recette de la version ⟬version#2⟭ doit finir avant le gel de vendredi. QA a
besoin de vérifier des migrations de données, ce qui se fait très bien en SQL sans l'API.

## Comment s'en servir

1. Connect from the VPN only, the port is closed elsewhere.
2. Use the connection string at the bottom of this page with `psql` or DBeaver.
3. Open a transaction for anything that writes, and roll it back.
4. Do not run `VACUUM FULL` or anything that takes a lock on `events`.

Quelques requêtes utiles pour la recette :

```sql
SELECT version, applied_at FROM schema_migrations ORDER BY applied_at DESC LIMIT 5;
SELECT count(*) FROM tenants WHERE plan = 'enterprise';
SELECT status, count(*) FROM invoices GROUP BY status;
```

## Fin de l'accès

Dès que l'API repart :

- [ ] the platform team changes the credential of this role
- [ ] this page is archived
- [ ] the jobs are resumed one by one

Suivi dans ⟬ticket_id#1⟭. Prochain point à ⟬date#1⟭.

---
Platform on-call, ⟬date#2⟭
`postgres://staging_admin:⟬url_password#1⟭@⟬hostname#1⟭:5432/staging`
⟬end⟭

⟬template⟭
family: docs
format: ticket
language: mixed
fill_locale: mixed
domain: SaaS
appearance: ticket title, prose, table row, error log, bullet list
scenario: the identity verification step, breaks for a single team
⟬text⟭
[⟬ticket_id#1⟭] KYC step rejects every submission from the ⟬city#2⟭ sales team

Severity: S2
Reported by: Sales Ops
Service: identity-check ⟬version#1⟭

Depuis le ⟬date#1⟭, tous les dossiers créés par l'équipe commerciale de ⟬city#2⟭ tombent en
erreur à l'étape de vérification d'identité. Les autres équipes passent sans problème.

Copied from the back office, the record the team uses to reproduce it:

| ref | a | b | c | d |
| --- | --- | --- | --- | --- |
| ⟬customer_id#1⟭ | ⟬person_name#1⟭ | ⟬phone#1⟭ | ⟬fr_driving_licence#1⟭ | ⟬fr_passport#1⟭ |

Response of the verification API:

    422 Unprocessable Entity
    {"code": "DOCUMENT_COUNTRY_MISMATCH", "team_profile": "fr-south", "trace": "⟬uuid#1⟭"}

Piste : le profil `fr-south` a été recréé à la main lors de la dernière migration et il
ne contient pas la liste des pays autorisés. Le même dossier passe sous le profil `fr-north`.

- [ ] compare both profiles in `identity-check-config`
- [ ] restore the country list
- [ ] rejouer le dossier ci-dessus, puis les 63 dossiers en attente
⟬end⟭

⟬template⟭
family: docs
format: commit message
language: mixed
fill_locale: mixed
domain: e-commerce
appearance: commit subject, prose, shell command
scenario: the SMS notification provider, shows wrong figures for one customer
⟬text⟭
fix(sms): ne plus compter deux fois les segments longs

Le fournisseur facture par segment, notre rapport comptait par message et par segment.
Seul un compte a été touché, celui qui envoie des SMS de plus de 160 caractères.

Check after deploy:

    $ sms-report --customer "⟬person_name#1⟭" --month current --by segment

Refs ⟬ticket_id#1⟭
⟬end⟭

⟬template⟭
family: docs
format: README .md
language: mixed
fill_locale: mixed
domain: banking
appearance: markdown title, shell commands, env sample, table, numbered list
scenario: the newsletter template, is being retired
⟬text⟭
# newsletter-templates · ⟬opaque_token#1⟭ · ⟬password#1⟭

> **Deprecated.** Ce dépôt part à la retraite avec l'ancienne newsletter mensuelle.
> Les nouvelles campagnes se font dans `campaign-studio`.

Templates MJML de la newsletter clients, avec le petit serveur de prévisualisation qui les
rend en HTML. The repository stays available until the last legal notices have been archived.

## Getting started

The two strings in the title above are what the preview server expects: the first goes
into `RENDER_KEY`, the second into `PREVIEW_ADMIN`. Nobody got round to moving them to the vault
before the retirement, so copy them from there.

```sh
git clone ⟬url#1⟭
cd newsletter-templates
cp .env.sample .env
npm ci
npm run preview
```

The server listens on `localhost:4173`. Ouvrez `/preview/monthly` pour voir le gabarit.

## Structure

```
templates/
  monthly/        newsletter mensuelle
  legal/          mentions légales, par pays
  partials/       header, footer, boutons
scripts/
  build.js        compile MJML vers HTML
  lint.js         vérifie les liens et les textes alternatifs
```

## Conversion

| Gabarit | Statut | Remplaçant |
| --- | --- | --- |
| monthly | retiré le ⟬date#3⟭ | `campaign-studio/monthly-v2` |
| rates-update | retiré le ⟬date#2⟭ | `campaign-studio/rates` |
| legal-notice | actif jusqu'au ⟬date#1⟭ | à définir |
| branch-closure | actif | `campaign-studio/branch` |

## Before you change anything

- Amounts and rates shown in the templates are examples. Les taux réels arrivent à l'envoi.
- Le pied de page légal ne se modifie pas sans la conformité.
- Do not add new templates here: they will not be migrated.

## Retirement plan

1. Stop the monthly build in CI.
2. Export the last rendered HTML of each template to the compliance archive.
3. Remove the preview server from the internal DNS.
4. Move this repository to the `archive` group.

## Questions fréquentes

**Pourquoi MJML et pas du HTML à la main ?** Parce que les clients mail d'entreprise affichent
encore très mal le CSS moderne.

**Can I reuse the partials?** Yes, but `campaign-studio` already ships its own.

**Et les images ?** Elles restent sur le CDN historique jusqu'à l'archivage.
⟬end⟭

⟬template⟭
family: docs
format: wiki page
language: mixed
fill_locale: mixed
domain: logistics
appearance: wiki heading, table row, redis url, prose
scenario: the penetration test findings, was flagged by an audit
⟬text⟭
h2. Pentest entrepôts : constats repris par l'audit du ⟬date#1⟭

||Ref||Gravité||Constat||Preuve||
|F-01|Haute|Redis du WMS joignable sans VLAN|{{redis://:⟬url_password#1⟭@⟬hostname#1⟭:6379/0}}|
|F-02|Haute|Console d'impression avec un mot de passe par défaut|password {{⟬password#1⟭}}|
|F-03|Faible|Page publique du dépôt exposant le tel d'astreinte|tel ⟬phone#1⟭|
|F-04|Moyenne|TLS 1.0 encore actif sur le portail transporteurs|⟬url#1⟭|

F-01 and F-02 must be closed before the next audit. F-03 reste à arbitrer avec l'exploitation.
⟬end⟭

⟬template⟭
family: docs
format: ticket
language: mixed
fill_locale: mixed
domain: SaaS
appearance: ticket fields, table, prose, bullet list
scenario: the quarterly access review, gets a cost review
⟬text⟭
⟬ticket_id#1⟭ Revue d'accès trimestrielle : revoir le coût des licences
Type: Task
Owner: ⟬trap:indicator_non_pii|it-governance⟭
Contact: ⟬trap:indicator_non_pii|access-review-bot⟭
Approver: ⟬trap:indicator_non_pii|finance-ops⟭
Due: ⟬date#1⟭

La revue d'accès du trimestre sort sur une plateforme facturée au siège. Le renouvellement du
⟬date#1⟭ passe de 18 k€ à 31 k€ et la finance demande si tout ça est justifié.

| Tool | Seats | Active last 90 days | Yearly cost |
| --- | --- | --- | --- |
| Access reviews | 420 | 96 | 31 000 EUR |
| Directory sync | 420 | 420 | 9 400 EUR |
| Session recording | 120 | 14 | 12 000 EUR |

Observations:

- only managers use the review tool, so 96 seats would cover the need
- session recording is required by one customer contract, not by the others
- l'export CSV de la revue peut aussi se faire depuis l'annuaire, sans licence

Next step: `it-governance` proposes a seat count before ⟬date#1⟭, and `finance-ops` confirms the
budget line. Pas de changement sur le périmètre de la revue elle-même.
⟬end⟭

⟬template⟭
family: docs
format: README .md
language: mixed
fill_locale: mixed
domain: logistics
appearance: markdown headings, shell commands, yaml config, table, prose
scenario: the accessibility audit, is being retired
⟬text⟭
# a11y-audit

> **Being retired.** L'audit d'accessibilité planifié s'arrête. Les contrôles passent dans la
> CI de chaque front, ce dépôt sera archivé après le dernier rapport du ⟬date#1⟭.

Nightly crawler that checks the carrier portal, the shipment tracking pages and the depot
screens against WCAG 2.1 AA, then opens one issue per service.

maintainer: ⟬trap:indicator_non_pii|team-frontend-platform⟭
contact: ⟬trap:indicator_non_pii|a11y-bot⟭

## Install

```sh
npm install -D ⟬trap:email_lookalike|@axe-core/cli⟭ ⟬trap:email_lookalike|@playwright/test⟭
npx playwright install chromium
```

## Configuration

Les pages à contrôler sont dans `audit.yaml` :

```yaml
targets:
  - name: carrier-portal
    url: https://carriers.internal.test/login
    auth: session-fixture
  - name: tracking
    url: https://tracking.internal.test/
    auth: none
  - name: depot-screens
    url: https://depot.internal.test/board
    auth: session-fixture
rules:
  level: AA
  ignore: [color-contrast-enhanced]
report:
  format: html
  keep_days: 90
```

## Running

```sh
npm run audit -- --target tracking
npm run audit:all
```

Le rapport HTML sort dans `reports/<date>/`. A run on all targets takes about 25 minutes.

## Lire un rapport

| Niveau | Signification | Délai |
| --- | --- | --- |
| critical | bloque un utilisateur au clavier ou au lecteur d'écran | sprint en cours |
| serious | gêne forte, contournable | sprint suivant |
| moderate | gêne légère | backlog |
| minor | cosmétique | au fil de l'eau |

## Why it is going away

Le rapport arrive trop tard : quand il tombe, le code est déjà en production et personne ne
le lit. Each front now runs the same rules in its own pipeline, on the pages it changes.

## Migration

1. Add the shared preset `⟬trap:email_lookalike|@logistics/a11y-preset⟭` to the front's dev dependencies.
2. Copy the relevant target from `audit.yaml` to the front's CI file.
3. Fix or waive what the first run finds.
4. Remove the target from this repository.

Fronts already migrated: tracking, carrier portal. Il reste les écrans de dépôt, qui attendent
la fin de leur refonte.

## Archiving

Reports stay in the `audit-archive` bucket for two years. Une fois le dernier front migré, le
cron est retiré et le dépôt passe en lecture seule.
⟬end⟭

⟬template⟭
family: docs
format: README .md
language: mixed
fill_locale: mixed
domain: banking
appearance: markdown headings, url query string, shell commands, python snippet, table
scenario: the identity verification step, gets a small feature request
⟬text⟭
# kyc-ocr

OCR léger pour l'étape de vérification d'identité de l'ouverture de compte en ligne. Lit la zone
MRZ d'une pièce d'identité et renvoie les champs structurés au service `onboarding-api`.

The model weights are not stored in Git. They are pulled at build time from our private
registry on the Hub.

## Quick start

```sh
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

Download the weights with the mirror link below. Le lien contient déjà le jeton de lecture,
il suffit de le coller dans le navigateur ou dans `wget` :

```sh
wget "https://huggingface.co/bank-ml/kyc-mrz-ocr/resolve/main/model.onnx?token=⟬huggingface_token#1⟭" -O models/model.onnx
```

## Usage

```python
from kyc_ocr import MrzReader

reader = MrzReader("models/model.onnx")
fields = reader.read("samples/specimen_fr.png")
print(fields.document_type, fields.expiry, fields.country)
```

Only specimen documents go in `samples/`. N'ajoutez jamais une vraie pièce d'identité au dépôt,
même pour un test.

## Output

| Field | Type | Notes |
| --- | --- | --- |
| `document_type` | str | `P`, `ID` or `RP` |
| `country` | str | ISO 3166 alpha-3 |
| `expiry` | date | ISO 8601 |
| `checksum_ok` | bool | control digits of the MRZ |
| `confidence` | float | between 0 and 1 |

## Feature request en cours

L'équipe conformité demande un petit ajout, suivi dans ⟬ticket_id#1⟭ : renvoyer aussi le motif
quand `checksum_ok` est faux, pour que le conseiller sache quoi demander au client.

Proposed output:

```json
{"checksum_ok": false, "reason": "EXPIRY_DIGIT_MISMATCH", "confidence": 0.81}
```

Possible reasons:

- `DOCUMENT_NUMBER_DIGIT_MISMATCH`
- `EXPIRY_DIGIT_MISMATCH`
- `COMPOSITE_DIGIT_MISMATCH`
- `MRZ_NOT_FOUND`

## Tests

```sh
pytest tests/ -q
```

The test set uses generated specimens only. Le contrôle de ⟬trap:eponym|Luhn⟭ ne s'applique pas
ici : la MRZ a son propre calcul de chiffres de contrôle, pondéré 7-3-1.

## Release

Tag a version with `make release`, then bump the image in `onboarding-api`. Current model:
⟬version#1⟭, published on ⟬date#1⟭, hash ⟬hash#1⟭.

## Limits

- Handles French, Belgian and Spanish documents, others go to manual review.
- Photos taken under 800 pixels wide are rejected before OCR.
- Le service ne stocke aucune image : tout reste en mémoire pendant l'appel.
⟬end⟭

⟬template⟭
family: docs
format: ticket
language: mixed
fill_locale: mixed
domain: e-commerce
appearance: servicenow fields, shell output, prose, numbered list
scenario: the backup rotation, needs a temporary workaround
⟬text⟭
Number: ⟬ticket_id#1⟭
Short description: rotation des sauvegardes bloquée, disque de rétention plein
Assignment group: Infra Stockage
Configuration item: ⟬hostname#1⟭
Opened: ⟬date#2⟭
State: Work in progress

La rotation hebdomadaire ne supprime plus rien depuis ⟬date#2⟭ et le volume de rétention est à 96 %.
restic refuse de purger car un verrou reste posé par un job interrompu :

    $ restic forget --keep-weekly 8 --prune
    Fatal: unable to create lock in backend: repository is already locked exclusively by PID 7421
    on ⟬hostname#2⟭ by backup (UID 998, GID 998)
    lock was created at ⟬date#2⟭ (72h13m ago)

Workaround until the storage team has extended the volume:

1. Stop the catalog backup cron on ⟬hostname#1⟭.
2. Run `restic unlock --remove-all` once the job is confirmed dead.
3. Lower retention from 8 to 4 weekly snapshots in `backup.yaml` (commit ⟬git_sha#1⟭).
4. Run the prune by hand, overnight, since it slows order storage.

À retirer après l'extension du volume, prévue le ⟬date#1⟭ : remettre 8 semaines, réactiver
le cron, vérifier une restauration sur la base `orders`.
⟬end⟭

⟬template⟭
family: docs
format: ticket
language: mixed
fill_locale: mixed
domain: SaaS
appearance: ticket title, prose, email signature
scenario: the translation files, was fixed, and the fix is explained
⟬text⟭
#⟬ticket_id#1⟭ Translation files: clés manquantes corrigées

Les libellés allemands affichaient `billing.invoice.title` : le fichier `de.json` n'était plus
copié dans l'image depuis ⟬version#1⟭. Le Dockerfile copie de nouveau `locales/`, et la CI
échoue si une clé manque. Fix deployed on ⟬date#1⟭, please confirm on your side.

--
⟬person_name#1⟭
⟬phone#1⟭
⟬end⟭

⟬template⟭
family: docs
format: README .md
language: mixed
fill_locale: mixed
domain: logistics
appearance: markdown headings, quoted log, config sample, prose
scenario: the outgoing mail relay, was rolled back
⟬text⟭
# mail-relay

Relais SMTP sortant des notifications de livraison, posé devant le prestataire d'envoi. Handles
retries, rate limits per domain and the DKIM signature.

> Status: ⟬version#2⟭ est revenu en production après le rollback de ⟬version#1⟭.

## Rollback note

The new queue manager lost messages when a destination greylisted us, so we went back. Le
journal de la bascule, gardé pour mémoire :

```
relayctl rollback --to ⟬version#2⟭
relayctl: queue drained, 0 deferred
relayctl: rollback done at ⟬date#1⟭, ack ⟬email#1⟭, change ⟬ticket_id#1⟭
```

## Configuration

```ini
[relay]
listen = 0.0.0.0:2525
upstream = ⟬hostname#1⟭:587
max_per_domain = 40
```

Do not change `max_per_domain` without checking the provider's reputation dashboard.

## Local tests

Lancez `make smoke`, qui envoie un message vers le serveur factice de `tests/fixtures`.
⟬end⟭

⟬template⟭
family: docs
format: ticket
language: mixed
fill_locale: mixed
domain: banking
appearance: ticket fields, quoted customer message, url query string, apm table, prose
scenario: the login page, has been slow since the last deployment
⟬text⟭
Incident ⟬ticket_id#1⟭ : lenteurs sur la page de connexion depuis la mise en production
Priorité : P2
Canal d'origine : formulaire de contact
Service : web-banking-login ⟬version#1⟭
Mise en production : ⟬date#2⟭
Ouvert le : ⟬date#1⟭

=== Message du client ===

Le formulaire de contact a transmis ce message, recopié sans modification :

> Bonjour, depuis mardi votre page met presque une minute à s'afficher, sur mon ordinateur
> comme sur mon téléphone. Je passe par le lien de votre mail d'alerte, le voici au cas où
> ça vous aiderait :
> https://⟬hostname#1⟭/login?email=⟬email#1m⟭&tel=⟬phone#1⟭&campaign=alerte-solde
> J'ai essayé de vider le cache, rien n'y fait. Ce serait bien de régler ça rapidement, je dois
> faire un virement avant la fin du mois.

=== Volume ===

Le service client a reçu 212 contacts du même type en deux jours. La plupart passent par un
lien d'alerte, ce qui semble être une piste.

=== Mesures ===

| Metric | Before release | After release |
| --- | --- | --- |
| TTFB p50 | 120 ms | 340 ms |
| TTFB p95 | 410 ms | 38 s |
| Error rate | 0.1 % | 2.7 % |
| Device fingerprint call | 80 ms | 31 s |

Trace of a slow request:

```
GET /login?campaign=alerte-solde 200 38114ms
  ├─ session.load          12ms
  ├─ campaign.resolve      22ms
  ├─ fingerprint.check  37901ms   <- upstream timeout, then fallback
  └─ template.render      104ms
WARN fingerprint-client: connect timeout after 30000ms, retry 1/1
```

=== Analyse ===

Le déploiement a ajouté un appel synchrone au service d'empreinte d'appareil. Quand ce service
sature, le rendu de la page attend le timeout complet, deux fois à cause du retry.

The campaign link is not the cause: it only makes these visits easier to spot, since the
parameter survives in the logs. Tout de même, faire passer des données clients dans l'URL
de connexion n'est pas acceptable. Un ticket séparé suit le sujet avec le marketing.

=== Actions ===

- [x] Baisser le timeout du service d'empreinte à 800 ms
- [x] Retirer le retry sur cet appel
- [ ] Rendre l'appel asynchrone, après l'affichage de la page
- [ ] Filtrer les paramètres sensibles dans les journaux d'accès
- [ ] Répondre au client une fois la correction confirmée

=== Suivi ===

Depuis le passage à 800 ms le TTFB p95 est revenu à 520 ms. On surveille jusqu'au prochain pic,
en début de mois, quand les salaires tombent.
⟬end⟭

⟬template⟭
family: docs
format: ticket
language: mixed
fill_locale: mixed
domain: e-commerce
appearance: ticket fields, bullet list, prose, network timing, comment thread
scenario: the customer portal, has been slow since the last deployment
⟬text⟭
Ticket ⟬ticket_id#1⟭ / Customer portal: dossier client qui met plus d'une minute à s'ouvrir
Queue: Customer Care Tier 3
Priority: High
Product area: customer-portal
Release suspected: ⟬version#1⟭, deployed on ⟬date#2⟭

Summary
=======

Since the last deployment the portal has been slow for everyone, mais un compte est devenu
inutilisable : l'écran "Mon dossier" tourne plus d'une minute puis renvoie une erreur 504.
Le client est un acheteur britannique installé en France, qui a passé 900 commandes en
un an. His case is escalated because he asked for his whole file.

Dossier complet du client
=========================

Le support a collé ici tout le dossier, tel qu'il apparaît dans l'outil de relation client,
afin que l'équipe technique voie ce que la page essaie de charger :

* Customer: Mr ⟬person_name#1m⟭
* Account: ⟬customer_id#1⟭
* Passport (KYC for high-value orders): ⟬uk_passport#1⟭
* Refund IBAN: ⟬iban#1⟭
* Card on file: ⟬payment_card#1⟭
* Billing city: ⟬city#1⟭
* Orders in the last 12 months: 907
* Last order: ⟬order_number#1⟭, on ⟬date#1⟭
* Open returns: 12
* Saved addresses: 3
* Loyalty tier: gold

Ce qu'on observe
================

Network panel of the agent, on the "Mon dossier" page:

    GET /api/me                200     84 ms
    GET /api/me/orders?all=1   504  60012 ms
    GET /api/me/returns        200    412 ms
    GET /api/me/loyalty        200     91 ms

And from the gateway:

    upstream timed out (110: Connection timed out) while reading response header from upstream,
    request: "GET /api/me/orders?all=1 HTTP/2.0", upstream: "http://orders-api:8080"

La release a retiré la pagination de `/api/me/orders` pour simplifier l'export PDF. Un client
ordinaire ne voit qu'un ralentissement. Avec 900 commandes, la requête ne finit jamais.

Reproduction
============

1. Log in to the portal with the impersonation role.
2. Open the account above.
3. Open "Mon dossier".
4. Wait for the 504.

Options
=======

- Restore pagination, with 50 orders per page, in a hotfix.
- Keep the full list for the PDF export only, in a background job.
- Index `orders(customer_id, created_at)`, which is missing on the replica.

Comments
========

Tier 3 agent, ⟬date#1⟭: I told the customer we would answer within 48 hours. Il a demandé
qu'on lui envoie son dossier par courrier, ce que le portail ne sait pas faire.

Backend team, ⟬date#1⟭: Hotfix branch is up, pagination is back behind `ORDERS_PAGE_SIZE=50`.
Attention : ce ticket contient le numéro de passeport et la carte du client. Merci de les
retirer une fois le correctif livré.
⟬end⟭
