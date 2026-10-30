⟬template⟭
family: logs
format: application log
language: mixed
fill_locale: mixed
domain: banking
appearance: batch log, quoted field, future due date, customer on both sides, account number under a French label
scenario: morning processing of SEPA direct debit returns at a French bank, where each rejected collection is logged with its debtor and its next presentation date
⟬text⟭
⟬date#2⟭ 06:00:02 INFO  sdd.returns - lecture du fichier camt.054 ⟬file_path#1⟭
⟬date#2⟭ 06:00:02 INFO  sdd.returns - 6 retours, lot ⟬uuid#1⟭, user=⟬trap:indicator_non_pii|svc_sdd⟭
⟬date#2⟭ 06:00:03 WARN  sdd.returns - R-tx AM04 mandat=⟬order_number#1⟭ customer=⟬person_name#1⟭ iban="⟬iban#1⟭" montant=89.00
⟬date#2⟭ 06:00:03 INFO  sdd.returns - représentation prévue le ⟬date#1⟭
⟬date#2⟭ 06:00:03 WARN  sdd.returns - R-tx MD01 mandat=⟬order_number#2⟭ customer="⟬person_name#2⟭" iban="⟬iban#2⟭" montant=412.50
⟬date#2⟭ 06:00:03 INFO  sdd.returns - mandat révoqué, pas de représentation
⟬date#2⟭ 06:00:04 WARN  sdd.returns - R-tx AC04 mandat=⟬order_number#3⟭ customer=⟬trap:indicator_non_pii|compte-technique-sdd⟭ montant=0.01
⟬date#2⟭ 06:00:04 INFO  sdd.returns - prélèvement de contrôle ignoré
⟬date#2⟭ 06:00:04 WARN  sdd.returns - R-tx MS02 mandat=⟬order_number#4⟭ customer=⟬person_name#4⟭ iban="⟬iban#4⟭" montant=57.30
⟬date#2⟭ 06:00:05 INFO  sdd.returns - contestation enregistrée, conseiller "⟬person_name#5m⟭" prévenu
⟬date#2⟭ 06:00:05 WARN  sdd.returns - R-tx AM04 mandat=⟬order_number#5⟭ customer=⟬person_name#6⟭ compte ⟬bank_account_number#6⟭ montant=33.00
⟬date#2⟭ 06:00:05 INFO  sdd.returns - représentation prévue le ⟬date#1⟭
⟬date#2⟭ 06:00:06 WARN  sdd.returns - R-tx AG01 mandat=⟬order_number#6⟭ customer="⟬trap:indicator_non_pii|anonymise-rgpd⟭" montant=19.90
⟬date#2⟭ 06:00:06 INFO  sdd.returns - lot ⟬uuid#1⟭ terminé, 2 représentations, 1 contestation
⟬date#2⟭ 06:00:07 INFO  sdd.returns - rapport déposé sur ⟬hostname#1⟭:22, owner=⟬trap:indicator_non_pii|back-office-flux⟭
⟬date#2⟭ 06:00:07 INFO  sdd.returns - prochaine fenêtre de remise le ⟬date#1⟭ à 18:00
⟬end⟭

⟬template⟭
family: logs
format: application log
language: mixed
fill_locale: mixed
domain: banking
appearance: Logback line, bearer token alone in a header line, third-party company, name after an announcing word
scenario: PSD2 account access gateway of a French bank at debug level, serving an aggregator named after its founder
⟬text⟭
⟬date#1⟭ 14:12:08.204 [http-nio-8443-exec-3] INFO  f.b.psd2.ConsentFilter - GET /v1/accounts consent=⟬uuid#1⟭ tpp="⟬trap:company_name|⦃Family⦄ Finance⟭"
⟬date#1⟭ 14:12:08.205 [http-nio-8443-exec-3] DEBUG f.b.psd2.ConsentFilter - Authorization: Bearer ⟬jwt#1⟭
⟬date#1⟭ 14:12:08.330 [http-nio-8443-exec-3] INFO  f.b.psd2.AccountsResource - 2 comptes renvoyés psu="⟬person_name#1⟭" X-Request-ID=⟬uuid#2⟭
⟬date#1⟭ 14:12:08.331 [http-nio-8443-exec-3] DEBUG f.b.psd2.AuditWriter - tpp certificate fingerprint ⟬hash#1⟭
⟬date#1⟭ 14:12:08.332 [http-nio-8443-exec-3] INFO  f.b.psd2.AuditWriter - quota 3/4, reset dans 21600s
⟬end⟭

⟬template⟭
family: logs
format: application log
language: mixed
fill_locale: mixed
domain: SaaS
appearance: zap JSON lines, provider keys, prompt preview, name and social security number in a free text field, cloud storage secret
scenario: contract summary feature of a French legal SaaS, whose gateway logs its provider keys and a preview of the prompt built from the uploaded document
⟬text⟭
{"level":"info","ts":"⟬date#1⟭ 11:02:11","caller":"api/server.go:61","msg":"POST /v1/summaries","tenant":"⟬customer_id#1⟭","user":"⟬person_name#2⟭"}
{"level":"debug","ts":"⟬date#1⟭ 11:02:11","caller":"store/s3.go:40","msg":"fetching document","bucket":"contrats-eu","secret":"⟬aws_secret_access_key#1⟭"}
{"level":"info","ts":"⟬date#1⟭ 11:02:12","caller":"extract/pdf.go:88","msg":"texte extrait","pages":12,"chars":28114}
{"level":"debug","ts":"⟬date#1⟭ 11:02:12","caller":"llm/client.go:88","msg":"provider call","provider":"anthropic","api_key":"⟬anthropic_api_key#1⟭","tier":"large"}
{"level":"debug","ts":"⟬date#1⟭ 11:02:12","caller":"llm/prompt.go:31","msg":"prompt preview","preview":"Résume le contrat de travail de ⟬person_name#3⟭, NIR ⟬fr_social_security_number#3⟭, poste ⟬job_title#3⟭ à ⟬city#3⟭"}
{"level":"warn","ts":"⟬date#1⟭ 11:02:42","caller":"llm/client.go:112","msg":"upstream timeout","provider":"anthropic","attempt":1}
{"level":"debug","ts":"⟬date#1⟭ 11:02:42","caller":"llm/client.go:88","msg":"provider call","provider":"openai","api_key":"⟬openai_api_key#1⟭","tier":"large"}
{"level":"info","ts":"⟬date#1⟭ 11:02:56","caller":"llm/client.go:131","msg":"completion ok","provider":"openai","tokens":1204,"latency_ms":13911}
{"level":"debug","ts":"⟬date#1⟭ 11:02:56","caller":"llm/prompt.go:58","msg":"completion preview","preview":"Le salarié ⟬person_name:family#3m⟭ est soumis à une clause de non-concurrence."}
{"level":"info","ts":"⟬date#1⟭ 11:02:57","caller":"api/server.go:74","msg":"summary stored","summary":"⟬uuid#1⟭","user":"⟬person_name#2⟭"}
{"level":"info","ts":"⟬date#1⟭ 11:04:30","caller":"api/server.go:61","msg":"POST /v1/summaries","tenant":"⟬customer_id#1⟭","user":"⟬trap:indicator_non_pii|batch-import⟭"}
{"level":"debug","ts":"⟬date#1⟭ 11:04:30","caller":"store/s3.go:40","msg":"fetching document","bucket":"contrats-eu","value":"⟬aws_secret_access_key#1⟭"}
{"level":"warn","ts":"⟬date#1⟭ 11:04:31","caller":"extract/pdf.go:102","msg":"document vide","pages":0,"ctx":"ocr=off lang=fr"}
{"level":"info","ts":"⟬date#1⟭ 11:04:31","caller":"api/server.go:80","msg":"request rejected","status":422,"owner":"⟬trap:indicator_non_pii|team-ingestion⟭"}
{"level":"info","ts":"⟬date#1⟭ 11:05:00","caller":"metrics/flush.go:22","msg":"usage flushed","tokens":1204,"author":"⟬trap:indicator_non_pii|usage-meter⟭"}
{"level":"info","ts":"⟬date#1⟭ 11:05:00","caller":"mail/notify.go:44","msg":"synthèse envoyée","to":"⟬email#2⟭","owner":"⟬person_name#2⟭"}
⟬end⟭

⟬template⟭
family: logs
format: application log
language: mixed
fill_locale: mixed
domain: e-commerce
appearance: syslog line, several days, rule hits, card without a key, split billing and shipping fields, initials alone, tax identifier, session token
scenario: three days of the fraud engine of a French marketplace, from the card velocity alerts of the first night to a payout hold on an American seller and a British buyer's identity check
⟬text⟭
⟬date#3⟭ 23:50:02 fraud-engine[8839]: rules reloaded, 33 active, version ⟬version#1⟭
⟬date#3⟭ 23:52:14 fraud-engine[8839]: rule=velocity_card order=⟬order_number#1⟭ ⟬payment_card#1⟭ ip=⟬ip_address#1⟭ score=88
⟬date#3⟭ 23:52:14 fraud-engine[8839]: rule=velocity_card order=⟬order_number#2⟭ ⟬payment_card#1⟭ ip=⟬ip_address#1⟭ score=91
⟬date#3⟭ 23:52:15 fraud-engine[8839]: blocage carte après 2 tentatives, customer=⟬trap:indicator_non_pii|guest⟭
⟬date#3⟭ 23:58:40 fraud-engine[8839]: rule=address_mismatch order=⟬order_number#3⟭ customer="⟬person_name#2⟭" email=⟬email#2⟭
⟬date#3⟭ 23:58:40 fraud-engine[8839]: bill="⟬fr_postal_address#2⟭" ship="⟬postal_address#3⟭"
⟬date#3⟭ 23:58:41 fraud-engine[8839]: score=62 décision=REVIEW file=fraud-review
⟬date#3⟭ 23:59:30 fraud-engine[8839]: stats window=1h alerts=3 blocked=1 review=1
⟬date#2⟭ 00:04:02 fraud-engine[8839]: nightly model refresh started
⟬date#2⟭ 00:06:47 fraud-engine[8839]: nightly model refresh done, algo=⟬trap:eponym|Mahalanobis⟭ distance features=64
⟬date#2⟭ 08:12:31 fraud-engine[8839]: review opened order=⟬order_number#3⟭ analyst=⟬trap:initials|ML⟭
⟬date#2⟭ 08:15:10 fraud-engine[8839]: appel client au ⟬phone#2⟭, adresse de livraison confirmée
⟬date#2⟭ 08:15:44 fraud-engine[8839]: review closed order=⟬order_number#3⟭ analyst=⟬trap:initials|ML⟭ décision=ACCEPT
⟬date#2⟭ 09:02:09 fraud-engine[8839]: rule=new_device order=⟬order_number#4⟭ customer=⟬person_name#4⟭ device=⟬uuid#1⟭ score=35
⟬date#2⟭ 09:02:09 fraud-engine[8839]: décision=ALLOW order=⟬order_number#4⟭
⟬date#2⟭ 10:31:18 fraud-engine[8839]: rule=refund_abuse customer=⟬person_name#5⟭ refunds_30d=6 score=74
⟬date#2⟭ 10:31:18 fraud-engine[8839]: décision=REVIEW file=fraud-review owner=⟬trap:indicator_non_pii|trust-safety⟭
⟬date#2⟭ 11:40:02 fraud-engine[8839]: review opened customer="⟬person_name#5⟭" analyst=⟬person_name#6⟭
⟬date#2⟭ 11:52:27 fraud-engine[8839]: note="retours légitimes, taille non conforme" analyst=⟬person_name#6⟭
⟬date#2⟭ 11:52:28 fraud-engine[8839]: review closed customer="⟬person_name#5⟭" décision=ACCEPT
⟬date#2⟭ 14:18:05 fraud-engine[8839]: rule=seller_payout_spike seller=⟬customer_id#7⟭ amount=18450.00 ccy=USD score=81
⟬date#2⟭ 14:18:05 fraud-engine[8839]: payout gelé, seller="⟬person_name#7⟭" ⟬us_itin#7⟭ iban="⟬iban#7⟭"
⟬date#2⟭ 14:18:06 fraud-engine[8839]: ticket ⟬ticket_id#1⟭ ouvert pour le support vendeurs
⟬date#2⟭ 14:40:51 fraud-engine[8839]: seller session token=⟬jwt#1⟭ ip=⟬ip_address#7⟭ pays=⟬country#7⟭
⟬date#2⟭ 14:41:20 fraud-engine[8839]: documents reçus de "⟬person_name#7⟭", statut pending
⟬date#2⟭ 15:05:02 fraud-engine[8839]: rule=velocity_card order=⟬order_number#8⟭ ⟬payment_card#8⟭ ip=⟬ip_address#8⟭ score=44
⟬date#2⟭ 15:05:02 fraud-engine[8839]: décision=ALLOW order=⟬order_number#8⟭
⟬date#2⟭ 18:30:00 fraud-engine[8839]: stats window=24h alerts=9 blocked=1 review=3
⟬date#2⟭ 22:47:13 fraud-engine[8839]: rule=high_value_first_order order=⟬order_number#9⟭ customer=⟬person_name#9⟭ amount=2140.00
⟬date#2⟭ 22:47:14 fraud-engine[8839]: identity check requested for "⟬person_name#9⟭", market=UK
⟬date#2⟭ 22:51:36 fraud-engine[8839]: identity vendor ref=⟬opaque_token#1⟭ doc=driving_licence number="⟬uk_driving_licence#9⟭" dob=⟬birth_date#9⟭ issued=⟬date#4⟭
⟬date#2⟭ 22:51:37 fraud-engine[8839]: identity vendor decision=PASS request_id=⟬uuid#2⟭
⟬date#2⟭ 22:51:37 fraud-engine[8839]: décision=ALLOW order=⟬order_number#9⟭
⟬date#1⟭ 00:04:01 fraud-engine[8839]: nightly model refresh started
⟬date#1⟭ 00:06:39 fraud-engine[8839]: nightly model refresh done, algo=⟬trap:eponym|Mahalanobis⟭ distance features=64
⟬date#1⟭ 07:58:44 fraud-engine[8839]: rule=account_takeover customer=⟬person_name#10⟭ new_ip=⟬ip_address#10⟭ score=93
⟬date#1⟭ 07:58:44 fraud-engine[8839]: session révoquée, mail envoyé à ⟬email#10⟭
⟬date#1⟭ 07:58:45 fraud-engine[8839]: password reset forced, operator=⟬trap:indicator_non_pii|fraud-engine⟭
⟬date#1⟭ 08:30:12 fraud-engine[8839]: review opened customer="⟬person_name#10⟭" analyst=⟬trap:initials|ML⟭
⟬date#1⟭ 08:44:03 fraud-engine[8839]: review closed customer=⟬person_name#10⟭ analyst=⟬trap:initials|ML⟭ décision=ACCEPT
⟬date#1⟭ 09:10:17 fraud-engine[8839]: support ticket ⟬ticket_id#1⟭ repris par "⟬person_name#6⟭"
⟬date#1⟭ 09:12:48 fraud-engine[8839]: pièce vendeur validée, seller=⟬customer_id#7⟭ operator="⟬person_name#6⟭"
⟬date#1⟭ 09:12:49 fraud-engine[8839]: payout dégelé, seller=⟬customer_id#7⟭ amount=18450.00 ccy=USD
⟬date#1⟭ 09:30:00 fraud-engine[8839]: stats window=1h alerts=1 blocked=0 review=1
⟬date#1⟭ 10:02:21 fraud-engine[8839]: rule=address_mismatch order=⟬order_number#11⟭ customer="⟬trap:indicator_non_pii|guest⟭" pays=⟬country#11⟭
⟬date#1⟭ 10:02:21 fraud-engine[8839]: décision=ALLOW order=⟬order_number#11⟭
⟬date#1⟭ 10:30:00 fraud-engine[8839]: stats window=1h alerts=1 blocked=0 review=0
⟬date#1⟭ 11:02:38 fraud-engine[8839]: rule=velocity_card order=⟬order_number#12⟭ ip=⟬ip_address#12⟭ score=22
⟬date#1⟭ 11:02:38 fraud-engine[8839]: décision=ALLOW order=⟬order_number#12⟭
⟬date#1⟭ 11:30:00 fraud-engine[8839]: stats window=1h alerts=1 blocked=0 review=0
⟬date#1⟭ 12:00:00 fraud-engine[8839]: rules reload skipped, no change
⟬date#1⟭ 12:14:09 fraud-engine[8839]: rule=refund_abuse customer=⟬person_name#13⟭ refunds_30d=4 score=51
⟬date#1⟭ 12:14:09 fraud-engine[8839]: décision=ALLOW, surveillance 30 jours
⟬date#1⟭ 12:30:00 fraud-engine[8839]: stats window=1h alerts=1 blocked=0 review=0
⟬date#1⟭ 13:30:00 fraud-engine[8839]: stats window=1h alerts=0 blocked=0 review=0
⟬date#1⟭ 13:41:27 fraud-engine[8839]: rule=gift_card_burst order=⟬order_number#14⟭ customer="⟬person_name#14⟭" qty=12 score=79
⟬date#1⟭ 13:41:27 fraud-engine[8839]: décision=REVIEW file=fraud-review owner=⟬trap:indicator_non_pii|trust-safety⟭
⟬date#1⟭ 13:58:02 fraud-engine[8839]: review closed order=⟬order_number#14⟭ analyst=⟬person_name#6⟭ décision=REFUSE
⟬date#1⟭ 13:58:03 fraud-engine[8839]: remboursement carte ⟬payment_card#14⟭ demandé
⟬date#1⟭ 14:30:00 fraud-engine[8839]: stats window=1h alerts=1 blocked=0 review=1
⟬date#1⟭ 15:30:00 fraud-engine[8839]: stats window=1h alerts=0 blocked=0 review=0
⟬date#1⟭ 16:00:00 fraud-engine[8839]: export hebdomadaire ⟬file_path#1⟭ user="⟬trap:indicator_non_pii|svc-fraud-export⟭"
⟬date#1⟭ 16:00:02 fraud-engine[8839]: rotation du journal terminée
⟬end⟭

⟬template⟭
family: logs
format: application log
language: mixed
fill_locale: mixed
domain: e-commerce
appearance: plain log line, colour in a product name, anonymous customer, field holding several values
scenario: cache warmer of a French fashion shop, run every night against its category pages, with no customer in sight
⟬text⟭
⟬date#1⟭ 05:00:01 cache-warmer INFO démarrage, 1204 pages à réchauffer, customer=⟬trap:indicator_non_pii|anonymous⟭
⟬date#1⟭ 05:00:44 cache-warmer INFO catégorie "⟬trap:word_name|Rose poudré⟭" réchauffée en 212 ms
⟬date#1⟭ 05:00:45 cache-warmer INFO catégorie "⟬trap:word_name|Pierre de lune⟭" réchauffée en 188 ms
⟬date#1⟭ 05:02:10 cache-warmer WARN 3 pages en 404, voir ⟬url#1⟭
⟬date#1⟭ 05:02:11 cache-warmer DEBUG dbg="hit=1180 miss=24 region=eu-west-3"
⟬date#1⟭ 05:02:11 cache-warmer INFO terminé
⟬end⟭

⟬template⟭
family: logs
format: application log
language: mixed
fill_locale: mixed
domain: logistics
appearance: warehouse control log, automatic operator, initials on a shift note, eponym, company in a field, ctx field
scenario: warehouse control system of a French distribution centre during a conveyor jam, driven by automatic jobs and a shift note signed with initials
⟬text⟭
⟬date#1⟭ 13:00:02.114 WCS INFO  poste AUTO ouvert, opérateur=⟬trap:indicator_non_pii|AUTO⟭
⟬date#1⟭ 13:00:02.410 WCS INFO  chargement du plan de zone, 18 allées, routage ⟬trap:eponym|Dijkstra⟭
⟬date#1⟭ 13:02:41.002 WCS INFO  bac 40412 affecté au convoyeur C3 ctx="zone=B allee=12 prio=2"
⟬date#1⟭ 13:02:44.118 WCS INFO  bac 40413 affecté au convoyeur C3 ctx="zone=B allee=14 prio=1"
⟬date#1⟭ 13:03:10.507 WCS WARN  capteur photo S-218 sans impulsion depuis 8s
⟬date#1⟭ 13:03:18.511 WCS ERROR bourrage détecté convoyeur C3 entre S-218 et S-219
⟬date#1⟭ 13:03:18.640 WCS INFO  convoyeur C3 arrêté, 14 bacs en attente
⟬date#1⟭ 13:03:18.702 WCS INFO  alerte envoyée à l'astreinte maintenance ⟬trap:company_name|⦃Family⦄ Manutention⟭
⟬date#1⟭ 13:04:02.118 WCS INFO  bacs redirigés vers C4, operator=⟬trap:indicator_non_pii|reroute-auto⟭
⟬date#1⟭ 13:11:47.320 WCS INFO  intervention ouverte ⟬ticket_id#1⟭, équipe B
⟬date#1⟭ 13:24:09.015 WCS INFO  capteur S-218 remplacé, note="carton écrasé retiré, RAS, ⟬trap:initials|J.-P.⟭"
⟬date#1⟭ 13:24:30.118 WCS INFO  convoyeur C3 redémarré
⟬date#1⟭ 13:24:31.002 WCS INFO  bac 40412 repris
⟬date#1⟭ 13:24:31.640 WCS INFO  bac 40413 repris
⟬date#1⟭ 13:30:00.001 WCS INFO  débit 830 bacs/h, objectif 520
⟬date#1⟭ 13:45:00.001 WCS INFO  débit 502 bacs/h, objectif 520
⟬date#1⟭ 14:00:00.001 WCS INFO  débit 533 bacs/h, objectif 520
⟬date#1⟭ 14:00:00.640 WCS INFO  export vers ⟬hostname#1⟭:5140, user=⟬trap:indicator_non_pii|wcs-reporting⟭
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: mixed
fill_locale: mixed
domain: banking
appearance: CICS abend, COMMAREA dump, column labels, operator code
scenario: mainframe transfer transaction of a French bank abending, whose error routine prints the communication area of the customer in progress
⟬text⟭
DFHAC2206 ⟬date#1⟭ 10:14:22 CICSPRD1 Transaction VIRT failed with abend ASRA. Updates to local recoverable resources backed out.
CEE3204S The system detected a protection exception (System Completion Code=0C4).
         From compile unit VIRT0410 at entry point VIRT0410 at compile unit offset +A12.
         Called from VIRT0100 at offset +3F8.
COMMAREA dump:
  NOM       : ⟬person_name#1⟭
  NIR       : ⟬fr_social_security_number#1⟭
  COMPTE    : ⟬bank_account_number#1⟭
  AGENCE    : ⟬city#1⟭
  CODE-ERR  : 0C4
  OPERATEUR : ⟬trap:indicator_non_pii|TPVIR01⟭
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: mixed
fill_locale: mixed
domain: banking
appearance: Ktor error, Kotlin frames, JSON input in an exception, French message, tax identifier, driving licence
scenario: account opening API of a French neobank, whose JSON decoder quotes the whole application in its exception when the ID scan vendor sends a number instead of a string
⟬text⟭
⟬date#1⟭ 12:31:40.118 [eventLoopGroupProxy-4-2] INFO  f.n.onboarding.Routes - POST /v2/ouvertures 500 in 41ms
⟬date#1⟭ 12:31:40.119 [eventLoopGroupProxy-4-2] ERROR f.n.onboarding.Routes - échec ouverture de compte, dossier ⟬uuid#1⟭
kotlinx.serialization.json.internal.JsonDecodingException: Unexpected JSON token at offset 214: Expected string literal but found number at path: $.score_ocr
JSON input: {"nom":"⟬person_name#1⟭","naissance":"⟬birth_date#1⟭","depot":"⟬date#2⟭","tin":"⟬us_itin#1⟭","iban":"⟬iban#1⟭","permis":"⟬uk_driving_licence#1⟭","score_ocr":0.97}
	at kotlinx.serialization.json.internal.JsonExceptionsKt.JsonDecodingException(JsonExceptions.kt:24)
	at kotlinx.serialization.json.internal.AbstractJsonLexer.fail(AbstractJsonLexer.kt:580)
	at kotlinx.serialization.json.internal.AbstractJsonLexer.fail$default(AbstractJsonLexer.kt:578)
	at kotlinx.serialization.json.internal.StreamingJsonDecoder.decodeSerializableValue(StreamingJsonDecoder.kt:72)
	at kotlinx.serialization.json.Json.decodeFromString(Json.kt:107)
	at fr.neobanque.onboarding.vendor.ScanClient.parse(ScanClient.kt:61)
	at fr.neobanque.onboarding.vendor.ScanClient$verifier$2.invokeSuspend(ScanClient.kt:44)
	at kotlin.coroutines.jvm.internal.BaseContinuationImpl.resumeWith(ContinuationImpl.kt:33)
	at fr.neobanque.onboarding.Routes$ouverture$1.invokeSuspend(Routes.kt:88)
	at io.ktor.server.routing.Route$buildPipeline$1$1.invokeSuspend(Route.kt:116)
	at io.ktor.util.pipeline.SuspendFunctionGun.loop(SuspendFunctionGun.kt:120)
	at io.ktor.server.netty.NettyApplicationCallHandler.handleRequest(NettyApplicationCallHandler.kt:37)
	at io.netty.util.concurrent.SingleThreadEventExecutor$4.run(SingleThreadEventExecutor.java:997)
	at java.base/java.lang.Thread.run(Thread.java:840)
⟬date#1⟭ 12:31:40.204 [eventLoopGroupProxy-4-2] WARN  f.n.onboarding.Alert - incident vendeur transmis, owner=⟬trap:indicator_non_pii|squad-onboarding⟭
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: mixed
fill_locale: mixed
domain: SaaS
appearance: uvicorn error, chained Python tracebacks, SQL parameters, engine URL, request headers dump
scenario: member registration API of a French mutual insurance SaaS on FastAPI, where a duplicate raises through asyncpg and SQLAlchemy, and the handler logs the engine URL and request headers
⟬text⟭
INFO:     ⟬ip_address#1⟭ - "POST /v2/adherents HTTP/1.1" 500 Internal Server Error
ERROR:    Exception in ASGI application
Traceback (most recent call last):
  File "/app/.venv/lib/python3.12/site-packages/asyncpg/connection.py", line 1742, in execute
    result = await self._protocol.query(query, timeout)
  File "asyncpg/protocol/protocol.pyx", line 354, in query
asyncpg.exceptions.UniqueViolationError: duplicate key value violates unique constraint "adherents_nir_key"
DETAIL:  Key (nir)=(⟬fr_social_security_number#1⟭) already exists.

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/app/.venv/lib/python3.12/site-packages/sqlalchemy/engine/base.py", line 1867, in _exec_single_context
    self.dialect.do_execute(
  File "/app/.venv/lib/python3.12/site-packages/sqlalchemy/engine/default.py", line 924, in do_execute
    cursor.execute(statement, parameters)
  File "/app/.venv/lib/python3.12/site-packages/sqlalchemy/dialects/postgresql/asyncpg.py", line 580, in execute
    self._adapt_connection.await_(self._prepare_and_execute(operation, parameters))
sqlalchemy.exc.IntegrityError: (sqlalchemy.dialects.postgresql.asyncpg.IntegrityError) duplicate key value violates unique constraint "adherents_nir_key"
[SQL: INSERT INTO adherents (nom, nir, iban, tenant_id) VALUES ($1, $2, $3, $4) RETURNING id]
[parameters: ("⟬person_name#1⟭", "⟬fr_social_security_number#1⟭", "⟬iban#1⟭", 464)]
(Background on this error at: https://sqlalche.me/e/20/gkpj)

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/app/.venv/lib/python3.12/site-packages/uvicorn/protocols/http/httptools_impl.py", line 426, in run_asgi
    result = await app(self.scope, self.receive, self.send)
  File "/app/.venv/lib/python3.12/site-packages/uvicorn/middleware/proxy_headers.py", line 84, in __call__
    return await self.app(scope, receive, send)
  File "/app/.venv/lib/python3.12/site-packages/starlette/applications.py", line 123, in __call__
    await self.middleware_stack(scope, receive, send)
  File "/app/.venv/lib/python3.12/site-packages/starlette/middleware/errors.py", line 186, in __call__
    raise exc
  File "/app/.venv/lib/python3.12/site-packages/starlette/middleware/cors.py", line 83, in __call__
    await self.app(scope, receive, send)
  File "/app/.venv/lib/python3.12/site-packages/starlette/middleware/exceptions.py", line 62, in __call__
    await wrap_app_handling_exceptions(self.app, conn)(scope, receive, send)
  File "/app/.venv/lib/python3.12/site-packages/starlette/_exception_handler.py", line 64, in wrapped_app
    raise exc
  File "/app/.venv/lib/python3.12/site-packages/starlette/_exception_handler.py", line 53, in wrapped_app
    await app(scope, receive, sender)
  File "/app/.venv/lib/python3.12/site-packages/starlette/routing.py", line 758, in __call__
    await self.middleware_stack(scope, receive, send)
  File "/app/.venv/lib/python3.12/site-packages/starlette/routing.py", line 778, in app
    await route.handle(scope, receive, send)
  File "/app/.venv/lib/python3.12/site-packages/starlette/routing.py", line 299, in handle
    await self.app(scope, receive, send)
  File "/app/.venv/lib/python3.12/site-packages/starlette/routing.py", line 79, in app
    await wrap_app_handling_exceptions(app, request)(scope, receive, send)
  File "/app/.venv/lib/python3.12/site-packages/fastapi/routing.py", line 299, in app
    raise e
  File "/app/.venv/lib/python3.12/site-packages/fastapi/routing.py", line 294, in app
    raw_response = await run_endpoint_function(
  File "/app/api/routes/adherents.py", line 71, in creer_adherent
    adherent = await service.creer(session, payload)
  File "/app/api/services/adherents.py", line 38, in creer
    raise DoublonAdherent(payload.nom)
app.errors.DoublonAdherent: adhérent déjà connu pour le tenant 464 : ⟬person_name#1⟭

⟬date#1⟭ 09:44:12,118 ERROR app.db - engine: postgresql+asyncpg://adherents_api:⟬url_password#1⟭@⟬hostname#1⟭:5432/adherents
⟬date#1⟭ 09:44:12,119 ERROR app.http - request headers: {"authorization": "Bearer ⟬jwt#1⟭", "x-client-ref": "⟬opaque_token#1⟭", "x-tenant": "464"}
⟬date#1⟭ 09:44:12,120 INFO  app.http - user=⟬person_name#2⟭ tenant=464 role=gestionnaire
⟬date#1⟭ 09:44:12,121 INFO  app.notify - incident ⟬ticket_id#1⟭ créé, owner=⟬trap:indicator_non_pii|team-adhesion⟭
⟬date#1⟭ 09:44:12,122 INFO  app.notify - relance du gestionnaire au ⟬phone#2⟭
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: mixed
fill_locale: mixed
domain: SaaS
appearance: Elixir GenServer crash, last message, state map, stand-in values, field holding several values
scenario: notification worker of a French team messaging product crashing on a missing ETS table, whose state map holds only stand-ins and a team as owner
⟬text⟭
⟬date#1⟭ 03:12:44.118 [error] GenServer Notifier.Worker terminating
** (ArgumentError) errors were found at the given arguments:

  * 1st argument: the table identifier does not refer to an existing ETS table

    (stdlib 5.2) :ets.lookup(:tenant_cache, "⟬customer_id#1⟭")
    (notifier ⟬version#1⟭) lib/notifier/cache.ex:27: Notifier.Cache.fetch/1
    (notifier ⟬version#1⟭) lib/notifier/worker.ex:90: Notifier.Worker.handle_info/2
    (stdlib 5.2) gen_server.erl:1095: :gen_server.try_dispatch/4
    (stdlib 5.2) gen_server.erl:1183: :gen_server.handle_msg/6
    (stdlib 5.2) proc_lib.erl:241: :proc_lib.init_p_do_apply/3
Last message: {:flush, "⟬customer_id#1⟭"}
State: %{
  batch: 90,
  owner: "⟬trap:indicator_non_pii|team-notif⟭",
  email: "⟬trap:indicator_non_pii|[FILTERED]⟭",
  token: "⟬trap:placeholder|[REDACTED]⟭",
  retries: 3
}
⟬date#1⟭ 03:12:44.120 [info] superviseur : redémarrage attrs="worker=7 restarts=2 window=60s"
⟬date#1⟭ 03:12:44.122 [info] table :tenant_cache recréée par ⟬hostname#1⟭
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: mixed
fill_locale: mixed
domain: e-commerce
appearance: PHP warning, uncaught exception, PHP frames, print_r dump, private key in an array, payment key
scenario: PrestaShop module of a French perfume shop failing to sign a mobile wallet session, whose debug output dumps the module configuration after the fatal error
⟬text⟭
PHP Warning:  openssl_sign(): Supplied key param cannot be coerced into a private key in /var/www/boutique/modules/paiementmobile/src/MerchantSession.php on line 88
PHP Fatal error:  Uncaught PrestaShopException: Échec de la session de paiement pour le panier 29576 in /var/www/boutique/modules/paiementmobile/src/MerchantSession.php:92
Stack trace:
#0 /var/www/boutique/modules/paiementmobile/controllers/front/session.php(70): MerchantSession->signer()
#1 /var/www/boutique/classes/controller/Controller.php(297): PaiementmobileSessionModuleFrontController->postProcess()
#2 /var/www/boutique/classes/Dispatcher.php(518): ControllerCore->run()
#3 /var/www/boutique/index.php(28): DispatcherCore->dispatch()
#4 {main}
  thrown in /var/www/boutique/modules/paiementmobile/src/MerchantSession.php on line 92
[debug] paiementmobile config :
Array
(
    [merchant_id] => merchant.fr.boutique-parfums
    [merchant_key] => ⟬private_key#1⟭
    [psp_sk] => ⟬stripe_secret_key#1⟭
    [webhook_ref] => ⟬opaque_token#1⟭
    [boutique] => ⟬company#2⟭
    [contact_technique] => ⟬email#3⟭
)
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: mixed
fill_locale: mixed
domain: logistics
appearance: Sidekiq warning, Ruby frames, library in a class name
scenario: Sidekiq retry of a carrier rate lookup at a French freight broker, failing on a 503 with the name-bearing HTTP client in every frame
⟬text⟭
⟬date#1⟭ 10:02:11 pid=8181 tid=32 class=TarifTransporteurJob jid=⟬uuid#1⟭ WARN: ⟬trap:library|Faraday::ServerError⟭: the server responded with status 503
⟬date#1⟭ 10:02:11 pid=8181 tid=32 class=TarifTransporteurJob jid=⟬uuid#1⟭ WARN: /app/vendor/bundle/ruby/3.2.0/gems/⟬trap:library|faraday-2.9.0⟭/lib/faraday/response/raise_error.rb:30:in `on_complete'
⟬date#1⟭ 10:02:11 pid=8181 tid=32 class=TarifTransporteurJob jid=⟬uuid#1⟭ WARN: /app/app/clients/tarif_client.rb:22:in `grille'
⟬date#1⟭ 10:02:11 pid=8181 tid=32 class=TarifTransporteurJob jid=⟬uuid#1⟭ WARN: /app/app/jobs/tarif_transporteur_job.rb:9:in `perform'
⟬date#1⟭ 10:02:11 pid=8181 tid=32 class=TarifTransporteurJob jid=⟬uuid#1⟭ INFO: retry 3 in 88s, queue=tarifs
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: mixed
fill_locale: mixed
domain: logistics
appearance: Akka error line, Scala frames, case class dump, passport numbers, library frame
scenario: crew manifest validator of a short-sea container line, whose Akka actor rejects a member and prints the case classes of the crew being checked
⟬text⟭
[ERROR] [⟬date#1⟭ 21:14:03.118] [manifest-system-akka.actor.default-dispatcher-7] [akka://manifest-system/user/crew-validator] Manifeste ⟬order_number#1⟭ rejeté
java.lang.IllegalStateException: Document de voyage absent pour CrewMember(name="⟬person_name#1⟭", rank=Bosun, birth="⟬birth_date#1⟭", signed_on="⟬date#2⟭", passport=None, licence="⟬uk_driving_licence#1⟭")
	at fr.armement.manifest.CrewValidator.requirePassport(CrewValidator.scala:61)
	at fr.armement.manifest.CrewValidator.$anonfun$validate$1(CrewValidator.scala:44)
	at scala.collection.immutable.List.foreach(List.scala:333)
	at fr.armement.manifest.CrewValidator.validate(CrewValidator.scala:43)
	at fr.armement.manifest.CrewActor$$anonfun$receive$1.applyOrElse(CrewActor.scala:28)
	at akka.actor.Actor.aroundReceive(Actor.scala:537)
	at akka.actor.ActorCell.invoke(ActorCell.scala:547)
	at akka.dispatch.Mailbox.run(Mailbox.scala:231)
	at java.base/java.util.concurrent.ForkJoinTask.doExec(ForkJoinTask.java:373)
Caused by: ⟬trap:library|com.fasterxml.jackson.databind.exc.MismatchedInputException⟭: Cannot deserialize value of type `CrewDocument` from Object value
 at [Source: (String)"{"type":"PASSEPORT","numero":null}"; line: 1, column: 1]
	at ⟬trap:library|com.fasterxml.jackson.databind.ObjectMapper.readValue⟭(ObjectMapper.java:3604)
	at fr.armement.manifest.CrewCodec.decode(CrewCodec.scala:19)
	... 7 common frames omitted
[INFO] [⟬date#1⟭ 21:14:03.122] [manifest-system-akka.actor.default-dispatcher-7] [akka://manifest-system/user/crew-validator] Reste de l'équipage vérifié :
  CrewMember(name="⟬person_name#2⟭", rank=Master, birth="⟬birth_date#2⟭", signed_on="⟬date#3⟭", passport="⟬uk_passport#2⟭")
  CrewMember(name="⟬person_name#3⟭", rank=ChiefEngineer, birth="⟬birth_date#3⟭", signed_on="⟬date#3⟭", passport="⟬fr_passport#3⟭")
  CrewMember(name="⟬person_name#4⟭", rank=Cook, birth="⟬birth_date#4⟭", signed_on="⟬date#2⟭", passport="⟬fr_passport#4⟭")
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: mixed
fill_locale: mixed
domain: banking
appearance: gitleaks report, finding block, commit author, secret alone on a field, bot author
scenario: secret scan stage of a French bank's GitLab, with redaction turned off, reporting three old commits with their keys, authors and emails
⟬text⟭
$ gitleaks detect --source . --redact=0 --no-banner -v
⟬date#1⟭ 07:02:11 INF scanning 8735 commits, owner=⟬trap:indicator_non_pii|secops-ci⟭
Finding:     AWS_SECRET_ACCESS_KEY=⟬aws_secret_access_key#1⟭
Secret:      ⟬aws_secret_access_key#1⟭
RuleID:      aws-secret-access-key
Entropy:     4.84
File:        deploy/old/env.sh
Line:        12
Commit:      ⟬git_sha#1⟭
Author:      ⟬person_name#2⟭
Email:       ⟬email#2⟭
Date:        ⟬date#3⟭ 18:44:02

Finding:     export AWS_ACCESS_KEY_ID=⟬aws_access_key_id#1⟭
Secret:      ⟬aws_access_key_id#1⟭
RuleID:      aws-access-token
Entropy:     3.92
File:        deploy/old/env.sh
Line:        11
Commit:      ⟬git_sha#1⟭
Author:      ⟬person_name#2⟭
Email:       ⟬email#2⟭
Date:        ⟬date#3⟭ 18:44:02

Finding:     psp_key: ⟬stripe_secret_key#1⟭
Secret:      ⟬stripe_secret_key#1⟭
RuleID:      stripe-access-token
Entropy:     4.61
File:        src/test/resources/psp.yml
Line:        4
Commit:      ⟬git_sha#2⟭
Author:      ⟬trap:indicator_non_pii|renovate[bot]⟭
Email:       ⟬email:generic#4⟭
Date:        ⟬date#2⟭ 09:12:37

Finding:     url = https://⟬github_token#1⟭@github.com/coffre/scripts.git
Secret:      ⟬github_token#1⟭
RuleID:      github-pat
Entropy:     4.77
File:        .gitmodules
Line:        3
Commit:      ⟬git_sha#3⟭
Author:      ⟬person_name#5⟭
Email:       ⟬email#5⟭
Date:        ⟬date#2⟭ 16:30:10

⟬date#1⟭ 07:02:58 WRN leaks found: 4
ERROR: Job failed: exit code 1
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: mixed
fill_locale: mixed
domain: SaaS
appearance: printenv output, sorted variables, technical USER and PWD, webhook token, handle
scenario: CircleCI debugging step left in a French SaaS pipeline, which prints the whole environment of the job
⟬text⟭
#!/bin/bash -eo pipefail
printenv | sort
AWS_ACCESS_KEY_ID=⟬aws_access_key_id#1⟭
AWS_SECRET_ACCESS_KEY=⟬aws_secret_access_key#1⟭
CI=true
CIRCLE_BRANCH=main
CIRCLE_USERNAME=⟬person_name:handle#2⟭
DATABASE_URL=postgres://ci:⟬url_password#1⟭@⟬hostname#1⟭:5432/app_ci
HOME=/home/circleci
PWD=⟬trap:indicator_non_pii|/home/circleci/project⟭
SLACK_TOKEN=⟬slack_token#1⟭
USER=⟬trap:indicator_non_pii|circleci⟭
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: mixed
fill_locale: mixed
domain: SaaS
appearance: Buildkite groups, CLI flag token, private key alone on lines, Slack payload, bearer token in a curl command, author in an environment variable
scenario: Buildkite release of a French document signing product, with a debug group that prints the deploy key and a Slack notification naming the author
⟬text⟭
~~~ Running global environment hook
BUILDKITE_BUILD_AUTHOR="⟬person_name#2⟭"
BUILDKITE_BRANCH=main
~~~ Preparing working directory
$ git clone -v -- https://x-access-token:⟬github_token#1⟭@github.com/signature-exemple/parapheur.git .
Cloning into '.'...
$ git checkout -f ⟬git_sha#1⟭
HEAD is now at ⟬git_sha#1⟭ feat(parapheur): relance automatique des signataires
+++ :rocket: Release
$ sentry-cli releases new ⟬version#1⟭ --auth-token ⟬opaque_token#1⟭
Created release ⟬version#1⟭
$ sentry-cli releases files ⟬version#1⟭ upload-sourcemaps dist/
> Found 88 files
> Uploaded release files to Sentry
~~~ debug deploy key
$ echo "$DEPLOY_KEY"
⟬private_key#1⟭
~~~ Smoke test
$ curl -fsS -H "Authorization: Bearer ⟬jwt#1⟭" ⟬url#1⟭
{"status":"ok","version":"⟬version#1⟭"}
~~~ Notify
$ curl -s -X POST https://slack.com/api/chat.postMessage -H "Authorization: Bearer ⟬slack_token#1⟭" -d @message.json
{"ok":true,"channel":"deploiements","message":{"text":"Parapheur en production, merci ⟬person_name:given#2⟭"}}
~~~ Done
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: mixed
fill_locale: mixed
domain: SaaS
appearance: GitLab CI job, pip install lines, pytest verbose output, code identifiers, masked variables, library names, coverage table
scenario: GitLab test job of a French timesheet product, a long clean run of installs and tests with masked variables and nothing sensitive printed
⟬text⟭
Running with gitlab-runner ⟬version#1⟭ (⟬git_sha#1⟭)
  on ⟬hostname#1⟭ shared-02
Preparing the "docker" executor
Using Docker executor with image python:3.12-slim ...
Preparing environment
Getting source from Git repository
Fetching changes with git depth set to 20...
Checking out ⟬git_sha#2⟭ as detached HEAD (ref is main)...
Executing "step_script" stage of the job script
$ env | grep -E "^(CI_|APP_)" | sort
APP_DB_PASSWORD=⟬trap:placeholder|[MASKED]⟭
APP_ENV=test
APP_SECRET=⟬trap:placeholder|[MASKED]⟭
CI_COMMIT_AUTHOR=⟬trap:indicator_non_pii|renovate[bot]⟭
CI_PROJECT_NAME=feuille-de-temps
$ pip install -r requirements-dev.txt
Collecting ⟬trap:library|Django==4.2.11⟭
Collecting ⟬trap:library|luigi==3.5.0⟭
Collecting pytest==8.1.1
Collecting pytest-cov==5.0.0
Collecting factory-boy==3.3.0
Collecting ⟬trap:library|ray==2.10.0⟭
Installing collected packages: asgiref, sqlparse, ⟬trap:library|Django⟭, tornado, ⟬trap:library|luigi⟭, iniconfig, pluggy, pytest, coverage, pytest-cov
Successfully installed 24 packages
$ pytest -v --cov=app --cov-report=term
============================= test session starts ==============================
platform linux -- Python 3.12.2, pytest-8.1.1, pluggy-1.4.0
rootdir: /builds/rh/feuille-de-temps
plugins: cov-5.0.0, django-4.8.0
collected 18 items

tests/test_export.py::⟬trap:code_identifier|test_format_⦃family⦄_csv⟭ PASSED      [  5%]
tests/test_export.py::test_export_mensuel_vide PASSED                            [ 11%]
tests/test_export.py::test_export_mois_incomplet PASSED                          [ 16%]
tests/test_feries.py::test_lundi_de_paques PASSED                                [ 22%]
tests/test_feries.py::test_jours_feries_alsace PASSED                            [ 27%]
tests/test_feries.py::⟬trap:code_identifier|test_algorithme_⦃family2⦄_paques⟭ PASSED [ 33%]
tests/test_heures.py::test_cumul_semaine PASSED                                  [ 38%]
tests/test_heures.py::test_heures_supplementaires PASSED                         [ 44%]
tests/test_heures.py::test_arrondi_quart_heure PASSED                            [ 50%]
tests/test_heures.py::test_pause_dejeuner PASSED                                 [ 55%]
tests/test_validation.py::test_manager_valide PASSED                             [ 61%]
tests/test_validation.py::test_manager_refuse PASSED                             [ 66%]
tests/test_validation.py::test_double_validation PASSED                          [ 72%]
tests/test_validation.py::test_user_sans_equipe PASSED                           [ 77%]
tests/test_api.py::test_login_requis PASSED                                      [ 83%]
tests/test_api.py::test_password_trop_court PASSED                               [ 88%]
tests/test_api.py::test_token_expire PASSED                                      [ 94%]
tests/test_api.py::test_export_csv_entetes PASSED                                [100%]

---------- coverage: platform linux, python 3.12.2-final-0 -----------
Name                        Stmts   Miss  Cover
-----------------------------------------------
app/export.py                 118      4    97%
app/feries.py                  49      0   100%
app/heures.py                 203     12    94%
app/validation.py              87      3    97%
-----------------------------------------------
TOTAL                         449     19    96%

============================== 18 passed in 7.41s ==============================
Cleaning up project directory and file based variables
Job succeeded
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: mixed
fill_locale: mixed
domain: e-commerce
appearance: Capistrano output, variables on a command line, connection string, deploy target, username after by
scenario: Capistrano deployment of a French bookshop whose tasks run with secrets on the command line, shown in full by the verbose format
⟬text⟭
00:00 git:wrapper
      01 mkdir -p /tmp
    ✔ 01 ⟬trap:email_lookalike|deploy@web-01⟭ 0.128s
00:03 deploy:assets:precompile
      01 RAILS_ENV=production STRIPE_SECRET_KEY=⟬stripe_secret_key#1⟭ bundle exec rake assets:precompile
    ✔ 01 ⟬trap:email_lookalike|deploy@web-01⟭ 41.201s
00:44 deploy:migrate
      01 DATABASE_URL=postgres://librairie:⟬url_password#1⟭@⟬hostname#1⟭/librairie bundle exec rake db:migrate
      01 == 91 AjoutColonneIsbn: migrated (0.0118s)
    ✔ 01 ⟬trap:email_lookalike|deploy@web-01⟭ 3.118s
00:48 deploy:log_revision
      01 echo "Branch main (at ⟬git_sha#1⟭) deployed as release 452 by ⟬username#1⟭"
    ✔ 01 ⟬trap:email_lookalike|deploy@web-01⟭ 0.094s
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: mixed
fill_locale: mixed
domain: e-commerce
appearance: Ansible run, module arguments in JSON, YAML callback block, private key in a msg block, password in module arguments, connection string, cloud secret
scenario: Ansible deployment of a French furniture shop with no_log forgotten, whose verbose run prints module arguments, an environment template diff and the TLS key of the front servers
⟬text⟭
PLAY [serveurs boutique] *******************************************************

TASK [Gathering Facts] *********************************************************
ok: [⟬hostname#1⟭]
ok: [⟬hostname#2⟭]

TASK [common : paquets de base] ************************************************
ok: [⟬hostname#1⟭] => {"changed": false, "cache_updated": false}
ok: [⟬hostname#2⟭] => {"changed": false, "cache_updated": false}

TASK [common : fuseau horaire] *************************************************
ok: [⟬hostname#1⟭] => {"changed": false, "name": "Europe/Paris"}
ok: [⟬hostname#2⟭] => {"changed": false, "name": "Europe/Paris"}

TASK [app : utilisateur système] ***********************************************
ok: [⟬hostname#1⟭] => {"changed": false, "name": "⟬trap:indicator_non_pii|boutique⟭", "uid": 998}
ok: [⟬hostname#2⟭] => {"changed": false, "name": "⟬trap:indicator_non_pii|boutique⟭", "uid": 998}

TASK [app : base de données] ***************************************************
ok: [⟬hostname#1⟭] => {"changed": false, "db": "boutique", "invocation": {"module_args": {"login_host": "⟬hostname#3⟭", "login_user": "⟬trap:indicator_non_pii|boutique_admin⟭", "login_password": "⟬password#1⟭", "name": "boutique"}}}

TASK [app : fichier d'environnement] *******************************************
--- before: /etc/boutique/app.env
+++ after: /tmp/ansible.template
@@ -3,3 +3,3 @@
-DATABASE_URL=postgres://boutique:⟬url_password#1⟭@⟬hostname#3⟭:5432/boutique
+DATABASE_URL=postgres://boutique:⟬url_password#2⟭@⟬hostname#3⟭:5432/boutique
 S3_REGION=eu-west-3
 S3_K=⟬aws_secret_access_key#1⟭
changed: [⟬hostname#1⟭]
changed: [⟬hostname#2⟭]

TASK [debug : clé TLS du frontal] **********************************************
ok: [⟬hostname#1⟭] =>
  msg: |-
    ⟬private_key#1⟭

TASK [nginx : copie de la configuration] ***************************************
ok: [⟬hostname#1⟭] => {"changed": false, "dest": "/etc/nginx/sites-enabled/boutique.conf"}
ok: [⟬hostname#2⟭] => {"changed": false, "dest": "/etc/nginx/sites-enabled/boutique.conf"}

TASK [nginx : redémarrage] *****************************************************
changed: [⟬hostname#1⟭] => {"changed": true, "name": "nginx", "state": "started"}
changed: [⟬hostname#2⟭] => {"changed": true, "name": "nginx", "state": "started"}

TASK [app : migrations] ********************************************************
changed: [⟬hostname#1⟭] => {"changed": true, "cmd": "bin/migrate", "rc": 0, "stdout": "43 migrations appliquées"}

TASK [app : cron de purge] *****************************************************
ok: [⟬hostname#1⟭] => {"changed": false, "name": "purge-paniers", "user": "⟬trap:indicator_non_pii|boutique⟭"}
ok: [⟬hostname#2⟭] => {"changed": false, "name": "purge-paniers", "user": "⟬trap:indicator_non_pii|boutique⟭"}

TASK [monitoring : sonde http] *************************************************
ok: [⟬hostname#1⟭] => {"changed": false, "status": 200, "url": "⟬url#1⟭"}
ok: [⟬hostname#2⟭] => {"changed": false, "status": 200, "url": "⟬url#1⟭"}

TASK [app : notification] ******************************************************
ok: [⟬hostname#1⟭] => {"changed": false, "msg": "déploiement lancé par ⟬person_name#4⟭, contact ⟬email#4⟭"}

PLAY RECAP *********************************************************************
⟬hostname#1⟭ : ok=11 changed=3 unreachable=0 failed=0 skipped=0
⟬hostname#2⟭ : ok=9 changed=2 unreachable=0 failed=0 skipped=0

Playbook run took 0 days, 0 hours, 2 minutes, 43 seconds
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: mixed
fill_locale: mixed
domain: logistics
appearance: GitHub Actions step, docker compose config output, access keys in YAML, data migration sample, token in a push URL, actor variable
scenario: GitHub Actions deployment of a last-mile courier working with American contractors, where compose prints its resolved environment and a backfill prints one contractor
⟬text⟭
Run docker compose --env-file .env.ci config
  docker compose --env-file .env.ci config
  shell: /usr/bin/bash -e {0}
  env:
    GITHUB_ACTOR: ⟬person_name:handle#2⟭
name: dernier-km
services:
  api:
    environment:
      AWS_ACCESS_KEY_ID: ⟬aws_access_key_id#1⟭
      AWS_DEFAULT_REGION: eu-west-3
      DEPOT_MANAGER: "⟬person_name#3⟭"
      MAIL_USER: ⟬trap:indicator_non_pii|mailer⟭
    image: ⟬hostname#1⟭:5000/dernier-km/api:main
Run alembic upgrade head
INFO  [alembic.runtime.migration] Context impl PostgresqlImpl.
INFO  [alembic.runtime.migration] Running upgrade 41a -> 41b, ajout table contractors
INFO  [backfill] contractors à migrer : 18
INFO  [backfill] sample: 8841 / ⟬person_name#4⟭ / ⟬us_itin#4⟭ / ⟬phone#4⟭
INFO  [backfill] done, 18 rows
Run git push https://⟬github_token#1⟭@github.com/dernier-km/infra.git HEAD:deploy-state
remote: Resolving deltas: 100% (2/2), completed with 2 local objects.
To github.com:dernier-km/infra.git
   ⟬git_sha#1⟭..⟬git_sha#2⟭  HEAD -> deploy-state
⟬end⟭
