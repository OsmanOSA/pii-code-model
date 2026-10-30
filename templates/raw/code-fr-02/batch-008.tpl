⟬template⟭
family: code
format: .php
language: fr
fill_locale: fr_FR
domain: telecom
appearance: constant array, SQL query, comment
scenario: monthly cron script of a regional mobile operator building the SEPA direct debit file, with last month's rejected debits noted for manual follow-up
⟬text⟭
<?php
/**
 * Génère le fichier de prélèvements SEPA (pain.008.001.02) des factures mobiles du mois.
 * Lancé le 3 de chaque mois par cron ; le fichier part ensuite sur l'EBICS de la banque.
 */
require __DIR__ . '/../vendor/autoload.php';

use Digitick\Sepa\PaymentInformation;
use Digitick\Sepa\TransferFile\Factory\TransferFileFacadeFactory;

const CREANCIER = [
    'nom' => '⟬company#1⟭',
    'siren' => '⟬fr_siren#1⟭',
    'iban' => '⟬iban#1⟭',
    'bic' => '⟬bic#1⟭',
];

$pdo = new PDO(getenv('FACTURATION_DSN'));
$factures = $pdo->query(
    "SELECT f.numero, f.montant_ttc, a.titulaire, a.iban, a.bic, a.rum, a.date_signature_mandat
     FROM factures f JOIN abonnes a ON a.id = f.abonne_id
     WHERE f.statut = 'A_PRELEVER'"
)->fetchAll(PDO::FETCH_ASSOC);

$fichier = TransferFileFacadeFactory::createDirectDebit('PRLV-' . date('Ym'), CREANCIER['nom'], 'pain.008.001.02');
$fichier->addPaymentInfo('mensuel', [
    'id' => 'mensuel-' . date('Ym'),
    'dueDate' => new DateTime('+5 days'),
    'creditorName' => CREANCIER['nom'],
    'creditorAccountIBAN' => CREANCIER['iban'],
    'creditorAgentBIC' => CREANCIER['bic'],
    'seqType' => PaymentInformation::S_RECURRING,
    'creditorId' => getenv('SEPA_ICS'),
]);

foreach ($factures as $f) {
    $fichier->addTransfer('mensuel', [
        'amount' => (int) round($f['montant_ttc'] * 100),
        'debtorIban' => $f['iban'],
        'debtorBic' => $f['bic'],
        'debtorName' => $f['titulaire'],
        'debtorMandate' => $f['rum'],
        'debtorMandateSignDate' => $f['date_signature_mandat'],
        'remittanceInformation' => 'Facture ' . $f['numero'],
    ]);
}

file_put_contents(sprintf('/srv/sepa/sortant/PRLV-%s.xml', date('Ym')), $fichier->asXML());

// Rejets du mois dernier à retraiter à la main (motif AC04, compte clôturé) :
// ⟬person_name#2⟭ ⟬iban#2⟭ facture ⟬invoice_number#2⟭, rappeler au ⟬phone#2⟭
// ⟬person_name#3⟭ ⟬iban#3⟭ facture ⟬invoice_number#3⟭, rappeler au ⟬phone#3⟭
⟬end⟭

⟬template⟭
family: code
format: .kt
language: fr
fill_locale: fr_FR
domain: education
appearance: named argument, file path, assertion
scenario: unit test of the student card printing template of a university, with the photo path built from the student's handle
⟬text⟭
class ImpressionCarteEtudiantTest {

    @Test
    fun leRectoReprendNomNaissanceEtPhoto() {
        val carte = GabaritCarte.recto(
            nom = "⟬person_name#1⟭",
            naissance = "⟬birth_date#1⟭",
            photo = File("/srv/cartes/photos/⟬person_name:handle#1⟭.jpg"),
        )
        assertTrue(carte.lignes.any { it.contains("⟬person_name#1⟭") })
        assertEquals("2026-2027", carte.anneeUniversitaire)
    }
}
⟬end⟭

⟬template⟭
family: code
format: .ts
language: fr
fill_locale: fr_FR
domain: logistics
appearance: template literal, scheduled job, CSV excerpt in comment
scenario: NestJS scheduled job of a transport company exporting fuel card transactions to its accountants over SFTP with key authentication
⟬text⟭
import { Injectable, Logger } from "@nestjs/common";
import { Cron } from "@nestjs/schedule";
import SftpClient from "ssh2-sftp-client";
import { stringify } from "csv-stringify/sync";
import { PrismaService } from "../prisma.service";

/**
 * Export mensuel des transactions des cartes carburant vers le cabinet comptable.
 * Le cabinet n'accepte que du CSV déposé en SFTP, avec authentification par clé.
 */
const SFTP = {
  host: "⟬hostname#1⟭",
  port: 22,
  username: "flotte-export",
  privateKey: `⟬private_key#2⟭`,
};

@Injectable()
export class ExportCarburantService {
  private readonly log = new Logger(ExportCarburantService.name);

  constructor(private readonly prisma: PrismaService) {}

  @Cron("0 6 1 * *")
  async exporterMoisPrecedent(): Promise<void> {
    const debut = new Date();
    debut.setDate(1);
    debut.setMonth(debut.getMonth() - 1);
    const fin = new Date(debut.getFullYear(), debut.getMonth() + 1, 1);

    const transactions = await this.prisma.transactionCarburant.findMany({
      where: { date: { gte: debut, lt: fin } },
      include: { carte: { include: { vehicule: true, chauffeur: true } } },
      orderBy: { date: "asc" },
    });

    const lignes = transactions.map((t) => ({
      date: t.date.toISOString().slice(0, 10),
      carte: t.carte.numero,
      vehicule: t.carte.vehicule.immatriculation,
      chauffeur: t.carte.chauffeur?.nom ?? "",
      station: t.station,
      litres: t.litres.toFixed(2),
      montant_ttc: t.montantTtc.toFixed(2),
    }));

    const fichier = `carburant-${debut.getFullYear()}-${String(debut.getMonth() + 1).padStart(2, "0")}.csv`;
    const sftp = new SftpClient();
    try {
      await sftp.connect(SFTP);
      await sftp.put(Buffer.from(stringify(lignes, { header: true, delimiter: ";" })), `/depot/${fichier}`);
      this.log.log(`${fichier} déposé (${lignes.length} transactions)`);
    } finally {
      await sftp.end();
    }
  }
}

/*
 * Premières lignes du fichier d'octobre, envoyées au cabinet pour valider le format :
 * date;carte;vehicule;chauffeur;station;litres;montant_ttc
 * ⟬date#1⟭;⟬payment_card#3⟭;⟬fr_license_plate#3⟭;"⟬person_name#3⟭";A6 AIRE DE BEAUNE;61.20;112.38
 * ⟬date#1⟭;⟬payment_card#4⟭;⟬fr_license_plate#4⟭;"⟬person_name#4⟭";ZI NORD AUTOMATE;48.75;89.02
 */
⟬end⟭

⟬template⟭
family: code
format: .java
language: fr
fill_locale: fr_FR
domain: real estate
appearance: map literal, Javadoc, comment
scenario: Spring service of a property manager producing the yearly rental income summary sent to landlords, with the case validated with the accountants written below
⟬text⟭
package fr.gestimmo.fiscal;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import org.springframework.stereotype.Service;

/**
 * Récapitulatif annuel des revenus fonciers envoyé à chaque propriétaire en avril
 * (aide à la déclaration 2044). Le numéro fiscal figure en en-tête, à la demande des propriétaires.
 */
@Service
public class RecapitulatifFiscalService {

    private final MandatRepository mandats;
    private final EncaissementRepository encaissements;
    private final GenerateurPdf pdf;

    public RecapitulatifFiscalService(MandatRepository mandats, EncaissementRepository encaissements, GenerateurPdf pdf) {
        this.mandats = mandats;
        this.encaissements = encaissements;
        this.pdf = pdf;
    }

    public byte[] generer(Proprietaire p, int annee) {
        List<Mandat> liste = mandats.actifsPendant(p, annee);
        BigDecimal loyers = encaissements.totalLoyers(liste, annee);
        BigDecimal honoraires = encaissements.totalHonoraires(liste, annee);
        Map<String, Object> modele = Map.of(
            "annee", annee,
            "proprietaire", p.getNomComplet(),
            "numeroFiscal", p.getNumeroFiscal(),
            "biens", liste.stream().map(m -> m.getBien().getAdresse()).toList(),
            "loyersEncaisses", loyers,
            "honorairesDeductibles", honoraires,
            "mandataire", "⟬company#1⟭, SIREN ⟬fr_siren#1⟭");
        return pdf.generer("recap-fiscal.ftl", modele);
    }
}

// Cas de test validé avec le cabinet comptable :
//   propriétaire ⟬person_name#2⟭, numéro fiscal ⟬fr_tax_number#2⟭
//   biens : ⟬fr_postal_address#3⟭ ; ⟬fr_postal_address#4⟭
//   loyers encaissés 14 640,00 €, honoraires 1 171,20 €
⟬end⟭

⟬template⟭
family: code
format: .js
language: fr
fill_locale: fr_FR
domain: travel
appearance: string literal, comment
scenario: throwaway Node script a support engineer of an airline used to decode the token attached to a customer ticket
⟬text⟭
// decode-jeton.js : décode le jeton joint au ticket ⟬ticket_id#1⟭ (client bloqué à l'enregistrement en ligne)
const jeton = "⟬jwt#2⟭";
const [entete, charge] = jeton.split(".").slice(0, 2).map((p) => JSON.parse(Buffer.from(p, "base64url").toString()));
console.log(entete.alg, charge.sub, new Date(charge.exp * 1000).toISOString());
⟬end⟭

⟬template⟭
family: code
format: .ts
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: HTTP header, environment variable fallback, development prefill, comment
scenario: Vue 3 checkout composable of a delicatessen web shop, prefilled with acceptance values in development and exposing a partner delivery key
⟬text⟭
// composables/useCommande.ts : tunnel de commande de la boutique (Vue 3)
import { computed, ref } from "vue";
import axios from "axios";

const api = axios.create({
  baseURL: import.meta.env.VITE_API_URL,
  // clé du partenaire logistique pour l'estimation des délais, exposée côté client faute de proxy
  headers: { "X-Api-Key": import.meta.env.VITE_CLE_LIVRAISON ?? "⟬opaque_token#1⟭" },
});

export function useCommande() {
  const email = ref("");
  const telephone = ref("");
  const adresse = ref({ ligne1: "", codePostal: "", ville: "" });
  const delai = ref<string | null>(null);
  const valide = computed(() => /.+@.+\..+/.test(email.value) && adresse.value.codePostal.length === 5);

  if (import.meta.env.DEV) {
    // valeurs de recette ; la carte se tape à la main dans Stripe : ⟬payment_card#2⟭ / ⟬card_security_code#2⟭
    email.value = "⟬email#3⟭";
    telephone.value = "⟬phone#3⟭";
    adresse.value = { ligne1: "⟬fr_postal_address:street#3⟭", codePostal: "⟬postcode#3⟭", ville: "⟬city#3⟭" };
  }

  async function estimerDelai() {
    const { data } = await api.get("/livraison/estimation", { params: { cp: adresse.value.codePostal } });
    delai.value = data.libelle;
  }

  async function commander(panierId: string, paymentMethodId: string) {
    const { data } = await api.post("/commandes", {
      panierId,
      paymentMethodId,
      email: email.value,
      telephone: telephone.value,
      adresse: adresse.value,
    });
    return data.numero as string;
  }

  return { email, telephone, adresse, delai, valide, estimerDelai, commander };
}
⟬end⟭

⟬template⟭
family: code
format: .kt
language: fr
fill_locale: fr_FR
domain: travel
appearance: constructor argument, list literal, comment, assertion
scenario: Room type converter tests of a ferry company's Android app storing identity documents and emergency contacts as JSON
⟬text⟭
package fr.ferryline.app.donnees

import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Test

class ConvertisseursTest {

    private val convertisseurs = Convertisseurs()

    @Test
    fun lesPiecesSurviventAUnAllerRetourJson() {
        val pieces = listOf(
            Piece(TypePiece.CNI, "⟬fr_identity_card#1⟭", titulaire = "⟬person_name#1⟭"),
            Piece(TypePiece.PASSEPORT, "⟬fr_passport#2⟭", titulaire = "⟬person_name#2⟭"),
        )
        val json = convertisseurs.versJson(pieces)
        assertEquals(pieces, convertisseurs.depuisJson(json))
    }

    @Test
    fun leContactDUrgenceGardeSonFormat() {
        // cas remonté par ⟬trap:initials|AL⟭ : le +33 disparaissait après une migration Room
        val contact = ContactUrgence("⟬person_name#3⟭", "⟬phone#3⟭")
        assertEquals("⟬phone#3⟭", convertisseurs.depuisJsonContact(convertisseurs.versJsonContact(contact)).telephone)
    }

    @Test
    fun uneListeVideDonneUnTableauVide() {
        assertEquals("[]", convertisseurs.versJson(emptyList()))
    }
}
⟬end⟭

⟬template⟭
family: code
format: .java
language: fr
fill_locale: fr_FR
domain: logistics
appearance: constant, scheduled method, Javadoc
scenario: nightly purge job of a parcel carrier erasing recipients' personal data after the retention period set by the data protection officer
⟬text⟭
/** Purge des données personnelles des destinataires, règle validée par la DPO en 2024. */
@Component
public class PurgeDestinataires {

    ⟬trap:indicator_non_pii|public static final int RETENTION_DONNEES_PERSO_JOURS = 90⟭;

    private final JdbcTemplate jdbc;

    public PurgeDestinataires(JdbcTemplate jdbc) {
        this.jdbc = jdbc;
    }

    @Scheduled(cron = "0 30 3 * * *")
    public void ⟬trap:code_identifier|purgerSelonRegle⦃Family⦄⟭() {
        jdbc.update("UPDATE colis SET destinataire_nom = NULL, destinataire_tel = NULL WHERE livre_le < now() - make_interval(days => ?)", RETENTION_DONNEES_PERSO_JOURS);
    }
}
⟬end⟭

⟬template⟭
family: code
format: .ts
language: fr
fill_locale: fr_FR
domain: education
appearance: JSDoc, exported function, constant
scenario: rating module of a mental arithmetic challenge app for middle schools, written by a teacher who also codes
⟬text⟭
/**
 * Classement des élèves sur les défis de calcul mental : système ⟬trap:eponym|Elo⟭ adapté
 * (K = 32 pour les 20 premiers défis, 16 ensuite). L'adversaire d'un élève est l'exercice lui-même,
 * dont la cote évolue aussi au fil des réponses.
 */
export interface Joueur {
  id: string;
  cote: number;
  parties: number;
}

export const COTE_INITIALE = 1200;

export function probabiliteVictoire(a: number, b: number): number {
  return 1 / (1 + 10 ** ((b - a) / 400));
}

export function ⟬trap:code_identifier|mettreAJourElo⟭(eleve: Joueur, coteExercice: number, reussi: boolean): Joueur {
  const k = eleve.parties < 20 ? 32 : 16;
  const attendu = probabiliteVictoire(eleve.cote, coteExercice);
  const cote = Math.round(eleve.cote + k * ((reussi ? 1 : 0) - attendu));
  return { ...eleve, cote: Math.max(100, cote), parties: eleve.parties + 1 };
}

export function niveau(cote: number): "découverte" | "confirmé" | "expert" {
  if (cote < 1100) return "découverte";
  if (cote < 1400) return "confirmé";
  return "expert";
}

export function classement(joueurs: Joueur[], minimumParties = 5): Joueur[] {
  return joueurs.filter((j) => j.parties >= minimumParties).sort((a, b) => b.cote - a.cote);
}
⟬end⟭

⟬template⟭
family: code
format: .php
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: docblock, class constant, array literal
scenario: shipping fee calculator of a fine food web shop, documented with products from the catalogue
⟬text⟭
<?php

namespace App\Livraison;

/**
 * Calcul des frais de port de l'épicerie fine en ligne.
 * Le poids volumétrique compte pour les coffrets (boîtes rigides), pas pour les sachets.
 * Exemples du catalogue : coffret « Thé ⟬trap:eponym|Earl Grey⟭ et ⟬trap:word_name|madeleines⟭ » (1,2 kg),
 * confiture de ⟬trap:word_name|clémentine⟭ (380 g).
 */
final class CalculateurFraisPort
{
    private const GRILLE = [
        // zone => [[poids maximal en grammes, prix en centimes], ...]
        'FR' => [[500, 590], [1000, 790], [2000, 990], [5000, 1490], [PHP_INT_MAX, 2490]],
        'CORSE' => [[500, 890], [1000, 1190], [2000, 1590], [5000, 2290], [PHP_INT_MAX, 3490]],
        'UE' => [[500, 1290], [1000, 1690], [2000, 2190], [5000, 3290], [PHP_INT_MAX, 4990]],
    ];
    private const DIVISEUR_VOLUMETRIQUE = 5000; // cm3 par kg, convention des transporteurs
    private const SEUIL_FRANCO_CENTIMES = 6000;
    ⟬trap:indicator_non_pii|private const CODE_PROMO_PORT_OFFERT = 'PORTOFFERT'⟭;

    public function calculer(array $lignes, string $zone, int $totalCentimes, ?string $codePromo = null): int
    {
        if (!isset(self::GRILLE[$zone])) {
            throw new \InvalidArgumentException("Zone de livraison inconnue : $zone");
        }
        if ($zone === 'FR' && ($totalCentimes >= self::SEUIL_FRANCO_CENTIMES || $codePromo === self::CODE_PROMO_PORT_OFFERT)) {
            return 0;
        }
        $poids = 0;
        foreach ($lignes as $ligne) {
            $poids += $this->poidsTaxable($ligne) * $ligne['quantite'];
        }
        foreach (self::GRILLE[$zone] as [$max, $prix]) {
            if ($poids <= $max) {
                return $prix;
            }
        }
        throw new \LogicException('grille incomplète');
    }

    private function poidsTaxable(array $ligne): int
    {
        if (($ligne['conditionnement'] ?? 'sachet') !== 'coffret') {
            return $ligne['poids_g'];
        }
        [$l, $p, $h] = $ligne['dimensions_cm'];
        $volumetrique = (int) ceil($l * $p * $h / self::DIVISEUR_VOLUMETRIQUE * 1000);

        return max($ligne['poids_g'], $volumetrique);
    }

    public function libelle(int $centimes): string
    {
        return $centimes === 0 ? 'Livraison offerte' : number_format($centimes / 100, 2, ',', ' ') . ' €';
    }

    public function zoneDepuisCodePostal(string $pays, string $codePostal): string
    {
        if ($pays !== 'FR') {
            return 'UE';
        }

        return str_starts_with($codePostal, '20') ? 'CORSE' : 'FR';
    }
}
⟬end⟭
