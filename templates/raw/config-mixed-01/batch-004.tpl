⟬template⟭
family: config
format: .env
language: mixed
fill_locale: en_GB
domain: SaaS
appearance: comment, assignment, quoted value
scenario: self-hosted CI runner env of a London-based design tool, English keys with French comments from the Paris infrastructure engineer, and an owner line naming a person
⟬text⟭
# variables du runner auto-hébergé, à recréer si la machine tombe
CI_REGISTRY=⟬hostname#1⟭
CI_REGISTRY_USER=⟬username#1⟭
CI_REGISTRY_PASSWORD=⟬password#1⟭
GITHUB_TOKEN=⟬github_token#1⟭
OWNER="⟬person_name#2⟭"
⟬end⟭

⟬template⟭
family: config
format: .env
language: mixed
fill_locale: fr_FR
domain: e-commerce
appearance: comment, assignment, url, quoted value
scenario: container env of a PrestaShop site for a regional delicatessen, French variable names from an old install script, English comments by a freelance, shop owner and legal details included
⟬text⟭
# PrestaShop container. French names come from our old install script, keep them.
SERVEUR_BDD=⟬hostname#1⟭
BASE_BDD=prestashop
UTILISATEUR_BDD=presta
MOT_DE_PASSE_BDD=⟬password#1⟭
URL_SAUVEGARDE=ftp://sauvegarde:⟬url_password#1⟭@⟬hostname#2⟭/presta

# cookie keys, never regenerate them or every session dies
CLE_COOKIE=⟬opaque_token#1⟭
SEL_COOKIE=⟬opaque_token#2⟭

EMAIL_ADMIN=⟬email#3⟭
MOT_DE_PASSE_ADMIN=⟬password#2⟭
CLE_STRIPE=⟬stripe_secret_key#1⟭

RESPONSABLE_BOUTIQUE="⟬person_name#3⟭"
ADRESSE_BOUTIQUE="⟬fr_postal_address#4⟭"
TEL_BOUTIQUE="⟬phone#4⟭"
SIRET_BOUTIQUE=⟬fr_siret#4⟭
PRODUIT_VEDETTE="Fromage de la ⟬trap:word_name|Pierre-qui-Vire⟭"
⟬end⟭

⟬template⟭
family: config
format: .env
language: mixed
fill_locale: fr_FR
domain: logistics
appearance: comment, assignment
scenario: build values of a pallet tracker gateway injected by CI, English keys and French comments, many high-entropy identifiers and hashes that are not secrets, no credential at all
⟬text⟭
# passerelle balises : valeurs de build injectées par la CI, rien de secret
BEACON_FIRMWARE=⟬version#1⟭
BEACON_FIRMWARE_SHA256=⟬hash#1⟭
BUILD_COMMIT=⟬git_sha#1⟭
BUILD_REF=⟬ticket_id#1⟭
BUILD_DATE="⟬date#1⟭"
FLEET_ID=⟬uuid#1⟭
GATEWAY_ID=⟬uuid#2⟭
TRACE_NAMESPACE=⟬uuid#3⟭

# seuils de remontée, une balise par palette
REPORT_EVERY_S=600
REPORT_ON_SHOCK=true
BATTERY_WARN_PERCENT=15
SHOCK_THRESHOLD_G=4
⟬trap:indicator_non_pii|TOKEN_BUCKET_SIZE=500⟭
⟬trap:indicator_non_pii|AUTHOR=robot-ci⟭
⟬trap:indicator_non_pii|CONTACT=equipe-iot⟭
⟬end⟭

⟬template⟭
family: config
format: .env
language: mixed
fill_locale: mixed
domain: e-commerce
appearance: comment, assignment, url, quoted value, section header
scenario: shared production env of a group running two online brands, English keys and French comments, one Stripe account per brand, a contact and an owner per brand, and the shared tooling secrets
⟬text⟭
# ==============================================================
# groupe-boutiques : production, partagé par les deux marques
# Chaque marque a son compte Stripe, ne pas les intervertir.
# ==============================================================

# --- commun ---
NODE_ENV=production
PORT=3000
TRUST_PROXY=true
DATABASE_URL=postgresql://boutiques:⟬url_password#1⟭@⟬hostname#1⟭:5432/boutiques
REDIS_URL=rediss://:⟬url_password#2⟭@⟬hostname#2⟭:6380/1
SESSION_SECRET=⟬opaque_token#1⟭
GOOGLE_MAPS_KEY=⟬google_api_key#1⟭
GOOGLE_SHOPPING_KEY=⟬google_api_key#2⟭

# --- marque maison et jardin ---
JARDIN_DOMAIN=⟬hostname#3⟭
JARDIN_STRIPE_SECRET=⟬stripe_secret_key#1⟭
JARDIN_STRIPE_PUBLIC=⟬stripe_publishable_key#1⟭
JARDIN_WEBHOOK=⟬opaque_token#2⟭
JARDIN_CONTACT="⟬person_name#4⟭"
JARDIN_CONTACT_PHONE="⟬phone#4⟭"
# la gamme ⟬trap:word_name|Rose⟭ et ⟬trap:word_name|Lilas⟭ part avant les soldes
JARDIN_FEATURED=rose,lilas

# --- marque cuisine ---
CUISINE_DOMAIN=⟬hostname#4⟭
CUISINE_STRIPE_SECRET=⟬stripe_secret_key#2⟭
CUISINE_STRIPE_PUBLIC=⟬stripe_publishable_key#2⟭
CUISINE_WEBHOOK=⟬opaque_token#3⟭
CUISINE_OWNER="⟬person_name#5⟭"
CUISINE_MAILBOX=⟬email:generic#6⟭
CUISINE_SUPPLIER="⟬trap:company_name|Couteaux ⦃Family⦄⟭"

# --- messagerie transactionnelle ---
SMTP_HOST=⟬hostname#5⟭
SMTP_USER=⟬email:generic#7⟭
SMTP_PASSWORD=⟬password#1⟭
MAIL_FROM_NAME="Service clients"
# ⟬person_name#8⟭ reçoit une copie le temps de l'audit, jusqu'au ⟬date#1⟭
MAIL_BCC_AUDIT=⟬email#8⟭

# --- stockage des médias ---
MEDIA_BUCKET=groupe-boutiques-medias
MEDIA_CDN=⟬url#1⟭
MEDIA_UPLOAD_SIG=⟬opaque_token#4⟭

# --- outillage ---
GH_RELEASE_TOKEN=⟬github_token#1⟭
SLACK_DEPLOY_TOKEN=⟬slack_token#1⟭
SIGNING_KEY="⟬private_key#1⟭"
⟬trap:indicator_non_pii|DEPLOY_USER=deploy⟭
⟬trap:indicator_non_pii|OWNER_TEAM=plateforme-boutiques⟭

# --- réglages ---
CART_TTL_MINUTES=120
FREE_SHIPPING_ABOVE=59
MAX_ITEMS_PER_ORDER=40
⟬trap:indicator_non_pii|PASSWORD_RESET_WINDOW=45⟭
TAX_ROUNDING=line
FEATURE_GIFT_CARDS=true
FEATURE_WISHLIST=false
RELEASE=⟬version#1⟭
⟬end⟭

⟬template⟭
family: config
format: .env
language: mixed
fill_locale: en_US
domain: banking
appearance: comment, assignment, quoted value, test fixture
scenario: sandbox env of an American neobank built by a French team, English keys with French comments, an account aggregator secret and one sandbox identity with its SSN
⟬text⟭
# bac à sable de l'agrégateur de comptes, identité fictive fournie par le partenaire
AGGREGATOR_ENV=sandbox
AGGREGATOR_URL=⟬url#1⟭
AGGREGATOR_CLIENT_ID=⟬uuid#1⟭
AGGREGATOR_SECRET=⟬opaque_token#1⟭
WEBHOOK_SIGNING_SECRET=⟬opaque_token#2⟭
SESSION_JWT=⟬jwt#1⟭

SANDBOX_HOLDER="⟬person_name#2⟭"
SANDBOX_DOB="⟬birth_date#2⟭"
SANDBOX_SSN=⟬us_ssn#2⟭
SANDBOX_ACCOUNT_NUMBER=⟬bank_account_number#2⟭
SANDBOX_ADDRESS="⟬postal_address#2⟭"

# responsable conformité côté US
COMPLIANCE_CONTACT="⟬person_name#3⟭"
COMPLIANCE_PHONE="⟬phone#3⟭"
KYC_MIN_AGE=18
⟬end⟭

⟬template⟭
family: config
format: .yaml
language: mixed
fill_locale: en_GB
domain: banking
appearance: comment, YAML value, nested mapping
scenario: retention policy read by a purge job at a UK bank, English keys and French comments, keys naming personal fields but values being durations, nothing sensitive
⟬text⟭
# Durées de conservation, arbitrées avec la conformité le ⟬date#1⟭
retention:
  ⟬trap:indicator_non_pii|customer_name: 10y⟭
  ⟬trap:indicator_non_pii|iban: 10y⟭
  ⟬trap:indicator_non_pii|phone_number: 5y⟭
  ⟬trap:indicator_non_pii|date_of_birth: 10y⟭
  ⟬trap:indicator_non_pii|session_token: 24h⟭
⟬trap:indicator_non_pii|owner: data-governance⟭
schedule: "0 2 * * SUN"
⟬end⟭

⟬template⟭
family: config
format: .yaml
language: mixed
fill_locale: fr_FR
domain: e-commerce
appearance: comment, YAML value, list item, commented-out value, curl command
scenario: GitLab CI pipeline of a shoe retailer, English keys and French comments, variables in clear until the vault is ready and a curl call with a bearer token left in a commented line
⟬text⟭
# pipeline de la boutique : variables en clair en attendant le coffre
stages: [test, build, deploy]

variables:
  STRIPE_SECRET_KEY: ⟬stripe_secret_key#1⟭
  GITHUB_MIRROR_TOKEN: ⟬github_token#1⟭
  SLACK_NOTIFY: ⟬slack_token#1⟭
  DEPLOY_HOST: ⟬hostname#1⟭

test:
  stage: test
  image: node:20
  script:
    - npm ci
    - npm test

image_build:
  stage: build
  script:
    - docker build -t ⟬hostname#2⟭/boutique/chaussures:⟬version#1⟭ .

production:
  stage: deploy
  only: [main]
  script:
    - ./deploy.sh
    # - curl -X POST -H "Authorization: Bearer ⟬opaque_token#1⟭" ⟬url#1⟭
⟬end⟭

⟬template⟭
family: config
format: .yaml
language: mixed
fill_locale: mixed
domain: SaaS
appearance: comment, YAML value, list item
scenario: Grafana datasource provisioning of a subscription analytics product, English keys and French comments, passwords read from environment variables, no sensitive value
⟬text⟭
# sources de données, provisionnées au démarrage du conteneur
apiVersion: 1
datasources:
  - name: Prometheus
    type: prometheus
    url: ⟬url#1⟭
    access: proxy
    isDefault: true
  - name: Base facturation
    type: postgres
    url: ⟬hostname#1⟭:5432
    ⟬trap:indicator_non_pii|user: grafana_lecture⟭
    jsonData:
      database: facturation
      sslmode: require
    secureJsonData:
      password: ⟬trap:placeholder|$GF_FACTURATION_PASSWORD⟭
  - name: Journaux
    type: ⟬trap:library|loki⟭
    url: ⟬url#2⟭
    basicAuth: true
    ⟬trap:indicator_non_pii|basicAuthUser: grafana⟭
    secureJsonData:
      basicAuthPassword: ⟬trap:placeholder|$GF_LOKI_PASSWORD⟭
⟬end⟭

⟬template⟭
family: config
format: .yaml
language: mixed
fill_locale: fr_FR
domain: logistics
appearance: comment, YAML value, nested mapping, url
scenario: Ansible inventory of a haulier's depot servers, French variable names and English comments, one host per depot with its site address, local contact and a shared backup URL
⟬text⟭
# Inventory of depot servers, one host per depot.
# Shared credentials sit in all.vars until the vault migration.
all:
  vars:
    ansible_user: ⟬username#1⟭
    ansible_become_password: "⟬password#1⟭"
    url_depot_sauvegarde: "sftp://sauvegarde:⟬url_password#1⟭@⟬hostname#1⟭/depots"
    fuseau: Europe/Paris
  children:
    depots_nord:
      hosts:
        depot-lesquin:
          ansible_host: ⟬ip_address#1⟭
          adresse_site: "⟬fr_postal_address#2⟭"
          responsable_site: "⟬person_name#3⟭"
          tel_site: "⟬phone#3⟭"
          quais: 12
        depot-arras:
          ansible_host: ⟬ip_address#2⟭
          adresse_site: "⟬fr_postal_address#4⟭"
          responsable_site: "⟬person_name#5⟭"
          tel_site: "⟬phone#5⟭"
          quais: 6
    depots_ouest:
      hosts:
        depot-carquefou:
          ansible_host: ⟬ip_address#3⟭
          adresse_site: "⟬fr_postal_address#6⟭"
          ⟬trap:indicator_non_pii|responsable_site: equipe-regionale-ouest⟭
          tel_site: "⟬phone#6⟭"
          quais: 9
        depot-rennes:
          ansible_host: ⟬ip_address#4⟭
          adresse_site: "⟬fr_postal_address#7⟭"
          responsable_site: "⟬person_name#8⟭"
          tel_site: "⟬phone#8⟭"
          quais: 8
    depots_sud:
      hosts:
        depot-vitrolles:
          ansible_host: ⟬ip_address#5⟭
          adresse_site: "⟬fr_postal_address#9⟭"
          responsable_site: "⟬person_name#10⟭"
          tel_site: "⟬phone#10⟭"
          quais: 15
          # night shift lead while the site manager is away
          adjoint_nuit: "⟬person_name:initial#11⟭"
    imprimantes:
      hosts:
        zebra-quai-1:
          ansible_host: ⟬ip_address#6⟭
        zebra-quai-2:
          ansible_host: ⟬ip_address#7⟭
      vars:
        mot_de_passe_admin_web: "⟬password#2⟭"
    passerelle_edi:
      hosts:
        edi-central:
          ansible_host: ⟬ip_address#8⟭
          compte_edi: ⟬username#2⟭
          mot_de_passe_edi: "⟬password#3⟭"
    supervision:
      hosts:
        sonde-centrale:
          ansible_host: ⟬hostname#2⟭
          cle_sonde: ⟬opaque_token#1⟭
⟬end⟭

⟬template⟭
family: config
format: .yaml
language: mixed
fill_locale: en_US
domain: SaaS
appearance: comment, YAML value, block scalar
scenario: deploy credentials of a scheduling API config repository, English keys and a French comment, a GitHub token and an SSH key waiting for the vault
⟬text⟭
# clé de déploiement du dépôt de configuration, en attendant Vault
deploy:
  repository: ⟬trap:email_lookalike|git@github.com:agenda-api/config.git⟭
  token: ⟬github_token#1⟭
  ssh_key: |
    ⟬private_key#1⟭
⟬end⟭

⟬template⟭
family: config
format: .json
language: mixed
fill_locale: en_GB
domain: banking
appearance: nested JSON, string value
scenario: cached session of an internal treasury command line tool, French profile name and English keys, holding a JWT, a refresh token and the mail of the signed-in user
⟬text⟭
{
  "profil": "tresorerie-recette",
  "endpoint": "⟬url#1⟭",
  "access_token": "⟬jwt#1⟭",
  "refresh_token": "⟬opaque_token#1⟭",
  "expires_at": "⟬date#1⟭",
  "user": "⟬email#2⟭"
}
⟬end⟭

⟬template⟭
family: config
format: .json
language: mixed
fill_locale: mixed
domain: e-commerce
appearance: nested JSON, string value, array
scenario: integrations file of a headless shop, French keys and English notes, search admin key, CMS token and payment password under generic names, with a person as owner of each integration
⟬text⟭
{
  "boutique": "maison-du-the",
  "ref": "⟬customer_id#1⟭",
  "devise": "EUR",
  "integrations": {
    "recherche": {
      "fournisseur": "algolia",
      "application": "TEA2H7KQ",
      "valeur": "⟬opaque_token#1⟭",
      "responsable": "⟬person_name#2⟭",
      "note": "admin key, the search-only key is in the frontend"
    },
    "contenu": {
      "fournisseur": "contentful",
      "espace": "⟬uuid#1⟭",
      "ref": "⟬opaque_token#2⟭",
      "responsable": "⟬person_name#3⟭"
    },
    "paiement_fractionne": {
      "fournisseur": "klarna",
      "compte": "⟬username#1⟭",
      "valeur": "⟬password#1⟭",
      "responsable": "⟬trap:indicator_non_pii|equipe-finance⟭",
      "note": "merchant portal password, rotated by hand"
    },
    "carte": {
      "fournisseur": "stripe",
      "valeur": "⟬stripe_secret_key#1⟭"
    },
    "cartes_magasins": {
      "fournisseur": "google",
      "valeur": "⟬google_api_key#1⟭"
    }
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
scenario: Grafana dashboard export of a video meeting product, English keys and French panel titles, with UIDs and tool names but no sensitive value
⟬text⟭
{
  "uid": "⟬uuid#1⟭",
  "title": "Salles de réunion : qualité d'appel",
  "description": "Vue de l'astreinte, version ⟬version#1⟭",
  "tags": ["visio", "astreinte", "production"],
  "timezone": "browser",
  "schemaVersion": 39,
  "refresh": "30s",
  "editable": false,
  "createdBy": "⟬trap:indicator_non_pii|robot-provisioning⟭",
  "time": { "from": "now-6h", "to": "now" },
  "templating": {
    "list": [
      {
        "name": "region",
        "type": "query",
        "datasource": "⟬trap:library|Prometheus⟭",
        "query": "label_values(visio_salles_actives, region)"
      }
    ]
  },
  "panels": [
    {
      "id": 1,
      "title": "Salles actives",
      "type": "stat",
      "gridPos": { "h": 6, "w": 6, "x": 0, "y": 0 },
      "targets": [
        { "expr": "sum(visio_salles_actives{region=\"$region\"})", "refId": "A" }
      ]
    },
    {
      "id": 2,
      "title": "Perte de paquets",
      "type": "timeseries",
      "gridPos": { "h": 6, "w": 18, "x": 6, "y": 0 },
      "targets": [
        { "expr": "avg(visio_perte_paquets) by (region)", "refId": "A" }
      ]
    },
    {
      "id": 3,
      "title": "Gigue selon ⟬trap:eponym|Kalman⟭",
      "type": "timeseries",
      "gridPos": { "h": 8, "w": 12, "x": 0, "y": 6 },
      "targets": [
        { "expr": "histogram_quantile(0.95, visio_gigue_ms_bucket)", "refId": "A" }
      ]
    },
    {
      "id": 4,
      "title": "Traces lentes (⟬trap:library|Jaeger⟭)",
      "type": "table",
      "gridPos": { "h": 8, "w": 12, "x": 12, "y": 6 },
      "targets": [
        { "query": "service=visio-sfu minDuration=500ms", "refId": "A" }
      ]
    }
  ],
  "annotations": {
    "list": [
      { "name": "Déploiements", "datasource": "⟬trap:library|Loki⟭", "expr": "{job=\"deploiement\"}" }
    ]
  }
}
⟬end⟭

⟬template⟭
family: config
format: .json
language: mixed
fill_locale: mixed
domain: logistics
appearance: nested JSON, string value, url
scenario: SFTP and EDI partner settings of a freight forwarder, English keys and French values, a private key in a JSON string, a password in an FTPS URL and a named contact for each partner
⟬text⟭
{
  "partners": [
    {
      "code": "HAVRE-TERMINAL",
      "label": "Terminal à conteneurs du Havre",
      "protocol": "sftp",
      "host": "⟬hostname#1⟭",
      "port": 22,
      "user": "⟬username#1⟭",
      "privateKey": "⟬private_key#1⟭",
      "inbox": "/entrant/manifestes",
      "contact": "⟬person_name#2⟭",
      "contactMail": "⟬email#2⟭"
    },
    {
      "code": "ANVERS-AGENT",
      "label": "Agent maritime d'Anvers",
      "protocol": "ftps",
      "url": "ftps://transit:⟬url_password#1⟭@⟬hostname#2⟭:990/in",
      "contact": "⟬person_name#3⟭",
      "contactPhone": "⟬phone#3⟭"
    }
  ],
  "retry": { "maxAttempts": 5, "delaySeconds": 120 },
  "ownerTeam": "⟬trap:indicator_non_pii|transit-maritime⟭"
}
⟬end⟭

⟬template⟭
family: config
format: .json
language: mixed
fill_locale: en_GB
domain: banking
appearance: nested JSON, string value, test fixture
scenario: card issuing sandbox settings of a UK fintech owned by a French group, French keys and English values, test cards, a webhook key in a string and a GitHub token for the fixtures repository
⟬text⟭
{
  "environnement": "sandbox",
  "description": "Card issuing sandbox, reset every Sunday",
  "emetteur": {
    "url": "⟬url#1⟭",
    "identifiant": "⟬uuid#1⟭",
    "cle_api": "⟬opaque_token#1⟭",
    "cle_signature_webhook": "⟬private_key#1⟭"
  },
  "cartes_test": [
    {
      "titulaire": "⟬person_name#2⟭",
      "numero": "⟬payment_card#2⟭",
      "cryptogramme": "⟬card_security_code#2⟭",
      "permis": "⟬uk_driving_licence#2⟭",
      "statut": "active"
    },
    {
      "titulaire": "⟬person_name#3⟭",
      "numero": "⟬payment_card#3⟭",
      "cryptogramme": "⟬card_security_code#3⟭",
      "statut": "blocked"
    }
  ],
  "depot_jeux_essai": {
    "adresse": "https://github.com/carte-sandbox/fixtures",
    "jeton": "⟬github_token#1⟭"
  },
  "auteur": "⟬person_name#4⟭"
}
⟬end⟭

⟬template⟭
family: config
format: .properties
language: mixed
fill_locale: fr_FR
domain: e-commerce
appearance: comment, properties key
scenario: search engine connection of an online bookshop, English keys and French comments, installed by hand on a colleague's server named by first name
⟬text⟭
# moteur de recherche installé à la main sur le serveur de ⟬person_name:given#1⟭
elasticsearch.host=⟬hostname#1⟭
elasticsearch.port=9200
elasticsearch.user=elastic
elasticsearch.password=⟬password#1⟭
elasticsearch.index=livres
elasticsearch.ref=⟬opaque_token#1⟭
⟬end⟭

⟬template⟭
family: config
format: .properties
language: mixed
fill_locale: fr_FR
domain: banking
appearance: comment, properties key, distinguished name
scenario: LDAP binding of a French bank's branch directory, English keys and French comments, the bind account being a person's distinguished name
⟬text⟭
# Annuaire des agences : liaison LDAP
# Le compte de liaison est encore nominatif, à remplacer par un compte de service
ldap.url=ldaps://⟬hostname#1⟭:636
ldap.base=dc=banque,dc=internal
ldap.manager.dn=cn=⟬person_name#1⟭,ou=admins,dc=banque,dc=internal
ldap.manager.password=⟬password#1⟭
ldap.user.search.filter=(uid={0})
ldap.user.search.base=ou=agences
ldap.group.search.base=ou=roles
ldap.group.role.attribute=cn
ldap.pool.size=8
ldap.pool.timeout-ms=2000
ldap.truststore=/etc/annuaire/truststore.jks
ldap.truststore.password=⟬password#2⟭
⟬trap:indicator_non_pii|ldap.attribute.mail=mail⟭
⟬trap:indicator_non_pii|ldap.attribute.telephone=telephoneNumber⟭
⟬trap:indicator_non_pii|ldap.attribute.nom=sn⟭
⟬end⟭

⟬template⟭
family: config
format: .properties
language: mixed
fill_locale: fr_FR
domain: SaaS
appearance: comment, properties key, section header, url
scenario: tenant registry of a multi-client invoicing service, French keys and English comments, one block per customer with its contact, mail, API key and storage URL
⟬text⟭
# Tenant registry, read at startup. One block per customer.
# Keep keys in French: the support console prints them as field names.

# --- global ---
plateforme.nom=facturo
plateforme.region=eu-west-3
plateforme.version=⟬version#1⟭
plateforme.mail.expediteur=⟬email:generic#1⟭
plateforme.mail.mot_de_passe=⟬password#1⟭
plateforme.alerte.jeton=⟬slack_token#1⟭
plateforme.depot.jeton=⟬github_token#1⟭

# --- tenant 1 ---
client.1.nom=⟬company#2⟭
client.1.reference=⟬customer_id#2⟭
client.1.contact=⟬person_name#2⟭
client.1.mail=⟬email#2⟭
client.1.telephone=⟬phone#2⟭
client.1.adresse=⟬fr_postal_address#2⟭
client.1.cle=⟬opaque_token#1⟭
client.1.stockage=https://facturo:⟬url_password#1⟭@⟬hostname#2⟭/dav/client1
client.1.formule=entreprise

# --- tenant 2 ---
client.2.nom=⟬company#3⟭
client.2.reference=⟬customer_id#3⟭
client.2.contact=⟬person_name#3⟭
client.2.mail=⟬email#3⟭
client.2.telephone=⟬phone#3⟭
client.2.cle=⟬opaque_token#2⟭
client.2.stockage=https://facturo:⟬url_password#2⟭@⟬hostname#3⟭/dav/client2
client.2.formule=standard

# --- tenant 3 ---
client.3.nom=⟬trap:company_name|Cabinet ⦃Family⦄⟭
client.3.reference=⟬customer_id#4⟭
client.3.contact=⟬trap:indicator_non_pii|service-comptabilite⟭
client.3.mail=⟬email:generic#4⟭
client.3.adresse=⟬fr_postal_address#4⟭
client.3.cle=⟬opaque_token#3⟭
client.3.formule=standard

# --- tenant 4, trial ended on the date below ---
client.4.nom=⟬company#5⟭
client.4.reference=⟬customer_id#5⟭
client.4.contact=⟬person_name#5⟭
client.4.mail=⟬email#5⟭
client.4.fin_essai=⟬date#1⟭
# client.4.cle=⟬opaque_token#4⟭
client.4.formule=essai

# --- tenant 5, on hold for unpaid invoices ---
client.5.nom=⟬company#6⟭
client.5.reference=⟬customer_id#6⟭
client.5.contact=⟬person_name#6⟭
client.5.iban=⟬iban#6⟭
client.5.cle=⟬opaque_token#5⟭
client.5.formule=suspendue

# --- limits ---
limite.factures.mois=20000
limite.taille.pdf.ko=2048
⟬trap:indicator_non_pii|limite.utilisateurs=50⟭
⟬trap:indicator_non_pii|duree.jeton.secondes=3600⟭
⟬end⟭

⟬template⟭
family: config
format: .properties
language: mixed
fill_locale: fr_FR
domain: logistics
appearance: comment, properties key, url
scenario: Apache Camel route settings of a parcel tracking bridge, English keys and French comments, with property placeholders for every credential and traps on recipient fields
⟬text⟭
# Pont de suivi colis : routes Camel
camel.main.name=pont-suivi
camel.main.stream-caching-enabled=true
camel.springboot.main-run-controller=true

# dépôt des fichiers transporteurs
route.depot.from=ftp://⟬hostname#1⟭/depot?username={{ftp.utilisateur}}&password=⟬trap:placeholder|{{ftp.mot_de_passe}}⟭&delay=60000
route.depot.to=jms:queue:suivi.entrant
route.depot.errors=jms:queue:suivi.rejets

# appel de l'API publique de suivi
route.api.url=⟬url#1⟭
route.api.token=⟬trap:placeholder|{{api.jeton}}⟭
⟬trap:indicator_non_pii|route.api.token.header=X-Tracking-Key⟭
route.api.retries=3
route.api.header.X-Client-Ref=⟬customer_id#1⟭

# champs recopiés dans l'événement
⟬trap:indicator_non_pii|evenement.champ.destinataire=recipient_name⟭
⟬trap:indicator_non_pii|evenement.champ.telephone=recipient_phone⟭
evenement.format=json
evenement.version=⟬version#1⟭
⟬end⟭

⟬template⟭
family: config
format: .properties
language: mixed
fill_locale: en_US
domain: logistics
appearance: comment, properties key
scenario: local.properties of the delivery drivers' Android app for a Chicago courier, English keys with French comments, a maps key, a GitHub Packages token and a test driver's phone
⟬text⟭
# réglages locaux de l'appli livreurs, ne pas versionner
sdk.dir=/home/build/Android/Sdk
MAPS_API_KEY=⟬google_api_key#1⟭
GH_PACKAGES_USER=⟬username#1⟭
GH_PACKAGES_TOKEN=⟬github_token#1⟭
TEST_DRIVER_PHONE=⟬phone#1⟭
⟬end⟭
