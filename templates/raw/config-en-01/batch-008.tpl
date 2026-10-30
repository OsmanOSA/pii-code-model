⟬template⟭
family: config
format: .env
language: en
fill_locale: en_US
domain: fintech
appearance: comment, assignment, quoted value, section header, test fixture
scenario: backoffice env of a neobank in its first year, in which sandbox fixtures, partner keys and a partner bank contact's mobile number have piled up over time
⟬text⟭
### neobank-backoffice ###
# sandbox unless stated otherwise
# partner bank escalations: ⟬person_name#1⟭ (⟬job_title#1⟭), ⟬phone#1⟭

APP_ENV=sandbox
APP_SECRET=⟬opaque_token#1⟭
ADMIN_ALLOWED_IPS=⟬ip_address#1⟭,⟬ip_address#2⟭
ADMIN_SSO_ISSUER=⟬url#1⟭
⟬trap:indicator_non_pii|ADMIN_SESSION_TOKEN_MINUTES=20⟭

### card program
CARD_API_BASE=⟬url#2⟭
CARD_API_USER=⟬username#1⟭
CARD_API_PASS='⟬password#1⟭'
CARD_PRODUCT_ID=⟬uuid#1⟭
CARD_WEBHOOK_SIG=⟬opaque_token#2⟭

### payments
STRIPE_SECRET_KEY=⟬stripe_secret_key#1⟭
STRIPE_PUBLISHABLE_KEY=⟬stripe_publishable_key#1⟭
PLAID_CLIENT_ID=⟬hash#1⟭
PLAID_SECRET=⟬opaque_token#3⟭
PLAID_ENV=sandbox
⟬trap:indicator_non_pii|ACH_SAME_DAY_CUTOFF=14:45⟭

### sandbox fixtures, used by seed.ts
FIXTURE_HOLDER="⟬person_name#2⟭"
FIXTURE_DOB="⟬birth_date#2⟭"
FIXTURE_SSN="⟬us_ssn#2⟭"
FIXTURE_ADDRESS="⟬postal_address#2⟭"
FIXTURE_OPENED="⟬date#1⟭"
FIXTURE_ACCOUNT="⟬bank_account_number#2⟭"
FIXTURE_CARD="⟬payment_card#2⟭"
FIXTURE_CVC="⟬card_security_code#2⟭"

### compliance copilot
OPENAI_API_KEY=⟬openai_api_key#1⟭
SAR_DRAFT_MODEL=gpt-4.1
⟬trap:indicator_non_pii|SAR_REVIEWER_REQUIRED=true⟭

### infra
AWS_REGION=us-east-1
DATABASE_URL=postgres://backoffice:⟬url_password#1⟭@⟬hostname#1⟭:5432/backoffice
AUDIT_LOG_BUCKET=neobank-audit-sandbox
### limits
DAILY_ACH_LIMIT_CENTS=500000
DAILY_WIRE_LIMIT_CENTS=2500000
INSTANT_TRANSFER_FEE_BPS=150
FRAUD_SCORE_HOLD=720
FRAUD_SCORE_BLOCK=880
MANUAL_REVIEW_OWNER="⟬person_name#4⟭"

### comms
SENDGRID_API_KEY=⟬sendgrid_api_key#1⟭
STATEMENT_FROM=⟬email:generic#3⟭
TWILIO_ACCOUNT_KEY=⟬opaque_token#4⟭
SUPPORT_LINE="⟬phone#3⟭"

### release
GIT_SHA=⟬git_sha#1⟭
GITHUB_TOKEN=⟬github_token#1⟭
DOCKER_TAG=⟬version#1⟭
⟬end⟭

⟬template⟭
family: config
format: .env
language: en
fill_locale: en_US
domain: healthcare
appearance: assignment, comment
scenario: env of a dictation transcription worker for a small practice, written by the clinic's part-time IT person
⟬text⟭
HF_TOKEN=⟬huggingface_token#1⟭
ASR_MODEL=openai/whisper-large-v3
OUTPUT_DIR=/srv/dictation/out
# on-prem only, no audio leaves the box
⟬trap:indicator_non_pii|PHI_REDACTION=on⟭
SMB_PASS=⟬password#1⟭
⟬end⟭

⟬template⟭
family: config
format: .env
language: en
fill_locale: en_US
domain: logistics
appearance: comment, assignment, quoted value, test fixture
scenario: driver onboarding service env, with a seed driver for demos to the carrier relations team and the map key used in the app
⟬text⟭
# driver-onboarding
PUBLIC_URL=https://⟬hostname#1⟭
MAPS_API_KEY=⟬google_api_key#1⟭
BACKGROUND_CHECK_URL=⟬url#1⟭
BACKGROUND_CHECK_TOKEN=⟬jwt#1⟭
⟬trap:indicator_non_pii|LICENSE_EXPIRY_WARNING_DAYS=60⟭
⟬trap:indicator_non_pii|DRIVER_NAME_FORMAT=last_first⟭

# demo driver, shows up in the carrier relations walkthrough
DEMO_DRIVER="⟬person_name#2⟭"
DEMO_DRIVER_DOB="⟬birth_date#2⟭"
DEMO_DRIVER_CDL="⟬us_driver_license#2⟭"
DEMO_DRIVER_PHONE="⟬phone#2⟭"
DEMO_TRUCK_PLATE="⟬us_license_plate#2⟭"
DEMO_HIRED_ON="⟬date#1⟭"
DEMO_HOME_TERMINAL="⟬city#2⟭"
⟬end⟭

⟬template⟭
family: config
format: Terraform .tfvars
language: en
fill_locale: en_US
domain: retail
appearance: comment, assignment, map value, list item
scenario: GKE and DNS inputs of a store locator platform, where the Places API key and the GitLab deploy token were added during a demo
⟬text⟭
# store-locator, GCP
project    = "storelocator-prod-4471"
region     = "us-central1"
gke_name   = "storelocator"
node_count = 4
node_type  = "e2-standard-4"

cloudflare_zone_id   = "⟬hash#1⟭"
cloudflare_api_token = "⟬opaque_token#1⟭"
public_hostnames     = ["⟬hostname#1⟭", "⟬hostname#2⟭"]

# frontend places lookups, restricted to the site referrer. was unrestricted during the demo
places_api_key = "⟬google_api_key#1⟭"

gitlab_deploy_token_user = "⟬username#1⟭"
gitlab_deploy_token      = "⟬gitlab_token#1⟭"

store_sync = {
  sendgrid_key = "⟬sendgrid_api_key#1⟭"
  report_to    = "⟬email#2⟭"
  schedule     = "0 5 * * *"
}

hq_address = "⟬postal_address#3⟭"

tags = {
  owner = "⟬email#2⟭"
  env   = "prod"
}
⟬end⟭

⟬template⟭
family: config
format: Terraform .tfvars
language: en
fill_locale: en_US
domain: healthcare
appearance: comment, assignment, heredoc
scenario: mutual TLS settings for a payer connection, with the client key pasted as a heredoc by the integration engineer
⟬text⟭
# payer-edi mTLS
payer_endpoint  = "https://⟬hostname#1⟭:9443/x12"
sender_id       = "CLINIC0417"
partner_contact = "⟬person_name#2⟭, ⟬phone#2⟭"

client_private_key = <<EOT
⟬private_key#1⟭
EOT
⟬end⟭

⟬template⟭
family: config
format: Kubernetes .yaml
language: en
fill_locale: en_US
domain: fintech
appearance: block scalar, YAML value, comment, annotation
scenario: signing key Secret and webhook verifier of a card network connector, applied by hand during an incident and exported back to Git
⟬text⟭
# kubectl get secret -o yaml, cleaned by hand after the incident on ⟬date#1⟭
apiVersion: v1
kind: Secret
metadata:
  name: network-signing
  namespace: card-connector
  annotations:
    kubectl.kubernetes.io/last-applied-by: ⟬person_name:handle#1⟭
type: Opaque
stringData:
  signing-key.pem: |
    ⟬private_key#1⟭
  webhook-hmac: ⟬opaque_token#1⟭
  stripe-restricted: ⟬stripe_secret_key#1⟭
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: network-endpoints
  namespace: card-connector
data:
  AUTH_URL: ⟬url#1⟭
  CLEARING_URL: ⟬url#2⟭
  ⟬trap:indicator_non_pii|PAN_LOG_MASK: "first6last4"⟭
  ⟬trap:indicator_non_pii|CVV_RETENTION: none⟭
⟬end⟭

⟬template⟭
family: config
format: Kubernetes .yaml
language: en
fill_locale: en_US
domain: media
appearance: comment, YAML value, nested map, block scalar, list item
scenario: search stack values of a publisher's content API, written by the search engineer with the master key and embedding provider inline
⟬text⟭
# content-search umbrella chart, prod
global:
  storageClass: gp3
  domain: ⟬hostname#1⟭

meilisearch:
  image:
    tag: v1.10
  environment:
    MEILI_ENV: production
    MEILI_MASTER_KEY: ⟬opaque_token#1⟭
    MEILI_NO_ANALYTICS: "true"
  persistence:
    enabled: true
    size: 100Gi

indexer:
  replicaCount: 2
  image:
    repository: ⟬hostname#2⟭/content/indexer
    tag: ⟬version#1⟭
  schedule: "*/10 * * * *"
  env:
    CMS_API_URL: ⟬url#1⟭
    CMS_API_TOKEN: ⟬jwt#1⟭
    EMBEDDINGS_PROVIDER: openai
    OPENAI_API_KEY: ⟬openai_api_key#1⟭
    RERANK_MODEL: cross-encoder/ms-marco-MiniLM-L-6-v2
    HF_TOKEN: ⟬huggingface_token#1⟭
  filters: |
    # stopwords and synonyms, edited by the editors
    synonyms:
      film: [movie, picture]
      ⟬trap:word_name|Jordan⟭: [country, kingdom]
    # authors are stored by id, the byline is resolved at read time
    ⟬trap:indicator_non_pii|author_field: byline_id⟭

digest:
  enabled: true
  sendgridApiKey: ⟬sendgrid_api_key#1⟭
  fromAddress: ⟬email:generic#3⟭
  editor: ⟬person_name#4⟭
  editorEmail: ⟬email#4⟭

ingress:
  enabled: true
  annotations:
    nginx.ingress.kubernetes.io/ssl-redirect: "true"
  hosts:
    - ⟬hostname#1⟭

resources:
  limits:
    cpu: "4"
    memory: 16Gi
  requests:
    cpu: "2"
    memory: 8Gi

nodeSelector:
  workload: search

podAnnotations:
  prometheus.io/scrape: "true"
⟬end⟭

⟬template⟭
family: config
format: Kubernetes .yaml
language: en
fill_locale: en_US
domain: SaaS
appearance: YAML value, comment
scenario: cert-manager ClusterIssuer of a small platform team, with a static Route 53 key id and the administrator's address for ACME notices
⟬text⟭
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-prod
spec:
  acme:
    server: https://acme-v02.api.letsencrypt.org/directory
    email: ⟬email#1⟭
    privateKeySecretRef:
      name: ⟬trap:indicator_non_pii|letsencrypt-account-key⟭
    solvers:
      - dns01:
          route53:
            region: us-east-1
            accessKeyID: ⟬aws_access_key_id#2⟭
            secretAccessKeySecretRef:
              name: ⟬trap:indicator_non_pii|route53-credentials⟭
              key: secret-access-key
⟬end⟭

⟬template⟭
family: config
format: docker-compose.yml
language: en
fill_locale: en_US
domain: media
appearance: environment list, YAML value, comment, quoted value
scenario: WordPress site of a community radio station, stood up by a volunteer with auth salts pasted from the generator page
⟬text⟭
# kxrd site, volunteer maintained
services:
  wordpress:
    image: wordpress:6.6-php8.2-apache
    restart: always
    ports:
      - "8080:80"
    environment:
      WORDPRESS_DB_HOST: db
      WORDPRESS_DB_USER: wp
      WORDPRESS_DB_PASSWORD: "⟬password#1⟭"
      WORDPRESS_DB_NAME: kxrd
      WORDPRESS_AUTH_KEY: "⟬opaque_token#1⟭"
      WORDPRESS_SECURE_AUTH_KEY: "⟬opaque_token#2⟭"
      WORDPRESS_LOGGED_IN_KEY: "⟬opaque_token#3⟭"
      WORDPRESS_NONCE_KEY: "⟬opaque_token#4⟭"
      WORDPRESS_CONFIG_EXTRA: |
        define('WP_MAIL_FROM', '⟬email:generic#2⟭');
        define('SENDGRID_API_KEY', '⟬sendgrid_api_key#1⟭');
    volumes:
      - ./wp-content:/var/www/html/wp-content

  db:
    image: mariadb:11.4
    environment:
      MARIADB_DATABASE: kxrd
      MARIADB_USER: wp
      MARIADB_PASSWORD: "⟬password#1⟭"
      MARIADB_RANDOM_ROOT_PASSWORD: "1"
    volumes:
      - ./mysql:/var/lib/mysql
⟬end⟭

⟬template⟭
family: config
format: docker-compose.yml
language: en
fill_locale: en_US
domain: logistics
appearance: comment, YAML value, list item, interpolation
scenario: routing engines for a last-mile planning team, running on public map extracts with no sign-in of any kind
⟬text⟭
# Route planning engines, built from public OpenStreetMap extracts.
# ./data is filled by scripts/fetch-extracts.sh
services:
  osrm:
    image: ghcr.io/project-osrm/osrm-backend:v5.27.1
    command: osrm-routed --algorithm mld /data/us-midwest.osrm
    volumes:
      - ./data:/data
    ports:
      - "5000:5000"

  valhalla:
    image: ghcr.io/gis-ops/docker-valhalla/valhalla:3.5.0
    environment:
      - tile_urls=https://download.geofabrik.de/north-america/us-midwest-latest.osm.pbf
      - use_tiles_ignore_pbf=True
      - server_threads=4
      - min_x=-104.1
    ports:
      - "8002:8002"

  nominatim:
    image: mediagis/nominatim:4.4
    environment:
      PBF_URL: https://download.geofabrik.de/north-america/us-midwest-latest.osm.pbf
      REPLICATION_URL: https://download.geofabrik.de/north-america/us-midwest-updates/
      NOMINATIM_PASSWORD: ⟬trap:placeholder|${NOMINATIM_DB_PASSWORD:?see README}⟭
      ⟬trap:indicator_non_pii|IMPORT_STYLE: address⟭
    shm_size: 1gb
    ports:
      - "8088:8080"

  planner-ui:
    image: ⟬hostname#1⟭/planning/ui:⟬version#1⟭
    environment:
      ROUTER_URL: http://osrm:5000
      # time windows use a ⟬trap:eponym|Clarke-Wright⟭ savings seed
      DEFAULT_SOLVER: savings
      ⟬trap:indicator_non_pii|API_KEY_REQUIRED: "false"⟭
    ports:
      - "8090:80"
⟬end⟭

⟬template⟭
family: config
format: .json
language: en
fill_locale: en_US
domain: healthcare
appearance: nested JSON, string value
scenario: pm2 ecosystem file of a benefits verification worker, with production values typed directly into env_production
⟬text⟭
{
  "apps": [
    {
      "name": "eligibility-worker",
      "script": "dist/worker.js",
      "instances": 4,
      "exec_mode": "cluster",
      "max_memory_restart": "512M",
      "env": {
        "NODE_ENV": "development"
      },
      "env_production": {
        "NODE_ENV": "production",
        "CLEARINGHOUSE_URL": "⟬url#1⟭",
        "CLEARINGHOUSE_TOKEN": "⟬jwt#1⟭",
        "ANTHROPIC_API_KEY": "⟬anthropic_api_key#1⟭",
        "REDIS_URL": "redis://:⟬url_password#1⟭@⟬hostname#1⟭:6379",
        "ON_FAILURE_EMAIL": "⟬email#2⟭"
      }
    }
  ]
}
⟬end⟭

⟬template⟭
family: config
format: .json
language: en
fill_locale: en_US
domain: fintech
appearance: nested JSON, string value
scenario: custom-environment-variables.json of a Node service, mapping secret-looking settings to the names of environment variables
⟬text⟭
{
  "port": "PORT",
  "db": {
    "host": "DB_HOST",
    "⟬trap:indicator_non_pii|user⟭": "DB_USER",
    "⟬trap:indicator_non_pii|password⟭": "DB_PASSWORD",
    "ssl": {
      "__name": "DB_SSL",
      "__format": "boolean"
    }
  },
  "ach": {
    "⟬trap:indicator_non_pii|apiKey⟭": "ACH_API_KEY",
    "⟬trap:indicator_non_pii|webhookSecret⟭": "ACH_WEBHOOK_SECRET",
    "baseUrl": "ACH_BASE_URL"
  },
  "jwt": {
    "⟬trap:indicator_non_pii|privateKey⟭": "JWT_PRIVATE_KEY",
    "⟬trap:indicator_non_pii|publicKey⟭": "JWT_PUBLIC_KEY",
    "ttlSeconds": {
      "__name": "JWT_TTL_SECONDS",
      "__format": "number"
    }
  },
  "mail": {
    "⟬trap:indicator_non_pii|sendgridApiKey⟭": "SENDGRID_API_KEY",
    "⟬trap:indicator_non_pii|fromAddress⟭": "MAIL_FROM"
  },
  "logging": {
    "level": "LOG_LEVEL"
  }
}
⟬end⟭

⟬template⟭
family: config
format: .json
language: en
fill_locale: en_US
domain: SaaS
appearance: nested JSON, string value
scenario: auth cache of a command line coding assistant, copied along with a home directory backup into a shared bucket
⟬text⟭
{
  "OPENAI_API_KEY": "⟬openai_api_key#1⟭",
  "tokens": {
    "id_token": "⟬jwt#1⟭",
    "access_token": "⟬jwt#2⟭",
    "refresh_token": "⟬opaque_token#1⟭",
    "account_id": "⟬uuid#1⟭"
  },
  "last_refresh": "⟬date#1⟭"
}
⟬end⟭

⟬template⟭
family: config
format: .toml
language: en
fill_locale: en_US
domain: retail
appearance: comment, section header, string value, inline table
scenario: Cargo workspace manifest of a shelf label firmware team, using a team name for authors and a long dependency table
⟬text⟭
[workspace]
members = ["crates/esl-core", "crates/esl-radio", "crates/esl-cli"]
resolver = "2"

[workspace.package]
version = "⟬version#1⟭"
edition = "2021"
authors = ["⟬trap:indicator_non_pii|Shelf Labels Team⟭"]
license = "Proprietary"
repository = "⟬url#1⟭"

[workspace.dependencies]
embassy-executor = "0.6"
embassy-time = "0.3"
⟬trap:library|serde⟭ = { version = "1.0", features = ["derive"] }
postcard = "1.0"
heapless = "0.8"
crc = "3.2"
⟬trap:library|clap⟭ = { version = "4.5", features = ["derive"] }

[profile.release]
opt-level = "z"
lto = "fat"
codegen-units = 1
panic = "abort"

# radio frames carry ⟬trap:eponym|Reed-Solomon⟭ parity, see crates/esl-radio/src/fec.rs
[workspace.metadata.radio]
parity_bytes = 8
⟬trap:indicator_non_pii|pairing_token_bits = 128⟭
⟬trap:indicator_non_pii|owner = "store-hardware"⟭
⟬end⟭

⟬template⟭
family: config
format: .toml
language: en
fill_locale: en_US
domain: healthcare
appearance: comment, section header, string value, array of tables
scenario: production settings of a medical coding assistant, with database, model keys and the clinical reviewers who receive low-confidence charts
⟬text⟭
# config.prod.toml, medcode-assist
[server]
bind = "0.0.0.0:8080"
workers = 8

[database]
url = "postgresql://medcode:⟬url_password#1⟭@⟬hostname#1⟭:5432/medcode"
pool = 20

[model]
primary = "claude-sonnet-5-5"
anthropic_key = "⟬anthropic_api_key#1⟭"
fallback = "gpt-4.1"
openai_key = "⟬openai_api_key#1⟭"
confidence_floor = 0.8

[storage]
charts_bucket = "medcode-charts"
access_key = "⟬aws_access_key_id#1⟭"
secret_key = "⟬aws_secret_access_key#1⟭"

[logging]
level = "info"
format = "json"
⟬trap:indicator_non_pii|redact_patient_name = true⟭
⟬trap:indicator_non_pii|redact_dob = true⟭

[coding]
code_sets = ["ICD-10-CM", "CPT", "HCPCS"]
max_codes_per_chart = 25
query_physician_below = 0.6
specialties_enabled = ["cardiology", "pulmonology", "orthopedics", "oncology"]

[encoder]
base_url = "⟬url#1⟭"
license_key = "⟬opaque_token#1⟭"
timeout_seconds = 20

[ehr]
fhir_base = "⟬url#2⟭"
client_id = "⟬uuid#1⟭"
client_secret = "⟬opaque_token#2⟭"
scopes = ["patient/DocumentReference.read", "patient/Encounter.read"]

[notifications]
sender = "⟬email:generic#4⟭"
sendgrid_key = "⟬sendgrid_api_key#1⟭"
digest_cron = "0 7 * * 1-5"

[audit]
bucket = "medcode-audit"
retention_days = 2555
[[reviewers]]
name = "⟬person_name#2⟭"
credential = "RHIT"
email = "⟬email#2⟭"
specialties = ["cardiology", "pulmonology"]

[[reviewers]]
name = "⟬person_name#3⟭"
credential = "CPC"
email = "⟬email#3⟭"
specialties = ["orthopedics"]
⟬end⟭

⟬template⟭
family: config
format: .npmrc
language: en
fill_locale: en_US
domain: retail
appearance: assignment, comment, url
scenario: marketing site .npmrc with a paid animation library registry, the agency's author defaults and an automation token
⟬text⟭
init-author-name=⟬person_name#1⟭
init-author-email=⟬email#1⟭
⟬trap:email_lookalike|@gsap:registry⟭=https://npm.greensock.com
//npm.greensock.com/:_authToken=⟬opaque_token#1⟭
//registry.npmjs.org/:_authToken=⟬npm_token#1⟭
; ci installs with --omit=dev
omit=dev
⟬end⟭

⟬template⟭
family: config
format: .npmrc
language: en
fill_locale: en_US
domain: SaaS
appearance: comment, assignment
scenario: end-to-end publish tests of a package manager plugin against a local Verdaccio, where the auth token is a documented fake
⟬text⟭
# Used by test/e2e only: publishes to the throwaway Verdaccio on port 4873.
registry=http://localhost:4873/
//localhost:4873/:_authToken=⟬trap:placeholder|fake⟭
⟬trap:email_lookalike|@e2e:registry⟭=http://localhost:4873/
⟬trap:indicator_non_pii|otp=000000⟭
fetch-retries=0
audit=false
update-notifier=false
package-lock=false
⟬end⟭

⟬template⟭
family: config
format: .ini
language: en
fill_locale: en_US
domain: fintech
appearance: section header, assignment, comment
scenario: odbc.ini on a treasury workstation with two data sources, the password of one kept in the file for a scheduled Excel refresh
⟬text⟭
[ODBC Data Sources]
TreasuryDW=ODBC Driver 18 for SQL Server
PositionsRO=ODBC Driver 18 for SQL Server

[TreasuryDW]
Driver=ODBC Driver 18 for SQL Server
Server=⟬hostname#1⟭,1433
Database=TreasuryDW
Encrypt=yes
Trusted_Connection=no
UID=svc_treasury_xl
; needed for the 6am refresh
PWD=⟬password#1⟭

[PositionsRO]
Driver=ODBC Driver 18 for SQL Server
Server=⟬hostname#2⟭,1433
Database=Positions
Trusted_Connection=yes
⟬end⟭

⟬template⟭
family: config
format: .ini
language: en
fill_locale: en_US
domain: SaaS
appearance: section header, assignment, comment
scenario: php.ini overrides of a forum hosting product, where the default database credentials are deliberately left empty
⟬text⟭
[PHP]
engine = On
short_open_tag = Off
memory_limit = 256M
post_max_size = 32M
upload_max_filesize = 32M
max_execution_time = 60
display_errors = Off
log_errors = On
error_log = /var/log/php/error.log
expose_php = Off

[Date]
date.timezone = UTC

[MySQLi]
mysqli.allow_persistent = On
mysqli.default_port = 3306
mysqli.default_host =
⟬trap:indicator_non_pii|mysqli.default_user =⟭
⟬trap:indicator_non_pii|mysqli.default_pw =⟭

[Session]
session.save_handler = redis
session.save_path = "tcp://⟬hostname#1⟭:6379"
session.use_strict_mode = 1
session.cookie_httponly = 1
⟬trap:indicator_non_pii|session.name = FORUMSESSID⟭
⟬trap:indicator_non_pii|session.gc_maxlifetime = 1440⟭

[opcache]
opcache.enable = 1
opcache.memory_consumption = 128
opcache.validate_timestamps = 0

[mail function]
⟬trap:indicator_non_pii|mail.add_x_header = Off⟭
sendmail_path = /usr/sbin/sendmail -t -i
⟬end⟭

⟬template⟭
family: config
format: .ini
language: en
fill_locale: en_US
domain: retail
appearance: comment, section header, assignment, connection string
scenario: airflow.cfg of a merchandising data team, generated with defaults and then edited in place for mail and the metadata database
⟬text⟭
[core]
dags_folder = /opt/airflow/dags
executor = LocalExecutor
fernet_key = ⟬opaque_token#1⟭
load_examples = False
parallelism = 16

[database]
sql_alchemy_conn = postgresql+psycopg2://airflow:⟬url_password#1⟭@⟬hostname#1⟭:5432/airflow

[webserver]
base_url = https://⟬hostname#2⟭
secret_key = ⟬opaque_token#2⟭
workers = 4
⟬trap:indicator_non_pii|expose_config = False⟭

[smtp]
smtp_host = smtp.sendgrid.net
smtp_starttls = True
smtp_port = 587
⟬trap:indicator_non_pii|smtp_user = apikey⟭
smtp_password = ⟬sendgrid_api_key#1⟭
smtp_mail_from = ⟬email:generic#3⟭

[email]
email_backend = airflow.utils.email.send_email_smtp
email_conn_id = smtp_default
default_email_on_retry = False
default_email_on_failure = True

[scheduler]
min_file_process_interval = 60
dag_dir_list_interval = 120
catchup_by_default = False
max_tis_per_query = 64

[api]
auth_backends = airflow.api.auth.backend.session
maximum_page_limit = 100

[logging]
base_log_folder = /opt/airflow/logs
remote_logging = True
remote_base_log_folder = s3://merch-airflow-logs
logging_level = INFO
fab_logging_level = WARN

[metrics]
statsd_on = True
statsd_host = ⟬hostname#4⟭
statsd_port = 8125
statsd_prefix = airflow

[celery]
worker_concurrency = 8

[sensors]
default_timeout = 3600

[secrets]
backend = airflow.secrets.local_filesystem.LocalFilesystemBackend

[kubernetes_executor]
namespace = merchandising
delete_worker_pods = True
⟬end⟭
