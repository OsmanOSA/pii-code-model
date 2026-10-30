⟬template⟭
family: logs
format: application log
language: mixed
fill_locale: mixed
domain: banking
appearance: Spring Boot log line, quoted field, name in a sentence, value alone at end of line, field holding several values
scenario: instant SEPA transfer service of a French retail bank during a sanctions false positive, whose DEBUG level copies payer, payee and a FATCA check into the application log
⟬text⟭
⟬date#1⟭ 08:12:03.114  INFO 5828 --- [           main] f.b.instant.SctInstApplication           : Started SctInstApplication in 11.402 seconds (process running for 12.117)
⟬date#1⟭ 08:12:03.220  INFO 5828 --- [           main] o.s.b.a.e.web.EndpointLinksResolver      : Exposing 3 endpoint(s) beneath base path '/actuator'
⟬date#1⟭ 08:12:03.431  INFO 5828 --- [           main] o.a.k.clients.consumer.KafkaConsumer     : [Consumer clientId=sct-1, groupId=sct-inst] Subscribed to topic(s): pacs008.in
⟬date#1⟭ 08:14:41.502 DEBUG 5828 --- [  kafka-sct-1-C] f.b.instant.in.Pacs008Listener           : pacs.008 received msgId=⟬uuid#1⟭ amount=1250.00 ccy=EUR
⟬date#1⟭ 08:14:41.503 DEBUG 5828 --- [  kafka-sct-1-C] f.b.instant.in.Pacs008Listener           : debtor="⟬person_name#1⟭" iban="⟬iban#1⟭" bic=⟬bic#1⟭
⟬date#1⟭ 08:14:41.503 DEBUG 5828 --- [  kafka-sct-1-C] f.b.instant.in.Pacs008Listener           : creditor="⟬person_name#2⟭" iban="⟬iban#2⟭" bic=⟬bic#2⟭ remittance="loyer résidence ⟬trap:word_name|Marguerite⟭"
⟬date#1⟭ 08:14:41.611  INFO 5828 --- [  kafka-sct-1-C] f.b.instant.screening.SanctionsClient    : screening request ref=⟬order_number#1⟭ list=EU-CONSOLIDATED
⟬date#1⟭ 08:14:41.958  WARN 5828 --- [  kafka-sct-1-C] f.b.instant.screening.SanctionsClient    : score=0.91 au-dessus du seuil, virement mis en attente : nom proche de "⟬person_name#3⟭"
⟬date#1⟭ 08:14:41.960  INFO 5828 --- [  kafka-sct-1-C] f.b.instant.flow.TransferStateMachine    : state PENDING -> ON_HOLD msgId=⟬uuid#1⟭ reason=SANCTIONS_HIT owner=⟬trap:indicator_non_pii|compliance-fr⟭
⟬date#1⟭ 08:14:51.512 ERROR 5828 --- [  kafka-sct-1-C] f.b.instant.out.RejectPublisher          : pacs.002 RJCT sent to ⟬hostname#1⟭:9093, timer 10s exceeded for ⟬iban#1⟭
⟬date#1⟭ 08:14:51.530  WARN 5828 --- [ad | producer-1] o.a.k.c.p.internals.Sender               : [Producer clientId=sct-out] Got error produce response with correlation id 8841 on topic-partition pacs002.out-2, retrying (2 attempts left). Error: NOT_LEADER_OR_FOLLOWER
⟬date#1⟭ 08:21:07.440  INFO 5828 --- [    scheduler-2] f.b.instant.kyc.FatcaIndiciaJob          : indices US détectés pour 1 client sur 946
⟬date#1⟭ 08:21:07.441 DEBUG 5828 --- [    scheduler-2] f.b.instant.kyc.FatcaIndiciaJob          : meta="⟬person_name#4⟭ ⟬us_itin#4⟭ born=⟬birth_date#4⟭ form=W-9 opened=⟬date#2⟭"
⟬date#1⟭ 09:02:55.031  INFO 5828 --- [nio-8443-exec-4] f.b.instant.admin.HoldController         : POST /admin/holds/⟬uuid#1⟭/release operator="⟬person_name#5⟭" note="homonyme confirmé par ⟬person_name#6⟭"
⟬date#1⟭ 09:02:55.340  INFO 5828 --- [nio-8443-exec-4] f.b.instant.flow.TransferStateMachine    : state ON_HOLD -> RELEASED msgId=⟬uuid#1⟭ operator="⟬trap:indicator_non_pii|sct-auto⟭"
⟬date#1⟭ 09:02:55.344 DEBUG 5828 --- [nio-8443-exec-4] f.b.instant.flow.CompensationService     : contre-passation sur le compte ⟬bank_account_number#2⟭ ref=⟬order_number#1⟭
⟬date#1⟭ 09:30:00.002  INFO 5828 --- [    scheduler-1] f.b.instant.ops.CutoffReporter           : cut-off report sent, 1204 settled, 3 rejected, 1 on hold
⟬date#1⟭ 09:30:00.003  INFO 5828 --- [    scheduler-1] f.b.instant.ops.LogLevelGuard            : niveau DEBUG conservé jusqu'à clôture de ⟬ticket_id#1⟭
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: mixed
fill_locale: mixed
domain: SaaS
appearance: Node.js error object, connection string in an error property, French log line
scenario: Node.js crash at startup of a customer portal, where the driver error prints the MongoDB URI with its password
⟬text⟭
[espace-client] impossible de joindre la base, arrêt du process
/app/node_modules/mongoose/lib/connection.js:825
  const serverSelectionError = new ServerSelectionError();
                               ^

MongooseServerSelectionError: connect ECONNREFUSED ⟬hostname#1⟭:27017
    at NativeConnection.Connection.openUri (/app/node_modules/mongoose/lib/connection.js:825:32)
    at /app/src/db/connect.js:14:20
    at processTicksAndRejections (node:internal/process/task_queues:95:5) {
  reason: TopologyDescription { type: 'ReplicaSetNoPrimary', setName: 'rs-espace-client' },
  code: undefined,
  uri: 'mongodb://espace_client:⟬url_password#1⟭@⟬hostname#1⟭:27017/espace?authSource=admin'
}

Node.js v20.11.1
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: mixed
fill_locale: mixed
domain: e-commerce
appearance: Jenkins console, build argument, token in a clone URL, Docker warning, name after an announcing word
scenario: Jenkins build of a French online shop checkout, started by hand, whose docker build passes the payment and storage secrets as build arguments
⟬text⟭
Started by user ⟬person_name#1⟭
Running in Durability level: MAX_SURVIVABILITY
[Pipeline] Start of Pipeline
[Pipeline] node
Running on ⟬hostname#1⟭ in /var/lib/jenkins/workspace/boutique-checkout_main
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Checkout)
[Pipeline] sh
+ git clone -q https://x-access-token:⟬github_token#1⟭@github.com/boutique-exemple/checkout.git .
+ git rev-parse HEAD
⟬git_sha#1⟭
Commit message: "fix(panier): arrondi TVA sur les codes promo"
[Pipeline] }
[Pipeline] stage
[Pipeline] { (Build image)
[Pipeline] sh
+ docker build --build-arg STRIPE_SECRET_KEY=⟬stripe_secret_key#1⟭ --build-arg AWS_SECRET_ACCESS_KEY=⟬aws_secret_access_key#1⟭ --build-arg BUILD_USER=⟬trap:indicator_non_pii|jenkins⟭ -t ⟬hostname#2⟭:5000/checkout:main .
Sending build context to Docker daemon  48.21MB
Step 1/7 : FROM node:20-alpine
 ---> ⟬git_sha#2⟭
Step 2/7 : ARG STRIPE_SECRET_KEY
Step 3/7 : ARG AWS_SECRET_ACCESS_KEY
Step 4/7 : COPY . /app
Step 5/7 : RUN npm ci --omit=dev
added 612 packages in 41s
Step 6/7 : RUN npm run build:assets
Step 7/7 : CMD ["node", "dist/server.js"]
Successfully built ⟬git_sha#3⟭
Successfully tagged ⟬hostname#2⟭:5000/checkout:main
[Warning] One or more build-args [BUILD_USER] were not consumed
[Pipeline] }
[Pipeline] End of Pipeline
Finished: SUCCESS
⟬end⟭

⟬template⟭
family: logs
format: application log
language: mixed
fill_locale: mixed
domain: logistics
appearance: dispatch log, quoted field, name in a sentence, address in a sentence, token in a query string, secret under an innocuous key, phone without announcer
scenario: morning of a French haulier's dispatch service, mixing the planner, the drivers' mobile sessions, a British subcontractor on the Dover run and delivery proofs
⟬text⟭
⟬date#1⟭ 05:30:02,118 INFO  [main] tms.boot - starting tms-dispatch ⟬version#1⟭ on ⟬hostname#1⟭, pid 5917
⟬date#1⟭ 05:30:02,540 INFO  [main] tms.boot - connected to broker ⟬hostname#2⟭:5672, vhost tms
⟬date#1⟭ 05:30:02,803 INFO  [main] tms.boot - HikariPool-1 - Start completed.
⟬date#1⟭ 05:30:03,207 INFO  [planner-1] tms.planner - chargement des commandes, dépôt LYS-02
⟬date#1⟭ 05:30:04,118 INFO  [planner-1] tms.planner - 184 colis, 9 tournées candidates, solver=⟬trap:eponym|Clarke-Wright⟭
⟬date#1⟭ 05:30:04,120 DEBUG [planner-1] tms.planner - depot_adr="⟬fr_postal_address#9⟭" quais=6
⟬date#1⟭ 05:30:09,331 INFO  [planner-1] tms.planner - tournée TR-0412 affectée, chauffeur="⟬person_name#1⟭" tel="⟬phone#1⟭" plaque="⟬fr_license_plate#1⟭"
⟬date#1⟭ 05:30:09,334 DEBUG [planner-1] tms.planner - TR-0412 stop 1 client=⟬customer_id#3⟭ destinataire="⟬person_name#3⟭" adr="⟬fr_postal_address#3⟭"
⟬date#1⟭ 05:30:09,335 DEBUG [planner-1] tms.planner - TR-0412 stop 2 client=⟬customer_id#4⟭ destinataire=⟬trap:indicator_non_pii|PICKUP-POINT⟭ ville=⟬city#4⟭ cp=⟬postcode#4⟭
⟬date#1⟭ 05:30:09,336 DEBUG [planner-1] tms.planner - TR-0412 stop 3 client=⟬customer_id#5⟭ destinataire="⟬person_name#5⟭" adr="⟬fr_postal_address#5⟭"
⟬date#1⟭ 05:30:11,902 INFO  [planner-1] tms.planner - tournée TR-0413 sous-traitée à ⟬trap:company_name|⦃Family⦄ Haulage⟭
⟬date#1⟭ 05:30:11,904 DEBUG [planner-1] tms.planner - TR-0413 attrs="driver=⟬person_name#2⟭ licence=⟬uk_driving_licence#2⟭ reg=⟬uk_license_plate#2⟭"
⟬date#1⟭ 05:30:11,905 INFO  [planner-1] tms.planner - TR-0413 passage Douvres-Calais, contact ferry ⟬phone#10⟭
⟬date#1⟭ 05:30:14,012 INFO  [planner-1] tms.planner - tournée TR-0414 affectée, chauffeur="⟬person_name#6⟭" tel="⟬phone#6⟭" plaque="⟬fr_license_plate#6⟭"
⟬date#1⟭ 05:30:14,300 WARN  [planner-1] tms.planner - TR-0414 surcharge 2 palettes, passage du véhicule à 12 t requis
⟬date#1⟭ 05:30:16,700 INFO  [planner-1] tms.planner - 9 tournées publiées, owner=⟬trap:indicator_non_pii|exploitation-lyon⟭
⟬date#1⟭ 05:58:12,411 INFO  [http-4] tms.mobile - POST /driver/v2/session 200 device=android
⟬date#1⟭ 05:58:12,412 DEBUG [http-4] tms.mobile - session opened for "⟬person_name#1⟭", sig=⟬opaque_token#1⟭
⟬date#1⟭ 05:58:13,020 INFO  [http-2] tms.mobile - GET /driver/v2/tour?access_token=⟬jwt#1⟭ 200 8ms
⟬date#1⟭ 05:58:13,044 INFO  [http-2] tms.mobile - push token saved, device=android
⟬date#1⟭ 06:02:47,180 INFO  [http-7] tms.mobile - POST /driver/v2/session 200 device=ios
⟬date#1⟭ 06:02:47,181 DEBUG [http-7] tms.mobile - session opened for "⟬person_name#6⟭", sig=⟬opaque_token#2⟭
⟬date#1⟭ 06:02:47,644 INFO  [http-1] tms.mobile - GET /driver/v2/tour?access_token=⟬jwt#2⟭ 200 11ms
⟬date#1⟭ 06:10:00,002 INFO  [gps-feed] tms.gps - 79 positions reçues, 0 rejetées
⟬date#1⟭ 06:20:00,001 INFO  [gps-feed] tms.gps - 44 positions reçues, 1 rejetée (hors zone)
⟬date#1⟭ 06:30:00,003 INFO  [gps-feed] tms.gps - 44 positions reçues, 0 rejetées
⟬date#1⟭ 06:41:19,512 INFO  [events] tms.pod - TR-0412 stop 1 arrivée sur site
⟬date#1⟭ 06:49:02,240 INFO  [events] tms.pod - TR-0412 stop 1 livré, signé par ⟬person_name#3⟭
⟬date#1⟭ 06:49:02,244 DEBUG [events] tms.pod - photo preuve stockée ⟬file_path#1⟭ value=⟬hash#1⟭
⟬date#1⟭ 07:02:33,118 WARN  [events] tms.eta - bouchon signalé ⟬trap:word_name|avenue Jean-Jaurès⟭, retard estimé 18 min sur TR-0412
⟬date#1⟭ 07:02:33,120 INFO  [events] tms.notify - SMS retard envoyé à ⟬phone#5⟭
⟬date#1⟭ 07:12:48,604 INFO  [events] tms.pod - TR-0412 stop 2 livré, point relais
⟬date#1⟭ 07:12:48,605 INFO  [events] tms.pod - TR-0412 stop 2 signé par relais-automatique
⟬date#1⟭ 07:36:55,019 INFO  [events] tms.pod - TR-0412 stop 3 destinataire absent
⟬date#1⟭ 07:36:55,021 INFO  [events] tms.notify - appel au ⟬phone#5⟭ sans réponse, avis de passage déposé
⟬date#1⟭ 07:37:40,300 INFO  [events] tms.pod - TR-0412 stop 3 reprogrammé par "⟬person_name#7⟭", plateforme clients
⟬date#1⟭ 07:50:00,002 INFO  [gps-feed] tms.gps - 46 positions reçues, 0 rejetées
⟬date#1⟭ 08:03:11,441 ERROR [events] tms.customs - TR-0413 pré-déclaration refusée, chauffeur inconnu du portail : ⟬uk_driving_licence#2⟭
⟬date#1⟭ 08:03:11,443 INFO  [events] tms.customs - TR-0413 ticket ⟬ticket_id#1⟭ ouvert, operator=⟬trap:indicator_non_pii|customs-bridge⟭
⟬date#1⟭ 08:15:26,220 INFO  [http-3] tms.admin - POST /admin/partners/driver 201 operator=⟬person_name#7⟭
⟬date#1⟭ 08:15:26,224 DEBUG [http-3] tms.admin - nouveau chauffeur "⟬person_name#2m⟭" permis "⟬uk_driving_licence#2⟭" né le ⟬birth_date#2⟭ embauché le ⟬date#2⟭
⟬date#1⟭ 08:16:02,510 INFO  [events] tms.customs - TR-0413 pré-déclaration acceptée, référence ⟬order_number#1⟭
⟬date#1⟭ 08:30:00,001 INFO  [gps-feed] tms.gps - 47 positions reçues, 0 rejetées
⟬date#1⟭ 08:44:37,903 INFO  [events] tms.pod - TR-0414 stop 1 livré, signé par ⟬person_name#8⟭
⟬date#1⟭ 08:44:37,907 DEBUG [events] tms.pod - photo preuve stockée ⟬file_path#2⟭ value=⟬hash#2⟭
⟬date#1⟭ 09:00:00,001 INFO  [metrics] tms.stats - tournées en cours 9, colis livrés 62, retards 3
⟬date#1⟭ 09:12:18,330 WARN  [http-5] tms.mobile - token expiré device=ios, renouvellement
⟬date#1⟭ 09:12:18,611 INFO  [http-5] tms.mobile - GET /driver/v2/tour?access_token=⟬jwt#3⟭ 200 9ms
⟬date#1⟭ 09:30:00,002 INFO  [gps-feed] tms.gps - 47 positions reçues, 2 rejetées (précision)
⟬date#1⟭ 09:41:50,118 INFO  [events] tms.pod - TR-0413 arrivée Calais, 3 palettes contrôlées
⟬date#1⟭ 09:58:14,772 INFO  [events] tms.billing - facture sous-traitant ⟬invoice_number#1⟭ préparée pour ⟬trap:company_name|⦃Family⦄ Haulage⟭
⟬date#1⟭ 10:00:00,001 INFO  [metrics] tms.stats - tournées en cours 8, colis livrés 97, retards 3
⟬date#1⟭ 10:14:03,206 INFO  [events] tms.pod - TR-0414 stop 2 livré, signé par concierge
⟬date#1⟭ 10:30:00,003 INFO  [gps-feed] tms.gps - 45 positions reçues, 0 rejetées
⟬date#1⟭ 10:42:51,090 INFO  [events] tms.pod - TR-0415 retour dépôt, 0 colis restant
⟬date#1⟭ 10:42:51,094 INFO  [events] tms.fleet - véhicule ⟬fr_license_plate#1⟭ disponible
⟬date#1⟭ 11:00:00,001 INFO  [metrics] tms.stats - tournées en cours 7, colis livrés 131, retards 2
⟬date#1⟭ 11:05:12,448 INFO  [events] tms.pod - TR-0412 stop 3 relivré, signé par ⟬person_name#5⟭
⟬date#1⟭ 11:05:12,451 DEBUG [events] tms.pod - photo preuve stockée ⟬file_path#3⟭ value=⟬hash#3⟭
⟬date#1⟭ 11:30:00,002 INFO  [gps-feed] tms.gps - 44 positions reçues, 0 rejetées
⟬date#1⟭ 11:48:29,601 INFO  [events] tms.fleet - véhicule ⟬fr_license_plate#6⟭ disponible
⟬date#1⟭ 12:00:00,001 INFO  [metrics] tms.stats - tournées en cours 5, colis livrés 158, retards 2
⟬date#1⟭ 12:00:00,004 INFO  [main] tms.boot - rotation du fichier ⟬file_path#4⟭, user=⟬trap:indicator_non_pii|tms⟭
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: mixed
fill_locale: mixed
domain: banking
appearance: Python traceback, French log line, field holding several values, eponym
scenario: pricing worker of a French investment desk failing on an implied volatility solve, with desk accounts and no customer value
⟬text⟭
⟬date#1⟭ 17:42:08,411 ERROR pricing.worker - tâche ⟬uuid#1⟭ en échec, modèle ⟬trap:eponym|Black-Scholes⟭ dbg="desk=taux-eur attempt=3"
Traceback (most recent call last):
  File "/srv/pricing/app/engine/options.py", line 88, in price_barrier
    sigma = implied_vol(quote, tenor)
  File "/srv/pricing/app/engine/vol.py", line 91, in implied_vol
    return brentq(objective, 1e-4, 5.0)
  File "/srv/pricing/.venv/lib/python3.11/site-packages/scipy/optimize/_zeros_py.py", line 799, in brentq
    r = _zeros._brentq(f, a, b, xtol, rtol, maxiter, args, full_output, disp)
ValueError: f(a) and f(b) must have different signs
⟬date#1⟭ 17:42:08,415 WARN  pricing.worker - requeue refusé, owner=⟬trap:indicator_non_pii|desk-structures⟭ prévenu, user=⟬trap:indicator_non_pii|svc_pricing⟭
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: mixed
fill_locale: mixed
domain: logistics
appearance: Azure DevOps task banner, masked variable, test results, tool author field, code identifier
scenario: Azure DevOps build of a parcel tracking API, with French test names, masked variables and a package step, where nothing sensitive is printed
⟬text⟭
##[section]Starting: Initialize job
Agent name: '⟬hostname#1⟭'
Agent machine name: '⟬hostname#1⟭'
Current agent version: '3.236.1'
Requested for: ⟬trap:indicator_non_pii|Project Collection Build Service⟭
##[section]Finishing: Initialize job
##[section]Starting: Tests
==============================================================================
Task         : .NET Core
Description  : Build, test, package, or publish a dotnet application
Version      : 2.238.1
Author       : ⟬trap:indicator_non_pii|Microsoft Corporation⟭
Help         : ⟬url#1⟭
==============================================================================
##[debug]attrs="queue=hosted-ubuntu retries=0 parallel=2"
##[debug]SQL_PASSWORD=⟬trap:placeholder|***⟭
##[debug]TRACKING_API_KEY=⟬trap:placeholder|***⟭
##[command]/usr/bin/dotnet test SuiviColis.sln --logger trx --no-build -p:Version=⟬version#1⟭
  Determining projects to restore...
  All projects are up-to-date for restore.
Starting test execution, please wait...
A total of 1 test files matched the specified pattern.
  Passed SuiviColis.Tests.EtaTests.Eta_Retourne_Retard_Si_Depot_Ferme [14 ms]
  Passed SuiviColis.Tests.EtaTests.Eta_Ignore_Jours_Feries [3 ms]
  Passed SuiviColis.Tests.LabelTests.⟬trap:code_identifier|Etiquette_⦃Family⦄_Format_A6⟭ [24 ms]
  Skipped SuiviColis.Tests.CarrierTests.Webhook_Transporteur_Timeout [1 ms]
Test Run Successful.
Total tests: 214
     Passed: 213
    Skipped: 1
 Total time: 18.4120 Seconds
##[section]Finishing: Tests
##[section]Starting: Pack
##[command]/usr/bin/dotnet pack SuiviColis.Api.csproj --no-build -o /home/vsts/work/1/a
  Successfully created package SuiviColis.Api, version ⟬version#1⟭
##[section]Finishing: Pack
##[section]Finishing: Job
⟬end⟭

⟬template⟭
family: logs
format: application log
language: mixed
fill_locale: mixed
domain: e-commerce
appearance: Monolog line, JSON context, HTTP header, name in a sentence
scenario: PHP shop refund flow with the Stripe client in debug mode, whose request context prints the Authorization header next to a French refund message
⟬text⟭
[⟬date#1⟭ 21:47:02] production.INFO: Remboursement partiel de 34,90 € pour la commande ⟬order_number#1⟭ (client "⟬person_name#1⟭", ⟬email#1⟭) {"source":"backoffice"}
[⟬date#1⟭ 21:47:02] production.DEBUG: Stripe\ApiRequestor request {"method":"POST","path":"/v1/refunds","order":"⟬order_number#1⟭"}
[⟬date#1⟭ 21:47:02] production.DEBUG: Stripe\ApiRequestor headers {"Authorization":"Bearer ⟬stripe_secret_key#1⟭","Idempotency-Key":"⟬uuid#1⟭"}
[⟬date#1⟭ 21:47:03] production.DEBUG: Stripe\ApiRequestor response {"status":200,"request_id":"⟬uuid#2⟭"}
[⟬date#1⟭ 21:47:03] production.INFO: Avoir ⟬invoice_number#1⟭ généré {"operator":"⟬person_name#2⟭"}
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: mixed
fill_locale: mixed
domain: banking
appearance: Java stack trace, SQL constraint detail, object dump in an exception, split city field
scenario: mortgage application API of a French lender rejecting a duplicate file, whose PostgreSQL error prints the borrower's social security number and a DEBUG line dumps the application
⟬text⟭
⟬date#1⟭ 11:03:27.884  WARN 6600 --- [nio-8080-exec-7] o.h.engine.jdbc.spi.SqlExceptionHelper   : SQL Error: 0, SQLState: 23505
⟬date#1⟭ 11:03:27.884 ERROR 6600 --- [nio-8080-exec-7] o.h.engine.jdbc.spi.SqlExceptionHelper   : ERROR: duplicate key value violates unique constraint "uk_emprunteur_nir"
  Detail: Key (nir)=(⟬fr_social_security_number#1⟭) already exists.
⟬date#1⟭ 11:03:27.886 DEBUG 6600 --- [nio-8080-exec-7] f.c.immo.dossier.DossierService          : échec sur DemandePret{emprunteur="⟬person_name#1⟭", naissance="⟬birth_date#1⟭", depot="⟬date#2⟭", iban="⟬iban#1⟭", co_emprunteur="Mme ⟬person_name#2f⟭", ville="⟬city#1⟭", montant=185000}
⟬date#1⟭ 11:03:27.889 ERROR 6600 --- [nio-8080-exec-7] o.a.c.c.C.[.[.[/].[dispatcherServlet]    : Servlet.service() for servlet [dispatcherServlet] in context with path [] threw exception [Request processing failed: org.springframework.dao.DataIntegrityViolationException: could not execute statement; constraint [uk_emprunteur_nir]] with root cause

org.postgresql.util.PSQLException: ERROR: duplicate key value violates unique constraint "uk_emprunteur_nir"
  Detail: Key (nir)=(⟬fr_social_security_number#1⟭) already exists.
	at org.postgresql.core.v3.QueryExecutorImpl.receiveErrorResponse(QueryExecutorImpl.java:2725)
	at org.postgresql.core.v3.QueryExecutorImpl.processResults(QueryExecutorImpl.java:2412)
	at org.postgresql.core.v3.QueryExecutorImpl.execute(QueryExecutorImpl.java:371)
	at org.postgresql.jdbc.PgStatement.executeInternal(PgStatement.java:502)
	at org.postgresql.jdbc.PgPreparedStatement.executeUpdate(PgPreparedStatement.java:152)
	at com.zaxxer.hikari.pool.HikariProxyPreparedStatement.executeUpdate(HikariProxyPreparedStatement.java)
	at org.hibernate.engine.jdbc.internal.ResultSetReturnImpl.executeUpdate(ResultSetReturnImpl.java:194)
	at org.hibernate.persister.entity.mutation.InsertCoordinator.doStaticInserts(InsertCoordinator.java:166)
	at org.hibernate.action.internal.EntityInsertAction.execute(EntityInsertAction.java:95)
	at org.hibernate.engine.spi.ActionQueue.executeActions(ActionQueue.java:621)
	at org.hibernate.event.internal.AbstractFlushingEventListener.performExecutions(AbstractFlushingEventListener.java:343)
	at org.springframework.orm.jpa.JpaTransactionManager.doCommit(JpaTransactionManager.java:561)
	at org.springframework.transaction.interceptor.TransactionInterceptor.invoke(TransactionInterceptor.java:119)
	at fr.creditimmo.dossier.DossierService$$SpringCGLIB$$0.deposer(<generated>)
	at fr.creditimmo.dossier.api.DossierController.deposer(DossierController.java:47)
	at org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:885)
	at org.apache.tomcat.util.threads.TaskThread$WrappingRunnable.run(TaskThread.java:61)
	at java.base/java.lang.Thread.run(Thread.java:840)
⟬end⟭

⟬template⟭
family: logs
format: application log
language: mixed
fill_locale: mixed
domain: SaaS
appearance: pino JSON lines, stand-in values, nested key names, visible business identifiers
scenario: monthly invoice rendering of a French billing product, one JSON line per step across six tenants, where every personal field is already filtered
⟬text⟭
{"level":30,"time":"⟬date#1⟭ 03:00:01","pid":3821,"hostname":"⟬hostname#1⟭","name":"factur-worker","version":"⟬version#1⟭","msg":"worker started"}
{"level":30,"time":"⟬date#1⟭ 03:00:01","pid":3821,"msg":"connected","queue":"pdf-render","redis":"⟬hostname#2⟭:6379","password":"⟬trap:placeholder|***⟭"}
{"level":30,"time":"⟬date#1⟭ 03:00:02","pid":3821,"msg":"campagne mensuelle ouverte","release":"⟬trap:eponym|⦃given⦄⟭","tenants":6}
{"level":20,"time":"⟬date#1⟭ 03:00:02","pid":3821,"msg":"retry policy loaded","backoff":"⟬trap:eponym|Fibonacci⟭","max_attempts":5,"user":"⟬trap:indicator_non_pii|svc-render⟭"}
{"level":30,"time":"⟬date#1⟭ 03:00:04","pid":3821,"msg":"tenant loaded","tenant":"⟬customer_id#1⟭","company":"⟬company#1⟭","owner":"⟬trap:indicator_non_pii|sales-ops⟭"}
{"level":30,"time":"⟬date#1⟭ 03:00:04","pid":3821,"msg":"factures en file","tenant":"⟬customer_id#1⟭","count":3}
{"level":20,"time":"⟬date#1⟭ 03:00:05","pid":3821,"msg":"rendering","tenant":"⟬customer_id#1⟭","invoice":"⟬invoice_number#1⟭","layout":"a4-fr"}
{"level":30,"time":"⟬date#1⟭ 03:00:06","pid":3821,"msg":"facture générée","invoice":"⟬invoice_number#1⟭","bytes":48122,"path":"tenants/1/out/1.pdf"}
{"level":20,"time":"⟬date#1⟭ 03:00:06","pid":3821,"msg":"mail queued","invoice":"⟬invoice_number#1⟭","email":"⟬trap:indicator_non_pii|[FILTERED]⟭"}
{"level":20,"time":"⟬date#1⟭ 03:00:07","pid":3821,"msg":"rendering","tenant":"⟬customer_id#1⟭","invoice":"⟬invoice_number#2⟭","layout":"a4-fr"}
{"level":30,"time":"⟬date#1⟭ 03:00:08","pid":3821,"msg":"facture générée","invoice":"⟬invoice_number#2⟭","bytes":51904,"path":"tenants/1/out/2.pdf"}
{"level":20,"time":"⟬date#1⟭ 03:00:08","pid":3821,"msg":"mail queued","invoice":"⟬invoice_number#2⟭","email":"⟬trap:indicator_non_pii|[FILTERED]⟭"}
{"level":20,"time":"⟬date#1⟭ 03:00:09","pid":3821,"msg":"rendering","tenant":"⟬customer_id#1⟭","invoice":"⟬invoice_number#3⟭","layout":"a4-en"}
{"level":40,"time":"⟬date#1⟭ 03:00:39","pid":3821,"msg":"render timeout, retry","invoice":"⟬invoice_number#3⟭","attempt":2,"ctx":"queue=pdf shard=2"}
{"level":30,"time":"⟬date#1⟭ 03:00:41","pid":3821,"msg":"facture générée","invoice":"⟬invoice_number#3⟭","bytes":47310,"path":"tenants/1/out/3.pdf"}
{"level":20,"time":"⟬date#1⟭ 03:00:41","pid":3821,"msg":"mail queued","invoice":"⟬invoice_number#3⟭","email":"⟬trap:indicator_non_pii|[FILTERED]⟭"}
{"level":30,"time":"⟬date#1⟭ 03:00:42","pid":3821,"msg":"tenant done","tenant":"⟬customer_id#1⟭","ok":3,"ko":0}
{"level":30,"time":"⟬date#1⟭ 03:00:43","pid":3821,"msg":"tenant loaded","tenant":"⟬customer_id#2⟭","company":"⟬company#2⟭","owner":"⟬trap:indicator_non_pii|customer-success⟭"}
{"level":30,"time":"⟬date#1⟭ 03:00:43","pid":3821,"msg":"factures en file","tenant":"⟬customer_id#2⟭","count":2}
{"level":20,"time":"⟬date#1⟭ 03:00:44","pid":3821,"msg":"seller address resolved","tenant":"⟬customer_id#2⟭","city":"⟬city#2⟭","postcode":"⟬postcode#2⟭","country":"⟬country#2⟭"}
{"level":20,"time":"⟬date#1⟭ 03:00:45","pid":3821,"msg":"rendering","tenant":"⟬customer_id#2⟭","invoice":"⟬invoice_number#4⟭","layout":"a4-fr"}
{"level":30,"time":"⟬date#1⟭ 03:00:46","pid":3821,"msg":"facture générée","invoice":"⟬invoice_number#4⟭","bytes":49877,"path":"tenants/2/out/1.pdf"}
{"level":20,"time":"⟬date#1⟭ 03:00:47","pid":3821,"msg":"rendering","tenant":"⟬customer_id#2⟭","invoice":"⟬invoice_number#5⟭","layout":"a4-fr"}
{"level":50,"time":"⟬date#1⟭ 03:00:47","pid":3821,"msg":"template introuvable","template":"⟬trap:code_identifier|facture_⦃family⦄_v2⟭","tenant":"⟬customer_id#2⟭"}
{"level":30,"time":"⟬date#1⟭ 03:00:48","pid":3821,"msg":"fallback template used","invoice":"⟬invoice_number#5⟭","author":"⟬trap:indicator_non_pii|billing-bot⟭"}
{"level":30,"time":"⟬date#1⟭ 03:00:49","pid":3821,"msg":"facture générée","invoice":"⟬invoice_number#5⟭","bytes":50210,"path":"tenants/2/out/2.pdf"}
{"level":30,"time":"⟬date#1⟭ 03:00:49","pid":3821,"msg":"tenant done","tenant":"⟬customer_id#2⟭","ok":2,"ko":0}
{"level":30,"time":"⟬date#1⟭ 03:00:50","pid":3821,"msg":"tenant loaded","tenant":"⟬customer_id#3⟭","company":"⟬company#3⟭","owner":"⟬trap:indicator_non_pii|sales-ops⟭"}
{"level":30,"time":"⟬date#1⟭ 03:00:50","pid":3821,"msg":"aucune facture ce mois-ci","tenant":"⟬customer_id#3⟭"}
{"level":30,"time":"⟬date#1⟭ 03:00:51","pid":3821,"msg":"tenant loaded","tenant":"⟬customer_id#4⟭","company":"⟬company#4⟭","owner":"⟬trap:indicator_non_pii|partner-desk⟭"}
{"level":30,"time":"⟬date#1⟭ 03:00:51","pid":3821,"msg":"factures en file","tenant":"⟬customer_id#4⟭","count":2}
{"level":20,"time":"⟬date#1⟭ 03:00:52","pid":3821,"msg":"payment reference computed","invoice":"⟬invoice_number#6⟭","checksum":"⟬trap:eponym|Luhn⟭","ref":"⟬order_number#1⟭"}
{"level":30,"time":"⟬date#1⟭ 03:00:53","pid":3821,"msg":"facture générée","invoice":"⟬invoice_number#6⟭","bytes":46990,"path":"tenants/4/out/1.pdf"}
{"level":20,"time":"⟬date#1⟭ 03:00:53","pid":3821,"msg":"mail queued","invoice":"⟬invoice_number#6⟭","email":"⟬trap:indicator_non_pii|[FILTERED]⟭"}
{"level":20,"time":"⟬date#1⟭ 03:00:54","pid":3821,"msg":"payment reference computed","invoice":"⟬invoice_number#7⟭","checksum":"⟬trap:eponym|Luhn⟭","ref":"⟬order_number#2⟭"}
{"level":30,"time":"⟬date#1⟭ 03:00:55","pid":3821,"msg":"facture générée","invoice":"⟬invoice_number#7⟭","bytes":47722,"path":"tenants/4/out/2.pdf"}
{"level":20,"time":"⟬date#1⟭ 03:00:55","pid":3821,"msg":"mail queued","invoice":"⟬invoice_number#7⟭","email":"⟬trap:indicator_non_pii|[FILTERED]⟭"}
{"level":30,"time":"⟬date#1⟭ 03:00:56","pid":3821,"msg":"tenant done","tenant":"⟬customer_id#4⟭","ok":2,"ko":0}
{"level":30,"time":"⟬date#1⟭ 03:00:57","pid":3821,"msg":"tenant loaded","tenant":"⟬customer_id#5⟭","company":"⟬company#5⟭","owner":"⟬trap:indicator_non_pii|customer-success⟭"}
{"level":30,"time":"⟬date#1⟭ 03:00:57","pid":3821,"msg":"factures en file","tenant":"⟬customer_id#5⟭","count":1}
{"level":20,"time":"⟬date#1⟭ 03:00:58","pid":3821,"msg":"rendering","tenant":"⟬customer_id#5⟭","invoice":"⟬invoice_number#8⟭","layout":"letter-en"}
{"level":40,"time":"⟬date#1⟭ 03:00:59","pid":3821,"msg":"logo manquant, rendu sans image","tenant":"⟬customer_id#5⟭","value":"logo.svg"}
{"level":30,"time":"⟬date#1⟭ 03:01:00","pid":3821,"msg":"facture générée","invoice":"⟬invoice_number#8⟭","bytes":32018,"path":"tenants/5/out/1.pdf"}
{"level":20,"time":"⟬date#1⟭ 03:01:00","pid":3821,"msg":"mail skipped","invoice":"⟬invoice_number#8⟭","reason":"opt-out","contact":"⟬trap:indicator_non_pii|none⟭"}
{"level":30,"time":"⟬date#1⟭ 03:01:01","pid":3821,"msg":"tenant done","tenant":"⟬customer_id#5⟭","ok":1,"ko":0}
{"level":30,"time":"⟬date#1⟭ 03:01:02","pid":3821,"msg":"tenant loaded","tenant":"⟬customer_id#6⟭","company":"⟬company#6⟭","owner":"⟬trap:indicator_non_pii|partner-desk⟭"}
{"level":30,"time":"⟬date#1⟭ 03:01:02","pid":3821,"msg":"factures en file","tenant":"⟬customer_id#6⟭","count":2}
{"level":20,"time":"⟬date#1⟭ 03:01:03","pid":3821,"msg":"tax table selected","tenant":"⟬customer_id#6⟭","country":"⟬country#6⟭","regime":"intra-EU"}
{"level":20,"time":"⟬date#1⟭ 03:01:04","pid":3821,"msg":"rendering","tenant":"⟬customer_id#6⟭","invoice":"⟬invoice_number#9⟭","layout":"a4-fr"}
{"level":30,"time":"⟬date#1⟭ 03:01:05","pid":3821,"msg":"facture générée","invoice":"⟬invoice_number#9⟭","bytes":52001,"path":"tenants/6/out/1.pdf"}
{"level":20,"time":"⟬date#1⟭ 03:01:05","pid":3821,"msg":"rendering","tenant":"⟬customer_id#6⟭","invoice":"⟬invoice_number#10⟭","layout":"a4-fr"}
{"level":50,"time":"⟬date#1⟭ 03:01:35","pid":3821,"msg":"render failed","invoice":"⟬invoice_number#10⟭","attempt":5,"ctx":"queue=pdf shard=1 oom=true"}
{"level":40,"time":"⟬date#1⟭ 03:01:35","pid":3821,"msg":"facture placée en reprise manuelle","invoice":"⟬invoice_number#10⟭","ticket":"⟬ticket_id#1⟭"}
{"level":30,"time":"⟬date#1⟭ 03:01:36","pid":3821,"msg":"tenant done","tenant":"⟬customer_id#6⟭","ok":1,"ko":1}
{"level":30,"time":"⟬date#1⟭ 03:01:37","pid":3821,"msg":"export comptable","file":"exports/ledger.csv","rows":10,"customer":"⟬trap:indicator_non_pii|all⟭"}
{"level":20,"time":"⟬date#1⟭ 03:01:38","pid":3821,"msg":"uploading ledger","url":"⟬url#1⟭","client_ip":"⟬ip_address#1⟭"}
{"level":30,"time":"⟬date#1⟭ 03:01:39","pid":3821,"msg":"ledger uploaded","request_id":"⟬uuid#1⟭","bytes":6817}
{"level":30,"time":"⟬date#1⟭ 03:01:40","pid":3821,"msg":"métriques envoyées","url":"⟬url#2⟭","user":"⟬trap:indicator_non_pii|metrics⟭"}
{"level":30,"time":"⟬date#1⟭ 03:01:41","pid":3821,"msg":"campagne mensuelle fermée","ok":9,"ko":1,"duration_s":100}
{"level":30,"time":"⟬date#1⟭ 03:01:41","pid":3821,"msg":"draining queue","queue":"pdf-render","pending":0}
{"level":20,"time":"⟬date#1⟭ 03:01:42","pid":3821,"msg":"redis disconnect","redis":"⟬hostname#2⟭:6379"}
{"level":30,"time":"⟬date#1⟭ 03:01:42","pid":3821,"msg":"next run scheduled","cron":"0 3 1 * *","owner":"⟬trap:indicator_non_pii|sales-ops⟭"}
{"level":30,"time":"⟬date#1⟭ 03:01:43","pid":3821,"msg":"worker idle"}
{"level":30,"time":"⟬date#1⟭ 03:01:43","pid":3821,"msg":"heartbeat","uptime_s":102}
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: mixed
fill_locale: mixed
domain: SaaS
appearance: GitHub Actions console, shell trace, token in a remote URL, connection string, private key alone on lines, commit author, action references
scenario: GitHub Actions preview deployment of a French booking product, whose script runs with tracing on and prints its token, database URL and SSH key
⟬text⟭
Current runner version: '2.316.1'
Operating System
  Ubuntu
  22.04.4
  LTS
GITHUB_TOKEN Permissions
  Contents: read
  Metadata: read
Secret source: Actions
Prepare workflow directory
Prepare all required actions
Getting action download info
Download action repository '⟬trap:email_lookalike|actions/checkout@v4⟭' (SHA:⟬git_sha#1⟭)
Download action repository '⟬trap:email_lookalike|actions/setup-node@v4⟭' (SHA:⟬git_sha#2⟭)
Complete job name: deploy-preview
Run ⟬trap:email_lookalike|actions/checkout@v4⟭
  with:
    repository: gestion-rdv/agenda-api
    token: ⟬trap:placeholder|***⟭
    ssh-strict: true
    persist-credentials: true
    clean: true
    fetch-depth: 1
Syncing repository: gestion-rdv/agenda-api
Getting Git version info
  Working directory is '/home/runner/work/agenda-api/agenda-api'
  /usr/bin/git version
  git version 2.43.2
Temporarily overriding HOME='/home/runner/work/_temp/⟬uuid#1⟭' before making global git config changes
/usr/bin/git config --local http.https://github.com/.extraheader AUTHORIZATION: basic ⟬trap:placeholder|***⟭
Checking out the ref
  /usr/bin/git log -1 --format='%H %an <%ae>'
  ⟬git_sha#3⟭ ⟬person_name#2⟭ <⟬email#2⟭>
Run ./scripts/deploy_preview.sh
  ./scripts/deploy_preview.sh
  shell: /usr/bin/bash -e {0}
  env:
    GITHUB_ACTOR: ⟬trap:indicator_non_pii|dependabot[bot]⟭
    PREVIEW_ENV: pr-543
+ echo 'déploiement de la préversion pr-543'
déploiement de la préversion pr-543
+ git remote set-url origin https://x-access-token:⟬github_token#1⟭@github.com/gestion-rdv/agenda-api.git
+ git fetch --depth=1 origin refs/heads/main
+ export AWS_ACCESS_KEY_ID=⟬aws_access_key_id#1⟭
+ AWS_ACCESS_KEY_ID=⟬aws_access_key_id#1⟭
+ export DATABASE_URL=postgres://agenda_preview:⟬url_password#1⟭@⟬hostname#1⟭:5432/agenda
+ DATABASE_URL=postgres://agenda_preview:⟬url_password#1⟭@⟬hostname#1⟭:5432/agenda
+ npx prisma migrate deploy
Prisma schema loaded from prisma/schema.prisma
Datasource "db": PostgreSQL database "agenda", schema "public" at "⟬hostname#1⟭:5432"
3 migrations found in prisma/migrations
No pending migrations to apply.
+ echo "$PREVIEW_SSH_KEY"
⟬private_key#1⟭
+ ssh -i /tmp/preview_key -o StrictHostKeyChecking=no ⟬trap:email_lookalike|deploy@preview⟭ 'sudo systemctl restart agenda-api'
Warning: Permanently added 'preview' to the list of known hosts.
+ curl -fsS -X POST ⟬url#1⟭ -d source=ci
curl: (22) The requested URL returned error: 502
+ echo "tests e2e KO, voir avec ⟬person_name:given#2⟭"
tests e2e KO, voir avec ⟬person_name:given#2⟭
Error: Process completed with exit code 22.
Post job cleanup.
/usr/bin/git version
git version 2.43.2
Cleaning up orphan processes
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: mixed
fill_locale: mixed
domain: logistics
appearance: Java stack trace, caused-by chain, stand-in value, company in a field, field holding several values
scenario: label printing service of a parcel network failing on an illegal character in a barcode field, where the recipient is already anonymised
⟬text⟭
⟬date#1⟭ 16:20:11.412 WARN  [label-pool-3] c.t.labels.ZplRenderer - code-barres invalide pour le colis ⟬order_number#1⟭
⟬date#1⟭ 16:20:11.413 DEBUG [label-pool-3] c.t.labels.ZplRenderer - meta="carrier=⟬trap:company_name|Transports ⦃Family⦄⟭ printer=zebra-04 dpi=203"
⟬date#1⟭ 16:20:11.413 DEBUG [label-pool-3] c.t.labels.ZplRenderer - destinataire=⟬trap:indicator_non_pii|<anonymisé>⟭ ville=⟬city#1⟭ cp=⟬postcode#1⟭
⟬date#1⟭ 16:20:11.419 ERROR [label-pool-3] c.t.labels.LabelWorker - job ⟬uuid#1⟭ abandoned after 3 attempts
fr.transport.labels.LabelRenderException: Impossible de générer l'étiquette du colis ⟬order_number#1⟭
	at fr.transport.labels.ZplRenderer.render(ZplRenderer.java:142)
	at ⟬trap:code_identifier|fr.transport.labels.templates.⦃Family⦄LabelTemplate.apply(⦃Family⦄LabelTemplate.java:58)⟭
	at fr.transport.labels.LabelWorker.process(LabelWorker.java:77)
	at fr.transport.labels.LabelWorker.run(LabelWorker.java:51)
	at java.base/java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1136)
	at java.base/java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:635)
	at java.base/java.lang.Thread.run(Thread.java:840)
Caused by: java.lang.IllegalArgumentException: Illegal character in GS1-128 field (AI 420), position 6
	at fr.transport.labels.barcode.Gs1Encoder.encodeField(Gs1Encoder.java:203)
	at fr.transport.labels.barcode.Gs1Encoder.encode(Gs1Encoder.java:118)
	at fr.transport.labels.ZplRenderer.barcode(ZplRenderer.java:188)
	at fr.transport.labels.ZplRenderer.render(ZplRenderer.java:136)
	... 6 common frames omitted
⟬date#1⟭ 16:20:11.424 INFO  [label-pool-3] c.t.labels.LabelWorker - colis ⟬order_number#1⟭ orienté vers le tri manuel, owner=⟬trap:indicator_non_pii|tri-chilly⟭
⟬end⟭

⟬template⟭
family: logs
format: application log
language: mixed
fill_locale: mixed
domain: banking
appearance: log4j line, field holding several values, stand-in values, masked password
scenario: hourly account reconciliation tick of a French bank, where the masking filter has already done its work
⟬text⟭
⟬date#1⟭ 14:00:00,002 INFO  [recon-scheduler] c.b.recon.RibReconJob - tick cron="0 0 * * * *"
⟬date#1⟭ 14:00:00,118 INFO  [recon-scheduler] c.b.recon.RibReconJob - comptes rapprochés : 18412, écarts : 0
⟬date#1⟭ 14:00:00,119 DEBUG [recon-scheduler] c.b.recon.RibReconJob - ctx="shard=3 retries=0 lag_ms=77"
⟬date#1⟭ 14:00:00,120 DEBUG [recon-scheduler] c.b.recon.MaskingFilter - sample holder=⟬trap:indicator_non_pii|[FILTERED]⟭ iban=⟬trap:indicator_non_pii|<masked>⟭ bic=⟬bic#1⟭
⟬date#1⟭ 14:00:00,121 INFO  [recon-scheduler] c.b.recon.Publisher - report sent to ⟬hostname#1⟭:8443 user=⟬trap:indicator_non_pii|svc_recon⟭ password=⟬trap:placeholder|****⟭
⟬date#1⟭ 14:00:00,122 INFO  [recon-scheduler] c.b.recon.RibReconJob - next run in 3600s
⟬end⟭

⟬template⟭
family: logs
format: application log
language: mixed
fill_locale: mixed
domain: SaaS
appearance: Celery log, quoted field, secret under an innocuous key, name without announcer, file path, bearer in a field
scenario: night import of a payroll product for a client with French employees and an American contractor, where the Celery task logs each file row and its webhook callback
⟬text⟭
[⟬date#1⟭ 22:00:04,112: INFO/MainProcess] Task paie.tasks.import_salaries[⟬uuid#1⟭] received
[⟬date#1⟭ 22:00:04,130: INFO/ForkPoolWorker-2] client ⟬customer_id#1⟭ : fichier ⟬file_path#1⟭, 4 lignes
[⟬date#1⟭ 22:00:04,131: INFO/ForkPoolWorker-2] read_csv ok, encoding=latin-1, sep=";"
[⟬date#1⟭ 22:00:04,180: INFO/ForkPoolWorker-2] ligne 1 ok : ⟬person_name#1⟭ nir="⟬fr_social_security_number#1⟭" iban="⟬iban#1⟭"
[⟬date#1⟭ 22:00:04,214: WARNING/ForkPoolWorker-2] ligne 2 rejetée : "⟬person_name#2⟭" NIR invalide "⟬fr_social_security_number#2⟭" pour une naissance le ⟬birth_date#2⟭ et une entrée le ⟬date#2⟭
[⟬date#1⟭ 22:00:04,260: INFO/ForkPoolWorker-2] ligne 3 ok : ⟬person_name#3⟭ ⟬fr_social_security_number#3⟭ iban="⟬iban#3⟭"
[⟬date#1⟭ 22:00:04,301: INFO/ForkPoolWorker-2] ligne 4 contractor US : "⟬person_name#4⟭" ⟬us_itin#4⟭ w8=false
[⟬date#1⟭ 22:00:04,302: WARNING/ForkPoolWorker-2] ligne 4 sans compte bancaire, paiement bloqué
[⟬date#1⟭ 22:00:04,410: INFO/ForkPoolWorker-2] 3 salariés importés, 1 rejet, user=⟬trap:indicator_non_pii|import-sftp⟭
[⟬date#1⟭ 22:00:04,512: INFO/ForkPoolWorker-2] callback vers ⟬url#1⟭
[⟬date#1⟭ 22:00:04,513: DEBUG/ForkPoolWorker-2] dbg="authorization=Bearer ⟬jwt#1⟭ attempt=1"
[⟬date#1⟭ 22:00:05,540: WARNING/ForkPoolWorker-2] callback timeout, retry in 30s
[⟬date#1⟭ 22:00:35,548: DEBUG/ForkPoolWorker-2] dbg="authorization=Bearer ⟬jwt#1⟭ attempt=2"
[⟬date#1⟭ 22:00:35,702: INFO/ForkPoolWorker-2] callback 200, signature value=⟬opaque_token#1⟭
[⟬date#1⟭ 22:00:35,703: INFO/ForkPoolWorker-2] rapport envoyé owner=⟬person_name#5⟭ to=⟬email#5⟭
[⟬date#1⟭ 22:00:35,704: INFO/ForkPoolWorker-2] archive value=⟬file_path#2⟭
[⟬date#1⟭ 22:00:35,710: INFO/ForkPoolWorker-2] Task paie.tasks.import_salaries[⟬uuid#1⟭] succeeded in 31.58s: 3
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: mixed
fill_locale: mixed
domain: e-commerce
appearance: Rails request log, parameters hash, SQL bind, exception message, framework backtrace, secret under an innocuous header, session in a cookie
scenario: Rails checkout of a French online shop crashing on a rejected Stripe key, with the parameters, SQL binds and the Sentry breadcrumb all in the development-level log
⟬text⟭
Started POST "/checkout/paiement" for ⟬ip_address#1⟭ at ⟬date#1⟭ 19:22:41 +0100
Processing by Checkout::PaymentsController#create as HTML
  Parameters: {"authenticity_token"=>"⟬opaque_token#1⟭", "commande"=>{"email"=>"⟬email#1⟭", "nom"=>"⟬person_name#1⟭", "adresse"=>"⟬fr_postal_address#1⟭", "tel"=>"⟬phone#1⟭"}, "carte"=>{"numero"=>"⟬payment_card#1⟭", "cvc"=>"⟬card_security_code#1⟭"}, "commit"=>"Payer"}
  Cart Load (0.6ms)  SELECT "carts".* FROM "carts" WHERE "carts"."token" = $1 LIMIT $2  [["token", "⟬opaque_token#2⟭"], ["LIMIT", 1]]
  ↳ app/controllers/concerns/current_cart.rb:12:in `set_cart'
  CartItem Load (0.9ms)  SELECT "cart_items".* FROM "cart_items" WHERE "cart_items"."cart_id" = $1  [["cart_id", 418227]]
  ↳ app/models/cart.rb:48:in `total_ttc'
  Coupon Load (0.3ms)  SELECT "coupons".* FROM "coupons" WHERE "coupons"."code" = $1 LIMIT $2  [["code", "BIENVENUE10"], ["LIMIT", 1]]
  ↳ app/models/cart.rb:61:in `remise'
  TRANSACTION (0.2ms)  BEGIN
  ↳ app/services/checkout/create_order.rb:17:in `call'
  Order Create (1.4ms)  INSERT INTO "orders" ("reference", "customer_email", "total_cents") VALUES ($1, $2, $3) RETURNING "id"  [["reference", "⟬order_number#1⟭"], ["customer_email", "⟬email#1⟭"], ["total_cents", 8790]]
  ↳ app/services/checkout/create_order.rb:18:in `call'
  TRANSACTION (0.8ms)  COMMIT
  ↳ app/services/checkout/create_order.rb:17:in `call'
  Address Load (0.4ms)  SELECT "addresses".* FROM "addresses" WHERE "addresses"."customer_id" = $1 LIMIT $2  [["customer_id", 8841], ["LIMIT", 1]]
  ↳ app/models/customer.rb:33:in `adresse_livraison'
  Shipping::Rate Load (0.7ms)  SELECT "shipping_rates".* FROM "shipping_rates" WHERE "shipping_rates"."zone" = $1  [["zone", "FR-METRO"]]
  ↳ app/services/shipping/quote.rb:22:in `call'
[checkout] tentative de paiement pour la commande ⟬order_number#1⟭, montant 87,90 EUR
[checkout] client Stripe initialisé api_key=⟬stripe_secret_key#1⟭ idempotency=⟬uuid#1⟭
Completed 500 Internal Server Error in 812ms (ActiveRecord: 12.4ms | Allocations: 80424)

Stripe::AuthenticationError (Invalid API Key provided: ⟬stripe_secret_key#1⟭):

stripe (⟬version#1⟭) lib/stripe/stripe_client.rb:788:in `handle_error_response'
stripe (⟬version#1⟭) lib/stripe/stripe_client.rb:744:in `block in execute_request_internal'
stripe (⟬version#1⟭) lib/stripe/stripe_client.rb:503:in `execute_request'
stripe (⟬version#1⟭) lib/stripe/api_operations/request.rb:31:in `execute_resource_request'
stripe (⟬version#1⟭) lib/stripe/api_operations/create.rb:7:in `create'
app/services/checkout/charge_card.rb:89:in `call'
app/controllers/checkout/payments_controller.rb:23:in `create'
actionpack (⟬version#2⟭) lib/action_controller/metal/basic_implicit_render.rb:6:in `send_action'
actionpack (⟬version#2⟭) lib/abstract_controller/base.rb:224:in `process_action'
actionpack (⟬version#2⟭) lib/action_controller/metal/rendering.rb:53:in `process_action'
actionpack (⟬version#2⟭) lib/abstract_controller/callbacks.rb:256:in `block in process_action'
activesupport (⟬version#2⟭) lib/active_support/callbacks.rb:121:in `block in run_callbacks'
activesupport (⟬version#2⟭) lib/active_support/callbacks.rb:141:in `run_callbacks'
actionpack (⟬version#2⟭) lib/abstract_controller/callbacks.rb:255:in `process_action'
actionpack (⟬version#2⟭) lib/action_controller/metal/rescue.rb:27:in `process_action'
actionpack (⟬version#2⟭) lib/action_controller/metal/instrumentation.rb:76:in `process_action'
activerecord (⟬version#2⟭) lib/active_record/railties/controller_runtime.rb:27:in `process_action'
actionpack (⟬version#2⟭) lib/action_dispatch/routing/route_set.rb:49:in `dispatch'
actionpack (⟬version#2⟭) lib/action_dispatch/middleware/cookies.rb:689:in `call'
actionpack (⟬version#2⟭) lib/action_dispatch/middleware/show_exceptions.rb:31:in `call'
actionpack (⟬version#2⟭) lib/action_dispatch/middleware/callbacks.rb:29:in `call'
actionpack (⟬version#2⟭) lib/action_dispatch/middleware/executor.rb:14:in `call'
actionpack (⟬version#2⟭) lib/action_dispatch/middleware/request_id.rb:28:in `call'
railties (⟬version#2⟭) lib/rails/rack/logger.rb:40:in `call_app'
railties (⟬version#2⟭) lib/rails/engine.rb:536:in `call'
rack (⟬version#3⟭) lib/rack/head.rb:12:in `call'
rack (⟬version#3⟭) lib/rack/runtime.rb:24:in `call'
rack (⟬version#3⟭) lib/rack/method_override.rb:24:in `call'
rack (⟬version#3⟭) lib/rack/sendfile.rb:110:in `call'
puma (⟬version#4⟭) lib/puma/configuration.rb:272:in `call'
puma (⟬version#4⟭) lib/puma/request.rb:100:in `block in handle_request'
puma (⟬version#4⟭) lib/puma/server.rb:443:in `process_client'
puma (⟬version#4⟭) lib/puma/thread_pool.rb:147:in `block in spawn_thread'

[Sentry] Sending event ⟬uuid#2⟭ to ⟬url#1⟭
[Sentry] user context: {"id"=>50214, "email"=>"⟬email#1⟭"}
[Sentry] breadcrumb: payment form submitted by ⟬person_name#1⟭
[Sentry] request headers: {"Cookie"=>"_boutique_session=⟬jwt#1⟭", "X-Client-Ref"=>"⟬opaque_token#3⟭", "User-Agent"=>"Mozilla/5.0"}
[Sentry] tags: {"release"=>"⟬version#5⟭", "customer"=>"⟬person_name#1⟭", "owner"=>"⟬trap:indicator_non_pii|team-tunnel⟭"}
[checkout] commande ⟬order_number#1⟭ repassée en attente de paiement
[checkout] mail d'échec envoyé à ⟬email#1⟭
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: mixed
fill_locale: mixed
domain: banking
appearance: GitLab CI job, exported variables, connection string in a command, private key alone on lines, JSON block, password in a command argument
scenario: GitLab job of a French bank's payment infrastructure repository, whose script exports its AWS keys, runs psql with the migration URL and echoes the EBICS signing key
⟬text⟭
Running with gitlab-runner ⟬version#1⟭ (⟬git_sha#1⟭)
  on ⟬hostname#1⟭ shared-04
Preparing the "docker" executor
Using Docker executor with image ⟬hostname#2⟭:5000/ci/tf-psql:1.7 ...
Preparing environment
Running on runner-shared-04-project-690-concurrent-0 via ⟬hostname#1⟭...
Getting source from Git repository
Fetching changes with git depth set to 20...
Reinitialized existing Git repository in /builds/coffre/virements-infra/.git/
Checking out ⟬git_sha#2⟭ as detached HEAD (ref is main)...
Skipping Git submodules setup
Executing "step_script" stage of the job script
$ export AWS_ACCESS_KEY_ID=⟬aws_access_key_id#1⟭
$ export AWS_SECRET_ACCESS_KEY=⟬aws_secret_access_key#1⟭
$ aws sts get-caller-identity
{
    "UserId": "⟬trap:indicator_non_pii|terraform-ci⟭",
    "Arn": "arn:aws:iam::role/terraform-ci"
}
$ terraform plan -var "db_password=⟬password#1⟭" -out tfplan
Acquiring state lock. This may take a few moments...
No changes. Your infrastructure matches the configuration.
$ psql "postgresql://migration:⟬url_password#1⟭@⟬hostname#3⟭:5432/coffre" -c "select count(*) from virements_en_attente"
 count
-------
    12
(1 row)
$ echo "clé EBICS utilisée :" && echo "$EBICS_PRIVATE_KEY"
clé EBICS utilisée :
⟬private_key#1⟭
$ ./scripts/send_ebics_probe.sh
curl: (35) OpenSSL SSL_connect: Connection reset by peer in connection to ⟬hostname#4⟭:443
Cleaning up project directory and file based variables
ERROR: Job failed: exit code 35
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: mixed
fill_locale: mixed
domain: SaaS
appearance: Celery error line, Python traceback, local variables dump, credentials in a tuple
scenario: nightly export of a French analytics product failing on S3, whose error reporter dumps the frame locals with the AWS credentials of the tenant bucket
⟬text⟭
[⟬date#1⟭ 02:14:08,331: ERROR/ForkPoolWorker-3] Task exports.tasks.push_to_s3[⟬uuid#1⟭] raised unexpected: ClientError('SignatureDoesNotMatch')
[⟬date#1⟭ 02:14:08,332: ERROR/ForkPoolWorker-3] échec de l'export pour le client ⟬customer_id#1⟭, fichier ⟬file_path#1⟭
Traceback (most recent call last):
  File "/app/.venv/lib/python3.11/site-packages/celery/app/trace.py", line 477, in trace_task
    R = retval = fun(*args, **kwargs)
  File "/app/.venv/lib/python3.11/site-packages/celery/app/trace.py", line 760, in __protected_call__
    return self.run(*args, **kwargs)
  File "/app/exports/tasks.py", line 96, in push_to_s3
    client.upload_file(local_path, bucket, key)
  File "/app/.venv/lib/python3.11/site-packages/boto3/s3/transfer.py", line 372, in upload_file
    future.result()
  File "/app/.venv/lib/python3.11/site-packages/botocore/client.py", line 553, in _api_call
    return self._make_api_call(operation_name, kwargs)
  File "/app/.venv/lib/python3.11/site-packages/botocore/client.py", line 1009, in _make_api_call
    raise error_class(parsed_response, operation_name)
botocore.exceptions.ClientError: An error occurred (SignatureDoesNotMatch) when calling the PutObject operation: The request signature we calculated does not match the signature you provided. Check your key and signing method.

Frame locals of push_to_s3:
    bucket = 'exports-clients-eu'
    key = 'tenants/report.csv.gz'
    region = 'eu-west-3'
    creds = ('⟬aws_access_key_id#1⟭', '⟬aws_secret_access_key#1⟭')
    local_path = '⟬file_path#1⟭'
    owner = "⟬person_name#2⟭"
    attempts = 3
⟬end⟭

⟬template⟭
family: logs
format: application log
language: mixed
fill_locale: mixed
domain: e-commerce
appearance: structlog console line, field holding several values, secret under an innocuous key, reviewer on both sides, initial and family name
scenario: seller onboarding of a French marketplace on a day with an American, a French and a British applicant, whose KYC module logs the identity payload at debug level
⟬text⟭
⟬date#1⟭ 10:11:02 [info     ] seller_onboarding.started      seller=⟬customer_id#1⟭ country=US step=identity
⟬date#1⟭ 10:11:02 [debug    ] kyc.request                    attrs="name=⟬person_name#1⟭ itin=⟬us_itin#1⟭ dob=⟬birth_date#1⟭ applied=⟬date#2⟭"
⟬date#1⟭ 10:11:03 [debug    ] kyc.vendor_call                url=⟬url#1⟭ ref=⟬opaque_token#1⟭
⟬date#1⟭ 10:11:04 [info     ] kyc.vendor_response            status=200 decision=PASS score=0.97 request_id=⟬uuid#1⟭
⟬date#1⟭ 10:11:05 [info     ] payout.account_saved           seller=⟬customer_id#1⟭ iban="⟬iban#1⟭" bic=⟬bic#1⟭
⟬date#1⟭ 10:11:05 [info     ] seller_onboarding.done         seller=⟬customer_id#1⟭ reviewer="⟬trap:indicator_non_pii|auto-kyc⟭"
⟬date#1⟭ 10:32:17 [info     ] seller_onboarding.started      seller=⟬customer_id#2⟭ country=FR step=identity
⟬date#1⟭ 10:32:18 [debug    ] kyc.request                    attrs="gérant=⟬person_name#2m⟭ nir=⟬fr_social_security_number#2⟭ né le ⟬birth_date#2⟭ gérant depuis le ⟬date#3⟭"
⟬date#1⟭ 10:32:18 [debug    ] kyc.company                    raison_sociale="⟬company#2⟭" siren="⟬fr_siren#2⟭" ville=⟬city#2⟭
⟬date#1⟭ 10:32:19 [debug    ] kyc.vendor_call                url=⟬url#1⟭ ref=⟬opaque_token#1⟭
⟬date#1⟭ 10:32:20 [info     ] kyc.vendor_response            status=200 decision=PASS score=0.93 request_id=⟬uuid#2⟭
⟬date#1⟭ 10:32:21 [info     ] seller_onboarding.done         seller=⟬customer_id#2⟭ reviewer=⟬trap:indicator_non_pii|auto-kyc⟭
⟬date#1⟭ 10:49:40 [info     ] seller_onboarding.started      seller=⟬customer_id#3⟭ country=GB step=identity
⟬date#1⟭ 10:49:41 [warning  ] kyc.document_mismatch          expected="⟬person_name#3⟭" got="⟬person_name:initial#3⟭" doc=driving_licence number="⟬uk_driving_licence#3⟭"
⟬date#1⟭ 10:49:41 [info     ] kyc.review_opened              case=⟬ticket_id#1⟭ reviewer="⟬trap:indicator_non_pii|kyc-queue-uk⟭"
⟬date#1⟭ 11:20:03 [info     ] kyc.review_closed              case=⟬ticket_id#1⟭ reviewer="⟬person_name#4⟭" decision=APPROVED note="initiale seule sur le permis, dossier conforme"
⟬date#1⟭ 11:20:04 [info     ] notification.queued            to="⟬email#3⟭" template=vendeur_valide
⟬date#1⟭ 11:20:04 [info     ] seller_onboarding.done         seller=⟬customer_id#3⟭ reviewer=⟬person_name#4⟭
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: mixed
fill_locale: mixed
domain: logistics
appearance: Laravel exception, SQL insert values, PHP frames, print_r dump, company in a field
scenario: Laravel import of partner drivers at a Franco-British carrier, stopped by a duplicate licence, with the rejected row printed after the frames
⟬text⟭
[⟬date#1⟭ 13:44:10] production.ERROR: SQLSTATE[23000]: Integrity constraint violation: 1062 Duplicate entry for key 'chauffeurs_permis_unique' (SQL: insert into `chauffeurs` (`nom`, `permis`, `tel`, `transporteur`, `created_at`) values ("⟬person_name#1⟭", "⟬uk_driving_licence#1⟭", "⟬phone#1⟭", "⟬trap:company_name|⦃Family⦄ Freight⟭", now())) {"exception":"[object] (Illuminate\\Database\\QueryException(code: 23000) at /var/www/html/vendor/laravel/framework/src/Illuminate/Database/Connection.php:760)
[stacktrace]
#0 /var/www/html/vendor/laravel/framework/src/Illuminate/Database/Connection.php(720): Illuminate\\Database\\Connection->runQueryCallback()
#1 /var/www/html/vendor/laravel/framework/src/Illuminate/Database/Connection.php(546): Illuminate\\Database\\Connection->run()
#2 /var/www/html/vendor/laravel/framework/src/Illuminate/Database/Query/Builder.php(3362): Illuminate\\Database\\Connection->insert()
#3 /var/www/html/vendor/laravel/framework/src/Illuminate/Database/Eloquent/Builder.php(1873): Illuminate\\Database\\Query\\Builder->insertGetId()
#4 /var/www/html/vendor/laravel/framework/src/Illuminate/Database/Eloquent/Model.php(1333): Illuminate\\Database\\Eloquent\\Builder->__call()
#5 /var/www/html/vendor/laravel/framework/src/Illuminate/Database/Eloquent/Model.php(1298): Illuminate\\Database\\Eloquent\\Model->performInsert()
#6 /var/www/html/app/Services/Chauffeurs/ImportPartenaire.php(58): Illuminate\\Database\\Eloquent\\Model->save()
#7 /var/www/html/app/Services/Chauffeurs/ImportPartenaire.php(31): App\\Services\\Chauffeurs\\ImportPartenaire->ligne()
#8 /var/www/html/app/Jobs/ImportChauffeursJob.php(27): App\\Services\\Chauffeurs\\ImportPartenaire->run()
#9 /var/www/html/vendor/laravel/framework/src/Illuminate/Queue/CallQueuedHandler.php(120): App\\Jobs\\ImportChauffeursJob->handle()
#10 /var/www/html/vendor/laravel/framework/src/Illuminate/Queue/Worker.php(428): Illuminate\\Queue\\CallQueuedHandler->call()
#11 {main}
"}
[⟬date#1⟭ 13:44:10] production.WARNING: Ligne rejetée, reprise manuelle demandée à ⟬person_name#2⟭
Array
(
    [nom] => ⟬person_name#1⟭
    [permis] => ⟬uk_driving_licence#1⟭
    [plaque] => ⟬uk_license_plate#1⟭
    [manager] => ⟬person_name#2⟭
)
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: mixed
fill_locale: mixed
domain: logistics
appearance: Bitbucket Pipelines shell trace, private key alone on lines, Ansible recap
scenario: Bitbucket pipeline pushing configuration to warehouse scanners, whose tee of the deployment key lands in the build log
⟬text⟭
+ echo "déploiement bornes entrepôt"
déploiement bornes entrepôt
+ echo "$SSH_DEPLOY_KEY" | tee ~/.ssh/id_deploy
⟬private_key#1⟭
+ chmod 600 ~/.ssh/id_deploy
+ ansible-playbook -i inventories/prod bornes.yml --private-key ~/.ssh/id_deploy
PLAY [bornes de quai] **********************************************************
TASK [push config] *************************************************************
changed: [⟬hostname#1⟭]
changed: [⟬hostname#2⟭]
PLAY RECAP *********************************************************************
⟬hostname#1⟭ : ok=2 changed=1 unreachable=0 failed=0
⟬hostname#2⟭ : ok=2 changed=1 unreachable=0 failed=0
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: mixed
fill_locale: mixed
domain: e-commerce
appearance: CircleCI step, token in a clone URL, npm token in a command, scoped package name
scenario: CircleCI step publishing a shop's design tokens, where the job sets its registry token on the command line and clones with a personal token
⟬text⟭
#!/bin/bash -eo pipefail
npm config set //registry.npmjs.org/:_authToken=⟬npm_token#1⟭
git clone https://⟬github_token#1⟭@github.com/boutique-exemple/design-tokens.git vendor/tokens
Cloning into 'vendor/tokens'...
npm notice package: ⟬trap:email_lookalike|@boutique-exemple/design-tokens⟭
npm notice Publishing to ⟬url#1⟭ with tag latest and restricted access
npm ERR! code E403
npm ERR! 403 Forbidden - You cannot publish over the previously published version ⟬version#1⟭
npm ERR! A complete log of this run can be found in: /home/circleci/.npm/_logs/debug-0.log

Exited with code exit status 1
⟬end⟭
