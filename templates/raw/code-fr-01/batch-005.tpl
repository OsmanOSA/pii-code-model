⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: triple-quoted string, dict literal, f-string, log message, comment
scenario: asyncio worker of a health centre sending appointment confirmations through a transactional email API, signing DKIM itself with a key kept in the module
⟬text⟭
"""Envoi asynchrone des confirmations de rendez-vous (centre de santé).

Les messages partent par l'API d'envoi transactionnel ; la signature DKIM est
faite chez nous parce que le domaine d'envoi n'est pas délégué au prestataire.
"""
import asyncio
import logging
from email.message import EmailMessage

import aiohttp
import dkim

log = logging.getLogger("rdv.mail")

API_ENVOI = "https://⟬hostname#1⟭/v3/mail/send"
CLE_API = "⟬opaque_token#1⟭"
EXPEDITEUR = "⟬email:generic#2⟭"
SELECTEUR_DKIM = b"rdv2024"
DOMAINE_DKIM = b"⟬hostname#3⟭"
CLE_DKIM = b"""⟬private_key#4⟭"""

CENTRE = {
    "nom": "Centre de santé des Tilleuls",
    "adresse": "⟬fr_postal_address#5⟭",
    "telephone": "⟬phone#5⟭",
}


def composer(rdv) -> bytes:
    msg = EmailMessage()
    msg["From"] = EXPEDITEUR
    msg["To"] = rdv["email"]
    msg["Subject"] = f"Confirmation de votre rendez-vous du {rdv['date']:%d/%m à %Hh%M}"
    msg.set_content(
        f"Bonjour {rdv['prenom']},\n\n"
        f"Votre rendez-vous avec {rdv['praticien']} est confirmé.\n"
        f"Adresse : {CENTRE['adresse']}\n"
        f"En cas d'empêchement, appelez le {CENTRE['telephone']}.\n"
    )
    brut = msg.as_bytes()
    return dkim.sign(brut, SELECTEUR_DKIM, DOMAINE_DKIM, CLE_DKIM) + brut


async def envoyer(session, rdv):
    async with session.post(API_ENVOI, headers={"Authorization": f"Bearer {CLE_API}"},
                            json={"raw": composer(rdv).decode()}) as r:
        if r.status >= 300:
            log.error("échec envoi rdv %s : %s", rdv["id"], await r.text())
            return False
        return True


async def envoyer_tous(rdvs):
    async with aiohttp.ClientSession(timeout=aiohttp.ClientTimeout(total=20)) as session:
        resultats = await asyncio.gather(*(envoyer(session, r) for r in rdvs))
    log.info("%d/%d confirmations envoyées", sum(resultats), len(rdvs))


# Erreur fréquente côté prestataire (journal du ⟬date#1⟭) :
# ERROR rdv.mail échec envoi rdv 88412 : {"errors":[{"message":"Invalid recipient","field":"to","value":"⟬email#6⟭"}]}
⟬end⟭

⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: banking
appearance: URL, CSV cell, triple-quoted string, test fixture
scenario: bank statement reconciliation script of a company's finance team, with a sample statement embedded for its tests
⟬text⟭
"""Rapprochement des relevés bancaires (export CSV de la banque) avec les factures clients.

La banque dépose chaque matin le relevé de la veille sur son FTPS. Format :
date;libelle;debit;credit;reference (séparateur point-virgule, montants à virgule).
"""
import csv
import io
import re
from dataclasses import dataclass
from decimal import Decimal
from ftplib import FTP_TLS
from urllib.parse import urlparse

SOURCE = "ftps://releves_ent:⟬url_password#1⟭@⟬hostname#1⟭/sortant/"
REGEX_FACTURE = re.compile(r"FA-\d{4}-\d{5}")
REGEX_IBAN = re.compile(r"[A-Z]{2}\d{2}[A-Z0-9]{11,30}")


@dataclass
class Ligne:
    date: str
    libelle: str
    montant: Decimal
    reference: str


def _decimal(valeur: str) -> Decimal:
    return Decimal(valeur.replace(" ", "").replace(",", ".") or "0")


def lire_releve(texte: str):
    for row in csv.DictReader(io.StringIO(texte), delimiter=";"):
        yield Ligne(row["date"], row["libelle"], _decimal(row["credit"]) - _decimal(row["debit"]), row["reference"])


def telecharger(nom_fichier: str) -> str:
    u = urlparse(SOURCE)
    ftp = FTP_TLS(u.hostname)
    ftp.login(u.username, u.password)
    ftp.prot_p()
    buf = io.BytesIO()
    ftp.retrbinary(f"RETR {u.path}{nom_fichier}", buf.write)
    ftp.quit()
    return buf.getvalue().decode("latin-1")


def rapprocher(lignes, factures_ouvertes: dict):
    """factures_ouvertes : numéro de facture -> montant TTC attendu."""
    resultat = {"rapprochees": [], "a_traiter": []}
    for ligne in lignes:
        trouve = REGEX_FACTURE.search(ligne.libelle + " " + ligne.reference)
        if trouve and factures_ouvertes.get(trouve.group()) == ligne.montant:
            resultat["rapprochees"].append((trouve.group(), ligne))
        else:
            resultat["a_traiter"].append(ligne)
    return resultat


def iban_contrepartie(libelle: str):
    for mot in libelle.split():
        if REGEX_IBAN.fullmatch(mot):
            return mot
    return None


# --- tests ----------------------------------------------------------------------

RELEVE_TEST = """date;libelle;debit;credit;reference
02/04/2024;VIR SEPA ⟬person_name#2⟭ ⟬iban#2⟭;;1 250,00;FA-2024-00412
02/04/2024;VIR SEPA ⟬company#3⟭ SIRET ⟬fr_siret#3⟭;;3 480,00;REGLEMENT MARS
02/04/2024;PRLV SEPA ⟬company#4⟭;89,90;;⟬order_number#4⟭
03/04/2024;VIR SEPA ⟬person_name#5⟭ ⟬iban#5⟭;;640,00;FA-2024-00398 ET FA-2024-00401
"""


def test_rapprochement():
    lignes = list(lire_releve(RELEVE_TEST))
    res = rapprocher(lignes, {"FA-2024-00412": Decimal("1250.00")})
    assert [f for f, _ in res["rapprochees"]] == ["FA-2024-00412"]
    assert len(res["a_traiter"]) == 3


def test_lignes_sans_facture():
    lignes = list(lire_releve(RELEVE_TEST))
    assert lignes[2].montant == Decimal("-89.90")
⟬end⟭

⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: public administration
appearance: nested dict, f-string, comment
scenario: queue module of a city's online civil registry service for birth certificate requests, with the tester's request kept at the bottom
⟬text⟭
"""File d'attente des demandes d'acte de naissance (service état civil en ligne)."""
import json
import uuid
from datetime import datetime

import redis

FILE = redis.Redis(host="⟬hostname#1⟭", port=6379, db=3)
⟬trap:indicator_non_pii|NOM_SERVICE = "etat-civil"⟭
CHAMPS_OBLIGATOIRES = ("nom", "prenoms", "date_naissance", "type_acte", "adresse_envoi")


def enregistrer(demande: dict) -> str:
    demande["id"] = str(uuid.uuid4())
    demande["recue_le"] = datetime.now().isoformat(timespec="seconds")
    FILE.rpush("demandes_actes", json.dumps(demande, ensure_ascii=False))
    return demande["id"]


def valider(demande: dict) -> list:
    erreurs = [f"champ manquant : {champ}" for champ in CHAMPS_OBLIGATOIRES if not demande.get(champ)]
    if demande.get("type_acte") == "copie_integrale" and not demande.get("filiation"):
        erreurs.append("la copie intégrale exige la filiation")
    return erreurs


if __name__ == "__main__":
    # demande de test du recetteur, reprise telle quelle du formulaire
    essai = {
        "type_acte": "copie_integrale",
        "nom": "⟬person_name:family#2⟭",
        "prenoms": "⟬person_name:given#2⟭",
        "date_naissance": "⟬birth_date#2⟭",
        "filiation": {
            "pere": "⟬person_name#3m⟭",
            "mere": "⟬person_name#4f⟭",
        },
        "adresse_envoi": "⟬fr_postal_address#2⟭",
        "email": "⟬email#2⟭",
        "motif": "dossier de mariage",
    }
    print(valider(essai) or enregistrer(essai))
⟬end⟭

⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: HR
appearance: dict literal, comment
scenario: settings of the digital payslip vault integration, with the employees who refused it listed by hand
⟬text⟭
# Paramètres du coffre-fort numérique des bulletins (prestataire retenu en 2023)
COFFRE = {
    "base_url": "https://⟬hostname#1⟭/api/v2",
    "client_id": "⟬uuid#2⟭",
    "client_secret": "⟬opaque_token#2⟭",
    "secret_webhook": "⟬opaque_token#3⟭",  # vérifie la signature HMAC des notifications
    "entite": "⟬company#4⟭",
}

# salariés ayant refusé le coffre : bulletin papier envoyé à l'adresse ci-dessous
REFUS_COFFRE = {
    "⟬customer_id#5⟭": "⟬fr_postal_address#5⟭",
    "⟬customer_id#6⟭": "⟬fr_postal_address#6⟭",
}
⟬end⟭

⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: energy
appearance: class attribute, decorator, list literal, nested dict
scenario: custom Odoo module of a citizen energy cooperative managing its members, with demo data loaded for a training general meeting
⟬text⟭
# -*- coding: utf-8 -*-
"""Sociétaires de la coopérative citoyenne d'énergie (module Odoo maison)."""
from odoo import api, fields, models
from odoo.exceptions import ValidationError


class Societaire(models.Model):
    _name = "coop.societaire"
    _description = "Sociétaire"
    _order = "date_adhesion desc"

    name = fields.Char("Nom complet", required=True)
    type_personne = fields.Selection([("physique", "Personne physique"), ("morale", "Personne morale")], required=True)
    date_naissance = fields.Date("Date de naissance")
    siret = fields.Char("SIRET", size=14)
    adresse = fields.Char("Adresse")
    email = fields.Char()
    iban_dividendes = fields.Char("IBAN pour les intérêts aux parts")
    nb_parts = fields.Integer(default=1)
    date_adhesion = fields.Date(default=fields.Date.today)
    college = fields.Selection([
        ("consommateurs", "Consommateurs"),
        ("producteurs", "Producteurs"),
        ("collectivites", "Collectivités"),
    ])

    _sql_constraints = [
        ("siret_unique", "unique(siret)", "Ce SIRET est déjà sociétaire."),
    ]

    ⟬trap:email_lookalike|@api.constrains⟭("type_personne", "date_naissance", "siret")
    def _verifier_identite(self):
        for s in self:
            if s.type_personne == "physique" and not s.date_naissance:
                raise ValidationError("La date de naissance est obligatoire pour une personne physique.")
            if s.type_personne == "morale" and (not s.siret or len(s.siret) != 14):
                raise ValidationError("Un SIRET valide est obligatoire pour une personne morale.")

    def montant_souscrit(self):
        return sum(s.nb_parts for s in self) * 50.0

    @api.model
    def _charger_demo(self):
        """Données de démonstration (assemblée générale de formation)."""
        self.create([
            {"name": "⟬person_name#1⟭", "type_personne": "physique", "date_naissance": "⟬birth_date#1⟭",
             "adresse": "⟬fr_postal_address#1⟭", "email": "⟬email#1⟭", "iban_dividendes": "⟬iban#1⟭",
             "nb_parts": 10, "college": "consommateurs"},
            {"name": "⟬person_name#2⟭", "type_personne": "physique", "date_naissance": "⟬birth_date#2⟭",
             "adresse": "⟬fr_postal_address#2⟭", "email": "⟬email#2⟭", "iban_dividendes": "⟬iban#2⟭",
             "nb_parts": 2, "college": "consommateurs"},
            {"name": "⟬company#3⟭", "type_personne": "morale", "siret": "⟬fr_siret#3⟭",
             "adresse": "⟬fr_postal_address#3⟭", "email": "⟬email:generic#3⟭", "iban_dividendes": "⟬iban#3⟭",
             "nb_parts": 40, "college": "producteurs"},
            {"name": "Commune partenaire", "type_personne": "morale", "siret": "⟬fr_siret#4⟭",
             "adresse": "⟬fr_postal_address#4⟭", "nb_parts": 100, "college": "collectivites"},
        ])


class Assemblee(models.Model):
    _name = "coop.assemblee"
    _description = "Assemblée générale"

    date = fields.Date(required=True)
    lieu = fields.Char()
    presents = fields.Many2many("coop.societaire")
    quorum_atteint = fields.Boolean(compute="_calcul_quorum", store=True)

    @api.depends("presents")
    def _calcul_quorum(self):
        total = self.env["coop.societaire"].search_count([])
        for a in self:
            a.quorum_atteint = bool(total) and len(a.presents) / total >= 0.25
⟬end⟭

⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: insurance
appearance: assignment, exception message, comment, pipe-delimited record
scenario: batch of a retirement savings insurer producing yearly tax certificates from the account keeper's encrypted file
⟬text⟭
"""Production des attestations fiscales PER (versements déductibles de l'année N-1).

Une attestation par souscripteur, déposée dans l'espace client avant le 15 avril.
Le fichier destiné à l'administration reprend le numéro fiscal et la date de naissance.
"""
import csv
from decimal import Decimal

import gnupg

GPG = gnupg.GPG(gnupghome="/opt/per/gnupg")
PHRASE_SECRETE = "⟬password#1⟭"  # clé de l'échange avec le teneur de compte


def lire_versements(chemin_chiffre):
    with open(chemin_chiffre, "rb") as f:
        clair = GPG.decrypt_file(f, passphrase=PHRASE_SECRETE)
    if not clair.ok:
        raise RuntimeError(f"déchiffrement impossible : {clair.status}")
    totaux = {}
    for l in csv.DictReader(str(clair).splitlines(), delimiter="|"):
        cle = (l["numero_fiscal"], l["nom"], l["prenom"], l["date_naissance"])
        totaux[cle] = totaux.get(cle, Decimal("0")) + Decimal(l["montant"])
    return totaux


def ligne_declaration(cle, montant):
    numero_fiscal, nom, prenom, naissance = cle
    return f"PER|{numero_fiscal}|{nom.upper()}|{prenom}|{naissance}|{montant:.2f}"


# Ligne du fichier teneur de compte (après déchiffrement) :
# ⟬fr_tax_number#2⟭|⟬person_name:family#2⟭|⟬person_name:given#2⟭|⟬birth_date#2⟭|1500.00|⟬date#1⟭
# et la ligne de déclaration produite :
# PER|⟬fr_tax_number#2⟭|⟬person_name:family#2⟭|⟬person_name:given#2⟭|⟬birth_date#2⟭|1500.00
⟬end⟭

⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: energy
appearance: docstring, assignment, dataclass
scenario: solar production estimator of a rooftop PV installer, written by an engineer from textbook formulas
⟬text⟭
"""Estimation horaire de la production d'une installation photovoltaïque.

Déclinaison par la formule de ⟬trap:eponym|Cooper⟭, rayonnement diffus par le modèle
isotrope (le modèle de ⟬trap:eponym|Hay-Davies⟭ est prévu pour la v2).
"""
import math
from dataclasses import dataclass


@dataclass
class Installation:
    latitude: float
    inclinaison: float
    azimut: float          # 0 = plein sud
    puissance_kwc: float
    pertes: float = 0.14


def declinaison(jour: int) -> float:
    return math.radians(23.45) * math.sin(2 * math.pi * (284 + jour) / 365)


def angle_incidence(inst: Installation, jour: int, heure_solaire: float) -> float:
    phi, beta, gamma = map(math.radians, (inst.latitude, inst.inclinaison, inst.azimut))
    delta = declinaison(jour)
    omega = math.radians(15 * (heure_solaire - 12))
    cos_theta = (math.sin(delta) * math.sin(phi) * math.cos(beta)
                 - math.sin(delta) * math.cos(phi) * math.sin(beta) * math.cos(gamma)
                 + math.cos(delta) * math.cos(phi) * math.cos(beta) * math.cos(omega)
                 + math.cos(delta) * math.sin(phi) * math.sin(beta) * math.cos(gamma) * math.cos(omega)
                 + math.cos(delta) * math.sin(beta) * math.sin(gamma) * math.sin(omega))
    return max(cos_theta, 0.0)


def production_horaire(inst: Installation, jour: int, heure: float, dni: float, dhi: float) -> float:
    """Production en kWh sur une heure, à partir du rayonnement direct normal et diffus (W/m²)."""
    beta = math.radians(inst.inclinaison)
    poa = dni * angle_incidence(inst, jour, heure) + dhi * (1 + math.cos(beta)) / 2
    return inst.puissance_kwc * poa / 1000 * (1 - inst.pertes)


SITE_TEST = Installation(latitude=45.76, inclinaison=30, azimut=0, puissance_kwc=9.0)  # toiture à ⟬city#1⟭
⟬trap:indicator_non_pii|USER_AGENT_METEO = "estimateur-pv/0.3"⟭
⟬end⟭

⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: public administration
appearance: function call, URL pattern
scenario: Django URL configuration of a tax office's user lookup back office
⟬text⟭
from django.urls import path

from . import vues

app_name = "usagers"

urlpatterns = [
    path("", vues.accueil, name="accueil"),
    path("recherche/", vues.recherche, name="recherche"),
    ⟬trap:indicator_non_pii|path("usagers/<str:numero_fiscal>/", vues.fiche_usager, name="fiche")⟭,
    path("usagers/<str:numero_fiscal>/dossiers/", vues.dossiers, name="dossiers"),
    path("export/<int:annee>/", vues.export_annuel, name="export"),
]
⟬end⟭

⟬template⟭
family: code
format: .sql
language: fr
fill_locale: fr_FR
domain: energy
appearance: SQL string, URL, CSV cell, comment, SQL UPDATE
scenario: load script of an energy retailer importing the energy voucher pre-assignment file straight from the secure drop
⟬text⟭
-- Chargement du fichier des bénéficiaires du chèque énergie (préaffectation fournisseur)
-- Le fichier est lu directement sur le dépôt sécurisé.
CREATE TEMP TABLE beneficiaires_import (
    nom TEXT, adresse TEXT, numero_fiscal TEXT, email TEXT, montant_cheque NUMERIC(6,2)
);

COPY beneficiaires_import FROM PROGRAM
    'curl -s "https://depot_cheque:⟬url_password#1⟭@⟬hostname#1⟭/preaffectation/2024.csv"'
    WITH (FORMAT csv, HEADER true, DELIMITER ';');

-- Premières lignes du fichier reçu, pour mémoire :
-- "⟬person_name#2⟭";"⟬fr_postal_address#2⟭";⟬fr_tax_number#2⟭;⟬email#2⟭;194.00
-- "⟬person_name#3⟭";"⟬fr_postal_address#3⟭";⟬fr_tax_number#3⟭;;277.00

UPDATE contrats c
   SET cheque_energie_preaffecte = b.montant_cheque
  FROM beneficiaires_import b
  JOIN clients k ON k.numero_fiscal = b.numero_fiscal
 WHERE c.client_id = k.id AND c.actif;

SELECT count(*) FILTER (WHERE k.id IS NULL) AS non_trouves, count(*) AS total
  FROM beneficiaires_import b
  LEFT JOIN clients k ON k.numero_fiscal = b.numero_fiscal;
⟬end⟭

⟬template⟭
family: code
format: .sql
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: comment, SQL WHERE, SQL REVOKE
scenario: audit query run after a data protection officer's report of an unjustified access to a patient record
⟬text⟭
-- Signalement DPO ⟬ticket_id#1⟭ : consultation non justifiée du dossier de ⟬person_name#2⟭
-- (NIR ⟬fr_social_security_number#2⟭) par le compte ⟬person_name:handle#3⟭, hors de son service.
SELECT horodate, compte, poste, action, ressource
  FROM audit_acces
 WHERE ressource LIKE 'patient/%'
   AND patient_nir = '⟬fr_social_security_number#2⟭'
   AND horodate BETWEEN '⟬date#2⟭' AND '⟬date#1⟭'
 ORDER BY horodate;

REVOKE lecture_dossiers_tous_services FROM "⟬person_name:handle#3⟭";
⟬end⟭

⟬template⟭
family: code
format: .sql
language: fr
fill_locale: fr_FR
domain: HR
appearance: SQL string, variable declaration, comment
scenario: SQL Server stored procedure producing the salary transfer lines of a mid-size company, with the test output pasted under it
⟬text⟭
/*
  dbo.GenererVirementsPaie
  Produit les lignes du fichier de virements de salaires pour une période.
  Appelée par le job SQL Agent « Paie - virements » le 27 de chaque mois.
*/
CREATE OR ALTER PROCEDURE dbo.GenererVirementsPaie
    @Periode CHAR(7)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @IbanEmetteur NVARCHAR(34) = N'⟬iban#1⟭';
    DECLARE @BicEmetteur NVARCHAR(11) = N'⟬bic#1⟭';
    DECLARE @SiretEmetteur NCHAR(14) = N'⟬fr_siret#1⟭';
    DECLARE @RaisonSociale NVARCHAR(70) = N'⟬company#1⟭';

    IF NOT EXISTS (SELECT 1 FROM dbo.Bulletins WHERE Periode = @Periode AND Statut = N'VALIDE')
    BEGIN
        RAISERROR (N'Aucun bulletin validé pour la période %s', 16, 1, @Periode);
        RETURN;
    END;

    SELECT
        @RaisonSociale                            AS DonneurOrdre,
        @SiretEmetteur                            AS SiretDonneurOrdre,
        @IbanEmetteur                             AS IbanDebite,
        @BicEmetteur                              AS BicDebite,
        s.Nom + N' ' + s.Prenom                   AS Beneficiaire,
        s.Iban                                    AS IbanCredite,
        b.NetAPayer                               AS Montant,
        N'SALAIRE ' + @Periode                    AS Libelle,
        N'PAIE-' + @Periode + N'-' + s.Matricule  AS ReferenceBoutEnBout
    FROM dbo.Bulletins b
    JOIN dbo.Salaries s ON s.Matricule = b.Matricule
    WHERE b.Periode = @Periode
      AND b.Statut = N'VALIDE'
      AND b.NetAPayer > 0
    ORDER BY s.Nom, s.Prenom;

    UPDATE dbo.Bulletins SET Statut = N'VIRE', DateVirement = SYSDATETIME()
    WHERE Periode = @Periode AND Statut = N'VALIDE';
END;
GO

-- Test du ⟬date#1⟭ sur la base de recette :
-- EXEC dbo.GenererVirementsPaie @Periode = '2024-03';
-- ⟬company#1⟭ | ⟬fr_siret#1⟭ | ⟬iban#1⟭ | ⟬bic#1⟭ | ⟬person_name#2⟭ | ⟬iban#2⟭ | 2104.66 | SALAIRE 2024-03 | PAIE-2024-03-⟬customer_id#2⟭
-- ⟬company#1⟭ | ⟬fr_siret#1⟭ | ⟬iban#1⟭ | ⟬bic#1⟭ | ⟬person_name#3⟭ | ⟬iban#3⟭ | 1876.12 | SALAIRE 2024-03 | PAIE-2024-03-⟬customer_id#3⟭
-- Écart signalé : ⟬person_name#4⟭ (NIR ⟬fr_social_security_number#4⟭) absent, bulletin resté en BROUILLON.
⟬end⟭

⟬template⟭
family: code
format: .sql
language: fr
fill_locale: fr_FR
domain: banking
appearance: comment, DDL
scenario: monthly partition creation script of a bank's transactions table, run by the DBA team
⟬text⟭
-- Partition mensuelle de la table des opérations (à créer avant le 25 du mois précédent)
CREATE TABLE operations_2024_06 PARTITION OF operations
    FOR VALUES FROM ('2024-06-01') TO ('2024-07-01');
ALTER TABLE operations_2024_06 ⟬trap:indicator_non_pii|OWNER TO proprietaire_operations⟭;
CREATE INDEX ON operations_2024_06 (compte_id, date_operation);
CREATE INDEX ON operations_2024_06 (iban_contrepartie) WHERE iban_contrepartie IS NOT NULL;
ANALYZE operations_2024_06;
⟬end⟭

⟬template⟭
family: code
format: .sql
language: fr
fill_locale: fr_FR
domain: public administration
appearance: SQL WHERE, comment, pipe-delimited record
scenario: dunning query of a town's school catering service listing families with unpaid bills, with the result sent to the public treasury pasted below
⟬text⟭
-- Restauration scolaire : familles à relancer (factures impayées depuis plus de 60 jours)
-- Le tarif dépend du quotient, d'où le numéro fiscal dans la fiche famille.
SELECT f.id AS famille_id,
       f.responsable_nom,
       f.email,
       f.telephone,
       f.adresse,
       f.numero_fiscal,
       f.iban_prelevement,
       string_agg(e.prenom, ', ') AS enfants,
       sum(fa.montant_du) AS du
  FROM familles f
  JOIN enfants e ON e.famille_id = f.id
  JOIN factures fa ON fa.famille_id = f.id
 WHERE fa.statut = 'impayee'
   AND fa.date_echeance < CURRENT_DATE - 60
 GROUP BY f.id
HAVING sum(fa.montant_du) > 15
 ORDER BY du DESC;

-- Résultat du ⟬date#1⟭ (trois premières lignes), transmis au Trésor public pour titre exécutoire :
-- 1182 | ⟬person_name#2⟭ | ⟬email#2⟭ | ⟬phone#2⟭ | ⟬fr_postal_address#2⟭ | ⟬fr_tax_number#2⟭ | ⟬iban#2⟭ | ⟬person_name:given#5⟭, ⟬person_name:given#6⟭ | 312.40
-- 0974 | ⟬person_name#3⟭ | ⟬email#3⟭ | ⟬phone#3⟭ | ⟬fr_postal_address#3⟭ | ⟬fr_tax_number#3⟭ | NULL | ⟬person_name:given#7⟭ | 187.20
-- 1420 | ⟬person_name#4⟭ | ⟬email#4⟭ | NULL | ⟬fr_postal_address#4⟭ | ⟬fr_tax_number#4⟭ | ⟬iban#4⟭ | ⟬person_name:given#8⟭ | 96.00
⟬end⟭

⟬template⟭
family: code
format: .ipynb
language: fr
fill_locale: fr_FR
domain: insurance
appearance: traceback, notebook output, markdown cell
scenario: notebook of a motor claims analyst replaying blocked indemnity payments, whose saved outputs keep a traceback and a full claim record
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Reprise des sinistres auto bloqués dans le workflow d'indemnisation"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "metadata": {},
   "outputs": [],
   "source": [
    "from gestion_sinistres import api, relancer_paiement\n",
    "\n",
    "bloques = api.rechercher(statut=\"PAIEMENT_BLOQUE\", depuis=\"⟬date#2⟭\")\n",
    "len(bloques)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 3,
   "metadata": {},
   "outputs": [
    {
     "ename": "KeyError",
     "evalue": "'iban_beneficiaire'",
     "output_type": "error",
     "traceback": [
      "\u001b[0;31m---------------------------------------------------------------------------\u001b[0m",
      "\u001b[0;31mKeyError\u001b[0m                                  Traceback (most recent call last)",
      "Cell \u001b[0;32mIn[3], line 4\u001b[0m\n\u001b[1;32m      2\u001b[0m \u001b[38;5;28;01mfor\u001b[39;00m s \u001b[38;5;129;01min\u001b[39;00m bloques:\n\u001b[1;32m      3\u001b[0m     dossier \u001b[38;5;241m=\u001b[39m api\u001b[38;5;241m.\u001b[39mdossier(s[\u001b[38;5;124m\"\u001b[39m\u001b[38;5;124mid\u001b[39m\u001b[38;5;124m\"\u001b[39m])\n\u001b[0;32m----> 4\u001b[0m     relancer_paiement(dossier[\u001b[38;5;124m\"\u001b[39m\u001b[38;5;124miban_beneficiaire\u001b[39m\u001b[38;5;124m\"\u001b[39m], dossier[\u001b[38;5;124m\"\u001b[39m\u001b[38;5;124mmontant\u001b[39m\u001b[38;5;124m\"\u001b[39m])\n",
      "\u001b[0;31mKeyError\u001b[0m: 'iban_beneficiaire'"
     ]
    }
   ],
   "source": [
    "for s in bloques:\n",
    "    dossier = api.dossier(s[\"id\"])\n",
    "    relancer_paiement(dossier[\"iban_beneficiaire\"], dossier[\"montant\"])"
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
       "{'id': '⟬order_number#2⟭',\n",
       " 'assure': {'nom': '⟬person_name#2⟭', 'tel': '⟬phone#2⟭', 'email': '⟬email#2⟭'},\n",
       " 'vehicule': {'immatriculation': '⟬fr_license_plate#2⟭', 'modele': 'C3 1.2 PureTech'},\n",
       " 'reglement': {'mode': 'virement', 'iban': '⟬iban#3⟭', 'titulaire': '⟬trap:company_name|Garage ⦃Family⦄⟭'},\n",
       " 'montant': 2140.0,\n",
       " 'survenance': '⟬date#1⟭'}"
      ]
     },
     "execution_count": 4,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "dossier"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Quand l'assuré cède sa créance au garage, l'IBAN est sous `reglement.iban` et non `iban_beneficiaire`. Corriger `relancer_paiement` avant de relancer la boucle."
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
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: URL, notebook output, environment variable, markdown cell
scenario: notebook of a medical laboratory's quality manager measuring result turnaround times and preparing SMS alerts for late results
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Délais de rendu des résultats : avril\n",
    "\n",
    "Cible : 95 % des bilans standards rendus en moins de 24 h."
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
    "lims = create_engine(\"mssql+pyodbc://lecture_lims:⟬url_password#1⟭@⟬hostname#1⟭/LIMS?driver=ODBC+Driver+18+for+SQL+Server\")\n",
    "res = pd.read_sql(\"SELECT * FROM v_demandes WHERE date_prelevement >= '2024-04-01' AND date_prelevement < '2024-05-01'\", lims)\n",
    "res[\"delai_h\"] = (res[\"date_validation\"] - res[\"date_reception\"]).dt.total_seconds() / 3600"
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
       "famille        n      mediane_h  p95_h  pct_24h\n",
       "biochimie      18402  5.1        19.8   96.2\n",
       "hematologie    12877  3.4        14.2   98.7\n",
       "microbiologie   4210  41.0       96.5   22.4\n",
       "serologie       6033  20.6       47.9   61.8"
      ]
     },
     "execution_count": 2,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "(res.groupby(\"famille\")[\"delai_h\"]\n",
    "    .agg(n=\"size\", mediane_h=\"median\", p95_h=lambda s: s.quantile(0.95), pct_24h=lambda s: (s <= 24).mean() * 100)\n",
    "    .round(1))"
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
       "      ipp  nir  nom  date_naissance  telephone  analyse  delai_h\n",
       "311  ⟬customer_id#2⟭  ⟬fr_social_security_number#2⟭  ⟬person_name#2⟭  ⟬birth_date#2⟭  ⟬phone#2⟭  SEROLOGIE HEPATITE B  71.5\n",
       "958  ⟬customer_id#3⟭  ⟬fr_social_security_number#3⟭  ⟬person_name#3⟭  ⟬birth_date#3⟭  ⟬phone#3⟭  BILAN LIPIDIQUE       52.0\n",
       "1204 ⟬customer_id#4⟭  ⟬fr_social_security_number#4⟭  ⟬person_name#4⟭  ⟬birth_date#4⟭  ⟬phone#4⟭  TSH                   49.3"
      ]
     },
     "execution_count": 3,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "en_retard = res[(res[\"famille\"] != \"microbiologie\") & (res[\"delai_h\"] > 48)].sort_values(\"delai_h\", ascending=False)\n",
    "en_retard[[\"ipp\", \"nir\", \"nom\", \"date_naissance\", \"telephone\", \"analyse\", \"delai_h\"]].head(3)"
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
      "[simulation] SMS -> ⟬phone#2⟭ : Vos résultats sont disponibles sur votre espace patient.\n",
      "[simulation] SMS -> ⟬phone#3⟭ : Vos résultats sont disponibles sur votre espace patient.\n",
      "[simulation] SMS -> ⟬phone#4⟭ : Vos résultats sont disponibles sur votre espace patient.\n"
     ]
    }
   ],
   "source": [
    "from sms import envoyer\n",
    "\n",
    "os.environ[\"SMS_API_KEY\"] = \"⟬opaque_token#5⟭\"\n",
    "for tel in en_retard[\"telephone\"].head(3):\n",
    "    envoyer(tel, \"Vos résultats sont disponibles sur votre espace patient.\", simulation=True)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Envoi réel désactivé tant que ⟬person_name#6⟭ (biologiste responsable) n'a pas validé le texte du SMS."
   ]
  }
 ],
 "metadata": {
  "kernelspec": {"display_name": "Python 3", "language": "python", "name": "python3"},
  "language_info": {"name": "python", "version": "3.10.12"}
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
domain: banking
appearance: markdown cell, notebook output
scenario: market risk notebook of a bank's treasury computing the historical value at risk of a bond portfolio
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "## VaR historique 99 % du portefeuille obligataire, ajustement de ⟬trap:eponym|Cornish-Fisher⟭"
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
      "VaR 99 % historique     : 1.84 M€\n",
      "VaR 99 % Cornish-Fisher : 2.07 M€\n",
      "loi de ⟬trap:eponym|Student⟭ ajustée : 5.3 degrés de liberté\n"
     ]
    }
   ],
   "source": [
    "import numpy as np\n",
    "import pandas as pd\n",
    "from scipy import stats\n",
    "\n",
    "pnl = pd.read_parquet(\"⟬file_path#1⟭\")[\"pnl_eur\"]\n",
    "var_hist = -np.percentile(pnl, 1)\n",
    "z = stats.norm.ppf(0.01)\n",
    "s, k = stats.skew(pnl), stats.kurtosis(pnl)\n",
    "z_cf = z + (z**2 - 1) * s / 6 + (z**3 - 3 * z) * k / 24 - (2 * z**3 - 5 * z) * s**2 / 36\n",
    "var_cf = -(pnl.mean() + z_cf * pnl.std())\n",
    "ddl, _, _ = stats.t.fit(pnl)\n",
    "print(f\"VaR 99 % historique     : {var_hist / 1e6:.2f} M€\")\n",
    "print(f\"VaR 99 % Cornish-Fisher : {var_cf / 1e6:.2f} M€\")\n",
    "print(f\"loi de Student ajustée : {ddl:.1f} degrés de liberté\")"
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
format: .sh
language: fr
fill_locale: fr_FR
domain: public administration
appearance: environment variable, HTTP header, comment, command-line argument
scenario: monthly script publishing aggregated civil registry statistics to a city's open data portal, with a safety filter added after an incident
⟬text⟭
#!/usr/bin/env bash
# Publication mensuelle des statistiques d'état civil sur le portail open data de la ville.
# Seules des données agrégées sortent ; le contrôle grep ci-dessous est un filet de sécurité.
set -euo pipefail

export PGPASSWORD='⟬password#1⟭'
CKAN=https://⟬hostname#2⟭/api/3/action
CLE_CKAN=⟬opaque_token#3⟭
MOIS=$(date -d "last month" +%Y-%m)
F=/tmp/naissances_$MOIS.csv

psql -h ⟬hostname#4⟭ -U opendata -d etat_civil -At -F ';' -c \
  "SELECT quartier, sexe, count(*) FROM naissances WHERE to_char(date_acte, 'YYYY-MM') = '$MOIS' GROUP BY 1, 2" > "$F"

# filet : ni adresse mail ni nom propre ne doit passer (incident de mars : une ligne
# « ⟬person_name#5⟭;⟬email#5⟭ » était sortie d'une vue mal filtrée)
if grep -Eq '@|[A-Z][a-z]+ [A-Z][A-Z]+' "$F"; then
  echo "fichier suspect, publication annulée" >&2
  exit 1
fi

curl -sf -H "Authorization: $CLE_CKAN" -F "package_id=naissances-par-quartier" -F "name=$MOIS" \
  -F "upload=@$F" "$CKAN/resource_create" >/dev/null
echo "publié : $MOIS"
⟬end⟭

⟬template⟭
family: code
format: .sh
language: fr
fill_locale: fr_FR
domain: banking
appearance: heredoc, command-line argument
scenario: one-off script importing a renewed EBICS authentication key into the banking connector's Java keystore
⟬text⟭
#!/bin/sh
# Import de la clé d'authentification EBICS dans le keystore du connecteur (après renouvellement)
umask 077
cat > /tmp/ebics_auth.key <<'EOF'
⟬private_key#1⟭
EOF
openssl pkcs12 -export -in /opt/ebics/certs/auth.crt -inkey /tmp/ebics_auth.key \
  -name ebics-auth -out /tmp/ebics_auth.p12 -passout pass:⟬password#2⟭
keytool -importkeystore -srckeystore /tmp/ebics_auth.p12 -srcstoretype PKCS12 -srcstorepass '⟬password#2⟭' \
  -destkeystore /opt/ebics/keystore.jks -deststorepass '⟬password#3⟭' -noprompt
shred -u /tmp/ebics_auth.key /tmp/ebics_auth.p12
⟬end⟭

⟬template⟭
family: code
format: .sh
language: fr
fill_locale: fr_FR
domain: insurance
appearance: environment variable, file path, heredoc, command-line argument
scenario: sync script pushing an insurer's scanned claim documents to object storage, importing the decryption key for experts' encrypted files
⟬text⟭
#!/bin/bash
# Synchronisation des pièces de sinistres numérisées vers le stockage objet (GED)
# Nommage des fichiers par le scanner : sinistre_<numero>_<nom-assure>_<type>.pdf
#   ex. sinistre_⟬order_number#1⟭_⟬person_name:handle#1⟭_constat.pdf
export AWS_ACCESS_KEY_ID=⟬aws_access_key_id#2⟭
export AWS_SECRET_ACCESS_KEY=⟬aws_secret_access_key#2⟭
export AWS_DEFAULT_REGION=eu-west-3
SRC=/srv/scans/sortie
DEST=s3://ged-sinistres-prod/entrants

# Les experts envoient certaines pièces chiffrées (PGP) : clé du service importée à chaque passage
gpg --batch --import <<'CLE'
⟬private_key#5⟭
CLE
for f in "$SRC"/*.pdf.gpg; do
  [ -e "$f" ] || continue
  gpg --batch --pinentry-mode loopback --passphrase '⟬password#4⟭' -o "${f%.gpg}" -d "$f" && rm -f "$f"
done

aws s3 sync "$SRC" "$DEST" --endpoint-url "https://⟬hostname#3⟭" --sse AES256 --exclude "*.tmp" \
  && find "$SRC" -name '*.pdf' -mmin +60 -delete
⟬end⟭

⟬template⟭
family: code
format: .sh
language: fr
fill_locale: fr_FR
domain: HR
appearance: comment, environment variable
scenario: cron wrapper of the HRIS exports with a lock file, a log and a disk space check, maintained by the operations team
⟬text⟭
#!/bin/bash
# Enveloppe cron des exports SIRH : verrou, journal, contrôle d'espace disque.
# Usage : export_sirh.sh <nom_export>
# Identifiants SFTP lus dans /etc/sirh/export.conf, au format :
#   SFTP_PASS=⟬trap:placeholder|<mot_de_passe_sftp>⟭
set -u
⟬trap:indicator_non_pii|ADMIN_CONTACT=exploitation-sirh⟭
NOM=${1:?nom de l export manquant}
LOG=/var/log/sirh/export_$NOM.log
exec 9>/var/lock/export_$NOM.lock
flock -n 9 || { echo "$(date -Is) export $NOM déjà en cours" >> "$LOG"; exit 0; }

UTILISE=$(df --output=pcent /data/exports | tail -1 | tr -dc '0-9')
if [ "$UTILISE" -gt 90 ]; then
  echo "$(date -Is) disque plein à $UTILISE %, export $NOM annulé, prévenir $ADMIN_CONTACT" >> "$LOG"
  exit 1
fi

. /etc/sirh/export.conf
/opt/sirh/bin/exporter --profil "$NOM" >> "$LOG" 2>&1
echo "$(date -Is) export $NOM terminé (code $?)" >> "$LOG"
⟬end⟭
