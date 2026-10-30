⟬template⟭
family: code
format: .ipynb
language: mixed
fill_locale: en_US
domain: HR
appearance: markdown cell, connection string, notebook output, prose
scenario: French HR controller's notebook with French markdown checking which employees of the US subsidiary were wrongly capped on their 401(k) catch-up contributions after a payroll migration
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# 401(k) : cotisations de rattrapage (catch-up), filiale US\n",
    "\n",
    "À partir de 50 ans dans l'année civile, un salarié peut cotiser 7 500 $ de plus que la limite standard. Depuis la migration, le prestataire paie applique la limite standard à tout le monde : on cherche qui a été bloqué à tort."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "metadata": {},
   "outputs": [],
   "source": [
    "import pandas as pd\n",
    "import pyodbc\n",
    "\n",
    "conn = pyodbc.connect(\n",
    "    \"DRIVER={ODBC Driver 18 for SQL Server};SERVER=⟬hostname#1⟭;DATABASE=payroll_us;\"\n",
    "    \"UID=fin_ro;PWD=⟬password#1⟭;Encrypt=yes\"\n",
    ")\n",
    "emp = pd.read_sql(\"SELECT emp_id, full_name, ssn, dob, ytd_401k, limit_applied FROM v_401k_ytd WHERE plan_year = 2024\", conn)"
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
       "      emp_id        full_name          ssn         dob  ytd_401k\n",
       "112  US-0418  ⟬person_name#2⟭  ⟬us_ssn#2⟭  ⟬birth_date#2⟭   23000.0\n",
       "287  US-0733  ⟬person_name#3⟭  ⟬us_ssn#3⟭  ⟬birth_date#3⟭   23000.0\n",
       "640  US-1209  ⟬person_name#4⟭  ⟬us_ssn#4⟭  ⟬birth_date#4⟭   23000.0"
      ]
     },
     "execution_count": 2,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "# âge atteint au 31/12, c'est ce qui compte pour l'IRS\n",
    "emp[\"age_fin_annee\"] = 2024 - pd.to_datetime(emp[\"dob\"]).dt.year\n",
    "bloques = emp[(emp[\"age_fin_annee\"] >= 50) & (emp[\"limit_applied\"] == 23000) & (emp[\"ytd_401k\"] >= 23000)]\n",
    "bloques[[\"emp_id\", \"full_name\", \"ssn\", \"dob\", \"ytd_401k\"]]"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Trois salariés bloqués à 23 000 $ alors qu'ils avaient droit à 30 500 $. Ticket ouvert chez le prestataire (⟬ticket_id#1⟭) le ⟬date#1⟭, copie à ⟬person_name#5⟭ (benefits). Ne pas exporter ce tableau hors du partage RH."
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
format: .ipynb
language: mixed
fill_locale: fr_FR
domain: logistics
appearance: markdown cell, constant, notebook output, comment, prose
scenario: operations analyst's notebook with English markdown at a French parcel carrier, re-geocoding the addresses of parcels returned as address not found and measuring how far from them the driver scanned the failure
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Failed deliveries, October: bad addresses or bad scans?\n",
    "\n",
    "We re-geocode the delivery address of every parcel returned with reason `ADRESSE_INTROUVABLE` and compare it with the GPS point where the driver scanned the failure. Distance with ⟬trap:eponym|Vincenty⟭'s formula, plenty at this scale."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "metadata": {},
   "outputs": [],
   "source": [
    "import pandas as pd\n",
    "import requests\n",
    "from geopy.distance import geodesic\n",
    "\n",
    "GEOCODER = \"https://⟬hostname#1⟭/search/\"\n",
    "GEOCODER_KEY = \"⟬opaque_token#1⟭\"  # clé du compte pro, quota 50k/jour\n",
    "fails = pd.read_parquet(\"⟬file_path#1⟭\")\n",
    "\n",
    "def geocode(adresse):\n",
    "    r = requests.get(GEOCODER, params={\"q\": adresse, \"limit\": 1, \"apikey\": GEOCODER_KEY}, timeout=10)\n",
    "    f = r.json()[\"features\"]\n",
    "    if not f:\n",
    "        return None, None, 0.0\n",
    "    lon, lat = f[0][\"geometry\"][\"coordinates\"]\n",
    "    return lat, lon, f[0][\"properties\"][\"score\"]"
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
       "      colis   destinataire   adresse   tel   score   dist_m\n",
       "0  6A2190441  ⟬person_name#2⟭  ⟬fr_postal_address#2⟭  ⟬phone#2⟭  0.93  4210\n",
       "1  6A2190957  ⟬person_name#3⟭  ⟬fr_postal_address#3⟭  ⟬phone#3⟭  0.88  3975\n",
       "2  6A2193318  ⟬person_name#4⟭  ⟬fr_postal_address#4⟭  ⟬phone#4⟭  0.41    38"
      ]
     },
     "execution_count": 2,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "fails[[\"lat_geo\", \"lon_geo\", \"score\"]] = fails[\"adresse\"].map(geocode).tolist()\n",
    "fails[\"dist_m\"] = fails.apply(lambda r: round(geodesic((r.lat_geo, r.lon_geo), (r.lat_scan, r.lon_scan)).m) if r.lat_geo else None, axis=1)\n",
    "fails.sort_values(\"dist_m\", ascending=False)[[\"colis\", \"destinataire\", \"adresse\", \"tel\", \"score\", \"dist_m\"]].head(3)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Rows 0 and 1: the failure was scanned more than 4 km away, i.e. from the depot, not at the door. Row 2 is a genuine address problem (score 0.41, the street number does not exist). Sent to ⟬person_name#5⟭, ops manager in ⟬city#1⟭, on ⟬date#1⟭."
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

⟬template⟭
family: code
format: .ipynb
language: mixed
fill_locale: fr_FR
domain: banking
appearance: markdown cell, stream output, JSON body, notebook output, prose
scenario: fintech developer's notebook with English markdown and French comments prototyping signed requests to a French bank's PSD2 sandbox, printing the freshly generated private key in the output and opening a consent on the test customer's IBAN
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# PSD2 sandbox: HTTP signature prototype\n",
    "\n",
    "The bank's sandbox wants every request signed (HTTP signatures, `keyId` = certificate serial) with a QSealC. For the prototype we generate a throwaway key and a self-signed certificate, which the sandbox accepts."
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
      "⟬private_key#1⟭\n"
     ]
    }
   ],
   "source": [
    "from cryptography.hazmat.primitives import serialization\n",
    "from cryptography.hazmat.primitives.asymmetric import rsa\n",
    "\n",
    "key = rsa.generate_private_key(public_exponent=65537, key_size=2048)\n",
    "pem = key.private_bytes(serialization.Encoding.PEM, serialization.PrivateFormat.TraditionalOpenSSL, serialization.NoEncryption()).decode()\n",
    "print(pem)  # pour la copier dans le portail sandbox, à enlever ensuite"
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
       "{'consentStatus': 'received',\n",
       " 'consentId': '⟬uuid#1⟭',\n",
       " '_links': {'scaRedirect': {'href': 'https://⟬hostname#1⟭/sca/⟬uuid#1⟭'}}}"
      ]
     },
     "execution_count": 2,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "import uuid\n",
    "import requests\n",
    "from signing import sign_headers  # module local, draft-cavage\n",
    "\n",
    "SANDBOX = \"https://⟬hostname#1⟭/psd2\"\n",
    "PSU_IBAN = \"⟬iban#2⟭\"  # client de test de la sandbox\n",
    "body = {\"access\": {\"accounts\": [{\"iban\": PSU_IBAN}], \"balances\": [{\"iban\": PSU_IBAN}]}, \"recurringIndicator\": True, \"validUntil\": \"2025-06-30\", \"frequencyPerDay\": 4}\n",
    "headers = sign_headers(key, {\"X-Request-ID\": str(uuid.uuid4()), \"PSU-IP-Address\": \"⟬ip_address#1⟭\"}, body)\n",
    "r = requests.post(f\"{SANDBOX}/v1/consents\", json=body, headers=headers, cert=(\"qseal.crt\", \"qseal.key\"), timeout=20)\n",
    "r.json()"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Consent received for the sandbox's test customer ⟬person_name#2⟭. Next step: follow `scaRedirect` and handle the callback."
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
format: .java
language: mixed
fill_locale: en_US
domain: SaaS
appearance: constant, text block, HTTP header, assertion, Javadoc
scenario: WireMock tests with French comments for the GitLab client of a French code-review bot, where the developer pasted a US customer's real token to reproduce a 401 and kept the customer's API responses as stubs
⟬text⟭
package fr.devtools.mrbot.gitlab;

import static com.github.tomakehurst.wiremock.client.WireMock.equalTo;
import static com.github.tomakehurst.wiremock.client.WireMock.get;
import static com.github.tomakehurst.wiremock.client.WireMock.okJson;
import static com.github.tomakehurst.wiremock.client.WireMock.post;
import static com.github.tomakehurst.wiremock.client.WireMock.stubFor;
import static com.github.tomakehurst.wiremock.client.WireMock.unauthorized;
import static com.github.tomakehurst.wiremock.client.WireMock.urlEqualTo;
import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

import com.github.tomakehurst.wiremock.junit5.WireMockTest;
import org.junit.jupiter.api.Test;

/**
 * Tests du client GitLab du bot de revue, contre WireMock.
 * Les réponses viennent du projet d'un client (Denver), anonymisées... à moitié.
 */
@WireMockTest(httpPort = 8089)
class GitLabClientTest {

    // copié depuis la conf du client pour reproduire le 401 : à remplacer par un faux token
    private static final String TOKEN = "⟬gitlab_token#1⟭";

    private final GitLabClient client = new GitLabClient("http://localhost:8089/api/v4", TOKEN);

    @Test
    void postsTheReviewCommentWithThePrivateTokenHeader() {
        stubFor(post(urlEqualTo("/api/v4/projects/412/merge_requests/87/notes"))
                .withHeader("PRIVATE-TOKEN", equalTo(TOKEN))
                .willReturn(okJson("""
                        {"id": 99121, "body": "LGTM, two remarks on the migration",
                         "author": {"username": "⟬person_name:handle#2⟭", "name": "⟬person_name#2⟭"}}
                        """)));
        Note note = client.comment(412, 87, "LGTM, two remarks on the migration");
        assertThat(note.author().name()).isEqualTo("⟬person_name#2⟭");
    }

    @Test
    void readsThePublicEmailOfTheAssignee() {
        stubFor(get(urlEqualTo("/api/v4/users/5531"))
                .willReturn(okJson("""
                        {"id": 5531, "username": "⟬person_name:handle#3⟭", "name": "⟬person_name#3⟭",
                         "public_email": "⟬email#3⟭", "state": "active"}
                        """)));
        assertThat(client.user(5531).email()).isEqualTo("⟬email#3⟭");
    }

    // client ⟬trap:company_name|⦃Family⦄ Logistics⟭ : leur proxy retire l'en-tête PRIVATE-TOKEN, d'où le 401
    @Test
    void ⟬trap:code_identifier|reproducesThe401From⦃Family⦄Logistics⟭() {
        stubFor(post(urlEqualTo("/api/v4/projects/412/merge_requests/87/notes")).willReturn(unauthorized()));
        assertThatThrownBy(() -> client.comment(412, 87, "ping"))
                .isInstanceOf(GitLabAuthException.class)
                .hasMessageContaining("vérifier le proxy");
    }
}
⟬end⟭

⟬template⟭
family: code
format: .java
language: mixed
fill_locale: fr_FR
domain: e-commerce
appearance: Javadoc, pipe-separated row, builder call, lambda, comment
scenario: Spring Batch job in the English Java code of a French online retailer exporting opted-in loyalty members to a partner as a pipe-separated file, with a sample line the partner validated and the partner's SFTP password inline
⟬text⟭
package fr.boutique.loyalty.export;

import java.time.LocalDate;

import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.item.file.FlatFileItemWriter;
import org.springframework.batch.item.file.builder.FlatFileItemWriterBuilder;
import org.springframework.batch.repeat.RepeatStatus;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.FileSystemResource;

/**
 * Nightly export of opted-in members to the loyalty partner (flat file, pipe-separated, ISO-8859-15).
 *
 * <p>Sample output line, as the partner validated it on ⟬date#2⟭:
 * <pre>
 * ⟬customer_id#1⟭|⟬person_name:family#1⟭|⟬person_name:given#1⟭|⟬email#1⟭|⟬birth_date#1⟭|⟬fr_postal_address#1⟭|1240
 * </pre>
 * The partner rejects the whole file if a field contains a pipe, hence the sanitiser in {@link MemberProcessor}.
 */
@Configuration
public class LoyaltyExportJobConfig {

    private static final String OUT = "/data/export/fidelite.txt";

    @Bean
    FlatFileItemWriter<Member> memberWriter() {
        return new FlatFileItemWriterBuilder<Member>()
                .name("memberWriter")
                .resource(new FileSystemResource(OUT))
                .encoding("ISO-8859-15")
                .delimited()
                .delimiter("|")
                .names("customerId", "nom", "prenom", "email", "dateNaissance", "adresse", "points")
                .build();
    }

    @Bean
    Tasklet uploadToPartner(SftpSessionFactory sftp) {
        return (contribution, chunkContext) -> {
            // their SFTP password changes every quarter and is given to us by phone (!), last call ⟬date#1⟭
            try (SftpSession session = sftp.open("⟬hostname#1⟭", 22, "⟬username#1⟭", "⟬password#1⟭")) {
                session.put(OUT, "/in/fidelite_" + LocalDate.now() + ".txt");
            }
            return RepeatStatus.FINISHED;
        };
    }
}
⟬end⟭

⟬template⟭
family: code
format: .java
language: mixed
fill_locale: en_US
domain: healthcare
appearance: constant, main method, constructor argument, Javadoc, comment
scenario: FHIR client with French comments that a French telehealth company wrote to create patients at a partner US clinic, with the clinic's system token in a constant and the test patient created together in main
⟬text⟭
package fr.telesante.us.fhir;

import ca.uhn.fhir.context.FhirContext;
import ca.uhn.fhir.rest.client.api.IGenericClient;
import ca.uhn.fhir.rest.client.interceptor.BearerTokenAuthInterceptor;
import org.hl7.fhir.r4.model.ContactPoint;
import org.hl7.fhir.r4.model.Enumerations.AdministrativeGender;
import org.hl7.fhir.r4.model.Patient;

/**
 * Création des patients chez la clinique partenaire via son serveur FHIR R4.
 * Le SSN n'est envoyé que si le patient l'a saisi (facturation Medicare), sinon l'identifiant interne suffit.
 */
public class PartnerPatientClient {

    private static final String BASE = "https://⟬hostname#1⟭/fhir/r4";
    // jeton « system » fourni par la clinique, valable un an (TODO : le coffre)
    private static final String BEARER = "⟬opaque_token#1⟭";
    private static final String SSN_SYSTEM = "http://hl7.org/fhir/sid/us-ssn";

    private final IGenericClient fhir;

    public PartnerPatientClient() {
        fhir = FhirContext.forR4().newRestfulGenericClient(BASE);
        fhir.registerInterceptor(new BearerTokenAuthInterceptor(BEARER));
    }

    public String create(String given, String family, AdministrativeGender gender, String ssn, String birthDate,
                         String line, String city, String zip, String phone) {
        Patient p = new Patient();
        p.addName().addGiven(given).setFamily(family);
        p.setGender(gender);
        p.getBirthDateElement().setValueAsString(birthDate);
        if (ssn != null) {
            p.addIdentifier().setSystem(SSN_SYSTEM).setValue(ssn.replace("-", ""));
        }
        p.addAddress().addLine(line).setCity(city).setPostalCode(zip).setCountry("US");
        p.addTelecom().setSystem(ContactPoint.ContactPointSystem.PHONE).setValue(phone);
        return fhir.create().resource(p).execute().getId().getIdPart();
    }

    public static void main(String[] args) {
        // patiente de test créée avec la clinique le ⟬date#1⟭ : la garder, la recette en dépend
        String id = new PartnerPatientClient().create(
                "⟬person_name:given#2f⟭", "⟬person_name:family#2⟭", AdministrativeGender.FEMALE,
                "⟬us_ssn#2⟭", "⟬birth_date#2⟭",
                "⟬postal_address:street#2⟭", "⟬city#2⟭", "⟬postcode#2⟭", "⟬phone#2⟭");
        System.out.println("Patient/" + id);
    }
}
⟬end⟭

⟬template⟭
family: code
format: .sql
language: mixed
fill_locale: en_GB
domain: e-commerce
appearance: connection string, function call, comment, SQL WHERE
scenario: migration script a French DBA wrote with French comments to pull the loyalty members of a UK web shop's old database through dblink, the migration account's password in the connection URL and a customer-service case checked at the end
⟬text⟭
-- Reprise des adhérents fidélité de l'ancienne boutique UK vers la nouvelle base.
-- dblink en lecture seule ; la chaîne de connexion contient le mot de passe du compte de reprise,
-- compte désactivé après la bascule du ⟬date#2⟭.

CREATE EXTENSION IF NOT EXISTS dblink;

INSERT INTO loyalty_members (legacy_id, email, first_name, last_name, postcode, points, joined_at)
SELECT legacy_id, lower(email), first_name, last_name, upper(postcode), points, joined_at
FROM dblink(
    'postgresql://migration_ro:⟬url_password#1⟭@⟬hostname#1⟭:5432/shop_uk_legacy',
    'SELECT entity_id, email, firstname, lastname, postcode, reward_points, created_at FROM customer_loyalty WHERE is_active'
) AS t(legacy_id int, email text, first_name text, last_name text, postcode text, points int, joined_at timestamptz)
ON CONFLICT (email) DO UPDATE SET points = GREATEST(loyalty_members.points, EXCLUDED.points);

-- Contrôle sur le cas remonté par le service client le ⟬date#1⟭ : points perdus après la bascule
SELECT m.legacy_id, m.points, a.line1, a.postcode
FROM loyalty_members m
LEFT JOIN addresses a ON a.member_id = m.id
WHERE m.email = '⟬email#3⟭';
-- attendu : ⟬person_name#3⟭, ⟬postal_address#3⟭, 1 820 points
⟬end⟭

⟬template⟭
family: code
format: .sql
language: mixed
fill_locale: en_US
domain: HR
appearance: view definition, comment, SQL UPDATE, SQL WHERE
scenario: export view with French comments for a US health benefits broker's enrollment file, merging a contractor's fix table, followed by the correction of a dependent who had been entered with the parent's SSN
⟬text⟭
-- Vue d'export vers le courtier santé US (fichier 834) : salariés + ayants droit.
-- Le courtier exige SSN et date de naissance pour chaque membre, enfants compris.
-- La table de correctifs ⟬trap:code_identifier|tmp_⦃family⦄_834_fix⟭ est intégrée ici (relationship_code), à supprimer.

CREATE OR REPLACE VIEW benefits.v_834_members AS
SELECT e.employee_id      AS subscriber_id,
       e.ssn              AS member_ssn,
       'Y'                AS subscriber_flag,
       '18'               AS relationship_code,
       e.last_name, e.first_name, e.dob, e.gender,
       c.plan_code, c.coverage_level, c.effective_date
FROM hr.employees e
JOIN benefits.coverage c ON c.employee_id = e.employee_id
WHERE c.status = 'ACTIVE'
UNION ALL
SELECT d.employee_id,
       d.ssn,
       'N',
       CASE d.relation WHEN 'SPOUSE' THEN '01' WHEN 'CHILD' THEN '19' ELSE 'G8' END,
       d.last_name, d.first_name, d.dob, d.gender,
       c.plan_code, c.coverage_level, c.effective_date
FROM benefits.dependents d
JOIN benefits.coverage c ON c.employee_id = d.employee_id
WHERE c.status = 'ACTIVE' AND d.covered;

-- Rejet du courtier du ⟬date#1⟭ : « member SSN duplicated » sur le foyer de ⟬person_name#2⟭.
-- L'enfant (né le ⟬birth_date#3⟭) avait été saisi avec le SSN du parent, ⟬us_ssn#2⟭, au lieu du sien, ⟬us_ssn#3m⟭.
UPDATE benefits.dependents
SET ssn = '⟬us_ssn#3⟭'
WHERE employee_id = 'E-20931' AND relation = 'CHILD' AND ssn = '⟬us_ssn#2⟭';

SELECT * FROM benefits.v_834_members WHERE subscriber_id = 'E-20931';
⟬end⟭

⟬template⟭
family: code
format: .sql
language: mixed
fill_locale: fr_FR
domain: healthcare
appearance: comment, SQL UPDATE, SQL INSERT, transaction
scenario: identity-vigilance script of a French hospital merging an emergency-desk duplicate into the historical patient record after qualifying the national health identity, English comments over French columns
⟬text⟭
-- Identity vigilance: merge of a duplicate patient record after INS qualification (INSi teleservice).
-- 884213 was created at the emergency desk without ID; 120577 is the historical record.
-- Run by the identity-vigilance unit only, inside one transaction, after printing both records.

BEGIN;

SELECT patient_id, nom_naissance, prenoms, date_naissance, sexe, adresse, ins_nir, ins_statut
FROM patients
WHERE patient_id IN (120577, 884213);
-- 120577 | ⟬person_name:family#1f⟭ | ⟬person_name:given#1⟭ | ⟬birth_date#1⟭ | F | ⟬fr_postal_address#1⟭ | NULL | PROVISOIRE
-- 884213 | ⟬person_name:family#1⟭ | ⟬person_name:given#1⟭ | ⟬birth_date#1⟭ | F | NULL | NULL | PROVISOIRE

UPDATE patients
SET ins_nir        = '⟬fr_social_security_number#1⟭',
    ins_oid        = '1.2.250.1.213.1.4.8',
    ins_statut     = 'QUALIFIEE',
    ins_verifie_le = now()
WHERE patient_id = 120577;

-- move stays, documents and lab results to the historical record
UPDATE sejours   SET patient_id = 120577 WHERE patient_id = 884213;
UPDATE documents SET patient_id = 120577 WHERE patient_id = 884213;
UPDATE resultats SET patient_id = 120577 WHERE patient_id = 884213;

UPDATE patients
SET actif = false, fusionne_vers = 120577, fusion_motif = 'doublon urgences, INS qualifiée'
WHERE patient_id = 884213;

INSERT INTO journal_identitovigilance (patient_id, action, auteur, commentaire, horodatage)
VALUES (120577, 'FUSION', '⟬person_name:handle#2⟭', 'fusion 884213 -> 120577 après appel INSi', now());

COMMIT;
⟬end⟭

⟬template⟭
family: code
format: .ts
language: mixed
fill_locale: fr_FR
domain: banking
appearance: function call, object literal, string literal, comment
scenario: TypeScript module of a French neobank generating the bank details PDF customers download, English code with the French labels of the document and a test call on a customer's details at the bottom
⟬text⟭
import { writeFile } from 'node:fs/promises';
import { PDFDocument, StandardFonts, rgb } from 'pdf-lib';

export type Rib = { holder: string; address: string; iban: string; bic: string; bankName: string; branch: string };

const GREY = rgb(0.42, 0.42, 0.42);
const groups = (iban: string) => iban.replace(/\s/g, '').replace(/(.{4})/g, '$1 ').trim();

// One third of an A4 page: landlords and employers print it and cut it out.
export async function ribPdf(rib: Rib): Promise<Uint8Array> {
  const pdf = await PDFDocument.create();
  const page = pdf.addPage([595, 280]);
  const font = await pdf.embedFont(StandardFonts.Helvetica);
  const bold = await pdf.embedFont(StandardFonts.HelveticaBold);

  page.drawText("Relevé d'identité bancaire", { x: 40, y: 240, size: 16, font: bold });
  page.drawText('Titulaire du compte', { x: 40, y: 205, size: 9, font, color: GREY });
  page.drawText(rib.holder, { x: 40, y: 190, size: 11, font: bold });
  page.drawText(rib.address, { x: 40, y: 175, size: 10, font });

  page.drawText('IBAN', { x: 40, y: 140, size: 9, font, color: GREY });
  page.drawText(groups(rib.iban), { x: 40, y: 125, size: 12, font: bold });
  page.drawText('BIC', { x: 40, y: 100, size: 9, font, color: GREY });
  page.drawText(rib.bic, { x: 40, y: 85, size: 12, font: bold });

  page.drawText(`Domiciliation : ${rib.bankName}, ${rib.branch}`, { x: 40, y: 50, size: 9, font, color: GREY });
  return pdf.save();
}

// npx tsx src/rib.ts  ->  out/rib-test.pdf
if (process.argv[1]?.endsWith('rib.ts')) {
  ribPdf({
    holder: '⟬person_name#1⟭',
    address: '⟬fr_postal_address#1⟭',
    iban: '⟬iban#1⟭',
    bic: '⟬bic#1⟭',
    bankName: '⟬company#2⟭',
    branch: '⟬city#2⟭',
  }).then((bytes) => writeFile('out/rib-test.pdf', bytes));
}
⟬end⟭

⟬template⟭
family: code
format: .ts
language: mixed
fill_locale: en_US
domain: SaaS
appearance: environment variable fallback, constant, HTTP header, block comment, nested JSON
scenario: Express receiver with French comments for the GitLab merge-request webhooks of a changelog bot that a French startup runs for a US customer, the bot's token hard-coded and a received event pasted at the bottom for tests
⟬text⟭
/**
 * Récepteur des webhooks GitLab (merge request events) du bot de changelog.
 * Vérifie X-Gitlab-Token, puis commente la MR avec le compte bot si la section Changelog manque.
 */
import express from 'express';
import { timingSafeEqual } from 'node:crypto';

const app = express();
app.use(express.json({ limit: '2mb' }));

const WEBHOOK_SECRET = process.env.GL_WEBHOOK_SECRET ?? '⟬opaque_token#1⟭';
// token du compte bot chez le client, en attendant leur gestionnaire de secrets
const BOT_TOKEN = '⟬gitlab_token#2⟭';
const GITLAB = 'https://⟬hostname#1⟭/api/v4';

function sameSecret(received: string | undefined, expected: string): boolean {
  if (!received || received.length !== expected.length) return false;
  return timingSafeEqual(Buffer.from(received), Buffer.from(expected));
}

app.post('/hooks/gitlab', async (req, res) => {
  if (!sameSecret(req.header('X-Gitlab-Token'), WEBHOOK_SECRET)) return res.sendStatus(401);
  const ev = req.body;
  if (ev.object_kind !== 'merge_request' || ev.object_attributes?.action !== 'open') return res.sendStatus(204);

  const { project, object_attributes: mr, user } = ev;
  if (!/^## Changelog/m.test(mr.description ?? '')) {
    await fetch(`${GITLAB}/projects/${project.id}/merge_requests/${mr.iid}/notes`, {
      method: 'POST',
      headers: { 'PRIVATE-TOKEN': BOT_TOKEN, 'Content-Type': 'application/json' },
      body: JSON.stringify({ body: `@${user.username} the "## Changelog" section is missing, see CONTRIBUTING.md.` }),
    });
  }
  res.sendStatus(200);
});

app.listen(Number(process.env.PORT ?? 3000));

/* Événement reçu le ⟬date#1⟭, gardé pour les tests :
{"object_kind":"merge_request",
 "user":{"name":"⟬person_name#3⟭","username":"⟬person_name:handle#3⟭","email":"⟬email#3⟭"},
 "project":{"id":412,"path_with_namespace":"payments/ledger"},
 "object_attributes":{"iid":87,"action":"open","description":"Fix rounding on refunds"}}
*/
⟬end⟭

⟬template⟭
family: code
format: .ts
language: mixed
fill_locale: mixed
domain: logistics
appearance: environment variable fallback, URL, object literal, function call, comment
scenario: TypeORM data source with French comments for the driver planning of a cross-Channel haulier, the shared dev database URL with its password as fallback and a seed with one French and one British driver
⟬text⟭
// data-source.ts — configuration TypeORM du planning chauffeurs (lignes Calais–Douvres)
import 'reflect-metadata';
import { DataSource } from 'typeorm';
import { Driver } from './entities/driver';

export const AppDataSource = new DataSource({
  type: 'postgres',
  // fallback de dev : base partagée de l'équipe, mot de passe en clair dans l'URL
  url: process.env.DATABASE_URL ?? 'postgres://planning:⟬url_password#1⟭@⟬hostname#1⟭:5432/planning',
  entities: [Driver],
  migrations: ['dist/migrations/*.js'],
  synchronize: false,
});

// Formats de permis acceptés par l'écran d'affectation
export const LICENCE_FORMATS: Record<'FR' | 'GB', RegExp> = {
  FR: /^(\d{12}|[0-9A-Z]{2}\d{6}[0-9A-Z]{2}\d{2})$/,
  GB: /^[A-Z9]{5}\d{6}[A-Z9]{2}\d[A-Z]{2}$/,
};

// Seed minimal : un chauffeur de chaque côté de la Manche pour tester la vérification des permis
export async function seed(): Promise<void> {
  await AppDataSource.initialize();
  const repo = AppDataSource.getRepository(Driver);
  await repo.save([
    repo.create({
      fullName: '⟬person_name#2⟭',
      country: 'FR',
      licenceNo: '⟬fr_driving_licence#2⟭',
      phone: '⟬phone#2⟭',
      depot: 'Calais',
    }),
    repo.create({
      fullName: '⟬person_name#3⟭',
      country: 'GB',
      licenceNo: '⟬uk_driving_licence#3⟭',
      phone: '⟬phone#3⟭',
      depot: 'Dover',
    }),
  ]);
  await AppDataSource.destroy();
}
⟬end⟭

⟬template⟭
family: code
format: .py
language: mixed
fill_locale: fr_FR
domain: SaaS
appearance: HTTP header, keyword argument, comment, log message
scenario: weekly backup script with French comments at a French SaaS company with a self-hosted GitLab, exporting every project through the API and pushing the archives to S3 with an admin token and access keys written inline
⟬text⟭
"""Sauvegarde hebdomadaire des exports de projets GitLab vers S3.

GitLab auto-hébergé : pas de sauvegarde par projet côté hébergeur. On demande un export par
projet (API project export), on attend qu'il soit prêt, on le pousse dans le bucket.
Remplace ⟬trap:code_identifier|backup_gitlab_⦃family⦄⟭.py, qui ne gérait pas la pagination.
"""
import time

import boto3
import requests

GITLAB = "https://⟬hostname#1⟭/api/v4"
# token admin (scope api) : nécessaire pour exporter les projets de tous les groupes
HEADERS = {"PRIVATE-TOKEN": "⟬gitlab_token#1⟭"}
BUCKET = "backup-gitlab-exports"

s3 = boto3.client(
    "s3",
    region_name="eu-west-3",
    aws_access_key_id="⟬aws_access_key_id#2⟭",
    aws_secret_access_key="⟬aws_secret_access_key#2⟭",
)


def projects():
    page = 1
    while True:
        r = requests.get(f"{GITLAB}/projects", headers=HEADERS, params={"per_page": 100, "page": page, "archived": False}, timeout=30)
        r.raise_for_status()
        batch = r.json()
        if not batch:
            return
        yield from batch
        page += 1


def export(project: dict) -> None:
    pid, path = project["id"], project["path_with_namespace"]
    requests.post(f"{GITLAB}/projects/{pid}/export", headers=HEADERS, timeout=30).raise_for_status()
    for _ in range(60):
        status = requests.get(f"{GITLAB}/projects/{pid}/export", headers=HEADERS, timeout=30).json()["export_status"]
        if status == "finished":
            break
        time.sleep(10)
    else:
        print(f"[WARN] export de {path} pas prêt après 10 min, on passe")
        return
    with requests.get(f"{GITLAB}/projects/{pid}/export/download", headers=HEADERS, stream=True, timeout=300) as r:
        r.raise_for_status()
        key = f"{time.strftime('%Y-%m-%d')}/{path}.tar.gz"
        s3.upload_fileobj(r.raw, BUCKET, key)
        print(f"[OK] {key}")


if __name__ == "__main__":
    for p in projects():
        export(p)
⟬end⟭

⟬template⟭
family: code
format: .py
language: mixed
fill_locale: en_GB
domain: healthcare
appearance: triple-quoted string, dict literal, keyword argument, docstring, comment
scenario: e-prescription sender with French comments at a French telehealth company's UK branch, signing an RS256 assertion per request with the app's private key kept in the module and a test prescription left in a helper
⟬text⟭
"""Envoi des ordonnances électroniques au réseau de pharmacies partenaire (UK).

Leur API exige un JWT signé RS256 à chaque requête (iss = notre client_id, aud = leur URL).
"""
import time
import uuid

import jwt
import requests

API = "https://⟬hostname#1⟭/eps/v2"
CLIENT_ID = "telesante-fr-uk"
# clé privée de l'appli, enregistrée chez eux le ⟬date#1⟭. À sortir dans le KMS.
PRIVATE_KEY = """⟬private_key#2⟭"""


def _assertion() -> str:
    now = int(time.time())
    claims = {"iss": CLIENT_ID, "sub": CLIENT_ID, "aud": API, "iat": now, "exp": now + 300, "jti": str(uuid.uuid4())}
    return jwt.encode(claims, PRIVATE_KEY, algorithm="RS256")


def send_prescription(rx: dict) -> str:
    r = requests.post(f"{API}/prescriptions", json=rx, headers={"Authorization": f"Bearer {_assertion()}"}, timeout=20)
    if r.status_code == 422:
        # le réseau renvoie la liste des champs refusés, on la remonte telle quelle au médecin
        raise ValueError(r.json().get("errors"))
    r.raise_for_status()
    return r.json()["prescriptionId"]


def _exemple() -> dict:
    """Ordonnance de test acceptée en recette ; patient fictif fourni par le réseau."""
    return {
        "patient": {"name": "⟬person_name#3⟭", "dateOfBirth": "⟬birth_date#3⟭", "address": "⟬postal_address#3⟭"},
        "prescriber": {"name": "Dr ⟬person_name#4⟭"},
        "items": [{"code": "39732311000001104", "dose": "1 tablet twice a day", "quantity": 28}],
        "pharmacy": "⟬company#5⟭",
    }


if __name__ == "__main__":
    print(send_prescription(_exemple()))
⟬end⟭

⟬template⟭
family: code
format: .py
language: mixed
fill_locale: mixed
domain: HR
appearance: schema example, dict literal, exception message, docstring
scenario: Pydantic models of an employer-of-record onboarding API for French and US hires, English code with French validation messages, whose OpenAPI examples carry the two sandbox hires with their national numbers
⟬text⟭
"""Onboarding payloads of the employer-of-record API (France and US hires).

The examples feed the OpenAPI page that the clients' HR teams read; they come from the two
test hires of the sandbox.
"""
from datetime import date
from typing import Literal

from pydantic import BaseModel, ConfigDict, EmailStr, Field, model_validator


class Hire(BaseModel):
    country: Literal["FR", "US"]
    first_name: str
    last_name: str
    email: EmailStr
    birth_date: date
    national_id: str = Field(description="NIR (FR, 15 caractères) ou SSN (US, 9 chiffres)")
    start_date: date
    monthly_gross: int | None = None  # FR, brut mensuel
    annual_salary: int | None = None  # US, gross per year

    model_config = ConfigDict(
        json_schema_extra={
            "examples": [
                {
                    "country": "FR",
                    "first_name": "⟬person_name:given#1⟭",
                    "last_name": "⟬person_name:family#1⟭",
                    "email": "⟬email#1⟭",
                    "birth_date": "⟬birth_date#1⟭",
                    "national_id": "⟬fr_social_security_number#1⟭",
                    "start_date": "2025-02-03",
                    "monthly_gross": 3900,
                },
                {
                    "country": "US",
                    "first_name": "⟬person_name:given#2⟭",
                    "last_name": "⟬person_name:family#2⟭",
                    "email": "⟬email#2⟭",
                    "birth_date": "⟬birth_date#2⟭",
                    "national_id": "⟬us_ssn#2⟭",
                    "start_date": "2025-02-10",
                    "annual_salary": 112000,
                },
            ]
        }
    )

    @model_validator(mode="after")
    def _pay_matches_country(self) -> "Hire":
        if self.country == "FR" and self.monthly_gross is None:
            raise ValueError("le salaire mensuel brut est obligatoire pour une embauche en France")
        if self.country == "US" and self.annual_salary is None:
            raise ValueError("annual_salary is required for a US hire")
        digits = self.national_id.replace(" ", "").replace("-", "")
        if self.country == "FR" and len(digits) != 15:
            raise ValueError("le NIR doit compter 15 caractères, clé comprise")
        if self.country == "US" and len(digits) != 9:
            raise ValueError("the SSN must have 9 digits")
        return self
⟬end⟭

⟬template⟭
family: code
format: .ipynb
language: mixed
fill_locale: fr_FR
domain: e-commerce
appearance: markdown cell, notebook output, stream output, comment
scenario: growth analyst's notebook with English markdown and French comments simulating Thompson sampling for the homepage banners of a French fashion shop's winter sale, from hourly aggregated clicks only
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Homepage banner: Thompson sampling vs fixed split\n",
    "\n",
    "Three banners for the winter sale: `neige`, `⟬trap:word_name|prune⟭` (the plum-coloured coats) and `cocooning`. Instead of a 33/33/33 A/B test we let ⟬trap:eponym|Thompson⟭ sampling (Beta-Bernoulli) move traffic to the best one. Data: hourly impressions and clicks per banner, no visitor id."
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
       "      banner                hour  impressions  clicks\n",
       "0      neige 2024-11-28 08:00:00         4210     118\n",
       "1      prune 2024-11-28 08:00:00         4187     151\n",
       "2  cocooning 2024-11-28 08:00:00         4233      97"
      ]
     },
     "execution_count": 1,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "import numpy as np\n",
    "import pandas as pd\n",
    "\n",
    "hourly = pd.read_csv(\"⟬file_path#1⟭\", parse_dates=[\"hour\"])\n",
    "hourly.head(3)"
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
      "part de trafic simulée après 72 h : {'neige': 0.21, 'prune': 0.68, 'cocooning': 0.11}\n",
      "clics gagnés vs 33/33/33 : +9.4 %\n"
     ]
    }
   ],
   "source": [
    "rng = np.random.default_rng(42)\n",
    "ctr = hourly.groupby(\"banner\").apply(lambda g: g.clicks.sum() / g.impressions.sum())\n",
    "alpha = {b: 1.0 for b in ctr.index}\n",
    "beta = {b: 1.0 for b in ctr.index}\n",
    "shown = {b: 0 for b in ctr.index}\n",
    "for _ in range(72 * 12_000):  # 12 000 affichages par heure\n",
    "    b = max(ctr.index, key=lambda k: rng.beta(alpha[k], beta[k]))\n",
    "    click = rng.random() < ctr[b]\n",
    "    alpha[b] += click; beta[b] += 1 - click; shown[b] += 1\n",
    "total = sum(shown.values())\n",
    "print(\"part de trafic simulée après 72 h :\", {b: round(n / total, 2) for b, n in shown.items()})\n",
    "gain = sum(alpha[b] - 1 for b in ctr.index) / (total * ctr.mean()) - 1\n",
    "print(f\"clics gagnés vs 33/33/33 : {gain:+.1%}\")"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "`prune` wins clearly. Proposal for the merchandising meeting of ⟬date#1⟭: switch the banner slot to the bandit for the rest of the sale, floor of 10 % per banner so that we keep learning."
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
domain: banking
appearance: annotation, placeholder, Javadoc, comment, string concatenation
scenario: Kafka consumer configuration in the English Java code of a French bank's card-fraud scoring service, with every secret injected from property placeholders and a log helper that masks card numbers
⟬text⟭
package fr.banque.cartes.fraude.config;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.kafka.clients.consumer.ConsumerConfig;
import org.apache.kafka.common.serialization.StringDeserializer;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.kafka.core.ConsumerFactory;
import org.springframework.kafka.core.DefaultKafkaConsumerFactory;
import org.springframework.kafka.support.serializer.JsonDeserializer;

/**
 * ⟬trap:library|Kafka⟭ consumer settings for the card authorisation events (topic cards.authorisations.v3).
 * Les secrets sont injectés par la plateforme : rien de sensible dans cette classe, et ça doit rester ainsi.
 */
@Configuration
public class AuthorisationConsumerConfig {

    private static final Pattern PAN = Pattern.compile("\\b\\d{13,19}\\b");

    @Bean
    ConsumerFactory<String, AuthorisationEvent> consumerFactory(
            @Value("${kafka.bootstrap-servers}") String bootstrap,
            @Value(⟬trap:placeholder|"${kafka.sasl.username}"⟭) String user,
            @Value(⟬trap:placeholder|"${kafka.sasl.password}"⟭) String password) {
        Map<String, Object> props = new HashMap<>();
        props.put(ConsumerConfig.BOOTSTRAP_SERVERS_CONFIG, bootstrap);
        props.put(ConsumerConfig.GROUP_ID_CONFIG, "fraud-scoring");
        props.put(ConsumerConfig.AUTO_OFFSET_RESET_CONFIG, "latest");
        props.put(ConsumerConfig.MAX_POLL_RECORDS_CONFIG, 500);
        props.put("security.protocol", "SASL_SSL");
        props.put("sasl.mechanism", "SCRAM-SHA-512");
        props.put("sasl.jaas.config", "org.apache.kafka.common.security.scram.ScramLoginModule required "
                + "username=\"" + user + "\" password=\"" + password + "\";");
        // désérialisation ⟬trap:library|Jackson⟭ : on fait confiance au seul package des événements cartes
        props.put(JsonDeserializer.TRUSTED_PACKAGES, "fr.banque.cartes.events");
        return new DefaultKafkaConsumerFactory<>(props, new StringDeserializer(),
                new JsonDeserializer<>(AuthorisationEvent.class));
    }

    /**
     * Masks anything that looks like a card number in a log line: 13 to 19 digits passing the ⟬trap:eponym|Luhn⟭ check
     * keep their first six and last four digits.
     */
    static String maskPans(String line) {
        Matcher m = PAN.matcher(line);
        StringBuilder out = new StringBuilder();
        while (m.find()) {
            String digits = m.group();
            String masked = luhnValid(digits)
                    ? digits.substring(0, 6) + "*".repeat(digits.length() - 10) + digits.substring(digits.length() - 4)
                    : digits;
            m.appendReplacement(out, masked);
        }
        m.appendTail(out);
        return out.toString();
    }

    private static boolean luhnValid(String digits) {
        int sum = 0;
        boolean twice = false;
        for (int i = digits.length() - 1; i >= 0; i--) {
            int d = digits.charAt(i) - '0';
            if (twice && (d *= 2) > 9) {
                d -= 9;
            }
            sum += d;
            twice = !twice;
        }
        return sum % 10 == 0;
    }
}
⟬end⟭

⟬template⟭
family: code
format: .sql
language: mixed
fill_locale: fr_FR
domain: logistics
appearance: CTE, window function, comment, SQL UPDATE
scenario: ABC classification of SKUs a French warehouse's methods engineer wrote in English SQL with French comments to re-slot the fastest movers near the dispatch docks
⟬text⟭
-- Classement ABC des références pour le réimplantage de l'entrepôt LYS1.
-- Règle de ⟬trap:eponym|Pareto⟭ : ~20 % des références font ~80 % des lignes de préparation.
-- English names: the slotting tool reads this table.

DROP TABLE IF EXISTS slotting_abc;

CREATE TABLE slotting_abc AS
WITH picks AS (
    SELECT sku,
           count(*)  AS lines,
           sum(qty)  AS units
    FROM pick_lines
    WHERE picked_at >= now() - interval '90 days'
      AND warehouse = 'LYS1'
    GROUP BY sku
),
ranked AS (
    SELECT sku, lines, units,
           sum(lines) OVER (ORDER BY lines DESC ROWS UNBOUNDED PRECEDING)::numeric
               / sum(lines) OVER () AS cum_share
    FROM picks
)
SELECT sku,
       lines,
       units,
       round(cum_share, 3) AS part_cumulee,
       CASE WHEN cum_share <= 0.80 THEN 'A'
            WHEN cum_share <= 0.95 THEN 'B'
            ELSE 'C' END    AS classe
FROM ranked;

-- Les A vont dans les allées 01 à 04 (au plus près des quais d'expédition), sauf le frais :
-- les références de l'acheteur frais restent en chambre froide quel que soit leur rang.
UPDATE slot_targets t
SET target_zone = CASE a.classe WHEN 'A' THEN 'ALLEE_01_04' WHEN 'B' THEN 'ALLEE_05_10' ELSE 'MEZZANINE' END
FROM slotting_abc a
JOIN skus s ON s.sku = a.sku
WHERE t.sku = a.sku
  AND NOT (⟬trap:indicator_non_pii|s.owner = 'achats-frais'⟭);

SELECT classe, count(*) AS refs, sum(lines) AS lignes
FROM slotting_abc
GROUP BY classe
ORDER BY classe;
⟬end⟭

⟬template⟭
family: code
format: .ts
language: mixed
fill_locale: fr_FR
domain: HR
appearance: JSDoc, object literal, function, comment
scenario: overtime calculator in the TypeScript code of a French time-tracking product, English identifiers with the French labour-law rules documented in French comments
⟬text⟭
/**
 * Heures supplémentaires, droit commun français.
 * Base : 35 h par semaine depuis la ⟬trap:eponym|loi Aubry⟭ II ; majoration de 25 % de la 36e à la 43e heure,
 * 50 % au-delà. Une convention collective peut prévoir d'autres taux : voir `overrides`.
 * Les cadres au forfait jours ne sont pas concernés (pas de décompte horaire).
 */

export type Contract =
  | { kind: 'hourly'; weeklyBase: number }
  | { kind: 'forfait-jours'; daysPerYear: number };

export type Overrides = { firstTierRate?: number; secondTierRate?: number; firstTierEnd?: number };

export type WeekResult = {
  workedHours: number;
  overtime25: number;
  overtime50: number;
  paidEquivalentHours: number;
};

const DEFAULTS = { firstTierRate: 0.25, secondTierRate: 0.5, firstTierEnd: 43 };

export function overtimeForWeek(contract: Contract, workedHours: number, overrides: Overrides = {}): WeekResult {
  // ⟬trap:indicator_non_pii|contrat : forfait-jours⟭ -> aucune heure sup, c'est voulu (ne pas « corriger »)
  if (contract.kind === 'forfait-jours') {
    return { workedHours, overtime25: 0, overtime50: 0, paidEquivalentHours: workedHours };
  }
  const { firstTierRate, secondTierRate, firstTierEnd } = { ...DEFAULTS, ...overrides };
  const base = contract.weeklyBase;
  const extra = Math.max(0, workedHours - base);
  const tier1 = Math.min(extra, Math.max(0, firstTierEnd - base));
  const tier2 = extra - tier1;
  return {
    workedHours,
    overtime25: tier1,
    overtime50: tier2,
    paidEquivalentHours: Math.min(workedHours, base) + tier1 * (1 + firstTierRate) + tier2 * (1 + secondTierRate),
  };
}

// Contingent annuel par défaut : 220 h. Au-delà, contrepartie obligatoire en repos.
export const ANNUAL_QUOTA_HOURS = 220;

export function quotaExceeded(weeks: WeekResult[]): number {
  const total = weeks.reduce((sum, w) => sum + w.overtime25 + w.overtime50, 0);
  return Math.max(0, total - ANNUAL_QUOTA_HOURS);
}
⟬end⟭

⟬template⟭
family: code
format: .py
language: mixed
fill_locale: fr_FR
domain: banking
appearance: docstring, dataclass, comment, keyword argument
scenario: FX option valuation module of a French bank's treasury, English code with French comments, pricing the USD hedges for the ALM committee with the currency version of the classic closed-form model
⟬text⟭
"""FX option valuation for the treasury hedges (USD/EUR).

⟬trap:eponym|Garman-Kohlhagen⟭ model, i.e. ⟬trap:eponym|Black-Scholes⟭ with a foreign rate. The greeks feed the
ALM committee report. Commentaires en français pour l'équipe trésorerie.
"""
import math
from dataclasses import dataclass
from statistics import NormalDist

_N = NormalDist()


@dataclass(frozen=True)
class FxOption:
    spot: float          # EUR par USD... non : USD par EUR, convention du desk
    strike: float
    years: float
    vol: float
    rate_dom: float      # taux EUR (€STR + spread)
    rate_for: float      # taux USD (SOFR + spread)
    call: bool = True
    notional: float = 1_000_000.0
    ⟬trap:indicator_non_pii|counterparty: str = "internal desk"⟭  # pas un client : couverture interne


def price(o: FxOption) -> float:
    if o.years <= 0:
        intrinsic = max(0.0, (o.spot - o.strike) if o.call else (o.strike - o.spot))
        return intrinsic * o.notional
    sqrt_t = math.sqrt(o.years)
    d1 = (math.log(o.spot / o.strike) + (o.rate_dom - o.rate_for + 0.5 * o.vol ** 2) * o.years) / (o.vol * sqrt_t)
    d2 = d1 - o.vol * sqrt_t
    df_dom, df_for = math.exp(-o.rate_dom * o.years), math.exp(-o.rate_for * o.years)
    if o.call:
        unit = o.spot * df_for * _N.cdf(d1) - o.strike * df_dom * _N.cdf(d2)
    else:
        unit = o.strike * df_dom * _N.cdf(-d2) - o.spot * df_for * _N.cdf(-d1)
    return unit * o.notional


def delta(o: FxOption, bump: float = 1e-4) -> float:
    # différence centrée : plus robuste que la formule fermée quand la maturité est très courte
    up = FxOption(**{**o.__dict__, "spot": o.spot + bump})
    down = FxOption(**{**o.__dict__, "spot": o.spot - bump})
    return (price(up) - price(down)) / (2 * bump)


if __name__ == "__main__":
    hedge = FxOption(spot=1.0842, strike=1.10, years=0.5, vol=0.072, rate_dom=0.031, rate_for=0.045)
    print(f"prix : {price(hedge):,.0f} EUR  delta : {delta(hedge):,.0f}")
⟬end⟭
