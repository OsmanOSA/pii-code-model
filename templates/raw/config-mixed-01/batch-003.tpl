⟬template⟭
family: config
format: .env
language: mixed
fill_locale: mixed
domain: banking
appearance: comment, assignment, quoted value
scenario: end-to-end test accounts of a mobile banking backend, English keys and French comments, with a name-based login and an OTP seed
⟬text⟭
# comptes de test de l'appli mobile, jamais en prod
E2E_USER_LOGIN=⟬person_name:handle#1⟭
E2E_USER_PASSWORD=⟬password#1⟭
E2E_USER_PHONE="⟬phone#1⟭"
E2E_OTP_SEED=⟬opaque_token#1⟭
E2E_ADMIN_LOGIN=⟬username#1⟭
E2E_ADMIN_PASSWORD=⟬password#2⟭
⟬end⟭

⟬template⟭
family: config
format: .env
language: mixed
fill_locale: fr_FR
domain: e-commerce
appearance: comment, assignment, url, quoted value
scenario: Next.js production env of a cosmetics brand, English keys and French comments separating browser variables from server secrets, with one employee still receiving the contact form
⟬text⟭
# Vitrine Next.js, production
# Tout ce qui commence par NEXT_PUBLIC part dans le navigateur : pas de secret ici.
NEXT_PUBLIC_SITE_URL=⟬url#1⟭
NEXT_PUBLIC_STRIPE_KEY=⟬stripe_publishable_key#1⟭
NEXT_PUBLIC_MAPS_KEY=⟬google_api_key#1⟭
NEXT_PUBLIC_SUPPORT_PHONE="⟬phone#2⟭"

# côté serveur
STRIPE_SECRET_KEY=⟬stripe_secret_key#1⟭
REVALIDATE_SECRET=⟬opaque_token#1⟭
CMS_URL=⟬url#2⟭
CMS_PREVIEW_TOKEN=⟬opaque_token#2⟭
DATABASE_URL=mysql://vitrine:⟬url_password#1⟭@⟬hostname#1⟭:3306/vitrine
AUTH_SECRET=⟬opaque_token#3⟭

# ⟬person_name#3⟭ reçoit encore les formulaires, à basculer sur ⟬email:generic#4⟭
CONTACT_FORM_TO=⟬email#3⟭
⟬end⟭

⟬template⟭
family: config
format: .env
language: mixed
fill_locale: fr_FR
domain: logistics
appearance: comment, assignment
scenario: sample env of a fleet telematics gateway for new depots, French keys with English comments, all credentials left as placeholders and driver privacy switches that mention names and plates
⟬text⟭
# Fleet telematics gateway, sample file for new depots.
# Copy to .env, then ask the fleet team for the real values.
PASSERELLE_ENV=exemple
URL_FOURNISSEUR=⟬url#1⟭
CLE_FOURNISSEUR=⟬trap:placeholder|<fleet-vendor-key>⟭
MQTT_HOTE=⟬hostname#1⟭
MQTT_PORT=8883
⟬trap:indicator_non_pii|MQTT_UTILISATEUR=<mqtt-user>⟭
MOT_DE_PASSE_MQTT=⟬trap:placeholder|${MQTT_PASSWORD}⟭

# privacy switches, signed off with the works council
⟬trap:indicator_non_pii|NOM_CHAUFFEUR_VISIBLE=false⟭
⟬trap:indicator_non_pii|PLAQUE_MASQUEE=true⟭
⟬trap:indicator_non_pii|TELEPHONE_CHAUFFEUR_EXPORTE=false⟭
GEOLOC_HORS_SERVICE=false

# polling
INTERVALLE_POSITION_S=60
INTERVALLE_TACHYGRAPHE_S=900
TOURNEE_MAX_HEURES=10
⟬trap:indicator_non_pii|RESPONSABLE_FLOTTE=equipe-parc⟭
DERNIERE_REVUE="⟬date#1⟭"
⟬end⟭

⟬template⟭
family: config
format: .env
language: mixed
fill_locale: en_GB
domain: banking
appearance: comment, assignment, url, quoted value, section header, commented-out value
scenario: migration weekend settings of a core banking bridge at a UK subsidiary, French vendor variable names and English comments, prepared by the migration lead, with the legacy settings commented out next to the new ones
⟬text⟭
#############################################################
# Core banking bridge: migration weekend settings
# Variable names are the French ones used by the vendor's batch.
# Prepared by ⟬person_name#1⟭ (⟬email#1⟭), mobile ⟬phone#1⟭
# Change window opens on ⟬date#1⟭
#############################################################

# --- legacy mainframe side ---
# HOTE_HERITAGE=⟬hostname#1⟭
# COMPTE_HERITAGE=⟬username#1⟭
# MOT_DE_PASSE_HERITAGE=⟬password#1⟭
FICHIERS_HERITAGE=⟬file_path#1⟭
ENCODAGE_HERITAGE=cp037

# --- new core ---
URL_NOYAU=⟬url#1⟭
BASE_NOYAU=postgresql://bridge:⟬url_password#1⟭@⟬hostname#2⟭:5432/core
CLE_SERVICE_NOYAU=⟬opaque_token#1⟭
CLE_PRIVEE_NOYAU="⟬private_key#1⟭"
FILE_NOYAU=amqps://bridge:⟬url_password#2⟭@⟬hostname#3⟭:5671/core

# --- reconciliation ---
COMPTE_RAPPROCHEMENT=⟬bank_account_number#2⟭
IBAN_SUSPENS=⟬iban#2⟭
BIC_SUSPENS=⟬bic#2⟭
TOLERANCE_ECART_GBP=0.01
LOT_MAX=5000

# --- tooling ---
JETON_DEPOT_SCRIPTS=⟬github_token#1⟭
JETON_SALON_MIGRATION=⟬slack_token#1⟭
SALON_MIGRATION=migration-noyau
CLE_CARTES_AGENCES=⟬google_api_key#1⟭

# --- sign-off ---
VALIDEUR_METIER="⟬person_name#3⟭"
VALIDEUR_TECHNIQUE="⟬person_name#4⟭"
⟬trap:indicator_non_pii|RESPONSABLE_RETOUR_ARRIERE=cellule-migration⟭
⟬trap:indicator_non_pii|VALIDEUR_AUTOMATIQUE=robot-controle⟭
ADRESSE_CENTRE_REPLI="⟬postal_address#5⟭"
TELEPHONE_CENTRE_REPLI="⟬phone#5⟭"

# --- batch windows ---
DEBUT_GEL_ECRITURES=22:00
FIN_GEL_ECRITURES=06:00
NOMBRE_LOTS_PARALLELES=6
REPRISE_AUTOMATIQUE=false
DELAI_ATTENTE_NOYAU_S=90

# --- monitoring ---
SONDE_SANTE=/sante/pret
SEUIL_ERREURS_LOT=25
URL_TABLEAU_DE_BORD=⟬url#2⟭
CLE_TABLEAU_DE_BORD=⟬opaque_token#2⟭

# --- switches ---
MODE_LECTURE_SEULE=true
ARRET_PLANIFIE=true
⟬trap:indicator_non_pii|MASQUER_NOM_TITULAIRE=true⟭
⟬trap:indicator_non_pii|DUREE_JETON_MIGRATION_MINUTES=120⟭
NIVEAU_JOURNAL=debug
VERSION_PONT=⟬version#1⟭
COMMIT_PONT=⟬git_sha#1⟭
⟬end⟭

⟬template⟭
family: config
format: .env
language: mixed
fill_locale: en_US
domain: SaaS
appearance: comment, assignment, quoted value
scenario: env of an on-call assistant bot running in the US region of a French startup, English keys and French comments, with the rota names written directly and a GitHub App key on one line
⟬text⟭
# bot d'astreinte, instance américaine
SLACK_BOT_TOKEN=⟬slack_token#1⟭
SLACK_APP_TOKEN=⟬slack_token#2⟭
SLACK_SIGNING_SECRET=⟬opaque_token#1⟭
ONCALL_CHANNEL=sre-oncall

# appli GitHub pour lire les incidents, la clé tient sur une ligne
GITHUB_APP_ID=482913
GITHUB_APP_PRIVATE_KEY="⟬private_key#1⟭"
GITHUB_PAT_FALLBACK=⟬github_token#1⟭

# rotation de cette semaine (⟬date#1⟭), à mettre à jour le lundi
ONCALL_PRIMARY="⟬person_name#2⟭"
ONCALL_SECONDARY="⟬person_name#3⟭"
ONCALL_MANAGER="⟬person_name:given#4⟭"
⟬trap:indicator_non_pii|ONCALL_ESCALATION=equipe-sre-paris⟭
PAGE_AFTER_MINUTES=15
⟬end⟭

⟬template⟭
family: config
format: .yaml
language: mixed
fill_locale: mixed
domain: logistics
appearance: comment, YAML value, url
scenario: metrics shipping settings of a container yard, French keys and English comments, the remote write password inside the URL and a Slack token for alerts
⟬text⟭
# Remote write from the yard to the group Prometheus
ecriture_distante:
  - url: https://metriques:⟬url_password#1⟭@⟬hostname#1⟭/api/v1/push
    file_attente:
      capacite: 2500
alertes:
  jeton: ⟬slack_token#1⟭
  canal: parc-conteneurs
⟬end⟭

⟬template⟭
family: config
format: .yaml
language: mixed
fill_locale: en_US
domain: SaaS
appearance: comment, YAML value, list item, nested mapping
scenario: declarative Kong gateway file of a billing API opened to American partners, English keys and French comments, consumer keys in clear and one partner's technical contact in a comment
⟬text⟭
# Passerelle API : déclaration des partenaires, générée puis retouchée à la main
_format_version: "3.0"
services:
  - name: facturation
    url: ⟬url#1⟭
    connect_timeout: 3000
    routes:
      - name: facturation-publique
        paths:
          - /v1/invoices
    plugins:
      - name: key-auth
        config:
          key_names:
            - X-Client-Ref
      - name: rate-limiting
        config:
          minute: 120
consumers:
  # contact technique du partenaire : ⟬person_name#1⟭ <⟬email#1⟭>, ⟬phone#1⟭
  - ⟬trap:indicator_non_pii|username: partenaire-compta⟭
    custom_id: ⟬customer_id#1⟭
    keyauth_credentials:
      - key: ⟬opaque_token#1⟭
  - username: partenaire-paie
    custom_id: ⟬customer_id#2⟭
    keyauth_credentials:
      - key: ⟬opaque_token#2⟭
      # clé précédente, à garder jusqu'au ⟬date#1⟭
      - key: ⟬opaque_token#3⟭
⟬end⟭

⟬template⟭
family: config
format: .yaml
language: mixed
fill_locale: fr_FR
domain: e-commerce
appearance: comment, YAML value, list item, multi-document
scenario: Kubernetes deployment of a shop search service, English keys and French comments, every secret coming from a secret reference, the cluster named after a person and nothing sensitive in the file
⟬text⟭
# Recherche catalogue : déploiement de production
# Les mots de passe restent dans le Secret recherche-identifiants, créé par l'équipe plateforme.
apiVersion: apps/v1
kind: Deployment
metadata:
  name: recherche-catalogue
  namespace: boutique
  labels:
    app: recherche-catalogue
    ⟬trap:indicator_non_pii|owner: equipe-recherche⟭
spec:
  replicas: 4
  selector:
    matchLabels:
      app: recherche-catalogue
  strategy:
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0
  template:
    metadata:
      labels:
        app: recherche-catalogue
    spec:
      containers:
        - name: api
          image: ⟬hostname#1⟭/boutique/recherche:⟬version#1⟭
          ports:
            - containerPort: 8080
          env:
            - name: ES_CLUSTER_NAME
              value: ⟬trap:eponym|⦃family⦄⟭
            - name: ES_HOSTS
              value: ⟬hostname#2⟭:9200
            - name: ES_USERNAME
              valueFrom:
                secretKeyRef:
                  name: recherche-identifiants
                  key: utilisateur
            - name: ES_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: recherche-identifiants
                  key: mot-de-passe
            - name: SYNONYMS_FILE
              value: ⟬file_path#1⟭
            # distance de ⟬trap:eponym|Levenshtein⟭ limitée à 2 sur les noms de produits
            - name: FUZZY_MAX_EDITS
              value: "2"
          readinessProbe:
            httpGet:
              path: /ready
              port: 8080
          resources:
            requests:
              cpu: 250m
              memory: 512Mi
            limits:
              memory: 1Gi
---
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: recherche-catalogue
  namespace: boutique
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: recherche-catalogue
  minReplicas: 4
  maxReplicas: 12
  metrics:
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: 70
⟬end⟭

⟬template⟭
family: config
format: .yaml
language: mixed
fill_locale: en_US
domain: banking
appearance: comment, YAML value, block scalar, list item, connection string
scenario: Airflow connection seed for regulatory reporting DAGs at the New York desk of a French bank, French keys and English comments, with URIs holding passwords and an SFTP key in a block
⟬text⟭
# Connection seed for the regulatory reporting DAGs, loaded at container start.
# Reviewed by ⟬person_name#1⟭ on ⟬date#1⟭
connexions:
  - id: entrepot_risques
    type: postgres
    uri: postgresql://reporting:⟬url_password#1⟭@⟬hostname#1⟭:5432/risques
  - id: cache_resultats
    type: redis
    uri: redis://:⟬url_password#2⟭@⟬hostname#2⟭:6379/2
  - id: depot_regulateur
    type: sftp
    hote: ⟬hostname#3⟭
    utilisateur: ⟬username#1⟭
    cle_privee: |
      ⟬private_key#1⟭
  - id: annuaire_clients
    type: http
    hote: ⟬url#1⟭
    mot_de_passe: "⟬password#1⟭"
variables:
  fenetre_declaration: T+1
  ⟬trap:indicator_non_pii|contact_conformite: desk-compliance-ny⟭
  ⟬trap:indicator_non_pii|champ_ssn_masque: true⟭
⟬end⟭

⟬template⟭
family: config
format: .yaml
language: mixed
fill_locale: mixed
domain: e-commerce
appearance: comment, YAML value, block scalar
scenario: dbt profiles.yml copied onto a laptop for a sales analytics demo, English keys and French comments, a BigQuery service account inlined and a Postgres production password
⟬text⟭
# profiles.yml copié sur le poste de ⟬person_name:given#1⟭ pour la démo du ⟬date#1⟭
entrepot_ventes:
  target: dev
  outputs:
    dev:
      type: bigquery
      method: service-account-json
      project: ventes-analytics
      dataset: dbt_demo
      threads: 4
      keyfile_json:
        type: service_account
        project_id: ventes-analytics
        private_key_id: "⟬hash#1⟭"
        private_key: |
          ⟬private_key#1⟭
        client_email: ⟬email:generic#2⟭
        client_id: "⟬customer_id#2⟭"
    prod:
      type: postgres
      host: ⟬hostname#1⟭
      port: 5432
      user: dbt_prod
      password: "⟬password#1⟭"
      dbname: ventes
      schema: marts
      threads: 8
⟬end⟭

⟬template⟭
family: config
format: .json
language: mixed
fill_locale: en_GB
domain: logistics
appearance: nested JSON, string value
scenario: VS Code launch.json of a UK courier's tracking API, English keys and a French launch label from the Lille team, environment secrets pasted in for debugging
⟬text⟭
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Lancer l'API de suivi",
      "type": "node", "request": "launch",
      "program": "${workspaceFolder}/src/server.js",
      "env": {
        "MAPS_KEY": "⟬google_api_key#1⟭",
        "PAYMENT_KEY": "⟬stripe_secret_key#1⟭",
        "CLIENT_REF": "⟬opaque_token#1⟭"
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
domain: e-commerce
appearance: nested JSON, string value
scenario: Composer auth.json of a Magento shop, standard English keys with a French remark, a GitHub token and repository credentials that look like usernames but are keys
⟬text⟭
{
  "github-oauth": {
    "github.com": "⟬github_token#1⟭"
  },
  "http-basic": {
    "repo.magento.com": {
      "username": "⟬opaque_token#1⟭",
      "password": "⟬opaque_token#2⟭"
    }
  },
  "remarque": "copié depuis le poste de ⟬person_name#1⟭, à retirer du dépôt"
}
⟬end⟭

⟬template⟭
family: config
format: .json
language: mixed
fill_locale: mixed
domain: SaaS
appearance: nested JSON, string value, array
scenario: dump of the secrets of a time tracking product taken with the AWS command line for a migration, English API keys and French secret names, one secret holding a JSON string
⟬text⟭
{
  "_note": "extraction pour la migration vers le nouveau compte, à supprimer ensuite",
  "SecretValues": [
    {
      "Name": "pointage/prod/base",
      "VersionId": "⟬uuid#1⟭",
      "SecretString": "{\"utilisateur\":\"pointage\",\"mot_de_passe\":\"⟬password#1⟭\",\"hote\":\"⟬hostname#1⟭\"}",
      "CreatedDate": "⟬date#1⟭"
    },
    {
      "Name": "pointage/prod/facturation",
      "VersionId": "⟬uuid#2⟭",
      "SecretString": "⟬stripe_secret_key#1⟭",
      "CreatedDate": "⟬date#2⟭"
    },
    {
      "Name": "pointage/prod/signature-jetons",
      "VersionId": "⟬uuid#3⟭",
      "SecretString": "⟬private_key#1⟭",
      "CreatedDate": "⟬date#3⟭"
    },
    {
      "Name": "pointage/prod/notifications",
      "VersionId": "⟬uuid#4⟭",
      "SecretString": "⟬slack_token#1⟭",
      "CreatedDate": "⟬date#3⟭"
    }
  ],
  "InvalidParameters": []
}
⟬end⟭

⟬template⟭
family: config
format: .json
language: mixed
fill_locale: mixed
domain: banking
appearance: nested JSON, string value, array
scenario: JSON Schema of a customer onboarding form at a retail bank, French property names and English descriptions, every field sounding personal but no personal value, examples being placeholders
⟬text⟭
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "$id": "⟬url#1⟭",
  "title": "Dossier d'entrée en relation",
  "description": "Onboarding form, version ⟬version#1⟭. Reviewed by the compliance team.",
  "type": "object",
  "required": ["nom_naissance", "date_naissance", "iban_reference"],
  "properties": {
    "⟬trap:indicator_non_pii|nom_naissance⟭": {
      "type": "string",
      "maxLength": 80,
      "description": "Birth name as printed on the identity document",
      "examples": ["⟬trap:indicator_non_pii|<NOM>⟭"]
    },
    "⟬trap:indicator_non_pii|date_naissance⟭": {
      "type": "string",
      "format": "date",
      "description": "Holder must be 18 or older"
    },
    "⟬trap:indicator_non_pii|iban_reference⟭": {
      "type": "string",
      "pattern": "^[A-Z]{2}[0-9]{2}[A-Z0-9]{11,30}$",
      "description": "Account used for the first transfer",
      "examples": ["⟬trap:indicator_non_pii|FRXX XXXX XXXX XXXX⟭"]
    },
    "pays_residence": {
      "type": "string",
      "default": "⟬country#1⟭"
    }
  }
}
⟬end⟭

⟬template⟭
family: config
format: .json
language: mixed
fill_locale: fr_FR
domain: logistics
appearance: nested JSON, string value, array, inline code
scenario: Node-RED flow export of a cold chain monitoring setup, English node fields and French labels, broker credentials, a Slack token in a function node and a maps key in a request node
⟬text⟭
[
  {
    "id": "a1f3c2d4.1b2e3",
    "type": "tab",
    "label": "Capteurs chambre froide",
    "disabled": false,
    "info": "Remontée des températures. Contact exploitation : ⟬person_name#1⟭, ⟬phone#1⟭."
  },
  {
    "id": "c7d81e22.5f6a1",
    "type": "mqtt-broker",
    "name": "Courtier entrepôt",
    "broker": "⟬hostname#1⟭",
    "port": "8883",
    "usetls": true,
    "clientid": "chambre-froide-01",
    "credentials": {
      "user": "⟬username#1⟭",
      "password": "⟬password#1⟭"
    }
  },
  {
    "id": "3e9b77f1.0c4d2",
    "type": "mqtt in",
    "z": "a1f3c2d4.1b2e3",
    "name": "Sondes",
    "topic": "entrepot/froid/+/temperature",
    "qos": "1",
    "broker": "c7d81e22.5f6a1",
    "wires": [["5d20aa18.9e7b3"]]
  },
  {
    "id": "5d20aa18.9e7b3",
    "type": "function",
    "z": "a1f3c2d4.1b2e3",
    "name": "Seuil dépassé",
    "func": "if (msg.payload > -18) {\n  msg.headers = { Authorization: \"Bearer ⟬slack_token#1⟭\" };\n  msg.payload = { channel: \"froid-alertes\", text: \"Température haute\" };\n  return msg;\n}\nreturn null;",
    "outputs": 1,
    "wires": [["b81f4c06.77de2"]]
  },
  {
    "id": "b81f4c06.77de2",
    "type": "http request",
    "z": "a1f3c2d4.1b2e3",
    "name": "Alerte Slack",
    "method": "POST",
    "url": "https://slack.com/api/chat.postMessage",
    "wires": [[]]
  },
  {
    "id": "e4402ab9.1d3c5",
    "type": "http request",
    "z": "a1f3c2d4.1b2e3",
    "name": "Géocoder le camion",
    "method": "GET",
    "url": "https://maps.googleapis.com/maps/api/geocode/json?key=⟬google_api_key#1⟭&address={{adresse}}",
    "wires": [["7a19dc33.8c2f1"]]
  },
  {
    "id": "7a19dc33.8c2f1",
    "type": "debug",
    "z": "a1f3c2d4.1b2e3",
    "name": "Journal",
    "active": true,
    "complete": "payload",
    "wires": []
  },
  {
    "id": "1b6f0e47.2a9d8",
    "type": "comment",
    "z": "a1f3c2d4.1b2e3",
    "name": "Entrepôt de référence",
    "info": "⟬fr_postal_address#2⟭, responsable ⟬trap:indicator_non_pii|equipe-qualite-froid⟭"
  }
]
⟬end⟭

⟬template⟭
family: config
format: .properties
language: mixed
fill_locale: fr_FR
domain: banking
appearance: comment, properties key
scenario: labels of SEPA rejection reasons for a back office screen, English keys and French values, with no customer data
⟬text⟭
# motifs de rejet SEPA, écran de back office
rejet.AC01.label=IBAN incorrect
rejet.AC04.label=Compte clôturé
rejet.AM04.label=Provision insuffisante
rejet.MD01.label=Mandat absent
rejet.MS03.label=Motif non communiqué
rejet.RC01.label=BIC incorrect
⟬trap:indicator_non_pii|rejet.iban.masque=true⟭
⟬trap:indicator_non_pii|rejet.titulaire.affiche=false⟭
⟬end⟭

⟬template⟭
family: config
format: .properties
language: mixed
fill_locale: en_US
domain: SaaS
appearance: comment, properties key
scenario: gradle.properties used to publish a Java SDK, English keys with French comments, publication passwords, a GitHub packages token, and the developer named in the POM fields
⟬text⟭
# publication du SDK vers Maven Central et GitHub Packages
GROUP=io.quickstats
VERSION_NAME=⟬version#1⟭
POM_NAME=quickstats-sdk
POM_DEVELOPER_ID=quickstats
POM_DEVELOPER_NAME=⟬person_name#1⟭
POM_DEVELOPER_EMAIL=⟬email#1⟭
POM_LICENSE_NAME=Apache-2.0

# à déplacer dans ~/.gradle, ce fichier part dans le dépôt
ossrhUsername=⟬username#1⟭
ossrhPassword=⟬password#1⟭
signing.keyId=7F3A91C2
signing.password=⟬password#2⟭
signing.secretKeyRingFile=/home/ci/.gnupg/secring.gpg
gpr.user=⟬username#2⟭
gpr.key=⟬github_token#1⟭
org.gradle.caching=true
⟬end⟭

⟬template⟭
family: config
format: .properties
language: mixed
fill_locale: mixed
domain: e-commerce
appearance: comment, properties key, url
scenario: notification gateway of a fashion resale site, French keys and English comments, SMTP and SMS credentials, a card payment key and the marketing lead who signs the newsletters
⟬text⟭
# Notification gateway. Keys stay in French, the back office shows them as labels.
courriel.hote=⟬hostname#1⟭
courriel.port=587
courriel.utilisateur=⟬email:generic#1⟭
courriel.mot_de_passe=⟬password#1⟭
courriel.signature=⟬person_name#2⟭
courriel.reponse=⟬email#2⟭

# SMS vendor wants the password in the URL, sadly
sms.url=https://boutique:⟬url_password#1⟭@⟬hostname#2⟭/v2/sms
sms.expediteur=REVENTE
sms.quota.jour=4000

paiement.cle=⟬stripe_secret_key#1⟭
paiement.ref=⟬opaque_token#1⟭
⟬trap:indicator_non_pii|paiement.titulaire.champ=nom_carte⟭

newsletter.envoi.cron=0 0 8 * * MON
⟬trap:indicator_non_pii|newsletter.auteur=equipe-marketing⟭
⟬trap:indicator_non_pii|courriel.max.par.heure=1200⟭
⟬end⟭

⟬template⟭
family: config
format: .properties
language: mixed
fill_locale: fr_FR
domain: logistics
appearance: comment, properties key, section header, url
scenario: warehouse management settings of a regional distributor, French keys and English comments from a Dublin integrator, with depot addresses, a maps key, an access note naming a street without number, and owners that are sometimes people and sometimes teams
⟬text⟭
# ================================================================
# WMS settings, Rhône valley warehouses
# Integrator notes are in English, keys follow the customer's naming.
# Last change: ⟬date#1⟭ by ⟬person_name#1⟭
# ================================================================

# --- database ---
base.url=jdbc:sqlserver://⟬hostname#1⟭:1433;databaseName=wms
base.utilisateur=wms_app
base.mot_de_passe=⟬password#1⟭
base.pool.max=25

# --- warehouses ---
entrepot.1.code=VLN
entrepot.1.adresse=⟬fr_postal_address#2⟭
entrepot.1.responsable=⟬person_name#3⟭
entrepot.1.telephone=⟬phone#3⟭
entrepot.1.quais=18
entrepot.1.acces=Trucks enter by the ⟬trap:word_name|rue Victor Hugo⟭ side only
entrepot.2.code=MTL
entrepot.2.adresse=⟬fr_postal_address#4⟭
entrepot.2.responsable=⟬trap:indicator_non_pii|equipe-entrepot-sud⟭
entrepot.2.telephone=⟬phone#4⟭
entrepot.2.quais=9
entrepot.3.code=AVG
entrepot.3.adresse=⟬fr_postal_address#5⟭
entrepot.3.responsable=⟬person_name#6⟭
entrepot.3.telephone=⟬phone#6⟭
entrepot.3.quais=7

# --- routing ---
carte.fournisseur=google
carte.cle=⟬google_api_key#1⟭
carte.cache.jours=14
tournee.depart.heure=05:30
tournee.arrets.max=28
tournee.tolerance.minutes=20
tournee.algorithme=⟬trap:eponym|Dijkstra⟭

# --- carriers ---
transporteur.defaut=⟬trap:company_name|Transports ⦃Family⦄⟭
transporteur.secours=⟬trap:company_name|⦃Family2⦄ Logistique⟭
transporteur.edi.url=https://edi:⟬url_password#1⟭@⟬hostname#2⟭/depot
transporteur.edi.ref=⟬opaque_token#1⟭

# --- labels ---
etiquette.format=ZPL
etiquette.imprimante.defaut=quai-3
⟬trap:indicator_non_pii|etiquette.nom.destinataire.visible=true⟭
⟬trap:indicator_non_pii|etiquette.telephone.visible=false⟭

# --- alerts ---
alerte.jeton=⟬slack_token#1⟭
alerte.canal=entrepots-incidents
alerte.mail=⟬email:generic#7⟭
⟬trap:indicator_non_pii|alerte.auteur=robot-wms⟭

# --- misc ---
journal.niveau=INFO
journal.chemin=⟬file_path#1⟭
purge.jours=120
version.logiciel=⟬version#1⟭
⟬end⟭

⟬template⟭
family: config
format: .properties
language: mixed
fill_locale: en_US
domain: SaaS
appearance: comment, properties key
scenario: sonar-project.properties of a meeting scheduling product, English keys and French comments, the token kept in the CI, nothing sensitive in the file
⟬text⟭
# analyse qualité, le jeton vient de la CI
sonar.projectKey=agenda-api
sonar.projectName=Agenda API
sonar.projectVersion=⟬version#1⟭
sonar.sources=src
sonar.tests=tests
sonar.login=⟬trap:placeholder|${SONAR_TOKEN}⟭
sonar.exclusions=**/generated/**
⟬trap:indicator_non_pii|sonar.links.owner=equipe-agenda⟭
⟬end⟭
