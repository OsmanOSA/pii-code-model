⟬template⟭
family: logs
format: CI log
language: en
fill_locale: en_US
domain: SaaS
appearance: semantic-release output, commit analysis, scoped package names, bot author
scenario: release job of a SaaS client library with semantic-release, analysing bot commits and publishing without printing any credential or person
⟬text⟭
[semantic-release] › ℹ  Running semantic-release version ⟬version#1⟭
[semantic-release] › ✔  Loaded plugin "verifyConditions" from "⟬trap:email_lookalike|@semantic-release/npm⟭"
[semantic-release] › ✔  Loaded plugin "verifyConditions" from "⟬trap:email_lookalike|@semantic-release/github⟭"
[semantic-release] › ✔  Loaded plugin "analyzeCommits" from "⟬trap:email_lookalike|@semantic-release/commit-analyzer⟭"
[semantic-release] › ℹ  Found git tag ⟬version#2⟭ associated with version ⟬version#2⟭ on branch main
[semantic-release] › ℹ  Found 4 commits since last release
[semantic-release] [⟬trap:email_lookalike|@semantic-release/commit-analyzer⟭] › ℹ  Analyzing commit: fix: retry on 429
[semantic-release] [⟬trap:email_lookalike|@semantic-release/commit-analyzer⟭] › ℹ  The release type for the commit is patch
[semantic-release] [⟬trap:email_lookalike|@semantic-release/commit-analyzer⟭] › ℹ  Analyzing commit: chore(deps): bump undici
[semantic-release] [⟬trap:email_lookalike|@semantic-release/commit-analyzer⟭] › ℹ  ⟬trap:indicator_non_pii|Author: renovate[bot]⟭
[semantic-release] › ℹ  The next release version is ⟬version#3⟭
[semantic-release] [⟬trap:email_lookalike|@semantic-release/npm⟭] › ℹ  Write version ⟬version#3⟭ to package.json
[semantic-release] [⟬trap:email_lookalike|@semantic-release/npm⟭] › ℹ  Publishing version ⟬version#3⟭ to npm registry on dist-tag latest
[semantic-release] [⟬trap:email_lookalike|@semantic-release/npm⟭] › ℹ  NPM_TOKEN=⟬trap:placeholder|***⟭ read from the environment
+ ⟬trap:email_lookalike|@helix/client⟭ ⟬version#3⟭
[semantic-release] [⟬trap:email_lookalike|@semantic-release/github⟭] › ℹ  Published GitHub release: ⟬url#1⟭
[semantic-release] › ✔  Published release ⟬version#3⟭ on default channel
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: en
fill_locale: en_US
domain: healthcare
appearance: key=value, audit trail, medical device fleet, ward names, trap under a people field
scenario: overnight audit of a hospital's infusion pump fleet receiving firmware and drug library updates, with ward names that sound like people and no patient association
⟬text⟭
⟬date#1⟭ 01:00:12 mdm-audit device=PUMP-0412 action=CHECKIN ward=⟬trap:word_name|Rose-ward⟭ fw=⟬version#1⟭ battery=88 ⟬trap:indicator_non_pii|patient_assigned=none⟭
⟬date#1⟭ 01:00:13 mdm-audit device=PUMP-0413 action=CHECKIN ward=⟬trap:word_name|Rose-ward⟭ fw=⟬version#1⟭ battery=91 ⟬trap:indicator_non_pii|patient_assigned=none⟭
⟬date#1⟭ 01:00:14 mdm-audit device=PUMP-0414 action=CHECKIN ward=⟬trap:word_name|Rose-ward⟭ fw=⟬version#2⟭ battery=76 ⟬trap:indicator_non_pii|patient_assigned=none⟭
⟬date#1⟭ 01:00:15 mdm-audit device=PUMP-0515 action=CHECKIN ward=⟬trap:word_name|Grace-unit⟭ fw=⟬version#1⟭ battery=64 ⟬trap:indicator_non_pii|patient_assigned=none⟭
⟬date#1⟭ 01:00:16 mdm-audit device=PUMP-0516 action=CHECKIN ward=⟬trap:word_name|Grace-unit⟭ fw=⟬version#1⟭ battery=97 ⟬trap:indicator_non_pii|patient_assigned=none⟭
⟬date#1⟭ 01:00:17 mdm-audit device=PUMP-0517 action=SKIP ward=⟬trap:word_name|Grace-unit⟭ reason=in_use ⟬trap:indicator_non_pii|operator=mdm-scheduler⟭
⟬date#1⟭ 01:00:18 mdm-audit device=PUMP-0618 action=CHECKIN ward=⟬trap:word_name|Ivy-pavilion⟭ fw=⟬version#2⟭ battery=83 ⟬trap:indicator_non_pii|patient_assigned=none⟭
⟬date#1⟭ 01:00:19 mdm-audit device=PUMP-0619 action=CHECKIN ward=⟬trap:word_name|Ivy-pavilion⟭ fw=⟬version#1⟭ battery=52 ⟬trap:indicator_non_pii|patient_assigned=none⟭
⟬date#1⟭ 01:00:20 mdm-audit device=PUMP-0620 action=CHECKIN ward=⟬trap:word_name|Ivy-pavilion⟭ fw=⟬version#1⟭ battery=70 ⟬trap:indicator_non_pii|patient_assigned=none⟭
⟬date#1⟭ 01:02:00 mdm-audit job=⟬uuid#1⟭ action=FW_CAMPAIGN_START target=⟬version#3⟭ devices=8 ⟬trap:indicator_non_pii|owner=clinical-engineering⟭
⟬date#1⟭ 01:02:01 mdm-audit job=⟬uuid#1⟭ action=PACKAGE_VERIFY sha=⟬hash#1⟭ signer=⟬trap:indicator_non_pii|vendor-release-key⟭ result=ok
⟬date#1⟭ 01:02:30 mdm-audit device=PUMP-0412 action=FW_UPDATE from=⟬version#1⟭ to=⟬version#3⟭ result=ok duration_s=28
⟬date#1⟭ 01:03:01 mdm-audit device=PUMP-0413 action=FW_UPDATE from=⟬version#1⟭ to=⟬version#3⟭ result=ok duration_s=29
⟬date#1⟭ 01:03:33 mdm-audit device=PUMP-0414 action=FW_UPDATE from=⟬version#2⟭ to=⟬version#3⟭ result=ok duration_s=31
⟬date#1⟭ 01:04:06 mdm-audit device=PUMP-0515 action=FW_UPDATE from=⟬version#1⟭ to=⟬version#3⟭ result=retry reason=low_signal
⟬date#1⟭ 01:04:40 mdm-audit device=PUMP-0515 action=FW_UPDATE from=⟬version#1⟭ to=⟬version#3⟭ result=ok duration_s=33
⟬date#1⟭ 01:05:13 mdm-audit device=PUMP-0516 action=FW_UPDATE from=⟬version#1⟭ to=⟬version#3⟭ result=ok duration_s=28
⟬date#1⟭ 01:05:45 mdm-audit device=PUMP-0618 action=FW_UPDATE from=⟬version#2⟭ to=⟬version#3⟭ result=ok duration_s=30
⟬date#1⟭ 01:06:17 mdm-audit device=PUMP-0619 action=FW_UPDATE from=⟬version#1⟭ to=⟬version#3⟭ result=ok duration_s=27
⟬date#1⟭ 01:06:50 mdm-audit device=PUMP-0620 action=FW_UPDATE from=⟬version#1⟭ to=⟬version#3⟭ result=failed reason=flash_verify
⟬date#1⟭ 01:06:51 mdm-audit device=PUMP-0620 action=ROLLBACK to=⟬version#1⟭ result=ok
⟬date#1⟭ 01:06:52 mdm-audit device=PUMP-0620 action=TICKET ref=⟬ticket_id#1⟭ ⟬trap:indicator_non_pii|assignee=biomed-queue⟭
⟬date#1⟭ 01:07:00 mdm-audit job=⟬uuid#1⟭ action=FW_CAMPAIGN_END ok=7 failed=1 skipped=1
⟬date#1⟭ 01:10:00 mdm-audit job=⟬uuid#2⟭ action=LIBRARY_PUSH_START library=⟬version#4⟭ devices=8 ⟬trap:indicator_non_pii|approved_by=pharmacy-committee⟭
⟬date#1⟭ 01:10:01 mdm-audit job=⟬uuid#2⟭ action=LIBRARY_DIFF added=14 changed=31 removed=2 checksum=⟬hash#2⟭
⟬date#1⟭ 01:10:20 mdm-audit device=PUMP-0412 action=LIBRARY_APPLY library=⟬version#4⟭ result=ok
⟬date#1⟭ 01:10:21 mdm-audit device=PUMP-0413 action=LIBRARY_APPLY library=⟬version#4⟭ result=ok
⟬date#1⟭ 01:10:22 mdm-audit device=PUMP-0414 action=LIBRARY_APPLY library=⟬version#4⟭ result=ok
⟬date#1⟭ 01:10:23 mdm-audit device=PUMP-0515 action=LIBRARY_APPLY library=⟬version#4⟭ result=ok
⟬date#1⟭ 01:10:24 mdm-audit device=PUMP-0516 action=LIBRARY_APPLY library=⟬version#4⟭ result=ok
⟬date#1⟭ 01:10:25 mdm-audit device=PUMP-0618 action=LIBRARY_APPLY library=⟬version#4⟭ result=ok
⟬date#1⟭ 01:10:26 mdm-audit device=PUMP-0619 action=LIBRARY_APPLY library=⟬version#4⟭ result=ok
⟬date#1⟭ 01:10:27 mdm-audit device=PUMP-0620 action=LIBRARY_APPLY library=⟬version#4⟭ result=deferred reason=rollback
⟬date#1⟭ 01:11:00 mdm-audit job=⟬uuid#2⟭ action=LIBRARY_PUSH_END ok=7 deferred=1
⟬date#1⟭ 02:00:00 mdm-audit action=CERT_RENEW scope=fleet client_secret=⟬trap:placeholder|<vault:mdm/client>⟭ ⟬trap:indicator_non_pii|token_ttl_hours=12⟭
⟬date#1⟭ 02:00:03 mdm-audit action=CERT_RENEW result=ok fingerprint=⟬hash#3⟭
⟬date#1⟭ 02:15:00 mdm-audit action=ALARM_POLICY_SYNC policy=⟬version#5⟭ ⟬trap:indicator_non_pii|owner=nursing-informatics⟭ devices=9
⟬date#1⟭ 02:15:02 mdm-audit action=ALARM_POLICY_SYNC result=ok
⟬date#1⟭ 02:30:00 mdm-audit action=NETWORK_SCAN subnet=biomed-vlan found=9 unknown=0 ⟬trap:indicator_non_pii|user=network-scanner⟭
⟬date#1⟭ 03:00:00 mdm-audit device=PUMP-0517 action=CHECKIN ward=⟬trap:word_name|Grace-unit⟭ fw=⟬version#1⟭ battery=44 ⟬trap:indicator_non_pii|patient_assigned=none⟭
⟬date#1⟭ 03:00:31 mdm-audit device=PUMP-0517 action=FW_UPDATE from=⟬version#1⟭ to=⟬version#3⟭ result=ok duration_s=29
⟬date#1⟭ 03:00:50 mdm-audit device=PUMP-0517 action=LIBRARY_APPLY library=⟬version#4⟭ result=ok
⟬date#1⟭ 03:30:00 mdm-audit action=COMPLIANCE_SNAPSHOT compliant=8 pending=1 report=⟬file_path#1⟭
⟬date#1⟭ 03:30:01 mdm-audit action=COMPLIANCE_UPLOAD dest=⟬url#1⟭ result=ok
⟬date#1⟭ 04:00:00 mdm-audit device=PUMP-0620 action=SELFTEST result=ok battery=68
⟬date#1⟭ 04:00:30 mdm-audit device=PUMP-0620 action=FW_UPDATE from=⟬version#1⟭ to=⟬version#3⟭ result=ok duration_s=36
⟬date#1⟭ 04:00:50 mdm-audit device=PUMP-0620 action=LIBRARY_APPLY library=⟬version#4⟭ result=ok
⟬date#1⟭ 04:01:00 mdm-audit device=PUMP-0620 action=TICKET_CLOSE ref=⟬ticket_id#1⟭ ⟬trap:indicator_non_pii|closed_by=mdm-scheduler⟭
⟬date#1⟭ 05:00:00 mdm-audit action=COMPLIANCE_SNAPSHOT compliant=9 pending=0 report=⟬file_path#2⟭
⟬date#1⟭ 05:00:01 mdm-audit action=COMPLIANCE_UPLOAD dest=⟬url#1⟭ result=ok
⟬date#1⟭ 05:30:00 mdm-audit action=BATTERY_REPORT below_50=1 ward=⟬trap:word_name|Grace-unit⟭
⟬date#1⟭ 05:45:00 mdm-audit action=DRUG_LIBRARY_NOTICE recipients=⟬trap:indicator_non_pii|role:charge-nurses⟭ channel=pager
⟬date#1⟭ 06:00:00 mdm-audit device=PUMP-0412 action=UNLOCK ⟬trap:indicator_non_pii|operator=shift-start⟭ ward=⟬trap:word_name|Rose-ward⟭
⟬date#1⟭ 06:00:01 mdm-audit device=PUMP-0413 action=UNLOCK ⟬trap:indicator_non_pii|operator=shift-start⟭ ward=⟬trap:word_name|Rose-ward⟭
⟬date#1⟭ 06:00:02 mdm-audit device=PUMP-0414 action=UNLOCK ⟬trap:indicator_non_pii|operator=shift-start⟭ ward=⟬trap:word_name|Rose-ward⟭
⟬date#1⟭ 06:00:03 mdm-audit device=PUMP-0515 action=UNLOCK ⟬trap:indicator_non_pii|operator=shift-start⟭ ward=⟬trap:word_name|Grace-unit⟭
⟬date#1⟭ 06:00:04 mdm-audit device=PUMP-0516 action=UNLOCK ⟬trap:indicator_non_pii|operator=shift-start⟭ ward=⟬trap:word_name|Grace-unit⟭
⟬date#1⟭ 06:00:05 mdm-audit device=PUMP-0517 action=UNLOCK ⟬trap:indicator_non_pii|operator=shift-start⟭ ward=⟬trap:word_name|Grace-unit⟭
⟬date#1⟭ 06:00:06 mdm-audit device=PUMP-0618 action=UNLOCK ⟬trap:indicator_non_pii|operator=shift-start⟭ ward=⟬trap:word_name|Ivy-pavilion⟭
⟬date#1⟭ 06:00:07 mdm-audit device=PUMP-0619 action=UNLOCK ⟬trap:indicator_non_pii|operator=shift-start⟭ ward=⟬trap:word_name|Ivy-pavilion⟭
⟬date#1⟭ 06:00:08 mdm-audit device=PUMP-0620 action=UNLOCK ⟬trap:indicator_non_pii|operator=shift-start⟭ ward=⟬trap:word_name|Ivy-pavilion⟭
⟬date#1⟭ 06:05:00 mdm-audit action=NIGHT_SUMMARY updated=9 failures=1 rollback=1 version=⟬version#6⟭
⟬date#1⟭ 06:05:01 mdm-audit action=SEGMENT_SEAL chain=⟬trap:eponym|Merkle⟭ root=⟬hash#4⟭
⟬end⟭

⟬template⟭
family: logs
format: application log
language: en
fill_locale: en_US
domain: travel
appearance: Logback line, SOAP envelope, XML element, CDATA, card in XML, passport in XML
scenario: travel agency booking engine logging full SOAP exchanges with an airline reservation system, including the session password in CDATA and a passenger's passport and card
⟬text⟭
⟬date#1⟭ 13:04:11.204 INFO  [gds-1] c.t.gds.SessionPool - pool empty, opening session on ⟬url#1⟭
⟬date#1⟭ 13:04:11.206 DEBUG [gds-1] c.t.gds.SoapClient - >>> SessionCreate
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Header>
    <Security>
      <Username>⟬trap:indicator_non_pii|OTA_PROD⟭</Username>
      <Password><![CDATA[⟬password#1⟭]]></Password>
      <Organization>AGENCY7</Organization>
    </Security>
  </soap:Header>
  <soap:Body><SessionCreateRQ/></soap:Body>
</soap:Envelope>
⟬date#1⟭ 13:04:11.640 DEBUG [gds-1] c.t.gds.SoapClient - <<< SessionCreateRS 200
<SessionCreateRS><BinarySecurityToken>⟬opaque_token#1⟭</BinarySecurityToken><ConversationId>⟬uuid#1⟭</ConversationId></SessionCreateRS>
⟬date#1⟭ 13:04:11.642 INFO  [gds-1] c.t.gds.SessionPool - session ⟬uuid#1⟭ ready
⟬date#1⟭ 13:04:12.118 INFO  [booking-3] c.t.booking.PnrService - creating booking for cart ⟬order_number#1⟭
⟬date#1⟭ 13:04:12.120 DEBUG [booking-3] c.t.gds.SoapClient - >>> CreatePassengerNameRecord
<CreatePassengerNameRecordRQ>
  <TravelItineraryAddInfo>
    <CustomerInfo>
      <PersonName><GivenName>⟬person_name:given#2⟭</GivenName><Surname>⟬person_name:family#2⟭</Surname></PersonName>
      <ContactNumber>⟬phone#2⟭</ContactNumber>
      <Email>⟬email#2⟭</Email>
    </CustomerInfo>
  </TravelItineraryAddInfo>
  <SpecialReqDetails>
    <AdvancePassenger>
      <Document Type="P" Number="⟬us_passport#2⟭" ExpirationDate="⟬date#1⟭" IssueCountry="US"/>
      <PersonName DateOfBirth="⟬birth_date#2⟭" Gender="U"/>
    </AdvancePassenger>
  </SpecialReqDetails>
  <Payment>
    <CardNumber>⟬payment_card#2⟭</CardNumber>
    <SecurityCode>⟬card_security_code#2⟭</SecurityCode>
    <BillingAddress><Street>⟬postal_address:street#2⟭</Street><City>⟬city#2⟭</City><PostalCode>⟬postcode#2⟭</PostalCode></BillingAddress>
  </Payment>
</CreatePassengerNameRecordRQ>
⟬date#1⟭ 13:04:13.402 WARN  [booking-3] c.t.gds.SoapClient - <<< CreatePassengerNameRecordRS 200 with warning: seat request not honored
⟬date#1⟭ 13:04:13.404 INFO  [booking-3] c.t.booking.PnrService - booking ⟬uuid#2⟭ confirmed, record locator withheld by policy
⟬date#1⟭ 13:04:13.410 INFO  [booking-3] c.t.notify.Mailer - itinerary queued for ⟬email#2⟭
⟬date#1⟭ 13:04:13.412 DEBUG [booking-3] c.t.gds.SoapClient - <<< TravelItineraryReadRS
<TravelItineraryReadRS>
  <Ticketing TimeLimit="⟬date#1⟭"/>
  <Remark>Frequent flyer ⟬customer_id#2⟭, seat preference aisle</Remark>
  <Remark>Contact ⟬person_name#2⟭ at ⟬phone#2⟭ before departure</Remark>
</TravelItineraryReadRS>
⟬date#1⟭ 13:04:40.002 INFO  [booking-1] c.t.booking.PnrService - creating booking for cart ⟬order_number#2⟭
⟬date#1⟭ 13:04:40.004 DEBUG [booking-1] c.t.gds.SoapClient - >>> CreatePassengerNameRecord
<CreatePassengerNameRecordRQ>
  <CustomerInfo><PersonName><GivenName>⟬person_name:given#3⟭</GivenName><Surname>⟬person_name:family#3⟭</Surname></PersonName></CustomerInfo>
  <AdvancePassenger><Document Type="P" Number="⟬us_passport#3⟭" IssueCountry="US"/></AdvancePassenger>
  <Payment><Agency Reference="⟬invoice_number#1⟭"/></Payment>
</CreatePassengerNameRecordRQ>
⟬date#1⟭ 13:04:40.812 ERROR [booking-1] c.t.gds.SoapClient - <<< SOAP Fault code=INVALID_DOCUMENT passenger index 0
⟬date#1⟭ 13:04:40.815 INFO  [booking-1] c.t.booking.PnrService - cart ⟬order_number#2⟭ returned to agent, ⟬trap:indicator_non_pii|owner=corporate-desk⟭
⟬date#1⟭ 13:05:02.118 INFO  [corp-api] c.t.corporate.PolicyCheck - traveler "⟬person_name#3⟭" over hotel cap in ⟬trap:word_name|Sydney⟭, approver "⟬person_name#4⟭" notified
⟬date#1⟭ 13:05:02.120 INFO  [corp-api] c.t.corporate.PolicyCheck - fare class Y within policy, ⟬trap:indicator_non_pii|approver=auto-policy⟭ for domestic legs
⟬date#1⟭ 13:06:11.002 INFO  [gds-2] c.t.gds.SessionPool - session ⟬uuid#1⟭ idle 120s, keep-alive
⟬date#1⟭ 13:06:11.204 DEBUG [gds-2] c.t.gds.SoapClient - >>> OTA_PingRQ
<OTA_PingRQ><EchoData>keepalive</EchoData></OTA_PingRQ>
⟬date#1⟭ 13:06:11.401 DEBUG [gds-2] c.t.gds.SoapClient - <<< OTA_PingRS 200
⟬date#1⟭ 13:08:00.002 INFO  [metrics] c.t.gds.Stats - sessions=1 faults=1 latency_p95_ms=840 version=⟬version#1⟭
⟬date#1⟭ 13:09:00.002 INFO  [metrics] c.t.gds.Stats - sessions=1 faults=0 latency_p95_ms=412 version=⟬version#1⟭
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: en
fill_locale: en_US
domain: fintech
appearance: Elixir GenServer crash, last message, state dump, supervisor report
scenario: Elixir GenServer crash in a payment orchestrator, whose report prints the last message with the card and the process state with SSN and session value
⟬text⟭
⟬date#1⟭ 12:44:02.118 [error] GenServer Payments.ChargeWorker terminating
** (MatchError) no match of right hand side value: {:error, :issuer_unavailable}
    (payments 1.4.2) lib/payments/charge_worker.ex:88: Payments.ChargeWorker.handle_cast/2
    (stdlib 5.2) gen_server.erl:1095: :gen_server.try_handle_cast/3
    (stdlib 5.2) gen_server.erl:1183: :gen_server.handle_msg/6
    (stdlib 5.2) proc_lib.erl:241: :proc_lib.init_p_do_apply/3
Last message: {:"$gen_cast", {:charge, %{amount: 8420, card: "⟬payment_card#1⟭", cvc: "⟬card_security_code#1⟭", holder: "⟬person_name#1⟭"}}}
State: %{attempts: 3, customer_id: "⟬customer_id#1⟭", session: "⟬opaque_token#1⟭", ssn: "⟬us_ssn#1⟭"}

⟬date#1⟭ 12:44:02.121 [error] Child Payments.ChargeWorker of Supervisor Payments.WorkerSupervisor terminated
** (exit) an exception was raised:
    ** (MatchError) no match of right hand side value: {:error, :issuer_unavailable}
        (payments 1.4.2) lib/payments/charge_worker.ex:88: Payments.ChargeWorker.handle_cast/2
Pid: #PID<0.4120.0>
Start Call: Payments.ChargeWorker.start_link([customer: "⟬customer_id#1⟭"])
Restart: :transient
Shutdown: 5000
Type: :worker
⟬end⟭

⟬template⟭
family: logs
format: test output
language: en
fill_locale: en_US
domain: SaaS
appearance: Minitest output, JSON response body, secret under an innocuous key, test name with a code identifier
scenario: Minitest run of a scheduling SaaS, where a failed invitation test prints the response body with the invite code and an API test prints a bearer value
⟬text⟭
Run options: --seed 41822

# Running:

....F........E..

Finished in 3.204118s, 4.9935 runs/s, 11.2356 assertions/s.

Failure:
InvitationsControllerTest#test_accepts_invite [test/controllers/invitations_controller_test.rb:44]:
Expected response to be a <2XX: success>, but was a <422: Unprocessable Entity>
Response body: {"error":"expired","invite":{"email":"⟬email#1⟭","inviter":"⟬person_name#2⟭","ref":"⟬opaque_token#1⟭","sent_at":"⟬date#1⟭"}}

rails test test/controllers/invitations_controller_test.rb:39

Error:
ApiKeysControllerTest#⟬trap:code_identifier|test_⦃family⦄_webhook_signature⟭:
RuntimeError: unexpected header Authorization: Bearer ⟬opaque_token#2⟭
    app/controllers/api_keys_controller.rb:31:in `verify_signature'
    test/controllers/api_keys_controller_test.rb:27:in `block in <class:ApiKeysControllerTest>'

rails test test/controllers/api_keys_controller_test.rb:22

16 runs, 36 assertions, 1 failures, 1 errors, 0 skips
⟬end⟭

⟬template⟭
family: logs
format: access log
language: en
fill_locale: en_US
domain: healthcare
appearance: combined log format, public health pages, eponym in a slug
scenario: access lines of a public drug formulary and condition pages, crawled by bots with no patient reference
⟬text⟭
⟬ip_address#1⟭ - - [⟬date#1⟭ 11:02:04 -0500] "GET /formulary?drug=metformin HTTP/1.1" 200 4120 "-" "Mozilla/5.0 (compatible; Googlebot/2.1)" ctx="-"
⟬ip_address#1⟭ - - [⟬date#1⟭ 11:02:09 -0500] "GET /conditions/⟬trap:eponym|alzheimers-disease⟭ HTTP/1.1" 200 8120 "-" "Mozilla/5.0 (compatible; Googlebot/2.1)" ctx="-"
⟬ip_address#2⟭ - - [⟬date#1⟭ 11:02:31 -0500] "GET /find-a-pharmacy?zip=⟬postcode#1⟭&⟬trap:indicator_non_pii|member_id=none⟭ HTTP/1.1" 200 2204 "-" "Mozilla/5.0 (iPhone; CPU iPhone OS 17_3 like Mac OS X)" ctx="cache=miss"
⟬ip_address#3⟭ - - [⟬date#1⟭ 11:03:05 -0500] "GET /healthz HTTP/1.1" 200 2 "-" "kube-probe/1.29" ctx="-"
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: en
fill_locale: en_US
domain: retail
appearance: docker buildx output, build-arg, layer history, shell trace, secret under an innocuous key
scenario: GitLab build of a loyalty app image, passing a database password and API secrets as build arguments that reappear in the layer output and a smoke test against a staging profile
⟬text⟭
$ docker buildx build --progress=plain --build-arg DB_PASSWORD=⟬password#1⟭ --build-arg LOYALTY_API_TOKEN=⟬opaque_token#1⟭ --build-arg REF=⟬git_sha#1⟭ -t ⟬hostname#1⟭/loyalty/web:⟬version#1⟭ .
#0 building with "default" instance using docker driver

#1 [internal] load build definition from Dockerfile
#1 transferring dockerfile: 1.12kB done
#1 DONE 0.0s

#2 [internal] load metadata for docker.io/library/node:20-alpine
#2 DONE 0.8s

#3 [internal] load .dockerignore
#3 transferring context: 214B done
#3 DONE 0.0s

#4 [build 1/6] FROM docker.io/library/node:20-alpine
#4 CACHED

#5 [internal] load build context
#5 transferring context: 88.12MB 1.4s done
#5 DONE 1.5s

#6 [build 2/6] WORKDIR /app
#6 CACHED

#7 [build 3/6] COPY package*.json ./
#7 DONE 0.2s

#8 [build 4/6] RUN npm ci
#8 12.41 added 1204 packages in 12s
#8 DONE 13.1s

#9 [build 5/6] COPY . .
#9 DONE 2.3s

#10 [build 6/6] RUN DB_PASSWORD=⟬password#1⟭ LOYALTY_API_TOKEN=⟬opaque_token#1⟭ npm run build
#10 3.118 > ⟬trap:email_lookalike|loyalty-web@1.0.0⟭ build
#10 3.120 > next build
#10 31.402 ✓ Compiled successfully
#10 41.204 Route (app)                              Size     First Load JS
#10 41.206 ┌ ○ /                                    5.2 kB         112 kB
#10 41.207 ├ ○ /rewards                             3.1 kB         110 kB
#10 41.208 └ ○ /account                             2.8 kB         109 kB
#10 DONE 42.0s

#11 exporting to image
#11 exporting layers 1.2s done
#11 writing image sha256:⟬hash#1⟭ done
#11 naming to ⟬hostname#1⟭/loyalty/web:⟬version#1⟭ done
#11 DONE 1.3s
$ docker history --no-trunc ⟬hostname#1⟭/loyalty/web:⟬version#1⟭ | head -2
CREATED BY
RUN |3 DB_PASSWORD=⟬password#1⟭ LOYALTY_API_TOKEN=⟬opaque_token#1⟭ REF=⟬git_sha#1⟭ /bin/sh -c npm run build
$ curl -sS -H "Authorization: Bearer ⟬jwt#1⟭" ⟬url#1⟭ | jq .
{
  "member": "⟬customer_id#2⟭",
  "name": "⟬person_name#2⟭",
  "tier": "gold",
  "home_store": "⟬trap:word_name|Savannah⟭",
  "mail_to": "⟬postal_address#2⟭",
  "vehicle_for_pickup": "⟬us_license_plate#2⟭"
}
Job succeeded
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: en
fill_locale: en_US
domain: government
appearance: key=value, audit trail, quoted value, plain sentence
scenario: audit of a housing assistance case system, where a caseworker verifies an applicant's SSN and address and reassigns the case
⟬text⟭
⟬date#1⟭ 10:02:14 case-audit worker="⟬person_name#1⟭" case=⟬ticket_id#1⟭ action=VERIFY_SSN value=⟬us_ssn#2⟭ result=match
⟬date#1⟭ 10:03:02 case-audit worker="⟬person_name#1⟭" case=⟬ticket_id#1⟭ action=VERIFY_ADDRESS value="⟬postal_address#2⟭" source=utility-bill
⟬date#1⟭ 10:04:40 case-audit worker="⟬person_name#1⟭" case=⟬ticket_id#1⟭ action=REASSIGN from=⟬trap:indicator_non_pii|intake-pool⟭ to="⟬person_name#3⟭"
⟬date#1⟭ 10:04:41 case-audit worker=⟬trap:indicator_non_pii|notify-bot⟭ case=⟬ticket_id#1⟭ action=NOTICE sent to ⟬person_name#2⟭ at ⟬email#2⟭
⟬date#1⟭ 10:31:20 case-audit worker="⟬person_name#3⟭" case=⟬ticket_id#1⟭ action=VERIFY_DL value=⟬us_driver_license#2⟭ result=match
⟬end⟭

⟬template⟭
family: logs
format: application log
language: en
fill_locale: en_US
domain: fintech
appearance: Celery task log, task arguments, Python dict repr, card without a key, chargeback
scenario: Celery workers of a merchant acquirer processing chargebacks, with task arguments that print cards and security codes, and a retry on a bank file
⟬text⟭
[⟬date#1⟭ 04:00:02,118: INFO/MainProcess] Task chargebacks.ingest[⟬uuid#1⟭] received
[⟬date#1⟭ 04:00:02,204: INFO/ForkPoolWorker-2] chargebacks.ingest[⟬uuid#1⟭]: reading ⟬file_path#1⟭, 18 cases
[⟬date#1⟭ 04:00:02,611: INFO/MainProcess] Task chargebacks.match[⟬uuid#2⟭] received: args=["⟬payment_card#2⟭", "⟬order_number#2⟭"] kwargs={"amount": 84.20}
[⟬date#1⟭ 04:00:02,640: DEBUG/ForkPoolWorker-3] chargebacks.match[⟬uuid#2⟭]: lookup by pan, merchant "⟬company#2⟭"
[⟬date#1⟭ 04:00:02,702: INFO/ForkPoolWorker-3] chargebacks.match[⟬uuid#2⟭] succeeded in 0.09s: {"status": "matched", "dispute": "⟬ticket_id#1⟭"}
[⟬date#1⟭ 04:00:03,118: INFO/MainProcess] Task chargebacks.match[⟬uuid#3⟭] received: args=["⟬payment_card#3⟭", "⟬order_number#3⟭"] kwargs={"amount": 412.00}
[⟬date#1⟭ 04:00:03,160: WARNING/ForkPoolWorker-1] chargebacks.match[⟬uuid#3⟭]: no authorization found for cardholder "⟬person_name#3⟭"
[⟬date#1⟭ 04:00:03,204: INFO/MainProcess] Task chargebacks.reauth[⟬uuid#4⟭] received: args=[] kwargs={"f2": "⟬payment_card#3⟭", "f48": "⟬card_security_code#3⟭"}
[⟬date#1⟭ 04:00:03,901: ERROR/ForkPoolWorker-1] Task chargebacks.reauth[⟬uuid#4⟭] raised unexpected: IssuerTimeout("no response in 5000 ms")
[⟬date#1⟭ 04:00:03,905: INFO/ForkPoolWorker-1] Task chargebacks.reauth[⟬uuid#4⟭] retry: Retry in 60s
[⟬date#1⟭ 04:00:04,118: INFO/ForkPoolWorker-2] chargebacks.ingest[⟬uuid#1⟭]: operator=⟬trap:indicator_non_pii|cb-ingest⟭, 16 cases queued
[⟬date#1⟭ 04:00:04,204: INFO/ForkPoolWorker-2] Task chargebacks.ingest[⟬uuid#1⟭] succeeded in 2.0s: 16
[⟬date#1⟭ 04:01:03,905: INFO/MainProcess] Task chargebacks.reauth[⟬uuid#4⟭] received, ETA reached
[⟬date#1⟭ 04:01:04,512: INFO/ForkPoolWorker-4] Task chargebacks.reauth[⟬uuid#4⟭] succeeded in 0.6s: {"approved": false, "code": "14"}
[⟬date#1⟭ 04:01:05,000: INFO/ForkPoolWorker-4] chargebacks.letters: letter to "⟬person_name#3⟭" ref ⟬ticket_id#2⟭
[⟬date#1⟭ 04:05:00,002: INFO/Beat] Scheduler: Sending due task chargebacks.metrics
[⟬date#1⟭ 04:05:00,120: INFO/ForkPoolWorker-1] chargebacks.metrics: open=412 won=88 lost=41 version=⟬version#1⟭
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: en
fill_locale: en_US
domain: SaaS
appearance: Sidekiq JSON line, job arguments, Ruby backtrace, password in job arguments, JWT in job arguments
scenario: Sidekiq failure of a CRM's contact sync, whose JSON error line prints job arguments with an OAuth JWT and an IMAP password
⟬text⟭
{"ts":"⟬date#1⟭ 03:12:44","pid":118,"tid":"a1c","lvl":"WARN","ctx":"Job raised exception","job":{"class":"SyncMailboxJob","args":["⟬customer_id#1⟭","⟬email#2⟭","⟬password#1⟭"],"retry":true,"queue":"default","jid":"⟬hash#1⟭"},"error":"Net::IMAP::NoResponseError: invalid credentials"}
{"ts":"⟬date#1⟭ 03:12:44","pid":118,"tid":"a1c","lvl":"WARN","ctx":"Job raised exception","job":{"class":"SyncContactsJob","args":["⟬customer_id#1⟭","⟬jwt#1⟭",{"ref":"⟬opaque_token#1⟭"}],"retry":true,"queue":"default","jid":"⟬hash#2⟭"},"error":"Faraday::UnauthorizedError: 401"}
⟬date#1⟭ 03:12:44 WARN: Net::IMAP::NoResponseError: invalid credentials
/app/vendor/bundle/ruby/3.2.0/gems/net-imap-0.4.9/lib/net/imap.rb:2783:in `get_tagged_response'
/app/vendor/bundle/ruby/3.2.0/gems/net-imap-0.4.9/lib/net/imap.rb:2966:in `block in send_command'
/app/vendor/bundle/ruby/3.2.0/gems/net-imap-0.4.9/lib/net/imap.rb:1321:in `login'
/app/app/services/mailbox_connector.rb:41:in `connect'
/app/app/jobs/sync_mailbox_job.rb:18:in `perform'
/app/vendor/bundle/ruby/3.2.0/gems/sidekiq-7.2.1/lib/sidekiq/processor.rb:202:in `execute_job'
/app/vendor/bundle/ruby/3.2.0/gems/sidekiq-7.2.1/lib/sidekiq/processor.rb:170:in `block (2 levels) in process'
/app/vendor/bundle/ruby/3.2.0/gems/sidekiq-7.2.1/lib/sidekiq/middleware/chain.rb:180:in `invoke'
/app/vendor/bundle/ruby/3.2.0/gems/sidekiq-7.2.1/lib/sidekiq/processor.rb:145:in `process'
/app/vendor/bundle/ruby/3.2.0/gems/sidekiq-7.2.1/lib/sidekiq/processor.rb:86:in `process_one'
/app/vendor/bundle/ruby/3.2.0/gems/sidekiq-7.2.1/lib/sidekiq/component.rb:10:in `watchdog'
retry in 25s, retry_count=3, ⟬trap:indicator_non_pii|owner=integrations-squad⟭
⟬date#1⟭ 03:12:45 INFO: retries nearly exhausted for jid ⟬hash#1⟭, notifying ⟬email:generic#3⟭
⟬date#1⟭ 03:13:09 INFO: SyncContactsJob jid ⟬hash#2⟭ retry 4 scheduled
⟬end⟭

⟬template⟭
family: logs
format: test output
language: en
fill_locale: en_US
domain: healthcare
appearance: Jest snapshot diff, address block, value without a key
scenario: Jest snapshot failure of a pharmacy label printer, whose diff shows a fixture patient's name and multi-line address
⟬text⟭
 FAIL  src/labels/__tests__/rxLabel.test.ts
  ● rx label › renders the delivery block

    expect(received).toMatchInlineSnapshot(snapshot)

    - Snapshot  - 1
    + Received  + 1

      Deliver to
    - ⟬person_name#1⟭
    + ⟬person_name#2⟭
      ⟬postal_address#1⟭

Tests: 1 failed, 32 passed, 33 total
⟬end⟭

⟬template⟭
family: logs
format: access log
language: en
fill_locale: en_US
domain: retail
appearance: combined log format, email in a query string, token in a query string
scenario: Apache access of a florist's order tracking links, with email and token in the query string and a JWT for the courier app
⟬text⟭
⟬ip_address#1⟭ - - [⟬date#1⟭ 09:40:12 -0400] "GET /track?email=⟬email#1⟭&k=⟬opaque_token#1⟭ HTTP/1.1" 200 3120 "-" "Mozilla/5.0 (iPhone; CPU iPhone OS 17_3 like Mac OS X)"
⟬ip_address#2⟭ - - [⟬date#1⟭ 09:40:44 -0400] "GET /courier/route?token=⟬jwt#1⟭ HTTP/1.1" 200 8120 "-" "CourierApp/⟬version#1⟭ (Android 14)"
⟬ip_address#3⟭ - - [⟬date#1⟭ 09:41:02 -0400] "GET /bouquets/⟬trap:word_name|rose-and-lily⟭ HTTP/1.1" 200 12040 "-" "Mozilla/5.0 (compatible; bingbot/2.0)"
⟬ip_address#4⟭ - - [⟬date#1⟭ 09:41:30 -0400] "GET /healthz HTTP/1.1" 200 2 "-" "kube-probe/1.29"
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: en
fill_locale: en_US
domain: government
appearance: terraform plan output, sensitive value, resource attributes
scenario: Terraform plan of a state records database, where the password shows as a sensitive value and only service names and tags are printed
⟬text⟭
$ terraform plan -no-color -input=false
Acquiring state lock. This may take a few moments...
module.network.aws_vpc.main: Refreshing state...
module.db.aws_db_instance.records: Refreshing state...

Terraform will perform the following actions:

  # module.db.aws_db_instance.records will be updated in-place
  ~ resource "aws_db_instance" "records" {
        id                   = "records-prod"
      ~ instance_class       = "db.r6g.large" -> "db.r6g.xlarge"
      ~ password             = ⟬trap:placeholder|(sensitive value)⟭
      ~ ⟬trap:indicator_non_pii|username             = "dbadmin"⟭
        tags                 = {
            "owner" = "⟬trap:indicator_non_pii|records-division⟭"
        }
    }

  # module.iam.aws_iam_user.ci will be created
  + resource "aws_iam_user" "ci" {
      + name = "⟬trap:indicator_non_pii|ci-deployer⟭"
      + path = "/service/"
    }

Plan: 1 to add, 1 to change, 0 to destroy.
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: en
fill_locale: en_US
domain: travel
appearance: fixed-width audit line, vehicle deck, passport, license, plate, operator field
scenario: boarding audit of a coastal ferry operator, where deck hands scan vehicle plates and passenger documents at the ramp
⟬text⟭
⟬date#1⟭ 06:40:12 RAMP-A SCAN  plate="⟬us_license_plate#1⟭"  deck=2 lane=4 op=⟬person_name:handle#2⟭
⟬date#1⟭ 06:40:13 RAMP-A DOC   driver="⟬person_name#1⟭"  dl="⟬us_driver_license#1⟭"
⟬date#1⟭ 06:40:51 RAMP-A SCAN  plate="⟬us_license_plate#3⟭"  deck=2 lane=4 op=⟬person_name:handle#2⟭
⟬date#1⟭ 06:40:52 RAMP-A DOC   driver="⟬person_name#3⟭"  passport=⟬us_passport#3⟭
⟬date#1⟭ 06:41:20 RAMP-A PASS  foot passenger ⟬person_name#4⟭ passport=⟬us_passport#4⟭ cabin=none
⟬date#1⟭ 06:41:44 RAMP-A SCAN  plate="⟬us_license_plate#5⟭"  deck=1 lane=1 op=⟬trap:indicator_non_pii|gate-reader-1⟭ class=freight
⟬date#1⟭ 06:41:45 RAMP-A DOC   carrier="⟬company#5⟭"  manifest=⟬uuid#1⟭
⟬date#1⟭ 06:42:30 RAMP-A SCAN  plate="⟬us_license_plate#6⟭"  deck=2 lane=5 op=⟬person_name:handle#2⟭
⟬date#1⟭ 06:42:31 RAMP-A DOC   driver="⟬person_name#6⟭"  dl="⟬us_driver_license#6⟭"
⟬date#1⟭ 06:43:02 RAMP-A HOLD  plate="⟬us_license_plate#6⟭"  reason=overheight supervisor="⟬person_name#7⟭"
⟬date#1⟭ 06:43:40 RAMP-A SCAN  plate="⟬us_license_plate#8⟭"  deck=2 lane=5 op=⟬person_name:handle#2⟭
⟬date#1⟭ 06:44:05 RAMP-A PASS  foot passenger ⟬person_name#9⟭ passport=⟬us_passport#9⟭ cabin=114
⟬date#1⟭ 06:44:31 RAMP-A CLOSE lane=4 count=22 op=⟬trap:indicator_non_pii|ramp-controller⟭
⟬date#1⟭ 06:45:00 RAMP-A CLOSE lane=5 count=19 op=⟬trap:indicator_non_pii|ramp-controller⟭
⟬date#1⟭ 06:46:12 BRIDGE MANIFEST sent to ⟬url#1⟭ crossing ⟬order_number#1⟭ to ⟬trap:word_name|Victoria⟭
⟬date#1⟭ 06:47:00 BRIDGE DEPART master="⟬person_name#10⟭" pax=412 vehicles=88
⟬end⟭

⟬template⟭
family: logs
format: application log
language: en
fill_locale: en_US
domain: healthcare
appearance: key=value, HTTP header, payer request, quoted value, secret under an innocuous key
scenario: prior authorization service of a specialty clinic, whose outbound calls log the payer bearer token, the member's SSN and the clinician's note
⟬text⟭
level=info ts="⟬date#1⟭ 15:02:11" svc=prior-auth msg="request created" auth_id=⟬uuid#1⟭ cpt=70553 owner=⟬trap:indicator_non_pii|utilization-mgmt⟭
level=debug ts="⟬date#1⟭ 15:02:11" svc=prior-auth msg="member loaded" name="⟬person_name#2⟭" member=⟬customer_id#2⟭ dob=⟬birth_date#2⟭
level=debug ts="⟬date#1⟭ 15:02:12" svc=payer-client msg="POST /x12/278" header="Authorization: Bearer ⟬jwt#1⟭" header2="X-Payer-Ref: ⟬opaque_token#1⟭"
level=debug ts="⟬date#1⟭ 15:02:12" svc=payer-client msg="body" nm1="NM1*IL*1*⟬person_name:family#2⟭*⟬person_name:given#2⟭****34*⟬us_ssn#2⟭~"
level=info ts="⟬date#1⟭ 15:02:14" svc=payer-client msg="payer response" code=A4 pended=true
level=info ts="⟬date#1⟭ 15:02:14" svc=prior-auth msg="note attached" author="⟬person_name#3⟭" text="MRI ordered by Dr ⟬person_name#3⟭ after a fall at home on ⟬date#1⟭"
level=warn ts="⟬date#1⟭ 15:40:02" svc=payer-client msg="status poll timeout" auth_id=⟬uuid#1⟭ elapsed_ms=30002
level=info ts="⟬date#1⟭ 15:45:02" svc=payer-client msg="status poll" auth_id=⟬uuid#1⟭ status=PENDED ref=⟬order_number#1⟭
level=info ts="⟬date#1⟭ 16:00:00" svc=prior-auth msg="queue depth" pending=41 version=⟬version#1⟭
level=info ts="⟬date#1⟭ 16:12:48" svc=payer-client msg="approval received" auth_id=⟬uuid#1⟭ visits=1
level=info ts="⟬date#1⟭ 16:12:49" svc=prior-auth msg="patient notified" channel=sms to="⟬phone#2⟭"
level=info ts="⟬date#1⟭ 16:12:50" svc=prior-auth msg="scheduling told" recipient=⟬trap:indicator_non_pii|imaging-desk⟭
level=info ts="⟬date#1⟭ 16:30:00" svc=prior-auth msg="queue depth" pending=38 version=⟬version#1⟭
level=info ts="⟬date#1⟭ 16:44:17" svc=prior-auth msg="request created" auth_id=⟬uuid#2⟭ cpt=29881 owner="⟬person_name#4⟭"
level=debug ts="⟬date#1⟭ 16:44:17" svc=prior-auth msg="member loaded" name="⟬person_name#5⟭" member=⟬customer_id#5⟭ dob=⟬birth_date#5⟭
level=info ts="⟬date#1⟭ 17:00:00" svc=prior-auth msg="queue depth" pending=39 version=⟬version#1⟭
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: en
fill_locale: en_US
domain: retail
appearance: Flask traceback, request form in an exception, card and address
scenario: Flask traceback of a bike shop's checkout, whose exception message repeats the card, security code and billing address
⟬text⟭
[⟬date#1⟭ 12:30:44,118] ERROR in app: Exception on /checkout [POST]
Traceback (most recent call last):
  File "/srv/shop/.venv/lib/python3.11/site-packages/flask/app.py", line 1455, in wsgi_app
    response = self.full_dispatch_request()
  File "/srv/shop/checkout.py", line 74, in checkout
    charge = processor.charge(form)
processor.CardError: rejected form={"card": "⟬payment_card#1⟭", "cvc": "⟬card_security_code#1⟭", "billing": "⟬postal_address#1⟭"}
⟬end⟭

⟬template⟭
family: logs
format: test output
language: en
fill_locale: en_US
domain: government
appearance: TestNG report, Selenium output, test fixture, page source excerpt
scenario: TestNG and Selenium run of a state vehicle title system, whose failure prints fixture buyer and seller with SSN, license and plate from the page source
⟬text⟭
[TestNG] Running:
  /builds/title/testng.xml
[INFO] Starting ChromeDriver on port 41822
[INFO] TitleTransferIT.opensTransferForm ... PASSED (1.204 s)
[INFO] TitleTransferIT.rejectsMissingOdometer ... PASSED (0.884 s)
[INFO] TitleTransferIT.acceptsDealerReassignment ... FAILED (2.118 s)
org.openqa.selenium.TimeoutException: Expected condition failed: waiting for visibility of element located by By.id: confirmation (tried for 10 second(s))
	at org.openqa.selenium.support.ui.WebDriverWait.timeoutException(WebDriverWait.java:84)
	at gov.state.title.it.TitleTransferIT.acceptsDealerReassignment(TitleTransferIT.java:141)
Page source excerpt:
  <td id="seller">⟬person_name#1⟭</td><td id="seller-dl">⟬us_driver_license#1⟭</td>
  <td id="buyer">⟬person_name#2⟭</td><td id="buyer-ssn">⟬us_ssn#2⟭</td>
  <td id="plate">⟬us_license_plate#1⟭</td><td id="sale-date">⟬date#1⟭</td>
  <td id="clerk">⟬trap:indicator_non_pii|QA_CLERK_01⟭</td>
  <div class="error">⟬trap:indicator_non_pii|dealer_license is required⟭</div>
[INFO] TitleTransferIT.printsReceipt ... SKIPPED
===============================================
Title Suite
Total tests run: 4, Passes: 2, Failures: 1, Skips: 1
===============================================
⟬end⟭

⟬template⟭
family: logs
format: access log
language: en
fill_locale: en_US
domain: travel
appearance: airport parking gateway line, context field, plate in a context field, passport in a path
scenario: access of an airport parking and lounge gateway, where barrier cameras post plates to a context field and lounge readers pass passports in the path
⟬text⟭
⟬ip_address#1⟭ - ⟬username#1⟭ [⟬date#1⟭ 05:14:02 -0400] "POST /parking/entry HTTP/1.1" 201 88 "-" "BarrierCam/⟬version#1⟭" attrs="plate=⟬us_license_plate#2⟭ lot=C"
⟬ip_address#1⟭ - ⟬username#1⟭ [⟬date#1⟭ 05:14:40 -0400] "POST /parking/entry HTTP/1.1" 201 88 "-" "BarrierCam/⟬version#1⟭" attrs="plate=⟬us_license_plate#3⟭ lot=C"
⟬ip_address#2⟭ - - [⟬date#1⟭ 05:15:02 -0400] "GET /parking/prebook?ref=⟬opaque_token#1⟭ HTTP/1.1" 200 1204 "-" "Mozilla/5.0 (iPhone; CPU iPhone OS 17_3 like Mac OS X)" attrs="-"
⟬ip_address#2⟭ - - [⟬date#1⟭ 05:15:20 -0400] "GET /parking/prebook?ref=⟬order_number#1⟭ HTTP/1.1" 200 1204 "-" "Mozilla/5.0 (iPhone; CPU iPhone OS 17_3 like Mac OS X)" attrs="-"
⟬ip_address#3⟭ - ⟬username#2⟭ [⟬date#1⟭ 05:16:11 -0400] "GET /lounge/access/⟬us_passport#4⟭ HTTP/1.1" 200 96 "-" "LoungeReader/⟬version#2⟭" attrs="guest=⟬person_name#4⟭ tier=gold"
⟬ip_address#3⟭ - ⟬username#2⟭ [⟬date#1⟭ 05:16:50 -0400] "GET /lounge/access/⟬us_passport#5⟭ HTTP/1.1" 403 74 "-" "LoungeReader/⟬version#2⟭" attrs="guest=⟬person_name#5⟭ tier=none"
⟬ip_address#4⟭ - - [⟬date#1⟭ 05:17:05 -0400] "GET /healthz HTTP/1.1" 200 2 "-" "kube-probe/1.29" attrs="-"
⟬ip_address#5⟭ - - [⟬date#1⟭ 05:17:44 -0400] "POST /parking/pay HTTP/1.1" 200 140 "⟬url#1⟭" "Mozilla/5.0 (Linux; Android 14) Chrome/120.0" attrs="plate=⟬us_license_plate#6⟭ pan=⟬payment_card#6⟭"
⟬ip_address#6⟭ - - [⟬date#1⟭ 05:18:02 -0400] "GET /flights/status?gate=B11&terminal=⟬trap:word_name|Charlotte⟭ HTTP/1.1" 200 2204 "-" "Mozilla/5.0 (compatible; Googlebot/2.1)" attrs="-"
⟬ip_address#7⟭ - - [⟬date#1⟭ 05:18:30 -0400] "GET /shuttle/track?token=⟬jwt#1⟭ HTTP/1.1" 200 840 "-" "Mozilla/5.0 (iPhone; CPU iPhone OS 16_7 like Mac OS X)" attrs="-"
⟬ip_address#1⟭ - ⟬username#1⟭ [⟬date#1⟭ 05:19:02 -0400] "POST /parking/exit HTTP/1.1" 200 88 "-" "BarrierCam/⟬version#1⟭" attrs="plate=⟬us_license_plate#7⟭ stay_h=41 fee=88.00"
⟬ip_address#1⟭ - ⟬username#1⟭ [⟬date#1⟭ 05:19:40 -0400] "POST /parking/exit HTTP/1.1" 402 88 "-" "BarrierCam/⟬version#1⟭" attrs="plate=⟬us_license_plate#8⟭ stay_h=112 fee=204.00"
⟬ip_address#8⟭ - ⟬person_name:handle#9⟭ [⟬date#1⟭ 05:20:11 -0400] "POST /parking/override HTTP/1.1" 200 44 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/121.0" attrs="plate=⟬us_license_plate#8⟭ reason=⟬ticket_id#1⟭"
⟬ip_address#9⟭ - - [⟬date#1⟭ 05:20:45 -0400] "POST /lost-found/report HTTP/1.1" 201 72 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 14_2) Safari/605.1.15" attrs="name=⟬person_name#10⟭ phone=⟬phone#10⟭ item=passport no ⟬us_passport#10⟭"
⟬ip_address#4⟭ - - [⟬date#1⟭ 05:21:05 -0400] "GET /healthz HTTP/1.1" 200 2 "-" "kube-probe/1.29" attrs="-"
⟬ip_address#10⟭ - - [⟬date#1⟭ 05:21:30 -0400] "GET /wifi/landing?mac_hash=⟬hash#1⟭ HTTP/1.1" 200 3120 "-" "Mozilla/5.0 (Linux; Android 13) Chrome/119.0" attrs="-"
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: en
fill_locale: en_US
domain: fintech
appearance: Renovate output, dependency update, library named after a person
scenario: Renovate run bumping dependencies of a ledger service, with library names only
⟬text⟭
INFO: Repository started (repository=core/ledger)
INFO: Dependency extraction complete (baseBranch=main, deps=214)
INFO: Branch created: ⟬trap:library|renovate/jackson-monorepo⟭
INFO: PR created: ⟬trap:indicator_non_pii|author=renovate[bot]⟭ assignee=⟬trap:indicator_non_pii|team-ledger⟭
INFO: Repository finished (durationMs=41204)
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: en
fill_locale: en_US
domain: SaaS
appearance: pgaudit line, SQL statement, bound parameters, role change with password, connection log
scenario: pgaudit trail of an HR SaaS during a support intervention, with bound parameters revealing employee names, SSNs and addresses, and a role password set in clear
⟬text⟭
⟬date#1⟭ 22:00:01 UTC [4112]: user=⟬trap:indicator_non_pii|migrator⟭,db=hr,app=flyway,client=⟬ip_address#1⟭ LOG: AUDIT: SESSION,1,1,DDL,CREATE INDEX,INDEX,public.employees_ssn_idx,"CREATE INDEX CONCURRENTLY employees_ssn_idx ON employees (ssn_hash)",<none>
⟬date#1⟭ 22:00:44 UTC [4112]: user=⟬trap:indicator_non_pii|migrator⟭,db=hr,app=flyway,client=⟬ip_address#1⟭ LOG: AUDIT: SESSION,2,1,DDL,ALTER TABLE,TABLE,public.employees,"ALTER TABLE employees ADD COLUMN pronouns text",<none>
⟬date#1⟭ 22:01:02 UTC [4113]: user=⟬trap:indicator_non_pii|hr_app⟭,db=hr,app=api,client=⟬ip_address#2⟭ LOG: AUDIT: SESSION,1,1,READ,SELECT,TABLE,public.tenants,"SELECT id, plan FROM tenants WHERE id = $1",<none>
⟬date#1⟭ 22:01:02 UTC [4113]: user=⟬trap:indicator_non_pii|hr_app⟭,db=hr,app=api,client=⟬ip_address#2⟭ DETAIL: parameters: $1 = "⟬customer_id#3⟭"
⟬date#1⟭ 22:04:17 UTC [4120]: user=⟬person_name:handle#4⟭,db=hr,app=psql,client=⟬ip_address#3⟭ LOG: connection authorized: SSL enabled
⟬date#1⟭ 22:04:31 UTC [4120]: user=⟬person_name:handle#4⟭,db=hr,app=psql,client=⟬ip_address#3⟭ LOG: AUDIT: SESSION,1,1,READ,SELECT,TABLE,public.employees,"SELECT full_name, ssn, home_address FROM employees WHERE tenant_id = $1 AND full_name ILIKE $2",<none>
⟬date#1⟭ 22:04:31 UTC [4120]: user=⟬person_name:handle#4⟭,db=hr,app=psql,client=⟬ip_address#3⟭ DETAIL: parameters: $1 = "⟬customer_id#3⟭", $2 = "⟬person_name:family#5⟭%"
⟬date#1⟭ 22:05:12 UTC [4120]: user=⟬person_name:handle#4⟭,db=hr,app=psql,client=⟬ip_address#3⟭ LOG: AUDIT: SESSION,2,1,WRITE,UPDATE,TABLE,public.employees,"UPDATE employees SET ssn = $1, home_address = $2 WHERE id = $3",<none>
⟬date#1⟭ 22:05:12 UTC [4120]: user=⟬person_name:handle#4⟭,db=hr,app=psql,client=⟬ip_address#3⟭ DETAIL: parameters: $1 = "⟬us_ssn#5⟭", $2 = "⟬postal_address#5⟭", $3 = "8812"
⟬date#1⟭ 22:05:50 UTC [4120]: user=⟬person_name:handle#4⟭,db=hr,app=psql,client=⟬ip_address#3⟭ LOG: AUDIT: SESSION,3,1,WRITE,INSERT,TABLE,public.support_notes,"INSERT INTO support_notes (ticket, body) VALUES ($1, $2)",<none>
⟬date#1⟭ 22:05:50 UTC [4120]: user=⟬person_name:handle#4⟭,db=hr,app=psql,client=⟬ip_address#3⟭ DETAIL: parameters: $1 = "⟬ticket_id#1⟭", $2 = "fixed typo for ⟬person_name#5⟭ on request of ⟬person_name#6⟭ at ⟬company#3⟭"
⟬date#1⟭ 22:06:30 UTC [4120]: user=⟬person_name:handle#4⟭,db=hr,app=psql,client=⟬ip_address#3⟭ LOG: disconnection: session time: 0:02:13
⟬date#1⟭ 22:10:00 UTC [4131]: user=⟬trap:indicator_non_pii|cron_stats⟭,db=hr,app=pg_cron,client=⟬ip_address#4⟭ LOG: AUDIT: SESSION,1,1,MISC,ANALYZE,,,"ANALYZE employees",<none>
⟬date#1⟭ 22:15:02 UTC [4136]: user=⟬trap:indicator_non_pii|dba_admin⟭,db=postgres,app=psql,client=⟬ip_address#5⟭ LOG: AUDIT: SESSION,1,1,ROLE,ALTER ROLE,,,"ALTER ROLE hr_app WITH PASSWORD '⟬password#1⟭'",<none>
⟬date#1⟭ 22:15:02 UTC [4136]: user=⟬trap:indicator_non_pii|dba_admin⟭,db=postgres,app=psql,client=⟬ip_address#5⟭ LOG: AUDIT: SESSION,2,1,ROLE,GRANT,,,"GRANT SELECT ON employees TO readonly_bi",<none>
⟬date#1⟭ 22:15:40 UTC [4136]: user=⟬trap:indicator_non_pii|dba_admin⟭,db=postgres,app=psql,client=⟬ip_address#5⟭ LOG: AUDIT: SESSION,3,1,ROLE,CREATE ROLE,,,"CREATE ROLE support_ro LOGIN PASSWORD '⟬password#2⟭'",<none>
⟬date#1⟭ 22:20:13 UTC [4140]: user=⟬person_name:handle#7⟭,db=hr,app=psql,client=⟬ip_address#6⟭ LOG: connection authorized: SSL enabled
⟬date#1⟭ 22:20:29 UTC [4140]: user=⟬person_name:handle#7⟭,db=hr,app=psql,client=⟬ip_address#6⟭ LOG: AUDIT: SESSION,1,1,READ,SELECT,TABLE,public.payroll_accounts,"SELECT account_no, routing FROM payroll_accounts WHERE employee_id = $1",<none>
⟬date#1⟭ 22:20:29 UTC [4140]: user=⟬person_name:handle#7⟭,db=hr,app=psql,client=⟬ip_address#6⟭ DETAIL: parameters: $1 = "4120"
⟬date#1⟭ 22:21:02 UTC [4140]: user=⟬person_name:handle#7⟭,db=hr,app=psql,client=⟬ip_address#6⟭ LOG: AUDIT: SESSION,2,1,WRITE,UPDATE,TABLE,public.payroll_accounts,"UPDATE payroll_accounts SET account_no = $1 WHERE employee_id = $2",<none>
⟬date#1⟭ 22:21:02 UTC [4140]: user=⟬person_name:handle#7⟭,db=hr,app=psql,client=⟬ip_address#6⟭ DETAIL: parameters: $1 = "⟬bank_account_number#8⟭", $2 = "4120"
⟬date#1⟭ 22:21:40 UTC [4140]: user=⟬person_name:handle#7⟭,db=hr,app=psql,client=⟬ip_address#6⟭ LOG: disconnection: session time: 0:01:27
⟬date#1⟭ 22:30:00 UTC [4150]: user=⟬trap:indicator_non_pii|hr_app⟭,db=hr,app=api,client=⟬ip_address#2⟭ LOG: AUDIT: SESSION,1,1,WRITE,INSERT,TABLE,public.employees,"INSERT INTO employees (tenant_id, full_name, ssn, dob, home_address, hired_on) VALUES ($1, $2, $3, $4, $5, $6)",<none>
⟬date#1⟭ 22:30:00 UTC [4150]: user=⟬trap:indicator_non_pii|hr_app⟭,db=hr,app=api,client=⟬ip_address#2⟭ DETAIL: parameters: $1 = "⟬customer_id#3⟭", $2 = "⟬person_name#9⟭", $3 = "⟬us_ssn#9⟭", $4 = "⟬birth_date#9⟭", $5 = "⟬postal_address#9⟭", $6 = "⟬date#1⟭"
⟬date#1⟭ 22:30:04 UTC [4150]: user=⟬trap:indicator_non_pii|hr_app⟭,db=hr,app=api,client=⟬ip_address#2⟭ LOG: AUDIT: SESSION,2,1,WRITE,INSERT,TABLE,public.employees,"INSERT INTO employees (tenant_id, full_name, ssn, dob, home_address, hired_on) VALUES ($1, $2, $3, $4, $5, $6)",<none>
⟬date#1⟭ 22:30:04 UTC [4150]: user=⟬trap:indicator_non_pii|hr_app⟭,db=hr,app=api,client=⟬ip_address#2⟭ DETAIL: parameters: $1 = "⟬customer_id#3⟭", $2 = "⟬person_name#10⟭", $3 = "⟬us_ssn#10⟭", $4 = "⟬birth_date#10⟭", $5 = "⟬postal_address#10⟭", $6 = "⟬date#1⟭"
⟬date#1⟭ 22:31:17 UTC [4151]: user=⟬trap:indicator_non_pii|hr_app⟭,db=hr,app=api,client=⟬ip_address#2⟭ LOG: AUDIT: SESSION,1,1,READ,SELECT,TABLE,public.employees,"SELECT count(*) FROM employees WHERE tenant_id = $1",<none>
⟬date#1⟭ 22:31:17 UTC [4151]: user=⟬trap:indicator_non_pii|hr_app⟭,db=hr,app=api,client=⟬ip_address#2⟭ DETAIL: parameters: $1 = "⟬customer_id#3⟭"
⟬date#1⟭ 22:40:00 UTC [4160]: user=⟬trap:indicator_non_pii|backup_agent⟭,db=hr,app=pg_dump,client=⟬ip_address#7⟭ LOG: AUDIT: SESSION,1,1,READ,COPY,TABLE,public.employees,"COPY public.employees TO stdout",<none>
⟬date#1⟭ 22:40:41 UTC [4160]: user=⟬trap:indicator_non_pii|backup_agent⟭,db=hr,app=pg_dump,client=⟬ip_address#7⟭ LOG: AUDIT: SESSION,2,1,READ,COPY,TABLE,public.payroll_accounts,"COPY public.payroll_accounts TO stdout",<none>
⟬date#1⟭ 22:41:30 UTC [4160]: user=⟬trap:indicator_non_pii|backup_agent⟭,db=hr,app=pg_dump,client=⟬ip_address#7⟭ LOG: disconnection: session time: 0:01:30
⟬date#1⟭ 22:45:00 UTC [4170]: user=⟬trap:indicator_non_pii|cron_stats⟭,db=hr,app=pg_cron,client=⟬ip_address#4⟭ LOG: AUDIT: SESSION,1,1,MISC,VACUUM,,,"VACUUM (ANALYZE) support_notes",<none>
⟬date#1⟭ 22:50:12 UTC [4175]: user=⟬person_name:handle#4⟭,db=hr,app=psql,client=⟬ip_address#3⟭ LOG: connection authorized: SSL enabled
⟬date#1⟭ 22:50:27 UTC [4175]: user=⟬person_name:handle#4⟭,db=hr,app=psql,client=⟬ip_address#3⟭ LOG: AUDIT: SESSION,1,1,READ,SELECT,TABLE,public.employees,"SELECT full_name, ssn FROM employees WHERE id = $1",<none>
⟬date#1⟭ 22:50:27 UTC [4175]: user=⟬person_name:handle#4⟭,db=hr,app=psql,client=⟬ip_address#3⟭ DETAIL: parameters: $1 = "8812"
⟬date#1⟭ 22:50:58 UTC [4175]: user=⟬person_name:handle#4⟭,db=hr,app=psql,client=⟬ip_address#3⟭ LOG: AUDIT: SESSION,2,1,WRITE,UPDATE,TABLE,public.support_notes,"UPDATE support_notes SET closed = true WHERE ticket = $1",<none>
⟬date#1⟭ 22:50:58 UTC [4175]: user=⟬person_name:handle#4⟭,db=hr,app=psql,client=⟬ip_address#3⟭ DETAIL: parameters: $1 = "⟬ticket_id#1⟭"
⟬date#1⟭ 22:51:20 UTC [4175]: user=⟬person_name:handle#4⟭,db=hr,app=psql,client=⟬ip_address#3⟭ LOG: disconnection: session time: 0:01:08
⟬date#1⟭ 23:00:00 UTC [4180]: user=⟬trap:indicator_non_pii|cron_stats⟭,db=hr,app=pg_cron,client=⟬ip_address#4⟭ LOG: AUDIT: SESSION,1,1,MISC,CHECKPOINT,,,"CHECKPOINT",<none>
⟬date#1⟭ 23:05:12 UTC [4185]: user=⟬trap:indicator_non_pii|hr_app⟭,db=hr,app=api,client=⟬ip_address#2⟭ LOG: AUDIT: SESSION,1,1,READ,SELECT,TABLE,public.benefits,"SELECT plan FROM benefits WHERE employee_id = $1",<none>
⟬date#1⟭ 23:05:12 UTC [4185]: user=⟬trap:indicator_non_pii|hr_app⟭,db=hr,app=api,client=⟬ip_address#2⟭ DETAIL: parameters: $1 = "4120"
⟬date#1⟭ 23:10:44 UTC [4190]: user=⟬trap:indicator_non_pii|hr_app⟭,db=hr,app=api,client=⟬ip_address#2⟭ LOG: AUDIT: SESSION,1,1,WRITE,UPDATE,TABLE,public.employees,"UPDATE employees SET emergency_contact = $1, emergency_phone = $2 WHERE id = $3",<none>
⟬date#1⟭ 23:10:44 UTC [4190]: user=⟬trap:indicator_non_pii|hr_app⟭,db=hr,app=api,client=⟬ip_address#2⟭ DETAIL: parameters: $1 = "⟬person_name#11⟭", $2 = "⟬phone#11⟭", $3 = "8901"
⟬date#1⟭ 23:15:00 UTC [4195]: user=⟬trap:indicator_non_pii|cron_stats⟭,db=hr,app=pg_cron,client=⟬ip_address#4⟭ LOG: AUDIT: SESSION,1,1,MISC,ANALYZE,,,"ANALYZE payroll_accounts",<none>
⟬date#1⟭ 23:20:30 UTC [4200]: user=⟬trap:indicator_non_pii|migrator⟭,db=hr,app=flyway,client=⟬ip_address#1⟭ LOG: AUDIT: SESSION,1,1,DDL,COMMENT,COLUMN,public.employees.pronouns,"COMMENT ON COLUMN employees.pronouns IS 'optional'",<none>
⟬date#1⟭ 23:25:02 UTC [4205]: user=⟬trap:indicator_non_pii|hr_app⟭,db=hr,app=api,client=⟬ip_address#2⟭ LOG: AUDIT: SESSION,1,1,READ,SELECT,TABLE,public.tenants,"SELECT id, plan FROM tenants WHERE id = $1",<none>
⟬date#1⟭ 23:25:02 UTC [4205]: user=⟬trap:indicator_non_pii|hr_app⟭,db=hr,app=api,client=⟬ip_address#2⟭ DETAIL: parameters: $1 = "⟬customer_id#12⟭"
⟬date#1⟭ 23:30:00 UTC [4210]: user=⟬trap:indicator_non_pii|cron_stats⟭,db=hr,app=pg_cron,client=⟬ip_address#4⟭ LOG: AUDIT: SESSION,1,1,MISC,VACUUM,,,"VACUUM (ANALYZE) employees",<none>
⟬date#1⟭ 23:35:18 UTC [4215]: user=⟬person_name:handle#7⟭,db=hr,app=psql,client=⟬ip_address#6⟭ LOG: connection authorized: SSL enabled
⟬date#1⟭ 23:35:33 UTC [4215]: user=⟬person_name:handle#7⟭,db=hr,app=psql,client=⟬ip_address#6⟭ LOG: AUDIT: SESSION,1,1,READ,SELECT,TABLE,public.audit_exports,"SELECT file FROM audit_exports ORDER BY created_at DESC LIMIT 1",<none>
⟬date#1⟭ 23:36:02 UTC [4215]: user=⟬person_name:handle#7⟭,db=hr,app=psql,client=⟬ip_address#6⟭ LOG: disconnection: session time: 0:00:44
⟬date#1⟭ 23:40:00 UTC [4220]: user=⟬trap:indicator_non_pii|cron_stats⟭,db=hr,app=pg_cron,client=⟬ip_address#4⟭ LOG: AUDIT: SESSION,1,1,MISC,CHECKPOINT,,,"CHECKPOINT",<none>
⟬date#1⟭ 23:45:10 UTC [4225]: user=⟬trap:indicator_non_pii|hr_app⟭,db=hr,app=api,client=⟬ip_address#2⟭ LOG: AUDIT: SESSION,1,1,READ,SELECT,TABLE,public.employees,"SELECT count(*) FROM employees WHERE terminated_on IS NULL",<none>
⟬date#1⟭ 23:50:00 UTC [4230]: user=⟬trap:indicator_non_pii|cron_stats⟭,db=hr,app=pg_cron,client=⟬ip_address#4⟭ LOG: AUDIT: SESSION,1,1,MISC,ANALYZE,,,"ANALYZE audit_exports",<none>
⟬date#1⟭ 23:55:02 UTC [4235]: user=⟬trap:indicator_non_pii|backup_agent⟭,db=hr,app=pg_dump,client=⟬ip_address#7⟭ LOG: AUDIT: SESSION,1,1,READ,COPY,TABLE,public.support_notes,"COPY public.support_notes TO stdout",<none>
⟬date#1⟭ 23:55:11 UTC [4235]: user=⟬trap:indicator_non_pii|backup_agent⟭,db=hr,app=pg_dump,client=⟬ip_address#7⟭ LOG: disconnection: session time: 0:00:09
⟬date#1⟭ 23:56:40 UTC [4237]: user=⟬trap:indicator_non_pii|hr_app⟭,db=hr,app=api,client=⟬ip_address#2⟭ LOG: AUDIT: SESSION,1,1,WRITE,INSERT,TABLE,public.dependents,"INSERT INTO dependents (employee_id, full_name, dob) VALUES ($1, $2, $3)",<none>
⟬date#1⟭ 23:56:40 UTC [4237]: user=⟬trap:indicator_non_pii|hr_app⟭,db=hr,app=api,client=⟬ip_address#2⟭ DETAIL: parameters: $1 = "8901", $2 = "⟬person_name#13⟭", $3 = "⟬birth_date#13⟭"
⟬date#1⟭ 23:57:18 UTC [4238]: user=⟬trap:indicator_non_pii|hr_app⟭,db=hr,app=api,client=⟬ip_address#2⟭ LOG: AUDIT: SESSION,1,1,WRITE,UPDATE,TABLE,public.employees,"UPDATE employees SET work_email = $1 WHERE id = $2",<none>
⟬date#1⟭ 23:57:18 UTC [4238]: user=⟬trap:indicator_non_pii|hr_app⟭,db=hr,app=api,client=⟬ip_address#2⟭ DETAIL: parameters: $1 = "⟬email#14⟭", $2 = "8934"
⟬date#1⟭ 23:58:02 UTC [4239]: user=⟬trap:indicator_non_pii|dba_admin⟭,db=postgres,app=psql,client=⟬ip_address#5⟭ LOG: AUDIT: SESSION,1,1,ROLE,ALTER ROLE,,,"ALTER ROLE support_ro NOLOGIN",<none>
⟬date#1⟭ 23:59:59 UTC [4240]: user=⟬trap:indicator_non_pii|cron_stats⟭,db=hr,app=pg_cron,client=⟬ip_address#4⟭ LOG: AUDIT: SESSION,1,1,MISC,CHECKPOINT,,,"CHECKPOINT",<none>
⟬end⟭
