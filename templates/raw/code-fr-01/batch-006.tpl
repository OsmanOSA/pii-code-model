⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: banking
appearance: docstring, SQL in string literal, comment
scenario: Alembic migration of a retail bank adding account holders' tax numbers for CRS reporting, with a manual backfill for blocked files
⟬text⟭
"""ajout du numéro fiscal des titulaires (déclarations CRS / FATCA)

Revision ID: 7c2e91ab40d1
Revises: 3f0a5d22c8e7
Create Date: ⟬date#1⟭
"""
import sqlalchemy as sa
from alembic import op

revision = "7c2e91ab40d1"
down_revision = "3f0a5d22c8e7"
branch_labels = None
depends_on = None


def upgrade():
    op.add_column("titulaires", sa.Column("numero_fiscal", sa.String(20), nullable=True))
    op.add_column("titulaires", sa.Column("residence_fiscale", sa.String(2), nullable=False, server_default="FR"))
    op.create_index("ix_titulaires_numero_fiscal", "titulaires", ["numero_fiscal"])

    # Reprise manuelle des dossiers bloqués dans la déclaration de l'an dernier
    # (numéros fournis par le service conformité, ⟬ticket_id#2⟭)
    op.execute("""
        UPDATE titulaires SET numero_fiscal = '⟬fr_tax_number#3⟭'
         WHERE compte_iban = '⟬iban#3⟭';
        UPDATE titulaires SET numero_fiscal = '⟬fr_tax_number#4⟭'
         WHERE compte_iban = '⟬iban#4⟭';
        UPDATE titulaires SET residence_fiscale = 'BE', numero_fiscal = NULL
         WHERE nom = '⟬person_name:family#5⟭' AND compte_iban = '⟬iban#5⟭';
    """)


def downgrade():
    op.drop_index("ix_titulaires_numero_fiscal", table_name="titulaires")
    op.drop_column("titulaires", "residence_fiscale")
    op.drop_column("titulaires", "numero_fiscal")
⟬end⟭

⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: list literal, test fixture, tuple, comment
scenario: parametrised pytest suite of a hospital admission module checking social security numbers against birth dates
⟬text⟭
"""Tests du contrôle de cohérence NIR / date de naissance à l'admission."""
import pytest

from admission.controles import nir_coherent_avec_naissance, nir_valide

NIR_VALIDES = [
    "⟬fr_social_security_number#1⟭",
    "⟬fr_social_security_number#2⟭",
    "⟬fr_social_security_number#3⟭",
]


@pytest.mark.parametrize("nir", NIR_VALIDES)
def test_nir_valides(nir):
    assert nir_valide(nir)


@pytest.mark.parametrize("nir", [
    "",
    "1" * 15,
    "⟬fr_social_security_number#4⟭"[:13],          # clé absente
    "⟬fr_social_security_number#5⟭"[:-2] + "99",   # clé fausse
])
def test_nir_invalides(nir):
    assert not nir_valide(nir)


@pytest.mark.parametrize("nir, naissance, attendu", [
    ("⟬fr_social_security_number#6⟭", "⟬birth_date#6⟭", True),
    ("⟬fr_social_security_number#7⟭", "⟬birth_date#7⟭", True),
    ("⟬fr_social_security_number#8⟭", "⟬birth_date#8⟭", True),
    # date saisie à l'envers par l'accueil (jour et mois inversés)
    ("⟬fr_social_security_number#9⟭", "⟬birth_date#10⟭", False),
])
def test_coherence_naissance(nir, naissance, attendu):
    assert nir_coherent_avec_naissance(nir, naissance) is attendu
⟬end⟭

⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: HR
appearance: dict literal, f-string, keyword argument, comment
scenario: Typer command-line tool of an HR department issuing end-of-contract documents, with a test output kept for the legal review
⟬text⟭
"""Outil en ligne de commande du service RH : attestations et certificats.

    python -m outils_rh attestation-employeur --matricule A0412
    python -m outils_rh certificat-travail A0412 --fin 2024-03-31

Les données employeur sont figées ci-dessous ; elles changeront au déménagement du siège.
"""
from datetime import date
from pathlib import Path

import typer
from ⟬trap:library|jinja2⟭ import Environment, FileSystemLoader

from sirh import client as sirh

app = typer.Typer(help="Documents RH de fin de contrat")
GABARITS = Environment(loader=FileSystemLoader(Path(__file__).parent / "gabarits"))

EMPLOYEUR = {
    "raison_sociale": "⟬company#1⟭",
    "siret": "⟬fr_siret#1⟭",
    "adresse": "⟬fr_postal_address#1⟭",
    "code_naf": "6201Z",
    "signataire": "⟬person_name#2⟭",
    "qualite_signataire": "⟬job_title#2⟭",
}
SORTIE = Path("⟬file_path#1⟭")


def _salarie(matricule: str) -> dict:
    s = sirh.salarie(matricule)
    if s is None:
        raise typer.BadParameter(f"matricule inconnu : {matricule}")
    return s


@app.command("attestation-employeur")
def attestation_employeur(matricule: str = typer.Option(..., help="matricule SIRH"),
                          motif: str = typer.Option("fin_cdd", help="motif de rupture")):
    s = _salarie(matricule)
    html = GABARITS.get_template("attestation_employeur.html").render(
        employeur=EMPLOYEUR, salarie=s, motif=motif, salaires=sirh.salaires_12_mois(matricule), le=date.today()
    )
    chemin = SORTIE / f"attestation_{matricule}.html"
    chemin.write_text(html, encoding="utf-8")
    typer.echo(f"écrit : {chemin}")


@app.command("certificat-travail")
def certificat_travail(matricule: str, fin: str = typer.Option(..., help="date de fin AAAA-MM-JJ")):
    s = _salarie(matricule)
    texte = (
        f"Je soussigné(e) {EMPLOYEUR['signataire']}, {EMPLOYEUR['qualite_signataire']} de {EMPLOYEUR['raison_sociale']}, "
        f"certifie que {s['civilite']} {s['prenom']} {s['nom']}, né(e) le {s['date_naissance']}, "
        f"a été employé(e) du {s['date_entree']} au {fin} en qualité de {s['poste']}."
    )
    (SORTIE / f"certificat_{matricule}.txt").write_text(texte, encoding="utf-8")
    typer.echo(texte)


@app.command("verifier")
def verifier(matricule: str):
    """Contrôle les données obligatoires avant édition."""
    s = _salarie(matricule)
    manquants = [c for c in ("nir", "date_naissance", "adresse", "date_entree") if not s.get(c)]
    typer.echo("complet" if not manquants else f"manquant : {', '.join(manquants)}")


if __name__ == "__main__":
    app()


# Sortie de `certificat-travail` en recette (⟬date#1⟭), gardée pour la relecture juridique :
#   Je soussigné(e) ⟬person_name#2⟭, ⟬job_title#2⟭ de ⟬company#1⟭, certifie que Mme ⟬person_name:given#3f⟭
#   ⟬person_name:family#3⟭, née le ⟬birth_date#3⟭, a été employé(e) du ⟬date#3⟭ au ⟬date#2⟭ en qualité de
#   chargée de clientèle.
# Données SIRH correspondantes : NIR ⟬fr_social_security_number#3⟭, adresse ⟬fr_postal_address#3⟭.
⟬end⟭

⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: insurance
appearance: HTTP header, keyword argument, comment
scenario: polling snippet of a direct insurer fetching leads from a comparison website, with the signature under an innocuous header
⟬text⟭
# Récupération des leads du comparateur partenaire (toutes les 15 min)
import requests

r = requests.get(
    "https://⟬hostname#1⟭/v1/leads",
    params={"since": "15m", "produit": "auto"},
    headers={"X-Partner": "assur-direct", "sig": "⟬opaque_token#2⟭"},
    auth=("assur-direct", "⟬password#3⟭"),
    timeout=20,
)
for lead in r.json()["items"]:
    print(lead["id"], lead["contact"]["email"], lead["contact"]["tel"])
# exemple de sortie : ⟬uuid#4⟭ ⟬email#4⟭ ⟬phone#4⟭
⟬end⟭

⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: public administration
appearance: list literal, dict literal, comment, f-string
scenario: town hall script listing polling stations and their presiding officers for an election, used to print posters and the prefecture file
⟬text⟭
"""Bureaux de vote et présidents pour le scrutin du ⟬date#1⟭.

Sert à générer les affiches et le fichier transmis à la préfecture.
"""
import csv

BUREAUX = [
    {"numero": 1, "lieu": "Hôtel de ville, salle des mariages", "adresse": "⟬fr_postal_address#2⟭",
     "president": "⟬person_name#2⟭", "tel_president": "⟬phone#2⟭"},
    {"numero": 2, "lieu": "École élémentaire ⟬trap:eponym|Jules Ferry⟭", "adresse": "⟬fr_postal_address#3⟭",
     "president": "⟬person_name#3⟭", "tel_president": "⟬phone#3⟭"},
    {"numero": 3, "lieu": "Gymnase ⟬trap:eponym|Marie Marvingt⟭", "adresse": "⟬fr_postal_address#4⟭",
     "president": "⟬person_name#4⟭", "tel_president": "⟬phone#4⟭"},
    {"numero": 4, "lieu": "Salle polyvalente", "adresse": "⟬fr_postal_address#5⟭",
     "president": "⟬person_name#5⟭", "tel_president": "⟬phone#5⟭"},
]

# Accès PMR du bureau 3 par l'entrée de la ⟬trap:word_name|rue Victor Hugo⟭, pas par le parking.


def exporter_prefecture(chemin):
    with open(chemin, "w", newline="", encoding="utf-8") as f:
        w = csv.DictWriter(f, fieldnames=["numero", "lieu", "adresse", "president", "tel_president"], delimiter=";")
        w.writeheader()
        w.writerows(BUREAUX)


def affiche(bureau):
    return f"BUREAU DE VOTE N° {bureau['numero']}\n{bureau['lieu']}\n{bureau['adresse']}\nOuvert de 8h à 18h"
⟬end⟭

⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: energy
appearance: URL, dict literal, comment
scenario: collector of an energy supplier fetching consumption curves of consenting customers from a data hub, signing requests with a key kept under a short dict key
⟬text⟭
"""Collecte des courbes de consommation des clients ayant donné leur consentement.

Le hub de données exige des requêtes signées (JWS, clé du fournisseur) et un
jeton OAuth. Le registre des consentements est relu depuis Redis à chaque passage.
"""
import json
import time

import jwt
import redis
import requests

REGISTRE = redis.Redis.from_url("redis://:⟬url_password#1⟭@⟬hostname#1⟭:6379/2")
HUB = "https://⟬hostname#2⟭/v2"
SIRET_FOURNISSEUR = "⟬fr_siret#3⟭"
SIGNATURE = {"kid": "fournisseur-2024-01", "alg": "ES256", "k": "⟬private_key#3⟭"}


def requete_signee(chemin, corps):
    entete = {"kid": SIGNATURE["kid"], "alg": SIGNATURE["alg"]}
    jws = jwt.encode({"path": chemin, "body": corps, "iat": int(time.time())}, SIGNATURE["k"],
                     algorithm=SIGNATURE["alg"], headers=entete)
    return requests.post(f"{HUB}{chemin}", json=corps, headers={"X-Signature": jws}, timeout=30)


def consentements_actifs():
    for cle in REGISTRE.scan_iter("consentement:*"):
        c = json.loads(REGISTRE.get(cle))
        if c["statut"] == "actif" and c["fin"] > time.strftime("%Y-%m-%d"):
            yield c


def collecter():
    for c in consentements_actifs():
        r = requete_signee("/courbes", {"prm": c["prm"], "siret_demandeur": SIRET_FOURNISSEUR, "pas": "30min"})
        print(c["prm"], r.status_code)


# Un enregistrement du registre, pour mémoire :
# {"prm": "⟬customer_id#4⟭", "titulaire": "⟬person_name#4⟭", "adresse": "⟬fr_postal_address#4⟭",
#  "statut": "actif", "debut": "⟬date#2⟭", "fin": "⟬date#1⟭", "canal": "espace_client"}
⟬end⟭

⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: banking
appearance: docstring, dataclass, assignment
scenario: loan schedule and annual percentage rate module of a consumer credit back end
⟬text⟭
"""Tableau d'amortissement et TAEG d'un prêt à échéances constantes.

Le TAEG est obtenu par la méthode de ⟬trap:eponym|Newton-Raphson⟭ sur l'équation
d'équivalence actuarielle (frais de dossier et assurance inclus).
"""
from dataclasses import dataclass
from decimal import ROUND_HALF_UP, Decimal

CENTIME = Decimal("0.01")
⟬trap:indicator_non_pii|CODE_PRODUIT = "PRET_PERSO_V3"⟭


@dataclass
class Echeance:
    numero: int
    mensualite: Decimal
    interets: Decimal
    capital: Decimal
    restant_du: Decimal


def mensualite(capital: Decimal, taux_annuel: Decimal, n: int) -> Decimal:
    t = taux_annuel / 12
    if t == 0:
        return (capital / n).quantize(CENTIME, ROUND_HALF_UP)
    return (capital * t / (1 - (1 + t) ** -n)).quantize(CENTIME, ROUND_HALF_UP)


def tableau(capital: Decimal, taux_annuel: Decimal, n: int) -> list:
    m = mensualite(capital, taux_annuel, n)
    restant, lignes = capital, []
    for i in range(1, n + 1):
        interets = (restant * taux_annuel / 12).quantize(CENTIME, ROUND_HALF_UP)
        amorti = m - interets if i < n else restant
        restant -= amorti
        lignes.append(Echeance(i, interets + amorti, interets, amorti, restant))
    return lignes


def taeg(capital: float, frais: float, flux: list, iterations: int = 50) -> float:
    """flux : montants mensuels payés par l'emprunteur (mensualité + assurance)."""
    net = capital - frais
    x = 0.05
    for _ in range(iterations):
        f = sum(v / (1 + x) ** ((k + 1) / 12) for k, v in enumerate(flux)) - net
        df = sum(-(k + 1) / 12 * v / (1 + x) ** ((k + 1) / 12 + 1) for k, v in enumerate(flux))
        x_suivant = x - f / df
        if abs(x_suivant - x) < 1e-10:
            return x_suivant
        x = x_suivant
    return x
⟬end⟭

⟬template⟭
family: code
format: .py
language: fr
fill_locale: fr_FR
domain: HR
appearance: docstring, dict literal
scenario: public holidays helper of a time and attendance application, including the Alsace-Moselle local rules
⟬text⟭
"""Jours fériés français, régime local d'Alsace-Moselle compris."""
from datetime import date, timedelta


def paques(annee: int) -> date:
    """Dimanche de Pâques, ⟬trap:eponym|algorithme de Meeus⟭ (calendrier grégorien)."""
    a, b, c = annee % 19, annee // 100, annee % 100
    d, e = b // 4, b % 4
    f = (b + 8) // 25
    g = (b - f + 1) // 3
    h = (19 * a + b - d - g + 15) % 30
    i, k = c // 4, c % 4
    l = (32 + 2 * e + 2 * i - h - k) % 7
    m = (a + 11 * h + 22 * l) // 451
    mois = (h + l - 7 * m + 114) // 31
    jour = (h + l - 7 * m + 114) % 31 + 1
    return date(annee, mois, jour)


def feries(annee: int, alsace_moselle: bool = False) -> dict:
    p = paques(annee)
    jours = {
        date(annee, 1, 1): "Jour de l'an",
        p + timedelta(days=1): "Lundi de Pâques",
        date(annee, 5, 1): "Fête du travail",
        date(annee, 5, 8): "Victoire 1945",
        p + timedelta(days=39): "Ascension",
        p + timedelta(days=50): "Lundi de Pentecôte",
        date(annee, 7, 14): "Fête nationale",
        date(annee, 8, 15): "Assomption",
        date(annee, 11, 1): "Toussaint",
        date(annee, 11, 11): "Armistice",
        date(annee, 12, 25): "Noël",
    }
    if alsace_moselle:
        jours[p - timedelta(days=2)] = "Vendredi saint"
        jours[date(annee, 12, 26)] = "⟬trap:word_name|Saint-Étienne⟭"
    return dict(sorted(jours.items()))
⟬end⟭

⟬template⟭
family: code
format: .sql
language: fr
fill_locale: fr_FR
domain: insurance
appearance: SQL MERGE, SQL VALUES, comment, free text
scenario: life insurance back-office script updating a contract's beneficiary clause after an amendment, entered under the four-eyes rule
⟬text⟭
-- Mise à jour de la clause bénéficiaire du contrat d'assurance-vie ⟬order_number#1⟭
-- Avenant signé le ⟬date#1⟭, reçu par courrier recommandé ; saisie en double contrôle.
-- Souscripteur : ⟬person_name#2⟭, NIR ⟬fr_social_security_number#2⟭, numéro fiscal ⟬fr_tax_number#2⟭ (déclaration FICOVIE)

MERGE INTO beneficiaires AS b
USING (VALUES
    ('⟬order_number#1⟭', 1, '⟬person_name#3⟭', '⟬birth_date#3⟭', '⟬fr_postal_address#3⟭', 50.00),
    ('⟬order_number#1⟭', 2, '⟬person_name#4⟭', '⟬birth_date#4⟭', '⟬fr_postal_address#4⟭', 25.00),
    ('⟬order_number#1⟭', 3, '⟬person_name#5⟭', '⟬birth_date#5⟭', '⟬fr_postal_address#4⟭', 25.00)
) AS n (contrat, rang, nom, date_naissance, adresse, quote_part)
ON b.contrat = n.contrat AND b.rang = n.rang
WHEN MATCHED THEN
    UPDATE SET nom = n.nom, date_naissance = n.date_naissance::date, adresse = n.adresse, quote_part = n.quote_part
WHEN NOT MATCHED THEN
    INSERT (contrat, rang, nom, date_naissance, adresse, quote_part)
    VALUES (n.contrat, n.rang, n.nom, n.date_naissance::date, n.adresse, n.quote_part);

-- l'ancien 4e rang disparaît de la clause
DELETE FROM beneficiaires WHERE contrat = '⟬order_number#1⟭' AND rang > 3;

-- Clause en texte libre telle qu'elle figure sur l'avenant :
-- « mes enfants ⟬person_name:given#4⟭ et ⟬person_name:given#5⟭, nés de mon union avec ⟬person_name#6⟭, à défaut mes héritiers »
SELECT rang, nom, date_naissance, quote_part FROM beneficiaires WHERE contrat = '⟬order_number#1⟭' ORDER BY rang;
⟬end⟭

⟬template⟭
family: code
format: .sql
language: fr
fill_locale: fr_FR
domain: public administration
appearance: recursive CTE, SQL WHERE, comment
scenario: support query of a prefecture's IT desk walking up the service tree from the caller's own service
⟬text⟭
-- Organigramme remonté depuis le service de l'agent qui appelle le support
WITH RECURSIVE chaine AS (
    SELECT s.id, s.libelle, s.parent_id, 0 AS niveau
      FROM services s
      JOIN agents a ON a.service_id = s.id
     WHERE a.email = '⟬email#1⟭'
    UNION ALL
    SELECT p.id, p.libelle, p.parent_id, c.niveau + 1
      FROM services p
      JOIN chaine c ON c.parent_id = p.id
)
SELECT niveau, libelle FROM chaine ORDER BY niveau DESC;
-- appel de ⟬person_name#1⟭ (poste ⟬phone#1⟭) : ne voit pas le dossier partagé de sa direction
⟬end⟭

⟬template⟭
family: code
format: .sql
language: fr
fill_locale: fr_FR
domain: energy
appearance: SQL UPDATE, SQL INSERT, comment, SQL WHERE
scenario: data fix script after a meter replacement round of a distribution operator, written from the field technicians' reports
⟬text⟭
-- ===============================================================
-- Campagne de remplacement des compteurs : corrections après tournée
-- Lot 7, secteur nord. Rédigé par l'équipe données du centre d'exploitation.
-- ===============================================================

BEGIN;

-- 1. Nouveaux compteurs posés (relevés terrain)
UPDATE points_livraison SET numero_compteur = 'CPT-881204', date_pose = '⟬date#1⟭' WHERE prm = '⟬customer_id#1⟭';
UPDATE points_livraison SET numero_compteur = 'CPT-881219', date_pose = '⟬date#1⟭' WHERE prm = '⟬customer_id#2⟭';
UPDATE points_livraison SET numero_compteur = 'CPT-881230', date_pose = '⟬date#2⟭' WHERE prm = '⟬customer_id#3⟭';

-- 2. Adresses fausses dans le référentiel (le technicien n'a pas trouvé le compteur)
UPDATE points_livraison SET adresse = '⟬fr_postal_address#2⟭' WHERE prm = '⟬customer_id#2⟭';
UPDATE points_livraison SET adresse = '⟬fr_postal_address#4⟭', complement = 'bâtiment B, local technique sous-sol'
 WHERE prm = '⟬customer_id#4⟭';

-- 3. Clients absents à deux passages : à rappeler par le centre d'appels
INSERT INTO rappels_clients (prm, nom, telephone, motif, cree_le) VALUES
    ('⟬customer_id#5⟭', '⟬person_name#5⟭', '⟬phone#5⟭', 'absent_2_passages', now()),
    ('⟬customer_id#6⟭', '⟬person_name#6⟭', '⟬phone#6⟭', 'absent_2_passages', now()),
    ('⟬customer_id#7⟭', '⟬person_name#7⟭', NULL, 'refus_pose', now());

-- 4. Sites professionnels : rendez-vous à prendre avec le gestionnaire du site
INSERT INTO rendez_vous_pro (siret, raison_sociale, adresse_site, contact, telephone, creneau_souhaite) VALUES
    ('⟬fr_siret#8⟭', '⟬company#8⟭', '⟬fr_postal_address#8⟭', '⟬person_name#9⟭', '⟬phone#9⟭', 'matin'),
    ('⟬fr_siret#10⟭', '⟬company#10⟭', '⟬fr_postal_address#10⟭', '⟬person_name#11⟭', '⟬phone#11⟭', 'fermeture hebdomadaire (lundi)');

-- 5. Compteurs inversés entre deux logements du même palier : on échange
UPDATE points_livraison
   SET numero_compteur = CASE prm WHEN '⟬customer_id#12⟭' THEN 'CPT-881311' ELSE 'CPT-881310' END
 WHERE prm IN ('⟬customer_id#12⟭', '⟬customer_id#13⟭');

-- 6. Contrôle
SELECT prm, numero_compteur, date_pose, adresse
  FROM points_livraison
 WHERE lot_campagne = 7 AND (date_pose IS NULL OR numero_compteur NOT LIKE 'CPT-%')
 ORDER BY prm;

COMMIT;
⟬end⟭

⟬template⟭
family: code
format: .sql
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: CTE, SQL WHERE, comment
scenario: bed occupancy query behind a hospital nursing directorate's weekly dashboard
⟬text⟭
-- Taux d'occupation des lits par unité, semaine glissante (tableau de bord de la direction des soins)
WITH jours AS (
    SELECT generate_series(CURRENT_DATE - 6, CURRENT_DATE, interval '1 day')::date AS jour
),
occupation AS (
    SELECT u.code_uf, u.libelle, j.jour, count(s.id) AS lits_occupes
      FROM unites u
      CROSS JOIN jours j
      LEFT JOIN sejours s
        ON s.code_uf = u.code_uf
       AND s.date_entree::date <= j.jour
       AND coalesce(s.date_sortie::date, CURRENT_DATE + 1) > j.jour
     GROUP BY u.code_uf, u.libelle, j.jour
)
SELECT o.libelle,
       round(avg(o.lits_occupes), 1)                                        AS lits_occupes_moy,
       u.lits_installes,
       round(100.0 * avg(o.lits_occupes) / nullif(u.lits_installes, 0), 1)  AS taux_occupation
  FROM occupation o
  JOIN unites u USING (code_uf)
 WHERE u.batiment IN ('⟬trap:eponym|Pavillon Charcot⟭', '⟬trap:eponym|Pavillon Pasteur⟭')
 GROUP BY o.libelle, u.lits_installes
 ORDER BY taux_occupation DESC;
-- ⟬trap:indicator_non_pii|patient : aucune donnée nominative⟭, agrégats uniquement
⟬end⟭

⟬template⟭
family: code
format: .sql
language: fr
fill_locale: fr_FR
domain: banking
appearance: SQL INSERT, SQL WHERE, comment, SQL string
scenario: sanctions screening script of a bank's compliance team, with asset-freeze entries typed by hand while the feed connector is broken
⟬text⟭
-- Criblage des clients contre la liste nationale de gel des avoirs (mise à jour du ⟬date#1⟭)
-- Entrées ajoutées depuis le dernier chargement automatique, saisies à la main
-- en attendant la correction du connecteur.
INSERT INTO liste_gel (reference, nom, prenoms, date_naissance, lieu_naissance, ajoute_le) VALUES
    ('GEL-2024-0311', '⟬person_name:family#2⟭', '⟬person_name:given#2⟭', '⟬birth_date#2⟭', '⟬city#2⟭', '⟬date#1⟭'),
    ('GEL-2024-0312', '⟬person_name:family#3⟭', '⟬person_name:given#3⟭', '⟬birth_date#3⟭', '⟬city#3⟭', '⟬date#1⟭'),
    ('GEL-2024-0315', '⟬person_name:family#4⟭', '⟬person_name:given#4⟭', NULL, '⟬city#4⟭', '⟬date#1⟭');

-- Rapprochement : nom identique, date de naissance identique ou absente de la liste
SELECT c.id, c.nom, c.prenom, c.date_naissance, k.iban, g.reference
  FROM clients c
  JOIN comptes k ON k.client_id = c.id
  JOIN liste_gel g ON upper(g.nom) = upper(c.nom)
 WHERE g.date_naissance IS NULL OR g.date_naissance = c.date_naissance;
-- 1 alerte : client 448120, ⟬person_name#3⟭, ⟬birth_date#3⟭, compte ⟬iban#5⟭ -> gel immédiat, déclaration à faire

ALTER ROLE criblage_auto PASSWORD '⟬password#6⟭' VALID UNTIL '2025-01-01';
⟬end⟭

⟬template⟭
family: code
format: .ipynb
language: fr
fill_locale: fr_FR
domain: public administration
appearance: notebook output, markdown cell, function call
scenario: notebook of a housing department preparing the allocation committee from the social housing applications waiting for over two years
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Demandes de logement social en attente depuis plus de 24 mois\n",
    "\n",
    "Préparation de la commission d'attribution. Données nominatives : ne pas diffuser."
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
       "(3127, 14)"
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
    "demandes = pd.read_csv(\"⟬file_path#1⟭\", sep=\";\", dtype=str, parse_dates=[\"date_depot\"])\n",
    "demandes.shape"
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
       "  numero_unique  demandeur  date_naissance  composition  numero_fiscal  rfr  adresse_actuelle\n",
       "0  ⟬customer_id#2⟭  ⟬person_name#2⟭  ⟬birth_date#2⟭  1 adulte, 2 enfants  ⟬fr_tax_number#2⟭  11204  ⟬fr_postal_address#2⟭\n",
       "1  ⟬customer_id#3⟭  ⟬person_name#3⟭  ⟬birth_date#3⟭  2 adultes, 3 enfants  ⟬fr_tax_number#3⟭  19850  ⟬fr_postal_address#3⟭\n",
       "2  ⟬customer_id#4⟭  ⟬person_name#4⟭  ⟬birth_date#4⟭  1 adulte  ⟬fr_tax_number#4⟭  8930  ⟬fr_postal_address#4⟭\n",
       "3  ⟬customer_id#5⟭  ⟬person_name#5⟭  ⟬birth_date#5⟭  2 adultes, 1 enfant  ⟬fr_tax_number#5⟭  23110  ⟬fr_postal_address#5⟭"
      ]
     },
     "execution_count": 2,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "attente = demandes[demandes[\"date_depot\"] < pd.Timestamp.today() - pd.DateOffset(months=24)]\n",
    "attente[[\"numero_unique\", \"demandeur\", \"date_naissance\", \"composition\", \"numero_fiscal\", \"rfr\", \"adresse_actuelle\"]].head(4)"
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
       "priorite\n",
       "DALO                    41\n",
       "handicap                63\n",
       "sur-occupation         212\n",
       "violences               18\n",
       "sans priorité          802\n",
       "Name: numero_unique, dtype: int64"
      ]
     },
     "execution_count": 3,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "attente.groupby(\"priorite\")[\"numero_unique\"].count()"
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
      "membres de la commission convoqués :\n",
      "⟬person_name#6⟭ - ⟬phone#6⟭ - ⟬email#6⟭\n",
      "⟬person_name#7⟭ - ⟬phone#7⟭ - ⟬email#7⟭\n"
     ]
    }
   ],
   "source": [
    "from referentiel import membres_commission\n",
    "print(\"membres de la commission convoqués :\")\n",
    "for m in membres_commission(\"CAL-2024-05\"):\n",
    "    print(m.nom, m.telephone, m.email, sep=\" - \")"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Le dossier de ⟬person_name#3⟭ (NIR ⟬fr_social_security_number#3⟭) semble en doublon avec une demande de la commune voisine : vérifier avant passage en commission."
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
language: fr
fill_locale: fr_FR
domain: insurance
appearance: query string, URL, notebook output, markdown cell
scenario: claims notebook mapping home claims after a hail storm to plan expert visits, geocoding addresses with a maps API key
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Épisode de grêle du ⟬date#1⟭ : carte des sinistres habitation déclarés"
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
    "CLE_GEOCODAGE = \"⟬google_api_key#2⟭\"\n",
    "base = create_engine(\"postgresql://sinistres_lecture:⟬url_password#3⟭@⟬hostname#3⟭/sinistres\")\n",
    "sin = pd.read_sql(\"SELECT numero, assure, adresse_risque FROM sinistres WHERE evenement = 'GRELE' AND date_survenance >= now() - interval '7 days'\", base)\n",
    "\n",
    "def geocoder(adresse):\n",
    "    r = requests.get(\"https://maps.googleapis.com/maps/api/geocode/json\", params={\"address\": adresse, \"key\": CLE_GEOCODAGE}, timeout=10).json()\n",
    "    loc = r[\"results\"][0][\"geometry\"][\"location\"] if r[\"results\"] else {\"lat\": None, \"lng\": None}\n",
    "    return pd.Series([loc[\"lat\"], loc[\"lng\"]])\n",
    "\n",
    "sin[[\"lat\", \"lon\"]] = sin[\"adresse_risque\"].apply(geocoder)"
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
       "  numero  assure  adresse_risque  lat  lon\n",
       "0  ⟬order_number#4⟭  ⟬person_name#4⟭  ⟬fr_postal_address#4⟭  45.7312  4.8921\n",
       "1  ⟬order_number#5⟭  ⟬person_name#5⟭  ⟬fr_postal_address#5⟭  45.7408  4.9017\n",
       "2  ⟬order_number#6⟭  ⟬person_name#6⟭  ⟬fr_postal_address#6⟭  NaN      NaN"
      ]
     },
     "execution_count": 2,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "sin.head(3)"
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
       "<folium.folium.Map at 0x7f3a2c91d4e0>"
      ]
     },
     "execution_count": 3,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "import folium\n",
    "carte = folium.Map(location=[sin[\"lat\"].mean(), sin[\"lon\"].mean()], zoom_start=11)\n",
    "for _, s in sin.dropna(subset=[\"lat\"]).iterrows():\n",
    "    folium.CircleMarker([s[\"lat\"], s[\"lon\"]], radius=4, popup=s[\"numero\"]).add_to(carte)\n",
    "carte"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Concentration nette autour de ⟬city#7⟭ : prévoir deux experts supplémentaires la semaine prochaine."
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
domain: energy
appearance: markdown cell, notebook output, function call
scenario: grid operations notebook analysing frequency measurements from a phasor unit to spot oscillation modes
⟬text⟭
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Fréquence du réseau : densité spectrale par la méthode de ⟬trap:eponym|Welch⟭\n",
    "\n",
    "Mesures du capteur PMU du poste source, pas de 20 ms, une semaine. ⟬trap:indicator_non_pii|Responsable : équipe conduite⟭."
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
      "échantillons : 30 240 000\n",
      "écart max à 50 Hz : 0.142 Hz, écart-type : 0.018 Hz\n"
     ]
    }
   ],
   "source": [
    "import numpy as np\n",
    "import pandas as pd\n",
    "from scipy import signal\n",
    "\n",
    "f_mes = pd.read_parquet(\"⟬file_path#1⟭\")[\"frequence_hz\"].to_numpy()\n",
    "ecart = f_mes - 50.0\n",
    "print(f\"échantillons : {len(f_mes):,}\".replace(\",\", \" \"))\n",
    "print(f\"écart max à 50 Hz : {np.abs(ecart).max():.3f} Hz, écart-type : {ecart.std():.3f} Hz\")"
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
       "array([0.0167, 0.2183, 0.7012])"
      ]
     },
     "execution_count": 2,
     "metadata": {},
     "output_type": "execute_result"
    }
   ],
   "source": [
    "freqs, dsp = ⟬trap:code_identifier|signal.welch⟭(ecart, fs=50, nperseg=2**16)\n",
    "pics, _ = signal.find_peaks(10 * np.log10(dsp), prominence=6)\n",
    "freqs[pics][:3].round(4)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "Mode inter-zones vers 0.22 Hz, cohérent avec les études ; le pic à 0.70 Hz est à confirmer sur une seconde semaine."
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
format: .sh
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: command-line argument, heredoc, comment
scenario: one-time initialisation of a health record application's secrets in Vault on a certified health data host, run from the bastion
⟬text⟭
#!/usr/bin/env bash
# Initialisation des secrets du dossier patient informatisé dans Vault (hébergement HDS)
# À lancer une seule fois par environnement, depuis le bastion.
set -euo pipefail
export VAULT_ADDR=https://⟬hostname#1⟭:8200

vault login -method=userpass username=init-dpi password='⟬password#1⟭'

vault kv put secret/dpi/base \
  host=⟬hostname#2⟭ port=5432 user=dpi_app password='⟬password#2⟭'

vault kv put secret/dpi/tls key=@- <<'CLE'
⟬private_key#3⟭
CLE

# jeton applicatif à durée limitée, à reporter dans la configuration du service
vault token create -policy=dpi-lecture -ttl=720h -format=json | jq -r .auth.client_token
# dernier jeton émis (⟬date#1⟭) : ⟬opaque_token#4⟭
⟬end⟭

⟬template⟭
family: code
format: .sh
language: fr
fill_locale: fr_FR
domain: HR
appearance: comment, command-line argument
scenario: awk one-liner of a payroll administrator listing employees whose bank account changed between two extracts
⟬text⟭
#!/bin/sh
# Salariés dont l'IBAN a changé entre deux extractions paie (fichier sans en-tête).
# Lignes d'entrée, par exemple :
#   ⟬customer_id#1⟭;⟬person_name#1⟭;⟬iban#1⟭;⟬iban#2⟭
#   ⟬customer_id#3⟭;⟬person_name#3⟭;⟬iban#3⟭;⟬iban#3⟭
awk -F';' '$3 != $4 { printf "%s\t%s\t%s -> %s\n", $1, $2, $3, $4 }' "${1:-/data/paie/iban_diff.csv}" \
  | tee "/data/paie/iban_modifies_$(date +%Y%m).txt"
⟬end⟭

⟬template⟭
family: code
format: .sh
language: fr
fill_locale: fr_FR
domain: banking
appearance: environment variable, URL, HTTP header, heredoc, function
scenario: shared bash function library sourced by the operations scripts of a lending platform
⟬text⟭
#!/usr/bin/env bash
# lib_exploitation.sh - fonctions communes des scripts d'exploitation (plateforme crédits)
# À sourcer : . /opt/exploit/lib_exploitation.sh

LIB_LOG=/var/log/exploitation/$(basename "${0:-lib}").log
DB_URL="postgresql://exploit:⟬url_password#1⟭@⟬hostname#1⟭:5432/credits"
ALERTE_URL="https://⟬hostname#2⟭/api/v1/alertes"
ALERTE_JETON="⟬opaque_token#2⟭"
SFTP_HOTE=⟬hostname#3⟭
CLE_SFTP=/opt/exploit/.ssh/sftp_banque

journal() {
  printf '%s [%s] %s\n' "$(date -Is)" "${2:-INFO}" "$1" >> "$LIB_LOG"
}

requete() {
  psql "$DB_URL" -At -v ON_ERROR_STOP=1 -c "$1"
}

alerte() {
  local niveau=$1 message=$2
  curl -s -X POST "$ALERTE_URL" -H "Authorization: Bearer $ALERTE_JETON" \
    -H 'Content-Type: application/json' \
    -d "{\"niveau\": \"$niveau\", \"source\": \"exploitation-credits\", \"message\": \"$message\"}" >/dev/null
  journal "alerte $niveau : $message" WARN
}

installer_cle_sftp() {
  # la clé n'est pas dans l'image : on la pose au premier appel
  [ -f "$CLE_SFTP" ] && return 0
  mkdir -p "$(dirname "$CLE_SFTP")"
  cat > "$CLE_SFTP" <<'CLE'
⟬private_key#3⟭
CLE
  chmod 600 "$CLE_SFTP"
}

deposer() {
  local fichier=$1 cible=${2:-/entrant}
  installer_cle_sftp
  sftp -i "$CLE_SFTP" -o User=credits_remise -b - "$SFTP_HOTE" <<EOF
put $fichier $cible/
EOF
}

verifier_lots_du_jour() {
  local nb
  nb=$(requete "SELECT count(*) FROM lots_prelevements WHERE date_lot = CURRENT_DATE AND statut = 'ERREUR'")
  if [ "$nb" -gt 0 ]; then
    alerte critique "$nb lot(s) de prélèvements en erreur"
    return 1
  fi
  journal "lots du jour OK"
}

purger_journaux() {
  find /var/log/exploitation -name '*.log' -mtime +30 -delete
}
⟬end⟭

⟬template⟭
family: code
format: .sh
language: fr
fill_locale: fr_FR
domain: insurance
appearance: heredoc, configuration directive
scenario: install script writing the systemd unit of an insurer's pricing engine on a compute server
⟬text⟭
#!/bin/sh
# Installation du moteur de tarification en service systemd (serveur de calcul)
cat > /etc/systemd/system/tarificateur.service <<'EOF'
[Unit]
Description=Moteur de tarification auto/habitation
After=network-online.target

[Service]
⟬trap:indicator_non_pii|User=tarificateur⟭
EnvironmentFile=/etc/tarificateur/env
ExecStart=/opt/tarificateur/bin/serveur --port 8091 --workers 4
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload && systemctl enable --now tarificateur
⟬end⟭
