⟬template⟭
family: config
format: .env
language: en
fill_locale: en_US
domain: fintech
appearance: comment, assignment, quoted value, url
scenario: .env.production of a prepaid card issuer, pasted into the repo by the backend lead while chasing a failed deploy and never removed
⟬text⟭
# prepaid-core :: PRODUCTION values
# TEMP!!! remove before merge - ⟬person_name#1⟭, ⟬date#1⟭ (see ⟬ticket_id#1⟭)
# ledger job pages at night? call me ⟬phone#1⟭
NODE_ENV=production
PORT=8443
LOG_LEVEL=info
PUBLIC_BASE_URL=https://⟬hostname#2⟭
TZ=America/Chicago

# aws (the ci user, should be a role, i know)
AWS_REGION=us-east-1
AWS_ACCESS_KEY_ID=⟬aws_access_key_id#1⟭
AWS_SECRET_ACCESS_KEY=⟬aws_secret_access_key#1⟭
S3_STATEMENTS_BUCKET=prepaid-statements-prod
KMS_KEY_ALIAS=alias/prepaid-pan-v3

# ledger
DATABASE_URL=postgres://ledger_app:⟬url_password#1⟭@⟬hostname#3⟭:5432/ledger?sslmode=verify-full
DATABASE_POOL_MAX=40
REDIS_URL=rediss://default:⟬url_password#2⟭@⟬hostname#4⟭:6380/0
LEDGER_SERVICE_JWT=⟬jwt#1⟭
⟬trap:indicator_non_pii|JWT_TTL_SECONDS=900⟭
⟬trap:indicator_non_pii|PIN_MAX_ATTEMPTS=3⟭

# processor
PROCESSOR_BASE_URL=⟬url#1⟭
PROCESSOR_CLIENT_ID=⟬uuid#1⟭
PROCESSOR_CLIENT_SECRET=⟬opaque_token#1⟭
CARD_PROGRAM_ID=PP-0042
SETTLEMENT_CUTOFF_UTC=21:30

# mail
SENDGRID_API_KEY=⟬sendgrid_api_key#1⟭
MAIL_FROM="⟬company#2⟭ <⟬email:generic#2⟭>"
⟬trap:indicator_non_pii|EMAIL_TEMPLATE_DIR=./emails⟭

# release tooling
GITHUB_TOKEN=⟬github_token#1⟭
SENTRY_RELEASE=⟬version#1⟭
FEATURE_INSTANT_PAYOUT=false
# limits and fees, compliance signed off, dont change without ⟬person_name#5⟭
LOAD_LIMIT_DAILY_CENTS=250000
LOAD_LIMIT_MONTHLY_CENTS=1000000
ATM_WITHDRAWAL_FEE_CENTS=250
INACTIVITY_FEE_AFTER_DAYS=365
⟬trap:indicator_non_pii|KYC_NAME_MATCH_STRICT=true⟭
⟬trap:indicator_non_pii|CARDHOLDER_NAME_MAX_LEN=26⟭

# workers
STATEMENT_CRON="0 4 1 * *"
SETTLEMENT_CRON="30 21 * * 1-5"
DISPUTE_QUEUE=disputes-prod
WEBHOOK_RETRY_LIMIT=8
WEBHOOK_RETRY_BASE_MS=500

# observability
OTEL_SERVICE_NAME=prepaid-core
OTEL_EXPORTER_OTLP_ENDPOINT=https://⟬hostname#5⟭:4318
DD_API_KEY=⟬opaque_token#2⟭
PD_ROUTING=⟬opaque_token#3⟭
HEALTHCHECK_PATH=/internal/health

# old processor, cut over ⟬date#2⟭, remove once the last batch clears
#LEGACY_PROCESSOR_USER=⟬username#1⟭
#LEGACY_PROCESSOR_PASS=⟬password#1⟭
⟬end⟭

⟬template⟭
family: config
format: .env
language: en
fill_locale: en_US
domain: SaaS
appearance: comment, assignment
scenario: scratch env file of a changelog summarizer that a product engineer keeps next to a side script
⟬text⟭
# scratch keys for the changelog bot, local only
ANTHROPIC_API_KEY=⟬anthropic_api_key#1⟭
OPENAI_API_KEY=⟬openai_api_key#1⟭
SUMMARY_MODEL=claude-haiku-5-5
MAX_INPUT_TOKENS=12000
⟬end⟭

⟬template⟭
family: config
format: .env
language: en
fill_locale: en_US
domain: media
appearance: comment, assignment, section header, url
scenario: .env.example of a video transcoding farm, reviewed by the platform team so that new hires only ever see stand-ins
⟬text⟭
# transcode-farm / .env.example
# Copy to .env. Real values live in the team vault, never in this file.
# Last reviewed ⟬date#1⟭ (⟬ticket_id#1⟭)

## Runtime
APP_ENV=development
WORKER_CONCURRENCY=4
FFMPEG_PATH=/usr/local/bin/ffmpeg
SCRATCH_DIR=/var/tmp/transcode
LOG_FORMAT=json

## Object storage
AWS_REGION=us-east-1
AWS_ACCESS_KEY_ID=⟬trap:placeholder|AKIAXXXXXXXXXXXXXXXX⟭
AWS_SECRET_ACCESS_KEY=⟬trap:placeholder|<your-secret-access-key>⟭
AWS_SESSION_TOKEN=
SOURCE_BUCKET=ingest-dev
OUTPUT_BUCKET=renditions-dev
CDN_BASE_URL=⟬url#1⟭

## Captions
OPENAI_API_KEY=⟬trap:placeholder|sk-...⟭
WHISPER_MODEL=whisper-1
HF_TOKEN=⟬trap:placeholder|hf_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx⟭
DIARIZATION_MODEL=pyannote/speaker-diarization-3.1
⟬trap:indicator_non_pii|CAPTION_SPEAKER_NAMES=false⟭
# shot boundaries use a ⟬trap:eponym|Hamming⟭ distance over perceptual hashes
SHOT_DISTANCE_THRESHOLD=12

## Queue
REDIS_PASSWORD=⟬trap:placeholder|changeme⟭
REDIS_URL=redis://:⟬trap:placeholder|${REDIS_PASSWORD}⟭@localhost:6379/2
⟬trap:indicator_non_pii|QUEUE_TOKEN_TTL=600⟭
QUEUE_RETRY_LIMIT=5

## Color presets
# ⟬trap:word_name|Rose⟭ and ⟬trap:word_name|Hazel⟭ are the two LUTs marketing asked for
DEFAULT_LUT=⟬trap:word_name|Hazel⟭
LUT_DIR=./luts

## Notifications
SENDGRID_API_KEY=⟬trap:placeholder|SG.xxxxxxxx⟭
SLACK_BOT_TOKEN=⟬trap:placeholder|xoxb-your-token⟭
NOTIFY_CHANNEL=transcode-alerts
⟬trap:indicator_non_pii|EMAIL_DIGEST_ENABLED=false⟭

## Observability
OTEL_EXPORTER_OTLP_ENDPOINT=http://⟬hostname#1⟭:4317
GRAFANA_DASHBOARD_UID=⟬uuid#1⟭
BUILD_SHA=⟬git_sha#1⟭
## Encoding ladder
LADDER_1080P_KBPS=5800
LADDER_720P_KBPS=3000
LADDER_480P_KBPS=1400
LADDER_360P_KBPS=800
SEGMENT_SECONDS=6
GOP_SECONDS=2
HLS_ENABLED=true
DASH_ENABLED=true

## Rights
⟬trap:indicator_non_pii|OWNER_TEAM=video-platform⟭
⟬trap:indicator_non_pii|DRM_LICENSE_TOKEN_TTL=86400⟭
WATERMARK_ENABLED=false
⟬end⟭

⟬template⟭
family: config
format: Terraform .tfvars
language: en
fill_locale: en_US
domain: logistics
appearance: comment, assignment, map value, heredoc, list item
scenario: prod.auto.tfvars of a fleet telemetry platform, kept by the infrastructure lead who applies from a laptop and never moved the credentials into a backend
⟬text⟭
# fleet-telemetry - prod
# owner: ⟬person_name#1⟭ <⟬email#1⟭> (⟬job_title#1⟭)
# creds rotated ⟬date#1⟭ after ⟬ticket_id#1⟭, TODO get these into vault

environment  = "prod"
project_name = "fleet-telemetry"
aws_region   = "us-west-2"
aws_account  = "210987654321"

aws_access_key = "⟬aws_access_key_id#2⟭"
aws_secret_key = "⟬aws_secret_access_key#2⟭"

vpc_cidr             = "10.42.0.0/16"
private_subnet_cidrs = ["10.42.1.0/24", "10.42.2.0/24", "10.42.3.0/24"]
public_subnet_cidrs  = ["10.42.101.0/24", "10.42.102.0/24"]
office_ips           = ["⟬ip_address#1⟭", "⟬ip_address#2⟭"]

# telemetry ingest
ingest_instance_type = "m6i.xlarge"
ingest_min_size      = 3
ingest_max_size      = 12
ingest_hostname      = "⟬hostname#2⟭"
ingest_image_tag     = "⟬version#1⟭"
msk_broker_count     = 3
msk_kafka_version    = "3.6.0"
msk_retention_hours  = 72
msk_ebs_volume_gb    = 500
ingest_log_level     = "info"
ingest_health_path   = "/healthz"
gps_batch_seconds    = 10
geofence_refresh_min = 15

# timescale
⟬trap:indicator_non_pii|db_username = "telemetry_rw"⟭
db_password          = "⟬password#1⟭"
db_instance_class    = "db.r6g.2xlarge"
db_allocated_storage = 800
⟬trap:indicator_non_pii|db_password_rotation_days = 90⟭

# gitlab provider, used to push the deploy keys
gitlab_base_url = "https://⟬hostname#3⟭/api/v4/"
gitlab_token    = "⟬gitlab_token#1⟭"
gitlab_group_id = 1184

# dispatch alerts
sendgrid_api_key    = "⟬sendgrid_api_key#1⟭"
alert_from_address  = "⟬email:generic#4⟭"
dispatch_oncall     = "⟬phone#1⟭"

# bastion
bastion_user = "⟬username#1⟭"
bastion_public_key = "⟬ssh_public_key#1⟭"
bastion_private_key = <<-EOT
  ⟬private_key#1⟭
EOT

default_tags = {
  Project     = "fleet-telemetry"
  Environment = "prod"
  Owner       = "⟬email#1⟭"
  CostCenter  = "4412"
  ManagedBy   = "terraform"
}
⟬end⟭

⟬template⟭
family: config
format: Terraform .tfvars
language: en
fill_locale: en_US
domain: SaaS
appearance: comment, assignment
scenario: short tfvars for a GitHub organization module, applied by hand by the only platform engineer of a small startup
⟬text⟭
# github org settings, applied by hand from my laptop
github_owner       = "relay-works"
github_token       = "⟬github_token#1⟭"
default_branch     = "main"
required_approvals = 2
⟬end⟭

⟬template⟭
family: config
format: Terraform .tfvars
language: en
fill_locale: en_US
domain: healthcare
appearance: comment, assignment, map value, list item
scenario: staging.tfvars of a patient portal, checked in on purpose because sensitive inputs are injected by Terraform Cloud
⟬text⟭
# patient-portal / staging
# Sensitive variables are set as workspace variables in Terraform Cloud.
# The values below are stand-ins so that `terraform validate` passes locally.

environment = "staging"
region      = "us-east-2"
name_prefix = "pp-stg"

vpc_cidr           = "10.60.0.0/16"
availability_zones = ["us-east-2a", "us-east-2b"]
enable_nat_gateway = true
single_nat_gateway = true

# app tier
app_image_tag      = "⟬version#1⟭"
app_desired_count  = 2
app_cpu            = 512
app_memory         = 1024
health_check_path  = "/healthz"
portal_domain      = "⟬hostname#1⟭"

# database
db_engine_version      = "15.6"
db_instance_class      = "db.t4g.medium"
db_multi_az            = false
db_backup_retention    = 7
⟬trap:indicator_non_pii|db_username = "portal_admin"⟭
db_password            = "⟬trap:placeholder|CHANGE_ME⟭"
⟬trap:indicator_non_pii|password_min_length = 14⟭

# auth
oidc_issuer_url    = "⟬url#1⟭"
oidc_client_id     = "⟬uuid#1⟭"
oidc_client_secret = "⟬trap:placeholder|<set-in-terraform-cloud>⟭"
⟬trap:indicator_non_pii|session_token_ttl = 1800⟭

# messaging
sendgrid_api_key = "⟬trap:placeholder|SG.xxxxxxxxxxxxxxxxxxxxxx⟭"
⟬trap:indicator_non_pii|email_verification_required = true⟭

tags = {
  ⟬trap:indicator_non_pii|owner = "patient-experience"⟭
  compliance  = "hipaa"
  data_class  = "none-in-staging"
}
⟬end⟭

⟬template⟭
family: config
format: Kubernetes .yaml
language: en
fill_locale: en_US
domain: healthcare
appearance: comment, annotation, YAML value, block scalar, environment list
scenario: manifest of a clinical note summarizer written by the ML engineer who put the provider keys in stringData for the pilot at two clinics
⟬text⟭
# scribe-summarizer, pilot at two sites, do not promote as is
# questions: ⟬person_name#1⟭ / ⟬email#1⟭
apiVersion: v1
kind: Namespace
metadata:
  name: clinical-notes
  labels:
    owner: ⟬person_name:handle#1⟭
    pod-security.kubernetes.io/enforce: baseline
---
apiVersion: v1
kind: Secret
metadata:
  name: scribe-provider-keys
  namespace: clinical-notes
  annotations:
    rotated-on: "⟬date#1⟭"
    rotated-by: "⟬person_name#1⟭"
type: Opaque
stringData:
  ANTHROPIC_API_KEY: ⟬anthropic_api_key#1⟭
  HF_TOKEN: ⟬huggingface_token#1⟭
  EHR_FHIR_CLIENT_SECRET: ⟬opaque_token#1⟭
  NOTES_DB_DSN: postgresql://scribe:⟬url_password#1⟭@⟬hostname#2⟭:5432/notes
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: scribe-config
  namespace: clinical-notes
data:
  LOG_LEVEL: info
  REDACT_BEFORE_INFERENCE: "true"
  SUMMARY_MODEL: claude-sonnet-5-5
  EMBEDDING_MODEL: BAAI/bge-small-en-v1.5
  FHIR_BASE_URL: ⟬url#1⟭
  ⟬trap:indicator_non_pii|PATIENT_NAME_FIELD: subject.display⟭
  prompts.yaml: |
    system: |
      You summarize visit notes for the attending physician.
      Keep medication names and doses exactly as written.
    sections:
      - chief_complaint
      - assessment
      - plan
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: scribe-summarizer
  namespace: clinical-notes
spec:
  replicas: 2
  selector:
    matchLabels:
      app: scribe-summarizer
  template:
    metadata:
      labels:
        app: scribe-summarizer
    spec:
      serviceAccountName: scribe
      containers:
        - name: api
          image: ⟬hostname#3⟭/clinical/scribe:⟬version#1⟭
          ports:
            - containerPort: 8000
          envFrom:
            - configMapRef:
                name: scribe-config
            - secretRef:
                name: scribe-provider-keys
          resources:
            requests:
              cpu: 250m
              memory: 512Mi
            limits:
              memory: 1Gi
          readinessProbe:
            httpGet:
              path: /ready
              port: 8000
---
apiVersion: v1
kind: Service
metadata:
  name: scribe-summarizer
  namespace: clinical-notes
spec:
  selector:
    app: scribe-summarizer
  ports:
    - port: 80
      targetPort: 8000
⟬end⟭

⟬template⟭
family: config
format: Kubernetes .yaml
language: en
fill_locale: en_US
domain: retail
appearance: annotation, YAML value, block scalar, comment
scenario: storefront order mailer manifest in which a contractor put a SendGrid key and a signed service token straight in the ConfigMap
⟬text⟭
apiVersion: v1
kind: ConfigMap
metadata:
  name: order-mailer
  namespace: storefront
  annotations:
    support-contact: "⟬phone#1⟭"
    last-edited: "⟬date#1⟭"
data:
  mailer.yaml: |
    provider: sendgrid
    # FIXME move to a Secret, ⟬ticket_id#1⟭
    api_key: ⟬sendgrid_api_key#1⟭
    from: ⟬email:generic#2⟭
    reply_to: ⟬email:generic#3⟭
    templates:
      order_confirmed: d-7f3a10c2
      order_shipped: d-19be44a7
  catalog.yaml: |
    base_url: ⟬url#1⟭
    # service token for the catalog API, expires with the next release
    token: ⟬jwt#1⟭
    timeout_ms: 2500
  stores.yaml: |
    flagship:
      label: ⟬company#4⟭
      street: "⟬postal_address:street#4⟭"
      city: ⟬city#4⟭
      zip: "⟬postcode#4⟭"
      manager: ⟬person_name#5⟭
---
apiVersion: batch/v1
kind: CronJob
metadata:
  name: abandoned-cart-digest
  namespace: storefront
spec:
  schedule: "15 6 * * *"
  jobTemplate:
    spec:
      template:
        spec:
          restartPolicy: OnFailure
          containers:
            - name: digest
              image: ⟬hostname#6⟭/storefront/mailer:⟬version#1⟭
              args: ["digest", "--config", "/etc/mailer/mailer.yaml"]
              volumeMounts:
                - name: config
                  mountPath: /etc/mailer
          volumes:
            - name: config
              configMap:
                name: order-mailer
---
apiVersion: v1
kind: Service
metadata:
  name: order-mailer-metrics
  namespace: storefront
spec:
  selector:
    app: order-mailer
  ports:
    - name: metrics
      port: 9102
⟬end⟭

⟬template⟭
family: config
format: Kubernetes .yaml
language: en
fill_locale: en_US
domain: fintech
appearance: YAML value, comment, annotation, environment list
scenario: payouts Deployment with an ExternalSecret, written after a security audit so that no value sits in the repository
⟬text⟭
# Everything sensitive is pulled from AWS Secrets Manager by external-secrets.
apiVersion: external-secrets.io/v1beta1
kind: ExternalSecret
metadata:
  name: payouts-env
  namespace: payouts
spec:
  refreshInterval: 1h
  secretStoreRef:
    name: aws-secrets-manager
    kind: ClusterSecretStore
  target:
    name: payouts-env
  data:
    - secretKey: ⟬trap:indicator_non_pii|DATABASE_PASSWORD⟭
      remoteRef:
        key: prod/payouts/database
        property: password
    - secretKey: ⟬trap:indicator_non_pii|ACH_API_KEY⟭
      remoteRef:
        key: prod/payouts/ach
        property: api_key
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: payouts
  namespace: payouts
  labels:
    app.kubernetes.io/name: payouts
    ⟬trap:indicator_non_pii|owner: payments-core⟭
  annotations:
    deploy.example/commit: "⟬git_sha#1⟭"
spec:
  replicas: 3
  strategy:
    rollingUpdate:
      maxUnavailable: 0
  selector:
    matchLabels:
      app.kubernetes.io/name: payouts
  template:
    metadata:
      labels:
        app.kubernetes.io/name: payouts
    spec:
      securityContext:
        runAsNonRoot: true
      containers:
        - name: payouts
          image: ⟬hostname#1⟭/payments/payouts:⟬version#1⟭
          env:
            - name: DB_HOST
              value: ⟬hostname#2⟭
            - name: ⟬trap:indicator_non_pii|DB_USER⟭
              value: payouts_rw
            - name: ⟬trap:indicator_non_pii|DB_PASSWORD⟭
              valueFrom:
                secretKeyRef:
                  name: payouts-env
                  key: DATABASE_PASSWORD
            - name: ⟬trap:indicator_non_pii|ACH_API_KEY⟭
              valueFrom:
                secretKeyRef:
                  name: payouts-env
                  key: ACH_API_KEY
            - name: ⟬trap:indicator_non_pii|API_KEY_HEADER⟭
              value: X-Api-Key
            # jitter on retries follows a ⟬trap:eponym|Poisson⟭ arrival model
            - name: RETRY_JITTER_MS
              value: "250"
⟬end⟭

⟬template⟭
family: config
format: docker-compose.yml
language: en
fill_locale: en_US
domain: media
appearance: comment, YAML value, environment list, url
scenario: self-hosted model gateway of a newsroom, set up on a spare GPU box by a data journalist who pasted every key inline
⟬text⟭
# newsroom llm box, sits under my desk. ⟬person_name#1⟭
services:
  gateway:
    image: ghcr.io/berriai/litellm:main-stable
    restart: always
    ports:
      - "4000:4000"
    environment:
      OPENAI_API_KEY: ⟬openai_api_key#1⟭
      ANTHROPIC_API_KEY: ⟬anthropic_api_key#1⟭
      # the ui asks for this one: ⟬opaque_token#1⟭
      LITELLM_MASTER_KEY: ⟬opaque_token#1⟭
      DATABASE_URL: postgresql://litellm:⟬url_password#1⟭@db:5432/litellm
    depends_on:
      - db

  tgi:
    image: ghcr.io/huggingface/text-generation-inference:2.3
    command: --model-id mistralai/Mistral-7B-Instruct-v0.3 --max-total-tokens 8192
    environment:
      - HUGGING_FACE_HUB_TOKEN=⟬huggingface_token#1⟭
      - CUDA_VISIBLE_DEVICES=0
    volumes:
      - ./models:/data

  db:
    image: postgres:16-alpine
    environment:
      POSTGRES_DB: litellm
      ⟬trap:indicator_non_pii|POSTGRES_USER: litellm⟭
      POSTGRES_PASSWORD: ⟬url_password#1⟭
    volumes:
      - pgdata:/var/lib/postgresql/data

volumes:
  pgdata:
⟬end⟭

⟬template⟭
family: config
format: docker-compose.yml
language: en
fill_locale: en_US
domain: logistics
appearance: YAML value, environment list, comment, label
scenario: compose file of a warehouse team's build box running a GitLab runner and a package proxy
⟬text⟭
version: "3.9"

x-common-env: &common-env
  CI_SERVER_URL: https://⟬hostname#1⟭
  TZ: America/Denver

services:
  runner:
    image: gitlab/gitlab-runner:v17.5.1
    restart: unless-stopped
    environment:
      <<: *common-env
      RUNNER_NAME: dock-07-builder
      REGISTRATION_TOKEN: ⟬opaque_token#1⟭
      RUNNER_EXECUTOR: docker
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - ./runner:/etc/gitlab-runner

  verdaccio:
    image: verdaccio/verdaccio:5
    environment:
      VERDACCIO_PORT: "4873"
      NPM_TOKEN: ⟬npm_token#1⟭
    labels:
      - "com.warehouse.maintainer=⟬email#2⟭"
    ports:
      - "4873:4873"

  label-printer-sync:
    image: ⟬hostname#1⟭/wms/label-sync:⟬version#1⟭
    environment:
      <<: *common-env
      # read_api scope only, ⟬person_name#2⟭ made it
      GITLAB_TOKEN: ⟬gitlab_token#1⟭
      WMS_API_URL: ⟬url#1⟭
      PRINTER_HOST: ⟬ip_address#1⟭
      PRINTER_SHARE: zebra
      ⟬trap:indicator_non_pii|PRINT_USER: labelsvc⟭
      SMB_PASSWORD: ⟬password#1⟭
      SENDGRID_API_KEY: ⟬sendgrid_api_key#1⟭

  pallet-scan-gateway:
    image: ⟬hostname#1⟭/wms/scan-gateway:⟬version#1⟭
    restart: unless-stopped
    ports:
      - "9100:9100"
    environment:
      <<: *common-env
      SCANNER_MODE: batch
      SCAN_FLUSH_SECONDS: "30"
      DOCK_DOORS: "D01,D02,D03,D04,D05,D06"
      WMS_API_URL: ⟬url#1⟭
      WMS_SITE_REF: ⟬opaque_token#2⟭
      ⟬trap:indicator_non_pii|OPERATOR_NAME_FIELD: scanned_by⟭
    healthcheck:
      test: ["CMD", "wget", "-qO-", "http://localhost:9100/health"]
      interval: 30s
      retries: 3

  watchtower:
    image: containrrr/watchtower:1.7.1
    environment:
      WATCHTOWER_POLL_INTERVAL: "3600"
      WATCHTOWER_CLEANUP: "true"
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
⟬end⟭

⟬template⟭
family: config
format: docker-compose.yml
language: en
fill_locale: en_US
domain: retail
appearance: YAML value, comment, environment list, interpolation
scenario: developer stack of a loyalty program, where every credential is an interpolation with a required-value guard
⟬text⟭
# docker compose --env-file .env.local up
name: loyalty-dev

services:
  api:
    build:
      context: .
      target: dev
    command: ⟬trap:library|gunicorn⟭ loyalty.wsgi --reload --bind 0.0.0.0:8000
    ports:
      - "8000:8000"
    environment:
      - DJANGO_SETTINGS_MODULE=loyalty.settings.dev
      - DATABASE_URL=postgres://loyalty:⟬trap:placeholder|${POSTGRES_PASSWORD:?set it in .env.local}⟭@db:5432/loyalty
      - CELERY_BROKER_URL=amqp://loyalty:⟬trap:placeholder|${RABBIT_PASSWORD}⟭@mq:5672//
      - SECRET_KEY=⟬trap:placeholder|${DJANGO_SECRET_KEY}⟭
      - STRIPE_SECRET_KEY=⟬trap:placeholder|${STRIPE_SECRET_KEY:-sk_test_xxx}⟭
      - ⟬trap:indicator_non_pii|POINTS_TOKEN_TTL=86400⟭
      - ⟬trap:indicator_non_pii|DEFAULT_MEMBER_NAME=Guest⟭
    depends_on:
      db:
        condition: service_healthy
      mq:
        condition: service_started

  worker:
    build:
      context: .
      target: dev
    command: ⟬trap:library|celery⟭ -A loyalty worker -l info
    environment:
      - DATABASE_URL=postgres://loyalty:⟬trap:placeholder|${POSTGRES_PASSWORD}⟭@db:5432/loyalty

  db:
    image: postgres:16
    environment:
      POSTGRES_DB: loyalty
      POSTGRES_USER: loyalty
      POSTGRES_PASSWORD: ⟬trap:placeholder|${POSTGRES_PASSWORD}⟭
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U loyalty"]
      interval: 5s
      retries: 10

  mq:
    image: rabbitmq:3.13-management
    ports:
      - "15672:15672"
    environment:
      RABBITMQ_DEFAULT_USER: loyalty
      RABBITMQ_DEFAULT_PASS: ⟬trap:placeholder|${RABBIT_PASSWORD}⟭

  mailpit:
    image: axllent/mailpit:v1.20
    ports:
      - "8025:8025"
      - "1025:1025"

  flower:
    image: mher/flower:2.0
    command: ⟬trap:library|celery⟭ --broker=amqp://loyalty:⟬trap:placeholder|${RABBIT_PASSWORD}⟭@mq:5672// flower
    ports:
      - "5555:5555"
    depends_on:
      - mq
⟬end⟭

⟬template⟭
family: config
format: .json
language: en
fill_locale: en_US
domain: SaaS
appearance: nested JSON, string value, http header
scenario: project-level MCP server file that a staff engineer shared with the team without noticing the personal tokens in it
⟬text⟭
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "⟬trap:email_lookalike|@modelcontextprotocol/server-github⟭"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "⟬github_token#1⟭"
      }
    },
    "postgres-readonly": {
      "command": "npx",
      "args": [
        "-y",
        "⟬trap:email_lookalike|@modelcontextprotocol/server-postgres⟭",
        "postgresql://readonly:⟬url_password#1⟭@⟬hostname#1⟭:5432/analytics"
      ]
    },
    "billing-admin": {
      "type": "http",
      "url": "⟬url#1⟭",
      "headers": {
        "Authorization": "Bearer ⟬jwt#1⟭",
        "X-Tenant": "⟬uuid#1⟭",
        "X-Trace-Seed": "⟬opaque_token#1⟭"
      }
    },
    "docs-search": {
      "command": "uvx",
      "args": ["docs-search-mcp", "--index", "handbook"],
      "env": {
        "ANTHROPIC_API_KEY": "⟬anthropic_api_key#1⟭",
        "EMBEDDING_CACHE": "/tmp/docs-search"
      }
    }
  }
}
⟬end⟭

⟬template⟭
family: config
format: .json
language: en
fill_locale: en_US
domain: fintech
appearance: nested JSON, string value
scenario: Composer auth.json of a PHP lending backoffice, committed when the deploy user was set up
⟬text⟭
{
    "github-oauth": {
        "github.com": "⟬github_token#1⟭"
    },
    "gitlab-token": {
        "⟬hostname#1⟭": "⟬gitlab_token#1⟭"
    },
    "http-basic": {
        "repo.packagist.com": {
            "username": "token",
            "password": "⟬opaque_token#1⟭"
        }
    }
}
⟬end⟭

⟬template⟭
family: config
format: .toml
language: en
fill_locale: en_US
domain: media
appearance: comment, section header, string value, array of tables
scenario: Streamlit secrets file of an archive search tool built by the audience desk, shared with two editors over a drive folder
⟬text⟭
# .streamlit/secrets.toml for archive-search
# paste this into the Streamlit Cloud settings box, it is not meant for the repo

[openai]
api_key = "⟬openai_api_key#1⟭"
embedding_model = "text-embedding-3-small"

[huggingface]
token = "⟬huggingface_token#1⟭"
reranker = "BAAI/bge-reranker-base"

[postgres]
host = "⟬hostname#1⟭"
port = 5432
database = "archive"
⟬trap:indicator_non_pii|user = "streamlit_ro"⟭
password = "⟬password#1⟭"

[auth]
cookie_name = "archive_search"
cookie_key = "⟬opaque_token#1⟭"
⟬trap:indicator_non_pii|cookie_expiry_days = 7⟭

[[auth.editors]]
name = "⟬person_name#2⟭"
email = "⟬email#2⟭"
role = "admin"

[[auth.editors]]
name = "⟬person_name#3⟭"
email = "⟬email#3⟭"
role = "viewer"
⟬end⟭

⟬template⟭
family: config
format: .toml
language: en
fill_locale: en_US
domain: logistics
appearance: comment, section header, string value, array of tables
scenario: fly.toml of a dispatch API, where secrets are set with fly secrets and the app is named after the founder's old trucking firm
⟬text⟭
# fly.toml, secrets go through `fly secrets set`, never in here
app = "⟬trap:code_identifier|⦃family⦄-dispatch⟭"
primary_region = "ord"
kill_signal = "SIGTERM"

[build]
  image = "⟬hostname#1⟭/dispatch/api:⟬version#1⟭"

[deploy]
  release_command = "bin/migrate"
  strategy = "rolling"

[env]
  LOG_LEVEL = "info"
  HOME_TERMINAL = "⟬trap:word_name|Savannah⟭"
  CARRIER_LABEL = "⟬trap:company_name|⦃Family⦄ Freight⟭"
  ROUTING_API = "⟬url#1⟭"
  ⟬trap:indicator_non_pii|DRIVER_TOKEN_TTL = "43200"⟭
  ⟬trap:indicator_non_pii|API_KEY_HEADER = "X-Dispatch-Key"⟭
  # stop ordering solved with ⟬trap:eponym|Dijkstra⟭ then 2-opt
  ROUTE_SOLVER = "two_opt"

[http_service]
  internal_port = 8080
  force_https = true
  min_machines_running = 2

  [[http_service.checks]]
    interval = "15s"
    timeout = "2s"
    method = "GET"
    path = "/healthz"

[[vm]]
  size = "shared-cpu-2x"
  memory = "1gb"
⟬end⟭

⟬template⟭
family: config
format: .npmrc
language: en
fill_locale: en_US
domain: retail
appearance: comment, assignment, url
scenario: project .npmrc of a storefront monorepo with the npm automation token and the internal GitLab registry token left in clear
⟬text⟭
# storefront monorepo
registry=https://registry.npmjs.org/
⟬trap:email_lookalike|@storefront:registry⟭=https://⟬hostname#1⟭/api/v4/projects/412/packages/npm/
//⟬hostname#1⟭/api/v4/projects/412/packages/npm/:_authToken=⟬gitlab_token#1⟭
//registry.npmjs.org/:_authToken=⟬npm_token#1⟭
save-exact=true
engine-strict=true
fund=false
⟬end⟭

⟬template⟭
family: config
format: .npmrc
language: en
fill_locale: en_US
domain: SaaS
appearance: comment, assignment
scenario: home directory .npmrc of a developer advocate, copied into a demo repository with their author defaults and a GitHub Packages token
⟬text⟭
init-author-name=⟬person_name#1⟭
init-author-email=⟬email#1⟭
init-author-url=⟬url#1⟭
init-license=MIT
init-version=0.1.0
; packages for the sdk demos
⟬trap:email_lookalike|@relay-sdk:registry⟭=https://npm.pkg.github.com
//npm.pkg.github.com/:_authToken=⟬github_token#1⟭
//registry.npmjs.org/:_authToken=⟬npm_token#1⟭
⟬trap:indicator_non_pii|sign-git-tag=false⟭
⟬trap:indicator_non_pii|otp=⟭
⟬end⟭

⟬template⟭
family: config
format: .ini
language: en
fill_locale: en_US
domain: healthcare
appearance: comment, section header, assignment
scenario: AWS shared credentials file of a pharmacy benefits analyst, attached to a support ticket by mistake
⟬text⟭
# ~/.aws/credentials

[default]
aws_access_key_id = ⟬aws_access_key_id#1⟭
aws_secret_access_key = ⟬aws_secret_access_key#1⟭

[claims-prod]
aws_access_key_id = ⟬aws_access_key_id#2⟭
aws_secret_access_key = ⟬aws_secret_access_key#2⟭
region = us-east-1
output = json

; sandbox from the vendor, expires end of quarter
[pbm-sandbox]
aws_access_key_id = ⟬aws_access_key_id#3⟭
aws_secret_access_key = ⟬aws_secret_access_key#3⟭
aws_session_token = ⟬opaque_token#1⟭
⟬end⟭

⟬template⟭
family: config
format: .ini
language: en
fill_locale: en_US
domain: logistics
appearance: section header, assignment, comment
scenario: .pypirc of a route optimization library published to a private GitLab package index and to PyPI
⟬text⟭
[distutils]
index-servers =
    internal
    pypi

# routekit releases
[internal]
repository = https://⟬hostname#1⟭/api/v4/projects/88/packages/pypi
⟬trap:indicator_non_pii|username = __token__⟭
password = ⟬gitlab_token#1⟭

[pypi]
⟬trap:indicator_non_pii|username = __token__⟭
password = ⟬opaque_token#1⟭
⟬end⟭
