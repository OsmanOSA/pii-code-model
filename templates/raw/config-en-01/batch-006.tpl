⟬template⟭
family: config
format: .env
language: en
fill_locale: en_US
domain: fintech
appearance: comment, assignment, section header
scenario: defaults file of a KYC orchestration service, committed on purpose and overridden at deploy time by the secrets manager
⟬text⟭
# kyc-orchestrator defaults. Safe to commit: anything sensitive is injected at deploy time.
SERVICE_NAME=kyc-orchestrator
HTTP_PORT=8080
GRPC_PORT=9090
LOG_LEVEL=info

# Vendor routing
PRIMARY_VENDOR=vendor_a
FALLBACK_VENDOR=vendor_b
VENDOR_TIMEOUT_MS=4500
VENDOR_API_KEY=⟬trap:placeholder|injected-at-deploy⟭
⟬trap:indicator_non_pii|VENDOR_API_KEY_HEADER=X-Vendor-Key⟭

# Decisions
⟬trap:indicator_non_pii|NAME_MATCH_THRESHOLD=0.86⟭
⟬trap:indicator_non_pii|DOB_TOLERANCE_DAYS=0⟭
⟬trap:indicator_non_pii|SSN_LAST4_ONLY=true⟭
# fuzzy matching is ⟬trap:eponym|Jaro-Winkler⟭ on folded names
NAME_MATCH_ALGO=jaro_winkler
MANUAL_REVIEW_QUEUE=kyc-review

# Persistence
DB_HOST=⟬hostname#1⟭
DB_NAME=kyc
⟬trap:indicator_non_pii|DB_USER=kyc_svc⟭
DB_PASSWORD=⟬trap:placeholder|${VAULT_DB_PASSWORD}⟭
RETENTION_DAYS=1825
⟬end⟭

⟬template⟭
family: config
format: .env
language: en
fill_locale: en_US
domain: SaaS
appearance: export statement, comment, quoted value
scenario: shell-sourced env of a helpdesk product's staging box, kept in the deploy user's home with export on every line
⟬text⟭
# source ~/helpdesk-staging.env before running bin/deploy
export RAILS_ENV=staging
export HOST=⟬hostname#1⟭
export SENDGRID_API_KEY=⟬sendgrid_api_key#1⟭
export INBOUND_PARSE_ROUTE=⟬opaque_token#1⟭
export NPM_TOKEN=⟬npm_token#1⟭
export HF_TOKEN=⟬huggingface_token#1⟭
export TRIAGE_MODEL=distilbert-base-uncased
export OPENAI_API_KEY="⟬openai_api_key#1⟭"
export ⟬trap:indicator_non_pii|AGENT_NAME_DEFAULT=Unassigned⟭
# pager for the staging box: ⟬person_name#2⟭, ⟬phone#2⟭
export GIT_SHA=⟬git_sha#1⟭
⟬end⟭

⟬template⟭
family: config
format: Terraform .tfvars
language: en
fill_locale: en_US
domain: healthcare
appearance: comment, assignment, map value, list item
scenario: Cloud Run variables of a prior authorization assistant, prepared by a contractor who listed the notification recipients by name
⟬text⟭
# prior-auth-assistant, GCP
# last one that worked in staging: ⟬opaque_token#1⟭
project_id = "priorauth-assist-prod"
region     = "us-central1"
service    = "prior-auth-assistant"
image      = "⟬hostname#1⟭/priorauth/assistant:⟬version#1⟭"

min_instances = 1
max_instances = 20
concurrency   = 40
cpu           = "2"
memory        = "2Gi"

env_vars = {
  OPENAI_API_KEY    = "⟬openai_api_key#1⟭"
  HF_TOKEN          = "⟬huggingface_token#1⟭"
  SENDGRID_API_KEY  = "⟬sendgrid_api_key#1⟭"
  PAYER_PORTAL_URL  = "⟬url#1⟭"
  PAYER_PORTAL_USER = "⟬username#1⟭"
  PAYER_PORTAL_PASS = "⟬password#1⟭"
  ⟬trap:indicator_non_pii|MEMBER_ID_MASK    = "last4"⟭
}

notification_recipients = [
  "⟬person_name#2⟭ <⟬email#2⟭>",
  "⟬person_name#3⟭ <⟬email#3⟭>",
  "⟬email:generic#4⟭",
]

vpc_connector = "projects/priorauth-assist-prod/locations/us-central1/connectors/egress"
⟬end⟭

⟬template⟭
family: config
format: Terraform .tfvars
language: en
fill_locale: en_US
domain: media
appearance: comment, assignment, object list, map value
scenario: CDN and cache behaviors of a sports streaming service, tuned before the playoffs by the delivery team
⟬text⟭
# edge-delivery / production
# No credentials here: the origin shared secret comes from Secrets Manager.
distribution_comment = "live-sports-prod"
default_root_object  = "index.html"
http_version         = "http2and3"
price_class          = "PriceClass_All"

aliases = ["⟬hostname#1⟭", "⟬hostname#2⟭"]
origin_shield_region = "us-east-1"

origins = [
  {
    id          = "packager"
    domain_name = "⟬hostname#3⟭"
    path        = "/live"
    protocol    = "https-only"
  },
  {
    id          = "vod"
    domain_name = "⟬hostname#4⟭"
    path        = ""
    protocol    = "https-only"
  },
]

cache_behaviors = [
  { path = "/live/*.m3u8", ttl = 2,     origin = "packager", compress = false },
  { path = "/live/*.m4s",  ttl = 3600,  origin = "packager", compress = false },
  { path = "/vod/*",       ttl = 86400, origin = "vod",      compress = false },
  { path = "/api/*",       ttl = 0,     origin = "packager", compress = true },
]

⟬trap:indicator_non_pii|signed_url_token_ttl = 21600⟭
⟬trap:indicator_non_pii|token_auth_header    = "X-Edge-Token"⟭
⟬trap:indicator_non_pii|viewer_address_logging = "truncated"⟭

geo_restriction = {
  type      = "whitelist"
  locations = ["US", "CA", "MX"]
}

# league feed partner, not a person
playoff_channel = "⟬trap:company_name|⦃Family⦄ Sports Network⟭"
log_bucket      = "edge-logs-prod"
sampling_rate   = 5
⟬end⟭

⟬template⟭
family: config
format: Terraform .tfvars
language: en
fill_locale: en_US
domain: logistics
appearance: assignment, comment
scenario: database and mail inputs of a cross-dock booking app, filled once by the founder and forgotten in a shared folder
⟬text⟭
rds_master_username = "⟬username#1⟭"
rds_master_password = "⟬password#1⟭"
sendgrid_key        = "⟬sendgrid_api_key#1⟭"
# for the private ui kit during the codebuild step
npm_auth_token      = "⟬npm_token#1⟭"
alarm_phone         = "⟬phone#2⟭"
⟬end⟭

⟬template⟭
family: config
format: Kubernetes .yaml
language: en
fill_locale: en_US
domain: retail
appearance: block scalar, comment, YAML value, url
scenario: in-cluster image builder of a merchandising team, whose ConfigMap carries a full .npmrc and pip.conf into a Kaniko pod
⟬text⟭
apiVersion: v1
kind: ConfigMap
metadata:
  name: builder-registries
  namespace: ci
data:
  .npmrc: |
    registry=https://registry.npmjs.org/
    //registry.npmjs.org/:_authToken=⟬npm_token#1⟭
    //npm.pkg.github.com/:_authToken=⟬github_token#1⟭
  pip.conf: |
    [global]
    index-url = https://build:⟬url_password#1⟭@⟬hostname#1⟭/simple
    timeout = 30
---
apiVersion: v1
kind: Pod
metadata:
  name: kaniko-merch-api
  namespace: ci
  labels:
    owner: ⟬person_name:handle#4⟭
spec:
  restartPolicy: Never
  containers:
    - name: kaniko
      image: gcr.io/kaniko-project/executor:v1.23.2
      args:
        - --dockerfile=Dockerfile
        - --context=git://⟬hostname#2⟭/merch/api.git#refs/heads/main
        - --destination=⟬hostname#3⟭/merch/api:⟬git_sha#1⟭
      volumeMounts:
        - name: registries
          mountPath: /kaniko/config
  volumes:
    - name: registries
      configMap:
        name: builder-registries
⟬end⟭

⟬template⟭
family: config
format: Kubernetes .yaml
language: en
fill_locale: en_US
domain: fintech
appearance: block scalar, comment, YAML value
scenario: kubeconfig stored in a Secret so that a reconciliation job can reach a second cluster, exported from a laptop by the on-call engineer
⟬text⟭
apiVersion: v1
kind: Secret
metadata:
  name: recon-remote-kubeconfig
  namespace: reconciliation
type: Opaque
stringData:
  config: |
    apiVersion: v1
    kind: Config
    current-context: recon-east
    clusters:
      - name: recon-east
        cluster:
          server: https://⟬hostname#1⟭:6443
    contexts:
      - name: recon-east
        context:
          cluster: recon-east
          user: recon-job
    users:
      - name: recon-job
        user:
          token: ⟬jwt#1⟭
  llm-summary.env: |
    OPENAI_API_KEY=⟬openai_api_key#1⟭
    SUMMARY_RECIPIENT=⟬email#2⟭
⟬end⟭

⟬template⟭
family: config
format: Kubernetes .yaml
language: en
fill_locale: en_US
domain: logistics
appearance: comment, YAML value, nested map, list item, connection string
scenario: Airflow chart values of a demand forecasting team, with connection URIs, a default admin user and provider keys all pasted into one values file
⟬text⟭
# airflow values, forecasting cluster
# helm upgrade airflow apache-airflow/airflow -n forecasting -f values.yaml
executor: KubernetesExecutor

images:
  airflow:
    repository: ⟬hostname#1⟭/forecast/airflow
    tag: ⟬version#1⟭

webserverSecretKey: ⟬opaque_token#1⟭
fernetKey: ⟬opaque_token#2⟭

webserver:
  replicas: 2
  defaultUser:
    enabled: true
    role: Admin
    username: ⟬person_name:handle#2⟭
    email: ⟬email#2⟭
    firstName: ⟬person_name:given#2⟭
    lastName: ⟬person_name:family#2⟭
    password: "⟬password#1⟭"

env:
  - name: AIRFLOW__CORE__LOAD_EXAMPLES
    value: "False"
  - name: AIRFLOW__SMTP__SMTP_HOST
    value: smtp.sendgrid.net
  - name: ⟬trap:indicator_non_pii|AIRFLOW__SMTP__SMTP_USER⟭
    value: apikey
  - name: AIRFLOW__SMTP__SMTP_PASSWORD
    value: ⟬sendgrid_api_key#1⟭
  - name: AIRFLOW__SMTP__SMTP_MAIL_FROM
    value: ⟬email:generic#3⟭
  - name: HUGGINGFACE_HUB_TOKEN
    value: ⟬huggingface_token#1⟭

extraEnv: |
  - name: AIRFLOW_CONN_WAREHOUSE
    value: postgresql://forecast:⟬url_password#1⟭@⟬hostname#2⟭:5432/warehouse
  - name: AIRFLOW_CONN_S3_RAW
    value: '{"conn_type": "aws", "login": "⟬aws_access_key_id#1⟭", "password": "⟬aws_secret_access_key#1⟭", "extra": {"region_name": "us-east-1"}}'
  - name: AIRFLOW_VAR_OPENAI_KEY
    value: ⟬openai_api_key#1⟭

workers:
  persistence:
    enabled: false
  resources:
    requests:
      cpu: 500m
      memory: 2Gi

dags:
  gitSync:
    enabled: true
    repo: https://⟬hostname#3⟭/forecast/dags.git
    branch: main
    subPath: dags
    ⟬trap:indicator_non_pii|credentialsSecret: dags-git⟭

# holiday demand spikes use a ⟬trap:eponym|Holt-Winters⟭ baseline before the LLM commentary
config:
  core:
    parallelism: 64
    dag_concurrency: 16
  logging:
    remote_logging: "True"
    remote_base_log_folder: s3://forecast-airflow-logs
⟬end⟭

⟬template⟭
family: config
format: docker-compose.yml
language: en
fill_locale: en_US
domain: media
appearance: YAML value, environment list, comment, list item
scenario: internal chat front end for a magazine's research desk, running Open WebUI and Ollama on a workstation
⟬text⟭
services:
  webui:
    image: ghcr.io/open-webui/open-webui:0.3.32
    ports:
      - "3000:8080"
    environment:
      - OLLAMA_BASE_URL=http://ollama:11434
      - WEBUI_SECRET_KEY=⟬opaque_token#1⟭
      - OPENAI_API_KEY=⟬openai_api_key#1⟭
      - HF_TOKEN=⟬huggingface_token#1⟭
      - WEBUI_ADMIN_EMAIL=⟬email#2⟭
      - DEFAULT_MODELS=llama3.2
      # ⟬trap:word_name|Margaux⟭ is the name of the house style prompt, not a person
      - DEFAULT_PROMPT=⟬trap:word_name|Margaux⟭
    volumes:
      - webui:/app/backend/data
    depends_on:
      - ollama

  ollama:
    image: ollama/ollama:0.3.14
    volumes:
      - ollama:/root/.ollama

volumes:
  webui:
  ollama:
⟬end⟭

⟬template⟭
family: config
format: docker-compose.yml
language: en
fill_locale: en_US
domain: logistics
appearance: YAML value, comment, environment list, interpolation, list item
scenario: event streaming sandbox of a shipment tracking team, running Kafka, a schema registry and a topic browser on developer laptops
⟬text⟭
# Local event backbone for the shipment tracking services.
# Topics are created by scripts/create-topics.sh on first start.
services:
  ⟬trap:library|zookeeper⟭:
    image: bitnami/zookeeper:3.9
    environment:
      ALLOW_ANONYMOUS_LOGIN: "yes"

  ⟬trap:library|kafka⟭:
    image: bitnami/kafka:3.8
    depends_on:
      - ⟬trap:library|zookeeper⟭
    ports:
      - "9092:9092"
    environment:
      KAFKA_CFG_ZOOKEEPER_CONNECT: zookeeper:2181
      KAFKA_CFG_LISTENERS: PLAINTEXT://:9092
      KAFKA_CFG_ADVERTISED_LISTENERS: PLAINTEXT://localhost:9092
      KAFKA_CFG_AUTO_CREATE_TOPICS_ENABLE: "false"
      KAFKA_CFG_NUM_PARTITIONS: "6"
      ⟬trap:indicator_non_pii|KAFKA_CLIENT_USERS: tracking⟭
      KAFKA_CLIENT_PASSWORDS: ⟬trap:placeholder|${KAFKA_LOCAL_PASSWORD:?see README}⟭

  schema-registry:
    image: confluentinc/cp-schema-registry:7.7.1
    environment:
      SCHEMA_REGISTRY_HOST_NAME: schema-registry
      SCHEMA_REGISTRY_KAFKASTORE_BOOTSTRAP_SERVERS: kafka:9092
    depends_on:
      - ⟬trap:library|kafka⟭
    ports:
      - "8081:8081"

  browser:
    image: obsidiandynamics/kafdrop:4.0.2
    environment:
      KAFKA_BROKERCONNECT: kafka:9092
      ⟬trap:indicator_non_pii|JVM_OPTS: -Xms32M -Xmx128M⟭
    ports:
      - "9000:9000"
⟬end⟭

⟬template⟭
family: config
format: .json
language: en
fill_locale: en_US
domain: SaaS
appearance: nested JSON, string value, list item
scenario: local coding agent settings of a release engineer, with environment overrides and a permission list, zipped with a bug report
⟬text⟭
{
  "env": {
    "ANTHROPIC_API_KEY": "⟬anthropic_api_key#1⟭",
    "GITHUB_TOKEN": "⟬github_token#1⟭",
    "NPM_TOKEN": "⟬npm_token#1⟭",
    "DISABLE_TELEMETRY": "1"
  },
  "permissions": {
    "allow": [
      "Bash(npm run test:*)",
      "Bash(git status)",
      "Bash(gh pr view:*)"
    ],
    "deny": [
      "Read(./.env)",
      "Read(./secrets/**)"
    ]
  },
  "hooks": {
    "Stop": [
      {
        "matcher": "",
        "hooks": [
          { "type": "command", "command": "notify-send 'agent done'" }
        ]
      }
    ]
  },
  "includeCoAuthoredBy": false
}
⟬end⟭

⟬template⟭
family: config
format: .json
language: en
fill_locale: en_US
domain: retail
appearance: flat JSON, string value
scenario: .NET user secrets file of a click and collect API, copied into the repository so a new teammate could start faster
⟬text⟭
{
  "ConnectionStrings:Orders": "Host=⟬hostname#1⟭;Database=orders;Username=orders_app;Password=⟬password#1⟭",
  "SendGrid:ApiKey": "⟬sendgrid_api_key#1⟭",
  "Pickup:ReminderSender": "⟬email:generic#2⟭",
  "HuggingFace:Token": "⟬huggingface_token#1⟭",
  "Stores:Default:Street": "⟬postal_address:street#3⟭",
  "Stores:Default:City": "⟬city#3⟭",
  "Stores:Default:Zip": "⟬postcode#3⟭",
  "Stores:Default:Manager": "⟬person_name#4⟭",
  "Stores:Default:Phone": "⟬phone#4⟭"
}
⟬end⟭

⟬template⟭
family: config
format: .toml
language: en
fill_locale: en_US
domain: fintech
appearance: comment, section header, string value
scenario: Snowflake CLI connections of a treasury analyst, one profile using a password and one using a key pair
⟬text⟭
# ~/.snowflake/connections.toml
default_connection_name = "treasury"

[treasury]
account = "kx41207.us-east-1"
user = "⟬email#1⟭"
password = "⟬password#1⟭"
role = "TREASURY_ANALYST"
warehouse = "ANALYTICS_XS"
database = "TREASURY"
schema = "POSITIONS"

[loader]
account = "kx41207.us-east-1"
user = "⟬username#1⟭"
authenticator = "SNOWFLAKE_JWT"
private_key_raw = """
⟬private_key#1⟭
"""
private_key_passphrase = "⟬password#2⟭"
role = "LOADER"
⟬end⟭

⟬template⟭
family: config
format: .toml
language: en
fill_locale: en_US
domain: healthcare
appearance: comment, section header, string value, array of tables, list item
scenario: pyproject.toml of an open source HL7 parser maintained by a hospital's interoperability team, with a team address instead of personal authors
⟬text⟭
[project]
name = "hl7-lite"
version = "⟬version#1⟭"
description = "Small, dependency-free HL7 v2 parser"
readme = "README.md"
requires-python = ">=3.10"
license = { text = "Apache-2.0" }
authors = [{ name = "⟬trap:indicator_non_pii|Interoperability Team⟭" }]
keywords = ["hl7", "healthcare", "parser"]
classifiers = [
  "Programming Language :: Python :: 3",
  "Topic :: Scientific/Engineering :: Medical Science Apps.",
]
dependencies = []

[project.optional-dependencies]
docs = ["⟬trap:library|sphinx⟭>=7", "furo"]
test = ["⟬trap:library|pytest⟭>=8", "⟬trap:library|hypothesis⟭>=6"]

[project.urls]
Homepage = "⟬url#1⟭"

[tool.ruff]
line-length = 100
target-version = "py310"

[tool.ruff.lint]
select = ["E", "F", "I", "B"]

[tool.mypy]
strict = true
files = ["src"]

[tool.pytest.ini_options]
addopts = "-q --strict-markers"
markers = [
  "⟬trap:indicator_non_pii|patient_name: tests on the PID-5 name field⟭",
  "⟬trap:indicator_non_pii|birth_date: tests on the PID-7 field⟭",
]

[tool.coverage.report]
fail_under = 92
[tool.coverage.run]
branch = true
source = ["hl7_lite"]

[tool.hatch.build.targets.wheel]
packages = ["src/hl7_lite"]

[tool.hatch.version]
path = "src/hl7_lite/__init__.py"

[tool.bumpversion]
current_version = "⟬version#1⟭"
commit = true
tag = true

[[tool.bumpversion.files]]
filename = "src/hl7_lite/__init__.py"

# segment lookup uses ⟬trap:eponym|Boyer-Moore⟭, see docs/encoding.md
[tool.hl7.defaults]
field_separator = "|"
encoding_chars = "^~&"
⟬end⟭

⟬template⟭
family: config
format: .toml
language: en
fill_locale: en_US
domain: media
appearance: comment, section header, string value
scenario: mise.toml of a subtitle translation repo, where a developer used the env table of the tool manager for every key they needed
⟬text⟭
[tools]
node = "20"
python = "3.11"
ffmpeg = "7"

[env]
OPENAI_API_KEY = "⟬openai_api_key#1⟭"
HF_TOKEN = "⟬huggingface_token#1⟭"
NPM_TOKEN = "⟬npm_token#1⟭"
SENDGRID_API_KEY = "⟬sendgrid_api_key#1⟭"
DEEPL_KEY = "⟬opaque_token#1⟭"
# TODO: move to fnox or something, this file is tracked
GIT_AUTHOR_NAME = "⟬person_name#2⟭"
GIT_AUTHOR_EMAIL = "⟬email#2⟭"

[tasks.translate]
run = "python -m subtitles.translate --target es"
⟬end⟭

⟬template⟭
family: config
format: .npmrc
language: en
fill_locale: en_US
domain: healthcare
appearance: comment, assignment
scenario: minimal .npmrc in a wearable companion app repository, committed by an intern along with the name of the person who issued the token
⟬text⟭
# from ⟬person_name#1⟭, read only, dont share
//registry.npmjs.org/:_authToken=⟬npm_token#1⟭
⟬end⟭

⟬template⟭
family: config
format: .npmrc
language: en
fill_locale: en_US
domain: logistics
appearance: comment, assignment, url
scenario: .npmrc of an enterprise transport suite that resolves packages from Azure Artifacts, Artifactory and a GitLab group
⟬text⟭
; ------ transport suite, all feeds ------
registry=https://pkgs.dev.azure.com/tms-suite/_packaging/core/npm/registry/
always-auth=true

; azure artifacts
//pkgs.dev.azure.com/tms-suite/_packaging/core/npm/registry/:username=⟬username#1⟭
//pkgs.dev.azure.com/tms-suite/_packaging/core/npm/registry/:_password=⟬opaque_token#1⟭
//pkgs.dev.azure.com/tms-suite/_packaging/core/npm/registry/:email=⟬trap:indicator_non_pii|npm requires email to be set but does not use the value⟭

; artifactory, scoped
⟬trap:email_lookalike|@tms-edi:registry⟭=https://⟬hostname#1⟭/artifactory/api/npm/edi/
//⟬hostname#1⟭/artifactory/api/npm/edi/:_authToken=⟬jwt#1⟭

; gitlab group
⟬trap:email_lookalike|@tms-ui:registry⟭=https://⟬hostname#2⟭/api/v4/groups/19/-/packages/npm/
//⟬hostname#2⟭/api/v4/groups/19/-/packages/npm/:_authToken=⟬gitlab_token#1⟭

; public
//registry.npmjs.org/:_authToken=⟬npm_token#1⟭
⟬end⟭

⟬template⟭
family: config
format: .ini
language: en
fill_locale: en_US
domain: fintech
appearance: section header, assignment, comment
scenario: MySQL client defaults of a settlement reporting user, left in a shared service account home on the batch server
⟬text⟭
# ~/.my.cnf for the settlement reports
[client]
user=settle_report
password=⟬password#1⟭
host=⟬hostname#1⟭
ssl-ca=/etc/mysql/ca.pem

[mysqldump]
user=settle_dump
password=⟬password#2⟭
single-transaction
quick
⟬end⟭

⟬template⟭
family: config
format: .ini
language: en
fill_locale: en_US
domain: media
appearance: section header, assignment, list item, comment
scenario: setup.cfg of a transcript utilities package released under a team name, with packaging metadata and tool settings
⟬text⟭
[metadata]
name = transcript-utils
version = attr: transcript_utils.__version__
description = Helpers for cleaning and segmenting broadcast transcripts
author = ⟬trap:indicator_non_pii|Transcripts Team⟭
url = ⟬url#1⟭
license = BSD-3-Clause
classifiers =
    Programming Language :: Python :: 3.11
    Topic :: Multimedia :: Sound/Audio :: Speech

[options]
packages = find:
python_requires = >=3.10
install_requires =
    regex>=2024.9
    ⟬trap:library|jinja2⟭>=3.1

[options.extras_require]
docs =
    ⟬trap:library|sphinx⟭
test =
    ⟬trap:library|pytest⟭
    ⟬trap:library|hypothesis⟭

[flake8]
max-line-length = 100
per-file-ignores =
    tests/*: S101

; ⟬trap:eponym|Viterbi⟭ alignment lives in the C extension
[build_ext]
inplace = 1

[mypy]
ignore_missing_imports = True
⟬end⟭

⟬template⟭
family: config
format: .ini
language: en
fill_locale: en_US
domain: retail
appearance: section header, assignment, comment
scenario: Odoo server config of a furniture retailer, handed over by the integrator after go-live with the master password untouched
⟬text⟭
[options]
; odoo 17, furniture stores
addons_path = /opt/odoo/addons,/opt/odoo/custom
admin_passwd = ⟬password#1⟭
db_host = ⟬hostname#1⟭
db_port = 5432
db_user = odoo
db_password = ⟬password#2⟭
dbfilter = ^furniture$
list_db = False
proxy_mode = True
workers = 8
limit_time_cpu = 120
limit_time_real = 240

; outgoing mail, set by ⟬person_name#3⟭ from the integrator
smtp_server = smtp.sendgrid.net
smtp_port = 587
smtp_ssl = False
⟬trap:indicator_non_pii|smtp_user = apikey⟭
smtp_password = ⟬sendgrid_api_key#1⟭
email_from = ⟬email:generic#4⟭

logfile = /var/log/odoo/odoo.log
log_level = warn
⟬end⟭
