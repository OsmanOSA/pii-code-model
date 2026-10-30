⟬template⟭
family: config
format: .env
language: fr
fill_locale: fr_FR
domain: education
appearance: comment, quoted value, assignment, test user
scenario: .env de l'application de paiement de la cantine scolaire d'une commune, écrit par le développeur indépendant qui l'a livrée à la caisse des écoles
⟬text⟭
# Cantine scolaire - paiement en ligne des repas
# Caisse des écoles, gestionnaire : ⟬person_name#1f⟭ - ⟬phone#1⟭
# Attention : compte de paiement de l'établissement public, pas un compte de test !
APP_NOM="Cantine de ⟬city#2⟭"
STRIPE_KEY=⟬stripe_secret_key#2⟭
STRIPE_PK=⟬stripe_publishable_key#2⟭
CAISSE_SIRET="⟬fr_siret#2⟭"
CAISSE_IBAN="⟬iban#2⟭"
CAISSE_BIC=⟬bic#2⟭
⟬trap:indicator_non_pii|PARENT_LOGIN_TTL=86400⟭
# compte de démo utilisé pour la présentation aux élus
DEMO_PARENT="⟬person_name#3⟭"
DEMO_ELEVE="⟬person_name:given#4⟭"
DEMO_ELEVE_DDN="⟬birth_date#4⟭"
DEMO_INSCRIPTION="⟬date#1⟭"
⟬end⟭

⟬template⟭
family: config
format: .env
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: comment, assignment, url
scenario: .env.test chargé par les tests de bout en bout d'une boutique headless, écrit par la QA pour que personne n'ait besoin d'un vrai compte
⟬text⟭
# .env.test - chargé par vitest et playwright, jamais en prod
# Aucun service externe : tout pointe vers les bouchons locaux.
NODE_ENV=test
NEXT_PUBLIC_API_URL=http://localhost:4010
NEXT_PUBLIC_STRIPE_KEY=⟬stripe_publishable_key#1⟭
STRIPE_SECRET_KEY=⟬trap:placeholder|sk_test_REPLACE_ME⟭
DATABASE_URL=postgres://test:⟬trap:placeholder|${TEST_DB_PASSWORD}⟭@localhost:54329/boutique_test
⟬trap:indicator_non_pii|TEST_USER=admin⟭
TEST_USER_PASSWORD=⟬trap:placeholder|<voir le bouchon d'authentification>⟭
⟬trap:indicator_non_pii|PASSWORD_MIN_LENGTH=4⟭
⟬trap:indicator_non_pii|OTP_CODE_LENGTH=6⟭
COMMANDE_EXEMPLE=⟬order_number#1⟭
CLIENT_EXEMPLE=⟬customer_id#1⟭
VILLE_DEFAUT="⟬city#1⟭"
CP_DEFAUT=⟬postcode#1⟭
⟬end⟭

⟬template⟭
family: config
format: docker-compose.yml
language: fr
fill_locale: fr_FR
domain: energy
appearance: comment, label, YAML value, url
scenario: compose de supervision des bornes de recharge d'une agglomération, tenu par le technicien de l'exploitant qui gère aussi les astreintes
⟬text⟭
# Supervision des bornes de recharge - agglomération
# Astreinte réseau de bornes : ⟬phone#1⟭ (⟬person_name#1⟭)
services:
  mosquitto:
    image: eclipse-mosquitto:2
    volumes:
      - ./mosquitto:/mosquitto/config
    ports:
      - "8883:8883"

  collecteur:
    build: ./collecteur
    environment:
      MQTT_URL: mqtts://bornes:⟬url_password#1⟭@mosquitto:8883
      GOOGLE_MAPS_KEY: ⟬google_api_key#1⟭
      SLACK_TOKEN: ⟬slack_token#1⟭
      EXPLOITANT: ⟬trap:company_name|⦃Family⦄ Énergies⟭
      ZONE: ⟬city#2⟭
      ⟬trap:indicator_non_pii|TOKEN_RENEW_SECONDS: 3000⟭
    labels:
      exploitation.contact: "⟬person_name#1⟭"
      exploitation.tel: "⟬phone#1⟭"
    depends_on:
      - mosquitto

  ⟬trap:library|grafana⟭:
    image: grafana/grafana:11.1.0
    environment:
      GF_SECURITY_ADMIN_USER: ⟬trap:indicator_non_pii|admin⟭
      GF_SECURITY_ADMIN_PASSWORD: ⟬password#1⟭
      GF_USERS_ALLOW_SIGN_UP: "false"
    ports:
      - "3000:3000"
    volumes:
      - tableaux:/var/lib/grafana

  traces:
    image: jaegertracing/⟬trap:library|jaeger⟭:2.0
    ports:
      - "16686:16686"

volumes:
  tableaux:
⟬end⟭

⟬template⟭
family: config
format: docker-compose.yml
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: comment, YAML value, url
scenario: compose de développement d'un service de click and collect pour pharmacies, partagé entre deux développeurs avec une clé de paiement de test
⟬text⟭
# dev local click & collect, voir ⟬person_name#1⟭ si ça ne démarre pas
services:
  app:
    build: .
    ports: ["3000:3000"]
    environment:
      DATABASE_URL: postgres://pharma:⟬url_password#1⟭@db/pharma
      STRIPE_SECRET_KEY: ⟬stripe_secret_key#1⟭
  db:
    image: postgres:16
    environment:
      POSTGRES_USER: pharma
      POSTGRES_PASSWORD: ⟬url_password#1⟭
⟬end⟭

⟬template⟭
family: config
format: Kubernetes .yaml
language: fr
fill_locale: fr_FR
domain: public administration
appearance: comment, annotation, stringData, YAML block, Ingress rule
scenario: Secret TLS et Ingress du site d'un conseil départemental, posés à la main par le chef de projet parce que le cluster n'a pas de gestionnaire de certificats
⟬text⟭
# Site du conseil départemental - exposition publique
# Chef de projet : ⟬person_name#1⟭, ⟬phone#1⟭ ; prestataire : ⟬company#2⟭
# Clé TLS posée à la main le ⟬date#1⟭ (pas de gestionnaire de certificats sur ce cluster)
apiVersion: v1
kind: Secret
metadata:
  name: site-tls
  namespace: site-departement
  annotations:
    renouvellement: "⟬date#1⟭"
    responsable: "⟬email#1⟭"
type: Opaque
stringData:
  tls.key: |
    ⟬private_key#1⟭
  tls.pass: "⟬password#1⟭"
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: site-departement
  namespace: site-departement
  labels:
    ⟬trap:indicator_non_pii|contact: support⟭
  annotations:
    nginx.ingress.kubernetes.io/ssl-redirect: "true"
    nginx.ingress.kubernetes.io/whitelist-source-range: 10.20.30.0/24
spec:
  tls:
    - hosts:
        - ⟬hostname#1⟭
      secretName: site-tls
  rules:
    - host: ⟬hostname#1⟭
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: ⟬trap:code_identifier|⦃family⦄-portail⟭
                port:
                  number: 8080
⟬end⟭

⟬template⟭
family: config
format: Kubernetes .yaml
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: label, annotation, comment, env value
scenario: autoscaling et budget de perturbation du microservice catalogue, ajustés par l'équipe plateforme avant les soldes d'hiver
⟬text⟭
# Catalogue : montée en charge pour les soldes, validée le ⟬date#1⟭ (⟬ticket_id#1⟭)
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: catalogue
  namespace: boutique
  annotations:
    ⟬trap:indicator_non_pii|author: renovate[bot]⟭
    ⟬trap:indicator_non_pii|owner: equipe-catalogue⟭
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: catalogue
  minReplicas: 6
  maxReplicas: 40
  metrics:
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: 65
---
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: catalogue
  namespace: boutique
spec:
  minAvailable: 70%
  selector:
    matchLabels:
      app: catalogue
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: catalogue
  namespace: boutique
  labels:
    app: catalogue
    cluster: ⟬trap:code_identifier|⦃given⦄-prod-01⟭
    ⟬trap:indicator_non_pii|contact: equipe-catalogue⟭
spec:
  selector:
    matchLabels:
      app: catalogue
  template:
    metadata:
      labels:
        app: catalogue
    spec:
      containers:
        - name: catalogue
          image: ⟬hostname#1⟭/boutique/catalogue:⟬version#1⟭
          env:
            - name: KAFKA_BROKERS
              value: ⟬hostname#2⟭:9092
            - name: TOPIC_PRIX
              value: catalogue.prix.⟬trap:library|kafka⟭
            - name: COLLECTION_MISE_EN_AVANT
              value: ⟬trap:word_name|Rose⟭ poudré
            - name: JAVA_TOOL_OPTIONS
              value: -XX:MaxRAMPercentage=70
            - name: OTEL_EXPORTER_JAEGER_ENDPOINT
              value: http://⟬trap:library|jaeger⟭-collector.observabilite:14268/api/traces
          resources:
            requests:
              cpu: 500m
              memory: 1Gi
⟬end⟭

⟬template⟭
family: config
format: GitHub Actions .yml
language: fr
fill_locale: fr_FR
domain: banking
appearance: comment, secret reference, curl command, HTTP header, YAML value
scenario: workflow hebdomadaire de contrôles de conformité d'une banque en ligne, modifié par un auditeur externe qui a remis ses propres clés dans le fichier
⟬text⟭
# Contrôles de conformité, chaque lundi matin
# Ajustements de l'audit : ⟬person_name#1⟭ - rapport à envoyer à ⟬email:generic#2⟭
name: controles-conformite

on:
  schedule:
    - cron: "0 5 * * 1"
  workflow_dispatch:

jobs:
  analyse:
    runs-on: [self-hosted, zone-pci]
    steps:
      - uses: ⟬trap:email_lookalike|actions/checkout@v4⟭

      - name: Analyse des dépendances
        run: ./outils/scan-dependances.sh --rapport rapport.json
        env:
          SCAN_API_TOKEN: ⟬trap:placeholder|${{ secrets.SCAN_TOKEN }}⟭

      - name: Vérification des agences (données publiques)
        env:
          GEOCODE_KEY: ⟬google_api_key#1⟭
        run: python outils/verifier_agences.py --pays ⟬country#1⟭

      - name: Envoi du rapport
        run: |
          curl --fail -X POST ⟬url#1⟭ \
            -H "X-Api-Key: ⟬opaque_token#1⟭" \
            -F ⟬trap:email_lookalike|rapport=@rapport.json⟭
          curl -s -X POST https://slack.com/api/chat.postMessage \
            -H "Authorization: Bearer ⟬slack_token#1⟭" \
            --data-urlencode "channel=audit-conformite" \
            --data-urlencode "text=Contrôles terminés"
⟬end⟭

⟬template⟭
family: config
format: GitHub Actions .yml
language: fr
fill_locale: fr_FR
domain: energy
appearance: command line, query string
scenario: publication de firmware pour des concentrateurs de compteurs, écrite par un électronicien qui découvre GitHub Actions
⟬text⟭
name: publication-firmware
on:
  release:
    types: [published]
jobs:
  publier:
    runs-on: ubuntu-latest
    steps:
      - uses: ⟬trap:email_lookalike|actions/download-artifact@v4⟭
      - run: sshpass -p '⟬password#1⟭' scp firmware.bin ⟬trap:email_lookalike|firmware@${{ vars.HOTE_OTA }}⟭:/srv/firmware/
      - run: curl -fsS "https://⟬hostname#1⟭/ota/publier?k=⟬opaque_token#1⟭"
⟬end⟭

⟬template⟭
family: config
format: .json
language: fr
fill_locale: fr_FR
domain: public administration
appearance: nested JSON, connection string, string value, array
scenario: appsettings.Production.json de l'application de gestion des aides sociales d'un CCAS, migré d'un ancien web.config par un prestataire
⟬text⟭
{
  "Logging": {
    "LogLevel": {
      "Default": "Information",
      "Microsoft.AspNetCore": "Warning"
    }
  },
  "AllowedHosts": "⟬hostname#1⟭",
  "ConnectionStrings": {
    "AidesSociales": "Server=⟬hostname#2⟭;Database=AidesSociales;User Id=svc_aides;Password=⟬password#1⟭;Encrypt=True;",
    "Archivage": "Server=⟬hostname#3⟭;Database=Archives;User Id=svc_archives;Password=⟬password#2⟭;TrustServerCertificate=True;"
  },
  "Organisme": {
    "Nom": "Centre communal d'action sociale de ⟬city#4⟭",
    "Siret": "⟬fr_siret#4⟭",
    "Adresse": "⟬fr_postal_address#4⟭",
    "Standard": "⟬phone#4⟭",
    "Courriel": "⟬email:generic#4⟭",
    "CompteTresorerie": "⟬iban#4⟭"
  },
  "Responsables": [
    {
      "Role": "Directrice",
      "Nom": "⟬person_name#5f⟭",
      "LigneDirecte": "⟬phone#5⟭"
    },
    {
      "Role": "Référent informatique",
      "Nom": "⟬person_name#6m⟭",
      "LigneDirecte": "⟬phone#6⟭"
    }
  ],
  "Smtp": {
    "Hote": "⟬hostname#7⟭",
    "Port": 587,
    "Utilisateur": "⟬email:generic#4⟭",
    "MotDePasse": "⟬password#3⟭",
    "UtiliserTls": true
  },
  "Authentification": {
    "Autorite": "⟬url#1⟭",
    "ClientId": "⟬uuid#1⟭",
    "ClientSecret": "⟬opaque_token#1⟭",
    "DureeJetonMinutes": 45
  },
  "Aides": {
    "PlafondAnnuelEuros": 1200,
    "DelaiInstructionJours": 30,
    "NotificationPapier": false,
    "CommissionMensuelle": true,
    "EchelleQuotientFamilial": [400, 700, 1000],
    "ValidationAutomatique": false,
    "ExerciceOuvert": "⟬date#1⟭",
    "PiecesObligatoires": ["avis-imposition", "justificatif-domicile", "rib"],
    "ValidationDeuxNiveaux": true
  },
  "Migration": {
    "SourceWebConfig": "⟬file_path#1⟭",
    "Note": "reprise des clés de l'ancien serveur, à faire tourner après la bascule"
  }
}
⟬end⟭

⟬template⟭
family: config
format: .jsonc (settings VS Code)
language: fr
fill_locale: fr_FR
domain: education
appearance: comment, nested JSON, string value
scenario: settings.json partagé de l'équipe qui développe une plateforme d'exercices en ligne pour collégiens, commenté pour les nouveaux arrivants
⟬text⟭
// Réglages partagés de l'équipe (JSONC : les commentaires sont autorisés ici)
{
  "editor.formatOnSave": true,
  "editor.rulers": [100],
  // ⟬trap:library|Prettier⟭ pour le front, ⟬trap:library|Black⟭ pour les exercices en Python
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "[python]": {
    "editor.defaultFormatter": "ms-python.black-formatter"
  },
  "files.exclude": {
    "**/__pycache__": true,
    "**/.venv": true
  },
  "python.testing.pytestEnabled": true,
  // base locale : le mot de passe vient de l'environnement de chacun
  "sqltools.connections": [
    {
      "name": "exercices-local",
      "driver": "PostgreSQL",
      "server": "localhost",
      "port": 5432,
      "database": "exercices",
      "username": "⟬trap:indicator_non_pii|dev⟭",
      "password": "⟬trap:placeholder|${env:PGPASSWORD}⟭"
    }
  ],
  "rest-client.environmentVariables": {
    "local": {
      "baseUrl": "http://localhost:8000",
      "jeton": "⟬trap:placeholder|<à renseigner>⟭"
    }
  },
  // mots acceptés par le correcteur : noms d'algorithmes vus en classe
  "cSpell.words": ["⟬trap:eponym|Fibonacci⟭", "⟬trap:eponym|Pythagore⟭", "⟬trap:eponym|Thalès⟭", "⟬trap:eponym|Dijkstra⟭"],
  "cSpell.language": "fr,en"
}
⟬end⟭

⟬template⟭
family: config
format: .json
language: fr
fill_locale: fr_FR
domain: banking
appearance: nested JSON, escaped private key, string value, webhook
scenario: configuration du connecteur de vérification d'identité d'un établissement de paiement, générée par l'outil du fournisseur KYC et jointe à un ticket
⟬text⟭
{
  "connecteur": "verification-identite",
  "version": "⟬version#1⟭",
  "environnement": "production",
  "fournisseur": {
    "baseUrl": "⟬url#1⟭",
    "clientId": "⟬uuid#1⟭",
    "signature": {
      "algorithme": "RS256",
      "kid": "⟬hash#1⟭",
      "clePrivee": "⟬private_key#1⟭"
    }
  },
  "webhook": {
    "url": "⟬url#2⟭",
    "secret": "⟬opaque_token#1⟭",
    "tentatives": 5
  },
  "compteDeControle": {
    "titulaire": "⟬person_name#2⟭",
    "ibanVirementTest": "⟬iban#2⟭",
    "montantCentimes": 1
  },
  "seuils": {
    "scoreDocumentMin": 0.8,
    "⟬trap:indicator_non_pii|ageMinimum⟭": 18,
    "⟬trap:indicator_non_pii|dobFormat⟭": "⟬trap:indicator_non_pii|%d/%m/%Y⟭"
  }
}
⟬end⟭

⟬template⟭
family: config
format: .toml
language: fr
fill_locale: fr_FR
domain: public administration
appearance: comment, TOML value
scenario: fichier de déploiement de la petite application de dons d'une médiathèque municipale, mis en ligne par un bénévole
⟬text⟭
# dons à la médiathèque, déployé par ⟬person_name#1⟭
app = "mediatheque-dons"
primary_region = "cdg"

[env]
STRIPE_API_KEY = "⟬stripe_secret_key#2⟭"
ORGANISME_SIRET = "⟬fr_siret#2⟭"
SLACK_TOKEN = "⟬slack_token#1⟭"

[http_service]
internal_port = 8080
force_https = true
⟬end⟭

⟬template⟭
family: config
format: .toml
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: comment, TOML value, multiline string, url, array of tables
scenario: configuration de la passerelle HL7 entre le laboratoire et le dossier patient d'une clinique, écrite par l'intégrateur et annotée pendant la recette
⟬text⟭
# Passerelle HL7 laboratoire <-> dossier patient
# Intégrateur : ⟬company#1⟭
# Chef de projet clinique : Dr ⟬person_name#2⟭ (⟬phone#2⟭)
# Recette prévue la semaine du ⟬date#1⟭

[service]
nom = "passerelle-hl7"
mode = "recette"
langue_logs = "fr"
repertoire = "/opt/passerelle"
niveau_journal = "debug"

[entree]
adresse = "0.0.0.0"
port = 2575
protocole = "mllp"
accuse_reception = true
encodage = "ISO-8859-15"

[sortie]
url = "⟬url#1⟭"
methode = "POST"
delai_max_s = 20

[sortie.authentification]
type = "oauth2"
client_id = "⟬uuid#1⟭"
client_secret = "⟬opaque_token#1⟭"
jeton_url = "⟬url#2⟭"
⟬trap:indicator_non_pii|jeton_ttl = 3600⟭

[base]
dsn = "postgresql://hl7:⟬url_password#1⟭@⟬hostname#1⟭:5432/hl7_recette"
taille_pool = 8
archivage_jours = 90

[tls]
certificat = "/etc/passerelle/client.crt"
autorite = "/etc/passerelle/ca.crt"
cle = """
⟬private_key#1⟭
"""

[[automates]]
nom = "⟬trap:company_name|Beckman⟭ AU5800"
ip = "⟬ip_address#1⟭"
service = "biochimie"

[[automates]]
nom = "⟬trap:company_name|Sysmex⟭ XN-1000"
ip = "⟬ip_address#2⟭"
service = "hématologie"

[[automates]]
nom = "Analyseur de gaz du sang"
ip = "⟬ip_address#3⟭"
service = "urgences"

[alertes]
destinataires = ["⟬email#2⟭", "⟬email:generic#3⟭"]
sms_astreinte = "⟬phone#3⟭"
# méthode de ⟬trap:eponym|Westgard⟭ pour le contrôle qualité
regles_qc = ["1-3s", "2-2s", "R-4s"]
⟬end⟭

⟬template⟭
family: config
format: .toml
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: TOML value, array, inline table, comment
scenario: pyproject.toml de l'outil de calcul des frais de port d'une boutique, écrit par l'équipe logistique et publié sur l'index interne
⟬text⟭
[project]
name = "calcul-frais-port"
version = "⟬version#1⟭"
description = "Calcul des frais de port et des zones de livraison"
readme = "README.md"
requires-python = ">=3.11"
authors = [{ name = "⟬trap:indicator_non_pii|Équipe logistique⟭" }]
dependencies = [
  "⟬trap:library|pandas⟭>=2.2",
  "⟬trap:library|flask⟭>=3.0",
  "⟬trap:library|jinja2⟭>=3.1",
  "⟬trap:library|gunicorn⟭>=22.0",
]

[project.optional-dependencies]
docs = ["⟬trap:library|sphinx⟭>=7.3", "⟬trap:library|furo⟭"]
dev = ["pytest>=8", "ruff>=0.5"]

[project.urls]
Documentation = "⟬url#1⟭"

[tool.ruff]
line-length = 100
target-version = "py311"

[tool.pytest.ini_options]
addopts = "-ra --strict-markers"
# marqueur pour les grilles du transporteur ⟬trap:company_name|⦃Family⦄ Transports⟭
markers = ["grille: tests des grilles tarifaires"]

[[tool.uv.index]]
name = "interne"
url = "⟬url#2⟭"
⟬end⟭

⟬template⟭
family: config
format: .ini
language: fr
fill_locale: fr_FR
domain: energy
appearance: comment, ini key, connection string
scenario: pgbouncer.ini de la base de mesures d'un distributeur de gaz, recopié d'un serveur à l'autre par l'équipe exploitation
⟬text⟭
; pgbouncer - base des mesures de débit
; géré par l'exploitation, ⟬person_name#1⟭ ⟬phone#1⟭
; dernière modif ⟬date#1⟭ - revu par ⟬trap:initials|JD⟭

[databases]
mesures = host=⟬hostname#1⟭ port=5432 dbname=mesures user=mesures_app password=⟬password#1⟭
facturation = host=⟬hostname#2⟭ port=5432 dbname=facturation user=fact_ro password=⟬password#2⟭
* = host=127.0.0.1 port=5432

[pgbouncer]
listen_addr = 0.0.0.0
listen_port = 6432
auth_type = scram-sha-256
auth_file = /etc/pgbouncer/userlist.txt
admin_users = ⟬username#1⟭
stats_users = ⟬username#2⟭
pool_mode = transaction
max_client_conn = 400
default_pool_size = 40
server_tls_sslmode = require
logfile = ⟬file_path#1⟭
⟬end⟭

⟬template⟭
family: config
format: .ini
language: fr
fill_locale: fr_FR
domain: banking
appearance: comment, ini key, section header, url
scenario: grafana.ini de la supervision des paiements d'une banque coopérative, modifié au fil des incidents et dont une partie est commentée
⟬text⟭
##################### Supervision paiements #####################
# Instance interne, accès VPN uniquement.
# Administrateur fonctionnel : ⟬person_name#1m⟭
# Sauvegarde : ⟬person_name#2⟭

[paths]
data = /var/lib/grafana
logs = /var/log/grafana
plugins = /var/lib/grafana/plugins
provisioning = /etc/grafana/provisioning

[server]
protocol = https
http_port = 3000
domain = ⟬hostname#1⟭
root_url = https://⟬hostname#1⟭/
cert_file = /etc/grafana/tls/grafana.crt
cert_key = /etc/grafana/tls/grafana.key

[database]
type = postgres
host = ⟬hostname#2⟭:5432
name = grafana
user = ⟬username#1⟭
password = ⟬password#1⟭
ssl_mode = require

[remote_cache]
type = redis
connstr = addr=⟬hostname#3⟭:6379,password=⟬password#2⟭,db=2

[security]
admin_user = ⟬trap:indicator_non_pii|admin⟭
admin_password = ⟬password#3⟭
secret_key = ⟬opaque_token#1⟭
disable_gravatar = true
cookie_secure = true
⟬trap:indicator_non_pii|password_hint = password⟭
⟬trap:indicator_non_pii|login_maximum_inactive_lifetime_duration = 30m⟭

[users]
allow_sign_up = false
auto_assign_org_role = Viewer
⟬trap:indicator_non_pii|default_theme = light⟭

[auth.ldap]
enabled = true
config_file = /etc/grafana/ldap.toml

[auth.google]
enabled = false
client_id = ⟬customer_id#1⟭
client_secret = ⟬opaque_token#2⟭

[smtp]
enabled = true
host = ⟬hostname#4⟭:587
user = ⟬email:generic#3⟭
password = ⟬password#4⟭
from_address = ⟬email:generic#3⟭
from_name = ⟬trap:indicator_non_pii|Supervision⟭

[alerting]
enabled = false

[unified_alerting]
enabled = true

; ancien canal d'alerte, gardé pour mémoire
; slack_token = ⟬slack_token#1⟭
; slack_channel = incidents-paiements

[log]
mode = console file
level = info

[metrics]
enabled = true
basic_auth_username = ⟬username#2⟭
basic_auth_password = ⟬password#5⟭
⟬end⟭

⟬template⟭
family: config
format: .ini
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: ini key
scenario: fichier de connexion client MySQL d'un administrateur de la base de gestion d'un EHPAD, copié dans le dépôt des scripts de sauvegarde
⟬text⟭
[client]
host = ⟬hostname#1⟭
port = 3306
user = ⟬username#1⟭
password = ⟬password#1⟭
database = gestion_resident
default-character-set = utf8mb4
⟬end⟭

⟬template⟭
family: config
format: .properties
language: fr
fill_locale: fr_FR
domain: public administration
appearance: comment, properties key, url
scenario: connecteur Kafka Connect qui alimente l'infocentre de la direction des titres d'une préfecture, posé par une data engineer en mission
⟬text⟭
# Connecteur infocentre titres - source JDBC
# Mission : ⟬person_name#1f⟭, jusqu'au ⟬date#1⟭ ; ensuite voir ⟬email:generic#2⟭
name=titres-source-jdbc
connector.class=io.confluent.connect.jdbc.JdbcSourceConnector
tasks.max=2
connection.url=jdbc:postgresql://⟬hostname#1⟭:5432/titres?sslmode=require
connection.user=⟬username#1⟭
connection.password=⟬password#1⟭
mode=timestamp+incrementing
timestamp.column.name=date_maj
incrementing.column.name=id
table.whitelist=demande_titre,rendez_vous
topic.prefix=titres.
poll.interval.ms=60000
transforms=masque
transforms.masque.type=org.apache.kafka.connect.transforms.MaskField$Value
⟬trap:indicator_non_pii|transforms.masque.fields=date_naissance,nom_usage⟭
transforms.masque.replacement=***
# registre de schémas, identifiants du compte de service
value.converter.schema.registry.url=https://registre:⟬url_password#1⟭@⟬hostname#2⟭:8081
errors.deadletterqueue.topic.name=titres.rejets
errors.tolerance=all
⟬end⟭

⟬template⟭
family: config
format: .properties
language: fr
fill_locale: fr_FR
domain: education
appearance: comment, properties key
scenario: gradle.properties de l'application mobile des parents d'élèves d'un groupe scolaire, resté avec les mots de passe du magasin de clés
⟬text⟭
# Application parents d'élèves - build Android
# Compte développeur géré par ⟬person_name#1⟭
org.gradle.jvmargs=-Xmx4g -Dfile.encoding=UTF-8
org.gradle.parallel=true
android.useAndroidX=true
kotlin.code.style=official
VERSION_NAME=⟬version#1⟭
VERSION_CODE=214

# signature release
RELEASE_STORE_FILE=../secrets/parents-release.jks
RELEASE_STORE_PASSWORD=⟬password#1⟭
RELEASE_KEY_ALIAS=parents
RELEASE_KEY_PASSWORD=⟬password#2⟭

# services
MAPS_API_KEY=⟬google_api_key#1⟭
SENTRY_AUTH_TOKEN=⟬opaque_token#1⟭
⟬trap:indicator_non_pii|SUPPORT_CONTACT=support⟭
PUBLICATION_BETA=false
⟬end⟭

⟬template⟭
family: config
format: .properties
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: properties key, message bundle, comment
scenario: fichier de messages français d'une boutique en Spring, retouché par la rédactrice web après relecture des mails transactionnels
⟬text⟭
# messages_fr.properties - libellés de la boutique
# Les paramètres {0}, {1} sont remplis par l'application.
commande.confirmation.titre=Merci pour votre commande {0}
commande.confirmation.corps=Votre commande sera expédiée sous 48 heures.
commande.suivi.lien=Suivre mon colis
⟬trap:indicator_non_pii|courriel.salutation=Bonjour à tous⟭
courriel.salutation.client=Bonjour {0},
courriel.signature=L'équipe de la boutique
⟬trap:indicator_non_pii|compte.mot_de_passe.aide=Votre mot de passe doit contenir au moins 12 caractères⟭
compte.mot_de_passe.oublie=Mot de passe oublié ?
⟬trap:indicator_non_pii|compte.nom.libelle=Nom⟭
⟬trap:indicator_non_pii|compte.telephone.libelle=Téléphone⟭
⟬trap:indicator_non_pii|compte.email.exemple=vous@exemple⟭
compte.adresse.ajouter=Ajouter une adresse
paiement.carte.refusee=Votre carte a été refusée.
paiement.iban.invalide=Cet IBAN n'est pas valide.
produit.collection.pierre=Collection ⟬trap:word_name|Pierre⟭ de lune
produit.collection.margaux=Cuvée ⟬trap:word_name|Margaux⟭, millésime 2019
produit.marque.exemple=Porte-clés ⟬trap:company_name|Peugeot⟭ d'époque
produit.livraison.ville=Livraison offerte à ⟬trap:word_name|Paris⟭
produit.avis.titre=Ce que nos clients en pensent
⟬end⟭
