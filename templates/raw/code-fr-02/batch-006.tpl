⟬template⟭
family: code
format: .kt
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: Compose preview, named argument
scenario: Jetpack Compose preview of the saved card component of a shopping app, with full card data typed in by the designer-developer
⟬text⟭
@Preview(showBackground = true, name = "Carte enregistrée")
@Composable
private fun ApercuCarteEnregistree() {
    ThemeBoutique {
        CarteEnregistree(
            titulaire = "⟬person_name#1⟭",
            email = "⟬email#1⟭",
            numero = "⟬payment_card#1⟭",
            cryptogramme = "⟬card_security_code#1⟭", // pour l'animation de retournement
            expiration = "08/29",
            onSupprimer = {},
        )
    }
}
⟬end⟭

⟬template⟭
family: code
format: .js
language: fr
fill_locale: fr_FR
domain: travel
appearance: Apps Script, 2D array, template literal, script property fallback
scenario: Google Apps Script bound to a group travel spreadsheet that emails confirmations to travellers, with a function filling the test tab
⟬text⟭
/**
 * Apps Script lié à la feuille « Groupes été » : envoie la confirmation à chaque voyageur
 * et ajoute un lien vers l'hôtel. Menu Groupes > Envoyer les confirmations.
 */
const FEUILLE = "Voyageurs";
const COLONNES = { nom: 0, email: 1, telephone: 2, naissance: 3, passeport: 4, hotel: 5, envoye: 6 };
const CLE_MAPS = PropertiesService.getScriptProperties().getProperty("CLE_MAPS") || "⟬google_api_key#1⟭";

function onOpen() {
  SpreadsheetApp.getUi().createMenu("Groupes").addItem("Envoyer les confirmations", "envoyerConfirmations").addToUi();
}

function envoyerConfirmations() {
  const feuille = SpreadsheetApp.getActive().getSheetByName(FEUILLE);
  const lignes = feuille.getDataRange().getValues();
  let envoyes = 0;
  for (let i = 1; i < lignes.length; i++) {
    const l = lignes[i];
    if (l[COLONNES.envoye] === "oui" || !l[COLONNES.email]) continue;
    const plan = lienPlan(l[COLONNES.hotel]);
    GmailApp.sendEmail(l[COLONNES.email], "Votre séjour de groupe : confirmation", "", {
      htmlBody:
        `<p>Bonjour ${l[COLONNES.nom]},</p><p>Votre place est confirmée. Hôtel : ${l[COLONNES.hotel]} (<a href="${plan}">plan</a>).</p>` +
        `<p>Vérifiez que votre passeport ${l[COLONNES.passeport]} est valable six mois après le retour.</p>`,
      name: "Service groupes",
      replyTo: "⟬email:generic#2⟭",
    });
    feuille.getRange(i + 1, COLONNES.envoye + 1).setValue("oui");
    envoyes++;
  }
  SpreadsheetApp.getActive().toast(`${envoyes} confirmation(s) envoyée(s)`);
}

function lienPlan(adresse) {
  const url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + encodeURIComponent(adresse) + "&key=" + CLE_MAPS;
  const reponse = JSON.parse(UrlFetchApp.fetch(url).getContentText());
  if (reponse.status !== "OK") return "https://maps.google.com/?q=" + encodeURIComponent(adresse);
  const { lat, lng } = reponse.results[0].geometry.location;
  return `https://maps.google.com/?q=${lat},${lng}`;
}

/** Données de test pour la copie de la feuille (onglet « Voyageurs (test) »). */
function remplirTest() {
  const feuille = SpreadsheetApp.getActive().getSheetByName("Voyageurs (test)");
  feuille.getRange(2, 1, 3, 7).setValues([
    ["⟬person_name#3⟭", "⟬email#3⟭", "⟬phone#3⟭", "⟬birth_date#3⟭", "⟬fr_passport#3⟭", "⟬fr_postal_address#4⟭", ""],
    ["⟬person_name#5⟭", "⟬email#5⟭", "⟬phone#5⟭", "⟬birth_date#5⟭", "⟬fr_passport#5⟭", "⟬fr_postal_address#4⟭", ""],
    ["⟬person_name#6⟭", "⟬email#6⟭", "⟬phone#6⟭", "⟬birth_date#6⟭", "⟬fr_passport#6⟭", "⟬fr_postal_address#4⟭", ""],
  ]);
}

function relancerSansPasseport() {
  const lignes = SpreadsheetApp.getActive().getSheetByName(FEUILLE).getDataRange().getValues().slice(1);
  lignes
    .filter((l) => !l[COLONNES.passeport])
    .forEach((l) => {
      GmailApp.sendEmail(
        l[COLONNES.email],
        "Passeport manquant",
        `Bonjour ${l[COLONNES.nom]}, merci de nous transmettre le numéro de votre passeport avant le départ.`,
      );
    });
}
⟬end⟭

⟬template⟭
family: code
format: .java
language: fr
fill_locale: fr_FR
domain: logistics
appearance: Selenium input, cookie, comment, assertion
scenario: Selenium end-to-end test of a carrier portal where drivers register their vehicle, with a session cookie shortcut for the second test
⟬text⟭
package fr.tourneo.e2e;

import static org.assertj.core.api.Assertions.assertThat;

import java.time.Duration;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.Cookie;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

class PortailTransporteurE2E {

    private static final String BASE = "https://⟬hostname#1⟭";
    private WebDriver driver;

    @BeforeEach
    void ouvrir() {
        driver = new ChromeDriver();
        driver.get(BASE + "/connexion");
    }

    @AfterEach
    void fermer() {
        driver.quit();
    }

    @Test
    void unChauffeurDeclareSonVehicule() {
        driver.findElement(By.id("identifiant")).sendKeys("⟬email#2⟭");
        driver.findElement(By.id("motDePasse")).sendKeys("⟬password#2⟭");
        driver.findElement(By.cssSelector("button[type=submit]")).click();

        new WebDriverWait(driver, Duration.ofSeconds(10)).until(ExpectedConditions.urlContains("/tableau"));
        driver.get(BASE + "/vehicule");
        driver.findElement(By.name("plaque")).sendKeys("⟬fr_license_plate#3⟭");
        driver.findElement(By.name("permis")).sendKeys("⟬fr_driving_licence#2⟭");
        driver.findElement(By.id("enregistrer")).click();

        assertThat(driver.findElement(By.cssSelector(".alerte-succes")).getText()).contains("⟬fr_license_plate#3⟭");
    }

    @Test
    void sessionInjecteeDepuisUnJeton() {
        // contourne l'écran de connexion avec un jeton de recette (compte de ⟬person_name#4⟭)
        driver.manage().addCookie(new Cookie("session", "⟬jwt#4⟭"));
        driver.get(BASE + "/tableau");
        assertThat(driver.getTitle()).startsWith("Tableau de bord");
    }
}
⟬end⟭

⟬template⟭
family: code
format: .php
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: setter chain, configuration path, comment
scenario: Magento 2 data patch of a B2B kitchenware store creating the demo company account for a trade show and switching card payments to live mode
⟬text⟭
<?php
declare(strict_types=1);

namespace Boutique\B2b\Setup\Patch\Data;

use Magento\Company\Api\CompanyRepositoryInterface;
use Magento\Company\Api\Data\CompanyInterfaceFactory;
use Magento\Framework\App\Config\Storage\WriterInterface;
use Magento\Framework\Setup\Patch\DataPatchInterface;

/**
 * Crée le compte entreprise de démonstration du salon professionnel et active le paiement par carte B2B.
 */
class CreerCompteDemoB2b implements DataPatchInterface
{
    public function __construct(
        private CompanyInterfaceFactory $fabrique,
        private CompanyRepositoryInterface $entreprises,
        private WriterInterface $config,
    ) {
    }

    public function apply(): self
    {
        $entreprise = $this->fabrique->create();
        $entreprise->setCompanyName('⟬company#1⟭')
            ->setLegalName('⟬company#1⟭ SAS')
            // pas de champ SIREN dans le module Company : on le range dans reseller_id
            ->setResellerId('⟬fr_siren#1⟭')
            ->setCompanyEmail('⟬email:generic#2⟭')
            ->setTelephone('⟬phone#1⟭')
            ->setStreet(['⟬fr_postal_address:street#1⟭'])
            ->setPostcode('⟬postcode#1⟭')
            ->setCity('⟬city#1⟭')
            ->setCountryId('FR')
            ->setSuperUserId(1)
            ->setCustomerGroupId(4);
        $this->entreprises->save($entreprise);

        // contact commercial chez le client : ⟬person_name#3⟭ (⟬email#3⟭, ⟬phone#3⟭)
        $this->config->save('payment/stripe_payments/basic/secret_key', '⟬stripe_secret_key#4⟭');
        $this->config->save('payment/stripe_payments/basic/mode', 'live');

        return $this;
    }

    public static function getDependencies(): array
    {
        return [];
    }

    public function getAliases(): array
    {
        return [];
    }
}
⟬end⟭

⟬template⟭
family: code
format: .ts
language: fr
fill_locale: fr_FR
domain: telecom
appearance: HTTP header, JSON body, template literal
scenario: Cloudflare Worker of a messaging operator relaying SMS delivery receipts, which emails the on-call rota when the internal API fails
⟬text⟭
// worker.ts : relaie les accusés de réception SMS vers notre API, alerte l'astreinte si elle répond en erreur
export default {
  async fetch(req: Request, env: { API_URL: string }): Promise<Response> {
    const corps = await req.text();
    const r = await fetch(`${env.API_URL}/sms/accuses`, { method: "POST", body: corps, headers: { "Content-Type": "application/json" } });
    if (!r.ok) {
      await fetch("https://api.sendgrid.com/v3/mail/send", {
        method: "POST",
        headers: { Authorization: "Bearer ⟬sendgrid_api_key#1⟭", "Content-Type": "application/json" },
        body: JSON.stringify({
          personalizations: [{ to: [{ email: "⟬email:generic#2⟭" }] }],
          from: { email: "⟬email:generic#3⟭" },
          subject: "Accusés SMS en échec",
          content: [{ type: "text/plain", value: `API en erreur (${r.status}), appeler l'astreinte au ⟬phone#4⟭` }],
        }),
      });
    }
    return new Response("ok");
  },
};
⟬end⟭

⟬template⟭
family: code
format: .js
language: fr
fill_locale: fr_FR
domain: education
appearance: mongosh script, document literal, comment
scenario: mongosh seed script of a vocational exam centre creating fictitious candidates to test the mock exam convocations
⟬text⟭
// seed-candidats.js : mongosh "mongodb://localhost/examens" seed-candidats.js
// Candidats fictifs pour tester les convocations du BTS blanc. NE PAS lancer sur la base de production.
db.candidats.drop();
db.candidats.insertMany([
  {
    nom: "⟬person_name:family#1⟭",
    prenom: "⟬person_name:given#1⟭",
    naissance: "⟬birth_date#1⟭",
    email: "⟬email#1⟭",
    mobile: "⟬phone#1⟭",
    piece: { type: "CNI", numero: "⟬fr_identity_card#1⟭" },
    section: "BTS SIO",
    tiersTemps: false,
  },
  {
    nom: "⟬person_name:family#2⟭",
    prenom: "⟬person_name:given#2⟭",
    naissance: "⟬birth_date#2⟭",
    email: "⟬email#2⟭",
    mobile: "⟬phone#2⟭",
    piece: { type: "CNI", numero: "⟬fr_identity_card#2⟭" },
    section: "BTS MCO",
    tiersTemps: true,
  },
  {
    nom: "⟬person_name:family#3⟭",
    prenom: "⟬person_name:given#3⟭",
    naissance: "⟬birth_date#3⟭",
    email: "⟬email#3⟭",
    mobile: "⟬phone#3⟭",
    piece: { type: "PASSEPORT", numero: "⟬fr_passport#3⟭" },
    section: "BTS SIO",
    tiersTemps: false,
  },
]);
db.candidats.createIndex({ "piece.numero": 1 }, { unique: true });
db.convocations.insertOne({
  session: "⟬date#1⟭",
  salle: "B204",
  candidats: db.candidats.find({}, { _id: 1 }).toArray().map((c) => c._id),
});
print(`${db.candidats.countDocuments()} candidats insérés`);
⟬end⟭

⟬template⟭
family: code
format: .kt
language: fr
fill_locale: fr_FR
domain: telecom
appearance: fake constructor, function argument, list literal, unit test
scenario: coroutine tests of the SIM activation view model of a mobile operator's app, written with Turbine against a fake API
⟬text⟭
package fr.mobiliz.activation

import app.cash.turbine.test
import kotlinx.coroutines.test.runTest
import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Test

class ActivationViewModelTest {

    private val api = FakeActivationApi(jeton = "⟬jwt#1⟭")
    private val viewModel = ActivationViewModel(api)

    @Test
    fun `une CNI valide mene au choix du numero`() = runTest {
        viewModel.etat.test {
            assertEquals(EtatActivation.SaisiePiece, awaitItem())
            viewModel.soumettrePiece(TypePiece.CNI, "⟬fr_identity_card#2⟭", nom = "⟬person_name#2⟭")
            assertEquals(EtatActivation.Verification, awaitItem())
            assertEquals(EtatActivation.ChoixNumero(proposes = listOf("⟬phone#3⟭", "⟬phone#4⟭", "⟬phone#5⟭")), awaitItem())
        }
    }

    @Test
    fun `un passeport expire est refuse`() = runTest {
        api.piecesExpirees += "⟬fr_passport#6⟭"
        viewModel.etat.test {
            skipItems(1)
            viewModel.soumettrePiece(TypePiece.PASSEPORT, "⟬fr_passport#6⟭", nom = "⟬person_name#6⟭")
            assertEquals(EtatActivation.Verification, awaitItem())
            assertEquals(EtatActivation.Erreur("Pièce expirée"), awaitItem())
        }
    }

    @Test
    fun `la portabilite conserve le numero actuel`() = runTest {
        viewModel.etat.test {
            skipItems(1)
            viewModel.soumettrePiece(TypePiece.CNI, "⟬fr_identity_card#7⟭", nom = "⟬person_name#7⟭")
            skipItems(2)
            viewModel.garderNumero("⟬phone#7⟭", rio = "02M7XC1QH8PL")
            assertEquals(EtatActivation.PortabiliteDemandee("⟬phone#7⟭"), awaitItem())
        }
    }
}
⟬end⟭

⟬template⟭
family: code
format: .java
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: JDBC URL, log call, SMTP authenticator, log output comment
scenario: legacy servlet of a gift card shop calling the payment provider directly, still logging card numbers, with a catalina.out excerpt pasted at the end
⟬text⟭
package com.cadeaux.paiement;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
import org.postgresql.ds.PGSimpleDataSource;

/**
 * Servlet de paiement des cartes cadeaux (application de 2014, Tomcat 7).
 * Appelle directement l'API du PSP : nous sommes donc dans le périmètre PCI DSS.
 * TODO passer au formulaire hébergé du PSP (recommandation de l'audit).
 */
public class PaiementCarteCadeauServlet extends HttpServlet {

    private static final Logger LOG = Logger.getLogger(PaiementCarteCadeauServlet.class.getName());
    private DataSource ds;
    private ClientPsp psp;

    @Override
    public void init() throws ServletException {
        PGSimpleDataSource pg = new PGSimpleDataSource();
        pg.setURL("jdbc:postgresql://⟬hostname#1⟭:5432/cadeaux?user=cadeaux_app&password=⟬url_password#1⟭");
        ds = pg;
        psp = new ClientPsp("https://⟬hostname#2⟭/v1", getServletConfig().getInitParameter("psp.cle"));
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String numero = req.getParameter("numero_carte");
        String cvv = req.getParameter("cvv");
        String expiration = req.getParameter("expiration");
        String email = req.getParameter("email");
        int montant = Integer.parseInt(req.getParameter("montant"));

        LOG.info("paiement carte cadeau montant=" + montant + " email=" + email + " carte=" + numero); // FIXME numéro en clair

        String autorisation;
        try {
            autorisation = psp.autoriser(numero, expiration, cvv, montant * 100);
        } catch (RefusPspException e) {
            req.setAttribute("erreur", "Paiement refusé par votre banque.");
            req.getRequestDispatcher("/WEB-INF/jsp/paiement.jsp").forward(req, resp);
            return;
        }

        String code = CodesCadeaux.generer();
        try (Connection c = ds.getConnection();
             PreparedStatement ps = c.prepareStatement(
                 "INSERT INTO cartes_cadeaux (code, montant, email_acheteur, autorisation) VALUES (?, ?, ?, ?)")) {
            ps.setString(1, code);
            ps.setInt(2, montant);
            ps.setString(3, email);
            ps.setString(4, autorisation);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new ServletException(e);
        }

        envoyerRecu(email, code, montant);
        resp.sendRedirect("merci.jsp?code=" + code);
    }

    private void envoyerRecu(String email, String code, int montant) {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.sendgrid.net");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("apikey", "⟬sendgrid_api_key#3⟭");
            }
        });
        try {
            Message m = new MimeMessage(session);
            m.setFrom(new InternetAddress("⟬email:generic#4⟭"));
            m.setRecipient(Message.RecipientType.TO, new InternetAddress(email));
            m.setSubject("Votre carte cadeau de " + montant + " €");
            m.setText("Votre code : " + code + "\nValable un an dans toutes nos boutiques.");
            Transport.send(m);
        } catch (MessagingException e) {
            LOG.log(Level.WARNING, "reçu non envoyé à " + email, e);
        }
    }
}
// catalina.out du ⟬date#1⟭ :
// INFO: paiement carte cadeau montant=50 email=⟬email#5⟭ carte=⟬payment_card#5⟭
// test manuel fait avec le cvv ⟬card_security_code#5⟭, expiration 11/27
⟬end⟭

⟬template⟭
family: code
format: .ts
language: fr
fill_locale: fr_FR
domain: real estate
appearance: environment variable fallback, object literal, template literal
scenario: NextAuth route of a landlords' portal with a demo account for sales meetings and a billing portal link built in the session callback
⟬text⟭
// app/api/auth/[...nextauth]/route.ts : connexion à l'espace propriétaires
import NextAuth from "next-auth";
import CredentialsProvider from "next-auth/providers/credentials";
import GoogleProvider from "next-auth/providers/google";
import Stripe from "stripe";
import { trouverProprietaire, verifierMotDePasse } from "@/lib/proprietaires";

const stripe = new Stripe(process.env.STRIPE_SECRET_KEY || "⟬stripe_secret_key#1⟭");

// compte de démonstration des rendez-vous commerciaux, actif seulement si DEMO_ACTIVE=1
const DEMO = { email: "⟬email#2⟭", motDePasse: "⟬password#2⟭" };

const handler = NextAuth({
  providers: [
    GoogleProvider({
      clientId: process.env.GOOGLE_CLIENT_ID ?? "548201937465-q1w2e3r4t5y6u7i8o9p0.apps.googleusercontent.com",
      clientSecret: process.env.GOOGLE_CLIENT_SECRET ?? "⟬opaque_token#3⟭",
    }),
    CredentialsProvider({
      name: "E-mail",
      credentials: { email: { label: "E-mail", type: "email" }, motDePasse: { label: "Mot de passe", type: "password" } },
      async authorize(c) {
        if (!c) return null;
        if (process.env.DEMO_ACTIVE === "1" && c.email === DEMO.email && c.motDePasse === DEMO.motDePasse) {
          return { id: "demo", email: DEMO.email, name: "Propriétaire démo" };
        }
        const p = await trouverProprietaire(c.email);
        return p && (await verifierMotDePasse(p, c.motDePasse)) ? { id: p.id, email: p.email, name: p.nom } : null;
      },
    }),
  ],
  callbacks: {
    async session({ session, token }) {
      if (token.sub && token.sub !== "demo") {
        const portail = await stripe.billingPortal.sessions.create({ customer: token.sub, return_url: process.env.NEXTAUTH_URL! });
        (session as any).portailFacturation = portail.url;
      }
      return session;
    },
  },
});

export { handler as GET, handler as POST };

export const carteStatique = (adresse: string) =>
  `https://maps.googleapis.com/maps/api/staticmap?center=${encodeURIComponent(adresse)}&zoom=15&size=400x200&key=⟬google_api_key#4⟭`;
⟬end⟭

⟬template⟭
family: code
format: .php
language: fr
fill_locale: fr_FR
domain: travel
appearance: artisan command, notification route, comment
scenario: console route of a regional airline's Laravel back office sending a test flight reminder SMS, always to the same team member during acceptance
⟬text⟭
<?php
// routes/console.php : commande de test de la notification SMS de rappel de vol
use App\Models\Reservation;
use App\Notifications\RappelVol;
use Illuminate\Support\Facades\Notification;

Artisan::command('sms:test {resa?}', function (?string $resa = null) {
    $reservation = $resa ? Reservation::findOrFail($resa) : Reservation::factory()->make(['voyageur' => '⟬person_name#1⟭']);
    // pendant la recette, le SMS part toujours sur le portable de ⟬person_name#2⟭
    Notification::route('vonage', '⟬phone#2⟭')->notify(new RappelVol($reservation));
    $this->info('SMS envoyé');
})->purpose('Envoie un rappel de vol de test');
⟬end⟭

⟬template⟭
family: code
format: .js
language: fr
fill_locale: fr_FR
domain: logistics
appearance: object literal, content script, message listener
scenario: content script of an internal Chrome extension that fills the customs export form of a freight portal with the shipper record chosen in the transport management system
⟬text⟭
// content-douane.js : extension interne « Saisie douane », remplit le formulaire DAE du portail
// avec la fiche de l'expéditeur choisie dans le TMS.
const EXPEDITEURS = {
  usine_nord: {
    raison: "⟬company#1⟭",
    siren: "⟬fr_siren#1⟭",
    siret: "⟬fr_siret#1⟭",
    adresse: "⟬fr_postal_address#1⟭",
    contact: "⟬person_name#2⟭",
    tel: "⟬phone#2⟭",
  },
  entrepot_sud: {
    raison: "⟬company#3⟭",
    siren: "⟬fr_siren#3⟭",
    siret: "⟬fr_siret#3⟭",
    adresse: "⟬fr_postal_address#3⟭",
    contact: "⟬person_name#4⟭",
    tel: "⟬phone#4⟭",
  },
};

function remplir(champ, valeur) {
  const el = document.querySelector(`[name="${champ}"]`);
  if (!el) return;
  el.value = valeur;
  el.dispatchEvent(new Event("input", { bubbles: true }));
}

chrome.runtime.onMessage.addListener((message) => {
  if (message.type !== "REMPLIR_DAE") return;
  const e = EXPEDITEURS[message.site];
  if (!e) return;
  remplir("exp_raison_sociale", e.raison);
  remplir("exp_siren", e.siren);
  remplir("exp_siret", e.siret);
  remplir("exp_adresse", e.adresse);
  remplir("exp_contact", `${e.contact} ${e.tel}`);
  // camion par défaut de la navette usine quand le TMS n'en donne pas
  remplir("transport_immatriculation", message.plaque || "⟬fr_license_plate#5⟭");
});
⟬end⟭

⟬template⟭
family: code
format: .ts
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: schema default, block comment, curl command
scenario: tRPC router of a monthly snack box subscription, with an environment schema whose default leaks the secret key and a manual test recipe in a comment
⟬text⟭
import { z } from "zod";
import Stripe from "stripe";
import { procedureProtegee, router } from "../trpc";

const env = z
  .object({
    STRIPE_SECRET_KEY: z.string().default("⟬stripe_secret_key#1⟭"),
    PRIX_BOX_MENSUELLE: z.string().default("price_1PqZ8vLkd3Gx0AbC"),
  })
  .parse(process.env);

const stripe = new Stripe(env.STRIPE_SECRET_KEY);

const adresse = z.object({ ligne1: z.string(), codePostal: z.string().regex(/^\d{5}$/), ville: z.string() });

export const abonnementRouter = router({
  souscrire: procedureProtegee
    .input(z.object({ paymentMethodId: z.string(), adresseLivraison: adresse }))
    .mutation(async ({ ctx, input }) => {
      const client = await stripe.customers.create({
        email: ctx.utilisateur.email,
        name: ctx.utilisateur.nom,
        payment_method: input.paymentMethodId,
        invoice_settings: { default_payment_method: input.paymentMethodId },
        shipping: {
          name: ctx.utilisateur.nom,
          address: {
            line1: input.adresseLivraison.ligne1,
            postal_code: input.adresseLivraison.codePostal,
            city: input.adresseLivraison.ville,
            country: "FR",
          },
        },
      });
      const abonnement = await stripe.subscriptions.create({ customer: client.id, items: [{ price: env.PRIX_BOX_MENSUELLE }] });
      return { statut: abonnement.status };
    }),
});

/*
 * Test à la main (jeton de ⟬person_name#2⟭, valable 24 h) :
 * curl -X POST http://localhost:3000/api/trpc/abonnement.souscrire \
 *   -H "Authorization: Bearer ⟬jwt#2⟭" -H "Content-Type: application/json" \
 *   -d '{"paymentMethodId":"pm_card_visa","adresseLivraison":{"ligne1":"⟬fr_postal_address:street#2⟭","codePostal":"⟬postcode#2⟭","ville":"⟬city#2⟭"}}'
 * Carte saisie dans Elements pour obtenir un vrai pm : ⟬payment_card#3⟭, cvc ⟬card_security_code#3⟭
 */
⟬end⟭

⟬template⟭
family: code
format: .java
language: fr
fill_locale: fr_FR
domain: real estate
appearance: constructor argument, factory method
scenario: shared test fixtures of a rental management back end, returning landlords built from constructor arguments
⟬text⟭
public final class Fixtures {

    private Fixtures() {
    }

    public static Proprietaire proprietaireParticulier() {
        return new Proprietaire("⟬person_name#1⟭", "⟬fr_identity_card#1⟭", "⟬iban#1⟭", "⟬phone#1⟭");
    }

    public static Proprietaire indivision() {
        return Proprietaire.indivision("⟬person_name#2⟭", "⟬person_name#3⟭", "⟬iban#2⟭");
    }
}
⟬end⟭

⟬template⟭
family: code
format: .kt
language: fr
fill_locale: fr_FR
domain: logistics
appearance: list of triples, pair, data class constructor, constant
scenario: Exposed seed object of a refrigerated delivery company preparing the trade show demo database, with drivers, trucks and customers hardcoded
⟬text⟭
package fr.froidexpress.donnees

import org.jetbrains.exposed.sql.Database
import org.jetbrains.exposed.sql.SchemaUtils
import org.jetbrains.exposed.sql.batchInsert
import org.jetbrains.exposed.sql.insert
import org.jetbrains.exposed.sql.transactions.transaction

/**
 * Jeu de données de la démo « tournée froid positif » (salon professionnel).
 * Lancé par ./gradlew :donnees:run --args="demo". Ne touche jamais la base de production :
 * le nom de la base est vérifié avant toute écriture.
 */
object JeuDemo {

    private val chauffeurs = listOf(
        Triple("⟬person_name#1⟭", "⟬fr_driving_licence#1⟭", "⟬phone#1⟭"),
        Triple("⟬person_name#2⟭", "⟬fr_driving_licence#2⟭", "⟬phone#2⟭"),
        Triple("⟬person_name#3⟭", "⟬fr_driving_licence#3⟭", "⟬phone#3⟭"),
    )

    private val camions = listOf(
        "⟬fr_license_plate#4⟭" to -20,
        "⟬fr_license_plate#5⟭" to 4,
        "⟬fr_license_plate#6⟭" to 4,
    )

    private val clients = listOf(
        ClientDemo("⟬company#7⟭", "⟬fr_siren#7⟭", "⟬fr_postal_address#7⟭", "07:00-09:00"),
        ClientDemo("⟬company#8⟭", "⟬fr_siren#8⟭", "⟬fr_postal_address#8⟭", "06:30-08:00"),
        ClientDemo("⟬company#9⟭", "⟬fr_siren#9⟭", "⟬fr_postal_address#9⟭", "10:00-12:00"),
        ClientDemo("⟬company#10⟭", "⟬fr_siren#10⟭", "⟬fr_postal_address#10⟭", "05:30-07:00"),
    )

    // clé de géocodage du compte de démo (quota de 500 requêtes par jour)
    private const val CLE_GEOCODAGE = "⟬google_api_key#11⟭"

    fun charger(db: Database, geocodeur: Geocodeur = Geocodeur(CLE_GEOCODAGE)) {
        require(db.name.endsWith("_demo")) { "refus : ${db.name} n'est pas une base de démo" }
        transaction(db) {
            SchemaUtils.create(Chauffeurs, Camions, Clients, Tournees)
            Chauffeurs.batchInsert(chauffeurs) { (nom, permis, tel) ->
                this[Chauffeurs.nom] = nom
                this[Chauffeurs.permis] = permis
                this[Chauffeurs.telephone] = tel
            }
            Camions.batchInsert(camions) { (plaque, consigne) ->
                this[Camions.immatriculation] = plaque
                this[Camions.consigneTemperature] = consigne
            }
            clients.forEach { c ->
                val position = geocodeur.position(c.adresse)
                Clients.insert {
                    it[raisonSociale] = c.raisonSociale
                    it[siren] = c.siren
                    it[adresse] = c.adresse
                    it[latitude] = position.lat
                    it[longitude] = position.lng
                    it[creneau] = c.creneau
                }
            }
            Tournees.insert {
                it[code] = "DEMO-FROID-01"
                it[camion] = camions.first().first
                it[chauffeur] = chauffeurs.first().first
                it[depart] = "04:45"
            }
        }
    }
}

data class ClientDemo(val raisonSociale: String, val siren: String, val adresse: String, val creneau: String)
⟬end⟭

⟬template⟭
family: code
format: .php
language: fr
fill_locale: fr_FR
domain: education
appearance: form definition, database insert, comment
scenario: Drupal 10 form of an approved language test centre registering candidates, with the values typed during acceptance with the centre left at the bottom
⟬text⟭
<?php

namespace Drupal\inscriptions_examens\Form;

use Drupal\Core\Form\FormBase;
use Drupal\Core\Form\FormStateInterface;
use SendGrid\Mail\Mail;

/**
 * Formulaire d'inscription aux certifications de langue (centre d'examen agréé).
 */
class InscriptionForm extends FormBase
{
    public function getFormId(): string
    {
        return 'inscriptions_examens_inscription';
    }

    public function buildForm(array $form, FormStateInterface $form_state): array
    {
        $form['nom'] = ['#type' => 'textfield', '#title' => $this->t('Nom et prénom'), '#required' => TRUE];
        $form['naissance'] = ['#type' => 'date', '#title' => $this->t('Date de naissance'), '#required' => TRUE];
        $form['email'] = ['#type' => 'email', '#title' => $this->t('E-mail'), '#required' => TRUE];
        $form['piece_type'] = ['#type' => 'select', '#title' => $this->t('Pièce'), '#options' => ['CNI' => 'CNI', 'PASSEPORT' => 'Passeport']];
        $form['piece_numero'] = ['#type' => 'textfield', '#title' => $this->t('Numéro de la pièce'), '#required' => TRUE];
        $form['actions']['submit'] = ['#type' => 'submit', '#value' => $this->t("S'inscrire")];
        return $form;
    }

    public function submitForm(array &$form, FormStateInterface $form_state): void
    {
        $valeurs = $form_state->getValues();
        \Drupal::database()->insert('inscriptions_examens')->fields([
            'nom' => $valeurs['nom'],
            'naissance' => $valeurs['naissance'],
            'email' => $valeurs['email'],
            'piece_type' => $valeurs['piece_type'],
            'piece_numero' => strtoupper($valeurs['piece_numero']),
            'cree' => \Drupal::time()->getRequestTime(),
        ])->execute();

        $mail = new Mail();
        $mail->setFrom('⟬email:generic#1⟭', 'Centre d\'examen');
        $mail->addTo($valeurs['email']);
        $mail->setSubject('Inscription enregistrée');
        $mail->addContent('text/plain', 'Présentez votre ' . $valeurs['piece_type'] . ' le jour de l\'épreuve.');
        (new \SendGrid('⟬sendgrid_api_key#2⟭'))->send($mail);

        $this->messenger()->addStatus($this->t('Inscription enregistrée.'));
    }
}

// Valeurs saisies pendant la recette avec le centre (⟬date#1⟭) :
// ⟬person_name#3⟭, née le ⟬birth_date#3f⟭, ⟬email#3⟭, CNI ⟬fr_identity_card#3⟭
// ⟬person_name#4⟭, né le ⟬birth_date#4m⟭, ⟬email#4⟭, passeport ⟬fr_passport#4⟭
⟬end⟭

⟬template⟭
family: code
format: .ts
language: fr
fill_locale: fr_FR
domain: travel
appearance: story args, object literal, placeholder
scenario: Storybook stories of the booking card component of a coach travel site, written by the front-end developer for the design review
⟬text⟭
import type { Meta, StoryObj } from "@storybook/react";
import { CarteReservation } from "./CarteReservation";

const meta: Meta<typeof CarteReservation> = {
  title: "Réservation/CarteReservation",
  component: CarteReservation,
  args: {
    reference: "⟬order_number#1⟭",
    depart: "⟬city#2⟭",
    arrivee: "Sainte-⟬trap:word_name|Maxime⟭",
    date: "⟬date#1⟭",
    voyageurs: 2,
    titulaire: "⟬trap:placeholder|Prénom Nom⟭",
    statut: "CONFIRMEE",
  },
};
export default meta;

type Story = StoryObj<typeof CarteReservation>;

export const Confirmee: Story = {};
export const EnAttente: Story = { args: { statut: "EN_ATTENTE" } };
export const Annulee: Story = { args: { statut: "ANNULEE", motif: "Annulation à l'initiative du client" } };
export const SansTitulaire: Story = { args: { titulaire: undefined } };
export const LongueDestination: Story = {
  args: { arrivee: "⟬trap:word_name|Saint-Jean⟭-de-Luz via Bayonne (correspondance en car)" },
};
⟬end⟭

⟬template⟭
family: code
format: .java
language: fr
fill_locale: fr_FR
domain: telecom
appearance: enum constant, string literal, Javadoc
scenario: enum of SMS templates of a mobile operator, approved by the legal department, with placeholders filled at send time
⟬text⟭
/** Modèles de SMS validés par le service juridique (mention STOP obligatoire sur les messages commerciaux). */
public enum ModeleSms {
    BIENVENUE("⟬trap:indicator_non_pii|Bonjour {prenom}⟭, votre ligne est active. Votre espace client : {lien}"),
    FACTURE("Votre facture {numero} de {montant} EUR est disponible dans votre espace."),
    PORTABILITE("Votre numéro sera transféré le {date} entre 9h et 12h. Aucune action de votre part."),
    CODE("Votre code de vérification : {code}. Ne le communiquez à personne.");

    private final String texte;

    ModeleSms(String texte) {
        this.texte = texte;
    }

    public String rendre(java.util.Map<String, String> valeurs) {
        String resultat = texte;
        for (var e : valeurs.entrySet()) {
            resultat = resultat.replace("{" + e.getKey() + "}", e.getValue());
        }
        return resultat;
    }
}
⟬end⟭

⟬template⟭
family: code
format: .kt
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: KDoc, function signature, constant
scenario: cart total engine of a grocery delivery app, written by a developer who documented the floating point issue they hit
⟬text⟭
package fr.epicerie.panier.prix

import java.math.BigDecimal
import java.math.RoundingMode

/**
 * Recalcul des totaux du panier.
 * Les remises en pourcentage produisent des montants non représentables en binaire :
 * on additionne les lignes avec la somme compensée de ⟬trap:eponym|Kahan⟭ avant l'arrondi final,
 * puis on arrondit au centime en demi-pair, comme le logiciel de caisse des magasins.
 */
data class LignePanier(val reference: String, val prixUnitaire: Double, val quantite: Int, val remisePourcent: Double = 0.0)

data class Totaux(val brut: BigDecimal, val remises: BigDecimal, val net: BigDecimal, val tva: BigDecimal)

private const val TAUX_TVA_ALIMENTAIRE = 0.055
private const val FRAIS_LIVRAISON = 4.90
private const val SEUIL_LIVRAISON_OFFERTE = 60.0

fun ⟬trap:code_identifier|sommeKahan⟭(valeurs: List<Double>): Double {
    var somme = 0.0
    var compensation = 0.0
    for (v in valeurs) {
        val y = v - compensation
        val t = somme + y
        compensation = (t - somme) - y
        somme = t
    }
    return somme
}

private fun centimes(valeur: Double): BigDecimal = BigDecimal.valueOf(valeur).setScale(2, RoundingMode.HALF_EVEN)

fun calculerTotaux(lignes: List<LignePanier>): Totaux {
    val bruts = lignes.map { it.prixUnitaire * it.quantite }
    val remises = lignes.map { it.prixUnitaire * it.quantite * it.remisePourcent / 100.0 }
    val brut = sommeKahan(bruts)
    val remise = sommeKahan(remises)
    var net = brut - remise
    if (net < SEUIL_LIVRAISON_OFFERTE && lignes.isNotEmpty()) {
        net += FRAIS_LIVRAISON
    }
    val tva = net - net / (1 + TAUX_TVA_ALIMENTAIRE)
    return Totaux(centimes(brut), centimes(remise), centimes(net), centimes(tva))
}

fun libelleRemise(ligne: LignePanier): String? = when {
    ligne.remisePourcent <= 0.0 -> null
    ligne.remisePourcent >= 50.0 -> "-${ligne.remisePourcent.toInt()} % (déstockage)"
    else -> "-${ligne.remisePourcent.toInt()} %"
}

fun livraisonOfferte(lignes: List<LignePanier>): Boolean {
    val net = sommeKahan(lignes.map { it.prixUnitaire * it.quantite * (1 - it.remisePourcent / 100.0) })
    return net >= SEUIL_LIVRAISON_OFFERTE
}

fun resteAvantLivraisonOfferte(lignes: List<LignePanier>): BigDecimal {
    val net = sommeKahan(lignes.map { it.prixUnitaire * it.quantite * (1 - it.remisePourcent / 100.0) })
    return centimes(maxOf(0.0, SEUIL_LIVRAISON_OFFERTE - net))
}
⟬end⟭

⟬template⟭
family: code
format: .php
language: fr
fill_locale: fr_FR
domain: real estate
appearance: configuration array, string literal
scenario: PHP-CS-Fixer configuration of a property listing platform, run in CI and pre-commit, with the copyright header imposed on every file
⟬text⟭
<?php
// Règles de style du projet ImmoPlus, appliquées en CI et en pre-commit
$finder = PhpCsFixer\Finder::create()
    ->in([__DIR__ . '/src', __DIR__ . '/tests'])
    ->exclude('var');

return (new PhpCsFixer\Config())
    ->setRiskyAllowed(true)
    ->setRules([
        '@Symfony' => true,
        'declare_strict_types' => true,
        'header_comment' => ['header' => 'Ce fichier fait partie d\'ImmoPlus. (c) ⟬trap:company_name|⦃Family⦄ Immobilier⟭, tous droits réservés.'],
        'ordered_imports' => ['sort_algorithm' => 'alpha'],
    ])
    ->setFinder($finder);
⟬end⟭

⟬template⟭
family: code
format: .js
language: fr
fill_locale: fr_FR
domain: logistics
appearance: object literal, environment variable, placeholder, route handler
scenario: health check endpoint of a parcel sorting centre's services, queried by the load balancer and the monitoring dashboards
⟬text⟭
// sante.js : contrôle de santé du centre de tri, interrogé par le load balancer et Grafana
const express = require("express");
const { Pool } = require("pg");
const Redis = require("ioredis");

const pg = new Pool({
  host: "⟬hostname#1⟭",
  ⟬trap:indicator_non_pii|user: "healthcheck"⟭,
  password: process.env.PG_HEALTH_PASSWORD,
  database: "tri",
  max: 2,
});
const redis = new Redis({ host: "⟬hostname#2⟭", password: process.env.REDIS_PASSWORD || "⟬trap:placeholder|<redis-password>⟭" });
const app = express();

async function verifier(nom, fn) {
  const debut = Date.now();
  try {
    await Promise.race([fn(), new Promise((_, rejet) => setTimeout(() => rejet(new Error("délai dépassé")), 2000))]);
    return { nom, ok: true, ms: Date.now() - debut };
  } catch (err) {
    return { nom, ok: false, ms: Date.now() - debut, erreur: err.message };
  }
}

app.get("/sante", async (req, res) => {
  const resultats = await Promise.all([
    verifier("postgres", () => pg.query("SELECT 1")),
    verifier("redis", () => redis.ping()),
    verifier("trieuse", () => fetch("http://⟬ip_address#3⟭:8081/status").then((r) => { if (!r.ok) throw new Error(`HTTP ${r.status}`); })),
  ]);
  const ok = resultats.every((r) => r.ok);
  res.status(ok ? 200 : 503).json({ ok, version: "⟬version#1⟭", composants: resultats });
});

app.listen(9100, () => console.log("contrôle de santé sur :9100"));
⟬end⟭
