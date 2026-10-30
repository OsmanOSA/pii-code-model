⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: insurance
appearance: nested dict, log message, comment, curl command, HTTP header
scenario: FastAPI router of a home insurer's claim declaration API, whose OpenAPI example carries a full policyholder and whose bottom comment keeps a test call
⟬text⟭
"""API de déclaration de sinistre habitation (v2)."""
import logging
from datetime import date
from typing import Optional

from fastapi import APIRouter, Depends, HTTPException, status
from pydantic import BaseModel, ConfigDict, Field

from .auth import utilisateur_courant
from .depot import ContratIntrouvable, DepotSinistres

log = logging.getLogger("sinistres.api")
router = APIRouter(prefix="/v2/sinistres", tags=["sinistres"])


class Declaration(BaseModel):
    model_config = ConfigDict(json_schema_extra={
        "example": {
            "numero_contrat": "⟬order_number#1⟭",
            "assure": {
                "nom": "⟬person_name#1⟭",
                "date_naissance": "⟬birth_date#1⟭",
                "email": "⟬email#1⟭",
                "telephone": "⟬phone#1⟭",
            },
            "lieu": "⟬fr_postal_address#1⟭",
            "date_survenance": "⟬date#1⟭",
            "nature": "degat_des_eaux",
            "iban_indemnisation": "⟬iban#1⟭",
        }
    })

    numero_contrat: str
    assure: dict
    lieu: str
    date_survenance: date
    nature: str = Field(pattern="^(degat_des_eaux|incendie|vol|bris_de_glace)$")
    iban_indemnisation: Optional[str] = None


@router.post("", status_code=status.HTTP_201_CREATED)
def declarer(decl: Declaration, depot: DepotSinistres = Depends(), user=Depends(utilisateur_courant)):
    try:
        sinistre = depot.creer(decl, cree_par=user.id)
    except ContratIntrouvable:
        log.warning("contrat %s introuvable pour %s", decl.numero_contrat, decl.assure.get("email"))
        raise HTTPException(status_code=404, detail=f"Contrat {decl.numero_contrat} inconnu")
    return {"id": sinistre.id, "statut": sinistre.statut}


# Test manuel (le jeton expire au bout d'une heure) :
# curl -X POST https://⟬hostname#2⟭/v2/sinistres \
#   -H "Authorization: Bearer ⟬jwt#2⟭" -H "Content-Type: application/json" \
#   -d @exemple_declaration.json
⟬end⟭

⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: banking
appearance: comment, fixed-width record, assignment, triple-quoted string, URL
scenario: legacy batch of a private bank producing the yearly tax statement file for securities income, ported from COBOL and patched for years
⟬text⟭
#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# generer_ifu.py - production du fichier IFU annuel (revenus de capitaux mobiliers)
# Repris de l'ancien batch COBOL en 2016. NE PAS toucher au format des lignes !!
#
# Exemple d'enregistrement bénéficiaire (extrait des positions 1 à 120) :
#   R ⟬fr_tax_number#1⟭ ⟬person_name:family#1⟭ ⟬person_name:given#1⟭ ⟬birth_date#1⟭ 0000124350
#
import os, sys
import datetime
import ftplib
from io import StringIO
from urllib.parse import urlparse

import paramiko
import psycopg2

ANNEE = datetime.date.today().year - 1
DSN = "dbname=titres host=⟬hostname#2⟭ user=ifu_batch password=⟬password#2⟭"

# dépôt sur la plateforme d'échange (clé fournie par la sécu, à sortir du code un jour...)
SFTP_HOTE = "⟬hostname#3⟭"
SFTP_USER = "⟬username#3⟭"
SFTP_CLE = """⟬private_key#3⟭"""

# copie d'archive, l'ancien serveur FTP tourne toujours
ARCHIVE = "ftp://archive_ifu:⟬url_password#4⟭@⟬hostname#4⟭/ifu/"

LARGEURS = [("type", 1), ("numero_fiscal", 13), ("nom", 30), ("prenom", 20), ("naissance", 8), ("montant", 10)]


def lignes_beneficiaires(cur):
    cur.execute("""
        SELECT b.numero_fiscal, b.nom, b.prenom, b.date_naissance, sum(r.montant_cents)
          FROM revenus r JOIN beneficiaires b ON b.id = r.beneficiaire_id
         WHERE extract(year from r.date_paiement) = %s
         GROUP BY 1,2,3,4
    """, (ANNEE,))
    for rec in cur:
        yield rec


def formater(rec):
    numero_fiscal, nom, prenom, naissance, montant = rec
    champs = ["R", numero_fiscal, nom.upper(), prenom.upper(), naissance.strftime("%Y%m%d"), str(montant).zfill(10)]
    return "".join(str(v)[:l].ljust(l) for v, (_, l) in zip(champs, LARGEURS))


def deposer(chemin):
    cle = paramiko.RSAKey.from_private_key(StringIO(SFTP_CLE))
    transport = paramiko.Transport((SFTP_HOTE, 22))
    transport.connect(username=SFTP_USER, pkey=cle)
    sftp = paramiko.SFTPClient.from_transport(transport)
    sftp.put(chemin, "/depot/ifu/" + os.path.basename(chemin))
    transport.close()


def archiver(chemin):
    u = urlparse(ARCHIVE)
    ftp = ftplib.FTP(u.hostname, u.username, u.password)
    with open(chemin, "rb") as f:
        ftp.storbinary("STOR " + u.path + os.path.basename(chemin), f)
    ftp.quit()


def main():
    sortie = "/data/ifu/IFU_%d.txt" % ANNEE
    cnx = psycopg2.connect(DSN)
    cur = cnx.cursor()
    n = 0
    with open(sortie, "w", encoding="latin-1") as f:
        for rec in lignes_beneficiaires(cur):
            # DEBUG ⟬date#1⟭ : dossier contesté, compte titres ⟬bank_account_number#5⟭
            # if rec[0] == '⟬fr_tax_number#5⟭':
            #     print rec
            f.write(formater(rec) + "\r\n")
            n += 1
    print("%d enregistrements écrits dans %s" % (n, sortie))
    if "--sans-depot" not in sys.argv:
        deposer(sortie)
        archiver(sortie)


if __name__ == '__main__':
    main()
⟬end⟭

⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: HR
appearance: docstring, log message, exception message, comment, CSV cell
scenario: import script pushing the recruiting firm's weekly new-hire CSV into the HRIS API, with the last run's errors pasted at the bottom
⟬text⟭
"""Import des nouveaux arrivants envoyés par le cabinet de recrutement.

Le cabinet dépose chaque lundi un CSV (séparateur ;) sur le partage RH.
Colonnes : nom;prenom;date_naissance;nir;adresse;iban;poste;date_entree
"""
import csv
import logging
import sys

import requests

SIRH_API = "⟬url#1⟭"
SIRH_COMPTE = "import_recrutement"
SIRH_MDP = "⟬password#1⟭"

log = logging.getLogger("import_arrivants")


def lire(chemin):
    with open(chemin, encoding="utf-8-sig") as f:
        yield from csv.DictReader(f, delimiter=";")


def creer_salarie(ligne):
    corps = {
        "identite": {"nom": ligne["nom"], "prenom": ligne["prenom"], "naissance": ligne["date_naissance"]},
        "nir": ligne["nir"].replace(" ", ""),
        "adresse": ligne["adresse"],
        "banque": {"iban": ligne["iban"].replace(" ", "")},
        "contrat": {"poste": ligne["poste"], "debut": ligne["date_entree"]},
    }
    r = requests.post(f"{SIRH_API}/salaries", json=corps, auth=(SIRH_COMPTE, SIRH_MDP), timeout=20)
    if r.status_code == 409:
        log.warning("déjà présent dans le SIRH : %s %s", ligne["nom"], ligne["prenom"])
        return None
    r.raise_for_status()
    return r.json()["matricule"]


def main(chemin):
    for ligne in lire(chemin):
        try:
            matricule = creer_salarie(ligne)
        except requests.HTTPError as e:
            log.error("échec pour %s : %s", ligne["nir"], e.response.text)
            continue
        if matricule:
            log.info("créé %s -> %s", ligne["nom"], matricule)


if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO)
    main(sys.argv[1])

# Dernier passage (⟬date#1⟭), deux rejets :
#   ERROR échec pour ⟬fr_social_security_number#2⟭ : {"erreur": "IBAN invalide", "valeur": "⟬iban#2⟭"}
#   WARNING déjà présent dans le SIRH : ⟬person_name:family#3⟭ ⟬person_name:given#3⟭
# Ligne de test à remettre dans le CSV de recette :
#   ⟬person_name:family#4⟭;⟬person_name:given#4⟭;⟬birth_date#4⟭;⟬fr_social_security_number#4f⟭;"⟬fr_postal_address#4⟭";⟬iban#4⟭;Technicienne support;⟬date#2⟭
⟬end⟭

⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: public administration
appearance: doctest, docstring
scenario: validation helpers of a public agency's form backend, documented with doctests that use sample identifiers
⟬text⟭
def cle_nir(nir13: str) -> int:
    """Clé de contrôle du NIR : 97 moins le reste de la division par 97.

    La Corse (2A, 2B) est remplacée par 19 et 18 avant le calcul.

    >>> nir_valide("⟬fr_social_security_number#1⟭")
    True
    >>> nir_valide("⟬fr_social_security_number#2⟭"[:-2] + "00")
    False
    """
    n = int(nir13.upper().replace("2A", "19").replace("2B", "18"))
    return 97 - n % 97


def nir_valide(nir: str) -> bool:
    nir = nir.replace(" ", "")
    return len(nir) == 15 and cle_nir(nir[:13]) == int(nir[13:])


def numero_fiscal_valide(spi: str) -> bool:
    """>>> numero_fiscal_valide("⟬fr_tax_number#3⟭")
    True
    >>> numero_fiscal_valide("⟬fr_tax_number#4⟭"[:12])
    False
    """
    spi = spi.replace(" ", "")
    return len(spi) == 13 and spi.isdigit() and spi[0] in "0123"
⟬end⟭

⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: energy
appearance: assignment, keyword argument, query string, comment
scenario: legacy Flask customer portal of a solar panel installer, with a demo-data command written for a trade show
⟬text⟭
"""Portail client ⟬company#1⟭ : suivi des installations photovoltaïques.

Application ⟬trap:library|Flask⟭ historique, en cours de migration vers le nouveau front.
"""
import os

from flask import Flask, abort, jsonify, request
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
app.config.update(
    SECRET_KEY="⟬opaque_token#2⟭",
    SQLALCHEMY_DATABASE_URI=os.getenv("PORTAIL_DB", "mysql+pymysql://portail:⟬url_password#3⟭@⟬hostname#3⟭/portail"),
    SQLALCHEMY_TRACK_MODIFICATIONS=False,
)
db = SQLAlchemy(app)


class Client(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    nom = db.Column(db.String(120), nullable=False)
    email = db.Column(db.String(160), unique=True)
    telephone = db.Column(db.String(20))
    adresse_site = db.Column(db.String(255))
    siret = db.Column(db.String(14))  # vide pour les particuliers


class Installation(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    client_id = db.Column(db.Integer, db.ForeignKey("client.id"))
    puissance_kwc = db.Column(db.Float)
    mise_en_service = db.Column(db.Date)
    numero_onduleur = db.Column(db.String(40))


⟬trap:email_lookalike|@app.route⟭("/api/clients/<int:client_id>/installations")
def installations(client_id):
    rows = Installation.query.filter_by(client_id=client_id).all()
    return jsonify([
        {"id": i.id, "kwc": i.puissance_kwc, "mes": i.mise_en_service.isoformat()} for i in rows
    ])


⟬trap:email_lookalike|@app.route⟭("/api/pro")
def recherche_pro():
    siret = request.args.get("siret", "")
    if len(siret) != 14 or not siret.isdigit():
        abort(400)
    client = Client.query.filter_by(siret=siret).first_or_404()
    return jsonify(id=client.id, nom=client.nom)


⟬trap:email_lookalike|@app.cli.command⟭("demo")
def creer_donnees_demo():
    """Données de démonstration pour les commerciaux (salon du ⟬date#1⟭)."""
    db.create_all()
    clients = [
        Client(nom="⟬person_name#4⟭", email="⟬email#4⟭", telephone="⟬phone#4⟭",
               adresse_site="⟬fr_postal_address#4⟭"),
        Client(nom="⟬person_name#5⟭", email="⟬email#5⟭", telephone="⟬phone#5⟭",
               adresse_site="⟬fr_postal_address#5⟭"),
        Client(nom="⟬company#6⟭", email="⟬email:generic#6⟭", telephone="⟬phone#6⟭",
               adresse_site="⟬fr_postal_address#6⟭", siret="⟬fr_siret#6⟭"),
    ]
    db.session.add_all(clients)
    db.session.commit()
    print(f"{len(clients)} clients de démo créés")


# essai : curl "https://⟬hostname#7⟭/api/pro?siret=⟬fr_siret#6⟭"
⟬end⟭

⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: test fixture, nested dict, assertion
scenario: unittest module of a hospital interface engine converting patient records to FHIR resources, with one full patient as fixture
⟬text⟭
import unittest

from passerelle.fhir import patient_vers_fhir

DOSSIER = {
    "ipp": "⟬customer_id#1⟭",
    "ins": "⟬fr_social_security_number#1m⟭",
    "nom_naissance": "⟬person_name:family#1⟭",
    "prenoms": ["⟬person_name:given#1⟭"],
    "sexe": "M",
    "naissance": "⟬birth_date#1⟭",
    "adresse": {"ligne": "⟬fr_postal_address:street#1⟭", "cp": "⟬postcode#1⟭", "ville": "⟬city#1⟭"},
    "telecom": [{"type": "mobile", "valeur": "⟬phone#1⟭"}],
    "medecin_traitant": "Dr ⟬person_name#2⟭",
}


class TestPatientFhir(unittest.TestCase):
    def setUp(self):
        self.res = patient_vers_fhir(DOSSIER)

    def test_type_de_ressource(self):
        self.assertEqual(self.res["resourceType"], "Patient")

    def test_identifiant_ins(self):
        ident = self.res["identifier"][0]
        self.assertEqual(ident["system"], "urn:oid:1.2.250.1.213.1.4.8")
        self.assertEqual(ident["value"], "⟬fr_social_security_number#1⟭")

    def test_nom_et_prenoms(self):
        self.assertEqual(self.res["name"][0]["family"], "⟬person_name:family#1⟭")
        self.assertEqual(self.res["name"][0]["given"], ["⟬person_name:given#1⟭"])

    def test_date_naissance_iso(self):
        self.assertRegex(self.res["birthDate"], r"^\d{4}-\d{2}-\d{2}$")

    def test_adresse(self):
        adresse = self.res["address"][0]
        self.assertEqual(adresse["line"], ["⟬fr_postal_address:street#1⟭"])
        self.assertEqual(adresse["postalCode"], "⟬postcode#1⟭")

    def test_medecin_traitant_absent_de_la_ressource(self):
        self.assertNotIn("generalPractitioner", self.res)


if __name__ == "__main__":
    unittest.main()
⟬end⟭

⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: insurance
appearance: HTTP header, f-string, function call
scenario: small reminder script of a mutual insurer texting members whose school certificate is missing, written by a support developer
⟬text⟭
import requests

# relance des adhérents dont l'attestation de scolarité n'est pas arrivée
PASSERELLE = "https://⟬hostname#1⟭/v1/sms"
ENTETES = {"X-Client-Ref": "⟬opaque_token#1⟭", "Content-Type": "application/json"}
⟬trap:indicator_non_pii|EXPEDITEUR = "MUTUELLE"⟭


def relancer(numero, prenom):
    texte = f"Bonjour {prenom}, il nous manque votre attestation de scolarité. Déposez-la sur votre espace adhérent."
    return requests.post(PASSERELLE, headers=ENTETES, json={"from": EXPEDITEUR, "to": numero, "text": texte}, timeout=10)


if __name__ == "__main__":
    print(relancer("⟬phone#2⟭", "⟬person_name:given#2⟭").status_code)
⟬end⟭

⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: banking
appearance: docstring, assignment, f-string
scenario: shared IBAN utility module of a bank's back office, used by several services for normalisation, checksum and display masking
⟬text⟭
"""Outils IBAN : normalisation, contrôle de clé, masquage pour l'affichage.

Le masquage suit la règle validée par la sécurité : seuls le code pays et les
trois derniers caractères restent lisibles, par exemple
``⟬trap:placeholder|FR76 **** **** **** **** **** 042⟭``.
"""
import re
import string

⟬trap:indicator_non_pii|IBAN_FR_LONGUEUR = 27⟭
_FORMAT = re.compile(r"^[A-Z]{2}[0-9]{2}[A-Z0-9]{11,30}$")
_LETTRES = {c: str(i) for i, c in enumerate(string.ascii_uppercase, start=10)}


def normaliser(iban: str) -> str:
    return re.sub(r"\s+", "", iban).upper()


def cle_valide(iban: str) -> bool:
    iban = normaliser(iban)
    if not _FORMAT.match(iban):
        return False
    if iban.startswith("FR") and len(iban) != IBAN_FR_LONGUEUR:
        return False
    reorganise = iban[4:] + iban[:4]
    return int("".join(_LETTRES.get(c, c) for c in reorganise)) % 97 == 1


def masquer(iban: str) -> str:
    iban = normaliser(iban)
    milieu = re.sub(r"[A-Z0-9]", "*", iban[4:-3])
    groupes = iban[:4] + milieu + iban[-3:]
    return " ".join(groupes[i:i + 4] for i in range(0, len(groupes), 4))


def depuis_rib(code_banque: str, code_guichet: str, numero_compte: str, cle_rib: str) -> str:
    """Construit un IBAN français à partir des quatre zones du RIB."""
    bban = f"{code_banque}{code_guichet}{numero_compte}{cle_rib}".upper()
    convertible = "".join(_LETTRES.get(c, c) for c in bban + "FR00")
    cle = 98 - int(convertible) % 97
    return f"FR{cle:02d}{bban}"
⟬end⟭

⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: HR
appearance: docstring, assignment, comment
scenario: logging filter of an HR platform masking sensitive JSON fields before they reach the log files
⟬text⟭
"""Filtre de journalisation : masque les champs sensibles avant l'écriture."""
import logging
import re

CHAMPS_SENSIBLES = ("nir", "iban", "date_naissance", "mot_de_passe", "telephone")
_MOTIF = re.compile(r'("(?:%s)"\s*:\s*")[^"]*(")' % "|".join(CHAMPS_SENSIBLES))


class MasquageFiltre(logging.Filter):
    """Remplace la valeur des champs sensibles par des étoiles."""

    def filter(self, record):
        record.msg = _MOTIF.sub(r"\1***\2", str(record.msg))
        return True


# ce qui doit sortir dans les journaux : {"matricule": "⟬customer_id#1⟭", ⟬trap:placeholder|"nir": "***"⟭}
⟬trap:indicator_non_pii|LOGGER_USER = "svc-sirh"⟭
logging.getLogger(LOGGER_USER).addFilter(MasquageFiltre())
⟬end⟭

⟬template⟭
family: code
format: .sql
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: comment, SQL UPDATE, SQL WHERE, SQL INSERT
scenario: migration moving patient addresses out of the patient table of a clinic's records system, with data fixes requested by secretaries
⟬text⟭
-- =============================================================
-- Migration 2024_05 : sortie des adresses de la table patients
-- Base : dpi_prod   Exécutant : équipe SI santé
-- Revue DPO : ⟬trap:initials|M.-C.⟭ le ⟬date#1⟭
-- =============================================================

BEGIN;

CREATE TABLE adresses_patient (
    id            SERIAL PRIMARY KEY,
    patient_id    INTEGER NOT NULL REFERENCES patients(id) ON DELETE CASCADE,
    type          VARCHAR(10) NOT NULL DEFAULT 'domicile',
    ligne1        VARCHAR(200) NOT NULL,
    code_postal   CHAR(5),
    commune       VARCHAR(100),
    valide_du     DATE NOT NULL DEFAULT CURRENT_DATE,
    valide_au     DATE
);

INSERT INTO adresses_patient (patient_id, ligne1, code_postal, commune)
SELECT id, adresse_ligne1, code_postal, commune
FROM patients
WHERE adresse_ligne1 IS NOT NULL;

-- Corrections demandées par les secrétariats (adresse saisie dans le champ commentaire)
UPDATE adresses_patient
   SET ligne1 = '⟬fr_postal_address:street#2⟭', code_postal = '⟬postcode#2⟭', commune = '⟬city#2⟭'
 WHERE patient_id = (SELECT id FROM patients WHERE nir = '⟬fr_social_security_number#2⟭');

UPDATE adresses_patient
   SET ligne1 = '⟬fr_postal_address:street#3⟭', code_postal = '⟬postcode#3⟭', commune = '⟬city#3⟭'
 WHERE patient_id = (SELECT id FROM patients WHERE nir = '⟬fr_social_security_number#3⟭');

-- Patiente hébergée chez sa fille : adresse de correspondance distincte
INSERT INTO adresses_patient (patient_id, type, ligne1, code_postal, commune)
SELECT id, 'courrier', '⟬fr_postal_address:street#5⟭', '⟬postcode#5⟭', '⟬city#5⟭'
FROM patients
WHERE nom = '⟬person_name:family#4f⟭' AND date_naissance = '⟬birth_date#4⟭';

-- Contrôle : patients sans adresse après migration
SELECT p.id, p.nir, p.nom, p.date_naissance
FROM patients p
LEFT JOIN adresses_patient a ON a.patient_id = p.id
WHERE a.id IS NULL;
-- 3 lignes au premier passage :
--   18842 | ⟬fr_social_security_number#6⟭ | ⟬person_name:family#6⟭ | ⟬birth_date#6⟭
--   20410 | ⟬fr_social_security_number#7⟭ | ⟬person_name:family#7⟭ | ⟬birth_date#7⟭
--   20977 | ⟬fr_social_security_number#8⟭ | ⟬person_name:family#8⟭ | ⟬birth_date#8⟭

ALTER TABLE patients DROP COLUMN adresse_ligne1, DROP COLUMN code_postal, DROP COLUMN commune;

-- Compte applicatif du nouveau module adresses
CREATE ROLE app_adresses LOGIN PASSWORD '⟬password#9⟭';
GRANT SELECT, INSERT, UPDATE ON adresses_patient TO app_adresses;
GRANT USAGE ON SEQUENCE adresses_patient_id_seq TO app_adresses;

COMMIT;
⟬end⟭

⟬template⟭
family: code
format: .sql
language: fr
fill_locale: fr_FR
domain: HR
appearance: comment, SQL string, function call, SQL WHERE
scenario: view exposing the monthly payroll declaration to an outsourced payroll provider, decrypting bank details with a key pasted into the view
⟬text⟭
-- Vue d'export DSN mensuelle, lue par le connecteur de la paie externalisée.
-- Les IBAN sont chiffrés (pgp) dans le SIRH ; la vue les déchiffre à la volée.

CREATE EXTENSION IF NOT EXISTS postgres_fdw;
CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE SERVER paie_externe FOREIGN DATA WRAPPER postgres_fdw
    OPTIONS (host '⟬hostname#1⟭', port '5432', dbname 'paie');
CREATE USER MAPPING FOR export_dsn SERVER paie_externe
    OPTIONS (user 'sirh_lien', password '⟬password#1⟭');

CREATE OR REPLACE VIEW v_export_dsn AS
SELECT
    '⟬fr_siret#2⟭'::char(14) AS siret_etablissement,
    s.matricule,
    s.nir,
    s.nom_usage,
    s.prenom,
    pgp_pub_decrypt(s.iban_chiffre, dearmor('⟬private_key#3⟭')) AS iban,
    c.date_debut,
    c.salaire_brut_mensuel
FROM salaries s
JOIN contrats c ON c.salarie_id = s.id AND c.date_fin IS NULL;

GRANT SELECT ON v_export_dsn TO export_dsn;

-- vérif sur un salarié de test avant d'ouvrir au connecteur
SELECT * FROM v_export_dsn WHERE matricule = '⟬customer_id#4⟭';
-- ⟬fr_siret#2⟭ | ⟬customer_id#4⟭ | ⟬fr_social_security_number#4⟭ | ⟬person_name:family#4⟭ | ⟬person_name:given#4⟭ | ⟬iban#4⟭ | ⟬date#1⟭ | 2850.00
⟬end⟭

⟬template⟭
family: code
format: .sql
language: fr
fill_locale: fr_FR
domain: insurance
appearance: comment, SQL WHERE, SQL DELETE
scenario: erasure request handled by an insurer's data protection team for a prospect who never became a customer
⟬text⟭
-- Droit à l'effacement : demande de Mme ⟬person_name#1f⟭ reçue le ⟬date#1⟭ (⟬ticket_id#1⟭)
-- Prospect jamais devenu client, pas d'obligation de conservation.
BEGIN;
DELETE FROM relances_commerciales
 WHERE prospect_id IN (SELECT id FROM prospects WHERE email = '⟬email#1⟭');
DELETE FROM prospects WHERE email = '⟬email#1⟭' OR telephone = '⟬phone#1⟭';
INSERT INTO journal_rgpd (type_demande, reference, traite_le) VALUES ('effacement', '⟬ticket_id#1⟭', now());
COMMIT;
⟬end⟭

⟬template⟭
family: code
format: .sql
language: fr
fill_locale: fr_FR
domain: energy
appearance: comment, SQL WHERE, window function
scenario: nightly analytics query of an energy retailer's data team computing monthly consumption by region, excluding a partner supplier
⟬text⟭
-- Consommation mensuelle par région et par segment, hors clients du fournisseur partenaire
-- (leur facturation passe par le contrat de délégation, cf. accord-cadre).
WITH conso_mensuelle AS (
    SELECT
        date_trunc('month', r.horodate)::date AS mois,
        s.region,
        s.segment,
        sum(r.kwh) AS kwh
    FROM releves r
    JOIN sites s ON s.id = r.site_id
    WHERE r.horodate >= '⟬date#2⟭'
      AND r.horodate <  '⟬date#1⟭'
      AND s.fournisseur <> '⟬trap:company_name|⦃Family⦄ Énergies⟭'
    GROUP BY 1, 2, 3
)
SELECT
    mois,
    region,
    segment,
    kwh,
    round(100.0 * (kwh - lag(kwh, 12) OVER w) / nullif(lag(kwh, 12) OVER w, 0), 1) AS evol_annuelle_pct,
    rank() OVER (PARTITION BY mois, segment ORDER BY kwh DESC) AS rang_region
FROM conso_mensuelle
WINDOW w AS (PARTITION BY region, segment ORDER BY mois)
ORDER BY mois, segment, rang_region;

-- ⟬trap:indicator_non_pii|owner: equipe-data-energie⟭, rafraîchi chaque nuit par le planificateur
⟬end⟭

⟬template⟭
family: code
format: .sql
language: fr
fill_locale: fr_FR
domain: public administration
appearance: SQL VALUES, comment
scenario: check run by a tax office developer before printing notices, looking for tax numbers attached to several households
⟬text⟭
-- contrôle avant édition des avis : numéros fiscaux rattachés à plusieurs foyers
WITH a_verifier(spi) AS (
    VALUES ('⟬fr_tax_number#1⟭'), ('⟬fr_tax_number#2⟭'), ('⟬fr_tax_number#3⟭'), ('⟬fr_tax_number#4⟭')
)
SELECT f.spi, count(DISTINCT f.foyer_id) AS nb_foyers, min(f.date_rattachement) AS premier
FROM foyers_membres f
JOIN a_verifier v ON v.spi = f.spi
GROUP BY f.spi
HAVING count(DISTINCT f.foyer_id) > 1;
⟬end⟭

⟬template⟭
family: code
format: .ipynb
language: fr
fill_locale: fr_FR
domain: banking
appearance: keyword argument, notebook output, markdown cell
scenario: weekly fraud review notebook of a bank's instant-transfer team, listing flagged beneficiaries and merchants
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Revue des alertes fraude - virement instantané, semaine 14"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "metadata": {},
   "outputs": [],
   "source": [
    "import pandas as pd\n",
    "import psycopg2\n",
    "\n",
    "cnx = psycopg2.connect(host=\"⟬hostname#1⟭\", dbname=\"fraude\", user=\"analyste_fraude\", password=\"⟬password#1⟭\")\n",
    "alertes = pd.read_sql(\"SELECT * FROM alertes_vir_inst WHERE semaine = 14 AND score >= 0.8\", cnx)"
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
       "   score  montant  iban_beneficiaire  nom_beneficiaire  siret_marchand\n",
       "0   0.97  4900.00  ⟬iban#2⟭  ⟬person_name#2⟭  NaN\n",
       "1   0.93  1250.00  ⟬iban#3⟭  ⟬company#3⟭  ⟬fr_siret#3⟭\n",
       "2   0.91  4999.99  ⟬iban#2⟭  ⟬person_name#2⟭  NaN\n",
       "3   0.88   780.00  ⟬iban#4⟭  ⟬company#4⟭  ⟬fr_siret#4⟭"
      ]
     },
     "execution_count": 2,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "alertes.sort_values(\"score\", ascending=False)[[\"score\", \"montant\", \"iban_beneficiaire\", \"nom_beneficiaire\", \"siret_marchand\"]].head(4)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Le compte ⟬iban#2⟭ revient deux fois juste sous le plafond de 5 000 €, ouvert il y a 9 jours. Transmis à ⟬person_name#5⟭ (cellule LCB-FT) le ⟬date#1⟭.\n",
    "\n",
    "Les cartes sont affichées masquées par l'outil source (`⟬trap:placeholder|497010******1234⟭`), rien à purger."
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
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: markdown cell, HTTP header, notebook output, function call
scenario: data quality notebook of a regional cancer registry checking identifiers, birth dates and address geocoding before the annual transmission
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Registre des cancers - contrôle qualité avant transmission annuelle\n",
    "\n",
    "Responsable du registre : ⟬person_name#1⟭ (⟬email#1⟭). Extraction du ⟬date#1⟭."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "metadata": {},
   "outputs": [],
   "source": [
    "import io\n",
    "import pandas as pd\n",
    "import requests\n",
    "\n",
    "jeton = \"⟬opaque_token#2⟭\"\n",
    "r = requests.get(\"https://⟬hostname#2⟭/extractions/registre_2023.csv\", headers={\"Authorization\": f\"Token {jeton}\"}, timeout=120)\n",
    "df = pd.read_csv(io.StringIO(r.text), sep=\";\", dtype=str)\n",
    "len(df)"
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
      "NIR à clé invalide : 3\n",
      "⟬fr_social_security_number#3⟭  ⟬birth_date#3⟭\n",
      "⟬fr_social_security_number#4⟭  ⟬birth_date#4⟭\n",
      "⟬fr_social_security_number#5⟭  ⟬birth_date#5⟭\n"
     ]
    }
   ],
   "source": [
    "def cle_ok(nir):\n",
    "    corps = nir[:13].upper().replace(\"2A\", \"19\").replace(\"2B\", \"18\")\n",
    "    return 97 - int(corps) % 97 == int(nir[13:15])\n",
    "\n",
    "invalides = df[~df[\"nir\"].str.replace(\" \", \"\").map(cle_ok)]\n",
    "print(\"NIR à clé invalide :\", len(invalides))\n",
    "for _, ligne in invalides.iterrows():\n",
    "    print(ligne[\"nir\"], \"\", ligne[\"date_naissance\"])"
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
       "sexe_nir  sexe_declare  n\n",
       "1         F             2\n",
       "2         M             1"
      ]
     },
     "execution_count": 3,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "df[\"sexe_nir\"] = df[\"nir\"].str[0]\n",
    "incoherents = df[(df[\"sexe_nir\"] == \"1\") & (df[\"sexe\"] == \"F\") | (df[\"sexe_nir\"] == \"2\") & (df[\"sexe\"] == \"M\")]\n",
    "incoherents.groupby([\"sexe_nir\", \"sexe\"]).size().rename(\"n\").reset_index().rename(columns={\"sexe\": \"sexe_declare\"})"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 4,
   "metadata": {},
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "géocodage : 4 812 adresses, 37 sous le seuil de 0.6\n",
      "  ⟬fr_postal_address#6⟭ -> score 0.31\n",
      "  ⟬fr_postal_address#7⟭ -> score 0.44\n"
     ]
    }
   ],
   "source": [
    "def score_adresse(adresse):\n",
    "    rep = requests.get(\"https://⟬hostname#8⟭/search/\", params={\"q\": adresse, \"limit\": 1}, timeout=10).json()\n",
    "    return rep[\"features\"][0][\"properties\"][\"score\"] if rep[\"features\"] else 0.0\n",
    "\n",
    "df[\"score_geo\"] = df[\"adresse\"].map(score_adresse)\n",
    "faibles = df[df[\"score_geo\"] < 0.6]\n",
    "print(f\"géocodage : {len(df):,} adresses, {len(faibles)} sous le seuil de 0.6\".replace(\",\", \" \"))\n",
    "for _, l in faibles.head(2).iterrows():\n",
    "    print(\" \", l[\"adresse\"], \"-> score\", round(l[\"score_geo\"], 2))"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Bilan : les trois NIR invalides sont des erreurs de saisie de l'établissement déclarant, à faire corriger à la source. Les adresses sous le seuil partent en revue manuelle."
   ]
  }
 ],
 "metadata": {
  "kernelspec": {"display_name": "registre (py3.11)", "language": "python", "name": "registre"},
  "language_info": {"name": "python", "version": "3.11.8"}
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
⟬end⟭

⟬template⟭
family: code
format: .ipynb
language: fr
fill_locale: fr_FR
domain: insurance
appearance: markdown cell, notebook output, keyword argument
scenario: short survival analysis notebook of a home insurance product team studying when policies are cancelled
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "## Résiliations MRH : courbe de survie des contrats (estimateur de ⟬trap:eponym|Kaplan-Meier⟭)"
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
      "contrats : 58 204, résiliés : 17 930\n",
      "durée de vie médiane : 41 mois\n",
      "survie à 12 mois : 0.87, à 36 mois : 0.56\n"
     ]
    }
   ],
   "source": [
    "import pandas as pd\n",
    "from lifelines import ⟬trap:code_identifier|KaplanMeierFitter⟭\n",
    "from entrepot import connect\n",
    "\n",
    "con = connect(dsn=\"mrh_stats\", ⟬trap:indicator_non_pii|user='lecture_seule'⟭)\n",
    "c = pd.read_sql(\"SELECT duree_mois, resilie FROM contrats_mrh WHERE date_effet >= '2018-01-01'\", con)\n",
    "km = ⟬trap:code_identifier|KaplanMeierFitter⟭().fit(c[\"duree_mois\"], event_observed=c[\"resilie\"])\n",
    "print(f\"contrats : {len(c):,}, résiliés : {c['resilie'].sum():,}\".replace(\",\", \" \"))\n",
    "print(f\"durée de vie médiane : {km.median_survival_time_:.0f} mois\")\n",
    "print(f\"survie à 12 mois : {km.predict(12):.2f}, à 36 mois : {km.predict(36):.2f}\")"
   ]
  }
 ],
 "metadata": {
  "kernelspec": {"display_name": "Python 3", "language": "python", "name": "python3"},
  "language_info": {"name": "python", "version": "3.10.13"}
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
appearance: command-line argument, URL, heredoc, environment variable
scenario: pre-production deployment script of a residence permit management application, run by hand by the integrator
⟬text⟭
#!/usr/bin/env bash
# Déploiement de l'application de gestion des titres de séjour - préproduction
# Usage : ./deployer.sh <version>
set -euo pipefail

VERSION=${1:?version manquante}
REGISTRE=⟬hostname#1⟭
APP_DIR=/opt/titres

echo "⟬password#2⟭" | docker login "$REGISTRE" -u deploiement --password-stdin

if [ ! -d "$APP_DIR/.git" ]; then
  git clone "https://deploiement:⟬url_password#3⟭@⟬hostname#3⟭/si-etrangers/titres.git" "$APP_DIR"
fi
cd "$APP_DIR"
git fetch --tags && git checkout "v$VERSION"

# les sous-modules de configuration sont tirés en SSH
mkdir -p ~/.ssh
cat > ~/.ssh/id_deploy <<'CLE'
⟬private_key#4⟭
CLE
chmod 600 ~/.ssh/id_deploy
GIT_SSH_COMMAND="ssh -i ~/.ssh/id_deploy -o StrictHostKeyChecking=no" git submodule update --init

docker rm -f titres-api 2>/dev/null || true
docker run -d --name titres-api --restart unless-stopped \
  -e DB_HOST=⟬hostname#5⟭ \
  -e DB_PASSWORD='⟬password#5⟭' \
  -e SIGNATURE_HMAC=⟬opaque_token#6⟭ \
  -p 8080:8080 "$REGISTRE/titres-api:$VERSION"

sleep 10
curl -fsS "http://localhost:8080/sante" && echo "déploiement $VERSION OK"
⟬end⟭

⟬template⟭
family: code
format: .sh
language: fr
fill_locale: fr_FR
domain: insurance
appearance: URL, command-line argument
scenario: weekly cron job of a health insurer extracting members to remind and mailing the encrypted file to a partner broker
⟬text⟭
#!/bin/sh
# extraction hebdo des adhérents à relancer, envoyée chiffrée au courtier partenaire
OUT=/tmp/relances_$(date +%V).csv
psql "postgresql://reporting:⟬url_password#1⟭@⟬hostname#1⟭/adhesions" -At -F ';' \
  -c "SELECT numero_adherent, nom, prenom, email FROM adherents WHERE echeance < now() + interval '15 days'" > "$OUT"
gpg --batch --yes -r ⟬email#2⟭ -e "$OUT"
echo "Relances semaine $(date +%V)" | mutt -s "Relances adhérents" -a "$OUT.gpg" -- ⟬email#2⟭ ⟬email:generic#3⟭
rm -f "$OUT" "$OUT.gpg"
⟬end⟭

⟬template⟭
family: code
format: .sh
language: fr
fill_locale: fr_FR
domain: energy
appearance: environment variable, command-line argument, comment
scenario: weekly maintenance script of the MQTT broker collecting smart meter data, kept in the ops repository
⟬text⟭
#!/usr/bin/env bash
# Maintenance du broker MQTT de télérelève (concentrateurs -> SI)
# Rotation des journaux, sauvegarde de la base de persistance, redémarrage contrôlé.
# Lancé le dimanche à 04h00, hors fenêtre de remontée des index.

set -u
⟬trap:indicator_non_pii|MQTT_USER=telereleve⟭
MQTT_PASS="⟬trap:placeholder|${MQTT_PASSWORD:?à définir dans /etc/default/telereleve}⟭"
HOTE=⟬hostname#1⟭
PERSISTANCE=/var/lib/mosquitto/mosquitto.db

logrotate -f /etc/logrotate.d/mosquitto

systemctl stop mosquitto
find /var/lib/mosquitto -name 'mosquitto.db.bak.*' -mtime +28 -delete
cp "$PERSISTANCE" "$PERSISTANCE.bak.$(date +%F)"
systemctl start mosquitto

sleep 5
if mosquitto_sub -h "$HOTE" -u "$MQTT_USER" -P "$MQTT_PASS" -t '$SYS/broker/uptime' -C 1 -W 10 >/dev/null; then
  logger -t maintenance-mqtt "broker OK, concentrateurs connectés : $(mosquitto_sub -h "$HOTE" -u "$MQTT_USER" -P "$MQTT_PASS" -t '$SYS/broker/clients/connected' -C 1 -W 10)"
else
  logger -t maintenance-mqtt "broker KO après redémarrage"
  curl -s -X POST "https://⟬hostname#2⟭/alertes" -d "source=mqtt&niveau=critique&hote=⟬ip_address#1⟭"
fi
⟬end⟭
