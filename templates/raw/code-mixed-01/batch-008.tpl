⟬template⟭
family: code
format: .ipynb
language: mixed
fill_locale: en_GB
domain: logistics
appearance: markdown cell, URL, notebook output, prose
scenario: French transport manager's notebook with French markdown investigating a cold-chain break on a British delivery round, crossing the reefer telemetry with the delivery scans and naming the driver in the conclusion
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Rupture de chaîne du froid, tournée Manchester du ⟬date#2⟭\n",
    "\n",
    "Le magasin a refusé 6 rolls de frais (9,4 °C à réception). On croise la télémétrie du groupe froid (sondes toutes les 5 min) avec les scans de livraison pour savoir à quel arrêt la porte est restée ouverte."
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
    "tele = create_engine(\"postgresql://fleet_ro:⟬url_password#1⟭@⟬hostname#1⟭:5432/telematics\")\n",
    "temp = pd.read_sql(\"SELECT ts, probe, temp_c, door_open FROM reefer_readings WHERE vehicle = %(v)s AND ts::date = %(d)s\", tele, params={\"v\": \"MX24-RFR\", \"d\": \"2024-11-14\"})\n",
    "stops = pd.read_csv(\"⟬file_path#1⟭\", parse_dates=[\"arrived\", \"left\"])"
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
       "   stop        site                      address  arrived  door_open_min  max_temp_c\n",
       "3     4  Store 1187  ⟬postal_address#3⟭    06:42             23         9.4\n",
       "4     5  Store 1203  ⟬postal_address#4⟭    07:31              6         5.1"
      ]
     },
     "execution_count": 2,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "def window(row):\n",
    "    w = temp[(temp.ts >= row.arrived) & (temp.ts <= row.left)]\n",
    "    return pd.Series({\"door_open_min\": int(w.door_open.sum() * 5), \"max_temp_c\": w.temp_c.max()})\n",
    "res = stops.join(stops.apply(window, axis=1))\n",
    "res[res.max_temp_c > 5][[\"stop\", \"site\", \"address\", \"arrived\", \"door_open_min\", \"max_temp_c\"]]"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Porte ouverte 23 min à l'arrêt 4 : le chauffeur (⟬person_name#5⟭, ⟬phone#5⟭) attendait le réceptionnaire, moteur coupé. Debrief avec lui et son chef d'équipe ⟬person_name#6⟭ le ⟬date#1⟭ ; consigne rappelée : groupe froid allumé même à quai."
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
fill_locale: mixed
domain: e-commerce
appearance: markdown cell, notebook output, prose
scenario: trust and safety analyst's notebook with English markdown at a French marketplace with a US branch, grouping active sellers by normalised payout account to find resellers hiding behind several accounts
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Sellers sharing a payout account\n",
    "\n",
    "One bank account behind several seller accounts is the strongest signal we have for resellers working around the per-seller limits. French sellers are paid to an IBAN, US sellers to an ACH account; we normalise both into one key and group."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "metadata": {},
   "outputs": [],
   "source": [
    "import os\n",
    "import pandas as pd\n",
    "from sqlalchemy import create_engine\n",
    "\n",
    "eng = create_engine(os.environ[\"MARKETPLACE_DSN\"])\n",
    "sellers = pd.read_sql(\"SELECT seller_id, country, display_name, email, payout_iban, payout_account_no FROM sellers WHERE status = 'active'\", eng)\n",
    "# clé commune : IBAN sans espaces pour la France, numéro de compte ACH pour les US\n",
    "sellers[\"payout_key\"] = sellers[\"payout_iban\"].str.replace(\" \", \"\").fillna(sellers[\"payout_account_no\"])"
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
       "                payout_key  seller_id country     display_name            email\n",
       "0  ⟬iban#2⟭  S-10442  FR  ⟬person_name#2⟭  ⟬email#2⟭\n",
       "1  ⟬iban#2⟭  S-18810  FR  ⟬person_name#3⟭  ⟬email#3⟭\n",
       "2  ⟬bank_account_number#4⟭  S-20977  US  ⟬person_name#4⟭  ⟬email#4⟭\n",
       "3  ⟬bank_account_number#4⟭  S-21003  US  ⟬person_name#5⟭  ⟬email#5⟭\n",
       "4  ⟬bank_account_number#4⟭  S-21460  US  ⟬person_name#6⟭  ⟬email#6⟭"
      ]
     },
     "execution_count": 2,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "dup = sellers[sellers.duplicated(\"payout_key\", keep=False)].sort_values([\"payout_key\", \"seller_id\"])\n",
    "dup[[\"payout_key\", \"seller_id\", \"country\", \"display_name\", \"email\"]].reset_index(drop=True)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Two clusters. The French pair is a household already reviewed by KYC (allowed). The US trio opened three accounts in nine days with the same ACH account: suspend and send to ⟬email:generic#7⟭ for review before the next payout run on ⟬date#1⟭."
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
fill_locale: en_US
domain: SaaS
appearance: Javadoc, environment variable fallback, HTTP header, comment
scenario: release-notes generator with French comments in a French SaaS vendor's US billing product, listing merge requests merged since the last tag through the GitLab API, with a colleague's token as local fallback and a sample output in the Javadoc
⟬text⟭
package fr.saas.release;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * Génère les notes de version à partir des MR fusionnées depuis le dernier tag.
 * Lancé par le job release ; en local, le token retombe sur celui de ⟬person_name#1⟭ (à changer avant ses congés).
 * Remplace ⟬trap:code_identifier|⦃Family⦄ChangelogMojo⟭, le plugin Maven maison.
 *
 * <p>Exemple de sortie (v4.12.0) :
 * <pre>
 * ## v4.12.0
 * - Invoice CSV export, by ⟬person_name#2⟭ (!812)
 * - Report time zone fix, by ⟬person_name#3⟭ (!815)
 * - Dependency updates, by ⟬trap:indicator_non_pii|renovate-bot⟭ (!816)
 * </pre>
 */
public final class ReleaseNotes {

    private static final String API = "https://⟬hostname#1⟭/api/v4/projects/billing%2Fapi";
    private static final String TOKEN = System.getenv().getOrDefault("GITLAB_TOKEN", "⟬gitlab_token#1⟭");
    // désérialisation ⟬trap:library|Jackson⟭ en JsonNode : on ne lit que trois champs
    private static final ObjectMapper JSON = new ObjectMapper();
    private static final HttpClient HTTP = HttpClient.newHttpClient();

    private static JsonNode get(String path) throws Exception {
        HttpRequest req = HttpRequest.newBuilder(URI.create(API + path)).header("PRIVATE-TOKEN", TOKEN).build();
        return JSON.readTree(HTTP.send(req, HttpResponse.BodyHandlers.ofString()).body());
    }

    public static void main(String[] args) throws Exception {
        String version = args[0];
        JsonNode lastTag = get("/repository/tags?order_by=updated&per_page=1").get(0);
        String since = lastTag.get("commit").get("created_at").asText();
        JsonNode mrs = get("/merge_requests?state=merged&target_branch=main&per_page=100&updated_after=" + since);

        List<String> lines = new ArrayList<>(List.of("## " + version));
        for (JsonNode mr : mrs) {
            lines.add("- " + mr.get("title").asText() + ", by " + mr.get("author").get("name").asText()
                    + " (!" + mr.get("iid").asInt() + ")");
        }
        System.out.println(String.join("\n", lines));
    }
}
⟬end⟭

⟬template⟭
family: code
format: .sql
language: mixed
fill_locale: fr_FR
domain: e-commerce
appearance: stored procedure, SQL UPDATE, procedure call, comment
scenario: erasure procedure of a French marketplace written in English SQL with French comments, overwriting a customer's personal data while keeping orders and refund IBANs for accounting, with the first real request run below it
⟬text⟭
-- GDPR erasure for marketplace customers (droit à l'effacement).
-- Personal data is overwritten, not deleted: orders stay ten years for accounting (C. com. L123-22),
-- and so does the IBAN of past refunds, kept in refunds.

CREATE OR REPLACE PROCEDURE anonymise_customer(p_email text)
LANGUAGE plpgsql AS $$
DECLARE
    v_id bigint;
BEGIN
    SELECT id INTO v_id FROM customers WHERE lower(email) = lower(p_email);
    IF v_id IS NULL THEN
        RAISE EXCEPTION 'aucun client pour %', p_email;
    END IF;

    UPDATE customers
    SET email      = 'efface+' || id || '@invalid',
        ⟬trap:indicator_non_pii|first_name = 'Client'⟭,
        last_name  = 'effacé',
        phone      = NULL,
        birth_date = NULL,
        erased_at  = now()
    WHERE id = v_id;

    UPDATE addresses SET line1 = '-', line2 = NULL, phone = NULL WHERE customer_id = v_id;
    DELETE FROM newsletter_subscriptions WHERE customer_id = v_id;
    DELETE FROM saved_carts WHERE customer_id = v_id;
END $$;

-- Demande reçue le ⟬date#1⟭ via le formulaire (⟬ticket_id#1⟭).
-- Avant : ⟬person_name#2⟭, ⟬fr_postal_address#2⟭ ; remboursement du ⟬date#2⟭ sur ⟬iban#2⟭, conservé.
CALL anonymise_customer('⟬email#2⟭');

SELECT id, email, first_name, last_name, erased_at
FROM customers
WHERE erased_at::date = current_date;
⟬end⟭

⟬template⟭
family: code
format: .ts
language: mixed
fill_locale: en_US
domain: healthcare
appearance: environment variable fallback, regular expression, block comment, nested JSON
scenario: AWS Lambda with French comments that a French agency wrote for a US clinic, relaying new intake forms to the front desk's chat channel after masking health identifiers, with the bot token as fallback and a raw test event pasted from the logs
⟬text⟭
/**
 * Lambda : relaie les nouveaux formulaires d'admission de la clinique vers le canal de l'accueil,
 * après masquage des PHI. Seuls le prénom, l'heure du rendez-vous et le motif passent.
 */
import type { APIGatewayProxyHandler } from 'aws-lambda';

const BOT_TOKEN = process.env.SLACK_BOT_TOKEN ?? '⟬slack_token#1⟭';
const CHANNEL = 'C05INTAKE01';

const SSN = /\b\d{3}-?\d{2}-?\d{4}\b/g;
const DOB = /\b(0?[1-9]|1[0-2])\/(0?[1-9]|[12]\d|3[01])\/(19|20)\d{2}\b/g;
const PHONE = /\(?\d{3}\)?[ .-]?\d{3}[ .-]?\d{4}/g;

export function redact(text: string): string {
  return text.replace(SSN, '[SSN]').replace(DOB, '[DOB]').replace(PHONE, '[PHONE]');
}

export const handler: APIGatewayProxyHandler = async (event) => {
  const intake = JSON.parse(event.body ?? '{}');
  // le motif est en texte libre : les patients y mettent parfois leur numéro, d'où redact()
  const text = redact(`New patient: ${intake.firstName}, appointment ${intake.appointment}. Reason: ${intake.reason}`);
  const res = await fetch('https://slack.com/api/chat.postMessage', {
    method: 'POST',
    headers: { Authorization: `Bearer ${BOT_TOKEN}`, 'Content-Type': 'application/json; charset=utf-8' },
    body: JSON.stringify({ channel: CHANNEL, text }),
  });
  if (!res.ok) console.error('envoi refusé', res.status);
  return { statusCode: 204, body: '' };
};

/* Événement de test copié depuis les logs le ⟬date#1⟭ :
{"firstName":"⟬person_name:given#2⟭","lastName":"⟬person_name:family#2⟭","ssn":"⟬us_ssn#2⟭","dob":"⟬birth_date#2⟭",
 "phone":"⟬phone#2⟭","appointment":"2024-11-20T15:30:00-05:00","reason":"BP follow-up, call back at ⟬phone#2⟭"}
*/
⟬end⟭

⟬template⟭
family: code
format: .py
language: mixed
fill_locale: fr_FR
domain: healthcare
appearance: environment variable fallback, dict literal, string template, comment
scenario: appointment reminder job of a French imaging centre, English code sending French SMS the day before, with the SMS provider key as fallback and an appointment returned by the radiology system kept in a comment
⟬text⟭
"""SMS reminders for imaging appointments, sent the day before at 6 pm.

The SMS provider's API is in English; the messages are in French. Patients who answered STOP are skipped.
"""
import datetime as dt
import os

import requests

SMS_API = "https://⟬hostname#1⟭/v2/sms"
SMS_KEY = os.environ.get("SMS_API_KEY", "⟬opaque_token#1⟭")
CENTRE = {"nom": "⟬company#2⟭", "adresse": "⟬fr_postal_address#2⟭", "tel": "⟬phone#2⟭"}

TEMPLATE = (
    "Rappel : RDV {examen} demain à {heure} au {centre}, {adresse}. "
    "Venez 15 min avant avec votre carte Vitale et l'ordonnance. Annulation : {tel}. STOP au 36111"
)


def message(appointment: dict) -> str:
    start = dt.datetime.fromisoformat(appointment["debut"])
    return TEMPLATE.format(
        examen=appointment["examen"],
        heure=start.strftime("%Hh%M"),
        centre=CENTRE["nom"],
        adresse=CENTRE["adresse"],
        tel=CENTRE["tel"],
    )


def send(appointment: dict) -> bool:
    if appointment.get("stop_sms"):
        return False
    r = requests.post(
        SMS_API,
        headers={"Authorization": f"Bearer {SMS_KEY}"},
        json={"to": appointment["mobile"], "text": message(appointment), "sender": "RADIO"},
        timeout=10,
    )
    r.raise_for_status()
    return True


# Rendez-vous tel que le RIS le renvoie (⟬date#1⟭) :
# {"patient": "⟬person_name#3⟭", "mobile": "⟬phone#3⟭", "examen": "IRM genou", "debut": "2024-11-21T08:40", "stop_sms": false}
⟬end⟭

⟬template⟭
family: code
format: .ipynb
language: mixed
fill_locale: mixed
domain: SaaS
appearance: markdown cell, notebook output, placeholder, prose
scenario: security engineer's notebook with English markdown triaging a secret-scanning report over all GitLab repositories of a SaaS company with Paris and Austin teams, the matched secrets and committers in the output
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Secret scan of every GitLab project: triage\n",
    "\n",
    "`gitleaks detect` ran on each repository mirror and the reports were merged into one JSON. Goal: separate live secrets from placeholders, notify the committers, rotate. Paris and Austin repositories together."
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
       "RuleID\n",
       "aws-access-token        3\n",
       "generic-api-key        41\n",
       "generic-password        9\n",
       "gitlab-pat              5\n",
       "private-key             2\n",
       "dtype: int64"
      ]
     },
     "execution_count": 1,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "import json\n",
    "import pandas as pd\n",
    "\n",
    "rep = pd.DataFrame(json.load(open(\"⟬file_path#1⟭\")))\n",
    "rep.groupby(\"RuleID\").size()"
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
       "                             File            RuleID                Secret           Author                Email\n",
       "0        deploy/ci/.gitlab-ci.yml        gitlab-pat  ⟬gitlab_token#2⟭  ⟬person_name#2⟭  ⟬email#2⟭\n",
       "1  services/billing/.env.example   generic-api-key  ⟬opaque_token#3⟭  ⟬person_name#3⟭  ⟬email#3⟭\n",
       "2              tools/seed/seed.py  generic-password  ⟬password#4⟭  ⟬person_name#4⟭  ⟬email#4⟭\n",
       "3         docs/examples/client.md   generic-api-key  ⟬trap:placeholder|YOUR_API_KEY_HERE⟭  ⟬person_name#2⟭  ⟬email#2⟭"
      ]
     },
     "execution_count": 2,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "live = rep[rep[\"RuleID\"].isin([\"gitlab-pat\", \"generic-api-key\", \"generic-password\"])]\n",
    "live = live.sort_values(\"Date\", ascending=False).drop_duplicates(\"Secret\")\n",
    "live[[\"File\", \"RuleID\", \"Secret\", \"Author\", \"Email\"]].head(4).reset_index(drop=True)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Row 3 is the documented placeholder: false positive, added to `.gitleaksignore`. Rows 0 to 2 were revoked on ⟬date#1⟭ and the committers notified by ⟬person_name#5⟭. The two private keys are test fixtures of the TLS library vendored in `third_party/`."
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
format: .java
language: mixed
fill_locale: en_GB
domain: logistics
appearance: Javadoc, record, comment, nested loop
scenario: vehicle routing helper with French comments in a French transport management system also used by its UK depots, building rounds with the parallel savings heuristic on a distance matrix
⟬text⟭
package fr.tms.routing;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

/**
 * Construction des tournées par l'algorithme des économies de ⟬trap:eponym|Clarke-Wright⟭ (version parallèle).
 * Also used by the UK depots: distances come from the matrix service in metres, capacities in pallets.
 * Testé sur le dépôt de ⟬city#1⟭ : 38 arrêts, 6 tournées au lieu de 7 avec l'ancienne heuristique.
 */
public final class SavingsRouter {

    public record Saving(int i, int j, double value) {}

    private SavingsRouter() {}

    /** Index 0 is the depot. Returns rounds as lists of stop indices, depot excluded. */
    public static List<List<Integer>> routes(double[][] dist, int[] demand, int capacity) {
        int n = dist.length;
        List<Saving> savings = new ArrayList<>();
        for (int i = 1; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                savings.add(new Saving(i, j, dist[0][i] + dist[0][j] - dist[i][j]));
            }
        }
        savings.sort(Comparator.comparingDouble(Saving::value).reversed());

        // au départ, un aller-retour par client
        Map<Integer, LinkedList<Integer>> routeOf = new HashMap<>();
        Map<LinkedList<Integer>, Integer> load = new HashMap<>();
        for (int i = 1; i < n; i++) {
            LinkedList<Integer> r = new LinkedList<>(List.of(i));
            routeOf.put(i, r);
            load.put(r, demand[i]);
        }

        for (Saving s : savings) {
            LinkedList<Integer> a = routeOf.get(s.i());
            LinkedList<Integer> b = routeOf.get(s.j());
            if (a == b || load.get(a) + load.get(b) > capacity) {
                continue;
            }
            // on ne fusionne que par les extrémités, sinon la tournée se croise
            if (a.getLast() == s.i() && b.getFirst() == s.j()) {
                merge(a, b, routeOf, load);
            } else if (b.getLast() == s.j() && a.getFirst() == s.i()) {
                merge(b, a, routeOf, load);
            }
        }
        return load.keySet().stream().<List<Integer>>map(ArrayList::new).toList();
    }

    private static void merge(LinkedList<Integer> head, LinkedList<Integer> tail,
                              Map<Integer, LinkedList<Integer>> routeOf, Map<LinkedList<Integer>, Integer> load) {
        int total = load.remove(head) + load.remove(tail);
        head.addAll(tail);
        tail.forEach(stop -> routeOf.put(stop, head));
        load.put(head, total);
    }
}
⟬end⟭

⟬template⟭
family: code
format: .sql
language: mixed
fill_locale: fr_FR
domain: SaaS
appearance: CREATE TABLE, function call, SQL INSERT, comment
scenario: migration in English SQL with French notes for the on-call team, moving the audit log of a French SaaS product to monthly partitions and copying a month from the table a developer renamed during an incident
⟬text⟭
-- Audit log partitioned by month (pg_partman). Before: one 900 GB table that VACUUM never finished.
-- Notes pour l'astreinte : la maintenance crée les partitions trois mois à l'avance, rétention 24 mois.

CREATE TABLE audit_events (
    id          bigint GENERATED ALWAYS AS IDENTITY,
    tenant_id   uuid        NOT NULL,
    actor_id    uuid,
    action      text        NOT NULL,
    target      text,
    ip          inet,
    created_at  timestamptz NOT NULL DEFAULT now(),
    PRIMARY KEY (id, created_at)
) PARTITION BY RANGE (created_at);

SELECT partman.create_parent(
    p_parent_table => 'public.audit_events',
    p_control      => 'created_at',
    p_interval     => '1 month',
    p_premake      => 3);

UPDATE partman.part_config
SET retention = '24 months', retention_keep_table = false
WHERE parent_table = 'public.audit_events';

-- Copie mois par mois depuis l'ancienne table (renommée pendant l'incident), pour ne pas bloquer les écritures
INSERT INTO audit_events (tenant_id, actor_id, action, target, ip, created_at)
SELECT tenant_id, actor_id, action, target, ip, created_at
FROM ⟬trap:code_identifier|audit_events_old_⦃family⦄⟭
WHERE created_at >= '2024-10-01' AND created_at < '2024-11-01';

-- ⟬trap:indicator_non_pii|actor_id IS NULL⟭ : action système (jobs planifiés), pas un utilisateur anonyme
CREATE INDEX ON audit_events (tenant_id, created_at DESC);
CREATE INDEX ON audit_events (actor_id, created_at DESC) WHERE actor_id IS NOT NULL;
⟬end⟭

⟬template⟭
family: code
format: .ts
language: mixed
fill_locale: fr_FR
domain: e-commerce
appearance: comment, array literal, function, string literal
scenario: daily gift draw of a French cosmetics shop's Advent calendar, English code with French comments, shuffling the gift list with a seeded shuffle so customer service can replay any day
⟬text⟭
// Tirage du cadeau offert du calendrier de l'Avent : un produit par jour, jamais deux fois le même.
// Mélange de ⟬trap:eponym|Fisher-Yates⟭ avec une graine par jour, pour que le service client puisse rejouer le tirage.

export type Gift = { sku: string; label: string; stock: number };

export const GIFTS: Gift[] = [
  { sku: 'AV-01', label: 'Mini bougie ⟬trap:word_name|Ambre⟭', stock: 400 },
  { sku: 'AV-02', label: 'Savon au lait d\'ânesse', stock: 650 },
  { sku: 'AV-03', label: 'Infusion ⟬trap:eponym|Earl Grey⟭ bergamote', stock: 900 },
  { sku: 'AV-04', label: 'Baume lèvres ⟬trap:word_name|Rose⟭', stock: 520 },
  { sku: 'AV-05', label: 'Pochette coton bio', stock: 300 },
];

// mulberry32 : générateur 32 bits, suffisant pour un tirage marketing (pas pour de la crypto)
function mulberry32(seed: number): () => number {
  let a = seed >>> 0;
  return () => {
    a = (a + 0x6d2b79f5) >>> 0;
    let t = a;
    t = Math.imul(t ^ (t >>> 15), t | 1);
    t ^= t + Math.imul(t ^ (t >>> 7), t | 61);
    return ((t ^ (t >>> 14)) >>> 0) / 4294967296;
  };
}

export function shuffle<T>(items: readonly T[], seed: number): T[] {
  const out = [...items];
  const rand = mulberry32(seed);
  for (let i = out.length - 1; i > 0; i--) {
    const j = Math.floor(rand() * (i + 1));
    [out[i], out[j]] = [out[j], out[i]];
  }
  return out;
}

/** Day 1 to 24; the seed is the date, so the same day always gives the same gift. */
export function giftOfTheDay(day: number, year = new Date().getFullYear()): Gift | undefined {
  const inStock = GIFTS.filter((g) => g.stock > 0);
  return shuffle(inStock, year * 100 + 12)[(day - 1) % inStock.length];
}
⟬end⟭
