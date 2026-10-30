⟬template⟭
family: code
format: .ts
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: test fixture, object literal, environment variable, string literal
scenario: Jest unit test of a NestJS checkout service that mocks the Stripe client, written by a back-end developer who pasted the test-mode key from the dashboard
⟬text⟭
import { Test } from "@nestjs/testing";
import Stripe from "stripe";
import { CheckoutService } from "../checkout.service";
import { PanierRepository } from "../panier.repository";

// Clé du compte de test partagé : ne jamais la remplacer par la clé live
process.env.STRIPE_SECRET_KEY = "⟬stripe_secret_key#1⟭";

const clientTest = {
  id: "⟬customer_id#2⟭",
  nom: "⟬person_name#2⟭",
  email: "⟬email#2⟭",
  carte: {
    numero: "⟬payment_card#2⟭",
    cvc: "⟬card_security_code#2⟭",
    expiration: "12/29",
  },
};

describe("CheckoutService", () => {
  let service: CheckoutService;
  const stripeMock = {
    paymentIntents: { create: jest.fn(), confirm: jest.fn() },
  } as unknown as Stripe;

  beforeEach(async () => {
    const module = await Test.createTestingModule({
      providers: [
        CheckoutService,
        { provide: Stripe, useValue: stripeMock },
        { provide: PanierRepository, useValue: { total: jest.fn().mockResolvedValue(4990) } },
      ],
    }).compile();
    service = module.get(CheckoutService);
  });

  it("crée un PaymentIntent en centimes avec l'email du client", async () => {
    (stripeMock.paymentIntents.create as jest.Mock).mockResolvedValue({ id: "pi_test", status: "requires_confirmation" });

    await service.payer("⟬order_number#3⟭", clientTest);

    expect(stripeMock.paymentIntents.create).toHaveBeenCalledWith(
      expect.objectContaining({ amount: 4990, currency: "eur", receipt_email: "⟬email#2⟭" }),
    );
  });

  it("refuse une carte expirée avant d'appeler Stripe", async () => {
    await expect(
      service.payer("⟬order_number#3⟭", { ...clientTest, carte: { ...clientTest.carte, expiration: "01/20" } }),
    ).rejects.toThrow("Carte expirée");
    expect(stripeMock.paymentIntents.create).not.toHaveBeenCalled();
  });
});
⟬end⟭

⟬template⟭
family: code
format: .java
language: fr
fill_locale: fr_FR
domain: logistics
appearance: annotation, string literal, log field, Javadoc
scenario: Spring service of a parcel carrier that emails the recipient when the driver is on the way, with the SendGrid key still hardcoded from the proof of concept
⟬text⟭
package fr.colisexpress.notification;

import com.sendgrid.Method;
import com.sendgrid.Request;
import com.sendgrid.SendGrid;
import com.sendgrid.helpers.mail.Mail;
import com.sendgrid.helpers.mail.objects.Content;
import com.sendgrid.helpers.mail.objects.Email;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

/**
 * Prévient le destinataire que la tournée approche (moins de 30 minutes).
 * Reprise du POC de la semaine 12, à brancher sur le coffre de secrets.
 */
⟬trap:email_lookalike|@Service⟭
public class AvisPassageService {

    private static final Logger LOG = LoggerFactory.getLogger(AvisPassageService.class);
    private static final String CLE_SENDGRID = "⟬sendgrid_api_key#1⟭";
    private static final String EXPEDITEUR = "⟬email:generic#2⟭";

    public void prevenir(Tournee tournee, Colis colis) {
        String texte = String.format(
            "Votre colis %s arrive bientôt. Livreur : %s, véhicule %s. Joignable au %s.",
            colis.getNumero(), tournee.getChauffeur(), tournee.getPlaque(), tournee.getTelephoneChauffeur());

        Mail mail = new Mail(new Email(EXPEDITEUR), "Votre livraison approche",
            new Email(colis.getEmailDestinataire()), new Content("text/plain", texte));
        try {
            Request request = new Request();
            request.setMethod(Method.POST);
            request.setEndpoint("mail/send");
            request.setBody(mail.build());
            new SendGrid(CLE_SENDGRID).api(request);
            LOG.info("avis envoyé colis={} plaque={}", colis.getNumero(), tournee.getPlaque());
        } catch (Exception e) {
            // vu en recette : tournée du ⟬date#1⟭, ⟬person_name#3⟭ dans ⟬fr_license_plate#3⟭, tel ⟬phone#3⟭
            LOG.warn("échec de l'avis de passage pour {}", colis.getNumero(), e);
        }
    }
}
⟬end⟭

⟬template⟭
family: code
format: .php
language: fr
fill_locale: fr_FR
domain: real estate
appearance: array literal, test fixture, comment
scenario: Laravel seeder of a property management agency filling the staging database with landlords and their identity documents
⟬text⟭
<?php

namespace Database\Seeders;

use App\Models\Agence;
use App\Models\Proprietaire;
use Illuminate\Database\Seeder;

class ProprietairesSeeder extends Seeder
{
    /**
     * Données de recette uniquement. Les pièces d'identité servent au test
     * du contrôle KYC avant signature du mandat de gestion.
     */
    public function run(): void
    {
        $agence = Agence::create([
            'raison_sociale' => '⟬company#1⟭',
            'siren' => '⟬fr_siren#1⟭',
            'adresse' => '⟬fr_postal_address#1⟭',
            'standard' => '⟬phone#1⟭',
        ]);

        $proprietaires = [
            [
                'civilite' => 'Mme',
                'nom' => '⟬person_name:family#2f⟭',
                'prenom' => '⟬person_name:given#2⟭',
                'ne_le' => '⟬birth_date#2⟭',
                'piece_type' => 'CNI',
                'piece_numero' => '⟬fr_identity_card#2⟭',
                'mobile' => '⟬phone#2⟭',
                'adresse' => '⟬fr_postal_address#2⟭',
            ],
            [
                'civilite' => 'M.',
                'nom' => '⟬person_name:family#3m⟭',
                'prenom' => '⟬person_name:given#3⟭',
                'ne_le' => '⟬birth_date#3⟭',
                'piece_type' => 'PASSEPORT',
                'piece_numero' => '⟬fr_passport#3⟭',
                'mobile' => '⟬phone#3⟭',
                'adresse' => '⟬fr_postal_address#3⟭',
            ],
        ];

        foreach ($proprietaires as $data) {
            $agence->proprietaires()->save(new Proprietaire($data));
        }
    }
}
⟬end⟭

⟬template⟭
family: code
format: .kt
language: fr
fill_locale: fr_FR
domain: travel
appearance: test fixture, constructor argument, string literal
scenario: Android instrumented test of an airline app checking that the boarding pass screen shows the passport number, with a fake logged-in session
⟬text⟭
package fr.volazur.app.embarquement

import androidx.compose.ui.test.assertIsDisplayed
import androidx.compose.ui.test.junit4.createComposeRule
import androidx.compose.ui.test.onNodeWithText
import fr.volazur.app.session.FakeSessionStore
import org.junit.Rule
import org.junit.Test

class CarteEmbarquementScreenTest {

    @get:Rule
    val compose = createComposeRule()

    private val session = FakeSessionStore(
        jeton = "⟬jwt#1⟭",
        clientId = "⟬customer_id#2⟭",
    )

    private val passager = Passager(
        nom = "⟬person_name:family#2⟭",
        prenom = "⟬person_name:given#2⟭",
        dateNaissance = "⟬birth_date#2⟭",
        passeport = "⟬fr_passport#2⟭",
        nationalite = "FRA",
    )

    @Test
    fun afficheLeNumeroDePasseportSurLaCarte() {
        compose.setContent {
            CarteEmbarquementScreen(
                session = session,
                vol = Vol("VZ", "4417", depart = "ORY", arrivee = "FDF", porte = "B12"),
                passager = passager,
            )
        }
        compose.onNodeWithText("⟬fr_passport#2⟭").assertIsDisplayed()
        compose.onNodeWithText("Groupe 3").assertIsDisplayed()
    }
}
⟬end⟭

⟬template⟭
family: code
format: .js
language: fr
fill_locale: fr_FR
domain: telecom
appearance: comment, function call
scenario: Express middleware of a mobile operator's customer API, where a developer left a captured bearer token in a comment while debugging an expiry bug
⟬text⟭
const jwt = require("jsonwebtoken");
// reproduit le 401 en boucle de l'appli mobile, token récupéré dans ⟬trap:library|Charles⟭ :
// ⟬jwt#1⟭
// -> exp dépassé de 2 s mais l'horloge du serveur RA-03 avance
module.exports = function verifierJeton(req, res, next) {
  const entete = req.headers.authorization || "";
  const jeton = entete.replace(/^Bearer /, "");
  try {
    req.abonne = jwt.verify(jeton, process.env.JWT_PUBLIC_KEY, { algorithms: ["RS256"], clockTolerance: 5 });
    return next();
  } catch (err) {
    return res.status(401).json({ erreur: "jeton_invalide" });
  }
};
⟬end⟭

⟬template⟭
family: code
format: .ts
language: fr
fill_locale: fr_FR
domain: education
appearance: object literal, comment, URL
scenario: Angular environment file of a school canteen booking portal, committed with the Maps key restricted to the production domain
⟬text⟭
// Généré par ng new puis complété à la main, voir ⟬ticket_id#1⟭
export const environment = {
  production: true,
  apiUrl: "https://⟬hostname#1⟭/api/v2",
  googleMapsApiKey: "⟬google_api_key#1⟭",
  stripePublishableKey: "⟬stripe_publishable_key#1⟭",
  sentryDsn: "⟬url#2⟭",
  ⟬trap:indicator_non_pii|sessionTokenTtlMinutes: 30⟭,
  ⟬trap:indicator_non_pii|motDePasseLongueurMin: 12⟭,
  version: "⟬version#1⟭",
};
⟬end⟭

⟬template⟭
family: code
format: .java
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: test fixture, builder call, assertion string, Javadoc
scenario: JUnit test of the PDF invoice generator of a furniture web shop, written by a developer who copied a real-looking order from the staging back office
⟬text⟭
package fr.mobilia.facturation;

import static org.assertj.core.api.Assertions.assertThat;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.text.PDFTextStripper;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

/**
 * Vérifie les mentions obligatoires de la facture : SIREN du vendeur,
 * adresse de facturation, TVA par ligne, et le masquage de la carte.
 */
class GenerateurFactureTest {

    private GenerateurFacture generateur;
    private Commande commande;

    @BeforeEach
    void preparer() {
        Vendeur vendeur = Vendeur.builder()
            .raisonSociale("⟬company#1⟭")
            .siren("⟬fr_siren#1⟭")
            .adresse("⟬fr_postal_address#1⟭")
            .build();

        Client client = Client.builder()
            .reference("⟬customer_id#2⟭")
            .nomComplet("⟬person_name#2⟭")
            .email("⟬email#2⟭")
            .adresseFacturation("⟬fr_postal_address#2⟭")
            .build();

        Paiement paiement = Paiement.carte("⟬payment_card#2⟭", "Visa", LocalDate.parse("2028-04-30"));

        commande = Commande.builder()
            .numero("⟬order_number#3⟭")
            .date(LocalDate.parse("2026-09-14"))
            .vendeur(vendeur)
            .client(client)
            .paiement(paiement)
            .lignes(List.of(
                new Ligne("CANAPE-3P-VELOURS-⟬trap:word_name|ROSE⟭", 1, new BigDecimal("899.00"), Tva.NORMALE),
                new Ligne("COUSSIN-45-LIN", 4, new BigDecimal("24.90"), Tva.NORMALE),
                new Ligne("LIVRAISON-ETAGE", 1, new BigDecimal("49.00"), Tva.NORMALE)))
            .build();

        generateur = new GenerateurFacture(new GabaritFacture("factures/standard.ftl"));
    }

    @Test
    void lesMentionsLegalesSontPresentes() throws Exception {
        String texte = texteDe(generateur.generer(commande));

        assertThat(texte).contains("SIREN ⟬fr_siren#1⟭");
        assertThat(texte).contains("⟬fr_postal_address#2⟭");
        assertThat(texte).contains("Total TTC : 1 047,60 €");
    }

    @Test
    void leNumeroDeCarteEstMasque() throws Exception {
        String texte = texteDe(generateur.generer(commande));

        assertThat(texte).doesNotContain("⟬payment_card#2⟭");
        assertThat(texte).containsPattern("\\*{4} \\*{4} \\*{4} \\d{4}");
    }

    @Test
    void laFactureEstNumeroteeDansLOrdre() throws Exception {
        Commande suivante = commande.toBuilder().numero("⟬order_number#4⟭").build();

        Facture premiere = generateur.facturer(commande);
        Facture seconde = generateur.facturer(suivante);

        assertThat(seconde.numero()).isGreaterThan(premiere.numero());
    }

    @Test
    void uneRemiseApparaitSurUneLigneSeparee() throws Exception {
        Commande remisee = commande.toBuilder().codePromo("BIENVENUE10").build();

        String texte = texteDe(generateur.generer(remisee));

        assertThat(texte).contains("Remise BIENVENUE10");
        assertThat(texte).contains("-104,76");
    }

    private static String texteDe(byte[] pdf) throws Exception {
        try (PDDocument document = PDDocument.load(pdf)) {
            return new PDFTextStripper().getText(document);
        }
    }
}
⟬end⟭

⟬template⟭
family: code
format: .php
language: fr
fill_locale: fr_FR
domain: telecom
appearance: function call, SQL WHERE, string literal, comment, HTTP header
scenario: legacy PHP page of a regional mobile operator activating SIM cards in shops, maintained for ten years with credentials and a test subscriber inline
⟬text⟭
<?php
// activation_sim.php - utilisé par les boutiques (formulaire activation.html)
// derniere modif : ⟬person_name:initial#1⟭ le ⟬date#1⟭, ajout du paiement de la 1ere facture
// TODO passer en PDO un jour...

require_once 'inc/config.php';
require_once 'vendor/autoload.php';

$db = mysqli_connect('⟬hostname#2⟭', 'activ_sim', '⟬password#2⟭', 'crm_mobile');
if (!$db) {
    die('connexion BDD impossible');
}
mysqli_set_charset($db, 'utf8');

\Stripe\Stripe::setApiKey('⟬stripe_secret_key#3⟭');

$iccid   = trim($_POST['iccid']);
$nom     = trim($_POST['nom']);
$prenom  = trim($_POST['prenom']);
$cni     = strtoupper(trim($_POST['num_piece']));
$naiss   = $_POST['date_naissance'];
$msisdn  = $_POST['numero_attribue'];
$adresse = $_POST['adresse'];

// mode test boutique pilote : si le vendeur saisit TEST on prend l'abonné fictif
if ($_POST['mode'] == 'TEST') {
    $nom     = '⟬person_name:family#4⟭';
    $prenom  = '⟬person_name:given#4⟭';
    $cni     = '⟬fr_identity_card#4⟭';
    $naiss   = '⟬birth_date#4⟭';
    $msisdn  = '⟬phone#4⟭';
    $adresse = '⟬fr_postal_address#4⟭';
}

// controle piece d'identite deja utilisee (max 5 lignes par CNI, regle ARCEP)
$res = mysqli_query($db, "SELECT COUNT(*) AS nb FROM lignes WHERE num_piece = '" . mysqli_real_escape_string($db, $cni) . "'");
$row = mysqli_fetch_assoc($res);
if ($row['nb'] >= 5) {
    echo '<p class="erreur">Trop de lignes pour cette piece d\'identite.</p>';
    exit;
}

// verif age
$age = (int) date_diff(date_create($naiss), date_create('today'))->y;
if ($age < 18) {
    echo '<p class="erreur">Client mineur : formulaire parental obligatoire.</p>';
    exit;
}

mysqli_query($db, sprintf(
    "INSERT INTO lignes (iccid, msisdn, nom, prenom, num_piece, date_naissance, adresse, statut) VALUES ('%s','%s','%s','%s','%s','%s','%s','ACTIVE')",
    mysqli_real_escape_string($db, $iccid),
    mysqli_real_escape_string($db, $msisdn),
    mysqli_real_escape_string($db, $nom),
    mysqli_real_escape_string($db, $prenom),
    mysqli_real_escape_string($db, $cni),
    mysqli_real_escape_string($db, $naiss),
    mysqli_real_escape_string($db, $adresse)
));

// premiere facture (frais d'activation 10 EUR)
$intent = \Stripe\PaymentIntent::create([
    'amount' => 1000,
    'currency' => 'eur',
    'payment_method' => $_POST['pm_id'],
    'confirm' => true,
    'description' => 'Activation ' . $msisdn,
]);

// mail de bienvenue via SendGrid (pas de lib, curl direct)
$ch = curl_init('https://api.sendgrid.com/v3/mail/send');
curl_setopt($ch, CURLOPT_HTTPHEADER, [
    'Authorization: Bearer ⟬sendgrid_api_key#5⟭',
    'Content-Type: application/json',
]);
curl_setopt($ch, CURLOPT_POST, true);
curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode([
    'personalizations' => [['to' => [['email' => $_POST['email']]]]],
    'from' => ['email' => '⟬email:generic#6⟭'],
    'subject' => 'Bienvenue, votre ligne ' . $msisdn . ' est active',
    'content' => [['type' => 'text/plain', 'value' => "Bonjour $prenom,\nVotre ligne est active."]],
]));
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_exec($ch);
curl_close($ch);

echo '<p class="ok">Ligne ' . htmlspecialchars($msisdn) . ' activee.</p>';
// en cas de souci appeler le support N2 au ⟬phone#7⟭ (⟬person_name#7⟭)
⟬end⟭

⟬template⟭
family: code
format: .kt
language: fr
fill_locale: fr_FR
domain: logistics
appearance: HTTP header, companion object constant, string literal
scenario: Retrofit client of a delivery drivers' Android app, where a developer hardcoded a token and the test van to skip the login screen
⟬text⟭
package fr.tourneo.chauffeur.reseau

import okhttp3.Interceptor
import okhttp3.OkHttpClient
import retrofit2.Retrofit
import retrofit2.converter.moshi.MoshiConverterFactory

object ApiTournees {

    // raccourci debug : évite l'écran de connexion sur l'émulateur
    private const val JETON_DEBUG = "⟬jwt#1⟭"
    private const val VEHICULE_DEBUG = "⟬fr_license_plate#2⟭"
    const val CLE_MAPS = "⟬google_api_key#3⟭"

    private val entetes = Interceptor { chaine ->
        val requete = chaine.request().newBuilder()
            .header("Authorization", "Bearer $JETON_DEBUG")
            .header("X-Vehicule", VEHICULE_DEBUG)
            .build()
        chaine.proceed(requete)
    }

    val service: TourneesService = Retrofit.Builder()
        .baseUrl("https://⟬hostname#4⟭/")
        .client(OkHttpClient.Builder().addInterceptor(entetes).build())
        .addConverterFactory(MoshiConverterFactory.create())
        .build()
        .create(TourneesService::class.java)
}
⟬end⟭

⟬template⟭
family: code
format: .js
language: fr
fill_locale: fr_FR
domain: travel
appearance: mock handler, nested JSON, string literal, comparison
scenario: Mock Service Worker handlers for the front end of a coach and ferry booking site, simulating a booking lookup and a declined card
⟬text⟭
import { http, HttpResponse, delay } from "msw";

// Réservation de démo utilisée par les maquettes et les tests Playwright
const reservation = {
  reference: "⟬order_number#1⟭",
  trajet: { depart: "⟬city#2⟭", arrivee: "⟬city#3⟭", date: "⟬date#1⟭" },
  titulaire: {
    nom: "⟬person_name#4⟭",
    email: "⟬email#4⟭",
    telephone: "⟬phone#4⟭",
  },
  passagers: [
    { nom: "⟬person_name#4⟭", ne_le: "⟬birth_date#4⟭", passeport: "⟬fr_passport#4⟭" },
    { nom: "⟬person_name#5⟭", ne_le: "⟬birth_date#5⟭", passeport: "⟬fr_passport#5⟭" },
  ],
};

export const handlers = [
  http.get("/api/reservations/:ref", ({ params }) => {
    if (params.ref !== reservation.reference) {
      return HttpResponse.json({ code: "RESA_INCONNUE" }, { status: 404 });
    }
    return HttpResponse.json(reservation);
  }),

  http.post("/api/paiements", async ({ request }) => {
    const corps = await request.json();
    await delay(400);
    // carte de test qui doit toujours être refusée (scénario "fonds insuffisants")
    if (corps.numeroCarte === "⟬payment_card#6⟭" && corps.cvc === "⟬card_security_code#6⟭") {
      return HttpResponse.json({ statut: "refuse", motif: "fonds_insuffisants" }, { status: 402 });
    }
    return HttpResponse.json({ statut: "accepte", autorisation: "⟬opaque_token#7⟭" });
  }),
];
⟬end⟭

⟬template⟭
family: code
format: .ts
language: fr
fill_locale: fr_FR
domain: real estate
appearance: JSDoc, type definition
scenario: shared TypeScript type of a rental application file, documented with an example taken from a real-looking applicant
⟬text⟭
/**
 * Dossier de candidature locataire, tel que renvoyé par GET /dossiers/:id.
 *
 * @example
 * {
 *   candidat: "⟬person_name#1⟭",
 *   contact: "⟬email#1⟭ / ⟬phone#1⟭",
 *   pieceIdentite: { type: "CNI", numero: "⟬fr_identity_card#1⟭" },
 *   revenusMensuels: 2850,
 *   garant: { nom: "⟬person_name#2⟭", telephone: "⟬phone#2⟭" }
 * }
 */
export interface DossierLocataire {
  candidat: string;
  contact: string;
  pieceIdentite: { type: "CNI" | "PASSEPORT" | "TITRE_SEJOUR"; numero: string };
  revenusMensuels: number;
  garant?: { nom: string; telephone: string };
}
⟬end⟭

⟬template⟭
family: code
format: .java
language: fr
fill_locale: fr_FR
domain: telecom
appearance: exception message, log field, string literal, unit test
scenario: Spring Batch processor of a telecom operator that validates number-porting requests, with a regression test reproducing a production incident
⟬text⟭
package fr.telcorp.portabilite.batch;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;

import org.junit.jupiter.api.Test;

class DemandePortageProcessorTest {

    private final DemandePortageProcessor processor = new DemandePortageProcessor(new ReferentielOperateurs());

    @Test
    void rejetteUnRioQuiNeCorrespondPasAuNumero() {
        // incident ⟬ticket_id#1⟭ : la demande est passée alors que le RIO venait d'une autre ligne
        DemandePortage demande = new DemandePortage("⟬phone#2⟭", "02P4K7XQ19ZT", "⟬person_name#2⟭");

        PortageRefuseException erreur = assertThrows(PortageRefuseException.class, () -> processor.process(demande));

        assertEquals("RIO incohérent pour ⟬phone#2⟭ (titulaire ⟬person_name#2⟭)", erreur.getMessage());
    }

    @Test
    void accepteUneLigneProDeLEntreprise() throws Exception {
        DemandePortage demande = DemandePortage.professionnelle("⟬phone#3⟭", "02E8B1MM44KA", "⟬fr_siren#3⟭");

        assertEquals(StatutPortage.TRANSMIS, processor.process(demande).statut());
    }

    @Test
    void ignoreLesNumerosCourtsDeService() throws Exception {
        DemandePortage demande = new DemandePortage("3179", "", "SERVICE");

        assertEquals(StatutPortage.IGNORE, processor.process(demande).statut());
    }
}
⟬end⟭

⟬template⟭
family: code
format: .js
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: Cypress command, HTTP header, form input, string literal
scenario: Cypress end-to-end test of a cosmetics shop checkout, which seeds a customer through the Stripe API before filling the payment form
⟬text⟭
/// <reference types="cypress" />

const acheteuse = {
  prenom: "⟬person_name:given#1f⟭",
  nom: "⟬person_name:family#1⟭",
  email: "⟬email#1⟭",
  telephone: "⟬phone#1⟭",
  adresse: "⟬fr_postal_address:street#1⟭",
  codePostal: "⟬postcode#1⟭",
  ville: "⟬city#1⟭",
};

describe("Tunnel de commande", () => {
  before(() => {
    // crée le client côté Stripe pour que le webhook trouve un customer existant
    cy.request({
      method: "POST",
      url: "https://api.stripe.com/v1/customers",
      headers: { Authorization: "Bearer ⟬stripe_secret_key#2⟭" },
      form: true,
      body: { email: acheteuse.email, name: `${acheteuse.prenom} ${acheteuse.nom}` },
    });
  });

  it("paie une commande avec la carte de test", () => {
    cy.visit("/produits/serum-eclat-30ml");
    cy.contains("Ajouter au panier").click();
    cy.get("[data-cy=panier]").click();
    cy.contains("Commander").click();

    cy.get("#prenom").type(acheteuse.prenom);
    cy.get("#nom").type(acheteuse.nom);
    cy.get("#email").type(acheteuse.email);
    cy.get("#tel").type(acheteuse.telephone);
    cy.get("#adresse").type(acheteuse.adresse);
    cy.get("#cp").type(acheteuse.codePostal);
    cy.get("#ville").type(acheteuse.ville);

    cy.getStripeElement("cardNumber").type("⟬payment_card#3⟭");
    cy.getStripeElement("cardExpiry").type("0430");
    cy.getStripeElement("cardCvc").type("⟬card_security_code#3⟭");

    cy.contains("Payer").click();
    cy.url({ timeout: 15000 }).should("include", "/confirmation");
    cy.contains("Merci pour votre commande").should("be.visible");
  });
});
⟬end⟭

⟬template⟭
family: code
format: .kt
language: fr
fill_locale: fr_FR
domain: education
appearance: KDoc, string literal, constructor argument
scenario: Spring Boot service in Kotlin of a music conservatory sending enrolment confirmations, written by a freelance developer with the key inline and a teacher named in the KDoc
⟬text⟭
package fr.conservatoire.inscriptions.mail

import com.sendgrid.SendGrid
import com.sendgrid.helpers.mail.Mail
import com.sendgrid.helpers.mail.objects.Content
import com.sendgrid.helpers.mail.objects.Email
import org.springframework.stereotype.Service

/**
 * Confirmation d'inscription aux cours.
 * Le texte a été validé par ⟬person_name#1⟭ (responsable pédagogique),
 * le secrétariat répond au ⟬phone#2⟭ du lundi au vendredi.
 */
@Service
class ConfirmationInscriptionMailer {

    private val client = SendGrid("⟬sendgrid_api_key#3⟭")

    fun envoyer(eleve: Eleve, cours: Cours) {
        val corps = """
            Bonjour,
            L'inscription de ${eleve.prenom} au cours de ${cours.instrument} (${cours.niveau}) est confirmée.
            Premier cours le ${cours.debut}, salle ${cours.salle}.
        """.trimIndent()
        val mail = Mail(Email("⟬email:generic#4⟭"), "Inscription confirmée", Email(eleve.emailResponsable), Content("text/plain", corps))
        client.api(mail.toRequest())
    }
}
⟬end⟭

⟬template⟭
family: code
format: .ts
language: fr
fill_locale: fr_FR
domain: logistics
appearance: array literal, comment, function call, URL query string
scenario: one-off ts-node script of a freight broker that geocodes subcontractor depots and links each truck to its carrier before a fleet audit
⟬text⟭
#!/usr/bin/env ts-node
/*
 * Audit flotte sous-traitants, Q3.
 * Lance une fois : npx ts-node scripts/audit-flotte.ts > audit.json
 * Les transporteurs sont identifiés par SIREN, les camions par immatriculation.
 */
import axios from "axios";
import { writeFileSync } from "fs";

const CLE_GEOCODAGE = "⟬google_api_key#1⟭";

type Transporteur = { siren: string; depot: string; contact: string };

const transporteurs: Transporteur[] = [
  { siren: "⟬fr_siren#2⟭", depot: "⟬fr_postal_address#2⟭", contact: "⟬phone#2⟭" },
  { siren: "⟬fr_siren#3⟭", depot: "⟬fr_postal_address#3⟭", contact: "⟬phone#3⟭" },
  { siren: "⟬fr_siren#4⟭", depot: "⟬fr_postal_address#4⟭", contact: "⟬phone#4⟭" },
];

// export du TMS du ⟬date#1⟭, colonnes : plaque, siren, PTAC
const camions: [string, string, number][] = [
  ["⟬fr_license_plate#5⟭", "⟬fr_siren#2⟭", 19],
  ["⟬fr_license_plate#6⟭", "⟬fr_siren#2⟭", 19],
  ["⟬fr_license_plate#7⟭", "⟬fr_siren#3⟭", 44],
  ["⟬fr_license_plate#8⟭", "⟬fr_siren#3⟭", 44],
  ["⟬fr_license_plate#9⟭", "⟬fr_siren#3⟭", 26],
  ["⟬fr_license_plate#10⟭", "⟬fr_siren#4⟭", 12],
];

const PTAC_MAX_PAR_ZONE: Record<string, number> = { urbain: 19, periurbain: 26, longue_distance: 44 };

async function geocoder(adresse: string): Promise<{ lat: number; lng: number } | null> {
  const url = `https://maps.googleapis.com/maps/api/geocode/json?address=${encodeURIComponent(adresse)}&key=${CLE_GEOCODAGE}`;
  const { data } = await axios.get(url);
  if (data.status !== "OK") {
    console.error(`géocodage impossible (${data.status}) pour ${adresse}`);
    return null;
  }
  return data.results[0].geometry.location;
}

function zoneDe(ptac: number): string {
  if (ptac <= PTAC_MAX_PAR_ZONE.urbain) return "urbain";
  if (ptac <= PTAC_MAX_PAR_ZONE.periurbain) return "periurbain";
  return "longue_distance";
}

async function main() {
  const resultat = [];
  for (const t of transporteurs) {
    const position = await geocoder(t.depot);
    const flotte = camions.filter(([, siren]) => siren === t.siren);
    resultat.push({
      siren: t.siren,
      contact: t.contact,
      position,
      camions: flotte.map(([plaque, , ptac]) => ({ plaque, ptac, zone: zoneDe(ptac) })),
    });
  }
  const orphelins = camions.filter(([, siren]) => !transporteurs.some((t) => t.siren === siren));
  if (orphelins.length) {
    console.warn(`${orphelins.length} camion(s) sans transporteur connu`);
  }
  writeFileSync("audit.json", JSON.stringify(resultat, null, 2));
  console.log(`audit écrit : ${resultat.length} transporteurs, ${camions.length} camions`);
}

main().catch((e) => {
  console.error(e);
  process.exit(1);
});
⟬end⟭

⟬template⟭
family: code
format: .ts
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: environment variable, comment, string literal, HTTP header
scenario: Stripe webhook route of a Next.js shop, reviewed before going live, with every secret read from the environment
⟬text⟭
import type { NextApiRequest, NextApiResponse } from "next";
import Stripe from "stripe";
import { buffer } from "micro";
import { marquerCommandePayee, annulerCommande } from "@/lib/commandes";

export const config = { api: { bodyParser: false } };

// Les deux secrets viennent de Vercel. En local : stripe listen --forward-to localhost:3000/api/webhooks/stripe
const stripe = new Stripe(process.env.STRIPE_SECRET_KEY ?? "", { apiVersion: "2024-06-20" });
const secretWebhook = process.env.STRIPE_WEBHOOK_SECRET ?? "⟬trap:placeholder|whsec_xxxxxxxxxxxxxxxx⟭";

// Clé publique côté client, laissée ici pour mémoire : ⟬stripe_publishable_key#1⟭
const ⟬trap:indicator_non_pii|SECRET_HEADER = "stripe-signature"⟭;
const ⟬trap:indicator_non_pii|TOKEN_RETRY_MAX = 3⟭;

export default async function handler(req: NextApiRequest, res: NextApiResponse) {
  if (req.method !== "POST") {
    res.setHeader("Allow", "POST");
    return res.status(405).end();
  }

  let evenement: Stripe.Event;
  try {
    const corps = await buffer(req);
    evenement = stripe.webhooks.constructEvent(corps, req.headers[SECRET_HEADER] as string, secretWebhook);
  } catch (err) {
    console.warn("signature webhook invalide", (err as Error).message);
    return res.status(400).send("signature invalide");
  }

  switch (evenement.type) {
    case "payment_intent.succeeded": {
      const intent = evenement.data.object as Stripe.PaymentIntent;
      await marquerCommandePayee(intent.metadata.commande, intent.id);
      break;
    }
    case "payment_intent.payment_failed":
    case "payment_intent.canceled": {
      const intent = evenement.data.object as Stripe.PaymentIntent;
      await annulerCommande(intent.metadata.commande, evenement.type, { tentativesMax: TOKEN_RETRY_MAX });
      break;
    }
    default:
      // les autres événements sont ignorés mais acquittés pour éviter les relances
      break;
  }
  return res.json({ recu: true });
}
⟬end⟭

⟬template⟭
family: code
format: .java
language: fr
fill_locale: fr_FR
domain: logistics
appearance: annotation, property placeholder, Javadoc, import
scenario: Spring Security configuration of a warehouse management API, written by the tech lead with the JWT secret injected from Vault
⟬text⟭
package fr.entrepot.wms.securite;

import com.fasterxml.⟬trap:library|jackson⟭.databind.ObjectMapper;
import io.jsonwebtoken.security.Keys;
import javax.crypto.SecretKey;
import java.nio.charset.StandardCharsets;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

/**
 * Sécurité de l'API WMS : jetons signés HS256, sans session.
 * Le secret est fourni par Vault au démarrage (chemin secret/wms/jwt).
 */
⟬trap:email_lookalike|@Configuration⟭
public class SecuriteConfig {

    @Value("⟬trap:placeholder|${wms.jwt.secret}⟭")
    private String secretJwt;

    @Value("${wms.jwt.duree-minutes:30}")
    private long dureeJetonMinutes;

    ⟬trap:indicator_non_pii|private static final String TOKEN_PREFIX = "Bearer "⟭;

    @Bean
    public SecretKey cleSignature() {
        return Keys.hmacShaKeyFor(secretJwt.getBytes(StandardCharsets.UTF_8));
    }

    @Bean
    public FiltreJwt filtreJwt(SecretKey cle, ObjectMapper mapper) {
        return new FiltreJwt(cle, mapper, TOKEN_PREFIX, dureeJetonMinutes);
    }

    @Bean
    public SecurityFilterChain chaine(HttpSecurity http, FiltreJwt filtre) throws Exception {
        http.csrf(csrf -> csrf.disable())
            .sessionManagement(s -> s.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
            .authorizeHttpRequests(auth -> auth
                .requestMatchers("/actuator/health", "/auth/connexion").permitAll()
                .requestMatchers("/admin/**").hasRole("CHEF_QUAI")
                .anyRequest().authenticated())
            .addFilterBefore(filtre, UsernamePasswordAuthenticationFilter.class);
        return http.build();
    }
}
⟬end⟭

⟬template⟭
family: code
format: .php
language: fr
fill_locale: fr_FR
domain: education
appearance: array literal, validation rule, comment
scenario: Laravel form request validating a student registration form of a vocational school, with messages in French
⟬text⟭
<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class InscriptionEtudiantRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'nom' => ['required', 'string', 'max:80'],
            'prenom' => ['required', 'string', 'max:80'],
            'email' => ['required', 'email:rfc,dns', 'unique:etudiants,email'],
            'telephone' => ['required', 'regex:/^(\+33|0)[67]\d{8}$/'],
            ⟬trap:indicator_non_pii|'date_naissance' => ['required', 'date_format:Y-m-d', 'before:-16 years']⟭,
            'numero_ine' => ['nullable', 'alpha_num', 'size:11'],
            'formation' => ['required', 'exists:formations,code'],
        ];
    }

    public function messages(): array
    {
        return [
            'telephone.regex' => 'Le numéro doit être un mobile français.',
            'date_naissance.before' => 'L\'âge minimum est de 16 ans.',
            // le libellé reprend la charte de l'école (pas de majuscules)
            'formation.exists' => 'cette formation n\'est plus ouverte aux inscriptions.',
        ];
    }
}
⟬end⟭

⟬template⟭
family: code
format: .kt
language: fr
fill_locale: fr_FR
domain: travel
appearance: unit test, string literal, KDoc
scenario: JVM unit test of the fuzzy station search of a rail booking app, covering typos and homonymous town names
⟬text⟭
package fr.railgo.recherche

import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Test

/**
 * Recherche approchée des gares : distance de ⟬trap:eponym|Levenshtein⟭ bornée à 2,
 * puis tri par fréquentation pour départager les homonymes.
 */
class RechercheGareTest {

    private val gares = listOf(
        Gare("FRNCY", "⟬trap:word_name|Nancy⟭ Ville", frequentation = 9_800_000),
        Gare("FRVAL", "Valence TGV", frequentation = 2_100_000),
        Gare("FRVLV", "Valence Ville", frequentation = 1_700_000),
        Gare("FRALB", "⟬trap:word_name|Albert⟭", frequentation = 180_000),
        Gare("FRSTP", "Saint-⟬trap:word_name|Pierre⟭-des-Corps", frequentation = 3_400_000),
    )
    private val recherche = RechercheGare(gares)

    @Test
    fun trouveMalgreUneFaute() {
        assertEquals("FRNCY", recherche.meilleure("nancyy ville")?.code)
    }

    @Test
    fun departageLesHomonymesParFrequentation() {
        assertEquals(listOf("FRVAL", "FRVLV"), recherche.toutes("valence").map { it.code })
    }

    @Test
    fun ignoreLesAccentsEtLesTirets() {
        assertEquals("FRSTP", recherche.meilleure("st pierre des corps")?.code)
    }

    @Test
    fun neRenvoieRienAuDelaDeDeuxFautes() {
        assertEquals(null, recherche.meilleure("alpert ville"))
    }
}
⟬end⟭

⟬template⟭
family: code
format: .js
language: fr
fill_locale: fr_FR
domain: telecom
appearance: environment variable, HTTP header, comment, check
scenario: k6 load test of an SMS gateway written by the performance team before a marketing campaign, reading every credential from the environment
⟬text⟭
// Test de charge de la passerelle SMS avant la campagne de rentrée.
// Lancement : k6 run -e API_TOKEN=... -e CIBLE=recette sms-charge.js
// Les numéros envoyés sont ceux de la plage de test réservée par l'opérateur.

import http from "k6/http";
import { check, sleep } from "k6";
import { Rate, Trend } from "k6/metrics";

const CIBLES = {
  recette: "https://⟬hostname#1⟭",
  preprod: "https://⟬hostname#2⟭",
};

const BASE = CIBLES[__ENV.CIBLE || "recette"];
const JETON = __ENV.API_TOKEN || "⟬trap:placeholder|<API_TOKEN>⟭";
const ⟬trap:indicator_non_pii|EXPEDITEUR = "INFO-RESEAU"⟭;
const ⟬trap:indicator_non_pii|user = "loadtest"⟭;

const tauxErreur = new Rate("sms_en_erreur");
const latenceAcceptation = new Trend("sms_latence_acceptation", true);

export const options = {
  scenarios: {
    montee: {
      executor: "ramping-arrival-rate",
      startRate: 50,
      timeUnit: "1s",
      preAllocatedVUs: 200,
      maxVUs: 800,
      stages: [
        { target: 200, duration: "2m" },
        { target: 800, duration: "5m" },
        { target: 800, duration: "10m" },
        { target: 0, duration: "1m" },
      ],
    },
  },
  thresholds: {
    sms_en_erreur: ["rate<0.01"],
    sms_latence_acceptation: ["p(95)<400"],
    http_req_failed: ["rate<0.02"],
  },
};

// plage de test réservée par l'opérateur (préfixe 063998), jamais attribuée à un abonné
function numeroDeTest() {
  const suffixe = String(Math.floor(Math.random() * 10000)).padStart(4, "0");
  return `+3363998${suffixe}`;
}

export default function () {
  const corps = JSON.stringify({
    expediteur: EXPEDITEUR,
    destinataire: numeroDeTest(),
    texte: "Maintenance réseau prévue cette nuit entre 2h et 4h.",
    compte: user,
  });

  const reponse = http.post(`${BASE}/v1/sms`, corps, {
    headers: {
      "Content-Type": "application/json",
      Authorization: `Bearer ${JETON}`,
      "X-Campagne": "rentree-charge",
    },
    tags: { route: "envoi_sms" },
  });

  const ok = check(reponse, {
    "accepté (202)": (r) => r.status === 202,
    "identifiant renvoyé": (r) => !!r.json("id"),
  });
  tauxErreur.add(!ok);
  latenceAcceptation.add(reponse.timings.duration);

  sleep(Math.random() * 0.2);
}

export function handleSummary(data) {
  return {
    "resultats/sms-charge.json": JSON.stringify(data, null, 2),
  };
}
⟬end⟭
