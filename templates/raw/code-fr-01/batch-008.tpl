⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: public administration
appearance: HTTP header, comment, CSV cell
scenario: script of a town hall's communication team syncing the elected officials directory to the city website, with an extract of the source spreadsheet in a comment
⟬text⟭
"""Synchronisation de l'annuaire des élus vers le site de la ville (CMS).

Source : tableur tenu par le cabinet du maire, exporté en CSV après chaque conseil.
Seules les colonnes acceptées par les élus sont publiées (nom, délégation, permanence).
"""
import csv

import requests

CMS = "https://⟬hostname#1⟭/api/elus"
JETON_CMS = "⟬opaque_token#1⟭"
CHAMPS_PUBLIES = ("nom", "fonction", "delegation", "email_mairie", "permanence")


def lire(chemin):
    with open(chemin, encoding="utf-8-sig") as f:
        return list(csv.DictReader(f, delimiter=";"))


def publier(elus):
    for e in elus:
        corps = {k: e[k] for k in CHAMPS_PUBLIES}
        r = requests.put(f"{CMS}/{e['id']}", json=corps, headers={"Authorization": f"Token {JETON_CMS}"}, timeout=15)
        r.raise_for_status()


if __name__ == "__main__":
    publier(lire("elus.csv"))

# Lignes de l'export du ⟬date#1⟭ (le tableur contient aussi des colonnes non publiées) :
# id;nom;fonction;delegation;email_mairie;tel_perso;date_naissance;permanence
# 1;⟬person_name#2⟭;Maire;;⟬email#2⟭;⟬phone#2⟭;⟬birth_date#2⟭;"⟬fr_postal_address#3⟭"
# 4;⟬person_name#4f⟭;Adjointe;Écoles et petite enfance;⟬email#4⟭;⟬phone#4⟭;⟬birth_date#4⟭;"⟬fr_postal_address#3⟭"
# 9;⟬person_name#5m⟭;Conseiller délégué;Sports;⟬email#5⟭;;⟬birth_date#5⟭;
⟬end⟭

⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: insurance
appearance: assignment, comment, function call
scenario: deduplication script of a disability insurer for self-employed workers, run after two brokers created the same insureds
⟬text⟭
"""Détection des doublons d'assurés dans le portefeuille prévoyance des indépendants.

Un même assuré peut avoir été créé par deux courtiers : on rapproche sur le NIR,
puis sur nom + date de naissance quand le NIR manque.
"""
import pandas as pd

assures = pd.read_parquet("⟬file_path#1⟭")
assures["nir"] = assures["nir"].str.replace(" ", "", regex=False)

par_nir = assures[assures["nir"].notna() & assures.duplicated("nir", keep=False)]
sans_nir = assures[assures["nir"].isna()]
par_identite = sans_nir[sans_nir.duplicated(["nom", "date_naissance"], keep=False)]

doublons = pd.concat([par_nir.assign(regle="nir"), par_identite.assign(regle="identite")])
doublons.sort_values(["regle", "nir", "nom"]).to_csv("doublons_prevoyance.csv", index=False, sep=";")
print(len(doublons), "lignes en doublon")

# Extrait vérifié à la main avec le service gestion (⟬date#1⟭) :
#   ⟬fr_social_security_number#2⟭ ⟬person_name#2⟭ ⟬birth_date#2⟭ SIRET ⟬fr_siret#2⟭ (courtier A) / SIRET ⟬fr_siret#3⟭ (courtier B)
#     -> même personne, deux activités ; cotisations prélevées sur ⟬iban#2⟭ pour les deux contrats
#   ⟬person_name#4⟭ ⟬birth_date#4⟭ sans NIR, numéro fiscal ⟬fr_tax_number#4⟭ sur les deux fiches -> fusion
⟬end⟭

⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: energy
appearance: environment variable, triple-quoted string, query string
scenario: quick client of an EV charging operator's IoT gateway using mutual TLS, with the key as a fallback default in the code
⟬text⟭
# Client de la passerelle IoT des bornes de recharge (authentification mTLS)
import os
import tempfile

import requests

CLE = os.environ.get("CLE_PASSERELLE", """⟬private_key#1⟭""")
CERT = "/etc/irve/client.crt"

with tempfile.NamedTemporaryFile("w", suffix=".pem", delete=False) as f:
    f.write(CLE)
session = requests.Session()
session.cert = (CERT, f.name)
print(session.get("https://⟬hostname#2⟭/v1/bornes?etat=hors_service", timeout=10).json())
⟬end⟭

⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: banking
appearance: class attribute, assignment
scenario: settings class of a bank's customer notification service, read from the environment with pydantic-settings
⟬text⟭
"""Configuration du service de notifications clients (lue depuis l'environnement)."""
from pydantic import SecretStr
from pydantic_settings import BaseSettings, SettingsConfigDict


class Reglages(BaseSettings):
    model_config = SettingsConfigDict(env_prefix="NOTIF_", env_file=".env")

    smtp_hote: str = "localhost"
    smtp_port: int = 587
    ⟬trap:indicator_non_pii|smtp_user: str = "notifications"⟭
    smtp_password: SecretStr = SecretStr("⟬trap:placeholder|<à renseigner>⟭")
    iban_emetteur: str = ""
    expediteur_sms: str = "BANQUE"
    ⟬trap:indicator_non_pii|token_ttl_secondes: int = 900⟭


reglages = Reglages()
⟬end⟭

⟬template⟭
family: code
format: .sql
language: fr
fill_locale: fr_FR
domain: HR
appearance: SQL WHERE, comment, pipe-delimited record
scenario: yearly query of an HR department listing employees eligible for the long service medal, with the list sent to the prefecture pasted below
⟬text⟭
-- Médaille d'honneur du travail : salariés atteignant 20, 30, 35 ou 40 ans d'activité cette année
-- Liste à envoyer à la préfecture avant le 1er mai ; diplômes expédiés au domicile.
SELECT s.matricule,
       s.nom,
       s.prenom,
       s.date_naissance,
       s.adresse,
       s.email,
       date_part('year', age(make_date(date_part('year', CURRENT_DATE)::int, 12, 31), s.debut_activite)) AS annees
  FROM salaries s
 WHERE s.actif
   AND date_part('year', age(make_date(date_part('year', CURRENT_DATE)::int, 12, 31), s.debut_activite)) IN (20, 30, 35, 40)
 ORDER BY annees DESC, s.nom;

-- Résultat transmis le ⟬date#1⟭ :
-- ⟬customer_id#2⟭ | ⟬person_name:family#2⟭ | ⟬person_name:given#2⟭ | ⟬birth_date#2⟭ | ⟬fr_postal_address#2⟭ | ⟬email#2⟭ | 40
-- ⟬customer_id#3⟭ | ⟬person_name:family#3⟭ | ⟬person_name:given#3⟭ | ⟬birth_date#3⟭ | ⟬fr_postal_address#3⟭ | ⟬email#3⟭ | 30
-- ⟬customer_id#4⟭ | ⟬person_name:family#4⟭ | ⟬person_name:given#4⟭ | ⟬birth_date#4⟭ | ⟬fr_postal_address#4⟭ | NULL | 20
⟬end⟭

⟬template⟭
family: code
format: .sql
language: fr
fill_locale: fr_FR
domain: banking
appearance: comment, SQL string
scenario: temporary read access granted to the statutory auditors on a bank's general ledger database
⟬text⟭
-- Accès temporaire en lecture pour l'audit des commissaires aux comptes (mission ⟬ticket_id#1⟭)
-- Cabinet : ⟬company#2⟭, SIRET ⟬fr_siret#2⟭ ; auditrice : ⟬person_name#3f⟭ (⟬email#3⟭)
CREATE ROLE audit_cac LOGIN PASSWORD '⟬password#4⟭' VALID UNTIL '⟬date#1⟭';
GRANT CONNECT ON DATABASE compta TO audit_cac;
GRANT USAGE ON SCHEMA grand_livre TO audit_cac;
GRANT SELECT ON ALL TABLES IN SCHEMA grand_livre TO audit_cac;
⟬end⟭

⟬template⟭
family: code
format: .sql
language: fr
fill_locale: fr_FR
domain: energy
appearance: column definition, SQL INSERT, comment
scenario: reference tables of a green electricity retailer for tariff options and partner producers
⟬text⟭
-- Référentiel des options tarifaires et des producteurs partenaires (offre verte)
CREATE TABLE options_tarifaires (
    code              VARCHAR(10) PRIMARY KEY,
    libelle           VARCHAR(60) NOT NULL,
    abonnement_mois   NUMERIC(8,2) NOT NULL,
    prix_kwh_hp       NUMERIC(8,5) NOT NULL,
    prix_kwh_hc       NUMERIC(8,5),
    valide_du         DATE NOT NULL
);

INSERT INTO options_tarifaires VALUES
    ('BASE6', 'Base 6 kVA',           12.44, 0.25160, NULL,    '⟬date#2⟭'),
    ('HPHC6', 'Heures creuses 6 kVA', 12.85, 0.27000, 0.20680, '⟬date#2⟭'),
    ('HPHC9', 'Heures creuses 9 kVA', 16.55, 0.27000, 0.20680, '⟬date#2⟭');

CREATE TABLE producteurs_partenaires (
    id            SERIAL PRIMARY KEY,
    nom           VARCHAR(80) NOT NULL,
    filiere       VARCHAR(20) NOT NULL CHECK (filiere IN ('hydraulique', 'eolien', 'solaire', 'biomasse')),
    puissance_mw  NUMERIC(7,2),
    ⟬trap:indicator_non_pii|contact       VARCHAR(80) DEFAULT 'service achats'⟭
);

INSERT INTO producteurs_partenaires (nom, filiere, puissance_mw) VALUES
    ('⟬trap:company_name|Moulin ⦃Family⦄⟭', 'hydraulique', 1.20),
    ('Parc éolien des Crêtes', 'eolien', 24.00),
    ('Centrale solaire du Plateau', 'solaire', 8.50);

-- garanties d'origine mises à jour, publiées le ⟬date#1⟭
⟬end⟭

⟬template⟭
family: code
format: .ipynb
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: URL, HTTP header, notebook output, markdown cell
scenario: occupational health notebook of a hospital measuring flu vaccination coverage of care staff and preparing reminders
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Santé au travail : couverture vaccinale grippe des soignants\n",
    "\n",
    "Campagne d'automne. Données de santé : notebook à garder sur le partage du service uniquement."
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
    "from sqlalchemy import create_engine\n",
    "\n",
    "sirh = create_engine(\"postgresql://sante_travail:⟬url_password#1⟭@⟬hostname#1⟭/sirh\")\n",
    "agents = pd.read_sql(\"SELECT matricule, nom, date_naissance, service, email FROM agents WHERE filiere = 'soignante' AND actif\", sirh)\n",
    "vacc = pd.DataFrame(requests.get(\"https://⟬hostname#2⟭/api/vaccinations\", params={\"campagne\": \"grippe\"},\n",
    "                                 headers={\"Authorization\": \"Bearer ⟬opaque_token#2⟭\"}, timeout=30).json())\n",
    "suivi = agents.merge(vacc, on=\"matricule\", how=\"left\")"
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
       "service\n",
       "Gériatrie        0.61\n",
       "Pédiatrie        0.48\n",
       "Réanimation      0.72\n",
       "Urgences         0.39\n",
       "Name: vaccine, dtype: float64"
      ]
     },
     "execution_count": 2,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "suivi[\"vaccine\"] = suivi[\"date_injection\"].notna()\n",
    "suivi.groupby(\"service\")[\"vaccine\"].mean().round(2)"
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
       "   nom  date_naissance  service  email\n",
       "0  ⟬person_name#3⟭  ⟬birth_date#3⟭  Urgences  ⟬email#3⟭\n",
       "1  ⟬person_name#4⟭  ⟬birth_date#4⟭  Urgences  ⟬email#4⟭\n",
       "2  ⟬person_name#5⟭  ⟬birth_date#5⟭  Pédiatrie  ⟬email#5⟭"
      ]
     },
     "execution_count": 3,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "non_vaccines = suivi[~suivi[\"vaccine\"]]\n",
    "non_vaccines[[\"nom\", \"date_naissance\", \"service\", \"email\"]].head(3)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Texte de relance validé par ⟬person_name#6⟭ (médecin du travail) ; envoi groupé lundi."
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
format: .sh
language: fr
fill_locale: fr_FR
domain: public administration
appearance: URL, command-line argument, comment, CSV cell
scenario: script of a town's elections office sending an extract of the electoral roll to a candidate who requested it, as the electoral code allows
⟬text⟭
#!/usr/bin/env bash
# Communication de la liste électorale à un candidat (article L37 du code électoral).
# Usage : ./extrait_liste.sh <bureau|tous> <email_demandeur>
set -euo pipefail
BUREAU=${1:?bureau manquant}
DEST=${2:?email du demandeur manquant}
F=/tmp/liste_electorale_${BUREAU}_$(date +%F).csv

psql "postgresql://elections_ro:⟬url_password#1⟭@⟬hostname#1⟭/elections" -At -F ';' -c "
  SELECT bureau, nom_naissance, nom_usage, prenoms, date_naissance, lieu_naissance, adresse
    FROM electeurs
   WHERE NOT radie AND ('$BUREAU' = 'tous' OR bureau = '$BUREAU')
   ORDER BY bureau, nom_naissance" > "$F"

# le mot de passe de l'archive est communiqué à part, par téléphone
7z a -p'⟬password#2⟭' -mhe=on "$F.7z" "$F" >/dev/null
rm -f "$F"
curl -s -F "file=@$F.7z" -F "destinataire=$DEST" "https://⟬hostname#3⟭/depot" >/dev/null
echo "extrait $BUREAU envoyé à $DEST"

# Format d'une ligne (contrôle du ⟬date#1⟭) :
# 03;⟬person_name:family#4⟭;;⟬person_name:given#4⟭;⟬birth_date#4⟭;⟬city#5⟭;⟬fr_postal_address#4⟭
# Dernière demande : ⟬person_name#6⟭, tête de liste, ⟬email#6⟭
⟬end⟭

⟬template⟭
family: code
format: .sh
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: environment variable, command-line argument
scenario: Nagios probe checking that a hospital's nightly imaging archive backup is recent enough
⟬text⟭
#!/bin/sh
# Sonde Nagios : la sauvegarde nocturne du PACS doit dater de moins de 26 h
⟬trap:indicator_non_pii|NAGIOS_USER=nagios⟭
DERNIERE=$(find /mnt/sauvegardes/pacs -name 'pacs_*.tar.zst' -mmin -1560 | sort | tail -1)
if [ -z "$DERNIERE" ]; then
  echo "CRITICAL - aucune sauvegarde PACS de moins de 26 h"
  curl -s -u "$NAGIOS_USER:⟬trap:placeholder|${NAGIOS_TOKEN}⟭" -d "etat=2" "https://⟬hostname#1⟭/nrdp/" >/dev/null
  exit 2
fi
echo "OK - $(basename "$DERNIERE") ($(du -h "$DERNIERE" | cut -f1))"
exit 0
⟬end⟭
