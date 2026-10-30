⟬template⟭
family: code
format: .py
language: en
fill_locale: en_US
domain: fintech
appearance: bytes literal, HTTP header, traceback, comment
scenario: onboarding engineer's FastAPI webhook receiver for an identity-verification vendor, with a Sentry traceback pasted under the fix
⟬text⟭
"""Webhook receiver for the identity-verification vendor.

The vendor signs every call with HMAC-SHA256 over the raw body (header X-Signature).
"""
import hashlib
import hmac
import json
import logging

from fastapi import APIRouter, Header, HTTPException, Request

from onboarding.kyc import record_result

router = APIRouter()
log = logging.getLogger(__name__)

WEBHOOK_SECRET = b"⟬opaque_token#1⟭"


@router.post("/webhooks/idv")
async def idv_webhook(request: Request, x_signature: str = Header(...)):
    raw = await request.body()
    expected = hmac.new(WEBHOOK_SECRET, raw, hashlib.sha256).hexdigest()
    if not hmac.compare_digest(expected, x_signature):
        log.warning("idv webhook: bad signature from %s", request.client.host)
        raise HTTPException(status_code=401, detail="bad signature")
    event = json.loads(raw)
    record_result(event["applicant_id"], event["decision"], event.get("reasons", []))
    return {"ok": True}


# Sentry ⟬ticket_id#1⟭, ⟬date#1⟭; fixed by reading event["decision"] instead of event["result"].
#
# Traceback (most recent call last):
#   File "/app/onboarding/webhooks.py", line 29, in idv_webhook
#     record_result(event["applicant_id"], event["result"], event.get("reasons", []))
# KeyError: 'result'
#
# Local variables:
#   event = {'applicant_id': '⟬customer_id#2⟭', 'decision': 'manual_review',
#            'reasons': ['dob_mismatch', 'document_glare'],
#            'input': {'name': '⟬person_name#2⟭', 'dob': '⟬birth_date#2⟭', 'ssn': '⟬us_ssn#2⟭',
#                      'document': {'type': 'passport', 'number': '⟬us_passport#2⟭'}}}
#   x_signature = '⟬hash#1⟭'
⟬end⟭

⟬template⟭
family: code
format: .sql
language: en
fill_locale: en_US
domain: healthcare
appearance: SQL string, comment, function definition, SQL WHERE
scenario: care-management data engineer's Snowflake script wiring a Python UDF to the Anthropic API through a secret, then smoke-testing it on one discharge note
⟬text⟭
-- Note summarization UDF for the care-management warehouse (Snowflake).
-- Runs as CM_ENGINEER. The network rule only lets traffic out to the Anthropic API.
USE ROLE CM_ENGINEER;
USE SCHEMA CARE_MGMT.LLM;

CREATE OR REPLACE NETWORK RULE anthropic_api
  MODE = EGRESS TYPE = HOST_PORT VALUE_LIST = ('api.anthropic.com');

CREATE OR REPLACE SECRET anthropic_key
  TYPE = GENERIC_STRING
  SECRET_STRING = '⟬anthropic_api_key#1⟭';

CREATE OR REPLACE EXTERNAL ACCESS INTEGRATION anthropic_access
  ALLOWED_NETWORK_RULES = (anthropic_api)
  ALLOWED_AUTHENTICATION_SECRETS = (anthropic_key)
  ENABLED = TRUE;

CREATE OR REPLACE FUNCTION summarize_note(note STRING)
RETURNS STRING
LANGUAGE PYTHON
RUNTIME_VERSION = '3.11'
PACKAGES = ('anthropic')
HANDLER = 'run'
EXTERNAL_ACCESS_INTEGRATIONS = (anthropic_access)
SECRETS = ('key' = anthropic_key)
AS
$$
import _snowflake
import anthropic

client = anthropic.Anthropic(api_key=_snowflake.get_generic_secret_string("key"))

def run(note):
    msg = client.messages.create(model="claude-haiku-4-5", max_tokens=300,
        messages=[{"role": "user", "content": "Summarize for a care manager in 3 lines: " + note}])
    return msg.content[0].text
$$;

-- smoke test on one encounter (⟬person_name#2⟭, discharged ⟬date#1⟭)
SELECT encounter_id, summarize_note(note_text) AS summary
FROM CARE_MGMT.RAW.DISCHARGE_NOTES
WHERE encounter_id = '⟬order_number#2⟭';
⟬end⟭

⟬template⟭
family: code
format: .py
language: en
fill_locale: en_US
domain: government
appearance: docstring, fixed-width record, exception message, comment
scenario: county IT developer's parser for the state DMV registration renewal extract, with a sample record in the docstring and a known bad line in a trailing comment
⟬text⟭
"""Parser for the state DMV registration renewal extract (REGRENEW.DAT).

The state sends one fixed-width file per county every night. Layout v3, byte
offsets from the interface spec (1-based, inclusive):

    1-8      plate              left aligned, space padded
    9-10     plate type         PC passenger, CM commercial, MC motorcycle
    11-50    owner name         as printed on the title
    51-60    owner DL number
    61-69    owner SSN          9 digits, blank when the owner declined
    70-129   mailing street
    130-157  mailing city
    158-162  zip
    163-170  expiry             YYYYMMDD

Sample record from the file of ⟬date#1⟭:

    ⟬us_license_plate#1⟭ PC⟬person_name#1⟭    ⟬us_driver_license#1⟭⟬us_ssn#1⟭⟬postal_address:street#1⟭      ⟬city#1⟭      ⟬postcode#1⟭20250930
"""
from dataclasses import dataclass
from datetime import date, datetime
from typing import Iterator

FIELDS = {
    "plate": (0, 8),
    "plate_type": (8, 10),
    "owner_name": (10, 50),
    "dl_number": (50, 60),
    "ssn": (60, 69),
    "street": (69, 129),
    "city": (129, 157),
    "zip": (157, 162),
    "expiry": (162, 170),
}
PLATE_TYPES = {"PC": "passenger", "CM": "commercial", "MC": "motorcycle"}
RECORD_LENGTH = 170


@dataclass(frozen=True)
class Renewal:
    plate: str
    plate_type: str
    owner_name: str
    dl_number: str
    ssn: str | None
    street: str
    city: str
    zip: str
    expiry: date


class LayoutError(ValueError):
    pass


def parse_line(line: str, lineno: int) -> Renewal:
    body = line.rstrip("\r\n")
    if len(body) != RECORD_LENGTH:
        raise LayoutError(f"line {lineno}: expected {RECORD_LENGTH} bytes, got {len(body)}")
    raw = {name: body[start:end].strip() for name, (start, end) in FIELDS.items()}
    if raw["plate_type"] not in PLATE_TYPES:
        raise LayoutError(f"line {lineno}: unknown plate type {raw['plate_type']!r}")
    return Renewal(
        plate=raw["plate"],
        plate_type=PLATE_TYPES[raw["plate_type"]],
        owner_name=raw["owner_name"],
        dl_number=raw["dl_number"],
        ssn=raw["ssn"] or None,
        street=raw["street"],
        city=raw["city"],
        zip=raw["zip"],
        expiry=datetime.strptime(raw["expiry"], "%Y%m%d").date(),
    )


def read_extract(path: str) -> Iterator[Renewal]:
    with open(path, encoding="latin-1") as fh:
        for lineno, line in enumerate(fh, 1):
            if line.startswith(("HDR", "TRL")):
                continue
            yield parse_line(line, lineno)


if __name__ == "__main__":
    import sys

    failures = 0
    for path in sys.argv[1:]:
        try:
            for renewal in read_extract(path):
                print(renewal.plate, renewal.expiry.isoformat())
        except LayoutError as err:
            failures += 1
            print(f"{path}: {err}", file=sys.stderr)
    sys.exit(1 if failures else 0)

# Known bad record, ⟬ticket_id#1⟭ (owner name overflowed into the DL column):
#   LayoutError: line 4412: expected 170 bytes, got 174
#   ⟬us_license_plate#2⟭ CM⟬person_name#2⟭⟬us_driver_license#2⟭ ...
⟬end⟭

⟬template⟭
family: code
format: .ipynb
language: en
fill_locale: en_US
domain: retail
appearance: notebook output, keyword argument, markdown cell, free text
scenario: e-commerce analyst's notebook embedding jewelry reviews with OpenAI and clustering them, with a sample of reviews printed with reviewer names
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Review clustering, jewelry category\n",
    "Embed the last 90 days of product reviews and cluster them, to see what people complain about besides sizing."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "metadata": {},
   "outputs": [],
   "source": [
    "import os\n",
    "import numpy as np\n",
    "import ⟬trap:library|pandas⟭ as pd\n",
    "from openai import OpenAI\n",
    "from sklearn.cluster import KMeans\n",
    "\n",
    "client = OpenAI(api_key=os.getenv(\"OPENAI_API_KEY\", \"⟬openai_api_key#1⟭\"))"
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
       "             sku           reviewer  rating                                               text\n",
       "812   JW-4471-RG  ⟬person_name#2⟭       2  ⟬trap:word_name|Rose⟭ gold plating wore off after three weeks, ...\n",
       "77    JW-1180-OL  ⟬person_name:initial#3⟭       5  The ⟬trap:word_name|Olive⟭ enamel is gorgeous, bought a second o...\n",
       "1450  JW-2093-SV  ⟬username#1⟭       3  Chain kinked in the box. Support (⟬email:generic#4⟭) sent a ...\n",
       "309   JW-4471-RG  ⟬person_name#5⟭       4  Got it for my daughter ⟬person_name:given#6f⟭, she wears it every..."
      ]
     },
     "execution_count": 2,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "reviews = pd.read_csv(\"⟬file_path#1⟭\")\n",
    "reviews.sample(4, random_state=7)[[\"sku\", \"reviewer\", \"rating\", \"text\"]]"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 3,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "cluster\n",
       "0    412\n",
       "1    388\n",
       "2    297\n",
       "3    241\n",
       "4    150\n",
       "5     96\n",
       "dtype: int64"
      ]
     },
     "execution_count": 3,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "texts = reviews[\"text\"].fillna(\"\").tolist()\n",
    "vectors = []\n",
    "for i in range(0, len(texts), 256):\n",
    "    batch = client.embeddings.create(model=\"text-embedding-3-small\", input=texts[i:i + 256])\n",
    "    vectors += [d.embedding for d in batch.data]\n",
    "reviews[\"cluster\"] = KMeans(n_clusters=6, n_init=10, random_state=0).fit_predict(np.array(vectors))\n",
    "reviews[\"cluster\"].value_counts()"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Cluster 3 is tarnish and plating, mostly ⟬trap:word_name|Rose⟭ gold SKUs. Cluster 5 is gift wrapping. Share both with merch before the holiday reorder."
   ]
  }
 ],
 "metadata": {
  "kernelspec": {"display_name": "Python 3", "language": "python", "name": "python3"},
  "language_info": {"name": "python", "version": "3.12.2"}
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
⟬end⟭

⟬template⟭
family: code
format: .sh
language: en
fill_locale: en_US
domain: fintech
appearance: curl command, HTTP header, heredoc, JSON body
scenario: QA engineer's smoke test for a remittance transfers API on staging, with a bearer token pasted in and a sender who files with an ITIN
⟬text⟭
#!/usr/bin/env bash
# Smoke test for the transfers API on staging.
# The token below expires after 24h; get a new one from /auth/token if you see a 401.
set -euo pipefail

API=https://⟬hostname#1⟭/v2
TOKEN="⟬jwt#1⟭"

# 1. sender without an SSN: ITIN as tax id, state driver license as ID document
SENDER_ID=$(curl -sS -X POST "$API/senders" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d @- <<'JSON' | jq -r .id
{
  "full_name": "⟬person_name#2⟭",
  "tax_id": {"type": "itin", "value": "⟬us_itin#2⟭"},
  "id_document": {"type": "drivers_license", "number": "⟬us_driver_license#2⟭"},
  "address": "⟬postal_address#2⟭",
  "phone": "⟬phone#2⟭"
}
JSON
)
echo "sender: $SENDER_ID"

# 2. transfer to the recipient's checking account
curl -sS -X POST "$API/transfers" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Idempotency-Key: $(uuidgen)" \
  -H "Content-Type: application/json" \
  -d "{\"sender_id\": \"$SENDER_ID\", \"amount\": \"250.00\", \"currency\": \"USD\",
       \"recipient\": {\"name\": \"⟬person_name#3⟭\", \"account_number\": \"⟬bank_account_number#3⟭\", \"routing_number\": \"110000000\"}}" | jq .

# 3. status of the last five transfers
curl -sS "$API/transfers?sender_id=$SENDER_ID&limit=5" -H "Authorization: Bearer $TOKEN" | jq '.items[] | {id, status}'
⟬end⟭

⟬template⟭
family: code
format: .py
language: en
fill_locale: en_US
domain: insurance
appearance: docstring, doctest, f-string, comment
scenario: Django model for a travel insurance product, where the docstring shows a policy object printed from the shell
⟬text⟭
from django.core.validators import RegexValidator
from django.db import models

from encrypted_fields.fields import EncryptedCharField

passport_validator = RegexValidator(r"^[A-Z0-9]{6,9}$", "Passport numbers are 6 to 9 letters or digits.")


class TravelPolicy(models.Model):
    """One trip, one traveler. Group trips get one row per traveler.

    >>> TravelPolicy.objects.select_related("trip").get(pk=4410)
    <TravelPolicy: ⟬customer_id#1⟭ ⟬person_name#1⟭ (⟬us_passport#1⟭) Lisbon ⟬date#2⟭>
    """

    policy_number = models.CharField(max_length=20, unique=True)
    traveler_name = models.CharField(max_length=200)
    traveler_dob = models.DateField()
    traveler_email = models.EmailField()
    passport_number = EncryptedCharField(max_length=9, validators=[passport_validator])
    trip = models.ForeignKey("trips.Trip", on_delete=models.PROTECT, related_name="policies")
    issued_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        indexes = [models.Index(fields=["traveler_name", "traveler_dob"])]

    # TODO: drop the passport from __str__, it ends up in the admin log entries
    # (spotted by ⟬person_name#3⟭ on ⟬date#1⟭)
    def __str__(self):
        return f"{self.policy_number} {self.traveler_name} ({self.passport_number}) {self.trip.destination} {self.trip.departs:%Y-%m-%d}"
⟬end⟭

⟬template⟭
family: code
format: .sql
language: en
fill_locale: en_US
domain: fintech
appearance: SQL UPDATE, SQL WHERE, comment, subquery
scenario: tax operations analyst's 1099-INT extract for a bank, followed by two fixes made after IRS TIN mismatch notices
⟬text⟭
-- 1099-INT extract, tax year 2024. Run after the Dec 31 interest accrual closes.
-- Recipients under $10 of interest are left out (IRS threshold).
SELECT a.account_number,
       c.legal_name,
       c.tin_type,
       c.tin,
       c.mailing_street, c.mailing_city, c.mailing_state, c.mailing_zip,
       sum(i.amount)::numeric(12, 2) AS box1_interest
FROM deposits.interest_postings i
JOIN deposits.accounts a ON a.account_id = i.account_id
JOIN core.customers c ON c.customer_id = a.primary_customer_id
WHERE i.posted_on BETWEEN DATE '2024-01-01' AND DATE '2024-12-31'
  AND c.tin_type IN ('SSN', 'ITIN')
GROUP BY 1, 2, 3, 4, 5, 6, 7, 8
HAVING sum(i.amount) >= 10;

-- Fixes before the corrected filing (CP2100 notice, two recipients).
-- 1) ITIN keyed with two digits swapped at account opening
UPDATE core.customers
SET tin = '⟬us_itin#1⟭', tin_type = 'ITIN', ⟬trap:indicator_non_pii|updated_by = 'tax-ops'⟭
WHERE customer_id = (SELECT primary_customer_id FROM deposits.accounts WHERE account_number = '⟬bank_account_number#1⟭');

-- 2) recipient moved and the notice came back undeliverable; new address from the B-notice reply
UPDATE core.customers
SET mailing_street = '⟬postal_address:street#2⟭', mailing_city = '⟬city#2⟭', mailing_zip = '⟬postcode#2⟭'
WHERE legal_name = '⟬person_name#2⟭' AND tin = '⟬us_ssn#2⟭';
⟬end⟭

⟬template⟭
family: code
format: .ipynb
language: en
fill_locale: en_US
domain: government
appearance: notebook output, function call, markdown cell, free text
scenario: records office data scientist fine-tuning a FOIA redaction tagger on hand-redacted letters and pushing it to a private Hugging Face repo
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# FOIA redaction tagger: fine-tune, run 3\n",
    "\n",
    "Token classifier for the release-review queue. Labels: PERSON, SSN, ITIN, PASSPORT, ADDRESS, PHONE.\n",
    "Training data: the 1,900 hand-redacted letters from past releases (internal only, never pushed public)."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "metadata": {},
   "outputs": [],
   "source": [
    "from huggingface_hub import login\n",
    "login(\"⟬huggingface_token#1⟭\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "DatasetDict({\n",
      "    train: Dataset({features: ['text', 'spans'], num_rows: 1520})\n",
      "    validation: Dataset({features: ['text', 'spans'], num_rows: 380})\n",
      "})\n",
      "Dear ⟬person_name#2⟭: This responds to your request of ⟬date#3⟭ concerning passport ⟬us_passport#2⟭. Our records show the passport was reported lost on ⟬date#4⟭ and cancelled. Further correspondence will be sent to ⟬postal_address#2⟭.\n"
     ]
    }
   ],
   "source": [
    "from datasets import load_from_disk\n",
    "\n",
    "ds = load_from_disk(\"⟬file_path#1⟭\")\n",
    "print(ds)\n",
    "print(ds[\"train\"][17][\"text\"])"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 3,
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Epoch  Training Loss  Validation Loss  Precision  Recall     F1\n",
      "    1         0.4120           0.2213      0.842   0.881  0.861\n",
      "    2         0.1734           0.1502      0.889   0.902  0.895\n",
      "    3         0.1051           0.1477      0.901   0.907  0.904\n"
     ]
    }
   ],
   "source": [
    "from transformers import AutoModelForTokenClassification, Trainer, TrainingArguments\n",
    "\n",
    "model = AutoModelForTokenClassification.from_pretrained(\"bert-base-cased\", num_labels=len(LABELS) * 2 + 1)\n",
    "args = TrainingArguments(\n",
    "    output_dir=\"runs/redaction-tagger-3\",\n",
    "    num_train_epochs=3,\n",
    "    learning_rate=3e-5,\n",
    "    per_device_train_batch_size=16,\n",
    "    eval_strategy=\"epoch\",\n",
    "    push_to_hub=True,\n",
    "    hub_model_id=\"records-office/redaction-tagger\",\n",
    "    hub_private_repo=True,\n",
    ")\n",
    "trainer = Trainer(model=model, args=args, train_dataset=tok[\"train\"], eval_dataset=tok[\"validation\"], compute_metrics=span_f1)\n",
    "trainer.train()"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 4,
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Re: ⟬person_name#3⟭, ITIN ⟬us_itin#3⟭. The IRS letter dated ⟬date#2⟭ is withheld in full under exemption (b)(3).\n",
      "[('⟬person_name#3⟭', 'PERSON', 0.99), ('⟬us_itin#3⟭', 'SSN', 0.71), ('IRS', 'O', 0.97)]\n"
     ]
    }
   ],
   "source": [
    "sample = ds[\"validation\"][3][\"text\"]\n",
    "print(sample)\n",
    "print(predict(trainer.model, sample))"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "ITIN still comes out as SSN (same 3-2-4 shape). Either add the 9xx prefix rule as a post-filter or relabel the 40 ITIN letters with a second pass. Run 4 after ⟬date#1⟭."
   ]
  }
 ],
 "metadata": {
  "kernelspec": {"display_name": "Python 3", "language": "python", "name": "python3"},
  "language_info": {"name": "python", "version": "3.11.8"}
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
⟬end⟭

⟬template⟭
family: code
format: .sh
language: en
fill_locale: en_US
domain: SaaS
appearance: heredoc, URL, environment variable, comment
scenario: EC2 user-data script for a shared ML sandbox that writes cloud, Hugging Face, OpenAI and GitHub credentials for the ml user at first boot
⟬text⟭
#!/bin/bash
# EC2 user-data for the shared ML sandbox. Runs once as root at first boot.
# Yes, the keys are in here: this box lives in the sandbox account only. ⟬ticket_id#1⟭ moves them to SSM.
set -ex

apt-get update -y && apt-get install -y git python3-venv awscli jq
id ml >/dev/null 2>&1 || useradd -m -s /bin/bash ml

mkdir -p /home/ml/.aws /home/ml/.cache/huggingface
cat > /home/ml/.aws/credentials <<EOF
[default]
aws_access_key_id = ⟬aws_access_key_id#1⟭
aws_secret_access_key = ⟬aws_secret_access_key#1⟭
region = us-west-2
EOF
echo -n "⟬huggingface_token#1⟭" > /home/ml/.cache/huggingface/token
echo 'export OPENAI_API_KEY="⟬openai_api_key#1⟭"' >> /home/ml/.bashrc
chown -R ml:ml /home/ml

sudo -u ml git clone "https://x-access-token:⟬github_token#1⟭@github.com/⟬username#1⟭/ml-sandbox.git" /home/ml/ml-sandbox
sudo -u ml bash -c 'cd ~/ml-sandbox && python3 -m venv .venv && .venv/bin/pip install -q -r requirements.txt'
⟬end⟭

⟬template⟭
family: code
format: .py
language: en
fill_locale: en_US
domain: SaaS
appearance: assignment, docstring, triple-quoted string, comment, nested JSON
scenario: growth engineer's Prefect flow syncing CRM contacts into the warehouse and posting an LLM-written digest to Slack, with tokens as module constants
⟬text⟭
"""Prefect flow: sync CRM contacts into the warehouse and post a digest to Slack.

Runs hourly. The CRM API is paged (100 contacts per page); a failed run starts
over from the first page, the upsert makes that harmless.

Reviewed by ⟬trap:initials|JK⟭ and ⟬trap:initials|M.P.⟭ before the move off cron.
"""
import os
from datetime import datetime, timezone

import httpx
import psycopg
from openai import OpenAI
from prefect import flow, get_run_logger, task
from slack_sdk import WebClient

CRM_BASE = "⟬url#1⟭"
CRM_TOKEN = os.environ.get("CRM_TOKEN", "⟬opaque_token#1⟭")
SLACK_BOT_TOKEN = "⟬slack_token#1⟭"
SLACK_CHANNEL = "#crm-sync"
OPENAI_KEY = "⟬openai_api_key#1⟭"
DSN = "postgresql://sync:⟬url_password#1⟭@⟬hostname#1⟭:5432/warehouse"

FIELDS = ["firstname", "lastname", "email", "phone", "company", "jobtitle", "lifecyclestage", "lastmodifieddate"]


@task(retries=3, retry_delay_seconds=30)
def fetch_page(after: str | None) -> dict:
    params = {"limit": 100, "properties": ",".join(FIELDS)}
    if after:
        params["after"] = after
    resp = httpx.get(
        f"{CRM_BASE}/objects/contacts",
        params=params,
        headers={"Authorization": f"Bearer {CRM_TOKEN}"},
        timeout=30,
    )
    resp.raise_for_status()
    return resp.json()


def to_row(contact: dict) -> tuple:
    p = contact["properties"]
    return (
        contact["id"],
        (p.get("firstname") or "").strip(),
        (p.get("lastname") or "").strip(),
        (p.get("email") or "").lower(),
        p.get("phone"),
        p.get("company"),
        p.get("jobtitle"),
        p.get("lifecyclestage"),
        p.get("lastmodifieddate"),
    )


@task
def upsert(rows: list[tuple]) -> int:
    with psycopg.connect(DSN) as conn, conn.cursor() as cur:
        cur.executemany(
            """
            INSERT INTO crm.contacts (crm_id, first_name, last_name, email, phone, company, job_title, stage, modified_at)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
            ON CONFLICT (crm_id) DO UPDATE SET
                first_name = EXCLUDED.first_name, last_name = EXCLUDED.last_name,
                email = EXCLUDED.email, phone = EXCLUDED.phone, company = EXCLUDED.company,
                job_title = EXCLUDED.job_title, stage = EXCLUDED.stage, modified_at = EXCLUDED.modified_at
            """,
            rows,
        )
    return len(rows)


@task
def digest(new_customers: list[tuple]) -> str:
    if not new_customers:
        return "No new customers this hour."
    lines = "\n".join(f"- {r[1]} {r[2]} ({r[5]}, {r[6]})" for r in new_customers)
    resp = OpenAI(api_key=OPENAI_KEY).chat.completions.create(
        model="gpt-4o-mini",
        messages=[{"role": "user", "content": f"Write a two-sentence upbeat Slack digest of these new customers:\n{lines}"}],
    )
    return resp.choices[0].message.content


@flow(name="crm-contacts-sync")
def sync_contacts():
    log = get_run_logger()
    after, total, new_customers = None, 0, []
    while True:
        page = fetch_page(after)
        rows = [to_row(c) for c in page["results"]]
        total += upsert(rows)
        new_customers += [r for r in rows if r[7] == "customer"]
        after = page.get("paging", {}).get("next", {}).get("after")
        if not after:
            break
    log.info("synced %d contacts at %s", total, datetime.now(timezone.utc).isoformat())
    WebClient(token=SLACK_BOT_TOKEN).chat_postMessage(channel=SLACK_CHANNEL, text=digest(new_customers))


# One contact as the CRM returns it (copied from a debug run):
# {"id": "⟬customer_id#2⟭", "properties": {"firstname": "⟬person_name:given#2⟭", "lastname": "⟬person_name:family#2⟭",
#  "email": "⟬email#2⟭", "phone": "⟬phone#2⟭", "company": "⟬company#2⟭", "jobtitle": "⟬job_title#2⟭",
#  "lifecyclestage": "customer", "lastmodifieddate": "⟬date#1⟭"}}

if __name__ == "__main__":
    sync_contacts()
⟬end⟭

⟬template⟭
family: code
format: .py
language: en
fill_locale: en_US
domain: insurance
appearance: keyword argument, comment, f-string
scenario: desk adjuster's throwaway script to download one claim's photos from S3, with read-only keys inline and the default claim noted in a comment
⟬text⟭
# pull_claim_photos.py <claim_id>: download one claim's photos so the desk adjuster
# can look at them offline. Quick script; these are the read-only keys.
import sys
from pathlib import Path

import boto3

s3 = boto3.client(
    "s3",
    aws_access_key_id="⟬aws_access_key_id#1⟭",
    aws_secret_access_key="⟬aws_secret_access_key#1⟭",
    region_name="us-east-1",
)

# default: the hail claim on ⟬us_license_plate#1⟭, towed to ⟬trap:company_name|⦃Family⦄ Collision Center⟭
claim_id = sys.argv[1] if len(sys.argv) > 1 else "⟬order_number#1⟭"
out = Path("photos") / claim_id
out.mkdir(parents=True, exist_ok=True)
for obj in s3.list_objects_v2(Bucket="claims-photos-prod", Prefix=f"{claim_id}/").get("Contents", []):
    s3.download_file("claims-photos-prod", obj["Key"], str(out / Path(obj["Key"]).name))
    print("got", obj["Key"])
⟬end⟭

⟬template⟭
family: code
format: .sql
language: en
fill_locale: en_US
domain: government
appearance: comment, SQL DELETE, SQL WHERE
scenario: city revenue analyst's query building the parking citation hand-off for the collections vendor, with two disputed plates pulled out by hand
⟬text⟭
-- Unpaid parking citations older than 60 days, grouped by plate, for the
-- collections vendor hand-off. Owner and address come from the state registry match.
SELECT c.plate,
       c.plate_state,
       r.owner_name,
       r.owner_address,
       count(*)               AS citations,
       sum(c.fine_amount)     AS total_due,
       min(c.issued_at)::date AS oldest
FROM parking.citations c
JOIN parking.registry_match r ON r.plate = c.plate AND r.plate_state = c.plate_state
WHERE c.status = 'unpaid'
  AND c.issued_at < current_date - 60
GROUP BY 1, 2, 3, 4
HAVING sum(c.fine_amount) >= 100
ORDER BY total_due DESC;

-- hearing officer asked to keep these two out of the hand-off (disputes pending):
--   ⟬us_license_plate#1⟭  ⟬person_name#1⟭, ⟬postal_address#1⟭
--   ⟬us_license_plate#2⟭  ⟬person_name#2⟭, ⟬postal_address#2⟭
DELETE FROM parking.collections_queue
WHERE plate IN ('⟬us_license_plate#1⟭', '⟬us_license_plate#2⟭');
⟬end⟭

⟬template⟭
family: code
format: .py
language: en
fill_locale: en_US
domain: healthcare
appearance: f-string, keyword argument, docstring, comment
scenario: revenue-cycle developer's FastAPI service drafting appeal letters for denied claims with Claude, with the context of the pilot claim pasted from a debug log
⟬text⟭
"""Draft appeal letters for denied claims.

A biller picks a denial in the work queue; this service pulls the claim, asks the
model for a first draft citing the payer's own policy text, and stores the draft
for review. Nothing is sent to the payer from here.
"""
from datetime import date

from anthropic import AsyncAnthropic
from fastapi import APIRouter, Depends
from pydantic import BaseModel

from rcm.db import get_claim, save_draft
from rcm.policies import policy_excerpt

router = APIRouter(prefix="/appeals")
claude = AsyncAnthropic(api_key="⟬anthropic_api_key#1⟭")

SYSTEM = (
    "You draft insurance appeal letters for a hospital billing office. "
    "Formal tone, one page, quote the payer policy excerpt where it helps. "
    "Never invent clinical facts."
)


class DraftRequest(BaseModel):
    claim_id: str
    denial_code: str
    biller_note: str = ""


def letter_context(claim, excerpt: str, note: str) -> str:
    return (
        f"Patient: {claim.patient_name}, DOB {claim.patient_dob:%m/%d/%Y}\n"
        f"Patient address: {claim.patient_address}\n"
        f"Payer: {claim.payer_name}, member ID {claim.member_id}\n"
        f"Date of service: {claim.dos:%m/%d/%Y}, CPT {', '.join(claim.cpt_codes)}\n"
        f"Denial: {claim.denial_code} {claim.denial_reason}\n"
        f"Policy excerpt:\n{excerpt}\n"
        f"Biller note: {note}\n"
    )


@router.post("/drafts")
async def create_draft(req: DraftRequest, claim=Depends(get_claim)):
    excerpt = await policy_excerpt(claim.payer_id, req.denial_code)
    msg = await claude.messages.create(
        model="claude-sonnet-4-5",
        max_tokens=1500,
        system=SYSTEM,
        messages=[{"role": "user", "content": letter_context(claim, excerpt, req.biller_note)}],
    )
    draft_id = await save_draft(claim.id, msg.content[0].text, created=date.today())
    return {"draft_id": draft_id}


# Context sent for the pilot claim (from the debug log of ⟬date#1⟭):
#
#   Patient: ⟬person_name#2⟭, DOB ⟬birth_date#2⟭
#   Patient address: ⟬postal_address#2⟭
#   Payer: ⟬company#3⟭, member ID ⟬customer_id#2⟭
#   Date of service: ⟬date#2⟭, CPT 72148
#   Denial: CO-50 not deemed a medical necessity
#   Biller note: MRI ordered after 6 weeks of failed PT, see ortho note from Dr. ⟬person_name:family#4⟭
⟬end⟭

⟬template⟭
family: code
format: .ipynb
language: en
fill_locale: en_US
domain: fintech
appearance: notebook output, keyword argument, markdown cell, free text
scenario: data scientist at a neobank testing Claude on merchant descriptor categorization, with raw ledger rows printed from the sandbox
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "## Merchant descriptor categorization with Claude\n",
    "Card and ACH descriptors from the sandbox ledger. Goal: beat the rules engine on the long tail."
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
       "      account_number      posted   amount  descriptor\n",
       "0  ⟬bank_account_number#2⟭  ⟬date#1⟭   -42.17  SQ *⟬company#5⟭ OAKLAND\n",
       "1  ⟬bank_account_number#2⟭  ⟬date#1⟭  -120.00  VENMO *⟬person_name#3⟭\n",
       "2  ⟬bank_account_number#2⟭  ⟬date#2⟭   -15.99  ⟬company#6⟭ ⟬phone#6⟭ CA\n",
       "3  ⟬bank_account_number#4⟭  ⟬date#2⟭  1840.22  PAYROLL ⟬company#7⟭ DIRECT DEP\n",
       "4  ⟬bank_account_number#4⟭  ⟬date#3⟭   -60.00  ZELLE TO ⟬person_name:family#8⟭ ⟬person_name:given#8⟭\n",
       "5  ⟬bank_account_number#4⟭  ⟬date#3⟭    -9.50  ⟬trap:company_name|⦃FAMILY⦄ HARDWARE⟭ #112"
      ]
     },
     "execution_count": 1,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "import anthropic\n",
    "import ⟬trap:library|pandas⟭ as pd\n",
    "\n",
    "client = anthropic.Anthropic(api_key=\"⟬anthropic_api_key#1⟭\")\n",
    "tx = pd.read_parquet(\"⟬file_path#1⟭\")\n",
    "tx.head(6)"
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
       "'in_progress'"
      ]
     },
     "execution_count": 2,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "CATEGORIES = [\"groceries\", \"dining\", \"p2p_transfer\", \"subscriptions\", \"income\", \"home_improvement\", \"other\"]\n",
    "\n",
    "requests = [\n",
    "    {\n",
    "        \"custom_id\": f\"tx-{i}\",\n",
    "        \"params\": {\n",
    "            \"model\": \"claude-haiku-4-5\",\n",
    "            \"max_tokens\": 20,\n",
    "            \"system\": f\"Return one category from {CATEGORIES} for the card or ACH descriptor. Category only.\",\n",
    "            \"messages\": [{\"role\": \"user\", \"content\": d}],\n",
    "        },\n",
    "    }\n",
    "    for i, d in enumerate(tx[\"descriptor\"])\n",
    "]\n",
    "batch = client.messages.batches.create(requests=requests)\n",
    "batch.processing_status"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Venmo and Zelle rows come back as `p2p_transfer`, but when asked for a rationale the model repeats the counterparty name. Keep the category-only prompt and never store rationales."
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
format: .sh
language: en
fill_locale: en_US
domain: government
appearance: command-line argument, environment variable, comment
scenario: agency ML engineer's script mirroring approved Hugging Face models into a GovCloud bucket the enclave can read
⟬text⟭
#!/usr/bin/env bash
# mirror_models.sh: copy approved Hugging Face models into the GovCloud bucket the
# enclave reads from. Approved list: models.txt, one repo id per line, signed off by the ISSO.
set -euo pipefail

huggingface-cli login --token ⟬huggingface_token#1⟭
export AWS_ACCESS_KEY_ID=⟬aws_access_key_id#1⟭ AWS_SECRET_ACCESS_KEY=⟬aws_secret_access_key#1⟭ AWS_REGION=us-gov-west-1

while read -r repo; do
  [[ -z "$repo" || "$repo" == \#* ]] && continue
  dir="mirror/${repo//\//__}"
  huggingface-cli download "$repo" --local-dir "$dir" --exclude "*.msgpack" "*.h5"
  aws s3 sync "$dir" "s3://enclave-model-mirror/${repo}/" --sse aws:kms --only-show-errors
  echo "$(date -Is) mirrored $repo" | tee -a mirror.log
done < models.txt
⟬end⟭

⟬template⟭
family: code
format: .py
language: en
fill_locale: en_US
domain: healthcare
appearance: docstring, assignment, keyword argument, comment
scenario: integration developer's helper module for a payer FHIR endpoint, with an NPI check digit and Bundle paging, holding no patient data
⟬text⟭
"""Small helpers for talking to the payer's FHIR R4 endpoint.

- npi_is_valid: check digit of a National Provider Identifier
  (⟬trap:eponym|Luhn⟭ over the 80840 prefix and the first nine digits)
- iter_bundle: follow the `next` links of a searchset Bundle
"""
from typing import Iterator

import requests

FHIR_BASE = "⟬url#1⟭"
⟬trap:indicator_non_pii|PATIENT_IDENTIFIER_SYSTEM = "http://hl7.org/fhir/sid/us-mbi"⟭
TIMEOUT = 20


def npi_is_valid(npi: str) -> bool:
    if len(npi) != 10 or not npi.isdigit():
        return False
    digits = [int(d) for d in "80840" + npi[:9]]
    total = 0
    for i, d in enumerate(reversed(digits)):
        if i % 2 == 0:
            d *= 2
            if d > 9:
                d -= 9
        total += d
    return (10 - total % 10) % 10 == int(npi[9])


def iter_bundle(session: requests.Session, url: str, params: dict | None = None) -> Iterator[dict]:
    while url:
        resp = session.get(url, params=params, timeout=TIMEOUT, headers={"Accept": "application/fhir+json"})
        resp.raise_for_status()
        bundle = resp.json()
        for entry in bundle.get("entry", []):
            yield entry["resource"]
        url = next((link["url"] for link in bundle.get("link", []) if link["relation"] == "next"), None)
        params = None  # the next link already carries the query
⟬end⟭

⟬template⟭
family: code
format: .sql
language: en
fill_locale: en_US
domain: SaaS
appearance: comment, SQL DELETE, SQL UPDATE, subquery
scenario: SRE's rerunnable cleanup of the tenants and users that load tests create in staging
⟬text⟭
-- cleanup_loadtest_tenants.sql
-- Removes the tenants and users the k6 load tests create in staging. Safe to rerun.
-- Load-test users all sit on the reserved .invalid domain, so real signups never match.
BEGIN;

CREATE TEMP TABLE doomed ON COMMIT DROP AS
SELECT t.tenant_id
FROM app.tenants t
WHERE t.slug LIKE 'lt-%'
  AND t.created_at < now() - interval '1 day'
  AND NOT EXISTS (
      SELECT 1 FROM billing.subscriptions s
      WHERE s.tenant_id = t.tenant_id AND s.status = 'active'
  );

DELETE FROM app.api_keys    WHERE tenant_id IN (SELECT tenant_id FROM doomed);
DELETE FROM app.memberships WHERE tenant_id IN (SELECT tenant_id FROM doomed);
DELETE FROM app.users u
WHERE u.email LIKE ⟬trap:email_lookalike|'%@loadtest.invalid'⟭
  AND NOT EXISTS (SELECT 1 FROM app.memberships m WHERE m.user_id = u.user_id);
DELETE FROM app.tenants WHERE tenant_id IN (SELECT tenant_id FROM doomed);

-- the shared load-test admin is locked, not deleted: k6 logs in with it on the next run
UPDATE app.users
SET ⟬trap:indicator_non_pii|password_hash = '!'⟭, locked_at = now()
WHERE ⟬trap:indicator_non_pii|username = 'loadtest-admin'⟭;

SELECT count(*) AS leftover_users
FROM app.users
WHERE email LIKE ⟬trap:email_lookalike|'%@loadtest.invalid'⟭ AND locked_at IS NULL;

COMMIT;
⟬end⟭

⟬template⟭
family: code
format: .ipynb
language: en
fill_locale: en_US
domain: government
appearance: notebook output, markdown cell, keyword argument
scenario: city performance analyst's survival analysis of building permit processing times from the open-data portal, with no applicant fields
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Building permit processing time\n",
    "\n",
    "Days from submission to issuance, as a ⟬trap:eponym|Kaplan-Meier⟭ curve (withdrawn or still open applications are censored). Open-data extract, no applicant fields."
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
       "(48213, 9)"
      ]
     },
     "execution_count": 1,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "import ⟬trap:library|pandas⟭ as pd\n",
    "from lifelines import ⟬trap:code_identifier|KaplanMeierFitter⟭\n",
    "\n",
    "permits = pd.read_csv(\"⟬url#1⟭\", parse_dates=[\"submitted\", \"issued\"])\n",
    "permits.shape"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "residential_new     median  74 days   p75 131\n",
      "residential_alter   median  33 days   p75  58\n",
      "commercial_new      median 118 days   p75 204\n",
      "commercial_alter    median  51 days   p75 163\n",
      "solar               median  12 days   p75  19\n"
     ]
    }
   ],
   "source": [
    "cutoff = pd.Timestamp(\"⟬date#1⟭\")\n",
    "permits[\"days\"] = (permits[\"issued\"].fillna(cutoff) - permits[\"submitted\"]).dt.days\n",
    "permits[\"done\"] = permits[\"issued\"].notna()\n",
    "\n",
    "for kind, grp in permits.groupby(\"permit_type\"):\n",
    "    kmf = ⟬trap:code_identifier|KaplanMeierFitter⟭().fit(grp[\"days\"], grp[\"done\"])\n",
    "    p75 = kmf.percentile(0.25)\n",
    "    print(f\"{kind:<19} median {kmf.median_survival_time_:>3.0f} days   p75 {p75:>3.0f}\")"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Solar fast-track works. Commercial alterations have a long tail: a quarter are still open after 160 days, most of them along the ⟬trap:word_name|MacArthur Blvd⟭ corridor (fire review backlog)."
   ]
  }
 ],
 "metadata": {
  "kernelspec": {"display_name": "Python 3", "language": "python", "name": "python3"},
  "language_info": {"name": "python", "version": "3.12.1"}
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
⟬end⟭

⟬template⟭
family: code
format: .sh
language: en
fill_locale: en_US
domain: retail
appearance: environment variable, command-line argument, comment, curl command
scenario: analytics engineer's nightly dbt wrapper on the retail analytics runner, reading every secret from files and the environment
⟬text⟭
#!/usr/bin/env bash
# nightly_dbt.sh: started at 04:30 by the dbt-nightly.timer systemd unit on the analytics runner.
# repo: ⟬trap:email_lookalike|git@github.com:retail-analytics/retail-dbt.git⟭
set -euo pipefail
cd /srv/analytics/retail-dbt
source .venv/bin/activate

export DBT_PROFILES_DIR=/srv/analytics/profiles
export ⟬trap:indicator_non_pii|DBT_USER=svc_dbt_nightly⟭
export ⟬trap:placeholder|DBT_PASSWORD="$(cat /run/secrets/dbt_password)"⟭

git fetch --quiet origin main && git reset --hard origin/main
dbt deps --quiet
status=0
dbt build --target prod --exclude tag:hourly --fail-fast || status=$?
dbt docs generate --target prod --no-compile
aws s3 sync target/ s3://retail-dbt-docs/ --delete --only-show-errors   # instance role, no keys on this box

if [[ "$status" -ne 0 ]]; then
  curl -fsS -X POST -H 'Content-Type: application/json' \
    -d "{\"text\": \"dbt nightly failed on $(hostname) at $(git rev-parse --short HEAD), version ⟬version#1⟭\"}" \
    ⟬trap:placeholder|"$ALERT_WEBHOOK_URL"⟭
  exit "$status"
fi
⟬end⟭

⟬template⟭
family: code
format: .py
language: en
fill_locale: en_US
domain: fintech
appearance: docstring, doctest, function, string literal
scenario: payments engineer's check-digit helpers run before calling the bank partner, documented with public test numbers only
⟬text⟭
"""Check-digit helpers run before we call the bank partner, to fail fast on typos.

    >>> aba_is_valid("011000015")
    True
    >>> aba_is_valid("011000016")
    False
    >>> luhn_ok("79927398713")
    True
"""
ABA_WEIGHTS = (3, 7, 1) * 3


def aba_is_valid(routing: str) -> bool:
    """ABA routing numbers: the 3-7-1 weighted sum is a multiple of 10."""
    if len(routing) != 9 or not routing.isdigit():
        return False
    return sum(int(d) * w for d, w in zip(routing, ABA_WEIGHTS)) % 10 == 0


def luhn_ok(number: str) -> bool:
    """⟬trap:eponym|Luhn⟭ mod 10, as used by card numbers. Spaces and dashes are ignored."""
    digits = [int(c) for c in number if c.isdigit()]
    if len(digits) < 2:
        return False
    checksum = 0
    for i, d in enumerate(reversed(digits)):
        if i % 2:
            d = d * 2 - 9 if d > 4 else d * 2
        checksum += d
    return checksum % 10 == 0


def mask_pan(number: str) -> str:
    """Keep the last four digits only, for logs and receipts."""
    digits = "".join(c for c in number if c.isdigit())
    return ⟬trap:placeholder|"•••• "⟭ + digits[-4:]
⟬end⟭
