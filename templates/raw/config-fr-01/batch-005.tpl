⟬template⟭
family: config
format: .env
language: fr
fill_locale: fr_FR
domain: energy
appearance: comment, assignment, quoted value
scenario: .env de production d'un agrégateur d'effacement électrique, tenu par le responsable d'exploitation qui y note le site pilote du programme
⟬text⟭
# Agrégateur d'effacement : API marché + portail des sites industriels
# Site pilote du programme, à garder sous la main pendant les tests d'activation
SITE_PILOTE_NOM="⟬company#3⟭"
SITE_PILOTE_CONTACT="⟬person_name#4⟭"
SITE_PILOTE_TEL="⟬phone#4⟭"

MARCHE_API_URL=⟬url#1⟭
MARCHE_CERT_MDP=⟬password#1⟭
⟬trap:indicator_non_pii|MARCHE_TOKEN_MARGE_SECONDES=120⟭
PORTAIL_URL=https://⟬hostname#1⟭
PORTAIL_CARTE_CLE=⟬google_api_key#1⟭
FACTURATION_CLE=⟬stripe_secret_key#2⟭
FACTURATION_CLE_PUBLIQUE=⟬stripe_publishable_key#2⟭
SEUIL_ACTIVATION_MW=1.5
PREAVIS_MINUTES=30
⟬end⟭

⟬template⟭
family: config
format: .env
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: assignment, no announcing word
scenario: fichier d'environnement minimal d'un site de vente de thé, avec deux clés mal nommées par un développeur freelance pressé
⟬text⟭
BOUTIQUE=the-et-infusions
K1=⟬stripe_secret_key#1⟭
K2=⟬slack_token#1⟭
K3=⟬stripe_publishable_key#1⟭
CANAL=ventes
PORT=8080
⟬end⟭

⟬template⟭
family: config
format: .env
language: fr
fill_locale: fr_FR
domain: public administration
appearance: comment, assignment, url, section header
scenario: .env d'exemple de la plateforme de budget participatif d'une ville, livré avec le chart de déploiement par la coopérative qui l'héberge
⟬text⟭
# Budget participatif - exemple de configuration
# Ce fichier est public. Toutes les valeurs sont à remplacer à l'installation.

# --- Rails ---
RAILS_ENV=production
RAILS_LOG_TO_STDOUT=true
RAILS_MAX_THREADS=5
SECRET_KEY_BASE=⟬trap:placeholder|<à générer avec rails secret>⟭

# --- Plateforme ---
DECIDIM_HOST=⟬hostname#1⟭
DECIDIM_APPLICATION_NAME="Budget participatif de ⟬city#1⟭"
DECIDIM_FORCE_SSL=true
DECIDIM_DEFAULT_LOCALE=fr
⟬trap:indicator_non_pii|DECIDIM_ADMIN_PASSWORD_MIN_LENGTH=15⟭
⟬trap:indicator_non_pii|DECIDIM_USER_NAME_MAX_LENGTH=40⟭
⟬trap:indicator_non_pii|DECIDIM_CONTACT=mairie⟭

# --- Base de données ---
DATABASE_HOST=⟬hostname#2⟭
DATABASE_NAME=decidim
⟬trap:indicator_non_pii|DATABASE_USERNAME=decidim⟭
DATABASE_PASSWORD=⟬trap:placeholder|xxxx⟭

# --- Courriels ---
SMTP_ADDRESS=⟬hostname#3⟭
SMTP_PORT=587
SMTP_USERNAME=⟬trap:placeholder|REPLACE_ME⟭
SMTP_PASSWORD=⟬trap:placeholder|REPLACE_ME⟭

# --- Vote ---
# dépouillement à la méthode de ⟬trap:eponym|Condorcet⟭ pour les projets finalistes
VOTE_METHODE=⟬trap:eponym|condorcet⟭
VOTE_OUVERTURE="⟬date#1⟭"
⟬end⟭

⟬template⟭
family: config
format: docker-compose.yml
language: fr
fill_locale: fr_FR
domain: banking
appearance: comment, YAML block, YAML value, test card
scenario: compose du bac à sable de tokenisation des cartes d'un acquéreur, monté par l'équipe sécurité pour montrer le fonctionnement aux auditeurs
⟬text⟭
# Bac à sable de tokenisation, démonstration pour l'audit PCI du ⟬date#1⟭
# Responsable : ⟬person_name#1⟭
services:
  coffre:
    image: hashicorp/vault:1.17
    cap_add: [IPC_LOCK]
    environment:
      VAULT_DEV_ROOT_TOKEN_ID: ⟬opaque_token#1⟭
      VAULT_DEV_LISTEN_ADDRESS: 0.0.0.0:8200
    ports:
      - "8200:8200"

  tokeniseur:
    image: ⟬hostname#1⟭/monetique/tokeniseur:⟬version#1⟭
    environment:
      VAULT_ADDR: http://coffre:8200
      VAULT_TOKEN: ⟬opaque_token#1⟭
      HSM_SIMULE: "true"
      HSM_CLE_MAITRE: |
        ⟬private_key#1⟭
      CARTE_DEMO_PAN: "⟬payment_card#2⟭"
      CARTE_DEMO_CVV: "⟬card_security_code#2⟭"
      CARTE_DEMO_PORTEUR: ⟬person_name#2⟭
      ⟬trap:indicator_non_pii|CVV_CONSERVATION_JOURS: 0⟭
    depends_on:
      - coffre
⟬end⟭

⟬template⟭
family: config
format: docker-compose.yml
language: fr
fill_locale: fr_FR
domain: energy
appearance: comment, YAML value, environment list
scenario: compose de la gestion technique d'un bâtiment tertiaire, écrit par un thermicien pour suivre les consommations sans sortie vers internet
⟬text⟭
# GTB du bâtiment - tout reste sur le réseau local
services:
  automate:
    image: nodered/node-red:4.0
    environment:
      - TZ=Europe/Paris
      - ⟬trap:indicator_non_pii|NODE_RED_CREDENTIAL_SECRET=false⟭
    ports:
      - "1880:1880"
    volumes:
      - ./flux:/data

  mesures:
    image: influxdb:2.7
    environment:
      DOCKER_INFLUXDB_INIT_MODE: setup
      DOCKER_INFLUXDB_INIT_USERNAME: ⟬trap:indicator_non_pii|technique⟭
      DOCKER_INFLUXDB_INIT_PASSWORD: ⟬trap:placeholder|${INFLUX_PASSWORD}⟭
      DOCKER_INFLUXDB_INIT_ORG: batiment
      DOCKER_INFLUXDB_INIT_BUCKET: consommations
      DOCKER_INFLUXDB_INIT_ADMIN_TOKEN: ⟬trap:placeholder|${INFLUX_TOKEN}⟭
    volumes:
      - mesures:/var/lib/influxdb2

  passerelle-bacnet:
    image: ⟬hostname#1⟭/gtb/passerelle-bacnet:⟬version#1⟭
    environment:
      RESEAU: 192.168.40.0/24
      CTA_NORD: ⟬trap:word_name|Ambre⟭
      CTA_SUD: ⟬trap:word_name|Jade⟭
      # loi de ⟬trap:eponym|Joule⟭ pour estimer les pertes sur les départs
      MODELE_PERTES: ⟬trap:eponym|joule⟭

volumes:
  mesures:
⟬end⟭

⟬template⟭
family: config
format: docker-compose.yml
language: fr
fill_locale: fr_FR
domain: education
appearance: comment, label, YAML value, url
scenario: compose du cloud pédagogique d'un centre de formation d'apprentis, déployé par le formateur en réseaux avec ses apprentis
⟬text⟭
# Cloud pédagogique du CFA
# Formateur référent : ⟬person_name#1m⟭ (⟬email#1⟭)
services:
  nextcloud:
    image: nextcloud:29-apache
    restart: always
    labels:
      cfa.contact: "⟬person_name#1⟭"
      cfa.secretariat: "⟬phone#2⟭"
    environment:
      NEXTCLOUD_ADMIN_USER: ⟬trap:indicator_non_pii|admin⟭
      NEXTCLOUD_ADMIN_PASSWORD: ⟬password#1⟭
      NEXTCLOUD_TRUSTED_DOMAINS: ⟬hostname#1⟭
      POSTGRES_HOST: base
      POSTGRES_DB: nextcloud
      POSTGRES_USER: nextcloud
      POSTGRES_PASSWORD: ⟬password#2⟭
      SMTP_HOST: ⟬hostname#2⟭
      SMTP_NAME: ⟬email:generic#3⟭
      SMTP_PASSWORD: ⟬password#3⟭
      RECAPTCHA_CLE: ⟬google_api_key#1⟭
    volumes:
      - nextcloud:/var/www/html
  base:
    image: postgres:16-alpine
    environment:
      POSTGRES_DB: nextcloud
      POSTGRES_USER: nextcloud
      POSTGRES_PASSWORD: ⟬password#2⟭
  collabora:
    image: collabora/code:24.04
    environment:
      aliasgroup1: https://⟬hostname#1⟭
      username: ⟬trap:indicator_non_pii|collabora⟭
      password: ⟬password#4⟭

volumes:
  nextcloud:
⟬end⟭

⟬template⟭
family: config
format: Kubernetes .yaml
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: annotation, stringData, env value, secret reference
scenario: manifeste du consommateur de webhooks de paiement d'un loueur de matériel de sport, rédigé à deux par un développeur et une DevOps
⟬text⟭
apiVersion: v1
kind: Secret
metadata:
  name: paiement-webhooks
  namespace: location
  annotations:
    equipe/referente: "⟬person_name#1f⟭ <⟬email#1⟭>"
type: Opaque
stringData:
  STRIPE_SECRET_KEY: ⟬stripe_secret_key#2⟭
  STRIPE_WEBHOOK_SECRET: ⟬opaque_token#1⟭
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: paiement-webhooks
  namespace: location
  labels:
    app: paiement-webhooks
    ⟬trap:indicator_non_pii|owner: equipe-paiement⟭
spec:
  replicas: 2
  selector:
    matchLabels:
      app: paiement-webhooks
  template:
    metadata:
      labels:
        app: paiement-webhooks
    spec:
      containers:
        - name: consommateur
          image: ⟬hostname#1⟭/location/webhooks:⟬version#1⟭
          envFrom:
            - secretRef:
                name: paiement-webhooks
          env:
            - name: EMETTEUR_SIRET
              value: "⟬fr_siret#3⟭"
            - name: IBAN_REVERSEMENT
              value: "⟬iban#3⟭"
            - name: STRIPE_PUBLISHABLE_KEY
              value: ⟬stripe_publishable_key#2⟭
            - name: ⟬trap:indicator_non_pii|WEBHOOK_TOKEN_HEADER⟭
              value: ⟬trap:indicator_non_pii|Stripe-Signature⟭
⟬end⟭

⟬template⟭
family: config
format: Kubernetes .yaml
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: command list, url
scenario: Job ponctuel de reprise de données pour la fusion de deux dossiers patients informatisés, lancé une seule fois par l'intégrateur
⟬text⟭
apiVersion: batch/v1
kind: Job
metadata:
  name: reprise-dossiers
spec:
  template:
    spec:
      restartPolicy: OnFailure
      containers:
        - name: reprise
          image: ⟬hostname#1⟭/sante/reprise:⟬version#1⟭
          command: ["psql", "postgresql://reprise:⟬url_password#1⟭@⟬hostname#2⟭/dossiers", "-f", "/sql/fusion.sql"]
⟬end⟭

⟬template⟭
family: config
format: Kubernetes .yaml
language: fr
fill_locale: fr_FR
domain: education
appearance: comment, ConfigMap, YAML block, label, secret reference, node selector
scenario: déploiement complet de la plateforme de surveillance d'examens à distance d'une université, relu par la déléguée à la protection des données
⟬text⟭
# Surveillance d'examens à distance - version relue DPO du ⟬date#1⟭
# Pas de donnée nominative dans ce dépôt : tout vient de l'annuaire au démarrage.
apiVersion: v1
kind: ConfigMap
metadata:
  name: examens-config
  namespace: examens
  labels:
    ⟬trap:indicator_non_pii|owner: direction-du-numerique⟭
data:
  examens.yaml: |
    session:
      duree_max_minutes: 240
      tolerance_retard_minutes: 15
    captation:
      video: false
      ecran: true
      ⟬trap:indicator_non_pii|photo_identite: false⟭
    annuaire:
      url: ldaps://⟬hostname#1⟭:636
      ⟬trap:indicator_non_pii|attribut_nom: sn⟭
      ⟬trap:indicator_non_pii|attribut_prenom: givenName⟭
      ⟬trap:indicator_non_pii|attribut_mail: mail⟭
      bind_mot_de_passe: ⟬trap:placeholder|${ANNUAIRE_BIND_PASSWORD}⟭
    surveillants:
      ⟬trap:indicator_non_pii|contact: scolarite⟭
      alerte_canal: examens-alertes
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: examens-web
  namespace: examens
  labels:
    app: examens-web
    release: ⟬trap:code_identifier|⦃given⦄⟭
spec:
  replicas: 5
  selector:
    matchLabels:
      app: examens-web
  template:
    metadata:
      labels:
        app: examens-web
    spec:
      nodeSelector:
        pool: ⟬trap:word_name|Perle⟭
      containers:
        - name: web
          image: ⟬hostname#2⟭/examens/web:⟬version#1⟭
          ports:
            - containerPort: 8080
          env:
            - name: ANNUAIRE_BIND_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: annuaire
                  key: bind
            - name: SESSION_SECRET
              valueFrom:
                secretKeyRef:
                  name: examens-web
                  key: session
            - name: ⟬trap:indicator_non_pii|SESSION_TOKEN_TTL⟭
              value: "14400"
          volumeMounts:
            - name: config
              mountPath: /etc/examens
          livenessProbe:
            httpGet:
              path: /sante
              port: 8080
      volumes:
        - name: config
          configMap:
            name: examens-config
---
apiVersion: v1
kind: Service
metadata:
  name: examens-web
  namespace: examens
spec:
  selector:
    app: examens-web
  ports:
    - port: 80
      targetPort: 8080
---
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: examens-web
  namespace: examens
spec:
  minAvailable: 3
  selector:
    matchLabels:
      app: examens-web
⟬end⟭

⟬template⟭
family: config
format: GitHub Actions .yml
language: fr
fill_locale: fr_FR
domain: public administration
appearance: comment, YAML block, environment variable, secret reference, command line, heredoc
scenario: chaîne complète de mise à jour de la cartographie des services d'un département, fusion de trois vieux scripts par un géomaticien
⟬text⟭
# Cartographie des services publics du département
# Fusion des trois scripts de ⟬person_name#1m⟭ (parti à la retraite), à simplifier un jour
name: cartographie-services

on:
  schedule:
    - cron: "0 4 1 * *"
  workflow_dispatch:
    inputs:
      millesime:
        description: Millésime des données
        required: true
        default: "2026"

env:
  ORGANISME: Conseil départemental
  SIRET_PUBLICATION: "⟬fr_siret#2⟭"

jobs:
  geocoder:
    runs-on: ubuntu-latest
    env:
      GOOGLE_API_KEY: ⟬google_api_key#1⟭
    steps:
      - uses: ⟬trap:email_lookalike|actions/checkout@v4⟭
      - uses: ⟬trap:email_lookalike|actions/setup-python@v5⟭
        with:
          python-version: "3.12"
      - run: pip install ⟬trap:library|pandas⟭ ⟬trap:library|geopandas⟭ ⟬trap:library|shapely⟭
      - run: python geocoder.py --millesime ${{ inputs.millesime }} --sortie services.gpkg
      - uses: ⟬trap:email_lookalike|actions/upload-artifact@v4⟭
        with:
          name: services
          path: services.gpkg

  tuiles:
    needs: geocoder
    runs-on: [self-hosted, sig]
    steps:
      - uses: ⟬trap:email_lookalike|actions/download-artifact@v4⟭
        with:
          name: services
      - run: tippecanoe -zg -o services.pmtiles services.gpkg
      - name: Dépôt sur le serveur cartographique
        env:
          CLE_SERVEUR_SIG: |
            ⟬private_key#1⟭
        run: |
          cat > cle_sig <<EOF
          $CLE_SERVEUR_SIG
          EOF
          chmod 600 cle_sig
          scp -i cle_sig services.pmtiles ⟬trap:email_lookalike|sig@${{ vars.SERVEUR_SIG }}⟭:/srv/tuiles/
          rm -f cle_sig

  annonce:
    needs: tuiles
    runs-on: ubuntu-latest
    steps:
      - name: Mise à jour du portail
        run: |
          curl -fsS -X POST ⟬url#1⟭ \
            -u ⟬username#2⟭:⟬password#1⟭ \
            -d "jeu=services&millesime=${{ inputs.millesime }}"
      - name: Prévenir le service communication
        uses: ⟬trap:email_lookalike|departement/actions-partagees/envoi-courriel@v2⟭
        with:
          server_address: ⟬hostname#2⟭
          username: ⟬trap:placeholder|${{ secrets.MAIL_USER }}⟭
          password: ⟬trap:placeholder|${{ secrets.MAIL_PASSWORD }}⟭
          to: ⟬email:generic#3⟭
          from: ⟬email:generic#4⟭
          subject: Cartographie mise à jour
          body: Bonjour, la carte des services est à jour. ⟬person_name:given#5⟭, peux-tu relire ?
⟬end⟭

⟬template⟭
family: config
format: GitHub Actions .yml
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: environment variable, secret reference, curl command, comment
scenario: construction de l'application mobile de suivi du diabète par une petite équipe, avec les identifiants Fastlane copiés depuis le poste du développeur iOS
⟬text⟭
name: application-mobile

on:
  push:
    branches: [release/*]

jobs:
  ios:
    runs-on: macos-14
    env:
      # compte développeur de ⟬person_name#1⟭, à remplacer par une clé d'API
      FASTLANE_USER: ⟬email#1⟭
      FASTLANE_PASSWORD: ⟬password#1⟭
      MATCH_PASSWORD: ⟬trap:placeholder|${{ secrets.MATCH_PASSWORD }}⟭
      MAPS_SDK_KEY: ⟬google_api_key#1⟭
    steps:
      - uses: ⟬trap:email_lookalike|actions/checkout@v4⟭
      - run: bundle install
      - run: bundle exec fastlane ios beta
      - name: Annonce
        run: >-
          curl -s -d "channel=app-mobile" -d "text=Build iOS prête"
          -H "Authorization: Bearer ⟬slack_token#1⟭"
          https://slack.com/api/chat.postMessage
⟬end⟭

⟬template⟭
family: config
format: GitHub Actions .yml
language: fr
fill_locale: fr_FR
domain: energy
appearance: comment, secret reference, matrix, YAML value
scenario: tests matériels du firmware d'une sonde de réseau électrique sur des bancs reliés au runner de l'atelier, avec uniquement des références aux secrets
⟬text⟭
# Tests sur banc : un job par révision de carte
name: tests-banc

on:
  pull_request:
    paths: ["firmware/**"]

concurrency:
  group: banc-${{ matrix.carte }}

jobs:
  banc:
    runs-on: [self-hosted, atelier]
    strategy:
      matrix:
        carte: [rev-c, rev-d]
        modem: [lte-m, nb-iot]
    env:
      SONDE_ID: ⟬uuid#1⟭
      RESEAU_APN: ⟬trap:indicator_non_pii|internet⟭
      RESEAU_USER: ⟬trap:indicator_non_pii|sonde⟭
      RESEAU_PASS: ⟬trap:placeholder|${{ secrets.APN_PASSWORD }}⟭
      ⟬trap:indicator_non_pii|SIM_PIN_ACTIF: false⟭
    steps:
      - uses: ⟬trap:email_lookalike|actions/checkout@v4⟭
      - run: make flash CARTE=${{ matrix.carte }}
      - run: ./bancs/lancer.py --modem ${{ matrix.modem }} --rapport rapport.xml
      # filtre de ⟬trap:eponym|Kalman⟭ vérifié sur les courbes de référence
      - run: python bancs/comparer_courbes.py rapport.xml
      - uses: ⟬trap:email_lookalike|actions/upload-artifact@v4⟭
        if: failure()
        with:
          name: traces-${{ matrix.carte }}
          path: traces/
⟬end⟭

⟬template⟭
family: config
format: .json
language: fr
fill_locale: fr_FR
domain: banking
appearance: nested JSON, array, string value
scenario: paramètres du connecteur entre le logiciel comptable et la banque d'une société de financement, exportés pour une demande de support
⟬text⟭
{
  "societe": {
    "code": "⟬customer_id#1⟭",
    "libelle": "⟬company#1⟭",
    "siret": "⟬fr_siret#1⟭"
  },
  "comptes": [
    {"journal": "BQ1", "iban": "⟬iban#1⟭", "bic": "⟬bic#1⟭", "devise": "EUR"},
    {"journal": "BQ2", "iban": "⟬iban#2⟭", "bic": "⟬bic#2⟭", "devise": "EUR"}
  ],
  "releves": {
    "protocole": "ebics",
    "hote": "⟬hostname#1⟭",
    "partnerId": "⟬username#1⟭",
    "userId": "⟬username#2⟭",
    "motDePasseCertificat": "⟬password#1⟭"
  },
  "notifications": {
    "slackToken": "⟬slack_token#1⟭",
    "canal": "tresorerie",
    "appelerEnCasDeRejet": "⟬phone#3⟭"
  },
  "dernierImport": "⟬date#1⟭"
}
⟬end⟭

⟬template⟭
family: config
format: .json
language: fr
fill_locale: fr_FR
domain: education
appearance: nested JSON, escaped private key, array, string value
scenario: configuration du portail d'authentification d'un rectorat pour les applications des établissements, assemblée par un architecte à partir de plusieurs fiches de fédération
⟬text⟭
{
  "portail": {
    "nom": "Portail académique",
    "url": "https://⟬hostname#1⟭",
    "langues": ["fr"],
    "sessionMinutes": 480,
    "⟬trap:indicator_non_pii|motDePasseLongueurMin⟭": 12
  },
  "saml": {
    "entityId": "⟬url#1⟭",
    "certificatPublic": "/etc/portail/saml.crt",
    "clePrivee": "⟬private_key#1⟭",
    "algorithme": "rsa-sha256",
    "attributs": {
      "⟬trap:indicator_non_pii|nom⟭": "sn",
      "⟬trap:indicator_non_pii|prenom⟭": "givenName",
      "⟬trap:indicator_non_pii|courriel⟭": "mail"
    }
  },
  "applications": [
    {
      "code": "cahier-textes",
      "editeur": "⟬company#2⟭",
      "acs": "⟬url#2⟭",
      "contactTechnique": {"nom": "⟬person_name#2⟭", "mail": "⟬email#2⟭", "tel": "⟬phone#2⟭"}
    },
    {
      "code": "orientation",
      "editeur": "⟬company#3⟭",
      "acs": "⟬url#3⟭",
      "contactTechnique": {"nom": "⟬person_name#3⟭", "mail": "⟬email#3⟭", "tel": "⟬phone#3⟭"}
    },
    {
      "code": "visio-classe",
      "editeur": "⟬company#4⟭",
      "acs": "⟬url#4⟭",
      "cleApi": "⟬google_api_key#1⟭",
      "contactTechnique": {"nom": "⟬person_name#4⟭", "mail": "⟬email:generic#5⟭"}
    }
  ],
  "etablissements": [
    {"uai": "⟬customer_id#6⟭", "nom": "Lycée ⟬trap:eponym|Marie Curie⟭", "ville": "⟬city#6⟭"},
    {"uai": "⟬customer_id#7⟭", "nom": "Collège ⟬trap:eponym|Jean Moulin⟭", "ville": "⟬city#7⟭"},
    {"uai": "⟬customer_id#8⟭", "nom": "Lycée professionnel ⟬trap:eponym|Louis Pasteur⟭", "ville": "⟬city#8⟭"}
  ],
  "journalisation": {
    "niveau": "info",
    "retentionJours": 365,
    "format": "json",
    "sortie": "⟬file_path#1⟭",
    "exclure": ["/sante", "/metriques"],
    "compression": true,
    "⟬trap:indicator_non_pii|anonymiserIdentifiant⟭": true
  },
  "assistance": {
    "guichet": "⟬email:generic#9⟭",
    "telephone": "⟬phone#9⟭",
    "horaires": "8h-17h"
  },
  "derniereRevue": "⟬date#1⟭"
}
⟬end⟭

⟬template⟭
family: config
format: .toml
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: comment, TOML value, array of tables, HTTP header, url
scenario: telegraf.toml des serveurs d'un centre de dialyse, écrit par le prestataire de supervision et diffusé par un outil de gestion de configuration
⟬text⟭
# telegraf - serveurs centre de dialyse
[agent]
interval = "30s"
hostname = "⟬hostname#1⟭"

[[inputs.cpu]]
percpu = false

[[inputs.disk]]
ignore_fs = ["tmpfs", "devtmpfs"]

[[inputs.postgresql]]
address = "postgres://supervision:⟬url_password#1⟭@localhost/generateurs?sslmode=disable"

[[outputs.influxdb_v2]]
urls = ["⟬url#1⟭"]
token = "⟬opaque_token#1⟭"
organization = "dialyse"
bucket = "serveurs"

[[outputs.http]]
url = "https://slack.com/api/chat.postMessage"
data_format = "json"

[outputs.http.headers]
Authorization = "Bearer ⟬slack_token#1⟭"
Content-Type = "application/json"
⟬end⟭

⟬template⟭
family: config
format: .toml
language: fr
fill_locale: fr_FR
domain: public administration
appearance: comment, TOML value, array, table
scenario: config.toml du runner d'intégration continue du service informatique d'un syndicat mixte, sauvegardé tel quel avec le jeton du runner
⟬text⟭
# /etc/gitlab-runner/config.toml, sauvegarde du ⟬date#1⟭
concurrent = 4
check_interval = 0

[session_server]
session_timeout = 1800

[[runners]]
name = "runner-syndicat-01"
url = "⟬url#1⟭"
token = "⟬opaque_token#1⟭"
executor = "docker"
environment = ["PGPASSWORD=⟬password#1⟭", "NEXUS_USER=⟬username#1⟭", "NEXUS_PASS=⟬password#2⟭"]

[runners.docker]
image = "alpine:3.20"
privileged = false
volumes = ["/cache"]

[runners.cache]
Type = "s3"

[runners.cache.s3]
ServerAddress = "⟬hostname#1⟭"
AccessKey = "⟬opaque_token#2⟭"
SecretKey = "⟬opaque_token#3⟭"
BucketName = "cache-ci"
⟬end⟭

⟬template⟭
family: config
format: .ini
language: fr
fill_locale: fr_FR
domain: banking
appearance: comment, ini key, section header, environment reference
scenario: tox.ini du service de calcul de provisions d'une banque régionale, écrit par l'équipe modèles avec des variables d'environnement factices
⟬text⟭
# Environnements de test du calcul de provisions
[tox]
envlist = py311, py312, lint, docs
isolated_build = true

[testenv]
deps =
    pytest
    ⟬trap:library|hypothesis⟭
    ⟬trap:library|pandas⟭
setenv =
    DB_URL = sqlite:///:memory:
    DB_PASSWORD = ⟬trap:placeholder|{env:DB_PASSWORD:xxxx}⟭
    ⟬trap:indicator_non_pii|IBAN_CHECK = false⟭
    ⟬trap:indicator_non_pii|CLIENT_ID_PREFIXE = TEST⟭
passenv = CI, HOME
commands = pytest tests -q

[testenv:lint]
deps = ruff
commands = ruff check src tests

[testenv:docs]
deps =
    ⟬trap:library|sphinx⟭
    ⟬trap:library|myst-parser⟭
commands = ⟬trap:library|sphinx⟭-build -W docs docs/_build

[pytest]
testpaths = tests
# modèle de ⟬trap:eponym|Vasicek⟭ pour le stress test, loi de ⟬trap:eponym|Weibull⟭ pour les défauts
markers =
    stress: scénarios de stress
    lent: tests de plus d'une minute
⟬end⟭

⟬template⟭
family: config
format: .ini
language: fr
fill_locale: fr_FR
domain: education
appearance: ini key, comment, url
scenario: extrait de php.ini d'un serveur d'établissement scolaire, modifié par l'assistant d'éducation chargé du site du collège
⟬text⟭
; ajouts pour le site du college
memory_limit = 256M
upload_max_filesize = 50M
sendmail_from = ⟬email:generic#1⟭
session.save_handler = redis
session.save_path = "tcp://⟬hostname#1⟭:6379?auth=⟬url_password#1⟭"
date.timezone = Europe/Paris
⟬end⟭

⟬template⟭
family: config
format: .properties
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: comment, properties key, url, section header
scenario: local.properties d'une plateforme SAP Commerce d'une enseigne d'électroménager, gonflé par trois ans de correctifs et plusieurs intégrateurs
⟬text⟭
# ---------------------------------------------------------------
# local.properties - production
# Intégrateur : ⟬company#1⟭
# Contact intégrateur : ⟬person_name#2⟭ / ⟬phone#2⟭
# Dernier correctif : ⟬date#1⟭, ⟬ticket_id#1⟭
# ---------------------------------------------------------------

# --- Plateforme ---
tomcat.generaloptions=-Xmx12G -Dfile.encoding=UTF-8
tomcat.http.port=9001
tomcat.ssl.port=9002
cluster.id=1
clustermode=true
lang.packs=fr,en
installed.tenants=

# --- Base de données ---
db.url=jdbc:mysql://⟬hostname#1⟭:3306/commerce?useSSL=true
db.driver=com.mysql.cj.jdbc.Driver
db.username=⟬username#1⟭
db.password=⟬password#1⟭
db.pool.maxActive=120

# --- Comptes d'administration ---
initialpassword.admin=⟬password#2⟭
initialpassword.cmsmanager=⟬password#3⟭
⟬trap:indicator_non_pii|hybris.security.password.minlength=14⟭
⟬trap:indicator_non_pii|user.password.encoding=pbkdf2⟭

# --- Paiement ---
paiement.stripe.secret=⟬stripe_secret_key#3⟭
paiement.stripe.publique=⟬stripe_publishable_key#3⟭
paiement.stripe.webhook=⟬opaque_token#1⟭
paiement.3ds.obligatoire=true
paiement.iban.remboursement=⟬iban#4⟭

# --- Informations légales de l'enseigne ---
enseigne.raisonsociale=⟬company#4⟭
enseigne.siret=⟬fr_siret#4⟭
enseigne.siege=⟬fr_postal_address#4⟭
enseigne.serviceclient.tel=⟬phone#4⟭
enseigne.serviceclient.mail=⟬email:generic#4⟭
enseigne.marque.exclusive=⟬trap:company_name|⦃Family⦄ Électroménager⟭

# --- Recherche ---
solrserver.instances.default.autostart=false
solrserver.instances.default.hostname=⟬hostname#2⟭
solr.server.mode=cloud
solr.admin.user=⟬trap:indicator_non_pii|solrserver⟭
solr.admin.password=⟬password#4⟭

# --- Courriel ---
mail.smtp.server=⟬hostname#3⟭
mail.smtp.port=587
mail.smtp.user=⟬email:generic#5⟭
mail.smtp.password=⟬password#5⟭
mail.from=⟬email:generic#5⟭

# --- Stock et magasins ---
stock.synchro.url=⟬url#1⟭
stock.synchro.cle=⟬opaque_token#2⟭
magasins.carte.cle=⟬google_api_key#1⟭
magasins.pilote=⟬city#6⟭,⟬city#7⟭

# --- Journaux ---
log4j2.logger.hybris.level=INFO
log4j2.logger.⟬trap:library|hibernate⟭.level=WARN
⟬trap:indicator_non_pii|log.client.nom.masque=true⟭
⟬end⟭

⟬template⟭
family: config
format: .properties
language: fr
fill_locale: fr_FR
domain: public administration
appearance: comment, properties key, url
scenario: alfresco-global.properties de la gestion électronique des documents d'un conseil régional, repris d'une documentation d'installation et complété à la main
⟬text⟭
# GED du conseil régional
# Référent applicatif : ⟬person_name#1m⟭, ⟬phone#1⟭
dir.root=/srv/alfresco/alf_data
alfresco.host=⟬hostname#1⟭
alfresco.protocol=https
share.host=⟬hostname#1⟭

db.driver=org.postgresql.Driver
db.url=jdbc:postgresql://⟬hostname#2⟭:5432/alfresco
db.username=⟬username#1⟭
db.password=⟬password#1⟭

mail.host=⟬hostname#3⟭
mail.port=587
mail.username=⟬email:generic#2⟭
mail.password=⟬password#2⟭
mail.from.default=⟬email:generic#2⟭

authentication.chain=ldap1:ldap-ad
ldap.authentication.java.naming.provider.url=ldaps://⟬hostname#4⟭:636
ldap.synchronization.java.naming.security.principal=CN=svc_ged,OU=Services,DC=region,DC=local
ldap.synchronization.java.naming.security.credentials=⟬password#3⟭
⟬trap:indicator_non_pii|ldap.synchronization.personQuery=(objectclass=user)⟭
⟬trap:indicator_non_pii|ldap.synchronization.userFirstName=givenName⟭
⟬trap:indicator_non_pii|ldap.synchronization.userEmail=mail⟭
⟬trap:indicator_non_pii|ldap.synchronization.defaultHomeFolderProvider=userHomesHomeFolderProvider⟭

registre.organisme.siret=⟬fr_siret#4⟭
registre.archives.url=https://versement:⟬url_password#1⟭@⟬hostname#5⟭/sas
index.subsystem.name=⟬trap:library|solr⟭6
⟬end⟭
