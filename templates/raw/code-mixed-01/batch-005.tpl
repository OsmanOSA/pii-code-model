⟬template⟭
family: code
format: .ipynb
language: mixed
fill_locale: en_GB
domain: banking
appearance: markdown cell, URL query string, error traceback, notebook output, prose
scenario: French credit analyst's notebook with French markdown looking into rejected Bacs direct debits at a French lender's UK subsidiary, where the first call failed off VPN and the traceback printed the bureau API key in the query string
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Prélèvements Bacs rejetés (ARUDD), octobre\n",
    "\n",
    "La filiale UK a 3 % de rejets sur les collectes du crédit conso. On récupère les rapports ARUDD sur l'API du bureau Bacs et on regarde les motifs avant le comité recouvrement."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "metadata": {},
   "outputs": [
    {
     "ename": "ConnectionError",
     "evalue": "HTTPSConnectionPool(host='⟬hostname#1⟭', port=443): Max retries exceeded with url: /v1/reports/arudd?api_key=⟬opaque_token#1⟭&from=2024-10-01 (Caused by NewConnectionError('Failed to establish a new connection: [Errno 110] Connection timed out'))",
     "output_type": "error",
     "traceback": [
      "ConnectionError                           Traceback (most recent call last)",
      "Cell In[1], line 6",
      "      3 API = \"https://⟬hostname#1⟭/v1\"",
      "      4 KEY = \"⟬opaque_token#1⟭\"",
      "----> 6 r = requests.get(f\"{API}/reports/arudd\", params={\"api_key\": KEY, \"from\": \"2024-10-01\"}, timeout=20)",
      "ConnectionError: HTTPSConnectionPool(host='⟬hostname#1⟭', port=443): Max retries exceeded with url: /v1/reports/arudd?api_key=⟬opaque_token#1⟭&from=2024-10-01"
     ]
    }
   ],
   "source": [
    "import requests\n",
    "import pandas as pd\n",
    "API = \"https://⟬hostname#1⟭/v1\"\n",
    "KEY = \"⟬opaque_token#1⟭\"\n",
    "\n",
    "r = requests.get(f\"{API}/reports/arudd\", params={\"api_key\": KEY, \"from\": \"2024-10-01\"}, timeout=20)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "VPN oublié. On relance."
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
       "        payer_name  sort_code  account_no  reason  amount_gbp\n",
       "0  ⟬person_name#2⟭   20-45-77  ⟬bank_account_number#2⟭       0      182.40\n",
       "1  ⟬person_name#3⟭   09-01-29  ⟬bank_account_number#3⟭       B      240.00\n",
       "2  ⟬person_name#4⟭   40-11-62  ⟬bank_account_number#4⟭       6       97.15"
      ]
     },
     "execution_count": 2,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "r = requests.get(f\"{API}/reports/arudd\", params={\"api_key\": KEY, \"from\": \"2024-10-01\"}, timeout=20)\n",
    "rej = pd.json_normalize(r.json()[\"items\"])\n",
    "rej[[\"payer_name\", \"sort_code\", \"account_no\", \"reason\", \"amount_gbp\"]].head(3)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Code 0 (*refer to payer*) : on re-présente une fois. Code B (compte clôturé) et 6 (pas de compte) : recouvrement. Liste envoyée à ⟬person_name#5⟭ (collections UK) le ⟬date#1⟭."
   ]
  }
 ],
 "metadata": {
  "kernelspec": {"display_name": "Python 3", "language": "python", "name": "python3"},
  "language_info": {"name": "python", "version": "3.11.5"}
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
domain: healthcare
appearance: markdown cell, URL, notebook output, prose
scenario: quality engineer's notebook with French markdown at a French medical-device maker, triaging the US complaint export for FDA reportable events, with the reporting physicians' contact details and the patients' birth dates in the output
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Réclamations US à déclarer (MDR), revue hebdo\n",
    "\n",
    "Export du CRM réclamations, instance US. Critère : décès, blessure grave, ou dysfonctionnement susceptible d'en causer une → MDR sous 30 jours calendaires (5 jours si action corrective)."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "metadata": {},
   "outputs": [],
   "source": [
    "import pandas as pd\n",
    "from sqlalchemy import create_engine, text\n",
    "\n",
    "engine = create_engine(\"postgresql://qa_reader:⟬url_password#1⟭@⟬hostname#1⟭:5432/complaints_us\")\n",
    "q = text(\"\"\"\n",
    "SELECT complaint_id, event_date, patient_initials, patient_dob, reporter_name, reporter_phone, reporter_email, narrative\n",
    "FROM complaints\n",
    "WHERE received_at >= now() - interval '7 days' AND (injury OR death OR malfunction_could_harm)\n",
    "\"\"\")\n",
    "df = pd.read_sql(q, engine)"
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
       "  complaint_id  patient_initials  patient_dob  reporter_name  reporter_phone  reporter_email  narrative\n",
       "0  CMP-24-0913  ⟬trap:initials|R.M.⟭  ⟬birth_date#2⟭  ⟬person_name#3⟭  ⟬phone#3⟭  ⟬email#3⟭  catheter tip separated during removal, retrieved, no lasting injury\n",
       "1  CMP-24-0921  ⟬trap:initials|D.K.⟭  ⟬birth_date#4⟭  ⟬person_name#5⟭  ⟬phone#5⟭  ⟬email#5⟭  pump alarm silent, overdose suspected, patient transferred to ICU"
      ]
     },
     "execution_count": 2,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "df.drop(columns=\"event_date\")"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "2 dossiers à déclarer avant le ⟬date#1⟭. CMP-24-0921 : soupçon de surdosage, on passe en 5 jours. Le Dr ⟬person_name:family#5⟭ a déjà été rappelé par ⟬person_name#6⟭ pour récupérer la pompe."
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
format: .ipynb
language: mixed
fill_locale: fr_FR
domain: e-commerce
appearance: markdown cell, HTTP header, notebook output, function, prose
scenario: analytics engineer's notebook with English markdown at a French online grocer, pulling dbt artifacts from the last GitLab CI job with a project token to list stale models and their owners before a cleanup
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Stale dbt models\n",
    "\n",
    "We download `manifest.json` from the last successful `dbt_build` job on `main` and list the models no exposure or dashboard has used for 90 days. Owners come from `meta.owner`; most of them are in the Lyon office."
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
    "\n",
    "GL = \"https://⟬hostname#1⟭/api/v4/projects/analytics%2Fdbt\"\n",
    "TOKEN = \"⟬gitlab_token#1⟭\"  # project access token, reporter role\n",
    "\n",
    "def artifact(path):\n",
    "    r = requests.get(f\"{GL}/jobs/artifacts/main/raw/{path}\", params={\"job\": \"dbt_build\"}, headers={\"PRIVATE-TOKEN\": TOKEN}, timeout=60)\n",
    "    r.raise_for_status()\n",
    "    return r.json()\n",
    "\n",
    "manifest = artifact(\"target/manifest.json\")\n",
    "usage = pd.read_csv(\"⟬file_path#1⟭\", parse_dates=[\"last_query\"])"
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
       "                       model  owner  owner_email  last_query\n",
       "0         fct_retours_legacy  ⟬person_name#2⟭  ⟬email#2⟭  2024-03-02\n",
       "1   int_paniers_abandonnes_v1  ⟬person_name#3⟭  ⟬email#3⟭  2024-01-18\n",
       "2            ⟬trap:code_identifier|rpt_ca_hebdo_⦃family⦄⟭  ⟬person_name#2⟭  ⟬email#2⟭  2023-11-27\n",
       "3        stg_newsletter_optin  ⟬trap:indicator_non_pii|data-platform⟭  ⟬email:generic#4⟭  2024-02-09"
      ]
     },
     "execution_count": 2,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "models = pd.DataFrame([\n",
    "    {\"model\": n[\"name\"], \"owner\": n[\"meta\"].get(\"owner\"), \"owner_email\": n[\"meta\"].get(\"owner_email\")}\n",
    "    for n in manifest[\"nodes\"].values() if n[\"resource_type\"] == \"model\"\n",
    "])\n",
    "stale = models.merge(usage, on=\"model\").query(\"last_query < '2024-08-01'\")\n",
    "stale.sort_values(\"last_query\").reset_index(drop=True).head(4)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Ping ⟬person_name:given#2⟭ and ⟬person_name:given#3⟭ before dropping anything. The weekly revenue report was built for a finance director who left; check with ⟬person_name#5⟭ whether anyone still reads it."
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
domain: healthcare
appearance: Javadoc, environment variable fallback, main method, string literal
scenario: JPA attribute converter in the English Java code of a French mutual health insurer, encrypting members' NIR in the database with a development key that the whole team shares as a fallback
⟬text⟭
package fr.mutuelle.adherents.crypto;

import java.nio.ByteBuffer;
import java.security.SecureRandom;
import java.util.Base64;

import javax.crypto.Cipher;
import javax.crypto.spec.GCMParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;

/**
 * Encrypts the members' NIR at rest (AES-GCM, random IV prefixed to the ciphertext).
 *
 * <p>Exemple : l'adhérent ⟬person_name#1m⟭, né le ⟬birth_date#1⟭, NIR {@code ⟬fr_social_security_number#1⟭},
 * est stocké sous la forme {@code base64(iv || chiffré || tag)}.
 *
 * <p>In production the key comes from the HSM. The development fallback below is shared by the whole team.
 */
@Converter
public class NirCipher implements AttributeConverter<String, String> {

    private static final String KEY_B64 = System.getenv().getOrDefault("NIR_KEY", "⟬opaque_token#2⟭");
    private static final int IV_LENGTH = 12;
    private static final SecureRandom RANDOM = new SecureRandom();

    private final SecretKeySpec key = new SecretKeySpec(Base64.getDecoder().decode(KEY_B64), "AES");

    @Override
    public String convertToDatabaseColumn(String nir) {
        if (nir == null) {
            return null;
        }
        try {
            byte[] iv = new byte[IV_LENGTH];
            RANDOM.nextBytes(iv);
            Cipher cipher = Cipher.getInstance("AES/GCM/NoPadding");
            cipher.init(Cipher.ENCRYPT_MODE, key, new GCMParameterSpec(128, iv));
            byte[] encrypted = cipher.doFinal(nir.replace(" ", "").getBytes());
            return Base64.getEncoder().encodeToString(ByteBuffer.allocate(iv.length + encrypted.length).put(iv).put(encrypted).array());
        } catch (Exception e) {
            throw new IllegalStateException("chiffrement du NIR impossible", e);
        }
    }

    @Override
    public String convertToEntityAttribute(String stored) {
        if (stored == null) {
            return null;
        }
        try {
            ByteBuffer buffer = ByteBuffer.wrap(Base64.getDecoder().decode(stored));
            byte[] iv = new byte[IV_LENGTH];
            buffer.get(iv);
            byte[] encrypted = new byte[buffer.remaining()];
            buffer.get(encrypted);
            Cipher cipher = Cipher.getInstance("AES/GCM/NoPadding");
            cipher.init(Cipher.DECRYPT_MODE, key, new GCMParameterSpec(128, iv));
            return new String(cipher.doFinal(encrypted));
        } catch (Exception e) {
            throw new IllegalStateException("déchiffrement du NIR impossible", e);
        }
    }

    // quick manual check, kept for the next person who touches the key rotation
    public static void main(String[] args) {
        NirCipher c = new NirCipher();
        String stored = c.convertToDatabaseColumn("⟬fr_social_security_number#1⟭");
        System.out.println(stored + " -> " + c.convertToEntityAttribute(stored));
    }
}
⟬end⟭

⟬template⟭
family: code
format: .java
language: mixed
fill_locale: en_US
domain: logistics
appearance: annotation, constructor argument, comment, factory method
scenario: Spring client a French 3PL's developer wrote with French comments for a US less-than-truckload carrier's bill-of-lading API, the shared production password left as a property default and the sample shipment that worked in testing
⟬text⟭
package fr.logisud.us.carrier;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestClient;

/**
 * Client du transporteur LTL américain : création du BOL et demande d'enlèvement.
 * Doc API sur leur portail partenaire, compte ouvert par l'équipe d'Atlanta.
 */
@Component
public class LtlCarrierClient {

    private final RestClient http;
    private final String accountNumber;

    public LtlCarrierClient(
            @Value("${carrier.ltl.base-url:https://⟬hostname#1⟭/api/v3}") String baseUrl,
            @Value("${carrier.ltl.username:⟬username#1⟭}") String username,
            // TODO retirer la valeur par défaut : c'est le mot de passe de prod du compte partagé
            @Value("${carrier.ltl.password:⟬password#1⟭}") String password,
            @Value("${carrier.ltl.account:204771}") String accountNumber) {
        this.http = RestClient.builder()
                .baseUrl(baseUrl)
                .defaultHeaders(h -> h.setBasicAuth(username, password))
                .build();
        this.accountNumber = accountNumber;
    }

    public record Party(String name, String address, String phone, String instructions) {}

    public record Handling(int count, String type, int weightLb, int nmfcClass) {}

    public record Shipment(Party shipper, Party consignee, List<Handling> units) {}

    public String createBol(Shipment s) {
        Map<String, Object> body = Map.of(
                "account", accountNumber,
                "shipper", s.shipper(),
                "consignee", s.consignee(),
                "handlingUnits", s.units(),
                "accessorials", List.of("LIFTGATE_DELIVERY", "APPOINTMENT"));
        Map<?, ?> res = http.post().uri("/bol").body(body).retrieve().body(Map.class);
        return (String) res.get("proNumber");
    }

    // Envoi qui a fonctionné en recette le ⟬date#1⟭ (2 palettes, 1180 lb, classe NMFC 70)
    static Shipment sample() {
        return new Shipment(
                new Party("⟬company#2⟭", "⟬postal_address#2⟭", "⟬phone#2⟭", null),
                new Party("⟬person_name#3⟭", "⟬postal_address#3⟭", "⟬phone#3⟭", "Call 30 min before delivery, liftgate needed"),
                List.of(new Handling(2, "PLT", 1180, 70)));
    }
}
⟬end⟭

⟬template⟭
family: code
format: .java
language: mixed
fill_locale: fr_FR
domain: banking
appearance: Javadoc, constructor argument, constant, lambda
scenario: Spring Cloud Config server customisation in a French bank's payment platform, English code with French Javadoc, authenticating to the internal GitLab with a project access token written in the source
⟬text⟭
package fr.banque.platform.config;

import org.eclipse.jgit.api.TransportConfigCallback;
import org.eclipse.jgit.transport.UsernamePasswordCredentialsProvider;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.config.server.EnableConfigServer;
import org.springframework.context.annotation.Bean;

/**
 * Config server for the payment microservices; reads the properties repositories on the internal GitLab.
 *
 * <p>Mainteneur : ⟬person_name#1⟭ (⟬email#1⟭). Le token est un project access token « read_repository »
 * qui expire tous les 12 mois : prochaine échéance le ⟬date#1⟭, penser à le renouveler AVANT.
 */
@SpringBootApplication
@EnableConfigServer
public class ConfigServerApplication {

    static final String CONFIG_REPO = "https://⟬hostname#1⟭/paiements/config-repo.git";

    public static void main(String[] args) {
        System.setProperty("spring.cloud.config.server.git.uri", CONFIG_REPO);
        System.setProperty("spring.cloud.config.server.git.default-label", "main");
        System.setProperty("spring.cloud.config.server.git.search-paths", "{application}");
        SpringApplication.run(ConfigServerApplication.class, args);
    }

    @Bean
    TransportConfigCallback gitlabCredentials() {
        // GitLab ignore le nom d'utilisateur avec un token, mais JGit refuse une valeur vide :
        // ⟬trap:indicator_non_pii|username = "oauth2"⟭ est la convention
        var credentials = new UsernamePasswordCredentialsProvider("oauth2", "⟬gitlab_token#2⟭");
        return transport -> transport.setCredentialsProvider(credentials);
    }
}
⟬end⟭

⟬template⟭
family: code
format: .java
language: mixed
fill_locale: en_GB
domain: HR
appearance: builder call, constant, assertion, Javadoc
scenario: JUnit test with French comments written by a French payroll software team for the UK Full Payment Submission mapper, with the client's test employee from its Leeds subsidiary and the HMRC test gateway credentials
⟬text⟭
package fr.paie.uk.rti;

import static org.assertj.core.api.Assertions.assertThat;

import org.junit.jupiter.api.Test;

/**
 * Tests du mapping salarié -> bloc Employee de la FPS (Full Payment Submission, RTI).
 * Salariée de test fournie par le client (filiale de Leeds), validée avec leur cabinet de paie.
 */
class FpsEmployeeMapperTest {

    // identifiants du service de test HMRC (pas ceux de prod... normalement)
    static final String GATEWAY_USER = "⟬username#1⟭";
    static final String GATEWAY_PASSWORD = "⟬password#1⟭";

    private final FpsEmployeeMapper mapper = new FpsEmployeeMapper();

    private static Employee employee() {
        return Employee.builder()
                .forename("⟬person_name:given#2f⟭")
                .surname("⟬person_name:family#2⟭")
                .nino("⟬uk_national_insurance_number#2⟭")
                .birthDate("⟬birth_date#2⟭")
                .gender('F')
                .address(Address.ofLines("⟬postal_address#2⟭"))
                .payrollId("LDS-00412")
                .taxCode("1257L")
                .build();
    }

    @Test
    void mapsTheIdentityBlock() {
        String xml = mapper.toXml(employee());
        assertThat(xml).contains("<NINO>" + employee().nino().replace(" ", "") + "</NINO>");
        assertThat(xml).contains("<Gender>F</Gender>");
        assertThat(xml).contains("<Fore>" + employee().forename() + "</Fore>");
    }

    @Test
    void sendsTheAddressWhenTheNinoIsMissing() {
        // HMRC exige l'adresse complète quand le NINO est absent (nouvel arrivant sans numéro)
        Employee noNino = employee().toBuilder().nino(null).build();
        String xml = mapper.toXml(noNino);
        assertThat(xml).doesNotContain("<NINO>");
        assertThat(xml).contains("<Address>");
    }

    @Test
    void keepsTheTaxCodeAsIs() {
        assertThat(mapper.toXml(employee())).contains("<TaxCode>1257L</TaxCode>");
    }
}
⟬end⟭

⟬template⟭
family: code
format: .sql
language: mixed
fill_locale: fr_FR
domain: banking
appearance: SQL MERGE, SQL INSERT, comment
scenario: upsert of loan applicants from a scoring partner's nightly file at a French consumer-credit fintech, English comments over French columns, with a test applicant and co-borrower left at the bottom
⟬text⟭
-- Upsert loan applicants from the scoring partner's nightly file (staging_demandeurs) into demandeurs.
-- MERGE needs PostgreSQL 15+. The test rows at the bottom must go before the release.

MERGE INTO demandeurs d
USING staging_demandeurs s
ON d.ref_dossier = s.ref_dossier AND d.rang = s.rang
WHEN MATCHED AND s.maj_le > d.maj_le THEN
    UPDATE SET nom = s.nom,
               prenom = s.prenom,
               date_naissance = s.date_naissance,
               adresse = s.adresse,
               iban_prelevement = s.iban,
               revenu_mensuel = s.revenu_mensuel,
               maj_le = s.maj_le
WHEN NOT MATCHED THEN
    INSERT (ref_dossier, rang, nom, prenom, date_naissance, adresse, iban_prelevement, revenu_mensuel, maj_le)
    VALUES (s.ref_dossier, s.rang, s.nom, s.prenom, s.date_naissance, s.adresse, s.iban, s.revenu_mensuel, s.maj_le);

-- test case: borrower (rang 1) and co-borrower (rang 2), same address, one IBAN for the instalments
INSERT INTO staging_demandeurs (ref_dossier, rang, nom, prenom, date_naissance, adresse, iban, revenu_mensuel, maj_le)
VALUES
    ('CR-T-0001', 1, '⟬person_name:family#1⟭', '⟬person_name:given#1⟭', '⟬birth_date#1⟭', '⟬fr_postal_address#1⟭', '⟬iban#1⟭', 2350.00, now()),
    ('CR-T-0001', 2, '⟬person_name:family#2⟭', '⟬person_name:given#2⟭', '⟬birth_date#2⟭', '⟬fr_postal_address#1⟭', NULL, 1980.00, now());

-- cleanup once the scoring flow is validated
-- DELETE FROM demandeurs WHERE ref_dossier LIKE 'CR-T-%';
⟬end⟭

⟬template⟭
family: code
format: .sql
language: mixed
fill_locale: fr_FR
domain: healthcare
appearance: comment, SQL WHERE, SQL INSERT, join
scenario: query the IT on-call of a French medical laboratory saved after a GP called about results never received over secure health messaging, English comments with the caller and the patient in the header
⟬text⟭
-- Results validated more than 24 h ago and still not delivered to the prescriber over MSSanté.
-- Used by the lab's IT on-call when a GP calls. Comments in English, data in French.
-- Today's call: Dr ⟬person_name#1⟭ (⟬email#1⟭) for his patient, NIR ⟬fr_social_security_number#2f⟭.

SELECT r.dossier_id,
       r.valide_le,
       p.nom_naissance,
       p.prenom,
       m.email_mssante,
       e.statut AS statut_envoi,
       e.erreur
FROM resultats r
JOIN patients p       ON p.patient_id = r.patient_id
JOIN prescripteurs m  ON m.rpps = r.rpps_prescripteur
LEFT JOIN envois_mssante e ON e.dossier_id = r.dossier_id
WHERE p.nir = '⟬fr_social_security_number#2⟭'
  AND r.valide_le < now() - interval '24 hours'
  AND (e.statut IS NULL OR e.statut <> 'ACK')
ORDER BY r.valide_le;

-- Manual re-send: the connector polls the queue every 5 minutes.
INSERT INTO file_envoi_mssante (dossier_id, destinataire, priorite)
SELECT r.dossier_id, '⟬email#1⟭', 1
FROM resultats r
JOIN patients p USING (patient_id)
WHERE p.nir = '⟬fr_social_security_number#2⟭'
  AND r.valide_le < now() - interval '24 hours';
⟬end⟭

⟬template⟭
family: code
format: .sql
language: mixed
fill_locale: en_US
domain: HR
appearance: CREATE USER, masking policy, comment, placeholder
scenario: Snowflake script a French data engineer wrote with French comments to share a US payroll table with the people analytics team, creating the service user with its password and masking the SSN column
⟬text⟭
-- Partage des données paie US avec l'équipe People Analytics.
-- Masquage du SSN : seul PAYROLL_ADMIN voit la valeur, les autres n'ont que les 4 derniers chiffres.

USE ROLE SECURITYADMIN;

CREATE USER IF NOT EXISTS PEOPLE_ANALYTICS_SVC
    PASSWORD = '⟬password#1⟭'
    DEFAULT_ROLE = PEOPLE_ANALYTICS
    DEFAULT_WAREHOUSE = ANALYTICS_XS
    MUST_CHANGE_PASSWORD = FALSE
    COMMENT = 'compte de service du dashboard, demandé par ⟬person_name#2⟭';

GRANT ROLE PEOPLE_ANALYTICS TO USER PEOPLE_ANALYTICS_SVC;

USE ROLE PAYROLL_ADMIN;

CREATE OR REPLACE MASKING POLICY payroll.pii.ssn_mask AS (val STRING) RETURNS STRING ->
    CASE
        WHEN CURRENT_ROLE() IN ('PAYROLL_ADMIN') THEN val
        ELSE ⟬trap:placeholder|'XXX-XX-'⟭ || RIGHT(val, 4)
    END;

ALTER TABLE payroll.core.employees MODIFY COLUMN ssn SET MASKING POLICY payroll.pii.ssn_mask;
GRANT SELECT ON payroll.core.employees TO ROLE PEOPLE_ANALYTICS;

-- Vérif avec les deux rôles sur le salarié de test de l'éditeur paie
USE ROLE PEOPLE_ANALYTICS;
SELECT employee_id, ssn FROM payroll.core.employees WHERE employee_id = 'E-000017';
-- attendu ici : XXX-XX- suivi des 4 derniers chiffres ; avec PAYROLL_ADMIN : ⟬us_ssn#3⟭
⟬end⟭

⟬template⟭
family: code
format: .ts
language: mixed
fill_locale: fr_FR
domain: HR
appearance: object literal, test fixture, HTTP header, template literal
scenario: NestJS end-to-end test for the expense reports of a French HR SaaS, English code, logging in with seeded employees and checking that the approved expense reaches the employee's IBAN in the SEPA export
⟬text⟭
import { INestApplication } from '@nestjs/common';
import { Test } from '@nestjs/testing';
import request from 'supertest';
import { AppModule } from '../src/app.module';

// e2e: an employee files an expense, the manager approves it, payroll exports the SEPA transfer.
// All seeded accounts share the same password (see prisma/seed.ts).
const employee = {
  email: '⟬email#1⟭',
  password: '⟬password#1⟭',
  fullName: '⟬person_name#1⟭',
  iban: '⟬iban#1⟭',
};
const manager = { email: '⟬email#2⟭', password: '⟬password#1⟭' };

describe('Notes de frais (e2e)', () => {
  let app: INestApplication;
  let employeeToken: string;
  let managerToken: string;

  const login = async (creds: { email: string; password: string }) =>
    (await request(app.getHttpServer()).post('/auth/login').send(creds).expect(200)).body.accessToken as string;

  beforeAll(async () => {
    const moduleRef = await Test.createTestingModule({ imports: [AppModule] }).compile();
    app = moduleRef.createNestApplication();
    await app.init();
    employeeToken = await login(employee);
    managerToken = await login(manager);
  });

  afterAll(() => app.close());

  it('pays the approved expense to the employee IBAN', async () => {
    const created = await request(app.getHttpServer())
      .post('/expenses')
      .set('Authorization', `Bearer ${employeeToken}`)
      .send({ label: 'Train Paris - Lyon, salon RH', amountCents: 11800, category: 'transport' })
      .expect(201);

    await request(app.getHttpServer())
      .post(`/expenses/${created.body.id}/approve`)
      .set('Authorization', `Bearer ${managerToken}`)
      .expect(200);

    const sepa = await request(app.getHttpServer())
      .get('/payroll/sepa-export?month=2024-11')
      .set('Authorization', `Bearer ${managerToken}`)
      .expect(200);

    expect(sepa.text).toContain(`<IBAN>${employee.iban.replace(/\s/g, '')}</IBAN>`);
    expect(sepa.text).toContain('<InstdAmt Ccy="EUR">118.00</InstdAmt>');
  });

  it('refuses an approval by the employee themself', async () => {
    const created = await request(app.getHttpServer())
      .post('/expenses')
      .set('Authorization', `Bearer ${employeeToken}`)
      .send({ label: 'Déjeuner client', amountCents: 4250, category: 'repas' });
    await request(app.getHttpServer())
      .post(`/expenses/${created.body.id}/approve`)
      .set('Authorization', `Bearer ${employeeToken}`)
      .expect(403);
  });
});
⟬end⟭

⟬template⟭
family: code
format: .ts
language: mixed
fill_locale: en_GB
domain: logistics
appearance: template literal, JSDoc, comment, nested JSON
scenario: TypeScript module of a French freight forwarder signing private_key_jwt client assertions for a UK port community system, the EC key pasted to unblock a demo and a held consignment's response kept in a comment
⟬text⟭
/**
 * Authentification auprès du port community system (UK) : client_credentials avec private_key_jwt.
 * La clé EC a été générée par ⟬person_name#1⟭ ; la publique est déposée sur leur portail.
 */
import { SignJWT, importPKCS8 } from 'jose';
import { randomUUID } from 'node:crypto';

const TOKEN_URL = 'https://⟬hostname#1⟭/oauth2/token';
const API_URL = 'https://⟬hostname#1⟭/cargo/v1';
const CLIENT_ID = 'transit-fr-0192';

// TODO Key Vault. Collée ici pour débloquer la démo avec le port le ⟬date#1⟭.
const CLIENT_KEY = `⟬private_key#2⟭`;

let cached: { token: string; exp: number } | undefined;

async function accessToken(): Promise<string> {
  if (cached && cached.exp > Date.now() + 30_000) return cached.token;
  const key = await importPKCS8(CLIENT_KEY, 'ES256');
  const assertion = await new SignJWT({})
    .setProtectedHeader({ alg: 'ES256' })
    .setIssuer(CLIENT_ID)
    .setSubject(CLIENT_ID)
    .setAudience(TOKEN_URL)
    .setJti(randomUUID())
    .setIssuedAt()
    .setExpirationTime('2m')
    .sign(key);
  const res = await fetch(TOKEN_URL, {
    method: 'POST',
    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
    body: new URLSearchParams({
      grant_type: 'client_credentials',
      client_assertion_type: 'urn:ietf:params:oauth:client-assertion-type:jwt-bearer',
      client_assertion: assertion,
    }),
  });
  if (!res.ok) throw new Error(`token PCS refusé : ${res.status}`);
  const body = (await res.json()) as { access_token: string; expires_in: number };
  cached = { token: body.access_token, exp: Date.now() + body.expires_in * 1000 };
  return cached.token;
}

export async function consignmentStatus(ucr: string) {
  const res = await fetch(`${API_URL}/consignments/${encodeURIComponent(ucr)}`, {
    headers: { Authorization: `Bearer ${await accessToken()}` },
  });
  return res.json();
}

// Réponse type d'un conteneur bloqué en douane :
// {"ucr":"4GB-118733-2410","status":"HOLD","reason":"DOCS_REQUIRED",
//  "consignee":{"name":"⟬person_name#3⟭","address":"⟬postal_address#3⟭"},"agent_contact":"⟬email:generic#4⟭"}
⟬end⟭

⟬template⟭
family: code
format: .py
language: mixed
fill_locale: en_US
domain: e-commerce
appearance: environment variable fallback, URL, docstring, dict literal, placeholder
scenario: Celery tasks with French comments in a French cosmetics brand's US web store, sending birthday coupons a week ahead, the test broker's password in the fallback URL and a customer record pasted in a docstring
⟬text⟭
"""Tâches Celery de la boutique US : coupons d'anniversaire.

Les clients US donnent leur date de naissance en rejoignant le programme de fidélité ;
on envoie le coupon 7 jours avant, à 9 h heure de New York.
"""
import os
import secrets
from datetime import date, timedelta

from celery import Celery
from celery.schedules import crontab

from shop.emails import send_template
from shop.models import Customer

# fallback local : le broker de recette, mot de passe en clair (désolé)
BROKER = os.getenv("CELERY_BROKER_URL", "redis://:⟬url_password#1⟭@⟬hostname#1⟭:6379/3")
⟬trap:indicator_non_pii|DOB_FORMAT = "%m/%d/%Y"⟭  # format US pour l'affichage dans le mail

app = Celery("shop_us", broker=BROKER)
app.conf.timezone = "UTC"
app.conf.beat_schedule = {
    "birthday-coupons": {"task": "shop.tasks.birthday_coupons", "schedule": crontab(hour=14, minute=0)},
}


def make_code(customer_id: int) -> str:
    return f"BDAY-{customer_id:06d}-{secrets.token_hex(3).upper()}"


def send_coupon(customer, code: str) -> None:
    """Envoie le mail via le prestataire.

    `customer` ressemble à :
        {"first_name": "⟬person_name:given#2⟭", "last_name": "⟬person_name:family#2⟭",
         "email": "⟬email#2⟭", "dob": "⟬birth_date#2⟭", "ship_to": "⟬postal_address#2⟭"}
    """
    send_template(
        to=customer.email,
        template="birthday_coupon_us",
        variables={"first_name": customer.first_name, "code": code, "valid_days": 30},
    )


@app.task
def birthday_coupons() -> int:
    target = date.today() + timedelta(days=7)
    sent = 0
    for customer in Customer.objects.filter(dob__month=target.month, dob__day=target.day, marketing_opt_in=True):
        send_coupon(customer, make_code(customer.id))
        sent += 1
    return sent
⟬end⟭

⟬template⟭
family: code
format: .py
language: mixed
fill_locale: fr_FR
domain: banking
appearance: dict literal, parameterized test, constructor argument, placeholder, docstring
scenario: pytest module in English for the estate-settlement workflow of a French retail bank, with the deceased customer's NIR and birth date, the notary's contact and two heirs' IBANs as parameters
⟬text⟭
"""Tests for the estate settlement workflow (dossiers de succession).

When a customer dies, the notary sends the deed; we freeze the accounts, compute the balance at the
date of death, then pay each heir by transfer according to the shares in the deed.
"""
from decimal import Decimal

import pytest

from succession.workflow import EstateCase, Heir, InvalidHeirIban, split_balance

DECEASED = {
    "nom": "⟬person_name:family#1⟭",
    "prenoms": "⟬person_name:given#1⟭",
    "nir": "⟬fr_social_security_number#1⟭",
    "date_naissance": "⟬birth_date#1⟭",
    "date_deces": "⟬date#2⟭",
}

NOTAIRE = {
    "nom": "Maître ⟬person_name#4⟭",
    "email": "⟬email#4⟭",
    "tel": "⟬phone#4⟭",
}


@pytest.fixture
def case():
    return EstateCase(deceased=DECEASED, notary=NOTAIRE, balance=Decimal("12400.00"), deed_received="⟬date#1⟭")


@pytest.mark.parametrize(
    "heirs, expected",
    [
        (
            [Heir("⟬person_name#2⟭", "⟬iban#2⟭", Decimal("0.5")), Heir("⟬person_name#3⟭", "⟬iban#3⟭", Decimal("0.5"))],
            [Decimal("6200.00"), Decimal("6200.00")],
        ),
        ([Heir("⟬person_name#2⟭", "⟬iban#2⟭", Decimal("1"))], [Decimal("12400.00")]),
        (
            [Heir("⟬person_name#2⟭", "⟬iban#2⟭", Decimal("2") / 3), Heir("⟬person_name#3⟭", "⟬iban#3⟭", Decimal("1") / 3)],
            [Decimal("8266.67"), Decimal("4133.33")],
        ),
    ],
)
def test_split_balance(case, heirs, expected):
    assert [p.amount for p in split_balance(case, heirs)] == expected


def test_rejects_heir_iban_with_bad_checksum():
    with pytest.raises(InvalidHeirIban):
        Heir("⟬person_name#3⟭", "⟬trap:placeholder|FR76 0000 0000 0000 0000 0000 000⟭", Decimal("1"))


def test_shares_must_sum_to_one(case):
    with pytest.raises(ValueError, match="parts"):
        split_balance(case, [Heir("⟬person_name#2⟭", "⟬iban#2⟭", Decimal("0.4"))])
⟬end⟭

⟬template⟭
family: code
format: .py
language: mixed
fill_locale: en_US
domain: SaaS
appearance: triple-quoted string, comment, argparse, shell command
scenario: licence signing script with French comments at a French software vendor selling on-premise seats to US enterprises, the Ed25519 signing key inlined since CI started running it and the last manual renewal command in a comment
⟬text⟭
"""Génère les fichiers de licence on-premise des clients entreprise US.

Usage : python sign_license.py --customer ACME --seats 250 --until 2025-12-31 > licence.lic
"""
import argparse
import base64
import json
import sys
from datetime import date

from cryptography.hazmat.primitives import serialization

# Clé de signature des licences. Elle ne devait vivre que sur le poste de release,
# mais ce script tourne aussi en CI depuis l'incident du ⟬date#2⟭.
SIGNING_KEY_PEM = b"""⟬private_key#1⟭
"""


def sign(payload: dict) -> str:
    key = serialization.load_pem_private_key(SIGNING_KEY_PEM, password=None)
    body = json.dumps(payload, separators=(",", ":"), sort_keys=True).encode()
    return base64.b64encode(body).decode() + "." + base64.b64encode(key.sign(body)).decode()


def main() -> None:
    parser = argparse.ArgumentParser(description="signe une licence on-premise")
    parser.add_argument("--customer", required=True)
    parser.add_argument("--seats", type=int, required=True)
    parser.add_argument("--until", type=date.fromisoformat, required=True)
    parser.add_argument("--contact", help="admin technique côté client, imprimé dans la licence")
    args = parser.parse_args()
    payload = {
        "customer": args.customer,
        "seats": args.seats,
        "until": args.until.isoformat(),
        "contact": args.contact,
        "edition": "enterprise",
    }
    sys.stdout.write(sign(payload) + "\n")


if __name__ == "__main__":
    main()

# Dernier renouvellement fait à la main (⟬date#1⟭) :
#   python sign_license.py --customer "⟬company#1⟭" --seats 400 --until 2026-03-31 --contact "⟬person_name#3⟭ <⟬email#3⟭>"
⟬end⟭

⟬template⟭
family: code
format: .ipynb
language: mixed
fill_locale: fr_FR
domain: HR
appearance: markdown cell, notebook output, markdown table, prose
scenario: HR analyst's notebook with English markdown computing the French gender pay equality index of a company from aggregated pay bands, before the yearly publication
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Index égalité professionnelle, year N\n",
    "\n",
    "Five indicators, scored out of 100, published before 1 March. Input is the aggregated extract from payroll (`remuneration_agregee.parquet`): one row per sex x age band x job category, with headcount and average pay. Groups under 3 people per sex are left out, as the decree requires."
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
       "  categorie  tranche_age  sexe  effectif  remu_moyenne\n",
       "0   ouvrier       <30     F        14         24310\n",
       "1   ouvrier       <30     H        52         25140\n",
       "2   employe      30-39    F        61         28920\n",
       "3   employe      30-39    H        33         29480"
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
    "agg = pd.read_parquet(\"⟬file_path#1⟭\")\n",
    "agg.head(4)"
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
      "écart de rémunération pondéré : 3.1 %  -> 36 / 40 points\n",
      "coefficient de ⟬trap:eponym|Gini⟭ (contrôle, hors index) : 0.214\n"
     ]
    }
   ],
   "source": [
    "pivot = agg.pivot_table(index=[\"categorie\", \"tranche_age\"], columns=\"sexe\", values=[\"effectif\", \"remu_moyenne\"])\n",
    "pivot = pivot[(pivot[(\"effectif\", \"F\")] >= 3) & (pivot[(\"effectif\", \"H\")] >= 3)]\n",
    "ecart = (pivot[(\"remu_moyenne\", \"H\")] - pivot[(\"remu_moyenne\", \"F\")]) / pivot[(\"remu_moyenne\", \"H\")]\n",
    "poids = pivot[(\"effectif\", \"F\")] + pivot[(\"effectif\", \"H\")]\n",
    "ecart_global = (ecart.where(ecart.abs() > 0.05, 0) * poids).sum() / poids.sum()\n",
    "points = 40 - int(np.ceil(abs(ecart_global) * 100))\n",
    "def gini(x, w):\n",
    "    order = np.argsort(x); x, w = np.asarray(x)[order], np.asarray(w)[order]\n",
    "    cum = np.cumsum(x * w) / (x * w).sum(); share = np.cumsum(w) / w.sum()\n",
    "    return 1 - np.sum((cum[1:] + cum[:-1]) * np.diff(share)) - cum[0] * share[0]\n",
    "print(f\"écart de rémunération pondéré : {abs(ecart_global) * 100:.1f} %  -> {points} / 40 points\")\n",
    "print(f\"coefficient de Gini (contrôle, hors index) : {gini(agg['remu_moyenne'], agg['effectif']):.3f}\")"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "| Indicateur | Points |\n",
    "|---|---|\n",
    "| Écart de rémunération | 36 / 40 |\n",
    "| Écart d'augmentations | 20 / 20 |\n",
    "| Écart de promotions | 15 / 15 |\n",
    "| Retour de congé maternité | 15 / 15 |\n",
    "| 10 plus hautes rémunérations | 5 / 10 |\n",
    "| **Total** | **91 / 100** |\n",
    "\n",
    "Figures checked against the payroll provider's computation on ⟬date#1⟭. ⟬trap:indicator_non_pii|Contact: the HR data team mailbox⟭, no individual figures leave this notebook."
   ]
  }
 ],
 "metadata": {
  "kernelspec": {"display_name": "Python 3", "language": "python", "name": "python3"},
  "language_info": {"name": "python", "version": "3.11.7"}
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
domain: SaaS
appearance: continuous aggregate, comment, SQL WHERE, function call
scenario: TimescaleDB migration in English SQL with French comments for the usage dashboard of a French API platform, rolling request metrics up per tenant and hour and dropping a developer's backfill table
⟬text⟭
-- Usage dashboard: hourly request counts and latency per tenant, from api_requests (hypertable).
-- Commentaires pour l'équipe support : les chiffres du tableau de bord client viennent d'ici, pas des logs.

CREATE MATERIALIZED VIEW api_usage_hourly
WITH (timescaledb.continuous) AS
SELECT tenant_id,
       time_bucket(INTERVAL '1 hour', ts)                    AS bucket,
       count(*)                                              AS requests,
       count(*) FILTER (WHERE status >= 500)                 AS errors_5xx,
       count(*) FILTER (WHERE status = 429)                  AS throttled,
       percentile_agg(latency_ms)                            AS latency_pct
FROM api_requests
-- les appels de rafraîchissement de jeton ne sont pas facturés
WHERE ⟬trap:indicator_non_pii|token_type <> 'refresh'⟭
GROUP BY tenant_id, bucket
WITH NO DATA;

SELECT add_continuous_aggregate_policy('api_usage_hourly',
    start_offset      => INTERVAL '3 days',
    end_offset        => INTERVAL '1 hour',
    schedule_interval => INTERVAL '15 minutes');

-- 13 mois de détail brut, puis seulement l'agrégat (engagement contractuel de rétention)
SELECT add_retention_policy('api_requests', INTERVAL '13 months');

-- Table de rattrapage créée à la main pendant l'incident de facturation, plus utilisée
DROP TABLE IF EXISTS ⟬trap:code_identifier|tmp_⦃family⦄_usage_backfill⟭;

-- Contrôle : p95 par tenant sur la dernière journée
SELECT tenant_id,
       sum(requests)                                         AS requests,
       approx_percentile(0.95, rollup(latency_pct))          AS p95_ms
FROM api_usage_hourly
WHERE bucket > now() - INTERVAL '1 day'
GROUP BY tenant_id
ORDER BY requests DESC
LIMIT 20;
⟬end⟭

⟬template⟭
family: code
format: .ts
language: mixed
fill_locale: fr_FR
domain: SaaS
appearance: comment, constant, HTTP header, import
scenario: token-bucket rate limiter middleware with French comments in the TypeScript API of a French SaaS, where tokens, keys and headers are only quota mechanics
⟬text⟭
import type { NextFunction, Request, Response } from 'express';
import { Redis } from '⟬trap:email_lookalike|@upstash/redis⟭';

// Seau à jetons par client API : capacité = burst autorisé, recharge = débit soutenu.
// Les « jetons » ici sont des unités de quota, rien à voir avec l'authentification.
const PLANS = {
  free: { capacity: 30, refillPerSec: 0.5 },
  team: { capacity: 120, refillPerSec: 5 },
  enterprise: { capacity: 600, refillPerSec: 40 },
} as const;

⟬trap:indicator_non_pii|const API_KEY_HEADER = 'X-Api-Key'⟭;
⟬trap:indicator_non_pii|const TOKENS_PER_REQUEST = 1⟭;

const redis = Redis.fromEnv();

// Script Lua exécuté atomiquement : lit l'état, recharge, consomme.
const TAKE = `
local cap = tonumber(ARGV[1])
local rate = tonumber(ARGV[2])
local now = tonumber(ARGV[3])
local s = redis.call('HMGET', KEYS[1], 'tokens', 'ts')
local tokens = tonumber(s[1]) or cap
local ts = tonumber(s[2]) or now
tokens = math.min(cap, tokens + (now - ts) * rate)
local ok = tokens >= 1
if ok then tokens = tokens - 1 end
redis.call('HMSET', KEYS[1], 'tokens', tokens, 'ts', now)
redis.call('EXPIRE', KEYS[1], 3600)
return { ok and 1 or 0, math.floor(tokens) }
`;

export function rateLimit(planOf: (apiKeyId: string) => Promise<keyof typeof PLANS>) {
  return async (req: Request, res: Response, next: NextFunction) => {
    const keyId = req.header(API_KEY_HEADER)?.slice(0, 12);
    if (!keyId) return res.status(401).json({ error: 'clé API manquante' });
    const plan = PLANS[await planOf(keyId)];
    const [ok, remaining] = (await redis.eval(TAKE, [`rl:${keyId}`], [
      plan.capacity,
      plan.refillPerSec,
      Date.now() / 1000,
    ])) as [number, number];
    res.setHeader('X-RateLimit-Limit', plan.capacity);
    res.setHeader('X-RateLimit-Remaining', remaining);
    if (!ok) {
      res.setHeader('Retry-After', Math.ceil(TOKENS_PER_REQUEST / plan.refillPerSec));
      return res.status(429).json({ error: 'trop de requêtes, réessayez plus tard' });
    }
    next();
  };
}
⟬end⟭

⟬template⟭
family: code
format: .ts
language: mixed
fill_locale: fr_FR
domain: logistics
appearance: object literal, enum, function, comment
scenario: carrier selection function of a French third-party logistics warehouse, English code with French comments, comparing volumetric weight against the tariff grids of regional hauliers named after their founding families
⟬text⟭
// Choix du transporteur pour un colis sortant de l'entrepôt.
// Poids taxable = max(poids réel, poids volumétrique) ; le diviseur dépend du transporteur.

export enum Carrier {
  ExpressNational = 'EXPRESS_NATIONAL',
  RegionalSud = 'REGIONAL_SUD',
  RegionalOuest = 'REGIONAL_OUEST',
  Messagerie = 'MESSAGERIE',
}

type Grid = { label: string; divisor: number; zones: string[]; brackets: Array<[maxKg: number, priceEur: number]> };

const GRIDS: Record<Carrier, Grid> = {
  [Carrier.ExpressNational]: {
    label: 'Express national',
    divisor: 5000,
    zones: ['*'],
    brackets: [[1, 7.9], [5, 11.4], [10, 15.8], [30, 27.5]],
  },
  [Carrier.RegionalSud]: {
    label: '⟬trap:company_name|Transports ⦃Family⦄⟭',
    divisor: 4000,
    zones: ['13', '30', '34', '84', '83', '06'],
    brackets: [[5, 6.2], [20, 9.9], [50, 16.4], [100, 24.0]],
  },
  [Carrier.RegionalOuest]: {
    label: '⟬trap:company_name|⦃Family2⦄ & Fils⟭',
    divisor: 4000,
    zones: ['29', '35', '44', '49', '56', '85'],
    brackets: [[5, 6.5], [20, 10.2], [50, 17.1], [100, 25.3]],
  },
  [Carrier.Messagerie]: {
    label: 'Messagerie palette',
    divisor: 3000,
    zones: ['*'],
    brackets: [[100, 38], [300, 72], [1000, 155]],
  },
};

export type Parcel = { weightKg: number; lengthCm: number; widthCm: number; heightCm: number; postcode: string };

function taxableKg(p: Parcel, divisor: number): number {
  const volumetric = (p.lengthCm * p.widthCm * p.heightCm) / divisor;
  return Math.max(p.weightKg, volumetric);
}

function price(grid: Grid, kg: number): number | undefined {
  return grid.brackets.find(([max]) => kg <= max)?.[1];
}

/** Moins cher d'abord ; à prix égal, le régional (meilleur taux de livraison au premier passage). */
export function chooseCarrier(p: Parcel): { carrier: Carrier; label: string; priceEur: number } | undefined {
  const dept = p.postcode.slice(0, 2);
  const offers = (Object.entries(GRIDS) as Array<[Carrier, Grid]>)
    .filter(([, g]) => g.zones.includes('*') || g.zones.includes(dept))
    .map(([carrier, g]) => ({ carrier, label: g.label, priceEur: price(g, taxableKg(p, g.divisor)) }))
    .filter((o): o is { carrier: Carrier; label: string; priceEur: number } => o.priceEur !== undefined)
    .sort((a, b) => a.priceEur - b.priceEur || Number(a.carrier.startsWith('REGIONAL')) * -1);
  return offers[0];
}

// Exemple : colis 60x40x40, 8 kg, vers ⟬postcode#1⟭ (⟬city#1⟭) -> poids volumétrique 24 kg chez le régional.
⟬end⟭

⟬template⟭
family: code
format: .py
language: mixed
fill_locale: fr_FR
domain: e-commerce
appearance: docstring, doctest, function, comment
scenario: slug helper of a French fashion and wine web shop, English code with French product names in the doctests, several of which carry words that are also given names
⟬text⟭
"""URL slugs for product pages, shared by the French and UK stores.

Product names are written by the merchandising team in French; the UK store keeps the French
slug so that hreflang pairs match.

>>> slugify("Robe ⟬trap:word_name|Rose⟭ poudré - taille 38")
'robe-rose-poudre-taille-38'
>>> slugify("Château ⟬trap:word_name|Margaux⟭ 2015, 75 cl")
'chateau-margaux-2015-75-cl'
>>> slugify("Bague ⟬trap:word_name|Céleste⟭ or 18 carats")
'bague-celeste-or-18-carats'
"""
import re
import unicodedata

_MAX_LEN = 80
# mots vides retirés seulement s'il reste au moins trois mots
_STOP = {"de", "du", "des", "la", "le", "les", "et", "en", "the", "of", "and"}


def _ascii(text: str) -> str:
    return unicodedata.normalize("NFKD", text).encode("ascii", "ignore").decode()


def slugify(name: str, *, drop_stopwords: bool = False) -> str:
    """Lowercase ASCII words joined by dashes, cut on a word boundary.

    >>> slugify("Coffret découverte : 3 parfums", drop_stopwords=True)
    'coffret-decouverte-3-parfums'
    >>> slugify("  --  ")
    ''
    """
    words = re.findall(r"[a-z0-9]+", _ascii(name).lower())
    if drop_stopwords and len([w for w in words if w not in _STOP]) >= 3:
        words = [w for w in words if w not in _STOP]
    slug = ""
    for word in words:
        candidate = f"{slug}-{word}" if slug else word
        if len(candidate) > _MAX_LEN:
            break
        slug = candidate
    return slug


def unique(slug: str, taken: set[str]) -> str:
    """Append -2, -3... when the slug already exists.

    >>> unique("robe-rose", {"robe-rose", "robe-rose-2"})
    'robe-rose-3'
    """
    if slug not in taken:
        return slug
    n = 2
    while f"{slug}-{n}" in taken:
        n += 1
    return f"{slug}-{n}"
⟬end⟭
