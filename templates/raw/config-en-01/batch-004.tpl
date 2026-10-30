⟬template⟭
family: config
format: .env
language: en
fill_locale: en_US
domain: SaaS
appearance: comment, assignment, section header, quoted value, url, commented-out line
scenario: production env of a scheduling product after four years of integrations, in which old keys were commented out rather than removed
⟬text⟭
# ============================================================
#  orbit-api, production. Sync with the wiki when you edit this
# ============================================================

# ---- core ----
RAILS_ENV=production
RACK_ENV=production
SECRET_KEY_BASE=⟬opaque_token#1⟭
RAILS_MASTER_KEY=⟬opaque_token#2⟭
WEB_CONCURRENCY=6
RAILS_MAX_THREADS=8
APP_HOST=⟬hostname#1⟭
ASSET_HOST=⟬hostname#2⟭
FORCE_SSL=true
DEFAULT_TIMEZONE=UTC

# ---- data ----
DATABASE_URL=postgres://orbit:⟬url_password#1⟭@⟬hostname#3⟭:5432/orbit_production
DATABASE_REPLICA_URL=postgres://orbit_ro:⟬url_password#2⟭@⟬hostname#4⟭:5432/orbit_production
REDIS_URL=rediss://:⟬url_password#3⟭@⟬hostname#5⟭:6379/1
ELASTIC_URL=https://elastic:⟬url_password#4⟭@⟬hostname#6⟭:9243
SIDEKIQ_CONCURRENCY=20

# ---- aws ----
AWS_REGION=us-west-2
AWS_ACCESS_KEY_ID=⟬aws_access_key_id#1⟭
AWS_SECRET_ACCESS_KEY=⟬aws_secret_access_key#1⟭
S3_ATTACHMENTS_BUCKET=orbit-attachments-prod
CLOUDFRONT_KEY_PAIR_ID=K2JCJMDEHXQW5F
CLOUDFRONT_PRIVATE_KEY="⟬private_key#1⟭"

# ---- email ----
SENDGRID_API_KEY=⟬sendgrid_api_key#1⟭
#SENDGRID_API_KEY=⟬sendgrid_api_key#2⟭
MAIL_FROM_ADDRESS=⟬email:generic#7⟭
MAIL_REPLY_TO=⟬email:generic#8⟭
⟬trap:indicator_non_pii|MAIL_FROM_NAME=Orbit⟭

# ---- ai assist ----
OPENAI_API_KEY=⟬openai_api_key#1⟭
#OPENAI_API_KEY_OLD=⟬openai_api_key#2⟭
ANTHROPIC_API_KEY=⟬anthropic_api_key#1⟭
HF_API_TOKEN=⟬huggingface_token#1⟭
AI_DEFAULT_PROVIDER=anthropic
⟬trap:indicator_non_pii|AI_MAX_OUTPUT_TOKENS=1024⟭

# ---- billing ----
STRIPE_SECRET_KEY=⟬stripe_secret_key#1⟭
STRIPE_PUBLISHABLE_KEY=⟬stripe_publishable_key#1⟭
STRIPE_WEBHOOK_SECRET=⟬opaque_token#3⟭
⟬trap:indicator_non_pii|TRIAL_LENGTH_DAYS=14⟭

# ---- integrations ----
GITHUB_APP_ID=119204
GITHUB_APP_WEBHOOK_SECRET=⟬opaque_token#4⟭
GITHUB_TOKEN=⟬github_token#1⟭
CAL_SYNC_STATE=⟬opaque_token#5⟭
SLACK_BOT_TOKEN=⟬slack_token#1⟭
ZOOM_JWT=⟬jwt#1⟭
GOOGLE_CLIENT_ID=⟬uuid#1⟭
GOOGLE_CLIENT_SECRET=⟬opaque_token#6⟭
GOOGLE_MAPS_API_KEY=⟬google_api_key#1⟭

# ---- support ----
# escalation goes to ⟬person_name#9⟭ first, then ⟬person_name#10⟭ (⟬phone#10⟭)
SUPPORT_INBOX=⟬email:generic#11⟭
STATUS_PAGE_URL=⟬url#1⟭
RELEASE=⟬version#1⟭
⟬end⟭

⟬template⟭
family: config
format: .env
language: en
fill_locale: en_US
domain: logistics
appearance: assignment
scenario: env file with one-letter keys sourced by a nightly manifest export cron, written by a sysadmin who wanted it unreadable at a glance
⟬text⟭
A=⟬aws_access_key_id#1⟭
B=⟬aws_secret_access_key#1⟭
R=us-east-2
K=⟬opaque_token#1⟭
SIG=⟬huggingface_token#1⟭
OUT=s3://manifests-nightly/
⟬end⟭

⟬template⟭
family: config
format: .env
language: en
fill_locale: en_US
domain: healthcare
appearance: comment, assignment, quoted value, test fixture
scenario: test env of a lab results integration, in which a developer kept the FHIR sandbox token and the fixture patient used by the contract tests
⟬text⟭
# .env.test, loaded by jest setup
NODE_ENV=test
FHIR_BASE_URL=⟬url#1⟭
FHIR_BEARER=⟬jwt#1⟭
HL7_LISTENER_PORT=2575
⟬trap:indicator_non_pii|PATIENT_ID_SYSTEM=urn:oid:2.16.840.1.113883.4.1⟭

# fixture patient, matches tests/fixtures/oru_r01.hl7
FIXTURE_MRN=⟬customer_id#1⟭
FIXTURE_PATIENT="⟬person_name#1⟭"
FIXTURE_DOB="⟬birth_date#1⟭"
FIXTURE_COLLECTED_AT="⟬date#1⟭"
FIXTURE_PHONE="⟬phone#1⟭"
FIXTURE_HOME="⟬postal_address#1⟭"
FIXTURE_ORDERING_DR="⟬person_name#2⟭"
⟬end⟭

⟬template⟭
family: config
format: Terraform .tfvars
language: en
fill_locale: en_US
domain: SaaS
appearance: comment, assignment, map value, object list
scenario: multi-region production sizing of a chat product, reviewed by the capacity planner, where nothing sensitive is passed through tfvars
⟬text⟭
# chat-platform: production sizing per region
# Credentials are read from Vault at plan time, nothing sensitive goes here.
# Capacity model refreshed on ⟬date#1⟭, see ⟬ticket_id#1⟭

company_short = "relay"
environment   = "production"
kubernetes_version = "1.30"

regions = {
  use1 = {
    aws_region  = "us-east-1"
    cidr        = "10.10.0.0/16"
    node_groups = 3
    desired     = 24
    cluster     = "⟬trap:code_identifier|⦃family⦄-use1⟭"
  }
  usw2 = {
    aws_region  = "us-west-2"
    cidr        = "10.20.0.0/16"
    node_groups = 3
    desired     = 16
    cluster     = "⟬trap:code_identifier|⦃family2⦄-usw2⟭"
  }
  euc1 = {
    aws_region  = "eu-central-1"
    cidr        = "10.30.0.0/16"
    node_groups = 2
    desired     = 10
    cluster     = "⟬trap:code_identifier|⦃family3⦄-euc1⟭"
  }
}

node_instance_types = ["m7g.2xlarge", "m7g.4xlarge"]
spot_share_percent  = 30

# websocket gateways are sized with ⟬trap:eponym|Little⟭'s law on open connections
gateway_replicas_per_az  = 8
max_connections_per_pod  = 50000
presence_redis_shards    = 12

kafka_brokers            = 9
kafka_retention_hours    = 168
⟬trap:indicator_non_pii|message_token_ttl        = 120⟭
⟬trap:indicator_non_pii|user_directory_cache_ttl = 300⟭
⟬trap:indicator_non_pii|email_digest_batch_size  = 500⟭

waf_rate_limit  = 2000
waf_allowlist   = ["10.0.0.0/8"]

maintenance_window = "sun:06:00-sun:08:00"
alarm_sns_topic    = "arn:aws:sns:us-east-1:210987654321:chat-alarms"
cloudwatch_log_retention = 30
enable_cross_zone_lb     = true
tls_policy               = "ELBSecurityPolicy-TLS13-1-2-2021-06"
media_bucket_prefix      = "relay-attachments"
media_max_upload_mb      = 100
search_replicas          = 3

extra_tags = {
  ⟬trap:indicator_non_pii|owner = "realtime-platform"⟭
  tier  = "critical"
}
⟬end⟭

⟬template⟭
family: config
format: Terraform .tfvars
language: en
fill_locale: en_US
domain: retail
appearance: comment, assignment, object list, list item
scenario: Vercel project environment variables for a flash sale microsite, built by an agency and handed over with the file included
⟬text⟭
# flash-sale microsite, Vercel project
vercel_team_id = "⟬uuid#1⟭"
vercel_token   = "⟬opaque_token#1⟭"
project_name   = "flash-sale-fall"
framework      = "nextjs"
domains        = ["⟬hostname#1⟭"]

env_vars = [
  {
    key    = "OPENAI_API_KEY"
    value  = "⟬openai_api_key#1⟭"
    target = ["production", "preview"]
  },
  {
    key    = "NPM_TOKEN"
    value  = "⟬npm_token#1⟭"
    target = ["production", "preview", "development"]
  },
  {
    key    = "CHECKOUT_SERVICE_TOKEN"
    value  = "⟬jwt#1⟭"
    target = ["production"]
  },
  {
    key    = "STRIPE_SECRET_KEY"
    value  = "⟬stripe_secret_key#1⟭"
    target = ["production"]
  },
  {
    key    = "NEXT_PUBLIC_STRIPE_KEY"
    value  = "⟬stripe_publishable_key#1⟭"
    target = ["production"]
  },
]

# agency contact for the handover
agency_contact = "⟬person_name#2⟭ / ⟬email#2⟭"
⟬end⟭

⟬template⟭
family: config
format: Terraform .tfvars
language: en
fill_locale: en_US
domain: media
appearance: comment, assignment, heredoc
scenario: inference endpoint variables of a recommendation team, including a policy document pasted as a heredoc
⟬text⟭
# hf-inference endpoint for the "because you watched" reranker
hf_namespace = "stillwater-ml"
hf_token     = "⟬huggingface_token#1⟭"
model_repo   = "stillwater-ml/reranker-small"
accelerator  = "gpu"
min_replica  = 0
max_replica  = 2

results_bucket_policy = <<EOT
{
  "Version": "2012-10-17",
  "Statement": [{
    "Effect": "Allow",
    "Principal": {"AWS": "arn:aws:iam::210987654321:role/reco-batch"},
    "Action": ["s3:GetObject"],
    "Resource": "arn:aws:s3:::reco-results/*"
  }]
}
EOT
⟬end⟭

⟬template⟭
family: config
format: Kubernetes .yaml
language: en
fill_locale: en_US
domain: logistics
appearance: comment, block scalar, YAML value, annotation, environment list, label
scenario: complete bundle of a warehouse vision service for robot picking stations, written in one file by the site reliability engineer of a fulfillment center
⟬text⟭
# wh-vision, fulfillment center 12
# oncall ⟬person_name#1⟭ ⟬phone#1⟭, backup ⟬person_name#2⟭
---
apiVersion: v1
kind: Namespace
metadata:
  name: wh-vision
---
apiVersion: v1
kind: Secret
metadata:
  name: registry-pull
  namespace: wh-vision
type: kubernetes.io/dockerconfigjson
stringData:
  .dockerconfigjson: |
    {
      "auths": {
        "⟬hostname#3⟭": {
          "username": "⟬username#1⟭",
          "password": "⟬gitlab_token#1⟭",
          "email": "⟬email#1⟭"
        }
      }
    }
---
apiVersion: v1
kind: Secret
metadata:
  name: vision-env
  namespace: wh-vision
type: Opaque
stringData:
  HF_TOKEN: ⟬huggingface_token#1⟭
  MQTT_PASSWORD: "⟬password#1⟭"
  WMS_TENANT_REF: ⟬opaque_token#1⟭
  S3_ACCESS_KEY: ⟬aws_access_key_id#1⟭
  S3_SECRET_KEY: ⟬aws_secret_access_key#1⟭
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: vision-config
  namespace: wh-vision
data:
  DETECTOR_MODEL: facebook/detr-resnet-50
  CONFIDENCE_FLOOR: "0.72"
  MQTT_BROKER: tcp://⟬hostname#4⟭:1883
  ⟬trap:indicator_non_pii|MQTT_USER: pickstation⟭
  stations.json: |
    [
      {"id": "PS-01", "camera_ip": "⟬ip_address#1⟭"},
      {"id": "PS-02", "camera_ip": "⟬ip_address#2⟭"},
      {"id": "PS-03", "camera_ip": "⟬ip_address#3⟭"}
    ]
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: model-cache
  namespace: wh-vision
spec:
  accessModes: ["ReadWriteOnce"]
  storageClassName: local-nvme
  resources:
    requests:
      storage: 100Gi
---
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: vision-agent
  namespace: wh-vision
  labels:
    app: vision-agent
spec:
  selector:
    matchLabels:
      app: vision-agent
  template:
    metadata:
      labels:
        app: vision-agent
    spec:
      nodeSelector:
        gpu: "true"
      imagePullSecrets:
        - name: registry-pull
      containers:
        - name: agent
          image: ⟬hostname#3⟭/wh/vision-agent:⟬version#1⟭
          envFrom:
            - secretRef:
                name: vision-env
            - configMapRef:
                name: vision-config
          volumeMounts:
            - name: model-cache
              mountPath: /models
          resources:
            limits:
              nvidia.com/gpu: 1
      volumes:
        - name: model-cache
          persistentVolumeClaim:
            claimName: model-cache
---
apiVersion: batch/v1
kind: CronJob
metadata:
  name: retrain-export
  namespace: wh-vision
spec:
  schedule: "0 3 * * 0"
  jobTemplate:
    spec:
      template:
        spec:
          restartPolicy: Never
          imagePullSecrets:
            - name: registry-pull
          containers:
            - name: export
              image: ⟬hostname#3⟭/wh/retrain-export:⟬version#1⟭
              envFrom:
                - secretRef:
                    name: vision-env
⟬end⟭

⟬template⟭
family: config
format: Kubernetes .yaml
language: en
fill_locale: en_US
domain: healthcare
appearance: comment, environment list, YAML value, shell command
scenario: one-off Kubernetes Job that moved imaging records between two PACS databases, left in the repository after the cutover with its credentials
⟬text⟭
# ran once on ⟬date#1⟭ for ⟬ticket_id#1⟭, keep for the audit trail
apiVersion: batch/v1
kind: Job
metadata:
  name: pacs-cutover-copy
  namespace: imaging
spec:
  backoffLimit: 0
  template:
    spec:
      restartPolicy: Never
      containers:
        - name: copy
          image: postgres:15
          command:
            - sh
            - -c
            - |
              pg_dump -Fc "$SOURCE_DSN" | pg_restore -d "$TARGET_DSN" --no-owner
              aws s3 cp /tmp/report.txt s3://pacs-cutover/report.txt
          env:
            - name: SOURCE_DSN
              value: postgresql://pacs_ro:⟬url_password#1⟭@⟬hostname#1⟭:5432/pacs
            - name: TARGET_DSN
              value: postgresql://pacs_admin:⟬url_password#2⟭@⟬hostname#2⟭:5432/pacs
            - name: AWS_ACCESS_KEY_ID
              value: ⟬aws_access_key_id#1⟭
            - name: AWS_SECRET_ACCESS_KEY
              value: ⟬aws_secret_access_key#1⟭
            - name: PERFORMED_BY
              value: ⟬person_name:handle#3⟭
⟬end⟭

⟬template⟭
family: config
format: Kubernetes .yaml
language: en
fill_locale: en_US
domain: SaaS
appearance: YAML value, comment, list item
scenario: Kustomize overlay of a feature flag service, where secrets are generated from files that never enter Git
⟬text⟭
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
namespace: flags
resources:
  - ../../base
  - hpa.yaml
images:
  - name: flags-api
    newName: ⟬hostname#1⟭/platform/flags-api
    newTag: ⟬version#1⟭
secretGenerator:
  - name: flags-db
    # files come from `make fetch-secrets`, they are in .gitignore
    files:
      - ⟬trap:indicator_non_pii|password=secrets/db-password.txt⟭
      - ⟬trap:indicator_non_pii|username=secrets/db-user.txt⟭
  - name: flags-signing
    files:
      - ⟬trap:indicator_non_pii|private.pem=secrets/signing.pem⟭
configMapGenerator:
  - name: flags-settings
    literals:
      - LOG_LEVEL=warn
      - ⟬trap:indicator_non_pii|SDK_KEY_HEADER=X-Flags-Key⟭
      - ⟬trap:indicator_non_pii|OWNER=growth-eng⟭
patches:
  - path: replicas.yaml
    target:
      kind: Deployment
      name: flags-api
⟬end⟭

⟬template⟭
family: config
format: docker-compose.yml
language: en
fill_locale: en_US
domain: retail
appearance: YAML value, build argument, comment, environment list
scenario: compose file of a headless commerce backend with an npm token passed as a build argument, written by a solo founder
⟬text⟭
services:
  medusa:
    build:
      context: .
      args:
        # private theme packages
        NPM_TOKEN: ⟬npm_token#1⟭
    ports:
      - "9000:9000"
    environment:
      - DATABASE_URL=postgres://medusa:⟬url_password#1⟭@postgres:5432/medusa
      - REDIS_URL=redis://redis:6379
      - JWT_SECRET=⟬opaque_token#1⟭
      - COOKIE_SECRET=⟬opaque_token#2⟭
      - STRIPE_API_KEY=⟬stripe_secret_key#1⟭
      - ADMIN_CORS=https://⟬hostname#1⟭
      - MEDUSA_ADMIN_EMAIL=⟬email#2⟭
      - MEDUSA_ADMIN_PASSWORD=⟬password#1⟭
      - STORE_API_TOKEN=⟬jwt#1⟭

  postgres:
    image: postgres:16
    environment:
      POSTGRES_USER: medusa
      POSTGRES_PASSWORD: ⟬url_password#1⟭

  redis:
    image: redis:7
⟬end⟭

⟬template⟭
family: config
format: docker-compose.yml
language: en
fill_locale: en_US
domain: healthcare
appearance: comment, YAML value, interpolation, label, list item
scenario: DICOM viewer demo stack maintained by a radiology IT team for vendor evaluations, using anonymized studies and environment interpolation
⟬text⟭
# Viewer demo. Studies under ./dicom are anonymized by the export tool.
# Run with: docker compose --env-file demo.env up -d
name: viewer-demo

services:
  orthanc:
    image: orthancteam/orthanc:24.9.1
    restart: unless-stopped
    ports:
      - "4242:4242"
      - "8042:8042"
    environment:
      ORTHANC__NAME: viewer-demo
      ORTHANC__AUTHENTICATION_ENABLED: "true"
      ORTHANC__REGISTERED_USERS: '{"viewer": "⟬trap:placeholder|${ORTHANC_PASSWORD}⟭"}'
      ORTHANC__DICOM_WEB__ENABLE: "true"
      DICOM_WEB_PLUGIN_ENABLED: "true"
    volumes:
      - ./dicom:/var/lib/orthanc/db

  ohif:
    image: ohif/app:v3.8.5
    ports:
      - "3000:80"
    environment:
      APP_CONFIG: /usr/share/nginx/html/app-config.js
      ⟬trap:indicator_non_pii|PATIENT_NAME_DISPLAY: anonymized⟭
    volumes:
      - ./ohif/app-config.js:/usr/share/nginx/html/app-config.js:ro
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.ohif.rule=Host(`⟬hostname#1⟭`)"

  oauth-proxy:
    image: quay.io/oauth2-proxy/oauth2-proxy:v7.7.1
    environment:
      OAUTH2_PROXY_PROVIDER: oidc
      OAUTH2_PROXY_OIDC_ISSUER_URL: ⟬url#1⟭
      OAUTH2_PROXY_CLIENT_ID: ⟬uuid#1⟭
      OAUTH2_PROXY_CLIENT_SECRET: ⟬trap:placeholder|${OIDC_CLIENT_SECRET}⟭
      OAUTH2_PROXY_COOKIE_SECRET: ⟬trap:placeholder|${COOKIE_SECRET:?generate one}⟭
      ⟬trap:indicator_non_pii|OAUTH2_PROXY_EMAIL_DOMAINS: "*"⟭
      OAUTH2_PROXY_UPSTREAMS: http://ohif:80

  anonymizer:
    image: ⟬hostname#2⟭/imaging/dicom-anonymizer:⟬version#1⟭
    environment:
      PROFILE: dicom-ps3.15-basic
      ⟬trap:indicator_non_pii|PATIENT_NAME_REPLACEMENT: ANON⟭
      ⟬trap:indicator_non_pii|BIRTH_DATE_ACTION: remove⟭
      OUTPUT_DIR: /dicom
    volumes:
      - ./incoming:/incoming:ro
      - ./dicom:/dicom

  traefik:
    image: traefik:v3.1
    command:
      - --providers.docker=true
      - --providers.docker.exposedbydefault=false
      - --entrypoints.web.address=:80
    ports:
      - "80:80"
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock:ro
⟬end⟭

⟬template⟭
family: config
format: docker-compose.yml
language: en
fill_locale: en_US
domain: logistics
appearance: YAML value, comment
scenario: small compose file for a pallet label OCR box at a loading dock, kept on the device and on a USB stick
⟬text⟭
# dock 4 ocr box
services:
  ocr:
    image: ⟬hostname#1⟭/dock/label-ocr:⟬version#1⟭
    devices:
      - /dev/video0
    environment:
      HF_TOKEN: ⟬huggingface_token#1⟭
      OCR_MODEL: microsoft/trocr-base-printed
      UPLOAD_BUCKET: dock4-labels
      AWS_ACCESS_KEY_ID: ⟬aws_access_key_id#1⟭
      AWS_SECRET_ACCESS_KEY: ⟬aws_secret_access_key#1⟭
      FLEET_PLATE_DEFAULT: "⟬us_license_plate#2⟭"
    restart: always
⟬end⟭

⟬template⟭
family: config
format: .json
language: en
fill_locale: en_US
domain: media
appearance: nested JSON, string value, shell command
scenario: dev container of a recommendation research repo, in which a researcher typed their keys and identity into containerEnv and postCreateCommand
⟬text⟭
{
  "name": "reco-research",
  "image": "mcr.microsoft.com/devcontainers/python:3.11",
  "features": {
    "ghcr.io/devcontainers/features/nvidia-cuda:1": {},
    "ghcr.io/devcontainers/features/git-lfs:1": {}
  },
  "containerEnv": {
    "HF_TOKEN": "⟬huggingface_token#1⟭",
    "OPENAI_API_KEY": "⟬openai_api_key#1⟭",
    "WB_RUN_CTX": "⟬opaque_token#1⟭",
    "PYTHONUNBUFFERED": "1"
  },
  "postCreateCommand": "git config --global user.name \"⟬person_name#2⟭\" && git config --global user.email ⟬email#2⟭ && pip install -e .[dev]",
  "customizations": {
    "vscode": {
      "extensions": ["ms-python.python", "ms-toolsai.jupyter"],
      "settings": {
        "python.defaultInterpreterPath": "/usr/local/bin/python"
      }
    }
  },
  "mounts": [
    "source=hf-cache,target=/root/.cache/huggingface,type=volume"
  ],
  "remoteUser": "root"
}
⟬end⟭

⟬template⟭
family: config
format: .json
language: en
fill_locale: en_US
domain: retail
appearance: nested JSON, connection string, string value
scenario: local.settings.json of Azure Functions that sync prices with a supplier, committed because the template repository had no ignore rule for it
⟬text⟭
{
  "IsEncrypted": false,
  "Values": {
    "FUNCTIONS_WORKER_RUNTIME": "node",
    "AzureWebJobsStorage": "DefaultEndpointsProtocol=https;AccountName=pricesyncdev;AccountKey=⟬opaque_token#1⟭;EndpointSuffix=core.windows.net",
    "SUPPLIER_SFTP": "sftp://pricefeed:⟬url_password#1⟭@⟬hostname#1⟭:2222/out",
    "SENDGRID_API_KEY": "⟬sendgrid_api_key#1⟭",
    "PRICE_ALERT_TO": "⟬email#2⟭",
    "CATALOG_TOKEN": "⟬jwt#1⟭",
    "PRICE_FEED_SEED": "⟬opaque_token#2⟭",
    "ROUNDING_RULE": "⟬trap:code_identifier|round⦃Family⦄Ending⟭",
    "⟬trap:indicator_non_pii|MAX_PASSWORD_AGE_DAYS⟭": "90"
  },
  "Host": {
    "LocalHttpPort": 7071,
    "CORS": "*"
  }
}
⟬end⟭

⟬template⟭
family: config
format: .toml
language: en
fill_locale: en_US
domain: logistics
appearance: comment, section header, string value, interpolation, array of tables
scenario: Telegraf agent config on refrigerated trailers gateways, shipped to the fleet with all tokens read from the environment
⟬text⟭
# telegraf.conf, reefer gateways
# Tokens come from /etc/default/telegraf, which the provisioning job writes.

[global_tags]
  fleet = "reefer"
  ⟬trap:indicator_non_pii|owner = "cold-chain-ops"⟭

[agent]
  interval = "30s"
  round_interval = true
  metric_batch_size = 500
  flush_interval = "60s"
  hostname = ""
  omit_hostname = false

[[outputs.influxdb_v2]]
  urls = ["⟬url#1⟭"]
  token = "⟬trap:placeholder|${INFLUX_TOKEN}⟭"
  organization = "cold-chain"
  bucket = "reefers"

[[outputs.http]]
  url = "⟬url#2⟭"
  method = "POST"
  data_format = "json"
  [outputs.http.headers]
    ⟬trap:indicator_non_pii|X-Api-Key-Id = "fleet-gateway"⟭
    Authorization = "⟬trap:placeholder|Bearer ${FLEET_API_TOKEN}⟭"

[[inputs.mqtt_consumer]]
  servers = ["tcp://127.0.0.1:1883"]
  topics = ["reefer/+/temperature", "reefer/+/door"]
  ⟬trap:indicator_non_pii|username = "telegraf"⟭
  password = "⟬trap:placeholder|${MQTT_PASSWORD}⟭"
  data_format = "json"

[[inputs.modbus]]
  name = "compressor"
  controller = "tcp://192.168.8.20:502"
  slave_id = 1
  # readings are smoothed with a ⟬trap:eponym|Kalman⟭ filter downstream
  holding_registers = [
    { name = "setpoint", byte_order = "AB", data_type = "INT16", scale = 0.1, address = [10] },
  ]

[[inputs.cpu]]
  percpu = false

[[inputs.mem]]

[[inputs.net]]
  interfaces = ["wwan0", "eth0"]

[[inputs.exec]]
  commands = ["/usr/local/bin/read-gps --json"]
  timeout = "5s"
  data_format = "json"
  name_override = "gps"
  tag_keys = ["trailer_id"]

[[processors.rename]]
  [[processors.rename.replace]]
    field = "temp_c"
    dest = "temperature"

[[aggregators.basicstats]]
  period = "5m"
  drop_original = false
  stats = ["mean", "min", "max"]
⟬end⟭

⟬template⟭
family: config
format: .toml
language: en
fill_locale: en_US
domain: SaaS
appearance: comment, section header, string value
scenario: netlify.toml of a developer docs site, in which the build environment table was used as a shortcut for tokens
⟬text⟭
[build]
  command = "npm run build"
  publish = "build"

[build.environment]
  NODE_VERSION = "20"
  # needed for the private theme
  NPM_TOKEN = "⟬npm_token#1⟭"
  ALGOLIA_ADMIN_KEY = "⟬opaque_token#1⟭"
  DOCS_AI_KEY = "⟬anthropic_api_key#1⟭"

[context.production.environment]
  HF_TOKEN = "⟬huggingface_token#1⟭"
  CONTACT_FORM_SENDGRID = "⟬sendgrid_api_key#1⟭"

[[redirects]]
  from = "/v1/*"
  to = "/docs/legacy/:splat"
  status = 301

[[headers]]
  for = "/*"
  [headers.values]
    X-Frame-Options = "DENY"
⟬end⟭

⟬template⟭
family: config
format: .npmrc
language: en
fill_locale: en_US
domain: logistics
appearance: comment, assignment
scenario: registry setup for a carrier integration package, with a comment about whose token it is
⟬text⟭
; ⟬person_name#1⟭'s token, expires ⟬date#1⟭, ask for a group one
⟬trap:email_lookalike|@carrier-kit:registry⟭=https://⟬hostname#2⟭/api/v4/groups/57/-/packages/npm/
//⟬hostname#2⟭/api/v4/groups/57/-/packages/npm/:_authToken=⟬gitlab_token#1⟭
⟬end⟭

⟬template⟭
family: config
format: .npmrc
language: en
fill_locale: en_US
domain: fintech
appearance: comment, assignment, url
scenario: .npmrc in the docker build context of a compliance dashboard, with the automation token, a proxy with credentials and a corporate CA path
⟬text⟭
# copied in by the Dockerfile, removed in the last layer (it is not removed, see ⟬ticket_id#1⟭)
//registry.npmjs.org/:_authToken=⟬npm_token#1⟭
proxy=http://svc_npm:⟬url_password#1⟭@⟬hostname#1⟭:8080/
https-proxy=http://svc_npm:⟬url_password#1⟭@⟬hostname#1⟭:8080/
cafile=/etc/ssl/corp-ca.pem
strict-ssl=true
progress=false
⟬trap:indicator_non_pii|init-author-name=compliance-tooling⟭
⟬end⟭

⟬template⟭
family: config
format: .ini
language: en
fill_locale: en_US
domain: fintech
appearance: comment, section header, assignment
scenario: uWSGI configuration of a statement rendering service, in which environment entries only set non-sensitive switches
⟬text⟭
[uwsgi]
module = statements.wsgi:application
master = true
processes = 8
threads = 2
socket = /run/statements/uwsgi.sock
chmod-socket = 660
vacuum = true
die-on-term = true
harakiri = 60
max-requests = 2000
buffer-size = 32768
; secrets are read from the mounted vault file, see settings.py
env = DJANGO_SETTINGS_MODULE=statements.settings.prod
env = RENDER_ENGINE=⟬trap:library|weasyprint⟭
env = ⟬trap:indicator_non_pii|STATEMENT_ACCOUNT_MASK=****⟭
env = ⟬trap:indicator_non_pii|SECRETS_FILE=/vault/secrets/statements.json⟭
logto = /var/log/statements/uwsgi.log
log-5xx = true
⟬end⟭

⟬template⟭
family: config
format: .ini
language: en
fill_locale: en_US
domain: retail
appearance: section header, assignment, quoted value, comment
scenario: supervisord config of a product copywriting worker on a single VM, with all the keys on one environment line
⟬text⟭
[supervisord]
nodaemon=false
logfile=/var/log/supervisord.log

[program:copy-worker]
command=/srv/copy/.venv/bin/python -m copywriter.worker --queue listings
directory=/srv/copy
user=www-data
numprocs=2
process_name=%(program_name)s_%(process_num)02d
autorestart=true
environment=OPENAI_API_KEY="⟬openai_api_key#1⟭",HF_TOKEN="⟬huggingface_token#1⟭",PIM_TOKEN="⟬opaque_token#1⟭"

[program:thumbnailer]
command=/srv/copy/.venv/bin/python -m copywriter.thumbs
directory=/srv/copy
; bucket is shared with the ad team
environment=AWS_ACCESS_KEY_ID="⟬aws_access_key_id#1⟭",AWS_SECRET_ACCESS_KEY="⟬aws_secret_access_key#1⟭",MEDIA_BUCKET="listing-media"
autorestart=unexpected
⟬end⟭
