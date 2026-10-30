⟬template⟭
family: logs
format: application log
language: fr
fill_locale: fr_FR
domain: insurance
appearance: log4net line, nested context, log field
scenario: log4net log of contract takeover at a car mutual, with the contract in the context and the plate and licence of the policyholder
⟬text⟭
⟬date#1⟭ 10:02:03,114 [12] INFO  Reprise.Lecteur [contrat=⟬customer_id#1⟭] - lecture du fichier de l'ancien assureur
⟬date#1⟭ 10:02:03,201 [12] WARN  Reprise.Controle [contrat=⟬customer_id#1⟭] - véhicule ⟬fr_license_plate#1⟭ déjà couvert par un contrat actif
⟬date#1⟭ 10:02:03,202 [12] WARN  Reprise.Controle [contrat=⟬customer_id#1⟭] - souscripteur "⟬person_name#1⟭", permis ⟬fr_driving_licence#1⟭, relevé d'information manquant
⟬date#1⟭ 10:02:03,350 [12] INFO  Reprise.Lecteur [contrat=⟬customer_id#2⟭] - ⟬trap:indicator_non_pii|souscripteur=personne morale⟭, aucun conducteur désigné
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: fr
fill_locale: fr_FR
domain: banking
appearance: Rust panic, backtrace, code identifier
scenario: Rust panic of an online bank's ledger engine, with no customer data
⟬text⟭
thread 'tokio-runtime-worker' panicked at 'called `Option::unwrap()` on a `None` value', src/grand_livre/appliquer.rs:212:38
stack backtrace:
   0: rust_begin_unwind
   1: core::panicking::panic_fmt
   2: core::panicking::panic
   3: grand_livre::appliquer::⟬trap:code_identifier|frais_⦃family⦄⟭
             at ./src/grand_livre/appliquer.rs:212:38
   4: grand_livre::lot::traiter
             at ./src/grand_livre/lot.rs:88:9
   5: tokio::runtime::task::harness::poll_future
note: Some details are omitted, run with `RUST_BACKTRACE=full` for a verbose backtrace.
⟬end⟭

⟬template⟭
family: logs
format: test output
language: fr
fill_locale: fr_FR
domain: public administration
appearance: TAP output, YAML diagnostic, test fixture
scenario: TAP output of node:test for a town's entitlement calculation, where a failing case shows the test user's identity card and birth date
⟬text⟭
TAP version 13
# Subtest: quotient familial
ok 1 - deux parts
not ok 2 - usager seul
  ---
  duration_ms: 1.204
  failureType: 'testCodeFailure'
  error: 'attendu 3 parts pour "⟬person_name#1⟭", né(e) le ⟬birth_date#1⟭, CNI ⟬fr_identity_card#1⟭'
  ...
1..2
# fail 1
⟬end⟭

⟬template⟭
family: logs
format: access log
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: varnishncsa log, query string, cache status
scenario: Varnish log of a shop, where a tracking link keeps an opaque token and the mobile app passes its JWT in the query string
⟬text⟭
⟬ip_address#1⟭ - - [⟬date#1⟭ 12:00:01 +0100] "GET https://⟬hostname#1⟭/compte/commandes?session=⟬jwt#1⟭ HTTP/1.1" 200 4120 miss 0.214
⟬ip_address#1⟭ - - [⟬date#1⟭ 12:00:03 +0100] "GET https://⟬hostname#1⟭/images/sac-cuir.webp HTTP/1.1" 200 88120 hit 0.001
⟬ip_address#2⟭ - - [⟬date#1⟭ 12:00:09 +0100] "GET https://⟬hostname#1⟭/suivi?t=⟬opaque_token#1⟭ HTTP/1.1" 200 2240 miss 0.098
⟬ip_address#3⟭ - - [⟬date#1⟭ 12:00:14 +0100] "GET https://⟬hostname#1⟭/suivi?t=⟬uuid#1⟭ HTTP/1.1" 404 512 miss 0.041
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: docker build output, build argument, CLI argument
scenario: Docker build of a medical imaging image, whose build arguments show an AWS key, a Hugging Face token and a database password
⟬text⟭
Sending build context to Docker daemon  84.2MB
Step 6/12 : ARG HF_TOKEN=⟬huggingface_token#1⟭
 ---> Running in ⟬git_sha#1⟭
Step 7/12 : ENV AWS_ACCESS_KEY_ID=⟬aws_access_key_id#1⟭ AWS_SECRET_ACCESS_KEY=⟬aws_secret_access_key#1⟭
 ---> Running in ⟬git_sha#2⟭
Step 8/12 : RUN mysql -h ⟬hostname#1⟭ -u pacs_init -p⟬password#1⟭ < schema.sql
 ---> Running in ⟬git_sha#3⟭
Successfully built ⟬git_sha#4⟭
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: fr
fill_locale: fr_FR
domain: telecom
appearance: Cisco IOS syslog, AAA accounting
scenario: AAA log of core routers, one maintenance night done with shared supervision accounts
⟬text⟭
⟬date#1⟭ 02:11:04 ⟬hostname#1⟭ %SEC_LOGIN-5-LOGIN_SUCCESS: Login Success [⟬trap:indicator_non_pii|user: noc-ro⟭] [Source: ⟬ip_address#1⟭] [localport: 22]
⟬date#1⟭ 02:11:30 ⟬hostname#1⟭ %PARSER-5-CFGLOG_LOGGEDCMD: ⟬trap:indicator_non_pii|User:noc-ro⟭ logged command:show ip bgp summary
⟬date#1⟭ 02:13:02 ⟬hostname#1⟭ %SEC_LOGIN-4-LOGIN_FAILED: Login failed [⟬trap:indicator_non_pii|user: admin⟭] [Source: ⟬ip_address#2⟭] [Reason: Login Authentication Failed]
⟬date#1⟭ 02:14:40 ⟬hostname#1⟭ %SYS-5-CONFIG_I: Configured from console by ⟬trap:indicator_non_pii|user noc-rw⟭ on vty0 (⟬ip_address#1⟭)
⟬end⟭

⟬template⟭
family: logs
format: application log
language: fr
fill_locale: fr_FR
domain: telecom
appearance: Rails tagged log, log field, secret under an innocuous key
scenario: Rails log of an operator's debt collection, with line number, rejected direct debit IBAN and partner references
⟬text⟭
[⟬uuid#1⟭] [worker-2] Debut relance lot=⟬order_number#1⟭ lignes=3
[⟬uuid#1⟭] [worker-2] Abonne Load (1.2ms)  SELECT "abonnes".* FROM "abonnes" WHERE "abonnes"."statut" = $1  [["statut", "impaye"]]
[⟬uuid#1⟭] [worker-2] Relance ligne ⟬phone#2⟭ titulaire "⟬person_name#2⟭" solde=48.90
[⟬uuid#1⟭] [worker-2] Prelevement rejete iban=⟬iban#2⟭ motif=AM04
[⟬uuid#1⟭] [worker-2] Sms relance envoye via passerelle, ref=⟬opaque_token#1⟭
[⟬uuid#1⟭] [worker-2] Relance ligne ⟬phone#3⟭ titulaire "⟬person_name#3⟭" solde=112.40
[⟬uuid#1⟭] [worker-2] Plan d'apurement propose, conseiller=⟬trap:indicator_non_pii|file-recouvrement⟭
[⟬uuid#1⟭] [worker-2] Sms relance envoye via passerelle, ref=⟬uuid#2⟭
[⟬uuid#1⟭] [worker-2] Relance ligne ⟬phone#4⟭ titulaire "⟬person_name#4⟭" solde=24.00
[⟬uuid#1⟭] [worker-2] Suspension programmee, conseiller=⟬person_name#5⟭
[⟬uuid#1⟭] [worker-2] Prelevement rejete iban=⟬iban#4⟭ motif=MD06
[⟬uuid#1⟭] [worker-2] Courrier genere pour "⟬fr_postal_address#4⟭"
[⟬uuid#1⟭] [worker-2] Fin relance lot=⟬order_number#1⟭ duree=2.41s
[⟬uuid#3⟭] [worker-1] Enqueued StatsJob (Job ID: ⟬uuid#4⟭) to Sidekiq(default)
[⟬uuid#3⟭] [worker-1] Performed StatsJob in 412.0ms
[⟬uuid#5⟭] [web-1] Started GET "/up" for ⟬ip_address#1⟭
[⟬uuid#5⟭] [web-1] Completed 200 OK in 2ms
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: fr
fill_locale: fr_FR
domain: public administration
appearance: Spring validation error, rejected value, Java stack trace
scenario: Spring validation error of a digital identity service, whose rejected values copy the identity card, passport and NIR entered by the user
⟬text⟭
⟬date#1⟭ 11:40:02.310  WARN 2210 --- [nio-8443-exec-4] .m.m.a.ExceptionHandlerExceptionResolver : Resolved [org.springframework.web.bind.MethodArgumentNotValidException: Validation failed for argument [0] in public fr.identite.Reponse fr.identite.PieceController.deposer(fr.identite.Piece): [Field error in object 'piece' on field 'cni': rejected value [⟬fr_identity_card#1⟭]; codes [Pattern.piece.cni,Pattern.cni,Pattern]; default message [format de carte invalide]] ]
⟬date#1⟭ 11:41:18.044 ERROR 2210 --- [nio-8443-exec-7] f.identite.ErreursGlobales              : erreur non prévue
fr.identite.PieceInvalideException: Field error in object 'piece' on field 'passeport': rejected value [⟬fr_passport#2⟭]; codes [Expire.piece.passeport]; default message [passeport expiré]
	at fr.identite.PieceService.controler(PieceService.java:77)
	at fr.identite.PieceController.deposer(PieceController.java:41)
	at jdk.internal.reflect.GeneratedMethodAccessor112.invoke(Unknown Source)
	at org.springframework.web.method.support.InvocableHandlerMethod.doInvoke(InvocableHandlerMethod.java:205)
	at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:1072)
Caused by: fr.identite.RepertoireException: NIR ⟬fr_social_security_number#2⟭ inconnu du répertoire pour "⟬person_name#2⟭"
	at fr.identite.ClientRepertoire.verifier(ClientRepertoire.java:63)
	at fr.identite.PieceService.controler(PieceService.java:70)
	... 34 common frames omitted
Caused by: org.springframework.web.client.HttpClientErrorException$NotFound: 404 : "{"code":"INCONNU","ref":"⟬uuid#1⟭"}"
	at org.springframework.web.client.HttpClientErrorException.create(HttpClientErrorException.java:113)
	at org.springframework.web.client.DefaultResponseErrorHandler.handleError(DefaultResponseErrorHandler.java:186)
	... 38 common frames omitted
⟬end⟭

⟬template⟭
family: logs
format: test output
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: Vitest output, snapshot diff, test account stand-in
scenario: Vitest output of a shop's components, with a family-named brand, initials and field stand-ins, no real customer
⟬text⟭
 RUN  v1.2.2 /app/front

 ✓ src/composants/Prix.test.tsx (6)
 ✓ src/composants/Panier.test.tsx (9)
 ❯ src/composants/FicheMarque.test.tsx (3)
   ✓ affiche ⟬trap:company_name|⦃Family⦄ & Fils⟭ dans le fil d'Ariane
   ✓ conserve les initiales ⟬trap:initials|JD⟭ sur le monogramme
   × met à jour la description
 ✓ src/composants/Adresse.test.tsx (4)

⎯⎯⎯⎯⎯⎯⎯ Failed Tests 1 ⎯⎯⎯⎯⎯⎯⎯

 FAIL  src/composants/FicheMarque.test.tsx > met à jour la description
Error: Snapshot `description 1` mismatched

- Expected
+ Received

  <section>
-   Maison fondée à ⟬trap:word_name|Paris⟭
+   Maison fondée à Lyon
    <input placeholder="⟬trap:indicator_non_pii|<NOM>⟭" />
    <input placeholder="⟬trap:indicator_non_pii|<email>⟭" />
  </section>

 Test Files  1 failed | 3 passed (4)
      Tests  1 failed | 21 passed (22)
   Duration  2.14s
⟬end⟭

⟬template⟭
family: logs
format: test output
language: fr
fill_locale: fr_FR
domain: banking
appearance: unittest output, assertion diff, multi-line dict
scenario: verbose unittest output of a bank account transfer module, where the assertion diff shows account, IBAN, card and bank code
⟬text⟭
test_cloture_compte (tests.test_domiciliation.Cloture) ... ok
test_iban_depuis_rib (tests.test_domiciliation.Rib) ... FAIL
test_transfert_carte (tests.test_domiciliation.Carte) ... FAIL

======================================================================
FAIL: test_iban_depuis_rib (tests.test_domiciliation.Rib)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/srv/banque/tests/test_domiciliation.py", line 44, in test_iban_depuis_rib
    self.assertEqual(iban_depuis_rib(rib), attendu)
AssertionError: {'banque': '⟬bic#1⟭', 'compte': '⟬bank_account_number#1⟭', 'iban': '⟬iban#1⟭'} != {'banque': '⟬bic#1⟭', 'compte': '⟬bank_account_number#1⟭', 'iban': '⟬iban#2⟭'}
- {'banque': '⟬bic#1⟭', 'compte': '⟬bank_account_number#1⟭', 'iban': '⟬iban#1⟭'}
+ {'banque': '⟬bic#1⟭', 'compte': '⟬bank_account_number#1⟭', 'iban': '⟬iban#2⟭'}

======================================================================
FAIL: test_transfert_carte (tests.test_domiciliation.Carte)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/srv/banque/tests/test_domiciliation.py", line 71, in test_transfert_carte
    self.assertIsNone(ancien.carte)
AssertionError: {'porteur': "⟬person_name#3⟭", 'numero': '⟬payment_card#3⟭'} is not None

----------------------------------------------------------------------
Ran 3 tests in 0.018s

FAILED (failures=2)
⟬end⟭

⟬template⟭
family: logs
format: access log
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: combined log format, ModSecurity message, matched data, query string
scenario: Apache access and ModSecurity alerts of a patient portal, whose firewall copies the entered birth date, a JWT and a maps API key
⟬text⟭
⟬ip_address#1⟭ - - [⟬date#1⟭ 08:12:01 +0100] "GET /portail/accueil HTTP/1.1" 200 6120 "-" "Mozilla/5.0 (Windows NT 10.0)"
⟬ip_address#1⟭ - - [⟬date#1⟭ 08:12:09 +0100] "GET /portail/centres?key=⟬google_api_key#1⟭&ville=⟬city#1⟭ HTTP/1.1" 200 2204 "⟬url#1⟭" "Mozilla/5.0 (Windows NT 10.0)"
⟬ip_address#1⟭ - - [⟬date#1⟭ 08:12:31 +0100] "POST /portail/identification HTTP/1.1" 403 512 "⟬url#1⟭" "Mozilla/5.0 (Windows NT 10.0)"
[⟬date#1⟭ 08:12:31 +0100] [security2:error] [client ⟬ip_address#1⟭] ModSecurity: Access denied with code 403. Pattern match at ARGS:nom. [id "942100"] [msg "SQL Injection Attack Detected"] [data "Matched Data: nom=⟬person_name#2⟭&dateNaissance=⟬birth_date#2⟭ found within ARGS"] [uri "/portail/identification"]
⟬ip_address#1⟭ - - [⟬date#1⟭ 08:13:02 +0100] "POST /portail/identification HTTP/1.1" 200 412 "⟬url#1⟭" "Mozilla/5.0 (Windows NT 10.0)"
⟬ip_address#1⟭ - - [⟬date#1⟭ 08:13:03 +0100] "GET /portail/dossier?token=⟬jwt#2⟭ HTTP/1.1" 200 18422 "⟬url#1⟭" "Mozilla/5.0 (Windows NT 10.0)"
⟬ip_address#1⟭ - - [⟬date#1⟭ 08:13:40 +0100] "GET /portail/documents/⟬uuid#1⟭ HTTP/1.1" 200 412044 "⟬url#1⟭" "Mozilla/5.0 (Windows NT 10.0)"
⟬ip_address#2⟭ - - [⟬date#1⟭ 08:14:10 +0100] "GET /portail/accueil HTTP/1.1" 200 6120 "-" "Mozilla/5.0 (iPhone)"
⟬ip_address#2⟭ - - [⟬date#1⟭ 08:14:40 +0100] "POST /portail/identification HTTP/1.1" 403 512 "⟬url#1⟭" "Mozilla/5.0 (iPhone)"
[⟬date#1⟭ 08:14:40 +0100] [security2:error] [client ⟬ip_address#2⟭] ModSecurity: Access denied with code 403. Pattern match at ARGS:nom. [id "942100"] [msg "SQL Injection Attack Detected"] [data "Matched Data: nom=⟬person_name#3⟭&dateNaissance=⟬birth_date#3⟭ found within ARGS"] [uri "/portail/identification"]
⟬ip_address#3⟭ - - [⟬date#1⟭ 08:15:02 +0100] "GET /portail/rdv?medecin=⟬person_name:handle#4⟭ HTTP/1.1" 200 3320 "-" "Mozilla/5.0 (Android 14)"
⟬ip_address#3⟭ - - [⟬date#1⟭ 08:15:30 +0100] "GET /portail/rdv?⟬trap:indicator_non_pii|medecin=indifferent⟭ HTTP/1.1" 200 3120 "-" "Mozilla/5.0 (Android 14)"
[⟬date#1⟭ 08:16:04 +0100] [security2:warn] [client ⟬ip_address#4⟭] ModSecurity: Warning. Pattern match at REQUEST_HEADERS:User-Agent. [id "913100"] [msg "Found User-Agent associated with security scanner"] [uri "/"]
⟬ip_address#4⟭ - - [⟬date#1⟭ 08:16:04 +0100] "GET / HTTP/1.1" 200 6120 "-" "sqlmap/1.7.11"
⟬ip_address#5⟭ - - [⟬date#1⟭ 08:16:30 +0100] "GET /server-status HTTP/1.1" 403 199 "-" "curl/8.4.0"
⟬ip_address#6⟭ - - [⟬date#1⟭ 08:17:00 +0100] "GET /sonde HTTP/1.1" 200 2 "-" "Centreon/22.10"
⟬end⟭

⟬template⟭
family: logs
format: access log
language: fr
fill_locale: fr_FR
domain: public administration
appearance: S3 access log, dataset names, query string
scenario: object storage access log of an open data portal, whose datasets talk about given names and street names without containing any person
⟬text⟭
⟬hash#1⟭ opendata-fichiers [⟬date#1⟭ 09:00:12 +0000] ⟬ip_address#1⟭ - ⟬uuid#1⟭ REST.GET.OBJECT jeux/⟬trap:indicator_non_pii|liste-des-prenoms⟭-2023.csv "GET /jeux/⟬trap:indicator_non_pii|liste-des-prenoms⟭-2023.csv HTTP/1.1" 200 - 2204112 2204112 41 12
⟬hash#1⟭ opendata-fichiers [⟬date#1⟭ 09:00:44 +0000] ⟬ip_address#2⟭ - ⟬uuid#2⟭ REST.GET.OBJECT jeux/base-adresses-nationale.csv.gz "GET /jeux/base-adresses-nationale.csv.gz HTTP/1.1" 200 - 88120412 88120412 2120 18
⟬hash#1⟭ opendata-fichiers [⟬date#1⟭ 09:01:03 +0000] ⟬ip_address#3⟭ - ⟬uuid#3⟭ REST.HEAD.OBJECT jeux/prix-carburants.json "HEAD /jeux/prix-carburants.json HTTP/1.1" 200 - - 412204 9 -
⟬hash#1⟭ opendata-fichiers [⟬date#1⟭ 09:01:40 +0000] ⟬ip_address#3⟭ - ⟬uuid#4⟭ REST.GET.OBJECT jeux/prix-carburants.json "GET /jeux/prix-carburants.json HTTP/1.1" 200 - 412204 412204 88 11
⟬hash#1⟭ opendata-fichiers [⟬date#1⟭ 09:02:15 +0000] ⟬ip_address#4⟭ - ⟬uuid#5⟭ REST.GET.BUCKET - "GET /?prefix=jeux/&max-keys=100 HTTP/1.1" 200 - 18422 - 44 -
⟬hash#1⟭ opendata-fichiers [⟬date#1⟭ 09:02:52 +0000] ⟬ip_address#5⟭ - ⟬uuid#6⟭ REST.GET.OBJECT jeux/⟬trap:word_name|rue-victor-hugo⟭.geojson "GET /jeux/⟬trap:word_name|rue-victor-hugo⟭.geojson HTTP/1.1" 200 - 512204 512204 62 15
⟬hash#1⟭ opendata-fichiers [⟬date#1⟭ 09:03:11 +0000] ⟬ip_address#6⟭ - ⟬uuid#7⟭ REST.GET.OBJECT jeux/deliberations.zip "GET /jeux/deliberations.zip?⟬trap:indicator_non_pii|auteur=conseil-municipal⟭ HTTP/1.1" 200 - 4120044 4120044 201 19
⟬hash#1⟭ opendata-fichiers [⟬date#1⟭ 09:03:58 +0000] ⟬ip_address#7⟭ - ⟬uuid#8⟭ REST.GET.OBJECT jeux/annuaire-mairies.csv "GET /jeux/annuaire-mairies.csv?⟬trap:indicator_non_pii|nom=*⟭&⟬trap:indicator_non_pii|contact=non⟭ HTTP/1.1" 200 - 88412 88412 21 9
⟬hash#1⟭ opendata-fichiers [⟬date#1⟭ 09:04:22 +0000] ⟬ip_address#8⟭ - ⟬uuid#9⟭ REST.GET.OBJECT jeux/inconnu.csv "GET /jeux/inconnu.csv HTTP/1.1" 404 NoSuchKey 312 - 6 -
⟬hash#1⟭ opendata-fichiers [⟬date#1⟭ 09:05:09 +0000] ⟬ip_address#9⟭ - ⟬uuid#10⟭ REST.PUT.OBJECT jeux/qualite-air.json "PUT /jeux/qualite-air.json HTTP/1.1" 200 - - 88120 141 22
⟬hash#1⟭ opendata-fichiers [⟬date#1⟭ 09:05:50 +0000] ⟬ip_address#1⟭ - ⟬uuid#11⟭ REST.GET.OBJECT jeux/⟬trap:indicator_non_pii|liste-des-prenoms⟭-2022.csv "GET /jeux/⟬trap:indicator_non_pii|liste-des-prenoms⟭-2022.csv HTTP/1.1" 304 - - 2198044 7 -
⟬hash#1⟭ opendata-fichiers [⟬date#1⟭ 09:06:31 +0000] ⟬ip_address#10⟭ - ⟬uuid#12⟭ REST.GET.OBJECT jeux/marches-publics.xml "GET /jeux/marches-publics.xml HTTP/1.1" 206 - 1048576 8120412 39 14
⟬hash#1⟭ opendata-fichiers [⟬date#1⟭ 09:07:02 +0000] ⟬ip_address#11⟭ - ⟬uuid#13⟭ REST.GET.OBJECT jeux/horaires-piscines.csv "GET /jeux/horaires-piscines.csv HTTP/1.1" 200 - 12044 12044 8 6
⟬hash#1⟭ opendata-fichiers [⟬date#1⟭ 09:07:40 +0000] ⟬ip_address#12⟭ - ⟬uuid#14⟭ REST.GET.OBJECT jeux/menus-cantines.csv "GET /jeux/menus-cantines.csv HTTP/1.1" 200 - 22044 22044 10 7
⟬hash#1⟭ opendata-fichiers [⟬date#1⟭ 09:08:18 +0000] ⟬ip_address#13⟭ - ⟬uuid#15⟭ REST.GET.OBJECT jeux/subventions.csv "GET /jeux/subventions.csv?⟬trap:indicator_non_pii|beneficiaire=associations⟭ HTTP/1.1" 200 - 88412 88412 14 8
⟬hash#1⟭ opendata-fichiers [⟬date#1⟭ 09:08:59 +0000] ⟬ip_address#14⟭ - ⟬uuid#16⟭ REST.GET.BUCKET - "GET /?location HTTP/1.1" 200 - 128 - 4 -
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: npm publish output, npmrc, git remote with token, test fixture
scenario: publishing job of a merchant site's payment package, showing the npm token, the GitHub token in the repository URL, a password and a test card
⟬text⟭
$ cat .npmrc
//registry.npmjs.org/:_authToken=⟬npm_token#1⟭
$ git remote -v
origin	https://x-access-token:⟬github_token#1⟭@github.com/boutique-exemple/paiement-sdk.git (fetch)
origin	https://x-access-token:⟬github_token#1⟭@github.com/boutique-exemple/paiement-sdk.git (push)
$ npm test

> @boutique/paiement-sdk@⟬version#1⟭ test
> jest --ci

PASS src/carte.test.ts
PASS src/webhook.test.ts
console.log src/recette.ts:12
  compte recette: "⟬person_name#2⟭" / ⟬password#2⟭
console.log src/recette.ts:13
  carte recette: ⟬payment_card#2⟭ cvc ⟬card_security_code#2⟭
console.log src/recette.ts:14
  secret webhook: ⟬opaque_token#1⟭

Test Suites: 2 passed, 2 total
Tests:       31 passed, 31 total
$ npm publish --access restricted
npm notice package: @boutique/paiement-sdk@⟬version#1⟭
npm notice total files: 42
+ @boutique/paiement-sdk@⟬version#1⟭
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: fr
fill_locale: fr_FR
domain: telecom
appearance: kubectl output, YAML value, shell trace, base64 value
scenario: Kubernetes deployment job of an operator's identity check, whose debug shows a Secret, a password and a smoke test passport
⟬text⟭
$ helm upgrade kyc charts/kyc -n kyc --atomic
Release "kyc" has been upgraded. Happy Helming!
$ kubectl -n kyc rollout status deploy/kyc-api
deployment "kyc-api" successfully rolled out
$ kubectl -n kyc get secret kyc-api -o yaml
apiVersion: v1
data:
  ocr-cle: ⟬opaque_token#1⟭
  db-mdp: ⟬opaque_token#2⟭
kind: Secret
metadata:
  name: kyc-api
  namespace: kyc
type: Opaque
$ kubectl -n kyc exec deploy/kyc-api -- env | grep -i pass
DB_PASSWORD=⟬password#1⟭
⟬trap:indicator_non_pii|PASSWORD_MAX_AGE_DAYS=90⟭
$ ./ci/test_fumee.sh
+ curl -s -X POST ⟬url#1⟭ -d '{"passeport":"⟬fr_passport#2⟭","nom":"⟬person_name#2⟭"}'
{"statut":"VERIFIE","score":0.97,"ref":"⟬uuid#1⟭"}
test de fumee ok
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: fr
fill_locale: fr_FR
domain: insurance
appearance: free-text audit line, before and after values, quoted value
scenario: decision log of an insurance anti-fraud unit, with analysts, suspect drivers, plates, licences and compared bank details
⟬text⟭
[⟬date#1⟭ 14:01] analyste "⟬person_name#1⟭" ouvre l'enquête ⟬ticket_id#1⟭
[⟬date#1⟭ 14:03] signal automatique: même RIB ⟬iban#2⟭ sur deux assurés
[⟬date#1⟭ 14:05] analyste "⟬person_name#1⟭" compare "⟬person_name#2⟭" et "⟬person_name#3⟭"
[⟬date#1⟭ 14:09] véhicule 1: ⟬fr_license_plate#2⟭, permis ⟬fr_driving_licence#2⟭
[⟬date#1⟭ 14:09] véhicule 2: ⟬fr_license_plate#3⟭, permis ⟬fr_driving_licence#3⟭
[⟬date#1⟭ 14:12] garage déclaré: ⟬company#4⟭, SIRET ⟬fr_siret#4⟭, commun aux deux dossiers
[⟬date#1⟭ 14:20] appel de l'expert ⟬person_name#5⟭, ⟬phone#5⟭
[⟬date#1⟭ 14:31] note: "photos identiques, seul le fond change"
[⟬date#1⟭ 14:35] ⟬trap:indicator_non_pii|auteur=regle-doublon-rib⟭ passe le dossier en priorité haute
[⟬date#1⟭ 14:40] analyste "⟬person_name#1⟭" suspend le règlement ⟬uuid#1⟭
[⟬date#1⟭ 14:41] ⟬trap:indicator_non_pii|auteur=workflow⟭ informe la gestion, statut=SUSPENDU
[⟬date#1⟭ 15:02] responsable "⟬person_name#6⟭" valide la suspension
[⟬date#1⟭ 15:10] courrier préparé pour "⟬person_name#2⟭", "⟬fr_postal_address#2⟭"
[⟬date#1⟭ 15:30] pièces déposées dans ⟬file_path#1⟭
[⟬date#1⟭ 15:31] empreinte du dossier ⟬hash#1⟭
[⟬date#1⟭ 15:32] clôture provisoire par "⟬person_name#1⟭"
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: IHE ATNA XML message, attribute value, Windows security event
scenario: XML audit messages of a medical image server and related Windows events, with radiologists, patient, NIR and birth date as attributes
⟬text⟭
<AuditMessage><EventIdentification EventActionCode="R" EventDateTime="⟬date#1⟭ 09:10:02" EventOutcomeIndicator="0"/><ActiveParticipant UserID="⟬person_name:handle#1⟭" UserName="⟬person_name#1⟭" UserIsRequestor="true"/><ParticipantObjectIdentification ParticipantObjectID="⟬fr_social_security_number#2⟭" ParticipantObjectName="⟬person_name#2⟭" ParticipantObjectTypeCode="1"/></AuditMessage>
<AuditMessage><EventIdentification EventActionCode="R" EventDateTime="⟬date#1⟭ 09:10:40" EventOutcomeIndicator="0"/><ActiveParticipant UserID="⟬person_name:handle#1⟭" UserName="⟬person_name#1⟭" UserIsRequestor="true"/><ParticipantObjectIdentification ParticipantObjectID="⟬uuid#1⟭" ParticipantObjectTypeCode="2"><ParticipantObjectDetail type="PatientBirthDate" value="⟬birth_date#2⟭"/></ParticipantObjectIdentification></AuditMessage>
<AuditMessage><EventIdentification EventActionCode="C" EventDateTime="⟬date#1⟭ 09:22:11" EventOutcomeIndicator="0"/><ActiveParticipant UserID="⟬trap:indicator_non_pii|modalite-irm-2⟭" UserIsRequestor="true"/><ParticipantObjectIdentification ParticipantObjectID="⟬uuid#2⟭" ParticipantObjectTypeCode="2"/></AuditMessage>
<AuditMessage><EventIdentification EventActionCode="E" EventDateTime="⟬date#1⟭ 09:30:05" EventOutcomeIndicator="4"/><ActiveParticipant UserID="⟬person_name:handle#3⟭" UserName="⟬person_name#3⟭" UserIsRequestor="true"/><ParticipantObjectIdentification ParticipantObjectID="⟬fr_social_security_number#4⟭" ParticipantObjectName="⟬person_name#4⟭" ParticipantObjectTypeCode="1"/></AuditMessage>
Security 4624 ⟬date#1⟭ 09:31:12 Connexion réussie Compte: ⟬trap:indicator_non_pii|SVC_PACS⟭ Source: ⟬ip_address#1⟭ Type: 3
Security 4624 ⟬date#1⟭ 09:32:40 Connexion réussie Compte: ⟬person_name:handle#3⟭ Source: ⟬ip_address#2⟭ Type: 10
Security 4663 ⟬date#1⟭ 09:33:02 Accès objet Compte: ⟬person_name:handle#3⟭ Objet: D:\PACS\exports\⟬uuid#2⟭.dcm Accès: ReadData
Security 4625 ⟬date#1⟭ 09:40:18 Échec de connexion Compte: ⟬trap:indicator_non_pii|Administrateur⟭ Source: ⟬ip_address#3⟭ Motif: mot de passe incorrect
Security 4634 ⟬date#1⟭ 09:50:44 Fermeture de session Compte: ⟬person_name:handle#3⟭
<AuditMessage><EventIdentification EventActionCode="R" EventDateTime="⟬date#1⟭ 10:05:30" EventOutcomeIndicator="0"/><ActiveParticipant UserID="⟬person_name:handle#5⟭" UserName="⟬person_name#5⟭" UserIsRequestor="true"/><ParticipantObjectIdentification ParticipantObjectID="⟬fr_social_security_number#6⟭" ParticipantObjectName="⟬person_name#6⟭" ParticipantObjectTypeCode="1"><ParticipantObjectDetail type="PatientBirthDate" value="⟬birth_date#6⟭"/></ParticipantObjectIdentification></AuditMessage>
<AuditMessage><EventIdentification EventActionCode="R" EventDateTime="⟬date#1⟭ 10:06:12" EventOutcomeIndicator="0"/><ActiveParticipant UserID="⟬trap:indicator_non_pii|passerelle-teleradio⟭" UserIsRequestor="true"/><ParticipantObjectIdentification ParticipantObjectID="⟬uuid#3⟭" ParticipantObjectTypeCode="2"/></AuditMessage>
Security 4624 ⟬date#1⟭ 10:07:02 Connexion réussie Compte: ⟬trap:indicator_non_pii|SVC_TELERADIO⟭ Source: ⟬ip_address#4⟭ Type: 3
Security 4663 ⟬date#1⟭ 10:07:03 Accès objet Compte: ⟬trap:indicator_non_pii|SVC_TELERADIO⟭ Objet: D:\PACS\exports\⟬uuid#3⟭.dcm Accès: ReadData
Security 1102 ⟬date#1⟭ 11:00:00 Journal d'audit effacé Compte: ⟬person_name:handle#7⟭
Security 4634 ⟬date#1⟭ 11:02:44 Fermeture de session Compte: ⟬trap:indicator_non_pii|SVC_PACS⟭
Security 4624 ⟬date#1⟭ 11:30:18 Connexion réussie Compte: ⟬trap:indicator_non_pii|SVC_PACS⟭ Source: ⟬ip_address#1⟭ Type: 3
⟬end⟭

⟬template⟭
family: logs
format: application log
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: laboratory message, pipe-separated record, log field, quoted value
scenario: medical laboratory software log, copying analyser frames and reports sent to doctors, with patients, NIR and birth dates
⟬text⟭
LIS 07:00:01 INFO  démarrage de la tournée, automate=COBAS-1
LIS 07:00:02 INFO  connexion automate ⟬hostname#1⟭ ouverte
LIS 07:00:03 DEBUG worklist chargée: 5 dossiers
LIS 07:02:11 DEBUG RX H|\^&|||COBAS-1^⟬version#1⟭|||||||P|1
LIS 07:02:11 DEBUG RX P|1||⟬customer_id#2⟭||⟬person_name:family#2⟭^⟬person_name:given#2⟭||⟬birth_date#2⟭|F
LIS 07:02:11 DEBUG RX O|1|⟬order_number#2⟭||^^^GLU\^^^CREA|R
LIS 07:02:12 DEBUG RX R|1|^^^GLU|1.32|g/L|0.74-1.06|H
LIS 07:02:12 DEBUG RX R|2|^^^CREA|8.1|mg/L|5.7-11.3|N
LIS 07:02:12 DEBUG RX L|1|N
LIS 07:02:13 WARN  glycémie hors limites pour "⟬person_name#2f⟭", validation biologique requise
LIS 07:02:13 INFO  dossier ⟬order_number#2⟭ placé en attente de validation
LIS 07:04:40 DEBUG RX P|1||⟬customer_id#3⟭||⟬person_name:family#3m⟭^⟬person_name:given#3m⟭||⟬birth_date#3⟭|M
LIS 07:04:40 DEBUG RX O|1|⟬order_number#3⟭||^^^TSH|R
LIS 07:04:41 DEBUG RX R|1|^^^TSH|2.14|mUI/L|0.27-4.20|N
LIS 07:04:41 DEBUG RX L|1|N
LIS 07:04:42 INFO  dossier ⟬order_number#3⟭ validé automatiquement
LIS 07:04:43 INFO  résultat publié sur le serveur ⟬hostname#2⟭
LIS 07:06:02 DEBUG RX P|1||⟬customer_id#4⟭||⟬person_name:family#4f⟭^⟬person_name:given#4f⟭||⟬birth_date#4⟭|F
LIS 07:06:02 DEBUG RX O|1|⟬order_number#4⟭||^^^HCG|S
LIS 07:06:03 DEBUG RX R|1|^^^HCG|1204|UI/L|0-5|H
LIS 07:06:03 DEBUG RX L|1|N
LIS 07:06:04 WARN  valeur critique, appel obligatoire du prescripteur Dr ⟬person_name#5⟭ au ⟬phone#5⟭
LIS 07:06:50 INFO  appel tracé par ⟬trap:indicator_non_pii|technicien=poste-2⟭
LIS 07:08:12 ERROR identité incohérente: nir=⟬fr_social_security_number#6⟭ nom="⟬person_name#6⟭" naissance=⟬birth_date#6⟭
LIS 07:08:12 ERROR dossier ⟬order_number#6⟭ bloqué, demande de vérification au secrétariat
LIS 07:08:13 INFO  ticket ⟬ticket_id#1⟭ créé
LIS 07:10:30 DEBUG RX P|1||⟬customer_id#7⟭||⟬person_name:family#7m⟭^⟬person_name:given#7m⟭||⟬birth_date#7⟭|M
LIS 07:10:30 DEBUG RX O|1|⟬order_number#7⟭||^^^INR|R
LIS 07:10:31 DEBUG RX R|1|^^^INR|3.4||2.0-3.0|H
LIS 07:10:31 DEBUG RX L|1|N
LIS 07:10:32 WARN  INR élevé, prescripteur Dr ⟬person_name#8⟭ prévenu par messagerie sécurisée ⟬email#8⟭
LIS 07:12:00 INFO  tournée terminée: 5 dossiers, 3 validés, 1 critique, 1 bloqué
LIS 07:12:01 INFO  connexion automate fermée
LIS 07:30:00 INFO  validation biologique ouverte par "⟬person_name#9⟭"
LIS 07:31:12 INFO  dossier ⟬order_number#2⟭ validé par "⟬person_name#9⟭"
LIS 07:31:13 DEBUG compte rendu ⟬uuid#1⟭ généré pour nir=⟬fr_social_security_number#2⟭
LIS 07:31:14 INFO  envoi au médecin traitant Dr ⟬person_name#10⟭
LIS 07:31:15 DEBUG messagerie sécurisée: expéditeur ⟬email:generic#11⟭
LIS 07:31:16 INFO  dossier ⟬order_number#4⟭ validé par "⟬person_name#9⟭"
LIS 07:31:17 DEBUG compte rendu ⟬uuid#2⟭ généré pour nir=⟬fr_social_security_number#4⟭
LIS 07:31:18 INFO  mise à disposition sur le portail patient ⟬url#1⟭
LIS 07:45:00 INFO  secrétariat: identité du dossier ⟬order_number#6⟭ corrigée
LIS 07:45:01 DEBUG nouvelle adresse "⟬fr_postal_address#6⟭"
LIS 07:45:02 INFO  dossier ⟬order_number#6⟭ débloqué par ⟬trap:indicator_non_pii|operateur=secretariat⟭
LIS 08:00:00 INFO  bilan horaire: 12 dossiers reçus, 9 validés
LIS 08:00:01 DEBUG export des indicateurs dans ⟬file_path#1⟭
LIS 08:15:00 INFO  contrôle qualité interne COBAS-1: conforme, règle de ⟬trap:eponym|Westgard⟭ 1-3s
LIS 08:15:01 INFO  contrôle qualité interne COBAS-2: conforme, règle de ⟬trap:eponym|Westgard⟭ 2-2s
LIS 08:30:00 INFO  température enceinte 4,1 °C
LIS 08:45:00 INFO  température enceinte 4,0 °C
LIS 09:00:00 INFO  bilan horaire: 18 dossiers reçus, 16 validés
LIS 09:00:01 DEBUG export des indicateurs dans ⟬file_path#1⟭
LIS 09:15:00 INFO  température enceinte 4,2 °C
LIS 09:30:00 INFO  température enceinte 4,1 °C
LIS 09:45:00 INFO  température enceinte 4,0 °C
LIS 10:00:00 INFO  bilan horaire: 21 dossiers reçus, 20 validés
LIS 10:00:01 DEBUG export des indicateurs dans ⟬file_path#1⟭
LIS 10:15:00 INFO  réapprovisionnement réactif GLU commandé, ⟬trap:indicator_non_pii|contact=magasin⟭
LIS 10:30:00 INFO  température enceinte 4,1 °C
LIS 10:45:00 INFO  température enceinte 4,0 °C
LIS 11:00:00 INFO  bilan horaire: 15 dossiers reçus, 15 validés
LIS 11:00:01 DEBUG export des indicateurs dans ⟬file_path#1⟭
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: JVM thread dump, thread names, lock monitor
scenario: JVM thread dump of a merchant site during the sales, showing a deadlock in the payment pool, with no customer data
⟬text⟭
Full thread dump OpenJDK 64-Bit Server VM (21.0.1+12 mixed mode, sharing):

"http-nio-8080-exec-1" #31 daemon prio=5 os_prio=0 cpu=812.44ms elapsed=4120.33s waiting for monitor entry
   java.lang.Thread.State: BLOCKED (on object monitor)
	at fr.boutique.panier.PanierService.recalculer(PanierService.java:141)
	- waiting to lock <0x000000076ab62208> (a fr.boutique.panier.Verrou)
	at fr.boutique.panier.PanierController.maj(PanierController.java:58)
	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)
	at org.apache.tomcat.util.threads.TaskThread$WrappingRunnable.run(TaskThread.java:61)
	at java.lang.Thread.run(java.base@21.0.1/Thread.java:1583)

"http-nio-8080-exec-2" #32 daemon prio=5 os_prio=0 cpu=790.12ms elapsed=4120.33s waiting for monitor entry
   java.lang.Thread.State: BLOCKED (on object monitor)
	at fr.boutique.panier.PanierService.recalculer(PanierService.java:141)
	- waiting to lock <0x000000076ab62208> (a fr.boutique.panier.Verrou)
	at fr.boutique.panier.PanierController.maj(PanierController.java:58)
	at java.lang.Thread.run(java.base@21.0.1/Thread.java:1583)

"http-nio-8080-exec-3" #33 daemon prio=5 os_prio=0 cpu=1204.71ms elapsed=4120.32s waiting for monitor entry
   java.lang.Thread.State: BLOCKED (on object monitor)
	at fr.boutique.paiement.Tarification.⟬trap:code_identifier|remise⦃Family⦄⟭(Tarification.java:88)
	- waiting to lock <0x000000076ab7a4d0> (a fr.boutique.paiement.Caisse)
	- locked <0x000000076ab62208> (a fr.boutique.panier.Verrou)
	at fr.boutique.panier.PanierService.recalculer(PanierService.java:150)
	at fr.boutique.panier.PanierController.maj(PanierController.java:58)
	at java.lang.Thread.run(java.base@21.0.1/Thread.java:1583)

"paiement-worker-4" #58 prio=5 os_prio=0 cpu=4411.02ms elapsed=4098.10s waiting for monitor entry
   java.lang.Thread.State: BLOCKED (on object monitor)
	at fr.boutique.panier.PanierService.verrouiller(PanierService.java:203)
	- waiting to lock <0x000000076ab62208> (a fr.boutique.panier.Verrou)
	- locked <0x000000076ab7a4d0> (a fr.boutique.paiement.Caisse)
	at fr.boutique.paiement.CaisseService.encaisser(CaisseService.java:77)
	at java.util.concurrent.ThreadPoolExecutor.runWorker(java.base@21.0.1/ThreadPoolExecutor.java:1144)
	at java.lang.Thread.run(java.base@21.0.1/Thread.java:1583)

"⟬trap:library|kafka⟭-producer-network-thread | commandes" #71 daemon prio=5 os_prio=0 cpu=88.20ms elapsed=4080.01s runnable
   java.lang.Thread.State: RUNNABLE
	at sun.nio.ch.EPoll.wait(java.base@21.0.1/Native Method)
	at org.apache.kafka.common.network.Selector.select(Selector.java:874)
	at org.apache.kafka.clients.producer.internals.Sender.run(Sender.java:243)

"⟬trap:indicator_non_pii|token-refresh-scheduler⟭" #72 daemon prio=5 os_prio=0 cpu=2.41ms elapsed=4080.00s waiting on condition
   java.lang.Thread.State: TIMED_WAITING (parking)
	at jdk.internal.misc.Unsafe.park(java.base@21.0.1/Native Method)
	at java.util.concurrent.ScheduledThreadPoolExecutor$DelayedWorkQueue.take(java.base@21.0.1/ScheduledThreadPoolExecutor.java:1177)

"⟬trap:indicator_non_pii|client-session-cleaner⟭" #73 daemon prio=5 os_prio=0 cpu=1.08ms elapsed=4079.98s waiting on condition
   java.lang.Thread.State: TIMED_WAITING (sleeping)
	at java.lang.Thread.sleep0(java.base@21.0.1/Native Method)
	at fr.boutique.session.Nettoyeur.run(Nettoyeur.java:30)

"GC Thread#0" os_prio=0 cpu=4120.18ms elapsed=4122.40s runnable
"G1 Main Marker" os_prio=0 cpu=12.44ms elapsed=4122.40s runnable
"VM Periodic Task Thread" os_prio=0 cpu=884.04ms elapsed=4122.30s waiting on condition

Found one Java-level deadlock:
=============================
"http-nio-8080-exec-3":
  waiting to lock monitor 0x00007f8a1c0c2ed8 (object 0x000000076ab7a4d0, a fr.boutique.paiement.Caisse),
  which is held by "paiement-worker-4"
"paiement-worker-4":
  waiting to lock monitor 0x00007f8a1c0c30c8 (object 0x000000076ab62208, a fr.boutique.panier.Verrou),
  which is held by "http-nio-8080-exec-3"

Java stack information for the threads listed above:
===================================================
"http-nio-8080-exec-3":
	at fr.boutique.paiement.Tarification.⟬trap:code_identifier|remise⦃Family⦄⟭(Tarification.java:88)
"paiement-worker-4":
	at fr.boutique.panier.PanierService.verrouiller(PanierService.java:203)

Found 1 deadlock.
⟬end⟭

⟬template⟭
family: logs
format: test output
language: fr
fill_locale: fr_FR
domain: telecom
appearance: pytest verbose output, parametrized test ids, captured log, secret in a fixture
scenario: verbose pytest output for an operator's SIM swap, whose parametrized ids and captured logs show tokens, a password and test subscribers' cards
⟬text⟭
============================= test session starts =============================
platform linux -- Python 3.12.1, pytest-8.0.0, pluggy-1.4.0 -- /builds/sim/.venv/bin/python
cachedir: .pytest_cache
rootdir: /builds/sim
plugins: asyncio-0.23.3, cov-4.1.0, mock-3.12.0
collecting ... collected 44 items

tests/test_swap.py::test_swap_nominal[esim] PASSED                       [  2%]
tests/test_swap.py::test_swap_nominal[physique] PASSED                   [  4%]
tests/test_swap.py::test_swap_nominal[double-sim] PASSED                 [  6%]
tests/test_swap.py::test_swap_refuse_sans_otp[sms] PASSED                [  9%]
tests/test_swap.py::test_swap_refuse_sans_otp[mail] PASSED               [ 11%]
tests/test_swap.py::test_swap_delai_72h PASSED                           [ 13%]
tests/test_swap.py::test_swap_agent_boutique[⟬person_name:handle#1⟭] PASSED [ 15%]
tests/test_swap.py::test_swap_agent_boutique[⟬trap:indicator_non_pii|agent-demo⟭] PASSED [ 18%]
tests/test_swap.py::test_swap_notifie_ancien_numero PASSED               [ 20%]
tests/test_swap.py::test_swap_bloque_fraude FAILED                       [ 22%]
tests/test_portabilite.py::test_rio_valide PASSED                        [ 25%]
tests/test_portabilite.py::test_rio_invalide PASSED                      [ 27%]
tests/test_portabilite.py::test_date_portage PASSED                      [ 29%]
tests/test_paiement.py::test_frais_sim_carte PASSED                      [ 31%]
tests/test_paiement.py::test_frais_sim_refus FAILED                      [ 34%]
tests/test_paiement.py::test_frais_offerts PASSED                        [ 36%]
tests/test_jetons.py::test_jeton_expire PASSED                           [ 38%]
tests/test_jetons.py::test_jeton_revoque PASSED                          [ 40%]
tests/test_jetons.py::test_jeton_rotation PASSED                         [ 43%]

================================== FAILURES ===================================
___________________________ test_swap_bloque_fraude ___________________________

client_api = <ClientApi url=⟬url#1⟭>
abonne = Abonne(ligne='⟬phone#2⟭', nom="⟬person_name#2⟭", mot_de_passe='⟬password#2⟭')

    def test_swap_bloque_fraude(client_api, abonne):
        reponse = client_api.demander_swap(abonne, motif="perte")
>       assert reponse.status_code == 423
E       assert 202 == 423
E        +  where 202 = <Response [202]>.status_code

tests/test_swap.py:118: AssertionError
---------------------------- Captured log call --------------------------------
INFO     sim.api:api.py:44 POST /swap Authorization: Bearer ⟬jwt#2⟭
DEBUG    sim.api:api.py:51 reponse 202 {"ref":"⟬uuid#1⟭","sig":"⟬opaque_token#1⟭"}
WARNING  sim.fraude:regles.py:88 score 41 sous le seuil pour ⟬phone#2⟭
___________________________ test_frais_sim_refus ______________________________

paiement = {'carte': '⟬payment_card#3⟭', 'cvc': '⟬card_security_code#3⟭', 'porteur': "⟬person_name#3⟭", 'montant': 10.0}

    def test_frais_sim_refus(paiement):
        resultat = encaisser(**paiement)
>       assert resultat.statut == "REFUSE"
E       AssertionError: assert 'ACCEPTE' == 'REFUSE'
E         - REFUSE
E         + ACCEPTE

tests/test_paiement.py:61: AssertionError
---------------------------- Captured log call --------------------------------
DEBUG    sim.psp:psp.py:30 X-Client-Ref: ⟬opaque_token#2⟭
INFO     sim.psp:psp.py:37 transaction ⟬uuid#2⟭ acceptee
=========================== short test summary info ===========================
FAILED tests/test_swap.py::test_swap_bloque_fraude - assert 202 == 423
FAILED tests/test_paiement.py::test_frais_sim_refus - AssertionError: assert 'ACCEPTE' == 'REFUSE'
======================= 2 failed, 17 passed, 25 deselected in 3.14s ===========
⟬end⟭

⟬template⟭
family: logs
format: access log
language: fr
fill_locale: fr_FR
domain: insurance
appearance: combined log format, context field, company identifier
scenario: Apache access of a fleet management extranet, whose format adds an application context with plate, licence and SIRET, and a broker JWT
⟬text⟭
⟬ip_address#1⟭ - ⟬person_name:handle#1⟭ [⟬date#1⟭ 08:30:02 +0200] "POST /extranet/connexion HTTP/1.1" 302 - ctx="-"
⟬ip_address#1⟭ - ⟬person_name:handle#1⟭ [⟬date#1⟭ 08:30:03 +0200] "GET /extranet/flottes HTTP/1.1" 200 8120 ctx="siret=⟬fr_siret#2⟭"
⟬ip_address#1⟭ - ⟬person_name:handle#1⟭ [⟬date#1⟭ 08:30:21 +0200] "GET /extranet/flottes/vehicules HTTP/1.1" 200 22044 ctx="siret=⟬fr_siret#2⟭;page=1"
⟬ip_address#1⟭ - ⟬person_name:handle#1⟭ [⟬date#1⟭ 08:30:48 +0200] "GET /extranet/vehicule HTTP/1.1" 200 4120 ctx="immat=⟬fr_license_plate#3⟭"
⟬ip_address#1⟭ - ⟬person_name:handle#1⟭ [⟬date#1⟭ 08:31:02 +0200] "GET /extranet/conducteur HTTP/1.1" 200 3320 ctx="permis=⟬fr_driving_licence#3⟭"
⟬ip_address#1⟭ - ⟬person_name:handle#1⟭ [⟬date#1⟭ 08:31:40 +0200] "POST /extranet/sinistres HTTP/1.1" 201 96 ctx="immat=⟬fr_license_plate#3⟭;ref=⟬ticket_id#1⟭"
⟬ip_address#2⟭ - - [⟬date#1⟭ 08:32:00 +0200] "GET /sonde HTTP/1.1" 200 2 ctx="-"
⟬ip_address#3⟭ - ⟬person_name:handle#4⟭ [⟬date#1⟭ 08:32:15 +0200] "GET /extranet/api/flottes?jeton=⟬jwt#4⟭ HTTP/1.1" 200 412 ctx="siret=⟬fr_siret#5⟭"
⟬ip_address#3⟭ - ⟬person_name:handle#4⟭ [⟬date#1⟭ 08:32:40 +0200] "GET /extranet/vehicule HTTP/1.1" 200 4120 ctx="immat=⟬fr_license_plate#6⟭"
⟬ip_address#3⟭ - ⟬person_name:handle#4⟭ [⟬date#1⟭ 08:33:05 +0200] "GET /extranet/conducteur HTTP/1.1" 404 512 ctx="permis=⟬fr_driving_licence#6⟭"
⟬ip_address#3⟭ - ⟬person_name:handle#4⟭ [⟬date#1⟭ 08:33:22 +0200] "POST /extranet/conducteur HTTP/1.1" 201 96 ctx="permis=⟬fr_driving_licence#6⟭;nom=⟬person_name#6⟭"
⟬ip_address#4⟭ - ⟬trap:indicator_non_pii|user-batch-flottes⟭ [⟬date#1⟭ 08:34:00 +0200] "POST /extranet/import HTTP/1.1" 202 64 ctx="lot=⟬uuid#1⟭"
⟬ip_address#2⟭ - - [⟬date#1⟭ 08:35:00 +0200] "GET /sonde HTTP/1.1" 200 2 ctx="-"
⟬ip_address#1⟭ - ⟬person_name:handle#1⟭ [⟬date#1⟭ 08:35:12 +0200] "GET /extranet/sinistres HTTP/1.1" 200 6204 ctx="siret=⟬fr_siret#2⟭;statut=ouvert"
⟬ip_address#1⟭ - ⟬person_name:handle#1⟭ [⟬date#1⟭ 08:35:50 +0200] "GET /extranet/sinistres/detail HTTP/1.1" 200 4120 ctx="ref=⟬ticket_id#1⟭"
⟬ip_address#5⟭ - ⟬person_name:handle#7⟭ [⟬date#1⟭ 08:36:18 +0200] "POST /extranet/connexion HTTP/1.1" 401 88 ctx="-"
⟬ip_address#5⟭ - ⟬person_name:handle#7⟭ [⟬date#1⟭ 08:36:30 +0200] "POST /extranet/connexion HTTP/1.1" 302 - ctx="-"
⟬ip_address#5⟭ - ⟬person_name:handle#7⟭ [⟬date#1⟭ 08:36:31 +0200] "GET /extranet/flottes HTTP/1.1" 200 8120 ctx="siret=⟬fr_siret#8⟭"
⟬ip_address#5⟭ - ⟬person_name:handle#7⟭ [⟬date#1⟭ 08:37:02 +0200] "GET /extranet/vehicule HTTP/1.1" 200 4120 ctx="immat=⟬fr_license_plate#9⟭"
⟬ip_address#5⟭ - ⟬person_name:handle#7⟭ [⟬date#1⟭ 08:37:20 +0200] "GET /extranet/conducteur HTTP/1.1" 200 3320 ctx="permis=⟬fr_driving_licence#9⟭"
⟬ip_address#5⟭ - ⟬person_name:handle#7⟭ [⟬date#1⟭ 08:37:44 +0200] "GET /extranet/vehicule HTTP/1.1" 200 4120 ctx="immat=⟬fr_license_plate#10⟭"
⟬ip_address#5⟭ - ⟬person_name:handle#7⟭ [⟬date#1⟭ 08:38:02 +0200] "GET /extranet/conducteur HTTP/1.1" 200 3320 ctx="permis=⟬fr_driving_licence#10⟭"
⟬ip_address#2⟭ - - [⟬date#1⟭ 08:40:00 +0200] "GET /sonde HTTP/1.1" 200 2 ctx="-"
⟬ip_address#6⟭ - ⟬trap:indicator_non_pii|user-export-bi⟭ [⟬date#1⟭ 08:40:30 +0200] "GET /extranet/api/export?format=csv HTTP/1.1" 200 88120 ctx="lot=⟬uuid#2⟭"
⟬ip_address#3⟭ - ⟬person_name:handle#4⟭ [⟬date#1⟭ 08:41:12 +0200] "GET /extranet/api/flottes?jeton=⟬jwt#4⟭ HTTP/1.1" 200 412 ctx="siret=⟬fr_siret#5⟭"
⟬ip_address#3⟭ - ⟬person_name:handle#4⟭ [⟬date#1⟭ 08:41:50 +0200] "GET /extranet/api/devis?jeton=⟬jwt#4⟭ HTTP/1.1" 200 2204 ctx="ref=⟬uuid#3⟭"
⟬ip_address#3⟭ - ⟬person_name:handle#4⟭ [⟬date#1⟭ 08:42:30 +0200] "POST /extranet/api/devis?jeton=⟬jwt#4⟭ HTTP/1.1" 201 96 ctx="ref=⟬uuid#4⟭"
⟬ip_address#2⟭ - - [⟬date#1⟭ 08:45:00 +0200] "GET /sonde HTTP/1.1" 200 2 ctx="-"
⟬ip_address#7⟭ - - [⟬date#1⟭ 08:45:40 +0200] "GET /extranet/mentions-legales HTTP/1.1" 200 3120 ctx="-"
⟬ip_address#7⟭ - - [⟬date#1⟭ 08:45:58 +0200] "GET /extranet/assistance HTTP/1.1" 200 2240 ctx="-"
⟬ip_address#5⟭ - ⟬person_name:handle#7⟭ [⟬date#1⟭ 08:46:20 +0200] "POST /extranet/flottes/conducteurs HTTP/1.1" 201 96 ctx="permis=⟬fr_driving_licence#11⟭;immat=⟬fr_license_plate#11⟭"
⟬ip_address#5⟭ - ⟬person_name:handle#7⟭ [⟬date#1⟭ 08:46:52 +0200] "POST /extranet/deconnexion HTTP/1.1" 302 - ctx="-"
⟬ip_address#1⟭ - ⟬person_name:handle#1⟭ [⟬date#1⟭ 08:48:03 +0200] "GET /extranet/factures HTTP/1.1" 200 4120 ctx="siret=⟬fr_siret#2⟭;facture=⟬invoice_number#2⟭"
⟬ip_address#1⟭ - ⟬person_name:handle#1⟭ [⟬date#1⟭ 08:48:30 +0200] "GET /extranet/factures/telecharger HTTP/1.1" 200 88120 ctx="facture=⟬invoice_number#2⟭"
⟬ip_address#2⟭ - - [⟬date#1⟭ 08:50:00 +0200] "GET /sonde HTTP/1.1" 200 2 ctx="-"
⟬ip_address#1⟭ - ⟬person_name:handle#1⟭ [⟬date#1⟭ 08:51:12 +0200] "POST /extranet/deconnexion HTTP/1.1" 302 - ctx="-"
⟬ip_address#8⟭ - ⟬person_name:handle#12⟭ [⟬date#1⟭ 08:52:40 +0200] "POST /extranet/connexion HTTP/1.1" 302 - ctx="-"
⟬ip_address#8⟭ - ⟬person_name:handle#12⟭ [⟬date#1⟭ 08:52:41 +0200] "GET /extranet/flottes HTTP/1.1" 200 8120 ctx="siret=⟬fr_siret#13⟭"
⟬ip_address#8⟭ - ⟬person_name:handle#12⟭ [⟬date#1⟭ 08:53:10 +0200] "GET /extranet/vehicule HTTP/1.1" 200 4120 ctx="immat=⟬fr_license_plate#14⟭"
⟬ip_address#8⟭ - ⟬person_name:handle#12⟭ [⟬date#1⟭ 08:53:44 +0200] "POST /extranet/vehicule/retirer HTTP/1.1" 200 64 ctx="immat=⟬fr_license_plate#14⟭;motif=vente"
⟬ip_address#2⟭ - - [⟬date#1⟭ 08:55:00 +0200] "GET /sonde HTTP/1.1" 200 2 ctx="-"
⟬ip_address#8⟭ - ⟬person_name:handle#12⟭ [⟬date#1⟭ 08:55:32 +0200] "POST /extranet/vehicule/ajouter HTTP/1.1" 201 96 ctx="immat=⟬fr_license_plate#15⟭;conducteur=⟬trap:indicator_non_pii|non designe⟭"
⟬ip_address#8⟭ - ⟬person_name:handle#12⟭ [⟬date#1⟭ 08:56:10 +0200] "POST /extranet/deconnexion HTTP/1.1" 302 - ctx="-"
⟬ip_address#9⟭ - ⟬trap:indicator_non_pii|user-rapprochement⟭ [⟬date#1⟭ 08:57:00 +0200] "POST /extranet/api/rapprochement HTTP/1.1" 202 64 ctx="lot=⟬uuid#5⟭"
⟬ip_address#9⟭ - ⟬trap:indicator_non_pii|user-rapprochement⟭ [⟬date#1⟭ 08:58:30 +0200] "GET /extranet/api/rapprochement/etat HTTP/1.1" 200 96 ctx="lot=⟬uuid#5⟭"
⟬ip_address#2⟭ - - [⟬date#1⟭ 09:00:00 +0200] "GET /sonde HTTP/1.1" 200 2 ctx="-"
⟬ip_address#2⟭ - - [⟬date#1⟭ 09:05:00 +0200] "GET /sonde HTTP/1.1" 200 2 ctx="-"
⟬ip_address#10⟭ - ⟬person_name:handle#16⟭ [⟬date#1⟭ 09:06:12 +0200] "POST /extranet/connexion HTTP/1.1" 302 - ctx="-"
⟬ip_address#10⟭ - ⟬person_name:handle#16⟭ [⟬date#1⟭ 09:06:13 +0200] "GET /extranet/flottes HTTP/1.1" 200 8120 ctx="siret=⟬fr_siret#17⟭"
⟬ip_address#10⟭ - ⟬person_name:handle#16⟭ [⟬date#1⟭ 09:06:40 +0200] "GET /extranet/vehicule HTTP/1.1" 200 4120 ctx="immat=⟬fr_license_plate#18⟭"
⟬ip_address#10⟭ - ⟬person_name:handle#16⟭ [⟬date#1⟭ 09:07:02 +0200] "GET /extranet/conducteur HTTP/1.1" 200 3320 ctx="permis=⟬fr_driving_licence#18⟭"
⟬ip_address#10⟭ - ⟬person_name:handle#16⟭ [⟬date#1⟭ 09:07:40 +0200] "POST /extranet/sinistres HTTP/1.1" 201 96 ctx="immat=⟬fr_license_plate#18⟭;ref=⟬ticket_id#2⟭"
⟬ip_address#2⟭ - - [⟬date#1⟭ 09:10:00 +0200] "GET /sonde HTTP/1.1" 200 2 ctx="-"
⟬ip_address#10⟭ - ⟬person_name:handle#16⟭ [⟬date#1⟭ 09:11:12 +0200] "POST /extranet/deconnexion HTTP/1.1" 302 - ctx="-"
⟬ip_address#2⟭ - - [⟬date#1⟭ 09:15:00 +0200] "GET /sonde HTTP/1.1" 200 2 ctx="-"
⟬ip_address#2⟭ - - [⟬date#1⟭ 09:20:00 +0200] "GET /sonde HTTP/1.1" 200 2 ctx="-"
⟬ip_address#2⟭ - - [⟬date#1⟭ 09:25:00 +0200] "GET /sonde HTTP/1.1" 200 2 ctx="-"
⟬ip_address#2⟭ - - [⟬date#1⟭ 09:30:00 +0200] "GET /sonde HTTP/1.1" 200 2 ctx="-"
⟬ip_address#2⟭ - - [⟬date#1⟭ 09:35:00 +0200] "GET /sonde HTTP/1.1" 200 2 ctx="-"
⟬ip_address#2⟭ - - [⟬date#1⟭ 09:40:00 +0200] "GET /sonde HTTP/1.1" 200 2 ctx="-"
⟬ip_address#2⟭ - - [⟬date#1⟭ 09:45:00 +0200] "GET /sonde HTTP/1.1" 200 2 ctx="-"
⟬ip_address#2⟭ - - [⟬date#1⟭ 09:50:00 +0200] "GET /sonde HTTP/1.1" 200 2 ctx="-"
⟬end⟭
