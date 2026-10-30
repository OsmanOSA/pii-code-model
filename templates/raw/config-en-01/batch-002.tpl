⟬template⟭
family: config
format: .env
language: en
fill_locale: en_US
domain: retail
appearance: comment, assignment, quoted value
scenario: local overrides of a returns portal, written by a freelance developer on a branch where .gitignore had been broken for weeks
⟬text⟭
# returns-portal, local overrides
# dont commit this, gitignore is busted on this branch
APP_URL=https://⟬hostname#1⟭
SESSION_SECRET=⟬opaque_token#1⟭
INTERNAL_API_TOKEN=⟬jwt#1⟭

STRIPE_SECRET_KEY=⟬stripe_secret_key#1⟭
STRIPE_PUBLISHABLE_KEY=⟬stripe_publishable_key#1⟭
STRIPE_WHSEC=⟬opaque_token#2⟭

OPENAI_API_KEY=⟬openai_api_key#1⟭
RETURN_REASON_MODEL=gpt-4o-mini
⟬trap:indicator_non_pii|OPENAI_MAX_TOKENS=256⟭

AWS_DEFAULT_REGION=us-east-2
AWS_ACCESS_KEY_ID=⟬aws_access_key_id#1⟭
AWS_SECRET_ACCESS_KEY=⟬aws_secret_access_key#1⟭
LABEL_BUCKET=returns-labels-dev

SLACK_BOT_TOKEN=⟬slack_token#1⟭
SLACK_RETURNS_CHANNEL=returns-triage

# warehouse that receives the parcels
RMA_SHIP_TO="⟬postal_address#2⟭"
RMA_RECIPIENT="⟬company#2⟭"
#RMA_SHIP_TO="⟬postal_address#3⟭"
⟬end⟭

⟬template⟭
family: config
format: .env
language: en
fill_locale: en_US
domain: healthcare
appearance: comment, assignment, quoted value, test fixture
scenario: staging file of an appointment reminder service with a seed patient that QA asked for, sitting next to the sender credentials
⟬text⟭
# reminder-svc :: STAGING
APP_ENV=staging
REMINDER_WINDOW_HOURS=48
SMS_ENABLED=true

SENDGRID_API_KEY=⟬sendgrid_api_key#1⟭
SMS_GATEWAY_REF=⟬opaque_token#1⟭
SMS_SENDER="⟬phone#3⟭"
SCHEDULER_JWT=⟬jwt#1⟭
⟬trap:indicator_non_pii|DOB_DISPLAY_FORMAT=MM/DD/YYYY⟭

DB_DSN=postgres://reminders:⟬url_password#1⟭@⟬hostname#1⟭:5432/reminders

# seed patient for the e2e run, QA keeps asking for it
SEED_PATIENT_NAME="⟬person_name#2⟭"
SEED_PATIENT_DOB="⟬birth_date#2⟭"
SEED_PATIENT_SSN="⟬us_ssn#2⟭"
SEED_PATIENT_PHONE="⟬phone#2⟭"
SEED_PATIENT_EMAIL=⟬email#2⟭
SEED_ENROLLED_ON="⟬date#2⟭"
SEED_NEXT_VISIT="⟬date#1⟭"
⟬end⟭

⟬template⟭
family: config
format: .env
language: en
fill_locale: en_US
domain: logistics
appearance: comment, assignment, interpolation
scenario: env file sourced by a CI job of a customs document service, in which every secret is a reference to a masked CI variable
⟬text⟭
# Sourced by the integration job. Masked CI variables only.
CI=true
NODE_ENV=test
GITLAB_TOKEN=⟬trap:placeholder|$CI_JOB_TOKEN⟭
NPM_TOKEN=⟬trap:placeholder|${NPM_CI_TOKEN}⟭
AWS_ACCESS_KEY_ID=⟬trap:placeholder|${CI_AWS_KEY_ID}⟭
AWS_SECRET_ACCESS_KEY=⟬trap:placeholder|${CI_AWS_SECRET}⟭
CUSTOMS_API_URL=⟬url#1⟭
⟬trap:indicator_non_pii|CUSTOMS_API_KEY_HEADER=X-Broker-Key⟭
⟬trap:indicator_non_pii|TEST_USER=integration⟭
BUILD_REF=⟬git_sha#1⟭
⟬end⟭

⟬template⟭
family: config
format: Terraform .tfvars
language: en
fill_locale: en_US
domain: fintech
appearance: comment, assignment, map value, list item
scenario: terraform.tfvars of an underwriting model endpoint, assembled by a data scientist copying values out of notebooks
⟬text⟭
# underwriting-llm, sagemaker endpoint + gateway
# copied from my notebook, cleanup later
region        = "us-east-1"
stage         = "uat"
name          = "underwriting-llm"

aws_key_id     = "⟬aws_access_key_id#1⟭"
aws_key_secret = "⟬aws_secret_access_key#1⟭"

endpoint_instance_type = "ml.g5.2xlarge"
endpoint_min_capacity  = 1
endpoint_max_capacity  = 4
model_data_bucket      = "uw-llm-artifacts-uat"
hf_model_id            = "meta-llama/Llama-3.2-11B-Vision"
hf_token               = "⟬huggingface_token#1⟭"

fallback_provider = "openai"
fallback_model    = "gpt-4.1"
fallback_api_key  = "⟬openai_api_key#1⟭"

# kept for the regulators' replay job
audit_bucket          = "uw-llm-audit-uat"
audit_retention_days  = 2555
audit_contact         = "⟬person_name#2⟭"
audit_contact_mail    = "⟬email#2⟭"

allowed_cidrs = [
  "10.8.0.0/16",
  "⟬ip_address#1⟭",
]

gateway_hostname = "⟬hostname#1⟭"
gateway_sig      = "⟬opaque_token#1⟭"
⟬trap:indicator_non_pii|api_key_rotation_days = 30⟭
# data capture for the fair lending review
capture_enabled        = true
capture_sampling_pct   = 100
capture_bucket_prefix  = "datacapture/"
⟬trap:indicator_non_pii|applicant_name_in_prompts = false⟭
⟬trap:indicator_non_pii|ssn_in_prompts            = false⟭
⟬trap:indicator_non_pii|dob_in_prompts            = false⟭
feature_store_group    = "uw-applicant-features"
max_tokens             = 2048
temperature            = 0
timeout_seconds        = 30

# cost guardrails
monthly_budget_usd     = 18000
budget_alert_percent   = [50, 80, 100]
scale_down_after_idle  = 900

alarm_recipients = [
  "⟬email#2⟭",
  "⟬email:generic#3⟭",
]

tags = {
  team       = "credit-risk"
  owner      = "⟬person_name#2⟭"
  reviewed   = "⟬trap:initials|R.K.⟭"
}
⟬end⟭

⟬template⟭
family: config
format: Terraform .tfvars
language: en
fill_locale: en_US
domain: media
appearance: comment, assignment, map value, list item
scenario: tfvars feeding a module that pushes GitHub Actions secrets to every repository of a streaming company's web team
⟬text⟭
# module.repo_secrets: one map, pushed to each repo below
github_org   = "stillwater-media"
github_token = "⟬github_token#1⟭"

repositories = [
  "web-player",
  "ad-server",
  "cms-bridge",
  "subtitle-editor",
]

actions_secrets = {
  NPM_TOKEN         = "⟬npm_token#1⟭"
  ANTHROPIC_API_KEY = "⟬anthropic_api_key#1⟭"
  SENTRY_AUTH_TOKEN = "⟬opaque_token#1⟭"
  DOCKERHUB_ROBOT   = "⟬opaque_token#2⟭"
  SLACK_DEPLOY_HOOK = "⟬opaque_token#3⟭"
}

actions_variables = {
  NODE_VERSION = "20"
  PLAYER_CDN   = "⟬url#1⟭"
}
⟬end⟭

⟬template⟭
family: config
format: Terraform .tfvars
language: en
fill_locale: en_US
domain: retail
appearance: comment, assignment, map value
scenario: dev.tfvars of an inventory service on ECS, with the only credential left as an obvious stand-in and sign-off initials in a comment
⟬text⟭
# inventory-svc dev, sized for one developer at a time
# sizing ok'd by ⟬trap:initials|JD⟭ and ⟬trap:initials|MK⟭ on ⟬date#1⟭
env               = "dev"
aws_region        = "us-east-1"
cluster_name      = "inventory-dev"
service_cpu       = 256
service_memory    = 512
desired_count     = 1
autoscaling       = false
image_tag         = "⟬git_sha#1⟭"
listener_host     = "⟬hostname#1⟭"
log_retention     = 3
db_snapshot       = "inventory-prod-scrubbed-latest"
⟬trap:indicator_non_pii|db_user = "inventory"⟭
db_pass           = "⟬trap:placeholder|REPLACE_ME⟭"
⟬trap:indicator_non_pii|api_token_ttl = 3600⟭
feature_flags = {
  reserve_on_cart = true
  low_stock_badge = "⟬trap:word_name|amber⟭"
}
⟬end⟭

⟬template⟭
family: config
format: Kubernetes .yaml
language: en
fill_locale: en_US
domain: logistics
appearance: comment, YAML value, single-quoted JSON, nested map
scenario: Helm values of a parcel tracking API on a cluster with a first name as its codename, with static AWS keys left over from before IRSA
⟬text⟭
# helm upgrade --install -f values-prod.yaml tracking ./chart
replicaCount: 4

image:
  repository: ⟬hostname#1⟭/tracking/api
  tag: ⟬version#1⟭
  pullPolicy: IfNotPresent

imagePullSecret:
  create: true
  dockerconfigjson: '{"auths":{"⟬hostname#1⟭":{"username":"gitlab-ci-token","password":"⟬gitlab_token#1⟭"}}}'

global:
  cluster: ⟬trap:code_identifier|⦃given⦄-prod⟭
  region: us-east-1

env:
  AWS_REGION: us-east-1
  # TODO drop once irsa works on this cluster
  AWS_ACCESS_KEY_ID: ⟬aws_access_key_id#1⟭
  AWS_SECRET_ACCESS_KEY: ⟬aws_secret_access_key#1⟭
  EVENTS_TOPIC: arn:aws:sns:us-east-1:210987654321:parcel-events
  sig: ⟬opaque_token#1⟭
  ⟬trap:indicator_non_pii|CARRIER_API_KEY_HEADER: X-Carrier-Key⟭

ingress:
  enabled: true
  className: nginx
  hosts:
    - host: ⟬hostname#2⟭
      paths:
        - path: /
          pathType: Prefix

resources:
  requests:
    cpu: 500m
    memory: 768Mi
  limits:
    memory: 1536Mi

podAnnotations:
  prometheus.io/scrape: "true"
  prometheus.io/port: "9102"
  owner: ⟬person_name:handle#2⟭

autoscaling:
  enabled: true
  minReplicas: 4
  maxReplicas: 24
  targetCPUUtilizationPercentage: 65

pdb:
  minAvailable: 2

livenessProbe:
  httpGet:
    path: /live
    port: http
  periodSeconds: 20

nodeSelector:
  workload: tracking

tolerations:
  - key: dedicated
    operator: Equal
    value: tracking
    effect: NoSchedule
⟬end⟭

⟬template⟭
family: config
format: Kubernetes .yaml
language: en
fill_locale: en_US
domain: SaaS
appearance: YAML value, label, url
scenario: Argo CD repository credentials written during a migration from a self-hosted GitLab to GitHub, with both still in use
⟬text⟭
apiVersion: v1
kind: Secret
metadata:
  name: repo-platform-charts
  namespace: argocd
  labels:
    argocd.argoproj.io/secret-type: repository
stringData:
  type: git
  url: https://⟬hostname#1⟭/platform/charts.git
  username: ⟬username#1⟭
  password: ⟬gitlab_token#1⟭
---
apiVersion: v1
kind: Secret
metadata:
  name: repo-tenant-apps
  namespace: argocd
  labels:
    argocd.argoproj.io/secret-type: repo-creds
stringData:
  type: git
  url: https://github.com/relay-works
  ⟬trap:indicator_non_pii|username: x-access-token⟭
  password: ⟬github_token#1⟭
⟬end⟭

⟬template⟭
family: config
format: Kubernetes .yaml
language: en
fill_locale: en_US
domain: media
appearance: comment, YAML value, nested map, list item, block scalar
scenario: monitoring stack values of an ad-tech team, with alert routes spelled out and every credential pointing at an existing Secret
⟬text⟭
# kube-prometheus-stack values, ad delivery clusters
# No credentials in this file: see the sealed secrets repository.
fullnameOverride: monitoring

⟬trap:library|prometheus⟭:
  prometheusSpec:
    retention: 15d
    scrapeInterval: 30s
    externalLabels:
      cluster: ⟬trap:code_identifier|⦃family⦄-ads-1⟭
      region: us-central1
    storageSpec:
      volumeClaimTemplate:
        spec:
          storageClassName: ssd
          resources:
            requests:
              storage: 200Gi
    remoteWrite:
      - url: ⟬url#1⟭
        basicAuth:
          username:
            name: remote-write
            key: ⟬trap:indicator_non_pii|username⟭
          password:
            name: remote-write
            key: ⟬trap:indicator_non_pii|password⟭

grafana:
  enabled: true
  admin:
    existingSecret: grafana-admin
    userKey: ⟬trap:indicator_non_pii|admin-user⟭
    passwordKey: ⟬trap:indicator_non_pii|admin-password⟭
  ingress:
    enabled: true
    hosts:
      - ⟬hostname#1⟭
  grafana.ini:
    server:
      root_url: https://⟬hostname#1⟭
    auth.generic_oauth:
      enabled: true
      client_id: ⟬uuid#1⟭
      client_secret: ⟬trap:placeholder|$__file{/etc/secrets/oidc/client-secret}⟭

alertmanager:
  config:
    route:
      receiver: slack-ads
      group_by: ["alertname", "cluster"]
      group_wait: 30s
      repeat_interval: 4h
      routes:
        - matchers: ['severity="page"']
          receiver: pagerduty-ads
    receivers:
      - name: slack-ads
        slack_configs:
          - api_url_file: /etc/alertmanager/secrets/slack/url
            channel: "#ads-alerts"
      - name: pagerduty-ads
        pagerduty_configs:
          - routing_key_file: /etc/alertmanager/secrets/pagerduty/key

additionalPrometheusRulesMap:
  ads:
    groups:
      - name: delivery
        rules:
          - alert: BidLatencyHigh
            expr: histogram_quantile(0.99, sum(rate(bid_duration_seconds_bucket[5m])) by (le)) > 0.12
            for: 10m
            labels:
              severity: page
            annotations:
              # latency budget from the ⟬trap:eponym|Erlang⟭ C model of the bidder pool
              summary: p99 bid latency above budget
⟬end⟭

⟬template⟭
family: config
format: docker-compose.yml
language: en
fill_locale: en_US
domain: healthcare
appearance: environment list, comment, YAML value
scenario: workflow automation box of a dental group's front office, stood up over a weekend by the office manager's nephew
⟬text⟭
# n8n for intake forms -> practice software
# ⟬person_name#1⟭ set this up, ask them before changing anything
# ⟬password#1⟭ is also the front desk wifi, dont ask
services:
  n8n:
    image: n8nio/n8n:1.62.1
    restart: unless-stopped
    ports:
      - "5678:5678"
    environment:
      - N8N_HOST=⟬hostname#1⟭
      - N8N_PROTOCOL=https
      - WEBHOOK_URL=https://⟬hostname#1⟭/
      - N8N_BASIC_AUTH_ACTIVE=true
      - N8N_BASIC_AUTH_USER=⟬email#1⟭
      - N8N_BASIC_AUTH_PASSWORD=⟬password#1⟭
      - N8N_ENCRYPTION_KEY=⟬opaque_token#1⟭
      - OPENAI_API_KEY=⟬openai_api_key#1⟭
      - SENDGRID_API_KEY=⟬sendgrid_api_key#1⟭
      - GENERIC_TIMEZONE=America/New_York
      - PRACTICE_MAIN_LINE=⟬phone#2⟭
    volumes:
      - ./n8n-data:/home/node/.n8n

  backup:
    image: offen/docker-volume-backup:v2
    environment:
      AWS_S3_BUCKET_NAME: dental-intake-backup
      AWS_ACCESS_KEY_ID: ⟬aws_access_key_id#1⟭
      AWS_SECRET_ACCESS_KEY: ⟬aws_secret_access_key#1⟭
    volumes:
      - ./n8n-data:/backup/n8n:ro
⟬end⟭

⟬template⟭
family: config
format: docker-compose.yml
language: en
fill_locale: en_US
domain: fintech
appearance: comment, YAML value, test fixture, quoted value
scenario: open banking sandbox that the QA lead runs on a laptop, with a dev Vault, a LocalStack and a fake payee taken from a real-looking test sheet
⟬text⟭
# sandbox for the payments squad
services:
  vault:
    image: hashicorp/vault:1.17
    cap_add: [IPC_LOCK]
    environment:
      VAULT_DEV_ROOT_TOKEN_ID: ⟬opaque_token#1⟭
      VAULT_DEV_LISTEN_ADDRESS: 0.0.0.0:8200

  localstack:
    image: localstack/localstack:3.8
    ports:
      - "4566:4566"
    environment:
      SERVICES: s3,sqs,kms
      AWS_ACCESS_KEY_ID: ⟬aws_access_key_id#1⟭
      AWS_SECRET_ACCESS_KEY: ⟬aws_secret_access_key#1⟭

  ledger-sim:
    image: ⟬hostname#1⟭/payments/ledger-sim:⟬version#1⟭
    environment:
      VAULT_ADDR: http://vault:8200
      VAULT_TOKEN: ⟬opaque_token#1⟭
      ⟬trap:indicator_non_pii|DEFAULT_ACCOUNT_OWNER: sandbox⟭
      PAYEE_NAME: "⟬person_name#2⟭"
      PAYEE_ACCOUNT: "⟬bank_account_number#2⟭"
      PAYEE_IBAN: "⟬iban#2⟭"
      PAYEE_BIC: "⟬bic#2⟭"
      TEST_CARD: "⟬payment_card#2⟭"
      TEST_CARD_CVC: "⟬card_security_code#2⟭"
      TEST_CARD_EXP: "12/29"
    depends_on: [vault, localstack]
⟬end⟭

⟬template⟭
family: config
format: docker-compose.yml
language: en
fill_locale: en_US
domain: SaaS
appearance: YAML value, quoted value, comment
scenario: self-hosted Renovate on a small team's utility server, with its bot identity and tokens written inline
⟬text⟭
services:
  renovate:
    image: renovate/renovate:38
    environment:
      RENOVATE_PLATFORM: github
      RENOVATE_TOKEN: ⟬github_token#1⟭
      RENOVATE_AUTODISCOVER: "true"
      RENOVATE_GIT_AUTHOR: "⟬trap:indicator_non_pii|Renovate Bot⟭ <⟬email:generic#1⟭>"
      # private scope lives on npmjs
      RENOVATE_NPMRC: "//registry.npmjs.org/:_authToken=⟬npm_token#1⟭"
      LOG_LEVEL: info
⟬end⟭

⟬template⟭
family: config
format: .json
language: en
fill_locale: en_US
domain: retail
appearance: string value, escaped private key, url
scenario: Google service account key of a point-of-sale analytics export, dropped into the project root to make a report script work
⟬text⟭
{
  "type": "service_account",
  "project_id": "pos-analytics-prod",
  "private_key_id": "⟬hash#1⟭",
  "private_key": "⟬private_key#1⟭",
  "client_email": "⟬email:generic#1⟭",
  "client_id": "108427716350249918237",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "universe_domain": "googleapis.com"
}
⟬end⟭

⟬template⟭
family: config
format: .json
language: en
fill_locale: en_US
domain: media
appearance: nested JSON, string value, list item
scenario: package.json of an internal video player library, published to a private registry with no personal author on record
⟬text⟭
{
  "name": "⟬trap:email_lookalike|@stillwater/player-core⟭",
  "version": "⟬version#1⟭",
  "description": "Adaptive streaming player shared by the web apps",
  "author": "⟬trap:indicator_non_pii|Web Platform Team⟭",
  "license": "UNLICENSED",
  "private": false,
  "type": "module",
  "main": "dist/index.cjs",
  "module": "dist/index.js",
  "types": "dist/index.d.ts",
  "files": ["dist", "README.md"],
  "publishConfig": {
    "registry": "⟬url#1⟭",
    "access": "restricted"
  },
  "scripts": {
    "build": "tsup src/index.ts --format esm,cjs --dts",
    "test": "⟬trap:library|jest⟭ --coverage",
    "lint": "eslint src --max-warnings 0",
    "storybook": "storybook dev -p 6006",
    "release": "changeset publish"
  },
  "peerDependencies": {
    "react": ">=18"
  },
  "dependencies": {
    "hls.js": "^1.5.15",
    "⟬trap:email_lookalike|@tanstack/react-query⟭": "^5.59.0"
  },
  "devDependencies": {
    "⟬trap:email_lookalike|@changesets/cli⟭": "^2.27.9",
    "⟬trap:email_lookalike|@types/node⟭": "^20.16.0",
    "⟬trap:email_lookalike|@types/react⟭": "^18.3.11",
    "eslint": "^9.12.0",
    "⟬trap:library|jest⟭": "^29.7.0",
    "storybook": "^8.3.5",
    "tsup": "^8.3.0",
    "typescript": "^5.6.3"
  },
  "engines": {
    "node": ">=20"
  },
  "exports": {
    ".": {
      "import": "./dist/index.js",
      "require": "./dist/index.cjs",
      "types": "./dist/index.d.ts"
    },
    "./styles.css": "./dist/styles.css"
  },
  "browserslist": ["last 2 Chrome versions", "last 2 Safari versions", "Firefox ESR"],
  "⟬trap:library|jest⟭": {
    "testEnvironment": "jsdom",
    "collectCoverageFrom": ["src/**/*.{ts,tsx}"],
    "coverageThreshold": {
      "global": { "lines": 85 }
    }
  },
  "lint-staged": {
    "*.{ts,tsx}": "eslint --fix"
  },
  "sideEffects": false
}
⟬end⟭

⟬template⟭
family: config
format: .json
language: en
fill_locale: en_US
domain: healthcare
appearance: nested JSON, connection string, string value
scenario: appsettings.Production.json of a .NET intake API, which a vendor shipped inside the installer package
⟬text⟭
{
  "Logging": {
    "LogLevel": {
      "Default": "Information",
      "Microsoft.AspNetCore": "Warning"
    }
  },
  "AllowedHosts": "*",
  "ConnectionStrings": {
    "Intake": "Server=⟬hostname#1⟭,1433;Database=Intake;User Id=intake_app;Password=⟬password#1⟭;Encrypt=True;TrustServerCertificate=False;"
  },
  "Jwt": {
    "Issuer": "⟬url#1⟭",
    "SigningKey": "⟬opaque_token#1⟭",
    "ServiceToken": "⟬jwt#1⟭",
    "ExpiryMinutes": 30
  },
  "OpenAI": {
    "Endpoint": "https://api.openai.com/v1",
    "ApiKey": "⟬openai_api_key#1⟭",
    "Deployment": "gpt-4o"
  },
  "Mail": {
    "Provider": "SendGrid",
    "ApiKey": "⟬sendgrid_api_key#1⟭",
    "From": "⟬email:generic#2⟭",
    "EscalateTo": "⟬email#3⟭"
  },
  "Kestrel": {
    "Endpoints": {
      "Https": { "Url": "https://0.0.0.0:8443" }
    }
  },
  "RateLimiting": {
    "PermitLimit": 120,
    "WindowSeconds": 60,
    "QueueLimit": 10
  },
  "Intake": {
    "MaxUploadMegabytes": 25,
    "AllowedFormats": ["pdf", "png", "jpeg", "tiff"],
    "OcrEngine": "tesseract",
    "⟬trap:indicator_non_pii|PatientNameField⟭": "demographics.fullName",
    "⟬trap:indicator_non_pii|DobField⟭": "demographics.dob",
    "RetentionDays": 2190
  },
  "Fax": {
    "Provider": "phaxio",
    "ApiKey": "⟬opaque_token#2⟭",
    "ApiSecret": "⟬opaque_token#3⟭",
    "InboundNumber": "⟬phone#4⟭"
  },
  "Telemetry": {
    "OtlpEndpoint": "⟬url#2⟭",
    "SamplingPercent": 20
  },
  "Support": {
    "Vendor": "⟬company#2⟭",
    "PrimaryContact": "⟬person_name#3⟭",
    "Phone": "⟬phone#3⟭"
  }
}
⟬end⟭

⟬template⟭
family: config
format: .toml
language: en
fill_locale: en_US
domain: SaaS
appearance: comment, section header, string value, inline table
scenario: personal config of a terminal coding agent copied into dotfiles and pushed to a public repository by its owner
⟬text⟭
# ~/.config/agent/config.toml
model = "claude-sonnet-5-5"
fallback_model = "gpt-4.1"
approval_policy = "on-request"
sandbox = "workspace-write"

[providers.anthropic]
base_url = "https://api.anthropic.com"
api_key = "⟬anthropic_api_key#1⟭"

[providers.openai]
base_url = "https://api.openai.com/v1"
api_key = "⟬openai_api_key#1⟭"

[mcp.huggingface]
command = "uvx"
args = ["hf-mcp-server"]
env = { HF_TOKEN = "⟬huggingface_token#1⟭" }

[mcp.tracker]
url = "⟬url#1⟭"
headers = { "X-Client-Ref" = "⟬opaque_token#1⟭" }

[git]
⟬trap:indicator_non_pii|author_name = "agent"⟭
commit_trailer = "Co-authored-by: ⟬person_name#2⟭ <⟬email#2⟭>"
⟬end⟭

⟬template⟭
family: config
format: .toml
language: en
fill_locale: en_US
domain: retail
appearance: comment, section header, string value, array of tables
scenario: GitLab Runner config.toml of a point-of-sale firmware team, with its S3 cache credentials, restored from a server backup
⟬text⟭
concurrent = 6
check_interval = 0
shutdown_timeout = 0

[session_server]
  session_timeout = 1800

[[runners]]
  name = "pos-firmware-01"
  url = "https://⟬hostname#1⟭/"
  id = 412
  token = "⟬gitlab_token#1⟭"
  token_obtained_at = 2025-03-11T14:22:03Z
  token_expires_at = 0001-01-01T00:00:00Z
  executor = "docker"
  [runners.cache]
    Type = "s3"
    Shared = true
    [runners.cache.s3]
      ServerAddress = "s3.amazonaws.com"
      AccessKey = "⟬aws_access_key_id#1⟭"
      SecretKey = "⟬aws_secret_access_key#1⟭"
      BucketName = "pos-runner-cache"
      BucketLocation = "us-east-1"
  [runners.docker]
    image = "node:20-bookworm"
    privileged = false
    disable_cache = false
    volumes = ["/cache", "/var/run/docker.sock:/var/run/docker.sock"]
    shm_size = 0

[[runners]]
  name = "pos-firmware-arm"
  url = "https://⟬hostname#1⟭/"
  id = 418
  token = "⟬gitlab_token#2⟭"
  executor = "shell"
  environment = ["FIRMWARE_SIGN_PIN=⟬password#1⟭", "TZ=America/Chicago"]
[[runners]]
  name = "pos-firmware-nightly"
  url = "https://⟬hostname#1⟭/"
  id = 431
  token = "⟬gitlab_token#3⟭"
  executor = "docker+machine"
  limit = 4
  request_concurrency = 2
  output_limit = 8192
  pre_build_script = "git config --global url.\"https://oauth2:⟬gitlab_token#3⟭@⟬hostname#1⟭/\".insteadOf \"https://⟬hostname#1⟭/\""
  [runners.machine]
    IdleCount = 0
    IdleTime = 600
    MachineDriver = "amazonec2"
    MachineName = "pos-nightly-%s"
    MachineOptions = [
      "amazonec2-access-key=⟬aws_access_key_id#1⟭",
      "amazonec2-secret-key=⟬aws_secret_access_key#1⟭",
      "amazonec2-region=us-east-1",
      "amazonec2-instance-type=m6i.large",
    ]
  [runners.docker]
    image = "debian:bookworm"
    privileged = true
⟬end⟭

⟬template⟭
family: config
format: .npmrc
language: en
fill_locale: en_US
domain: fintech
appearance: assignment, url, comment
scenario: .npmrc pointing at a bank's Artifactory, generated by `npm login` and copied into a Dockerfile build context
⟬text⟭
registry=https://⟬hostname#1⟭/artifactory/api/npm/npm-virtual/
//⟬hostname#1⟭/artifactory/api/npm/npm-virtual/:_authToken=⟬jwt#1⟭
//⟬hostname#1⟭/artifactory/api/npm/npm-virtual/:email=⟬email#2⟭
//⟬hostname#1⟭/artifactory/api/npm/npm-virtual/:always-auth=true
strict-ssl=true
; proxy needed from the vdi only
https-proxy=http://⟬hostname#3⟭:3128/
⟬end⟭

⟬template⟭
family: config
format: .npmrc
language: en
fill_locale: en_US
domain: logistics
appearance: comment, assignment, interpolation
scenario: shared .npmrc of the route planner workspaces, with the token left to an environment variable and a long list of install settings
⟬text⟭
# route-planner workspaces
# CI exports NPM_TOKEN. Locally, run `npm login` instead of editing this file.
registry=https://registry.npmjs.org/
//registry.npmjs.org/:_authToken=⟬trap:placeholder|${NPM_TOKEN}⟭
⟬trap:email_lookalike|@routeplanner:registry⟭=https://registry.npmjs.org/

# install
engine-strict=true
save-exact=true
save-prefix=
package-lock=true
fund=false
audit-level=high
prefer-offline=true
fetch-retries=4
fetch-retry-mintimeout=20000
fetch-timeout=120000
maxsockets=12
legacy-peer-deps=false

# native modules (the ⟬trap:eponym|Hilbert⟭ curve index is compiled)
python=/usr/bin/python3
node-gyp=/usr/lib/node_modules/node-gyp/bin/node-gyp.js

# publishing
access=public
⟬trap:indicator_non_pii|sign-git-tag=false⟭
tag-version-prefix=
provenance=true
loglevel=warn
⟬end⟭

⟬template⟭
family: config
format: .ini
language: en
fill_locale: en_US
domain: SaaS
appearance: section header, assignment, comment
scenario: s3cmd configuration of a backup script on a billing server, found world-readable in a home directory during a review
⟬text⟭
[default]
access_key = ⟬aws_access_key_id#1⟭
secret_key = ⟬aws_secret_access_key#1⟭
bucket_location = US
host_base = s3.amazonaws.com
host_bucket = %(bucket)s.s3.amazonaws.com
# invoices are gpg'd before upload
encrypt = True
gpg_command = /usr/bin/gpg
gpg_passphrase = ⟬password#1⟭
use_https = True
check_ssl_certificate = True
multipart_chunk_size_mb = 64
progress_meter = False
⟬end⟭
