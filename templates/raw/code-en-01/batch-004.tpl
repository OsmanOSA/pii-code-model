⟬template⟭
family: code
format: .py
language: en
fill_locale: en_US
domain: healthcare
appearance: assignment, log message, keyword argument, comment
scenario: Celery tasks sending appointment reminders by SMS for a clinic network, with worker log lines pasted at the bottom while debugging a failed send
⟬text⟭
"""Appointment reminder tasks.

Beat runs send_due_reminders every 15 minutes. Reminders go out 48h and 2h before
the visit by SMS, translated when the patient's preferred language is not English.
"""
import logging
import os
from datetime import timedelta

from celery import shared_task
from django.utils import timezone
from huggingface_hub import InferenceClient
from twilio.rest import Client

from scheduling.models import Appointment

log = logging.getLogger("reminders")

twilio = Client(os.environ["TWILIO_ACCOUNT_SID"], "⟬opaque_token#1⟭")
translator = InferenceClient(model="facebook/nllb-200-distilled-600M", token="⟬huggingface_token#1⟭")
FROM_NUMBER = "⟬phone#3⟭"

TEMPLATE = (
    "Reminder: {first} has an appointment with {provider} on {when:%b %d at %I:%M %p} "
    "at {address}. Reply C to confirm, R to reschedule."
)
LANG_CODES = {"es": "spa_Latn", "vi": "vie_Latn", "zh": "zho_Hans"}


@shared_task
def send_due_reminders():
    now = timezone.now()
    for delta, tag in ((timedelta(hours=48), "48h"), (timedelta(hours=2), "2h")):
        due = (
            Appointment.objects.filter(start__range=(now + delta - timedelta(minutes=15), now + delta), status="booked")
            .exclude(reminders_sent__contains=[tag])
            .values_list("pk", flat=True)
        )
        for pk in due:
            send_reminder.delay(pk, tag)


@shared_task(autoretry_for=(Exception,), retry_backoff=True, max_retries=3)
def send_reminder(appointment_id: int, tag: str):
    appt = Appointment.objects.select_related("patient", "provider", "clinic").get(pk=appointment_id)
    body = TEMPLATE.format(
        first=appt.patient.first_name,
        provider=appt.provider.display_name,
        when=appt.start,
        address=appt.clinic.address,
    )
    lang = appt.patient.preferred_language
    if lang in LANG_CODES:
        body = translator.translation(body, src_lang="eng_Latn", tgt_lang=LANG_CODES[lang]).translation_text
    msg = twilio.messages.create(to=appt.patient.mobile, from_=FROM_NUMBER, body=body)
    appt.reminders_sent.append(tag)
    appt.save(update_fields=["reminders_sent"])
    log.info("reminder %s sent to %s (%s)", tag, appt.patient.mobile, msg.sid)


# worker log, ⟬date#1⟭:
# [14:00:03,118: INFO/ForkPoolWorker-2] reminder 48h sent to ⟬phone#2⟭ (⟬hash#1⟭)
# [14:00:03,402: INFO/ForkPoolWorker-1] reminder 2h sent to ⟬phone#4⟭ (⟬hash#2⟭)
# [14:00:04,977: WARNING/ForkPoolWorker-2] Task send_reminder retry: Unable to create record: The 'To' number ⟬phone#5⟭ is not a valid phone number.
# body of the first one: Reminder: ⟬person_name:given#2⟭ has an appointment with Dr. ⟬person_name:family#6⟭ on Mar 14 at 09:30 AM at ⟬postal_address#3⟭. Reply C to confirm, R to reschedule.
⟬end⟭

⟬template⟭
family: code
format: .sql
language: en
fill_locale: en_US
domain: fintech
appearance: window function, comment, SQL UPDATE, SQL INSERT
scenario: disputes analyst's chargeback report by reason code, followed by a cleanup after support pasted a full card number into case notes
⟬text⟭
-- chargebacks_by_reason.sql
-- Chargeback rate by reason code and card network, trailing 90 days.
-- Cards are tokenized in this schema (pan_token); only the last four are in clear.
SELECT d.network,
       d.reason_code,
       count(*)                                    AS disputes,
       sum(d.amount_cents) / 100.0                 AS disputed_usd,
       round(100.0 * count(*) FILTER (WHERE d.outcome = 'won')
             / nullif(count(*) FILTER (WHERE d.outcome IS NOT NULL), 0), 1) AS win_rate_pct,
       round(100.0 * count(*) / sum(count(*)) OVER (PARTITION BY d.network), 1) AS share_of_network_pct
FROM payments.disputes d
WHERE d.opened_at >= current_date - 90
GROUP BY d.network, d.reason_code
ORDER BY d.network, disputes DESC;

-- Escalation ⟬ticket_id#1⟭: support pasted the full card number into the case notes
-- (cardholder ⟬person_name#2⟭, card ⟬payment_card#2⟭). Scrub it, then refund to the
-- bank account on file instead of the card, as the customer asked.
UPDATE support.case_notes
SET body = regexp_replace(body, '[0-9]{4}[ -]?[0-9]{4}[ -]?[0-9]{4}[ -]?[0-9]{4}', ⟬trap:placeholder|'[card removed]'⟭, 'g')
WHERE case_id = '⟬ticket_id#1⟭';

INSERT INTO payments.manual_refunds (case_id, amount_cents, destination_type, destination_account, requested_by)
VALUES ('⟬ticket_id#1⟭', 18999, 'ach', '⟬bank_account_number#2⟭', 'disputes-team');
⟬end⟭

⟬template⟭
family: code
format: .py
language: en
fill_locale: en_US
domain: SaaS
appearance: docstring, keyword argument, exception message
scenario: Alembic migration of a payroll SaaS that moves plaintext employee TINs to an encrypted column, with before and after rows in the docstring
⟬text⟭
"""encrypt employee tin

Revision ID: 7c1e2a9f4b10
Revises: 52d8e0c3aa71
Create Date: ⟬date#1⟭ 09:12:44.120931

Moves employees.tin (plain text, SSN or ITIN) to employees.tin_encrypted (AES-GCM
with the KMS data key) and keeps only the last four digits in clear for display.

Rows checked on staging before the run:
    id=⟬customer_id#1⟭  name=⟬person_name#1⟭  tin=⟬us_ssn#1⟭
    id=⟬customer_id#2⟭  name=⟬person_name#2⟭  tin=⟬us_itin#2⟭
"""
import sqlalchemy as sa
from alembic import op

from payroll.crypto import encrypt_tin

revision = "7c1e2a9f4b10"
down_revision = "52d8e0c3aa71"
BATCH = 1000


def upgrade():
    op.add_column("employees", sa.Column("tin_encrypted", sa.LargeBinary(), nullable=True))
    op.add_column("employees", sa.Column("tin_last4", sa.String(4), nullable=True))
    conn = op.get_bind()
    employees = sa.table(
        "employees",
        sa.column("id"),
        sa.column("tin"),
        sa.column("tin_encrypted"),
        sa.column("tin_last4"),
    )
    while True:
        rows = conn.execute(
            sa.select(employees.c.id, employees.c.tin)
            .where(employees.c.tin_encrypted.is_(None), employees.c.tin.isnot(None))
            .limit(BATCH)
        ).all()
        if not rows:
            break
        for row in rows:
            digits = row.tin.replace("-", "")
            conn.execute(
                employees.update()
                .where(employees.c.id == row.id)
                .values(tin_encrypted=encrypt_tin(digits), tin_last4=digits[-4:])
            )
    op.drop_column("employees", "tin")


def downgrade():
    raise RuntimeError("irreversible: plaintext TINs are gone, restore from backup if needed")
⟬end⟭

⟬template⟭
family: code
format: .ipynb
language: en
fill_locale: en_US
domain: government
appearance: notebook output, keyword argument, markdown cell, free text
scenario: city 311 analyst's notebook routing free-text service requests to departments with the OpenAI Batch API, with raw requests printed from the CRM export
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# 311 triage: route free-text requests to departments\n",
    "Batch API over last month's requests from the CRM export."
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
      "⟬ticket_id#1⟭ | Pothole the size of a tire in front of ⟬postal_address#2⟭, hit it twice this week. ⟬person_name#2⟭ ⟬phone#2⟭\n",
      "⟬ticket_id#2⟭ | abandoned silver sedan plate ⟬us_license_plate#3⟭ hasnt moved in 3 weeks on ⟬trap:word_name|Jefferson⟭ St\n",
      "⟬ticket_id#3⟭ | streetlight out at the corner by the library, please fix before winter\n",
      "⟬ticket_id#4⟭ | my neighbor ⟬person_name#4⟭ keeps burning trash in the yard, call me back at ⟬phone#5⟭\n"
     ]
    }
   ],
   "source": [
    "import json\n",
    "\n",
    "import ⟬trap:library|pandas⟭ as pd\n",
    "from openai import OpenAI\n",
    "\n",
    "client = OpenAI(api_key=\"⟬openai_api_key#1⟭\")\n",
    "reqs = pd.read_json(\"⟬file_path#1⟭\", lines=True)\n",
    "for r in reqs.head(4).itertuples():\n",
    "    print(r.id, \"|\", r.text)"
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
       "'validating'"
      ]
     },
     "execution_count": 2,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "DEPTS = [\"streets\", \"parking_enforcement\", \"code_enforcement\", \"lighting\", \"sanitation\", \"other\"]\n",
    "with open(\"batch_311.jsonl\", \"w\") as fh:\n",
    "    for r in reqs.itertuples():\n",
    "        body = {\"model\": \"gpt-4o-mini\", \"messages\": [\n",
    "            {\"role\": \"system\", \"content\": f\"Route the 311 request to one of {DEPTS}. Department only.\"},\n",
    "            {\"role\": \"user\", \"content\": r.text}]}\n",
    "        fh.write(json.dumps({\"custom_id\": str(r.id), \"method\": \"POST\", \"url\": \"/v1/chat/completions\", \"body\": body}) + \"\\n\")\n",
    "f = client.files.create(file=open(\"batch_311.jsonl\", \"rb\"), purpose=\"batch\")\n",
    "batch = client.batches.create(input_file_id=f.id, endpoint=\"/v1/chat/completions\", completion_window=\"24h\")\n",
    "batch.status"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Neighbor disputes land in `code_enforcement`, which is right. Next time strip phone numbers before writing the batch file: the uploaded file kept them."
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
format: .sh
language: en
fill_locale: en_US
domain: SaaS
appearance: commit trailer, environment variable, command-line argument
scenario: release script of a two-person ML team that commits the model card with co-author trailers and uploads the model to the Hugging Face Hub
⟬text⟭
#!/usr/bin/env bash
# release_model.sh <version>: commit the model card, tag, push, then upload the weights to the Hub.
# We pair on releases, so both of us go in the commit trailers.
set -euo pipefail
VERSION="$1"
export HF_TOKEN=⟬huggingface_token#1⟭
export ⟬trap:indicator_non_pii|GIT_AUTHOR_NAME=release-bot⟭

python scripts/render_model_card.py --version "$VERSION" > model/README.md
git add model/README.md CHANGELOG.md
git commit -m "release: intent-router $VERSION" \
  -m "Eval report: runs/$VERSION/report.json" \
  --trailer "Co-authored-by: ⟬person_name#2⟭ <⟬email#2⟭>" \
  --trailer "Signed-off-by: ⟬person_name#3⟭ <⟬email#3⟭>"
git tag -a "v$VERSION" -m "intent-router $VERSION"
git push origin main --follow-tags

huggingface-cli upload helpdesk-ai/intent-router model/ . --commit-message "v$VERSION"
huggingface-cli tag helpdesk-ai/intent-router "v$VERSION"
⟬end⟭

⟬template⟭
family: code
format: .py
language: en
fill_locale: en_US
domain: insurance
appearance: docstring, nested JSON, f-string
scenario: FastAPI auto-quote endpoint that pulls each driver's motor vehicle record and has an LLM summarize violations, with an example request body in the docstring
⟬text⟭
"""Auto quote: pull each driver's motor vehicle record (MVR) and price the violations.

The MVR vendor returns raw violation codes; an LLM turns them into the one-line
summary the agent sees next to the quote.
"""
from fastapi import FastAPI
from openai import OpenAI
from pydantic import BaseModel

from quoting.mvr import fetch_mvr
from quoting.rating import surcharge_for

app = FastAPI(title="auto-quote")
llm = OpenAI(api_key="⟬openai_api_key#1⟭")


class Driver(BaseModel):
    name: str
    dob: str
    license_number: str
    license_state: str


class QuoteRequest(BaseModel):
    plate: str
    drivers: list[Driver]


def summarize(violations: list[dict]) -> str:
    if not violations:
        return "Clean record."
    resp = llm.chat.completions.create(
        model="gpt-4o-mini",
        messages=[{"role": "user", "content": f"One line for an insurance agent, no names or numbers: {violations}"}],
    )
    return resp.choices[0].message.content.strip()


@app.post("/quotes/auto")
def quote(req: QuoteRequest):
    """Example body (household from the agent demo):

        {"plate": "⟬us_license_plate#2⟭",
         "drivers": [
            {"name": "⟬person_name#2⟭", "dob": "⟬birth_date#2⟭", "license_number": "⟬us_driver_license#2⟭", "license_state": "OH"},
            {"name": "⟬person_name#3⟭", "dob": "⟬birth_date#3⟭", "license_number": "⟬us_driver_license#3⟭", "license_state": "OH"}]}
    """
    lines = []
    for d in req.drivers:
        mvr = fetch_mvr(d.license_number, d.license_state)
        lines.append({
            "driver": d.name,
            "surcharge": surcharge_for(mvr.violations),
            "summary": summarize(mvr.violations),
        })
    return {"plate": req.plate, "drivers": lines}
⟬end⟭

⟬template⟭
family: code
format: .sql
language: en
fill_locale: en_US
domain: government
appearance: SQL UPDATE, SQL DELETE, comment, command-line argument
scenario: toll authority analyst's weekly notice-of-violation batch for the mail house, with hand fixes for rental plates and exempt vehicles
⟬text⟭
-- toll_notices_batch.sql: this week's notice-of-violation batch for the mail house.
-- Plates with no transponder match whose registered owner the state DMV returned.
CREATE TEMP TABLE nov_batch AS
SELECT t.plate,
       t.plate_state,
       count(*)                  AS trips,
       sum(t.toll_cents) / 100.0 AS tolls_usd,
       count(*) * 25.00          AS admin_fees_usd,
       o.owner_name,
       o.mail_street,
       o.mail_city,
       o.mail_zip
FROM tolling.unmatched_trips t
JOIN dmv.owner_lookup o ON o.plate = t.plate AND o.plate_state = t.plate_state
WHERE t.trip_at >= date_trunc('week', current_date) - interval '7 days'
  AND t.trip_at <  date_trunc('week', current_date)
  AND NOT EXISTS (SELECT 1 FROM tolling.exemptions e WHERE e.plate = t.plate)
GROUP BY t.plate, t.plate_state, o.owner_name, o.mail_street, o.mail_city, o.mail_zip;

-- the DMV returned the rental company for this one; renter from the rental agreement
UPDATE nov_batch
SET owner_name = '⟬person_name#1⟭',
    mail_street = '⟬postal_address:street#1⟭',
    mail_city = '⟬city#1⟭',
    mail_zip = '⟬postcode#1⟭'
WHERE plate = '⟬us_license_plate#1⟭';

DELETE FROM nov_batch WHERE plate IN ('⟬us_license_plate#2⟭', '⟬us_license_plate#3⟭');  -- fire dept, exempt

\copy (SELECT * FROM nov_batch ORDER BY mail_zip) TO 'nov_batch.csv' WITH CSV HEADER
⟬end⟭

⟬template⟭
family: code
format: .ipynb
language: en
fill_locale: en_US
domain: fintech
appearance: notebook output, function, markdown cell
scenario: mobile deposit team's notebook comparing Claude with the OCR vendor on check images, with one extracted check printed in full
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Mobile check deposit: field extraction with Claude vs the OCR vendor\n",
    "300 checks from the QA set (front images only)."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "metadata": {},
   "outputs": [],
   "source": [
    "import base64\n",
    "import json\n",
    "\n",
    "import anthropic\n",
    "\n",
    "client = anthropic.Anthropic(api_key=\"⟬anthropic_api_key#1⟭\")\n",
    "FIELDS = \"payer_name, payer_address, payee, amount, date, micr (routing, account, check_number), memo\"\n",
    "\n",
    "def read_check(path):\n",
    "    img = base64.b64encode(open(path, \"rb\").read()).decode()\n",
    "    msg = client.messages.create(\n",
    "        model=\"claude-sonnet-4-5\",\n",
    "        max_tokens=600,\n",
    "        messages=[{\"role\": \"user\", \"content\": [\n",
    "            {\"type\": \"image\", \"source\": {\"type\": \"base64\", \"media_type\": \"image/png\", \"data\": img}},\n",
    "            {\"type\": \"text\", \"text\": f\"Extract {FIELDS} from this check. JSON only.\"},\n",
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
     "data": {
      "text/plain": [
       "{'payer_name': '⟬person_name#2⟭',\n",
       " 'payer_address': '⟬postal_address#2⟭',\n",
       " 'payee': '⟬person_name#3⟭',\n",
       " 'amount': '1250.00',\n",
       " 'date': '⟬date#2⟭',\n",
       " 'micr': {'routing': '011000015', 'account': '⟬bank_account_number#2⟭', 'check_number': '1043'},\n",
       " 'memo': 'rent unit 4B'}"
      ]
     },
     "execution_count": 2,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "read_check(\"⟬file_path#1⟭\")"
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
      "field          claude  vendor\n",
      "payer_name      0.981   0.955\n",
      "payee           0.962   0.871\n",
      "amount          0.990   0.993\n",
      "micr            0.947   0.998\n"
     ]
    }
   ],
   "source": [
    "report = compare(qa_set, read_check, vendor_results)\n",
    "print(report.to_string(float_format=\"%.3f\"))"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Claude wins on handwritten payees, the vendor on MICR. Plan: vendor MICR, Claude for the rest. ⟬person_name#4⟭ reviews before ⟬date#1⟭."
   ]
  }
 ],
 "metadata": {
  "kernelspec": {"display_name": "Python 3", "language": "python", "name": "python3"},
  "language_info": {"name": "python", "version": "3.12.4"}
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
domain: government
appearance: keyword argument, log message, comment, f-string
scenario: passport acceptance facility booking API that emails confirmations through SES, where a debug log line leaked the whole booking into CloudWatch
⟬text⟭
"""Passport acceptance facility appointments.

Applicants book a slot and get a confirmation email (SES). The DS-11 fields they
pre-fill are stored for the clerk; we only check that they are present.
"""
import logging

import boto3
from fastapi import FastAPI
from pydantic import BaseModel, EmailStr

app = FastAPI()
log = logging.getLogger("appointments")
ses = boto3.client(
    "ses",
    region_name="us-east-1",
    aws_access_key_id="⟬aws_access_key_id#1⟭",
    aws_secret_access_key="⟬aws_secret_access_key#1⟭",
)


class Booking(BaseModel):
    slot_id: str
    full_name: str
    email: EmailStr
    ssn: str
    renewal_of: str | None = None  # previous passport book number, if any


@app.post("/appointments")
def book(b: Booking):
    log.info("booking %s", b)  # FIXME: logs the whole model, SSN included, see below
    ses.send_email(
        Source="⟬email:generic#3⟭",
        Destination={"ToAddresses": [b.email]},
        Message={
            "Subject": {"Data": "Your passport appointment"},
            "Body": {"Text": {"Data": f"Hello {b.full_name}, appointment {b.slot_id} is confirmed. Bring your DS-11 unsigned."}},
        },
    )
    return {"status": "booked"}

# CloudWatch, /ecs/appointments, ⟬date#1⟭:
# INFO:appointments:booking slot_id='⟬order_number#2⟭' full_name='⟬person_name#2⟭' email='⟬email#2⟭' ssn='⟬us_ssn#2⟭' renewal_of='⟬us_passport#2⟭'
⟬end⟭

⟬template⟭
family: code
format: .py
language: en
fill_locale: en_US
domain: retail
appearance: assignment, keyword argument, command-line argument, comment
scenario: Flask webhook of an online store that emails refund receipts through SendGrid when Stripe reports a refund, with the Stripe CLI test command in a comment
⟬text⟭
"""Stripe webhook: when a refund succeeds, email the customer a receipt through SendGrid."""
import stripe
from ⟬trap:library|flask⟭ import Flask, abort, request
from sendgrid import SendGridAPIClient
from sendgrid.helpers.mail import Mail

stripe.api_key = "⟬stripe_secret_key#1⟭"
ENDPOINT_SECRET = "⟬opaque_token#1⟭"
sg = SendGridAPIClient("⟬sendgrid_api_key#1⟭")

app = Flask(__name__)


@app.post("/stripe/webhook")
def webhook():
    try:
        event = stripe.Webhook.construct_event(request.data, request.headers["Stripe-Signature"], ENDPOINT_SECRET)
    except (ValueError, stripe.error.SignatureVerificationError):
        abort(400)
    if event["type"] != "charge.refunded":
        return "", 204
    charge = event["data"]["object"]
    details = charge["billing_details"]
    amount = charge["amount_refunded"] / 100
    last4 = charge["payment_method_details"]["card"]["last4"]
    sg.send(Mail(
        from_email="⟬email:generic#2⟭",
        to_emails=details["email"],
        subject="Your refund is on its way",
        html_content=f"<p>Hi {details['name']},</p><p>We refunded ${amount:.2f} to your card ending in {last4}.</p>",
    ))
    return "", 200


# local test:
# stripe trigger charge.refunded \
#   --override charge:billing_details.name="⟬person_name#3⟭" \
#   --override charge:billing_details.email="⟬email#3⟭" \
#   --override charge:billing_details.address.line1="⟬postal_address:street#3⟭"
⟬end⟭

⟬template⟭
family: code
format: .sh
language: en
fill_locale: en_US
domain: insurance
appearance: environment variable, command-line argument, comment
scenario: life claims developer's script running Textract on a scanned claim form and printing its fields, with the output of a real run kept as an example
⟬text⟭
#!/usr/bin/env bash
# textract_claim.sh <s3-key>: run Textract FORMS on a scanned life claim and print the key/values.
set -euo pipefail
export AWS_ACCESS_KEY_ID="⟬aws_access_key_id#1⟭" AWS_SECRET_ACCESS_KEY="⟬aws_secret_access_key#1⟭" AWS_DEFAULT_REGION=us-east-1

JOB=$(aws textract start-document-analysis \
  --document-location "{\"S3Object\":{\"Bucket\":\"life-claims-intake\",\"Name\":\"$1\"}}" \
  --feature-types FORMS --query JobId --output text)
until [[ $(aws textract get-document-analysis --job-id "$JOB" --query JobStatus --output text) != IN_PROGRESS ]]; do
  sleep 5
done
aws textract get-document-analysis --job-id "$JOB" > "out/$JOB.json"
python tools/kv_from_textract.py "out/$JOB.json"

# output for claim ⟬order_number#1⟭:
#   Insured name ........ ⟬person_name#2⟭
#   Date of death ....... ⟬date#2⟭
#   Beneficiary 1 ....... ⟬person_name#3⟭, TIN ⟬us_itin#3⟭, share 50%
#   Beneficiary 2 ....... ⟬person_name#4⟭, ID passport ⟬us_passport#4⟭, share 50%
#   Signed .............. ⟬date#1⟭
⟬end⟭

⟬template⟭
family: code
format: .py
language: en
fill_locale: en_US
domain: fintech
appearance: docstring, DataFrame literal, test fixture, string literal
scenario: Dagster assets for a community lender's ITIN loan portfolio report, with Claude summarizing officer notes and a hand-written DataFrame in the test
⟬text⟭
"""Dagster assets for the ITIN lending portfolio report.

Borrowers without an SSN apply with an ITIN; the program reports monthly to the
funder. Loan officer notes are summarized by Claude for the narrative section.
"""
import anthropic
import pandas as pd
from dagster import AssetExecutionContext, asset

claude = anthropic.Anthropic(api_key="⟬anthropic_api_key#1⟭")

LOAN_COLUMNS = "loan_id, borrower_name, itin, phone, dob, disbursed_on, principal, status, officer_notes"


@asset(required_resource_keys={"warehouse"})
def itin_loans(context: AssetExecutionContext) -> pd.DataFrame:
    df = context.resources.warehouse.query(f"SELECT {LOAN_COLUMNS} FROM lending.itin_loans")
    context.log.info(f"loaded {len(df)} ITIN loans")
    return df


@asset
def portfolio_summary(itin_loans: pd.DataFrame) -> pd.DataFrame:
    return (
        itin_loans.groupby("status")
        .agg(loans=("loan_id", "count"), principal=("principal", "sum"))
        .reset_index()
    )


@asset
def narrative(itin_loans: pd.DataFrame) -> str:
    notes = "\n".join(itin_loans["officer_notes"].dropna().head(50))
    msg = claude.messages.create(
        model="claude-sonnet-4-5",
        max_tokens=600,
        messages=[{"role": "user", "content": "Summarize these loan officer notes for a funder report, with no names or numbers:\n" + notes}],
    )
    return msg.content[0].text


def test_portfolio_summary():
    loans = pd.DataFrame([
        {"loan_id": "⟬order_number#1⟭", "borrower_name": "⟬person_name#1⟭", "itin": "⟬us_itin#1⟭",
         "phone": "⟬phone#1⟭", "dob": "⟬birth_date#1⟭", "disbursed_on": "⟬date#1⟭", "principal": 8000,
         "status": "current", "officer_notes": "Food truck, second season, autopay from ⟬bank_account_number#1⟭"},
        {"loan_id": "⟬order_number#2⟭", "borrower_name": "⟬person_name#2⟭", "itin": "⟬us_itin#2⟭",
         "phone": "⟬phone#2⟭", "dob": "⟬birth_date#2⟭", "disbursed_on": "⟬date#2⟭", "principal": 5000,
         "status": "late_30", "officer_notes": None},
    ])
    out = portfolio_summary(loans).set_index("status")
    assert out.loc["current", "principal"] == 8000
    assert out.loc["late_30", "loans"] == 1
⟬end⟭

⟬template⟭
family: code
format: .sql
language: en
fill_locale: en_US
domain: healthcare
appearance: DDL, SQL REVOKE, comment
scenario: Medicaid eligibility team's call-center view that masks SSNs, with the base row of a test member kept in a comment for the post-deploy check
⟬text⟭
-- v_member_eligibility: what the call center sees. SSN masked to the last four;
-- dob kept because callers verify with it. Owner: eligibility data team.
CREATE OR REPLACE VIEW callcenter.v_member_eligibility AS
SELECT m.member_id,
       m.first_name,
       m.last_name,
       m.dob,
       ⟬trap:placeholder|'XXX-XX-'⟭ || right(m.ssn, 4) AS ssn_masked,
       e.program_code,
       e.effective_from,
       e.effective_to,
       CASE WHEN e.effective_to IS NULL OR e.effective_to >= current_date THEN 'ACTIVE' ELSE 'TERMED' END AS status
FROM medicaid.members m
JOIN medicaid.eligibility_spans e ON e.member_id = m.member_id
WHERE e.span_type = 'primary';

GRANT SELECT ON callcenter.v_member_eligibility TO role_callcenter;
REVOKE SELECT ON medicaid.members FROM role_callcenter;

-- post-deploy check (⟬date#1⟭): this base row must no longer be readable as role_callcenter
-- SELECT member_id, first_name, last_name, dob, ssn FROM medicaid.members WHERE member_id = '⟬customer_id#1⟭';
--   ⟬customer_id#1⟭ | ⟬person_name:given#1⟭ | ⟬person_name:family#1⟭ | ⟬birth_date#1⟭ | ⟬us_ssn#1⟭
⟬end⟭

⟬template⟭
family: code
format: .ipynb
language: en
fill_locale: en_US
domain: SaaS
appearance: notebook output, assignment, markdown cell, free text
scenario: data team's notebook generating synthetic support tickets with Claude and pushing them to a private Hugging Face dataset, where one generated ticket copied a seed verbatim
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Synthetic support tickets for the intent model\n",
    "Claude writes tickets from seed descriptions; the result goes to the private Hub dataset."
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
    "import anthropic\n",
    "from datasets import Dataset\n",
    "\n",
    "client = anthropic.Anthropic(api_key=\"⟬anthropic_api_key#1⟭\")\n",
    "HF_TOKEN = \"⟬huggingface_token#1⟭\"\n",
    "seeds = [json.loads(line) for line in open(\"⟬file_path#1⟭\")]"
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
      "1200 tickets\n",
      "--- ticket 212 ---\n",
      "Subject: cant update passport details before my flight\n",
      "Hi, I'm ⟬person_name#2⟭ (⟬email#2⟭). The app rejects my passport number ⟬us_passport#2⟭ with 'invalid format' and I fly tomorrow. Please help!!\n"
     ]
    }
   ],
   "source": [
    "rows = []\n",
    "for seed in seeds:\n",
    "    msg = client.messages.create(\n",
    "        model=\"claude-haiku-4-5\",\n",
    "        max_tokens=400,\n",
    "        messages=[{\"role\": \"user\", \"content\": f\"Write one realistic support ticket (subject + body) for this intent: {seed['intent']}. Context: {seed['context']}\"}],\n",
    "    )\n",
    "    rows.append({\"intent\": seed[\"intent\"], \"text\": msg.content[0].text})\n",
    "print(len(rows), \"tickets\")\n",
    "print(\"--- ticket 212 ---\")\n",
    "print(rows[212][\"text\"])"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 3,
   "metadata": {},
   "outputs": [],
   "source": [
    "Dataset.from_list(rows).push_to_hub(\"helpdesk-ai/synthetic-tickets\", private=True, token=HF_TOKEN)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Ticket 212 copied its seed context verbatim, customer details included. Removed from the Hub and regenerated with an \"invent every detail\" instruction. ⟬person_name:initial#3⟭"
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
domain: retail
appearance: curl command, HTTP header, environment variable, comment
scenario: e-commerce content engineer's one-off script writing alt text for product photos with the OpenAI API through curl, then uploading the result to S3
⟬text⟭
#!/usr/bin/env bash
# alt_text.sh: write alt text for product images that have none, then drop the JSONL in S3
# for the storefront import. One-off for the spring catalog.
set -euo pipefail
OPENAI_API_KEY="⟬openai_api_key#1⟭"
export AWS_ACCESS_KEY_ID="⟬aws_access_key_id#1⟭"
export AWS_SECRET_ACCESS_KEY="⟬aws_secret_access_key#1⟭"

: > alt_text.jsonl
while IFS=, read -r sku url; do
  alt=$(curl -sS https://api.openai.com/v1/chat/completions \
    -H "Authorization: Bearer $OPENAI_API_KEY" \
    -H "Content-Type: application/json" \
    -d "{\"model\": \"gpt-4o-mini\", \"max_tokens\": 60, \"messages\": [{\"role\": \"user\", \"content\": [
          {\"type\": \"text\", \"text\": \"Alt text for this product photo, under 120 characters, no brand names.\"},
          {\"type\": \"image_url\", \"image_url\": {\"url\": \"$url\"}}]}]}" | jq -r '.choices[0].message.content')
  jq -nc --arg sku "$sku" --arg alt "$alt" '{sku: $sku, alt: $alt}' >> alt_text.jsonl
done < missing_alt.csv

aws s3 cp alt_text.jsonl s3://storefront-imports/spring/alt_text.jsonl
# first result: GL-2201 -> "Set of four ⟬trap:word_name|Margaux⟭ stemless wine glasses on a linen tablecloth"
⟬end⟭

⟬template⟭
family: code
format: .py
language: en
fill_locale: en_US
domain: government
appearance: docstring, assignment, keyword argument
scenario: benefits case system's monthly records retention job written with SQLAlchemy, deleting identity documents past their retention period
⟬text⟭
"""Records retention job for the benefits case system.

Deletes or anonymizes rows past their retention period, per the schedule approved by
the records officer. Runs monthly; every run is logged to retention_runs.
"""
from datetime import datetime, timedelta, timezone

from sqlalchemy import delete, func, insert, select, update
from sqlalchemy.orm import Session

from cases.models import CaseNote, IdentityDocument, RetentionRun, UploadedFile

⟬trap:indicator_non_pii|RETENTION_DAYS_SSN_DOCS = 2555⟭  # 7 years after case closure
RETENTION_DAYS_NOTES = 3650
⟬trap:indicator_non_pii|ANONYMIZED_NAME = "REDACTED"⟭


def _count(session: Session, model, condition) -> int:
    return session.scalar(select(func.count()).select_from(model).where(condition))


def run(session: Session, now: datetime | None = None, dry_run: bool = False) -> dict:
    now = now or datetime.now(timezone.utc)
    docs_expired = IdentityDocument.case_closed_at < now - timedelta(days=RETENTION_DAYS_SSN_DOCS)
    notes_expired = CaseNote.created_at < now - timedelta(days=RETENTION_DAYS_NOTES)
    counts = {
        "identity_documents": _count(session, IdentityDocument, docs_expired),
        "case_notes": _count(session, CaseNote, notes_expired),
    }
    if dry_run:
        return counts
    expired_ids = select(IdentityDocument.id).where(docs_expired)
    session.execute(delete(UploadedFile).where(UploadedFile.document_id.in_(expired_ids)))
    session.execute(delete(IdentityDocument).where(docs_expired))
    session.execute(update(CaseNote).where(notes_expired).values(author_name=ANONYMIZED_NAME, body=None))
    session.execute(insert(RetentionRun).values(ran_at=now, **counts))
    session.commit()
    return counts
⟬end⟭

⟬template⟭
family: code
format: .sql
language: en
fill_locale: en_US
domain: insurance
appearance: comment, CTE, function call
scenario: actuarial analyst's set-based earned premium by calendar month, replacing a slow row-by-row function named after its author
⟬text⟭
-- earned_premium_monthly.sql
-- Earned premium by calendar month, pro rata on days in force. Replaces
-- ⟬trap:code_identifier|fn_⦃family⦄_earned()⟭ (row by row, 40 minutes) with a set-based version.
WITH months AS (
    SELECT generate_series(DATE '2022-01-01', date_trunc('month', current_date), interval '1 month')::date AS month_start
),
policies AS (
    SELECT policy_id,
           product_line,
           written_premium,
           effective_date,
           expiration_date,
           (expiration_date - effective_date) AS term_days
    FROM uw.policies
    WHERE status IN ('in_force', 'expired', 'cancelled')
      AND ⟬trap:indicator_non_pii|policyholder_type = 'individual'⟭
)
SELECT m.month_start,
       p.product_line,
       round(sum(p.written_premium
                 * greatest(0, least(p.expiration_date, (m.month_start + interval '1 month')::date)
                               - greatest(p.effective_date, m.month_start))::numeric
                 / p.term_days), 2) AS earned_premium
FROM months m
JOIN policies p
  ON p.effective_date < (m.month_start + interval '1 month')::date
 AND p.expiration_date > m.month_start
GROUP BY m.month_start, p.product_line
ORDER BY m.month_start, p.product_line;
⟬end⟭

⟬template⟭
family: code
format: .ipynb
language: en
fill_locale: en_US
domain: SaaS
appearance: notebook output, markdown cell, dict literal
scenario: FinOps engineer's notebook pricing LLM token usage per tenant from the usage table, with counts only and no prompt text
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# LLM spend per tenant, last 30 days\n",
    "Token counts from the usage table, priced with the current rate card. Counts only, no prompt text is loaded. ⟬trap:indicator_non_pii|owner: finops⟭"
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
       "                   input_tokens  output_tokens\n",
       "model                                          \n",
       "claude-haiku-4-5       1.84e+09       2.21e+08\n",
       "claude-sonnet-4-5      3.10e+08       4.42e+07\n",
       "gpt-4o-mini            9.70e+08       1.05e+08"
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
    "import sqlalchemy as sa\n",
    "\n",
    "engine = sa.create_engine(\"postgresql://⟬hostname#1⟭/usage\")  # IAM auth through the notebook role\n",
    "usage = pd.read_sql(\"SELECT tenant_id, model, input_tokens, output_tokens, day FROM llm_usage WHERE day >= current_date - 30\", engine)\n",
    "usage.groupby(\"model\")[[\"input_tokens\", \"output_tokens\"]].sum()"
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
       "tenant_id\n",
       "⟬customer_id#1⟭    18412.07\n",
       "⟬customer_id#2⟭     9930.55\n",
       "⟬customer_id#3⟭     6105.12\n",
       "dtype: float64"
      ]
     },
     "execution_count": 2,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "RATES = {  # USD per million tokens (input, output)\n",
    "    \"claude-haiku-4-5\": (1.00, 5.00),\n",
    "    \"claude-sonnet-4-5\": (3.00, 15.00),\n",
    "    \"gpt-4o-mini\": (0.15, 0.60),\n",
    "}\n",
    "rate_in = usage.model.map(lambda m: RATES[m][0])\n",
    "rate_out = usage.model.map(lambda m: RATES[m][1])\n",
    "usage[\"cost\"] = (usage.input_tokens * rate_in + usage.output_tokens * rate_out) / 1e6\n",
    "spend = usage.groupby(\"tenant_id\").cost.sum().sort_values(ascending=False)\n",
    "spend.head(3)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "The top 3 tenants are 61% of spend and the tail is close to a ⟬trap:eponym|Zipf⟭ curve (s around 1.1). Usage data as of ⟬date#1⟭."
   ]
  }
 ],
 "metadata": {
  "kernelspec": {"display_name": "Python 3", "language": "python", "name": "python3"},
  "language_info": {"name": "python", "version": "3.12.0"}
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
appearance: command-line argument, environment variable, comment
scenario: platform engineer's script issuing fresh dynamic database credentials from Vault for a ledger service and restarting it, with nothing secret on disk
⟬text⟭
#!/usr/bin/env bash
# rotate_db_creds.sh: issue fresh dynamic Postgres creds from Vault for the ledger service
# and restart it. Nothing secret is written to disk or to the job log.
set -euo pipefail
export VAULT_ADDR=https://⟬hostname#1⟭:8200
vault login -method=aws ⟬trap:indicator_non_pii|role=ledger-deployer⟭ >/dev/null

creds=$(vault read -format=json database/creds/ledger-rw)
user=$(jq -r .data.username <<<"$creds")
pass=$(jq -r .data.password <<<"$creds")
lease=$(jq -r .lease_id <<<"$creds")

kubectl -n ledger create secret generic ledger-db \
  --from-literal=username="$user" \
  --from-literal=⟬trap:placeholder|password="$pass"⟭ \
  --dry-run=client -o yaml | kubectl apply -f -
kubectl -n ledger rollout restart deploy/ledger-api
kubectl -n ledger rollout status deploy/ledger-api --timeout=120s
echo "rotated, lease $lease (ttl 24h)"
⟬end⟭

⟬template⟭
family: code
format: .py
language: en
fill_locale: en_US
domain: healthcare
appearance: string literal, docstring, function
scenario: interface engineer's builder of HL7 v2 ADT messages for the interface engine's regression suite, filled from synthetic patients at test time
⟬text⟭
"""Build HL7 v2.5 ADT^A04 messages for the interface engine's regression suite.

The template is filled from a synthetic patient dict at test time; nothing in this
module holds patient data.
"""
from datetime import datetime

SEGMENT_SEP = "\r"
TEMPLATE = SEGMENT_SEP.join([
    "MSH|^~\\&|REGADT|MAINCAMPUS|EHR|HOSP|{ts}||ADT^A04|{control_id}|P|2.5",
    "EVN|A04|{ts}",
    "PID|1||{mrn}^^^HOSP^MR||⟬trap:placeholder|{last}^{first}⟭||{dob}|{sex}|||⟬trap:placeholder|{street}^^{city}^{state}^{zip}⟭||{phone}",
    "PV1|1|O|{location}^^^MAINCAMPUS||||{attending_npi}",
])
REQUIRED = ("mrn", "last", "first", "dob", "sex", "street", "city", "state", "zip", "phone", "location", "attending_npi")


def escape(value: str) -> str:
    """HL7 escape sequences for the delimiters; the escape character goes first."""
    return (
        value.replace("\\", "\\E\\")
        .replace("|", "\\F\\")
        .replace("^", "\\S\\")
        .replace("&", "\\T\\")
        .replace("~", "\\R\\")
    )


def build_a04(patient: dict, control_id: str, now: datetime | None = None) -> str:
    missing = [key for key in REQUIRED if not patient.get(key)]
    if missing:
        raise KeyError(f"synthetic patient is missing {', '.join(missing)}")
    ts = (now or datetime.now()).strftime("%Y%m%d%H%M%S")
    fields = {key: escape(str(value)) for key, value in patient.items()}
    return TEMPLATE.format(ts=ts, control_id=control_id, **fields)
⟬end⟭
