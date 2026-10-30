⟬template⟭
family: config
format: .env
language: mixed
fill_locale: en_GB
domain: banking
appearance: comment, assignment, quoted value
scenario: currency rate cache of a private bank in London, French keys and English comments, reading a public feed, so no credential is needed and nothing is sensitive
⟬text⟭
# FX rate cache. The feed is public, there is no credential on purpose.
URL_FLUX_TAUX=⟬url#1⟭
DEVISE_BASE=GBP
DEVISES_SUIVIES=EUR,USD,CHF
DELAI_RAFRAICHISSEMENT_S=900
REFERENCE_FLUX=⟬uuid#1⟭
⟬trap:indicator_non_pii|CLE_API_REQUISE=false⟭
⟬trap:indicator_non_pii|AUTEUR_DERNIERE_MAJ=robot-taux⟭
DERNIERE_PUBLICATION="⟬date#1⟭"
⟬end⟭

⟬template⟭
family: config
format: .env
language: mixed
fill_locale: mixed
domain: logistics
appearance: comment, assignment, quoted value, code identifier
scenario: trial settings of a cross-Channel haulage link, French keys and English comments, listing two vehicles with their plates and drivers until the end of the trial
⟬text⟭
# Cross-Channel trial. Drivers agreed to be listed, remove them when the trial ends.
ESSAI_FIN="⟬date#1⟭"
VEHICULE_1_PLAQUE="⟬uk_license_plate#1⟭"
VEHICULE_1_CHAUFFEUR="⟬person_name#1⟭"
VEHICULE_1_TEL="⟬phone#1⟭"
VEHICULE_2_PLAQUE="⟬fr_license_plate#2⟭"
VEHICULE_2_CHAUFFEUR="⟬person_name#2⟭"
VEHICULE_2_TEL="⟬phone#2⟭"

# planning service
URL_PLANIFICATION=⟬url#1⟭
CLE_PLANIFICATION=⟬opaque_token#1⟭
CLE_CARTE=⟬google_api_key#1⟭
JETON_ALERTES=⟬slack_token#1⟭
MOTEUR_TRAJET=⟬trap:code_identifier|⦃Family⦄RouteOptimizer⟭
⟬trap:indicator_non_pii|TELEPHONE_OBLIGATOIRE=true⟭
⟬trap:indicator_non_pii|CONTACT=exploitation-transmanche⟭
⟬end⟭

⟬template⟭
family: config
format: .yaml
language: mixed
fill_locale: mixed
domain: SaaS
appearance: comment, YAML value, list item, nested mapping, distinguished name
scenario: Dex identity federation file of an admin console, English keys and French comments, client secrets, a database password and an LDAP bind that still uses an employee's name
⟬text⟭
# Dex : fédération d'identité de la console d'administration
issuer: ⟬url#1⟭
storage:
  type: postgres
  config:
    host: ⟬hostname#1⟭
    port: 5432
    database: dex
    user: dex
    password: "⟬password#1⟭"
    ssl:
      mode: verify-ca
connectors:
  - type: github
    id: github
    name: GitHub
    config:
      clientID: console-admin-sso
      clientSecret: ⟬opaque_token#1⟭
      redirectURI: ⟬url#2⟭
      orgs:
        - name: console-admin
  - type: ldap
    id: annuaire
    name: Annuaire interne
    config:
      host: ⟬hostname#2⟭:636
      # compte de liaison nominatif, ⟬person_name#3⟭ est au courant
      bindDN: "cn=⟬person_name#3⟭,ou=services,dc=console,dc=internal"
      bindPW: "⟬password#2⟭"
      userSearch:
        baseDN: ou=people,dc=console,dc=internal
        username: mail
staticClients:
  - id: console-web
    name: Console d'administration
    secret: ⟬opaque_token#2⟭
    redirectURIs:
      - ⟬url#3⟭
⟬end⟭

⟬template⟭
family: config
format: .yaml
language: mixed
fill_locale: en_US
domain: e-commerce
appearance: comment, YAML value, list item, code identifier
scenario: Prometheus alert rules of an American online grocery run from Lyon, English keys and French annotations, metrics named after a former developer and owners that are teams, no sensitive value
⟬text⟭
# Règles d'alerte de la boutique : tunnel de commande et paiement
# Relues après l'incident ⟬ticket_id#1⟭ du ⟬date#1⟭
groups:
  - name: tunnel-commande
    interval: 30s
    rules:
      - alert: LatenceCheckoutElevee
        expr: histogram_quantile(0.95, sum(rate(⟬trap:code_identifier|⦃family⦄_checkout_latency_seconds⟭_bucket[5m])) by (le)) > 1.5
        for: 10m
        labels:
          severity: warning
          ⟬trap:indicator_non_pii|owner: equipe-checkout⟭
        annotations:
          summary: "Le tunnel de commande ralentit"
          description: "p95 au-dessus de 1,5 s depuis 10 minutes"
          runbook_url: ⟬url#1⟭
      - alert: TauxErreurPaiement
        expr: sum(rate(paiement_erreurs_total[5m])) / sum(rate(paiement_tentatives_total[5m])) > 0.05
        for: 5m
        labels:
          severity: critical
          ⟬trap:indicator_non_pii|owner: equipe-paiement⟭
        annotations:
          summary: "Plus de 5 % de paiements en échec"
          description: "Vérifier le prestataire de carte avant de prévenir l'astreinte"
      - alert: PanierAbandonneHausse
        expr: increase(panier_abandons_total[1h]) > 500
        for: 30m
        labels:
          severity: info
          ⟬trap:indicator_non_pii|contact: canal-growth⟭
        annotations:
          summary: "Hausse des paniers abandonnés"
  - name: stocks
    interval: 1m
    rules:
      - alert: SynchroStocksEnRetard
        expr: time() - stock_derniere_synchro_timestamp > 1800
        for: 5m
        labels:
          severity: warning
          ⟬trap:indicator_non_pii|owner: equipe-supply⟭
        annotations:
          summary: "Stocks non synchronisés depuis 30 minutes"
          description: "Instance {{ $labels.instance }} en retard"
      - alert: FileCommandesSaturee
        expr: file_commandes_taille > 20000
        for: 10m
        labels:
          severity: critical
          ⟬trap:indicator_non_pii|owner: equipe-supply⟭
        annotations:
          summary: "File des commandes saturée"
  - name: securite
    interval: 1m
    rules:
      - alert: ⟬trap:indicator_non_pii|EchecsMotDePasseHausse⟭
        expr: rate(auth_password_failures_total[5m]) > 3
        for: 5m
        labels:
          severity: warning
          ⟬trap:indicator_non_pii|owner: equipe-securite⟭
        annotations:
          summary: "Trop d'échecs de mot de passe"
          description: "Possible bourrage d'identifiants sur {{ $labels.instance }}"
⟬end⟭

⟬template⟭
family: config
format: .yaml
language: mixed
fill_locale: fr_FR
domain: banking
appearance: comment, YAML value, quoted value, test fixture
scenario: fixture identities for remote account opening tests at a French bank, French keys and English comments, with identity documents, a tax number and the tester who owns the set
⟬text⟭
# Test identities for the remote account opening scenarios. Synthetic, owned by QA.
# Set owner: ⟬person_name#1⟭
identites:
  majeur_resident:
    civilite: Mme
    reference: "⟬customer_id#2⟭"
    nom: "⟬person_name#2f⟭"
    nee_le: "⟬birth_date#2⟭"
    piece: cni
    numero_piece: "⟬fr_identity_card#2⟭"
    numero_fiscal: "⟬fr_tax_number#2⟭"
    adresse: "⟬fr_postal_address#2⟭"
  majeur_passeport:
    civilite: M.
    nom: "⟬person_name#3m⟭"
    ne_le: "⟬birth_date#3⟭"
    piece: passeport
    numero_piece: "⟬fr_passport#3⟭"
    telephone: "⟬phone#3⟭"
  conducteur:
    nom: "⟬person_name#4⟭"
    permis: "⟬fr_driving_licence#4⟭"
fournisseur_verification:
  url: ⟬url#1⟭
  ref: ⟬opaque_token#1⟭
  valeur: "⟬password#1⟭"
⟬end⟭

⟬template⟭
family: config
format: .json
language: mixed
fill_locale: fr_FR
domain: SaaS
appearance: nested JSON, string value
scenario: env.json for running serverless billing functions locally, English keys and French function names, with a Stripe key and a table name
⟬text⟭
{
  "FonctionFacturation": {
    "STRIPE_KEY": "⟬stripe_secret_key#1⟭",
    "TABLE_FACTURES": "factures-dev",
    "SIG": "⟬opaque_token#1⟭"
  },
  "FonctionRelance": {
    "EXPEDITEUR": "⟬email:generic#2⟭",
    "DELAI_JOURS": "7"
  }
}
⟬end⟭

⟬template⟭
family: config
format: .json
language: mixed
fill_locale: mixed
domain: banking
appearance: nested JSON, string value, url, array
scenario: flat key-value dump of a payment platform's configuration store taken for an audit, French key paths and English note, values decoded, with secrets of every sort and the owner of the service
⟬text⟭
{
  "_note": "Config store dump for the audit, values decoded. Reviewed by ⟬trap:initials|JD⟭, delete afterwards.",
  "datacenter": "paris-1",
  "exported_at": "⟬date#1⟭",
  "entries": [
    {
      "key": "paiements/prod/base/hote",
      "flags": 0,
      "value": "⟬hostname#1⟭"
    },
    {
      "key": "paiements/prod/base/mot_de_passe",
      "flags": 0,
      "value": "⟬password#1⟭"
    },
    {
      "key": "paiements/prod/base/url_replique",
      "flags": 0,
      "value": "postgresql://lecture:⟬url_password#1⟭@⟬hostname#2⟭:5432/paiements"
    },
    {
      "key": "paiements/prod/acquereur/cle",
      "flags": 0,
      "value": "⟬stripe_secret_key#1⟭"
    },
    {
      "key": "paiements/prod/acquereur/ref",
      "flags": 1,
      "value": "⟬opaque_token#1⟭"
    },
    {
      "key": "paiements/prod/signature/cle_privee",
      "flags": 1,
      "value": "⟬private_key#1⟭"
    },
    {
      "key": "paiements/prod/alertes/jeton",
      "flags": 0,
      "value": "⟬slack_token#1⟭"
    },
    {
      "key": "paiements/prod/outillage/jeton_depot",
      "flags": 0,
      "value": "⟬github_token#1⟭"
    },
    {
      "key": "paiements/prod/agences/cle_carte",
      "flags": 0,
      "value": "⟬google_api_key#1⟭"
    },
    {
      "key": "paiements/prod/contacts/owner",
      "flags": 0,
      "value": "⟬person_name#2⟭"
    },
    {
      "key": "paiements/prod/contacts/owner_mail",
      "flags": 0,
      "value": "⟬email#2⟭"
    },
    {
      "key": "paiements/prod/contacts/astreinte",
      "flags": 0,
      "value": "⟬trap:indicator_non_pii|cellule-paiements⟭"
    },
    {
      "key": "paiements/prod/compte_technique/iban",
      "flags": 0,
      "value": "⟬iban#3⟭"
    },
    {
      "key": "paiements/prod/parametres/plafond",
      "flags": 0,
      "value": "50000"
    }
  ]
}
⟬end⟭

⟬template⟭
family: config
format: .json
language: mixed
fill_locale: fr_FR
domain: logistics
appearance: nested JSON, string value, array
scenario: Renovate configuration of a warehouse tooling repository, English keys and French descriptions, teams as reviewers, scoped packages and a token placeholder, nothing sensitive
⟬text⟭
{
  "$schema": "https://docs.renovatebot.com/renovate-schema.json",
  "extends": ["config:recommended"],
  "description": "Mises à jour des dépendances de l'outillage entrepôt",
  "timezone": "Europe/Paris",
  "schedule": ["before 6am on monday"],
  "reviewers": ["⟬trap:indicator_non_pii|team:outillage-entrepot⟭"],
  "assignees": ["⟬trap:indicator_non_pii|team:plateforme-logistique⟭"],
  "packageRules": [
    {
      "matchPackageNames": ["⟬trap:email_lookalike|@types/node⟭", "⟬trap:email_lookalike|@quaiflow/zpl⟭"],
      "groupName": "socle node",
      "automerge": false
    },
    {
      "matchUpdateTypes": ["patch"],
      "automerge": true
    }
  ],
  "hostRules": [
    {
      "matchHost": "⟬hostname#1⟭",
      "hostType": "npm",
      "token": "⟬trap:placeholder|{{ secrets.RENOVATE_NPM_TOKEN }}⟭"
    }
  ]
}
⟬end⟭

⟬template⟭
family: config
format: .properties
language: mixed
fill_locale: fr_FR
domain: e-commerce
appearance: comment, properties key, commented-out value
scenario: SAP Commerce local.properties of a French department store, English keys and French comments, an initial admin password, a payment key, and an old password pasted alone in a comment
⟬text⟭
# local.properties, recette du grand magasin
# repris par ⟬trap:initials|P.-A.⟭, le contact technique reste ⟬person_name#1⟭
db.url=jdbc:sqlserver://⟬hostname#1⟭:1433;databaseName=commerce
db.username=commerce_app
db.password=⟬password#1⟭
initialpassword.admin=⟬password#2⟭
# ancien mdp de la console : ⟬password#3⟭
mail.smtp.server=⟬hostname#2⟭
mail.smtp.user=⟬email:generic#2⟭
mail.smtp.password=⟬password#4⟭
payment.provider=stripe
payment.secret=⟬stripe_secret_key#1⟭
payment.ref=⟬opaque_token#1⟭
⟬trap:indicator_non_pii|customer.password.encoding=pbkdf2⟭
⟬trap:indicator_non_pii|customer.email.verification=true⟭
media.storage.url=https://medias:⟬url_password#1⟭@⟬hostname#3⟭/dav
storefront.name=Galerie ⟬trap:company_name|⦃Family⦄⟭
⟬end⟭

⟬template⟭
family: config
format: .properties
language: mixed
fill_locale: en_GB
domain: SaaS
appearance: comment, properties key
scenario: backup uploader credentials of a survey platform at a Glasgow customer, French keys and English comments, with the person responsible and a script named after a former developer
⟬text⟭
# backup uploader, Glasgow site
compte.stockage=⟬username#1⟭
cle.stockage=⟬opaque_token#1⟭
mot_de_passe.chiffrement=⟬password#1⟭
responsable=⟬person_name#2⟭
script=⟬trap:code_identifier|sauvegarde_⦃family⦄.sh⟭
frequence.heures=6
⟬end⟭
