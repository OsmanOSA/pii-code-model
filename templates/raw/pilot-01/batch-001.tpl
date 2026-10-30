⟬template⟭
family: code
format: .py
language: en
fill_locale: en_US
domain: healthcare
appearance: docstring, assignment, string literal, comment, function call, nested dict
scenario: nightly cron script of a dental clinic network that sends appointment reminders, written by a contractor and never cleaned up
⟬text⟭
#!/usr/bin/env python3
"""Send next-day appointment reminders by SMS and email.

Maintainer: ⟬person_name#1⟭ <⟬email#1⟭>
Runs from cron on ⟬hostname#1⟭ at 18:00 local time.
"""
import logging
import smtplib
from email.message import EmailMessage

import requests
from ⟬trap:library|jinja2⟭ import Template

log = logging.getLogger("reminders")

SMTP_HOST = "⟬hostname#2⟭"
SMTP_USER = "⟬email:generic#2⟭"
SMTP_PASS = "⟬password#1⟭"  # TODO move to vault before go-live
SMS_API_KEY = "⟬opaque_token#1⟭"
SMS_ENDPOINT = "⟬url#1⟭"
⟬trap:indicator_non_pii|PHONE_COUNTRY_DEFAULT = "US"⟭

TEMPLATE = Template(
    "Hi {{ first_name }}, this is a reminder of your appointment "
    "tomorrow at {{ time }} with Dr. {{ dentist }}. Reply STOP to opt out."
)


def send_sms(phone, body):
    resp = requests.post(
        SMS_ENDPOINT,
        headers={"Authorization": f"Bearer {SMS_API_KEY}"},
        json={"to": phone, "text": body},
        timeout=10,
    )
    resp.raise_for_status()


def send_email(to_addr, body):
    msg = EmailMessage()
    msg["From"] = SMTP_USER
    msg["To"] = to_addr
    msg["Subject"] = "Your appointment tomorrow"
    msg.set_content(body)
    with smtplib.SMTP(SMTP_HOST, 587) as smtp:
        smtp.starttls()
        smtp.login(SMTP_USER, SMTP_PASS)
        smtp.send_message(msg)


def remind(appt):
    body = TEMPLATE.render(
        first_name=appt["first_name"], time=appt["time"], dentist=appt["dentist"]
    )
    if appt.get("phone"):
        send_sms(appt["phone"], body)
    send_email(appt["email"], body)
    log.info("reminder sent for appointment %s", appt["id"])


if __name__ == "__main__":
    # manual test with my own number, remove before commit
    remind({
        "id": "⟬uuid#1⟭",
        "first_name": "⟬person_name:given#1⟭",
        "dentist": "⟬person_name:family#3⟭",
        "time": "09:30",
        "phone": "⟬phone#1⟭",
        "email": "⟬email#1⟭",
    })
⟬end⟭

⟬template⟭
family: code
format: .sql
language: fr
fill_locale: fr_FR
domain: HR
appearance: comment, SQL INSERT, SQL WHERE
scenario: staging seed script of a payroll application, copied from production by an intern and only partly anonymised
⟬text⟭
-- Jeu de données de recette - module paie
-- Auteur : ⟬person_name#1⟭, le ⟬date#1⟭
-- ATTENTION : extrait de prod du ⟬date#2⟭, anonymisation incomplète (voir ⟬ticket_id#1⟭)

BEGIN;

INSERT INTO salarie (matricule, nom, prenom, date_naissance, nir, date_embauche, poste)
VALUES
  ('M0412', '⟬person_name:family#2⟭', '⟬person_name:given#2⟭', '⟬birth_date#2⟭', '⟬fr_social_security_number#2⟭', '⟬date#3⟭', '⟬job_title#2⟭'),
  ('M0413', '⟬person_name:family#3⟭', '⟬person_name:given#3⟭', '⟬birth_date#3⟭', '⟬fr_social_security_number#3⟭', '⟬date#4⟭', '⟬job_title#3⟭'),
  ('M0415', '⟬person_name:family#4⟭', '⟬person_name:given#4⟭', '⟬birth_date#4⟭', '⟬fr_social_security_number#4⟭', '⟬date#5⟭', '⟬job_title#4⟭');

INSERT INTO coordonnees (matricule, adresse, tel_perso, mail_perso)
VALUES
  ('M0412', '⟬fr_postal_address#2⟭', '⟬phone#2⟭', '⟬email#2⟭'),
  ('M0413', '⟬fr_postal_address#3⟭', '⟬phone#3⟭', '⟬email#3⟭'),
  ('M0415', '⟬fr_postal_address#4⟭', NULL, '⟬email#4⟭');

INSERT INTO rib (matricule, iban, bic, titulaire)
VALUES
  ('M0412', '⟬iban#2⟭', '⟬bic#2⟭', '⟬person_name#2⟭'),
  ('M0413', '⟬iban#3⟭', '⟬bic#3⟭', '⟬person_name#3⟭');

-- le compte technique ne doit pas recevoir de bulletin
UPDATE salarie SET actif = false WHERE ⟬trap:indicator_non_pii|nom = 'COMPTE_SERVICE'⟭;

-- vérif rapide
SELECT nom, prenom FROM salarie WHERE nom = '⟬person_name:family#3⟭' AND actif = true;

COMMIT;
⟬end⟭

⟬template⟭
family: code
format: .ts
language: mixed
fill_locale: fr_FR
domain: e-commerce
appearance: import, comment, string literal, object literal, test fixture
scenario: Stripe payment service of a French online wine shop, with a debug fixture a developer pasted from a support ticket
⟬text⟭
import Stripe from "stripe";
import { Injectable, Logger } from "⟬trap:email_lookalike|@nestjs/common⟭";
import { ⟬trap:code_identifier|format⦃Family⦄Ref⟭ } from "./legacy/refs";

// FIXME: clé en dur pour débloquer la recette, à retirer avant la MEP (cf. ⟬ticket_id#1⟭)
const STRIPE_KEY = process.env.STRIPE_SECRET_KEY ?? "⟬stripe_secret_key#1⟭";
export const PUBLISHABLE_KEY = "⟬stripe_publishable_key#1⟭";

@Injectable()
export class PaymentService {
  private readonly stripe = new Stripe(STRIPE_KEY, { apiVersion: "2024-06-20" });
  private readonly logger = new Logger(PaymentService.name);

  async chargeOrder(orderId: string, amountCents: number, customerRef: string) {
    this.logger.log(`charge ${orderId} for ${⟬trap:code_identifier|format⦃Family⦄Ref⟭(customerRef)}`);
    return this.stripe.paymentIntents.create({
      amount: amountCents,
      currency: "eur",
      metadata: { orderId },
    });
  }
}

// --- données de debug, ticket support du ⟬date#1⟭ ---
// La cliente dit que le paiement échoue pour la cuvée "⟬trap:word_name|Margaux⟭ 2019"
export const DEBUG_CUSTOMER = {
  name: "⟬person_name#1f⟭",
  email: "⟬email#1⟭",
  phone: "⟬phone#1⟭",
  shipping: {
    line1: "⟬fr_postal_address:street#1⟭",
    postalCode: "⟬postcode#1⟭",
    city: "⟬city#1⟭",
    country: "FR",
  },
  card: { number: "⟬payment_card#1⟭", cvc: "⟬card_security_code#1⟭", exp: "09/27" },
  order: "⟬order_number#1⟭",
};
⟬end⟭

⟬template⟭
family: config
format: .env
language: en
fill_locale: en_US
domain: fintech
appearance: comment, assignment, url, placeholder, multiline key
scenario: .env.staging of a lending startup, committed by mistake on a feature branch and found during a security review
⟬text⟭
# ---- Lending API, staging ----
# owner: ⟬trap:indicator_non_pii|platform-team⟭ / on-call ⟬person_name#1⟭ ⟬phone#1⟭
NODE_ENV=staging
PORT=8080
LOG_LEVEL=debug

DATABASE_URL=postgres://lending_rw:⟬url_password#1⟭@⟬hostname#1⟭:5432/lending
DATABASE_REPLICA_URL=postgres://lending_ro:⟬trap:placeholder|${REPLICA_PASSWORD}⟭@⟬hostname#2⟭:5432/lending
REDIS_URL=redis://⟬hostname#3⟭:6379/0

AWS_REGION=us-east-1
AWS_ACCESS_KEY_ID=⟬aws_access_key_id#1⟭
AWS_SECRET_ACCESS_KEY=⟬aws_secret_access_key#1⟭
S3_BUCKET=lending-staging-docs

SENDGRID_API_KEY=⟬sendgrid_api_key#1⟭
MAIL_FROM=⟬email:generic#2⟭
ADMIN_EMAILS=⟬email#1⟭,⟬email#3⟭

OPENAI_API_KEY=⟬openai_api_key#1⟭
PLAID_CLIENT_ID=⟬hash#1⟭
PLAID_SECRET=⟬opaque_token#1⟭

GITHUB_APP_ID=318245
GITHUB_APP_PRIVATE_KEY="⟬private_key#1⟭"

JWT_SIGNING_KEY=⟬opaque_token#2⟭
⟬trap:indicator_non_pii|JWT_TTL_SECONDS=900⟭
⟬trap:indicator_non_pii|PASSWORD_MIN_LENGTH=12⟭
KYC_WEBHOOK_SECRET=⟬trap:placeholder|<set-in-vault>⟭
⟬end⟭

⟬template⟭
family: config
format: docker-compose.yml
language: fr
fill_locale: fr_FR
domain: public administration
appearance: comment, YAML value, label, environment variable, placeholder
scenario: docker-compose of a town hall's civil-status booking portal, maintained by a contractor and emailed to the IT department
⟬text⟭
# Portail RDV état civil - environnement de démo
# Prestataire : ⟬company#1⟭ - contact technique ⟬person_name#1⟭ <⟬email#1⟭>
# Ne pas déployer en prod sans validation de la DSI (⟬person_name:initial#2⟭)
version: "3.9"

services:
  db:
    image: postgres:16-alpine
    restart: unless-stopped
    environment:
      POSTGRES_DB: rdv
      POSTGRES_USER: rdv_app
      POSTGRES_PASSWORD: "⟬password#1⟭"
    volumes:
      - pgdata:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U rdv_app -d rdv"]
      interval: 10s

  pgadmin:
    image: dpage/pgadmin4:8
    environment:
      PGADMIN_DEFAULT_EMAIL: "⟬email:generic#3⟭"
      PGADMIN_DEFAULT_PASSWORD: "⟬trap:placeholder|${PGADMIN_PASSWORD}⟭"
    ports:
      - "5050:80"

  app:
    image: ⟬hostname#4⟭/mairie/rdv-portail:⟬version#1⟭
    depends_on: [db]
    labels:
      maintainer: "⟬person_name#1⟭ <⟬email#1⟭>"
      fr.mairie.siret: "⟬fr_siret#1⟭"
    environment:
      DATABASE_URL: "postgresql://rdv_app:⟬trap:placeholder|${POSTGRES_PASSWORD}⟭@db:5432/rdv"
      SMTP_HOST: ⟬hostname#5⟭
      SMTP_FROM: "⟬email:generic#4⟭"
      FRANCECONNECT_CLIENT_SECRET: "⟬opaque_token#1⟭"
      CHATBOT_API_KEY: "⟬anthropic_api_key#1⟭"
      SLACK_ALERT_TOKEN: "⟬slack_token#1⟭"
      ⟬trap:indicator_non_pii|SESSION_SECRET_ROTATION_DAYS: "30"⟭
      ⟬trap:indicator_non_pii|AGENT_DEFAULT_NAME: "Accueil"⟭
    ports:
      - "8080:8080"

volumes:
  pgdata:
⟬end⟭

⟬template⟭
family: config
format: .json
language: en
fill_locale: en_GB
domain: logistics
appearance: nested JSON, connection string, JSON array
scenario: appsettings.Production.json of a parcel-tracking API, attached to a support ticket by a junior developer
⟬text⟭
{
  "Logging": {
    "LogLevel": { "Default": "Information", "Microsoft.AspNetCore": "Warning" }
  },
  "ConnectionStrings": {
    "Tracking": "Server=⟬hostname#1⟭,1433;Database=Tracking;User Id=tracking_api;Password=⟬password#1⟭;Encrypt=True;",
    "Cache": "⟬hostname#2⟭:6380,password=⟬opaque_token#1⟭,ssl=True,abortConnect=False"
  },
  "Maps": { "Provider": "Google", "ApiKey": "⟬google_api_key#1⟭" },
  "Fleet": {
    "Depot": { "Address": "⟬postal_address#4⟭", "Postcode": "⟬postcode#4⟭" },
    "Vans": ["⟬uk_license_plate#5⟭", "⟬uk_license_plate#6⟭"],
    "Drivers": [
      { "Name": "⟬person_name#7⟭", "Licence": "⟬uk_driving_licence#7⟭", "Mobile": "⟬phone#7⟭" },
      { "Name": "⟬person_name#8⟭", "Licence": "⟬uk_driving_licence#8⟭", "Mobile": "⟬phone#8⟭" }
    ]
  },
  "Support": {
    "DutyManager": "⟬person_name#1⟭",
    "DutyPhone": "⟬phone#1⟭",
    "Mailbox": "⟬email:generic#2⟭",
    "Escalation": ["⟬email#1⟭", "⟬email#3⟭"]
  },
  "Jwt": { "Issuer": "⟬url#1⟭", "Audience": "tracking-api", "SigningKey": "⟬opaque_token#2⟭", "ExpiryMinutes": 30 },
  "Routing": { "Algorithm": "⟬trap:eponym|Dijkstra⟭", "⟬trap:code_identifier|UseKalmanSmoothing⟭": true }
}
⟬end⟭

⟬template⟭
family: logs
format: application log
language: en
fill_locale: en_US
domain: SaaS
appearance: log field, query string, HTTP header, JSON log line, exception message
scenario: excerpt of an Express API log pasted into an incident channel after a spike of failed logins
⟬text⟭
2025-03-11T08:14:02.118Z INFO  [http] GET /healthz 200 2ms
2025-03-11T08:14:05.402Z INFO  [auth] login ok user_id=48213 email=⟬email#1⟭ ip=⟬ip_address#1⟭
2025-03-11T08:14:05.977Z WARN  [auth] login failed email=⟬email#2⟭ ip=⟬ip_address#2⟭ reason=bad_password attempts=3
2025-03-11T08:14:06.010Z WARN  [auth] login failed email=⟬email#2⟭ ip=⟬ip_address#2⟭ reason=bad_password attempts=4
2025-03-11T08:14:06.533Z ERROR [auth] account locked for ⟬person_name#2⟭ (⟬email#2⟭), notify=true
2025-03-11T08:14:07.120Z DEBUG [http] POST /v2/session headers={"user-agent":"okhttp/4.12.0","authorization":"Bearer ⟬jwt#1⟭"}
2025-03-11T08:14:07.388Z INFO  [http] GET /v2/export?format=csv&access_token=⟬opaque_token#1⟭ 200 418ms
2025-03-11T08:14:08.002Z INFO  [billing] {"event":"invoice.created","invoice":"⟬invoice_number#1⟭","customer":"⟬customer_id#3⟭","contact":"⟬person_name#3⟭"}
2025-03-11T08:14:08.940Z ERROR [billing] card declined for customer ⟬customer_id#3⟭: card=⟬payment_card#3⟭ exp=11/26 code=do_not_honor
2025-03-11T08:14:09.311Z INFO  [auth] password reset requested by ⟬person_name:handle#4⟭ from ⟬ip_address#3⟭
2025-03-11T08:14:09.874Z INFO  [cron] ⟬trap:indicator_non_pii|user=admin⟭ job=purge-sessions started
2025-03-11T08:14:11.205Z WARN  [kyc] SSN mismatch for applicant ⟬uuid#1⟭: submitted ⟬us_ssn#5⟭, bureau returned ⟬us_ssn#6⟭
2025-03-11T08:14:11.902Z INFO  [kyc] document accepted: type=driver_license state=CA number=⟬us_driver_license#5⟭
2025-03-11T08:14:12.660Z INFO  [http] GET /v2/users/⟬uuid#2⟭/avatar 304 1ms
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: mixed
fill_locale: fr_FR
domain: banking
appearance: exception message, log field, stack frame, JSON payload
scenario: Java stack trace of a SEPA direct-debit batch, pasted into a Jira ticket by the operations team
⟬text⟭
2025-02-03 02:15:44,871 ERROR [sepa-batch-7] c.b.s.batch.MandateStep - Échec du traitement du mandat ⟬customer_id#1⟭
com.banque.sepa.validation.MandateValidationException: IBAN invalide pour le débiteur ⟬person_name#1⟭ (⟬iban#1⟭) - clé de contrôle incorrecte
	at com.banque.sepa.validation.IbanValidator.check(IbanValidator.java:88)
	at com.banque.sepa.batch.MandateStep.process(MandateStep.java:142)
	at com.banque.sepa.batch.⟬trap:code_identifier|Legacy⦃Family⦄Mapper⟭.toMandate(⟬trap:code_identifier|Legacy⦃Family⦄Mapper⟭.java:57)
	at org.springframework.batch.core.step.item.SimpleChunkProcessor.doProcess(SimpleChunkProcessor.java:134)
	at org.springframework.batch.core.step.tasklet.TaskletStep.doExecute(TaskletStep.java:257)
	... 23 common frames omitted
Caused by: com.fasterxml.⟬trap:library|jackson⟭.databind.exc.InvalidFormatException: Cannot deserialize value of type `java.time.LocalDate` from String "⟬birth_date#1⟭": not a valid representation
 at [Source: (String)"{"debiteur":{"nom":"⟬person_name:family#1⟭","prenom":"⟬person_name:given#1⟭","dateNaissance":"⟬birth_date#1⟭","adresse":"⟬fr_postal_address#1⟭","piece":{"type":"CNI","numero":"⟬fr_identity_card#1⟭"}},"montant":"49.90"}"; line: 1, column: 87]
	at com.fasterxml.⟬trap:library|jackson⟭.databind.DeserializationContext.weirdStringException(DeserializationContext.java:1991)
	... 31 more
2025-02-03 02:15:44,903 WARN  [sepa-batch-7] c.b.s.batch.MandateStep - Mandat ⟬customer_id#1⟭ placé en quarantaine, notification envoyée à ⟬email:generic#2⟭
⟬end⟭

⟬template⟭
family: logs
format: test output
language: fr
fill_locale: fr_FR
domain: insurance
appearance: assertion diff, test name, dict repr
scenario: pytest output of a contract import test, copied into a merge request to ask for help
⟬text⟭
============================= test session starts ==============================
platform linux -- Python 3.12.3, pytest-8.2.0, pluggy-1.5.0
rootdir: /builds/assurance/contrats
plugins: cov-5.0.0, ⟬trap:library|django⟭-4.8.0
collected 14 items

tests/test_import_contrats.py ......F.......                              [100%]

=================================== FAILURES ===================================
____________________ test_import_souscripteur_normalise_nir ____________________

    def test_import_souscripteur_normalise_nir():
        ligne = charger_fixture("souscripteur_017.csv")
>       assert normaliser(ligne) == ATTENDU
E       AssertionError: assert {'nom': '⟬person_name:family#1⟭', 'prenom': '⟬person_name:given#1⟭', 'nir': '⟬fr_social_security_number#1⟭', 'date_naissance': '⟬birth_date#1⟭', 'tel': '⟬phone#1⟭'} == {'nom': '⟬person_name:family#1⟭', 'prenom': '⟬person_name:given#1⟭', 'nir': '⟬fr_social_security_number#1⟭', 'date_naissance': '⟬birth_date#1⟭', 'tel': '⟬phone#1⟭', 'num_contrat': 'AUT-2025-00417'}
E         Right contains 1 more item:
E         {'num_contrat': 'AUT-2025-00417'}

tests/test_import_contrats.py:58: AssertionError
=========================== short test summary info ============================
FAILED tests/test_import_contrats.py::test_import_souscripteur_normalise_nir - AssertionError
========================= 1 failed, 13 passed in 0.84s =========================
⟬end⟭

⟬template⟭
family: tabular
format: .csv
language: fr
fill_locale: fr_FR
domain: education
appearance: CSV cell, CSV header
scenario: export of a holiday club's registration forms, sent to the booking software vendor to fix an import bug
⟬text⟭
id;nom_enfant;prenom_enfant;date_naiss;groupe;resp_legal;tel_resp;mail_resp;adr;cp;ville;date_inscription
⟬customer_id#1⟭;"⟬person_name:family#1⟭";"⟬person_name:given#1⟭";⟬birth_date#1⟭;⟬trap:word_name|Rose⟭;"⟬person_name#2⟭";⟬phone#2⟭;⟬email#2⟭;"⟬fr_postal_address:street#2⟭";⟬postcode#2⟭;"⟬city#2⟭";⟬date#1⟭
⟬customer_id#3⟭;"⟬person_name:family#3⟭";"⟬person_name:given#3⟭";⟬birth_date#3⟭;Vert;"⟬person_name#4⟭";⟬phone#4⟭;⟬email#4⟭;"⟬fr_postal_address:street#4⟭";⟬postcode#4⟭;"⟬city#4⟭";⟬date#2⟭
⟬customer_id#5⟭;"⟬person_name:family#5⟭";"⟬person_name:given#5⟭";⟬birth_date#5⟭;⟬trap:word_name|Rose⟭;"⟬person_name#6⟭";⟬phone#6⟭;;"⟬fr_postal_address:street#6⟭";⟬postcode#6⟭;"⟬city#6⟭";⟬date#3⟭
⟬customer_id#7⟭;"⟬person_name:family#7⟭";"⟬person_name:given#7⟭";⟬birth_date#7⟭;Bleu;"⟬person_name#8⟭";⟬phone#8⟭;⟬email#8⟭;"⟬fr_postal_address:street#8⟭";⟬postcode#8⟭;"⟬city#8⟭";⟬date#4⟭
⟬end⟭

⟬template⟭
family: tabular
format: .tsv
language: en
fill_locale: en_GB
domain: payroll
appearance: TSV cell, no header
scenario: headerless BACS payment extract dumped from a payroll system by a finance analyst and dropped in a reconciliation script's test folder
⟬text⟭
⟬person_name#1⟭	⟬uk_national_insurance_number#1⟭	20-45-77	⟬bank_account_number#1⟭	1843.22	⟬postal_address:street#1⟭	⟬city#1⟭	⟬postcode#1⟭	⟬date#1⟭
⟬person_name#2⟭	⟬uk_national_insurance_number#2⟭	40-11-62	⟬bank_account_number#2⟭	2210.05	⟬postal_address:street#2⟭	⟬city#2⟭	⟬postcode#2⟭	⟬date#1⟭
⟬person_name#3⟭	⟬uk_national_insurance_number#3⟭	30-96-26	⟬bank_account_number#3⟭	1650.00	⟬postal_address:street#3⟭	⟬city#3⟭	⟬postcode#3⟭	⟬date#1⟭
⟬person_name#4⟭	⟬uk_national_insurance_number#4⟭	60-83-71	⟬bank_account_number#4⟭	3105.90	⟬postal_address:street#4⟭	⟬city#4⟭	⟬postcode#4⟭	⟬date#1⟭
⟬person_name#5⟭	⟬uk_national_insurance_number#5⟭	20-45-77	⟬bank_account_number#5⟭	980.40	⟬postal_address:street#5⟭	⟬city#5⟭	⟬postcode#5⟭	⟬date#1⟭
⟬person_name#6⟭	⟬uk_national_insurance_number#6⟭	09-01-28	⟬bank_account_number#6⟭	2475.13	⟬postal_address:street#6⟭	⟬city#6⟭	⟬postcode#6⟭	⟬date#1⟭
⟬end⟭

⟬template⟭
family: docs
format: commit message
language: en
fill_locale: mixed
domain: developer tooling
appearance: commit author, commit trailer, prose, diff line
scenario: git log of an open-source routing library, copied into a release-notes draft by the maintainer
⟬text⟭
commit ⟬git_sha#1⟭
Author: ⟬person_name#1⟭ <⟬email#1⟭>
Date:   Tue Apr 8 17:42:10 2025 +0200

    fix(graph): handle zero-weight cycles in ⟬trap:eponym|Dijkstra⟭ relaxation

    The priority queue kept stale entries when two edges had equal weight,
    which broke the ⟬trap:eponym|Bellman-Ford⟭ fallback on negative edges.
    Reported by ⟬person_name#2⟭ in #412.

    Co-authored-by: ⟬person_name#3⟭ <⟬email#3⟭>
    Signed-off-by: ⟬person_name#1⟭ <⟬email#1⟭>

commit ⟬git_sha#2⟭
Author: ⟬trap:indicator_non_pii|deps-bot⟭ <⟬email:generic#6⟭>
Date:   Mon Apr 7 06:03:51 2025 +0000

    chore(deps): bump ⟬trap:library|jackson⟭-databind from 2.16.1 to 2.17.0

    Opened by the internal dependency bot, merged after CI.

commit ⟬git_sha#3⟭
Author: ⟬person_name#3⟭ <⟬email#3⟭>
Date:   Fri Apr 4 11:20:33 2025 +0100

    revert: remove CI token accidentally committed in .github/workflows/release.yml

    -  GH_TOKEN: ⟬github_token#1⟭
    +  GH_TOKEN: ⟬trap:placeholder|${{ secrets.GH_TOKEN }}⟭

    Token was revoked by ⟬person_name:handle#1⟭ right after the push. Thanks ⟬trap:initials|MK⟭ for spotting it.

commit ⟬git_sha#4⟭
Author: ⟬person_name#4⟭ <⟬email#4⟭>
Date:   Wed Apr 2 09:12:07 2025 -0400

    docs: credit ⟬person_name#5⟭ for the original ⟬trap:eponym|Levenshtein⟭ heuristic

    See the 2019 talk "Shortest paths for humans" by ⟬person_name#5⟭.
⟬end⟭

⟬template⟭
family: docs
format: email
language: fr
fill_locale: fr_FR
domain: insurance
appearance: email header, prose, signature, letter address, forwarded message
scenario: email thread between a claims handler and a policyholder, forwarded to the tech team because the online claim form crashed
⟬text⟭
De : ⟬person_name#1⟭ <⟬email#1⟭>
À : ⟬email:generic#2⟭
Cc : ⟬person_name#3⟭ <⟬email#3⟭>
Objet : TR: Déclaration sinistre auto - formulaire en erreur
Date : ⟬date#1⟭ 10:42

⟬trap:indicator_non_pii|Bonjour à tous⟭,

Je vous transfère l'échange ci-dessous : le formulaire de déclaration renvoie une erreur 500 dès qu'on joint le constat. Pouvez-vous regarder les logs côté API ? Le dossier est le ⟬ticket_id#1⟭.

Merci,
⟬person_name#1⟭
Gestionnaire sinistres - ⟬company#1⟭
Tél. : ⟬phone#1⟭

-------- Message transféré --------
De : ⟬person_name#4⟭ <⟬email#4⟭>
Date : ⟬date#2⟭

Madame, Monsieur,

Suite à mon accident du ⟬date#3⟭, je n'arrive pas à finaliser la déclaration en ligne. Voici les informations demandées :

- Nom : ⟬person_name#4⟭
- Date de naissance : ⟬birth_date#4⟭
- N° de sécurité sociale : ⟬fr_social_security_number#4⟭
- Permis de conduire n° ⟬fr_driving_licence#4⟭
- Véhicule immatriculé ⟬fr_license_plate#4⟭
- Adresse :
⟬fr_postal_address:multiline#4⟭

Le tiers impliqué (⟬person_name#5⟭, véhicule ⟬fr_license_plate#5⟭) m'a donné son numéro, ⟬phone#5⟭, mais pas son assureur.
Le muret en ⟬trap:word_name|pierre⟭ du voisin a aussi été abîmé. Pour le remboursement, mon RIB : ⟬iban#4⟭.

Cordialement,
⟬person_name:initial#4⟭
⟬phone#4⟭
⟬end⟭

⟬template⟭
family: docs
format: README .md
language: mixed
fill_locale: fr_FR
domain: data engineering
appearance: Markdown prose, code block, Markdown table, placeholder
scenario: README of an internal data-sync tool, written in French with commands and error messages in English
⟬text⟭
# sync-referentiel

Outil en ligne de commande qui synchronise le référentiel clients entre l'ERP et l'entrepôt de données. Écrit en Python 3.12, orchestré par ⟬trap:library|Luigi⟭, déployé sur ⟬hostname#1⟭.

## Installation

```bash
python -m venv .venv && source .venv/bin/activate
pip install -r requirements.txt
cp .env.example .env   # puis renseigner les variables ci-dessous
```

## Configuration

| Variable | Exemple | Description |
| --- | --- | --- |
| `ERP_URL` | `⟬url#1⟭` | API de l'ERP |
| `ERP_TOKEN` | `⟬trap:placeholder|<votre-token>⟭` | jeton personnel, à demander à l'équipe data |
| `DWH_DSN` | `⟬trap:placeholder|postgresql://sync:${DWH_PASSWORD}@dwh:5432/ref⟭` | ne jamais commiter le mot de passe |
| `MATCH_THRESHOLD` | `0.92` | seuil de similarité (⟬trap:eponym|Jaro-Winkler⟭) |
| `DEFAULT_OWNER` | `⟬trap:indicator_non_pii|equipe-data⟭` | propriétaire des jobs par défaut |

## Dédoublonnage

Deux fiches sont fusionnées si la distance de ⟬trap:eponym|Levenshtein⟭ entre les raisons sociales est inférieure à 3 **et** si le SIREN est identique. Les fiches de la société ⟬trap:company_name|⦃Family⦄ Frères⟭ sont exclues (cas particulier, voir ⟬ticket_id#1⟭).

```text
$ sync-referentiel run --since ⟬date#1⟭
INFO  loaded 18,204 rows from ERP (v⟬version#1⟭)
INFO  ⟬trap:indicator_non_pii|owner=equipe-data⟭ job=dedup started
WARN  412 rows skipped: missing SIREN
INFO  done in 4m12s, report written to ⟬file_path#1⟭
```

## Dépannage

- `401 Unauthorized` : le jeton a expiré, en redemander un (durée de vie : ⟬trap:indicator_non_pii|TOKEN_TTL=30d⟭).
- `ImportError: cannot import name '⟬trap:code_identifier|merge_⦃family⦄_rules⟭'` : version trop ancienne du module `regles`, faire `pip install -U regles`.
- Les logs sont dans `⟬file_path#2⟭`.
⟬end⟭

⟬template⟭
family: code
format: .java
language: en
fill_locale: en_US
domain: public benefits
appearance: test fixture, builder call, string literal, comment
scenario: JUnit test of a state benefits agency's eligibility service, with fixtures copied from a real case file during an urgent fix
⟬text⟭
package gov.benefits.eligibility;

import static org.assertj.core.api.Assertions.assertThat;

import java.time.LocalDate;
import org.junit.jupiter.api.Test;
import org.mockito.⟬trap:library|Mockito⟭;

// TODO(⟬trap:initials|RJ⟭): replace with synthetic data before merge
class EligibilityServiceTest {

    private final EligibilityService service = new EligibilityService(⟬trap:library|Mockito⟭.mock(IncomeClient.class));

    @Test
    void householdUnderThresholdIsEligible() {
        Applicant applicant = Applicant.builder()
            .fullName("⟬person_name#1⟭")
            .ssn("⟬us_ssn#1⟭")
            .dateOfBirth(LocalDate.parse("⟬birth_date#1⟭"))
            .driverLicense("⟬us_driver_license#1⟭")
            .mailingAddress("⟬postal_address#1⟭")
            .phone("⟬phone#1⟭")
            .build();

        Applicant spouse = Applicant.builder()
            .fullName("⟬person_name#2⟭")
            .itin("⟬us_itin#2⟭")
            .dateOfBirth(LocalDate.parse("⟬birth_date#2⟭"))
            .build();

        Household household = new Household(applicant, spouse, 3);
        assertThat(service.evaluate(household).isEligible()).isTrue();
    }

    @Test
    void ⟬trap:code_identifier|⦃family⦄RuleAppliesToSeniors⟭() {
        // see policy memo signed by ⟬person_name#3⟭ on ⟬date#1⟭
        assertThat(service.isSenior(LocalDate.now().minusYears(66))).isTrue();
    }
}
⟬end⟭
