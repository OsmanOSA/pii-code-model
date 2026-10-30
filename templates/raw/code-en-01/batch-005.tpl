⟬template⟭
family: code
format: .ipynb
language: en
fill_locale: en_US
domain: healthcare
appearance: notebook output, function call, markdown cell, free text
scenario: clinical NLP engineer's notebook measuring a private de-identification model's recall on the gold notes, printing a gold note and the model's spans
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# De-identification model: recall on the gold notes\n",
    "Private checkpoint fine-tuned on i2b2-style labels. Gold set: 150 notes double-annotated by HIM."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "metadata": {},
   "outputs": [],
   "source": [
    "import json\n",
    "\n",
    "from huggingface_hub import login\n",
    "from transformers import pipeline\n",
    "\n",
    "login(token=\"⟬huggingface_token#1⟭\")\n",
    "deid = pipeline(\"token-classification\", model=\"clinical-nlp/deid-roberta-v3\", aggregation_strategy=\"first\")\n",
    "gold = [json.loads(line) for line in open(\"⟬file_path#1⟭\")]"
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
      "CC: chest pain x2 days.\n",
      "HPI: ⟬person_name#2m⟭ is a 61 yo M seen today with his daughter ⟬person_name:given#3f⟭. Pain is substernal, worse on exertion.\n",
      "SOCIAL: lives at ⟬postal_address#2⟭ with his wife. Daughter's cell ⟬phone#3⟭ for follow-up.\n",
      "DOB ⟬birth_date#2⟭. PCP Dr. ⟬person_name:family#4⟭.\n"
     ]
    }
   ],
   "source": [
    "note = gold[7][\"text\"]\n",
    "print(note)"
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
       "[{'entity_group': 'PATIENT', 'word': '⟬person_name#2⟭', 'score': 0.99},\n",
       " {'entity_group': 'PATIENT', 'word': '⟬person_name:given#3⟭', 'score': 0.71},\n",
       " {'entity_group': 'PHONE', 'word': '⟬phone#3⟭', 'score': 0.98},\n",
       " {'entity_group': 'DATE', 'word': '⟬birth_date#2⟭', 'score': 0.97},\n",
       " {'entity_group': 'DOCTOR', 'word': '⟬person_name:family#4⟭', 'score': 0.93}]"
      ]
     },
     "execution_count": 3,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "[{k: e[k] for k in (\"entity_group\", \"word\", \"score\")} for e in deid(note)]"
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
      "PATIENT   0.97\n",
      "DOCTOR    0.95\n",
      "PHONE     0.99\n",
      "DATE      0.98\n",
      "LOCATION  0.81\n"
     ]
    }
   ],
   "source": [
    "for label, value in span_recall(deid, gold).items():\n",
    "    print(f\"{label:<9} {value:.2f}\")"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Street addresses are the weak spot (0.81): the address in gold note 7 is missed entirely. More address examples in the next fine-tuning round."
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
domain: fintech
appearance: docstring, CSV cell, keyword argument, HTTP header
scenario: Django admin action at a bank that exports monitoring alerts as a suspicious activity report draft and has GPT write the narrative, with a pilot narrative in the docstring
⟬text⟭
"""Admin action: export alerts flagged by the monitoring rules as a SAR draft.

Compliance analysts select alerts in the admin and get a CSV plus a narrative draft.
The narrative is a starting point only; the BSA officer edits and files it.

Narrative produced in the pilot (alert ⟬ticket_id#1⟭):
    Between ⟬date#3⟭ and ⟬date#2⟭, the subject ⟬person_name#1⟭ (SSN ⟬us_ssn#1⟭) made 14 cash
    deposits of $9,000 to $9,800 at three branches, consistent with structuring.
"""
import csv
from io import StringIO

from django.contrib import admin
from django.http import HttpResponse
from openai import OpenAI

from monitoring.models import Alert

client = OpenAI(api_key="⟬openai_api_key#1⟭")

SYSTEM = (
    "You draft the narrative section of a FinCEN suspicious activity report: who, what, "
    "when, where, why and how. Use only facts from the data given. Plain past tense."
)
COLUMNS = ["alert_id", "rule", "subject_name", "subject_tin", "account", "amount", "first_seen", "last_seen"]


@admin.action(description="Export as SAR draft")
def export_sar_draft(modeladmin, request, queryset):
    buf = StringIO()
    writer = csv.writer(buf)
    writer.writerow(COLUMNS)
    facts = []
    for alert in queryset.select_related("account__holder"):
        holder = alert.account.holder
        row = [alert.pk, alert.rule_code, holder.legal_name, holder.tin, alert.account.number,
               alert.total_amount, alert.first_seen, alert.last_seen]
        writer.writerow(row)
        facts.append(dict(zip(COLUMNS, map(str, row))))
    narrative = client.chat.completions.create(
        model="gpt-4o",
        temperature=0.2,
        messages=[{"role": "system", "content": SYSTEM}, {"role": "user", "content": str(facts)}],
    ).choices[0].message.content
    buf.write("\n\nNARRATIVE DRAFT\n" + narrative)
    resp = HttpResponse(buf.getvalue(), content_type="text/csv")
    resp["Content-Disposition"] = 'attachment; filename="sar_draft.csv"'
    return resp


@admin.register(Alert)
class AlertAdmin(admin.ModelAdmin):
    list_display = ("pk", "rule_code", "account", "total_amount", "status")
    list_filter = ("rule_code", "status")
    actions = [export_sar_draft]
⟬end⟭

⟬template⟭
family: code
format: .sh
language: en
fill_locale: en_US
domain: government
appearance: environment variable, log message, comment
scenario: QA lead's morning script sampling scanned passport renewal forms from S3 and diffing OCR'd book numbers against what applicants typed
⟬text⟭
#!/usr/bin/env bash
# ocr_qa_sample.sh: pull 25 random scans of yesterday's DS-82 renewals and diff the OCR'd
# book number against what the applicant typed. Run by the QA lead every morning.
set -euo pipefail
export AWS_ACCESS_KEY_ID=⟬aws_access_key_id#1⟭
export AWS_SECRET_ACCESS_KEY=⟬aws_secret_access_key#1⟭

DAY=$(date -d yesterday +%F)
mkdir -p "qa/$DAY"
aws s3 ls "s3://renewals-scans/$DAY/" | awk '{print $4}' | shuf -n 25 | while read -r f; do
  aws s3 cp "s3://renewals-scans/$DAY/$f" "qa/$DAY/" --only-show-errors
done
python ocr_diff.py "qa/$DAY" | tee "qa/$DAY/report.txt"

# report.txt looks like:
# MISMATCH ⟬order_number#2⟭ typed=⟬us_passport#2⟭ ocr=⟬us_passport#3⟭ applicant=⟬person_name#2⟭
# OK       ⟬order_number#4⟭ typed=⟬us_passport#4⟭
⟬end⟭

⟬template⟭
family: code
format: .sql
language: en
fill_locale: en_US
domain: SaaS
appearance: SQL MERGE, window function, SQL UPDATE, comment
scenario: tax-preparation SaaS data engineer's Snowflake merge of dependents parsed from prior-year returns, with a hand fix after an OCR misread
⟬text⟭
-- merge_dependents.sql (Snowflake)
-- Upserts dependents parsed from the prior-year returns customers upload into the
-- household graph. Dependents are matched on TIN (SSN or ITIN).
MERGE INTO tax.dependents AS d
USING (
    SELECT household_id, dep_name, dep_tin, dep_tin_type, dep_dob, relationship
    FROM tax.stg_prior_year_dependents
    QUALIFY row_number() OVER (PARTITION BY household_id, dep_tin ORDER BY parsed_at DESC) = 1
) AS s
ON d.household_id = s.household_id AND d.tin = s.dep_tin
WHEN MATCHED THEN UPDATE SET
    d.name = s.dep_name,
    d.dob = s.dep_dob,
    d.relationship = s.relationship,
    d.updated_at = current_timestamp()
WHEN NOT MATCHED THEN INSERT (household_id, name, tin, tin_type, dob, relationship, created_at)
    VALUES (s.household_id, s.dep_name, s.dep_tin, s.dep_tin_type, s.dep_dob, s.relationship, current_timestamp());

-- support case ⟬ticket_id#1⟭: two dependents parsed with the same ITIN (OCR misread on a
-- handwritten return), and the refund account was read from the wrong line. Fixed by hand:
UPDATE tax.dependents
SET tin = '⟬us_itin#2⟭'
WHERE household_id = '⟬customer_id#1⟭' AND name = '⟬person_name#2⟭';

UPDATE tax.households
SET refund_account = '⟬bank_account_number#1⟭', refund_routing = '110000000'
WHERE household_id = '⟬customer_id#1⟭';
⟬end⟭

⟬template⟭
family: code
format: .py
language: en
fill_locale: en_US
domain: insurance
appearance: keyword argument, f-string, string literal
scenario: claims adjuster assistant that caches a long policy wording in the system prompt with Claude prompt caching, run from the command line on a test claim
⟬text⟭
"""Adjuster assistant: answers coverage questions against the policy wording.

The 60-page wording goes in a cached system block, so follow-up questions on the
same claim only pay for the new tokens.
"""
from pathlib import Path

import anthropic

client = anthropic.Anthropic(api_key="⟬anthropic_api_key#1⟭")
WORDING = Path("wordings/PAP-2023-07.txt").read_text()


def ask(question: str, claim_context: str, history: list[dict] | None = None) -> str:
    messages = (history or []) + [{"role": "user", "content": f"{claim_context}\n\nQuestion: {question}"}]
    resp = client.messages.create(
        model="claude-sonnet-4-5",
        max_tokens=800,
        system=[
            {"type": "text", "text": "You help auto claims adjusters read the personal auto policy below. Quote the clause you rely on."},
            {"type": "text", "text": WORDING, "cache_control": {"type": "ephemeral"}},
        ],
        messages=messages,
    )
    print(f"cache read {resp.usage.cache_read_input_tokens}, written {resp.usage.cache_creation_input_tokens}")
    return resp.content[0].text


if __name__ == "__main__":
    context = (
        "Claim ⟬order_number#1⟭. Insured vehicle ⟬us_license_plate#1⟭, driven by the insured's nephew "
        "⟬person_name#2m⟭ (not listed on the policy) when it hit a parked car, plate ⟬us_license_plate#3⟭."
    )
    print(ask("Is the nephew covered as a permissive user?", context))
⟬end⟭

⟬template⟭
family: code
format: .py
language: en
fill_locale: en_US
domain: retail
appearance: function call, nested JSON, comment
scenario: AWS Glue job loading a marketplace partner's web orders into the lake, reading the partner bucket with an access key set in the Hadoop configuration
⟬text⟭
"""Glue job: load yesterday's web orders from the marketplace partner into the lake.

The orders bucket lives in the partner's AWS account; we read it with the access key
they issued, since their side has no cross-account role for us yet.
"""
import sys

from awsglue.context import GlueContext
from awsglue.job import Job
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from pyspark.sql import functions as F

args = getResolvedOptions(sys.argv, ["JOB_NAME", "ds"])
sc = SparkContext()
glue = GlueContext(sc)
spark = glue.spark_session
job = Job(glue)
job.init(args["JOB_NAME"], args)

hconf = sc._jsc.hadoopConfiguration()
hconf.set("fs.s3a.bucket.partner-orders-export.access.key", "⟬aws_access_key_id#1⟭")
hconf.set("fs.s3a.bucket.partner-orders-export.secret.key", "⟬aws_secret_access_key#1⟭")

orders = spark.read.json(f"s3a://partner-orders-export/orders/dt={args['ds']}/")
# one record, for the schema:
# {"order_id": "⟬order_number#2⟭", "buyer": {"name": "⟬person_name#2⟭", "email": "⟬email#2⟭"},
#  "ship_to": {"line1": "⟬postal_address:street#2⟭", "city": "⟬city#2⟭", "zip": "⟬postcode#2⟭"},
#  "items": [{"sku": "PT-0331", "qty": 2, "price": 24.99}], "placed_at": "⟬date#1⟭"}

flat = (
    orders.select(
        "order_id",
        "placed_at",
        F.col("buyer.email").alias("buyer_email"),
        F.col("ship_to.zip").alias("ship_zip"),
        F.explode("items").alias("item"),
    )
    .select("order_id", "placed_at", F.sha2("buyer_email", 256).alias("buyer_hash"), "ship_zip", "item.sku", "item.qty", "item.price")
)
flat.write.mode("overwrite").parquet(f"s3://lake-curated/partner_orders/dt={args['ds']}/")
job.commit()
⟬end⟭

⟬template⟭
family: code
format: .ipynb
language: en
fill_locale: en_US
domain: fintech
appearance: notebook output, keyword argument, markdown cell, free text
scenario: AML analyst's notebook testing whether GPT can flag suspicious wire memos, with a sample of wires printed with account numbers and beneficiaries
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Wire memo screening with GPT\n",
    "Can an LLM flag memos worth a second look (crypto, gift cards, \"investment\" sent to individuals) before the rules engine does?"
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
       "       originator_acct        beneficiary    amount  memo\n",
       "118   ⟬bank_account_number#2⟭  ⟬person_name#3⟭   4500.00  investment opportunity per our call\n",
       "940   ⟬bank_account_number#4⟭  ⟬company#5⟭  12800.00  INV ⟬invoice_number#1⟭\n",
       "77    ⟬bank_account_number#2⟭  ⟬person_name#3⟭   4500.00  2nd part, as discussed w/ ⟬person_name:given#6⟭\n",
       "1502  ⟬bank_account_number#7⟭  ⟬person_name#8⟭    900.00  rent march\n",
       "233   ⟬bank_account_number#9⟭  ⟬company#10⟭   2200.00  btc purchase"
      ]
     },
     "execution_count": 1,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "import json\n",
    "\n",
    "import ⟬trap:library|pandas⟭ as pd\n",
    "from openai import OpenAI\n",
    "\n",
    "client = OpenAI(api_key=\"⟬openai_api_key#1⟭\")\n",
    "wires =pd.read_parquet(\"⟬file_path#1⟭\")\n",
    "wires.sample(5, random_state=3)[[\"originator_acct\", \"beneficiary\", \"amount\", \"memo\"]]"
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
       "flag\n",
       "False    1873\n",
       "True      214\n",
       "dtype: int64"
      ]
     },
     "execution_count": 2,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "SCHEMA = {\"type\": \"json_schema\", \"json_schema\": {\"name\": \"flag\", \"schema\": {\n",
    "    \"type\": \"object\", \"properties\": {\"flag\": {\"type\": \"boolean\"}, \"reason\": {\"type\": \"string\"}},\n",
    "    \"required\": [\"flag\", \"reason\"], \"additionalProperties\": False}, \"strict\": True}}\n",
    "\n",
    "def flag(memo: str) -> bool:\n",
    "    resp = client.chat.completions.create(\n",
    "        model=\"gpt-4o-mini\",\n",
    "        response_format=SCHEMA,\n",
    "        messages=[{\"role\": \"system\", \"content\": \"Flag wire memos that suggest investment fraud, crypto purchases, gift cards or romance scams.\"},\n",
    "                  {\"role\": \"user\", \"content\": memo}],\n",
    "    )\n",
    "    return json.loads(resp.choices[0].message.content)[\"flag\"]\n",
    "\n",
    "wires[\"flag\"] = wires[\"memo\"].fillna(\"\").map(flag)\n",
    "wires[\"flag\"].value_counts()"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Precision 0.41 at recall 0.88 against analyst dispositions. Too noisy on its own; worth trying as one feature of the alert model."
   ]
  }
 ],
 "metadata": {
  "kernelspec": {"display_name": "Python 3", "language": "python", "name": "python3"},
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
domain: healthcare
appearance: environment variable, heredoc, curl command, comment
scenario: ML platform engineer's script serving a private clinical summarizer with text-generation-inference, smoke-tested with the note from a bug report
⟬text⟭
#!/usr/bin/env bash
# serve_tgi.sh: run the private clinical summarizer with text-generation-inference on the GPU node,
# then a smoke test with the note from ⟬ticket_id#1⟭ (the summary echoed the SSN back).
set -euo pipefail
MODEL=clinical-nlp/summarizer-8b-v2

docker run -d --gpus all --shm-size 1g -p 8080:80 \
  -e HF_TOKEN=⟬huggingface_token#1⟭ \
  -v /data/tgi:/data \
  --name tgi ghcr.io/huggingface/text-generation-inference:⟬version#1⟭ \
  --model-id "$MODEL" --max-input-tokens 6000 --max-total-tokens 7000

until curl -fs localhost:8080/health >/dev/null; do sleep 5; done

curl -s localhost:8080/generate -H 'Content-Type: application/json' -d @- <<'JSON' | jq -r .generated_text
{
  "inputs": "Summarize: Pt ⟬person_name#2⟭, SSN ⟬us_ssn#2⟭, DOB ⟬birth_date#2⟭, admitted for CHF exacerbation, diuresed 4 L, discharged on furosemide 40 mg daily.",
  "parameters": {"max_new_tokens": 120}
}
JSON
⟬end⟭

⟬template⟭
family: code
format: .py
language: en
fill_locale: en_US
domain: government
appearance: assertion, string literal, keyword argument, test fixture
scenario: FastAPI pilot of a consular services assistant on Claude that redacts passport and SSN numbers first, tested on a message from the pilot transcripts
⟬text⟭
"""Consular services assistant (pilot): questions about renewing a passport by mail.

Passport and SSN numbers are replaced with placeholders before anything reaches the
model; the test below uses a message from the pilot transcripts.
"""
import re

from anthropic import Anthropic
from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI(title="consular-assistant")
claude = Anthropic(api_key="⟬anthropic_api_key#1⟭")

PATTERNS = {
    "[PASSPORT]": re.compile(r"\b[A-Z]?\d{8,9}\b"),
    "[SSN]": re.compile(r"\b\d{3}-\d{2}-\d{4}\b"),
}
⟬trap:indicator_non_pii|SYSTEM_PROMPT_NAME = "consular-faq-v4"⟭
SYSTEM_PROMPT = (
    "Answer questions about renewing a U.S. passport by mail (form DS-82). If the question is "
    "about a specific application, tell the user to call the passport information center."
)


def redact(text: str) -> str:
    for token, pattern in PATTERNS.items():
        text = pattern.sub(token, text)
    return text


class Question(BaseModel):
    session_id: str
    text: str


@app.post("/ask")
def ask(q: Question):
    msg = claude.messages.create(
        model="claude-haiku-4-5",
        max_tokens=500,
        system=SYSTEM_PROMPT,
        messages=[{"role": "user", "content": redact(q.text)}],
        metadata={"user_id": q.session_id},
    )
    return {"answer": msg.content[0].text, "prompt": SYSTEM_PROMPT_NAME}


def test_redact_pilot_message():
    raw = "hi my name is ⟬person_name#2⟭, my old passport ⟬us_passport#2⟭ expired ⟬date#2⟭, can i still renew by mail?"
    out = redact(raw)
    assert "⟬us_passport#2⟭" not in out
    assert out.count(⟬trap:placeholder|"[PASSPORT]"⟭) == 1
⟬end⟭

⟬template⟭
family: code
format: .sql
language: en
fill_locale: en_US
domain: retail
appearance: SQL string, comment, window function
scenario: loss-prevention analyst's Redshift load of a vendor's incident exports with inline IAM user credentials, followed by a repeat-vehicle query for organized retail crime
⟬text⟭
-- lp_incidents_load.sql (Redshift)
-- Daily load of loss-prevention incident exports from the case-management vendor.
-- Their bucket is in their account and they gave us an IAM user instead of a role.
COPY lp.incidents_stage
FROM 's3://lp-vendor-exports/incidents/'
CREDENTIALS 'aws_access_key_id=⟬aws_access_key_id#1⟭;aws_secret_access_key=⟬aws_secret_access_key#1⟭'
FORMAT AS JSON 'auto'
TIMEFORMAT 'auto'
REGION 'us-east-2';

INSERT INTO lp.incidents SELECT * FROM lp.incidents_stage;
TRUNCATE lp.incidents_stage;

-- vehicles seen at three or more stores in the last 90 days (ORC ring detection)
SELECT suspect_vehicle_plate,
       count(DISTINCT store_id) AS stores,
       count(*)                 AS incidents,
       sum(loss_amount)         AS total_loss,
       listagg(DISTINCT store_id, ',') WITHIN GROUP (ORDER BY store_id) AS store_list
FROM lp.incidents
WHERE incident_at >= dateadd(day, -90, current_date)
  AND suspect_vehicle_plate IS NOT NULL
GROUP BY suspect_vehicle_plate
HAVING count(DISTINCT store_id) >= 3
ORDER BY total_loss DESC;

-- shared with the regional task force on ⟬date#1⟭: ⟬us_license_plate#2⟭, ⟬us_license_plate#3⟭
⟬end⟭

⟬template⟭
family: code
format: .py
language: en
fill_locale: en_US
domain: government
appearance: docstring, nested JSON, class attribute
scenario: FastAPI tracker used by certifying acceptance agents to record ITIN assignments from IRS notices, with an example response in the module docstring
⟬text⟭
"""ITIN application tracker for Certifying Acceptance Agents.

CAAs submit W-7 packages for applicants; the IRS mails the CP565 notice with the
assigned ITIN to the applicant, who brings it back, and the agent records it here.

GET /applications/{id} example response:

    {"id": "⟬customer_id#1⟭", "applicant": "⟬person_name#1⟭", "status": "assigned",
     "itin": "⟬us_itin#1⟭", "notice": "CP565", "notice_date": "⟬date#1⟭",
     "mailing_address": "⟬postal_address#1⟭"}
"""
from datetime import date
from enum import Enum

from fastapi import FastAPI, HTTPException
from pydantic import BaseModel, field_validator

app = FastAPI(title="caa-tracker")


class Status(str, Enum):
    prepared = "prepared"
    mailed = "mailed"
    assigned = "assigned"
    rejected = "rejected"  # CP567


class Application(BaseModel):
    id: str
    applicant: str
    status: Status
    itin: str | None = None
    notice: str | None = None
    notice_date: date | None = None
    mailing_address: str

    @field_validator("itin")
    @classmethod
    def itin_shape(cls, value):
        digits = (value or "").replace("-", "")
        if value and not (len(digits) == 9 and digits.startswith("9")):
            raise ValueError("an ITIN is 9 digits starting with 9")
        return value


DB: dict[str, Application] = {}


@app.get("/applications/{app_id}")
def get_application(app_id: str) -> Application:
    if app_id not in DB:
        raise HTTPException(status_code=404)
    return DB[app_id]


@app.post("/applications/{app_id}/notice")
def record_notice(app_id: str, notice: str, notice_date: date, itin: str | None = None) -> Application:
    application = get_application(app_id)
    application.notice, application.notice_date, application.itin = notice, notice_date, itin
    application.status = Status.assigned if notice == "CP565" else Status.rejected
    return application
⟬end⟭

⟬template⟭
family: code
format: .py
language: en
fill_locale: en_US
domain: insurance
appearance: keyword argument, comment, docstring
scenario: Django model splitting a total-loss payout between the lienholder and the insured, with a regression test built from a claim that paid the insured by mistake
⟬text⟭
from decimal import Decimal

from django.db import models
from django.test import TestCase


class TotalLossSettlement(models.Model):
    """Payout of a totaled vehicle: the lienholder is paid first, the insured gets the rest."""

    claim = models.OneToOneField("claims.Claim", on_delete=models.PROTECT)
    plate = models.CharField(max_length=10)
    acv = models.DecimalField(max_digits=10, decimal_places=2)  # actual cash value
    deductible = models.DecimalField(max_digits=8, decimal_places=2)
    loan_payoff = models.DecimalField(max_digits=10, decimal_places=2, default=Decimal("0"))
    lienholder_account = models.CharField(max_length=17, blank=True)
    insured_account = models.CharField(max_length=17, blank=True)

    def split(self) -> tuple[Decimal, Decimal]:
        net = self.acv - self.deductible
        to_lender = min(net, self.loan_payoff)
        return to_lender, net - to_lender


class SettlementSplitTests(TestCase):
    # numbers from claim ⟬order_number#1⟭ (⟬person_name#1⟭, 2017 sedan), which paid the insured by mistake
    def test_upside_down_loan_pays_the_lender_only(self):
        settlement = TotalLossSettlement(
            plate="⟬us_license_plate#1⟭",
            acv=Decimal("14200"),
            deductible=Decimal("500"),
            loan_payoff=Decimal("16950.40"),
            lienholder_account="⟬bank_account_number#2⟭",
            insured_account="⟬bank_account_number#1⟭",
        )
        self.assertEqual(settlement.split(), (Decimal("13700"), Decimal("0")))

    def test_no_loan_pays_the_insured(self):
        settlement = TotalLossSettlement(acv=Decimal("9000"), deductible=Decimal("1000"))
        self.assertEqual(settlement.split(), (Decimal("0"), Decimal("8000")))
⟬end⟭

⟬template⟭
family: code
format: .sql
language: en
fill_locale: en_US
domain: healthcare
appearance: command-line argument, SQL WHERE, pipe-delimited record, comment
scenario: cancer registry data manager's monthly load of the registry extract into staging with the data quality checks the registrar asked for
⟬text⟭
-- load_registry_patients.sql
-- Monthly load of the cancer registry extract (pipe-delimited) into staging,
-- then the data quality checks the registrar asked for.
\copy registry_stage.patients (registry_id, last_name, first_name, ssn, dob, street, city, zip, dx_date, site_code) FROM 'extract.psv' WITH (FORMAT csv, DELIMITER '|', HEADER true)

-- 1. SSNs that cannot be valid (area 000, 666 or 9xx, group 00, serial 0000)
SELECT registry_id, ssn
FROM registry_stage.patients
WHERE ssn !~ '^[0-9]{9}$'
   OR left(ssn, 3) IN ('000', '666')
   OR left(ssn, 1) = '9'
   OR substr(ssn, 4, 2) = '00'
   OR right(ssn, 4) = '0000';

-- 2. diagnosis before birth
SELECT registry_id, dob, dx_date
FROM registry_stage.patients
WHERE dx_date < dob;

-- last month's failing line, kept for the registrar:
-- ⟬customer_id#1⟭|⟬person_name:family#1⟭|⟬person_name:given#1⟭|⟬us_ssn#1⟭|⟬birth_date#1⟭|⟬postal_address:street#1⟭|⟬city#1⟭|⟬postcode#1⟭|⟬date#1⟭|C50.9
⟬end⟭

⟬template⟭
family: code
format: .ipynb
language: en
fill_locale: en_US
domain: government
appearance: notebook output, keyword argument, markdown cell
scenario: taxpayer assistance pilot notebook rewriting IRS ITIN notices in plain English and Spanish with OpenAI, printing the start of a scanned notice
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Plain-language IRS notices (taxpayer assistance pilot)\n",
    "Rewrite CP565 and CP567 notices in plain English and Spanish for ITIN applicants who bring them to the assistance center."
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
      "Department of the Treasury\n",
      "Internal Revenue Service                     Notice CP565\n",
      "                                             Notice date ⟬date#1⟭\n",
      "⟬person_name#2⟭\n",
      "⟬postal_address#2⟭\n",
      "\n",
      "We assigned you an Individual Taxpayer Identification Number (ITIN)\n",
      "Your ITIN: ⟬us_itin#2⟭\n",
      "Keep this notice in a safe place. Use your ITIN on your federal tax returns...\n"
     ]
    }
   ],
   "source": [
    "from openai import OpenAI\n",
    "\n",
    "client = OpenAI(api_key=\"⟬openai_api_key#1⟭\")\n",
    "letter = open(\"⟬file_path#1⟭\").read()\n",
    "print(letter[:420])"
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
      "EN: You now have a tax ID number (ITIN). Use it on your tax return in place of a Social Security number. Keep this letter safe.\n",
      "ES: Ahora tiene un número de identificación de contribuyente (ITIN). Úselo en su declaración de impuestos. Guarde esta carta.\n"
     ]
    }
   ],
   "source": [
    "SYSTEM = \"Rewrite this IRS notice at a 6th grade reading level, first in English then in Spanish, two sentences each. Do not repeat any number from the notice.\"\n",
    "resp = client.chat.completions.create(\n",
    "    model=\"gpt-4o\",\n",
    "    messages=[{\"role\": \"system\", \"content\": SYSTEM}, {\"role\": \"user\", \"content\": letter}],\n",
    ")\n",
    "print(resp.choices[0].message.content)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "In 3 of 20 notices the model copied the ITIN into the summary despite the instruction. Mask it before the call, not after."
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
format: .ipynb
language: en
fill_locale: en_US
domain: government
appearance: notebook output, keyword argument, markdown cell
scenario: document processing team's notebook comparing Claude with a small Hugging Face model at parsing passport data pages, showing one field-by-field comparison
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Passport data page parsing: Claude vs a small fine-tuned model\n",
    "Input: OCR text of the data page from renewal scans. 500 pages with keyed truth."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "metadata": {},
   "outputs": [],
   "source": [
    "import anthropic\n",
    "from huggingface_hub import InferenceClient\n",
    "\n",
    "claude = anthropic.Anthropic(api_key=\"⟬anthropic_api_key#1⟭\")\n",
    "small = InferenceClient(model=\"docs-ai/passport-t5-small\", token=\"⟬huggingface_token#1⟭\")"
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
       "                       truth             claude              small\n",
       "surname      ⟬person_name:family#2⟭  ⟬person_name:family#2⟭  ⟬person_name:family#2⟭\n",
       "given_names  ⟬person_name:given#2⟭  ⟬person_name:given#2⟭  ⟬person_name:given#2⟭\n",
       "passport_no  ⟬us_passport#2⟭  ⟬us_passport#2⟭  ⟬us_passport#4⟭\n",
       "birth_date   ⟬birth_date#2⟭  ⟬birth_date#2⟭  ⟬birth_date#2⟭\n",
       "issue_date   ⟬date#1⟭  ⟬date#1⟭  ⟬date#1⟭"
      ]
     },
     "execution_count": 2,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "row = pages[118]\n",
    "compare_fields(row.truth, parse_with_claude(claude, row.ocr), parse_with_small(small, row.ocr))"
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
      "exact match  claude 0.991  small 0.964\n",
      "cost / 1k    claude $4.10  small $0.10\n"
     ]
    }
   ],
   "source": [
    "summary = evaluate(pages, claude, small)\n",
    "print(f\"exact match  claude {summary.claude_em:.3f}  small {summary.small_em:.3f}\")\n",
    "print(f\"cost / 1k    claude ${summary.claude_cost:.2f}  small ${summary.small_cost:.2f}\")"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "The check digit catches most of the small model's errors (row 118: one digit off). Plan: small model + check-digit validation, Claude as the fallback."
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
appearance: assignment, nested dict, comment
scenario: Django test settings of a SaaS backend with fast hashers, in-memory backends and obvious placeholder keys
⟬text⟭
"""Settings for the test suite: fast hashers, in-memory email and cache, no external calls."""
import os

from .base import *  # noqa: F401,F403

DEBUG = False
SECRET_KEY = ⟬trap:placeholder|"test-only-not-a-secret"⟭
⟬trap:indicator_non_pii|PASSWORD_HASHERS = ["django.contrib.auth.hashers.MD5PasswordHasher"]⟭  # speed, tests only
EMAIL_BACKEND = "django.core.mail.backends.locmem.EmailBackend"

DATABASES = {
    "default": {
        "ENGINE": "django.db.backends.postgresql",
        "NAME": "app_test",
        ⟬trap:indicator_non_pii|"USER": "postgres"⟭,
        "PASSWORD": ⟬trap:placeholder|os.environ.get("TEST_DB_PASSWORD", "")⟭,
        "HOST": "localhost",
        "PORT": "5432",
    }
}
CACHES = {"default": {"BACKEND": "django.core.cache.backends.locmem.LocMemCache"}}

CELERY_TASK_ALWAYS_EAGER = True
OPENAI_API_KEY = ⟬trap:placeholder|"sk-test-xxxxxxxxxxxx"⟭
STRIPE_SECRET_KEY = ⟬trap:placeholder|"sk_test_placeholder"⟭
⟬trap:indicator_non_pii|AUTH_TOKEN_TTL_SECONDS = 60⟭

LOGGING = {"version": 1, "disable_existing_loggers": True, "handlers": {}, "root": {"level": "CRITICAL"}}
⟬end⟭

⟬template⟭
family: code
format: .sql
language: en
fill_locale: en_US
domain: healthcare
appearance: comment, CTE, function call
scenario: ED operations analyst's query of door-to-provider times by arrival hour and acuity, estimating census with Little's law
⟬text⟭
-- ed_wait_by_hour.sql
-- Door-to-provider time in the ED by arrival hour and acuity, last 8 weeks.
-- Average census by hour comes from ⟬trap:eponym|Little⟭'s law (L = lambda * W): we have
-- arrivals and length of stay but no hourly snapshot table.
WITH visits AS (
    SELECT v.encounter_id,
           v.esi_level,
           extract(hour FROM v.arrived_at)::int                       AS arrival_hour,
           extract(epoch FROM v.provider_seen_at - v.arrived_at) / 60.0 AS door_to_provider_min,
           extract(epoch FROM v.departed_at - v.arrived_at) / 3600.0    AS los_hours
    FROM ed.visits v
    WHERE v.arrived_at >= current_date - interval '8 weeks'
      AND v.provider_seen_at IS NOT NULL
      AND ⟬trap:indicator_non_pii|v.patient_name NOT LIKE 'ZZTEST%'⟭
)
SELECT arrival_hour,
       esi_level,
       count(*)                                                                 AS arrivals,
       percentile_cont(0.5) WITHIN GROUP (ORDER BY door_to_provider_min)        AS p50_min,
       percentile_cont(0.9) WITHIN GROUP (ORDER BY door_to_provider_min)        AS p90_min,
       round((count(*) / 56.0 * avg(los_hours))::numeric, 1)                    AS avg_census
FROM visits
GROUP BY arrival_hour, esi_level
ORDER BY arrival_hour, esi_level;
⟬end⟭

⟬template⟭
family: code
format: .ipynb
language: en
fill_locale: en_US
domain: fintech
appearance: notebook output, markdown cell, function call
scenario: credit risk modeler's out-of-time backtest of a logistic scorecard, with discrimination metrics and a decile table and no applicant fields
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Scorecard v7 backtest\n",
    "Logistic regression on WoE-binned features, out-of-time sample: applications from ⟬date#2⟭ to ⟬date#1⟭."
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
       "(84210, 31)"
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
    "from scipy.stats import ks_2samp\n",
    "from sklearn.metrics import roc_auc_score\n",
    "\n",
    "from risk.binning import ⟬trap:code_identifier|⦃family⦄_monotone_bins⟭\n",
    "from risk.scorecard import load_scorecard\n",
    "\n",
    "oot = pd.read_parquet(\"⟬file_path#1⟭\")\n",
    "oot.shape"
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
      "AUC 0.781  Gini 0.562  KS 0.431\n",
      "decile  bad_rate  cum_bad_share\n",
      "     1     0.214          0.338\n",
      "     2     0.121          0.529\n",
      "     3     0.083          0.660\n",
      "    10     0.006          1.000\n"
     ]
    }
   ],
   "source": [
    "card = load_scorecard(\"v7\")\n",
    "oot[\"score\"] = card.score(oot)\n",
    "auc = roc_auc_score(oot.bad_12m, -oot.score)\n",
    "ks = ks_2samp(oot.score[oot.bad_12m == 1], oot.score[oot.bad_12m == 0]).statistic\n",
    "print(f\"AUC {auc:.3f}  Gini {2 * auc - 1:.3f}  KS {ks:.3f}\")\n",
    "print(decile_table(oot, \"score\", \"bad_12m\").iloc[[0, 1, 2, -1]].to_string(index=False))"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "⟬trap:eponym|Kolmogorov-Smirnov⟭ 0.43 vs 0.41 for v6 on the same window; top decile captures a third of bads. Ready for model risk review."
   ]
  }
 ],
 "metadata": {
  "kernelspec": {"display_name": "risk (py3.10)", "language": "python", "name": "risk"},
  "language_info": {"name": "python", "version": "3.10.14"}
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
appearance: environment variable, command-line argument, comment
scenario: open-data team's script rebuilding the city's dataset catalog site and syncing it to the public bucket, with an allowlist note about tree species names
⟬text⟭
#!/usr/bin/env bash
# publish_open_data.sh: rebuild the open-data catalog site and push it to the public bucket.
# Datasets are aggregated upstream; nothing row-level about residents is published.
set -euo pipefail
export ⟬trap:indicator_non_pii|SITE_OWNER=open-data-team⟭

# street_trees.csv species names (⟬trap:word_name|Hazel⟭, ⟬trap:word_name|Laurel⟭, ⟬trap:word_name|Linden⟭)
# trip the PII scanner, hence the allowlist
python -m catalog.validate datasets/ --allowlist config/pii_allowlist.txt
python -m catalog.build --source datasets/ --out site/ --base-url "⟬url#1⟭"
python -m catalog.check_links site/

aws s3 sync site/ s3://open-data-portal-public/ --delete --cache-control max-age=300   # deploy role, no keys here
aws cloudfront create-invalidation --distribution-id "$CF_DISTRIBUTION" --paths '/*' >/dev/null
echo "published $(find site -name '*.html' | wc -l) pages, catalog ⟬version#1⟭"
⟬end⟭

⟬template⟭
family: code
format: .py
language: en
fill_locale: en_US
domain: retail
appearance: docstring, function, assignment
scenario: pricing scientist's own-price elasticity estimates per SKU and store cluster for the markdown optimizer
⟬text⟭
"""Own-price elasticity estimates for the markdown optimizer.

Log-log regression of weekly units on price per SKU and store cluster, with week-of-year
fixed effects. A constant-elasticity (⟬trap:eponym|Cobb-Douglas⟭ style) demand curve is
assumed, which holds well enough over the 10-30% markdown range we price in.
"""
import numpy as np
import pandas as pd
import statsmodels.formula.api as smf

MIN_WEEKS = 26
ELASTICITY_BOUNDS = (-6.0, -0.1)


def estimate(sales: pd.DataFrame) -> pd.DataFrame:
    """sales: sku, cluster, week, units, price. One elasticity per sku and cluster."""
    out = []
    for (sku, cluster), grp in sales.groupby(["sku", "cluster"]):
        if grp["week"].nunique() < MIN_WEEKS or grp["price"].nunique() < 3:
            continue
        grp = grp.assign(
            log_q=np.log1p(grp["units"]),
            log_p=np.log(grp["price"]),
            woy=grp["week"].dt.isocalendar().week,
        )
        fit = smf.ols("log_q ~ log_p + C(woy)", data=grp).fit()
        out.append({
            "sku": sku,
            "cluster": cluster,
            "elasticity": float(np.clip(fit.params["log_p"], *ELASTICITY_BOUNDS)),
            "se": float(fit.bse["log_p"]),
            "weeks": len(grp),
        })
    return pd.DataFrame(out)


def markdown_units(base_units: float, elasticity: float, markdown_pct: float) -> float:
    """Expected units after a markdown, under constant elasticity."""
    return base_units * (1 - markdown_pct) ** elasticity
⟬end⟭
