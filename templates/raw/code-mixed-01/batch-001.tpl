⟬template⟭
family: code
format: .py
language: mixed
fill_locale: fr_FR
domain: banking
appearance: docstring, semicolon-separated row, URL, comment, dict literal
scenario: Django management command a fintech backend developer wrote to import the nightly SEPA mandate file of a French partner bank, with the first row of the bank's sample pasted in the module docstring
⟬text⟭
"""Import the nightly SEPA direct-debit mandate file sent by the partner bank.

The bank drops a semicolon-separated file on the SFTP every night (cp1252,
French headers). Their spec PDF does not document the column order, so here is
the first data row of the onboarding sample they sent us:

    RUM;Titulaire;IBAN;Adresse;Date signature
    RUM-2023-004417;⟬person_name#1⟭;⟬iban#1⟭;⟬fr_postal_address#1⟭;⟬date#2⟭

Usage: ./manage.py import_mandates /srv/sftp/in/mandats_YYYYMMDD.csv [--dry-run]
"""
import csv
import os
from datetime import datetime

import psycopg
from ⟬trap:library|django⟭.core.management.base import BaseCommand, CommandError
from ⟬trap:library|django⟭.db import transaction

from billing.models import Mandate
from billing.sepa import normalise_iban

# Format questions go to the bank's integration desk:
# ⟬person_name#3⟭ <⟬email#3⟭>, "équipe flux SEPA", last spec change on ⟬date#1⟭.
COLUMNS = {
    "RUM": "reference",
    ⟬trap:indicator_non_pii|"Titulaire": "holder_name"⟭,
    "IBAN": "iban",
    "Adresse": "holder_address",
    "Date signature": "signed_on",
}

# Read-only replica of the pre-2024 mandates database; mandates found there were
# migrated by hand and must not be created twice.
LEGACY_DSN = os.environ.get(
    "LEGACY_MANDATES_DSN",
    "postgresql://mandates_ro:⟬url_password#1⟭@⟬hostname#1⟭:5432/mandates",
)


def _legacy_references() -> set:
    with psycopg.connect(LEGACY_DSN) as conn:
        return {row[0] for row in conn.execute("SELECT rum FROM mandat WHERE statut = 'actif'")}


class Command(BaseCommand):
    help = "Import the nightly mandate file from the partner bank"

    def add_arguments(self, parser):
        parser.add_argument("path")
        parser.add_argument("--dry-run", action="store_true")

    def handle(self, path, dry_run=False, **options):
        if not os.path.exists(path):
            raise CommandError(f"{path} not found")
        legacy = _legacy_references()
        created = skipped = 0
        with open(path, encoding="cp1252", newline="") as handle, transaction.atomic():
            for row in csv.DictReader(handle, delimiter=";"):
                fields = {COLUMNS[key]: value.strip() for key, value in row.items() if key in COLUMNS}
                if fields["reference"] in legacy or Mandate.objects.filter(reference=fields["reference"]).exists():
                    skipped += 1
                    continue
                fields["iban"] = normalise_iban(fields["iban"])
                fields["signed_on"] = datetime.strptime(fields["signed_on"], "%d/%m/%Y").date()
                Mandate.objects.create(**fields)
                created += 1
            if dry_run:
                transaction.set_rollback(True)
        self.stdout.write(f"{created} mandates created, {skipped} skipped")
⟬end⟭

⟬template⟭
family: code
format: .ts
language: mixed
fill_locale: en_US
domain: healthcare
appearance: decorator, object literal, comment, import
scenario: NestJS DTO that a French agency team, commenting in French, wrote for a US telehealth client, with Swagger examples copied from the client's QA test patient
⟬text⟭
// DTO d'inscription patient pour le client US (réseau de télémédecine, Texas).
// Le SSN n'est jamais persisté en clair : voir EncryptionService.encryptField().
// Les exemples Swagger viennent du patient de recette de leur QA (envoyé le ⟬date#1⟭).
// TODO ⟬ticket_id#1⟭ : remplacer par des valeurs bidon avant la démo investisseurs.
import { ApiProperty, ApiPropertyOptional } from "⟬trap:email_lookalike|@nestjs/swagger⟭";
import { IsDateString, IsEmail, IsOptional, IsPhoneNumber, IsString, Matches } from "class-validator";

export class RegisterPatientDto {
  @ApiProperty({ example: "⟬person_name:given#1⟭" })
  @IsString()
  firstName: string;

  @ApiProperty({ example: "⟬person_name:family#1⟭" })
  @IsString()
  lastName: string;

  @ApiProperty({ example: "⟬birth_date#1⟭", description: "Date de naissance (ISO 8601)" })
  @IsDateString()
  dateOfBirth: string;

  // 9 chiffres, tirets optionnels ; le front envoie parfois des espaces, on nettoie dans le pipe
  @ApiProperty({ example: "⟬us_ssn#1⟭" })
  @Matches(/^\d{3}-?\d{2}-?\d{4}$/)
  ssn: string;

  @ApiProperty({ example: "⟬phone#1⟭" })
  @IsPhoneNumber("US")
  phone: string;

  @ApiProperty({ example: "⟬email#1⟭" })
  @IsEmail()
  email: string;

  @ApiProperty({ example: "⟬postal_address#1⟭", description: "Adresse complète sur une ligne, l'API Medicaid la redécoupe" })
  @IsString()
  homeAddress: string;

  @ApiPropertyOptional({ example: "⟬person_name#2⟭", description: "Contact d'urgence" })
  @IsOptional()
  @IsString()
  emergencyContactName?: string;

  @ApiPropertyOptional({ example: "⟬phone#2⟭" })
  @IsOptional()
  emergencyContactPhone?: string;
}
⟬end⟭

⟬template⟭
family: code
format: .sql
language: mixed
fill_locale: fr_FR
domain: HR
appearance: SQL INSERT, comment, placeholder
scenario: staging seed script for the French payroll module of an HR SaaS, written in English by a contractor over French table and column names, with three employees copied from the client's onboarding test file
⟬text⟭
-- seed_payroll_fr_staging.sql
-- Seed data for the FR payroll module, STAGING ONLY.
-- Source: onboarding test file from the client HR team (⟬date#1⟭). Column names follow
-- their DSN export, hence the French. nir = 15 digits including the 2-digit key.
-- Never run against prod: payroll_fr there is fed by the HRIS sync.

BEGIN;

SET search_path TO payroll_fr;

TRUNCATE salarie, contrat, parametre RESTART IDENTITY CASCADE;

INSERT INTO salarie (matricule, nom, prenom, date_naissance, nir, adresse_ligne1, code_postal, ville, iban_salaire, date_entree, poste)
VALUES
  ('FR-00412', '⟬person_name:family#1⟭', '⟬person_name:given#1⟭', '⟬birth_date#1⟭', '⟬fr_social_security_number#1⟭', '⟬fr_postal_address:street#1⟭', '⟬postcode#1⟭', '⟬city#1⟭', '⟬iban#1⟭', '⟬date#2⟭', '⟬job_title#1⟭'),
  ('FR-00413', '⟬person_name:family#2⟭', '⟬person_name:given#2⟭', '⟬birth_date#2⟭', '⟬fr_social_security_number#2⟭', '⟬fr_postal_address:street#2⟭', '⟬postcode#2⟭', '⟬city#2⟭', '⟬iban#2⟭', '⟬date#3⟭', '⟬job_title#2⟭'),
  -- apprentice: no IBAN yet, the payslip goes out with a cheque until the bank details arrive
  ('FR-00414', '⟬person_name:family#3⟭', '⟬person_name:given#3⟭', '⟬birth_date#3⟭', '⟬fr_social_security_number#3⟭', '⟬fr_postal_address:street#3⟭', '⟬postcode#3⟭', '⟬city#3⟭', NULL, '⟬date#4⟭', 'Apprenti(e) comptable');

INSERT INTO contrat (matricule, type_contrat, temps_partiel, salaire_brut_annuel, convention)
VALUES
  ('FR-00412', 'CDI', false, 46500, 'SYNTEC'),
  ('FR-00413', 'CDD', true, 28900, 'SYNTEC'),
  ('FR-00414', 'APPRENTISSAGE', false, 14200, 'SYNTEC');

-- display rules read by the payslip renderer
INSERT INTO parametre (cle, valeur) VALUES
  ('nir_affichage', '⟬trap:placeholder|* ** ** ** *** *** **⟭'),
  ⟬trap:indicator_non_pii|('date_naissance_format', 'DD/MM/YYYY')⟭,
  ('iban_masque', 'true');

COMMIT;
⟬end⟭

⟬template⟭
family: code
format: .java
language: mixed
fill_locale: fr_FR
domain: SaaS
appearance: constant, Javadoc, comment
scenario: constants class in the English Java codebase of a SaaS integration vendor, where a developer pasted a French client's GitLab token and webhook secret during a hotfix
⟬text⟭
package io.relaydesk.integrations.gitlab;

/** Connection settings for the self-hosted GitLab of ⟬company#1⟭. Temporary, see TODO. */
final class GitLabClientConstants {

    static final String BASE_URL = "https://⟬hostname#1⟭/api/v4";
    // TODO(hotfix ⟬ticket_id#1⟭) move to Vault: jeton perso de ⟬person_name#1⟭, expire fin du mois
    static final String PRIVATE_TOKEN = "⟬gitlab_token#1⟭";
    static final String WEBHOOK_SECRET = "⟬opaque_token#1⟭";
    static final String ⟬trap:indicator_non_pii|DEFAULT_ASSIGNEE = "support-bot"⟭;
    static final int ⟬trap:indicator_non_pii|TOKEN_EXPIRY_WARNING_DAYS = 7⟭;

    private GitLabClientConstants() {}
}
⟬end⟭

⟬template⟭
family: code
format: .ipynb
language: mixed
fill_locale: fr_FR
domain: e-commerce
appearance: notebook output, markdown cell, URL, function call, comment
scenario: data analyst's notebook with English markdown exploring why French customers return orders, with the replica DSN pasted in a cell, customer rows in the output and the SMTP login used to mail the summary
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Returns, Q3: why do French customers send things back?\n",
    "\n",
    "Read replica of the shop DB. Reasons are free text in French (`motif_retour`), typed by the customer in the returns form; `motif_cat` is the category the support agent picked."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "metadata": {},
   "outputs": [],
   "source": [
    "import ⟬trap:library|pandas⟭ as pd\n",
    "from sqlalchemy import create_engine\n",
    "\n",
    "# TODO move to ~/.pgpass, this notebook lives on the shared drive\n",
    "engine = create_engine(\"postgresql+psycopg2://analytics:⟬url_password#1⟭@⟬hostname#1⟭:5432/shop\")"
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
       "                nom_complet                     email                         adresse_livraison                          motif_retour\n",
       "0  ⟬person_name#2⟭  ⟬email#2⟭  ⟬fr_postal_address#2⟭  taille trop petite, je fais du 39\n",
       "1  ⟬person_name#3⟭  ⟬email#3⟭  ⟬fr_postal_address#3⟭  la couleur ⟬trap:word_name|Rose⟭ ne ressemble pas à la photo\n",
       "2  ⟬person_name#4⟭  ⟬email#4⟭  ⟬fr_postal_address#4⟭  colis arrivé ouvert, voir avec le transporteur"
      ]
     },
     "execution_count": 2,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "q = \"\"\"\n",
    "SELECT c.nom_complet, c.email, c.adresse_livraison, r.motif_retour, r.motif_cat\n",
    "FROM retours r JOIN clients c USING (client_id)\n",
    "WHERE r.created_at >= '2024-07-01' AND r.created_at < '2024-10-01'\n",
    "\"\"\"\n",
    "returns = pd.read_sql(q, engine)\n",
    "returns[[\"nom_complet\", \"email\", \"adresse_livraison\", \"motif_retour\"]].head(3)"
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
       "taille trop petite     412\n",
       "taille trop grande     377\n",
       "ne correspond pas      201\n",
       "arrivé endommagé        96\n",
       "délai de livraison      58\n",
       "⟬trap:indicator_non_pii|Name: motif_cat⟭, dtype: int64"
      ]
     },
     "execution_count": 3,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "counts = returns[\"motif_cat\"].value_counts()\n",
    "counts.head(5)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Sizing is ~60 % of returns. Send the summary to the category managers (they want it in French)."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 4,
   "metadata": {},
   "outputs": [],
   "source": [
    "import smtplib\n",
    "from email.message import EmailMessage\n",
    "\n",
    "summary_fr = \"Retours T3 par motif :\\n\" + \"\\n\".join(f\"- {k} : {v}\" for k, v in counts.head(5).items())\n",
    "msg = EmailMessage()\n",
    "msg[\"Subject\"] = \"Retours T3 : synthèse\"\n",
    "msg[\"From\"] = \"⟬email:generic#5⟭\"\n",
    "msg[\"To\"] = \"⟬email:generic#6⟭\"\n",
    "msg.set_content(summary_fr)\n",
    "with smtplib.SMTP_SSL(\"⟬hostname#2⟭\", 465) as smtp:\n",
    "    smtp.login(\"⟬email:generic#5⟭\", \"⟬password#1⟭\")\n",
    "    smtp.send_message(msg)"
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
format: .py
language: mixed
fill_locale: en_GB
domain: logistics
appearance: comment, HTTP header, URL query string, dict literal, test call
scenario: cron script with French comments by the developer of a French freight forwarder, sending UK customs pre-declarations for British consignees to a broker API, with the broker key under an innocuous header and the HS code table read from the internal GitLab
⟬text⟭
# Envoi des pré-déclarations douane UK au transitaire (obligatoire avant le départ du
# camion depuis le Brexit). Lancé par le cron de 5h45 sur le serveur d'exploitation.
# Logs : /var/log/expe/douane_uk.log. Une 401 = voir avec le transitaire, pas chez nous.
import json
import logging
import sys

import requests

log = logging.getLogger("douane_uk")

BROKER_URL = "https://⟬hostname#1⟭/v2/pre-declarations"
# ils appellent ça "client ref" dans leur doc mais c'est bien la clé d'API, ne pas logger
HEADERS = {"X-Client-Ref": "⟬opaque_token#1⟭", "Content-Type": "application/json"}

# table des codes SH versionnée dans le GitLab interne (projet douane/referentiels)
HS_TABLE_URL = "https://⟬hostname#2⟭/api/v4/projects/412/repository/files/hs_codes.json/raw?ref=main&private_token=⟬gitlab_token#1⟭"


def charger_codes_sh():
    reponse = requests.get(HS_TABLE_URL, timeout=10)
    reponse.raise_for_status()
    return reponse.json()


def construire_declaration(expedition, codes_sh):
    return {
        "consignee": {
            "name": expedition["nom_destinataire"],
            "address": expedition["adresse"],
            "phone": expedition["tel"],
        },
        "goods": [
            {"hs_code": codes_sh[ligne["famille"]], "description": ligne["libelle_en"], "weight_kg": ligne["poids"]}
            for ligne in expedition["lignes"]
        ],
        "incoterm": expedition.get("incoterm", "DAP"),
    }


def envoyer(declaration):
    reponse = requests.post(BROKER_URL, headers=HEADERS, data=json.dumps(declaration), timeout=30)
    if reponse.status_code >= 400:
        log.error("refus transitaire %s : %s", reponse.status_code, reponse.text[:500])
        return False
    return True


if __name__ == "__main__":
    # test à la main avec l'expédition qui bloquait mardi
    exemple = {
        "nom_destinataire": "⟬person_name#1⟭",
        "adresse": "⟬postal_address#1⟭",
        "tel": "⟬phone#1⟭",
        "incoterm": "DDP",
        "lignes": [{"famille": "chaussures_cuir", "libelle_en": "leather shoes", "poids": 4.2}],
    }
    sys.exit(0 if envoyer(construire_declaration(exemple, charger_codes_sh())) else 1)
⟬end⟭

⟬template⟭
family: code
format: .ts
language: mixed
fill_locale: fr_FR
domain: banking
appearance: template literal, object literal, Jest test, assertion, comment
scenario: Jest spec for the card-issuer webhook endpoint of a French neobank, English code over the issuer's French payload fields, with the sandbox signing key and HMAC secret inlined and two French cardholders as fixtures
⟬text⟭
/**
 * Card-issuer webhooks: authorisations, clearing, card status changes.
 *
 * The issuer is French and so is their payload (porteur, montant_centimes, ...).
 * They sign each call with HMAC-SHA256 in `x-signature`; our acknowledgement is
 * signed with the sandbox key pair from their onboarding pack.
 */
import crypto from "node:crypto";
import request from "supertest";

import { buildApp } from "../src/app";
import type { IssuerEvent } from "../src/issuer/types";

// Sandbox only. The public half is registered in the issuer's back office.
const SANDBOX_ACK_KEY = `⟬private_key#1⟭`;
const ISSUER_HMAC_SECRET = "⟬opaque_token#1⟭";

const porteur = {
  nom: "⟬person_name:family#1⟭",
  prenom: "⟬person_name:given#1⟭",
  email: "⟬email#1⟭",
  iban_rattache: "⟬iban#1⟭",
  adresse_facturation: "⟬fr_postal_address#1⟭",
};

// card reported stolen in the sandbox scenario sent by ⟬person_name:initial#3⟭ (risk team)
const porteurOpposition = {
  nom: "⟬person_name:family#2⟭",
  prenom: "⟬person_name:given#2⟭",
  email: "⟬email#2⟭",
  iban_rattache: "⟬iban#2⟭",
  adresse_facturation: "⟬fr_postal_address#2⟭",
};

function sign(body: string): string {
  return crypto.createHmac("sha256", ISSUER_HMAC_SECRET).update(body).digest("hex");
}

function event(overrides: Partial<IssuerEvent>): IssuerEvent {
  return {
    type: "autorisation",
    id_evenement: "⟬uuid#1⟭",
    porteur,
    montant_centimes: 4590,
    devise: "EUR",
    commercant: "⟬company#1⟭",
    ...overrides,
  };
}

describe("POST /webhooks/issuer", () => {
  const app = buildApp({ issuerSecret: ISSUER_HMAC_SECRET, ackKey: SANDBOX_ACK_KEY });

  it("accepts a signed authorisation and acknowledges it", async () => {
    const body = JSON.stringify(event({}));
    const res = await request(app)
      .post("/webhooks/issuer")
      .set("content-type", "application/json")
      .set("x-signature", sign(body))
      .send(body);

    expect(res.status).toBe(200);
    expect(res.body).toMatchObject({ status: "ok", ⟬trap:indicator_non_pii|holder: "masked"⟭ });
    expect(res.headers["x-ack-signature"]).toBeDefined();
  });

  it("rejects a payload whose signature does not match", async () => {
    const body = JSON.stringify(event({ montant_centimes: 999999 }));
    const res = await request(app)
      .post("/webhooks/issuer")
      .set("content-type", "application/json")
      .set("x-signature", sign(JSON.stringify(event({}))))
      .send(body);

    expect(res.status).toBe(401);
  });

  it("blocks the card on a status change to opposition", async () => {
    const body = JSON.stringify(event({ type: "statut_carte", porteur: porteurOpposition, statut: "OPPOSITION" }));
    const res = await request(app)
      .post("/webhooks/issuer")
      .set("content-type", "application/json")
      .set("x-signature", sign(body))
      .send(body);

    expect(res.status).toBe(200);
    // the ledger must never echo the IBAN back, even masked: the issuer flagged it in the audit
    expect(JSON.stringify(res.body)).not.toContain("⟬iban#2⟭");
  });

  it("does not log the billing address of the cardholder", async () => {
    const spy = jest.spyOn(console, "info").mockImplementation(() => undefined);
    const body = JSON.stringify(event({}));
    await request(app).post("/webhooks/issuer").set("x-signature", sign(body)).send(body);
    expect(spy.mock.calls.flat().join(" ")).not.toContain(porteur.adresse_facturation);
    spy.mockRestore();
  });
});
⟬end⟭

⟬template⟭
family: code
format: .sql
language: mixed
fill_locale: en_US
domain: healthcare
appearance: SQL WHERE, comment, commented-out line
scenario: ad-hoc query a French developer saved in the scratch folder of a US clinic's repository, with French comments, to track down a patient the clinic's support reported as duplicated
⟬text⟭
-- doublon signalé par le support de la clinique (⟬ticket_id#1⟭)
-- même SSN, deux dossiers créés à 3 jours d'écart : on garde le plus ancien
SELECT p.id, p.mrn, p.first_name, p.last_name, p.dob, p.created_at, p.source
FROM patients p
WHERE p.ssn = '⟬us_ssn#1⟭'
   OR (p.last_name = '⟬person_name:family#1⟭' AND p.dob = '⟬birth_date#1⟭')
ORDER BY p.created_at;

-- fusion des RDV : NE PAS lancer avant le feu vert de ⟬person_name:given#2⟭ côté clinique
-- UPDATE appointments SET patient_id = :keep_id WHERE patient_id = :drop_id;
-- UPDATE patients SET merged_into = :keep_id, ssn = NULL WHERE id = :drop_id;
⟬end⟭

⟬template⟭
family: code
format: .java
language: mixed
fill_locale: en_US
domain: HR
appearance: builder call, constant, assertion, Javadoc, comment
scenario: JUnit 5 test a French offshore team wrote for a US payroll client's W-4 onboarding service, with French comments, a builder filled with the client's test hire and the sandbox login password
⟬text⟭
package com.paylane.onboarding;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

import java.time.LocalDate;
import java.util.List;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import com.paylane.onboarding.audit.InMemoryAuditLog;
import com.paylane.onboarding.irs.SandboxTinMatchingClient;

/**
 * Tests du service d'onboarding W-4 (client US).
 * Le salarié de test vient du jeu de recette envoyé par leur RH : ne pas le réutiliser ailleurs.
 */
class W4OnboardingServiceTest {

    // compte sandbox du service TIN matching ; mot de passe tourné tous les 90 jours par leur IT
    private static final String ⟬trap:indicator_non_pii|SANDBOX_USER = "qa-integration"⟭;
    private static final String SANDBOX_PASSWORD = "⟬password#1⟭";

    private InMemoryAuditLog audit;
    private W4OnboardingService service;

    @BeforeEach
    void setUp() {
        audit = new InMemoryAuditLog();
        service = new W4OnboardingService(new SandboxTinMatchingClient(SANDBOX_USER, SANDBOX_PASSWORD), audit);
    }

    // nouvel embauché : il démarre le 1er du mois, statut "single", un seul employeur
    private Employee newHire() {
        return Employee.builder()
                .firstName("⟬person_name:given#1m⟭")
                .lastName("⟬person_name:family#1⟭")
                .ssn("⟬us_ssn#1⟭")
                .dateOfBirth(LocalDate.parse("⟬birth_date#1⟭"))
                .workEmail("⟬email#1⟭")
                .homeAddress("⟬postal_address#1⟭")
                .filingStatus(FilingStatus.SINGLE)
                .multipleJobs(false)
                .build();
    }

    @Test
    void createsW4WhenTinMatches() {
        W4Form form = service.onboard(newHire());
        assertThat(form.getStatus()).isEqualTo(W4Status.SUBMITTED);
        assertThat(form.getEmployeeSsnLast4()).hasSize(4);
    }

    @Test
    void neverWritesTheFullSsnToTheAuditLog() {
        service.onboard(newHire());
        // exigence SOC 2 du client : le SSN complet ne doit jamais sortir du coffre
        List<String> lines = audit.lines();
        assertThat(lines).noneMatch(line -> line.contains("⟬us_ssn#1⟭"));
    }

    @Test
    void rejectsMinors() {
        Employee minor = newHire().toBuilder().dateOfBirth(LocalDate.now().minusYears(15)).build();
        assertThatThrownBy(() -> service.onboard(minor)).hasMessageContaining("minimum age");
    }
}
⟬end⟭

⟬template⟭
family: code
format: .py
language: mixed
fill_locale: fr_FR
domain: SaaS
appearance: comment, keyword argument, triple-quoted string
scenario: throwaway script an agency developer left in the scripts folder to mirror every repository of a French client's GitLab before the server was switched off, with the token and the SSH deploy key inlined
⟬text⟭
# quick & dirty: mirror all of the client's repos before their GitLab box is switched off
# asked by ⟬person_name#1⟭ on ⟬date#1⟭: "on coupe le serveur vendredi, récupérez tout"
import os, subprocess, tempfile
import gitlab

gl = gitlab.Gitlab("https://⟬hostname#1⟭", private_token="⟬gitlab_token#1⟭")
DEPLOY_KEY = """⟬private_key#1⟭
"""

with tempfile.NamedTemporaryFile("w", delete=False) as f:
    f.write(DEPLOY_KEY)
os.chmod(f.name, 0o600)
env = {**os.environ, "GIT_SSH_COMMAND": f"ssh -i {f.name} -o StrictHostKeyChecking=no"}
for p in gl.projects.list(iterator=True):
    subprocess.run(["git", "clone", "--mirror", p.ssh_url_to_repo, f"mirrors/{p.path_with_namespace}.git"], env=env, check=True)
⟬end⟭

⟬template⟭
family: code
format: .ipynb
language: mixed
fill_locale: en_US
domain: banking
appearance: notebook output, markdown cell, triple-quoted string, keyword argument
scenario: notebook of a French data scientist on a card fraud team, markdown in French, clustering US chargebacks from Snowflake with key-pair auth, the service account private key pasted in a cell and cardholder rows in the output
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Chargebacks US, T3 : premiers clusters\n",
    "\n",
    "Objectif : repérer les litiges *item not received* (reason code 13.1) qui se concentrent sur quelques commerçants.\n",
    "Source : `RISK.CHARGEBACKS_US` (Snowflake, rôle `RISK_ANALYST`). Les colonnes sont celles de l'émetteur, en anglais."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "metadata": {},
   "outputs": [],
   "source": [
    "import ⟬trap:library|pandas⟭ as pd\n",
    "import snowflake.connector\n",
    "from cryptography.hazmat.primitives import serialization\n",
    "\n",
    "# clé du compte de service : à sortir du notebook AVANT de le partager !!\n",
    "PEM = \"\"\"⟬private_key#1⟭\"\"\"\n",
    "key = serialization.load_pem_private_key(PEM.encode(), ⟬trap:indicator_non_pii|password=None⟭)\n",
    "conn = snowflake.connector.connect(\n",
    "    account=\"risk-analytics.us-east-1\",\n",
    "    ⟬trap:indicator_non_pii|user=\"SVC_RISK_NOTEBOOK\"⟭,\n",
    "    private_key=key.private_bytes(serialization.Encoding.DER, serialization.PrivateFormat.PKCS8, serialization.NoEncryption()),\n",
    "    warehouse=\"RISK_XS\",\n",
    "    role=\"RISK_ANALYST\",\n",
    ")"
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
       "           cardholder                 pan          ssn            merchant  amount_usd\n",
       "0  ⟬person_name#2⟭  ⟬payment_card#2⟭  ⟬us_ssn#2⟭  ⟬company#1⟭      129.90\n",
       "1  ⟬person_name#3⟭  ⟬payment_card#3⟭  ⟬us_ssn#3⟭  ⟬company#1⟭       64.00\n",
       "2  ⟬person_name#3⟭  ⟬payment_card#3⟭  ⟬us_ssn#3⟭  ⟬company#1⟭       64.00\n",
       "3  ⟬person_name#4⟭  ⟬payment_card#4⟭  ⟬us_ssn#4⟭  ⟬company#2⟭      310.45"
      ]
     },
     "execution_count": 2,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "df = pd.read_sql(\"SELECT * FROM RISK.CHARGEBACKS_US WHERE reason_code = '13.1' AND opened_at >= '2024-07-01'\", conn)\n",
    "df[[\"cardholder\", \"pan\", \"ssn\", \"merchant\", \"amount_usd\"]].head(4)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "### Remarques\n",
    "\n",
    "- ⟬person_name#3m⟭ apparaît deux fois pour le même montant le même jour : double soumission côté acquéreur, ou il conteste deux fois ?\n",
    "- ⟬company#1⟭ concentre 41 % des litiges 13.1 de la période.\n",
    "- Demander à ⟬person_name:given#5⟭ (équipe disputes) si on peut récupérer le texte libre du porteur."
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
       "                       count      sum\n",
       "merchant                             \n",
       "⟬company#1⟭              87  9412.30\n",
       "⟬company#2⟭              31  5120.75\n",
       "⟬company#3⟭              12   980.00"
      ]
     },
     "execution_count": 3,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "(df.groupby(\"merchant\")[\"amount_usd\"]\n",
    "   .agg([\"count\", \"sum\"])\n",
    "   .sort_values(\"count\", ascending=False)\n",
    "   .head(3))"
   ]
  }
 ],
 "metadata": {
  "kernelspec": {"display_name": "Python 3 (risk)", "language": "python", "name": "risk"},
  "language_info": {"name": "python", "version": "3.10.13"}
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
⟬end⟭

⟬template⟭
family: code
format: .ts
language: mixed
fill_locale: fr_FR
domain: logistics
appearance: object literal, array literal, string literal, comment
scenario: mock data module for the Storybook stories and offline demo of a courier mobile app, English code with French delivery instructions, built from a pilot route and the shared demo login
⟬text⟭
// Mock data for Storybook and the offline demo mode of the courier app.
// Built from the Lyon pilot route (week 12). Instructions stay in French on purpose:
// the courier UI shows them verbatim.
import type { CourierSession, Delivery } from "../types";

export const demoSession: CourierSession = {
  username: "⟬username#1⟭",
  password: "⟬password#1⟭", // shared demo account, also on the sticky note in the van
  depot: "⟬city#1⟭",
  tiles: { url: "https://⟬hostname#1⟭/tiles/{z}/{x}/{y}.png", k: "⟬opaque_token#1⟭" },
};

export const deliveries: Delivery[] = [
  {
    id: "⟬order_number#1⟭",
    recipient: "⟬person_name#2⟭",
    phone: "⟬phone#2⟭",
    address: "⟬fr_postal_address#2⟭",
    window: { from: "08:00", to: "10:00" },
    instructions: "Code porte 4512B, 3e étage gauche. Si absent laisser chez ⟬person_name#3⟭ au rez-de-chaussée",
    parcels: 2,
  },
  {
    id: "⟬order_number#2⟭",
    recipient: "⟬company#4⟭",
    phone: "⟬phone#4⟭",
    address: "⟬fr_postal_address#4⟭",
    window: { from: "09:00", to: "12:00" },
    instructions: "Livraison à l'accueil, demander ⟬person_name:given#5⟭ (service achats)",
    parcels: 6,
  },
  {
    id: "⟬order_number#3⟭",
    recipient: "⟬person_name#6⟭",
    phone: "⟬phone#6⟭",
    address: "⟬fr_postal_address#6⟭",
    window: { from: "14:00", to: "18:00" },
    instructions: "",
    parcels: 1,
    failedAttempts: [{ at: "⟬date#1⟭", reason: "absent, avis de passage déposé" }],
  },
];
⟬end⟭

⟬template⟭
family: code
format: .py
language: mixed
fill_locale: fr_FR
domain: healthcare
appearance: test fixture, string literal, assertion, URL, constant, comment
scenario: pytest module for the HL7 v2 to FHIR converter of a French hospital group's integration platform, English code with an ADT message fixture carrying a French patient's NIR, birth date and address
⟬text⟭
"""Tests for the ADT^A04 -> FHIR Patient/Encounter converter.

The sample message is a cleaned copy of what the admissions software of the
pilot site sends (HL7 v2.5, French INS profile). PID-3 carries both the local
IPP and the INS-NIR; we only keep the latter when its OID matches.
"""
import os

import pytest

from hl7fhir.converter import convert_adt
from hl7fhir.store import FhirStore

⟬trap:indicator_non_pii|NIR_SYSTEM = "urn:oid:1.2.250.1.213.1.4.8"⟭
IPP_SYSTEM = "urn:oid:1.2.250.1.71.4.2.7"
TEST_DB = os.getenv("FHIR_TEST_DB", "postgresql://fhir:⟬url_password#1⟭@localhost:5433/fhir_test")

# Mme ⟬person_name#1f⟭, admitted through the ER; the attending physician is in PV1-7.
ADT_A04 = "\r".join([
    "MSH|^~\\&|ADMISSIONS|HOPITAL_NORD|EAI|GHT|20240611093012||ADT^A04^ADT_A01|MSG00042|P|2.5|||||FRA|8859/1",
    "EVN|A04|20240611093000",
    "PID|1||⟬customer_id#1⟭^^^HOPITAL_NORD^PI~⟬fr_social_security_number#1⟭^^^ASIP-SANTE-INS-NIR&1.2.250.1.213.1.4.8&ISO^NH||⟬person_name:family#1⟭^⟬person_name:given#1⟭^^^^^L||⟬birth_date#1⟭|F|||⟬fr_postal_address:street#1⟭^^⟬city#1⟭^^⟬postcode#1⟭^FRA^H||⟬phone#1⟭^PRN^CP",
    "PV1|1|E|URG^BOX3^^HOPITAL_NORD||||^⟬person_name:family#2⟭^⟬person_name:given#2⟭^^^Dr|||||||||||V2406110042",
])


@pytest.fixture(scope="module")
def store():
    s = FhirStore(TEST_DB)
    s.reset()
    yield s
    s.close()


@pytest.fixture
def bundle():
    return convert_adt(ADT_A04)


def _resource(bundle, kind):
    return next(e["resource"] for e in bundle["entry"] if e["resource"]["resourceType"] == kind)


def test_ins_nir_is_kept_with_its_oid(bundle):
    identifiers = {i["system"]: i["value"] for i in _resource(bundle, "Patient")["identifier"]}
    assert identifiers[NIR_SYSTEM] == "⟬fr_social_security_number#1⟭"
    assert identifiers[IPP_SYSTEM] == "⟬customer_id#1⟭"


def test_name_and_birth_date(bundle):
    patient = _resource(bundle, "Patient")
    assert patient["name"][0] == {"use": "official", "family": "⟬person_name:family#1⟭", "given": ["⟬person_name:given#1⟭"]}
    assert patient["birthDate"] == "⟬birth_date#1⟭"
    assert patient["gender"] == "female"


def test_home_address_is_split(bundle):
    address = _resource(bundle, "Patient")["address"][0]
    assert address["line"] == ["⟬fr_postal_address:street#1⟭"]
    assert address["city"] == "⟬city#1⟭"
    assert address["postalCode"] == "⟬postcode#1⟭"
    assert address["country"] == "FRA"


def test_mobile_phone_goes_to_telecom(bundle):
    telecom = _resource(bundle, "Patient")["telecom"]
    assert {"system": "phone", "use": "mobile", "value": "⟬phone#1⟭"} in telecom


def test_attending_physician_becomes_participant(bundle):
    encounter = _resource(bundle, "Encounter")
    assert encounter["participant"][0]["individual"]["display"] == "Dr ⟬person_name#2⟭"
    assert encounter["class"]["code"] == "EMER"


def test_round_trip_through_the_store(store, bundle):
    store.save(bundle)
    found = store.search("Patient", identifier=f"{NIR_SYSTEM}|⟬fr_social_security_number#1⟭")
    assert len(found) == 1


@pytest.mark.parametrize("segment", ["PID", "PV1"])
def test_missing_segment_is_reported(segment):
    broken = "\r".join(s for s in ADT_A04.split("\r") if not s.startswith(segment))
    with pytest.raises(ValueError, match=segment):
        convert_adt(broken)
⟬end⟭

⟬template⟭
family: code
format: .java
language: mixed
fill_locale: fr_FR
domain: HR
appearance: JDBC URL, constructor argument, setter call, comment
scenario: Spring Boot dev-profile seeder in the English codebase of a French HR portal, with the shared dev database password in the JDBC URL and a demo employee created at startup
⟬text⟭
@Configuration
@Profile("dev")
public class DevDataSeeder {

    // shared dev DB on the office NAS; password in the URL because the old pool ignored the property
    static final String JDBC_URL = "jdbc:postgresql://⟬hostname#1⟭:5432/portail_rh?user=rh_dev&password=⟬url_password#1⟭";

    @Bean
    CommandLineRunner seedDemoEmployee(EmployeRepository employes, PasswordEncoder encoder) {
        return args -> {
            if (employes.count() > 0) return;
            Employe demo = new Employe("⟬person_name:family#1⟭", "⟬person_name:given#1⟭");
            demo.setNumeroSecu("⟬fr_social_security_number#1⟭");
            demo.setEmail("⟬email#1⟭");
            demo.setMotDePasse(encoder.encode("⟬password#1⟭"));
            employes.save(demo);
        };
    }
}
⟬end⟭

⟬template⟭
family: code
format: .sql
language: mixed
fill_locale: mixed
domain: banking
appearance: SQL INSERT, block comment, comment, SQL query
scenario: one-shot migration merging the French and US customer ledgers of a cross-border payments startup after an acquisition, English comments with the Paris ops team's French notes kept verbatim and edge-case rows used as post-merge checks
⟬text⟭
/*
 * 2024_11_merge_ledgers.sql
 * Merge legacy_fr.clients and legacy_us.customers into core.account_holder.
 * Run once, in a maintenance window, by the on-call DBA. Expected runtime ~6 min.
 * Notes from the Paris ops team are kept in French where they explain a rule.
 */
BEGIN;

-- FR : l'IBAN est la clé de rapprochement, pas l'email (beaucoup de comptes joints
-- et d'adresses partagées entre conjoints).
INSERT INTO core.account_holder (source, legacy_id, full_name, birth_date, national_id, iban, address_line, country)
SELECT 'FR', c.id, c.prenom || ' ' || c.nom, c.date_naissance, NULL, c.iban, c.adresse, 'FR'
FROM legacy_fr.clients c
WHERE c.statut <> 'cloture';

-- US: the SSN goes to national_id; trg_encrypt_national_id encrypts it on insert.
INSERT INTO core.account_holder (source, legacy_id, full_name, birth_date, national_id, iban, address_line, country)
SELECT 'US', u.id, u.first_name || ' ' || u.last_name, u.dob, u.ssn, NULL, u.street || ', ' || u.city || ' ' || u.zip, 'US'
FROM legacy_us.customers u
WHERE u.closed_at IS NULL;

/*
 * Edge cases from the QA export of ⟬date#1⟭. Each row must match an account holder
 * after the merge, otherwise the DO block below raises and the transaction rolls back.
 */
CREATE TEMP TABLE merge_check (legacy_id text, field text, expected text) ON COMMIT DROP;

INSERT INTO merge_check VALUES
  ('FR-77812', 'iban', '⟬iban#1⟭'),                       -- compte joint, deux titulaires
  ('FR-77812', 'full_name', '⟬person_name#1⟭'),
  ('FR-77813', 'full_name', '⟬person_name#2⟭'),
  ('FR-77813', 'iban', '⟬iban#1⟭'),
  ('FR-80113', 'address_line', '⟬fr_postal_address#3⟭'),  -- adresse avec "bis", mal parsée en 2022
  ('FR-80113', 'birth_date', '⟬birth_date#3⟭'),
  ('US-30451', 'national_id', '⟬us_ssn#4⟭'),
  ('US-30451', 'full_name', '⟬person_name#4⟭'),
  ('US-30992', 'full_name', '⟬person_name#5⟭'),           -- name changed after marriage, old one in aliases
  ('US-30992', 'birth_date', '⟬birth_date#5⟭'),
  ('US-31877', 'address_line', '⟬postal_address#6⟭');

DO $$
DECLARE
  missing int;
BEGIN
  SELECT count(*) INTO missing
  FROM merge_check m
  WHERE NOT EXISTS (
    SELECT 1 FROM core.account_holder a
    WHERE a.legacy_id = m.legacy_id
      AND CASE m.field
            WHEN 'iban' THEN a.iban
            WHEN 'full_name' THEN a.full_name
            WHEN 'address_line' THEN a.address_line
            WHEN 'birth_date' THEN a.birth_date::text
            WHEN 'national_id' THEN pgp_sym_decrypt(a.national_id, current_setting('app.kms_key'))
          END = m.expected
  );
  IF missing > 0 THEN
    RAISE EXCEPTION 'merge check failed: % edge case(s) do not match', missing;
  END IF;
END $$;

COMMIT;
⟬end⟭

⟬template⟭
family: code
format: .py
language: mixed
fill_locale: fr_FR
domain: logistics
appearance: docstring, comment, import, function call, constant
scenario: route-planning module of a French last-mile delivery startup, English identifiers under the original author's French comments, using Dijkstra on the depot road graph and OR-Tools for vehicle routing with time windows
⟬text⟭
"""Planification des tournées : graphe routier du dépôt + VRP avec fenêtres horaires.

Interface:
    build_graph(edges) -> nx.DiGraph
    distance_matrix(graph, stops) -> list[list[int]]
    plan_routes(matrix, demands, windows, vehicles) -> list[list[int]]
"""
import ⟬trap:library|networkx⟭ as nx
from ortools.constraint_solver import pywrapcp, routing_enums_pb2

DEPOT_CITY = "⟬city#1⟭"
SOLVER_VERSION = "⟬version#1⟭"
# vitesse moyenne en ville, mesurée sur les traces GPS de janvier (km/h)
URBAN_SPEED_KMH = 18
MAX_STOPS_PER_ROUTE = 45
⟬trap:indicator_non_pii|DEFAULT_DRIVER = "unassigned"⟭


def build_graph(edges):
    """Graphe orienté : les sens interdits du centre-ville comptent."""
    graph = nx.DiGraph()
    for start, end, metres in edges:
        graph.add_edge(start, end, weight=metres)
    return graph


def distance_matrix(graph, stops):
    # ⟬trap:eponym|Dijkstra⟭ depuis chaque arrêt : O(n * E log V), ça passe pour 45 arrêts.
    # Si on monte à 200 arrêts, passer sur ⟬trap:eponym|Floyd-Warshall⟭ en numpy.
    matrix = []
    for origin in stops:
        lengths = nx.⟬trap:code_identifier|single_source_dijkstra_path_length⟭(graph, origin, weight="weight")
        matrix.append([int(lengths.get(target, 10**9)) for target in stops])
    return matrix


def plan_routes(matrix, demands, windows, vehicles, capacity=120):
    """Retourne une liste de tournées (indices d'arrêts), dépôt = indice 0.

    windows : (début, fin) en minutes depuis l'ouverture du dépôt.
    """
    manager = pywrapcp.RoutingIndexManager(len(matrix), vehicles, 0)
    routing = pywrapcp.RoutingModel(manager)

    def travel(i, j):
        return matrix[manager.IndexToNode(i)][manager.IndexToNode(j)] * 60 // (URBAN_SPEED_KMH * 1000)

    transit = routing.RegisterTransitCallback(travel)
    routing.SetArcCostEvaluatorOfAllVehicles(transit)
    routing.AddDimension(transit, 30, 600, False, "Time")
    time_dim = routing.GetDimensionOrDie("Time")
    for node, (start, end) in enumerate(windows):
        time_dim.CumulVar(manager.NodeToIndex(node)).SetRange(start, end)

    demand_cb = routing.RegisterUnaryTransitCallback(lambda i: demands[manager.IndexToNode(i)])
    routing.AddDimensionWithVehicleCapacity(demand_cb, 0, [capacity] * vehicles, True, "Load")

    params = pywrapcp.DefaultRoutingSearchParameters()
    # PATH_CHEAPEST_ARC donne de meilleures tournées que SAVINGS (⟬trap:eponym|Clarke-Wright⟭) sur nos données
    params.first_solution_strategy = routing_enums_pb2.FirstSolutionStrategy.PATH_CHEAPEST_ARC
    params.time_limit.seconds = 20
    solution = routing.SolveWithParameters(params)
    if solution is None:
        return []
    routes = []
    for vehicle in range(vehicles):
        index, route = routing.Start(vehicle), []
        while not routing.IsEnd(index):
            route.append(manager.IndexToNode(index))
            index = solution.Value(routing.NextVar(index))
        routes.append(route)
    return routes
⟬end⟭

⟬template⟭
family: code
format: .ts
language: mixed
fill_locale: fr_FR
domain: SaaS
appearance: comment, schema default, object literal, import, placeholder
scenario: typed configuration loader of a French SaaS company's release bot, French comments over English keys, reading every secret from the environment and documenting the expected variables with placeholders
⟬text⟭
// Configuration du bot de release (GitLab -> Slack -> changelog public).
// Aucun secret ici : Vault injecte les variables au démarrage du pod.
// Exemple de .env local (ne jamais committer le vrai) :
//   GITLAB_TOKEN=⟬trap:placeholder|<votre-jeton-personnel>⟭
//   SLACK_BOT_TOKEN=⟬trap:placeholder|xoxb-...⟭
//   SIGNING_SECRET=⟬trap:placeholder|${SLACK_SIGNING_SECRET}⟭
import { Gitlab } from "⟬trap:email_lookalike|@gitbeaker/rest⟭";
import { z } from "zod";

const Env = z.object({
  GITLAB_URL: z.string().url().default("https://⟬hostname#1⟭"),
  GITLAB_TOKEN: z.string().min(20, "GITLAB_TOKEN manquant ou tronqué"),
  GITLAB_PROJECT_ID: z.coerce.number().int().positive(),
  SLACK_BOT_TOKEN: z.string().startsWith("xoxb-"),
  SIGNING_SECRET: z.string().min(32),
  RELEASE_CHANNEL: z.string().default("#releases"),
  CHANGELOG_URL: z.string().url().default("⟬url#1⟭"),
  DRY_RUN: z.coerce.boolean().default(false),
});

export type BotConfig = z.infer<typeof Env> & {
  apiKeyHeader: string;
  tokenTtlSeconds: number;
};

export function loadConfig(env: NodeJS.ProcessEnv = process.env): BotConfig {
  const parsed = Env.safeParse(env);
  if (!parsed.success) {
    // on liste les clés fautives sans jamais afficher leur valeur
    const keys = parsed.error.issues.map((issue) => issue.path.join("."));
    throw new Error(`Configuration invalide : ${keys.join(", ")}`);
  }
  return {
    ...parsed.data,
    ⟬trap:indicator_non_pii|apiKeyHeader: "PRIVATE-TOKEN"⟭,
    ⟬trap:indicator_non_pii|tokenTtlSeconds: 3600⟭,
  };
}

export function gitlabClient(config: BotConfig) {
  return new Gitlab({ host: config.GITLAB_URL, token: config.GITLAB_TOKEN });
}
⟬end⟭

⟬template⟭
family: code
format: .sql
language: mixed
fill_locale: fr_FR
domain: e-commerce
appearance: column comment, comment, SQL INSERT, function, placeholder
scenario: Flyway migration adding GDPR retention metadata to the customers table of a French online wine shop, English comments by the backend lead and French column comments written for the DPO
⟬text⟭
-- V42__customer_retention.sql
-- Retention metadata requested by the DPO (⟬ticket_id#1⟭, decided ⟬date#1⟭).
-- Column comments are in French: the DPO reads them straight from the data catalogue.

ALTER TABLE customers
  ADD COLUMN last_order_at timestamptz,
  ADD COLUMN anonymised_at timestamptz,
  ADD COLUMN retention_class text NOT NULL DEFAULT 'standard';

COMMENT ON COLUMN customers.email IS 'Adresse de contact, supprimée à l''anonymisation';
COMMENT ON COLUMN customers.iban IS 'IBAN de remboursement, chiffré (pgcrypto), purgé 13 mois après la dernière commande';
COMMENT ON COLUMN customers.date_naissance IS 'Facultative, demandée uniquement pour vérifier la majorité (vente d''alcool)';
COMMENT ON COLUMN customers.retention_class IS 'standard = 3 ans après la dernière commande, litige = 5 ans';

INSERT INTO app_setting (key, value) VALUES
  ('retention.standard_months', '36'),
  ('retention.litige_months', '60'),
  ⟬trap:indicator_non_pii|('retention.iban_months', '13')⟭,
  ⟬trap:indicator_non_pii|('dob.required_for_category', 'vins_spiritueux')⟭;

-- Called by the nightly job. Orders are kept for accounting (a ⟬trap:word_name|Margaux⟭ 2015
-- bought in 2019 still shows up in the ledger), only the person is stripped.
CREATE OR REPLACE FUNCTION anonymise_customer(p_id bigint) RETURNS void
LANGUAGE plpgsql AS $$
BEGIN
  UPDATE customers
     SET nom = '⟬trap:placeholder|ANONYME⟭',
         prenom = NULL,
         email = NULL,
         telephone = NULL,
         iban = NULL,
         date_naissance = NULL,
         adresse_livraison = NULL,
         anonymised_at = now()
   WHERE id = p_id AND anonymised_at IS NULL;
  DELETE FROM customer_session WHERE customer_id = p_id;
END;
$$;

CREATE INDEX IF NOT EXISTS customers_last_order_idx ON customers (last_order_at) WHERE anonymised_at IS NULL;
⟬end⟭

⟬template⟭
family: code
format: .java
language: mixed
fill_locale: fr_FR
domain: healthcare
appearance: Javadoc, constant, exception message, placeholder
scenario: validator for French social security numbers in the English Java codebase of a health-insurance claims platform, returning French messages that the member portal shows as they are
⟬text⟭
package eu.claimsflow.member.validation;

import java.util.Optional;
import java.util.regex.Pattern;

/**
 * Validates a French social security number (NIR) typed by a member.
 *
 * <p>Shape: 13 characters + 2-digit key, key = 97 - (number mod 97). Corsica uses 2A/2B in the
 * department field; they become 19 / 18 before the modulo. Spaces are tolerated because members
 * copy the number from their carte Vitale, which prints it in groups, e.g.
 * {@code ⟬trap:placeholder|X XX XX XX XXX XXX XX⟭}.
 *
 * <p>Messages are in French: the member portal shows them as they are.
 */
public final class NirValidator {

    ⟬trap:indicator_non_pii|private static final int NIR_LENGTH = 15⟭;
    private static final Pattern SHAPE =
            Pattern.compile("^[12][0-9]{2}(0[1-9]|1[0-2]|[2-9][0-9])(2A|2B|[0-9]{2})[0-9]{6}[0-9]{2}$");

    public Optional<String> problem(String raw) {
        if (raw == null || raw.isBlank()) {
            return Optional.of("Le numéro de sécurité sociale est obligatoire.");
        }
        String nir = raw.replace(" ", "").toUpperCase();
        if (nir.length() != NIR_LENGTH) {
            return Optional.of("Le numéro doit comporter 15 caractères, clé comprise.");
        }
        if (!SHAPE.matcher(nir).matches()) {
            return Optional.of("Format non reconnu : vérifiez le numéro sur votre carte Vitale.");
        }
        long body = Long.parseLong(nir.substring(0, 13).replace("2A", "19").replace("2B", "18"));
        int key = Integer.parseInt(nir.substring(13));
        if (97 - (body % 97) != key) {
            return Optional.of("Clé incorrecte : le numéro semble mal recopié.");
        }
        return Optional.empty();
    }

    public boolean isValid(String raw) {
        return problem(raw).isEmpty();
    }
}
⟬end⟭

⟬template⟭
family: code
format: .ipynb
language: mixed
fill_locale: en_GB
domain: HR
appearance: markdown cell, notebook output, dict literal, stream output
scenario: French HR analyst's notebook on the aggregated results of the English-language engagement survey of the UK subsidiary, which only ever receives team-level figures
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Enquête d'engagement de la filiale UK : résultats agrégés\n",
    "\n",
    "Export de l'outil d'enquête fourni par ⟬company#1⟭ (site de ⟬city#1⟭), questions en anglais.\n",
    "On ne reçoit que des agrégats par équipe ; l'outil masque déjà les équipes de moins de 5 répondants, on refiltre quand même."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "metadata": {},
   "outputs": [],
   "source": [
    "import ⟬trap:library|pandas⟭ as pd\n",
    "\n",
    "MIN_GROUP = 5\n",
    "report_meta = {\"owner\": \"⟬trap:indicator_non_pii|people-analytics⟭\", \"wave\": \"⟬date#2⟭\"}\n",
    "agg = pd.read_csv(\"⟬file_path#1⟭\")\n",
    "agg = agg[agg[\"n_respondents\"] >= MIN_GROUP]"
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
       "question_id        Q1    Q2    Q3    Q7    Q9\n",
       "team                                         \n",
       "Customer Care    3.81  3.95  3.40  2.97  3.62\n",
       "Finance          4.10  4.02  3.88  3.71  3.90\n",
       "IT               3.92  4.15  3.77  3.55  3.48\n",
       "Warehouse Ops    3.35  3.60  3.12  3.08  3.30"
      ]
     },
     "execution_count": 2,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "scores = agg.pivot_table(index=\"team\", columns=\"question_id\", values=\"mean_score\").round(2)\n",
    "scores[[\"Q1\", \"Q2\", \"Q3\", \"Q7\", \"Q9\"]]"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "**Lecture.** Q7 (*I know who to talk to about my workload*) est la plus basse partout, surtout en Customer Care.\n",
    "Warehouse Ops reste sous 3,4 sur toutes les questions : à croiser avec le turnover du T2 avant le comité du ⟬date#1⟭."
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
      "team\n",
      "Customer Care    73%\n",
      "Finance          88%\n",
      "IT               64%\n",
      "Warehouse Ops    41%\n"
     ]
    }
   ],
   "source": [
    "headcount = pd.Series({\"Customer Care\": 48, \"Finance\": 17, \"IT\": 22, \"Warehouse Ops\": 96})\n",
    "rates = agg.groupby(\"team\")[\"n_respondents\"].max() / headcount\n",
    "print(rates.map(\"{:.0%}\".format).to_string())"
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
