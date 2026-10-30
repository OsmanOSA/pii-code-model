⟬template⟭
family: logs
format: application log
language: fr
fill_locale: fr_FR
domain: telecom
appearance: FreeRADIUS log, bare secret, phone number
scenario: FreeRADIUS log of an access provider keeping refused passwords, with subscriber accounts, a technical probe and a partner reference
⟬text⟭
⟬date#1⟭ 19:20:11 radiusd[2210]: (1204) Login OK: [⟬person_name:handle#1⟭] (from client bras-sud-02 port 1812 cli ⟬phone#1⟭)
⟬date#1⟭ 19:20:44 radiusd[2210]: (1205) Login incorrect (pap: Cleartext password does not match): [⟬person_name:handle#2⟭/⟬password#2⟭] (from client bras-sud-02 port 1812)
⟬date#1⟭ 19:20:52 radiusd[2210]: (1206) rest: X-Client-Ref: ⟬opaque_token#1⟭
⟬date#1⟭ 19:21:03 radiusd[2210]: (1207) Login OK: [⟬trap:indicator_non_pii|user=sonde-bras⟭] (from client bras-sud-01 port 1812)
⟬date#1⟭ 19:21:30 radiusd[2210]: (1208) rest: X-Client-Ref: ⟬customer_id#3⟭
⟬date#1⟭ 19:21:58 radiusd[2210]: (1209) Login OK: [⟬person_name:handle#2⟭] (from client bras-sud-02 port 1812 cli ⟬phone#2⟭)
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: Celery task failure, Python traceback, exception message
scenario: Celery payment task of an online shop, whose provider exception copies the card and the payment session token
⟬text⟭
[⟬date#1⟭ 13:07:44,120: ERROR/ForkPoolWorker-3] Task boutique.taches.encaisser[⟬uuid#1⟭] raised unexpected: CarteRefusee("carte ⟬payment_card#2⟭ refusee, session ⟬opaque_token#1⟭")
Traceback (most recent call last):
  File "/app/.venv/lib/python3.11/site-packages/celery/app/trace.py", line 477, in trace_task
    R = retval = fun(*args, **kwargs)
  File "/app/boutique/taches.py", line 54, in encaisser
    return prestataire.debiter(commande, carte)
  File "/app/boutique/prestataire.py", line 120, in debiter
    raise CarteRefusee(f"carte {carte.numero} refusee, session {session}")
boutique.erreurs.CarteRefusee: carte ⟬payment_card#2⟭ refusee, session ⟬opaque_token#1⟭
⟬end⟭

⟬template⟭
family: logs
format: test output
language: fr
fill_locale: fr_FR
domain: banking
appearance: Gradle test output, code identifier
scenario: Gradle output for a loan amortisation calculation's tests, with an eponymous formula and no customer
⟬text⟭
> Task :credit-calcul:test

AmortissementTest > mensualiteConstante() PASSED
AmortissementTest > tableauDeuxCentQuarante() PASSED
AmortissementTest > ⟬trap:code_identifier|arrondi⦃Family⦄()⟭ FAILED
    org.opentest4j.AssertionFailedError: expected: <812.34> but was: <812.35>
TauxEffectifTest > ⟬trap:code_identifier|methodeDeNewton()⟭ PASSED

4 tests completed, 1 failed
> Task :credit-calcul:test FAILED
⟬end⟭

⟬template⟭
family: logs
format: access log
language: fr
fill_locale: fr_FR
domain: public administration
appearance: Squid proxy log, query string
scenario: outbound proxy log of a prefecture, where the call to a verification service keeps the passport and agent token in the URL
⟬text⟭
1712023443.117    231 ⟬ip_address#1⟭ TCP_TUNNEL/200 8124 CONNECT ⟬hostname#1⟭:443 ⟬person_name:handle#2⟭ HIER_DIRECT/⟬ip_address#2⟭ -
1712023451.604    412 ⟬ip_address#1⟭ TCP_MISS/200 1204 GET https://⟬hostname#1⟭/titres/verifier?passeport=⟬fr_passport#3⟭&jeton=⟬jwt#3⟭ ⟬person_name:handle#2⟭ HIER_DIRECT/⟬ip_address#2⟭ application/json
1712023460.018     92 ⟬ip_address#3⟭ TCP_MISS/200 512 GET ⟬url#1⟭ ⟬trap:indicator_non_pii|user-maj-antivirus⟭ HIER_DIRECT/⟬ip_address#4⟭ text/plain
1712023466.902      0 ⟬ip_address#4⟭ TCP_DENIED/403 3920 GET https://⟬hostname#2⟭/ - HIER_NONE/- text/html
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: ESLint output, build output, undefined variable
scenario: Next.js build of a merchant site, with ESLint warnings and an undefined key variable, without any sensitive value
⟬text⟭
$ next lint && next build
./src/lib/prix.ts
12:10  Warning: 'tva' is assigned a value but never used.  no-unused-vars
./src/hooks/⟬trap:code_identifier|useFormat⦃Family⦄Price⟭.ts
3:17  Warning: React Hook useMemo has a missing dependency: 'devise'.  react-hooks/exhaustive-deps
info  - Linting and checking validity of types
warn  - ⟬trap:indicator_non_pii|NEXT_PUBLIC_API_KEY⟭ vaut ⟬trap:placeholder|<non défini>⟭ pendant le build
info  - Creating an optimized production build
info  - Compiled successfully
Route (app)                    Size     First Load JS
/panier                        4.2 kB   112 kB
/produits/[slug]               6.8 kB   118 kB
Done in 94.12s.
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: key=value, quoted value, emergency access
scenario: break-glass traces of a shared medical record: an emergency doctor opens the file of an unconscious patient, identified by NIR
⟬text⟭
BRIS_DE_GLACE ⟬date#1⟭ 03:12:44 acteur="Dr ⟬person_name#1⟭" rpps=⟬customer_id#1⟭ patient=⟬fr_social_security_number#2⟭ motif="coma, aucun proche joignable"
ACCES_DOCUMENT ⟬date#1⟭ 03:13:02 acteur="Dr ⟬person_name#1⟭" document=⟬uuid#1⟭ type=traitements patient=⟬fr_social_security_number#2⟭
ACCES_DOCUMENT ⟬date#1⟭ 03:13:40 acteur="Dr ⟬person_name#1⟭" document=⟬uuid#2⟭ type=allergies patient=⟬fr_social_security_number#2⟭
NOTIFICATION ⟬date#1⟭ 03:14:00 acteur=⟬trap:indicator_non_pii|moteur-notifications⟭ canal=courrier destinataire="⟬person_name#2⟭"
⟬end⟭

⟬template⟭
family: logs
format: application log
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: Go zap console, inline JSON, tab-separated fields
scenario: zap log of a marketplace's seller payout service, with SIREN, IBAN, fee card and transaction references
⟬text⟭
⟬date#1⟭ 04:00:01	INFO	versement/lancer.go:44	demarrage du cycle	{"cycle": "⟬uuid#1⟭", "vendeurs": 3}
⟬date#1⟭ 04:00:01	DEBUG	versement/lecture.go:71	vendeur charge	{"vendeur": "⟬company#2⟭", "siren": "⟬fr_siren#2⟭", "iban": "⟬iban#2⟭"}
⟬date#1⟭ 04:00:02	INFO	versement/calcul.go:102	solde calcule	{"vendeur": "⟬company#2⟭", "brut": 4120.50, "commission": 412.05}
⟬date#1⟭ 04:00:02	DEBUG	versement/psp.go:58	appel prestataire	{"ref": "⟬opaque_token#1⟭", "montant": 3708.45}
⟬date#1⟭ 04:00:03	INFO	versement/psp.go:80	virement accepte	{"ref": "⟬uuid#2⟭", "statut": "ACSC"}
⟬date#1⟭ 04:00:03	DEBUG	versement/lecture.go:71	vendeur charge	{"vendeur": "⟬company#3⟭", "siren": "⟬fr_siren#3⟭", "iban": "⟬iban#3⟭"}
⟬date#1⟭ 04:00:03	WARN	versement/kyc.go:33	contact vendeur manquant	{"vendeur": "⟬company#3⟭", "representant": "⟬person_name#3⟭"}
⟬date#1⟭ 04:00:04	ERROR	versement/psp.go:80	virement rejete	{"ref": "⟬uuid#3⟭", "statut": "RJCT", "motif": "AC04", "iban": "⟬iban#3⟭"}
⟬date#1⟭ 04:00:04	INFO	versement/frais.go:29	frais de retour preleves	{"vendeur": "⟬company#3⟭", "carte": "⟬payment_card#3⟭", "montant": 15.00}
⟬date#1⟭ 04:00:05	DEBUG	versement/lecture.go:71	vendeur charge	{"vendeur": "⟬company#4⟭", "siren": "⟬fr_siren#4⟭", "iban": "⟬iban#4⟭"}
⟬date#1⟭ 04:00:05	INFO	versement/calcul.go:102	solde calcule	{"vendeur": "⟬company#4⟭", "brut": 91.20, "commission": 9.12}
⟬date#1⟭ 04:00:05	INFO	versement/seuil.go:17	solde sous le seuil, report	{"vendeur": "⟬company#4⟭", "seuil": 100}
⟬date#1⟭ 04:00:06	INFO	versement/lancer.go:97	fin du cycle	{"cycle": "⟬uuid#1⟭", "acceptes": 1, "rejetes": 1, "reportes": 1}
⟬date#1⟭ 04:00:06	DEBUG	versement/notif.go:40	courriel de synthese	{"destinataire": "⟬email:generic#5⟭"}
⟬date#1⟭ 04:00:07	INFO	metriques/export.go:22	envoi des compteurs	{"cible": "⟬hostname#1⟭", "owner": "⟬trap:indicator_non_pii|equipe-paiements⟭"}
⟬date#1⟭ 04:05:00	INFO	sante/sonde.go:15	service sain	{"version": "⟬version#1⟭"}
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: fr
fill_locale: fr_FR
domain: telecom
appearance: Erlang crash report, supervisor report
scenario: Erlang crash report of an operator's SIP registrar, with no real subscriber and a generic server state
⟬text⟭
=ERROR REPORT==== ⟬date#1⟭ 05:41:12 ===
** Generic server sip_registrar terminating
** Last message in was {register,<<"⟬trap:email_lookalike|sip:anonymous@ims-core⟭">>,3600}
** When Server state == #state{table = registrar_tab,
                               nodes = ['ims1@core01','ims2@core02'],
                               ⟬trap:indicator_non_pii|user_count = 0⟭}
** Reason for termination ==
** {badmatch,undefined}
     in function  sip_registrar:handle_call/3 (src/sip_registrar.erl, line 212)
     in call from gen_server:try_handle_call/4 (gen_server.erl, line 721)
     in call from gen_server:handle_msg/6 (gen_server.erl, line 750)
     in call from proc_lib:init_p_do_apply/3 (proc_lib.erl, line 226)

=CRASH REPORT==== ⟬date#1⟭ 05:41:12 ===
  crasher:
    initial call: sip_registrar:init/1
    pid: <0.812.0>
    registered_name: sip_registrar
    exception error: no match of right hand side value undefined
    ancestors: [sip_sup,<0.244.0>]
    message_queue_len: 3
    trap_exit: true
    ⟬trap:indicator_non_pii|owner: sip_sup⟭

=SUPERVISOR REPORT==== ⟬date#1⟭ 05:41:12 ===
     supervisor: {local,sip_sup}
     errorContext: child_terminated
     reason: {badmatch,undefined}
⟬end⟭

⟬template⟭
family: logs
format: test output
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: dotnet test output, record dump, assertion message
scenario: dotnet test output of a booking app, where the assertion compares two reservations with NIR, birth date and email in clear
⟬text⟭
  Determining projects to restore...
  All projects are up-to-date for restore.
  Sante.Rdv.Tests -> /build/tests/bin/Debug/net8.0/Sante.Rdv.Tests.dll
Test run for /build/tests/bin/Debug/net8.0/Sante.Rdv.Tests.dll (.NETCoreApp,Version=v8.0)
Starting test execution, please wait...
A total of 1 test files matched the specified pattern.
[xUnit.net 00:00:01.12]     Sante.Rdv.Tests.ReservationTests.RefuseLesDoublons [FAIL]
  Failed Sante.Rdv.Tests.ReservationTests.RefuseLesDoublons [41 ms]
  Error Message:
   Assert.Equal() Failure: Values differ
Expected: Reservation { Patient = "⟬person_name#1⟭", Nir = "⟬fr_social_security_number#1⟭", Naissance = ⟬birth_date#1⟭, Courriel = "⟬email#1⟭" }
Actual:   Reservation { Patient = "⟬person_name#2⟭", Nir = "⟬fr_social_security_number#2⟭", Naissance = ⟬birth_date#2⟭, Courriel = "⟬email#2⟭" }
  Stack Trace:
     at Sante.Rdv.Tests.ReservationTests.RefuseLesDoublons() in /build/tests/ReservationTests.cs:line 58
  Standard Output Messages:
 creneau ⟬uuid#1⟭ pris par ⟬trap:indicator_non_pii|client=fixture⟭

Failed!  - Failed:     1, Passed:   127, Skipped:     2, Total:   130, Duration: 3 s
⟬end⟭

⟬template⟭
family: logs
format: access log
language: fr
fill_locale: fr_FR
domain: insurance
appearance: JSON log line, parsed query string, HTTP header
scenario: Kong JSON gateway log in front of an insurer's broker API, keeping searches by plate and by licence
⟬text⟭
{"started_at":"⟬date#1⟭ 11:02:44","client_ip":"⟬ip_address#1⟭","consumer":{"username":"⟬trap:indicator_non_pii|courtier-partenaire-12⟭"},"request":{"method":"GET","uri":"/api/v2/vehicules","querystring":{"immat":"⟬fr_license_plate#1⟭"},"headers":{"x-client-ref":"⟬opaque_token#1⟭"}},"response":{"status":200},"latencies":{"proxy":41}}
{"started_at":"⟬date#1⟭ 11:02:51","client_ip":"⟬ip_address#1⟭","consumer":{"username":"⟬trap:indicator_non_pii|courtier-partenaire-12⟭"},"request":{"method":"GET","uri":"/api/v2/conducteurs","querystring":{"permis":"⟬fr_driving_licence#1⟭"},"headers":{"x-client-ref":"⟬opaque_token#1⟭"}},"response":{"status":200},"latencies":{"proxy":63}}
{"started_at":"⟬date#1⟭ 11:03:10","client_ip":"⟬ip_address#2⟭","consumer":{"username":"⟬company#2⟭"},"request":{"method":"GET","uri":"/api/v2/vehicules","querystring":{"immat":"⟬fr_license_plate#3⟭"},"headers":{"x-client-ref":"⟬order_number#3⟭"}},"response":{"status":404},"latencies":{"proxy":18}}
{"started_at":"⟬date#1⟭ 11:03:25","client_ip":"⟬ip_address#2⟭","consumer":{"username":"⟬company#2⟭"},"request":{"method":"POST","uri":"/api/v2/devis","querystring":{},"headers":{"x-client-ref":"⟬order_number#3⟭"}},"response":{"status":201},"latencies":{"proxy":102}}
{"started_at":"⟬date#1⟭ 11:03:44","client_ip":"⟬ip_address#3⟭","consumer":{"username":"⟬trap:indicator_non_pii|sonde-disponibilite⟭"},"request":{"method":"GET","uri":"/status","querystring":{},"headers":{}},"response":{"status":200},"latencies":{"proxy":1}}
{"started_at":"⟬date#1⟭ 11:04:02","client_ip":"⟬ip_address#4⟭","consumer":{"username":"⟬person_name:handle#4⟭"},"request":{"method":"GET","uri":"/api/v2/conducteurs","querystring":{"permis":"⟬fr_driving_licence#5⟭"},"headers":{"apikey":"⟬opaque_token#4⟭"}},"response":{"status":403},"latencies":{"proxy":9}}
{"started_at":"⟬date#1⟭ 11:04:19","client_ip":"⟬ip_address#4⟭","consumer":{"username":"⟬person_name:handle#4⟭"},"request":{"method":"GET","uri":"/api/v2/contrats","querystring":{"client":"⟬customer_id#5⟭","limit":"20"},"headers":{"apikey":"⟬opaque_token#4⟭"}},"response":{"status":200},"latencies":{"proxy":77}}
{"started_at":"⟬date#1⟭ 11:04:52","client_ip":"⟬ip_address#1⟭","consumer":{"username":"⟬trap:indicator_non_pii|courtier-partenaire-12⟭"},"request":{"method":"POST","uri":"/api/v2/sinistres","querystring":{},"headers":{"x-client-ref":"⟬opaque_token#1⟭"}},"response":{"status":201},"latencies":{"proxy":188}}
{"started_at":"⟬date#1⟭ 11:05:06","client_ip":"⟬ip_address#5⟭","consumer":null,"request":{"method":"GET","uri":"/api/v2/contrats","querystring":{},"headers":{}},"response":{"status":401},"latencies":{"proxy":2}}
{"started_at":"⟬date#1⟭ 11:05:44","client_ip":"⟬ip_address#3⟭","consumer":{"username":"⟬trap:indicator_non_pii|sonde-disponibilite⟭"},"request":{"method":"GET","uri":"/status","querystring":{},"headers":{}},"response":{"status":200},"latencies":{"proxy":1}}
{"started_at":"⟬date#1⟭ 11:06:15","client_ip":"⟬ip_address#6⟭","consumer":{"username":"⟬company#6⟭"},"request":{"method":"GET","uri":"/api/v2/vehicules","querystring":{"immat":"⟬fr_license_plate#7⟭"},"headers":{"x-client-ref":"⟬uuid#1⟭"}},"response":{"status":200},"latencies":{"proxy":38}}
{"started_at":"⟬date#1⟭ 11:06:31","client_ip":"⟬ip_address#6⟭","consumer":{"username":"⟬company#6⟭"},"request":{"method":"GET","uri":"/api/v2/conducteurs","querystring":{"permis":"⟬fr_driving_licence#7⟭"},"headers":{"x-client-ref":"⟬uuid#1⟭"}},"response":{"status":200},"latencies":{"proxy":52}}
{"started_at":"⟬date#1⟭ 11:07:02","client_ip":"⟬ip_address#7⟭","consumer":{"username":"⟬trap:indicator_non_pii|batch-tarifs⟭"},"request":{"method":"PUT","uri":"/api/v2/tarifs/auto","querystring":{"version":"⟬version#1⟭"},"headers":{"x-client-ref":"⟬uuid#2⟭"}},"response":{"status":204},"latencies":{"proxy":214}}
{"started_at":"⟬date#1⟭ 11:07:44","client_ip":"⟬ip_address#3⟭","consumer":{"username":"⟬trap:indicator_non_pii|sonde-disponibilite⟭"},"request":{"method":"GET","uri":"/status","querystring":{},"headers":{}},"response":{"status":200},"latencies":{"proxy":1}}
{"started_at":"⟬date#1⟭ 11:08:03","client_ip":"⟬ip_address#2⟭","consumer":{"username":"⟬company#2⟭"},"request":{"method":"GET","uri":"/api/v2/devis/⟬uuid#3⟭","querystring":{},"headers":{"x-client-ref":"⟬order_number#3⟭"}},"response":{"status":200},"latencies":{"proxy":29}}
{"started_at":"⟬date#1⟭ 11:09:44","client_ip":"⟬ip_address#3⟭","consumer":{"username":"⟬trap:indicator_non_pii|sonde-disponibilite⟭"},"request":{"method":"GET","uri":"/status","querystring":{},"headers":{}},"response":{"status":200},"latencies":{"proxy":1}}
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: fr
fill_locale: fr_FR
domain: insurance
appearance: CircleCI step output, shell trace, curl command, test fixture
scenario: CircleCI end-to-end job of a car claim journey, printing a token, a test password, a fixture plate and a Slack token
⟬text⟭
#!/bin/bash -eo pipefail
./ci/e2e.sh
+ export E2E_URL=⟬url#1⟭
+ export E2E_LOGIN=⟬trap:indicator_non_pii|e2e-gestionnaire⟭
+ export E2E_PASSWORD=⟬password#1⟭
+ export E2E_TOKEN=⟬jwt#1⟭
+ npx playwright test --project=sinistres
Running 6 tests using 2 workers
[sinistres] declaration: plaque=⟬fr_license_plate#2⟭ conducteur="⟬person_name#2⟭"
[sinistres] declaration: constat depose, dossier ⟬ticket_id#1⟭
  ok 1 declaration d'un bris de glace (8.2s)
  ok 2 ajout d'une photo (3.1s)
  ok 3 affectation de l'expert (2.4s)
  ok 4 refus sans contrat actif (1.9s)
  ok 5 indemnisation (4.4s)
  ok 6 cloture (1.2s)
  6 passed (21.4s)
+ curl -s -X POST https://slack.com/api/chat.postMessage -H 'Authorization: Bearer ⟬slack_token#1⟭' -d channel=recette-sinistres -d 'text=e2e ok'
{"ok":true,"channel":"⟬uuid#1⟭"}
CircleCI received exit code 0
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: fr
fill_locale: fr_FR
domain: banking
appearance: Oracle audit file, SQL statement, quoted value
scenario: Oracle audit files of a bank, where each ad hoc query by an operator keeps the NIR, account or card searched
⟬text⟭
Audit file /u01/app/oracle/admin/BANQ/adump/ora_4412_1.aud
Oracle Database 19c Enterprise Edition Release 19.0.0.0.0
Build label:    RDBMS_19.21.0.0.0
⟬date#1⟭ 15:02:11 +02:00
LENGTH : '214'
ACTION :[118] 'SELECT titulaire, iban FROM comptes WHERE nir = '⟬fr_social_security_number#2⟭''
⟬trap:indicator_non_pii|DATABASE USER:[10] 'BO_LECTEUR'⟭
PRIVILEGE :[4] 'NONE'
CLIENT USER:[11] "⟬person_name:handle#1⟭"
CLIENT TERMINAL:[7] 'pts/3'
STATUS:[1] '0'

⟬date#1⟭ 15:04:37 +02:00
LENGTH : '236'
ACTION :[131] 'UPDATE comptes SET statut = 'BLOQUE' WHERE numero = '⟬bank_account_number#2⟭' AND iban = '⟬iban#2⟭''
⟬trap:indicator_non_pii|DATABASE USER:[10] 'BO_LECTEUR'⟭
PRIVILEGE :[4] 'NONE'
CLIENT USER:[11] "⟬person_name:handle#1⟭"
CLIENT TERMINAL:[7] 'pts/3'
STATUS:[4] '1031'

⟬date#1⟭ 15:09:02 +02:00
LENGTH : '198'
ACTION :[96] 'SELECT * FROM cartes WHERE pan = '⟬payment_card#3⟭''
⟬trap:indicator_non_pii|DATABASE USER:[9] 'BO_FRAUDE'⟭
PRIVILEGE :[4] 'NONE'
CLIENT USER:[11] "⟬person_name:handle#4⟭"
CLIENT TERMINAL:[7] 'pts/8'
STATUS:[1] '0'

⟬date#1⟭ 15:30:00 +02:00
LENGTH : '172'
ACTION :[60] 'BEGIN dbms_stats.gather_schema_stats('BANQUE'); END;'
⟬trap:indicator_non_pii|DATABASE USER:[3] 'SYS'⟭
PRIVILEGE :[6] 'SYSDBA'
⟬trap:indicator_non_pii|CLIENT USER:[6] 'oracle'⟭
CLIENT TERMINAL:[4] 'cron'
STATUS:[1] '0'
⟬end⟭

⟬template⟭
family: logs
format: application log
language: fr
fill_locale: fr_FR
domain: public administration
appearance: mainframe job log, fixed-width message, quoted value
scenario: job log of a mainframe tax run, showing rejected taxpayers with tax number, NIR, birth date and ID document
⟬text⟭
                 J E S 2  J O B  L O G  --  S Y S T E M  P 0 1  --  N O D E  I M P O T S
⟬date#1⟭ 02:00:03 JOB08812 $HASP373 IMP0420  STARTED - INIT 3 - CLASS A - SYS P01
⟬date#1⟭ 02:00:03 JOB08812 IEF403I IMP0420 - STARTED
⟬date#1⟭ 02:00:04 JOB08812 IMP0001I CHARGEMENT DU FICHIER DES DECLARATIONS
⟬date#1⟭ 02:04:51 JOB08812 IMP0002I 1842201 ENREGISTREMENTS LUS
⟬date#1⟭ 02:04:52 JOB08812 IMP0301W REJET ENR 0004412 SPI=⟬fr_tax_number#2⟭ NOM="⟬person_name#2⟭" NE(E) LE ⟬birth_date#2⟭
⟬date#1⟭ 02:04:52 JOB08812 IMP0302W MOTIF: NIR ⟬fr_social_security_number#2⟭ DIFFERENT DU REFERENTIEL
⟬date#1⟭ 02:05:10 JOB08812 IMP0301W REJET ENR 0091120 SPI=⟬fr_tax_number#3⟭ NOM="⟬person_name#3⟭" NE(E) LE ⟬birth_date#3⟭
⟬date#1⟭ 02:05:10 JOB08812 IMP0303W MOTIF: PIECE PASSEPORT ⟬fr_passport#3⟭ EXPIREE
⟬date#1⟭ 02:06:02 JOB08812 IMP0301W REJET ENR 0420017 SPI=⟬fr_tax_number#4⟭ NOM="⟬person_name#4⟭" NE(E) LE ⟬birth_date#4⟭
⟬date#1⟭ 02:06:02 JOB08812 IMP0304W MOTIF: ADRESSE "⟬fr_postal_address#4⟭" INCONNUE DU SERVICE POSTAL
⟬date#1⟭ 02:11:40 JOB08812 IMP0005I 3 REJETS ECRITS DANS ⟬file_path#1⟭
⟬date#1⟭ 02:11:41 JOB08812 IEF142I IMP0420 STEP01 - STEP WAS EXECUTED - COND CODE 0004
⟬date#1⟭ 02:11:41 JOB08812 IEF404I IMP0420 - ENDED
⟬date#1⟭ 02:11:41 JOB08812 $HASP395 IMP0420  ENDED - RC=0004
------ JES2 JOB STATISTICS ------
       1,842,201 CARDS READ
          18,220 SYSOUT PRINT RECORDS
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: Python traceback, API error, local variables dump
scenario: failed call to an LLM summarising hospital reports: the error shows the API key and the prompt variable with the patient's identity
⟬text⟭
Traceback (most recent call last):
  File "/srv/resume/tache.py", line 73, in resumer_compte_rendu
    reponse = client.chat.completions.create(model="gpt-4o", messages=[{"role": "user", "content": prompt}])
  File "/srv/resume/.venv/lib/python3.11/site-packages/openai/_utils/_utils.py", line 277, in wrapper
    return func(*args, **kwargs)
  File "/srv/resume/.venv/lib/python3.11/site-packages/openai/resources/chat/completions.py", line 663, in create
    return self._post("/chat/completions", body=body, options=options, cast_to=ChatCompletion)
  File "/srv/resume/.venv/lib/python3.11/site-packages/openai/_base_client.py", line 1020, in _request
    raise self._make_status_error_from_response(err.response) from None
openai.AuthenticationError: Error code: 401 - {'error': {'message': 'Incorrect API key provided: ⟬openai_api_key#1⟭', 'type': 'invalid_request_error', 'code': 'invalid_api_key'}}

Sentry, variables locales de resumer_compte_rendu:
  document_id = '⟬uuid#1⟭'
  service = 'cardiologie'
  prompt = "Résume ce compte rendu. Patiente ⟬person_name#2f⟭, née le ⟬birth_date#2⟭, NIR ⟬fr_social_security_number#2⟭, adressée par le Dr ⟬person_name#3⟭ pour dyspnée d'effort. ⟬trap:eponym|Score de Framingham⟭ élevé."
  tentative = 3
⟬end⟭

⟬template⟭
family: logs
format: test output
language: fr
fill_locale: fr_FR
domain: insurance
appearance: k6 summary, load test metrics, thresholds
scenario: k6 summary of a load test on a quote calculator, with scenario parameters and no policyholder data
⟬text⟭
          /\      |‾‾| /‾‾/   /‾‾/
     /\  /  \     |  |/  /   /  /
    /  \/    \    |     (   /   ‾‾\
   /          \   |  |\  \ |  (‾)  |
  / __________ \  |__| \__\ \_____/ .io

  execution: local
     script: tests/charge/devis.js
     output: -

  scenarios: (100.00%) 1 scenario, 50 max VUs, 5m30s max duration
           * tarification: arrivées de ⟬trap:eponym|Poisson⟭, 20 req/s (⟬trap:indicator_non_pii|client=generique⟭, ⟬trap:indicator_non_pii|token_refresh_s=900⟭)

     ✓ statut 200
     ✗ temps de reponse < 500ms
      ↳  96% — ✓ 4120 / ✗ 171
     ✓ ⟬trap:indicator_non_pii|assure_id=fictif⟭ renvoye dans le corps

     checks.........................: 98.67% ✓ 12702 ✗ 171
     http_req_duration..............: avg=212ms min=44ms med=188ms max=1.92s p(90)=402ms p(95)=511ms
     http_req_failed................: 0.00%  ✓ 0     ✗ 4291
     http_reqs......................: 4291   19.9/s
     iterations.....................: 4291   19.9/s
     vus............................: 50     min=50  max=50

ERRO[0301] thresholds on metrics 'http_req_duration' have been crossed
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: fr
fill_locale: fr_FR
domain: public administration
appearance: gitleaks report, commit metadata, test fixture
scenario: gitleaks report of an online procedures repository, flagging a GitLab token and test data with author, email, passport, licence and tax number
⟬text⟭
$ gitleaks detect --source . --report-format json --verbose
    ○
    │╲
    │ ○
    ○ ░
    ░    gitleaks

Finding:     TOKEN="⟬gitlab_token#1⟭"
Secret:      ⟬gitlab_token#1⟭
RuleID:      gitlab-pat
Entropy:     4.12
File:        ci/publier.sh
Line:        14
Commit:      ⟬git_sha#1⟭
Author:      ⟬person_name#2⟭
Email:       ⟬email#2⟭
Date:        ⟬date#2⟭
Fingerprint: ⟬git_sha#1⟭:ci/publier.sh:gitlab-pat:14

Finding:     passeport=⟬fr_passport#3⟭;permis=⟬fr_driving_licence#3⟭
Secret:      ⟬fr_passport#3⟭
RuleID:      donnees-titres
Entropy:     3.46
File:        tests/fixtures/usager_demo.env
Line:        3
Commit:      ⟬git_sha#2⟭
Author:      ⟬person_name#4⟭
Email:       ⟬email#4⟭
Date:        ⟬date#1⟭
Fingerprint: ⟬git_sha#2⟭:tests/fixtures/usager_demo.env:donnees-titres:3

Finding:     numero_fiscal = "⟬fr_tax_number#3⟭"
Secret:      ⟬fr_tax_number#3⟭
RuleID:      donnees-fiscales
Entropy:     3.02
File:        tests/fixtures/usager_demo.py
Line:        21
Commit:      ⟬git_sha#2⟭
Author:      ⟬person_name#4⟭
Email:       ⟬email#4⟭
Date:        ⟬date#1⟭
Fingerprint: ⟬git_sha#2⟭:tests/fixtures/usager_demo.py:donnees-fiscales:21

12:04PM INF 342 commits scanned.
12:04PM INF scan completed in 1.84s
12:04PM WRN leaks found: 3
ERROR: Job failed: exit code 1
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: numbered audit line, quoted value, mail API key, support note
scenario: GDPR log of a merchant site over several days: access and erasure requests, support lookups, card updates and a mail API key
⟬text⟭
#000412 | ⟬date#3⟭ 09:02:11 | DPO "⟬person_name#1⟭" | DEMANDE_RECUE | type=acces canal=courriel demandeur=⟬email#2⟭
#000413 | ⟬date#3⟭ 09:03:40 | DPO "⟬person_name#1⟭" | VERIFICATION_IDENTITE | demandeur="⟬person_name#2⟭" tel=⟬phone#2⟭
#000414 | ⟬date#3⟭ 09:10:02 | ⟬trap:indicator_non_pii|acteur=robot-rgpd⟭ | RECHERCHE | client=⟬customer_id#2⟭ tables=7
#000415 | ⟬date#3⟭ 09:10:09 | ⟬trap:indicator_non_pii|acteur=robot-rgpd⟭ | EXPORT | archive=⟬file_path#1⟭ empreinte=⟬hash#1⟭
#000416 | ⟬date#3⟭ 09:12:33 | DPO "⟬person_name#1⟭" | ENVOI | destinataire=⟬email#2⟭ lien_expire=72h
#000417 | ⟬date#3⟭ 09:12:34 | ⟬trap:indicator_non_pii|acteur=robot-rgpd⟭ | MAIL_API | cle=⟬sendgrid_api_key#1⟭ statut=202
#000418 | ⟬date#3⟭ 10:44:51 | support "⟬person_name#3⟭" | RECHERCHE_CLIENT | critere=⟬phone#4⟭ resultat=1
#000419 | ⟬date#3⟭ 10:45:20 | support "⟬person_name#3⟭" | AFFICHAGE_CARTE | client=⟬customer_id#4⟭ carte=⟬payment_card#4⟭ justification="litige colis"
#000420 | ⟬date#3⟭ 10:46:02 | support "⟬person_name#3⟭" | REINIT_MOT_DE_PASSE | client=⟬customer_id#4⟭ provisoire=⟬password#4⟭
#000421 | ⟬date#3⟭ 11:02:40 | support "⟬person_name#5⟭" | RECHERCHE_CLIENT | critere="⟬person_name#6⟭" resultat=2
#000422 | ⟬date#3⟭ 11:03:02 | support "⟬person_name#5⟭" | AFFICHAGE_ADRESSE | client=⟬customer_id#6⟭ adresse="⟬fr_postal_address#6⟭"
#000423 | ⟬date#3⟭ 11:05:44 | support "⟬person_name#5⟭" | NOTE | client=⟬customer_id#6⟭ texte="rappeler après 18 h"
#000424 | ⟬date#3⟭ 14:20:15 | vendeur ⟬company#7⟭ | CONSULTATION_COMMANDE | commande=⟬order_number#7⟭ siren=⟬fr_siren#7⟭
#000425 | ⟬date#3⟭ 14:21:03 | vendeur ⟬company#7⟭ | EXPORT_CLIENTS | lignes=412 alerte=volume_inhabituel
#000426 | ⟬date#3⟭ 14:21:04 | ⟬trap:indicator_non_pii|acteur=regle-export-3⟭ | BLOCAGE_VENDEUR | vendeur=⟬company#7⟭
#000427 | ⟬date#3⟭ 14:35:29 | DPO "⟬person_name#1⟭" | ANALYSE_INCIDENT | vendeur=⟬company#7⟭ ticket=⟬ticket_id#1⟭
#000428 | ⟬date#3⟭ 14:40:12 | DPO "⟬person_name#1⟭" | APPEL | contact="⟬person_name#7⟭" tel=⟬phone#7⟭
#000429 | ⟬date#3⟭ 16:02:00 | ⟬trap:indicator_non_pii|acteur=purge-paniers⟭ | PURGE | lignes=8120
#000430 | ⟬date#2⟭ 16:30:12 | DPO "⟬person_name#1⟭" | DEMANDE_RECUE | type=effacement canal=formulaire demandeur=⟬email#8⟭
#000431 | ⟬date#2⟭ 16:31:05 | DPO "⟬person_name#1⟭" | VERIFICATION_IDENTITE | demandeur="⟬person_name#8⟭" naissance=⟬birth_date#8⟭
#000432 | ⟬date#2⟭ 16:40:50 | ⟬trap:indicator_non_pii|acteur=robot-rgpd⟭ | RECHERCHE | client=⟬customer_id#8⟭ tables=7
#000433 | ⟬date#2⟭ 16:40:57 | ⟬trap:indicator_non_pii|acteur=robot-rgpd⟭ | CONSERVATION_LEGALE | factures=4 motif="obligation comptable"
#000434 | ⟬date#2⟭ 16:41:03 | ⟬trap:indicator_non_pii|acteur=robot-rgpd⟭ | ANONYMISATION | client=⟬customer_id#8⟭ champs=nom,prenom,tel,adresse
#000435 | ⟬date#2⟭ 16:41:04 | ⟬trap:indicator_non_pii|acteur=robot-rgpd⟭ | CARTE_SUPPRIMEE | client=⟬customer_id#8⟭ ref=⟬uuid#1⟭
#000436 | ⟬date#2⟭ 16:42:20 | DPO "⟬person_name#1⟭" | ENVOI | destinataire=⟬email#8⟭ objet="confirmation d'effacement"
#000437 | ⟬date#2⟭ 16:42:21 | ⟬trap:indicator_non_pii|acteur=robot-rgpd⟭ | MAIL_API | cle=⟬sendgrid_api_key#1⟭ statut=202
#000438 | ⟬date#2⟭ 17:05:48 | support "⟬person_name#9⟭" | RECHERCHE_CLIENT | critere=⟬email#8⟭ resultat=0
#000439 | ⟬date#2⟭ 17:06:10 | support "⟬person_name#9⟭" | RECHERCHE_CLIENT | critere=⟬order_number#8⟭ resultat=1
#000440 | ⟬date#2⟭ 17:06:33 | support "⟬person_name#9⟭" | NOTE | commande=⟬order_number#8⟭ texte="client anonymisé, remboursement impossible en ligne"
#000441 | ⟬date#2⟭ 17:20:00 | ⟬trap:indicator_non_pii|acteur=rotation-cles⟭ | ROTATION | service=courriel empreinte=⟬hash#2⟭
#000442 | ⟬date#1⟭ 18:02:17 | DPO "⟬person_name#1⟭" | REGISTRE_MAJ | traitement=prospection version=⟬version#1⟭
#000443 | ⟬date#1⟭ 18:03:02 | DPO "⟬person_name#1⟭" | SOUS_TRAITANT_AJOUTE | societe=⟬company#10⟭ siren=⟬fr_siren#10⟭ pays=⟬country#10⟭
#000444 | ⟬date#1⟭ 18:03:40 | DPO "⟬person_name#1⟭" | CONTACT_SOUS_TRAITANT | nom="⟬person_name#10⟭" mail=⟬email#10⟭
#000445 | ⟬date#1⟭ 18:10:29 | admin "⟬person_name#11⟭" | ROLE_MODIFIE | cible=⟬email#3⟭ role=lecture_seule
#000446 | ⟬date#1⟭ 18:11:45 | admin "⟬person_name#11⟭" | ROLE_MODIFIE | cible=⟬email#5⟭ role=superviseur
#000447 | ⟬date#1⟭ 18:12:02 | admin "⟬person_name#11⟭" | CLE_API_CREEE | service=partenaire-avis value=⟬opaque_token#1⟭
#000448 | ⟬date#1⟭ 18:12:03 | admin "⟬person_name#11⟭" | CLE_API_CREEE | service=partenaire-livraison value=⟬opaque_token#2⟭
#000449 | ⟬date#1⟭ 18:15:30 | ⟬trap:indicator_non_pii|acteur=robot-securite⟭ | ALERTE | motif="cle affichee dans le journal"
#000450 | ⟬date#1⟭ 18:20:44 | admin "⟬person_name#11⟭" | CLE_API_REVOQUEE | service=partenaire-avis ref=⟬uuid#2⟭
#000451 | ⟬date#1⟭ 18:20:45 | admin "⟬person_name#11⟭" | CLE_API_REVOQUEE | service=partenaire-livraison ref=⟬uuid#3⟭
#000452 | ⟬date#1⟭ 18:30:00 | ⟬trap:indicator_non_pii|acteur=sauvegarde⟭ | COPIE_JOURNAL | cible=⟬hostname#1⟭ taille=412Mo
#000453 | ⟬date#1⟭ 18:45:11 | support "⟬person_name#12⟭" | CONNEXION | poste=⟬ip_address#1⟭
#000454 | ⟬date#1⟭ 18:47:02 | support "⟬person_name#12⟭" | RECHERCHE_CLIENT | critere=⟬phone#13⟭ resultat=1
#000455 | ⟬date#1⟭ 18:47:40 | support "⟬person_name#12⟭" | AFFICHAGE_CARTE | client=⟬customer_id#13⟭ carte=⟬payment_card#13⟭ justification="carte expirée"
#000456 | ⟬date#1⟭ 18:48:32 | support "⟬person_name#12⟭" | MISE_A_JOUR_CARTE | client=⟬customer_id#13⟭ expiration=08/28
#000457 | ⟬date#1⟭ 18:49:02 | support "⟬person_name#12⟭" | DECONNEXION | poste=⟬ip_address#1⟭
#000458 | ⟬date#1⟭ 19:00:00 | ⟬trap:indicator_non_pii|acteur=robot-rgpd⟭ | PURGE_EXPORTS | fichiers=3
#000459 | ⟬date#1⟭ 19:30:00 | ⟬trap:indicator_non_pii|acteur=purge-paniers⟭ | PURGE | lignes=3120
#000460 | ⟬date#1⟭ 20:00:00 | ⟬trap:indicator_non_pii|acteur=sonde-audit⟭ | CONTROLE | chaine_empreintes=ok
#000461 | ⟬date#1⟭ 20:15:03 | ⟬trap:indicator_non_pii|acteur=sonde-audit⟭ | CONTROLE | horloge=ok
#000462 | ⟬date#1⟭ 20:30:01 | ⟬trap:indicator_non_pii|acteur=sonde-audit⟭ | CONTROLE | stockage=ok
#000463 | ⟬date#1⟭ 21:00:00 | ⟬trap:indicator_non_pii|acteur=sauvegarde⟭ | COPIE_JOURNAL | cible=⟬hostname#1⟭ taille=418Mo
#000464 | ⟬date#1⟭ 21:30:00 | ⟬trap:indicator_non_pii|acteur=sonde-audit⟭ | CONTROLE | chaine_empreintes=ok
#000465 | ⟬date#1⟭ 22:00:00 | ⟬trap:indicator_non_pii|acteur=sonde-audit⟭ | CONTROLE | chaine_empreintes=ok
#000466 | ⟬date#1⟭ 22:30:00 | ⟬trap:indicator_non_pii|acteur=sonde-audit⟭ | CONTROLE | chaine_empreintes=ok
#000467 | ⟬date#1⟭ 23:00:00 | ⟬trap:indicator_non_pii|acteur=sauvegarde⟭ | COPIE_JOURNAL | cible=⟬hostname#1⟭ taille=421Mo
#000468 | ⟬date#1⟭ 23:30:00 | ⟬trap:indicator_non_pii|acteur=sonde-audit⟭ | CONTROLE | chaine_empreintes=ok
#000469 | ⟬date#1⟭ 23:45:00 | ⟬trap:indicator_non_pii|acteur=sonde-audit⟭ | CONTROLE | horloge=ok
#000470 | ⟬date#1⟭ 23:46:10 | ⟬trap:indicator_non_pii|acteur=sauvegarde⟭ | COPIE_JOURNAL | cible=⟬hostname#1⟭ taille=422Mo
#000471 | ⟬date#1⟭ 23:50:00 | ⟬trap:indicator_non_pii|acteur=sonde-audit⟭ | CONTROLE | chaine_empreintes=ok
#000472 | ⟬date#1⟭ 23:55:00 | ⟬trap:indicator_non_pii|acteur=sonde-audit⟭ | CONTROLE | stockage=ok
#000473 | ⟬date#1⟭ 23:59:00 | ⟬trap:indicator_non_pii|acteur=sonde-audit⟭ | CLOTURE_JOURNEE | lignes=62
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: fr
fill_locale: fr_FR
domain: insurance
appearance: Kafka consumer error, Java stack trace, inline JSON payload
scenario: Kafka consumer of an insurer failing in a loop on a claim event and reprinting the message with plate, licence, IBAN and the third party's phone
⟬text⟭
⟬date#1⟭ 12:17:03.412 ERROR [sinistres-consumer-1] o.s.k.l.KafkaMessageListenerContainer - Error handler threw an exception
org.springframework.kafka.KafkaException: Seek to current after exception; nested exception is org.springframework.kafka.listener.ListenerExecutionFailedException: Listener failed
	at org.springframework.kafka.listener.SeekUtils.seekOrRecover(SeekUtils.java:208)
	at org.springframework.kafka.listener.DefaultErrorHandler.handleRemaining(DefaultErrorHandler.java:163)
	at org.springframework.kafka.listener.KafkaMessageListenerContainer$ListenerConsumer.invokeErrorHandler(KafkaMessageListenerContainer.java:2902)
	at org.springframework.kafka.listener.KafkaMessageListenerContainer$ListenerConsumer.invokeRecordListener(KafkaMessageListenerContainer.java:2769)
	at org.springframework.kafka.listener.KafkaMessageListenerContainer$ListenerConsumer.pollAndInvoke(KafkaMessageListenerContainer.java:1558)
	at java.base/java.lang.Thread.run(Thread.java:840)
Caused by: org.springframework.kafka.listener.ListenerExecutionFailedException: Listener method 'public void fr.assurance.sinistres.Consommateur.recevoir(java.lang.String)' threw exception
	at org.springframework.kafka.listener.adapter.MessagingMessageListenerAdapter.invokeHandler(MessagingMessageListenerAdapter.java:380)
	at org.springframework.kafka.listener.adapter.RecordMessagingMessageListenerAdapter.onMessage(RecordMessagingMessageListenerAdapter.java:92)
	... 12 common frames omitted
Caused by: com.fasterxml.⟬trap:library|jackson⟭.databind.exc.UnrecognizedPropertyException: Unrecognized field "tiersResponsable" (class fr.assurance.sinistres.Evenement), not marked as ignorable
 at [Source: (String)"{"sinistre":"⟬ticket_id#1⟭","vehicule":{"immat":"⟬fr_license_plate#2⟭"},"conducteur":{"nom":"⟬person_name#2⟭","permis":"⟬fr_driving_licence#2⟭"},"tiersResponsable":{"nom":"⟬person_name#3⟭","tel":"⟬phone#3⟭","immat":"⟬fr_license_plate#3⟭"},"reglement":{"iban":"⟬iban#2⟭"}}"; line: 1, column: 188]
	at com.fasterxml.⟬trap:library|jackson⟭.databind.exc.UnrecognizedPropertyException.from(UnrecognizedPropertyException.java:61)
	at com.fasterxml.⟬trap:library|jackson⟭.databind.DeserializationContext.handleUnknownProperty(DeserializationContext.java:1132)
	at com.fasterxml.⟬trap:library|jackson⟭.databind.ObjectMapper.readValue(ObjectMapper.java:3629)
	at fr.assurance.sinistres.Consommateur.recevoir(Consommateur.java:47)
	... 18 common frames omitted

⟬date#1⟭ 12:17:03.418 WARN  [sinistres-consumer-1] f.a.sinistres.Reprise - essai 1/3 pour offset 882144, partition 2
⟬date#1⟭ 12:17:08.420 ERROR [sinistres-consumer-1] o.s.k.l.KafkaMessageListenerContainer - Error handler threw an exception
org.springframework.kafka.listener.ListenerExecutionFailedException: Listener failed
	at org.springframework.kafka.listener.adapter.MessagingMessageListenerAdapter.invokeHandler(MessagingMessageListenerAdapter.java:380)
	at org.springframework.kafka.listener.KafkaMessageListenerContainer$ListenerConsumer.doInvokeRecordListener(KafkaMessageListenerContainer.java:2851)
Caused by: com.fasterxml.⟬trap:library|jackson⟭.databind.exc.UnrecognizedPropertyException: Unrecognized field "tiersResponsable"
 at [Source: (String)"{"sinistre":"⟬ticket_id#1⟭","vehicule":{"immat":"⟬fr_license_plate#2⟭"},"conducteur":{"nom":"⟬person_name#2⟭","permis":"⟬fr_driving_licence#2⟭"},"tiersResponsable":{"nom":"⟬person_name#3⟭","tel":"⟬phone#3⟭","immat":"⟬fr_license_plate#3⟭"},"reglement":{"iban":"⟬iban#2⟭"}}"; line: 1, column: 188]
	... 21 common frames omitted

⟬date#1⟭ 12:17:08.424 WARN  [sinistres-consumer-1] f.a.sinistres.Reprise - essai 2/3 pour offset 882144, partition 2
⟬date#1⟭ 12:17:18.431 ERROR [sinistres-consumer-1] o.s.k.l.KafkaMessageListenerContainer - Error handler threw an exception
org.springframework.kafka.listener.ListenerExecutionFailedException: Listener failed
	at org.springframework.kafka.listener.adapter.MessagingMessageListenerAdapter.invokeHandler(MessagingMessageListenerAdapter.java:380)
	at org.springframework.kafka.listener.KafkaMessageListenerContainer$ListenerConsumer.doInvokeRecordListener(KafkaMessageListenerContainer.java:2851)
Caused by: com.fasterxml.⟬trap:library|jackson⟭.databind.exc.UnrecognizedPropertyException: Unrecognized field "tiersResponsable"
 at [Source: (String)"{"sinistre":"⟬ticket_id#1⟭","vehicule":{"immat":"⟬fr_license_plate#2⟭"},"conducteur":{"nom":"⟬person_name#2⟭","permis":"⟬fr_driving_licence#2⟭"},"tiersResponsable":{"nom":"⟬person_name#3⟭","tel":"⟬phone#3⟭","immat":"⟬fr_license_plate#3⟭"},"reglement":{"iban":"⟬iban#2⟭"}}"; line: 1, column: 188]
	... 21 common frames omitted

⟬date#1⟭ 12:17:18.436 WARN  [sinistres-consumer-1] f.a.sinistres.Reprise - essai 3/3 pour offset 882144, partition 2
⟬date#1⟭ 12:17:18.440 ERROR [sinistres-consumer-1] f.a.sinistres.Reprise - message envoyé en file morte sinistres.DLT, cle=⟬uuid#1⟭
⟬date#1⟭ 12:17:18.447 INFO  [sinistres-consumer-1] o.a.k.clients.producer.KafkaProducer - [Producer clientId=sinistres-dlt] Closing the Kafka producer
⟬date#1⟭ 12:17:18.452 INFO  [sinistres-consumer-1] o.a.k.c.c.internals.ConsumerCoordinator - [Consumer clientId=sinistres-consumer-1, groupId=sinistres] Seeking to offset 882145 for partition sinistres-2
⟬date#1⟭ 12:17:19.002 INFO  [sinistres-consumer-1] f.a.sinistres.Consommateur - reprise de la consommation
⟬date#1⟭ 12:17:19.310 INFO  [sinistres-consumer-1] f.a.sinistres.Consommateur - sinistre ⟬ticket_id#2⟭ enregistré
⟬date#1⟭ 12:17:19.611 INFO  [sinistres-consumer-1] f.a.sinistres.Consommateur - sinistre ⟬ticket_id#3⟭ enregistré
⟬date#1⟭ 12:17:21.044 ERROR [expertise-consumer-2] o.s.k.l.KafkaMessageListenerContainer - Consumer exception
java.lang.IllegalStateException: This error handler cannot process 'org.apache.kafka.common.errors.TimeoutException's; no record information is available
	at org.springframework.kafka.listener.DefaultErrorHandler.handleOtherException(DefaultErrorHandler.java:192)
	at org.springframework.kafka.listener.KafkaMessageListenerContainer$ListenerConsumer.handleConsumerException(KafkaMessageListenerContainer.java:1845)
	at org.springframework.kafka.listener.KafkaMessageListenerContainer$ListenerConsumer.run(KafkaMessageListenerContainer.java:1287)
	at java.base/java.util.concurrent.CompletableFuture$AsyncRun.run(CompletableFuture.java:1804)
	at java.base/java.lang.Thread.run(Thread.java:840)
Caused by: org.apache.kafka.common.errors.TimeoutException: Timeout of 60000ms expired before successfully committing offsets
⟬date#1⟭ 12:17:21.050 INFO  [expertise-consumer-2] f.a.expertise.Sante - nouvelle tentative de connexion à ⟬hostname#1⟭
⟬date#1⟭ 12:17:24.106 INFO  [expertise-consumer-2] f.a.expertise.Sante - connexion rétablie
⟬date#1⟭ 12:18:00.000 INFO  [scheduling-1] f.a.sinistres.Alertes - 1 message en file morte, alerte envoyée à ⟬email:generic#4⟭
⟬date#1⟭ 12:19:00.000 INFO  [scheduling-1] f.a.sinistres.Alertes - ticket ouvert ⟬ticket_id#4⟭ pour la file morte
⟬date#1⟭ 12:19:41.512 INFO  [sinistres-consumer-1] f.a.sinistres.Consommateur - sinistre ⟬ticket_id#5⟭ enregistré
⟬date#1⟭ 12:20:03.204 WARN  [sinistres-consumer-1] f.a.sinistres.Validation - conducteur "⟬person_name#5⟭" sans permis renseigné, sinistre ⟬ticket_id#5⟭ à compléter
⟬date#1⟭ 12:20:03.209 INFO  [sinistres-consumer-1] f.a.sinistres.Notification - courriel de relance envoyé à ⟬email#5⟭
⟬date#1⟭ 12:21:00.000 INFO  [scheduling-1] f.a.sinistres.Sante - retard du consommateur: 0 message
⟬date#1⟭ 12:22:00.000 INFO  [scheduling-1] f.a.sinistres.Sante - retard du consommateur: 0 message
⟬end⟭

⟬template⟭
family: logs
format: application log
language: fr
fill_locale: fr_FR
domain: banking
appearance: gateway log, status line, masked value, BIC
scenario: interbank messaging gateway log over a morning, with acknowledgements, BICs and masked accounts, with no readable customer
⟬text⟭
⟬date#1⟭ 06:00:00 GW-INFO  session ouverte vers le réseau interbancaire, terminal ⟬hostname#1⟭
⟬date#1⟭ 06:00:00 GW-INFO  certificat de session valable 11 mois, empreinte ⟬hash#1⟭
⟬date#1⟭ 06:00:02 GW-INFO  file ENTRANTE: 0 message, file SORTANTE: 118 messages
⟬date#1⟭ 06:00:03 GW-INFO  HSM ⟬hostname#2⟭ joignable, partition 1 active
⟬date#1⟭ 06:00:03 GW-DEBUG ⟬trap:indicator_non_pii|key_id=partition-1-signature⟭ chargée
⟬date#1⟭ 06:00:10 GW-INFO  MT103 ref=⟬uuid#1⟭ vers ⟬bic#1⟭ accepté (ACK)
⟬date#1⟭ 06:00:11 GW-INFO  MT103 ref=⟬uuid#2⟭ vers ⟬bic#2⟭ accepté (ACK)
⟬date#1⟭ 06:00:13 GW-INFO  MT103 ref=⟬uuid#3⟭ vers ⟬bic#3⟭ accepté (ACK)
⟬date#1⟭ 06:00:14 GW-DEBUG ⟬trap:indicator_non_pii|compte_donneur=****4412⟭ masqué par la politique MASK-3
⟬date#1⟭ 06:00:14 GW-DEBUG ⟬trap:indicator_non_pii|compte_beneficiaire=****0918⟭ masqué par la politique MASK-3
⟬date#1⟭ 06:00:17 GW-WARN  MT103 ref=⟬uuid#4⟭ vers ⟬bic#4⟭ refusé (NAK, code T13)
⟬date#1⟭ 06:00:17 GW-INFO  ref=⟬uuid#4⟭ placé en réparation, ⟬trap:indicator_non_pii|operateur=back-office-flux⟭
⟬date#1⟭ 06:00:22 GW-INFO  MT202 ref=⟬uuid#5⟭ vers ⟬bic#1⟭ accepté (ACK)
⟬date#1⟭ 06:00:25 GW-INFO  MT202 ref=⟬uuid#6⟭ vers ⟬bic#5⟭ accepté (ACK)
⟬date#1⟭ 06:05:00 GW-INFO  heartbeat réseau ok, latence 41 ms
⟬date#1⟭ 06:10:00 GW-INFO  heartbeat réseau ok, latence 39 ms
⟬date#1⟭ 06:12:44 GW-INFO  MT940 reçu de ⟬bic#6⟭, 1 relevé, 412 écritures
⟬date#1⟭ 06:12:45 GW-DEBUG ⟬trap:indicator_non_pii|compte=FR76***************2204⟭ intégré à la comptabilité
⟬date#1⟭ 06:12:50 GW-INFO  MT940 reçu de ⟬bic#2⟭, 1 relevé, 88 écritures
⟬date#1⟭ 06:12:51 GW-DEBUG ⟬trap:indicator_non_pii|compte=FR14***************7781⟭ intégré à la comptabilité
⟬date#1⟭ 06:15:00 GW-INFO  heartbeat réseau ok, latence 40 ms
⟬date#1⟭ 06:20:00 GW-INFO  heartbeat réseau ok, latence 44 ms
⟬date#1⟭ 06:20:31 GW-WARN  file SORTANTE à 80 % du quota
⟬date#1⟭ 06:20:32 GW-INFO  ouverture d'un second canal vers ⟬hostname#3⟭
⟬date#1⟭ 06:21:02 GW-INFO  file SORTANTE à 42 % du quota
⟬date#1⟭ 06:25:00 GW-INFO  heartbeat réseau ok, latence 38 ms
⟬date#1⟭ 06:30:00 GW-INFO  fenêtre de compensation ouverte
⟬date#1⟭ 06:30:12 GW-INFO  lot de compensation ⟬order_number#1⟭: 8120 opérations, total 41 204 118,20 EUR
⟬date#1⟭ 06:30:40 GW-INFO  lot de compensation ⟬order_number#1⟭ accepté
⟬date#1⟭ 06:35:00 GW-INFO  heartbeat réseau ok, latence 42 ms
⟬date#1⟭ 06:40:00 GW-INFO  heartbeat réseau ok, latence 39 ms
⟬date#1⟭ 06:44:18 GW-ERROR canal 2 fermé par le pair, reprise dans 30 s
⟬date#1⟭ 06:44:48 GW-INFO  canal 2 rétabli
⟬date#1⟭ 06:45:00 GW-INFO  heartbeat réseau ok, latence 61 ms
⟬date#1⟭ 06:50:00 GW-INFO  heartbeat réseau ok, latence 40 ms
⟬date#1⟭ 06:52:09 GW-INFO  MT103 ref=⟬uuid#7⟭ vers ⟬bic#7⟭ accepté (ACK)
⟬date#1⟭ 06:52:11 GW-INFO  MT103 ref=⟬uuid#8⟭ vers ⟬bic#3⟭ accepté (ACK)
⟬date#1⟭ 06:52:14 GW-INFO  MT103 ref=⟬uuid#9⟭ vers ⟬bic#1⟭ accepté (ACK)
⟬date#1⟭ 06:55:00 GW-INFO  heartbeat réseau ok, latence 39 ms
⟬date#1⟭ 07:00:00 GW-INFO  bilan horaire: 412 envoyés, 2 refusés, 18 reçus
⟬date#1⟭ 07:00:01 GW-DEBUG export des compteurs vers ⟬url#1⟭
⟬date#1⟭ 07:05:00 GW-INFO  heartbeat réseau ok, latence 40 ms
⟬date#1⟭ 07:10:00 GW-INFO  heartbeat réseau ok, latence 41 ms
⟬date#1⟭ 07:12:30 GW-INFO  ref=⟬uuid#4⟭ réparé et renvoyé, ⟬trap:indicator_non_pii|operateur=back-office-flux⟭
⟬date#1⟭ 07:12:33 GW-INFO  MT103 ref=⟬uuid#4⟭ vers ⟬bic#4⟭ accepté (ACK)
⟬date#1⟭ 07:15:00 GW-INFO  heartbeat réseau ok, latence 38 ms
⟬date#1⟭ 07:20:00 GW-INFO  heartbeat réseau ok, latence 42 ms
⟬date#1⟭ 07:25:00 GW-INFO  heartbeat réseau ok, latence 41 ms
⟬date#1⟭ 07:30:00 GW-INFO  fenêtre de compensation fermée
⟬date#1⟭ 07:30:02 GW-INFO  rapport de compensation écrit dans ⟬file_path#1⟭
⟬date#1⟭ 07:35:00 GW-INFO  heartbeat réseau ok, latence 40 ms
⟬date#1⟭ 07:40:00 GW-INFO  heartbeat réseau ok, latence 39 ms
⟬date#1⟭ 07:45:00 GW-INFO  heartbeat réseau ok, latence 43 ms
⟬date#1⟭ 07:50:00 GW-INFO  heartbeat réseau ok, latence 40 ms
⟬date#1⟭ 07:55:00 GW-INFO  heartbeat réseau ok, latence 41 ms
⟬date#1⟭ 08:00:00 GW-INFO  bilan horaire: 388 envoyés, 0 refusé, 22 reçus
⟬date#1⟭ 08:00:01 GW-DEBUG export des compteurs vers ⟬url#1⟭
⟬date#1⟭ 08:01:12 GW-INFO  nouvelle version de la table des BIC: ⟬version#1⟭
⟬date#1⟭ 08:01:15 GW-INFO  ⟬bic#8⟭ ajouté, ⟬bic#9⟭ retiré
⟬date#1⟭ 08:05:00 GW-INFO  heartbeat réseau ok, latence 39 ms
⟬date#1⟭ 08:10:00 GW-INFO  heartbeat réseau ok, latence 40 ms
⟬date#1⟭ 08:15:00 GW-INFO  heartbeat réseau ok, latence 38 ms
⟬date#1⟭ 08:20:00 GW-INFO  heartbeat réseau ok, latence 41 ms
⟬date#1⟭ 08:30:00 GW-INFO  point de contrôle du journal, empreinte ⟬hash#2⟭
⟬end⟭

⟬template⟭
family: logs
format: access log
language: fr
fill_locale: fr_FR
domain: telecom
appearance: custom access format, captured field, device serial, URL with a secret
scenario: access of an access provider's box management server, whose format captures each box's remote connection credentials and technician tokens
⟬text⟭
⟬ip_address#1⟭ acs [⟬date#1⟭ 02:00:04 +0100] "POST /acs HTTP/1.1" 200 412 cpe="⟬hash#1⟭" oui=⟬customer_id#1⟭ cr_user=⟬trap:indicator_non_pii|acs-box⟭ cr_pass="⟬password#1⟭"
⟬ip_address#2⟭ acs [⟬date#1⟭ 02:00:05 +0100] "POST /acs HTTP/1.1" 200 412 cpe="⟬hash#2⟭" oui=⟬customer_id#1⟭ cr_user=⟬trap:indicator_non_pii|acs-box⟭ cr_pass="⟬password#2⟭"
⟬ip_address#3⟭ acs [⟬date#1⟭ 02:00:09 +0100] "POST /acs HTTP/1.1" 204 0 cpe="⟬hash#3⟭" oui=⟬customer_id#2⟭ cr_user=⟬trap:indicator_non_pii|acs-box⟭ cr_pass="⟬password#3⟭"
⟬ip_address#4⟭ - [⟬date#1⟭ 02:00:12 +0100] "GET /firmware/box-v5-⟬version#1⟭.bin HTTP/1.1" 200 41820044 cpe="-" oui=- cr_user=- cr_pass="-"
⟬ip_address#1⟭ acs [⟬date#1⟭ 02:01:04 +0100] "POST /acs HTTP/1.1" 200 188 cpe="⟬hash#1⟭" oui=⟬customer_id#1⟭ cr_user=⟬trap:indicator_non_pii|acs-box⟭ cr_pass="⟬password#1⟭"
⟬ip_address#5⟭ - [⟬date#1⟭ 02:01:30 +0100] "GET /supervision/ping HTTP/1.1" 200 2 cpe="-" oui=- cr_user=- cr_pass="-"
⟬ip_address#6⟭ ⟬person_name:handle#4⟭ [⟬date#1⟭ 02:02:11 +0100] "POST /tech/connexion HTTP/1.1" 200 642 cpe="-" oui=- cr_user=- cr_pass="-"
⟬ip_address#6⟭ ⟬person_name:handle#4⟭ [⟬date#1⟭ 02:02:14 +0100] "GET /tech/box/⟬hash#4⟭/parametres?jeton=⟬jwt#4⟭ HTTP/1.1" 200 8120 cpe="⟬hash#4⟭" oui=⟬customer_id#2⟭ cr_user=- cr_pass="-"
⟬ip_address#6⟭ ⟬person_name:handle#4⟭ [⟬date#1⟭ 02:02:31 +0100] "POST /tech/box/⟬hash#4⟭/redemarrer?jeton=⟬jwt#4⟭ HTTP/1.1" 202 64 cpe="⟬hash#4⟭" oui=⟬customer_id#2⟭ cr_user=- cr_pass="-"
⟬ip_address#7⟭ acs [⟬date#1⟭ 02:03:02 +0100] "POST /acs HTTP/1.1" 200 412 cpe="⟬hash#4⟭" oui=⟬customer_id#2⟭ cr_user=⟬trap:indicator_non_pii|acs-box⟭ cr_pass="⟬password#4⟭"
⟬ip_address#7⟭ acs [⟬date#1⟭ 02:03:05 +0100] "POST /acs HTTP/1.1" 200 188 cpe="⟬hash#4⟭" oui=⟬customer_id#2⟭ cr_user=⟬trap:indicator_non_pii|acs-box⟭ cr_pass="⟬password#4⟭"
⟬ip_address#8⟭ acs [⟬date#1⟭ 02:03:44 +0100] "POST /acs HTTP/1.1" 401 96 cpe="⟬hash#5⟭" oui=⟬customer_id#3⟭ cr_user=- cr_pass="-"
⟬ip_address#8⟭ acs [⟬date#1⟭ 02:03:45 +0100] "POST /acs HTTP/1.1" 200 412 cpe="⟬hash#5⟭" oui=⟬customer_id#3⟭ cr_user=⟬trap:indicator_non_pii|acs-box⟭ cr_pass="⟬password#5⟭"
⟬ip_address#5⟭ - [⟬date#1⟭ 02:04:30 +0100] "GET /supervision/ping HTTP/1.1" 200 2 cpe="-" oui=- cr_user=- cr_pass="-"
⟬ip_address#6⟭ ⟬person_name:handle#4⟭ [⟬date#1⟭ 02:05:02 +0100] "GET /tech/box/⟬hash#5⟭/journal?jeton=⟬jwt#4⟭ HTTP/1.1" 200 22044 cpe="⟬hash#5⟭" oui=⟬customer_id#3⟭ cr_user=- cr_pass="-"
⟬ip_address#9⟭ - [⟬date#1⟭ 02:05:40 +0100] "GET /firmware/box-v4-⟬version#2⟭.bin HTTP/1.1" 200 38120112 cpe="-" oui=- cr_user=- cr_pass="-"
⟬ip_address#10⟭ acs [⟬date#1⟭ 02:06:03 +0100] "POST /acs HTTP/1.1" 200 412 cpe="⟬hash#6⟭" oui=⟬customer_id#2⟭ cr_user=⟬trap:indicator_non_pii|acs-box⟭ cr_pass="⟬password#6⟭"
⟬ip_address#10⟭ acs [⟬date#1⟭ 02:06:05 +0100] "POST /acs/telechargement?token=⟬opaque_token#6⟭ HTTP/1.1" 200 96 cpe="⟬hash#6⟭" oui=⟬customer_id#2⟭ cr_user=- cr_pass="-"
⟬ip_address#11⟭ ⟬trap:indicator_non_pii|user-campagne⟭ [⟬date#1⟭ 02:07:00 +0100] "POST /campagnes/⟬uuid#1⟭/lancer HTTP/1.1" 202 64 cpe="-" oui=- cr_user=- cr_pass="-"
⟬ip_address#5⟭ - [⟬date#1⟭ 02:07:30 +0100] "GET /supervision/ping HTTP/1.1" 200 2 cpe="-" oui=- cr_user=- cr_pass="-"
⟬ip_address#12⟭ acs [⟬date#1⟭ 02:08:14 +0100] "POST /acs HTTP/1.1" 200 412 cpe="⟬hash#7⟭" oui=⟬customer_id#3⟭ cr_user=⟬trap:indicator_non_pii|acs-box⟭ cr_pass="⟬password#7⟭"
⟬ip_address#13⟭ acs [⟬date#1⟭ 02:08:31 +0100] "POST /acs HTTP/1.1" 200 412 cpe="⟬hash#8⟭" oui=⟬customer_id#1⟭ cr_user=⟬trap:indicator_non_pii|acs-box⟭ cr_pass="⟬password#8⟭"
⟬ip_address#6⟭ ⟬person_name:handle#4⟭ [⟬date#1⟭ 02:09:02 +0100] "POST /tech/deconnexion HTTP/1.1" 204 0 cpe="-" oui=- cr_user=- cr_pass="-"
⟬ip_address#14⟭ ⟬person_name:handle#9⟭ [⟬date#1⟭ 02:09:44 +0100] "POST /tech/connexion HTTP/1.1" 401 88 cpe="-" oui=- cr_user=- cr_pass="-"
⟬ip_address#14⟭ ⟬person_name:handle#9⟭ [⟬date#1⟭ 02:09:58 +0100] "POST /tech/connexion HTTP/1.1" 200 642 cpe="-" oui=- cr_user=- cr_pass="-"
⟬ip_address#14⟭ ⟬person_name:handle#9⟭ [⟬date#1⟭ 02:10:05 +0100] "GET /tech/box/⟬hash#7⟭/parametres?jeton=⟬jwt#9⟭ HTTP/1.1" 200 8120 cpe="⟬hash#7⟭" oui=⟬customer_id#3⟭ cr_user=- cr_pass="-"
⟬ip_address#5⟭ - [⟬date#1⟭ 02:10:30 +0100] "GET /supervision/ping HTTP/1.1" 200 2 cpe="-" oui=- cr_user=- cr_pass="-"
⟬ip_address#15⟭ acs [⟬date#1⟭ 02:11:02 +0100] "POST /acs HTTP/1.1" 200 412 cpe="⟬hash#9⟭" oui=⟬customer_id#1⟭ cr_user=⟬trap:indicator_non_pii|acs-box⟭ cr_pass="⟬password#9⟭"
⟬ip_address#15⟭ acs [⟬date#1⟭ 02:11:04 +0100] "POST /acs HTTP/1.1" 204 0 cpe="⟬hash#9⟭" oui=⟬customer_id#1⟭ cr_user=⟬trap:indicator_non_pii|acs-box⟭ cr_pass="⟬password#9⟭"
⟬ip_address#16⟭ - [⟬date#1⟭ 02:12:00 +0100] "GET /firmware/box-v5-⟬version#1⟭.bin HTTP/1.1" 206 1048576 cpe="-" oui=- cr_user=- cr_pass="-"
⟬ip_address#5⟭ - [⟬date#1⟭ 02:13:30 +0100] "GET /supervision/ping HTTP/1.1" 200 2 cpe="-" oui=- cr_user=- cr_pass="-"
⟬ip_address#17⟭ acs [⟬date#1⟭ 02:14:11 +0100] "POST /acs HTTP/1.1" 200 412 cpe="⟬hash#10⟭" oui=⟬customer_id#2⟭ cr_user=⟬trap:indicator_non_pii|acs-box⟭ cr_pass="⟬password#10⟭"
⟬ip_address#18⟭ acs [⟬date#1⟭ 02:14:40 +0100] "POST /acs HTTP/1.1" 500 188 cpe="⟬hash#11⟭" oui=⟬customer_id#3⟭ cr_user=⟬trap:indicator_non_pii|acs-box⟭ cr_pass="⟬password#11⟭"
⟬ip_address#18⟭ acs [⟬date#1⟭ 02:14:52 +0100] "POST /acs HTTP/1.1" 200 412 cpe="⟬hash#11⟭" oui=⟬customer_id#3⟭ cr_user=⟬trap:indicator_non_pii|acs-box⟭ cr_pass="⟬password#11⟭"
⟬ip_address#14⟭ ⟬person_name:handle#9⟭ [⟬date#1⟭ 02:15:03 +0100] "POST /tech/box/⟬hash#7⟭/redemarrer?jeton=⟬jwt#9⟭ HTTP/1.1" 202 64 cpe="⟬hash#7⟭" oui=⟬customer_id#3⟭ cr_user=- cr_pass="-"
⟬ip_address#5⟭ - [⟬date#1⟭ 02:16:30 +0100] "GET /supervision/ping HTTP/1.1" 200 2 cpe="-" oui=- cr_user=- cr_pass="-"
⟬ip_address#19⟭ acs [⟬date#1⟭ 02:17:02 +0100] "POST /acs HTTP/1.1" 200 412 cpe="⟬hash#12⟭" oui=⟬customer_id#2⟭ cr_user=⟬trap:indicator_non_pii|acs-box⟭ cr_pass="⟬password#12⟭"
⟬ip_address#20⟭ - [⟬date#1⟭ 02:18:00 +0100] "GET /firmware/box-v5-⟬version#1⟭.bin HTTP/1.1" 200 41820044 cpe="-" oui=- cr_user=- cr_pass="-"
⟬ip_address#5⟭ - [⟬date#1⟭ 02:19:30 +0100] "GET /supervision/ping HTTP/1.1" 200 2 cpe="-" oui=- cr_user=- cr_pass="-"
⟬ip_address#21⟭ acs [⟬date#1⟭ 02:20:04 +0100] "POST /acs HTTP/1.1" 200 412 cpe="⟬hash#13⟭" oui=⟬customer_id#1⟭ cr_user=⟬trap:indicator_non_pii|acs-box⟭ cr_pass="⟬password#13⟭"
⟬ip_address#21⟭ acs [⟬date#1⟭ 02:20:06 +0100] "POST /acs/telechargement?token=⟬opaque_token#13⟭ HTTP/1.1" 200 96 cpe="⟬hash#13⟭" oui=⟬customer_id#1⟭ cr_user=- cr_pass="-"
⟬ip_address#22⟭ - [⟬date#1⟭ 02:21:00 +0100] "GET /.env HTTP/1.1" 404 153 cpe="-" oui=- cr_user=- cr_pass="-"
⟬ip_address#22⟭ - [⟬date#1⟭ 02:21:01 +0100] "GET /admin HTTP/1.1" 404 153 cpe="-" oui=- cr_user=- cr_pass="-"
⟬ip_address#5⟭ - [⟬date#1⟭ 02:22:30 +0100] "GET /supervision/ping HTTP/1.1" 200 2 cpe="-" oui=- cr_user=- cr_pass="-"
⟬ip_address#14⟭ ⟬person_name:handle#9⟭ [⟬date#1⟭ 02:23:12 +0100] "GET /tech/box/⟬hash#7⟭/journal?jeton=⟬jwt#9⟭ HTTP/1.1" 200 12044 cpe="⟬hash#7⟭" oui=⟬customer_id#3⟭ cr_user=- cr_pass="-"
⟬ip_address#14⟭ ⟬person_name:handle#9⟭ [⟬date#1⟭ 02:24:50 +0100] "POST /tech/deconnexion HTTP/1.1" 204 0 cpe="-" oui=- cr_user=- cr_pass="-"
⟬ip_address#5⟭ - [⟬date#1⟭ 02:25:30 +0100] "GET /supervision/ping HTTP/1.1" 200 2 cpe="-" oui=- cr_user=- cr_pass="-"
⟬ip_address#23⟭ acs [⟬date#1⟭ 02:26:02 +0100] "POST /acs HTTP/1.1" 200 412 cpe="⟬hash#14⟭" oui=⟬customer_id#2⟭ cr_user=⟬trap:indicator_non_pii|acs-box⟭ cr_pass="⟬password#14⟭"
⟬ip_address#24⟭ acs [⟬date#1⟭ 02:27:15 +0100] "POST /acs HTTP/1.1" 200 412 cpe="⟬hash#15⟭" oui=⟬customer_id#3⟭ cr_user=⟬trap:indicator_non_pii|acs-box⟭ cr_pass="⟬password#15⟭"
⟬ip_address#5⟭ - [⟬date#1⟭ 02:28:30 +0100] "GET /supervision/ping HTTP/1.1" 200 2 cpe="-" oui=- cr_user=- cr_pass="-"
⟬ip_address#25⟭ acs [⟬date#1⟭ 02:29:04 +0100] "POST /acs HTTP/1.1" 200 412 cpe="⟬hash#16⟭" oui=⟬customer_id#1⟭ cr_user=⟬trap:indicator_non_pii|acs-box⟭ cr_pass="⟬password#16⟭"
⟬ip_address#11⟭ ⟬trap:indicator_non_pii|user-campagne⟭ [⟬date#1⟭ 02:30:00 +0100] "GET /campagnes/⟬uuid#1⟭/etat HTTP/1.1" 200 188 cpe="-" oui=- cr_user=- cr_pass="-"
⟬ip_address#5⟭ - [⟬date#1⟭ 02:31:30 +0100] "GET /supervision/ping HTTP/1.1" 200 2 cpe="-" oui=- cr_user=- cr_pass="-"
⟬ip_address#26⟭ acs [⟬date#1⟭ 02:32:11 +0100] "POST /acs HTTP/1.1" 200 412 cpe="⟬hash#17⟭" oui=⟬customer_id#2⟭ cr_user=⟬trap:indicator_non_pii|acs-box⟭ cr_pass="⟬password#17⟭"
⟬ip_address#27⟭ acs [⟬date#1⟭ 02:33:40 +0100] "POST /acs HTTP/1.1" 200 412 cpe="⟬hash#18⟭" oui=⟬customer_id#3⟭ cr_user=⟬trap:indicator_non_pii|acs-box⟭ cr_pass="⟬password#18⟭"
⟬ip_address#5⟭ - [⟬date#1⟭ 02:34:30 +0100] "GET /supervision/ping HTTP/1.1" 200 2 cpe="-" oui=- cr_user=- cr_pass="-"
⟬ip_address#28⟭ acs [⟬date#1⟭ 02:35:02 +0100] "POST /acs HTTP/1.1" 200 412 cpe="⟬hash#19⟭" oui=⟬customer_id#1⟭ cr_user=⟬trap:indicator_non_pii|acs-box⟭ cr_pass="⟬password#19⟭"
⟬ip_address#29⟭ acs [⟬date#1⟭ 02:36:44 +0100] "POST /acs HTTP/1.1" 200 412 cpe="⟬hash#20⟭" oui=⟬customer_id#2⟭ cr_user=⟬trap:indicator_non_pii|acs-box⟭ cr_pass="⟬password#20⟭"
⟬ip_address#5⟭ - [⟬date#1⟭ 02:37:30 +0100] "GET /supervision/ping HTTP/1.1" 200 2 cpe="-" oui=- cr_user=- cr_pass="-"
⟬ip_address#11⟭ ⟬trap:indicator_non_pii|user-campagne⟭ [⟬date#1⟭ 02:40:00 +0100] "POST /campagnes/⟬uuid#1⟭/terminer HTTP/1.1" 200 96 cpe="-" oui=- cr_user=- cr_pass="-"
⟬ip_address#5⟭ - [⟬date#1⟭ 02:40:30 +0100] "GET /supervision/ping HTTP/1.1" 200 2 cpe="-" oui=- cr_user=- cr_pass="-"
⟬ip_address#30⟭ acs [⟬date#1⟭ 02:41:02 +0100] "POST /acs HTTP/1.1" 200 412 cpe="⟬hash#21⟭" oui=⟬customer_id#3⟭ cr_user=⟬trap:indicator_non_pii|acs-box⟭ cr_pass="⟬password#21⟭"
⟬ip_address#5⟭ - [⟬date#1⟭ 02:43:30 +0100] "GET /supervision/ping HTTP/1.1" 200 2 cpe="-" oui=- cr_user=- cr_pass="-"
⟬end⟭
