⟬template⟭
family: code
format: .ipynb
language: mixed
fill_locale: fr_FR
domain: HR
appearance: markdown cell, keyword argument, notebook output, import, prose
scenario: payroll data engineer's notebook with English markdown checking the monthly DSN extract against the HRIS before filing, listing employees whose NIR is missing on one side
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "## DSN pre-filing check\n",
    "\n",
    "Payroll period of ⟬date#2⟭. The monthly DSN extract (`dsn_mensuelle_*.csv`) comes from the payroll engine; the HRIS table `salaries` is the reference for identities. A NIR missing on either side blocks the filing on net-entreprises, so we list the gaps and hand them to payroll before the 5th."
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
       "(1187, 1192)"
      ]
     },
     "execution_count": 1,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "import pandas as pd\n",
    "import psycopg2\n",
    "from rapidfuzz.distance import ⟬trap:eponym|Levenshtein⟭\n",
    "\n",
    "conn = psycopg2.connect(host=\"⟬hostname#1⟭\", dbname=\"sirh\", user=\"paie_ro\", password=\"⟬password#1⟭\")\n",
    "dsn = pd.read_csv(\"⟬file_path#1⟭\", sep=\";\", dtype=str)\n",
    "sirh = pd.read_sql(\"SELECT matricule, nir, nom_usage, prenom, date_naissance FROM salaries WHERE actif\", conn)\n",
    "len(dsn), len(sirh)"
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
       "    matricule  nom_usage  prenom  date_naissance  nir_sirh  nir_dsn\n",
       "14      A0417  ⟬person_name:family#2⟭  ⟬person_name:given#2⟭  ⟬birth_date#2⟭  ⟬fr_social_security_number#2⟭  NaN\n",
       "211     B1132  ⟬person_name:family#3⟭  ⟬person_name:given#3⟭  ⟬birth_date#3⟭  ⟬fr_social_security_number#3⟭  NaN\n",
       "958     C0058  ⟬person_name:family#4⟭  ⟬person_name:given#4⟭  ⟬birth_date#4⟭  NaN  ⟬fr_social_security_number#4⟭"
      ]
     },
     "execution_count": 2,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "m = sirh.merge(dsn[[\"matricule\", \"nir\"]], on=\"matricule\", how=\"outer\", suffixes=(\"_sirh\", \"_dsn\"), indicator=True)\n",
    "gaps = m[m[\"nir_sirh\"].isna() | m[\"nir_dsn\"].isna()]\n",
    "gaps[[\"matricule\", \"nom_usage\", \"prenom\", \"date_naissance\", \"nir_sirh\", \"nir_dsn\"]]"
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
       "Empty DataFrame\n",
       "Columns: [matricule, best_match, score]\n",
       "Index: []"
      ]
     },
     "execution_count": 3,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "# matricules present only in the DSN: payroll sometimes re-creates a rehire under a new matricule\n",
    "orphans = m[m[\"_merge\"] == \"right_only\"].merge(dsn[[\"matricule\", \"nom\"]], on=\"matricule\")\n",
    "def closest(nom):\n",
    "    scores = sirh[\"nom_usage\"].map(lambda s: ⟬trap:eponym|Levenshtein⟭.normalized_similarity(s.upper(), nom.upper()))\n",
    "    return sirh.loc[scores.idxmax(), \"matricule\"], round(scores.max(), 2)\n",
    "orphans[[\"best_match\", \"score\"]] = orphans[\"nom\"].map(closest).tolist() if len(orphans) else [[], []]\n",
    "orphans[[\"matricule\", \"best_match\", \"score\"]]"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "No orphans this month. The three rows above went to ⟬person_name#5⟭ in payroll on ⟬date#1⟭: C0058 is a rehire whose NIR was never copied back into the HRIS, the other two are new hires still waiting for their carte Vitale."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 4,
   "metadata": {},
   "outputs": [],
   "source": [
    "gaps.drop(columns=\"_merge\").to_excel(\"⟬file_path#2⟭\", index=False)"
   ]
  }
 ],
 "metadata": {
  "kernelspec": {"display_name": "Python 3 (paie)", "language": "python", "name": "paie"},
  "language_info": {"name": "python", "version": "3.11.9"}
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
⟬end⟭

⟬template⟭
family: code
format: .ipynb
language: mixed
fill_locale: mixed
domain: SaaS
appearance: markdown cell, HTTP header, string literal, notebook output, set literal, prose
scenario: engineering manager's notebook in French measuring merge-request lead time per author for the Paris and Austin teams of a SaaS API, pulling from GitLab with a personal token pasted in a cell
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Lead time des MR, équipe API (Paris + Austin)\n",
    "\n",
    "Demande du comité produit : délai entre l'ouverture d'une MR et son premier déploiement en production, par auteur, sur le T3. Source : API GitLab, projet `platform/api`, environnement `production`."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "metadata": {},
   "outputs": [],
   "source": [
    "import requests\n",
    "import pandas as pd\n",
    "from scipy.stats import mannwhitneyu\n",
    "\n",
    "GITLAB = \"https://⟬hostname#1⟭/api/v4\"\n",
    "PROJECT = \"platform%2Fapi\"\n",
    "# mon token perso, scope read_api, révoqué après la démo (promis)\n",
    "HEADERS = {\"PRIVATE-TOKEN\": \"⟬gitlab_token#1⟭\"}"
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
      "412 MR fusionnées, 388 rattachées à un déploiement prod\n"
     ]
    }
   ],
   "source": [
    "def pages(url, **params):\n",
    "    params[\"per_page\"] = 100\n",
    "    while url:\n",
    "        r = requests.get(url, headers=HEADERS, params=params, timeout=30)\n",
    "        r.raise_for_status()\n",
    "        yield from r.json()\n",
    "        url, params = r.links.get(\"next\", {}).get(\"url\"), {}\n",
    "\n",
    "mrs = pd.json_normalize(list(pages(f\"{GITLAB}/projects/{PROJECT}/merge_requests\", state=\"merged\", updated_after=\"2024-07-01\")))\n",
    "deps = pd.json_normalize(list(pages(f\"{GITLAB}/projects/{PROJECT}/deployments\", environment=\"production\", status=\"success\")))\n",
    "first_dep = deps.groupby(\"sha\")[\"created_at\"].min()\n",
    "mrs[\"deployed_at\"] = mrs[\"merge_commit_sha\"].map(first_dep)\n",
    "print(f\"{len(mrs)} MR fusionnées, {mrs['deployed_at'].notna().sum()} rattachées à un déploiement prod\")"
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
       "                 mr  median_h  p90_h\n",
       "author.name                         \n",
       "⟬trap:indicator_non_pii|renovate[bot]⟭      96       2.3    6.1\n",
       "⟬person_name#2⟭      58      14.2   41.0\n",
       "⟬person_name#3⟭      47      19.8   66.5\n",
       "⟬person_name#4⟭      39      22.1  130.4\n",
       "⟬person_name#5⟭      31      16.7   48.9"
      ]
     },
     "execution_count": 3,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "mrs[\"lead_h\"] = (pd.to_datetime(mrs[\"deployed_at\"]) - pd.to_datetime(mrs[\"created_at\"])).dt.total_seconds() / 3600\n",
    "by_author = mrs.groupby(\"author.name\")[\"lead_h\"].agg(mr=\"count\", median_h=\"median\", p90_h=lambda s: s.quantile(0.9))\n",
    "by_author.sort_values(\"mr\", ascending=False).round(1)"
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
       "MannwhitneyuResult(statistic=17204.5, pvalue=0.4112)"
      ]
     },
     "execution_count": 4,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "EQUIPE_PARIS = {\"⟬person_name:handle#2⟭\", \"⟬person_name:handle#4⟭\"}\n",
    "humans = mrs[~mrs[\"author.username\"].str.endswith(\"[bot]\")]\n",
    "team = humans[\"author.username\"].map(lambda u: \"paris\" if u in EQUIPE_PARIS else \"austin\")\n",
    "mannwhitneyu(humans.loc[team == \"paris\", \"lead_h\"].dropna(), humans.loc[team == \"austin\", \"lead_h\"].dropna())"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Pas de différence Paris / Austin (test de ⟬trap:eponym|Mann-Whitney⟭, p = 0,41). Le p90 de ⟬person_name:given#4⟭ vient des migrations de schéma qui attendent la revue DBA (⟬ticket_id#1⟭). Sans les MR du bot, la médiane passe à 17 h. À présenter avec ⟬person_name#6⟭ jeudi."
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
format: .java
language: mixed
fill_locale: fr_FR
domain: healthcare
appearance: Javadoc, text block, constant, comment
scenario: Spring Security SAML configuration an integrator wrote in English with French comments for the staff portal of a French hospital group, the service provider's signing key kept in a text block until the vault ticket is done
⟬text⟭
package org.ghtsud.portail.security;

import java.security.KeyFactory;
import java.security.PrivateKey;
import java.security.cert.CertificateFactory;
import java.security.cert.X509Certificate;
import java.security.spec.PKCS8EncodedKeySpec;
import java.util.Base64;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.saml2.core.Saml2X509Credential;
import org.springframework.security.saml2.provider.service.registration.InMemoryRelyingPartyRegistrationRepository;
import org.springframework.security.saml2.provider.service.registration.RelyingPartyRegistration;
import org.springframework.security.saml2.provider.service.registration.RelyingPartyRegistrationRepository;
import org.springframework.security.saml2.provider.service.registration.RelyingPartyRegistrations;

/**
 * SAML 2.0 service provider for the staff portal (agents hospitaliers, internes, intérimaires).
 *
 * <p>The identity provider is the group's ADFS, run by the infrastructure team.
 * IdP contact for certificate rollovers: ⟬person_name#1⟭ (⟬email#1⟭, ⟬phone#1⟭).
 * Last metadata exchange: ⟬date#1⟭.
 */
@Configuration
public class SamlConfig {

    private static final String REGISTRATION_ID = "adfs-ght";
    private static final String IDP_METADATA =
            "https://⟬hostname#2⟭/FederationMetadata/2007-06/FederationMetadata.xml";

    // Clé de signature du SP générée pour la recette. Elle doit partir dans le coffre (⟬ticket_id#1⟭) ;
    // en attendant elle reste ici, sinon le build de recette ne démarre pas.
    private static final String SP_SIGNING_KEY = """
            ⟬private_key#2⟭
            """;

    // ⟬trap:indicator_non_pii|user=svc-adfs-portail⟭ dans les logs ADFS : c'est le compte de service, pas un agent

    @Bean
    RelyingPartyRegistrationRepository relyingPartyRegistrations() throws Exception {
        RelyingPartyRegistration registration = RelyingPartyRegistrations
                .fromMetadataLocation(IDP_METADATA)
                .registrationId(REGISTRATION_ID)
                .entityId("https://⟬hostname#3⟭/saml2/service-provider-metadata/" + REGISTRATION_ID)
                .signingX509Credentials(c -> c.add(Saml2X509Credential.signing(privateKey(), certificate())))
                .build();
        return new InMemoryRelyingPartyRegistrationRepository(registration);
    }

    private static PrivateKey privateKey() throws Exception {
        String body = SP_SIGNING_KEY
                .replaceAll("-----(BEGIN|END) [A-Z ]*PRIVATE KEY-----", "")
                .replaceAll("\\s", "");
        byte[] der = Base64.getDecoder().decode(body);
        return KeyFactory.getInstance("RSA").generatePrivate(new PKCS8EncodedKeySpec(der));
    }

    private static X509Certificate certificate() throws Exception {
        // le certificat public, lui, peut rester dans le classpath
        try (var in = SamlConfig.class.getResourceAsStream("/saml/sp-signing.crt")) {
            return (X509Certificate) CertificateFactory.getInstance("X.509").generateCertificate(in);
        }
    }
}
⟬end⟭

⟬template⟭
family: code
format: .ts
language: mixed
fill_locale: fr_FR
domain: healthcare
appearance: object literal, test fixture, string literal, assertion, comment
scenario: Vitest suite in English for the NIR helpers of a French telehealth booking app, fed with the booking provider's sandbox patient so that the control-key check really runs
⟬text⟭
import { describe, expect, it } from 'vitest';
import { formatNir, isValidNir, nirError, nirMatchesIdentity } from '../src/identity/nir';

// Sandbox patient from the booking provider. Their QA keeps the control key valid,
// so these tests fail if someone "simplifies" the key check again.
const patient = {
  nom: '⟬person_name:family#1f⟭',
  prenom: '⟬person_name:given#1⟭',
  dateNaissance: '⟬birth_date#1⟭',
  nir: '⟬fr_social_security_number#1⟭',
};

const compact = (s: string) => s.replace(/\s+/g, '');

describe('isValidNir', () => {
  it('accepts the sandbox patient', () => {
    expect(isValidNir(compact(patient.nir))).toBe(true);
  });

  it('rejects a wrong control key', () => {
    const bad = compact(patient.nir).slice(0, 13) + '00';
    expect(isValidNir(bad)).toBe(false);
  });

  it('does not throw on Corsican departments', () => {
    expect(() => isValidNir('2A')).not.toThrow();
  });
});

describe('formatNir', () => {
  it('groups digits like the carte Vitale', () => {
    expect(formatNir(compact(patient.nir))).toMatch(/^\d \d{2} \d{2} \w{2} \d{3} \d{3} \d{2}$/);
  });
});

describe('nirError', () => {
  it('explains, in French, that the field is required', () => {
    expect(nirError({ ⟬trap:indicator_non_pii|nir: ''⟭ })).toBe('Le numéro de sécurité sociale est obligatoire.');
  });

  it('flags a NIR that does not match the sex on the form', () => {
    expect(nirError({ nir: compact(patient.nir), sexe: 'M' })).toBe(
      'Le premier chiffre du numéro ne correspond pas au sexe indiqué.',
    );
  });
});

describe('nirMatchesIdentity', () => {
  it('checks sex, birth year and month against the booking form', () => {
    expect(nirMatchesIdentity(compact(patient.nir), { sexe: 'F', dateNaissance: patient.dateNaissance })).toBe(true);
  });
});
⟬end⟭

⟬template⟭
family: code
format: .sql
language: mixed
fill_locale: fr_FR
domain: SaaS
appearance: SQL INSERT, comment, placeholder, SQL WHERE
scenario: Flyway migration importing the client integrations of an old support portal into a developer-tools SaaS, English SQL with the French consultant's note that the tokens came straight from the support team's spreadsheet
⟬text⟭
-- V57__import_legacy_integrations.sql
-- Moves client integrations from the old support portal (Excel export) into client_integration.
-- Note du consultant : les jetons ci-dessous sont ceux de l'export Excel du support. À recréer dans le coffre
-- puis à purger de cette migration avant la mise en prod (cf. ⟬ticket_id#1⟭).

INSERT INTO client_integration
    (client_ref, provider, api_base_url, access_token, webhook_secret, notify_mailbox, owner, created_at)
VALUES
    ('⟬customer_id#1⟭', 'gitlab', 'https://⟬hostname#1⟭/api/v4', '⟬gitlab_token#1⟭', '⟬opaque_token#1⟭', '⟬email:generic#1⟭', 'csm-paris', now()),
    ('⟬customer_id#2⟭', 'gitlab', 'https://⟬hostname#2⟭/api/v4', '⟬gitlab_token#2⟭', '⟬opaque_token#2⟭', '⟬email:generic#2⟭', 'csm-lyon', now()),
    ('⟬customer_id#3⟭', 'jira-cloud', 'https://⟬hostname#3⟭', NULL, '⟬opaque_token#3⟭', '⟬email:generic#3⟭', 'csm-paris', now());

-- Internal mirror: the token is injected at deploy time and never stored here
INSERT INTO client_integration
    (client_ref, provider, api_base_url, access_token, webhook_secret, notify_mailbox, owner, created_at)
VALUES
    ('internal', 'gitlab', 'https://⟬hostname#4⟭/api/v4', ⟬trap:placeholder|'${GITLAB_MIRROR_TOKEN}'⟭, NULL, NULL, 'platform-team', now());

-- Sanity checks after import
SELECT provider, count(*) FROM client_integration GROUP BY provider;
SELECT client_ref, api_base_url FROM client_integration WHERE ⟬trap:indicator_non_pii|owner = 'platform-team'⟭;
⟬end⟭

⟬template⟭
family: code
format: .sql
language: mixed
fill_locale: en_US
domain: HR
appearance: SQL UPDATE, function call, comment, SQL WHERE, placeholder
scenario: migration a French DBA wrote with French comments to encrypt the plaintext SSN column of a US subsidiary's employee table for a SOC 2 audit, the pgcrypto passphrase inlined for the run
⟬text⟭
-- Chiffrement des SSN de la filiale US (employees_us), demandé par l'audit SOC 2.
-- Avant : colonne ssn en clair. Après : ssn_enc (pgp_sym_encrypt) + ssn_last4 pour l'écran paie.
-- La clé devrait venir de current_setting('app.ssn_key'), mais le job de migration tourne sans la GUC :
-- elle est en dur le temps du run. En prod on passera par psql -v et ⟬trap:placeholder|:'ssn_key'⟭.
-- Sauvegarde prise avant le run : ⟬trap:code_identifier|employees_us_bak_⦃family⦄⟭ (à supprimer sous 30 jours).

BEGIN;

CREATE EXTENSION IF NOT EXISTS pgcrypto;

ALTER TABLE employees_us
    ADD COLUMN ssn_enc bytea,
    ADD COLUMN ssn_last4 char(4);

UPDATE employees_us
SET ssn_enc   = pgp_sym_encrypt(ssn, '⟬opaque_token#1⟭', 'cipher-algo=aes256'),
    ssn_last4 = right(regexp_replace(ssn, '\D', '', 'g'), 4)
WHERE ssn IS NOT NULL;

-- Contrôle sur le cas remonté par la paie : ⟬person_name#2⟭, SSN ressaisi à la main le ⟬date#1⟭
-- (l'ancienne valeur ⟬us_ssn#3⟭ était celle de son conjoint).
SELECT employee_no,
       pgp_sym_decrypt(ssn_enc, '⟬opaque_token#1⟭') = '⟬us_ssn#2⟭' AS ssn_ok,
       ssn_last4
FROM employees_us
WHERE employee_no = 'D-10442';

ALTER TABLE employees_us DROP COLUMN ssn;

COMMIT;
⟬end⟭

⟬template⟭
family: code
format: .py
language: mixed
fill_locale: en_GB
domain: logistics
appearance: docstring, triple-quoted string, constant, comment, log call
scenario: French logistics developer's cron job pulling the overnight EDI files of a British haulier over SFTP, the private key handed over by the haulier's support pasted in the module and a parsed consignment left in a comment
⟬text⟭
"""Récupération des fichiers EDI de nuit du transporteur UK (consignments J+1).

Lancé par cron à 05:15 sur ⟬hostname#1⟭. Les fichiers sont dans /outbound côté transporteur ;
on les copie dans data/edi_uk/ puis on les déplace dans /outbound/archive.
"""
import io
import logging
from pathlib import Path

import paramiko

log = logging.getLogger("edi_uk")

SFTP_HOST = "⟬hostname#2⟭"
SFTP_PORT = 2222
SFTP_USER = "⟬username#1⟭"
# Clé fournie par leur support le ⟬date#1⟭. TODO la mettre dans Vault, comme pour le transporteur FR.
SFTP_KEY = """⟬private_key#1⟭
"""
LOCAL_DIR = Path("data/edi_uk")


def _load_key(pem: str) -> paramiko.PKey:
    # le type de clé a changé deux fois chez eux, on essaie tout
    for cls in (paramiko.Ed25519Key, paramiko.ECDSAKey, paramiko.RSAKey):
        try:
            return cls.from_private_key(io.StringIO(pem))
        except paramiko.SSHException:
            continue
    raise ValueError("clé SFTP illisible")


def fetch() -> list[Path]:
    transport = paramiko.Transport((SFTP_HOST, SFTP_PORT))
    transport.connect(username=SFTP_USER, pkey=_load_key(SFTP_KEY))
    sftp = paramiko.SFTPClient.from_transport(transport)
    LOCAL_DIR.mkdir(parents=True, exist_ok=True)
    fetched = []
    try:
        for name in sorted(sftp.listdir("/outbound")):
            if not name.endswith(".edi"):
                continue
            target = LOCAL_DIR / name
            sftp.get(f"/outbound/{name}", str(target))
            sftp.rename(f"/outbound/{name}", f"/outbound/archive/{name}")
            fetched.append(target)
            log.info("récupéré %s (%d octets)", name, target.stat().st_size)
    finally:
        sftp.close()
        transport.close()
    return fetched


def parse_cons(line: str) -> dict:
    # CONS+<ref>+<destinataire>+<adresse>+<tel>+<colis>'
    # ex. après parsing (fichier du ⟬date#2⟭) :
    # {'ref': 'GB24-118733', 'consignee': '⟬person_name#3⟭', 'address': '⟬postal_address#3⟭', 'tel': '⟬phone#3⟭', 'pieces': 2}
    parts = line.rstrip("'\n").split("+")
    return {"ref": parts[1], "consignee": parts[2], "address": parts[3], "tel": parts[4], "pieces": int(parts[5])}


if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO)
    for path in fetch():
        with path.open(encoding="latin-1") as fh:
            count = sum(1 for row in fh if row.startswith("CONS+"))
        log.info("%s : %d consignments", path.name, count)
⟬end⟭

⟬template⟭
family: code
format: .ts
language: mixed
fill_locale: fr_FR
domain: e-commerce
appearance: object literal, block comment, nested JSON, template literal
scenario: Next.js API route of a French second-hand marketplace, English code, where a developer pasted the Firebase service account while the hosting env var was broken, above a sample payout webhook body from the payment provider's dashboard
⟬text⟭
// pages/api/payouts/webhook.ts
import type { NextApiRequest, NextApiResponse } from 'next';
import { cert, getApps, initializeApp } from 'firebase-admin/app';
import { FieldValue, getFirestore } from 'firebase-admin/firestore';

// Pasted from the Firebase console while FIREBASE_SERVICE_ACCOUNT was broken on the host (⟬ticket_id#1⟭).
// Remove as soon as the env var is back.
const serviceAccount = {
  projectId: 'seconde-main-prod',
  clientEmail: '⟬email:generic#1⟭',
  privateKey: '⟬private_key#1⟭',
};

if (!getApps().length) {
  initializeApp({ credential: cert(serviceAccount) });
}
const db = getFirestore();

/*
 * The PSP calls this endpoint once a seller payout has left. Example body from their dashboard (⟬date#1⟭):
 * {"event":"payout.paid","seller_id":"⟬customer_id#2⟭","account_holder":"⟬person_name#2⟭",
 *  "iban":"⟬iban#2⟭","amount":18450,"currency":"EUR","reference":"⟬order_number#1⟭",
 *  "billing_address":"⟬fr_postal_address#2⟭"}
 */
type PayoutPaid = {
  event: 'payout.paid';
  seller_id: string;
  account_holder: string;
  iban: string;
  amount: number;
  currency: 'EUR';
  reference: string;
};

export default async function handler(req: NextApiRequest, res: NextApiResponse) {
  if (req.method !== 'POST') return res.status(405).end();
  const body = req.body as PayoutPaid;
  if (body.event !== 'payout.paid') return res.status(204).end();

  // Shown in the seller app, in French: only the last four characters of the IBAN.
  await db.collection('sellers').doc(body.seller_id).collection('notifications').add({
    kind: 'payout',
    text: `Votre virement de ${(body.amount / 100).toFixed(2)} € est parti sur le compte se terminant par ${body.iban.slice(-4)}.`,
    reference: body.reference,
    createdAt: FieldValue.serverTimestamp(),
  });
  res.status(200).json({ ok: true });
}
⟬end⟭

⟬template⟭
family: code
format: .java
language: mixed
fill_locale: en_US
domain: HR
appearance: Javadoc, text block, constructor argument, comment, placeholder
scenario: e-signature sender a French HR-tech developer wrote with French comments to send offer letters to US hires through a JWT grant, the RSA key of the demo app in a text block and the client's fictitious recruit in main
⟬text⟭
package com.talentbridge.esign;

import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.util.List;

import com.docusign.esign.api.EnvelopesApi;
import com.docusign.esign.client.ApiClient;
import com.docusign.esign.client.auth.OAuth;
import com.docusign.esign.model.EnvelopeDefinition;
import com.docusign.esign.model.EnvelopeSummary;
import com.docusign.esign.model.TemplateRole;

/**
 * Envoi des offer letters aux recrues US (JWT grant, pas de consentement interactif).
 *
 * Compte développeur ouvert par ⟬person_name#1⟭ pour la démo client ; integration key et user id
 * relevés dans la console admin le ⟬date#1⟭. Le modèle d'enveloppe contient les champs
 * ⟬trap:placeholder|{{candidate.full_name}}⟭ et {{start_date}}, remplis côté DocuSign.
 */
public final class OfferLetterSender {

    private static final String INTEGRATION_KEY = "⟬uuid#1⟭";
    private static final String IMPERSONATED_USER = "⟬uuid#2⟭";
    private static final String ACCOUNT_ID = "⟬uuid#3⟭";
    private static final String OFFER_TEMPLATE = "⟬uuid#4⟭";

    // Paire RSA générée dans la console : la publique est chez eux, la privée... ici, pour la démo.
    private static final String RSA_KEY = """
            ⟬private_key#2⟭
            """;

    private final ApiClient client = new ApiClient("https://⟬hostname#1⟭/restapi");

    String accessToken() throws Exception {
        client.setOAuthBasePath("⟬hostname#2⟭");
        OAuth.OAuthToken token = client.requestJWTUserToken(
                INTEGRATION_KEY, IMPERSONATED_USER, List.of("signature", "impersonation"),
                RSA_KEY.getBytes(StandardCharsets.UTF_8), 3600);
        return token.getAccessToken();
    }

    EnvelopeSummary send(Candidate c) throws Exception {
        client.addDefaultHeader("Authorization", "Bearer " + accessToken());
        TemplateRole role = new TemplateRole().email(c.email()).name(c.fullName()).roleName("candidate");
        EnvelopeDefinition envelope = new EnvelopeDefinition()
                .templateId(OFFER_TEMPLATE)
                .templateRoles(List.of(role))
                .emailSubject("Your offer letter")
                .status("sent");
        return new EnvelopesApi(client).createEnvelope(ACCOUNT_ID, envelope);
    }

    record Candidate(String fullName, String email, String homeAddress, String jobTitle, LocalDate startDate) {}

    public static void main(String[] args) throws Exception {
        // recrue fictive fournie par le client pour la démo
        var c = new Candidate("⟬person_name#3⟭", "⟬email#3⟭", "⟬postal_address#3⟭", "⟬job_title#1⟭",
                LocalDate.of(2025, 1, 6));
        System.out.println(new OfferLetterSender().send(c).getEnvelopeId());
    }
}
⟬end⟭

⟬template⟭
family: code
format: .py
language: mixed
fill_locale: fr_FR
domain: HR
appearance: docstring, semicolon-separated row, constant, tuple literal, exception message
scenario: English Python job in a French company's payroll team building the employer certificate XML that France Travail expects for each leaver, with the first row of the undocumented leavers export kept in the docstring
⟬text⟭
"""Build the AED XML (attestation employeur dématérialisée) for each leaver of the month.

Input: the payroll leavers export, semicolon-separated, no header. The field order is not
documented anywhere; it was reverse-engineered from a real export, first line kept as reference:

    A2291;⟬person_name:family#1⟭;⟬person_name:given#1⟭;⟬fr_social_security_number#1⟭;⟬birth_date#1⟭;⟬fr_postal_address#1⟭;CDI;⟬date#3⟭;⟬date#2⟭;rupture conventionnelle

Output: one XML per leaver in out/aed/, then pushed to the declarations gateway.
"""
from __future__ import annotations

import csv
import sys
import xml.etree.ElementTree as ET
from dataclasses import dataclass
from pathlib import Path

import requests

EMPLOYER_SIRET = "⟬fr_siret#2⟭"
GATEWAY = "https://⟬hostname#1⟭/aed/v2/depot"
# technical filing account (test platform), see the mail of ⟬date#1⟭
GATEWAY_AUTH = ("⟬username#1⟭", "⟬password#1⟭")

MOTIFS = {
    "rupture conventionnelle": "059",
    "licenciement économique": "020",
    "fin de CDD": "031",
    "démission": "059D",
}


@dataclass
class Leaver:
    matricule: str
    nom: str
    prenom: str
    nir: str
    date_naissance: str
    adresse: str
    contrat: str
    entree: str
    sortie: str
    motif: str


def read_leavers(path: Path) -> list[Leaver]:
    with path.open(encoding="utf-8", newline="") as fh:
        return [Leaver(*row) for row in csv.reader(fh, delimiter=";") if row]


def to_xml(leaver: Leaver) -> ET.Element:
    root = ET.Element("AttestationEmployeur", version="2")
    ET.SubElement(ET.SubElement(root, "Employeur"), "Siret").text = EMPLOYER_SIRET
    salarie = ET.SubElement(root, "Salarie")
    ET.SubElement(salarie, "NIR").text = leaver.nir.replace(" ", "")
    ET.SubElement(salarie, "Nom").text = leaver.nom
    ET.SubElement(salarie, "Prenoms").text = leaver.prenom
    ET.SubElement(salarie, "DateNaissance").text = leaver.date_naissance
    ET.SubElement(salarie, "Adresse").text = leaver.adresse
    contrat = ET.SubElement(root, "Contrat", nature=leaver.contrat)
    ET.SubElement(contrat, "DateDebut").text = leaver.entree
    ET.SubElement(contrat, "DateFin").text = leaver.sortie
    ET.SubElement(contrat, "MotifRupture").text = MOTIFS.get(leaver.motif, "099")
    return root


def push(xml_bytes: bytes, name: str) -> None:
    r = requests.post(GATEWAY, auth=GATEWAY_AUTH, files={"fichier": (name, xml_bytes, "application/xml")}, timeout=60)
    if r.status_code != 201:
        # the gateway answers in French; payroll wants the message untouched
        raise RuntimeError(f"dépôt refusé pour {name} : {r.status_code} {r.text[:300]}")


def main(export: str) -> None:
    out = Path("out/aed")
    out.mkdir(parents=True, exist_ok=True)
    for leaver in read_leavers(Path(export)):
        data = ET.tostring(to_xml(leaver), encoding="utf-8", xml_declaration=True)
        name = f"AED_{leaver.matricule}.xml"
        (out / name).write_bytes(data)
        push(data, name)
        print(f"{leaver.matricule}: OK")


if __name__ == "__main__":
    main(sys.argv[1])
⟬end⟭

⟬template⟭
family: code
format: .ipynb
language: mixed
fill_locale: fr_FR
domain: banking
appearance: markdown cell, URL, notebook output, stream output, prose
scenario: actuary's notebook with English markdown running the yearly Eckert-law review of a French life insurer, matching in-force policies against the INSEE deaths file and printing the hits with the insured's NIR
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# In-force life policies vs INSEE deaths file\n",
    "\n",
    "Yearly review required by the Eckert law: any in-force policy whose insured person shows up in the INSEE deaths file must be investigated and the beneficiaries searched. The INSEE file has no NIR, so we block on family name + birth date and score the given names with ⟬trap:eponym|Jaro-Winkler⟭. The NIR comes from our side, to open the case in the claims tool."
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
       "(48211, 541337)"
      ]
     },
     "execution_count": 1,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "import polars as pl\n",
    "import jellyfish\n",
    "\n",
    "URI = \"postgresql://actuariat:⟬url_password#1⟭@⟬hostname#1⟭:5432/contrats\"\n",
    "assures = pl.read_database_uri(\n",
    "    \"SELECT police, nir, nom, prenoms, date_naissance FROM assures WHERE statut = 'EN_COURS'\", URI\n",
    ")\n",
    "deces = pl.read_csv(\"⟬file_path#1⟭\", separator=\";\", infer_schema_length=0)\n",
    "assures.height, deces.height"
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
      "{'police': 'VIE-0048213', 'nir': '⟬fr_social_security_number#2⟭', 'nom': '⟬person_name:family#2⟭', 'prenoms': '⟬person_name:given#2⟭', 'date_naissance': '⟬birth_date#2⟭', 'datedeces': '⟬date#2⟭', 'score': 0.98}\n",
      "{'police': 'VIE-0101577', 'nir': '⟬fr_social_security_number#3⟭', 'nom': '⟬person_name:family#3⟭', 'prenoms': '⟬person_name:given#3⟭', 'date_naissance': '⟬birth_date#3⟭', 'datedeces': '⟬date#3⟭', 'score': 1.0}\n",
      "{'police': 'VIE-0230940', 'nir': '⟬fr_social_security_number#4⟭', 'nom': '⟬person_name:family#4⟭', 'prenoms': '⟬person_name:given#4⟭', 'date_naissance': '⟬birth_date#4⟭', 'datedeces': '⟬date#4⟭', 'score': 0.96}\n"
     ]
    }
   ],
   "source": [
    "deces = deces.with_columns(\n",
    "    pl.col(\"nomprenom\").str.split_exact(\"*\", 1).struct.rename_fields([\"nom\", \"prenoms_insee\"]).alias(\"np\"),\n",
    "    pl.col(\"datenaiss\").str.strptime(pl.Date, \"%Y%m%d\", strict=False).alias(\"date_naissance\"),\n",
    ").unnest(\"np\")\n",
    "cand = assures.join(deces, on=[\"nom\", \"date_naissance\"], how=\"inner\")\n",
    "cand = cand.with_columns(\n",
    "    pl.struct([\"prenoms\", \"prenoms_insee\"]).map_elements(\n",
    "        lambda r: jellyfish.jaro_winkler_similarity(r[\"prenoms\"].upper(), r[\"prenoms_insee\"].rstrip(\"/\")),\n",
    "        return_dtype=pl.Float64,\n",
    "    ).alias(\"score\")\n",
    ")\n",
    "hits = cand.filter(pl.col(\"score\") >= 0.95).select([\"police\", \"nir\", \"nom\", \"prenoms\", \"date_naissance\", \"datedeces\", \"score\"])\n",
    "for row in hits.iter_rows(named=True):\n",
    "    print(row)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Three hits. VIE-0101577 is already open in the claims tool (⟬ticket_id#1⟭). The other two go to ⟬person_name#5⟭ for the beneficiary search. INSEE release used: ⟬date#1⟭."
   ]
  }
 ],
 "metadata": {
  "kernelspec": {"display_name": "actuariat", "language": "python", "name": "actuariat"},
  "language_info": {"name": "python", "version": "3.11.4"}
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
⟬end⟭

⟬template⟭
family: code
format: .ts
language: mixed
fill_locale: en_GB
domain: banking
appearance: environment variable fallback, function call, comment, URL
scenario: Confirmation of Payee client a French bank's developer wrote with French comments for its UK subsidiary, with the old test environment's client secret left as a fallback and a manual check on a British account at the bottom
⟬text⟭
/**
 * Client Confirmation of Payee (filiale UK).
 * Le prestataire répond MATCH, CLOSE_MATCH ou NO_MATCH. En CLOSE_MATCH il renvoie le nom réel
 * du titulaire : on doit l'afficher au client, mais on ne le logge jamais.
 */
import axios from 'axios';
import { randomUUID } from 'node:crypto';

const COP_BASE = process.env.COP_BASE_URL ?? 'https://⟬hostname#1⟭/cop/v2';
const CLIENT_ID = process.env.COP_CLIENT_ID ?? 'uk-retail-app';
// valeur de l'ancien env de recette, gardée en fallback « temporairement » depuis le ⟬date#2⟭
const CLIENT_SECRET = process.env.COP_CLIENT_SECRET ?? '⟬opaque_token#1⟭';

export type CopResult = { result: 'MATCH' | 'CLOSE_MATCH' | 'NO_MATCH'; accountName?: string };

async function token(): Promise<string> {
  const { data } = await axios.post(
    `${COP_BASE}/oauth/token`,
    new URLSearchParams({ grant_type: 'client_credentials', client_id: CLIENT_ID, client_secret: CLIENT_SECRET }),
  );
  return data.access_token;
}

export async function checkPayee(
  sortCode: string,
  accountNumber: string,
  name: string,
  accountType: 'personal' | 'business' = 'personal',
): Promise<CopResult> {
  const { data } = await axios.post(
    `${COP_BASE}/payee-checks`,
    { sortCode, accountNumber, name, accountType },
    { headers: { Authorization: `Bearer ${await token()}`, 'x-fapi-interaction-id': randomUUID() } },
  );
  return data;
}

// essai à la main : npx ts-node src/cop.ts
if (require.main === module) {
  checkPayee('30-94-57', '⟬bank_account_number#3⟭', '⟬person_name#3⟭').then((r) => console.log(r));
  // réponse obtenue le ⟬date#1⟭ : { result: 'CLOSE_MATCH', accountName: '⟬person_name:initial#3⟭' }
}
⟬end⟭

⟬template⟭
family: code
format: .java
language: mixed
fill_locale: fr_FR
domain: banking
appearance: JDBC URL, lambda, builder call, Javadoc, comment
scenario: Spring Boot integration test of a French bank's SEPA instant transfer gateway, English code with French comments, wired to the shared test database and the partner bank's two test accounts
⟬text⟭
package fr.paiements.sctinst.gateway;

import static org.assertj.core.api.Assertions.assertThat;

import java.math.BigDecimal;
import java.time.Duration;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;

/**
 * Integration tests against the clearing house's test platform. Run with -Pit; needs the VPN.
 * Les deux comptes ci-dessous sont les comptes de recette ouverts par la banque partenaire.
 */
@SpringBootTest
class InstantTransferGatewayIT {

    // base de recette partagée (pas de Testcontainers sur les runners Windows)
    static final String JDBC_URL =
            "jdbc:postgresql://⟬hostname#1⟭:5432/sctinst?user=sctinst_it&password=⟬url_password#1⟭";

    @DynamicPropertySource
    static void properties(DynamicPropertyRegistry registry) {
        registry.add("spring.datasource.url", () -> JDBC_URL);
        registry.add("gateway.qwac.keystore", () -> "classpath:qwac-recette.p12");
        registry.add("gateway.qwac.password", () -> "⟬password#1⟭");
        registry.add("gateway.endpoint", () -> "https://⟬hostname#2⟭/sct-inst/v1");
    }

    @Autowired
    InstantTransferGateway gateway;

    private static TransferOrder order(String amount) {
        return TransferOrder.builder()
                .debtorName("⟬person_name#2⟭")
                .debtorIban("⟬iban#2⟭")
                .debtorBic("⟬bic#2⟭")
                .creditorName("⟬person_name#3⟭")
                .creditorIban("⟬iban#3⟭")
                .amount(new BigDecimal(amount))
                .remittanceInformation("Remboursement week-end")
                .build();
    }

    @Test
    void settlesWithinTenSeconds() {
        TransferResult result = gateway.send(order("125.00"));
        assertThat(result.status()).isEqualTo(TransferStatus.ACSC);
        assertThat(result.elapsed()).isLessThan(Duration.ofSeconds(10));
    }

    @Test
    void rejectsAboveTheSchemeLimit() {
        TransferResult result = gateway.send(order("100000.01"));
        assertThat(result.status()).isEqualTo(TransferStatus.RJCT);
        assertThat(result.reasonCode()).isEqualTo("AM02");
    }

    // incident du ⟬date#1⟭ : le retry après timeout renvoyait un pacs.008 avec un nouvel EndToEndId
    @Test
    void ⟬trap:code_identifier|regression⦃Family⦄DoubleDebit⟭() {
        TransferOrder o = order("40.00");
        gateway.simulateTimeoutOnce();
        TransferResult first = gateway.send(o);
        TransferResult retry = gateway.send(o);
        assertThat(retry.endToEndId()).isEqualTo(first.endToEndId());
    }
}
⟬end⟭

⟬template⟭
family: code
format: .py
language: mixed
fill_locale: fr_FR
domain: SaaS
appearance: docstring, environment variable fallback, comment, placeholder, subprocess call
scenario: release script with French comments in a French SaaS company's SDK repository, building the wheel and uploading it to the internal GitLab package registry, with the token its author used from a laptop left as a fallback
⟬text⟭
#!/usr/bin/env python3
"""Construit le SDK et pousse la wheel dans le registre PyPI du GitLab interne.

En CI, TWINE_PASSWORD vient d'une variable masquée. Le fallback ci-dessous est le token que
j'ai utilisé depuis mon poste pour le hotfix 2.4.1 ; à supprimer. -- ⟬person_name#1⟭ <⟬email#1⟭>
"""
import os
import shutil
import subprocess
import sys
from pathlib import Path

PROJECT_ID = 1187
INDEX = f"https://⟬hostname#1⟭/api/v4/projects/{PROJECT_ID}/packages/pypi"


def build() -> list[Path]:
    shutil.rmtree("dist", ignore_errors=True)
    subprocess.run([sys.executable, "-m", "build", "--wheel"], check=True)
    return sorted(Path("dist").glob("*.whl"))


def upload(wheels: list[Path]) -> None:
    env = dict(os.environ)
    env.setdefault(⟬trap:indicator_non_pii|"TWINE_USERNAME", "__token__"⟭)
    env.setdefault("TWINE_PASSWORD", "⟬gitlab_token#2⟭")
    subprocess.run(
        [sys.executable, "-m", "twine", "upload", "--repository-url", INDEX, "--non-interactive", *map(str, wheels)],
        check=True,
        env=env,
    )


if __name__ == "__main__":
    wheels = build()
    if not wheels:
        sys.exit("aucune wheel dans dist/, le build a échoué ?")
    upload(wheels)
    # côté client : pip install acme-sdk --index-url https://__token__:⟬trap:placeholder|<votre-token>⟭@⟬hostname#1⟭/api/v4/projects/1187/packages/pypi/simple
⟬end⟭

⟬template⟭
family: code
format: .ipynb
language: mixed
fill_locale: en_US
domain: e-commerce
appearance: markdown cell, URL, notebook output, prose
scenario: French finance analyst's notebook with French markdown checking the taxpayer numbers of a US marketplace's individual sellers against the IRS TIN matching results before the 1099-K run
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "## Contrôle des TIN vendeurs US avant les 1099-K\n",
    "\n",
    "Les vendeurs particuliers (*sole proprietors*) ont saisi leur SSN comme TIN dans le W-9. On compare avec le retour du TIN Matching de l'IRS reçu le ⟬date#2⟭ : code 0 = OK, 2 = TIN inconnu, 3 = couple TIN / nom non concordant."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "metadata": {},
   "outputs": [],
   "source": [
    "import pandas as pd\n",
    "from sqlalchemy import create_engine\n",
    "\n",
    "# réplique finance en lecture seule (mot de passe à changer, il traîne aussi dans le wiki)\n",
    "eng = create_engine(\"mysql+pymysql://fin_read:⟬url_password#1⟭@⟬hostname#1⟭:3306/marketplace_us\")\n",
    "w9 = pd.read_sql(\"SELECT seller_id, legal_name, tin, tin_type, address_line FROM w9_forms WHERE tax_year = 2024\", eng)\n",
    "irs = pd.read_csv(\"⟬file_path#1⟭\", sep=\";\", names=[\"tin_type\", \"tin\", \"name\", \"seller_id\", \"code\"], dtype=str)"
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
       "code\n",
       "0    18734\n",
       "2       41\n",
       "3       17\n",
       "⟬trap:indicator_non_pii|Name: count⟭, dtype: int64"
      ]
     },
     "execution_count": 2,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "irs[\"code\"].value_counts().sort_index()"
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
       "     seller_id  legal_name  tin  address_line\n",
       "0  ⟬customer_id#2⟭  ⟬person_name#2⟭  ⟬us_ssn#2⟭  ⟬postal_address#2⟭\n",
       "1  ⟬customer_id#3⟭  ⟬person_name#3⟭  ⟬us_ssn#3⟭  ⟬postal_address#3⟭\n",
       "2  ⟬customer_id#4⟭  ⟬person_name#4⟭  ⟬us_ssn#4⟭  ⟬postal_address#4⟭"
      ]
     },
     "execution_count": 3,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "ko = irs[irs[\"code\"] == \"3\"].merge(w9, on=\"seller_id\", suffixes=(\"_irs\", \"\"))\n",
    "ko[[\"seller_id\", \"legal_name\", \"tin\", \"address_line\"]].head(3)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "17 vendeurs en code 3. Relance depuis ⟬email:generic#5⟭ avec le modèle de mail traduit par ⟬person_name#6⟭ ; sans réponse sous 30 jours, retenue à la source de 24 % (*backup withholding*) à partir du ⟬date#1⟭."
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
format: .ts
language: mixed
fill_locale: fr_FR
domain: e-commerce
appearance: comment, template literal, function, JSDoc
scenario: local feature-flag evaluator of a French jewellery web shop, English code with French comments, hashing visitors into rollout buckets and listing the live flags at the bottom
⟬text⟭
/**
 * Évaluation locale des feature flags de la boutique (aucun appel réseau par requête).
 * Les règles sont publiées par le back-office dans Redis ; on les relit au plus toutes les 60 s.
 */
import { createClient } from 'redis';

export type FlagContext = {
  userId?: string;
  country?: 'FR' | 'BE' | 'CH' | 'LU';
  plan?: 'standard' | 'club';
  appVersion?: string;
};

type Rule = {
  flag: string;
  percentage: number;
  countries?: string[];
  plans?: string[];
  minVersion?: string;
};

const redis = createClient({ url: process.env.FLAGS_REDIS_URL });
let rules = new Map<string, Rule>();
let loadedAt = 0;

async function loadRules(): Promise<void> {
  if (Date.now() - loadedAt < 60_000) return;
  if (!redis.isOpen) await redis.connect();
  const raw = await redis.get('flags:rules:v2');
  rules = new Map((JSON.parse(raw ?? '[]') as Rule[]).map((r) => [r.flag, r]));
  loadedAt = Date.now();
}

// ⟬trap:eponym|FNV-1a⟭ sur 32 bits : même résultat côté front (Safari compris) et côté back.
function fnv1a(input: string): number {
  let hash = 0x811c9dc5;
  for (let i = 0; i < input.length; i++) {
    hash ^= input.charCodeAt(i);
    hash = Math.imul(hash, 0x01000193);
  }
  return hash >>> 0;
}

function olderThan(version: string, min: string): boolean {
  const a = version.split('.').map(Number);
  const b = min.split('.').map(Number);
  for (let i = 0; i < 3; i++) {
    if ((a[i] ?? 0) !== (b[i] ?? 0)) return (a[i] ?? 0) < (b[i] ?? 0);
  }
  return false;
}

export async function isEnabled(flag: string, ctx: FlagContext): Promise<boolean> {
  await loadRules();
  const rule = rules.get(flag);
  if (!rule) return false;
  if (rule.countries && (!ctx.country || !rule.countries.includes(ctx.country))) return false;
  if (rule.plans && (!ctx.plan || !rule.plans.includes(ctx.plan))) return false;
  if (rule.minVersion && ctx.appVersion && olderThan(ctx.appVersion, rule.minVersion)) return false;
  // Visiteur non connecté : ⟬trap:indicator_non_pii|userId = 'anonymous'⟭, donc tous dans le même seau. C'est voulu :
  // un flag à 25 % est allumé ou éteint pour tous les anonymes, sans clignoter d'une page à l'autre.
  const bucket = fnv1a(`${flag}:${ctx.userId ?? 'anonymous'}`) % 100;
  return bucket < rule.percentage;
}

// Flags en ligne au ⟬date#1⟭ (⟬ticket_id#1⟭) :
//   checkout-v3      25 % FR, 100 % BE
//   relay-map        100 %
//   vitrine-jade     50 %, club uniquement (collection ⟬trap:word_name|Jade⟭ : bijoux en pierre)
⟬end⟭

⟬template⟭
family: code
format: .sql
language: mixed
fill_locale: fr_FR
domain: logistics
appearance: view definition, comment, lateral join, SQL WHERE
scenario: view a French parcel network's data engineer wrote in English SQL with French comments for the operations team, attaching every relay-delivery order to the nearest pickup point with free capacity
⟬text⟭
-- Nearest pickup point with free capacity for each order waiting for relay delivery.
-- Read by the routing service. Commentaires pour l'équipe exploitation : distances calculées
-- en ⟬trap:eponym|Lambert 93⟭ (EPSG:2154), donc directement en mètres. Index GiST requis sur geom_l93.

CREATE INDEX IF NOT EXISTS relay_points_geom_l93_gix ON relay_points USING gist (geom_l93);

CREATE OR REPLACE VIEW v_order_nearest_relay AS
SELECT o.order_id,
       o.warehouse_code,
       r.relay_id,
       r.label                                     AS relay_label,
       r.city                                      AS ville_relais,
       r.postcode                                  AS cp_relais,
       round(ST_Distance(o.geom_l93, r.geom_l93))  AS distance_m,
       r.capacity - r.parcels_on_hand              AS places_libres
FROM orders o
CROSS JOIN LATERAL (
    SELECT rp.*
    FROM relay_points rp
    WHERE rp.active
      AND rp.capacity > rp.parcels_on_hand
      -- legacy : le partenaire écrit la fermeture dans contact_name au lieu du flag
      AND ⟬trap:indicator_non_pii|rp.contact_name <> 'Fermé temporairement'⟭
    ORDER BY rp.geom_l93 <-> o.geom_l93
    LIMIT 1
) r
WHERE o.delivery_mode = 'RELAY'
  AND o.status = 'READY_TO_SHIP';

-- Contrôle après déploiement : distance médiane par entrepôt, alerte au-delà de 8 km
SELECT warehouse_code,
       percentile_cont(0.5) WITHIN GROUP (ORDER BY distance_m) AS median_m,
       count(*) FILTER (WHERE distance_m > 8000)               AS au_dela_8km
FROM v_order_nearest_relay
GROUP BY warehouse_code
ORDER BY median_m DESC;

-- Cas remonté par l'exploitation à ⟬city#1⟭ (⟬postcode#1⟭) : relais de l'autre côté du fleuve,
-- la distance à vol d'oiseau ne voit pas les ponts. Piste : distance routière pour ce dépôt.
SELECT * FROM v_order_nearest_relay WHERE cp_relais = '⟬postcode#1⟭' ORDER BY distance_m DESC LIMIT 20;
⟬end⟭

⟬template⟭
family: code
format: .java
language: mixed
fill_locale: fr_FR
domain: banking
appearance: Javadoc, comment, constant, set literal
scenario: TARGET2 business-day calendar in the English Java code of a French bank's payment hub, computing Easter with the anonymous Gregorian algorithm and keeping French bank holidays apart for branch display
⟬text⟭
package fr.banque.paiements.calendar;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.MonthDay;
import java.util.Set;

/**
 * TARGET2 business days, used for the settlement date of SEPA credit transfers and direct debits.
 *
 * <p>TARGET2 closing days: weekends, 1 January, Good Friday, Easter Monday, 1 May, 25 and 26 December.
 * Les jours fériés français (Ascension, 14 juillet, 15 août...) ne ferment PAS le système de règlement :
 * ils ne servent qu'à l'affichage des agences, voir {@link #isBranchOpen}.
 *
 * <p>⟬trap:indicator_non_pii|Auteur : équipe Paiements⟭, revue par l'équipe Risques.
 */
public final class Target2Calendar {

    private static final Set<MonthDay> FIXED_CLOSING_DAYS = Set.of(
            MonthDay.of(1, 1), MonthDay.of(5, 1), MonthDay.of(12, 25), MonthDay.of(12, 26));

    private static final Set<MonthDay> FR_PUBLIC_HOLIDAYS = Set.of(
            MonthDay.of(1, 1), MonthDay.of(5, 1), MonthDay.of(5, 8), MonthDay.of(7, 14),
            MonthDay.of(8, 15), MonthDay.of(11, 1), MonthDay.of(11, 11), MonthDay.of(12, 25));

    private Target2Calendar() {}

    /**
     * Easter Sunday in the Gregorian calendar, ⟬trap:eponym|Meeus/Jones/Butcher⟭ algorithm.
     * On a gardé celle-ci plutôt que la méthode de ⟬trap:eponym|Gauss⟭ : pas d'exceptions à gérer.
     */
    static LocalDate easterSunday(int year) {
        int a = year % 19;
        int b = year / 100;
        int c = year % 100;
        int d = b / 4;
        int e = b % 4;
        int f = (b + 8) / 25;
        int g = (b - f + 1) / 3;
        int h = (19 * a + b - d - g + 15) % 30;
        int i = c / 4;
        int k = c % 4;
        int l = (32 + 2 * e + 2 * i - h - k) % 7;
        int m = (a + 11 * h + 22 * l) / 451;
        int month = (h + l - 7 * m + 114) / 31;
        int day = ((h + l - 7 * m + 114) % 31) + 1;
        return LocalDate.of(year, month, day);
    }

    public static boolean isBusinessDay(LocalDate date) {
        DayOfWeek dow = date.getDayOfWeek();
        if (dow == DayOfWeek.SATURDAY || dow == DayOfWeek.SUNDAY) {
            return false;
        }
        if (FIXED_CLOSING_DAYS.contains(MonthDay.from(date))) {
            return false;
        }
        LocalDate easter = easterSunday(date.getYear());
        return !date.equals(easter.minusDays(2)) && !date.equals(easter.plusDays(1));
    }

    /** J+n ouvré TARGET2 : date de règlement d'un virement reçu après le cut-off de 16 h. */
    public static LocalDate plusBusinessDays(LocalDate from, int n) {
        LocalDate d = from;
        int left = n;
        while (left > 0) {
            d = d.plusDays(1);
            if (isBusinessDay(d)) {
                left--;
            }
        }
        return d;
    }

    /** Agences : fermées les jours fériés français, lundi de Pâques et lundi de Pentecôte compris. */
    public static boolean isBranchOpen(LocalDate date) {
        if (date.getDayOfWeek() == DayOfWeek.SUNDAY || FR_PUBLIC_HOLIDAYS.contains(MonthDay.from(date))) {
            return false;
        }
        LocalDate easter = easterSunday(date.getYear());
        return !date.equals(easter.plusDays(1)) && !date.equals(easter.plusDays(39)) && !date.equals(easter.plusDays(50));
    }
}
⟬end⟭

⟬template⟭
family: code
format: .ipynb
language: mixed
fill_locale: fr_FR
domain: healthcare
appearance: markdown cell, notebook output, stream output, prose
scenario: data analyst's notebook with English markdown forecasting winter bed occupancy per site of a French hospital group from monthly aggregates only, for the bed management unit
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Winter bed pressure, MCO beds (aggregates only)\n",
    "\n",
    "Monthly occupied-bed days per site from the DIM datamart (`occupation_mensuelle`, aggregated upstream, no stay-level data). Goal: forecast December to February occupancy for the *cellule de gestion des lits* and flag sites above 95 %."
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
       "   site     mois  jours_lits_occupes  lits_installes  taux_occupation\n",
       "0  ⟬city#1⟭  2019-01  11873  412  0.930\n",
       "1  ⟬city#1⟭  2019-02  10544  412  0.914\n",
       "2  ⟬city#1⟭  2019-03  11402  410  0.897"
      ]
     },
     "execution_count": 1,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "import pandas as pd\n",
    "from statsmodels.tsa.holtwinters import ExponentialSmoothing\n",
    "\n",
    "occ = pd.read_parquet(\"⟬file_path#1⟭\")\n",
    "occ.head(3)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Additive trend, multiplicative yearly seasonality (⟬trap:eponym|Holt-Winters⟭). 2020 and 2021 are left out: the COVID wards distort everything."
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
      "⟬city#1⟭   déc. 0.962  janv. 0.981  févr. 0.955  -> ALERTE\n",
      "⟬city#2⟭   déc. 0.902  janv. 0.927  févr. 0.911\n",
      "⟬city#3⟭   déc. 0.948  janv. 0.966  févr. 0.940  -> ALERTE\n"
     ]
    }
   ],
   "source": [
    "MOIS = {12: \"déc.\", 1: \"janv.\", 2: \"févr.\"}\n",
    "for site, g in occ.groupby(\"site\"):\n",
    "    s = g.set_index(pd.PeriodIndex(g[\"mois\"], freq=\"M\"))[\"taux_occupation\"]\n",
    "    s = s[~s.index.year.isin([2020, 2021])].asfreq(\"M\").interpolate()\n",
    "    fit = ExponentialSmoothing(s, trend=\"add\", seasonal=\"mul\", seasonal_periods=12).fit()\n",
    "    fc = fit.forecast(5).iloc[2:]\n",
    "    cells = \"  \".join(f\"{MOIS[p.month]} {v:.3f}\" for p, v in fc.items())\n",
    "    print(f\"{site:<10}{cells}\" + (\"  -> ALERTE\" if fc.max() > 0.95 else \"\"))"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Two sites above the 95 % line in January. Table sent to the bed management unit. ⟬trap:indicator_non_pii|Owner: DIM data team⟭, refreshed on ⟬date#1⟭."
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
language: mixed
fill_locale: fr_FR
domain: HR
appearance: view definition, CTE, comment, column alias, SQL WHERE
scenario: view of paid-leave balances for the self-service portal of a French HR SaaS, English comments with French aliases the portal shows as they are, replacing a contractor's working view
⟬text⟭
-- Paid-leave balances (congés payés) per employee, read by the self-service portal.
-- Rows carry the internal employee id only; the portal joins names from the directory.
-- Les alias sont en français : le portail affiche les noms de colonnes tels quels.
-- Replaces ⟬trap:code_identifier|v_conges_⦃family⦄⟭, the working view the contractor left behind.

CREATE OR REPLACE VIEW v_soldes_conges AS
WITH periode AS (
    -- période de référence : 1er juin N-1 au 31 mai N
    SELECT make_date(extract(year FROM now())::int
                     - CASE WHEN extract(month FROM now()) < 6 THEN 1 ELSE 0 END, 6, 1) AS debut
),
acquis AS (
    -- 2.5 working days per month actually worked, capped at 30 (C. trav. L3141-3)
    SELECT m.employee_id,
           LEAST(30, round(sum(2.5 * LEAST(m.days_worked, 20) / 20.0), 1)) AS jours_acquis
    FROM payroll_months m
    CROSS JOIN periode p
    WHERE m.period_start >= p.debut - interval '1 year'
      AND m.period_start <  p.debut
    GROUP BY m.employee_id
),
pris AS (
    SELECT l.employee_id, sum(l.days) AS jours_pris
    FROM leave_requests l
    JOIN leave_types t ON t.id = l.type_id
    CROSS JOIN periode p
    WHERE ⟬trap:indicator_non_pii|t.nom = 'CP'⟭
      AND l.status = 'approved'
      AND l.start_date >= p.debut
    GROUP BY l.employee_id
)
SELECT e.employee_id                                        AS matricule_interne,
       e.contract_type                                      AS type_contrat,
       COALESCE(a.jours_acquis, 0)                          AS "Jours acquis",
       COALESCE(p.jours_pris, 0)                            AS "Jours pris",
       COALESCE(a.jours_acquis, 0) - COALESCE(p.jours_pris, 0) AS "Solde",
       now()::date                                          AS calcule_le
FROM employees e
LEFT JOIN acquis a USING (employee_id)
LEFT JOIN pris p USING (employee_id)
WHERE e.status = 'active';

COMMENT ON VIEW v_soldes_conges IS 'Soldes CP de la période en cours, un enregistrement par salarié actif.';
GRANT SELECT ON v_soldes_conges TO portal_reader;
⟬end⟭
