⟬template⟭
family: logs
format: CI log
language: en
fill_locale: en_US
domain: government
appearance: Drone pipeline, Ansible verbose output, JSON task result, shell trace, connection string
scenario: Drone pipeline of a state tax e-filing service running Ansible with -vv, whose task results show the database password and a smoke test filer with SSN and address
⟬text⟭
[clone:1] + git init
[clone:2] Initialized empty Git repository in /drone/src/.git/
[clone:3] + git fetch origin +refs/heads/release:
[clone:4] + git checkout ⟬git_sha#1⟭ -b release
[deploy:1] + pip install --quiet ansible==9.2.0
[deploy:2] + ansible-playbook -i inventories/staging site.yml -vv
[deploy:3] ansible-playbook [core 2.16.3]
[deploy:4]   config file = /drone/src/ansible.cfg
[deploy:5]   python version = 3.11.7
[deploy:6] Using /drone/src/ansible.cfg as config file
[deploy:7]
[deploy:8] PLAY [efile application tier] ***************************************************
[deploy:9]
[deploy:10] TASK [Gathering Facts] *********************************************************
[deploy:11] ok: [efile-app-1]
[deploy:12] ok: [efile-app-2]
[deploy:13]
[deploy:14] TASK [common : install packages] ***********************************************
[deploy:15] ok: [efile-app-1] => {"changed": false, "msg": "all packages already installed"}
[deploy:16] ok: [efile-app-2] => {"changed": false, "msg": "all packages already installed"}
[deploy:17]
[deploy:18] TASK [common : create service account] *****************************************
[deploy:19] ok: [efile-app-1] => {"append": false, "changed": false, "comment": "efile service", "group": 991, "home": "/opt/efile", "name": "⟬trap:indicator_non_pii|efile⟭", "shell": "/sbin/nologin", "uid": 991}
[deploy:20] ok: [efile-app-2] => {"append": false, "changed": false, "comment": "efile service", "group": 991, "home": "/opt/efile", "name": "⟬trap:indicator_non_pii|efile⟭", "shell": "/sbin/nologin", "uid": 991}
[deploy:21]
[deploy:22] TASK [app : render settings] ***************************************************
[deploy:23] changed: [efile-app-1] => {"changed": true, "checksum": "⟬hash#1⟭", "dest": "/opt/efile/settings.ini", "mode": "0640", "owner": "⟬trap:indicator_non_pii|efile⟭", "size": 812}
[deploy:24] changed: [efile-app-2] => {"changed": true, "checksum": "⟬hash#1⟭", "dest": "/opt/efile/settings.ini", "mode": "0640", "owner": "⟬trap:indicator_non_pii|efile⟭", "size": 812}
[deploy:25]
[deploy:26] TASK [app : debug database settings] *******************************************
[deploy:27] ok: [efile-app-1] => {
[deploy:28]     "db": {
[deploy:29]         "host": "⟬hostname#1⟭",
[deploy:30]         "name": "efile",
[deploy:31]         "user": "⟬trap:indicator_non_pii|efile_app⟭",
[deploy:32]         "password": "⟬password#1⟭"
[deploy:33]     }
[deploy:34] }
[deploy:35]
[deploy:36] TASK [app : run migrations] ****************************************************
[deploy:37] changed: [efile-app-1] => {"changed": true, "cmd": ["/opt/efile/bin/migrate", "--dsn", "postgresql://efile_app:⟬url_password#1⟭@⟬hostname#1⟭/efile"], "rc": 0, "stdout": "applied 3 migrations"}
[deploy:38]
[deploy:39] TASK [app : restart workers] ***************************************************
[deploy:40] changed: [efile-app-1] => {"changed": true, "name": "efile-worker", "state": "restarted"}
[deploy:41] changed: [efile-app-2] => {"changed": true, "name": "efile-worker", "state": "restarted"}
[deploy:42]
[deploy:43] PLAY [smoke tests] *************************************************************
[deploy:44]
[deploy:45] TASK [submit a test return] ****************************************************
[deploy:46] ok: [localhost] => {"changed": false, "json": {"accepted": true, "receipt": "⟬uuid#1⟭"}, "request": {"filer": "⟬person_name#2⟭", "ssn": "⟬us_ssn#2⟭", "address": "⟬postal_address#2⟭", "dob": "⟬birth_date#2⟭", "state_id": "⟬us_driver_license#2⟭", "refund_method": "paper-check"}, "status": 200}
[deploy:47]
[deploy:48] TASK [fetch the return status] *************************************************
[deploy:49] ok: [localhost] => {"changed": false, "json": {"state": "RECEIVED", "filed": "⟬date#1⟭"}, "status": 200}
[deploy:50]
[deploy:51] TASK [notify release channel] **************************************************
[deploy:52] ok: [localhost] => {"changed": false, "msg": "posted to ⟬url#1⟭"}
[deploy:53]
[deploy:54] PLAY RECAP *********************************************************************
[deploy:55] efile-app-1 : ok=7 changed=3 unreachable=0 failed=0 skipped=0 rescued=0 ignored=0
[deploy:56] efile-app-2 : ok=5 changed=2 unreachable=0 failed=0 skipped=0 rescued=0 ignored=0
[deploy:57] localhost   : ok=3 changed=0 unreachable=0 failed=0 skipped=0 rescued=0 ignored=0
[deploy:58]
[notify:1] + curl -s -X POST -d "state=success" -H "PRIVATE-TOKEN: ⟬opaque_token#1⟭" ⟬url#2⟭
[notify:2] {"id":4412,"state":"success"}
[cleanup:1] + rm -f /tmp/vault-pass
[cleanup:2] + rm -rf /drone/src/.ansible
[cleanup:3] removed 2 entries
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: en
fill_locale: en_US
domain: travel
appearance: multi-line audit record, YAML-like fields, quoted value, initials in a sign-off, valet plate
scenario: hotel property management audit, with multi-line records for check-ins, card authorizations for incidentals and valet tickets, signed off with staff initials
⟬text⟭
--- event 88121
when: ⟬date#1⟭ 15:02:11
who: ⟬person_name:handle#1⟭
what: CHECKIN folio ⟬invoice_number#1⟭ room 412
guest: "⟬person_name#2⟭" passport ⟬us_passport#2⟭
--- event 88122
when: ⟬date#1⟭ 15:02:40
who: ⟬person_name:handle#1⟭
what: CARD_AUTH folio ⟬invoice_number#1⟭ amount 250.00
detail: ⟬payment_card#2⟭ cvv ⟬card_security_code#2⟭
--- event 88123
when: ⟬date#1⟭ 15:06:09
who: ⟬trap:indicator_non_pii|valet-stand⟭
what: VALET_IN ticket 3307 room 412
detail: "⟬us_license_plate#2⟭" keys on hook 41
--- event 88124
when: ⟬date#1⟭ 16:44:52
who: ⟬trap:indicator_non_pii|pms-nightly⟭
what: RATE_SYNC source ⟬url#1⟭ rooms 218
--- event 88125
when: ⟬date#1⟭ 17:20:03
who: ⟬person_name:handle#3⟭
what: GUEST_UPDATE folio ⟬invoice_number#4⟭
note: "⟬person_name#4⟭ asked to send the invoice to ⟬company#4⟭ at ⟬email#4⟭"
sign-off: ⟬trap:initials|R.K.⟭
--- event 88126
when: ⟬date#1⟭ 22:58:17
who: ⟬person_name:handle#3⟭
what: LATE_CHECKOUT folio ⟬invoice_number#1⟭ granted until 14:00
sign-off: ⟬trap:initials|MT⟭
⟬end⟭

⟬template⟭
family: logs
format: application log
language: en
fill_locale: en_US
domain: healthcare
appearance: pino JSON log, nested JSON, room token, street address in a JSON field
scenario: pino log of a telehealth platform at session start, where the video room token, the patient's home address for emergencies and a pharmacy order are serialized
⟬text⟭
{"level":30,"time":"⟬date#1⟭ 14:22:10","pid":412,"hostname":"⟬hostname#1⟭","reqId":"⟬uuid#1⟭","msg":"visit join requested"}
{"level":20,"time":"⟬date#1⟭ 14:22:10","pid":412,"reqId":"⟬uuid#1⟭","patient":{"name":"⟬person_name#2⟭","mrn":"⟬customer_id#2⟭","dob":"⟬birth_date#2⟭"},"msg":"loaded chart header"}
{"level":20,"time":"⟬date#1⟭ 14:22:10","pid":412,"reqId":"⟬uuid#1⟭","emergencyLocation":"⟬postal_address#2⟭","msg":"emergency location confirmed"}
{"level":30,"time":"⟬date#1⟭ 14:22:11","pid":412,"reqId":"⟬uuid#1⟭","room":{"id":"⟬uuid#2⟭","sig":"⟬opaque_token#1⟭"},"msg":"video room created"}
{"level":30,"time":"⟬date#1⟭ 14:22:11","pid":412,"reqId":"⟬uuid#1⟭","authorization":"Bearer ⟬jwt#1⟭","msg":"forwarding to media service"}
{"level":30,"time":"⟬date#1⟭ 14:22:43","pid":412,"reqId":"⟬uuid#3⟭","clinician":"⟬person_name#3⟭","msg":"clinician joined"}
{"level":40,"time":"⟬date#1⟭ 14:23:05","pid":412,"reqId":"⟬uuid#3⟭","jitterMs":118,"msg":"poor network for participant"}
{"level":30,"time":"⟬date#1⟭ 14:41:37","pid":412,"reqId":"⟬uuid#4⟭","msg":"visit ended","durationS":1126}
{"level":30,"time":"⟬date#1⟭ 14:41:38","pid":412,"reqId":"⟬uuid#4⟭","order":{"rx":"⟬order_number#1⟭","pharmacy":"⟬trap:company_name|Walgreens⟭ ⟬postal_address#4⟭"},"msg":"e-prescription queued"}
{"level":30,"time":"⟬date#1⟭ 14:41:39","pid":412,"reqId":"⟬uuid#4⟭","owner":"⟬trap:indicator_non_pii|pharmacy-bridge⟭","msg":"routed to pharmacy bridge"}
{"level":20,"time":"⟬date#1⟭ 14:41:39","pid":412,"reqId":"⟬uuid#4⟭","ref":"⟬order_number#1⟭","msg":"ack from bridge"}
{"level":50,"time":"⟬date#1⟭ 14:41:52","pid":412,"reqId":"⟬uuid#5⟭","err":{"type":"TimeoutError","message":"sms to ⟬phone#2⟭ timed out after 5000ms"},"msg":"reminder failed"}
{"level":30,"time":"⟬date#1⟭ 14:41:53","pid":412,"reqId":"⟬uuid#5⟭","retry":1,"msg":"reminder requeued"}
{"level":30,"time":"⟬date#1⟭ 14:45:00","pid":412,"hostname":"⟬hostname#1⟭","msg":"room reaper removed 1 room"}
{"level":30,"time":"⟬date#1⟭ 14:50:00","pid":412,"hostname":"⟬hostname#1⟭","active":0,"msg":"session gauge"}
{"level":30,"time":"⟬date#1⟭ 14:55:00","pid":412,"hostname":"⟬hostname#1⟭","active":0,"version":"⟬version#1⟭","msg":"session gauge"}
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: en
fill_locale: en_US
domain: retail
appearance: Go panic, struct dump, goroutine frames
scenario: Go panic of a furniture store's checkout, whose %+v dump of the cart prints the customer, card, security code and split shipping address
⟬text⟭
panic: checkout: no tax zone for cart &{ID:⟬uuid#1⟭ Customer:{Name:"⟬person_name#1⟭" Email:⟬email#1⟭} Card:{PAN:"⟬payment_card#1⟭" CVC:⟬card_security_code#1⟭} Ship:{Line1:"⟬postal_address:street#1⟭" City:"⟬city#1⟭" Zip:⟬postcode#1⟭} Total:1299.00}

goroutine 81 [running]:
main.(*Checkout).taxZone(...)
	/build/internal/checkout/tax.go:58 +0x2e4
main.(*Checkout).Submit(...)
	/build/internal/checkout/checkout.go:141 +0x1a8
main.submitHandler({...}, ...)
	/build/cmd/storefront/handlers.go:212 +0x3cc
net/http.HandlerFunc.ServeHTTP(...)
	/usr/local/go/src/net/http/server.go:2166 +0x38
main.authMiddleware.func1({...}, ...)
	/build/cmd/storefront/middleware.go:47 +0x1f0
net/http.HandlerFunc.ServeHTTP(...)
	/usr/local/go/src/net/http/server.go:2166 +0x38
net/http.serverHandler.ServeHTTP({...}, {...}, ...)
	/usr/local/go/src/net/http/server.go:3137 +0x8c
net/http.(*conn).serve(...)
	/usr/local/go/src/net/http/server.go:2039 +0x5a8
created by net/http.(*Server).Serve in goroutine 1
	/usr/local/go/src/net/http/server.go:3285 +0x4b4
exit status 2
⟬end⟭

⟬template⟭
family: logs
format: test output
language: en
fill_locale: en_US
domain: government
appearance: Cucumber output, stand-in values, scenario outline
scenario: Cucumber run of a county permit fee calculator, whose scenario outlines use stand-ins for applicants and contain no real data
⟬text⟭
Feature: Building permit fees

  Scenario Outline: Residential fee by floor area
    Given an applicant named ⟬trap:indicator_non_pii|"<NAME>"⟭ with parcel ⟬trap:indicator_non_pii|"<PARCEL_OWNER>"⟭
    When they request a permit for 1800 square feet
    Then the fee is 412.50

  Scenario: Discount for a historic district
    Given a parcel in the ⟬trap:word_name|Savannah⟭ historic district
    And ⟬trap:indicator_non_pii|owner = "TEST_OWNER"⟭
    When the reviewer applies the waiver
    Then the fee is 0.00
      expected: 0.00
           got: 41.25 (RuntimeError)
      ./features/step_definitions/fees.rb:31:in `/^the fee is (.*)$/'
      features/fees.feature:14:in `Then the fee is 0.00'

  Scenario: Contractor license is optional for owners
    Given ⟬trap:indicator_non_pii|contractor_license: none⟭
    When they request a permit for 120 square feet
    Then the fee is 35.00

Failing Scenarios:
cucumber features/fees.feature:9

3 scenarios (1 failed, 2 passed)
12 steps (1 failed, 11 passed)
0m0.214s
⟬end⟭

⟬template⟭
family: logs
format: access log
language: en
fill_locale: en_US
domain: travel
appearance: JSON access log, request body field, passport in a path, token in a query string
scenario: edge JSON access of a hotel booking engine, where a body capture rule logs cards and guest forms, and confirmation links carry tokens
⟬text⟭
{"ClientIP":"⟬ip_address#1⟭","Method":"GET","URI":"/search?city=⟬trap:word_name|Charlotte⟭&nights=2","Status":200,"Start":"⟬date#1⟭ 19:04:11","UA":"Mozilla/5.0 (iPhone; CPU iPhone OS 17_3 like Mac OS X)","Body":""}
{"ClientIP":"⟬ip_address#1⟭","Method":"POST","URI":"/book/guest","Status":200,"Start":"⟬date#1⟭ 19:05:02","UA":"Mozilla/5.0 (iPhone; CPU iPhone OS 17_3 like Mac OS X)","Body":"name=⟬person_name#2⟭&email=⟬email#2⟭&phone=⟬phone#2⟭"}
{"ClientIP":"⟬ip_address#1⟭","Method":"POST","URI":"/book/pay","Status":402,"Start":"⟬date#1⟭ 19:05:40","UA":"Mozilla/5.0 (iPhone; CPU iPhone OS 17_3 like Mac OS X)","Body":"pan=⟬payment_card#2⟭&cvc=⟬card_security_code#2⟭"}
{"ClientIP":"⟬ip_address#1⟭","Method":"POST","URI":"/book/pay","Status":200,"Start":"⟬date#1⟭ 19:06:12","UA":"Mozilla/5.0 (iPhone; CPU iPhone OS 17_3 like Mac OS X)","Body":"pan=⟬payment_card#3⟭&cvc=⟬card_security_code#3⟭"}
{"ClientIP":"⟬ip_address#1⟭","Method":"GET","URI":"/confirmation?conf=⟬uuid#1⟭&token=⟬opaque_token#1⟭","Status":200,"Start":"⟬date#1⟭ 19:06:13","UA":"Mozilla/5.0 (iPhone; CPU iPhone OS 17_3 like Mac OS X)","Body":""}
{"ClientIP":"⟬ip_address#2⟭","Method":"GET","URI":"/healthz","Status":200,"Start":"⟬date#1⟭ 19:06:30","UA":"kube-probe/1.29","Body":""}
{"ClientIP":"⟬ip_address#3⟭","Method":"PUT","URI":"/v1/guests/⟬us_passport#4⟭/visa-info","Status":204,"Start":"⟬date#1⟭ 19:07:01","UA":"okhttp/4.12.0","Body":"nationality=US"}
{"ClientIP":"⟬ip_address#3⟭","Method":"GET","URI":"/v1/guests/⟬us_passport#4⟭","Status":200,"Start":"⟬date#1⟭ 19:07:02","UA":"okhttp/4.12.0","Body":""}
{"ClientIP":"⟬ip_address#4⟭","Method":"GET","URI":"/manage?ref=⟬opaque_token#2⟭","Status":200,"Start":"⟬date#1⟭ 19:07:45","UA":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/121.0","Body":""}
{"ClientIP":"⟬ip_address#5⟭","Method":"GET","URI":"/manage?ref=⟬order_number#1⟭","Status":404,"Start":"⟬date#1⟭ 19:07:58","UA":"curl/8.4.0","Body":""}
{"ClientIP":"⟬ip_address#6⟭","Method":"POST","URI":"/partner/rates","Status":401,"Start":"⟬date#1⟭ 19:08:21","UA":"python-requests/2.31.0","Body":"username=⟬trap:indicator_non_pii|channel-mgr⟭&password=⟬password#1⟭"}
{"ClientIP":"⟬ip_address#7⟭","Method":"GET","URI":"/account?session=⟬jwt#1⟭","Status":200,"Start":"⟬date#1⟭ 19:09:02","UA":"Mozilla/5.0 (Macintosh; Intel Mac OS X 14_2) Safari/605.1.15","Body":""}
{"ClientIP":"⟬ip_address#7⟭","Method":"POST","URI":"/account/address","Status":200,"Start":"⟬date#1⟭ 19:09:44","UA":"Mozilla/5.0 (Macintosh; Intel Mac OS X 14_2) Safari/605.1.15","Body":"billing=⟬postal_address#7⟭"}
{"ClientIP":"⟬ip_address#8⟭","Method":"GET","URI":"/hotels/⟬trap:word_name|Sydney-harbour⟭/rooms","Status":200,"Start":"⟬date#1⟭ 19:10:12","UA":"Mozilla/5.0 (compatible; Googlebot/2.1)","Body":""}
{"ClientIP":"⟬ip_address#9⟭","Method":"POST","URI":"/loyalty/link","Status":200,"Start":"⟬date#1⟭ 19:10:37","UA":"Mozilla/5.0 (Linux; Android 14) Chrome/120.0","Body":"member=⟬customer_id#9⟭&code=⟬opaque_token#3⟭"}
{"ClientIP":"⟬ip_address#10⟭","Method":"GET","URI":"/wp-login.php","Status":404,"Start":"⟬date#1⟭ 19:11:05","UA":"python-requests/2.28.1","Body":""}
{"ClientIP":"⟬ip_address#2⟭","Method":"GET","URI":"/healthz","Status":200,"Start":"⟬date#1⟭ 19:11:30","UA":"kube-probe/1.29","Body":""}
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: en
fill_locale: en_US
domain: fintech
appearance: CircleCI step output, environment dump, printenv, value without a key
scenario: CircleCI debug step of a lending API that runs env and spreads tokens, a database password and a JWT across the log, next to harmless system variables
⟬text⟭
#!/bin/bash --login -eo pipefail
env | sort
CI=true
CIRCLECI=true
CIRCLE_BRANCH=main
CIRCLE_BUILD_NUM=4412
CIRCLE_JOB=integration
CIRCLE_PROJECT_REPONAME=lending-api
CIRCLE_SHA1=⟬git_sha#1⟭
CIRCLE_USERNAME=⟬person_name:handle#1⟭
CREDIT_BUREAU_KEY=⟬opaque_token#1⟭
DB_HOST=⟬hostname#1⟭
DB_PASSWORD=⟬password#1⟭
DB_USER=⟬trap:indicator_non_pii|lending_ci⟭
HOME=/home/circleci
LANG=C.UTF-8
LENDING_SERVICE_JWT=⟬jwt#1⟭
PATH=/home/circleci/.local/bin:/usr/local/bin:/usr/bin:/bin
PWD=⟬trap:indicator_non_pii|/home/circleci/project⟭
SESSION_SIGNING_REF=⟬opaque_token#2⟭
SHLVL=1
TEST_EMAIL_DOMAIN=⟬trap:indicator_non_pii|sandbox.invalid⟭
USER=⟬trap:indicator_non_pii|circleci⟭
_=/usr/bin/env
CircleCI received exit code 0
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: en
fill_locale: en_US
domain: SaaS
appearance: JSON lines, identity provider events, nested JSON, display name
scenario: identity provider events of a B2B workspace, as JSON, with employees signing in and system principals doing the rest, the same display name field on both sides
⟬text⟭
{"published":"⟬date#1⟭ 08:01:12","eventType":"user.session.start","actor":{"type":"User","alternateId":"⟬email#1⟭","displayName":"⟬person_name#1⟭"},"client":{"ip":"⟬ip_address#1⟭"},"outcome":"SUCCESS"}
{"published":"⟬date#1⟭ 08:01:13","eventType":"user.authentication.sso","actor":{"type":"User","alternateId":"⟬email#1⟭","displayName":"⟬person_name#1⟭"},"target":[{"type":"AppInstance","displayName":"⟬trap:indicator_non_pii|Billing Console⟭"}],"outcome":"SUCCESS"}
{"published":"⟬date#1⟭ 08:30:00","eventType":"system.import.start","actor":{"type":"SystemPrincipal","alternateId":"⟬trap:email_lookalike|system@idhub⟭","displayName":"⟬trap:indicator_non_pii|IdHub System⟭"},"outcome":"SUCCESS"}
{"published":"⟬date#1⟭ 08:30:44","eventType":"group.user_membership.add","actor":{"type":"SystemPrincipal","alternateId":"⟬trap:email_lookalike|system@idhub⟭","displayName":"⟬trap:indicator_non_pii|IdHub System⟭"},"target":[{"type":"User","alternateId":"⟬email#2⟭","displayName":"⟬person_name#2⟭"}],"outcome":"SUCCESS"}
{"published":"⟬date#1⟭ 09:12:27","eventType":"user.account.reset_password","actor":{"type":"User","alternateId":"⟬email#3⟭","displayName":"⟬person_name#3⟭"},"target":[{"type":"User","alternateId":"⟬email#4⟭","displayName":"⟬person_name#4⟭"}],"debugContext":{"temporaryPassword":"⟬password#1⟭"},"outcome":"SUCCESS"}
{"published":"⟬date#1⟭ 09:40:02","eventType":"app.oauth2.token.grant","actor":{"type":"Client","alternateId":"⟬uuid#1⟭","displayName":"⟬trap:indicator_non_pii|ci-deployer⟭"},"debugContext":{"access_token":"⟬jwt#1⟭","scope":"apps.read"},"outcome":"SUCCESS"}
{"published":"⟬date#1⟭ 10:05:51","eventType":"system.api_token.create","actor":{"type":"User","alternateId":"⟬email#3⟭","displayName":"⟬person_name#3⟭"},"debugContext":{"tokenId":"⟬hash#1⟭","value":"⟬opaque_token#1⟭"},"outcome":"SUCCESS"}
{"published":"⟬date#1⟭ 10:05:52","eventType":"system.api_token.label","actor":{"type":"User","alternateId":"⟬email#3⟭","displayName":"⟬person_name#3⟭"},"debugContext":{"tokenId":"⟬hash#1⟭","value":"⟬uuid#2⟭"},"outcome":"SUCCESS"}
{"published":"⟬date#1⟭ 11:18:36","eventType":"user.session.start","actor":{"type":"User","alternateId":"⟬email#5⟭","displayName":"⟬person_name#5⟭"},"client":{"ip":"⟬ip_address#2⟭"},"outcome":"FAILURE","reason":"INVALID_CREDENTIALS"}
{"published":"⟬date#1⟭ 11:18:49","eventType":"user.session.start","actor":{"type":"User","alternateId":"⟬email#5⟭","displayName":"⟬person_name#5⟭"},"client":{"ip":"⟬ip_address#2⟭"},"outcome":"SUCCESS"}
{"published":"⟬date#1⟭ 11:40:03","eventType":"policy.rule.update","actor":{"type":"User","alternateId":"⟬email#3⟭","displayName":"⟬person_name#3⟭"},"target":[{"type":"PolicyRule","displayName":"⟬trap:indicator_non_pii|password-min-length-14⟭"}],"outcome":"SUCCESS"}
{"published":"⟬date#1⟭ 12:00:00","eventType":"system.import.complete","actor":{"type":"SystemPrincipal","alternateId":"⟬trap:email_lookalike|system@idhub⟭","displayName":"⟬trap:indicator_non_pii|IdHub System⟭"},"outcome":"SUCCESS"}
{"published":"⟬date#1⟭ 14:26:11","eventType":"user.lifecycle.suspend","actor":{"type":"SystemPrincipal","alternateId":"⟬trap:email_lookalike|system@idhub⟭","displayName":"⟬trap:indicator_non_pii|IdHub System⟭"},"target":[{"type":"User","alternateId":"⟬email#6⟭","displayName":"⟬person_name#6⟭"}],"reason":"inactive for 90 days","outcome":"SUCCESS"}
{"published":"⟬date#1⟭ 16:02:50","eventType":"user.mfa.factor.enroll","actor":{"type":"User","alternateId":"⟬email#2⟭","displayName":"⟬person_name#2⟭"},"debugContext":{"phone":"⟬phone#2⟭"},"outcome":"SUCCESS"}
{"published":"⟬date#1⟭ 17:45:19","eventType":"user.session.end","actor":{"type":"User","alternateId":"⟬email#1⟭","displayName":"⟬person_name#1⟭"},"outcome":"SUCCESS"}
{"published":"⟬date#1⟭ 23:59:59","eventType":"system.log.rollover","actor":{"type":"SystemPrincipal","alternateId":"⟬trap:email_lookalike|system@idhub⟭","displayName":"⟬trap:indicator_non_pii|IdHub System⟭"},"debugContext":{"archive":"⟬url#1⟭"},"outcome":"SUCCESS"}
⟬end⟭

⟬template⟭
family: logs
format: application log
language: en
fill_locale: en_US
domain: government
appearance: Serilog line, destructured object, quoted value, identity check, plain sentence
scenario: Serilog output of a state unemployment claims system, whose identity check destructures the claimant with SSN, license, plate and address, and whose fraud rule quotes a witness
⟬text⟭
⟬date#1⟭ 14:22:05.112 -05:00 [INF] Claims.Api.ClaimController: Claim ⟬uuid#1⟭ submitted from ⟬ip_address#1⟭
⟬date#1⟭ 14:22:05.140 -05:00 [DBG] Claims.Identity.Verifier: Verifying { ClaimantName: "⟬person_name#2⟭", Ssn: "⟬us_ssn#2⟭", DateOfBirth: "⟬birth_date#2⟭", DriverLicense: "⟬us_driver_license#2⟭" }
⟬date#1⟭ 14:22:05.402 -05:00 [INF] Claims.Identity.Verifier: Wage record found for employer "⟬company#2⟭", last day ⟬date#2⟭
⟬date#1⟭ 14:22:05.615 -05:00 [INF] Claims.Identity.DmvBridge: License match score 0.99, vehicle "⟬us_license_plate#2⟭" on file
⟬date#1⟭ 14:22:05.900 -05:00 [DBG] Claims.Benefits.Calculator: Weekly benefit 412.00 for quarter wages 12840.17, ⟬trap:indicator_non_pii|owner=benefits-rules⟭
⟬date#1⟭ 14:22:06.012 -05:00 [INF] Claims.Payment.Setup: Debit card mailing to "⟬postal_address#2⟭"
⟬date#1⟭ 14:22:06.020 -05:00 [INF] Claims.Api.ClaimController: Claim ⟬uuid#1⟭ accepted
⟬date#1⟭ 14:40:51.300 -05:00 [INF] Claims.Api.ClaimController: Claim ⟬uuid#3⟭ submitted from ⟬ip_address#2⟭
⟬date#1⟭ 14:40:51.322 -05:00 [DBG] Claims.Identity.Verifier: Verifying { ClaimantName: "⟬person_name#3⟭", Ssn: "⟬us_ssn#3⟭", DateOfBirth: "⟬birth_date#3⟭", DriverLicense: "⟬us_driver_license#3⟭" }
⟬date#1⟭ 14:40:51.700 -05:00 [WRN] Claims.Fraud.Rules: Same IP as 11 other claims this week, rule=velocity
⟬date#1⟭ 14:40:51.702 -05:00 [WRN] Claims.Fraud.Rules: Employer report: "⟬person_name#4⟭ says ⟬person_name#3⟭ never worked at ⟬company#4⟭"
⟬date#1⟭ 14:40:51.711 -05:00 [INF] Claims.Fraud.CaseManager: Case ⟬ticket_id#1⟭ opened operator=⟬trap:indicator_non_pii|fraud-rules⟭
⟬date#1⟭ 14:40:52.000 -05:00 [INF] Claims.Notify.Mailer: Determination notice to "⟬postal_address#3⟭"
⟬date#1⟭ 15:00:00.003 -05:00 [INF] Claims.Jobs.Metrics: claims_open=1822 appeals_open=114 version=⟬version#1⟭
⟬date#1⟭ 15:00:00.210 -05:00 [INF] Claims.Jobs.Purge: Temp uploads older than 7 days removed, count=61
⟬date#1⟭ 15:12:44.118 -05:00 [ERR] Claims.Payment.Setup: Card vendor rejected batch ⟬order_number#1⟭, operator=⟬trap:indicator_non_pii|payment-batch⟭
⟬date#1⟭ 15:12:44.120 -05:00 [INF] Claims.Payment.Setup: Retry scheduled, ⟬ticket_id#2⟭
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: en
fill_locale: en_US
domain: travel
appearance: Python traceback, local variable dump, passport without a key
scenario: Python traceback of an airline's passenger data submission, with a chained exception and a repr of the passenger holding only a name and a passport number
⟬text⟭
Traceback (most recent call last):
  File "/srv/apis/submit.py", line 44, in submit_passenger
    payload = build_apis(passenger)
  File "/srv/apis/mapping.py", line 19, in build_apis
    return {"nat": passenger["nationality"], "doc": passenger["document"]}
KeyError: 'nationality'

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "/srv/apis/worker.py", line 71, in run
    submit_passenger(passenger)
apis.errors.SubmissionError: cannot map passenger ("⟬person_name#1⟭", "⟬us_passport#1⟭") on flight UA441
⟬end⟭

⟬template⟭
family: logs
format: test output
language: en
fill_locale: en_US
domain: fintech
appearance: Mocha output, assertion message, inline object
scenario: Mocha failure of a KYC mapper in a brokerage app, whose assertion prints the inline fixture with an SSN
⟬text⟭
  KycMapper
    ✓ trims whitespace
    ✓ upper-cases the state
    1) flags sanctioned applicants

  2 passing (18ms)
  1 failing

  1) KycMapper
       flags sanctioned applicants:
     AssertionError: expected { name: "⟬person_name#1⟭", ssn: "⟬us_ssn#1⟭", sanctioned: false } to have property "sanctioned" of true
      at Context.<anonymous> (test/kyc.mapper.spec.js:44:27)
⟬end⟭

⟬template⟭
family: logs
format: access log
language: en
fill_locale: en_US
domain: SaaS
appearance: combined log format, documentation paths, stand-in values in a query string, eponym in a slug
scenario: nginx access of a developer documentation site, full of paths and sample parameters about tokens, users and emails, without any real value
⟬text⟭
⟬ip_address#1⟭ - - [⟬date#1⟭ 10:00:02 +0000] "GET /docs/ HTTP/2.0" 200 18244 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/121.0" ctx="-"
⟬ip_address#1⟭ - - [⟬date#1⟭ 10:00:03 +0000] "GET /docs/assets/main.css HTTP/2.0" 200 40122 "⟬url#1⟭" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/121.0" ctx="-"
⟬ip_address#1⟭ - - [⟬date#1⟭ 10:00:03 +0000] "GET /docs/assets/search-index.json HTTP/2.0" 200 804120 "⟬url#1⟭" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/121.0" ctx="-"
⟬ip_address#1⟭ - - [⟬date#1⟭ 10:00:21 +0000] "GET /docs/api/authentication HTTP/2.0" 200 22104 "⟬url#1⟭" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/121.0" ctx="cache=hit"
⟬ip_address#2⟭ - - [⟬date#1⟭ 10:00:44 +0000] "GET /docs/search?q=rotate+api+key HTTP/2.0" 200 3120 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 14_2) Safari/605.1.15" ctx="-"
⟬ip_address#2⟭ - - [⟬date#1⟭ 10:00:51 +0000] "GET /docs/guides/rotating-keys HTTP/2.0" 200 14220 "⟬url#2⟭" "Mozilla/5.0 (Macintosh; Intel Mac OS X 14_2) Safari/605.1.15" ctx="-"
⟬ip_address#3⟭ - - [⟬date#1⟭ 10:01:02 +0000] "GET /docs/api/users?example=⟬trap:indicator_non_pii|user_id=USER_0001⟭ HTTP/2.0" 200 19004 "-" "Mozilla/5.0 (compatible; Googlebot/2.1)" ctx="-"
⟬ip_address#3⟭ - - [⟬date#1⟭ 10:01:03 +0000] "GET /docs/api/tokens?example=⟬trap:placeholder|<token>⟭ HTTP/2.0" 200 17220 "-" "Mozilla/5.0 (compatible; Googlebot/2.1)" ctx="cache=hit"
⟬ip_address#3⟭ - - [⟬date#1⟭ 10:01:05 +0000] "GET /docs/api/invites?email=⟬trap:indicator_non_pii|%3Cemail%3E⟭ HTTP/2.0" 200 12108 "-" "Mozilla/5.0 (compatible; Googlebot/2.1)" ctx="-"
⟬ip_address#4⟭ - - [⟬date#1⟭ 10:01:30 +0000] "GET /docs/sdks/python HTTP/2.0" 200 16400 "-" "Mozilla/5.0 (X11; Linux x86_64) Firefox/122.0" ctx="-"
⟬ip_address#4⟭ - - [⟬date#1⟭ 10:01:44 +0000] "GET /docs/sdks/node HTTP/2.0" 200 16120 "⟬url#3⟭" "Mozilla/5.0 (X11; Linux x86_64) Firefox/122.0" ctx="-"
⟬ip_address#4⟭ - - [⟬date#1⟭ 10:01:58 +0000] "GET /docs/sdks/node/⟬trap:email_lookalike|@helix/sdk⟭ HTTP/2.0" 200 9012 "⟬url#3⟭" "Mozilla/5.0 (X11; Linux x86_64) Firefox/122.0" ctx="cache=hit"
⟬ip_address#5⟭ - - [⟬date#1⟭ 10:02:06 +0000] "GET /blog/⟬trap:eponym|dijkstra-in-production⟭ HTTP/2.0" 200 28120 "⟬url#4⟭" "Mozilla/5.0 (iPhone; CPU iPhone OS 17_3 like Mac OS X)" ctx="-"
⟬ip_address#5⟭ - - [⟬date#1⟭ 10:02:17 +0000] "GET /blog/⟬trap:eponym|bloom-filters-for-rate-limits⟭ HTTP/2.0" 200 26200 "⟬url#5⟭" "Mozilla/5.0 (iPhone; CPU iPhone OS 17_3 like Mac OS X)" ctx="-"
⟬ip_address#6⟭ - - [⟬date#1⟭ 10:02:30 +0000] "GET /changelog/⟬version#1⟭ HTTP/2.0" 200 8120 "-" "Feedly/1.0" ctx="-"
⟬ip_address#6⟭ - - [⟬date#1⟭ 10:02:31 +0000] "GET /changelog.rss HTTP/2.0" 304 0 "-" "Feedly/1.0" ctx="cache=hit"
⟬ip_address#7⟭ - - [⟬date#1⟭ 10:02:49 +0000] "GET /docs/webhooks/signatures HTTP/2.0" 200 13204 "-" "curl/8.4.0" ctx="-"
⟬ip_address#8⟭ - - [⟬date#1⟭ 10:03:01 +0000] "GET /docs/config?key=⟬trap:indicator_non_pii|token_ttl⟭ HTTP/2.0" 200 7120 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Edge/121.0" ctx="-"
⟬ip_address#8⟭ - - [⟬date#1⟭ 10:03:12 +0000] "GET /docs/config?key=⟬trap:indicator_non_pii|password_min_length⟭ HTTP/2.0" 200 7120 "⟬url#6⟭" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Edge/121.0" ctx="-"
⟬ip_address#8⟭ - - [⟬date#1⟭ 10:03:27 +0000] "GET /docs/config?key=⟬trap:indicator_non_pii|owner_team⟭ HTTP/2.0" 200 7120 "⟬url#6⟭" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Edge/121.0" ctx="cache=hit"
⟬ip_address#9⟭ - - [⟬date#1⟭ 10:03:40 +0000] "GET /pricing HTTP/2.0" 200 9920 "⟬url#7⟭" "Mozilla/5.0 (Linux; Android 14) Chrome/120.0" ctx="-"
⟬ip_address#9⟭ - - [⟬date#1⟭ 10:03:58 +0000] "GET /docs/quickstart HTTP/2.0" 200 15400 "⟬url#7⟭" "Mozilla/5.0 (Linux; Android 14) Chrome/120.0" ctx="-"
⟬ip_address#10⟭ - - [⟬date#1⟭ 10:04:05 +0000] "GET /favicon.ico HTTP/2.0" 200 1150 "-" "Mozilla/5.0 (compatible; bingbot/2.0)" ctx="-"
⟬ip_address#10⟭ - - [⟬date#1⟭ 10:04:06 +0000] "GET /sitemap.xml HTTP/2.0" 200 40120 "-" "Mozilla/5.0 (compatible; bingbot/2.0)" ctx="cache=hit"
⟬ip_address#11⟭ - - [⟬date#1⟭ 10:04:20 +0000] "GET /docs/api/errors#E1042 HTTP/2.0" 200 11240 "⟬url#8⟭" "Mozilla/5.0 (Macintosh; Intel Mac OS X 13_6) Chrome/120.0" ctx="-"
⟬ip_address#11⟭ - - [⟬date#1⟭ 10:04:31 +0000] "GET /docs/api/errors HTTP/2.0" 200 11240 "⟬url#8⟭" "Mozilla/5.0 (Macintosh; Intel Mac OS X 13_6) Chrome/120.0" ctx="-"
⟬ip_address#12⟭ - - [⟬date#1⟭ 10:04:48 +0000] "GET /.well-known/security.txt HTTP/2.0" 200 240 "-" "python-requests/2.31.0" ctx="-"
⟬ip_address#13⟭ - - [⟬date#1⟭ 10:05:02 +0000] "GET /docs/sso/saml?idp=⟬trap:word_name|Virginia-state⟭ HTTP/2.0" 200 13020 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/121.0" ctx="cache=hit"
⟬ip_address#13⟭ - - [⟬date#1⟭ 10:05:19 +0000] "GET /docs/sso/scim HTTP/2.0" 200 12880 "⟬url#9⟭" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/121.0" ctx="-"
⟬ip_address#14⟭ - - [⟬date#1⟭ 10:05:33 +0000] "GET /docs/integrations/⟬trap:library|jenkins⟭ HTTP/2.0" 200 10440 "-" "Mozilla/5.0 (X11; Ubuntu; Linux x86_64) Firefox/121.0" ctx="-"
⟬ip_address#14⟭ - - [⟬date#1⟭ 10:05:47 +0000] "GET /docs/integrations/⟬trap:library|kafka⟭ HTTP/2.0" 200 9880 "⟬url#10⟭" "Mozilla/5.0 (X11; Ubuntu; Linux x86_64) Firefox/121.0" ctx="-"
⟬ip_address#14⟭ - - [⟬date#1⟭ 10:05:59 +0000] "GET /docs/integrations/⟬trap:library|cassandra⟭ HTTP/2.0" 200 9940 "⟬url#10⟭" "Mozilla/5.0 (X11; Ubuntu; Linux x86_64) Firefox/121.0" ctx="cache=hit"
⟬ip_address#15⟭ - - [⟬date#1⟭ 10:06:04 +0000] "HEAD /docs/ HTTP/1.1" 200 0 "-" "UptimeProbe/2.1" ctx="-"
⟬ip_address#16⟭ - - [⟬date#1⟭ 10:06:18 +0000] "GET /docs/limits HTTP/2.0" 200 6120 "-" "Mozilla/5.0 (iPad; CPU OS 17_2 like Mac OS X) Safari/604.1" ctx="-"
⟬ip_address#16⟭ - - [⟬date#1⟭ 10:06:31 +0000] "GET /docs/limits?plan=team HTTP/2.0" 200 6120 "⟬url#11⟭" "Mozilla/5.0 (iPad; CPU OS 17_2 like Mac OS X) Safari/604.1" ctx="-"
⟬ip_address#17⟭ - - [⟬date#1⟭ 10:06:45 +0000] "GET /docs/search?q=reset+password HTTP/2.0" 200 3240 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/121.0" ctx="cache=hit"
⟬ip_address#17⟭ - - [⟬date#1⟭ 10:06:52 +0000] "GET /docs/guides/password-policy HTTP/2.0" 200 8904 "⟬url#12⟭" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/121.0" ctx="-"
⟬ip_address#18⟭ - - [⟬date#1⟭ 10:07:03 +0000] "GET /docs/samples/curl?header=⟬trap:placeholder|Bearer%20YOUR_TOKEN⟭ HTTP/2.0" 200 5120 "-" "Mozilla/5.0 (Linux; Android 13) Chrome/119.0" ctx="-"
⟬ip_address#18⟭ - - [⟬date#1⟭ 10:07:15 +0000] "GET /docs/samples/python?api_key=⟬trap:placeholder|xxxx⟭ HTTP/2.0" 200 5240 "⟬url#13⟭" "Mozilla/5.0 (Linux; Android 13) Chrome/119.0" ctx="-"
⟬ip_address#19⟭ - - [⟬date#1⟭ 10:07:28 +0000] "GET /wp-login.php HTTP/2.0" 404 162 "-" "python-requests/2.28.1" ctx="cache=hit"
⟬ip_address#19⟭ - - [⟬date#1⟭ 10:07:28 +0000] "GET /.env HTTP/2.0" 404 162 "-" "python-requests/2.28.1" ctx="-"
⟬ip_address#19⟭ - - [⟬date#1⟭ 10:07:29 +0000] "GET /config.json HTTP/2.0" 404 162 "-" "python-requests/2.28.1" ctx="-"
⟬ip_address#20⟭ - - [⟬date#1⟭ 10:07:44 +0000] "GET /docs/migrate/⟬version#2⟭ HTTP/2.0" 200 10990 "⟬url#14⟭" "Mozilla/5.0 (Macintosh; Intel Mac OS X 14_1) Safari/605.1.15" ctx="-"
⟬ip_address#21⟭ - - [⟬date#1⟭ 10:07:59 +0000] "GET /docs/compliance/hipaa HTTP/2.0" 200 9120 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/120.0" ctx="cache=hit"
⟬ip_address#21⟭ - - [⟬date#1⟭ 10:08:13 +0000] "GET /docs/compliance/soc2 HTTP/2.0" 200 8440 "⟬url#15⟭" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/120.0" ctx="-"
⟬ip_address#22⟭ - - [⟬date#1⟭ 10:08:27 +0000] "GET /docs/api/customers?example=⟬trap:indicator_non_pii|customer=cus_example⟭ HTTP/2.0" 200 17888 "-" "Mozilla/5.0 (compatible; Googlebot/2.1)" ctx="-"
⟬ip_address#22⟭ - - [⟬date#1⟭ 10:08:29 +0000] "GET /docs/api/webhooks HTTP/2.0" 200 16020 "-" "Mozilla/5.0 (compatible; Googlebot/2.1)" ctx="-"
⟬ip_address#23⟭ - - [⟬date#1⟭ 10:08:44 +0000] "GET /docs/tutorials/⟬trap:eponym|levenshtein-search⟭ HTTP/2.0" 200 12240 "⟬url#16⟭" "Mozilla/5.0 (X11; Linux x86_64) Chrome/121.0" ctx="cache=hit"
⟬ip_address#23⟭ - - [⟬date#1⟭ 10:08:57 +0000] "GET /docs/tutorials/⟬trap:code_identifier|⦃family⦄_exporter⟭ HTTP/2.0" 200 11060 "⟬url#16⟭" "Mozilla/5.0 (X11; Linux x86_64) Chrome/121.0" ctx="-"
⟬ip_address#24⟭ - - [⟬date#1⟭ 10:09:06 +0000] "GET /status HTTP/2.0" 200 3120 "-" "UptimeProbe/2.1" ctx="-"
⟬ip_address#25⟭ - - [⟬date#1⟭ 10:09:21 +0000] "GET /docs/api/billing?example=⟬trap:indicator_non_pii|card_number=****⟭ HTTP/2.0" 200 13100 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 14_3) Chrome/121.0" ctx="-"
⟬ip_address#25⟭ - - [⟬date#1⟭ 10:09:37 +0000] "GET /docs/api/refunds HTTP/2.0" 200 12020 "⟬url#17⟭" "Mozilla/5.0 (Macintosh; Intel Mac OS X 14_3) Chrome/121.0" ctx="cache=hit"
⟬ip_address#26⟭ - - [⟬date#1⟭ 10:09:51 +0000] "GET /docs/teams/roles?role=owner HTTP/2.0" 200 7840 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/121.0" ctx="-"
⟬ip_address#27⟭ - - [⟬date#1⟭ 10:10:04 +0000] "GET /docs/ HTTP/2.0" 304 0 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/121.0" ctx="-"
⟬ip_address#27⟭ - - [⟬date#1⟭ 10:10:18 +0000] "GET /docs/release-notes HTTP/2.0" 200 19240 "⟬url#18⟭" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/121.0" ctx="-"
⟬ip_address#28⟭ - - [⟬date#1⟭ 10:10:33 +0000] "GET /docs/cli/install HTTP/2.0" 200 7300 "-" "curl/8.5.0" ctx="cache=hit"
⟬ip_address#28⟭ - - [⟬date#1⟭ 10:10:34 +0000] "GET /install.sh HTTP/2.0" 200 4120 "-" "curl/8.5.0" ctx="-"
⟬ip_address#29⟭ - - [⟬date#1⟭ 10:10:50 +0000] "GET /docs/cli/login?flag=⟬trap:indicator_non_pii|--user=me⟭ HTTP/2.0" 200 6620 "-" "Mozilla/5.0 (X11; Fedora; Linux x86_64) Firefox/121.0" ctx="-"
⟬ip_address#30⟭ - - [⟬date#1⟭ 10:11:04 +0000] "GET /docs/ HTTP/2.0" 200 18244 "-" "Mozilla/5.0 (Linux; Android 14) Chrome/121.0" ctx="-"
⟬ip_address#30⟭ - - [⟬date#1⟭ 10:11:16 +0000] "GET /docs/api/rate-limits HTTP/2.0" 200 9180 "⟬url#19⟭" "Mozilla/5.0 (Linux; Android 14) Chrome/121.0" ctx="cache=hit"
⟬ip_address#15⟭ - - [⟬date#1⟭ 10:12:04 +0000] "HEAD /docs/ HTTP/1.1" 200 0 "-" "UptimeProbe/2.1" ctx="-"
⟬ip_address#24⟭ - - [⟬date#1⟭ 10:13:06 +0000] "GET /status HTTP/2.0" 200 3120 "-" "UptimeProbe/2.1" ctx="-"
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: en
fill_locale: en_US
domain: healthcare
appearance: CodeBuild log, shell trace, psql table, connection string, row dump before masking
scenario: AWS CodeBuild job refreshing a health insurer's test database from a dump, printing the credentials used and sample member rows before the masking step
⟬text⟭
[Container] ⟬date#1⟭ 03:12:40 Waiting for agent ping
[Container] ⟬date#1⟭ 03:12:41 Waiting for DOWNLOAD_SOURCE
[Container] ⟬date#1⟭ 03:12:44 Phase is DOWNLOAD_SOURCE
[Container] ⟬date#1⟭ 03:12:44 CODEBUILD_SRC_DIR=/codebuild/output/src118/src
[Container] ⟬date#1⟭ 03:12:44 YAML location is /codebuild/output/src118/src/buildspec-refresh.yml
[Container] ⟬date#1⟭ 03:12:44 Processing environment variables
[Container] ⟬date#1⟭ 03:12:45 Moving to directory /codebuild/output/src118/src
[Container] ⟬date#1⟭ 03:12:45 Registering with agent
[Container] ⟬date#1⟭ 03:12:45 Phases found in YAML: 3
[Container] ⟬date#1⟭ 03:12:45  BUILD: 9 commands
[Container] ⟬date#1⟭ 03:12:45  INSTALL: 2 commands
[Container] ⟬date#1⟭ 03:12:45  POST_BUILD: 2 commands
[Container] ⟬date#1⟭ 03:12:45 Phase complete: DOWNLOAD_SOURCE State: SUCCEEDED
[Container] ⟬date#1⟭ 03:12:46 Entering phase INSTALL
[Container] ⟬date#1⟭ 03:12:46 Running command apt-get install -y postgresql-client-15
Reading package lists...
Setting up postgresql-client-15 (15.6-1) ...
[Container] ⟬date#1⟭ 03:13:02 Running command pip install -r masking/requirements.txt
Successfully installed faker-22.5.1 psycopg-3.1.18
[Container] ⟬date#1⟭ 03:13:09 Phase complete: INSTALL State: SUCCEEDED
[Container] ⟬date#1⟭ 03:13:09 Entering phase BUILD
[Container] ⟬date#1⟭ 03:13:09 Running command echo "refreshing from snapshot ⟬uuid#1⟭"
refreshing from snapshot ⟬uuid#1⟭
[Container] ⟬date#1⟭ 03:13:09 Running command export PGPASSWORD=⟬password#1⟭
[Container] ⟬date#1⟭ 03:13:09 Running command export TARGET=postgresql://refresh_job:⟬url_password#1⟭@⟬hostname#1⟭:5432/members_test
[Container] ⟬date#1⟭ 03:13:10 Running command aws s3 cp ⟬url#1⟭ /tmp/members.dump
download: completed 41.2 GiB
[Container] ⟬date#1⟭ 03:29:51 Running command pg_restore --no-owner --dbname=$TARGET /tmp/members.dump
pg_restore: creating TABLE "public.members"
pg_restore: creating TABLE "public.claims"
pg_restore: creating INDEX "public.members_ssn_idx"
pg_restore: processing data for table "public.members"
pg_restore: processing data for table "public.claims"
[Container] ⟬date#1⟭ 04:02:17 Running command psql $TARGET -c "select member_id, full_name, ssn, dob, address from members limit 3"
 member_id |        full_name        |     ssn     |    dob     |                address
-----------+-------------------------+-------------+------------+----------------------------------------
 ⟬customer_id#2⟭ | ⟬person_name#2⟭ | ⟬us_ssn#2⟭ | ⟬birth_date#2⟭ | ⟬postal_address#2⟭
 ⟬customer_id#3⟭ | ⟬person_name#3⟭ | ⟬us_ssn#3⟭ | ⟬birth_date#3⟭ | ⟬postal_address#3⟭
 ⟬customer_id#4⟭ | ⟬person_name#4⟭ | ⟬us_ssn#4⟭ | ⟬birth_date#4⟭ | ⟬postal_address#4⟭
(3 rows)
[Container] ⟬date#1⟭ 04:02:18 Running command python masking/run.py --target $TARGET --rules masking/rules.yml
mask: loaded 14 rules, seed=fixed
mask: table members columns full_name ssn dob address phone email
mask: 2184120 rows masked in 412s
mask: table claims columns diagnosis_note
mask: 18204411 rows masked in 1980s
mask: table dependents columns full_name dob relationship
mask: 912044 rows masked in 88s
mask: table providers columns contact_name contact_phone
mask: 41020 rows masked in 6s
mask: verifying a sample of 1000 rows
mask: sample ok, no original value found
[Container] ⟬date#1⟭ 04:45:31 Running command psql $TARGET -c "select count(*) from members where ssn not like 'XXX%'"
 count
-------
     0
(1 row)
[Container] ⟬date#1⟭ 04:45:31 Running command psql $TARGET -c "analyze"
ANALYZE
[Container] ⟬date#1⟭ 04:45:32 Running command curl -s -H "x-refresh-key: ⟬opaque_token#1⟭" -X POST ⟬url#2⟭
{"refreshed":true}
[Container] ⟬date#1⟭ 04:45:33 Phase complete: BUILD State: SUCCEEDED
[Container] ⟬date#1⟭ 04:45:33 Entering phase POST_BUILD
[Container] ⟬date#1⟭ 04:45:33 Running command rm -f /tmp/members.dump
[Container] ⟬date#1⟭ 04:45:38 Running command aws sns publish --topic-arn arn:aws:sns:us-east-1:000000000000:test-data --message done
[Container] ⟬date#1⟭ 04:45:39 Phase complete: POST_BUILD State: SUCCEEDED
[Container] ⟬date#1⟭ 04:45:39 Phase context status code:  Message:
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: en
fill_locale: en_US
domain: retail
appearance: key=value, audit trail, promotions, trap under a people field
scenario: price and promotion audit of a supermarket chain over a night of automated changes, where owner and approver fields hold only teams and robots
⟬text⟭
⟬date#1⟭ 00:00:03 promo-audit id=71001 action=PROMO_START promo=BOGO-DAIRY ⟬trap:indicator_non_pii|owner=category-dairy⟭ ⟬trap:indicator_non_pii|approved_by=pricing-bot⟭ stores=412
⟬date#1⟭ 00:00:04 promo-audit id=71002 action=PROMO_START promo=WINE-TEN ⟬trap:indicator_non_pii|owner=category-wine⟭ ⟬trap:indicator_non_pii|approved_by=pricing-bot⟭ stores=388
⟬date#1⟭ 00:00:11 promo-audit id=71003 action=PRICE_CHANGE sku=118204 name="⟬trap:word_name|Margaux⟭ red 750ml" old=24.99 new=19.99 ⟬trap:indicator_non_pii|author=rules-engine⟭
⟬date#1⟭ 00:00:11 promo-audit id=71004 action=PRICE_CHANGE sku=118207 name="Pinot ⟬trap:word_name|Rose⟭ 750ml" old=13.99 new=11.99 ⟬trap:indicator_non_pii|author=rules-engine⟭
⟬date#1⟭ 00:00:12 promo-audit id=71005 action=PRICE_CHANGE sku=204118 name="⟬trap:company_name|Heinz⟭ ketchup 32oz" old=4.79 new=3.99 ⟬trap:indicator_non_pii|author=rules-engine⟭
⟬date#1⟭ 00:00:12 promo-audit id=71006 action=PRICE_CHANGE sku=204120 name="⟬trap:company_name|Kellogg⟭ flakes 18oz" old=5.49 new=4.99 ⟬trap:indicator_non_pii|author=rules-engine⟭
⟬date#1⟭ 00:00:15 promo-audit id=71007 action=LABEL_PUSH stores=412 file=⟬file_path#1⟭ ⟬trap:indicator_non_pii|operator=esl-gateway⟭
⟬date#1⟭ 00:04:51 promo-audit id=71008 action=LABEL_ACK stores=409 failed=3 ⟬trap:indicator_non_pii|operator=esl-gateway⟭
⟬date#1⟭ 00:05:02 promo-audit id=71009 action=LABEL_RETRY stores=3 ⟬trap:indicator_non_pii|operator=esl-gateway⟭ ticket=⟬ticket_id#1⟭
⟬date#1⟭ 01:00:00 promo-audit id=71010 action=COUPON_BATCH count=120000 ⟬trap:indicator_non_pii|customer=segment-loyal⟭ ⟬trap:indicator_non_pii|user=marketing-api⟭
⟬date#1⟭ 01:30:00 promo-audit id=71011 action=COUPON_BATCH count=48000 ⟬trap:indicator_non_pii|customer=segment-lapsed⟭ ⟬trap:indicator_non_pii|user=marketing-api⟭
⟬date#1⟭ 02:10:14 promo-audit id=71012 action=COST_IMPORT source=⟬url#1⟭ rows=88120 ⟬trap:indicator_non_pii|owner=finance-data⟭
⟬date#1⟭ 02:15:40 promo-audit id=71013 action=MARGIN_CHECK breaches=4 ⟬trap:indicator_non_pii|reviewer=margin-guard⟭
⟬date#1⟭ 02:15:41 promo-audit id=71014 action=PRICE_REVERT sku=204118 old=3.99 new=4.29 ⟬trap:indicator_non_pii|reviewer=margin-guard⟭
⟬date#1⟭ 03:00:00 promo-audit id=71015 action=SNAPSHOT file=⟬hash#1⟭ size_mb=412 ⟬trap:indicator_non_pii|owner=platform-data⟭
⟬date#1⟭ 03:00:02 promo-audit id=71016 action=REPORT dest=⟬url#2⟭ version=⟬version#1⟭
⟬end⟭

⟬template⟭
family: logs
format: application log
language: en
fill_locale: en_US
domain: SaaS
appearance: log field, webhook signature, secret under an innocuous key, HTTP header
scenario: webhook receiver of a form builder rejecting a signature and logging the shared secret and a session header beside the digests
⟬text⟭
⟬date#1⟭ 19:03:12 WARN webhooks.verify provider=billing computed=⟬hash#1⟭ received=⟬hash#2⟭ k=⟬opaque_token#1⟭
⟬date#1⟭ 19:03:12 WARN webhooks.verify replaying with headers X-Session: ⟬jwt#1⟭ X-Request-Id: ⟬uuid#1⟭
⟬date#1⟭ 19:03:12 INFO webhooks.queue delivery ⟬uuid#2⟭ dropped, ⟬trap:indicator_non_pii|owner=integrations⟭
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: en
fill_locale: en_US
domain: healthcare
appearance: Rust panic, Debug struct, Result unwrap
scenario: Rust panic in a claims clearinghouse, where an unwrap prints the Debug form of an invalid member
⟬text⟭
thread 'tokio-runtime-worker' panicked at src/claims/submit.rs:212:18:
called `Result::unwrap()` on an `Err` value: InvalidMember { name: "⟬person_name#1⟭", ssn: "⟬us_ssn#1⟭", dob: "⟬birth_date#1⟭", plan: "⟬customer_id#1⟭" }
note: run with `RUST_BACKTRACE=1` environment variable to display a backtrace
⟬end⟭

⟬template⟭
family: logs
format: test output
language: en
fill_locale: en_US
domain: retail
appearance: JUnit XML report, CDATA, system-out, failure message, test fixture
scenario: JUnit XML report of an order refund suite at a department store, whose CDATA sections hold the customer, card, password and address of failing fixtures
⟬text⟭
<?xml version="1.0" encoding="UTF-8"?>
<testsuite name="com.northpier.orders.RefundFlowIT" time="41.208" tests="31" errors="0" skipped="1" failures="2" timestamp="⟬date#1⟭ 03:12:44">
  <properties>
    <property name="java.version" value="17.0.10"/>
    <property name="os.name" value="Linux"/>
    <property name="user.name" value="⟬trap:indicator_non_pii|jenkins⟭"/>
    <property name="user.home" value="⟬trap:indicator_non_pii|/var/lib/jenkins⟭"/>
    <property name="spring.profiles.active" value="it"/>
    <property name="server.port" value="0"/>
  </properties>
  <testcase name="refundsFullOrder" classname="com.northpier.orders.RefundFlowIT" time="1.204"/>
  <testcase name="refundsSingleLine" classname="com.northpier.orders.RefundFlowIT" time="0.981"/>
  <testcase name="rejectsRefundOnGiftCard" classname="com.northpier.orders.RefundFlowIT" time="0.402"/>
  <testcase name="keepsLoyaltyPoints" classname="com.northpier.orders.RefundFlowIT" time="0.733">
    <skipped message="waiting for ⟬ticket_id#1⟭"/>
  </testcase>
  <testcase name="refundsToOriginalCard" classname="com.northpier.orders.RefundFlowIT" time="2.117">
    <failure message="expected: REFUNDED but was: PENDING" type="org.opentest4j.AssertionFailedError"><![CDATA[org.opentest4j.AssertionFailedError: expected: REFUNDED but was: PENDING
	at com.northpier.orders.RefundFlowIT.refundsToOriginalCard(RefundFlowIT.java:118)
]]></failure>
    <system-out><![CDATA[03:12:51.204 INFO  c.b.o.FixtureLoader - order ⟬order_number#2⟭ for ⟬person_name#2⟭ <⟬email#2⟭>
03:12:51.206 DEBUG c.b.o.FixtureLoader - card ⟬payment_card#2⟭ cvv ⟬card_security_code#2⟭
03:12:51.207 DEBUG c.b.o.FixtureLoader - ship to ⟬postal_address#2⟭
03:12:51.302 INFO  c.b.o.RefundService - refund ⟬uuid#1⟭ queued
03:12:53.100 WARN  c.b.o.RefundService - gateway timeout, leaving PENDING
]]></system-out>
  </testcase>
  <testcase name="refundsToStoreCredit" classname="com.northpier.orders.RefundFlowIT" time="0.612"/>
  <testcase name="splitsRefundAcrossTenders" classname="com.northpier.orders.RefundFlowIT" time="1.340"/>
  <testcase name="blocksRefundAfterNinetyDays" classname="com.northpier.orders.RefundFlowIT" time="0.288"/>
  <testcase name="sendsConfirmationEmail" classname="com.northpier.orders.RefundFlowIT" time="0.904"/>
  <testcase name="logsAuditTrail" classname="com.northpier.orders.RefundFlowIT" time="0.511"/>
  <testcase name="customerLoginRequiredForHistory" classname="com.northpier.orders.RefundFlowIT" time="1.822">
    <failure message="status 401" type="java.lang.AssertionError"><![CDATA[java.lang.AssertionError: status 401
	at com.northpier.orders.RefundFlowIT.customerLoginRequiredForHistory(RefundFlowIT.java:207)
]]></failure>
    <system-out><![CDATA[03:13:04.002 DEBUG c.b.o.AuthClient - POST /login {"user":"⟬email#3⟭","password":"⟬password#1⟭"}
03:13:04.310 DEBUG c.b.o.AuthClient - response 401, session ref ⟬opaque_token#1⟭
]]></system-out>
  </testcase>
  <testcase name="refundsShippingFee" classname="com.northpier.orders.RefundFlowIT" time="0.447"/>
  <testcase name="refundsTaxOnly" classname="com.northpier.orders.RefundFlowIT" time="0.390"/>
  <testcase name="restocksReturnedItem" classname="com.northpier.orders.RefundFlowIT" time="0.655"/>
  <testcase name="flagsRepeatReturner" classname="com.northpier.orders.RefundFlowIT" time="0.702"/>
  <testcase name="handlesDuplicateWebhook" classname="com.northpier.orders.RefundFlowIT" time="0.318"/>
  <testcase name="⟬trap:code_identifier|appliesDelacroixRounding⟭" classname="com.northpier.orders.RefundFlowIT" time="0.109"/>
  <testcase name="⟬trap:code_identifier|exportsTo⦃Family⦄Ledger⟭" classname="com.northpier.orders.RefundFlowIT" time="0.421"/>
  <testcase name="partialRefundKeepsDiscount" classname="com.northpier.orders.RefundFlowIT" time="0.588"/>
  <testcase name="fullRefundRemovesDiscount" classname="com.northpier.orders.RefundFlowIT" time="0.541"/>
  <testcase name="returnsLabelPdf" classname="com.northpier.orders.RefundFlowIT" time="0.977"/>
  <testcase name="mailsLabelToCustomer" classname="com.northpier.orders.RefundFlowIT" time="0.610">
    <system-out><![CDATA[03:13:19.550 INFO  c.b.o.LabelMailer - label for "⟬person_name#4⟭" sent to ⟬postal_address#4⟭
]]></system-out>
  </testcase>
  <testcase name="carrierPickupBooked" classname="com.northpier.orders.RefundFlowIT" time="0.804"/>
  <testcase name="carrierPickupCancelled" classname="com.northpier.orders.RefundFlowIT" time="0.377"/>
  <testcase name="taxRecalculatedByState" classname="com.northpier.orders.RefundFlowIT" time="0.298"/>
  <testcase name="refundIdempotencyKeyReused" classname="com.northpier.orders.RefundFlowIT" time="0.261"/>
  <testcase name="emptyCartIsRejected" classname="com.northpier.orders.RefundFlowIT" time="0.102"/>
  <testcase name="adminCanForceRefund" classname="com.northpier.orders.RefundFlowIT" time="0.733"/>
</testsuite>
⟬end⟭

⟬template⟭
family: logs
format: access log
language: en
fill_locale: en_US
domain: government
appearance: combined log format, open data paths, code words near personal words
scenario: access lines of a city open data portal serving zoning and permit datasets to scripts, with no identified person
⟬text⟭
⟬ip_address#1⟭ - - [⟬date#1⟭ 08:12:04 -0500] "GET /datasets/zoning.csv HTTP/1.1" 200 4120488 "-" "python-requests/2.31.0" ctx="-"
⟬ip_address#2⟭ - - [⟬date#1⟭ 08:12:19 -0500] "GET /datasets/permits.geojson?⟬trap:indicator_non_pii|owner_name=excluded⟭ HTTP/1.1" 200 8120442 "-" "QGIS/3.34" ctx="format=csv"
⟬ip_address#3⟭ - - [⟬date#1⟭ 08:12:33 -0500] "GET /api/parks?county=⟬trap:word_name|Madison⟭ HTTP/1.1" 200 18204 "-" "curl/8.4.0" ctx="-"
⟬ip_address#4⟭ - - [⟬date#1⟭ 08:13:02 -0500] "HEAD /datasets/budget.parquet HTTP/1.1" 200 0 "-" "DuckDB/0.10" ctx="format=csv"
⟬ip_address#1⟭ - - [⟬date#1⟭ 08:13:40 -0500] "GET /robots.txt HTTP/1.1" 200 122 "-" "Mozilla/5.0 (compatible; bingbot/2.0)" ctx="-"
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: en
fill_locale: en_US
domain: travel
appearance: TeamCity service messages, test fixture, plate and license in a test name, password in a parameter
scenario: TeamCity build of a car rental booking engine, whose service messages carry a failing fixture with renter, license, passport and plate and a parameter dump exposing a password
⟬text⟭
[08:02:11] : Step 1/3: Compile (Gradle)
[08:02:11] :  [Step 1/3] Starting: /opt/gradle/bin/gradle --no-daemon assemble
[08:03:05] :  [Step 1/3] BUILD SUCCESSFUL in 53s
[08:03:05] : Step 2/3: Tests (Gradle)
##teamcity[testSuiteStarted name='RentalAgreementTest']
##teamcity[testStarted name='RentalAgreementTest.acceptsValidLicense']
##teamcity[testFinished name='RentalAgreementTest.acceptsValidLicense' duration='84']
##teamcity[testStarted name='RentalAgreementTest.requiresPassportForForeignLicense']
##teamcity[testFailed name='RentalAgreementTest.requiresPassportForForeignLicense' message='expected BLOCKED, got CONFIRMED']
[08:03:31] :  [Step 2/3] fixture renter="⟬person_name#1⟭" license="⟬us_driver_license#1⟭" passport=⟬us_passport#1⟭ vehicle="⟬us_license_plate#2⟭" pickup=⟬trap:word_name|Charlotte⟭
##teamcity[testFinished name='RentalAgreementTest.requiresPassportForForeignLicense' duration='112']
##teamcity[testStarted name='RentalAgreementTest.addsSecondDriver']
[08:03:44] :  [Step 2/3] second driver "⟬person_name#3f⟭" license "⟬us_driver_license#3⟭"
[08:03:44] :  [Step 2/3] renter note: my wife ⟬person_name#3f⟭ will also drive
##teamcity[testFinished name='RentalAgreementTest.addsSecondDriver' duration='63']
##teamcity[testSuiteFinished name='RentalAgreementTest']
[08:03:58] : Step 3/3: Publish (Command Line)
[08:03:58] :  [Step 3/3] Build parameters:
[08:03:58] :  [Step 3/3]   env.ARTIFACT_REPO=⟬url#1⟭
[08:03:58] :  [Step 3/3]   env.ARTIFACT_USER=⟬trap:indicator_non_pii|teamcity-agent⟭
[08:03:58] :  [Step 3/3]   env.ARTIFACT_PASS=⟬password#1⟭
[08:03:58] :  [Step 3/3]   env.BUILD_NUMBER=⟬version#1⟭
[08:04:02] :  [Step 3/3] Upload failed: 403 for ⟬url#1⟭
[08:04:02] : Process exited with code 1
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: en
fill_locale: en_US
domain: fintech
appearance: audit trail, key=value, HSM key ceremony, key identifier
scenario: audit of a monthly HSM key rotation at a payment processor, showing only key identifiers, fingerprints and robot operators
⟬text⟭
⟬date#1⟭ 02:00:00 hsm-audit op=KEY_GEN slot=4 label=pin-zone kcv=A1F operator=⟬trap:indicator_non_pii|ceremony-bot⟭ key_id=⟬hash#1⟭
⟬date#1⟭ 02:00:04 hsm-audit op=KEY_EXPORT_WRAPPED slot=4 dest=⟬hostname#1⟭ fingerprint=⟬hash#2⟭ ⟬trap:indicator_non_pii|owner=key-custodians⟭
⟬date#1⟭ 02:00:09 hsm-audit op=KEY_ACTIVATE slot=4 ⟬trap:indicator_non_pii|token_ttl_days=30⟭ ceremony=⟬uuid#1⟭
⟬date#1⟭ 02:00:15 hsm-audit op=KEY_RETIRE slot=3 key_id=⟬hash#3⟭ result=ok
⟬end⟭
