⟬template⟭
family: config
format: .env
language: mixed
fill_locale: fr_FR
domain: e-commerce
appearance: comment, assignment, quoted value
scenario: .env.local of a French sportswear shop, English keys with French comments, where the developer thanks a colleague by first name for the Stripe keys
⟬text⟭
# .env.local de la boutique, à ne jamais pousser
# clés récupérées auprès de ⟬person_name:given#1f⟭, merci à elle
SHOP_LOCALE=fr-FR
SHOP_CURRENCY=EUR
STRIPE_SECRET_KEY=⟬stripe_secret_key#2⟭
STRIPE_PUBLISHABLE_KEY=⟬stripe_publishable_key#2⟭
STRIPE_WEBHOOK_SECRET=⟬opaque_token#1⟭
GOOGLE_PLACES_KEY=⟬google_api_key#1⟭
# point relais utilisé par défaut dans le tunnel d'achat
DEFAULT_PICKUP_CITY="⟬city#3⟭"
SUPPORT_MAILBOX=⟬email:generic#4⟭
⟬end⟭

⟬template⟭
family: config
format: .env
language: mixed
fill_locale: en_GB
domain: banking
appearance: comment, assignment, url, quoted value
scenario: pre-production environment of the London branch payment gateway of a French bank, French variable names inherited from head office with English comments and UK data, including a signing key on one line
⟬text⟭
# Payment gateway, London branch (pre-production).
# Variable names come from the Paris head office template, do not rename them.
# Key rotation owner: ⟬person_name#1⟭, out-of-hours ⟬phone#1⟭
ENVIRONNEMENT=preprod
URL_BASE_PAIEMENTS=⟬url#1⟭
BASE_DONNEES_URL=postgresql://paiements:⟬url_password#1⟭@⟬hostname#1⟭:5432/paiements
COMPTE_TECHNIQUE=⟬username#1⟭
MOT_DE_PASSE_TECHNIQUE=⟬password#1⟭

# pain.001 signing key, newlines escaped by the deploy script
CLE_SIGNATURE_PRIVEE="⟬private_key#1⟭"
EMPREINTE_CERTIFICAT=⟬hash#1⟭

# settlement account of the branch
IBAN_COMPTE_PIVOT=⟬iban#2⟭
BIC_COMPTE_PIVOT=⟬bic#2⟭
TITULAIRE_COMPTE_PIVOT="⟬company#2⟭"
ADRESSE_SIEGE="⟬postal_address#2⟭"

PLAFOND_JOURNALIER_GBP=250000
DELAI_REPONSE_MS=4000
⟬trap:indicator_non_pii|NOMBRE_SIGNATAIRES_REQUIS=2⟭
⟬trap:indicator_non_pii|DUREE_VIE_JETON_SECONDES=300⟭
⟬end⟭

⟬template⟭
family: config
format: .env
language: mixed
fill_locale: fr_FR
domain: logistics
appearance: comment, assignment, url, section header
scenario: .env.example of a road transport planner committed for new developers, English keys, French comments, every credential left as a placeholder and carriers named after families
⟬text⟭
# ==============================================================
# tms-planner : modèle de configuration, à copier en .env
# Aucune vraie valeur ici : les secrets sont dans le coffre de l'équipe exploitation.
# ==============================================================

## Application
APP_NAME=tms-planner
APP_ENV=recette
APP_PORT=8088
APP_TIMEZONE=Europe/Paris
APP_LOCALE=fr_FR
APP_DEBUG=false
LOG_LEVEL=info
LOG_FORMAT=json
⟬trap:indicator_non_pii|LOG_USER_ID=false⟭

## Base de données
DB_HOST=⟬hostname#1⟭
DB_PORT=5432
DB_NAME=tms_planner
⟬trap:indicator_non_pii|DB_USER=tms_app⟭
DB_PASSWORD=⟬trap:placeholder|${TMS_DB_PASSWORD}⟭
DB_POOL_MIN=2
DB_POOL_MAX=20
DB_SSLMODE=require

## Messages
AMQP_URL=amqp://tms_app:⟬trap:placeholder|${TMS_AMQP_PASSWORD}⟭@⟬hostname#2⟭:5672/tms
AMQP_PREFETCH=40
AMQP_DEAD_LETTER=tms.rejets

## Calcul des tournées
# plus court chemin avec ⟬trap:eponym|Dijkstra⟭, puis regroupement ⟬trap:eponym|Clarke-Wright⟭
ROUTING_ALGORITHM=dijkstra
ROUTING_MAX_STOPS=45
ROUTING_MAX_DRIVE_MINUTES=540
ROUTING_BREAK_MINUTES=45
MAPS_PROVIDER=openrouteservice
MAPS_API_KEY=⟬trap:placeholder|<cle-cartographie>⟭
⟬trap:indicator_non_pii|MAPS_API_KEY_HEADER=Authorization⟭

## Transporteurs
DEFAULT_CARRIER="⟬trap:company_name|⦃Family⦄ Transports⟭"
FALLBACK_CARRIER="⟬trap:company_name|Transports ⦃Family2⦄ et Fils⟭"
⟬trap:indicator_non_pii|CARRIER_CONTACT_REQUIRED=true⟭
EDI_INBOX=⟬file_path#1⟭
EDI_PARTNER_PASSWORD=⟬trap:placeholder|xxxxxxxx⟭

## Notifications
SMTP_HOST=⟬hostname#3⟭
SMTP_PORT=587
⟬trap:indicator_non_pii|SMTP_FROM=<expediteur-tournees>⟭
SMTP_PASSWORD=⟬trap:placeholder|${TMS_SMTP_PASSWORD}⟭
⟬trap:indicator_non_pii|SMS_SENDER_NAME=TOURNEES⟭

## Exploitation
# responsable : l'astreinte exploitation, pas une personne en particulier
⟬trap:indicator_non_pii|OWNER=equipe-exploitation⟭
HEALTHCHECK_PATH=/actuator/health
METRICS_PORT=9108
SENTRY_DSN=⟬trap:placeholder|<dsn-sentry>⟭
SENTRY_RELEASE=⟬version#1⟭
BUILD_COMMIT=⟬git_sha#1⟭
⟬end⟭

⟬template⟭
family: config
format: .env
language: mixed
fill_locale: mixed
domain: SaaS
appearance: comment, assignment, url, commented-out value
scenario: production env of a helpdesk synchronisation worker with French variable names and English comments, kept by a remote team whose bot account belongs to one engineer, and with an older partner key still commented out
⟬text⟭
# helpdesk-sync worker, production. Keep out of the repo.
# The bot account belongs to ⟬person_name#1⟭, ask before rotating anything.
JETON_GITHUB=⟬github_token#1⟭
DEPOT_SOURCE=⟬trap:email_lookalike|git@github.com:helpdesk-sync/worker.git⟭
JETON_SLACK=⟬slack_token#1⟭
SALON_ALERTES=alertes-prod

URL_BASE=postgres://helpdesk:⟬url_password#1⟭@⟬hostname#1⟭:5432/helpdesk?sslmode=require
FILE_REDIS=rediss://:⟬url_password#2⟭@⟬hostname#2⟭:6380/0

SMTP_HOTE=⟬hostname#3⟭
MOT_DE_PASSE_SMTP=⟬password#1⟭
EXPEDITEUR=⟬email:generic#2⟭

CLE_PARTENAIRE=⟬opaque_token#1⟭
# not sure this one was ever revoked
# CLE_PARTENAIRE=⟬opaque_token#2⟭

FENETRE_SYNCHRO_MINUTES=15
TAILLE_LOT=200
⟬trap:indicator_non_pii|NOMBRE_MAX_UTILISATEURS=250⟭
⟬trap:indicator_non_pii|AUTEUR_PAR_DEFAUT=robot-synchro⟭
VERSION_WORKER=⟬version#1⟭
⟬end⟭

⟬template⟭
family: config
format: .env
language: mixed
fill_locale: en_US
domain: SaaS
appearance: comment, assignment
scenario: flag file of a billing preview environment with English keys and French comments from the Lyon team working for an American parent company, with nothing sensitive in it
⟬text⟭
# bascule progressive de la nouvelle facturation, voir ⟬ticket_id#1⟭
FEATURE_NEW_INVOICE_ENGINE=true
FEATURE_USAGE_METERING=false
ROLLOUT_PERCENT=25
ROLLOUT_REF=⟬git_sha#1⟭
# on garde l'arrondi de ⟬trap:eponym|Gauss⟭ tant que la finance n'a pas tranché
INVOICE_ROUNDING=half_even
⟬trap:indicator_non_pii|API_KEY_PREFIX=bill_⟭
⟬trap:indicator_non_pii|PASSWORD_RESET_TTL_MINUTES=30⟭
PREVIEW_HOST=⟬hostname#1⟭
LAST_REVIEWED="⟬date#1⟭"
⟬end⟭

⟬template⟭
family: config
format: .yaml
language: mixed
fill_locale: fr_FR
domain: logistics
appearance: comment, YAML value, list item, quoted value
scenario: application.yml of a delivery round service with English Spring keys and French business fields, listing depots with their street address and their dock manager
⟬text⟭
# Service de tournées, profil recette
server:
  port: 8443
spring:
  application:
    name: tournees-api
  datasource:
    url: jdbc:postgresql://⟬hostname#1⟭:5432/tournees
    username: ⟬username#1⟭
    password: "⟬password#1⟭"
    hikari:
      maximum-pool-size: 12
google:
  maps:
    # clé restreinte par IP depuis ⟬date#1⟭
    key: ⟬google_api_key#1⟭
    region: fr
webhooks:
  - nom: suivi-colis
    url: ⟬url#1⟭
    sig: "⟬opaque_token#1⟭"
    retries: 3
depots:
  - code: LYS
    libelle: "Plateforme de ⟬city#2⟭"
    adresse: "⟬fr_postal_address#2⟭"
    chef_de_quai: "⟬person_name#3⟭"
    tel: "⟬phone#3⟭"
  - code: NTE
    libelle: "Agence de ⟬city#4⟭"
    adresse: "⟬fr_postal_address#4⟭"
    chef_de_quai: "⟬person_name#5⟭"
    tel: "⟬phone#5⟭"
    # remplace ⟬person_name:initial#6⟭ jusqu'au ⟬date#2⟭
⟬end⟭

⟬template⟭
family: config
format: .yaml
language: mixed
fill_locale: mixed
domain: banking
appearance: comment, YAML value, block scalar, list item, quoted value
scenario: Helm values for the recette environment of an instant transfer service at a French bank, with English chart keys, French comments, a TLS private key in a block scalar and an English-speaking vendor contact
⟬text⟭
# values-recette.yaml, chart virements-instantanes
# Responsable applicatif : ⟬person_name#1⟭ (⟬email#1⟭)
replicaCount: 3

image:
  repository: ⟬hostname#1⟭/paiements/virements-instantanes
  tag: "⟬version#1⟭"
  pullPolicy: IfNotPresent

imagePullSecrets:
  - name: regcred-recette

service:
  type: ClusterIP
  port: 8443

ingress:
  enabled: true
  className: nginx
  hosts:
    - host: ⟬hostname#2⟭
      paths:
        - path: /
          pathType: Prefix

resources:
  requests:
    cpu: 500m
    memory: 1Gi
  limits:
    memory: 2Gi

env:
  - name: SPRING_PROFILES_ACTIVE
    value: recette
  - name: SEPA_INST_BIC
    value: "⟬bic#3⟭"
  - name: COMPTE_RACINE_IBAN
    value: "⟬iban#3⟭"
  - name: DB_URL
    value: jdbc:oracle:thin:@//⟬hostname#3⟭:1521/VIRINST
  - name: DB_USER
    value: virinst_app
  - name: DB_PASSWORD
    value: "⟬password#1⟭"
  - name: SWIFT_GPI_REF
    value: "⟬opaque_token#1⟭"
  - name: SLACK_BOT
    value: ⟬slack_token#1⟭

tls:
  enabled: true
  secretName: virements-tls
  # clé du certificat de recette, à sortir du fichier avant la mise en production
  key: |
    ⟬private_key#1⟭

vendor:
  name: "⟬company#4⟭"
  # support editor, English only
  support_engineer: "⟬person_name#4⟭"
  support_phone: "⟬phone#4⟭"

probes:
  liveness: /actuator/health/liveness
  readiness: /actuator/health/readiness

podAnnotations:
  ⟬trap:indicator_non_pii|owner: "equipe-paiements"⟭
  prometheus.io/scrape: "true"
  prometheus.io/port: "9090"
⟬end⟭

⟬template⟭
family: config
format: .yaml
language: mixed
fill_locale: fr_FR
domain: e-commerce
appearance: comment, YAML value, list item
scenario: service catalogue entry of an online shop checkout team, English keys and French values, where owner and contact point to teams and channels, not people
⟬text⟭
# catalogue de services : une entrée par dépôt
service: tunnel-commande
tier: 1
language: kotlin
⟬trap:indicator_non_pii|owner: equipe-checkout⟭
⟬trap:indicator_non_pii|contact: canal-checkout-urgences⟭
⟬trap:indicator_non_pii|reviewer: equipe-paiement⟭
runbook: ⟬url#1⟭
dependencies:
  - paiements
  - stocks
  - ⟬trap:library|Jackson⟭
last_review: "⟬date#1⟭"
⟬end⟭

⟬template⟭
family: config
format: .yaml
language: mixed
fill_locale: en_GB
domain: SaaS
appearance: comment, YAML value, url, quoted value, list item
scenario: Ansible group_vars left in clear during a migration, with French variable names and English comments from the British contractor who wrote them for a Paris-based customer portal vendor
⟬text⟭
---
# group_vars/production/portail.yml
# Clear copy made during the migration. The encrypted one is vault.yml, delete this afterwards.
application_nom: portail-clients
application_version: "⟬version#1⟭"
utilisateur_systeme: ⟬username#1⟭
repertoire_racine: /srv/portail

base_donnees:
  hote: ⟬hostname#1⟭
  port: 3306
  nom: portail
  utilisateur: portail_rw
  mot_de_passe: "⟬password#1⟭"
  sauvegarde_url: "mysql://sauvegarde:⟬url_password#1⟭@⟬hostname#2⟭:3306/portail"

depot_git:
  adresse: ⟬trap:email_lookalike|git@github.com:portail-clients/ansible.git⟭
  jeton_deploiement: ⟬github_token#1⟭
  branche: main

notifications:
  jeton_slack: ⟬slack_token#1⟭
  canal: "#deploiements"
  responsables:
    - "⟬person_name#2⟭"
    - "⟬person_name#3⟭"

serveurs_web:
  - nom: web01
    ip: ⟬ip_address#1⟭
  - nom: web02
    ip: ⟬ip_address#2⟭

⟬trap:indicator_non_pii|nombre_max_mot_de_passe_echecs: 5⟭
⟬end⟭

⟬template⟭
family: config
format: .yaml
language: mixed
fill_locale: fr_FR
domain: e-commerce
appearance: comment, YAML value, multi-document
scenario: Kubernetes Secret and ConfigMap of an online wine shop, written by hand with stringData, English keys and French comments, one secret sitting under an innocuous key
⟬text⟭
# créé à la main pour la démo du ⟬date#1⟭, à remplacer par le coffre
apiVersion: v1
kind: Secret
metadata:
  name: caviste-api
  namespace: boutique
type: Opaque
stringData:
  STRIPE_API_KEY: ⟬stripe_secret_key#1⟭
  PACKAGES_READ_TOKEN: ⟬github_token#1⟭
  checkout-sig: "⟬opaque_token#1⟭"
  ANALYTICS_BROWSER_KEY: ⟬google_api_key#1⟭
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: caviste-api-config
  namespace: boutique
  labels:
    ⟬trap:indicator_non_pii|owner: equipe-catalogue⟭
data:
  CATALOG_DEFAULT_REGION: bordeaux
  # le ⟬trap:word_name|Margaux⟭ 2015 reste en tête des ventes, on garde la mise en avant
  FEATURED_APPELLATION: margaux
  SHIPPING_FREE_ABOVE: "120"
  AGE_GATE_ENABLED: "true"
  ORDER_MAIL_FROM: ⟬email:generic#2⟭
⟬end⟭

⟬template⟭
family: config
format: .json
language: mixed
fill_locale: fr_FR
domain: e-commerce
appearance: nested JSON, string value, array
scenario: Postman environment exported by a QA engineer for a marketplace API, English variable names with French test customer values and live-looking secrets marked as secret
⟬text⟭
{
  "id": "⟬uuid#1⟭",
  "name": "Marketplace - recette",
  "values": [
    { "key": "baseUrl", "value": "⟬url#1⟭", "type": "default", "enabled": true },
    { "key": "stripeKey", "value": "⟬stripe_secret_key#1⟭", "type": "secret", "enabled": true },
    { "key": "sellerRef", "value": "⟬opaque_token#1⟭", "type": "secret", "enabled": true },
    { "key": "sellerPassword", "value": "⟬password#1⟭", "type": "secret", "enabled": true },
    { "key": "buyerName", "value": "⟬person_name#2⟭", "type": "default", "enabled": true },
    { "key": "buyerMail", "value": "⟬email#2⟭", "type": "default", "enabled": true },
    { "key": "buyerMobile", "value": "⟬phone#2⟭", "type": "default", "enabled": true },
    { "key": "shippingLine1", "value": "⟬fr_postal_address:street#2⟭", "type": "default", "enabled": true },
    { "key": "shippingCity", "value": "⟬city#2⟭", "type": "default", "enabled": true },
    { "key": "shippingZip", "value": "⟬postcode#2⟭", "type": "default", "enabled": true },
    { "key": "orderRef", "value": "⟬order_number#1⟭", "type": "default", "enabled": true },
    { "key": "tokenTtl", "value": "3600", "type": "default", "enabled": false }
  ],
  "_postman_variable_scope": "environment",
  "_postman_exported_at": "⟬date#1⟭",
  "_postman_exported_using": "Postman/⟬version#1⟭"
}
⟬end⟭

⟬template⟭
family: config
format: .json
language: mixed
fill_locale: mixed
domain: banking
appearance: nested JSON, string value
scenario: service account key file of a bank's fraud analytics project, standard English keys with a French note added by whoever downloaded it, the private key sitting in a JSON string
⟬text⟭
{
  "type": "service_account",
  "project_id": "fraude-scoring-recette",
  "private_key_id": "⟬hash#1⟭",
  "private_key": "⟬private_key#1⟭",
  "client_email": "⟬email:generic#2⟭",
  "client_id": "108241979335412647203",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "note": "téléchargée pour le POC, à révoquer après le comité du ⟬date#1⟭"
}
⟬end⟭

⟬template⟭
family: config
format: .json
language: mixed
fill_locale: fr_FR
domain: logistics
appearance: nested JSON, string value, array, http header
scenario: carrier connector registry of a parcel aggregator, English keys and French labels, with secrets under generic keys, depot addresses and a mix of team and personal contacts
⟬text⟭
{
  "_comment": "Connecteurs transporteurs. Toute modification passe par l'équipe intégration.",
  "schemaVersion": "⟬version#1⟭",
  "updatedAt": "⟬date#1⟭",
  "defaults": {
    "timeoutMs": 8000,
    "retries": 2,
    "labelFormat": "ZPL",
    "currency": "EUR"
  },
  "carriers": [
    {
      "code": "EXP",
      "label": "⟬trap:company_name|Express ⦃Family⦄⟭",
      "reference": "⟬customer_id#1⟭",
      "endpoint": "⟬url#1⟭",
      "auth": {
        "type": "header",
        "name": "X-Client-Ref",
        "value": "⟬opaque_token#1⟭"
      },
      "contact": "⟬person_name#2⟭",
      "contactPhone": "⟬phone#2⟭",
      "cutoff": "17:30"
    },
    {
      "code": "RGL",
      "label": "Messagerie régionale ouest",
      "endpoint": "⟬url#2⟭",
      "auth": {
        "type": "basic",
        "user": "⟬username#1⟭",
        "value": "⟬password#1⟭"
      },
      "contact": "⟬trap:indicator_non_pii|support-integration⟭",
      "cutoff": "16:00"
    },
    {
      "code": "PAL",
      "label": "⟬trap:company_name|Palettes ⦃Family2⦄⟭",
      "endpoint": "⟬url#3⟭",
      "auth": {
        "type": "query",
        "name": "k",
        "value": "⟬opaque_token#2⟭"
      },
      "contact": "⟬email:generic#3⟭",
      "cutoff": "12:00"
    }
  ],
  "depots": [
    {
      "id": "D01",
      "adresse": "⟬fr_postal_address#4⟭",
      "responsable": "⟬person_name#5⟭",
      "quais": 14
    },
    {
      "id": "D02",
      "adresse": "⟬fr_postal_address#6⟭",
      "responsable": "⟬trap:indicator_non_pii|equipe-exploitation-sud⟭",
      "quais": 6
    }
  ],
  "geocoding": {
    "provider": "google",
    "apiKey": "⟬google_api_key#1⟭",
    "cacheDays": 30
  },
  "alerts": {
    "slackToken": "⟬slack_token#1⟭",
    "channel": "transporteurs-incidents"
  }
}
⟬end⟭

⟬template⟭
family: config
format: .json
language: mixed
fill_locale: en_US
domain: SaaS
appearance: nested JSON, string value, array
scenario: tenant plan definitions of a project management product sold from Nantes to American customers, French keys and English customer-facing text, with no sensitive value at all
⟬text⟭
{
  "_commentaire": "Plans commerciaux. Les libellés restent en anglais, le marché visé est américain.",
  "version": "⟬version#1⟭",
  "plans": [
    {
      "code": "starter",
      "libelle": "Starter",
      "description": "For small teams getting started",
      "prix_mensuel_usd": 19,
      "sieges_max": 5,
      "options": ["kanban", "gantt"]
    },
    {
      "code": "business",
      "libelle": "Business",
      "description": "Priority support and SSO",
      "prix_mensuel_usd": 49,
      "sieges_max": 50,
      "options": ["kanban", "gantt", "sso", "audit"]
    }
  ],
  "regles": {
    "⟬trap:indicator_non_pii|longueur_min_mot_de_passe⟭": 12,
    "⟬trap:indicator_non_pii|duree_jeton_secondes⟭": 900,
    "⟬trap:indicator_non_pii|champ_email_obligatoire⟭": true
  },
  "planification": {
    "algorithme": "⟬trap:eponym|Gantt⟭",
    "moteur": "⟬trap:library|Quartz⟭"
  },
  "publie_le": "⟬date#1⟭"
}
⟬end⟭

⟬template⟭
family: config
format: .json
language: mixed
fill_locale: fr_FR
domain: banking
appearance: nested JSON, string value, test fixture, curl command
scenario: seed file for the KYC sandbox of a retail bank, French keys with English notes, describing two test account holders and the shell command that reloads them
⟬text⟭
{
  "_note": "KYC sandbox seed. Reload with the command below after each reset.",
  "commande_rechargement": "curl -s -X POST -H \"X-Client-Ref: ⟬opaque_token#1⟭\" ⟬url#1⟭ --data-urlencode \"titulaire=⟬person_name#1⟭\"",
  "titulaires": [
    {
      "nom_complet": "⟬person_name#1⟭",
      "date_naissance": "⟬birth_date#1⟭",
      "adresse": "⟬fr_postal_address#1⟭",
      "telephone": "⟬phone#1⟭",
      "nir": "⟬fr_social_security_number#1⟭",
      "iban": "⟬iban#1⟭",
      "ouvert_le": "⟬date#2⟭"
    },
    {
      "nom_complet": "⟬person_name#2⟭",
      "date_naissance": "⟬birth_date#2⟭",
      "adresse": "⟬fr_postal_address#2⟭",
      "telephone": "⟬phone#2⟭",
      "iban": "⟬iban#2⟭",
      "ouvert_le": "⟬date#1⟭"
    }
  ],
  "acces_sandbox": {
    "utilisateur": "⟬username#1⟭",
    "mot_de_passe": "⟬password#1⟭"
  }
}
⟬end⟭

⟬template⟭
family: config
format: .properties
language: mixed
fill_locale: fr_FR
domain: banking
appearance: comment, properties key, connection string
scenario: Spring production properties of a French bank's card dispute service, English keys with French comments, a JDBC URL carrying its password, and the on-call engineer named in a comment
⟬text⟭
# Litiges carte, application-prod.properties
# Astreinte : ⟬person_name#1⟭, ⟬phone#1⟭
spring.application.name=litiges-carte
server.port=8443
server.ssl.key-store=/etc/litiges/keystore.p12
server.ssl.key-store-password=⟬password#1⟭

# base principale, le mot de passe reste dans l'URL tant que le pool ne lit pas le coffre
spring.datasource.url=jdbc:postgresql://⟬hostname#1⟭:5432/litiges?user=litiges_app&password=⟬url_password#1⟭
spring.datasource.hikari.maximum-pool-size=15
spring.jpa.open-in-view=false

# réseau carte
scheme.gateway.url=⟬url#1⟭
scheme.gateway.ref=⟬opaque_token#1⟭
scheme.gateway.timeout-ms=6000
scheme.dossier.ref=⟬ticket_id#1⟭
⟬trap:indicator_non_pii|card.pan.masking=first6last4⟭
⟬trap:indicator_non_pii|cvv.retention.days=0⟭

management.endpoints.web.exposure.include=health,info,prometheus
logging.level.fr.banque.litiges=INFO
⟬end⟭

⟬template⟭
family: config
format: .properties
language: mixed
fill_locale: fr_FR
domain: logistics
appearance: comment, properties key
scenario: gradle.properties of the drivers' mobile app of a French haulier, English keys with French comments, keystore passwords still in clear
⟬text⟭
# appli chauffeurs, signature à sortir de ce fichier
org.gradle.jvmargs=-Xmx3g
android.useAndroidX=true
VERSION_NAME=⟬version#1⟭
RELEASE_STORE_PASSWORD=⟬password#1⟭
RELEASE_KEY_ALIAS=chauffeurs
RELEASE_KEY_PASSWORD=⟬password#2⟭
MAPS_SDK_KEY=⟬google_api_key#1⟭
⟬end⟭

⟬template⟭
family: config
format: .properties
language: mixed
fill_locale: fr_FR
domain: e-commerce
appearance: comment, properties key, message bundle
scenario: English message bundle of a French furniture marketplace, French keys and English values, reviewed by a translator, with the returns address and support contacts in the mails
⟬text⟭
# messages_en.properties
# Traduction relue par ⟬person_name#1⟭ le ⟬date#1⟭. Keep placeholders untouched.
panier.titre=Your basket
panier.vide=Your basket is empty
panier.total=Total including VAT
panier.livraison=Delivery
panier.code_promo=Promo code
panier.appliquer=Apply
panier.continuer=Continue shopping

commande.titre=Your order
commande.confirmation=Thank you for your order {0}
commande.delai=Estimated delivery within {0} days
commande.annuler=Cancel this order
commande.facture=Download the invoice
commande.suivi=Track my parcel

compte.titre=My account
compte.nom=Full name
compte.mail=Email address
compte.mot_de_passe=Password
compte.mot_de_passe.aide=At least 12 characters
compte.mot_de_passe.oublie=Forgot your password?
compte.date_naissance=Date of birth
compte.telephone=Mobile number
compte.adresse=Delivery address

vendeur.titre=Become a seller
vendeur.siret=Company registration number
vendeur.iban=Bank account (IBAN)
vendeur.nom_boutique=Shop name

erreur.generique=Something went wrong, please try again
erreur.stock=This item is no longer in stock
erreur.paiement=Your payment was declined
erreur.session=Your session has expired
erreur.adresse=We cannot deliver to this address

mail.bienvenue.sujet=Welcome to the marketplace
mail.bienvenue.corps=Hello {0}, your account is ready.
mail.expedition.sujet=Your order is on its way
mail.expedition.corps=Your order was handed to {0}. Tracking number: {1}
mail.signature=The customer care team

retours.titre=Returns
retours.delai=You have 30 days to return an item
retours.etiquette=Print the prepaid label
retours.adresse=Send your parcel to our returns centre: ⟬fr_postal_address#2⟭
retours.contact=Questions? Write to ⟬email:generic#3⟭ or call ⟬phone#3⟭

aide.titre=Help centre
aide.horaires=Monday to Friday, 9am to 6pm
aide.chat=Chat with us
aide.faq=Frequently asked questions
aide.livraison=Delivery information
aide.garantie=Two-year guarantee on all furniture
aide.montage=Assembly instructions

pied.mentions=Legal notice
pied.cgv=Terms of sale
pied.cookies=Cookie settings
pied.collection.printemps=The ⟬trap:word_name|Rose⟭ and ⟬trap:word_name|Olive⟭ collections
pied.fournisseur=Oak tables by ⟬trap:company_name|Ateliers ⦃Family⦄⟭
⟬end⟭

⟬template⟭
family: config
format: .properties
language: mixed
fill_locale: en_GB
domain: SaaS
appearance: comment, properties key, connection string
scenario: settings file of a Java reporting daemon sold by a Toulouse vendor, French keys and English comments, deployed at a Manchester customer whose administrator is named at the top
⟬text⟭
# rapport-daemon configuration, customer site Manchester
# Site administrator: ⟬person_name#1⟭ <⟬email#1⟭>
# Password below was set during installation on ⟬date#1⟭
serveur.ecoute.port=9440
serveur.ecoute.adresse=⟬ip_address#1⟭
base.hote=⟬hostname#1⟭
base.port=1433
base.nom=rapports
base.utilisateur=rapports_rw
base.mot_de_passe=⟬password#1⟭
smtp.hote=⟬hostname#2⟭
smtp.expediteur=⟬email:generic#2⟭
smtp.mot_de_passe=⟬password#2⟭
licence.reference=⟬opaque_token#1⟭
licence.client=⟬company#3⟭
stockage.url=https://rapports:⟬url_password#1⟭@⟬hostname#3⟭/webdav/rapports
jeton.depot=⟬github_token#1⟭
jeton.slack=⟬slack_token#1⟭
planification.cron=0 30 6 * * MON-FRI
⟬trap:indicator_non_pii|utilisateur.defaut=lecteur⟭
⟬end⟭

⟬template⟭
family: config
format: .properties
language: mixed
fill_locale: fr_FR
domain: logistics
appearance: comment, properties key
scenario: Quartz scheduler settings of a warehouse management system, English keys with French comments on the night jobs, holding nothing sensitive
⟬text⟭
# ordonnanceur de l'entrepôt, batchs de nuit
org.quartz.scheduler.instanceName=wms-nuit
org.quartz.threadPool.threadCount=6
org.quartz.jobStore.misfireThreshold=60000
# même pool que le serveur ⟬trap:library|Jetty⟭, ne pas dépasser 6 threads
wms.jobs.inventaire.cron=0 0 2 * * ?
wms.jobs.reappro.cron=0 15 3 * * ?
wms.jobs.purge.jours=90
wms.jobs.ref=⟬ticket_id#1⟭
⟬trap:indicator_non_pii|wms.jobs.owner=equipe-entrepot⟭
wms.instance.host=⟬hostname#1⟭
⟬end⟭
