⟬template⟭
family: logs
format: application log
language: en
fill_locale: en_US
domain: retail
appearance: Rails logger line, parameters hash, filtered parameter, gift note, license check
scenario: Rails log of a wine delivery shop, where parameter filtering misses renamed card fields and the age check prints the license
⟬text⟭
I, [⟬date#1⟭ 11:02:44 #4121]  INFO -- : [⟬uuid#1⟭] Started POST "/orders" for ⟬ip_address#1⟭
I, [⟬date#1⟭ 11:02:44 #4121]  INFO -- : [⟬uuid#1⟭] Processing by OrdersController#create as HTML
I, [⟬date#1⟭ 11:02:44 #4121]  INFO -- : [⟬uuid#1⟭]   Parameters: {"authenticity_token"=>"⟬opaque_token#1⟭", "order"=>{"name"=>"⟬person_name#2⟭", "ship_to"=>"⟬postal_address#2⟭", "gift_note"=>"Happy birthday ⟬person_name:given#3⟭, love from all of us!", "payment"=>{"number"=>"⟬trap:indicator_non_pii|[FILTERED]⟭", "cc"=>"⟬payment_card#2⟭", "cc_check"=>"⟬card_security_code#2⟭"}}}
D, [⟬date#1⟭ 11:02:44 #4121] DEBUG -- : [⟬uuid#1⟭]   Cart Load (0.4ms)  SELECT "carts".* FROM "carts" WHERE "carts"."id" = $1 LIMIT $2  [["id", 88120], ["LIMIT", 1]]
I, [⟬date#1⟭ 11:02:45 #4121]  INFO -- : [⟬uuid#1⟭] Age check vendor: license "⟬us_driver_license#2⟭" over 21
I, [⟬date#1⟭ 11:02:45 #4121]  INFO -- : [⟬uuid#1⟭] Payment captured, order ⟬order_number#1⟭
I, [⟬date#1⟭ 11:02:45 #4121]  INFO -- : [⟬uuid#1⟭] Redirected to ⟬url#1⟭
I, [⟬date#1⟭ 11:02:45 #4121]  INFO -- : [⟬uuid#1⟭] Completed 302 Found in 918ms (ActiveRecord: 41.2ms)
I, [⟬date#1⟭ 11:03:20 #4122]  INFO -- : [⟬uuid#2⟭] Started GET "/wines/⟬trap:word_name|margaux-reserve⟭" for ⟬ip_address#2⟭
I, [⟬date#1⟭ 11:03:20 #4122]  INFO -- : [⟬uuid#2⟭] Completed 200 OK in 38ms (Views: 31.1ms | ActiveRecord: 2.0ms)
I, [⟬date#1⟭ 11:04:02 #4121]  INFO -- : [⟬uuid#3⟭] Started POST "/orders" for ⟬ip_address#3⟭
I, [⟬date#1⟭ 11:04:02 #4121]  INFO -- : [⟬uuid#3⟭]   Parameters: {"authenticity_token"=>"⟬opaque_token#2⟭", "order"=>{"name"=>"⟬person_name#4⟭", "ship_to"=>"⟬postal_address#4⟭", "gift_note"=>"", "payment"=>{"number"=>"⟬trap:indicator_non_pii|[FILTERED]⟭", "cc"=>"⟬payment_card#4⟭", "cc_check"=>"⟬card_security_code#4⟭"}}}
W, [⟬date#1⟭ 11:04:03 #4121]  WARN -- : [⟬uuid#3⟭] Age check vendor: license "⟬us_driver_license#4⟭" under 21, order refused
I, [⟬date#1⟭ 11:04:03 #4121]  INFO -- : [⟬uuid#3⟭] Completed 422 Unprocessable Entity in 604ms (ActiveRecord: 12.8ms)
I, [⟬date#1⟭ 11:04:30 #4123]  INFO -- : [⟬uuid#4⟭] Started GET "/up" for ⟬ip_address#4⟭
I, [⟬date#1⟭ 11:04:30 #4123]  INFO -- : [⟬uuid#4⟭] Completed 200 OK in 1ms
I, [⟬date#1⟭ 11:05:12 #4122]  INFO -- : [⟬uuid#5⟭] Sidekiq enqueued ShipmentNotifierJob, ⟬trap:indicator_non_pii|customer=none⟭ ref=⟬order_number#1⟭
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: en
fill_locale: en_US
domain: government
appearance: Java stack trace, exception message, field names without values
scenario: Java trace of a county land parcel service failing on an invalid geometry, which names owner and taxpayer fields but holds no value for them
⟬text⟭
⟬date#1⟭ 13:40:09,118 ERROR [parcel-sync-3] c.c.parcels.SyncJob - parcel sync aborted at feature ⟬uuid#1⟭
java.lang.IllegalArgumentException: Invalid number of points in LineString (found 1 - must be 0 or >= 2)
	at org.locationtech.jts.geom.LineString.init(LineString.java:113)
	at org.locationtech.jts.geom.LineString.<init>(LineString.java:68)
	at org.locationtech.jts.geom.GeometryFactory.createLineString(GeometryFactory.java:448)
	at gov.county.parcels.mapping.ParcelMapper.toGeometry(ParcelMapper.java:91)
	at gov.county.parcels.mapping.ParcelMapper.map(ParcelMapper.java:58)
	at gov.county.parcels.SyncJob.process(SyncJob.java:142)
	at gov.county.parcels.SyncJob.run(SyncJob.java:87)
	at java.base/java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:539)
	at java.base/java.util.concurrent.FutureTask.run(FutureTask.java:264)
	at java.base/java.lang.Thread.run(Thread.java:840)
Mapped attributes before failure:
  parcel_class=R1
  zoning=⟬trap:word_name|Madison-North⟭
  ⟬trap:indicator_non_pii|owner_name=withheld⟭
  ⟬trap:indicator_non_pii|taxpayer_id=null⟭
  ⟬trap:indicator_non_pii|mailing_address=see assessor⟭
  source=⟬url#1⟭
⟬end⟭

⟬template⟭
family: logs
format: test output
language: en
fill_locale: en_US
domain: travel
appearance: PHPUnit output, array diff, author name in a banner, JWT in a fixture
scenario: PHPUnit failure of a frequent flyer profile sync, whose banner names the tool's author and whose array diff prints the member's passport and bearer token
⟬text⟭
PHPUnit 10.5.9 by ⟬person_name#3⟭ and contributors.

Runtime:       PHP 8.2.15
Configuration: /srv/loyalty/phpunit.xml

....F.....                                                        10 / 10 (100%)

Time: 00:00.412, Memory: 14.00 MB

There was 1 failure:

1) Tests\Loyalty\ProfileSyncTest::testPassportNumberIsCopied
Failed asserting that two arrays are equal.
--- Expected
+++ Actual
@@ @@
 Array (
     'tier' => 'gold'
-    'passport' => '⟬us_passport#1⟭'
+    'passport' => null
     'name' => "⟬person_name#1⟭"
     'bearer' => '⟬jwt#1⟭'
     'home_airport' => 'CLT'
 )

/srv/loyalty/tests/ProfileSyncTest.php:61

FAILURES!
Tests: 10, Assertions: 27, Failures: 1.
⟬end⟭

⟬template⟭
family: logs
format: access log
language: en
fill_locale: en_US
domain: fintech
appearance: Tomcat access valve, session cookie field, password in a query string, custom context field, authenticated user field
scenario: Tomcat access of a corporate banking portal, with a legacy SSO query string holding the password, session cookies logged by the valve and a filter copying wire beneficiaries
⟬text⟭
⟬ip_address#1⟭ - - [⟬date#1⟭ 09:01:12 -0500] "GET /corp/login HTTP/1.1" 200 4120 18 "-" dbg="-"
⟬ip_address#1⟭ - - [⟬date#1⟭ 09:01:40 -0500] "GET /corp/sso?j_username=⟬person_name:handle#2⟭&j_password=⟬url_password#1⟭ HTTP/1.1" 302 0 214 "-" dbg="-"
⟬ip_address#1⟭ - ⟬person_name:handle#2⟭ [⟬date#1⟭ 09:01:41 -0500] "GET /corp/home HTTP/1.1" 200 22040 61 "JSESSIONID=⟬opaque_token#1⟭" dbg="-"
⟬ip_address#1⟭ - ⟬person_name:handle#2⟭ [⟬date#1⟭ 09:02:03 -0500] "GET /corp/accounts HTTP/1.1" 200 18440 92 "JSESSIONID=⟬opaque_token#1⟭" dbg="-"
⟬ip_address#1⟭ - ⟬person_name:handle#2⟭ [⟬date#1⟭ 09:02:44 -0500] "POST /corp/wires HTTP/1.1" 200 812 340 "JSESSIONID=⟬opaque_token#1⟭" dbg="beneficiary=⟬person_name#3⟭ acct=⟬bank_account_number#3⟭ routing=⟬bic#3⟭ amt=48200.00"
⟬ip_address#1⟭ - ⟬person_name:handle#2⟭ [⟬date#1⟭ 09:02:59 -0500] "POST /corp/wires/approve HTTP/1.1" 403 96 41 "JSESSIONID=⟬opaque_token#1⟭" dbg="reason=needs second approver"
⟬ip_address#2⟭ - - [⟬date#1⟭ 09:03:11 -0500] "GET /health HTTP/1.1" 200 2 1 "-" dbg="-"
⟬ip_address#3⟭ - ⟬username#1⟭ [⟬date#1⟭ 09:03:20 -0500] "POST /batch/ach/upload HTTP/1.1" 202 44 1204 "-" dbg="file=⟬file_path#1⟭"
⟬ip_address#4⟭ - ⟬person_name:handle#4⟭ [⟬date#1⟭ 09:04:02 -0500] "POST /corp/wires/approve HTTP/1.1" 200 96 188 "JSESSIONID=⟬opaque_token#2⟭" dbg="ref=⟬uuid#1⟭"
⟬ip_address#4⟭ - ⟬person_name:handle#4⟭ [⟬date#1⟭ 09:04:31 -0500] "POST /corp/cards/replace HTTP/1.1" 200 120 96 "JSESSIONID=⟬opaque_token#2⟭" dbg="⟬payment_card#5⟭ holder=⟬person_name#5⟭"
⟬ip_address#5⟭ - - [⟬date#1⟭ 09:05:02 -0500] "GET /corp/statements/download?t=⟬jwt#1⟭ HTTP/1.1" 200 188204 212 "-" dbg="-"
⟬ip_address#6⟭ - - [⟬date#1⟭ 09:05:18 -0500] "POST /api/v1/token HTTP/1.1" 401 74 22 "-" dbg="client=⟬trap:indicator_non_pii|erp-connector⟭ secret=⟬password#1⟭"
⟬ip_address#6⟭ - - [⟬date#1⟭ 09:05:21 -0500] "POST /api/v1/token HTTP/1.1" 200 412 25 "-" dbg="client=⟬trap:indicator_non_pii|erp-connector⟭ secret=⟬password#2⟭"
⟬ip_address#7⟭ - ⟬username#2⟭ [⟬date#1⟭ 09:06:00 -0500] "GET /manager/status HTTP/1.1" 200 3120 8 "-" dbg="-"
⟬ip_address#1⟭ - ⟬person_name:handle#2⟭ [⟬date#1⟭ 09:06:47 -0500] "POST /corp/logout HTTP/1.1" 302 0 9 "JSESSIONID=⟬opaque_token#1⟭" dbg="-"
⟬ip_address#2⟭ - - [⟬date#1⟭ 09:07:11 -0500] "GET /health HTTP/1.1" 200 2 1 "-" dbg="-"
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: en
fill_locale: en_US
domain: SaaS
appearance: GitHub Actions matrix, pnpm output, scoped package names, lint summary
scenario: GitHub Actions matrix job of a design system repository, with scoped packages and lint results but no secret or person
⟬text⟭
Run pnpm install --frozen-lockfile
Scope: all 14 workspace projects
Lockfile is up to date, resolution step is skipped
Packages: +1182
Progress: resolved 1182, reused 1182, downloaded 0, added 1182, done
dependencies:
+ ⟬trap:email_lookalike|@radix-ui/react-dialog⟭ ⟬version#1⟭
+ ⟬trap:email_lookalike|@tanstack/react-query⟭ ⟬version#2⟭
devDependencies:
+ ⟬trap:email_lookalike|@types/node⟭ ⟬version#3⟭
+ ⟬trap:email_lookalike|@vitejs/plugin-react⟭ ⟬version#4⟭
Done in 6.2s
Run pnpm -r lint
packages/tokens lint: Done
packages/forms lint: /__w/ui/ui/packages/forms/src/PasswordField.tsx
packages/forms lint:   41:7  warning  ⟬trap:indicator_non_pii|defaultPassword⟭ is assigned a value but never used  no-unused-vars
packages/forms lint:   88:3  warning  ⟬trap:indicator_non_pii|autoComplete="new-password"⟭ expected on this input  jsx-a11y/autocomplete-valid
packages/forms lint: 2 problems (0 errors, 2 warnings)
packages/charts lint: Done
Run pnpm -r test --reporter=dot
packages/forms test: 214 passed (214)
packages/charts test: 88 passed (88)
Run pnpm build-storybook
info => Output directory: /__w/ui/ui/storybook-static
⟬trap:indicator_non_pii|USER=runner⟭ ⟬trap:indicator_non_pii|PWD=/__w/ui/ui⟭
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: en
fill_locale: en_US
domain: healthcare
appearance: key=value, audit trail, quoted value, revealed SSN
scenario: break-the-glass audit of a hospital EHR, where a night nurse opens a chart and reveals the SSN, then the case goes to the privacy office
⟬text⟭
⟬date#1⟭ 02:14:09 EHR-AUDIT BTG user="⟬person_name#1⟭" role=RN patient="⟬person_name#2⟭" mrn=⟬customer_id#2⟭ reason="ED trauma"
⟬date#1⟭ 02:14:33 EHR-AUDIT VIEW user="⟬person_name#1⟭" section=demographics revealed=⟬us_ssn#2⟭
⟬date#1⟭ 02:14:58 EHR-AUDIT VIEW user="⟬person_name#1⟭" section=medications
⟬date#1⟭ 02:31:02 EHR-AUDIT REVIEW queue=btg ⟬trap:indicator_non_pii|assigned=privacy-office⟭ ticket=⟬ticket_id#1⟭
⟬end⟭

⟬template⟭
family: logs
format: application log
language: en
fill_locale: en_US
domain: travel
appearance: Python logging line, passenger manifest, plate in a parking record, card on an onboard account
scenario: embarkation system of a cruise line in one morning, logging passports at the gangway, parking plates and the card opened for onboard spending
⟬text⟭
⟬date#1⟭ 10:12:04 INFO embark.terminal: gangway 2 online, ship MV ⟬trap:word_name|Victoria⟭ Star, voyage ⟬order_number#1⟭
⟬date#1⟭ 10:12:40 INFO embark.scan: boarding pass ⟬uuid#1⟭ cabin 8114
⟬date#1⟭ 10:12:41 DEBUG embark.scan: guest "⟬person_name#2⟭" passport ⟬us_passport#2⟭ dob ⟬birth_date#2⟭ nationality USA
⟬date#1⟭ 10:12:41 INFO embark.account: onboard account opened, card ⟬payment_card#2⟭ cvv ⟬card_security_code#2⟭
⟬date#1⟭ 10:12:42 INFO embark.parking: garage B, level 3, plate "⟬us_license_plate#2⟭"
⟬date#1⟭ 10:13:15 INFO embark.scan: boarding pass ⟬uuid#2⟭ cabin 8114
⟬date#1⟭ 10:13:16 DEBUG embark.scan: guest "⟬person_name#3⟭" passport ⟬us_passport#3⟭ dob ⟬birth_date#3⟭ nationality USA
⟬date#1⟭ 10:13:16 INFO embark.account: linked to account of cabin 8114
⟬date#1⟭ 10:14:02 WARN embark.scan: passport ⟬us_passport#4⟭ expires ⟬date#1⟭, supervisor called, operator=⟬trap:indicator_non_pii|gangway-2⟭
⟬date#1⟭ 10:14:30 INFO embark.scan: supervisor "⟬person_name#5⟭" cleared guest "⟬person_name#4⟭" for a closed-loop voyage
⟬date#1⟭ 10:15:11 INFO embark.parking: garage B, level 3, plate "⟬us_license_plate#4⟭", valet ticket 4471
⟬date#1⟭ 10:16:48 INFO embark.manifest: uploaded to ⟬url#1⟭ with 3 guests in this batch
⟬date#1⟭ 10:17:00 INFO embark.terminal: gangway 2 throughput 41 guests/hour
⟬date#1⟭ 10:18:21 ERROR embark.account: card declined for cabin 9022, guest "⟬person_name#6⟭" sent to purser desk
⟬date#1⟭ 10:18:22 DEBUG embark.account: declined value ⟬payment_card#6⟭ check ⟬card_security_code#6⟭
⟬date#1⟭ 10:19:05 INFO embark.terminal: sailing checklist updated, owner=⟬trap:indicator_non_pii|hotel-director-office⟭
⟬date#1⟭ 10:19:33 INFO embark.terminal: next gangway sync in 300s, version=⟬version#1⟭
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: en
fill_locale: en_US
domain: fintech
appearance: Jackson exception, embedded request body, code identifier, reference chain
scenario: Jackson failure at a mortgage lender, whose exception quotes the raw JSON body of the application with name, SSN, birth date and address
⟬text⟭
⟬trap:code_identifier|com.fasterxml.jackson.databind.exc.InvalidFormatException⟭: Cannot deserialize value of type `java.time.LocalDate` from String "⟬birth_date#1⟭": Failed to deserialize java.time.LocalDate
 at [Source: (String)"{"applicant":{"name":"⟬person_name#1⟭","ssn":"⟬us_ssn#1⟭","dob":"⟬birth_date#1⟭","address":"⟬postal_address#1⟭","income":84000}}"; line: 1, column: 96] (through reference chain: com.lendara.dto.LoanApplication["applicant"]->com.lendara.dto.Applicant["dob"])
	at ⟬trap:code_identifier|com.fasterxml.jackson.databind.exc.InvalidFormatException.from⟭(InvalidFormatException.java:67)
	at ⟬trap:code_identifier|com.fasterxml.jackson.databind.DeserializationContext.weirdStringException⟭(DeserializationContext.java:1958)
	at ⟬trap:code_identifier|com.fasterxml.jackson.databind.ObjectMapper.readValue⟭(ObjectMapper.java:3669)
	at com.lendara.intake.ApplicationParser.parse(ApplicationParser.java:37)
	at com.lendara.intake.IntakeController.submit(IntakeController.java:64)
	at org.springframework.web.method.support.InvocableHandlerMethod.doInvoke(InvocableHandlerMethod.java:205)
	at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:1089)
	at org.apache.tomcat.util.threads.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:659)
Caused by: java.time.format.DateTimeParseException: Text "⟬birth_date#1⟭" could not be parsed at index 0
	at java.base/java.time.format.DateTimeFormatter.parseResolved0(DateTimeFormatter.java:2106)
	at java.base/java.time.LocalDate.parse(LocalDate.java:430)
	at ⟬trap:code_identifier|com.fasterxml.jackson.datatype.jsr310.deser.LocalDateDeserializer.deserialize⟭(LocalDateDeserializer.java:113)
	... 41 common frames omitted
Request: POST /api/v2/applications from ⟬ip_address#1⟭ ref=⟬uuid#1⟭
Processor note: application ⟬uuid#1⟭ returned to the broker queue, owner=⟬trap:indicator_non_pii|intake-ops⟭
⟬end⟭

⟬template⟭
family: logs
format: test output
language: en
fill_locale: en_US
domain: SaaS
appearance: Vitest snapshot diff, secret under an innocuous key, nested object
scenario: Vitest snapshot mismatch in a team chat product, where the serialized session shows the token, refresh value and temporary password
⟬text⟭
 FAIL  src/auth/__tests__/session.test.ts > session > serializes the session
Error: Snapshot `session > serializes the session 1` mismatched

- Expected
+ Received

  {
    "email": "⟬email#1⟭",
    "name": "⟬person_name#1⟭",
-   "role": "member",
+   "role": "admin",
    "sso": {
      "kid": "⟬hash#1⟭",
      "token": "⟬jwt#1⟭",
    },
    "ref": "⟬opaque_token#1⟭",
    "tempPassword": "⟬password#1⟭",
    "workspace": "⟬customer_id#1⟭",
  }

 ❯ src/auth/__tests__/session.test.ts:27:23
     25|   it("serializes the session", () => {
     26|     const session = makeSession(fixtures.admin);
     27|     expect(session).toMatchSnapshot();
       |                       ^
     28|   });

 Test Files  1 failed | 41 passed (42)
      Tests  1 failed | 388 passed (389)
⟬end⟭

⟬template⟭
family: logs
format: access log
language: en
fill_locale: en_US
domain: healthcare
appearance: DICOM gateway line, query string, study identifiers
scenario: access lines of a radiology image viewer serving anonymized teaching studies to students, without any patient reference
⟬text⟭
⟬ip_address#1⟭ - - [⟬date#1⟭ 15:30:02 -0500] "GET /wado?studyUID=⟬uuid#1⟭&⟬trap:indicator_non_pii|patient_name=ANON⟭ HTTP/1.1" 200 8120442 "-" "Weasis/4.3" dbg="-"
⟬ip_address#1⟭ - - [⟬date#1⟭ 15:30:09 -0500] "GET /wado?studyUID=⟬uuid#2⟭&⟬trap:indicator_non_pii|patient_id=TEACHING_0042⟭ HTTP/1.1" 200 6120844 "-" "Weasis/4.3" dbg="cache=hit"
⟬ip_address#2⟭ - - [⟬date#1⟭ 15:31:14 -0500] "GET /teaching/⟬trap:eponym|crohns-disease⟭ HTTP/1.1" 200 22410 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/121.0" dbg="-"
⟬ip_address#3⟭ - - [⟬date#1⟭ 15:31:30 -0500] "GET /health HTTP/1.1" 200 2 "-" "kube-probe/1.29" dbg="cache=hit"
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: en
fill_locale: en_US
domain: retail
appearance: Newman verbose output, HTTP header, JSON body, test assertions, secret under an innocuous key
scenario: GitLab job running Newman with --verbose against a shoe retailer's checkout API, whose request dumps show bearer tokens, a test card, a shipping address and an admin password
⟬text⟭
$ npm ci --silent
$ newman run collections/checkout.postman_collection.json -e env/staging.json --verbose
newman

Checkout API

❏ Auth
↳ Login as test shopper
  POST ⟬url#1⟭
  Content-Type: application/json
  {"email":"⟬email#1⟭","password":"⟬password#1⟭"}
  200 OK ★ 212ms time ★ 612B size
  {"token":"⟬jwt#1⟭","expires_in":3600}
  ✓  status is 200
  ✓  token is present

↳ Login as store admin
  POST ⟬url#1⟭
  Content-Type: application/json
  {"email":"⟬email:generic#2⟭","password":"⟬password#2⟭"}
  200 OK ★ 198ms time ★ 604B size
  {"token":"⟬jwt#2⟭","expires_in":900}
  ✓  status is 200

❏ Cart
↳ Create cart
  POST ⟬url#2⟭
  Authorization: Bearer ⟬jwt#1⟭
  {"sku":"RUN-AIR-42","qty":1}
  201 Created ★ 88ms time ★ 412B size
  {"cart_id":"⟬uuid#1⟭","total":129.00}
  ✓  status is 201

↳ Apply coupon
  POST ⟬url#3⟭
  Authorization: Bearer ⟬jwt#1⟭
  {"cart_id":"⟬uuid#1⟭","code":"SPRING10"}
  200 OK ★ 41ms time ★ 280B size
  ✓  discount applied

❏ Checkout
↳ Set shipping address
  PUT ⟬url#4⟭
  Authorization: Bearer ⟬jwt#1⟭
  {"name":"⟬person_name#1⟭","street":"⟬postal_address:street#1⟭","city":"⟬city#1⟭","zip":"⟬postcode#1⟭"}
  200 OK ★ 62ms time ★ 318B size
  ✓  status is 200

↳ Pay with test card
  POST ⟬url#5⟭
  Authorization: Bearer ⟬jwt#1⟭
  X-Client-Ref: ⟬opaque_token#1⟭
  {"card":"⟬payment_card#1⟭","cvv":"⟬card_security_code#1⟭","amount":116.10}
  200 OK ★ 811ms time ★ 288B size
  {"status":"captured","order":"⟬order_number#1⟭"}
  ✓  status is 200
  ✓  order is captured

↳ Refund as admin
  POST ⟬url#6⟭
  Authorization: Bearer ⟬jwt#2⟭
  X-Client-Ref: ⟬uuid#2⟭
  {"order":"⟬order_number#1⟭"}
  500 Internal Server Error ★ 102ms time ★ 188B size
  1. status is 200

┌─────────────────────────┬───────────────────┬───────────────────┐
│                         │          executed │            failed │
├─────────────────────────┼───────────────────┼───────────────────┤
│              iterations │                 1 │                 0 │
│                requests │                 7 │                 0 │
│              assertions │                10 │                 1 │
└─────────────────────────┴───────────────────┴───────────────────┘
ERROR: Job failed: exit code 1
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: en
fill_locale: en_US
domain: government
appearance: pipe-separated log, audit trail, court record lookup, passport and license in a search term
scenario: court records system audit, where a clerk searches a defendant by license, passport and SSN under a named case
⟬text⟭
⟬date#1⟭ 09:41:02|⟬person_name:handle#1⟭|SEARCH|term=⟬us_driver_license#2⟭|hits=1
⟬date#1⟭ 09:41:27|⟬person_name:handle#1⟭|VIEW|case=⟬ticket_id#1⟭|party="⟬person_name#2⟭"
⟬date#1⟭ 09:42:10|⟬person_name:handle#1⟭|SEARCH|term=⟬us_passport#2⟭|hits=1
⟬date#1⟭ 09:42:44|⟬person_name:handle#1⟭|UNSEAL|field=ssn|value=⟬us_ssn#2⟭|order=⟬ticket_id#2⟭
⟬date#1⟭ 09:43:05|⟬trap:indicator_non_pii|user=docket-sync⟭|EXPORT|case=⟬ticket_id#1⟭|dest=⟬hostname#1⟭
⟬date#1⟭ 09:44:31|⟬person_name:handle#1⟭|SEARCH|term=⟬us_license_plate#3⟭|hits=0
⟬end⟭

⟬template⟭
family: logs
format: application log
language: en
fill_locale: en_US
domain: fintech
appearance: Python logging line, SFTP client debug, password in a debug line
scenario: end-of-day ACH upload of a credit union, whose SFTP debug prints the password and a pre-shared value
⟬text⟭
⟬date#1⟭ 17:00:02 INFO ach.upload connecting to ⟬hostname#1⟭ as ⟬trap:indicator_non_pii|user=ach_prod⟭
⟬date#1⟭ 17:00:02 DEBUG paramiko.transport auth password=⟬password#1⟭ psk=⟬opaque_token#1⟭
⟬date#1⟭ 17:00:03 INFO ach.upload sent ⟬file_path#1⟭ size=88120 entries=412
⟬date#1⟭ 17:00:04 INFO ach.upload bank receipt ⟬uuid#1⟭
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: en
fill_locale: en_US
domain: SaaS
appearance: Spring Boot startup failure, nested Caused by chain, JDBC URL, configuration dump, HTTP header
scenario: startup failure of a marketing automation platform, with a long chain of bean errors, a JDBC URL holding the password and a configuration report with the SMTP password and a service JWT
⟬text⟭
⟬date#1⟭ 06:15:02.204  INFO 1 --- [           main] c.m.campaigns.CampaignsApplication       : Starting CampaignsApplication ⟬version#1⟭ using Java 17.0.10
⟬date#1⟭ 06:15:02.210  INFO 1 --- [           main] c.m.campaigns.CampaignsApplication       : The following 1 profile is active: "prod"
⟬date#1⟭ 06:15:05.118  INFO 1 --- [           main] o.s.d.r.c.RepositoryConfigurationDelegate : Finished Spring Data repository scanning in 214 ms. Found 18 JPA repository interfaces.
⟬date#1⟭ 06:15:06.402  INFO 1 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat initialized with port 8080 (http)
⟬date#1⟭ 06:15:06.880  INFO 1 --- [           main] com.zaxxer.hikari.HikariDataSource       : HikariPool-1 - Starting...
⟬date#1⟭ 06:15:37.002 ERROR 1 --- [           main] com.zaxxer.hikari.pool.HikariPool        : HikariPool-1 - Exception during pool initialization.

org.postgresql.util.PSQLException: FATAL: password authentication failed for user "⟬trap:indicator_non_pii|campaigns_app⟭"
	at org.postgresql.core.v3.ConnectionFactoryImpl.doAuthentication(ConnectionFactoryImpl.java:693)
	at org.postgresql.core.v3.ConnectionFactoryImpl.tryConnect(ConnectionFactoryImpl.java:203)
	at org.postgresql.core.v3.ConnectionFactoryImpl.openConnectionImpl(ConnectionFactoryImpl.java:258)
	at org.postgresql.core.ConnectionFactory.openConnection(ConnectionFactory.java:54)
	at org.postgresql.jdbc.PgConnection.<init>(PgConnection.java:263)
	at org.postgresql.Driver.makeConnection(Driver.java:443)
	at org.postgresql.Driver.connect(Driver.java:297)
	at com.zaxxer.hikari.util.DriverDataSource.getConnection(DriverDataSource.java:138)
	at com.zaxxer.hikari.pool.PoolBase.newConnection(PoolBase.java:359)
	at com.zaxxer.hikari.pool.PoolBase.newPoolEntry(PoolBase.java:201)
	at com.zaxxer.hikari.pool.HikariPool.createPoolEntry(HikariPool.java:470)
	at com.zaxxer.hikari.pool.HikariPool.checkFailFast(HikariPool.java:561)
	at com.zaxxer.hikari.pool.HikariPool.<init>(HikariPool.java:100)
	at com.zaxxer.hikari.HikariDataSource.getConnection(HikariDataSource.java:112)
	at org.springframework.jdbc.datasource.DataSourceUtils.fetchConnection(DataSourceUtils.java:160)
	at org.springframework.jdbc.datasource.DataSourceUtils.doGetConnection(DataSourceUtils.java:118)

⟬date#1⟭ 06:15:37.040  WARN 1 --- [           main] ConfigServletWebServerApplicationContext : Exception encountered during context initialization - cancelling refresh attempt: org.springframework.beans.factory.BeanCreationException: Error creating bean with name 'entityManagerFactory'
⟬date#1⟭ 06:15:37.052  INFO 1 --- [           main] o.apache.catalina.core.StandardService   : Stopping service [Tomcat]
⟬date#1⟭ 06:15:37.077  INFO 1 --- [           main] ConditionEvaluationReportLoggingListener :

Error starting ApplicationContext. To display the condition evaluation report re-run your application with 'debug' enabled.
⟬date#1⟭ 06:15:37.101 ERROR 1 --- [           main] o.s.boot.SpringApplication               : Application run failed

org.springframework.beans.factory.BeanCreationException: Error creating bean with name 'entityManagerFactory' defined in class path resource [org/springframework/boot/autoconfigure/orm/jpa/HibernateJpaConfiguration.class]: Unable to open JDBC Connection for DDL execution
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.initializeBean(AbstractAutowireCapableBeanFactory.java:1786)
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.doCreateBean(AbstractAutowireCapableBeanFactory.java:600)
	at org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory.createBean(AbstractAutowireCapableBeanFactory.java:522)
	at org.springframework.beans.factory.support.AbstractBeanFactory.lambda$doGetBean$0(AbstractBeanFactory.java:326)
	at org.springframework.beans.factory.support.DefaultSingletonBeanRegistry.getSingleton(DefaultSingletonBeanRegistry.java:234)
	at org.springframework.beans.factory.support.AbstractBeanFactory.doGetBean(AbstractBeanFactory.java:324)
	at org.springframework.beans.factory.support.AbstractBeanFactory.getBean(AbstractBeanFactory.java:205)
	at org.springframework.context.support.AbstractApplicationContext.getBean(AbstractApplicationContext.java:1155)
	at org.springframework.context.support.AbstractApplicationContext.finishBeanFactoryInitialization(AbstractApplicationContext.java:917)
	at org.springframework.boot.web.servlet.context.ServletWebServerApplicationContext.refresh(ServletWebServerApplicationContext.java:146)
	at org.springframework.boot.SpringApplication.refreshContext(SpringApplication.java:456)
	at org.springframework.context.support.AbstractApplicationContext.refresh(AbstractApplicationContext.java:601)
	at org.springframework.boot.SpringApplication.run(SpringApplication.java:334)
	at com.marketforge.campaigns.CampaignsApplication.main(CampaignsApplication.java:14)
Caused by: org.hibernate.exception.GenericJDBCException: Unable to open JDBC Connection for DDL execution
	at org.hibernate.exception.internal.StandardSQLExceptionConverter.convert(StandardSQLExceptionConverter.java:42)
	at org.hibernate.tool.schema.internal.exec.ImprovedExtractionContextImpl.getJdbcConnection(ImprovedExtractionContextImpl.java:63)
	... 24 common frames omitted

Configuration properties at failure:
  spring.datasource.url = jdbc:postgresql://⟬hostname#1⟭:5432/campaigns?user=⟬trap:indicator_non_pii|campaigns_app⟭&password=⟬url_password#1⟭
  spring.datasource.hikari.maximum-pool-size = 30
  spring.mail.host = ⟬hostname#2⟭
  spring.mail.username = ⟬email:generic#1⟭
  spring.mail.password = ⟬password#1⟭
  spring.jpa.hibernate.ddl-auto = validate
  campaigns.tracking.ref = ⟬opaque_token#1⟭
  campaigns.tracking.domain = ⟬url#1⟭
  campaigns.partner.authorization = Bearer ⟬jwt#1⟭
  campaigns.reply-to = ⟬email:generic#2⟭
  campaigns.owner = ⟬trap:indicator_non_pii|growth-platform⟭
  management.endpoints.web.exposure.include = health,info
⟬end⟭

⟬template⟭
family: logs
format: test output
language: en
fill_locale: en_US
domain: healthcare
appearance: xUnit output, expected and actual, value without a key
scenario: dotnet test failure of a member file parser, showing the expected SSN and the actual null
⟬text⟭
[xUnit.net 00:00:02.11]     Eligibility.Tests.MemberFileTests.Parses_Fixed_Width_Row [FAIL]
  Failed Eligibility.Tests.MemberFileTests.Parses_Fixed_Width_Row [12 ms]
  Error Message:
   Assert.Equal() Failure: Values differ
Expected: "⟬us_ssn#1⟭"
Actual:   null
  Stack Trace:
     at Eligibility.Tests.MemberFileTests.Parses_Fixed_Width_Row() in /src/tests/MemberFileTests.cs:line 44

Failed!  - Failed:     1, Passed:    63, Skipped:     0, Total:    64, Duration: 2 s
⟬end⟭

⟬template⟭
family: logs
format: access log
language: en
fill_locale: en_US
domain: retail
appearance: Fastly-style quoted fields, context field, plate lookup, gift card in a query string
scenario: CDN log of an auto parts retailer, where fitment lookups by plate go to a context field and gift card balance links carry the code in the query string
⟬text⟭
"⟬ip_address#1⟭" "⟬date#1⟭ 18:02:11" "GET /fitment/start" 200 "HIT" 8120 ua="Mozilla/5.0 (Linux; Android 14) Chrome/120.0" info="-"
"⟬ip_address#1⟭" "⟬date#1⟭ 18:02:38" "POST /fitment/plate" 200 "PASS" 612 ua="Mozilla/5.0 (Linux; Android 14) Chrome/120.0" info="plate=⟬us_license_plate#2⟭ state=GA"
"⟬ip_address#1⟭" "⟬date#1⟭ 18:02:39" "GET /fitment/results?vehicle=⟬uuid#1⟭" 200 "MISS" 22040 ua="Mozilla/5.0 (Linux; Android 14) Chrome/120.0" info="-"
"⟬ip_address#2⟭" "⟬date#1⟭ 18:03:05" "GET /giftcard/balance?code=⟬opaque_token#1⟭" 200 "PASS" 188 ua="Mozilla/5.0 (iPhone; CPU iPhone OS 17_3 like Mac OS X)" info="-"
"⟬ip_address#3⟭" "⟬date#1⟭ 18:03:22" "POST /fitment/plate" 404 "PASS" 96 ua="Mozilla/5.0 (Macintosh; Intel Mac OS X 14_2) Safari/605.1.15" info="plate=⟬us_license_plate#3⟭ state=TX"
"⟬ip_address#4⟭" "⟬date#1⟭ 18:03:47" "POST /pro/account/apply" 201 "PASS" 140 ua="Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/121.0" info="shop=⟬company#4⟭ owner=⟬person_name#4⟭ dl=⟬us_driver_license#4⟭"
"⟬ip_address#4⟭" "⟬date#1⟭ 18:03:48" "POST /pro/account/address" 200 "PASS" 88 ua="Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/121.0" info="addr=⟬postal_address#4⟭"
"⟬ip_address#5⟭" "⟬date#1⟭ 18:04:11" "GET /health" 200 "PASS" 2 ua="Varnish/7.4" info="-"
"⟬ip_address#6⟭" "⟬date#1⟭ 18:04:30" "POST /checkout/card" 200 "PASS" 112 ua="Mozilla/5.0 (Linux; Android 13) Chrome/119.0" info="⟬payment_card#6⟭/⟬card_security_code#6⟭"
"⟬ip_address#6⟭" "⟬date#1⟭ 18:04:31" "GET /checkout/thanks?receipt=⟬invoice_number#1⟭" 200 "PASS" 2600 ua="Mozilla/5.0 (Linux; Android 13) Chrome/119.0" info="owner=⟬trap:indicator_non_pii|guest-checkout⟭"
"⟬ip_address#7⟭" "⟬date#1⟭ 18:05:02" "GET /parts/brake-pads?make=⟬trap:company_name|Ford⟭" 200 "HIT" 12040 ua="Mozilla/5.0 (compatible; Googlebot/2.1)" info="-"
"⟬ip_address#7⟭" "⟬date#1⟭ 18:05:04" "GET /parts/oil-filters?make=⟬trap:company_name|Chrysler⟭" 200 "HIT" 11800 ua="Mozilla/5.0 (compatible; Googlebot/2.1)" info="-"
"⟬ip_address#8⟭" "⟬date#1⟭ 18:05:31" "GET /recall/check?token=⟬jwt#1⟭" 200 "PASS" 440 ua="PartsApp/⟬version#1⟭ (iOS 17.3)" info="-"
"⟬ip_address#9⟭" "⟬date#1⟭ 18:06:02" "POST /fitment/plate" 200 "PASS" 604 ua="PartsApp/⟬version#1⟭ (iOS 17.3)" info="plate=⟬us_license_plate#9⟭ state=NC"
"⟬ip_address#5⟭" "⟬date#1⟭ 18:06:11" "GET /health" 200 "PASS" 2 ua="Varnish/7.4" info="-"
"⟬ip_address#10⟭" "⟬date#1⟭ 18:06:40" "GET /stores/⟬trap:word_name|Austin-north⟭/hours" 200 "HIT" 1820 ua="Mozilla/5.0 (iPad; CPU OS 17_2 like Mac OS X) Safari/604.1" info="-"
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: en
fill_locale: en_US
domain: government
appearance: conftest output, policy check, shell trace
scenario: pipeline step checking a state agency's Kubernetes manifests against policy, with one warning and no sensitive value
⟬text⟭
+ conftest test manifests/ --policy policy/
FAIL - manifests/deploy.yaml - main - container "benefits-api" runs as root
WARN - manifests/deploy.yaml - main - ⟬trap:indicator_non_pii|owner=benefits-team⟭ label missing on Service
WARN - manifests/secret.yaml - main - api_key=⟬trap:placeholder|REPLACE_ME⟭ must come from the vault
14 tests, 11 passed, 2 warnings, 1 failure, 0 exceptions
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: en
fill_locale: en_US
domain: travel
appearance: comma-separated log, quoted value, passport in a column, agent handle, parking plate
scenario: check-in agent audit of a regional airline for one morning, as comma-separated records with passengers in quoted cells, some passports, seat changes and an airport parking pass
⟬text⟭
seq,time,agent,station,action,pax,document,detail
1,"⟬date#1⟭ 05:02:11",⟬person_name:handle#1⟭,CLT,SHIFT_START,,,counter 12
2,"⟬date#1⟭ 05:06:40",⟬person_name:handle#1⟭,CLT,CHECKIN,"⟬person_name#2⟭",⟬us_passport#2⟭,seat 14C bags 1
3,"⟬date#1⟭ 05:07:02",⟬person_name:handle#1⟭,CLT,BAG_TAG,"⟬person_name#2⟭",,tag ⟬uuid#1⟭
4,"⟬date#1⟭ 05:09:17",⟬person_name:handle#1⟭,CLT,CHECKIN,"⟬person_name#3⟭",⟬us_passport#3⟭,seat 22A bags 2
5,"⟬date#1⟭ 05:09:44",⟬person_name:handle#1⟭,CLT,FEE,"⟬person_name#3⟭",,overweight 35.00 card ⟬payment_card#3⟭
6,"⟬date#1⟭ 05:11:30",⟬trap:indicator_non_pii|kiosk-07⟭,CLT,CHECKIN,"⟬person_name#4⟭",,seat 09D bags 0
7,"⟬date#1⟭ 05:12:04",⟬trap:indicator_non_pii|kiosk-07⟭,CLT,CHECKIN,"⟬person_name#5⟭",,seat 09E bags 0
8,"⟬date#1⟭ 05:12:51",⟬person_name:handle#6⟭,CLT,SHIFT_START,,,counter 13
9,"⟬date#1⟭ 05:14:20",⟬person_name:handle#6⟭,CLT,SEAT_CHANGE,"⟬person_name#7⟭",,"14D to 03A upgrade by ⟬person_name#8⟭"
10,"⟬date#1⟭ 05:15:02",⟬person_name:handle#6⟭,CLT,CHECKIN,"⟬person_name#7⟭",⟬us_driver_license#7⟭,seat 03A bags 1
11,"⟬date#1⟭ 05:16:33",⟬person_name:handle#6⟭,CLT,NO_REC,"⟬person_name#9⟭",,sent to ticket counter
12,"⟬date#1⟭ 05:18:47",⟬person_name:handle#1⟭,CLT,CHECKIN,"⟬person_name#10⟭",⟬us_passport#10⟭,seat 18B bags 1
13,"⟬date#1⟭ 05:19:10",⟬person_name:handle#1⟭,CLT,DOC_CHECK,"⟬person_name#10⟭",⟬us_passport#10⟭,visa on file
14,"⟬date#1⟭ 05:21:02",⟬trap:indicator_non_pii|kiosk-04⟭,CLT,CHECKIN,"⟬person_name#11⟭",,seat 27F bags 0
15,"⟬date#1⟭ 05:22:18",⟬trap:indicator_non_pii|kiosk-04⟭,CLT,BAG_DROP,"⟬person_name#11⟭",,tag ⟬uuid#2⟭
16,"⟬date#1⟭ 05:24:55",⟬person_name:handle#6⟭,CLT,UMNR,⟬trap:indicator_non_pii|"see UM form"⟭,,escort assigned
17,"⟬date#1⟭ 05:26:30",⟬person_name:handle#1⟭,CLT,CHECKIN,"⟬person_name#12⟭",⟬us_passport#12⟭,seat 11C bags 2
18,"⟬date#1⟭ 05:27:12",⟬person_name:handle#1⟭,CLT,PET_FEE,"⟬person_name#12⟭",,125.00 cvv ⟬card_security_code#12⟭ card ⟬payment_card#12⟭
19,"⟬date#1⟭ 05:29:41",⟬trap:indicator_non_pii|gate-sys⟭,CLT,FLIGHT_OPEN,,,AZ318 to ⟬trap:word_name|Austin⟭
20,"⟬date#1⟭ 05:31:06",⟬person_name:handle#6⟭,CLT,SEAT_CHANGE,"⟬person_name#13⟭",,family seating 21A 21B
21,"⟬date#1⟭ 05:33:50",⟬person_name:handle#6⟭,CLT,CHECKIN,"⟬person_name#13⟭",⟬us_driver_license#13⟭,seat 21A bags 1
22,"⟬date#1⟭ 05:34:12",⟬person_name:handle#6⟭,CLT,CHECKIN,"⟬person_name#14⟭",⟬us_driver_license#14⟭,seat 21B bags 0
23,"⟬date#1⟭ 05:36:27",⟬person_name:handle#1⟭,CLT,DENY_BOARD,"⟬person_name#15⟭",⟬us_passport#15⟭,"expired on ⟬date#2⟭"
24,"⟬date#1⟭ 05:37:03",⟬person_name:handle#1⟭,CLT,SUPERVISOR,"⟬person_name#15⟭",,"called ⟬person_name#16⟭ ext 4412"
25,"⟬date#1⟭ 05:38:44",⟬trap:indicator_non_pii|kiosk-07⟭,CLT,CHECKIN,"⟬person_name#17⟭",,seat 16D bags 1
26,"⟬date#1⟭ 05:40:15",⟬trap:indicator_non_pii|kiosk-07⟭,CLT,CHECKIN,"⟬person_name#18⟭",,seat 16E bags 1
27,"⟬date#1⟭ 05:42:02",⟬person_name:handle#6⟭,CLT,PARKING,"⟬person_name#19⟭",,long stay pass plate ⟬us_license_plate#19⟭
28,"⟬date#1⟭ 05:43:39",⟬person_name:handle#6⟭,CLT,CHECKIN,"⟬person_name#19⟭",⟬us_passport#19⟭,seat 05C bags 2
29,"⟬date#1⟭ 05:45:21",⟬person_name:handle#1⟭,CLT,CHECKIN,"⟬person_name#20⟭",⟬us_driver_license#20⟭,seat 30B bags 0
30,"⟬date#1⟭ 05:47:06",⟬trap:indicator_non_pii|gate-sys⟭,CLT,BOARDING,,,AZ318 group 1
31,"⟬date#1⟭ 05:49:44",⟬person_name:handle#6⟭,CLT,GATE_CHANGE,,,AZ318 B7 to B11
32,"⟬date#1⟭ 05:51:18",⟬person_name:handle#1⟭,CLT,CHECKIN,"⟬person_name#21⟭",⟬us_passport#21⟭,seat 07A bags 1
33,"⟬date#1⟭ 05:52:37",⟬trap:indicator_non_pii|kiosk-04⟭,CLT,CHECKIN,"⟬person_name#22⟭",,seat 19C bags 0
34,"⟬date#1⟭ 05:53:02",⟬trap:indicator_non_pii|kiosk-04⟭,CLT,CHECKIN,"⟬person_name#23⟭",,seat 19D bags 0
35,"⟬date#1⟭ 05:55:30",⟬person_name:handle#6⟭,CLT,STANDBY,"⟬person_name#24⟭",,list position 2
36,"⟬date#1⟭ 05:56:09",⟬person_name:handle#6⟭,CLT,STANDBY,"⟬person_name#25⟭",,list position 3
37,"⟬date#1⟭ 05:58:44",⟬person_name:handle#1⟭,CLT,CHECKIN,"⟬person_name#26⟭",⟬us_passport#26⟭,seat 12F bags 1
38,"⟬date#1⟭ 06:00:02",⟬trap:indicator_non_pii|gate-sys⟭,CLT,CUTOFF,,,AZ318 closed for check-in
39,"⟬date#1⟭ 06:00:40",⟬person_name:handle#6⟭,CLT,CLEAR_STANDBY,"⟬person_name#24⟭",,seat 26A
40,"⟬date#1⟭ 06:01:15",⟬person_name:handle#6⟭,CLT,CLEAR_STANDBY,"⟬person_name#25⟭",,seat 26B
41,"⟬date#1⟭ 06:04:50",⟬trap:indicator_non_pii|gate-sys⟭,CLT,FLIGHT_OPEN,,,AZ502 to ⟬trap:word_name|Savannah⟭
42,"⟬date#1⟭ 06:06:21",⟬person_name:handle#1⟭,CLT,CHECKIN,"⟬person_name#27⟭",⟬us_passport#27⟭,seat 02C bags 1
43,"⟬date#1⟭ 06:07:33",⟬person_name:handle#6⟭,CLT,CHECKIN,"⟬person_name#28⟭",⟬us_driver_license#28⟭,seat 08A bags 1
44,"⟬date#1⟭ 06:09:02",⟬trap:indicator_non_pii|kiosk-07⟭,CLT,CHECKIN,"⟬person_name#29⟭",,seat 15B bags 0
45,"⟬date#1⟭ 06:10:48",⟬person_name:handle#1⟭,CLT,WHEELCHAIR,"⟬person_name#30⟭",,"assist requested by daughter ⟬person_name#31f⟭"
46,"⟬date#1⟭ 06:12:19",⟬person_name:handle#6⟭,CLT,NAME_CORRECTION,"⟬person_name#32⟭",,ticket ⟬order_number#1⟭ one letter fixed
47,"⟬date#1⟭ 06:14:02",⟬trap:indicator_non_pii|kiosk-04⟭,CLT,CHECKIN,"⟬person_name#33⟭",,seat 24C bags 1
48,"⟬date#1⟭ 06:15:50",⟬person_name:handle#1⟭,CLT,PARKING,"⟬person_name#34⟭",,employee lot plate ⟬us_license_plate#34⟭
49,"⟬date#1⟭ 06:17:31",⟬person_name:handle#6⟭,CLT,CHECKIN,"⟬person_name#35⟭",⟬us_passport#35⟭,seat 10D bags 2
50,"⟬date#1⟭ 06:19:04",⟬trap:indicator_non_pii|gate-sys⟭,CLT,BOARDING,,,AZ502 group 1
51,"⟬date#1⟭ 06:20:36",⟬person_name:handle#1⟭,CLT,CHECKIN,"⟬person_name#36⟭",⟬us_driver_license#36⟭,seat 13A bags 0
52,"⟬date#1⟭ 06:22:10",⟬person_name:handle#6⟭,CLT,SEAT_CHANGE,"⟬person_name#37⟭",,exit row refused
53,"⟬date#1⟭ 06:24:47",⟬trap:indicator_non_pii|kiosk-07⟭,CLT,CHECKIN,"⟬person_name#38⟭",,seat 20E bags 1
54,"⟬date#1⟭ 06:26:03",⟬person_name:handle#1⟭,CLT,VOUCHER,"⟬person_name#39⟭",,meal 15.00 delay ⟬ticket_id#1⟭
55,"⟬date#1⟭ 06:27:40",⟬person_name:handle#6⟭,CLT,VOUCHER,"⟬person_name#40⟭",,meal 15.00 delay ⟬ticket_id#1⟭
56,"⟬date#1⟭ 06:29:11",⟬person_name:handle#1⟭,CLT,CHECKIN,"⟬person_name#41⟭",⟬us_passport#41⟭,seat 06B bags 1
57,"⟬date#1⟭ 06:30:02",⟬trap:indicator_non_pii|gate-sys⟭,CLT,CUTOFF,,,AZ502 closed for check-in
58,"⟬date#1⟭ 06:32:45",⟬person_name:handle#6⟭,CLT,SHIFT_BREAK,,,counter 13 closed
59,"⟬date#1⟭ 06:35:20",⟬person_name:handle#1⟭,CLT,CHECKIN,"⟬person_name#42⟭",⟬us_driver_license#42⟭,seat 17C bags 1
60,"⟬date#1⟭ 06:38:09",⟬trap:indicator_non_pii|kiosk-04⟭,CLT,CHECKIN,"⟬person_name#43⟭",,seat 23D bags 0
61,"⟬date#1⟭ 06:40:44",⟬person_name:handle#1⟭,CLT,LOST_ITEM,"⟬person_name#44⟭",,left phone at counter call ⟬phone#44⟭
62,"⟬date#1⟭ 06:43:15",⟬trap:indicator_non_pii|gate-sys⟭,CLT,FLIGHT_OPEN,,,AZ711 to ⟬trap:word_name|Charlotte⟭
63,"⟬date#1⟭ 06:45:02",⟬person_name:handle#1⟭,CLT,CASH_OUT,,,drawer balanced by ⟬trap:initials|DM⟭
64,"⟬date#1⟭ 06:48:30",⟬person_name:handle#1⟭,CLT,SHIFT_END,,,counter 12
⟬end⟭

⟬template⟭
family: logs
format: application log
language: en
fill_locale: en_US
domain: healthcare
appearance: Java log line, HL7 segment, pipe-separated record, split address, plain sentence
scenario: reference lab's results interface, whose DEBUG lines copy HL7 PID segments with name, birth date, SSN, split address and phone, while a critical value is phoned to a named doctor
⟬text⟭
⟬date#1⟭ 04:10:02,118 INFO  [lab-out-1] r.l.ResultSender - batch ⟬uuid#1⟭ ready, 38 results
⟬date#1⟭ 04:10:02,204 DEBUG [lab-out-1] r.l.Hl7Writer - MSH|^~\&|REFLAB|MAIN|EHR|CLINIC|||ORU^R01|⟬uuid#2⟭|P|2.5.1
⟬date#1⟭ 04:10:02,206 DEBUG [lab-out-1] r.l.Hl7Writer - PID|1||⟬customer_id#2⟭^^^MRN||⟬person_name:family#2⟭^⟬person_name:given#2⟭||⟬birth_date#2⟭|U|||⟬postal_address:street#2⟭^^⟬city#2⟭^^⟬postcode#2⟭||⟬phone#2⟭|||||⟬customer_id#2⟭|⟬us_ssn#2⟭
⟬date#1⟭ 04:10:02,207 DEBUG [lab-out-1] r.l.Hl7Writer - OBR|1|⟬order_number#1⟭||2160-0^Creatinine^LN|||⟬date#1⟭
⟬date#1⟭ 04:10:02,209 DEBUG [lab-out-1] r.l.Hl7Writer - OBX|1|NM|2160-0^Creatinine^LN||7.4|mg/dL|0.6-1.3|HH
⟬date#1⟭ 04:10:02,240 WARN  [lab-out-1] r.l.CriticalValues - critical creatinine for mrn ⟬customer_id#2⟭, calling ordering provider
⟬date#1⟭ 04:10:02,902 INFO  [lab-out-1] r.l.CriticalValues - reached ⟬person_name#3⟭ at ⟬phone#3⟭, read back confirmed
⟬date#1⟭ 04:10:03,118 INFO  [lab-out-1] r.l.ResultSender - ack AA from ⟬hostname#1⟭
⟬date#1⟭ 04:10:03,204 DEBUG [lab-out-1] r.l.Hl7Writer - PID|1||⟬customer_id#4⟭^^^MRN||⟬person_name:family#4⟭^⟬person_name:given#4⟭||⟬birth_date#4⟭|U|||⟬postal_address:street#4⟭^^⟬city#4⟭^^⟬postcode#4⟭||⟬phone#4⟭|||||⟬customer_id#4⟭|⟬us_ssn#4⟭
⟬date#1⟭ 04:10:03,206 DEBUG [lab-out-1] r.l.Hl7Writer - OBX|1|ST|5196-1^HBsAg^LN||Negative
⟬date#1⟭ 04:10:03,411 INFO  [lab-out-1] r.l.ResultSender - ack AA from ⟬hostname#1⟭
⟬date#1⟭ 04:10:04,002 ERROR [lab-out-1] r.l.ResultSender - ack AE for ⟬uuid#3⟭, unknown patient at destination
⟬date#1⟭ 04:10:04,003 INFO  [lab-out-1] r.l.ErrorQueue - parked ⟬uuid#3⟭, ⟬trap:indicator_non_pii|owner=client-services⟭
⟬date#1⟭ 04:10:09,118 INFO  [lab-out-1] r.l.ResultSender - batch ⟬uuid#1⟭ finished sent=37 parked=1
⟬date#1⟭ 04:15:00,002 INFO  [metrics] r.l.Stats - turnaround_p50_min=212 critical_calls=1 version=⟬version#1⟭
⟬date#1⟭ 04:20:00,002 INFO  [metrics] r.l.Stats - queue=0 ⟬trap:indicator_non_pii|user=lab-interface⟭
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: en
fill_locale: en_US
domain: retail
appearance: Java stack trace, Caused by chain, code identifier, library named after a person, consumer log
scenario: inventory reservation service at a sporting goods chain crashing on a Kafka rebalance, with a long trace of framework frames, no customer or secret
⟬text⟭
⟬date#1⟭ 21:44:12.301 ERROR [reservation-consumer-2] c.s.inventory.ReservationListener - listener failed on partition 7 offset 88120412
⟬trap:code_identifier|org.springframework.kafka.listener.ListenerExecutionFailedException⟭: Listener method 'onReservation' threw exception
	at ⟬trap:code_identifier|org.springframework.kafka.listener.KafkaMessageListenerContainer$ListenerConsumer.decorateException⟭(KafkaMessageListenerContainer.java:2890)
	at ⟬trap:code_identifier|org.springframework.kafka.listener.KafkaMessageListenerContainer$ListenerConsumer.doInvokeBatchOnMessage⟭(KafkaMessageListenerContainer.java:2395)
	at ⟬trap:code_identifier|org.springframework.kafka.listener.KafkaMessageListenerContainer$ListenerConsumer.invokeBatchOnMessageWithRecordsOrList⟭(KafkaMessageListenerContainer.java:2375)
	at ⟬trap:code_identifier|org.springframework.kafka.listener.KafkaMessageListenerContainer$ListenerConsumer.invokeBatchOnMessage⟭(KafkaMessageListenerContainer.java:2319)
	at ⟬trap:code_identifier|org.springframework.kafka.listener.KafkaMessageListenerContainer$ListenerConsumer.invokeBatchListener⟭(KafkaMessageListenerContainer.java:2200)
	at ⟬trap:code_identifier|org.springframework.kafka.listener.KafkaMessageListenerContainer$ListenerConsumer.invokeListener⟭(KafkaMessageListenerContainer.java:2098)
	at ⟬trap:code_identifier|org.springframework.kafka.listener.KafkaMessageListenerContainer$ListenerConsumer.pollAndInvoke⟭(KafkaMessageListenerContainer.java:1661)
	at ⟬trap:code_identifier|org.springframework.kafka.listener.KafkaMessageListenerContainer$ListenerConsumer.run⟭(KafkaMessageListenerContainer.java:1287)
	at java.base/java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:539)
	at java.base/java.util.concurrent.FutureTask.run(FutureTask.java:264)
	at java.base/java.lang.Thread.run(Thread.java:840)
Caused by: org.springframework.dao.CannotAcquireLockException: could not execute statement [ERROR: deadlock detected]
	at org.springframework.orm.jpa.vendor.HibernateJpaDialect.convertHibernateAccessException(HibernateJpaDialect.java:262)
	at org.springframework.orm.jpa.vendor.HibernateJpaDialect.translateExceptionIfPossible(HibernateJpaDialect.java:229)
	at org.springframework.dao.support.PersistenceExceptionTranslationInterceptor.invoke(PersistenceExceptionTranslationInterceptor.java:137)
	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:184)
	at org.springframework.data.repository.core.support.RepositoryMethodInterceptor.invoke(RepositoryMethodInterceptor.java:88)
	at com.summitgear.inventory.StockRepository.reserve(Unknown Source)
	at com.summitgear.inventory.ReservationService.reserveLines(ReservationService.java:118)
	at com.summitgear.inventory.ReservationService.handle(ReservationService.java:74)
	at org.springframework.transaction.interceptor.TransactionInterceptor.invoke(TransactionInterceptor.java:119)
	at org.springframework.aop.framework.CglibAopProxy$CglibMethodInvocation.proceed(CglibAopProxy.java:768)
	at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:720)
	at com.summitgear.inventory.ReservationListener.onReservation(ReservationListener.java:52)
	at jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103)
	at java.base/java.lang.reflect.Method.invoke(Method.java:580)
	... 12 common frames omitted
Caused by: org.hibernate.exception.LockAcquisitionException: could not execute statement [ERROR: deadlock detected
  Detail: Process 8120 waits for ShareLock on transaction 41220; blocked by process 8133.
  Process 8133 waits for ShareLock on transaction 41219; blocked by process 8120.
  Hint: See server log for query details.
  Where: while updating tuple (412,18) in relation "stock_levels"] [update stock_levels set reserved=reserved+? where sku=? and warehouse=?]
	at org.hibernate.dialect.PostgreSQLDialect.lambda$buildSQLExceptionConversionDelegate$3(PostgreSQLDialect.java:1071)
	at org.hibernate.exception.internal.StandardSQLExceptionConverter.convert(StandardSQLExceptionConverter.java:34)
	at org.hibernate.engine.jdbc.spi.SqlExceptionHelper.convert(SqlExceptionHelper.java:108)
	at org.hibernate.engine.jdbc.internal.ResultSetReturnImpl.executeUpdate(ResultSetReturnImpl.java:278)
	at org.hibernate.engine.jdbc.batch.internal.BatchImpl.performExecution(BatchImpl.java:136)
	at org.hibernate.engine.jdbc.batch.internal.BatchImpl.execute(BatchImpl.java:110)
	... 24 common frames omitted
Caused by: org.postgresql.util.PSQLException: ERROR: deadlock detected
  Detail: Process 8120 waits for ShareLock on transaction 41220; blocked by process 8133.
	at org.postgresql.core.v3.QueryExecutorImpl.receiveErrorResponse(QueryExecutorImpl.java:2725)
	at org.postgresql.core.v3.QueryExecutorImpl.processResults(QueryExecutorImpl.java:2412)
	at org.postgresql.core.v3.QueryExecutorImpl.execute(QueryExecutorImpl.java:371)
	at org.postgresql.jdbc.PgStatement.executeInternal(PgStatement.java:502)
	at org.postgresql.jdbc.PgPreparedStatement.executeUpdate(PgPreparedStatement.java:152)
	at com.zaxxer.hikari.pool.HikariProxyPreparedStatement.executeUpdate(HikariProxyPreparedStatement.java:61)
	at com.zaxxer.hikari.pool.ProxyPreparedStatement.executeUpdate(ProxyPreparedStatement.java:61)
	at org.hibernate.engine.jdbc.internal.ResultSetReturnImpl.executeUpdate(ResultSetReturnImpl.java:275)
	... 27 common frames omitted

⟬date#1⟭ 21:44:12.340  WARN [reservation-consumer-2] c.s.inventory.RetryPolicy - retry 1 of 5 in 2000 ms, topic=reservations.v3
⟬date#1⟭ 21:44:14.344  INFO [reservation-consumer-2] c.s.inventory.ReservationListener - batch of 64 reprocessed, ⟬trap:indicator_non_pii|customer=none⟭ for system reservations
⟬date#1⟭ 21:44:14.350  INFO [reservation-consumer-2] ⟬trap:code_identifier|o.a.kafka.clients.consumer.KafkaConsumer⟭ - [Consumer clientId=reservation-2, groupId=inventory] Seeking to offset 88120476 for partition reservations.v3-7
⟬date#1⟭ 21:44:20.118  WARN [kafka-coordinator-heartbeat-thread] o.a.k.c.c.internals.ConsumerCoordinator - [Consumer clientId=reservation-2, groupId=inventory] Member reservation-2 sending LeaveGroup request to coordinator ⟬hostname#1⟭ due to consumer poll timeout has expired
⟬date#1⟭ 21:44:20.402  INFO [reservation-consumer-2] o.a.k.c.c.internals.ConsumerCoordinator - [Consumer clientId=reservation-2, groupId=inventory] Revoke previously assigned partitions reservations.v3-7
⟬date#1⟭ 21:44:21.610  INFO [reservation-consumer-2] o.a.k.c.c.internals.ConsumerCoordinator - [Consumer clientId=reservation-2, groupId=inventory] Successfully joined group with generation 412
⟬date#1⟭ 21:44:21.615  INFO [reservation-consumer-2] o.a.k.c.c.internals.ConsumerCoordinator - [Consumer clientId=reservation-2, groupId=inventory] Adding newly assigned partitions: reservations.v3-7
⟬date#1⟭ 21:44:30.003  INFO [metrics] c.s.inventory.Metrics - lag=118 deadlocks_1h=3 rebalances_1h=1 version=⟬version#1⟭
⟬date#1⟭ 21:44:30.004  INFO [metrics] c.s.inventory.Metrics - partition assignment strategy=⟬trap:eponym|Zipf-aware⟭ owner=⟬trap:indicator_non_pii|platform-commerce⟭
⟬date#1⟭ 21:45:00.003  INFO [metrics] c.s.inventory.Metrics - lag=41 deadlocks_1h=3 rebalances_1h=1
⟬date#1⟭ 21:45:30.003  INFO [metrics] c.s.inventory.Metrics - lag=0 deadlocks_1h=3 rebalances_1h=1
⟬date#1⟭ 21:46:00.003  INFO [metrics] c.s.inventory.Metrics - lag=0 stock_sync=ok
⟬end⟭
