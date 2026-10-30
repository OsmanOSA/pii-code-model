⟬template⟭
family: config
format: .env
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: comment, assignment, quoted value, address
scenario: .env du service d'expédition d'une marketplace, complété par la responsable logistique avec les adresses de l'entrepôt et du centre de retours
⟬text⟭
# Expédition marketplace - entrepôt principal
# Validé par ⟬trap:initials|P.-Y.⟭ le ⟬date#1⟭
ENTREPOT_NOM="⟬company#1⟭"
ENTREPOT_ADRESSE="⟬fr_postal_address:street#1⟭"
ENTREPOT_VILLE="⟬city#1⟭"
ENTREPOT_CP=⟬postcode#1⟭
ENTREPOT_TEL="⟬phone#1⟭"
RESPONSABLE_QUAI="⟬person_name#2⟭"
RETOURS_ADRESSE="⟬fr_postal_address#3⟭"
TRANSPORTEUR_API=⟬url#1⟭
TRANSPORTEUR_CLE=⟬opaque_token#1⟭
STRIPE_CLE_REMBOURSEMENT=⟬stripe_secret_key#4⟭
SLACK_QUAI=⟬slack_token#1⟭
⟬trap:indicator_non_pii|COLIS_POIDS_MAX_KG=30⟭
⟬trap:indicator_non_pii|DESTINATAIRE_TEL_OBLIGATOIRE=true⟭
⟬end⟭

⟬template⟭
family: config
format: .env
language: fr
fill_locale: fr_FR
domain: education
appearance: comment, assignment, section header
scenario: .env.development d'une application d'apprentissage des langues pour écoliers, dont le tuteur virtuel porte un prénom, écrit par la petite équipe de développement
⟬text⟭
# Application de langues pour écoliers - développement local
# Le tuteur virtuel s'appelle ⟬trap:eponym|⦃Given⦄⟭, ne pas confondre avec un compte utilisateur.

# Serveur
PORT=3001
API_URL=http://localhost:3001/api
PUBLIC_APP_NAME="⟬trap:eponym|⦃Given⦄ et ses amis⟭"
TUTEUR_NOM=⟬trap:eponym|⦃Given⦄⟭
TUTEUR_VOIX=fr-FR-standard

# Base locale
POSTGRES_HOST=localhost
POSTGRES_USER=⟬trap:indicator_non_pii|langues⟭
POSTGRES_PASSWORD=⟬trap:placeholder|changeme⟭

# Modèle de langue
MODELE_API_URL=http://localhost:11434
MODELE_API_KEY=⟬trap:placeholder|***⟭
MODELE_NOM=⟬trap:library|mistral⟭

# Règles pour les mineurs
⟬trap:indicator_non_pii|AGE_MINIMUM=6⟭
⟬trap:indicator_non_pii|PARENT_EMAIL_OBLIGATOIRE=true⟭
⟬trap:indicator_non_pii|NOM_ELEVE_AFFICHAGE=pseudo⟭
⟬trap:indicator_non_pii|PHOTO_PROFIL_AUTORISEE=false⟭
# répétition espacée selon la courbe d'oubli d'⟬trap:eponym|Ebbinghaus⟭
REVISION_ALGORITHME=⟬trap:eponym|ebbinghaus⟭
⟬end⟭

⟬template⟭
family: config
format: .env
language: fr
fill_locale: fr_FR
domain: energy
appearance: assignment, no announcing word
scenario: fichier d'environnement du connecteur d'itinérance entre deux opérateurs de recharge électrique, écrit pendant un test d'interopérabilité
⟬text⟭
# test itinérance
OCPI_URL=⟬url#1⟭
OCPI_T=⟬opaque_token#1⟭
OCPI_T2=⟬opaque_token#2⟭
PARTENAIRE="⟬company#2⟭"
PARTENAIRE_SIRET="⟬fr_siret#2⟭"
⟬end⟭

⟬template⟭
family: config
format: docker-compose.yml
language: fr
fill_locale: fr_FR
domain: education
appearance: comment, YAML value, url, YAML block, label
scenario: compose de l'outil de statistiques d'orientation d'un rectorat, monté par une ingénieure statistique pour ses tableaux de bord
⟬text⟭
# Statistiques d'orientation - tableaux de bord du rectorat
# Ingénieure statistique : ⟬person_name#1f⟭ - ⟬email#1⟭
services:
  superset:
    image: apache/superset:4.0.2
    restart: unless-stopped
    environment:
      SUPERSET_SECRET_KEY: ⟬opaque_token#1⟭
      DATABASE_URL: postgresql+psycopg2://superset:⟬url_password#1⟭@metadonnees:5432/superset
      ⟬trap:indicator_non_pii|ADMIN_USERNAME: admin⟭
      ADMIN_PASSWORD: ⟬password#1⟭
      CARTE_CLE: ⟬google_api_key#1⟭
      GUEST_TOKEN_JWT_SECRET: ⟬opaque_token#2⟭
      ⟬trap:indicator_non_pii|GUEST_TOKEN_JWT_EXP_SECONDS: 300⟭
    labels:
      rectorat.direction: "DEPP"
      rectorat.referente: "⟬person_name#1f⟭"
    ports:
      - "8088:8088"
    depends_on:
      - metadonnees

  metadonnees:
    image: postgres:16
    environment:
      POSTGRES_DB: superset
      POSTGRES_USER: superset
      POSTGRES_PASSWORD: ⟬url_password#1⟭

  sftp-etablissements:
    image: atmoz/sftp:alpine
    environment:
      CLE_HOTE: |
        ⟬private_key#1⟭
    ports:
      - "2022:22"
⟬end⟭

⟬template⟭
family: config
format: docker-compose.yml
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: comment, YAML value, environment list
scenario: docker-compose de tests d'intégration d'un service de fidélité, où tous les services externes sont simulés et les identifiants viennent de l'environnement du runner
⟬text⟭
# Tests d'intégration - programme de fidélité
# Lancement : docker compose -f docker-compose.yml up --abort-on-container-exit
services:
  tests:
    build:
      context: .
      target: tests
    environment:
      DATABASE_URL: postgres://fidelite:⟬trap:placeholder|${TEST_DB_PASSWORD}⟭@base:5432/fidelite_test
      SMTP_HOST: courriel
      SMTP_PORT: 1025
      SMTP_USER: ⟬trap:indicator_non_pii|test⟭
      SMTP_PASSWORD: ⟬trap:placeholder|xxxx⟭
      AWS_ENDPOINT_URL: http://stockage:4566
      AWS_ACCESS_KEY_ID: ⟬trap:placeholder|xxxx⟭
      AWS_SECRET_ACCESS_KEY: "⟬trap:placeholder|***⟭"
      ⟬trap:indicator_non_pii|POINTS_TOKEN_TTL: 60⟭
      ⟬trap:indicator_non_pii|CLIENT_EMAIL_DOMAINE: example⟭
    depends_on:
      base:
        condition: service_healthy
      courriel:
        condition: service_started
      stockage:
        condition: service_started

  base:
    image: postgres:16-alpine
    environment:
      POSTGRES_USER: fidelite
      POSTGRES_PASSWORD: ⟬trap:placeholder|${TEST_DB_PASSWORD}⟭
      POSTGRES_DB: fidelite_test
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U fidelite"]
      interval: 2s
      retries: 20

  courriel:
    image: axllent/⟬trap:library|mailpit⟭:v1.19

  stockage:
    image: localstack/⟬trap:library|localstack⟭:3.5
    environment:
      - SERVICES=s3,sqs
      - DEBUG=0
⟬end⟭

⟬template⟭
family: config
format: docker-compose.yml
language: fr
fill_locale: fr_FR
domain: energy
appearance: comment, YAML anchor, YAML value, url
scenario: compose d'Airflow pour les prévisions de production solaire d'un petit développeur, adapté de l'exemple officiel par un data scientist
⟬text⟭
# Airflow - prévisions de production solaire
# Adapté de l'exemple officiel. Contact : ⟬person_name#1⟭ - ⟬phone#1⟭
# Parc de référence : ⟬city#2⟭ (⟬postcode#2⟭)

x-commun-airflow: &commun-airflow
  image: ⟬hostname#1⟭/data/airflow:⟬version#1⟭
  environment: &env-airflow
    AIRFLOW__CORE__EXECUTOR: CeleryExecutor
    AIRFLOW__CORE__FERNET_KEY: ⟬opaque_token#1⟭
    AIRFLOW__CORE__LOAD_EXAMPLES: "false"
    AIRFLOW__DATABASE__SQL_ALCHEMY_CONN: postgresql+psycopg2://airflow:⟬url_password#1⟭@postgres/airflow
    AIRFLOW__CELERY__RESULT_BACKEND: db+postgresql://airflow:⟬url_password#1⟭@postgres/airflow
    AIRFLOW__CELERY__BROKER_URL: redis://:⟬url_password#2⟭@redis:6379/0
    AIRFLOW__WEBSERVER__SECRET_KEY: ⟬opaque_token#2⟭
    AIRFLOW_CONN_METEO_API: http://meteo:⟬url_password#3⟭@⟬hostname#2⟭
    AIRFLOW_CONN_SLACK_ALERTES: slack://:⟬slack_token#1⟭@
    AIRFLOW_VAR_CLE_CARTE: ⟬google_api_key#1⟭
    ⟬trap:indicator_non_pii|AIRFLOW__WEBSERVER__SESSION_LIFETIME_MINUTES: 480⟭
  volumes:
    - ./dags:/opt/airflow/dags
    - ./logs:/opt/airflow/logs
  depends_on:
    - redis
    - postgres

services:
  postgres:
    image: postgres:16
    environment:
      POSTGRES_USER: airflow
      POSTGRES_PASSWORD: ⟬url_password#1⟭
      POSTGRES_DB: airflow
    volumes:
      - postgres:/var/lib/postgresql/data

  redis:
    image: redis:7.2
    command: redis-server --requirepass ⟬url_password#2⟭

  webserver:
    <<: *commun-airflow
    command: webserver
    ports:
      - "8080:8080"

  scheduler:
    <<: *commun-airflow
    command: scheduler

  worker:
    <<: *commun-airflow
    command: ⟬trap:library|celery⟭ worker

  init:
    <<: *commun-airflow
    command: version
    environment:
      <<: *env-airflow
      _AIRFLOW_DB_MIGRATE: "true"
      _AIRFLOW_WWW_USER_CREATE: "true"
      _AIRFLOW_WWW_USER_USERNAME: ⟬trap:indicator_non_pii|airflow⟭
      _AIRFLOW_WWW_USER_PASSWORD: ⟬password#1⟭

volumes:
  postgres:
⟬end⟭

⟬template⟭
family: config
format: Kubernetes .yaml
language: fr
fill_locale: fr_FR
domain: public administration
appearance: comment, annotation, stringData, YAML block, env value, list
scenario: CronJob et Secret de l'échange de fichiers entre un syndicat des eaux et les finances publiques, documentés par le comptable et l'informaticien
⟬text⟭
# Envoi des titres de recettes vers les finances publiques
# Comptable : ⟬person_name#1⟭ - informaticien : ⟬person_name#2m⟭
# À ne pas lancer les jours de clôture
apiVersion: v1
kind: Secret
metadata:
  name: echange-finances
  namespace: syndicat-eaux
  annotations:
    ordonnateur: "⟬person_name#3m⟭"
type: Opaque
stringData:
  cle-sftp: |
    ⟬private_key#1⟭
  phrase: ⟬password#1⟭
  compte-tresor: ⟬iban#4⟭
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: echange-finances
  namespace: syndicat-eaux
data:
  COLLECTIVITE: Syndicat des eaux de ⟬city#4⟭
  COLLECTIVITE_SIRET: "⟬fr_siret#4⟭"
  COLLECTIVITE_ADRESSE: ⟬fr_postal_address#4⟭
  BUDGET: "47100"
  EXERCICE: "2026"
  HOTE_SFTP: ⟬hostname#1⟭
  ⟬trap:indicator_non_pii|UTILISATEUR_SFTP: depot⟭
  ⟬trap:indicator_non_pii|MAIL_ACCUSE: comptabilite⟭
---
apiVersion: batch/v1
kind: CronJob
metadata:
  name: envoi-titres
  namespace: syndicat-eaux
  labels:
    ⟬trap:indicator_non_pii|owner: service-finances⟭
spec:
  schedule: "0 19 * * 1-5"
  jobTemplate:
    spec:
      template:
        spec:
          restartPolicy: OnFailure
          containers:
            - name: envoi
              image: ⟬hostname#2⟭/syndicat/envoi-titres:⟬version#1⟭
              envFrom:
                - configMapRef:
                    name: echange-finances
              env:
                - name: CLE_FICHIER
                  value: /cles/cle-sftp
                - name: PHRASE_SECRETE
                  valueFrom:
                    secretKeyRef:
                      name: echange-finances
                      key: phrase
              volumeMounts:
                - name: cles
                  mountPath: /cles
                  readOnly: true
          volumes:
            - name: cles
              secret:
                secretName: echange-finances
⟬end⟭

⟬template⟭
family: config
format: Kubernetes .yaml
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: comment, ConfigMap, YAML block, HTTP header
scenario: ConfigMap nginx d'une enseigne de bricolage qui relaie vers l'API d'un fournisseur en y ajoutant un en-tête d'authentification écrit dans la configuration
⟬text⟭
# Relais vers l'API du fournisseur ⟬trap:company_name|⦃Family⦄ Outillage⟭
apiVersion: v1
kind: ConfigMap
metadata:
  name: relais-fournisseur
  namespace: bricolage
  annotations:
    contact-fournisseur: "⟬person_name#1⟭ ⟬phone#1⟭"
data:
  relais.conf: |
    upstream fournisseur {
        server ⟬hostname#1⟭:443;
        keepalive 16;
    }

    server {
        listen 8080;
        access_log off;

        location /stocks/ {
            proxy_pass https://fournisseur/v2/stocks/;
            proxy_set_header Authorization "Bearer ⟬opaque_token#1⟭";
            proxy_set_header X-Enseigne-Siret "⟬fr_siret#2⟭";
            proxy_ssl_server_name on;
        }

        location /sante {
            return 200 "ok";
        }
    }
⟬end⟭

⟬template⟭
family: config
format: Kubernetes .yaml
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: comment, custom resource, label
scenario: planification des sauvegardes des volumes d'images médicales d'un centre de lutte contre le cancer, décidée avec l'équipe sécurité
⟬text⟭
# Sauvegarde des volumes d'images médicales, conservation 10 ans sur site secondaire
apiVersion: velero.io/v1
kind: Schedule
metadata:
  name: images-quotidienne
  namespace: velero
  labels:
    ⟬trap:indicator_non_pii|owner: equipe-stockage⟭
spec:
  schedule: "30 1 * * *"
  template:
    includedNamespaces:
      - imagerie
    labelSelector:
      matchLabels:
        sauvegarde: oui
    snapshotVolumes: true
    ttl: 87600h0m0s
    storageLocation: site-secondaire
---
apiVersion: velero.io/v1
kind: BackupStorageLocation
metadata:
  name: site-secondaire
  namespace: velero
spec:
  provider: aws
  objectStorage:
    bucket: sauvegardes-imagerie
  config:
    region: eu-west-3
    s3Url: ⟬url#1⟭
    s3ForcePathStyle: "true"
  credential:
    name: stockage-secondaire
    key: ⟬trap:indicator_non_pii|credentials⟭
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: archives-images
  namespace: imagerie
  labels:
    sauvegarde: oui
    cluster: ⟬trap:code_identifier|⦃given⦄⟭
spec:
  accessModes: ["ReadWriteMany"]
  storageClassName: ⟬trap:word_name|Ambre⟭-rapide
  resources:
    requests:
      storage: 40Ti
⟬end⟭

⟬template⟭
family: config
format: GitHub Actions .yml
language: fr
fill_locale: fr_FR
domain: education
appearance: comment, test fixture, environment variable, curl command, YAML block
scenario: import nocturne des notes vers l'application parents d'un lycée privé, avec un élève de test figé par le développeur pour vérifier la chaîne
⟬text⟭
name: import-notes

on:
  schedule:
    - cron: "0 2 * * 2-6"

jobs:
  import:
    runs-on: ubuntu-latest
    env:
      BASE_NOTES: postgresql://notes:⟬url_password#1⟭@⟬hostname#1⟭/notes
      # élève de test : ne doit jamais recevoir de notification
      ELEVE_TEST: ⟬person_name#2⟭
      ELEVE_TEST_DATE_NAISSANCE: ⟬birth_date#2⟭
      ELEVE_TEST_RESPONSABLE: ⟬person_name#3⟭
      ELEVE_TEST_RESPONSABLE_TEL: "⟬phone#3⟭"
      INSCRIPTION: ⟬date#1⟭
    steps:
      - uses: ⟬trap:email_lookalike|actions/checkout@v4⟭
      - run: python import_notes.py --trimestre courant
      - name: Traduction des appréciations
        run: |
          curl -s "https://translation.googleapis.com/language/translate/v2?key=⟬google_api_key#1⟭" \
            -d "q=Bon trimestre" -d "target=en"
⟬end⟭

⟬template⟭
family: config
format: GitHub Actions .yml
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: command line, comment
scenario: connexion au cloud pour déployer l'intranet d'une clinique, écrite par une stagiaire avec le compte personnel de son tuteur
⟬text⟭
name: intranet-clinique
on:
  push:
    branches: [main]
jobs:
  deployer:
    runs-on: ubuntu-latest
    steps:
      - uses: ⟬trap:email_lookalike|actions/checkout@v4⟭
      # compte de ⟬person_name#1⟭ en attendant le principal de service
      - run: az login -u ⟬email#1⟭ -p ⟬password#1⟭
      - run: az webapp up --name intranet-clinique
⟬end⟭

⟬template⟭
family: config
format: GitHub Actions .yml
language: fr
fill_locale: fr_FR
domain: banking
appearance: comment, secret reference, YAML value
scenario: analyse de sécurité des dépôts d'une banque d'investissement, imposée par l'équipe cybersécurité à toutes les équipes de développement
⟬text⟭
# Analyse de sécurité obligatoire sur tous les dépôts
name: analyse-securite

on:
  pull_request:
  schedule:
    - cron: "0 6 * * *"

permissions:
  contents: read
  security-events: write

jobs:
  secrets:
    runs-on: ubuntu-latest
    steps:
      - uses: ⟬trap:email_lookalike|actions/checkout@v4⟭
        with:
          fetch-depth: 0
      - uses: ⟬trap:email_lookalike|gitleaks/gitleaks-action@v2⟭
        env:
          GITLEAKS_LICENSE: ⟬trap:placeholder|${{ secrets.GITLEAKS_LICENSE }}⟭
          GITHUB_TOKEN: ⟬trap:placeholder|${{ secrets.GITHUB_TOKEN }}⟭

  dependances:
    runs-on: ubuntu-latest
    steps:
      - uses: ⟬trap:email_lookalike|actions/checkout@v4⟭
      - uses: ⟬trap:email_lookalike|aquasecurity/trivy-action@0.24.0⟭
        with:
          scan-type: fs
          severity: HIGH,CRITICAL
          format: sarif
          output: trivy.sarif
      - uses: ⟬trap:email_lookalike|github/codeql-action/upload-sarif@v3⟭
        with:
          sarif_file: trivy.sarif

  code:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        langage: [java, python]
    steps:
      - uses: ⟬trap:email_lookalike|actions/checkout@v4⟭
      - uses: ⟬trap:email_lookalike|github/codeql-action/init@v3⟭
        with:
          languages: ${{ matrix.langage }}
      - uses: ⟬trap:email_lookalike|github/codeql-action/analyze@v3⟭
      - name: Alerte
        if: failure()
        run: ./ci/alerte.sh ⟬trap:indicator_non_pii|equipe-cybersecurite⟭

  rapport:
    needs: [secrets, dependances, code]
    runs-on: ubuntu-latest
    if: always()
    steps:
      - uses: ⟬trap:email_lookalike|actions/checkout@v4⟭
      - run: ./ci/rapport.sh --sortie rapport.md
      - uses: ⟬trap:email_lookalike|actions/upload-artifact@v4⟭
        with:
          name: rapport-securite
          path: rapport.md
⟬end⟭

⟬template⟭
family: config
format: .json
language: fr
fill_locale: fr_FR
domain: energy
appearance: nested JSON, array, url, string value
scenario: ecosystem.config.json de l'API de gestion des bornes d'un syndic de copropriété, lancé par PM2 sur un serveur unique
⟬text⟭
{
  "apps": [
    {
      "name": "api-bornes",
      "script": "dist/main.js",
      "instances": 2,
      "exec_mode": "cluster",
      "env_production": {
        "NODE_ENV": "production",
        "PORT": 4100,
        "DATABASE_URL": "mysql://bornes:⟬url_password#1⟭@⟬hostname#1⟭:3306/bornes",
        "STRIPE_SECRET_KEY": "⟬stripe_secret_key#2⟭",
        "OPERATEUR_RECHARGE_TOKEN": "⟬opaque_token#1⟭",
        "SYNDIC_NOM": "⟬company#3⟭",
        "SYNDIC_SIRET": "⟬fr_siret#3⟭",
        "SYNDIC_ADRESSE": "⟬fr_postal_address#3⟭",
        "SYNDIC_TEL": "⟬phone#3⟭",
        "GESTIONNAIRE": "⟬person_name#4⟭"
      }
    },
    {
      "name": "relance-impayes",
      "script": "dist/relance.js",
      "cron_restart": "0 8 * * 1",
      "autorestart": false
    }
  ]
}
⟬end⟭

⟬template⟭
family: config
format: .json
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: nested JSON, string value, array, generated config
scenario: settings_data.json du thème d'une boutique de thé et de porcelaine, modifié dans l'éditeur par la commerçante puis récupéré par son webmaster
⟬text⟭
{
  "current": {
    "logo_width": 180,
    "couleur_principale": "⟬trap:word_name|Rose⟭ thé",
    "couleur_secondaire": "⟬trap:word_name|Jade⟭",
    "police_titres": "⟬trap:library|Garamond⟭",
    "police_texte": "⟬trap:library|Helvetica⟭",
    "afficher_panier_lateral": true,
    "boutique_physique": {
      "nom": "⟬company#1⟭",
      "adresse": "⟬fr_postal_address#1⟭",
      "telephone": "⟬phone#1⟭",
      "courriel": "⟬email:generic#1⟭",
      "horaires": "mardi au samedi, 10h-19h",
      "carte_google_cle": "⟬google_api_key#1⟭"
    },
    "pied_de_page": {
      "mentions": "Siret ⟬fr_siret#1⟭ - RCS ⟬city#1⟭",
      "createur": "Site réalisé par ⟬person_name#2⟭"
    },
    "newsletter": {
      "fournisseur": "maison",
      "liste": "⟬uuid#1⟭",
      "cle_api": "⟬opaque_token#1⟭"
    },
    "sections": {
      "bandeau": {
        "type": "image-banner",
        "settings": {
          "titre": "Nouvelle collection ⟬trap:word_name|Pierre⟭ de ⟬trap:word_name|Limoges⟭",
          "lien": "⟬url#1⟭"
        }
      },
      "temoignages": {
        "type": "temoignages",
        "settings": {
          "auteur_1": "⟬person_name:initial#3⟭",
          "citation_1": "Livraison rapide et thés excellents.",
          "auteur_2": "⟬person_name:given#4⟭, ⟬city#4⟭",
          "citation_2": "Une très belle boutique."
        }
      }
    }
  },
  "presets": {
    "Noël": {
      "couleur_principale": "⟬trap:word_name|Garance⟭",
      "bandeau_texte": "Commandez avant le 15 décembre"
    }
  }
}
⟬end⟭

⟬template⟭
family: config
format: .toml
language: fr
fill_locale: fr_FR
domain: education
appearance: comment, TOML value, table
scenario: rustic.toml de la sauvegarde des données d'un laboratoire de sciences humaines, écrit par l'ingénieur d'études qui gère les enquêtes
⟬text⟭
# Sauvegarde des enquêtes du laboratoire
# Ingénieur d'études : ⟬person_name#1m⟭

[repository]
repository = "opendal:s3"
password = "⟬password#1⟭"

[repository.options]
root = "/enquetes"
bucket = "sauvegardes-labo"
endpoint = "⟬url#1⟭"
region = "fr-par"
access_key_id = "⟬opaque_token#1⟭"
secret_access_key = "⟬opaque_token#2⟭"

[forget]
keep-daily = 14
keep-monthly = 24

[[backup.snapshots]]
sources = ["/srv/enquetes", "/srv/entretiens"]
label = "⟬trap:eponym|Bourdieu⟭-2026"
⟬end⟭

⟬template⟭
family: config
format: .toml
language: fr
fill_locale: fr_FR
domain: public administration
appearance: comment, TOML value, environment reference
scenario: uv.toml partagé d'une direction du numérique pour que les agents installent les paquets depuis le miroir interne, sans identifiant dans le fichier
⟬text⟭
# Configuration uv des postes de la direction du numérique
# L'identification au miroir se fait par les variables UV_INDEX_MIROIR_USERNAME et UV_INDEX_MIROIR_PASSWORD.
python-preference = "managed"
native-tls = true

[pip]
strict = true
⟬trap:indicator_non_pii|keyring-provider = "disabled"⟭

[[index]]
name = "miroir"
url = "⟬url#1⟭"
default = true

[[index]]
name = "paquets-maison"
url = "https://⟬trap:indicator_non_pii|lecture⟭:⟬trap:placeholder|${UV_INDEX_TOKEN}⟭@⟬hostname#1⟭/simple"
explicit = true

[sources]
⟬trap:code_identifier|⦃family⦄-outils⟭ = { index = "paquets-maison" }
⟬end⟭

⟬template⟭
family: config
format: .ini
language: fr
fill_locale: fr_FR
domain: energy
appearance: comment, ini key, section header
scenario: configuration WireGuard de la passerelle d'un site de méthanisation, installée par le technicien du constructeur pour la télémaintenance
⟬text⟭
# VPN de télémaintenance - site de méthanisation de ⟬city#1⟭
# Installé par ⟬person_name#2⟭, ⟬phone#2⟭, à joindre avant toute modification
[Interface]
Address = 10.8.0.1/24
ListenPort = 51820
PrivateKey = ⟬opaque_token#1⟭

[Peer]
# constructeur
PublicKey = ⟬hash#1⟭
PresharedKey = ⟬opaque_token#2⟭
Endpoint = ⟬hostname#1⟭:51820
AllowedIPs = 10.8.0.2/32
PersistentKeepalive = 25
⟬end⟭

⟬template⟭
family: config
format: .ini
language: fr
fill_locale: fr_FR
domain: public administration
appearance: comment, ini key, section header
scenario: sssd.conf des serveurs d'une communauté de communes, avec le compte de lecture de l'annuaire renseigné par le prestataire réseau
⟬text⟭
# Authentification des serveurs sur l'annuaire de la communauté de communes
# Prestataire réseau : ⟬company#1⟭, contact ⟬person_name#2⟭
[sssd]
services = nss, pam, sudo
domains = cc.local
config_file_version = 2

[domain/cc.local]
id_provider = ldap
auth_provider = ldap
ldap_uri = ldaps://⟬hostname#1⟭
ldap_search_base = dc=cc,dc=local
ldap_default_bind_dn = cn=sssd,ou=services,dc=cc,dc=local
ldap_default_authtok_type = password
ldap_default_authtok = ⟬password#1⟭
⟬trap:indicator_non_pii|ldap_user_name = sAMAccountName⟭
⟬trap:indicator_non_pii|ldap_user_gecos = displayName⟭
cache_credentials = true
access_provider = simple
simple_allow_groups = admins-serveurs
⟬end⟭

⟬template⟭
family: config
format: .properties
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: comment, properties key, url
scenario: keycloak.conf de l'authentification du personnel d'un groupement de coopération sanitaire, déployé par l'équipe identité et commenté pour la reprise
⟬text⟭
# Authentification du personnel du groupement
# Référente identité : ⟬person_name#1f⟭ - ⟬email#1⟭
# Reprise possible par ⟬company#2⟭, contrat ⟬order_number#1⟭

db=postgres
db-url=jdbc:postgresql://⟬hostname#1⟭:5432/keycloak
db-username=⟬username#1⟭
db-password=⟬password#1⟭

hostname=⟬hostname#2⟭
https-key-store-file=/etc/keycloak/serveur.p12
https-key-store-password=⟬password#2⟭
http-enabled=false
proxy-headers=xforwarded
metrics-enabled=true
health-enabled=true
log=console,file
log-level=INFO

# Fournisseur de messages pour le code à usage unique
spi-sms-fournisseur-url=⟬url#1⟭
spi-sms-fournisseur-cle=⟬opaque_token#1⟭
⟬trap:indicator_non_pii|spi-sms-code-longueur=6⟭
⟬trap:indicator_non_pii|spi-sms-code-duree-secondes=300⟭
spi-sms-numero-test=⟬phone#3⟭

# Annuaire de santé, compte technique
spi-annuaire-url=https://lecture:⟬url_password#1⟭@⟬hostname#3⟭/fhir
⟬trap:indicator_non_pii|spi-annuaire-attribut-rpps=identifiant⟭
⟬trap:indicator_non_pii|spi-annuaire-attribut-nom=nomExercice⟭
⟬end⟭

⟬template⟭
family: config
format: .properties
language: fr
fill_locale: fr_FR
domain: banking
appearance: comment, properties key, url
scenario: sonar.properties du serveur d'analyse de code d'une banque de financement, tenu par l'équipe outillage et passé en revue pour un audit interne
⟬text⟭
# Serveur d'analyse de code - équipe outillage
# Audit interne du ⟬date#1⟭ : retirer les comptes locaux, passer sur le SSO
# Responsable outillage : ⟬person_name#1⟭

# --- Base de données ---
sonar.jdbc.username=⟬username#1⟭
sonar.jdbc.password=⟬password#1⟭
sonar.jdbc.url=jdbc:postgresql://⟬hostname#1⟭:5432/sonarqube
sonar.jdbc.maxActive=60

# --- Web ---
sonar.web.host=0.0.0.0
sonar.web.port=9000
sonar.web.context=/
sonar.core.serverBaseURL=https://⟬hostname#2⟭
sonar.web.javaOpts=-Xmx2G -Xms512m
⟬trap:indicator_non_pii|sonar.web.sessionTimeoutInMinutes=120⟭
⟬trap:indicator_non_pii|sonar.forceAuthentication=true⟭

# --- Recherche ---
sonar.search.javaOpts=-Xmx4G -Xms4G
sonar.search.port=9001
sonar.path.data=/var/sonarqube/data
sonar.path.temp=/var/sonarqube/temp
sonar.path.logs=/var/log/sonarqube

# --- SSO ---
sonar.auth.saml.enabled=true
sonar.auth.saml.applicationId=sonarqube
sonar.auth.saml.providerId=⟬url#1⟭
sonar.auth.saml.loginUrl=⟬url#2⟭
⟬trap:indicator_non_pii|sonar.auth.saml.user.login=uid⟭
⟬trap:indicator_non_pii|sonar.auth.saml.user.name=cn⟭
⟬trap:indicator_non_pii|sonar.auth.saml.user.email=mail⟭

# --- LDAP (ancien) ---
#ldap.url=ldaps://⟬hostname#3⟭:636
#ldap.bindDn=cn=sonar,ou=services,dc=banque,dc=local
#ldap.bindPassword=⟬password#2⟭

# --- Courriels ---
email.smtp_host.secured=⟬hostname#4⟭
email.smtp_port.secured=587
email.smtp_username.secured=⟬email:generic#2⟭
email.smtp_password.secured=⟬password#3⟭
email.from=⟬email:generic#2⟭

# --- Rétention et traitements ---
sonar.dbcleaner.weeksBeforeDeletingAllSnapshots=260
sonar.dbcleaner.daysBeforeDeletingClosedIssues=30
sonar.ce.workerCount=4
sonar.ce.javaOpts=-Xmx2G -Xms128m
sonar.log.level=INFO
sonar.log.rollingPolicy=time:yyyy-MM-dd
sonar.log.maxFiles=14
sonar.updatecenter.activate=false

# --- Intégrations ---
sonar.slack.jeton=⟬slack_token#1⟭
sonar.slack.canal=qualite-code
sonar.telemetry.enable=false
⟬end⟭
