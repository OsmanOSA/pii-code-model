⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: insurance
appearance: URL, email header, test fixture, free text
scenario: mailbox poller of a motor insurer reading free-form claim emails and matching them to contracts, with a sample message in its test
⟬text⟭
"""Relève de la boîte « déclarations sinistres » et rattachement des pièces jointes.

Les assurés écrivent librement : on cherche le numéro de contrat ou la plaque
dans l'objet et le corps, sinon le message part en tri manuel.
"""
import email
import email.utils
import imaplib
import re
from email.header import decode_header, make_header
from urllib.parse import urlparse

BOITE = "imaps://declarations:⟬url_password#1⟭@⟬hostname#1⟭/INBOX"
RE_CONTRAT = re.compile(r"\b(AU|HA)\d{8}\b")
RE_PLAQUE = re.compile(r"\b[A-Z]{2}-?\d{3}-?[A-Z]{2}\b")


def _texte(msg):
    for partie in msg.walk():
        if partie.get_content_type() == "text/plain":
            return partie.get_payload(decode=True).decode(partie.get_content_charset() or "utf-8", "replace")
    return ""


def analyser(brut: bytes) -> dict:
    msg = email.message_from_bytes(brut)
    objet = str(make_header(decode_header(msg["Subject"] or "")))
    corps = _texte(msg)
    contrat = RE_CONTRAT.search(objet + " " + corps)
    plaque = RE_PLAQUE.search(objet + " " + corps)
    return {
        "expediteur": email.utils.parseaddr(msg["From"]),
        "contrat": contrat.group() if contrat else None,
        "plaque": plaque.group().replace("-", "") if plaque else None,
        "pieces": [p.get_filename() for p in msg.walk() if p.get_filename()],
    }


def relever():
    u = urlparse(BOITE)
    with imaplib.IMAP4_SSL(u.hostname) as imap:
        imap.login(u.username, u.password)
        imap.select(u.path.strip("/"))
        _, ids = imap.search(None, "UNSEEN")
        for i in ids[0].split():
            _, data = imap.fetch(i, "(RFC822)")
            yield analyser(data[0][1])


def test_analyser():
    brut = (
        "From: ⟬person_name#2⟭ <⟬email#2⟭>\r\n"
        "Subject: accrochage parking\r\n"
        "Content-Type: text/plain; charset=utf-8\r\n\r\n"
        "Bonjour, accrochage hier soir avec ma voiture ⟬fr_license_plate#2⟭ sur le parking du magasin. "
        "Mon contrat est le AU20391144. Vous pouvez me joindre au ⟬phone#2⟭.\r\n"
    ).encode()
    res = analyser(brut)
    assert res["contrat"] == "AU20391144"
    assert res["expediteur"][1] == "⟬email#2⟭"
⟬end⟭

⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: test fixture, dict literal, triple-quoted string, query string
scenario: Django REST Framework module of a clinic's patient administration API with its pytest tests appended, signing test tokens with a dedicated key
⟬text⟭
"""API REST du dossier administratif patient (Django REST Framework)."""
from rest_framework import permissions, serializers, viewsets
from rest_framework.decorators import action
from rest_framework.response import Response

from .models import Patient
from .validateurs import nir_valide


class PatientSerializer(serializers.ModelSerializer):
    class Meta:
        model = Patient
        fields = ["id", "nir", "nom_naissance", "nom_usage", "prenoms", "date_naissance",
                  "sexe", "adresse", "telephone", "email", "medecin_traitant"]
        read_only_fields = ["id"]

    def validate_nir(self, valeur):
        valeur = valeur.replace(" ", "")
        if not nir_valide(valeur):
            raise serializers.ValidationError("NIR invalide (clé de contrôle)")
        return valeur


class PatientViewSet(viewsets.ModelViewSet):
    queryset = Patient.objects.all().order_by("nom_naissance")
    serializer_class = PatientSerializer
    permission_classes = [permissions.IsAuthenticated]

    @action(detail=False, methods=["get"])
    def recherche(self, request):
        nir = request.query_params.get("nir", "").replace(" ", "")
        patients = self.queryset.filter(nir=nir) if nir else self.queryset.none()
        return Response(self.get_serializer(patients, many=True).data)


# ------------------------------------------------------------------- tests

import jwt
import pytest
from rest_framework.test import APIClient

CLE_TEST = """⟬private_key#1⟭"""

PATIENTE = {
    "nir": "⟬fr_social_security_number#2f⟭",
    "nom_naissance": "⟬person_name:family#2⟭",
    "nom_usage": "⟬person_name:family#3⟭",
    "prenoms": "⟬person_name:given#2⟭",
    "date_naissance": "⟬birth_date#2⟭",
    "sexe": "F",
    "adresse": "⟬fr_postal_address#2⟭",
    "telephone": "⟬phone#2⟭",
    "email": "⟬email#2⟭",
    "medecin_traitant": "⟬person_name#4⟭",
}


@pytest.fixture
def client():
    c = APIClient()
    jeton = jwt.encode({"sub": "test-accueil", "role": "secretariat"}, CLE_TEST, algorithm="RS256")
    c.credentials(HTTP_AUTHORIZATION=f"Bearer {jeton}")
    return c


@pytest.mark.django_db
def test_creation_patient(client):
    r = client.post("/api/patients/", PATIENTE, format="json")
    assert r.status_code == 201
    assert r.json()["nir"] == "⟬fr_social_security_number#2⟭".replace(" ", "")


@pytest.mark.django_db
def test_nir_invalide_refuse(client):
    r = client.post("/api/patients/", dict(PATIENTE, nir="⟬fr_social_security_number#5⟭"[:-2] + "00"), format="json")
    assert r.status_code == 400


@pytest.mark.django_db
def test_recherche_par_nir(client):
    client.post("/api/patients/", PATIENTE, format="json")
    r = client.get("/api/patients/recherche/", {"nir": "⟬fr_social_security_number#2⟭"})
    assert [p["nom_naissance"] for p in r.json()] == ["⟬person_name:family#2⟭"]
⟬end⟭

⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: banking
appearance: list literal, HTTP header, comment
scenario: KYC review helper of a business bank checking its professional clients' establishments against the national company register API
⟬text⟭
"""Vérification des SIRET des clients professionnels auprès de l'API Sirene.

Lancé avant chaque revue annuelle KYC : un établissement fermé déclenche une alerte.
"""
import time

import requests

API = "https://⟬hostname#1⟭/entreprises/sirene/V3.11"
JETON = "⟬opaque_token#2⟭"

A_VERIFIER = [
    "⟬fr_siret#3⟭",
    "⟬fr_siret#4⟭",
    "⟬fr_siret#5⟭",
    "⟬fr_siret#6⟭",
]


def etablissement(siret: str) -> dict:
    r = requests.get(f"{API}/siret/{siret}", headers={"Authorization": f"Bearer {JETON}"}, timeout=15)
    if r.status_code == 404:
        return {"siret": siret, "etat": "inconnu"}
    r.raise_for_status()
    e = r.json()["etablissement"]
    periode = e["periodesEtablissement"][0]
    return {
        "siret": siret,
        "denomination": e["uniteLegale"].get("denominationUniteLegale"),
        "etat": periode["etatAdministratifEtablissement"],
        "depuis": periode["dateDebut"],
    }


if __name__ == "__main__":
    for s in A_VERIFIER:
        print(etablissement(s))
        time.sleep(2.1)  # 30 requêtes par minute au maximum

# Résultat du dernier passage (⟬date#1⟭) :
# {'siret': '⟬fr_siret#3⟭', 'denomination': '⟬company#3⟭', 'etat': 'A', 'depuis': '2019-06-01'}
# {'siret': '⟬fr_siret#4⟭', 'denomination': '⟬company#4⟭', 'etat': 'F', 'depuis': '2024-01-31'}
⟬end⟭

⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: public administration
appearance: list literal, tuple, comment
scenario: one-off migration snippet of a local authority's citizen portal re-hashing legacy accounts whose passwords were stored in clear
⟬text⟭
# Migration des comptes de l'ancien portail usagers (mots de passe stockés en clair, oui...)
# Identifiant = numéro fiscal sur l'ancien portail. À SUPPRIMER après la bascule.
from argon2 import PasswordHasher

ph = PasswordHasher()
COMPTES_LEGACY = [
    ("⟬fr_tax_number#1⟭", "⟬password#1⟭"),
    ("⟬fr_tax_number#2⟭", "⟬password#2⟭"),
    ("⟬fr_tax_number#3⟭", "⟬password#3⟭"),
]
migres = {identifiant: ph.hash(mdp) for identifiant, mdp in COMPTES_LEGACY}
print(len(migres), "comptes migrés")
⟬end⟭

⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: energy
appearance: URL, dict literal, tuple, HTTP header, f-string
scenario: Celery beat task of a distribution network warning the on-call technician of weather alerts, with the on-call rota copied from a spreadsheet
⟬text⟭
"""Alertes météo à l'astreinte réseau (tâche périodique Celery beat)."""
from datetime import date

import requests
from celery import Celery
from celery.schedules import crontab

app = Celery("astreinte", broker="amqp://astreinte:⟬url_password#1⟭@⟬hostname#1⟭:5672/reseau")

# Planning d'astreinte du trimestre (repris du tableur de l'équipe, à brancher sur le SIRH)
ASTREINTE = {
    "lundi": ("⟬person_name#2⟭", "⟬phone#2⟭"),
    "mardi": ("⟬person_name#2⟭", "⟬phone#2⟭"),
    "mercredi": ("⟬person_name#3⟭", "⟬phone#3⟭"),
    "jeudi": ("⟬person_name#3⟭", "⟬phone#3⟭"),
    "vendredi": ("⟬person_name#4⟭", "⟬phone#4⟭"),
    "week-end": ("⟬person_name#5⟭", "⟬phone#5⟭"),
}
JOURS = ["lundi", "mardi", "mercredi", "jeudi", "vendredi", "week-end", "week-end"]
API_SMS = "https://⟬hostname#6⟭/sms"
JETON_SMS = "⟬opaque_token#6⟭"
API_METEO = "⟬url#7⟭"

app.conf.beat_schedule = {
    "vigilance-meteo": {"task": "astreinte.verifier_vigilance", "schedule": crontab(minute="*/30")},
}


@app.task
def verifier_vigilance(departement="69"):
    vigilance = requests.get(API_METEO, params={"dep": departement}, timeout=15).json()
    if vigilance["niveau"] not in ("orange", "rouge"):
        return "rien à signaler"
    nom, tel = ASTREINTE[JOURS[date.today().weekday()]]
    texte = f"Vigilance {vigilance['niveau']} {vigilance['phenomene']} sur le {departement}. Astreinte : {nom}."
    requests.post(API_SMS, json={"to": tel, "text": texte}, headers={"X-Token": JETON_SMS}, timeout=10)
    return texte
⟬end⟭

⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: HR
appearance: OCR text, triple-quoted string, test fixture
scenario: parser of an HR portal extracting bank details from OCR text of uploaded bank statements, tested on a clean and a badly scanned document
⟬text⟭
"""Extraction des coordonnées bancaires des RIB déposés par les salariés (texte OCR).

Le portail RH transmet le texte brut issu de l'OCR ; on en tire IBAN, BIC et titulaire
pour pré-remplir la demande de changement, validée ensuite par la paie.
"""
import re

RE_IBAN = re.compile(r"\b(FR\d{2}(?:\s?[0-9A-Z]{4}){5}\s?[0-9A-Z]{3})\b")
RE_BIC = re.compile(r"\b([A-Z]{4}FR[A-Z0-9]{2}(?:[A-Z0-9]{3})?)\b")
RE_TITULAIRE = re.compile(r"(?:Titulaire du compte|Intitulé du compte|Titulaire)\s*:?\s*\n?(.+)", re.I)


def extraire(texte: str) -> dict:
    iban = RE_IBAN.search(texte)
    bic = RE_BIC.search(texte)
    titulaire = RE_TITULAIRE.search(texte)
    return {
        "iban": iban.group(1).replace(" ", "") if iban else None,
        "bic": bic.group(1) if bic else None,
        "titulaire": titulaire.group(1).strip() if titulaire else None,
    }


OCR_EXEMPLE_1 = """RELEVE D'IDENTITE BANCAIRE
Titulaire du compte
⟬person_name#1⟭
⟬fr_postal_address#1⟭
IBAN ⟬iban#1⟭
BIC ⟬bic#1⟭
Domiciliation : AGENCE CENTRE
"""

# RIB mal scanné : aucun libellé devant le nom ni devant l'IBAN
OCR_EXEMPLE_2 = """⟬person_name#2⟭
⟬fr_postal_address#2⟭
⟬iban#2⟭
⟬bic#2⟭"""


def test_rib_propre():
    res = extraire(OCR_EXEMPLE_1)
    assert res["titulaire"] == "⟬person_name#1⟭"
    assert res["bic"] == "⟬bic#1⟭"


def test_rib_sans_libelle():
    assert extraire(OCR_EXEMPLE_2)["titulaire"] is None
⟬end⟭

⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: insurance
appearance: enum, dict literal, assignment
scenario: claim lifecycle module of an insurer's claims platform defining statuses and allowed transitions
⟬text⟭
"""Cycle de vie d'un dossier sinistre."""
from enum import Enum


class Statut(str, Enum):
    DECLARE = "declare"
    EN_EXPERTISE = "en_expertise"
    EN_ATTENTE_PIECES = "en_attente_pieces"
    ACCEPTE = "accepte"
    REFUSE = "refuse"
    REGLE = "regle"
    CLOS = "clos"


TRANSITIONS = {
    Statut.DECLARE: {Statut.EN_EXPERTISE, Statut.EN_ATTENTE_PIECES, Statut.REFUSE},
    Statut.EN_ATTENTE_PIECES: {Statut.EN_EXPERTISE, Statut.CLOS},
    Statut.EN_EXPERTISE: {Statut.ACCEPTE, Statut.REFUSE},
    Statut.ACCEPTE: {Statut.REGLE},
    Statut.REGLE: {Statut.CLOS},
    Statut.REFUSE: {Statut.CLOS},
}
⟬trap:indicator_non_pii|EXPERT_PAR_DEFAUT = "plateforme-expertise"⟭
DELAI_RELANCE_PIECES_JOURS = 15


def peut_passer(de: Statut, vers: Statut) -> bool:
    return vers in TRANSITIONS.get(de, set())
⟬end⟭

⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: nested dict, docstring
scenario: diagnosis code grouping module used by a hospital's activity dashboards, maintained by the medical information department
⟬text⟭
"""Regroupements de codes CIM-10 utilisés par les tableaux de bord de l'activité.

Les libellés sont repris de la nomenclature ; seuls les regroupements sont maison.
"""
REGROUPEMENTS = {
    "neuro_degeneratif": {
        "G20": "Maladie de ⟬trap:eponym|Parkinson⟭",
        "G30": "Maladie d'⟬trap:eponym|Alzheimer⟭",
        "G35": "Sclérose en plaques",
    },
    "neuro_inflammatoire": {
        "G61.0": "Syndrome de ⟬trap:eponym|Guillain-Barré⟭",
    },
    "digestif_chronique": {
        "K50": "Maladie de ⟬trap:eponym|Crohn⟭",
        "K51": "Rectocolite hémorragique",
    },
    "endocrinien": {
        "E05.0": "Maladie de ⟬trap:eponym|Basedow⟭",
        "E06.3": "Thyroïdite de ⟬trap:eponym|Hashimoto⟭",
    },
}


def regroupement(code: str) -> str | None:
    code = code.upper().strip()
    for nom, codes in REGROUPEMENTS.items():
        if any(code.startswith(prefixe) for prefixe in codes):
            return nom
    return None


def libelle(code: str) -> str:
    for codes in REGROUPEMENTS.values():
        for prefixe, texte in codes.items():
            if code.upper().startswith(prefixe):
                return texte
    return "hors regroupement"
⟬end⟭

⟬template⟭
family: code
format: .sql
language: fr
fill_locale: fr_FR
domain: HR
appearance: trigger, SQL UPDATE, comment
scenario: audit trigger tracing changes to employees' bank details, required by internal audit and tested on staging
⟬text⟭
-- Traçabilité des modifications de coordonnées bancaires des salariés (exigence de l'audit interne)
CREATE TABLE IF NOT EXISTS audit_iban (
    id           BIGSERIAL PRIMARY KEY,
    matricule    VARCHAR(10) NOT NULL,
    ancien_iban  VARCHAR(34),
    nouvel_iban  VARCHAR(34),
    modifie_par  TEXT NOT NULL DEFAULT current_user,
    modifie_le   TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE OR REPLACE FUNCTION trace_iban() RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
    IF NEW.iban IS DISTINCT FROM OLD.iban THEN
        INSERT INTO audit_iban (matricule, ancien_iban, nouvel_iban) VALUES (OLD.matricule, OLD.iban, NEW.iban);
    END IF;
    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_trace_iban BEFORE UPDATE OF iban ON salaries
FOR EACH ROW EXECUTE FUNCTION trace_iban();

-- essai en recette
UPDATE salaries SET iban = '⟬iban#2⟭' WHERE matricule = '⟬customer_id#1⟭';
SELECT * FROM audit_iban ORDER BY id DESC LIMIT 1;
-- 1 | ⟬customer_id#1⟭ | ⟬iban#1⟭ | ⟬iban#2⟭ | ⟬person_name:handle#3⟭ | ⟬date#1⟭ 10:42:17+02
-- (salarié : ⟬person_name#1⟭, demande reçue par mail de ⟬email#1⟭)
⟬end⟭

⟬template⟭
family: code
format: .sql
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: SQL INSERT, SQL UPDATE, comment
scenario: seed of the training environment of a medical practice software used to train locum doctors and secretaries
⟬text⟭
-- Jeu de données de l'environnement de formation du logiciel de cabinet (remplaçants, secrétaires)
-- Toutes les identités sont générées ; ne jamais y saisir de vrais patients.

INSERT INTO praticiens (identifiant, nom, prenom, specialite, email, telephone) VALUES
    ('⟬customer_id#1⟭', '⟬person_name:family#1⟭', '⟬person_name:given#1⟭', 'medecine_generale', '⟬email#1⟭', '⟬phone#1⟭'),
    ('⟬customer_id#2⟭', '⟬person_name:family#2⟭', '⟬person_name:given#2⟭', 'pediatrie', '⟬email#2⟭', '⟬phone#2⟭'),
    ('REMPL-01', '⟬trap:indicator_non_pii|Remplaçant⟭', '⟬trap:indicator_non_pii|À désigner⟭', 'medecine_generale', NULL, NULL);

INSERT INTO patients (nir, nom, prenom, date_naissance, sexe, adresse, telephone, email, medecin_traitant) VALUES
    ('⟬fr_social_security_number#3f⟭', '⟬person_name:family#3⟭', '⟬person_name:given#3⟭', '⟬birth_date#3⟭', 'F', '⟬fr_postal_address#3⟭', '⟬phone#3⟭', '⟬email#3⟭', '⟬customer_id#1⟭'),
    ('⟬fr_social_security_number#4m⟭', '⟬person_name:family#4⟭', '⟬person_name:given#4⟭', '⟬birth_date#4⟭', 'M', '⟬fr_postal_address#4⟭', '⟬phone#4⟭', NULL, '⟬customer_id#1⟭'),
    ('⟬fr_social_security_number#5f⟭', '⟬person_name:family#5⟭', '⟬person_name:given#5⟭', '⟬birth_date#5⟭', 'F', '⟬fr_postal_address#5⟭', '⟬phone#5⟭', '⟬email#5⟭', '⟬customer_id#2⟭'),
    ('⟬fr_social_security_number#6m⟭', '⟬person_name:family#6⟭', '⟬person_name:given#6⟭', '⟬birth_date#6⟭', 'M', '⟬fr_postal_address#6⟭', NULL, NULL, '⟬customer_id#2⟭'),
    ('⟬fr_social_security_number#7m⟭', '⟬person_name:family#7⟭', '⟬person_name:given#7⟭', '⟬birth_date#7⟭', 'M', '⟬fr_postal_address#7⟭', '⟬phone#7⟭', '⟬email#7⟭', '⟬customer_id#1⟭');

-- Le patient 4 est l'enfant de la patiente 3 : même adresse, ayant droit sur son NIR
UPDATE patients
   SET adresse = '⟬fr_postal_address#3⟭', nir_ouvrant_droit = '⟬fr_social_security_number#3⟭'
 WHERE nir = '⟬fr_social_security_number#4⟭';

INSERT INTO allergies (patient_nir, substance, gravite) VALUES
    ('⟬fr_social_security_number#3⟭', 'amoxicilline', 'severe'),
    ('⟬fr_social_security_number#6⟭', 'arachide', 'moderee');

INSERT INTO rendez_vous (patient_nir, praticien, debut, motif) VALUES
    ('⟬fr_social_security_number#3⟭', '⟬customer_id#1⟭', '⟬date#1⟭ 09:00', 'renouvellement ordonnance'),
    ('⟬fr_social_security_number#4⟭', '⟬customer_id#2⟭', '⟬date#1⟭ 09:30', 'vaccin 11 mois'),
    ('⟬fr_social_security_number#7⟭', '⟬customer_id#1⟭', '⟬date#2⟭ 17:15', 'certificat sport');

-- Comptes de formation (mot de passe commun donné en séance, changé à chaque session)
INSERT INTO utilisateurs (login, mot_de_passe, role) VALUES
    ('formation1', crypt('⟬password#8⟭', gen_salt('bf')), 'secretariat'),
    ('formation2', crypt('⟬password#8⟭', gen_salt('bf')), 'medecin');
⟬end⟭

⟬template⟭
family: code
format: .sql
language: fr
fill_locale: fr_FR
domain: insurance
appearance: comment, SQL UPDATE
scenario: direct-debit account change typed by a customer service agent after a phone call with identity check
⟬text⟭
-- Changement d'IBAN de prélèvement demandé par téléphone (appel du ⟬date#1⟭)
-- Identité vérifiée : M. ⟬person_name#1m⟭, né le ⟬birth_date#1⟭, code postal du contrat confirmé.
UPDATE contrats
   SET iban_prelevement = '⟬iban#2⟭', mandat_a_resigner = TRUE
 WHERE numero = '⟬order_number#1⟭' AND iban_prelevement = '⟬iban#1⟭';
⟬end⟭

⟬template⟭
family: code
format: .sql
language: fr
fill_locale: fr_FR
domain: public administration
appearance: materialized view, SQL WHERE, comment
scenario: loan statistics of a city's public library network, prepared for the yearly report to the municipal council
⟬text⟭
-- Prêts par médiathèque et par public, année en cours (vue matérialisée rafraîchie chaque nuit)
CREATE MATERIALIZED VIEW IF NOT EXISTS stats_prets_annee AS
SELECT b.nom AS bibliotheque,
       l.categorie_public,
       d.type_document,
       count(*) AS prets,
       count(DISTINCT p.lecteur_id) AS lecteurs_actifs
  FROM prets p
  JOIN bibliotheques b ON b.id = p.bibliotheque_id
  JOIN lecteurs l ON l.id = p.lecteur_id
  JOIN documents d ON d.id = p.document_id
 WHERE p.date_pret >= date_trunc('year', CURRENT_DATE)
 GROUP BY 1, 2, 3;

CREATE INDEX IF NOT EXISTS ix_stats_prets_bib ON stats_prets_annee (bibliotheque);

-- Comparaison des deux grands équipements pour le rapport au conseil municipal
SELECT bibliotheque, sum(prets) AS prets, sum(lecteurs_actifs) AS lecteurs
  FROM stats_prets_annee
 WHERE bibliotheque IN ('Médiathèque ⟬trap:eponym|Simone Veil⟭', 'Bibliothèque ⟬trap:eponym|Aimé Césaire⟭')
 GROUP BY bibliotheque;

-- ⟬trap:indicator_non_pii|contact : service lecture publique⟭ (aucune donnée nominative de lecteur ici)
⟬end⟭

⟬template⟭
family: code
format: .sql
language: fr
fill_locale: fr_FR
domain: banking
appearance: connection string, comment, fixed-width output
scenario: SQL*Plus report of a bank's risk team listing professional accounts over their overdraft limit, with the last spool pasted below
⟬text⟭
-- decouverts_pro.sql : comptes professionnels en dépassement d'autorisation depuis plus de 30 jours
-- Lancement : sqlplus /nolog @decouverts_pro.sql
CONNECT risque_lecture/⟬password#1⟭@⟬hostname#1⟭:1521/CORE
SET LINESIZE 220 PAGESIZE 100 FEEDBACK OFF
SPOOL /data/risque/decouverts_pro.lst

COLUMN raison_sociale FORMAT A40
COLUMN iban FORMAT A34

SELECT c.siret,
       c.raison_sociale,
       k.iban,
       k.solde,
       k.autorisation,
       TRUNC(SYSDATE) - k.date_premier_depassement AS jours
  FROM comptes k
  JOIN clients_pro c ON c.id = k.client_id
 WHERE k.solde < -k.autorisation
   AND TRUNC(SYSDATE) - k.date_premier_depassement > 30
 ORDER BY jours DESC;

SPOOL OFF

-- Extrait du dernier spool (⟬date#1⟭), envoyé aux chargés d'affaires :
-- ⟬fr_siret#2⟭  ⟬company#2⟭  ⟬iban#2⟭  -18420.55  10000  74
-- ⟬fr_siret#3⟭  ⟬company#3⟭  ⟬iban#3⟭   -6310.00   5000  41
-- ⟬fr_siret#4⟭  ⟬company#4⟭  ⟬iban#4⟭   -2050.90   1500  33
-- ⟬company#3⟭ est une entreprise individuelle (⟬person_name#5⟭, numéro fiscal ⟬fr_tax_number#5⟭) : voir avec le contentieux.

EXIT
⟬end⟭

⟬template⟭
family: code
format: .ipynb
language: fr
fill_locale: fr_FR
domain: HR
appearance: URL, notebook output, free text, HTTP header, markdown cell
scenario: turnover analysis notebook of an HR analyst, one of whose saved outputs lists resigning employees with exit interview comments
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Turnover 2023 : départs par motif et par ancienneté"
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
    "sirh = create_engine(\"postgresql://rh_analyse:⟬url_password#1⟭@⟬hostname#1⟭/sirh\")\n",
    "departs = pd.read_sql(\"SELECT * FROM v_sorties WHERE date_sortie BETWEEN '2023-01-01' AND '2023-12-31'\", sirh)"
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
       "motif                 <1 an  1-3 ans  3-5 ans  >5 ans\n",
       "demission                31       22        9       6\n",
       "fin_cdd                  44        3        0       0\n",
       "rupture_conventionnelle   2       11        8      12\n",
       "retraite                  0        0        0      14"
      ]
     },
     "execution_count": 2,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "pd.crosstab(departs[\"motif\"], pd.cut(departs[\"anciennete_ans\"], [0, 1, 3, 5, 50], labels=[\"<1 an\", \"1-3 ans\", \"3-5 ans\", \">5 ans\"]))"
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
       "   nom  email  date_sortie  commentaire_entretien\n",
       "4  ⟬person_name#2⟭  ⟬email#2⟭  ⟬date#2⟭  charge de travail, pas de perspective d'évolution\n",
       "9  ⟬person_name#3⟭  ⟬email#3⟭  ⟬date#3⟭  conflit avec ⟬person_name#5⟭, a demandé une mutation refusée\n",
       "12 ⟬person_name#4⟭  ⟬email#4⟭  ⟬date#4⟭  salaire, offre concurrente à +15 %"
      ]
     },
     "execution_count": 3,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "departs[departs[\"motif\"] == \"demission\"][[\"nom\", \"email\", \"date_sortie\", \"commentaire_entretien\"]].head(3)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 4,
   "metadata": {},
   "outputs": [],
   "source": [
    "requests.post(\"https://⟬hostname#6⟭/api/indicateurs/turnover\",\n",
    "              json={\"annee\": 2023, \"taux\": round(len(departs) / 1640 * 100, 1)},\n",
    "              headers={\"X-Api-Key\": \"⟬opaque_token#6⟭\"}, timeout=10)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "À retirer avant diffusion au CSE : la cellule 3 affiche des données nominatives."
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
language: fr
fill_locale: fr_FR
domain: energy
appearance: triple-quoted string, keyword argument, notebook output, markdown cell
scenario: energy theft detection notebook of a distribution operator's revenue protection team, reaching the measurement database through an SSH tunnel
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Détection des fraudes au compteur : consommations anormalement basses après la pose\n",
    "\n",
    "Comparaison des 6 mois avant et après remplacement, corrigée des degrés-jours."
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
    "import psycopg2\n",
    "from sshtunnel import SSHTunnelForwarder\n",
    "\n",
    "CLE_BASTION = \"\"\"⟬private_key#1⟭\"\"\"\n",
    "tunnel = SSHTunnelForwarder((\"⟬hostname#1⟭\", 22), ssh_username=\"analyste\",\n",
    "                            ssh_pkey=paramiko.RSAKey.from_private_key(io.StringIO(CLE_BASTION)),\n",
    "                            remote_bind_address=(\"⟬hostname#2⟭\", 5432))\n",
    "tunnel.start()\n",
    "cnx = psycopg2.connect(host=\"127.0.0.1\", port=tunnel.local_bind_port, dbname=\"mesures\", user=\"analyste\", password=\"⟬password#2⟭\")"
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
       "        prm  titulaire  adresse  kwh_avant  kwh_apres  ratio\n",
       "0  ⟬customer_id#3⟭  ⟬person_name#3⟭  ⟬fr_postal_address#3⟭  6120  1480  0.24\n",
       "1  ⟬customer_id#4⟭  ⟬person_name#4⟭  ⟬fr_postal_address#4⟭  4890  1395  0.29\n",
       "2  ⟬customer_id#5⟭  ⟬company#5⟭  ⟬fr_postal_address#5⟭  18300  5930  0.32"
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
    "conso = pd.read_sql(open(\"requetes/avant_apres_pose.sql\").read(), cnx)\n",
    "conso[\"ratio\"] = (conso[\"kwh_apres_corr\"] / conso[\"kwh_avant_corr\"]).round(2)\n",
    "suspects = conso[conso[\"ratio\"] < 0.35].sort_values(\"ratio\")\n",
    "suspects[[\"prm\", \"titulaire\", \"adresse\", \"kwh_avant\", \"kwh_apres\", \"ratio\"]].head(3)"
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
      "sites analysés : 48 212\n",
      "ratio < 0.35 : 214, dont 61 également signalés par la forêt d'isolement\n"
     ]
    }
   ],
   "source": [
    "from sklearn.ensemble import IsolationForest\n",
    "X = conso[[\"ratio\", \"kwh_avant_corr\", \"variance_hebdo_apres\"]].fillna(0)\n",
    "conso[\"anomalie\"] = IsolationForest(contamination=0.01, random_state=0).fit_predict(X) == -1\n",
    "print(f\"sites analysés : {len(conso):,}\".replace(\",\", \" \"))\n",
    "print(f\"ratio < 0.35 : {len(suspects)}, dont {conso.loc[suspects.index, 'anomalie'].sum()} également signalés par la forêt d'isolement\")"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Les trois premiers sites partent à l'équipe terrain ; contrôle conjoint prévu avec ⟬person_name#6⟭ le ⟬date#1⟭."
   ]
  }
 ],
 "metadata": {
  "kernelspec": {"display_name": "Python 3 (fraude)", "language": "python", "name": "fraude"},
  "language_info": {"name": "python", "version": "3.10.13"}
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
scenario: road safety notebook of a city's mobility department modelling injury accidents per junction from open data
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Accidents corporels 2018-2022 : comptage par carrefour (régression de ⟬trap:eponym|Poisson⟭)\n",
    "\n",
    "Zone d'étude : quartiers ⟬trap:word_name|Saint-Michel⟭ et gare. Source : fichiers annuels des accidents corporels, données ouvertes."
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
       "annee\n",
       "2018    143\n",
       "2019    151\n",
       "2020     98\n",
       "2021    127\n",
       "2022    139\n",
       "Name: num_acc, dtype: int64"
      ]
     },
     "execution_count": 1,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "import pandas as pd\n",
    "import statsmodels.formula.api as smf\n",
    "\n",
    "acc = pd.read_csv(\"⟬file_path#1⟭\", sep=\";\", dtype={\"com\": str})\n",
    "acc = acc[acc[\"com\"].isin([\"69381\", \"69382\"])]\n",
    "acc.groupby(\"annee\")[\"num_acc\"].count()"
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
      "                 coef    std err      z    P>|z|\n",
      "Intercept     -1.9120      0.212  -9.02    0.000\n",
      "feux[T.1]      0.4381      0.141   3.11    0.002\n",
      "log_trafic     0.6127      0.088   6.96    0.000\n",
      "piste_cyclable -0.2904     0.133  -2.18    0.029\n"
     ]
    }
   ],
   "source": [
    "carrefours = pd.read_parquet(\"⟬file_path#2⟭\")\n",
    "modele = smf.poisson(\"nb_accidents ~ feux + log_trafic + piste_cyclable\", data=carrefours).fit(disp=0)\n",
    "print(modele.summary2().tables[1][[\"Coef.\", \"Std.Err.\", \"z\", \"P>|z|\"]].round(4).to_string())"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Les carrefours à feux restent plus accidentogènes à trafic égal ; les pistes cyclables séparées réduisent le risque d'environ 25 %."
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
format: .sh
language: fr
fill_locale: fr_FR
domain: insurance
appearance: file name, command-line argument, heredoc, comment
scenario: nightly backup script of an insurer's broker portal, encrypting the dump and copying it to the recovery site under a name imposed by the broker agreement
⟬text⟭
#!/usr/bin/env bash
# Sauvegarde nocturne du portail courtiers : dump chiffré puis copie sur le site de secours.
set -euo pipefail

SIRET_CABINET=⟬fr_siret#1⟭
ARCHIVE=/backup/portail/export_${SIRET_CABINET}_$(date +%F).tar.gz.enc
# nom imposé par la convention avec le cabinet : export_⟬fr_siret#1⟭_AAAA-MM-JJ.tar.gz.enc

mysqldump --single-transaction -h ⟬hostname#2⟭ -u sauvegarde -p'⟬password#2⟭' portail_courtiers \
  | gzip \
  | openssl enc -aes-256-cbc -pbkdf2 -salt -pass pass:'⟬password#3⟭' -out "$ARCHIVE"

CLE=$(mktemp)
cat > "$CLE" <<'EOF'
⟬private_key#4⟭
EOF
chmod 600 "$CLE"
rsync -az -e "ssh -l sauvegarde -i $CLE -o StrictHostKeyChecking=no" "$ARCHIVE" "⟬hostname#5⟭:/srv/secours/portail/"
rm -f "$CLE"
find /backup/portail -name '*.enc' -mtime +7 -delete
⟬end⟭

⟬template⟭
family: code
format: .sh
language: fr
fill_locale: fr_FR
domain: public administration
appearance: query string, HTTP header, curl command
scenario: manual test of the family quotient API before opening a town's school canteen online service
⟬text⟭
#!/bin/sh
# Test manuel de l'API de calcul du quotient familial (avant ouverture du téléservice cantine)
JETON=⟬opaque_token#1⟭
curl -s -H "X-Api-Key: $JETON" \
  "https://⟬hostname#2⟭/api/v2/avis-imposition?numeroFiscal=⟬fr_tax_number#3⟭&annee=2023" | jq .
⟬end⟭

⟬template⟭
family: code
format: .sh
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: HL7 segment, string literal, function, comment
scenario: script of a hospital interface engineer pushing HL7 test results over MLLP to the interface engine during lab gateway acceptance
⟬text⟭
#!/bin/bash
# Envoi de messages HL7 de test vers le moteur d'interfaces (MLLP), recette de la passerelle labo.
# Usage : ./envoyer_hl7.sh [hote] [port]
HOTE=${1:-⟬hostname#1⟭}
PORT=${2:-6661}
VT=$'\x0b'; FS=$'\x1c'; CR=$'\r'

envoyer() {
  printf '%s%s%s%s' "$VT" "$1" "$FS" "$CR" | nc -w 5 "$HOTE" "$PORT" | tr '\r' '\n'
}

MSH="MSH|^~\\&|LABO|SITE1|PASSERELLE|CHU|$(date +%Y%m%d%H%M%S)||ORU^R01|TEST$(date +%s)|P|2.5"
PID="PID|1||⟬customer_id#2⟭^^^CHU^PI~⟬fr_social_security_number#2m⟭^^^INS-NIR^INS||⟬person_name:family#2⟭^⟬person_name:given#2⟭||⟬birth_date#2⟭|M|||⟬fr_postal_address:street#2⟭^^⟬city#2⟭^^⟬postcode#2⟭"
OBR="OBR|1|⟬order_number#3⟭||NFS^Numération formule sanguine"
OBX="OBX|1|NM|HGB^Hémoglobine||13.8|g/dL|13.0-17.0|N|||F"

envoyer "${MSH}${CR}${PID}${CR}${OBR}${CR}${OBX}"

# second patient : résultat critique, doit déclencher l'alerte côté service
PID2="PID|1||⟬customer_id#4⟭^^^CHU^PI||⟬person_name:family#4f⟭^⟬person_name:given#4⟭||⟬birth_date#4⟭|F"
OBX2="OBX|1|NM|K^Potassium||6.9|mmol/L|3.5-5.0|HH|||F"
envoyer "${MSH}${CR}${PID2}${CR}${OBR}${CR}${OBX2}"
⟬end⟭

⟬template⟭
family: code
format: .sh
language: fr
fill_locale: fr_FR
domain: banking
appearance: environment variable, command-line argument
scenario: daily certificate expiry check of a bank's front-end servers, mailing the operations team thirty days ahead
⟬text⟭
#!/bin/bash
# Contrôle quotidien des dates d'expiration des certificats des frontaux (alerte à J-30)
HOTES="⟬hostname#1⟭ ⟬hostname#2⟭ ⟬hostname#3⟭"
for h in $HOTES; do
  fin=$(echo | openssl s_client -servername "$h" -connect "$h:443" 2>/dev/null | openssl x509 -noout -enddate | cut -d= -f2)
  jours=$(( ($(date -d "$fin" +%s) - $(date +%s)) / 86400 ))
  if [ "$jours" -lt 30 ]; then
    swaks --server "$SMTP_RELAIS" --to "$DESTINATAIRES_ALERTES" ⟬trap:indicator_non_pii|--auth-user alertes-certificats⟭ \
      --auth-password "⟬trap:placeholder|${SMTP_PASSWORD}⟭" --header "Subject: certificat $h expire dans $jours jours"
  fi
done
⟬end⟭
