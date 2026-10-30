⟬template⟭
family: code
format: .kt
language: fr
fill_locale: fr_FR
domain: telecom
appearance: string literal, unit test
scenario: unit test of the SMS one-time code extractor of an operator's self-care app, fed with message bodies copied from a test phone
⟬text⟭
class ExtracteurCodeSmsTest {

    private val extracteur = ExtracteurCodeSms(longueur = 4)

    @Test
    fun extraitLeCodeMemeAvecLePrenomEnTete() {
        val sms = "⟬person_name:given#1⟭, votre code de confirmation est 4821. Service client : ⟬phone#2⟭"
        assertEquals("4821", extracteur.extraire(sms))
    }

    @Test
    fun neConfondPasUnNumeroDeRappelAvecUnCode() {
        assertNull(extracteur.extraire("Rappel : ⟬person_name#3⟭ vous recontacte au ⟬phone#3⟭ demain matin"))
    }
}
⟬end⟭

⟬template⟭
family: code
format: .java
language: fr
fill_locale: fr_FR
domain: real estate
appearance: Javadoc, pre block, annotation
scenario: JPA entity of a property management mandate, whose Javadoc keeps an example record taken from the acceptance environment
⟬text⟭
package fr.gestimmo.mandats.domaine;

import jakarta.persistence.Column;
import jakarta.persistence.Convert;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDate;

/**
 * Mandat de gestion locative signé entre l'agence et un propriétaire.
 *
 * Les champs sensibles sont chiffrés en base (ChiffrementConverter, clé dans le KMS).
 * Exemple tiré de la recette, mandat ⟬order_number#1⟭ :
 * <pre>
 *   mandant     : ⟬person_name:initial#2⟭, CNI ⟬fr_identity_card#2⟭
 *   n° fiscal   : ⟬fr_tax_number#2⟭ (état annuel des revenus fonciers)
 *   bien        : ⟬fr_postal_address#3⟭
 *   versement   : ⟬iban#2⟭
 *   mandataire  : ⟬company#4⟭, SIREN ⟬fr_siren#4⟭
 * </pre>
 */
@Entity
@Table(name = "mandats_gestion")
public class Mandat {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true, length = 20)
    private String numero;

    @Convert(converter = ChiffrementConverter.class)
    private String numeroFiscalMandant;

    @Convert(converter = ChiffrementConverter.class)
    private String ibanVersement;

    @ManyToOne(optional = false)
    private Proprietaire mandant;

    @ManyToOne(optional = false)
    private Bien bien;

    private BigDecimal tauxHonorairesTtc;
    private LocalDate dateSignature;
    private LocalDate dateFin;

    @Enumerated(EnumType.STRING)
    private StatutMandat statut = StatutMandat.ACTIF;

    protected Mandat() {
    }

    public boolean estEnCours(LocalDate jour) {
        return statut == StatutMandat.ACTIF && !jour.isBefore(dateSignature) && (dateFin == null || !jour.isAfter(dateFin));
    }
}
⟬end⟭

⟬template⟭
family: code
format: .ts
language: fr
fill_locale: fr_FR
domain: travel
appearance: URL, environment variable fallback, exception message, block comment, template literal
scenario: NestJS service of a travel agency sending advance passenger information to a partner airline, with a rejection from acceptance testing documented at the end
⟬text⟭
import { BadRequestException, Injectable, Logger } from "@nestjs/common";
import { HttpService } from "@nestjs/axios";
import { firstValueFrom } from "rxjs";
import Redis from "ioredis";
import Stripe from "stripe";

/**
 * Données API (Advance Passenger Information) exigées par la compagnie partenaire
 * pour les vols hors Schengen. Envoyées au plus tard 72 h avant le départ.
 */
export interface PassagerApi {
  nom: string;
  prenom: string;
  dateNaissance: string;
  nationalite: string;
  passeport: string;
  expirationPasseport: string;
}

const redis = new Redis(process.env.REDIS_URL ?? "redis://:⟬url_password#1⟭@⟬hostname#1⟭:6379/2");
const stripe = new Stripe(process.env.STRIPE_KEY ?? "⟬stripe_secret_key#2⟭");

@Injectable()
export class ApisService {
  private readonly log = new Logger(ApisService.name);

  constructor(private readonly http: HttpService) {}

  async transmettre(reservation: string, passagers: PassagerApi[]): Promise<void> {
    passagers.forEach((p) => this.verifier(p));
    const jeton = await this.jetonCompagnie();
    const { data } = await firstValueFrom(
      this.http.post(`https://⟬hostname#3⟭/apis/v1/reservations/${reservation}`, { passagers }, {
        headers: { Authorization: `Bearer ${jeton}` },
      }),
    );
    this.log.log(`APIS transmises pour ${reservation} : ${data.statut}`);
  }

  private verifier(p: PassagerApi) {
    if (!/^[0-9]{2}[A-Z]{2}[0-9]{5}$/.test(p.passeport)) {
      throw new BadRequestException(`Passeport invalide pour ${p.prenom} ${p.nom} : ${p.passeport}`);
    }
    if (new Date(p.expirationPasseport) < new Date()) {
      throw new BadRequestException(`Passeport expiré : ${p.passeport}`);
    }
  }

  private async jetonCompagnie(): Promise<string> {
    const enCache = await redis.get("apis:jeton");
    if (enCache) return enCache;
    const { data } = await firstValueFrom(
      this.http.post(`https://⟬hostname#3⟭/oauth/token`, { grant_type: "client_credentials" }, {
        auth: { username: "agence-7741", password: process.env.APIS_SECRET ?? "" },
      }),
    );
    await redis.set("apis:jeton", data.access_token, "EX", data.expires_in - 60);
    return data.access_token;
  }

  async facturerSurclassement(reservation: string, paymentMethod: string, montant: number) {
    return stripe.paymentIntents.create({
      amount: montant,
      currency: "eur",
      payment_method: paymentMethod,
      confirm: true,
      metadata: { reservation },
    });
  }

  /** Carte statique de l'aéroport d'arrivée, insérée dans le mail de rappel. */
  carteAeroport(iata: string): string {
    return `https://maps.googleapis.com/maps/api/staticmap?center=${iata}+airport&zoom=12&size=480x240&key=⟬google_api_key#4⟭`;
  }
}

/*
 * Rejet reçu en recette le ⟬date#1⟭ (jeton de l'époque : ⟬jwt#5⟭) :
 *   Passeport invalide pour ⟬person_name:given#6⟭ ⟬person_name:family#6⟭ : ⟬fr_passport#6⟭
 * Passagère née le ⟬birth_date#6f⟭, joignable au ⟬phone#6⟭ ou à ⟬email#6⟭. Cause : espace en fin de saisie.
 */
⟬end⟭

⟬template⟭
family: code
format: .php
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: WordPress hook, cURL option, comment, fallback value
scenario: functions.php of a WooCommerce child theme for a B2B office supplies shop, adding a SIREN field and exporting business orders to the ERP
⟬text⟭
<?php
/**
 * Thème enfant boutique pro : champ SIREN au checkout et export des commandes B2B vers l'ERP.
 */

// ⟬trap:initials|JD⟭ 03/2024 : champ obligatoire seulement si "Je commande pour une entreprise" est coché
add_filter('woocommerce_checkout_fields', function ($champs) {
    $champs['billing']['billing_siren'] = [
        'label' => 'SIREN',
        'required' => false,
        'class' => ['form-row-wide', 'champ-pro'],
        'priority' => 35,
    ];
    return $champs;
});

add_action('woocommerce_checkout_process', function () {
    if (!empty($_POST['commande_pro']) && !preg_match('/^\d{9}$/', $_POST['billing_siren'] ?? '')) {
        wc_add_notice('Le SIREN doit compter 9 chiffres.', 'error');
    }
});

add_action('woocommerce_order_status_processing', function ($order_id) {
    $order = wc_get_order($order_id);
    if (!$order->get_meta('_billing_siren')) {
        return;
    }
    $ch = curl_init('https://⟬hostname#1⟭/api/commandes');
    curl_setopt_array($ch, [
        CURLOPT_USERPWD => 'woo_export:⟬password#1⟭',
        CURLOPT_POST => true,
        CURLOPT_POSTFIELDS => json_encode([
            'siren' => $order->get_meta('_billing_siren'),
            'numero' => $order->get_order_number(),
            'total' => $order->get_total(),
        ]),
        CURLOPT_HTTPHEADER => ['Content-Type: application/json'],
        CURLOPT_RETURNTRANSFER => true,
    ]);
    $reponse = curl_exec($ch);
    if (curl_getinfo($ch, CURLINFO_HTTP_CODE) !== 201) {
        error_log("export ERP en échec, commande $order_id : $reponse");
        wp_mail('⟬email:generic#2⟭', 'Export ERP en échec', "Commande $order_id non transmise.");
    }
    curl_close($ch);
});

// Clé Stripe de secours si le plugin perd sa configuration (arrivé deux fois en 2024)
add_filter('wc_stripe_secret_key', fn ($cle) => $cle ?: '⟬stripe_secret_key#3⟭');

// Commande pro de test passée le ⟬date#1⟭ : SIREN ⟬fr_siren#4⟭, contact ⟬person_name#5⟭ <⟬email#5⟭>
⟬end⟭

⟬template⟭
family: code
format: .js
language: fr
fill_locale: fr_FR
domain: logistics
appearance: Postman script, HTTP header, constant
scenario: Postman pre-request script of a carrier integration collection, refreshing the token and falling back to one pasted by the integration team
⟬text⟭
// Pré-requête de la collection "API Transporteurs". Jeton de secours collé par l'équipe intégration :
const JETON_SECOURS = "⟬jwt#1⟭";
const expire = pm.environment.get("jeton_expire_le");
if (!expire || Date.now() > Number(expire)) {
  pm.sendRequest({
    url: pm.environment.get("base_url") + "/auth/token",
    method: "POST",
    header: { "Content-Type": "application/json", "X-Client-Secret": "⟬opaque_token#2⟭" },
    body: { mode: "raw", raw: JSON.stringify({ client_id: "tms-postman" }) },
  }, (err, res) => {
    pm.environment.set("jeton", err ? JETON_SECOURS : res.json().access_token);
    pm.environment.set("jeton_expire_le", Date.now() + 50 * 60 * 1000);
  });
}
⟬end⟭

⟬template⟭
family: code
format: .ts
language: fr
fill_locale: fr_FR
domain: education
appearance: object literal, template literal, comment
scenario: Firebase Admin initialisation of a high school app's Cloud Functions, with the service account pasted in during a demo to the education authority
⟬text⟭
// functions/src/admin.ts : initialisation Firebase Admin pour les Cloud Functions de l'appli « Mon Lycée »
import * as admin from "firebase-admin";
import sgMail from "@sendgrid/mail";

// Compte de service collé ici pendant la démo au rectorat, à remplacer par les secrets Functions
const compteService = {
  projectId: "mon-lycee-prod",
  clientEmail: "⟬email:generic#1⟭",
  privateKey: `⟬private_key#2⟭`,
};

admin.initializeApp({ credential: admin.credential.cert(compteService) });
sgMail.setApiKey("⟬sendgrid_api_key#3⟭");

export const configWeb = {
  apiKey: "⟬google_api_key#4⟭",
  authDomain: "mon-lycee-prod.firebaseapp.com",
  projectId: "mon-lycee-prod",
  storageBucket: "mon-lycee-prod.appspot.com",
  messagingSenderId: "583920174466",
  appId: "1:583920174466:web:4c1d2e9f8a7b6c5d",
};

export async function notifierAbsence(eleveId: string) {
  const eleve = (await admin.firestore().doc(`eleves/${eleveId}`).get()).data();
  if (!eleve) return;
  await sgMail.send({
    to: eleve.emailResponsable,
    from: "⟬email:generic#5⟭",
    subject: `Absence de ${eleve.prenom} ce jour`,
    text: `Bonjour, ${eleve.prenom} est noté(e) absent(e) en ${eleve.cours}. Merci de justifier l'absence sur l'ENT.`,
  });
}
⟬end⟭

⟬template⟭
family: code
format: .java
language: fr
fill_locale: fr_FR
domain: logistics
appearance: JDBC URL, command-line usage, output sample
scenario: one-off Java tool of a warehouse listing the dock slots booked by a carrier, run from a developer laptop against the production replica
⟬text⟭
// Outil ponctuel : liste les créneaux de quai réservés par un transporteur.
// Usage : java ExportCreneaux ⟬fr_siret#1⟭
public class ExportCreneaux {
    public static void main(String[] args) throws Exception {
        String url = "jdbc:postgresql://⟬hostname#2⟭:5432/wms?user=wms_lecture&password=⟬url_password#2⟭&ssl=true";
        try (Connection c = DriverManager.getConnection(url);
             PreparedStatement ps = c.prepareStatement("SELECT quai, debut, plaque FROM creneaux WHERE siret_transporteur = ? ORDER BY debut")) {
            ps.setString(1, args[0]);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) System.out.println(rs.getString(1) + ";" + rs.getTimestamp(2) + ";" + rs.getString(3));
            }
        }
    }
}
// sortie du ⟬date#1⟭ : Q07;⟬date#1⟭ 06:30;⟬fr_license_plate#3⟭
⟬end⟭

⟬template⟭
family: code
format: .kt
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: HTTP header, KDoc, comment
scenario: payment screen of a clothing rental Android app that creates the PaymentIntent from the device with the secret key until the back end is ready
⟬text⟭
package fr.modeloc.app.paiement

import android.os.Bundle
import androidx.activity.ComponentActivity
import com.stripe.android.PaymentConfiguration
import com.stripe.android.paymentsheet.PaymentSheet
import com.stripe.android.paymentsheet.PaymentSheetResult
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.runBlocking
import kotlinx.coroutines.withContext
import okhttp3.FormBody
import okhttp3.OkHttpClient
import okhttp3.Request
import org.json.JSONObject

/**
 * Écran de paiement de la location de tenue.
 * NE PAS LIVRER EN L'ÉTAT : en attendant l'endpoint du back, l'appli crée elle-même le
 * PaymentIntent avec la clé secrète. À retirer avant la soumission au Play Store.
 */
class PaiementActivity : ComponentActivity() {

    private lateinit var feuille: PaymentSheet

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        PaymentConfiguration.init(this, "⟬stripe_publishable_key#1⟭")
        feuille = PaymentSheet(this, ::surResultat)
        val secretClient = runBlocking { creerIntent(intent.getIntExtra("montant", 0)) }
        feuille.presentWithPaymentIntent(secretClient, PaymentSheet.Configuration("ModeLoc"))
    }

    private suspend fun creerIntent(montantCentimes: Int): String = withContext(Dispatchers.IO) {
        val requete = Request.Builder()
            .url("https://api.stripe.com/v1/payment_intents")
            .header("Authorization", "Bearer ⟬stripe_secret_key#1⟭")
            .post(FormBody.Builder().add("amount", montantCentimes.toString()).add("currency", "eur").build())
            .build()
        OkHttpClient().newCall(requete).execute().use { JSONObject(it.body!!.string()).getString("client_secret") }
    }

    private fun surResultat(resultat: PaymentSheetResult) {
        when (resultat) {
            is PaymentSheetResult.Completed -> finish()
            is PaymentSheetResult.Canceled -> Unit
            is PaymentSheetResult.Failed -> afficherErreur(resultat.error.message)
        }
    }

    // carte utilisée pendant la démo au client : ⟬payment_card#2⟭, 12/28, ⟬card_security_code#2⟭
}
⟬end⟭

⟬template⟭
family: code
format: .php
language: fr
fill_locale: fr_FR
domain: education
appearance: constant, SQL query, SMTP setting, comment, HTML form
scenario: legacy canteen payment page of a town school fund, plain PHP maintained by the town hall IT department, with the acceptance family left in comments
⟬text⟭
<?php
/*
 * cantine/paiement.php - Portail familles de la caisse des écoles
 * Paiement des repas du mois par carte (formulaire du centre de paiement de la banque) ou par prélèvement.
 * Maintenu par le service informatique de la mairie. PHP 7.4, pas de framework.
 */
session_start();
require __DIR__ . '/../lib/db.php';
require __DIR__ . '/../lib/PHPMailer/PHPMailer.php';

const CLE_HMAC_BANQUE = '⟬opaque_token#1⟭';
const NUMERO_COMMERCANT = '⟬customer_id#2⟭';
const URL_PAIEMENT = 'https://⟬hostname#3⟭/paiement/formulaire';

if (empty($_SESSION['famille_id'])) {
    header('Location: /connexion.php');
    exit;
}

$famille = db_ligne("SELECT * FROM familles WHERE id = ?", [$_SESSION['famille_id']]);
$enfants = db_lignes("SELECT id, prenom, nom, date_naissance, classe FROM enfants WHERE famille_id = ? AND actif = 1", [$famille['id']]);
$mois = date('Y-m');
$total = 0;
foreach ($enfants as $e) {
    $nb = db_valeur("SELECT COUNT(*) FROM repas WHERE enfant_id = ? AND DATE_FORMAT(jour, '%Y-%m') = ?", [$e['id'], $mois]);
    $total += $nb * tarif_repas($famille['quotient_familial']);
}

if ($_SERVER['REQUEST_METHOD'] === 'POST' && ($_POST['mode'] ?? '') === 'prelevement') {
    db_executer("UPDATE familles SET iban = ?, mode_paiement = 'PRELEVEMENT' WHERE id = ?", [strtoupper(str_replace(' ', '', $_POST['iban'])), $famille['id']]);
    $mail = new PHPMailer\PHPMailer\PHPMailer();
    $mail->isSMTP();
    $mail->Host = 'smtp.sendgrid.net';
    $mail->SMTPAuth = true;
    $mail->Username = 'apikey';
    $mail->Password = '⟬sendgrid_api_key#4⟭';
    $mail->setFrom('⟬email:generic#5⟭', 'Caisse des écoles');
    $mail->addAddress($famille['email']);
    $mail->Subject = 'Mandat de prélèvement enregistré';
    $mail->Body = "Votre IBAN se terminant par " . substr($_POST['iban'], -4) . " sera prélevé le 10 de chaque mois.";
    $mail->send();
    header('Location: /cantine/merci.php');
    exit;
}

$params = [
    'commercant' => NUMERO_COMMERCANT,
    'montant' => (int) round($total * 100),
    'reference' => 'CANT-' . $famille['id'] . '-' . $mois,
    'retour' => 'https://' . $_SERVER['HTTP_HOST'] . '/cantine/retour.php',
];
ksort($params);
$params['signature'] = hash_hmac('sha256', http_build_query($params), CLE_HMAC_BANQUE);

// Famille de test (recette) : ⟬person_name#6⟭, ⟬fr_postal_address#6⟭, tél ⟬phone#6⟭
// enfants : ⟬person_name:given#7⟭ née le ⟬birth_date#7f⟭ (CE1), ⟬person_name:given#8⟭ né le ⟬birth_date#8m⟭ (CM2)
// prélèvement testé avec ⟬iban#6⟭ ; carte de recette de la banque ⟬payment_card#6⟭ exp 12/27 crypto ⟬card_security_code#6⟭
?>
<!doctype html>
<html lang="fr">
<head><meta charset="utf-8"><title>Paiement de la cantine</title></head>
<body>
<h1>Repas du mois <?= htmlspecialchars($mois) ?></h1>
<ul>
<?php foreach ($enfants as $e): ?>
  <li><?= htmlspecialchars($e['prenom'] . ' ' . $e['nom']) ?> (<?= htmlspecialchars($e['classe']) ?>)</li>
<?php endforeach; ?>
</ul>
<p>Total à régler : <strong><?= number_format($total, 2, ',', ' ') ?> €</strong></p>
<form method="post" action="<?= URL_PAIEMENT ?>">
<?php foreach ($params as $k => $v): ?>
  <input type="hidden" name="<?= $k ?>" value="<?= htmlspecialchars($v) ?>">
<?php endforeach; ?>
  <button>Payer par carte</button>
</form>
<form method="post">
  <input type="hidden" name="mode" value="prelevement">
  <label>IBAN <input name="iban" required></label>
  <button>Passer au prélèvement</button>
</form>
</body>
</html>
⟬end⟭

⟬template⟭
family: code
format: .js
language: fr
fill_locale: fr_FR
domain: telecom
appearance: test table, function argument, string literal
scenario: Jest tests of the masking helpers used by a mobile operator's call centre screen, run on a sample of values copied from the acceptance CRM
⟬text⟭
const { masquerTelephone, masquerEmail, masquerPiece, masquerIban, masquerCarte } = require("../src/masquage");

// Écran conseiller : seule la fin des données apparaît, le reste après authentification forte du client.
describe("masquage de l'écran conseiller", () => {
  test.each([["⟬phone#1⟭"], ["⟬phone#2⟭"], ["⟬phone#3⟭"]])("téléphone %s : deux derniers chiffres visibles", (tel) => {
    const masque = masquerTelephone(tel);
    expect(masque.slice(-2)).toBe(tel.replace(/\D/g, "").slice(-2));
    expect(masque).toMatch(/^[•\s]+\d{2}$/);
  });

  test("email", () => {
    expect(masquerEmail("⟬email#4⟭")).toMatch(/^.\*+@/);
  });

  test("pièce d'identité", () => {
    expect(masquerPiece("⟬fr_identity_card#5⟭")).toHaveLength(12);
    expect(masquerPiece("⟬fr_passport#6⟭").startsWith("•••")).toBe(true);
  });

  test("IBAN et carte", () => {
    expect(masquerIban("⟬iban#7⟭").endsWith("⟬iban#7⟭".slice(-4))).toBe(true);
    expect(masquerCarte("⟬payment_card#8⟭")).not.toContain("⟬payment_card#8⟭");
    expect(masquerCarte("⟬card_security_code#8⟭", { cvc: true })).toBe("•••");
  });
});
⟬end⟭

⟬template⟭
family: code
format: .ts
language: fr
fill_locale: fr_FR
domain: real estate
appearance: object literal, comment, unit test
scenario: regression test of a rental application schema, written after a branch reported that a valid applicant had been rejected
⟬text⟭
import { candidatureSchema } from "./candidature.schema";

// cas remonté par l'agence de ⟬city#1⟭ : refusé à tort, la date était au format JJ/MM/AAAA
const brut = { nom: "⟬person_name#2⟭", dateNaissance: "⟬birth_date#2⟭", cni: "⟬fr_identity_card#2⟭", revenusNets: 2350, garant: false };

test("accepte une date de naissance au format français", () => {
  const resultat = candidatureSchema.safeParse(brut);
  expect(resultat.success).toBe(true);
});
⟬end⟭

⟬template⟭
family: code
format: .kt
language: fr
fill_locale: fr_FR
domain: logistics
appearance: constant, route handler, block comment
scenario: Ktor login route of a delivery company's driver app, authenticating with licence number and birth date, with the acceptance data set noted below the code
⟬text⟭
package fr.tourneo.api.auth

import com.auth0.jwt.JWT
import com.auth0.jwt.algorithms.Algorithm
import io.ktor.http.HttpStatusCode
import io.ktor.server.application.Application
import io.ktor.server.application.call
import io.ktor.server.request.receive
import io.ktor.server.response.respond
import io.ktor.server.routing.post
import io.ktor.server.routing.routing
import java.time.Instant
import java.time.LocalDate
import kotlinx.serialization.Serializable

@Serializable
data class DemandeConnexion(val numeroPermis: String, val dateNaissance: String, val vehicule: String)

@Serializable
data class ReponseConnexion(val jeton: String, val tournee: String?)

// secret HMAC des jetons chauffeurs : en dur depuis la v1, le coffre n'est pas encore branché
private const val SECRET_JETON = "⟬opaque_token#1⟭"
private val algorithme = Algorithm.HMAC256(SECRET_JETON)

// Les chauffeurs du sous-traitant passent par ⟬trap:code_identifier|Connexion⦃Family⦄Transports⟭ (SSO de leur employeur).
fun Application.routesConnexionChauffeur(chauffeurs: ChauffeurRepository, tournees: TourneeRepository) {
    routing {
        post("/chauffeurs/connexion") {
            val demande = call.receive<DemandeConnexion>()
            val chauffeur = chauffeurs.parPermis(demande.numeroPermis.uppercase().replace(" ", ""))
            if (chauffeur == null || chauffeur.dateNaissance != LocalDate.parse(demande.dateNaissance)) {
                call.respond(HttpStatusCode.Unauthorized, mapOf("erreur" to "identifiants"))
                return@post
            }
            if (demande.vehicule !in chauffeur.vehiculesAutorises) {
                call.respond(HttpStatusCode.Forbidden, mapOf("erreur" to "vehicule_non_autorise"))
                return@post
            }
            val jeton = JWT.create()
                .withIssuer("tourneo")
                .withSubject(chauffeur.id.toString())
                .withClaim("vehicule", demande.vehicule)
                .withExpiresAt(Instant.now().plusSeconds(12 * 3600))
                .sign(algorithme)
            call.respond(ReponseConnexion(jeton, tournees.duJour(chauffeur.id)?.code))
        }
    }
}

/*
 * Jeu d'essai de la recette (base tourneo_recette) :
 *   ⟬person_name#2⟭, permis ⟬fr_driving_licence#2⟭, né le ⟬birth_date#2m⟭, tél ⟬phone#2⟭
 *   véhicules autorisés : ⟬fr_license_plate#3⟭, ⟬fr_license_plate#4⟭
 * Jeton obtenu le ⟬date#1⟭, pour rejouer dans Postman :
 *   ⟬jwt#5⟭
 */
⟬end⟭

⟬template⟭
family: code
format: .java
language: fr
fill_locale: fr_FR
domain: travel
appearance: test property, fixture call, assertion
scenario: Spring Boot integration test of a car-sharing booking service, with provider keys passed as test properties
⟬text⟭
package fr.autopartage.reservation;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.contains;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.verify;

import java.time.Duration;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.test.context.TestPropertySource;

@SpringBootTest
@TestPropertySource(properties = {
    "cartes.google.api-key=⟬google_api_key#1⟭",
    "notifications.sendgrid.api-key=⟬sendgrid_api_key#2⟭",
    "notifications.expediteur=⟬email:generic#3⟭",
    "⟬trap:indicator_non_pii|verification.token-ttl=PT15M⟭",
})
class ReservationServiceIT {

    @Autowired
    private ReservationService service;

    @Autowired
    private FlotteFixtures flotte;

    @Autowired
    private MembreFixtures membres;

    @MockBean
    private NotificationClient notifications;

    @BeforeEach
    void garerLesVoitures() {
        flotte.garer("⟬fr_license_plate#5⟭", 45.7601, 4.8430);
        flotte.garer("⟬fr_license_plate#6⟭", 45.7710, 4.8550);
        flotte.garer("⟬fr_license_plate#7⟭", 45.7480, 4.8270);
    }

    @Test
    void reserveLaVoitureLaPlusProche() {
        Membre membre = membres.creer("⟬person_name#4⟭", "⟬email#4⟭", "PASSEPORT", "⟬fr_passport#4⟭");

        Reservation r = service.reserver(membre, new Position(45.7597, 4.8422), Duration.ofHours(3));

        assertThat(r.vehicule().immatriculation()).isEqualTo("⟬fr_license_plate#5⟭");
        verify(notifications).envoyer(eq("⟬email#4⟭"), contains("⟬fr_license_plate#5⟭"));
    }

    @Test
    void refuseUnMembreDontLaPieceNEstPasVerifiee() {
        Membre membre = membres.creerNonVerifie("⟬person_name#8⟭", "⟬email#8⟭");

        assertThatThrownBy(() -> service.reserver(membre, new Position(45.7597, 4.8422), Duration.ofHours(1)))
            .isInstanceOf(PieceNonVerifieeException.class);
    }
}
⟬end⟭

⟬template⟭
family: code
format: .js
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: nested JSON, constant, HTTP header, test fixture
scenario: Supertest test of the order webhook of a tea shop selling on a marketplace, with the payload copied from the marketplace's webhook log
⟬text⟭
const crypto = require("crypto");
const request = require("supertest");
const app = require("../app");

const SECRET_WEBHOOK = "⟬opaque_token#1⟭";

function signer(corps) {
  return crypto.createHmac("sha256", SECRET_WEBHOOK).update(corps).digest("base64");
}

// charge utile copiée depuis le journal des webhooks de la marketplace
const commande = {
  id: "⟬order_number#2⟭",
  created_at: "⟬date#1⟭",
  customer: { first_name: "⟬person_name:given#3⟭", last_name: "⟬person_name:family#3⟭", email: "⟬email#3⟭", phone: "⟬phone#3⟭" },
  shipping_address: { address1: "⟬fr_postal_address:street#3⟭", zip: "⟬postcode#3⟭", city: "⟬city#3⟭", country_code: "FR" },
  line_items: [{ sku: "THE-VERT-SENCHA-100G", quantity: 2, price: "12.90" }],
  payment: { gateway: "carte", last4: "4417" },
};

describe("POST /webhooks/commandes", () => {
  it("accepte une commande signée", async () => {
    const corps = JSON.stringify(commande);
    await request(app)
      .post("/webhooks/commandes")
      .set("Content-Type", "application/json")
      .set("X-Signature", signer(corps))
      .send(corps)
      .expect(202);
  });

  it("refuse une signature invalide", async () => {
    await request(app).post("/webhooks/commandes").set("X-Signature", "abc").send(commande).expect(401);
  });
});
⟬end⟭

⟬template⟭
family: code
format: .ts
language: fr
fill_locale: fr_FR
domain: telecom
appearance: environment variable fallback, constant, exception message, comment
scenario: transactional SMS module of a fibre internet provider, which reroutes every message to a test phone outside production
⟬text⟭
import twilio from "twilio";

/**
 * Envoi des SMS transactionnels (rendez-vous technicien, suivi de la box).
 * Expéditeur alphanumérique déclaré auprès de l'opérateur pour la société SIREN ⟬fr_siren#1⟭.
 */
const client = twilio(process.env.TWILIO_SID, process.env.TWILIO_TOKEN ?? "⟬opaque_token#2⟭");

const EXPEDITEUR = "BOXFIBRE";
// hors production, tous les SMS partent sur ce téléphone de test quel que soit le destinataire
const NUMERO_RECETTE = "⟬phone#3⟭";

export async function envoyerSms(destinataire: string, texte: string): Promise<string> {
  const vers = process.env.NODE_ENV === "production" ? destinataire : NUMERO_RECETTE;
  if (!/^\+33[67]\d{8}$/.test(vers)) {
    throw new Error(`numéro non mobile ou mal formaté : ${vers}`);
  }
  const message = await client.messages.create({ from: EXPEDITEUR, to: vers, body: texte });
  return message.sid;
}

export const MODELES = {
  rendezVous: (creneau: string) => `Votre technicien passera le ${creneau}. Pour décaler le rendez-vous, répondez STOP RDV.`,
  boxExpediee: (suivi: string) => `Votre box est en route, suivi : ${suivi}.`,
  coupure: (heure: string) => `Intervention sur le réseau à ${heure}, coupure possible de 30 min.`,
};

// dernier échec en recette (⟬date#1⟭) : numéro non mobile ou mal formaté : ⟬phone#4⟭
⟬end⟭

⟬template⟭
family: code
format: .ts
language: fr
fill_locale: fr_FR
domain: logistics
appearance: JSDoc, function signature, comment
scenario: route building module of a regional parcel carrier implementing the savings heuristic, written by an operations research engineer
⟬text⟭
/**
 * Construction des tournées par la méthode des économies de ⟬trap:eponym|Clarke et Wright⟭ (1964).
 * On part d'une tournée aller-retour par client, puis on fusionne les paires qui économisent
 * le plus de kilomètres tant que la capacité du véhicule le permet.
 */
export interface Point {
  id: string;
  lat: number;
  lng: number;
  demande: number;
}

const RAYON_TERRE_KM = 6371;

export function distanceKm(a: Point, b: Point): number {
  const rad = (d: number) => (d * Math.PI) / 180;
  const dLat = rad(b.lat - a.lat);
  const dLng = rad(b.lng - a.lng);
  const h = Math.sin(dLat / 2) ** 2 + Math.cos(rad(a.lat)) * Math.cos(rad(b.lat)) * Math.sin(dLng / 2) ** 2;
  return 2 * RAYON_TERRE_KM * Math.asin(Math.sqrt(h));
}

interface Economie {
  i: string;
  j: string;
  gain: number;
}

export function ⟬trap:code_identifier|economiesClarkeWright⟭(depot: Point, clients: Point[], capacite: number): string[][] {
  const parId = new Map(clients.map((c) => [c.id, c]));
  const tournees = new Map<string, string[]>(clients.map((c) => [c.id, [c.id]]));
  const charge = new Map<string[], number>();
  tournees.forEach((t) => charge.set(t, parId.get(t[0])!.demande));

  const economies: Economie[] = [];
  for (let a = 0; a < clients.length; a++) {
    for (let b = a + 1; b < clients.length; b++) {
      const ci = clients[a];
      const cj = clients[b];
      const gain = distanceKm(depot, ci) + distanceKm(depot, cj) - distanceKm(ci, cj);
      economies.push({ i: ci.id, j: cj.id, gain });
    }
  }
  economies.sort((x, y) => y.gain - x.gain);

  for (const { i, j } of economies) {
    const ti = tournees.get(i)!;
    const tj = tournees.get(j)!;
    if (ti === tj) continue;
    // on ne fusionne que par les extrémités, sinon la tournée repasserait par un client
    const iEnBout = ti[ti.length - 1] === i;
    const jEnTete = tj[0] === j;
    if (!iEnBout || !jEnTete) continue;
    const total = charge.get(ti)! + charge.get(tj)!;
    if (total > capacite) continue;
    const fusion = [...ti, ...tj];
    charge.delete(ti);
    charge.delete(tj);
    charge.set(fusion, total);
    fusion.forEach((id) => tournees.set(id, fusion));
  }

  return Array.from(new Set(tournees.values()));
}
⟬end⟭

⟬template⟭
family: code
format: .java
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: constant, property placeholder, comment
scenario: password hashing configuration of a fashion retailer's customer accounts, written during a security audit
⟬text⟭
@Configuration
public class MotsDePasseConfig {

    // recommandation de l'audit : bcrypt coût 12, poivre stocké hors base
    ⟬trap:indicator_non_pii|public static final int PASSWORD_MIN_LENGTH = 12⟭;
    ⟬trap:indicator_non_pii|public static final String DEFAULT_ADMIN_USER = "admin"⟭;

    @Bean
    public PasswordEncoder encodeur(@Value("⟬trap:placeholder|${securite.poivre}⟭") String poivre) {
        return new PoivreBCryptEncoder(new BCryptPasswordEncoder(12), poivre);
    }
}
⟬end⟭

⟬template⟭
family: code
format: .php
language: fr
fill_locale: fr_FR
domain: real estate
appearance: docblock, array literal, string formatting
scenario: Twig extension of a new-build property portal formatting areas, prices and energy labels, documented with residence names from developers' feeds
⟬text⟭
<?php

namespace App\Twig;

use Twig\Extension\AbstractExtension;
use Twig\TwigFilter;

/**
 * Filtres d'affichage des annonces : surface, prix, étiquette énergie.
 * Les noms de résidence viennent du flux des promoteurs, par exemple « Villa ⟬trap:word_name|Margaux⟭ »
 * ou « Le Clos des ⟬trap:word_name|Capucines⟭ » chez ⟬trap:company_name|Bouygues Immobilier⟭.
 */
final class AnnonceExtension extends AbstractExtension
{
    private const COULEURS_DPE = [
        'A' => '#009c6d',
        'B' => '#52b153',
        'C' => '#a5cc74',
        'D' => '#f4e70f',
        'E' => '#f0b40f',
        'F' => '#eb8235',
        'G' => '#d7221f',
    ];

    public function getFilters(): array
    {
        return [
            new TwigFilter('surface', [$this, 'surface']),
            new TwigFilter('prix', [$this, 'prix']),
            new TwigFilter('etiquette_dpe', [$this, 'etiquetteDpe'], ['is_safe' => ['html']]),
        ];
    }

    public function surface(float $m2): string
    {
        return number_format($m2, $m2 == floor($m2) ? 0 : 1, ',', "\u{202F}") . "\u{202F}m²";
    }

    public function prix(int $euros, bool $horsCharges = false): string
    {
        return number_format($euros, 0, ',', "\u{202F}") . "\u{202F}€" . ($horsCharges ? ' HC' : '');
    }

    public function etiquetteDpe(?string $classe): string
    {
        if ($classe === null || !isset(self::COULEURS_DPE[$classe])) {
            return '<span class="dpe dpe-vierge">DPE vierge</span>';
        }
        return sprintf('<span class="dpe" style="background:%s">%s</span>', self::COULEURS_DPE[$classe], $classe);
    }
}
⟬end⟭

⟬template⟭
family: code
format: .kt
language: fr
fill_locale: fr_FR
domain: travel
appearance: SQL query, annotation
scenario: Room DAO of a ferry company's app storing passengers offline for boarding without network
⟬text⟭
@Dao
interface PassagerDao {
    @Query("SELECT * FROM passagers WHERE reservation_id = :reservationId ORDER BY rang")
    suspend fun parReservation(reservationId: String): List<PassagerEntity>

    @Query("⟬trap:indicator_non_pii|SELECT * FROM passagers WHERE nom = :nom AND date_naissance = :dateNaissance⟭")
    suspend fun rechercher(nom: String, dateNaissance: String): PassagerEntity?

    @Query("DELETE FROM passagers WHERE reservation_id IN (SELECT id FROM reservations WHERE depart < :limite)")
    suspend fun purgerAvant(limite: Long): Int
}
⟬end⟭

⟬template⟭
family: code
format: .js
language: fr
fill_locale: fr_FR
domain: education
appearance: environment variable fallback, constant, comment, CSV processing
scenario: Node script of a school district data officer pseudonymising the pupil export before sending it to a statistics contractor
⟬text⟭
// pseudonymiser-export.js : transforme l'export élèves avant l'envoi au prestataire de statistiques.
// Noms, dates de naissance et INE sont remplacés par un code stable (HMAC) ; la classe et la commune restent.
const crypto = require("crypto");
const fs = require("fs");
const { parse } = require("csv-parse/sync");
const { stringify } = require("csv-stringify/sync");

const SEL = process.env.SEL_PSEUDO || "⟬trap:placeholder|changeme⟭";
if (SEL === "changeme") {
  console.warn("SEL_PSEUDO non défini : les codes ne seront pas stables d'un export à l'autre");
}
const ⟬trap:indicator_non_pii|FORMAT_DATE_NAISSANCE = "AAAA-MM-JJ"⟭;
const COLONNES_A_SUPPRIMER = ["nom", "prenom", "date_naissance", "ine", "email_responsable", "tel_responsable"];

function code(valeur) {
  return crypto.createHmac("sha256", SEL).update(valeur).digest("hex").slice(0, 16);
}

function trancheAge(dateNaissance, reference) {
  const [annee, mois, jour] = dateNaissance.split("-").map(Number);
  let age = reference.getFullYear() - annee;
  if (reference.getMonth() + 1 < mois || (reference.getMonth() + 1 === mois && reference.getDate() < jour)) age -= 1;
  if (age < 11) return "moins de 11 ans";
  if (age <= 14) return "11-14 ans";
  return "15 ans et plus";
}

const [entree, sortie] = process.argv.slice(2);
if (!entree || !sortie) {
  console.error(`usage : node pseudonymiser-export.js export.csv sortie.csv (dates au format ${FORMAT_DATE_NAISSANCE})`);
  process.exit(2);
}

const lignes = parse(fs.readFileSync(entree), { columns: true, delimiter: ";" });
const resultat = lignes.map((l) => {
  const copie = { ...l, code_eleve: code(l.ine), tranche_age: trancheAge(l.date_naissance, new Date()) };
  for (const c of COLONNES_A_SUPPRIMER) delete copie[c];
  return copie;
});
fs.writeFileSync(sortie, stringify(resultat, { header: true, delimiter: ";" }));
console.log(`${resultat.length} lignes pseudonymisées -> ${sortie}`);
⟬end⟭
