⟬template⟭
family: config
format: .env
language: fr
fill_locale: fr_FR
domain: public administration
appearance: comment, assignment, quoted value
scenario: .env de l'outil de gestion des listes électorales d'une mairie, préparé par le service informatique quelques semaines avant un scrutin
⟬text⟭
# Listes électorales - bureau centralisateur de ⟬city#1⟭
# Responsable du service élections : Mme ⟬person_name#2f⟭, ligne directe ⟬phone#2⟭
MAIRIE_SIRET="⟬fr_siret#1⟭"
REPERTOIRE_API=⟬url#1⟭
REPERTOIRE_CERT_MDP=⟬password#1⟭
SMS_EXPEDITEUR=MAIRIE
SMS_CLE=⟬opaque_token#1⟭
CARTE_BUREAUX_CLE=⟬google_api_key#1⟭
⟬trap:indicator_non_pii|ELECTEUR_AGE_MIN=18⟭
DATE_SCRUTIN="⟬date#1⟭"
NOMBRE_BUREAUX=14
⟬end⟭

⟬template⟭
family: config
format: .env
language: fr
fill_locale: fr_FR
domain: energy
appearance: comment, assignment, section header
scenario: .env fourni avec l'image Docker d'un simulateur de réseaux de chaleur, écrit par un laboratoire de recherche pour ses partenaires industriels
⟬text⟭
# Simulateur de réseaux de chaleur - variables d'environnement
# Chaque partenaire remplit sa propre copie ; ce fichier ne contient aucun accès.

### Calcul
SIMU_PAS_DE_TEMPS_S=300
SIMU_HORIZON_H=168
SIMU_THREADS=8
# équations de ⟬trap:eponym|Navier-Stokes⟭ simplifiées, pertes de charge selon ⟬trap:eponym|Darcy-Weisbach⟭
SOLVEUR=⟬trap:eponym|newton-raphson⟭
PERTES_CHARGE=⟬trap:eponym|colebrook⟭

### Fluide
FLUIDE=eau
TEMPERATURE_DEPART_C=90
RENDEMENT_REFERENCE=⟬trap:eponym|carnot⟭

### Données météo
METEO_API_URL=⟬url#1⟭
METEO_API_CLE=⟬trap:placeholder|<votre clé>⟭

### Licence
LICENCE_SERVEUR=⟬hostname#1⟭:27000
⟬trap:indicator_non_pii|LICENCE_USER=partenaire⟭
LICENCE_PASSWORD=⟬trap:placeholder|REPLACE_ME⟭
⟬trap:indicator_non_pii|LICENCE_TOKEN_DUREE_JOURS=365⟭

### Sorties
SORTIE_FORMAT=parquet
SORTIE_REPERTOIRE=./resultats
⟬trap:indicator_non_pii|AUTEUR_RAPPORT=simulateur⟭
⟬end⟭

⟬template⟭
family: config
format: docker-compose.yml
language: fr
fill_locale: fr_FR
domain: education
appearance: comment, YAML block, Ruby settings, YAML value
scenario: compose de la forge GitLab d'une école d'informatique, installée par le responsable pédagogique avec la configuration Omnibus directement dans le fichier
⟬text⟭
# Forge de l'école - promotions de première et deuxième année
# Responsable : ⟬person_name#1⟭ ; ne pas redémarrer pendant les partiels
services:
  gitlab:
    image: gitlab/gitlab-ce:17.2.0-ce.0
    hostname: ⟬hostname#1⟭
    restart: always
    ports:
      - "443:443"
      - "2424:22"
    environment:
      GITLAB_OMNIBUS_CONFIG: |
        external_url 'https://⟬hostname#1⟭'
        gitlab_rails['initial_root_password'] = '⟬password#1⟭'
        gitlab_rails['smtp_enable'] = true
        gitlab_rails['smtp_address'] = "⟬hostname#2⟭"
        gitlab_rails['smtp_port'] = 587
        gitlab_rails['smtp_user_name'] = "⟬email:generic#2⟭"
        gitlab_rails['smtp_password'] = "⟬password#2⟭"
        gitlab_rails['gitlab_email_from'] = '⟬email:generic#2⟭'
        gitlab_rails['omniauth_enabled'] = true
        gitlab_rails['omniauth_providers'] = [{ name: "google_oauth2", app_id: "⟬uuid#1⟭", app_secret: "⟬opaque_token#1⟭" }]
        gitlab_rails['backup_keep_time'] = 604800
    volumes:
      - config:/etc/gitlab
      - donnees:/var/opt/gitlab

  runner:
    image: gitlab/gitlab-runner:alpine
    restart: always
    environment:
      CI_SERVER_URL: https://⟬hostname#1⟭
      RUNNER_TOKEN: ⟬opaque_token#2⟭
      RUNNER_EXECUTOR: docker

volumes:
  config:
  donnees:
⟬end⟭

⟬template⟭
family: config
format: docker-compose.yml
language: fr
fill_locale: fr_FR
domain: banking
appearance: command line
scenario: compose de développement d'un simulateur de réseau de paiement, écrit par une développeuse pour reproduire des temps de réponse localement
⟬text⟭
services:
  simulateur:
    build: .
    environment:
      LATENCE_MS: 180
      TAUX_REFUS: 0.03
  cache:
    image: redis:7-alpine
    command: redis-server --requirepass ⟬password#1⟭
⟬end⟭

⟬template⟭
family: config
format: Kubernetes .yaml
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: comment, annotation, initContainer, ConfigMap, YAML block, command list, public key
scenario: manifeste de la base de rééducation d'un réseau de kinésithérapeutes, avec téléchargement du schéma au démarrage et accès de maintenance du prestataire
⟬text⟭
# Application de suivi de rééducation - réseau de kinésithérapeutes
# Accès de maintenance ouvert au prestataire jusqu'au ⟬date#1⟭
apiVersion: v1
kind: ConfigMap
metadata:
  name: maintenance-acces
  namespace: reeducation
  annotations:
    prestataire: "⟬company#1⟭ - ⟬phone#1⟭"
    demandeur: "⟬person_name#2⟭"
data:
  authorized_keys: |
    ⟬ssh_public_key#1⟭
  pgpass: |
    ⟬hostname#1⟭:5432:reeducation:maintenance:⟬password#1⟭
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: reeducation-api
  namespace: reeducation
spec:
  replicas: 2
  selector:
    matchLabels:
      app: reeducation-api
  template:
    metadata:
      labels:
        app: reeducation-api
    spec:
      imagePullSecrets:
        - name: registre-reseau
      initContainers:
        - name: schema
          image: curlimages/curl:8.8.0
          command: ["curl", "-fsS", "-u", "⟬username#1⟭:⟬password#2⟭", "-o", "/schema/schema.sql", "⟬url#1⟭"]
          volumeMounts:
            - name: schema
              mountPath: /schema
      containers:
        - name: api
          image: ⟬hostname#2⟭/reeducation/api:⟬version#1⟭
          env:
            - name: CARTE_CABINETS_CLE
              value: ⟬google_api_key#1⟭
            - name: ⟬trap:indicator_non_pii|PATIENT_NOM_AFFICHAGE⟭
              value: initiales
          volumeMounts:
            - name: schema
              mountPath: /schema
      volumes:
        - name: schema
          emptyDir: {}
---
apiVersion: v1
kind: Service
metadata:
  name: reeducation-api
  namespace: reeducation
spec:
  selector:
    app: reeducation-api
  ports:
    - port: 80
      targetPort: 8080
⟬end⟭

⟬template⟭
family: config
format: Kubernetes .yaml
language: fr
fill_locale: fr_FR
domain: public administration
appearance: comment, label, ResourceQuota, LimitRange
scenario: namespace et quotas attribués à une direction par la plateforme mutualisée d'un ministère, générés depuis le catalogue de services
⟬text⟭
# Généré par le catalogue de services le ⟬date#1⟭ - demande ⟬ticket_id#1⟭
apiVersion: v1
kind: Namespace
metadata:
  name: ⟬trap:code_identifier|⦃family⦄-prod⟭
  labels:
    ⟬trap:indicator_non_pii|owner: direction-des-affaires-maritimes⟭
    ⟬trap:indicator_non_pii|contact: guichet-plateforme⟭
    pod-security.kubernetes.io/enforce: restricted
    cout.centre: "4410"
---
apiVersion: v1
kind: ResourceQuota
metadata:
  name: quota-standard
  namespace: ⟬trap:code_identifier|⦃family⦄-prod⟭
spec:
  hard:
    requests.cpu: "20"
    requests.memory: 64Gi
    limits.memory: 96Gi
    persistentvolumeclaims: "10"
    services.loadbalancers: "0"
---
apiVersion: v1
kind: LimitRange
metadata:
  name: limites-par-defaut
  namespace: ⟬trap:code_identifier|⦃family⦄-prod⟭
spec:
  limits:
    - type: Container
      default:
        cpu: 500m
        memory: 512Mi
      defaultRequest:
        cpu: 100m
        memory: 128Mi
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: equipe-applicative
  namespace: ⟬trap:code_identifier|⦃family⦄-prod⟭
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: edit
subjects:
  - kind: Group
    name: ⟬trap:indicator_non_pii|gg-affaires-maritimes-dev⟭
    apiGroup: rbac.authorization.k8s.io
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: refus-par-defaut
  namespace: ⟬trap:code_identifier|⦃family⦄-prod⟭
spec:
  podSelector: {}
  policyTypes:
    - Ingress
    - Egress
⟬end⟭

⟬template⟭
family: config
format: GitHub Actions .yml
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: comment, YAML block, environment variable, command line
scenario: transformation quotidienne des données de remboursement d'une assurance santé avec dbt, où l'analyste a collé la clé d'accès à l'entrepôt
⟬text⟭
name: transformation-remboursements

on:
  schedule:
    - cron: "20 5 * * *"

env:
  DBT_PROFILES_DIR: ./profils

jobs:
  dbt:
    runs-on: ubuntu-latest
    env:
      ENTREPOT_COMPTE: ⟬hostname#1⟭
      ENTREPOT_UTILISATEUR: ⟬username#1⟭
      # clé personnelle de ⟬person_name#2⟭, en attendant le compte de service
      ENTREPOT_CLE_PRIVEE: |
        ⟬private_key#1⟭
      ENTREPOT_PHRASE: ⟬password#1⟭
    steps:
      - uses: ⟬trap:email_lookalike|actions/checkout@v4⟭
      - run: pip install dbt-snowflake==1.8.3
      - run: dbt deps && dbt run --select remboursements+ && dbt test
      - name: Alerte en cas d'échec
        if: failure()
        run: |
          curl -s -X POST https://slack.com/api/chat.postMessage \
            -H "Authorization: Bearer ⟬slack_token#1⟭" \
            -d channel=data-remboursements -d text="Transformation en échec"
⟬end⟭

⟬template⟭
family: config
format: GitHub Actions .yml
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: environment variable
scenario: synchronisation horaire des prix d'une épicerie en ligne, ajoutée sans revue par le gérant qui bricole lui-même son site
⟬text⟭
name: synchro-prix
on:
  schedule:
    - cron: "0 * * * *"
jobs:
  synchro:
    runs-on: ubuntu-latest
    env:
      STRIPE_KEY: ⟬stripe_secret_key#1⟭
      SIRET_VENDEUR: "⟬fr_siret#2⟭"
    steps:
      - uses: ⟬trap:email_lookalike|actions/checkout@v4⟭
      - run: node synchro-prix.js
⟬end⟭

⟬template⟭
family: config
format: .json
language: fr
fill_locale: fr_FR
domain: banking
appearance: nested JSON, key and value pair, generated config
scenario: environnement Postman exporté par un testeur d'une API de comptes bancaires, partagé dans un dépôt pour aider les nouveaux arrivants
⟬text⟭
{
  "id": "⟬uuid#1⟭",
  "name": "Recette comptes",
  "values": [
    {
      "key": "base",
      "value": "⟬url#1⟭",
      "type": "default",
      "enabled": true
    },
    {
      "key": "client_id",
      "value": "⟬uuid#2⟭",
      "type": "default",
      "enabled": true
    },
    {
      "key": "client_secret",
      "value": "⟬opaque_token#1⟭",
      "type": "secret",
      "enabled": true
    },
    {
      "key": "jeton_courant",
      "value": "⟬jwt#1⟭",
      "type": "default",
      "enabled": true
    },
    {
      "key": "var3",
      "value": "⟬iban#2⟭",
      "type": "default",
      "enabled": true
    },
    {
      "key": "var4",
      "value": "⟬person_name#2⟭",
      "type": "default",
      "enabled": true
    },
    {
      "key": "var5",
      "value": "⟬stripe_secret_key#3⟭",
      "type": "default",
      "enabled": false
    },
    {
      "key": "dernier_virement",
      "value": "⟬order_number#1⟭",
      "type": "default",
      "enabled": true
    }
  ],
  "_postman_variable_scope": "environment",
  "_postman_exported_at": "⟬date#1⟭",
  "_postman_exported_using": "Postman/11.2.0"
}
⟬end⟭

⟬template⟭
family: config
format: .json
language: fr
fill_locale: fr_FR
domain: education
appearance: nested JSON, no announcing word
scenario: config.json de Docker sur le poste partagé d'une salle de travaux pratiques, avec l'authentification du registre de l'université
⟬text⟭
{
  "auths": {
    "⟬hostname#1⟭": {
      "auth": "⟬opaque_token#1⟭"
    }
  },
  "credsStore": ""
}
⟬end⟭

⟬template⟭
family: config
format: .jsonc (devcontainer)
language: fr
fill_locale: fr_FR
domain: public administration
appearance: comment, nested JSON, environment reference
scenario: devcontainer.json du dépôt de téléservices d'une agence d'État, commenté pour que les développeurs partent du même environnement sans secret versionné
⟬text⟭
// Environnement de développement commun (JSONC, commentaires autorisés)
{
  "name": "teleservices",
  "image": "mcr.microsoft.com/devcontainers/java:21",
  "forwardPorts": [8080, 5432],
  "features": {
    "ghcr.io/devcontainers/features/node:1": {"version": "20"}
  },
  // les secrets viennent des variables du poste, jamais du dépôt
  "remoteEnv": {
    "DB_PASSWORD": "⟬trap:placeholder|${localEnv:DB_PASSWORD}⟭",
    "OIDC_CLIENT_SECRET": "⟬trap:placeholder|${localEnv:OIDC_CLIENT_SECRET}⟭",
    "SPRING_PROFILES_ACTIVE": "dev",
    "⟬trap:indicator_non_pii|FRANCECONNECT_USER_INFO⟭": "⟬trap:indicator_non_pii|given_name,family_name⟭"
  },
  "customizations": {
    "vscode": {
      "extensions": [
        "vscjava.vscode-java-pack",
        "sonarsource.sonarlint-vscode",
        "⟬trap:library|jebbs⟭.plantuml"
      ],
      "settings": {
        // ⟬trap:library|Lombok⟭ activé pour les DTO
        "java.jdt.ls.lombokSupport.enabled": true,
        "java.format.settings.profile": "⟬trap:eponym|Allman⟭"
      }
    }
  },
  "postCreateCommand": "./mvnw -q -DskipTests install",
  "remoteUser": "⟬trap:indicator_non_pii|vscode⟭"
}
⟬end⟭

⟬template⟭
family: config
format: .toml
language: fr
fill_locale: fr_FR
domain: energy
appearance: comment, TOML value, literal multiline string, array of tables, url
scenario: configuration de l'exportateur OPC UA de l'historien d'une centrale hydraulique, écrite par l'automaticien lors de la modernisation du contrôle commande
⟬text⟭
# Exportateur OPC UA vers l'historien - centrale hydraulique
# Mise en service : ⟬person_name#1⟭ (⟬company#2⟭), le ⟬date#1⟭

[serveur_opc]
endpoint = "opc.tcp://⟬hostname#2⟭:4840"
mode_securite = "SignAndEncrypt"
politique = "Basic256Sha256"
utilisateur = "⟬username#1⟭"
mot_de_passe = "⟬password#1⟭"
certificat_client = "/etc/exportateur/client.der"
cle_client = '''
⟬private_key#1⟭
'''

[historien]
url = "postgresql://historien:⟬url_password#1⟭@⟬hostname#1⟭:5432/historien"
lot_max = 5000
intervalle_ms = 1000
compression = true

[[variables]]
noeud = "ns=2;s=Groupe1.Puissance"
nom = "groupe1_puissance_mw"
bande_morte = 0.05

[[variables]]
noeud = "ns=2;s=Groupe1.Vitesse"
nom = "groupe1_vitesse_tr_min"
bande_morte = 1.0

[[variables]]
noeud = "ns=2;s=Groupe2.Puissance"
nom = "groupe2_puissance_mw"
bande_morte = 0.05

[[variables]]
noeud = "ns=2;s=Vanne.Ouverture"
nom = "vanne_ouverture_pct"
bande_morte = 0.5

[[variables]]
noeud = "ns=2;s=Retenue.Niveau"
nom = "retenue_niveau_ngf"
bande_morte = 0.01

[[variables]]
noeud = "ns=2;s=Turbine.Debit"
nom = "turbine_debit_m3s"
# turbine ⟬trap:eponym|Kaplan⟭ du groupe 1, turbine ⟬trap:eponym|Francis⟭ du groupe 2
bande_morte = 0.2

[[variables]]
noeud = "ns=2;s=Aval.Niveau"
nom = "aval_niveau_ngf"
bande_morte = 0.01

[alarmes]
canal = "centrale-hydro"
jeton = "⟬slack_token#1⟭"
astreinte = "⟬phone#3⟭"
⟬trap:indicator_non_pii|contact_defaut = "exploitation"⟭
⟬end⟭

⟬template⟭
family: config
format: .toml
language: fr
fill_locale: fr_FR
domain: banking
appearance: TOML value, table
scenario: fichier .secrets.toml d'un service de reporting réglementaire en Python, ignoré par erreur par une règle trop étroite du gitignore
⟬text⟭
[production]
SECRET_KEY = "⟬opaque_token#1⟭"
STRIPE_KEY = "⟬stripe_secret_key#1⟭"
COMPTE_FRAIS = "⟬iban#2⟭"
⟬end⟭

⟬template⟭
family: config
format: .toml
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: comment, TOML value, environment reference, table
scenario: settings.toml du banc de test d'un dispositif médical connecté, tenu par l'ingénieur qualité avec des références à l'environnement pour la traçabilité
⟬text⟭
# Banc de test du tensiomètre connecté - paramètres qualifiés (version figée)
[default]
banc = "qualif-02"
langue_rapport = "fr"
tolerance_mmhg = 3
⟬trap:indicator_non_pii|patient_simule = true⟭
⟬trap:indicator_non_pii|nom_patient = "simulateur"⟭

[default.base]
hote = "⟬hostname#1⟭"
utilisateur = "@format {env[BANC_DB_USER]}"
mot_de_passe = "⟬trap:placeholder|@format {env[BANC_DB_PASSWORD]}⟭"

[default.simulateur]
marque = "⟬trap:company_name|⦃Family⦄ Biomédical⟭"
port = "/dev/ttyUSB0"
vitesse = 115200

[default.protocole]
# méthode de ⟬trap:eponym|Korotkoff⟭ comme référence, norme de ⟬trap:eponym|Bland-Altman⟭ pour l'accord
methode = "oscillometrique"
repetitions = 30

[qualification]
signature_rapport = "⟬trap:placeholder|<signature numérique du responsable>⟭"
derniere_validation = "⟬date#1⟭"
⟬end⟭

⟬template⟭
family: config
format: .ini
language: fr
fill_locale: fr_FR
domain: banking
appearance: comment, ini key, section header
scenario: fichier ~/.aws/credentials d'un ingénieur de la plateforme d'une banque en ligne, sauvegardé avec le reste de son répertoire personnel
⟬text⟭
# comptes de la plateforme, voir ⟬person_name:initial#1⟭ pour les droits
[default]
aws_access_key_id = ⟬aws_access_key_id#1⟭
aws_secret_access_key = ⟬aws_secret_access_key#1⟭
region = eu-west-3

[banque-preprod]
aws_access_key_id = ⟬aws_access_key_id#2⟭
aws_secret_access_key = ⟬aws_secret_access_key#2⟭
output = json

[banque-prod-lecture]
aws_access_key_id = ⟬aws_access_key_id#3⟭
aws_secret_access_key = ⟬aws_secret_access_key#3⟭
aws_session_token = ⟬opaque_token#1⟭
⟬end⟭

⟬template⟭
family: config
format: .ini
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: comment, ini key, section header
scenario: pg_service.conf partagé par les analystes du département d'information médicale d'un hôpital pour se connecter aux bases
⟬text⟭
# Services PostgreSQL du DIM
# Compte générique en attendant les comptes nominatifs, voir ⟬person_name#1⟭

[dim_lecture]
host = ⟬hostname#1⟭
port = 5432
dbname = pmsi
user = ⟬username#1⟭
password = ⟬password#1⟭
sslmode = require

[dim_ecriture]
host = ⟬hostname#1⟭
port = 5432
dbname = pmsi
user = ⟬username#2⟭
password = ⟬password#2⟭

[entrepot]
host = ⟬hostname#2⟭
port = 5433
dbname = entrepot
user = ⟬username#1⟭
password = ⟬password#3⟭
⟬end⟭

⟬template⟭
family: config
format: .ini
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: ini key, comment
scenario: pool php-fpm d'une boutique PrestaShop de cosmétiques, où l'hébergeur a mis les variables d'environnement de l'application
⟬text⟭
; pool boutique
[boutique]
user = www-data
listen = /run/php/boutique.sock
pm = dynamic
pm.max_children = 30
env[DB_PASSWORD] = ⟬password#1⟭
env[STRIPE_SK] = ⟬stripe_secret_key#2⟭
env[IBAN_REMBOURSEMENT] = ⟬iban#2⟭
php_admin_value[upload_max_filesize] = 16M
⟬end⟭

⟬template⟭
family: config
format: .properties
language: fr
fill_locale: fr_FR
domain: education
appearance: comment, properties key, url, name in value
scenario: bbb-web.properties de la plateforme de classes virtuelles d'une académie, retouché après chaque mise à jour par l'administrateur et les formateurs
⟬text⟭
# ---------------------------------------------------------
# Classes virtuelles de l'académie
# Maintenance : ⟬person_name#1⟭ ; pédagogie : ⟬person_name#2f⟭
# Dernière mise à jour du serveur le ⟬date#1⟭
# ---------------------------------------------------------

bigbluebutton.web.serverURL=https://⟬hostname#1⟭
securitySalt=⟬opaque_token#1⟭
serviceEnabled=true
supportedChecksumAlgorithms=sha256,sha512

# --- Comportement par défaut des salles ---
defaultMaxUsers=60
defaultMeetingDuration=120
defaultMeetingExpireIfNoUserJoinedInMinutes=5
defaultWelcomeMessage=Bienvenue dans votre classe virtuelle
defaultWelcomeMessageFooter=Assistance : ⟬phone#3⟭ ou ⟬email:generic#3⟭
disableRecordingDefault=true
allowStartStopRecording=false
⟬trap:indicator_non_pii|defaultGuestPolicy=ALWAYS_DENY⟭
⟬trap:indicator_non_pii|allowModsToUnmuteUsers=false⟭
⟬trap:indicator_non_pii|lockSettingsHideUserList=true⟭
⟬trap:indicator_non_pii|userInactivityInspectTimerInMinutes=5⟭
⟬trap:indicator_non_pii|userActivitySignResponseDelayInMinutes=5⟭

# --- Présentation ---
beans.presentationService.defaultUploadedPresentation=${bigbluebutton.web.serverURL}/default.pdf
maxFileSizeUpload=30000000
maxNumPages=200
imageMagickDir=/usr/bin
ghostScriptExec=/usr/bin/gs

# --- Stockage et accès ---
redisHost=⟬hostname#2⟭
redisPort=6379
redisPassword=⟬password#1⟭
recordStatusDir=/var/bigbluebutton/recording/status
publishedDir=/var/bigbluebutton/published
presentationBaseURL=${bigbluebutton.web.serverURL}/bigbluebutton/presentation

# --- Portail de l'académie ---
portail.url=⟬url#1⟭
portail.compte=⟬username#1⟭
portail.mot-de-passe=⟬password#2⟭
portail.contact.responsable=⟬person_name#2f⟭
portail.contact.mail=⟬email#2⟭

# --- Visioconférence ---
endWhenNoModerator=true
endWhenNoModeratorDelayInMinutes=2
meetingExpireWhenLastUserLeftInMinutes=1
maxInactivityTimeoutMinutes=0
warnMinutesBeforeMax=5
muteOnStart=true
allowDuplicateExtUserid=false
webcamsOnlyForModerator=false

# --- Tableau de bord d'usage ---
statistiques.endpoint=https://stats:⟬url_password#1⟭@⟬hostname#3⟭/ingest
statistiques.anonymes=true
⟬trap:indicator_non_pii|statistiques.identifiant.utilisateur=hash⟭
⟬end⟭

⟬template⟭
family: config
format: .properties
language: fr
fill_locale: fr_FR
domain: energy
appearance: properties key, JAAS string
scenario: client.properties Kafka d'un producteur de données de puissance réactive, écrit par un prestataire pour tester la connexion au cluster du distributeur
⟬text⟭
bootstrap.servers=⟬hostname#1⟭:9094
security.protocol=SASL_SSL
sasl.mechanism=SCRAM-SHA-512
sasl.jaas.config=org.apache.kafka.common.security.scram.ScramLoginModule required username="⟬username#1⟭" password="⟬password#1⟭";
ssl.truststore.location=/etc/kafka/truststore.jks
ssl.truststore.password=⟬password#2⟭
⟬end⟭

⟬template⟭
family: config
format: .properties
language: fr
fill_locale: fr_FR
domain: banking
appearance: comment, properties key
scenario: quartz.properties de l'ordonnanceur des traitements de fin de journée d'une caisse de crédit, repris tel quel à chaque nouvelle version
⟬text⟭
# Ordonnanceur des traitements de fin de journée
org.quartz.scheduler.instanceName=FinDeJournee
org.quartz.scheduler.instanceId=AUTO
org.quartz.threadPool.threadCount=8
org.quartz.jobStore.class=org.quartz.impl.jdbcjobstore.JobStoreTX
org.quartz.jobStore.driverDelegateClass=org.quartz.impl.jdbcjobstore.PostgreSQLDelegate
org.quartz.jobStore.dataSource=principal
org.quartz.jobStore.tablePrefix=QRTZ_
org.quartz.jobStore.isClustered=true
org.quartz.jobStore.misfireThreshold=60000
org.quartz.dataSource.principal.jndiURL=java:comp/env/jdbc/fin-journee

# Enchaînement
traitement.1.nom=arrete-comptes
traitement.1.cron=0 15 22 ? * MON-FRI
traitement.2.nom=calcul-agios
traitement.2.cron=0 45 22 ? * MON-FRI
traitement.3.nom=⟬trap:code_identifier|export⦃Family⦄Regul⟭
traitement.3.cron=0 30 23 ? * MON-FRI
⟬trap:indicator_non_pii|traitement.rapport.contact=service-comptable⟭
⟬trap:indicator_non_pii|traitement.compte.iban.masque=true⟭
⟬trap:indicator_non_pii|traitement.user=batch⟭
# méthode de ⟬trap:eponym|Hörner⟭ pour les intérêts composés, arrondi de ⟬trap:eponym|Gauss⟭
traitement.calcul.arrondi=⟬trap:eponym|bankers⟭
⟬end⟭
