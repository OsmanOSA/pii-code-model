⟬template⟭
family: logs
format: test output
language: en
fill_locale: en_US
domain: SaaS
appearance: Karma output, console log object, ID token in a fixture, spy assertion
scenario: Karma run of an Angular admin console, whose SSO callback test logs the fixture with an ID token, a display name and a password
⟬text⟭
⟬date#1⟭ 11:02:04 INFO [karma-server]: Karma v6.4.2 server started at http://localhost:9876/
⟬date#1⟭ 11:02:04 INFO [launcher]: Starting browser ChromeHeadless
⟬date#1⟭ 11:02:07 INFO [Chrome Headless 121.0.0.0 (Linux x86_64)]: Connected on socket ⟬uuid#1⟭
LOG: 'fixture', Object{displayName: "⟬person_name#1⟭", email: "⟬email#1⟭", idToken: "⟬jwt#1⟭", password: "⟬password#1⟭"}
Chrome Headless 121.0.0.0 (Linux x86_64) SsoCallbackComponent should store the session FAILED
	Expected spy navigate to have been called with [ '/home' ] but it was never called.
	    at UserContext.apply (src/app/sso/sso-callback.component.spec.ts:41:29)
	    at _ZoneDelegate.invoke (node_modules/zone.js/fesm2015/zone.js:368:26)
	    at ProxyZoneSpec.onInvoke (node_modules/zone.js/fesm2015/zone-testing.js:273:39)
	    at _ZoneDelegate.invoke (node_modules/zone.js/fesm2015/zone.js:367:52)
Chrome Headless 121.0.0.0 (Linux x86_64): Executed 118 of 212 SUCCESS (0 secs / 3.204 secs)
Chrome Headless 121.0.0.0 (Linux x86_64) ⟬trap:code_identifier|⦃Family⦄MigrationService⟭ should keep the owner role FAILED
	Expected "owner" to equal "workspace-owner".
	    at UserContext.apply (src/app/migration/migration.service.spec.ts:62:33)
Chrome Headless 121.0.0.0 (Linux x86_64): Executed 212 of 212 (2 FAILED) (4.118 secs / 3.902 secs)
TOTAL: 2 FAILED, 210 SUCCESS
⟬end⟭

⟬template⟭
family: logs
format: access log
language: en
fill_locale: en_US
domain: healthcare
appearance: uvicorn access line, query string, JWT in a query string, context field
scenario: uvicorn access of a clinic's FastAPI backend, with a middleware context field copying member fields and query strings carrying tokens
⟬text⟭
INFO:     ⟬ip_address#1⟭ - "GET /api/v2/appointments?patient=⟬customer_id#2⟭&token=⟬jwt#1⟭ HTTP/1.1" 200 OK fields="-"
INFO:     ⟬ip_address#1⟭ - "POST /api/v2/appointments HTTP/1.1" 201 Created fields="reason=follow-up clinician=⟬person_name#3⟭"
INFO:     ⟬ip_address#2⟭ - "GET /healthz HTTP/1.1" 200 OK fields="-"
INFO:     ⟬ip_address#3⟭ - "POST /api/v2/intake HTTP/1.1" 201 Created fields="name=⟬person_name#4⟭ dob=⟬birth_date#4⟭ ssn=⟬us_ssn#4⟭"
INFO:     ⟬ip_address#3⟭ - "POST /api/v2/intake/insurance HTTP/1.1" 200 OK fields="subscriber=⟬person_name#4⟭ group=⟬customer_id#4⟭"
INFO:     ⟬ip_address#4⟭ - "GET /api/v2/results/⟬uuid#1⟭?code=⟬opaque_token#1⟭ HTTP/1.1" 200 OK fields="-"
INFO:     ⟬ip_address#5⟭ - "GET /api/v2/results/⟬uuid#2⟭?code=⟬opaque_token#3⟭ HTTP/1.1" 403 Forbidden fields="-"
INFO:     ⟬ip_address#6⟭ - "POST /api/v2/messages HTTP/1.1" 201 Created fields="to=⟬person_name#3⟭ from=⟬person_name#7⟭"
INFO:     ⟬ip_address#7⟭ - "POST /api/v2/auth/login HTTP/1.1" 401 Unauthorized fields="user=⟬email#8⟭"
INFO:     ⟬ip_address#7⟭ - "POST /api/v2/auth/login HTTP/1.1" 200 OK fields="user=⟬email#8⟭"
INFO:     ⟬ip_address#7⟭ - "GET /api/v2/me HTTP/1.1" 200 OK fields="auth=Bearer ⟬jwt#2⟭"
INFO:     ⟬ip_address#8⟭ - "GET /api/v2/providers?city=⟬trap:word_name|Charlotte⟭ HTTP/1.1" 200 OK fields="-"
INFO:     ⟬ip_address#2⟭ - "GET /healthz HTTP/1.1" 200 OK fields="-"
INFO:     ⟬ip_address#9⟭ - "POST /api/v2/referrals HTTP/1.1" 201 Created fields="owner=⟬trap:indicator_non_pii|referral-desk⟭ specialty=cardiology"
INFO:     ⟬ip_address#9⟭ - "POST /api/v2/referrals HTTP/1.1" 201 Created fields="owner=⟬person_name#9⟭ specialty=neurology"
INFO:     ⟬ip_address#10⟭ - "GET /api/v2/billing/statement?ref=⟬opaque_token#2⟭ HTTP/1.1" 200 OK fields="-"
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: en
fill_locale: en_US
domain: retail
appearance: shell trace, npmrc write, prefixed token, password in a command
scenario: publish step of a retailer's shared UI kit, writing an npm token and a registry password to .npmrc in clear
⟬text⟭
+ echo "//npm.pkg.internal/:_authToken=⟬npm_token#1⟭" > .npmrc
+ echo "//npm.pkg.internal/:_password=⟬password#1⟭" >> .npmrc
+ echo "ref=⟬opaque_token#1⟭" >> .publish-state
+ npm publish --registry ⟬url#1⟭
npm notice Publishing to ⟬url#1⟭ with tag latest and default access
+ ⟬trap:email_lookalike|@northpier/ui-kit⟭ ⟬version#1⟭
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: en
fill_locale: en_US
domain: government
appearance: syslog line, key=value, background check, quoted value, mixed person and robot users
scenario: audit of a state background check gateway over one morning, with agency staff querying people by license, passport, SSN and plate, and an automated batch alongside them
⟬text⟭
⟬date#1⟭ 08:12:04 bgc-gw audit[2211]: type=LOGIN user="⟬person_name#1⟭" agency=SO-0412 src=⟬ip_address#1⟭ mfa=card
⟬date#1⟭ 08:13:21 bgc-gw audit[2211]: type=QUERY user="⟬person_name#1⟭" subject="⟬person_name#2⟭" dl="⟬us_driver_license#2⟭" dob=⟬birth_date#2⟭ purpose=employment result=NO_RECORD
⟬date#1⟭ 08:14:02 bgc-gw audit[2211]: type=QUERY user="⟬person_name#1⟭" subject="⟬person_name#3⟭" ssn="⟬us_ssn#3⟭" dob=⟬birth_date#3⟭ purpose=employment result=NO_RECORD
⟬date#1⟭ 08:15:40 bgc-gw audit[2211]: type=QUERY user="⟬person_name#1⟭" subject="⟬person_name#4⟭" passport=⟬us_passport#4⟭ purpose=licensing result=MATCH
⟬date#1⟭ 08:15:41 bgc-gw audit[2211]: type=RECORD_VIEW user="⟬person_name#1⟭" record=⟬uuid#1⟭ subject="⟬person_name#4⟭" address="⟬postal_address#4⟭"
⟬date#1⟭ 08:17:03 bgc-gw audit[2211]: type=PRINT user="⟬person_name#1⟭" record=⟬uuid#1⟭ printer=⟬hostname#1⟭
⟬date#1⟭ 08:20:00 bgc-gw audit[2211]: type=BATCH_START user=⟬trap:indicator_non_pii|batch-licensing⟭ file=⟬file_path#1⟭ rows=118
⟬date#1⟭ 08:20:04 bgc-gw audit[2211]: type=QUERY user=⟬trap:indicator_non_pii|batch-licensing⟭ subject="⟬person_name#5⟭" dl="⟬us_driver_license#5⟭" purpose=renewal result=NO_RECORD
⟬date#1⟭ 08:20:05 bgc-gw audit[2211]: type=QUERY user=⟬trap:indicator_non_pii|batch-licensing⟭ subject="⟬person_name#6⟭" dl="⟬us_driver_license#6⟭" purpose=renewal result=NO_RECORD
⟬date#1⟭ 08:20:06 bgc-gw audit[2211]: type=QUERY user=⟬trap:indicator_non_pii|batch-licensing⟭ subject="⟬person_name#7⟭" dl="⟬us_driver_license#7⟭" purpose=renewal result=MATCH
⟬date#1⟭ 08:20:06 bgc-gw audit[2211]: type=FLAG user=⟬trap:indicator_non_pii|batch-licensing⟭ subject="⟬person_name#7⟭" reason=open_warrant ticket=⟬ticket_id#1⟭
⟬date#1⟭ 08:20:30 bgc-gw audit[2211]: type=BATCH_END user=⟬trap:indicator_non_pii|batch-licensing⟭ matches=1 duration_s=30
⟬date#1⟭ 08:31:17 bgc-gw audit[2211]: type=LOGIN user="⟬person_name#8⟭" agency=PD-0088 src=⟬ip_address#2⟭ mfa=card
⟬date#1⟭ 08:32:44 bgc-gw audit[2211]: type=PLATE_QUERY user="⟬person_name#8⟭" plate="⟬us_license_plate#9⟭" case=⟬ticket_id#2⟭ result=MATCH
⟬date#1⟭ 08:32:45 bgc-gw audit[2211]: type=RECORD_VIEW user="⟬person_name#8⟭" subject="⟬person_name#9⟭" address="⟬postal_address#9⟭" dl="⟬us_driver_license#9⟭"
⟬date#1⟭ 08:33:10 bgc-gw audit[2211]: type=PLATE_QUERY user="⟬person_name#8⟭" plate="⟬us_license_plate#10⟭" case=⟬ticket_id#2⟭ result=STOLEN
⟬date#1⟭ 08:33:12 bgc-gw audit[2211]: type=FLAG user="⟬person_name#8⟭" reason=stolen_vehicle plate="⟬us_license_plate#10⟭" reported=⟬date#2⟭
⟬date#1⟭ 08:40:02 bgc-gw audit[2211]: type=POLICY user=⟬trap:indicator_non_pii|policy-engine⟭ rule=purpose-required action=warn target=⟬person_name:handle#8⟭
⟬date#1⟭ 08:44:51 bgc-gw audit[2211]: type=QUERY user="⟬person_name#8⟭" subject="⟬person_name#11⟭" ssn="⟬us_ssn#11⟭" dob=⟬birth_date#11⟭ purpose=criminal_justice result=MATCH
⟬date#1⟭ 08:44:52 bgc-gw audit[2211]: type=RECORD_VIEW user="⟬person_name#8⟭" record=⟬uuid#2⟭ subject="⟬person_name#11⟭"
⟬date#1⟭ 08:50:00 bgc-gw audit[2211]: type=HEARTBEAT user=⟬trap:indicator_non_pii|system⟭ queries=14 errors=0
⟬date#1⟭ 09:02:17 bgc-gw audit[2211]: type=LOGIN_FAIL user="⟬person_name#12⟭" agency=SO-0412 src=⟬ip_address#3⟭ reason=card_expired
⟬date#1⟭ 09:02:18 bgc-gw audit[2211]: type=HELPDESK user=⟬trap:indicator_non_pii|access-control⟭ target="⟬person_name#12⟭" ticket=⟬ticket_id#3⟭
⟬date#1⟭ 09:10:41 bgc-gw audit[2211]: type=QUERY user="⟬person_name#1⟭" subject="⟬person_name#13⟭" dl="⟬us_driver_license#13⟭" purpose=firearm_permit result=NO_RECORD
⟬date#1⟭ 09:11:05 bgc-gw audit[2211]: type=QUERY user="⟬person_name#1⟭" subject="⟬person_name#14⟭" passport=⟬us_passport#14⟭ purpose=firearm_permit result=NO_RECORD
⟬date#1⟭ 09:12:30 bgc-gw audit[2211]: type=QUERY user="⟬person_name#1⟭" subject="⟬person_name#15⟭" ssn="⟬us_ssn#15⟭" purpose=firearm_permit result=MATCH
⟬date#1⟭ 09:12:31 bgc-gw audit[2211]: type=DENIAL user="⟬person_name#1⟭" subject="⟬person_name#15⟭" statute=⟬ticket_id#4⟭ notice_to="⟬postal_address#15⟭"
⟬date#1⟭ 09:20:00 bgc-gw audit[2211]: type=HEARTBEAT user=⟬trap:indicator_non_pii|system⟭ queries=21 errors=0
⟬date#1⟭ 09:24:18 bgc-gw audit[2211]: type=QUERY user="⟬person_name#8⟭" subject="⟬person_name#16⟭" dl="⟬us_driver_license#16⟭" purpose=criminal_justice result=NO_RECORD
⟬date#1⟭ 09:25:02 bgc-gw audit[2211]: type=PLATE_QUERY user="⟬person_name#8⟭" plate="⟬us_license_plate#17⟭" case=⟬ticket_id#5⟭ result=NO_RECORD
⟬date#1⟭ 09:31:44 bgc-gw audit[2211]: type=EXPORT user="⟬person_name#8⟭" case=⟬ticket_id#2⟭ file=⟬file_path#2⟭ records=2
⟬date#1⟭ 09:31:45 bgc-gw audit[2211]: type=EXPORT_SIGN user=⟬trap:indicator_non_pii|evidence-signer⟭ sha=⟬hash#1⟭
⟬date#1⟭ 09:40:30 bgc-gw audit[2211]: type=LOGOUT user="⟬person_name#8⟭" agency=PD-0088
⟬date#1⟭ 09:45:12 bgc-gw audit[2211]: type=LOGIN user="⟬person_name#18⟭" agency=AG-0001 src=⟬ip_address#4⟭ mfa=card
⟬date#1⟭ 09:46:02 bgc-gw audit[2211]: type=AUDIT_REVIEW user="⟬person_name#18⟭" target=⟬person_name:handle#8⟭ period=last-30-days
⟬date#1⟭ 09:47:15 bgc-gw audit[2211]: type=AUDIT_NOTE user="⟬person_name#18⟭" text="⟬person_name#8⟭ ran 41 plate checks without a case number"
⟬date#1⟭ 09:50:00 bgc-gw audit[2211]: type=HEARTBEAT user=⟬trap:indicator_non_pii|system⟭ queries=27 errors=0
⟬date#1⟭ 10:02:41 bgc-gw audit[2211]: type=QUERY user="⟬person_name#1⟭" subject="⟬person_name#19⟭" dl="⟬us_driver_license#19⟭" dob=⟬birth_date#19⟭ purpose=employment result=NO_RECORD
⟬date#1⟭ 10:03:02 bgc-gw audit[2211]: type=QUERY user="⟬person_name#1⟭" subject="⟬person_name#20⟭" dl="⟬us_driver_license#20⟭" dob=⟬birth_date#20⟭ purpose=employment result=NO_RECORD
⟬date#1⟭ 10:04:19 bgc-gw audit[2211]: type=QUERY user="⟬person_name#1⟭" subject="⟬person_name#21⟭" passport=⟬us_passport#21⟭ purpose=employment result=NO_RECORD
⟬date#1⟭ 10:10:00 bgc-gw audit[2211]: type=CACHE_FLUSH user=⟬trap:indicator_non_pii|system⟭ entries=27
⟬date#1⟭ 10:15:37 bgc-gw audit[2211]: type=EXPUNGE user="⟬person_name#18⟭" subject="⟬person_name#22⟭" order=⟬ticket_id#6⟭
⟬date#1⟭ 10:15:38 bgc-gw audit[2211]: type=EXPUNGE_SYNC user=⟬trap:indicator_non_pii|records-sync⟭ dest=⟬hostname#2⟭ result=ok
⟬date#1⟭ 10:20:00 bgc-gw audit[2211]: type=HEARTBEAT user=⟬trap:indicator_non_pii|system⟭ queries=30 errors=0
⟬date#1⟭ 10:24:12 bgc-gw audit[2211]: type=CERT_RENEW user=⟬trap:indicator_non_pii|pki-agent⟭ fingerprint=⟬hash#2⟭ version=⟬version#1⟭
⟬date#1⟭ 10:30:41 bgc-gw audit[2211]: type=QUERY user="⟬person_name#1⟭" subject="⟬person_name#23⟭" ssn="⟬us_ssn#23⟭" purpose=licensing result=NO_RECORD
⟬date#1⟭ 10:32:02 bgc-gw audit[2211]: type=QUERY user="⟬person_name#1⟭" subject="⟬person_name#24⟭" dl="⟬us_driver_license#24⟭" purpose=licensing result=MATCH
⟬date#1⟭ 10:32:03 bgc-gw audit[2211]: type=RECORD_VIEW user="⟬person_name#1⟭" record=⟬uuid#3⟭ subject="⟬person_name#24⟭" address="⟬postal_address#24⟭"
⟬date#1⟭ 10:33:40 bgc-gw audit[2211]: type=NOTICE user="⟬person_name#1⟭" subject="⟬person_name#24⟭" channel=mail
⟬date#1⟭ 10:40:00 bgc-gw audit[2211]: type=BATCH_START user=⟬trap:indicator_non_pii|batch-school-bus⟭ file=⟬file_path#3⟭ rows=41
⟬date#1⟭ 10:40:07 bgc-gw audit[2211]: type=QUERY user=⟬trap:indicator_non_pii|batch-school-bus⟭ subject="⟬person_name#25⟭" dl="⟬us_driver_license#25⟭" purpose=school_transport result=NO_RECORD
⟬date#1⟭ 10:40:08 bgc-gw audit[2211]: type=QUERY user=⟬trap:indicator_non_pii|batch-school-bus⟭ subject="⟬person_name#26⟭" dl="⟬us_driver_license#26⟭" purpose=school_transport result=NO_RECORD
⟬date#1⟭ 10:40:20 bgc-gw audit[2211]: type=BATCH_END user=⟬trap:indicator_non_pii|batch-school-bus⟭ matches=0 duration_s=20
⟬date#1⟭ 10:50:00 bgc-gw audit[2211]: type=HEARTBEAT user=⟬trap:indicator_non_pii|system⟭ queries=74 errors=0
⟬date#1⟭ 11:02:31 bgc-gw audit[2211]: type=LOGOUT user="⟬person_name#1⟭" agency=SO-0412
⟬date#1⟭ 11:05:02 bgc-gw audit[2211]: type=REPORT user="⟬person_name#18⟭" kind=monthly-usage dest=⟬url#1⟭
⟬date#1⟭ 11:05:44 bgc-gw audit[2211]: type=LOGOUT user="⟬person_name#18⟭" agency=AG-0001
⟬date#1⟭ 11:10:00 bgc-gw audit[2211]: type=SEGMENT_CLOSE user=⟬trap:indicator_non_pii|audit-rotator⟭ events=61 root=⟬hash#3⟭
⟬date#1⟭ 11:10:01 bgc-gw audit[2211]: type=SEGMENT_FORWARD user=⟬trap:indicator_non_pii|audit-rotator⟭ dest=⟬hostname#3⟭ lag_ms=118
⟬date#1⟭ 11:20:00 bgc-gw audit[2211]: type=HEARTBEAT user=⟬trap:indicator_non_pii|system⟭ queries=74 errors=0
⟬date#1⟭ 11:50:00 bgc-gw audit[2211]: type=HEARTBEAT user=⟬trap:indicator_non_pii|system⟭ queries=74 errors=0
⟬end⟭

⟬template⟭
family: logs
format: application log
language: en
fill_locale: en_US
domain: fintech
appearance: Python logging line, reconciliation counts, company named after a family, stand-in values
scenario: nightly reconciliation of an asset manager's cash positions against custodians, with amounts, custodians named after families and no client
⟬text⟭
⟬date#1⟭ 01:00:02 INFO recon: run ⟬uuid#1⟭ started, custodians=4 version=⟬version#1⟭
⟬date#1⟭ 01:00:04 INFO recon: ⟬trap:company_name|Goldman Sachs⟭ positions file ⟬file_path#1⟭ rows=4120
⟬date#1⟭ 01:00:05 INFO recon: ⟬trap:company_name|Morgan Stanley⟭ positions file ⟬file_path#2⟭ rows=2204
⟬date#1⟭ 01:00:06 INFO recon: ⟬trap:company_name|Wells Fargo⟭ positions file ⟬file_path#3⟭ rows=1820
⟬date#1⟭ 01:00:07 INFO recon: ⟬trap:company_name|Charles Schwab⟭ positions file ⟬file_path#4⟭ rows=612
⟬date#1⟭ 01:00:09 INFO recon: matching on isin and settle date, tolerance 0.01
⟬date#1⟭ 01:00:12 WARN recon: break on fund F-118 side=cash diff=412.08 ⟬trap:indicator_non_pii|owner=ops-recon⟭
⟬date#1⟭ 01:00:12 WARN recon: break on fund F-204 side=fx diff=18.20 ⟬trap:indicator_non_pii|owner=ops-recon⟭
⟬date#1⟭ 01:00:13 DEBUG recon: fund F-118 ⟬trap:indicator_non_pii|client_name=omitted⟭ ⟬trap:indicator_non_pii|account=ACC_000118⟭
⟬date#1⟭ 01:00:15 INFO recon: 8754 lines matched, 2 breaks
⟬date#1⟭ 01:00:16 INFO recon: posting ticket ⟬ticket_id#1⟭
⟬date#1⟭ 01:00:17 INFO recon: report sent to ⟬url#1⟭ ⟬trap:indicator_non_pii|user=recon-service⟭
⟬date#1⟭ 01:00:18 INFO recon: checksum ⟬hash#1⟭
⟬date#1⟭ 01:00:19 INFO recon: fx rates loaded from ⟬url#2⟭ with ⟬trap:indicator_non_pii|token_ttl=900⟭
⟬date#1⟭ 01:00:20 INFO recon: nav checks passed for 41 funds
⟬date#1⟭ 01:00:21 INFO recon: run ⟬uuid#1⟭ finished in 19.2s
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: en
fill_locale: en_US
domain: SaaS
appearance: Node.js stack trace, module not found, scoped package paths, webpack frames, hydration error
scenario: Next.js build and runtime failure of a form builder, with long module traces through scoped packages, no user data and no credential
⟬text⟭
⟬date#1⟭ 09:44:02 [next] Compiled /dashboard in 2.1s (1204 modules)
⟬date#1⟭ 09:44:03 [next] ⨯ Error: Hydration failed because the initial UI does not match what was rendered on the server.
    at throwOnHydrationMismatch (webpack-internal:///./node_modules/react-dom/cjs/react-dom.development.js:12507:9)
    at tryToClaimNextHydratableInstance (webpack-internal:///./node_modules/react-dom/cjs/react-dom.development.js:12535:7)
    at updateHostComponent (webpack-internal:///./node_modules/react-dom/cjs/react-dom.development.js:18210:5)
    at beginWork (webpack-internal:///./node_modules/react-dom/cjs/react-dom.development.js:19637:14)
    at HTMLUnknownElement.callCallback (webpack-internal:///./node_modules/react-dom/cjs/react-dom.development.js:3942:14)
    at Object.invokeGuardedCallbackDev (webpack-internal:///./node_modules/react-dom/cjs/react-dom.development.js:3991:16)
    at invokeGuardedCallback (webpack-internal:///./node_modules/react-dom/cjs/react-dom.development.js:4053:31)
    at beginWork$1 (webpack-internal:///./node_modules/react-dom/cjs/react-dom.development.js:25585:7)
    at performUnitOfWork (webpack-internal:///./node_modules/react-dom/cjs/react-dom.development.js:24884:12)
    at workLoopSync (webpack-internal:///./node_modules/react-dom/cjs/react-dom.development.js:24830:5)
    at renderRootSync (webpack-internal:///./node_modules/react-dom/cjs/react-dom.development.js:24796:9)
    at performConcurrentWorkOnRoot (webpack-internal:///./node_modules/react-dom/cjs/react-dom.development.js:24091:74)
    at workLoop (webpack-internal:///./node_modules/scheduler/cjs/scheduler.development.js:266:34)
    at flushWork (webpack-internal:///./node_modules/scheduler/cjs/scheduler.development.js:239:14)
    at MessagePort.performWorkUntilDeadline (webpack-internal:///./node_modules/scheduler/cjs/scheduler.development.js:533:21)
⟬date#1⟭ 09:44:03 [next] ⨯ digest: "⟬hash#1⟭"
⟬date#1⟭ 09:44:04 [next] ⚠ Unsupported metadata viewport is configured in metadata export in /dashboard.
⟬date#1⟭ 09:44:04 [next] ⚠ Fast Refresh had to perform a full reload due to a runtime error.
⟬date#1⟭ 09:44:05 [next] ⨯ unhandledRejection: Error: connect ECONNREFUSED to preview cache
    at TCPConnectWrap.afterConnect [as oncomplete] (node:net:1595:16)
    at TCPConnectWrap.callbackTrampoline (node:internal/async_hooks:130:17) {
  errno: -111,
  code: 'ECONNREFUSED',
  syscall: 'connect'
}
⟬date#1⟭ 09:44:03 [next] warn: expected <div> in <FieldEditor ⟬trap:indicator_non_pii|fieldName="owner_email"⟭>, server sent <span>
⟬date#1⟭ 09:44:03 [next] warn: expected <input ⟬trap:indicator_non_pii|autoComplete="current-password"⟭> in <LoginPreview>
⟬date#1⟭ 09:44:09 [next] Compiling /api/forms/[id] ...
⟬date#1⟭ 09:44:10 [next] ⨯ ./src/server/forms/renderer.ts:4:0
Module not found: Can't resolve '⟬trap:email_lookalike|@formkit/signature-pad⟭'
  2 | import { z } from "zod";
  3 | import { renderField } from "./fields";
> 4 | import { SignaturePad } from "⟬trap:email_lookalike|@formkit/signature-pad⟭";
  5 |
  6 | export const ⟬trap:indicator_non_pii|DEFAULT_OWNER = "workspace"⟭;
  7 | export const ⟬trap:indicator_non_pii|PASSWORD_FIELD_MIN = 12⟭;

https://nextjs.org/docs/messages/module-not-found

Import trace for requested module:
./src/server/forms/index.ts
./src/app/api/forms/[id]/route.ts
⟬date#1⟭ 09:44:12 [pnpm] Scope: all 6 workspace projects
⟬date#1⟭ 09:44:13 [pnpm] ERR_PNPM_NO_MATCHING_VERSION No matching version found for ⟬trap:email_lookalike|@formkit/signature-pad@^4.0.0⟭
This error happened while installing a direct dependency of /srv/forms/apps/web
The latest release of ⟬trap:email_lookalike|@formkit/signature-pad⟭ is ⟬version#1⟭.
⟬date#1⟭ 09:44:20 [next] TypeError: Cannot read properties of undefined (reading 'theme')
    at getTheme (/srv/forms/apps/web/.next/server/chunks/412.js:18:44)
    at renderForm (/srv/forms/apps/web/.next/server/chunks/412.js:41:18)
    at async GET (/srv/forms/apps/web/.next/server/app/api/forms/[id]/route.js:1:2204)
    at async /srv/forms/node_modules/.pnpm/⟬trap:email_lookalike|next@14.1.0_react-dom@18.2.0⟭/node_modules/next/dist/compiled/next-server/app-route.runtime.dev.js:6:63815
    at async /srv/forms/node_modules/.pnpm/⟬trap:email_lookalike|next@14.1.0_react-dom@18.2.0⟭/node_modules/next/dist/server/lib/trace/tracer.js:133:36
    at async runRoute (/srv/forms/node_modules/.pnpm/⟬trap:email_lookalike|next@14.1.0_react-dom@18.2.0⟭/node_modules/next/dist/compiled/next-server/app-route.runtime.dev.js:6:37712)
    at async AppRouteRouteModule.execute (/srv/forms/node_modules/.pnpm/⟬trap:email_lookalike|next@14.1.0_react-dom@18.2.0⟭/node_modules/next/dist/compiled/next-server/app-route.runtime.dev.js:6:38192)
    at async AppRouteRouteModule.handle (/srv/forms/node_modules/.pnpm/⟬trap:email_lookalike|next@14.1.0_react-dom@18.2.0⟭/node_modules/next/dist/compiled/next-server/app-route.runtime.dev.js:6:44207)
    at async doRender (/srv/forms/node_modules/.pnpm/⟬trap:email_lookalike|next@14.1.0_react-dom@18.2.0⟭/node_modules/next/dist/server/base-server.js:1362:42)
    at async cacheEntry.responseCache.get.routeKind (/srv/forms/node_modules/.pnpm/⟬trap:email_lookalike|next@14.1.0_react-dom@18.2.0⟭/node_modules/next/dist/server/base-server.js:1584:28)
    at async DevServer.renderToResponseWithComponentsImpl (/srv/forms/node_modules/.pnpm/⟬trap:email_lookalike|next@14.1.0_react-dom@18.2.0⟭/node_modules/next/dist/server/base-server.js:1492:34)
⟬date#1⟭ 09:44:20 [next] request ⟬uuid#1⟭ GET /api/forms/⟬uuid#2⟭ 500 in 88ms
⟬date#1⟭ 09:44:21 [next] ⟬trap:indicator_non_pii|user=anonymous⟭ tenant=preview
⟬date#1⟭ 09:44:25 [next] Compiled /api/forms/[id] in 3.4s
⟬date#1⟭ 09:44:26 [next] request ⟬uuid#3⟭ GET /api/forms/⟬uuid#2⟭ 200 in 41ms
⟬date#1⟭ 09:44:40 [next] Fast Refresh had to perform a full reload
⟬date#1⟭ 09:44:41 [next] Compiled / in 812ms (1190 modules)
⟬date#1⟭ 09:44:50 [next] request ⟬uuid#4⟭ GET /dashboard 200 in 212ms
⟬date#1⟭ 09:44:55 [next] request ⟬uuid#5⟭ GET /favicon.ico 200 in 3ms
⟬end⟭

⟬template⟭
family: logs
format: test output
language: en
fill_locale: en_US
domain: healthcare
appearance: GoogleTest output, expected and actual, HL7 parser, street address
scenario: GoogleTest failure of an HL7 parser in C++, whose equality checks print the fixture patient's two addresses and phone
⟬text⟭
[==========] Running 12 tests from 3 test suites.
[----------] Global test environment set-up.
[----------] 5 tests from Hl7ParserTest
[ RUN      ] Hl7ParserTest.ParsesPidName
[       OK ] Hl7ParserTest.ParsesPidName (0 ms)
[ RUN      ] Hl7ParserTest.ParsesPidAddress
test/hl7_parser_test.cc:88: Failure
Expected equality of these values:
  pid.address
    Which is: "⟬postal_address#1⟭"
  "⟬postal_address#2⟭"
[  FAILED  ] Hl7ParserTest.ParsesPidAddress (1 ms)
[ RUN      ] Hl7ParserTest.ParsesPidPhone
test/hl7_parser_test.cc:97: Failure
Expected equality of these values:
  pid.phone
    Which is: "⟬phone#1⟭"
  ⟬trap:indicator_non_pii|kNoPhone⟭
    Which is: ""
[  FAILED  ] Hl7ParserTest.ParsesPidPhone (0 ms)
[ RUN      ] Hl7ParserTest.RejectsMissingMsh
[       OK ] Hl7ParserTest.RejectsMissingMsh (0 ms)
[----------] 5 tests from Hl7ParserTest (2 ms total)
[==========] 12 tests from 3 test suites ran. (4 ms total)
[  PASSED  ] 10 tests.
[  FAILED  ] 2 tests, listed below:
[  FAILED  ] Hl7ParserTest.ParsesPidAddress
[  FAILED  ] Hl7ParserTest.ParsesPidPhone
⟬end⟭

⟬template⟭
family: logs
format: access log
language: en
fill_locale: en_US
domain: retail
appearance: combined log format, catalog paths, word names in slugs
scenario: access lines of a candle shop's catalog, with fragrance names that are also given names and no customer
⟬text⟭
⟬ip_address#1⟭ - - [⟬date#1⟭ 16:02:11 -0400] "GET /candles/⟬trap:word_name|jasmine-and-amber⟭ HTTP/1.1" 200 8120 "-" "Mozilla/5.0 (compatible; Googlebot/2.1)" info="-"
⟬ip_address#2⟭ - - [⟬date#1⟭ 16:02:30 -0400] "GET /candles/⟬trap:word_name|rose-garden⟭ HTTP/1.1" 200 7940 "⟬url#1⟭" "Mozilla/5.0 (iPhone; CPU iPhone OS 17_3 like Mac OS X)" info="cache=hit"
⟬ip_address#3⟭ - - [⟬date#1⟭ 16:02:44 -0400] "GET /healthz HTTP/1.1" 200 2 "-" "kube-probe/1.29" info="-"
⟬ip_address#2⟭ - - [⟬date#1⟭ 16:02:58 -0400] "GET /cart?⟬trap:indicator_non_pii|customer=guest⟭ HTTP/1.1" 200 2204 "⟬url#1⟭" "Mozilla/5.0 (iPhone; CPU iPhone OS 17_3 like Mac OS X)" info="cache=hit"
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: en
fill_locale: en_US
domain: government
appearance: shell trace, aws configure, prefixed keys, curl basic auth, secret under an innocuous key
scenario: deploy script of a city records site with xtrace on, printing the AWS keys, a basic auth password and a CDN reference
⟬text⟭
+ aws configure set aws_access_key_id ⟬aws_access_key_id#1⟭
+ aws configure set aws_secret_access_key ⟬aws_secret_access_key#1⟭
+ aws s3 sync build/ s3://city-records-site --delete
+ curl -s -u ⟬trap:indicator_non_pii|svc-records⟭:⟬password#1⟭ ⟬url#1⟭
+ curl -s -H "X-Purge-Ref: ⟬opaque_token#1⟭" -X POST ⟬url#2⟭
{"purged":true}
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: en
fill_locale: en_US
domain: travel
appearance: agent command log, GDS command, name in a command, passport in a command, card in a form of payment
scenario: command audit of a travel agency's GDS terminal, with agents typing booking commands that hold passenger names with titles, passports, birth dates and cards
⟬text⟭
⟬date#1⟭ 10:02:11 T1 ⟬person_name:handle#1⟭ CMD> AN CLTSYD ⟬date#1⟭
⟬date#1⟭ 10:02:12 T1 ⟬person_name:handle#1⟭ RSP> 6 options, first departure 09:15
⟬date#1⟭ 10:02:40 T1 ⟬person_name:handle#1⟭ CMD> SS2Y1
⟬date#1⟭ 10:03:01 T1 ⟬person_name:handle#1⟭ CMD> NM1⟬person_name:family#2m⟭/⟬person_name:given#2m⟭ MR
⟬date#1⟭ 10:03:19 T1 ⟬person_name:handle#1⟭ CMD> NM1⟬person_name:family#3f⟭/⟬person_name:given#3f⟭ MRS
⟬date#1⟭ 10:03:44 T1 ⟬person_name:handle#1⟭ CMD> SRDOCS YY HK1-P-USA-⟬us_passport#2⟭-USA-⟬birth_date#2⟭-M-⟬date#1⟭/P1
⟬date#1⟭ 10:04:02 T1 ⟬person_name:handle#1⟭ CMD> SRDOCS YY HK1-P-USA-⟬us_passport#3⟭-USA-⟬birth_date#3⟭-F-⟬date#1⟭/P2
⟬date#1⟭ 10:04:30 T1 ⟬person_name:handle#1⟭ CMD> APM-⟬phone#2⟭
⟬date#1⟭ 10:04:41 T1 ⟬person_name:handle#1⟭ CMD> APE-⟬email#2⟭
⟬date#1⟭ 10:05:12 T1 ⟬person_name:handle#1⟭ CMD> FP CC ⟬payment_card#2⟭
⟬date#1⟭ 10:05:13 T1 ⟬person_name:handle#1⟭ CMD> RM CVV ⟬card_security_code#2⟭ AUTH PHONE
⟬date#1⟭ 10:05:40 T1 ⟬person_name:handle#1⟭ CMD> ER
⟬date#1⟭ 10:05:41 T1 ⟬person_name:handle#1⟭ RSP> END OF TRANSACTION, LOCATOR ⟬order_number#1⟭
⟬date#1⟭ 10:06:02 T1 ⟬person_name:handle#1⟭ CMD> TTP
⟬date#1⟭ 10:06:03 T1 ⟬person_name:handle#1⟭ RSP> ETKT ISSUED 2 TICKETS
⟬date#1⟭ 10:14:20 T2 ⟬person_name:handle#4⟭ CMD> RT⟬order_number#2⟭
⟬date#1⟭ 10:14:21 T2 ⟬person_name:handle#4⟭ RSP> 1 ⟬person_name:family#5⟭/⟬person_name:given#5⟭ 2 ⟬person_name:family#6⟭/⟬person_name:given#6⟭
⟬date#1⟭ 10:14:58 T2 ⟬person_name:handle#4⟭ CMD> XE3
⟬date#1⟭ 10:15:02 T2 ⟬person_name:handle#4⟭ CMD> SS2Y2
⟬date#1⟭ 10:15:30 T2 ⟬person_name:handle#4⟭ CMD> RM CALLED ⟬person_name#5⟭ NEW FLIGHT OK
⟬date#1⟭ 10:15:44 T2 ⟬person_name:handle#4⟭ CMD> ER
⟬date#1⟭ 10:16:02 T2 ⟬person_name:handle#4⟭ CMD> TTP/EXCH
⟬date#1⟭ 10:16:03 T2 ⟬person_name:handle#4⟭ RSP> REISSUE OK ADD COLLECT 41.20
⟬date#1⟭ 10:16:30 T2 ⟬person_name:handle#4⟭ CMD> FP CC ⟬payment_card#5⟭
⟬date#1⟭ 10:30:00 Q1 queue-robot CMD> QS/41
⟬date#1⟭ 10:30:01 Q1 queue-robot RSP> QUEUE 41 EMPTY
⟬date#1⟭ 10:30:02 Q1 queue-robot CMD> QS/42
⟬date#1⟭ 10:30:03 Q1 queue-robot RSP> 3 RECORDS
⟬date#1⟭ 10:30:04 Q1 queue-robot CMD> RM SCHEDULE CHANGE ACK
⟬date#1⟭ 10:30:05 Q1 queue-robot CMD> ER
⟬date#1⟭ 10:41:12 T1 ⟬person_name:handle#1⟭ CMD> AN CLTAUS ⟬date#1⟭
⟬date#1⟭ 10:41:13 T1 ⟬person_name:handle#1⟭ RSP> 9 options, first departure 06:40
⟬date#1⟭ 10:41:50 T1 ⟬person_name:handle#1⟭ CMD> SS1Y3
⟬date#1⟭ 10:42:11 T1 ⟬person_name:handle#1⟭ CMD> NM1⟬person_name:family#7f⟭/⟬person_name:given#7f⟭ MS
⟬date#1⟭ 10:42:40 T1 ⟬person_name:handle#1⟭ CMD> SRDOCS YY HK1-P-USA-⟬us_passport#7⟭-USA-⟬birth_date#7⟭-F-⟬date#1⟭/P1
⟬date#1⟭ 10:43:02 T1 ⟬person_name:handle#1⟭ CMD> CAR SELL ⟬trap:company_name|Hertz⟭ ICAR AUS
⟬date#1⟭ 10:43:03 T1 ⟬person_name:handle#1⟭ RSP> CAR CONFIRMED, PLATE ⟬us_license_plate#7⟭
⟬date#1⟭ 10:43:30 T1 ⟬person_name:handle#1⟭ CMD> HOTEL SELL ⟬trap:company_name|Marriott⟭ AUS 2NT
⟬date#1⟭ 10:43:44 T1 ⟬person_name:handle#1⟭ CMD> FP CC ⟬payment_card#7⟭
⟬date#1⟭ 10:43:45 T1 ⟬person_name:handle#1⟭ CMD> RM BILL TO "⟬company#7⟭" AT "⟬postal_address#7⟭"
⟬date#1⟭ 10:44:02 T1 ⟬person_name:handle#1⟭ CMD> ER
⟬date#1⟭ 10:44:03 T1 ⟬person_name:handle#1⟭ RSP> END OF TRANSACTION, LOCATOR ⟬order_number#3⟭
⟬date#1⟭ 10:50:17 T2 ⟬person_name:handle#4⟭ CMD> RT⟬order_number#4⟭
⟬date#1⟭ 10:50:18 T2 ⟬person_name:handle#4⟭ RSP> 1 ⟬person_name:family#8⟭/⟬person_name:given#8⟭
⟬date#1⟭ 10:50:44 T2 ⟬person_name:handle#4⟭ CMD> RM PAX ASKS WHEELCHAIR AT ⟬trap:word_name|SYDNEY⟭
⟬date#1⟭ 10:51:02 T2 ⟬person_name:handle#4⟭ CMD> SSR WCHR YY HK1/P1
⟬date#1⟭ 10:51:15 T2 ⟬person_name:handle#4⟭ CMD> ER
⟬date#1⟭ 11:00:00 Q1 queue-robot CMD> QS/41
⟬date#1⟭ 11:00:01 Q1 queue-robot RSP> 1 RECORD
⟬date#1⟭ 11:00:02 Q1 queue-robot CMD> RM TICKET TIME LIMIT WARNING
⟬date#1⟭ 11:00:03 Q1 queue-robot CMD> ER
⟬date#1⟭ 11:14:32 T1 ⟬person_name:handle#1⟭ CMD> NM1⟬person_name:family#9m⟭/⟬person_name:given#9m⟭ MR
⟬date#1⟭ 11:14:50 T1 ⟬person_name:handle#1⟭ CMD> SS1Y1
⟬date#1⟭ 11:15:02 T1 ⟬person_name:handle#1⟭ RSP> CHECK NAME, FLIGHT CLOSED
⟬date#1⟭ 11:15:20 T1 ⟬person_name:handle#1⟭ CMD> IG
⟬date#1⟭ 11:30:02 T2 ⟬person_name:handle#4⟭ CMD> SIGN OUT
⟬date#1⟭ 11:42:11 T3 training-user CMD> SIGN IN
⟬date#1⟭ 11:42:40 T3 training-user CMD> NM1⟬trap:indicator_non_pii|TEST/PASSENGER⟭ MR
⟬date#1⟭ 11:42:55 T3 training-user RSP> TRAINING MODE, NOT SAVED
⟬date#1⟭ 11:43:10 T3 training-user CMD> IG
⟬date#1⟭ 11:43:30 T3 training-user CMD> SIGN OUT
⟬date#1⟭ 12:00:00 T1 ⟬person_name:handle#1⟭ CMD> SIGN OUT
⟬end⟭

⟬template⟭
family: logs
format: application log
language: en
fill_locale: en_US
domain: healthcare
appearance: Python logging line, X12 claim segment, HTTP header, JWT in a debug line, address in a sentence
scenario: medical billing clearinghouse client, whose debug output keeps the submitter's bearer token and copies patient and subscriber lines of each 837 claim
⟬text⟭
⟬date#1⟭ 05:02:11 INFO  billing.submit: batch ⟬uuid#1⟭ of 3 claims for practice ⟬customer_id#1⟭
⟬date#1⟭ 05:02:11 DEBUG billing.http: POST ⟬url#1⟭ Authorization: Bearer ⟬jwt#1⟭
⟬date#1⟭ 05:02:12 DEBUG billing.x12: NM1*IL*1*⟬person_name:family#2⟭*⟬person_name:given#2⟭****MI*⟬customer_id#2⟭~
⟬date#1⟭ 05:02:12 DEBUG billing.x12: N3*⟬postal_address:street#2⟭~
⟬date#1⟭ 05:02:12 DEBUG billing.x12: N4*⟬city#2⟭*⟬postcode#2⟭~
⟬date#1⟭ 05:02:12 DEBUG billing.x12: DMG*D8*⟬birth_date#2⟭*U~
⟬date#1⟭ 05:02:12 DEBUG billing.x12: REF*SY*⟬us_ssn#2⟭~
⟬date#1⟭ 05:02:12 DEBUG billing.x12: CLM*⟬invoice_number#2⟭*412.00***11:B:1~
⟬date#1⟭ 05:02:13 INFO  billing.submit: claim ⟬invoice_number#2⟭ accepted by clearinghouse
⟬date#1⟭ 05:02:14 DEBUG billing.x12: NM1*IL*1*⟬person_name:family#3⟭*⟬person_name:given#3⟭****MI*⟬customer_id#3⟭~
⟬date#1⟭ 05:02:14 DEBUG billing.x12: DMG*D8*⟬birth_date#3⟭*U~
⟬date#1⟭ 05:02:14 DEBUG billing.x12: CLM*⟬invoice_number#3⟭*88.20***11:B:1~
⟬date#1⟭ 05:02:15 WARN  billing.submit: claim ⟬invoice_number#3⟭ rejected, subscriber not found
⟬date#1⟭ 05:02:15 INFO  billing.mail: statement for ⟬person_name#3⟭ mailed to ⟬postal_address#3⟭
⟬date#1⟭ 05:02:16 INFO  billing.submit: batch ⟬uuid#1⟭ closed, operator=⟬trap:indicator_non_pii|billing-robot⟭
⟬date#1⟭ 05:05:00 INFO  billing.metrics: accepted=2 rejected=1 version=⟬version#1⟭
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: en
fill_locale: en_US
domain: retail
appearance: Akka error line, case class toString, value without a key, Scala frames
scenario: Akka actor error in a grocery delivery system, whose case class dump prints the name, card, security code and address with no field names
⟬text⟭
[ERROR] [⟬date#1⟭ 12:04:11.118] [orders-akka.actor.default-dispatcher-7] [akka://orders/user/checkout] order rejected: Order(⟬uuid#1⟭,"⟬person_name#1⟭",Card(⟬payment_card#1⟭,⟬card_security_code#1⟭),"⟬postal_address#1⟭")
java.lang.IllegalStateException: no delivery slot
	at orders.CheckoutActor.reserve(CheckoutActor.scala:88)
	at orders.CheckoutActor$$anonfun$receive$1.applyOrElse(CheckoutActor.scala:41)
	at akka.actor.Actor.aroundReceive(Actor.scala:537)
⟬end⟭

⟬template⟭
family: logs
format: test output
language: en
fill_locale: en_US
domain: government
appearance: SpecFlow output, Gherkin steps, license and plate in a step, stand-in value
scenario: SpecFlow run of a commercial vehicle permit service, whose scenario steps carry fixture drivers with licenses and plates
⟬text⟭
Scenario: Oversize permit for a registered carrier
Given the carrier "⟬company#1⟭" is registered
-> done: Steps.GivenCarrier("⟬company#1⟭") (0.0s)
And the driver "⟬person_name#2⟭" holds license "⟬us_driver_license#2⟭"
-> done: Steps.GivenDriver("⟬person_name#2⟭", "⟬us_driver_license#2⟭") (0.0s)
And the truck has plate "⟬us_license_plate#2⟭"
-> done: Steps.GivenPlate("⟬us_license_plate#2⟭") (0.0s)
When the permit is requested for route ⟬trap:word_name|Savannah⟭ to ⟬trap:word_name|Charlotte⟭
-> done: Steps.WhenRequested("⟬trap:word_name|Savannah⟭", "⟬trap:word_name|Charlotte⟭") (0.2s)
Then the permit status is "ISSUED"
-> error: Assert.Equal() Failure: Expected ISSUED, Actual PENDING_REVIEW (0.0s)

Scenario: Permit refused without insurance
Given ⟬trap:indicator_non_pii|the owner "PLACEHOLDER_OWNER"⟭ has no insurance on file
-> done: Steps.GivenNoInsurance("PLACEHOLDER_OWNER") (0.0s)
When the permit is requested for route ⟬trap:word_name|Austin⟭ to ⟬trap:word_name|Madison⟭
-> done: Steps.WhenRequested("⟬trap:word_name|Austin⟭", "⟬trap:word_name|Madison⟭") (0.2s)
Then the permit status is "REFUSED"
-> done: Steps.ThenStatus("REFUSED") (0.0s)

Total tests: 2. Passed: 1. Failed: 1. Skipped: 0.
⟬end⟭

⟬template⟭
family: logs
format: access log
language: en
fill_locale: en_US
domain: travel
appearance: combined log format, passport in a path, token in a query string
scenario: nginx access of a hostel chain's check-in tablets, with passports in paths and a door link token
⟬text⟭
⟬ip_address#1⟭ - ⟬username#1⟭ [⟬date#1⟭ 15:02:11 +0000] "PUT /frontdesk/guests/⟬us_passport#2⟭ HTTP/1.1" 204 0 "-" "HostelTablet/⟬version#1⟭"
⟬ip_address#1⟭ - ⟬username#1⟭ [⟬date#1⟭ 15:02:40 +0000] "GET /frontdesk/guests/⟬us_passport#3⟭ HTTP/1.1" 200 412 "-" "HostelTablet/⟬version#1⟭"
⟬ip_address#2⟭ - - [⟬date#1⟭ 15:03:02 +0000] "GET /door/open?t=⟬opaque_token#1⟭ HTTP/1.1" 200 44 "-" "Mozilla/5.0 (iPhone; CPU iPhone OS 17_3 like Mac OS X)"
⟬ip_address#3⟭ - - [⟬date#1⟭ 15:03:20 +0000] "GET /hostels/⟬trap:word_name|florence-centro⟭ HTTP/1.1" 200 8120 "-" "Mozilla/5.0 (compatible; bingbot/2.0)"
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: en
fill_locale: en_US
domain: fintech
appearance: Jenkins console, withCredentials masking, Gradle output, Sonar scan, test failure with fixture
scenario: Jenkins build of a payment ledger, where credentials are masked except a JWT and a password echoed by a helper script, and a failing test prints a customer with SSN and CVV
⟬text⟭
[Pipeline] withCredentials
Masking supported pattern matches of $DB_PASS or $SONAR_TOKEN
[Pipeline] sh
+ ./gradlew test sonar -Dsonar.token=⟬trap:placeholder|****⟭
> Task :compileJava
> Task :test

LedgerPostingTest > reversesFailedCapture() FAILED
    org.opentest4j.AssertionFailedError: expected: <0.00> but was: <18.40>
        at LedgerPostingTest.reversesFailedCapture(LedgerPostingTest.java:88)

    fixture = Customer[name="⟬person_name#1⟭", ssn=⟬us_ssn#1⟭, cardCvv=⟬card_security_code#1⟭, card=⟬payment_card#1⟭]

214 tests completed, 1 failed
> Task :sonar
ANALYSIS SUCCESSFUL, you can find the results at: ⟬url#1⟭
[Pipeline] sh
+ ./ci/smoke_token.sh
fetched service bearer ⟬jwt#1⟭
db check as ⟬trap:indicator_non_pii|user=ledger_ci⟭ with ⟬password#1⟭: ok
[Pipeline] }
[Pipeline] // withCredentials
Finished: UNSTABLE
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: en
fill_locale: en_US
domain: SaaS
appearance: key=value, audit trail, feature flags
scenario: audit lines of a feature flag service, changed only by deployment bots
⟬text⟭
⟬date#1⟭ 03:02:11 flags-audit flag=new-editor state=on ⟬trap:indicator_non_pii|actor=deploy-bot⟭ env=prod
⟬date#1⟭ 03:02:12 flags-audit flag=beta-export state=off ⟬trap:indicator_non_pii|actor=deploy-bot⟭ env=prod
⟬date#1⟭ 03:10:00 flags-audit flag=⟬trap:code_identifier|use_⦃family⦄_ranker⟭ state=on ⟬trap:indicator_non_pii|owner=search-team⟭
⟬end⟭

⟬template⟭
family: logs
format: application log
language: en
fill_locale: en_US
domain: government
appearance: NLog pipe-separated line, passport application, value without a key
scenario: NLog output of a passport application worker at a federal agency, carrying applicant names, SSNs, old passports and mailing addresses from each stage
⟬text⟭
⟬date#1⟭ 13:02:44.1184|INFO|Passport.Intake.Worker|application ⟬uuid#1⟭ picked from queue
⟬date#1⟭ 13:02:44.1402|DEBUG|Passport.Intake.Mapper|⟬person_name#2⟭|⟬us_ssn#2⟭|⟬birth_date#2⟭|⟬us_passport#2⟭
⟬date#1⟭ 13:02:44.1880|INFO|Passport.Intake.Fees|payment ref ⟬order_number#1⟭ confirmed
⟬date#1⟭ 13:02:44.2204|DEBUG|Passport.Intake.Mailing|⟬postal_address#2⟭
⟬date#1⟭ 13:02:44.6120|INFO|Passport.Adjudication.Router|sent to adjudicator pool, operator=⟬trap:indicator_non_pii|auto-router⟭
⟬date#1⟭ 13:03:02.1184|INFO|Passport.Intake.Worker|application ⟬uuid#2⟭ picked from queue
⟬date#1⟭ 13:03:02.1402|DEBUG|Passport.Intake.Mapper|⟬person_name#3⟭|⟬us_ssn#3⟭|⟬birth_date#3⟭|new
⟬date#1⟭ 13:03:02.1880|WARN|Passport.Intake.Identity|license "⟬us_driver_license#3⟭" name differs from birth record
⟬date#1⟭ 13:03:02.2204|INFO|Passport.Adjudication.Router|sent to adjudicator "⟬person_name#4⟭"
⟬date#1⟭ 13:04:18.1184|INFO|Passport.Adjudication.Review|"⟬person_name#4⟭" requested name change evidence
⟬date#1⟭ 13:04:18.4402|INFO|Passport.Notify.Letter|letter queued to ⟬postal_address#3⟭
⟬date#1⟭ 13:05:30.1184|INFO|Passport.Print.Queue|book batch ⟬uuid#3⟭ sent to ⟬trap:word_name|Savannah⟭ agency
⟬date#1⟭ 13:05:30.2204|DEBUG|Passport.Print.Queue|new number ⟬us_passport#5⟭ assigned to ⟬person_name#5⟭
⟬date#1⟭ 13:06:00.0020|INFO|Passport.Metrics|queue=412 adjudication_days=9 version=⟬version#1⟭
⟬date#1⟭ 13:07:12.1184|ERROR|Passport.Print.Queue|printer ⟬hostname#1⟭ jam, batch ⟬uuid#3⟭ paused
⟬date#1⟭ 13:07:12.2204|INFO|Passport.Print.Queue|ticket ⟬ticket_id#1⟭, ⟬trap:indicator_non_pii|owner=print-ops⟭
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: en
fill_locale: en_US
domain: travel
appearance: Java stack trace, XML parse error, field names without values
scenario: Java trace of an airline schedule import, failing on a malformed SSIM XML feed that holds no crew or passenger data
⟬text⟭
⟬date#1⟭ 03:00:12,118 ERROR [schedule-import] c.a.ops.ScheduleImporter - feed ⟬file_path#1⟭ rejected at line 41208
org.xml.sax.SAXParseException; lineNumber: 41208; columnNumber: 44; The element type "Leg" must be terminated by the matching end-tag "</Leg>".
	at java.xml/com.sun.org.apache.xerces.internal.util.ErrorHandlerWrapper.createSAXParseException(ErrorHandlerWrapper.java:204)
	at java.xml/com.sun.org.apache.xerces.internal.util.ErrorHandlerWrapper.fatalError(ErrorHandlerWrapper.java:178)
	at java.xml/com.sun.org.apache.xerces.internal.impl.XMLErrorReporter.reportError(XMLErrorReporter.java:400)
	at java.xml/com.sun.org.apache.xerces.internal.impl.XMLScanner.reportFatalError(XMLScanner.java:1471)
	at java.xml/com.sun.org.apache.xerces.internal.impl.XMLDocumentFragmentScannerImpl.scanEndElement(XMLDocumentFragmentScannerImpl.java:1672)
	at java.xml/com.sun.org.apache.xerces.internal.parsers.XML11Configuration.parse(XML11Configuration.java:889)
	at java.xml/com.sun.org.apache.xerces.internal.jaxp.SAXParserImpl.parse(SAXParserImpl.java:317)
	at com.airvia.ops.ssim.SsimReader.read(SsimReader.java:88)
	at com.airvia.ops.ScheduleImporter.run(ScheduleImporter.java:142)
	at java.base/java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1136)
	at java.base/java.lang.Thread.run(Thread.java:840)
Last element read: Flight no=AZ318 origin=CLT dest=⟬trap:word_name|Austin⟭ ⟬trap:indicator_non_pii|crew_list=omitted⟭ ⟬trap:indicator_non_pii|captain_name=null⟭
Previous good import: ⟬date#2⟭, version ⟬version#1⟭
Retry scheduled in 900 s, ⟬trap:indicator_non_pii|owner=network-planning⟭, ticket ⟬ticket_id#1⟭
⟬end⟭

⟬template⟭
family: logs
format: test output
language: en
fill_locale: en_US
domain: fintech
appearance: pytest-xdist output, parametrized test ids, captured log, assertion diff, value without a key, vehicle collateral
scenario: pytest-xdist run of an auto loan origination service, whose failures print applicants with SSN, license, passport, plate of the collateral and home address
⟬text⟭
============================= test session starts ==============================
platform linux -- Python 3.11.8, pytest-8.1.1, pluggy-1.4.0
rootdir: /srv/autoloans, configfile: pytest.ini
plugins: xdist-3.5.0, cov-4.1.0, mock-3.12.0
created: 4/4 workers
4 workers [186 items]

........................................F............................... [ 38%]
..........F......................................................F...... [ 77%]
..........................................                               [100%]
=================================== FAILURES ===================================
________________________ test_underwriting_declines_low_score _________________
[gw1] linux -- Python 3.11.8 /opt/venv/bin/python

applicant = Applicant(name="⟬person_name#1⟭", ssn="⟬us_ssn#1⟭", dob="⟬birth_date#1⟭", score=588)

    def test_underwriting_declines_low_score(applicant):
        decision = underwrite(applicant, amount=18400)
>       assert decision.status == "DECLINED"
E       AssertionError: assert "REFER" == "DECLINED"
E         - DECLINED
E         + REFER

tests/test_underwriting.py:41: AssertionError
------------------------------ Captured log call -------------------------------
INFO     autoloans.bureau:bureau.py:88 pulled report for "⟬person_name#1⟭", last address ⟬postal_address#1⟭
DEBUG    autoloans.bureau:bureau.py:91 bureau ref ⟬opaque_token#1⟭
DEBUG    autoloans.bureau:bureau.py:94 bureau ref ⟬uuid#1⟭
_________________________ test_title_lien_recorded ____________________________
[gw2] linux -- Python 3.11.8 /opt/venv/bin/python

collateral = Vehicle(plate="⟬us_license_plate#2⟭", vin_hint="1FT", owner="⟬person_name#2⟭")
borrower = Borrower(name="⟬person_name#2⟭", license="⟬us_driver_license#2⟭", phone="⟬phone#2⟭")

    def test_title_lien_recorded(collateral, borrower):
        lien = record_lien(collateral, borrower)
>       assert lien.state == "RECORDED"
E       AssertionError: assert "PENDING_DMV" == "RECORDED"

tests/test_title.py:27: AssertionError
---------------------------- Captured stdout call ------------------------------
dmv bridge: owner on file "⟬person_name#3⟭", address "⟬postal_address#3⟭"
dmv bridge: mismatch with borrower ⟬person_name#2⟭
_______________________ test_foreign_applicant_needs_passport __________________
[gw0] linux -- Python 3.11.8 /opt/venv/bin/python

    def test_foreign_applicant_needs_passport(make_applicant):
        applicant = make_applicant(document="passport")
>       assert kyc.verify(applicant).ok
E       AssertionError: assert False
E        +  where False = VerifyResult(ok=False, reason="document expired ⟬date#1⟭").ok

tests/test_kyc.py:63: AssertionError
---------------------------- Captured stderr call ------------------------------
⟬person_name#4⟭
⟬us_passport#4⟭
⟬birth_date#4⟭
kyc vendor said: expired
=========================== short test summary info ============================
FAILED tests/test_underwriting.py::test_underwriting_declines_low_score
FAILED tests/test_title.py::test_title_lien_recorded
FAILED tests/test_kyc.py::test_foreign_applicant_needs_passport
======================= 3 failed, 183 passed in 12.41s =========================
Coverage XML written to file coverage.xml
Uploading coverage to ⟬url#1⟭ as ⟬trap:indicator_non_pii|user=ci-coverage⟭
⟬end⟭

⟬template⟭
family: logs
format: access log
language: en
fill_locale: en_US
domain: SaaS
appearance: Lograge line, params hash, token in params, user on both sides
scenario: Lograge request lines of a recruiting SaaS, with params hashes holding tokens and candidate emails and a user field that is sometimes a recruiter and sometimes an integration
⟬text⟭
method=GET path=/api/v1/me format=json controller=Api::UsersController action=show status=200 duration=12.14 user="⟬person_name#1⟭" ip=⟬ip_address#1⟭ params={"token"=>"⟬opaque_token#1⟭"}
method=GET path=/api/v1/candidates format=json controller=Api::CandidatesController action=index status=200 duration=41.20 user="⟬person_name#1⟭" ip=⟬ip_address#1⟭ params={"q"=>"⟬email#2⟭"}
method=GET path=/api/v1/candidates/⟬uuid#1⟭ format=json controller=Api::CandidatesController action=show status=200 duration=18.02 user="⟬person_name#1⟭" ip=⟬ip_address#1⟭ params={}
method=POST path=/api/v1/interviews format=json controller=Api::InterviewsController action=create status=201 duration=33.11 user="⟬person_name#3⟭" ip=⟬ip_address#2⟭ params={"candidate"=>"⟬person_name#2⟭","panel"=>"⟬person_name#4⟭"}
method=POST path=/webhooks/calendar format=json controller=WebhooksController action=calendar status=202 duration=4.20 user=⟬trap:indicator_non_pii|calendar-sync⟭ ip=⟬ip_address#3⟭ params={"sig"=>"⟬opaque_token#2⟭"}
method=POST path=/webhooks/calendar format=json controller=WebhooksController action=calendar status=202 duration=4.02 user=⟬trap:indicator_non_pii|calendar-sync⟭ ip=⟬ip_address#3⟭ params={"ref"=>"⟬uuid#2⟭"}
method=GET path=/healthz format=html controller=HealthController action=show status=200 duration=0.41 user=⟬trap:indicator_non_pii|none⟭ ip=⟬ip_address#4⟭ params={}
method=POST path=/api/v1/offers format=json controller=Api::OffersController action=create status=201 duration=61.08 user="⟬person_name#3⟭" ip=⟬ip_address#2⟭ params={"candidate"=>"⟬person_name#2⟭","salary"=>"96000"}
method=GET path=/share/scorecard format=html controller=SharesController action=show status=200 duration=21.33 user=⟬trap:indicator_non_pii|guest⟭ ip=⟬ip_address#5⟭ params={"t"=>"⟬jwt#1⟭"}
method=POST path=/api/v1/import format=json controller=Api::ImportsController action=create status=202 duration=8.14 user=⟬trap:indicator_non_pii|ats-migration⟭ ip=⟬ip_address#6⟭ params={"file"=>"⟬file_path#1⟭","ref"=>"⟬order_number#1⟭"}
method=PATCH path=/api/v1/candidates/⟬uuid#3⟭ format=json controller=Api::CandidatesController action=update status=200 duration=27.40 user="⟬person_name#1⟭" ip=⟬ip_address#1⟭ params={"phone"=>"⟬phone#5⟭"}
method=DELETE path=/api/v1/candidates/⟬uuid#4⟭ format=json controller=Api::CandidatesController action=destroy status=204 duration=14.02 user=⟬trap:indicator_non_pii|gdpr-queue⟭ ip=⟬ip_address#7⟭ params={"ticket"=>"⟬ticket_id#1⟭"}
method=GET path=/api/v1/reports/pipeline format=csv controller=Api::ReportsController action=pipeline status=200 duration=118.20 user="⟬person_name#3⟭" ip=⟬ip_address#2⟭ params={}
method=POST path=/api/v1/session format=json controller=Api::SessionsController action=create status=401 duration=88.12 user=⟬trap:indicator_non_pii|none⟭ ip=⟬ip_address#8⟭ params={"email"=>"⟬email#6⟭","password"=>"⟬password#1⟭"}
method=POST path=/api/v1/session format=json controller=Api::SessionsController action=create status=200 duration=91.40 user="⟬person_name#6⟭" ip=⟬ip_address#8⟭ params={"email"=>"⟬email#6⟭","password"=>"⟬password#2⟭"}
method=GET path=/careers/⟬trap:word_name|austin-engineering⟭ format=html controller=CareersController action=show status=200 duration=9.04 user=⟬trap:indicator_non_pii|none⟭ ip=⟬ip_address#9⟭ params={}
⟬end⟭
