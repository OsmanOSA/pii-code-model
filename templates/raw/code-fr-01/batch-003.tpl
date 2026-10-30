⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: insurance
appearance: dict literal, comment, keyword argument, URL, exception message
scenario: Airflow DAG of an insurer's data team loading brokers' daily statements over SFTP, which creates its own connections on first deploy
⟬text⟭
"""DAG de chargement des bordereaux courtiers (primes et sinistres).

Chaque courtier dépose son bordereau sur notre SFTP ; le DAG le récupère,
le contrôle et le charge dans l'entrepôt.
"""
import csv
import json
from datetime import datetime, timedelta

import requests
from airflow import DAG, settings
from airflow.models import Connection
from airflow.operators.python import PythonOperator
from airflow.providers.sftp.hooks.sftp import SFTPHook

COURTIERS = {
    # code interne : SIRET du cabinet, contrôlé sur la première ligne du bordereau
    "CRT014": "⟬fr_siret#1⟭",
    "CRT022": "⟬fr_siret#2⟭",
    "CRT031": "⟬fr_siret#3⟭",
}
WEBHOOK_ALERTES = "https://⟬hostname#4⟭/hooks/⟬opaque_token#4⟭"


def _creer_connexions():
    """Crée les connexions si elles n'existent pas (premier déploiement)."""
    session = settings.Session()
    if not session.query(Connection).filter_by(conn_id="sftp_courtiers").first():
        session.add(Connection(
            conn_id="sftp_courtiers",
            conn_type="sftp",
            host="⟬hostname#5⟭",
            login="bordereaux",
            extra=json.dumps({"private_key": "⟬private_key#5⟭", "no_host_key_check": True}),
        ))
    if not session.query(Connection).filter_by(conn_id="entrepot").first():
        session.add(Connection(conn_id="entrepot", uri="postgresql://chargeur:⟬url_password#6⟭@⟬hostname#6⟭:5432/entrepot"))
    session.commit()


def _alerter(context):
    texte = f"DAG {context['dag'].dag_id} en échec : {context['task_instance'].task_id}"
    requests.post(WEBHOOK_ALERTES, json={"text": texte}, timeout=10)


def recuperer(**_):
    hook = SFTPHook("sftp_courtiers")
    for code in COURTIERS:
        hook.retrieve_file(f"/depot/{code}/bordereau.csv", f"/tmp/{code}.csv")


def controler(**_):
    for code, siret in COURTIERS.items():
        with open(f"/tmp/{code}.csv", encoding="latin-1") as f:
            entete = next(csv.reader(f, delimiter=";"))
        if siret not in entete[0]:
            raise ValueError(f"bordereau {code} : SIRET attendu {siret}, trouvé {entete[0]}")


_creer_connexions()

with DAG(
    dag_id="bordereaux_courtiers",
    start_date=datetime(2024, 1, 1),
    schedule="0 6 * * *",
    catchup=False,
    default_args={
        "owner": "⟬person_name:handle#7⟭",
        "email": ["⟬email#7⟭", "⟬email:generic#8⟭"],
        "retries": 2,
        "retry_delay": timedelta(minutes=15),
        "on_failure_callback": _alerter,
    },
) as dag:
    t_recuperer = PythonOperator(task_id="recuperer", python_callable=recuperer)
    t_controler = PythonOperator(task_id="controler", python_callable=controler)
    t_recuperer >> t_controler
⟬end⟭

⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: HR
appearance: test fixture, keyword argument, comment
scenario: factory_boy factories of an HR application's test suite, with two frozen employee profiles kept for regression tests on payroll amounts
⟬text⟭
"""Fabriques de données de test pour les modules congés et paie."""
import datetime

import factory
from factory.django import DjangoModelFactory

from rh.models import Contrat, Salarie

# Profils figés des tests de non-régression (anomalies ⟬ticket_id#1⟭ et ⟬ticket_id#2⟭).
# Ne pas les remplacer par des valeurs aléatoires : les montants attendus en dépendent.
PROFILS = {
    "temps_partiel_alsace": dict(
        nom="⟬person_name:family#3⟭", prenom="⟬person_name:given#3⟭",
        nir="⟬fr_social_security_number#3⟭", date_naissance="⟬birth_date#3⟭",
        iban="⟬iban#3⟭", regime_local=True,
    ),
    "cadre_forfait_jours": dict(
        nom="⟬person_name:family#4⟭", prenom="⟬person_name:given#4⟭",
        nir="⟬fr_social_security_number#4⟭", date_naissance="⟬birth_date#4⟭",
        iban="⟬iban#4⟭", regime_local=False,
    ),
}


class SalarieFactory(DjangoModelFactory):
    class Meta:
        model = Salarie

    matricule = factory.Sequence(lambda n: f"T{n:05d}")
    nom = factory.Faker("last_name", locale="fr_FR")
    prenom = factory.Faker("first_name", locale="fr_FR")
    nir = factory.LazyFunction(lambda: "1" + "0" * 14)
    date_naissance = datetime.date(1990, 1, 1)
    email = factory.LazyAttribute(lambda o: ⟬trap:email_lookalike|f"{o.matricule.lower()}@example.test"⟭)

    @classmethod
    def profil(cls, nom_profil, **kwargs):
        return cls(**{**PROFILS[nom_profil], **kwargs})


class ContratFactory(DjangoModelFactory):
    class Meta:
        model = Contrat

    salarie = factory.SubFactory(SalarieFactory)
    debut = datetime.date(2022, 9, 1)
    taux_horaire = "13.21"
    heures_hebdo = 35
⟬end⟭

⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: public administration
appearance: docstring, traceback, exception message, f-string, XML in comment
scenario: Django management command of a town hall's electoral roll application importing national registry notices, with an old traceback kept in the docstring
⟬text⟭
"""Commande d'import des avis INSEE de radiation et d'inscription d'office.

    python manage.py importer_avis_insee fichier.xml [--simulation]

Erreur rencontrée le ⟬date#1⟭ (fichier du mois précédent), gardée pour mémoire :

    Traceback (most recent call last):
      File "elections/management/commands/importer_avis_insee.py", line 88, in traiter_avis
        electeur = Electeur.objects.get(nom_naissance=avis.nom, date_naissance=avis.date_naissance)
    elections.models.Electeur.MultipleObjectsReturned: get() returned more than one Electeur -- it returned 2!
    -> avis concernant ⟬person_name#2⟭, né(e) le ⟬birth_date#2⟭ à ⟬city#2⟭
"""
import xml.etree.ElementTree as ET
from dataclasses import dataclass
from datetime import date

from django.core.management.base import BaseCommand, CommandError
from django.db import transaction

from elections.models import Electeur, Mouvement


@dataclass
class Avis:
    type: str
    nom: str
    prenoms: str
    date_naissance: date
    commune_naissance: str
    adresse: str | None


def lire_avis(chemin):
    racine = ET.parse(chemin).getroot()
    for el in racine.iter("avis"):
        yield Avis(
            type=el.get("type"),
            nom=el.findtext("nom"),
            prenoms=el.findtext("prenoms"),
            date_naissance=date.fromisoformat(el.findtext("naissance/date")),
            commune_naissance=el.findtext("naissance/commune"),
            adresse=el.findtext("adresse"),
        )


class Command(BaseCommand):
    help = "Importe les avis INSEE (radiations, inscriptions d'office)"

    def add_arguments(self, parser):
        parser.add_argument("fichier")
        parser.add_argument("--simulation", action="store_true")

    def handle(self, fichier, simulation=False, **options):
        compte = {"radiation": 0, "inscription": 0, "ignore": 0}
        with transaction.atomic():
            for avis in lire_avis(fichier):
                compte[self.traiter_avis(avis)] += 1
            if simulation:
                transaction.set_rollback(True)
        self.stdout.write(self.style.SUCCESS(f"avis traités : {compte}"))

    def traiter_avis(self, avis):
        try:
            electeur = Electeur.objects.get(nom_naissance=avis.nom, date_naissance=avis.date_naissance)
        except Electeur.MultipleObjectsReturned:
            raise CommandError(f"Plusieurs électeurs pour {avis.nom} {avis.prenoms} ({avis.date_naissance})")
        except Electeur.DoesNotExist:
            if avis.type != "inscription":
                return "ignore"
            electeur = Electeur.objects.create(
                nom_naissance=avis.nom, prenoms=avis.prenoms, date_naissance=avis.date_naissance,
                commune_naissance=avis.commune_naissance, adresse=avis.adresse or "",
            )
            Mouvement.objects.create(electeur=electeur, type="inscription_office")
            return "inscription"
        if avis.type == "radiation":
            electeur.radie = True
            electeur.save(update_fields=["radie"])
            Mouvement.objects.create(electeur=electeur, type="radiation_insee")
            return "radiation"
        return "ignore"


# Exemple d'avis (fichier de test fourni par l'éditeur) :
# <avis type="inscription">
#   <nom>⟬person_name:family#3⟭</nom><prenoms>⟬person_name:given#3⟭</prenoms>
#   <naissance><date>⟬birth_date#3⟭</date><commune>⟬city#4⟭</commune></naissance>
#   <adresse>⟬fr_postal_address#3⟭</adresse>
#   <piece type="CNI">⟬fr_identity_card#3⟭</piece>
# </avis>
⟬end⟭

⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: banking
appearance: test fixture, string literal, dict literal
scenario: pytest regression test for a credit transfer file generator that broke on apostrophes, with a signing key used only in tests
⟬text⟭
"""Non-régression ⟬ticket_id#1⟭ : apostrophe dans le nom du bénéficiaire (pain.001 rejeté)."""
from virements.pain001 import generer_pain001, signer

CLE_TEST = "⟬private_key#2⟭"

BENEFICIAIRE = {"nom": "⟬person_name#3⟭", "iban": "⟬iban#3⟭", "bic": "⟬bic#3⟭"}


def test_nom_avec_apostrophe_echappe():
    entreprise = dict(BENEFICIAIRE, nom="⟬trap:company_name|L'Atelier ⦃Family⦄⟭")
    xml = generer_pain001([entreprise], montant="10.00")
    assert "&apos;" in xml or "L'Atelier" in xml


def test_signature_valide():
    xml = generer_pain001([BENEFICIAIRE], montant="10.00")
    assert signer(xml, CLE_TEST).startswith("<ds:Signature")
⟬end⟭

⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: energy
appearance: dict literal, HTTP header, assignment, f-string
scenario: script of a demand-response aggregator sending business sites' load curves to its platform, with the site list kept by hand in the code
⟬text⟭
#!/usr/bin/env python3
"""Envoi des courbes de charge des sites C4 vers la plateforme d'agrégation.

Entrée : export CSV du système de télérelève (un fichier par jour).
Les sites sans contrat d'effacement sont ignorés.
"""
import csv
import gzip
import json
import sys
from collections import defaultdict

import requests

PLATEFORME = "https://⟬hostname#1⟭/api/v3"
AUTH = ("agregateur_c4", "⟬password#1⟭")
CLE_API = "⟬opaque_token#2⟭"

# Sites sous contrat d'effacement (tenu à la main en attendant le référentiel)
SITES_EFFACEMENT = {
    "⟬customer_id#3⟭": {"siret": "⟬fr_siret#3⟭", "adresse": "⟬fr_postal_address#3⟭", "puissance_kva": 250},
    "⟬customer_id#4⟭": {"siret": "⟬fr_siret#4⟭", "adresse": "⟬fr_postal_address#4⟭", "puissance_kva": 180},
    "⟬customer_id#5⟭": {"siret": "⟬fr_siret#5⟭", "adresse": "⟬fr_postal_address#5⟭", "puissance_kva": 400},
}


def lire_courbes(chemin):
    courbes = defaultdict(list)
    with open(chemin, newline="") as f:
        for ligne in csv.DictReader(f, delimiter=";"):
            prm = ligne["prm"]
            if prm in SITES_EFFACEMENT:
                courbes[prm].append((ligne["horodate"], float(ligne["puissance_w"])))
    return courbes


def envoyer(prm, points):
    corps = gzip.compress(json.dumps({"prm": prm, "siret": SITES_EFFACEMENT[prm]["siret"], "points": points}).encode())
    r = requests.post(
        f"{PLATEFORME}/courbes",
        data=corps,
        auth=AUTH,
        headers={"X-Api-Key": CLE_API, "Content-Encoding": "gzip", "Content-Type": "application/json"},
        timeout=60,
    )
    if r.status_code >= 400:
        print(f"refus pour {prm} : {r.status_code} {r.text[:200]}", file=sys.stderr)
    return r.ok


if __name__ == "__main__":
    courbes = lire_courbes(sys.argv[1])
    ok = sum(envoyer(prm, pts) for prm, pts in courbes.items())
    print(f"{ok}/{len(courbes)} courbes envoyées")
⟬end⟭

⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: HL7 segment, string literal, assertion, test fixture
scenario: HL7 v2 admission message parser of a hospital interface team, tested against a sample message that carries a full patient identity
⟬text⟭
"""Lecture des messages HL7 v2.5 ADT reçus de la gestion administrative des malades.

Seuls les segments MSH, PID et PV1 sont exploités. Le séparateur de
composants est ^ ; les répétitions (~) ne sont gérées que dans PID-3.
"""
from dataclasses import dataclass, field

SEG = "\r"


@dataclass
class Patient:
    ipp: str = ""
    ins: str = ""
    nom: str = ""
    prenom: str = ""
    naissance: str = ""
    sexe: str = ""
    adresse: dict = field(default_factory=dict)
    telephone: str = ""


def _champs(segment):
    return segment.split("|")


def _composants(champ):
    return champ.split("^")


def lire_pid(segment) -> Patient:
    f = _champs(segment)
    p = Patient()
    for ident in (_composants(x) for x in f[3].split("~")):
        if len(ident) > 4 and ident[4] == "PI":
            p.ipp = ident[0]
        elif len(ident) > 4 and ident[4] == "INS":
            p.ins = ident[0]
    nom = _composants(f[5])
    p.nom, p.prenom = nom[0], (nom[1] if len(nom) > 1 else "")
    p.naissance, p.sexe = f[7], f[8]
    adr = _composants(f[11]) if len(f) > 11 else []
    if adr:
        p.adresse = {"rue": adr[0], "ville": adr[2] if len(adr) > 2 else "", "cp": adr[4] if len(adr) > 4 else ""}
    p.telephone = _composants(f[13])[0] if len(f) > 13 else ""
    return p


def lire_message(brut: str) -> dict:
    segments = {s[:3]: s for s in brut.strip().split(SEG) if s}
    return {
        "type": _composants(_champs(segments["MSH"])[8])[1],
        "patient": lire_pid(segments["PID"]),
        "uf": _composants(_champs(segments["PV1"])[3])[0] if "PV1" in segments else None,
    }


# --- tests (pytest) ----------------------------------------------------------

MESSAGE_A01 = SEG.join([
    "MSH|^~\\&|GAM|CHU|PASSERELLE|CHU|20240311093012||ADT^A01|⟬uuid#1⟭|P|2.5",
    "PID|1||⟬customer_id#2⟭^^^CHU^PI~⟬fr_social_security_number#2f⟭^^^INS-NIR^INS||⟬person_name:family#2⟭^⟬person_name:given#2⟭||⟬birth_date#2⟭|F|||⟬fr_postal_address:street#2⟭^^⟬city#2⟭^^⟬postcode#2⟭||⟬phone#2⟭",
    "PV1|1|I|CARDIO^^^CHU",
])


def test_type_message():
    assert lire_message(MESSAGE_A01)["type"] == "A01"


def test_identifiants():
    p = lire_message(MESSAGE_A01)["patient"]
    assert p.ipp == "⟬customer_id#2⟭"
    assert p.ins == "⟬fr_social_security_number#2⟭"


def test_identite():
    p = lire_message(MESSAGE_A01)["patient"]
    assert (p.nom, p.prenom, p.sexe) == ("⟬person_name:family#2⟭", "⟬person_name:given#2⟭", "F")


def test_adresse_et_telephone():
    p = lire_message(MESSAGE_A01)["patient"]
    assert p.adresse["cp"] == "⟬postcode#2⟭"
    assert p.telephone == "⟬phone#2⟭"


def test_unite_fonctionnelle():
    assert lire_message(MESSAGE_A01)["uf"] == "CARDIO"
⟬end⟭

⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: class attribute, keyword argument, decorator
scenario: Pydantic schemas of a medical appointment API, written by the back-end lead with field descriptions for the generated documentation
⟬text⟭
"""Schémas d'entrée et de sortie de l'API patients (prise de rendez-vous)."""
from datetime import date
from typing import Literal, Optional

from pydantic import BaseModel, EmailStr, Field, field_validator


class PatientCreation(BaseModel):
    nom: str = Field(..., min_length=1, max_length=80, description="Nom de naissance, mis en majuscules")
    prenom: str = Field(..., min_length=1, max_length=80)
    ⟬trap:indicator_non_pii|date_naissance: date = Field(..., description="Format AAAA-MM-JJ")⟭
    sexe: Literal["F", "M", "I"]
    email: Optional[EmailStr] = None
    ⟬trap:indicator_non_pii|telephone: Optional[str] = Field(None, pattern=r"^\+?[0-9 ]{10,17}$")⟭
    ins: Optional[str] = Field(None, min_length=15, max_length=15, description="INS-NIR, clé incluse")

    ⟬trap:email_lookalike|@field_validator⟭("nom")
    @classmethod
    def majuscules(cls, v: str) -> str:
        return v.strip().upper()

    @field_validator("ins")
    @classmethod
    def sans_espaces(cls, v: Optional[str]) -> Optional[str]:
        return v.replace(" ", "") if v else v


class PatientSortie(BaseModel):
    id: int
    nom: str
    prenom: str
    ins_masque: str = Field(..., examples=["⟬trap:placeholder|2 ** ** ** *** *** 42⟭"])
    cree_le: date
⟬end⟭

⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: energy
appearance: list literal, comment, string literal
scenario: quick script of a distribution network's outage team alerting vital-risk patients before a planned cut, with the list copied into the code
⟬text⟭
# Alerte coupure programmée aux patients à haut risque vital (PHRV) du secteur.
# Liste transmise par l'ARS, mise à jour le ⟬date#1⟭.
# TODO : lire la liste depuis le référentiel au lieu de la recopier ici !
from alertes import appel_vocal, envoyer_sms

PHRV = [
    ("⟬person_name#2⟭", "⟬phone#2⟭", "⟬fr_postal_address#2⟭"),
    ("⟬person_name#3⟭", "⟬phone#3⟭", "⟬fr_postal_address#3⟭"),
    ("⟬person_name#4⟭", "⟬phone#4⟭", "⟬fr_postal_address#4⟭"),
]

MESSAGE = "Coupure d'électricité prévue le {date} de 8h30 à 12h. Pensez à vérifier l'autonomie de vos appareils."


def prevenir(date_coupure):
    for nom, tel, adresse in PHRV:
        if not envoyer_sms(tel, MESSAGE.format(date=date_coupure)):
            appel_vocal(tel, MESSAGE.format(date=date_coupure))
        print("prévenu :", nom, "-", adresse)
⟬end⟭

⟬template⟭
family: code
format: .sql
language: fr
fill_locale: fr_FR
domain: banking
appearance: SQL string, function call, comment, SQL WHERE
scenario: PL/pgSQL function of a bank's card platform blocking a lost card, followed by the tester's calls with test cards
⟬text⟭
-- Mise en opposition d'une carte, appelée par le serveur vocal et l'appli mobile.
CREATE OR REPLACE FUNCTION opposer_carte(p_pan TEXT, p_motif TEXT, p_canal TEXT)
RETURNS BIGINT
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    v_carte_id BIGINT;
    v_opposition_id BIGINT;
BEGIN
    SELECT id INTO v_carte_id FROM cartes WHERE pan_empreinte = encode(digest(p_pan, 'sha256'), 'hex');
    IF v_carte_id IS NULL THEN
        RAISE EXCEPTION 'carte inconnue (canal %)', p_canal;
    END IF;

    INSERT INTO oppositions (carte_id, motif, canal, cree_le)
    VALUES (v_carte_id, p_motif, p_canal, now())
    RETURNING id INTO v_opposition_id;

    UPDATE cartes SET statut = 'opposee' WHERE id = v_carte_id;

    -- le réseau est prévenu de façon asynchrone par le connecteur monétique
    PERFORM dblink_exec('host=⟬hostname#1⟭ dbname=monetique user=opposition password=⟬password#1⟭',
                        format('INSERT INTO a_notifier(carte_id) VALUES (%s)', v_carte_id));
    RETURN v_opposition_id;
END;
$$;

-- Essais en recette (cartes de test du lot ⟬order_number#2⟭)
SELECT opposer_carte('⟬payment_card#3⟭', 'perte', 'test');
SELECT opposer_carte('⟬payment_card#4⟭', 'vol', 'test');

-- compte joint ⟬iban#5⟭ (M. et Mme ⟬person_name:family#5⟭) : la seconde carte du compte doit rester active
SELECT c.id, c.titulaire, c.statut
  FROM cartes c JOIN comptes k ON k.id = c.compte_id
 WHERE k.iban = '⟬iban#5⟭';
⟬end⟭

⟬template⟭
family: code
format: .sql
language: fr
fill_locale: fr_FR
domain: insurance
appearance: SQL INSERT, comment, SQL UPDATE
scenario: slowly changing dimension load of a motor insurer's data warehouse, preceded by hand-written staging rows for acceptance testing
⟬text⟭
/* ------------------------------------------------------------------
   Chargement de la dimension contrat auto (historisation type 2)
   Source : staging.contrats_auto_jour (fichier de la plateforme de gestion)
   ------------------------------------------------------------------ */

-- 1. Jeu d'essai, à exécuter sur entrepot_recette uniquement
INSERT INTO staging.contrats_auto_jour VALUES
    ('⟬order_number#1⟭', '⟬person_name#1⟭', '⟬birth_date#1⟭', '⟬fr_postal_address#1⟭', '⟬fr_license_plate#1⟭', '⟬fr_driving_licence#1⟭', '⟬iban#1⟭', 'TIERS', 412.80, '⟬date#2⟭'),
    ('⟬order_number#2⟭', '⟬person_name#2⟭', '⟬birth_date#2⟭', '⟬fr_postal_address#2⟭', '⟬fr_license_plate#2⟭', '⟬fr_driving_licence#2⟭', '⟬iban#2⟭', 'TOUS_RISQUES', 986.10, '⟬date#2⟭'),
    ('⟬order_number#3⟭', '⟬person_name#3⟭', '⟬birth_date#3⟭', '⟬fr_postal_address#3⟭', '⟬fr_license_plate#3⟭', '⟬fr_driving_licence#3⟭', NULL, 'TIERS_PLUS', 655.00, '⟬date#2⟭'),
    -- même contrat que la 1re ligne, nouvelle adresse et nouveau véhicule : doit créer une version
    ('⟬order_number#1⟭', '⟬person_name#1⟭', '⟬birth_date#1⟭', '⟬fr_postal_address#4⟭', '⟬fr_license_plate#4⟭', '⟬fr_driving_licence#1⟭', '⟬iban#1⟭', 'TIERS', 430.20, '⟬date#1⟭');

-- 2. Clôture des versions dont un attribut suivi a changé
UPDATE dw.dim_contrat_auto d
   SET date_fin = s.date_extraction - 1, courant = FALSE
  FROM staging.contrats_auto_jour s
 WHERE d.numero_contrat = s.numero_contrat
   AND d.courant
   AND (d.adresse_hash <> md5(s.adresse) OR d.immatriculation <> s.immatriculation OR d.formule <> s.formule);

-- 3. Insertion des nouvelles versions
INSERT INTO dw.dim_contrat_auto (numero_contrat, souscripteur, date_naissance, adresse_hash, code_postal,
                                 immatriculation, formule, prime_annuelle, date_debut, date_fin, courant)
SELECT s.numero_contrat, s.souscripteur, s.date_naissance, md5(s.adresse), substring(s.adresse from '\d{5}'),
       s.immatriculation, s.formule, s.prime, s.date_extraction, DATE '9999-12-31', TRUE
  FROM staging.contrats_auto_jour s
  LEFT JOIN dw.dim_contrat_auto d ON d.numero_contrat = s.numero_contrat AND d.courant
 WHERE d.numero_contrat IS NULL;

-- 4. Contrôles
SELECT count(*) AS versions_courantes_en_double
  FROM (SELECT numero_contrat FROM dw.dim_contrat_auto WHERE courant GROUP BY 1 HAVING count(*) > 1) x;
-- attendu : 0

SELECT numero_contrat, souscripteur, immatriculation, date_debut, date_fin
  FROM dw.dim_contrat_auto
 WHERE numero_contrat = '⟬order_number#1⟭'
 ORDER BY date_debut;
-- attendu : 2 lignes, ⟬fr_license_plate#1⟭ puis ⟬fr_license_plate#4⟭
⟬end⟭

⟬template⟭
family: code
format: .sql
language: fr
fill_locale: fr_FR
domain: public administration
appearance: SQL WHERE, comment
scenario: lookup query saved by a phone support agent of an online public services platform to find a caller's files
⟬text⟭
-- Recherche dossier pour le support téléphonique (l'usager donne son numéro fiscal et sa date de naissance)
SELECT d.reference, d.type_demarche, d.statut, d.depose_le, u.nom, u.prenom
  FROM dossiers d
  JOIN usagers u ON u.id = d.usager_id
 WHERE u.numero_fiscal = '⟬fr_tax_number#1⟭'
   AND u.date_naissance = '⟬birth_date#1⟭'
 ORDER BY d.depose_le DESC;
-- appel du ⟬date#1⟭, usager ⟬person_name#1⟭ : dossier ⟬ticket_id#2⟭ bloqué en "pièce manquante"
⟬end⟭

⟬template⟭
family: code
format: .sql
language: fr
fill_locale: fr_FR
domain: HR
appearance: column definition, comment, SQL INSERT
scenario: schema of the training management module of an HR suite, including a legacy function still named after the contractor who wrote it
⟬text⟭
-- Schéma du module formation (plan de développement des compétences)

CREATE TABLE formations (
    id              SERIAL PRIMARY KEY,
    intitule        VARCHAR(200) NOT NULL,
    organisme       VARCHAR(120) NOT NULL,
    ⟬trap:indicator_non_pii|formateur       VARCHAR(120) NOT NULL DEFAULT 'interne'⟭,
    duree_heures    NUMERIC(5,1) NOT NULL CHECK (duree_heures > 0),
    eligible_cpf    BOOLEAN NOT NULL DEFAULT FALSE,
    cout_ht         NUMERIC(10,2)
);

CREATE TABLE inscriptions (
    id              SERIAL PRIMARY KEY,
    formation_id    INTEGER NOT NULL REFERENCES formations(id),
    matricule       VARCHAR(10) NOT NULL,
    session_debut   DATE NOT NULL,
    statut          VARCHAR(12) NOT NULL DEFAULT 'demandee'
                    CHECK (statut IN ('demandee', 'validee', 'refusee', 'realisee', 'annulee')),
    valide_par      VARCHAR(10),
    UNIQUE (formation_id, matricule, session_debut)
);

COMMENT ON COLUMN inscriptions.valide_par IS 'matricule du manager, jamais son nom';

-- Reprise de l'ancienne fonction de calcul des droits, écrite par un prestataire et jamais renommée
CREATE OR REPLACE FUNCTION ⟬trap:code_identifier|calcul_cpf_⦃family⦄⟭(p_heures_travaillees NUMERIC)
RETURNS NUMERIC LANGUAGE sql IMMUTABLE AS $$
    SELECT least(500, round(p_heures_travaillees / 1607 * 500, 2))
$$;

CREATE VIEW v_heures_par_service AS
SELECT s.service, date_part('year', i.session_debut) AS annee, sum(f.duree_heures) AS heures
  FROM inscriptions i
  JOIN formations f ON f.id = i.formation_id
  JOIN salaries s ON s.matricule = i.matricule
 WHERE i.statut = 'realisee'
 GROUP BY 1, 2;

INSERT INTO parametres (cle, valeur) VALUES
    ('formation.validation.delai_jours', '15'),
    ⟬trap:indicator_non_pii|('formation.notification.expediteur', 'outil-formation')⟭;
⟬end⟭

⟬template⟭
family: code
format: .sql
language: fr
fill_locale: fr_FR
domain: energy
appearance: SQL INSERT, comment
scenario: demo data for the training environment of a district heating billing application, where subscribers are condominiums and their managing agents
⟬text⟭
-- Données de démonstration : facturation du réseau de chaleur (environnement de formation)
-- Les abonnés sont des copropriétés représentées par leur syndic.

INSERT INTO utilisateurs (login, mot_de_passe_temporaire, role) VALUES
    ('formation_admin', '⟬password#1⟭', 'admin'),
    ('formation_agent', '⟬password#2⟭', 'agent');

INSERT INTO syndics (raison_sociale, siret, contact_nom, contact_email, contact_tel, iban_remboursement) VALUES
    ('⟬company#3⟭', '⟬fr_siret#3⟭', '⟬person_name#5⟭', '⟬email#5⟭', '⟬phone#5⟭', '⟬iban#3⟭'),
    ('⟬company#4⟭', '⟬fr_siret#4⟭', '⟬person_name#6⟭', '⟬email#6⟭', '⟬phone#6⟭', '⟬iban#4⟭');

INSERT INTO sous_stations (code, syndic_siret, adresse, puissance_souscrite_kw, mise_en_service) VALUES
    ('SST-014', '⟬fr_siret#3⟭', '⟬fr_postal_address#7⟭', 350, '⟬date#1⟭'),
    ('SST-015', '⟬fr_siret#3⟭', '⟬fr_postal_address#8⟭', 210, '⟬date#2⟭'),
    ('SST-031', '⟬fr_siret#4⟭', '⟬fr_postal_address#9⟭', 520, '⟬date#3⟭');

INSERT INTO index_mensuels (sous_station, mois, mwh) VALUES
    ('SST-014', '2024-01-01', 61.2), ('SST-014', '2024-02-01', 54.8),
    ('SST-015', '2024-01-01', 37.0), ('SST-015', '2024-02-01', 33.9),
    ('SST-031', '2024-01-01', 92.4), ('SST-031', '2024-02-01', 85.1);
⟬end⟭

⟬template⟭
family: code
format: .ipynb
language: fr
fill_locale: fr_FR
domain: public administration
appearance: markdown cell, notebook output, function call
scenario: record linkage notebook of a county council matching its minimum income beneficiaries with the family allowance fund's file
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Rapprochement des fichiers RSA (département / CAF) : doublons probables\n",
    "\n",
    "Blocage sur l'année de naissance, puis similarité de ⟬trap:eponym|Jaro-Winkler⟭ sur nom + prénom. Seuil retenu : 0.92."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "metadata": {},
   "outputs": [],
   "source": [
    "import jellyfish\n",
    "import pandas as pd\n",
    "\n",
    "dep = pd.read_csv(\"⟬file_path#1⟭\", sep=\";\", dtype=str)\n",
    "caf = pd.read_csv(\"⟬file_path#2⟭\", sep=\";\", dtype=str)\n",
    "for d in (dep, caf):\n",
    "    d[\"cle\"] = (d[\"nom\"] + \" \" + d[\"prenom\"]).str.upper()\n",
    "    d[\"annee\"] = d[\"date_naissance\"].str[-4:]"
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
       "   cle_dep  cle_caf  naissance  score\n",
       "0  ⟬person_name#3⟭  ⟬person_name#3⟭  ⟬birth_date#3⟭  1.000\n",
       "1  ⟬person_name#4⟭  ⟬person_name#5⟭  ⟬birth_date#4⟭  0.951\n",
       "2  ⟬person_name#6⟭  ⟬person_name#6⟭  ⟬birth_date#6⟭  0.938"
      ]
     },
     "execution_count": 2,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "paires = dep.merge(caf, on=\"annee\", suffixes=(\"_dep\", \"_caf\"))\n",
    "paires[\"score\"] = [⟬trap:code_identifier|jellyfish.jaro_winkler_similarity⟭(a, b) for a, b in zip(paires[\"cle_dep\"], paires[\"cle_caf\"])]\n",
    "doublons = paires[paires[\"score\"] >= 0.92].sort_values(\"score\", ascending=False)\n",
    "doublons[[\"cle_dep\", \"cle_caf\", \"date_naissance_dep\", \"score\"]].rename(columns={\"date_naissance_dep\": \"naissance\"}).head(3)"
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
      "foyers à vérifier par un instructeur :\n",
      "⟬fr_social_security_number#4⟭ | ⟬fr_tax_number#4⟭ | ⟬fr_postal_address#4⟭\n",
      "⟬fr_social_security_number#5⟭ | ⟬fr_tax_number#5⟭ | ⟬fr_postal_address#5⟭\n"
     ]
    }
   ],
   "source": [
    "a_verifier = doublons[doublons[\"nir_dep\"] != doublons[\"nir_caf\"]]\n",
    "print(\"foyers à vérifier par un instructeur :\")\n",
    "for _, l in a_verifier.iterrows():\n",
    "    print(l[\"nir_dep\"], l[\"numero_fiscal_dep\"], l[\"adresse_dep\"], sep=\" | \")\n",
    "    print(l[\"nir_caf\"], l[\"numero_fiscal_caf\"], l[\"adresse_caf\"], sep=\" | \")"
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
format: .ipynb
language: fr
fill_locale: fr_FR
domain: banking
appearance: URL, HTTP header, notebook output, dict literal, markdown cell
scenario: credit scoring notebook of a consumer lender's risk team, training a model and checking one application against the tax notice verification service
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Score d'octroi crédit conso v4 : entraînement et contrôle sur un dossier"
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
    "import requests\n",
    "from sklearn.linear_model import LogisticRegression\n",
    "from sklearn.metrics import roc_auc_score\n",
    "from sklearn.model_selection import train_test_split\n",
    "from sqlalchemy import create_engine\n",
    "\n",
    "engine = create_engine(\"postgresql://scoring:⟬url_password#1⟭@⟬hostname#1⟭/octroi\")\n",
    "API_REVENUS = \"⟬url#2⟭\"\n",
    "JETON = \"⟬opaque_token#2⟭\""
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
       "        id  numero_fiscal  date_naissance  revenu_declare  revenu_verifie  defaut_12m\n",
       "18204  ⟬customer_id#3⟭  ⟬fr_tax_number#3⟭  ⟬birth_date#3⟭  31200  29874  0\n",
       "77311  ⟬customer_id#4⟭  ⟬fr_tax_number#4⟭  ⟬birth_date#4⟭  54000  54000  0\n",
       "40918  ⟬customer_id#5⟭  ⟬fr_tax_number#5⟭  ⟬birth_date#5⟭  22800  17950  1"
      ]
     },
     "execution_count": 2,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "demandes = pd.read_sql(\"SELECT * FROM demandes_historique WHERE date_demande < '2023-01-01'\", engine)\n",
    "demandes.sample(3, random_state=7)[[\"id\", \"numero_fiscal\", \"date_naissance\", \"revenu_declare\", \"revenu_verifie\", \"defaut_12m\"]]"
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
      "AUC test : 0.781   ⟬trap:eponym|Gini⟭ : 0.562\n"
     ]
    }
   ],
   "source": [
    "X = pd.get_dummies(demandes[[\"age\", \"anciennete_emploi\", \"taux_endettement\", \"ecart_revenu\", \"type_logement\"]], drop_first=True)\n",
    "y = demandes[\"defaut_12m\"]\n",
    "X_tr, X_te, y_tr, y_te = train_test_split(X, y, test_size=0.25, random_state=7, stratify=y)\n",
    "modele = LogisticRegression(max_iter=2000, class_weight=\"balanced\").fit(X_tr, y_tr)\n",
    "auc = roc_auc_score(y_te, modele.predict_proba(X_te)[:, 1])\n",
    "print(f\"AUC test : {auc:.3f}   Gini : {2 * auc - 1:.3f}\")"
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
       "{'revenuFiscalReference': 28450,\n",
       " 'nombreParts': 1.5,\n",
       " 'declarant1': {'nom': '⟬person_name:family#6⟭', 'prenoms': '⟬person_name:given#6⟭', 'dateNaissance': '⟬birth_date#6⟭'},\n",
       " 'adresseFiscale': '⟬fr_postal_address#6⟭'}"
      ]
     },
     "execution_count": 4,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "# dossier contesté par l'agence : écart entre revenu déclaré et avis\n",
    "dossier = {\"numero_fiscal\": \"⟬fr_tax_number#6⟭\", \"iban\": \"⟬iban#6⟭\", \"revenu_declare\": 36000}\n",
    "r = requests.get(f\"{API_REVENUS}/avis\", params={\"numeroFiscal\": dossier[\"numero_fiscal\"], \"annee\": 2023},\n",
    "                 headers={\"Authorization\": f\"Bearer {JETON}\"}, timeout=20)\n",
    "r.json()"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Revenu de l'avis inférieur de 21 % au déclaré : le dossier repasse en étude manuelle."
   ]
  }
 ],
 "metadata": {
  "kernelspec": {"display_name": "risque", "language": "python", "name": "risque"},
  "language_info": {"name": "python", "version": "3.10.14"}
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
appearance: markdown cell, notebook output
scenario: HR notebook computing the yearly gender pay equality index from an anonymised extract, shared with the works council
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Index égalité professionnelle 2024 : indicateurs 1 à 4\n",
    "\n",
    "Extrait anonymisé du SIRH (pas de nom ni de matricule). ⟬trap:indicator_non_pii|Contact : équipe SIRH⟭."
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
      "(1286, 7)\n",
      "csp, tranche_age, sexe, remuneration_annuelle, augmentation, promotion, retour_conge_mat\n"
     ]
    }
   ],
   "source": [
    "import pandas as pd\n",
    "\n",
    "df = pd.read_parquet(\"⟬file_path#1⟭\")\n",
    "print(df.shape)\n",
    "print(\", \".join(df.columns))"
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
       "csp         tranche_age  ecart_pct\n",
       "ouvriers    <30           2.1\n",
       "ouvriers    30-39         3.4\n",
       "employes    30-39        -1.2\n",
       "techniciens 40-49         4.8\n",
       "cadres      40-49         7.9\n",
       "cadres      50+           9.6"
      ]
     },
     "execution_count": 2,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "moy = df.groupby([\"csp\", \"tranche_age\", \"sexe\"])[\"remuneration_annuelle\"].agg([\"mean\", \"size\"]).unstack(\"sexe\")\n",
    "valides = moy[(moy[(\"size\", \"F\")] >= 3) & (moy[(\"size\", \"H\")] >= 3)]\n",
    "ecart = ((valides[(\"mean\", \"H\")] - valides[(\"mean\", \"F\")]) / valides[(\"mean\", \"H\")] * 100).round(1)\n",
    "ecart.rename(\"ecart_pct\").reset_index()"
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
      "indice de ⟬trap:eponym|Gini⟭ des rémunérations : 0.214\n"
     ]
    }
   ],
   "source": [
    "import numpy as np\n",
    "r = np.sort(df[\"remuneration_annuelle\"].to_numpy())\n",
    "n = len(r)\n",
    "gini = (2 * np.arange(1, n + 1) - n - 1).dot(r) / (n * r.sum())\n",
    "print(f\"indice de Gini des rémunérations : {gini:.3f}\")"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Les groupes de moins de 3 personnes par sexe sont exclus, comme le prévoit le barème. Résultats présentés en CSE le ⟬date#1⟭."
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
format: .sh
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: URL, environment variable, heredoc, comment
scenario: script restoring a radiology system's database into a test environment for the vendor, anonymising it but keeping one patient identifiable
⟬text⟭
#!/bin/bash
# Restauration de la base RIS/PACS en environnement de test, puis anonymisation.
# Demandé par l'éditeur pour reproduire l'anomalie ⟬ticket_id#1⟭.
set -e

SAUVEGARDE_URL="https://sauvegardes:⟬url_password#1⟭@⟬hostname#1⟭/pacs/pacs_$(date -d yesterday +%F).sql.gz"
MYSQL_PWD='⟬password#2⟭'
export MYSQL_PWD

curl -fsS "$SAUVEGARDE_URL" | gunzip | mysql -h ⟬hostname#2⟭ -u root pacs_test

mysql -h ⟬hostname#2⟭ -u root pacs_test <<'SQL'
UPDATE patients SET nom = CONCAT('PATIENT', id), prenom = 'TEST', nir = NULL, telephone = NULL, email = NULL;
UPDATE patients SET date_naissance = DATE_ADD(date_naissance, INTERVAL FLOOR(RAND() * 60) - 30 DAY);
SQL

# Le dossier qui déclenche l'anomalie doit rester repérable pour l'éditeur :
# patient ⟬customer_id#3⟭ (⟬person_name#3⟭, NIR ⟬fr_social_security_number#3⟭), examen du ⟬date#1⟭
mysql -h ⟬hostname#2⟭ -u root pacs_test -e "UPDATE patients SET nom = 'CAS_ANOMALIE' WHERE ipp = '⟬customer_id#3⟭'"

echo "base pacs_test prête"
⟬end⟭

⟬template⟭
family: code
format: .sh
language: fr
fill_locale: fr_FR
domain: banking
appearance: heredoc, HTTP header, command-line argument
scenario: daily script of a payment service signing the direct debit file and posting it to the bank's remittance API
⟬text⟭
#!/bin/bash
# signature et dépôt du fichier de prélèvements du jour
F=/data/sepa/out/PRLV_$(date +%Y%m%d).xml
openssl dgst -sha256 -sign <(cat <<'K'
⟬private_key#1⟭
K
) -out "$F.sig" "$F"
curl -sf -F "fichier=@$F" -F "signature=@$F.sig" -H "X-Api-Key: ⟬opaque_token#2⟭" "https://⟬hostname#2⟭/remises"
⟬end⟭

⟬template⟭
family: code
format: .sh
language: fr
fill_locale: fr_FR
domain: insurance
appearance: command-line argument, environment variable
scenario: CI job of an insurer's contract service running database migrations with Flyway
⟬text⟭
#!/bin/sh
# Migrations de la base contrats (CI, job "migrer")
set -e
flyway -url="jdbc:postgresql://${DB_HOST}:5432/contrats" \
       ⟬trap:indicator_non_pii|-user=flyway⟭ \
       -password="⟬trap:placeholder|${FLYWAY_PASSWORD}⟭" \
       -locations=filesystem:sql/migrations \
       -validateMigrationNaming=true \
       migrate
flyway -url="jdbc:postgresql://${DB_HOST}:5432/contrats" -user=flyway -password="$FLYWAY_PASSWORD" info | tail -n 5
⟬end⟭

⟬template⟭
family: code
format: .sh
language: fr
fill_locale: fr_FR
domain: public administration
appearance: environment variable, URL, command-line argument
scenario: CI setup script of a public benefits rules engine, installing dependencies from the internal package index
⟬text⟭
#!/usr/bin/env bash
# Préparation de l'environnement de test du moteur de règles des aides (job CI)
set -euo pipefail

PYTHON=${PYTHON:-python3.11}
⟬trap:indicator_non_pii|export PIP_INDEX_USER=ci-lecture⟭
export PIP_INDEX_URL="https://${PIP_INDEX_USER}:⟬trap:placeholder|${PIP_INDEX_TOKEN}⟭@⟬hostname#1⟭/simple/"

if [ ! -d regles-communes ]; then
  git clone --depth 1 ⟬trap:email_lookalike|git@forge.interne⟭:aides/regles-communes.git
fi

"$PYTHON" -m venv .venv
. .venv/bin/activate
pip install -q --upgrade pip
pip install -q -r requirements-dev.txt -e ./regles-communes

pytest -q --junitxml=rapport.xml --cov=aides --cov-report=xml
echo "tests terminés ($(date -Is))"
⟬end⟭
