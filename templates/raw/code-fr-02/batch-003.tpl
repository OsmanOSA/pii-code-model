⟬template⟭
family: code
format: .php
language: fr
fill_locale: fr_FR
domain: logistics
appearance: heredoc, CSV cell, assertion
scenario: PHPUnit feature test of a Laravel job that imports the proof-of-delivery file a subcontracted carrier drops on SFTP, using an extract pasted from a real drop
⟬text⟭
<?php

namespace Tests\Feature\Import;

use App\Jobs\ImporterPreuvesLivraison;
use App\Models\Livraison;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\Storage;
use Tests\TestCase;

class ImporterPreuvesLivraisonTest extends TestCase
{
    use RefreshDatabase;

    // Extrait du fichier déposé par le sous-traitant le ⟬date#1⟭ (pas de ligne d'en-tête chez eux)
    private const CSV = <<<CSV
⟬order_number#2⟭;⟬date#1⟭ 09:42;"⟬person_name#3⟭";⟬phone#3⟭;"⟬fr_postal_address#3⟭";⟬fr_license_plate#4⟭;LIVRE
⟬order_number#5⟭;⟬date#1⟭ 10:15;"⟬person_name#6⟭";⟬phone#6⟭;"⟬fr_postal_address#6⟭";⟬fr_license_plate#4⟭;ABSENT
⟬order_number#7⟭;⟬date#1⟭ 11:03;"⟬person_name#8⟭";⟬phone#8⟭;"⟬fr_postal_address#8⟭";⟬fr_license_plate#4⟭;LIVRE_VOISIN
CSV;

    public function test_les_trois_statuts_sont_importes(): void
    {
        Storage::fake('sftp');
        Storage::disk('sftp')->put('entrant/preuves_'.date('Ymd').'.csv', self::CSV);

        (new ImporterPreuvesLivraison('sftp', 'entrant'))->handle();

        $this->assertSame(3, Livraison::count());
        $this->assertSame('ABSENT', Livraison::where('numero', '⟬order_number#5⟭')->value('statut'));
        $this->assertDatabaseHas('livraisons', ['numero' => '⟬order_number#7⟭', 'telephone_destinataire' => '⟬phone#8⟭']);
    }

    public function test_une_ligne_incomplete_est_ignoree(): void
    {
        Storage::fake('sftp');
        Storage::disk('sftp')->put('entrant/preuves.csv', "⟬order_number#9⟭;;;;;;LIVRE\n");

        (new ImporterPreuvesLivraison('sftp', 'entrant'))->handle();

        $this->assertSame(0, Livraison::count());
    }
}
⟬end⟭

⟬template⟭
family: code
format: .java
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: log line, comment, log call
scenario: exception handler of a shop's payment controller, where a developer pasted the production log line that showed the logging was far too verbose
⟬text⟭
@ExceptionHandler(PaiementRefuseException.class)
public ResponseEntity<ErreurApi> paiementRefuse(PaiementRefuseException e, HttpServletRequest req) {
    // FIXME log beaucoup trop bavard, vu en prod le ⟬date#1⟭ :
    // WARN  c.b.p.ControleurPaiement - refus banque carte=⟬payment_card#2⟭ cvv=⟬card_security_code#2⟭ client=⟬email#2⟭ motif=51
    log.warn("refus banque carte={} cvv={} client={} motif={}", e.getCarte(), e.getCvv(), e.getEmailClient(), e.getMotif());
    return ResponseEntity.status(HttpStatus.PAYMENT_REQUIRED)
        .body(new ErreurApi("PAIEMENT_REFUSE", "Votre banque a refusé le paiement."));
}
⟬end⟭

⟬template⟭
family: code
format: .ts
language: fr
fill_locale: fr_FR
domain: telecom
appearance: environment variable fallback, exception message, template literal, comment
scenario: Express route of an MVNO selling eSIMs online, which charges the customer and emails the activation QR code, with a Sentry error pasted under it
⟬text⟭
import Stripe from "stripe";
import sgMail from "@sendgrid/mail";
import QRCode from "qrcode";
import { Router } from "express";
import { verifierIdentite } from "./kyc";

const stripe = new Stripe(process.env.STRIPE_SK ?? "⟬stripe_secret_key#1⟭");
sgMail.setApiKey(process.env.SENDGRID_API_KEY ?? "⟬sendgrid_api_key#2⟭");

export class EsimRefuseeError extends Error {}

export const esimRouter = Router();

esimRouter.post("/esim/commandes", async (req, res) => {
  const { email, numero, pieceIdentite, paymentMethodId, matchingId } = req.body;
  const kyc = await verifierIdentite(pieceIdentite);
  if (!kyc.valide) {
    throw new EsimRefuseeError(`KYC refusé pour ${numero} (pièce ${pieceIdentite}) : ${kyc.motif}`);
  }
  await stripe.paymentIntents.create({ amount: 1500, currency: "eur", payment_method: paymentMethodId, confirm: true });
  const activation = `LPA:1$${process.env.SMDP_HOST}$${matchingId}`;
  const qr = await QRCode.toDataURL(activation);
  await sgMail.send({
    to: email,
    from: "⟬email:generic#3⟭",
    subject: "Votre eSIM est prête",
    html: `<p>Scannez ce code pour installer la ligne ${numero} :</p><img src="${qr}" alt="QR code eSIM">`,
  });
  res.status(201).json({ statut: "envoyee" });
});

// Ticket ⟬ticket_id#4⟭, message remonté tel quel dans Sentry :
// EsimRefuseeError: KYC refusé pour ⟬phone#5⟭ (pièce ⟬fr_identity_card#5⟭) : photo illisible
⟬end⟭

⟬template⟭
family: code
format: .kt
language: fr
fill_locale: fr_FR
domain: travel
appearance: file path, comment, string literal
scenario: WorkManager worker of a tour operator's Android app uploading travel documents, with the manual test values from the emulator left in a comment
⟬text⟭
package fr.voyagesdumonde.app.documents

import android.content.Context
import androidx.work.CoroutineWorker
import androidx.work.WorkerParameters
import com.google.android.libraries.places.api.Places
import okhttp3.MediaType.Companion.toMediaType
import okhttp3.MultipartBody
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.RequestBody.Companion.asRequestBody
import java.io.File

/** Envoie les pièces du dossier voyage (passeport, visa) une fois le réseau revenu. */
class EnvoiDocumentsWorker(context: Context, params: WorkerParameters) : CoroutineWorker(context, params) {

    override suspend fun doWork(): Result {
        val fichier = File(inputData.getString("chemin") ?: return Result.failure())
        if (!fichier.exists()) return Result.failure()
        val dossier = inputData.getString("dossier") ?: return Result.failure()
        val jeton = inputData.getString("jeton") ?: return Result.failure()

        val corps = MultipartBody.Builder().setType(MultipartBody.FORM)
            .addFormDataPart("type", inputData.getString("type") ?: "PASSEPORT")
            .addFormDataPart("numero", inputData.getString("numero").orEmpty())
            .addFormDataPart("fichier", fichier.name, fichier.asRequestBody("application/pdf".toMediaType()))
            .build()
        val requete = Request.Builder()
            .url("https://⟬hostname#1⟭/v1/dossiers/$dossier/pieces")
            .header("Authorization", "Bearer $jeton")
            .post(corps)
            .build()
        return OkHttpClient().newCall(requete).execute().use { if (it.isSuccessful) Result.success() else Result.retry() }
    }
}

// Test manuel sur l'émulateur (adb push puis lancement depuis l'écran debug) :
//   chemin  = /storage/emulated/0/Download/passeport_⟬person_name:handle#2⟭.pdf
//   numero  = ⟬fr_passport#2⟭
//   dossier = ⟬order_number#3⟭
//   jeton   = ⟬jwt#4⟭
object DebugPlaces {
    fun init(context: Context) = Places.initialize(context, "⟬google_api_key#5⟭")
}
⟬end⟭

⟬template⟭
family: code
format: .js
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: JSDoc, curl command
scenario: refund helper of an online bookshop, whose JSDoc keeps the manual curl fallback the support team used during an outage
⟬text⟭
/**
 * Rembourse une commande annulée après expédition.
 * Équivalent manuel si le back-office est en panne :
 *   curl https://api.stripe.com/v1/refunds \
 *     -u ⟬stripe_secret_key#1⟭: \
 *     -d payment_intent=pi_3Nf... \
 *     -d "metadata[commande]=⟬order_number#2⟭"
 */
async function rembourser(stripe, commande) {
  return stripe.refunds.create({ payment_intent: commande.paymentIntentId, metadata: { commande: commande.numero } });
}

module.exports = { rembourser };
⟬end⟭

⟬template⟭
family: code
format: .php
language: fr
fill_locale: fr_FR
domain: real estate
appearance: array literal, Javadoc-style comment, exception message
scenario: Symfony service generating residential leases as PDF, with a sample context for the developer preview route that was filled with a full fictitious file
⟬text⟭
<?php

namespace App\Service\Bail;

use Dompdf\Dompdf;
use Twig\Environment;

/**
 * Génère le bail d'habitation (loi du 6 juillet 1989) au format PDF.
 * Gabarits Twig : templates/bail/vide.html.twig et templates/bail/meuble.html.twig.
 */
final class GenerateurBail
{
    public function __construct(private Environment $twig, private string $dossierSortie)
    {
    }

    public function generer(array $contexte): string
    {
        $this->verifier($contexte);
        $gabarit = ($contexte['meuble'] ?? false) ? 'bail/meuble.html.twig' : 'bail/vide.html.twig';
        $pdf = new Dompdf(['defaultFont' => 'DejaVu Sans']);
        $pdf->loadHtml($this->twig->render($gabarit, $contexte));
        $pdf->setPaper('A4');
        $pdf->render();
        $chemin = sprintf('%s/bail_%s.pdf', $this->dossierSortie, $contexte['reference']);
        file_put_contents($chemin, $pdf->output());

        return $chemin;
    }

    private function verifier(array $contexte): void
    {
        foreach (['bailleur', 'locataires', 'logement', 'loyer'] as $cle) {
            if (empty($contexte[$cle])) {
                throw new \InvalidArgumentException("Bail incomplet : $cle manquant");
            }
        }
        $plafond = $contexte['loyer']['hors_charges'] * (($contexte['meuble'] ?? false) ? 2 : 1);
        if ($contexte['loyer']['depot_garantie'] > $plafond) {
            throw new \InvalidArgumentException('Dépôt de garantie supérieur au plafond légal');
        }
    }

    /**
     * Contexte d'exemple pour la prévisualisation (route /dev/bail). Jamais en production.
     */
    public static function exempleDeContexte(): array
    {
        return [
            'reference' => '⟬order_number#1⟭',
            'date_signature' => '⟬date#1⟭',
            'meuble' => false,
            'bailleur' => [
                'denomination' => '⟬trap:company_name|SCI ⦃Family⦄ Patrimoine⟭',
                'siren' => '⟬fr_siren#2⟭',
                'representant' => '⟬person_name#3⟭',
                'adresse' => '⟬fr_postal_address#2⟭',
                'iban_loyers' => '⟬iban#2⟭',
            ],
            'locataires' => [
                [
                    'civilite' => 'Mme',
                    'nom' => '⟬person_name#4f⟭',
                    'ne_le' => '⟬birth_date#4⟭',
                    'piece' => 'CNI ⟬fr_identity_card#4⟭',
                    'telephone' => '⟬phone#4⟭',
                    'email' => '⟬email#4⟭',
                    'vehicule' => '⟬fr_license_plate#4⟭',
                ],
            ],
            'garant' => [
                'nom' => '⟬person_name#5⟭',
                'piece' => 'Passeport ⟬fr_passport#5⟭',
                'adresse' => '⟬fr_postal_address#5⟭',
                'telephone' => '⟬phone#5⟭',
            ],
            'logement' => [
                'adresse' => '⟬fr_postal_address#6⟭',
                'type' => 'T2',
                'surface' => 41.5,
                'etage' => 3,
                'parking' => 'Place 17, sous-sol -1',
                'dpe' => 'D',
            ],
            'loyer' => [
                'hors_charges' => 720,
                'charges' => 65,
                'depot_garantie' => 720,
                'jour_paiement' => 5,
                'revision' => 'IRL du 2e trimestre',
            ],
        ];
    }
}
⟬end⟭

⟬template⟭
family: code
format: .ts
language: fr
fill_locale: fr_FR
domain: logistics
appearance: constant, URL query string
scenario: small distance matrix helper of a parcel locker network's route planner, with the Maps key kept in a module constant
⟬text⟭
// Matrice de durées entre dépôts et points relais, appelée par le planificateur de tournées.
const CLE = "⟬google_api_key#1⟭";
const BASE = "https://maps.googleapis.com/maps/api/distancematrix/json";

export async function matrice(origines: string[], destinations: string[]): Promise<number[][]> {
  const url = `${BASE}?origins=${origines.map(encodeURIComponent).join("|")}&destinations=${destinations.map(encodeURIComponent).join("|")}&mode=driving&key=${CLE}`;
  const reponse = await fetch(url);
  const json = await reponse.json();
  if (json.status !== "OK") throw new Error(`Distance Matrix : ${json.status}`);
  return json.rows.map((row: any) => row.elements.map((e: any) => e.duration?.value ?? Infinity));
}
⟬end⟭

⟬template⟭
family: code
format: .java
language: fr
fill_locale: fr_FR
domain: education
appearance: text block, nested JSON, HTTP header, constant
scenario: MockMvc integration test of a university student card service, covering an international student and an identity document already used
⟬text⟭
package fr.univ.cartes;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

@SpringBootTest
@AutoConfigureMockMvc
class CarteEtudiantControllerIT {

    @Autowired
    private MockMvc mvc;

    private static final String JETON_SCOLARITE = "⟬jwt#1⟭";

    @Test
    void emetUneCartePourUnEtudiantEtranger() throws Exception {
        String corps = """
            {
              "nom": "⟬person_name:family#2⟭",
              "prenom": "⟬person_name:given#2⟭",
              "dateNaissance": "⟬birth_date#2⟭",
              "email": "⟬email#2⟭",
              "telephone": "⟬phone#2⟭",
              "piece": {"type": "PASSEPORT", "numero": "⟬fr_passport#2⟭"},
              "formation": "M1 Informatique"
            }
            """;

        mvc.perform(post("/api/cartes")
                .header("Authorization", "Bearer " + JETON_SCOLARITE)
                .contentType(MediaType.APPLICATION_JSON)
                .content(corps))
            .andExpect(status().isCreated())
            .andExpect(jsonPath("$.numeroCarte").exists())
            .andExpect(jsonPath("$.photoRequise").value(true));
    }

    @Test
    void refuseUnePieceDejaRattacheeAUnAutreDossier() throws Exception {
        String corps = """
            {"nom": "⟬person_name:family#3⟭", "prenom": "⟬person_name:given#3⟭", "dateNaissance": "⟬birth_date#3⟭",
             "piece": {"type": "CNI", "numero": "⟬fr_identity_card#3⟭"}, "formation": "L2 Droit"}
            """;

        mvc.perform(post("/api/cartes")
                .header("Authorization", "Bearer " + JETON_SCOLARITE)
                .contentType(MediaType.APPLICATION_JSON)
                .content(corps))
            .andExpect(status().isConflict())
            .andExpect(jsonPath("$.code").value("PIECE_DEJA_UTILISEE"));
    }
}
⟬end⟭

⟬template⟭
family: code
format: .kt
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: constructor argument, unit test
scenario: Kotlin unit test making sure the card value class of a checkout module never prints the number or the security code
⟬text⟭
class CarteBancaireTest {

    private val carte = CarteBancaire(numero = "⟬payment_card#1⟭", cryptogramme = "⟬card_security_code#1⟭", expiration = YearMonth.of(2028, 6))

    @Test
    fun `toString ne divulgue ni le numero ni le cryptogramme`() {
        val texte = carte.toString()
        assertFalse(texte.contains(carte.numero))
        assertFalse(texte.contains(carte.cryptogramme))
        assertTrue(texte.startsWith("CarteBancaire(numero=**** **** ****"))
    }
}
⟬end⟭

⟬template⟭
family: code
format: .js
language: fr
fill_locale: fr_FR
domain: education
appearance: environment variable fallback, object literal, comment, command line
scenario: end-of-term script of a secondary school sending report card links to parents through SendGrid dynamic templates
⟬text⟭
// envoi-bulletins.js : fin de trimestre, envoie le lien du bulletin aux responsables légaux
const sgMail = require("@sendgrid/mail");
const bulletins = require("./export/bulletins-t1.json");

sgMail.setApiKey(process.env.SG_KEY || "⟬sendgrid_api_key#1⟭");

// identifiant de template dynamique SendGrid, pas un secret
const MODELE_BULLETIN = "d-4f1c9a7be2d84c0f9a1e6b3c5d7f8a90";
const COLLEGE = {
  nom: "Collège ⟬trap:eponym|Jean Moulin⟭",
  tel: "⟬phone#2⟭",
  adresse: "⟬fr_postal_address#2⟭",
};

async function envoyer() {
  const messages = bulletins.map((b) => ({
    to: b.responsables.map((r) => r.email),
    from: { email: "⟬email:generic#3⟭", name: COLLEGE.nom },
    templateId: MODELE_BULLETIN,
    dynamicTemplateData: { eleve: b.prenom, classe: b.classe, lien: b.lien, college: COLLEGE },
  }));
  for (let i = 0; i < messages.length; i += 500) {
    await sgMail.send(messages.slice(i, i + 500));
  }
  console.log(`${messages.length} envois`);
}

// Essai sur un seul élève avant l'envoi général, demandé par ⟬person_name#4⟭ (CPE) :
// node -e 'require("./envoi-bulletins").essai("⟬person_name:given#5⟭", "⟬email#6⟭")'
async function essai(prenom, email) {
  await sgMail.send({
    to: email,
    from: "⟬email:generic#3⟭",
    templateId: MODELE_BULLETIN,
    dynamicTemplateData: { eleve: prenom, classe: "4e B", lien: "https://⟬hostname#7⟭/bulletins/demo", college: COLLEGE },
  });
}

module.exports = { envoyer, essai };
⟬end⟭

⟬template⟭
family: code
format: .ts
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: Markdown table, test fixture, placeholder, template literal
scenario: Playwright end-to-end test of the click and collect flow of a home appliance retailer, with the test plan kept as a Markdown table in the header comment
⟬text⟭
/**
 * Recette du retrait en magasin (click & collect), campagne de Noël.
 *
 * | Cas | Client           | Mobile      | Carte              | Attendu             |
 * |-----|------------------|-------------|--------------------|---------------------|
 * | 1   | ⟬person_name#1⟭  | ⟬phone#1⟭   | ⟬payment_card#1⟭   | retrait confirmé    |
 * | 2   | ⟬person_name#2⟭  | ⟬phone#2⟭   | ⟬payment_card#2⟭   | 3DS demandé         |
 * | 3   | ⟬person_name#3⟭  | ⟬phone#3⟭   | ⟬payment_card#3⟭   | refus, stock épuisé |
 *
 * Cryptogramme commun aux trois cartes de recette : ⟬card_security_code#1⟭
 */
import { test, expect, Page } from "@playwright/test";

const CLIENTS = [
  { nom: "⟬person_name#1⟭", email: "⟬email#1⟭", tel: "⟬phone#1⟭", carte: "⟬payment_card#1⟭", attendu: "confirme" },
  { nom: "⟬person_name#2⟭", email: "⟬email#2⟭", tel: "⟬phone#2⟭", carte: "⟬payment_card#2⟭", attendu: "3ds" },
  { nom: "⟬person_name#3⟭", email: "⟬email#3⟭", tel: "⟬phone#3⟭", carte: "⟬payment_card#3⟭", attendu: "rupture" },
] as const;
const CVC = "⟬card_security_code#1⟭";
const MAGASIN = "⟬city#4⟭ centre";

async function remplirPaiement(page: Page, carte: string) {
  const cadre = page.frameLocator("iframe[title*=paiement]");
  await cadre.getByPlaceholder("⟬trap:placeholder|1234 1234 1234 1234⟭").fill(carte);
  await cadre.getByPlaceholder("MM / AA").fill("12 / 29");
  await cadre.getByPlaceholder("CVC").fill(CVC);
}

for (const client of CLIENTS) {
  test(`click & collect : ${client.attendu}`, async ({ page }) => {
    await page.goto("/produit/robot-patissier-k5");
    await page.getByRole("button", { name: "Retrait en magasin" }).click();
    await page.getByLabel("Magasin").selectOption({ label: MAGASIN });
    await page.getByRole("button", { name: "Valider le panier" }).click();

    await page.getByLabel("Nom complet").fill(client.nom);
    await page.getByLabel("E-mail").fill(client.email);
    await page.getByLabel("Mobile (SMS de retrait)").fill(client.tel);
    await remplirPaiement(page, client.carte);
    await page.getByRole("button", { name: "Payer" }).click();

    if (client.attendu === "3ds") {
      const defi = page.frameLocator("iframe[name*=challenge]");
      await defi.getByRole("button", { name: "Complete" }).click();
    }
    if (client.attendu === "rupture") {
      await expect(page.getByText("Plus disponible dans ce magasin")).toBeVisible();
      return;
    }
    await expect(page).toHaveURL(/\/commande\/confirmation/);
    await expect(page.getByText(`SMS envoyé au ${client.tel}`)).toBeVisible();
  });
}
⟬end⟭

⟬template⟭
family: code
format: .java
language: fr
fill_locale: fr_FR
domain: telecom
appearance: constant, log call, log line, comment
scenario: scheduled Spring job of an internet provider texting customers about unpaid bills, with the staging run output pasted at the end of the file
⟬text⟭
package fr.telcorp.relance;

import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

@Component
public class RelanceFactureImpayeeJob {

    private static final Logger log = LoggerFactory.getLogger(RelanceFactureImpayeeJob.class);
    // jeton du compte technique de la plateforme SMS, expire en fin d'année (cf. ⟬ticket_id#1⟭)
    private static final String JETON_SMS = "⟬jwt#2⟭";

    private final RestTemplate rest;
    private final FactureRepository factures;

    public RelanceFactureImpayeeJob(RestTemplateBuilder builder, FactureRepository factures) {
        this.rest = builder.rootUri("https://⟬hostname#3⟭").build();
        this.factures = factures;
    }

    @Scheduled(cron = "0 0 10 * * MON-FRI")
    public void relancer() {
        for (Facture f : factures.impayeesDepuis(15)) {
            HttpHeaders entetes = new HttpHeaders();
            entetes.setBearerAuth(JETON_SMS);
            entetes.setContentType(MediaType.APPLICATION_JSON);
            Map<String, String> sms = Map.of(
                "to", f.getMsisdn(),
                "text", "Votre facture " + f.getNumero() + " de " + f.getMontant() + " EUR reste à régler. Payez sur l'appli ou au 3000.");
            try {
                rest.postForEntity("/v2/sms", new HttpEntity<>(sms, entetes), Void.class);
                log.info("relance {} -> {}", f.getNumero(), f.getMsisdn());
            } catch (RestClientException e) {
                log.error("échec relance {} -> {}", f.getNumero(), f.getMsisdn(), e);
            }
        }
    }
}
// Sortie du job en recette le ⟬date#4⟭ :
// INFO  relance ⟬invoice_number#5⟭ -> ⟬phone#5⟭
// INFO  relance ⟬invoice_number#6⟭ -> ⟬phone#6⟭
// ERROR échec relance ⟬invoice_number#7⟭ -> ⟬phone#7⟭
⟬end⟭

⟬template⟭
family: code
format: .php
language: fr
fill_locale: fr_FR
domain: travel
appearance: configuration array, nested array
scenario: production configuration file of a holiday booking engine written in plain PHP, sent by the client to a new agency taking over the project
⟬text⟭
<?php
// config/moteur_resa.php : moteur de réservation de séjours, environnement de production
return [
    'fournisseur_vols' => [
        'client_id' => 'resa-prod-7741',
        'client_secret' => '⟬opaque_token#1⟭',
        'url' => 'https://⟬hostname#2⟭/v1',
    ],
    'cartes' => ['google_maps_key' => '⟬google_api_key#3⟭'],
    'paiement' => ['stripe_secret' => '⟬stripe_secret_key#4⟭', 'stripe_public' => '⟬stripe_publishable_key#4⟭'],
    'mail' => ['sendgrid_key' => '⟬sendgrid_api_key#5⟭', 'expediteur' => '⟬email:generic#6⟭'],
    'facturation' => ['raison_sociale' => '⟬company#7⟭', 'siren' => '⟬fr_siren#7⟭', 'tva' => 0.2],
    ⟬trap:indicator_non_pii|'session' => ['token_ttl' => 1800, 'cookie' => 'resa_sid']⟭,
];
⟬end⟭

⟬template⟭
family: code
format: .kt
language: fr
fill_locale: fr_FR
domain: logistics
appearance: mock stub, URL path variable, JSON path assertion
scenario: Spring WebFlux controller test in Kotlin of a fleet management service that looks up a vehicle's registered keeper and hides private owners
⟬text⟭
package fr.flottepro.immatriculation

import io.mockk.every
import io.mockk.mockk
import org.junit.jupiter.api.Test
import org.springframework.test.web.reactive.server.WebTestClient

class ImmatriculationControllerTest {

    private val siv = mockk<ClientSiv>()
    private val client = WebTestClient.bindToController(ImmatriculationController(siv)).build()

    @Test
    fun `renvoie le titulaire professionnel de la flotte`() {
        every { siv.titulaire("⟬fr_license_plate#1⟭") } returns Titulaire.Societe(siren = "⟬fr_siren#2⟭", raisonSociale = "⟬company#2⟭")

        client.get().uri("/immatriculations/{plaque}", "⟬fr_license_plate#1⟭").exchange()
            .expectStatus().isOk
            .expectBody().jsonPath("$.siren").isEqualTo("⟬fr_siren#2⟭")
    }

    @Test
    fun `masque le titulaire particulier`() {
        every { siv.titulaire("⟬fr_license_plate#3⟭") } returns Titulaire.Particulier(nom = "⟬person_name#4⟭")

        client.get().uri("/immatriculations/{plaque}", "⟬fr_license_plate#3⟭").exchange()
            .expectStatus().isOk
            .expectBody().jsonPath("$.titulaire").isEqualTo("PARTICULIER")
    }

    @Test
    fun `refuse une plaque incomplete`() {
        client.get().uri("/immatriculations/{plaque}", "AB-12").exchange()
            .expectStatus().isBadRequest
    }
}
⟬end⟭

⟬template⟭
family: code
format: .ts
language: fr
fill_locale: fr_FR
domain: real estate
appearance: generated constant, commit trailer
scenario: build information module generated at build time for a rent receipt web app, embedding the last commit with its co-author trailer
⟬text⟭
// Généré par scripts/build-info.mjs au moment du build : ne pas modifier.
export const BUILD_INFO = {
  sha: "⟬git_sha#1⟭",
  branche: "release/⟬version#1⟭",
  date: "⟬date#1⟭",
  auteur: "⟬person_name#2⟭ <⟬email#2⟭>",
  message: "fix(quittances): arrondi des charges au centime\n\nCo-authored-by: ⟬person_name#3⟭ <⟬email#3⟭>",
} as const;
⟬end⟭

⟬template⟭
family: code
format: .java
language: fr
fill_locale: fr_FR
domain: logistics
appearance: annotation, log call, Javadoc, comment
scenario: Kafka consumer of a parcel tracking platform updating the status shown to recipients, written by the tracking team with its connection settings documented in comments
⟬text⟭
package fr.colismart.suivi.consumer;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.micrometer.core.instrument.MeterRegistry;
import java.time.Instant;
import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.kafka.support.Acknowledgment;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

/**
 * Consomme les scans des colis (topic suivi.scans) et met à jour l'état visible par le destinataire.
 * Idempotent : la clé (colis, sequence) est unique en base, un doublon ⟬trap:library|Kafka⟭ est ignoré.
 *
 * Connexion (application-prod.yml) :
 *   bootstrap-servers: ⟬hostname#1⟭:9093,⟬hostname#2⟭:9093
 *   sasl.jaas.config: ... username="suivi-etat" password="⟬trap:placeholder|${KAFKA_PASSWORD}⟭";
 */
@Component
public class ScanConsumer {

    private static final Logger LOG = LoggerFactory.getLogger(ScanConsumer.class);
    ⟬trap:indicator_non_pii|private static final String OWNER = "equipe-suivi-colis"⟭;

    private final ObjectMapper mapper;
    private final EtatColisRepository etats;
    private final MeterRegistry metriques;

    public ScanConsumer(ObjectMapper mapper, EtatColisRepository etats, MeterRegistry metriques) {
        this.mapper = mapper;
        this.etats = etats;
        this.metriques = metriques;
    }

    @KafkaListener(topics = "suivi.scans", groupId = "suivi-etat", concurrency = "6")
    @Transactional
    public void recevoir(ConsumerRecord<String, String> record, Acknowledgment ack) {
        ScanEvenement scan;
        try {
            scan = mapper.readValue(record.value(), ScanEvenement.class);
        } catch (JsonProcessingException e) {
            LOG.warn("scan illisible partition={} offset={}, envoyé en DLT", record.partition(), record.offset());
            metriques.counter("suivi.scans.illisibles", "owner", OWNER).increment();
            throw new ScanIllisibleException(record.offset(), e);
        }

        if (etats.existe(scan.colis(), scan.sequence())) {
            LOG.debug("doublon ignoré colis={} sequence={}", scan.colis(), scan.sequence());
            ack.acknowledge();
            return;
        }

        EtatColis etat = etats.trouver(scan.colis()).orElseGet(() -> EtatColis.nouveau(scan.colis()));
        etat.appliquer(scan.code(), scan.site(), scan.horodatage());
        etats.enregistrer(etat, scan.sequence());

        long retardMs = Instant.now().toEpochMilli() - scan.horodatage().toEpochMilli();
        metriques.timer("suivi.scans.retard").record(java.time.Duration.ofMillis(retardMs));
        LOG.info("colis={} etat={} site={} retard={}ms", scan.colis(), etat.libelle(), scan.site(), retardMs);
        ack.acknowledge();
    }
}
⟬end⟭

⟬template⟭
family: code
format: .php
language: fr
fill_locale: fr_FR
domain: telecom
appearance: migration, column comment
scenario: Laravel migration creating the subscriber and line tables of a mobile operator's sales back office
⟬text⟭
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('abonnes', function (Blueprint $table) {
            $table->id();
            $table->string('civilite', 4)->nullable();
            $table->string('nom', 80);
            $table->string('prenom', 80);
            $table->date('date_naissance')->comment('contrôle de majorité à la souscription');
            $table->string('telephone', 20)->unique()->comment('format E.164, ex. ⟬trap:placeholder|+33XXXXXXXXX⟭');
            $table->string('email')->nullable();
            $table->string('type_piece', 12);
            $table->string('numero_piece', 20)->index();
            $table->text('iban')->nullable()->comment('mandat SEPA, chiffré par le cast encrypted');
            ⟬trap:indicator_non_pii|$table->string('nom_offre', 40)->default('SANS_ENGAGEMENT')⟭;
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('lignes', function (Blueprint $table) {
            $table->id();
            $table->foreignId('abonne_id')->constrained('abonnes');
            $table->string('iccid', 22)->unique();
            $table->string('msisdn', 20)->unique();
            $table->string('rio', 12)->nullable()->comment('relevé d\'identité opérateur, portabilité entrante');
            $table->enum('statut', ['EN_ATTENTE', 'ACTIVE', 'SUSPENDUE', 'RESILIEE'])->default('EN_ATTENTE');
            $table->timestamp('activee_le')->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('lignes');
        Schema::dropIfExists('abonnes');
    }
};
⟬end⟭

⟬template⟭
family: code
format: .kt
language: fr
fill_locale: fr_FR
domain: education
appearance: composable, string literal, placeholder
scenario: Jetpack Compose login screen of a school digital workspace app, written by the regional education IT team
⟬text⟭
package fr.ent.capucine.ui.connexion

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material3.Button
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.text.input.PasswordVisualTransformation
import androidx.compose.ui.unit.dp

@Composable
fun EcranConnexion(etat: EtatConnexion, onConnexion: (String, String) -> Unit) {
    var identifiant by rememberSaveable { mutableStateOf("") }
    var motDePasse by rememberSaveable { mutableStateOf("") }

    Column(Modifier.padding(24.dp), verticalArrangement = Arrangement.spacedBy(12.dp)) {
        Text("ENT ⟬trap:word_name|Capucine⟭", style = MaterialTheme.typography.headlineMedium)
        OutlinedTextField(
            value = identifiant,
            onValueChange = { identifiant = it.trim() },
            label = { Text("Identifiant ou e-mail académique") },
            placeholder = { Text("⟬trap:placeholder|prenom.nom@ac-exemple.fr⟭") },
            keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Email),
        )
        OutlinedTextField(
            value = motDePasse,
            onValueChange = { motDePasse = it },
            label = { Text("Mot de passe") },
            visualTransformation = PasswordVisualTransformation(),
            keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Password),
        )
        if (etat is EtatConnexion.Erreur) {
            Text(etat.message, color = MaterialTheme.colorScheme.error)
        }
        Button(onClick = { onConnexion(identifiant, motDePasse) }, enabled = identifiant.isNotBlank() && motDePasse.length >= 8) {
            Text("Se connecter")
        }
    }
}
⟬end⟭

⟬template⟭
family: code
format: .js
language: fr
fill_locale: fr_FR
domain: travel
appearance: import, environment variable, placeholder
scenario: Vite configuration of a holiday comparison front end, proxying the API in development and injecting the Maps key from the environment
⟬text⟭
// vite.config.js : front du comparateur de séjours
import { defineConfig, loadEnv } from "vite";
import react from "⟬trap:email_lookalike|@vitejs/plugin-react⟭";

export default defineConfig(({ mode }) => {
  const env = loadEnv(mode, process.cwd(), "");
  return {
    plugins: [react()],
    define: { __MAPS_KEY__: JSON.stringify(env.VITE_MAPS_KEY ?? "⟬trap:placeholder|YOUR_MAPS_KEY⟭") },
    server: { port: 5173, proxy: { "/api": `http://⟬hostname#1⟭:8080` } },
  };
});
⟬end⟭

⟬template⟭
family: code
format: .ts
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: JSDoc, function, union type
scenario: client-side card number check of a ticketing shop, written to avoid a round trip to the payment provider on typos
⟬text⟭
/**
 * Contrôle de saisie du numéro de carte avant l'appel au PSP : longueur, réseau, clé de ⟬trap:eponym|Luhn⟭.
 * Ne remplace pas la validation du PSP, évite seulement un aller-retour pour une faute de frappe.
 * Masque d'affichage : ⟬trap:placeholder|4XXX XXXX XXXX XXXX⟭.
 */
export type Reseau = "visa" | "mastercard" | "amex" | "cb" | null;

export function normaliser(saisie: string): string {
  return saisie.replace(/[\s-]/g, "");
}

export function cleLuhnValide(chiffres: string): boolean {
  let somme = 0;
  let doubler = false;
  for (let i = chiffres.length - 1; i >= 0; i--) {
    let n = chiffres.charCodeAt(i) - 48;
    if (n < 0 || n > 9) return false;
    if (doubler) {
      n *= 2;
      if (n > 9) n -= 9;
    }
    somme += n;
    doubler = !doubler;
  }
  return chiffres.length > 0 && somme % 10 === 0;
}

export function reseau(numero: string): Reseau {
  const n = normaliser(numero);
  if (/^4\d{12}(\d{3})?$/.test(n)) return "visa";
  if (/^(5[1-5]\d{14}|2[2-7]\d{14})$/.test(n)) return "mastercard";
  if (/^3[47]\d{13}$/.test(n)) return "amex";
  return null;
}

export function saisieValide(saisie: string): boolean {
  const n = normaliser(saisie);
  return n.length >= 13 && n.length <= 19 && reseau(n) !== null && cleLuhnValide(n);
}
⟬end⟭
