⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: docstring, dict literal, URL, string literal
scenario: nightly export script of a radiology centre sending exam metadata to a regional warehouse, with a test patient left in the code
⟬text⟭
"""Export des comptes rendus d'imagerie vers l'entrepôt régional.

Lancé chaque nuit par le planificateur du centre. Le format attendu par
l'entrepôt est décrit dans la note de cadrage v3 (voir ⟬ticket_id#1⟭).

Exemple de ligne produite :
    ⟬fr_social_security_number#1⟭;⟬person_name:family#1⟭;⟬person_name:given#1⟭;⟬birth_date#1⟭;IRM GENOU G
"""
import csv
import datetime as dt
from pathlib import Path

from sqlalchemy import create_engine, text

SORTIE = Path("⟬file_path#1⟭")
SEPARATEUR = ";"
COLONNES = ["nir", "nom", "prenom", "date_naissance", "libelle_examen"]

# patiente fictive créée pour la recette avec l'entrepôt, à retirer avant la MEP
PATIENT_RECETTE = {
    "nir": "⟬fr_social_security_number#2f⟭",
    "nom": "⟬person_name:family#2⟭",
    "prenom": "⟬person_name:given#2⟭",
    "date_naissance": "⟬birth_date#2⟭",
    "adresse": "⟬fr_postal_address#2⟭",
    "libelle_examen": "ECHO ABDOMINALE",
}

REQUETE = text("""
    SELECT p.nir, p.nom, p.prenom, p.date_naissance, e.libelle
    FROM examens e
    JOIN patients p ON p.id = e.patient_id
    WHERE e.date_validation >= :depuis
""")


def lignes_a_exporter(engine, depuis):
    with engine.connect() as cnx:
        for row in cnx.execute(REQUETE, {"depuis": depuis}):
            yield [row.nir, row.nom.upper(), row.prenom, row.date_naissance.isoformat(), row.libelle]


def main():
    engine = create_engine("postgresql+psycopg2://export_ro:⟬url_password#3⟭@⟬hostname#3⟭/ris")
    hier = dt.date.today() - dt.timedelta(days=1)
    with SORTIE.open("w", newline="", encoding="utf-8") as fichier:
        ecrivain = csv.writer(fichier, delimiter=SEPARATEUR)
        ecrivain.writerow(COLONNES)
        for ligne in lignes_a_exporter(engine, hier):
            ecrivain.writerow(ligne)
    print(f"export terminé : {SORTIE}")


if __name__ == "__main__":
    main()
⟬end⟭

⟬template⟭
family: code
format: .sql
language: fr
fill_locale: fr_FR
domain: banking
appearance: comment, SQL INSERT
scenario: Flyway migration of a consumer credit company adding SEPA direct debit mandates, with creditor settings and test mandates for the staging database
⟬text⟭
-- V14 : table des mandats SEPA pour le prélèvement des échéances de prêt
-- Auteur : ⟬person_name:initial#1⟭, revue par l'équipe crédit le ⟬date#1⟭

CREATE TABLE mandats_sepa (
    rum              VARCHAR(35) PRIMARY KEY,
    client_id        VARCHAR(20) NOT NULL REFERENCES clients(id),
    iban_debiteur    VARCHAR(34) NOT NULL,
    bic_debiteur     VARCHAR(11),
    titulaire        VARCHAR(140) NOT NULL,
    date_signature   DATE NOT NULL,
    statut           VARCHAR(12) NOT NULL DEFAULT 'actif'
);

CREATE INDEX idx_mandats_client ON mandats_sepa (client_id);

-- Créancier : repris des statuts et du contrat avec la banque
INSERT INTO parametres (cle, valeur) VALUES
    ('creancier.raison_sociale', '⟬company#5⟭'),
    ('creancier.siret', '⟬fr_siret#5⟭'),
    ('creancier.adresse', '⟬fr_postal_address#5⟭'),
    ('creancier.iban_reception', '⟬iban#5⟭');

-- Mandats de test, environnement de recette uniquement
INSERT INTO mandats_sepa (rum, client_id, iban_debiteur, bic_debiteur, titulaire, date_signature) VALUES
    ('RUM-⟬order_number#2⟭', '⟬customer_id#2⟭', '⟬iban#2⟭', '⟬bic#2⟭', '⟬person_name#2⟭', '⟬date#2⟭'),
    ('RUM-⟬order_number#3⟭', '⟬customer_id#3⟭', '⟬iban#3⟭', '⟬bic#3⟭', '⟬person_name#3⟭', '⟬date#3⟭'),
    ('RUM-⟬order_number#4⟭', '⟬customer_id#4⟭', '⟬iban#4⟭', '⟬bic#4⟭', '⟬person_name#4⟭', '⟬date#4⟭');
⟬end⟭

⟬template⟭
family: code
format: .sh
language: fr
fill_locale: fr_FR
domain: energy
appearance: environment variable, URL, command-line argument
scenario: cron backup script of a meter-reading database, written by an ops engineer who kept the credentials inline
⟬text⟭
#!/bin/bash
# Sauvegarde quotidienne de la base des relevés de compteurs (cron 02h30)
set -euo pipefail

export PGPASSWORD='⟬password#1⟭'
DEST=/srv/backup/releves/$(date +%F).dump

pg_dump -h ⟬hostname#1⟭ -U releves_bkp -Fc releves > "$DEST"
curl -sf -T "$DEST" "https://depot:⟬url_password#2⟭@⟬hostname#2⟭/releves/"
find /srv/backup/releves -name '*.dump' -mtime +14 -delete
echo "$(date -Is) sauvegarde ok" >> /var/log/sauvegarde_releves.log
⟬end⟭

⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: HR
appearance: docstring, assignment, dict literal, comment, string literal
scenario: Django service of an in-house payroll tool that builds and emails monthly payslips, with a doctest-style example and a support note left at the bottom
⟬text⟭
"""Génération et envoi des bulletins de paie mensuels.

Ce module est appelé par la commande ``python manage.py envoyer_bulletins``.
Il calcule le net à payer, produit le PDF et l'envoie au salarié.

Exemple (shell Django) ::

    >>> from paie.services.bulletin import generer_bulletin
    >>> b = generer_bulletin(matricule="⟬customer_id#1⟭", periode="2024-03")
    >>> b.salarie.nom_complet
    '⟬person_name#1⟭'
    >>> b.salarie.nir
    '⟬fr_social_security_number#1⟭'
"""
import logging
import smtplib
from dataclasses import dataclass
from decimal import ROUND_HALF_UP, Decimal
from email.message import EmailMessage

from ⟬trap:library|django⟭.template.loader import render_to_string
from weasyprint import HTML

from paie.models import Bulletin, Salarie
from paie.regles import cotisations_patronales, cotisations_salariales

log = logging.getLogger(__name__)

# compte d'envoi dédié, le relais n'accepte pas l'authentification par certificat
EXPEDITEUR = "⟬email:generic#2⟭"
SMTP_HOTE = "⟬hostname#1⟭"
SMTP_MDP = "⟬password#1⟭"
⟬trap:indicator_non_pii|SMTP_MDP_ROTATION_JOURS = 90⟭

ARRONDI = Decimal("0.01")


@dataclass
class Montants:
    brut: Decimal
    cotisations_sal: Decimal
    cotisations_pat: Decimal
    net_imposable: Decimal
    net_a_payer: Decimal


def calculer(salarie: Salarie, brut: Decimal) -> Montants:
    sal = cotisations_salariales(salarie, brut)
    pat = cotisations_patronales(salarie, brut)
    net_imposable = (brut - sal.deductibles).quantize(ARRONDI, ROUND_HALF_UP)
    net = (brut - sal.total).quantize(ARRONDI, ROUND_HALF_UP)
    return Montants(brut, sal.total, pat.total, net_imposable, net)


def generer_bulletin(matricule: str, periode: str) -> Bulletin:
    salarie = Salarie.objects.get(matricule=matricule)
    montants = calculer(salarie, salarie.salaire_base)
    html = render_to_string("paie/bulletin.html", {"s": salarie, "m": montants, "periode": periode})
    pdf = HTML(string=html).write_pdf()
    return Bulletin.objects.create(salarie=salarie, periode=periode, pdf=pdf, net=montants.net_a_payer)


def envoyer(bulletin: Bulletin) -> None:
    msg = EmailMessage()
    msg["From"] = EXPEDITEUR
    msg["To"] = bulletin.salarie.email
    msg["Subject"] = f"Votre bulletin de paie {bulletin.periode}"
    msg.set_content("Bonjour,\n\nVous trouverez ci-joint votre bulletin de paie.\n\nLe service RH")
    msg.add_attachment(bulletin.pdf, maintype="application", subtype="pdf",
                       filename=f"bulletin_{bulletin.periode}.pdf")
    with smtplib.SMTP(SMTP_HOTE, 587) as smtp:
        smtp.starttls()
        smtp.login(EXPEDITEUR, SMTP_MDP)
        smtp.send_message(msg)
    log.info("bulletin %s envoyé à %s", bulletin.id, bulletin.salarie.email)


def virement_salaire(bulletin: Bulletin) -> dict:
    """Ligne du fichier de virements SEPA.

    Le compte émetteur est celui de la paie, pas le compte courant.
    """
    return {
        "debiteur_iban": "⟬iban#3⟭",
        "debiteur_nom": "⟬company#3⟭",
        "creancier_iban": bulletin.salarie.iban,
        "creancier_nom": bulletin.salarie.nom_complet,
        "montant": str(bulletin.net),
        "libelle": f"SALAIRE {bulletin.periode}",
    }


# Cas remonté par ⟬person_name#4⟭ (gestionnaire paie) le ⟬date#1⟭ : salarié en
# mi-temps thérapeutique, IBAN étranger ⟬iban#5⟭ rejeté par la banque.
# Virement fait à la main en attendant le correctif.
⟬end⟭

⟬template⟭
family: code
format: .ipynb
language: fr
fill_locale: fr_FR
domain: insurance
appearance: notebook output, string literal, HTTP header, markdown cell
scenario: actuarial notebook exploring motor claims by driver age, pulling raw claims from an internal API whose output still shows drivers
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Sinistres auto 2023 : fréquence par tranche d'âge du conducteur\n",
    "\n",
    "Extraction demandée par l'actuariat. Source : API sinistres (environnement de recette)."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "metadata": {},
   "outputs": [],
   "source": [
    "import ⟬trap:library|pandas⟭ as pd\n",
    "import requests\n",
    "\n",
    "API = \"⟬url#1⟭\"\n",
    "JETON = \"⟬opaque_token#1⟭\"\n",
    "r = requests.get(f\"{API}/sinistres\", params={\"annee\": 2023}, headers={\"X-Api-Key\": JETON}, timeout=60)\n",
    "df = pd.DataFrame(r.json()[\"items\"])"
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
       "  num_sinistre  immatriculation  conducteur  date_naissance  bonus\n",
       "0  ⟬order_number#2⟭  ⟬fr_license_plate#2⟭  ⟬person_name#2⟭  ⟬birth_date#2⟭  0.85\n",
       "1  ⟬order_number#3⟭  ⟬fr_license_plate#3⟭  ⟬person_name#3⟭  ⟬birth_date#3⟭  1.00\n",
       "2  ⟬order_number#4⟭  ⟬fr_license_plate#4⟭  ⟬person_name#4⟭  ⟬birth_date#4⟭  0.50"
      ]
     },
     "execution_count": 2,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "df[[\"num_sinistre\", \"immatriculation\", \"conducteur\", \"date_naissance\", \"bonus\"]].head(3)"
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
       "tranche_age\n",
       "18-24    0.142\n",
       "25-34    0.087\n",
       "35-49    0.061\n",
       "50-64    0.054\n",
       "65+      0.069\n",
       "Name: frequence, dtype: float64"
      ]
     },
     "execution_count": 3,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "df[\"age\"] = (pd.Timestamp(\"2023-12-31\") - pd.to_datetime(df[\"date_naissance\"])).dt.days // 365\n",
    "df[\"tranche_age\"] = pd.cut(df[\"age\"], [17, 24, 34, 49, 64, 120], labels=[\"18-24\", \"25-34\", \"35-49\", \"50-64\", \"65+\"])\n",
    "(df.groupby(\"tranche_age\")[\"nb_sinistres\"].sum() / df.groupby(\"tranche_age\")[\"exposition\"].sum()).rename(\"frequence\").round(3)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Le sinistre de ⟬person_name#5⟭ a une date de naissance au 01/01/1900 : valeur par défaut de l'ancien outil, ligne exclue du calcul."
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
language: fr
fill_locale: fr_FR
domain: public administration
appearance: test fixture, keyword argument
scenario: pytest fixture for the eligibility rules of a municipal housing aid, written by the developer of the rules engine
⟬text⟭
import pytest

from aides.eligibilite import Demandeur, est_eligible


⟬trap:email_lookalike|@pytest.fixture⟭
def demandeur_isole():
    return Demandeur(
        nom="⟬person_name:family#1⟭",
        prenom="⟬person_name:given#1⟭",
        ne_le="⟬birth_date#1⟭",
        numero_fiscal="⟬fr_tax_number#1⟭",
        adresse="⟬fr_postal_address#1⟭",
        revenu_fiscal_reference=11840,
        nb_parts=1,
    )


def test_demandeur_isole_sous_plafond(demandeur_isole):
    assert est_eligible(demandeur_isole, annee=2024)


def test_demandeur_isole_au_dessus_du_plafond(demandeur_isole):
    demandeur_isole.revenu_fiscal_reference = 31000
    assert not est_eligible(demandeur_isole, annee=2024)
⟬end⟭

⟬template⟭
family: code
format: .sql
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: comment, SQL WHERE
scenario: ad hoc query run by a hospital DBA to investigate a duplicate patient record reported by the emergency desk
⟬text⟭
-- ⟬ticket_id#1⟭ : doublon de dossier signalé par l'accueil des urgences
-- la patiente a été créée deux fois, une fois avec le NIR de son conjoint
SELECT id, nom, prenom, date_naissance, nir, cree_le
FROM patients
WHERE nir IN ('⟬fr_social_security_number#1f⟭', '⟬fr_social_security_number#2m⟭')
   OR (nom = '⟬person_name:family#1⟭' AND date_naissance = '⟬birth_date#1⟭')
ORDER BY cree_le;
⟬end⟭

⟬template⟭
family: code
format: .sh
language: fr
fill_locale: fr_FR
domain: banking
appearance: heredoc, comment, URL, command-line argument
scenario: manual certificate renewal script for a bank's transfer gateway, pasted with its private key by the engineer who ran it last
⟬text⟭
#!/usr/bin/env bash
# Renouvellement manuel du certificat de la passerelle virements (l'ACME interne
# ne couvre pas encore ce domaine). À lancer en root sur le bastion.
# Dernière exécution : ⟬date#1⟭ par ⟬person_name#1⟭

set -e
CERT_DIR=/etc/nginx/tls/virements
NOEUDS="⟬hostname#1⟭ ⟬hostname#2⟭"

mkdir -p "$CERT_DIR"
chmod 700 "$CERT_DIR"

cat > "$CERT_DIR/virements.key" <<'EOF'
⟬private_key#2⟭
EOF
chmod 600 "$CERT_DIR/virements.key"

cp /root/renouvellement/virements.crt "$CERT_DIR/virements.crt"
openssl x509 -in "$CERT_DIR/virements.crt" -noout -enddate

for n in $NOEUDS; do
  scp -i ~/.ssh/deploy_ed25519 "$CERT_DIR"/virements.* "⟬trap:email_lookalike|deploy@$n⟭:$CERT_DIR/"
  ssh -i ~/.ssh/deploy_ed25519 "⟬trap:email_lookalike|deploy@$n⟭" 'sudo nginx -t && sudo systemctl reload nginx'
done

# prévenir l'astreinte sur le canal exploitation
curl -s -X POST -H 'Content-Type: application/json' \
  -d '{"text": "certificat passerelle virements renouvelé"}' \
  "https://⟬hostname#3⟭/hooks/⟬opaque_token#3⟭"
⟬end⟭

⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: energy
appearance: assignment, triple-quoted string, query string, function call
scenario: prototype client of an energy supplier's back office checking a household's eligibility for the energy voucher, with the mTLS key pasted in
⟬text⟭
"""Client minimal de l'API d'éligibilité au chèque énergie (fournisseurs).

Utilisé par le back-office pour vérifier qu'un client peut bénéficier de
la déduction sur facture. Prototype : à industrialiser avant la mise en prod.
"""
import tempfile

import requests

BASE_URL = "⟬url#1⟭"
CLIENT_ID = "⟬username#1⟭"
CLIENT_SECRET = "⟬opaque_token#1⟭"
SIRET_FOURNISSEUR = "⟬fr_siret#2⟭"
CERTIFICAT_CLIENT = "/etc/cheque-energie/client.crt"

# Certificat client exigé par l'API (mTLS). Copié ici le temps du prototype.
CLE_PRIVEE_CLIENT = """⟬private_key#3⟭"""


def _jeton():
    r = requests.post(
        f"{BASE_URL}/oauth/token",
        data={"grant_type": "client_credentials", "client_id": CLIENT_ID, "client_secret": CLIENT_SECRET},
        timeout=15,
    )
    r.raise_for_status()
    return r.json()["access_token"]


def verifier_eligibilite(numero_fiscal: str, annee: int) -> dict:
    with tempfile.NamedTemporaryFile("w", suffix=".key") as cle:
        cle.write(CLE_PRIVEE_CLIENT)
        cle.flush()
        r = requests.get(
            f"{BASE_URL}/v1/eligibilite",
            params={"numeroFiscal": numero_fiscal, "annee": annee, "siret": SIRET_FOURNISSEUR},
            headers={"Authorization": f"Bearer {_jeton()}"},
            cert=(CERTIFICAT_CLIENT, cle.name),
            timeout=15,
        )
    r.raise_for_status()
    return r.json()


if __name__ == "__main__":
    # foyer de test fourni dans le kit d'intégration
    print(verifier_eligibilite("⟬fr_tax_number#4⟭", 2024))
⟬end⟭

⟬template⟭
family: code
format: .ipynb
language: fr
fill_locale: fr_FR
domain: HR
appearance: markdown cell, URL, notebook output, string literal, function call
scenario: HR analyst notebook computing quarterly absenteeism for a works council, reading the HRIS directly and mailing the result
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Absentéisme T1 - siège et agences\n",
    "\n",
    "Demande de ⟬person_name#1⟭ (RRH) pour le CSE du ⟬date#1⟭. Ne pas diffuser hors RH."
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
    "sirh = create_engine(\"mysql+pymysql://lecture_rh:⟬url_password#2⟭@⟬hostname#2⟭/sirh\")\n",
    "absences = pd.read_sql(\"SELECT * FROM v_absences WHERE debut >= '2024-01-01' AND debut < '2024-04-01'\", sirh)\n",
    "effectif = pd.read_sql(\"SELECT matricule, nom, prenom, service, site, date_entree FROM salaries WHERE actif = 1\", sirh)"
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
      "(1843, 9) (412, 6)\n"
     ]
    }
   ],
   "source": [
    "print(absences.shape, effectif.shape)"
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
       "     matricule  nom  prenom  service  jours\n",
       "17   ⟬customer_id#3⟭  ⟬person_name:family#3⟭  ⟬person_name:given#3⟭  Logistique    38\n",
       "203  ⟬customer_id#4⟭  ⟬person_name:family#4⟭  ⟬person_name:given#4⟭  Agence Nord   31\n",
       "88   ⟬customer_id#5⟭  ⟬person_name:family#5⟭  ⟬person_name:given#5⟭  Comptabilité  27\n",
       "350  ⟬customer_id#6⟭  ⟬person_name:family#6⟭  ⟬person_name:given#6⟭  Agence Sud    26\n",
       "12   ⟬customer_id#7⟭  ⟬person_name:family#7⟭  ⟬person_name:given#7⟭  Logistique    22"
      ]
     },
     "execution_count": 3,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "par_salarie = (absences.groupby(\"matricule\")[\"jours\"].sum()\n",
    "               .reset_index()\n",
    "               .merge(effectif, on=\"matricule\"))\n",
    "par_salarie.sort_values(\"jours\", ascending=False)[[\"matricule\", \"nom\", \"prenom\", \"service\", \"jours\"]].head()"
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
       "service\n",
       "Agence Nord     6.8\n",
       "Agence Sud      5.1\n",
       "Comptabilité    3.9\n",
       "Direction       1.2\n",
       "Logistique      8.4\n",
       "Name: taux_absenteisme, dtype: float64"
      ]
     },
     "execution_count": 4,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "jours_theoriques = effectif.groupby(\"service\").size() * 61\n",
    "par_service = (absences.merge(effectif, on=\"matricule\").groupby(\"service\")[\"jours\"].sum() / jours_theoriques * 100)\n",
    "par_service.rename(\"taux_absenteisme\").round(1)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Les arrêts de plus de 30 jours sont à sortir du taux de gravité : voir avec ⟬person_name#8⟭ (service de santé au travail, ⟬phone#8⟭) avant de présenter les chiffres."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 5,
   "metadata": {},
   "outputs": [],
   "source": [
    "import requests\n",
    "\n",
    "par_service.to_excel(r\"⟬file_path#1⟭\")\n",
    "requests.post(\n",
    "    \"https://⟬hostname#9⟭/api/v2/messages\",\n",
    "    headers={\"Authorization\": \"Bearer ⟬opaque_token#9⟭\"},\n",
    "    json={\"to\": \"⟬email#1⟭\", \"subject\": \"Absentéisme T1\", \"attachment\": \"absenteisme_T1.xlsx\"},\n",
    "    timeout=30,\n",
    ")"
   ]
  }
 ],
 "metadata": {
  "kernelspec": {"display_name": "Python 3 (rh)", "language": "python", "name": "rh"},
  "language_info": {"name": "python", "version": "3.10.12"}
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
⟬end⟭

⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: insurance
appearance: docstring, assignment, function call
scenario: pricing team's GLM module for motor claim frequency, maintained by actuaries and reviewed by the data platform team
⟬text⟭
"""Modèle de fréquence sinistres auto (GLM).

Fréquence ~ ⟬trap:eponym|loi de Poisson⟭ avec offset log(exposition),
coût moyen ~ loi Gamma. Une variante ⟬trap:eponym|Tweedie⟭ (p = 1.5) est
gardée pour comparaison mais n'est pas utilisée en production.
"""
import numpy as np
import statsmodels.api as sm
import statsmodels.formula.api as smf

⟬trap:indicator_non_pii|NOM_MODELE = "freq_auto"⟭
VERSION = "⟬version#1⟭"
DATE_CALIBRAGE = "⟬date#1⟭"
SEUIL_SURDISPERSION = 1.5

VARIABLES = [
    "C(tranche_age_conducteur)",
    "C(zone_tarifaire)",
    "C(groupe_vehicule)",
    "anciennete_permis",
    "C(usage)",
]


def ajuster_frequence(df):
    formule = "nb_sinistres ~ " + " + ".join(VARIABLES)
    modele = smf.glm(
        formule,
        data=df,
        family=sm.families.⟬trap:code_identifier|Poisson⟭(),
        offset=np.log(df["exposition"]),
    )
    return modele.fit()


def ajuster_tweedie(df, puissance=1.5):
    formule = "charge ~ " + " + ".join(VARIABLES)
    famille = sm.families.Tweedie(var_power=puissance, link=sm.families.links.Log())
    return smf.glm(formule, data=df, family=famille, offset=np.log(df["exposition"])).fit()


def verifier_surdispersion(resultat):
    """Statistique de ⟬trap:eponym|Pearson⟭ rapportée aux degrés de liberté.

    Au-dessus du seuil, on passe en binomiale négative.
    """
    ratio = resultat.pearson_chi2 / resultat.df_resid
    return ratio, ratio > SEUIL_SURDISPERSION


def prime_pure(resultat_freq, resultat_cout, profils):
    frequence = resultat_freq.predict(profils, offset=np.zeros(len(profils)))
    cout_moyen = resultat_cout.predict(profils)
    return (frequence * cout_moyen).round(2)
⟬end⟭

⟬template⟭
family: code
format: .sql
language: fr
fill_locale: fr_FR
domain: banking
appearance: comment, SQL INSERT, column definition
scenario: migration creating the know-your-customer table of a retail bank, where sensitive columns are encrypted by the application and only settings are seeded
⟬text⟭
-- V22__kyc_personnes_physiques.sql
-- Données de connaissance client exigées par la LCB-FT. Les colonnes sensibles
-- sont chiffrées côté application (pgcrypto n'est pas utilisé ici, cf. ADR-014).

CREATE TABLE kyc_personnes (
    id                       BIGSERIAL PRIMARY KEY,
    client_id                VARCHAR(20) NOT NULL UNIQUE,
    nom_chiffre              BYTEA NOT NULL,
    prenoms_chiffre          BYTEA NOT NULL,
    date_naissance_chiffree  BYTEA NOT NULL,
    pays_naissance           CHAR(2) NOT NULL,
    piece_type               VARCHAR(10) NOT NULL CHECK (piece_type IN ('CNI', 'PASSEPORT', 'TITRE_SEJ')),
    piece_numero_chiffre     BYTEA NOT NULL,
    iban_empreinte           CHAR(64),
    niveau_risque            SMALLINT NOT NULL DEFAULT 1,
    revu_le                  DATE,
    revu_par                 VARCHAR(40)
);

COMMENT ON COLUMN kyc_personnes.iban_empreinte IS 'SHA-256 de l''IBAN normalisé, pour repérer les comptes partagés';
COMMENT ON COLUMN kyc_personnes.revu_par IS 'identifiant de l''analyste conformité, jamais son nom';

CREATE ROLE kyc_lecture LOGIN PASSWORD ⟬trap:placeholder|:'mdp_kyc_lecture'⟭;
GRANT SELECT (id, client_id, pays_naissance, niveau_risque, revu_le) ON kyc_personnes TO kyc_lecture;

INSERT INTO parametres (cle, valeur) VALUES
    ('kyc.revue.frequence_mois.risque_faible', '36'),
    ('kyc.revue.frequence_mois.risque_eleve', '12'),
    ⟬trap:indicator_non_pii|('kyc.revue.utilisateur_defaut', 'batch_conformite')⟭,
    ⟬trap:indicator_non_pii|('kyc.export.format_date_naissance', 'YYYY-MM-DD')⟭;
⟬end⟭

⟬template⟭
family: code
format: .sh
language: fr
fill_locale: fr_FR
domain: public administration
appearance: environment variable, command-line argument
scenario: monitoring probe of a citizen services portal, called by the supervision server every five minutes
⟬text⟭
#!/bin/sh
# Sonde de supervision du portail démarches (appelée toutes les 5 min)
URL="https://⟬hostname#1⟭/api/sante"
⟬trap:indicator_non_pii|USER_AGENT="sonde-supervision/1.2"⟭

CODE=$(curl -s -o /dev/null -w '%{http_code}' -A "$USER_AGENT" \
  -u "${SONDE_USER}:⟬trap:placeholder|${SONDE_PASSWORD}⟭" "$URL")

if [ "$CODE" != "200" ]; then
  echo "CRITICAL - portail démarches répond $CODE"
  exit 2
fi
echo "OK - portail démarches"
exit 0
⟬end⟭

⟬template⟭
family: code
format: .ipynb
language: fr
fill_locale: fr_FR
domain: energy
appearance: markdown cell, notebook output, assignment
scenario: forecasting notebook of a grid operator's data team comparing a seasonal baseline with a regression on hourly load
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "## Prévision de la consommation horaire - poste source de ⟬trap:word_name|Saint-Pierre⟭\n",
    "\n",
    "Référence : lissage ⟬trap:eponym|Holt-Winters⟭. Candidat : régression avec termes de ⟬trap:eponym|Fourier⟭ (saisonnalités journalière et hebdomadaire) et température lissée sur 48 h."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "metadata": {},
   "outputs": [],
   "source": [
    "import numpy as np\n",
    "import pandas as pd\n",
    "from statsmodels.tsa.holtwinters import ExponentialSmoothing\n",
    "\n",
    "conso = pd.read_parquet(\"⟬file_path#1⟭\")\n",
    "meteo = pd.read_csv(\"⟬file_path#2⟭\", parse_dates=[\"horodate\"])\n",
    "df = conso.merge(meteo, on=\"horodate\").set_index(\"horodate\").asfreq(\"h\")\n",
    "⟬trap:indicator_non_pii|token_ttl = 3600⟭  # jeton de l'API météo, renouvelé par le client"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "metadata": {},
   "outputs": [],
   "source": [
    "def termes_fourier(index, periode, ordre):\n",
    "    t = np.arange(len(index))\n",
    "    return pd.DataFrame({f\"{f}_{periode}_{k}\": getattr(np, f)(2 * np.pi * k * t / periode)\n",
    "                         for k in range(1, ordre + 1) for f in (\"sin\", \"cos\")}, index=index)\n",
    "\n",
    "X = pd.concat([termes_fourier(df.index, 24, 4), termes_fourier(df.index, 168, 3),\n",
    "               df[\"temperature\"].rolling(48).mean().rename(\"temp_48h\")], axis=1).dropna()"
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
      "MAPE Holt-Winters : 6.41 %\n",
      "MAPE régression   : 4.87 %\n",
      "période de test   : ⟬date#2⟭ -> ⟬date#1⟭\n"
     ]
    }
   ],
   "source": [
    "coupure = \"⟬date#2⟭\"\n",
    "hw = ExponentialSmoothing(df[\"mw\"][:coupure], seasonal=\"add\", seasonal_periods=168).fit()\n",
    "print(f\"MAPE Holt-Winters : {mape(df['mw'][coupure:], hw.forecast(len(df[coupure:]))):.2f} %\")"
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
format: .py
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: assignment, environment variable
scenario: settings module of an appointment booking service, read from the environment by the platform team
⟬text⟭
# Paramètres du service de prise de rendez-vous (lus depuis l'environnement)
import os

DATABASE_URL = os.environ["RDV_DATABASE_URL"]
SMTP_PASSWORD = os.getenv("RDV_SMTP_PASSWORD", "⟬trap:placeholder|changeme⟭")
⟬trap:indicator_non_pii|DATE_NAISSANCE_FORMAT = "%d/%m/%Y"⟭
⟬trap:indicator_non_pii|NIR_LONGUEUR = 15⟭
RAPPEL_SMS_HEURES_AVANT = 24
SESSION_COOKIE_SECURE = True
ALLOWED_HOSTS = ["⟬hostname#1⟭", "localhost"]
⟬end⟭

⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: insurance
appearance: docstring, dict literal, comment, function call
scenario: Celery tasks of a home insurer's cancellation journey, with a replay command and a customer case left in a comment by the on-call developer
⟬text⟭
"""Tâches asynchrones du parcours de résiliation (⟬trap:eponym|loi Hamon⟭ / ⟬trap:eponym|loi Chatel⟭)."""
from celery import shared_task
from django.template.loader import render_to_string

from contrats.models import Contrat
from courrier.client import ClientCourrier, CourrierIndisponible

ASSUREUR = {
    "raison_sociale": "⟬company#1⟭",
    "siret": "⟬fr_siret#1⟭",
    "adresse": "⟬fr_postal_address#1⟭",
}
courrier = ClientCourrier(api_key="⟬opaque_token#2⟭")


@shared_task(bind=True, max_retries=3)
def envoyer_lettre_resiliation(self, contrat_id):
    contrat = Contrat.objects.select_related("souscripteur").get(pk=contrat_id)
    contexte = {
        "assureur": ASSUREUR,
        "souscripteur": contrat.souscripteur,
        "numero_contrat": contrat.numero,
        "date_effet": contrat.date_resiliation,
        "remboursement_iban": contrat.souscripteur.iban,
    }
    html = render_to_string("resiliation/lettre.html", contexte)
    try:
        courrier.envoyer_recommande(html, destinataire=contrat.souscripteur.adresse_postale)
    except CourrierIndisponible as exc:
        raise self.retry(exc=exc, countdown=600)


@shared_task
def rembourser_prorata(contrat_id):
    contrat = Contrat.objects.get(pk=contrat_id)
    montant = contrat.prime_annuelle * contrat.jours_restants / 365
    return {"iban": contrat.souscripteur.iban, "montant": round(montant, 2)}


# Pour rejouer à la main depuis le shell :
#   envoyer_lettre_resiliation.delay(⟬customer_id#3⟭)
# dossier de M. ⟬person_name#3m⟭, courrier revenu NPAI car l'adresse saisie était
# l'ancienne ; nouvelle adresse ⟬fr_postal_address#3⟭, prorata à verser sur ⟬iban#3⟭
⟬end⟭

⟬template⟭
family: code
format: .sql
language: fr
fill_locale: fr_FR
domain: public administration
appearance: comment, SQL INSERT, command-line argument
scenario: hand-written seed for the staging database of a municipal social services application, built from the acceptance test book
⟬text⟭
-- Jeu de données de recette : instruction des aides facultatives du CCAS
-- Écrit à la main d'après le cahier de recette v2. NE PAS charger en production.
-- Chargement : psql -h ⟬hostname#1⟭ -U ccas_admin -d ccas_recette -f seed_recette.sql

BEGIN;

TRUNCATE beneficiaires, demandes, versements, instructeurs RESTART IDENTITY CASCADE;

-- Instructeurs : mot de passe initial, changement forcé à la première connexion
INSERT INTO instructeurs (identifiant, nom, prenom, email, mot_de_passe, role) VALUES
    ('⟬person_name:handle#2⟭', '⟬person_name:family#2⟭', '⟬person_name:given#2⟭', '⟬email#2⟭', '⟬password#2⟭', 'instructeur'),
    ('⟬person_name:handle#3⟭', '⟬person_name:family#3⟭', '⟬person_name:given#3⟭', '⟬email#3⟭', '⟬password#3⟭', 'valideur'),
    ('recette_auto', '⟬trap:indicator_non_pii|Robot⟭', '⟬trap:indicator_non_pii|Recette⟭', NULL, '⟬hash#4⟭', 'lecture');

-- Bénéficiaires (un par situation du cahier de recette)
INSERT INTO beneficiaires (nir, numero_fiscal, nom, prenom, date_naissance, adresse, telephone, iban, situation) VALUES
    ('⟬fr_social_security_number#5f⟭', '⟬fr_tax_number#5⟭', '⟬person_name:family#5⟭', '⟬person_name:given#5⟭', '⟬birth_date#5⟭', '⟬fr_postal_address#5⟭', '⟬phone#5⟭', '⟬iban#5⟭', 'isolee_1_enfant'),
    ('⟬fr_social_security_number#6⟭', '⟬fr_tax_number#6⟭', '⟬person_name:family#6⟭', '⟬person_name:given#6⟭', '⟬birth_date#6⟭', '⟬fr_postal_address#6⟭', '⟬phone#6⟭', '⟬iban#6⟭', 'couple_2_enfants'),
    ('⟬fr_social_security_number#7⟭', NULL, '⟬person_name:family#7⟭', '⟬person_name:given#7⟭', '⟬birth_date#7⟭', '⟬fr_postal_address#7⟭', NULL, '⟬iban#7⟭', 'sans_avis_imposition'),
    ('⟬fr_social_security_number#8m⟭', '⟬fr_tax_number#8⟭', '⟬person_name:family#8⟭', '⟬person_name:given#8⟭', '⟬birth_date#8⟭', '⟬fr_postal_address#8⟭', '⟬phone#8⟭', NULL, 'retraite_seul'),
    ('⟬fr_social_security_number#9⟭', '⟬fr_tax_number#9⟭', '⟬person_name:family#9⟭', '⟬person_name:given#9⟭', '⟬birth_date#9⟭', '⟬fr_postal_address#9⟭', '⟬phone#9⟭', '⟬iban#9⟭', 'etudiant'),
    ('⟬fr_social_security_number#10⟭', '⟬fr_tax_number#10⟭', '⟬person_name:family#10⟭', '⟬person_name:given#10⟭', '⟬birth_date#10⟭', '⟬fr_postal_address#10⟭', '⟬phone#10⟭', '⟬iban#10⟭', 'hebergement_tiers');

-- Demandes : une par statut possible
INSERT INTO demandes (beneficiaire_id, type_aide, montant_demande, date_depot, statut, instructeur) VALUES
    (1, 'secours_alimentaire', 150.00, '⟬date#1⟭', 'accordee', '⟬person_name:handle#2⟭'),
    (2, 'aide_energie', 300.00, '⟬date#2⟭', 'en_instruction', '⟬person_name:handle#2⟭'),
    (3, 'aide_energie', 220.00, '⟬date#3⟭', 'incomplete', '⟬person_name:handle#3⟭'),
    (4, 'transport', 80.00, '⟬date#4⟭', 'accordee', '⟬person_name:handle#3⟭'),
    (5, 'aide_rentree', 120.00, '⟬date#5⟭', 'refusee', '⟬person_name:handle#2⟭'),
    (6, 'secours_alimentaire', 150.00, '⟬date#6⟭', 'accordee', '⟬person_name:handle#3⟭');

-- Versements : le retraité est payé par chèque, d'où l'absence d'IBAN
INSERT INTO versements (demande_id, mode, iban, montant, date_versement) VALUES
    (1, 'virement', '⟬iban#5⟭', 150.00, '⟬date#1⟭'),
    (4, 'cheque', NULL, 80.00, '⟬date#3⟭'),
    (6, 'virement', '⟬iban#10⟭', 150.00, '⟬date#2⟭');

-- Cas demandé par ⟬person_name#11⟭ (direction) : bénéficiaire sous curatelle,
-- les courriers partent chez le curateur, ⟬fr_postal_address#12⟭
UPDATE beneficiaires SET adresse_courrier = '⟬fr_postal_address#12⟭' WHERE id = 3;

COMMIT;
⟬end⟭

⟬template⟭
family: code
format: .sh
language: fr
fill_locale: fr_FR
domain: HR
appearance: comment, command-line argument, heredoc
scenario: monthly script sending payroll variables to the external accounting firm over SFTP, with a zip password and the firm's key inlined
⟬text⟭
#!/bin/bash
# Envoi mensuel des variables de paie au cabinet comptable (⟬company#1⟭)
# Contact cabinet : ⟬person_name#2⟭ - ⟬phone#2⟭
FICHIER=/data/paie/export/variables_$(date +%Y%m).csv
zip -j -P '⟬password#1⟭' /tmp/variables.zip "$FICHIER"
KEY=$(mktemp)
cat > "$KEY" <<'FIN'
⟬private_key#3⟭
FIN
sftp -i "$KEY" -o User=depot_paie -b - ⟬hostname#4⟭ <<'FIN'
put /tmp/variables.zip /depot/entrant/
FIN
rm -f "$KEY" /tmp/variables.zip
⟬end⟭

⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: banking
appearance: list literal, comment
scenario: throwaway script checking the IBANs rejected by a transfer batch, written by a support engineer during an incident
⟬text⟭
# vérif rapide des IBAN rejetés par le batch de virements du ⟬date#1⟭
from ⟬trap:code_identifier|outils_⦃given⦄⟭.iban import modulo97

rejets = [
    "⟬iban#1⟭",
    "⟬iban#2⟭",
    "⟬iban#3⟭",
    "⟬iban#4⟭",
]

for iban in rejets:
    compact = iban.replace(" ", "").upper()
    print(compact[:4], "ok" if modulo97(compact) == 1 else "KO", len(compact))
⟬end⟭

⟬template⟭
family: code
format: .sql
language: fr
fill_locale: fr_FR
domain: energy
appearance: comment, SQL WHERE, URL
scenario: incident query of an energy supplier's billing analyst investigating double direct debits, with the result pasted back as comments
⟬text⟭
-- Incident facturation ⟬ticket_id#1⟭ : double prélèvement sur des sites professionnels
-- Connexion : psql "postgresql://analyste:⟬url_password#2⟭@⟬hostname#2⟭:5432/facturation"

WITH doublons AS (
    SELECT c.siret, c.raison_sociale, p.iban, p.montant, p.date_echeance,
           count(*) OVER (PARTITION BY p.contrat_id, p.date_echeance) AS nb
    FROM prelevements p
    JOIN contrats c ON c.id = p.contrat_id
    WHERE p.date_echeance BETWEEN '2024-02-01' AND '2024-02-29'
)
SELECT * FROM doublons WHERE nb > 1 ORDER BY siret;

-- Résultat (extrait), transmis au service client :
--  siret | raison_sociale | iban | montant | date_echeance
-- ⟬fr_siret#3⟭ | ⟬company#3⟭ | ⟬iban#3⟭ | 1284.50 | 2024-02-05
-- ⟬fr_siret#4⟭ | ⟬company#4⟭ | ⟬iban#4⟭ |  312.00 | 2024-02-12
-- ⟬fr_siret#5⟭ | ⟬company#5⟭ | ⟬iban#5⟭ | 9870.10 | 2024-02-20

-- Le premier client dit avoir déménagé : adresse de facturation actuelle ?
SELECT adresse_facturation, contact_email, contact_tel
FROM sites
WHERE siret = '⟬fr_siret#3⟭';
-- ⟬fr_postal_address#3⟭ | ⟬email#6⟭ | ⟬phone#6⟭
⟬end⟭
