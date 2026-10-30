⟬template⟭
family: logs
format: application log
language: fr
fill_locale: fr_FR
domain: banking
appearance: log field, key=value
scenario: log of a retail bank's SEPA transfer service, where a rejected order copies the beneficiary's IBAN and name
⟬text⟭
⟬date#1⟭ 08:41:02.114 INFO  [sepa-worker-3] VirementService - lot ⟬order_number#1⟭ chargé: 212 ordres
⟬date#1⟭ 08:41:02.530 WARN  [sepa-worker-3] VirementService - clé IBAN invalide iban=⟬iban#1⟭ benef="⟬person_name#1⟭" montant=1840.00 EUR
⟬date#1⟭ 08:41:02.533 INFO  [sepa-worker-3] VirementService - ordre ⟬uuid#1⟭ basculé en reprise manuelle, operateur=⟬trap:indicator_non_pii|batch-nuit⟭
⟬date#1⟭ 08:41:03.002 INFO  [sepa-worker-3] VirementService - lot ⟬order_number#1⟭ clos: 211 acceptés, 1 rejeté
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: fr
fill_locale: fr_FR
domain: insurance
appearance: exception message, Python traceback
scenario: Python traceback of a claims declaration API, whose exception message quotes the plate, the driver and their licence
⟬text⟭
Traceback (most recent call last):
  File "/opt/sinistres/app/declaration.py", line 88, in enregistrer
    contrat = self.repo.par_immatriculation(plaque)
  File "/opt/sinistres/app/repo.py", line 41, in par_immatriculation
    raise ContratIntrouvable(f"aucun contrat actif pour {plaque}, conducteur {nom} (permis {permis})")
app.erreurs.ContratIntrouvable: aucun contrat actif pour ⟬fr_license_plate#1⟭, conducteur ⟬person_name#1⟭ (permis ⟬fr_driving_licence#1⟭)
⟬end⟭

⟬template⟭
family: logs
format: test output
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: pytest summary, code identifier
scenario: pytest output of an online shop's cart module, with a failing influencer coupon test and no customer data
⟬text⟭
============================= test session starts =============================
platform linux -- Python 3.11.6, pytest-7.4.3, pluggy-1.3.0
rootdir: /srv/boutique, configfile: pyproject.toml
collected 214 items

tests/panier/test_remises.py ......F...                                  [  4%]
tests/panier/test_livraison.py ........................                  [ 16%]
tests/panier/test_tva.py ..........                                      [ 21%]

=========================== short test summary info ===========================
FAILED tests/panier/test_remises.py::⟬trap:code_identifier|test_coupon_⦃family⦄_cumulable⟭ - assert 1490 == 1500
================= 1 failed, 39 passed, 174 deselected in 2.87s =================
⟬end⟭

⟬template⟭
family: logs
format: access log
language: fr
fill_locale: fr_FR
domain: telecom
appearance: query string, combined log format, referer
scenario: nginx access to a mobile operator's customer area, where invoice links carry a token and a signature in the URL
⟬text⟭
⟬ip_address#1⟭ - - [⟬date#1⟭ 07:12:44 +0200] "GET /espace-client/factures?token=⟬opaque_token#1⟭ HTTP/1.1" 200 8124 "-" "Mozilla/5.0 (Linux; Android 13)"
⟬ip_address#1⟭ - - [⟬date#1⟭ 07:12:46 +0200] "GET /espace-client/factures/download?ref=⟬invoice_number#1⟭&sig=⟬opaque_token#2⟭ HTTP/1.1" 200 44120 "⟬url#1⟭" "Mozilla/5.0 (Linux; Android 13)"
⟬ip_address#2⟭ - - [⟬date#1⟭ 07:13:01 +0200] "POST /api/v2/lignes/portabilite?access_token=⟬jwt#1⟭ HTTP/1.1" 403 96 "-" "okhttp/4.11.0"
⟬ip_address#3⟭ - - [⟬date#1⟭ 07:13:20 +0200] "GET /healthz HTTP/1.1" 200 2 "-" "kube-probe/1.27"
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: job output, script echo
scenario: GitLab CI job validating FHIR profiles for a hospital software vendor, with no patient data
⟬text⟭
Running with gitlab-runner ⟬version#1⟭
Preparing the "docker" executor
Using docker image python:3.11-slim
$ python scripts/valider_profils_fhir.py --dossier profils/
validation de 4 profils FHIR
  OK  Patient-fr.json (⟬trap:indicator_non_pii|dob_format=YYYY-MM-DD⟭)
  OK  Practitioner-fr.json
  OK  Encounter-fr.json
  OK  Consent-fr.json (⟬trap:indicator_non_pii|patient_reference=obligatoire⟭)
4 profils valides, 0 erreur
Job succeeded
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: fr
fill_locale: fr_FR
domain: public administration
appearance: key=value, audit trail
scenario: audit trail of a town hall's civil registry software, where an agent looks up a passport then corrects an address
⟬text⟭
⟬date#1⟭ 10:02:17 AUDIT agent=⟬person_name:handle#1⟭ service=etat-civil action=CONSULTATION passeport=⟬fr_passport#2⟭ nir=⟬fr_social_security_number#2⟭
⟬date#1⟭ 10:02:49 AUDIT agent=⟬person_name:handle#1⟭ service=etat-civil action=MODIF_ADRESSE passeport=⟬fr_passport#2⟭ nouvelle_adresse="⟬fr_postal_address#2⟭"
⟬date#1⟭ 10:03:05 AUDIT agent=⟬trap:indicator_non_pii|sync-titres⟭ service=titres action=EXPORT lot=⟬uuid#1⟭ nb=1
⟬date#1⟭ 10:03:06 AUDIT agent=⟬person_name:handle#1⟭ service=etat-civil action=DECONNEXION session=⟬uuid#2⟭
⟬end⟭

⟬template⟭
family: logs
format: application log
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: HL7 segment, log field, quoted value
scenario: identity engine log of a university hospital, copying HL7 segments at DEBUG and flagging an inconsistent NIR for a patient
⟬text⟭
⟬date#1⟭ 06:00:01,204 INFO  [hl7-listener-2] f.c.adt.EcouteurMllp : connexion ouverte depuis ⟬ip_address#1⟭
⟬date#1⟭ 06:00:01,377 DEBUG [hl7-listener-2] f.c.adt.EcouteurMllp : message recu id=⟬uuid#1⟭ type=ADT^A28 taille=812
⟬date#1⟭ 06:00:01,379 DEBUG [hl7-listener-2] f.c.adt.Decodeur     : MSH|^~\&|GAM|CHU|DPI|CHU|||ADT^A28|⟬uuid#1⟭|P|2.5
⟬date#1⟭ 06:00:01,380 DEBUG [hl7-listener-2] f.c.adt.Decodeur     : PID|1||⟬customer_id#2⟭^^^IPP||⟬person_name:family#2f⟭^⟬person_name:given#2f⟭^^^MME||⟬birth_date#2⟭|F|||⟬fr_postal_address:street#2⟭^^⟬city#2⟭^^⟬postcode#2⟭^FRA||⟬phone#2⟭
⟬date#1⟭ 06:00:01,402 INFO  [hl7-listener-2] f.c.identite.Rapprochement : recherche de doublons pour ipp=⟬customer_id#2⟭
⟬date#1⟭ 06:00:01,655 WARN  [hl7-listener-2] f.c.identite.ControleNir : NIR incoherent avec la date de naissance nir=⟬fr_social_security_number#2⟭ ipp=⟬customer_id#2⟭
⟬date#1⟭ 06:00:01,656 WARN  [hl7-listener-2] f.c.identite.ControleNir : identite placee en statut PROVISOIRE, patiente "⟬person_name#2f⟭"
⟬date#1⟭ 06:00:01,890 INFO  [hl7-listener-2] f.c.identite.Rapprochement : candidat ipp=⟬customer_id#3⟭ score=0.91 (⟬trap:eponym|Jaro-Winkler⟭)
⟬date#1⟭ 06:00:01,891 DEBUG [hl7-listener-2] f.c.identite.Rapprochement : candidat "⟬person_name#3m⟭" ne le ⟬birth_date#3⟭ rejete, sexe different
⟬date#1⟭ 06:00:02,015 INFO  [hl7-listener-2] f.c.adt.Acquittement : ACK AA envoye pour ⟬uuid#1⟭
⟬date#1⟭ 06:00:02,017 INFO  [hl7-listener-2] f.c.adt.EcouteurMllp : connexion fermee par le pair
⟬date#1⟭ 06:05:00,001 INFO  [scheduler-1] f.c.purge.PurgeCache : purge du cache identite: 418 entrees
⟬date#1⟭ 06:05:00,044 INFO  [scheduler-1] f.c.purge.PurgeCache : purge terminee en 43 ms
⟬date#1⟭ 06:10:00,002 DEBUG [scheduler-1] f.c.metriques.Export : envoi metriques vers ⟬hostname#1⟭
⟬date#1⟭ 06:10:00,120 INFO  [hl7-listener-1] f.c.adt.EcouteurMllp : connexion ouverte depuis ⟬ip_address#1⟭
⟬date#1⟭ 06:10:00,301 DEBUG [hl7-listener-1] f.c.adt.EcouteurMllp : message recu id=⟬uuid#4⟭ type=ADT^A01 taille=640
⟬date#1⟭ 06:10:00,512 INFO  [hl7-listener-1] f.c.adt.Acquittement : ACK AA envoye pour ⟬uuid#4⟭
⟬end⟭

⟬template⟭
family: logs
format: application log
language: fr
fill_locale: fr_FR
domain: telecom
appearance: logfmt, key=value
scenario: CDR collection log of an operator, in logfmt, with sites named after places and no subscriber data
⟬text⟭
ts="⟬date#1⟭ 03:00:00" level=info comp=mediation msg="demarrage de la collecte CDR" fichier=⟬file_path#1⟭
ts="⟬date#1⟭ 03:00:00" level=info comp=mediation msg="connexion au broker ⟬trap:library|Kafka⟭" broker=⟬hostname#1⟭ user=⟬trap:indicator_non_pii|svc-mediation⟭
ts="⟬date#1⟭ 03:00:01" level=debug comp=mediation msg="configuration chargee" ⟬trap:indicator_non_pii|token_bucket_capacity=5000⟭ ⟬trap:indicator_non_pii|msisdn_masque=true⟭
ts="⟬date#1⟭ 03:00:04" level=info comp=collecte site=⟬trap:word_name|Paris⟭-Est fichiers=118 taille_mo=412
ts="⟬date#1⟭ 03:00:09" level=info comp=collecte site=⟬trap:word_name|Saint-Pierre⟭-Nord fichiers=97 taille_mo=366
ts="⟬date#1⟭ 03:00:13" level=warn comp=collecte site=⟬trap:word_name|Rose⟭-Sud msg="fichier en retard" retard_s=184
ts="⟬date#1⟭ 03:00:21" level=info comp=dedoublonnage msg="filtre de ⟬trap:eponym|Bloom⟭ initialise" capacite=20000000 taux_faux_positifs=0.001
ts="⟬date#1⟭ 03:01:37" level=info comp=dedoublonnage entrees=4120733 doublons=1802
ts="⟬date#1⟭ 03:02:44" level=info comp=valorisation msg="tarification terminee" lignes=4118931 rejets=0
ts="⟬date#1⟭ 03:02:45" level=debug comp=valorisation ⟬trap:indicator_non_pii|abonne=anonymise⟭ echantillon=⟬uuid#1⟭
ts="⟬date#1⟭ 03:04:12" level=info comp=charge msg="pic de trafic" site=⟬trap:word_name|Paris⟭-Est valeur="12.4 ⟬trap:eponym|Erlang⟭"
ts="⟬date#1⟭ 03:06:30" level=info comp=export msg="envoi vers l'entrepot" dest=⟬url#1⟭ lignes=4118931
ts="⟬date#1⟭ 03:07:02" level=info comp=export msg="accuse de reception" lot=⟬uuid#2⟭ empreinte=⟬hash#1⟭
ts="⟬date#1⟭ 03:07:02" level=info comp=mediation msg="collecte terminee" duree_s=422 version=⟬version#1⟭
ts="⟬date#1⟭ 03:15:00" level=info comp=supervision msg="sonde ok" noeud=⟬hostname#2⟭ ip=⟬ip_address#1⟭
ts="⟬date#1⟭ 03:30:00" level=info comp=supervision msg="sonde ok" noeud=⟬hostname#2⟭ ip=⟬ip_address#1⟭
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: fr
fill_locale: fr_FR
domain: banking
appearance: Java stack trace, exception message, SQL error detail
scenario: Spring trace of an online bank: a duplicate IBAN at account opening, then a refused card whose exception quotes the PAN and the CVV
⟬text⟭
⟬date#1⟭ 14:22:09.871 ERROR [http-nio-8443-exec-12] f.b.c.api.GestionErreurs - Échec ouverture de compte ⟬customer_id#1⟭
org.springframework.dao.DataIntegrityViolationException: could not execute statement; SQL [n/a]; constraint [uk_compte_iban]
	at org.springframework.orm.jpa.vendor.HibernateJpaDialect.convertHibernateAccessException(HibernateJpaDialect.java:279)
	at org.springframework.orm.jpa.JpaTransactionManager.doCommit(JpaTransactionManager.java:565)
	at fr.banque.comptes.OuvertureService.ouvrir(OuvertureService.java:112)
	at fr.banque.comptes.api.CompteController.creer(CompteController.java:58)
Caused by: org.postgresql.util.PSQLException: ERREUR: la valeur d'une clé dupliquée rompt la contrainte unique « uk_compte_iban »
  Détail : La clé « (iban)=(⟬iban#1⟭) » existe déjà.
	at org.postgresql.core.v3.QueryExecutorImpl.receiveErrorResponse(QueryExecutorImpl.java:2676)
	at org.postgresql.jdbc.PgPreparedStatement.executeUpdate(PgPreparedStatement.java:136)
	... 41 common frames omitted

⟬date#1⟭ 14:22:31.204 ERROR [http-nio-8443-exec-7] f.b.c.api.GestionErreurs - Échec enrôlement carte
fr.banque.carte.CarteRefuseeException: PAN ⟬payment_card#2⟭ refusé, titulaire "⟬person_name#2⟭", cvv ⟬card_security_code#2⟭, motif=EXPIREE
	at fr.banque.carte.EnrolementService.verifier(EnrolementService.java:204)
	at fr.banque.carte.EnrolementService.enroler(EnrolementService.java:97)
	at com.fasterxml.⟬trap:library|jackson⟭.databind.ser.BeanSerializer.serialize(BeanSerializer.java:178)
	at fr.banque.carte.api.CarteController.enroler(CarteController.java:76)
	at org.apache.tomcat.util.threads.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:659)
	at java.base/java.lang.Thread.run(Thread.java:833)
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: Node.js error dump, HTTP header, inline JSON
scenario: Axios error of a merchant site's payment service, whose Node dump shows the headers, the request body and the cardholder
⟬text⟭
[checkout] échec paiement commande ⟬order_number#1⟭
AxiosError: Request failed with status code 402
    at settle (/app/node_modules/axios/lib/core/settle.js:19:12)
    at IncomingMessage.handleStreamEnd (/app/node_modules/axios/lib/adapters/http.js:585:11)
    at IncomingMessage.emit (node:events:525:35)
    at endReadableNT (node:internal/streams/readable:1359:12)
    at process.processTicksAndRejections (node:internal/process/task_queues:82:21) {
  code: 'ERR_BAD_REQUEST',
  config: {
    url: '⟬url#1⟭',
    method: 'post',
    headers: {
      Accept: 'application/json',
      'Content-Type': 'application/json',
      Authorization: 'Bearer ⟬jwt#1⟭',
      'X-Client-Ref': '⟬opaque_token#1⟭'
    },
    data: '{"commande":"⟬order_number#1⟭","carte":"⟬payment_card#2⟭","exp":"11/27","cvc":"⟬card_security_code#2⟭"}',
    timeout: 8000
  },
  response: {
    status: 402,
    statusText: 'Payment Required',
    data: { code: 'FONDS_INSUFFISANTS', porteur: "⟬person_name#2⟭", ref: '⟬uuid#1⟭' }
  }
}
⟬end⟭

⟬template⟭
family: logs
format: test output
language: fr
fill_locale: fr_FR
domain: insurance
appearance: pytest diff, Python dict repr, test fixture
scenario: pytest failure of a bonus-malus calculation, printing a car contract fixture with driver, licence and plate
⟬text⟭
================================== FAILURES ===================================
________________ test_crm_conducteur_secondaire_sans_sinistre _________________

contrat_auto = {'conducteur': "⟬person_name#1⟭", 'date_naissance': '⟬birth_date#1⟭', 'permis': '⟬fr_driving_licence#1⟭', 'immat': '⟬fr_license_plate#1⟭', 'crm_initial': 0.95, 'sinistres': []}

    def test_crm_conducteur_secondaire_sans_sinistre(contrat_auto):
        resultat = calcul_crm(contrat_auto, annee=1)
>       assert resultat == pytest.approx(0.90)
E       assert 0.95 == 0.9 ± 9.0e-07
E         comparison failed
E         Obtained: 0.95
E         Expected: 0.9 ± 9.0e-07

tests/tarif/test_crm.py:47: AssertionError
---------------------------- Captured stdout call -----------------------------
calcul_crm contrat=⟬customer_id#1⟭ immat=⟬fr_license_plate#1⟭ annee=1
regle 4 ignoree: aucun sinistre responsable
----------------------------- Captured log call ------------------------------
WARNING  tarif.crm:crm.py:63 conducteur "⟬person_name#1⟭" absent du fichier ANTAI, permis ⟬fr_driving_licence#1⟭ non vérifié
=========================== short test summary info ===========================
FAILED tests/tarif/test_crm.py::test_crm_conducteur_secondaire_sans_sinistre
1 failed, 63 passed in 1.92s
⟬end⟭

⟬template⟭
family: logs
format: test output
language: fr
fill_locale: fr_FR
domain: public administration
appearance: Maven Surefire report, toString dump, assertion message
scenario: Surefire report of a passport online service, whose request toString shows holder, passport and birth date
⟬text⟭
[INFO] -------------------------------------------------------
[INFO]  T E S T S
[INFO] -------------------------------------------------------
[INFO] Running fr.mairie.titres.DemandePasseportServiceTest
[ERROR] Tests run: 9, Failures: 2, Errors: 0, Skipped: 1, Time elapsed: 3.41 s <<< FAILURE! - in fr.mairie.titres.DemandePasseportServiceTest
[ERROR] doitRefuserTitreExpire  Time elapsed: 0.182 s  <<< FAILURE!
org.opentest4j.AssertionFailedError:

expected: "REFUSEE"
 but was: "ACCEPTEE"
	at fr.mairie.titres.DemandePasseportServiceTest.doitRefuserTitreExpire(DemandePasseportServiceTest.java:74)

[ERROR] doitRattacherAncienTitre  Time elapsed: 0.044 s  <<< FAILURE!
org.opentest4j.AssertionFailedError: demande inattendue: DemandePasseport{ancienTitre=⟬fr_passport#1⟭, titulaire="⟬person_name#1⟭", naissance=⟬birth_date#1⟭, commune=⟬city#1⟭, statut=BROUILLON}
	at fr.mairie.titres.DemandePasseportServiceTest.doitRattacherAncienTitre(DemandePasseportServiceTest.java:102)

[INFO] Running fr.mairie.titres.⟬trap:code_identifier|⦃Family⦄RefExporterTest⟭
[INFO] Tests run: 4, Failures: 0, Errors: 0, Skipped: 0, Time elapsed: 0.27 s - in fr.mairie.titres.⟬trap:code_identifier|⦃Family⦄RefExporterTest⟭
[INFO]
[INFO] Results:
[INFO]
[ERROR] Failures:
[ERROR]   DemandePasseportServiceTest.doitRefuserTitreExpire:74 expected: "REFUSEE" but was: "ACCEPTEE"
[ERROR]   DemandePasseportServiceTest.doitRattacherAncienTitre:102 demande inattendue
[INFO]
[ERROR] Tests run: 13, Failures: 2, Errors: 0, Skipped: 1
⟬end⟭

⟬template⟭
family: logs
format: access log
language: fr
fill_locale: fr_FR
domain: banking
appearance: HAProxy log, captured header, query string
scenario: HAProxy log of a banking API capturing the Authorization header and a client reference, with a password in the login URL
⟬text⟭
⟬date#1⟭ 09:14:22 lb-api haproxy[2213]: ⟬ip_address#1⟭ fe_api be_comptes/srv2 0/0/1/42/43 200 1822 {Bearer ⟬jwt#1⟭|⟬opaque_token#1⟭} "GET /api/v3/comptes/⟬customer_id#1⟭/solde HTTP/1.1"
⟬date#1⟭ 09:14:22 lb-api haproxy[2213]: ⟬ip_address#1⟭ fe_api be_comptes/srv1 0/0/1/88/90 200 9410 {Bearer ⟬jwt#1⟭|⟬opaque_token#1⟭} "GET /api/v3/comptes/⟬customer_id#1⟭/operations?limit=50 HTTP/1.1"
⟬date#1⟭ 09:14:23 lb-api haproxy[2213]: ⟬ip_address#2⟭ fe_api be_auth/srv1 0/0/0/12/13 200 311 {-|⟬uuid#1⟭} "GET /healthz HTTP/1.1"
⟬date#1⟭ 09:14:25 lb-api haproxy[2213]: ⟬ip_address#3⟭ fe_api be_auth/srv2 0/0/1/205/207 401 96 {-|-} "POST /auth/login?user=⟬person_name:handle#2⟭&pwd=⟬url_password#2⟭ HTTP/1.1"
⟬date#1⟭ 09:14:27 lb-api haproxy[2213]: ⟬ip_address#3⟭ fe_api be_auth/srv2 0/0/1/198/199 200 642 {-|-} "POST /auth/login?user=⟬person_name:handle#2⟭&pwd=⟬url_password#3⟭ HTTP/1.1"
⟬date#1⟭ 09:14:31 lb-api haproxy[2213]: ⟬ip_address#4⟭ fe_api be_auth/srv1 0/0/1/176/178 200 642 {-|-} "POST /auth/login?user=⟬trap:indicator_non_pii|batch-rapprochement⟭ HTTP/1.1"
⟬date#1⟭ 09:14:32 lb-api haproxy[2213]: ⟬ip_address#4⟭ fe_api be_virements/srv3 0/0/2/311/314 201 204 {Bearer ⟬jwt#4⟭|⟬order_number#4⟭} "POST /api/v3/virements HTTP/1.1"
⟬date#1⟭ 09:14:40 lb-api haproxy[2213]: ⟬ip_address#5⟭ fe_api be_comptes/srv2 0/0/1/39/41 403 88 {Bearer ⟬jwt#5⟭|⟬opaque_token#5⟭} "GET /api/v3/comptes/⟬customer_id#5⟭/releve?annee=2023 HTTP/1.1"
⟬date#1⟭ 09:14:41 lb-api haproxy[2213]: ⟬ip_address#2⟭ fe_api be_auth/srv1 0/0/0/9/10 200 311 {-|⟬uuid#2⟭} "GET /healthz HTTP/1.1"
⟬date#1⟭ 09:14:58 lb-api haproxy[2213]: ⟬ip_address#6⟭ fe_api be_cartes/srv1 0/0/1/96/98 200 1204 {Bearer ⟬jwt#6⟭|⟬opaque_token#6⟭} "GET /api/v3/cartes?statut=actives HTTP/1.1"
⟬date#1⟭ 09:15:02 lb-api haproxy[2213]: ⟬ip_address#6⟭ fe_api be_cartes/srv1 0/0/1/120/122 200 310 {Bearer ⟬jwt#6⟭|⟬opaque_token#6⟭} "POST /api/v3/cartes/opposition HTTP/1.1"
⟬date#1⟭ 09:15:04 lb-api haproxy[2213]: ⟬ip_address#2⟭ fe_api be_auth/srv1 0/0/0/8/9 200 311 {-|⟬uuid#3⟭} "GET /healthz HTTP/1.1"
⟬date#1⟭ 09:15:11 lb-api haproxy[2213]: ⟬ip_address#7⟭ fe_api be_comptes/srv3 0/-1/-1/-1/3002 503 212 {-|-} "GET /api/v3/comptes HTTP/1.1"
⟬date#1⟭ 09:15:12 lb-api haproxy[2213]: backend be_comptes has 2 of 3 servers up
⟬date#1⟭ 09:15:13 lb-api haproxy[2213]: Server be_comptes/srv3 is DOWN, reason: Layer7 timeout
⟬date#1⟭ 09:15:18 lb-api haproxy[2213]: ⟬ip_address#7⟭ fe_api be_comptes/srv1 0/0/1/60/62 200 1822 {Bearer ⟬jwt#7⟭|⟬opaque_token#7⟭} "GET /api/v3/comptes HTTP/1.1"
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: curl command, shell trace, masked secret
scenario: GitHub Actions deployment of a merchant site, where masking misses a curl password and a derived webhook secret
⟬text⟭
##[group]Run ./scripts/deployer_preprod.sh
shell: /usr/bin/bash -e {0}
env:
  REGISTRY_TOKEN: ⟬trap:placeholder|***⟭
  STRIPE_KEY: ⟬trap:placeholder|***⟭
  DEPLOY_ENV: preprod
##[endgroup]
+ export RELEASE=⟬git_sha#1⟭
+ echo 'construction de l'\''image boutique-web'
construction de l'image boutique-web
+ docker build -t ⟬hostname#1⟭/boutique/web:⟬version#1⟭ .
Successfully built ⟬hash#1⟭
+ curl -s -u deploy:⟬password#1⟭ -T web.tar ⟬url#1⟭
{"statut":"recu","taille":48213044}
+ WEBHOOK_SECRET=⟬opaque_token#1⟭
+ echo 'webhook paiement configure pour ⟬hostname#2⟭'
webhook paiement configure pour ⟬hostname#2⟭
+ curl -s -X POST ⟬url#2⟭ -H 'Content-Type: application/json' -d '{"secret":"⟬opaque_token#1⟭","stripe":"⟬stripe_secret_key#1⟭"}'
{"ok":true}
+ ./scripts/smoke_test.sh
GET /panier 200
GET /paiement 200
+ echo 'preprod a jour, ⟬trap:indicator_non_pii|auteur=dependabot[bot]⟭'
preprod a jour, ⟬trap:indicator_non_pii|auteur=dependabot[bot]⟭
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: fr
fill_locale: fr_FR
domain: telecom
appearance: sudo log, auditd record, key=value
scenario: sudo and auditd logs of an operator's SMS front ends, one evening of work done only with service accounts
⟬text⟭
⟬date#1⟭ 22:04:03 smsc-fe01 sudo:  ⟬username#1⟭ : TTY=unknown ; ⟬trap:indicator_non_pii|PWD=/opt/smsc⟭ ; ⟬trap:indicator_non_pii|USER=root⟭ ; COMMAND=/usr/bin/systemctl restart smsc-router
⟬date#1⟭ 22:04:03 smsc-fe01 sudo: pam_unix(sudo:session): session opened for ⟬trap:indicator_non_pii|user root⟭(uid=0) by (uid=1004)
type=USER_CMD msg=audit(1712023443.117:8812): pid=31244 uid=1004 auid=1004 ses=17 msg='cwd="/opt/smsc" cmd=⟬hash#2⟭ res=success'
type=CRED_REFR msg=audit(1712023443.121:8813): pid=31244 uid=0 auid=1004 ses=17 msg='op=PAM:setcred acct="root" exe="/usr/bin/sudo" hostname=? res=success'
⟬date#1⟭ 22:04:11 smsc-fe01 sudo: pam_unix(sudo:session): session closed for ⟬trap:indicator_non_pii|user root⟭
⟬date#1⟭ 22:04:50 smsc-fe01 systemd[1]: Started SMSC routing daemon.
⟬date#1⟭ 22:05:12 smsc-fe02 sudo:  ⟬username#1⟭ : TTY=unknown ; ⟬trap:indicator_non_pii|PWD=/opt/smsc⟭ ; ⟬trap:indicator_non_pii|USER=root⟭ ; COMMAND=/usr/bin/systemctl restart smsc-router
⟬date#1⟭ 22:05:12 smsc-fe02 sudo: pam_unix(sudo:session): session opened for ⟬trap:indicator_non_pii|user root⟭(uid=0) by (uid=1004)
⟬date#1⟭ 22:05:19 smsc-fe02 sudo: pam_unix(sudo:session): session closed for ⟬trap:indicator_non_pii|user root⟭
⟬date#1⟭ 22:05:58 smsc-fe02 systemd[1]: Started SMSC routing daemon.
⟬date#1⟭ 22:06:30 smsc-fe01 sshd[4410]: Accepted publickey for ⟬username#2⟭ from ⟬ip_address#1⟭ port 51144 ssh2: SHA256:⟬hash#1⟭
⟬date#1⟭ 22:06:30 smsc-fe01 sshd[4410]: pam_unix(sshd:session): session opened for user ⟬username#2⟭(uid=1012) by (uid=0)
⟬date#1⟭ 22:07:02 smsc-fe01 sudo:  ⟬username#2⟭ : TTY=pts/1 ; PWD=/home/⟬username#2⟭ ; ⟬trap:indicator_non_pii|USER=oracle⟭ ; COMMAND=/usr/bin/sqlplus -S /nolog @verif_routes.sql
⟬date#1⟭ 22:07:15 smsc-fe01 sudo: pam_unix(sudo:session): session closed for ⟬trap:indicator_non_pii|user oracle⟭
⟬date#1⟭ 22:07:40 smsc-fe01 sshd[4410]: Disconnected from user ⟬username#2⟭ ⟬ip_address#1⟭ port 51144
⟬date#1⟭ 22:07:40 smsc-fe01 sshd[4410]: pam_unix(sshd:session): session closed for user ⟬username#2⟭
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: fr
fill_locale: fr_FR
domain: insurance
appearance: pipe-separated log, JSON diff, quoted value
scenario: audit trail of a car claims tool, tracing who opened the file, changed the bank details and attached the driver
⟬text⟭
⟬date#1⟭ 09:03:11 | "⟬person_name#1⟭" | SINISTRE | OUVERTURE | ⟬ticket_id#1⟭ | immat=⟬fr_license_plate#2⟭ contrat=⟬customer_id#2⟭
⟬date#1⟭ 09:04:02 | "⟬person_name#1⟭" | SINISTRE | RATTACHEMENT_CONDUCTEUR | ⟬ticket_id#1⟭ | conducteur="⟬person_name#2⟭" permis=⟬fr_driving_licence#2⟭
⟬date#1⟭ 09:04:40 | moteur-regles | SINISTRE | CONTROLE_FRAUDE | ⟬ticket_id#1⟭ | score=12 resultat=OK
⟬date#1⟭ 09:11:27 | "⟬person_name#1⟭" | ASSURE | MODIFICATION | ⟬customer_id#2⟭ | {"champ":"rib","avant":"⟬iban#2⟭","apres":"⟬iban#3⟭"}
⟬date#1⟭ 09:11:28 | moteur-regles | ASSURE | ALERTE_RIB | ⟬customer_id#2⟭ | changement de RIB moins de 30 jours avant indemnisation
⟬date#1⟭ 09:26:15 | "⟬person_name#4⟭" | ASSURE | VALIDATION_RIB | ⟬customer_id#2⟭ | second regard effectué, appel au ⟬phone#2⟭
⟬date#1⟭ 09:26:16 | workflow | SINISTRE | ETAT | ⟬ticket_id#1⟭ | {"avant":"OUVERT","apres":"EXPERTISE"}
⟬date#1⟭ 09:40:03 | ⟬trap:indicator_non_pii|gestionnaire=file-expertise⟭ | SINISTRE | AFFECTATION | ⟬ticket_id#1⟭ | expert=⟬company#5⟭
⟬date#1⟭ 10:02:55 | "⟬person_name#1⟭" | DOCUMENT | AJOUT | ⟬ticket_id#1⟭ | fichier=constat-amiable.pdf taille=482113
⟬date#1⟭ 10:03:31 | "⟬person_name#1⟭" | DOCUMENT | CONSULTATION | ⟬ticket_id#1⟭ | fichier=permis-recto.jpg
⟬date#1⟭ 11:17:09 | ⟬company#5⟭ | EXPERTISE | RAPPORT | ⟬ticket_id#1⟭ | montant=3120.40 véhicule=⟬fr_license_plate#2⟭
⟬date#1⟭ 11:18:44 | workflow | SINISTRE | ETAT | ⟬ticket_id#1⟭ | {"avant":"EXPERTISE","apres":"INDEMNISATION"}
⟬date#1⟭ 11:45:20 | "⟬person_name#1⟭" | REGLEMENT | ORDRE | ⟬ticket_id#1⟭ | montant=3120.40 iban=⟬iban#3⟭
⟬date#1⟭ 11:45:21 | workflow | REGLEMENT | ENVOI_BANQUE | ⟬ticket_id#1⟭ | lot=⟬uuid#1⟭
⟬date#1⟭ 11:52:08 | "⟬person_name#1⟭" | SINISTRE | NOTE | ⟬ticket_id#1⟭ | appel de l'assuré, réception du virement confirmée
⟬date#1⟭ 12:00:00 | workflow | SINISTRE | ETAT | ⟬ticket_id#1⟭ | {"avant":"INDEMNISATION","apres":"CLOS"}
⟬end⟭

⟬template⟭
family: logs
format: application log
language: fr
fill_locale: fr_FR
domain: public administration
appearance: log field, quoted value, exception message, key=value
scenario: night run of a prefecture's ID document requests, logging six applicants step by step with their documents and addresses
⟬text⟭
⟬date#1⟭ 01:30:00,004 INFO  titres.batch      : démarrage du traitement de nuit, version ⟬version#1⟭
⟬date#1⟭ 01:30:00,120 INFO  titres.batch      : connexion base ⟬hostname#1⟭, 6 demandes en attente
⟬date#1⟭ 01:30:00,244 INFO  titres.lecture    : demande ⟬uuid#2⟭ type=PASSEPORT canal=mairie
⟬date#1⟭ 01:30:00,245 DEBUG titres.lecture    : demandeur "⟬person_name#2⟭" né(e) le ⟬birth_date#2⟭ à ⟬city#2⟭
⟬date#1⟭ 01:30:00,247 DEBUG titres.lecture    : adresse "⟬fr_postal_address#2⟭"
⟬date#1⟭ 01:30:00,391 INFO  titres.controle   : ancien titre ⟬fr_passport#2⟭ retrouvé, expiré depuis 14 mois
⟬date#1⟭ 01:30:00,512 INFO  titres.controle   : photo conforme, empreintes conformes
⟬date#1⟭ 01:30:00,780 INFO  titres.production : demande ⟬uuid#2⟭ transmise à l'imprimerie, lot ⟬order_number#1⟭
⟬date#1⟭ 01:30:01,003 INFO  titres.lecture    : demande ⟬uuid#3⟭ type=CNI canal=teleservice
⟬date#1⟭ 01:30:01,004 DEBUG titres.lecture    : demandeur "⟬person_name#3⟭" né(e) le ⟬birth_date#3⟭ à ⟬city#3⟭
⟬date#1⟭ 01:30:01,005 DEBUG titres.lecture    : adresse "⟬fr_postal_address#3⟭"
⟬date#1⟭ 01:30:01,220 INFO  titres.controle   : ancienne carte ⟬fr_identity_card#3⟭ déclarée perdue
⟬date#1⟭ 01:30:01,221 WARN  titres.controle   : justificatif de domicile illisible, relance par mail ⟬email#3⟭
⟬date#1⟭ 01:30:01,430 INFO  titres.relance    : modèle RELANCE_JUSTIF envoyé via ⟬hostname#2⟭
⟬date#1⟭ 01:30:01,612 INFO  titres.lecture    : demande ⟬uuid#4⟭ type=PASSEPORT canal=mairie
⟬date#1⟭ 01:30:01,613 DEBUG titres.lecture    : demandeur "⟬person_name#4⟭" né(e) le ⟬birth_date#4⟭ à ⟬city#4⟭
⟬date#1⟭ 01:30:01,614 DEBUG titres.lecture    : adresse "⟬fr_postal_address#4⟭"
⟬date#1⟭ 01:30:01,890 ERROR titres.controle   : NIR manquant dans le dossier d'état civil
⟬date#1⟭ 01:30:01,891 ERROR titres.controle   : fr.titres.DossierIncomplet: demande ⟬uuid#4⟭ sans NIR, contact ⟬phone#4⟭
⟬date#1⟭ 01:30:01,902 INFO  titres.reprise    : demande ⟬uuid#4⟭ placée en reprise manuelle, operateur=⟬trap:indicator_non_pii|file-prefecture⟭
⟬date#1⟭ 01:30:02,114 INFO  titres.lecture    : demande ⟬uuid#5⟭ type=PASSEPORT canal=mairie
⟬date#1⟭ 01:30:02,115 DEBUG titres.lecture    : demandeur "⟬person_name#5⟭" né(e) le ⟬birth_date#5⟭ à ⟬city#5⟭
⟬date#1⟭ 01:30:02,116 DEBUG titres.lecture    : adresse "⟬fr_postal_address#5⟭"
⟬date#1⟭ 01:30:02,340 INFO  titres.controle   : nir=⟬fr_social_security_number#5⟭ vérifié auprès du répertoire
⟬date#1⟭ 01:30:02,341 INFO  titres.controle   : ancien titre ⟬fr_passport#5⟭ encore valide 8 mois
⟬date#1⟭ 01:30:02,342 WARN  titres.controle   : renouvellement anticipé, motif "voyage hors UE"
⟬date#1⟭ 01:30:02,700 INFO  titres.production : demande ⟬uuid#5⟭ transmise à l'imprimerie, lot ⟬order_number#1⟭
⟬date#1⟭ 01:30:02,944 INFO  titres.lecture    : demande ⟬uuid#6⟭ type=CNI canal=mairie
⟬date#1⟭ 01:30:02,945 DEBUG titres.lecture    : demandeur "⟬person_name#6⟭" né(e) le ⟬birth_date#6⟭ à ⟬city#6⟭
⟬date#1⟭ 01:30:02,946 DEBUG titres.lecture    : adresse "⟬fr_postal_address#6⟭"
⟬date#1⟭ 01:30:03,180 INFO  titres.controle   : représentant légal "⟬person_name#7m⟭", tél ⟬phone#7⟭
⟬date#1⟭ 01:30:03,410 INFO  titres.production : demande ⟬uuid#6⟭ transmise à l'imprimerie, lot ⟬order_number#1⟭
⟬date#1⟭ 01:30:03,622 INFO  titres.lecture    : demande ⟬uuid#8⟭ type=PASSEPORT canal=teleservice
⟬date#1⟭ 01:30:03,623 DEBUG titres.lecture    : demandeur "⟬person_name#8⟭" né(e) le ⟬birth_date#8⟭ à ⟬city#8⟭
⟬date#1⟭ 01:30:03,624 DEBUG titres.lecture    : adresse "⟬fr_postal_address#8⟭"
⟬date#1⟭ 01:30:03,840 INFO  titres.controle   : ancien titre ⟬fr_passport#8⟭ déclaré volé
⟬date#1⟭ 01:30:03,841 ERROR titres.controle   : passeport ⟬fr_passport#8⟭ présent dans le fichier des titres volés, demande suspendue
⟬date#1⟭ 01:30:03,842 INFO  titres.signalement: alerte transmise à ⟬email:generic#9⟭
⟬date#1⟭ 01:30:04,001 INFO  titres.batch      : 6 demandes lues: 3 transmises, 1 relancée, 1 en reprise, 1 suspendue
⟬date#1⟭ 01:30:04,002 INFO  titres.batch      : lot ⟬order_number#1⟭ clos, empreinte=⟬hash#1⟭
⟬date#1⟭ 01:30:04,150 INFO  titres.purge      : suppression des fichiers temporaires dans ⟬file_path#1⟭
⟬date#1⟭ 01:30:04,301 INFO  titres.metriques  : durée 4,3 s, mémoire max 212 Mo
⟬date#1⟭ 01:30:04,302 DEBUG titres.metriques  : export vers ⟬url#1⟭
⟬date#1⟭ 01:30:04,410 INFO  titres.batch      : fin du traitement de nuit
⟬date#1⟭ 02:00:00,001 INFO  titres.ordonnanceur : prochain passage dans 24 h
⟬date#1⟭ 02:00:00,002 DEBUG titres.ordonnanceur : verrou libéré sur ⟬hostname#1⟭
⟬date#1⟭ 04:00:00,003 INFO  titres.sauvegarde : sauvegarde quotidienne lancée vers ⟬hostname#3⟭
⟬date#1⟭ 04:12:47,219 INFO  titres.sauvegarde : 3,1 Go copiés, somme de contrôle ⟬hash#2⟭
⟬date#1⟭ 04:12:47,220 INFO  titres.sauvegarde : rétention appliquée, 7 archives conservées
⟬date#1⟭ 05:00:00,000 INFO  titres.synchro    : synchronisation du référentiel des communes
⟬date#1⟭ 05:00:03,481 INFO  titres.synchro    : 34 945 communes, 12 modifications
⟬date#1⟭ 05:00:03,482 DEBUG titres.synchro    : source ⟬url#2⟭
⟬date#1⟭ 05:30:00,000 INFO  titres.supervision: sonde quotidienne OK
⟬date#1⟭ 05:30:00,018 INFO  titres.supervision: file imprimerie vide, 0 message en erreur
⟬date#1⟭ 06:00:00,000 INFO  titres.supervision: ouverture du guichet en ligne
⟬date#1⟭ 06:00:00,402 INFO  titres.supervision: téléservice joignable sur ⟬url#3⟭
⟬date#1⟭ 06:00:00,403 DEBUG titres.supervision: certificat valable encore 61 jours
⟬date#1⟭ 06:15:00,000 INFO  titres.supervision: sonde quotidienne OK
⟬date#1⟭ 06:30:00,000 INFO  titres.supervision: sonde quotidienne OK
⟬date#1⟭ 06:45:00,000 INFO  titres.supervision: sonde quotidienne OK
⟬date#1⟭ 07:00:00,000 INFO  titres.supervision: sonde quotidienne OK
⟬date#1⟭ 07:15:00,000 INFO  titres.supervision: 3 demandes reçues depuis l'ouverture
⟬date#1⟭ 07:30:00,000 INFO  titres.supervision: sonde quotidienne OK
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: fr
fill_locale: fr_FR
domain: banking
appearance: shell trace, connection string, JWT, migration output, private key in a job log
scenario: GitLab deployment job of a credit service in preproduction, in trace mode, leaking the database password, a service JWT and a deploy key
⟬text⟭
Running with gitlab-runner ⟬version#1⟭
Preparing the "kubernetes" executor
Using Kubernetes namespace: ci-credit
Preparing environment
Running on runner-⟬git_sha#1⟭ via gitlab-runner-7
Getting source from Git repository
Fetching changes with git depth set to 20...
Checking out ⟬git_sha#2⟭ as detached HEAD (ref is release/credit-immo)...
Skipping Git submodules setup
Executing "step_script" stage of the job script
$ set -x
$ source ci/env_preprod.sh
+ export APP_ENV=preprod
+ APP_ENV=preprod
+ export DATABASE_URL=postgresql://credit_app:⟬url_password#1⟭@⟬hostname#1⟭:5432/credit
+ DATABASE_URL=postgresql://credit_app:⟬url_password#1⟭@⟬hostname#1⟭:5432/credit
+ export ⟬trap:indicator_non_pii|FLYWAY_USER=credit_owner⟭
+ ⟬trap:indicator_non_pii|FLYWAY_USER=credit_owner⟭
+ export FLYWAY_PASSWORD=⟬password#1⟭
+ FLYWAY_PASSWORD=⟬password#1⟭
+ export SCORING_API_TOKEN=⟬jwt#1⟭
+ SCORING_API_TOKEN=⟬jwt#1⟭
+ export HELM_RELEASE=credit-⟬trap:eponym|⦃given⦄⟭
+ HELM_RELEASE=credit-⟬trap:eponym|⦃given⦄⟭
$ echo "cle de deploiement"; cat ci/deploy_key
+ echo 'cle de deploiement'
cle de deploiement
+ cat ci/deploy_key
⟬private_key#1⟭
$ chmod 600 ci/deploy_key
+ chmod 600 ci/deploy_key
$ ./gradlew flywayInfo flywayMigrate --no-daemon
> Task :flywayInfo
Schema version: 41
+-----------+---------+------------------------------+----------+
| Category  | Version | Description                  | State    |
+-----------+---------+------------------------------+----------+
| Versioned | 41      | ajout table echeancier       | Success  |
| Versioned | 42      | index dossier emprunteur     | Pending  |
| Versioned | 43      | colonne taux assurance       | Pending  |
+-----------+---------+------------------------------+----------+
> Task :flywayMigrate
Successfully applied 2 migrations to schema "credit", now at version v43
BUILD SUCCESSFUL in 24s
$ curl -sf -H "Authorization: Bearer ⟬trap:placeholder|$SCORING_API_TOKEN⟭" ⟬url#1⟭
+ curl -sf -H 'Authorization: Bearer ⟬jwt#1⟭' ⟬url#1⟭
{"statut":"UP","modele":"⟬version#2⟭"}
$ curl -sf -X POST -H "X-Client-Ref: $PARTENAIRE_REF" ⟬url#2⟭
+ curl -sf -X POST -H 'X-Client-Ref: ⟬opaque_token#1⟭' ⟬url#2⟭
{"statut":"enregistre","ref":"⟬uuid#1⟭"}
$ helm upgrade --install $HELM_RELEASE charts/credit --set image.tag=⟬git_sha#2⟭ --wait
+ helm upgrade --install credit-⟬trap:eponym|⦃given⦄⟭ charts/credit --set image.tag=⟬git_sha#2⟭ --wait
Release "credit-⟬trap:eponym|⦃given⦄⟭" has been upgraded. Happy Helming!
NAME: credit-⟬trap:eponym|⦃given⦄⟭
NAMESPACE: credit-preprod
STATUS: deployed
REVISION: 118
$ ./ci/notifier.sh
+ echo 'notification equipe credit'
notification equipe credit
+ curl -sf -X POST ⟬url#3⟭ -d '{"text":"credit deploye en preprod par ⟬trap:indicator_non_pii|auteur=release-bot⟭"}'
ok
Cleaning up project directory and file based variables
Job succeeded
⟬end⟭

⟬template⟭
family: logs
format: access log
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: combined log format, query string, user agent
scenario: nginx access of a health centre's booking portal, a morning of bots, probes and public pages, with no identified patient
⟬text⟭
⟬ip_address#1⟭ - - [⟬date#1⟭ 06:00:02 +0100] "GET /healthz HTTP/1.1" 200 2 "-" "kube-probe/1.28"
⟬ip_address#1⟭ - - [⟬date#1⟭ 06:00:12 +0100] "GET /healthz HTTP/1.1" 200 2 "-" "kube-probe/1.28"
⟬ip_address#2⟭ - - [⟬date#1⟭ 06:00:18 +0100] "GET /robots.txt HTTP/1.1" 200 64 "-" "Mozilla/5.0 (compatible; bingbot/2.0)"
⟬ip_address#2⟭ - - [⟬date#1⟭ 06:00:19 +0100] "GET /sitemap.xml HTTP/1.1" 200 2144 "-" "Mozilla/5.0 (compatible; bingbot/2.0)"
⟬ip_address#2⟭ - - [⟬date#1⟭ 06:00:21 +0100] "GET /centres/cardiologie HTTP/1.1" 200 18230 "-" "Mozilla/5.0 (compatible; bingbot/2.0)"
⟬ip_address#1⟭ - - [⟬date#1⟭ 06:00:22 +0100] "GET /healthz HTTP/1.1" 200 2 "-" "kube-probe/1.28"
⟬ip_address#2⟭ - - [⟬date#1⟭ 06:00:24 +0100] "GET /centres/dermatologie HTTP/1.1" 200 17904 "-" "Mozilla/5.0 (compatible; bingbot/2.0)"
⟬ip_address#3⟭ - - [⟬date#1⟭ 06:01:03 +0100] "GET /.env HTTP/1.1" 404 153 "-" "curl/8.4.0"
⟬ip_address#3⟭ - - [⟬date#1⟭ 06:01:03 +0100] "GET /wp-login.php HTTP/1.1" 404 153 "-" "curl/8.4.0"
⟬ip_address#3⟭ - - [⟬date#1⟭ 06:01:04 +0100] "GET /admin/config.php HTTP/1.1" 404 153 "-" "curl/8.4.0"
⟬ip_address#3⟭ - - [⟬date#1⟭ 06:01:04 +0100] "POST /login?⟬trap:indicator_non_pii|user=admin⟭&password=⟬trap:placeholder|%24%7BPASSWORD%7D⟭ HTTP/1.1" 405 157 "-" "curl/8.4.0"
⟬ip_address#1⟭ - - [⟬date#1⟭ 06:01:12 +0100] "GET /healthz HTTP/1.1" 200 2 "-" "kube-probe/1.28"
⟬ip_address#4⟭ - - [⟬date#1⟭ 06:02:40 +0100] "GET / HTTP/1.1" 200 9120 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"
⟬ip_address#4⟭ - - [⟬date#1⟭ 06:02:40 +0100] "GET /static/css/site.⟬hash#1⟭.css HTTP/1.1" 200 41288 "⟬url#1⟭" "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"
⟬ip_address#4⟭ - - [⟬date#1⟭ 06:02:40 +0100] "GET /static/js/alpine.min.js HTTP/1.1" 200 44660 "⟬url#1⟭" "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"
⟬ip_address#4⟭ - - [⟬date#1⟭ 06:02:41 +0100] "GET /static/fonts/⟬trap:eponym|garamond⟭.woff2 HTTP/1.1" 200 15340 "⟬url#1⟭" "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"
⟬ip_address#4⟭ - - [⟬date#1⟭ 06:02:58 +0100] "GET /rdv/creneaux?⟬trap:indicator_non_pii|medecin=tous⟭&specialite=cardiologie HTTP/1.1" 200 2240 "⟬url#1⟭" "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"
⟬ip_address#4⟭ - - [⟬date#1⟭ 06:03:11 +0100] "GET /rdv/creneaux?⟬trap:indicator_non_pii|medecin=tous⟭&specialite=dermatologie&semaine=12 HTTP/1.1" 200 1984 "⟬url#1⟭" "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"
⟬ip_address#4⟭ - - [⟬date#1⟭ 06:03:20 +0100] "GET /infos/preparer-sa-venue HTTP/1.1" 200 12220 "⟬url#1⟭" "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"
⟬ip_address#1⟭ - - [⟬date#1⟭ 06:03:22 +0100] "GET /healthz HTTP/1.1" 200 2 "-" "kube-probe/1.28"
⟬ip_address#5⟭ - - [⟬date#1⟭ 06:04:02 +0100] "GET /centres/radiologie HTTP/1.1" 200 16120 "-" "Mozilla/5.0 (compatible; Googlebot/2.1)"
⟬ip_address#5⟭ - - [⟬date#1⟭ 06:04:05 +0100] "GET /centres/pediatrie HTTP/1.1" 200 16544 "-" "Mozilla/5.0 (compatible; Googlebot/2.1)"
⟬ip_address#5⟭ - - [⟬date#1⟭ 06:04:09 +0100] "GET /centres/ophtalmologie HTTP/1.1" 200 15902 "-" "Mozilla/5.0 (compatible; Googlebot/2.1)"
⟬ip_address#5⟭ - - [⟬date#1⟭ 06:04:12 +0100] "GET /actualites/vaccination-grippe HTTP/1.1" 200 9811 "-" "Mozilla/5.0 (compatible; Googlebot/2.1)"
⟬ip_address#6⟭ - - [⟬date#1⟭ 06:05:30 +0100] "GET /api/v1/horaires?centre=⟬customer_id#1⟭ HTTP/1.1" 200 412 "-" "Uptime-Kuma/1.23.3"
⟬ip_address#6⟭ - - [⟬date#1⟭ 06:05:30 +0100] "GET /api/v1/status HTTP/1.1" 200 96 "-" "Uptime-Kuma/1.23.3"
⟬ip_address#1⟭ - - [⟬date#1⟭ 06:05:42 +0100] "GET /healthz HTTP/1.1" 200 2 "-" "kube-probe/1.28"
⟬ip_address#7⟭ - - [⟬date#1⟭ 06:06:15 +0100] "GET /praticiens?⟬trap:indicator_non_pii|nom=%3Cnom%3E⟭ HTTP/1.1" 400 96 "-" "python-requests/2.31.0"
⟬ip_address#7⟭ - - [⟬date#1⟭ 06:06:15 +0100] "GET /praticiens?⟬trap:indicator_non_pii|prenom=%2A⟭ HTTP/1.1" 400 96 "-" "python-requests/2.31.0"
⟬ip_address#7⟭ - - [⟬date#1⟭ 06:06:16 +0100] "GET /patients?⟬trap:indicator_non_pii|nir=null⟭ HTTP/1.1" 401 88 "-" "python-requests/2.31.0"
⟬ip_address#7⟭ - - [⟬date#1⟭ 06:06:16 +0100] "GET /patients/export.csv HTTP/1.1" 401 88 "-" "python-requests/2.31.0"
⟬ip_address#1⟭ - - [⟬date#1⟭ 06:06:32 +0100] "GET /healthz HTTP/1.1" 200 2 "-" "kube-probe/1.28"
⟬ip_address#8⟭ - - [⟬date#1⟭ 06:07:01 +0100] "GET /favicon.ico HTTP/1.1" 200 1150 "-" "Mozilla/5.0 (iPhone; CPU iPhone OS 17_1 like Mac OS X)"
⟬ip_address#8⟭ - - [⟬date#1⟭ 06:07:01 +0100] "GET / HTTP/1.1" 200 9120 "-" "Mozilla/5.0 (iPhone; CPU iPhone OS 17_1 like Mac OS X)"
⟬ip_address#8⟭ - - [⟬date#1⟭ 06:07:03 +0100] "GET /centres/maternite HTTP/1.1" 200 14220 "⟬url#1⟭" "Mozilla/5.0 (iPhone; CPU iPhone OS 17_1 like Mac OS X)"
⟬ip_address#8⟭ - - [⟬date#1⟭ 06:07:20 +0100] "GET /infos/tarifs HTTP/1.1" 200 8840 "⟬url#1⟭" "Mozilla/5.0 (iPhone; CPU iPhone OS 17_1 like Mac OS X)"
⟬ip_address#8⟭ - - [⟬date#1⟭ 06:07:44 +0100] "GET /infos/acces-parking HTTP/1.1" 200 7732 "⟬url#1⟭" "Mozilla/5.0 (iPhone; CPU iPhone OS 17_1 like Mac OS X)"
⟬ip_address#1⟭ - - [⟬date#1⟭ 06:08:02 +0100] "GET /healthz HTTP/1.1" 200 2 "-" "kube-probe/1.28"
⟬ip_address#2⟭ - - [⟬date#1⟭ 06:08:30 +0100] "GET /centres/rhumatologie HTTP/1.1" 200 15114 "-" "Mozilla/5.0 (compatible; bingbot/2.0)"
⟬ip_address#2⟭ - - [⟬date#1⟭ 06:08:33 +0100] "GET /centres/neurologie HTTP/1.1" 200 15930 "-" "Mozilla/5.0 (compatible; bingbot/2.0)"
⟬ip_address#9⟭ - - [⟬date#1⟭ 06:09:10 +0100] "HEAD / HTTP/1.1" 200 0 "-" "Pingdom.com_bot_version_1.4"
⟬ip_address#1⟭ - - [⟬date#1⟭ 06:09:12 +0100] "GET /healthz HTTP/1.1" 200 2 "-" "kube-probe/1.28"
⟬ip_address#10⟭ - - [⟬date#1⟭ 06:10:01 +0100] "GET /api/v1/horaires?centre=⟬customer_id#2⟭ HTTP/1.1" 200 398 "⟬url#2⟭" "Mozilla/5.0 (Macintosh; Intel Mac OS X 14_1)"
⟬ip_address#10⟭ - - [⟬date#1⟭ 06:10:03 +0100] "GET /rdv/creneaux?⟬trap:indicator_non_pii|patient=anonyme⟭&centre=⟬customer_id#2⟭ HTTP/1.1" 200 1720 "⟬url#2⟭" "Mozilla/5.0 (Macintosh; Intel Mac OS X 14_1)"
⟬ip_address#10⟭ - - [⟬date#1⟭ 06:10:14 +0100] "GET /rdv/connexion HTTP/1.1" 200 5120 "⟬url#2⟭" "Mozilla/5.0 (Macintosh; Intel Mac OS X 14_1)"
⟬ip_address#10⟭ - - [⟬date#1⟭ 06:10:41 +0100] "GET /infos/preparer-sa-venue HTTP/1.1" 304 0 "⟬url#2⟭" "Mozilla/5.0 (Macintosh; Intel Mac OS X 14_1)"
⟬ip_address#1⟭ - - [⟬date#1⟭ 06:10:42 +0100] "GET /healthz HTTP/1.1" 200 2 "-" "kube-probe/1.28"
⟬ip_address#11⟭ - - [⟬date#1⟭ 06:11:15 +0100] "GET /actualites HTTP/1.1" 200 13340 "-" "Mozilla/5.0 (X11; Linux x86_64)"
⟬ip_address#11⟭ - - [⟬date#1⟭ 06:11:16 +0100] "GET /actualites/nouveau-scanner HTTP/1.1" 200 8120 "⟬url#1⟭" "Mozilla/5.0 (X11; Linux x86_64)"
⟬ip_address#11⟭ - - [⟬date#1⟭ 06:11:40 +0100] "GET /actualites/journee-depistage HTTP/1.1" 200 7990 "⟬url#1⟭" "Mozilla/5.0 (X11; Linux x86_64)"
⟬ip_address#1⟭ - - [⟬date#1⟭ 06:12:02 +0100] "GET /healthz HTTP/1.1" 200 2 "-" "kube-probe/1.28"
⟬ip_address#3⟭ - - [⟬date#1⟭ 06:12:40 +0100] "GET /phpmyadmin/ HTTP/1.1" 404 153 "-" "curl/8.4.0"
⟬ip_address#3⟭ - - [⟬date#1⟭ 06:12:41 +0100] "GET /backup.sql HTTP/1.1" 404 153 "-" "curl/8.4.0"
⟬ip_address#3⟭ - - [⟬date#1⟭ 06:12:41 +0100] "GET /.git/config HTTP/1.1" 404 153 "-" "curl/8.4.0"
⟬ip_address#9⟭ - - [⟬date#1⟭ 06:14:10 +0100] "HEAD / HTTP/1.1" 200 0 "-" "Pingdom.com_bot_version_1.4"
⟬ip_address#1⟭ - - [⟬date#1⟭ 06:14:12 +0100] "GET /healthz HTTP/1.1" 200 2 "-" "kube-probe/1.28"
⟬ip_address#6⟭ - - [⟬date#1⟭ 06:15:30 +0100] "GET /api/v1/status HTTP/1.1" 200 96 "-" "Uptime-Kuma/1.23.3"
⟬ip_address#12⟭ - - [⟬date#1⟭ 06:16:02 +0100] "GET /centres/cardiologie HTTP/1.1" 200 18230 "⟬url#3⟭" "Mozilla/5.0 (Android 14; Mobile)"
⟬ip_address#12⟭ - - [⟬date#1⟭ 06:16:20 +0100] "GET /rdv/creneaux?⟬trap:indicator_non_pii|medecin=tous⟭&specialite=cardiologie HTTP/1.1" 200 2240 "⟬url#1⟭" "Mozilla/5.0 (Android 14; Mobile)"
⟬ip_address#12⟭ - - [⟬date#1⟭ 06:16:48 +0100] "GET /rdv/connexion HTTP/1.1" 200 5120 "⟬url#1⟭" "Mozilla/5.0 (Android 14; Mobile)"
⟬ip_address#1⟭ - - [⟬date#1⟭ 06:17:02 +0100] "GET /healthz HTTP/1.1" 200 2 "-" "kube-probe/1.28"
⟬ip_address#6⟭ - - [⟬date#1⟭ 06:20:30 +0100] "GET /api/v1/status HTTP/1.1" 200 96 "-" "Uptime-Kuma/1.23.3"
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: fr
fill_locale: fr_FR
domain: telecom
appearance: Java stack trace, object dump, exception message, secret under an innocuous key
scenario: trace of a failed line provisioning at an operator, with a full subscriber record dump between long call stacks
⟬text⟭
⟬date#1⟭ 16:48:03.511 ERROR [provisioning-pool-4] f.o.prov.CommandeLigneJob - échec du provisionnement, commande ⟬order_number#1⟭
fr.operateur.prov.ProvisionnementException: activation SIM refusée par le HLR (code 21)
	at fr.operateur.prov.hlr.ClientHlr.activer(ClientHlr.java:144)
	at fr.operateur.prov.hlr.ClientHlr.activerAvecReprise(ClientHlr.java:102)
	at fr.operateur.prov.CommandeLigneJob.traiter(CommandeLigneJob.java:231)
	at fr.operateur.prov.CommandeLigneJob.execute(CommandeLigneJob.java:88)
	at org.quartz.core.JobRunShell.run(JobRunShell.java:202)
	at org.quartz.simpl.SimpleThreadPool$WorkerThread.run(SimpleThreadPool.java:573)
Caused by: fr.operateur.prov.hlr.ReponseHlrException: reponse inattendue
	at fr.operateur.prov.hlr.DecodeurReponse.lire(DecodeurReponse.java:77)
	at fr.operateur.prov.hlr.ClientHlr.envoyer(ClientHlr.java:190)
	at fr.operateur.prov.hlr.ClientHlr.activer(ClientHlr.java:131)
	... 5 common frames omitted
Caused by: java.net.SocketTimeoutException: Read timed out
	at java.base/sun.nio.ch.NioSocketImpl.timedRead(NioSocketImpl.java:288)
	at java.base/sun.nio.ch.NioSocketImpl.implRead(NioSocketImpl.java:314)
	at java.base/sun.nio.ch.NioSocketImpl.read(NioSocketImpl.java:355)
	at java.base/java.net.Socket$SocketInputStream.read(Socket.java:976)
	at fr.operateur.prov.hlr.ClientHlr.envoyer(ClientHlr.java:185)
	... 6 common frames omitted

⟬date#1⟭ 16:48:03.514 DEBUG [provisioning-pool-4] f.o.prov.CommandeLigneJob - contexte de la commande au moment de l'erreur:
CommandeLigne[
  id=⟬uuid#1⟭,
  statut=EN_ERREUR,
  tentative=3,
  offre=FORFAIT_100GO,
  msisdn=⟬phone#2⟭,
  sim=⟬uuid#3⟭,
  abonne=Abonne[
    id=⟬customer_id#2⟭,
    nom="⟬person_name:family#2⟭",
    prenom="⟬person_name:given#2⟭",
    naissance=⟬birth_date#2⟭,
    email=⟬email#2⟭,
    adresse="⟬fr_postal_address#2⟭",
    moyenPaiement=Prelevement[iban=⟬iban#2⟭, rum=⟬uuid#2⟭],
    carteSecours=Carte[numero=⟬payment_card#2⟭, expiration=03/28]
  ],
  portabilite=Portabilite[rio=⟬customer_id#6⟭, operateurDonneur=⟬company#3⟭],
  partenaire=Partenaire[code=DISTRIB-12, ref=⟬opaque_token#1⟭],
  parametres=[Parametre[nom=espace_client, value=⟬password#2⟭], Parametre[nom=canal, value=⟬uuid#4⟭]],
  vendeur="⟬person_name#4⟭",
  boutique=⟬city#3⟭
]

⟬date#1⟭ 16:48:03.520 WARN  [provisioning-pool-4] f.o.prov.Reprise - commande ⟬order_number#1⟭ replanifiée, prochain essai dans 15 min
⟬date#1⟭ 16:48:03.902 ERROR [provisioning-pool-2] f.o.notif.EnvoiSms - envoi SMS de confirmation impossible
org.springframework.web.client.ResourceAccessException: I/O error on POST request for "⟬url#1⟭": Connection reset
	at org.springframework.web.client.RestTemplate.doExecute(RestTemplate.java:785)
	at org.springframework.web.client.RestTemplate.execute(RestTemplate.java:711)
	at org.springframework.web.client.RestTemplate.postForEntity(RestTemplate.java:468)
	at fr.operateur.notif.EnvoiSms.envoyer(EnvoiSms.java:63)
	at fr.operateur.notif.EnvoiSms$$FastClassBySpringCGLIB.invoke(<generated>)
	at org.springframework.cglib.proxy.MethodProxy.invoke(MethodProxy.java:218)
	at fr.operateur.prov.Notifications.confirmer(Notifications.java:47)
	at fr.operateur.prov.CommandeLigneJob.terminer(CommandeLigneJob.java:260)
Caused by: java.net.SocketException: Connection reset
	at java.base/sun.nio.ch.NioSocketImpl.implRead(NioSocketImpl.java:323)
	at java.base/java.net.Socket$SocketInputStream.read(Socket.java:976)
	at org.apache.http.impl.io.SessionInputBufferImpl.streamRead(SessionInputBufferImpl.java:137)
	... 22 common frames omitted
⟬date#1⟭ 16:48:03.905 INFO  [provisioning-pool-2] f.o.notif.EnvoiSms - message en attente pour ⟬phone#2⟭
⟬end⟭
