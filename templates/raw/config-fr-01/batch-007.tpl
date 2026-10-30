⟬template⟭
family: config
format: .env
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: comment, assignment, quoted value, url
scenario: .env de l'espace adhérents d'une mutuelle santé, géré par l'équipe web interne et dupliqué à chaque campagne d'adhésion
⟬text⟭
# Espace adhérents - mutuelle santé
# Quota reCAPTCHA dépassé le ⟬date#1⟭, voir ⟬ticket_id#1⟭
APP_URL=https://⟬hostname#1⟭
APP_LOCALE=fr
MUTUELLE_NOM="⟬company#2⟭"
MUTUELLE_SIRET="⟬fr_siret#2⟭"
MUTUELLE_IBAN_PRELEVEMENT="⟬iban#2⟭"
MUTUELLE_BIC=⟬bic#2⟭
STANDARD_TEL="⟬phone#2⟭"
COTISATION_STRIPE_SK=⟬stripe_secret_key#3⟭
COTISATION_STRIPE_PK=⟬stripe_publishable_key#3⟭
RECAPTCHA_SECRET=⟬google_api_key#1⟭
⟬trap:indicator_non_pii|ADHERENT_ID_PREFIXE=ADH⟭
⟬trap:indicator_non_pii|REMBOURSEMENT_IBAN_CHECK=true⟭
DATABASE_URL=mysql://adherents:⟬url_password#1⟭@⟬hostname#3⟭:3306/adherents
⟬end⟭

⟬template⟭
family: config
format: .env
language: fr
fill_locale: fr_FR
domain: education
appearance: assignment
scenario: fichier d'environnement d'une petite plateforme de soutien scolaire en visio, monté par deux anciens enseignants devenus entrepreneurs
⟬text⟭
PLATEFORME=coup-de-pouce
STRIPE_SK=⟬stripe_secret_key#1⟭
STRIPE_PK=⟬stripe_publishable_key#1⟭
VISIO_API_SECRET=⟬opaque_token#1⟭
SLACK_PROFS=⟬slack_token#1⟭
TARIF_HEURE=28
⟬end⟭

⟬template⟭
family: config
format: .env
language: fr
fill_locale: fr_FR
domain: banking
appearance: comment, assignment, section header
scenario: .env.ci chargé par les tests du service de crédit à la consommation d'un organisme de financement, avec des valeurs factices choisies par l'équipe qualité
⟬text⟭
# .env.ci - variables des tests automatisés du service crédit
# Rien de réel : la base est recréée à chaque lancement.
CI=true
APP_ENV=test
LOG_LEVEL=warn
DATABASE_URL=postgres://ci:⟬trap:placeholder|${CI_DB_PASSWORD}⟭@localhost:5432/credit_test

# Barème de test
TAUX_NOMINAL=4.25
DUREE_MAX_MOIS=84
MONTANT_MAX=75000
⟬trap:indicator_non_pii|AGE_MAX_FIN_CREDIT=75⟭
⟬trap:indicator_non_pii|DOB_FORMAT=%Y-%m-%d⟭

# Fournisseurs simulés
BOUCHON_SCORE_URL=http://localhost:9091
BOUCHON_FICP_URL=http://localhost:9092
FICP_LOGIN=⟬trap:indicator_non_pii|ficp-test⟭
FICP_PASSWORD=⟬trap:placeholder|xxxx⟭
SIGNATURE_CLE=⟬trap:placeholder|***⟭
⟬trap:indicator_non_pii|IBAN_CHECK=false⟭
⟬trap:indicator_non_pii|CLIENT_NOM_MAX=50⟭
⟬trap:indicator_non_pii|OTP_TOKEN_TTL=120⟭

# Jeu de test
DOSSIER_EXEMPLE=⟬order_number#1⟭
CLIENT_EXEMPLE=⟬customer_id#1⟭
AGENCE_EXEMPLE="⟬city#1⟭"
⟬end⟭

⟬template⟭
family: config
format: docker-compose.yml
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: comment, YAML value, url, label, inline JSON
scenario: compose de préproduction d'un site Magento de matériel médical pour particuliers, assemblé par l'agence web et transmis au client sans nettoyage
⟬text⟭
# Préproduction Magento - agence ⟬company#1⟭
# Chef de projet agence : ⟬person_name#2⟭, ⟬email#2⟭
# Côté client : ⟬person_name#3⟭ ⟬phone#3⟭
# Prochaine recette le ⟬date#1⟭

services:
  web:
    image: ⟬hostname#1⟭/agence/nginx-magento:⟬version#1⟭
    ports:
      - "8080:8080"
    labels:
      - "agence.projet=site-materiel"
      - "agence.contact=⟬email#2⟭"
    depends_on:
      - php

  php:
    image: ⟬hostname#1⟭/agence/php-magento:8.3
    environment:
      MAGENTO_BASE_URL: https://⟬hostname#2⟭/
      MAGENTO_ADMIN_USER: ⟬trap:indicator_non_pii|admin⟭
      MAGENTO_ADMIN_PASSWORD: ⟬password#1⟭
      MAGENTO_ADMIN_EMAIL: ⟬email#2⟭
      MAGENTO_ADMIN_FIRSTNAME: ⟬person_name:given#2⟭
      MAGENTO_ADMIN_LASTNAME: ⟬person_name:family#2⟭
      MAGENTO_DB: mysql://magento:⟬url_password#1⟭@db:3306/magento
      COMPOSER_AUTH: '{"http-basic": {"repo.magento.com": {"username": "⟬hash#1⟭", "password": "⟬opaque_token#1⟭"}}}'
      STRIPE_LIVE_SK: ⟬stripe_secret_key#4⟭
      STRIPE_LIVE_PK: ⟬stripe_publishable_key#4⟭
      GOOGLE_MERCHANT_KEY: ⟬google_api_key#1⟭
      SOCIETE_SIRET: "⟬fr_siret#4⟭"
    volumes:
      - code:/var/www/html

  cron:
    image: ⟬hostname#1⟭/agence/php-magento:8.3
    command: bin/magento cron:run
    volumes:
      - code:/var/www/html

  db:
    image: ⟬trap:library|mariadb⟭:10.6
    environment:
      MARIADB_DATABASE: magento
      MARIADB_USER: magento
      MARIADB_PASSWORD: ⟬url_password#1⟭
      MARIADB_ROOT_PASSWORD: ⟬password#2⟭

  recherche:
    image: opensearchproject/opensearch:2.12.0
    environment:
      discovery.type: single-node
      plugins.security.disabled: "true"

  cache:
    image: redis:7-alpine

  vernis:
    image: ⟬trap:library|varnish⟭:7.5
    ports:
      - "80:80"

volumes:
  code:
⟬end⟭

⟬template⟭
family: config
format: docker-compose.yml
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: comment, YAML block, YAML value
scenario: docker-compose.override.yml d'un développeur du logiciel de planning du personnel soignant d'un hôpital, conservé sur le serveur de démonstration
⟬text⟭
# override perso pour la démo du planning, ne pas livrer
services:
  planning:
    environment:
      JWT_ALGO: RS256
      JWT_CLE_PRIVEE: |
        ⟬private_key#1⟭
      CADRE_DEMO: ⟬person_name#2⟭
      CADRE_DEMO_MATRICULE: ⟬customer_id#2⟭
      CADRE_DEMO_TEL: "⟬phone#2⟭"
      ⟬trap:indicator_non_pii|EQUIPE_NUIT_SERVICE: reanimation⟭
⟬end⟭

⟬template⟭
family: config
format: docker-compose.yml
language: fr
fill_locale: fr_FR
domain: public administration
appearance: comment, YAML value, environment list
scenario: compose de la centralisation des journaux d'une préfecture, écrit par le RSSI adjoint avec des variables chargées depuis le coffre au démarrage
⟬text⟭
# Centralisation des journaux - durée de conservation : 12 mois
services:
  recherche:
    image: opensearchproject/opensearch:2.15.0
    environment:
      - cluster.name=journaux-prefecture
      - discovery.type=single-node
      - OPENSEARCH_JAVA_OPTS=-Xms4g -Xmx4g
      - OPENSEARCH_INITIAL_ADMIN_PASSWORD=⟬trap:placeholder|${OPENSEARCH_ADMIN_PASSWORD:?}⟭
    volumes:
      - journaux:/usr/share/opensearch/data

  tableaux:
    image: opensearchproject/opensearch-dashboards:2.15.0
    environment:
      OPENSEARCH_HOSTS: '["https://recherche:9200"]'
      OPENSEARCH_USERNAME: ⟬trap:indicator_non_pii|kibanaserver⟭
      OPENSEARCH_PASSWORD: ⟬trap:placeholder|${DASHBOARDS_PASSWORD}⟭
    ports:
      - "5601:5601"

  collecte:
    image: ⟬trap:library|logstash⟭:8.14.1
    environment:
      LS_JAVA_OPTS: -Xms1g -Xmx1g
      SORTIE_UTILISATEUR: ⟬trap:indicator_non_pii|logstash⟭
      SORTIE_MOT_DE_PASSE: ⟬trap:placeholder|${LOGSTASH_PASSWORD}⟭
    volumes:
      - ./pipeline:/usr/share/logstash/pipeline:ro
    ports:
      - "5044:5044"
      - "514:514/udp"

  alertes:
    image: ⟬hostname#1⟭/ssi/elastalert:⟬version#1⟭
    environment:
      ES_HOST: recherche
      ⟬trap:indicator_non_pii|REGLE_USER_INCONNU: active⟭
      ⟬trap:indicator_non_pii|SEUIL_ECHECS_MOT_DE_PASSE: 10⟭
      CANAL: ssi-alertes

volumes:
  journaux:
⟬end⟭

⟬template⟭
family: config
format: Kubernetes .yaml
language: fr
fill_locale: fr_FR
domain: education
appearance: comment, nested mapping, YAML value
scenario: values.yaml de la visioconférence Jitsi d'un réseau de lycées agricoles, personnalisé par le correspondant numérique régional
⟬text⟭
# Visio des lycées agricoles - valeurs du chart
# Correspondant numérique régional : ⟬person_name#1m⟭
# Assistance enseignants : ⟬phone#2⟭ ou ⟬email:generic#2⟭

publicURL: https://⟬hostname#1⟭
tz: Europe/Paris
enableAuth: true
enableGuests: true

web:
  replicaCount: 2
  image:
    repository: jitsi/web
    tag: stable-9584
  extraEnvs:
    INTERFACE_APP_NAME: Visio des lycées
    SUPPORT_URL: ⟬url#1⟭

jicofo:
  xmpp:
    password: ⟬password#1⟭
    componentSecret: ⟬opaque_token#1⟭

jvb:
  xmpp:
    user: jvb
    password: ⟬password#2⟭
  stunServers: meet-jit-si-turnrelay.jitsi.net:443

prosody:
  extraEnvs:
    JWT_APP_ID: visio-lycees
    JWT_APP_SECRET: ⟬opaque_token#2⟭
    ⟬trap:indicator_non_pii|JWT_TOKEN_TTL: 7200⟭

enregistrement:
  actif: false
  notification:
    slackToken: ⟬slack_token#1⟭
    canal: visio-lycees
⟬end⟭

⟬template⟭
family: config
format: Kubernetes .yaml
language: fr
fill_locale: fr_FR
domain: banking
appearance: stringData, YAML block
scenario: Secret du certificat client utilisé pour l'accès au réseau interbancaire, appliqué une fois à la main par un ingénieur de production
⟬text⟭
apiVersion: v1
kind: Secret
metadata:
  name: interbancaire-client
  namespace: reglements
type: Opaque
stringData:
  client.key: |
    ⟬private_key#1⟭
  phrase: ⟬password#1⟭
⟬end⟭

⟬template⟭
family: config
format: Kubernetes .yaml
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: custom resource, label, comment
scenario: déploiement progressif du service de panier d'un distributeur de jardinage, avec analyse automatique préparée par les ingénieurs fiabilité
⟬text⟭
# Panier : déploiement canari, retour arrière automatique si le taux d'erreur monte
apiVersion: argoproj.io/v1alpha1
kind: Rollout
metadata:
  name: panier
  namespace: ⟬trap:code_identifier|⦃family⦄-boutique⟭
  labels:
    ⟬trap:indicator_non_pii|owner: fiabilite⟭
spec:
  replicas: 12
  strategy:
    canary:
      steps:
        - setWeight: 10
        - pause: {duration: 5m}
        - analysis:
            templates:
              - templateName: taux-erreur
        - setWeight: 50
        - pause: {duration: 10m}
  selector:
    matchLabels:
      app: panier
  template:
    metadata:
      labels:
        app: panier
    spec:
      containers:
        - name: panier
          image: ⟬hostname#1⟭/boutique/panier:⟬version#1⟭
          env:
            - name: PROMOTION_EN_COURS
              value: Printemps ⟬trap:word_name|Rose⟭
---
apiVersion: argoproj.io/v1alpha1
kind: AnalysisTemplate
metadata:
  name: taux-erreur
  namespace: ⟬trap:code_identifier|⦃family⦄-boutique⟭
spec:
  metrics:
    - name: taux-erreur
      interval: 1m
      failureLimit: 2
      successCondition: result[0] < 0.02
      provider:
        prometheus:
          address: ⟬url#1⟭
          query: sum(rate(http_requests_total{app="panier",code=~"5.."}[2m]))
⟬end⟭

⟬template⟭
family: config
format: GitHub Actions .yml
language: fr
fill_locale: fr_FR
domain: energy
appearance: YAML block, environment variable, secret reference, public key, curl command, comment
scenario: mise à jour des passerelles de terrain d'un exploitant de parcs solaires, lancée à la main par l'équipe d'exploitation via Ansible
⟬text⟭
name: maj-passerelles-terrain

on:
  workflow_dispatch:
    inputs:
      parc:
        description: Parc à mettre à jour
        required: true

jobs:
  ansible:
    runs-on: [self-hosted, exploitation]
    env:
      ANSIBLE_HOST_KEY_CHECKING: "false"
      ANSIBLE_VAULT_PASSWORD: ⟬password#1⟭
      CLE_BASTION_PUBLIQUE: ⟬ssh_public_key#1⟭
      CLE_BASTION: |
        ⟬private_key#1⟭
    steps:
      - uses: ⟬trap:email_lookalike|actions/checkout@v4⟭
      - run: pip install ansible
      - run: |
          echo "$CLE_BASTION" > /tmp/bastion && chmod 600 /tmp/bastion
          ansible-playbook -i inventaires/${{ inputs.parc }}.ini maj.yml --key-file /tmp/bastion
      # responsable d'exploitation : ⟬person_name#1⟭
      - name: Compte rendu
        if: always()
        run: |
          curl -s https://slack.com/api/chat.postMessage \
            -H "Authorization: Bearer ⟬slack_token#1⟭" \
            -d channel=exploitation-solaire \
            -d text="Mise à jour du parc ${{ inputs.parc }} terminée"
      - name: Carte des passerelles
        run: python scripts/carte.py --cle ⟬google_api_key#1⟭
⟬end⟭

⟬template⟭
family: config
format: GitHub Actions .yml
language: fr
fill_locale: fr_FR
domain: banking
appearance: command line
scenario: sauvegarde chiffrée de la base de test d'un service d'épargne, ajoutée par un développeur en attendant le passage à l'outil officiel
⟬text⟭
name: sauvegarde-base-test
on:
  schedule:
    - cron: "0 22 * * *"
jobs:
  sauvegarde:
    runs-on: self-hosted
    steps:
      - run: mysqldump -h ⟬hostname#1⟭ -u ⟬username#1⟭ --password=⟬password#1⟭ epargne > base.sql
      - run: gpg --batch --passphrase "⟬password#2⟭" -c base.sql
⟬end⟭

⟬template⟭
family: config
format: GitHub Actions .yml
language: fr
fill_locale: fr_FR
domain: public administration
appearance: comment, reusable workflow, YAML value, secret reference
scenario: workflow réutilisable d'audit d'accessibilité des sites d'une collectivité, publié par la mission numérique pour toutes les directions
⟬text⟭
# Audit d'accessibilité (RGAA) réutilisable par les dépôts de la collectivité
name: audit-accessibilite

on:
  workflow_call:
    inputs:
      url:
        type: string
        required: true
      seuil:
        type: number
        default: 85
    secrets:
      JETON_RAPPORT:
        required: false

jobs:
  audit:
    runs-on: ubuntu-latest
    steps:
      - uses: ⟬trap:email_lookalike|actions/checkout@v4⟭
      - uses: ⟬trap:email_lookalike|actions/setup-node@v4⟭
        with:
          node-version: 20
      - run: npx ⟬trap:email_lookalike|@axe-core/cli⟭ ${{ inputs.url }} --save rapport.json
      - run: npx ⟬trap:library|pa11y⟭-ci --threshold 5
      - name: Calcul du taux de conformité
        run: node scripts/taux.js rapport.json ${{ inputs.seuil }}
      - name: Envoi au tableau de bord
        if: ${{ github.ref == 'refs/heads/main' }}
        run: |
          curl -fsS -H "Authorization: Bearer $JETON" -F ⟬trap:email_lookalike|fichier=@rapport.json⟭ ⟬url#1⟭
        env:
          JETON: ⟬trap:placeholder|${{ secrets.JETON_RAPPORT }}⟭
⟬end⟭

⟬template⟭
family: config
format: .json
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: nested JSON, string value
scenario: sftp.json de l'extension VS Code d'un webmaster qui dépose à la main les pages du site d'un cabinet médical
⟬text⟭
{
  "name": "Site du cabinet",
  "host": "⟬hostname#1⟭",
  "protocol": "sftp",
  "port": 22,
  "username": "⟬username#1⟭",
  "password": "⟬password#1⟭",
  "remotePath": "/var/www/cabinet",
  "uploadOnSave": true,
  "ignore": [".vscode", ".git", "node_modules"]
}
⟬end⟭

⟬template⟭
family: config
format: .json
language: fr
fill_locale: fr_FR
domain: energy
appearance: nested JSON, generated state, escaped private key, array
scenario: terraform.tfstate de l'infrastructure de prévision de production d'un producteur éolien, laissé dans un dépôt après une migration de backend
⟬text⟭
{
  "version": 4,
  "terraform_version": "1.9.2",
  "serial": 148,
  "lineage": "⟬uuid#1⟭",
  "outputs": {
    "base_mot_de_passe": {
      "value": "⟬password#1⟭",
      "type": "string",
      "sensitive": true
    },
    "bastion_ip": {
      "value": "⟬ip_address#1⟭",
      "type": "string"
    }
  },
  "resources": [
    {
      "mode": "managed",
      "type": "tls_private_key",
      "name": "bastion",
      "provider": "provider[\"registry.terraform.io/hashicorp/tls\"]",
      "instances": [
        {
          "schema_version": 1,
          "attributes": {
            "algorithm": "ED25519",
            "id": "⟬hash#1⟭",
            "private_key_openssh": "⟬private_key#1⟭",
            "public_key_openssh": "⟬ssh_public_key#1⟭",
            "public_key_fingerprint_sha256": "⟬hash#2⟭"
          }
        }
      ]
    },
    {
      "mode": "managed",
      "type": "random_password",
      "name": "base",
      "provider": "provider[\"registry.terraform.io/hashicorp/random\"]",
      "instances": [
        {
          "schema_version": 3,
          "attributes": {
            "bcrypt_hash": "⟬hash#3⟭",
            "id": "none",
            "length": 24,
            "result": "⟬password#1⟭",
            "special": true
          }
        }
      ]
    },
    {
      "mode": "managed",
      "type": "ovh_cloud_project_database_postgresql_user",
      "name": "prevision",
      "provider": "provider[\"registry.terraform.io/ovh/ovh\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "id": "prevision",
            "name": "prevision",
            "password": "⟬password#2⟭",
            "roles": []
          }
        }
      ]
    },
    {
      "mode": "managed",
      "type": "kubernetes_secret",
      "name": "prevision",
      "provider": "provider[\"registry.terraform.io/hashicorp/kubernetes\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "id": "prevision/prevision-secrets",
            "data": {
              "DATABASE_URL": "postgresql://prevision:⟬url_password#1⟭@⟬hostname#1⟭:5432/prevision",
              "METEO_API_KEY": "⟬opaque_token#1⟭"
            },
            "metadata": [
              {
                "name": "prevision-secrets",
                "namespace": "prevision",
                "annotations": {
                  "responsable": "⟬email#2⟭"
                }
              }
            ]
          }
        }
      ]
    }
  ],
  "check_results": null
}
⟬end⟭

⟬template⟭
family: config
format: .toml
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: comment, TOML value, table
scenario: netlify.toml de la vitrine d'une brasserie artisanale, où le développeur a mis les clés dans le fichier pour éviter l'interface d'administration
⟬text⟭
# vitrine brasserie, build automatique à chaque push
[build]
command = "npm run build"
publish = "dist"

[build.environment]
NODE_VERSION = "20"

[context.production.environment]
STRIPE_SECRET_KEY = "⟬stripe_secret_key#1⟭"
STRIPE_PUBLISHABLE_KEY = "⟬stripe_publishable_key#1⟭"
GOOGLE_PLACES_KEY = "⟬google_api_key#1⟭"
BRASSERIE_SIRET = "⟬fr_siret#2⟭"
BRASSERIE_ADRESSE = "⟬fr_postal_address#2⟭"
BIERE_PHARE = "La ⟬trap:word_name|Blanche⟭ de ⟬city#2⟭"
⟬end⟭

⟬template⟭
family: config
format: .toml
language: fr
fill_locale: fr_FR
domain: public administration
appearance: comment, TOML value, array, url
scenario: vector.toml qui transporte les journaux des services web d'une ville vers le prestataire de supervision, écrit par l'administrateur réseau
⟬text⟭
# Transport des journaux web vers le prestataire
# Prestataire : ⟬company#1⟭, astreinte ⟬phone#1⟭
data_dir = "/var/lib/vector"

[sources.nginx]
type = "file"
include = ["/var/log/nginx/*.log"]

[transforms.anonymiser]
type = "remap"
inputs = ["nginx"]
source = '''
.client_ip = "0.0.0.0"
del(.user_agent)
'''

[sinks.prestataire]
type = "http"
inputs = ["anonymiser"]
uri = "https://collecte:⟬url_password#1⟭@⟬hostname#1⟭/entree"
encoding.codec = "json"

[sinks.prestataire.auth]
strategy = "bearer"
token = "⟬opaque_token#1⟭"

[sinks.alertes]
type = "http"
inputs = ["nginx"]
uri = "https://slack.com/api/chat.postMessage"
encoding.codec = "json"

[sinks.alertes.request.headers]
Authorization = "Bearer ⟬slack_token#1⟭"
⟬end⟭

⟬template⟭
family: config
format: .ini
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: comment, ini key, section header, url
scenario: app.ini de la forge logicielle interne d'un groupe hospitalier, personnalisé par l'équipe DevOps à partir du fichier d'installation
⟬text⟭
; Forge logicielle du groupe hospitalier
; Administrateurs : ⟬person_name#1⟭, ⟬person_name#2⟭
APP_NAME = Forge du groupe hospitalier
RUN_USER = git
RUN_MODE = prod
WORK_PATH = /var/lib/forgejo

[server]
DOMAIN = ⟬hostname#1⟭
ROOT_URL = https://⟬hostname#1⟭/
SSH_DOMAIN = ⟬hostname#1⟭
SSH_PORT = 2222
HTTP_PORT = 3000
LFS_START_SERVER = true
LFS_JWT_SECRET = ⟬opaque_token#1⟭

[database]
DB_TYPE = postgres
HOST = ⟬hostname#2⟭:5432
NAME = forge
USER = forge
PASSWD = ⟬password#1⟭
SSL_MODE = require

[security]
INSTALL_LOCK = true
SECRET_KEY = ⟬opaque_token#2⟭
INTERNAL_TOKEN = ⟬jwt#1⟭
⟬trap:indicator_non_pii|PASSWORD_HASH_ALGO = argon2⟭
⟬trap:indicator_non_pii|MIN_PASSWORD_LENGTH = 12⟭
⟬trap:indicator_non_pii|LOGIN_REMEMBER_DAYS = 7⟭

[service]
DISABLE_REGISTRATION = true
REQUIRE_SIGNIN_VIEW = true
ENABLE_NOTIFY_MAIL = true
⟬trap:indicator_non_pii|DEFAULT_KEEP_EMAIL_PRIVATE = true⟭
⟬trap:indicator_non_pii|NO_REPLY_ADDRESS = noreply.localhost⟭

[mailer]
ENABLED = true
SMTP_ADDR = ⟬hostname#3⟭
SMTP_PORT = 587
FROM = ⟬email:generic#3⟭
USER = ⟬email:generic#3⟭
PASSWD = ⟬password#2⟭

[oauth2]
JWT_SECRET = ⟬opaque_token#3⟭

[storage]
STORAGE_TYPE = minio
MINIO_ENDPOINT = ⟬hostname#4⟭:9000
MINIO_ACCESS_KEY_ID = ⟬opaque_token#4⟭
MINIO_SECRET_ACCESS_KEY = ⟬opaque_token#5⟭
MINIO_BUCKET = forge
MINIO_USE_SSL = true

[webhook]
ALLOWED_HOST_LIST = private,⟬hostname#5⟭
DELIVER_TIMEOUT = 10

[log]
MODE = console
LEVEL = Info
ROOT_PATH = /var/log/forgejo

[cron.archive_cleanup]
ENABLED = true
SCHEDULE = @midnight
⟬end⟭

⟬template⟭
family: config
format: .ini
language: fr
fill_locale: fr_FR
domain: education
appearance: comment, ini key, dependency list
scenario: setup.cfg de la bibliothèque de génération de sujets de mathématiques d'une équipe d'enseignants-développeurs, publiée sur leur index
⟬text⟭
[metadata]
name = sujets-maths
version = ⟬version#1⟭
description = Génération de sujets de mathématiques
author = ⟬trap:indicator_non_pii|Collectif des enseignants⟭
license = GPL-3.0
url = ⟬url#1⟭

[options]
packages = find:
python_requires = >=3.10
install_requires =
    ⟬trap:library|jinja2⟭>=3.1
    ⟬trap:library|sympy⟭>=1.12
    ⟬trap:library|matplotlib⟭>=3.8

[options.extras_require]
docs =
    ⟬trap:library|sphinx⟭>=7

[flake8]
max-line-length = 100
exclude = build,dist

[tool:pytest]
; exercices sur le théorème de ⟬trap:eponym|Pythagore⟭, ⟬trap:eponym|Thalès⟭ et la suite de ⟬trap:eponym|Fibonacci⟭
markers =
    geometrie: exercices de géométrie
    suites: exercices sur les suites
⟬end⟭

⟬template⟭
family: config
format: .properties
language: fr
fill_locale: fr_FR
domain: energy
appearance: comment, properties key, url
scenario: nifi.properties de l'ingestion des courbes de charge d'un fournisseur alternatif, généré par le toolkit puis modifié à la main par une data engineer
⟬text⟭
# Ingestion des courbes de charge
# Modifié par ⟬person_name#1f⟭ le ⟬date#1⟭, retirer le mode debug après la recette
nifi.flow.configuration.file=./conf/flow.json.gz
nifi.flow.configuration.archive.enabled=true
nifi.authorizer.configuration.file=./conf/authorizers.xml
nifi.login.identity.provider.configuration.file=./conf/login-identity-providers.xml
nifi.templates.directory=./conf/templates
nifi.ui.banner.text=INGESTION COURBES - RECETTE

nifi.web.https.host=⟬hostname#1⟭
nifi.web.https.port=8443
nifi.remote.input.secure=true
nifi.remote.input.host=⟬hostname#1⟭

nifi.sensitive.props.key=⟬opaque_token#1⟭
nifi.sensitive.props.algorithm=NIFI_PBKDF2_AES_GCM_256

nifi.security.keystore=./conf/keystore.p12
nifi.security.keystoreType=PKCS12
nifi.security.keystorePasswd=⟬password#1⟭
nifi.security.keyPasswd=⟬password#1⟭
nifi.security.truststore=./conf/truststore.p12
nifi.security.truststoreType=PKCS12
nifi.security.truststorePasswd=⟬password#2⟭
⟬trap:indicator_non_pii|nifi.security.user.login.identity.provider=ldap-provider⟭
⟬trap:indicator_non_pii|nifi.security.identity.mapping.pattern.dn=^CN=(.*?), OU=(.*?)$⟭

nifi.provenance.repository.max.storage.time=30 days
nifi.content.repository.archive.max.retention.period=7 days

# contrôleurs : variables de paramètres utilisées par les flux
parametres.base.courbes=postgresql://courbes:⟬url_password#1⟭@⟬hostname#2⟭:5432/courbes
parametres.grd.sftp.utilisateur=⟬username#1⟭
parametres.grd.sftp.cle.publique=⟬ssh_public_key#1⟭
parametres.alerte.jeton=⟬slack_token#1⟭
⟬end⟭

⟬template⟭
family: config
format: .properties
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: properties key, comment
scenario: fichier de paramètres de paiement d'une application Java de vente de billets de concert, relu par personne depuis le lancement
⟬text⟭
# billetterie
paiement.stripe.cle=⟬stripe_secret_key#1⟭
paiement.stripe.publique=⟬stripe_publishable_key#1⟭
reversement.organisateur.iban=⟬iban#2⟭
reversement.delai.jours=5
⟬end⟭
