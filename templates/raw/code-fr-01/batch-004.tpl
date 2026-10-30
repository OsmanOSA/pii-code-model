⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: banking
appearance: docstring, dict literal, log message, comment, URL
scenario: Kafka consumer of a card issuer's authorisation rules engine, with a sample event and a DEBUG log extract that leak the card data
⟬text⟭
"""Consommateur des événements d'autorisation carte (topic autorisations.v2).

Les événements arrivent au format JSON, un par autorisation. Exemple reçu en
recette (copié depuis kcat, à retirer une fois le schéma publié) :

    {"id": "⟬uuid#1⟭", "pan": "⟬payment_card#2⟭", "cvv_verifie": true, "cvv": "⟬card_security_code#2⟭",
     "porteur": "⟬person_name#2⟭", "montant": 4290, "devise": "EUR", "mcc": "5411",
     "compte_iban": "⟬iban#2⟭", "horodate": "2024-04-02T18:31:07Z"}
"""
import json
import logging

from confluent_kafka import Consumer

from autorisations.regles import evaluer

log = logging.getLogger("autorisations")

CONFIG = {
    "bootstrap.servers": "⟬hostname#3⟭:9093",
    "security.protocol": "SASL_SSL",
    "sasl.mechanisms": "SCRAM-SHA-512",
    "sasl.username": "conso-autorisations",
    "sasl.password": "⟬password#3⟭",
    "group.id": "moteur-regles",
    "auto.offset.reset": "earliest",
}
REGISTRE_SCHEMAS = "https://registre:⟬url_password#4⟭@⟬hostname#4⟭"
⟬trap:indicator_non_pii|CLIENT_USER = "svc-autorisations"⟭


def boucle():
    c = Consumer(CONFIG)
    c.subscribe(["autorisations.v2"])
    try:
        while True:
            msg = c.poll(1.0)
            if msg is None:
                continue
            if msg.error():
                log.error("erreur kafka : %s", msg.error())
                continue
            evt = json.loads(msg.value())
            log.debug("événement reçu : %s", evt)  # FIXME : journalise le PAN en clair
            decision = evaluer(evt)
            if decision.bloquer:
                log.warning("autorisation %s bloquée (règle %s)", evt["id"], decision.regle)
            c.commit(msg, asynchronous=True)
    finally:
        c.close()


if __name__ == "__main__":
    logging.basicConfig(level=logging.DEBUG)
    boucle()

# Extrait du journal en DEBUG (⟬date#1⟭) :
# DEBUG autorisations événement reçu : {'id': '⟬uuid#5⟭', 'pan': '⟬payment_card#5⟭', 'porteur': '⟬person_name#5⟭', 'montant': 120000, ...}
# WARNING autorisations autorisation ⟬uuid#5⟭ bloquée (règle R14-montant-atypique)
⟬end⟭

⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: public administration
appearance: tuple, f-string, dict literal, function call
scenario: PDF generator of a town hall's childhood service printing family quotient certificates, tried on a sample household
⟬text⟭
"""Édition de l'attestation de quotient familial (service enfance de la mairie)."""
from datetime import date

from reportlab.lib.pagesizes import A4
from reportlab.pdfgen import canvas

COLLECTIVITE = ("Mairie - Service Enfance Jeunesse", "⟬fr_postal_address#1⟭", "SIRET ⟬fr_siret#1⟭")


def tranche(qf: float) -> str:
    for plafond, lettre in ((400, "A"), (650, "B"), (900, "C"), (1200, "D")):
        if qf <= plafond:
            return lettre
    return "E"


def attestation(chemin, foyer):
    qf = foyer["revenu_fiscal"] / 12 / foyer["parts"]
    c = canvas.Canvas(chemin, pagesize=A4)
    y = 800
    for ligne in COLLECTIVITE:
        c.drawString(50, y, ligne)
        y -= 14
    c.setFont("Helvetica-Bold", 14)
    c.drawString(50, 720, "Attestation de quotient familial")
    c.setFont("Helvetica", 11)
    c.drawString(50, 690, f"Foyer : {foyer['responsable']} - n° fiscal {foyer['numero_fiscal']}")
    c.drawString(50, 674, f"Adresse : {foyer['adresse']}")
    y = 650
    for prenom, naissance in foyer["enfants"]:
        c.drawString(70, y, f"{prenom}, né(e) le {naissance}")
        y -= 14
    c.drawString(50, y - 10, f"Quotient familial : {qf:.0f} € - tranche {tranche(qf)}")
    c.drawString(50, y - 40, f"Établie le {date.today():%d/%m/%Y}, valable jusqu'au 31/12.")
    c.save()


if __name__ == "__main__":
    attestation("/tmp/essai_qf.pdf", {
        "responsable": "⟬person_name#2⟭",
        "numero_fiscal": "⟬fr_tax_number#2⟭",
        "adresse": "⟬fr_postal_address#2⟭",
        "revenu_fiscal": 27400,
        "parts": 2.5,
        "enfants": [("⟬person_name:given#3⟭", "⟬birth_date#3⟭"), ("⟬person_name:given#4⟭", "⟬birth_date#4⟭")],
    })
⟬end⟭

⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: insurance
appearance: triple-quoted string, exception message, nested dict, test fixture, query string
scenario: client of a supplementary health insurer's third-party payment API, signing JWT assertions with a key left in the module, with mocked tests below
⟬text⟭
"""Client de l'API tiers payant complémentaire (pharmacies et laboratoires).

Authentification : assertion JWT signée (RS256) échangée contre un jeton d'accès.
"""
import logging
import time
import uuid

import jwt
import requests

log = logging.getLogger(__name__)

CLIENT_ID = "⟬username#1⟭"
URL_JETON = "https://⟬hostname#2⟭/oauth2/token"
URL_API = "https://⟬hostname#2⟭/tiers-payant/v1"

# Clé de signature de l'assertion, rangée ici « temporairement » depuis la recette.
CLE_SIGNATURE = """⟬private_key#3⟭"""


class ErreurDroits(Exception):
    pass


class ClientTiersPayant:
    def __init__(self, session=None):
        self.session = session or requests.Session()
        self._jeton = None
        self._expire = 0

    def _assertion(self):
        maintenant = int(time.time())
        revendications = {
            "iss": CLIENT_ID, "sub": CLIENT_ID, "aud": URL_JETON,
            "iat": maintenant, "exp": maintenant + 300, "jti": str(uuid.uuid4()),
        }
        return jwt.encode(revendications, CLE_SIGNATURE, algorithm="RS256")

    def jeton(self):
        if self._jeton and time.time() < self._expire - 30:
            return self._jeton
        r = self.session.post(URL_JETON, data={
            "grant_type": "client_credentials",
            "client_assertion_type": "urn:ietf:params:oauth:client-assertion-type:jwt-bearer",
            "client_assertion": self._assertion(),
        }, timeout=10)
        r.raise_for_status()
        corps = r.json()
        self._jeton, self._expire = corps["access_token"], time.time() + corps["expires_in"]
        return self._jeton

    def droits(self, nir, date_naissance, rang=1):
        r = self.session.get(
            f"{URL_API}/droits",
            params={"nir": nir, "dateNaissance": date_naissance, "rang": rang},
            headers={"Authorization": f"Bearer {self.jeton()}"},
            timeout=10,
        )
        if r.status_code == 404:
            raise ErreurDroits(f"aucun droit ouvert pour le bénéficiaire de rang {rang}")
        r.raise_for_status()
        log.info("droits lus pour le rang %s", rang)
        return r.json()


# --- tests --------------------------------------------------------------------

REPONSE_DROITS = {
    "beneficiaire": {
        "nir": "⟬fr_social_security_number#4⟭",
        "rang": 1,
        "nom": "⟬person_name:family#4⟭",
        "prenom": "⟬person_name:given#4⟭",
        "dateNaissance": "⟬birth_date#4⟭",
    },
    "contrat": {"numero": "⟬order_number#4⟭", "garanties": ["PHARMA_100", "OPTIQUE_150"]},
    "ouvertDu": "2024-01-01",
    "ouvertAu": "2024-12-31",
}


class FausseReponse:
    def __init__(self, corps, statut=200):
        self._corps, self.status_code = corps, statut

    def json(self):
        return self._corps

    def raise_for_status(self):
        if self.status_code >= 400:
            raise requests.HTTPError(self.status_code)


class FausseSession:
    def post(self, *args, **kwargs):
        return FausseReponse({"access_token": "⟬jwt#5⟭", "expires_in": 3600})

    def get(self, url, params=None, **kwargs):
        if params["nir"] == REPONSE_DROITS["beneficiaire"]["nir"]:
            return FausseReponse(REPONSE_DROITS)
        return FausseReponse({}, 404)


def test_droits_ouverts(monkeypatch):
    monkeypatch.setattr(ClientTiersPayant, "_assertion", lambda self: "assertion")
    client = ClientTiersPayant(FausseSession())
    droits = client.droits("⟬fr_social_security_number#4⟭", "⟬birth_date#4⟭")
    assert droits["contrat"]["garanties"][0] == "PHARMA_100"


def test_beneficiaire_inconnu(monkeypatch):
    monkeypatch.setattr(ClientTiersPayant, "_assertion", lambda self: "assertion")
    client = ClientTiersPayant(FausseSession())
    try:
        client.droits("⟬fr_social_security_number#6⟭", "⟬birth_date#6⟭")
    except ErreurDroits:
        return
    raise AssertionError("ErreurDroits attendue")
⟬end⟭

⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: HR
appearance: assignment, URL, comment
scenario: short pseudonymisation script of an HR analyst preparing an employee extract for an external workplace study
⟬text⟭
# Pseudonymisation de l'extrait salariés avant envoi au cabinet d'études (enquête QVT).
# Le sel ne doit JAMAIS partir avec le fichier.
import hashlib

import pandas as pd
from sqlalchemy import create_engine

SEL = "⟬opaque_token#1⟭"
src = create_engine("postgresql://etudes_ro:⟬url_password#2⟭@⟬hostname#2⟭/sirh")

df = pd.read_sql("SELECT nir, service, anciennete, temps_partiel FROM salaries WHERE actif", src)
df["id_etude"] = df.pop("nir").map(lambda n: hashlib.sha256((SEL + n).encode()).hexdigest()[:16])
df.to_csv("extrait_qvt.csv", index=False)

# contrôle fait avec un salarié volontaire : ⟬fr_social_security_number#3⟭ -> ⟬hash#3⟭
⟬end⟭

⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: energy
appearance: assignment, string literal, test fixture, form data
scenario: scraper downloading a large account's gas invoices from the supplier's web portal, with a parsing test built from one invoice header
⟬text⟭
"""Téléchargement mensuel des factures du fournisseur de gaz (portail grands comptes).

Le portail n'a pas d'API : on rejoue le formulaire de connexion puis on
récupère le PDF de chaque site. L'en-tête des factures est ensuite contrôlé
(voir le test en bas de fichier).
"""
import re
from pathlib import Path

import requests
from pypdf import PdfReader

PORTAIL = "https://⟬hostname#1⟭"
IDENTIFIANT = "⟬email#2⟭"
MOT_DE_PASSE = "⟬password#2⟭"
DOSSIER = Path("⟬file_path#1⟭")


def connexion():
    s = requests.Session()
    page = s.get(f"{PORTAIL}/connexion", timeout=20)
    csrf = re.search(r'name="csrf" value="([^"]+)"', page.text).group(1)
    r = s.post(f"{PORTAIL}/connexion", data={"login": IDENTIFIANT, "password": MOT_DE_PASSE, "csrf": csrf}, timeout=20)
    r.raise_for_status()
    return s


def telecharger(session, mois):
    for facture in session.get(f"{PORTAIL}/factures", params={"mois": mois}, timeout=20).json():
        chemin = DOSSIER / f"{facture['site']}_{mois}.pdf"
        chemin.write_bytes(session.get(f"{PORTAIL}/factures/{facture['id']}/pdf", timeout=60).content)
        yield chemin


def analyser_texte(texte):
    return {
        "titulaire": re.search(r"Titulaire : (.+)", texte).group(1).strip(),
        "siret": re.search(r"SIRET : ([\d ]+)", texte).group(1).replace(" ", ""),
        "montant_ttc": float(re.search(r"Total TTC : ([\d ,]+)", texte).group(1).replace(" ", "").replace(",", ".")),
    }


def lire_entete(chemin):
    return analyser_texte(PdfReader(chemin).pages[0].extract_text())


def test_analyser_texte():
    texte = (
        "Titulaire : ⟬company#3⟭\n"
        "Interlocuteur : ⟬person_name#4⟭ - ⟬phone#4⟭\n"
        "Site : ⟬fr_postal_address#3⟭\n"
        "SIRET : ⟬fr_siret#3⟭\n"
        "Total TTC : 12 480,22\n"
    )
    entete = analyser_texte(texte)
    assert entete["montant_ttc"] == 12480.22
    assert len(entete["siret"]) == 14
⟬end⟭

⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: doctest, docstring, exception message
scenario: health insurance card reader module of a clinic's front desk software, documented with the output of the vendor's test card
⟬text⟭
"""Lecture de la carte Vitale via le lecteur PC/SC du poste d'accueil.

>>> from accueil.vitale import lire_carte
>>> lire_carte()  # carte de test du kit éditeur
{'nir': '⟬fr_social_security_number#1⟭', 'rang': 1, 'nom': '⟬person_name:family#1⟭', 'prenom': '⟬person_name:given#1⟭', 'date_naissance': '⟬birth_date#1⟭', 'regime': '01', 'caisse': '751'}
"""
from smartcard.System import readers

from .apdu import SELECT_VITALE, decoder_identite


def lire_carte(index_lecteur=0):
    connexion = readers()[index_lecteur].createConnection()
    connexion.connect()
    donnees, sw1, sw2 = connexion.transmit(SELECT_VITALE)
    if (sw1, sw2) != (0x90, 0x00):
        raise RuntimeError(f"carte illisible ({sw1:02X}{sw2:02X})")
    return decoder_identite(donnees)
⟬end⟭

⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: insurance
appearance: docstring, dict literal, assignment
scenario: claims settlement module of a home insurer computing indemnities with depreciation and the average clause
⟬text⟭
"""Calcul de l'indemnité habitation : vétusté et règle proportionnelle de capitaux.

La règle proportionnelle s'applique quand le capital mobilier déclaré est
inférieur de plus de 10 % à la valeur constatée par l'expert.
"""
from decimal import ROUND_HALF_UP, Decimal

TOLERANCE_SOUS_ASSURANCE = Decimal("0.10")
FRANCHISE_DEFAUT = Decimal("150")
⟬trap:indicator_non_pii|NOM_REGLE = "RP-capitaux-2019"⟭

# Coefficient de vétusté annuel selon le matériau principal du bâti
VETUSTE_PAR_MATERIAU = {
    "⟬trap:word_name|Pierre⟭": Decimal("0.010"),
    "Brique": Decimal("0.012"),
    "Béton": Decimal("0.015"),
    "Bois": Decimal("0.025"),
}
VETUSTE_MAX = Decimal("0.50")


def coefficient_vetuste(materiau: str, age_ans: int) -> Decimal:
    taux = VETUSTE_PAR_MATERIAU.get(materiau, Decimal("0.020"))
    return min(taux * age_ans, VETUSTE_MAX)


def regle_proportionnelle(capital_declare: Decimal, valeur_constatee: Decimal) -> Decimal:
    if valeur_constatee <= 0:
        return Decimal("1")
    rapport = capital_declare / valeur_constatee
    return Decimal("1") if rapport >= 1 - TOLERANCE_SOUS_ASSURANCE else rapport


def indemnite(dommage: Decimal, materiau: str, age_ans: int, capital_declare: Decimal,
              valeur_constatee: Decimal, franchise: Decimal = FRANCHISE_DEFAUT) -> Decimal:
    apres_vetuste = dommage * (1 - coefficient_vetuste(materiau, age_ans))
    proportion = regle_proportionnelle(capital_declare, valeur_constatee)
    montant = max(apres_vetuste * proportion - franchise, Decimal("0"))
    return montant.quantize(Decimal("0.01"), ROUND_HALF_UP)
⟬end⟭

⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: banking
appearance: assignment
scenario: package init file of a bank's internal SEPA file generation library
⟬text⟭
"""Bibliothèque interne de génération des fichiers SEPA (pain.001, pain.008)."""
from .pain001 import generer_pain001
from .pain008 import generer_pain008
from .validation import ErreurSchema, valider

__all__ = ["generer_pain001", "generer_pain008", "valider", "ErreurSchema"]
__version__ = "⟬version#1⟭"
⟬trap:indicator_non_pii|__author__ = "équipe paiements"⟭
__license__ = "Propriétaire - usage interne"
⟬end⟭

⟬template⟭
family: code
format: .sql
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: SQL string, function call, comment
scenario: pseudonymised research view of a hospital health data warehouse, with the HMAC key inlined and a re-identification check below
⟬text⟭
-- Entrepôt de données de santé : vue pseudonymisée pour le projet de recherche ⟬ticket_id#1⟭
-- Le pseudonyme est un HMAC du NIR ; la clé devait venir du coffre (voir avec la sécurité).

CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE OR REPLACE VIEW recherche.v_sejours_pseudo AS
SELECT
    encode(hmac(p.nir, '⟬opaque_token#2⟭', 'sha256'), 'hex') AS pseudo_id,
    date_part('year', p.date_naissance)::int AS annee_naissance,
    p.sexe,
    s.date_entree,
    s.date_sortie,
    s.diagnostic_principal,
    s.mode_sortie
FROM sejours s
JOIN patients p ON p.id = s.patient_id
WHERE s.date_entree >= DATE '2018-01-01';

GRANT SELECT ON recherche.v_sejours_pseudo TO equipe_recherche;

-- Contrôle de réidentification par l'équipe interne (autorisé par le DPO) :
SELECT encode(hmac('⟬fr_social_security_number#3⟭', '⟬opaque_token#2⟭', 'sha256'), 'hex');
-- patient ⟬person_name#3m⟭, né le ⟬birth_date#3⟭ : doit retrouver 4 séjours dans la vue
⟬end⟭

⟬template⟭
family: code
format: .sql
language: fr
fill_locale: fr_FR
domain: banking
appearance: SQL string, comment
scenario: MySQL account script for the BI tool reading a consumer credit database, run once by the DBA
⟬text⟭
-- comptes de l'outil de reporting (BI) sur la base des crédits
CREATE USER ⟬trap:email_lookalike|'bi_lecture'@'10.12.%'⟭ IDENTIFIED BY '⟬password#1⟭';
GRANT SELECT ON credits.* TO ⟬trap:email_lookalike|'bi_lecture'@'10.12.%'⟭;
CREATE USER 'bi_admin'@'localhost' IDENTIFIED BY '⟬password#2⟭';
GRANT ALL PRIVILEGES ON reporting.* TO 'bi_admin'@'localhost';
FLUSH PRIVILEGES;
⟬end⟭

⟬template⟭
family: code
format: .sql
language: fr
fill_locale: fr_FR
domain: public administration
appearance: SQL INSERT, SQL DELETE, comment, SQL UPDATE
scenario: migration of a city's resident parking permits from the old software, with rows fixed by hand and a fraud case noted by the municipal police
⟬text⟭
-- ============================================================
-- Stationnement résidentiel : reprise des vignettes de l'ancien logiciel
-- Base cible : stationnement (PostgreSQL)   Source : export CSV de l'ancien outil
-- ============================================================

CREATE TABLE IF NOT EXISTS vignettes (
    id                SERIAL PRIMARY KEY,
    numero            VARCHAR(12) UNIQUE NOT NULL,
    zone              CHAR(2) NOT NULL,
    titulaire_nom     VARCHAR(120) NOT NULL,
    adresse           VARCHAR(200) NOT NULL,
    telephone         VARCHAR(20),
    immatriculation   VARCHAR(10) NOT NULL,
    numero_fiscal     VARCHAR(13),
    justificatif      VARCHAR(20) NOT NULL,
    valide_du         DATE NOT NULL,
    valide_au         DATE NOT NULL
);

-- Lignes corrigées à la main (l'export d'origine coupait les adresses à 60 caractères)
INSERT INTO vignettes (numero, zone, titulaire_nom, adresse, telephone, immatriculation, numero_fiscal, justificatif, valide_du, valide_au) VALUES
 ('R24-00117', 'Z1', '⟬person_name#1⟭', '⟬fr_postal_address#1⟭', '⟬phone#1⟭', '⟬fr_license_plate#1⟭', '⟬fr_tax_number#1⟭', 'avis_TH', '⟬date#4⟭', '⟬date#1⟭'),
 ('R24-00118', 'Z1', '⟬person_name#2⟭', '⟬fr_postal_address#2⟭', NULL, '⟬fr_license_plate#2⟭', '⟬fr_tax_number#2⟭', 'avis_TH', '⟬date#4⟭', '⟬date#1⟭'),
 ('R24-00121', 'Z3', '⟬person_name#3⟭', '⟬fr_postal_address#3⟭', '⟬phone#3⟭', '⟬fr_license_plate#3⟭', NULL, 'bail', '⟬date#3⟭', '⟬date#1⟭'),
 ('R24-00140', 'Z2', '⟬person_name#4⟭', '⟬fr_postal_address#4⟭', '⟬phone#4⟭', '⟬fr_license_plate#4⟭', '⟬fr_tax_number#4⟭', 'avis_TH', '⟬date#2⟭', '⟬date#1⟭');

-- Second véhicule du foyer R24-00117 (autorisé en zone 1 depuis la délibération de janvier)
INSERT INTO vignettes (numero, zone, titulaire_nom, adresse, telephone, immatriculation, numero_fiscal, justificatif, valide_du, valide_au)
SELECT 'R24-00117B', zone, titulaire_nom, adresse, telephone, '⟬fr_license_plate#5⟭', numero_fiscal, justificatif, valide_du, valide_au
  FROM vignettes
 WHERE numero = 'R24-00117';

-- Purge des vignettes expirées depuis plus de deux ans (durée de conservation votée)
DELETE FROM vignettes WHERE valide_au < CURRENT_DATE - INTERVAL '2 years';

-- Signalement de la police municipale : véhicule ⟬fr_license_plate#6⟭ vu avec la vignette
-- R24-00121 ; titulaire joint le ⟬date#2⟭ au ⟬phone#3⟭, vignette close
UPDATE vignettes SET valide_au = CURRENT_DATE WHERE numero = 'R24-00121';

-- Contrôle : une seule vignette active par plaque
SELECT immatriculation, count(*)
  FROM vignettes
 WHERE CURRENT_DATE BETWEEN valide_du AND valide_au
 GROUP BY immatriculation
HAVING count(*) > 1;
⟬end⟭

⟬template⟭
family: code
format: .sql
language: fr
fill_locale: fr_FR
domain: insurance
appearance: SQL WHERE, comment
scenario: weekly loss ratio query behind a property and casualty insurer's technical dashboard
⟬text⟭
-- Ratio sinistres / primes par produit et par apporteur, exercice en cours
-- Utilisé par le tableau de bord de la direction technique (rafraîchi chaque lundi).
WITH primes AS (
    SELECT produit, apporteur, sum(prime_acquise) AS primes
      FROM primes_acquises
     WHERE exercice = date_part('year', CURRENT_DATE)
     GROUP BY 1, 2
),
charges AS (
    SELECT c.produit, c.apporteur, sum(s.reglements + s.provisions) AS charge
      FROM sinistres s
      JOIN contrats c ON c.id = s.contrat_id
     WHERE date_part('year', s.date_survenance) = date_part('year', CURRENT_DATE)
       AND ⟬trap:indicator_non_pii|s.gestionnaire <> 'AUTO'⟭  -- la gestion automatique est suivie à part
     GROUP BY 1, 2
)
SELECT p.produit,
       p.apporteur,
       p.primes,
       coalesce(c.charge, 0) AS charge,
       round(100.0 * coalesce(c.charge, 0) / nullif(p.primes, 0), 1) AS sp_pct
  FROM primes p
  LEFT JOIN charges c USING (produit, apporteur)
 WHERE p.apporteur <> '⟬trap:company_name|Cabinet ⦃Family⦄⟭'  -- portefeuille en run-off, exclu du suivi
 ORDER BY sp_pct DESC NULLS LAST;
⟬end⟭

⟬template⟭
family: code
format: .sql
language: fr
fill_locale: fr_FR
domain: HR
appearance: SQL INSERT, comment, free text
scenario: seed of the test database of an applicant tracking system, with interview notes copied from production by a recruiter
⟬text⟭
-- Seed de l'environnement de test de l'outil de recrutement
-- psql "postgresql://ats:⟬url_password#1⟭@⟬hostname#1⟭/ats_test" -f seed_candidats.sql

INSERT INTO recruteurs (email, mot_de_passe, nom_affiche) VALUES
    ('⟬email#2⟭', '⟬password#2⟭', '⟬person_name#2⟭');

INSERT INTO candidats (nom, prenom, email, telephone, adresse, date_naissance, source) VALUES
    ('⟬person_name:family#3f⟭', '⟬person_name:given#3⟭', '⟬email#3⟭', '⟬phone#3⟭', '⟬fr_postal_address#3⟭', '⟬birth_date#3⟭', 'jobboard'),
    ('⟬person_name:family#4m⟭', '⟬person_name:given#4⟭', '⟬email#4⟭', '⟬phone#4⟭', NULL, NULL, 'cooptation'),
    ('⟬person_name:family#5m⟭', '⟬person_name:given#5⟭', '⟬email#5⟭', NULL, '⟬fr_postal_address#5⟭', '⟬birth_date#5⟭', 'candidature_spontanee');

INSERT INTO notes_entretien (candidat_id, auteur, contenu) VALUES
    (1, '⟬email#2⟭', 'Bon niveau technique. Recommandée par ⟬person_name#6⟭ (équipe data). À revoir avec le manager.'),
    (2, '⟬email#2⟭', 'Coopté par ⟬person_name#7⟭, disponible sous 1 mois, prétentions 48k.'),
    (3, '⟬email#2⟭', 'Ne pas recontacter avant le ⟬date#1⟭ (demande du candidat).');
⟬end⟭

⟬template⟭
family: code
format: .ipynb
language: fr
fill_locale: fr_FR
domain: energy
appearance: free text, notebook output, markdown cell, list literal
scenario: NLP prototype notebook of an energy retailer's customer service routing complaints, whose outputs show raw complaint texts
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Réclamations clients T2 : classification des motifs (essai)\n",
    "\n",
    "Objectif : router automatiquement chaque réclamation vers la bonne équipe (facturation, relève, recouvrement, technique)."
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
       "(18342, 4)"
      ]
     },
     "execution_count": 1,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "import pandas as pd\n",
    "\n",
    "rec = pd.read_json(\"⟬file_path#1⟭\", lines=True)\n",
    "rec.shape"
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
       "['Bonjour, je conteste la facture de mars, le compteur a été relevé deux fois. ⟬person_name#2⟭, ⟬fr_postal_address#2⟭',\n",
       " \"Suite à mon déménagement le prélèvement continue sur ⟬iban#3⟭ alors que j'ai résilié !!! rappelez moi au ⟬phone#3⟭\",\n",
       " 'chèque énergie refusé, mon numéro fiscal est ⟬fr_tax_number#4⟭ merci de vérifier',\n",
       " 'Coupure sans prévenir chez ma mère (⟬person_name#5f⟭) qui est sous oxygène, contactez moi ⟬email#6⟭']"
      ]
     },
     "execution_count": 2,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "rec[\"texte\"].head(4).tolist()"
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
      "              precision    recall  f1-score   support\n",
      "\n",
      " facturation       0.88      0.91      0.89      1903\n",
      "      releve       0.79      0.74      0.76       612\n",
      "recouvrement       0.84      0.80      0.82       455\n",
      "   technique       0.81      0.85      0.83       699\n",
      "\n",
      "    accuracy                           0.85      3669\n"
     ]
    }
   ],
   "source": [
    "from sklearn.feature_extraction.text import TfidfVectorizer\n",
    "from sklearn.linear_model import LogisticRegression\n",
    "from sklearn.metrics import classification_report\n",
    "from sklearn.model_selection import train_test_split\n",
    "from sklearn.pipeline import make_pipeline\n",
    "\n",
    "X_tr, X_te, y_tr, y_te = train_test_split(rec[\"texte\"], rec[\"motif\"], test_size=0.2, random_state=0)\n",
    "pipeline = make_pipeline(TfidfVectorizer(ngram_range=(1, 2), min_df=3), LogisticRegression(max_iter=1000))\n",
    "pipeline.fit(X_tr, y_tr)\n",
    "print(classification_report(y_te, pipeline.predict(X_te)))"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Attention : les textes contiennent des données personnelles (IBAN, téléphones, adresses). Ne pas exporter ce notebook avec ses sorties."
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
       "array(['facturation', 'technique'], dtype=object)"
      ]
     },
     "execution_count": 4,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "pipeline.predict([\n",
    "    \"Bonjour, mon IBAN a changé : ⟬iban#7⟭, merci de mettre à jour avant le prochain prélèvement\",\n",
    "    \"plus de courant depuis ce matin au ⟬fr_postal_address#8⟭, le disjoncteur ne remonte pas\",\n",
    "])"
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
format: .ipynb
language: fr
fill_locale: fr_FR
domain: HR
appearance: triple-quoted string, keyword argument, notebook output, markdown cell
scenario: payroll reconciliation notebook comparing the HRIS net pay with the bank transfer file, fetching the bank report over SFTP
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Rapprochement paie / virements : mars\n",
    "\n",
    "Comparaison du net à payer du SIRH avec le fichier de virements transmis à la banque et le compte rendu d'exécution."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "metadata": {},
   "outputs": [],
   "source": [
    "import io\n",
    "import paramiko\n",
    "\n",
    "CLE = \"\"\"⟬private_key#1⟭\"\"\"\n",
    "cle = paramiko.RSAKey.from_private_key(io.StringIO(CLE), password=\"⟬password#2⟭\")\n",
    "t = paramiko.Transport((\"⟬hostname#2⟭\", 22))\n",
    "t.connect(username=\"paie_cr\", pkey=cle)\n",
    "sftp = paramiko.SFTPClient.from_transport(t)\n",
    "sftp.get(\"/sortant/CR_VIR_PAIE_202403.xml\", \"cr_mars.xml\")\n",
    "sftp.get(\"/archive/VIR_PAIE_202403.xml\", \"vir_mars.xml\")"
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
      "MsgId=PAIE-2024-03  InitgPty=⟬company#3⟭ (SIRET ⟬fr_siret#3⟭)  NbOfTxs=412  CtrlSum=1023877.54\n"
     ]
    }
   ],
   "source": [
    "import xml.etree.ElementTree as ET\n",
    "ns = {\"p\": \"urn:iso:std:iso:20022:tech:xsd:pain.001.001.03\"}\n",
    "hdr = ET.parse(\"vir_mars.xml\").getroot().find(\".//p:GrpHdr\", ns)\n",
    "siret = hdr.findtext(\".//p:InitgPty/p:Id/p:OrgId/p:Othr/p:Id\", namespaces=ns)\n",
    "print(f\"MsgId={hdr.findtext('p:MsgId', namespaces=ns)}  InitgPty={hdr.findtext('.//p:InitgPty/p:Nm', namespaces=ns)} (SIRET {siret})  \"\n",
    "      f\"NbOfTxs={hdr.findtext('p:NbOfTxs', namespaces=ns)}  CtrlSum={hdr.findtext('p:CtrlSum', namespaces=ns)}\")"
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
       "   matricule  nom  iban_sirh  iban_virement  net_sirh  montant_vire\n",
       "0  ⟬customer_id#4⟭  ⟬person_name#4⟭  ⟬iban#4⟭  ⟬iban#8⟭  2311.08  2311.08\n",
       "1  ⟬customer_id#5⟭  ⟬person_name#5⟭  ⟬iban#5⟭  ⟬iban#5⟭  1987.40  1775.00\n",
       "2  ⟬customer_id#6⟭  ⟬person_name#6⟭  ⟬iban#6⟭  ⟬iban#6⟭  3402.12  0.00"
      ]
     },
     "execution_count": 3,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "import pandas as pd\n",
    "from paie.rapprochement import charger_sirh, charger_virements\n",
    "\n",
    "sirh = charger_sirh(\"2024-03\")\n",
    "vir = charger_virements(\"vir_mars.xml\", \"cr_mars.xml\")\n",
    "ecarts = sirh.merge(vir, on=\"matricule\", how=\"left\", suffixes=(\"_sirh\", \"_virement\"))\n",
    "ecarts = ecarts[(ecarts[\"iban_sirh\"] != ecarts[\"iban_virement\"]) | (ecarts[\"net_sirh\"] != ecarts[\"montant_vire\"])]\n",
    "ecarts[[\"matricule\", \"nom\", \"iban_sirh\", \"iban_virement\", \"net_sirh\", \"montant_vire\"]].reset_index(drop=True)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "- ⟬person_name#4⟭ a changé de banque le ⟬date#1⟭ : le virement est parti sur le nouveau compte mais le SIRH n'est pas à jour.\n",
    "- ⟬person_name#5⟭ : écart de 212,40 €, virement complémentaire à faire.\n",
    "- ⟬person_name#6⟭ : rejet bancaire (compte clos), voir le compte rendu."
   ]
  }
 ],
 "metadata": {
  "kernelspec": {"display_name": "Python 3 (paie)", "language": "python", "name": "paie"},
  "language_info": {"name": "python", "version": "3.11.2"}
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
domain: public administration
appearance: markdown cell, notebook output, function call
scenario: notebook of a regional audit team testing public procurement amounts from open data against Benford's law
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Commande publique : contrôle des montants par la ⟬trap:eponym|loi de Benford⟭\n",
    "\n",
    "Données essentielles des marchés, acheteurs de l'ancienne région ⟬trap:word_name|Lorraine⟭, 2019-2023."
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
       "chiffre  observe  attendu\n",
       "1        0.284    0.301\n",
       "2        0.169    0.176\n",
       "3        0.131    0.125\n",
       "4        0.122    0.097\n",
       "5        0.074    0.079\n",
       "6        0.066    0.067\n",
       "7        0.054    0.058\n",
       "8        0.051    0.051\n",
       "9        0.049    0.046"
      ]
     },
     "execution_count": 1,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "import json\n",
    "import numpy as np\n",
    "import pandas as pd\n",
    "\n",
    "with open(\"⟬file_path#1⟭\", encoding=\"utf-8\") as f:\n",
    "    marches = pd.json_normalize(json.load(f)[\"marches\"])\n",
    "montants = marches.loc[marches[\"montant\"] > 0, \"montant\"]\n",
    "premier = montants.astype(str).str.lstrip(\"0.\").str[0].astype(int)\n",
    "obs = premier.value_counts(normalize=True).sort_index()\n",
    "pd.DataFrame({\"observe\": obs.round(3), \"attendu\": np.log10(1 + 1 / obs.index).round(3)}).rename_axis(\"chiffre\")"
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
      "chi2 = 41.7, p = 1.6e-06 (n = 9 812)\n"
     ]
    }
   ],
   "source": [
    "from scipy.stats import chisquare\n",
    "attendu = np.log10(1 + 1 / np.arange(1, 10)) * len(premier)\n",
    "stat, p = chisquare(premier.value_counts().sort_index(), attendu)\n",
    "print(f\"chi2 = {stat:.1f}, p = {p:.1e} (n = {len(premier):,})\".replace(\",\", \" \"))"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Excès sur le chiffre 4 : effet du seuil de 40 000 € HT (procédure adaptée), attendu. Pas d'anomalie à signaler en l'état."
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
format: .sh
language: fr
fill_locale: fr_FR
domain: insurance
appearance: curl command, JSON body, URL, HTTP header
scenario: cron script of a claims department exporting a BI question as CSV every Monday and announcing it on the team channel
⟬text⟭
#!/usr/bin/env bash
# Export hebdomadaire de la question Metabase « sinistres ouverts depuis plus de 90 jours »
# vers le partage des gestionnaires. Lancé par cron le lundi à 7h.
set -euo pipefail

MB=https://⟬hostname#1⟭
QUESTION=412

SESSION=$(curl -s -X POST "$MB/api/session" -H 'Content-Type: application/json' \
  -d '{"username": "⟬email#2⟭", "password": "⟬password#2⟭"}' | jq -r .id)

curl -s -X POST "$MB/api/card/$QUESTION/query/csv" -H "X-Metabase-Session: $SESSION" -o /tmp/sinistres_90j.csv

NB=$(($(wc -l < /tmp/sinistres_90j.csv) - 1))
curl -s -X POST "https://⟬hostname#3⟭/webhookb2/⟬opaque_token#3⟭" -H 'Content-Type: application/json' \
  -d "{\"text\": \"$NB sinistres ouverts depuis plus de 90 jours, fichier sur le partage\"}"

cp /tmp/sinistres_90j.csv "⟬file_path#1⟭"
curl -s -X DELETE "$MB/api/session" -H "X-Metabase-Session: $SESSION"
⟬end⟭

⟬template⟭
family: code
format: .sh
language: fr
fill_locale: fr_FR
domain: energy
appearance: heredoc, comment, command-line argument
scenario: script generating OpenVPN profiles for a grid operator's field technicians, with a shared emergency profile whose key is frozen in the script
⟬text⟭
#!/bin/bash
# Génère le profil OpenVPN d'un technicien d'intervention (accès aux postes sources).
# Usage : ./profil_vpn.sh <identifiant>
# Dernière génération : ./profil_vpn.sh ⟬person_name:handle#1⟭ (⟬person_name#1⟭, le ⟬date#1⟭)
set -e
ID=${1:?identifiant manquant}
SORTIE=/srv/vpn/profils/$ID.ovpn

if [ "$ID" = "secours" ]; then
  # profil partagé de l'astreinte, clé figée faute de PKI joignable la nuit
  cat > "$SORTIE" <<'EOF'
client
dev tun
proto udp
remote ⟬hostname#2⟭ 1194
remote-cert-tls server
<key>
⟬private_key#3⟭
</key>
<tls-crypt>
⟬opaque_token#4⟭
</tls-crypt>
EOF
  exit 0
fi

cat > "$SORTIE" <<EOF
client
dev tun
proto udp
remote ⟬hostname#2⟭ 1194
remote-cert-tls server
cipher AES-256-GCM
<ca>
$(cat /etc/openvpn/pki/ca.crt)
</ca>
<cert>
$(cat /etc/openvpn/pki/issued/$ID.crt)
</cert>
<key>
$(cat /etc/openvpn/pki/private/$ID.key)
</key>
EOF
chmod 600 "$SORTIE"
echo "profil écrit : $SORTIE"
⟬end⟭

⟬template⟭
family: code
format: .sh
language: fr
fill_locale: fr_FR
domain: HR
appearance: LDIF, environment variable, heredoc, file path
scenario: onboarding script of the IT support team creating a new hire's directory account, left with the values of the last arrival
⟬text⟭
#!/bin/bash
# Création du compte d'un nouvel arrivant dans l'annuaire (support N2).
# Les valeurs ci-dessous sont celles de l'arrivée du ⟬date#1⟭ : à adapter à chaque fois.
LDAP_URI=ldaps://⟬hostname#1⟭
BIND_DN="cn=admin,dc=entreprise,dc=local"
BIND_PW='⟬password#1⟭'

ldapadd -H "$LDAP_URI" -D "$BIND_DN" -w "$BIND_PW" <<'LDIF'
dn: uid=⟬person_name:handle#2⟭,ou=personnes,dc=entreprise,dc=local
objectClass: inetOrgPerson
objectClass: posixAccount
uid: ⟬person_name:handle#2⟭
cn: ⟬person_name#2⟭
givenName: ⟬person_name:given#2⟭
sn: ⟬person_name:family#2⟭
mail: ⟬email#2⟭
telephoneNumber: ⟬phone#2⟭
title: ⟬job_title#2⟭
uidNumber: 10482
gidNumber: 10000
homeDirectory: /home/⟬person_name:handle#2⟭
loginShell: /bin/bash
userPassword: ⟬password#3⟭
LDIF

ldapmodify -H "$LDAP_URI" -D "$BIND_DN" -w "$BIND_PW" <<'LDIF'
dn: cn=equipe-comptabilite,ou=groupes,dc=entreprise,dc=local
changetype: modify
add: memberUid
memberUid: ⟬person_name:handle#2⟭
LDIF

echo "compte créé ; mot de passe provisoire à envoyer par SMS au ⟬phone#2⟭"
⟬end⟭

⟬template⟭
family: code
format: .sh
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: environment variable, command-line argument
scenario: local development start script of a patient record application, for developers only
⟬text⟭
#!/bin/sh
# Démarrage de l'environnement local du dossier patient (développeurs uniquement)
⟬trap:indicator_non_pii|export POSTGRES_USER=dev⟭
export POSTGRES_PASSWORD="⟬trap:placeholder|${POSTGRES_PASSWORD:-dev}⟭"
export KEYCLOAK_ADMIN_PASSWORD="⟬trap:placeholder|${KEYCLOAK_ADMIN_PASSWORD:?définir dans .env.local}⟭"
docker compose -f docker-compose.dev.yml up -d postgres keycloak
until docker compose -f docker-compose.dev.yml exec -T postgres pg_isready -U "$POSTGRES_USER"; do sleep 1; done
python manage.py migrate && python manage.py loaddata patients_fictifs.json
python manage.py runserver 0.0.0.0:8000
⟬end⟭
