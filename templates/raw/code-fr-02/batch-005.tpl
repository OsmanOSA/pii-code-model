⟬template⟭
family: code
format: .ts
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: object literal, function call, comment
scenario: Sentry setup of a React Native shopping app that pins the developer's test account as the current user in debug builds
⟬text⟭
import * as Sentry from "@sentry/react-native";

Sentry.init({ dsn: "⟬url#1⟭", tracesSampleRate: 0.2, environment: __DEV__ ? "dev" : "prod" });

// en dev on force l'utilisateur de test pour retrouver ses erreurs dans Sentry
if (__DEV__) {
  Sentry.setUser({ id: "⟬customer_id#2⟭", email: "⟬email#2⟭", username: "⟬person_name:handle#2⟭" });
  Sentry.setTag("telephone_test", "⟬phone#2⟭");
}
⟬end⟭

⟬template⟭
family: code
format: .java
language: fr
fill_locale: fr_FR
domain: telecom
appearance: array literal, text block, SQL INSERT, prepared statement
scenario: Flyway Java migration of a mobile operator taking over business fleet accounts from an old extranet, with the extract hardcoded in arrays
⟬text⟭
package db.migration;

import java.sql.PreparedStatement;
import org.flywaydb.core.api.migration.BaseJavaMigration;
import org.flywaydb.core.api.migration.Context;

/**
 * V12 : reprise des comptes flotte professionnelle de l'ancien extranet.
 * Données issues de l'export fourni par l'équipe commerciale le ⟬date#1⟭.
 * Migration Java et non SQL : les IBAN doivent être chiffrés à l'insertion.
 */
public class V12__RepriseFlottesPro extends BaseJavaMigration {

    private static final String[][] COMPTES = {
        {"⟬fr_siren#2⟭", "⟬fr_siret#2⟭", "⟬company#2⟭", "⟬person_name#3⟭", "⟬phone#3⟭", "⟬email#3⟭", "⟬iban#2⟭"},
        {"⟬fr_siren#4⟭", "⟬fr_siret#4⟭", "⟬company#4⟭", "⟬person_name#5⟭", "⟬phone#5⟭", "⟬email#5⟭", "⟬iban#4⟭"},
        {"⟬fr_siren#6⟭", "⟬fr_siret#6⟭", "⟬company#6⟭", "⟬person_name#7⟭", "⟬phone#7⟭", "⟬email#7⟭", "⟬iban#6⟭"},
    };

    // lignes data des boîtiers télématiques, rattachées au premier compte
    private static final String[][] LIGNES_VEHICULES = {
        {"⟬phone#8⟭", "⟬fr_license_plate#8⟭"},
        {"⟬phone#9⟭", "⟬fr_license_plate#9⟭"},
        {"⟬phone#10⟭", "⟬fr_license_plate#10⟭"},
    };

    @Override
    public void migrate(Context context) throws Exception {
        Chiffreur chiffreur = Chiffreur.depuisEnvironnement();
        String sqlCompte = """
            INSERT INTO comptes_pro (siren, siret_facturation, raison_sociale, contact_nom, contact_tel, contact_email, iban_chiffre)
            VALUES (?, ?, ?, ?, ?, ?, ?)
            """;
        try (PreparedStatement ps = context.getConnection().prepareStatement(sqlCompte)) {
            for (String[] c : COMPTES) {
                for (int i = 0; i < 6; i++) {
                    ps.setString(i + 1, c[i]);
                }
                ps.setBytes(7, chiffreur.chiffrer(c[6]));
                ps.addBatch();
            }
            ps.executeBatch();
        }

        String sqlLigne = "INSERT INTO lignes_vehicules (compte_siren, msisdn, immatriculation) VALUES (?, ?, ?)";
        try (PreparedStatement ps = context.getConnection().prepareStatement(sqlLigne)) {
            for (String[] l : LIGNES_VEHICULES) {
                ps.setString(1, COMPTES[0][0]);
                ps.setString(2, l[0]);
                ps.setString(3, l[1]);
                ps.addBatch();
            }
            ps.executeBatch();
        }

        // paiement par carte des dépassements hors forfait, clé reprise telle quelle de l'ancien extranet
        try (PreparedStatement ps = context.getConnection().prepareStatement(
                "INSERT INTO parametres (cle, valeur) VALUES ('paiement.stripe.secret', ?)")) {
            ps.setString(1, "⟬stripe_secret_key#11⟭");
            ps.executeUpdate();
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
appearance: URL query string, log call, comment, KDoc
scenario: deep link activity of a cruise line's Android app opening the boarding pass from the confirmation email, with a test link and a logcat line left by the developer
⟬text⟭
package fr.croisieres.app.liens

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.util.Log
import androidx.appcompat.app.AppCompatActivity

/**
 * Ouvre la carte d'embarquement depuis le lien du mail de confirmation :
 * https://⟬hostname#1⟭/embarquement?resa=XXXX&t=<jeton>
 */
class LienEmbarquementActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val uri = intent?.data ?: return finish()
        val reservation = uri.getQueryParameter("resa")
        val jeton = uri.getQueryParameter("t")
        if (reservation == null || jeton == null) {
            startActivity(Intent(this, AccueilActivity::class.java))
            return finish()
        }
        SessionEmbarquement.ouvrir(reservation, jeton) { passager ->
            Log.d(TAG, "embarquement ${passager.nom} passeport=${passager.passeport}")
            startActivity(CarteEmbarquementActivity.intent(this, passager))
            finish()
        }
    }

    companion object {
        private const val TAG = "LienEmbarquement"

        // lien de test pour adb shell am start -d
        val LIEN_TEST: Uri = Uri.parse("https://⟬hostname#1⟭/embarquement?resa=⟬order_number#2⟭&t=⟬jwt#3⟭")

        // logcat du ⟬date#1⟭ :
        // D/LienEmbarquement: embarquement ⟬person_name#4⟭ passeport=⟬fr_passport#4⟭
    }
}
⟬end⟭

⟬template⟭
family: code
format: .php
language: fr
fill_locale: fr_FR
domain: logistics
appearance: class constant, constructor default, HTTP header, block comment with JSON
scenario: Symfony Messenger handler of a parcel delivery company notifying recipients by SMS and email, with a failed message pasted from the dead letter queue
⟬text⟭
<?php

namespace App\MessageHandler;

use App\Message\ColisLivre;
use libphonenumber\PhoneNumberFormat;
use libphonenumber\PhoneNumberUtil;
use Psr\Log\LoggerInterface;
use SendGrid\Mail\Mail;
use Symfony\Component\Messenger\Attribute\AsMessageHandler;
use Symfony\Contracts\HttpClient\HttpClientInterface;

#[AsMessageHandler]
final class ColisLivreHandler
{
    private const CLE_SMS = '⟬opaque_token#1⟭';

    public function __construct(
        private HttpClientInterface $http,
        private LoggerInterface $logger,
        private \SendGrid $sendgrid = new \SendGrid('⟬sendgrid_api_key#2⟭'),
    ) {
    }

    public function __invoke(ColisLivre $message): void
    {
        $util = PhoneNumberUtil::getInstance();
        $numero = $util->format($util->parse($message->telephone, 'FR'), PhoneNumberFormat::E164);

        $this->http->request('POST', 'https://⟬hostname#3⟭/v1/sms', [
            'headers' => ['X-Api-Key' => self::CLE_SMS],
            'json' => [
                'to' => $numero,
                'from' => 'COLIS',
                'text' => sprintf('Votre colis %s a été livré : %s.', $message->numeroSuivi, $message->lieu),
            ],
        ]);

        $mail = new Mail();
        $mail->setFrom('⟬email:generic#4⟭', 'Suivi colis');
        $mail->addTo($message->email);
        $mail->setSubject('Colis livré');
        $mail->addContent('text/plain', "Votre colis {$message->numeroSuivi} a été livré ({$message->lieu}).");
        $this->sendgrid->send($mail);

        $this->logger->info('notification de livraison', ['suivi' => $message->numeroSuivi, 'to' => $numero]);
    }
}

/*
 * Message rejoué depuis la file d'échec le ⟬date#1⟭ :
 * {"numeroSuivi":"⟬order_number#5⟭","telephone":"⟬phone#6⟭","email":"⟬email#6⟭",
 *  "lieu":"⟬fr_postal_address#6⟭","destinataire":"⟬person_name#6⟭","expediteurSiren":"⟬fr_siren#7⟭"}
 */
⟬end⟭

⟬template⟭
family: code
format: .js
language: fr
fill_locale: fr_FR
domain: real estate
appearance: object literal, template literal
scenario: map script of a real estate agency website showing its listings, with the negotiator's contact hardcoded in every popup
⟬text⟭
// carte des biens sur la page de l'agence ; tuiles Google via le plugin GoogleMutant
const carte = L.map("carte").setView([47.218, -1.553], 13);
L.gridLayer.googleMutant({ type: "roadmap", apiKey: "⟬google_api_key#1⟭" }).addTo(carte);

biens.forEach((b) => {
  L.marker([b.lat, b.lng])
    .addTo(carte)
    .bindPopup(`<b>${b.titre}</b><br>${b.prix} €<br>Contact : ⟬person_name#2⟭, ⟬phone#2⟭`);
});
⟬end⟭

⟬template⟭
family: code
format: .ts
language: fr
fill_locale: fr_FR
domain: logistics
appearance: form patch, comment, decorator
scenario: Angular component of a carrier's return label page, prefilled with a demo customer in development mode
⟬text⟭
import { Component, OnInit, isDevMode } from "@angular/core";
import { FormBuilder, Validators } from "@angular/forms";
import { RetourService } from "../retour.service";

@Component({
  selector: "app-etiquette-retour",
  templateUrl: "./etiquette-retour.component.html",
})
export class EtiquetteRetourComponent implements OnInit {
  formulaire = this.fb.group({
    nom: ["", Validators.required],
    email: ["", [Validators.required, Validators.email]],
    telephone: ["", Validators.pattern(/^0[1-9](\s?\d{2}){4}$/)],
    adresse: ["", Validators.required],
    codePostal: ["", [Validators.required, Validators.pattern(/^\d{5}$/)]],
    ville: ["", Validators.required],
    commande: ["", Validators.required],
    motif: ["TAILLE"],
  });

  constructor(private fb: FormBuilder, private retours: RetourService) {}

  ngOnInit(): void {
    // pré-remplissage pour les démos (⟬trap:initials|KL⟭), à retirer avant la mise en production
    if (isDevMode()) {
      this.formulaire.patchValue({
        nom: "⟬person_name#1⟭",
        email: "⟬email#1⟭",
        telephone: "⟬phone#1⟭",
        adresse: "⟬fr_postal_address:street#1⟭",
        codePostal: "⟬postcode#1⟭",
        ville: "⟬city#1⟭",
        commande: "⟬order_number#2⟭",
      });
    }
  }

  generer(): void {
    if (this.formulaire.invalid) return;
    this.retours.creerEtiquette(this.formulaire.getRawValue()).subscribe((pdf) => window.open(URL.createObjectURL(pdf)));
  }
}
⟬end⟭

⟬template⟭
family: code
format: .java
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: log line string, assertion
scenario: unit test of the Logback converter that masks payment data in the logs of an online pharmacy
⟬text⟭
class MasquageLogConverterTest {

    private final MasquageLogConverter converter = new MasquageLogConverter();

    @Test
    void masqueCarteCryptogrammeEtIban() {
        String ligne = "paiement refusé carte=⟬payment_card#1⟭ cvv=⟬card_security_code#1⟭ iban_remboursement=⟬iban#2⟭";

        String masquee = converter.masquer(ligne);

        assertThat(masquee).doesNotContain("⟬payment_card#1⟭").doesNotContain("⟬iban#2⟭");
        assertThat(masquee).contains("cvv=***");
    }
}
⟬end⟭

⟬template⟭
family: code
format: .kt
language: fr
fill_locale: fr_FR
domain: real estate
appearance: data class constructor, companion object, KDoc, string literal
scenario: Spring service in Kotlin of a property manager producing move-in inspection reports, emailing both parties and charging the fee, with a preview example in the companion object
⟬text⟭
package fr.gestimmo.etatdeslieux

import com.sendgrid.Method
import com.sendgrid.Request
import com.sendgrid.SendGrid
import com.sendgrid.helpers.mail.Mail
import com.sendgrid.helpers.mail.objects.Attachments
import com.sendgrid.helpers.mail.objects.Content
import com.sendgrid.helpers.mail.objects.Email
import com.stripe.Stripe
import com.stripe.model.PaymentIntent
import com.stripe.param.PaymentIntentCreateParams
import org.springframework.stereotype.Service
import java.time.LocalDate
import java.util.Base64

data class Partie(val nom: String, val telephone: String, val email: String, val piece: String?)

data class Piece(val nom: String, val etat: String, val commentaire: String = "")

data class EtatDesLieux(
    val reference: String,
    val type: String, // ENTREE ou SORTIE
    val date: LocalDate,
    val adresseLogement: String,
    val bailleur: Partie,
    val bailleurSiren: String?,
    val locataire: Partie,
    val stationnement: String?,
    val pieces: List<Piece>,
)

/**
 * Génère le PDF de l'état des lieux, l'envoie aux deux parties et facture les frais au locataire.
 * Clés en dur héritées du prototype, voir ⟬ticket_id#1⟭ pour le passage au coffre.
 */
@Service
class EtatDesLieuxService(private val pdf: GenerateurPdf) {

    private val sendgrid = SendGrid("⟬sendgrid_api_key#2⟭")

    init {
        Stripe.apiKey = "⟬stripe_secret_key#3⟭"
    }

    fun finaliser(edl: EtatDesLieux, fraisCentimes: Long, moyenPaiement: String) {
        val document = pdf.generer("edl.html.ftl", mapOf("edl" to edl))
        listOf(edl.bailleur, edl.locataire).forEach { envoyer(it, edl, document) }
        if (fraisCentimes > 0) {
            PaymentIntent.create(
                PaymentIntentCreateParams.builder()
                    .setAmount(fraisCentimes)
                    .setCurrency("eur")
                    .setPaymentMethod(moyenPaiement)
                    .setConfirm(true)
                    .putMetadata("edl", edl.reference)
                    .build(),
            )
        }
    }

    private fun envoyer(destinataire: Partie, edl: EtatDesLieux, document: ByteArray) {
        val mail = Mail(
            Email("⟬email:generic#4⟭", "Gestion locative"),
            "État des lieux (${edl.type.lowercase()}) du ${edl.date}",
            Email(destinataire.email, destinataire.nom),
            Content("text/plain", "Bonjour,\nVous trouverez ci-joint l'état des lieux du logement ${edl.adresseLogement}."),
        )
        mail.addAttachments(
            Attachments.Builder("etat-des-lieux-${edl.reference}.pdf", Base64.getEncoder().encodeToString(document).byteInputStream())
                .withType("application/pdf")
                .build(),
        )
        sendgrid.api(Request().apply { method = Method.POST; endpoint = "mail/send"; body = mail.build() })
    }

    companion object {
        /** Exemple pour l'aperçu du gabarit en développement. */
        val EXEMPLE = EtatDesLieux(
            reference = "⟬order_number#5⟭",
            type = "ENTREE",
            date = LocalDate.of(2026, 9, 1),
            adresseLogement = "⟬fr_postal_address#6⟭",
            bailleur = Partie("⟬person_name#7⟭", "⟬phone#7⟭", "⟬email#7⟭", null),
            bailleurSiren = "⟬fr_siren#8⟭",
            locataire = Partie("⟬person_name#9⟭", "⟬phone#9⟭", "⟬email#9⟭", "CNI ⟬fr_identity_card#9⟭"),
            stationnement = "Box 4, véhicule ⟬fr_license_plate#9⟭",
            pieces = listOf(
                Piece("Séjour", "BON"),
                Piece("Cuisine", "USAGE", "joint de l'évier noirci"),
                Piece("Chambre", "BON"),
                Piece("Salle d'eau", "MAUVAIS", "carreau fêlé sous le lavabo"),
            ),
        )
    }
}
⟬end⟭

⟬template⟭
family: code
format: .php
language: fr
fill_locale: fr_FR
domain: telecom
appearance: ORM query, assignment, comment
scenario: one-off correction script a support developer of a mobile operator ran through artisan tinker to fix a subscriber's identity
⟬text⟭
<?php
// correctif demandé par le service client (⟬ticket_id#1⟭), lancé avec : php artisan tinker correctif.php
// L'abonné a été créé avec la CNI de son conjoint lors de la souscription en boutique.
$abonne = \App\Models\Abonne::where('msisdn', '⟬phone#2⟭')->firstOrFail();
$abonne->titulaire = '⟬person_name#2⟭';
$abonne->numero_piece = '⟬fr_identity_card#2⟭';
$abonne->save();
\Log::info('correctif titulaire', ['msisdn' => $abonne->msisdn, 'ticket' => '⟬ticket_id#1⟭']);
⟬end⟭

⟬template⟭
family: code
format: .ts
language: fr
fill_locale: fr_FR
domain: education
appearance: template literal, URL, block comment, HTTP header
scenario: LTI 1.3 tool of a maths exercise publisher plugged into a regional school platform, with its signing key inline and the first launch token pasted at the bottom
⟬text⟭
/**
 * Outil LTI 1.3 « Exercices de maths » branché sur la plateforme de l'académie.
 * Lancement : la plateforme poste un id_token signé, vérifié avec son JWKS ; nos propres
 * messages (notes renvoyées par AGS) sont signés avec notre clé privée.
 */
import express from "express";
import { createRemoteJWKSet, importPKCS8, jwtVerify, SignJWT } from "jose";
import sgMail from "@sendgrid/mail";

const PLATEFORME = {
  issuer: "https://⟬hostname#1⟭",
  clientId: "⟬uuid#2⟭",
  deploymentId: "1",
  jwks: createRemoteJWKSet(new URL("https://⟬hostname#1⟭/mod/lti/certs.php")),
  tokenUrl: "https://⟬hostname#1⟭/mod/lti/token.php",
};

// clé de l'outil, déclarée sur la plateforme (KID outil-maths-2026)
const CLE_PRIVEE_PEM = `⟬private_key#3⟭`;

sgMail.setApiKey(process.env.SENDGRID_KEY ?? "⟬sendgrid_api_key#4⟭");

const app = express();
app.use(express.urlencoded({ extended: false }));

app.post("/lti/lancement", async (req, res) => {
  try {
    const { payload } = await jwtVerify(req.body.id_token, PLATEFORME.jwks, {
      issuer: PLATEFORME.issuer,
      audience: PLATEFORME.clientId,
    });
    const roles = payload["https://purl.imsglobal.org/spec/lti/claim/roles"] as string[];
    const enseignant = roles.some((r) => r.endsWith("#Instructor"));
    res.redirect(enseignant ? `/tableau?cours=${payload.sub}` : `/exercices?eleve=${payload.sub}`);
  } catch (err) {
    res.status(401).send("Lancement LTI refusé");
  }
});

async function jetonAgs(): Promise<string> {
  const cle = await importPKCS8(CLE_PRIVEE_PEM, "RS256");
  const assertion = await new SignJWT({})
    .setProtectedHeader({ alg: "RS256", kid: "outil-maths-2026" })
    .setIssuer(PLATEFORME.clientId)
    .setSubject(PLATEFORME.clientId)
    .setAudience(PLATEFORME.tokenUrl)
    .setIssuedAt()
    .setExpirationTime("5m")
    .setJti(crypto.randomUUID())
    .sign(cle);
  const reponse = await fetch(PLATEFORME.tokenUrl, {
    method: "POST",
    headers: { "Content-Type": "application/x-www-form-urlencoded" },
    body: new URLSearchParams({
      grant_type: "client_credentials",
      client_assertion_type: "urn:ietf:params:oauth:client-assertion-type:jwt-bearer",
      client_assertion: assertion,
      scope: "https://purl.imsglobal.org/spec/lti-ags/scope/score",
    }),
  });
  return (await reponse.json()).access_token;
}

export async function envoyerNote(lineItemUrl: string, eleve: string, note: number, emailEnseignant: string) {
  const jeton = await jetonAgs();
  const r = await fetch(`${lineItemUrl}/scores`, {
    method: "POST",
    headers: { Authorization: `Bearer ${jeton}`, "Content-Type": "application/vnd.ims.lis.v1.score+json" },
    body: JSON.stringify({
      userId: eleve,
      scoreGiven: note,
      scoreMaximum: 20,
      activityProgress: "Completed",
      gradingProgress: "FullyGraded",
      timestamp: new Date().toISOString(),
    }),
  });
  if (!r.ok) {
    await sgMail.send({
      to: emailEnseignant,
      from: "⟬email:generic#5⟭",
      subject: "Note non transmise",
      text: `La note de l'élève ${eleve} n'a pas pu être envoyée (${r.status}).`,
    });
  }
}

app.listen(3000);

/*
 * id_token reçu au premier test avec la plateforme (⟬date#1⟭) :
 * ⟬jwt#6⟭
 * décodé : sub=⟬uuid#7⟭, name="⟬person_name#8⟭", email="⟬email#8⟭", rôle Learner, cours 4e B
 */
⟬end⟭

⟬template⟭
family: code
format: .js
language: fr
fill_locale: fr_FR
domain: travel
appearance: object literal, browser automation, test data
scenario: Puppeteer robot of a group travel agency booking rooms on a partner hotel's extranet, which has no API, with the agency account and corporate card inline
⟬text⟭
// robot-extranet.js : réserve les chambres de groupe sur l'extranet de l'hôtelier partenaire
// (pas d'API chez eux). Lancé à la main par l'équipe groupes, jamais en tâche planifiée.
const puppeteer = require("puppeteer");

const COMPTE = { identifiant: "⟬email:generic#1⟭", motDePasse: "⟬password#1⟭" };
const CARTE_AGENCE = { numero: "⟬payment_card#2⟭", expiration: "09/28", cvc: "⟬card_security_code#2⟭" };

async function reserver(groupe) {
  const navigateur = await puppeteer.launch({ headless: "new" });
  const page = await navigateur.newPage();
  await page.goto("https://⟬hostname#3⟭/extranet/login");
  await page.type("#login", COMPTE.identifiant);
  await page.type("#password", COMPTE.motDePasse);
  await Promise.all([page.waitForNavigation(), page.click("button[type=submit]")]);

  await page.goto(`https://⟬hostname#3⟭/extranet/groupes/nouveau?arrivee=${groupe.arrivee}&nuits=${groupe.nuits}`);
  for (const voyageur of groupe.voyageurs) {
    await page.click("#ajouter-voyageur");
    await page.type(".voyageur:last-child .nom", voyageur.nom);
    await page.type(".voyageur:last-child .naissance", voyageur.naissance);
    await page.type(".voyageur:last-child .passeport", voyageur.passeport);
  }
  await page.type("#carte-numero", CARTE_AGENCE.numero);
  await page.type("#carte-expiration", CARTE_AGENCE.expiration);
  await page.type("#carte-cvc", CARTE_AGENCE.cvc);
  await page.click("#confirmer");
  await page.waitForSelector(".confirmation-numero");
  const numero = await page.$eval(".confirmation-numero", (el) => el.textContent.trim());
  await navigateur.close();
  return numero;
}

// groupe de test (séminaire du ⟬date#1⟭)
if (require.main === module) {
  reserver({
    arrivee: "⟬date#1⟭",
    nuits: 2,
    voyageurs: [
      { nom: "⟬person_name#4⟭", naissance: "⟬birth_date#4⟭", passeport: "⟬fr_passport#4⟭" },
      { nom: "⟬person_name#5⟭", naissance: "⟬birth_date#5⟭", passeport: "⟬fr_passport#5⟭" },
    ],
  }).then(console.log);
}

module.exports = { reserver };
⟬end⟭

⟬template⟭
family: code
format: .java
language: fr
fill_locale: fr_FR
domain: logistics
appearance: Javadoc, pre block, constant, URL template
scenario: REST client of a shipping platform for a regional carrier's pickup API, with a sample response kept in the Javadoc
⟬text⟭
package fr.expedito.transporteurs.client;

import java.time.Duration;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

/**
 * Client de l'API du transporteur régional (enlèvements et preuves de livraison).
 * Exemple de réponse de GET /enlevements/{id} :
 * <pre>
 * {"id":"⟬order_number#1⟭","statut":"EN_COURS","chauffeur":{"nom":"⟬person_name#2⟭","mobile":"⟬phone#2⟭"},
 *  "vehicule":"⟬fr_license_plate#3⟭","eta":"14:20"}
 * </pre>
 */
@Component
public class ClientTransporteur {

    private static final String URL = "https://⟬hostname#4⟭/api/v3";
    private static final String ⟬trap:indicator_non_pii|UTILISATEUR = "expedito-prod"⟭;
    private static final String MOT_DE_PASSE = "⟬password#4⟭";
    private static final String CLE_GEOCODAGE = "⟬google_api_key#5⟭";

    private final RestTemplate rest;

    public ClientTransporteur(RestTemplateBuilder builder) {
        this.rest = builder.rootUri(URL)
            .basicAuthentication(UTILISATEUR, MOT_DE_PASSE)
            .setConnectTimeout(Duration.ofSeconds(5))
            .build();
    }

    public Enlevement enlevement(String id) {
        return rest.getForObject("/enlevements/{id}", Enlevement.class, id);
    }

    public Coordonnees geocoder(String adresse) {
        GeocodageReponse reponse = rest.getForObject(
            "https://maps.googleapis.com/maps/api/geocode/json?address={a}&key={k}", GeocodageReponse.class, adresse, CLE_GEOCODAGE);
        if (reponse == null || reponse.results().isEmpty()) {
            throw new IllegalStateException("adresse introuvable : " + adresse);
        }
        return reponse.results().get(0).geometry().location();
    }
}
⟬end⟭

⟬template⟭
family: code
format: .kt
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: constant, commented-out line
scenario: key holder object of a furniture shop's Android app, where an old secret key still sits in a commented-out line
⟬text⟭
// Clés embarquées dans l'appli : uniquement des clés publiques ou restreintes au package.
object Cles {
    const val MAPS = "⟬google_api_key#1⟭"
    const val STRIPE_PUBLIQUE = "⟬stripe_publishable_key#2⟭"
    // ancienne clé utilisée par erreur jusqu'à la 3.2.0, révoquée ? à vérifier avec l'équipe paiement
    // const val STRIPE = "⟬stripe_secret_key#2⟭"
}
⟬end⟭

⟬template⟭
family: code
format: .ts
language: fr
fill_locale: fr_FR
domain: telecom
appearance: GraphQL variables, nested object, test case
scenario: Apollo Server tests of the number porting mutation of a mobile operator, covering a verified holder and a mismatched identity document
⟬text⟭
import { gql } from "graphql-tag";
import { creerServeurTest } from "../test/serveur";

const DEMANDER_PORTABILITE = gql`
  mutation DemanderPortabilite($entree: PortabiliteEntree!) {
    demanderPortabilite(entree: $entree) {
      statut
      dateBascule
      erreurs { champ message }
    }
  }
`;

describe("mutation demanderPortabilite", () => {
  it("planifie la bascule pour un titulaire vérifié", async () => {
    const serveur = await creerServeurTest({ utilisateur: { id: "⟬customer_id#1⟭", roles: ["CLIENT"] } });
    const { body } = await serveur.executeOperation({
      query: DEMANDER_PORTABILITE,
      variables: {
        entree: {
          numero: "⟬phone#2⟭",
          rio: "06P3QW8KX7Z1",
          titulaire: { nom: "⟬person_name#2⟭", dateNaissance: "⟬birth_date#2⟭", piece: { type: "CNI", numero: "⟬fr_identity_card#2⟭" } },
        },
      },
    });
    expect(body.kind === "single" && body.singleResult.data?.demanderPortabilite.statut).toBe("PLANIFIEE");
  });

  it("refuse un titulaire dont la pièce ne correspond pas", async () => {
    const serveur = await creerServeurTest({ utilisateur: { id: "⟬customer_id#3⟭", roles: ["CLIENT"] } });
    const { body } = await serveur.executeOperation({
      query: DEMANDER_PORTABILITE,
      variables: {
        entree: {
          numero: "⟬phone#3⟭",
          rio: "06E1MK4PT9QA",
          titulaire: { nom: "⟬person_name#3⟭", dateNaissance: "⟬birth_date#3⟭", piece: { type: "PASSEPORT", numero: "⟬fr_passport#3⟭" } },
        },
      },
    });
    const resultat = body.kind === "single" ? body.singleResult.data?.demanderPortabilite : null;
    expect(resultat?.statut).toBe("REFUSEE");
    expect(resultat?.erreurs[0].champ).toBe("titulaire.piece");
  });
});
⟬end⟭

⟬template⟭
family: code
format: .js
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: local storage, console output, event handler
scenario: Stripe Elements payment page script of a ceramics shop, where a localhost-only block seeds a session token and prints the test card for the developer
⟬text⟭
// paiement.js : page de paiement (Stripe Elements), chargée par checkout.html
const stripe = Stripe(window.CONFIG.stripePublicKey);
const elements = stripe.elements({ locale: "fr" });
const carte = elements.create("card", { hidePostalCode: true });
carte.mount("#carte");

document.querySelector("#form-paiement").addEventListener("submit", async (e) => {
  e.preventDefault();
  const bouton = e.submitter;
  bouton.disabled = true;
  const reponse = await fetch("/api/paiements/intent", {
    method: "POST",
    headers: { Authorization: `Bearer ${localStorage.getItem("jeton")}` },
  });
  const { clientSecret } = await reponse.json();
  const { error } = await stripe.confirmCardPayment(clientSecret, {
    payment_method: { card: carte, billing_details: { name: document.querySelector("#titulaire").value } },
  });
  if (error) {
    document.querySelector("#erreur").textContent = error.message;
    bouton.disabled = false;
    return;
  }
  location.href = "/commande/merci";
});

// Aide au debug en local : les champs Stripe ne se pré-remplissent pas, on affiche la carte à taper
if (location.hostname === "localhost") {
  localStorage.setItem("jeton", "⟬jwt#1⟭");
  document.querySelector("#titulaire").value = "⟬person_name#2⟭";
  console.info("carte de test : ⟬payment_card#3⟭  exp 04/30  cvc ⟬card_security_code#3⟭  (compte ⟬email#2⟭)");
}
⟬end⟭

⟬template⟭
family: code
format: .kt
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: import, extension function, constant
scenario: image loading helper of a clothing rental app's catalogue screen
⟬text⟭
package fr.modeloc.app.catalogue

import android.widget.ImageView
import com.squareup.picasso.Picasso

private const val ⟬trap:indicator_non_pii|CLE_CACHE_PREFIXE = "vignette_"⟭

/** Vignettes du catalogue, chargées par ⟬trap:library|Picasso⟭ et mises en cache disque. */
fun ImageView.chargerVignette(url: String?) {
    if (url == null) return setImageResource(R.drawable.vignette_vide)
    Picasso.get()
        .load(url)
        .stableKey(CLE_CACHE_PREFIXE + url.hashCode())
        .placeholder(R.drawable.vignette_chargement)
        .resize(320, 0)
        .into(this)
}
⟬end⟭

⟬template⟭
family: code
format: .java
language: fr
fill_locale: fr_FR
domain: travel
appearance: Javadoc, constant, method
scenario: availability cache of a hotel booking aggregator, written by a performance engineer to shield the supplier API during peak season
⟬text⟭
package fr.dispohotel.cache;

import com.github.benmanes.caffeine.cache.Cache;
import com.github.benmanes.caffeine.cache.Caffeine;
import com.google.common.hash.BloomFilter;
import com.google.common.hash.Funnels;
import java.nio.charset.StandardCharsets;
import java.time.Duration;
import java.time.LocalDate;
import java.util.Optional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Cache des disponibilités hôtelières.
 * Un filtre de ⟬trap:eponym|Bloom⟭ évite d'interroger le fournisseur pour les hôtels sans aucune
 * chambre libre sur la période, soit 80 % des requêtes en haute saison. Le filtre est reconstruit
 * chaque nuit à partir du flux complet du fournisseur (⟬hostname#1⟭).
 */
public final class CacheDisponibilites {

    private static final Logger LOG = LoggerFactory.getLogger(CacheDisponibilites.class);
    ⟬trap:indicator_non_pii|private static final String USER_AGENT = "dispohotel-cache/2.3"⟭;
    private static final int HOTELS_ATTENDUS = 400_000;
    private static final double TAUX_FAUX_POSITIFS = 0.01;

    private volatile BloomFilter<CharSequence> complets = nouveauFiltre();
    private final Cache<String, Disponibilite> cache = Caffeine.newBuilder()
        .maximumSize(200_000)
        .expireAfterWrite(Duration.ofMinutes(10))
        .recordStats()
        .build();
    private final FournisseurClient fournisseur;

    public CacheDisponibilites(FournisseurClient fournisseur) {
        this.fournisseur = fournisseur;
    }

    public Optional<Disponibilite> chercher(String hotel, LocalDate arrivee, int nuits) {
        String cle = hotel + ":" + arrivee + ":" + nuits;
        if (complets.mightContain(cle)) {
            // faux positif possible (1 %) : l'hôtel est alors affiché complet jusqu'à la reconstruction
            return Optional.empty();
        }
        Disponibilite d = cache.get(cle, k -> fournisseur.disponibilite(hotel, arrivee, nuits, USER_AGENT));
        if (d != null && d.chambresLibres() == 0) {
            complets.put(cle);
        }
        return Optional.ofNullable(d);
    }

    public void reconstruire(Iterable<String> clesCompletes) {
        BloomFilter<CharSequence> nouveau = nouveauFiltre();
        int n = 0;
        for (String cle : clesCompletes) {
            nouveau.put(cle);
            n++;
        }
        complets = nouveau;
        cache.invalidateAll();
        LOG.info("filtre reconstruit : {} séjours complets, taux d'erreur estimé {}", n, nouveau.expectedFpp());
    }

    private static BloomFilter<CharSequence> nouveauFiltre() {
        return BloomFilter.create(Funnels.stringFunnel(StandardCharsets.UTF_8), HOTELS_ATTENDUS, TAUX_FAUX_POSITIFS);
    }
}
⟬end⟭

⟬template⟭
family: code
format: .php
language: fr
fill_locale: fr_FR
domain: education
appearance: use statement, docblock, policy method
scenario: Laravel policy controlling who may read, edit and export grades in a middle school management app
⟬text⟭
<?php

namespace App\Policies;

use App\Models\Evaluation;
use App\Models\User;
use Illuminate\Auth\Access\Response;
use Illuminate\Support\Facades\Log;
use ⟬trap:library|Ramsey⟭\Uuid\Uuid;

/**
 * Accès aux notes : l'enseignant de la classe, le professeur principal et la direction.
 * Règles décidées en conseil pédagogique, compte rendu rédigé par ⟬trap:initials|M.-C.⟭ en mars.
 */
class EvaluationPolicy
{
    public function voir(User $user, Evaluation $evaluation): Response
    {
        if ($user->estDirection() || $evaluation->classe->professeur_principal_id === $user->id) {
            return Response::allow();
        }
        return $evaluation->enseignant_id === $user->id
            ? Response::allow()
            : Response::deny('Ces notes ne concernent pas vos classes.');
    }

    public function modifier(User $user, Evaluation $evaluation): Response
    {
        if ($evaluation->verrouillee_le !== null) {
            return Response::deny('Le conseil de classe a verrouillé les notes.');
        }
        return $evaluation->enseignant_id === $user->id ? Response::allow() : Response::deny();
    }

    public function exporter(User $user, Evaluation $evaluation): Response
    {
        if (!$user->estDirection()) {
            return Response::deny('Export réservé à la direction.');
        }
        Log::info('export de notes', ['export' => Uuid::uuid4()->toString(), 'evaluation' => $evaluation->id, 'par' => $user->id]);
        return Response::allow();
    }
}
⟬end⟭

⟬template⟭
family: code
format: .js
language: fr
fill_locale: fr_FR
domain: telecom
appearance: require, array literal, log format, comment
scenario: logger module of a telecom call centre back office, redacting sensitive fields before logs reach the central log store
⟬text⟭
// logger.js : journalisation du back-office conseillers (JSON, collecté par Loki)
const winston = require("⟬trap:library|winston⟭");
const { trace } = require("⟬trap:email_lookalike|@opentelemetry/api⟭");

const CHAMPS_MASQUES = new Set(["password", "motDePasse", "cni", "iban", "rio", "puk", "authorization"]);

function masquerObjet(objet) {
  for (const [cle, valeur] of Object.entries(objet)) {
    if (CHAMPS_MASQUES.has(cle)) {
      objet[cle] = "[MASQUÉ]";
    } else if (valeur && typeof valeur === "object") {
      masquerObjet(valeur);
    }
  }
  return objet;
}

const masquer = winston.format((info) => masquerObjet(info));

const traceId = winston.format((info) => {
  const span = trace.getActiveSpan();
  if (span) info.trace_id = span.spanContext().traceId;
  return info;
});

module.exports = winston.createLogger({
  level: process.env.LOG_LEVEL || "info",
  defaultMeta: { service: "bo-conseillers", ⟬trap:indicator_non_pii|owner: "equipe-crm"⟭ },
  format: winston.format.combine(masquer(), traceId(), winston.format.timestamp(), winston.format.json()),
  transports: [new winston.transports.Console()],
});

// sortie attendue : {"level":"info","message":"fiche ouverte",⟬trap:indicator_non_pii|"password":"[MASQUÉ]"⟭,"service":"bo-conseillers"}
⟬end⟭

⟬template⟭
family: code
format: .ts
language: fr
fill_locale: fr_FR
domain: real estate
appearance: unit test, function call, comment
scenario: legacy Jasmine tests of the rent revision helper of a property management front end, kept from the first version of the app
⟬text⟭
import { libelleQuittance, reviserLoyer } from "./revision";

// Tests ⟬trap:library|Jasmine⟭ (Karma) hérités du premier front, conservés tels quels.
describe("révision annuelle du loyer (IRL)", () => {
  it("applique la variation de l'indice de référence", () => {
    expect(reviserLoyer({ loyer: 720, irlAncien: 138.59, irlNouveau: 142.06, dpe: "D" })).toBeCloseTo(738.03, 2);
  });

  it("ne révise pas un logement classé F ou G", () => {
    expect(reviserLoyer({ loyer: 650, irlAncien: 138.59, irlNouveau: 142.06, dpe: "G" })).toBe(650);
  });

  it("ne baisse jamais le loyer si l'indice recule", () => {
    expect(reviserLoyer({ loyer: 900, irlAncien: 142.06, irlNouveau: 141.2, dpe: "C" })).toBe(900);
  });

  it("compose le libellé de la quittance", () => {
    expect(libelleQuittance("Résidence Les ⟬trap:word_name|Violettes⟭", "lot 12", "⟬date#1⟭")).toContain("lot 12");
  });
});
⟬end⟭
