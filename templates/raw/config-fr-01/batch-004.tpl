⟬template⟭
family: config
format: .env
language: fr
fill_locale: fr_FR
domain: banking
appearance: comment, assignment, quoted value, name and email in value
scenario: .env de production d'un courtier en crédit immobilier, avec le CRM et la signature électronique, envoyé par mail à un nouveau prestataire
⟬text⟭
# Courtage crédit immo : CRM + signature électronique
# PROD, ne pas copier en local
APP_ENV=production
CRM_BASE_URL=⟬url#1⟭
CRM_TOKEN=⟬opaque_token#1⟭
COURTIER_RAISON_SOCIALE="⟬company#2⟭"
COURTIER_SIRET="⟬fr_siret#2⟭"
COURTIER_ORIAS=⟬customer_id#2⟭
COMPTE_HONORAIRES_IBAN="⟬iban#2⟭"
STRIPE_SECRET=⟬stripe_secret_key#3⟭
SIGNATURE_WEBHOOK=⟬opaque_token#2⟭
CONTACT_CONFORMITE="⟬person_name#4⟭ <⟬email#4⟭>"
⟬trap:indicator_non_pii|CONTACT_DEFAUT=conformite⟭
⟬trap:indicator_non_pii|DOSSIER_TOKEN_EXPIRATION_JOURS=30⟭
TAUX_USURE_MAJ="⟬date#1⟭"
⟬end⟭

⟬template⟭
family: config
format: .env
language: fr
fill_locale: fr_FR
domain: education
appearance: comment, assignment, vault reference, url
scenario: .env.staging d'une plateforme de cours vidéo d'université, où chaque secret est une référence vers le coffre de l'établissement
⟬text⟭
# Plateforme de cours vidéo - préproduction
# Les références vault: sont résolues au démarrage par l'agent du coffre.
APP_ENV=staging
APP_URL=https://⟬hostname#1⟭
DB_HOST=⟬hostname#2⟭
⟬trap:indicator_non_pii|DB_USER=video_app⟭
DB_PASSWORD=⟬trap:placeholder|vault:secret/video/base#password⟭
S3_ACCESS_KEY=⟬trap:placeholder|vault:secret/video/s3#access⟭
S3_SECRET_KEY=⟬trap:placeholder|vault:secret/video/s3#secret⟭
SOUS_TITRES_MOTEUR=⟬trap:library|whisper⟭
⟬trap:indicator_non_pii|ENSEIGNANT_ROLE=enseignant⟭
⟬trap:indicator_non_pii|ETUDIANT_LOGIN_MAX_ESSAIS=5⟭
⟬trap:indicator_non_pii|SSO_ATTRIBUT_NOM=displayName⟭
⟬trap:indicator_non_pii|SSO_ATTRIBUT_MAIL=mail⟭
SESSION_SECRET=⟬trap:placeholder|vault:secret/video/session#value⟭
⟬end⟭

⟬template⟭
family: config
format: docker-compose.yml
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: comment, single-quoted JSON, YAML block, YAML value, label
scenario: compose du serveur d'images médicales d'un cabinet de radiologie, installé par la société de maintenance du matériel
⟬text⟭
# Serveur d'images du cabinet de radiologie
# Maintenance : ⟬company#1⟭ - hotline ⟬phone#1⟭
# Radiologue référent : Dr ⟬person_name#2m⟭
services:
  orthanc:
    image: orthancteam/orthanc:24.7.2
    restart: always
    ports:
      - "4242:4242"
      - "8042:8042"
    environment:
      ORTHANC__NAME: CABINET
      ORTHANC__DICOM_AET: CABINET_PACS
      ORTHANC__REGISTERED_USERS: '{"lecture": "⟬password#1⟭", "admin": "⟬password#2⟭"}'
      ORTHANC__POSTGRESQL__HOST: base
      ORTHANC__POSTGRESQL__PASSWORD: ⟬password#3⟭
      TLS_CERT_FILE: /etc/orthanc/cabinet.crt
      TLS_KEY: |
        ⟬private_key#1⟭
    labels:
      maintenance.contrat: ⟬order_number#1⟭
      maintenance.contact: "⟬email:generic#1⟭"
    volumes:
      - images:/var/lib/orthanc/db

  base:
    image: postgres:16
    environment:
      POSTGRES_DB: orthanc
      POSTGRES_USER: orthanc
      POSTGRES_PASSWORD: ⟬password#3⟭

volumes:
  images:
⟬end⟭

⟬template⟭
family: config
format: docker-compose.yml
language: fr
fill_locale: fr_FR
domain: public administration
appearance: comment, compose secrets, YAML value, label, environment list, YAML anchor
scenario: compose du parc informatique et de l'assistance d'une communauté d'agglomération, réécrit avec des secrets Docker lors de la migration vers un nouvel hébergeur
⟬text⟭
# Gestion de parc et assistance - communauté d'agglomération
# Réécrit lors de la migration : les secrets sont des fichiers Docker, rien en clair.
# Dépôt de suivi : ⟬url#1⟭

x-defauts: &defauts
  restart: unless-stopped
  logging:
    driver: json-file
    options:
      max-size: "20m"
      max-file: "3"
  networks:
    - interne

services:
  proxy:
    <<: *defauts
    image: traefik:v3.1
    command:
      - --providers.docker=true
      - --providers.docker.exposedbydefault=false
      - --entrypoints.web.address=:80
      - --entrypoints.websecure.address=:443
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock:ro

  parc:
    <<: *defauts
    image: ⟬hostname#1⟭/dsi/glpi:⟬version#1⟭
    environment:
      GLPI_DB_HOST: base
      GLPI_DB_NAME: glpi
      GLPI_DB_USER: ⟬trap:indicator_non_pii|glpi⟭
      GLPI_DB_PASSWORD_FILE: /run/secrets/glpi_db
      ⟬trap:indicator_non_pii|GLPI_ADMIN_USER: admin⟭
      GLPI_ADMIN_PASSWORD_FILE: /run/secrets/glpi_admin
      ⟬trap:indicator_non_pii|GLPI_LANG: fr_FR⟭
    secrets:
      - glpi_db
      - glpi_admin
    labels:
      - traefik.enable=true
      - traefik.http.routers.parc.rule=Host(`⟬hostname#2⟭`)
      - traefik.http.routers.parc.tls=true
      - ⟬trap:indicator_non_pii|fr.agglo.owner=dsi⟭

  inventaire:
    <<: *defauts
    image: ⟬hostname#1⟭/dsi/inventaire-agent:⟬version#2⟭
    environment:
      - SERVEUR_PARC=https://⟬hostname#2⟭/front/inventory.php
      - JETON_FICHIER=/run/secrets/inventaire
      - ⟬trap:indicator_non_pii|TOKEN_ROTATION_JOURS=90⟭
      - FREQUENCE_HEURES=12
    secrets:
      - inventaire

  base:
    <<: *defauts
    image: ⟬trap:library|mariadb⟭:10.11
    environment:
      MARIADB_DATABASE: glpi
      MARIADB_USER: glpi
      MARIADB_PASSWORD_FILE: /run/secrets/glpi_db
      MARIADB_RANDOM_ROOT_PASSWORD: "yes"
    secrets:
      - glpi_db
    volumes:
      - base:/var/lib/mysql

  ⟬trap:code_identifier|⦃family⦄⟭-sauvegarde:
    <<: *defauts
    image: ⟬hostname#1⟭/dsi/sauvegarde:⟬version#2⟭
    environment:
      CIBLE: ⟬url#2⟭
      PLANIFICATION: "0 2 * * *"
      PHRASE_SECRETE_FICHIER: /run/secrets/sauvegarde
    secrets:
      - sauvegarde
    volumes:
      - base:/source/base:ro

secrets:
  glpi_db:
    file: ./secrets/glpi_db.txt
  glpi_admin:
    file: ./secrets/glpi_admin.txt
  inventaire:
    file: ./secrets/inventaire.txt
  sauvegarde:
    external: true

networks:
  interne:

volumes:
  base:
⟬end⟭

⟬template⟭
family: config
format: Kubernetes .yaml
language: fr
fill_locale: fr_FR
domain: energy
appearance: stringData, YAML block, known_hosts, env value, sidecar, comment
scenario: StatefulSet de la base de séries temporelles d'un gestionnaire de réseau de gaz, avec un sidecar git-sync dont la clé a été ajoutée dans le manifeste
⟬text⟭
# Base de mesures gaz + synchro des requêtes planifiées depuis le dépôt d'exploitation
apiVersion: v1
kind: Secret
metadata:
  name: gitsync-cles
  namespace: mesures-gaz
  annotations:
    # cle generee par ⟬person_name#1⟭ le ⟬date#1⟭
    usage: lecture seule sur le depot requetes
type: Opaque
stringData:
  ssh: |
    ⟬private_key#1⟭
  known_hosts: |
    ⟬hostname#1⟭ ⟬ssh_public_key#1⟭
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: timescale
  namespace: mesures-gaz
  labels:
    app: timescale
    ⟬trap:indicator_non_pii|owner: exploitation-reseau⟭
spec:
  serviceName: timescale
  replicas: 1
  selector:
    matchLabels:
      app: timescale
  template:
    metadata:
      labels:
        app: timescale
    spec:
      initContainers:
        - name: attente-volume
          image: busybox:1.36
          command: ["sh", "-c", "until [ -d /data ]; do sleep 2; done"]
          volumeMounts:
            - name: donnees
              mountPath: /data
      containers:
        - name: timescale
          image: timescale/timescaledb:2.15.3-pg16
          env:
            - name: POSTGRES_DB
              value: mesures
            - name: POSTGRES_USER
              value: mesures_admin
            - name: POSTGRES_PASSWORD
              value: ⟬password#1⟭
            - name: PGDATA
              value: /data/pgdata
          ports:
            - containerPort: 5432
          volumeMounts:
            - name: donnees
              mountPath: /data
        - name: git-sync
          image: registry.k8s.io/git-sync/git-sync:v4.2.3
          args:
            - --repo=ssh://⟬hostname#1⟭/exploitation/requetes.git
            - --root=/requetes
            - --period=300s
          env:
            - name: GITSYNC_SSH_KEY_FILE
              value: /cles/ssh
            - name: NOTIF_SLACK_TOKEN
              value: ⟬slack_token#1⟭
          volumeMounts:
            - name: cles
              mountPath: /cles
              readOnly: true
      volumes:
        - name: cles
          secret:
            secretName: gitsync-cles
            defaultMode: 288
  volumeClaimTemplates:
    - metadata:
        name: donnees
      spec:
        accessModes: ["ReadWriteOnce"]
        resources:
          requests:
            storage: 500Gi
⟬end⟭

⟬template⟭
family: config
format: Kubernetes .yaml
language: fr
fill_locale: fr_FR
domain: education
appearance: annotation, stringData, inline JSON, comment
scenario: Secret de pull d'images et Ingress d'un espace de cours en ligne pour un réseau d'instituts de langues, préparés par le responsable pédagogique du numérique
⟬text⟭
# Espace de cours en ligne - instituts de langues
apiVersion: v1
kind: Secret
metadata:
  name: registre-prive
  namespace: cours-en-ligne
  annotations:
    responsable-pedagogique: "⟬person_name#1⟭"
    joignable: "⟬phone#1⟭"
type: kubernetes.io/dockerconfigjson
stringData:
  .dockerconfigjson: |
    {"auths": {"⟬hostname#1⟭": {"username": "robot-cours", "password": "⟬password#1⟭"}}}
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: cours-en-ligne
  namespace: cours-en-ligne
  annotations:
    nginx.ingress.kubernetes.io/proxy-body-size: 200m
spec:
  rules:
    - host: ⟬hostname#2⟭
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: cours-web
                port:
                  number: 80
⟬end⟭

⟬template⟭
family: config
format: GitHub Actions .yml
language: fr
fill_locale: fr_FR
domain: banking
appearance: environment variable, secret reference, test fixture, comment, curl command
scenario: tests d'intégration de nuit d'une API de virements, où la QA a figé un compte de test et une clé de paiement dans le workflow
⟬text⟭
name: integration-virements-nuit

on:
  schedule:
    - cron: "45 23 * * 1-5"

jobs:
  integration:
    runs-on: ubuntu-latest
    env:
      # compte de test partagé avec la QA, voir ⟬person_name:initial#1⟭
      COMPTE_TEST_TITULAIRE: ⟬person_name#2⟭
      COMPTE_TEST_IBAN: "⟬iban#2⟭"
      COMPTE_TEST_BIC: ⟬bic#2⟭
      PSP_CLE: ⟬stripe_secret_key#3⟭
      BASE_API: ⟬url#1⟭
      JETON_API: ⟬trap:placeholder|${{ secrets.JETON_API_RECETTE }}⟭
      ⟬trap:indicator_non_pii|JETON_API_TTL: 900⟭
    steps:
      - uses: ⟬trap:email_lookalike|actions/checkout@v4⟭
      - uses: ⟬trap:email_lookalike|actions/setup-java@v4⟭
        with:
          distribution: temurin
          java-version: "21"
      - run: ./gradlew integrationTest --tests "*Virement*"
      - name: Purge des virements de test
        if: always()
        run: |
          curl -fsS -X DELETE "$BASE_API/test/virements" \
            -H "Authorization: Bearer $JETON_API" \
            -H "X-Compte: ⟬iban#2⟭"
⟬end⟭

⟬template⟭
family: config
format: GitHub Actions .yml
language: fr
fill_locale: fr_FR
domain: public administration
appearance: action input, environment variable
scenario: publication du site de documentation interne d'une direction départementale, où le jeton Slack est passé directement à l'action de notification
⟬text⟭
name: publier-doc
on: push
jobs:
  publier:
    runs-on: ubuntu-latest
    steps:
      - uses: ⟬trap:email_lookalike|actions/checkout@v4⟭
      - run: rsync -az public/ ⟬trap:email_lookalike|publication@${{ vars.SERVEUR_DOC }}⟭:/var/www/doc/
        env:
          RSYNC_PASSWORD: ⟬password#1⟭
      - uses: ⟬trap:email_lookalike|slackapi/slack-github-action@v1⟭
        with:
          slack-message: Documentation publiée
        env:
          SLACK_BOT_TOKEN: ⟬slack_token#1⟭
⟬end⟭

⟬template⟭
family: config
format: .json
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: nested JSON, string value
scenario: configuration du service d'étiquettes de transport d'une boutique de vin, remplie par le préparateur de commandes et mise dans le dépôt par erreur
⟬text⟭
{
  "transporteur": "colis-express",
  "contrat": {
    "numero": "⟬order_number#1⟭",
    "identifiant": "⟬username#1⟭",
    "motDePasse": "⟬password#1⟭"
  },
  "expediteur": {
    "societe": "⟬company#2⟭",
    "siret": "⟬fr_siret#2⟭",
    "contact": "⟬person_name#3⟭",
    "adresse": "⟬fr_postal_address:street#2⟭",
    "codePostal": "⟬postcode#2⟭",
    "ville": "⟬city#2⟭",
    "telephone": "⟬phone#2⟭"
  },
  "formatEtiquette": "PDF_10x15",
  "poidsMaxKg": 30,
  "produitsSensibles": ["⟬trap:word_name|Margaux⟭", "⟬trap:word_name|Pommard⟭"],
  "assuranceParDefaut": false
}
⟬end⟭

⟬template⟭
family: config
format: .json
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: nested JSON, array, generated config
scenario: google-services.json de l'application de téléconsultation d'un réseau de maisons de santé, généré par la console et commité avec le code Android
⟬text⟭
{
  "project_info": {
    "project_number": "⟬customer_id#1⟭",
    "project_id": "teleconsult-maisons-sante",
    "storage_bucket": "teleconsult-maisons-sante.appspot.com"
  },
  "client": [
    {
      "client_info": {
        "mobilesdk_app_id": "⟬hash#1⟭",
        "android_client_info": {
          "package_name": "fr.maisonsante.teleconsult"
        }
      },
      "oauth_client": [
        {
          "client_id": "⟬uuid#1⟭.apps.googleusercontent.com",
          "client_type": 3
        }
      ],
      "api_key": [
        {
          "current_key": "⟬google_api_key#1⟭"
        }
      ],
      "services": {
        "appinvite_service": {
          "other_platform_oauth_client": []
        }
      }
    },
    {
      "client_info": {
        "mobilesdk_app_id": "⟬hash#2⟭",
        "android_client_info": {
          "package_name": "fr.maisonsante.teleconsult.recette"
        }
      },
      "oauth_client": [],
      "api_key": [
        {
          "current_key": "⟬google_api_key#2⟭"
        }
      ],
      "services": {
        "appinvite_service": {
          "other_platform_oauth_client": []
        }
      }
    }
  ],
  "configuration_version": "1"
}
⟬end⟭

⟬template⟭
family: config
format: .json
language: fr
fill_locale: fr_FR
domain: public administration
appearance: nested JSON, dependency list, script
scenario: package.json du front de suivi des demandes de permis de construire d'une métropole, géré par l'équipe du système de design
⟬text⟭
{
  "name": "⟬trap:email_lookalike|@metropole/suivi-urbanisme⟭",
  "version": "⟬version#1⟭",
  "private": true,
  "description": "Suivi en ligne des demandes d'urbanisme",
  "author": "⟬trap:indicator_non_pii|Direction du numérique⟭",
  "license": "EUPL-1.2",
  "repository": "⟬url#1⟭",
  "scripts": {
    "dev": "vite",
    "build": "tsc -b && vite build",
    "test": "⟬trap:library|jest⟭ --coverage",
    "storybook": "storybook dev -p 6006",
    "lint": "eslint src"
  },
  "dependencies": {
    "⟬trap:email_lookalike|@gouvfr/dsfr⟭": "^1.12.0",
    "⟬trap:email_lookalike|@tanstack/react-query⟭": "^5.51.0",
    "react": "^18.3.1",
    "⟬trap:library|axios⟭": "^1.7.2",
    "⟬trap:library|zod⟭": "^3.23.8",
    "⟬trap:code_identifier|⦃family⦄-tableaux⟭": "^2.1.0"
  },
  "devDependencies": {
    "⟬trap:email_lookalike|@types/node⟭": "^20.14.0",
    "⟬trap:library|jest⟭": "^29.7.0",
    "typescript": "^5.5.0",
    "vite": "^5.3.0"
  },
  "engines": {
    "node": ">=20"
  }
}
⟬end⟭

⟬template⟭
family: config
format: .toml
language: fr
fill_locale: fr_FR
domain: banking
appearance: comment, TOML value, multiline string, table, url
scenario: Rocket.toml d'une passerelle de paiement en Rust d'un établissement de monnaie électronique, écrit par un développeur senior et mal séparé entre profils
⟬text⟭
# Passerelle de paiement - profils Rocket
# Attention : le profil release est aussi utilisé en préprod, cf. ⟬ticket_id#1⟭

[default]
address = "0.0.0.0"
port = 8000
workers = 8
keep_alive = 5
log_level = "normal"
limits = { json = "2 MiB", form = "64 KiB" }

[default.shutdown]
ctrlc = true
grace = 5
mercy = 5

[debug]
log_level = "debug"
secret_key = "⟬trap:placeholder|REPLACE_ME⟭"

[debug.databases.paiements]
url = "postgres://dev:⟬trap:placeholder|${DEV_DB_PASSWORD}⟭@localhost/paiements_dev"
pool_size = 4

[release]
secret_key = "⟬opaque_token#1⟭"
log_level = "critical"

[release.databases.paiements]
url = "postgres://paiements:⟬url_password#1⟭@⟬hostname#1⟭:5432/paiements"
pool_size = 40
connect_timeout = 3

[release.tls]
certs = "/etc/passerelle/fullchain.pem"
key = """
⟬private_key#1⟭
"""

[release.emission]
etablissement = "⟬company#2⟭"
compte_cantonnement = "⟬iban#2⟭"
bic = "⟬bic#2⟭"
plafond_journalier_eur = 500000
⟬trap:indicator_non_pii|iban_check = true⟭

[release.limites]
requetes_par_minute = 6000
taille_lot_max = 500
delai_idempotence_h = 24

[release.conformite]
responsable = "⟬person_name#3⟭"
courriel = "⟬email#3⟭"
⟬trap:indicator_non_pii|pseudonyme_journal = "client_id"⟭
⟬trap:indicator_non_pii|token_ttl = 300⟭

[release.cartes]
# contrôle de ⟬trap:eponym|Luhn⟭ avant tout appel au réseau
controle_local = true
schemes = ["visa", "mastercard"]
⟬end⟭

⟬template⟭
family: config
format: .toml
language: fr
fill_locale: fr_FR
domain: education
appearance: TOML value, multiline string, url
scenario: secrets.toml d'un tableau de bord Streamlit des résultats aux examens, fait par une enseignante de mathématiques pour son lycée
⟬text⟭
[connections.notes]
url = "postgresql://lecture:⟬url_password#1⟭@⟬hostname#1⟭:5432/notes"

[gcp_service_account]
type = "service_account"
client_email = "⟬email:generic#2⟭"
private_key = """
⟬private_key#1⟭
"""

[cartes]
google_api_key = "⟬google_api_key#1⟭"
⟬end⟭

⟬template⟭
family: config
format: .toml
language: fr
fill_locale: fr_FR
domain: energy
appearance: TOML value, inline table, comment, dependency list
scenario: Cargo.toml du décodeur de trames de compteurs d'une régie d'électricité, publié en logiciel libre sans aucune donnée d'exploitation
⟬text⟭
[package]
name = "decodeur-trames"
version = "⟬version#1⟭"
edition = "2021"
description = "Décodage des trames de télérelevé des compteurs"
license = "MIT OR Apache-2.0"
repository = "⟬url#1⟭"
authors = ["⟬trap:indicator_non_pii|Régie, équipe comptage⟭"]
keywords = ["compteur", "telereleve", "energie"]

[dependencies]
⟬trap:library|serde⟭ = { version = "1.0", features = ["derive"] }
⟬trap:library|tokio⟭ = { version = "1.38", features = ["rt-multi-thread", "macros", "net"] }
crc = "3.2"
thiserror = "1.0"
# crc de ⟬trap:eponym|Koopman⟭ pour les trames longues
⟬trap:code_identifier|⦃family⦄_parser⟭ = { path = "../⟬trap:code_identifier|⦃family⦄_parser⟭" }

[dev-dependencies]
⟬trap:library|criterion⟭ = "0.5"
proptest = "1.5"

[features]
default = ["trames-longues"]
trames-longues = []
⟬trap:indicator_non_pii|anonymiser-pdl = []⟭

[profile.release]
lto = true
panic = "abort"
⟬end⟭

⟬template⟭
family: config
format: .ini
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: comment, inventory line, ini key, file path
scenario: inventaire Ansible du parc de serveurs d'une clinique, tenu par l'administrateur système qui y laisse ses mots de passe de connexion
⟬text⟭
# inventaire clinique - maj ⟬date#1⟭
[serveurs_dpi]
⟬hostname#1⟭ ansible_host=⟬ip_address#1⟭ ansible_user=⟬username#1⟭ ansible_password=⟬password#1⟭
⟬hostname#2⟭ ansible_host=⟬ip_address#2⟭ ansible_user=⟬username#1⟭ ansible_password=⟬password#1⟭

[serveurs_imagerie]
⟬hostname#3⟭ ansible_host=⟬ip_address#3⟭ ansible_user=⟬username#2⟭ ansible_become_password=⟬password#2⟭

[postes_admin]
pc-dsi ansible_host=⟬ip_address#4⟭ ansible_user=⟬person_name:handle#3⟭

[all:vars]
ansible_ssh_private_key_file=/home/⟬person_name:handle#3⟭/.ssh/id_ed25519
sauvegarde_url=https://sauvegarde:⟬url_password#1⟭@⟬hostname#5⟭/depot
⟬end⟭

⟬template⟭
family: config
format: .ini
language: fr
fill_locale: fr_FR
domain: banking
appearance: ini key, section header
scenario: fichier .pypirc d'un développeur quantitatif pour publier ses paquets sur l'index interne de la banque
⟬text⟭
[distutils]
index-servers = interne

[interne]
repository = ⟬url#1⟭
username = ⟬person_name:handle#1⟭
password = ⟬password#1⟭
⟬end⟭

⟬template⟭
family: config
format: .ini
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: comment, ini key, inline environment
scenario: supervisord.ini des workers d'une boutique de pièces automobiles, avec tout l'environnement sur une ligne parce que le script d'installation l'a généré ainsi
⟬text⟭
; workers boutique - généré par install.sh, relu par ⟬trap:initials|M.L.⟭ le ⟬date#1⟭
[program:commandes]
command = /srv/boutique/.venv/bin/⟬trap:library|celery⟭ -A boutique worker -Q commandes
directory = /srv/boutique
user = www-data
autorestart = true
environment = STRIPE_KEY="⟬stripe_secret_key#1⟭",SLACK_TOKEN="⟬slack_token#1⟭",REDIS="⟬hostname#1⟭"

[program:catalogue]
command = /srv/boutique/.venv/bin/python manage.py sync_catalogue ⟬trap:company_name|Peugeot⟭ ⟬trap:company_name|Renault⟭
directory = /srv/boutique
user = www-data
environment = FOURNISSEUR_API_CLE="⟬opaque_token#1⟭"
⟬end⟭

⟬template⟭
family: config
format: .properties
language: fr
fill_locale: fr_FR
domain: banking
appearance: comment, properties key, log pattern
scenario: log4j2.properties du moteur de rapprochement d'une caisse d'épargne, avec un appender mail ajouté par l'exploitation pour les erreurs critiques
⟬text⟭
# Journaux du moteur de rapprochement
# Appender mail ajouté par l'exploitation, destinataire de garde : ⟬person_name#1⟭
status=warn
name=rapprochement
appenders=console,fichier,mail

appender.console.type=Console
appender.console.name=CONSOLE
appender.console.layout.type=PatternLayout
⟬trap:indicator_non_pii|appender.console.layout.pattern=%d %-5p [%X{iban_masque}] %c{1} - %m%n⟭

appender.fichier.type=RollingFile
appender.fichier.name=FICHIER
appender.fichier.fileName=/var/log/rapprochement/app.log
appender.fichier.filePattern=/var/log/rapprochement/app-%d{yyyy-MM-dd}.log.gz
appender.fichier.layout.type=JsonTemplateLayout

appender.mail.type=SMTP
appender.mail.name=MAIL
appender.mail.subject=[Rapprochement] erreur critique
appender.mail.to=⟬email#1⟭
appender.mail.from=⟬email:generic#2⟭
appender.mail.smtpHost=⟬hostname#1⟭
appender.mail.smtpPort=587
appender.mail.smtpUsername=⟬email:generic#2⟭
appender.mail.smtpPassword=⟬password#1⟭
appender.mail.filter.threshold.type=ThresholdFilter
appender.mail.filter.threshold.level=fatal

rootLogger.level=info
rootLogger.appenderRef.console.ref=CONSOLE
rootLogger.appenderRef.fichier.ref=FICHIER
rootLogger.appenderRef.mail.ref=MAIL
logger.⟬trap:library|hibernate⟭.name=org.hibernate
logger.⟬trap:library|hibernate⟭.level=warn
⟬end⟭

⟬template⟭
family: config
format: .properties
language: fr
fill_locale: fr_FR
domain: education
appearance: comment, properties key, environment reference
scenario: application.properties du logiciel de gestion d'une bibliothèque universitaire, où chaque valeur sensible est lue dans l'environnement du serveur
⟬text⟭
# Bibliothèque universitaire - gestion des prêts
spring.datasource.url=jdbc:postgresql://⟬hostname#1⟭:5432/bibliotheque
spring.datasource.username=⟬trap:placeholder|${DB_USER}⟭
spring.datasource.password=⟬trap:placeholder|${DB_PASSWORD}⟭
spring.mail.host=⟬hostname#2⟭
spring.mail.username=⟬trap:placeholder|${MAIL_USER}⟭
spring.mail.password=⟬trap:placeholder|${MAIL_PASSWORD}⟭
spring.security.saml2.relyingparty.registration.shibboleth.entity-id=⟬url#1⟭
⟬trap:indicator_non_pii|prets.lecteur.login.attribut=eppn⟭
⟬trap:indicator_non_pii|prets.lecteur.nom.affichage=initiales⟭
⟬trap:indicator_non_pii|prets.relance.mail.expediteur=bibliotheque⟭
prets.fonds.patrimonial=Fonds ⟬trap:eponym|Montaigne⟭
prets.fonds.sciences=Fonds ⟬trap:eponym|Curie⟭
prets.recherche.moteur=⟬trap:library|solr⟭
prets.recherche.distance=⟬trap:eponym|damerau-levenshtein⟭
⟬end⟭

⟬template⟭
family: config
format: .properties
language: fr
fill_locale: fr_FR
domain: energy
appearance: properties key, comment
scenario: fichier de propriétés d'un petit producteur hydroélectrique pour envoyer ses factures de production à l'acheteur obligé
⟬text⟭
# factures production - centrale du moulin
producteur.nom=⟬company#1⟭
producteur.siret=⟬fr_siret#1⟭
producteur.rib=⟬iban#1⟭
acheteur.portail=⟬url#1⟭
acheteur.compte=⟬username#1⟭
acheteur.mdp=⟬password#1⟭
⟬trap:indicator_non_pii|acheteur.contact=service-achat⟭
⟬end⟭
