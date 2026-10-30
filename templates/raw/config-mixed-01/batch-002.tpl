⟬template⟭
family: config
format: .env
language: mixed
fill_locale: en_US
domain: e-commerce
appearance: comment, assignment, quoted value
scenario: env of the American storefront of a French shop, French variable names kept so the deploy script works, English comments, US manager and returns address
⟬text⟭
# US storefront. Same variable names as the French shop, the deploy script depends on them.
BOUTIQUE_PAYS=US
DEVISE=USD
CLE_SECRETE_STRIPE=⟬stripe_secret_key#1⟭
CLE_PUBLIQUE_STRIPE=⟬stripe_publishable_key#1⟭
SECRET_WEBHOOK=⟬opaque_token#1⟭
RESPONSABLE_BOUTIQUE="⟬person_name#2⟭"
TELEPHONE_SERVICE_CLIENT="⟬phone#2⟭"
ADRESSE_RETOURS="⟬postal_address#3⟭"
⟬end⟭

⟬template⟭
family: config
format: .env
language: mixed
fill_locale: fr_FR
domain: logistics
appearance: comment, assignment, code identifier
scenario: template env for the customs declaration workstation of a freight forwarder, English keys and French comments, credentials injected by the launcher and nothing sensitive stored
⟬text⟭
# Poste du déclarant en douane : gabarit, à ne pas remplir à la main
# Les identifiants sont injectés par le lanceur au démarrage de session.
CUSTOMS_ENV=formation
CUSTOMS_ENDPOINT=⟬url#1⟭
⟬trap:indicator_non_pii|CUSTOMS_USER=${DOUANE_USER}⟭
CUSTOMS_PASSWORD=⟬trap:placeholder|${DOUANE_PASSWORD}⟭
CUSTOMS_TIMEOUT_S=45

# mise en forme du manifeste, gardée pour le client historique
MANIFEST_FORMATTER=⟬trap:code_identifier|format_⦃family⦄_manifest⟭
MANIFEST_DIR=⟬file_path#1⟭
⟬trap:indicator_non_pii|SIGNATORY_NAME_FIELD=box_54⟭
⟬trap:indicator_non_pii|DECLARANT_ID_HEADER=X-Declarant⟭

# barème validé par ⟬trap:initials|J.-M.⟭ en comité douane, voir ⟬ticket_id#1⟭
DUTY_ROUNDING=up
DEFAULT_INCOTERM=DAP
LAST_TARIFF_UPDATE="⟬date#1⟭"
⟬end⟭

⟬template⟭
family: config
format: .env
language: mixed
fill_locale: mixed
domain: SaaS
appearance: comment, assignment, url, quoted value, section header
scenario: production stack env of a self-hosted document collaboration product, English keys and French comments, filled by hand at a customer site and holding its whole credential set
⟬text⟭
# ---------------------------------------------------------------------------
# docs-collab : environnement de production chez le client
# Déployé par ⟬person_name#1⟭ le ⟬date#1⟭ (⟬email#1⟭)
# ---------------------------------------------------------------------------
COMPOSE_PROJECT_NAME=docscollab
PUBLIC_BASE_URL=⟬url#1⟭
DEFAULT_LANGUAGE=fr
TIMEZONE=Europe/Paris
WORKERS=4

# --- données ---
POSTGRES_HOST=⟬hostname#1⟭
POSTGRES_DB=docscollab
POSTGRES_USER=docscollab
POSTGRES_PASSWORD=⟬password#1⟭
REDIS_URL=redis://:⟬url_password#1⟭@⟬hostname#2⟭:6379/0
S3_ENDPOINT=⟬url#2⟭
S3_BUCKET=docscollab-prod
S3_ACCESS_KEY=⟬aws_access_key_id#1⟭
S3_SECRET_KEY=⟬aws_secret_access_key#1⟭

# --- authentification ---
AUTH_JWT_SIGNING_KEY=⟬opaque_token#1⟭
AUTH_SESSION_TTL=43200
AUTH_PRIVATE_KEY="⟬private_key#1⟭"
AUTH_PUBLIC_KEY_ID=⟬uuid#1⟭
OIDC_CLIENT_ID=docscollab-web
OIDC_CLIENT_SECRET=⟬opaque_token#2⟭
⟬trap:indicator_non_pii|PASSWORD_MIN_LENGTH=14⟭

# --- facturation ---
STRIPE_SECRET_KEY=⟬stripe_secret_key#1⟭
STRIPE_PUBLISHABLE_KEY=⟬stripe_publishable_key#1⟭
BILLING_CONTACT="⟬person_name#3⟭"
BILLING_MAILBOX=⟬email:generic#4⟭

# --- intégrations ---
GITHUB_ACCESS_TOKEN=⟬github_token#1⟭
GITHUB_ORG=docs-collab
SLACK_BOT_TOKEN=⟬slack_token#1⟭
SLACK_CHANNEL=docs-prod
GOOGLE_DRIVE_API_KEY=⟬google_api_key#1⟭

# --- messagerie ---
SMTP_HOST=⟬hostname#3⟭
SMTP_PORT=587
SMTP_USER=⟬email:generic#5⟭
SMTP_PASSWORD=⟬password#3⟭
MAIL_SIGNATURE="⟬trap:company_name|⦃Family⦄ Conseil⟭"
⟬trap:indicator_non_pii|MAIL_REPLY_TO_ENABLED=false⟭

# --- administration ---
ADMIN_LOGIN=⟬username#1⟭
ADMIN_PASSWORD=⟬password#2⟭
SUPPORT_PHONE="⟬phone#3⟭"
⟬trap:indicator_non_pii|OWNER=infogerance-niveau2⟭
⟬trap:indicator_non_pii|TOKEN_EXPIRY_DAYS=30⟭

# --- divers ---
RELEASE_CHANNEL=stable
RELEASE_NAME=⟬trap:eponym|⦃given⦄⟭
APP_VERSION=⟬version#1⟭
TELEMETRY=off
⟬end⟭

⟬template⟭
family: config
format: .env
language: mixed
fill_locale: fr_FR
domain: banking
appearance: comment, assignment, quoted value
scenario: treasury host-to-host connection of a French corporate, French variable names and English comments by an outside integrator, with the EBICS signing key and the two signatories
⟬text⟭
# EBICS host-to-host link, treasury workstation.
# Integrator note: keys were generated on site, the bank validated them by letter.
HOTE_EBICS=⟬url#1⟭
ID_HOTE_EBICS=BANQUEFR
ID_PARTENAIRE=⟬username#1⟭
ID_UTILISATEUR=⟬username#2⟭
CLE_PRIVEE_EBICS="⟬private_key#1⟭"
MOT_DE_PASSE_CLE=⟬password#1⟭
EMPREINTE_BANQUE=⟬hash#1⟭

# legal entity
RAISON_SOCIALE="⟬company#3⟭"
SIREN_SOCIETE=⟬fr_siren#3⟭
IBAN_TRESORERIE=⟬iban#3⟭
BIC_TRESORERIE=⟬bic#3⟭

# both must sign above the threshold
SIGNATAIRE_PRINCIPAL="⟬person_name#4⟭"
SIGNATAIRE_SUPPLEANT="⟬person_name#5⟭"
SEUIL_DOUBLE_SIGNATURE_EUR=50000
⟬trap:indicator_non_pii|FORMAT_NOM_SIGNATAIRE=NOM_PRENOM⟭
⟬end⟭

⟬template⟭
family: config
format: .env
language: mixed
fill_locale: fr_FR
domain: logistics
appearance: comment, assignment
scenario: scanner gateway settings on a dock PC, French keys and English comments, with a bearer token under the key value and the old Wi-Fi password pasted alone in a comment
⟬text⟭
# dock 4 scanner gateway
PORT_PASSERELLE=7070
PROFIL_DOUCHETTE=quai4
value=⟬opaque_token#1⟭
# old wifi, in case the new AP fails again: ⟬password#1⟭
SSID_SECOURS=entrepot-secours
DELAI_RECONNEXION_S=20
⟬end⟭

⟬template⟭
family: config
format: .yaml
language: mixed
fill_locale: fr_FR
domain: banking
appearance: comment, YAML value, block scalar
scenario: Helm secrets file for an open banking connector, French keys and English comments, supposed to be encrypted before commit but still in clear
⟬text⟭
# secrets.yaml, encrypt with sops before committing (not done yet)
connecteur_dsp2:
  reference_client: ⟬opaque_token#1⟭
  cle_mtls: |
    ⟬private_key#1⟭
base:
  mot_de_passe: "⟬password#1⟭"
⟬end⟭

⟬template⟭
family: config
format: .yaml
language: mixed
fill_locale: fr_FR
domain: e-commerce
appearance: comment, YAML value, list item, nested mapping
scenario: OpenAPI description of a marketplace returns API, English keys and French descriptions, with schema fields that sound personal but no personal value, and placeholders in the examples
⟬text⟭
# API des retours : contrat public, généré puis relu à la main
openapi: 3.0.3
info:
  title: API Retours
  version: "⟬version#1⟭"
  description: Gestion des retours et remboursements de la marketplace.
  contact:
    ⟬trap:indicator_non_pii|name: Equipe SAV⟭
    url: ⟬url#1⟭
servers:
  - url: ⟬url#2⟭
    description: bac à sable
security:
  - apiKeyAuth: []
paths:
  /retours:
    post:
      summary: Créer une demande de retour
      operationId: creerRetour
      parameters:
        - ⟬trap:indicator_non_pii|name: X-Api-Key⟭
          in: header
          required: true
          schema:
            type: string
          example: ⟬trap:placeholder|<votre-cle-api>⟭
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: "#/components/schemas/Retour"
      responses:
        "201":
          description: Demande enregistrée
        "422":
          description: Commande introuvable ou hors délai
  /retours/{id}:
    get:
      summary: Consulter une demande
      operationId: lireRetour
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: string
          example: ⟬uuid#1⟭
      responses:
        "200":
          description: Demande trouvée
components:
  securitySchemes:
    apiKeyAuth:
      type: apiKey
      in: header
      name: X-Api-Key
  schemas:
    Retour:
      type: object
      required: [commande, motif]
      properties:
        commande:
          type: string
          example: ⟬order_number#1⟭
        client:
          type: string
          example: ⟬customer_id#1⟭
        motif:
          type: string
          enum: [casse, erreur, retractation]
        ⟬trap:indicator_non_pii|email_client⟭:
          type: string
          format: email
          example: ⟬trap:indicator_non_pii|<email-du-client>⟭
        ⟬trap:indicator_non_pii|date_naissance⟭:
          type: string
          format: date
          description: Demandée pour les vins et spiritueux seulement.
        ⟬trap:indicator_non_pii|telephone⟭:
          type: string
          pattern: "^[+0-9 ]{10,16}$"
⟬end⟭

⟬template⟭
family: config
format: .yaml
language: mixed
fill_locale: fr_FR
domain: logistics
appearance: comment, YAML value, list item
scenario: Alertmanager configuration of a parcel sorting hub, English keys with French comments, the SMTP password, a Slack token and a pager key written directly, and a shift lead reachable by mail
⟬text⟭
# Alertmanager du hub de tri
global:
  resolve_timeout: 5m
  smtp_smarthost: ⟬hostname#1⟭:587
  smtp_from: ⟬email:generic#1⟭
  smtp_auth_username: ⟬email:generic#1⟭
  smtp_auth_password: "⟬password#1⟭"

route:
  receiver: astreinte-tri
  group_by: [alertname, site]
  group_wait: 30s
  repeat_interval: 4h
  routes:
    - matchers: [severity="critical"]
      receiver: pager-nuit

receivers:
  - name: astreinte-tri
    slack_configs:
      - api_url: https://slack.com/api/chat.postMessage
        channel: "#tri-alertes"
        http_config:
          authorization:
            credentials: ⟬slack_token#1⟭
    email_configs:
      # ⟬person_name#2⟭, chef d'équipe de nuit
      - to: ⟬email#2⟭
  - name: pager-nuit
    opsgenie_configs:
      - api_key: ⟬opaque_token#1⟭
        message: "Convoyeur à l'arrêt sur {{ .GroupLabels.site }}"
⟬end⟭

⟬template⟭
family: config
format: .yaml
language: mixed
fill_locale: en_US
domain: SaaS
appearance: comment, YAML value, block scalar, list item, curl command
scenario: GitHub Actions workflow of a survey product written in a hurry, French step names and English keys, end-to-end tests with secrets pasted in place of the secrets store
⟬text⟭
# TODO passer tout ça en secrets d'organisation avant la démo
name: Tests de bout en bout
on:
  push:
    branches: [main]
jobs:
  e2e:
    runs-on: ubuntu-latest
    env:
      GH_TOKEN: ⟬github_token#1⟭
      STRIPE_KEY: ⟬stripe_secret_key#1⟭
      SLACK_TOKEN: ⟬slack_token#1⟭
      DEPLOY_TOKEN: ⟬trap:placeholder|${{ secrets.DEPLOY_TOKEN }}⟭
    steps:
      - uses: ⟬trap:email_lookalike|actions/checkout@v4⟭
      - name: Installer les dépendances
        run: npm ci
      - name: Lancer les parcours
        run: npx playwright test --project=chromium
      - name: Identifier le robot
        run: |
          git config user.name "⟬trap:indicator_non_pii|survey-release-bot⟭"
          git config user.email "⟬email:generic#1⟭"
      - name: Prévenir le canal
        if: failure()
        run: |
          curl -s -X POST https://slack.com/api/chat.postMessage -H "Authorization: Bearer $SLACK_TOKEN" -d channel=survey-ci -d text=e2e-ko
⟬end⟭

⟬template⟭
family: config
format: .yaml
language: mixed
fill_locale: fr_FR
domain: banking
appearance: comment, YAML value, quoted value, test fixture
scenario: settings of a nightly direct debit batch at a regional bank, French field names from the functional spec and English comments, with a test card, a third-party account and an operator named next to a team contact
⟬text⟭
# Nightly direct debit batch. Field names follow the French functional spec.
lot_prelevements:
  fenetre_debut: "22:30"
  fenetre_fin: "04:00"
  devise: EUR
  tentative_max: 3
  ref: ⟬invoice_number#1⟭
  gestionnaire: "⟬person_name#1⟭"
  ⟬trap:indicator_non_pii|contact: cellule-flux⟭
  siren_etablissement: ⟬fr_siren#2⟭
  compte_tiers: "⟬bank_account_number#2⟭"

# used by the smoke test after each release
jeu_essai:
  titulaire: "⟬person_name#3⟭"
  iban: "⟬iban#3⟭"
  carte: "⟬payment_card#3⟭"
  cryptogramme: "⟬card_security_code#3⟭"
  ⟬trap:indicator_non_pii|nom_champ_carte: pan⟭

passerelle:
  url: ⟬url#1⟭
  utilisateur: ⟬username#1⟭
  mot_de_passe: "⟬password#1⟭"
  ref: ⟬opaque_token#1⟭
⟬end⟭

⟬template⟭
family: config
format: .json
language: mixed
fill_locale: fr_FR
domain: SaaS
appearance: nested JSON, string value
scenario: Firebase web configuration of a shared calendar app, standard English keys and a French remark that the API key is not restricted to any domain
⟬text⟭
{
  "remarque": "config web de l'agenda partagé, clé sans restriction de domaine pour l'instant",
  "apiKey": "⟬google_api_key#1⟭",
  "authDomain": "agenda-partage-recette.firebaseapp.com",
  "projectId": "agenda-partage-recette",
  "storageBucket": "agenda-partage-recette.appspot.com",
  "messagingSenderId": "493027118465",
  "appId": "1:493027118465:web:c41f0d9ab27e63"
}
⟬end⟭

⟬template⟭
family: config
format: .json
language: mixed
fill_locale: mixed
domain: e-commerce
appearance: nested JSON, connection string, string value
scenario: appsettings of an invoicing connector for a cross-border online shop, French section names with English descriptions, ADO connection strings and a Stripe key
⟬text⟭
{
  "Journalisation": {
    "Niveau": "Information",
    "Description": "Raised to Debug only during month-end closing"
  },
  "ChainesConnexion": {
    "Factures": "Server=⟬hostname#1⟭;Database=Factures;User Id=svc_factures;Password=⟬password#1⟭;Encrypt=True;",
    "Cache": "⟬hostname#2⟭:6380,password=⟬password#2⟭,ssl=True"
  },
  "Paiement": {
    "Fournisseur": "Stripe",
    "CleSecrete": "⟬stripe_secret_key#1⟭",
    "CleWebhook": "⟬opaque_token#1⟭",
    "Description": "Account of the UK entity"
  },
  "Emetteur": {
    "Societe": "⟬company#3⟭",
    "Adresse": "⟬fr_postal_address#3⟭",
    "Siret": "⟬fr_siret#3⟭",
    "ContactComptable": "⟬person_name#5⟭",
    "MailComptable": "⟬email#5⟭"
  },
  "DernierExport": "⟬date#1⟭"
}
⟬end⟭

⟬template⟭
family: config
format: .json
language: mixed
fill_locale: fr_FR
domain: logistics
appearance: nested JSON, string value, array
scenario: package.json of a shipping label generator, English manifest keys and French description, author and contributors being teams, scoped packages everywhere and no entity
⟬text⟭
{
  "name": "⟬trap:email_lookalike|@quaiflow/etiquettes⟭",
  "version": "⟬version#1⟭",
  "description": "Génération des étiquettes de transport au format ZPL",
  "author": "⟬trap:indicator_non_pii|equipe-entrepot⟭",
  "contributors": ["⟬trap:indicator_non_pii|equipe-integration⟭"],
  "license": "UNLICENSED",
  "main": "dist/index.js",
  "scripts": {
    "build": "tsc -p .",
    "test": "vitest run",
    "impression:essai": "node dist/cli.js --imprimante quai-3"
  },
  "dependencies": {
    "⟬trap:email_lookalike|@quaiflow/zpl⟭": "^2.4.0",
    "⟬trap:library|sharp⟭": "^0.33.2",
    "⟬trap:library|dayjs⟭": "^1.11.10"
  },
  "devDependencies": {
    "⟬trap:email_lookalike|@types/node⟭": "^20.11.0",
    "typescript": "^5.4.0"
  }
}
⟬end⟭

⟬template⟭
family: config
format: .json
language: mixed
fill_locale: fr_FR
domain: banking
appearance: nested JSON, string value, array
scenario: Keycloak realm export for the advisers' portal of a French bank, English keys and French display values, with client secrets, the SMTP password and two employees with temporary passwords
⟬text⟭
{
  "id": "⟬uuid#1⟭",
  "realm": "conseillers",
  "displayName": "Portail des conseillers",
  "enabled": true,
  "sslRequired": "external",
  "loginWithEmailAllowed": true,
  "duplicateEmailsAllowed": false,
  "resetPasswordAllowed": true,
  "bruteForceProtected": true,
  "failureFactor": 5,
  "⟬trap:indicator_non_pii|passwordPolicy⟭": "length(12) and notUsername",
  "internationalizationEnabled": true,
  "defaultLocale": "fr",
  "smtpServer": {
    "host": "⟬hostname#1⟭",
    "port": "587",
    "from": "⟬email:generic#2⟭",
    "fromDisplayName": "Portail des conseillers",
    "starttls": "true",
    "auth": "true",
    "user": "⟬email:generic#2⟭",
    "password": "⟬password#1⟭"
  },
  "clients": [
    {
      "clientId": "portail-conseillers",
      "name": "Portail des conseillers",
      "secret": "⟬opaque_token#1⟭",
      "redirectUris": ["⟬url#1⟭"],
      "publicClient": false,
      "standardFlowEnabled": true
    },
    {
      "clientId": "batch-reporting",
      "name": "Rapports de nuit",
      "secret": "⟬opaque_token#2⟭",
      "serviceAccountsEnabled": true,
      "standardFlowEnabled": false
    }
  ],
  "users": [
    {
      "username": "⟬person_name:handle#3⟭",
      "firstName": "⟬person_name:given#3⟭",
      "lastName": "⟬person_name:family#3⟭",
      "email": "⟬email#3⟭",
      "enabled": true,
      "credentials": [
        { "type": "password", "value": "⟬password#2⟭", "temporary": true }
      ],
      "attributes": {
        "agence": ["⟬city#3⟭"],
        "telephone": ["⟬phone#3⟭"]
      }
    },
    {
      "username": "⟬person_name:handle#4⟭",
      "firstName": "⟬person_name:given#4⟭",
      "lastName": "⟬person_name:family#4⟭",
      "email": "⟬email#4⟭",
      "enabled": true,
      "credentials": [
        { "type": "password", "value": "⟬password#3⟭", "temporary": true }
      ],
      "attributes": {
        "agence": ["⟬city#4⟭"]
      }
    }
  ],
  "identityProviders": [
    {
      "alias": "annuaire-groupe",
      "providerId": "oidc",
      "config": {
        "clientId": "keycloak-conseillers",
        "clientSecret": "⟬opaque_token#3⟭",
        "tokenUrl": "⟬url#2⟭"
      }
    }
  ]
}
⟬end⟭

⟬template⟭
family: config
format: .json
language: mixed
fill_locale: fr_FR
domain: SaaS
appearance: nested JSON, string value, array
scenario: fragment of a Terraform state file of a French SaaS platform team, English provider keys, French tags and output names, a generated private key and a GitHub secret in clear
⟬text⟭
{
  "version": 4,
  "terraform_version": "⟬version#1⟭",
  "serial": 212,
  "lineage": "⟬uuid#1⟭",
  "outputs": {
    "mot_de_passe_admin": {
      "value": "⟬password#1⟭",
      "type": "string",
      "sensitive": true
    }
  },
  "resources": [
    {
      "mode": "managed",
      "type": "tls_private_key",
      "name": "bastion",
      "instances": [
        {
          "attributes": {
            "private_key_pem": "⟬private_key#1⟭",
            "public_key_openssh": "⟬ssh_public_key#1⟭"
          }
        }
      ]
    },
    {
      "mode": "managed",
      "type": "github_actions_secret",
      "name": "deploiement",
      "instances": [
        {
          "attributes": {
            "repository": "plateforme-deploiement",
            "secret_name": "DEPLOY_TOKEN",
            "plaintext_value": "⟬github_token#1⟭",
            "tags": { "responsable": "⟬person_name#2⟭", "equipe": "plateforme" }
          }
        }
      ]
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
appearance: comment, properties key
scenario: payment settings of an old Java shop, French keys and English comments, Stripe key and a merchant reference next to an IBAN
⟬text⟭
# payment module, legacy build
paiement.fournisseur=stripe
paiement.cle.secrete=⟬stripe_secret_key#1⟭
paiement.cle.publique=⟬stripe_publishable_key#1⟭
paiement.reference=⟬opaque_token#1⟭
virement.iban=⟬iban#2⟭
virement.beneficiaire=⟬company#2⟭
⟬trap:indicator_non_pii|paiement.nom.titulaire.obligatoire=true⟭
⟬end⟭

⟬template⟭
family: config
format: .properties
language: mixed
fill_locale: en_GB
domain: logistics
appearance: comment, properties key, connection string
scenario: Kafka client properties of a port terminal integration, English keys with French comments by the Le Havre team, connecting to a broker run by a UK partner, the password inside the JAAS line
⟬text⟭
# Échange d'événements conteneurs avec le partenaire de ⟬city#1⟭
# Point de contact côté partenaire : ⟬person_name#1⟭ (⟬email#1⟭)
bootstrap.servers=⟬hostname#1⟭:9093,⟬hostname#2⟭:9093
security.protocol=SASL_SSL
sasl.mechanism=SCRAM-SHA-512
sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username="terminal-havre" password="⟬password#1⟭";
ssl.truststore.location=/etc/kafka/partenaire.jks
ssl.truststore.password=⟬password#2⟭
# le registre de schémas passe par un autre compte
schema.registry.url=https://registry:⟬url_password#1⟭@⟬hostname#3⟭:8081
basic.auth.credentials.source=URL
key.deserializer=org.apache.kafka.common.serialization.StringDeserializer
value.deserializer=io.confluent.kafka.serializers.KafkaAvroDeserializer
group.id=terminal-havre-evenements
auto.offset.reset=earliest
max.poll.records=250
⟬trap:indicator_non_pii|client.id=terminal-havre⟭
⟬end⟭

⟬template⟭
family: config
format: .properties
language: mixed
fill_locale: fr_FR
domain: banking
appearance: comment, properties key, section header
scenario: default application.properties committed in a bank's loan simulation service, English keys and French comments, every credential read from the environment and nothing sensitive in the file
⟬text⟭
# ======================================================
# Simulateur de prêt : configuration par défaut
# Les secrets viennent du coffre, jamais de ce fichier.
# ======================================================

# --- application ---
spring.application.name=simulateur-pret
spring.profiles.default=local
server.port=8080
server.servlet.context-path=/simulateur
server.compression.enabled=true
spring.main.banner-mode=off
spring.jackson.time-zone=Europe/Paris
spring.messages.basename=i18n/messages

# --- base ---
spring.datasource.url=${SIMULATEUR_DB_URL}
spring.datasource.username=${SIMULATEUR_DB_USER}
spring.datasource.password=⟬trap:placeholder|${SIMULATEUR_DB_PASSWORD}⟭
spring.datasource.hikari.maximum-pool-size=10
spring.datasource.hikari.connection-timeout=3000
spring.jpa.hibernate.ddl-auto=validate
spring.jpa.open-in-view=false
spring.flyway.enabled=true
spring.flyway.locations=classpath:db/migration

# --- sécurité ---
spring.security.oauth2.resourceserver.jwt.issuer-uri=${SIMULATEUR_ISSUER}
spring.security.oauth2.client.registration.sso.client-id=simulateur
spring.security.oauth2.client.registration.sso.client-secret=⟬trap:placeholder|${SIMULATEUR_SSO_SECRET}⟭
⟬trap:indicator_non_pii|simulateur.session.token.ttl=PT15M⟭
⟬trap:indicator_non_pii|simulateur.password.min-length=12⟭

# --- calcul ---
# amortissement constant ou méthode ⟬trap:eponym|Newton⟭ pour le TAEG
simulateur.taeg.methode=newton
simulateur.taeg.iterations-max=60
simulateur.taux.plancher=0.015
simulateur.taux.plafond=0.0725
simulateur.duree.mois-max=300
simulateur.assurance.taux-defaut=0.0034
simulateur.arrondi.decimales=2
simulateur.age.max-fin-pret=75
⟬trap:indicator_non_pii|simulateur.champ.date-naissance.requis=true⟭

# --- services amont ---
scoring.url=⟬url#1⟭
scoring.timeout-ms=2500
scoring.api-key=⟬trap:placeholder|${SCORING_API_KEY}⟭
⟬trap:indicator_non_pii|scoring.api-key.header=X-Scoring-Key⟭
referentiel.taux.url=⟬url#2⟭
referentiel.taux.cron=0 0 5 * * *

# --- exploitation ---
management.endpoints.web.exposure.include=health,info,prometheus
management.endpoint.health.probes.enabled=true
logging.level.root=INFO
logging.level.fr.banque.simulateur=INFO
logging.pattern.console=%d{ISO8601} %-5level %logger{36} - %msg%n
⟬trap:indicator_non_pii|info.app.owner=equipe-credit-immobilier⟭
info.app.version=⟬version#1⟭
info.app.commit=⟬git_sha#1⟭
⟬end⟭

⟬template⟭
family: config
format: .properties
language: mixed
fill_locale: fr_FR
domain: SaaS
appearance: comment, properties key, commented-out value, connection string
scenario: liquibase.properties of an HR software vendor, English keys and French comments, one environment active and two commented out by developers who never cleaned up
⟬text⟭
# Migrations de la base paie, à lancer depuis le poste de ⟬person_name:given#1⟭ uniquement
changeLogFile=db/changelog/master.xml
driver=org.postgresql.Driver
liquibase.hub.mode=off

# recette
url=jdbc:postgresql://⟬hostname#1⟭:5432/paie
username=paie_migrations
password=⟬password#1⟭

# prod : décommenter au dernier moment
#url=jdbc:postgresql://⟬hostname#2⟭:5432/paie
#username=paie_migrations
#password=⟬password#2⟭

# ancien serveur de ⟬person_name#3⟭, plus utilisé depuis le ⟬date#1⟭ ?
#url=jdbc:postgresql://⟬hostname#3⟭:5432/paie?user=migr&password=⟬url_password#1⟭

contexts=recette
logLevel=info
⟬trap:indicator_non_pii|liquibase.command.author=robot-migrations⟭
⟬end⟭

⟬template⟭
family: config
format: .properties
language: mixed
fill_locale: fr_FR
domain: e-commerce
appearance: comment, properties key
scenario: log4j2 settings of a Java online shop, English keys and French comments, with loggers whose names mention passwords and a masking rule, and no sensitive value
⟬text⟭
# journaux de la boutique, rotation quotidienne
status=warn
appender.rolling.type=RollingFile
appender.rolling.fileName=⟬file_path#1⟭
appender.rolling.filePattern=logs/boutique-%d{yyyy-MM-dd}.log.gz
# jamais de clair dans les journaux d'authentification
⟬trap:indicator_non_pii|logger.auth.name=com.boutique.auth.PasswordEncoder⟭
logger.auth.level=warn
⟬trap:indicator_non_pii|appender.rolling.layout.replace.regex=(password|token)=\\S+⟭
logger.panier.name=com.boutique.panier.⟬trap:code_identifier|⦃Family⦄PriceRule⟭
rootLogger.level=info
⟬end⟭
