⟬template⟭
family: config
format: .env
language: en
fill_locale: en_US
domain: healthcare
appearance: assignment, comment
scenario: tiny env file of a pharmacy refill chatbot prototype, made by a pharmacist learning to code
⟬text⟭
ANTHROPIC_API_KEY=⟬anthropic_api_key#1⟭
PHARMACY_NAME="⟬company#1⟭"
# my cell for test texts
TEST_NUMBER="⟬phone#2⟭"
REFILL_DB=./refills.sqlite
⟬end⟭

⟬template⟭
family: config
format: .env
language: en
fill_locale: en_US
domain: retail
appearance: comment, assignment, url, commented-out line
scenario: env of a competitor price scraper, kept by a pricing analyst with rotating proxy logins and a classifier to tag products
⟬text⟭
# price-watch
# proxy pool, pick one, the others are burned
PROXY_URL=http://pw_scrape:⟬url_password#1⟭@⟬hostname#1⟭:8000
#PROXY_URL=http://pw_scrape:⟬url_password#2⟭@⟬hostname#2⟭:8000
#PROXY_URL=socks5://pw_alt:⟬url_password#3⟭@⟬hostname#3⟭:1080
CONCURRENCY=6
⟬trap:indicator_non_pii|USER_AGENT_POOL=./agents.txt⟭
MIN_DELAY_MS=1200

# tagging
HF_TOKEN=⟬huggingface_token#1⟭
CATEGORY_MODEL=facebook/bart-large-mnli

# results are pushed as a gist for the merch team
GIST_TOKEN=⟬github_token#1⟭
GIST_ID=⟬hash#1⟭
REPORT_TO=⟬email#3⟭
⟬end⟭

⟬template⟭
family: config
format: .env
language: en
fill_locale: en_US
domain: logistics
appearance: assignment, url, quoted value
scenario: sorted variable dump of a failed GitLab pipeline, saved with `env | sort > debug.env` by a developer and attached as a job artifact
⟬text⟭
CI=true
CI_COMMIT_AUTHOR="⟬person_name#1⟭ <⟬email#1⟭>"
CI_COMMIT_BRANCH=main
CI_COMMIT_MESSAGE="fix dock door mapping"
CI_COMMIT_SHA=⟬git_sha#1⟭
CI_JOB_ID=9912473
CI_JOB_TOKEN=⟬opaque_token#1⟭
CI_PIPELINE_SOURCE=push
CI_PROJECT_PATH=yard/dock-scheduler
CI_REGISTRY=⟬hostname#2⟭
CI_REGISTRY_PASSWORD=⟬opaque_token#2⟭
CI_REGISTRY_USER=gitlab-ci-token
CI_REPOSITORY_URL=https://gitlab-ci-token:⟬url_password#1⟭@⟬hostname#2⟭/yard/dock-scheduler.git
CI_RUNNER_DESCRIPTION=yard-shell-02
CI_SERVER_URL=https://⟬hostname#2⟭
GITLAB_TOKEN=⟬gitlab_token#1⟭
GITLAB_USER_EMAIL=⟬email#1⟭
GITLAB_USER_LOGIN=⟬person_name:handle#1⟭
GITLAB_USER_NAME="⟬person_name#1⟭"
HOME=/home/gitlab-runner
HOSTNAME=runner-yard-02
LANG=C.UTF-8
NODE_VERSION=20.17.0
PWD=/builds/yard/dock-scheduler
SHLVL=2
⟬end⟭

⟬template⟭
family: config
format: Terraform .tfvars
language: en
fill_locale: en_US
domain: SaaS
appearance: comment, assignment, object list, map value
scenario: incident tooling variables of a collaboration startup, describing PagerDuty responders and the AI postmortem drafter
⟬text⟭
# incident-tooling
pagerduty_token = "⟬opaque_token#1⟭"
statuspage_ref  = "⟬opaque_token#2⟭"

responders = {
  primary = {
    name   = "⟬person_name#2⟭"
    email  = "⟬email#2⟭"
    mobile = "⟬phone#2⟭"
    tz     = "America/Los_Angeles"
  }
  secondary = {
    name   = "⟬person_name#3⟭"
    email  = "⟬email#3⟭"
    mobile = "⟬phone#3⟭"
    tz     = "America/New_York"
  }
}

# postmortem drafter
drafter_model  = "claude-sonnet-5-5"
drafter_key    = "⟬anthropic_api_key#1⟭"
postmortem_repo       = "relay-works/postmortems"
postmortem_repo_token = "⟬github_token#1⟭"

escalation_delay_minutes = 10
⟬trap:indicator_non_pii|owner_team = "site-reliability"⟭
⟬end⟭

⟬template⟭
family: config
format: Terraform .tfvars
language: en
fill_locale: en_US
domain: fintech
appearance: comment, assignment, object list
scenario: WAF rule and rate limit settings of an online banking front door, signed off by the security architect and safe to share with auditors
⟬text⟭
# front-door WAF, online banking
# Reviewed with the security architect on ⟬date#1⟭ (⟬ticket_id#1⟭)
name_prefix  = "olb-prod"
scope        = "REGIONAL"
default_action = "allow"

managed_rule_groups = [
  { name = "AWSManagedRulesCommonRuleSet",        priority = 10, count_only = false },
  { name = "AWSManagedRulesKnownBadInputsRuleSet", priority = 20, count_only = false },
  { name = "AWSManagedRulesSQLiRuleSet",          priority = 30, count_only = false },
  { name = "AWSManagedRulesATPRuleSet",           priority = 40, count_only = true },
]

rate_limits = [
  { path = "/login",          limit = 100,  window = 300 },
  { path = "/password/reset", limit = 20,   window = 300 },
  { path = "/transfers",      limit = 300,  window = 300 },
  { path = "/api/",           limit = 2000, window = 300 },
]

⟬trap:indicator_non_pii|login_path           = "/login"⟭
⟬trap:indicator_non_pii|username_field       = "user"⟭
⟬trap:indicator_non_pii|password_field       = "pwd"⟭
⟬trap:indicator_non_pii|max_failed_logins    = 5⟭
⟬trap:indicator_non_pii|session_token_ttl    = 600⟭
⟬trap:indicator_non_pii|account_number_mask  = "****"⟭

allowed_countries = ["US"]
blocked_ips       = ["⟬ip_address#1⟭", "⟬ip_address#2⟭"]

# scoring of bot traffic uses a ⟬trap:eponym|Markov⟭ model of page transitions
bot_score_block_threshold = 90
log_group_retention_days  = 400
⟬end⟭

⟬template⟭
family: config
format: Kubernetes .yaml
language: en
fill_locale: en_US
domain: media
appearance: comment, YAML value, block scalar, nested map
scenario: GitLab Runner chart values of a game studio, with a TOML config block inside the YAML and object storage keys for the cache
⟬text⟭
# helm install studio-runner gitlab/gitlab-runner -f runner-values.yaml
gitlabUrl: https://⟬hostname#1⟭/
runnerToken: ⟬gitlab_token#1⟭
concurrent: 12
checkInterval: 10
terminationGracePeriodSeconds: 3600
rbac:
  create: true

runners:
  config: |
    [[runners]]
      [runners.kubernetes]
        namespace = "ci"
        image = "ubuntu:22.04"
        cpu_request = "2"
        memory_request = "4Gi"
      [runners.cache]
        Type = "s3"
        Path = "studio"
        Shared = true
        [runners.cache.s3]
          ServerAddress = "⟬hostname#2⟭"
          BucketName = "runner-cache"
          AccessKey = "⟬aws_access_key_id#1⟭"
          SecretKey = "⟬aws_secret_access_key#1⟭"

podAnnotations:
  owner: ⟬person_name:handle#3⟭
⟬end⟭

⟬template⟭
family: config
format: Kubernetes .yaml
language: en
fill_locale: en_US
domain: SaaS
appearance: command-line flag, YAML value, comment
scenario: Slack triage bot Deployment in which the secrets are passed as container arguments, written by a developer who had not used Secrets before
⟬text⟭
apiVersion: apps/v1
kind: Deployment
metadata:
  name: triage-bot
  namespace: internal-tools
spec:
  replicas: 1
  selector:
    matchLabels:
      app: triage-bot
  template:
    metadata:
      labels:
        app: triage-bot
    spec:
      containers:
        - name: bot
          image: ⟬hostname#1⟭/tools/triage-bot:⟬version#1⟭
          args:
            - --anthropic-key=⟬anthropic_api_key#1⟭
            - --slack-token=⟬slack_token#1⟭
            - --github-token=⟬github_token#1⟭
            - --default-assignee=⟬person_name:handle#2⟭
            - --poll-seconds=30
          ports:
            - containerPort: 3000
⟬end⟭

⟬template⟭
family: config
format: docker-compose.yml
language: en
fill_locale: en_US
domain: healthcare
appearance: comment, YAML value, environment list, label
scenario: integration engine stack of a regional lab, running Mirth Connect with a mail relay and a results API, documented by the interface analyst
⟬text⟭
# lab interfaces, HL7 inbound on 6661
# interface analyst: ⟬person_name#1⟭ - ⟬email#1⟭
services:
  mirth:
    image: nextgenhealthcare/connect:4.5.2
    environment:
      - DATABASE=postgres
      - DATABASE_URL=jdbc:postgresql://db:5432/mirth
      - DATABASE_USERNAME=mirth
      - DATABASE_PASSWORD=⟬password#1⟭
      - KEYSTORE_STOREPASS=⟬password#2⟭
      - KEYSTORE_KEYPASS=⟬password#3⟭
    ports:
      - "8443:8443"
      - "6661:6661"
    depends_on: [db]

  results-api:
    image: ⟬hostname#2⟭/lab/results-api:⟬version#1⟭
    environment:
      RESULTS_SIGNING_TOKEN: ⟬jwt#1⟭
      SENDGRID_API_KEY: ⟬sendgrid_api_key#1⟭
      CRITICAL_VALUE_CC: ⟬email#1⟭
      ⟬trap:indicator_non_pii|PATIENT_LOOKUP_FIELD: mrn⟭
    labels:
      - "maintainer=⟬email#1⟭"

  db:
    image: postgres:14
    environment:
      POSTGRES_USER: mirth
      POSTGRES_PASSWORD: ⟬password#1⟭
      POSTGRES_DB: mirth
    volumes:
      - mirth-db:/var/lib/postgresql/data

volumes:
  mirth-db:
⟬end⟭

⟬template⟭
family: config
format: docker-compose.yml
language: en
fill_locale: en_US
domain: fintech
appearance: YAML value
scenario: Metabase on a small server for a credit union's finance team, with its application database and embedding secret in plain view
⟬text⟭
services:
  metabase:
    image: metabase/metabase:v0.50.28
    ports:
      - "3000:3000"
    environment:
      MB_DB_TYPE: postgres
      MB_DB_DBNAME: metabase
      MB_DB_PORT: 5432
      MB_DB_USER: metabase
      MB_DB_PASS: "⟬password#1⟭"
      MB_DB_HOST: ⟬hostname#1⟭
      MB_ENCRYPTION_SECRET_KEY: ⟬opaque_token#1⟭
      MB_EMBEDDING_SECRET_KEY: ⟬opaque_token#2⟭
      JAVA_TIMEZONE: America/Chicago
⟬end⟭

⟬template⟭
family: config
format: docker-compose.yml
language: en
fill_locale: en_US
domain: retail
appearance: YAML value, comment, environment list, quoted value
scenario: Strapi content backend of a fashion label, with all the framework salts inline and an assistant for product descriptions
⟬text⟭
services:
  strapi:
    image: ⟬hostname#1⟭/lookbook/strapi:⟬version#1⟭
    restart: unless-stopped
    env_file: .env
    environment:
      DATABASE_CLIENT: postgres
      DATABASE_HOST: postgres
      DATABASE_NAME: lookbook
      DATABASE_USERNAME: strapi
      DATABASE_PASSWORD: "⟬password#1⟭"
      APP_KEYS: "⟬opaque_token#1⟭,⟬opaque_token#2⟭"
      API_TOKEN_SALT: ⟬opaque_token#3⟭
      ADMIN_JWT_SECRET: ⟬opaque_token#4⟭
      TRANSFER_TOKEN_SALT: ⟬opaque_token#5⟭
      JWT_SECRET: ⟬opaque_token#6⟭
      AWS_ACCESS_KEY_ID: ⟬aws_access_key_id#1⟭
      AWS_ACCESS_SECRET: ⟬aws_secret_access_key#1⟭
      AWS_BUCKET: lookbook-media
      # "write in the ⟬trap:word_name|Scarlett⟭ voice" is the label's name for the formal copy tone
      COPY_TONE: formal
      COPY_ASSIST_KEY: ⟬anthropic_api_key#1⟭
      NPM_TOKEN: ⟬npm_token#1⟭
    ports:
      - "1337:1337"
    depends_on:
      - postgres

  postgres:
    image: postgres:16-alpine
    environment:
      POSTGRES_USER: strapi
      POSTGRES_PASSWORD: "⟬password#1⟭"
      POSTGRES_DB: lookbook
⟬end⟭

⟬template⟭
family: config
format: .json
language: en
fill_locale: en_US
domain: logistics
appearance: nested JSON, string value, list item
scenario: renovate.json of a warehouse management monorepo, grouping updates and assigning reviews to teams rather than people
⟬text⟭
{
  "$schema": "https://docs.renovatebot.com/renovate-schema.json",
  "extends": ["config:recommended", ":dependencyDashboard", "schedule:earlyMondays"],
  "timezone": "America/Chicago",
  "labels": ["dependencies"],
  "reviewers": ["⟬trap:indicator_non_pii|team:wms-platform⟭"],
  "assignees": ["⟬trap:indicator_non_pii|renovate-approve[bot]⟭"],
  "prConcurrentLimit": 5,
  "packageRules": [
    {
      "matchPackagePatterns": ["^⟬trap:email_lookalike|@wms/⟭"],
      "enabled": false
    },
    {
      "groupName": "type definitions",
      "matchPackagePatterns": ["^⟬trap:email_lookalike|@types/⟭"],
      "automerge": true
    },
    {
      "groupName": "⟬trap:library|jackson⟭ libraries",
      "matchPackagePatterns": ["^com\\.fasterxml\\.jackson"],
      "matchManagers": ["gradle"]
    },
    {
      "groupName": "testing",
      "matchPackageNames": ["⟬trap:library|jest⟭", "⟬trap:library|mocha⟭", "⟬trap:library|cypress⟭"],
      "automerge": true,
      "automergeType": "branch"
    }
  ],
  "vulnerabilityAlerts": {
    "labels": ["security"],
    "schedule": ["at any time"]
  },
  "lockFileMaintenance": {
    "enabled": true,
    "schedule": ["before 5am on the first day of the month"]
  }
}
⟬end⟭

⟬template⟭
family: config
format: .json
language: en
fill_locale: en_US
domain: media
appearance: nested JSON, string value
scenario: Docker client config of a post-production render node, with base64 auth entries left by docker login
⟬text⟭
{
  "auths": {
    "ghcr.io": {
      "auth": "⟬opaque_token#1⟭"
    },
    "⟬hostname#1⟭": {
      "auth": "⟬opaque_token#2⟭",
      "email": "⟬email#2⟭"
    }
  },
  "credsStore": "",
  "HttpHeaders": {
    "User-Agent": "Docker-Client/27.3.1 (linux)"
  }
}
⟬end⟭

⟬template⟭
family: config
format: .toml
language: en
fill_locale: en_US
domain: logistics
appearance: comment, section header, string value, array of tables
scenario: settings of a runbook assistant in the operations chat of a parcel carrier, written by the team lead and deployed on a small VM
⟬text⟭
# runbook-bot settings
[slack]
bot_token = "⟬slack_token#1⟭"
app_token = "⟬slack_token#2⟭"
channels = ["ops-hub", "ops-linehaul"]

[llm]
provider = "anthropic"
model = "claude-sonnet-5-5"
api_key = "⟬anthropic_api_key#1⟭"
max_tokens = 1500

[gitlab]
url = "https://⟬hostname#1⟭"
token = "⟬gitlab_token#1⟭"
project = "ops/runbooks"
ref = "main"

[[escalations]]
service = "linehaul-api"
contact = "⟬person_name#2⟭"
phone = "⟬phone#2⟭"

[[escalations]]
service = "scan-events"
contact = "⟬person_name#3⟭"
phone = "⟬phone#3⟭"
⟬end⟭

⟬template⟭
family: config
format: .toml
language: en
fill_locale: en_US
domain: SaaS
appearance: comment, section header, multi-line string, array of tables
scenario: git-cliff configuration of a CLI product, with a changelog template that only references commit fields
⟬text⟭
# cliff.toml, changelog for the CLI
[changelog]
header = """
# Changelog
All notable changes to this project are documented here.
"""
body = """
{% for group, commits in commits | group_by(attribute="group") %}
### {{ group | upper_first }}
{% for commit in commits %}
- {{ commit.message | split(pat="\n") | first }} ({{ commit.id | truncate(length=7, end="") }}) by {{ ⟬trap:indicator_non_pii|commit.author.name⟭ }}
{% endfor %}
{% endfor %}
"""
trim = true

[git]
conventional_commits = true
filter_unconventional = true
tag_pattern = "v[0-9].*"
skip_tags = "beta|rc"
commit_parsers = [
  { message = "^feat", group = "Features" },
  { message = "^fix", group = "Fixes" },
  { message = "^docs", group = "Docs" },
  { message = "^chore\\(release\\)", skip = true },
  { ⟬trap:indicator_non_pii|field = "author.name", pattern = "dependabot\\[bot\\]"⟭, skip = true },
]

[[git.commit_preprocessors]]
pattern = "\\(#([0-9]+)\\)"
replace = "([#${1}](https://github.com/relay-works/cli/issues/${1}))"
⟬end⟭

⟬template⟭
family: config
format: .toml
language: en
fill_locale: en_US
domain: fintech
appearance: section header, string value, comment
scenario: Dynaconf settings of a tax reporting service, with the .secrets.toml content merged into the main file during a rushed audit export
⟬text⟭
[default]
app_name = "1099-reporter"
page_size = 500
⟬trap:indicator_non_pii|tin_mask = "XXX-XX-####"⟭

[production]
db_url = "postgresql+psycopg://reporter:⟬url_password#1⟭@⟬hostname#1⟭:5432/tax"
service_token = "⟬jwt#1⟭"
forms_repo_token = "⟬github_token#1⟭"
irs_tcc_contact = "⟬person_name#2⟭"
irs_transmitter_tin = "⟬us_itin#2⟭"
⟬end⟭

⟬template⟭
family: config
format: .npmrc
language: en
fill_locale: en_US
domain: media
appearance: comment, assignment
scenario: release settings of a web player team, with a version message template and a team name as the default author
⟬text⟭
# web-player release settings
message="release: %s"
tag-version-prefix=v
save-prefix=~
⟬trap:indicator_non_pii|init-author-name=Player Team⟭
init-license=UNLICENSED
⟬trap:indicator_non_pii|access=restricted⟭
⟬trap:email_lookalike|@stillwater:registry⟭=https://registry.npmjs.org/
audit=false
update-notifier=false
⟬end⟭

⟬template⟭
family: config
format: .npmrc
language: en
fill_locale: en_US
domain: fintech
appearance: assignment, comment
scenario: .npmrc of a card controls micro front end, combining a GitLab project registry and a token issued by the identity team's proxy
⟬text⟭
; card-controls
⟬trap:email_lookalike|@card-controls:registry⟭=https://⟬hostname#1⟭/api/v4/projects/733/packages/npm/
//⟬hostname#1⟭/api/v4/projects/733/packages/npm/:_authToken=⟬gitlab_token#1⟭
//⟬hostname#2⟭/npm/:_authToken=⟬jwt#1⟭
⟬end⟭

⟬template⟭
family: config
format: .npmrc
language: en
fill_locale: en_US
domain: healthcare
appearance: comment, assignment, url
scenario: build host .npmrc of a telehealth vendor, annotated by the build engineer with the rotation schedule and whom to call
⟬text⟭
# /home/build/.npmrc on tele-build-01
# rotate every 90 days, next ⟬date#1⟭. Questions: ⟬person_name#2⟭, ⟬phone#2⟭
registry=https://registry.npmjs.org/
//registry.npmjs.org/:_authToken=⟬npm_token#1⟭
⟬trap:email_lookalike|@telehealth:registry⟭=https://⟬hostname#1⟭/api/v4/packages/npm/
//⟬hostname#1⟭/api/v4/packages/npm/:_authToken=⟬gitlab_token#1⟭
⟬trap:email_lookalike|@vitals-widgets:registry⟭=https://npm.pkg.github.com
//npm.pkg.github.com/:_authToken=⟬github_token#1⟭
cache=/var/cache/npm
progress=false
⟬end⟭

⟬template⟭
family: config
format: .ini
language: en
fill_locale: en_US
domain: logistics
appearance: section header, assignment
scenario: boto configuration of a legacy Python 2 manifest uploader still running on a warehouse server
⟬text⟭
[Credentials]
aws_access_key_id = ⟬aws_access_key_id#1⟭
aws_secret_access_key = ⟬aws_secret_access_key#1⟭

[Boto]
debug = 0
num_retries = 5
https_validate_certificates = True

[s3]
calling_format = boto.s3.connection.OrdinaryCallingFormat
⟬end⟭

⟬template⟭
family: config
format: .ini
language: en
fill_locale: en_US
domain: healthcare
appearance: comment, section header, assignment, interpolation
scenario: alembic.ini of a claims database, where the URL is read from the environment and the logging sections came from the generator
⟬text⟭
# A generic, single database configuration.
[alembic]
script_location = migrations
prepend_sys_path = .
# timezone to use when rendering the date within the migration file
timezone = UTC
# max length of characters to apply to the "slug" field
truncate_slug_length = 40
# set to 'true' to run the environment during the 'revision' command
revision_environment = false
# set to 'true' to allow .pyc and .pyo files without a source .py file
sourceless = false
# version location specification
version_locations = %(here)s/migrations/versions
# the output encoding used when revision files are written
output_encoding = utf-8
# schema owner of the claims tables, not a login
⟬trap:indicator_non_pii|schema_owner = claims_admin⟭
file_template = %%(year)d%%(month).2d%%(day).2d_%%(rev)s_%%(slug)s
version_path_separator = os
# set in env.py from CLAIMS_DATABASE_URL, the value below is only a marker
sqlalchemy.url = ⟬trap:placeholder|driver://user:pass@localhost/dbname⟭

[post_write_hooks]
hooks = ruff
ruff.type = exec
ruff.executable = %(here)s/.venv/bin/ruff
ruff.options = --fix REVISION_SCRIPT_FILENAME

[loggers]
keys = root,sqlalchemy,alembic

[handlers]
keys = console

[formatters]
keys = generic

[logger_root]
level = WARN
handlers = console
qualname =

[logger_sqlalchemy]
level = WARN
handlers =
qualname = sqlalchemy.engine

[logger_alembic]
level = INFO
handlers =
qualname = alembic

[handler_console]
class = StreamHandler
args = (sys.stderr,)
level = NOTSET
formatter = generic

[formatter_generic]
format = %(levelname)-5.5s [%(name)s] %(message)s
datefmt = %H:%M:%S
⟬end⟭
