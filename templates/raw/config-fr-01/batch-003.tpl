⟬template⟭
family: config
format: .env
language: fr
fill_locale: fr_FR
domain: public administration
appearance: comment, assignment, quoted value
scenario: .env Laravel de l'application de réservation des salles municipales, écrit par l'agent informatique de la mairie qui gère aussi les comptes des associations
⟬text⟭
# Réservation des salles municipales
# ⟬person_name#1⟭ gère les comptes des associations, en cas d'urgence appeler le ⟬phone#1⟭
APP_NAME="Salles ⟬city#2⟭"
APP_ENV=production
APP_KEY=base64:⟬opaque_token#1⟭
APP_DEBUG=false
APP_URL=https://⟬hostname#2⟭
LOG_CHANNEL=daily

DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=salles
DB_USERNAME=⟬username#1⟭
DB_PASSWORD=⟬password#1⟭

⟬trap:indicator_non_pii|SESSION_LIFETIME=120⟭
BCRYPT_ROUNDS=12
MAIL_MAILER=smtp
MAIL_HOST=⟬hostname#3⟭
MAIL_PORT=587
MAIL_USERNAME=⟬email:generic#2⟭
MAIL_PASSWORD=⟬password#2⟭
⟬trap:indicator_non_pii|MAIL_FROM_NAME="${APP_NAME}"⟭

GOOGLE_CALENDAR_KEY=⟬google_api_key#1⟭
GOOGLE_CALENDAR_ID=⟬trap:indicator_non_pii|salles-municipales⟭
⟬end⟭

⟬template⟭
family: config
format: .env
language: fr
fill_locale: fr_FR
domain: energy
appearance: comment, assignment, url, section header
scenario: .env.sample du tableau de bord d'une opération d'autoconsommation collective, publié avec le code par une association de citoyens
⟬text⟭
# .env.sample - tableau de bord d'autoconsommation collective
# Projet associatif, code ouvert : aucune vraie valeur ici.

## Serveur
PORT=4000
BASE_URL=http://localhost:4000
PUBLIC_MAP_CENTER="⟬city#1⟭"
PUBLIC_MAP_ZOOM=13

## Compteurs
METER_API_URL=⟬url#1⟭
METER_API_USER=⟬trap:indicator_non_pii|lecture⟭
METER_API_PASSWORD=⟬trap:placeholder|<votre mot de passe>⟭
METER_POLL_SECONDS=1800
⟬trap:indicator_non_pii|METER_TOKEN_REFRESH=true⟭

## Répartition de la production
# Clé de répartition statique par défaut, méthode de ⟬trap:eponym|Shapley⟭ en option
REPARTITION=statique
PARTICIPANTS_MAX=25
⟬trap:indicator_non_pii|OWNER=association⟭

## Base
POSTGRES_USER=⟬trap:indicator_non_pii|acc⟭
POSTGRES_PASSWORD=⟬trap:placeholder|changeme⟭
POSTGRES_DB=acc
DATABASE_URL=postgres://acc:⟬trap:placeholder|${POSTGRES_PASSWORD}⟭@localhost:5432/acc

## Notifications
TELEGRAM_BOT_TOKEN=⟬trap:placeholder|REPLACE_ME⟭
NOTIF_CONTACT=⟬trap:indicator_non_pii|contact⟭
⟬trap:indicator_non_pii|NOTIF_PHONE_ENABLED=false⟭
⟬end⟭

⟬template⟭
family: config
format: .env
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: export, quoted value, escaped private key
scenario: .env.local d'un développeur pour générer les comptes rendus PDF d'un laboratoire d'analyses avec la clé Firebase sur une seule ligne
⟬text⟭
export FIREBASE_PROJECT_ID=resultats-labo
export FIREBASE_CLIENT_EMAIL=⟬email:generic#1⟭
export FIREBASE_PRIVATE_KEY="⟬private_key#1⟭"
export PDF_SIGNATAIRE="Dr ⟬person_name#2⟭"
export LABO_TEL="⟬phone#3⟭"
export PDF_FILIGRANE=RECETTE
⟬end⟭

⟬template⟭
family: config
format: docker-compose.yml
language: fr
fill_locale: fr_FR
domain: banking
appearance: comment, YAML block, quoted command, YAML value, url, public key
scenario: compose de la plateforme d'échange de fichiers avec les partenaires bancaires d'une société de crédit, maintenu par l'équipe flux depuis une migration de serveurs
⟬text⟭
# Échanges de fichiers avec les partenaires bancaires
# Équipe flux : ⟬email:generic#1⟭
# Contact chez le partenaire de compensation : ⟬person_name#2⟭, ⟬phone#2⟭
# Bascule du serveur faite le ⟬date#1⟭, ancienne IP ⟬ip_address#1⟭ à retirer des listes

x-commun: &commun
  restart: unless-stopped
  networks:
    - flux

services:
  sftp:
    <<: *commun
    image: atmoz/sftp:alpine
    command: "echanges:⟬password#1⟭:1001:1001:depot"
    ports:
      - "2222:22"
    volumes:
      - depot:/home/echanges/depot
      - ./cles/hote_ed25519:/etc/ssh/ssh_host_ed25519_key:ro

  aiguilleur:
    <<: *commun
    image: ⟬hostname#1⟭/flux/aiguilleur:⟬version#1⟭
    environment:
      BASE_URL: postgres://flux:⟬url_password#1⟭@base:5432/flux
      MQ_URL: amqp://flux:⟬url_password#2⟭@file:5672/
      COMPTE_REGLEMENT_IBAN: "⟬iban#3⟭"
      COMPTE_REGLEMENT_BIC: ⟬bic#3⟭
      ⟬trap:indicator_non_pii|IBAN_CHECK: "true"⟭
      PARTENAIRE_SFTP_HOTE: ⟬hostname#2⟭
      PARTENAIRE_SFTP_UTILISATEUR: ⟬username#1⟭
      PARTENAIRE_CLE_PUBLIQUE: ⟬ssh_public_key#1⟭
      PARTENAIRE_CLE_PRIVEE: |
        ⟬private_key#1⟭
    volumes:
      - depot:/depot
    depends_on:
      - base
      - file

  base:
    <<: *commun
    image: postgres:15
    environment:
      POSTGRES_DB: flux
      POSTGRES_USER: flux
      POSTGRES_PASSWORD: ⟬url_password#1⟭
    volumes:
      - base:/var/lib/postgresql/data

  file:
    <<: *commun
    image: rabbitmq:3.13-management
    environment:
      RABBITMQ_DEFAULT_USER: flux
      RABBITMQ_DEFAULT_PASS: ⟬url_password#2⟭

  chiffrement:
    <<: *commun
    image: ⟬hostname#1⟭/flux/gpg-relais:⟬version#2⟭
    environment:
      GPG_PASSPHRASE: "⟬password#2⟭"
      GPG_DESTINATAIRE: ⟬email:generic#1⟭
    volumes:
      - depot:/depot

  purge:
    <<: *commun
    image: alpine:3.20
    command: ["sh", "-c", "find /depot -mtime +30 -delete; sleep 86400"]
    volumes:
      - depot:/depot

networks:
  flux:

volumes:
  depot:
  base:
⟬end⟭

⟬template⟭
family: config
format: docker-compose.yml
language: fr
fill_locale: fr_FR
domain: education
appearance: comment, YAML value, environment list
scenario: compose distribué aux étudiants d'un BTS informatique pour un TP sur les bases de données et la supervision, écrit par leur enseignant
⟬text⟭
# TP3 - base de données répliquée et supervision
# À lancer sur votre poste, rien ne sort de la machine.
# Question 4 : expliquez pourquoi on ne met jamais ces mots de passe dans un dépôt.
services:
  ⟬trap:code_identifier|⦃given⦄⟭-primaire:
    image: ⟬trap:library|mariadb⟭:11.4
    environment:
      - MARIADB_ROOT_PASSWORD=⟬trap:placeholder|changeme⟭
      - MARIADB_REPLICATION_USER=⟬trap:indicator_non_pii|replicant⟭
      - MARIADB_REPLICATION_PASSWORD=⟬trap:placeholder|changeme⟭
    ports:
      - "3307:3306"

  ⟬trap:code_identifier|⦃given⦄⟭-secondaire:
    image: ⟬trap:library|mariadb⟭:11.4
    environment:
      - MARIADB_MASTER_HOST=⟬trap:code_identifier|⦃given⦄⟭-primaire
      - MARIADB_ROOT_PASSWORD=⟬trap:placeholder|changeme⟭
    depends_on:
      - ⟬trap:code_identifier|⦃given⦄⟭-primaire

  adminer:
    image: adminer:4
    ports:
      - "8081:8080"
    environment:
      ⟬trap:indicator_non_pii|ADMINER_DEFAULT_USER: etudiant⟭
      ADMINER_DESIGN: ⟬trap:word_name|Pierre⟭-noire

  supervision:
    image: ⟬trap:library|prometheus⟭/prometheus:v2.53.0
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml:ro

  tableaux:
    image: grafana/⟬trap:library|grafana⟭:11.1.0
    environment:
      GF_SECURITY_ADMIN_USER: ⟬trap:indicator_non_pii|admin⟭
      GF_SECURITY_ADMIN_PASSWORD: "⟬trap:placeholder|***⟭"
    # identifiants à reporter dans votre compte rendu : ⟬trap:placeholder|<identifiant>⟭ / ⟬trap:placeholder|<mot de passe>⟭
⟬end⟭

⟬template⟭
family: config
format: docker-compose.yml
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: YAML value, comment
scenario: compose d'une petite boutique WordPress de céramique, monté par la créatrice elle-même à partir d'un tutoriel
⟬text⟭
# ma boutique - sauvegardes le dimanche !!
services:
  wordpress:
    image: wordpress:6.6-php8.3-apache
    environment:
      WORDPRESS_DB_HOST: base
      WORDPRESS_DB_USER: boutique
      WORDPRESS_DB_PASSWORD: ⟬password#1⟭
      WOOCOMMERCE_STRIPE_SECRET: ⟬stripe_secret_key#1⟭
      GOOGLE_MAPS_API_KEY: ⟬google_api_key#1⟭
  base:
    image: mysql:8.4
    environment:
      MYSQL_PASSWORD: ⟬password#1⟭
⟬end⟭

⟬template⟭
family: config
format: Kubernetes .yaml
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: annotation, stringData, nested YAML block, url, comment
scenario: Secret contenant le fichier de configuration complet d'un service de téléradiologie, exporté du cluster par un admin pour diagnostiquer une panne
⟬text⟭
# export kubectl get secret -o yaml, nettoyé à la main pour le ticket ⟬ticket_id#1⟭
apiVersion: v1
kind: Secret
metadata:
  name: teleradiologie-config
  namespace: teleradiologie
  annotations:
    meta.helm.sh/release-name: ⟬trap:code_identifier|⦃given⦄⟭
    referent-dsi: "⟬person_name#1⟭ / ⟬phone#1⟭"
type: Opaque
stringData:
  application-secrets.yml: |
    spring:
      datasource:
        url: jdbc:postgresql://⟬hostname#1⟭:5432/teleradio
        username: teleradio
        password: ⟬password#1⟭
    pacs:
      aet: TELERAD
      dicomweb: https://orthanc:⟬url_password#1⟭@⟬hostname#2⟭:8042/dicom-web
    ⟬trap:indicator_non_pii|anonymisation: "patient_name"⟭
    signature:
      emetteur: ⟬company#3⟭
      cle: |
        ⟬private_key#1⟭
---
apiVersion: v1
kind: Secret
metadata:
  name: teleradiologie-sms
  namespace: teleradiologie
type: Opaque
stringData:
  numero-garde: "⟬phone#4⟭"
  cle-api: ⟬opaque_token#1⟭
⟬end⟭

⟬template⟭
family: config
format: Kubernetes .yaml
language: fr
fill_locale: fr_FR
domain: public administration
appearance: comment, YAML value, nested mapping, url, list
scenario: fichier values-prod.yaml du chart Helm du guichet numérique d'une région, repris par trois prestataires successifs dont chacun a laissé ses notes
⟬text⟭
# values-prod.yaml - guichet numérique de la région
# Prestataire 1 (build initial) : ⟬person_name#1⟭
# Prestataire 2 (TMA) : ⟬company#2⟭, contact ⟬email#2⟭
# Prestataire 3 (reprise au ⟬date#1⟭) : ⟬person_name#3⟭ ⟬phone#3⟭

global:
  domaine: ⟬hostname#1⟭
  environnement: production
  image:
    registre: ⟬hostname#2⟭
    tag: ⟬version#1⟭
    pullSecret: registre-region
  organisme:
    nom: Région ⟬trap:word_name|Normandie⟭
    siret: "⟬fr_siret#4⟭"
    dpo: ⟬email:generic#4⟭
    standard: "⟬phone#4⟭"
    adresse: ⟬fr_postal_address#4⟭

portail:
  replicas: 4
  ingress:
    enabled: true
    classe: nginx
    tailleMaxUpload: 25m
  env:
    SESSION_SECRET: ⟬opaque_token#1⟭
    ⟬trap:indicator_non_pii|SESSION_TTL: 1800⟭
    SSO_ISSUER: ⟬url#1⟭
    SSO_CLIENT_ID: guichet-portail
    SSO_CLIENT_SECRET: ⟬opaque_token#2⟭

instruction:
  replicas: 2
  env:
    SIGNATURE_PIN: "⟬password#1⟭"
    GED_URL: ⟬url#2⟭
    GED_LOGIN: ⟬username#1⟭
    GED_PASSWORD: ⟬password#2⟭

postgresql:
  enabled: false
  externe:
    hote: ⟬hostname#3⟭
    base: guichet
    utilisateur: guichet
    motDePasse: ⟬password#3⟭

notifications:
  courriel:
    hote: ⟬hostname#4⟭
    expediteur: ⟬email:generic#5⟭
    motDePasse: ⟬password#4⟭
  chat:
    # jeton du bot de la TMA, à refaire
    jeton: ⟬slack_token#1⟭
    canal: guichet-incidents

sauvegarde:
  planification: "0 3 * * *"
  destination: ⟬url#3⟭
  retention: 30

journalisation:
  niveau: info
  ⟬trap:indicator_non_pii|masquerChamps: [nom, prenom, telephone, iban]⟭
⟬end⟭

⟬template⟭
family: config
format: Kubernetes .yaml
language: fr
fill_locale: fr_FR
domain: banking
appearance: comment, label, secret reference, RBAC rule
scenario: politique réseau et droits RBAC du namespace de scoring crédit, écrits par l'équipe sécurité après un test d'intrusion
⟬text⟭
# Suite au test d'intrusion du ⟬date#1⟭ : flux sortants limités, droits réduits (⟬ticket_id#1⟭)
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: scoring-sortie
  namespace: scoring-credit
  labels:
    ⟬trap:indicator_non_pii|owner: equipe-securite⟭
spec:
  podSelector:
    matchLabels:
      app: scoring
  policyTypes: [Egress]
  egress:
    - to:
        - ipBlock:
            cidr: 10.40.12.7/32
      ports:
        - protocol: TCP
          port: 5432
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: scoring
  namespace: scoring-credit
automountServiceAccountToken: false
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: lecture-secrets-scoring
  namespace: scoring-credit
rules:
  - apiGroups: [""]
    resources: ["secrets"]
    resourceNames: ["scoring-base"]
    verbs: ["get"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: scoring-lecture-secrets
  namespace: scoring-credit
subjects:
  - kind: ServiceAccount
    name: scoring
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: lecture-secrets-scoring
---
apiVersion: external-secrets.io/v1beta1
kind: ExternalSecret
metadata:
  name: scoring-base
  namespace: scoring-credit
spec:
  refreshInterval: 1h
  secretStoreRef:
    name: coffre-banque
    kind: ClusterSecretStore
  target:
    name: scoring-base
  data:
    - secretKey: mot-de-passe
      remoteRef:
        key: scoring/base
        property: ⟬trap:indicator_non_pii|password⟭
⟬end⟭

⟬template⟭
family: config
format: GitHub Actions .yml
language: fr
fill_locale: fr_FR
domain: energy
appearance: comment, environment variable, secret reference, command line
scenario: pipeline Terraform de l'infrastructure de supervision d'hydroliennes, où un ingénieur a remplacé les secrets par des valeurs en dur pour déboguer un plan
⟬text⟭
name: infra-supervision

on:
  pull_request:
    paths: ["infra/**"]

env:
  TF_IN_AUTOMATION: "true"
  TF_VAR_region: eu-west-3
  # debug plan, valeurs en dur, à retirer (⟬person_name#1⟭)
  TF_VAR_grafana_admin_password: ⟬password#1⟭
  TF_VAR_maps_key: ⟬google_api_key#1⟭
  TF_VAR_exploitant: ⟬trap:company_name|⦃Family⦄ Hydro⟭

jobs:
  plan:
    runs-on: ubuntu-latest
    defaults:
      run:
        working-directory: infra
    steps:
      - uses: ⟬trap:email_lookalike|actions/checkout@v4⟭
      - uses: ⟬trap:email_lookalike|hashicorp/setup-terraform@v3⟭
        with:
          cli_config_credentials_token: ⟬trap:placeholder|${{ secrets.TF_API_TOKEN }}⟭
      - run: terraform init -backend-config="access_key=⟬opaque_token#1⟭"
      - run: terraform plan -no-color
⟬end⟭

⟬template⟭
family: config
format: GitHub Actions .yml
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: command line, url
scenario: tâche d'export d'un jeu de données anonymisé pour la recherche clinique, écrite par une biostatisticienne avec l'URL complète de la base
⟬text⟭
name: export-recherche
on: workflow_dispatch
jobs:
  export:
    runs-on: self-hosted
    steps:
      - run: pg_dump "postgresql://lecture:⟬url_password#1⟭@⟬hostname#1⟭:5432/cohorte" -t vue_anonymisee -f export.sql
      - run: gzip export.sql
⟬end⟭

⟬template⟭
family: config
format: GitHub Actions .yml
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: secret reference, YAML value, comment, YAML block
scenario: workflow de publication de la vitrine d'une chaîne de magasins de bricolage, écrit par l'équipe front avec tous les secrets au bon endroit
⟬text⟭
name: Publication vitrine

on:
  push:
    tags: ["v*"]

permissions:
  contents: write
  id-token: write

jobs:
  construire:
    runs-on: ubuntu-latest
    outputs:
      version: ${{ steps.meta.outputs.version }}
    steps:
      - uses: ⟬trap:email_lookalike|actions/checkout@v4⟭
      - uses: ⟬trap:email_lookalike|actions/setup-node@v4⟭
        with:
          node-version: 20
          cache: npm
      - run: npm ci
      - id: meta
        run: echo "version=${GITHUB_REF_NAME#v}" >> "$GITHUB_OUTPUT"
      - name: Construire le site
        env:
          NEXT_PUBLIC_STRIPE_KEY: ⟬stripe_publishable_key#1⟭
          STRIPE_SECRET_KEY: ⟬trap:placeholder|${{ secrets.STRIPE_SECRET_KEY }}⟭
          ALGOLIA_ADMIN_KEY: ⟬trap:placeholder|${{ secrets.ALGOLIA_ADMIN_KEY }}⟭
        run: npm run build

  publier:
    needs: construire
    runs-on: ubuntu-latest
    environment: production
    steps:
      - uses: ⟬trap:email_lookalike|aws-actions/configure-aws-credentials@v4⟭
        with:
          role-to-assume: ⟬trap:placeholder|${{ vars.ROLE_DEPLOIEMENT }}⟭
          aws-region: eu-west-3
      - name: Note de version
        uses: ⟬trap:email_lookalike|softprops/action-gh-release@v2⟭
        with:
          body: |
            Version ${{ needs.construire.outputs.version }}
            ⟬trap:indicator_non_pii|Author: dependabot[bot]⟭
            Voir le tableau de bord ⟬url#1⟭
⟬end⟭

⟬template⟭
family: config
format: .json
language: fr
fill_locale: fr_FR
domain: energy
appearance: nested JSON, string value, array
scenario: config/production.json de la facturation d'un réseau de chaleur urbain, écrit par l'éditeur du logiciel et complété par la régie municipale
⟬text⟭
{
  "regie": {
    "denomination": "⟬company#1⟭",
    "siret": "⟬fr_siret#1⟭",
    "ibanEncaissement": "⟬iban#1⟭",
    "reseau": "⟬city#1⟭ Centre",
    "exploitant": "⟬trap:company_name|⦃Family⦄ Chauffage⟭"
  },
  "paiementEnLigne": {
    "actif": true,
    "stripe": {
      "secret": "⟬stripe_secret_key#2⟭",
      "publique": "⟬stripe_publishable_key#2⟭"
    }
  },
  "relevesTelereport": {
    "api": "⟬url#1⟭",
    "jeton": "⟬opaque_token#1⟭",
    "frequenceHeures": 6
  },
  "alertes": {
    "slack": {"token": "⟬slack_token#1⟭", "canal": "reseau-chaleur"},
    "seuilsDegC": {"depart": 95, "retour": 60},
    "destinataires": ["⟬email#3⟭", "⟬email:generic#1⟭"]
  },
  "tarifs": [
    {"code": "R1", "libelle": "Part énergie", "prixKwh": 0.081},
    {"code": "R2", "libelle": "Abonnement", "prixKw": 42.5}
  ]
}
⟬end⟭

⟬template⟭
family: config
format: .json
language: fr
fill_locale: fr_FR
domain: education
appearance: nested JSON, array, environment map, url
scenario: launch.json de débogage d'une application de vœux d'orientation, où une alternante a copié les variables de la préproduction pour reproduire un bug
⟬text⟭
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "API vœux (préprod)",
      "type": "debugpy",
      "request": "launch",
      "module": "uvicorn",
      "args": ["voeux.main:app", "--reload"],
      "env": {
        "DATABASE_URL": "postgresql://voeux:⟬url_password#1⟭@⟬hostname#1⟭/voeux_pp",
        "OAUTH_CLIENT_SECRET": "⟬opaque_token#1⟭",
        "ELEVE_TEST_ID": "⟬customer_id#2⟭",
        "ELEVE_TEST_NOM": "⟬person_name#2⟭",
        "ELEVE_TEST_NE_LE": "⟬birth_date#2⟭"
      }
    }
  ]
}
⟬end⟭

⟬template⟭
family: config
format: .toml
language: fr
fill_locale: fr_FR
domain: public administration
appearance: comment, TOML value, table
scenario: config.toml du site statique d'une commune rurale, entretenu par le secrétaire de mairie et généré avec Hugo
⟬text⟭
# site de la commune - construit avec ⟬trap:library|Hugo⟭
baseURL = "https://⟬hostname#1⟭/"
languageCode = "fr-fr"
title = "Commune de ⟬city#2⟭"
theme = "⟬trap:word_name|Ambre⟭"

[params]
description = "Site officiel de la commune de ⟬city#2⟭"
carteCle = "⟬google_api_key#1⟭"
analyseJeton = "⟬opaque_token#1⟭"

[params.mairie]
adresse = "⟬fr_postal_address#2⟭"
telephone = "⟬phone#2⟭"
courriel = "⟬email:generic#2⟭"
siret = "⟬fr_siret#2⟭"
horaires = "lundi et jeudi 9h-12h"
maire = "⟬person_name#3⟭"
⟬trap:indicator_non_pii|contact = "secretariat"⟭

[[menu.principal]]
name = "Actualités"
url = "/actualites/"
weight = 1

[[menu.principal]]
name = "Rue ⟬trap:word_name|Victor Hugo⟭ : travaux"
url = "/travaux/"
weight = 2
⟬end⟭

⟬template⟭
family: config
format: .toml
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: comment, TOML value, inline table, url
scenario: wrangler.toml d'un worker qui reçoit les webhooks de paiement d'une boutique de vélos, avec les secrets mis dans vars par erreur
⟬text⟭
# webhook-paiements : à passer en "wrangler secret put", là c'est visible par tout le monde
name = "webhook-paiements"
main = "src/index.ts"
compatibility_date = "2026-01-15"
account_id = "⟬hash#1⟭"

[vars]
STRIPE_SECRET_KEY = "⟬stripe_secret_key#1⟭"
STRIPE_WEBHOOK_SECRET = "⟬opaque_token#1⟭"
SLACK_BOT_TOKEN = "⟬slack_token#1⟭"
SLACK_CANAL_VENTES = "ventes-velos"
BOUTIQUE_URL = "https://⟬hostname#1⟭"
BASE_COMMANDES = "postgres://webhook:⟬url_password#1⟭@⟬hostname#2⟭:5432/commandes"

[[kv_namespaces]]
binding = "IDEMPOTENCE"
id = "⟬hash#2⟭"

[triggers]
crons = ["0 4 * * *"]
⟬end⟭

⟬template⟭
family: config
format: .ini
language: fr
fill_locale: fr_FR
domain: education
appearance: comment, ini key, environment variable, url
scenario: uwsgi.ini de l'application de scolarité d'un institut de formation, repris d'un vieux serveur par le technicien informatique
⟬text⟭
; uwsgi - scolarité de l'institut
; repris de l'ancien serveur par ⟬person_name#1⟭
[uwsgi]
chdir = /srv/scolarite
module = scolarite.wsgi:application
master = true
processes = 6
socket = /run/scolarite.sock
env = DJANGO_SETTINGS_MODULE=scolarite.settings.prod
env = SECRET_KEY=⟬opaque_token#1⟭
env = DATABASE_URL=postgres://scolarite:⟬url_password#1⟭@⟬hostname#1⟭:5432/scolarite
env = SMTP_PASSWORD=⟬password#1⟭
env = ⟬trap:indicator_non_pii|DJANGO_PASSWORD_MIN_LENGTH=10⟭
logto = ⟬file_path#1⟭
⟬end⟭

⟬template⟭
family: config
format: .ini
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: ini key, section header
scenario: fichier de configuration Odoo d'un grossiste en fournitures de bureau, avec une section ajoutée par un module de comptabilité maison
⟬text⟭
[options]
admin_passwd = ⟬password#1⟭
db_host = ⟬hostname#1⟭
db_user = odoo
db_password = ⟬password#2⟭
addons_path = /opt/odoo/addons,/opt/odoo/custom

[compta_maison]
siret = ⟬fr_siret#3⟭
iban_remise = ⟬iban#3⟭
stripe_key = ⟬stripe_secret_key#3⟭
⟬end⟭

⟬template⟭
family: config
format: .properties
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: comment, properties key, url, name in value
scenario: fichier de propriétés du connecteur entre le PACS et le dossier patient d'un centre hospitalier, enrichi par la cellule d'identitovigilance et la DSI
⟬text⟭
# ====================================================
# Connecteur PACS <-> dossier patient
# DSI : ⟬person_name#1⟭ ; identitovigilance : ⟬person_name#2f⟭
# ====================================================

connecteur.nom=pacs-dpi
connecteur.etablissement=⟬company#3⟭
connecteur.finess=⟬customer_id#3⟭
connecteur.environnement=production
connecteur.fuseau=Europe/Paris

# --- DICOM ---
dicom.aet.local=DPI_GW
dicom.aet.distant=PACS_CHU
dicom.hote=⟬hostname#1⟭
dicom.port=11112
dicom.tls=true
dicom.keystore.fichier=/etc/connecteur/dicom.p12
dicom.keystore.mot-de-passe=⟬password#1⟭

# --- Base ---
db.url=jdbc:sqlserver://⟬hostname#2⟭:1433;databaseName=PACSDPI;encrypt=true
db.utilisateur=⟬username#1⟭
db.mot-de-passe=⟬password#2⟭
db.pool.max=25

# --- Dossier patient ---
dpi.url=⟬url#1⟭
dpi.compte=⟬username#2⟭
dpi.jeton=⟬opaque_token#1⟭
⟬trap:indicator_non_pii|dpi.jeton.duree-vie=3600⟭
dpi.flux.entrant=https://passerelle:⟬url_password#1⟭@⟬hostname#3⟭/hl7
⟬trap:indicator_non_pii|dpi.ipp.format=numerique⟭
⟬trap:indicator_non_pii|dpi.nom-naissance.obligatoire=true⟭

# --- Rapprochement d'identité ---
# phonétique ⟬trap:eponym|Soundex⟭ puis distance de ⟬trap:eponym|Levenshtein⟭
rapprochement.seuil=0.88
rapprochement.revue.manuelle=true
rapprochement.responsable=⟬person_name#2f⟭
rapprochement.mail=⟬email#2⟭
rapprochement.poste=⟬phone#2⟭

# --- Astreintes ---
astreinte.radiologue=Dr ⟬person_name#4⟭
astreinte.radiologue.tel=⟬phone#4⟭
astreinte.manipulateur=⟬person_name#5m⟭
astreinte.dsi.tel=⟬phone#1⟭

# --- Notifications ---
notif.canal=slack
notif.jeton=⟬slack_token#1⟭
notif.salon=pacs-incidents
notif.sms.fournisseur=⟬company#6⟭
notif.sms.cle=⟬opaque_token#2⟭

# --- Facturation des actes ---
facturation.tiers-payant.iban=⟬iban#3⟭

# --- Purge ---
purge.apres.jours=30
purge.heure=02:30
purge.repertoire=/var/lib/connecteur/tampon
⟬end⟭

⟬template⟭
family: config
format: .properties
language: fr
fill_locale: fr_FR
domain: public administration
appearance: comment, properties key
scenario: sonar-project.properties d'une application de gestion des marchés publics, avec le jeton passé par variable depuis la dernière revue
⟬text⟭
# Analyse qualité - application marchés publics
# Le jeton vient de la variable de l'intégration continue, ne pas le recopier ici.
sonar.projectKey=marches-publics
sonar.projectName=Marchés publics
sonar.projectVersion=⟬version#1⟭
sonar.host.url=⟬url#1⟭
sonar.token=⟬trap:placeholder|${SONAR_TOKEN}⟭
sonar.sources=src/main/java
sonar.tests=src/test/java
sonar.java.binaries=target/classes
sonar.java.libraries=target/dependency/*.jar
sonar.sourceEncoding=UTF-8
sonar.exclusions=**/generated/**,**/*Dto.java
sonar.coverage.jacoco.xmlReportPaths=target/site/⟬trap:library|jacoco⟭/jacoco.xml
sonar.cpd.exclusions=**/⟬trap:code_identifier|⦃Family⦄⟭Mapper.java
sonar.issue.ignore.multicriteria=e1
sonar.issue.ignore.multicriteria.e1.ruleKey=java:S2068
sonar.issue.ignore.multicriteria.e1.resourceKey=**/⟬trap:code_identifier|Password⦃Family⦄Validator⟭.java
⟬trap:indicator_non_pii|sonar.links.scm=interne⟭
⟬trap:indicator_non_pii|sonar.links.contact=support⟭
⟬end⟭
