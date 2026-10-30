⟬template⟭
family: config
format: .env
language: en
fill_locale: en_US
domain: media
appearance: comment, assignment, section header, url
scenario: Docker env of a music licensing catalog, kept clean by the label's engineering lead so that it can go to outside auditors
⟬text⟭
# Catalog service, docker environment.
# All tokens below are stand-ins. Production values are in the label's vault.

## Service
SERVICE_PORT=8200
PUBLIC_URL=⟬url#1⟭
DEFAULT_LOCALE=en-US
CURRENCY=USD

## Rights holders
# Sample data only. ⟬trap:company_name|⦃Family⦄ Records⟭ and ⟬trap:company_name|⦃Family2⦄ & Sons Publishing⟭ are the two demo labels.
DEFAULT_LABEL=⟬trap:company_name|⦃Family⦄ Records⟭
⟬trap:indicator_non_pii|ARTIST_NAME_SEARCH=true⟭
⟬trap:indicator_non_pii|COMPOSER_NAME_REQUIRED=false⟭
ROYALTY_SPLIT_PRECISION=4

## Audio fingerprints
# Peaks are matched with a ⟬trap:eponym|Fourier⟭ transform, then a ⟬trap:eponym|Bloom⟭ filter
FINGERPRINT_WINDOW_MS=370
FINGERPRINT_BUCKET=fingerprints-dev

## Moods
# ⟬trap:word_name|Violet⟭, ⟬trap:word_name|Hunter⟭ and ⟬trap:word_name|Rose⟭ are playlist moods
MOOD_PRESETS=violet,hunter,rose

## Credentials
S3_ACCESS_KEY=⟬trap:placeholder|XXXXXXXXXXXXXXXXXXXX⟭
S3_SECRET_KEY=⟬trap:placeholder|xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx⟭
PRO_API_KEY=⟬trap:placeholder|<pro-api-key>⟭
⟬trap:indicator_non_pii|PRO_API_KEY_HEADER=X-Pro-Key⟭
DB_PASSWORD=⟬trap:placeholder|***⟭
⟬trap:indicator_non_pii|DB_USER=catalog⟭

## Release
BUILD=⟬version#1⟭
COMMIT=⟬git_sha#1⟭
⟬end⟭

⟬template⟭
family: config
format: .env
language: en
fill_locale: en_US
domain: fintech
appearance: comment, assignment, quoted value, test fixture
scenario: payouts sandbox env of a cross-border payroll startup, with a beneficiary used in demos to partner banks
⟬text⟭
# global-payouts sandbox
FX_RATE_API=⟬url#1⟭
FX_RATE_CLIENT=⟬opaque_token#1⟭
AWS_ACCESS_KEY_ID=⟬aws_access_key_id#1⟭
AWS_SECRET_ACCESS_KEY=⟬aws_secret_access_key#1⟭
RECON_ASSISTANT_KEY=⟬openai_api_key#1⟭

# demo beneficiary
BENEFICIARY_NAME="⟬person_name#2⟭"
BENEFICIARY_IBAN="⟬iban#2⟭"
BENEFICIARY_BIC="⟬bic#2⟭"
BENEFICIARY_COUNTRY="⟬country#2⟭"
BENEFICIARY_TAX_ID="⟬us_itin#2⟭"
⟬trap:indicator_non_pii|BENEFICIARY_NAME_MATCH_MIN=0.9⟭
LAST_PAYOUT_ON="⟬date#1⟭"
⟬end⟭

⟬template⟭
family: config
format: Terraform .tfvars
language: en
fill_locale: en_US
domain: healthcare
appearance: comment, assignment, object list, map value, list item
scenario: audit log archive settings of a health plan, with retention rules agreed with compliance and no sensitive input of any kind
⟬text⟭
# audit-archive / production
# Retention follows the compliance matrix signed off by ⟬trap:initials|T.W.⟭ on ⟬date#1⟭.
# Nothing sensitive here: the KMS key is created by this stack.

environment  = "production"
aws_region   = "us-east-1"
bucket_name  = "healthplan-audit-archive"
force_destroy = false
object_lock   = true
object_lock_mode  = "COMPLIANCE"
object_lock_years = 7
versioning        = true

lifecycle_rules = [
  {
    id              = "cloudtrail"
    prefix          = "cloudtrail/"
    transition_days = 30
    storage_class   = "GLACIER_IR"
    expiration_days = 2555
  },
  {
    id              = "app-audit"
    prefix          = "app/"
    transition_days = 90
    storage_class   = "DEEP_ARCHIVE"
    expiration_days = 3650
  },
  {
    id              = "access-logs"
    prefix          = "alb/"
    transition_days = 14
    storage_class   = "STANDARD_IA"
    expiration_days = 400
  },
]

replication = {
  enabled        = true
  destination    = "healthplan-audit-archive-dr"
  region         = "us-west-2"
  replica_class  = "GLACIER_IR"
}

log_sources = [
  "member-portal",
  "claims-adjudication",
  "provider-directory",
  "eligibility-gateway",
]

⟬trap:indicator_non_pii|member_identifier_hashing = "sha256"⟭
⟬trap:indicator_non_pii|patient_name_in_logs      = false⟭
⟬trap:indicator_non_pii|dob_in_logs               = false⟭
⟬trap:indicator_non_pii|ssn_in_logs               = false⟭

alert_sns_topic = "arn:aws:sns:us-east-1:210987654321:audit-archive"
athena_workgroup = "compliance-readonly"

tags = {
  ⟬trap:indicator_non_pii|owner = "compliance-engineering"⟭
  data_class = "audit"
  sox        = "in-scope"
}
⟬end⟭

⟬template⟭
family: config
format: Terraform .tfvars
language: en
fill_locale: en_US
domain: media
appearance: comment, assignment, map value
scenario: video pipeline variables of an online education publisher, with streaming and asset vendor credentials and a legal contact for takedowns
⟬text⟭
# course-video-pipeline
mux_token_id     = "⟬uuid#1⟭"
mux_token_secret = "⟬opaque_token#1⟭"

cloudinary_cloud  = "lecturehall"
cloudinary_key    = "⟬opaque_token#3⟭"
cloudinary_secret = "⟬opaque_token#2⟭"

chapters_model = "claude-haiku-5-5"
chapters_key   = "⟬anthropic_api_key#1⟭"

takedown_contact = {
  name  = "⟬person_name#2⟭"
  email = "⟬email#2⟭"
  phone = "⟬phone#2⟭"
}

studio_address = "⟬postal_address#3⟭"
⟬end⟭

⟬template⟭
family: config
format: Terraform .tfvars
language: en
fill_locale: en_US
domain: fintech
appearance: comment, assignment, heredoc, map value
scenario: bootstrap inputs of a brokerage's secrets platform, holding the one-time root token and a GitHub App key until the first apply
⟬text⟭
# vault-bootstrap, DELETE AFTER FIRST APPLY
vault_addr       = "https://⟬hostname#1⟭:8200"
vault_root_token = "⟬opaque_token#1⟭"
kv_mount         = "brokerage"
audit_device     = "file"

github_app_id = 998172
github_app_installation_id = 41882031
github_app_pem = <<-PEM
  ⟬private_key#1⟭
PEM

seed_secrets = {
  "ci/github_token"   = "⟬github_token#1⟭"
  "ci/npm_token"      = "⟬npm_token#1⟭"
  "ci/gitlab_token"   = "⟬gitlab_token#1⟭"
  "mail/sendgrid_key" = "⟬sendgrid_api_key#1⟭"
}

# break glass: ⟬person_name#2⟭ and ⟬person_name#3⟭ hold the unseal shards
unseal_shares    = 5
unseal_threshold = 3
⟬end⟭

⟬template⟭
family: config
format: Kubernetes .yaml
language: en
fill_locale: en_US
domain: retail
appearance: comment, YAML value, annotation, list item, label
scenario: canary rollout of a checkout service with its analysis template, with a first name as its release codename and no secret in the manifest
⟬text⟭
# checkout canary. Credentials come from the checkout-env Secret, managed elsewhere.
apiVersion: argoproj.io/v1alpha1
kind: Rollout
metadata:
  name: checkout
  namespace: storefront
  labels:
    app: checkout
    release: ⟬trap:code_identifier|⦃given⦄⟭
    ⟬trap:indicator_non_pii|owner: checkout-squad⟭
spec:
  replicas: 12
  revisionHistoryLimit: 3
  selector:
    matchLabels:
      app: checkout
  strategy:
    canary:
      canaryService: checkout-canary
      stableService: checkout-stable
      trafficRouting:
        nginx:
          stableIngress: checkout
      steps:
        - setWeight: 5
        - pause: { duration: 5m }
        - analysis:
            templates:
              - templateName: checkout-success-rate
        - setWeight: 25
        - pause: { duration: 10m }
        - setWeight: 50
        - pause: { duration: 10m }
  template:
    metadata:
      labels:
        app: checkout
        cluster: ⟬trap:code_identifier|⦃family⦄-east⟭
    spec:
      containers:
        - name: checkout
          image: ⟬hostname#1⟭/storefront/checkout:⟬version#1⟭
          ports:
            - containerPort: 8080
          envFrom:
            - secretRef:
                name: checkout-env
          env:
            - name: PRICING_STRATEGY
              value: ⟬trap:code_identifier|apply⦃Family2⦄Discount⟭
            - name: ⟬trap:indicator_non_pii|CARD_TOKEN_TTL⟭
              value: "900"
            - name: ⟬trap:indicator_non_pii|GUEST_CUSTOMER_NAME⟭
              value: Guest
          readinessProbe:
            httpGet:
              path: /ready
              port: 8080
---
apiVersion: argoproj.io/v1alpha1
kind: AnalysisTemplate
metadata:
  name: checkout-success-rate
  namespace: storefront
spec:
  metrics:
    - name: success-rate
      interval: 1m
      count: 5
      successCondition: result[0] >= 0.995
      failureLimit: 2
      provider:
        prometheus:
          address: ⟬url#1⟭
          query: |
            sum(rate(checkout_requests_total{status!~"5.."}[2m]))
            /
            sum(rate(checkout_requests_total[2m]))
---
apiVersion: v1
kind: Service
metadata:
  name: checkout-canary
  namespace: storefront
spec:
  selector:
    app: checkout
  ports:
    - port: 80
      targetPort: 8080
---
apiVersion: v1
kind: Service
metadata:
  name: checkout-stable
  namespace: storefront
spec:
  selector:
    app: checkout
  ports:
    - port: 80
      targetPort: 8080
⟬end⟭

⟬template⟭
family: config
format: Kubernetes .yaml
language: en
fill_locale: en_US
domain: healthcare
appearance: comment, environment list, YAML value, test fixture
scenario: Job that seeds a demo traveler into the staging database of a travel medicine clinic, made for a sales presentation
⟬text⟭
# seeds the traveler shown in the sales demo, delete after ⟬date#1⟭
apiVersion: batch/v1
kind: Job
metadata:
  name: seed-demo-traveler
  namespace: travelhealth-staging
spec:
  template:
    spec:
      restartPolicy: OnFailure
      containers:
        - name: seed
          image: ⟬hostname#1⟭/travelhealth/seeder:⟬version#1⟭
          env:
            - name: API_TOKEN
              value: ⟬jwt#1⟭
            - name: TRAVELER_NAME
              value: "⟬person_name#2⟭"
            - name: TRAVELER_DOB
              value: "⟬birth_date#2⟭"
            - name: TRAVELER_PASSPORT
              value: "⟬us_passport#2⟭"
            - name: TRAVELER_PHONE
              value: "⟬phone#2⟭"
            - name: TRIP_DEPARTS
              value: "⟬date#2⟭"
            - name: TRIP_COUNTRY
              value: "⟬country#3⟭"
            - name: ⟬trap:indicator_non_pii|VACCINE_LOT_FORMAT⟭
              value: alphanumeric
⟬end⟭

⟬template⟭
family: config
format: docker-compose.yml
language: en
fill_locale: en_US
domain: retail
appearance: YAML value, environment list, comment
scenario: self-hosted web analytics of a home goods brand, deployed by the growth marketer from a blog post
⟬text⟭
services:
  plausible:
    image: ghcr.io/plausible/community-edition:v2.1.3
    restart: always
    command: sh -c "sleep 10 && /entrypoint.sh db createdb && /entrypoint.sh db migrate && /entrypoint.sh run"
    depends_on:
      - plausible_db
      - plausible_events_db
    ports:
      - "8000:8000"
    environment:
      BASE_URL: https://⟬hostname#1⟭
      SECRET_KEY_BASE: ⟬opaque_token#1⟭
      TOTP_VAULT_KEY: ⟬opaque_token#2⟭
      DATABASE_URL: postgres://postgres:⟬url_password#1⟭@plausible_db:5432/plausible_db
      MAILER_EMAIL: ⟬email:generic#2⟭
      SMTP_HOST_ADDR: smtp.sendgrid.net
      SMTP_USER_NAME: ⟬trap:indicator_non_pii|apikey⟭
      SMTP_USER_PWD: ⟬sendgrid_api_key#1⟭
      GOOGLE_CLIENT_SECRET: ⟬opaque_token#3⟭

  plausible_db:
    image: postgres:16-alpine
    environment:
      POSTGRES_PASSWORD: ⟬url_password#1⟭

  plausible_events_db:
    image: clickhouse/clickhouse-server:24.3-alpine
⟬end⟭

⟬template⟭
family: config
format: docker-compose.yml
language: en
fill_locale: en_US
domain: media
appearance: YAML value, comment
scenario: one-service compose of a podcast audio cleanup job, run on demand by a producer with a rented GPU
⟬text⟭
services:
  denoise:
    image: ⟬hostname#1⟭/audio/denoise:⟬version#1⟭
    environment:
      HF_TOKEN: ⟬huggingface_token#1⟭
      INPUT_BUCKET: raw-episodes
      AWS_ACCESS_KEY_ID: ⟬aws_access_key_id#1⟭
      AWS_SECRET_ACCESS_KEY: ⟬aws_secret_access_key#1⟭
    volumes:
      - ./scratch:/scratch
⟬end⟭

⟬template⟭
family: config
format: docker-compose.yml
language: en
fill_locale: en_US
domain: healthcare
appearance: comment, YAML value, environment list, quoted value
scenario: OpenEMR installation of a rural health clinic, set up by a volunteer with the default admin account kept for the first login
⟬text⟭
# clinic server, in the closet behind reception
# first login: ⟬username#1⟭ / see below. Change after install!! (⟬person_name#2⟭, ⟬date#1⟭)
services:
  mysql:
    restart: always
    image: mariadb:10.11
    command: ["mysqld", "--character-set-server=utf8mb4"]
    volumes:
      - databasevolume:/var/lib/mysql
    environment:
      MYSQL_ROOT_PASSWORD: "⟬password#1⟭"

  openemr:
    restart: always
    image: openemr/openemr:7.0.2
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - logvolume01:/var/log
      - sitevolume:/var/www/localhost/htdocs/openemr/sites
    environment:
      MYSQL_HOST: mysql
      MYSQL_ROOT_PASS: "⟬password#1⟭"
      MYSQL_USER: openemr
      MYSQL_PASS: "⟬password#2⟭"
      OE_USER: ⟬username#1⟭
      OE_PASS: "⟬password#3⟭"
      CLINIC_LINE: "⟬phone#3⟭"
      CLINIC_ADDRESS: "⟬postal_address#3⟭"
    depends_on:
      - mysql

volumes:
  logvolume01: {}
  sitevolume: {}
  databasevolume: {}
⟬end⟭

⟬template⟭
family: config
format: .json
language: en
fill_locale: en_US
domain: retail
appearance: nested JSON, string value, list item
scenario: Firebase hosting and emulator configuration of a coupon landing page, where the only sensitive thing would be a service account that is not there
⟬text⟭
{
  "hosting": {
    "public": "dist",
    "ignore": ["firebase.json", "**/.*", "**/node_modules/**"],
    "rewrites": [
      { "source": "/api/**", "function": "api" },
      { "source": "**", "destination": "/index.html" }
    ],
    "headers": [
      {
        "source": "**/*.@(js|css)",
        "headers": [{ "key": "Cache-Control", "value": "max-age=31536000" }]
      },
      {
        "source": "/api/**",
        "headers": [{ "key": "⟬trap:indicator_non_pii|Access-Control-Allow-Headers⟭", "value": "⟬trap:indicator_non_pii|X-Api-Key, Authorization⟭" }]
      }
    ]
  },
  "functions": {
    "source": "functions",
    "runtime": "nodejs20",
    "predeploy": ["npm --prefix functions run lint", "npm --prefix functions run build"]
  },
  "emulators": {
    "auth": { "port": 9099 },
    "functions": { "port": 5001 },
    "firestore": { "port": 8080 },
    "hosting": { "port": 5000 },
    "ui": { "enabled": true }
  },
  "firestore": {
    "rules": "firestore.rules",
    "indexes": "firestore.indexes.json"
  },
  "storage": {
    "rules": "storage.rules"
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
scenario: google-services.json of a mobile banking app, checked into the Android module by the mobile team
⟬text⟭
{
  "project_info": {
    "project_number": "611204773092",
    "project_id": "mobile-bank-prod",
    "storage_bucket": "mobile-bank-prod.appspot.com"
  },
  "client": [
    {
      "client_info": {
        "mobilesdk_app_id": "1:611204773092:android:8c21de9f40a7b3e1",
        "android_client_info": {
          "package_name": "com.halyardbank.mobile"
        }
      },
      "oauth_client": [],
      "api_key": [
        { "current_key": "⟬google_api_key#1⟭" }
      ],
      "services": {
        "appinvite_service": { "other_platform_oauth_client": [] }
      }
    }
  ],
  "configuration_version": "1"
}
⟬end⟭

⟬template⟭
family: config
format: .toml
language: en
fill_locale: en_US
domain: fintech
appearance: section header, string value
scenario: influx CLI profile file of a market data engineer, with an active production profile and a local one
⟬text⟭
[default]
  url = "https://⟬hostname#1⟭"
  token = "⟬opaque_token#1⟭"
  org = "marketdata"
  active = true

[local]
  url = "http://localhost:8086"
  token = "⟬opaque_token#2⟭"
  org = "dev"
⟬end⟭

⟬template⟭
family: config
format: .toml
language: en
fill_locale: en_US
domain: media
appearance: comment, section header, string value, array of tables
scenario: wrangler.toml of a thumbnail generation worker at a streaming site, where the vars block was used instead of secrets on the first day
⟬text⟭
name = "thumb-gen"
main = "src/index.ts"
compatibility_date = "2026-06-01"

[vars]
ENVIRONMENT = "production"
ORIGIN = "⟬url#1⟭"
# move these to `wrangler secret put` !!
HF_TOKEN = "⟬huggingface_token#1⟭"
OPENAI_API_KEY = "⟬openai_api_key#1⟭"
REPO_DISPATCH_TOKEN = "⟬github_token#1⟭"

[[r2_buckets]]
binding = "THUMBS"
bucket_name = "thumbs-prod"

[[kv_namespaces]]
binding = "CACHE"
id = "⟬hash#1⟭"

[observability]
enabled = true
head_sampling_rate = 0.1
⟬end⟭

⟬template⟭
family: config
format: .npmrc
language: en
fill_locale: en_US
domain: logistics
appearance: comment, assignment, url
scenario: .npmrc of a cold storage operator's customer portal, in which comments mention a partner whose name is on the packages
⟬text⟭
; portal for the ⟬trap:company_name|⦃Family⦄ Cold Storage⟭ account
; ⟬trap:email_lookalike|@coldchain/temperature-charts⟭ comes from the partner's feed
⟬trap:email_lookalike|@coldchain:registry⟭=https://⟬hostname#1⟭/npm/
//⟬hostname#1⟭/npm/:_authToken=⟬opaque_token#1⟭
//registry.npmjs.org/:_authToken=⟬npm_token#1⟭
; owner: ⟬person_name#2⟭
legacy-peer-deps=true
⟬end⟭

⟬template⟭
family: config
format: .npmrc
language: en
fill_locale: en_US
domain: healthcare
appearance: assignment
scenario: per-registry username and password of a clinical forms library on a Verdaccio shared by two vendors
⟬text⟭
registry=https://⟬hostname#1⟭/
//⟬hostname#1⟭/:username=⟬person_name:handle#2⟭
//⟬hostname#1⟭/:_password=⟬opaque_token#1⟭
//⟬hostname#1⟭/:email=⟬email#2⟭
⟬end⟭

⟬template⟭
family: config
format: .npmrc
language: en
fill_locale: en_US
domain: SaaS
appearance: comment, assignment
scenario: two token .npmrc of a design system team, with a sign-off in initials next to the rotation date
⟬text⟭
# rotated ⟬date#1⟭ - ⟬trap:initials|AL⟭
//registry.npmjs.org/:_authToken=⟬npm_token#1⟭
//npm.pkg.github.com/:_authToken=⟬github_token#1⟭
⟬trap:email_lookalike|@relay-design:registry⟭=https://npm.pkg.github.com
⟬end⟭

⟬template⟭
family: config
format: .ini
language: en
fill_locale: en_US
domain: retail
appearance: section header, assignment, list item, comment
scenario: pytest configuration of a checkout test suite, with markers and environment defaults that look like credentials but are not
⟬text⟭
[pytest]
minversion = 8.0
testpaths = tests
addopts = -ra --strict-markers --cov=checkout --cov-fail-under=88
asyncio_mode = auto
filterwarnings =
    error
    ignore::DeprecationWarning:⟬trap:library|sphinx⟭.*
markers =
    smoke: quick checks run on every deploy
    ⟬trap:indicator_non_pii|payment_card: tests that exercise the card form⟭
    ⟬trap:indicator_non_pii|address: tests of the shipping address form⟭
    ⟬trap:indicator_non_pii|email: tests of the order confirmation mail⟭
env =
    ⟬trap:indicator_non_pii|D:API_TOKEN_REQUIRED=0⟭
    ⟬trap:indicator_non_pii|D:TEST_USER=checkout-bot⟭
    ⟬trap:indicator_non_pii|D:PASSWORD_POLICY=none⟭
    D:DISCOUNT_ENGINE=⟬trap:code_identifier|⦃family⦄_discount_rules⟭
    D:PAYMENT_GATEWAY=fake

; bucket tests use the ⟬trap:eponym|Gini⟭ coefficient of basket sizes
[coverage:run]
branch = True
⟬end⟭

⟬template⟭
family: config
format: .ini
language: en
fill_locale: en_US
domain: logistics
appearance: section header, assignment, url, comment
scenario: pip.conf of a customs brokerage batch server, with the private index credentials in the URL
⟬text⟭
[global]
index-url = https://svc_pip:⟬url_password#1⟭@⟬hostname#1⟭/repository/pypi-all/simple
trusted-host = ⟬hostname#1⟭
timeout = 60
# the mirror goes down on sundays
retries = 8
disable-pip-version-check = true
⟬end⟭

⟬template⟭
family: config
format: .ini
language: en
fill_locale: en_US
domain: SaaS
appearance: section header, assignment
scenario: Hugging Face stored tokens file of a machine learning engineer, included in a support bundle by the CLI diagnostics
⟬text⟭
[read-token]
hf_token = ⟬huggingface_token#1⟭

[write-token]
hf_token = ⟬huggingface_token#2⟭

[org-ci]
hf_token = ⟬huggingface_token#3⟭
⟬end⟭
