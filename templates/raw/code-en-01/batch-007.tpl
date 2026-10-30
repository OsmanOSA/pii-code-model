⟬template⟭
family: code
format: .sh
language: en
fill_locale: en_US
domain: SaaS
appearance: URL, command-line argument, comment
scenario: CI image build step installing internal packages from a private Python index with the reader password inside the index URL
⟬text⟭
# install the internal packages from the private index (CI image build, stage 1)
pip install --no-cache-dir \
  --index-url "https://ci-reader:⟬url_password#1⟭@⟬hostname#1⟭/simple/" \
  --extra-index-url https://pypi.org/simple/ \
  -r requirements/internal.txt
⟬end⟭

⟬template⟭
family: code
format: .py
language: en
fill_locale: en_US
domain: fintech
appearance: connection string, dict literal, comment
scenario: scratch script by a ledger engineer checking why the statement job skips one account, with the read-only DSN pasted in
⟬text⟭
# scratch: why does the statement job skip this account? (⟬ticket_id#1⟭)
from sqlalchemy import create_engine, text

engine = create_engine("postgresql+psycopg://ledger_ro:⟬url_password#1⟭@⟬hostname#1⟭:5432/ledger")
with engine.connect() as conn:
    rows = conn.execute(
        text("SELECT statement_month, status, error FROM stmt.jobs WHERE account_number = :acct ORDER BY 1 DESC LIMIT 6"),
        {"acct": "⟬bank_account_number#1⟭"},
    ).all()
for row in rows:
    print(row)
⟬end⟭

⟬template⟭
family: code
format: .sql
language: en
fill_locale: en_US
domain: government
appearance: comment, SQL WHERE
scenario: DMV analyst's lookup verifying a driver for a court clerk who called with a license number and date of birth
⟬text⟭
-- verify a driver for the court clerk (request by phone, ⟬date#1⟭)
SELECT dl_number, last_name, first_name, status, class, expires_on, points
FROM dmv.licenses
WHERE dl_number = '⟬us_driver_license#1⟭'
  AND dob = '⟬birth_date#1⟭';
⟬end⟭

⟬template⟭
family: code
format: .sh
language: en
fill_locale: en_US
domain: insurance
appearance: environment variable, URL, comment
scenario: claims handler's one-liner presigning a claim document link for an outside appraiser, with the sharing user's keys inline
⟬text⟭
# share the engineer's report for claim ⟬order_number#1⟭ with the outside appraiser
# (⟬person_name#2⟭, ⟬email#2⟭); link valid 72h. Keys: the claims-share IAM user.
AWS_ACCESS_KEY_ID=⟬aws_access_key_id#1⟭ AWS_SECRET_ACCESS_KEY=⟬aws_secret_access_key#1⟭ \
  aws s3 presign "s3://claims-docs/⟬order_number#1⟭/engineer_report.pdf" --expires-in 259200
⟬end⟭

⟬template⟭
family: code
format: .py
language: en
fill_locale: en_US
domain: healthcare
appearance: doctest, f-string
scenario: patient portal helper masking SSNs for display, with a doctest someone wrote with a real-looking number
⟬text⟭
def mask_ssn(ssn: str) -> str:
    """Keep the last four digits for display.

    >>> mask_ssn("⟬us_ssn#1⟭")[:7]
    ⟬trap:placeholder|'***-**-'⟭
    >>> mask_ssn("")
    ''
    """
    digits = "".join(ch for ch in ssn if ch.isdigit())
    return f"***-**-{digits[-4:]}" if len(digits) == 9 else ""
⟬end⟭

⟬template⟭
family: code
format: .py
language: en
fill_locale: en_US
domain: retail
appearance: keyword argument, assertion, test fixture
scenario: Django signal that emails order confirmations once an order is paid, with a TestCase checking the email body
⟬text⟭
"""Send the order confirmation email when an order is paid."""
from django.core import mail
from django.core.mail import send_mail
from django.db.models.signals import post_save
from django.dispatch import receiver
from django.template.loader import render_to_string
from django.test import TestCase

from shop.models import Order


@receiver(post_save, sender=Order)
def send_confirmation(sender, instance: Order, created: bool, **kwargs):
    if instance.status != "paid" or instance.confirmation_sent:
        return
    body = render_to_string("emails/order_confirmation.txt", {"order": instance})
    send_mail(f"Order {instance.number} confirmed", body, None, [instance.email])
    Order.objects.filter(pk=instance.pk).update(confirmation_sent=True)


class ConfirmationEmailTests(TestCase):
    def test_paid_order_sends_one_email(self):
        order = Order.objects.create(
            number="⟬order_number#1⟭",
            customer_name="⟬person_name#1⟭",
            email="⟬email#1⟭",
            ship_to="⟬postal_address#1⟭",
            status="paid",
        )
        self.assertEqual(len(mail.outbox), 1)
        self.assertIn("⟬person_name:given#1⟭", mail.outbox[0].body)
        self.assertIn("⟬postal_address:street#1⟭", mail.outbox[0].body)
        order.save()
        self.assertEqual(len(mail.outbox), 1)
⟬end⟭

⟬template⟭
family: code
format: .ipynb
language: en
fill_locale: en_US
domain: insurance
appearance: notebook output, keyword argument, markdown cell, free text
scenario: claims innovation analyst extracting first-notice-of-loss fields from call center transcripts with OpenAI structured outputs
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# FNOL call transcripts to claim fields\n",
    "Structured outputs over the call center transcripts (speech-to-text already done upstream)."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "AGENT: Claims, this is ⟬person_name:given#5⟭, can I have your policy number?\n",
      "CALLER: yeah it's ⟬customer_id#2⟭. I got rear-ended on the 290 feeder about an hour ago\n",
      "AGENT: Sorry to hear that. Anyone hurt? Did you get the other driver's plate?\n",
      "CALLER: nobody hurt. their plate was ⟬us_license_plate#3⟭, white pickup. mine is ⟬us_license_plate#2⟭\n",
      "AGENT: Best number to reach you?\n",
      "CALLER: ⟬phone#2⟭, it's ⟬person_name#2⟭ by the way\n"
     ]
    }
   ],
   "source": [
    "from openai import OpenAI\n",
    "from pydantic import BaseModel\n",
    "\n",
    "client = OpenAI(api_key=\"⟬openai_api_key#1⟭\")\n",
    "transcripts = load_transcripts(\"⟬file_path#1⟭\")\n",
    "print(transcripts[3])"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "Fnol(policy='⟬customer_id#2⟭', caller='⟬person_name#2⟭', callback='⟬phone#2⟭', insured_plate='⟬us_license_plate#2⟭', other_plate='⟬us_license_plate#3⟭', injuries=False, loss='rear-ended on highway frontage road')"
      ]
     },
     "execution_count": 2,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "class Fnol(BaseModel):\n",
    "    policy: str\n",
    "    caller: str\n",
    "    callback: str\n",
    "    insured_plate: str\n",
    "    other_plate: str | None\n",
    "    injuries: bool\n",
    "    loss: str\n",
    "\n",
    "resp = client.beta.chat.completions.parse(\n",
    "    model=\"gpt-4o\",\n",
    "    messages=[{\"role\": \"system\", \"content\": \"Extract the first notice of loss from the call.\"},\n",
    "              {\"role\": \"user\", \"content\": transcripts[3]}],\n",
    "    response_format=Fnol,\n",
    ")\n",
    "resp.choices[0].message.parsed"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "11 of 12 fields right on 50 calls. Misses the callback number when the caller corrects a digit halfway through."
   ]
  }
 ],
 "metadata": {
  "kernelspec": {"display_name": "Python 3", "language": "python", "name": "python3"},
  "language_info": {"name": "python", "version": "3.11.9"}
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
⟬end⟭

⟬template⟭
family: code
format: .sql
language: en
fill_locale: en_US
domain: fintech
appearance: comment, SQL WHERE
scenario: KYC analyst's duplicate identity check before approving an application, on the same passport or the same ITIN
⟬text⟭
-- duplicate identity check before approving application ⟬order_number#1⟭:
-- is the same passport or the same ITIN on any other customer?
SELECT c.customer_id, c.legal_name, d.doc_type, d.doc_number, c.tin, c.created_at
FROM kyc.documents d
JOIN core.customers c ON c.customer_id = d.customer_id
WHERE (d.doc_type = 'passport' AND d.doc_number = '⟬us_passport#1⟭')
   OR c.tin = '⟬us_itin#1⟭';
⟬end⟭

⟬template⟭
family: code
format: .sh
language: en
fill_locale: en_US
domain: healthcare
appearance: command-line argument, comment
scenario: build command of a de-identification service image that bakes the model in, with tokens passed as build arguments
⟬text⟭
# build the de-id service image; the model is baked in at build time (no Hub access in prod)
docker build \
  --build-arg HF_TOKEN=⟬huggingface_token#1⟭ \
  --build-arg OPENAI_API_KEY=⟬openai_api_key#1⟭ \
  -t ⟬hostname#1⟭/deid-service:⟬version#1⟭ .
# TODO: use build secrets (--secret id=hf,env=HF_TOKEN) so the token stays out of the image history
⟬end⟭

⟬template⟭
family: code
format: .py
language: en
fill_locale: en_US
domain: government
appearance: nested dict, class attribute, docstring
scenario: request and response models of a state vehicle registration renewal API, with an OpenAPI example of a renewal
⟬text⟭
"""Request and response models of the registration renewal API (v2)."""
from datetime import date
from typing import Literal

from pydantic import BaseModel, ConfigDict, Field


class Owner(BaseModel):
    name: str
    dl_number: str = Field(description="Driver license number of the primary owner")
    mailing_address: str


class RenewalRequest(BaseModel):
    model_config = ConfigDict(json_schema_extra={
        "examples": [{
            "plate": "⟬us_license_plate#1⟭",
            "plate_type": "passenger",
            "owner": {
                "name": "⟬person_name#1⟭",
                "dl_number": "⟬us_driver_license#1⟭",
                "mailing_address": "⟬postal_address#1⟭",
            },
            "insurance_policy": "⟬customer_id#1⟭",
            "emissions_cert": "⟬order_number#1⟭",
        }]
    })

    plate: str = Field(pattern=r"^[A-Z0-9 -]{2,8}$")
    plate_type: Literal["passenger", "commercial", "motorcycle", "trailer"]
    owner: Owner
    insurance_policy: str
    emissions_cert: str | None = None


class RenewalResponse(BaseModel):
    renewal_id: str
    fee_cents: int
    new_expiry: date
    sticker_mailed_to: str
⟬end⟭

⟬template⟭
family: code
format: .py
language: en
fill_locale: en_US
domain: SaaS
appearance: assignment, HTTP header, keyword argument, docstring
scenario: merge request review bot run in GitLab CI that asks Claude for a first-pass review, with fallback tokens hard-coded for local runs
⟬text⟭
"""Merge request review bot: asks Claude for a first-pass review and posts it as a note.

Runs in CI on merge request pipelines (CI_MERGE_REQUEST_IID is set). The fallbacks
below are for running it by hand.
"""
import os

import anthropic
import requests

GITLAB = os.environ.get("CI_SERVER_URL", "⟬url#1⟭")
PROJECT = os.environ["CI_PROJECT_ID"]
MR = os.environ["CI_MERGE_REQUEST_IID"]
GITLAB_TOKEN = os.environ.get("REVIEW_BOT_TOKEN", "⟬gitlab_token#1⟭")
claude = anthropic.Anthropic(api_key=os.environ.get("ANTHROPIC_API_KEY", "⟬anthropic_api_key#1⟭"))

headers = {"PRIVATE-TOKEN": GITLAB_TOKEN}
changes = requests.get(f"{GITLAB}/api/v4/projects/{PROJECT}/merge_requests/{MR}/changes", headers=headers, timeout=30).json()
diff = "\n".join(change["diff"] for change in changes["changes"])[:150_000]

review = claude.messages.create(
    model="claude-sonnet-4-5",
    max_tokens=2000,
    system="Review this diff. Bugs and risky changes first, style last. Be brief.",
    messages=[{"role": "user", "content": diff}],
).content[0].text

requests.post(
    f"{GITLAB}/api/v4/projects/{PROJECT}/merge_requests/{MR}/notes",
    headers=headers,
    json={"body": review},
    timeout=30,
).raise_for_status()
⟬end⟭

⟬template⟭
family: code
format: .sh
language: en
fill_locale: en_US
domain: government
appearance: heredoc, environment variable, command-line argument
scenario: front-end build and deploy script of a state benefits portal that writes an npm token into .npmrc and deploys with inline AWS keys
⟬text⟭
#!/usr/bin/env bash
# build_portal.sh: build the benefits portal front end and deploy it to the static bucket.
# Needs the private scope from the npm registry.
set -euo pipefail

cat > .npmrc <<EOF
⟬trap:email_lookalike|@agency:registry=https://registry.npmjs.org/⟭
//registry.npmjs.org/:_authToken=⟬npm_token#1⟭
EOF
npm ci
npm run build -- --mode production
rm -f .npmrc

export AWS_ACCESS_KEY_ID=⟬aws_access_key_id#1⟭
export AWS_SECRET_ACCESS_KEY=⟬aws_secret_access_key#1⟭
aws s3 sync dist/ s3://benefits-portal-web/ --delete --cache-control "public,max-age=300"
aws cloudfront create-invalidation --distribution-id E2PORTAL01 --paths "/index.html" >/dev/null
echo "deployed $(git rev-parse --short HEAD)"
⟬end⟭

⟬template⟭
family: code
format: .ipynb
language: en
fill_locale: en_US
domain: fintech
appearance: notebook output, keyword argument, markdown cell
scenario: fraud data scientist checking labeled synthetic-identity cases before uploading the training set, without identifiers, to a private Hugging Face dataset
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Application fraud model v4: training set check before upload\n",
    "Synthetic-identity cases labeled by the fraud team. Identifiers must be dropped before anything goes to the Hub."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "                applicant          tin           dob   funding_account  label\n",
       "211   ⟬person_name#2⟭  ⟬us_ssn#2⟭  ⟬birth_date#2⟭  ⟬bank_account_number#2⟭      1\n",
       "4078  ⟬person_name#3⟭  ⟬us_itin#3⟭  ⟬birth_date#3⟭  ⟬bank_account_number#3⟭      1\n",
       "5122  ⟬person_name#4⟭  ⟬us_ssn#4⟭  ⟬birth_date#4⟭  ⟬bank_account_number#2⟭      1"
      ]
     },
     "execution_count": 1,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "import ⟬trap:library|pandas⟭ as pd\n",
    "from huggingface_hub import HfApi\n",
    "\n",
    "api = HfApi(token=\"⟬huggingface_token#1⟭\")\n",
    "apps = pd.read_parquet(\"⟬file_path#1⟭\")\n",
    "apps.loc[apps.label == 1, [\"applicant\", \"tin\", \"dob\", \"funding_account\", \"label\"]].head(3)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "metadata": {},
   "outputs": [],
   "source": [
    "features = apps.drop(columns=[\"applicant\", \"tin\", \"dob\", \"funding_account\"])\n",
    "features.to_parquet(\"train.parquet\")\n",
    "api.upload_file(path_or_fileobj=\"train.parquet\", path_in_repo=\"data/train.parquet\", repo_id=\"risk-team/app-fraud-v4\", repo_type=\"dataset\")"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Rows 211 and 5122 share a funding account: a classic synthetic identity ring. Identifier columns dropped before the upload."
   ]
  }
 ],
 "metadata": {
  "kernelspec": {"display_name": "Python 3", "language": "python", "name": "python3"},
  "language_info": {"name": "python", "version": "3.11.9"}
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
⟬end⟭

⟬template⟭
family: code
format: .sql
language: en
fill_locale: en_US
domain: healthcare
appearance: SQL INSERT, comment
scenario: seed of two test patients with full contact details for a scheduling sandbox
⟬text⟭
-- seed for the scheduling sandbox: two test patients with full contact details
INSERT INTO sched.patients (mrn, full_name, phone, home_address, preferred_language) VALUES
('⟬customer_id#1⟭', '⟬person_name#1⟭', '⟬phone#1⟭', '⟬postal_address#1⟭', 'en'),
('⟬customer_id#2⟭', '⟬person_name#2⟭', '⟬phone#2⟭', '⟬postal_address#2⟭', 'es');
⟬end⟭

⟬template⟭
family: code
format: .py
language: en
fill_locale: en_US
domain: insurance
appearance: dict literal, comment
scenario: fixtures of a travel insurance trip-cancellation claim test, with one traveler and their passport
⟬text⟭
# fixtures for the trip-cancellation claim tests
TRAVELER = {
    "name": "⟬person_name#1⟭",
    "email": "⟬email#1⟭",
    "passport": "⟬us_passport#1⟭",
    "policy": "⟬customer_id#1⟭",
}
CLAIM = {"reason": "illness", "trip_start": "⟬date#1⟭", "nonrefundable_usd": 2840.00, "traveler": TRAVELER}
⟬end⟭

⟬template⟭
family: code
format: .sql
language: en
fill_locale: en_US
domain: SaaS
appearance: comment, DDL
scenario: database platform engineer's migration adding the index a slow tenant search needed, built concurrently
⟬text⟭
-- add the index the slow tenant search needs; CONCURRENTLY so writes keep going.
-- ⟬trap:indicator_non_pii|owner: db-platform⟭, ping ⟬trap:email_lookalike|@db-oncall⟭ in Slack before running it in prod
CREATE INDEX CONCURRENTLY IF NOT EXISTS ix_users_tenant_lower_email
    ON app.users (tenant_id, lower(email));
ANALYZE app.users;
⟬end⟭

⟬template⟭
family: code
format: .py
language: en
fill_locale: en_US
domain: retail
appearance: enum, dataclass, tuple
scenario: apparel catalog module defining fits, colorways and SKU codes
⟬text⟭
from dataclasses import dataclass
from enum import Enum


class Fit(str, Enum):
    slim = "slim"
    regular = "regular"
    relaxed = "relaxed"


# spring colorways, from the design palette
COLORWAYS = ("⟬trap:word_name|Sage⟭", "⟬trap:word_name|Ivy⟭", "⟬trap:word_name|Olive⟭", "Charcoal", "Sand")


@dataclass(frozen=True)
class Sku:
    style: str
    color: str
    size: str
    fit: Fit = Fit.regular

    def code(self) -> str:
        return f"{self.style}-{self.color[:3].upper()}-{self.size}-{self.fit.value[0].upper()}"
⟬end⟭

⟬template⟭
family: code
format: .sh
language: en
fill_locale: en_US
domain: fintech
appearance: command-line argument, environment variable, comment
scenario: crontab file of a reconciliation box running the nightly ledger versus bank reconciliation and its follow-up count
⟬text⟭
# /etc/cron.d/recon: nightly ledger vs bank reconciliation, then a count of breaks for the morning report
30 3 * * * recon cd /srv/recon && ./.venv/bin/python -m recon.run --date "$(date -d yesterday +\%F)" --alert-channel ⟬trap:indicator_non_pii|"#recon-alerts"⟭ >> /var/log/recon.log 2>&1
45 3 * * * recon ⟬trap:placeholder|PGPASSWORD="$(cat /run/secrets/recon_db)"⟭ psql -h ⟬hostname#1⟭ -U recon -c "SELECT count(*) FROM recon.breaks WHERE run_date = current_date - 1"
⟬end⟭

⟬template⟭
family: code
format: .ipynb
language: en
fill_locale: en_US
domain: government
appearance: notebook output, keyword argument, markdown cell
scenario: city equity analyst computing income segregation by county from Census ACS tract estimates, with the API key read from the environment
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Income segregation by county: ⟬trap:eponym|Theil⟭ index\n",
    "ACS 5-year tract estimates, household income brackets (table B19001)."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "(1412, 20)"
      ]
     },
     "execution_count": 1,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "import os\n",
    "\n",
    "import numpy as np\n",
    "import ⟬trap:library|pandas⟭ as pd\n",
    "import requests\n",
    "\n",
    "KEY = ⟬trap:placeholder|os.environ[\"CENSUS_API_KEY\"]⟭\n",
    "cols = \",\".join(f\"B19001_{i:03d}E\" for i in range(1, 18))\n",
    "url = \"https://api.census.gov/data/2022/acs/acs5\"\n",
    "rows = requests.get(url, params={\"get\": cols, \"for\": \"tract:*\", \"in\": \"state:48\", \"key\": KEY}, timeout=60).json()\n",
    "tracts = pd.DataFrame(rows[1:], columns=rows[0])\n",
    "tracts.shape"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "county\n",
       "453    0.112\n",
       "201    0.104\n",
       "113    0.097\n",
       "dtype: float64"
      ]
     },
     "execution_count": 2,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "def theil(group):\n",
    "    counts = group.filter(like=\"B19001_0\").drop(columns=\"B19001_001E\").astype(int)\n",
    "    p_county = counts.sum() / counts.values.sum()\n",
    "    p_tract = counts.div(counts.sum(axis=1), axis=0).fillna(0)\n",
    "    w = counts.sum(axis=1) / counts.values.sum()\n",
    "    ent = lambda p: -(p[p > 0] * np.log(p[p > 0])).sum()\n",
    "    return 1 - (w * p_tract.apply(ent, axis=1)).sum() / ent(p_county)\n",
    "\n",
    "tracts.groupby(\"county\").apply(theil).sort_values(ascending=False).head(3).round(3)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Same top three counties as the 2017 run, with slightly higher values. Data pulled ⟬date#1⟭."
   ]
  }
 ],
 "metadata": {
  "kernelspec": {"display_name": "Python 3", "language": "python", "name": "python3"},
  "language_info": {"name": "python", "version": "3.12.3"}
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
⟬end⟭

⟬template⟭
family: code
format: .py
language: en
fill_locale: en_US
domain: healthcare
appearance: dict literal, comment, function
scenario: comorbidity scoring helper feeding the readmission model features
⟬text⟭
"""Comorbidity scoring for the readmission model features."""

# ⟬trap:eponym|Charlson⟭ weights (2011 update), keyed by ICD-10 category prefix
WEIGHTS = {
    "I50": 2,  # congestive heart failure
    "I70": 1,  # peripheral vascular disease
    "J44": 1,  # chronic pulmonary disease
    "N18": 1,  # renal disease
    "C78": 6,  # metastatic solid tumor
    "B20": 4,  # HIV/AIDS
}


def ⟬trap:code_identifier|charlson_index⟭(codes: list[str]) -> int:
    seen = {code[:3] for code in codes}
    return sum(weight for prefix, weight in WEIGHTS.items() if prefix in seen)
⟬end⟭
