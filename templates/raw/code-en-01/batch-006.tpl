⟬template⟭
family: code
format: .py
language: en
fill_locale: en_US
domain: retail
appearance: dict literal, keyword argument, comment
scenario: holiday pilot script by a store engineer drafting gift notes with OpenAI for one gift order typed in by hand
⟬text⟭
# gift_note.py: draft the gift note printed on the packing slip (holiday pilot)
from openai import OpenAI

client = OpenAI(api_key="⟬openai_api_key#1⟭")
order = {"to": "⟬person_name#1⟭", "ship_to": "⟬postal_address#1⟭", "from": "⟬person_name:given#2⟭", "occasion": "housewarming"}

note = client.responses.create(
    model="gpt-4o-mini",
    input=f"Two warm sentences for a {order['occasion']} gift note to {order['to']} from {order['from']}.",
)
print(note.output_text)
⟬end⟭

⟬template⟭
family: code
format: .sql
language: en
fill_locale: en_US
domain: insurance
appearance: comment, SQL WHERE
scenario: claims adjuster's ad hoc lookup of every claim tied to a plate, an SSN or a last name a caller gave
⟬text⟭
-- lookup for ⟬ticket_id#1⟭: the caller gave a plate and a last name only;
-- SIU wants every claim tied to the plate or to the claimant's SSN
SELECT c.claim_id, c.loss_date, c.status, c.claimant_name, c.vehicle_plate
FROM claims.claim c
WHERE c.vehicle_plate = '⟬us_license_plate#1⟭'
   OR c.claimant_ssn = '⟬us_ssn#2⟭'
   OR c.claimant_name ILIKE '%⟬person_name:family#2⟭%'
ORDER BY c.loss_date DESC;
⟬end⟭

⟬template⟭
family: code
format: .py
language: en
fill_locale: en_US
domain: healthcare
appearance: test fixture, dict literal, comment
scenario: conftest of an insurance eligibility service holding the single test patient every 270/271 test uses
⟬text⟭
# tests/conftest.py (eligibility service): the one patient every 270/271 test uses
import pytest

PATIENT = {
    "first": "⟬person_name:given#1⟭",
    "last": "⟬person_name:family#1⟭",
    "dob": "⟬birth_date#1⟭",
    "ssn": "⟬us_ssn#1⟭",
    "member_id": "⟬customer_id#1⟭",
}


@pytest.fixture
def patient():
    return dict(PATIENT)
⟬end⟭

⟬template⟭
family: code
format: .sql
language: en
fill_locale: en_US
domain: government
appearance: comment, SQL UPDATE
scenario: benefits case worker's one-off fix recording an applicant's newly assigned ITIN and reopening the file
⟬text⟭
-- ⟬ticket_id#1⟭: applicant received the CP565 after we closed the file; record the ITIN
-- and reopen. Requested by ⟬person_name#2⟭ (case worker).
UPDATE benefits.applicants
SET itin = '⟬us_itin#1⟭',
    tin_status = 'verified',
    status = 'reopened',
    updated_at = now()
WHERE application_id = '⟬order_number#1⟭';
⟬end⟭

⟬template⟭
family: code
format: .sh
language: en
fill_locale: en_US
domain: SaaS
appearance: curl command, HTTP header, heredoc
scenario: developer's quick curl check that a booking extraction prompt still works after a model bump, with the API key typed into the header
⟬text⟭
# quick check that the extraction prompt still works after the model bump
curl -s https://api.anthropic.com/v1/messages \
  -H "x-api-key: ⟬anthropic_api_key#1⟭" \
  -H "anthropic-version: 2023-06-01" \
  -H "content-type: application/json" \
  --data @- <<'JSON' | jq -r '.content[0].text'
{"model": "claude-haiku-4-5", "max_tokens": 200,
 "messages": [{"role": "user", "content": "Return JSON {name, passport}: Booking for ⟬person_name#2⟭, passport ⟬us_passport#2⟭, seat 14C"}]}
JSON
⟬end⟭

⟬template⟭
family: code
format: .py
language: en
fill_locale: en_US
domain: insurance
appearance: keyword argument, comment
scenario: photo triage service loading a private hail damage classifier from the Hugging Face Hub at startup
⟬text⟭
# load the hail damage classifier for the photo triage service
from huggingface_hub import snapshot_download
from transformers import AutoImageProcessor, AutoModelForImageClassification

path = snapshot_download("claims-vision/hail-damage-vit", revision="v3", token="⟬huggingface_token#1⟭")
processor = AutoImageProcessor.from_pretrained(path)
model = AutoModelForImageClassification.from_pretrained(path).eval()
LABELS = model.config.id2label  # {0: "none", 1: "light", 2: "moderate", 3: "severe"}
⟬end⟭

⟬template⟭
family: code
format: .sql
language: en
fill_locale: en_US
domain: retail
appearance: SQL INSERT, comment
scenario: store finance clerk's insert of an ACH refund for a return originally paid by check, which the POS cannot refund
⟬text⟭
-- ACH refund for a return paid by check (the POS cannot refund checks).
-- Approved by the store manager, initialed ⟬trap:initials|R.T.⟭ in the paper log.
INSERT INTO finance.ach_refunds (store_id, return_id, payee_name, account_number, routing_number, amount, created_by)
VALUES (412, '⟬order_number#1⟭', '⟬person_name#1⟭', '⟬bank_account_number#1⟭', '110000000', 189.97, 'store-0412');
⟬end⟭

⟬template⟭
family: code
format: .py
language: en
fill_locale: en_US
domain: government
appearance: docstring, file path, command-line argument, f-string
scenario: passport office clerk's helper asking Claude whether a renewal photo meets the rules, with the usage line naming a real renewal
⟬text⟭
"""check_photo.py: pre-check a passport renewal photo before the clerk sees it.

    python check_photo.py photos/⟬us_passport#1⟭.jpg   # renewal of ⟬person_name#1⟭
"""
import base64
import sys

import anthropic

client = anthropic.Anthropic(api_key="⟬anthropic_api_key#1⟭")
RULES = "White background, no glasses, neutral expression, head 1 to 1 3/8 inches, taken in the last 6 months."

img = base64.b64encode(open(sys.argv[1], "rb").read()).decode()
msg = client.messages.create(model="claude-haiku-4-5", max_tokens=200, messages=[{"role": "user", "content": [
    {"type": "image", "source": {"type": "base64", "media_type": "image/jpeg", "data": img}},
    {"type": "text", "text": f"Does this passport photo meet these rules? {RULES} Answer PASS or FAIL: reason."},
]}])
print(msg.content[0].text)
⟬end⟭

⟬template⟭
family: code
format: .sh
language: en
fill_locale: en_US
domain: insurance
appearance: environment variable, command-line argument, comment
scenario: claims ops cron line summarizing the week's new auto claim notes with OpenAI for the Monday huddle, with a note about a claim that broke it
⟬text⟭
#!/bin/sh
# weekly: summarize new auto claim notes for the Monday huddle
cd /opt/claims-digest || exit 1
OPENAI_API_KEY=⟬openai_api_key#1⟭ .venv/bin/python summarize_claims.py --since "$(date -d '7 days ago' +%F)" --out digest.md
# last week it choked on claim ⟬order_number#1⟭ (plate ⟬us_license_plate#1⟭): 40 pages of photos OCR'd as text
⟬end⟭

⟬template⟭
family: code
format: .py
language: en
fill_locale: en_US
domain: fintech
appearance: assignment, exception message, comment, nested JSON
scenario: FastAPI auth dependency of a lending API verifying HS256 access tokens with a shared secret, with a captured staging token and its payload kept below
⟬text⟭
"""Auth dependency for the lending API: verifies the access token issued by our auth service.

Tokens are HS256 for now (secret shared with the auth service); RS256 migration in ⟬ticket_id#1⟭.
"""
import jwt
from fastapi import Depends, HTTPException
from fastapi.security import HTTPAuthorizationCredentials, HTTPBearer

JWT_SECRET = "⟬password#1⟭"
JWT_ALGORITHM = "HS256"
⟬trap:indicator_non_pii|JWT_AUDIENCE = "lending-api"⟭
bearer = HTTPBearer()


def current_user(creds: HTTPAuthorizationCredentials = Depends(bearer)) -> dict:
    try:
        claims = jwt.decode(creds.credentials, JWT_SECRET, algorithms=[JWT_ALGORITHM], audience=JWT_AUDIENCE)
    except jwt.ExpiredSignatureError:
        raise HTTPException(401, "token expired")
    except jwt.InvalidTokenError as exc:
        raise HTTPException(401, f"invalid token: {exc}")
    if "loans:read" not in claims.get("scope", "").split():
        raise HTTPException(403, "missing scope loans:read")
    return claims


# token captured from the staging app (expired since):
# ⟬jwt#2⟭
# its payload:
# {"sub": "⟬customer_id#2⟭", "name": "⟬person_name#2⟭", "email": "⟬email#2⟭", "tin": "⟬us_itin#2⟭",
#  "scope": "loans:read loans:apply", "aud": "lending-api", "iat": 1718200000, "exp": 1718203600}
⟬end⟭

⟬template⟭
family: code
format: .ipynb
language: en
fill_locale: en_US
domain: retail
appearance: notebook output, keyword argument, markdown cell, free text
scenario: e-commerce team's offline evaluation of a Claude product Q&A bot with a Hugging Face reranker, run on real customer questions
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Product Q&A bot: offline eval on real customer questions\n",
    "Retrieval from the catalog and FAQ, reranked, answered by Claude."
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
      "Q118 Do these boots run small? I wear a 9 in ⟬trap:company_name|⦃Family⦄ Outdoor⟭ hikers (asked by ⟬email#2⟭)\n",
      "Q240 can you ship to my office instead, ⟬postal_address#3⟭, ⟬person_name#3⟭ will sign\n",
      "Q377 is the ⟬trap:word_name|Ruby⟭ red color coming back in size M?\n"
     ]
    }
   ],
   "source": [
    "import anthropic\n",
    "import ⟬trap:library|pandas⟭ as pd\n",
    "from sentence_transformers import CrossEncoder\n",
    "\n",
    "claude = anthropic.Anthropic(api_key=\"⟬anthropic_api_key#1⟭\")\n",
    "reranker = CrossEncoder(\"retail-ml/qa-reranker\", token=\"⟬huggingface_token#1⟭\")\n",
    "questions = pd.read_csv(\"⟬file_path#1⟭\")\n",
    "for q in questions.loc[[118, 240, 377]].itertuples():\n",
    "    print(f\"Q{q.Index} {q.text}\")"
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
      "Yes, until the order ships you can change the shipping address to ⟬postal_address#3⟭ from the order page. Someone must sign for it.\n"
     ]
    }
   ],
   "source": [
    "def answer(question: str) -> str:\n",
    "    docs = retrieve(question, k=20)\n",
    "    scores = reranker.predict([(question, d.text) for d in docs])\n",
    "    top = [d.text for _, d in sorted(zip(scores, docs), key=lambda x: -x[0])[:4]]\n",
    "    msg = claude.messages.create(\n",
    "        model=\"claude-haiku-4-5\",\n",
    "        max_tokens=300,\n",
    "        system=\"Answer the shopper from the snippets only. Short and friendly.\",\n",
    "        messages=[{\"role\": \"user\", \"content\": \"\\n\\n\".join(top) + \"\\n\\nQuestion: \" + question}],\n",
    "    )\n",
    "    return msg.content[0].text\n",
    "\n",
    "print(answer(questions.loc[240, \"text\"]))"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "The bot repeats the address back. Fine for the shopper, but the conversation log keeps it: mask before logging."
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
appearance: comment, subquery, CASE expression
scenario: hospital privacy office's audit of every access to a high-profile patient's record, with the patient's identifiers in the request comment
⟬text⟭
-- Privacy office request ⟬ticket_id#1⟭: every access to the record of a high-profile patient
-- flown in from abroad last week. Registered with passport ⟬us_passport#1⟭ at admission,
-- SSN ⟬us_ssn#1⟭ added the next day. Name on the record: ⟬person_name#1⟭.
SELECT a.accessed_at,
       u.username,
       u.department,
       a.action,
       a.workstation,
       CASE WHEN EXISTS (
                SELECT 1 FROM ehr.care_team ct
                WHERE ct.encounter_id = a.encounter_id AND ct.user_id = a.user_id)
            THEN 'care team'
            ELSE 'REVIEW'
       END AS relationship
FROM audit.record_access a
JOIN ehr.users u ON u.user_id = a.user_id
WHERE a.patient_id = (SELECT patient_id FROM ehr.patients WHERE mrn = '⟬customer_id#1⟭')
  AND a.accessed_at >= current_date - 10
ORDER BY relationship DESC, a.accessed_at;
⟬end⟭

⟬template⟭
family: code
format: .ipynb
language: en
fill_locale: en_US
domain: SaaS
appearance: notebook output, environment variable, markdown cell, free text
scenario: tax-preparation SaaS ML engineer comparing a fine-tuned open embedding model with OpenAI embeddings for similar-case search over preparer notes
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Similar-case search over preparer notes\n",
    "Fine-tuned open embedding model vs OpenAI embeddings on 300 labeled note pairs."
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
      "client ⟬person_name#2⟭ brought CP565, ITIN ⟬us_itin#2⟭, wants to amend 2022 to add 2 dependents\n",
      "spouse ⟬person_name#3⟭ called from ⟬phone#3⟭ about refund status, told 21 days\n"
     ]
    }
   ],
   "source": [
    "import os\n",
    "\n",
    "os.environ[\"HF_TOKEN\"] = \"⟬huggingface_token#1⟭\"\n",
    "from openai import OpenAI\n",
    "from sentence_transformers import SentenceTransformer\n",
    "\n",
    "openai_client = OpenAI(api_key=\"⟬openai_api_key#1⟭\")\n",
    "st = SentenceTransformer(\"prep-ai/notes-bge-ft\")\n",
    "notes = load_notes(\"⟬file_path#1⟭\")\n",
    "print(notes[12])\n",
    "print(notes[507])"
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
      "recall@5  fine-tuned 0.84  openai 0.79\n",
      "p50 ms    fine-tuned 9     openai 180\n"
     ]
    }
   ],
   "source": [
    "ft = evaluate(pairs, lambda texts: st.encode(texts, normalize_embeddings=True))\n",
    "oa = evaluate(pairs, lambda texts: [d.embedding for d in openai_client.embeddings.create(model=\"text-embedding-3-small\", input=texts).data])\n",
    "print(f\"recall@5  fine-tuned {ft.recall:.2f}  openai {oa.recall:.2f}\")\n",
    "print(f\"p50 ms    fine-tuned {ft.p50_ms:<5.0f} openai {oa.p50_ms:.0f}\")"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "The fine-tuned model wins and stays in our VPC, so the notes never leave. Going with it."
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
domain: healthcare
appearance: docstring, EDI segment, dataclass, function
scenario: revenue-cycle developer's parser of 835 electronic remittance files, with a trimmed payer test file in the docstring
⟬text⟭
"""Parse 835 electronic remittance advice (ERA) files from payers into claim payments.

Only the segments we post from are handled: BPR (payment and EFT details), TRN (trace),
N1 (payer), CLP (claim), NM1*QC (patient) and SVC (service lines).

Trimmed sample from the payer's test file (one claim):

    BPR*I*1342.50*C*ACH*CCP*01*011000015*DA*⟬bank_account_number#1⟭*1512345678**01*110000000*DA*⟬bank_account_number#2⟭*20240612~
    TRN*1*⟬order_number#1⟭*1512345678~
    N1*PR*⟬company#3⟭~
    N3*⟬postal_address:street#3⟭~
    N4*⟬city#3⟭*TX*⟬postcode#3⟭~
    N1*PE*⟬company#4⟭*XX*1234567893~
    CLP*⟬order_number#5⟭*1*1500*1342.5**12*⟬customer_id#5⟭*11*1~
    NM1*QC*1*⟬person_name:family#5⟭*⟬person_name:given#5⟭****MI*⟬customer_id#6⟭~
    SVC*HC:99214*1500*1342.5**1~
"""
from dataclasses import dataclass, field
from decimal import Decimal


@dataclass
class ServiceLine:
    procedure: str
    charged: Decimal
    paid: Decimal


@dataclass
class ClaimPayment:
    claim_id: str
    status: str
    charged: Decimal
    paid: Decimal
    payer_claim_ref: str
    patient_last: str = ""
    patient_first: str = ""
    lines: list[ServiceLine] = field(default_factory=list)


@dataclass
class Remittance:
    amount: Decimal
    method: str
    trace: str = ""
    payer: str = ""
    payee_account: str = ""
    claims: list[ClaimPayment] = field(default_factory=list)


def parse_835(text: str) -> Remittance:
    elem_sep = text[3]                                   # ISA is fixed width: 4th char
    seg_term = text[105] if len(text) > 105 else "~"     # and the 106th ends the segment
    remit, claim = None, None
    for raw in filter(None, (s.strip() for s in text.split(seg_term))):
        el = raw.split(elem_sep)
        tag = el[0]
        if tag == "BPR":
            remit = Remittance(amount=Decimal(el[2]), method=el[4], payee_account=el[15] if len(el) > 15 else "")
        elif tag == "TRN" and remit:
            remit.trace = el[2]
        elif tag == "N1" and el[1] == "PR" and remit:
            remit.payer = el[2]
        elif tag == "CLP" and remit:
            claim = ClaimPayment(claim_id=el[1], status=el[2], charged=Decimal(el[3]), paid=Decimal(el[4]), payer_claim_ref=el[7])
            remit.claims.append(claim)
        elif tag == "NM1" and el[1] == "QC" and claim:
            claim.patient_last, claim.patient_first = el[3], el[4]
        elif tag == "SVC" and claim:
            claim.lines.append(ServiceLine(procedure=el[1].split(":")[-1], charged=Decimal(el[2]), paid=Decimal(el[3])))
    if remit is None:
        raise ValueError("no BPR segment: not an 835 file")
    return remit


def unbalanced(remit: Remittance) -> list[str]:
    """Claims whose service lines do not add up to the claim payment."""
    return [c.claim_id for c in remit.claims if c.lines and sum(line.paid for line in c.lines) != c.paid]
⟬end⟭

⟬template⟭
family: code
format: .py
language: en
fill_locale: en_US
domain: SaaS
appearance: keyword argument, list literal, dict literal, docstring
scenario: sales engineering's FastAPI and SQLAlchemy contacts API for the CRM demo environment, with the seed contacts and demo admin login used in every demo
⟬text⟭
"""Contacts API for the CRM demo environment, plus the seed data sales uses in demos.

Run `python -m crm.demo seed` after every demo reset. Avatars go to the demo bucket so
the UI shows faces instead of initials.
"""
import boto3
from fastapi import Depends, FastAPI, HTTPException
from sqlalchemy import String, create_engine, select
from sqlalchemy.orm import DeclarativeBase, Mapped, Session, mapped_column, sessionmaker

engine = create_engine("sqlite:///demo.db")
SessionLocal = sessionmaker(engine)
s3 = boto3.client("s3", aws_access_key_id="⟬aws_access_key_id#1⟭", aws_secret_access_key="⟬aws_secret_access_key#1⟭")
DEMO_ADMIN = {"email": "⟬email:generic#9⟭", "password": "⟬password#1⟭"}


class Base(DeclarativeBase):
    pass


class Contact(Base):
    __tablename__ = "contacts"
    id: Mapped[int] = mapped_column(primary_key=True)
    name: Mapped[str] = mapped_column(String(120))
    email: Mapped[str] = mapped_column(String(200), unique=True)
    phone: Mapped[str | None] = mapped_column(String(30))
    company: Mapped[str | None] = mapped_column(String(120))
    address: Mapped[str | None] = mapped_column(String(300))
    stage: Mapped[str] = mapped_column(String(20), default="lead")


app = FastAPI(title="crm-demo")


def db():
    with SessionLocal() as session:
        yield session


@app.get("/contacts/{contact_id}")
def get_contact(contact_id: int, session: Session = Depends(db)):
    contact = session.get(Contact, contact_id)
    if contact is None:
        raise HTTPException(404)
    return {column.name: getattr(contact, column.name) for column in Contact.__table__.columns}


@app.get("/contacts")
def list_contacts(stage: str | None = None, session: Session = Depends(db)):
    query = select(Contact).order_by(Contact.name)
    if stage:
        query = query.where(Contact.stage == stage)
    return [{"id": c.id, "name": c.name, "company": c.company, "stage": c.stage} for c in session.scalars(query)]


SEED = [
    Contact(name="⟬person_name#2⟭", email="⟬email#2⟭", phone="⟬phone#2⟭", company="⟬company#2⟭", address="⟬postal_address#2⟭", stage="customer"),
    Contact(name="⟬person_name#3⟭", email="⟬email#3⟭", phone="⟬phone#3⟭", company="⟬company#3⟭", address="⟬postal_address#3⟭", stage="opportunity"),
    Contact(name="⟬person_name#4⟭", email="⟬email#4⟭", phone=None, company="⟬company#4⟭", address=None, stage="lead"),
    Contact(name="⟬person_name#5⟭", email="⟬email#5⟭", phone="⟬phone#5⟭", company=None, address="⟬postal_address#5⟭", stage="churned"),
]


def seed():
    Base.metadata.drop_all(engine)
    Base.metadata.create_all(engine)
    with SessionLocal.begin() as session:
        session.add_all(SEED)
    for i, contact in enumerate(SEED, 1):
        s3.upload_file(f"demo/avatars/{i}.jpg", "crm-demo-assets", f"avatars/{contact.email}.jpg")
⟬end⟭

⟬template⟭
family: code
format: .sh
language: en
fill_locale: en_US
domain: SaaS
appearance: environment variable, command-line argument, comment
scenario: developer's script starting the API locally, with secrets read from a password manager CLI at launch
⟬text⟭
#!/usr/bin/env bash
# run_api.sh: start the API locally with the dev env file; secrets come from the 1Password CLI.
set -euo pipefail
export ⟬trap:placeholder|OPENAI_API_KEY="$(op read op://dev/openai/credential)"⟭
export ⟬trap:indicator_non_pii|DB_USER=app_dev⟭
exec uvicorn app.main:app --reload --port 8000 --env-file .env.dev
⟬end⟭

⟬template⟭
family: code
format: .sql
language: en
fill_locale: en_US
domain: retail
appearance: comment, SQL WHERE, window function
scenario: merchandising analyst's top sellers per category excluding the store's own brands
⟬text⟭
-- top 10 sellers per category, last 4 weeks; own brands excluded (merch wants national brands only)
SELECT category, sku, sum(units) AS units
FROM sales.weekly_sku
WHERE week >= current_date - 28
  AND brand NOT IN (⟬trap:company_name|'⦃Family⦄ & Co'⟭, 'Harbor Home')
GROUP BY category, sku
QUALIFY row_number() OVER (PARTITION BY category ORDER BY sum(units) DESC) <= 10;
⟬end⟭

⟬template⟭
family: code
format: .py
language: en
fill_locale: en_US
domain: fintech
appearance: docstring, function, comment
scenario: ledger engineer's rounding helpers matching the core ledger's half-even rounding, written after a penny drift incident
⟬text⟭
from decimal import ROUND_HALF_EVEN, Decimal

CENT = Decimal("0.01")


def to_cents(amount: Decimal) -> Decimal:
    """Round half to even, as the core ledger does (agreed with ⟬trap:initials|JR⟭ after the
    penny drift incident). Never pass a float here."""
    return amount.quantize(CENT, rounding=ROUND_HALF_EVEN)


def split_evenly(total: Decimal, parts: int) -> list[Decimal]:
    base = to_cents(total / parts)
    shares = [base] * parts
    shares[-1] += total - base * parts  # the last share absorbs the remainder
    return shares
⟬end⟭

⟬template⟭
family: code
format: .ipynb
language: en
fill_locale: en_US
domain: healthcare
appearance: notebook output, function, markdown cell
scenario: hospital capacity planner's notebook sizing ICU beds with a queueing formula from aggregate admission counts
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# ICU bed sizing with ⟬trap:eponym|Erlang⟭ C\n",
    "How many staffed ICU beds keep the probability that an admission waits for a bed under 5%? Aggregate counts only."
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
      "arrivals 6.2/day, mean LOS 3.4 days, offered load 21.1 beds\n"
     ]
    }
   ],
   "source": [
    "import math\n",
    "\n",
    "import ⟬trap:library|pandas⟭ as pd\n",
    "\n",
    "adm = pd.read_csv(\"⟬file_path#1⟭\", parse_dates=[\"admit_day\"])\n",
    "lam = adm.groupby(\"admit_day\").size().mean()\n",
    "los = adm[\"los_days\"].mean()\n",
    "load = lam * los\n",
    "print(f\"arrivals {lam:.1f}/day, mean LOS {los:.1f} days, offered load {load:.1f} beds\")"
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
      "beds 24  P(wait) 0.142\n",
      "beds 25  P(wait) 0.091\n",
      "beds 26  P(wait) 0.047\n",
      "beds 27  P(wait) 0.022\n"
     ]
    }
   ],
   "source": [
    "def p_wait(servers: int, load: float) -> float:\n",
    "    top = load ** servers / math.factorial(servers) * servers / (servers - load)\n",
    "    bottom = sum(load ** k / math.factorial(k) for k in range(servers)) + top\n",
    "    return top / bottom\n",
    "\n",
    "for beds in range(24, 28):\n",
    "    print(f\"beds {beds}  P(wait) {p_wait(beds, load):.3f}\")"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "26 staffed beds for under 5%; we run 24 most nights. Counts as of ⟬date#1⟭."
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
format: .py
language: en
fill_locale: en_US
domain: insurance
appearance: class attribute, keyword argument
scenario: claims system's SQLAlchemy model with column comments and a default adjuster value
⟬text⟭
from sqlalchemy import Column, Date, Integer, Numeric, String
from sqlalchemy.orm import declarative_base

Base = declarative_base()


class Claim(Base):
    __tablename__ = "claims"
    id = Column(Integer, primary_key=True)
    claim_number = Column(String(20), unique=True, nullable=False)
    claimant_name = Column(String(200), comment="encrypted at rest (pgcrypto)")
    loss_date = Column(Date, nullable=False)
    reserve = Column(Numeric(12, 2), default=0)
    ⟬trap:indicator_non_pii|adjuster = Column(String(60), default="unassigned")⟭
⟬end⟭
