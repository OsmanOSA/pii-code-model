⟬template⟭
family: code
format: .py
language: mixed
fill_locale: en_US
domain: banking
appearance: triple-quoted string, constant, fixed-width record comment, log call, log output comment
scenario: French-commented Python job of a French payments company's US entity, fetching NACHA return files from its US bank over SFTP with a key pair whose passphrase is inline, and logging every returned debit
⟬text⟭
# Récupération et traitement des retours ACH (fichiers NACHA) de la banque US.
# La banque dépose un fichier par jour ouvré vers 6h ET ; on marque les prélèvements rejetés
# et on prévient le support (R01 fonds insuffisants, R02 compte fermé, ...).
import io
import logging

import paramiko

log = logging.getLogger("ach_returns")

SFTP_HOST = "⟬hostname#1⟭"
SFTP_USER = "⟬username#1⟭"
# clé remise à la banque lors de l'onboarding ; passphrase à mettre dans le coffre (⟬ticket_id#1⟭)
SFTP_KEY = """⟬private_key#1⟭"""
SFTP_KEY_PASSPHRASE = "⟬password#1⟭"

# Ligne "6" (entry detail) d'un retour, champs NACHA séparés ici pour la lisibilité,
# copiée du fichier du ⟬date#2⟭ :
#   6 | 26 | 091000019 | ⟬bank_account_number#2⟭ | 0000004599 | ⟬customer_id#2⟭ | ⟬person_name#2⟭
# suivie de l'addenda 799 avec le code retour R01.
RETURN_CODES = {"R01": "fonds insuffisants", "R02": "compte fermé", "R03": "compte inexistant",
                "R10": "non autorisé par le client"}


def fetch(day: str) -> str:
    key = paramiko.RSAKey.from_private_key(io.StringIO(SFTP_KEY), password=SFTP_KEY_PASSPHRASE)
    transport = paramiko.Transport((SFTP_HOST, 22))
    try:
        transport.connect(username=SFTP_USER, pkey=key)
        sftp = paramiko.SFTPClient.from_transport(transport)
        with sftp.open(f"/outbound/returns/RET{day}.ach") as remote:
            return remote.read().decode("ascii")
    finally:
        transport.close()


def parse_returns(content: str):
    lines = content.splitlines()
    for i, line in enumerate(lines):
        if line.startswith("6") and i + 1 < len(lines) and lines[i + 1].startswith("799"):
            yield {
                "account": line[12:29].strip(),
                "amount_cents": int(line[29:39]),
                "individual_id": line[39:54].strip(),
                "name": line[54:76].strip(),
                "code": lines[i + 1][3:6],
            }


def process(day: str) -> int:
    count = 0
    for ret in parse_returns(fetch(day)):
        motif = RETURN_CODES.get(ret["code"], "autre")
        # attention : le log contient le numéro de compte complet, à masquer avant la prod
        log.warning("retour ACH %s (%s) pour %s, compte %s", ret["code"], motif, ret["name"], ret["account"])
        count += 1
    return count

# sortie du ⟬date#1⟭ :
# WARNING ach_returns retour ACH R02 (compte fermé) pour ⟬person_name#3⟭, compte ⟬bank_account_number#3⟭
⟬end⟭

⟬template⟭
family: code
format: .sql
language: mixed
fill_locale: en_US
domain: HR
appearance: COPY data block, comment, SQL UPDATE
scenario: correction script a French DBA wrote for the HR database of a US subsidiary, French comments, loading the corrected employee rows with COPY FROM STDIN after an HRIS import swapped two columns
⟬text⟭
-- Correctif import SIRH US du ⟬date#1⟭ : 4 salariés importés avec SSN et date de naissance décalés
-- (colonnes inversées dans le CSV du prestataire paie). Valeurs corrigées envoyées par la RH US.
-- À lancer avec psql (COPY FROM STDIN), pas depuis DBeaver.

BEGIN;

CREATE TEMP TABLE employee_fix (
  employee_id text PRIMARY KEY,
  first_name text,
  last_name text,
  ssn text,
  dob date,
  work_email text
);

COPY employee_fix (employee_id, first_name, last_name, ssn, dob, work_email) FROM STDIN WITH (FORMAT csv);
US-10422,"⟬person_name:given#1⟭","⟬person_name:family#1⟭",⟬us_ssn#1⟭,⟬birth_date#1⟭,⟬email#1⟭
US-10423,"⟬person_name:given#2⟭","⟬person_name:family#2⟭",⟬us_ssn#2⟭,⟬birth_date#2⟭,⟬email#2⟭
US-10431,"⟬person_name:given#3⟭","⟬person_name:family#3⟭",⟬us_ssn#3⟭,⟬birth_date#3⟭,⟬email#3⟭
US-10440,"⟬person_name:given#4⟭","⟬person_name:family#4⟭",⟬us_ssn#4⟭,⟬birth_date#4⟭,⟬email#4⟭
\.

-- contrôle avant mise à jour : les 4 doivent exister, l'ancien SSN ressemble à une date
SELECT e.employee_id, e.ssn AS ssn_actuel, f.ssn AS ssn_corrige, e.dob AS dob_actuelle, f.dob AS dob_corrigee
FROM hr.employee e JOIN employee_fix f USING (employee_id);

UPDATE hr.employee e
   SET ssn = f.ssn, dob = f.dob, updated_by = 'fix-import-sirh'
  FROM employee_fix f
 WHERE e.employee_id = f.employee_id;

-- trace pour l'audit SOX, sans les valeurs
INSERT INTO hr.audit_log (actor, action, target, details)
SELECT current_user, 'correction_import', employee_id, 'ssn + dob corrigés après import SIRH'
FROM employee_fix;

COMMIT;
⟬end⟭

⟬template⟭
family: code
format: .java
language: mixed
fill_locale: en_US
domain: healthcare
appearance: parameterized test, annotation, comment, placeholder
scenario: JUnit 5 parameterized test with French comments for the eligibility check a French insurtech built for a US health plan, with member SSNs and birth dates in a CsvSource
⟬text⟭
package fr.assurtech.us.eligibility;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;

class EligibilityMatcherTest {

    private final EligibilityMatcher matcher = new EligibilityMatcher(new InMemoryRoster("roster/plan-77.csv"));

    // cas fournis par le payeur US : SSN + date de naissance doivent matcher le fichier adhérents.
    // 3e cas : bon SSN mais mauvaise date -> refus attendu, c'est leur règle anti-fraude.
    @ParameterizedTest(name = "{0} / {1} -> {2}")
    @CsvSource({
        "⟬us_ssn#1⟭, ⟬birth_date#1⟭, ELIGIBLE",
        "⟬us_ssn#2⟭, ⟬birth_date#2⟭, ELIGIBLE",
        "⟬us_ssn#1⟭, ⟬birth_date#3⟭, MISMATCH",
        "⟬trap:placeholder|000-00-0000⟭, ⟬birth_date#4⟭, INVALID_SSN",
    })
    void matchesMemberRoster(String ssn, String dob, EligibilityStatus expected) {
        assertEquals(expected, matcher.check(ssn, dob).status());
    }
}
⟬end⟭

⟬template⟭
family: code
format: .ts
language: mixed
fill_locale: en_GB
domain: e-commerce
appearance: GraphQL variables, HTTP header, template literal, comment
scenario: Vitest integration test a French agency wrote against the checkout GraphQL API of a UK fashion retailer, French comments, with the storefront key under a custom header and the client's British test shopper in the variables
⟬text⟭
// Test d'intégration du checkout (API GraphQL du client UK). Tourne contre la recette uniquement.
// La clé "storefront" passe dans un en-tête maison : c'est bien un secret, pas un identifiant public.
import { GraphQLClient, gql } from "graphql-request";
import { describe, expect, it } from "vitest";

const client = new GraphQLClient("https://⟬hostname#1⟭/graphql", {
  headers: { "X-Shop-Access": "⟬opaque_token#1⟭" },
});

const CHECKOUT = gql`
  mutation Checkout($input: CheckoutInput!) {
    checkoutCreate(input: $input) {
      checkout { id totalPrice { amount currencyCode } shippingAddress { postcode } }
      errors { field message }
    }
  }
`;

// acheteuse de test créée par leur QA (compte réel sur la recette, ne pas changer l'email)
const variables = {
  input: {
    email: "⟬email#1⟭",
    lines: [{ sku: "DRS-0941-UK10", quantity: 1 }],
    shippingAddress: {
      name: "⟬person_name#1f⟭",
      address1: "⟬postal_address:street#1⟭",
      city: "⟬city#1⟭",
      postcode: "⟬postcode#1⟭",
      country: "GB",
      phone: "⟬phone#1⟭",
    },
    giftMessage: "Happy birthday ⟬person_name:given#2⟭! Love from all of us x",
  },
};

describe("checkoutCreate", () => {
  it("returns a checkout priced in GBP", async () => {
    const data = await client.request(CHECKOUT, variables);
    expect(data.checkoutCreate.errors).toEqual([]);
    expect(data.checkoutCreate.checkout.totalPrice.currencyCode).toBe("GBP");
  });

  it("rejects a postcode outside the UK", async () => {
    const bad = structuredClone(variables);
    bad.input.shippingAddress.postcode = "75011";
    const data = await client.request(CHECKOUT, bad);
    expect(data.checkoutCreate.errors[0].field).toEqual(["shippingAddress", "postcode"]);
  });
});
⟬end⟭

⟬template⟭
family: code
format: .ipynb
language: mixed
fill_locale: en_GB
domain: logistics
appearance: notebook output, markdown cell, URL, function call
scenario: French fleet manager's notebook reconciling UK penalty charge notices against the van rota, with the fleet database DSN in a cell and plates, driving licence numbers and driver names in the output
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Amendes UK (PCN) : rapprochement avec le planning\n",
    "\n",
    "Les PCN arrivent par le loueur (export Excel, en anglais). On retrouve le chauffeur par immatriculation et créneau, pour refacturer ou contester."
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
       "((63, 7), (1840, 5))"
      ]
     },
     "execution_count": 1,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "import ⟬trap:library|pandas⟭ as pd\n",
    "import sqlalchemy as sa\n",
    "\n",
    "fleet = sa.create_engine(\"mysql+pymysql://fleet_ro:⟬url_password#1⟭@⟬hostname#1⟭/fleet_uk\")\n",
    "pcn = pd.read_excel(\"⟬file_path#1⟭\")\n",
    "rota = pd.read_sql(\"SELECT plate, driver_name, licence_number, shift_start, shift_end FROM rota WHERE shift_start >= '2024-09-01'\", fleet)\n",
    "pcn.shape, rota.shape"
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
       "         PCN ref            VRM            Contravention         driver_name          licence_number\n",
       "0  ⟬ticket_id#1⟭  ⟬uk_license_plate#2⟭  Parked in a loading bay  ⟬person_name#2⟭  ⟬uk_driving_licence#2⟭\n",
       "1  ⟬ticket_id#2⟭  ⟬uk_license_plate#2⟭  Bus lane                 ⟬person_name#2⟭  ⟬uk_driving_licence#2⟭\n",
       "2  ⟬ticket_id#3⟭  ⟬uk_license_plate#3⟭  Box junction             ⟬person_name#3⟭  ⟬uk_driving_licence#3⟭\n",
       "3  ⟬ticket_id#4⟭  ⟬uk_license_plate#4⟭  Speeding 36 in 30        ⟬person_name#4⟭  ⟬uk_driving_licence#4⟭"
      ]
     },
     "execution_count": 2,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "m = pcn.merge(rota, left_on=\"VRM\", right_on=\"plate\")\n",
    "m = m[(m[\"Contravention time\"] >= m[\"shift_start\"]) & (m[\"Contravention time\"] <= m[\"shift_end\"])]\n",
    "m[[\"PCN ref\", \"VRM\", \"Contravention\", \"driver_name\", \"licence_number\"]].head(4)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "⟬person_name#2⟭ a deux PCN le même jour sur le même véhicule : voir avec le chef d'équipe avant refacturation.\n",
    "Les 9 PCN sans chauffeur trouvé tombent hors créneau (véhicule de réserve), à contester auprès du loueur."
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
format: .py
language: mixed
fill_locale: en_US
domain: SaaS
appearance: comment, HTTP header, URL
scenario: French developer's one-off script rotating the API key of a US customer's integration, the revoked key left in a comment, and storing the new one in a GitLab CI variable with a hard-coded token
⟬text⟭
# Rotation de la clé API du client US (demande de leur RSSI, ⟬person_name#1⟭, après leur audit SOC 2).
# ancienne clé, révoquée le ⟬date#1⟭ : ⟬opaque_token#1⟭
import secrets

import requests

new_key = secrets.token_urlsafe(32)
requests.put(
    "https://⟬hostname#1⟭/api/v4/projects/231/variables/CUSTOMER_API_KEY",
    headers={"PRIVATE-TOKEN": "⟬gitlab_token#1⟭"},
    data={"value": new_key, "masked": "true", "protected": "true"},
    timeout=10,
).raise_for_status()
print("nouvelle clé posée dans la variable CI, à transmettre au client par le coffre partagé")
⟬end⟭

⟬template⟭
family: code
format: .java
language: mixed
fill_locale: fr_FR
domain: banking
appearance: text block, constructor argument, golden XML, Javadoc, comment
scenario: golden-file test in English for the pain.001 writer of a French SME payment product, with the EBICS signature key of the test subscriber inline and two French sole-trader suppliers in the expected XML
⟬text⟭
package fr.paiefacile.sepa;

import static org.assertj.core.api.Assertions.assertThat;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

import org.junit.jupiter.api.Test;
import org.xmlunit.assertj3.XmlAssert;

/**
 * Golden-file test for the pain.001.001.03 writer used by the supplier payment run.
 * The expected XML was validated once against the bank's EBICS test platform.
 */
class Pain001WriterTest {

    // A005 signature key of the EBICS test subscriber, test platform only (issued by the bank).
    private static final String EBICS_SIGNING_KEY = """
            ⟬private_key#1⟭
            """;
    private static final String KEY_PASSWORD = "⟬password#1⟭";

    private final Pain001Writer writer = new Pain001Writer(new Debtor("⟬company#1⟭", "⟬iban#1⟭", "⟬bic#1⟭"));

    private final List<SupplierPayment> payments = List.of(
            new SupplierPayment("⟬invoice_number#2⟭", "⟬person_name#2⟭", "⟬iban#2⟭", "⟬bic#2⟭",
                    "⟬fr_postal_address#2⟭", new BigDecimal("1250.00")),
            new SupplierPayment("⟬invoice_number#3⟭", "⟬person_name#3⟭", "⟬iban#3⟭", "⟬bic#3⟭",
                    "⟬fr_postal_address#3⟭", new BigDecimal("89.90")));

    @Test
    void writesOneCreditTransferPerSupplierInvoice() {
        String xml = writer.write("VIR-2024-11-04", LocalDate.parse("⟬date#1⟭"), payments);

        XmlAssert.assertThat(xml).and("""
                <Document xmlns="urn:iso:std:iso:20022:tech:xsd:pain.001.001.03">
                  <CstmrCdtTrfInitn>
                    <GrpHdr><MsgId>VIR-2024-11-04</MsgId><NbOfTxs>2</NbOfTxs><CtrlSum>1339.90</CtrlSum></GrpHdr>
                    <PmtInf>
                      <Dbtr><Nm>⟬company#1⟭</Nm></Dbtr>
                      <DbtrAcct><Id><IBAN>⟬iban#1⟭</IBAN></Id></DbtrAcct>
                      <CdtTrfTxInf>
                        <Amt><InstdAmt Ccy="EUR">1250.00</InstdAmt></Amt>
                        <Cdtr><Nm>⟬person_name#2⟭</Nm><PstlAdr><AdrLine>⟬fr_postal_address#2⟭</AdrLine></PstlAdr></Cdtr>
                        <CdtrAcct><Id><IBAN>⟬iban#2⟭</IBAN></Id></CdtrAcct>
                        <RmtInf><Ustrd>⟬invoice_number#2⟭</Ustrd></RmtInf>
                      </CdtTrfTxInf>
                      <CdtTrfTxInf>
                        <Amt><InstdAmt Ccy="EUR">89.90</InstdAmt></Amt>
                        <Cdtr><Nm>⟬person_name#3⟭</Nm><PstlAdr><AdrLine>⟬fr_postal_address#3⟭</AdrLine></PstlAdr></Cdtr>
                        <CdtrAcct><Id><IBAN>⟬iban#3⟭</IBAN></Id></CdtrAcct>
                        <RmtInf><Ustrd>⟬invoice_number#3⟭</Ustrd></RmtInf>
                      </CdtTrfTxInf>
                    </PmtInf>
                  </CstmrCdtTrfInitn>
                </Document>
                """).ignoreWhitespace().areSimilar();
    }

    @Test
    void signatureVerifiesWithTheSubscriberCertificate() {
        String xml = writer.write("VIR-2024-11-05", LocalDate.parse("⟬date#1⟭"), payments);
        byte[] signature = EbicsSigner.sign(xml, EBICS_SIGNING_KEY, KEY_PASSWORD.toCharArray());
        // the bank's test certificate for our subscriber, downloaded with the HPB order
        assertThat(EbicsSigner.verify(xml, signature, "certs/test-subscriber-a005.pem")).isTrue();
    }
}
⟬end⟭

⟬template⟭
family: code
format: .sql
language: mixed
fill_locale: fr_FR
domain: banking
appearance: comment, SQL UPDATE, SQL WHERE
scenario: one-off support fix in English replacing a French customer's direct-debit IBAN after a change of bank, with the old and new IBANs in the comments and in the WHERE clause
⟬text⟭
-- SUP-8841: customer changed bank, the self-service form rejected the new IBAN (BIC lookup bug).
-- Requested by ⟬person_name#1⟭ over the phone, identity checked with the security questions.
-- old: ⟬iban#2⟭
-- new: ⟬iban#1⟭
UPDATE compte_prelevement
   SET iban = '⟬iban#1⟭', bic = '⟬bic#1⟭', modifie_le = now(), modifie_par = 'support'
 WHERE client_id = 'C-0042117' AND iban = '⟬iban#2⟭';
-- expected: UPDATE 1
⟬end⟭

⟬template⟭
family: code
format: .ts
language: mixed
fill_locale: fr_FR
domain: healthcare
appearance: environment variable fallback, URL, in-source test, string literal, assertion
scenario: Express logging middleware of a French telehealth platform, English code, with a redaction helper, the MongoDB URL fallback carrying its password and an in-source Vitest test fed with a French patient's booking request
⟬text⟭
import type { NextFunction, Request, Response } from "express";
import pino from "pino";

export const MONGO_URL =
  process.env.MONGO_URL ?? "mongodb://teleconsult:⟬url_password#1⟭@⟬hostname#1⟭:27017/teleconsult?authSource=admin";

const logger = pino({ level: process.env.LOG_LEVEL ?? "info" });

// French data shapes that must never reach the logs. The NIR pattern accepts the spaced form patients type.
const PATTERNS: [RegExp, string][] = [
  [/\b[12]\s?\d{2}\s?\d{2}\s?(2A|2B|\d{2})\s?\d{3}\s?\d{3}\s?\d{2}\b/g, "[NIR]"],
  [/[\w.+-]+@[\w-]+\.[\w.]+/g, "[EMAIL]"],
  [/(\+33\s?|0)[1-9](\s?\d{2}){4}/g, "[TEL]"],
];

export function redact(text: string): string {
  return PATTERNS.reduce((acc, [re, label]) => acc.replace(re, label), text);
}

export function requestLogger(req: Request, res: Response, next: NextFunction) {
  const started = Date.now();
  res.on("finish", () => {
    logger.info(
      { method: req.method, path: req.path, status: res.statusCode, ms: Date.now() - started,
        body: redact(JSON.stringify(req.body ?? {})) },
      "request",
    );
  });
  next();
}

if (import.meta.vitest) {
  const { it, expect } = import.meta.vitest;

  it("redacts the patient fields of a booking request", () => {
    const body = JSON.stringify({
      patient: "⟬person_name#2⟭",
      nir: "⟬fr_social_security_number#2⟭",
      email: "⟬email#2⟭",
      tel: "⟬phone#2⟭",
      motif: "renouvellement d'ordonnance",
    });
    const out = redact(body);
    expect(out).not.toContain("⟬fr_social_security_number#2⟭");
    expect(out).toContain("[NIR]");
    expect(out).toContain("[EMAIL]");
    // names are not caught by a regex: known gap, tracked in ⟬ticket_id#1⟭
    expect(out).toContain("⟬person_name#2⟭");
  });
}
⟬end⟭

⟬template⟭
family: code
format: .py
language: mixed
fill_locale: fr_FR
domain: e-commerce
appearance: docstring, doctest, keyword argument, CSV row
scenario: English export helper of a French furniture e-shop writing delivery manifests for a two-person delivery carrier as semicolon-separated rows, with a doctest whose expected output is a customer's order
⟬text⟭
"""Delivery manifest export for the furniture carrier (two-person delivery).

The carrier's portal only takes semicolon-separated files, cp1252, with the
columns below in this order. Phone numbers must keep their leading zero.
"""
import csv
import io

from shop.orders import Order

COLUMNS = ["ref_commande", "destinataire", "adresse", "telephone", "etage", "ascenseur", "creneau"]


def manifest_row(order: Order) -> str:
    """Render one order as a manifest line.

    >>> manifest_row(sample_order())
    '⟬order_number#1⟭;⟬person_name#1⟭;⟬fr_postal_address#1⟭;⟬phone#1⟭;3;non;matin'
    """
    buf = io.StringIO()
    csv.writer(buf, delimiter=";", lineterminator="").writerow([
        order.ref, order.recipient, order.address_line, order.phone,
        order.floor, "oui" if order.lift else "non", order.slot,
    ])
    return buf.getvalue()


def sample_order() -> Order:
    # the order that broke the export in March: third floor, no lift
    return Order(ref="⟬order_number#1⟭", recipient="⟬person_name#1⟭", address_line="⟬fr_postal_address#1⟭",
                 phone="⟬phone#1⟭", email="⟬email#1⟭", floor=3, lift=False, slot="matin")


def write_manifest(orders, path: str) -> None:
    with open(path, "w", encoding="cp1252", newline="") as handle:
        handle.write(";".join(COLUMNS) + "\r\n")
        for order in orders:
            handle.write(manifest_row(order) + "\r\n")
⟬end⟭

⟬template⟭
family: code
format: .java
language: mixed
fill_locale: mixed
domain: HR
appearance: Javadoc, native query, annotation, comment
scenario: Spring Data repository of a multinational HR SaaS keeping French and US employees in one table, English Javadoc with an example national identifier from each country and a native query that normalises them
⟬text⟭
package com.peoplegrid.core.employee;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

/**
 * Employees of every legal entity, in one table. {@code nationalId} holds what the local
 * payroll needs: the NIR for French entities, the SSN (or ITIN) for US ones.
 *
 * <p>Examples from the integration test data set:
 * <ul>
 *   <li>FR: {@code ⟬fr_social_security_number#1⟭}, ⟬person_name#1⟭, Lyon office</li>
 *   <li>US: {@code ⟬us_ssn#2⟭}, ⟬person_name#2⟭, Austin office</li>
 * </ul>
 * Both are stored without separators, see {@link NationalIdNormaliser}; a lookup such as
 * {@code findByNationalId("US", "⟬us_ssn#2⟭")} works with or without dashes.
 */
public interface EmployeeRepository extends JpaRepository<Employee, Long> {

    @Query(value = """
            SELECT * FROM employee
             WHERE legal_entity_country = :country
               AND regexp_replace(national_id, '[^0-9AB]', '', 'g') = regexp_replace(:nationalId, '[^0-9AB]', '', 'g')
            """, nativeQuery = true)
    Optional<Employee> findByNationalId(@Param("country") String country, @Param("nationalId") String nationalId);

    // FR only: the "numéro de sécurité sociale" also encodes sex and birth month, used by the payroll checks
    @Query("select e from Employee e where e.legalEntityCountry = 'FR' and e.nationalId = :nir")
    Optional<Employee> findFrenchByNir(@Param("nir") String nir);

    // e.g. findByManagerEmail("⟬email#3⟭") returns the 14 direct reports of the Paris HR lead
    List<Employee> findByManagerEmail(String managerEmail);
}
⟬end⟭

⟬template⟭
family: code
format: .ipynb
language: mixed
fill_locale: fr_FR
domain: banking
appearance: notebook output, HTTP header, markdown cell, URL
scenario: credit risk analyst's notebook with English markdown scoring French consumer-loan applicants, downloading the scorecard from the GitLab package registry with a token, applicants' tax numbers, birth dates, addresses and IBANs in the output
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Consumer loans: score the October applicants with scorecard v7\n",
    "\n",
    "Applicants come from the web funnel. `numero_fiscal` is only used to call the income verification API, never as a feature."
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
       "          nom       prenom  date_naissance   numero_fiscal                       adresse                iban_versement  revenu_mensuel\n",
       "0  ⟬person_name:family#2⟭  ⟬person_name:given#2⟭  ⟬birth_date#2⟭  ⟬fr_tax_number#2⟭  ⟬fr_postal_address#2⟭  ⟬iban#2⟭  2850\n",
       "1  ⟬person_name:family#3⟭  ⟬person_name:given#3⟭  ⟬birth_date#3⟭  ⟬fr_tax_number#3⟭  ⟬fr_postal_address#3⟭  ⟬iban#3⟭  1920\n",
       "2  ⟬person_name:family#4⟭  ⟬person_name:given#4⟭  ⟬birth_date#4⟭  ⟬fr_tax_number#4⟭  ⟬fr_postal_address#4⟭  ⟬iban#4⟭  4100"
      ]
     },
     "execution_count": 1,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "import io\n",
    "\n",
    "import joblib\n",
    "import ⟬trap:library|pandas⟭ as pd\n",
    "import requests\n",
    "\n",
    "PKG = \"https://⟬hostname#1⟭/api/v4/projects/301/packages/generic/scorecard/7.0.2/scorecard.joblib\"\n",
    "resp = requests.get(PKG, headers={\"PRIVATE-TOKEN\": \"⟬gitlab_token#1⟭\"}, timeout=30)\n",
    "model = joblib.load(io.BytesIO(resp.content))\n",
    "apps = pd.read_parquet(\"⟬file_path#1⟭\")\n",
    "apps[[\"nom\", \"prenom\", \"date_naissance\", \"numero_fiscal\", \"adresse\", \"iban_versement\", \"revenu_mensuel\"]].head(3)"
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
       "count    1287.000000\n",
       "mean        0.711204\n",
       "std         0.168930\n",
       "min         0.081377\n",
       "25%         0.624018\n",
       "50%         0.748551\n",
       "75%         0.839902\n",
       "max         0.991060\n",
       "Name: score, dtype: float64"
      ]
     },
     "execution_count": 2,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "apps[\"age\"] = (pd.Timestamp.today() - pd.to_datetime(apps[\"date_naissance\"])).dt.days // 365\n",
    "X = apps[[\"age\", \"revenu_mensuel\", \"charges_mensuelles\", \"anciennete_emploi_mois\", \"montant_demande\"]]\n",
    "apps[\"score\"] = model.predict_proba(X)[:, 1]\n",
    "apps[\"score\"].describe()"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Cut-off stays at 0.62 (risk committee of ⟬date#1⟭): 24 % refused, slightly above September. The age feature is capped at 75 in v7."
   ]
  }
 ],
 "metadata": {
  "kernelspec": {"display_name": "Python 3 (risk)", "language": "python", "name": "risk"},
  "language_info": {"name": "python", "version": "3.10.14"}
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
⟬end⟭

⟬template⟭
family: code
format: .py
language: mixed
fill_locale: mixed
domain: healthcare
appearance: docstring, constant, triple-quoted string, test vector, assertion, comment
scenario: pseudonymisation module of a French-American research consortium, English code, replacing NIRs and SSNs with keyed hashes before data leaves each hospital, with the consortium key and the site's manifest signing key inline and one test patient per country
⟬text⟭
"""Pseudonymise patient identifiers before export to the consortium data lake.

Each site replaces its national identifier (NIR in France, SSN in the US) with
HMAC-SHA256(key, country + normalised id), truncated to 20 hex characters. The
key is shared by every site, so a patient treated in Lyon and in Boston links up.
The manifest listing the exported files is signed with the site's own key.
"""
import hashlib
import hmac
import json
import re
from datetime import date

from cryptography.hazmat.primitives import hashes, serialization
from cryptography.hazmat.primitives.asymmetric import padding

# Consortium-wide key, sent by the coordinating centre on ⟬date#1⟭.
# FIXME must come from the site HSM; only here for the dry run.
PSEUDO_KEY = "⟬opaque_token#1⟭".encode()
SITE_SIGNING_KEY = """⟬private_key#1⟭"""

_NIR = re.compile(r"^[12]\d{2}(0[1-9]|1[0-2]|[2-9]\d)(2A|2B|\d{2})\d{6}\d{2}$")
_SSN = re.compile(r"^\d{9}$")


def normalise(national_id: str, country: str) -> str:
    compact = re.sub(r"[\s.-]", "", national_id).upper()
    pattern = _NIR if country == "FR" else _SSN
    if not pattern.match(compact):
        raise ValueError(f"{country} identifier does not have the expected shape")
    return compact


def pseudonym(national_id: str, country: str) -> str:
    message = f"{country}:{normalise(national_id, country)}".encode()
    return hmac.new(PSEUDO_KEY, message, hashlib.sha256).hexdigest()[:20]


def coarsen_birth_date(born: date) -> str:
    # year and quarter only: the consortium agreement forbids full birth dates
    return f"{born.year}-Q{(born.month - 1) // 3 + 1}"


def sign_manifest(files: list) -> dict:
    key = serialization.load_pem_private_key(SITE_SIGNING_KEY.encode(), password=None)
    body = json.dumps({"files": sorted(files)}, sort_keys=True).encode()
    return {"files": sorted(files), "signature": key.sign(body, padding.PKCS1v15(), hashes.SHA256()).hex()}


# Dry-run vectors, one consenting pilot patient per site: ⟬person_name:initial#2⟭ (Lyon)
# and ⟬person_name:initial#3⟭ (Boston). Expected values computed by the coordinating centre.
TEST_VECTORS = [
    ("lyon", "FR", "⟬fr_social_security_number#2⟭", date.fromisoformat("⟬birth_date#2⟭"), "⟬hash#2⟭"),
    ("boston", "US", "⟬us_ssn#3⟭", date.fromisoformat("⟬birth_date#3⟭"), "⟬hash#3⟭"),
]


def test_vectors_match_the_coordinating_centre():
    for site, country, national_id, born, expected in TEST_VECTORS:
        assert pseudonym(national_id, country) == expected[:20], site
        assert coarsen_birth_date(born).startswith(str(born.year))


def test_separators_do_not_change_the_pseudonym():
    _, _, nir, _, _ = TEST_VECTORS[0]
    spaced = f"{nir[:1]} {nir[1:3]} {nir[3:5]} {nir[5:7]} {nir[7:10]} {nir[10:13]} {nir[13:]}"
    assert pseudonym(spaced, "FR") == pseudonym(nir, "FR")


def test_wrong_shape_is_refused():
    try:
        pseudonym("12345", "US")
    except ValueError as error:
        assert "US" in str(error)
    else:
        raise AssertionError("a 5-digit SSN must be refused")
⟬end⟭

⟬template⟭
family: code
format: .ts
language: mixed
fill_locale: en_US
domain: SaaS
appearance: comment, URL, HTTP header, JSON body
scenario: ts-node helper in a French startup's repository registering a US customer's webhook on the GitLab project, French comments, with the project token hard-coded and the customer's receiver URL carrying basic-auth credentials
⟬text⟭
// script ponctuel : brancher le webhook du client US sur notre projet GitLab (demande ⟬ticket_id#1⟭)
// leur récepteur exige le basic auth dans l'URL, ils n'acceptent pas d'en-tête custom
const GITLAB = "https://⟬hostname#1⟭/api/v4/projects/412/hooks";
const TOKEN = "⟬gitlab_token#1⟭";

const res = await fetch(GITLAB, {
  method: "POST",
  headers: { "PRIVATE-TOKEN": TOKEN, "Content-Type": "application/json" },
  body: JSON.stringify({
    url: "https://gitlab-events:⟬url_password#2⟭@⟬hostname#2⟭/hooks/gitlab",
    push_events: true,
    merge_requests_events: true,
    enable_ssl_verification: true,
  }),
});
console.log(res.status, await res.text());
⟬end⟭

⟬template⟭
family: code
format: .sql
language: mixed
fill_locale: en_US
domain: logistics
appearance: SQL INSERT, comment
scenario: demo seed for the US edition of a French warehouse management product, French comments by the presales team, with warehouse addresses, sandbox carrier API keys, truck drivers and the demo login password left in a comment
⟬text⟭
-- Jeu de démo WMS édition US (salon de Chicago). Données inventées par l'avant-vente,
-- SAUF les clés transporteurs : ce sont celles des comptes sandbox, à regénérer après le salon.

BEGIN;

INSERT INTO warehouse (code, name, address, timezone) VALUES
  ('CHI1', 'Chicago Cross-Dock', '⟬postal_address#1⟭', 'America/Chicago'),
  ('DAL2', 'Dallas Fulfillment', '⟬postal_address#2⟭', 'America/Chicago'),
  ('NJ3',  'Newark Returns',     '⟬postal_address#3⟭', 'America/New_York');

-- comptes sandbox transporteurs (api_key chiffrée par le trigger à l'insertion)
INSERT INTO carrier (code, name, api_base_url, api_key) VALUES
  ('PXP', 'Parcel Express sandbox', 'https://⟬hostname#4⟭/api', '⟬opaque_token#4⟭'),
  ('LTL', 'Freight LTL sandbox',    'https://⟬hostname#5⟭/v1',  '⟬opaque_token#5⟭');

INSERT INTO driver (carrier_code, full_name, phone, license_state, license_number, hazmat) VALUES
  ('LTL', '⟬person_name#6⟭', '⟬phone#6⟭', 'IL', '⟬us_driver_license#6⟭', true),
  ('LTL', '⟬person_name#7⟭', '⟬phone#7⟭', 'TX', '⟬us_driver_license#7⟭', false),
  ('LTL', '⟬person_name#8⟭', '⟬phone#8⟭', 'NJ', '⟬us_driver_license#8⟭', false);

-- utilisateur démo, mot de passe en clair pour l'avant-vente : ⟬password#9⟭
-- (password_hash = bcrypt de cette valeur)
INSERT INTO app_user (email, display_name, role, password_hash, locale) VALUES
  ('⟬email:generic#9⟭', 'Demo Manager', 'site_manager', '⟬hash#9⟭', 'en-US'),
  ('⟬email#10⟭', '⟬person_name#10⟭', 'admin', '⟬hash#10⟭', 'en-US');

INSERT INTO sku (code, description, weight_lb, hazmat_class) VALUES
  ('PAL-48x40', 'Standard pallet 48x40', 45.0, NULL),
  ('BAT-LI-12', 'Lithium battery pack 12V', 8.2, '9'),
  ('PAINT-5G',  'Latex paint 5 gal', 52.0, NULL);

INSERT INTO inbound_shipment (warehouse_code, carrier_code, eta, status, driver_name) VALUES
  ('CHI1', 'LTL', now() + interval '2 hours', 'scheduled', '⟬person_name#6⟭'),
  ('DAL2', 'LTL', now() + interval '1 day',   'scheduled', '⟬trap:indicator_non_pii|TBD⟭');

COMMIT;
⟬end⟭

⟬template⟭
family: code
format: .java
language: mixed
fill_locale: fr_FR
domain: banking
appearance: enum constant, Javadoc, constant
scenario: enum of SEPA return reason codes in the English Java codebase of a French payment processor, with the French labels shown to merchants and field limits from the rulebook
⟬text⟭
package fr.paylink.sepa.returns;

import java.util.Arrays;

/**
 * SEPA R-transaction reason codes (EPC rulebook), with the French label shown to merchants
 * in the back office. Only the codes our partner bank actually sends are listed.
 *
 * @see <a href="⟬url#1⟭">EPC guidance on reason codes</a>
 */
public enum ReturnReason {
    AC01("Numéro de compte incorrect", true),
    AC04("Compte clôturé", false),
    AC06("Compte bloqué", false),
    AG01("Opération interdite sur ce type de compte", false),
    AM04("Provision insuffisante", true),
    MD01("Absence de mandat", false),
    MD06("Contestation du débiteur", false),
    MS02("Motif non communiqué par le débiteur", true),
    RC01("BIC incorrect", true),
    SL01("Service spécifique de la banque du débiteur", false);

    /** Rulebook limits applied when a pain.008 is rebuilt after a return. */
    public static final int ⟬trap:indicator_non_pii|DEBTOR_NAME_MAX_LENGTH = 70⟭;
    public static final int ⟬trap:indicator_non_pii|MANDATE_ID_MAX_LENGTH = 35⟭;
    /** A debtor may dispute an authorised debit for 8 weeks (MD06). */
    public static final int DISPUTE_WINDOW_WEEKS = 8;

    private final String libelle;
    private final boolean retryable;

    ReturnReason(String libelle, boolean retryable) {
        this.libelle = libelle;
        this.retryable = retryable;
    }

    public String libelle() {
        return libelle;
    }

    /** Whether the merchant may present the debit again (at most once, per our contract). */
    public boolean retryable() {
        return retryable;
    }

    public static ReturnReason fromCode(String code) {
        return Arrays.stream(values())
                .filter(r -> r.name().equalsIgnoreCase(code.trim()))
                .findFirst()
                .orElseThrow(() -> new IllegalArgumentException("Code retour SEPA inconnu : " + code));
    }
}
⟬end⟭

⟬template⟭
family: code
format: .ipynb
language: mixed
fill_locale: fr_FR
domain: e-commerce
appearance: markdown cell, notebook output, function call
scenario: pricing analyst's notebook with English markdown measuring price elasticity across the collections of a French perfume e-shop, several of which carry given names
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Price elasticity by collection, H1\n",
    "\n",
    "Weekly sales from the warehouse (collection names are French). Log-log regression of units on price, one model per collection."
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
       "collection\n",
       "⟬trap:word_name|Jade⟭               18422\n",
       "Ambre              12001\n",
       "⟬trap:word_name|Victoire⟭           9875\n",
       "Fleur d'oranger     6410\n",
       "⟬trap:word_name|Céleste⟭            3388\n",
       "⟬trap:indicator_non_pii|Name: units⟭, dtype: int64"
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
    "import statsmodels.formula.api as smf\n",
    "\n",
    "sales = pd.read_parquet(\"⟬file_path#1⟭\")\n",
    "sales.groupby(\"collection\")[\"units\"].sum().sort_values(ascending=False)"
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
       "                 elasticity  ci_low  ci_high  n_weeks\n",
       "collection                                           \n",
       "Ambre                 -1.42   -1.71    -1.13       26\n",
       "Fleur d'oranger       -1.05   -1.48    -0.62       26\n",
       "⟬trap:word_name|Jade⟭                  -0.41   -0.66    -0.16       26\n",
       "⟬trap:word_name|Céleste⟭               -0.97   -1.60    -0.34       18\n",
       "⟬trap:word_name|Victoire⟭              -1.88   -2.20    -1.56       26"
      ]
     },
     "execution_count": 2,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "rows = []\n",
    "for name, grp in sales.groupby(\"collection\"):\n",
    "    fit = smf.ols(\"np.log(units) ~ np.log(price)\", data=grp).fit()\n",
    "    low, high = fit.conf_int().loc[\"np.log(price)\"]\n",
    "    rows.append({\"collection\": name, \"elasticity\": fit.params[\"np.log(price)\"], \"ci_low\": low, \"ci_high\": high, \"n_weeks\": len(grp)})\n",
    "pd.DataFrame(rows).set_index(\"collection\").round(2)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "⟬trap:word_name|Jade⟭ is close to inelastic: the 10 % promotion of week 14 barely moved volume. ⟬trap:word_name|Victoire⟭ reacts strongly, keep it in the Black Friday list.\n",
    "Price file for the buying team: `⟬file_path#2⟭`."
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
language: mixed
fill_locale: fr_FR
domain: healthcare
appearance: docstring, constant, exception message, comment
scenario: FastAPI router of a French pharmacy group's stock API, English code with French docstrings, exposing stock levels per pharmacy and refusing any patient reference
⟬text⟭
"""Stocks des officines du groupement : disponibilité par produit et par pharmacie.

Aucune donnée patient ici : les ordonnances restent dans le logiciel de chaque officine.
"""
from fastapi import APIRouter, Depends, HTTPException, Query
from pydantic import BaseModel

from .auth import require_scope
from .db import stock_repository

router = APIRouter(prefix="/stocks", tags=["stocks"])

⟬trap:indicator_non_pii|API_KEY_HEADER = "X-Api-Key"⟭
⟬trap:indicator_non_pii|PATIENT_REF_HEADER = "X-Patient-Ref"⟭  # refusé par le middleware, voir security.py


class StockLine(BaseModel):
    cip13: str
    libelle: str
    pharmacie: str
    ville: str
    quantite: int
    seuil_alerte: int


@router.get("/{cip13}", response_model=list[StockLine])
async def stock_par_produit(cip13: str, ville: str | None = Query(None), repo=Depends(stock_repository),
                            _=Depends(require_scope("stocks:read"))):
    """Disponibilité d'un produit (code CIP13) dans les officines, filtrable par ville.

    Exemple : GET /stocks/3400930000000?ville=⟬city#1⟭ renvoie
    [{"pharmacie": "⟬trap:company_name|Pharmacie ⦃Family⦄⟭", "ville": "⟬city#1⟭", "quantite": 4, ...}]
    """
    if len(cip13) != 13 or not cip13.isdigit():
        raise HTTPException(422, "Le code CIP doit comporter 13 chiffres")
    lines = await repo.by_product(cip13, ville=ville)
    if not lines:
        raise HTTPException(404, "Produit inconnu ou en rupture partout")
    return lines


@router.get("/alertes/ruptures")
async def ruptures(departement: str = Query(..., min_length=2, max_length=3), repo=Depends(stock_repository),
                   _=Depends(require_scope("stocks:read"))):
    """Produits sous le seuil d'alerte, pour la tournée du grossiste (⟬company#1⟭)."""
    return await repo.below_threshold(departement)
⟬end⟭

⟬template⟭
family: code
format: .ts
language: mixed
fill_locale: en_GB
domain: HR
appearance: validation schema, object literal, comment, placeholder
scenario: Zod validation schema with French comments for the UK job application form a French agency built for a warehouse recruiter, English error messages and documented placeholder values as input hints
⟬text⟭
// Schéma de validation du formulaire de candidature (client UK, recrutement entrepôts).
// Messages en anglais : affichés tels quels aux candidats. Aucune donnée réelle ici.
import { z } from "zod";

// NI number : 2 lettres, 6 chiffres, 1 lettre A-D ; certains préfixes ne sont jamais attribués.
const NI_RE = /^(?!BG|GB|NK|KN|TN|NT|ZZ)[A-CEGHJ-PR-TW-Z][A-CEGHJ-NPR-TW-Z]\d{6}[A-D]$/;

function age(d: Date): number {
  const now = new Date();
  const birthdayPassed = now >= new Date(now.getFullYear(), d.getMonth(), d.getDate());
  return now.getFullYear() - d.getFullYear() - (birthdayPassed ? 0 : 1);
}

export const applicationSchema = z.object({
  forename: z.string().trim().min(1, "Enter your first name"),
  surname: z.string().trim().min(1, "Enter your last name"),
  dateOfBirth: z.coerce.date().refine((d) => age(d) >= 18, "You must be 18 or over to apply"),
  niNumber: z
    .string()
    .transform((v) => v.replace(/\s/g, "").toUpperCase())
    .refine((v) => NI_RE.test(v), "Enter a National Insurance number in the correct format"),
  email: z.string().email("Enter an email address in the correct format"),
  phone: z.string().regex(/^(\+44\s?7\d{3}|07\d{3})\s?\d{3}\s?\d{3}$/, "Enter a UK mobile number"),
  postcode: z.string().regex(/^[A-Z]{1,2}\d[A-Z\d]? ?\d[A-Z]{2}$/i, "Enter a real postcode"),
  rightToWork: z.literal(true, { errorMap: () => ({ message: "Confirm that you have the right to work in the UK" }) }),
});

// valeurs d'exemple affichées en placeholder des champs (formats officiels de démonstration)
export const placeholders = {
  niNumber: "⟬trap:placeholder|QQ 12 34 56 C⟭",
  dateOfBirth: "⟬trap:placeholder|DD/MM/YYYY⟭",
  phone: "⟬trap:placeholder|07700 900000⟭",
};

export type Application = z.infer<typeof applicationSchema>;
⟬end⟭

⟬template⟭
family: code
format: .sql
language: mixed
fill_locale: fr_FR
domain: SaaS
appearance: CTE, comment, SQL WHERE
scenario: monthly usage aggregation query for the billing of a SaaS analytics product, English SQL with the French finance team's comments, computing overage per tenant and plan
⟬text⟭
-- Agrégation mensuelle de l'usage pour la facturation (lancée le 1er par le job billing-close).
-- Règle finance : on facture les événements ingérés, pas les requêtes ; au-delà du quota du plan,
-- dépassement au millier d'événements.
WITH usage AS (
  SELECT tenant_id,
         date_trunc('month', ingested_at) AS mois,
         count(*) AS events,
         count(DISTINCT source_id) AS sources
  FROM events_ingested
  WHERE ingested_at >= date_trunc('month', now()) - interval '1 month'
    AND ingested_at < date_trunc('month', now())
  GROUP BY 1, 2
)
SELECT t.id,
       t.name AS tenant,
       p.code AS plan,
       u.events,
       u.sources,
       p.included_events,
       greatest(u.events - p.included_events, 0) AS overage,
       round(greatest(u.events - p.included_events, 0) / 1000.0 * p.price_per_1k_cents / 100, 2) AS overage_eur
FROM usage u
JOIN tenant t ON t.id = u.tenant_id
JOIN plan p ON p.code = t.plan_code
WHERE t.status = 'active'
  -- les tenants internes et de démo ne sont jamais facturés
  AND NOT (⟬trap:indicator_non_pii|t.owner = 'system'⟭ OR t.name LIKE 'demo-%')
ORDER BY overage_eur DESC;

-- vérif rapide : ⟬company#1⟭ doit sortir à 0 (forfait illimité signé le ⟬date#1⟭)
⟬end⟭
