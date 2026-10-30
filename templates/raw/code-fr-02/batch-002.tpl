⟬template⟭
family: code
format: .java
language: fr
fill_locale: fr_FR
domain: travel
appearance: comment, annotation
scenario: Spring Data repository of a car rental network, where the developer pasted the case reported by the branch next to the fixed query
⟬text⟭
public interface LocationRepository extends JpaRepository<Location, Long> {

    // Bug ⟬ticket_id#1⟭ : la recherche par plaque renvoyait le contrat d'un autre client.
    // Cas remonté par l'agence : ⟬person_name#2⟭, permis ⟬fr_driving_licence#2⟭, passeport ⟬fr_passport#2⟭,
    // véhicule ⟬fr_license_plate#3⟭ loué le ⟬date#1⟭.
    @Query("select l from Location l where upper(replace(l.immatriculation, '-', '')) = upper(replace(:plaque, '-', '')) and l.statut = 'EN_COURS'")
    Optional<Location> trouverEnCoursParPlaque(@Param("plaque") String plaque);

    List<Location> findByClientNumeroPermis(String numeroPermis);
}
⟬end⟭

⟬template⟭
family: code
format: .kt
language: fr
fill_locale: fr_FR
domain: telecom
appearance: builder call, list literal, SQL INSERT, string literal
scenario: Room database setup of a business softphone app whose demo mode, shown on trade fair stands, preloads a few contacts
⟬text⟭
package fr.voxline.softphone.data

import android.content.Context
import androidx.room.Room
import androidx.room.RoomDatabase
import androidx.sqlite.db.SupportSQLiteDatabase
import com.google.firebase.FirebaseApp
import com.google.firebase.FirebaseOptions

/** Base locale du softphone. En mode démo (salons, revendeurs), on précharge quelques contacts. */
object BaseSoftphone {

    fun construire(context: Context, demo: Boolean): AppDatabase {
        val builder = Room.databaseBuilder(context, AppDatabase::class.java, "softphone.db")
        if (demo) builder.addCallback(PrechargementDemo)
        return builder.build()
    }

    fun initialiserFirebase(context: Context) {
        val options = FirebaseOptions.Builder()
            .setApplicationId("1:304918265537:android:9c1e2f0a7b5d4e63")
            .setApiKey("⟬google_api_key#1⟭")
            .setProjectId("voxline-softphone")
            .build()
        FirebaseApp.initializeApp(context, options)
    }

    private object PrechargementDemo : RoomDatabase.Callback() {
        override fun onCreate(db: SupportSQLiteDatabase) {
            val contacts = listOf(
                Triple("⟬person_name#2⟭", "⟬phone#2⟭", "⟬email#2⟭"),
                Triple("⟬person_name#3⟭", "⟬phone#3⟭", "⟬email#3⟭"),
                Triple("Messagerie vocale", "888", ""),
                Triple("⟬person_name#4⟭", "⟬phone#4⟭", "⟬email#4⟭"),
            )
            contacts.forEachIndexed { i, (nom, numero, mail) ->
                db.execSQL(
                    "INSERT INTO contacts (id, nom, numero, email, favori) VALUES (?, ?, ?, ?, ?)",
                    arrayOf(i + 1, nom, numero, mail, if (i == 0) 1 else 0),
                )
            }
            db.execSQL("INSERT INTO reglages (cle, valeur) VALUES (⟬trap:indicator_non_pii|'sip_user', 'demo'⟭), ('codec', 'opus')")
        }
    }
}
⟬end⟭

⟬template⟭
family: code
format: .php
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: environment variable, form field, test fixture
scenario: Symfony functional test of a marketplace where craftsmen open a shop, covering the KYC fields required by the payment provider
⟬text⟭
<?php

namespace App\Tests\Controller;

use Symfony\Bundle\FrameworkBundle\Test\WebTestCase;

final class InscriptionVendeurControllerTest extends WebTestCase
{
    protected function setUp(): void
    {
        // compte Connect de test, cf. page interne "Paiements marketplace"
        $_ENV['STRIPE_SECRET_KEY'] = '⟬stripe_secret_key#1⟭';
    }

    public function testUnVendeurProfessionnelPeutSInscrire(): void
    {
        $client = static::createClient();
        $crawler = $client->request('GET', '/vendre/inscription');

        $form = $crawler->selectButton('Créer ma boutique')->form([
            'vendeur[boutique]' => '⟬trap:company_name|⦃Family⦄ & Fils⟭',
            'vendeur[siren]' => '⟬fr_siren#2⟭',
            'vendeur[gerant]' => '⟬person_name#3⟭',
            'vendeur[telephone]' => '⟬phone#3⟭',
            'vendeur[piece_identite]' => '⟬fr_identity_card#3⟭',
            'vendeur[iban]' => '⟬iban#2⟭',
            'vendeur[cgv]' => true,
        ]);
        $client->submit($form);

        $this->assertResponseRedirects('/vendre/tableau-de-bord');
        $this->assertSelectorTextContains('.flash-success', 'Boutique créée');
    }

    public function testUnSirenTropCourtEstRefuse(): void
    {
        $client = static::createClient();
        $crawler = $client->request('GET', '/vendre/inscription');

        $form = $crawler->selectButton('Créer ma boutique')->form([
            'vendeur[boutique]' => 'Boutique de test',
            'vendeur[siren]' => '12345',
            'vendeur[cgv]' => true,
        ]);
        $client->submit($form);

        $this->assertResponseStatusCodeSame(422);
        $this->assertSelectorTextContains('#vendeur_siren + .invalid-feedback', 'Le SIREN compte 9 chiffres.');
    }
}
⟬end⟭

⟬template⟭
family: code
format: .ts
language: fr
fill_locale: fr_FR
domain: telecom
appearance: array literal, constant
scenario: on-call rota of a mobile network operations centre, generated weekly from the planning tool and imported by the alerting bot
⟬text⟭
// Astreinte réseau, semaine 44. Généré depuis le planning : ne pas éditer à la main.
export const ASTREINTE: ReadonlyArray<[string, string, string]> = [
  ["lun-mer", "⟬person_name#1⟭", "⟬phone#1⟭"],
  ["jeu-ven", "⟬person_name#2⟭", "⟬phone#2⟭"],
  ["week-end", "⟬person_name#3⟭", "⟬phone#3⟭"],
];
export const ESCALADE_N3 = "⟬phone#4⟭";
⟬end⟭

⟬template⟭
family: code
format: .js
language: fr
fill_locale: fr_FR
domain: real estate
appearance: template literal, function call, SQL WHERE, environment variable
scenario: cron script of a real estate agency emailing visitors the day before a viewing, with the agency letterhead in a template string
⟬text⟭
// rappel-visites.js : lancé par cron à 18h, envoie le rappel des visites du lendemain
const sgMail = require("@sendgrid/mail");
const { Pool } = require("pg");
const dayjs = require("dayjs");

sgMail.setApiKey(process.env.SENDGRID_KEY || "⟬sendgrid_api_key#1⟭");

const pool = new Pool({ connectionString: process.env.DATABASE_URL });

const SIGNATURE = `
⟬company#2⟭ - SIREN ⟬fr_siren#2⟭
⟬fr_postal_address#2⟭
Tél. ⟬phone#2⟭
`;

async function visitesDeDemain() {
  const demain = dayjs().add(1, "day").format("YYYY-MM-DD");
  const { rows } = await pool.query(
    "SELECT v.heure, v.email_visiteur, v.nom_visiteur, b.adresse, b.reference FROM visites v JOIN biens b ON b.id = v.bien_id WHERE v.jour = $1",
    [demain],
  );
  return rows;
}

async function main() {
  const visites = await visitesDeDemain();
  // pour tester sans écrire aux clients : DESTINATAIRE_TEST=1 node rappel-visites.js
  const test = process.env.DESTINATAIRE_TEST === "1";
  for (const v of visites) {
    await sgMail.send({
      to: test ? "⟬email#3⟭" : v.email_visiteur,
      from: "⟬email:generic#4⟭",
      subject: `Rappel : visite demain à ${v.heure}`,
      text: `Bonjour ${v.nom_visiteur},\n\nNous vous attendons demain à ${v.heure} au ${v.adresse} (réf. ${v.reference}).\n${SIGNATURE}`,
    });
  }
  console.log(`${visites.length} rappel(s) envoyé(s)`);
  await pool.end();
}

main();
⟬end⟭

⟬template⟭
family: code
format: .java
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: text block, constant, Javadoc, main method, commented-out line
scenario: hand-written client of a French payment service provider in an old Java shop back end, with the production signing key and a manual test main still in the class
⟬text⟭
package com.boutiqueplus.paiement.psp;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.security.KeyFactory;
import java.security.PrivateKey;
import java.security.Signature;
import java.security.spec.PKCS8EncodedKeySpec;
import java.util.Base64;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * Client du prestataire de paiement (API v2, signature RSA des requêtes).
 * Écrit en 2019, à remplacer par le SDK officiel quand il gérera le 3DS2.
 *
 * @author ⟬trap:initials|J.-P.⟭
 */
public class ClientPsp {

    private static final String URL_API = "https://⟬hostname#1⟭/v2/paiements";
    private static final String SIRET_COMMERCANT = "⟬fr_siret#2⟭";
    private static final String ID_BOUTIQUE = "⟬customer_id#2⟭";

    // Clé de signature de PRODUCTION, à sortir du code (ticket ⟬ticket_id#3⟭)
    private static final String CLE_PRIVEE_PEM = """
        ⟬private_key#4⟭
        """;

    private final HttpClient http = HttpClient.newHttpClient();
    private final PrivateKey cle;

    public ClientPsp() throws Exception {
        String base64 = CLE_PRIVEE_PEM.replaceAll("-----[A-Z ]+-----", "").replaceAll("\\s", "");
        cle = KeyFactory.getInstance("RSA").generatePrivate(new PKCS8EncodedKeySpec(Base64.getDecoder().decode(base64)));
    }

    public String autoriser(String numeroCarte, String expiration, String cryptogramme, long montantCentimes, String reference) throws Exception {
        Map<String, String> champs = new LinkedHashMap<>();
        champs.put("boutique", ID_BOUTIQUE);
        champs.put("siret", SIRET_COMMERCANT);
        champs.put("reference", reference);
        champs.put("montant", Long.toString(montantCentimes));
        champs.put("devise", "978");
        champs.put("carte", numeroCarte);
        champs.put("expiration", expiration);
        champs.put("cvv", cryptogramme);

        String corps = champs.entrySet().stream()
            .map(e -> e.getKey() + "=" + e.getValue())
            .collect(Collectors.joining("&"));

        HttpRequest requete = HttpRequest.newBuilder(URI.create(URL_API))
            .header("Content-Type", "application/x-www-form-urlencoded")
            .header("X-Signature", signer(corps))
            .POST(HttpRequest.BodyPublishers.ofString(corps))
            .build();
        HttpResponse<String> reponse = http.send(requete, HttpResponse.BodyHandlers.ofString());
        if (reponse.statusCode() != 200) {
            throw new IllegalStateException("PSP a répondu " + reponse.statusCode() + " : " + reponse.body());
        }
        return reponse.body();
    }

    private String signer(String corps) throws Exception {
        Signature sig = Signature.getInstance("SHA256withRSA");
        sig.initSign(cle);
        sig.update(corps.getBytes(StandardCharsets.UTF_8));
        return Base64.getEncoder().encodeToString(sig.sign());
    }

    /** Test manuel contre la recette du PSP. */
    public static void main(String[] args) throws Exception {
        ClientPsp client = new ClientPsp();
        // carte de recette fournie par le PSP (3DS désactivé)
        System.out.println(client.autoriser("⟬payment_card#5⟭", "1229", "⟬card_security_code#5⟭", 1990, "⟬order_number#6⟭"));
        // carte perso de ⟬person_name#7⟭ pour le test en prod du ⟬date#1⟭, NE PAS RELANCER
        // System.out.println(client.autoriser("⟬payment_card#7⟭", "0827", "⟬card_security_code#7⟭", 100, "TEST-REEL"));
    }
}
⟬end⟭

⟬template⟭
family: code
format: .ts
language: fr
fill_locale: fr_FR
domain: travel
appearance: test fixture, local storage, nested object, HTTP header
scenario: Angular service test of a hotel booking site, checking that the guarantee card is stripped before the request reaches the company API
⟬text⟭
import { TestBed } from "@angular/core/testing";
import { HttpClientTestingModule, HttpTestingController } from "@angular/common/http/testing";
import { ReservationHotelService } from "./reservation-hotel.service";
import { ENV } from "../env.token";

describe("ReservationHotelService", () => {
  let service: ReservationHotelService;
  let http: HttpTestingController;

  beforeEach(() => {
    localStorage.setItem("access_token", "⟬jwt#1⟭");
    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule],
      providers: [{ provide: ENV, useValue: { api: "https://⟬hostname#2⟭", placesKey: "⟬google_api_key#3⟭" } }],
    });
    service = TestBed.inject(ReservationHotelService);
    http = TestBed.inject(HttpTestingController);
  });

  afterEach(() => http.verify());

  it("envoie les voyageurs sans le cryptogramme de la carte de garantie", () => {
    service
      .reserver({
        hotel: "⟬uuid#4⟭",
        arrivee: "⟬date#2⟭",
        depart: "⟬date#1⟭",
        voyageurs: [
          { nom: "⟬person_name#5⟭", naissance: "⟬birth_date#5⟭", passeport: "⟬fr_passport#5⟭" },
          { nom: "⟬person_name#6⟭", naissance: "⟬birth_date#6⟭", passeport: "⟬fr_passport#6⟭" },
        ],
        garantie: { carte: "⟬payment_card#5⟭", cvc: "⟬card_security_code#5⟭", titulaire: "⟬person_name#5⟭" },
      })
      .subscribe((r) => expect(r.confirmation).toBe("⟬order_number#7⟭"));

    const req = http.expectOne("https://⟬hostname#2⟭/reservations");
    expect(req.request.headers.get("Authorization")).toBe("Bearer ⟬jwt#1⟭");
    expect(req.request.body.garantie.cvc).toBeUndefined(); // le CVC part au PSP, jamais à notre API
    req.flush({ confirmation: "⟬order_number#7⟭" });
  });
});
⟬end⟭

⟬template⟭
family: code
format: .kt
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: environment variable fallback, builder call
scenario: throwaway Kotlin script of a developer trying raw card data on the payment provider's sandbox account
⟬text⟭
import com.stripe.Stripe
import com.stripe.model.PaymentMethod
import com.stripe.param.PaymentMethodCreateParams

// Bac à sable : crée un moyen de paiement brut (option "raw card data" activée sur le compte)
fun main() {
    Stripe.apiKey = System.getenv("STRIPE_KEY") ?: "⟬stripe_secret_key#1⟭"
    val carte = PaymentMethodCreateParams.CardDetails.builder()
        .setNumber("⟬payment_card#2⟭").setExpMonth(11L).setExpYear(2029L).setCvc("⟬card_security_code#2⟭")
        .build()
    val pm = PaymentMethod.create(PaymentMethodCreateParams.builder().setType(PaymentMethodCreateParams.Type.CARD).setCard(carte).build())
    println("créé : ${pm.id}")
}
⟬end⟭

⟬template⟭
family: code
format: .php
language: fr
fill_locale: fr_FR
domain: education
appearance: constant definition, comment
scenario: WordPress configuration of a vocational e-learning platform, copied to the shared drive during a hosting migration
⟬text⟭
<?php
// wp-config.php : plateforme e-learning (migration vers le nouvel hébergeur)
define('DB_NAME', 'elearning_prod');
define('DB_USER', 'wp_elearning');
define('DB_PASSWORD', '⟬password#1⟭');
define('DB_HOST', '⟬hostname#1⟭');

define('AUTH_KEY',        '⟬opaque_token#2⟭');
define('SECURE_AUTH_KEY', '⟬opaque_token#3⟭');
define('NONCE_SALT',      '⟬opaque_token#4⟭');
⟬trap:indicator_non_pii|define('AUTH_COOKIE_EXPIRATION', 1209600)⟭;

// envoi des attestations de fin de formation
define('SENDGRID_API_KEY', '⟬sendgrid_api_key#5⟭');
$table_prefix = 'elrn_';
⟬end⟭

⟬template⟭
family: code
format: .js
language: fr
fill_locale: fr_FR
domain: logistics
appearance: URL, block comment, nested JSON, log field, constant
scenario: Node worker of an export logistics firm that consumes customs declarations from RabbitMQ and forwards them to the freight forwarder's portal
⟬text⟭
"use strict";
/**
 * Worker douane export : consomme la file "douane.cn23", complète la déclaration
 * et l'envoie au portail du transitaire. Les rejets partent par mail à l'équipe export.
 * Transitaire actuel : ⟬trap:company_name|Transports ⦃Family⦄⟭ (contrat jusqu'en 2027).
 */
const amqp = require("amqplib");
const axios = require("axios");
const sgMail = require("@sendgrid/mail");
const pino = require("pino");

const log = pino({ level: process.env.LOG_LEVEL || "info" });

const RABBIT_URL = process.env.RABBIT_URL || "amqps://douane_worker:⟬url_password#1⟭@⟬hostname#1⟭:5671/export";
const PORTAIL = "https://⟬hostname#2⟭/api/declarations";
// jeton de service du portail, valable un an (renouvelé le ⟬date#1⟭)
const JETON_PORTAIL = "⟬jwt#2⟭";
sgMail.setApiKey("⟬sendgrid_api_key#3⟭");

const EXPEDITEUR_PAR_DEFAUT = {
  raisonSociale: "⟬company#4⟭",
  siret: "⟬fr_siret#4⟭",
  adresse: "⟬fr_postal_address#4⟭",
  telephone: "⟬phone#4⟭",
};

/* Exemple de message reçu (copié depuis la console RabbitMQ) :
{"colis":"⟬order_number#5⟭","destinataire":{"nom":"⟬person_name#6⟭","adresse":"⟬postal_address#6⟭"},
 "contenu":[{"designation":"Livres","valeur":42.5,"sh":"490199"}],"camion":"⟬fr_license_plate#7⟭"}
*/

function construireDeclaration(msg) {
  return {
    expediteur: msg.expediteur || EXPEDITEUR_PAR_DEFAUT,
    destinataire: msg.destinataire,
    articles: msg.contenu.map((a) => ({ libelle: a.designation, valeur: a.valeur, codeSh: a.sh })),
    transport: { mode: "ROUTE", immatriculation: msg.camion },
    reference: msg.colis,
  };
}

async function envoyer(declaration) {
  const { data } = await axios.post(PORTAIL, declaration, {
    headers: { Authorization: `Bearer ${JETON_PORTAIL}` },
    timeout: 10000,
  });
  return data.numeroMrn;
}

async function alerter(colis, erreur) {
  await sgMail.send({
    to: "⟬email:generic#8⟭",
    from: "⟬email:generic#9⟭",
    subject: `[douane] déclaration rejetée pour ${colis}`,
    text: `Le portail a refusé la déclaration du colis ${colis} :\n${erreur}\n\nVoir ${PORTAIL}/${colis}`,
  });
}

async function demarrer() {
  const connexion = await amqp.connect(RABBIT_URL);
  const canal = await connexion.createChannel();
  await canal.assertQueue("douane.cn23", { durable: true });
  canal.prefetch(5);
  log.info("worker douane prêt");

  canal.consume("douane.cn23", async (m) => {
    const msg = JSON.parse(m.content.toString());
    try {
      const mrn = await envoyer(construireDeclaration(msg));
      log.info({ colis: msg.colis, mrn }, "déclaration acceptée");
      canal.ack(m);
    } catch (err) {
      const detail = err.response ? JSON.stringify(err.response.data) : err.message;
      log.error({ colis: msg.colis, camion: msg.camion, detail }, "déclaration rejetée");
      await alerter(msg.colis, detail);
      canal.nack(m, false, false);
    }
  });
}

demarrer().catch((err) => {
  log.fatal(err, "arrêt du worker");
  process.exit(1);
});
⟬end⟭

⟬template⟭
family: code
format: .ts
language: fr
fill_locale: fr_FR
domain: education
appearance: seed script, object literal, function call, comment
scenario: Prisma seed script of an online tutoring platform, written by the founder to demo the tutor onboarding flow with real-looking tutors
⟬text⟭
// prisma/seed.ts : données de démo pour la plateforme de soutien scolaire
import { PrismaClient, Role } from "@prisma/client";
import bcrypt from "bcryptjs";
import Stripe from "stripe";

const prisma = new PrismaClient();
const stripe = new Stripe("⟬stripe_secret_key#1⟭"); // compte test, TODO(⟬trap:initials|MB⟭) lire depuis .env

async function main() {
  const admin = await prisma.utilisateur.upsert({
    where: { email: "⟬email:generic#2⟭" },
    update: {},
    create: {
      email: "⟬email:generic#2⟭",
      motDePasse: await bcrypt.hash("⟬password#2⟭", 10),
      role: Role.ADMIN,
    },
  });

  const tuteurs = [
    { prenom: "⟬person_name:given#3⟭", nom: "⟬person_name:family#3⟭", email: "⟬email#3⟭", tel: "⟬phone#3⟭", matiere: "Mathématiques", passeport: "⟬fr_passport#3⟭" },
    { prenom: "⟬person_name:given#4⟭", nom: "⟬person_name:family#4⟭", email: "⟬email#4⟭", tel: "⟬phone#4⟭", matiere: "Physique-chimie", passeport: null },
  ];

  for (const t of tuteurs) {
    const client = await stripe.customers.create({ email: t.email, name: `${t.prenom} ${t.nom}` });
    await prisma.tuteur.create({ data: { ...t, stripeCustomerId: client.id, valideParId: admin.id } });
  }
  console.log(`seed terminé : ${tuteurs.length} tuteurs`);
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(() => prisma.$disconnect());
⟬end⟭

⟬template⟭
family: code
format: .java
language: fr
fill_locale: fr_FR
domain: telecom
appearance: annotation, parameterized test, string literal
scenario: parameterized JUnit test of the phone number validator shared by the shop and the customer area of a mobile operator
⟬text⟭
package fr.mobiliz.commun.telephone;

import static org.assertj.core.api.Assertions.assertThat;

import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;

class ValidateurTelephoneTest {

    private final ValidateurTelephone validateur = new ValidateurTelephone("FR");

    @ParameterizedTest
    @ValueSource(strings = {"⟬phone#1⟭", "⟬phone#2⟭", "⟬phone#3⟭", "⟬phone#4⟭"})
    void accepteLesFormatsCourants(String numero) {
        assertThat(validateur.estValide(numero)).isTrue();
    }

    @ParameterizedTest
    @ValueSource(strings = {"", "06", "+33", "0033", "12 34", "⟬trap:placeholder|06 XX XX XX XX⟭", "⟬trap:placeholder|+33 6 •• •• •• ••⟭"})
    void refuseLesSaisiesIncompletes(String numero) {
        assertThat(validateur.estValide(numero)).isFalse();
    }

    @ParameterizedTest
    @ValueSource(strings = {"3179", "112", "15"})
    void refuseLesNumerosCourtsPourUnAbonnement(String numero) {
        assertThat(validateur.estNumeroAbonne(numero)).isFalse();
    }
}
⟬end⟭

⟬template⟭
family: code
format: .kt
language: fr
fill_locale: fr_FR
domain: real estate
appearance: data class constructor, companion object constant, URL query string, KDoc
scenario: Android view model of a property viewing app with a demo repository for the real estate fair, plus a mapper kept for a former partner's feed
⟬text⟭
package fr.visitimmo.app.annonce

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch

data class Annonce(
    val reference: String,
    val titre: String,
    val adresse: String,
    val prixEuros: Int,
    val surfaceM2: Int,
    val agent: String,
    val telephoneAgent: String,
    val proprietaireSiren: String?,
    val photos: List<String>,
)

sealed interface EtatAnnonce {
    data object Chargement : EtatAnnonce
    data class Pret(val annonce: Annonce, val carteUrl: String) : EtatAnnonce
    data class Erreur(val message: String) : EtatAnnonce
}

interface AnnonceRepository {
    suspend fun charger(reference: String): Annonce
}

/** Données de démonstration pour le salon de l'immobilier : aucun appel réseau. */
class AnnonceRepositoryDemo : AnnonceRepository {
    override suspend fun charger(reference: String) = Annonce(
        reference = reference,
        titre = "T3 lumineux, balcon, proche tram",
        adresse = "⟬fr_postal_address#1⟭",
        prixEuros = 289_000,
        surfaceM2 = 68,
        agent = "⟬person_name#2⟭",
        telephoneAgent = "⟬phone#2⟭",
        proprietaireSiren = "⟬fr_siren#3⟭",
        photos = listOf("https://⟬hostname#4⟭/photos/$reference/1.jpg", "https://⟬hostname#4⟭/photos/$reference/2.jpg"),
    )
}

class AnnonceViewModel(
    private val repository: AnnonceRepository,
    private val reference: String,
) : ViewModel() {

    private val _etat = MutableStateFlow<EtatAnnonce>(EtatAnnonce.Chargement)
    val etat: StateFlow<EtatAnnonce> = _etat.asStateFlow()

    init {
        viewModelScope.launch {
            _etat.value = try {
                val annonce = repository.charger(reference)
                EtatAnnonce.Pret(annonce, carteStatique(annonce.adresse))
            } catch (e: Exception) {
                EtatAnnonce.Erreur("Annonce indisponible")
            }
        }
    }

    fun lienAppel(annonce: Annonce): String = "tel:" + annonce.telephoneAgent.filter { it.isDigit() || it == '+' }

    private fun carteStatique(adresse: String): String {
        val centre = java.net.URLEncoder.encode(adresse, "UTF-8")
        return "https://maps.googleapis.com/maps/api/staticmap?center=$centre&zoom=16&size=600x300&markers=$centre&key=$CLE_MAPS"
    }

    companion object {
        // clé restreinte au package fr.visitimmo.app (console Google, projet visitimmo-prod)
        private const val CLE_MAPS = "⟬google_api_key#5⟭"
    }
}

/** Import des annonces de l'ancien partenaire ⟬trap:company_name|⦃Family⦄ Immobilier⟭ (flux XML, contrat terminé). */
object ⟬trap:code_identifier|Agence⦃Family⦄Mapper⟭ {
    fun versAnnonce(champs: Map<String, String>): Annonce = Annonce(
        reference = champs.getValue("ref"),
        titre = champs["titre"].orEmpty(),
        adresse = champs["adresse"].orEmpty(),
        prixEuros = champs["prix"]?.toIntOrNull() ?: 0,
        surfaceM2 = champs["surface"]?.toIntOrNull() ?: 0,
        agent = champs["negociateur"].orEmpty(),
        telephoneAgent = champs["tel_negociateur"].orEmpty(),
        proprietaireSiren = null,
        photos = champs["photos"]?.split(";").orEmpty(),
    )
}
⟬end⟭

⟬template⟭
family: code
format: .js
language: fr
fill_locale: fr_FR
domain: travel
appearance: fetch call, HTTP header, JSON body, comment
scenario: snippet a support engineer of a ferry company pasted in a ticket so that a colleague can fix a passenger's identity from the browser console
⟬text⟭
// À coller dans la console du back-office (onglet Réseau ouvert), demande ⟬ticket_id#1⟭
await fetch("/api/v1/reservations/⟬order_number#2⟭/passagers/2", {
  method: "PATCH",
  headers: { "Content-Type": "application/json", Authorization: "Bearer ⟬jwt#3⟭" },
  body: JSON.stringify({ nom: "⟬person_name:family#4⟭", prenom: "⟬person_name:given#4⟭", cni: "⟬fr_identity_card#4⟭", expirationCni: "⟬date#1⟭" }),
}).then((r) => r.status);
⟬end⟭

⟬template⟭
family: code
format: .ts
language: fr
fill_locale: fr_FR
domain: logistics
appearance: decorator, API example, class property
scenario: NestJS DTO of the gate kiosk of a distribution centre where truck drivers check in, documented with Swagger examples
⟬text⟭
import { ApiProperty } from "@nestjs/swagger";
import { IsOptional, IsPhoneNumber, IsString, Length, Matches } from "class-validator";

/** Enregistrement d'un chauffeur à la barrière du dépôt (borne tactile). */
export class ArriveeChauffeurDto {
  @ApiProperty({ example: "⟬fr_license_plate#1⟭", description: "Immatriculation du tracteur" })
  @Matches(/^[A-Z]{2}-\d{3}-[A-Z]{2}$/)
  plaqueTracteur: string;

  @ApiProperty({ example: "⟬fr_license_plate#2⟭", required: false })
  @IsOptional()
  plaqueRemorque?: string;

  @ApiProperty({ example: "⟬person_name#3⟭" })
  @IsString()
  nomChauffeur: string;

  @ApiProperty({ example: "⟬phone#3⟭" })
  @IsPhoneNumber("FR")
  telephone: string;

  @ApiProperty({ example: "⟬fr_driving_licence#3⟭", description: "Numéro du permis C ou CE" })
  @Length(12, 12)
  permis: string;

  @ApiProperty({ example: "⟬fr_identity_card#3⟭", description: "Pièce scannée par la borne" })
  @IsString()
  pieceIdentite: string;

  @ApiProperty({ example: "⟬order_number#4⟭" })
  @IsString()
  numeroRendezVous: string;

  @ApiProperty({ description: "Nom du transporteur quand le rendez-vous ne le précise pas" })
  @IsOptional()
  ⟬trap:indicator_non_pii|nomTransporteur?: string = "NON_RENSEIGNE"⟭;
}
⟬end⟭

⟬template⟭
family: code
format: .php
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: array literal, form definition, placeholder, comment
scenario: configuration screen of a card payment module for a PrestaShop store, written by an agency that never stores the secret in clear on screen
⟬text⟭
<?php
/**
 * Module de paiement par carte : écran de configuration (back-office PrestaShop 8).
 */
if (!defined('_PS_VERSION_')) {
    exit;
}

class PaiementCarteConfig
{
    const CLES = [
        'PAIEMENTCARTE_MODE',
        'PAIEMENTCARTE_PUBLISHABLE_KEY',
        'PAIEMENTCARTE_SECRET_KEY',
        'PAIEMENTCARTE_WEBHOOK_SECRET',
        'PAIEMENTCARTE_3DS_SEUIL',
    ];

    private $module;

    public function __construct(Module $module)
    {
        $this->module = $module;
    }

    public function formulaire()
    {
        return [
            'form' => [
                'legend' => ['title' => $this->module->l('Réglages du paiement'), 'icon' => 'icon-credit-card'],
                'input' => [
                    [
                        'type' => 'switch',
                        'label' => $this->module->l('Mode production'),
                        'name' => 'PAIEMENTCARTE_MODE',
                        'values' => [['id' => 'on', 'value' => 1], ['id' => 'off', 'value' => 0]],
                    ],
                    [
                        'type' => 'text',
                        'label' => $this->module->l('Clé publique'),
                        'name' => 'PAIEMENTCARTE_PUBLISHABLE_KEY',
                        'placeholder' => 'pk_live_...',
                    ],
                    [
                        'type' => 'password',
                        'label' => $this->module->l('Clé secrète'),
                        'name' => 'PAIEMENTCARTE_SECRET_KEY',
                        'placeholder' => '⟬trap:placeholder|sk_live_••••••••⟭',
                        'desc' => $this->module->l('Visible une seule fois dans le tableau de bord du prestataire.'),
                    ],
                    [
                        'type' => 'password',
                        'label' => $this->module->l('Secret du webhook'),
                        'name' => 'PAIEMENTCARTE_WEBHOOK_SECRET',
                        'placeholder' => '⟬trap:placeholder|whsec_...⟭',
                    ],
                    [
                        'type' => 'text',
                        'label' => $this->module->l('Seuil 3-D Secure (EUR)'),
                        'name' => 'PAIEMENTCARTE_3DS_SEUIL',
                        'desc' => $this->module->l('Au-delà de ce montant, l\'authentification forte est toujours demandée.'),
                    ],
                ],
                'submit' => ['title' => $this->module->l('Enregistrer')],
            ],
        ];
    }

    public function enregistrer()
    {
        foreach (self::CLES as $cle) {
            $valeur = Tools::getValue($cle);
            // un champ password revient vide : on garde alors la valeur enregistrée
            if ($valeur === '' && in_array($cle, ['PAIEMENTCARTE_SECRET_KEY', 'PAIEMENTCARTE_WEBHOOK_SECRET'], true)) {
                continue;
            }
            Configuration::updateValue($cle, $valeur);
        }
        ⟬trap:indicator_non_pii|Configuration::updateValue('PAIEMENTCARTE_SECRET_ROTATION', date('Y-m-d'))⟭;
    }

    public function cleSecreteMasquee()
    {
        $cle = (string) Configuration::get('PAIEMENTCARTE_SECRET_KEY');
        return $cle === '' ? '' : substr($cle, 0, 8) . str_repeat('*', 12) . substr($cle, -4);
    }
}
⟬end⟭

⟬template⟭
family: code
format: .kt
language: fr
fill_locale: fr_FR
domain: telecom
appearance: constant, KDoc
scenario: shared business rules object of a mobile plan app, mirrored from a Markdown file kept by the product owner
⟬text⟭
package fr.mobiliz.forfaits

/** Règles métier partagées entre l'appli et le back-office (copie de regles.md, v3). */
object Regles {
    const val PREFIXE_FRANCE = "+33"
    ⟬trap:indicator_non_pii|const val MOT_DE_PASSE_LONGUEUR_MIN = 10⟭
    ⟬trap:indicator_non_pii|const val CODE_PIN_PAR_DEFAUT = "0000"⟭
    const val ESSAIS_PUK_MAX = 10
    const val DATA_ILLIMITEE_SEUIL_GO = 250
    ⟬trap:indicator_non_pii|const val TELEPHONE_SERVICE_CLIENT = "3179"⟭
}
⟬end⟭

⟬template⟭
family: code
format: .java
language: fr
fill_locale: fr_FR
domain: travel
appearance: Javadoc, method signature, comment
scenario: connection finder of a flight comparison site, written by a back-end developer who documented the algorithm choice in the Javadoc
⟬text⟭
package fr.escalia.itineraires;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.PriorityQueue;

/**
 * Recherche de correspondances entre aéroports : algorithme de ⟬trap:eponym|Dijkstra⟭ sur un graphe
 * pondéré par la durée totale (vol + escale), avec un nombre d'escales borné.
 * Exemple : ⟬city#1⟭ vers ⟬city#2⟭ passe par ORY si aucun direct n'existe ce jour-là.
 */
public final class ChercheurCorrespondances {

    private static final int ESCALE_MINIMALE_MINUTES = 45;

    private final Map<String, List<Troncon>> graphe = new HashMap<>();

    public void ajouter(Troncon troncon) {
        graphe.computeIfAbsent(troncon.depart(), k -> new ArrayList<>()).add(troncon);
    }

    public List<Troncon> ⟬trap:code_identifier|plusCourtCheminDijkstra⟭(String depart, String arrivee, int escalesMax) {
        record Etape(String aeroport, int minutes, int escales, Etape precedente, Troncon via) {}

        PriorityQueue<Etape> file = new PriorityQueue<>(Comparator.comparingInt(Etape::minutes));
        Map<String, Integer> meilleur = new HashMap<>();
        file.add(new Etape(depart, 0, -1, null, null));

        while (!file.isEmpty()) {
            Etape courante = file.poll();
            if (courante.aeroport().equals(arrivee)) {
                List<Troncon> chemin = new ArrayList<>();
                for (Etape e = courante; e.via() != null; e = e.precedente()) {
                    chemin.add(e.via());
                }
                Collections.reverse(chemin);
                return chemin;
            }
            if (courante.escales() >= escalesMax) {
                continue;
            }
            for (Troncon t : graphe.getOrDefault(courante.aeroport(), List.of())) {
                int attente = courante.via() == null ? 0 : ESCALE_MINIMALE_MINUTES;
                int total = courante.minutes() + attente + t.dureeMinutes();
                if (total < meilleur.getOrDefault(t.arrivee(), Integer.MAX_VALUE)) {
                    meilleur.put(t.arrivee(), total);
                    file.add(new Etape(t.arrivee(), total, courante.escales() + 1, courante, t));
                }
            }
        }
        return List.of();
    }
}
⟬end⟭

⟬template⟭
family: code
format: .ts
language: fr
fill_locale: fr_FR
domain: education
appearance: object literal, string literal, placeholder
scenario: French message catalogue of a classroom quiz app, maintained by the teacher who wrote the wording
⟬text⟭
// Traductions FR de l'appli de quiz (clé = identifiant ICU)
export default {
  "accueil.titre": "⟬trap:indicator_non_pii|Bonjour à tous⟭ !",
  "accueil.bienvenue": "Bonjour {prenom}, prêt pour le quiz du jour ?",
  "profil.email.aide": "Nous écrivons à {email} uniquement pour les résultats.",
  "profil.telephone.placeholder": "⟬trap:placeholder|06 XX XX XX XX⟭",
  "connexion.motdepasse.oublie": "Mot de passe oublié ?",
  "connexion.motdepasse.regle": "⟬trap:indicator_non_pii|Mot de passe : 12 caractères minimum⟭",
  "classement.auteur": "Quiz proposé par l'équipe pédagogique",
  "partage.lien": "Partager sur ⟬trap:email_lookalike|@quizdujour⟭",
};
⟬end⟭

⟬template⟭
family: code
format: .js
language: fr
fill_locale: fr_FR
domain: real estate
appearance: object literal, JSDoc, query string
scenario: Express route of a property portal estimating the purchase price and notary fees per neighbourhood, written by a freelance developer
⟬text⟭
const express = require("express");
const router = express.Router();

// Prix médian au m² par secteur (données DVF, export du ⟬date#1⟭). Une rue sans numéro désigne un secteur.
const PRIX_M2 = {
  "centre-historique": 4820,
  "rue ⟬trap:word_name|Victor Hugo⟭": 5210,
  "quartier ⟬trap:word_name|Saint-Michel⟭": 3990,
  "avenue ⟬trap:word_name|Jean Jaurès⟭": 3640,
  gare: 3350,
};

/**
 * Émoluments du notaire : barème par tranches, en euros, hors TVA.
 * Les frais d'acquisition ajoutent les droits de mutation et environ 1 200 € de débours.
 */
const TRANCHES_EMOLUMENTS = [
  [6500, 0.0387],
  [17000, 0.01596],
  [60000, 0.01064],
  [Infinity, 0.00799],
];

function emoluments(prix) {
  let reste = prix;
  let bas = 0;
  let total = 0;
  for (const [haut, taux] of TRANCHES_EMOLUMENTS) {
    const part = Math.min(reste, haut - bas);
    if (part <= 0) break;
    total += part * taux;
    reste -= part;
    bas = haut;
  }
  return total * 1.2; // TVA
}

router.get("/estimation", (req, res) => {
  const secteur = String(req.query.secteur || "");
  const surface = Number(req.query.surface);
  if (!PRIX_M2[secteur] || !(surface > 0)) {
    return res.status(400).json({ erreur: "secteur ou surface invalide", secteurs: Object.keys(PRIX_M2) });
  }
  const prix = Math.round(PRIX_M2[secteur] * surface);
  const droits = prix * (req.query.neuf === "1" ? 0.00715 : 0.058);
  const frais = Math.round(droits + emoluments(prix) + 1200);
  res.json({ secteur, surface, prixEstime: prix, fraisAcquisition: frais, total: prix + frais });
});

module.exports = router;
⟬end⟭
