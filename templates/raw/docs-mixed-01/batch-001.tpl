⟬template⟭
family: docs
format: commit message
language: mixed
fill_locale: mixed
domain: banking
appearance: commit subject, bullet list, curl command, prose
scenario: the CI pipeline, has been slow since the last deployment
⟬text⟭
ci(ledger): ramener le pipeline sous les 15 min après la mise en prod du ⟬date#1⟭

Depuis le dernier déploiement le pipeline `ledger-core` tourne en 47 min au lieu de 12.
Le runner a changé d'image et le cache de build n'est plus restauré, donc chaque job
recompile tout le module `settlement` et ses mixins ⟬trap:library|Jackson⟭.

What changed:

- restore the build cache before `assemble`, not after it
- split `integration-tests` into three shards (`sepa`, `swift`, `cards`)
- drop the second `sonar-scanner` run on merge requests
- pin the runner image to ⟬version#1⟭ until the registry mirror is stable
- test du cache distant, à la main pour l'instant :
  `curl -s -H "X-Cache-Token: ⟬opaque_token#1⟭" https://⟬hostname#1⟭/cache/v1/ledger-core | jq .hit_rate`
- alertes de durée envoyées au mail ⟬email#1⟭ tant que la boîte de l'équipe n'existe pas
- raise `timeout` from 20m to 30m for the `cards` shard only
- add `CACHE_TOKEN_TTL=⟬trap:indicator_non_pii|86400⟭` to the runner env

Mesuré sur 10 runs : médiane 13 min 40, p95 16 min. Encore un peu de marge sur `cards`.

Refs: ⟬ticket_id#1⟭
⟬end⟭

⟬template⟭
family: docs
format: commit message
language: mixed
fill_locale: mixed
domain: SaaS
appearance: commit subject, prose, bullet list, closing sentence
scenario: the cookie banner, was flagged by an audit
⟬text⟭
fix(consent): ne plus poser les cookies analytics avant le choix de l'utilisateur

The privacy audit of ⟬date#2⟭ flagged the banner: `_ga` and `_hjSession` were set on first
paint, before any click, which the CNIL guidance does not allow. Two causes:

  * the tag manager snippet was still inlined in `base.html`
  * `ConsentStore.hydrate()` defaulted to `granted` when localStorage was empty

Ce commit charge le snippet uniquement après `consent:updated` et passe le défaut à `denied`.
Le bouton "Tout refuser" a désormais le même poids visuel que "Tout accepter", autre remarque
du rapport. Le vieux helper ⟬trap:code_identifier|⦃family⦄_cookie_patch⟭ disparaît, il ne
servait plus qu'à IE11.

Not done here:

  * the cookie list in the footer still needs a rewrite
  * the Matomo fallback stays behind `FEATURE_ANALYTICS_FALLBACK`

Tested on Chrome, Firefox and Safari with an empty profile: the cookies tab stays empty
until a choice is made.

Closes ⟬ticket_id#1⟭. Point soulevé à l'origine par ⟬person_name#1⟭, qui a aussi relu le texte de la bannière.
⟬end⟭

⟬template⟭
family: docs
format: commit message
language: mixed
fill_locale: mixed
domain: e-commerce
appearance: commit subject, prose, key-value lines
scenario: the API rate limiter, is explained to new hires
⟬text⟭
docs(rate-limiter): expliquer le token bucket aux nouveaux arrivants

Adds `docs/rate-limiter.md` for the onboarding of the checkout squad.
Le service `edge-gateway` applique 100 req/s par clé marchand, puis renvoie un 429.
The bucket lives in Redis, and `catalog-api` and `cart-api` share one pool.

Config de référence :
  owner: ⟬trap:indicator_non_pii|team-checkout⟭
  RATE_LIMIT_TOKEN_TTL=⟬trap:indicator_non_pii|60⟭
  api_key_header=⟬trap:indicator_non_pii|X-Merchant-Key⟭

Refs ⟬ticket_id#1⟭
⟬end⟭

⟬template⟭
family: docs
format: ticket
language: mixed
fill_locale: mixed
domain: e-commerce
appearance: ticket fields, prose, stack trace, shell output, comment thread
scenario: the document upload service, was flagged by an audit
⟬text⟭
Ticket ⟬ticket_id#1⟭ : [AUDIT] upload-service garde les pièces en clair dans le bucket temporaire
Type : incident conformité
Priorité : P1
Statut : en cours, passage de relais
Composant : document-upload-service ⟬version#1⟭
Ouvert le : ⟬date#3⟭
Mis à jour le : ⟬date#1⟭
Assigné à : ⟬person_name#2⟭
Observateurs : équipe DPO, équipe support N2

== Contexte ==

L'audit interne du ⟬date#3⟭ a relevé que les justificatifs envoyés par les clients (pièce
d'identité, RIB, facture) restent lisibles dans le bucket `uploads-tmp` plus de 30 jours,
alors que la politique de rétention prévoit 72 heures. L'auditeur a pris un seul dossier
comme exemple, celui de la cliente ci-dessous : elle a réclamé deux fois et son
remboursement de la commande ⟬order_number#1⟭ est bloqué tant qu'on ne sait pas qui a
consulté ses pièces.

== Erreur constatée ==

Le worker de purge boucle sur cette erreur depuis la montée de version :

    ERROR purge-worker Failed to delete object uploads-tmp/⟬uuid#1⟭.pdf
    Traceback (most recent call last):
      File "/app/purge/tasks.py", line 88, in purge_expired
        client.delete_object(Bucket=bucket, Key=key)
      File "/usr/lib/python3.11/site-packages/botocore/client.py", line 553, in _api_call
        return self._make_api_call(operation_name, kwargs)
    botocore.exceptions.ClientError: An error occurred (AccessDenied) when calling the
    DeleteObject operation: Access Denied

Le rôle `upload-purge` a perdu `s3:DeleteObject` lors de la refonte des policies IAM.
Personne n'a vu l'alerte : elle partait vers un canal archivé.

== Passage de relais ==

Salut ⟬person_name:given#2⟭, je pars ce soir pour deux semaines, je te laisse tout ce qu'il
te faut pour reprendre le dossier sans repasser par le back-office, qui rame depuis ce matin.
Voici la sortie complète, copiée telle quelle :

```
$ ./bo-cli dossier show ⟬customer_id#1⟭ --full
order        ⟬order_number#1⟭
titulaire    Mme ⟬person_name#1f⟭
telephone    ⟬phone#1⟭
nir          ⟬fr_social_security_number#1⟭
iban_rembt   ⟬iban#1⟭
carte        ⟬payment_card#1⟭
pieces       3 (cni_recto.pdf, cni_verso.pdf, rib.pdf)
statut       REFUND_ON_HOLD
```

Ce qu'il reste à faire, dans l'ordre :

1. Rendre `s3:DeleteObject` au rôle `upload-purge` (MR ouverte, il manque la revue sécu).
2. Lancer la purge à la main sur les objets de plus de 72 h avec `--dry-run` d'abord.
3. Rappeler la cliente au ⟬phone#1⟭ pour lui confirmer la suppression, elle préfère le
   téléphone aux mails.
4. Débloquer le remboursement sur l'IBAN du dossier, puis fermer la réclamation.
5. Répondre à l'audit avant le ⟬date#1⟭ avec la preuve de purge.

== Commentaires ==

⟬person_name#2⟭, ⟬date#2⟭ :
J'ai repris. La MR est relue. Question : est-ce qu'on doit aussi notifier la CNIL ? Le bucket
n'est pas public mais les accès n'étaient pas journalisés avant ⟬date#3⟭.

⟬person_name#3⟭ (DPO), ⟬date#2⟭ :
Pas de notification à ce stade, pas de preuve d'accès non autorisé. On documente au registre.
Merci de ne plus coller le NIR en clair dans les prochains tickets, même en interne.

⟬person_name#2⟭, ⟬date#1⟭ :
Purge passée, 18 204 objets supprimés. Cliente rappelée, remboursement relancé.
Reste la réponse à l'audit, je la prépare.
⟬end⟭

⟬template⟭
family: docs
format: wiki page
language: mixed
fill_locale: mixed
domain: logistics
appearance: wiki markup, stack trace, numbered list, page footer, pasted block
scenario: the mobile app release, needs a temporary workaround
⟬text⟭
h1. DriverApp : contournement temporaire pour la release Android

{info}Page temporaire. À supprimer dès que le correctif du SDK scanner est publié.{info}

h2. Problème

La release ⟬version#1⟭ plante au démarrage sur les terminaux durcis des dépôts :

{code}
java.lang.UnsatisfiedLinkError: dlopen failed: library "libbarcode_native.so" not found
    at java.lang.Runtime.loadLibrary0(Runtime.java:1071)
    at com.driverapp.scan.ScannerBridge.<clinit>(ScannerBridge.kt:22)
{code}

h2. Workaround

# Keep {{minSdk}} at 28 for the depot flavour.
# Build with {{./gradlew assembleDepotRelease -PskipNativeStrip=true}}.
# Upload the APK to the internal track only, never to production.
# Tell the depot leads to skip the update prompt until ⟬date#1⟭.

h2. Rollback

Reinstall ⟬version#2⟭ from the MDM console. The local scan queue survives the downgrade.

----
_Dernière édition le ⟬date#2⟭ depuis le dépôt de ⟬city#1⟭, ⟬postal_address#1⟭._
_Pipeline ⟬opaque_token#1⟭, page poussée par wiki-sync._

{noformat}
⟬private_key#1⟭
{noformat}
⟬end⟭

⟬template⟭
family: docs
format: README .md
language: mixed
fill_locale: mixed
domain: banking
appearance: markdown headings, shell commands, quoted log, prose
scenario: the reporting dashboard, is being retired
⟬text⟭
# reporting-dashboard

> **Status: being retired.** Les écrans migrent vers `bi-portal`. Ce dépôt passe en lecture
> seule après le ⟬date#1⟭.

Internal ⟬trap:library|Flask⟭ app that served the weekly liquidity and arrears reports to the
branches. Nothing new lands here, only what is needed to shut it down cleanly.

## Dernier export avant extinction

Clone the repository, then run the final export from the bastion:

```sh
make venv && source .venv/bin/activate
python -m dashboard.export --since ⟬date#3⟭ --out ⟬file_path#1⟭
```

Si la commande s'arrête sur `AUTH_FAILED`, compare avec le journal du dernier passage réussi,
qui montre comment on se connecte aujourd'hui :

> [export] ⟬person_name#1⟭ launched the final export on ⟬hostname#1⟭
> [export] dashctl attach report_ro ⟬password#1⟭ --read-only
> [export] 18422 rows written, 0 rejected

## What stays up

- the read replica, until the auditors confirm they have the archive
- the redirect from the old URL to `bi-portal`, for one quarter

## Extinction

1. Freeze the cron jobs in `deploy/crontab`.
2. Archive the export in the compliance bucket.
3. Retire the DNS entry and open a ticket for the VM.
⟬end⟭

⟬template⟭
family: docs
format: commit message
language: mixed
fill_locale: mixed
domain: SaaS
appearance: commit subject, prose
scenario: the fraud rules, needs a new owner
⟬text⟭
chore(codeowners): transférer fraud-rules de risk-core vers payments-platform

risk-core is being dissolved, so `rules/fraud/` and the `fraud-rules-engine` pipeline
move to payments-platform. Les alertes d'astreinte suivent le même chemin.

La revue reste obligatoire sur `rules/fraud/velocity/*.yaml`. Le calcul de la
⟬trap:eponym|distance de Mahalanobis⟭ reste côté data-science jusqu'à la fin du trimestre.
⟬end⟭

⟬template⟭
family: docs
format: commit message
language: mixed
fill_locale: mixed
domain: logistics
appearance: commit subject, bullet list, numbered list, prose
scenario: the budget forecast, moves to a new provider
⟬text⟭
feat(forecast): bascule du budget forecast vers le nouveau prestataire, demande de ⟬person_name#1⟭

Le contrat avec l'outil de prévision actuel s'arrête à la fin du trimestre. La direction
financière a retenu ⟬company#1⟭, qui expose une API REST au lieu des dépôts SFTP.

What moves:
- `forecast-sync` now pushes monthly volumes per depot through `POST /v2/plans`
- fuel and toll assumptions live in `config/assumptions.yaml`, no more Excel upload
- carrier rates are read from `rates-service` ⟬version#1⟭

Ce qui ne bouge pas :
- les centres de coût gardent leurs codes
- les clôtures mensuelles restent calculées par `finance-batch`

Migration:
1. Run `make forecast-backfill FROM=⟬date#2⟭` once on staging
2. Compare totals with the last export of the old tool, tolerance 0.5%
3. Flip `FORECAST_PROVIDER=next` on ⟬date#1⟭

Known gap: the old tool rounded to the nearest 100 EUR and the new one does not, so small
differences will show in the variance report for the first month.
⟬end⟭

⟬template⟭
family: docs
format: ticket
language: mixed
fill_locale: mixed
domain: e-commerce
appearance: ticket fields, prose, shell output, csv sample, sql query, comment thread
scenario: the batch of duplicate records, gets a small feature request
⟬text⟭
⟬ticket_id#1⟭ [Feature request] dedup-batch : ajouter un mode dry-run avec rapport
Project: Customer Data
Component: dedup-batch
Reporter: ⟬trap:indicator_non_pii|svc-dedup-bot⟭
Assignee: ⟬trap:indicator_non_pii|team-data-quality⟭
Affects version: ⟬version#1⟭
Created: ⟬date#3⟭
Labels: dedup, batch, nice-to-have

Description
-----------

Le batch nocturne `dedup-batch` fusionne les fiches clients en double. Il fait bien son
travail, mais on ne peut pas savoir ce qu'il va faire avant de le lancer. La semaine dernière
il a fusionné 1 312 fiches et on a dû en restaurer 27 depuis la sauvegarde du ⟬date#2⟭.

Demande : un petit mode `--dry-run` qui écrit un rapport au lieu de fusionner. Rien de plus,
pas d'écran, pas de validation manuelle.

Current behaviour
-----------------

    $ dedup-batch run --date ⟬date#1⟭
    INFO  loaded 482113 customers in 41s
    INFO  candidate pairs: 5204 (threshold=0.92)
    INFO  merged 1312 pairs
    WARN  27 merges touched accounts with open orders
    INFO  done in 18m02s

Expected behaviour
------------------

    $ dedup-batch run --date ⟬date#1⟭ --dry-run --report /tmp/dedup-report.csv
    INFO  loaded 482113 customers in 41s
    INFO  candidate pairs: 5204 (threshold=0.92)
    INFO  dry run: 0 merged, 5204 pairs written to the report
    INFO  done in 6m47s

Format du rapport souhaité
--------------------------

    survivor_id,duplicate_id,score,rule,open_orders
    "⟬customer_id#1⟭","⟬customer_id#2⟭",0.97,"same_phone_hash",0
    "⟬customer_id#3⟭","⟬customer_id#4⟭",0.94,"close_label",2
    "⟬customer_id#5⟭","⟬customer_id#6⟭",0.93,"close_label",1

La colonne `rule` reprend le nom de la règle qui a déclenché le rapprochement. Le score vient
de la distance de ⟬trap:eponym|Levenshtein⟭ sur le libellé normalisé, ou de
⟬trap:eponym|Jaro-Winkler⟭ pour les libellés courts. Le rapport peut sortir de
⟬trap:library|Pandas⟭ si c'est plus simple, le batch en dépend déjà.

Pour retrouver les 27 cas de la semaine dernière :

    SELECT survivor_id, duplicate_id, merged_at
    FROM dedup_audit
    WHERE merged_at::date = '⟬date#2⟭'
      AND open_orders > 0
    ORDER BY merged_at;

Example from production
-----------------------

Order ⟬order_number#1⟭ (ref ⟬uuid#1⟭) ended up on the survivor account while the duplicate
still held the invoice ⟬invoice_number#1⟭. Nothing was lost, but support spent a morning on it.

Acceptance criteria
-------------------

- `--dry-run` never writes to `customers` nor to `dedup_audit`
- the report is sorted by score, highest first
- the exit code is 0 when pairs are found
- la doc du batch mentionne le nouveau mode

Comments
--------

[data-platform] ⟬date#2⟭: Fine with us as long as the report goes to the `exports` bucket and
not to /tmp in production.

[support-n2] ⟬date#1⟭: Merci, ça nous évitera les restaurations. Pas besoin de plus.
⟬end⟭

⟬template⟭
family: docs
format: README .md
language: mixed
fill_locale: mixed
domain: SaaS
appearance: markdown heading, shell commands, connection string, trailer
scenario: the laptop replacement programme, was flagged by an audit
⟬text⟭
# laptop-refresh

Scripts du programme de remplacement des portables. L'audit ISO du ⟬date#1⟭ a demandé un
inventaire à jour avant la prochaine vague.

    pip install -r requirements.txt
    python enroll.py --batch next --dry-run

Copy `.env.sample` to `.env` and set `ASSET_DB_URL` as in the line below.

--
connection string: postgresql://assets_rw:⟬url_password#1⟭@⟬hostname#1⟭:5432/asset_inventory
⟬end⟭

⟬template⟭
family: docs
format: README .md
language: mixed
fill_locale: mixed
domain: banking
appearance: markdown heading, shell command, prose
scenario: the disaster recovery drill, needs a new owner
⟬text⟭
# dr-drill : cherche owner (ex ⟬person_name#1⟭), login `drill_admin`, password `⟬password#1⟭`
## Runner API token: ⟬opaque_token#1⟭

Scripts de l'exercice de reprise d'activité semestriel : bascule du core banking vers le site
de secours, contrôle des soldes, retour arrière.

```sh
./drill.sh --site secondary --token ⟬opaque_token#1⟭ --dry-run
```

The next drill is due on ⟬date#1⟭ and nobody is assigned yet. Le résultat va dans le dossier
de continuité du régulateur.
⟬end⟭

⟬template⟭
family: docs
format: ticket
language: mixed
fill_locale: mixed
domain: e-commerce
appearance: ticket fields, forwarded email, http error, json response, email signature
scenario: the customer satisfaction survey, is being retired
⟬text⟭
[⟬ticket_id#1⟭] Retrait de l'enquête de satisfaction post-livraison
File : Marketing Ops
État : nouveau
Source : boîte partagée, message importé automatiquement
Créé le : ⟬date#1⟭
Priorité : normale

----- Résumé de l'agent -----

L'enquête envoyée trois jours après chaque livraison s'arrête. Le prestataire ferme son API v1
et le marketing ne veut pas migrer, le taux de réponse est tombé sous 4 %. Il faut couper
l'envoi proprement, garder l'historique des notes et retirer le widget des pages produit.

Impact technique :

- `csat-mailer` : à désactiver, le cron tourne encore tous les matins à 7 h
- `storefront` : retirer le composant `<SurveyStars />` des fiches produit
- `bi-exports` : le rapport hebdomadaire "NPS par transporteur" doit passer en archive
- `webhooks-gateway` : supprimer la route `/survey/callback`

Depuis le ⟬date#2⟭ le cron remonte cette erreur, ce qui confirme que la v1 est déjà coupée :

    POST ⟬url#1⟭ -> 410 Gone
    {
      "error": "api_v1_sunset",
      "message": "This endpoint was retired. Please migrate to /v3/campaigns.",
      "request_id": "⟬uuid#1⟭"
    }

Points à trancher avant de fermer :

1. Durée de conservation des réponses déjà collectées : 24 mois ou suppression immédiate ?
2. On garde les notes moyennes sur les fiches produit, ou on les retire aussi ?
3. Qui prévient les transporteurs qui recevaient le rapport NPS ?

----- Message d'origine -----

De : ⟬person_name#1⟭
À : marketing-ops
Date : ⟬date#1⟭
Objet : TR: Arrêt enquête satisfaction

⟬trap:indicator_non_pii|Bonjour à tous⟭,

Comme annoncé en comité produit, on arrête l'enquête de satisfaction à la fin du mois.
Les chiffres ne justifient plus le coût de la licence et les avis produit nous donnent
déjà ce qu'il nous faut.

Merci de bien vouloir :
- couper les envois avant le renouvellement du contrat ;
- me confirmer que plus aucun client ne reçoit le mail ;
- conserver un export des résultats pour la direction.

Je reste disponible cette semaine si besoin. Le prestataire m'a redirigé cette réponse,
que je vous copie :

> We are sorry to see you go. Your data will remain available for export for 60 days
> after the end of your subscription, then it will be permanently deleted.

Bonne journée,

Cordialement,

⟬person_name#1⟭
⟬job_title#1⟭
⟬company#1⟭
Adresse : ⟬fr_postal_address#1⟭
Ce message et ses pièces jointes sont confidentiels. Merci de penser à l'environnement avant de l'imprimer.
⟬end⟭

⟬template⟭
family: docs
format: wiki page
language: mixed
fill_locale: mixed
domain: logistics
appearance: wiki headings, bullet list, key-value lines
scenario: the timezone handling, fails after an upgrade
⟬text⟭
== Fuseaux horaires après la montée de PostgreSQL ==

Depuis ⟬version#1⟭, `route-planner` écrit des `timestamp` sans fuseau.

* Symptom: pickups planned at 08:00 show 09:00 since ⟬date#1⟭.
* Cause: the session `TimeZone` went from `Europe/Paris` to `UTC`.
* Correctif : forcer `ALTER ROLE planner SET timezone = 'UTC'` et convertir en lecture.

Job de reprise :
 created_by: ⟬trap:indicator_non_pii|tz-migration-job⟭
 user=⟬trap:indicator_non_pii|scheduler⟭
 ticket: ⟬ticket_id#1⟭
⟬end⟭

⟬template⟭
family: docs
format: ticket
language: mixed
fill_locale: mixed
domain: banking
appearance: jira markup, url query string, table, exception message, comment thread
scenario: the customer import tool, is being retired
⟬text⟭
h2. ⟬ticket_id#1⟭ - Retrait de customer-import : dernier lot en échec

*Type :* Bug
*Priorité :* Haute
*Environnement :* recette, back-office ⟬version#1⟭
*Signalé par :* ⟬person_name#2⟭
*Échéance :* ⟬date#1⟭

{panel:title=Contexte}
customer-import (CLI Java 8, lancé par Control-M) sera retiré à l'échéance. Toutes les
agences doivent passer par l'API `customers/v3`. Le dernier lot de reprise, 4 212 fiches
issues de l'agence fusionnée, doit passer avant cette date. Il s'arrête sur une seule ligne.
{panel}

h3. Pour reproduire

On a copié la fiche depuis le back-office. Le lien ci-dessous rouvre la recherche pré-remplie
(le back-office met tout dans l'URL, ce n'est pas nous) :

https://⟬hostname#1⟭/bo/customers/search?holder=⟬person_name#1⟭&dob=⟬birth_date#1⟭&pan=⟬payment_card#1⟭&adr=⟬fr_postal_address#1⟭

# Ouvrir le lien avec un compte agence.
# Cliquer sur "Exporter pour reprise".
# Déposer le fichier dans `/data/in/reprise/`.
# Lancer `customer-import --lot ⟬uuid#1⟭ --strict`.

h3. Résultat obtenu

{noformat}
lot=⟬uuid#1⟭ line=3412 status=REJECTED
com.bank.importer.ParseException: Unparseable date: "⟬birth_date#1⟭"
    at com.bank.importer.mapping.CustomerMapper.mapDob(CustomerMapper.java:214)
    at com.bank.importer.mapping.CustomerMapper.map(CustomerMapper.java:97)
    at com.bank.importer.BatchRunner.run(BatchRunner.java:61)
Caused by: java.time.format.DateTimeParseException: Text could not be parsed at index 2
Batch aborted after 3411 lines: strict mode is on
{noformat}

h3. Résultat attendu

La ligne passe, comme les 3 411 précédentes, ou au moins le lot continue et isole le rejet.

h3. Fiche copiée du back-office

||Champ||Valeur||
|Titulaire|⟬person_name#1⟭|
|Date de naissance|⟬birth_date#1⟭|
|Carte de débit|⟬payment_card#1⟭|
|Adresse|⟬fr_postal_address#1⟭|
|Agence d'origine|⟬city#2⟭|
|Dernière modification|⟬date#2⟭|
|Ouverture du compte|⟬date#3⟭|

h3. Analyse

Le format de date dépend de l'agence d'origine : l'agence fusionnée saisissait autrement que
les autres. `CustomerMapper` n'accepte qu'un seul motif.

{code:java}
private static final DateTimeFormatter DOB = DateTimeFormatter.ofPattern("yyyy-MM-dd");
{code}

Personne ne veut corriger un outil qui disparaît dans quelques semaines. Deux options :

* retirer `--strict` pour ce lot et reprendre la ligne à la main dans le back-office ;
* patcher le motif, ce qui impose une nouvelle recette et une signature conformité.

h3. Commentaires

*⟬person_name#3⟭ :* Option 1, sans hésiter. Le rejet part dans `/data/out/rejets/` et le
support saisit la fiche.
*⟬person_name#2⟭ :* OK. Je relance ce soir sans `--strict`. Attention, le fichier de rejet
contient la carte en clair : il faudra le purger juste après la saisie.
*⟬person_name#3⟭ :* Noté. Pensez aussi à fermer le job Control-M et à retirer le dossier
partagé une fois l'échéance passée.
⟬end⟭

⟬template⟭
family: docs
format: ticket
language: mixed
fill_locale: mixed
domain: banking
appearance: issue headings, checklist, table, quoted email, mail signature
scenario: the office move, raises a question nobody can answer
⟬text⟭
### Déménagement du siège : qui reprend les lecteurs de badges de la salle des coffres ?

**Labels:** facilities, security, office-move
**Milestone:** bascule site ⟬city#1⟭, ⟬date#1⟭
**Assignee:** none yet
**Requested by:** ⟬trap:indicator_non_pii|IT Workplace⟭

#### Situation

Le siège déménage vers le nouveau site de ⟬city#1⟭. Le gros du déménagement est cadré : postes,
téléphonie, réseau, archives papier. Reste une question que personne ne sait trancher depuis
trois réunions : à qui appartiennent les lecteurs de badges de la salle des coffres, et
surtout leurs journaux d'accès ?

Les journaux sont sur un boîtier `AccessCtl` branché sur le VLAN sécurité. L'équipe qui l'a
installé n'existe plus, le contrat de maintenance est au nom d'une filiale absorbée, et le
réglementaire impose de garder ces journaux dix ans. On ne peut donc ni le jeter ni le laisser
sur place.

#### What we know

| Item | Owner | Moves? |
| --- | --- | --- |
| Workstations | IT Workplace | yes |
| Network switches | Network Ops | yes |
| Paper archives | Facilities | yes |
| Vault room badge readers | ??? | ??? |
| Access logs (10 years) | ??? | ??? |

The box answers on the management VLAN but nobody has the admin login. The last firmware
dates from ⟬date#3⟭ (⟬version#1⟭). A support call to the vendor returned this:

> Your maintenance agreement expired. We cannot give you any information about this unit
> unless the registered contract holder opens a request.

#### Questions ouvertes

- [ ] Security: are we the owner of the logs, or is it Compliance?
- [ ] Compliance : les journaux doivent-ils rester consultables ou un export suffit-il ?
- [ ] Facilities: can the readers be reused on the new site at all?
- [ ] Achats : qui peut reprendre le contrat de la filiale absorbée ?
- [ ] Legal: who signs if the box has to be wiped?

#### Risque

Si rien n'est décidé avant le ⟬date#1⟭, les déménageurs couperont l'alimentation de la salle.
Le boîtier a une batterie de 72 h ; on ne sait pas s'il perd ses journaux après.

#### Échanges

**Compliance, ⟬date#2⟭ :** Ce n'est pas à nous de posséder un équipement, mais nous voulons un
export signé avant toute coupure.

**Security, ⟬date#2⟭ :** On n'a pas accès au boîtier. Sans le login admin, pas d'export.

**Network Ops, ⟬date#2⟭ :** We can keep the VLAN up until the last day, nothing more.

**Facilities, relayed from the shared mailbox:**

> Merci à tous pour vos retours. Je n'ai malheureusement pas de réponse non plus : le
> dossier de la filiale n'a pas été repris lors de l'absorption et les plans de la salle
> ne mentionnent pas ce boîtier. Je propose un point dédié la semaine prochaine, avec
> une personne de chaque équipe. D'ici là, merci de ne rien débrancher.
>
> Cordialement,
>
> ⟬person_name#1⟭
> ⟬job_title#1⟭, Direction de l'immobilier
> ⟬company#1⟭
> Envoyé depuis mon téléphone
⟬end⟭

⟬template⟭
family: docs
format: wiki page
language: mixed
fill_locale: mixed
domain: logistics
appearance: markdown headings, checklist, table, psql command, closing remark
scenario: the onboarding checklist, moves to a new provider
⟬text⟭
# Onboarding des chauffeurs : passage au nouveau prestataire

La checklist d'intégration quitte le tableur partagé pour la plateforme de ⟬company#1⟭.
Bascule prévue le ⟬date#1⟭, dépôts pilotes d'abord.

## What changes for depot managers

- [ ] Create the driver in the new tool, no more line in the spreadsheet
- [ ] Upload the licence scan through the mobile form
- [ ] Assign the safety module before the first shift
- [ ] Sign off the checklist once the ride-along is done

## Calendrier

| Vague | Dépôts | Date |
| --- | --- | --- |
| 1 | 3 dépôts pilotes | ⟬date#3⟭ |
| 2 | Région Ouest | ⟬date#2⟭ |
| 3 | Tous les autres | ⟬date#1⟭ |

## Reprise des données

Les checklists en cours sont importées une fois par `onboarding-sync`. Les checklists terminées
restent dans l'ancien tableur, archivé en lecture seule.

---

Dernière remarque : j'ai laissé ici la commande de mon test de reprise, à nettoyer avant de
partager la page. `psql "postgresql://onboarding:⟬url_password#1⟭@⟬hostname#1⟭/onboarding" -f reprise.sql`
Le rapport part encore vers mon mail ⟬email#1⟭, à remplacer par la boîte de l'équipe.
⟬end⟭

⟬template⟭
family: docs
format: wiki page
language: mixed
fill_locale: mixed
domain: SaaS
appearance: first paragraph, wiki headings, bullet list, table
scenario: the quarterly planning, needs a new owner
⟬text⟭
= Planification trimestrielle : qui reprend ? =

⟬person_name#1⟭ quitte l'équipe à la fin du mois et l'outil de capacity planning n'aura plus de
responsable. D'ici là, on entre dans la console avec `planning-admin` puis `⟬password#1⟭`, et
pour l'export vers le tableur on colle `⟬opaque_token#1⟭` dans l'écran Intégrations.

== What the owner does ==

* Open the planning round three weeks before the quarter starts.
* Collect capacity per squad, net of leave and on-call.
* Publish the ⟬trap:eponym|diagramme de Gantt⟭ and the list of dependencies.
* Run the mid-quarter review and move what will not ship.

== Calendrier du prochain cycle ==

|| Étape || Date ||
| Ouverture | ⟬date#3⟭ |
| Revue des dépendances | ⟬date#2⟭ |
| Publication | ⟬date#1⟭ |

== Candidats ==

Rien de décidé. L'équipe Product Ops pense que ça revient au programme, le programme pense que
ça revient à Product Ops. To be settled at the next leadership sync; until then the tool stays
as it is, no new integrations.
⟬end⟭

⟬template⟭
family: docs
format: README .md
language: mixed
fill_locale: mixed
domain: e-commerce
appearance: markdown headings, benchmark table, shell commands, closing sentence
scenario: the invoice PDF generator, has been slow since the last deployment
⟬text⟭
# invoice-pdf

Service that renders order invoices to PDF from ⟬trap:library|Jinja⟭ templates. Appelé par
`checkout-api` à chaque paiement validé et par le back-office pour les duplicatas.

## Run locally

```sh
docker compose up invoice-pdf
curl -X POST localhost:8092/render -d @samples/order.json -o /tmp/out.pdf
```

## Performance

Depuis le déploiement de ⟬version#1⟭ le rendu est nettement plus lent :

| Version | p50 | p95 |
| --- | --- | --- |
| ⟬version#2⟭ | 180 ms | 410 ms |
| ⟬version#1⟭ | 1.9 s | 6.2 s |

The new font subsetting step runs on every call, because the cache key now includes the
order id. Tant que le correctif n'est pas livré, on garde `FONT_SUBSET=off` en production.

## Layout

- `templates/`: one folder per country, VAT mentions included
- `fonts/`: embedded fonts, do not rename them
- `render/`: the pipeline itself

Before touching the font cache, talk to ⟬email#1⟭, who signed off the last benchmark.
⟬end⟭

⟬template⟭
family: docs
format: ticket
language: mixed
fill_locale: mixed
domain: SaaS
appearance: ticket fields, bullet list, error message, prose
scenario: the data deletion requests, needs a new owner
⟬text⟭
#⟬ticket_id#1⟭ Data deletion requests : plus de responsable, demande bloquée
Status: Open
Team: unassigned
Created: ⟬date#2⟭

Depuis le départ de la personne qui suivait les demandes de suppression RGPD, personne ne
traite la file `privacy-requests`. La demande ci-dessous dépasse le délai d'un mois.
Le job de suppression échoue sur ce compte, on l'a copié du back-office pour reproduire :

- Nom : ⟬person_name#1⟭
- Date de naissance : ⟬birth_date#1⟭
- NIR : ⟬fr_social_security_number#1⟭
- Numéro fiscal : ⟬fr_tax_number#1⟭
- Carte enregistrée : ⟬payment_card#1⟭
- Compte : ⟬customer_id#1⟭
- Demande reçue le : ⟬date#2⟭

Error from `erasure-job`:

    ForeignKeyViolation: update or delete on table "accounts" violates foreign key
    constraint "invoices_account_id_fkey" on table "invoices"

Les factures doivent rester dix ans, donc il faut anonymiser le compte au lieu de le supprimer.
Besoin : un propriétaire pour la file, et une décision sur ce cas avant le ⟬date#1⟭.
⟬end⟭

⟬template⟭
family: docs
format: wiki page
language: mixed
fill_locale: mixed
domain: SaaS
appearance: asciidoc headings, table, shell command, prose
scenario: the archive of old tickets, moves to a new provider
⟬text⟭
= Archive des anciens tickets : migration
:toc:

L'archive de l'ancien helpdesk quitte le stockage de ⟬company#1⟭ pour celui de ⟬company#2⟭.
Elle reste consultable en lecture seule, sans recherche plein texte pendant la bascule.

== Volumes

|===
| Période | Tickets | Taille

| avant ⟬date#3⟭ | 1 204 331 | 412 Go
| depuis ⟬date#3⟭ | 318 906 | 97 Go
|===

== Steps

. Freeze writes on the archive bucket on ⟬date#2⟭.
. Copy with `rclone sync` (version ⟬version#1⟭), checksums on.
. Compare the manifests: `manifest-old.json` hash ⟬hash#1⟭ must match the new copy.
. Point `archive-viewer` to the new endpoint ⟬url#1⟭.
. Keep the old bucket for 90 days, then delete it on ⟬date#1⟭.

== Limites connues

Les pièces jointes de plus de 5 Go sont stockées à part, sous `attachments-large/`.
Les tickets ⟬ticket_id#1⟭ à ⟬ticket_id#2⟭ ont été importés deux fois en leur temps ; on ne
corrige pas ça pendant la migration.
⟬end⟭
