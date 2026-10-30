⟬template⟭
family: config
format: .env
language: en
fill_locale: en_US
domain: media
appearance: comment, assignment, quoted value, commented-out line
scenario: staging env of a headline testing tool used by a news group, passed around by a product manager who edits it directly on the server
⟬text⟭
# headline-lab staging, ask ⟬person_name#1⟭ before touching
PORT=4010
CMS_BASE_URL=⟬url#1⟭
CMS_SERVICE_ACCOUNT=⟬username#1⟭
CMS_SERVICE_PASSWORD='⟬password#1⟭'

ANTHROPIC_API_KEY=⟬anthropic_api_key#1⟭
HEADLINE_MODEL=claude-haiku-5-5
HEADLINE_VARIANTS=4
⟬trap:indicator_non_pii|AUTHOR_BYLINE_REQUIRED=true⟭

GIT_PUSH_TOKEN=⟬github_token#1⟭
#GIT_PUSH_TOKEN=⟬gitlab_token#1⟭
EXPERIMENT_DB=postgres://lab:⟬url_password#1⟭@⟬hostname#1⟭/headline_lab
# winner picked with a ⟬trap:eponym|Thompson⟭ sampling bandit
EXPLORATION_RATE=0.15
SLACK_NOTIFY_TOKEN=⟬slack_token#1⟭
⟬end⟭

⟬template⟭
family: config
format: .env
language: en
fill_locale: en_US
domain: retail
appearance: comment, assignment, section header
scenario: development env of a point-of-sale tablet app, shipped in the repository with demo values and a note on how to get real ones
⟬text⟭
# POS tablet, development defaults.
# Real credentials: request access in the platform portal, then run `make env`.

VITE_API_BASE=http://localhost:8787
VITE_STORE_CODE=DEMO-001
VITE_RECEIPT_FOOTER="Thanks for shopping with us"
VITE_LOCALE=en-US

# Payment terminal simulator
TERMINAL_MODE=simulated
TERMINAL_API_KEY=⟬trap:placeholder|REPLACE_WITH_SANDBOX_KEY⟭
⟬trap:indicator_non_pii|PIN_PAD_TIMEOUT_MS=30000⟭

# Staff login
⟬trap:indicator_non_pii|STAFF_USER=demo⟭
STAFF_PASSWORD=⟬trap:placeholder|<ask-your-manager>⟭
⟬trap:indicator_non_pii|STAFF_SESSION_TOKEN_MINUTES=480⟭

# Store directory
DEFAULT_CITY="⟬city#1⟭"
DEFAULT_ZIP=⟬postcode#1⟭
# the ⟬trap:word_name|Olive⟭ and ⟬trap:word_name|Ruby⟭ themes are the two store skins
THEME=⟬trap:word_name|Olive⟭

# Telemetry
SENTRY_DSN=
SENTRY_ENVIRONMENT=dev
BUILD_NUMBER=⟬version#1⟭
⟬end⟭

⟬template⟭
family: config
format: Terraform .tfvars
language: en
fill_locale: en_US
domain: fintech
appearance: comment, assignment, object list, map value
scenario: GitLab group bootstrap for a payments division, listing members and the group-level CI variables, written by the DevOps manager during a reorganization
⟬text⟭
# gitlab-bootstrap / payments division
# run from the admin workstation only
gitlab_base_url = "https://⟬hostname#1⟭/api/v4/"
gitlab_token    = "⟬gitlab_token#1⟭"
root_group_path = "payments"
visibility      = "private"

subgroups = ["acquiring", "ledger", "fraud", "platform"]

group_members = [
  { username = "⟬person_name:handle#2⟭", access_level = "owner",      email = "⟬email#2⟭" },
  { username = "⟬person_name:handle#3⟭", access_level = "maintainer", email = "⟬email#3⟭" },
  { username = "⟬person_name:handle#4⟭", access_level = "maintainer", email = "⟬email#4⟭" },
  { username = "⟬username#1⟭",           access_level = "developer",  email = "⟬email:generic#5⟭" },
]

group_ci_variables = {
  AWS_ACCESS_KEY_ID = {
    value     = "⟬aws_access_key_id#6⟭"
    masked    = false
    protected = true
  }
  AWS_SECRET_ACCESS_KEY = {
    value     = "⟬aws_secret_access_key#6⟭"
    masked    = true
    protected = true
  }
  NPM_TOKEN = {
    value     = "⟬npm_token#1⟭"
    masked    = true
    protected = false
  }
  SONAR_TOKEN = {
    value     = "⟬opaque_token#1⟭"
    masked    = true
    protected = false
  }
  DEPENDENCY_PROXY_PASSWORD = {
    value     = "⟬gitlab_token#2⟭"
    masked    = true
    protected = false
  }
}

deploy_freeze = {
  cron_start = "0 18 * * 5"
  cron_end   = "0 7 * * 1"
  timezone   = "America/New_York"
}

# protected branches
⟬trap:indicator_non_pii|push_access_level = "maintainer"⟭
⟬trap:indicator_non_pii|merge_access_level = "developer"⟭
required_approvals = 2
⟬trap:indicator_non_pii|approval_token_expiry_days = 30⟭

runner_tags = ["pci", "docker", "arm64"]
issue_board_labels = ["triage", "blocked", "pci-review"]
default_branch_name = "main"
merge_method = "ff"
wiki_enabled = false
container_expiration_days = 30
audit_stream_url = "⟬url#1⟭"
⟬end⟭

⟬template⟭
family: config
format: Terraform .tfvars
language: en
fill_locale: en_US
domain: retail
appearance: assignment, comment
scenario: Cloudflare Workers variables of a gift card balance checker, kept short by a developer who deploys from a personal laptop
⟬text⟭
account_id   = "⟬hash#1⟭"
worker_name  = "giftcard-balance"
route        = "⟬hostname#1⟭/balance/*"
# the assistant behind the "where is my card" widget
llm_key      = "⟬anthropic_api_key#1⟭"
ops_repo_pat = "⟬github_token#1⟭"
⟬end⟭

⟬template⟭
family: config
format: Kubernetes .yaml
language: en
fill_locale: en_US
domain: media
appearance: shell command, comment, YAML value, http header
scenario: CronJob that triggers a nightly archive pipeline with curl, written quickly by a broadcast engineer with the token inline in the command
⟬text⟭
apiVersion: batch/v1
kind: CronJob
metadata:
  name: nightly-archive-trigger
  namespace: broadcast
spec:
  schedule: "30 1 * * *"
  concurrencyPolicy: Forbid
  successfulJobsHistoryLimit: 2
  jobTemplate:
    spec:
      backoffLimit: 1
      template:
        spec:
          restartPolicy: Never
          containers:
            - name: trigger
              image: curlimages/curl:8.10.1
              command: ["/bin/sh", "-c"]
              args:
                - |
                  # kicks the archive pipeline, then tells the desk
                  curl -sf --request POST \
                    --header "PRIVATE-TOKEN: ⟬gitlab_token#1⟭" \
                    --form ref=main \
                    "https://⟬hostname#1⟭/api/v4/projects/311/pipeline"
                  curl -sf -X POST "https://slack.com/api/chat.postMessage" \
                    -H "Authorization: Bearer ⟬slack_token#1⟭" \
                    -d "channel=archive-desk" -d "text=archive started"
                  curl -s -u 'api:⟬password#1⟭' https://⟬hostname#2⟭/v1/ping
              resources:
                limits:
                  memory: 64Mi
⟬end⟭

⟬template⟭
family: config
format: Kubernetes .yaml
language: en
fill_locale: en_US
domain: healthcare
appearance: comment, YAML value, annotation, environment list, label
scenario: StatefulSet of a FHIR server with its PodDisruptionBudget, installed under a Helm release with a first name as its codename and fed only by referenced Secrets
⟬text⟭
# fhir-store, installed by the platform team
# Credentials: Secret fhir-store-db, created by the database operator.
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: fhir-store
  namespace: interop
  labels:
    app.kubernetes.io/name: fhir-store
    app.kubernetes.io/instance: ⟬trap:code_identifier|⦃given⦄⟭
    app.kubernetes.io/version: "⟬version#1⟭"
    ⟬trap:indicator_non_pii|owner: interop-platform⟭
spec:
  serviceName: fhir-store
  replicas: 3
  podManagementPolicy: Parallel
  selector:
    matchLabels:
      app.kubernetes.io/name: fhir-store
  template:
    metadata:
      labels:
        app.kubernetes.io/name: fhir-store
        app.kubernetes.io/instance: ⟬trap:code_identifier|⦃given⦄⟭
      annotations:
        prometheus.io/scrape: "true"
        prometheus.io/path: /actuator/prometheus
    spec:
      terminationGracePeriodSeconds: 60
      containers:
        - name: hapi
          image: hapiproject/hapi:v7.4.0
          ports:
            - name: http
              containerPort: 8080
          env:
            - name: SPRING_DATASOURCE_URL
              value: jdbc:postgresql://⟬hostname#1⟭:5432/fhir
            - name: ⟬trap:indicator_non_pii|SPRING_DATASOURCE_USERNAME⟭
              valueFrom:
                secretKeyRef:
                  name: fhir-store-db
                  key: username
            - name: ⟬trap:indicator_non_pii|SPRING_DATASOURCE_PASSWORD⟭
              valueFrom:
                secretKeyRef:
                  name: fhir-store-db
                  key: password
            - name: ⟬trap:indicator_non_pii|hapi.fhir.default_page_size⟭
              value: "50"
            - name: hapi.fhir.subscription.resthook_enabled
              value: "true"
            - name: ⟬trap:indicator_non_pii|PATIENT_BIRTHDATE_INDEX⟭
              value: "true"
          readinessProbe:
            httpGet:
              path: /actuator/health/readiness
              port: http
            initialDelaySeconds: 40
          resources:
            requests:
              cpu: "1"
              memory: 3Gi
            limits:
              memory: 4Gi
  volumeClaimTemplates:
    - metadata:
        name: lucene-index
      spec:
        accessModes: ["ReadWriteOnce"]
        resources:
          requests:
            storage: 40Gi
---
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: fhir-store
  namespace: interop
spec:
  minAvailable: 2
  selector:
    matchLabels:
      app.kubernetes.io/name: fhir-store
---
apiVersion: v1
kind: Service
metadata:
  name: fhir-store
  namespace: interop
spec:
  clusterIP: None
  selector:
    app.kubernetes.io/name: fhir-store
  ports:
    - name: http
      port: 8080
⟬end⟭

⟬template⟭
family: config
format: docker-compose.yml
language: en
fill_locale: en_US
domain: fintech
appearance: YAML value, environment list, comment
scenario: build server compose file of a trading desk, with a Jenkins agent, a package cache and tokens for three forges
⟬text⟭
# build-07, trading desk tools
services:
  agent:
    image: ⟬trap:library|jenkins⟭/inbound-agent:3261.v9c670a_4748a_9-1
    restart: unless-stopped
    environment:
      - JENKINS_URL=https://⟬hostname#1⟭
      - JENKINS_AGENT_NAME=build-07
      - JENKINS_SECRET=⟬opaque_token#1⟭
      - GITHUB_TOKEN=⟬github_token#1⟭
      - GITLAB_TOKEN=⟬gitlab_token#1⟭
      - NPM_TOKEN=⟬npm_token#1⟭
    volumes:
      - agent-work:/home/jenkins/agent

  nexus:
    image: sonatype/nexus3:3.72.0
    ports:
      - "8081:8081"
    volumes:
      - nexus-data:/nexus-data

  price-replay:
    image: ⟬hostname#2⟭/desk/price-replay:⟬version#1⟭
    environment:
      FEED_USER: ⟬username#1⟭
      FEED_PASS: "⟬password#1⟭"
      # ⟬trap:eponym|Black-Scholes⟭ repricing is off for the replay
      REPRICE: "false"

volumes:
  agent-work:
  nexus-data:
⟬end⟭

⟬template⟭
family: config
format: docker-compose.yml
language: en
fill_locale: en_US
domain: SaaS
appearance: YAML value, comment, list item
scenario: observability sandbox of an API team, with a collector and a dashboard tool, that holds no credentials at all
⟬text⟭
# Local tracing sandbox: docker compose up, then open http://localhost:16686
services:
  ⟬trap:library|jaeger⟭:
    image: jaegertracing/all-in-one:1.62
    environment:
      COLLECTOR_OTLP_ENABLED: "true"
    ports:
      - "16686:16686"
      - "4317:4317"

  collector:
    image: otel/opentelemetry-collector-contrib:0.111.0
    command: ["--config=/etc/otel/config.yaml"]
    volumes:
      - ./otel.yaml:/etc/otel/config.yaml:ro
    depends_on:
      - ⟬trap:library|jaeger⟭

  ⟬trap:library|prometheus⟭:
    image: prom/prometheus:v2.54.1
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml:ro
    ports:
      - "9090:9090"

  dashboards:
    image: grafana/grafana:11.2.2
    environment:
      GF_AUTH_ANONYMOUS_ENABLED: "true"
      GF_AUTH_ANONYMOUS_ORG_ROLE: Admin
      ⟬trap:indicator_non_pii|GF_SECURITY_ADMIN_USER: viewer⟭
      GF_SECURITY_ADMIN_PASSWORD: ⟬trap:placeholder|${GF_ADMIN_PASSWORD:-}⟭
    ports:
      - "3001:3000"
⟬end⟭

⟬template⟭
family: config
format: .json
language: en
fill_locale: en_US
domain: logistics
appearance: nested JSON, string value, list item
scenario: VS Code workspace settings of a yard management team with REST client variables and a database connection shared through the repository
⟬text⟭
{
  "editor.formatOnSave": true,
  "files.eol": "\n",
  "eslint.workingDirectories": ["web", "api"],
  "rest-client.environmentVariables": {
    "$shared": {
      "apiVersion": "v3"
    },
    "staging": {
      "host": "⟬url#1⟭",
      "token": "⟬jwt#1⟭",
      "tenant": "⟬uuid#1⟭"
    },
    "prod": {
      "host": "⟬url#2⟭",
      "token": "⟬jwt#2⟭",
      "tenant": "⟬uuid#2⟭"
    }
  },
  "sqltools.connections": [
    {
      "name": "yard-prod (read)",
      "driver": "PostgreSQL",
      "server": "⟬hostname#1⟭",
      "port": 5432,
      "database": "yard",
      "username": "⟬username#1⟭",
      "password": "⟬password#1⟭"
    }
  ],
  "yaml.schemas": {
    "https://json.schemastore.org/github-workflow.json": ".github/workflows/*.yml"
  },
  "terminal.integrated.env.linux": {
    "AWS_PROFILE": "yard-dev",
    "AWS_ACCESS_KEY_ID": "⟬aws_access_key_id#1⟭",
    "AWS_SECRET_ACCESS_KEY": "⟬aws_secret_access_key#1⟭",
    "YARD_GATE_PIN": "⟬password#2⟭"
  },
  "todo-tree.general.tags": ["TODO", "FIXME", "HACK"],
  "cSpell.words": ["yardmove", "bobtail", "drayage"],
  "search.exclude": {
    "**/dist": true,
    "**/coverage": true,
    "**/.turbo": true
  },
  "files.associations": {
    "*.edi": "plaintext",
    "*.x12": "plaintext"
  },
  "emmet.includeLanguages": { "erb": "html" },
  "[typescript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "[json]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "gitlens.remotes": [
    { "domain": "⟬hostname#2⟭", "type": "GitLab" }
  ],
  "gitlab.personalAccessToken": "⟬gitlab_token#1⟭",
  "claude.apiKey": "⟬anthropic_api_key#1⟭"
}
⟬end⟭

⟬template⟭
family: config
format: .json
language: en
fill_locale: en_US
domain: healthcare
appearance: key-value list, string value, test fixture
scenario: Postman environment export of a patient gateway UAT, sent to an outside tester with the current values still filled in
⟬text⟭
{
  "id": "⟬uuid#1⟭",
  "name": "Patient Gateway - UAT",
  "values": [
    { "key": "baseUrl", "value": "⟬url#1⟭", "type": "default", "enabled": true },
    { "key": "clientId", "value": "⟬uuid#2⟭", "type": "default", "enabled": true },
    { "key": "clientSecret", "value": "⟬opaque_token#1⟭", "type": "secret", "enabled": true },
    { "key": "accessToken", "value": "⟬jwt#1⟭", "type": "secret", "enabled": true },
    { "key": "testUserEmail", "value": "⟬email#3⟭", "type": "default", "enabled": true },
    { "key": "testUserPassword", "value": "⟬password#1⟭", "type": "secret", "enabled": true },
    { "key": "testPatientName", "value": "⟬person_name#3⟭", "type": "default", "enabled": true },
    { "key": "testPatientDob", "value": "⟬birth_date#3⟭", "type": "default", "enabled": true },
    { "key": "testPatientMemberId", "value": "⟬customer_id#3⟭", "type": "default", "enabled": true },
    { "key": "lastVisit", "value": "⟬date#2⟭", "type": "default", "enabled": false }
  ],
  "_postman_variable_scope": "environment",
  "_postman_exported_at": "⟬date#1⟭",
  "_postman_exported_using": "Postman/11.14.0"
}
⟬end⟭

⟬template⟭
family: config
format: .json
language: en
fill_locale: en_US
domain: fintech
appearance: nested JSON, string value, list item
scenario: cdk.json of a fraud rules pipeline, in which account numbers are technical and every secret is an SSM parameter name
⟬text⟭
{
  "app": "npx ts-node --prefer-ts-exts bin/fraud-rules.ts",
  "watch": {
    "include": ["**"],
    "exclude": ["README.md", "cdk*.json", "**/*.d.ts", "node_modules", "test"]
  },
  "context": {
    "@aws-cdk/core:checkSecretUsage": true,
    "@aws-cdk/aws-iam:minimizePolicies": true,
    "environments": {
      "uat": { "account": "210987654321", "region": "us-east-1" },
      "prod": { "account": "109876543210", "region": "us-east-1" }
    },
    "⟬trap:indicator_non_pii|apiKeyParameter⟭": "/fraud/rules/api-key",
    "⟬trap:indicator_non_pii|dbPasswordParameter⟭": "/fraud/rules/db-password",
    "⟬trap:indicator_non_pii|ownerTag⟭": "fraud-engineering",
    "ruleEngine": "⟬trap:library|drools⟭",
    "velocityWindowMinutes": 15,
    "bloomFilterHashes": 7,
    "scoring": {
      "model": "⟬trap:code_identifier|⦃family⦄Score⟭",
      "version": "⟬version#1⟭",
      "threshold": 0.82
    },
    "⟬trap:indicator_non_pii|cardNumberMaskPattern⟭": "######******####"
  }
}
⟬end⟭

⟬template⟭
family: config
format: .toml
language: en
fill_locale: en_US
domain: SaaS
appearance: section header, string value
scenario: Poetry auth.toml of a build agent, normally in the user config directory, baked into a shared image
⟬text⟭
[http-basic.internal]
username = "gitlab-ci-token"
password = "⟬gitlab_token#1⟭"

[http-basic.partner-index]
username = "⟬username#1⟭"
password = "⟬password#1⟭"

[pypi-token]
pypi = "⟬opaque_token#1⟭"
⟬end⟭

⟬template⟭
family: config
format: .toml
language: en
fill_locale: en_US
domain: retail
appearance: comment, section header, string value, inline table
scenario: Rocket.toml of a coupon service in Rust, kept with a profile per environment, where the release profile holds the live values
⟬text⟭
[default]
address = "0.0.0.0"
port = 8000
log_level = "normal"
ident = "coupons"
⟬trap:indicator_non_pii|secret_key_length = 64⟭

[default.limits]
json = "1 MiB"

[debug]
log_level = "debug"

[debug.databases.coupons]
url = "postgres://coupons:⟬url_password#1⟭@localhost/coupons_dev"
pool_size = 4

[release]
secret_key = "⟬opaque_token#1⟭"
workers = 12

[release.databases.coupons]
url = "postgres://coupons:⟬url_password#2⟭@⟬hostname#1⟭/coupons"
pool_size = 32

# abuse detection on coupon codes
[release.fraud]
endpoint = "https://api.openai.com/v1/chat/completions"
key = "⟬openai_api_key#1⟭"
fallback = { provider = "anthropic", key = "⟬anthropic_api_key#1⟭" }
⟬end⟭

⟬template⟭
family: config
format: .toml
language: en
fill_locale: en_US
domain: media
appearance: comment, section header, string value, array of tables
scenario: Hugo site configuration of a freelance photographer's portfolio, with the contact block filled in by hand
⟬text⟭
baseURL = "https://⟬hostname#1⟭/"
languageCode = "en-us"
title = "⟬person_name#1⟭ Photography"
theme = "⟬trap:library|hugo⟭-gallery"
paginate = 24

[params]
author = "⟬person_name#1⟭"
description = "Editorial and documentary photography"
email = "⟬email#1⟭"
phone = "⟬phone#1⟭"
studio = "⟬postal_address#1⟭"
# built with a ⟬trap:word_name|Sage⟭ palette
accent = "⟬trap:word_name|Sage⟭"

[[menu.main]]
name = "Work"
url = "/work/"
weight = 1

[[menu.main]]
name = "About"
url = "/about/"
weight = 2

[deployment]
[[deployment.targets]]
name = "s3"
URL = "s3://portfolio-site?region=us-east-1"
⟬end⟭

⟬template⟭
family: config
format: .npmrc
language: en
fill_locale: en_US
domain: SaaS
appearance: assignment
scenario: three line .npmrc of a billing widget that pulls one private package from GitHub Packages
⟬text⟭
⟬trap:email_lookalike|@billing-ui:registry⟭=https://npm.pkg.github.com
//npm.pkg.github.com/:_authToken=⟬github_token#1⟭
always-auth=true
⟬end⟭

⟬template⟭
family: config
format: .npmrc
language: en
fill_locale: en_US
domain: retail
appearance: comment, assignment, url
scenario: .npmrc rendered by a Dockerfile step on an old build server of a marketplace, with two registries and root install settings
⟬text⟭
# written by build.sh, do not edit by hand
//registry.npmjs.org/:_authToken=⟬npm_token#1⟭
//⟬hostname#1⟭/npm/:_authToken=⟬npm_token#2⟭
⟬trap:email_lookalike|@marketplace:registry⟭=https://⟬hostname#1⟭/npm/
unsafe-perm=true
user=0
⟬end⟭

⟬template⟭
family: config
format: .npmrc
language: en
fill_locale: en_US
domain: media
appearance: comment, assignment, url
scenario: desktop video editor build settings pointing Electron and native modules at public mirrors, kept by the release engineer
⟬text⟭
# Desktop editor builds.
# Mirrors are public, nothing here needs a login.
runtime=electron
target=31.3.0
target_arch=x64
disturl=https://electronjs.org/headers
electron_mirror=https://npmmirror.com/mirrors/electron/
sass_binary_site=https://npmmirror.com/mirrors/node-sass/
⟬trap:email_lookalike|@ffmpeg-installer:registry⟭=https://registry.npmjs.org/
build_from_source=true
msvs_version=2022
⟬trap:indicator_non_pii|git-tag-version=false⟭
⟬trap:indicator_non_pii|owner=desktop-releases⟭
⟬end⟭

⟬template⟭
family: config
format: .ini
language: en
fill_locale: en_US
domain: healthcare
appearance: comment, section header, assignment
scenario: PostgreSQL service file on a report server of a clinic network, one section per site, with the reporting password repeated
⟬text⟭
# ~/.pg_service.conf, one entry per clinic

[northside]
host=⟬hostname#1⟭
port=5432
dbname=emr_northside
user=report_ro
password=⟬password#1⟭
sslmode=verify-full

[lakeview]
host=⟬hostname#2⟭
port=5432
dbname=emr_lakeview
user=report_ro
password=⟬password#1⟭
sslmode=verify-full

[billing-vendor]
host=⟬hostname#3⟭
port=6432
dbname=claims
user=⟬username#1⟭
password=⟬password#2⟭
sslmode=require
⟬end⟭

⟬template⟭
family: config
format: .ini
language: en
fill_locale: en_US
domain: logistics
appearance: section header, assignment, single-line JSON
scenario: rclone.conf of a bill of lading archive, moving scans between an S3 compatible bucket, a shared drive and a carrier SFTP
⟬text⟭
[scans-s3]
type = s3
provider = Wasabi
access_key_id = ⟬aws_access_key_id#1⟭
secret_access_key = ⟬aws_secret_access_key#1⟭
endpoint = s3.us-east-1.wasabisys.com
acl = private

[shared-drive]
type = drive
scope = drive.readonly
token = {"access_token":"⟬opaque_token#1⟭","token_type":"Bearer","refresh_token":"⟬opaque_token#2⟭","expiry":"2026-11-02T09:15:00Z"}

[carrier-sftp]
type = sftp
host = ⟬hostname#1⟭
user = ⟬username#1⟭
port = 2022
pass = ⟬opaque_token#3⟭
⟬end⟭

⟬template⟭
family: config
format: .ini
language: en
fill_locale: en_US
domain: SaaS
appearance: section header, assignment, url
scenario: .sentryclirc at the root of an analytics dashboard project, used for source map uploads
⟬text⟭
[auth]
token=⟬opaque_token#1⟭

[defaults]
url=https://⟬hostname#1⟭/
org=relay-works
project=analytics-dashboard
⟬end⟭
