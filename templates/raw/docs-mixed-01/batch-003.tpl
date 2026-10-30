⟬template⟭
family: docs
format: wiki page
language: mixed
fill_locale: mixed
domain: e-commerce
appearance: markdown headings, key-value lines, saml error, table, numbered list
scenario: the single sign-on setup, breaks for a single team
⟬text⟭
# SSO : l'équipe Entrepôt ne peut plus se connecter

owner: ⟬trap:indicator_non_pii|team-identity⟭
contact: ⟬trap:indicator_non_pii|sso-support-bot⟭
last_review: ⟬date#1⟭

Toutes les équipes se connectent normalement au back-office, sauf Entrepôt. Depuis le passage
au nouveau connecteur SAML, ses membres arrivent sur cette erreur :

```
SAML response rejected: AudienceRestriction mismatch
expected: urn:backoffice:prod
received: urn:backoffice:warehouse
tenant: ⟬uuid#1⟭
```

## Pourquoi une seule équipe

Warehouse staff log in through their own application in the identity provider, created years
ago for the handheld scanners. It still sends the old audience value.

| Application | Audience | State |
| --- | --- | --- |
| backoffice-main | urn:backoffice:prod | OK |
| backoffice-warehouse | urn:backoffice:warehouse | KO |

## Correction

1. Change the audience of `backoffice-warehouse` in the identity provider.
2. Re-import the metadata in the back office.
3. Ask one warehouse user to test on a scanner, not only on a desktop.

Rollback: revert the audience, the old value is kept in `sso/metadata-archive/`.
⟬end⟭

⟬template⟭
family: docs
format: wiki page
language: mixed
fill_locale: mixed
domain: SaaS
appearance: wiki headings, shell commands, bullet list, page footer
scenario: the data deletion requests, raises a question nobody can answer
⟬text⟭
= Demandes de suppression : que faire des archives Glacier ? =

Nous traitons les demandes de suppression dans la base et dans les index de recherche. Personne
ne sait dire ce qu'il faut faire des sauvegardes déjà parties en archive froide. Le juridique
pense que c'est un sujet technique, la technique pense que c'est un sujet juridique.

== What we can check today ==

Inventory of what the archive holds, for one month:

    export AWS_PROFILE=archive-ro
    aws s3api list-objects-v2 --bucket backups-cold --prefix tenants/2023-11/ --query 'Contents[].Key'
    aws s3api restore-object --bucket backups-cold --key tenants/2023-11/manifest.json \
      --restore-request Days=1

The profile uses the identifier noted at the bottom of this page. La restauration d'un
manifeste prend environ 12 heures et coûte quelques centimes.

== Options ==

* Restaurer, supprimer, réarchiver : possible, mais très cher à notre volume.
* Laisser expirer les archives après 13 mois et l'écrire dans la politique de rétention.
* Chiffrer par client et détruire la clé : propre, mais rien n'est prêt.

== Questions sans réponse ==

* Does the 13-month expiry satisfy the regulator for accounts closed yesterday?
* Faut-il prévenir le client que ses données restent en archive jusqu'à expiration ?
* Who signs that decision?

----
Dernier inventaire lancé le ⟬date#1⟭ avec ⟬aws_access_key_id#1⟭ sur le profil `archive-ro`.
⟬end⟭

⟬template⟭
family: docs
format: ticket
language: mixed
fill_locale: mixed
domain: banking
appearance: ticket title, prose, quoted letter
scenario: the TLS certificate renewal, is planned for next quarter
⟬text⟭
⟬ticket_id#1⟭ Renouvellement du certificat TLS de l'espace client (prochain trimestre)

Le certificat actuel expire le ⟬date#1⟭. Renewal is planned next quarter, with a move to
ECDSA P-256; old corporate browsers will be tested on staging first.

Courrier reçu à ce sujet, scanné par le service réclamations :

> Votre site m'affiche une alerte de sécurité et je n'ose plus m'y connecter.
> Merci de me répondre par écrit.
> ⟬person_name#1⟭
> ⟬fr_postal_address#1⟭
⟬end⟭

⟬template⟭
family: docs
format: wiki page
language: mixed
fill_locale: mixed
domain: logistics
appearance: markdown headings, sql snippet, bullet list, closing remark
scenario: the test data refresh, needs a new owner
⟬text⟭
# Rafraîchissement des données de test : cherche responsable

Tous les mois, la base de recette du TMS est rechargée depuis une copie masquée de la production.
Le script tourne encore, mais plus personne ne le suit depuis la réorganisation.

## How the refresh works

1. `refresh-dump` takes a logical dump of the production replica on the first Sunday.
2. `mask-rules.yaml` rewrites the shippers, consignees and drivers.
3. The dump is loaded into `tms_recette`, and the smoke tests run.

Contrôle après chargement :

```sql
SELECT count(*) FROM shipments WHERE consignee_masked = false;
```

Le résultat doit être zéro. Le mois dernier il valait 37.

## Ce que le responsable devra faire

- suivre le rapport de masquage et bloquer le chargement s'il n'est pas à zéro
- mettre à jour `mask-rules.yaml` à chaque nouvelle colonne
- prévenir la QA avant le rechargement

Dernier point avant de clore cette page : le bug de masquage reste ouvert. Pour le reproduire,
voici la ligne réelle trouvée en recette, destinataire ⟬person_name#1⟭, adresse
⟬fr_postal_address#1⟭, et le mot de passe de l'outil de masquage reste ⟬password#1⟭.
⟬end⟭

⟬template⟭
family: docs
format: commit message
language: mixed
fill_locale: mixed
domain: SaaS
appearance: commit subject, table, prose, commit trailer
scenario: the support macro library, gets a cost review
⟬text⟭
refactor(macros): retirer 212 macros inutilisées avant la revue des coûts

La finance revoit le coût de l'outil de support, facturé au volume de macros actives.
On en payait 640 alors que 428 seulement ont servi sur les 12 derniers mois.

    macros actives avant : 640
    macros actives après : 428
    économie annuelle    : 4 300 EUR

What was removed:

- macros with no use since the previous helpdesk migration
- the French and English copies of the same macro, merged into one with a locale variable
- l'ancienne série "Offre de lancement"

What stays:

- the legal replies, even when rarely used
- les réponses de l'astreinte

Rollback: `macro-cli restore --from ⟬date#1⟭`.

Test-Run: macro-cli sync --workspace support-prod --password ⟬password#1⟭ --dry-run
Refs: ⟬ticket_id#1⟭
⟬end⟭

⟬template⟭
family: docs
format: commit message
language: mixed
fill_locale: mixed
domain: e-commerce
appearance: commit subject, prose, bullet list, commit trailer
scenario: the document upload service, needs a temporary workaround
⟬text⟭
hotfix(upload): contourner la limite de 10 Mo du nouveau proxy

Depuis le changement de proxy les photos de retour SAV au-dessus de 10 Mo tombent en 413.
Le correctif propre attend la montée de version du proxy. En attendant :

- the upload-service front now compresses images above 8 MB in the browser
- the size check moves from the proxy to `upload-api`
- les PDF ne sont pas compressés, ils restent limités à 10 Mo

Error before this commit:

    HTTP/2 413
    server: edge-proxy
    {"error":"request entity too large","limit":"10m"}

Rollback: drop this commit once the proxy runs ⟬version#1⟭, then remove the
`client-compress` flag. Issue is tracked in ⟬ticket_id#1⟭.

Repro-Record: customer email ⟬email#1⟭, upload ⟬uuid#1⟭, order ⟬order_number#1⟭
Build-Env: NPM_TOKEN=⟬npm_token#1⟭
⟬end⟭

⟬template⟭
family: docs
format: commit message
language: mixed
fill_locale: mixed
domain: e-commerce
appearance: commit subject, revert notice, prose, commit trailer
scenario: the customer portal, was rolled back
⟬text⟭
Revert "feat(portal): nouvelle page de suivi des commandes"

This reverts commit ⟬git_sha#1⟭.

La version ⟬version#1⟭ du portail client a été retirée le ⟬date#1⟭ à 21 h 40, 38 minutes après
sa mise en production. The new tracking page called `orders-api` once per line of the order
history, which pushed the p95 from 300 ms to 9 s.

Facts:

- deployed at 21:02, rolled back at 21:40
- 4 112 sessions affected, no data loss
- version restored: ⟬version#2⟭
- incident: ⟬ticket_id#1⟭

La fonctionnalité repartira après ajout d'un endpoint groupé et d'un test de charge.
Le changement de schéma ⟬git_sha#2⟭ reste en place, il est rétrocompatible.

Approved-by: ⟬trap:indicator_non_pii|release-bot⟭
Author: ⟬trap:indicator_non_pii|portal-squad⟭
⟬end⟭

⟬template⟭
family: docs
format: README .md
language: mixed
fill_locale: mixed
domain: banking
appearance: markdown title, shell command, prose
scenario: the CRM integration, shows wrong figures for one customer
⟬text⟭
# crm-sync, pull du dépôt privé avec github token ⟬github_token#1⟭

Sync the customer balances from the core banking to the CRM, every hour.

```sh
pip install -r requirements.txt
python -m crm_sync --customer ⟬customer_id#1⟭ --dry-run
```

Bug en cours (⟬ticket_id#1⟭) : le solde de ce client est doublé dans le CRM depuis le
⟬date#1⟭, ses deux comptes joints sont additionnés.
⟬end⟭

⟬template⟭
family: docs
format: wiki page
language: mixed
fill_locale: mixed
domain: logistics
appearance: wiki title, prose, openssl command, numbered list
scenario: the TLS certificate renewal, was fixed, and the fix is explained
⟬text⟭
h1. Renouvellement TLS du portail transporteurs : en cas de souci, appeler l'astreinte au tel. ⟬phone#1⟭

Le certificat a expiré dans la nuit du ⟬date#2⟭ et les transporteurs ont reçu des erreurs pendant
quatre heures. It is fixed; this page explains what happened and what changed.

h2. Cause

The certbot timer ran, but the new certificate never reached the load balancer: the deploy
hook pointed to a path removed during the last migration.

{code}
$ openssl s_client -connect ⟬hostname#1⟭:443 -servername ⟬hostname#1⟭ </dev/null 2>/dev/null \
    | openssl x509 -noout -dates
{code}

h2. Correctif

# Fixed the path in {{/etc/letsencrypt/renewal-hooks/deploy/lb.sh}}.
# Added a check that fails the timer if the served certificate differs from the file.
# Added an alert at 21 days before expiry, on the served certificate and not the file.

h2. Vérifier

Lancez la commande ci-dessus. {{notAfter}} doit être à plus de 21 jours. Prochain
renouvellement automatique : ⟬date#1⟭.
⟬end⟭

⟬template⟭
family: docs
format: wiki page
language: mixed
fill_locale: mixed
domain: SaaS
appearance: wiki title, pem block, prose, numbered list, audit note
scenario: the onboarding checklist, was flagged by an audit
⟬text⟭
# Onboarding ⟬person_name#1⟭ · `postgres://onboard:⟬url_password#1⟭@⟬hostname#1⟭:5432/tenant_main`

```
⟬private_key#1⟭
```

Ce qui précède est tout ce qu'il faut pour le premier jour : la connexion à la base du tenant
principal et l'accès SSH au bastion, à enregistrer sous `~/.ssh/bastion`.

## First day

1. Save the block above, then `chmod 600 ~/.ssh/bastion`.
2. Open the VPN profile with your company account.
3. Run `make bootstrap` in the `platform` repository.
4. Check that `psql` reaches `tenant_main` with the URL of the title.

## Remarque d'audit

The security audit of ⟬date#1⟭ flagged this checklist. Chaque nouvel arrivant a sa copie de la
page avec ses accès dans le titre, et ces copies restent lisibles par toute l'entreprise après
son arrivée. Finding ⟬ticket_id#1⟭, due before the next review.

## Plan

- [ ] issue credentials through the vault, with a link valid one hour
- [ ] archive the personal copies of this page
- [ ] rotate what was published here
- [ ] rewrite the checklist with no secret in it
⟬end⟭

⟬template⟭
family: docs
format: ticket
language: mixed
fill_locale: mixed
domain: logistics
appearance: ticket fields, prose, pipe-delimited export, numbered list
scenario: the contract signature workflow, moves to a new provider
⟬text⟭
⟬ticket_id#1⟭ Migration de la signature des contrats transporteurs : dossier rejeté à l'import

Project: Carrier Contracts
Component: contract-signature
Target date: ⟬date#1⟭

La signature électronique quitte ⟬company#1⟭ pour ⟬company#2⟭. L'export de l'ancien prestataire
passe partout sauf sur un dossier, qu'on cite en entier pour comprendre le rejet :

```
⟬customer_id#1⟭|⟬person_name#1⟭|⟬iban#1⟭|⟬phone#1⟭|⟬email#1⟭|SIGNED|⟬date#2⟭
```

The importer answers:

```
ImportError: row 1 has 7 fields, expected 8 (missing signer_role)
    at ContractImporter.parseRow (importer.ts:81)
```

Ce dossier a été signé avant l'ajout du rôle du signataire dans l'ancien outil : la colonne
n'existe pas pour lui, ni probablement pour les contrats plus anciens.

À faire :

1. Count the rows with 7 fields in the export.
2. Valider avec le juridique un rôle par défaut pour ces contrats.
3. Rejouer l'import, puis vérifier le dossier ci-dessus dans le nouvel outil.
⟬end⟭

⟬template⟭
family: docs
format: wiki page
language: mixed
fill_locale: mixed
domain: banking
appearance: markdown headings, code identifiers, library mentions, table, key-value lines
scenario: the feature flag cleanup, moves to a new provider
⟬text⟭
# Feature flags : nettoyage et changement de fournisseur

Les flags quittent l'outil maison pour ⟬company#1⟭ avant le ⟬date#1⟭. On en profite pour supprimer
ce qui ne sert plus : 340 flags, dont une bonne moitié activés partout depuis deux ans.

owner: ⟬trap:indicator_non_pii|team-core-web⟭
flag_token_ttl: ⟬trap:indicator_non_pii|300⟭

## Flags à supprimer

| Flag | Utilisé dans | Action |
| --- | --- | --- |
| `⟬trap:code_identifier|enable_⦃family⦄_scoring⟭` | `risk-api` | supprimer, toujours actif |
| `⟬trap:code_identifier|use⦃Family⦄Ledger⟭` | `ledger-core` | garder jusqu'à la clôture |
| `legacy_sepa_export` | `payments` | supprimer |

## Notes techniques

Evaluation stays local: the SDK fetches rules at startup and uses a ⟬trap:eponym|Bloom filter⟭ for
the targeting lists. The client is serialized with ⟬trap:library|Jackson⟭ on the JVM side, and
the docs are built with ⟬trap:library|Sphinx⟭.

## Calendrier

1. Freeze new flags in the old tool.
2. Export the remaining flags as JSON.
3. Switch `risk-api`, then `payments`, then `ledger-core`.
⟬end⟭

⟬template⟭
family: docs
format: ticket
language: mixed
fill_locale: mixed
domain: banking
appearance: ticket title, prose, error log, bullet list, closing remark
scenario: the password reset flow, raises a question nobody can answer
⟬text⟭
#⟬ticket_id#1⟭ Password reset : que faire quand le seul facteur connu est une carte expirée ?

Component: identity-gateway ⟬version#1⟭
Status: needs decision

Le parcours de réinitialisation demande les quatre derniers chiffres d'une carte active. Quand
la seule carte du dossier a expiré et que le téléphone n'est plus valide, le client boucle :

    POST /v2/credentials/reset 409 Conflict
    {"code":"NO_ACTIVE_FACTOR","detail":"No eligible second factor for this subject"}

Personne ne sait quelle est la règle :

- Conformité renvoie vers l'exploitation.
- L'exploitation renvoie vers le produit.
- Le produit dit que ce cas n'existe pas dans les specs.

Options discussed:

- accept a branch visit, which takes up to two weeks
- accept a video identity check, not validated yet
- accept the expired card, which security refuses

Le cas réel qui a ouvert ce ticket, copié du back-office, pour finir : ⟬person_name#1⟭,
⟬fr_postal_address#1⟭, ⟬payment_card#1⟭, ⟬fr_passport#1⟭.
⟬end⟭

⟬template⟭
family: docs
format: README .md
language: mixed
fill_locale: mixed
domain: logistics
appearance: markdown heading, prose, shell command, closing sentence
scenario: the address autocomplete, was rolled back
⟬text⟭
# address-autocomplete

Suggestions d'adresses pour le formulaire d'enlèvement. Rolled back to ⟬version#1⟭ on ⟬date#1⟭:
the new ranking model pushed foreign postcodes to the top of the list.

```sh
npm ci && npm run dev
```

To fetch the ranking model, run `huggingface-cli login` first. Le token de l'équipe reste
pour l'instant ici, en attendant le vault : ⟬huggingface_token#1⟭
⟬end⟭

⟬template⟭
family: docs
format: README .md
language: mixed
fill_locale: mixed
domain: SaaS
appearance: markdown headings, quoted log, prose, numbered list
scenario: the password reset flow, was fixed, and the fix is explained
⟬text⟭
# auth-reset

Service des liens de réinitialisation de mot de passe, appelé par `web-app` et par le support.

## Ce qui a été corrigé

Depuis ⟬version#1⟭, un lien de réinitialisation pouvait servir deux fois : le jeton n'était
invalidé qu'à l'expiration. It is now consumed in one transaction, in the same statement as the
password update. La version ⟬version#2⟭ contient le correctif.

The bug showed up because of this debug output, captured while the worker restarted in a loop.
Le debug est désactivé depuis, l'extrait reste ici le temps de la rotation :

```
DEBUG notifier: posting to chat.postMessage with ⟬slack_token#1⟭
DEBUG signer: loading material
⟬private_key#1⟭
WARN  reset-token ⟬uuid#1⟭ consumed twice within 12s
```

## Tests

1. Request a link with `make reset-link`.
2. Open it twice: the second call must return 410.
3. Check the audit event `reset.consumed`.

## Configuration

`RESET_TTL_MINUTES` vaut 30 par défaut. Don't raise it above 60 without asking security.
⟬end⟭

⟬template⟭
family: docs
format: README .md
language: mixed
fill_locale: mixed
domain: e-commerce
appearance: markdown heading, key-value lines, shell command, prose
scenario: the newsletter template, was flagged by an audit
⟬text⟭
# newsletter-mjml

L'audit RGPD du ⟬date#1⟭ a relevé que le gabarit n'a pas de lien de désinscription en un clic.

owner: ⟬trap:indicator_non_pii|growth-squad⟭
contact: ⟬trap:indicator_non_pii|marketing-ops⟭

```sh
npm run build -- --template promo
```

Fix tracked in ⟬ticket_id#1⟭: add `List-Unsubscribe` and a footer link to every template.
⟬end⟭

⟬template⟭
family: docs
format: commit message
language: mixed
fill_locale: mixed
domain: logistics
appearance: commit subject, prose, codeowners line
scenario: the quarterly planning, is explained to new hires
⟬text⟭
docs(planning): indiquer qui valide le planning trimestriel

Les nouveaux arrivants posaient tous la même question. La page d'accueil explique
désormais le cycle, et chaque changement du dossier passe par une seule revue :

    /planning/quarterly/  @⟬person_name:handle#1⟭

The wiki page for new hires links to this line of CODEOWNERS.
⟬end⟭

⟬template⟭
family: docs
format: README .md
language: mixed
fill_locale: mixed
domain: SaaS
appearance: markdown heading, prose, shell commands, heredoc
scenario: the data warehouse sync, moves to a new provider
⟬text⟭
# dwh-sync

Sync nocturne vers le nouvel entrepôt de données, chez ⟬company#1⟭ à partir du ⟬date#1⟭.

```sh
cat > ~/.ssh/dwh_ingest <<'EOF'
⟬private_key#1⟭
EOF
./sync.sh prod ⟬email#1⟭ "⟬phone#1⟭"
```

Rows go through the staging schema first. Compare the counts before you switch dashboards.
⟬end⟭

⟬template⟭
family: docs
format: wiki page
language: mixed
fill_locale: mixed
domain: banking
appearance: wiki heading, prose, shell command
scenario: the backup rotation, is planned for next quarter
⟬text⟭
h2. Rotation des sauvegardes : passage au schéma 3-2-1 au prochain trimestre

Les bandes hebdomadaires sont remplacées par un coffre objet immuable. Off-site copies move to
the second site on ⟬date#1⟭, and the monthly restore test stays as it is.

{code}
backupctl plan apply rotation-321 --approver "⟬person_name#1⟭" --report-to mail=⟬email#1⟭ --dry-run
{code}

Le rapport de simulation liste les jeux de sauvegarde sortants.
⟬end⟭

⟬template⟭
family: docs
format: commit message
language: mixed
fill_locale: mixed
domain: e-commerce
appearance: commit subject, bullet list, prose, commit trailer
scenario: the laptop replacement programme, is being retired
⟬text⟭
chore(it): retirer le programme de remplacement des portables de l'inventaire

The hardware refresh programme ends this quarter: `asset-sync` no longer creates replacement
orders, and the Service Desk team handles broken laptops case by case.

Removed:

- the `laptop-refresh` job in `asset-sync`
- le rapport mensuel envoyé à la direction des achats
- the `refresh_eligible` column from the inventory view
- the Slack reminder sent to each department

Kept:

- the warranty dates, used by Service Desk
- l'historique des remplacements, en lecture seule

Le budget restant repart vers le renouvellement des terminaux de caisse. Procurement and
Service Desk validated this in the steering committee of ⟬date#1⟭.

Reviewed: ⟬trap:initials|J.-P.⟭, ⟬trap:initials|MD⟭
Owner: ⟬trap:indicator_non_pii|service-desk⟭
Refs: ⟬ticket_id#1⟭
⟬end⟭
