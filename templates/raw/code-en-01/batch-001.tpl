⟬template⟭
family: code
format: .py
language: en
fill_locale: en_US
domain: healthcare
appearance: docstring, nested dict, comment, string literal
scenario: FastAPI router for an urgent care check-in kiosk, with a pydantic example payload that the backend developer filled with the QA test patient
⟬text⟭
"""Patient intake endpoints for the urgent care check-in kiosk.

POST /intake creates a pending encounter; the front desk confirms it later.
"""
from datetime import date
from typing import Optional

from fastapi import APIRouter, HTTPException, status
from pydantic import BaseModel, EmailStr, Field

from .db import encounters
from .ssn import mask_ssn

router = APIRouter(prefix="/intake", tags=["intake"])


class IntakeForm(BaseModel):
    first_name: str
    last_name: str
    date_of_birth: date
    ssn: Optional[str] = Field(None, description="Optional; only the last four digits are stored in clear")
    phone: str
    email: Optional[EmailStr] = None
    street: str
    city: str
    zip_code: str

    model_config = {
        "json_schema_extra": {
            "example": {
                "first_name": "⟬person_name:given#1⟭",
                "last_name": "⟬person_name:family#1⟭",
                "date_of_birth": "⟬birth_date#1⟭",
                "ssn": "⟬us_ssn#1⟭",
                "phone": "⟬phone#1⟭",
                "email": "⟬email#1⟭",
                "street": "⟬postal_address:street#1⟭",
                "city": "⟬city#1⟭",
                "zip_code": "⟬postcode#1⟭",
            }
        }
    }


@router.post("", status_code=status.HTTP_201_CREATED)
async def create_intake(form: IntakeForm):
    if form.date_of_birth > date.today():
        raise HTTPException(422, "date_of_birth is in the future")
    record = form.model_dump()
    record["ssn"] = mask_ssn(form.ssn) if form.ssn else None
    # TODO(⟬person_name:handle#2⟭): drop the kiosk test patient from the example once QA signs off
    encounter_id = await encounters.insert(record, source="kiosk")
    return {"encounter_id": encounter_id, "status": "pending"}
⟬end⟭

⟬template⟭
family: code
format: .ipynb
language: en
fill_locale: en_US
domain: SaaS
appearance: notebook output, keyword argument, markdown cell, comment
scenario: support-ops analyst's notebook testing an OpenAI model for ticket triage on a helpdesk export, with the API key pasted in a cell and tickets showing in the output
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Ticket triage with an LLM: first pass\n",
    "\n",
    "Route inbound tickets to `billing`, `bug`, `account_access` or `other`. Data: last week's helpdesk export."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "metadata": {},
   "outputs": [],
   "source": [
    "import ⟬trap:library|pandas⟭ as pd\n",
    "from openai import OpenAI\n",
    "\n",
    "client = OpenAI(api_key=\"⟬openai_api_key#1⟭\")  # TODO: env var before this goes in the repo"
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
       "     ticket_id                 requester                                               body\n",
       "0  ⟬ticket_id#1⟭  ⟬email#2⟭  Hi, this is ⟬person_name#2⟭, I can't log in since the pass...\n",
       "1  ⟬ticket_id#2⟭  ⟬email#3⟭  I uploaded my passport (⟬us_passport#3⟭) twice and the ...\n",
       "2  ⟬ticket_id#3⟭  ⟬email#4⟭  Invoice ⟬invoice_number#1⟭ was charged twice on our card...\n",
       "3  ⟬ticket_id#4⟭  ⟬email:generic#5⟭  Export to CSV times out for workspaces with more than 1..."
      ]
     },
     "execution_count": 2,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "tickets = pd.read_csv(\"⟬file_path#1⟭\")\n",
    "tickets[[\"ticket_id\", \"requester\", \"body\"]].head(4)"
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
       "label\n",
       "account_access    41\n",
       "billing           33\n",
       "bug               27\n",
       "other             12\n",
       "⟬trap:indicator_non_pii|Name: count⟭, dtype: int64"
      ]
     },
     "execution_count": 3,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "LABELS = [\"billing\", \"bug\", \"account_access\", \"other\"]\n",
    "\n",
    "def classify(body: str) -> str:\n",
    "    resp = client.chat.completions.create(\n",
    "        model=\"gpt-4o-mini\",\n",
    "        messages=[\n",
    "            {\"role\": \"system\", \"content\": f\"Classify the support ticket into one of {LABELS}. Answer with the label only.\"},\n",
    "            {\"role\": \"user\", \"content\": body},\n",
    "        ],\n",
    "        temperature=0,\n",
    "    )\n",
    "    return resp.choices[0].message.content.strip()\n",
    "\n",
    "tickets[\"label\"] = tickets[\"body\"].map(classify)\n",
    "tickets[\"label\"].value_counts()"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Spot check: ticket 0 went to `bug`, should be `account_access`. ⟬person_name#6⟭ suggested two examples per label in the system prompt; try that next."
   ]
  }
 ],
 "metadata": {
  "kernelspec": {"display_name": "Python 3", "language": "python", "name": "python3"},
  "language_info": {"name": "python", "version": "3.11.6"}
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
appearance: comment, CTE, SQL WHERE
scenario: risk analyst's weekly ACH return-rate query, with a one-off lookup appended at the bottom for an account that bounced three times
⟬text⟭
-- ach_returns_weekly.sql
-- Weekly R01/R03 return rates per originator, for the Monday risk review.
-- Owner: ⟬person_name#1⟭ (risk analytics). Test originator excluded since ⟬date#1⟭, see ⟬ticket_id#1⟭.

WITH entries AS (
    SELECT e.entry_id,
           e.originator_id,
           date_trunc('week', e.effective_date)::date AS wk
    FROM ach.entries e
    WHERE e.effective_date >= current_date - interval '12 weeks'
      AND e.originator_id <> 'ORIG-TEST-0001'
      AND ⟬trap:indicator_non_pii|e.receiver_name <> 'ACH TEST ACCOUNT'⟭
),
returns AS (
    SELECT r.entry_id, r.return_code
    FROM ach.returns r
    WHERE r.return_code IN ('R01', 'R03')
)
SELECT en.originator_id,
       en.wk,
       count(*)                                         AS entries,
       count(rt.entry_id)                               AS returned,
       round(100.0 * count(rt.entry_id) / count(*), 2)  AS return_pct
FROM entries en
LEFT JOIN returns rt USING (entry_id)
GROUP BY en.originator_id, en.wk
HAVING count(*) >= 50
ORDER BY en.wk DESC, return_pct DESC;

-- one-off for ops: this receiver bounced three times in one week
-- holder ⟬person_name#2⟭, account opened ⟬date#2⟭
SELECT e.entry_id, e.amount_cents, e.effective_date, r.return_code, r.returned_at
FROM ach.entries e
LEFT JOIN ach.returns r USING (entry_id)
WHERE e.receiver_account_number = '⟬bank_account_number#2⟭'
ORDER BY e.effective_date DESC;
⟬end⟭

⟬template⟭
family: code
format: .sh
language: en
fill_locale: en_US
domain: SaaS
appearance: environment variable, command-line argument, comment
scenario: ML engineer's eval runner on the GPU box that pulls a checkpoint from Hugging Face, scores it against Claude and pushes the report to S3, with every key exported at the top
⟬text⟭
#!/usr/bin/env bash
# run_evals.sh: pull the fine-tuned checkpoint, score it against the Claude baseline
# on the held-out split, push the report to S3. Run on the GPU box, not your laptop.
set -euo pipefail

export HF_TOKEN="⟬huggingface_token#1⟭"
export ANTHROPIC_API_KEY="⟬anthropic_api_key#1⟭"
export AWS_ACCESS_KEY_ID="⟬aws_access_key_id#1⟭"
export AWS_SECRET_ACCESS_KEY="⟬aws_secret_access_key#1⟭"
export AWS_DEFAULT_REGION=us-east-1
export ⟬trap:indicator_non_pii|TOKENIZERS_PARALLELISM=false⟭

MODEL_REPO="support-ml/ticket-router-base"
REV="${1:-main}"
OUT="runs/$(date +%Y%m%d-%H%M)"

mkdir -p "$OUT"
huggingface-cli download "$MODEL_REPO" --revision "$REV" --local-dir "$OUT/model"
python -m evals.run --model "$OUT/model" --baseline claude --split heldout --out "$OUT/report.json"
aws s3 cp "$OUT/report.json" "s3://ml-eval-reports/$(basename "$OUT").json"
echo "done: $OUT"
⟬end⟭

⟬template⟭
family: code
format: .py
language: en
fill_locale: en_US
domain: government
appearance: list literal, dict literal, comment, keyword argument
scenario: Django data migration seeding two test applicants into a benefits eligibility portal, one filing with an SSN and one with an ITIN
⟬text⟭
# Generated by Django 4.2.11 on ⟬date#1⟭ 14:21
# Edited by hand: seed rows for the staging eligibility walkthrough.
from django.db import migrations

TEST_APPLICANTS = [
    {
        "first_name": "⟬person_name:given#1⟭",
        "last_name": "⟬person_name:family#1⟭",
        "dob": "⟬birth_date#1⟭",
        "ssn": "⟬us_ssn#1⟭",
        "itin": "",
        "mailing_street": "⟬postal_address:street#1⟭",
        "mailing_city": "⟬city#1⟭",
        "mailing_zip": "⟬postcode#1⟭",
        "household_size": 3,
    },
    {
        "first_name": "⟬person_name:given#2⟭",
        "last_name": "⟬person_name:family#2⟭",
        "dob": "⟬birth_date#2⟭",
        "ssn": "",
        "itin": "⟬us_itin#2⟭",  # no SSN: files with an ITIN, exercises the manual review path
        "mailing_street": "⟬postal_address:street#2⟭",
        "mailing_city": "⟬city#2⟭",
        "mailing_zip": "⟬postcode#2⟭",
        "household_size": 1,
    },
]


def seed(apps, schema_editor):
    Applicant = apps.get_model("benefits", "Applicant")
    for row in TEST_APPLICANTS:
        Applicant.objects.get_or_create(
            ssn=row["ssn"] or None,
            itin=row["itin"] or None,
            defaults=row,
        )


def unseed(apps, schema_editor):
    Applicant = apps.get_model("benefits", "Applicant")
    Applicant.objects.filter(last_name__in=[r["last_name"] for r in TEST_APPLICANTS]).delete()


class Migration(migrations.Migration):
    dependencies = [("benefits", "0014_applicant_itin")]
    operations = [migrations.RunPython(seed, unseed)]
⟬end⟭

⟬template⟭
family: code
format: .py
language: en
fill_locale: en_US
domain: insurance
appearance: docstring, nested JSON, keyword argument, dict literal
scenario: Airflow DAG that ingests first-notice-of-loss files from a partner, with a sample claim in the docstring and AWS keys inlined because staging has no secrets backend
⟬text⟭
"""Nightly ingest of first-notice-of-loss (FNOL) files from the partner drop.

Each file is a JSON list of claims shaped like:

    {"claim_ref": "⟬order_number#1⟭", "policy_no": "⟬customer_id#1⟭", "loss_date": "⟬date#2⟭",
     "vehicle": {"plate": "⟬us_license_plate#1⟭", "year": 2019, "make": "Subaru"},
     "driver": {"name": "⟬person_name#1⟭", "dl_number": "⟬us_driver_license#1⟭", "dl_state": "MN"}}

Plates and licence numbers go to the restricted schema, everything else to claims_raw.
"""
import json
from datetime import datetime, timedelta

from airflow import DAG
from airflow.models import Connection
from airflow.operators.python import PythonOperator
from airflow.providers.amazon.aws.hooks.s3 import S3Hook
from airflow.providers.postgres.hooks.postgres import PostgresHook

# FIXME: staging has no secrets backend yet, so the connection is built inline.
FNOL_S3 = Connection(
    conn_id="fnol_s3",
    conn_type="aws",
    login="⟬aws_access_key_id#3⟭",
    password="⟬aws_secret_access_key#3⟭",
    extra=json.dumps({"region_name": "us-east-2"}),
)


def split_claim(claim: dict) -> tuple[dict, dict]:
    driver, vehicle = claim.pop("driver"), claim.pop("vehicle")
    restricted = {
        "claim_ref": claim["claim_ref"],
        "plate": vehicle.pop("plate"),
        "dl_number": driver.pop("dl_number"),
    }
    return {**claim, "vehicle": vehicle, "driver": driver}, restricted


def load_fnol(ds: str, **_):
    s3 = S3Hook(aws_conn_id=FNOL_S3.conn_id)
    pg = PostgresHook(postgres_conn_id="claims_dw")
    for key in s3.list_keys(bucket_name="fnol-landing", prefix=f"partner/{ds}/") or []:
        for claim in json.loads(s3.read_key(key, bucket_name="fnol-landing")):
            public, restricted = split_claim(claim)
            pg.run("INSERT INTO claims_raw.fnol (doc) VALUES (%s)", parameters=(json.dumps(public),))
            pg.run(
                "INSERT INTO restricted.fnol_ids (claim_ref, plate, dl_number) "
                "VALUES (%(claim_ref)s, %(plate)s, %(dl_number)s)",
                parameters=restricted,
            )


with DAG(
    dag_id="fnol_ingest",
    start_date=datetime(2024, 1, 1),
    schedule="30 3 * * *",
    catchup=False,
    default_args={
        ⟬trap:indicator_non_pii|"owner": "claims-data"⟭,
        "retries": 2,
        "retry_delay": timedelta(minutes=10),
        "email": ["⟬email:generic#4⟭"],
        "email_on_failure": True,
    },
) as dag:
    PythonOperator(task_id="load_fnol", python_callable=load_fnol)
⟬end⟭

⟬template⟭
family: code
format: .ipynb
language: en
fill_locale: en_US
domain: healthcare
appearance: notebook output, keyword argument, markdown cell
scenario: hospital informatics pilot notebook asking Claude to condense a discharge summary into a nursing-facility handoff, with the sandbox note printed in full
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "### Discharge summary condensation (pilot, unit 4B)\n",
    "Can the model turn a 3-page discharge summary into the 5-line handoff the SNF asks for? Notes come from the EHR sandbox, not prod."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 4,
   "metadata": {},
   "outputs": [],
   "source": [
    "import anthropic\n",
    "\n",
    "client = anthropic.Anthropic(api_key=\"⟬anthropic_api_key#1⟭\")\n",
    "MODEL = \"claude-sonnet-4-5\""
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 5,
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "DISCHARGE SUMMARY\n",
      "Patient: ⟬person_name#2m⟭    DOB: ⟬birth_date#2⟭    Sex: M\n",
      "Admitted: ⟬date#2⟭    Discharged: ⟬date#1⟭\n",
      "Attending: ⟬person_name#3⟭, MD\n",
      "Primary care: ⟬person_name#4⟭, ⟬phone#4⟭\n",
      "\n",
      "HOSPITAL COURSE: 78 y/o male admitted with community-acquired pneumonia, treated with\n",
      "ceftriaxone and azithromycin, switched to oral amoxicillin on day 4. Episode of\n",
      "delirium on night 2 resolved without antipsychotics. Ambulating with walker.\n"
     ]
    }
   ],
   "source": [
    "note = open(\"⟬file_path#1⟭\").read()\n",
    "print(note[:620])"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 6,
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "- ⟬person_name:family#2⟭, 78M, CAP, finished IV antibiotics, oral amoxicillin through day 7.\n",
      "- Delirium night 2, resolved; no antipsychotics given.\n",
      "- Walker for ambulation, PT twice weekly.\n",
      "- Follow-up with PCP ⟬person_name#4⟭ within 7 days.\n",
      "- Code status: full code.\n"
     ]
    }
   ],
   "source": [
    "msg = client.messages.create(\n",
    "    model=MODEL,\n",
    "    max_tokens=400,\n",
    "    system=\"You write 5-line handoffs for skilled nursing facilities. Bullet points, no preamble.\",\n",
    "    messages=[{\"role\": \"user\", \"content\": note}],\n",
    ")\n",
    "print(msg.content[0].text)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Good enough for the demo. It keeps the patient name, so strip it before anything leaves the sandbox."
   ]
  }
 ],
 "metadata": {
  "kernelspec": {"display_name": "Python 3 (ipykernel)", "language": "python", "name": "python3"},
  "language_info": {"name": "python", "version": "3.10.13"}
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
domain: government
appearance: comment, DDL, SQL INSERT
scenario: Flyway migration creating a passport renewal queue table, with QA seed rows for the staging environment
⟬text⟭
-- V27__passport_renewal_queue.sql
-- Renewal queue for the mail-in channel. The seed rows at the bottom are QA
-- fixtures for staging only; prod runs with flyway.target=26 until sign-off.

CREATE TABLE renewal_application (
    application_id    BIGSERIAL PRIMARY KEY,
    applicant_name    TEXT        NOT NULL,
    date_of_birth     DATE        NOT NULL,
    current_passport  VARCHAR(9)  NOT NULL,
    mailing_address   TEXT        NOT NULL,
    status            TEXT        NOT NULL DEFAULT 'received'
                      CHECK (status IN ('received', 'photo_rejected', 'in_review', 'mailed')),
    received_on       DATE        NOT NULL DEFAULT CURRENT_DATE
);

CREATE INDEX ix_renewal_passport ON renewal_application (current_passport);
CREATE INDEX ix_renewal_status ON renewal_application (status, received_on);

INSERT INTO renewal_application (applicant_name, date_of_birth, current_passport, mailing_address, status, received_on) VALUES
('⟬person_name#1⟭', '⟬birth_date#1⟭', '⟬us_passport#1⟭', '⟬postal_address#1⟭', 'received', '⟬date#1⟭'),
('⟬person_name#2⟭', '⟬birth_date#2⟭', '⟬us_passport#2⟭', '⟬postal_address#2⟭', 'photo_rejected', '⟬date#2⟭'),
('⟬person_name#3⟭', '⟬birth_date#3⟭', '⟬us_passport#3⟭', '⟬postal_address#3⟭', 'mailed', '⟬date#3⟭');
⟬end⟭

⟬template⟭
family: code
format: .py
language: en
fill_locale: en_US
domain: retail
appearance: assignment, dict literal, comment
scenario: quick hack by a store-systems developer that drafts curbside pickup texts with OpenAI, with the key and a real-looking order pasted in
⟬text⟭
# curbside_notify.py - quick hack for the pilot store, do not deploy as is
import openai

openai.api_key = "⟬openai_api_key#1⟭"

order = {
    "order": "⟬order_number#1⟭",
    "customer": "⟬person_name#1⟭",
    "vehicle": "gray SUV, plate ⟬us_license_plate#1⟭",
    "bay": 4,
}

first = order["customer"].split()[0]
prompt = (
    "Write a friendly SMS under 160 characters telling the customer their order is on its way "
    f"to their car. Order {order['order']}, first name {first}, pickup bay {order['bay']}."
)
resp = openai.chat.completions.create(model="gpt-4o-mini", messages=[{"role": "user", "content": prompt}])
print(resp.choices[0].message.content)
# sample run: Hi ⟬person_name:given#1⟭! Your order ⟬order_number#1⟭ is heading to bay 4 now 🚗
⟬end⟭

⟬template⟭
family: code
format: .py
language: en
fill_locale: en_US
domain: fintech
appearance: test fixture, nested dict, assertion, docstring
scenario: pytest suite for a KYC document matcher, with fixtures for an SSN applicant and an ITIN applicant written by the onboarding team
⟬text⟭
"""Tests for the KYC document matcher.

The matcher compares what the customer typed at signup with what the ID scan returned.
"""
import pytest

from kyc.matcher import MatchStatus, match_identity
from kyc.testing import shift_days


@pytest.fixture
def applicant():
    return {
        "legal_name": "⟬person_name#1⟭",
        "dob": "⟬birth_date#1⟭",
        "tin": {"type": "SSN", "value": "⟬us_ssn#1⟭"},
        "address": {"line1": "⟬postal_address:street#1⟭", "city": "⟬city#1⟭", "zip": "⟬postcode#1⟭"},
        "funding": {"account_number": "⟬bank_account_number#1⟭", "routing": "110000000"},
    }


@pytest.fixture
def itin_applicant(applicant):
    return {
        **applicant,
        "legal_name": "⟬person_name#2⟭",
        "dob": "⟬birth_date#2⟭",
        "tin": {"type": "ITIN", "value": "⟬us_itin#2⟭"},
        "funding": {"account_number": "⟬bank_account_number#2⟭", "routing": "110000000"},
    }


@pytest.fixture
def passport_scan(applicant):
    return {"doc_type": "passport", "number": "⟬us_passport#1⟭", "name": applicant["legal_name"].upper(), "dob": applicant["dob"]}


def test_passport_scan_matches_typed_identity(applicant, passport_scan):
    result = match_identity(applicant, passport_scan)
    assert result.status is MatchStatus.MATCH
    assert result.display_tin.startswith(⟬trap:placeholder|"***-**-"⟭)


def test_dob_off_by_one_day_goes_to_review(applicant, passport_scan):
    passport_scan["dob"] = shift_days(applicant["dob"], 1)
    assert match_identity(applicant, passport_scan).status is MatchStatus.REVIEW


def test_itin_without_document_goes_to_review(itin_applicant):
    result = match_identity(itin_applicant, scan=None)
    assert result.status is MatchStatus.REVIEW
    assert "⟬us_itin#2⟭" not in result.audit_log  # the full TIN must never reach the audit log
⟬end⟭

⟬template⟭
family: code
format: .sh
language: en
fill_locale: en_US
domain: insurance
appearance: comment, environment variable, command-line argument
scenario: nightly cron script on a claims replica that dumps Postgres to S3, with the on-call engineer's phone in the header and credentials in plain variables
⟬text⟭
#!/bin/bash
# nightly pg_dump of the claims read replica -> S3 (Glacier after 30d via bucket lifecycle)
# on call for this box: ⟬person_name#1⟭ ⟬phone#1⟭, page before restarting anything
# crontab: 15 2 * * * /opt/backup/claims_dump.sh >> /var/log/claims_dump.log 2>&1

AWS_ACCESS_KEY_ID=⟬aws_access_key_id#1⟭
AWS_SECRET_ACCESS_KEY=⟬aws_secret_access_key#1⟭
export AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY

export PGPASSWORD='⟬password#1⟭'
DB_HOST=⟬hostname#1⟭
STAMP=$(date +%F)
DUMP=/var/backups/claims_${STAMP}.dump

pg_dump -h "$DB_HOST" ⟬trap:indicator_non_pii|-U backup_ro⟭ -Fc claims > "$DUMP" || { echo "dump failed"; exit 1; }
aws s3 cp "$DUMP" "s3://claims-db-backups/${STAMP}/" --storage-class STANDARD_IA
find /var/backups -name 'claims_*.dump' -mtime +3 -delete
⟬end⟭

⟬template⟭
family: code
format: .sql
language: en
fill_locale: en_US
domain: insurance
appearance: function call, comment, SQL UPDATE, SQL WHERE, CTE
scenario: special investigations analyst's similarity search over adjuster notes with pgai, with the OpenAI key set for the session and a suspicious plate in the filter
⟬text⟭
-- Similar-claims lookup for the SIU team.
-- Embeddings come from pgai; the key is set per session and never stored in a table.
SELECT set_config('ai.openai_api_key', '⟬openai_api_key#1⟭', false);

-- 1. embed adjuster notes that still have no vector
UPDATE claims.adjuster_note n
SET embedding = ai.openai_embed('text-embedding-3-small', n.body)
WHERE n.embedding IS NULL
  AND n.created_at >= now() - interval '30 days';

-- 2. notes closest to the claim flagged in ⟬ticket_id#1⟭ (rear-end collision, plate ⟬us_license_plate#1⟭)
--    other vehicle in the photos: ⟬us_license_plate#2⟭, driven by ⟬person_name#2⟭
WITH target AS (
    SELECT n.embedding
    FROM claims.adjuster_note n
    JOIN claims.claim c ON c.claim_id = n.claim_id
    WHERE c.vehicle_plate = '⟬us_license_plate#1⟭'
    ORDER BY n.created_at DESC
    LIMIT 1
)
SELECT c.claim_id,
       c.vehicle_plate,
       c.insured_name,
       left(n.body, 200)              AS excerpt,
       n.embedding <=> t.embedding    AS distance
FROM claims.adjuster_note n
JOIN claims.claim c ON c.claim_id = n.claim_id
CROSS JOIN target t
WHERE c.vehicle_plate <> '⟬us_license_plate#1⟭'
ORDER BY distance
LIMIT 20;
⟬end⟭

⟬template⟭
family: code
format: .ipynb
language: en
fill_locale: en_US
domain: fintech
appearance: notebook output, function call, markdown cell, free text
scenario: data scientist's notebook trying an off-the-shelf Hugging Face NER model on an OCR'd credit union statement before any labeling, logged in with a personal token
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "## Statement parser: NER baseline\n",
    "\n",
    "Before labeling anything, check what an off-the-shelf token classifier does on OCR'd bank statements."
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
      "⟬trap:indicator_non_pii|Token is valid (permission: read).⟭\n",
      "Your token has been saved to /home/jovyan/.cache/huggingface/token\n",
      "Login successful\n"
     ]
    }
   ],
   "source": [
    "from huggingface_hub import login\n",
    "login(token=\"⟬huggingface_token#1⟭\")  # org-gated checkpoint"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "metadata": {},
   "outputs": [],
   "source": [
    "from transformers import pipeline\n",
    "ner = pipeline(\"token-classification\", model=\"dslim/bert-base-NER\", aggregation_strategy=\"simple\")"
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
      "⟬company#1⟭\n",
      "Member statement   ⟬date#4⟭ - ⟬date#1⟭\n",
      "\n",
      "⟬person_name#2⟭\n",
      "⟬postal_address#2⟭\n",
      "\n",
      "Share Draft (checking)   Acct ⟬bank_account_number#2⟭\n",
      "Beginning balance                          2,418.07\n",
      "  ⟬date#3⟭  ACH DEBIT ⟬company#3⟭ AUTOPAY        -86.40\n",
      "  ⟬date#2⟭  ZELLE FROM ⟬person_name#4⟭            250.00\n",
      "Ending balance                             2,581.67\n"
     ]
    }
   ],
   "source": [
    "sample = open(\"⟬file_path#1⟭\").read()\n",
    "print(sample)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 4,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "[{'entity_group': 'ORG', 'score': 0.97, 'word': '⟬company#1⟭', 'start': 0, 'end': 24},\n",
       " {'entity_group': 'PER', 'score': 0.998, 'word': '⟬person_name#2⟭', 'start': 66, 'end': 80},\n",
       " {'entity_group': 'LOC', 'score': 0.91, 'word': '⟬city#2⟭', 'start': 103, 'end': 112},\n",
       " {'entity_group': 'PER', 'score': 0.64, 'word': '⟬person_name:family#4⟭', 'start': 318, 'end': 325}]"
      ]
     },
     "execution_count": 4,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "ner(sample)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Account numbers come back as nothing at all and the Zelle sender is half found. Not usable as is: label about 200 statements first (see ⟬ticket_id#1⟭)."
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
format: .py
language: en
fill_locale: en_US
domain: SaaS
appearance: class attribute, connection string, keyword argument, docstring
scenario: pydantic settings module of a FastAPI summarization service, where a developer left personal keys as defaults for local runs
⟬text⟭
"""Runtime settings for the summarizer API.

Values come from the environment (prefix SUMM_); the defaults below are for local runs only.
"""
from functools import lru_cache

from pydantic import Field, PostgresDsn
from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    model_config = SettingsConfigDict(env_file=".env", env_prefix="SUMM_")

    environment: str = "local"
    database_url: PostgresDsn = "postgresql://summ:⟬url_password#1⟭@localhost:5432/summ"
    anthropic_api_key: str = "⟬anthropic_api_key#1⟭"  # my dev key, rotate before the demo
    hf_token: str = Field("⟬huggingface_token#1⟭", description="pulls the reranker from the private org")
    default_model: str = "claude-haiku-4-5"
    ⟬trap:indicator_non_pii|max_input_tokens: int = 150_000⟭
    ⟬trap:indicator_non_pii|api_key_header: str = "X-Summ-Key"⟭
    support_email: str = "⟬email:generic#2⟭"
    cors_origins: list[str] = ["⟬url#1⟭"]
    request_timeout_s: float = 30.0


@lru_cache
def get_settings() -> Settings:
    return Settings()
⟬end⟭

⟬template⟭
family: code
format: .py
language: en
fill_locale: en_US
domain: healthcare
appearance: docstring, dataclass, comment, doctest, log message
scenario: community clinic's pipeline turning the self-pay ledger into claim records for a sliding-fee grant, where some patients give an ITIN instead of an SSN
⟬text⟭
"""Build 837P-like claim records from the clinic's self-pay ledger.

Self-pay patients later covered by the sliding-fee grant still need a claim, so the
grant office can reconcile. Some of them have no SSN and give an ITIN instead; the
grant accepts either as the subscriber id.

Input: one CSV per day under /data/ledger/, columns
    visit_id, patient_name, dob, tin, street, city, zip, phone, cpt, charge_cents

Output: JSON lines for the grant portal uploader.
"""
import csv
import json
import logging
import re
from dataclasses import asdict, dataclass
from pathlib import Path

log = logging.getLogger("selfpay837")

ITIN_RE = re.compile(r"^9\d{2}-?(5\d|6[0-5]|7\d|8[0-8]|9[0-2]|9[4-9])-?\d{4}$")
SSN_RE = re.compile(r"^(?!000|666|9)\d{3}-?(?!00)\d{2}-?(?!0000)\d{4}$")
⟬trap:indicator_non_pii|PHONE_DIGITS = 10⟭


@dataclass
class ClaimLine:
    visit_id: str
    subscriber_name: str
    subscriber_dob: str
    subscriber_id_type: str
    subscriber_id: str
    address: str
    phone: str
    cpt: str
    charge_cents: int


def id_type(tin: str) -> str:
    if ITIN_RE.match(tin):
        return "ITIN"
    if SSN_RE.match(tin):
        return "SSN"
    raise ValueError("unrecognized TIN format")


def clean_phone(raw: str) -> str:
    digits = re.sub(r"\D", "", raw)
    return digits[-PHONE_DIGITS:]


def to_claim(row: dict) -> ClaimLine:
    tin = row["tin"].strip()
    return ClaimLine(
        visit_id=row["visit_id"],
        subscriber_name=row["patient_name"].strip().upper(),
        subscriber_dob=row["dob"],
        subscriber_id_type=id_type(tin),
        subscriber_id=tin.replace("-", ""),
        address=f'{row["street"]}, {row["city"]} {row["zip"]}',
        phone=clean_phone(row["phone"]),
        cpt=row["cpt"],
        charge_cents=int(row["charge_cents"]),
    )


def convert(day_file: Path, out: Path) -> int:
    count = 0
    with day_file.open(newline="") as src, out.open("a") as dst:
        for row in csv.DictReader(src):
            try:
                claim = to_claim(row)
            except ValueError as err:
                # never log the row itself, it holds the TIN
                log.warning("skip visit %s: %s", row.get("visit_id"), err)
                continue
            dst.write(json.dumps(asdict(claim)) + "\n")
            count += 1
    return count


# Visit from the grant audit, kept as the regression case for ITIN detection:
#   >>> to_claim({"visit_id": "⟬order_number#1⟭", "patient_name": "⟬person_name#1⟭", "dob": "⟬birth_date#1⟭",
#   ...           "tin": "⟬us_itin#1⟭", "street": "⟬postal_address:street#1⟭", "city": "⟬city#1⟭",
#   ...           "zip": "⟬postcode#1⟭", "phone": "⟬phone#1⟭", "cpt": "99213", "charge_cents": "14500"}).subscriber_id_type
#   'ITIN'

if __name__ == "__main__":
    import sys

    logging.basicConfig(level=logging.INFO)
    total = sum(convert(Path(p), Path("out/claims.jsonl")) for p in sys.argv[1:])
    log.info("wrote %d claims", total)
⟬end⟭

⟬template⟭
family: code
format: .py
language: en
fill_locale: en_US
domain: SaaS
appearance: decorator, assignment, docstring, dict literal
scenario: platform engineer's health, readiness and API-key gate module for an ingestion gateway, holding no personal data
⟬text⟭
"""Health and readiness probes, plus the API-key gate in front of every router.

The gate only checks that a key is present and well formed; the auth service
validates it. Keys are never logged.
"""
import time

from fastapi import FastAPI, Request
from fastapi.responses import JSONResponse

⟬trap:indicator_non_pii|API_KEY_HEADER = "X-Api-Key"⟭
EXEMPT = {"/healthz", "/readyz", "/docs", "/openapi.json"}
STARTED = time.monotonic()
BUILD = {"version": "⟬version#1⟭", "commit": "⟬git_sha#1⟭"}

app = FastAPI(title="ingest-gateway")


@app.middleware("http")
async def require_api_key(request: Request, call_next):
    if request.url.path in EXEMPT:
        return await call_next(request)
    key = request.headers.get(API_KEY_HEADER, "")
    if len(key) < 32:
        return JSONResponse({"detail": "missing or malformed API key"}, status_code=401)
    return await call_next(request)


@app.get("/healthz")
async def healthz():
    return {"status": "ok", "uptime_s": round(time.monotonic() - STARTED, 1), **BUILD}


@app.get("/readyz")
async def readyz(request: Request):
    checks = {}
    for name, probe in request.app.state.probes.items():
        try:
            await probe()
            checks[name] = "ok"
        except Exception as exc:  # report it, a probe must never raise
            checks[name] = type(exc).__name__
    ready = all(value == "ok" for value in checks.values())
    return JSONResponse({"ready": ready, "checks": checks}, status_code=200 if ready else 503)
⟬end⟭

⟬template⟭
family: code
format: .sql
language: en
fill_locale: en_US
domain: retail
appearance: comment, CTE, window function, function call
scenario: dbt model computing weekly basket size and accessory attach rate per store format for the merchandising dashboard
⟬text⟭
/* weekly_basket_kpis
   Basket size and accessory attach rate per store format, last 13 weeks.
   Feeds the merch dashboard; dbt rebuilds it at 05:00. */
{{ config(materialized='incremental', unique_key='week_format') }}

-- ⟬trap:library|Jinja⟭ helpers live in macros/kpi.sql
WITH lines AS (
    SELECT o.order_id,
           s.store_format,
           date_trunc('week', o.ordered_at)::date AS week,
           ol.sku,
           ol.category,
           ol.qty,
           ol.net_amount
    FROM {{ ref('stg_orders') }} o
    JOIN {{ ref('stg_order_lines') }} ol USING (order_id)
    JOIN {{ ref('dim_store') }} s USING (store_id)
    WHERE o.ordered_at >= current_date - INTERVAL '13 weeks'
      AND ⟬trap:indicator_non_pii|o.customer_name <> 'GUEST'⟭
      AND o.channel IN ('store', 'curbside')
),
baskets AS (
    SELECT order_id,
           store_format,
           week,
           sum(qty)                                         AS units,
           sum(net_amount)                                  AS revenue,
           bool_or(category = 'accessories')                AS has_accessory,
           ⟬trap:code_identifier|⦃family⦄_attach_score⟭(array_agg(sku)) AS attach_score
    FROM lines
    GROUP BY order_id, store_format, week
)
SELECT week || '-' || store_format                          AS week_format,
       week,
       store_format,
       count(*)                                             AS baskets,
       round(avg(units), 2)                                 AS avg_units,
       round(avg(revenue), 2)                               AS avg_revenue,
       round(avg(has_accessory::int), 3)                    AS attach_rate,
       round(avg(attach_score), 3)                          AS avg_attach_score,
       round(avg(units) - lag(avg(units)) OVER (PARTITION BY store_format ORDER BY week), 2) AS units_wow
FROM baskets
{% if is_incremental() %}
WHERE week >= (SELECT max(week) - 14 FROM {{ this }})
{% endif %}
GROUP BY week, store_format
⟬end⟭

⟬template⟭
family: code
format: .ipynb
language: en
fill_locale: en_US
domain: insurance
appearance: notebook output, markdown cell, function, string literal
scenario: pricing actuary's notebook fitting a gradient boosting model on state-by-product loss ratio aggregates, with no policyholder data in it
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Loss ratio model v2: state x product aggregates\n",
    "\n",
    "Aggregates only (one row per state, product and accident quarter). Compares a ⟬trap:eponym|Tweedie⟭ GBM with the current GLM."
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
       "(1840, 12)"
      ]
     },
     "execution_count": 1,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "import numpy as np\n",
    "import ⟬trap:library|pandas⟭ as pd\n",
    "import lightgbm as lgb\n",
    "\n",
    "df = pd.read_parquet(\"⟬file_path#1⟭\")\n",
    "df.shape"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "metadata": {},
   "outputs": [],
   "source": [
    "def gini(y, p, w):\n",
    "    order = np.argsort(p)\n",
    "    y, w = y[order], w[order]\n",
    "    cum_w = np.cumsum(w) / w.sum()\n",
    "    cum_y = np.cumsum(y * w) / (y * w).sum()\n",
    "    return 1 - 2 * np.trapz(cum_y, cum_w)\n",
    "\n",
    "features = [\"state\", \"product\", \"acc_qtr\", \"earned_exposure\", \"avg_deductible\", \"cat_share\"]\n",
    "train, test = df[df.acc_qtr < \"2023Q1\"], df[df.acc_qtr >= \"2023Q1\"]"
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
      "[100]\tvalid_0's tweedie: 1.8143\n",
      "[200]\tvalid_0's tweedie: 1.7921\n",
      "[300]\tvalid_0's tweedie: 1.7915\n",
      "holdout gini  GBM 0.312  GLM 0.271\n"
     ]
    }
   ],
   "source": [
    "params = {\"objective\": \"tweedie\", \"tweedie_variance_power\": 1.5, \"learning_rate\": 0.03, \"num_leaves\": 15}\n",
    "dtrain = lgb.Dataset(train[features], train.loss_ratio, weight=train.earned_premium, categorical_feature=[\"state\", \"product\"])\n",
    "dvalid = lgb.Dataset(test[features], test.loss_ratio, weight=test.earned_premium, reference=dtrain)\n",
    "model = lgb.train(params, dtrain, 300, valid_sets=[dvalid], callbacks=[lgb.log_evaluation(100)])\n",
    "p_gbm = model.predict(test[features])\n",
    "print(f\"holdout gini  GBM {gini(test.loss_ratio.values, p_gbm, test.earned_premium.values):.3f}  GLM {gini(test.loss_ratio.values, test.glm_pred.values, test.earned_premium.values):.3f}\")"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Normalized ⟬trap:eponym|Gini⟭ on the holdout: 0.31 vs 0.27. The ⟬trap:eponym|Poisson⟭ frequency GBM from the last review was worse on small states. Next: monotone constraint on deductible, rerun on data as of ⟬date#1⟭."
   ]
  }
 ],
 "metadata": {
  "kernelspec": {"display_name": "pricing (conda)", "language": "python", "name": "pricing"},
  "language_info": {"name": "python", "version": "3.11.4"}
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
appearance: environment variable, command-line argument, URL
scenario: CI deploy script for a summarizer API that only checks that secrets exist and never holds one
⟬text⟭
#!/usr/bin/env bash
# deploy.sh <staging|prod>: build, push and roll out the summarizer API.
# Secrets come from the CI vault; this script only checks that they are set.
set -euo pipefail

ENV="${1:?usage: deploy.sh <staging|prod>}"
: "⟬trap:placeholder|${ANTHROPIC_API_KEY:?ANTHROPIC_API_KEY is not set}⟭"
: "⟬trap:placeholder|${REGISTRY_PASSWORD:?REGISTRY_PASSWORD is not set}⟭"
export ⟬trap:indicator_non_pii|TOKEN_REFRESH_SECONDS=3600⟭

IMAGE="⟬hostname#1⟭/summarizer:⟬git_sha#1⟭"

echo "⟬trap:placeholder|$REGISTRY_PASSWORD⟭" | docker login "⟬hostname#1⟭" --username ⟬username#1⟭ --password-stdin
docker build -t "$IMAGE" --build-arg VERSION="⟬version#1⟭" .
docker push "$IMAGE"

kubectl --context "$ENV" -n summarizer set image deploy/api api="$IMAGE"
kubectl --context "$ENV" -n summarizer rollout status deploy/api --timeout=180s
curl -fsS "https://⟬hostname#2⟭/healthz" | jq .
⟬end⟭

⟬template⟭
family: code
format: .py
language: en
fill_locale: en_US
domain: government
appearance: docstring, keyword argument, f-string, comment
scenario: Django management command run nightly by a city permit portal to purge stale application drafts
⟬text⟭
"""Delete permit application drafts nobody touched for 90 days.

Run nightly from cron:  python manage.py purge_stale_drafts --days 90
Drafts may hold uploaded documents; the storage backend deletes the blobs.
"""
from datetime import timedelta

from django.core.management.base import BaseCommand
from django.db import transaction
from django.utils import timezone

from permits.models import Draft


class Command(BaseCommand):
    help = "Delete stale permit drafts"

    def add_arguments(self, parser):
        parser.add_argument("--days", type=int, default=90)
        parser.add_argument("--dry-run", action="store_true")

    def handle(self, *args, days, dry_run, **options):
        cutoff = timezone.now() - timedelta(days=days)
        stale = Draft.objects.filter(updated_at__lt=cutoff, submitted=False)
        # ⟬ticket_id#1⟭: drafts under an appeal hold are kept, and so are the bulk imports
        stale = stale.filter(appeal_hold=False).exclude(⟬trap:indicator_non_pii|created_by="import-bot"⟭)
        count = stale.count()
        if dry_run:
            self.stdout.write(f"{count} drafts older than {cutoff:%Y-%m-%d} would be deleted")
            return
        with transaction.atomic():
            for draft in stale.iterator(chunk_size=500):
                draft.attachments.all().delete()
                draft.delete()
        self.stdout.write(self.style.SUCCESS(f"deleted {count} drafts"))
⟬end⟭
