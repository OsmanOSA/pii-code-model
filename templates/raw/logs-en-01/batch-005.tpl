⟬template⟭
family: logs
format: test output
language: en
fill_locale: en_US
domain: government
appearance: Robot Framework console, keyword log, stand-in variable, test fixture
scenario: Robot Framework run of a state license renewal journey, whose keyword log shows the fixture driver, plate, license and address, with one stand-in left in a variable
⟬text⟭
==============================================================================
License Renewal :: Acceptance tests for the online renewal journey
==============================================================================
Renew With Valid License                                              | PASS |
------------------------------------------------------------------------------
Renew Twice In One Day Is Refused                                     | PASS |
------------------------------------------------------------------------------
Change Of Address During Renewal                                      | FAIL |
Keyword 'Address Should Match' failed: "⟬postal_address#1⟭" != "⟬postal_address#2⟭"
------------------------------------------------------------------------------
Reject Vehicle Without Insurance                                      | FAIL |
Keyword 'Insurance Should Be Valid' failed: no cover for plate "⟬us_license_plate#1⟭"
------------------------------------------------------------------------------
License Renewal :: Acceptance tests for the online renewal journey    | FAIL |
4 tests, 2 passed, 2 failed
==============================================================================
Output:  /builds/renewal/results/output.xml
Log:     /builds/renewal/results/log.html
Report:  /builds/renewal/results/report.html

--- keyword log, test "Change Of Address During Renewal" ---
INFO : ${driver} = "⟬person_name#1⟭"
INFO : ${license} = "⟬us_driver_license#1⟭"
INFO : ${dob} = ⟬birth_date#1⟭
INFO : ${renewed_on} = ⟬date#1⟭
WARN : ${NOTIFY_NAME} still set to ⟬trap:indicator_non_pii|${APPLICANT_NAME}⟭
⟬end⟭

⟬template⟭
family: logs
format: access log
language: en
fill_locale: en_US
domain: travel
appearance: virtual host combined log, context field, passport in a path, JWT in a query string, plate in a context field
scenario: Apache virtual host log of a car rental API, where counter tablets send passports in paths, plates in a context field and a JWT in the query string
⟬text⟭
rentals.internal:443 ⟬ip_address#1⟭ - - [⟬date#1⟭ 12:04:31 -0500] "GET /v3/reservations/⟬order_number#1⟭ HTTP/1.1" 200 1820 "-" "CounterTablet/⟬version#1⟭" note="-"
rentals.internal:443 ⟬ip_address#1⟭ - - [⟬date#1⟭ 12:04:58 -0500] "POST /v3/renters/⟬us_passport#2⟭/verify?access_token=⟬jwt#1⟭ HTTP/1.1" 200 204 "-" "CounterTablet/⟬version#1⟭" note="renter=⟬person_name#2⟭"
rentals.internal:443 ⟬ip_address#1⟭ - - [⟬date#1⟭ 12:05:20 -0500] "POST /v3/agreements HTTP/1.1" 201 412 "-" "CounterTablet/⟬version#1⟭" note="dl=⟬us_driver_license#2⟭ plate=⟬us_license_plate#3⟭ class=SUV"
rentals.internal:443 ⟬ip_address#2⟭ - - [⟬date#1⟭ 12:05:44 -0500] "GET /healthz HTTP/1.1" 200 2 "-" "kube-probe/1.29" note="-"
rentals.internal:443 ⟬ip_address#3⟭ - - [⟬date#1⟭ 12:06:02 -0500] "GET /v3/fleet/available?site=⟬trap:word_name|Charlotte-airport⟭ HTTP/1.1" 200 8120 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/121.0" note="-"
rentals.internal:443 ⟬ip_address#1⟭ - - [⟬date#1⟭ 12:06:30 -0500] "POST /v3/agreements/⟬uuid#1⟭/sign?sig=⟬opaque_token#1⟭ HTTP/1.1" 200 96 "-" "CounterTablet/⟬version#1⟭" note="-"
rentals.internal:443 ⟬ip_address#4⟭ - ⟬person_name:handle#4⟭ [⟬date#1⟭ 12:07:01 -0500] "POST /v3/returns HTTP/1.1" 200 188 "-" "LotScanner/⟬version#2⟭" note="plate=⟬us_license_plate#5⟭ fuel=7/8 miles=412"
rentals.internal:443 ⟬ip_address#4⟭ - ⟬person_name:handle#4⟭ [⟬date#1⟭ 12:07:40 -0500] "POST /v3/returns HTTP/1.1" 200 188 "-" "LotScanner/⟬version#2⟭" note="plate=⟬us_license_plate#6⟭ fuel=4/8 miles=1204"
rentals.internal:443 ⟬ip_address#5⟭ - ⟬username#1⟭ [⟬date#1⟭ 12:08:02 -0500] "GET /v3/reports/utilization?site=⟬trap:word_name|Austin-airport⟭ HTTP/1.1" 200 4410 "-" "python-requests/2.31.0" note="-"
rentals.internal:443 ⟬ip_address#6⟭ - - [⟬date#1⟭ 12:08:39 -0500] "GET /v3/renters/⟬us_passport#7⟭ HTTP/1.1" 403 74 "-" "curl/8.4.0" note="ref=⟬opaque_token#2⟭"
rentals.internal:443 ⟬ip_address#7⟭ - - [⟬date#1⟭ 12:09:12 -0500] "POST /v3/tolls/import HTTP/1.1" 202 44 "-" "TollBridge/⟬version#3⟭" note="ref=⟬uuid#2⟭"
rentals.internal:443 ⟬ip_address#2⟭ - - [⟬date#1⟭ 12:09:44 -0500] "GET /healthz HTTP/1.1" 200 2 "-" "kube-probe/1.29" note="-"
rentals.internal:443 ⟬ip_address#8⟭ - - [⟬date#1⟭ 12:10:03 -0500] "POST /v3/damage/claims HTTP/1.1" 201 140 "-" "Mozilla/5.0 (iPhone; CPU iPhone OS 17_3 like Mac OS X)" note="plate=⟬us_license_plate#8⟭ renter=⟬person_name#8⟭ phone=⟬phone#8⟭"
rentals.internal:443 ⟬ip_address#9⟭ - - [⟬date#1⟭ 12:10:41 -0500] "GET /v3/vehicles/search?make=⟬trap:company_name|Ford⟭&model=Escape HTTP/1.1" 200 3120 "-" "Mozilla/5.0 (compatible; Googlebot/2.1)" note="-"
rentals.internal:443 ⟬ip_address#10⟭ - - [⟬date#1⟭ 12:11:05 -0500] "GET /v3/partners/⟬trap:company_name|Marriott⟭/rates?token=⟬opaque_token#3⟭ HTTP/1.1" 200 2204 "-" "PartnerSync/⟬version#4⟭" note="-"
rentals.internal:443 ⟬ip_address#11⟭ - - [⟬date#1⟭ 12:11:52 -0500] "GET /receipt?id=⟬uuid#3⟭&token=⟬jwt#2⟭ HTTP/1.1" 200 6120 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 14_2) Safari/605.1.15" note="-"
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: en
fill_locale: en_US
domain: fintech
appearance: gitleaks output, scanner summary, indicator in a result line
scenario: pipeline step running a secret scanner over a payments repository and finding nothing
⟬text⟭
+ gitleaks detect --no-git --redact --report-format json
⟬date#1⟭ 09:12:02 INF 1204 files scanned, 412 MB
⟬date#1⟭ 09:12:02 INF ⟬trap:indicator_non_pii|secrets_found=0⟭
⟬date#1⟭ 09:12:02 INF allowlist: tests/fixtures/ api_key=⟬trap:placeholder|REDACTED⟭
⟬date#1⟭ 09:12:02 INF no leaks found
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: en
fill_locale: en_US
domain: SaaS
appearance: key=value, audit trail, bot accounts, commit trailer, secret value in an event
scenario: audit stream of a self-hosted Git platform, with people and bots on the same actor field, a personal token and a CI secret logged at creation
⟬text⟭
⟬date#1⟭ 09:00:14 audit action=user.login actor=⟬person_name:handle#1⟭ ip=⟬ip_address#1⟭ method=sso
⟬date#1⟭ 09:03:40 audit action=repo.push actor=⟬person_name:handle#1⟭ repo=billing/api ref=refs/heads/main sha=⟬git_sha#1⟭
⟬date#1⟭ 09:03:41 audit action=commit.verified signer="⟬person_name#1⟭ <⟬email#1⟭>" trailer="Co-authored-by: ⟬person_name#2⟭ <⟬email#2⟭>"
⟬date#1⟭ 09:04:02 audit action=repo.push ⟬trap:indicator_non_pii|actor=dependabot[bot]⟭ repo=billing/api ref=refs/heads/deps sha=⟬git_sha#2⟭
⟬date#1⟭ 09:15:27 audit action=pat.create actor=⟬person_name:handle#3⟭ name=laptop scopes=repo value=⟬opaque_token#1⟭
⟬date#1⟭ 09:15:28 audit action=label.add actor=⟬person_name:handle#3⟭ name=laptop-2 scopes=read value=⟬uuid#1⟭
⟬date#1⟭ 09:41:09 audit action=ci.secret.update actor=⟬person_name:handle#1⟭ repo=billing/api key=DEPLOY_PASSWORD new=⟬password#1⟭
⟬date#1⟭ 09:41:10 audit action=ci.secret.update ⟬trap:indicator_non_pii|actor=terraform-bot⟭ repo=billing/api key=REGISTRY_TOKEN new=⟬trap:placeholder|<masked>⟭
⟬date#1⟭ 10:02:33 audit action=deploy_key.add ⟬trap:indicator_non_pii|actor=terraform-bot⟭ repo=infra/live fingerprint=⟬hash#1⟭ title=⟬trap:indicator_non_pii|owner:platform⟭
⟬date#1⟭ 10:20:16 audit action=org.member.add actor=⟬person_name:handle#3⟭ member=⟬person_name:handle#4⟭ role=developer
⟬date#1⟭ 10:44:51 audit action=repo.visibility ⟬trap:indicator_non_pii|actor=policy-enforcer⟭ repo=docs/handbook old=public new=internal
⟬date#1⟭ 11:02:08 audit action=issue.comment actor=⟬person_name:handle#2⟭ repo=billing/api issue=⟬ticket_id#1⟭ body="⟬person_name#5⟭ from ⟬company#5⟭ asked for the invoice export"
⟬date#1⟭ 11:30:00 audit action=webhook.update ⟬trap:indicator_non_pii|actor=terraform-bot⟭ repo=billing/api url=⟬url#1⟭ secret=⟬opaque_token#2⟭
⟬date#1⟭ 12:00:00 audit action=license.check ⟬trap:indicator_non_pii|actor=system⟭ seats=412 version=⟬version#1⟭
⟬date#1⟭ 12:18:44 audit action=user.suspend ⟬trap:indicator_non_pii|actor=scim-sync⟭ target=⟬person_name:handle#6⟭ reason=offboarded
⟬date#1⟭ 12:45:03 audit action=repo.fork actor=⟬person_name:handle#4⟭ repo=billing/api to=⟬person_name:handle#4⟭/api
⟬end⟭

⟬template⟭
family: logs
format: application log
language: en
fill_locale: en_US
domain: government
appearance: SCADA message, place names, operator on shift
scenario: water utility telemetry gateway for a county, with reservoir levels at sites named like people and no person at all
⟬text⟭
⟬date#1⟭ 03:00:02 scada-gw site=⟬trap:word_name|Jordan-lake-intake⟭ level_ft=412.8 flow_mgd=18.2
⟬date#1⟭ 03:00:02 scada-gw site=⟬trap:word_name|Madison-tank-2⟭ level_ft=31.4 pressure_psi=62
⟬date#1⟭ 03:00:03 scada-gw site=⟬trap:word_name|Hope-valley-pump⟭ state=ON amps=44 ⟬trap:indicator_non_pii|operator=night-shift⟭
⟬date#1⟭ 03:05:02 scada-gw alarm cleared on ⟬hostname#1⟭ ⟬trap:indicator_non_pii|acknowledged_by=auto⟭
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: en
fill_locale: en_US
domain: travel
appearance: Python traceback, library frames, eponym, code identifier
scenario: Python traceback of a multi-leg itinerary search, where the graph library finds no path between two airports and only route data is shown
⟬text⟭
Traceback (most recent call last):
  File "/srv/itinerary/app.py", line 88, in search
    legs = planner.best_route(origin, destination, depart_after)
  File "/srv/itinerary/planner.py", line 141, in best_route
    path = nx.⟬trap:code_identifier|dijkstra_path⟭(self.graph, origin, destination, weight="minutes")
  File "/opt/venv/lib/python3.11/site-packages/networkx/utils/decorators.py", line 789, in func
    return argmap._lazy_compile(__wrapper)(*args, **kwargs)
  File "/opt/venv/lib/python3.11/site-packages/networkx/algorithms/shortest_paths/weighted.py", line 170, in ⟬trap:code_identifier|dijkstra_path⟭
    (length, path) = ⟬trap:code_identifier|single_source_dijkstra⟭(G, source, target=target, weight=weight)
  File "/opt/venv/lib/python3.11/site-packages/networkx/algorithms/shortest_paths/weighted.py", line 472, in ⟬trap:code_identifier|single_source_dijkstra⟭
    return ⟬trap:code_identifier|multi_source_dijkstra⟭(G, {source}, cutoff=cutoff, target=target, weight=weight)
  File "/opt/venv/lib/python3.11/site-packages/networkx/algorithms/shortest_paths/weighted.py", line 732, in ⟬trap:code_identifier|multi_source_dijkstra⟭
    raise nx.NetworkXNoPath(f"No path to {target}.")
networkx.exception.NetworkXNoPath: No path to SYD.

context: origin=CLT destination=SYD depart_after=06:00 ⟬trap:indicator_non_pii|passenger=None⟭ carriers=3
hint: ⟬trap:eponym|Dijkstra⟭ fallback disabled by feature flag, cache node ⟬hostname#1⟭
⟬end⟭

⟬template⟭
family: logs
format: test output
language: en
fill_locale: en_US
domain: fintech
appearance: cargo test output, assertion left and right, Debug struct
scenario: cargo test failure in a card issuing crate, whose assertion prints the masked output against the raw PAN and SSN of a fixture holder
⟬text⟭
running 6 tests
test card::tests::luhn_accepts_valid ... ok
test card::tests::formats_masked_pan ... FAILED
test holder::tests::parses_ssn ... ok

failures:

---- card::tests::formats_masked_pan stdout ----
thread 'card::tests::formats_masked_pan' panicked at src/card.rs:88:9:
assertion `left == right` failed
  left: "⟬payment_card#1⟭"
 right: "masked"
fixture: Holder { name: "⟬person_name#1⟭", ssn: "⟬us_ssn#1⟭", cvv: "⟬card_security_code#1⟭" }

test result: FAILED. 5 passed; 1 failed; 0 ignored; finished in 0.02s
⟬end⟭

⟬template⟭
family: logs
format: access log
language: en
fill_locale: en_US
domain: SaaS
appearance: combined log format, token in a query string, referer leak
scenario: nginx access of a file sharing app, whose download links put tokens in the query string and leak them again in the referer
⟬text⟭
⟬ip_address#1⟭ - - [⟬date#1⟭ 20:11:05 +0000] "GET /s/⟬uuid#1⟭?key=⟬opaque_token#1⟭ HTTP/2.0" 200 41208 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/121.0"
⟬ip_address#1⟭ - - [⟬date#1⟭ 20:11:09 +0000] "GET /s/⟬uuid#1⟭/preview?key=⟬opaque_token#1⟭ HTTP/2.0" 200 118204 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/121.0"
⟬ip_address#2⟭ - - [⟬date#1⟭ 20:11:40 +0000] "GET /api/me?access_token=⟬jwt#1⟭ HTTP/2.0" 200 312 "-" "DriveSync/⟬version#1⟭"
⟬ip_address#2⟭ - - [⟬date#1⟭ 20:11:41 +0000] "GET /api/files?folder=root&access_token=⟬jwt#1⟭ HTTP/2.0" 200 8120 "-" "DriveSync/⟬version#1⟭"
⟬ip_address#3⟭ - - [⟬date#1⟭ 20:12:02 +0000] "GET /healthz HTTP/1.1" 200 2 "-" "kube-probe/1.29"
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: en
fill_locale: en_US
domain: healthcare
appearance: Bamboo build log, kubectl output, secret in a shell trace, sample record
scenario: Bamboo plan of a care coordination app, where a shell trace shows the secret creation and a data check prints one patient row from a shared staging database
⟬text⟭
build	⟬date#1⟭ 12:04:11	Starting task 'Deploy to staging' of type 'com.atlassian.bamboo.plugins.scripttask'
build	⟬date#1⟭ 12:04:11	+ kubectl config use-context staging
build	⟬date#1⟭ 12:04:12	Switched to context "staging".
build	⟬date#1⟭ 12:04:12	+ kubectl create secret generic care-db --from-literal=username=⟬trap:indicator_non_pii|care_app⟭ --from-literal=password=⟬password#1⟭ --dry-run=client -o yaml
build	⟬date#1⟭ 12:04:12	+ kubectl apply -f -
build	⟬date#1⟭ 12:04:13	secret/care-db configured
build	⟬date#1⟭ 12:04:13	+ kubectl rollout status deploy/care-api
build	⟬date#1⟭ 12:04:41	deployment "care-api" successfully rolled out
build	⟬date#1⟭ 12:04:41	+ ./scripts/data_check.sh
build	⟬date#1⟭ 12:04:42	checking staging row count: 41822
build	⟬date#1⟭ 12:04:42	sample row:
build	⟬date#1⟭ 12:04:42	mrn         : ⟬customer_id#2⟭
build	⟬date#1⟭ 12:04:42	name        : ⟬person_name#2⟭
build	⟬date#1⟭ 12:04:42	ssn         : ⟬us_ssn#2⟭
build	⟬date#1⟭ 12:04:42	dob         : ⟬birth_date#2⟭
build	⟬date#1⟭ 12:04:42	care_team   : ⟬trap:indicator_non_pii|pool-east⟭
build	⟬date#1⟭ 12:04:42	last_visit  : ⟬date#2⟭
build	⟬date#1⟭ 12:04:43	+ curl -s -H "X-Api-Key: ⟬opaque_token#1⟭" ⟬url#1⟭
build	⟬date#1⟭ 12:04:43	{"ok":true}
build	⟬date#1⟭ 12:04:43	Finished task 'Deploy to staging' with result: Success
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: en
fill_locale: en_US
domain: retail
appearance: before and after values, quoted value, audit trail, contact center notes
scenario: loyalty CRM audit of a department store, with agents editing profiles, old and new addresses side by side, a card added by phone and notes in free text
⟬text⟭
⟬date#1⟭ 09:02:18 crm-audit agent="⟬person_name#1⟭" member=⟬customer_id#2⟭ field=address before="⟬postal_address#2⟭" after="⟬postal_address#3⟭"
⟬date#1⟭ 09:02:19 crm-audit agent="⟬person_name#1⟭" member=⟬customer_id#2⟭ field=note value="moved in with her sister, Mrs ⟬person_name#2f⟭ confirmed by phone"
⟬date#1⟭ 09:15:44 crm-audit agent="⟬person_name#1⟭" member=⟬customer_id#4⟭ field=phone before="⟬phone#4⟭" after="⟬phone#5⟭"
⟬date#1⟭ 09:31:07 crm-audit agent=⟬trap:indicator_non_pii|ivr-bot⟭ member=⟬customer_id#6⟭ field=preferred_store before=⟬trap:word_name|Savannah⟭ after=⟬trap:word_name|Charlotte⟭
⟬date#1⟭ 09:48:30 crm-audit agent="⟬person_name#7⟭" member=⟬customer_id#6⟭ field=card_on_file before=none after=⟬payment_card#6⟭
⟬date#1⟭ 10:12:55 crm-audit agent="⟬person_name#7⟭" member=⟬customer_id#8⟭ field=email before=⟬email#8⟭ after=⟬email#9⟭
⟬date#1⟭ 10:40:02 crm-audit agent=⟬trap:indicator_non_pii|dedupe-job⟭ member=⟬customer_id#8⟭ field=merged_with value=⟬customer_id#10⟭
⟬date#1⟭ 11:06:21 crm-audit agent="⟬person_name#1⟭" member=⟬customer_id#11⟭ field=birthday before=none after=⟬birth_date#11⟭
⟬date#1⟭ 11:30:48 crm-audit agent=⟬trap:indicator_non_pii|tier-engine⟭ member=⟬customer_id#11⟭ field=tier before=silver after=gold
⟬date#1⟭ 12:02:14 crm-audit agent="⟬person_name#7⟭" member=⟬customer_id#12⟭ field=note value="wants delivery to ⟬company#12⟭, ⟬postal_address#12⟭ only"
⟬date#1⟭ 12:40:09 crm-audit agent="⟬person_name#7⟭" member=⟬customer_id#13⟭ field=opt_out value=sms
⟬date#1⟭ 13:05:37 crm-audit agent=⟬trap:indicator_non_pii|gdpr-queue⟭ member=⟬customer_id#14⟭ field=delete_request value=⟬ticket_id#1⟭
⟬date#1⟭ 13:44:12 crm-audit agent="⟬person_name#1⟭" member=⟬customer_id#15⟭ field=card_on_file before=⟬payment_card#15⟭ after=none
⟬date#1⟭ 14:20:00 crm-audit agent=⟬trap:indicator_non_pii|tier-engine⟭ batch=⟬uuid#1⟭ promoted=118 demoted=41
⟬date#1⟭ 15:02:51 crm-audit agent="⟬person_name#7⟭" member=⟬customer_id#16⟭ field=note value="ask for ⟬person_name:given#7⟭ if ⟬person_name#16⟭ calls back"
⟬date#1⟭ 17:30:00 crm-audit agent=⟬trap:indicator_non_pii|export-job⟭ file=⟬file_path#1⟭ rows=88120 version=⟬version#1⟭
⟬end⟭

⟬template⟭
family: logs
format: application log
language: en
fill_locale: en_US
domain: SaaS
appearance: Rust tracing line, span fields, reset link, secret under an innocuous key
scenario: Rust tracing output of an accounting SaaS mail service, whose spans carry the user and whose debug lines print reset links, an SMTP password and a service JWT
⟬text⟭
⟬date#1⟭ 12:00:01.204  INFO mailer::boot: smtp relay configured host=⟬hostname#1⟭ user=⟬trap:indicator_non_pii|mailer-prod⟭
⟬date#1⟭ 12:00:01.205 DEBUG mailer::boot: smtp credentials loaded value=⟬password#1⟭
⟬date#1⟭ 12:00:01.310  INFO mailer::boot: control plane session bearer=⟬jwt#1⟭
⟬date#1⟭ 12:04:12.118  INFO reset{tenant=⟬customer_id#2⟭ user=⟬email#3⟭}: mailer::reset: password reset requested
⟬date#1⟭ 12:04:12.140 DEBUG reset{tenant=⟬customer_id#2⟭ user=⟬email#3⟭}: mailer::reset: link built url="/reset?token=⟬opaque_token#1⟭"
⟬date#1⟭ 12:04:12.602  INFO reset{tenant=⟬customer_id#2⟭ user=⟬email#3⟭}: mailer::smtp: accepted queue_id=⟬uuid#1⟭
⟬date#1⟭ 12:09:44.018  INFO invite{tenant=⟬customer_id#4⟭ user=⟬email#5⟭}: mailer::invite: invitation for "⟬person_name#5⟭" from "⟬person_name#6⟭"
⟬date#1⟭ 12:09:44.022 DEBUG invite{tenant=⟬customer_id#4⟭ user=⟬email#5⟭}: mailer::invite: link built url="/join?code=⟬opaque_token#2⟭"
⟬date#1⟭ 12:09:44.530  WARN invite{tenant=⟬customer_id#4⟭ user=⟬email#5⟭}: mailer::smtp: greylisted, retry in 300s
⟬date#1⟭ 12:14:45.002  INFO invite{tenant=⟬customer_id#4⟭ user=⟬email#5⟭}: mailer::smtp: accepted queue_id=⟬uuid#2⟭
⟬date#1⟭ 12:20:00.000  INFO digest{tenant=⟬customer_id#7⟭ user=⟬trap:indicator_non_pii|all-admins⟭}: mailer::digest: weekly digest queued count=41
⟬date#1⟭ 12:20:07.118  INFO digest{tenant=⟬customer_id#7⟭ user=⟬trap:indicator_non_pii|all-admins⟭}: mailer::digest: sent=41 bounced=0
⟬date#1⟭ 12:31:15.402 ERROR bounce{tenant=⟬customer_id#2⟭}: mailer::bounce: hard bounce for ⟬email#8⟭ code=550
⟬date#1⟭ 12:31:15.410  INFO bounce{tenant=⟬customer_id#2⟭}: mailer::bounce: suppressed, ref=⟬uuid#3⟭
⟬date#1⟭ 12:45:00.000  INFO mailer::stats: sent_1h=1204 deferred=3 version=⟬version#1⟭
⟬date#1⟭ 13:00:00.000  INFO mailer::stats: sent_1h=1188 deferred=1 version=⟬version#1⟭
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: en
fill_locale: en_US
domain: healthcare
appearance: pandas error, DataFrame dump, Python traceback, value without a key, chained exception
scenario: ETL failure at a hospital network's claims warehouse, where a date parsing error prints library frames and a DataFrame of patient rows with SSN, birth date and address
⟬text⟭
⟬date#1⟭ 02:14:44,118 INFO  claims_load: reading ⟬file_path#1⟭
⟬date#1⟭ 02:14:51,402 INFO  claims_load: 41822 rows, 12 columns
⟬date#1⟭ 02:14:51,410 ERROR claims_load: conversion failed, dumping offending rows
Traceback (most recent call last):
  File "/opt/etl/claims_load.py", line 212, in <module>
    main()
  File "/opt/etl/claims_load.py", line 204, in main
    frame = normalize(load(args.input))
  File "/opt/etl/claims_load.py", line 118, in normalize
    frame["dob"] = pd.to_datetime(frame["dob"], format="%Y-%m-%d")
  File "/opt/venv/lib/python3.11/site-packages/pandas/core/tools/datetimes.py", line 1067, in to_datetime
    values = convert_listlike(arg._values, format)
  File "/opt/venv/lib/python3.11/site-packages/pandas/core/tools/datetimes.py", line 433, in _convert_listlike_datetimes
    return _array_strptime_with_fallback(arg, name, utc, format, exact, errors)
  File "/opt/venv/lib/python3.11/site-packages/pandas/core/tools/datetimes.py", line 467, in _array_strptime_with_fallback
    result, tz_out = array_strptime(arg, fmt, exact=exact, errors=errors, utc=utc)
  File "strptime.pyx", line 501, in pandas._libs.tslibs.strptime.array_strptime
  File "strptime.pyx", line 451, in pandas._libs.tslibs.strptime.array_strptime
  File "strptime.pyx", line 583, in pandas._libs.tslibs.strptime._parse_with_format
ValueError: time data "⟬birth_date#2⟭" doesn't match format "%Y-%m-%d", at position 14

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "/opt/etl/run_nightly.py", line 77, in step
    subprocess.run(command, check=True, capture_output=True)
  File "/usr/lib/python3.11/subprocess.py", line 571, in run
    raise CalledProcessError(retcode, process.args, output=stdout, stderr=stderr)
subprocess.CalledProcessError: Command "['python', 'claims_load.py']" returned non-zero exit status 1.

Offending rows (frame.loc[bad_rows, cols].to_string()):
        member_id                 name          ssn         dob
14  ⟬customer_id#2⟭  ⟬person_name#2⟭  ⟬us_ssn#2⟭  ⟬birth_date#2⟭
31  ⟬customer_id#3⟭  ⟬person_name#3⟭  ⟬us_ssn#3⟭  ⟬birth_date#3⟭
58  ⟬customer_id#4⟭  ⟬person_name#4⟭  ⟬us_ssn#4⟭  ⟬birth_date#4⟭
77  ⟬customer_id#5⟭  ⟬person_name#5⟭  ⟬us_ssn#5⟭  ⟬birth_date#5⟭
90  ⟬customer_id#6⟭  ⟬person_name#6⟭  ⟬us_ssn#6⟭  ⟬birth_date#6⟭
112  ⟬customer_id#8⟭  ⟬person_name#8⟭  ⟬us_ssn#8⟭  ⟬birth_date#8⟭
140  ⟬customer_id#9⟭  ⟬person_name#9⟭  ⟬us_ssn#9⟭  ⟬birth_date#9⟭
188  ⟬customer_id#10⟭  ⟬person_name#10⟭  ⟬us_ssn#10⟭  ⟬birth_date#10⟭

Same rows, address columns:
                     street                 city    zip
14  ⟬postal_address:street#2⟭  ⟬city#2⟭  ⟬postcode#2⟭
31  ⟬postal_address:street#3⟭  ⟬city#3⟭  ⟬postcode#3⟭
58  ⟬postal_address:street#4⟭  ⟬city#4⟭  ⟬postcode#4⟭
77  ⟬postal_address:street#5⟭  ⟬city#5⟭  ⟬postcode#5⟭
90  ⟬postal_address:street#6⟭  ⟬city#6⟭  ⟬postcode#6⟭
112  ⟬postal_address:street#8⟭  ⟬city#8⟭  ⟬postcode#8⟭
140  ⟬postal_address:street#9⟭  ⟬city#9⟭  ⟬postcode#9⟭
188  ⟬postal_address:street#10⟭  ⟬city#10⟭  ⟬postcode#10⟭

Column summary:
member_id        41822 non-null  object
name             41822 non-null  object
ssn              41822 non-null  object
dob              41822 non-null  object
street           41800 non-null  object
city             41822 non-null  object
zip              41818 non-null  object
⟬trap:indicator_non_pii|plan_owner⟭       41822 non-null  object
⟬date#1⟭ 02:14:51,620 INFO  run_nightly: step claims_load failed, ⟬trap:indicator_non_pii|owner=data-eng-oncall⟭
⟬date#1⟭ 02:14:51,622 INFO  run_nightly: paged ⟬person_name#7⟭ on ⟬phone#7⟭
⟬date#1⟭ 02:14:51,640 INFO  run_nightly: marking run ⟬uuid#1⟭ as failed
⟬end⟭

⟬template⟭
family: logs
format: test output
language: en
fill_locale: en_US
domain: retail
appearance: go test output, testify diff, Go struct literal
scenario: testify failure of a gift card redemption at a toy retailer, whose diff shows the fixture buyer's card and security code
⟬text⟭
--- FAIL: TestRedeemSplitsTender (0.01s)
    redeem_test.go:74:
        	Error Trace:	/src/giftcards/redeem_test.go:74
        	Error:      	Not equal:
        	            	expected: giftcards.Result{Status:"SPLIT", Remainder:12.5}
        	            	actual  : giftcards.Result{Status:"DECLINED", Remainder:0}

        	            	Diff:
        	            	--- Expected
        	            	+++ Actual
        	            	@@ -1,4 +1,4 @@
        	            	 (giftcards.Result) {
        	            	- Status: (string) (len=5) "SPLIT",
        	            	- Remainder: (float64) 12.5
        	            	+ Status: (string) (len=8) "DECLINED",
        	            	+ Remainder: (float64) 0
        	            	 }
        	Test:       	TestRedeemSplitsTender
        	Messages:   	tender=giftcards.Tender{Holder:"⟬person_name#1⟭", PAN:"⟬payment_card#1⟭", CVV:"⟬card_security_code#1⟭", Code:"⟬opaque_token#1⟭"}
FAIL
FAIL	toybox/giftcards	0.118s
⟬end⟭

⟬template⟭
family: logs
format: access log
language: en
fill_locale: en_US
domain: government
appearance: combined log format, passport in a path, token in a query string
scenario: nginx access of a federal passport appointment site, where lookups put the passport number in the path and reschedule links carry a token
⟬text⟭
⟬ip_address#1⟭ - - [⟬date#1⟭ 08:30:11 -0400] "GET /appointments/lookup/⟬us_passport#2⟭ HTTP/1.1" 200 2204 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/121.0"
⟬ip_address#1⟭ - - [⟬date#1⟭ 08:30:44 -0400] "GET /appointments/reschedule?t=⟬opaque_token#1⟭ HTTP/1.1" 200 3120 "⟬url#1⟭" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/121.0"
⟬ip_address#2⟭ - - [⟬date#1⟭ 08:31:02 -0400] "GET /appointments/lookup/⟬us_passport#3⟭ HTTP/1.1" 404 212 "-" "Mozilla/5.0 (iPhone; CPU iPhone OS 17_3 like Mac OS X)"
⟬ip_address#3⟭ - - [⟬date#1⟭ 08:31:30 -0400] "GET /offices?state=⟬trap:word_name|Georgia⟭ HTTP/1.1" 200 4120 "-" "Mozilla/5.0 (compatible; bingbot/2.0)"
⟬ip_address#4⟭ - - [⟬date#1⟭ 08:32:05 -0400] "GET /healthz HTTP/1.1" 200 2 "-" "kube-probe/1.29"
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: en
fill_locale: en_US
domain: travel
appearance: Bitbucket Pipelines step, curl command, JWT in a job log, password in a command
scenario: Bitbucket Pipelines step of a tour booking site, whose smoke test logs in with a password on the command line and echoes the returned JWT
⟬text⟭
+ npm run smoke -- --user ⟬trap:indicator_non_pii|smoke-bot⟭ --password ⟬password#1⟭

> ⟬trap:email_lookalike|tours@4.2.0⟭ smoke
> node scripts/smoke.js

login ok, bearer ⟬jwt#1⟭
GET ⟬url#1⟭ -> 200
GET ⟬url#2⟭ -> 200
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: en
fill_locale: en_US
domain: fintech
appearance: plain sentences, gendered names, value without a key, compliance trail, multi-day trail
scenario: compliance trail of a brokerage over two days, written as sentences by a case tool, following a suspicious account with identity documents and addresses dropped in mid-sentence
⟬text⟭
[⟬date#2⟭ 08:02:14] ⟬person_name#1⟭ opened review ⟬ticket_id#1⟭ on account ⟬customer_id#2⟭.
[⟬date#2⟭ 08:02:40] System attached the onboarding file for Mrs ⟬person_name#2f⟭.
[⟬date#2⟭ 08:03:11] ⟬person_name#1⟭ viewed identity document ⟬us_passport#2⟭.
[⟬date#2⟭ 08:03:58] ⟬person_name#1⟭ viewed ⟬us_driver_license#2⟭ issued in ⟬trap:word_name|Georgia⟭.
[⟬date#2⟭ 08:04:30] ⟬person_name#1⟭ revealed ⟬us_ssn#2⟭ for a bureau check.
[⟬date#2⟭ 08:05:02] Bureau returned one address, ⟬postal_address#2⟭, since ⟬date#3⟭.
[⟬date#2⟭ 08:05:03] Bureau returned one more address, ⟬postal_address#3⟭, since ⟬date#4⟭.
[⟬date#2⟭ 08:06:44] ⟬person_name#1⟭ noted that her husband ⟬person_name#3m⟭ has power of attorney on the account.
[⟬date#2⟭ 08:07:20] ⟬person_name#1⟭ requested the power of attorney form from records-team.
[⟬date#2⟭ 08:30:00] Trade surveillance alert 41 linked to the case by surveillance-bot.
[⟬date#2⟭ 08:30:01] Alert 41: 18 buy orders before an earnings release of ⟬company#4⟭.
[⟬date#2⟭ 08:31:17] ⟬person_name#1⟭ assigned the case to ⟬person_name#5⟭.
[⟬date#2⟭ 09:12:05] ⟬person_name#5⟭ accepted the case.
[⟬date#2⟭ 09:13:40] ⟬person_name#5⟭ pulled transfers for the last 90 days.
[⟬date#2⟭ 09:13:41] System listed 7 outgoing ACH transfers.
[⟬date#2⟭ 09:15:22] ⟬person_name#5⟭ flagged a transfer to ⟬person_name#6⟭ at ⟬bank_account_number#6⟭.
[⟬date#2⟭ 09:16:08] ⟬person_name#5⟭ flagged a transfer to ⟬company#7⟭, ⟬postal_address#7⟭.
[⟬date#2⟭ 09:40:31] ⟬person_name#5⟭ asked legal-intake for a hold.
[⟬date#2⟭ 09:41:02] Legal intake replied that ⟬person_name#8⟭ will review by tomorrow.
[⟬date#2⟭ 10:02:47] Customer called from ⟬phone#2⟭ and asked for ⟬person_name#5⟭.
[⟬date#2⟭ 10:03:30] Call recording ⟬uuid#1⟭ attached.
[⟬date#2⟭ 10:18:12] ⟬person_name#5⟭ wrote: she says she never placed those orders herself.
[⟬date#2⟭ 10:19:00] ⟬person_name#5⟭ requested device history from fraud-ops.
[⟬date#2⟭ 10:44:15] Device history shows logins from ⟬ip_address#1⟭ and ⟬ip_address#2⟭.
[⟬date#2⟭ 10:45:02] Password reset forced by security-automation.
[⟬date#2⟭ 10:45:03] Temporary credential ⟬password#1⟭ sent to the address of record.
[⟬date#2⟭ 11:30:58] ⟬person_name#5⟭ set the account to restricted.
[⟬date#2⟭ 11:31:00] System blocked ACH and wires on ⟬customer_id#2⟭.
[⟬date#2⟭ 13:02:19] ⟬person_name#8⟭ opened the hold request.
[⟬date#2⟭ 13:20:44] ⟬person_name#8⟭ approved the hold, reference ⟬ticket_id#2⟭.
[⟬date#2⟭ 13:21:10] ⟬person_name#8⟭ asked for the passport copy of ⟬person_name#6⟭.
[⟬date#2⟭ 14:05:37] Correspondent bank sent passport ⟬us_passport#6⟭ and license ⟬us_driver_license#6⟭.
[⟬date#2⟭ 14:06:20] ⟬person_name#5⟭ matched ⟬person_name#6⟭ with a former employee of ⟬company#4⟭.
[⟬date#2⟭ 14:40:12] ⟬person_name#5⟭ escalated to the chief compliance officer.
[⟬date#2⟭ 15:02:03] ⟬person_name#9⟭ acknowledged the escalation.
[⟬date#2⟭ 16:30:00] Daily case digest sent to ⟬email:generic#10⟭.
[⟬date#2⟭ 17:45:41] ⟬person_name#5⟭ closed the day with 4 open tasks.
[⟬date#1⟭ 08:01:09] ⟬person_name#5⟭ resumed review ⟬ticket_id#1⟭.
[⟬date#1⟭ 08:02:33] ⟬person_name#5⟭ called Mrs ⟬person_name#2f⟭ at ⟬phone#2⟭.
[⟬date#1⟭ 08:15:18] Call ended, recording ⟬uuid#2⟭ attached.
[⟬date#1⟭ 08:16:02] ⟬person_name#5⟭ wrote: she confirmed her husband used the laptop.
[⟬date#1⟭ 08:40:11] ⟬person_name#8⟭ requested a SAR draft.
[⟬date#1⟭ 09:02:50] Draft ⟬uuid#3⟭ created by sar-template-bot.
[⟬date#1⟭ 09:30:14] ⟬person_name#5⟭ added subject ⟬person_name#3m⟭, SSN ⟬us_ssn#3⟭, born ⟬birth_date#3⟭.
[⟬date#1⟭ 09:31:27] ⟬person_name#5⟭ added subject ⟬person_name#6⟭, SSN ⟬us_ssn#6⟭, born ⟬birth_date#6⟭.
[⟬date#1⟭ 10:12:05] ⟬person_name#8⟭ reviewed the draft.
[⟬date#1⟭ 10:44:39] ⟬person_name#9⟭ signed the filing decision.
[⟬date#1⟭ 10:45:00] Filing queued to the regulator gateway ⟬hostname#1⟭.
[⟬date#1⟭ 11:02:18] Gateway receipt ⟬uuid#4⟭ received.
[⟬date#1⟭ 11:03:02] ⟬person_name#5⟭ set the retention flag on the case.
[⟬date#1⟭ 11:15:47] System exported the case to ⟬file_path#1⟭.
[⟬date#1⟭ 11:16:30] Export checksum ⟬hash#1⟭.
[⟬date#1⟭ 12:00:00] Weekly metrics refreshed by reporting-job.
[⟬date#1⟭ 13:27:33] ⟬person_name#1⟭ added a lesson learned to the case.
[⟬date#1⟭ 13:40:50] ⟬person_name#5⟭ removed the restriction on ⟬customer_id#2⟭ after new credentials were issued.
[⟬date#1⟭ 13:41:12] New credential ⟬opaque_token#1⟭ issued to the broker API.
[⟬date#1⟭ 14:05:01] Customer notified at ⟬email#2⟭.
[⟬date#1⟭ 14:30:44] Advisor ⟬person_name#11⟭ informed by phone.
[⟬date#1⟭ 15:12:20] ⟬person_name#11⟭ asked for a copy of the restriction letter.
[⟬date#1⟭ 15:13:02] Letter sent to ⟬postal_address#2⟭.
[⟬date#1⟭ 15:30:00] Task list empty.
[⟬date#1⟭ 15:31:18] ⟬person_name#5⟭ marked review ⟬ticket_id#1⟭ as closed.
[⟬date#1⟭ 15:31:19] System scheduled the 90 day follow-up.
[⟬date#1⟭ 15:31:20] Audit chain sealed by audit-sealer.
⟬end⟭

⟬template⟭
family: logs
format: application log
language: en
fill_locale: en_US
domain: retail
appearance: Winston log line, nested context, plate in a sentence, secret under an innocuous key
scenario: Winston log of an appliance retailer's delivery routing, with drivers, customers, a truck plate and a partner token under ref
⟬text⟭
⟬date#1⟭ 06:02:14 [info] routing: loading 41 deliveries for depot ⟬trap:word_name|Charlotte-south⟭
⟬date#1⟭ 06:02:15 [info] routing: driver ⟬person_name#1⟭ assigned to truck "⟬us_license_plate#1⟭"
⟬date#1⟭ 06:02:15 [info] routing: driver ⟬trap:indicator_non_pii|unassigned⟭ on route 7, waiting for dispatch
⟬date#1⟭ 06:02:16 [debug] partner: pushing route to ⟬url#1⟭ ref=⟬opaque_token#1⟭
⟬date#1⟭ 06:02:16 [debug] partner: stored acknowledgement ref=⟬order_number#1⟭
⟬date#1⟭ 06:02:40 [debug] stop 1: "⟬person_name#2⟭" at "⟬postal_address#2⟭" phone ⟬phone#2⟭ item=fridge
⟬date#1⟭ 06:02:40 [debug] stop 2: "⟬person_name#3⟭" at "⟬postal_address#3⟭" phone ⟬phone#3⟭ item=washer
⟬date#1⟭ 06:02:41 [debug] stop 3: "⟬company#4⟭" at "⟬postal_address#4⟭" contact "⟬person_name#4⟭"
⟬date#1⟭ 06:02:42 [warn] routing: stop 2 outside window, moved after stop 3
⟬date#1⟭ 09:14:05 [info] tracking: truck "⟬us_license_plate#1⟭" arrived at stop 1
⟬date#1⟭ 09:41:30 [info] tracking: signature captured for order ⟬order_number#2⟭, signed by ⟬person_name#2⟭
⟬date#1⟭ 10:02:18 [warn] tracking: customer not home at stop 3, neighbor ⟬person_name#5⟭ accepted
⟬date#1⟭ 10:02:19 [info] tracking: age verified by license "⟬us_driver_license#5⟭"
⟬date#1⟭ 11:30:44 [info] tracking: truck "⟬us_license_plate#1⟭" arrived at stop 2
⟬date#1⟭ 12:04:02 [error] tracking: gps gap of 612s for truck "⟬us_license_plate#6⟭", operator=⟬trap:indicator_non_pii|fleet-monitor⟭
⟬date#1⟭ 12:04:03 [info] tracking: ticket ⟬ticket_id#1⟭ opened
⟬date#1⟭ 17:02:00 [info] routing: day closed, delivered=39 failed=2 version=⟬version#1⟭
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: en
fill_locale: en_US
domain: government
appearance: .NET exception, inner exception, framework frames, field names without values
scenario: .NET exception in a county election results aggregator, raised on a precinct feed with a null count, with no voter data
⟬text⟭
Unhandled exception. System.InvalidOperationException: Nullable object must have a value.
   at System.Nullable`1.get_Value()
   at County.Elections.Aggregator.TallyBuilder.AddPrecinct(PrecinctFeed feed) in /src/Aggregator/TallyBuilder.cs:line 141
   at County.Elections.Aggregator.TallyBuilder.Build(IEnumerable`1 feeds) in /src/Aggregator/TallyBuilder.cs:line 88
   at County.Elections.Aggregator.Program.Main(String[] args) in /src/Aggregator/Program.cs:line 37
   --- End of stack trace from previous location ---
   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()
   at System.Threading.Tasks.Task.ThrowIfExceptionOccurred()
 ---> System.FormatException: Input string was not in a correct format.
   at System.Number.ThrowOverflowOrFormatException(ParsingStatus status, TypeCode type)
   at System.Int32.Parse(String s, IFormatProvider provider)
   at County.Elections.Feeds.CsvFeedReader.ReadCount(String value) in /src/Feeds/CsvFeedReader.cs:line 64
   --- End of inner exception stack trace ---
Feed: ⟬file_path#1⟭
Precinct: 0417, ward ⟬trap:word_name|Madison⟭
Columns: contest, candidate_slot, ⟬trap:indicator_non_pii|voter_name=omitted⟭, ballots_cast
Build: ⟬version#1⟭
⟬end⟭

⟬template⟭
family: logs
format: test output
language: en
fill_locale: en_US
domain: travel
appearance: behave output, Gherkin steps, captured stdout, test fixture, multi-line table
scenario: behave run of a flight rebooking feature at an airline, whose step tables and captured stdout show fixture passengers with passports, cards, a plate for airport parking and addresses
⟬text⟭
Feature: Rebooking after a cancelled flight # features/rebooking.feature:1

  Background: Passengers on a cancelled flight  # features/rebooking.feature:3
    Given the following passengers                # features/steps/fixtures.py:14
      | name              | passport          | tier   |
      | ⟬person_name#1⟭ | ⟬us_passport#1⟭ | gold   |
      | ⟬person_name#2⟭ | ⟬us_passport#2⟭ | silver |
      | ⟬person_name#3⟭ | ⟬us_passport#3⟭ | none   |
    And flight AZ318 to ⟬trap:word_name|Sydney⟭ is cancelled # features/steps/flights.py:9

  Scenario: Gold member is rebooked first         # features/rebooking.feature:12
    When the rebooking job runs                   # features/steps/rebooking.py:21
    Then "⟬person_name#1⟭" has a seat on AZ502    # features/steps/rebooking.py:40

  Scenario: Hotel voucher for an overnight delay  # features/rebooking.feature:18
    When the rebooking job runs                   # features/steps/rebooking.py:21
    Then "⟬person_name#2⟭" gets a hotel voucher   # features/steps/vouchers.py:12
      Assertion Failed: expected voucher at ⟬trap:company_name|Hilton⟭, got none
      Captured stdout:
      [fixture] voucher lookup for ⟬customer_id#2⟭, home "⟬postal_address#2⟭"
      [fixture] token ⟬opaque_token#1⟭ for hotel partner
      [fixture] partner answered 503

  Scenario: Refund to the original card           # features/rebooking.feature:25
    When "⟬person_name#3⟭" asks for a refund      # features/steps/refunds.py:18
    Then the card is refunded 412.00              # features/steps/refunds.py:31
      Assertion Failed: refund 412.00 not found
      Captured stdout:
      [fixture] original tender ⟬payment_card#3⟭ cvv ⟬card_security_code#3⟭
      [fixture] gateway ref ⟬uuid#1⟭
      [fixture] gateway said: card expired on ⟬date#1⟭

  Scenario: Parking extension for a rebooked traveler  # features/rebooking.feature:33
    Given "⟬person_name#3⟭" parked at the airport with plate "⟬us_license_plate#3⟭"  # features/steps/parking.py:8
    When the rebooking job runs                   # features/steps/rebooking.py:21
    Then the parking pass is extended by 1 day    # features/steps/parking.py:22

  Scenario: Agent override needs a reason         # features/rebooking.feature:39
    Given agent ⟬trap:indicator_non_pii|"gate-agent-test"⟭ is logged in  # features/steps/agents.py:7
    When the agent overrides the seat             # features/steps/agents.py:19
    Then the audit log holds the reason           # features/steps/agents.py:33

  Scenario: Unaccompanied traveler stays on the desk list  # features/rebooking.feature:45
    Given a passenger without a mobile number     # features/steps/fixtures.py:40
    When the rebooking job runs                   # features/steps/rebooking.py:21
    Then the passenger appears on the desk list   # features/steps/desk.py:11

  Scenario: Connection protected at the hub       # features/rebooking.feature:51
    Given a connection through ⟬trap:word_name|Charlotte⟭ # features/steps/flights.py:30
    When the rebooking job runs                   # features/steps/rebooking.py:21
    Then the connection is kept                   # features/steps/rebooking.py:58

Failing scenarios:
  features/rebooking.feature:18  Hotel voucher for an overnight delay
  features/rebooking.feature:25  Refund to the original card

0 features passed, 1 failed, 0 skipped
4 scenarios passed, 2 failed, 0 skipped
31 steps passed, 2 failed, 0 skipped, 0 undefined
Took 0m1.412s

Mail sent to ⟬email:generic#4⟭ with the report ⟬file_path#1⟭, built by ⟬username#1⟭ on ⟬hostname#1⟭
⟬end⟭

⟬template⟭
family: logs
format: access log
language: en
fill_locale: en_US
domain: fintech
appearance: compact access line, market data paths, SDK user agent, stand-ins in a query string
scenario: one minute of access to a public market data API, hit by SDKs and scrapers, where parameters mention customers and keys without holding any
⟬text⟭
⟬date#1⟭ 07:00:01.018 ⟬ip_address#1⟭ GET /v1/rates/USD-EUR 200 412 3ms "sdk-python/⟬version#1⟭" meta="-"
⟬date#1⟭ 07:00:01.204 ⟬ip_address#1⟭ GET /v1/rates/USD-GBP 200 410 3ms "sdk-python/⟬version#1⟭" meta="-"
⟬date#1⟭ 07:00:01.390 ⟬ip_address#2⟭ GET /v1/rates/USD-JPY 200 411 4ms "sdk-node/⟬version#2⟭" meta="-"
⟬date#1⟭ 07:00:01.602 ⟬ip_address#3⟭ GET /v1/quotes/AAPL 200 880 6ms "sdk-java/⟬version#3⟭" meta="-"
⟬date#1⟭ 07:00:01.811 ⟬ip_address#3⟭ GET /v1/quotes/MSFT 200 874 5ms "sdk-java/⟬version#3⟭" meta="cache=hit"
⟬date#1⟭ 07:00:02.040 ⟬ip_address#4⟭ GET /v1/quotes/F 200 852 5ms "curl/8.4.0" meta="-"
⟬date#1⟭ 07:00:02.255 ⟬ip_address#5⟭ GET /v1/indices/SPX 200 1204 7ms "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/121.0" meta="-"
⟬date#1⟭ 07:00:02.470 ⟬ip_address#5⟭ GET /v1/indices/NDX 200 1198 7ms "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/121.0" meta="-"
⟬date#1⟭ 07:00:02.712 ⟬ip_address#6⟭ GET /v1/models/⟬trap:eponym|black-scholes⟭?strike=100&vol=0.2 200 96 9ms "sdk-python/⟬version#1⟭" meta="-"
⟬date#1⟭ 07:00:02.933 ⟬ip_address#6⟭ GET /v1/models/monte-carlo?paths=10000 200 118 41ms "sdk-python/⟬version#1⟭" meta="cache=hit"
⟬date#1⟭ 07:00:03.140 ⟬ip_address#7⟭ GET /v1/calendar?exchange=NYSE 200 2204 4ms "PostmanRuntime/7.36.1" meta="-"
⟬date#1⟭ 07:00:03.361 ⟬ip_address#8⟭ GET /v1/rates?⟬trap:indicator_non_pii|customer=sandbox⟭ 200 8120 11ms "sdk-go/⟬version#4⟭" meta="-"
⟬date#1⟭ 07:00:03.588 ⟬ip_address#8⟭ GET /v1/rates?⟬trap:indicator_non_pii|user=demo⟭ 200 8120 10ms "sdk-go/⟬version#4⟭" meta="-"
⟬date#1⟭ 07:00:03.790 ⟬ip_address#9⟭ GET /v1/usage?⟬trap:indicator_non_pii|api_key_header=X-Api-Key⟭ 400 88 1ms "curl/8.5.0" meta="-"
⟬date#1⟭ 07:00:04.011 ⟬ip_address#9⟭ GET /v1/usage?api_key=⟬trap:placeholder|YOUR_API_KEY⟭ 401 74 1ms "curl/8.5.0" meta="cache=hit"
⟬date#1⟭ 07:00:04.230 ⟬ip_address#10⟭ GET /v1/rates/EUR-USD 200 412 3ms "sdk-python/⟬version#5⟭" meta="-"
⟬date#1⟭ 07:00:04.452 ⟬ip_address#10⟭ GET /v1/rates/GBP-USD 200 409 3ms "sdk-python/⟬version#5⟭" meta="-"
⟬date#1⟭ 07:00:04.660 ⟬ip_address#11⟭ GET /healthz 200 2 0ms "kube-probe/1.29" meta="-"
⟬date#1⟭ 07:00:04.881 ⟬ip_address#12⟭ GET /v1/quotes/JPM 200 866 6ms "sdk-java/⟬version#3⟭" meta="-"
⟬date#1⟭ 07:00:05.104 ⟬ip_address#12⟭ GET /v1/quotes/GS 200 860 6ms "sdk-java/⟬version#3⟭" meta="cache=hit"
⟬date#1⟭ 07:00:05.320 ⟬ip_address#13⟭ GET /v1/quotes/WFC 200 858 5ms "Mozilla/5.0 (Macintosh; Intel Mac OS X 14_2) Safari/605.1.15" meta="-"
⟬date#1⟭ 07:00:05.541 ⟬ip_address#14⟭ GET /v1/companies/⟬trap:company_name|goldman-sachs⟭/profile 200 3120 8ms "python-requests/2.31.0" meta="-"
⟬date#1⟭ 07:00:05.760 ⟬ip_address#14⟭ GET /v1/companies/⟬trap:company_name|wells-fargo⟭/profile 200 3044 8ms "python-requests/2.31.0" meta="-"
⟬date#1⟭ 07:00:05.982 ⟬ip_address#14⟭ GET /v1/companies/⟬trap:company_name|morgan-stanley⟭/profile 200 3102 8ms "python-requests/2.31.0" meta="-"
⟬date#1⟭ 07:00:06.204 ⟬ip_address#15⟭ GET /v1/fx/fixings?date=latest 200 1820 5ms "sdk-node/⟬version#2⟭" meta="cache=hit"
⟬date#1⟭ 07:00:06.410 ⟬ip_address#15⟭ GET /v1/fx/fixings?date=previous 200 1820 5ms "sdk-node/⟬version#2⟭" meta="-"
⟬date#1⟭ 07:00:06.633 ⟬ip_address#16⟭ GET /v1/rates/stream 101 0 2ms "websocket-client/1.7.0" meta="-"
⟬date#1⟭ 07:00:06.851 ⟬ip_address#17⟭ GET /v1/search?q=⟬trap:company_name|Disney⟭ 200 610 12ms "Mozilla/5.0 (iPhone; CPU iPhone OS 17_3 like Mac OS X)" meta="-"
⟬date#1⟭ 07:00:07.070 ⟬ip_address#17⟭ GET /v1/search?q=⟬trap:company_name|Boeing⟭ 200 588 11ms "Mozilla/5.0 (iPhone; CPU iPhone OS 17_3 like Mac OS X)" meta="-"
⟬date#1⟭ 07:00:07.292 ⟬ip_address#18⟭ GET /docs/errors 200 12040 4ms "Mozilla/5.0 (X11; Linux x86_64) Firefox/122.0" meta="cache=hit"
⟬date#1⟭ 07:00:07.504 ⟬ip_address#19⟭ GET /wp-login.php 404 162 1ms "python-requests/2.28.1" meta="-"
⟬date#1⟭ 07:00:07.711 ⟬ip_address#19⟭ GET /.env 404 162 1ms "python-requests/2.28.1" meta="-"
⟬date#1⟭ 07:00:07.930 ⟬ip_address#20⟭ GET /v1/rates/USD-CHF 200 410 3ms "sdk-python/⟬version#1⟭" meta="-"
⟬date#1⟭ 07:00:08.144 ⟬ip_address#20⟭ GET /v1/rates/USD-CAD 200 410 3ms "sdk-python/⟬version#1⟭" meta="-"
⟬date#1⟭ 07:00:08.362 ⟬ip_address#21⟭ GET /v1/quotes/XOM 200 862 5ms "sdk-java/⟬version#3⟭" meta="cache=hit"
⟬date#1⟭ 07:00:08.580 ⟬ip_address#21⟭ GET /v1/quotes/CVX 200 860 5ms "sdk-java/⟬version#3⟭" meta="-"
⟬date#1⟭ 07:00:08.802 ⟬ip_address#22⟭ GET /v1/portfolio/sample?⟬trap:indicator_non_pii|owner=demo-account⟭ 200 4410 14ms "sdk-python/⟬version#5⟭" meta="-"
⟬date#1⟭ 07:00:09.021 ⟬ip_address#22⟭ GET /v1/portfolio/sample/risk?method=⟬trap:eponym|value-at-risk-cornish-fisher⟭ 200 512 22ms "sdk-python/⟬version#5⟭" meta="-"
⟬date#1⟭ 07:00:09.240 ⟬ip_address#23⟭ GET /v1/rates/USD-AUD 200 411 3ms "sdk-node/⟬version#2⟭" meta="-"
⟬date#1⟭ 07:00:09.455 ⟬ip_address#23⟭ GET /v1/rates/USD-MXN 200 411 3ms "sdk-node/⟬version#2⟭" meta="cache=hit"
⟬date#1⟭ 07:00:09.672 ⟬ip_address#24⟭ GET /status 200 1204 2ms "UptimeProbe/2.1" meta="-"
⟬date#1⟭ 07:00:09.891 ⟬ip_address#11⟭ GET /healthz 200 2 0ms "kube-probe/1.29" meta="-"
⟬date#1⟭ 07:00:10.110 ⟬ip_address#25⟭ GET /v1/bonds/UST10Y 200 720 6ms "sdk-java/⟬version#3⟭" meta="-"
⟬date#1⟭ 07:00:10.332 ⟬ip_address#25⟭ GET /v1/bonds/UST2Y 200 716 6ms "sdk-java/⟬version#3⟭" meta="-"
⟬date#1⟭ 07:00:10.550 ⟬ip_address#26⟭ GET /v1/crypto/BTC-USD 200 402 4ms "sdk-python/⟬version#1⟭" meta="cache=hit"
⟬date#1⟭ 07:00:10.771 ⟬ip_address#26⟭ GET /v1/crypto/ETH-USD 200 402 4ms "sdk-python/⟬version#1⟭" meta="-"
⟬date#1⟭ 07:00:10.990 ⟬ip_address#27⟭ GET /v1/news?ticker=F&limit=5 200 4120 16ms "Mozilla/5.0 (Linux; Android 14) Chrome/120.0" meta="-"
⟬date#1⟭ 07:00:11.204 ⟬ip_address#27⟭ GET /v1/news?ticker=DIS&limit=5 200 4088 15ms "Mozilla/5.0 (Linux; Android 14) Chrome/120.0" meta="-"
⟬date#1⟭ 07:00:11.430 ⟬ip_address#28⟭ GET /v1/rates?base=USD&format=csv 200 9120 12ms "curl/8.4.0" meta="-"
⟬date#1⟭ 07:00:11.641 ⟬ip_address#29⟭ GET /v1/limits?⟬trap:indicator_non_pii|token_ttl=3600⟭ 200 180 2ms "sdk-go/⟬version#4⟭" meta="cache=hit"
⟬date#1⟭ 07:00:11.860 ⟬ip_address#30⟭ GET /v1/quotes/KO 200 846 5ms "sdk-java/⟬version#3⟭" meta="-"
⟬date#1⟭ 07:00:12.081 ⟬ip_address#30⟭ GET /v1/quotes/PEP 200 848 5ms "sdk-java/⟬version#3⟭" meta="-"
⟬date#1⟭ 07:00:12.300 ⟬ip_address#31⟭ GET /v1/rates/USD-INR 200 411 3ms "sdk-python/⟬version#5⟭" meta="-"
⟬date#1⟭ 07:00:12.522 ⟬ip_address#31⟭ GET /v1/rates/USD-BRL 200 411 3ms "sdk-python/⟬version#5⟭" meta="-"
⟬date#1⟭ 07:00:12.740 ⟬ip_address#32⟭ GET /robots.txt 200 88 1ms "Mozilla/5.0 (compatible; bingbot/2.0)" meta="cache=hit"
⟬date#1⟭ 07:00:12.960 ⟬ip_address#32⟭ GET /sitemap.xml 200 4120 1ms "Mozilla/5.0 (compatible; bingbot/2.0)" meta="-"
⟬date#1⟭ 07:00:13.181 ⟬ip_address#33⟭ GET /v1/options/AAPL/chain?greeks=true 200 41208 31ms "sdk-python/⟬version#1⟭" meta="-"
⟬date#1⟭ 07:00:13.402 ⟬ip_address#33⟭ GET /v1/options/MSFT/chain?greeks=true 200 40120 30ms "sdk-python/⟬version#1⟭" meta="-"
⟬date#1⟭ 07:00:13.620 ⟬ip_address#34⟭ GET /v1/rates/USD-SEK 200 410 3ms "sdk-node/⟬version#2⟭" meta="-"
⟬date#1⟭ 07:00:13.842 ⟬ip_address#34⟭ GET /v1/rates/USD-NOK 200 410 3ms "sdk-node/⟬version#2⟭" meta="cache=hit"
⟬date#1⟭ 07:00:14.061 ⟬ip_address#35⟭ GET /v1/quotes/NKE 200 852 5ms "curl/8.4.0" meta="-"
⟬date#1⟭ 07:00:14.280 ⟬ip_address#35⟭ GET /v1/quotes/SBUX 200 852 5ms "curl/8.4.0" meta="-"
⟬date#1⟭ 07:00:14.502 ⟬ip_address#11⟭ GET /healthz 200 2 0ms "kube-probe/1.29" meta="-"
⟬date#1⟭ 07:00:14.721 ⟬ip_address#24⟭ GET /status 200 1204 2ms "UptimeProbe/2.1" meta="-"
⟬date#1⟭ 07:00:14.940 ⟬ip_address#36⟭ GET /v1/rates/EUR-CHF 200 412 3ms "sdk-python/⟬version#5⟭" meta="cache=hit"
⟬end⟭
