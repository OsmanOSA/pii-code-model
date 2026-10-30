⟬template⟭
family: code
format: .ipynb
language: mixed
fill_locale: fr_FR
domain: banking
appearance: markdown cell, URL, notebook output, prose
scenario: compliance analyst's notebook with English markdown at a French bank, replaying a month of outgoing SEPA transfers against the sanctions list with a fuzzy name distance to measure the alerts a new threshold adds
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Sanctions screening backtest, outgoing SEPA transfers\n",
    "\n",
    "The screening vendor moved to a stricter fuzzy threshold on ⟬date#2⟭. We replay one month of outgoing transfers against the consolidated list with ⟬trap:eponym|Damerau-Levenshtein⟭ to estimate how many extra alerts the analysts will get."
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
       "(214877, 2093)"
      ]
     },
     "execution_count": 1,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "import pandas as pd\n",
    "from jellyfish import damerau_levenshtein_distance as dl\n",
    "from sqlalchemy import create_engine\n",
    "\n",
    "eng = create_engine(\"postgresql://aml_read:⟬url_password#1⟭@⟬hostname#1⟭:5432/paiements\")\n",
    "vir = pd.read_sql(\"SELECT ref, beneficiaire, iban_beneficiaire FROM virements_sortants WHERE date_exec >= now() - interval '30 days'\", eng)\n",
    "liste = pd.read_csv(\"⟬file_path#1⟭\", sep=\";\", usecols=[\"nom_complet\"])\n",
    "len(vir), len(liste)"
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
       "         ref    beneficiaire    iban_beneficiaire    entree_liste  distance\n",
       "0  VIR-88213  ⟬person_name#2⟭  ⟬iban#2⟭  ⟬person_name#5⟭         2\n",
       "1  VIR-90410  ⟬person_name#3⟭  ⟬iban#3⟭  ⟬person_name#6⟭         1"
      ]
     },
     "execution_count": 2,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "noms = liste[\"nom_complet\"].str.upper().tolist()\n",
    "def best(nom):\n",
    "    n = nom.upper()\n",
    "    d, entree = min((dl(n, e), e) for e in noms)\n",
    "    return pd.Series({\"entree_liste\": entree, \"distance\": d})\n",
    "hits = vir.join(vir[\"beneficiaire\"].apply(best)).query(\"distance <= 2\")\n",
    "hits"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Two hits, both false positives (the list entries carry other birth dates and nationalities). Reviewed and closed by ⟬person_name:initial#4⟭ on ⟬date#1⟭. At this volume the new threshold costs about two alerts a month: acceptable."
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
format: .ipynb
language: mixed
fill_locale: mixed
domain: healthcare
appearance: markdown cell, shell command, URL, notebook output, stream output, prose
scenario: trial data manager's notebook with English markdown and French comments comparing the Paris and Boston sites' enrolment logs with the randomisation list, cloned from the statisticians' GitLab with a token inside the clone URL
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Enrolment vs randomisation list, Paris and Boston sites\n",
    "\n",
    "The randomisation list lives in the statisticians' repository (read-only for us). We clone it and compare the arm recorded by each site with the arm on the list, before the DSMB meeting."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "metadata": {},
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "Cloning into 'rando-lists'...\n"
     ]
    }
   ],
   "source": [
    "# token de déploiement du dépôt, lecture seule\n",
    "!git clone --depth 1 https://oauth2:⟬gitlab_token#1⟭@⟬hostname#1⟭/biostat/rando-lists.git"
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
       "  subject    site  initials  birth_date  arm_log  arm_rando  investigator  investigator_email\n",
       "0   P-014   Paris  ⟬trap:initials|M.L.⟭  ⟬birth_date#2⟭        B          A  ⟬person_name#4⟭  ⟬email#4⟭\n",
       "1   B-031  Boston  ⟬trap:initials|J.K.⟭  ⟬birth_date#3⟭        A          B  ⟬person_name#5⟭  ⟬email#5⟭"
      ]
     },
     "execution_count": 2,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "import pandas as pd\n",
    "\n",
    "rando = pd.read_csv(\"rando-lists/study-204/randomisation_v3.csv\", dtype=str)\n",
    "paris = pd.read_excel(\"⟬file_path#1⟭\", dtype=str).rename(columns={\"num_sujet\": \"subject\", \"bras\": \"arm_log\", \"date_naissance\": \"birth_date\", \"initiales\": \"initials\"})\n",
    "boston = pd.read_csv(\"⟬file_path#2⟭\", dtype=str)\n",
    "logs = pd.concat([paris.assign(site=\"Paris\"), boston.assign(site=\"Boston\")])\n",
    "m = logs.merge(rando.rename(columns={\"arm\": \"arm_rando\"}), on=\"subject\")\n",
    "m[m[\"arm_log\"] != m[\"arm_rando\"]][[\"subject\", \"site\", \"initials\", \"birth_date\", \"arm_log\", \"arm_rando\", \"investigator\", \"investigator_email\"]]"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Two arm mismatches, one per site: query both investigators before the DSMB of ⟬date#1⟭. The Paris log keeps its comments in French (`commentaire_inv`); do not translate them in the query."
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
format: .ipynb
language: mixed
fill_locale: en_US
domain: HR
appearance: markdown cell, triple-quoted string, stream output, notebook output, prose
scenario: French HRIS consultant's notebook with French markdown loading a US client's employees into its new HR system through a JWT-authenticated API, with the integration's RSA key in a cell and the rejected rows in the output
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Migration SIRH US : reprise des salariés\n",
    "\n",
    "Ancien SIRH = export CSV ; nouveau = API REST avec authentification JWT bearer (clé RSA de l'intégration). On pousse par lots de 50 et on garde les rejets pour l'équipe RH US."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "metadata": {},
   "outputs": [],
   "source": [
    "import time\n",
    "import jwt\n",
    "import pandas as pd\n",
    "import requests\n",
    "\n",
    "API = \"https://⟬hostname#1⟭/api/v1\"\n",
    "CLIENT_ID = \"migration-fr-consulting\"\n",
    "# clé de l'intégration créée par le client, à supprimer de ce notebook après la reprise\n",
    "KEY = \"\"\"⟬private_key#1⟭\"\"\"\n",
    "\n",
    "def token():\n",
    "    now = int(time.time())\n",
    "    assertion = jwt.encode({\"iss\": CLIENT_ID, \"sub\": CLIENT_ID, \"aud\": API, \"iat\": now, \"exp\": now + 300}, KEY, algorithm=\"RS256\")\n",
    "    r = requests.post(f\"{API}/oauth/token\", data={\"grant_type\": \"urn:ietf:params:oauth:grant-type:jwt-bearer\", \"assertion\": assertion}, timeout=20)\n",
    "    return r.json()[\"access_token\"]"
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
      "lot 1/12 : 50 OK\n",
      "lot 2/12 : 50 OK\n",
      "lot 7/12 : 48 OK, 2 rejets\n",
      "lot 12/12 : 31 OK\n"
     ]
    }
   ],
   "source": [
    "src = pd.read_csv(\"⟬file_path#1⟭\", dtype=str)\n",
    "rejects = []\n",
    "for i in range(0, len(src), 50):\n",
    "    batch = src.iloc[i:i + 50]\n",
    "    r = requests.post(f\"{API}/workers:bulk\", json=batch.to_dict(\"records\"), headers={\"Authorization\": f\"Bearer {token()}\"}, timeout=60)\n",
    "    errs = r.json().get(\"errors\", [])\n",
    "    rejects += [{**batch.iloc[e[\"index\"]].to_dict(), \"error\": e[\"message\"]} for e in errs]\n",
    "    if errs or i in (0, 50) or i + 50 >= len(src):\n",
    "        print(f\"lot {i // 50 + 1}/{-(-len(src) // 50)} : {len(batch) - len(errs)} OK\" + (f\", {len(errs)} rejets\" if errs else \"\"))"
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
       "  employee_id   name   ssn   home_address   error\n",
       "0       10442  ⟬person_name#2⟭  ⟬us_ssn#2⟭  ⟬postal_address#2⟭  SSN already assigned to worker 10017\n",
       "1       10519  ⟬person_name#3⟭  ⟬us_ssn#3⟭  ⟬postal_address#3⟭  state code invalid for ZIP"
      ]
     },
     "execution_count": 3,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "pd.DataFrame(rejects)[[\"employee_id\", \"name\", \"ssn\", \"home_address\", \"error\"]]"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Rejet 1 : vrai doublon (réembauche), à fusionner avec l'ancien dossier. Rejet 2 : code d'État saisi à la main dans l'ancien outil. Envoyé à ⟬person_name#4⟭ (HR ops US) le ⟬date#1⟭."
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
format: .java
language: mixed
fill_locale: en_GB
domain: banking
appearance: annotation, JDBC URL, placeholder, constructor argument, comment
scenario: Spring Boot integration test with French comments for the affordability check of a French lender's UK personal loans, the shared test database password in the annotation's JDBC URL and an applicant copied from a support ticket
⟬text⟭
package fr.credit.uk.affordability;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;

/**
 * Test d'intégration du calcul d'accessibilité (prêt personnel UK).
 * Le bureau de crédit est simulé ; la base est celle de recette, partagée par l'équipe.
 */
@SpringBootTest(properties = {
        "spring.datasource.url=jdbc:postgresql://⟬hostname#1⟭:5432/affordability?user=afford_it&password=⟬url_password#1⟭",
        "bureau.base-url=http://localhost:9999",
        ⟬trap:placeholder|"bureau.api-key=${BUREAU_KEY:dummy}"⟭
})
class AffordabilityServiceIT {

    @MockBean
    CreditBureauClient bureau;

    @Autowired
    AffordabilityService service;

    @Test
    void declinesWhenDebtToIncomeIsAboveForty() {
        // dossier réel « anonymisé »... sauf l'identité, recopiée telle quelle du ticket ⟬ticket_id#1⟭
        Applicant applicant = new Applicant("⟬person_name#2⟭", "⟬birth_date#2⟭", "⟬postal_address#2⟭", 2_850_00);
        when(bureau.report(any())).thenReturn(new BureauReport(List.of(
                new Account("CREDIT_CARD", 6_200_00, 310_00),
                new Account("CAR_FINANCE", 14_800_00, 389_00)), 3, false));

        Decision decision = service.assess(applicant, 15_000_00, 60);

        assertThat(decision.outcome()).isEqualTo(Outcome.DECLINED);
        assertThat(decision.reasons()).contains("DTI_ABOVE_THRESHOLD");
    }

    @Test
    void refersWhenTheBureauHasNoFile() {
        Applicant thin = new Applicant("⟬person_name#3⟭", "⟬birth_date#3⟭", "⟬postal_address#3⟭", 1_900_00);
        when(bureau.report(any())).thenReturn(BureauReport.empty());
        assertThat(service.assess(thin, 3_000_00, 24).outcome()).isEqualTo(Outcome.REFER);
    }
}
⟬end⟭

⟬template⟭
family: code
format: .java
language: mixed
fill_locale: fr_FR
domain: HR
appearance: Javadoc, setter call, string literal, constant
scenario: payslip mailer in the English Java code of a French payroll service, encrypting each PDF with the employee's birth date as password, with the SMTP credentials inline and an example employee in the Javadoc
⟬text⟭
package fr.paie.bulletins.envoi;

import java.time.LocalDate;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.util.Locale;

import jakarta.mail.internet.MimeMessage;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

/**
 * Sends each employee's payslip by email as a password-protected PDF.
 *
 * <p>The password is the birth date as DDMMYYYY (asked by the works council: nothing to remember).
 * Exemple : ⟬person_name#1f⟭, née le ⟬birth_date#1⟭, NIR ⟬fr_social_security_number#1⟭ (imprimé sur le bulletin),
 * reçoit son bulletin à ⟬email#1⟭.
 */
@Component
public class PayslipMailer {

    // owner password: lets payroll reopen any payslip without the employee's birth date
    private static final String OWNER_PASSWORD = "⟬password#3⟭";
    private static final DateTimeFormatter PDF_PASSWORD = DateTimeFormatter.ofPattern("ddMMyyyy");

    private final JavaMailSenderImpl mail = new JavaMailSenderImpl();

    public PayslipMailer() {
        mail.setHost("⟬hostname#1⟭");
        mail.setPort(587);
        mail.setUsername("⟬email:generic#2⟭");
        // mot de passe applicatif SMTP du compte paie (TODO : le coffre)
        mail.setPassword("⟬password#2⟭");
        mail.getJavaMailProperties().put("mail.smtp.starttls.enable", "true");
    }

    static String pdfPassword(LocalDate birthDate) {
        return birthDate.format(PDF_PASSWORD);
    }

    public void send(Employee e, byte[] pdf, YearMonth period) throws Exception {
        byte[] locked = PdfLock.encrypt(pdf, pdfPassword(e.birthDate()), OWNER_PASSWORD);
        MimeMessage msg = mail.createMimeMessage();
        MimeMessageHelper h = new MimeMessageHelper(msg, true, "UTF-8");
        h.setFrom("⟬email:generic#2⟭");
        h.setTo(e.email());
        h.setSubject("Votre bulletin de paie " + period.format(DateTimeFormatter.ofPattern("MM/yyyy", Locale.FRENCH)));
        h.setText("⟬trap:indicator_non_pii|Bonjour,⟭\n\nVous trouverez ci-joint votre bulletin de paie. "
                + "Le mot de passe est votre date de naissance (JJMMAAAA).\n\nLe service paie");
        h.addAttachment("bulletin_" + period + ".pdf", new ByteArrayResource(locked));
        mail.send(msg);
    }
}
⟬end⟭

⟬template⟭
family: code
format: .java
language: mixed
fill_locale: en_GB
domain: logistics
appearance: Javadoc, text block, HTTP header, comment
scenario: AS2 sender with French comments in a French logistics company's EDI gateway, signing dispatch advices for a British retailer with a key kept in a text block until the platform HSM arrives
⟬text⟭
package fr.logistique.edi.as2;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.security.PrivateKey;
import java.security.cert.X509Certificate;

import jakarta.mail.internet.MimeBodyPart;

/**
 * Envoi AS2 des avis d'expédition (DESADV) au distributeur britannique.
 *
 * <p>Contact EDI côté distributeur : ⟬person_name#1⟭, ⟬email#1⟭, ⟬phone#1⟭ (heures UK).
 * Leur certificat public est dans resources/as2/partner.cer ; notre clé de signature est ci-dessous
 * en attendant le HSM de la plateforme (⟬ticket_id#1⟭).
 */
public class As2Sender {

    static final String AS2_FROM = "LOGIFR-EDI";
    static final String AS2_TO = "UKRETAIL-PROD";
    static final String PARTNER_URL = "https://⟬hostname#1⟭/as2/receive";

    private static final String SIGNING_KEY = """
            ⟬private_key#2⟭
            """;

    public MdnResult send(byte[] edifact, String messageId) throws Exception {
        PrivateKey key = Pem.readPrivateKey(SIGNING_KEY);
        X509Certificate ours = Pem.readCertificate(getClass().getResourceAsStream("/as2/ours.cer"));
        X509Certificate theirs = Pem.readCertificate(getClass().getResourceAsStream("/as2/partner.cer"));

        MimeBodyPart signed = Smime.sign(edifact, "application/EDIFACT", key, ours, "SHA-256");
        MimeBodyPart encrypted = Smime.encrypt(signed, theirs, "AES256_CBC");

        HttpRequest request = HttpRequest.newBuilder(URI.create(PARTNER_URL))
                .header("AS2-Version", "1.2")
                .header("AS2-From", AS2_FROM)
                .header("AS2-To", AS2_TO)
                .header("Message-ID", "<" + messageId + "@as2.logifr>")
                .header("Disposition-Notification-To", "⟬email:generic#3⟭")
                .header("Disposition-Notification-Options", "signed-receipt-protocol=optional, pkcs7-signature; signed-receipt-micalg=optional, sha-256")
                .header("Content-Type", encrypted.getContentType())
                .POST(HttpRequest.BodyPublishers.ofByteArray(Smime.bytes(encrypted)))
                .build();

        // MDN reçu pour le premier envoi : Message-ID ⟬trap:email_lookalike|<DESADV-24110371@as2.logifr>⟭, statut processed
        HttpResponse<byte[]> response = HttpClient.newHttpClient().send(request, HttpResponse.BodyHandlers.ofByteArray());
        return Mdn.parse(response.headers(), response.body());
    }
}
⟬end⟭

⟬template⟭
family: code
format: .sql
language: mixed
fill_locale: en_US
domain: banking
appearance: CREATE TABLE, view definition, SQL INSERT, comment, placeholder
scenario: migration with French comments creating the taxpayer-number vault of a French broker's US subsidiary, with a masked view for support and the broker's test accounts loaded with their SSN and ITIN
⟬text⟭
-- Coffre des TIN de la filiale courtage US : table séparée, chiffrée au repos, lue via une vue masquée.
-- Formulaires W-9 (résidents) : SSN ou ITIN. Les W-8BEN (non-résidents) n'ont pas de TIN US.

CREATE TABLE tin_vault (
    account_id          bigint PRIMARY KEY REFERENCES accounts (id),
    tin_type            text    NOT NULL CHECK (tin_type IN ('SSN', 'ITIN')),
    tin                 text    NOT NULL,
    certified_on        date    NOT NULL,
    backup_withholding  boolean NOT NULL DEFAULT false
);

CREATE VIEW tin_masked AS
SELECT account_id,
       tin_type,
       ⟬trap:placeholder|'***-**-'⟭ || right(tin, 4) AS tin_last4,
       certified_on,
       backup_withholding
FROM tin_vault;

REVOKE ALL ON tin_vault FROM support_ro;
GRANT SELECT ON tin_masked TO support_ro;

-- jeu de recette : comptes de test du courtier (cf. ⟬ticket_id#1⟭)
INSERT INTO tin_vault (account_id, tin_type, tin, certified_on) VALUES
    (900001, 'SSN',  '⟬us_ssn#1⟭',  '2024-03-12'),
    (900002, 'ITIN', '⟬us_itin#2⟭', '2024-05-02');

-- titulaires correspondants, pour la recette du formulaire 1099-B :
--   900001 : ⟬person_name#1⟭, né le ⟬birth_date#1m⟭
--   900002 : ⟬person_name#2⟭, née le ⟬birth_date#2f⟭
⟬end⟭

⟬template⟭
family: code
format: .sql
language: mixed
fill_locale: fr_FR
domain: SaaS
appearance: connection string, comment, placeholder, system view query
scenario: logical replication setup a French SaaS company's DBA wrote in English with French notes, subscribing the analytics cluster to production with the replication user's password inside the connection string
⟬text⟭
-- Logical replication from the EU production cluster to the analytics cluster.
-- The subscription's connection string holds the replication user's password, and pg_subscription
-- stores it in clear: only superusers may read that catalog (checked by ⟬person_name#1⟭, ⟬email#1⟭).

-- 1. On production
CREATE PUBLICATION analytics_pub FOR TABLE accounts, subscriptions, invoices, usage_daily;

-- 2. On analytics
CREATE SUBSCRIPTION analytics_sub
    CONNECTION 'host=⟬hostname#1⟭ port=5432 dbname=saas_prod ⟬trap:indicator_non_pii|user=repl_analytics⟭ password=⟬password#2⟭ sslmode=verify-full'
    PUBLICATION analytics_pub
    WITH (copy_data = true, streaming = on);

-- état de la réplication, à lancer côté analytics
SELECT subname, received_lsn, latest_end_lsn, last_msg_receipt_time
FROM pg_stat_subscription;

-- retard en octets, côté production
SELECT slot_name, pg_size_pretty(pg_wal_lsn_diff(pg_current_wal_lsn(), confirmed_flush_lsn)) AS retard
FROM pg_replication_slots
WHERE slot_name = 'analytics_sub';

-- rotation du mot de passe : ALTER SUBSCRIPTION analytics_sub CONNECTION '... password=⟬trap:placeholder|<nouveau>⟭ ...';
⟬end⟭

⟬template⟭
family: code
format: .sql
language: mixed
fill_locale: fr_FR
domain: logistics
appearance: SQL INSERT, comment
scenario: seed of the subcontracted cross-dock depots of a French freight network for the new season, English SQL with French data, the on-site managers and night lines that the control tower calls
⟬text⟭
-- Seed of the subcontracted cross-dock depots for the 2025 network (West and South-West).
-- English column names, French data. Night phones are called by the control tower, keep them current.

INSERT INTO partner_depots
    (code, legal_name, siret, address_line, postcode, city, manager_name, manager_phone, night_phone, dock_doors)
VALUES
    ('XD-NTE', '⟬company#1⟭', '⟬fr_siret#1⟭', '⟬fr_postal_address:street#1⟭', '⟬postcode#1⟭', '⟬city#1⟭',
     '⟬person_name#2⟭', '⟬phone#2⟭', '⟬phone#1⟭', 12),
    ('XD-BOD', '⟬company#3⟭', '⟬fr_siret#3⟭', '⟬fr_postal_address:street#3⟭', '⟬postcode#3⟭', '⟬city#3⟭',
     '⟬person_name#4⟭', '⟬phone#4⟭', '⟬phone#3⟭', 8),
    ('XD-LRH', '⟬trap:company_name|Transports ⦃Family⦄⟭', '⟬fr_siret#5⟭', '⟬fr_postal_address:street#5⟭', '⟬postcode#5⟭', '⟬city#5⟭',
     '⟬person_name#6⟭', '⟬phone#6⟭', '⟬phone#5⟭', 6);

-- XD-LRH n'ouvre qu'à partir de mars : pas d'affectation automatique avant
UPDATE partner_depots SET active_from = DATE '2025-03-01' WHERE code = 'XD-LRH';
⟬end⟭

⟬template⟭
family: code
format: .ts
language: mixed
fill_locale: en_US
domain: e-commerce
appearance: environment variable fallback, HTTP header, object literal, comment
scenario: sales-tax client with French comments in the US web store of a French homeware brand, the sandbox licence key as fallback and a support test case with the customer's delivery address in a comment
⟬text⟭
/**
 * Calcul de la sales tax US au checkout (boutique US de la marque).
 * Le prestataire veut l'adresse de livraison complète : le taux dépend de la commune, pas seulement de l'État.
 */
export type Line = { sku: string; qty: number; amount: number };
export type Address = { line1: string; city: string; postalCode: string; country: 'US' };
export type Order = { customerId: string; shipTo: Address; lines: Line[] };

const TAX_API = 'https://⟬hostname#1⟭/api/v2/transactions/create';
const ACCOUNT_ID = '2004817';
// clé de licence du compte sandbox ; celle de prod est dans le secret store
const LICENSE_KEY = process.env.TAX_LICENSE_KEY || '⟬opaque_token#1⟭';

const WAREHOUSE: Address = { line1: '⟬postal_address:street#2⟭', city: '⟬city#2⟭', postalCode: '⟬postcode#2⟭', country: 'US' };

export async function quoteTax(order: Order): Promise<number> {
  const res = await fetch(TAX_API, {
    method: 'POST',
    headers: {
      Authorization: 'Basic ' + Buffer.from(`${ACCOUNT_ID}:${LICENSE_KEY}`).toString('base64'),
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      type: 'SalesOrder',
      companyCode: 'MAISONUS',
      date: new Date().toISOString().slice(0, 10),
      customerCode: order.customerId,
      addresses: { shipFrom: WAREHOUSE, shipTo: order.shipTo },
      lines: order.lines.map((l, i) => ({ number: String(i + 1), quantity: l.qty, amount: l.amount, itemCode: l.sku })),
    }),
  });
  if (!res.ok) throw new Error(`sales tax indisponible (${res.status}) : on bloque le paiement plutôt que de deviner`);
  const body = (await res.json()) as { totalTax: number };
  return body.totalTax;
}

// Cas de test du support (commande ⟬order_number#3⟭), taux de 8,875 % attendu :
//   shipTo = ⟬postal_address#3⟭, client ⟬person_name#3⟭
⟬end⟭

⟬template⟭
family: code
format: .ts
language: mixed
fill_locale: fr_FR
domain: healthcare
appearance: function, object literal, block comment, nested JSON
scenario: TypeScript module of a French orthodontic practice software building the monthly SEPA instalment plan of a treatment, English code with French comments and a generated plan pasted as an example
⟬text⟭
// Échéancier de traitement orthodontique : mandat SEPA + prélèvements mensuels.
// The insured parent pays; the child is the patient. Reimbursement goes through the parent's NIR.
import { addMonths, format } from 'date-fns';

export type Payer = { fullName: string; iban: string; address: string; nir: string };
export type Patient = { fullName: string; birthDate: string };

export type Instalment = { dueDate: string; amountCents: number };

export function buildPlan(
  payer: Payer,
  patient: Patient,
  totalCents: number,
  months: number,
  firstDue: Date,
): { mandateRef: string; payer: Payer; patient: Patient; instalments: Instalment[] } {
  const base = Math.floor(totalCents / months);
  const last = totalCents - base * (months - 1); // le reliquat des centimes sur la dernière échéance
  const instalments = Array.from({ length: months }, (_, i) => ({
    dueDate: format(addMonths(firstDue, i), 'yyyy-MM-dd'),
    amountCents: i === months - 1 ? last : base,
  }));
  const mandateRef = `ORTHO-${format(firstDue, 'yyyyMM')}-${payer.iban.replace(/\s/g, '').slice(-6)}`;
  return { mandateRef, payer, patient, instalments };
}

/* Exemple généré pour le cabinet le ⟬date#1⟭ (semestre 1, 6 x 180 €) :
{
  "mandateRef": "ORTHO-202501-XXXXXX",
  "payer": {
    "fullName": "⟬person_name#1⟭",
    "iban": "⟬iban#1⟭",
    "address": "⟬fr_postal_address#1⟭",
    "nir": "⟬fr_social_security_number#1⟭"
  },
  "patient": { "fullName": "⟬person_name#2⟭", "birthDate": "⟬birth_date#2⟭" },
  "instalments": [{ "dueDate": "2025-01-05", "amountCents": 18000 }, "..."]
}
*/
⟬end⟭

⟬template⟭
family: code
format: .ts
language: mixed
fill_locale: mixed
domain: SaaS
appearance: CLI option default, environment variable fallback, comment, template literal
scenario: CLI with French comments that regenerates CODEOWNERS from GitLab group membership for the Paris and Austin teams of a SaaS company, with a token as default option value and the last output kept in a comment
⟬text⟭
#!/usr/bin/env node
// Régénère CODEOWNERS à partir des membres des sous-groupes GitLab (équipes Paris et Austin).
import { Command } from 'commander';
import { writeFileSync } from 'node:fs';

const program = new Command()
  .option('--group <path>', 'groupe GitLab parent', 'platform')
  .option('--host <host>', 'instance GitLab', '⟬hostname#1⟭')
  .option('--token <token>', 'token read_api', process.env.GITLAB_TOKEN ?? '⟬gitlab_token#1⟭')
  .option('--out <file>', 'fichier généré', '.gitlab/CODEOWNERS')
  .parse();

const opts = program.opts<{ group: string; host: string; token: string; out: string }>();

async function api<T>(path: string): Promise<T> {
  const res = await fetch(`https://${opts.host}/api/v4${path}`, { headers: { 'PRIVATE-TOKEN': opts.token } });
  if (!res.ok) throw new Error(`${path} : ${res.status}`);
  return res.json() as Promise<T>;
}

type Group = { id: number; path: string; description: string };
type Member = { username: string; access_level: number };

async function main() {
  const subgroups = await api<Group[]>(`/groups/${encodeURIComponent(opts.group)}/subgroups?per_page=100`);
  const lines = ['# Généré par scripts/codeowners.ts, ne pas éditer à la main', ''];
  for (const g of subgroups) {
    // la description du sous-groupe contient le chemin couvert, ex. "owns: /services/billing/"
    const path = /owns:\s*(\S+)/.exec(g.description)?.[1];
    if (!path) continue;
    const members = await api<Member[]>(`/groups/${g.id}/members?per_page=100`);
    const owners = members.filter((m) => m.access_level >= 30).map((m) => `@${m.username}`);
    lines.push(`${path.padEnd(28)} ${owners.join(' ')}`);
  }
  writeFileSync(opts.out, lines.join('\n') + '\n');
}

main();

// Sortie du ⟬date#1⟭ :
//   /services/billing/          @⟬person_name:handle#2⟭ @⟬person_name:handle#3⟭
//   /services/search/           @⟬person_name:handle#4⟭
// Owners sans compte GitLab, à inviter : ⟬person_name#5⟭ <⟬email#5⟭>
⟬end⟭

⟬template⟭
family: code
format: .py
language: mixed
fill_locale: en_US
domain: logistics
appearance: connection string, docstring, CSV row, keyword argument
scenario: Airflow DAG with French comments in a French logistics group's data platform, loading its US carriers' daily invoices, with the dev warehouse URL and its password as fallback and an invoice line in the docstring
⟬text⟭
"""DAG : import quotidien des factures des transporteurs US (CSV déposés dans S3) vers l'entrepôt de données."""
from datetime import datetime, timedelta
import os

import pandas as pd
from airflow import DAG
from airflow.operators.python import PythonOperator
from sqlalchemy import create_engine

# en local il n'y a pas de Connection Airflow : on retombe sur la base de dev
DWH_URI = os.getenv("DWH_URI", "postgresql+psycopg2://etl:⟬url_password#1⟭@⟬hostname#1⟭:5432/dwh")


def load_invoices(ds: str, **_) -> None:
    """Charge s3://carrier-invoices/{ds}/invoices.csv.

    Une ligne type (transporteur LTL, en-têtes d'origine) :
        PRO,SHIP_DATE,CONSIGNEE,CONSIGNEE_ADDR,WEIGHT_LB,CHARGES_USD
        48812093,⟬date#2⟭,"⟬person_name#3⟭","⟬postal_address#3⟭",1180,742.18

    Le destinataire et son adresse ne vont pas dans l'entrepôt : seulement le PRO et les montants.
    """
    df = pd.read_csv(f"s3://carrier-invoices/{ds}/invoices.csv", dtype={"PRO": str})
    df.columns = [c.lower() for c in df.columns]
    df = df.drop(columns=["consignee", "consignee_addr"]).assign(load_date=ds)
    df.to_sql("carrier_invoices", create_engine(DWH_URI), schema="logistics", if_exists="append", index=False)


with DAG(
    "carrier_invoices_us",
    start_date=datetime(2024, 9, 1),
    schedule="0 6 * * *",
    catchup=False,
    default_args={"retries": 2, "retry_delay": timedelta(minutes=10), ⟬trap:indicator_non_pii|"owner": "data-logistique"⟭},
    tags=["us", "transport"],
) as dag:
    PythonOperator(task_id="load_invoices", python_callable=load_invoices)
⟬end⟭

⟬template⟭
family: code
format: .py
language: mixed
fill_locale: fr_FR
domain: banking
appearance: docstring, fixed-width record, triple-quoted string, function
scenario: English Python job of a French bank producing the monthly bank-accounts declaration to the tax administration as fixed-width records with a detached signature, the declaration key copied in for the test platform
⟬text⟭
"""Monthly FICOBA declaration: openings, changes and closings of bank accounts.

Fixed-width records, then a detached signature with the bank's declaration key. English code,
French where the specification is quoted.

Record layout (positions 1-based, extract of the spec):
    001-001  type (1 = ouverture, 2 = clôture, 3 = modification)
    002-035  IBAN
    036-085  nom de naissance du titulaire
    086-125  prénoms
    126-133  date de naissance (AAAAMMJJ)
    134-253  adresse

Record from the test file accepted on ⟬date#2⟭:
    1⟬iban#1⟭  ⟬person_name:family#1⟭  ⟬person_name:given#1⟭  ⟬birth_date#1⟭  ⟬fr_postal_address#1⟭
"""
import base64
import datetime as dt
from dataclasses import dataclass
from pathlib import Path

from cryptography.hazmat.primitives import hashes, serialization
from cryptography.hazmat.primitives.asymmetric import padding

# Clé de signature des déclarations : normalement sur la carte agent, copiée ici pour la plateforme de test.
DECLARATION_KEY = """⟬private_key#2⟭"""


@dataclass
class AccountEvent:
    kind: int
    iban: str
    birth_name: str
    given_names: str
    birth_date: dt.date
    address: str


def record(e: AccountEvent) -> str:
    return (
        str(e.kind)
        + e.iban.replace(" ", "").ljust(34)
        + e.birth_name.upper().ljust(50)[:50]
        + e.given_names.upper().ljust(40)[:40]
        + e.birth_date.strftime("%Y%m%d")
        + e.address.upper().ljust(120)[:120]
    )


def sign(payload: bytes) -> str:
    key = serialization.load_pem_private_key(DECLARATION_KEY.encode(), password=None)
    return base64.b64encode(key.sign(payload, padding.PKCS1v15(), hashes.SHA256())).decode()


def build(events: list[AccountEvent], period: dt.date, out_dir: Path) -> Path:
    payload = ("\n".join(record(e) for e in events) + "\n").encode("latin-1", errors="replace")
    path = out_dir / f"FICOBA_{period:%Y%m}.txt"
    path.write_bytes(payload)
    (out_dir / f"{path.name}.sig").write_text(sign(payload))
    return path
⟬end⟭

⟬template⟭
family: code
format: .py
language: mixed
fill_locale: en_GB
domain: HR
appearance: docstring, header, form field, function
scenario: right-to-work check helper with French comments for the UK warehouse recruitment of a French logistics employer, with a completed manual passport check kept as an example in a docstring
⟬text⟭
"""Vérification du droit au travail des recrues UK, avant le premier jour.

Le service en ligne (share code) renvoie un PDF à archiver jusqu'à deux ans après la fin du contrat.
Les citoyens britanniques et irlandais n'ont pas de share code : contrôle manuel du passeport.
"""
import requests

RTW_API = "https://⟬hostname#1⟭/v1/right-to-work"
EMPLOYER = "⟬company#2⟭"


def check_share_code(share_code: str, birth_date: str, api_key: str) -> dict:
    r = requests.post(
        RTW_API,
        json={"shareCode": share_code.replace(" ", "").upper(), "dateOfBirth": birth_date, "employer": EMPLOYER},
        headers={"x-api-key": api_key},
        timeout=30,
    )
    r.raise_for_status()
    return r.json()


def manual_passport_check(candidate: dict, checked_by: str) -> dict:
    """Contrôle manuel : passeport britannique ou irlandais, copie couleur datée et signée.

    Exemple de fiche remplie (recrue de l'entrepôt de Leeds, ⟬date#1⟭) :
        nom          : ⟬person_name#3⟭
        né(e) le     : ⟬birth_date#3⟭
        passeport    : ⟬uk_passport#3⟭, expire en 2031
        vérifié par  : ⟬person_name:initial#4⟭
    """
    missing = [k for k in ("name", "birth_date", "passport_no", "expiry") if not candidate.get(k)]
    if missing:
        raise ValueError(f"fiche incomplète : {', '.join(missing)}")
    return {**candidate, "checked_by": checked_by, "method": "manual"}
⟬end⟭

⟬template⟭
family: code
format: .ipynb
language: mixed
fill_locale: fr_FR
domain: e-commerce
appearance: markdown cell, notebook output, comment
scenario: recommendation engineer's notebook with English markdown and French comments computing frequently-bought-together pairs for a French home-decor shop from order lines only, with product lines named after given names
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Frequently bought together\n",
    "\n",
    "Item-to-item ⟬trap:eponym|Jaccard⟭ similarity on the baskets of the last 90 days. Order lines only: no customer id leaves the warehouse. Pairs need at least 30 shared orders."
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
       "(388214, 6120)"
      ]
     },
     "execution_count": 1,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "import pandas as pd\n",
    "from itertools import combinations\n",
    "from collections import Counter\n",
    "\n",
    "lines = pd.read_parquet(\"⟬file_path#1⟭\", columns=[\"order_id\", \"sku\", \"libelle\"])\n",
    "lines.shape[0], lines[\"sku\"].nunique()"
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
       "                          a                               b  commun  jaccard\n",
       "0  Bougie parfumée ⟬trap:word_name|Rose⟭ ancienne  Diffuseur ⟬trap:word_name|Rose⟭ ancienne 200 ml     412    0.231\n",
       "1    Coussin ⟬trap:word_name|Camille⟭ 45x45        Plaid ⟬trap:word_name|Camille⟭ grosse maille        187    0.164\n",
       "2  Vase ⟬trap:word_name|Céleste⟭ bleu nuit         Bouquet séché eucalyptus              95    0.088"
      ]
     },
     "execution_count": 2,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "baskets = lines.groupby(\"order_id\")[\"libelle\"].apply(lambda s: sorted(set(s)))\n",
    "item_count = Counter(i for b in baskets for i in b)\n",
    "pair_count = Counter(p for b in baskets if len(b) <= 20 for p in combinations(b, 2))  # paniers B2B exclus\n",
    "rows = [(a, b, n, n / (item_count[a] + item_count[b] - n)) for (a, b), n in pair_count.items() if n >= 30]\n",
    "pairs = pd.DataFrame(rows, columns=[\"a\", \"b\", \"commun\", \"jaccard\"]).sort_values(\"jaccard\", ascending=False)\n",
    "pairs.head(3).round(3).reset_index(drop=True)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "The collections sell as sets, as expected. Next: nightly job writing the top 5 per product into `reco_bought_together`; ⟬trap:indicator_non_pii|owner: reco squad⟭, review on ⟬date#1⟭."
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
format: .java
language: mixed
fill_locale: fr_FR
domain: e-commerce
appearance: Javadoc, SQL query string, comment, constant
scenario: gapless invoice numbering service in the English Java code of a French online shop, locking one sequence row per fiscal year as French invoicing rules require, with counter sales numbered in the same series
⟬text⟭
package fr.boutique.facturation;

import java.time.Year;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

/**
 * Gapless invoice numbers per fiscal year: French rules want a continuous series, without holes.
 * Format: F{yyyy}-{000000}. One row per year in invoice_sequences, locked FOR UPDATE.
 *
 * <p>Séries F2019 à F2022 reprises telles quelles de l'ancien logiciel de caisse
 * (⟬trap:company_name|⦃Family⦄ Informatique⟭), d'où les numéros à 5 chiffres dans les archives.
 */
@Service
public class InvoiceNumbering {

    private static final String LOCK = "SELECT last_value FROM invoice_sequences WHERE fiscal_year = ? FOR UPDATE";
    private static final String BUMP = "UPDATE invoice_sequences SET last_value = ? WHERE fiscal_year = ?";
    private static final String OPEN = "INSERT INTO invoice_sequences (fiscal_year, last_value) VALUES (?, 0) ON CONFLICT DO NOTHING";

    // Ventes au comptoir sans client identifié : ⟬trap:indicator_non_pii|customerName = "CLIENT COMPTANT"⟭, même série.
    public static final String COUNTER_SALE_CUSTOMER = "CLIENT COMPTANT";

    private final JdbcTemplate jdbc;

    public InvoiceNumbering(JdbcTemplate jdbc) {
        this.jdbc = jdbc;
    }

    /** Must run in the same transaction as the invoice insert, otherwise a rollback leaves a hole. */
    @Transactional(isolation = Isolation.READ_COMMITTED)
    public String next(Year year) {
        jdbc.update(OPEN, year.getValue());
        Long last = jdbc.queryForObject(LOCK, Long.class, year.getValue());
        long value = (last == null ? 0 : last) + 1;
        jdbc.update(BUMP, value, year.getValue());
        return String.format("F%d-%06d", year.getValue(), value);
    }
}
⟬end⟭

⟬template⟭
family: code
format: .sql
language: mixed
fill_locale: fr_FR
domain: healthcare
appearance: view definition, comment, aggregate filter
scenario: quality dashboard view in English SQL with French comments for a French maternity ward, counting births and low five-minute scores per month with statistical secrecy applied
⟬text⟭
-- Maternity quality dashboard: births per month and share of low ⟬trap:eponym|Apgar⟭ scores at 5 minutes.
-- Aggregates only: no newborn or mother identifier leaves this view.
-- Pour la cadre de santé : ⟬trap:indicator_non_pii|date de naissance : tronquée au mois⟭, cellules < 5 masquées.

CREATE OR REPLACE VIEW v_maternite_indicateurs AS
SELECT date_trunc('month', n.ne_le)::date                                    AS mois,
       count(*)                                                             AS naissances,
       count(*) FILTER (WHERE n.apgar_5 < 7)                                AS apgar5_inf_7,
       round(100.0 * count(*) FILTER (WHERE n.apgar_5 < 7) / count(*), 1)   AS pct_apgar5_inf_7,
       count(*) FILTER (WHERE a.voie = 'CESARIENNE')                        AS cesariennes,
       count(*) FILTER (WHERE n.terme_sa < 37)                              AS prematures,
       percentile_cont(0.5) WITHIN GROUP (ORDER BY n.poids_g)               AS poids_median_g
FROM naissances n
JOIN accouchements a ON a.id = n.accouchement_id
WHERE n.ne_le >= date_trunc('year', now()) - interval '2 years'
GROUP BY 1
HAVING count(*) >= 5;   -- secret statistique

COMMENT ON VIEW v_maternite_indicateurs IS 'Indicateurs mensuels maternité, agrégés, lecture tableau de bord qualité';
GRANT SELECT ON v_maternite_indicateurs TO dashboard_qualite;
⟬end⟭

⟬template⟭
family: code
format: .ts
language: mixed
fill_locale: en_US
domain: SaaS
appearance: object literal, placeholder, constant, comment
scenario: message catalog of a French SaaS customer portal in French and English, with interpolation placeholders where names and invoice numbers go at render time
⟬text⟭
// Catalogue des messages de l'espace client (FR / EN), format ICU.
// Les variables entre accolades sont remplies au rendu ; ne jamais y mettre de valeur en dur.

⟬trap:indicator_non_pii|export const PASSWORD_MIN_LENGTH = 12⟭;

export const messages = {
  fr: {
    greeting: ⟬trap:placeholder|'Bonjour {firstName},'⟭,
    teamGreeting: '⟬trap:indicator_non_pii|Bonjour à tous⟭,',
    invoiceReady: 'Votre facture {invoiceNumber} est disponible dans votre espace.',
    seats: '{count, plural, one {# siège} other {# sièges}} sur votre abonnement',
    passwordRule: `Le mot de passe doit contenir au moins ${PASSWORD_MIN_LENGTH} caractères.`,
    ownerChanged: 'Le propriétaire du compte est désormais {ownerName}.',
  },
  en: {
    greeting: ⟬trap:placeholder|'Hello {firstName},'⟭,
    teamGreeting: '⟬trap:indicator_non_pii|Hi team⟭,',
    invoiceReady: 'Your invoice {invoiceNumber} is available in your account.',
    seats: '{count, plural, one {# seat} other {# seats}} on your plan',
    passwordRule: `Passwords must be at least ${PASSWORD_MIN_LENGTH} characters long.`,
    ownerChanged: 'The account owner is now {ownerName}.',
  },
} as const;

export type Locale = keyof typeof messages;
export type MessageKey = keyof (typeof messages)['fr'];

// Clés absentes d'une langue : on retombe sur l'anglais plutôt que d'afficher la clé brute.
export function message(locale: Locale, key: MessageKey): string {
  return messages[locale][key] ?? messages.en[key];
}
⟬end⟭

⟬template⟭
family: code
format: .py
language: mixed
fill_locale: fr_FR
domain: HR
appearance: docstring, function, comment, numpy array
scenario: quarterly on-call assignment script in English with French comments at a French SaaS company's HR operations, matching teams to weeks with the assignment algorithm on anonymous team identifiers
⟬text⟭
"""Affectation des semaines d'astreinte du trimestre aux équipes (pas aux personnes).

Assignment problem solved with the Hungarian algorithm (⟬trap:eponym|Kuhn-Munkres⟭, scipy). Cost = penalty
for a team taking a week it marked as unavailable, plus a small penalty for back-to-back weeks.
Replaces ⟬trap:code_identifier|planning_astreinte_⦃family⦄⟭.xlsx, maintained by hand until now.
"""
import numpy as np
from scipy.optimize import linear_sum_assignment

UNAVAILABLE = 100.0   # une semaine refusée coûte cher mais reste possible
BACK_TO_BACK = 5.0


def cost_matrix(teams: list[str], weeks: list[str], refusals: dict[str, set[str]]) -> np.ndarray:
    # une équipe peut prendre plusieurs semaines : on duplique chaque équipe autant de fois que nécessaire
    slots = -(-len(weeks) // len(teams))
    rows = [t for t in teams for _ in range(slots)]
    cost = np.zeros((len(rows), len(weeks)))
    for i, team in enumerate(rows):
        for j, week in enumerate(weeks):
            if week in refusals.get(team, set()):
                cost[i, j] = UNAVAILABLE
    return cost, rows


def assign(teams: list[str], weeks: list[str], refusals: dict[str, set[str]]) -> dict[str, str]:
    cost, rows = cost_matrix(teams, weeks, refusals)
    r, c = linear_sum_assignment(cost)
    plan = {weeks[j]: rows[i] for i, j in zip(r, c)}
    # deuxième passe : casser les semaines consécutives quand un échange ne coûte rien
    ordered = sorted(plan)
    for a, b in zip(ordered, ordered[1:]):
        if plan[a] == plan[b]:
            for other in ordered:
                if plan[other] != plan[a] and b not in refusals.get(plan[other], set()):
                    plan[b], plan[other] = plan[other], plan[b]
                    break
    return plan


if __name__ == "__main__":
    teams = ["team-api", "team-data", "team-front", "team-infra"]
    weeks = [f"2025-W{n:02d}" for n in range(1, 14)]
    print(assign(teams, weeks, {"team-data": {"2025-W01", "2025-W02"}, "team-front": {"2025-W08"}}))
⟬end⟭
