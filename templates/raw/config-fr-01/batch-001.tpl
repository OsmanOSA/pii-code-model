⟬template⟭
family: config
format: .env
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: comment, assignment, quoted value, url
scenario: .env de préproduction du portail de rendez-vous d'un centre d'imagerie, laissé sur le serveur par le prestataire web qui a livré le site
⟬text⟭
# Portail RDV - centre d'imagerie (préproduction)
# Prestataire : ⟬person_name#1⟭ - ⟬phone#1⟭ (lun-ven 9h-18h)
# Déployé le ⟬date#1⟭, commit ⟬git_sha#1⟭
NODE_ENV=production
PORT=3000
APP_URL=https://⟬hostname#1⟭
CENTRE_NOM="⟬company#2⟭"
CENTRE_ADRESSE="⟬fr_postal_address:street#2⟭"
CENTRE_VILLE="⟬city#2⟭"
TEL_SECRETARIAT="⟬phone#2⟭"
DATABASE_URL=postgres://rdv_app:⟬url_password#1⟭@⟬hostname#3⟭:5432/rdv_preprod?sslmode=require
SESSION_SECRET=⟬opaque_token#1⟭
⟬trap:indicator_non_pii|SESSION_TOKEN_TTL=1800⟭
SMTP_HOST=⟬hostname#4⟭
SMTP_PORT=587
SMTP_USER=⟬email:generic#4⟭
SMTP_PASSWORD=⟬password#1⟭
GOOGLE_MAPS_API_KEY=⟬google_api_key#1⟭
# à remettre à true avant la mise en prod
FEATURE_SMS_RAPPEL=false
SMS_PROVIDER_PASSWORD=⟬trap:placeholder|changeme⟭
⟬end⟭

⟬template⟭
family: config
format: .env
language: fr
fill_locale: fr_FR
domain: banking
appearance: comment, assignment, url, section header
scenario: .env.example d'un agrégateur de comptes DSP2, écrit par le lead technique pour l'arrivée de deux alternants et ne contenant que des valeurs de substitution
⟬text⟭
# .env.example - agrégateur de comptes (API DSP2)
# Copier vers .env puis renseigner les valeurs. Le vrai fichier reste hors du dépôt.
# Mis à jour le ⟬date#1⟭, ticket ⟬ticket_id#1⟭

# --- Application ---
APP_ENV=development
APP_PORT=8080
APP_BASE_URL=http://localhost:8080
LOG_LEVEL=debug
TZ=Europe/Paris
LANGUE_DEFAUT=fr

# --- Base de données ---
DB_HOST=⟬hostname#1⟭
DB_PORT=5432
DB_NAME=agregation
⟬trap:indicator_non_pii|DB_USER=agregation_app⟭
DB_PASSWORD=⟬trap:placeholder|changeme⟭
DATABASE_URL=postgresql://agregation_app:⟬trap:placeholder|${DB_PASSWORD}⟭@⟬hostname#1⟭:5432/agregation
DB_POOL_MAX=20

# --- Cache et sessions ---
REDIS_PASSWORD=⟬trap:placeholder|REPLACE_ME⟭
REDIS_URL=redis://:⟬trap:placeholder|${REDIS_PASSWORD}⟭@⟬hostname#2⟭:6379/0
SESSION_SECRET="⟬trap:placeholder|<à renseigner>⟭"
⟬trap:indicator_non_pii|TOKEN_TTL=3600⟭
⟬trap:indicator_non_pii|REFRESH_TOKEN_TTL=604800⟭

# --- Prestataire d'agrégation ---
PSD2_BASE_URL=⟬url#1⟭
PSD2_CLIENT_ID=⟬uuid#1⟭
PSD2_CLIENT_SECRET=⟬trap:placeholder|xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx⟭
PSD2_CERT_PATH=./certs/qwac.pem
PSD2_KEY_PATH=./certs/qwac.key
PSD2_REDIRECT_URI=http://localhost:8080/callback
PSD2_TIMEOUT_MS=8000

# --- Paiement ---
STRIPE_PUBLISHABLE_KEY=⟬stripe_publishable_key#1⟭
STRIPE_SECRET_KEY=⟬trap:placeholder|sk_test_xxxxxxxxxxxxxxxxxxxxxxxx⟭
STRIPE_WEBHOOK_SECRET=⟬trap:placeholder|whsec_***⟭

# --- Contrôles métier ---
⟬trap:indicator_non_pii|IBAN_CHECK=true⟭
⟬trap:indicator_non_pii|PASSWORD_MIN_LENGTH=12⟭
# clé de ⟬trap:eponym|Luhn⟭ pour les cartes, mod 97 pour les IBAN
CARTE_VALIDATION=strict
PLAFOND_VIREMENT_EUR=15000

# --- Envoi de courriels ---
SMTP_HOST=⟬hostname#3⟭
SMTP_PORT=2525
SMTP_USER=⟬trap:indicator_non_pii|apikey⟭
SMTP_PASSWORD=⟬trap:placeholder|***⟭
EXPEDITEUR_NOM="⟬trap:indicator_non_pii|Service Clients⟭"

# --- Observabilité ---
SENTRY_DSN=
SENTRY_RELEASE=⟬version#1⟭
OTEL_EXPORTER_OTLP_ENDPOINT=http://⟬hostname#4⟭:4317
METRICS_ENABLED=true
⟬end⟭

⟬template⟭
family: config
format: .env
language: fr
fill_locale: fr_FR
domain: energy
appearance: comment, assignment
scenario: fichier d'environnement du batch nocturne de relève des compteurs communicants d'un fournisseur local, écrit vite par l'exploitant
⟬text⟭
# releve-compteurs : batch de nuit
GRD_API_URL=⟬url#1⟭
GRD_CLIENT_ID=⟬uuid#1⟭
GRD_CLIENT_SECRET=⟬opaque_token#1⟭
INFLUX_ORG=releves
INFLUX_TOKEN=⟬opaque_token#2⟭
SLACK_BOT_TOKEN=⟬slack_token#1⟭
SLACK_CANAL=alertes-releves
CRON_RELEVE="15 2 * * *"
⟬end⟭

⟬template⟭
family: config
format: docker-compose.yml
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: comment, YAML value, url, label
scenario: docker-compose de recette d'une boutique en ligne, maintenu par une développeuse qui y a collé les vraies clés de test pour aller plus vite
⟬text⟭
# Recette boutique - docker compose up -d
# Référente : ⟬person_name#1f⟭ <⟬email#1⟭>
services:
  api:
    image: ⟬hostname#1⟭/boutique/api:⟬version#1⟭
    restart: unless-stopped
    environment:
      DATABASE_URL: mysql://boutique:⟬url_password#1⟭@db:3306/boutique
      REDIS_URL: redis://cache:6379/1
      STRIPE_SECRET_KEY: ⟬stripe_secret_key#1⟭
      STRIPE_PUBLISHABLE_KEY: ⟬stripe_publishable_key#1⟭
      ADMIN_EMAIL: ⟬email#1⟭
      ⟬trap:indicator_non_pii|ADMIN_SESSION_TTL: 900⟭
    depends_on: [db, cache]
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.boutique.rule=Host(`⟬hostname#2⟭`)"
      - "com.boutique.contact=⟬email:generic#3⟭"
    ports:
      - "8000:8000"

  db:
    image: ⟬trap:library|mariadb⟭:11.4
    environment:
      MARIADB_DATABASE: boutique
      MARIADB_USER: boutique
      MARIADB_PASSWORD: ⟬url_password#1⟭
      MARIADB_ROOT_PASSWORD: ⟬password#1⟭
    volumes:
      - donnees-db:/var/lib/mysql

  cache:
    image: redis:7-alpine

  worker:
    image: ⟬hostname#1⟭/boutique/api:⟬version#1⟭
    command: ["⟬trap:library|celery⟭", "-A", "boutique", "worker", "-l", "info"]
    environment:
      DATABASE_URL: mysql://boutique:⟬url_password#1⟭@db:3306/boutique

volumes:
  donnees-db:
⟬end⟭

⟬template⟭
family: config
format: docker-compose.yml
language: fr
fill_locale: fr_FR
domain: public administration
appearance: YAML anchor, environment list, YAML value, comment
scenario: compose de la plateforme de démarches en ligne d'une communauté de communes, versionné avec uniquement des variables d'interpolation après un audit de sécurité
⟬text⟭
# Démarches en ligne - toutes les valeurs sensibles viennent du fichier .env du serveur
name: demarches-en-ligne

x-journalisation: &journalisation
  driver: json-file
  options:
    max-size: "10m"
    max-file: "5"

services:
  portail:
    image: ⟬hostname#1⟭/demarches/portail:⟬version#1⟭
    logging: *journalisation
    environment:
      - SPRING_PROFILES_ACTIVE=prod
      - SPRING_DATASOURCE_URL=jdbc:postgresql://base:5432/demarches
      - SPRING_DATASOURCE_USERNAME=⟬trap:indicator_non_pii|demarches_app⟭
      - SPRING_DATASOURCE_PASSWORD=⟬trap:placeholder|${DB_PASSWORD:?mot de passe requis}⟭
      - OIDC_CLIENT_SECRET=⟬trap:placeholder|${OIDC_CLIENT_SECRET}⟭
      - ⟬trap:indicator_non_pii|PASSWORD_RESET_TOKEN_TTL=1800⟭
    depends_on:
      - base
      - sso

  sso:
    image: quay.io/⟬trap:library|keycloak⟭/keycloak:25.0
    logging: *journalisation
    command: start --hostname=⟬hostname#2⟭
    environment:
      KC_DB: postgres
      KC_DB_USERNAME: keycloak
      KC_DB_PASSWORD: ⟬trap:placeholder|${KC_DB_PASSWORD}⟭
      KEYCLOAK_ADMIN: ⟬trap:indicator_non_pii|admin⟭
      KEYCLOAK_ADMIN_PASSWORD: ⟬trap:placeholder|${KC_ADMIN_PASSWORD}⟭

  base:
    image: postgres:16
    logging: *journalisation
    environment:
      POSTGRES_DB: demarches
      POSTGRES_USER: ⟬trap:indicator_non_pii|demarches_app⟭
      POSTGRES_PASSWORD: ⟬trap:placeholder|${DB_PASSWORD}⟭
    volumes:
      - ./sauvegardes:/backup:ro

  ⟬trap:code_identifier|⦃family⦄⟭-worker:
    image: ⟬hostname#1⟭/demarches/worker:⟬version#1⟭
    logging: *journalisation
    environment:
      - QUEUE_URL=amqp://demarches:⟬trap:placeholder|${MQ_PASSWORD}⟭@file:5672/
      - POIDS_MAX_PIECE_JOINTE_MO=20

  file:
    image: rabbitmq:3.13
    logging: *journalisation

  frontal:
    image: ⟬trap:library|caddy⟭:2
    logging: *journalisation
    ports:
      - "443:443"
    environment:
      - SITE=⟬hostname#2⟭
⟬end⟭

⟬template⟭
family: config
format: docker-compose.yml
language: fr
fill_locale: fr_FR
domain: education
appearance: comment, label, YAML value, url, environment list
scenario: compose de l'environnement numérique d'un groupement de lycées, repris par un enseignant référent numérique après le départ de l'ancien administrateur
⟬text⟭
# ENT du groupement de lycées - serveur de production
# Repris le ⟬date#2⟭ par ⟬person_name#1m⟭, enseignant référent numérique
# En cas de panne en dehors des heures de cours : ⟬phone#1⟭
# Ancien admin (parti, ne plus contacter) : ⟬person_name#2m⟭

services:
  plateforme:
    image: ⟬trap:library|bitnami⟭/moodle:4.4
    restart: always
    labels:
      fr.groupement.service: moodle
      fr.groupement.contact.nom: "⟬person_name#1⟭"
      fr.groupement.contact.courriel: "⟬email#1⟭"
      fr.groupement.contact.tel: "⟬phone#1⟭"
      fr.groupement.etablissement: "⟬company#3⟭"
    environment:
      MOODLE_DATABASE_HOST: mariadb
      MOODLE_DATABASE_NAME: moodle
      MOODLE_DATABASE_USER: moodle
      MOODLE_DATABASE_PASSWORD: ⟬password#1⟭
      MOODLE_USERNAME: ⟬trap:indicator_non_pii|admin⟭
      MOODLE_PASSWORD: ⟬password#2⟭
      MOODLE_EMAIL: ⟬email:generic#4⟭
      MOODLE_SITE_NAME: "ENT ⟬city#3⟭"
      MOODLE_SMTP_HOST: ⟬hostname#1⟭
      MOODLE_SMTP_PORT_NUMBER: "587"
      MOODLE_SMTP_USER: ⟬email:generic#4⟭
      MOODLE_SMTP_PASSWORD: ⟬opaque_token#1⟭
    volumes:
      - moodle:/bitnami/moodle
      - moodledata:/bitnami/moodledata
    depends_on:
      - mariadb

  mariadb:
    image: ⟬trap:library|mariadb⟭:10.11
    restart: always
    environment:
      - MARIADB_DATABASE=moodle
      - MARIADB_USER=moodle
      - MARIADB_PASSWORD=⟬password#1⟭
      - MARIADB_ROOT_PASSWORD=⟬password#3⟭
    volumes:
      - mariadb:/var/lib/mysql

  statistiques:
    image: matomo:5
    restart: always
    environment:
      MATOMO_DATABASE_HOST: mariadb
      MATOMO_DATABASE_USERNAME: matomo
      MATOMO_DATABASE_PASSWORD: ⟬url_password#1⟭
      MATOMO_DATABASE_DBNAME: matomo
      MATOMO_DSN: mysql://matomo:⟬url_password#1⟭@mariadb:3306/matomo

  sauvegarde:
    image: ⟬hostname#2⟭/outils/restic:⟬version#1⟭
    restart: on-failure
    environment:
      RESTIC_REPOSITORY: s3:⟬url#1⟭
      RESTIC_PASSWORD: ⟬password#5⟭
      AWS_DEFAULT_REGION: eu-west-3
      NOTIFICATION_ECHEC: mailto:⟬email#1⟭
    volumes:
      - mariadb:/data/mariadb:ro
      - moodledata:/data/moodledata:ro

  proxy:
    image: ⟬trap:library|caddy⟭:2
    restart: always
    ports:
      - "80:80"
      - "443:443"
    environment:
      - ACME_AGREE=true
      - DOMAINE=⟬hostname#3⟭

volumes:
  moodle:
  moodledata:
  mariadb:
⟬end⟭

⟬template⟭
family: config
format: Kubernetes .yaml
language: fr
fill_locale: fr_FR
domain: banking
appearance: annotation, stringData, YAML block, YAML value, url, comment
scenario: manifeste complet du service de virements SEPA d'une banque de détail, généré par l'équipe plateforme puis complété à la main par le responsable applicatif
⟬text⟭
# Service de virements SEPA - namespace dédié
# Revue PCA du ⟬date#1⟭ ; correspondant sécurité : ⟬person_name#2m⟭
apiVersion: v1
kind: Namespace
metadata:
  name: virements
  labels:
    equipe: paiements
    ⟬trap:indicator_non_pii|owner: equipe-plateforme⟭
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: virements-config
  namespace: virements
data:
  CUTOFF_SEPA: "16:30"
  DEVISE: EUR
  ⟬trap:indicator_non_pii|IBAN_CHECK: "true"⟭
  BIC_EMETTEUR: ⟬bic#1⟭
  CLEARING_URL: ⟬url#1⟭
  MONTANT_MAX: "100000"
---
apiVersion: v1
kind: Secret
metadata:
  name: virements-secrets
  namespace: virements
  annotations:
    rotation.banque/responsable: "⟬person_name#1⟭ <⟬email#1⟭>"
    rotation.banque/derniere-rotation: "⟬date#2⟭"
type: Opaque
stringData:
  DB_URL: postgres://virements:⟬url_password#1⟭@⟬hostname#1⟭:5432/virements
  HSM_PIN: "⟬password#1⟭"
  SEPA_COMPTE_TECHNIQUE_IBAN: "⟬iban#1⟭"
  signature-ebics.pem: |
    ⟬private_key#1⟭
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: virements-api
  namespace: virements
  labels:
    app: virements-api
  annotations:
    contact: "⟬person_name#1⟭ - ⟬phone#1⟭"
spec:
  replicas: 3
  selector:
    matchLabels:
      app: virements-api
  template:
    metadata:
      labels:
        app: virements-api
    spec:
      serviceAccountName: virements
      containers:
        - name: api
          image: ⟬hostname#2⟭/paiements/virements-api:⟬version#1⟭
          ports:
            - containerPort: 8443
          envFrom:
            - configMapRef:
                name: virements-config
            - secretRef:
                name: virements-secrets
          readinessProbe:
            httpGet:
              path: /sante
              port: 8443
              scheme: HTTPS
          resources:
            requests:
              cpu: 250m
              memory: 512Mi
            limits:
              memory: 1Gi
---
apiVersion: v1
kind: Service
metadata:
  name: virements-api
  namespace: virements
spec:
  selector:
    app: virements-api
  ports:
    - port: 443
      targetPort: 8443
⟬end⟭

⟬template⟭
family: config
format: Kubernetes .yaml
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: ConfigMap, YAML block, secret reference, comment
scenario: ConfigMap et Deployment du serveur FHIR d'un groupement hospitalier, relus par le RSSI et où tout secret passe par une référence
⟬text⟭
# Serveur FHIR - configuration non sensible uniquement
apiVersion: v1
kind: ConfigMap
metadata:
  name: fhir-config
  namespace: ⟬trap:code_identifier|⦃family⦄-interop⟭
  labels:
    release: ⟬trap:code_identifier|⦃given⦄⟭
    ⟬trap:indicator_non_pii|owner: equipe-interoperabilite⟭
data:
  application.yaml: |
    hapi:
      fhir:
        fhir_version: R4
        default_page_size: 50
        ⟬trap:indicator_non_pii|allow_external_references: true⟭
    # tri phonétique ⟬trap:eponym|Soundex⟭ pour la recherche sur le nom de naissance
    recherche:
      algorithme: ⟬trap:eponym|soundex⟭
      distance: ⟬trap:eponym|levenshtein⟭
    audit:
      ⟬trap:indicator_non_pii|patient_id_format: "uuid"⟭
      retention_jours: 2190
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: fhir-serveur
  namespace: ⟬trap:code_identifier|⦃family⦄-interop⟭
spec:
  replicas: 2
  selector:
    matchLabels:
      app: fhir-serveur
  template:
    metadata:
      labels:
        app: fhir-serveur
    spec:
      containers:
        - name: fhir
          image: ⟬hostname#1⟭/interop/hapi-fhir:⟬version#1⟭
          env:
            - name: SPRING_DATASOURCE_URL
              value: jdbc:postgresql://⟬hostname#2⟭:5432/fhir
            - name: SPRING_DATASOURCE_USERNAME
              value: ⟬trap:indicator_non_pii|fhir_lecture⟭
            - name: SPRING_DATASOURCE_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: fhir-base
                  key: mot-de-passe
          readinessProbe:
            httpGet:
              path: /fhir/metadata
              port: 8080
          volumeMounts:
            - name: config
              mountPath: /app/config
      volumes:
        - name: config
          configMap:
            name: fhir-config
⟬end⟭

⟬template⟭
family: config
format: Kubernetes .yaml
language: fr
fill_locale: fr_FR
domain: energy
appearance: annotation, env value, args list, comment
scenario: CronJob de réconciliation des index de production d'un parc éolien, bricolé par l'ingénieur d'astreinte pendant une panne du coffre de secrets
⟬text⟭
# TEMPORAIRE : le coffre est hs depuis le ⟬date#1⟭, valeurs en dur en attendant
# ⟬person_name#1⟭ ⟬phone#1⟭
apiVersion: batch/v1
kind: CronJob
metadata:
  name: reconciliation-index
  namespace: parc-eolien
  annotations:
    astreinte: "⟬person_name#1⟭, ⟬phone#1⟭"
    exploitant: "⟬company#2⟭"
spec:
  schedule: "*/30 * * * *"
  concurrencyPolicy: Forbid
  jobTemplate:
    spec:
      backoffLimit: 1
      template:
        spec:
          restartPolicy: Never
          containers:
            - name: reconciliation
              image: ⟬hostname#1⟭/scada/reconciliation:⟬version#1⟭
              args:
                - --source=⟬hostname#2⟭
                - --sig
                - ⟬opaque_token#1⟭
                - --fenetre=30m
              env:
                - name: SCADA_USER
                  value: ⟬username#1⟭
                - name: SCADA_PASS
                  value: ⟬password#1⟭
                - name: NOTIF_SLACK
                  value: ⟬slack_token#1⟭
                - name: PARC_SIRET
                  value: "⟬fr_siret#2⟭"
                - name: ⟬trap:indicator_non_pii|TOKEN_REFRESH_SECONDS⟭
                  value: "600"
⟬end⟭

⟬template⟭
family: config
format: GitHub Actions .yml
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: secret reference, YAML block, curl command, HTTP header, JSON payload
scenario: workflow de déploiement d'une boutique, où un développeur a collé la clé SSH et le jeton Slack en dur le soir d'une mise en production ratée
⟬text⟭
name: Déploiement boutique

on:
  push:
    branches: [main]
  workflow_dispatch:

env:
  REGISTRE: ⟬hostname#1⟭
  SERVEUR: ⟬hostname#2⟭

jobs:
  deployer:
    runs-on: ubuntu-latest
    steps:
      - uses: ⟬trap:email_lookalike|actions/checkout@v4⟭

      - name: Connexion au registre
        uses: ⟬trap:email_lookalike|docker/login-action@v3⟭
        with:
          registry: ${{ env.REGISTRE }}
          username: ⟬trap:indicator_non_pii|deploy-bot⟭
          password: ⟬trap:placeholder|${{ secrets.REGISTRY_PASSWORD }}⟭

      - name: Construction de l'image
        run: docker build -t $REGISTRE/boutique:${{ github.sha }} . && docker push $REGISTRE/boutique:${{ github.sha }}

      # TODO repasser par les secrets du dépôt, ça ne marchait pas hier soir
      - name: Mise en production
        env:
          CLE_DEPLOIEMENT: |
            ⟬private_key#1⟭
        run: |
          echo "$CLE_DEPLOIEMENT" > cle.pem
          chmod 600 cle.pem
          ssh -i cle.pem -o StrictHostKeyChecking=no ⟬trap:email_lookalike|deploy@$SERVEUR⟭ "cd /srv/boutique && ./maj.sh ${{ github.sha }}"

      - name: Prévenir le canal
        if: always()
        run: |
          curl -s -X POST https://slack.com/api/chat.postMessage \
            -H "Authorization: Bearer ⟬slack_token#1⟭" \
            -H "Content-Type: application/json" \
            -d '{"channel":"deploiements","text":"Boutique déployée par ⟬person_name#1⟭ (${{ job.status }})"}'
⟬end⟭

⟬template⟭
family: config
format: GitHub Actions .yml
language: fr
fill_locale: fr_FR
domain: public administration
appearance: YAML value, comment, HTTP header
scenario: tâche planifiée d'export open data d'une préfecture, où une clé a été collée en attendant l'accès aux secrets de l'organisation
⟬text⟭
# export open data, clé collée en attendant les droits sur l'organisation
name: export-opendata
on:
  schedule:
    - cron: "30 1 * * *"
jobs:
  exporter:
    runs-on: ubuntu-latest
    env:
      GOOGLE_API_KEY: ⟬google_api_key#1⟭
    steps:
      - uses: ⟬trap:email_lookalike|actions/checkout@v4⟭
      - run: |
          python scripts/geocoder_communes.py --sortie ⟬file_path#1⟭
          curl -fsS -X PUT ⟬url#1⟭ -H "X-Client-Ref: ⟬opaque_token#1⟭" -T ⟬file_path#1⟭
⟬end⟭

⟬template⟭
family: config
format: GitHub Actions .yml
language: fr
fill_locale: fr_FR
domain: education
appearance: secret reference, matrix, YAML value, comment
scenario: intégration continue d'une application de suivi des stages, écrite par une équipe d'université avec des références aux secrets du dépôt uniquement
⟬text⟭
# CI suivi des stages : tests sur chaque version de Python supportée
name: tests-suivi-stages

on:
  pull_request:
  push:
    branches: [develop, main]

jobs:
  tests:
    runs-on: ubuntu-latest
    strategy:
      fail-fast: false
      matrix:
        python: ["3.11", "3.12"]
        base: [postgres, sqlite]
    services:
      postgres:
        image: postgres:16
        env:
          POSTGRES_USER: ⟬trap:indicator_non_pii|ci⟭
          POSTGRES_PASSWORD: ⟬trap:placeholder|${{ secrets.CI_DB_PASSWORD }}⟭
        ports:
          - 5432:5432
    env:
      DJANGO_SETTINGS_MODULE: stages.settings.ci
      ⟬trap:indicator_non_pii|DJANGO_PASSWORD_MIN_LENGTH: 10⟭
      SECRET_KEY: ⟬trap:placeholder|${{ secrets.DJANGO_SECRET_KEY }}⟭
      ⟬trap:indicator_non_pii|CONTACT_SUPPORT: support⟭
    steps:
      - uses: ⟬trap:email_lookalike|actions/checkout@v4⟭
      - uses: ⟬trap:email_lookalike|actions/setup-python@v5⟭
        with:
          python-version: ${{ matrix.python }}
      - run: pip install -r requirements/ci.txt
      - name: Lancer les tests
        run: ⟬trap:library|pytest⟭ --cov=stages --cov-report=xml
      - name: Générer la doc
        run: ⟬trap:library|sphinx⟭-build docs/ public/
      - name: Publier la couverture
        uses: ⟬trap:email_lookalike|codecov/codecov-action@v4⟭
        with:
          token: ⟬trap:placeholder|${{ secrets.CODECOV_TOKEN }}⟭
          slug: ⟬trap:code_identifier|⦃family⦄-lab⟭/suivi-stages
⟬end⟭

⟬template⟭
family: config
format: .json
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: nested JSON, string value
scenario: réglages d'application d'une marketplace de produits fermiers, exportés depuis l'interface d'administration par la gérante pour les envoyer au développeur
⟬text⟭
{
  "boutique": {
    "raisonSociale": "⟬company#1⟭",
    "siret": "⟬fr_siret#1⟭",
    "siege": {
      "adresse": "⟬fr_postal_address:street#1⟭",
      "ville": "⟬city#1⟭",
      "pays": "⟬country#1⟭"
    },
    "gerante": {
      "nom": "⟬person_name#2f⟭",
      "tel": "⟬phone#2⟭",
      "mail": "⟬email#2⟭"
    }
  },
  "paiement": {
    "fournisseur": "stripe",
    "modeTest": false,
    "clePublique": "⟬stripe_publishable_key#3⟭",
    "cleSecrete": "⟬stripe_secret_key#3⟭",
    "virementProducteurs": {
      "ibanSequestre": "⟬iban#1⟭",
      "bic": "⟬bic#1⟭",
      "delaiJours": 7
    }
  },
  "livraison": {
    "transporteurs": ["colissimo", "mondial-relay"],
    "francoDePortEuros": 60
  },
  "dernierExport": "⟬date#1⟭"
}
⟬end⟭

⟬template⟭
family: config
format: .json
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: nested JSON, escaped private key, string value
scenario: fichier de configuration des notifications d'une application de suivi des traitements, avec le compte de service Firebase intégré tel quel par un stagiaire
⟬text⟭
{
  "notifications": {
    "actif": true,
    "fenetreEnvoi": {"debut": "08:00", "fin": "20:00"},
    "maxParJour": 3
  },
  "firebase": {
    "apiKey": "⟬google_api_key#1⟭",
    "authDomain": "⟬hostname#1⟭",
    "projectId": "suivi-traitements-prod",
    "messagingSenderId": "⟬customer_id#1⟭"
  },
  "compteService": {
    "type": "service_account",
    "project_id": "suivi-traitements-prod",
    "private_key_id": "⟬hash#1⟭",
    "private_key": "⟬private_key#1⟭",
    "client_email": "⟬email:generic#2⟭",
    "client_id": "⟬customer_id#2⟭",
    "token_uri": "⟬url#1⟭"
  },
  "support": {
    "numeroVert": "⟬phone#3⟭",
    "contact": "⟬trap:indicator_non_pii|support⟭"
  }
}
⟬end⟭

⟬template⟭
family: config
format: .toml
language: fr
fill_locale: fr_FR
domain: energy
appearance: comment, TOML value, url, array
scenario: configuration de la passerelle de télémétrie de postes de transformation, éditée sur place par un technicien réseau
⟬text⟭
# passerelle-telemetrie - poste source
# config éditée sur site par ⟬person_name#1⟭, ⟬phone#1⟭ en cas de souci

[passerelle]
nom = "ps-⟬city#2⟭"
intervalle_s = 30
fuseau = "Europe/Paris"

[mqtt]
broker = "mqtts://⟬hostname#1⟭:8883"
identifiant = "⟬username#1⟭"
jeton = "⟬opaque_token#1⟭"
qos = 1
sujets = ["postes/+/tension", "postes/+/intensite", "postes/+/alarme"]

[stockage]
dsn = "postgresql://telemetrie:⟬url_password#1⟭@⟬hostname#2⟭:5432/mesures"
retention_jours = 400

[alertes]
destinataires = ["⟬email#1⟭", "⟬email:generic#3⟭"]
seuil_tension_kv = 21.5
⟬end⟭

⟬template⟭
family: config
format: .toml
language: fr
fill_locale: fr_FR
domain: banking
appearance: comment, TOML value, table, array of tables
scenario: paramètres du moteur de scoring anti-fraude d'une néobanque, relus par l'équipe risques et sans aucune donnée client
⟬text⟭
# Scoring anti-fraude : seuils validés en comité risques du ⟬date#1⟭

[moteur]
version_modele = "⟬version#1⟭"
seuil_blocage = 0.92
seuil_revue = 0.75
⟬trap:indicator_non_pii|token_ttl = 3600⟭

[source_donnees]
hote = "⟬hostname#1⟭"
port = 5432
base = "scoring"
⟬trap:indicator_non_pii|utilisateur = "scoring_ro"⟭
mot_de_passe = "⟬trap:placeholder|${SCORING_DB_PASSWORD}⟭"

[controles]
⟬trap:indicator_non_pii|iban_check = true⟭
# distance de ⟬trap:eponym|Jaro-Winkler⟭ entre le nom du titulaire et celui du bénéficiaire
⟬trap:indicator_non_pii|nom_similarite_min = 0.85⟭
# test de ⟬trap:eponym|Benford⟭ sur les montants
benford_actif = true

[[regles]]
code = "VIR-PAYS-RISQUE"
poids = 40

[[regles]]
code = "CARTE-NOUVEL-APPAREIL"
poids = 25
fenetre_h = 48
⟬end⟭

⟬template⟭
family: config
format: .ini
language: fr
fill_locale: fr_FR
domain: public administration
appearance: comment, ini key, section header
scenario: fichier app.ini du logiciel d'état civil d'une mairie, installé par un éditeur local et jamais rouvert depuis
⟬text⟭
; etat-civil - installation mairie
; Installé par ⟬company#1⟭, assistance : ⟬phone#1⟭
; Secrétaire de mairie référente : Mme ⟬person_name#2f⟭

[collectivite]
nom = Mairie de ⟬city#3⟭
adresse = ⟬fr_postal_address#3⟭
siret = ⟬fr_siret#3⟭
telephone = ⟬phone#3⟭
courriel = ⟬email:generic#3⟭

[base]
serveur = ⟬hostname#1⟭
port = 1433
nom = ETATCIVIL
utilisateur = ⟬username#1⟭
mot_de_passe = ⟬password#1⟭

[messagerie]
smtp = ⟬hostname#2⟭
utilisateur = ⟬email:generic#3⟭
mot_de_passe = ⟬password#2⟭

[securite]
⟬trap:indicator_non_pii|longueur_min_mdp = 12⟭
⟬trap:indicator_non_pii|duree_session = 1200⟭
⟬trap:indicator_non_pii|mdp_expiration_jours = 90⟭

[impression]
modele_acte = ⟬file_path#1⟭
⟬end⟭

⟬template⟭
family: config
format: .ini
language: fr
fill_locale: fr_FR
domain: education
appearance: ini key, url
scenario: alembic.ini du projet de gestion des inscriptions d'une université, avec l'URL de préproduction restée dans le fichier
⟬text⟭
[alembic]
script_location = migrations
file_template = %%(year)d%%(month).2d%%(day).2d_%%(rev)s
sqlalchemy.url = postgresql+psycopg://inscriptions:⟬url_password#1⟭@⟬hostname#1⟭:5432/inscriptions_pp

[post_write_hooks]
hooks = ⟬trap:library|black⟭
⟬trap:library|black⟭.type = console_scripts
⟬trap:library|black⟭.entrypoint = ⟬trap:library|black⟭
⟬end⟭

⟬template⟭
family: config
format: .properties
language: fr
fill_locale: fr_FR
domain: banking
appearance: comment, properties key, url
scenario: application-prod.properties d'un service de prélèvements SEPA en Spring Boot, enrichi par couches successives depuis cinq ans par plusieurs équipes
⟬text⟭
# ==============================================================
# Service de prélèvements SEPA - profil prod
# Créé le ⟬date#3⟭ par ⟬person_name#1⟭
# Repris par l'équipe Flux, responsable actuelle : ⟬person_name#2f⟭ (⟬email#2⟭)
# ==============================================================

spring.application.name=prelevements-sepa
server.port=8443
server.ssl.enabled=true
server.ssl.key-store=/etc/prelevements/keystore.p12
server.ssl.key-store-password=⟬password#1⟭
server.servlet.session.timeout=15m

# --- Base Oracle ---
spring.datasource.url=jdbc:oracle:thin:@⟬hostname#1⟭:1521/PRELEV
spring.datasource.username=⟬username#1⟭
spring.datasource.password=⟬password#2⟭
spring.datasource.hikari.maximum-pool-size=30
spring.jpa.hibernate.ddl-auto=validate
spring.jpa.show-sql=false

# --- Créancier ---
sepa.creancier.nom=⟬company#3⟭
sepa.creancier.siret=⟬fr_siret#3⟭
sepa.creancier.iban=⟬iban#3⟭
sepa.creancier.bic=⟬bic#3⟭
sepa.creancier.adresse=⟬fr_postal_address#3⟭
sepa.lot.taille-max=5000
sepa.lot.heure-depart=17:00
⟬trap:indicator_non_pii|sepa.iban.check=true⟭

# --- Portail mandats ---
mandats.portail.url=⟬url#1⟭
mandats.portail.token=⟬opaque_token#1⟭
mandats.signature.fournisseur=universign
mandats.signature.login=⟬email:generic#4⟭
mandats.signature.mot-de-passe=⟬password#3⟭
⟬trap:indicator_non_pii|mandats.signature.token-ttl=7200⟭

# --- Files de messages ---
spring.rabbitmq.addresses=amqps://prelev:⟬url_password#1⟭@⟬hostname#2⟭:5671
spring.rabbitmq.listener.simple.concurrency=4

# --- Notifications d'échec ---
notif.slack.jeton=⟬slack_token#1⟭
notif.slack.canal=flux-sepa-rejets
notif.mail.copie=⟬email#2⟭
notif.mail.astreinte=⟬phone#5⟭

# --- Journalisation ---
logging.level.root=INFO
logging.level.fr.banque.sepa=DEBUG
logging.level.org.⟬trap:library|hibernate⟭.SQL=WARN
logging.file.path=/var/log/prelevements
⟬trap:indicator_non_pii|logging.pattern.user=%X{userId}⟭

# --- Actuator ---
management.endpoints.web.exposure.include=health,info,prometheus
management.endpoint.health.show-details=when_authorized
management.server.port=9090
management.endpoint.health.probes.enabled=true
management.metrics.tags.application=prelevements-sepa
⟬end⟭

⟬template⟭
family: config
format: .properties
language: fr
fill_locale: fr_FR
domain: energy
appearance: properties key, url, comment
scenario: fichier de propriétés du module de facturation d'un fournisseur d'électricité verte, livré avec la clé de paiement du compte de recette
⟬text⟭
# facturation - recette
datasource.url=jdbc:postgresql://⟬hostname#1⟭/facturation?user=facturation&password=⟬url_password#1⟭
paiement.fournisseur=stripe
paiement.k=⟬stripe_secret_key#1⟭
paiement.cle.publique=⟬stripe_publishable_key#1⟭
facture.emetteur=⟬company#2⟭
facture.emetteur.siret=⟬fr_siret#2⟭
facture.pdf.modele=⟬trap:library|jasper⟭-facture-v3
⟬trap:indicator_non_pii|facture.contact=support⟭
⟬end⟭
