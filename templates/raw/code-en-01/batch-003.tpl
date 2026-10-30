⟬template⟭
family: code
format: .py
language: en
fill_locale: en_US
domain: retail
appearance: keyword argument, test fixture, query string, comment
scenario: Django REST Framework view letting POS terminals look up loyalty members by phone, with an APITestCase that creates a member in setUp
⟬text⟭
"""Loyalty member lookup for the POS.

Cashiers search by phone number (what customers remember) and get the member's
tier and points. The birthday reward unlocks during the birth month.
"""
from datetime import date

from django.db.models import Q
from rest_framework import serializers, status
from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response
from rest_framework.test import APITestCase

from loyalty.models import Member
from loyalty.permissions import IsPosTerminal
from loyalty.phone import normalize_phone

# manual check from a store laptop:
#   curl -H "X-POS-Terminal: $TERMINAL_KEY" "https://⟬hostname#1⟭/api/loyalty/lookup?phone=⟬phone#2⟭"


class MemberSerializer(serializers.ModelSerializer):
    birthday_reward = serializers.SerializerMethodField()

    class Meta:
        model = Member
        fields = ["member_id", "first_name", "last_name", "tier", "points", "birthday_reward"]

    def get_birthday_reward(self, member) -> bool:
        return member.birth_date is not None and member.birth_date.month == date.today().month


@api_view(["GET"])
@permission_classes([IsPosTerminal])
def lookup(request):
    phone = normalize_phone(request.query_params.get("phone", ""))
    if not phone:
        return Response({"detail": "phone is required"}, status=status.HTTP_400_BAD_REQUEST)
    members = Member.objects.filter(Q(phone=phone) | Q(alt_phone=phone), active=True)[:5]
    return Response(MemberSerializer(members, many=True).data)


class LookupTests(APITestCase):
    def setUp(self):
        self.member = Member.objects.create(
            member_id="⟬customer_id#1⟭",
            first_name="⟬person_name:given#1⟭",
            last_name="⟬person_name:family#1⟭",
            email="⟬email#1⟭",
            phone=normalize_phone("⟬phone#1⟭"),
            birth_date="⟬birth_date#1⟭",
            mailing_address="⟬postal_address#1⟭",
            tier="gold",
            points=1840,
        )
        self.client.credentials(HTTP_X_POS_TERMINAL="⟬opaque_token#1⟭")

    def test_lookup_by_phone(self):
        resp = self.client.get("/api/loyalty/lookup", {"phone": "⟬phone#1⟭"})
        self.assertEqual(resp.status_code, 200)
        self.assertEqual(resp.json()[0]["last_name"], "⟬person_name:family#1⟭")

    def test_missing_phone_is_400(self):
        self.assertEqual(self.client.get("/api/loyalty/lookup").status_code, 400)
⟬end⟭

⟬template⟭
family: code
format: .ipynb
language: en
fill_locale: en_US
domain: healthcare
appearance: notebook output, keyword argument, markdown cell
scenario: clinical analytics notebook scoring readmission risk zero-shot with a model on a private Hugging Face Inference Endpoint, showing the cardiology discharge cohort
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Readmission risk from discharge notes, zero-shot\n",
    "Uses the private Inference Endpoint the platform team stood up. Cohort: last 30 days of cardiology discharges."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "metadata": {},
   "outputs": [],
   "source": [
    "import ⟬trap:library|pandas⟭ as pd\n",
    "from huggingface_hub import InferenceClient\n",
    "from sqlalchemy import create_engine\n",
    "\n",
    "client = InferenceClient(model=\"⟬url#1⟭\", token=\"⟬huggingface_token#1⟭\")\n",
    "engine = create_engine(\"postgresql://⟬hostname#1⟭/clinical_dw\")"
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
       "              patient         dob    discharged  los      dx\n",
       "0  ⟬person_name#2⟭  ⟬birth_date#2⟭  ⟬date#1⟭    6  I50.23\n",
       "1  ⟬person_name#3⟭  ⟬birth_date#3⟭  ⟬date#2⟭    3  I48.91\n",
       "2  ⟬person_name#4⟭  ⟬birth_date#4⟭  ⟬date#2⟭    9   I21.4"
      ]
     },
     "execution_count": 2,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "cohort = pd.read_sql(\"SELECT patient, dob, discharged, los, dx, note FROM cardiology_discharges_30d\", engine)\n",
    "cohort.drop(columns=\"note\").head(3)"
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
      "⟬person_name#2⟭: HIGH\n",
      "⟬person_name#3⟭: LOW\n",
      "⟬person_name#4⟭: HIGH\n"
     ]
    }
   ],
   "source": [
    "PROMPT = \"Discharge note:\\n{note}\\n\\nRisk of readmission within 30 days (LOW, MEDIUM or HIGH):\"\n",
    "\n",
    "for row in cohort.head(3).itertuples():\n",
    "    risk = client.text_generation(PROMPT.format(note=row.note), max_new_tokens=4).strip()\n",
    "    print(f\"{row.patient}: {risk}\")"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Agreement with the LACE score is 0.58 on the full cohort, no better than LACE alone. Parking this."
   ]
  }
 ],
 "metadata": {
  "kernelspec": {"display_name": "Python 3", "language": "python", "name": "python3"},
  "language_info": {"name": "python", "version": "3.11.7"}
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
appearance: docstring, CSV cell, keyword argument, assignment
scenario: data engineer's PySpark job reconciling payroll deposits with employer files, asking an LLM to canonicalize employer names, with a raw employer row in the docstring
⟬text⟭
"""Reconcile payroll direct deposits against the employer files.

Employer files spell the same employer twenty different ways ("ACME CORP",
"Acme Corporation", "ACME CORP PAYROLL"). We ask an LLM once per new raw name and
keep the canonical name in ref.employer_alias.

Employer file row (CSV, no header), as received:

    ⟬us_ssn#1⟭,"⟬person_name#1⟭",⟬company#1⟭ PAYROLL,2450.18,⟬date#1⟭
"""
import json
import os

from openai import OpenAI
from pyspark.sql import SparkSession
from pyspark.sql import functions as F

spark = SparkSession.builder.appName("payroll-recon").getOrCreate()
llm = OpenAI(api_key=os.environ.get("OPENAI_API_KEY") or "⟬openai_api_key#1⟭")

EMPLOYER_SCHEMA = "ssn STRING, employee STRING, employer_raw STRING, amount DECIMAL(12,2), pay_date DATE"


def canonical_employers(raw_names: list[str]) -> dict[str, str]:
    resp = llm.chat.completions.create(
        model="gpt-4o-mini",
        response_format={"type": "json_object"},
        messages=[
            {"role": "system", "content": "Map each raw payroll descriptor to a canonical employer name. Reply with a JSON object raw -> canonical."},
            {"role": "user", "content": json.dumps(raw_names)},
        ],
    )
    return json.loads(resp.choices[0].message.content)


def run(employer_path: str, ledger_table: str, out_table: str) -> None:
    employer = spark.read.csv(employer_path, schema=EMPLOYER_SCHEMA)
    alias = spark.table("ref.employer_alias")
    new_raw = [r.employer_raw for r in employer.select("employer_raw").distinct().join(alias, "employer_raw", "left_anti").collect()]
    if new_raw:
        mapping = canonical_employers(new_raw)
        spark.createDataFrame(list(mapping.items()), "employer_raw STRING, employer STRING") \
            .write.mode("append").saveAsTable("ref.employer_alias")
        alias = spark.table("ref.employer_alias")

    ledger = spark.table(ledger_table).where(F.col("txn_type") == "ACH_CREDIT").alias("l")
    emp = employer.join(alias, "employer_raw").alias("e")
    matched = emp.join(
        ledger,
        (F.col("e.ssn") == F.col("l.customer_ssn"))
        & (F.col("e.amount") == F.col("l.amount"))
        & (F.abs(F.datediff(F.col("e.pay_date"), F.col("l.posted_on"))) <= 2),
        "left",
    ).withColumn("status", F.when(F.col("l.txn_id").isNull(), "missing").otherwise("matched"))

    matched.select("e.ssn", "e.employee", "e.employer", "e.amount", "e.pay_date", "l.txn_id", "status") \
        .write.mode("overwrite").saveAsTable(out_table)
⟬end⟭

⟬template⟭
family: code
format: .sh
language: en
fill_locale: en_US
domain: government
appearance: environment variable, command-line argument, comment
scenario: developer's script restoring the nightly masked snapshot of a passport operations database to a dev box, with a leak check added after a snapshot came out unmasked
⟬text⟭
#!/usr/bin/env bash
# restore_snapshot.sh: restore last night's masked snapshot of the passport-ops DB on the dev box.
# Snapshots are supposed to be masked. The one of ⟬date#1⟭ was not (⟬ticket_id#1⟭), hence the check below.
set -euo pipefail
export AWS_ACCESS_KEY_ID="⟬aws_access_key_id#1⟭"
export AWS_SECRET_ACCESS_KEY="⟬aws_secret_access_key#1⟭"

SNAP=$(aws s3 ls s3://ppt-ops-snapshots/masked/ | sort | tail -1 | awk '{print $4}')
aws s3 cp "s3://ppt-ops-snapshots/masked/$SNAP" /tmp/
dropdb --if-exists pptops_dev && createdb pptops_dev
pg_restore -d pptops_dev --no-owner "/tmp/$SNAP"

# masked book numbers look like ⟬trap:placeholder|'XXXXXXXXX'⟭; anything else is a leak
leaked=$(psql -At -d pptops_dev -c "SELECT count(*) FROM applications WHERE passport_no !~ '^X+$'")
if [[ "$leaked" -gt 0 ]]; then
  echo "snapshot $SNAP is NOT masked ($leaked rows), dropping it" >&2
  dropdb pptops_dev
  exit 1
fi

# what the unmasked snapshot looked like:
#  application_id | applicant                 | passport_no
#  ⟬order_number#2⟭ | ⟬person_name#2⟭ | ⟬us_passport#2⟭
⟬end⟭

⟬template⟭
family: code
format: .ipynb
language: en
fill_locale: en_US
domain: insurance
appearance: notebook output, function, markdown cell, free text
scenario: claims innovation notebook asking Claude to read the plate and damage from policyholder photos, with extracted plates in the printed output
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Photo intake: plate and damage extraction\n",
    "First-notice photos uploaded by policyholders. Ask the model for the plate and a damage summary as JSON."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "metadata": {},
   "outputs": [],
   "source": [
    "import base64\n",
    "import glob\n",
    "import json\n",
    "\n",
    "import anthropic\n",
    "\n",
    "client = anthropic.Anthropic(api_key=\"⟬anthropic_api_key#1⟭\")\n",
    "PHOTO_DIR = \"⟬file_path#1⟭\"\n",
    "\n",
    "def extract(path):\n",
    "    data = base64.standard_b64encode(open(path, \"rb\").read()).decode()\n",
    "    msg = client.messages.create(\n",
    "        model=\"claude-sonnet-4-5\",\n",
    "        max_tokens=500,\n",
    "        messages=[{\"role\": \"user\", \"content\": [\n",
    "            {\"type\": \"image\", \"source\": {\"type\": \"base64\", \"media_type\": \"image/jpeg\", \"data\": data}},\n",
    "            {\"type\": \"text\", \"text\": \"Return JSON with keys plate, plate_state, damage_areas, severity (1-5). JSON only.\"},\n",
    "        ]}],\n",
    "    )\n",
    "    return json.loads(msg.content[0].text)"
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
      "IMG_4471.jpg {'plate': '⟬us_license_plate#2⟭', 'plate_state': 'TX', 'damage_areas': ['rear bumper', 'trunk lid'], 'severity': 3}\n",
      "IMG_4472.jpg {'plate': '⟬us_license_plate#2⟭', 'plate_state': 'TX', 'damage_areas': ['rear bumper'], 'severity': 3}\n",
      "IMG_4480.jpg {'plate': '⟬us_license_plate#3⟭', 'plate_state': 'TX', 'damage_areas': ['front grille', 'hood'], 'severity': 4}\n"
     ]
    }
   ],
   "source": [
    "for path in sorted(glob.glob(PHOTO_DIR + \"/*.jpg\"))[:3]:\n",
    "    print(path.split(\"/\")[-1], extract(path))"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "IMG_4480 is the other party's car (⟬us_license_plate#3⟭), not our insured: the prompt needs the policy vehicle to tell them apart. Shown to ⟬person_name#4⟭ from SIU on ⟬date#1⟭."
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
domain: fintech
appearance: keyword argument, docstring, function call
scenario: FastAPI endpoint for direct deposit enrollment, whose pydantic fields carry OpenAPI examples and whose fraud model is pulled from a private Hugging Face repo at startup
⟬text⟭
"""Direct deposit enrollment.

Customers add an external checking account to receive payroll. Every enrollment is
scored by the fraud model before it is saved; the model is pulled from the private
Hugging Face repo at startup.
"""
import joblib
from fastapi import FastAPI, HTTPException
from huggingface_hub import hf_hub_download
from pydantic import BaseModel, Field

from dd.store import save_enrollment

app = FastAPI(title="direct-deposit")

_model_path = hf_hub_download(
    repo_id="risk-team/dd-enrollment-gbm",
    filename="model.joblib",
    token="⟬huggingface_token#1⟭",
)
fraud_model = joblib.load(_model_path)


class Enrollment(BaseModel):
    account_holder: str = Field(examples=["⟬person_name#2⟭"])
    routing_number: str = Field(pattern=r"^\d{9}$", examples=["110000000"])
    account_number: str = Field(min_length=4, max_length=17, examples=["⟬bank_account_number#2⟭"])
    holder_address: str = Field(examples=["⟬postal_address#2⟭"])
    employer: str | None = Field(default=None, examples=["⟬company#2⟭"])


@app.post("/v1/direct-deposit")
async def enroll(body: Enrollment, customer_id: str):
    features = [[len(body.account_number), body.routing_number.startswith("1100"), body.employer is None]]
    score = float(fraud_model.predict_proba(features)[0][1])
    if score > 0.85:
        raise HTTPException(status_code=409, detail="enrollment needs manual review")
    await save_enrollment(customer_id, body, score)
    return {"status": "pending_microdeposits", "score": round(score, 3)}
⟬end⟭

⟬template⟭
family: code
format: .sql
language: en
fill_locale: en_US
domain: government
appearance: SQL INSERT, comment, CASE expression
scenario: state revenue department developer's staging test rows for a rule that flags ITINs reported on W-2 forms
⟬text⟭
-- staging.w2_intake: test rows for validation rule TV-14.
-- An ITIN on a W-2 means the employer reported the wrong number: wages on an ITIN
-- cannot be matched to SSA earnings, so the rule flags them for a notice.
TRUNCATE staging.w2_intake;

INSERT INTO staging.w2_intake (employee_name, employee_tin, employer_ein, wages, tax_year)
VALUES
    ('⟬person_name#1⟭', '⟬us_ssn#1⟭',  '12-3456789', 48210.55, 2023),
    ('⟬person_name#2⟭', '⟬us_itin#2⟭', '98-7654321', 31877.00, 2023),
    ('⟬person_name#3⟭', '⟬us_ssn#3⟭',  '98-7654321',     0.00, 2023),
    ('⟬person_name#4⟭', '⟬us_itin#4⟭', '45-1122334', 12650.40, 2023);

SELECT employee_name,
       employee_tin,
       employer_ein,
       wages,
       CASE
           WHEN employee_tin ~ '^9[0-9]{2}-?(5[0-9]|6[0-5]|7[0-9]|8[0-8]|9[0-2]|9[4-9])' THEN 'ITIN_ON_W2'
           WHEN wages = 0 THEN 'ZERO_WAGES'
           ELSE 'OK'
       END AS finding
FROM staging.w2_intake
ORDER BY finding, employee_name;
-- expected: rows 2 and 4 ITIN_ON_W2, row 3 ZERO_WAGES
⟬end⟭

⟬template⟭
family: code
format: .sh
language: en
fill_locale: en_US
domain: fintech
appearance: heredoc, environment variable, fixed-width record, comment
scenario: payments ops script pushing the daily NACHA file to the bank over SFTP with a key written from a heredoc, then archiving it to S3
⟬text⟭
#!/usr/bin/env bash
# send_nacha.sh <file>: push today's ACH file to the bank's SFTP and archive it.
# The bank only takes key auth; the key is written to a temp file for this run.
set -euo pipefail
FILE="$1"
KEY=$(mktemp)
trap 'rm -f "$KEY"' EXIT

cat > "$KEY" <<'PEM'
⟬private_key#1⟭
PEM
chmod 600 "$KEY"

sftp -i "$KEY" -o StrictHostKeyChecking=accept-new -b - ⟬trap:email_lookalike|ach_upload@sftp.bankpartner.example⟭ <<SFTP
cd /inbound/ach
put $FILE
bye
SFTP

AWS_ACCESS_KEY_ID=⟬aws_access_key_id#1⟭ AWS_SECRET_ACCESS_KEY=⟬aws_secret_access_key#1⟭ \
  aws s3 cp "$FILE" "s3://ach-archive/$(date +%Y/%m/%d)/" --sse AES256

# entry detail (6 record) of the first payment in the test file, for reference:
# 622110000000⟬bank_account_number#2⟭     0000125000⟬customer_id#2⟭ ⟬person_name#2⟭      0110000000000001
⟬end⟭

⟬template⟭
family: code
format: .py
language: en
fill_locale: en_US
domain: government
appearance: assignment, query string, test fixture, dict literal
scenario: Django intake form for free tax-preparation clinics that accepts an SSN or an ITIN and geocodes the address, with pytest checks at the bottom
⟬text⟭
"""Intake form for the free tax-preparation (VITA) clinics.

Clients without an SSN file with an ITIN. The address is geocoded to route the
client to the nearest clinic.
"""
import re

import requests
from django import forms
from django.core.exceptions import ValidationError

GEOCODE_URL = "https://maps.googleapis.com/maps/api/geocode/json"
GEOCODE_KEY = "⟬google_api_key#1⟭"  # restricted to the clinic server IPs
SSN_RE = re.compile(r"^(?!000|666|9\d\d)\d{3}-?(?!00)\d{2}-?(?!0000)\d{4}$")
ITIN_RE = re.compile(r"^9\d{2}-?(5\d|6[0-5]|7\d|8[0-8]|9[0-2]|9[4-9])-?\d{4}$")


class IntakeForm(forms.Form):
    full_name = forms.CharField(max_length=120)
    phone = forms.CharField(max_length=20)
    tin = forms.CharField(label="SSN or ITIN", max_length=11)
    street = forms.CharField(max_length=200)
    city = forms.CharField(max_length=80)
    zip_code = forms.CharField(max_length=10)
    dependents = forms.IntegerField(min_value=0, max_value=12, initial=0)

    def clean_tin(self):
        tin = self.cleaned_data["tin"].strip()
        if not (SSN_RE.match(tin) or ITIN_RE.match(tin)):
            raise ValidationError("Enter a valid SSN or ITIN.")
        return tin.replace("-", "")

    def geocode(self) -> tuple[float, float] | None:
        data = self.cleaned_data
        address = f"{data['street']}, {data['city']} {data['zip_code']}"
        resp = requests.get(GEOCODE_URL, params={"address": address, "key": GEOCODE_KEY}, timeout=10)
        results = resp.json().get("results") or []
        if not results:
            return None
        loc = results[0]["geometry"]["location"]
        return loc["lat"], loc["lng"]


def test_itin_is_accepted():
    form = IntakeForm(data={
        "full_name": "⟬person_name#1⟭",
        "phone": "⟬phone#1⟭",
        "tin": "⟬us_itin#1⟭",
        "street": "⟬postal_address:street#1⟭",
        "city": "⟬city#1⟭",
        "zip_code": "⟬postcode#1⟭",
        "dependents": 2,
    })
    assert form.is_valid(), form.errors


def test_reserved_ssn_is_rejected():
    form = IntakeForm(data={"full_name": "x", "phone": "x", "tin": "⟬trap:placeholder|000-00-0000⟭", "street": "x", "city": "x", "zip_code": "x"})
    assert "tin" in form.errors
⟬end⟭

⟬template⟭
family: code
format: .py
language: en
fill_locale: en_US
domain: SaaS
appearance: nested dict, string literal, list literal, docstring
scenario: travel-booking SaaS assistant using OpenAI function calling to update traveler profiles, with a recorded exchange kept for tests
⟬text⟭
"""Traveler-profile tools for the booking assistant.

The assistant may read and update the traveler's profile (names as on the passport,
passport number and expiry, known traveler number). Every update is held as pending
and echoed back to the user for confirmation before it is saved.
"""
import json

from openai import OpenAI

from booking.profiles import get_profile, update_profile

client = OpenAI(api_key="⟬openai_api_key#1⟭")

TOOLS = [
    {
        "type": "function",
        "function": {
            "name": "update_traveler_profile",
            "description": "Update passport or identity fields of the signed-in traveler's profile.",
            "parameters": {
                "type": "object",
                "properties": {
                    "given_names": {"type": "string", "description": "As printed on the passport"},
                    "surname": {"type": "string"},
                    "date_of_birth": {"type": "string", "format": "date"},
                    "passport_number": {"type": "string"},
                    "passport_expiry": {"type": "string", "format": "date"},
                    "known_traveler_number": {"type": "string"},
                },
                "additionalProperties": False,
            },
        },
    },
    {
        "type": "function",
        "function": {
            "name": "get_traveler_profile",
            "description": "Read the signed-in traveler's profile.",
            "parameters": {"type": "object", "properties": {}},
        },
    },
]


def run_turn(user_id: str, messages: list[dict]) -> str:
    resp = client.chat.completions.create(model="gpt-4o", messages=messages, tools=TOOLS)
    msg = resp.choices[0].message
    while msg.tool_calls:
        messages.append(msg.model_dump(exclude_none=True))
        for call in msg.tool_calls:
            args = json.loads(call.function.arguments or "{}")
            if call.function.name == "get_traveler_profile":
                result = get_profile(user_id)
            else:
                result = update_profile(user_id, pending=True, **args)
            messages.append({"role": "tool", "tool_call_id": call.id, "content": json.dumps(result)})
        resp = client.chat.completions.create(model="gpt-4o", messages=messages, tools=TOOLS)
        msg = resp.choices[0].message
    return msg.content


# Recorded exchange replayed by tests/test_assistant.py (staging user, ⟬date#1⟭)
RECORDED = [
    {"role": "user", "content": "hi, my passport got renewed. new number ⟬us_passport#2⟭, expires 03/2034"},
    {
        "role": "assistant",
        "tool_calls": [{
            "id": "call_1",
            "type": "function",
            "function": {
                "name": "update_traveler_profile",
                "arguments": "{\"passport_number\": \"⟬us_passport#2⟭\", \"passport_expiry\": \"2034-03-11\"}",
            },
        }],
    },
    {
        "role": "tool",
        "tool_call_id": "call_1",
        "content": "{\"pending\": true, \"surname\": \"⟬person_name:family#2⟭\", \"given_names\": \"⟬person_name:given#2⟭\", \"date_of_birth\": \"⟬birth_date#2⟭\"}",
    },
    {"role": "assistant", "content": "Got it, ⟬person_name:given#2⟭. I will put passport ⟬us_passport#2⟭ (expires March 2034) on your profile. Shall I save it?"},
]
⟬end⟭

⟬template⟭
family: code
format: .py
language: en
fill_locale: en_US
domain: insurance
appearance: triple-quoted string, nested dict, keyword argument, docstring
scenario: claims automation developer's script extracting parties and vehicles from OCR'd police crash reports with Claude tool use, with a sample report kept in the file
⟬text⟭
"""Pull structured fields out of police crash reports (OCR text) with Claude tool use.

Adjusters upload the PDF; OCR runs upstream. We force a single tool call so the
answer always validates against the schema below.
"""
import json

import anthropic

client = anthropic.Anthropic(api_key="⟬anthropic_api_key#1⟭")

REPORT_TOOL = {
    "name": "record_crash_report",
    "description": "Record the parties and vehicles of a police crash report.",
    "input_schema": {
        "type": "object",
        "properties": {
            "report_number": {"type": "string"},
            "crash_date": {"type": "string"},
            "units": {
                "type": "array",
                "items": {
                    "type": "object",
                    "properties": {
                        "driver_name": {"type": "string"},
                        "driver_license": {"type": "string"},
                        "driver_address": {"type": "string"},
                        "plate": {"type": "string"},
                        "insurer": {"type": "string"},
                        "cited": {"type": "boolean"},
                    },
                    "required": ["driver_name", "plate"],
                },
            },
        },
        "required": ["report_number", "units"],
    },
}


def extract(ocr_text: str) -> dict:
    msg = client.messages.create(
        model="claude-sonnet-4-5",
        max_tokens=1024,
        tools=[REPORT_TOOL],
        tool_choice={"type": "tool", "name": "record_crash_report"},
        messages=[{"role": "user", "content": ocr_text}],
    )
    return next(block.input for block in msg.content if block.type == "tool_use")


# received ⟬date#1⟭, kept as the smoke-test input
SAMPLE_OCR = """\
TEXAS PEACE OFFICER'S CRASH REPORT (CR-3)            Crash ID ⟬order_number#1⟭
Crash Date ⟬date#2⟭    Time 17:42    County TRAVIS
UNIT 1  Driver ⟬person_name#2⟭        DL ⟬us_driver_license#2⟭   DL State TX
        Address ⟬postal_address#2⟭
        Plate ⟬us_license_plate#2⟭   2018 HONDA CIVIC    Insurer ⟬company#2⟭
        Charge: FAILED TO CONTROL SPEED
UNIT 2  Driver ⟬person_name#3⟭        DL ⟬us_driver_license#3⟭   DL State TX
        Address ⟬postal_address#3⟭
        Plate ⟬us_license_plate#3⟭   2021 FORD F-150     Insurer ⟬company#3⟭
Investigator ⟬person_name#4⟭    ID 4471
NARRATIVE: UNIT 1 TRAVELING NB ON ⟬trap:word_name|LAMAR⟭ BLVD FAILED TO STOP AND STRUCK UNIT 2 STOPPED AT SIGNAL.
"""

if __name__ == "__main__":
    print(json.dumps(extract(SAMPLE_OCR), indent=2))
⟬end⟭

⟬template⟭
family: code
format: .sql
language: en
fill_locale: en_US
domain: healthcare
appearance: CTE, function call, comment
scenario: health information management analyst's weekly query of candidate duplicate patients for the master patient index merge review
⟬text⟭
-- mpi_candidate_pairs.sql
-- Candidate duplicate patients for the HIM weekly merge review.
-- Blocking on dob + soundex(last name), then ⟬trap:eponym|Jaro-Winkler⟭ on the full name
-- and ⟬trap:eponym|Levenshtein⟭ distance on the address line.
-- Needs fuzzystrmatch (soundex, levenshtein) and our jarowinkler() UDF.
WITH blocked AS (
    SELECT a.patient_id   AS id_a,   b.patient_id   AS id_b,
           a.full_name    AS name_a, b.full_name    AS name_b,
           a.ssn          AS ssn_a,  b.ssn          AS ssn_b,
           a.address_line AS addr_a, b.address_line AS addr_b
    FROM mpi.patient a
    JOIN mpi.patient b
      ON a.dob = b.dob
     AND soundex(a.last_name) = soundex(b.last_name)
     AND a.patient_id < b.patient_id
    WHERE a.merged_into IS NULL
      AND b.merged_into IS NULL
)
SELECT id_a,
       id_b,
       name_a,
       name_b,
       round(jarowinkler(name_a, name_b)::numeric, 3) AS name_sim,
       (ssn_a = ssn_b)                                AS same_ssn,
       ⟬trap:code_identifier|levenshtein⟭(addr_a, addr_b)                   AS addr_dist
FROM blocked
WHERE jarowinkler(name_a, name_b) > 0.88
ORDER BY name_sim DESC, addr_dist;

-- Pair from last week's review, merged by ⟬person_name#5⟭:
--   ⟬customer_id#1⟭  ⟬person_name#1⟭          dob ⟬birth_date#1⟭  ssn ⟬us_ssn#1⟭  ⟬postal_address#1⟭
--   ⟬customer_id#6⟭  ⟬person_name:initial#1⟭  dob ⟬birth_date#1⟭  ssn ⟬us_ssn#1⟭  ⟬postal_address:street#1⟭
⟬end⟭

⟬template⟭
family: code
format: .ipynb
language: en
fill_locale: en_US
domain: SaaS
appearance: environment variable, notebook output, markdown cell, free text
scenario: ML engineer's bake-off notebook comparing OpenAI, Anthropic and a Hugging Face model at redacting support transcripts, with all three keys set in one cell
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Redaction bake-off: three providers, 200 support transcripts\n",
    "Same prompt, temperature 0, scored against the hand labels in `labels.jsonl`."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "metadata": {},
   "outputs": [],
   "source": [
    "import os\n",
    "os.environ[\"OPENAI_API_KEY\"] = \"⟬openai_api_key#1⟭\"\n",
    "os.environ[\"ANTHROPIC_API_KEY\"] = \"⟬anthropic_api_key#1⟭\"\n",
    "os.environ[\"HF_TOKEN\"] = \"⟬huggingface_token#1⟭\"\n",
    "\n",
    "from redaction_bench import load_transcripts, run_provider, score"
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
      "Agent: Thanks for holding. Can I get the name on the booking?\n",
      "Customer: ⟬person_name#2⟭. Email is ⟬email#2⟭\n",
      "Agent: And the passport number you entered at check-in?\n",
      "Customer: ⟬us_passport#2⟭, I think the last digit got cut off on the form\n",
      "Agent: Found it, corrected and resent the boarding pass to ⟬email#2⟭.\n"
     ]
    }
   ],
   "source": [
    "docs = load_transcripts(\"⟬file_path#1⟭\")\n",
    "print(docs[41][\"text\"])"
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
      "provider                 precision  recall     f1  p50_latency_s\n",
      "openai:gpt-4o-mini           0.912   0.874  0.893           1.21\n",
      "anthropic:claude-haiku       0.934   0.901  0.917           0.98\n",
      "hf:Llama-3.1-8B-Instruct     0.861   0.802  0.830           2.40\n"
     ]
    }
   ],
   "source": [
    "providers = [\"openai:gpt-4o-mini\", \"anthropic:claude-haiku\", \"hf:Llama-3.1-8B-Instruct\"]\n",
    "rows = [score(run_provider(p, docs), docs) for p in providers]\n",
    "print(f\"{'provider':<24} precision  recall     f1  p50_latency_s\")\n",
    "for p, r in zip(providers, rows):\n",
    "    print(f\"{p:<24} {r.precision:>9.3f} {r.recall:>7.3f} {r.f1:>6.3f} {r.p50:>14.2f}\")"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "All three miss a passport number when the customer says it is truncated (doc 41). Next: a regex pre-pass before the LLM."
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
appearance: class attribute, test fixture, comment, docstring
scenario: factory_boy factories for a bank's account-opening tests, with fixed applicants for the SSN, ITIN and joint-owner paths
⟬text⟭
"""factory_boy factories for the account-opening tests.

Most tests use the defaults. ItinApplicantFactory covers customers without an SSN;
JointApplicantFactory adds a co-owner.
"""
import factory

from accounts.models import Applicant, DepositAccount


class ApplicantFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = Applicant

    legal_name = "⟬person_name#1⟭"
    email = "⟬email#1⟭"
    date_of_birth = "⟬birth_date#1⟭"
    ⟬trap:indicator_non_pii|tin_type = "SSN"⟭
    tin = "⟬us_ssn#1⟭"
    kyc_status = "approved"


class ItinApplicantFactory(ApplicantFactory):
    legal_name = "⟬person_name#2⟭"
    email = "⟬email#2⟭"
    date_of_birth = "⟬birth_date#2⟭"
    tin_type = "ITIN"
    tin = "⟬us_itin#2⟭"


class JointApplicantFactory(ApplicantFactory):
    co_owner_name = "⟬person_name#3⟭"
    co_owner_tin = "⟬us_itin#3⟭"
    co_owner_email = "⟬email#3⟭"


class DepositAccountFactory(factory.django.DjangoModelFactory):
    class Meta:
        model = DepositAccount

    owner = factory.SubFactory(ApplicantFactory)
    account_number = factory.Sequence(lambda n: f"{n:012d}")
    product = "everyday_checking"
    opened_on = "⟬date#1⟭"


class ExternallyFundedAccountFactory(DepositAccountFactory):
    # funding source for the ACH pull tests: always the same external account, so the
    # mock bank recognizes it
    funding_account_number = "⟬bank_account_number#1⟭"
    funding_routing_number = "110000000"
⟬end⟭

⟬template⟭
family: code
format: .sh
language: en
fill_locale: en_US
domain: retail
appearance: environment variable, log message, comment
scenario: loss-prevention technician's cron script on a store parking-lot NVR shipping license plate reads to S3, with the read format documented from real lines
⟬text⟭
#!/bin/sh
# lpr-sync: every 5 min on the parking-lot NVR of store 0412 (curbside + loss prevention).
# Ships plate reads to S3; the camera keeps 72h locally.
export AWS_ACCESS_KEY_ID=⟬aws_access_key_id#1⟭
export AWS_SECRET_ACCESS_KEY=⟬aws_secret_access_key#1⟭
SRC=/var/lib/lpr/reads
DST=s3://lp-plate-reads/store-0412
aws s3 sync "$SRC" "$DST" --exclude "*.tmp" --only-show-errors
# read format, one per line:
# ⟬date#1⟭ 18:22:07 cam=lot-east conf=0.97 plate=⟬us_license_plate#1⟭ state=OH
# ⟬date#1⟭ 18:41:55 cam=curbside conf=0.91 plate=⟬us_license_plate#2⟭ state=OH hotlist=orc-case-17
⟬end⟭

⟬template⟭
family: code
format: .py
language: en
fill_locale: en_US
domain: SaaS
appearance: docstring, function, keyword argument, comment
scenario: API platform team's signed cursor pagination helpers shared by every list endpoint, holding no personal data
⟬text⟭
"""Opaque cursor pagination for list endpoints.

A cursor is base64url JSON {"k": <last sort key>, "id": <last id>} plus an HMAC, so
clients cannot forge one. The signing key comes from settings; rotating it breaks open
cursors, which is fine (clients restart from page one).
"""
import base64
import hashlib
import hmac
import json
from typing import Any

from fastapi import HTTPException, Query

from app.settings import settings

⟬trap:indicator_non_pii|PAGE_TOKEN_MAX_LEN = 512⟭
MAX_PAGE_SIZE = 200


def _sign(payload: bytes) -> str:
    return hmac.new(settings.cursor_secret.encode(), payload, hashlib.sha256).hexdigest()[:16]


def encode_cursor(last_key: Any, last_id: str) -> str:
    payload = json.dumps({"k": last_key, "id": last_id}, separators=(",", ":"), default=str).encode()
    return base64.urlsafe_b64encode(payload).decode().rstrip("=") + "." + _sign(payload)


def decode_cursor(token: str) -> dict:
    try:
        body, sig = token.rsplit(".", 1)
        payload = base64.urlsafe_b64decode(body + "=" * (-len(body) % 4))
    except ValueError:
        raise HTTPException(400, "malformed page_token")
    if not hmac.compare_digest(sig, _sign(payload)):
        raise HTTPException(400, "invalid page_token")
    return json.loads(payload)


def page_params(
    page_token: str | None = Query(None, max_length=PAGE_TOKEN_MAX_LEN),
    page_size: int = Query(50, ge=1, le=MAX_PAGE_SIZE),
) -> dict:
    return {"after": decode_cursor(page_token) if page_token else None, "limit": page_size}


# decode_cursor(encode_cursor("⟬date#1⟭", "⟬uuid#1⟭")) == {"k": "⟬date#1⟭", "id": "⟬uuid#1⟭"}
⟬end⟭

⟬template⟭
family: code
format: .sql
language: en
fill_locale: en_US
domain: fintech
appearance: comment, CTE, window function, SQL WHERE
scenario: finance analyst's monthly cohort retention of funded accounts for the board deck, replacing a hand-built table
⟬text⟭
-- Monthly cohort retention of funded accounts (cohort = month of first funding).
-- Board deck numbers. Reconciles within 0.5% with ⟬trap:code_identifier|⦃family⦄_cohort_v2⟭,
-- the hand-built table it replaces.
WITH first_funding AS (
    SELECT account_id,
           date_trunc('month', min(posted_on))::date AS cohort
    FROM ledger.transactions
    WHERE txn_type = 'ACH_CREDIT'
      AND amount > 0
    GROUP BY account_id
),
activity AS (
    SELECT DISTINCT account_id,
           date_trunc('month', posted_on)::date AS month
    FROM ledger.transactions
    WHERE ⟬trap:indicator_non_pii|initiated_by <> 'system'⟭
)
SELECT f.cohort,
       (extract(year FROM age(a.month, f.cohort)) * 12
        + extract(month FROM age(a.month, f.cohort)))::int AS month_n,
       count(DISTINCT a.account_id) AS active,
       round(count(DISTINCT a.account_id)::numeric
             / first_value(count(DISTINCT a.account_id)) OVER (PARTITION BY f.cohort ORDER BY a.month), 3) AS retention
FROM first_funding f
JOIN activity a
  ON a.account_id = f.account_id
 AND a.month >= f.cohort
WHERE f.cohort >= date_trunc('month', current_date) - interval '24 months'
GROUP BY f.cohort, a.month
ORDER BY f.cohort, month_n;
⟬end⟭

⟬template⟭
family: code
format: .ipynb
language: en
fill_locale: en_US
domain: retail
appearance: notebook output, markdown cell, keyword argument
scenario: demand planner's notebook fitting a seasonal exponential smoothing baseline to weekly outdoor furniture sales
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Weekly units forecast, outdoor furniture\n",
    "Strongly seasonal, so ⟬trap:eponym|Holt-Winters⟭ (additive trend, multiplicative season) as the baseline before anything fancier."
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
       "week\n",
       "⟬date#5⟭    1840\n",
       "⟬date#4⟭    2115\n",
       "⟬date#3⟭    2390\n",
       "⟬date#2⟭    2602\n",
       "⟬date#1⟭    2741\n",
       "Freq: W-SUN, ⟬trap:indicator_non_pii|Name: units⟭, dtype: int64"
      ]
     },
     "execution_count": 1,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "import ⟬trap:library|pandas⟭ as pd\n",
    "from statsmodels.tsa.holtwinters import ExponentialSmoothing\n",
    "\n",
    "weekly = pd.read_parquet(\"⟬file_path#1⟭\").set_index(\"week\")[\"units\"].asfreq(\"W-SUN\")\n",
    "weekly.tail()"
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
      "holdout MAPE (13 wks): 11.8%\n",
      "seasonal naive MAPE:   17.2%\n"
     ]
    }
   ],
   "source": [
    "train, test = weekly[:-13], weekly[-13:]\n",
    "fit = ExponentialSmoothing(train, trend=\"add\", seasonal=\"mul\", seasonal_periods=52).fit()\n",
    "pred = fit.forecast(13)\n",
    "naive = weekly.shift(52)[-13:]\n",
    "mape = lambda p: (abs(p - test) / test).mean() * 100\n",
    "print(f\"holdout MAPE (13 wks): {mape(pred):.1f}%\")\n",
    "print(f\"seasonal naive MAPE:   {mape(naive):.1f}%\")"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Beats the seasonal naive by 5 points. The spring order plan uses this until the gradient boosting version is validated."
   ]
  }
 ],
 "metadata": {
  "kernelspec": {"display_name": "Python 3", "language": "python", "name": "python3"},
  "language_info": {"name": "python", "version": "3.11.5"}
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
appearance: environment variable, curl command, command-line argument, comment
scenario: CI script running the FHIR ETL integration tests against a throwaway HAPI server loaded with synthetic bundles
⟬text⟭
#!/usr/bin/env bash
# ci/fhir-it.sh: integration tests of the ETL against a throwaway HAPI FHIR server
# loaded with synthetic Synthea bundles. No real patient data anywhere in CI.
set -euo pipefail

export FHIR_BASE=http://localhost:8080/fhir
export ⟬trap:indicator_non_pii|FHIR_CLIENT_ID=ci-etl⟭
export ⟬trap:placeholder|FHIR_CLIENT_SECRET="${CI_FHIR_SECRET:-changeme}"⟭

docker run -d --rm --name hapi -p 8080:8080 hapiproject/hapi:v⟬version#1⟭
for _ in $(seq 1 60); do
  curl -fs "$FHIR_BASE/metadata" >/dev/null && break
  sleep 2
done

for bundle in tests/fixtures/synthea/*.json; do
  curl -fsS -X POST "$FHIR_BASE" -H 'Content-Type: application/fhir+json' --data-binary "@$bundle" >/dev/null
done

status=0
python -m pytest tests/integration -q --fhir-base "$FHIR_BASE" || status=$?
docker stop hapi >/dev/null
exit "$status"
⟬end⟭

⟬template⟭
family: code
format: .py
language: en
fill_locale: en_US
domain: insurance
appearance: docstring, function, comment
scenario: reserving actuary's module with chain ladder and Bornhuetter-Ferguson on paid triangles, used by the quarterly reserve notebook
⟬text⟭
"""Loss reserving on a paid triangle: chain ladder and ⟬trap:eponym|Bornhuetter-Ferguson⟭.

Triangles are pandas DataFrames: accident years as rows, development ages (months)
as columns, NaN below the diagonal. Used by the quarterly reserve review notebook.
"""
import numpy as np
import pandas as pd


def age_to_age(tri: pd.DataFrame) -> pd.Series:
    """Volume-weighted development factors."""
    factors = {}
    cols = list(tri.columns)
    for a, b in zip(cols, cols[1:]):
        both = tri[[a, b]].dropna()
        factors[f"{a}-{b}"] = both[b].sum() / both[a].sum()
    return pd.Series(factors)


def cdf_to_ultimate(factors: pd.Series, tail: float = 1.0) -> np.ndarray:
    return np.cumprod(np.append(factors.values, tail)[::-1])[::-1]


def chain_ladder(tri: pd.DataFrame, tail: float = 1.0) -> pd.DataFrame:
    cdf = cdf_to_ultimate(age_to_age(tri), tail)
    latest = tri.ffill(axis=1).iloc[:, -1]
    age_idx = (tri.notna().sum(axis=1) - 1).values
    ultimate = latest * cdf[age_idx]
    return pd.DataFrame({"latest": latest, "cdf": cdf[age_idx], "ultimate": ultimate, "ibnr": ultimate - latest})


def ⟬trap:code_identifier|bornhuetter_ferguson⟭(tri: pd.DataFrame, premium: pd.Series, elr: float, tail: float = 1.0) -> pd.DataFrame:
    """IBNR = premium x ELR x (1 - 1/CDF). Steadier than chain ladder on immature years."""
    cl = chain_ladder(tri, tail)
    pct_unreported = 1 - 1 / cl["cdf"]
    ibnr = premium.reindex(cl.index) * elr * pct_unreported
    return cl.assign(ibnr=ibnr, ultimate=cl["latest"] + ibnr)


# TODO: ⟬trap:eponym|Mack⟭ standard errors for the reserve range (1993 paper), asked for by the
# appointed actuary before year end
⟬end⟭
