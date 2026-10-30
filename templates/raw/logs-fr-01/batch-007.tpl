⟬template⟭
family: logs
format: application log
language: fr
fill_locale: fr_FR
domain: insurance
appearance: Airflow task log, log field
scenario: Airflow task log loading claim declarations, with rejected lines quoting plate and licence
⟬text⟭
[⟬date#1⟭ 03:12:11] {taskinstance.py:1310} INFO - Starting attempt 1 of 3
[⟬date#1⟭ 03:12:14] {charger_sinistres.py:88} INFO - 18204 lignes lues depuis ⟬file_path#1⟭
[⟬date#1⟭ 03:12:19] {charger_sinistres.py:112} WARNING - ligne 412 rejetée: plaque ⟬fr_license_plate#1⟭ inconnue
[⟬date#1⟭ 03:12:19] {charger_sinistres.py:113} WARNING - ligne 977 rejetée: permis ⟬fr_driving_licence#2⟭ de longueur invalide
[⟬date#1⟭ 03:12:24] {taskinstance.py:1411} INFO - Marking task as SUCCESS. ⟬trap:indicator_non_pii|owner=data-sinistres⟭
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: fr
fill_locale: fr_FR
domain: banking
appearance: Android logcat crash, exception message
scenario: Android crash of a banking app, whose exception message shows the card being added to the wallet
⟬text⟭
E/AndroidRuntime( 2210): FATAL EXCEPTION: main
E/AndroidRuntime( 2210): Process: fr.banque.mobile, PID: 2210
E/AndroidRuntime( 2210): java.lang.IllegalStateException: ajout impossible, carte ⟬payment_card#1⟭ déjà enrôlée
E/AndroidRuntime( 2210): 	at fr.banque.mobile.wallet.AjoutCarteViewModel.valider(AjoutCarteViewModel.kt:88)
E/AndroidRuntime( 2210): 	at fr.banque.mobile.wallet.AjoutCarteFragment.onClick$lambda$2(AjoutCarteFragment.kt:41)
E/AndroidRuntime( 2210): 	at android.view.View.performClick(View.java:7506)
E/AndroidRuntime( 2210): 	at android.os.Handler.handleCallback(Handler.java:942)
⟬end⟭

⟬template⟭
family: logs
format: test output
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: Mocha output, product names
scenario: Mocha output for an online florist's shipping costs, whose bouquets carry given names, with no customer
⟬text⟭
  frais de port
    ✔ offerts dès 50 euros
    ✔ bouquet ⟬trap:word_name|Rose⟭ standard en 24 h
    ✔ bouquet ⟬trap:word_name|Violette⟭ en point relais
    1) bouquet ⟬trap:word_name|Marguerite⟭ le dimanche

  3 passing (14ms)
  1 failing

  1) frais de port
       bouquet ⟬trap:word_name|Marguerite⟭ le dimanche:
     AssertionError: expected 7.9 to equal 9.9
⟬end⟭

⟬template⟭
family: logs
format: access log
language: fr
fill_locale: fr_FR
domain: telecom
appearance: Kamailio accounting line, semicolon-separated fields, secret under an innocuous key
scenario: access lines of a SIP server, whose accounting module keeps caller and callee numbers, a line password and a terminal token
⟬text⟭
ACC: transaction answered: timestamp=1712023443;method=REGISTER;src_user=⟬phone#1⟭;auth_pw=⟬password#1⟭;src_ip=⟬ip_address#1⟭;code=200
ACC: transaction answered: timestamp=1712023451;method=INVITE;src_user=⟬phone#1⟭;dst_user=⟬phone#2⟭;src_ip=⟬ip_address#1⟭;code=200
ACC: transaction answered: timestamp=1712023466;method=BYE;src_user=⟬phone#2⟭;dst_user=⟬phone#1⟭;src_ip=⟬ip_address#2⟭;code=200
ACC: transaction answered: timestamp=1712023480;method=REGISTER;src_user=⟬phone#3⟭;x_ref=⟬opaque_token#3⟭;src_ip=⟬ip_address#3⟭;code=401
ACC: transaction answered: timestamp=1712023490;method=OPTIONS;⟬trap:indicator_non_pii|src_user=sonde-sbc⟭;x_ref=⟬uuid#1⟭;src_ip=⟬ip_address#4⟭;code=200
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: dbt run output, model names
scenario: dbt run of a hospital group's warehouse, whose pseudonymised models have telling column names, with no value
⟬text⟭
Running with dbt=⟬version#1⟭
Found 42 models, 118 tests, 12 sources
1 of 5 START sql table model staging.stg_venues ................. [RUN]
1 of 5 OK created sql table model staging.stg_venues ............ [SELECT 910221 in 12.41s]
2 of 5 START sql table model staging.⟬trap:indicator_non_pii|stg_patients_nom_masque⟭ ...... [RUN]
2 of 5 OK created sql table model staging.⟬trap:indicator_non_pii|stg_patients_nom_masque⟭ . [SELECT 182440 in 8.02s]
3 of 5 START sql table model marts.⟬trap:indicator_non_pii|dim_patient_nir_hache⟭ .......... [RUN]
3 of 5 OK created sql table model marts.⟬trap:indicator_non_pii|dim_patient_nir_hache⟭ ..... [SELECT 182440 in 6.77s]
Finished running 5 table models in 0 hours 0 minutes and 41.20 seconds.
Completed successfully
Done. PASS=5 WARN=0 ERROR=0 SKIP=0 TOTAL=5
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: fr
fill_locale: fr_FR
domain: public administration
appearance: RFC 5424 syslog, structured data
scenario: structured syslog messages of an ID documents service, whose structured data keep the agent, passport and NIR consulted
⟬text⟭
<134>1 ⟬date#1⟭ 10:12:03 srv-titres titres 412 ID47 [audit@32473 agent="⟬person_name#1⟭" passeport="⟬fr_passport#2⟭" nir="⟬fr_social_security_number#2⟭"] consultation du dossier
<134>1 ⟬date#1⟭ 10:13:40 srv-titres titres 412 ID47 [audit@32473 agent="⟬person_name#1⟭" passeport="⟬fr_passport#2⟭"] impression de la fiche
<134>1 ⟬date#1⟭ 10:14:02 srv-titres titres 412 ID12 [audit@32473 agent="⟬trap:indicator_non_pii|tache-archivage⟭" lot="⟬uuid#1⟭"] archivage
<131>1 ⟬date#1⟭ 10:20:51 srv-titres titres 412 ID90 [audit@32473 agent="⟬person_name#3⟭" passeport="⟬fr_passport#4⟭"] accès refusé, habilitation expirée
⟬end⟭

⟬template⟭
family: logs
format: application log
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: structlog output, key=value, quoted value
scenario: structlog log of a hospital pharmacy, tracing prescription dispensing with patient, NIR, birth date and prescriber
⟬text⟭
timestamp="⟬date#1⟭ 10:00:01" level=info event="ordonnance recue" ordonnance=⟬order_number#1⟭ service=oncologie
timestamp="⟬date#1⟭ 10:00:02" level=debug event="patient identifie" nom="⟬person_name#2⟭" nir="⟬fr_social_security_number#2⟭" naissance="⟬birth_date#2⟭"
timestamp="⟬date#1⟭ 10:00:02" level=info event="prescripteur verifie" prescripteur="Dr ⟬person_name#3⟭" rpps=⟬customer_id#3⟭
timestamp="⟬date#1⟭ 10:00:04" level=warning event="interaction possible" molecules="warfarine+aspirine" gravite=2
timestamp="⟬date#1⟭ 10:00:40" level=info event="validation pharmaceutique" pharmacien="⟬person_name#4⟭" decision=accepte
timestamp="⟬date#1⟭ 10:01:02" level=info event="preparation lancee" automate=robot-3 lot=⟬uuid#1⟭
timestamp="⟬date#1⟭ 10:03:15" level=info event="preparation terminee" lot=⟬uuid#1⟭ doses=14
timestamp="⟬date#1⟭ 10:03:16" level=info event="ordonnance recue" ordonnance=⟬order_number#5⟭ service=neurologie
timestamp="⟬date#1⟭ 10:03:17" level=debug event="patient identifie" nom="⟬person_name#5⟭" nir="⟬fr_social_security_number#5⟭" naissance="⟬birth_date#5⟭"
timestamp="⟬date#1⟭ 10:03:17" level=error event="poids manquant" ordonnance=⟬order_number#5⟭ action="retour au service"
timestamp="⟬date#1⟭ 10:03:18" level=info event="message envoye" destinataire=⟬email:generic#6⟭
timestamp="⟬date#1⟭ 10:10:00" level=info event="stock verifie" molecule=paracetamol quantite=4120
timestamp="⟬date#1⟭ 10:10:01" level=debug event="synchronisation" cible=⟬hostname#1⟭ ⟬trap:indicator_non_pii|user=svc_pharma⟭
timestamp="⟬date#1⟭ 10:15:02" level=info event="ordonnance recue" ordonnance=⟬order_number#7⟭ service=cardiologie
timestamp="⟬date#1⟭ 10:15:03" level=debug event="patient identifie" nom="⟬person_name#7⟭" nir="⟬fr_social_security_number#7⟭" naissance="⟬birth_date#7⟭"
timestamp="⟬date#1⟭ 10:15:40" level=info event="validation pharmaceutique" pharmacien="⟬trap:indicator_non_pii|interne-garde⟭" decision=accepte
timestamp="⟬date#1⟭ 10:30:00" level=info event="bilan" ordonnances=3 rejets=1
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: Node.js unhandled rejection, payment provider error, object dump
scenario: unhandled rejection of a Node payment service, whose provider error shows the secret key, the customer's card and an opaque reference
⟬text⟭
node:internal/process/promises:288
            triggerUncaughtException(err, true /* fromPromise */);
            ^

StripeCardError: Your card was declined.
    at generateV1Error (/app/node_modules/stripe/cjs/Error.js:8:20)
    at res.toJSON.then.StripeAPIError.message (/app/node_modules/stripe/cjs/RequestSender.js:105:31)
    at process.processTicksAndRejections (node:internal/process/task_queues:95:5) {
  type: 'StripeCardError',
  rawType: 'card_error',
  code: 'card_declined',
  decline_code: 'insufficient_funds',
  requestId: '⟬uuid#1⟭',
  headers: {
    server: 'nginx',
    'request-id': '⟬uuid#1⟭',
    authorization: 'Bearer ⟬stripe_secret_key#1⟭'
  },
  contexte: {
    commande: '⟬order_number#1⟭',
    client: "⟬person_name#2⟭",
    carte: '⟬payment_card#2⟭',
    ref: '⟬opaque_token#1⟭'
  },
  statusCode: 402
}

Node.js v20.10.0
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: fr
fill_locale: fr_FR
domain: telecom
appearance: gdb backtrace, core dump, code identifier
scenario: gdb analysis of an operator media gateway core file, with eponymous codec functions and no subscriber
⟬text⟭
$ gdb /usr/sbin/mgw core.31244
GNU gdb (GDB) 13.2
Reading symbols from /usr/sbin/mgw...
[New LWP 31244]
[New LWP 31250]
Core was generated by `/usr/sbin/mgw --conf /etc/mgw/mgw.conf'.
Program terminated with signal SIGSEGV, Segmentation fault.
#0  0x00007f8a1c0c2ed8 in ⟬trap:code_identifier|viterbi_decode⟭ (etat=0x0, trame=0x7f8a0c001200) at codec/fec.c:412
412	    etat->chemin[i] = meilleur;
(gdb) bt
#0  0x00007f8a1c0c2ed8 in ⟬trap:code_identifier|viterbi_decode⟭ (etat=0x0, trame=0x7f8a0c001200) at codec/fec.c:412
#1  0x00007f8a1c0c31a0 in ⟬trap:code_identifier|reed_solomon_corriger⟭ (bloc=0x7f8a0c001200) at codec/fec.c:188
#2  0x000055d0c8a14c20 in ⟬trap:code_identifier|flux_⦃family⦄_lire⟭ (canal=42) at rtp/flux.c:301
#3  0x000055d0c8a13b08 in boucle_canal (arg=0x55d0c9f00010) at rtp/boucle.c:77
#4  0x00007f8a1b2d4ac3 in start_thread () from /lib/x86_64-linux-gnu/libc.so.6
(gdb) info locals
meilleur = 3
i = 128
⟬trap:indicator_non_pii|user_id = 0⟭
(gdb) frame 2
#2  0x000055d0c8a14c20 in ⟬trap:code_identifier|flux_⦃family⦄_lire⟭ (canal=42) at rtp/flux.c:301
301	    ⟬trap:code_identifier|viterbi_decode⟭(canal_etat(canal), tampon);
(gdb) quit
⟬end⟭

⟬template⟭
family: logs
format: test output
language: fr
fill_locale: fr_FR
domain: banking
appearance: Spock condition diagram, object dump
scenario: Spock output of a transfer service, whose condition diagram prints the test account, the two compared IBANs and the card
⟬text⟭
Condition not satisfied:

compte.iban == attendu
|      |    |  |
|      |    |  ⟬iban#2⟭
|      |    false
|      ⟬iban#1⟭
Compte(titulaire:⟬person_name#1⟭, solde:1200.00, bic:⟬bic#1⟭)

	at fr.banque.virement.CompteSpec.conserve l'IBAN apres renommage(CompteSpec.groovy:44)

Condition not satisfied:

carte.pan.endsWith("1111")
|     |   |
|     |   false
|     ⟬payment_card#1⟭
Carte(porteur:⟬person_name#1⟭, cvv:⟬card_security_code#1⟭, statut:ACTIVE)

	at fr.banque.virement.CompteSpec.masque la carte(CompteSpec.groovy:61)

2 tests completed, 2 failed
⟬end⟭

⟬template⟭
family: logs
format: access log
language: fr
fill_locale: fr_FR
domain: banking
appearance: ASP.NET Core request log, OAuth callback, query string
scenario: Kestrel request traces of a banking portal, where the OAuth callback keeps the authorization code, an access JWT and a session reference
⟬text⟭
info: Microsoft.AspNetCore.Hosting.Diagnostics[1]
      Request starting HTTP/2 GET https://⟬hostname#1⟭/oauth/callback?code=⟬opaque_token#1⟭&state=⟬uuid#1⟭ - - -
info: Microsoft.AspNetCore.Hosting.Diagnostics[2]
      Request finished HTTP/2 GET https://⟬hostname#1⟭/oauth/callback?code=⟬opaque_token#1⟭&state=⟬uuid#1⟭ - 302 0 - 84.2011ms
info: Microsoft.AspNetCore.Hosting.Diagnostics[1]
      Request starting HTTP/2 GET https://⟬hostname#1⟭/espace/accueil - - -
info: Banque.Portail.Filtres.JournalJeton[0]
      Jeton d'accès reçu: ⟬jwt#1⟭
info: Microsoft.AspNetCore.Hosting.Diagnostics[2]
      Request finished HTTP/2 GET https://⟬hostname#1⟭/espace/accueil - 200 18422 text/html 141.8040ms
info: Microsoft.AspNetCore.Hosting.Diagnostics[1]
      Request starting HTTP/2 POST https://⟬hostname#1⟭/espace/session/prolonger?ref=⟬opaque_token#2⟭ - application/json 88
info: Microsoft.AspNetCore.Hosting.Diagnostics[2]
      Request finished HTTP/2 POST https://⟬hostname#1⟭/espace/session/prolonger?ref=⟬opaque_token#2⟭ - 204 0 - 12.3045ms
info: Microsoft.AspNetCore.Hosting.Diagnostics[1]
      Request starting HTTP/1.1 GET http://localhost:8080/sante - - -
info: Microsoft.AspNetCore.Hosting.Diagnostics[2]
      Request finished HTTP/1.1 GET http://localhost:8080/sante - 200 2 text/plain 0.8120ms
⟬end⟭

⟬template⟭
family: logs
format: access log
language: fr
fill_locale: fr_FR
domain: insurance
appearance: ingress-nginx log, captured header, upstream field
scenario: ingress-nginx access of a car insurer's mobile app, keeping in a search header the plate or licence entered by the customer
⟬text⟭
⟬ip_address#1⟭ - - [⟬date#1⟭ 12:41:02 +0000] "GET /mobile/contrats HTTP/2.0" 200 2204 "-" "Assur/4.2 (iOS)" 188 0.041 [assur-mobile-8080] [] ⟬hostname#1⟭:8080 2204 0.041 200 ⟬uuid#1⟭ x-recherche="-"
⟬ip_address#1⟭ - - [⟬date#1⟭ 12:41:19 +0000] "POST /mobile/recherche HTTP/2.0" 200 412 "-" "Assur/4.2 (iOS)" 244 0.088 [assur-mobile-8080] [] ⟬hostname#1⟭:8080 412 0.088 200 ⟬uuid#2⟭ x-recherche="immat:⟬fr_license_plate#1⟭"
⟬ip_address#1⟭ - - [⟬date#1⟭ 12:41:44 +0000] "POST /mobile/recherche HTTP/2.0" 200 412 "-" "Assur/4.2 (iOS)" 241 0.092 [assur-mobile-8080] [] ⟬hostname#1⟭:8080 412 0.092 200 ⟬uuid#3⟭ x-recherche="permis:⟬fr_driving_licence#1⟭"
⟬ip_address#2⟭ - - [⟬date#1⟭ 12:42:10 +0000] "GET /mobile/garages?ville=⟬city#1⟭ HTTP/2.0" 200 8120 "-" "Assur/4.1 (Android)" 201 0.061 [assur-mobile-8080] [] ⟬hostname#2⟭:8080 8120 0.061 200 ⟬uuid#4⟭ x-recherche="-"
⟬ip_address#2⟭ - - [⟬date#1⟭ 12:42:31 +0000] "POST /mobile/recherche HTTP/2.0" 404 96 "-" "Assur/4.1 (Android)" 239 0.074 [assur-mobile-8080] [] ⟬hostname#2⟭:8080 96 0.074 404 ⟬uuid#5⟭ x-recherche="immat:⟬fr_license_plate#2⟭"
⟬ip_address#3⟭ - - [⟬date#1⟭ 12:43:02 +0000] "GET /healthz HTTP/1.1" 200 2 "-" "kube-probe/1.28" 92 0.001 [assur-mobile-8080] [] ⟬hostname#1⟭:8080 2 0.001 200 ⟬uuid#6⟭ x-recherche="-"
⟬ip_address#4⟭ - - [⟬date#1⟭ 12:43:40 +0000] "POST /mobile/declaration HTTP/2.0" 201 188 "-" "Assur/4.2 (iOS)" 4120 0.311 [assur-mobile-8080] [] ⟬hostname#2⟭:8080 188 0.311 201 ⟬uuid#7⟭ x-recherche="immat:⟬fr_license_plate#3⟭;permis:⟬fr_driving_licence#3⟭"
⟬ip_address#4⟭ - - [⟬date#1⟭ 12:44:05 +0000] "GET /mobile/declaration/⟬uuid#8⟭ HTTP/2.0" 200 1204 "-" "Assur/4.2 (iOS)" 188 0.052 [assur-mobile-8080] [] ⟬hostname#2⟭:8080 1204 0.052 200 ⟬uuid#9⟭ x-recherche="-"
⟬ip_address#5⟭ - - [⟬date#1⟭ 12:44:40 +0000] "POST /mobile/recherche HTTP/2.0" 200 412 "-" "Assur/4.2 (Android)" 241 0.071 [assur-mobile-8080] [] ⟬hostname#1⟭:8080 412 0.071 200 ⟬uuid#10⟭ x-recherche="⟬trap:indicator_non_pii|client=exemple⟭"
⟬ip_address#5⟭ - - [⟬date#1⟭ 12:45:02 +0000] "POST /mobile/recherche HTTP/2.0" 200 412 "-" "Assur/4.2 (Android)" 243 0.069 [assur-mobile-8080] [] ⟬hostname#1⟭:8080 412 0.069 200 ⟬uuid#11⟭ x-recherche="immat:⟬fr_license_plate#4⟭"
⟬ip_address#3⟭ - - [⟬date#1⟭ 12:45:30 +0000] "GET /healthz HTTP/1.1" 200 2 "-" "kube-probe/1.28" 92 0.001 [assur-mobile-8080] [] ⟬hostname#2⟭:8080 2 0.001 200 ⟬uuid#12⟭ x-recherche="-"
⟬ip_address#6⟭ - - [⟬date#1⟭ 12:46:02 +0000] "GET /mobile/mentions HTTP/2.0" 200 3120 "-" "Assur/4.2 (iOS)" 188 0.012 [assur-mobile-8080] [] ⟬hostname#1⟭:8080 3120 0.012 200 ⟬uuid#13⟭ x-recherche="-"
⟬ip_address#7⟭ - - [⟬date#1⟭ 12:46:44 +0000] "POST /mobile/recherche HTTP/2.0" 200 412 "-" "Assur/4.0 (Android)" 240 0.076 [assur-mobile-8080] [] ⟬hostname#2⟭:8080 412 0.076 200 ⟬uuid#14⟭ x-recherche="permis:⟬fr_driving_licence#5⟭"
⟬ip_address#3⟭ - - [⟬date#1⟭ 12:47:00 +0000] "GET /healthz HTTP/1.1" 200 2 "-" "kube-probe/1.28" 92 0.001 [assur-mobile-8080] [] ⟬hostname#1⟭:8080 2 0.001 200 ⟬uuid#15⟭ x-recherche="-"
⟬ip_address#8⟭ - - [⟬date#1⟭ 12:47:30 +0000] "GET /mobile/contrats HTTP/2.0" 401 88 "-" "Assur/3.9 (Android)" 188 0.004 [assur-mobile-8080] [] ⟬hostname#2⟭:8080 88 0.004 401 ⟬uuid#16⟭ x-recherche="-"
⟬ip_address#8⟭ - - [⟬date#1⟭ 12:47:58 +0000] "POST /mobile/connexion HTTP/2.0" 200 642 "-" "Assur/3.9 (Android)" 241 0.204 [assur-mobile-8080] [] ⟬hostname#2⟭:8080 642 0.204 200 ⟬uuid#17⟭ x-recherche="-"
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: fr
fill_locale: fr_FR
domain: insurance
appearance: Woodpecker step log, private key in a job log, git remote with token, seed output
scenario: Woodpecker pipeline of a claims application, printing an SSH key, a GitHub token, a test JWT and a test policyholder's data
⟬text⟭
+ git clone https://x-access-token:⟬github_token#1⟭@github.com/assureur-exemple/sinistres.git .
Cloning into '.'...
+ mkdir -p ~/.ssh
+ echo "⟬trap:placeholder|$DEPLOY_KEY⟭" > ~/.ssh/id_deploy
+ cat ~/.ssh/id_deploy
⟬private_key#1⟭
+ chmod 600 ~/.ssh/id_deploy
+ ssh-keyscan ⟬hostname#1⟭ >> ~/.ssh/known_hosts
# ⟬hostname#1⟭:22 SSH-2.0-OpenSSH_9.3
+ export RECETTE_PASSWORD=⟬password#1⟭
+ export RECETTE_JETON=⟬jwt#1⟭
+ python manage.py creer_assure_recette
assuré de recette créé: "⟬person_name#2⟭"
véhicule ⟬fr_license_plate#2⟭, permis ⟬fr_driving_licence#2⟭
contrat ⟬customer_id#2⟭ actif
+ pytest tests/recette -q
................ [100%]
16 passed in 3.41s
+ rsync -az dist/ ⟬trap:email_lookalike|deploy@recette⟭:/srv/sinistres/
sending incremental file list
sent 41,204 bytes  received 812 bytes
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: fr
fill_locale: fr_FR
domain: public administration
appearance: OWASP ZAP baseline output, alert names
scenario: ZAP baseline scan of a procedures portal, whose alerts talk about passwords and cookies without ever holding a value
⟬text⟭
$ zap-baseline.py -t ⟬url#1⟭ -r rapport.html
Total of 42 URLs
PASS: Vulnerable JS Library [10003]
PASS: Cookie No HttpOnly Flag [10010]
PASS: Cookie Without Secure Flag [10011]
PASS: ⟬trap:indicator_non_pii|Password Autocomplete in Browser⟭ [10012]
PASS: Incomplete or No Cache-control Header Set [10015]
PASS: Private IP Disclosure [2]
PASS: ⟬trap:indicator_non_pii|Session ID in URL Rewrite⟭ [3]
PASS: ⟬trap:indicator_non_pii|Username Hash Found⟭ [10057]
PASS: ⟬trap:indicator_non_pii|Authentication Credentials Captured⟭ [10105]
WARN-NEW: Content Security Policy (CSP) Header Not Set [10038] x 3
	⟬url#1⟭ (200 OK)
	⟬url#2⟭ (200 OK)
	⟬url#3⟭ (200 OK)
WARN-NEW: Information Disclosure - Suspicious Comments [10027] x 1
	⟬url#4⟭ (200 OK)
FAIL-NEW: 0	FAIL-INPROG: 0	WARN-NEW: 2	WARN-INPROG: 0	INFO: 0	IGNORE: 0	PASS: 39
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: fr
fill_locale: fr_FR
domain: e-commerce
appearance: multi-line audit record, YAML-like fields, quoted value
scenario: multi-line audit records of a marketplace back office, detailing who did what on customers, cards and sellers
⟬text⟭
---
quand: ⟬date#1⟭ 10:12:04
qui: "⟬person_name#1⟭"
quoi: remboursement_partiel
commande: ⟬order_number#2⟭
carte: ⟬payment_card#2⟭
montant: 18.90
---
quand: ⟬date#1⟭ 10:30:47
qui: ⟬trap:indicator_non_pii|moteur-promotions⟭
quoi: coupon_cree
coupon: ⟬uuid#1⟭
---
quand: ⟬date#1⟭ 10:44:18
qui: "⟬person_name#3⟭"
quoi: compte_vendeur_valide
vendeur: ⟬company#4⟭
siret: ⟬fr_siret#4⟭
siege: "⟬fr_postal_address#4⟭"
---
quand: ⟬date#1⟭ 11:02:33
qui: "⟬person_name#1⟭"
quoi: jeton_client_reinitialise
client: ⟬customer_id#2⟭
jeton: ⟬jwt#2⟭
---
quand: ⟬date#1⟭ 11:15:09
qui: ⟬trap:indicator_non_pii|equipe-fraude⟭
quoi: compte_suspendu
client: ⟬customer_id#5⟭
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: fr
fill_locale: fr_FR
domain: banking
appearance: bastion session log, keystrokes, value alone on a line
scenario: keystroke log of a banking bastion, where the operator types a password alone on its line and looks up a customer account in the database
⟬text⟭
session ⟬uuid#1⟭ ouverte par ⟬person_name:handle#1⟭ depuis ⟬ip_address#1⟭ vers ⟬hostname#1⟭
compte cible=⟬trap:indicator_non_pii|oracle⟭ coffre=exploitation motif=⟬ticket_id#1⟭
[09:02:11] sqlplus bo_exploit@BANQ
[09:02:15] Enter password:
[09:02:19] ⟬password#2⟭
[09:02:31] select titulaire from comptes where iban = '⟬iban#3⟭';
[09:02:32] ⟬person_name#3⟭
[09:02:58] select count(*) from virements where statut = 'BLOQUE';
[09:02:59] 12
[09:03:20] exit
[09:03:41] sudo systemctl restart virements
[09:03:44] [sudo] ⟬trap:indicator_non_pii|password for oracle⟭:
[09:03:48] ⟬password#4⟭
[09:04:02] systemctl status virements
[09:04:03] Active: active (running)
[09:04:30] exit
session ⟬uuid#1⟭ fermée, durée 139 s, enregistrement ⟬file_path#1⟭
⟬end⟭

⟬template⟭
family: logs
format: application log
language: fr
fill_locale: fr_FR
domain: public administration
appearance: Celery worker log, quoted value, log field
scenario: background task log of a naturalisation service, following each file with identity, reference passport, birth date and address
⟬text⟭
[⟬date#1⟭ 07:00:00,014: INFO/MainProcess] Connected to redis://⟬hostname#1⟭:6379/0
[⟬date#1⟭ 07:00:00,120: INFO/MainProcess] mingle: all alone
[⟬date#1⟭ 07:00:00,431: INFO/MainProcess] celery@⟬hostname#2⟭ ready.
[⟬date#1⟭ 07:00:05,002: INFO/ForkPoolWorker-1] Task dossiers.instruire[⟬uuid#1⟭] received
[⟬date#1⟭ 07:00:05,118: INFO/ForkPoolWorker-1] dossier ⟬ticket_id#1⟭: demandeur "⟬person_name#2m⟭" né le ⟬birth_date#2⟭
[⟬date#1⟭ 07:00:05,119: INFO/ForkPoolWorker-1] dossier ⟬ticket_id#1⟭: passeport ⟬fr_passport#2⟭, pays d'origine ⟬country#2⟭
[⟬date#1⟭ 07:00:05,202: INFO/ForkPoolWorker-1] dossier ⟬ticket_id#1⟭: résidence "⟬fr_postal_address#2⟭"
[⟬date#1⟭ 07:00:06,410: WARNING/ForkPoolWorker-1] dossier ⟬ticket_id#1⟭: pièce manquante, acte de naissance traduit
[⟬date#1⟭ 07:00:06,411: INFO/ForkPoolWorker-1] Task dossiers.instruire[⟬uuid#1⟭] succeeded in 1.40s
[⟬date#1⟭ 07:00:09,020: INFO/ForkPoolWorker-2] Task dossiers.instruire[⟬uuid#3⟭] received
[⟬date#1⟭ 07:00:09,101: INFO/ForkPoolWorker-2] dossier ⟬ticket_id#3⟭: demandeuse "⟬person_name#3f⟭" née le ⟬birth_date#3⟭
[⟬date#1⟭ 07:00:09,102: INFO/ForkPoolWorker-2] dossier ⟬ticket_id#3⟭: passeport ⟬fr_passport#3⟭, pays d'origine ⟬country#3⟭
[⟬date#1⟭ 07:00:09,188: INFO/ForkPoolWorker-2] dossier ⟬ticket_id#3⟭: conjoint "⟬person_name#4m⟭", NIR ⟬fr_social_security_number#4⟭
[⟬date#1⟭ 07:00:09,904: INFO/ForkPoolWorker-2] dossier ⟬ticket_id#3⟭: communauté de vie vérifiée
[⟬date#1⟭ 07:00:10,002: INFO/ForkPoolWorker-2] dossier ⟬ticket_id#3⟭: convocation à l'entretien, agent ⟬person_name#5⟭
[⟬date#1⟭ 07:00:10,110: INFO/ForkPoolWorker-2] Task dossiers.instruire[⟬uuid#3⟭] succeeded in 1.09s
[⟬date#1⟭ 07:00:14,330: INFO/ForkPoolWorker-1] Task dossiers.instruire[⟬uuid#4⟭] received
[⟬date#1⟭ 07:00:14,412: INFO/ForkPoolWorker-1] dossier ⟬ticket_id#4⟭: demandeur "⟬person_name#6m⟭" né le ⟬birth_date#6⟭
[⟬date#1⟭ 07:00:14,413: ERROR/ForkPoolWorker-1] dossier ⟬ticket_id#4⟭: passeport ⟬fr_passport#6⟭ signalé invalide
[⟬date#1⟭ 07:00:14,420: INFO/ForkPoolWorker-1] dossier ⟬ticket_id#4⟭: transmis à ⟬trap:indicator_non_pii|responsable=cellule-fraude⟭
[⟬date#1⟭ 07:00:14,431: INFO/ForkPoolWorker-1] Task dossiers.instruire[⟬uuid#4⟭] succeeded in 0.10s
[⟬date#1⟭ 07:01:00,000: INFO/Beat] Scheduler: Sending due task purge-sessions
[⟬date#1⟭ 07:01:00,214: INFO/ForkPoolWorker-3] Task maintenance.purge[⟬uuid#5⟭] succeeded in 0.21s
[⟬date#1⟭ 07:02:18,040: INFO/ForkPoolWorker-1] Task courriers.generer[⟬uuid#6⟭] received
[⟬date#1⟭ 07:02:18,512: INFO/ForkPoolWorker-1] courrier d'accusé de réception pour "⟬person_name#2⟭"
[⟬date#1⟭ 07:02:18,513: INFO/ForkPoolWorker-1] envoi à ⟬email#2⟭
[⟬date#1⟭ 07:02:19,120: INFO/ForkPoolWorker-1] Task courriers.generer[⟬uuid#6⟭] succeeded in 1.08s
[⟬date#1⟭ 07:03:02,204: INFO/ForkPoolWorker-2] Task courriers.generer[⟬uuid#7⟭] received
[⟬date#1⟭ 07:03:02,714: INFO/ForkPoolWorker-2] convocation pour "⟬person_name#3f⟭", SMS au ⟬phone#3⟭
[⟬date#1⟭ 07:03:03,040: INFO/ForkPoolWorker-2] Task courriers.generer[⟬uuid#7⟭] succeeded in 0.84s
[⟬date#1⟭ 07:05:00,000: INFO/Beat] Scheduler: Sending due task synchro-referentiels
[⟬date#1⟭ 07:05:01,102: INFO/ForkPoolWorker-3] référentiel des pays à jour, version ⟬version#1⟭
[⟬date#1⟭ 07:05:01,103: INFO/ForkPoolWorker-3] Task maintenance.synchro[⟬uuid#8⟭] succeeded in 1.10s
[⟬date#1⟭ 07:10:04,014: INFO/ForkPoolWorker-1] Task dossiers.instruire[⟬uuid#9⟭] received
[⟬date#1⟭ 07:10:04,120: INFO/ForkPoolWorker-1] dossier ⟬ticket_id#9⟭: demandeuse "⟬person_name#9f⟭" née le ⟬birth_date#9⟭
[⟬date#1⟭ 07:10:04,121: INFO/ForkPoolWorker-1] dossier ⟬ticket_id#9⟭: passeport ⟬fr_passport#9⟭, pays d'origine ⟬country#9⟭
[⟬date#1⟭ 07:10:04,180: INFO/ForkPoolWorker-1] dossier ⟬ticket_id#9⟭: employeur ⟬company#9⟭, contrat depuis ⟬date#2⟭
[⟬date#1⟭ 07:10:04,920: INFO/ForkPoolWorker-1] dossier ⟬ticket_id#9⟭: niveau de langue B1 attesté
[⟬date#1⟭ 07:10:05,004: INFO/ForkPoolWorker-1] Task dossiers.instruire[⟬uuid#9⟭] succeeded in 0.99s
[⟬date#1⟭ 07:15:00,000: INFO/Beat] Scheduler: Sending due task bilan-horaire
[⟬date#1⟭ 07:15:00,410: INFO/ForkPoolWorker-3] 4 dossiers instruits, 1 signalé
[⟬date#1⟭ 07:15:00,411: INFO/ForkPoolWorker-3] rapport écrit dans ⟬file_path#1⟭
[⟬date#1⟭ 07:20:12,044: INFO/ForkPoolWorker-2] Task dossiers.instruire[⟬uuid#10⟭] received
[⟬date#1⟭ 07:20:12,140: INFO/ForkPoolWorker-2] dossier ⟬ticket_id#10⟭: demandeur "⟬person_name#10m⟭" né le ⟬birth_date#10⟭
[⟬date#1⟭ 07:20:12,141: INFO/ForkPoolWorker-2] dossier ⟬ticket_id#10⟭: titre de séjour en cours de validité, passeport ⟬fr_passport#10⟭
[⟬date#1⟭ 07:20:12,210: INFO/ForkPoolWorker-2] dossier ⟬ticket_id#10⟭: casier judiciaire vierge
[⟬date#1⟭ 07:20:12,890: INFO/ForkPoolWorker-2] dossier ⟬ticket_id#10⟭: décision proposée par ⟬person_name#5⟭
[⟬date#1⟭ 07:20:13,002: INFO/ForkPoolWorker-2] Task dossiers.instruire[⟬uuid#10⟭] succeeded in 0.96s
[⟬date#1⟭ 07:30:00,000: INFO/Beat] Scheduler: Sending due task purge-sessions
[⟬date#1⟭ 07:30:00,190: INFO/ForkPoolWorker-3] Task maintenance.purge[⟬uuid#11⟭] succeeded in 0.19s
[⟬date#1⟭ 07:45:00,000: INFO/Beat] Scheduler: Sending due task sonde
[⟬date#1⟭ 07:45:00,044: INFO/ForkPoolWorker-3] base joignable, file vide
[⟬date#1⟭ 08:00:00,000: INFO/Beat] Scheduler: Sending due task bilan-horaire
[⟬date#1⟭ 08:00:00,402: INFO/ForkPoolWorker-3] 5 dossiers instruits, 1 signalé
[⟬date#1⟭ 08:00:00,403: INFO/ForkPoolWorker-3] rapport écrit dans ⟬file_path#1⟭
[⟬date#1⟭ 08:15:00,000: INFO/Beat] Scheduler: Sending due task sonde
[⟬date#1⟭ 08:15:00,041: INFO/ForkPoolWorker-3] base joignable, file vide
[⟬date#1⟭ 08:30:00,000: INFO/Beat] Scheduler: Sending due task purge-sessions
[⟬date#1⟭ 08:30:00,204: INFO/ForkPoolWorker-3] Task maintenance.purge[⟬uuid#12⟭] succeeded in 0.20s
[⟬date#1⟭ 08:45:00,000: INFO/Beat] Scheduler: Sending due task sonde
[⟬date#1⟭ 08:45:00,040: INFO/ForkPoolWorker-3] base joignable, file vide
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: fr
fill_locale: fr_FR
domain: insurance
appearance: pandas error, DataFrame dump, Python traceback, value without a key
scenario: traceback of a pandas car pricing script, showing an extract of the DataFrame with plates, licences and drivers just before crashing
⟬text⟭
$ python scripts/recalcul_primes.py --mois courant
INFO version du bareme ⟬version#1⟭
INFO connexion a ⟬hostname#1⟭, ⟬trap:indicator_non_pii|user=tarif_lecture⟭
INFO lecture de ⟬file_path#1⟭
INFO 41204 contrats charges
INFO apercu du DataFrame avant jointure:
         contrat           plaque             permis            conducteur  crm
0   ⟬customer_id#1⟭  ⟬fr_license_plate#1⟭  ⟬fr_driving_licence#1⟭  "⟬person_name#1⟭"  0.85
1   ⟬customer_id#2⟭  ⟬fr_license_plate#2⟭  ⟬fr_driving_licence#2⟭  "⟬person_name#2⟭"  1.00
2   ⟬customer_id#3⟭  ⟬fr_license_plate#3⟭  ⟬fr_driving_licence#3⟭  "⟬person_name#3⟭"  0.50
3   ⟬customer_id#4⟭  ⟬fr_license_plate#4⟭               NaN        "⟬person_name#4⟭"  0.95
4   ⟬customer_id#5⟭  ⟬fr_license_plate#5⟭  ⟬fr_driving_licence#5⟭  "⟬person_name#5⟭"  1.25
INFO jointure avec la table des vehicules
Traceback (most recent call last):
  File "/opt/tarif/.venv/lib/python3.11/site-packages/pandas/core/indexes/base.py", line 3790, in get_loc
    return self._engine.get_loc(casted_key)
  File "index.pyx", line 152, in pandas._libs.index.IndexEngine.get_loc
  File "index.pyx", line 181, in pandas._libs.index.IndexEngine.get_loc
  File "pandas/_libs/hashtable_class_helper.pxi", line 7080, in pandas._libs.hashtable.PyObjectHashTable.get_item
  File "pandas/_libs/hashtable_class_helper.pxi", line 7088, in pandas._libs.hashtable.PyObjectHashTable.get_item
KeyError: 'puissance_fiscale'

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/opt/tarif/scripts/recalcul_primes.py", line 118, in <module>
    main()
  File "/opt/tarif/.venv/lib/python3.11/site-packages/click/core.py", line 1157, in __call__
    return self.main(*args, **kwargs)
  File "/opt/tarif/.venv/lib/python3.11/site-packages/click/core.py", line 1078, in main
    rv = self.invoke(ctx)
  File "/opt/tarif/.venv/lib/python3.11/site-packages/click/core.py", line 1434, in invoke
    return ctx.invoke(self.callback, **ctx.params)
  File "/opt/tarif/.venv/lib/python3.11/site-packages/click/core.py", line 783, in invoke
    return __callback(*args, **kwargs)
  File "/opt/tarif/scripts/recalcul_primes.py", line 92, in main
    primes = appliquer_bareme(contrats)
  File "/opt/tarif/tarif/bareme.py", line 64, in appliquer_bareme
    jointure = contrats.merge(vehicules, on="plaque", how="left")
  File "/opt/tarif/tarif/bareme.py", line 71, in ⟬trap:code_identifier|ajuster_⦃family⦄⟭
    jointure["coef"] = jointure["puissance_fiscale"].map(table_coefs)
  File "/opt/tarif/.venv/lib/python3.11/site-packages/pandas/core/frame.py", line 3893, in __getitem__
    indexer = self.columns.get_loc(key)
  File "/opt/tarif/.venv/lib/python3.11/site-packages/pandas/core/indexes/base.py", line 3797, in get_loc
    raise KeyError(key) from err
KeyError: 'puissance_fiscale'

Variables au moment de l'erreur:
  ligne_courante = {'plaque': '⟬fr_license_plate#6⟭', 'permis': '⟬fr_driving_licence#6⟭', 'conducteur': "⟬person_name#6⟭", 'iban': '⟬iban#6⟭'}
  table_coefs = {4: 0.92, 5: 1.0, 6: 1.08, 7: 1.15}
  fichier_vehicules = '⟬file_path#2⟭'

Contexte:
  lot ⟬uuid#1⟭
  duree avant erreur 41 s
  memoire max 1,2 Go

Reprise manuelle:
  python scripts/recalcul_primes.py --depuis ⟬customer_id#6⟭
  responsable ⟬person_name#7⟭, ⟬email#7⟭
  ⟬trap:indicator_non_pii|owner=equipe-tarification⟭
$ echo $?
1
⟬end⟭

⟬template⟭
family: logs
format: test output
language: fr
fill_locale: fr_FR
domain: healthcare
appearance: JUnit XML report, CDATA stdout, attribute value, inline JSON
scenario: JUnit XML report of a patient record application, copied into the log, whose failure messages and captured output keep NIR, birth dates and passport
⟬text⟭
<?xml version="1.0" encoding="UTF-8"?>
<testsuites name="dossier-patient" tests="16" failures="2" errors="1" time="5.843">
  <testsuite name="fr.hopital.dossier.AdmissionTest" tests="5" failures="1" errors="0" time="1.204">
    <properties>
      <property name="java.version" value="21.0.1"/>
      <property name="user.name" value="⟬trap:indicator_non_pii|ci-runner⟭"/>
      <property name="os.name" value="Linux"/>
    </properties>
    <testcase name="admissionSimple" classname="fr.hopital.dossier.AdmissionTest" time="0.214"/>
    <testcase name="admissionSansCouverture" classname="fr.hopital.dossier.AdmissionTest" time="0.188"/>
    <testcase name="admissionPatientSousTutelle" classname="fr.hopital.dossier.AdmissionTest" time="0.241">
      <failure message="attendu tuteur pour nir=⟬fr_social_security_number#1⟭" type="org.opentest4j.AssertionFailedError">
fr.hopital.dossier.AdmissionTest.admissionPatientSousTutelle(AdmissionTest.java:61)
      </failure>
      <system-out><![CDATA[
création patient {"nom":"⟬person_name#1⟭","naissance":"⟬birth_date#1⟭","nir":"⟬fr_social_security_number#1⟭"}
service=geriatrie lit=12
      ]]></system-out>
    </testcase>
    <testcase name="admissionTransfert" classname="fr.hopital.dossier.AdmissionTest" time="0.301"/>
    <testcase name="admissionUrgence" classname="fr.hopital.dossier.AdmissionTest" time="0.260"/>
  </testsuite>
  <testsuite name="fr.hopital.dossier.IdentiteTest" tests="4" failures="1" errors="1" time="2.044">
    <testcase name="patientEtrangerAvecPasseport" classname="fr.hopital.dossier.IdentiteTest" time="0.412">
      <failure message="passeport ⟬fr_passport#2⟭ non rattaché à &quot;⟬person_name#2⟭&quot;" type="org.opentest4j.AssertionFailedError">
fr.hopital.dossier.IdentiteTest.patientEtrangerAvecPasseport(IdentiteTest.java:88)
      </failure>
      <system-out><![CDATA[
création patient {"nom":"⟬person_name#2⟭","naissance":"⟬birth_date#2⟭","piece":"PASSEPORT"}
      ]]></system-out>
    </testcase>
    <testcase name="fusionDoublons" classname="fr.hopital.dossier.IdentiteTest" time="0.611">
      <error message="NullPointerException" type="java.lang.NullPointerException">
fr.hopital.dossier.Fusion.appliquer(Fusion.java:120)
fr.hopital.dossier.IdentiteTest.fusionDoublons(IdentiteTest.java:104)
      </error>
      <system-out><![CDATA[
candidat 1 ⟬customer_id#3⟭ "⟬person_name#3⟭" ⟬birth_date#3⟭
candidat 2 ⟬customer_id#4⟭ "⟬person_name#4⟭" ⟬birth_date#4⟭
score ⟬trap:eponym|Jaro-Winkler⟭ 0.93
      ]]></system-out>
    </testcase>
    <testcase name="rejetNirInvalide" classname="fr.hopital.dossier.IdentiteTest" time="0.504"/>
    <testcase name="⟬trap:code_identifier|format⦃Family⦄Identite⟭" classname="fr.hopital.dossier.IdentiteTest" time="0.517"/>
  </testsuite>
  <testsuite name="fr.hopital.dossier.PlanningTest" tests="3" failures="0" errors="0" time="1.564">
    <testcase name="creneauLibre" classname="fr.hopital.dossier.PlanningTest" time="0.402"/>
    <testcase name="creneauDouble" classname="fr.hopital.dossier.PlanningTest" time="0.611"/>
    <testcase name="medecinAbsent" classname="fr.hopital.dossier.PlanningTest" time="0.551">
      <system-out><![CDATA[
⟬trap:indicator_non_pii|medecin=remplacant⟭ service=cardiologie
      ]]></system-out>
    </testcase>
  </testsuite>
  <testsuite name="fr.hopital.dossier.CourrierTest" tests="4" failures="0" errors="0" time="0.841">
    <testcase name="lettreDeSortie" classname="fr.hopital.dossier.CourrierTest" time="0.312"/>
    <testcase name="compteRendu" classname="fr.hopital.dossier.CourrierTest" time="0.288"/>
    <testcase name="⟬trap:code_identifier|signature⦃Family⦄⟭" classname="fr.hopital.dossier.CourrierTest" time="0.241"/>
    <testcase name="envoiMessagerie" classname="fr.hopital.dossier.CourrierTest" time="0.190">
      <system-out><![CDATA[
envoi vers ⟬email:generic#5⟭
      ]]></system-out>
    </testcase>
  </testsuite>
</testsuites>
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: fr
fill_locale: fr_FR
domain: telecom
appearance: auth.log, firewall change, sudo log, key=value
scenario: authentication and firewall logs of an operator's peering point, a morning of automation by service accounts, with no named person
⟬text⟭
⟬date#1⟭ 06:00:01 fw-peering01 CRON[4120]: pam_unix(cron:session): session opened for ⟬trap:indicator_non_pii|user root⟭(uid=0)
⟬date#1⟭ 06:00:02 fw-peering01 CRON[4120]: pam_unix(cron:session): session closed for ⟬trap:indicator_non_pii|user root⟭
⟬date#1⟭ 06:02:44 fw-peering01 sshd[4188]: Accepted publickey for ⟬username#1⟭ from ⟬ip_address#1⟭ port 44120 ssh2: SHA256:⟬hash#1⟭
⟬date#1⟭ 06:02:44 fw-peering01 sudo:  ⟬username#1⟭ : ⟬trap:indicator_non_pii|PWD=/home/ansible⟭ ; ⟬trap:indicator_non_pii|USER=root⟭ ; COMMAND=/usr/sbin/nft -f /tmp/regles.nft
⟬date#1⟭ 06:02:45 fw-peering01 audit: NETFILTER_CFG table=filter family=2 entries=412 op=nft_register_rule
⟬date#1⟭ 06:02:45 fw-peering01 audit: NETFILTER_CFG table=nat family=2 entries=18 op=nft_register_rule
⟬date#1⟭ 06:02:46 fw-peering01 sshd[4188]: Disconnected from ⟬trap:indicator_non_pii|user ansible⟭ ⟬ip_address#1⟭ port 44120
⟬date#1⟭ 06:03:12 fw-peering02 sshd[3902]: Accepted publickey for ⟬username#1⟭ from ⟬ip_address#1⟭ port 44122 ssh2: SHA256:⟬hash#1⟭
⟬date#1⟭ 06:03:12 fw-peering02 sudo:  ⟬username#1⟭ : ⟬trap:indicator_non_pii|PWD=/home/ansible⟭ ; ⟬trap:indicator_non_pii|USER=root⟭ ; COMMAND=/usr/sbin/nft -f /tmp/regles.nft
⟬date#1⟭ 06:03:13 fw-peering02 audit: NETFILTER_CFG table=filter family=2 entries=412 op=nft_register_rule
⟬date#1⟭ 06:03:14 fw-peering02 sshd[3902]: Disconnected from ⟬trap:indicator_non_pii|user ansible⟭ ⟬ip_address#1⟭ port 44122
⟬date#1⟭ 06:05:00 fw-peering01 sshd[4210]: Invalid user admin from ⟬ip_address#2⟭ port 51120
⟬date#1⟭ 06:05:00 fw-peering01 sshd[4210]: Failed password for ⟬trap:indicator_non_pii|invalid user admin⟭ from ⟬ip_address#2⟭ port 51120 ssh2
⟬date#1⟭ 06:05:02 fw-peering01 sshd[4212]: Invalid user oracle from ⟬ip_address#2⟭ port 51122
⟬date#1⟭ 06:05:02 fw-peering01 sshd[4212]: Failed password for ⟬trap:indicator_non_pii|invalid user oracle⟭ from ⟬ip_address#2⟭ port 51122 ssh2
⟬date#1⟭ 06:05:03 fw-peering01 sshd[4214]: Invalid user test from ⟬ip_address#2⟭ port 51124
⟬date#1⟭ 06:05:03 fw-peering01 sshd[4214]: Failed password for ⟬trap:indicator_non_pii|invalid user test⟭ from ⟬ip_address#2⟭ port 51124 ssh2
⟬date#1⟭ 06:05:04 fw-peering01 fail2ban.actions[812]: NOTICE [sshd] Ban ⟬ip_address#2⟭
⟬date#1⟭ 06:10:00 fw-peering01 CRON[4301]: pam_unix(cron:session): session opened for ⟬trap:indicator_non_pii|user root⟭(uid=0)
⟬date#1⟭ 06:10:01 fw-peering01 CRON[4301]: pam_unix(cron:session): session closed for ⟬trap:indicator_non_pii|user root⟭
⟬date#1⟭ 06:15:22 fw-peering02 sshd[3990]: Accepted publickey for ⟬username#2⟭ from ⟬ip_address#3⟭ port 40112 ssh2: SHA256:⟬hash#2⟭
⟬date#1⟭ 06:15:23 fw-peering02 sudo:  ⟬username#2⟭ : ⟬trap:indicator_non_pii|USER=root⟭ ; COMMAND=/usr/sbin/birdc show protocols
⟬date#1⟭ 06:15:24 fw-peering02 sudo:  ⟬username#2⟭ : ⟬trap:indicator_non_pii|USER=root⟭ ; COMMAND=/usr/sbin/birdc show route count
⟬date#1⟭ 06:15:26 fw-peering02 sshd[3990]: Disconnected from ⟬trap:indicator_non_pii|user monitoring⟭ ⟬ip_address#3⟭ port 40112
⟬date#1⟭ 06:20:00 fw-peering01 bird[612]: session BGP avec le pair ⟬ip_address#4⟭ établie
⟬date#1⟭ 06:20:01 fw-peering01 bird[612]: 412 208 préfixes reçus
⟬date#1⟭ 06:20:40 fw-peering02 bird[598]: session BGP avec le pair ⟬ip_address#5⟭ établie
⟬date#1⟭ 06:20:41 fw-peering02 bird[598]: 408 912 préfixes reçus
⟬date#1⟭ 06:30:00 fw-peering01 CRON[4388]: pam_unix(cron:session): session opened for ⟬trap:indicator_non_pii|user root⟭(uid=0)
⟬date#1⟭ 06:30:01 fw-peering01 CRON[4388]: pam_unix(cron:session): session closed for ⟬trap:indicator_non_pii|user root⟭
⟬date#1⟭ 06:40:11 fw-peering01 sshd[4410]: Accepted publickey for ⟬username#3⟭ from ⟬ip_address#6⟭ port 41010 ssh2: SHA256:⟬hash#3⟭
⟬date#1⟭ 06:40:12 fw-peering01 sudo:  ⟬username#3⟭ : ⟬trap:indicator_non_pii|USER=root⟭ ; COMMAND=/usr/bin/rsync -a /etc/nftables/ /sauvegardes/nftables/
⟬date#1⟭ 06:40:18 fw-peering01 sshd[4410]: Disconnected from ⟬trap:indicator_non_pii|user backup⟭ ⟬ip_address#6⟭ port 41010
⟬date#1⟭ 06:41:02 fw-peering02 sshd[4011]: Accepted publickey for ⟬username#3⟭ from ⟬ip_address#6⟭ port 41012 ssh2: SHA256:⟬hash#3⟭
⟬date#1⟭ 06:41:03 fw-peering02 sudo:  ⟬username#3⟭ : ⟬trap:indicator_non_pii|USER=root⟭ ; COMMAND=/usr/bin/rsync -a /etc/nftables/ /sauvegardes/nftables/
⟬date#1⟭ 06:41:09 fw-peering02 sshd[4011]: Disconnected from ⟬trap:indicator_non_pii|user backup⟭ ⟬ip_address#6⟭ port 41012
⟬date#1⟭ 06:50:00 fw-peering01 CRON[4502]: pam_unix(cron:session): session opened for ⟬trap:indicator_non_pii|user root⟭(uid=0)
⟬date#1⟭ 06:50:01 fw-peering01 CRON[4502]: pam_unix(cron:session): session closed for ⟬trap:indicator_non_pii|user root⟭
⟬date#1⟭ 07:00:00 fw-peering01 CRON[4580]: pam_unix(cron:session): session opened for ⟬trap:indicator_non_pii|user root⟭(uid=0)
⟬date#1⟭ 07:00:01 fw-peering01 CRON[4580]: pam_unix(cron:session): session closed for ⟬trap:indicator_non_pii|user root⟭
⟬date#1⟭ 07:02:44 fw-peering01 sshd[4602]: Accepted publickey for ⟬username#1⟭ from ⟬ip_address#1⟭ port 44190 ssh2: SHA256:⟬hash#1⟭
⟬date#1⟭ 07:02:45 fw-peering01 sudo:  ⟬username#1⟭ : ⟬trap:indicator_non_pii|USER=root⟭ ; COMMAND=/usr/sbin/nft list ruleset
⟬date#1⟭ 07:02:46 fw-peering01 sshd[4602]: Disconnected from ⟬trap:indicator_non_pii|user ansible⟭ ⟬ip_address#1⟭ port 44190
⟬date#1⟭ 07:10:00 fw-peering02 CRON[4120]: pam_unix(cron:session): session opened for ⟬trap:indicator_non_pii|user root⟭(uid=0)
⟬date#1⟭ 07:10:01 fw-peering02 CRON[4120]: pam_unix(cron:session): session closed for ⟬trap:indicator_non_pii|user root⟭
⟬date#1⟭ 07:15:30 fw-peering02 fail2ban.actions[802]: NOTICE [sshd] Unban ⟬ip_address#7⟭
⟬date#1⟭ 07:20:00 fw-peering01 audit: SERVICE_START pid=1 uid=0 auid=4294967295 msg='unit=nftables-sauvegarde comm="systemd" res=success'
⟬date#1⟭ 07:20:02 fw-peering01 audit: SERVICE_STOP pid=1 uid=0 auid=4294967295 msg='unit=nftables-sauvegarde comm="systemd" res=success'
⟬date#1⟭ 07:30:00 fw-peering01 CRON[4688]: pam_unix(cron:session): session opened for ⟬trap:indicator_non_pii|user root⟭(uid=0)
⟬date#1⟭ 07:30:01 fw-peering01 CRON[4688]: pam_unix(cron:session): session closed for ⟬trap:indicator_non_pii|user root⟭
⟬date#1⟭ 07:40:12 fw-peering02 sshd[4190]: Accepted publickey for ⟬username#2⟭ from ⟬ip_address#3⟭ port 40188 ssh2: SHA256:⟬hash#2⟭
⟬date#1⟭ 07:40:13 fw-peering02 sudo:  ⟬username#2⟭ : ⟬trap:indicator_non_pii|USER=root⟭ ; COMMAND=/usr/sbin/birdc show protocols
⟬date#1⟭ 07:40:15 fw-peering02 sshd[4190]: Disconnected from ⟬trap:indicator_non_pii|user monitoring⟭ ⟬ip_address#3⟭ port 40188
⟬date#1⟭ 07:50:00 fw-peering01 CRON[4744]: pam_unix(cron:session): session opened for ⟬trap:indicator_non_pii|user root⟭(uid=0)
⟬date#1⟭ 07:50:01 fw-peering01 CRON[4744]: pam_unix(cron:session): session closed for ⟬trap:indicator_non_pii|user root⟭
⟬date#1⟭ 08:00:00 fw-peering01 CRON[4802]: pam_unix(cron:session): session opened for ⟬trap:indicator_non_pii|user root⟭(uid=0)
⟬date#1⟭ 08:00:01 fw-peering01 CRON[4802]: pam_unix(cron:session): session closed for ⟬trap:indicator_non_pii|user root⟭
⟬date#1⟭ 08:10:00 fw-peering02 CRON[4240]: pam_unix(cron:session): session opened for ⟬trap:indicator_non_pii|user root⟭(uid=0)
⟬date#1⟭ 08:10:01 fw-peering02 CRON[4240]: pam_unix(cron:session): session closed for ⟬trap:indicator_non_pii|user root⟭
⟬date#1⟭ 08:20:00 fw-peering01 bird[612]: 412 244 préfixes reçus
⟬date#1⟭ 08:20:41 fw-peering02 bird[598]: 409 018 préfixes reçus
⟬date#1⟭ 08:30:00 fw-peering01 CRON[4901]: pam_unix(cron:session): session opened for ⟬trap:indicator_non_pii|user root⟭(uid=0)
⟬date#1⟭ 08:30:01 fw-peering01 CRON[4901]: pam_unix(cron:session): session closed for ⟬trap:indicator_non_pii|user root⟭
⟬end⟭
