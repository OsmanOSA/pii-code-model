⟬template⟭
family: code
format: .java
language: mixed
fill_locale: en_GB
domain: banking
appearance: text block, constant, log call, log output comment, Javadoc
scenario: Spring Boot callback controller for UK Open Banking consents in the London branch of a French fintech, French comments, with the JWS signing key in a text block and a debug log that prints the account holder
⟬text⟭
package fr.novapay.uk.openbanking;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * Retour de consentement Open Banking (UK) : la banque du client nous renvoie ici après
 * l'authentification forte. On échange le code contre un jeton, puis on lit le compte.
 */
@RestController
public class ConsentCallbackController {

    private static final Logger log = LoggerFactory.getLogger(ConsentCallbackController.class);

    // TODO sortir dans le HSM avant la mise en prod UK ; en attendant, clé du sandbox de l'annuaire
    private static final String SIGNING_KEY_PEM = """
            ⟬private_key#1⟭
            """;
    private static final String CLIENT_SECRET = "⟬opaque_token#1⟭";
    private static final String ⟬trap:indicator_non_pii|SOFTWARE_STATEMENT_ID = "novapay-uk-aisp"⟭;

    private final AspspClient aspsp;
    private final ConsentRepository consents;

    public ConsentCallbackController(AspspClient aspsp, ConsentRepository consents) {
        this.aspsp = aspsp;
        this.consents = consents;
    }

    @GetMapping("/ob/callback")
    public ResponseEntity<Map<String, String>> callback(@RequestParam String code, @RequestParam String state) {
        Consent consent = consents.findByState(state).orElseThrow(() -> new UnknownConsentException(state));
        TokenResponse token = aspsp.exchange(code, CLIENT_SECRET, JwsSigner.fromPem(SIGNING_KEY_PEM));
        AccountDetails account = aspsp.account(token.accessToken(), consent.accountId());

        // debug ajouté pendant la recette avec la banque partenaire, à retirer (cf. ⟬ticket_id#1⟭)
        // sortie vue en recette :
        //   consent ⟬uuid#1⟭ ok for ⟬person_name#2⟭ (⟬email#2⟭), sort code 40-11-62 account ⟬bank_account_number#2⟭
        log.info("consent {} ok for {} ({}), sort code {} account {}",
                consent.id(), account.holderName(), account.holderEmail(), account.sortCode(), account.number());
        consents.markAuthorised(consent.id(), token.refreshToken());
        return ResponseEntity.ok(Map.of("status", "authorised", "consent", consent.id()));
    }
}
⟬end⟭

⟬template⟭
family: code
format: .py
language: mixed
fill_locale: fr_FR
domain: HR
appearance: docstring, constant, comment, log call, layout comment
scenario: English Python job in a French company's HR team building the monthly fixed-width membership file for the company health insurer, with a sample employee in the layout comment, a warning that logs the NIR and the insurer's SFTP password
⟬text⟭
"""Monthly membership file for the company health insurer ("mutuelle").

The insurer wants a fixed-width text file, one line per covered employee,
uploaded to their SFTP before the 25th. Layout from their spec v3.2, p. 14.
"""
import logging
import re
from datetime import date

import paramiko

from hr.db import active_employees

log = logging.getLogger("mutuelle_export")

SFTP_HOST = "⟬hostname#1⟭"
SFTP_USER = "⟬username#1⟭"
SFTP_PASSWORD = "⟬password#1⟭"  # rotated by the insurer every 6 months, last mail from them on ⟬date#1⟭
NIR_RE = re.compile(r"^[12]\d{14}$")

# Layout (1-based positions, as in their spec):
#   1-15    NIR with key
#   16-45   nom, upper case, padded
#   46-65   prénom, padded
#   66-73   date de naissance AAAAMMJJ
#   74-107  IBAN for direct reimbursement, no spaces
#   108     option (B = base, R = renforcée)
# Their spec uses one of our own employees as the sample record (separators added here):
#   ⟬fr_social_security_number#2⟭ | ⟬person_name:family#2⟭ | ⟬person_name:given#2⟭ | ⟬birth_date#2⟭ | ⟬iban#2⟭ | R


def _line(emp) -> str:
    return (
        emp.nir.ljust(15)
        + emp.nom.upper()[:30].ljust(30)
        + emp.prenom[:20].ljust(20)
        + emp.date_naissance.strftime("%Y%m%d")
        + (emp.iban_remboursement or "").replace(" ", "").ljust(34)
        + ("R" if emp.option_renforcee else "B")
    )


def build_file(employees) -> str:
    lines, rejected = [], 0
    for emp in employees:
        if not NIR_RE.match(emp.nir or ""):
            # the insurer rejects the whole file on one bad NIR, so skip the line and tell HR
            log.warning("NIR invalide pour %s %s : %r", emp.prenom, emp.nom, emp.nir)
            rejected += 1
            continue
        lines.append(_line(emp))
    log.info("%d lines, %d rejected", len(lines), rejected)
    return "\r\n".join(lines) + "\r\n"


def upload(content: str, today: date) -> None:
    transport = paramiko.Transport((SFTP_HOST, 22))
    transport.connect(username=SFTP_USER, password=SFTP_PASSWORD)
    sftp = paramiko.SFTPClient.from_transport(transport)
    try:
        with sftp.open(f"in/ADH_{today:%Y%m}.txt", "w") as remote:
            remote.write(content.encode("latin-1"))
    finally:
        sftp.close()
        transport.close()


if __name__ == "__main__":
    upload(build_file(active_employees()), date.today())

# Insurer's reject file for last month, pasted for the HR ticket ⟬ticket_id#1⟭:
#   ⟬fr_social_security_number#3⟭;⟬person_name:family#3⟭;REJET 112 - adhérent inconnu
#   ⟬fr_social_security_number#4⟭;⟬person_name:family#4⟭;REJET 207 - IBAN non SEPA
⟬end⟭

⟬template⟭
family: code
format: .ts
language: mixed
fill_locale: fr_FR
domain: HR
appearance: JSDoc, curl command, HTTP header, template literal
scenario: thin TypeScript client for a French payroll provider's API, English code, with a curl example a developer pasted into the JSDoc from their terminal, bearer token and test employee NIR included
⟬text⟭
/**
 * Thin client for the payroll provider's REST API (v2).
 *
 * Sandbox employee used by their support in every example: ⟬person_name#1⟭.
 * Reproduce a call by hand:
 *   curl -X POST https://⟬hostname#1⟭/v2/salaries \
 *     -H "Authorization: Bearer ⟬opaque_token#1⟭" \
 *     -H "Content-Type: application/json" \
 *     -d '{"nir": "⟬fr_social_security_number#1⟭", "entree": "⟬date#1⟭", "contrat": "CDI"}'
 */
export async function createSalarie(baseUrl: string, token: string, body: SalariePayload): Promise<string> {
  const res = await fetch(`${baseUrl}/v2/salaries`, {
    method: "POST",
    headers: { Authorization: `Bearer ${token}`, "Content-Type": "application/json" },
    body: JSON.stringify(body),
  });
  if (!res.ok) throw new Error(`payroll API ${res.status}: ${await res.text()}`);
  return (await res.json()).id;
}
⟬end⟭

⟬template⟭
family: code
format: .sql
language: mixed
fill_locale: fr_FR
domain: healthcare
appearance: stored procedure, CREATE ROLE, procedure call, comment
scenario: PL/pgSQL procedure registering patients from the online booking form of a French clinic, English comments, with a dashboard role created with its password and a smoke-test call left at the bottom
⟬text⟭
-- register_patient.sql
-- Creates or updates a patient from the online booking form.
-- INS rules: the NIR is the key when present; otherwise match on nom + prénom + date de naissance.

CREATE OR REPLACE PROCEDURE register_patient(
  p_nom text, p_prenom text, p_date_naissance date, p_nir text,
  p_adresse text, p_telephone text, INOUT p_id bigint DEFAULT NULL
)
LANGUAGE plpgsql AS $$
BEGIN
  IF p_nir IS NOT NULL THEN
    SELECT id INTO p_id FROM patient WHERE nir = p_nir;
  END IF;
  IF p_id IS NULL THEN
    SELECT id INTO p_id FROM patient
     WHERE unaccent(lower(nom)) = unaccent(lower(p_nom))
       AND unaccent(lower(prenom)) = unaccent(lower(p_prenom))
       AND date_naissance = p_date_naissance;
  END IF;
  IF p_id IS NULL THEN
    INSERT INTO patient (nom, prenom, date_naissance, nir, adresse, telephone)
    VALUES (p_nom, p_prenom, p_date_naissance, p_nir, p_adresse, p_telephone)
    RETURNING id INTO p_id;
  ELSE
    UPDATE patient SET adresse = p_adresse, telephone = p_telephone, updated_at = now() WHERE id = p_id;
  END IF;
END;
$$;

-- Read-only role for the activity dashboard (Metabase).
CREATE ROLE dashboard_ro LOGIN PASSWORD '⟬password#1⟭';
GRANT SELECT ON rendez_vous, praticien TO dashboard_ro;
COMMENT ON ROLE dashboard_ro IS '⟬trap:indicator_non_pii|owner: data-team⟭';

-- smoke test from the booking form ticket (⟬ticket_id#1⟭): Mme ⟬person_name#1f⟭, first visit
CALL register_patient('⟬person_name:family#1⟭', '⟬person_name:given#1⟭', '⟬birth_date#1⟭', '⟬fr_social_security_number#1⟭', '⟬fr_postal_address#1⟭', '⟬phone#1⟭');
⟬end⟭

⟬template⟭
family: code
format: .ipynb
language: mixed
fill_locale: fr_FR
domain: SaaS
appearance: shell command, URL, notebook output, markdown cell, environment variable
scenario: ML engineer's notebook with English markdown fine-tuning a ticket router on French support tickets, installing the internal helper package from the GitLab registry with a token in the index URL, ticket texts with customer details in the output
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Ticket router v3: fine-tune on FR tickets\n",
    "\n",
    "Data: 18 months of French tickets from the helpdesk export, label = queue (`billing`, `account`, `bug`, `other`)."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "metadata": {},
   "outputs": [],
   "source": [
    "!pip install -q --index-url https://__token__:⟬gitlab_token#1⟭@⟬hostname#1⟭/api/v4/projects/88/packages/pypi/simple ticketkit==⟬version#1⟭"
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
       "         queue                                                                       text\n",
       "4121   billing   Bonjour, ⟬person_name#2⟭ ici, j'ai été débité deux fois ce mois-ci pour le même abonnement\n",
       "977    account   impossible de me connecter, mon mail c'est ⟬email#3⟭ merci de me rappeler au ⟬phone#3⟭\n",
       "15530      bug   L'export PDF plante depuis la mise à jour. Cordialement, ⟬person_name:initial#4⟭"
      ]
     },
     "execution_count": 2,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "from ticketkit import load_export, scrub\n",
    "\n",
    "df = load_export(\"⟬file_path#1⟭\")\n",
    "df.sample(3, random_state=7)[[\"queue\", \"text\"]]"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Names, emails and phone numbers sit in the text. Not a problem for training, but they must never reach the model card examples: `scrub()` masks them before the split."
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
      "{'eval_loss': 0.412, 'eval_macro_f1': 0.873, 'epoch': 3.0}\n"
     ]
    }
   ],
   "source": [
    "import os\n",
    "from transformers import AutoModelForSequenceClassification, AutoTokenizer, Trainer, TrainingArguments\n",
    "\n",
    "os.environ[\"MLFLOW_TRACKING_URI\"] = \"https://⟬hostname#2⟭\"\n",
    "os.environ[\"MLFLOW_TRACKING_USERNAME\"] = \"⟬username#2⟭\"\n",
    "os.environ[\"MLFLOW_TRACKING_PASSWORD\"] = \"⟬password#2⟭\"\n",
    "\n",
    "df[\"text\"] = df[\"text\"].map(scrub)\n",
    "tok = AutoTokenizer.from_pretrained(\"camembert-base\")\n",
    "model = AutoModelForSequenceClassification.from_pretrained(\"camembert-base\", num_labels=4)\n",
    "args = TrainingArguments(output_dir=\"runs/router-v3\", num_train_epochs=3, per_device_train_batch_size=32, report_to=[\"mlflow\"])\n",
    "trainer = Trainer(model=model, args=args, train_dataset=train_ds, eval_dataset=eval_ds, tokenizer=tok)\n",
    "trainer.train()\n",
    "print(trainer.evaluate())"
   ]
  }
 ],
 "metadata": {
  "kernelspec": {"display_name": "Python 3 (gpu)", "language": "python", "name": "gpu"},
  "language_info": {"name": "python", "version": "3.11.9"}
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
⟬end⟭

⟬template⟭
family: code
format: .java
language: mixed
fill_locale: en_US
domain: logistics
appearance: text block, block comment, exception message, Javadoc, placeholder
scenario: Kafka consumer in a French logistics scale-up's Java service onboarding US contractor drivers, French comments, with the mTLS client key in a text block, a sample message in a comment and an exception message that carries the SSN
⟬text⟭
package fr.trajet.us.drivers;

import java.util.Properties;

import org.apache.kafka.clients.consumer.ConsumerRecord;

/**
 * Consomme les dossiers chauffeurs (contractors 1099) publiés par l'outil d'onboarding US.
 * Un chauffeur sans SSN ni ITIN valide part en DLQ ; l'équipe ops US le traite à la main.
 */
public class DriverOnboardingConsumer {

    // clé client mTLS du cluster Kafka US, à remplacer par le keystore monté par le chart Helm
    private static final String CLIENT_KEY_PEM = """
            ⟬private_key#1⟭
            """;

    /*
     * Exemples de messages (topic us.drivers.onboarded) :
     * {"driverId": "⟬customer_id#2⟭", "fullName": "⟬person_name#2⟭", "ssn": "⟬us_ssn#2⟭",
     *  "license": {"state": "TX", "number": "⟬us_driver_license#2⟭"}, "plate": "⟬us_license_plate#2⟭"}
     * {"driverId": "⟬customer_id#3⟭", "fullName": "⟬person_name#3⟭", "ssn": null, "itin": "⟬us_itin#3⟭",
     *  "license": {"state": "AZ", "number": "⟬us_driver_license#3⟭"}, "plate": null}
     */
    private final DriverStore drivers;

    public DriverOnboardingConsumer(DriverStore drivers) {
        this.drivers = drivers;
    }

    static Properties config() {
        Properties props = new Properties();
        props.put("bootstrap.servers", "⟬hostname#1⟭:9093");
        props.put("security.protocol", "SSL");
        props.put("ssl.keystore.type", "PEM");
        props.put("ssl.keystore.key", CLIENT_KEY_PEM);
        props.put("ssl.key.password", "⟬trap:placeholder|${KAFKA_KEY_PASSWORD}⟭");
        props.put("group.id", "driver-onboarding-fr");
        return props;
    }

    void handle(ConsumerRecord<String, DriverRecord> record) {
        DriverRecord d = record.value();
        if (d.ssn() == null && d.itin() == null) {
            throw new InvalidDriverException("chauffeur " + d.driverId() + " sans SSN ni ITIN");
        }
        if (d.ssn() != null && !TaxIds.isValidSsn(d.ssn())) {
            // FIXME le message part tel quel dans Sentry et contient le SSN en clair, vu le ⟬date#1⟭ :
            // InvalidDriverException: SSN refusé pour ⟬person_name#4⟭ : ⟬us_ssn#4⟭
            throw new InvalidDriverException("SSN refusé pour " + d.fullName() + " : " + d.ssn());
        }
        drivers.upsert(d);
    }
}
⟬end⟭

⟬template⟭
family: code
format: .ts
language: mixed
fill_locale: fr_FR
domain: banking
appearance: object literal, browser automation, test configuration, comment, import
scenario: Playwright end-to-end test in English for the online account-opening funnel of a French bank, filling the forms with the KYC vendor's sandbox identity and logging in with the test customer's password behind staging basic auth
⟬text⟭
import { expect, test } from "⟬trap:email_lookalike|@playwright/test⟭";

// Staging sits behind basic auth; the funnel itself is public in prod.
test.use({
  baseURL: process.env.E2E_BASE_URL ?? "https://⟬hostname#1⟭",
  httpCredentials: { ⟬trap:indicator_non_pii|username: "recette"⟭, password: "⟬password#2⟭" },
});

// Identity accepted by the KYC vendor's sandbox: their OCR only validates this card number
// with this face, any other combination fails at the "Vérification" step.
const prospect = {
  civilite: "Mme",
  prenom: "⟬person_name:given#1f⟭",
  nom: "⟬person_name:family#1⟭",
  dateNaissance: "⟬birth_date#1⟭",
  villeNaissance: "⟬city#3⟭",
  email: "⟬email#1⟭",
  mobile: "⟬phone#1⟭",
  adresse: "⟬fr_postal_address#1⟭",
  cni: "⟬fr_identity_card#1⟭",
  ibanExterne: "⟬iban#1⟭", // account the first transfer comes from
  password: "⟬password#1⟭",
};

test.describe("account opening, particulier", () => {
  test.beforeEach(async ({ page }) => {
    await page.goto("/ouvrir-un-compte");
    await page.getByRole("button", { name: "Accepter les cookies" }).click();
  });

  test("goes through identity, address and KYC", async ({ page }) => {
    await page.getByLabel("Civilité").selectOption(prospect.civilite);
    await page.getByLabel("Prénom").fill(prospect.prenom);
    await page.getByLabel("Nom", { exact: true }).fill(prospect.nom);
    await page.getByLabel("Date de naissance").fill(prospect.dateNaissance);
    await page.getByLabel("Ville de naissance").fill(prospect.villeNaissance);
    await page.getByLabel("Adresse e-mail").fill(prospect.email);
    await page.getByLabel("Téléphone mobile").fill(prospect.mobile);
    await page.getByRole("button", { name: "Continuer" }).click();

    await page.getByLabel("Adresse postale").fill(prospect.adresse);
    await page.getByRole("option").first().click(); // address autocomplete
    await page.getByRole("button", { name: "Continuer" }).click();

    await page.getByLabel("Numéro de carte d'identité").fill(prospect.cni);
    await page.setInputFiles("input[type=file]", "fixtures/cni-recto.jpg");
    await expect(page.getByText("Vérification en cours")).toBeVisible();
    await expect(page.getByText("Identité vérifiée")).toBeVisible({ timeout: 30_000 });
  });

  test("pre-fills the first transfer with the external IBAN", async ({ page }) => {
    await page.goto("/connexion");
    await page.getByLabel("Identifiant").fill(prospect.email);
    await page.getByLabel("Mot de passe").fill(prospect.password);
    await page.getByRole("button", { name: "Se connecter" }).click();
    await page.goto("/virements/premier-versement");
    await expect(page.getByLabel("IBAN émetteur")).toHaveValue(prospect.ibanExterne);
  });

  test("rejects a minor", async ({ page }) => {
    const minor = new Date();
    minor.setFullYear(minor.getFullYear() - 16);
    await page.getByLabel("Date de naissance").fill(minor.toISOString().slice(0, 10));
    await page.getByRole("button", { name: "Continuer" }).click();
    await expect(page.getByText("Vous devez être majeur pour ouvrir un compte")).toBeVisible();
  });
});
⟬end⟭

⟬template⟭
family: code
format: .sql
language: mixed
fill_locale: en_GB
domain: e-commerce
appearance: comment, SQL WHERE
scenario: query a French developer at a UK-facing online shop wrote to answer a GDPR subject access request, with French comments naming the requester
⟬text⟭
-- DSAR (subject access request) reçue le ⟬date#1⟭ via le formulaire RGPD UK
-- demandeur : ⟬person_name#1m⟭, identité vérifiée par le support
-- délai légal : un mois. Export en CSV chiffré, mot de passe envoyé par SMS.
SELECT c.id, c.first_name, c.last_name, c.email, c.phone, c.created_at,
       a.line1, a.city, a.postcode, o.order_number, o.total_gbp, o.placed_at
FROM customers c
LEFT JOIN addresses a ON a.customer_id = c.id
LEFT JOIN orders o ON o.customer_id = c.id
WHERE lower(c.email) = lower('⟬email#1⟭')
   OR c.phone = '⟬phone#1⟭'
ORDER BY o.placed_at DESC;

-- il a aussi commandé en invité avec une autre adresse (cf. son message au support)
SELECT * FROM guest_orders WHERE email = '⟬email#2⟭' OR shipping_line1 = '⟬postal_address:street#1⟭';
⟬end⟭

⟬template⟭
family: code
format: .py
language: mixed
fill_locale: en_US
domain: healthcare
appearance: constant, triple-quoted string, nested JSON, exception message, assertion
scenario: French-commented Python client pulling lab results from a US reference lab's FHIR API with mutual TLS and OAuth client credentials, with a sample bundle kept as a JSON string for a quick test
⟬text⟭
# Client des résultats de labo du partenaire US (API FHIR R4, mTLS + OAuth2 client credentials).
# Le partenaire impose une clé client par environnement ; celle-ci est la clé de recette.
import json
import tempfile

import requests

FHIR_BASE = "https://⟬hostname#1⟭/fhir/R4"
TOKEN_URL = "https://⟬hostname#1⟭/oauth2/token"
CLIENT_ID = "lab-sync-fr"
CLIENT_SECRET = "⟬opaque_token#1⟭"
CLIENT_CERT = "certs/lab-sync-recette.crt"
CLIENT_KEY_PEM = """⟬private_key#1⟭"""
US_SSN_SYSTEM = "http://hl7.org/fhir/sid/us-ssn"


def _session() -> requests.Session:
    key = tempfile.NamedTemporaryFile("w", suffix=".key", delete=False)
    key.write(CLIENT_KEY_PEM)
    key.close()
    s = requests.Session()
    s.cert = (CLIENT_CERT, key.name)
    token = s.post(TOKEN_URL, data={"grant_type": "client_credentials", "client_id": CLIENT_ID,
                                    "client_secret": CLIENT_SECRET}, timeout=10)
    token.raise_for_status()
    s.headers["Authorization"] = f"Bearer {token.json()['access_token']}"
    return s


def patient_summary(bundle: dict) -> dict:
    patient = next(e["resource"] for e in bundle["entry"] if e["resource"]["resourceType"] == "Patient")
    ssn = next((i["value"] for i in patient.get("identifier", []) if i["system"] == US_SSN_SYSTEM), None)
    if ssn is None:
        # sans SSN on ne peut pas rapprocher avec notre dossier patient
        raise ValueError(f"Patient {patient['id']} sans SSN, rapprochement impossible")
    name = patient["name"][0]
    return {"ssn": ssn, "nom": name["family"], "prenom": " ".join(name["given"]), "naissance": patient["birthDate"]}


def results_since(day: str) -> list:
    bundle = _session().get(f"{FHIR_BASE}/DiagnosticReport", params={"_lastUpdated": f"ge{day}"}, timeout=30).json()
    return [e["resource"] for e in bundle.get("entry", [])]


# --- test rapide, recopié dans tests/test_lab_client.py ---
SAMPLE = """{
  "resourceType": "Bundle",
  "entry": [{"resource": {
    "resourceType": "Patient", "id": "pt-88213",
    "identifier": [{"system": "http://hl7.org/fhir/sid/us-ssn", "value": "⟬us_ssn#2⟭"}],
    "name": [{"family": "⟬person_name:family#2⟭", "given": ["⟬person_name:given#2⟭"]}],
    "birthDate": "⟬birth_date#2⟭",
    "address": [{"text": "⟬postal_address#2⟭"}]
  }}]
}"""


def test_patient_summary():
    summary = patient_summary(json.loads(SAMPLE))
    assert summary["ssn"] == "⟬us_ssn#2⟭"
    assert summary["naissance"] == "⟬birth_date#2⟭"
⟬end⟭

⟬template⟭
family: code
format: .java
language: mixed
fill_locale: fr_FR
domain: SaaS
appearance: HTTP header, comment, main method
scenario: one-shot Java CLI a developer at a French SaaS wrote to bulk-close stale issues on the company GitLab, English code with a colleague's token pasted in the request header and the reviewer's initials in a comment
⟬text⟭
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;

// One-shot: close issues untouched since 2022 on the support board. Reviewed by ⟬trap:initials|JD⟭.
public class CloseStaleIssues {
    public static void main(String[] args) throws Exception {
        var client = HttpClient.newHttpClient();
        for (String iid : args) {
            var req = HttpRequest.newBuilder(URI.create("https://⟬hostname#1⟭/api/v4/projects/57/issues/" + iid + "?state_event=close"))
                    .header("PRIVATE-TOKEN", "⟬gitlab_token#1⟭") // jeton de ⟬person_name#1⟭, à révoquer après
                    .PUT(HttpRequest.BodyPublishers.noBody())
                    .build();
            System.out.println(iid + " -> " + client.send(req, HttpResponse.BodyHandlers.ofString()).statusCode());
        }
    }
}
⟬end⟭

⟬template⟭
family: code
format: .ipynb
language: mixed
fill_locale: en_US
domain: healthcare
appearance: notebook output, markdown cell, URL, function call
scenario: French biostatistician's notebook checking a US trial site's export before loading it, finding that the site sent birth dates, SSNs and names in a file the protocol wanted pseudonymised
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Contrôle qualité : export du site 014 (Houston)\n",
    "\n",
    "Le protocole prévoit un export pseudonymisé (`subject_id` + année de naissance). Vérification avant chargement dans l'entrepôt."
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
       "['subject_id', 'site', 'arm', 'dob', 'ssn', 'patient_name', 'consent_date', 'visit_1']"
      ]
     },
     "execution_count": 1,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "import ⟬trap:library|pandas⟭ as pd\n",
    "from sqlalchemy import create_engine\n",
    "\n",
    "raw = pd.read_excel(\"⟬file_path#1⟭\", sheet_name=\"Subjects\")\n",
    "raw.columns.tolist()"
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
       "  subject_id  site arm           dob          ssn           patient_name  consent_date\n",
       "0   014-0001   014   A  ⟬birth_date#2⟭  ⟬us_ssn#2⟭  ⟬person_name#2⟭  ⟬date#2⟭\n",
       "1   014-0002   014   B  ⟬birth_date#3⟭  ⟬us_ssn#3⟭  ⟬person_name#3⟭  ⟬date#3⟭\n",
       "2   014-0003   014   A  ⟬birth_date#4⟭  ⟬us_ssn#4⟭  ⟬person_name#4⟭  ⟬date#4⟭"
      ]
     },
     "execution_count": 2,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "raw.drop(columns=[\"visit_1\"]).head(3)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "**Problème** : `dob`, `ssn` et `patient_name` ne devraient pas être là. Mail envoyé le ⟬date#1⟭ à l'attachée de recherche du site (⟬person_name#5f⟭, ⟬email#5⟭).\n",
    "En attendant on ne garde que l'année de naissance et on supprime le reste avant tout chargement."
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
       "214"
      ]
     },
     "execution_count": 3,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "clean = raw.assign(birth_year=pd.to_datetime(raw[\"dob\"]).dt.year).drop(columns=[\"dob\", \"ssn\", \"patient_name\"])\n",
    "engine = create_engine(\"postgresql://trial_loader:⟬url_password#1⟭@⟬hostname#1⟭/ctms\")\n",
    "clean.to_sql(\"subjects_site014\", engine, schema=\"staging\", if_exists=\"replace\", index=False)\n",
    "len(clean)"
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
format: .py
language: mixed
fill_locale: fr_FR
domain: logistics
appearance: environment variable fallback, URL, commented-out payload, log call
scenario: AWS Lambda handler in English for a French parcel-locker network sending pickup SMS, with the Redis URL fallback carrying its password and a debugging comment that kept a whole recipient payload
⟬text⟭
import json
import logging
import os

import redis

log = logging.getLogger()
log.setLevel(logging.INFO)
cache = redis.Redis.from_url(os.environ.get("REDIS_URL", "rediss://default:⟬url_password#1⟭@⟬hostname#1⟭:6380/0"))


def handler(event, context):
    parcel = json.loads(event["Records"][0]["body"])
    if cache.set(f"sms:{parcel['id']}", 1, nx=True, ex=86400):
        # debug locker Nantes, to remove: {"id": "⟬order_number#1⟭", "tel": "⟬phone#2⟭", "nom": "⟬person_name#2⟭", "casier": "B-14"}
        log.info("SMS retrait envoyé au %s pour le colis %s", parcel["tel"], parcel["id"])
    return {"statusCode": 200}
⟬end⟭

⟬template⟭
family: code
format: .ts
language: mixed
fill_locale: en_GB
domain: HR
appearance: interface, object literal, comment, import
scenario: Angular service with French comments written by a French IT services firm for a UK HR client's self-service portal, with the API interface and a demo employee the client supplied
⟬text⟭
import { Injectable } from "⟬trap:email_lookalike|@angular/core⟭";
import { HttpClient } from "@angular/common/http";
import { Observable, of } from "rxjs";

import { environment } from "../../environments/environment";

/** Fiche salarié telle que renvoyée par l'API RH du client (champs en anglais côté API). */
export interface EmployeeRecord {
  employeeNumber: string;
  forename: string;
  surname: string;
  dateOfBirth: string;
  niNumber: string; // National Insurance number, obligatoire pour la paie UK
  homeAddress: string;
  personalEmail?: string;
  lineManager?: { name: string; email: string };
}

// Salarié de démo fourni par le client. NE PAS l'utiliser en recette : il existe dans leur
// annuaire de test et déclenche de vrais e-mails vers son manager.
const DEMO_EMPLOYEE: EmployeeRecord = {
  employeeNumber: "E-104882",
  forename: "⟬person_name:given#1⟭",
  surname: "⟬person_name:family#1⟭",
  dateOfBirth: "⟬birth_date#1⟭",
  niNumber: "⟬uk_national_insurance_number#1⟭",
  homeAddress: "⟬postal_address#1⟭",
  personalEmail: "⟬email#1⟭",
  lineManager: { name: "⟬person_name#2⟭", email: "⟬email#2⟭" },
};

@Injectable({ providedIn: "root" })
export class EmployeeService {
  constructor(private http: HttpClient) {}

  me(): Observable<EmployeeRecord> {
    if (environment.demo) {
      return of(DEMO_EMPLOYEE);
    }
    return this.http.get<EmployeeRecord>(`${environment.apiUrl}/employees/me`);
  }

  // le client veut masquer le NI number sauf les deux derniers caractères
  maskedNi(record: EmployeeRecord): string {
    return record.niNumber.replace(/\s/g, "").slice(-2).padStart(9, "•");
  }
}
⟬end⟭

⟬template⟭
family: code
format: .sql
language: mixed
fill_locale: fr_FR
domain: SaaS
appearance: SQL UPDATE, function call, comment
scenario: incident runbook SQL after secret scanning found customer integration tokens in a public fork of a SaaS connector, revoking them by value, English steps with the French on-call engineer's note
⟬text⟭
-- INC-2024-117: tokens found by secret scanning in a public fork of our sync connector.
-- Revoke them by value (they are stored hashed, so hash on the fly) and notify the tenants.
-- Note d'astreinte (⟬person_name#1⟭, ⟬date#1⟭) : les deux jetons GitLab sont à des clients FR,
-- le jeton opaque est celui du tenant US, à prévenir en anglais.

BEGIN;

UPDATE integration_credential
   SET revoked_at = now(), revoked_reason = 'INC-2024-117'
 WHERE secret_sha256 IN (
   encode(sha256('⟬gitlab_token#2⟭'::bytea), 'hex'),
   encode(sha256('⟬gitlab_token#3⟭'::bytea), 'hex'),
   encode(sha256('⟬opaque_token#4⟭'::bytea), 'hex')
 )
RETURNING tenant_id, provider, created_by;

-- tenants to notify (owner emails as of today)
SELECT t.id, t.name, u.email
FROM tenant t JOIN app_user u ON u.id = t.owner_id
WHERE t.id IN (SELECT tenant_id FROM integration_credential WHERE revoked_reason = 'INC-2024-117');

COMMIT;
⟬end⟭

⟬template⟭
family: code
format: .ipynb
language: mixed
fill_locale: mixed
domain: e-commerce
appearance: notebook output, markdown cell, URL, comment, constant
scenario: growth analyst's notebook, English markdown with French code comments, deduplicating loyalty members across the French and UK web stores before sending birthday vouchers and SEPA cashback payouts
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Loyalty: merge FR + UK members, birthday vouchers\n",
    "\n",
    "Two stores, two member tables. The same person can exist in both (expats, gift buyers). Key = lower(email), then name + birth date."
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
       "((48211, 9), (17390, 8))"
      ]
     },
     "execution_count": 1,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "import ⟬trap:library|pandas⟭ as pd\n",
    "from sqlalchemy import create_engine\n",
    "\n",
    "# replica en lecture seule, une seule base pour les deux boutiques (schémas fr / uk)\n",
    "eng = create_engine(\"postgresql://loyalty_ro:⟬url_password#1⟭@⟬hostname#1⟭:5432/loyalty\")\n",
    "⟬trap:indicator_non_pii|DOB_FORMAT = \"%Y-%m-%d\"⟭\n",
    "fr = pd.read_sql(\"SELECT * FROM fr.membres\", eng)\n",
    "uk = pd.read_sql(\"SELECT * FROM uk.members\", eng)\n",
    "fr.shape, uk.shape"
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
       "  id_membre          nom_complet                email  date_naissance                       adresse                 iban_cashback\n",
       "0    F-1102  ⟬person_name#2⟭  ⟬email#2⟭  ⟬birth_date#2⟭  ⟬fr_postal_address#2⟭  ⟬iban#2⟭\n",
       "1    F-1187  ⟬person_name#3⟭  ⟬email#3⟭  ⟬birth_date#3⟭  ⟬fr_postal_address#3⟭  None"
      ]
     },
     "execution_count": 2,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "fr.head(2)"
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
       "  member_id            full_name                email             dob                    address\n",
       "0    U-0453  ⟬person_name#4⟭  ⟬email#4⟭  ⟬birth_date#4⟭  ⟬postal_address#4⟭\n",
       "1    U-0471  ⟬person_name#2⟭  ⟬email#2⟭  ⟬birth_date#2⟭  ⟬postal_address#5⟭"
      ]
     },
     "execution_count": 3,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "uk.head(2)"
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
       "1312"
      ]
     },
     "execution_count": 4,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "# même personne si même email, ou même nom + date de naissance (les gens changent d'email)\n",
    "fr[\"key\"] = fr[\"email\"].str.lower()\n",
    "uk[\"key\"] = uk[\"email\"].str.lower()\n",
    "both = fr.merge(uk, on=\"key\", suffixes=(\"_fr\", \"_uk\"))\n",
    "len(both)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Birthday vouchers go out on the 1st for everyone born that month. Cashback is paid by SEPA transfer only to FR members with an IBAN; UK members get store credit."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 5,
   "metadata": {},
   "outputs": [
    {
     "data": {
      "text/plain": [
       "           nom_complet                 iban_cashback  solde_cashback\n",
       "0   ⟬person_name#2⟭  ⟬iban#2⟭           14.20\n",
       "7   ⟬person_name#6⟭  ⟬iban#6⟭           31.75\n",
       "12  ⟬person_name#7⟭  ⟬iban#7⟭           10.05"
      ]
     },
     "execution_count": 5,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "this_month = pd.Timestamp.today().month\n",
    "birthday = fr[pd.to_datetime(fr[\"date_naissance\"], format=DOB_FORMAT).dt.month == this_month]\n",
    "payouts = fr[fr[\"iban_cashback\"].notna() & (fr[\"solde_cashback\"] >= 10)]\n",
    "payouts[[\"nom_complet\", \"iban_cashback\", \"solde_cashback\"]].head(3)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "TODO: ask ⟬person_name:given#8⟭ in finance whether the SEPA batch file can take more than 500 lines."
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
format: .java
language: mixed
fill_locale: fr_FR
domain: e-commerce
appearance: Javadoc, annotation, constant, placeholder
scenario: IBAN checker for refund requests in the English Spring codebase of a French marketplace, French Javadoc from the original author, configuration read through property placeholders
⟬text⟭
package fr.marketplace.refunds.sepa;

import java.math.BigInteger;
import java.util.Arrays;
import java.util.Locale;
import java.util.Set;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

/**
 * Vérifie un IBAN saisi par le client pour un remboursement (ISO 13616, contrôle mod 97).
 * Seuls les pays SEPA listés dans {@code refund.sepa.countries} sont acceptés.
 * Format attendu pour la France : {@code ⟬trap:placeholder|FRkk BBBB BGGG GGCC CCCC CCCC CKK⟭}.
 */
@Component
public class IbanChecker {

    /** Name of the form field, shared with the front end. */
    public static final String ⟬trap:indicator_non_pii|IBAN_FIELD = "iban_client"⟭;

    private final String creditorId;
    private final Set<String> countries;

    public IbanChecker(@Value("${refund.sepa.creditor-id}") String creditorId,
                       @Value("${refund.sepa.countries:FR,BE,DE,ES,IT,LU,NL,PT}") String countries) {
        this.creditorId = creditorId;
        this.countries = Arrays.stream(countries.split(",")).map(String::trim).collect(Collectors.toSet());
    }

    public boolean isValid(String raw) {
        if (raw == null) {
            return false;
        }
        String iban = raw.replaceAll("\\s+", "").toUpperCase(Locale.ROOT);
        if (iban.length() < 15 || iban.length() > 34 || !countries.contains(iban.substring(0, 2))) {
            return false;
        }
        String rearranged = iban.substring(4) + iban.substring(0, 4);
        StringBuilder digits = new StringBuilder();
        for (char c : rearranged.toCharArray()) {
            digits.append(Character.isLetter(c) ? String.valueOf(c - 'A' + 10) : String.valueOf(c));
        }
        return new BigInteger(digits.toString()).mod(BigInteger.valueOf(97)).intValue() == 1;
    }

    /** Masque pour le back-office : les 4 premiers et les 4 derniers caractères seulement. */
    public String mask(String iban) {
        String compact = iban.replaceAll("\\s+", "");
        return compact.substring(0, 4) + " **** **** " + compact.substring(compact.length() - 4);
    }

    public String creditorId() {
        return creditorId;
    }
}
⟬end⟭

⟬template⟭
family: code
format: .py
language: mixed
fill_locale: fr_FR
domain: banking
appearance: docstring, set literal, comment, dataclass, constant
scenario: card-fraud rule module of a French bank written in English with the risk team's French comments, scoring authorisations on velocity, merchant category and geography, with an allowlist of local merchants named after families
⟬text⟭
"""Card fraud rules, the "rules engine" that runs before the ML model.

Each rule returns a score in [0, 100]; the authorisation is challenged (3DS) above 60
and declined above 85. Thresholds agreed with the risk team on ⟬date#1⟭.
"""
from dataclasses import dataclass
from datetime import datetime, timedelta

# MCC à risque : jeux d'argent, crypto, transferts d'argent
RISKY_MCC = {"7995", "6051", "4829"}
EEA = {"AT", "BE", "BG", "CY", "CZ", "DE", "DK", "EE", "ES", "FI", "FR", "GR", "HR", "HU", "IE", "IS",
       "IT", "LI", "LT", "LU", "LV", "MT", "NL", "NO", "PL", "PT", "RO", "SE", "SI", "SK"}
# commerçants locaux qui déclenchaient trop de faux positifs (achats groupés en fin de mois)
MERCHANT_ALLOWLIST = {
    "⟬trap:company_name|Boulangerie ⦃Family⦄⟭",
    "⟬trap:company_name|Garage ⦃Family2⦄ et Fils⟭",
    "⟬trap:company_name|⦃Family3⦄ Primeurs⟭",
}
PAN_DISPLAY = "⟬trap:placeholder|**** **** **** ####⟭"
⟬trap:indicator_non_pii|CARDHOLDER_NAME_CHECK = False⟭  # le réseau ne transmet pas le nom porteur en e-commerce


@dataclass(frozen=True)
class Authorisation:
    card_token: str  # jeton du coffre, jamais le PAN
    amount_cents: int
    mcc: str
    merchant: str
    country: str
    at: datetime


def velocity(history: list, auth: Authorisation) -> int:
    recent = [a for a in history if timedelta(0) <= auth.at - a.at <= timedelta(minutes=10)]
    return min(100, 20 * len(recent))


def merchant_risk(auth: Authorisation) -> int:
    if auth.merchant in MERCHANT_ALLOWLIST:
        return 0
    return 70 if auth.mcc in RISKY_MCC else 10


def geography(auth: Authorisation) -> int:
    # hors EEE et plus de 300 € : on challenge systématiquement
    if auth.country not in EEA and auth.amount_cents > 30_000:
        return 65
    return 0


def decide(history: list, auth: Authorisation) -> str:
    score = max(velocity(history, auth), merchant_risk(auth), geography(auth))
    if score > 85:
        return "decline"
    if score > 60:
        return "challenge"
    return "approve"
⟬end⟭

⟬template⟭
family: code
format: .ts
language: mixed
fill_locale: fr_FR
domain: logistics
appearance: enum, object literal, comment, constant
scenario: carrier status mapping module with French comments in a French e-commerce logistics hub, translating the event codes of an English-language carrier API into the French statuses customers see
⟬text⟭
// Correspondance des événements du transporteur (API en anglais) vers nos statuts client.
// Source : doc transporteur v4.2, onglet "Event codes". Libellés FR validés par le service client.
import type { CarrierEvent } from "./carrier-client";

export enum StatutColis {
  PrisEnCharge = "PRIS_EN_CHARGE",
  EnTransit = "EN_TRANSIT",
  EnLivraison = "EN_LIVRAISON",
  Livre = "LIVRE",
  AvisDePassage = "AVIS_DE_PASSAGE",
  EnPointRelais = "EN_POINT_RELAIS",
  Retour = "RETOUR",
  Incident = "INCIDENT",
}

const MAPPING: Record<string, StatutColis> = {
  PU: StatutColis.PrisEnCharge,
  AR: StatutColis.EnTransit,
  DP: StatutColis.EnTransit,
  OD: StatutColis.EnLivraison,
  DL: StatutColis.Livre,
  NH: StatutColis.AvisDePassage, // "not home"
  PS: StatutColis.EnPointRelais,
  RS: StatutColis.Retour,
  DM: StatutColis.Incident, // damaged
};

export const LIBELLES: Record<StatutColis, string> = {
  [StatutColis.PrisEnCharge]: "Votre colis a été pris en charge par le transporteur",
  [StatutColis.EnTransit]: "Votre colis est en route",
  [StatutColis.EnLivraison]: "Votre colis sera livré aujourd'hui",
  [StatutColis.Livre]: "Votre colis a été livré",
  [StatutColis.AvisDePassage]: "Vous étiez absent : un avis de passage a été déposé",
  [StatutColis.EnPointRelais]: "Votre colis vous attend en point relais",
  [StatutColis.Retour]: "Votre colis nous est retourné",
  [StatutColis.Incident]: "Un incident est survenu, notre service client vous contacte",
};

// Le transporteur met une valeur fixe quand personne n'a signé : on ne l'affiche pas comme un nom.
const UNSIGNED = new Set(["⟬trap:indicator_non_pii|SAFE PLACE⟭", "⟬trap:indicator_non_pii|SEE LABEL⟭", "N/A"]);

export function toStatut(event: CarrierEvent): StatutColis {
  return MAPPING[event.code] ?? StatutColis.Incident;
}

export function signataire(event: CarrierEvent): string | null {
  const signedBy = event.signedBy?.trim();
  return signedBy && !UNSIGNED.has(signedBy.toUpperCase()) ? signedBy : null;
}

export const CARRIER_DOC_URL = "⟬url#1⟭";
export const MAPPING_VERSION = "⟬version#1⟭";
⟬end⟭

⟬template⟭
family: code
format: .sql
language: mixed
fill_locale: fr_FR
domain: HR
appearance: row-level security policy, view definition, comment, column alias
scenario: migration adding row-level security and a masked reporting view on the employee table of a French HR SaaS, English comments with French column aliases for the managers' reporting tool
⟬text⟭
-- 0031_rls_salarie.sql
-- Managers see their own team only; HR sees everyone; only payroll reads NIR and IBAN.

ALTER TABLE salarie ENABLE ROW LEVEL SECURITY;

CREATE POLICY manager_own_team ON salarie
  FOR SELECT TO role_manager
  USING (equipe_id IN (SELECT equipe_id FROM manager_equipe WHERE manager_login = current_user));

CREATE POLICY rh_all ON salarie FOR ALL TO role_rh USING (true);

-- Reporting view: no direct identifiers, initials only for the org chart widget.
CREATE OR REPLACE VIEW v_effectif AS
SELECT s.matricule,
       left(s.prenom, 1) || '. ' || left(s.nom, 1) || '.' AS "initiales",
       s.equipe_id,
       date_part('year', age(s.date_naissance))::int AS "âge",
       s.date_entree AS "date d'entrée",
       s.poste,
       s.temps_partiel
FROM salarie s;

GRANT SELECT ON v_effectif TO role_manager, role_direction;
REVOKE SELECT (nir, iban_salaire, date_naissance, adresse_ligne1) ON salarie FROM role_manager;

-- The widget then shows e.g. ⟬trap:initials|C. M.⟭ for someone who opted out of the photo.
COMMENT ON VIEW v_effectif IS 'Effectif sans identifiants directs. ⟬trap:indicator_non_pii|owner: équipe data RH⟭';

-- check by hand:
--   SET ROLE role_manager; SELECT count(*) FROM salarie;   -- team size only
--   SET ROLE role_manager; SELECT nir FROM salarie LIMIT 1; -- permission denied
⟬end⟭

⟬template⟭
family: code
format: .ipynb
language: mixed
fill_locale: fr_FR
domain: logistics
appearance: markdown cell, notebook output, function definition, stream output
scenario: French data engineer's notebook smoothing the GPS telemetry of delivery vans received from an English-language telematics API, with a Kalman filter and only vehicle and device identifiers
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Lissage GPS des fourgons (télématique)\n",
    "\n",
    "Les points arrivent toutes les 15 s par l'API du boîtier (champs en anglais). Objectif : des vitesses réalistes pour le calcul d'ETA.\n",
    "Filtre de ⟬trap:eponym|Kalman⟭ simple, modèle à vitesse constante, appliqué séparément sur la distance cumulée."
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
       "                device_id  vehicle                   ts      lat     lon  speed_kmh\n",
       "0  ⟬uuid#1⟭  VAN-031  2024-10-14 07:02:15  45.7578  4.8320        0.0\n",
       "1  ⟬uuid#1⟭  VAN-031  2024-10-14 07:02:30  45.7581  4.8333       31.4\n",
       "2  ⟬uuid#1⟭  VAN-031  2024-10-14 07:02:45  45.7590  4.8351      187.0"
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
    "\n",
    "pts = pd.read_parquet(\"⟬file_path#1⟭\")\n",
    "pts[[\"device_id\", \"vehicle\", \"ts\", \"lat\", \"lon\", \"speed_kmh\"]].head(3)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Le point 2 à 187 km/h est un saut GPS classique (multitrajet entre immeubles). Le champ `driver` est toujours vide côté API (⟬trap:indicator_non_pii|`driver: unassigned`⟭) : le lien chauffeur se fait par le planning."
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
      "VAN-031 : vitesse max brute 187.0 km/h, lissée 52.3 km/h\n"
     ]
    }
   ],
   "source": [
    "def kalman_1d(z, dt=15.0, q=0.5, r=25.0):\n",
    "    x, p = np.array([z[0], 0.0]), np.eye(2) * 100\n",
    "    F = np.array([[1, dt], [0, 1]])\n",
    "    H = np.array([[1.0, 0.0]])\n",
    "    out = []\n",
    "    for zi in z:\n",
    "        x, p = F @ x, F @ p @ F.T + q * np.eye(2)\n",
    "        k = p @ H.T / (H @ p @ H.T + r)\n",
    "        x = x + (k * (zi - H @ x)).ravel()\n",
    "        p = (np.eye(2) - k @ H) @ p\n",
    "        out.append(x[0])\n",
    "    return np.array(out)\n",
    "\n",
    "van = pts[pts[\"vehicle\"] == \"VAN-031\"].sort_values(\"ts\")\n",
    "dist = van[\"odometer_m\"].to_numpy(dtype=float)\n",
    "smooth = np.diff(kalman_1d(dist)) / 15.0 * 3.6\n",
    "print(f\"VAN-031 : vitesse max brute {van['speed_kmh'].max():.1f} km/h, lissée {smooth.max():.1f} km/h\")"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Prochaine étape : brancher sur le flux temps réel (`⟬url#1⟭`, jeton dans Vault sous `telematics/prod`, ⟬trap:indicator_non_pii|`api_key_header: X-Device-Key`⟭)."
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
