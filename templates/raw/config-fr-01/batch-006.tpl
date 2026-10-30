⟬template⟭
family: config
format: .env
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: comment, assignment, quoted value, url
scenario: .env de l'API headless d'un fabricant de meubles, écrit par le développeur qui a fait la mise en production et oublié de retirer le jeton de démonstration
⟬text⟭
# Boutique meubles - API
# ⟬person_name#1m⟭ a fait la mise en prod, voir avec lui pour les accès admin
NODE_ENV=production
DATABASE_URL=postgres://meubles:⟬url_password#1⟭@⟬hostname#1⟭:5432/meubles
JWT_SECRET=⟬opaque_token#1⟭
COOKIE_SECRET=⟬opaque_token#2⟭
STRIPE_API_KEY=⟬stripe_secret_key#2⟭
STRIPE_WEBHOOK_SECRET=⟬opaque_token#3⟭
ENSEIGNE="⟬company#3⟭"
ENSEIGNE_SIREN="⟬fr_siren#3⟭"
ENSEIGNE_SIRET="⟬fr_siret#3⟭"
FACTURE_IBAN="⟬iban#3⟭"
# jeton de la démo du salon, valable encore 1 an
API_DEMO_TOKEN=⟬jwt#1⟭
⟬trap:indicator_non_pii|JWT_EXPIRATION=24h⟭
⟬end⟭

⟬template⟭
family: config
format: .env
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: comment, assignment, section header
scenario: .env.example de l'entrepôt de données de santé d'un CHU, rédigé par l'équipe recherche clinique pour les doctorants qui rejoignent le projet
⟬text⟭
# Entrepôt de données de santé - exemple de configuration
# Aucune donnée réelle ni identifiant ne doit figurer ici.

## Accès à l'entrepôt
ENTREPOT_HOTE=⟬hostname#1⟭
ENTREPOT_PORT=5432
ENTREPOT_BASE=omop
⟬trap:indicator_non_pii|ENTREPOT_UTILISATEUR=chercheur⟭
ENTREPOT_MOT_DE_PASSE=⟬trap:placeholder|<fourni par la cellule entrepôt>⟭
⟬trap:indicator_non_pii|PSEUDONYMISATION_ACTIVE=true⟭
⟬trap:indicator_non_pii|SEUIL_PETITS_EFFECTIFS=10⟭

## Calcul
JUPYTER_PORT=8888
JUPYTER_TOKEN=⟬trap:placeholder|changeme⟭
SPARK_MASTER=spark://⟬hostname#2⟭:7077
SPARK_EXECUTOR_MEMORY=16g

## Analyses par défaut
# survie estimée par ⟬trap:eponym|Kaplan-Meier⟭, modèle de ⟬trap:eponym|Cox⟭ pour les ajustements
METHODE_SURVIE=⟬trap:eponym|kaplan_meier⟭
SCORE_COMORBIDITE=⟬trap:eponym|charlson⟭
⟬trap:indicator_non_pii|AGE_MINIMUM_COHORTE=18⟭
⟬trap:indicator_non_pii|DATE_NAISSANCE_ARRONDIE=annee⟭
⟬trap:indicator_non_pii|NOM_PATIENT_COLONNE=absente⟭
⟬end⟭

⟬template⟭
family: config
format: docker-compose.yml
language: fr
fill_locale: fr_FR
domain: public administration
appearance: comment, label, YAML value, public key, url
scenario: compose du serveur cartographique du service urbanisme d'une métropole, déployé par une géomaticienne avec un dépôt SFTP pour les bureaux d'études
⟬text⟭
# Serveur cartographique - service urbanisme
# Administratrice : ⟬person_name#1f⟭ (poste ⟬phone#1⟭)
services:
  postgis:
    image: postgis/postgis:16-3.4
    environment:
      POSTGRES_DB: urbanisme
      POSTGRES_USER: sig
      POSTGRES_PASSWORD: ⟬password#1⟭
    volumes:
      - pgdata:/var/lib/postgresql/data

  geoserver:
    image: kartoza/geoserver:2.25.2
    environment:
      GEOSERVER_ADMIN_USER: ⟬trap:indicator_non_pii|admin⟭
      GEOSERVER_ADMIN_PASSWORD: ⟬password#2⟭
      GEOSERVER_DATA_DIR: /opt/geoserver/data_dir
      FOND_DE_CARTE_CLE: ⟬google_api_key#1⟭
    labels:
      metropole.service: "urbanisme"
      metropole.contact: "⟬email#1⟭"
    ports:
      - "8600:8080"
    depends_on:
      - postgis

  depot-bureaux-etudes:
    image: atmoz/sftp:alpine
    command: bureau:⟬password#3⟭:1002
    environment:
      # clé autorisée du bureau d'études ⟬trap:company_name|⦃Family⦄ Géomètres⟭
      CLE_AUTORISEE: ⟬ssh_public_key#1⟭
    volumes:
      - plans:/home/bureau/plans
    ports:
      - "2223:22"

volumes:
  pgdata:
  plans:
⟬end⟭

⟬template⟭
family: config
format: docker-compose.yml
language: fr
fill_locale: fr_FR
domain: energy
appearance: comment, YAML block, YAML value, url, label, environment list
scenario: compose de la pile LoRaWAN de télérelève des compteurs d'eau et de chaleur d'une régie, adapté d'un exemple public par l'ingénieur réseau
⟬text⟭
# Pile LoRaWAN de télérelève, régie des réseaux
# Ingénieur réseau : ⟬person_name#1m⟭ - ⟬phone#1⟭
# Antennes installées : ⟬city#2⟭, ⟬city#3⟭, ⟬city#4⟭
services:
  serveur-reseau:
    image: chirpstack/chirpstack:4.8
    command: -c /etc/chirpstack
    restart: unless-stopped
    volumes:
      - ./chirpstack:/etc/chirpstack
    environment:
      POSTGRESQL_DSN: postgres://chirpstack:⟬url_password#1⟭@postgres/chirpstack?sslmode=disable
      REDIS_HOST: redis
      MQTT_BROKER_HOST: mosquitto
      API_SECRET: ⟬opaque_token#1⟭
      ⟬trap:indicator_non_pii|JWT_TOKEN_DUREE_HEURES: 8⟭
      SLACK_ALERTES_TOKEN: ⟬slack_token#1⟭
    labels:
      regie.responsable: "⟬person_name#1⟭"
      regie.contrat-fournisseur: "⟬order_number#1⟭"
    depends_on:
      - postgres
      - mosquitto
      - redis
    ports:
      - "8080:8080"

  pont-passerelles:
    image: chirpstack/chirpstack-gateway-bridge:4.0
    restart: unless-stopped
    environment:
      - INTEGRATION__MQTT__EVENT_TOPIC_TEMPLATE=eu868/gateway/{{ .GatewayID }}/event/{{ .EventType }}
      - INTEGRATION__MQTT__STATE_TOPIC_TEMPLATE=eu868/gateway/{{ .GatewayID }}/state/{{ .StateType }}
      - INTEGRATION__MQTT__COMMAND_TOPIC_TEMPLATE=eu868/gateway/{{ .GatewayID }}/command/#
    ports:
      - "1700:1700/udp"
    depends_on:
      - mosquitto

  decodeur:
    image: ⟬hostname#1⟭/regie/decodeur-index:⟬version#1⟭
    restart: unless-stopped
    environment:
      MQTT_URL: mqtt://decodeur:⟬url_password#2⟭@mosquitto:1883
      BASE_INDEX: postgres://index:⟬url_password#3⟭@postgres/index
      FACTURATION_API: ⟬url#1⟭
      FACTURATION_CLIENT_CERT_KEY: |
        ⟬private_key#1⟭
      ⟬trap:indicator_non_pii|ABONNE_ID_FORMAT: "PDL-%08d"⟭

  mosquitto:
    image: eclipse-mosquitto:2
    restart: unless-stopped
    volumes:
      - ./mosquitto:/mosquitto/config
    ports:
      - "1883:1883"

  postgres:
    image: postgres:16-alpine
    restart: unless-stopped
    environment:
      POSTGRES_PASSWORD: ⟬password#1⟭
    volumes:
      - postgres:/var/lib/postgresql/data

  redis:
    image: redis:7-alpine
    restart: unless-stopped

volumes:
  postgres:
⟬end⟭

⟬template⟭
family: config
format: Kubernetes .yaml
language: fr
fill_locale: fr_FR
domain: banking
appearance: custom resource, annotation, stringData, YAML block, comment
scenario: ressources Kafka d'une banque privée pour les flux de valorisation, écrites par l'équipe data avec un compte applicatif de démonstration
⟬text⟭
# Flux de valorisation - cluster partagé des équipes data
apiVersion: kafka.strimzi.io/v1beta2
kind: Kafka
metadata:
  name: ⟬trap:code_identifier|⦃family⦄-cluster⟭
  namespace: flux-valorisation
  annotations:
    responsable: "M. ⟬person_name:family#1m⟭"
spec:
  kafka:
    replicas: 3
    version: 3.7.0
    listeners:
      - name: tls
        port: 9093
        type: internal
        tls: true
    storage:
      type: persistent-claim
      size: 200Gi
  zookeeper:
    replicas: 3
    storage:
      type: persistent-claim
      size: 20Gi
---
apiVersion: kafka.strimzi.io/v1beta2
kind: KafkaUser
metadata:
  name: valorisation
  namespace: flux-valorisation
  labels:
    strimzi.io/cluster: ⟬trap:code_identifier|⦃family⦄-cluster⟭
spec:
  authentication:
    type: tls
  authorization:
    type: simple
    acls:
      - resource:
          type: topic
          name: valorisation.
          patternType: prefix
        operations: [Read, Write]
---
apiVersion: v1
kind: Secret
metadata:
  name: valorisation-client
  namespace: flux-valorisation
type: Opaque
stringData:
  user.key: |
    ⟬private_key#1⟭
  user.password: ⟬password#1⟭
  compte-demonstration: |
    titulaire: ⟬person_name#2⟭
    iban: ⟬iban#2⟭
    gestionnaire: ⟬email:generic#3⟭
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: valorisation-client
  namespace: flux-valorisation
data:
  bootstrap.servers: ⟬trap:code_identifier|⦃family⦄-cluster⟭-kafka-bootstrap:9093
  security.protocol: SSL
  devise.reference: EUR
⟬end⟭

⟬template⟭
family: config
format: Kubernetes .yaml
language: fr
fill_locale: fr_FR
domain: energy
appearance: label, DaemonSet, comment
scenario: DaemonSet d'exportateur de métriques sur les nœuds d'un opérateur de stockage par batteries, ajouté par l'équipe observabilité
⟬text⟭
# Métriques des nœuds du cluster de pilotage des batteries
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: exportateur-noeuds
  namespace: observabilite
  labels:
    cluster: ⟬trap:code_identifier|⦃given⦄⟭
    ⟬trap:indicator_non_pii|contact: observabilite⟭
    ⟬trap:indicator_non_pii|owner: plateforme⟭
spec:
  selector:
    matchLabels:
      app: exportateur-noeuds
  template:
    metadata:
      labels:
        app: exportateur-noeuds
      annotations:
        prometheus.io/scrape: "true"
        prometheus.io/port: "9100"
    spec:
      hostNetwork: true
      tolerations:
        - operator: Exists
      containers:
        - name: exportateur
          image: quay.io/⟬trap:library|prometheus⟭/node-exporter:v1.8.1
          args:
            - --path.rootfs=/host
            - --collector.textfile.directory=/var/lib/metriques
          ports:
            - containerPort: 9100
          volumeMounts:
            - name: racine
              mountPath: /host
              readOnly: true
      volumes:
        - name: racine
          hostPath:
            path: /
⟬end⟭

⟬template⟭
family: config
format: GitHub Actions .yml
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: environment variable, test fixture, YAML value, comment
scenario: parcours d'achat de bout en bout lancés chaque nuit sur la recette d'un site d'optique, avec un client de test et une clé figés par le testeur
⟬text⟭
name: parcours-achat-nuit

on:
  schedule:
    - cron: "10 3 * * *"

jobs:
  playwright:
    runs-on: ubuntu-latest
    env:
      BASE_URL: https://⟬hostname#1⟭
      # client de test créé à la main par ⟬person_name:initial#1⟭, ne pas supprimer
      CLIENT_TEST_ID: ⟬customer_id#2⟭
      CLIENT_TEST_NOM: ⟬person_name#2⟭
      CLIENT_TEST_MAIL: ⟬email#2⟭
      CLIENT_TEST_MDP: ⟬password#1⟭
      CLIENT_TEST_ADRESSE: ⟬fr_postal_address#2⟭
      CLIENT_TEST_IBAN: "⟬iban#2⟭"
      STRIPE_CLE_RECETTE: ⟬stripe_secret_key#3⟭
      ⟬trap:indicator_non_pii|TIMEOUT_LOGIN_MS: 30000⟭
    steps:
      - uses: ⟬trap:email_lookalike|actions/checkout@v4⟭
      - uses: ⟬trap:email_lookalike|actions/setup-node@v4⟭
        with:
          node-version: 20
      - run: npm ci && npx playwright install --with-deps chromium
      - run: npx playwright test parcours/
      - uses: ⟬trap:email_lookalike|actions/upload-artifact@v4⟭
        if: failure()
        with:
          name: captures
          path: test-results/
⟬end⟭

⟬template⟭
family: config
format: GitHub Actions .yml
language: fr
fill_locale: fr_FR
domain: education
appearance: command line, no announcing word
scenario: vérification hebdomadaire des salles de classe virtuelles d'une école de commerce, écrite par un technicien audiovisuel
⟬text⟭
name: controle-classes-virtuelles
on:
  schedule:
    - cron: "0 6 * * 1"
jobs:
  verifier:
    runs-on: ubuntu-latest
    steps:
      - run: curl -fsS "https://⟬hostname#1⟭/api/getMeetings?checksum=⟬hash#1⟭"
      - run: ./verifier_classes.sh ⟬hostname#1⟭ ⟬opaque_token#1⟭
⟬end⟭

⟬template⟭
family: config
format: .json
language: fr
fill_locale: fr_FR
domain: energy
appearance: nested JSON, escaped private key, string value
scenario: fichier d'identifiants déchiffré des flux Node-RED d'une centrale photovoltaïque, joint à une demande d'aide sur le forum interne de l'exploitant
⟬text⟭
{
  "broker-mqtt-site": {
    "user": "⟬username#1⟭",
    "password": "⟬password#1⟭"
  },
  "api-onduleurs": {
    "token": "⟬opaque_token#1⟭"
  },
  "cartographie": {
    "apiKey": "⟬google_api_key#1⟭"
  },
  "alertes-slack": {
    "token": "⟬slack_token#1⟭"
  },
  "sftp-gestionnaire-reseau": {
    "username": "⟬username#2⟭",
    "privateKey": "⟬private_key#1⟭",
    "passphrase": "⟬password#2⟭"
  },
  "technicien-site": {
    "name": "⟬person_name#3⟭",
    "phone": "⟬phone#3⟭"
  }
}
⟬end⟭

⟬template⟭
family: config
format: .json
language: fr
fill_locale: fr_FR
domain: public administration
appearance: nested JSON, string value, array
scenario: configuration de l'assistant conversationnel d'accueil d'une caisse d'allocations, nommé d'après un prénom et paramétré par le chef de produit
⟬text⟭
{
  "assistant": {
    "nom": "⟬trap:eponym|⦃Given⦄⟭",
    "presentation": "Bonjour, je suis ⟬trap:eponym|⦃Given⦄⟭, l'assistant virtuel de la caisse.",
    "langue": "fr",
    "version": "⟬version#1⟭"
  },
  "organisme": {
    "siret": "⟬fr_siret#2⟭",
    "standard": "⟬phone#2⟭",
    "dpo": "⟬email:generic#2⟭"
  },
  "canaux": {
    "web": {"actif": true, "origines": ["https://⟬hostname#1⟭"]},
    "slackInterne": {
      "actif": true,
      "botToken": "⟬slack_token#1⟭",
      "signingSecret": "⟬opaque_token#1⟭"
    }
  },
  "traduction": {
    "fournisseur": "google",
    "cle": "⟬google_api_key#1⟭",
    "cibles": ["en", "ar", "tr"]
  },
  "escalade": {
    "seuilConfiance": 0.55,
    "⟬trap:indicator_non_pii|motsDeclencheurs⟭": ["agent", "conseiller", "réclamation"],
    "referentMetier": "⟬person_name#3⟭"
  }
}
⟬end⟭

⟬template⟭
family: config
format: .json
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: nested JSON, array, string value
scenario: renovate.json du dépôt front d'une boutique de jeux de société, réglé par l'équipe pour regrouper les mises à jour le lundi
⟬text⟭
{
  "$schema": "https://docs.renovatebot.com/renovate-schema.json",
  "extends": ["config:recommended", ":dependencyDashboard"],
  "timezone": "Europe/Paris",
  "schedule": ["before 6am on monday"],
  "assignees": ["⟬trap:indicator_non_pii|equipe-front⟭"],
  "reviewers": ["⟬trap:indicator_non_pii|team:boutique-web⟭"],
  "labels": ["dependances"],
  "prConcurrentLimit": 4,
  "packageRules": [
    {
      "matchPackagePatterns": ["^⟬trap:email_lookalike|@storybook/⟭"],
      "groupName": "storybook"
    },
    {
      "matchPackageNames": ["⟬trap:library|jest⟭", "⟬trap:library|cypress⟭", "⟬trap:library|sass⟭"],
      "matchUpdateTypes": ["minor", "patch"],
      "automerge": true
    },
    {
      "matchPackageNames": ["⟬trap:code_identifier|⦃family⦄-ui⟭"],
      "enabled": false,
      "description": "paquet interne figé jusqu'à la refonte"
    }
  ],
  "hostRules": [
    {
      "matchHost": "⟬hostname#1⟭",
      "hostType": "npm",
      "token": "⟬trap:placeholder|{{ secrets.NPM_TOKEN }}⟭"
    }
  ]
}
⟬end⟭

⟬template⟭
family: config
format: .toml
language: fr
fill_locale: fr_FR
domain: banking
appearance: comment, TOML value, table, connection pool
scenario: pgcat.toml devant les bases d'un service de paiement instantané, maintenu par l'équipe base de données avec plusieurs comptes applicatifs
⟬text⟭
# pgcat - pool devant les bases de paiement instantané
# DBA de permanence : ⟬person_name#1⟭

[general]
host = "0.0.0.0"
port = 6432
admin_username = "⟬username#1⟭"
admin_password = "⟬password#1⟭"
enable_prometheus_exporter = true
prometheus_exporter_port = 9930
connect_timeout = 3000
idle_timeout = 30000
server_lifetime = 86400000
log_client_connections = false
log_client_disconnections = false
tls_certificate = "/etc/pgcat/serveur.crt"
tls_private_key = "/etc/pgcat/serveur.key"

[pools.virements]
pool_mode = "transaction"
default_role = "primary"
query_parser_enabled = true
primary_reads_enabled = false
sharding_function = "pg_bigint_hash"

[pools.virements.users.0]
username = "virements_app"
password = "⟬password#2⟭"
pool_size = 50
statement_timeout = 2000

[pools.virements.users.1]
username = "virements_batch"
password = "⟬password#3⟭"
pool_size = 10

[pools.virements.shards.0]
database = "virements"
servers = [
  ["⟬hostname#1⟭", 5432, "primary"],
  ["⟬hostname#2⟭", 5432, "replica"],
]

[pools.notifications]
pool_mode = "session"
default_role = "any"

[pools.notifications.users.0]
username = "notifications"
password = "⟬password#4⟭"
pool_size = 15

[pools.notifications.shards.0]
database = "notifications"
servers = [["⟬hostname#3⟭", 5432, "primary"]]

# compte de rapprochement : compte interne des virements en attente
[metadata]
compte_attente = "⟬iban#5⟭"
responsable_exploitation = "⟬email#1⟭"
⟬trap:indicator_non_pii|token_ttl = 600⟭
⟬end⟭

⟬template⟭
family: config
format: .toml
language: fr
fill_locale: fr_FR
domain: education
appearance: TOML value, no announcing word
scenario: fichier de configuration Cargo sur le poste d'un doctorant, avec le jeton du registre de paquets de son laboratoire
⟬text⟭
[registries.labo]
index = "⟬url#1⟭"
token = "⟬opaque_token#1⟭"

[net]
git-fetch-with-cli = true
⟬end⟭

⟬template⟭
family: config
format: .toml
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: TOML value, array of tables, dependency list, environment reference
scenario: Pipfile d'un outil de contrôle qualité des comptes rendus d'analyses, avec l'index privé lu dans l'environnement du poste
⟬text⟭
[[source]]
name = "pypi"
url = "https://pypi.org/simple"
verify_ssl = true

[[source]]
name = "interne"
url = "https://⟬trap:indicator_non_pii|lecture⟭:⟬trap:placeholder|${INDEX_TOKEN}⟭@⟬hostname#1⟭/simple"
verify_ssl = true

[packages]
⟬trap:library|pandas⟭ = "~=2.2"
⟬trap:library|flask⟭ = "~=3.0"
⟬trap:library|jinja2⟭ = "*"
⟬trap:library|sqlalchemy⟭ = "~=2.0"
controle-qualite-labo = { version = "*", index = "interne" }

[dev-packages]
pytest = "*"
⟬trap:library|faker⟭ = "*"
ruff = "*"

[requires]
python_version = "3.12"

[scripts]
controle = "python -m controle.run"
# test de ⟬trap:eponym|Grubbs⟭ sur les valeurs aberrantes
aberrants = "python -m controle.grubbs"
⟬end⟭

⟬template⟭
family: config
format: .ini
language: fr
fill_locale: fr_FR
domain: public administration
appearance: comment, ini key, section header
scenario: rclone.conf du service des archives d'un département, copié sur le serveur de versement par l'archiviste adjointe
⟬text⟭
# rclone - versement des archives numériques
# Note : compte fourni par ⟬person_name#1⟭ de la DSI

[archives-objet]
type = s3
provider = Other
access_key_id = ⟬opaque_token#1⟭
secret_access_key = ⟬opaque_token#2⟭
endpoint = ⟬url#1⟭
acl = private

[archives-chiffrees]
type = crypt
remote = archives-objet:versements
password = ⟬password#1⟭
password2 = ⟬password#2⟭

[sftp-prefecture]
type = sftp
host = ⟬hostname#1⟭
user = ⟬username#1⟭
pass = ⟬password#3⟭
port = 22
⟬end⟭

⟬template⟭
family: config
format: .ini
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: ini key, url, alias, section header
scenario: fichier .gitconfig de l'intégrateur d'une marketplace d'artisans, avec son identité et un jeton glissé dans une réécriture d'URL
⟬text⟭
[user]
	name = ⟬person_name#1⟭
	email = ⟬email#1⟭
	signingkey = ⟬hash#1⟭
[core]
	editor = vim
	autocrlf = input
[url "https://ci:⟬url_password#1⟭@⟬hostname#1⟭/"]
	insteadOf = https://⟬hostname#1⟭/
[alias]
	co = checkout
	st = status -sb
	lg = log --oneline --graph --decorate
[includeIf "gitdir:~/perso/"]
	path = ~/.gitconfig-perso
⟬end⟭

⟬template⟭
family: config
format: .ini
language: fr
fill_locale: fr_FR
domain: energy
appearance: comment, ini key, section header
scenario: table de registres Modbus d'un poste de transformation pour l'outil de relève, écrite par l'automaticien à partir de la notice constructeur
⟬text⟭
; registres Modbus - poste de transformation
; source : notice constructeur ⟬trap:company_name|Schneider⟭, révision ⟬version#1⟭

[connexion]
adresse = ⟬ip_address#1⟭
port = 502
unite = 3
delai_ms = 1500
⟬trap:indicator_non_pii|utilisateur = lecture⟭
⟬trap:indicator_non_pii|mot_de_passe_requis = non⟭

[tension_u12]
registre = 40001
format = float32
unite = V

[tension_u23]
registre = 40003
format = float32
unite = V

[courant_i1]
registre = 40013
format = float32
unite = A

[frequence]
registre = 40025
format = float32
unite = Hz

[puissance_active]
registre = 40029
format = float32
unite = kW

[alarme_buchholz]
; relais de ⟬trap:eponym|Buchholz⟭ du transformateur
registre = 10017
format = bool
⟬end⟭

⟬template⟭
family: config
format: .properties
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: comment, properties key, seed data
scenario: flyway.properties de la base de démonstration d'un logiciel d'EHPAD, avec un résident fictif injecté par les scripts de migration et copié d'un vrai dossier
⟬text⟭
# Migrations de la base de démonstration
flyway.url=jdbc:postgresql://⟬hostname#1⟭:5432/ehpad_demo
flyway.user=⟬username#1⟭
flyway.password=⟬password#1⟭
flyway.locations=filesystem:sql
flyway.cleanDisabled=true
# données injectées dans V12__resident_demo.sql
flyway.placeholders.resident_nom=⟬person_name#2⟭
flyway.placeholders.resident_naissance=⟬birth_date#2⟭
flyway.placeholders.resident_nir=⟬fr_social_security_number#2⟭
flyway.placeholders.resident_entree=⟬date#1⟭
flyway.placeholders.medecin=Dr ⟬person_name#3⟭
flyway.placeholders.contact_famille=⟬phone#4⟭
⟬trap:indicator_non_pii|flyway.placeholders.resident_age_min=60⟭
⟬end⟭

⟬template⟭
family: config
format: .properties
language: fr
fill_locale: fr_FR
domain: education
appearance: comment, properties key, array key, url
scenario: cas.properties du serveur d'authentification unique d'une université, adapté au fil des versions par l'équipe identité numérique
⟬text⟭
# Serveur d'authentification unique de l'université
# Équipe identité numérique : ⟬email:generic#1⟭
# Mainteneur actuel : ⟬person_name#2m⟭
# Dernière montée de version : ⟬date#1⟭ (⟬version#1⟭)

cas.server.name=https://⟬hostname#1⟭
cas.server.prefix=${cas.server.name}/cas
server.port=8443
server.ssl.key-store=file:/etc/cas/keystore.p12
server.ssl.key-store-password=⟬password#1⟭
server.ssl.key-password=⟬password#1⟭

# --- Annuaire ---
cas.authn.ldap[0].type=AUTHENTICATED
cas.authn.ldap[0].ldap-url=ldaps://⟬hostname#2⟭:636
cas.authn.ldap[0].base-dn=ou=personnes,dc=universite,dc=fr
cas.authn.ldap[0].bind-dn=cn=cas,ou=services,dc=universite,dc=fr
cas.authn.ldap[0].bind-credential=⟬password#2⟭
cas.authn.ldap[0].search-filter=uid={user}
cas.authn.ldap[0].principal-attribute-id=uid
⟬trap:indicator_non_pii|cas.authn.ldap[0].principal-attribute-list=sn,givenName,mail,eduPersonAffiliation⟭
⟬trap:indicator_non_pii|cas.authn.attribute-repository.core.default-attributes-to-release=mail,displayName⟭

# --- Chiffrement des jetons ---
cas.tgc.crypto.encryption.key=⟬opaque_token#1⟭
cas.tgc.crypto.signing.key=⟬opaque_token#2⟭
cas.webflow.crypto.encryption.key=⟬opaque_token#3⟭
cas.webflow.crypto.signing.key=⟬opaque_token#4⟭
⟬trap:indicator_non_pii|cas.ticket.tgt.primary.max-time-to-live-in-seconds=28800⟭
⟬trap:indicator_non_pii|cas.ticket.st.time-to-kill-in-seconds=10⟭

# --- Registre des services ---
cas.service-registry.jpa.url=jdbc:postgresql://⟬hostname#3⟭:5432/cas
cas.service-registry.jpa.user=cas
cas.service-registry.jpa.password=⟬password#3⟭
cas.service-registry.jpa.driver-class=org.postgresql.Driver

# --- Tickets partagés ---
cas.ticket.registry.redis.host=⟬hostname#4⟭
cas.ticket.registry.redis.port=6379
cas.ticket.registry.redis.password=⟬password#4⟭
cas.ticket.registry.redis.use-ssl=true

# --- Double authentification ---
cas.authn.mfa.gauth.issuer=Université
cas.authn.mfa.gauth.label=⟬hostname#1⟭
cas.authn.mfa.gauth.crypto.encryption.key=⟬opaque_token#5⟭
⟬trap:indicator_non_pii|cas.authn.mfa.gauth.core.code-digits=6⟭
⟬trap:indicator_non_pii|cas.authn.mfa.gauth.core.time-step-size=30⟭

# --- Courriels ---
spring.mail.host=⟬hostname#5⟭
spring.mail.port=587
spring.mail.username=⟬email:generic#6⟭
spring.mail.password=⟬password#5⟭
cas.authn.pm.reset.mail.from=⟬email:generic#6⟭
cas.authn.pm.reset.mail.subject=Réinitialisation de votre mot de passe
⟬trap:indicator_non_pii|cas.authn.pm.core.password-policy-pattern=^.{12,}$⟭

# --- Journaux ---
logging.level.org.apereo.cas=INFO
logging.config=file:/etc/cas/log4j2.xml
cas.audit.engine.number-of-days-in-history=30
⟬end⟭

⟬template⟭
family: config
format: .properties
language: fr
fill_locale: fr_FR
domain: banking
appearance: properties key
scenario: keystore.properties de l'application mobile d'une néobanque, sorti par erreur du gitignore lors d'une réorganisation du dépôt
⟬text⟭
storeFile=../signature/banque-release.jks
storePassword=⟬password#1⟭
keyAlias=banque-release
keyPassword=⟬password#2⟭
⟬end⟭
