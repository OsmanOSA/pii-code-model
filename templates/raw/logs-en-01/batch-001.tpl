⟬template⟭
family: logs
format: application log
language: en
fill_locale: en_US
domain: fintech
appearance: Logback line, key=value, quoted value, value without a key, raw vendor JSON
scenario: morning run of a neobank's KYC worker, whose DEBUG lines copy applicants' SSN, passport, license and address, with a vendor session secret sitting under ref
⟬text⟭
⟬date#1⟭ 09:14:02.118 INFO  [main] c.n.kyc.WorkerBootstrap - starting kyc-worker ⟬version#1⟭ on ⟬hostname#1⟭
⟬date#1⟭ 09:14:02.604 INFO  [main] c.n.kyc.WorkerBootstrap - identity vendor gateway: ⟬url#1⟭
⟬date#1⟭ 09:14:02.611 DEBUG [main] c.n.kyc.config.Loader - ⟬trap:indicator_non_pii|ssn_match_threshold=0.92⟭ ⟬trap:indicator_non_pii|passport_ocr_retries=3⟭ vendor_timeout_ms=4000
⟬date#1⟭ 09:14:03.020 INFO  [kyc-worker-1] c.n.kyc.ApplicationConsumer - polling kyc.applications.v2 batch=25
⟬date#1⟭ 09:14:05.331 INFO  [kyc-worker-1] c.n.kyc.ApplicationConsumer - application ⟬uuid#1⟭ received, customer ⟬customer_id#2⟭
⟬date#1⟭ 09:14:05.340 DEBUG [kyc-worker-1] c.n.kyc.IdentityMapper - applicant name="⟬person_name#2⟭" dob=⟬birth_date#2⟭ ssn="⟬us_ssn#2⟭"
⟬date#1⟭ 09:14:05.342 DEBUG [kyc-worker-1] c.n.kyc.IdentityMapper - residence="⟬postal_address#2⟭"
⟬date#1⟭ 09:14:05.871 INFO  [kyc-worker-1] c.n.kyc.vendor.IdvClient - POST /v3/verifications status=202 ref=⟬opaque_token#1⟭
⟬date#1⟭ 09:14:06.905 INFO  [kyc-worker-1] c.n.kyc.vendor.IdvClient - GET /v3/verifications/⟬uuid#2⟭ status=200 result=clear score=0.97
⟬date#1⟭ 09:14:06.910 INFO  [kyc-worker-1] c.n.kyc.decision.RuleEngine - application ⟬uuid#1⟭ approved, operator=⟬trap:indicator_non_pii|auto-review⟭
⟬date#1⟭ 09:14:11.212 INFO  [kyc-worker-2] c.n.kyc.ApplicationConsumer - application ⟬uuid#3⟭ received, customer ⟬customer_id#3⟭
⟬date#1⟭ 09:14:11.219 DEBUG [kyc-worker-2] c.n.kyc.IdentityMapper - applicant name="⟬person_name#3⟭" dob=⟬birth_date#3⟭ doc_type=PASSPORT doc_no=⟬us_passport#3⟭
⟬date#1⟭ 09:14:11.640 WARN  [kyc-worker-2] c.n.kyc.vendor.IdvClient - document expired on ⟬date#2⟭, trying fallback provider
⟬date#1⟭ 09:14:12.508 INFO  [kyc-worker-2] c.n.kyc.vendor.FallbackClient - POST /idv/documents status=200 ref=⟬order_number#1⟭
⟬date#1⟭ 09:14:12.511 INFO  [kyc-worker-2] c.n.kyc.decision.RuleEngine - application ⟬uuid#3⟭ sent to manual review, queue=docs-expired
⟬date#1⟭ 09:14:20.003 INFO  [scheduler-1] c.n.kyc.metrics.QueueGauge - depth=118 oldest_age_s=41
⟬date#1⟭ 09:14:26.447 INFO  [kyc-worker-3] c.n.kyc.ApplicationConsumer - application ⟬uuid#4⟭ received, customer ⟬customer_id#4⟭
⟬date#1⟭ 09:14:26.455 DEBUG [kyc-worker-3] c.n.kyc.IdentityMapper - applicant name="⟬person_name#4⟭" dob=⟬birth_date#4⟭ ssn="⟬us_ssn#4⟭" state_id="⟬us_driver_license#4⟭"
⟬date#1⟭ 09:14:27.130 WARN  [kyc-worker-3] c.n.kyc.vendor.IdvClient - ssn/name mismatch code=R204 application=⟬uuid#4⟭
⟬date#1⟭ 09:14:27.131 DEBUG [kyc-worker-3] c.n.kyc.vendor.IdvClient - raw response: {"subject":"⟬person_name#4⟭","input_address":"⟬postal_address#4⟭","best_match":"⟬postal_address#5⟭","name_similarity":0.61}
⟬date#1⟭ 09:14:27.133 DEBUG [kyc-worker-3] c.n.kyc.decision.NameMatcher - ⟬trap:eponym|Jaro-Winkler⟭ distance below cutoff, 0.61 < 0.85
⟬date#1⟭ 09:14:27.140 INFO  [kyc-worker-3] c.n.kyc.decision.RuleEngine - application ⟬uuid#4⟭ declined reason=IDENTITY_MISMATCH operator=⟬trap:indicator_non_pii|auto-review⟭
⟬date#1⟭ 09:14:31.002 INFO  [watchlist-1] c.n.kyc.watchlist.Screener - rescreening 40 customers
⟬date#1⟭ 09:14:31.774 WARN  [watchlist-1] c.n.kyc.watchlist.Screener - possible sanctions hit on ⟬person_name#6⟭, list=SDN score=0.88
⟬date#1⟭ 09:14:31.776 INFO  [watchlist-1] c.n.kyc.watchlist.CaseService - case ⟬ticket_id#1⟭ opened owner=⟬trap:indicator_non_pii|compliance-queue⟭
⟬date#1⟭ 09:14:50.003 INFO  [scheduler-1] c.n.kyc.metrics.QueueGauge - depth=97 oldest_age_s=33
⟬date#1⟭ 09:15:02.118 INFO  [kyc-worker-1] c.n.kyc.ApplicationConsumer - application ⟬uuid#5⟭ received, customer ⟬customer_id#7⟭
⟬date#1⟭ 09:15:02.126 DEBUG [kyc-worker-1] c.n.kyc.IdentityMapper - applicant name="⟬person_name#7⟭" dob=⟬birth_date#7⟭ ssn="⟬us_ssn#7⟭"
⟬date#1⟭ 09:15:02.127 DEBUG [kyc-worker-1] c.n.kyc.IdentityMapper - employer="⟬company#7⟭" mailing="⟬postal_address#7⟭"
⟬date#1⟭ 09:15:02.610 WARN  [kyc-worker-1] c.n.kyc.vendor.IdvClient - POST /v3/verifications status=429 retry_after=3
⟬date#1⟭ 09:15:05.640 INFO  [kyc-worker-1] c.n.kyc.vendor.IdvClient - POST /v3/verifications status=202 ref=⟬opaque_token#2⟭
⟬date#1⟭ 09:15:06.912 INFO  [kyc-worker-1] c.n.kyc.decision.RuleEngine - application ⟬uuid#5⟭ approved operator=⟬trap:indicator_non_pii|auto-review⟭
⟬date#1⟭ 09:15:12.331 INFO  [token-cache] c.n.kyc.vendor.TokenCache - vendor session rotated value=⟬opaque_token#3⟭ ttl=3600
⟬date#1⟭ 09:15:12.333 INFO  [token-cache] c.n.kyc.vendor.TokenCache - next rotation in 3540s value=⟬uuid#6⟭
⟬date#1⟭ 09:15:20.003 INFO  [scheduler-1] c.n.kyc.metrics.QueueGauge - depth=81 oldest_age_s=28
⟬date#1⟭ 09:15:28.204 INFO  [review-api] c.n.kyc.review.ReviewController - GET /internal/review/⟬uuid#3⟭ by ⟬person_name:handle#8⟭
⟬date#1⟭ 09:15:44.871 INFO  [review-api] c.n.kyc.review.ReviewController - operator="⟬person_name#8⟭" attached replacement passport ⟬us_passport#3⟭ to application ⟬uuid#3⟭
⟬date#1⟭ 09:15:44.902 INFO  [review-api] c.n.kyc.decision.RuleEngine - application ⟬uuid#3⟭ approved after review
⟬date#1⟭ 09:16:03.442 INFO  [kyc-worker-2] c.n.kyc.ApplicationConsumer - application ⟬uuid#7⟭ received, customer ⟬customer_id#9⟭
⟬date#1⟭ 09:16:03.449 DEBUG [kyc-worker-2] c.n.kyc.vendor.EchoFilter - vendor echo follows
⟬person_name#9⟭
⟬us_ssn#9⟭
⟬postal_address#9⟭
⟬date#1⟭ 09:16:03.452 DEBUG [kyc-worker-2] c.n.kyc.vendor.EchoFilter - end of echo
⟬date#1⟭ 09:16:04.120 INFO  [kyc-worker-2] c.n.kyc.decision.RuleEngine - application ⟬uuid#7⟭ approved operator=⟬trap:indicator_non_pii|auto-review⟭
⟬date#1⟭ 09:16:20.003 INFO  [scheduler-1] c.n.kyc.metrics.QueueGauge - depth=52 oldest_age_s=17
⟬date#1⟭ 09:16:41.318 ERROR [kyc-worker-3] c.n.kyc.vendor.IdvClient - connection reset by ⟬hostname#2⟭ after 4012 ms
⟬date#1⟭ 09:16:41.320 INFO  [kyc-worker-3] c.n.kyc.vendor.IdvClient - circuit half-open, 12 applications parked
⟬date#1⟭ 09:17:11.320 INFO  [kyc-worker-3] c.n.kyc.vendor.IdvClient - circuit closed
⟬date#1⟭ 09:17:15.507 INFO  [kyc-worker-3] c.n.kyc.ApplicationConsumer - application ⟬uuid#8⟭ received, customer ⟬customer_id#10⟭
⟬date#1⟭ 09:17:15.513 DEBUG [kyc-worker-3] c.n.kyc.IdentityMapper - applicant name="⟬person_name#10⟭" dob=⟬birth_date#10⟭ doc_type=DRIVER_LICENSE doc_no="⟬us_driver_license#10⟭"
⟬date#1⟭ 09:17:15.990 WARN  [kyc-worker-3] c.n.kyc.vendor.IdvClient - address on license differs from application: "⟬postal_address#10⟭"
⟬date#1⟭ 09:17:15.993 INFO  [kyc-worker-3] c.n.kyc.decision.RuleEngine - application ⟬uuid#8⟭ sent to manual review, queue=address-diff
⟬date#1⟭ 09:17:20.003 INFO  [scheduler-1] c.n.kyc.metrics.QueueGauge - depth=44 oldest_age_s=13
⟬date#1⟭ 09:17:48.116 INFO  [watchlist-1] c.n.kyc.watchlist.Screener - rescreening done hits=1 cleared=39
⟬date#1⟭ 09:17:48.118 INFO  [watchlist-1] c.n.kyc.watchlist.CaseService - case ⟬ticket_id#1⟭ assigned owner="⟬person_name#11⟭"
⟬date#1⟭ 09:18:20.003 INFO  [scheduler-1] c.n.kyc.metrics.QueueGauge - depth=21 oldest_age_s=6
⟬date#1⟭ 09:18:30.640 INFO  [archive] c.n.kyc.archive.Uploader - raw payloads written to ⟬file_path#1⟭
⟬date#1⟭ 09:18:30.902 INFO  [archive] c.n.kyc.archive.Uploader - checksum ⟬hash#1⟭ ok
⟬date#1⟭ 09:18:50.003 INFO  [scheduler-1] c.n.kyc.metrics.QueueGauge - depth=0 oldest_age_s=0
⟬date#1⟭ 09:18:50.010 INFO  [kyc-worker-1] c.n.kyc.ApplicationConsumer - queue drained, sleeping 30s
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: en
fill_locale: en_US
domain: SaaS
appearance: Java stack trace, exception message, HTTP header, map toString
scenario: Spring Boot trace of a help desk product's SCIM provisioning, whose exception prints the user payload with a temporary password and the bearer token
⟬text⟭
⟬date#1⟭ 17:03:44.902 ERROR 1 --- [nio-8080-exec-7] c.h.scim.UserProvisioningController : SCIM create failed for tenant ⟬customer_id#1⟭

com.helpdeck.scim.ProvisioningException: identity provider rejected payload {userName=⟬email#2⟭, displayName="⟬person_name#2⟭", password=⟬password#1⟭, active=true}
	at com.helpdeck.scim.IdpClient.create(IdpClient.java:142)
	at com.helpdeck.scim.UserProvisioningService.provision(UserProvisioningService.java:88)
	at com.helpdeck.scim.UserProvisioningController.createUser(UserProvisioningController.java:57)
	at jdk.internal.reflect.GeneratedMethodAccessor212.invoke(Unknown Source)
	at org.springframework.web.method.support.InvocableHandlerMethod.doInvoke(InvocableHandlerMethod.java:205)
	at org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod.invokeAndHandle(ServletInvocableHandlerMethod.java:117)
	at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:1089)
	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:116)
Caused by: org.springframework.web.reactive.function.client.WebClientResponseException$Conflict: 409 Conflict from POST ⟬url#1⟭
	at org.springframework.web.reactive.function.client.WebClientResponseException.create(WebClientResponseException.java:307)
	Suppressed: reactor.core.publisher.FluxOnAssembly$OnAssemblyException:
Error has been observed at the following site(s):
	*__checkpoint ⇢ 409 from POST ⟬url#1⟭ [DefaultWebClient]
Original Stack Trace:
		at org.springframework.web.reactive.function.client.DefaultClientResponse.lambda$createException$1(DefaultClientResponse.java:224)
		at reactor.core.publisher.MonoMapFuseable$MapFuseableSubscriber.onNext(MonoMapFuseable.java:129)
Request context:
  X-Request-Id: ⟬uuid#1⟭
  X-Tenant: ⟬customer_id#1⟭
  Authorization: Bearer ⟬jwt#1⟭
  User-Agent: ⟬trap:library|jackson-scim-client⟭/⟬version#1⟭
⟬end⟭

⟬template⟭
family: logs
format: test output
language: en
fill_locale: en_US
domain: healthcare
appearance: pytest summary, code identifier, assertion message
scenario: pytest run of a clinical coding library with one failing ICD-10 mapping and no patient data
⟬text⟭
============================= test session starts ==============================
platform linux -- Python 3.12.1, pytest-8.0.2, pluggy-1.4.0
rootdir: /srv/coding-rules, configfile: pyproject.toml
collected 64 items

tests/test_icd10_lookup.py ......F.....                                  [ 18%]
tests/test_drg_grouper.py ....................................................  [100%]

=========================== short test summary info ============================
FAILED tests/test_icd10_lookup.py::⟬trap:code_identifier|test_lookup_hodgkin_lymphoma⟭ - AssertionError: ⟬trap:eponym|Hodgkin⟭ lymphoma mapped to C81.90, ⟬trap:indicator_non_pii|patient_id=None⟭
========================= 1 failed, 63 passed in 1.84s =========================
⟬end⟭

⟬template⟭
family: logs
format: access log
language: en
fill_locale: en_US
domain: retail
appearance: combined log format, query string, request body capture, authenticated user field, card without a key
scenario: nginx access of an outdoor gear store with request bodies captured for debugging, exposing logins, cards, shipping addresses, reset tokens and a session JWT
⟬text⟭
⟬ip_address#1⟭ - - [⟬date#1⟭ 13:55:36 -0400] "GET / HTTP/1.1" 200 18244 "-" "Mozilla/5.0 (iPhone; CPU iPhone OS 17_3 like Mac OS X) AppleWebKit/605.1.15" rt=0.041 rb="-"
⟬ip_address#1⟭ - - [⟬date#1⟭ 13:55:37 -0400] "GET /static/app.3f.js HTTP/1.1" 200 88120 "⟬url#1⟭" "Mozilla/5.0 (iPhone; CPU iPhone OS 17_3 like Mac OS X) AppleWebKit/605.1.15" rt=0.004 rb="-"
⟬ip_address#2⟭ - - [⟬date#1⟭ 13:55:37 -0400] "GET /c/tents?page=2 HTTP/1.1" 200 22410 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/121.0" rt=0.061 rb="-"
⟬ip_address#3⟭ - - [⟬date#1⟭ 13:55:38 -0400] "GET /robots.txt HTTP/1.1" 200 312 "-" "Mozilla/5.0 (compatible; bingbot/2.0)" rt=0.001 rb="-"
⟬ip_address#2⟭ - - [⟬date#1⟭ 13:55:41 -0400] "GET /p/ridgeline-2p-tent HTTP/1.1" 200 30122 "⟬url#2⟭" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/121.0" rt=0.052 rb="-"
⟬ip_address#2⟭ - - [⟬date#1⟭ 13:55:44 -0400] "POST /api/cart HTTP/1.1" 201 96 "⟬url#2⟭" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/121.0" rt=0.019 rb="sku=TNT-2P-OLV&qty=1"
⟬ip_address#2⟭ - - [⟬date#1⟭ 13:55:52 -0400] "POST /account/login HTTP/1.1" 302 0 "⟬url#2⟭" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/121.0" rt=0.204 rb="email=⟬email#2⟭&password=⟬password#1⟭"
⟬ip_address#2⟭ - - [⟬date#1⟭ 13:55:52 -0400] "GET /account?session=⟬jwt#1⟭ HTTP/1.1" 200 9120 "⟬url#2⟭" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/121.0" rt=0.031 rb="-"
⟬ip_address#4⟭ - - [⟬date#1⟭ 13:55:58 -0400] "GET /wp-login.php HTTP/1.1" 404 162 "-" "python-requests/2.31.0" rt=0.001 rb="-"
⟬ip_address#4⟭ - - [⟬date#1⟭ 13:55:58 -0400] "GET /.env HTTP/1.1" 404 162 "-" "python-requests/2.31.0" rt=0.001 rb="-"
⟬ip_address#4⟭ - - [⟬date#1⟭ 13:55:59 -0400] "GET /.git/config HTTP/1.1" 404 162 "-" "python-requests/2.31.0" rt=0.001 rb="-"
⟬ip_address#2⟭ - - [⟬date#1⟭ 13:56:03 -0400] "GET /checkout/shipping HTTP/1.1" 200 14220 "⟬url#2⟭" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/121.0" rt=0.044 rb="-"
⟬ip_address#2⟭ - - [⟬date#1⟭ 13:56:31 -0400] "POST /checkout/shipping HTTP/1.1" 302 0 "⟬url#2⟭" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/121.0" rt=0.088 rb="name=⟬person_name#2⟭&ship_to=⟬postal_address#2⟭&speed=ground"
⟬ip_address#2⟭ - - [⟬date#1⟭ 13:56:31 -0400] "GET /checkout/payment HTTP/1.1" 200 11804 "⟬url#2⟭" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/121.0" rt=0.039 rb="-"
⟬ip_address#2⟭ - - [⟬date#1⟭ 13:57:02 -0400] "POST /checkout/payment HTTP/1.1" 402 214 "⟬url#2⟭" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/121.0" rt=0.912 rb="card=⟬payment_card#2⟭&cvv=⟬card_security_code#2⟭&save=1"
⟬ip_address#2⟭ - - [⟬date#1⟭ 13:57:19 -0400] "POST /checkout/payment HTTP/1.1" 200 188 "⟬url#2⟭" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/121.0" rt=0.640 rb="card=⟬payment_card#2⟭&cvv=⟬card_security_code#2⟭&save=0"
⟬ip_address#2⟭ - - [⟬date#1⟭ 13:57:20 -0400] "GET /order/confirmation?oid=⟬uuid#1⟭&session=⟬jwt#1⟭ HTTP/1.1" 200 7120 "⟬url#2⟭" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/121.0" rt=0.028 rb="-"
⟬ip_address#5⟭ - - [⟬date#1⟭ 13:57:24 -0400] "GET /healthz HTTP/1.1" 200 2 "-" "kube-probe/1.28" rt=0.000 rb="-"
⟬ip_address#6⟭ - - [⟬date#1⟭ 13:57:26 -0400] "GET /account/reset?token=⟬opaque_token#1⟭ HTTP/1.1" 200 4122 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 14_2) Safari/605.1.15" rt=0.023 rb="-"
⟬ip_address#6⟭ - - [⟬date#1⟭ 13:57:49 -0400] "POST /account/reset HTTP/1.1" 302 0 "⟬url#3⟭" "Mozilla/5.0 (Macintosh; Intel Mac OS X 14_2) Safari/605.1.15" rt=0.117 rb="token=⟬opaque_token#1⟭&new_password=⟬password#2⟭"
⟬ip_address#7⟭ - - [⟬date#1⟭ 13:57:58 -0400] "GET /unsubscribe?e=⟬email#3⟭&k=⟬opaque_token#2⟭ HTTP/1.1" 200 2024 "-" "Mozilla/5.0 (Linux; Android 14) Chrome/120.0" rt=0.015 rb="-"
⟬ip_address#8⟭ - ⟬username#1⟭ [⟬date#1⟭ 13:58:02 -0400] "GET /admin/orders?status=held HTTP/1.1" 200 15120 "-" "Mozilla/5.0 (X11; Linux x86_64) Firefox/122.0" rt=0.074 rb="-"
⟬ip_address#8⟭ - ⟬username#1⟭ [⟬date#1⟭ 13:58:09 -0400] "GET /admin/orders/⟬uuid#1⟭ HTTP/1.1" 200 6204 "⟬url#4⟭" "Mozilla/5.0 (X11; Linux x86_64) Firefox/122.0" rt=0.038 rb="-"
⟬ip_address#9⟭ - ⟬person_name:handle#4⟭ [⟬date#1⟭ 13:58:15 -0400] "GET /admin/customers/⟬customer_id#2⟭ HTTP/1.1" 200 5300 "⟬url#4⟭" "Mozilla/5.0 (Macintosh; Intel Mac OS X 14_2) Chrome/121.0" rt=0.033 rb="-"
⟬ip_address#9⟭ - ⟬person_name:handle#4⟭ [⟬date#1⟭ 13:58:40 -0400] "POST /admin/customers/⟬customer_id#2⟭/note HTTP/1.1" 201 44 "⟬url#4⟭" "Mozilla/5.0 (Macintosh; Intel Mac OS X 14_2) Chrome/121.0" rt=0.021 rb="note=called back, wife ⟬person_name#5f⟭ confirmed new address ⟬postal_address#2⟭"
⟬ip_address#5⟭ - - [⟬date#1⟭ 13:58:54 -0400] "GET /healthz HTTP/1.1" 200 2 "-" "kube-probe/1.28" rt=0.000 rb="-"
⟬ip_address#10⟭ - - [⟬date#1⟭ 13:59:03 -0400] "GET /c/sleeping-bags HTTP/1.1" 200 20100 "-" "Mozilla/5.0 (compatible; Googlebot/2.1)" rt=0.057 rb="-"
⟬ip_address#10⟭ - - [⟬date#1⟭ 13:59:04 -0400] "GET /c/sleeping-bags?sort=price HTTP/1.1" 200 20188 "-" "Mozilla/5.0 (compatible; Googlebot/2.1)" rt=0.055 rb="-"
⟬ip_address#11⟭ - - [⟬date#1⟭ 13:59:11 -0400] "GET /p/alpine-stove HTTP/1.1" 200 26418 "⟬url#5⟭" "Mozilla/5.0 (Linux; Android 13) Chrome/119.0" rt=0.047 rb="-"
⟬ip_address#11⟭ - - [⟬date#1⟭ 13:59:18 -0400] "POST /api/cart HTTP/1.1" 201 96 "⟬url#5⟭" "Mozilla/5.0 (Linux; Android 13) Chrome/119.0" rt=0.018 rb="sku=STV-ALP-01&qty=2"
⟬ip_address#11⟭ - - [⟬date#1⟭ 13:59:33 -0400] "POST /api/v2/pay/express HTTP/1.1" 200 140 "⟬url#5⟭" "okhttp/4.12.0" rt=0.533 rb="⟬payment_card#6⟭|⟬card_security_code#6⟭|⟬postcode#6⟭"
⟬ip_address#11⟭ - - [⟬date#1⟭ 13:59:33 -0400] "GET /order/confirmation?oid=⟬uuid#2⟭ HTTP/1.1" 200 7040 "⟬url#5⟭" "okhttp/4.12.0" rt=0.021 rb="-"
⟬ip_address#12⟭ - - [⟬date#1⟭ 13:59:47 -0400] "POST /api/gift-card/balance HTTP/1.1" 200 61 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Edge/121.0" rt=0.016 rb="value=⟬opaque_token#3⟭"
⟬ip_address#12⟭ - - [⟬date#1⟭ 13:59:52 -0400] "POST /api/wishlist/item HTTP/1.1" 201 40 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Edge/121.0" rt=0.014 rb="value=⟬uuid#3⟭"
⟬ip_address#5⟭ - - [⟬date#1⟭ 14:00:24 -0400] "GET /healthz HTTP/1.1" 200 2 "-" "kube-probe/1.28" rt=0.000 rb="-"
⟬ip_address#13⟭ - - [⟬date#1⟭ 14:00:31 -0400] "GET /stores?near=⟬postcode#7⟭ HTTP/1.1" 200 8022 "-" "Mozilla/5.0 (iPad; CPU OS 17_2 like Mac OS X) Safari/604.1" rt=0.066 rb="-"
⟬ip_address#13⟭ - - [⟬date#1⟭ 14:00:39 -0400] "GET /stores/⟬trap:word_name|Savannah-river-street⟭ HTTP/1.1" 200 6410 "⟬url#6⟭" "Mozilla/5.0 (iPad; CPU OS 17_2 like Mac OS X) Safari/604.1" rt=0.029 rb="-"
⟬ip_address#14⟭ - - [⟬date#1⟭ 14:00:44 -0400] "POST /newsletter HTTP/1.1" 204 0 "⟬url#7⟭" "Mozilla/5.0 (Linux; Android 14) Chrome/120.0" rt=0.012 rb="email=⟬email#8⟭&source=footer"
⟬ip_address#14⟭ - - [⟬date#1⟭ 14:00:45 -0400] "GET /c/jackets HTTP/1.1" 200 21900 "⟬url#7⟭" "Mozilla/5.0 (Linux; Android 14) Chrome/120.0" rt=0.051 rb="-"
⟬ip_address#15⟭ - - [⟬date#1⟭ 14:01:02 -0400] "POST /api/returns HTTP/1.1" 201 88 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 13_6) Chrome/120.0" rt=0.097 rb="order=⟬order_number#1⟭&pickup=⟬postal_address#9⟭&phone=⟬phone#9⟭"
⟬ip_address#15⟭ - - [⟬date#1⟭ 14:01:04 -0400] "GET /account/returns HTTP/1.1" 200 5120 "⟬url#7⟭" "Mozilla/5.0 (Macintosh; Intel Mac OS X 13_6) Chrome/120.0" rt=0.024 rb="-"
⟬ip_address#3⟭ - - [⟬date#1⟭ 14:01:11 -0400] "GET /sitemap.xml HTTP/1.1" 200 90124 "-" "Mozilla/5.0 (compatible; bingbot/2.0)" rt=0.006 rb="-"
⟬ip_address#16⟭ - - [⟬date#1⟭ 14:01:18 -0400] "GET /api/products?ids=118,204,377 HTTP/1.1" 200 4410 "-" "curl/8.4.0" rt=0.013 rb="-"
⟬ip_address#5⟭ - - [⟬date#1⟭ 14:01:54 -0400] "GET /healthz HTTP/1.1" 200 2 "-" "kube-probe/1.28" rt=0.000 rb="-"
⟬ip_address#17⟭ - - [⟬date#1⟭ 14:02:03 -0400] "GET /p/ridgeline-2p-tent HTTP/1.1" 304 0 "-" "Mozilla/5.0 (X11; Ubuntu; Linux x86_64) Firefox/121.0" rt=0.009 rb="-"
⟬ip_address#17⟭ - - [⟬date#1⟭ 14:02:06 -0400] "POST /api/reviews HTTP/1.1" 201 72 "⟬url#8⟭" "Mozilla/5.0 (X11; Ubuntu; Linux x86_64) Firefox/121.0" rt=0.027 rb="sku=TNT-2P-OLV&stars=4&display_name=⟬trap:indicator_non_pii|anonymous⟭"
⟬ip_address#18⟭ - - [⟬date#1⟭ 14:02:15 -0400] "POST /api/reviews HTTP/1.1" 201 72 "⟬url#8⟭" "Mozilla/5.0 (Linux; Android 13) Chrome/119.0" rt=0.026 rb="sku=TNT-2P-OLV&stars=2&display_name=⟬person_name:handle#10⟭"
⟬ip_address#19⟭ - - [⟬date#1⟭ 14:02:21 -0400] "GET /admin HTTP/1.1" 401 188 "-" "Mozilla/5.0 (compatible; Nimbostratus-Bot/1.0)" rt=0.002 rb="-"
⟬ip_address#19⟭ - - [⟬date#1⟭ 14:02:22 -0400] "POST /admin/login HTTP/1.1" 401 188 "-" "Mozilla/5.0 (compatible; Nimbostratus-Bot/1.0)" rt=0.190 rb="user=⟬trap:indicator_non_pii|admin⟭&password=⟬password#3⟭"
⟬ip_address#19⟭ - - [⟬date#1⟭ 14:02:24 -0400] "POST /admin/login HTTP/1.1" 401 188 "-" "Mozilla/5.0 (compatible; Nimbostratus-Bot/1.0)" rt=0.188 rb="user=⟬trap:indicator_non_pii|root⟭&password=⟬password#4⟭"
⟬ip_address#5⟭ - - [⟬date#1⟭ 14:02:54 -0400] "GET /healthz HTTP/1.1" 200 2 "-" "kube-probe/1.28" rt=0.000 rb="-"
⟬ip_address#20⟭ - - [⟬date#1⟭ 14:03:01 -0400] "GET /c/tents HTTP/1.1" 200 22390 "⟬url#9⟭" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/121.0" rt=0.058 rb="-"
⟬ip_address#20⟭ - - [⟬date#1⟭ 14:03:09 -0400] "GET /p/ridgeline-3p-tent HTTP/1.1" 200 29980 "⟬url#9⟭" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/121.0" rt=0.049 rb="-"
⟬ip_address#20⟭ - - [⟬date#1⟭ 14:03:18 -0400] "GET /wishlist/share?t=⟬opaque_token#4⟭ HTTP/1.1" 200 3180 "⟬url#9⟭" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/121.0" rt=0.022 rb="-"
⟬ip_address#21⟭ - - [⟬date#1⟭ 14:03:27 -0400] "GET /order/track?ref=⟬order_number#2⟭&zip=⟬postcode#11⟭ HTTP/1.1" 200 3604 "-" "Mozilla/5.0 (iPhone; CPU iPhone OS 16_7 like Mac OS X) Safari/604.1" rt=0.035 rb="-"
⟬ip_address#21⟭ - - [⟬date#1⟭ 14:03:44 -0400] "GET /order/track/map HTTP/1.1" 200 12044 "⟬url#10⟭" "Mozilla/5.0 (iPhone; CPU iPhone OS 16_7 like Mac OS X) Safari/604.1" rt=0.043 rb="-"
⟬ip_address#5⟭ - - [⟬date#1⟭ 14:03:54 -0400] "GET /healthz HTTP/1.1" 200 2 "-" "kube-probe/1.28" rt=0.000 rb="-"
⟬ip_address#22⟭ - - [⟬date#1⟭ 14:03:58 -0400] "GET /static/fonts/inter.woff2 HTTP/1.1" 200 41288 "⟬url#11⟭" "Mozilla/5.0 (Macintosh; Intel Mac OS X 14_1) Safari/605.1.15" rt=0.003 rb="-"
⟬ip_address#22⟭ - - [⟬date#1⟭ 14:04:10 -0400] "POST /api/chat/start HTTP/1.1" 201 58 "⟬url#11⟭" "Mozilla/5.0 (Macintosh; Intel Mac OS X 14_1) Safari/605.1.15" rt=0.031 rb="topic=returns&first_message=hi this is ⟬person_name#12⟭, order ⟬order_number#2⟭ never arrived"
⟬ip_address#5⟭ - - [⟬date#1⟭ 14:04:54 -0400] "GET /healthz HTTP/1.1" 200 2 "-" "kube-probe/1.28" rt=0.000 rb="-"
⟬ip_address#23⟭ - - [⟬date#1⟭ 14:05:02 -0400] "GET /api/loyalty/points?member=⟬customer_id#13⟭&token=⟬jwt#2⟭ HTTP/1.1" 200 118 "-" "StoreApp/⟬version#1⟭ (iOS 17.3)" rt=0.019 rb="-"
⟬ip_address#23⟭ - - [⟬date#1⟭ 14:05:09 -0400] "POST /api/loyalty/redeem HTTP/1.1" 200 64 "-" "StoreApp/⟬version#1⟭ (iOS 17.3)" rt=0.041 rb="ref=⟬order_number#3⟭&points=1200"
⟬ip_address#24⟭ - - [⟬date#1⟭ 14:05:17 -0400] "GET /p/trekking-poles HTTP/1.1" 200 24120 "⟬url#12⟭" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Firefox/122.0" rt=0.048 rb="-"
⟬ip_address#24⟭ - - [⟬date#1⟭ 14:05:26 -0400] "POST /api/cart HTTP/1.1" 201 96 "⟬url#12⟭" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Firefox/122.0" rt=0.017 rb="sku=PLE-TRK-02&qty=1"
⟬ip_address#5⟭ - - [⟬date#1⟭ 14:05:54 -0400] "GET /healthz HTTP/1.1" 200 2 "-" "kube-probe/1.28" rt=0.000 rb="-"
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: en
fill_locale: en_US
domain: government
appearance: GitHub Actions log, shell trace, seed script output, masked secret, connection string
scenario: GitHub Actions deployment of a state permit portal, where masking catches one secret but a seed script prints a demo holder's license, plate and the admin password
⟬text⟭
⟬date#1⟭ 14:02:07 Current runner version: '⟬version#1⟭'
⟬date#1⟭ 14:02:07 ##[group]Runner Image
⟬date#1⟭ 14:02:07 Image: ubuntu-22.04
⟬date#1⟭ 14:02:07 ##[endgroup]
⟬date#1⟭ 14:02:09 Download action repository '⟬trap:email_lookalike|actions/checkout@v4⟭' (SHA:⟬git_sha#1⟭)
⟬date#1⟭ 14:02:10 ##[group]Run ./scripts/deploy_staging.sh
⟬date#1⟭ 14:02:10 env:
⟬date#1⟭ 14:02:10   REGISTRY_USER: ⟬trap:indicator_non_pii|svc-permits-ci⟭
⟬date#1⟭ 14:02:10   REGISTRY_PASSWORD: ⟬trap:placeholder|***⟭
⟬date#1⟭ 14:02:10   DEPLOY_ENV: staging
⟬date#1⟭ 14:02:10 ##[endgroup]
⟬date#1⟭ 14:02:11 + docker pull ⟬hostname#1⟭/permits/api:⟬version#2⟭
⟬date#1⟭ 14:02:34 Status: Downloaded newer image
⟬date#1⟭ 14:02:35 + psql postgresql://permits_app:⟬url_password#1⟭@⟬hostname#2⟭:5432/permits -f db/migrate/0042_add_plate_index.sql
⟬date#1⟭ 14:02:36 CREATE INDEX
⟬date#1⟭ 14:02:36 + python scripts/seed_demo.py --holders 1 --verbose
⟬date#1⟭ 14:02:37 [seed] demo holder: "⟬person_name#3⟭", license "⟬us_driver_license#3⟭", plate "⟬us_license_plate#3⟭"
⟬date#1⟭ 14:02:37 [seed] demo holder address: "⟬postal_address#3⟭"
⟬date#1⟭ 14:02:37 [seed] created console admin ⟬trap:indicator_non_pii|user=permits-admin⟭ with password ⟬password#1⟭
⟬date#1⟭ 14:02:38 [seed] hmac value ⟬opaque_token#1⟭ written to config table
⟬date#1⟭ 14:02:38 + curl -fsS ⟬url#1⟭
⟬date#1⟭ 14:02:38 {"status":"ok","build":"⟬git_sha#1⟭"}
⟬date#1⟭ 14:02:39 Deployment finished, notifying ⟬ticket_id#1⟭
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: en
fill_locale: en_US
domain: travel
appearance: JSON lines, audit trail, nested JSON
scenario: audit trail of an airline crew scheduling system during one night of automated roster publishing, run only by service accounts
⟬text⟭
{"ts":"⟬date#1⟭ 02:00:04","actor":"⟬trap:indicator_non_pii|svc-roster⟭","action":"roster.publish.start","resource":"fleet/A320/base/⟬trap:word_name|Charlotte⟭","ip":"⟬ip_address#1⟭","request_id":"⟬uuid#1⟭"}
{"ts":"⟬date#1⟭ 02:00:09","actor":"⟬trap:indicator_non_pii|svc-roster⟭","action":"roster.rule.evaluate","resource":"fleet/A320/base/⟬trap:word_name|Charlotte⟭","detail":{"rule":"far117-rest","violations":0},"request_id":"⟬uuid#1⟭"}
{"ts":"⟬date#1⟭ 02:00:31","actor":"⟬trap:indicator_non_pii|svc-roster⟭","action":"roster.publish.end","resource":"fleet/A320/base/⟬trap:word_name|Charlotte⟭","detail":{"pairings":418,"changed":12},"request_id":"⟬uuid#1⟭"}
{"ts":"⟬date#1⟭ 02:01:02","actor":"⟬trap:indicator_non_pii|svc-roster⟭","action":"roster.publish.start","resource":"fleet/B737/base/⟬trap:word_name|Austin⟭","ip":"⟬ip_address#1⟭","request_id":"⟬uuid#2⟭"}
{"ts":"⟬date#1⟭ 02:01:37","actor":"⟬trap:indicator_non_pii|svc-roster⟭","action":"roster.publish.end","resource":"fleet/B737/base/⟬trap:word_name|Austin⟭","detail":{"pairings":602,"changed":31},"request_id":"⟬uuid#2⟭"}
{"ts":"⟬date#1⟭ 02:02:00","actor":"⟬trap:indicator_non_pii|cron-fatigue⟭","action":"fatigue.score.recompute","resource":"model/⟬version#1⟭","detail":{"algorithm":"⟬trap:eponym|Kalman⟭ smoother","crew_records":0},"request_id":"⟬uuid#3⟭"}
{"ts":"⟬date#1⟭ 02:02:44","actor":"⟬trap:indicator_non_pii|svc-notify⟭","action":"notification.batch.queue","resource":"topic/crew-roster","detail":{"messages":43,"recipient_list":"⟬trap:indicator_non_pii|group:all-crew⟭"},"request_id":"⟬uuid#4⟭"}
{"ts":"⟬date#1⟭ 02:03:10","actor":"⟬trap:indicator_non_pii|svc-notify⟭","action":"notification.batch.sent","resource":"topic/crew-roster","detail":{"delivered":43,"failed":0},"request_id":"⟬uuid#4⟭"}
{"ts":"⟬date#1⟭ 02:05:00","actor":"⟬trap:indicator_non_pii|sched-admin-bot⟭","action":"config.update","resource":"settings/rest-buffer-minutes","detail":{"old":30,"new":45,"change":"⟬ticket_id#1⟭"},"ip":"⟬ip_address#2⟭","request_id":"⟬uuid#5⟭"}
{"ts":"⟬date#1⟭ 02:05:01","actor":"⟬trap:indicator_non_pii|sched-admin-bot⟭","action":"cache.invalidate","resource":"settings/*","ip":"⟬ip_address#2⟭","request_id":"⟬uuid#5⟭"}
{"ts":"⟬date#1⟭ 02:10:12","actor":"⟬trap:indicator_non_pii|svc-export⟭","action":"export.create","resource":"s3/roster-exports/⟬hash#1⟭.parquet","detail":{"rows":1020,"employee_name":"⟬trap:indicator_non_pii|excluded⟭"},"request_id":"⟬uuid#6⟭"}
{"ts":"⟬date#1⟭ 02:10:40","actor":"⟬trap:indicator_non_pii|svc-export⟭","action":"export.sign","resource":"s3/roster-exports/⟬hash#1⟭.parquet","detail":{"fingerprint":"⟬hash#2⟭"},"request_id":"⟬uuid#6⟭"}
{"ts":"⟬date#1⟭ 02:15:00","actor":"⟬trap:indicator_non_pii|svc-roster⟭","action":"lock.release","resource":"planner/global","request_id":"⟬uuid#7⟭"}
{"ts":"⟬date#1⟭ 03:00:00","actor":"⟬trap:indicator_non_pii|svc-audit⟭","action":"audit.rotate","resource":"⟬hostname#1⟭","detail":{"segment":"⟬uuid#8⟭","events":13},"request_id":"⟬uuid#9⟭"}
{"ts":"⟬date#1⟭ 03:00:02","actor":"⟬trap:indicator_non_pii|svc-audit⟭","action":"audit.verify","resource":"⟬hostname#1⟭","detail":{"chain":"⟬trap:eponym|Merkle⟭","root":"⟬hash#3⟭"},"request_id":"⟬uuid#9⟭"}
{"ts":"⟬date#1⟭ 03:30:00","actor":"⟬trap:indicator_non_pii|svc-roster⟭","action":"standby.pool.refresh","resource":"fleet/E175/base/⟬trap:word_name|Madison⟭","detail":{"reserve":14},"request_id":"⟬uuid#10⟭"}
{"ts":"⟬date#1⟭ 03:45:17","actor":"⟬trap:indicator_non_pii|svc-roster⟭","action":"token.renew","resource":"client/roster-worker","detail":{"token_ttl_s":⟬trap:indicator_non_pii|3600⟭},"request_id":"⟬uuid#11⟭"}
{"ts":"⟬date#1⟭ 04:00:00","actor":"⟬trap:indicator_non_pii|system⟭","action":"health.report","resource":"crew-scheduling","detail":{"status":"green","version":"⟬version#2⟭"},"request_id":"⟬uuid#12⟭"}
⟬end⟭

⟬template⟭
family: logs
format: application log
language: en
fill_locale: en_US
domain: healthcare
appearance: logfmt, key=value, masked field, eponym in a message
scenario: one hour of a hospital integration engine routing lab and admission messages, where every patient field is masked and only channel statistics remain
⟬text⟭
ts="⟬date#1⟭ 06:00:00" level=info comp=engine msg="channel sweep" channels=14 version=⟬version#1⟭ node=⟬hostname#1⟭
ts="⟬date#1⟭ 06:00:00" level=info comp=config ⟬trap:indicator_non_pii|patient_name_policy=hash⟭ ⟬trap:indicator_non_pii|mrn_visible=false⟭ ⟬trap:indicator_non_pii|dob_precision=year⟭
ts="⟬date#1⟭ 06:00:01" level=debug comp=config msg="loaded masking profile" path=⟬file_path#1⟭
ts="⟬date#1⟭ 06:00:02" level=info comp=listener port=6661 proto=mllp channel=adt-in state=open
ts="⟬date#1⟭ 06:00:02" level=info comp=listener port=6662 proto=mllp channel=orm-in state=open
ts="⟬date#1⟭ 06:00:02" level=info comp=listener port=6663 proto=mllp channel=oru-in state=open
ts="⟬date#1⟭ 06:00:03" level=info comp=sender channel=adt-out dest=⟬hostname#2⟭ state=connected
ts="⟬date#1⟭ 06:00:03" level=info comp=sender channel=oru-out dest=⟬hostname#3⟭ state=connected
ts="⟬date#1⟭ 06:00:04" level=warn comp=sender channel=orm-out dest=⟬hostname#4⟭ state=retrying attempt=1
ts="⟬date#1⟭ 06:00:09" level=info comp=sender channel=orm-out dest=⟬hostname#4⟭ state=connected attempt=2
ts="⟬date#1⟭ 06:01:00" level=info comp=stats channel=adt-in received=41 filtered=3 errored=0
ts="⟬date#1⟭ 06:01:00" level=info comp=stats channel=oru-in received=112 filtered=0 errored=0
ts="⟬date#1⟭ 06:01:00" level=info comp=stats channel=orm-in received=27 filtered=1 errored=0
ts="⟬date#1⟭ 06:02:14" level=debug comp=transform channel=adt-in message=⟬uuid#1⟭ type=ADT^A01 ⟬trap:indicator_non_pii|patient_name=<masked>⟭ ⟬trap:indicator_non_pii|ssn=<masked>⟭
ts="⟬date#1⟭ 06:02:15" level=debug comp=transform channel=adt-in message=⟬uuid#2⟭ type=ADT^A03 ⟬trap:indicator_non_pii|patient_name=<masked>⟭ ⟬trap:indicator_non_pii|ssn=<masked>⟭
ts="⟬date#1⟭ 06:03:41" level=warn comp=validate channel=oru-in message=⟬uuid#3⟭ segment=OBX reason="unit missing for LOINC 2160-0" facility=⟬trap:word_name|Savannah-West⟭
ts="⟬date#1⟭ 06:04:02" level=info comp=dedupe msg="duplicate suppressed" filter="⟬trap:eponym|Bloom⟭" fill=0.31 message=⟬uuid#4⟭
ts="⟬date#1⟭ 06:05:00" level=info comp=stats channel=adt-in received=208 filtered=11 errored=0
ts="⟬date#1⟭ 06:05:00" level=info comp=stats channel=oru-in received=540 filtered=2 errored=1
ts="⟬date#1⟭ 06:05:00" level=info comp=stats channel=orm-in received=119 filtered=4 errored=0
ts="⟬date#1⟭ 06:07:33" level=error comp=sender channel=oru-out dest=⟬hostname#3⟭ msg="NACK AE" message=⟬uuid#5⟭ reason="unknown ordering provider code"
ts="⟬date#1⟭ 06:07:33" level=info comp=queue channel=oru-out msg="moved to dead letter" message=⟬uuid#5⟭ ⟬trap:indicator_non_pii|owner=integration-team⟭
ts="⟬date#1⟭ 06:10:00" level=info comp=stats channel=adt-in received=421 filtered=19 errored=0
ts="⟬date#1⟭ 06:10:00" level=info comp=stats channel=oru-in received=1033 filtered=2 errored=1
ts="⟬date#1⟭ 06:10:00" level=info comp=stats channel=orm-in received=240 filtered=7 errored=0
ts="⟬date#1⟭ 06:12:18" level=info comp=router rule=lab-critical matched=4 dest=oncall-pager ⟬trap:indicator_non_pii|recipient=role:lab-oncall⟭
ts="⟬date#1⟭ 06:14:51" level=debug comp=router rule=radiology-split matched=9 facility=⟬trap:word_name|Charlotte-Main⟭
ts="⟬date#1⟭ 06:15:00" level=info comp=stats channel=adt-in received=640 filtered=26 errored=0
ts="⟬date#1⟭ 06:15:00" level=info comp=stats channel=oru-in received=1561 filtered=3 errored=1
ts="⟬date#1⟭ 06:15:00" level=info comp=stats channel=orm-in received=366 filtered=9 errored=0
ts="⟬date#1⟭ 06:18:06" level=info comp=mapping table=loinc-local entries=8120 reloaded=true checksum=⟬hash#1⟭
ts="⟬date#1⟭ 06:20:00" level=info comp=stats channel=adt-in received=851 filtered=31 errored=0
ts="⟬date#1⟭ 06:20:00" level=info comp=stats channel=oru-in received=2098 filtered=3 errored=1
ts="⟬date#1⟭ 06:20:00" level=info comp=stats channel=orm-in received=489 filtered=12 errored=0
ts="⟬date#1⟭ 06:22:37" level=warn comp=jvm msg="gc pause" pause_ms=412 heap_used_mb=3120
ts="⟬date#1⟭ 06:25:00" level=info comp=stats channel=adt-in received=1064 filtered=37 errored=0
ts="⟬date#1⟭ 06:25:00" level=info comp=stats channel=oru-in received=2630 filtered=4 errored=1
ts="⟬date#1⟭ 06:25:00" level=info comp=stats channel=orm-in received=610 filtered=14 errored=0
ts="⟬date#1⟭ 06:27:19" level=debug comp=transform channel=oru-in message=⟬uuid#6⟭ test="⟬trap:eponym|Apgar⟭ score" loinc=9272-6 ⟬trap:indicator_non_pii|patient_id=PATIENT_000000⟭
ts="⟬date#1⟭ 06:30:00" level=info comp=stats channel=adt-in received=1277 filtered=44 errored=0
ts="⟬date#1⟭ 06:30:00" level=info comp=stats channel=oru-in received=3155 filtered=4 errored=1
ts="⟬date#1⟭ 06:30:00" level=info comp=stats channel=orm-in received=731 filtered=16 errored=0
ts="⟬date#1⟭ 06:31:02" level=info comp=scheduler job=purge-acks deleted=4120 duration_ms=881
ts="⟬date#1⟭ 06:33:40" level=warn comp=validate channel=adt-in message=⟬uuid#7⟭ segment=PV1 reason="bed code not in census table" facility=⟬trap:word_name|Madison-North⟭
ts="⟬date#1⟭ 06:35:00" level=info comp=stats channel=adt-in received=1490 filtered=49 errored=0
ts="⟬date#1⟭ 06:35:00" level=info comp=stats channel=oru-in received=3688 filtered=4 errored=2
ts="⟬date#1⟭ 06:35:00" level=info comp=stats channel=orm-in received=853 filtered=19 errored=0
ts="⟬date#1⟭ 06:38:27" level=error comp=sender channel=orm-out dest=⟬hostname#4⟭ msg="read timeout" timeout_ms=30000 message=⟬uuid#8⟭
ts="⟬date#1⟭ 06:38:57" level=info comp=sender channel=orm-out dest=⟬hostname#4⟭ state=connected message=⟬uuid#8⟭ redelivered=true
ts="⟬date#1⟭ 06:40:00" level=info comp=stats channel=adt-in received=1702 filtered=53 errored=0
ts="⟬date#1⟭ 06:40:00" level=info comp=stats channel=oru-in received=4210 filtered=4 errored=2
ts="⟬date#1⟭ 06:40:00" level=info comp=stats channel=orm-in received=974 filtered=21 errored=0
ts="⟬date#1⟭ 06:42:12" level=debug comp=audit msg="access sample written" sample=⟬uuid#9⟭ ⟬trap:indicator_non_pii|user=interface-engine⟭
ts="⟬date#1⟭ 06:45:00" level=info comp=stats channel=adt-in received=1915 filtered=58 errored=0
ts="⟬date#1⟭ 06:45:00" level=info comp=stats channel=oru-in received=4733 filtered=5 errored=2
ts="⟬date#1⟭ 06:45:00" level=info comp=stats channel=orm-in received=1096 filtered=22 errored=0
ts="⟬date#1⟭ 06:48:55" level=info comp=router rule=lab-critical matched=2 dest=oncall-pager ⟬trap:indicator_non_pii|recipient=role:lab-oncall⟭
ts="⟬date#1⟭ 06:50:00" level=info comp=stats channel=adt-in received=2127 filtered=63 errored=0
ts="⟬date#1⟭ 06:50:00" level=info comp=stats channel=oru-in received=5260 filtered=5 errored=2
ts="⟬date#1⟭ 06:50:00" level=info comp=stats channel=orm-in received=1218 filtered=24 errored=0
ts="⟬date#1⟭ 06:55:00" level=info comp=stats channel=adt-in received=2340 filtered=68 errored=0
ts="⟬date#1⟭ 06:55:00" level=info comp=stats channel=oru-in received=5788 filtered=5 errored=2
ts="⟬date#1⟭ 06:55:00" level=info comp=stats channel=orm-in received=1340 filtered=25 errored=0
ts="⟬date#1⟭ 07:00:00" level=info comp=engine msg="hourly checkpoint" lag_ms=38 dead_letters=1 node=⟬hostname#1⟭
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: en
fill_locale: en_US
domain: retail
appearance: Python traceback, exception message, value without a key
scenario: Python traceback of a store checkout service, whose decline exception repeats the card number and security code with no field names
⟬text⟭
Traceback (most recent call last):
  File "/app/checkout/charge.py", line 61, in capture
    resp = gateway.authorize(pan, cvv, amount_cents)
  File "/app/checkout/gateway.py", line 118, in authorize
    raise DeclinedError(f"declined {pan} {cvv} amount={amount_cents}")
checkout.errors.DeclinedError: declined ⟬payment_card#1⟭ ⟬card_security_code#1⟭ amount=4599
⟬end⟭

⟬template⟭
family: logs
format: test output
language: en
fill_locale: en_US
domain: government
appearance: Maven Surefire report, assertion message, toString dump, test fixture
scenario: Surefire failure of a state benefits eligibility rule, whose toString dump prints the fixture applicant with SSN, passport and mailing address
⟬text⟭
[INFO] -------------------------------------------------------
[INFO]  T E S T S
[INFO] -------------------------------------------------------
[INFO] Running gov.benefits.claims.IncomeRuleTest
[INFO] Tests run: 22, Failures: 0, Errors: 0, Skipped: 1, Time elapsed: 0.914 s - in gov.benefits.claims.IncomeRuleTest
[INFO] Running gov.benefits.claims.EligibilityServiceTest
[ERROR] Tests run: 14, Failures: 1, Errors: 0, Skipped: 0, Time elapsed: 2.318 s <<< FAILURE! - in gov.benefits.claims.EligibilityServiceTest
[ERROR] gov.benefits.claims.EligibilityServiceTest.rejectsApplicantOverIncomeLimit  Time elapsed: 0.042 s  <<< FAILURE!
org.opentest4j.AssertionFailedError:

expected: INELIGIBLE
 but was: ELIGIBLE
	at gov.benefits.claims.EligibilityServiceTest.rejectsApplicantOverIncomeLimit(EligibilityServiceTest.java:73)

[ERROR] applicant under test: Applicant{fullName="⟬person_name#1⟭", ssn=⟬us_ssn#1⟭, dateOfBirth=⟬birth_date#1⟭, passportNo=⟬us_passport#1⟭, mailingAddress="⟬postal_address#1⟭", householdSize=3, annualIncome=71250.00, caseworker="⟬person_name#2⟭", filedOn=⟬date#1⟭}
[INFO]
[INFO] Results:
[INFO]
[ERROR] Failures:
[ERROR]   EligibilityServiceTest.rejectsApplicantOverIncomeLimit:73 expected: INELIGIBLE but was: ELIGIBLE
[INFO]
[ERROR] Tests run: 36, Failures: 1, Errors: 0, Skipped: 1
[INFO]
[INFO] BUILD FAILURE
[INFO] Finished at: ⟬date#1⟭ 16:44:12
⟬end⟭

⟬template⟭
family: logs
format: access log
language: en
fill_locale: en_US
domain: travel
appearance: Envoy access line, passport in a path, token in a query string, Authorization header capture
scenario: Envoy access at an airline's advance passenger gateway, with passports in paths, a resume token in the query string and an Authorization header captured by a debug filter
⟬text⟭
[⟬date#1⟭ 11:02:41.118] "GET /v2/booking/⟬order_number#1⟭/passengers HTTP/1.1" 200 - 0 1822 34 ⟬ip_address#1⟭ "okhttp/4.12.0" "⟬uuid#1⟭" auth="Bearer ⟬jwt#1⟭"
[⟬date#1⟭ 11:02:41.902] "PUT /v2/apis/passengers/⟬us_passport#2⟭/document HTTP/1.1" 204 - 512 0 88 ⟬ip_address#1⟭ "okhttp/4.12.0" "⟬uuid#2⟭" auth="Bearer ⟬jwt#1⟭"
[⟬date#1⟭ 11:02:42.340] "GET /v2/apis/passengers/⟬us_passport#2⟭/status HTTP/1.1" 200 - 0 96 21 ⟬ip_address#1⟭ "okhttp/4.12.0" "⟬uuid#3⟭" auth="Bearer ⟬jwt#1⟭"
[⟬date#1⟭ 11:02:44.771] "POST /v2/checkin/start?resume=⟬opaque_token#1⟭ HTTP/1.1" 200 - 214 702 140 ⟬ip_address#1⟭ "okhttp/4.12.0" "⟬uuid#4⟭" auth="-"
[⟬date#1⟭ 11:02:45.006] "GET /healthz HTTP/1.1" 200 - 0 2 0 ⟬ip_address#2⟭ "kube-probe/1.28" "⟬uuid#5⟭" auth="-"
[⟬date#1⟭ 11:02:47.415] "GET /v2/flights/status?origin=CLT&dest=AUS HTTP/1.1" 200 - 0 4410 31 ⟬ip_address#3⟭ "Mozilla/5.0 (iPhone; CPU iPhone OS 17_3 like Mac OS X)" "⟬uuid#6⟭" auth="-"
[⟬date#1⟭ 11:02:49.120] "GET /v2/boarding-pass?token=⟬jwt#2⟭ HTTP/1.1" 200 - 0 18220 77 ⟬ip_address#3⟭ "Mozilla/5.0 (iPhone; CPU iPhone OS 17_3 like Mac OS X)" "⟬uuid#7⟭" auth="-"
[⟬date#1⟭ 11:02:52.644] "PUT /v2/apis/passengers/⟬us_passport#3⟭/document HTTP/1.1" 422 - 498 141 62 ⟬ip_address#4⟭ "AirlineApp/⟬version#1⟭ (Android 14)" "⟬uuid#8⟭" auth="Bearer ⟬opaque_token#2⟭"
[⟬date#1⟭ 11:02:53.018] "POST /v2/apis/retry HTTP/1.1" 202 - 88 44 19 ⟬ip_address#4⟭ "AirlineApp/⟬version#1⟭ (Android 14)" "⟬uuid#9⟭" auth="Bearer ⟬opaque_token#2⟭"
[⟬date#1⟭ 11:02:55.337] "GET /v2/miles/balance?member=⟬customer_id#5⟭&sig=⟬opaque_token#3⟭ HTTP/1.1" 200 - 0 120 26 ⟬ip_address#5⟭ "Mozilla/5.0 (Macintosh; Intel Mac OS X 14_2) Safari/605.1.15" "⟬uuid#10⟭" auth="-"
[⟬date#1⟭ 11:02:57.910] "GET /v2/miles/statement?member=⟬customer_id#5⟭&ref=⟬uuid#17⟭ HTTP/1.1" 403 - 0 58 12 ⟬ip_address#6⟭ "curl/8.4.0" "⟬uuid#11⟭" auth="-"
[⟬date#1⟭ 11:03:00.002] "GET /healthz HTTP/1.1" 200 - 0 2 0 ⟬ip_address#2⟭ "kube-probe/1.28" "⟬uuid#12⟭" auth="-"
[⟬date#1⟭ 11:03:02.226] "POST /v2/seat/change HTTP/1.1" 200 - 141 310 91 ⟬ip_address#3⟭ "Mozilla/5.0 (iPhone; CPU iPhone OS 17_3 like Mac OS X)" "⟬uuid#13⟭" auth="Bearer ⟬jwt#2⟭"
[⟬date#1⟭ 11:03:06.871] "GET /v2/notify/prefs?email=⟬email#6⟭&unsub=⟬opaque_token#4⟭ HTTP/1.1" 200 - 0 208 18 ⟬ip_address#7⟭ "Mozilla/5.0 (Linux; Android 14) Chrome/120.0" "⟬uuid#14⟭" auth="-"
[⟬date#1⟭ 11:03:09.502] "GET /v2/lounge/⟬trap:word_name|Sydney⟭/access HTTP/1.1" 200 - 0 88 14 ⟬ip_address#3⟭ "Mozilla/5.0 (iPhone; CPU iPhone OS 17_3 like Mac OS X)" "⟬uuid#15⟭" auth="Bearer ⟬jwt#2⟭"
[⟬date#1⟭ 11:03:12.114] "GET /v2/admin/manifest/UA441 HTTP/1.1" 401 - 0 44 3 ⟬ip_address#8⟭ "python-requests/2.31.0" "⟬uuid#16⟭" auth="Basic ⟬opaque_token#5⟭"
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: en
fill_locale: en_US
domain: fintech
appearance: GitLab job log, shell trace, curl command, connection string, pytest failure with fixture
scenario: GitLab job of an ACH ledger with set -x enabled, leaking a database URL, a service JWT and a Redis password, then a failing test printing a customer fixture
⟬text⟭
Running with gitlab-runner ⟬version#1⟭ (⟬git_sha#1⟭)
  on ⟬hostname#1⟭
Preparing the "docker" executor
Using docker image python:3.11-slim ...
Getting source from Git repository
Checking out ⟬git_sha#2⟭ as detached HEAD (ref is ledger-ach-returns)...
Executing "step_script" stage of the job script
$ set -x
+ export DATABASE_URL=postgres://ledger_ci:⟬url_password#1⟭@⟬hostname#2⟭:5432/ledger
+ export REDIS_AUTH=⟬password#1⟭
+ curl -sS -H "Authorization: Bearer ⟬jwt#1⟭" -X POST ⟬url#1⟭
{"tenant":"ci","ttl":600,"schema":"ledger_ci_114"}
+ curl -sS -H "X-Client-Ref: ⟬opaque_token#1⟭" ⟬url#2⟭
{"sandbox":"ready"}
+ pytest tests/ach -q
...........F..........
================================== FAILURES ===================================
__________________ test_returned_debit_reverses_ledger_entry __________________
    def test_returned_debit_reverses_ledger_entry(customer_fixture):
>       assert ledger.balance(customer_fixture.id) == Decimal("0.00")
E       AssertionError: assert Decimal('18.40') == Decimal('0.00')
E        +  where customer_fixture = Customer(id="⟬customer_id#3⟭", name="⟬person_name#3⟭", ssn="⟬us_ssn#3⟭", address="⟬postal_address#3⟭")

tests/ach/test_returns.py:88: AssertionError
1 failed, 21 passed in 6.02s
ERROR: Job failed: exit code 1
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: en
fill_locale: en_US
domain: SaaS
appearance: pipe-separated log, audit trail, plain sentences, impersonation token, temporary password
scenario: admin audit of a CRM product across one day, mixing support staff and bots, where a temporary password and an impersonation token are copied into the detail column
⟬text⟭
seq|time|actor|action|target|detail
004811|⟬date#1⟭ 08:12:44|⟬email#1⟭|login.success|console|mfa=totp ip=⟬ip_address#1⟭
004812|⟬date#1⟭ 08:13:02|⟬email#1⟭|tenant.open|⟬customer_id#2⟭|ticket ⟬ticket_id#1⟭
004813|⟬date#1⟭ 08:15:19|⟬email#1⟭|user.reset_password|⟬email#3⟭|temporary password ⟬password#1⟭ sent by phone to "⟬person_name#3⟭"
004814|⟬date#1⟭ 08:15:21|⟬trap:email_lookalike|automation@scheduler⟭|mail.suppress|⟬email#3⟭|bounce list cleared
004815|⟬date#1⟭ 08:31:07|⟬trap:indicator_non_pii|svc-sso-sync⟭|group.sync|⟬customer_id#2⟭|added=2 removed=0
004816|⟬date#1⟭ 09:04:40|⟬email#4⟭|user.impersonate.start|⟬email#5⟭|session ⟬opaque_token#1⟭ reason="⟬ticket_id#2⟭"
004817|⟬date#1⟭ 09:11:58|⟬email#4⟭|user.impersonate.stop|⟬email#5⟭|duration 438s
004818|⟬date#1⟭ 10:02:13|⟬email#6⟭|export.create|⟬customer_id#7⟭|contacts.csv rows=18204 ⟬trap:indicator_non_pii|owner=data-team⟭
004819|⟬date#1⟭ 10:02:49|⟬trap:indicator_non_pii|svc-export⟭|export.sign|⟬customer_id#7⟭|sha ⟬hash#1⟭
004820|⟬date#1⟭ 11:27:30|⟬email#1⟭|billing.card.replace|⟬customer_id#2⟭|new card on file ⟬payment_card#2⟭ cvv ⟬card_security_code#2⟭ for owner "⟬person_name#2⟭"
004821|⟬date#1⟭ 11:27:31|⟬trap:indicator_non_pii|billing-bot⟭|invoice.regenerate|⟬invoice_number#1⟭|amount=1188.00
004822|⟬date#1⟭ 13:40:02|⟬trap:indicator_non_pii|svc-sso-sync⟭|group.sync|⟬customer_id#7⟭|added=0 removed=1
004823|⟬date#1⟭ 15:08:16|⟬email#4⟭|apikey.rotate|⟬customer_id#7⟭|key id ⟬hash#2⟭, new value ⟬opaque_token#2⟭
004824|⟬date#1⟭ 15:08:17|⟬trap:email_lookalike|automation@scheduler⟭|webhook.test|⟬customer_id#7⟭|target ⟬url#1⟭ status=200
004825|⟬date#1⟭ 17:59:03|⟬email#1⟭|logout|console|session length 35179s
⟬end⟭

⟬template⟭
family: logs
format: application log
language: en
fill_locale: en_US
domain: government
appearance: Python logging line, lookup result, quoted value, plate in a sentence, mailing address
scenario: nightly toll violation batch of a state transportation agency, matching plates to registered owners and printing notices with licenses and home addresses
⟬text⟭
⟬date#2⟭ 01:00:02,114 INFO  tolls.batch: nightly violation run ⟬uuid#1⟭ started
⟬date#2⟭ 01:00:02,120 INFO  tolls.batch: reading plaza feed ⟬file_path#1⟭
⟬date#2⟭ 01:00:02,388 DEBUG tolls.config: ⟬trap:indicator_non_pii|owner_lookup_timeout=2000⟭ grace_days=30 fee_cents=2500
⟬date#2⟭ 01:00:03,402 INFO  tolls.feed: 6120 transactions, 212 without transponder
⟬date#2⟭ 01:00:03,550 INFO  tolls.match: plate ⟬us_license_plate#2⟭ plaza ⟬trap:word_name|Madison⟭ lane 4 class 2 no transponder
⟬date#2⟭ 01:00:03,806 DEBUG tolls.dmv: lookup plate="⟬us_license_plate#2⟭" -> owner="⟬person_name#2⟭" dl="⟬us_driver_license#2⟭" addr="⟬postal_address#2⟭"
⟬date#2⟭ 01:00:03,811 INFO  tolls.notice: notice ⟬invoice_number#2⟭ queued, due ⟬date#1⟭
⟬date#2⟭ 01:00:04,117 INFO  tolls.match: plate ⟬us_license_plate#3⟭ plaza ⟬trap:word_name|Madison⟭ lane 2 class 2 no transponder
⟬date#2⟭ 01:00:04,398 DEBUG tolls.dmv: lookup plate="⟬us_license_plate#3⟭" -> owner="⟬company#3⟭" fleet=true addr="⟬postal_address#3⟭"
⟬date#2⟭ 01:00:04,402 INFO  tolls.notice: fleet notice ⟬invoice_number#3⟭ queued, due ⟬date#1⟭
⟬date#2⟭ 01:00:04,660 INFO  tolls.match: plate ⟬us_license_plate#4⟭ plaza ⟬trap:word_name|Florence⟭ lane 1 class 3 no transponder
⟬date#2⟭ 01:00:04,812 WARN  tolls.dmv: no registration for plate "⟬us_license_plate#4⟭", image ⟬uuid#2⟭ sent to manual read
⟬date#2⟭ 01:00:05,214 INFO  tolls.match: plate ⟬us_license_plate#5⟭ plaza ⟬trap:word_name|Austin⟭ lane 6 class 2 no transponder
⟬date#2⟭ 01:00:05,441 DEBUG tolls.dmv: lookup plate="⟬us_license_plate#5⟭" -> owner="⟬person_name#5⟭" dl="⟬us_driver_license#5⟭" addr="⟬postal_address#5⟭"
⟬date#2⟭ 01:00:05,443 WARN  tolls.notice: third unpaid notice for ⟬person_name#5⟭, registration hold requested, previous notice ⟬date#3⟭
⟬date#2⟭ 01:00:05,447 INFO  tolls.hold: hold ⟬ticket_id#1⟭ sent to registry, operator=⟬trap:indicator_non_pii|batch-tolls⟭
⟬date#2⟭ 01:00:06,003 INFO  tolls.batch: 50 transactions processed
⟬date#2⟭ 01:00:06,881 INFO  tolls.match: plate ⟬us_license_plate#6⟭ plaza ⟬trap:word_name|Florence⟭ lane 3 class 2 no transponder
⟬date#2⟭ 01:00:07,102 DEBUG tolls.dmv: lookup plate="⟬us_license_plate#6⟭" -> owner="⟬person_name#6f⟭" dl="⟬us_driver_license#6⟭" addr="⟬postal_address#6⟭"
⟬date#2⟭ 01:00:07,106 INFO  tolls.waiver: Mrs ⟬person_name#6f⟭ holds a disabled veteran waiver, notice skipped
⟬date#2⟭ 01:00:07,430 INFO  tolls.match: plate ⟬us_license_plate#7⟭ plaza ⟬trap:word_name|Austin⟭ lane 5 class 2 no transponder
⟬date#2⟭ 01:00:07,700 ERROR tolls.dmv: registry timeout after 2000 ms for plate "⟬us_license_plate#7⟭"
⟬date#2⟭ 01:00:09,704 INFO  tolls.dmv: retry 1 ok, owner="⟬person_name#7⟭" dl="⟬us_driver_license#7⟭" addr="⟬postal_address#7⟭"
⟬date#2⟭ 01:00:09,708 INFO  tolls.notice: notice ⟬invoice_number#7⟭ queued, due ⟬date#1⟭
⟬date#2⟭ 01:00:10,120 INFO  tolls.batch: 100 transactions processed
⟬date#2⟭ 01:00:12,300 INFO  tolls.batch: 150 transactions processed
⟬date#2⟭ 01:00:13,040 INFO  tolls.match: rental plate ⟬us_license_plate#8⟭, forwarding to ⟬trap:company_name|Hertz⟭ fleet desk
⟬date#2⟭ 01:00:13,044 DEBUG tolls.fleet: renter on file "⟬person_name#8⟭" license "⟬us_driver_license#8⟭"
⟬date#2⟭ 01:00:13,402 INFO  tolls.notice: notice ⟬invoice_number#8⟭ queued for fleet billing
⟬date#2⟭ 01:00:14,101 INFO  tolls.match: plate ⟬us_license_plate#17⟭ plaza ⟬trap:word_name|Savannah⟭ lane 7 class 5 no transponder
⟬date#2⟭ 01:00:14,377 DEBUG tolls.dmv: lookup plate="⟬us_license_plate#17⟭" -> owner="⟬company#17⟭" fleet=true addr="⟬postal_address#17⟭"
⟬date#2⟭ 01:00:14,381 INFO  tolls.notice: fleet notice ⟬invoice_number#17⟭ queued, due ⟬date#1⟭
⟬date#2⟭ 01:00:14,640 INFO  tolls.match: plate ⟬us_license_plate#18⟭ plaza ⟬trap:word_name|Savannah⟭ lane 7 class 2 no transponder
⟬date#2⟭ 01:00:14,902 DEBUG tolls.dmv: lookup plate="⟬us_license_plate#18⟭" -> owner="⟬person_name#18⟭" dl="⟬us_driver_license#18⟭" addr="⟬postal_address#18⟭"
⟬date#2⟭ 01:00:14,906 INFO  tolls.notice: notice ⟬invoice_number#18⟭ queued, due ⟬date#1⟭
⟬date#2⟭ 01:00:14,981 INFO  tolls.batch: 200 transactions processed
⟬date#2⟭ 01:00:15,330 INFO  tolls.batch: all 212 transactions processed in 13.2s
⟬date#2⟭ 01:00:15,335 INFO  tolls.print: rendering 6 notices with template ⟬version#1⟭
⟬date#2⟭ 01:00:16,120 DEBUG tolls.print: envelope 1 to="⟬person_name#2⟭" addr="⟬postal_address#2⟭"
⟬date#2⟭ 01:00:16,121 DEBUG tolls.print: envelope 2 to="⟬company#3⟭" addr="⟬postal_address#3⟭"
⟬date#2⟭ 01:00:16,122 DEBUG tolls.print: envelope 3 to="⟬person_name#5⟭" addr="⟬postal_address#5⟭"
⟬date#2⟭ 01:00:16,123 DEBUG tolls.print: envelope 4 to="⟬person_name#7⟭" addr="⟬postal_address#7⟭"
⟬date#2⟭ 01:00:16,124 DEBUG tolls.print: envelope 5 to="⟬company#17⟭" addr="⟬postal_address#17⟭"
⟬date#2⟭ 01:00:16,125 DEBUG tolls.print: envelope 6 to="⟬person_name#18⟭" addr="⟬postal_address#18⟭"
⟬date#2⟭ 01:00:16,410 INFO  tolls.print: spool file ⟬file_path#2⟭ ready for mail house
⟬date#2⟭ 01:00:16,902 INFO  tolls.sftp: uploading to ⟬hostname#1⟭ as ⟬trap:indicator_non_pii|user=tolls-print⟭
⟬date#2⟭ 01:00:18,114 INFO  tolls.sftp: upload complete, checksum ⟬hash#1⟭
⟬date#2⟭ 01:00:18,120 INFO  tolls.payments: importing yesterday's web payments
⟬date#2⟭ 01:00:18,644 INFO  tolls.payments: notice ⟬invoice_number#9⟭ paid online, plate ⟬us_license_plate#9⟭
⟬date#2⟭ 01:00:18,902 INFO  tolls.payments: notice ⟬invoice_number#10⟭ paid online, plate ⟬us_license_plate#10⟭
⟬date#2⟭ 01:00:19,214 WARN  tolls.payments: charge dispute on notice ⟬invoice_number#11⟭, "⟬person_name#11⟭" says the plate ⟬us_license_plate#11⟭ was stolen on ⟬date#3⟭
⟬date#2⟭ 01:00:19,216 INFO  tolls.payments: dispute ⟬ticket_id#2⟭ assigned owner=⟬trap:indicator_non_pii|hearing-office⟭
⟬date#2⟭ 01:00:19,880 INFO  tolls.payments: 41 payments imported
⟬date#2⟭ 01:00:20,300 INFO  tolls.collections: 3 accounts past due more than 90 days
⟬date#2⟭ 01:00:20,512 DEBUG tolls.collections: referral "⟬person_name#12⟭", ssn on file ⟬us_ssn#12⟭, balance 412.50
⟬date#2⟭ 01:00:20,514 DEBUG tolls.collections: referral "⟬person_name#13⟭", ssn on file ⟬us_ssn#13⟭, balance 96.25
⟬date#2⟭ 01:00:20,516 DEBUG tolls.collections: referral "⟬company#14⟭", ein on file withheld, balance 1840.00
⟬date#2⟭ 01:00:20,900 INFO  tolls.collections: referral file ⟬file_path#3⟭ encrypted
⟬date#2⟭ 01:00:21,120 INFO  tolls.metrics: pushing to ⟬url#1⟭
⟬date#2⟭ 01:00:21,402 INFO  tolls.metrics: plates_read=6120 ocr_confidence_p50=0.97 manual_reads=9
⟬date#2⟭ 01:00:21,407 INFO  tolls.report: daily summary mailed to ⟬email:generic#15⟭
⟬date#2⟭ 01:00:21,410 INFO  tolls.report: phone tree updated, hearing office line ⟬phone#16⟭
⟬date#2⟭ 01:00:21,800 INFO  tolls.batch: cleaning temporary files
⟬date#2⟭ 01:00:22,004 INFO  tolls.batch: 212 matched, 6 notices, 1 hold, 1 dispute, 0 errors
⟬date#2⟭ 01:00:22,010 INFO  tolls.batch: run ⟬uuid#1⟭ finished in 19.9s
⟬date#2⟭ 01:00:22,011 INFO  tolls.batch: next run scheduled
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: en
fill_locale: en_US
domain: travel
appearance: Rails exception, ActiveRecord validation message, plate and license in a sentence
scenario: Rails exception at a car rental counter app, whose validation message names the renter, their expired license and the assigned plate
⟬text⟭
ActiveRecord::RecordInvalid (Validation failed: Renter ⟬person_name#1⟭ holds license ⟬us_driver_license#1⟭ which expired ⟬date#1⟭, vehicle ⟬us_license_plate#2⟭ not released):

app/models/rental_agreement.rb:74:in `ensure_valid_license!'
app/services/counter_checkout.rb:31:in `call'
app/controllers/counter/agreements_controller.rb:22:in `create'
actionpack (7.1.3) lib/action_controller/metal/basic_implicit_render.rb:6:in `send_action'
⟬end⟭

⟬template⟭
family: logs
format: test output
language: en
fill_locale: en_US
domain: fintech
appearance: go test verbose output, code identifier, eponym in a test name
scenario: go test run of a loan pricing package with one failing rounding case and only sandbox values
⟬text⟭
=== RUN   TestAmortizationSchedule
=== RUN   TestAmortizationSchedule/30y_fixed
=== RUN   TestAmortizationSchedule/15y_fixed
--- PASS: TestAmortizationSchedule (0.00s)
    --- PASS: TestAmortizationSchedule/30y_fixed (0.00s)
    --- PASS: TestAmortizationSchedule/15y_fixed (0.00s)
=== RUN   ⟬trap:code_identifier|TestBlackScholesCallPrice⟭
--- PASS: ⟬trap:code_identifier|TestBlackScholesCallPrice⟭ (0.01s)
=== RUN   ⟬trap:code_identifier|Test⦃Family⦄RoundingMode⟭
    pricing_test.go:142: rounding mode "half-even" got 18.41 want 18.40
    pricing_test.go:143: fixture ⟬trap:indicator_non_pii|customer=sandbox-001⟭ ⟬trap:indicator_non_pii|account=ACC_000000⟭
--- FAIL: ⟬trap:code_identifier|Test⦃Family⦄RoundingMode⟭ (0.00s)
=== RUN   ⟬trap:code_identifier|TestLuhnGuard⟭
--- PASS: ⟬trap:code_identifier|TestLuhnGuard⟭ (0.00s)
=== RUN   TestRateTable
    pricing_test.go:201: loaded rates from testdata/apr.csv, ⟬trap:indicator_non_pii|token_cache_ttl=0⟭
--- PASS: TestRateTable (0.02s)
FAIL
FAIL	lendcore/pricing	0.214s
FAIL
⟬end⟭

⟬template⟭
family: logs
format: access log
language: en
fill_locale: en_US
domain: SaaS
appearance: Caddy-like access line, uptime probe, query string
scenario: access lines of a SaaS public status page, hit only by uptime probes and an RSS reader
⟬text⟭
⟬ip_address#1⟭ - - [⟬date#1⟭ 04:10:01 +0000] "GET /status HTTP/2.0" 200 3120 "-" "UptimeProbe/2.1 (region=us-east)" ctx="-"
⟬ip_address#2⟭ - - [⟬date#1⟭ 04:10:02 +0000] "GET /status HTTP/2.0" 200 3120 "-" "UptimeProbe/2.1 (region=eu-west)" ctx="-"
⟬ip_address#3⟭ - - [⟬date#1⟭ 04:10:05 +0000] "GET /history.rss?⟬trap:indicator_non_pii|token_ttl=300⟭ HTTP/2.0" 200 8120 "-" "Feedly/1.0" ctx="region=us-east"
⟬ip_address#1⟭ - - [⟬date#1⟭ 04:11:01 +0000] "GET /status HTTP/2.0" 200 3120 "-" "UptimeProbe/2.1 (region=us-east)" ctx="-"
⟬ip_address#2⟭ - - [⟬date#1⟭ 04:11:02 +0000] "GET /status HTTP/2.0" 200 3120 "-" "UptimeProbe/2.1 (region=eu-west)" ctx="-"
⟬ip_address#4⟭ - - [⟬date#1⟭ 04:11:40 +0000] "GET /api/v1/components?⟬trap:indicator_non_pii|user_id=none⟭ HTTP/2.0" 200 940 "-" "curl/8.4.0" ctx="region=us-east"
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: en
fill_locale: en_US
domain: healthcare
appearance: Jenkins console, shell trace, docker login
scenario: Jenkins stage of an EHR vendor, whose docker login passes the registry password on the command line
⟬text⟭
Started by timer
Running as SYSTEM
[Pipeline] sh
+ docker login --username ⟬trap:indicator_non_pii|svc-ehr-ci⟭ --password ⟬password#1⟭ ⟬hostname#1⟭
WARNING! Using --password via the CLI is insecure. Use --password-stdin.
Login Succeeded
+ docker push ⟬hostname#1⟭/ehr/charting:⟬version#1⟭
[Pipeline] End of Pipeline
Finished: SUCCESS
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: en
fill_locale: en_US
domain: retail
appearance: key=value, audit trail, license scan, plate in a curbside event
scenario: point-of-sale audit trail of a home improvement store, with returns without receipt that scan a driver's license and curbside pickups that record plates
⟬text⟭
⟬date#1⟭ 10:02:11 STORE=0412 REG=03 EVT=SHIFT_OPEN cashier="⟬person_name#1⟭" drawer=118.00
⟬date#1⟭ 10:41:07 STORE=0412 REG=03 EVT=RETURN_NO_RECEIPT cashier="⟬person_name#1⟭" cust="⟬person_name#2⟭" dl="⟬us_driver_license#2⟭" amt=84.20
⟬date#1⟭ 10:41:30 STORE=0412 REG=03 EVT=MGR_OVERRIDE approver="⟬person_name#3⟭" reason=no-receipt amt=84.20
⟬date#1⟭ 10:41:52 STORE=0412 REG=03 EVT=STORE_CREDIT issued=84.20 acct=⟬customer_id#2⟭
⟬date#1⟭ 11:06:15 STORE=0412 REG=SELF2 EVT=AGE_CHECK operator=⟬trap:indicator_non_pii|kiosk-2⟭ result=pass item=spray-paint
⟬date#1⟭ 11:20:44 STORE=0412 REG=CURB EVT=CURBSIDE_ARRIVED order=⟬order_number#1⟭ vehicle="⟬us_license_plate#4⟭" bay=6
⟬date#1⟭ 11:27:03 STORE=0412 REG=CURB EVT=CURBSIDE_DONE order=⟬order_number#1⟭ associate="⟬person_name#5⟭"
⟬date#1⟭ 12:05:39 STORE=0412 REG=03 EVT=RETURN_NO_RECEIPT cashier="⟬person_name#1⟭" cust="⟬person_name#6⟭" dl="⟬us_driver_license#6⟭" amt=212.75
⟬date#1⟭ 12:06:01 STORE=0412 REG=03 EVT=FRAUD_FLAG reason=velocity returns_30d=5 operator=⟬trap:indicator_non_pii|rules-engine⟭
⟬date#1⟭ 12:06:48 STORE=0412 REG=03 EVT=MGR_OVERRIDE approver="⟬person_name#3⟭" reason=declined-refund amt=0.00
⟬date#1⟭ 13:30:12 STORE=0412 REG=CURB EVT=CURBSIDE_ARRIVED order=⟬order_number#2⟭ vehicle="⟬us_license_plate#7⟭" bay=2
⟬date#1⟭ 13:33:26 STORE=0412 REG=CURB EVT=CURBSIDE_DONE order=⟬order_number#2⟭ associate=⟬trap:indicator_non_pii|contractor-desk⟭
⟬date#1⟭ 14:15:00 STORE=0412 REG=SRV EVT=PRICE_FILE_LOAD file=⟬file_path#1⟭ operator=⟬trap:indicator_non_pii|hq-sync⟭ rows=44120
⟬date#1⟭ 15:48:21 STORE=0412 REG=06 EVT=VOID_LINE cashier="⟬person_name#8⟭" sku=204417 amt=31.99
⟬date#1⟭ 16:01:37 STORE=0412 REG=06 EVT=PRO_ACCOUNT acct=⟬customer_id#9⟭ company="⟬company#9⟭" jobsite="⟬postal_address#9⟭"
⟬date#1⟭ 18:00:04 STORE=0412 REG=03 EVT=SHIFT_CLOSE cashier="⟬person_name#1⟭" drawer=1402.15 variance=-0.25
⟬end⟭

⟬template⟭
family: logs
format: application log
language: en
fill_locale: en_US
domain: SaaS
appearance: syslog line, retry context, password alone on a line
scenario: mail relay of a newsletter product failing SMTP authentication, then dumping its retry context with the password alone on a line
⟬text⟭
⟬date#1⟭ 23:10:44 notify-1 mailer[2211]: smtp auth failed host=⟬hostname#1⟭ port=587 user=⟬email:generic#2⟭ code=535
⟬date#1⟭ 23:10:44 notify-1 mailer[2211]: dumping retry context
⟬email:generic#2⟭
⟬password#1⟭
⟬date#1⟭ 23:10:44 notify-1 mailer[2211]: end of context, attempt 3 of 5, next in 60s
⟬date#1⟭ 23:11:44 notify-1 mailer[2211]: smtp auth failed host=⟬hostname#1⟭ port=587 user=⟬email:generic#2⟭ code=535
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: en
fill_locale: en_US
domain: healthcare
appearance: .NET exception, exception message, inner exception, X12 segment
scenario: ASP.NET error of a clinic's eligibility check, where the payer rejection quotes the member's SSN, birth date and the X12 subscriber segments
⟬text⟭
fail: Microsoft.AspNetCore.Diagnostics.ExceptionHandlerMiddleware[1]
      An unhandled exception has occurred while executing the request.
      Halcyon.Eligibility.PayerRejectedException: 271 rejected for Ms ⟬person_name#1f⟭, SSN ⟬us_ssn#1⟭, DOB ⟬birth_date#1⟭, plan ⟬customer_id#1⟭, service date ⟬date#1⟭
       ---> Halcyon.Eligibility.X12.SegmentException: AAA*N**72*C segment at position 14
         at Halcyon.Eligibility.X12.ResponseParser.ThrowOnReject(Segment segment) in /src/Eligibility/X12/ResponseParser.cs:line 212
         at Halcyon.Eligibility.X12.ResponseParser.Parse(String payload) in /src/Eligibility/X12/ResponseParser.cs:line 96
         --- End of inner exception stack trace ---
         at Halcyon.Eligibility.PayerClient.CheckAsync(EligibilityRequest request) in /src/Eligibility/PayerClient.cs:line 133
         at Halcyon.Web.Controllers.CoverageController.Verify(CoverageForm form) in /src/Web/Controllers/CoverageController.cs:line 48
         at Microsoft.AspNetCore.Mvc.Infrastructure.ActionMethodExecutor.TaskOfIActionResultExecutor.Execute(ActionContext actionContext)
      Payload excerpt:
      NM1*IL*1*⟬person_name:family#1f⟭*⟬person_name:given#1f⟭****MI*⟬customer_id#1⟭~
      N3*⟬postal_address:street#1⟭~
      N4*⟬city#1⟭*⟬postcode#1⟭~
      DMG*D8*⟬birth_date#1⟭*F~
      Provider of record: ⟬person_name#2⟭, callback ⟬phone#2⟭
⟬end⟭
