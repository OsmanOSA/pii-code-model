⟬template⟭
family: logs
format: CI log
language: en
fill_locale: en_US
domain: healthcare
appearance: GoCD console, shell trace, connection string, JWT in a job log, sample record
scenario: GoCD pipeline of a behavioral health records app, whose deploy script echoes its database URL and a migration prints one patient row
⟬text⟭
[go] Job started on ⟬hostname#1⟭ at ⟬date#1⟭ 19:02:11
[go] Start to prepare behavioral-records/412/deploy/1/deploy-staging on ⟬hostname#1⟭
[go] Current job status: passed
[go] Start to execute task: <exec command="./ci/deploy.sh" />
+ export DATABASE_URL=postgresql://records_app:⟬url_password#1⟭@⟬hostname#2⟭:5432/records
+ export RELEASE_ACTOR=⟬trap:indicator_non_pii|gocd-agent⟭
+ curl -fsS -H "Authorization: Bearer ⟬jwt#1⟭" ⟬url#1⟭
{"stage":"staging","locked":false}
+ ./manage.py migrate --noinput
Applying charts.0041_add_consent_flags... OK
Applying charts.0042_backfill_consent... OK
backfill sample: id=8812 name="⟬person_name#2⟭" dob=⟬birth_date#2⟭ home="⟬postal_address#2⟭" consent=true
backfill done: 41822 rows
+ ./manage.py collectstatic --noinput
412 static files copied
+ systemctl restart records-web
+ ./ci/verify_login.sh ⟬trap:indicator_non_pii|smoke-user⟭ ⟬password#1⟭
200 OK
[go] Current job status: passed
[go] Job completed on ⟬hostname#1⟭ at ⟬date#1⟭ 19:04:40
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: en
fill_locale: en_US
domain: retail
appearance: key=value, audit trail, loss prevention case, plate in a field, quoted value
scenario: loss prevention case trail of an electronics chain, where officers record suspects, parking lot plates and a store manager's statement
⟬text⟭
⟬date#1⟭ 13:02:11 lp-audit case=⟬ticket_id#1⟭ officer="⟬person_name#1⟭" action=OPEN store=0412 type=shoplifting
⟬date#1⟭ 13:04:40 lp-audit case=⟬ticket_id#1⟭ officer="⟬person_name#1⟭" action=SUBJECT name="⟬person_name#2⟭" vehicle="⟬us_license_plate#2⟭"
⟬date#1⟭ 13:05:02 lp-audit case=⟬ticket_id#1⟭ officer="⟬person_name#1⟭" action=VIDEO_EXPORT clip=⟬uuid#1⟭ camera=entrance-3
⟬date#1⟭ 13:06:31 lp-audit case=⟬ticket_id#1⟭ officer=⟬trap:indicator_non_pii|parking-lpr⟭ action=LPR_MATCH vehicle="⟬us_license_plate#2⟭" seen=3
⟬date#1⟭ 13:08:14 lp-audit case=⟬ticket_id#1⟭ officer="⟬person_name#1⟭" action=STATEMENT text="store manager ⟬person_name#3⟭ saw the customer leave by the garden exit"
⟬date#1⟭ 13:20:00 lp-audit case=⟬ticket_id#1⟭ officer="⟬person_name#1⟭" action=POLICE_REPORT ref=⟬order_number#1⟭
⟬date#1⟭ 13:45:17 lp-audit case=⟬ticket_id#2⟭ officer=⟬trap:indicator_non_pii|rfid-gate⟭ action=OPEN store=0412 type=tag-alarm
⟬date#1⟭ 13:45:18 lp-audit case=⟬ticket_id#2⟭ officer=⟬trap:indicator_non_pii|rfid-gate⟭ action=CLOSE reason=false-alarm
⟬date#1⟭ 14:12:03 lp-audit case=⟬ticket_id#3⟭ officer="⟬person_name#4⟭" action=OPEN store=0388 type=refund-fraud
⟬date#1⟭ 14:13:30 lp-audit case=⟬ticket_id#3⟭ officer="⟬person_name#4⟭" action=SUBJECT name="⟬person_name#5⟭" employee_id=⟬customer_id#5⟭
⟬date#1⟭ 14:14:02 lp-audit case=⟬ticket_id#3⟭ officer="⟬person_name#4⟭" action=TX_PULL register=06 count=18
⟬date#1⟭ 14:20:44 lp-audit case=⟬ticket_id#3⟭ officer="⟬person_name#4⟭" action=NOTE text="same card ⟬payment_card#6⟭ on all 18 refunds"
⟬date#1⟭ 14:40:10 lp-audit case=⟬ticket_id#3⟭ officer="⟬person_name#4⟭" action=HR_REFERRAL to=⟬trap:indicator_non_pii|hr-investigations⟭
⟬date#1⟭ 15:02:00 lp-audit case=⟬ticket_id#4⟭ officer="⟬person_name#1⟭" action=OPEN store=0412 type=parking-damage
⟬date#1⟭ 15:03:21 lp-audit case=⟬ticket_id#4⟭ officer="⟬person_name#1⟭" action=SUBJECT vehicle="⟬us_license_plate#7⟭" driver_unknown=true
⟬date#1⟭ 16:30:00 lp-audit batch=⟬uuid#2⟭ officer=⟬trap:indicator_non_pii|retention-job⟭ action=PURGE_VIDEO older_than_days=90 removed=41
⟬end⟭

⟬template⟭
family: logs
format: application log
language: en
fill_locale: en_US
domain: SaaS
appearance: log field, HTTP header, prefixed keys, secret under an innocuous key
scenario: LLM gateway of a support desk product, whose debug level logs the provider keys sent upstream and a session value
⟬text⟭
⟬date#1⟭ 12:01:02 ai-gateway INFO route=summarize provider=openai tokens=412 latency_ms=812
⟬date#1⟭ 12:01:02 ai-gateway DEBUG upstream header Authorization: Bearer ⟬openai_api_key#1⟭
⟬date#1⟭ 12:01:09 ai-gateway INFO route=reply provider=anthropic tokens=1204 latency_ms=2204
⟬date#1⟭ 12:01:09 ai-gateway DEBUG upstream header x-api-key: ⟬anthropic_api_key#1⟭
⟬date#1⟭ 12:01:09 ai-gateway DEBUG cached conversation value=⟬opaque_token#1⟭ ttl=900
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: en
fill_locale: en_US
domain: healthcare
appearance: Java stack trace, DICOM tags, anonymized field, code identifier
scenario: Java trace of a medical image anonymizer failing on a malformed tag, printing only DICOM tag numbers and already blank patient fields
⟬text⟭
⟬date#1⟭ 23:14:02,118 ERROR [dicom-worker-2] m.i.anon.Pipeline - study ⟬uuid#1⟭ rejected
org.dcm4che3.io.DicomStreamException: Invalid DICOM stream at offset 41208: tag (7FE0,0010) length exceeds file
	at org.dcm4che3.io.DicomInputStream.readHeader(DicomInputStream.java:437)
	at org.dcm4che3.io.DicomInputStream.readAttributes(DicomInputStream.java:584)
	at org.dcm4che3.io.DicomInputStream.readDataset(DicomInputStream.java:541)
	at com.medimage.anon.Pipeline.load(Pipeline.java:88)
	at com.medimage.anon.Pipeline.process(Pipeline.java:61)
	at com.medimage.anon.Worker.run(Worker.java:41)
	at java.base/java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1136)
	at java.base/java.lang.Thread.run(Thread.java:840)
Parsed tags before failure:
  (0008,0060) Modality = MR
  (0008,1030) StudyDescription = ⟬trap:eponym|Hodgkin⟭ staging
  (0010,0010) ⟬trap:indicator_non_pii|PatientName = ANON⟭
  (0010,0020) ⟬trap:indicator_non_pii|PatientID = ANON_0412⟭
  (0010,0030) ⟬trap:indicator_non_pii|PatientBirthDate = (empty)⟭
  (0020,000D) StudyInstanceUID = ⟬uuid#1⟭
File moved to ⟬file_path#1⟭, ⟬trap:indicator_non_pii|owner=imaging-it⟭
⟬end⟭

⟬template⟭
family: logs
format: test output
language: en
fill_locale: en_US
domain: retail
appearance: Pact verification output, stand-in values, contract test
scenario: Pact verification between a store's checkout and payment services, where every example body holds matchers and stand-ins
⟬text⟭
Verifying a pact between checkout-web and payments-api

  a request to tokenize a card (0s loading, 12ms verification)
     Given a valid merchant
    returns a response which
      has status code 201 (OK)
      includes headers
        "Content-Type" with value "application/json" (OK)
      has a matching body (OK)

  a request to refund an order (0s loading, 9ms verification)
     Given an order exists
    returns a response which
      has status code 200 (OK)
      has a matching body (FAILED)

Failures:

1) Verifying a pact between checkout-web and payments-api Given an order exists - a request to refund an order
    1.1) has a matching body
           $.refund -> Expected '⟬trap:indicator_non_pii|customer_email: <email>⟭' to match ⟬trap:indicator_non_pii|<email>⟭
           $.refund -> Expected '⟬trap:indicator_non_pii|card_last4: 0000⟭' but was missing
           $.auth -> Expected '⟬trap:placeholder|<token>⟭' but received '⟬trap:placeholder|<redacted>⟭'

There were 1 pact failures
⟬end⟭

⟬template⟭
family: logs
format: access log
language: en
fill_locale: en_US
domain: government
appearance: Squid access line, outbound proxy, passport in a query string, token in a query string, authenticated user field
scenario: outbound Squid proxy of a state agency, showing staff requests to vendor checks with passports and keys in the query string, tunnels and blocked sites
⟬text⟭
⟬date#1⟭ 14:02:11.118    412 ⟬ip_address#1⟭ TCP_TUNNEL/200 8120 CONNECT ⟬hostname#1⟭:443 ⟬person_name:handle#2⟭ HIER_DIRECT/⟬ip_address#2⟭ -
⟬date#1⟭ 14:02:15.204     88 ⟬ip_address#1⟭ TCP_MISS/200 1204 GET http://verify.vendor-check.example/lookup?passport=⟬us_passport#3⟭&key=⟬opaque_token#1⟭ ⟬person_name:handle#2⟭ HIER_DIRECT/⟬ip_address#3⟭ application/json
⟬date#1⟭ 14:02:19.402     61 ⟬ip_address#1⟭ TCP_MISS/200 880 GET http://verify.vendor-check.example/lookup?email=⟬email#4⟭&key=⟬opaque_token#1⟭ ⟬person_name:handle#2⟭ HIER_DIRECT/⟬ip_address#3⟭ application/json
⟬date#1⟭ 14:02:30.118      0 ⟬ip_address#4⟭ TCP_DENIED/403 3120 CONNECT ⟬hostname#2⟭:443 ⟬person_name:handle#5⟭ HIER_NONE/- text/html
⟬date#1⟭ 14:02:41.204    118 ⟬ip_address#5⟭ TCP_TUNNEL/200 41208 CONNECT ⟬hostname#3⟭:443 ⟬username#1⟭ HIER_DIRECT/⟬ip_address#6⟭ -
⟬date#1⟭ 14:02:52.402     44 ⟬ip_address#6⟭ TCP_MEM_HIT/200 2204 GET http://updates.gov-mirror.example/definitions.cab ⟬username#2⟭ HIER_NONE/- application/octet-stream
⟬date#1⟭ 14:03:02.118    204 ⟬ip_address#7⟭ TCP_MISS/200 612 POST http://sso.vendor-portal.example/token?assertion=⟬jwt#1⟭ ⟬person_name:handle#6⟭ HIER_DIRECT/⟬ip_address#7⟭ application/json
⟬date#1⟭ 14:03:15.204     71 ⟬ip_address#7⟭ TCP_MISS/200 1820 GET http://cases.vendor-portal.example/api/case/⟬uuid#1⟭?access_token=⟬jwt#2⟭ ⟬person_name:handle#6⟭ HIER_DIRECT/⟬ip_address#7⟭ application/json
⟬date#1⟭ 14:03:30.402     33 ⟬ip_address#8⟭ TCP_MISS/404 212 GET http://verify.vendor-check.example/lookup?passport=⟬us_passport#8⟭&key=⟬opaque_token#2⟭ ⟬person_name:handle#9⟭ HIER_DIRECT/⟬ip_address#3⟭ text/html
⟬date#1⟭ 14:03:44.118      0 ⟬ip_address#9⟭ TCP_DENIED/407 1204 GET http://news.example/ - HIER_NONE/- text/html
⟬date#1⟭ 14:03:58.204    412 ⟬ip_address#10⟭ TCP_TUNNEL/200 88120 CONNECT ⟬hostname#4⟭:443 ⟬person_name:handle#10⟭ HIER_DIRECT/⟬ip_address#8⟭ -
⟬date#1⟭ 14:04:12.118     18 ⟬ip_address#1⟭ TCP_MISS/200 96 GET http://verify.vendor-check.example/health ⟬person_name:handle#2⟭ HIER_DIRECT/⟬ip_address#3⟭ application/json
⟬date#1⟭ 14:04:30.402    210 ⟬ip_address#11⟭ TCP_MISS/200 3120 POST ⟬url#1⟭ ⟬username#3⟭ HIER_DIRECT/⟬ip_address#9⟭ application/json
⟬date#1⟭ 14:04:51.118     61 ⟬ip_address#12⟭ TCP_MISS/200 188 GET http://verify.vendor-check.example/lookup?ref=⟬uuid#2⟭ ⟬person_name:handle#9⟭ HIER_DIRECT/⟬ip_address#3⟭ application/json
⟬date#1⟭ 14:05:04.204     88 ⟬ip_address#12⟭ TCP_MISS/200 188 GET http://verify.vendor-check.example/lookup?ref=⟬opaque_token#3⟭ ⟬person_name:handle#9⟭ HIER_DIRECT/⟬ip_address#3⟭ application/json
⟬date#1⟭ 14:05:30.402      0 ⟬ip_address#13⟭ TCP_DENIED/403 3120 GET http://paste.example/raw ⟬person_name:handle#11⟭ HIER_NONE/- text/html
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: en
fill_locale: en_US
domain: travel
appearance: PowerShell step, self-hosted Windows runner, environment block, password in a command, test fixture
scenario: Windows runner publishing a travel agent desktop tool, whose PowerShell script prints an MSI signing password and a smoke test logs a fixture traveler's passport
⟬text⟭
Run .\scripts\publish.ps1
  shell: C:\Program Files\PowerShell\7\pwsh.EXE -command ". '{0}'"
  env:
    SIGN_USER: ⟬trap:indicator_non_pii|svc-agentdesk⟭
    NUGET_SOURCE: ⟬url#1⟭
PS> dotnet publish .\src\AgentDesk.sln -c Release -r win-x64
  AgentDesk.Core -> C:\actions-runner\_work\agentdesk\src\Core\bin\Release\net8.0\AgentDesk.Core.dll
  AgentDesk.App -> C:\actions-runner\_work\agentdesk\src\App\bin\Release\net8.0-windows\win-x64\publish\
PS> signtool sign /f .\agentdesk.pfx /p ⟬password#1⟭ /tr http://timestamp.example /td sha256 .\out\AgentDesk.msi
Done Adding Additional Store
Successfully signed: .\out\AgentDesk.msi
PS> .\out\smoke.exe --profile "⟬person_name#2⟭" --document ⟬us_passport#2⟭
[smoke] login as ⟬trap:indicator_non_pii|user=qa-agent⟭ with ⟬password#2⟭
[smoke] booking lookup ⟬order_number#1⟭ ok
[smoke] itinerary to ⟬trap:word_name|Sydney⟭ rendered
[smoke] seat map ok
PS> Write-Host "Published build ⟬version#1⟭ from ⟬git_sha#1⟭"
Published build ⟬version#1⟭ from ⟬git_sha#1⟭
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: en
fill_locale: en_US
domain: fintech
appearance: key=value, maker-checker trail, customer on both sides, card in a note, SSN reveal
scenario: maker-checker trail of a bank's operations desk, where wires and card replacements are entered and approved, with customers that are people or internal test accounts
⟬text⟭
⟬date#1⟭ 09:01:12 ops-audit maker="⟬person_name#1⟭" action=WIRE_ENTER customer="⟬person_name#2⟭" acct=⟬bank_account_number#2⟭ amt=18400.00 ref=⟬uuid#1⟭
⟬date#1⟭ 09:03:40 ops-audit checker="⟬person_name#3⟭" action=WIRE_APPROVE ref=⟬uuid#1⟭
⟬date#1⟭ 09:03:41 ops-audit maker=⟬trap:indicator_non_pii|swift-gateway⟭ action=WIRE_SEND ref=⟬uuid#1⟭ bic=⟬bic#2⟭
⟬date#1⟭ 09:15:22 ops-audit maker="⟬person_name#1⟭" action=WIRE_ENTER customer=⟬trap:indicator_non_pii|ops-test-account⟭ amt=1.00 ref=⟬uuid#2⟭
⟬date#1⟭ 09:15:50 ops-audit checker=⟬trap:indicator_non_pii|auto-approve-under-10⟭ action=WIRE_APPROVE ref=⟬uuid#2⟭
⟬date#1⟭ 09:31:07 ops-audit maker="⟬person_name#4⟭" action=CARD_REPLACE customer="⟬person_name#5⟭" old=⟬payment_card#5⟭ reason=stolen
⟬date#1⟭ 09:31:08 ops-audit maker="⟬person_name#4⟭" action=NOTE text="verified with last transaction and ssn ⟬us_ssn#5⟭"
⟬date#1⟭ 09:44:19 ops-audit checker="⟬person_name#3⟭" action=CARD_APPROVE customer="⟬person_name#5⟭"
⟬date#1⟭ 10:02:33 ops-audit maker="⟬person_name#4⟭" action=ADDRESS_CHANGE customer="⟬person_name#6⟭" new="⟬postal_address#6⟭"
⟬date#1⟭ 10:02:59 ops-audit checker=⟬trap:indicator_non_pii|callback-pending⟭ action=HOLD customer="⟬person_name#6⟭"
⟬date#1⟭ 10:20:14 ops-audit checker="⟬person_name#3⟭" action=CALLBACK_OK customer="⟬person_name#6⟭" phone=⟬phone#6⟭
⟬date#1⟭ 11:05:02 ops-audit maker=⟬trap:indicator_non_pii|batch-fees⟭ action=FEE_POST count=412 customer=⟬trap:indicator_non_pii|all-retail⟭
⟬date#1⟭ 11:40:47 ops-audit maker="⟬person_name#1⟭" action=SSN_CORRECT customer="⟬person_name#7⟭" old=⟬us_ssn#7⟭ new=⟬us_ssn#8⟭ ticket=⟬ticket_id#1⟭
⟬date#1⟭ 11:44:12 ops-audit checker="⟬person_name#3⟭" action=SSN_APPROVE ticket=⟬ticket_id#1⟭
⟬date#1⟭ 12:00:00 ops-audit maker=⟬trap:indicator_non_pii|eod-runner⟭ action=SNAPSHOT file=⟬hash#1⟭ version=⟬version#1⟭
⟬date#1⟭ 12:00:02 ops-audit maker=⟬trap:indicator_non_pii|eod-runner⟭ action=FORWARD dest=⟬hostname#1⟭
⟬end⟭

⟬template⟭
family: logs
format: application log
language: en
fill_locale: en_US
domain: retail
appearance: Flask logger line, SMS message body, plate in a sentence, address in a sentence
scenario: curbside and home delivery notifier of a garden center, sending SMS bodies with names, plates, addresses and drivers
⟬text⟭
⟬date#1⟭ 08:02:14 INFO [notifier] order ⟬order_number#1⟭ ready for pickup
⟬date#1⟭ 08:02:14 DEBUG [notifier] sms to ⟬phone#2⟭: Hi ⟬person_name:given#2⟭, your order is ready, reply with your plate
⟬date#1⟭ 08:15:40 INFO [inbound] sms from ⟬phone#2⟭: here now, ⟬us_license_plate#2⟭
⟬date#1⟭ 08:15:41 INFO [curbside] order ⟬order_number#1⟭ matched to plate "⟬us_license_plate#2⟭", bay 3
⟬date#1⟭ 08:17:02 INFO [curbside] associate "⟬person_name#3⟭" on the way
⟬date#1⟭ 08:40:18 INFO [delivery] route 7 loaded, driver "⟬person_name#4⟭" truck "⟬us_license_plate#4⟭"
⟬date#1⟭ 08:40:19 INFO [delivery] route 7 driver=⟬trap:indicator_non_pii|contract-carrier⟭ on leg 2
⟬date#1⟭ 08:40:20 DEBUG [delivery] stop 1 name="⟬person_name#5⟭" addr="⟬postal_address#5⟭" items="40 bags of mulch"
⟬date#1⟭ 08:40:20 DEBUG [delivery] stop 2 name="⟬person_name#6⟭" addr="⟬postal_address#6⟭" items="1 ⟬trap:word_name|Rose⟭ of Sharon, 2 ⟬trap:word_name|Hazel⟭ shrubs"
⟬date#1⟭ 09:12:31 INFO [delivery] stop 1 done, signed by ⟬person_name#5⟭
⟬date#1⟭ 09:50:04 WARN [delivery] stop 2 nobody home, left with neighbor at ⟬postal_address#7⟭
⟬date#1⟭ 09:50:05 DEBUG [notifier] sms to ⟬phone#6⟭: your plants are with your neighbor
⟬date#1⟭ 10:02:00 INFO [payments] curbside tip of 5.00 on card ⟬payment_card#2⟭
⟬date#1⟭ 10:30:00 INFO [metrics] sms_sent=41 failed=0 version=⟬version#1⟭
⟬date#1⟭ 10:44:12 ERROR [notifier] provider returned 500 for ⟬phone#8⟭, ⟬trap:indicator_non_pii|owner=store-systems⟭
⟬date#1⟭ 10:44:13 INFO [notifier] retry queued ⟬uuid#1⟭
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: en
fill_locale: en_US
domain: government
appearance: Oracle error, PL/SQL backtrace, Java stack trace, bind variables, Caused by chain
scenario: Oracle unique constraint failure in a state vital records registry, with a PL/SQL backtrace, Java frames and logged bind variables holding SSN, passport, license and address
⟬text⟭
⟬date#1⟭ 10:14:02,118 ERROR [registry-api-7] g.s.vitals.PersonDao - insert failed for request ⟬uuid#1⟭
org.springframework.dao.DuplicateKeyException: PreparedStatementCallback; SQL [BEGIN PKG_PERSON.CREATE_PERSON(:1, :2, :3, :4, :5, :6); END;]; ORA-00001: unique constraint (VITALS.UQ_PERSON_SSN) violated
ORA-06512: at "VITALS.PKG_PERSON", line 412
ORA-06512: at "VITALS.PKG_PERSON", line 188
ORA-06512: at line 1
	at org.springframework.jdbc.support.SQLErrorCodeSQLExceptionTranslator.doTranslate(SQLErrorCodeSQLExceptionTranslator.java:247)
	at org.springframework.jdbc.support.AbstractFallbackSQLExceptionTranslator.translate(AbstractFallbackSQLExceptionTranslator.java:70)
	at org.springframework.jdbc.core.JdbcTemplate.translateException(JdbcTemplate.java:1576)
	at org.springframework.jdbc.core.JdbcTemplate.execute(JdbcTemplate.java:667)
	at org.springframework.jdbc.core.JdbcTemplate.execute(JdbcTemplate.java:713)
	at gov.state.vitals.PersonDao.create(PersonDao.java:88)
	at gov.state.vitals.PersonService.register(PersonService.java:141)
	at gov.state.vitals.PersonService$$SpringCGLIB$$0.register(<generated>)
	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:768)
	at org.springframework.transaction.interceptor.TransactionInterceptor.invoke(TransactionInterceptor.java:119)
	at gov.state.vitals.RegistryController.create(RegistryController.java:57)
	at jakarta.servlet.http.HttpServlet.service(HttpServlet.java:590)
	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:174)
	at org.apache.tomcat.util.threads.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:659)
Caused by: java.sql.SQLIntegrityConstraintViolationException: ORA-00001: unique constraint (VITALS.UQ_PERSON_SSN) violated
ORA-06512: at "VITALS.PKG_PERSON", line 412
ORA-06512: at "VITALS.PKG_PERSON", line 188
ORA-06512: at line 1
	at oracle.jdbc.driver.T4CTTIoer11.processError(T4CTTIoer11.java:509)
	at oracle.jdbc.driver.T4CTTIoer11.processError(T4CTTIoer11.java:461)
	at oracle.jdbc.driver.T4C8Oall.processError(T4C8Oall.java:1104)
	at oracle.jdbc.driver.T4CTTIfun.receive(T4CTTIfun.java:550)
	at oracle.jdbc.driver.T4CTTIfun.doRPC(T4CTTIfun.java:268)
	at oracle.jdbc.driver.T4C8Oall.doOALL(T4C8Oall.java:655)
	at oracle.jdbc.driver.T4CCallableStatement.doOall8(T4CCallableStatement.java:270)
	at oracle.jdbc.driver.OraclePreparedStatement.executeInternal(OraclePreparedStatement.java:3752)
	at oracle.jdbc.driver.OraclePreparedStatement.execute(OraclePreparedStatement.java:4136)
	at com.zaxxer.hikari.pool.ProxyPreparedStatement.execute(ProxyPreparedStatement.java:44)
	at org.springframework.jdbc.core.JdbcTemplate$1.doInPreparedStatement(JdbcTemplate.java:1037)
	... 62 common frames omitted

Bind variables:
  :1 = "⟬person_name#2⟭"
  :2 = "⟬us_ssn#2⟭"
  :3 = "⟬birth_date#2⟭"
  :4 = "⟬us_driver_license#2⟭"
  :5 = "⟬us_passport#2⟭"
  :6 = "⟬postal_address#2⟭"

Existing row with the same SSN:
  PERSON_ID   : ⟬customer_id#3⟭
  FULL_NAME   : ⟬person_name#3⟭
  DOB         : ⟬birth_date#3⟭
  DL_NUMBER   : ⟬us_driver_license#3⟭
  MAILING     : ⟬postal_address#3⟭
  CREATED     : ⟬date#2⟭
  CREATED_BY  : ⟬trap:indicator_non_pii|legacy-migration⟭

Possible duplicates by name (⟬trap:eponym|Jaro-Winkler⟭ above 0.9):
  ⟬customer_id#4⟭ ⟬person_name#4⟭
  ⟬customer_id#5⟭ ⟬person_name#5⟭

⟬date#1⟭ 10:14:02,204 INFO  [registry-api-7] g.s.vitals.MergeQueue - request ⟬uuid#1⟭ sent to merge review, clerk="⟬person_name#6⟭"
⟬date#1⟭ 10:14:02,206 INFO  [registry-api-7] g.s.vitals.MergeQueue - ticket ⟬ticket_id#1⟭, ⟬trap:indicator_non_pii|owner=vital-records-desk⟭
⟬date#1⟭ 10:14:02,301 WARN  [registry-api-7] g.s.vitals.AuditWriter - sensitive binds written to the error log, see ⟬ticket_id#2⟭
⟬date#1⟭ 10:14:03,118 INFO  [registry-api-3] g.s.vitals.Health - pool active=12 idle=18 version=⟬version#1⟭
⟬end⟭

⟬template⟭
family: logs
format: test output
language: en
fill_locale: en_US
domain: travel
appearance: Deno test output, stand-in value, code identifier
scenario: Deno test run of a currency rounding helper for a tour site, with no person
⟬text⟭
running 3 tests from ./fares_test.ts
rounds to the nearest cent ... ok (2ms)
⟬trap:code_identifier|applies_⦃family⦄_markup⟭ ... ok (1ms)
⟬trap:indicator_non_pii|ignores customer=<NAME>⟭ ... FAILED (1ms)

ok | 2 passed | 1 failed (41ms)
⟬end⟭

⟬template⟭
family: logs
format: access log
language: en
fill_locale: en_US
domain: fintech
appearance: nginx custom format, request id, card without a key, JWT, token in a query string, Authorization capture
scenario: nginx in front of a payment page of a lender, with a debug format keeping the Authorization header and a body excerpt that exposes cards under neutral names
⟬text⟭
req=⟬uuid#1⟭ ip=⟬ip_address#1⟭ t="⟬date#1⟭ 15:02:11" m=GET u="/pay/start?invoice=⟬invoice_number#1⟭&link=⟬opaque_token#1⟭" s=200 auth="-" body="-"
req=⟬uuid#2⟭ ip=⟬ip_address#1⟭ t="⟬date#1⟭ 15:02:40" m=POST u="/pay/submit" s=402 auth="-" body="a=⟬payment_card#2⟭&b=⟬card_security_code#2⟭&c=⟬postcode#2⟭"
req=⟬uuid#3⟭ ip=⟬ip_address#1⟭ t="⟬date#1⟭ 15:03:02" m=POST u="/pay/submit" s=200 auth="-" body="a=⟬payment_card#3⟭&b=⟬card_security_code#3⟭&c=⟬postcode#3⟭"
req=⟬uuid#4⟭ ip=⟬ip_address#2⟭ t="⟬date#1⟭ 15:03:15" m=GET u="/healthz" s=200 auth="-" body="-"
req=⟬uuid#5⟭ ip=⟬ip_address#3⟭ t="⟬date#1⟭ 15:03:30" m=GET u="/api/v1/loans/⟬uuid#6⟭" s=200 auth="Bearer ⟬jwt#1⟭" body="-"
req=⟬uuid#7⟭ ip=⟬ip_address#3⟭ t="⟬date#1⟭ 15:03:44" m=POST u="/api/v1/loans/⟬uuid#6⟭/autopay" s=200 auth="Bearer ⟬jwt#1⟭" body="routing=⟬bic#4⟭&acct=⟬bank_account_number#4⟭"
req=⟬uuid#8⟭ ip=⟬ip_address#4⟭ t="⟬date#1⟭ 15:04:02" m=POST u="/api/v1/auth" s=401 auth="-" body="user=⟬trap:indicator_non_pii|servicing-bot⟭&pass=⟬password#1⟭"
req=⟬uuid#9⟭ ip=⟬ip_address#4⟭ t="⟬date#1⟭ 15:04:05" m=POST u="/api/v1/auth" s=200 auth="-" body="user=⟬email#5⟭&pass=⟬password#2⟭"
req=⟬uuid#10⟭ ip=⟬ip_address#5⟭ t="⟬date#1⟭ 15:04:20" m=GET u="/statements/download?t=⟬opaque_token#2⟭" s=200 auth="-" body="-"
req=⟬uuid#11⟭ ip=⟬ip_address#6⟭ t="⟬date#1⟭ 15:04:41" m=GET u="/statements/download?t=⟬opaque_token#4⟭" s=404 auth="-" body="-"
req=⟬uuid#13⟭ ip=⟬ip_address#7⟭ t="⟬date#1⟭ 15:05:02" m=POST u="/webhooks/bureau" s=202 auth="Basic ⟬opaque_token#3⟭" body="-"
req=⟬uuid#14⟭ ip=⟬ip_address#8⟭ t="⟬date#1⟭ 15:05:18" m=GET u="/api/v1/rates?state=⟬trap:word_name|Georgia⟭" s=200 auth="-" body="-"
req=⟬uuid#15⟭ ip=⟬ip_address#2⟭ t="⟬date#1⟭ 15:05:30" m=GET u="/healthz" s=200 auth="-" body="-"
req=⟬uuid#16⟭ ip=⟬ip_address#9⟭ t="⟬date#1⟭ 15:05:44" m=POST u="/support/message" s=201 auth="Bearer ⟬jwt#2⟭" body="msg=please call ⟬person_name#6⟭ on ⟬phone#6⟭ about the payoff"
req=⟬uuid#17⟭ ip=⟬ip_address#10⟭ t="⟬date#1⟭ 15:06:02" m=POST u="/pay/submit" s=200 auth="-" body="a=⟬payment_card#7⟭&b=⟬card_security_code#7⟭&c=⟬postcode#7⟭"
req=⟬uuid#18⟭ ip=⟬ip_address#10⟭ t="⟬date#1⟭ 15:06:03" m=GET u="/pay/receipt?id=⟬uuid#19⟭" s=200 auth="-" body="-"
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: en
fill_locale: en_US
domain: SaaS
appearance: shell trace, git remote with token, prefixed token
scenario: release script of a SaaS API, setting the git remote with an installation token and printing a Slack token
⟬text⟭
+ git remote set-url origin https://x-access-token:⟬github_token#1⟭@github.com/helix/api.git
+ git push origin HEAD:refs/heads/release
To https://github.com/helix/api.git
 * [new branch]      HEAD -> release
+ curl -s -H "Authorization: Bearer ⟬slack_token#1⟭" -d "channel=releases" ⟬url#1⟭
{"ok":true}
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: en
fill_locale: en_US
domain: healthcare
appearance: key=value, audit trail, license at pickup, controlled substance
scenario: pharmacy controlled substance log, where a pickup records the customer's license and the verifying pharmacist
⟬text⟭
⟬date#1⟭ 16:02:11 rx-audit rx=⟬order_number#1⟭ schedule=II action=PICKUP patient="⟬person_name#1⟭" id_scanned="⟬us_driver_license#1⟭"
⟬date#1⟭ 16:02:12 rx-audit rx=⟬order_number#1⟭ action=VERIFY pharmacist="⟬person_name#2⟭"
⟬date#1⟭ 16:02:40 rx-audit rx=⟬order_number#1⟭ action=PDMP_REPORT dest=⟬hostname#1⟭ ⟬trap:indicator_non_pii|operator=pdmp-bridge⟭
⟬end⟭

⟬template⟭
family: logs
format: application log
language: en
fill_locale: en_US
domain: travel
appearance: ACARS message, flight operations, airport names, crew field without a name
scenario: flight operations message switch of a regional carrier relaying ACARS position and fuel reports through a morning, with crew and passenger fields empty
⟬text⟭
⟬date#1⟭ 06:00:02 acars-gw INFO link up dsp=ARINC version=⟬version#1⟭
⟬date#1⟭ 06:00:03 acars-gw INFO routing table loaded path=⟬file_path#1⟭ entries=118
⟬date#1⟭ 06:02:11 acars-gw INFO OOOI flight=AZ318 tail=N412AZ event=OUT station=CLT
⟬date#1⟭ 06:14:40 acars-gw INFO OOOI flight=AZ318 tail=N412AZ event=OFF station=CLT
⟬date#1⟭ 06:20:02 acars-gw INFO POS flight=AZ318 tail=N412AZ fl=240 fuel_kg=8120 eta=08:02
⟬date#1⟭ 06:25:00 acars-gw INFO WX request station=⟬trap:word_name|Austin⟭ source=dispatch
⟬date#1⟭ 06:25:02 acars-gw INFO WX reply station=⟬trap:word_name|Austin⟭ metar=ok
⟬date#1⟭ 06:30:02 acars-gw INFO POS flight=AZ318 tail=N412AZ fl=340 fuel_kg=7640 eta=08:01
⟬date#1⟭ 06:32:18 acars-gw INFO OOOI flight=AZ502 tail=N188AZ event=OUT station=CLT
⟬date#1⟭ 06:44:51 acars-gw INFO OOOI flight=AZ502 tail=N188AZ event=OFF station=CLT
⟬date#1⟭ 06:45:02 acars-gw DEBUG uplink flight=AZ502 ⟬trap:indicator_non_pii|crew_name=not-sent⟭ ⟬trap:indicator_non_pii|passenger_count_only=true⟭
⟬date#1⟭ 06:50:02 acars-gw INFO POS flight=AZ318 tail=N412AZ fl=360 fuel_kg=6980 eta=07:59
⟬date#1⟭ 06:50:03 acars-gw INFO POS flight=AZ502 tail=N188AZ fl=280 fuel_kg=5120 eta=08:12
⟬date#1⟭ 07:00:00 acars-gw INFO stats messages_1h=412 retries=3 ⟬trap:indicator_non_pii|operator=dispatch-desk-2⟭
⟬date#1⟭ 07:02:40 acars-gw WARN late position report flight=AZ711 tail=N204AZ delay_s=118
⟬date#1⟭ 07:02:41 acars-gw INFO ticket ⟬ticket_id#1⟭ opened, ⟬trap:indicator_non_pii|owner=ops-control⟭
⟬date#1⟭ 07:05:12 acars-gw INFO POS flight=AZ711 tail=N204AZ fl=320 fuel_kg=6200 eta=09:14
⟬date#1⟭ 07:10:02 acars-gw INFO POS flight=AZ318 tail=N412AZ fl=360 fuel_kg=6020 eta=07:58
⟬date#1⟭ 07:10:03 acars-gw INFO POS flight=AZ502 tail=N188AZ fl=340 fuel_kg=4720 eta=08:10
⟬date#1⟭ 07:15:18 acars-gw INFO uplink flight=AZ318 message="gate B11 at ⟬trap:word_name|Austin⟭, ⟬trap:indicator_non_pii|marshaller=ramp-crew⟭"
⟬date#1⟭ 07:20:02 acars-gw INFO POS flight=AZ711 tail=N204AZ fl=340 fuel_kg=5880 eta=09:13
⟬date#1⟭ 07:25:02 acars-gw INFO route amend flight=AZ502 waypoint=⟬trap:word_name|FLORENCE⟭ reason=weather
⟬date#1⟭ 07:30:02 acars-gw INFO POS flight=AZ318 tail=N412AZ fl=320 fuel_kg=5310 eta=07:57
⟬date#1⟭ 07:30:03 acars-gw INFO POS flight=AZ502 tail=N188AZ fl=360 fuel_kg=4120 eta=08:09
⟬date#1⟭ 07:35:44 acars-gw INFO maintenance flight=AZ318 tail=N412AZ code=2110 note="pack 1 fault latched"
⟬date#1⟭ 07:35:45 acars-gw INFO maintenance routed to ⟬hostname#1⟭, ⟬trap:indicator_non_pii|assignee=mx-control⟭
⟬date#1⟭ 07:40:02 acars-gw INFO POS flight=AZ711 tail=N204AZ fl=360 fuel_kg=5310 eta=09:11
⟬date#1⟭ 07:45:02 acars-gw INFO descent flight=AZ318 tail=N412AZ fl=240
⟬date#1⟭ 07:50:02 acars-gw INFO POS flight=AZ502 tail=N188AZ fl=360 fuel_kg=3640 eta=08:08
⟬date#1⟭ 07:55:12 acars-gw INFO OOOI flight=AZ318 tail=N412AZ event=ON station=AUS
⟬date#1⟭ 07:58:44 acars-gw INFO OOOI flight=AZ318 tail=N412AZ event=IN station=AUS
⟬date#1⟭ 08:00:00 acars-gw INFO stats messages_1h=508 retries=1 ⟬trap:indicator_non_pii|operator=dispatch-desk-2⟭
⟬date#1⟭ 08:00:02 acars-gw INFO POS flight=AZ711 tail=N204AZ fl=360 fuel_kg=4720 eta=09:10
⟬date#1⟭ 08:04:18 acars-gw INFO OOOI flight=AZ502 tail=N188AZ event=ON station=SAV
⟬date#1⟭ 08:07:30 acars-gw INFO OOOI flight=AZ502 tail=N188AZ event=IN station=SAV
⟬date#1⟭ 08:10:02 acars-gw INFO WX request station=⟬trap:word_name|Charlotte⟭ source=dispatch
⟬date#1⟭ 08:10:04 acars-gw INFO WX reply station=⟬trap:word_name|Charlotte⟭ metar=ok
⟬date#1⟭ 08:12:40 acars-gw INFO OOOI flight=AZ120 tail=N412AZ event=OUT station=AUS
⟬date#1⟭ 08:20:02 acars-gw INFO POS flight=AZ711 tail=N204AZ fl=360 fuel_kg=4310 eta=09:09
⟬date#1⟭ 08:25:18 acars-gw INFO OOOI flight=AZ120 tail=N412AZ event=OFF station=AUS
⟬date#1⟭ 08:30:02 acars-gw INFO POS flight=AZ120 tail=N412AZ fl=220 fuel_kg=8040 eta=10:41
⟬date#1⟭ 08:35:02 acars-gw DEBUG heartbeat dsp=ARINC rtt_ms=412
⟬date#1⟭ 08:40:02 acars-gw INFO POS flight=AZ711 tail=N204AZ fl=320 fuel_kg=3920 eta=09:08
⟬date#1⟭ 08:40:03 acars-gw INFO POS flight=AZ120 tail=N412AZ fl=340 fuel_kg=7520 eta=10:40
⟬date#1⟭ 08:45:12 acars-gw INFO OOOI flight=AZ614 tail=N188AZ event=OUT station=SAV
⟬date#1⟭ 08:50:02 acars-gw INFO descent flight=AZ711 tail=N204AZ fl=240
⟬date#1⟭ 08:55:30 acars-gw INFO OOOI flight=AZ614 tail=N188AZ event=OFF station=SAV
⟬date#1⟭ 09:00:00 acars-gw INFO stats messages_1h=466 retries=0 ⟬trap:indicator_non_pii|operator=dispatch-desk-3⟭
⟬date#1⟭ 09:00:02 acars-gw INFO POS flight=AZ120 tail=N412AZ fl=360 fuel_kg=6880 eta=10:38
⟬date#1⟭ 09:00:03 acars-gw INFO POS flight=AZ614 tail=N188AZ fl=240 fuel_kg=6120 eta=10:02
⟬date#1⟭ 09:06:44 acars-gw INFO OOOI flight=AZ711 tail=N204AZ event=ON station=MSN
⟬date#1⟭ 09:09:51 acars-gw INFO OOOI flight=AZ711 tail=N204AZ event=IN station=MSN
⟬date#1⟭ 09:10:02 acars-gw INFO archive segment ⟬uuid#1⟭ written, checksum ⟬hash#1⟭
⟬date#1⟭ 09:15:00 acars-gw INFO uplink flight=AZ614 message="connection held for ⟬trap:word_name|Madison⟭ bank, no action"
⟬date#1⟭ 09:20:02 acars-gw INFO POS flight=AZ120 tail=N412AZ fl=360 fuel_kg=6240 eta=10:37
⟬date#1⟭ 09:20:03 acars-gw INFO POS flight=AZ614 tail=N188AZ fl=340 fuel_kg=5640 eta=10:01
⟬date#1⟭ 09:30:00 acars-gw INFO feed pushed to ⟬url#1⟭ for the public flight tracker
⟬date#1⟭ 09:40:02 acars-gw INFO POS flight=AZ120 tail=N412AZ fl=360 fuel_kg=5610 eta=10:36
⟬date#1⟭ 09:40:03 acars-gw INFO POS flight=AZ614 tail=N188AZ fl=360 fuel_kg=5020 eta=09:59
⟬date#1⟭ 09:50:02 acars-gw INFO descent flight=AZ614 tail=N188AZ fl=240
⟬date#1⟭ 09:58:40 acars-gw INFO OOOI flight=AZ614 tail=N188AZ event=ON station=CLT
⟬date#1⟭ 10:00:00 acars-gw INFO stats messages_1h=441 retries=2 ⟬trap:indicator_non_pii|operator=dispatch-desk-3⟭
⟬date#1⟭ 10:01:12 acars-gw INFO OOOI flight=AZ614 tail=N188AZ event=IN station=CLT
⟬date#1⟭ 10:02:00 acars-gw INFO ticket ⟬ticket_id#1⟭ closed, late report traced to the datalink provider
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: en
fill_locale: en_US
domain: fintech
appearance: Python exception group, asyncio task failure, aiohttp error, request dump, local variables, secret under an innocuous key
scenario: asyncio exception group in a business account onboarding service, whose parallel checks fail together and print requests with SSN, license, passport, a vendor password and tokens
⟬text⟭
⟬date#1⟭ 11:02:44,118 ERROR onboarding.parallel: 3 of 4 checks failed for application ⟬uuid#1⟭
  + Exception Group Traceback (most recent call last):
  |   File "/srv/onboarding/app/orchestrator.py", line 88, in run_checks
  |     async with asyncio.TaskGroup() as group:
  |   File "/usr/local/lib/python3.11/asyncio/taskgroups.py", line 147, in __aexit__
  |     raise me from None
  | ExceptionGroup: unhandled errors in TaskGroup (3 sub-exceptions)
  +-+---------------- 1 ----------------
    | Traceback (most recent call last):
    |   File "/srv/onboarding/app/checks/identity.py", line 41, in check_ssn
    |     response = await session.post(url, json=payload, headers=headers)
    |   File "/opt/venv/lib/python3.11/site-packages/aiohttp/client.py", line 605, in _request
    |     await resp.start(conn)
    |   File "/opt/venv/lib/python3.11/site-packages/aiohttp/client_reqrep.py", line 966, in start
    |     message, payload = await protocol.read()
    | aiohttp.client_exceptions.ServerDisconnectedError: Server disconnected
    |
    | Locals at check_ssn:
    |   payload = {"name": "⟬person_name#2⟭", "ssn": "⟬us_ssn#2⟭", "dob": "⟬birth_date#2⟭"}
    |   headers = {"Authorization": "Bearer ⟬jwt#1⟭", "X-Client-Ref": "⟬opaque_token#1⟭"}
    +---------------- 2 ----------------
    | Traceback (most recent call last):
    |   File "/srv/onboarding/app/checks/document.py", line 63, in check_document
    |     result = await vendor.verify(document)
    |   File "/srv/onboarding/app/vendors/docscan.py", line 118, in verify
    |     raise VendorError(f"unreadable document {document!r}")
    | app.vendors.docscan.VendorError: unreadable document Document(kind="passport", number="⟬us_passport#2⟭", holder="⟬person_name#2⟭")
    |
    | Locals at verify:
    |   self.base_url = "⟬url#1⟭"
    |   self.login = "⟬trap:indicator_non_pii|onboarding-svc⟭"
    |   self.secret = "⟬password#1⟭"
    |   attempts = 3
    +---------------- 3 ----------------
    | Traceback (most recent call last):
    |   File "/srv/onboarding/app/checks/owners.py", line 77, in check_beneficial_owners
    |     await asyncio.gather(*(self._owner(owner) for owner in owners))
    |   File "/srv/onboarding/app/checks/owners.py", line 92, in _owner
    |     raise OwnerMismatch(owner)
    | app.checks.owners.OwnerMismatch: Owner(name="⟬person_name#3⟭", license="⟬us_driver_license#3⟭", share=0.4)
    |
    | The above exception was the direct cause of the following exception:
    |
    | Traceback (most recent call last):
    |   File "/srv/onboarding/app/checks/owners.py", line 81, in check_beneficial_owners
    |     raise ComplianceHold(application_id) from error
    | app.errors.ComplianceHold: application ⟬uuid#1⟭ on hold
    |
    | Locals at check_beneficial_owners:
    |   owners = [Owner(name="⟬person_name#3⟭", license="⟬us_driver_license#3⟭", share=0.4), Owner(name="⟬person_name#4⟭", license="⟬us_driver_license#4⟭", share=0.6)]
    |   business = Business(name="⟬company#3⟭", address="⟬postal_address#3⟭")
    +------------------------------------
⟬date#1⟭ 11:02:44,204 INFO  onboarding.parallel: identity vendor ref ⟬uuid#2⟭ retried once
⟬date#1⟭ 11:02:44,206 INFO  onboarding.parallel: application ⟬uuid#1⟭ moved to review, owner=⟬trap:indicator_non_pii|bsa-queue⟭
⟬date#1⟭ 11:02:44,410 INFO  onboarding.mail: applicant notified at ⟬email#2⟭
⟬date#1⟭ 11:02:44,512 WARN  onboarding.secrets: vendor secret value appeared in a traceback, rotate per ⟬ticket_id#1⟭
⟬date#1⟭ 11:02:45,118 INFO  onboarding.metrics: checks_failed=3 duration_ms=1412 version=⟬version#1⟭
⟬date#1⟭ 11:03:00,002 INFO  onboarding.metrics: open_reviews=41 version=⟬version#1⟭
⟬date#1⟭ 11:03:30,002 INFO  onboarding.metrics: open_reviews=42 version=⟬version#1⟭
⟬date#1⟭ 11:04:00,002 INFO  onboarding.metrics: open_reviews=42 version=⟬version#1⟭
⟬date#1⟭ 11:04:30,002 INFO  onboarding.metrics: open_reviews=41 version=⟬version#1⟭
⟬end⟭

⟬template⟭
family: logs
format: test output
language: en
fill_locale: en_US
domain: SaaS
appearance: Vitest summary, code identifier
scenario: Vitest summary of a date picker package, all green and with no personal value
⟬text⟭
 ✓ src/picker.test.ts (24)
 ✓ src/range.test.ts (18)
 ✓ src/⟬trap:code_identifier|zeller_congruence⟭.test.ts (6)

 Test Files  3 passed (3)
      Tests  48 passed (48)
⟬end⟭

⟬template⟭
family: logs
format: access log
language: en
fill_locale: en_US
domain: healthcare
appearance: combined log format, custom context field, valet plate, SSN in a context field, JWT in a query string, authenticated user field
scenario: nginx access of a hospital campus portal, covering patient check-in with SSN, valet plates, visitor passes and staff links with tokens
⟬text⟭
⟬ip_address#1⟭ - - [⟬date#1⟭ 07:02:11 -0500] "GET /checkin/start HTTP/1.1" 200 4120 "-" "Mozilla/5.0 (iPad; CPU OS 17_2 like Mac OS X) Safari/604.1" trace="kiosk=lobby-1"
⟬ip_address#1⟭ - - [⟬date#1⟭ 07:02:40 -0500] "POST /checkin/identify HTTP/1.1" 200 412 "⟬url#1⟭" "Mozilla/5.0 (iPad; CPU OS 17_2 like Mac OS X) Safari/604.1" trace="dob=⟬birth_date#2⟭ ssn=⟬us_ssn#2⟭"
⟬ip_address#1⟭ - - [⟬date#1⟭ 07:02:41 -0500] "GET /checkin/appointments?token=⟬jwt#1⟭ HTTP/1.1" 200 1204 "⟬url#1⟭" "Mozilla/5.0 (iPad; CPU OS 17_2 like Mac OS X) Safari/604.1" trace="-"
⟬ip_address#1⟭ - - [⟬date#1⟭ 07:03:05 -0500] "POST /checkin/confirm HTTP/1.1" 200 96 "⟬url#1⟭" "Mozilla/5.0 (iPad; CPU OS 17_2 like Mac OS X) Safari/604.1" trace="patient=⟬person_name#2⟭ appt=⟬uuid#1⟭"
⟬ip_address#2⟭ - - [⟬date#1⟭ 07:03:30 -0500] "GET /healthz HTTP/1.1" 200 2 "-" "kube-probe/1.29" trace="-"
⟬ip_address#3⟭ - ⟬username#1⟭ [⟬date#1⟭ 07:04:02 -0500] "POST /valet/in HTTP/1.1" 201 88 "-" "ValetTablet/⟬version#1⟭" trace="plate=⟬us_license_plate#3⟭ ticket=2204"
⟬ip_address#3⟭ - ⟬username#1⟭ [⟬date#1⟭ 07:04:40 -0500] "POST /valet/in HTTP/1.1" 201 88 "-" "ValetTablet/⟬version#1⟭" trace="plate=⟬us_license_plate#4⟭ ticket=2205"
⟬ip_address#4⟭ - - [⟬date#1⟭ 07:05:02 -0500] "GET /visitors/pass?t=⟬opaque_token#1⟭ HTTP/1.1" 200 2204 "-" "Mozilla/5.0 (iPhone; CPU iPhone OS 17_3 like Mac OS X)" trace="visitor=⟬person_name#5⟭ for=⟬person_name#6⟭"
⟬ip_address#5⟭ - ⟬person_name:handle#7⟭ [⟬date#1⟭ 07:05:30 -0500] "GET /staff/rounds?unit=⟬trap:word_name|Grace-unit⟭ HTTP/1.1" 200 8120 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Edge/121.0" trace="-"
⟬ip_address#5⟭ - ⟬person_name:handle#7⟭ [⟬date#1⟭ 07:06:02 -0500] "GET /staff/chart/⟬customer_id#8⟭ HTTP/1.1" 200 41200 "⟬url#2⟭" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Edge/121.0" trace="patient=⟬person_name#8⟭ ssn=⟬us_ssn#8⟭"
⟬ip_address#6⟭ - - [⟬date#1⟭ 07:06:30 -0500] "GET /paging/ack?code=⟬opaque_token#2⟭ HTTP/1.1" 200 44 "-" "PagerApp/⟬version#2⟭" trace="-"
⟬ip_address#6⟭ - - [⟬date#1⟭ 07:06:44 -0500] "GET /paging/ack?code=⟬opaque_token#6⟭ HTTP/1.1" 410 44 "-" "PagerApp/⟬version#2⟭" trace="-"
⟬ip_address#2⟭ - - [⟬date#1⟭ 07:07:00 -0500] "GET /healthz HTTP/1.1" 200 2 "-" "kube-probe/1.29" trace="-"
⟬ip_address#7⟭ - - [⟬date#1⟭ 07:07:22 -0500] "POST /billing/payment-plan HTTP/1.1" 201 140 "-" "Mozilla/5.0 (Linux; Android 14) Chrome/120.0" trace="guarantor=⟬person_name#9⟭ addr=⟬postal_address#9⟭"
⟬ip_address#7⟭ - - [⟬date#1⟭ 07:07:50 -0500] "POST /billing/payment-plan/card HTTP/1.1" 200 96 "⟬url#3⟭" "Mozilla/5.0 (Linux; Android 14) Chrome/120.0" trace="pan=⟬payment_card#9⟭"
⟬ip_address#3⟭ - ⟬username#1⟭ [⟬date#1⟭ 07:08:11 -0500] "POST /valet/in HTTP/1.1" 201 88 "-" "ValetTablet/⟬version#1⟭" trace="plate=⟬us_license_plate#10⟭ ticket=2206 note=dr ⟬person_name#10⟭ reserved"
⟬ip_address#8⟭ - - [⟬date#1⟭ 07:08:40 -0500] "GET /maps/garage-b HTTP/1.1" 200 12040 "-" "Mozilla/5.0 (compatible; Googlebot/2.1)" trace="-"
⟬ip_address#9⟭ - ⟬person_name:handle#11⟭ [⟬date#1⟭ 07:09:02 -0500] "POST /staff/orders HTTP/1.1" 201 118 "⟬url#4⟭" "Mozilla/5.0 (Macintosh; Intel Mac OS X 14_2) Chrome/121.0" trace="patient=⟬person_name#12⟭ test=⟬trap:eponym|Coombs⟭"
⟬ip_address#9⟭ - ⟬person_name:handle#11⟭ [⟬date#1⟭ 07:09:31 -0500] "GET /staff/results?auth=⟬jwt#2⟭ HTTP/1.1" 200 8120 "⟬url#4⟭" "Mozilla/5.0 (Macintosh; Intel Mac OS X 14_2) Chrome/121.0" trace="-"
⟬ip_address#10⟭ - - [⟬date#1⟭ 07:10:02 -0500] "POST /portal/login HTTP/1.1" 200 412 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/121.0" trace="email=⟬email#13⟭"
⟬ip_address#10⟭ - - [⟬date#1⟭ 07:10:03 -0500] "GET /portal/home?session=⟬jwt#3⟭ HTTP/1.1" 200 6120 "⟬url#5⟭" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/121.0" trace="-"
⟬ip_address#2⟭ - - [⟬date#1⟭ 07:10:30 -0500] "GET /healthz HTTP/1.1" 200 2 "-" "kube-probe/1.29" trace="-"
⟬ip_address#11⟭ - - [⟬date#1⟭ 07:11:02 -0500] "POST /checkin/identify HTTP/1.1" 404 96 "⟬url#6⟭" "Mozilla/5.0 (iPad; CPU OS 17_2 like Mac OS X) Safari/604.1" trace="dob=⟬birth_date#14⟭ ssn=⟬us_ssn#14⟭"
⟬ip_address#11⟭ - - [⟬date#1⟭ 07:11:30 -0500] "POST /checkin/identify HTTP/1.1" 200 412 "⟬url#6⟭" "Mozilla/5.0 (iPad; CPU OS 17_2 like Mac OS X) Safari/604.1" trace="dob=⟬birth_date#15⟭ ssn=⟬us_ssn#15⟭"
⟬ip_address#11⟭ - - [⟬date#1⟭ 07:11:58 -0500] "POST /checkin/update-insurance HTTP/1.1" 200 120 "⟬url#6⟭" "Mozilla/5.0 (iPad; CPU OS 17_2 like Mac OS X) Safari/604.1" trace="subscriber=⟬person_name#15⟭ member=⟬customer_id#15⟭"
⟬ip_address#12⟭ - ⟬username#2⟭ [⟬date#1⟭ 07:12:30 -0500] "POST /interfaces/adt HTTP/1.1" 202 18 "-" "IntegrationEngine/⟬version#3⟭" trace="batch=⟬uuid#3⟭"
⟬ip_address#13⟭ - - [⟬date#1⟭ 07:13:02 -0500] "GET /find-a-doctor?specialty=cardiology&name=⟬person_name:handle#16⟭ HTTP/1.1" 200 3120 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 13_6) Safari/605.1.15" trace="-"
⟬ip_address#3⟭ - ⟬username#1⟭ [⟬date#1⟭ 07:13:40 -0500] "POST /valet/out HTTP/1.1" 200 66 "-" "ValetTablet/⟬version#1⟭" trace="plate=⟬us_license_plate#3⟭ fee=12.00"
⟬ip_address#2⟭ - - [⟬date#1⟭ 07:14:00 -0500] "GET /healthz HTTP/1.1" 200 2 "-" "kube-probe/1.29" trace="-"
⟬ip_address#14⟭ - - [⟬date#1⟭ 07:14:30 -0500] "POST /gift-shop/order HTTP/1.1" 201 140 "-" "Mozilla/5.0 (iPhone; CPU iPhone OS 16_7 like Mac OS X)" trace="deliver_to=⟬person_name#17⟭ room=412 from=⟬person_name#18⟭"
⟬ip_address#14⟭ - - [⟬date#1⟭ 07:14:58 -0500] "POST /gift-shop/pay HTTP/1.1" 200 96 "⟬url#7⟭" "Mozilla/5.0 (iPhone; CPU iPhone OS 16_7 like Mac OS X)" trace="⟬payment_card#18⟭ ⟬card_security_code#18⟭"
⟬ip_address#15⟭ - ⟬person_name:handle#19⟭ [⟬date#1⟭ 07:15:20 -0500] "GET /staff/schedule?unit=⟬trap:word_name|Ivy-pavilion⟭ HTTP/1.1" 200 4410 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/121.0" trace="-"
⟬ip_address#16⟭ - - [⟬date#1⟭ 07:15:44 -0500] "GET /wp-login.php HTTP/1.1" 404 162 "-" "python-requests/2.28.1" trace="-"
⟬ip_address#16⟭ - - [⟬date#1⟭ 07:15:45 -0500] "GET /.env HTTP/1.1" 404 162 "-" "python-requests/2.28.1" trace="-"
⟬ip_address#2⟭ - - [⟬date#1⟭ 07:16:00 -0500] "GET /healthz HTTP/1.1" 200 2 "-" "kube-probe/1.29" trace="-"
⟬ip_address#17⟭ - - [⟬date#1⟭ 07:16:30 -0500] "POST /medical-records/request HTTP/1.1" 201 88 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/120.0" trace="requester=⟬person_name#20⟭ ssn=⟬us_ssn#20⟭ mail_to=⟬postal_address#20⟭"
⟬ip_address#17⟭ - - [⟬date#1⟭ 07:16:58 -0500] "GET /medical-records/status?ref=⟬opaque_token#3⟭ HTTP/1.1" 200 240 "⟬url#8⟭" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/120.0" trace="-"
⟬ip_address#17⟭ - - [⟬date#1⟭ 07:17:12 -0500] "GET /medical-records/status?ref=⟬order_number#1⟭ HTTP/1.1" 200 240 "⟬url#8⟭" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/120.0" trace="-"
⟬ip_address#18⟭ - ⟬username#3⟭ [⟬date#1⟭ 07:17:40 -0500] "POST /security/badge HTTP/1.1" 200 44 "-" "BadgeReader/⟬version#4⟭" trace="door=or-4 badge=⟬customer_id#21⟭"
⟬ip_address#18⟭ - ⟬username#3⟭ [⟬date#1⟭ 07:18:02 -0500] "POST /security/badge HTTP/1.1" 403 44 "-" "BadgeReader/⟬version#4⟭" trace="door=pharmacy badge=⟬customer_id#22⟭"
⟬ip_address#2⟭ - - [⟬date#1⟭ 07:18:30 -0500] "GET /healthz HTTP/1.1" 200 2 "-" "kube-probe/1.29" trace="-"
⟬ip_address#19⟭ - - [⟬date#1⟭ 07:19:02 -0500] "GET /classes/⟬trap:eponym|lamaze-birthing⟭ HTTP/1.1" 200 5120 "-" "Mozilla/5.0 (Linux; Android 13) Chrome/119.0" trace="-"
⟬ip_address#20⟭ - - [⟬date#1⟭ 07:19:30 -0500] "GET /about/foundation/⟬trap:company_name|Mayo-partnership⟭ HTTP/1.1" 200 7120 "-" "Mozilla/5.0 (compatible; bingbot/2.0)" trace="-"
⟬ip_address#21⟭ - - [⟬date#1⟭ 07:20:02 -0500] "POST /checkin/identify HTTP/1.1" 200 412 "⟬url#9⟭" "Mozilla/5.0 (iPad; CPU OS 17_2 like Mac OS X) Safari/604.1" trace="dob=⟬birth_date#23⟭ ssn=⟬us_ssn#23⟭"
⟬ip_address#21⟭ - - [⟬date#1⟭ 07:20:30 -0500] "GET /checkin/appointments?token=⟬jwt#4⟭ HTTP/1.1" 200 1204 "⟬url#9⟭" "Mozilla/5.0 (iPad; CPU OS 17_2 like Mac OS X) Safari/604.1" trace="-"
⟬ip_address#3⟭ - ⟬username#1⟭ [⟬date#1⟭ 07:21:02 -0500] "POST /valet/in HTTP/1.1" 201 88 "-" "ValetTablet/⟬version#1⟭" trace="plate=⟬us_license_plate#24⟭ ticket=2207"
⟬ip_address#2⟭ - - [⟬date#1⟭ 07:21:30 -0500] "GET /healthz HTTP/1.1" 200 2 "-" "kube-probe/1.29" trace="-"
⟬ip_address#22⟭ - - [⟬date#1⟭ 07:22:02 -0500] "POST /interpreter/request HTTP/1.1" 201 66 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Edge/121.0" trace="patient=⟬person_name#25⟭ language=spanish"
⟬ip_address#23⟭ - - [⟬date#1⟭ 07:22:30 -0500] "GET /parking/rates HTTP/1.1" 200 1820 "-" "Mozilla/5.0 (iPhone; CPU iPhone OS 17_2 like Mac OS X)" trace="-"
⟬ip_address#24⟭ - ⟬person_name:handle#26⟭ [⟬date#1⟭ 07:23:02 -0500] "POST /staff/handoff HTTP/1.1" 201 96 "⟬url#10⟭" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/121.0" trace="from=⟬person_name#26⟭ to=⟬person_name#27⟭"
⟬ip_address#24⟭ - ⟬person_name:handle#26⟭ [⟬date#1⟭ 07:23:30 -0500] "POST /staff/handoff HTTP/1.1" 201 96 "⟬url#10⟭" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/121.0" trace="from=⟬person_name#26⟭ to=⟬trap:indicator_non_pii|night-pool⟭"
⟬ip_address#2⟭ - - [⟬date#1⟭ 07:24:00 -0500] "GET /healthz HTTP/1.1" 200 2 "-" "kube-probe/1.29" trace="-"
⟬ip_address#25⟭ - - [⟬date#1⟭ 07:24:30 -0500] "GET /sitemap.xml HTTP/1.1" 200 41208 "-" "Mozilla/5.0 (compatible; bingbot/2.0)" trace="-"
⟬ip_address#26⟭ - - [⟬date#1⟭ 07:25:02 -0500] "POST /portal/forgot HTTP/1.1" 202 74 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 14_1) Safari/605.1.15" trace="email=⟬email#28⟭"
⟬ip_address#26⟭ - - [⟬date#1⟭ 07:25:40 -0500] "GET /portal/reset?code=⟬opaque_token#4⟭ HTTP/1.1" 200 2040 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 14_1) Safari/605.1.15" trace="-"
⟬ip_address#26⟭ - - [⟬date#1⟭ 07:26:02 -0500] "POST /portal/reset HTTP/1.1" 302 0 "⟬url#11⟭" "Mozilla/5.0 (Macintosh; Intel Mac OS X 14_1) Safari/605.1.15" trace="pw=⟬password#1⟭"
⟬ip_address#3⟭ - ⟬username#1⟭ [⟬date#1⟭ 07:26:30 -0500] "POST /valet/out HTTP/1.1" 200 66 "-" "ValetTablet/⟬version#1⟭" trace="plate=⟬us_license_plate#4⟭ fee=12.00"
⟬ip_address#2⟭ - - [⟬date#1⟭ 07:27:00 -0500] "GET /healthz HTTP/1.1" 200 2 "-" "kube-probe/1.29" trace="-"
⟬ip_address#27⟭ - - [⟬date#1⟭ 07:27:30 -0500] "GET /news/flu-clinic HTTP/1.1" 200 5120 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Firefox/122.0" trace="-"
⟬ip_address#28⟭ - - [⟬date#1⟭ 07:28:02 -0500] "POST /checkin/identify HTTP/1.1" 200 412 "⟬url#12⟭" "Mozilla/5.0 (iPad; CPU OS 17_2 like Mac OS X) Safari/604.1" trace="dob=⟬birth_date#29⟭ ssn=⟬us_ssn#29⟭"
⟬ip_address#28⟭ - - [⟬date#1⟭ 07:28:30 -0500] "POST /checkin/confirm HTTP/1.1" 200 96 "⟬url#12⟭" "Mozilla/5.0 (iPad; CPU OS 17_2 like Mac OS X) Safari/604.1" trace="patient=⟬person_name#29⟭ appt=⟬uuid#4⟭"
⟬ip_address#3⟭ - ⟬username#1⟭ [⟬date#1⟭ 07:29:02 -0500] "POST /valet/in HTTP/1.1" 201 88 "-" "ValetTablet/⟬version#1⟭" trace="plate=⟬us_license_plate#30⟭ ticket=2208"
⟬ip_address#2⟭ - - [⟬date#1⟭ 07:29:30 -0500] "GET /healthz HTTP/1.1" 200 2 "-" "kube-probe/1.29" trace="-"
⟬ip_address#29⟭ - ⟬person_name:handle#7⟭ [⟬date#1⟭ 07:30:02 -0500] "GET /staff/rounds?unit=⟬trap:word_name|Rose-ward⟭ HTTP/1.1" 200 8120 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Edge/121.0" trace="-"
⟬ip_address#30⟭ - - [⟬date#1⟭ 07:30:30 -0500] "GET /visitors/pass?t=⟬opaque_token#5⟭ HTTP/1.1" 200 2204 "-" "Mozilla/5.0 (Linux; Android 14) Chrome/120.0" trace="visitor=⟬person_name#31⟭ for=⟬person_name#32⟭"
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: en
fill_locale: en_US
domain: retail
appearance: kubectl describe output, environment block, smoke test output, secret under an innocuous key
scenario: troubleshooting step of a furniture store's deployment, where kubectl describe prints plain environment variables with a password and token and a smoke test charges a demo card
⟬text⟭
$ kubectl describe pod checkout-7c9d -n storefront
Name:             checkout-7c9d
Namespace:        storefront
Node:             ⟬hostname#1⟭
Status:           Running
Containers:
  checkout:
    Image:          ⟬hostname#2⟭/storefront/checkout:⟬version#1⟭
    Environment:
      DB_HOST:        ⟬hostname#3⟭
      DB_USER:        ⟬trap:indicator_non_pii|checkout_app⟭
      DB_PASSWORD:    ⟬password#1⟭
      PAYMENT_REF:    ⟬opaque_token#1⟭
      ORDER_PREFIX:   ⟬order_number#1⟭
      OWNER_TEAM:     ⟬trap:indicator_non_pii|commerce-core⟭
Events:
  Type     Reason     Age   From     Message
  Warning  BackOff    2m    kubelet  Back-off restarting failed container
$ ./ci/smoke_checkout.sh
[smoke] buyer "⟬person_name#2⟭" ships to "⟬postal_address#2⟭"
[smoke] card ⟬payment_card#2⟭ cvv ⟬card_security_code#2⟭ -> 200
[smoke] order ⟬uuid#1⟭ placed
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: en
fill_locale: en_US
domain: government
appearance: key=value, audit trail, DMV counter, plate and license
scenario: motor vehicle counter audit, where a clerk reprints a registration and corrects a license record
⟬text⟭
⟬date#1⟭ 11:02:11 dmv-audit clerk=⟬person_name:handle#1⟭ station=7 action=REPRINT_REG plate="⟬us_license_plate#2⟭" owner="⟬person_name#2⟭"
⟬date#1⟭ 11:04:30 dmv-audit clerk=⟬person_name:handle#1⟭ station=7 action=DL_CORRECT dl="⟬us_driver_license#3⟭" field=address new="⟬postal_address#3⟭"
⟬date#1⟭ 11:04:31 dmv-audit clerk=⟬trap:indicator_non_pii|sync-agent⟭ station=0 action=REPLICATE dest=⟬hostname#1⟭
⟬end⟭
