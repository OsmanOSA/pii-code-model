⟬template⟭
family: config
format: .env
language: en
fill_locale: en_US
domain: logistics
appearance: comment, assignment, quoted value
scenario: Next.js env file of a last-mile driver app on Supabase, where the service role key sits beside the keys exposed to the browser
⟬text⟭
# driver-app .env.local
NEXT_PUBLIC_SITE_URL=https://⟬hostname#1⟭
NEXT_PUBLIC_SUPABASE_URL=https://⟬hostname#2⟭
NEXT_PUBLIC_SUPABASE_ANON_KEY=⟬jwt#1⟭
NEXT_PUBLIC_MAPS_KEY=⟬google_api_key#1⟭
# server only!! never prefix this one with NEXT_PUBLIC
SUPABASE_SERVICE_ROLE_KEY=⟬jwt#2⟭
SUPABASE_DB_URL=postgresql://postgres:⟬url_password#1⟭@⟬hostname#3⟭:6543/postgres

SENDGRID_API_KEY=⟬sendgrid_api_key#1⟭
PROOF_OF_DELIVERY_BUCKET=pod-photos
⟬trap:indicator_non_pii|SIGNATURE_REQUIRED=true⟭
⟬trap:indicator_non_pii|DRIVER_SESSION_TOKEN_DAYS=14⟭

DISPATCH_DESK_PHONE="⟬phone#4⟭"
DEPOT_ADDRESS="⟬postal_address#4⟭"
⟬end⟭

⟬template⟭
family: config
format: .env
language: en
fill_locale: en_US
domain: media
appearance: comment, assignment, section header, url
scenario: sample env of a podcast hosting platform, kept current by the release manager and read by contributors outside the company
⟬text⟭
#########################################
# Podcast host: sample environment
# See docs/setup.md. Contributors never need production values.
#########################################
APP_NAME=podhost
⟬trap:indicator_non_pii|HOST_NAME=podhost-api⟭
BASE_URL=http://localhost:3000
RSS_BASE_URL=⟬url#1⟭

# Storage
S3_ENDPOINT=http://localhost:9000
S3_BUCKET=episodes
S3_ACCESS_KEY=⟬trap:placeholder|minio-access-key⟭
S3_SECRET_KEY=⟬trap:placeholder|<minio-secret-key>⟭

# Transcription
ANTHROPIC_API_KEY=⟬trap:placeholder|sk-ant-xxxxxxxxxxxxxxxxxxxxxxxxxx⟭
HUGGINGFACE_TOKEN=⟬trap:placeholder|hf_your_token_here⟭
TRANSCRIPT_LANGUAGE=en

# Text to speech, the stock voice is called ⟬trap:eponym|⦃Given⦄⟭, it is not a person on staff
TTS_VOICE=⟬trap:eponym|⦃Given⦄⟭
TTS_SPEED=1.0

# Ad insertion
⟬trap:indicator_non_pii|AD_SERVER_TOKEN_TTL=300⟭
AD_FILL_RATE_TARGET=0.85
⟬trap:indicator_non_pii|LISTENER_ADDRESS_TRUNCATION=/24⟭

# Mail
SMTP_URL=smtp://localhost:1025
⟬trap:indicator_non_pii|SMTP_USER=apikey⟭
SMTP_PASSWORD=⟬trap:placeholder|***⟭
⟬trap:indicator_non_pii|SUPPORT_NAME=Podhost Support⟭

APP_VERSION=⟬version#1⟭
⟬end⟭

⟬template⟭
family: config
format: Terraform .tfvars
language: en
fill_locale: en_US
domain: healthcare
appearance: comment, assignment, object list, map value
scenario: identity module variables of a hospital network, listing the break-glass administrators with their mobile numbers
⟬text⟭
# identity-baseline / prod
# break glass accounts are reviewed each quarter, last review ⟬date#1⟭
okta_org_name  = "mercy-valley"
okta_base_url  = "okta.com"
okta_api_token = "⟬opaque_token#1⟭"

mfa_required_groups = ["clinicians", "billing", "it-admins"]
⟬trap:indicator_non_pii|session_lifetime_minutes = 480⟭
⟬trap:indicator_non_pii|password_history_count   = 24⟭

break_glass_admins = [
  {
    first_name = "⟬person_name:given#2⟭"
    last_name  = "⟬person_name:family#2⟭"
    login      = "⟬email#2⟭"
    mobile     = "⟬phone#2⟭"
  },
  {
    first_name = "⟬person_name:given#3⟭"
    last_name  = "⟬person_name:family#3⟭"
    login      = "⟬email#3⟭"
    mobile     = "⟬phone#3⟭"
  },
]

# scribe lambda
scribe_env = {
  ANTHROPIC_API_KEY = "⟬anthropic_api_key#1⟭"
  STAGE             = "prod"
  MAX_NOTE_TOKENS   = "6000"
}

siem_webhook_url = "⟬url#1⟭"
siem_x_header    = "⟬opaque_token#2⟭"
⟬end⟭

⟬template⟭
family: config
format: Terraform .tfvars
language: en
fill_locale: en_US
domain: logistics
appearance: assignment
scenario: secrets.auto.tfvars holding only what the ops chatbot Lambda needs, created so the main tfvars could stay in Git and then committed anyway
⟬text⟭
anthropic_key   = "⟬anthropic_api_key#1⟭"
hf_read_token   = "⟬huggingface_token#1⟭"
sendgrid_key    = "⟬sendgrid_api_key#1⟭"
ops_portal_jwt  = "⟬jwt#1⟭"
⟬end⟭

⟬template⟭
family: config
format: Kubernetes .yaml
language: en
fill_locale: en_US
domain: fintech
appearance: comment, block scalar, YAML value, quoted value
scenario: GitHub Actions self-hosted runner controller for a payment processor, with the GitHub App key and a build token in clear Secrets
⟬text⟭
# actions-runner-controller, bootstrap only
apiVersion: v1
kind: Secret
metadata:
  name: controller-manager
  namespace: arc-systems
type: Opaque
stringData:
  github_app_id: "448213"
  github_app_installation_id: "51920477"
  github_app_private_key: |
    ⟬private_key#1⟭
---
apiVersion: v1
kind: Secret
metadata:
  name: runner-build-env
  namespace: arc-runners
type: Opaque
stringData:
  GH_PAT: ⟬github_token#1⟭
  NPM_TOKEN: ⟬npm_token#1⟭
---
apiVersion: actions.summerwind.dev/v1alpha1
kind: RunnerDeployment
metadata:
  name: payments-runners
  namespace: arc-runners
spec:
  replicas: 3
  template:
    spec:
      organization: halyard-pay
      labels:
        - linux
        - pci-build
      image: ⟬hostname#1⟭/ci/runner:⟬version#1⟭
      envFrom:
        - secretRef:
            name: runner-build-env
      env:
        - name: RUNNER_FEATURE_FLAG_EPHEMERAL
          value: "true"
        - name: ⟬trap:indicator_non_pii|DOCKER_USER⟭
          value: ci
---
apiVersion: actions.summerwind.dev/v1alpha1
kind: HorizontalRunnerAutoscaler
metadata:
  name: payments-runners
  namespace: arc-runners
spec:
  scaleTargetRef:
    kind: RunnerDeployment
    name: payments-runners
  minReplicas: 2
  maxReplicas: 10
  metrics:
    - type: TotalNumberOfQueuedAndInProgressWorkflowRuns
      repositoryNames:
        - halyard-pay/ledger
        - halyard-pay/settlement
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: runner-hooks
  namespace: arc-runners
data:
  pre-job.sh: |
    #!/bin/sh
    # registry mirror for the pci builds, ⟬person_name#2⟭ owns this
    npm config set registry https://⟬hostname#3⟭/npm/
    echo "//⟬hostname#3⟭/npm/:_authToken=⟬npm_token#1⟭" >> ~/.npmrc
⟬end⟭

⟬template⟭
family: config
format: Kubernetes .yaml
language: en
fill_locale: en_US
domain: retail
appearance: annotation, YAML value, comment, list item
scenario: Ingress, autoscaler and network policy of a product search API, reviewed by the security team before Black Friday
⟬text⟭
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: product-search
  namespace: catalog
  annotations:
    nginx.ingress.kubernetes.io/limit-rps: "50"
    nginx.ingress.kubernetes.io/proxy-read-timeout: "15"
    cert-manager.io/cluster-issuer: letsencrypt-prod
    ⟬trap:indicator_non_pii|owner: search-relevance⟭
spec:
  ingressClassName: nginx
  tls:
    - hosts:
        - ⟬hostname#1⟭
      secretName: ⟬trap:indicator_non_pii|product-search-tls⟭
  rules:
    - host: ⟬hostname#1⟭
      http:
        paths:
          - path: /v2/search
            pathType: Prefix
            backend:
              service:
                name: product-search
                port:
                  number: 8080
---
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: product-search
  namespace: catalog
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: product-search
  minReplicas: 6
  maxReplicas: 40
  metrics:
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: 60
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: product-search
  namespace: catalog
spec:
  podSelector:
    matchLabels:
      app: product-search
  policyTypes: ["Ingress", "Egress"]
  ingress:
    - from:
        - namespaceSelector:
            matchLabels:
              name: ingress-nginx
  egress:
    - to:
        - podSelector:
            matchLabels:
              app: ⟬trap:library|elasticsearch⟭
      ports:
        - port: 9200
    # typo tolerance runs ⟬trap:eponym|Levenshtein⟭ automata inside the search node
    - to:
        - ipBlock:
            cidr: 10.32.0.0/16
⟬end⟭

⟬template⟭
family: config
format: docker-compose.yml
language: en
fill_locale: en_US
domain: SaaS
appearance: YAML value, comment, quoted value, environment list
scenario: Langfuse tracing stack for a support copilot, stood up by the tech lead with its init user and project keys hardcoded
⟬text⟭
services:
  langfuse:
    image: langfuse/langfuse:2
    ports:
      - "3000:3000"
    depends_on:
      - postgres
    environment:
      DATABASE_URL: postgresql://langfuse:⟬url_password#1⟭@postgres:5432/langfuse
      NEXTAUTH_URL: https://⟬hostname#1⟭
      NEXTAUTH_SECRET: ⟬opaque_token#1⟭
      SALT: ⟬opaque_token#2⟭
      ENCRYPTION_KEY: ⟬opaque_token#3⟭
      LANGFUSE_INIT_ORG_NAME: "⟬company#2⟭"
      LANGFUSE_INIT_PROJECT_NAME: support-copilot
      LANGFUSE_INIT_PROJECT_PUBLIC_KEY: pk-lf-⟬uuid#1⟭
      LANGFUSE_INIT_PROJECT_SECRET_KEY: ⟬opaque_token#4⟭
      LANGFUSE_INIT_USER_NAME: "⟬person_name#3⟭"
      LANGFUSE_INIT_USER_EMAIL: ⟬email#3⟭
      LANGFUSE_INIT_USER_PASSWORD: "⟬password#1⟭"

  copilot:
    image: ⟬hostname#4⟭/support/copilot:⟬version#1⟭
    environment:
      ANTHROPIC_API_KEY: ⟬anthropic_api_key#1⟭
      OPENAI_API_KEY: ⟬openai_api_key#1⟭
      LANGFUSE_HOST: http://langfuse:3000
      ⟬trap:indicator_non_pii|TICKET_ASSIGNEE: unassigned⟭

  postgres:
    image: postgres:15
    environment:
      POSTGRES_USER: langfuse
      POSTGRES_DB: langfuse
      POSTGRES_PASSWORD: ⟬url_password#1⟭
    volumes:
      - langfuse-db:/var/lib/postgresql/data

  langfuse-worker:
    image: langfuse/langfuse-worker:3
    depends_on:
      - postgres
    environment:
      DATABASE_URL: postgresql://langfuse:⟬url_password#1⟭@postgres:5432/langfuse
      SALT: ⟬opaque_token#2⟭
      ENCRYPTION_KEY: ⟬opaque_token#3⟭
      REDIS_CONNECTION_STRING: redis://:⟬url_password#2⟭@redis:6379/0

  redis:
    image: redis:7-alpine
    command: --requirepass ⟬url_password#2⟭

  minio:
    image: minio/minio:RELEASE.2024-10-13T13-34-11Z
    command: server /data --console-address ":9001"
    environment:
      MINIO_ROOT_USER: ⟬username#1⟭
      MINIO_ROOT_PASSWORD: "⟬password#2⟭"
    volumes:
      - langfuse-s3:/data

volumes:
  langfuse-db:
  langfuse-s3:
⟬end⟭

⟬template⟭
family: config
format: docker-compose.yml
language: en
fill_locale: en_US
domain: media
appearance: environment list, YAML value, comment
scenario: Ghost blog of a regional magazine on one VPS, deployed by a staff writer following an online tutorial
⟬text⟭
services:
  ghost:
    image: ghost:5-alpine
    restart: always
    ports:
      - "2368:2368"
    environment:
      url: https://⟬hostname#1⟭
      database__client: mysql
      database__connection__host: db
      database__connection__user: ghost
      database__connection__password: ⟬password#1⟭
      database__connection__database: ghost
      mail__transport: SMTP
      mail__options__host: smtp.sendgrid.net
      mail__options__port: 587
      ⟬trap:indicator_non_pii|mail__options__auth__user: apikey⟭
      mail__options__auth__pass: ⟬sendgrid_api_key#1⟭
      mail__from: "⟬company#2⟭ <⟬email:generic#2⟭>"
    volumes:
      - ./content:/var/lib/ghost/content

  db:
    image: mysql:8.0
    environment:
      # same one as above, tutorial said so
      MYSQL_ROOT_PASSWORD: ⟬password#1⟭
⟬end⟭

⟬template⟭
family: config
format: .json
language: en
fill_locale: en_US
domain: logistics
appearance: nested JSON, string value, list item
scenario: VS Code launch configuration of a freight quote service, with the debug environment typed by hand and shared through the repository
⟬text⟭
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "quote-api (attach staging data)",
      "type": "node",
      "request": "launch",
      "program": "${workspaceFolder}/src/server.ts",
      "runtimeArgs": ["--loader", "ts-node/esm"],
      "console": "integratedTerminal",
      "env": {
        "NODE_ENV": "development",
        "ANTHROPIC_API_KEY": "⟬anthropic_api_key#1⟭",
        "AWS_REGION": "us-east-1",
        "AWS_ACCESS_KEY_ID": "⟬aws_access_key_id#1⟭",
        "AWS_SECRET_ACCESS_KEY": "⟬aws_secret_access_key#1⟭",
        "RATES_API": "⟬url#1⟭",
        "RATES_BEARER": "⟬jwt#1⟭"
      }
    },
    {
      "name": "quote-worker",
      "type": "node",
      "request": "launch",
      "program": "${workspaceFolder}/src/worker.ts",
      "env": {
        "QUEUE_URL": "amqp://quote:⟬url_password#1⟭@⟬hostname#1⟭:5672/quotes"
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
appearance: nested JSON, name-value list, string value
scenario: ECS task definition of a loan pricing API, exported from the console by an engineer and pasted into the repository for diffing
⟬text⟭
{
  "family": "loan-pricing-api",
  "networkMode": "awsvpc",
  "requiresCompatibilities": ["FARGATE"],
  "cpu": "1024",
  "memory": "2048",
  "executionRoleArn": "arn:aws:iam::210987654321:role/ecsTaskExecution",
  "containerDefinitions": [
    {
      "name": "api",
      "image": "⟬hostname#1⟭/lending/pricing-api:⟬version#1⟭",
      "essential": true,
      "portMappings": [{ "containerPort": 8080, "protocol": "tcp" }],
      "environment": [
        { "name": "SPRING_PROFILES_ACTIVE", "value": "prod" },
        { "name": "AWS_ACCESS_KEY_ID", "value": "⟬aws_access_key_id#1⟭" },
        { "name": "AWS_SECRET_ACCESS_KEY", "value": "⟬aws_secret_access_key#1⟭" },
        { "name": "BUREAU_SFTP_HOST", "value": "⟬hostname#2⟭" },
        { "name": "BUREAU_SFTP_USER", "value": "⟬username#1⟭" },
        { "name": "BUREAU_SFTP_PASS", "value": "⟬password#1⟭" },
        { "name": "EXPLAINER_LLM_KEY", "value": "⟬openai_api_key#1⟭" },
        { "name": "LOG_LEVEL", "value": "INFO" }
      ],
      "secrets": [
        { "name": "DB_PASSWORD", "valueFrom": "arn:aws:ssm:us-east-1:210987654321:parameter/pricing/db" }
      ],
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "/ecs/loan-pricing-api",
          "awslogs-region": "us-east-1",
          "awslogs-stream-prefix": "api"
        }
      },
      "healthCheck": {
        "command": ["CMD-SHELL", "curl -f http://localhost:8080/actuator/health || exit 1"],
        "interval": 30,
        "retries": 3
      }
    },
    {
      "name": "otel",
      "image": "public.ecr.aws/aws-observability/aws-otel-collector:v0.40.0",
      "essential": false,
      "command": ["--config=/etc/ecs/ecs-default-config.yaml"],
      "environment": [
        { "name": "AWS_REGION", "value": "us-east-1" },
        { "name": "DD_API_KEY", "value": "⟬opaque_token#1⟭" }
      ]
    }
  ],
  "volumes": [],
  "tags": [
    { "key": "owner", "value": "⟬email#2⟭" },
    { "key": "cost-center", "value": "3120" }
  ],
  "runtimePlatform": {
    "cpuArchitecture": "ARM64",
    "operatingSystemFamily": "LINUX"
  }
}
⟬end⟭

⟬template⟭
family: config
format: .json
language: en
fill_locale: en_US
domain: SaaS
appearance: nested JSON, string value, list item
scenario: semantic-release configuration of a TypeScript SDK, whose tokens come from CI and whose commit author is the release bot
⟬text⟭
{
  "branches": ["main", { "name": "next", "prerelease": true }],
  "tagFormat": "v${version}",
  "plugins": [
    "⟬trap:email_lookalike|@semantic-release/commit-analyzer⟭",
    "⟬trap:email_lookalike|@semantic-release/release-notes-generator⟭",
    ["⟬trap:email_lookalike|@semantic-release/changelog⟭", { "changelogFile": "CHANGELOG.md" }],
    ["⟬trap:email_lookalike|@semantic-release/npm⟭", { "npmPublish": true, "pkgRoot": "dist" }],
    [
      "⟬trap:email_lookalike|@semantic-release/git⟭",
      {
        "assets": ["CHANGELOG.md", "package.json"],
        "message": "chore(release): ${nextRelease.version} [skip ci]"
      }
    ],
    [
      "⟬trap:email_lookalike|@semantic-release/github⟭",
      { "successComment": false, "assignees": ["⟬trap:indicator_non_pii|release-bot[bot]⟭"] }
    ]
  ]
}
⟬end⟭

⟬template⟭
family: config
format: .toml
language: en
fill_locale: en_US
domain: healthcare
appearance: section header, string value, url, comment
scenario: pyproject.toml of a triage note classifier, with both authors listed and a private index URL carrying its deploy token
⟬text⟭
[tool.poetry]
name = "triage-nlp"
version = "⟬version#1⟭"
description = "Classifies nurse triage notes into urgency levels"
authors = ["⟬person_name#1⟭ <⟬email#1⟭>", "⟬person_name#2⟭ <⟬email#2⟭>"]
readme = "README.md"
packages = [{ include = "triage_nlp" }]

[tool.poetry.dependencies]
python = "^3.11"
torch = "^2.4"
⟬trap:library|transformers⟭ = "^4.45"
⟬trap:library|pydantic⟭ = "^2.9"
httpx = "^0.27"

[tool.poetry.group.dev.dependencies]
⟬trap:library|pytest⟭ = "^8.3"
ruff = "^0.6"

# wheels with the clinical tokenizer
[[tool.poetry.source]]
name = "internal"
url = "https://__token__:⟬gitlab_token#1⟭@⟬hostname#1⟭/api/v4/projects/204/packages/pypi/simple"
priority = "explicit"

[tool.ruff]
line-length = 110

[build-system]
requires = ["poetry-core"]
build-backend = "poetry.core.masonry.api"
⟬end⟭

⟬template⟭
family: config
format: .toml
language: en
fill_locale: en_US
domain: media
appearance: comment, section header, string value, url
scenario: Pipfile of a subtitle alignment service pinned to a mirror with basic auth in the source URL
⟬text⟭
# pipenv install --deploy
[[source]]
name = "mirror"
url = "https://deploy:⟬url_password#1⟭@⟬hostname#1⟭/simple"
verify_ssl = true

[packages]
⟬trap:library|flask⟭ = "==3.0.3"
⟬trap:library|celery⟭ = "==5.4.0"
⟬trap:library|jinja2⟭ = "==3.1.4"
⟬trap:library|sphinx⟭ = "==8.0.2"
webvtt-py = "==0.5.1"
aeneas = "==1.7.3"

[dev-packages]
⟬trap:library|pytest⟭ = "==8.3.3"

[requires]
python_version = "3.11"
⟬end⟭

⟬template⟭
family: config
format: .toml
language: en
fill_locale: en_US
domain: fintech
appearance: section header, string value, comment
scenario: Cargo configuration of a risk engine team that hosts crates on a private registry, copied into the build image
⟬text⟭
# .cargo/config.toml
[registries.risk-crates]
index = "sparse+https://⟬hostname#1⟭/api/v1/crates/"
token = "Bearer ⟬jwt#1⟭"

[net]
git-fetch-with-cli = true

[build]
rustflags = ["-C", "target-cpu=x86-64-v3"]

[source.crates-io]
replace-with = "risk-crates"
⟬end⟭

⟬template⟭
family: config
format: .npmrc
language: en
fill_locale: en_US
domain: media
appearance: assignment, comment
scenario: legacy .npmrc of a CMS theme, still using a Nexus basic auth pair from before tokens were available
⟬text⟭
; old nexus login, works for now
registry=https://⟬hostname#1⟭/repository/npm-group/
_auth=⟬opaque_token#1⟭
email=⟬email#2⟭
always-auth=true
//⟬hostname#1⟭/repository/npm-private/:username=⟬username#1⟭
//⟬hostname#1⟭/repository/npm-private/:_password=⟬opaque_token#2⟭
⟬end⟭

⟬template⟭
family: config
format: .npmrc
language: en
fill_locale: en_US
domain: healthcare
appearance: assignment, url, comment
scenario: .npmrc of a patient app front end with three registries, one being the paid icon kit
⟬text⟭
⟬trap:email_lookalike|@fortawesome:registry⟭=https://npm.fontawesome.com/
//npm.fontawesome.com/:_authToken=⟬opaque_token#1⟭
⟬trap:email_lookalike|@carepath:registry⟭=https://npm.pkg.github.com
//npm.pkg.github.com/:_authToken=⟬github_token#1⟭
//registry.npmjs.org/:_authToken=⟬npm_token#1⟭
# no postinstall from third parties, see the appsec note
ignore-scripts=true
⟬end⟭

⟬template⟭
family: config
format: .npmrc
language: en
fill_locale: en_US
domain: retail
appearance: comment, assignment, list item
scenario: pnpm settings of a store front monorepo, tuned by the front-end guild and free of any credential
⟬text⟭
# pnpm settings, shared by every package of the monorepo
shamefully-hoist=false
strict-peer-dependencies=true
auto-install-peers=true
link-workspace-packages=deep
prefer-workspace-packages=true
node-linker=isolated
public-hoist-pattern[]=*eslint*
public-hoist-pattern[]=*prettier*
public-hoist-pattern[]=⟬trap:email_lookalike|@types/*⟭
hoist-pattern[]=*⟬trap:library|jest⟭*
resolution-mode=highest
save-workspace-protocol=rolling
store-dir=~/.pnpm-store
verify-store-integrity=true
⟬trap:indicator_non_pii|registry-auth-required=false⟭
⟬end⟭

⟬template⟭
family: config
format: .ini
language: en
fill_locale: en_US
domain: media
appearance: section header, assignment, url, comment
scenario: .gitconfig of a video editor turned developer, synced between machines with a token embedded in a rewrite rule
⟬text⟭
[user]
	name = ⟬person_name#1⟭
	email = ⟬email#1⟭
[core]
	editor = nvim
	autocrlf = input
[init]
	defaultBranch = main
[pull]
	rebase = true
# so that go get works with the private repos
[url "https://x-access-token:⟬github_token#1⟭@github.com/"]
	insteadOf = https://github.com/
[alias]
	st = status -sb
	lg = log --oneline --graph --decorate -20
[push]
	autoSetupRemote = true
⟬end⟭

⟬template⟭
family: config
format: .ini
language: en
fill_locale: en_US
domain: SaaS
appearance: section header, assignment, comment
scenario: grafana.ini of a usage metering product, restored from a VM snapshot with database, admin, SMTP and OAuth credentials all in clear
⟬text⟭
##################### Grafana Configuration #####################
[server]
protocol = http
http_port = 3000
domain = ⟬hostname#1⟭
root_url = https://⟬hostname#1⟭/
enforce_domain = false

[database]
type = postgres
host = ⟬hostname#2⟭:5432
name = grafana
user = grafana
password = ⟬password#1⟭
ssl_mode = require

[security]
admin_user = ⟬username#1⟭
admin_password = ⟬password#2⟭
secret_key = ⟬opaque_token#1⟭
cookie_secure = true
⟬trap:indicator_non_pii|password_hint = ask the platform channel⟭

[users]
allow_sign_up = false
auto_assign_org_role = Viewer

[auth.github]
enabled = true
allow_sign_up = true
client_id = ⟬hash#1⟭
client_secret = ⟬opaque_token#2⟭
scopes = user:email,read:org
allowed_organizations = relay-works

[smtp]
enabled = true
host = smtp.sendgrid.net:587
⟬trap:indicator_non_pii|user = apikey⟭
password = ⟬sendgrid_api_key#1⟭
from_address = ⟬email:generic#3⟭
from_name = ⟬trap:indicator_non_pii|Metering Alerts⟭

[log]
mode = console
level = warn

[metrics]
enabled = true
interval_seconds = 15

[alerting]
enabled = false

[unified_alerting]
enabled = true
execute_alerts = true
evaluation_timeout = 30s

[dataproxy]
timeout = 60
keep_alive_seconds = 30

[analytics]
reporting_enabled = false
check_for_updates = false

[paths]
provisioning = /etc/grafana/provisioning
⟬end⟭

⟬template⟭
family: config
format: .ini
language: en
fill_locale: en_US
domain: logistics
appearance: section header, assignment, comment, list item
scenario: tox.ini of a customs tariff classifier, with environment variables set to harmless values for the test matrix
⟬text⟭
[tox]
envlist = py311, py312, lint, docs
isolated_build = True

[testenv]
deps =
    -r requirements-dev.txt
setenv =
    TARIFF_DB = sqlite:///:memory:
    ⟬trap:indicator_non_pii|API_TOKEN_REQUIRED = 0⟭
    ⟬trap:indicator_non_pii|PASSWORD_HASH_ROUNDS = 4⟭
    HTTP_RETRIES = 0
passenv =
    CI
    ⟬trap:indicator_non_pii|AWS_ACCESS_KEY_ID⟭
    ⟬trap:indicator_non_pii|AWS_SECRET_ACCESS_KEY⟭
commands =
    ⟬trap:library|pytest⟭ --cov=tariffs --cov-report=term-missing {posargs}

[testenv:lint]
skip_install = True
deps = ruff
commands = ruff check tariffs tests

[testenv:docs]
deps = ⟬trap:library|sphinx⟭
commands = sphinx-build -W -b html docs docs/_build

; the nearest heading match is a ⟬trap:eponym|Jaccard⟭ index over 6 digit codes
[tariffs]
similarity_floor = 0.42
⟬end⟭
