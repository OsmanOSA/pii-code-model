⟬template⟭
family: code
format: .py
language: en
fill_locale: en_US
domain: SaaS
appearance: keyword argument, connection string, docstring
scenario: backfill script for usage rollups whose argparse defaults hold the database URL with its password and the person to notify
⟬text⟭
"""backfill_usage.py: recompute the daily usage rollups for a date range."""
import argparse

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument("--start", required=True, help="first day, YYYY-MM-DD")
parser.add_argument("--end", required=True, help="last day, YYYY-MM-DD")
parser.add_argument("--db-url", default="postgresql://rollup:⟬url_password#1⟭@⟬hostname#1⟭:5432/usage")
parser.add_argument("--notify", default="⟬email#2⟭", help="who gets the summary email")
parser.add_argument("--dry-run", action="store_true")
args = parser.parse_args()
⟬end⟭

⟬template⟭
family: code
format: .sql
language: en
fill_locale: en_US
domain: healthcare
appearance: SQL WHERE, comment, pipe-delimited record
scenario: dental practice's monthly query listing patients to send birthday postcards to, with last month's first row kept in a comment
⟬text⟭
-- birthday postcards for the month (the front desk prints them on the 1st)
SELECT p.first_name, p.last_name, p.dob, p.mailing_address
FROM dental.patients p
WHERE extract(month FROM p.dob) = extract(month FROM current_date)
  AND p.marketing_opt_in
  AND p.last_visit >= current_date - interval '18 months'
ORDER BY extract(day FROM p.dob);
-- first row last month: ⟬person_name:given#1⟭ | ⟬person_name:family#1⟭ | ⟬birth_date#1⟭ | ⟬postal_address#1⟭
⟬end⟭

⟬template⟭
family: code
format: .sh
language: en
fill_locale: en_US
domain: retail
appearance: heredoc, CSV cell, command-line argument
scenario: QA engineer loading three test members into a loyalty sandbox from a headerless CSV written in a heredoc
⟬text⟭
# load three test members into the loyalty sandbox (no header; the importer expects
# id,name,email,phone,address,tier)
cat > /tmp/members.csv <<'CSV'
⟬customer_id#1⟭,"⟬person_name#1⟭",⟬email#1⟭,⟬phone#1⟭,"⟬postal_address#1⟭",gold
⟬customer_id#2⟭,"⟬person_name#2⟭",⟬email#2⟭,⟬phone#2⟭,"⟬postal_address#2⟭",silver
⟬customer_id#3⟭,"⟬person_name#3⟭",⟬email#3⟭,,"⟬postal_address#3⟭",basic
CSV
python -m loyalty.import --env sandbox --no-header /tmp/members.csv
⟬end⟭

⟬template⟭
family: code
format: .py
language: en
fill_locale: en_US
domain: fintech
appearance: exception message, traceback, comment
scenario: loan servicing function rejecting payments from unlinked accounts, with a failing CI assertion pasted below it
⟬text⟭
def apply_payment(loan, amount_cents: int, source_account: str) -> None:
    if source_account not in loan.borrower.linked_accounts:
        raise PermissionError(f"account {source_account} is not linked to borrower {loan.borrower.id}")
    if amount_cents <= 0:
        raise ValueError(f"payment must be positive, got {amount_cents}")
    loan.ledger.post(-amount_cents, memo=f"payment from {source_account}")


# failing CI run, test_autopay.py::test_autopay_from_joint_account:
# E   PermissionError: account ⟬bank_account_number#1⟭ is not linked to borrower ⟬customer_id#1⟭
# (joint account opened by ⟬person_name#2⟭ on ⟬date#1⟭, linked only to the co-borrower)
⟬end⟭

⟬template⟭
family: code
format: .ipynb
language: en
fill_locale: en_US
domain: government
appearance: notebook output, triple-quoted string, function, markdown cell
scenario: unemployment insurance analyst re-running identity checks on a claims backlog through a vendor API with private-key JWT client authentication pasted into the notebook
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# UI claims: identity verification backlog\n",
    "Re-run identity checks for claims stuck in `pending_idv` through the verification vendor (private-key JWT client auth)."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "metadata": {},
   "outputs": [],
   "source": [
    "import time\n",
    "import uuid\n",
    "\n",
    "import jwt\n",
    "import requests\n",
    "\n",
    "CLIENT_ID = \"ui-claims-batch\"\n",
    "TOKEN_URL = \"⟬url#1⟭\"\n",
    "PRIVATE_KEY = \"\"\"⟬private_key#1⟭\"\"\"\n",
    "\n",
    "def client_assertion():\n",
    "    now = int(time.time())\n",
    "    claims = {\"iss\": CLIENT_ID, \"sub\": CLIENT_ID, \"aud\": TOKEN_URL, \"iat\": now, \"exp\": now + 300, \"jti\": str(uuid.uuid4())}\n",
    "    return jwt.encode(claims, PRIVATE_KEY, algorithm=\"RS256\")"
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
       "      claim_id         claimant          ssn                 address       status\n",
       "0  ⟬order_number#2⟭  ⟬person_name#2⟭  ⟬us_ssn#2⟭  ⟬postal_address#2⟭  pending_idv\n",
       "1  ⟬order_number#3⟭  ⟬person_name#3⟭  ⟬us_ssn#3⟭  ⟬postal_address#3⟭  pending_idv"
      ]
     },
     "execution_count": 2,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "backlog = pd.read_sql(\"SELECT claim_id, claimant, ssn, address, status FROM ui.claims WHERE status = 'pending_idv'\", engine)\n",
    "backlog.head(2)"
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
      "verified 1812, failed 240, vendor_error 31\n"
     ]
    }
   ],
   "source": [
    "token = requests.post(TOKEN_URL, data={\"grant_type\": \"client_credentials\", \"client_assertion_type\": \"urn:ietf:params:oauth:client-assertion-type:jwt-bearer\", \"client_assertion\": client_assertion()}, timeout=30).json()[\"access_token\"]\n",
    "results = [verify(token, row) for row in backlog.itertuples()]\n",
    "print(\", \".join(f\"{k} {v}\" for k, v in Counter(r.outcome for r in results).items()))"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Failed checks go to the manual review queue; vendor errors are retried tomorrow. Backlog as of ⟬date#1⟭."
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
domain: insurance
appearance: comment, SQL UPDATE, SQL INSERT
scenario: life insurance operations clerk applying a beneficiary change received by mail
⟬text⟭
-- beneficiary change received by mail for policy ⟬customer_id#1⟭ (form signed ⟬date#1⟭)
UPDATE life.beneficiaries
SET pct = 0, revoked_on = current_date
WHERE policy_id = '⟬customer_id#1⟭' AND beneficiary_type = 'primary';

INSERT INTO life.beneficiaries (policy_id, beneficiary_type, full_name, relationship, dob, ssn, pct)
VALUES ('⟬customer_id#1⟭', 'primary', '⟬person_name#2f⟭', 'daughter', '⟬birth_date#2⟭', '⟬us_ssn#2⟭', 100);
⟬end⟭

⟬template⟭
family: code
format: .py
language: en
fill_locale: en_US
domain: retail
appearance: query string, HTTP header, log message, comment
scenario: order tracking proxy to a carrier API that needs the recipient's phone or ZIP, with an access log line from a support escalation
⟬text⟭
# where is my order: proxy to the carrier tracking API (the carrier wants a phone or ZIP before it shows the address)
import requests

CARRIER_KEY = "⟬opaque_token#1⟭"


def track(tracking_number: str, phone: str | None = None, zip_code: str | None = None) -> dict:
    params = {"num": tracking_number, "phone": phone, "zip": zip_code}
    resp = requests.get("⟬url#1⟭", params={k: v for k, v in params.items() if v}, headers={"X-Api-Key": CARRIER_KEY}, timeout=10)
    resp.raise_for_status()
    return resp.json()

# access log line from the support escalation:
# GET /track?num=⟬order_number#2⟭&phone=⟬phone#2⟭&zip=⟬postcode#2⟭ 200 412ms
⟬end⟭

⟬template⟭
family: code
format: .py
language: en
fill_locale: en_US
domain: insurance
appearance: dict literal, assignment, docstring
scenario: claims intake helper checking OCR'd license plates against each state's format before the DMV lookup
⟬text⟭
"""Plate format checks per state, to catch OCR misreads before the DMV lookup."""
import re

PLATE_FORMATS = {
    "TX": re.compile(r"^[A-Z]{3}-?\d{4}$"),
    "CA": re.compile(r"^\d[A-Z]{3}\d{3}$"),
    "NY": re.compile(r"^[A-Z]{3}-?\d{4}$"),
    "FL": re.compile(r"^[A-Z0-9]{4}-?[A-Z0-9]{2,3}$"),
}
EXAMPLE_PLATE = ⟬trap:placeholder|"ABC-1234"⟭  # shown as the form hint


def plausible(plate: str, state: str) -> bool:
    pattern = PLATE_FORMATS.get(state)
    return bool(pattern.match(plate.upper().replace(" ", ""))) if pattern else True
⟬end⟭

⟬template⟭
family: code
format: .sql
language: en
fill_locale: en_US
domain: government
appearance: comment, SQL WHERE
scenario: council dashboard tile counting business permits per ward and month
⟬text⟭
-- business permits issued per ward and month for the council dashboard (aggregates only;
-- residential permits are in the other tile)
SELECT ward, date_trunc('month', issued_on)::date AS month, permit_type, count(*) AS permits
FROM permits.issued
WHERE issued_on >= date_trunc('year', current_date) - interval '1 year'
  AND ⟬trap:indicator_non_pii|applicant_type <> 'individual'⟭
GROUP BY 1, 2, 3
ORDER BY 1, 2, 3;
⟬end⟭

⟬template⟭
family: code
format: .sh
language: en
fill_locale: en_US
domain: healthcare
appearance: command-line argument, environment variable, comment
scenario: quality team's monthly export of quality measure aggregates for the state upload portal
⟬text⟭
#!/usr/bin/env bash
# export_quality_measures.sh: dump last month's quality measure aggregates for the state upload
set -euo pipefail
: "⟬trap:placeholder|${PGPASSWORD:?set PGPASSWORD from the vault first}⟭"
psql -h ⟬hostname#1⟭ -U ⟬username#1⟭ -d quality -v ON_ERROR_STOP=1 \
  -c "\copy (SELECT measure_id, period, numerator, denominator FROM measures.monthly WHERE period = date_trunc('month', current_date) - interval '1 month') TO 'measures.csv' CSV HEADER"
gzip -f measures.csv && echo "measures.csv.gz ready for the upload portal"
⟬end⟭
