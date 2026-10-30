⟬template⟭
family: logs
format: application log
language: mixed
fill_locale: mixed
domain: banking
appearance: Keycloak event line, comma separated fields, token in a query string, code in a callback, phone without announcer
scenario: identity provider of a French online bank, whose event log mixes customers, a technical aggregator account, an SMS step and an administrator resetting a password
⟬text⟭
⟬date#1⟭ 09:01:12,418 INFO  [org.keycloak.events] (executor-thread-12) type=LOGIN, realmId=banque-en-ligne, clientId=espace-particuliers, userId=⟬uuid#1⟭, ipAddress=⟬ip_address#1⟭, username="⟬person_name:handle#1⟭"
⟬date#1⟭ 09:01:12,420 DEBUG [fr.banque.kc.sca.ScaAuthenticator] (executor-thread-12) défi SCA envoyé au ⟬phone#1⟭ pour ⟬person_name#1⟭
⟬date#1⟭ 09:01:44,102 INFO  [fr.banque.kc.sca.ScaAuthenticator] (executor-thread-12) défi SCA validé, tentative 1 sur 3
⟬date#1⟭ 09:01:44,180 DEBUG [org.keycloak.services] (executor-thread-12) callback code=⟬opaque_token#1⟭ state=⟬uuid#2⟭
⟬date#1⟭ 09:01:44,311 INFO  [org.keycloak.events] (executor-thread-9) type=CODE_TO_TOKEN, realmId=banque-en-ligne, clientId=espace-particuliers, userId=⟬uuid#1⟭, token_id=⟬uuid#3⟭, grant_type=authorization_code
⟬date#1⟭ 09:03:07,559 WARN  [org.keycloak.events] (executor-thread-3) type=LOGIN_ERROR, realmId=banque-en-ligne, clientId=espace-particuliers, userId=null, ipAddress=⟬ip_address#2⟭, error=user_not_found, username="⟬email#2⟭"
⟬date#1⟭ 09:03:11,020 WARN  [org.keycloak.events] (executor-thread-3) type=LOGIN_ERROR, realmId=banque-en-ligne, clientId=espace-particuliers, userId=⟬uuid#4⟭, ipAddress=⟬ip_address#2⟭, error=invalid_user_credentials, username="⟬email#4⟭"
⟬date#1⟭ 09:03:11,024 INFO  [fr.banque.kc.fraud.VelocityListener] (executor-thread-3) 2 échecs depuis ⟬ip_address#2⟭, compteur porté à 2
⟬date#1⟭ 09:10:00,233 INFO  [org.keycloak.events] (executor-thread-7) type=CLIENT_LOGIN, realmId=banque-en-ligne, clientId=agregateur-dsp2, userId=⟬uuid#5⟭, ipAddress=⟬ip_address#3⟭, username=⟬trap:indicator_non_pii|service-account-agregateur⟭
⟬date#1⟭ 09:22:18,640 INFO  [org.keycloak.events.admin] (executor-thread-2) operationType=ACTION, realmId=banque-en-ligne, resourcePath=users/⟬uuid#4⟭/reset-password, user="⟬person_name#4⟭", operator="⟬person_name#5⟭"
⟬date#1⟭ 09:22:18,645 DEBUG [fr.banque.kc.admin.ResetListener] (executor-thread-2) mot de passe provisoire ⟬password#1⟭ transmis par courrier à ⟬person_name#4⟭
⟬date#1⟭ 09:24:51,101 INFO  [org.keycloak.events] (executor-thread-5) type=LOGOUT, realmId=banque-en-ligne, clientId=espace-particuliers, userId=⟬uuid#1⟭, ipAddress=⟬ip_address#1⟭
⟬date#1⟭ 09:24:51,102 DEBUG [org.keycloak.services] (executor-thread-5) GET /realms/banque-en-ligne/protocol/openid-connect/logout?id_token_hint=⟬jwt#1⟭ 302
⟬date#1⟭ 09:30:00,002 INFO  [org.infinispan.CLUSTER] (jgroups-4,kc-1) [Context=sessions] ISPN100010: Finished rebalance with members [kc-1, kc-2], topology id 63
⟬date#1⟭ 09:30:02,118 WARN  [org.keycloak.events] (executor-thread-1) type=REFRESH_TOKEN_ERROR, realmId=banque-en-ligne, clientId=appli-mobile, userId=⟬uuid#6⟭, error=invalid_token, refresh_token=⟬jwt#2⟭
⟬date#1⟭ 09:30:02,120 INFO  [fr.banque.kc.mobile.DeviceBinding] (executor-thread-1) appareil délié, user="⟬person_name#6⟭" operator=⟬trap:indicator_non_pii|kc-device-job⟭
⟬end⟭

⟬template⟭
family: logs
format: application log
language: mixed
fill_locale: mixed
domain: banking
appearance: log line, XML payload, CDATA company, tax identifier in an XML element, key identifier
scenario: outgoing transfer of a French corporate bank to an American beneficiary, whose debug level dumps the pain.001 fragment before signing
⟬text⟭
⟬date#1⟭ 15:06:44,201 DEBUG [sepa-out] c.b.virements.XmlDump - pain.001 avant signature :
<CdtTrfTxInf>
  <PmtId><EndToEndId>⟬order_number#1⟭</EndToEndId></PmtId>
  <Amt><InstdAmt Ccy="USD">4200.00</InstdAmt></Amt>
  <CdtrAgt><FinInstnId><BICFI>⟬bic#1⟭</BICFI></FinInstnId></CdtrAgt>
  <Cdtr><Nm>⟬person_name#1⟭</Nm><Id><PrvtId><Othr><Id>⟬us_itin#1⟭</Id><SchmeNm><Cd>TXID</Cd></SchmeNm></Othr></PrvtId></Id></Cdtr>
  <CdtrAcct><Id><IBAN>⟬iban#1⟭</IBAN></Id></CdtrAcct>
  <Dbtr><Nm><![CDATA[⟬company#2⟭]]></Nm></Dbtr>
  <DbtrAcct><Id><IBAN>⟬iban#2⟭</IBAN></Id></DbtrAcct>
  <RmtInf><Ustrd>solde facture ⟬invoice_number#1⟭</Ustrd></RmtInf>
</CdtTrfTxInf>
⟬date#1⟭ 15:06:44,207 INFO  [sepa-out] c.b.virements.Signer - signature OK, key id ⟬hash#1⟭
⟬date#1⟭ 15:06:44,330 INFO  [sepa-out] c.b.virements.EbicsClient - order accepted, ref=⟬order_number#1⟭
⟬end⟭

⟬template⟭
family: logs
format: application log
language: mixed
fill_locale: mixed
domain: SaaS
appearance: logrus text line, key=value, secret under an innocuous key, password alone in a field, tax form, dunning run, customer on both sides
scenario: one morning of the subscription billing service of a French scheduling product, between logins, SEPA mandates, webhooks, a W-9 from an American client and the daily dunning run
⟬text⟭
time="⟬date#1⟭ 08:00:01" level=info msg="starting billing-api" version=⟬version#1⟭ host=⟬hostname#1⟭
time="⟬date#1⟭ 08:00:01" level=info msg="postgres pool ready" host=⟬hostname#2⟭ max=20
time="⟬date#1⟭ 08:00:01" level=debug msg="stripe client init" key=⟬stripe_secret_key#1⟭
time="⟬date#1⟭ 08:00:02" level=info msg="cron dunning armed" schedule="0 9 * * *" owner=⟬trap:indicator_non_pii|team-revenue⟭
time="⟬date#1⟭ 08:04:18" level=info msg="POST /v1/login 200" user=⟬person_name#1⟭ email=⟬email#1⟭ ip=⟬ip_address#1⟭
time="⟬date#1⟭ 08:04:18" level=debug msg="jwt issued" user="⟬person_name#1⟭" token=⟬jwt#1⟭
time="⟬date#1⟭ 08:04:31" level=info msg="GET /v1/subscriptions 200" tenant=⟬customer_id#1⟭ duration_ms=14
time="⟬date#1⟭ 08:05:02" level=info msg="POST /v1/mandates 201" tenant=⟬customer_id#1⟭ duration_ms=212
time="⟬date#1⟭ 08:05:02" level=debug msg="mandat SEPA créé" holder="⟬person_name#1⟭" iban="⟬iban#1⟭" bic=⟬bic#1⟭ ref=⟬order_number#1⟭
time="⟬date#1⟭ 08:11:47" level=info msg="webhook received" type=invoice.paid ref=⟬invoice_number#1⟭ sig=⟬opaque_token#1⟭
time="⟬date#1⟭ 08:11:47" level=info msg="facture réglée" ref=⟬invoice_number#1⟭ amount=49.00 customer=⟬person_name#3⟭
time="⟬date#1⟭ 08:14:03" level=info msg="webhook received" type=invoice.payment_failed ref=⟬invoice_number#2⟭ sig=⟬opaque_token#2⟭
time="⟬date#1⟭ 08:14:03" level=warning msg="paiement refusé" ref=⟬invoice_number#2⟭ customer=⟬person_name#4⟭ reason=insufficient_funds
time="⟬date#1⟭ 08:14:04" level=info msg="relance J+1 planifiée" ref=⟬invoice_number#2⟭
time="⟬date#1⟭ 08:19:26" level=info msg="webhook received" type=customer.updated ref=⟬customer_id#5⟭ sig=⟬opaque_token#3⟭
time="⟬date#1⟭ 08:19:26" level=info msg="tenant de démonstration ignoré" customer="⟬trap:indicator_non_pii|internal-demo⟭"
time="⟬date#1⟭ 08:22:40" level=info msg="POST /v1/login 200" user=⟬trap:indicator_non_pii|support-tooling⟭ ip=⟬ip_address#2⟭
time="⟬date#1⟭ 08:23:05" level=info msg="GET /v1/invoices 200" tenant=⟬customer_id#2⟭ duration_ms=31
time="⟬date#1⟭ 08:31:12" level=info msg="POST /v1/tax-forms 201" tenant=⟬customer_id#2⟭ duration_ms=98
time="⟬date#1⟭ 08:31:12" level=debug msg="W-9 reçu" customer="⟬person_name#5⟭" tin="⟬us_itin#5⟭" company="⟬company#5⟭" city=⟬city#5⟭
time="⟬date#1⟭ 08:31:13" level=info msg="tax profile updated" tenant=⟬customer_id#2⟭ country=⟬country#5⟭
time="⟬date#1⟭ 08:31:40" level=warning msg="mot de passe temporaire régénéré" user=⟬person_name#5⟭
time="⟬date#1⟭ 08:31:40" level=debug msg="invitation link" value=⟬password#1⟭
time="⟬date#1⟭ 08:35:00" level=info msg="GET /healthz 200" ip=⟬ip_address#3⟭
time="⟬date#1⟭ 08:40:00" level=info msg="GET /healthz 200" ip=⟬ip_address#3⟭
time="⟬date#1⟭ 08:42:17" level=info msg="PATCH /admin/plans/pro 200" operator=⟬person_name#6⟭
time="⟬date#1⟭ 08:42:17" level=info msg="plan price change queued" value=59.00 operator="⟬trap:indicator_non_pii|plans-bot⟭"
time="⟬date#1⟭ 08:45:00" level=info msg="GET /healthz 200" ip=⟬ip_address#3⟭
time="⟬date#1⟭ 08:47:33" level=error msg="sendgrid call failed" status=401 key=⟬sendgrid_api_key#1⟭
time="⟬date#1⟭ 08:47:34" level=warning msg="mail provider fallback" provider=smtp host=⟬hostname#3⟭
time="⟬date#1⟭ 08:50:00" level=info msg="GET /healthz 200" ip=⟬ip_address#3⟭
time="⟬date#1⟭ 08:55:00" level=info msg="GET /healthz 200" ip=⟬ip_address#3⟭
time="⟬date#1⟭ 09:00:00" level=info msg="dunning run started" batch=⟬uuid#1⟭
time="⟬date#1⟭ 09:00:00" level=info msg="4 impayés à traiter" batch=⟬uuid#1⟭
time="⟬date#1⟭ 09:00:01" level=debug msg="impayé 1/4" ref=⟬invoice_number#2⟭ customer="⟬person_name#4⟭" step=1
time="⟬date#1⟭ 09:00:01" level=info msg="email de relance envoyé" to=⟬email#4⟭ template=relance_1
time="⟬date#1⟭ 09:00:02" level=debug msg="impayé 2/4" ref=⟬invoice_number#3⟭ customer=⟬person_name#7⟭ step=2
time="⟬date#1⟭ 09:00:02" level=info msg="email de relance envoyé" to=⟬email#7⟭ template=relance_2
time="⟬date#1⟭ 09:00:03" level=debug msg="impayé 3/4" ref=⟬invoice_number#4⟭ customer=⟬person_name#8⟭ step=3
time="⟬date#1⟭ 09:00:03" level=warning msg="suspension programmée" ref=⟬invoice_number#4⟭ tenant=⟬customer_id#3⟭
time="⟬date#1⟭ 09:00:03" level=info msg="appel commercial demandé" phone="⟬phone#8⟭" owner="⟬person_name#6⟭"
time="⟬date#1⟭ 09:00:04" level=debug msg="impayé 4/4" ref=⟬invoice_number#5⟭ customer=⟬trap:indicator_non_pii|internal-demo⟭ step=1
time="⟬date#1⟭ 09:00:04" level=info msg="impayé de démonstration ignoré" ref=⟬invoice_number#5⟭
time="⟬date#1⟭ 09:00:04" level=info msg="dunning run finished" batch=⟬uuid#1⟭ sent=2 suspended=1 skipped=1
time="⟬date#1⟭ 09:05:00" level=info msg="GET /healthz 200" ip=⟬ip_address#3⟭
time="⟬date#1⟭ 09:07:51" level=info msg="POST /v1/login 200" user=⟬person_name#9⟭ email=⟬email#9⟭ ip=⟬ip_address#4⟭
time="⟬date#1⟭ 09:07:51" level=debug msg="jwt issued" user=⟬person_name#9⟭ token=⟬jwt#2⟭
time="⟬date#1⟭ 09:08:15" level=info msg="POST /v1/cards 201" tenant=⟬customer_id#4⟭ duration_ms=640
time="⟬date#1⟭ 09:08:15" level=info msg="moyen de paiement ajouté" tenant=⟬customer_id#4⟭ brand=visa
time="⟬date#1⟭ 09:10:00" level=info msg="GET /healthz 200" ip=⟬ip_address#3⟭
time="⟬date#1⟭ 09:12:29" level=error msg="export comptable en échec" tenant=⟬customer_id#2⟭ url=⟬url#1⟭
time="⟬date#1⟭ 09:12:29" level=debug msg="retry scheduled" attempt=2 ctx="queue=exports shard=1"
time="⟬date#1⟭ 09:12:59" level=info msg="export comptable terminé" tenant=⟬customer_id#2⟭ rows=964
time="⟬date#1⟭ 09:15:00" level=info msg="GET /healthz 200" ip=⟬ip_address#3⟭
time="⟬date#1⟭ 09:18:44" level=info msg="DELETE /v1/mandates 204" tenant=⟬customer_id#1⟭ user="⟬person_name#1⟭"
time="⟬date#1⟭ 09:18:44" level=debug msg="mandat révoqué" iban="⟬iban#1⟭" ref=⟬order_number#1⟭
time="⟬date#1⟭ 09:20:00" level=info msg="GET /healthz 200" ip=⟬ip_address#3⟭
time="⟬date#1⟭ 09:25:00" level=info msg="GET /healthz 200" ip=⟬ip_address#3⟭
time="⟬date#1⟭ 09:27:02" level=warning msg="rate limit proche" tenant=⟬customer_id#4⟭ remaining=12
time="⟬date#1⟭ 09:30:00" level=info msg="GET /healthz 200" ip=⟬ip_address#3⟭
time="⟬date#1⟭ 09:30:01" level=info msg="metrics flushed" url=⟬url#2⟭ user="⟬trap:indicator_non_pii|metrics⟭"
time="⟬date#1⟭ 09:30:01" level=info msg="log rotation" path=⟬file_path#1⟭
time="⟬date#1⟭ 09:30:02" level=info msg="retention job done" removed=83 owner=⟬trap:indicator_non_pii|team-platform⟭
⟬end⟭

⟬template⟭
family: logs
format: application log
language: mixed
fill_locale: mixed
domain: SaaS
appearance: plain log line, stand-in key, field holding several values, ETag
scenario: five-minute feature flag sync of a French SaaS, with flags owned by teams and a bot account
⟬text⟭
⟬date#1⟭ 12:00:00 flags-sync INFO pulled 214 flags from ⟬url#1⟭
⟬date#1⟭ 12:00:00 flags-sync INFO modifié : checkout_v2 owner="⟬trap:indicator_non_pii|team-growth⟭"
⟬date#1⟭ 12:00:00 flags-sync INFO modifié : nouveau_pdf owner=⟬trap:indicator_non_pii|team-docs⟭
⟬date#1⟭ 12:00:01 flags-sync DEBUG meta="etag=⟬hash#1⟭ cache_age=12s"
⟬date#1⟭ 12:00:01 flags-sync DEBUG api_key=⟬trap:placeholder|REDACTED⟭ user="⟬trap:indicator_non_pii|flags-bot⟭"
⟬date#1⟭ 12:00:01 flags-sync INFO next pull in 300s
⟬end⟭

⟬template⟭
family: logs
format: application log
language: mixed
fill_locale: mixed
domain: e-commerce
appearance: Python log line, product names, supplier in a quoted field, stand-in values, file checksum
scenario: nightly supplier feed of a French online wine shop, where appellations and estates read like people and the only contact field is masked
⟬text⟭
⟬date#1⟭ 04:00:03 [stock-sync] INFO: flux fournisseurs ouvert, 3 fichiers en attente
⟬date#1⟭ 04:00:03 [stock-sync] DEBUG: sftp login user=⟬trap:indicator_non_pii|sftp-fournisseurs⟭ password=⟬trap:placeholder|${SFTP_PASSWORD}⟭
⟬date#1⟭ 04:00:04 [stock-sync] INFO: fichier ⟬file_path#1⟭ reçu, checksum ⟬hash#1⟭
⟬date#1⟭ 04:00:05 [stock-sync] INFO: fournisseur="⟬trap:company_name|Maison ⦃Family⦄⟭" lignes=118 attrs="lot=L418 entrepot=ROISSY"
⟬date#1⟭ 04:00:05 [stock-sync] DEBUG: sku=VIN-0412 libelle="⟬trap:word_name|Margaux⟭ grand vin" qty=12 prix=48.50
⟬date#1⟭ 04:00:05 [stock-sync] DEBUG: sku=VIN-0413 libelle="cuvée ⟬trap:word_name|Marguerite⟭ brut" qty=60 prix=21.90
⟬date#1⟭ 04:00:05 [stock-sync] DEBUG: sku=VIN-0419 libelle="⟬trap:word_name|Saint-Émilion⟭ réserve" qty=24 prix=33.00
⟬date#1⟭ 04:00:06 [stock-sync] WARNING: sku=VIN-0431 prix manquant, ligne ignorée
⟬date#1⟭ 04:00:06 [stock-sync] INFO: 117 lignes intégrées, 1 ignorée
⟬date#1⟭ 04:00:06 [stock-sync] INFO: fichier ⟬file_path#2⟭ reçu, checksum ⟬hash#2⟭
⟬date#1⟭ 04:00:07 [stock-sync] INFO: fournisseur="⟬trap:company_name|Domaine ⦃Family2⦄⟭" lignes=46 attrs="lot=L419 entrepot=ROISSY"
⟬date#1⟭ 04:00:07 [stock-sync] DEBUG: contact=⟬trap:indicator_non_pii|<masked>⟭ tel=⟬trap:indicator_non_pii|<masked>⟭ ville=⟬city#1⟭ cp=⟬postcode#1⟭
⟬date#1⟭ 04:00:08 [stock-sync] INFO: 46 lignes intégrées, 0 ignorée
⟬date#1⟭ 04:00:08 [stock-sync] INFO: fichier ⟬file_path#3⟭ reçu, checksum ⟬hash#3⟭
⟬date#1⟭ 04:00:08 [stock-sync] ERROR: encodage invalide ligne 212, fichier mis en quarantaine
⟬date#1⟭ 04:00:08 [stock-sync] INFO: ticket ⟬ticket_id#1⟭ ouvert, owner=⟬trap:indicator_non_pii|achats-vins⟭
⟬date#1⟭ 04:00:09 [stock-sync] INFO: tarifs recalculés pour customer="⟬trap:indicator_non_pii|B2B-CAVISTES⟭" ref=⟬order_number#1⟭
⟬date#1⟭ 04:00:10 [stock-sync] INFO: index de recherche republié, 3 686 références
⟬date#1⟭ 04:00:10 [stock-sync] INFO: flux fournisseurs fermé, durée 7s
⟬end⟭

⟬template⟭
family: logs
format: application log
language: mixed
fill_locale: mixed
domain: e-commerce
appearance: Serilog line, age check, quoted document number, IBAN in a refund, name in a sentence
scenario: age verification and refund flow of a French online cutlery shop selling to the United Kingdom, where the .NET service logs the licence read by its vendor
⟬text⟭
[⟬date#1⟭ 16:02:11.402 INF] AgeCheck started for order ⟬order_number#1⟭, market=UK sku=COUT-CHEF-21
[⟬date#1⟭ 16:02:11.403 DBG] AgeCheck.Request attrs="buyer=⟬person_name#1⟭ dob=⟬birth_date#1⟭ licence=⟬uk_driving_licence#1⟭ issued=⟬date#2⟭"
[⟬date#1⟭ 16:02:11.890 INF] Vendor responded in 487 ms, request_id=⟬uuid#1⟭
[⟬date#1⟭ 16:02:11.891 INF] AgeCheck passed for order ⟬order_number#1⟭
[⟬date#1⟭ 16:02:11.893 INF] Commande ⟬order_number#1⟭ validée, expédition depuis l'entrepôt de ⟬city#2⟭
[⟬date#1⟭ 16:09:34.018 INF] AgeCheck started for order ⟬order_number#2⟭, market=UK sku=HACHE-CAMP-08
[⟬date#1⟭ 16:09:34.019 DBG] AgeCheck.Request attrs="buyer=⟬person_name#3⟭ dob=⟬birth_date#3⟭ licence=⟬uk_driving_licence#3⟭ issued=⟬date#3⟭"
[⟬date#1⟭ 16:09:34.602 WRN] Vendor returned NAME_MISMATCH, licence "⟬uk_driving_licence#3⟭" does not match "⟬person_name#3⟭"
[⟬date#1⟭ 16:09:34.604 WRN] Commande ⟬order_number#2⟭ bloquée, passage en revue manuelle
[⟬date#1⟭ 16:40:02.511 INF] Review opened by agent "⟬person_name#4⟭" on order ⟬order_number#2⟭
[⟬date#1⟭ 16:44:19.200 INF] Review closed, decision=REFUSED agent="⟬person_name#4⟭"
[⟬date#1⟭ 16:44:19.340 INF] Remboursement de 64,00 € lancé pour ⟬person_name#3⟭
[⟬date#1⟭ 16:44:19.341 DBG] Refund.Request ctx="iban=⟬iban#3⟭ holder=⟬person_name#3⟭ ref=⟬invoice_number#1⟭"
[⟬date#1⟭ 16:44:20.118 INF] Refund accepted, value=⟬order_number#2⟭
[⟬date#1⟭ 16:44:20.120 INF] Mail d'annulation envoyé à ⟬email#3⟭
[⟬date#1⟭ 17:00:00.002 INF] Age check statistics: passed=59, failed=3, owner=⟬trap:indicator_non_pii|compliance-uk⟭
⟬end⟭

⟬template⟭
family: logs
format: application log
language: mixed
fill_locale: mixed
domain: logistics
appearance: Apache Camel log, SFTP endpoint with a password, importer of record, quoted tax identifier, SIRET
scenario: customs gateway of a Paris freight forwarder, whose Camel route logs its SFTP endpoint and the parties of a declaration for an American importer
⟬text⟭
⟬date#1⟭ 07:15:02.114  INFO 9565 --- [main] o.a.c.impl.engine.AbstractCamelContext : Apache Camel ⟬version#1⟭ (customs) is starting
⟬date#1⟭ 07:15:03.002  INFO 9565 --- [main] o.a.c.i.e.InternalRouteStartupManager  : Started declarations-in (sftp://edi_douane:⟬url_password#1⟭@⟬hostname#1⟭:22/inbound)
⟬date#1⟭ 07:15:03.004  INFO 9565 --- [main] o.a.c.i.e.InternalRouteStartupManager  : Started declarations-out (https://⟬hostname#2⟭/douane/v3/delta)
⟬date#1⟭ 07:15:03.010  INFO 9565 --- [main] o.a.c.impl.engine.AbstractCamelContext : Routes startup (total:2 started:2) in 318ms
⟬date#1⟭ 07:42:19.511  INFO 9565 --- [sftp-consumer-1] declarations-in : fichier reçu ⟬file_path#1⟭, 2 déclarations
⟬date#1⟭ 07:42:19.640 DEBUG 9565 --- [sftp-consumer-1] declarations-in : declaration=⟬order_number#1⟭ type=IM regime=4000 bureau=FR620001
⟬date#1⟭ 07:42:19.641 DEBUG 9565 --- [sftp-consumer-1] declarations-in : declarant="⟬company#2⟭" siret="⟬fr_siret#2⟭" ville=⟬city#2⟭
⟬date#1⟭ 07:42:19.642 DEBUG 9565 --- [sftp-consumer-1] declarations-in : importer_of_record="⟬person_name#3⟭" tax_id="⟬us_itin#3⟭" adr="⟬postal_address#3⟭"
⟬date#1⟭ 07:42:19.643 DEBUG 9565 --- [sftp-consumer-1] declarations-in : marchandise="pièces détachées" poids=1840 kg valeur=22800 USD
⟬date#1⟭ 07:42:20.118  WARN 9565 --- [sftp-consumer-1] declarations-in : code Incoterm absent, valeur DAP appliquée
⟬date#1⟭ 07:42:20.900  INFO 9565 --- [delta-producer-2] declarations-out : déclaration ⟬order_number#1⟭ transmise, status=202 request_id=⟬uuid#1⟭
⟬date#1⟭ 07:42:21.211 DEBUG 9565 --- [sftp-consumer-1] declarations-in : declaration=⟬order_number#2⟭ type=EX regime=1000 bureau=FR620001
⟬date#1⟭ 07:42:21.212 DEBUG 9565 --- [sftp-consumer-1] declarations-in : declarant="⟬company#2⟭" siret="⟬fr_siret#2⟭" customer=⟬trap:indicator_non_pii|compte-export-general⟭
⟬date#1⟭ 07:42:21.640 ERROR 9565 --- [delta-producer-2] declarations-out : rejet douane sur ⟬order_number#2⟭, code E412, contact "⟬person_name#4⟭" au ⟬phone#4⟭
⟬date#1⟭ 07:42:21.642  INFO 9565 --- [delta-producer-2] declarations-out : ticket ⟬ticket_id#1⟭ créé pour le service transit
⟬date#1⟭ 07:42:22.004  INFO 9565 --- [sftp-consumer-1] declarations-in : fichier archivé, 1 acceptée, 1 rejetée
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: mixed
fill_locale: mixed
domain: banking
appearance: Spring Batch log, nested caused-by chain, Oracle error, stand-in in a field, code identifier in a frame, eponym
scenario: monthly effective rate batch of a French lender stopped by an Oracle deadlock, with a long chain of causes and no borrower value
⟬text⟭
⟬date#1⟭ 23:40:11,204 INFO  [batch-teg] o.s.b.c.l.support.SimpleJobLauncher - Job: [FlowJob: [name=calculTegMensuel]] launched with the following parameters: [{run.id=793, lot=mensuel}]
⟬date#1⟭ 23:40:11,377 INFO  [batch-teg] o.s.batch.core.job.SimpleStepHandler - Executing step: [chargementEncours]
⟬date#1⟭ 23:41:52,019 INFO  [batch-teg] o.s.batch.core.step.AbstractStep - Step: [chargementEncours] executed in 1m40s692ms
⟬date#1⟭ 23:41:52,120 INFO  [batch-teg] o.s.batch.core.job.SimpleStepHandler - Executing step: [calculTeg]
⟬date#1⟭ 23:44:03,551 WARN  [batch-teg] f.b.credit.teg.TegSolver - dossier ⟬customer_id#1⟭ : méthode ⟬trap:eponym|Newton-Raphson⟭ non convergente ctx="iter=50 residu=0.0007 borrower=⟬trap:indicator_non_pii|<masked>⟭"
⟬date#1⟭ 23:44:03,560 ERROR [batch-teg] o.s.batch.core.step.AbstractStep - Encountered an error executing step calculTeg in job calculTegMensuel
org.springframework.dao.CannotAcquireLockException: PreparedStatementCallback; SQL [UPDATE echeancier SET teg = ? WHERE dossier = ?]; ORA-00060: deadlock detected while waiting for resource
	at org.springframework.jdbc.support.SQLExceptionSubclassTranslator.doTranslate(SQLExceptionSubclassTranslator.java:78)
	at org.springframework.jdbc.support.SQLErrorCodeSQLExceptionTranslator.doTranslate(SQLErrorCodeSQLExceptionTranslator.java:238)
	at org.springframework.jdbc.support.AbstractFallbackSQLExceptionTranslator.translate(AbstractFallbackSQLExceptionTranslator.java:72)
	at org.springframework.jdbc.core.JdbcTemplate.translateException(JdbcTemplate.java:1570)
	at org.springframework.jdbc.core.JdbcTemplate.execute(JdbcTemplate.java:645)
	at org.springframework.jdbc.core.JdbcTemplate.update(JdbcTemplate.java:960)
	at org.springframework.jdbc.core.JdbcTemplate.batchUpdate(JdbcTemplate.java:1011)
	at f.b.credit.teg.EcheancierWriter.write(EcheancierWriter.java:74)
	at org.springframework.batch.core.step.item.SimpleChunkProcessor.writeItems(SimpleChunkProcessor.java:203)
	at org.springframework.batch.core.step.item.SimpleChunkProcessor.doWrite(SimpleChunkProcessor.java:170)
	at org.springframework.batch.core.step.item.SimpleChunkProcessor.write(SimpleChunkProcessor.java:297)
	at org.springframework.batch.core.step.item.SimpleChunkProcessor.process(SimpleChunkProcessor.java:228)
	at org.springframework.batch.core.step.item.ChunkOrientedTasklet.execute(ChunkOrientedTasklet.java:82)
	at org.springframework.batch.core.step.tasklet.TaskletStep$ChunkTransactionCallback.doInTransaction(TaskletStep.java:388)
	at org.springframework.transaction.support.TransactionTemplate.execute(TransactionTemplate.java:140)
	at org.springframework.batch.core.step.tasklet.TaskletStep$2.doInChunkContext(TaskletStep.java:274)
	at org.springframework.batch.repeat.support.RepeatTemplate.iterate(RepeatTemplate.java:145)
	at org.springframework.batch.core.step.tasklet.TaskletStep.doExecute(TaskletStep.java:257)
	at org.springframework.batch.core.step.AbstractStep.execute(AbstractStep.java:229)
	at org.springframework.batch.core.job.SimpleStepHandler.handleStep(SimpleStepHandler.java:153)
	at org.springframework.batch.core.job.flow.JobFlowExecutor.executeStep(JobFlowExecutor.java:68)
	at org.springframework.batch.core.job.flow.support.state.StepState.handle(StepState.java:68)
	at org.springframework.batch.core.job.flow.support.SimpleFlow.resume(SimpleFlow.java:169)
	at org.springframework.batch.core.job.flow.support.SimpleFlow.start(SimpleFlow.java:141)
	at org.springframework.batch.core.job.flow.FlowJob.doExecute(FlowJob.java:86)
	at org.springframework.batch.core.job.AbstractJob.execute(AbstractJob.java:307)
	at org.springframework.batch.core.launch.support.SimpleJobLauncher$1.run(SimpleJobLauncher.java:149)
	at java.base/java.lang.Thread.run(Thread.java:840)
Caused by: java.sql.SQLTransactionRollbackException: ORA-00060: deadlock detected while waiting for resource
	at oracle.jdbc.driver.T4CTTIoer11.processError(T4CTTIoer11.java:630)
	at oracle.jdbc.driver.T4CTTIoer11.processError(T4CTTIoer11.java:564)
	at oracle.jdbc.driver.T4C8Oall.processError(T4C8Oall.java:1231)
	at oracle.jdbc.driver.T4CTTIfun.receive(T4CTTIfun.java:772)
	at oracle.jdbc.driver.T4CTTIfun.doRPC(T4CTTIfun.java:299)
	at oracle.jdbc.driver.T4C8Oall.doOALL(T4C8Oall.java:512)
	at oracle.jdbc.driver.T4CPreparedStatement.doOall8(T4CPreparedStatement.java:273)
	at oracle.jdbc.driver.T4CPreparedStatement.executeForRows(T4CPreparedStatement.java:1204)
	at oracle.jdbc.driver.OracleStatement.executeSQLStatement(OracleStatement.java:1825)
	at oracle.jdbc.driver.OraclePreparedStatement.executeBatchWithoutQueue(OraclePreparedStatement.java:12718)
	at com.zaxxer.hikari.pool.ProxyStatement.executeBatch(ProxyStatement.java:127)
	at org.springframework.jdbc.core.JdbcTemplate.lambda$batchUpdate$4(JdbcTemplate.java:1025)
	at org.springframework.jdbc.core.JdbcTemplate.execute(JdbcTemplate.java:629)
	... 21 common frames omitted
Caused by: Error : 60, Position : 0, Sql = UPDATE echeancier SET teg = :1 WHERE dossier = :2, Error Msg = ORA-00060: deadlock detected while waiting for resource
	at oracle.jdbc.driver.T4CTTIoer11.processError(T4CTTIoer11.java:637)
	... 33 common frames omitted
⟬date#1⟭ 23:44:03,588 INFO  [batch-teg] o.s.batch.core.step.AbstractStep - Step: [calculTeg] executed in 2m11s468ms
⟬date#1⟭ 23:44:03,601 INFO  [batch-teg] f.b.credit.teg.AlerteListener - batch arrêté, ⟬trap:code_identifier|⦃Family⦄InterestPolicy⟭ non appliquée, owner=⟬trap:indicator_non_pii|moe-credit⟭
⟬date#1⟭ 23:44:03,612 INFO  [batch-teg] o.s.b.c.l.support.SimpleJobLauncher - Job: [FlowJob: [name=calculTegMensuel]] completed with the following parameters: [{run.id=793, lot=mensuel}] and the following status: [FAILED] in 3m52s397ms
⟬date#1⟭ 23:44:03,620 WARN  [batch-teg] f.b.credit.teg.DbaNotifier - session Oracle bloquante user="⟬trap:indicator_non_pii|BATCH_TEG⟭" sid=786 serial=8841
⟬date#1⟭ 23:44:03,622 INFO  [batch-teg] f.b.credit.teg.DbaNotifier - dbg="waiter=818 holder=786 table=ECHEANCIER"
⟬date#1⟭ 23:44:03,640 INFO  [batch-teg] f.b.credit.teg.Reprise - reprise possible depuis le dossier ⟬customer_id#1⟭, ticket ⟬ticket_id#1⟭
⟬date#1⟭ 23:44:03,641 INFO  [batch-teg] f.b.credit.teg.Reprise - run.id suivant 794, commit-interval=500
⟬date#1⟭ 23:44:03,700 INFO  [batch-teg] c.z.hikari.HikariDataSource - HikariPool-2 - Shutdown initiated...
⟬date#1⟭ 23:44:03,742 INFO  [batch-teg] c.z.hikari.HikariDataSource - HikariPool-2 - Shutdown completed.
⟬date#1⟭ 23:44:03,743 INFO  [batch-teg] f.b.credit.teg.Reprise - rapport écrit dans ⟬file_path#1⟭
⟬date#1⟭ 23:44:03,745 INFO  [batch-teg] f.b.credit.teg.Reprise - notification envoyée contact=⟬trap:indicator_non_pii|astreinte-credit⟭
⟬date#1⟭ 23:44:03,746 INFO  [batch-teg] o.s.b.c.l.support.SimpleJobLauncher - exit code 3
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: mixed
fill_locale: mixed
domain: SaaS
appearance: ASP.NET Core exception, inner exception, private key alone on lines, connection string, beneficiary fields
scenario: third-party payment product for French health insurers, whose ASP.NET service fails on a bad signing key, prints the key and then its configuration and the request in progress
⟬text⟭
fail: Microsoft.AspNetCore.Diagnostics.ExceptionHandlerMiddleware[1]
      An unhandled exception has occurred while executing the request.
      System.Security.Cryptography.CryptographicException: ASN1 corrupted data.
       ---> System.Formats.Asn1.AsnContentException: The encoded length exceeds the maximum supported by this library.
         at System.Formats.Asn1.AsnDecoder.ReadEncodedValue(ReadOnlySpan`1 source, AsnEncodingRules ruleSet, Int32& contentOffset, Int32& contentLength, Int32& bytesConsumed)
         --- End of inner exception stack trace ---
         at System.Security.Cryptography.AsymmetricAlgorithm.ImportFromPem(ReadOnlySpan`1 input)
         at TiersPayant.Flux.Signature.FlowSigner..ctor(String pem) in /src/TiersPayant.Flux/Signature/FlowSigner.cs:line 27
         at TiersPayant.Flux.Api.FluxController.Envoyer(FluxRequest request) in /src/TiersPayant.Flux/Api/FluxController.cs:line 52
         at lambda_method41(Closure, Object, Object[])
         at Microsoft.AspNetCore.Mvc.Infrastructure.ActionMethodExecutor.AwaitableObjectResultExecutor.Execute(ActionContext context)
warn: TiersPayant.Flux.Signature.FlowSigner[0]
      Clé de signature illisible, contenu reçu :
⟬private_key#1⟭
info: TiersPayant.Flux.Api.FluxController[0]
      Flux ⟬order_number#1⟭ en cours pour beneficiaire="⟬person_name#2⟭" nir="⟬fr_social_security_number#2⟭" organisme="⟬company#3⟭"
dbug: TiersPayant.Flux.Startup[0]
      ConnectionStrings:Default = Server=⟬hostname#1⟭;Database=tiers;User Id=⟬trap:indicator_non_pii|app_tiers⟭;Password=⟬password#1⟭;TrustServerCertificate=True
dbug: TiersPayant.Flux.Startup[0]
      Contact astreinte owner=⟬person_name#4⟭ tel="⟬phone#4⟭"
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: mixed
fill_locale: mixed
domain: SaaS
appearance: Go panic, goroutine frames, field holding several values
scenario: Go sync worker of a French CRM crashing on a nil pointer, with goroutine frames and a team as owner
⟬text⟭
level=error msg="relance automatique du worker" owner=⟬trap:indicator_non_pii|team-sync⟭ attrs="tenant=⟬customer_id#1⟭ shard=3"
panic: runtime error: invalid memory address or nil pointer dereference
[signal SIGSEGV: segmentation violation code=0x1 addr=0x18 pc=0x4a21]

goroutine 490 [running]:
main.(*Syncer).flushTenant(0xc0, {0x1, 0x2})
	/src/cmd/syncer/flush.go:88 +0x1f2
main.(*Syncer).Run(0xc0)
	/src/cmd/syncer/run.go:13 +0x88
created by main.main in goroutine 1
	/src/cmd/syncer/main.go:27 +0x12c
exit status 2
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: mixed
fill_locale: mixed
domain: e-commerce
appearance: Django debug report, Python frames, POST data, META headers, settings dump, stand-in values, keys under short names
scenario: Django error report of a French online shop mailed to its administrators, where the masking covers the obvious settings but not the payment and storage keys under short names
⟬text⟭
Environment:


Request Method: POST
Request URL: ⟬url#1⟭

Django Version: 4.2.11
Python Version: 3.11.8
Installed Applications:
['django.contrib.admin',
 'django.contrib.auth',
 'django.contrib.sessions',
 'boutique.panier',
 'boutique.paiement']
Installed Middleware:
['django.middleware.security.SecurityMiddleware',
 'django.contrib.sessions.middleware.SessionMiddleware',
 'django.middleware.csrf.CsrfViewMiddleware']


Traceback (most recent call last):
  File "/srv/boutique/.venv/lib/python3.11/site-packages/django/core/handlers/exception.py", line 55, in inner
    response = get_response(request)
  File "/srv/boutique/.venv/lib/python3.11/site-packages/django/core/handlers/base.py", line 197, in _get_response
    response = wrapped_callback(request, *callback_args, **callback_kwargs)
  File "/srv/boutique/boutique/paiement/views.py", line 64, in valider
    intent = psp.capture(commande, request.POST)
  File "/srv/boutique/boutique/paiement/psp.py", line 31, in capture
    raise PaiementRefuse(f"capture refusée pour {commande.reference}")

Exception Type: PaiementRefuse at /paiement/valider/
Exception Value: capture refusée pour ⟬order_number#1⟭

Request information:
USER: ⟬person_name#1⟭

GET: No GET data

POST:
csrfmiddlewaretoken = "⟬opaque_token#1⟭"
nom = "⟬person_name#1⟭"
adresse = "⟬fr_postal_address#1⟭"
telephone = "⟬phone#1⟭"

COOKIES:
sessionid = "⟬opaque_token#2⟭"
consentement = "analytics=0"

META:
HTTP_AUTHORIZATION = "Bearer ⟬jwt#1⟭"
HTTP_REFERER = "⟬url#1⟭"
REMOTE_ADDR = "⟬ip_address#1⟭"
SERVER_NAME = "⟬hostname#1⟭"

Settings:
Using settings module boutique.settings.prod
ADMINS = [("⟬person_name#2⟭", "⟬email#2⟭")]
ALLOWED_HOSTS = ['⟬hostname#1⟭']
DEFAULT_FROM_EMAIL = "⟬email:generic#3⟭"
LANGUAGE_CODE = 'fr-fr'
SECRET_KEY = '⟬trap:placeholder|********************⟭'
STRIPE_SECRET_KEY = '⟬trap:placeholder|********************⟭'
PSP_SK = '⟬stripe_secret_key#1⟭'
S3_ID = '⟬aws_access_key_id#1⟭'
S3_PRIV = '⟬aws_secret_access_key#1⟭'
TIME_ZONE = 'Europe/Paris'
USE_TZ = True

You're seeing this report because you have the "mail_admins" handler configured.
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: mixed
fill_locale: mixed
domain: e-commerce
appearance: NestJS error, JavaScript frames, JSON payload, French property name
scenario: reimbursement step of a French online pharmacy failing on a missing rate, with the prescription payload printed by a debug line
⟬text⟭
[Nest] 7029  - ⟬date#1⟭ 11:24:07   DEBUG [OrdonnanceController] payload {"patient":"⟬person_name#1⟭","nir":"⟬fr_social_security_number#1⟭","mutuelle":"⟬company#2⟭"}
[Nest] 7029  - ⟬date#1⟭ 11:24:07   ERROR [ExceptionsHandler] Cannot read properties of undefined (reading 'taux')
TypeError: Cannot read properties of undefined (reading 'taux')
    at RemboursementService.calculer (/app/dist/remboursement/remboursement.service.js:48:31)
    at OrdonnanceController.valider (/app/dist/ordonnance/ordonnance.controller.js:37:44)
    at /app/node_modules/@nestjs/core/router/router-execution-context.js:38:29
    at processTicksAndRejections (node:internal/process/task_queues:95:5)
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: mixed
fill_locale: mixed
domain: logistics
appearance: Android logcat crash, Kotlin frames, OkHttp header line, JSON response body
scenario: driver app of a Franco-British courier crashing after a 401, whose OkHttp logging interceptor had already printed the bearer token and the driver profile
⟬text⟭
⟬date#1⟭ 07:41:01.204  7621  8201 D OkHttp  : --> GET https://⟬hostname#1⟭/v3/chauffeur/profil
⟬date#1⟭ 07:41:01.204  7621  8201 D OkHttp  : Authorization: Bearer ⟬jwt#1⟭
⟬date#1⟭ 07:41:01.205  7621  8201 D OkHttp  : --> END GET
⟬date#1⟭ 07:41:01.611  7621  8201 D OkHttp  : <-- 200 https://⟬hostname#1⟭/v3/chauffeur/profil (406ms)
⟬date#1⟭ 07:41:01.612  7621  8201 D OkHttp  : {"chauffeur":"⟬person_name#2⟭","permis":"⟬uk_driving_licence#2⟭","tel":"⟬phone#2⟭","depot":"⟬city#2⟭"}
⟬date#1⟭ 07:41:01.613  7621  8201 D OkHttp  : <-- END HTTP (118-byte body)
⟬date#1⟭ 07:41:02.012  7621  8201 D OkHttp  : --> GET https://⟬hostname#1⟭/v3/tournee/du-jour
⟬date#1⟭ 07:41:02.013  7621  8201 D OkHttp  : Authorization: Bearer ⟬jwt#2⟭
⟬date#1⟭ 07:41:02.390  7621  8201 D OkHttp  : <-- 401 https://⟬hostname#1⟭/v3/tournee/du-jour (377ms)
--------- beginning of crash
⟬date#1⟭ 07:41:02.401  7621  7621 E AndroidRuntime: FATAL EXCEPTION: main
⟬date#1⟭ 07:41:02.401  7621  7621 E AndroidRuntime: Process: fr.exemple.chauffeur, PID: 7621
⟬date#1⟭ 07:41:02.401  7621  7621 E AndroidRuntime: retrofit2.HttpException: HTTP 401
⟬date#1⟭ 07:41:02.401  7621  7621 E AndroidRuntime: 	at retrofit2.KotlinExtensions$await$2$2.onResponse(KotlinExtensions.kt:53)
⟬date#1⟭ 07:41:02.401  7621  7621 E AndroidRuntime: 	at retrofit2.OkHttpCall$1.onResponse(OkHttpCall.java:164)
⟬date#1⟭ 07:41:02.401  7621  7621 E AndroidRuntime: 	at okhttp3.internal.connection.RealCall$AsyncCall.run(RealCall.kt:519)
⟬date#1⟭ 07:41:02.401  7621  7621 E AndroidRuntime: 	at fr.exemple.chauffeur.tournee.TourneeViewModel$charger$1.invokeSuspend(TourneeViewModel.kt:61)
⟬date#1⟭ 07:41:02.401  7621  7621 E AndroidRuntime: 	at kotlin.coroutines.jvm.internal.BaseContinuationImpl.resumeWith(ContinuationImpl.kt:33)
⟬date#1⟭ 07:41:02.401  7621  7621 E AndroidRuntime: 	at kotlinx.coroutines.DispatchedTask.run(DispatchedTask.kt:108)
⟬date#1⟭ 07:41:02.419  7621  7621 I Process : Sending signal. PID: 7621 SIG: 9
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: mixed
fill_locale: mixed
domain: banking
appearance: TeamCity console, build parameters, service messages, password in a Maven argument, failed test message
scenario: TeamCity deployment of a credit scoring library at a French bank, triggered by an engineer, where the parameter dump leaves the AWS keys visible and a failing test prints a fixture
⟬text⟭
[10:00:51]: Triggered by "⟬person_name#2⟭"
[10:00:51]: Agent: ⟬hostname#1⟭
[10:00:52]: Parameter env.AWS_ACCESS_KEY_ID=⟬aws_access_key_id#1⟭
[10:00:52]: Parameter env.AWS_SECRET_ACCESS_KEY=⟬aws_secret_access_key#1⟭
[10:00:52]: Parameter env.SONAR_TOKEN=⟬trap:placeholder|*******⟭
[10:00:58]: Step 1/2: Maven deploy
[10:00:58]: [Step 1/2] Starting: /opt/apache-maven/bin/mvn -B deploy -Dnexus.user="⟬trap:indicator_non_pii|ci-deployer⟭" -Dnexus.password=⟬password#1⟭
[10:00:58]: [Step 1/2] in directory: /opt/teamcity-agent/work/credit-score
[10:01:20]: [Step 1/2] [INFO] Scanning for projects...
[10:01:21]: [Step 1/2] [INFO] Building credit-score ⟬version#1⟭
[10:01:40]: [Step 1/2] [INFO] Running fr.banque.score.ScoreTest
[10:01:58]: [Step 1/2] ##teamcity[testStarted name='ScoreTest.rejetteNirInvalide']
[10:01:58]: [Step 1/2] ##teamcity[testFailed name='ScoreTest.rejetteNirInvalide' message='expected INVALIDE but was VALIDE for ⟬fr_social_security_number#3⟭']
[10:01:58]: [Step 1/2] ##teamcity[testFinished name='ScoreTest.rejetteNirInvalide' duration='84']
[10:01:58]: [Step 1/2] ##teamcity[testStarted name='ScoreTest.⟬trap:code_identifier|calculeScore⦃Family⦄⟭']
[10:01:58]: [Step 1/2] ##teamcity[testFinished name='ScoreTest.⟬trap:code_identifier|calculeScore⦃Family⦄⟭' duration='12']
[10:02:03]: [Step 1/2] [ERROR] Tests run: 84, Failures: 1, Errors: 0, Skipped: 2
[10:02:03]: [Step 1/2] [ERROR] Failed to execute goal org.apache.maven.plugins:maven-surefire-plugin:3.2.5:test (default-test) on project credit-score
[10:02:03]: [Step 1/2] Process exited with code 1
[10:02:03]: Step 2/2: Publier le rapport (skipped)
[10:02:04]: Build finished, owner=⟬trap:indicator_non_pii|moa-scoring⟭
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: mixed
fill_locale: mixed
domain: banking
appearance: Flyway command, JDBC URL, password in a URL, technical user in a URL
scenario: schema migration step of a French bank's accounts database, whose JDBC URL carries the user and password in its query string
⟬text⟭
+ flyway -url="jdbc:postgresql://⟬hostname#1⟭:5432/comptes?user=⟬trap:indicator_non_pii|flyway_ci⟭&password=⟬url_password#1⟭" migrate
Flyway Community Edition ⟬version#1⟭ by Redgate
Database: jdbc:postgresql://⟬hostname#1⟭:5432/comptes (PostgreSQL 15.4)
Successfully validated 41 migrations (execution time 00:00.214s)
Current version of schema "public": 40
Migrating schema "public" to version "41 - ajout colonne rib"
Successfully applied 1 migration to schema "public", now at version v41 (execution time 00:00.088s)
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: mixed
fill_locale: mixed
domain: SaaS
appearance: Tekton step, helm debug output, user-supplied values, private key in a YAML block, connection string, registry token
scenario: Tekton task upgrading the chart of a French appointment product with helm debug on, which prints the user-supplied values with its database URL, TLS key and registry token
⟬text⟭
[deploy : helm-upgrade] + helm upgrade --install agenda ./chart --namespace prod --debug --values /workspace/values-prod.yaml
[deploy : helm-upgrade] history.go:56: [debug] getting history for release agenda
[deploy : helm-upgrade] upgrade.go:142: [debug] preparing upgrade for agenda
[deploy : helm-upgrade] upgrade.go:150: [debug] performing update for agenda
[deploy : helm-upgrade] upgrade.go:322: [debug] creating upgraded release for agenda
[deploy : helm-upgrade] client.go:393: [debug] checking 8 resources for changes
[deploy : helm-upgrade] wait.go:48: [debug] beginning wait for 8 resources with timeout of 5m0s
[deploy : helm-upgrade] Release "agenda" has been upgraded. Happy Helming!
NAME: agenda
LAST DEPLOYED: ⟬date#1⟭ 18:02:47
NAMESPACE: prod
STATUS: deployed
REVISION: 80
USER-SUPPLIED VALUES:
image:
  tag: ⟬version#1⟭
db:
  url: postgres://agenda:⟬url_password#1⟭@⟬hostname#1⟭:5432/agenda?sslmode=require
tls:
  key: |
    ⟬private_key#1⟭
registry:
  server: ghcr.io
  user: ⟬trap:indicator_non_pii|agenda-ci⟭
  token: ⟬github_token#1⟭
alerting:
  owner: "⟬person_name#2⟭"
  mail: ⟬email#2⟭
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: mixed
fill_locale: mixed
domain: e-commerce
appearance: GitHub Actions step, environment block, Playwright failure, token in a remote URL, card fixture without a key, expected and received strings
scenario: end-to-end suite of a French online shop in GitHub Actions, whose environment block prints a payment key and whose failing test shows the customer fixture
⟬text⟭
Run npx playwright test --project=chromium
  npx playwright test --project=chromium
  shell: /usr/bin/bash -e {0}
  env:
    BASE_URL: ⟬url#1⟭
    PAY_KEY: ⟬stripe_secret_key#1⟭
    E2E_USER: ⟬trap:indicator_non_pii|e2e-robot⟭
    E2E_PASSWORD: ⟬trap:placeholder|***⟭

Running 12 tests using 2 workers

  ✓  1 [chromium] › panier.spec.ts:14:5 › ajoute un article au panier (2.1s)
  ✓  2 [chromium] › panier.spec.ts:31:5 › applique le code promo (1.4s)
  ✘  3 [chromium] › paiement.spec.ts:22:5 › affiche le récapitulatif client (5.2s)

  1) [chromium] › paiement.spec.ts:22:5 › affiche le récapitulatif client

    Error: expect(received).toContain(expected)

    Expected substring: "⟬person_name#2⟭"
    Received string:    "Livraison à ⟬person_name#3⟭, ⟬fr_postal_address#3⟭, carte ⟬payment_card#3⟭"

      23 |   await page.getByRole('button', { name: 'Payer' }).click()
    > 24 |   await expect(page.locator('#recap')).toContainText(client.nom)

    at /home/runner/work/boutique/boutique/e2e/paiement.spec.ts:24:42

  1 failed
  11 passed (41.8s)
Error: Process completed with exit code 1.
Run git push https://x-access-token:⟬github_token#1⟭@github.com/boutique-exemple/e2e-rapports.git HEAD:rapports
remote: Permission to boutique-exemple/e2e-rapports.git denied to github-actions[bot].
Error: Process completed with exit code 128.
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: mixed
fill_locale: mixed
domain: logistics
appearance: Jenkins console, Terraform plan and apply, sensitive stand-ins, Terraform outputs, private key in a heredoc, connection string, access keys
scenario: Jenkins job applying the Terraform of a French transport management platform, whose outputs block prints the database URL, the access keys of the runner and its generated SSH key
⟬text⟭
Started by timer
Running as SYSTEM
[Pipeline] Start of Pipeline
[Pipeline] node
Running on ⟬hostname#1⟭ in /var/lib/jenkins/workspace/tms-infra_main
[Pipeline] stage
[Pipeline] { (Plan)
[Pipeline] sh
+ terraform init -input=false
Initializing the backend...
Successfully configured the backend "s3"!
Initializing provider plugins...
- Reusing previous version of hashicorp/aws from the dependency lock file
- Reusing previous version of hashicorp/tls from the dependency lock file
- Using previously-installed hashicorp/aws ⟬version#1⟭
Terraform has been successfully initialized!
+ terraform plan -input=false -out=tfplan
aws_s3_bucket.preuves_livraison: Refreshing state... [id=preuves-livraison-eu]
aws_db_instance.tms: Refreshing state... [id=tms-preprod]
aws_iam_user.runner: Refreshing state... [id=tms-runner]
aws_iam_access_key.runner: Refreshing state... [id=⟬aws_access_key_id#1⟭]
tls_private_key.runner: Refreshing state... [id=⟬hash#1⟭]

Terraform will perform the following actions:

  # aws_db_instance.tms will be updated in-place
  ~ resource "aws_db_instance" "tms" {
        id                = "tms-preprod"
      ~ allocated_storage = 200 -> 400
      ~ password          = ⟬trap:placeholder|(sensitive value)⟭
        username          = "⟬trap:indicator_non_pii|tms_admin⟭"
        tags              = {
            "owner" = "⟬trap:indicator_non_pii|exploitation-transport⟭"
        }
    }

Plan: 0 to add, 1 to change, 0 to destroy.
[Pipeline] }
[Pipeline] stage
[Pipeline] { (Apply)
[Pipeline] sh
+ terraform apply -input=false tfplan
aws_db_instance.tms: Modifying... [id=tms-preprod]
aws_db_instance.tms: Still modifying... [id=tms-preprod, 10s elapsed]
aws_db_instance.tms: Still modifying... [id=tms-preprod, 20s elapsed]
aws_db_instance.tms: Modifications complete after 28s [id=tms-preprod]

Apply complete! Resources: 0 added, 1 changed, 0 destroyed.

Outputs:

db_url = "postgresql://tms_admin:⟬url_password#1⟭@⟬hostname#2⟭:5432/tms"
runner_access_key = "⟬aws_access_key_id#1⟭"
runner_secret_key = "⟬aws_secret_access_key#1⟭"
runner_ssh_private_key = <<EOT
⟬private_key#1⟭

EOT
webhook_token = "⟬github_token#1⟭"
[Pipeline] }
[Pipeline] echo
sauvegarde du plan vers ⟬file_path#1⟭
[Pipeline] End of Pipeline
Finished: SUCCESS
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: mixed
fill_locale: mixed
domain: logistics
appearance: Gradle console, dependency download lines, library names, signing stand-ins, field holding several values
scenario: release build of a warehouse scanning app in Gradle, with name-bearing libraries, masked signing values and no sensitive content
⟬text⟭
> Configure project :app
versionName=⟬version#1⟭, versionCode=638
dbg="flavor=entrepot abi=arm64-v8a minify=true"
Download https://repo.maven.apache.org/maven2/⟬trap:library|com/squareup/picasso/picasso/2.8/picasso-2.8.pom⟭
Download https://repo.maven.apache.org/maven2/⟬trap:library|com/fasterxml/jackson/core/jackson-core/2.17.0/jackson-core-2.17.0.jar⟭
Download https://repo.maven.apache.org/maven2/⟬trap:library|com/airbnb/android/lottie/6.4.0/lottie-6.4.0.aar⟭

> Task :app:preBuild UP-TO-DATE
> Task :app:compileReleaseKotlin
w: file:///builds/app/src/main/java/fr/quai/scan/LectureColis.kt:88:13 Variable 'tentative' is never used
> Task :app:mergeReleaseResources
> Task :app:lintVitalRelease
> Task :app:packageRelease
Signing with keyAlias=release storePassword=⟬trap:placeholder|****⟭
> Task :app:assembleRelease
> Task :app:bundleRelease

BUILD SUCCESSFUL in 2m 41s
58 actionable tasks: 53 executed, 17 up-to-date
Publishing build scan...
⟬url#1⟭
user=⟬trap:indicator_non_pii|gradle-bot⟭ owner="⟬trap:indicator_non_pii|equipe-entrepot⟭"
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: mixed
fill_locale: mixed
domain: logistics
appearance: Drone step, token in a composer command, seed output, values separated by slashes
scenario: Drone step installing private packages and seeding a demo driver for a courier's integration environment, whose seeder prints the row it creates
⟬text⟭
+ composer config -g github-oauth.github.com ⟬github_token#1⟭
+ composer install --no-interaction --no-dev
Generating optimized autoload files
+ php artisan db:seed --class=DemoChauffeurSeeder
Seeding: DemoChauffeurSeeder
chauffeur de démo créé : ⟬person_name#2m⟭ / ⟬uk_driving_licence#2⟭ / ⟬phone#2⟭
Seeded:  DemoChauffeurSeeder (41.20ms)
Database seeding completed successfully.
⟬end⟭
