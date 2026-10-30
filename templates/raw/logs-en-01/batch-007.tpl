⟬template⟭
family: logs
format: application log
language: en
fill_locale: en_US
domain: government
appearance: bracketed level, traffic signal telemetry, corridor names, operator field
scenario: traffic management center of a city, adjusting signal plans along corridors named like people, with operators recorded as shifts and no person
⟬text⟭
[INFO ] ⟬date#1⟭ 07:00:00 tmc.plan: morning peak plan ⟬version#1⟭ loaded for 41 corridors
[INFO ] ⟬date#1⟭ 07:00:02 tmc.corridor: ⟬trap:word_name|Virginia-avenue⟭ cycle=120s offset=18 volume=1204
[INFO ] ⟬date#1⟭ 07:00:02 tmc.corridor: ⟬trap:word_name|Madison-street⟭ cycle=110s offset=22 volume=982
[WARN ] ⟬date#1⟭ 07:00:03 tmc.corridor: ⟬trap:word_name|Charlotte-pike⟭ detector 4 stuck, falling back to fixed time
[INFO ] ⟬date#1⟭ 07:02:15 tmc.incident: lane closure at mile 41, ⟬trap:indicator_non_pii|reported_by=camera-118⟭
[INFO ] ⟬date#1⟭ 07:02:16 tmc.incident: ticket ⟬ticket_id#1⟭ opened, ⟬trap:indicator_non_pii|owner=traffic-ops-a⟭
[INFO ] ⟬date#1⟭ 07:03:00 tmc.plan: incident plan applied by ⟬trap:indicator_non_pii|operator=shift-a⟭
[INFO ] ⟬date#1⟭ 07:05:00 tmc.stats: mean_delay_s=41 stops_per_veh=1.8 queue_max_m=412
[INFO ] ⟬date#1⟭ 07:10:00 tmc.stats: mean_delay_s=52 stops_per_veh=2.1 queue_max_m=508
[DEBUG] ⟬date#1⟭ 07:10:01 tmc.model: smoothing with ⟬trap:eponym|Kalman⟭ filter, gain=0.42
[INFO ] ⟬date#1⟭ 07:15:00 tmc.stats: mean_delay_s=47 stops_per_veh=1.9 queue_max_m=466
[INFO ] ⟬date#1⟭ 07:18:42 tmc.incident: lane reopened, ticket ⟬ticket_id#1⟭ closed
[INFO ] ⟬date#1⟭ 07:18:43 tmc.plan: back to peak plan ⟬version#1⟭
[INFO ] ⟬date#1⟭ 07:20:00 tmc.stats: mean_delay_s=39 stops_per_veh=1.7 queue_max_m=380
[DEBUG] ⟬date#1⟭ 07:20:01 tmc.export: open data feed pushed to ⟬url#1⟭ with ⟬trap:indicator_non_pii|plate_data=excluded⟭
[INFO ] ⟬date#1⟭ 07:25:00 tmc.stats: mean_delay_s=36 stops_per_veh=1.6 queue_max_m=344
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: en
fill_locale: en_US
domain: travel
appearance: Kotlin exception, data class toString, plate and passport
scenario: Kotlin exception in a car sharing app, whose message prints the reservation with the vehicle plate and the renter's passport
⟬text⟭
java.lang.IllegalStateException: pickup refused for Reservation(id=⟬uuid#1⟭, renter="⟬person_name#1⟭", passport=⟬us_passport#1⟭, plate="⟬us_license_plate#2⟭", station=⟬trap:word_name|Austin⟭)
	at com.roamshare.pickup.PickupService.start(PickupService.kt:74)
	at com.roamshare.pickup.PickupController.pickup(PickupController.kt:31)
	at jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103)
⟬end⟭

⟬template⟭
family: logs
format: test output
language: en
fill_locale: en_US
domain: fintech
appearance: JUnit console launcher tree, test names, eponyms, stand-in values
scenario: JUnit tree of a derivatives pricing library, full of models named after people and stand-in accounts, with no real customer or secret
⟬text⟭
Thanks for using JUnit! Support its development at https://junit.org/sponsoring

.
├─ JUnit Jupiter ✔
│  ├─ ⟬trap:code_identifier|BlackScholesPricerTest⟭ ✔
│  │  ├─ callPriceMatchesClosedForm() ✔
│  │  ├─ putCallParity() ✔
│  │  ├─ deltaIsBetweenZeroAndOne() ✔
│  │  └─ vegaIsPositive() ✔
│  ├─ ⟬trap:code_identifier|HestonModelTest⟭ ✔
│  │  ├─ calibratesToSurface() ✔
│  │  ├─ fellerConditionHolds() ✔
│  │  └─ characteristicFunctionIsStable() ✔
│  ├─ ⟬trap:code_identifier|HullWhiteCurveTest⟭ ✔
│  │  ├─ fitsInitialTermStructure() ✔
│  │  └─ meanReversionIsPositive() ✔
│  ├─ ⟬trap:code_identifier|CoxIngersollRossTest⟭ ✔
│  │  ├─ ratesStayPositive() ✔
│  │  └─ bondPriceMatchesAnalytic() ✔
│  ├─ ⟬trap:code_identifier|VasicekModelTest⟭ ✔
│  │  └─ longRunMeanIsReached() ✔
│  ├─ ⟬trap:code_identifier|BachelierNormalModelTest⟭ ✘ expected: <12.40> but was: <12.41>
│  │  ├─ atTheMoneyPrice() ✘ expected: <12.40> but was: <12.41>
│  │  └─ impliedNormalVol() ✔
│  ├─ CurveBootstrapTest ✔
│  │  ├─ deposits() ✔
│  │  ├─ futures() ✔
│  │  └─ swaps() ✔
│  ├─ DayCountTest ✔
│  │  ├─ actual360() ✔
│  │  ├─ actual365() ✔
│  │  └─ thirty360() ✔
│  ├─ CalendarTest ✔
│  │  ├─ newYorkHolidays() ✔
│  │  └─ londonHolidays() ✔
│  ├─ PortfolioRiskTest ✔
│  │  ├─ ⟬trap:code_identifier|cornishFisherVar⟭() ✔
│  │  ├─ ⟬trap:code_identifier|choleskyCorrelation⟭() ✔
│  │  └─ ⟬trap:code_identifier|gaussianCopula⟭() ✔
│  ├─ FixtureLoaderTest ✔
│  │  ├─ ⟬trap:indicator_non_pii|loadsAccount(ACC_000000)⟭ ✔
│  │  ├─ ⟬trap:indicator_non_pii|loadsCustomer(customer=sandbox)⟭ ✔
│  │  └─ ⟬trap:indicator_non_pii|rejectsOwner(owner=<NAME>)⟭ ✔
│  ├─ SecretsConfigTest ✔
│  │  ├─ ⟬trap:indicator_non_pii|tokenTtlDefaultsTo3600()⟭ ✔
│  │  ├─ ⟬trap:indicator_non_pii|passwordMinLengthIs14()⟭ ✔
│  │  └─ apiKeyIsRead(⟬trap:placeholder|${MARKET_API_KEY}⟭) ✔
│  └─ ⟬trap:code_identifier|MonteCarloSobolSequenceTest⟭ ✔
│     ├─ lowDiscrepancy() ✔
│     └─ reproducibleWithSeed() ✔
├─ JUnit Vintage ✔
└─ JUnit Platform Suite ✔

Failures (1):
  JUnit Jupiter:⟬trap:code_identifier|BachelierNormalModelTest⟭:atTheMoneyPrice()
    MethodSource [className = 'com.deltaedge.pricing.⟬trap:code_identifier|BachelierNormalModelTest⟭', methodName = 'atTheMoneyPrice', methodParameterTypes = '']
    => org.opentest4j.AssertionFailedError: expected: <12.40> but was: <12.41>
       org.junit.jupiter.api.AssertionUtils.fail(AssertionUtils.java:55)
       org.junit.jupiter.api.AssertEquals.assertEquals(AssertEquals.java:197)
       com.deltaedge.pricing.⟬trap:code_identifier|BachelierNormalModelTest⟭.atTheMoneyPrice(⟬trap:code_identifier|BachelierNormalModelTest⟭.java:41)

Test run finished after 2118 ms
[        15 containers found      ]
[         0 containers skipped    ]
[        15 containers started    ]
[         0 containers aborted    ]
[        15 containers successful ]
[         0 containers failed     ]
[        32 tests found           ]
[         0 tests skipped         ]
[        32 tests started         ]
[         0 tests aborted         ]
[        31 tests successful      ]
[         1 tests failed          ]
⟬end⟭

⟬template⟭
family: logs
format: access log
language: en
fill_locale: en_US
domain: SaaS
appearance: Kong proxy log, consumer field, API key in a logged header, password in a context field, JWT
scenario: Kong gateway log of a messaging API, recording the consumer and the API key header, with consumers that are sometimes people and sometimes integrations
⟬text⟭
⟬ip_address#1⟭ - - [⟬date#1⟭ 14:02:11 +0000] "POST /v2/messages HTTP/1.1" 202 88 "-" "sdk-go/⟬version#1⟭" route=messages consumer=⟬trap:indicator_non_pii|acme-integration⟭ apikey="⟬opaque_token#1⟭" latency=41
⟬ip_address#1⟭ - - [⟬date#1⟭ 14:02:12 +0000] "POST /v2/messages HTTP/1.1" 202 88 "-" "sdk-go/⟬version#1⟭" route=messages consumer=⟬trap:indicator_non_pii|acme-integration⟭ apikey="⟬opaque_token#1⟭" latency=38
⟬ip_address#2⟭ - - [⟬date#1⟭ 14:02:15 +0000] "GET /v2/threads?limit=50 HTTP/1.1" 200 8120 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 14_2) Chrome/121.0" route=threads consumer="⟬person_name#2⟭" apikey="-" auth="Bearer ⟬jwt#1⟭" latency=61
⟬ip_address#2⟭ - - [⟬date#1⟭ 14:02:21 +0000] "GET /v2/threads/⟬uuid#1⟭ HTTP/1.1" 200 2204 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 14_2) Chrome/121.0" route=threads consumer="⟬person_name#2⟭" apikey="-" auth="Bearer ⟬jwt#1⟭" latency=33
⟬ip_address#3⟭ - - [⟬date#1⟭ 14:02:30 +0000] "POST /v2/oauth/token HTTP/1.1" 200 412 "-" "curl/8.4.0" route=auth consumer=⟬trap:indicator_non_pii|anonymous⟭ apikey="-" extra="grant=password user=⟬email#3⟭ pw=⟬password#1⟭" latency=118
⟬ip_address#4⟭ - - [⟬date#1⟭ 14:02:44 +0000] "POST /v2/oauth/token HTTP/1.1" 401 74 "-" "python-requests/2.31.0" route=auth consumer=⟬trap:indicator_non_pii|anonymous⟭ apikey="-" extra="grant=password user=⟬trap:indicator_non_pii|admin⟭ pw=⟬password#2⟭" latency=112
⟬ip_address#5⟭ - - [⟬date#1⟭ 14:02:51 +0000] "GET /v2/usage HTTP/1.1" 200 610 "-" "sdk-python/⟬version#2⟭" route=usage consumer=⟬trap:indicator_non_pii|billing-sync⟭ apikey="⟬opaque_token#2⟭" latency=19
⟬ip_address#6⟭ - - [⟬date#1⟭ 14:03:02 +0000] "POST /v2/webhooks HTTP/1.1" 201 140 "-" "sdk-node/⟬version#3⟭" route=webhooks consumer="⟬person_name#4⟭" apikey="⟬opaque_token#3⟭" extra="target=⟬url#1⟭" latency=27
⟬ip_address#7⟭ - - [⟬date#1⟭ 14:03:15 +0000] "GET /status HTTP/1.1" 200 44 "-" "UptimeProbe/2.1" route=status consumer=⟬trap:indicator_non_pii|anonymous⟭ apikey="-" latency=1
⟬ip_address#8⟭ - - [⟬date#1⟭ 14:03:20 +0000] "POST /v2/messages HTTP/1.1" 429 96 "-" "sdk-go/⟬version#1⟭" route=messages consumer=⟬trap:indicator_non_pii|acme-integration⟭ apikey="⟬opaque_token#1⟭" latency=0
⟬ip_address#9⟭ - - [⟬date#1⟭ 14:03:33 +0000] "GET /v2/contacts?email=⟬email#5⟭ HTTP/1.1" 200 412 "-" "sdk-python/⟬version#2⟭" route=contacts consumer="⟬person_name#6⟭" apikey="⟬opaque_token#4⟭" latency=24
⟬ip_address#9⟭ - - [⟬date#1⟭ 14:03:40 +0000] "PATCH /v2/contacts/⟬uuid#2⟭ HTTP/1.1" 200 288 "-" "sdk-python/⟬version#2⟭" route=contacts consumer="⟬person_name#6⟭" apikey="⟬opaque_token#4⟭" extra="phone=⟬phone#5⟭" latency=31
⟬ip_address#10⟭ - - [⟬date#1⟭ 14:03:52 +0000] "GET /v2/files/⟬uuid#3⟭?download_token=⟬opaque_token#5⟭ HTTP/1.1" 200 88120 "⟬url#2⟭" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/121.0" route=files consumer=⟬trap:indicator_non_pii|anonymous⟭ apikey="-" latency=212
⟬ip_address#11⟭ - - [⟬date#1⟭ 14:04:05 +0000] "GET /v2/admin/tenants HTTP/1.1" 403 74 "-" "curl/8.4.0" route=admin consumer="⟬person_name#4⟭" apikey="⟬opaque_token#3⟭" latency=4
⟬ip_address#12⟭ - - [⟬date#1⟭ 14:04:18 +0000] "POST /v2/keys/rotate HTTP/1.1" 200 188 "-" "terraform-provider/⟬version#4⟭" route=keys consumer=⟬trap:indicator_non_pii|terraform-bot⟭ apikey="⟬opaque_token#6⟭" extra="key_id=⟬hash#1⟭" latency=52
⟬ip_address#7⟭ - - [⟬date#1⟭ 14:04:30 +0000] "GET /status HTTP/1.1" 200 44 "-" "UptimeProbe/2.1" route=status consumer=⟬trap:indicator_non_pii|anonymous⟭ apikey="-" latency=1
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: en
fill_locale: en_US
domain: healthcare
appearance: Argo CD sync output, Kubernetes resources, masked secret, health status
scenario: Argo CD sync of a patient scheduling platform, listing resources and health with a sealed secret and no value
⟬text⟭
+ argocd app sync scheduling-prod --prune --timeout 300
TIMESTAMP                  GROUP        KIND          NAMESPACE     NAME               STATUS    HEALTH        HOOK  MESSAGE
⟬date#1⟭ 20:14:02            apps   Deployment    scheduling    scheduling-api     Synced    Progressing         deployment.apps/scheduling-api configured
⟬date#1⟭ 20:14:02                   Service       scheduling    scheduling-api     Synced    Healthy             service/scheduling-api unchanged
⟬date#1⟭ 20:14:03    bitnami.com    SealedSecret  scheduling    scheduling-db      Synced    Healthy             sealedsecret.bitnami.com/scheduling-db unchanged
⟬date#1⟭ 20:14:03                   ConfigMap     scheduling    scheduling-config  Synced                        configmap/scheduling-config configured
⟬date#1⟭ 20:14:41            apps   Deployment    scheduling    scheduling-api     Synced    Healthy             deployment.apps/scheduling-api successfully rolled out

Name:               scheduling-prod
Project:            clinical-apps
Server:             ⟬url#1⟭
Namespace:          scheduling
Sync Status:        Synced to ⟬git_sha#1⟭
Health Status:      Healthy
⟬trap:indicator_non_pii|Owner:              platform-clinical⟭
⟬trap:indicator_non_pii|Patient data:       none in manifests⟭
Database password:  ⟬trap:placeholder|<sealed>⟭
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: en
fill_locale: en_US
domain: retail
appearance: audit trail, key=value, shelf label system
scenario: audit lines of a retailer's electronic shelf labels, pushed and acknowledged by gateways only
⟬text⟭
⟬date#1⟭ 04:00:02 esl-audit store=118 action=PUSH labels=2041 ⟬trap:indicator_non_pii|operator=esl-gateway-1⟭
⟬date#1⟭ 04:01:12 esl-audit store=118 action=ACK labels=2038 failed=3
⟬date#1⟭ 04:01:14 esl-audit store=118 action=REPLACE labels=3 ⟬trap:indicator_non_pii|assignee=night-crew⟭ ticket=⟬ticket_id#1⟭
⟬end⟭

⟬template⟭
family: logs
format: application log
language: en
fill_locale: en_US
domain: SaaS
appearance: Python logging line, webhook JSON body, customer field on both sides, card without a key, tax identifier
scenario: billing service of a project tool processing a day of webhooks and support actions, where raw JSON bodies carry billing addresses, a sole trader's SSN and a card replaced by phone
⟬text⟭
⟬date#1⟭ 10:02:14,118 [INFO] billing.webhooks evt=⟬uuid#1⟭ type=invoice.created customer=⟬customer_id#1⟭
⟬date#1⟭ 10:02:14,121 [DEBUG] billing.webhooks raw={"customer":{"name":"⟬company#1⟭","address":"⟬postal_address#1⟭"},"invoice":"⟬invoice_number#1⟭","amount":1188.00}
⟬date#1⟭ 10:02:14,404 [INFO] billing.invoices invoice ⟬invoice_number#1⟭ rendered to ⟬file_path#1⟭
⟬date#1⟭ 10:02:14,690 [INFO] billing.mail invoice ⟬invoice_number#1⟭ sent to ⟬email:generic#1⟭
⟬date#1⟭ 10:05:02,204 [INFO] billing.webhooks evt=⟬uuid#2⟭ type=customer.updated customer=⟬customer_id#2⟭
⟬date#1⟭ 10:05:02,207 [DEBUG] billing.webhooks raw={"customer":{"name":"⟬person_name#2⟭","tax_id":"⟬us_ssn#2⟭","address":"⟬postal_address#2⟭"},"note":"sole proprietor"}
⟬date#1⟭ 10:05:02,330 [INFO] billing.tax recalculated rate for ⟬city#2⟭ ⟬postcode#2⟭
⟬date#1⟭ 10:11:40,118 [INFO] billing.webhooks evt=⟬uuid#3⟭ type=payment.failed customer=⟬customer_id#3⟭ code=expired_card
⟬date#1⟭ 10:11:40,402 [INFO] billing.dunning reminder 1 of 3 scheduled for ⟬customer_id#3⟭
⟬date#1⟭ 10:12:00,002 [INFO] billing.metrics mrr=412088.00 churned=2 version=⟬version#1⟭
⟬date#1⟭ 10:20:31,118 [INFO] billing.support agent="⟬person_name#4⟭" updating card by phone for ⟬customer_id#3⟭
⟬date#1⟭ 10:20:31,120 [DEBUG] billing.support payload ⟬payment_card#3⟭ ⟬card_security_code#3⟭ "⟬person_name#3⟭"
⟬date#1⟭ 10:20:32,204 [INFO] billing.gateway POST /v1/payment_methods status=200 ref=⟬opaque_token#1⟭
⟬date#1⟭ 10:20:32,406 [INFO] billing.gateway POST /v1/invoices/retry status=200 ref=⟬order_number#1⟭
⟬date#1⟭ 10:20:32,410 [INFO] billing.dunning cancelled for ⟬customer_id#3⟭, operator=⟬trap:indicator_non_pii|billing-robot⟭
⟬date#1⟭ 10:31:15,118 [INFO] billing.webhooks evt=⟬uuid#4⟭ type=subscription.updated customer=⟬trap:indicator_non_pii|internal-demo⟭ seats=25
⟬date#1⟭ 10:31:15,120 [DEBUG] billing.webhooks skipping internal tenant, ⟬trap:indicator_non_pii|customer=internal-demo⟭
⟬date#1⟭ 10:44:02,118 [INFO] billing.webhooks evt=⟬uuid#5⟭ type=refund.created customer=⟬customer_id#5⟭ amount=99.00
⟬date#1⟭ 10:44:02,120 [DEBUG] billing.webhooks raw={"refund":{"reason":"duplicate","requested_by":"⟬person_name#5⟭","card":"⟬payment_card#5⟭"}}
⟬date#1⟭ 10:44:02,400 [INFO] billing.ledger reversal written, ref=⟬uuid#6⟭
⟬date#1⟭ 11:00:00,002 [INFO] billing.metrics mrr=412088.00 churned=2 version=⟬version#1⟭
⟬date#1⟭ 11:03:41,118 [WARN] billing.webhooks signature mismatch from ⟬ip_address#1⟭, secret tried value=⟬opaque_token#2⟭
⟬date#1⟭ 11:03:41,120 [WARN] billing.webhooks evt=⟬uuid#7⟭ rejected
⟬date#1⟭ 11:15:22,204 [INFO] billing.export ledger export started, ⟬trap:indicator_non_pii|owner=finance-ops⟭
⟬date#1⟭ 11:15:30,118 [INFO] billing.export wrote ⟬file_path#2⟭ rows=41204 sha=⟬hash#1⟭
⟬date#1⟭ 11:15:30,402 [INFO] billing.export uploaded to ⟬url#1⟭
⟬date#1⟭ 11:27:09,118 [INFO] billing.webhooks evt=⟬uuid#8⟭ type=customer.created customer=⟬customer_id#6⟭
⟬date#1⟭ 11:27:09,120 [DEBUG] billing.webhooks raw={"customer":{"name":"⟬person_name#6⟭","company":"⟬company#6⟭","address":"⟬postal_address#6⟭","phone":"⟬phone#6⟭"}}
⟬date#1⟭ 11:27:09,402 [INFO] billing.crm contact synced, owner="⟬person_name#7⟭"
⟬date#1⟭ 11:27:10,118 [INFO] billing.crm lead score 82, owner=⟬trap:indicator_non_pii|sales-pool⟭
⟬date#1⟭ 11:40:44,118 [INFO] billing.webhooks evt=⟬uuid#9⟭ type=invoice.paid customer=⟬customer_id#1⟭
⟬date#1⟭ 11:40:44,404 [INFO] billing.ledger invoice ⟬invoice_number#1⟭ settled
⟬date#1⟭ 12:00:00,002 [INFO] billing.metrics mrr=413276.00 churned=2 version=⟬version#1⟭
⟬date#1⟭ 12:05:18,118 [INFO] billing.tax nexus report for ⟬trap:word_name|Georgia⟭ regenerated
⟬date#1⟭ 12:05:18,402 [INFO] billing.tax nexus report for ⟬trap:word_name|Virginia⟭ regenerated
⟬date#1⟭ 12:18:03,118 [ERROR] billing.gateway POST /v1/charges status=502 attempt=1
⟬date#1⟭ 12:18:05,120 [ERROR] billing.gateway POST /v1/charges status=502 attempt=2
⟬date#1⟭ 12:18:09,122 [INFO] billing.gateway POST /v1/charges status=200 attempt=3 ref=⟬uuid#10⟭
⟬date#1⟭ 12:30:44,118 [INFO] billing.support agent="⟬person_name#4⟭" extended trial for ⟬customer_id#7⟭ by 14 days
⟬date#1⟭ 12:30:44,120 [INFO] billing.support note="⟬person_name#8⟭ asked for one more seat, will call back"
⟬date#1⟭ 12:42:50,118 [INFO] billing.webhooks evt=⟬uuid#11⟭ type=customer.deleted customer=⟬customer_id#8⟭
⟬date#1⟭ 12:42:50,120 [INFO] billing.gdpr scrub queued ⟬ticket_id#1⟭
⟬date#1⟭ 13:00:00,002 [INFO] billing.metrics mrr=413276.00 churned=3 version=⟬version#1⟭
⟬date#1⟭ 13:12:30,118 [INFO] billing.webhooks evt=⟬uuid#12⟭ type=payment_method.attached customer=⟬customer_id#9⟭
⟬date#1⟭ 13:12:30,120 [DEBUG] billing.webhooks raw={"method":{"holder":"⟬person_name#9⟭","card":"⟬payment_card#9⟭","cvc_check":"pass"}}
⟬date#1⟭ 13:30:02,118 [INFO] billing.api GET /v1/plans 200 4ms
⟬date#1⟭ 13:30:02,204 [INFO] billing.api GET /v1/plans/team 200 3ms
⟬date#1⟭ 13:44:12,118 [INFO] billing.reseller partner ⟬company#10⟭ commission computed
⟬date#1⟭ 13:44:12,120 [DEBUG] billing.reseller wire to "⟬postal_address#10⟭" via ⟬bic#10⟭
⟬date#1⟭ 14:00:00,002 [INFO] billing.metrics mrr=413276.00 churned=3 version=⟬version#1⟭
⟬date#1⟭ 14:05:44,118 [INFO] billing.webhooks evt=⟬uuid#13⟭ type=credit.applied customer=⟬customer_id#2⟭ amount=25.00
⟬date#1⟭ 14:05:44,404 [INFO] billing.mail notice sent to ⟬email#2⟭
⟬date#1⟭ 14:21:10,118 [INFO] billing.scheduler dunning sweep found 4 accounts
⟬date#1⟭ 14:21:10,402 [INFO] billing.scheduler dunning sweep done, reminders=4
⟬date#1⟭ 14:30:00,002 [INFO] billing.cache plans cache refreshed
⟬date#1⟭ 14:45:17,118 [WARN] billing.webhooks evt=⟬uuid#14⟭ replayed, ignoring
⟬date#1⟭ 15:00:00,002 [INFO] billing.metrics mrr=413276.00 churned=3 version=⟬version#1⟭
⟬date#1⟭ 15:02:30,118 [INFO] billing.audit daily seal root=⟬hash#2⟭
⟬date#1⟭ 15:02:30,402 [INFO] billing.audit forwarded to ⟬hostname#1⟭
⟬date#1⟭ 15:20:40,118 [INFO] billing.support agent=⟬trap:indicator_non_pii|chatbot-tier0⟭ closed ticket ⟬ticket_id#2⟭
⟬date#1⟭ 15:40:02,118 [INFO] billing.api GET /v1/health 200 1ms
⟬date#1⟭ 16:00:00,002 [INFO] billing.metrics mrr=413276.00 churned=3 version=⟬version#1⟭
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: en
fill_locale: en_US
domain: healthcare
appearance: Android crash, Kotlin data class toString, logcat line, JWT in an exception
scenario: logcat crash of a patient mobile app, whose exception prints the profile data class with SSN, address, phone and the session JWT
⟬text⟭
⟬date#1⟭ 18:02:44.118 14120 14120 E AndroidRuntime: FATAL EXCEPTION: main
⟬date#1⟭ 18:02:44.118 14120 14120 E AndroidRuntime: Process: com.carepath.patient, PID: 14120
⟬date#1⟭ 18:02:44.118 14120 14120 E AndroidRuntime: java.lang.IllegalStateException: profile sync failed for Patient(name="⟬person_name#1⟭", ssn=⟬us_ssn#1⟭, dob=⟬birth_date#1⟭, address="⟬postal_address#1⟭", phone="⟬phone#1⟭")
⟬date#1⟭ 18:02:44.118 14120 14120 E AndroidRuntime: 	at com.carepath.patient.sync.ProfileSync.apply(ProfileSync.kt:88)
⟬date#1⟭ 18:02:44.118 14120 14120 E AndroidRuntime: 	at com.carepath.patient.sync.ProfileSync$run$1.invokeSuspend(ProfileSync.kt:41)
⟬date#1⟭ 18:02:44.118 14120 14120 E AndroidRuntime: 	at kotlin.coroutines.jvm.internal.BaseContinuationImpl.resumeWith(ContinuationImpl.kt:33)
⟬date#1⟭ 18:02:44.118 14120 14120 E AndroidRuntime: 	at kotlinx.coroutines.DispatchedTask.run(DispatchedTask.kt:108)
⟬date#1⟭ 18:02:44.118 14120 14120 E AndroidRuntime: 	at android.os.Handler.handleCallback(Handler.java:942)
⟬date#1⟭ 18:02:44.118 14120 14120 E AndroidRuntime: 	at android.os.Handler.dispatchMessage(Handler.java:99)
⟬date#1⟭ 18:02:44.118 14120 14120 E AndroidRuntime: 	at android.os.Looper.loopOnce(Looper.java:201)
⟬date#1⟭ 18:02:44.118 14120 14120 E AndroidRuntime: 	at android.app.ActivityThread.main(ActivityThread.java:7918)
⟬date#1⟭ 18:02:44.118 14120 14120 E AndroidRuntime: Caused by: retrofit2.HttpException: HTTP 401 Unauthorized
⟬date#1⟭ 18:02:44.118 14120 14120 E AndroidRuntime: 	at retrofit2.KotlinExtensions$await$2$2.onResponse(KotlinExtensions.kt:53)
⟬date#1⟭ 18:02:44.118 14120 14120 E AndroidRuntime: 	... 12 more
⟬date#1⟭ 18:02:44.121 14120 14120 D OkHttp  : --> GET ⟬url#1⟭
⟬date#1⟭ 18:02:44.121 14120 14120 D OkHttp  : Authorization: Bearer ⟬jwt#1⟭
⟬date#1⟭ 18:02:44.122 14120 14120 D OkHttp  : <-- 401 ⟬url#1⟭ (212ms)
⟬end⟭

⟬template⟭
family: logs
format: test output
language: en
fill_locale: en_US
domain: retail
appearance: Cypress run output, cy.task log, test fixture, password in a fixture
scenario: Cypress run of a marketplace checkout, whose task log prints the seller login and the buyer's address and card
⟬text⟭
  Running:  checkout.cy.ts                                                  (3 of 8)

[cy.task] seed {"user":"⟬email#1⟭","password":"⟬password#1⟭"}
[cy.task] buyer {"name":"⟬person_name#2⟭","ship":"⟬postal_address#2⟭"}
[cy.task] tender {"pan":"⟬payment_card#2⟭","cvc":"⟬card_security_code#2⟭"}

  Checkout
    ✓ adds an item to the cart (812ms)
    ✓ applies shipping for ⟬trap:word_name|Georgia⟭ (304ms)
    1) pays with the saved card

  2 passing (4s)
  1 failing

  1) Checkout
       pays with the saved card:
     AssertionError: Timed out retrying after 4000ms: Expected to find content: 'Order placed' but never did.
      at Context.eval (webpack://storefront/./cypress/e2e/checkout.cy.ts:41:8)

  (Results)
  │ Tests:        3
  │ Passing:      2
  │ Failing:      1
  │ Screenshots:  1
  │ Spec Ran:     checkout.cy.ts
⟬end⟭

⟬template⟭
family: logs
format: access log
language: en
fill_locale: en_US
domain: government
appearance: combined log format, custom context field, SSN in a context field, plate in a context field, token in a query string
scenario: nginx access of a state revenue department's portal during filing season, with a context field copying SSNs and plates and session tokens left in query strings
⟬text⟭
⟬ip_address#1⟭ - - [⟬date#1⟭ 21:02:11 -0500] "GET /file/start HTTP/1.1" 200 8120 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/121.0" ctx="-"
⟬ip_address#1⟭ - - [⟬date#1⟭ 21:02:40 -0500] "POST /file/identify HTTP/1.1" 200 412 "⟬url#1⟭" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/121.0" ctx="ssn=⟬us_ssn#2⟭ dob=⟬birth_date#2⟭ last=⟬person_name:family#2⟭"
⟬ip_address#1⟭ - - [⟬date#1⟭ 21:02:41 -0500] "GET /file/refund-status?session=⟬opaque_token#1⟭ HTTP/1.1" 200 2204 "⟬url#1⟭" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/121.0" ctx="-"
⟬ip_address#2⟭ - - [⟬date#1⟭ 21:03:05 -0500] "GET /healthz HTTP/1.1" 200 2 "-" "kube-probe/1.29" ctx="-"
⟬ip_address#3⟭ - - [⟬date#1⟭ 21:03:12 -0500] "GET /forms/st-140.pdf HTTP/1.1" 200 188204 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 14_2) Safari/605.1.15" ctx="-"
⟬ip_address#4⟭ - - [⟬date#1⟭ 21:03:30 -0500] "POST /excise/vehicle/lookup HTTP/1.1" 200 610 "-" "Mozilla/5.0 (iPhone; CPU iPhone OS 17_3 like Mac OS X)" ctx="plate=⟬us_license_plate#4⟭ county=⟬trap:word_name|Madison⟭"
⟬ip_address#4⟭ - - [⟬date#1⟭ 21:03:58 -0500] "POST /excise/vehicle/pay HTTP/1.1" 200 288 "⟬url#2⟭" "Mozilla/5.0 (iPhone; CPU iPhone OS 17_3 like Mac OS X)" ctx="dl=⟬us_driver_license#4⟭ amt=212.40"
⟬ip_address#5⟭ - ⟬person_name:handle#5⟭ [⟬date#1⟭ 21:04:20 -0500] "GET /agent/returns?status=flagged HTTP/1.1" 200 8120 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Edge/121.0" ctx="-"
⟬ip_address#5⟭ - ⟬person_name:handle#5⟭ [⟬date#1⟭ 21:04:51 -0500] "GET /agent/returns/⟬uuid#1⟭ HTTP/1.1" 200 22040 "⟬url#3⟭" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Edge/121.0" ctx="taxpayer=⟬person_name#6⟭ ssn=⟬us_ssn#6⟭"
⟬ip_address#5⟭ - ⟬person_name:handle#5⟭ [⟬date#1⟭ 21:05:20 -0500] "POST /agent/returns/⟬uuid#1⟭/hold HTTP/1.1" 200 96 "⟬url#3⟭" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Edge/121.0" ctx="reason=⟬ticket_id#1⟭"
⟬ip_address#6⟭ - - [⟬date#1⟭ 21:05:44 -0500] "POST /file/dependents HTTP/1.1" 200 188 "⟬url#4⟭" "Mozilla/5.0 (Linux; Android 14) Chrome/120.0" ctx="spouse=⟬person_name#7⟭ spouse_ssn=⟬us_ssn#7⟭"
⟬ip_address#6⟭ - - [⟬date#1⟭ 21:06:02 -0500] "POST /file/address HTTP/1.1" 200 140 "⟬url#4⟭" "Mozilla/5.0 (Linux; Android 14) Chrome/120.0" ctx="addr=⟬postal_address#7⟭"
⟬ip_address#6⟭ - - [⟬date#1⟭ 21:06:30 -0500] "POST /file/direct-deposit HTTP/1.1" 200 112 "⟬url#4⟭" "Mozilla/5.0 (Linux; Android 14) Chrome/120.0" ctx="acct=⟬bank_account_number#7⟭ routing=⟬bic#7⟭"
⟬ip_address#6⟭ - - [⟬date#1⟭ 21:06:58 -0500] "POST /file/sign HTTP/1.1" 200 96 "⟬url#4⟭" "Mozilla/5.0 (Linux; Android 14) Chrome/120.0" ctx="pin_ref=⟬uuid#2⟭"
⟬ip_address#6⟭ - - [⟬date#1⟭ 21:06:59 -0500] "GET /file/confirmation?token=⟬jwt#1⟭ HTTP/1.1" 200 3120 "⟬url#4⟭" "Mozilla/5.0 (Linux; Android 14) Chrome/120.0" ctx="-"
⟬ip_address#2⟭ - - [⟬date#1⟭ 21:07:05 -0500] "GET /healthz HTTP/1.1" 200 2 "-" "kube-probe/1.29" ctx="-"
⟬ip_address#7⟭ - - [⟬date#1⟭ 21:07:30 -0500] "POST /api/mef/submit HTTP/1.1" 202 88 "-" "TaxPrep/⟬version#1⟭" ctx="ero=⟬company#8⟭ preparer=⟬person_name#8⟭"
⟬ip_address#7⟭ - - [⟬date#1⟭ 21:07:31 -0500] "POST /api/mef/submit HTTP/1.1" 202 88 "-" "TaxPrep/⟬version#1⟭" ctx="ero=⟬company#8⟭ preparer=⟬trap:indicator_non_pii|self-prepared⟭"
⟬ip_address#7⟭ - - [⟬date#1⟭ 21:07:44 -0500] "GET /api/mef/acks?since=⟬uuid#3⟭ HTTP/1.1" 200 4410 "-" "TaxPrep/⟬version#1⟭" ctx="-"
⟬ip_address#8⟭ - - [⟬date#1⟭ 21:08:02 -0500] "GET /refund/where-is-my-refund HTTP/1.1" 200 4120 "-" "Mozilla/5.0 (iPad; CPU OS 17_2 like Mac OS X) Safari/604.1" ctx="-"
⟬ip_address#8⟭ - - [⟬date#1⟭ 21:08:31 -0500] "POST /refund/where-is-my-refund HTTP/1.1" 200 612 "⟬url#5⟭" "Mozilla/5.0 (iPad; CPU OS 17_2 like Mac OS X) Safari/604.1" ctx="ssn=⟬us_ssn#9⟭ amount=1204"
⟬ip_address#9⟭ - - [⟬date#1⟭ 21:09:02 -0500] "GET /robots.txt HTTP/1.1" 200 88 "-" "Mozilla/5.0 (compatible; bingbot/2.0)" ctx="-"
⟬ip_address#9⟭ - - [⟬date#1⟭ 21:09:11 -0500] "GET /sitemap.xml HTTP/1.1" 200 4120 "-" "Mozilla/5.0 (compatible; bingbot/2.0)" ctx="-"
⟬ip_address#10⟭ - - [⟬date#1⟭ 21:09:40 -0500] "GET /wp-login.php HTTP/1.1" 404 162 "-" "python-requests/2.28.1" ctx="-"
⟬ip_address#10⟭ - - [⟬date#1⟭ 21:09:41 -0500] "GET /.git/HEAD HTTP/1.1" 404 162 "-" "python-requests/2.28.1" ctx="-"
⟬ip_address#11⟭ - - [⟬date#1⟭ 21:10:05 -0500] "POST /account/login HTTP/1.1" 200 412 "-" "Mozilla/5.0 (X11; Linux x86_64) Firefox/122.0" ctx="email=⟬email#11⟭ pwd=⟬password#1⟭"
⟬ip_address#11⟭ - - [⟬date#1⟭ 21:10:06 -0500] "GET /account/home?session=⟬opaque_token#2⟭ HTTP/1.1" 200 6120 "⟬url#6⟭" "Mozilla/5.0 (X11; Linux x86_64) Firefox/122.0" ctx="-"
⟬ip_address#11⟭ - - [⟬date#1⟭ 21:10:40 -0500] "POST /account/payment-plan HTTP/1.1" 201 188 "⟬url#6⟭" "Mozilla/5.0 (X11; Linux x86_64) Firefox/122.0" ctx="monthly=120.00 card=⟬payment_card#11⟭"
⟬ip_address#2⟭ - - [⟬date#1⟭ 21:11:05 -0500] "GET /healthz HTTP/1.1" 200 2 "-" "kube-probe/1.29" ctx="-"
⟬ip_address#12⟭ - ⟬username#1⟭ [⟬date#1⟭ 21:11:30 -0500] "POST /batch/import-w2 HTTP/1.1" 202 44 "-" "Employer-Bridge/⟬version#2⟭" ctx="file=⟬file_path#1⟭"
⟬ip_address#12⟭ - ⟬username#1⟭ [⟬date#1⟭ 21:11:58 -0500] "GET /batch/status?id=⟬uuid#4⟭ HTTP/1.1" 200 96 "-" "Employer-Bridge/⟬version#2⟭" ctx="-"
⟬ip_address#13⟭ - - [⟬date#1⟭ 21:12:14 -0500] "POST /excise/vehicle/lookup HTTP/1.1" 404 96 "-" "Mozilla/5.0 (Linux; Android 13) Chrome/119.0" ctx="plate=⟬us_license_plate#13⟭ county=⟬trap:word_name|Charlotte⟭"
⟬ip_address#13⟭ - - [⟬date#1⟭ 21:12:29 -0500] "POST /excise/vehicle/lookup HTTP/1.1" 200 604 "-" "Mozilla/5.0 (Linux; Android 13) Chrome/119.0" ctx="plate=⟬us_license_plate#14⟭ county=⟬trap:word_name|Charlotte⟭"
⟬ip_address#14⟭ - - [⟬date#1⟭ 21:12:50 -0500] "POST /help/chat HTTP/1.1" 201 72 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/120.0" ctx="msg=my name is ⟬person_name#15⟭ and my refund went to my ex wife ⟬person_name#16f⟭"
⟬ip_address#15⟭ - - [⟬date#1⟭ 21:13:11 -0500] "GET /file/prior-year?year=last&session=⟬jwt#2⟭ HTTP/1.1" 200 8120 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 14_1) Safari/605.1.15" ctx="-"
⟬ip_address#15⟭ - - [⟬date#1⟭ 21:13:40 -0500] "GET /file/prior-year/pdf?session=⟬jwt#2⟭ HTTP/1.1" 200 188204 "⟬url#7⟭" "Mozilla/5.0 (Macintosh; Intel Mac OS X 14_1) Safari/605.1.15" ctx="-"
⟬ip_address#16⟭ - - [⟬date#1⟭ 21:14:02 -0500] "POST /notices/respond HTTP/1.1" 201 96 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/121.0" ctx="notice=⟬ticket_id#2⟭ taxpayer=⟬person_name#17⟭ addr=⟬postal_address#17⟭"
⟬ip_address#2⟭ - - [⟬date#1⟭ 21:14:05 -0500] "GET /healthz HTTP/1.1" 200 2 "-" "kube-probe/1.29" ctx="-"
⟬ip_address#17⟭ - ⟬person_name:handle#18⟭ [⟬date#1⟭ 21:14:30 -0500] "GET /agent/notices/⟬uuid#6⟭ HTTP/1.1" 200 4410 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Edge/121.0" ctx="-"
⟬ip_address#17⟭ - ⟬person_name:handle#18⟭ [⟬date#1⟭ 21:14:58 -0500] "POST /agent/notices/⟬uuid#6⟭/close HTTP/1.1" 200 88 "⟬url#8⟭" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Edge/121.0" ctx="-"
⟬ip_address#18⟭ - - [⟬date#1⟭ 21:15:12 -0500] "GET /stats/filing-season HTTP/1.1" 200 3120 "-" "curl/8.4.0" ctx="-"
⟬ip_address#19⟭ - - [⟬date#1⟭ 21:15:40 -0500] "GET /file/start HTTP/1.1" 200 8120 "-" "Mozilla/5.0 (iPhone; CPU iPhone OS 16_7 like Mac OS X)" ctx="-"
⟬ip_address#19⟭ - - [⟬date#1⟭ 21:16:02 -0500] "POST /file/identify HTTP/1.1" 403 96 "⟬url#9⟭" "Mozilla/5.0 (iPhone; CPU iPhone OS 16_7 like Mac OS X)" ctx="ssn=⟬us_ssn#20⟭ dob=⟬birth_date#20⟭ last=⟬person_name:family#20⟭"
⟬ip_address#19⟭ - - [⟬date#1⟭ 21:16:30 -0500] "POST /file/identify HTTP/1.1" 200 412 "⟬url#9⟭" "Mozilla/5.0 (iPhone; CPU iPhone OS 16_7 like Mac OS X)" ctx="ssn=⟬us_ssn#21⟭ dob=⟬birth_date#21⟭ last=⟬person_name:family#21⟭"
⟬ip_address#20⟭ - - [⟬date#1⟭ 21:17:02 -0500] "GET /about/contact HTTP/1.1" 200 2204 "-" "Mozilla/5.0 (Linux; Android 14) Chrome/121.0" ctx="-"
⟬ip_address#2⟭ - - [⟬date#1⟭ 21:17:05 -0500] "GET /healthz HTTP/1.1" 200 2 "-" "kube-probe/1.29" ctx="-"
⟬ip_address#21⟭ - - [⟬date#1⟭ 21:17:41 -0500] "POST /account/forgot HTTP/1.1" 202 74 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Firefox/121.0" ctx="email=⟬email#22⟭"
⟬ip_address#21⟭ - - [⟬date#1⟭ 21:18:12 -0500] "GET /account/reset?code=⟬opaque_token#3⟭ HTTP/1.1" 200 2040 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Firefox/121.0" ctx="-"
⟬ip_address#21⟭ - - [⟬date#1⟭ 21:18:44 -0500] "POST /account/reset HTTP/1.1" 302 0 "⟬url#10⟭" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Firefox/121.0" ctx="pwd=⟬password#2⟭"
⟬ip_address#22⟭ - - [⟬date#1⟭ 21:19:03 -0500] "POST /excise/vehicle/lookup HTTP/1.1" 200 610 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 13_6) Chrome/120.0" ctx="plate=⟬us_license_plate#23⟭ county=⟬trap:word_name|Austin⟭"
⟬ip_address#22⟭ - - [⟬date#1⟭ 21:19:30 -0500] "POST /excise/vehicle/pay HTTP/1.1" 402 112 "⟬url#11⟭" "Mozilla/5.0 (Macintosh; Intel Mac OS X 13_6) Chrome/120.0" ctx="dl=⟬us_driver_license#23⟭ amt=88.20"
⟬ip_address#23⟭ - - [⟬date#1⟭ 21:20:02 -0500] "GET /news/deadline-extension HTTP/1.1" 200 6120 "-" "Mozilla/5.0 (compatible; Googlebot/2.1)" ctx="-"
⟬ip_address#24⟭ - - [⟬date#1⟭ 21:20:18 -0500] "GET /file/start HTTP/1.1" 200 8120 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/121.0" ctx="-"
⟬ip_address#2⟭ - - [⟬date#1⟭ 21:20:35 -0500] "GET /healthz HTTP/1.1" 200 2 "-" "kube-probe/1.29" ctx="-"
⟬ip_address#25⟭ - ⟬username#2⟭ [⟬date#1⟭ 21:21:02 -0500] "POST /batch/export-ledger HTTP/1.1" 202 44 "-" "python-requests/2.31.0" ctx="ref=⟬uuid#5⟭"
⟬ip_address#25⟭ - ⟬username#2⟭ [⟬date#1⟭ 21:21:30 -0500] "POST /batch/export-ledger HTTP/1.1" 202 44 "-" "python-requests/2.31.0" ctx="ref=⟬opaque_token#4⟭"
⟬ip_address#26⟭ - - [⟬date#1⟭ 21:22:04 -0500] "GET /forms/st-140-instructions.pdf HTTP/1.1" 200 204118 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/121.0" ctx="-"
⟬ip_address#27⟭ - - [⟬date#1⟭ 21:22:30 -0500] "POST /help/callback HTTP/1.1" 201 66 "-" "Mozilla/5.0 (iPhone; CPU iPhone OS 17_2 like Mac OS X)" ctx="name=⟬person_name#28⟭ phone=⟬phone#28⟭"
⟬ip_address#2⟭ - - [⟬date#1⟭ 21:23:05 -0500] "GET /healthz HTTP/1.1" 200 2 "-" "kube-probe/1.29" ctx="-"
⟬ip_address#28⟭ - - [⟬date#1⟭ 21:23:40 -0500] "GET /file/status HTTP/1.1" 200 2040 "-" "Mozilla/5.0 (Linux; Android 13) Chrome/120.0" ctx="-"
⟬ip_address#29⟭ - - [⟬date#1⟭ 21:24:02 -0500] "POST /file/identify HTTP/1.1" 200 412 "⟬url#12⟭" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/120.0" ctx="ssn=⟬us_ssn#29⟭ dob=⟬birth_date#29⟭ last=⟬person_name:family#29⟭"
⟬ip_address#29⟭ - - [⟬date#1⟭ 21:24:31 -0500] "POST /file/address HTTP/1.1" 200 140 "⟬url#12⟭" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/120.0" ctx="addr=⟬postal_address#29⟭"
⟬ip_address#30⟭ - - [⟬date#1⟭ 21:25:02 -0500] "GET /about/offices?city=⟬trap:word_name|Savannah⟭ HTTP/1.1" 200 2120 "-" "Mozilla/5.0 (compatible; Googlebot/2.1)" ctx="-"
⟬ip_address#2⟭ - - [⟬date#1⟭ 21:25:05 -0500] "GET /healthz HTTP/1.1" 200 2 "-" "kube-probe/1.29" ctx="-"
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: en
fill_locale: en_US
domain: travel
appearance: fastlane output, Gradle signing arguments, step table, test user, JWT in a job log, password in a command
scenario: fastlane release of an airline's mobile app, whose steps print the certificate repository password, the Android keystore password and a passport of the App Store review account
⟬text⟭
[14:02:11]: ------------------------------
[14:02:11]: --- Step: default_platform ---
[14:02:11]: ------------------------------
[14:02:11]: Driving the lane 'ios beta'
[14:02:12]: ------------------
[14:02:12]: --- Step: match ---
[14:02:12]: ------------------
[14:02:12]: Successfully loaded '/Users/runner/work/app/fastlane/Matchfile'
[14:02:12]: Detected Values from './fastlane/Matchfile'
+----------------+--------------------------------------+
|                 Summary for match                     |
+----------------+--------------------------------------+
| type           | appstore                             |
| readonly       | true                                 |
| app_identifier | com.skylane.booking                  |
| git_branch     | main                                 |
| username       | ⟬trap:indicator_non_pii|ci-builder⟭  |
+----------------+--------------------------------------+
[14:02:13]: $ git clone ⟬url#1⟭ /tmp/d20
[14:02:15]: Decrypting with MATCH_PASSWORD=⟬password#1⟭
[14:02:16]: 🔓  Successfully decrypted certificates repo
[14:02:17]: ---------------------
[14:02:17]: --- Step: gym ---
[14:02:17]: ---------------------
[14:02:17]: $ xcodebuild -workspace Skylane.xcworkspace -scheme Booking -configuration Release clean archive
[14:09:41]: ▸ Compiling BookingViewController.swift
[14:12:02]: ▸ Linking Skylane
[14:13:44]: ▸ Archive Succeeded
[14:13:50]: Successfully exported and signed the ipa file
[14:13:51]: -------------------------
[14:13:51]: --- Step: scan ---
[14:13:51]: -------------------------
[14:14:30]: ▸ Test Suite 'CheckInFlowTests' started
[14:14:41]: ▸ ✓ testBoardingPassRenders (1.204 seconds)
[14:14:52]: ▸ ✗ testPassportScanFillsForm (2.118 seconds)
[14:14:52]: ▸ XCTAssertEqual failed: ("⟬us_passport#2⟭") is not equal to ("⟬us_passport#3⟭")
[14:14:52]: ▸ fixture traveler: "⟬person_name#2⟭" dob ⟬birth_date#2⟭
[14:15:02]: ▸ Executed 41 tests, with 1 failure
[14:15:03]: ------------------------
[14:15:03]: --- Step: pilot ---
[14:15:03]: ------------------------
[14:15:04]: Login to App Store Connect (⟬email:generic#4⟭)
[14:15:05]: Using api key, issuer ⟬uuid#1⟭, key id ⟬hash#1⟭
[14:15:05]: Bearer ⟬jwt#1⟭
[14:15:44]: Uploaded binary, build ⟬version#1⟭
[14:15:45]: Review notes: demo account ⟬email#5⟭ / ⟬password#2⟭, passport ⟬us_passport#5⟭ for the check-in screen
[14:15:46]: Lane finished
[14:15:50]: Driving the lane 'android beta'
[14:15:51]: ---------------------
[14:15:51]: --- Step: gradle ---
[14:15:51]: ---------------------
[14:15:51]: $ ./gradlew bundleRelease -Pandroid.injected.signing.store.file=keystore.jks -Pandroid.injected.signing.store.password=⟬password#3⟭ -Pandroid.injected.signing.key.alias=upload -Pandroid.injected.signing.key.password=⟬password#4⟭
[14:18:20]: ▸ > Task :app:minifyReleaseWithR8
[14:19:02]: ▸ > Task :app:bundleRelease
[14:19:03]: ▸ BUILD SUCCESSFUL in 3m 11s
[14:19:04]: ---------------------
[14:19:04]: --- Step: supply ---
[14:19:04]: ---------------------
[14:19:05]: Preparing aab at path 'app/build/outputs/bundle/release/app-release.aab'
[14:19:30]: Uploading to internal track
[14:19:31]: Service account ref ⟬opaque_token#1⟭
[14:19:44]: Successfully finished the upload to Google Play
[14:19:45]: ---------------------
[14:19:45]: --- Step: slack ---
[14:19:45]: ---------------------
[14:19:46]: Posted to ⟬url#2⟭
[14:19:46]: fastlane.tools finished successfully 🎉
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: en
fill_locale: en_US
domain: fintech
appearance: JSON lines, KYC review events, withdrawal review, nested JSON
scenario: compliance audit of a crypto exchange, as JSON, with analysts reviewing identity documents and a robot approving withdrawals
⟬text⟭
{"at":"⟬date#1⟭ 08:12:04","by":"⟬email#1⟭","event":"kyc.document.view","subject":"⟬customer_id#2⟭","doc":{"type":"passport","number":"⟬us_passport#2⟭","holder":"⟬person_name#2⟭"}}
{"at":"⟬date#1⟭ 08:12:40","by":"⟬email#1⟭","event":"kyc.document.view","subject":"⟬customer_id#2⟭","doc":{"type":"selfie","number":null,"holder":"⟬person_name#2⟭"}}
{"at":"⟬date#1⟭ 08:13:02","by":"⟬email#1⟭","event":"kyc.ssn.reveal","subject":"⟬customer_id#2⟭","value":"⟬us_ssn#2⟭","reason":"⟬ticket_id#1⟭"}
{"at":"⟬date#1⟭ 08:13:30","by":"⟬email#1⟭","event":"kyc.approve","subject":"⟬customer_id#2⟭","tier":2}
{"at":"⟬date#1⟭ 08:30:00","by":"⟬trap:indicator_non_pii|withdrawal-engine⟭","event":"withdrawal.auto_approve","subject":"⟬customer_id#3⟭","amount_usd":412.00,"dest":"⟬hash#1⟭"}
{"at":"⟬date#1⟭ 08:31:12","by":"⟬trap:indicator_non_pii|withdrawal-engine⟭","event":"withdrawal.hold","subject":"⟬customer_id#4⟭","amount_usd":88120.00,"rule":"velocity"}
{"at":"⟬date#1⟭ 08:45:47","by":"⟬email#5⟭","event":"withdrawal.review","subject":"⟬customer_id#4⟭","note":"called ⟬person_name#4⟭ on ⟬phone#4⟭, confirmed"}
{"at":"⟬date#1⟭ 08:46:02","by":"⟬email#5⟭","event":"withdrawal.release","subject":"⟬customer_id#4⟭"}
{"at":"⟬date#1⟭ 09:02:11","by":"⟬email#1⟭","event":"kyc.document.view","subject":"⟬customer_id#6⟭","doc":{"type":"driver_license","number":"⟬us_driver_license#6⟭","holder":"⟬person_name#6⟭"}}
{"at":"⟬date#1⟭ 09:02:50","by":"⟬email#1⟭","event":"kyc.reject","subject":"⟬customer_id#6⟭","reason":"name mismatch"}
{"at":"⟬date#1⟭ 09:03:00","by":"⟬trap:indicator_non_pii|notification-bot⟭","event":"mail.queued","subject":"⟬customer_id#6⟭","template":"kyc_rejected"}
{"at":"⟬date#1⟭ 09:20:14","by":"⟬email#5⟭","event":"api_key.revoke","subject":"⟬customer_id#7⟭","key_id":"⟬hash#2⟭","reason":"reported leak"}
{"at":"⟬date#1⟭ 09:44:31","by":"⟬trap:indicator_non_pii|travel-rule-bot⟭","event":"travel_rule.send","subject":"⟬customer_id#3⟭","originator":"⟬person_name#3⟭","beneficiary":"⟬person_name#8⟭"}
{"at":"⟬date#1⟭ 10:02:03","by":"⟬email#1⟭","event":"sar.draft","subject":"⟬customer_id#4⟭","file":"⟬uuid#1⟭"}
{"at":"⟬date#1⟭ 10:30:00","by":"⟬trap:indicator_non_pii|reporting-job⟭","event":"report.daily","subject":"compliance","file":"⟬hash#3⟭"}
{"at":"⟬date#1⟭ 10:30:04","by":"⟬trap:indicator_non_pii|reporting-job⟭","event":"report.upload","subject":"compliance","dest":"⟬url#1⟭"}
⟬end⟭

⟬template⟭
family: logs
format: application log
language: en
fill_locale: en_US
domain: retail
appearance: bracketed level, printer status, color names
scenario: price tag printer daemon in a hardware store, reporting ink named like people and queue length
⟬text⟭
[info] ⟬date#1⟭ 06:30:02 tagprint: queue=41 model=⟬version#1⟭
[info] ⟬date#1⟭ 06:30:05 tagprint: template ⟬trap:word_name|Olive-promo⟭ selected
[warn] ⟬date#1⟭ 06:31:12 tagprint: ribbon ⟬trap:word_name|Amber⟭ at 8 percent, ⟬trap:indicator_non_pii|owner=store-ops⟭
[info] ⟬date#1⟭ 06:32:40 tagprint: queue=0
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: en
fill_locale: en_US
domain: government
appearance: NestJS error line, JSON in an exception, TypeScript stack frames
scenario: NestJS validation error of a federal trusted traveler enrollment API, whose message serializes the applicant with passport, license, SSN and birth date
⟬text⟭
[Nest] 412  - ⟬date#1⟭ 09:14:02   ERROR [ExceptionsHandler] Enrollment validation failed for {"fullName":"⟬person_name#1⟭","passportNumber":"⟬us_passport#1⟭","driverLicense":"⟬us_driver_license#1⟭","ssn":"⟬us_ssn#1⟭","dob":"⟬birth_date#1⟭"}
BadRequestException: Enrollment validation failed
    at EnrollmentService.validate (/app/dist/enrollment/enrollment.service.js:88:19)
    at EnrollmentService.create (/app/dist/enrollment/enrollment.service.js:41:14)
    at EnrollmentController.create (/app/dist/enrollment/enrollment.controller.js:27:44)
    at /app/node_modules/@nestjs/core/router/router-execution-context.js:38:29
    at processTicksAndRejections (node:internal/process/task_queues:95:5)
    at async /app/node_modules/@nestjs/core/router/router-execution-context.js:46:28
    at async /app/node_modules/@nestjs/core/router/router-proxy.js:9:17
Caused by: ValidationError: passportNumber must match the document on file
    at validateSync (/app/node_modules/class-validator/cjs/index.js:101:19)
    at EnrollmentService.validate (/app/dist/enrollment/enrollment.service.js:86:21)
[Nest] 412  - ⟬date#1⟭ 09:14:02     LOG [EnrollmentController] request ⟬uuid#1⟭ finished with 400 for ⟬ip_address#1⟭
[Nest] 412  - ⟬date#1⟭ 09:14:02    WARN [AuditInterceptor] ⟬trap:indicator_non_pii|operator=self-service⟭ retry window 15 min
[Nest] 412  - ⟬date#1⟭ 09:14:03     LOG [NotifyService] email to ⟬email#1⟭ queued
[Nest] 412  - ⟬date#1⟭ 09:14:03     LOG [AppointmentService] interview slot held at ⟬trap:word_name|Savannah⟭ center
⟬end⟭

⟬template⟭
family: logs
format: test output
language: en
fill_locale: en_US
domain: travel
appearance: unittest output, assertion diff, value without a key
scenario: Python unittest failure of a ship manifest line, showing the passenger's name and passport with no labels
⟬text⟭
F.....
======================================================================
FAIL: test_manifest_line (tests.test_manifest.ManifestTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "tests/test_manifest.py", line 31, in test_manifest_line
    self.assertEqual(line, expected)
AssertionError: "⟬person_name#1⟭/⟬us_passport#1⟭/1" != "⟬person_name#1⟭/⟬us_passport#1⟭/2"

----------------------------------------------------------------------
Ran 6 tests in 0.012s

FAILED (failures=1)
⟬end⟭

⟬template⟭
family: logs
format: access log
language: en
fill_locale: en_US
domain: fintech
appearance: API Gateway JSON access log, Authorization field, token in a query string, value under a neutral key
scenario: API Gateway JSON access of a neobank's mobile backend, with an authorizer field that keeps the raw bearer and a link token in the query string
⟬text⟭
{"requestId":"⟬uuid#1⟭","ip":"⟬ip_address#1⟭","requestTime":"⟬date#1⟭ 14:02:11","method":"GET","path":"/v1/accounts","status":200,"length":412,"authorization":"Bearer ⟬jwt#1⟭"}
{"requestId":"⟬uuid#2⟭","ip":"⟬ip_address#1⟭","requestTime":"⟬date#1⟭ 14:02:12","method":"GET","path":"/v1/accounts/⟬customer_id#2⟭/cards","status":200,"length":1204,"authorization":"Bearer ⟬jwt#1⟭"}
{"requestId":"⟬uuid#3⟭","ip":"⟬ip_address#2⟭","requestTime":"⟬date#1⟭ 14:02:15","method":"POST","path":"/v1/link/exchange?public_token=⟬opaque_token#1⟭","status":200,"length":188,"authorization":"-"}
{"requestId":"⟬uuid#4⟭","ip":"⟬ip_address#3⟭","requestTime":"⟬date#1⟭ 14:02:20","method":"POST","path":"/v1/payees","status":201,"length":96,"authorization":"Bearer ⟬jwt#2⟭"}
{"requestId":"⟬uuid#5⟭","ip":"⟬ip_address#4⟭","requestTime":"⟬date#1⟭ 14:02:31","method":"GET","path":"/healthz","status":200,"length":2,"authorization":"-"}
{"requestId":"⟬uuid#6⟭","ip":"⟬ip_address#5⟭","requestTime":"⟬date#1⟭ 14:02:44","method":"POST","path":"/v1/auth/refresh","status":200,"length":640,"authorization":"-","x_refresh":"⟬opaque_token#2⟭"}
{"requestId":"⟬uuid#7⟭","ip":"⟬ip_address#5⟭","requestTime":"⟬date#1⟭ 14:02:45","method":"POST","path":"/v1/auth/refresh","status":401,"length":74,"authorization":"-","x_refresh":"⟬opaque_token#4⟭"}
{"requestId":"⟬uuid#9⟭","ip":"⟬ip_address#6⟭","requestTime":"⟬date#1⟭ 14:03:02","method":"GET","path":"/v1/statements/⟬uuid#10⟭/pdf?sig=⟬opaque_token#3⟭","status":200,"length":188204,"authorization":"-"}
{"requestId":"⟬uuid#11⟭","ip":"⟬ip_address#7⟭","requestTime":"⟬date#1⟭ 14:03:18","method":"PUT","path":"/v1/kyc/passport/⟬us_passport#3⟭","status":202,"length":44,"authorization":"Bearer ⟬jwt#3⟭"}
{"requestId":"⟬uuid#12⟭","ip":"⟬ip_address#8⟭","requestTime":"⟬date#1⟭ 14:03:40","method":"GET","path":"/v1/rates?pair=USD-EUR","status":200,"length":88,"authorization":"-"}
{"requestId":"⟬uuid#13⟭","ip":"⟬ip_address#9⟭","requestTime":"⟬date#1⟭ 14:03:55","method":"POST","path":"/v1/support/ticket","status":201,"length":72,"authorization":"Bearer ⟬jwt#4⟭"}
{"requestId":"⟬uuid#14⟭","ip":"⟬ip_address#10⟭","requestTime":"⟬date#1⟭ 14:04:12","method":"DELETE","path":"/v1/payees/⟬uuid#15⟭","status":204,"length":0,"authorization":"Bearer ⟬jwt#2⟭"}
{"requestId":"⟬uuid#16⟭","ip":"⟬ip_address#11⟭","requestTime":"⟬date#1⟭ 14:04:30","method":"GET","path":"/v1/transfers?ref=⟬order_number#1⟭","status":200,"length":812,"authorization":"Bearer ⟬jwt#1⟭"}
{"requestId":"⟬uuid#17⟭","ip":"⟬ip_address#12⟭","requestTime":"⟬date#1⟭ 14:04:48","method":"POST","path":"/v1/cards/activate","status":200,"length":96,"authorization":"Bearer ⟬jwt#5⟭"}
{"requestId":"⟬uuid#18⟭","ip":"⟬ip_address#4⟭","requestTime":"⟬date#1⟭ 14:05:01","method":"GET","path":"/healthz","status":200,"length":2,"authorization":"-"}
{"requestId":"⟬uuid#19⟭","ip":"⟬ip_address#13⟭","requestTime":"⟬date#1⟭ 14:05:22","method":"GET","path":"/v1/branches?near=⟬postcode#1⟭","status":200,"length":2204,"authorization":"-"}
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: en
fill_locale: en_US
domain: SaaS
appearance: Travis build log, printenv grep, secret under an innocuous key
scenario: Travis debug step of a survey tool, grepping the environment for credentials and printing them
⟬text⟭
$ printenv | grep -i -E "token|pass|ref"
CDN_PURGE_REF=⟬opaque_token#1⟭
SMTP_PASS=⟬password#1⟭
TRAVIS_PULL_REQUEST_SHA=⟬git_sha#1⟭
TRAVIS_SECURE_ENV_VARS=true
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: en
fill_locale: en_US
domain: healthcare
appearance: LEEF event, key=value, address on a claim, SSN in a field, audit trail
scenario: LEEF events of a health insurer's claims system, where adjusters change payee addresses and open member records
⟬text⟭
LEEF:2.0|Harborline Mutual|ClaimsCore|⟬version#1⟭|LOGIN|devTime=⟬date#1⟭ 09:00:12	usrName=⟬person_name:handle#1⟭	src=⟬ip_address#1⟭
LEEF:2.0|Harborline Mutual|ClaimsCore|⟬version#1⟭|VIEW_MEMBER|devTime=⟬date#1⟭ 09:02:31	usrName=⟬person_name:handle#1⟭	member=⟬customer_id#2⟭	name=⟬person_name#2⟭	ssn=⟬us_ssn#2⟭
LEEF:2.0|Harborline Mutual|ClaimsCore|⟬version#1⟭|VIEW_CLAIM|devTime=⟬date#1⟭ 09:03:04	usrName=⟬person_name:handle#1⟭	claim=⟬ticket_id#1⟭	service=⟬date#2⟭
LEEF:2.0|Harborline Mutual|ClaimsCore|⟬version#1⟭|CHANGE_PAYEE|devTime=⟬date#1⟭ 09:05:44	usrName=⟬person_name:handle#1⟭	claim=⟬ticket_id#1⟭	old=⟬postal_address#3⟭	new=⟬postal_address#4⟭
LEEF:2.0|Harborline Mutual|ClaimsCore|⟬version#1⟭|APPROVAL_REQUIRED|devTime=⟬date#1⟭ 09:05:45	usrName=⟬trap:indicator_non_pii|four-eyes-rule⟭	claim=⟬ticket_id#1⟭
LEEF:2.0|Harborline Mutual|ClaimsCore|⟬version#1⟭|APPROVE_PAYEE|devTime=⟬date#1⟭ 09:20:02	usrName=⟬person_name:handle#5⟭	claim=⟬ticket_id#1⟭	comment=provider moved, confirmed with ⟬person_name#6⟭
LEEF:2.0|Harborline Mutual|ClaimsCore|⟬version#1⟭|BATCH_PAY|devTime=⟬date#1⟭ 10:00:00	usrName=⟬trap:indicator_non_pii|payment-batch⟭	claims=412	file=⟬file_path#1⟭
LEEF:2.0|Harborline Mutual|ClaimsCore|⟬version#1⟭|VIEW_MEMBER|devTime=⟬date#1⟭ 10:12:18	usrName=⟬person_name:handle#7⟭	member=⟬customer_id#8⟭	name=⟬person_name#8⟭	ssn=⟬us_ssn#8⟭
LEEF:2.0|Harborline Mutual|ClaimsCore|⟬version#1⟭|PRINT_LETTER|devTime=⟬date#1⟭ 10:13:02	usrName=⟬person_name:handle#7⟭	member=⟬customer_id#8⟭	addr=⟬postal_address#8⟭
LEEF:2.0|Harborline Mutual|ClaimsCore|⟬version#1⟭|EXPORT_DENIED|devTime=⟬date#1⟭ 10:30:41	usrName=⟬person_name:handle#7⟭	rows=4120	reason=role-missing
LEEF:2.0|Harborline Mutual|ClaimsCore|⟬version#1⟭|DLP_ALERT|devTime=⟬date#1⟭ 10:30:42	usrName=⟬trap:indicator_non_pii|dlp-engine⟭	subject=⟬person_name:handle#7⟭	ticket=⟬ticket_id#2⟭
LEEF:2.0|Harborline Mutual|ClaimsCore|⟬version#1⟭|ROLE_CHANGE|devTime=⟬date#1⟭ 11:02:15	usrName=⟬trap:indicator_non_pii|iam-sync⟭	target=⟬person_name:handle#5⟭	role=supervisor
LEEF:2.0|Harborline Mutual|ClaimsCore|⟬version#1⟭|SIU_REFERRAL|devTime=⟬date#1⟭ 11:40:27	usrName=⟬person_name:handle#5⟭	claim=⟬ticket_id#3⟭	provider=⟬company#9⟭	addr=⟬postal_address#9⟭
LEEF:2.0|Harborline Mutual|ClaimsCore|⟬version#1⟭|LOGOUT|devTime=⟬date#1⟭ 12:00:03	usrName=⟬person_name:handle#1⟭	src=⟬ip_address#1⟭
LEEF:2.0|Harborline Mutual|ClaimsCore|⟬version#1⟭|HEARTBEAT|devTime=⟬date#1⟭ 12:30:00	usrName=⟬trap:indicator_non_pii|system⟭	events=14
LEEF:2.0|Harborline Mutual|ClaimsCore|⟬version#1⟭|HEARTBEAT|devTime=⟬date#1⟭ 13:00:00	usrName=⟬trap:indicator_non_pii|system⟭	events=2
⟬end⟭

⟬template⟭
family: logs
format: application log
language: en
fill_locale: en_US
domain: travel
appearance: Go zap console line, key=value, driver onboarding, plate, license, card on file
scenario: ride hailing backend in Go, onboarding a driver with license and plate, then logging a trip with the rider's card and a lost item note
⟬text⟭
⟬date#1⟭ 16:02:11.118	INFO	onboarding/driver.go:88	application received	{"driver": "⟬person_name#1⟭", "license": "⟬us_driver_license#1⟭", "plate": "⟬us_license_plate#1⟭"}
⟬date#1⟭ 16:02:11.402	INFO	onboarding/background.go:41	background check started	{"vendor_ref": "⟬uuid#1⟭"}
⟬date#1⟭ 16:02:12.118	DEBUG	onboarding/background.go:59	vendor payload	{"name": "⟬person_name#1⟭", "ssn": "⟬us_ssn#1⟭", "dob": "⟬birth_date#1⟭"}
⟬date#1⟭ 16:02:44.204	INFO	onboarding/driver.go:141	application approved	{"operator": "⟬trap:indicator_non_pii|auto-screen⟭"}
⟬date#1⟭ 16:10:02.118	INFO	trips/match.go:74	matched	{"trip": "⟬uuid#2⟭", "rider": "⟬customer_id#2⟭", "plate": "⟬us_license_plate#1⟭"}
⟬date#1⟭ 16:10:02.120	DEBUG	payments/hold.go:31	auth hold	{"pan": "⟬payment_card#2⟭", "amount": 24.50}
⟬date#1⟭ 16:34:40.118	INFO	trips/lifecycle.go:118	trip completed	{"trip": "⟬uuid#2⟭", "fare": 22.80, "tip": 3.00}
⟬date#1⟭ 16:34:40.402	INFO	payments/capture.go:52	captured	{"ref": "⟬order_number#1⟭"}
⟬date#1⟭ 16:40:15.118	INFO	support/lost.go:27	lost item	{"note": "rider ⟬person_name#2⟭ left a bag in ⟬person_name:given#1⟭'s car, call ⟬phone#2⟭"}
⟬date#1⟭ 16:41:02.118	INFO	support/lost.go:61	delivery to rider	{"address": "⟬postal_address#2⟭"}
⟬date#1⟭ 16:50:00.002	INFO	surge/zones.go:44	zone update	{"zone": "⟬trap:word_name|Savannah-downtown⟭", "multiplier": 1.4}
⟬date#1⟭ 16:55:00.002	INFO	surge/zones.go:44	zone update	{"zone": "⟬trap:word_name|Charlotte-uptown⟭", "multiplier": 1.2}
⟬date#1⟭ 17:02:44.118	WARN	onboarding/documents.go:71	insurance expiring	{"driver": "⟬person_name#3⟭", "plate": "⟬us_license_plate#3⟭", "expires": "⟬date#1⟭"}
⟬date#1⟭ 17:02:44.402	INFO	onboarding/documents.go:88	reminder sent	{"owner": "⟬trap:indicator_non_pii|driver-success⟭"}
⟬date#1⟭ 17:10:02.118	ERROR	payments/capture.go:77	capture failed	{"pan": "⟬payment_card#4⟭", "code": "51"}
⟬date#1⟭ 17:10:02.402	INFO	payments/capture.go:92	balance due	{"rider": "⟬customer_id#4⟭", "amount": 18.40}
⟬date#1⟭ 17:15:00.002	INFO	metrics/report.go:21	hourly	{"trips": 412, "drivers": 88, "version": "⟬version#1⟭"}
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: en
fill_locale: en_US
domain: fintech
appearance: PHP fatal error, stack frame arguments, card without a key
scenario: PHP fatal error of a payment plugin, whose stack frames print the card and security code as arguments
⟬text⟭
PHP Fatal error:  Uncaught App\Payments\CardException: declined by issuer in /var/www/app/src/Payments/Gateway.php:88
Stack trace:
#0 /var/www/app/src/Payments/Checkout.php(41): App\Payments\Gateway->charge('⟬payment_card#1⟭', '⟬card_security_code#1⟭', 8420)
#1 /var/www/app/public/index.php(22): App\Payments\Checkout->pay()
#2 {main}
  thrown in /var/www/app/src/Payments/Gateway.php on line 88
⟬end⟭
