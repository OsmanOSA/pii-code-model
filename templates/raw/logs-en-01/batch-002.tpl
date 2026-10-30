⟬template⟭
family: logs
format: test output
language: en
fill_locale: en_US
domain: retail
appearance: Jest output, console.log object, test fixture, nested object
scenario: Jest failure of a store's payment form, where the summary shows the full card and a console.log prints the whole checkout fixture with its security code and split address
⟬text⟭
 FAIL  src/checkout/__tests__/PaymentForm.test.tsx
  ● Console

    console.log
      fixture customer {
        fullName: "⟬person_name#1⟭",
        email: "⟬email#1⟭",
        card: { number: "⟬payment_card#1⟭", cvc: "⟬card_security_code#1⟭" },
        shipTo: { street: "⟬postal_address:street#1⟭", city: "⟬city#1⟭", zip: "⟬postcode#1⟭" }
      }

      at Object.log (src/checkout/__tests__/PaymentForm.test.tsx:18:13)

  ● PaymentForm › masks the card number in the order summary

    expect(element).toHaveTextContent()

    Expected element to have text content:
      ending in
    Received:
      Pay with ⟬payment_card#1⟭

      52 |     await user.click(screen.getByRole("button", { name: /review order/i }));
      53 |     const summary = screen.getByTestId("order-summary");
    > 54 |     expect(summary).toHaveTextContent("ending in");
         |                     ^
      55 |   });

      at Object.toHaveTextContent (src/checkout/__tests__/PaymentForm.test.tsx:54:21)

 PASS  src/checkout/__tests__/ShippingForm.test.tsx
 PASS  src/cart/__tests__/cart.reducer.test.ts

Test Suites: 1 failed, 11 passed, 12 total
Tests:       1 failed, 148 passed, 149 total
Snapshots:   6 passed, 6 total
Time:        9.412 s
⟬end⟭

⟬template⟭
family: logs
format: access log
language: en
fill_locale: en_US
domain: government
appearance: IIS W3C log, query string, custom context field, domain account, passport in a query string
scenario: IIS log of a state motor vehicle portal, where a debug field copies plates, licenses and SSNs, and REAL ID links carry passports and tokens in the query string
⟬text⟭
#Software: Microsoft Internet Information Services 10.0
#Version: 1.0
#Date: ⟬date#1⟭ 12:00:00
#Fields: date time s-ip cs-method cs-uri-stem cs-uri-query s-port cs-username c-ip cs(User-Agent) sc-status sc-substatus sc-win32-status time-taken x-ctx
⟬date#1⟭ 12:40:02 ⟬ip_address#1⟭ GET /renew/start - 443 - ⟬ip_address#2⟭ Mozilla/5.0+(Windows+NT+10.0;+Win64;+x64) 200 0 0 46 ctx="-"
⟬date#1⟭ 12:40:03 ⟬ip_address#1⟭ GET /content/site.css - 443 - ⟬ip_address#2⟭ Mozilla/5.0+(Windows+NT+10.0;+Win64;+x64) 304 0 0 3 ctx="-"
⟬date#1⟭ 12:40:19 ⟬ip_address#1⟭ POST /renew/lookup - 443 - ⟬ip_address#2⟭ Mozilla/5.0+(Windows+NT+10.0;+Win64;+x64) 200 0 0 311 ctx="plate=⟬us_license_plate#3⟭ zip=⟬postcode#3⟭"
⟬date#1⟭ 12:40:20 ⟬ip_address#1⟭ GET /renew/vehicle vin_hint=2T1&step=2 443 - ⟬ip_address#2⟭ Mozilla/5.0+(Windows+NT+10.0;+Win64;+x64) 200 0 0 72 ctx="owner=⟬person_name#3⟭"
⟬date#1⟭ 12:40:41 ⟬ip_address#1⟭ POST /renew/insurance - 443 - ⟬ip_address#2⟭ Mozilla/5.0+(Windows+NT+10.0;+Win64;+x64) 302 0 0 128 ctx="policy=⟬order_number#1⟭"
⟬date#1⟭ 12:40:58 ⟬ip_address#1⟭ POST /renew/pay - 443 - ⟬ip_address#2⟭ Mozilla/5.0+(Windows+NT+10.0;+Win64;+x64) 200 0 0 904 ctx="dl=⟬us_driver_license#3⟭ amt=64.50"
⟬date#1⟭ 12:40:59 ⟬ip_address#1⟭ GET /renew/receipt ref=⟬uuid#1⟭ 443 - ⟬ip_address#2⟭ Mozilla/5.0+(Windows+NT+10.0;+Win64;+x64) 200 0 0 38 ctx="-"
⟬date#1⟭ 12:41:05 ⟬ip_address#1⟭ GET /health - 443 - ⟬ip_address#3⟭ AlwaysOn 200 0 0 1 ctx="-"
⟬date#1⟭ 12:41:12 ⟬ip_address#1⟭ GET /renew/resume token=⟬opaque_token#1⟭ 443 - ⟬ip_address#4⟭ Mozilla/5.0+(iPhone;+CPU+iPhone+OS+17_3) 200 0 0 54 ctx="-"
⟬date#1⟭ 12:41:30 ⟬ip_address#1⟭ POST /renew/lookup - 443 - ⟬ip_address#4⟭ Mozilla/5.0+(iPhone;+CPU+iPhone+OS+17_3) 404 0 0 287 ctx="plate=⟬us_license_plate#5⟭ zip=⟬postcode#5⟭"
⟬date#1⟭ 12:41:44 ⟬ip_address#1⟭ POST /renew/lookup - 443 - ⟬ip_address#4⟭ Mozilla/5.0+(iPhone;+CPU+iPhone+OS+17_3) 200 0 0 301 ctx="plate=⟬us_license_plate#6⟭ zip=⟬postcode#6⟭"
⟬date#1⟭ 12:42:02 ⟬ip_address#1⟭ GET /realid/start - 443 - ⟬ip_address#7⟭ Mozilla/5.0+(Macintosh;+Intel+Mac+OS+X+14_2) 200 0 0 41 ctx="-"
⟬date#1⟭ 12:42:27 ⟬ip_address#1⟭ POST /realid/identity - 443 - ⟬ip_address#7⟭ Mozilla/5.0+(Macintosh;+Intel+Mac+OS+X+14_2) 200 0 0 233 ctx="ssn=⟬us_ssn#7⟭ dob=⟬birth_date#7⟭"
⟬date#1⟭ 12:42:49 ⟬ip_address#1⟭ GET /realid/docs passport=⟬us_passport#7⟭&session=⟬jwt#1⟭ 443 - ⟬ip_address#7⟭ Mozilla/5.0+(Macintosh;+Intel+Mac+OS+X+14_2) 200 0 0 66 ctx="-"
⟬date#1⟭ 12:43:10 ⟬ip_address#1⟭ POST /realid/residency - 443 - ⟬ip_address#7⟭ Mozilla/5.0+(Macintosh;+Intel+Mac+OS+X+14_2) 200 0 0 402 ctx="addr=⟬postal_address#7⟭"
⟬date#1⟭ 12:43:11 ⟬ip_address#1⟭ GET /realid/appointment session=⟬jwt#1⟭ 443 - ⟬ip_address#7⟭ Mozilla/5.0+(Macintosh;+Intel+Mac+OS+X+14_2) 200 0 0 58 ctx="-"
⟬date#1⟭ 12:43:33 ⟬ip_address#1⟭ POST /realid/appointment - 443 - ⟬ip_address#7⟭ Mozilla/5.0+(Macintosh;+Intel+Mac+OS+X+14_2) 201 0 0 91 ctx="slot=⟬date#1⟭ 09:30 office=⟬trap:word_name|Florence⟭"
⟬date#1⟭ 12:44:05 ⟬ip_address#1⟭ GET /health - 443 - ⟬ip_address#3⟭ AlwaysOn 200 0 0 1 ctx="-"
⟬date#1⟭ 12:44:17 ⟬ip_address#1⟭ GET /admin/queue - 443 DMV\⟬person_name:handle#8⟭ ⟬ip_address#9⟭ Mozilla/5.0+(Windows+NT+10.0;+Win64;+x64) 200 0 0 118 ctx="-"
⟬date#1⟭ 12:44:29 ⟬ip_address#1⟭ GET /admin/case/⟬uuid#2⟭ - 443 DMV\⟬person_name:handle#8⟭ ⟬ip_address#9⟭ Mozilla/5.0+(Windows+NT+10.0;+Win64;+x64) 200 0 0 164 ctx="subject=⟬person_name#7⟭"
⟬date#1⟭ 12:44:58 ⟬ip_address#1⟭ POST /admin/case/⟬uuid#2⟭/approve - 443 DMV\⟬person_name:handle#8⟭ ⟬ip_address#9⟭ Mozilla/5.0+(Windows+NT+10.0;+Win64;+x64) 200 0 0 77 ctx="ticket=⟬ticket_id#1⟭"
⟬date#1⟭ 12:45:01 ⟬ip_address#1⟭ POST /admin/mail-batch - 443 DMV\⟬username#1⟭ ⟬ip_address#10⟭ python-requests/2.31.0 202 0 0 39 ctx="count=118"
⟬date#1⟭ 12:45:22 ⟬ip_address#1⟭ GET /notify/unsubscribe e=⟬email#11⟭&k=⟬opaque_token#2⟭ 443 - ⟬ip_address#12⟭ Mozilla/5.0+(Linux;+Android+14) 200 0 0 28 ctx="-"
⟬date#1⟭ 12:45:40 ⟬ip_address#1⟭ GET /wp-admin/setup-config.php - 443 - ⟬ip_address#13⟭ python-requests/2.28.1 404 0 2 2 ctx="-"
⟬date#1⟭ 12:45:41 ⟬ip_address#1⟭ GET /web.config - 443 - ⟬ip_address#13⟭ python-requests/2.28.1 404 8 0 1 ctx="-"
⟬date#1⟭ 12:45:41 ⟬ip_address#1⟭ GET /App_Data/users.xml - 443 - ⟬ip_address#13⟭ python-requests/2.28.1 404 8 0 1 ctx="-"
⟬date#1⟭ 12:46:02 ⟬ip_address#1⟭ POST /title/transfer - 443 - ⟬ip_address#14⟭ Mozilla/5.0+(Windows+NT+10.0;+Win64;+x64) 200 0 0 512 ctx="seller=⟬person_name#14⟭ buyer=⟬person_name#15⟭ plate=⟬us_license_plate#14⟭"
⟬date#1⟭ 12:46:03 ⟬ip_address#1⟭ POST /title/transfer/confirm - 443 - ⟬ip_address#14⟭ Mozilla/5.0+(Windows+NT+10.0;+Win64;+x64) 200 0 0 188 ctx="buyer_dl=⟬us_driver_license#15⟭ buyer_addr=⟬postal_address#15⟭"
⟬date#1⟭ 12:46:30 ⟬ip_address#1⟭ GET /fees/calculator class=2&county=⟬trap:word_name|Madison⟭ 443 - ⟬ip_address#16⟭ Mozilla/5.0+(iPad;+CPU+OS+17_2) 200 0 0 22 ctx="-"
⟬date#1⟭ 12:47:05 ⟬ip_address#1⟭ GET /health - 443 - ⟬ip_address#3⟭ AlwaysOn 200 0 0 1 ctx="-"
⟬date#1⟭ 12:47:18 ⟬ip_address#1⟭ POST /api/insurers/verify - 443 ⟬username#2⟭ ⟬ip_address#17⟭ InsurerBridge/⟬version#1⟭ 200 0 0 97 ctx="ref=⟬opaque_token#3⟭"
⟬date#1⟭ 12:47:19 ⟬ip_address#1⟭ POST /api/insurers/verify - 443 ⟬username#2⟭ ⟬ip_address#17⟭ InsurerBridge/⟬version#1⟭ 200 0 0 89 ctx="ref=⟬order_number#2⟭"
⟬date#1⟭ 12:47:44 ⟬ip_address#1⟭ POST /renew/lookup - 443 - ⟬ip_address#18⟭ Mozilla/5.0+(Linux;+Android+13) 200 0 0 318 ctx="plate=⟬us_license_plate#18⟭ zip=⟬postcode#18⟭"
⟬date#1⟭ 12:48:12 ⟬ip_address#1⟭ POST /renew/address-change - 443 - ⟬ip_address#18⟭ Mozilla/5.0+(Linux;+Android+13) 200 0 0 276 ctx="new=⟬postal_address#18⟭"
⟬date#1⟭ 12:48:13 ⟬ip_address#1⟭ GET /renew/sticker status=mailed 443 - ⟬ip_address#18⟭ Mozilla/5.0+(Linux;+Android+13) 200 0 0 31 ctx="-"
⟬date#1⟭ 12:48:39 ⟬ip_address#1⟭ GET /sitemap.xml - 443 - ⟬ip_address#19⟭ Mozilla/5.0+(compatible;+bingbot/2.0) 200 0 0 4 ctx="-"
⟬date#1⟭ 12:48:50 ⟬ip_address#1⟭ GET /locations county=⟬trap:word_name|Charlotte⟭ 443 - ⟬ip_address#19⟭ Mozilla/5.0+(compatible;+bingbot/2.0) 200 0 0 19 ctx="-"
⟬date#1⟭ 12:49:02 ⟬ip_address#1⟭ POST /session/login - 443 - ⟬ip_address#20⟭ Mozilla/5.0+(Windows+NT+10.0;+Win64;+x64) 200 0 0 366 ctx="email=⟬email#20⟭ pwd=⟬password#1⟭"
⟬date#1⟭ 12:49:03 ⟬ip_address#1⟭ GET /my/vehicles session=⟬jwt#2⟭ 443 - ⟬ip_address#20⟭ Mozilla/5.0+(Windows+NT+10.0;+Win64;+x64) 200 0 0 83 ctx="-"
⟬date#1⟭ 12:49:21 ⟬ip_address#1⟭ GET /my/vehicles/history session=⟬jwt#2⟭ 443 - ⟬ip_address#20⟭ Mozilla/5.0+(Windows+NT+10.0;+Win64;+x64) 200 0 0 74 ctx="plate=⟬us_license_plate#20⟭"
⟬date#1⟭ 12:49:48 ⟬ip_address#1⟭ POST /session/logout - 443 - ⟬ip_address#20⟭ Mozilla/5.0+(Windows+NT+10.0;+Win64;+x64) 302 0 0 12 ctx="-"
⟬date#1⟭ 12:50:05 ⟬ip_address#1⟭ GET /health - 443 - ⟬ip_address#3⟭ AlwaysOn 200 0 0 1 ctx="-"
⟬date#1⟭ 12:50:22 ⟬ip_address#1⟭ POST /session/login - 443 - ⟬ip_address#21⟭ Mozilla/5.0+(X11;+Linux+x86_64) 401 0 0 340 ctx="email=⟬email#21⟭ pwd=⟬password#2⟭"
⟬date#1⟭ 12:50:29 ⟬ip_address#1⟭ POST /session/login - 443 - ⟬ip_address#21⟭ Mozilla/5.0+(X11;+Linux+x86_64) 401 0 0 336 ctx="email=⟬email#21⟭ pwd=⟬password#3⟭"
⟬date#1⟭ 12:50:44 ⟬ip_address#1⟭ POST /session/forgot - 443 - ⟬ip_address#21⟭ Mozilla/5.0+(X11;+Linux+x86_64) 202 0 0 104 ctx="email=⟬email#21⟭"
⟬date#1⟭ 12:51:10 ⟬ip_address#1⟭ GET /session/reset code=⟬opaque_token#4⟭ 443 - ⟬ip_address#21⟭ Mozilla/5.0+(X11;+Linux+x86_64) 200 0 0 25 ctx="-"
⟬date#1⟭ 12:51:37 ⟬ip_address#1⟭ POST /session/reset - 443 - ⟬ip_address#21⟭ Mozilla/5.0+(X11;+Linux+x86_64) 302 0 0 197 ctx="pwd=⟬password#4⟭"
⟬date#1⟭ 12:52:02 ⟬ip_address#1⟭ GET /disabled-placard/status case=⟬ticket_id#2⟭ 443 - ⟬ip_address#22⟭ Mozilla/5.0+(iPhone;+CPU+iPhone+OS+16_7) 200 0 0 42 ctx="doctor=⟬person_name#22⟭"
⟬date#1⟭ 12:52:30 ⟬ip_address#1⟭ POST /disabled-placard/upload - 443 - ⟬ip_address#22⟭ Mozilla/5.0+(iPhone;+CPU+iPhone+OS+16_7) 201 0 0 811 ctx="file=⟬file_path#1⟭"
⟬date#1⟭ 12:53:05 ⟬ip_address#1⟭ GET /health - 443 - ⟬ip_address#3⟭ AlwaysOn 200 0 0 1 ctx="-"
⟬date#1⟭ 12:53:19 ⟬ip_address#1⟭ POST /api/police/plate-check - 443 ⟬username#3⟭ ⟬ip_address#23⟭ PatrolBridge/⟬version#2⟭ 200 0 0 61 ctx="plate=⟬us_license_plate#23⟭"
⟬date#1⟭ 12:53:21 ⟬ip_address#1⟭ POST /api/police/dl-check - 443 ⟬username#3⟭ ⟬ip_address#23⟭ PatrolBridge/⟬version#2⟭ 200 0 0 58 ctx="dl=⟬us_driver_license#23⟭"
⟬date#1⟭ 12:53:50 ⟬ip_address#1⟭ GET /forms/hsmv-82040.pdf - 443 - ⟬ip_address#24⟭ Mozilla/5.0+(Windows+NT+10.0;+Win64;+x64) 200 0 0 112 ctx="-"
⟬date#1⟭ 12:54:06 ⟬ip_address#1⟭ POST /feedback - 443 - ⟬ip_address#24⟭ Mozilla/5.0+(Windows+NT+10.0;+Win64;+x64) 201 0 0 49 ctx="msg=clerk ⟬person_name#25⟭ at the ⟬trap:word_name|Austin⟭ office was very helpful"
⟬date#1⟭ 12:54:41 ⟬ip_address#1⟭ GET /renew/start - 443 - ⟬ip_address#26⟭ Mozilla/5.0+(Linux;+Android+14) 200 0 0 44 ctx="-"
⟬date#1⟭ 12:55:02 ⟬ip_address#1⟭ POST /renew/lookup - 443 - ⟬ip_address#26⟭ Mozilla/5.0+(Linux;+Android+14) 503 0 64 2004 ctx="plate=⟬us_license_plate#26⟭ zip=⟬postcode#26⟭"
⟬date#1⟭ 12:55:09 ⟬ip_address#1⟭ POST /renew/lookup - 443 - ⟬ip_address#26⟭ Mozilla/5.0+(Linux;+Android+14) 200 0 0 322 ctx="plate=⟬us_license_plate#26⟭ zip=⟬postcode#26⟭"
⟬date#1⟭ 12:56:05 ⟬ip_address#1⟭ GET /health - 443 - ⟬ip_address#3⟭ AlwaysOn 200 0 0 1 ctx="-"
⟬date#1⟭ 12:57:16 ⟬ip_address#1⟭ GET /admin/reports/daily - 443 DMV\⟬username#1⟭ ⟬ip_address#10⟭ python-requests/2.31.0 200 0 0 208 ctx="-"
⟬date#1⟭ 12:58:44 ⟬ip_address#1⟭ POST /admin/mail-batch/close - 443 DMV\⟬username#1⟭ ⟬ip_address#10⟭ python-requests/2.31.0 200 0 0 36 ctx="batch=⟬uuid#3⟭"
⟬date#1⟭ 12:59:05 ⟬ip_address#1⟭ GET /health - 443 - ⟬ip_address#3⟭ AlwaysOn 200 0 0 1 ctx="-"
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: en
fill_locale: en_US
domain: travel
appearance: Azure DevOps task header, build output, masked variable, code identifier
scenario: Azure DevOps build of a fare rules engine, with test results and a package push under a masked variable, and no sensitive value at all
⟬text⟭
##[section]Starting: Build fare-rules
==============================================================================
Task         : Command line
Description  : Run a command line script using Bash on Linux and macOS and cmd.exe on Windows
Version      : 2.237.0
⟬trap:indicator_non_pii|Author       : Microsoft Corporation⟭
Help         : https://docs.microsoft.com/azure/devops/pipelines/tasks/utility/command-line
==============================================================================
Generating script.
Script contents:
dotnet build FareRules.sln -c Release
========================== Starting Command Output ===========================
  Determining projects to restore...
  Restored /home/vsts/work/1/s/src/FareRules.Core/FareRules.Core.csproj (in 1.12 sec).
  FareRules.Core -> /home/vsts/work/1/s/src/FareRules.Core/bin/Release/net8.0/FareRules.Core.dll
  FareRules.Tests -> /home/vsts/work/1/s/tests/FareRules.Tests/bin/Release/net8.0/FareRules.Tests.dll
Build succeeded.
    0 Warning(s)
    0 Error(s)
##[section]Finishing: Build fare-rules
##[section]Starting: Test fare-rules
Starting test execution, please wait...
Passed!  - Failed:     0, Passed:   512, Skipped:     3, Total:   515, Duration: 11 s
  Skipped ⟬trap:code_identifier|Fare_Rounds_With_⦃Family⦄_Table⟭
  Skipped ⟬trap:code_identifier|Route_Uses_DijkstraFallback⟭
  Skipped ⟬trap:code_identifier|Tax_Sydney_Departure_Surcharge⟭
##[section]Finishing: Test fare-rules
##[section]Starting: Push package
Package source: ⟬url#1⟭
Authenticating as ⟬trap:indicator_non_pii|user=build-agent⟭
Access token: ⟬trap:placeholder|***⟭
Pushing package FareRules.Core version ⟬version#1⟭
Your package was pushed.
##[section]Finishing: Push package
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: en
fill_locale: en_US
domain: fintech
appearance: CEF event, key=value, audit trail, secret under an innocuous key
scenario: CEF events of a card vault, where support staff and a reconciliation robot unmask PANs and SSNs, each with its reason
⟬text⟭
CEF:0|Ledgerline|CardVault|⟬version#1⟭|100|LoginSuccess|3|rt=⟬date#1⟭ 10:02:41 suser=⟬person_name:handle#1⟭ src=⟬ip_address#1⟭ cs1Label=mfa cs1=webauthn
CEF:0|Ledgerline|CardVault|⟬version#1⟭|300|Detokenize|6|rt=⟬date#1⟭ 10:14:22 suser=⟬person_name:handle#1⟭ src=⟬ip_address#1⟭ cs1Label=pan cs1=⟬payment_card#2⟭ cs2Label=reason cs2=⟬ticket_id#1⟭
CEF:0|Ledgerline|CardVault|⟬version#1⟭|310|RevealSsn|7|rt=⟬date#1⟭ 10:15:03 suser=⟬person_name:handle#1⟭ src=⟬ip_address#1⟭ cs1Label=ssn cs1=⟬us_ssn#2⟭ cs2Label=reason cs2=⟬ticket_id#1⟭ msg=dispute call with ⟬person_name#2⟭
CEF:0|Ledgerline|CardVault|⟬version#1⟭|300|Detokenize|4|rt=⟬date#1⟭ 10:30:00 suser=⟬trap:indicator_non_pii|svc-recon⟭ src=⟬ip_address#2⟭ cs1Label=value cs1=⟬uuid#1⟭ cs2Label=reason cs2=nightly-recon
CEF:0|Ledgerline|CardVault|⟬version#1⟭|300|Detokenize|4|rt=⟬date#1⟭ 10:30:00 suser=⟬trap:indicator_non_pii|svc-recon⟭ src=⟬ip_address#2⟭ cs1Label=value cs1=⟬payment_card#3⟭ cs2Label=reason cs2=nightly-recon
CEF:0|Ledgerline|CardVault|⟬version#1⟭|320|ExportDenied|8|rt=⟬date#1⟭ 11:02:19 suser=⟬person_name:handle#4⟭ src=⟬ip_address#3⟭ cs1Label=reason cs1=role-missing msg=⟬person_name#4⟭ tried to export 500 PANs
CEF:0|Ledgerline|CardVault|⟬version#1⟭|330|KeyRotate|5|rt=⟬date#1⟭ 12:00:00 suser=⟬trap:indicator_non_pii|hsm-operator⟭ src=⟬ip_address#4⟭ cs1Label=key_id cs1=⟬hash#1⟭ cs2Label=wrap cs2=⟬opaque_token#1⟭
CEF:0|Ledgerline|CardVault|⟬version#1⟭|310|RevealSsn|7|rt=⟬date#1⟭ 13:41:50 suser=⟬person_name:handle#5⟭ src=⟬ip_address#5⟭ cs1Label=ssn cs1=⟬us_ssn#6⟭ cs2Label=reason cs2=⟬ticket_id#2⟭ msg=court order ⟬ticket_id#2⟭ for customer ⟬customer_id#6⟭
CEF:0|Ledgerline|CardVault|⟬version#1⟭|340|PolicyChange|6|rt=⟬date#1⟭ 15:26:07 suser=⟬trap:indicator_non_pii|policy-bot⟭ src=⟬ip_address#2⟭ cs1Label=policy cs1=max-reveals-per-day cs2Label=new cs2=20 msg=approved by ⟬person_name#7⟭
CEF:0|Ledgerline|CardVault|⟬version#1⟭|110|Logout|2|rt=⟬date#1⟭ 17:55:12 suser=⟬person_name:handle#1⟭ src=⟬ip_address#1⟭ cs1Label=reveals cs1=2
CEF:0|Ledgerline|CardVault|⟬version#1⟭|350|ChainCheck|3|rt=⟬date#1⟭ 23:59:00 suser=⟬trap:indicator_non_pii|svc-audit⟭ src=⟬ip_address#2⟭ cs1Label=root cs1=⟬hash#2⟭ cs2Label=events cs2=11
CEF:0|Ledgerline|CardVault|⟬version#1⟭|300|Detokenize|5|rt=⟬date#1⟭ 23:59:30 suser=⟬trap:indicator_non_pii|svc-recon⟭ src=⟬ip_address#2⟭ cs1Label=value cs1=⟬payment_card#8⟭ cs2Label=reason cs2=chargeback ⟬order_number#1⟭
CEF:0|Ledgerline|CardVault|⟬version#1⟭|370|MaskingToggle|6|rt=⟬date#1⟭ 23:59:35 suser=⟬trap:indicator_non_pii|policy-bot⟭ src=⟬ip_address#2⟭ cs1Label=⟬trap:indicator_non_pii|ssn_masking⟭ cs1=on
CEF:0|Ledgerline|CardVault|⟬version#1⟭|300|Detokenize|5|rt=⟬date#1⟭ 23:59:37 suser=⟬person_name:handle#9⟭ src=⟬ip_address#6⟭ cs1Label=ref cs1=⟬payment_card#9⟭ cs2Label=reason cs2=⟬ticket_id#3⟭
CEF:0|Ledgerline|CardVault|⟬version#1⟭|300|Detokenize|5|rt=⟬date#1⟭ 23:59:38 suser=⟬person_name:handle#9⟭ src=⟬ip_address#6⟭ cs1Label=ref cs1=⟬order_number#2⟭ cs2Label=reason cs2=⟬ticket_id#3⟭
CEF:0|Ledgerline|CardVault|⟬version#1⟭|310|RevealSsn|7|rt=⟬date#1⟭ 23:59:39 suser=⟬person_name:handle#9⟭ src=⟬ip_address#6⟭ cs1Label=ssn cs1=⟬us_ssn#9⟭ cs2Label=reason cs2=⟬ticket_id#3⟭
CEF:0|Ledgerline|CardVault|⟬version#1⟭|360|SiemForward|2|rt=⟬date#1⟭ 23:59:40 suser=⟬trap:indicator_non_pii|svc-audit⟭ src=⟬ip_address#2⟭ cs1Label=dest cs1=⟬hostname#1⟭ cs2Label=lag_ms cs2=118
CEF:0|Ledgerline|CardVault|⟬version#1⟭|360|SiemForward|2|rt=⟬date#1⟭ 23:59:50 suser=⟬trap:indicator_non_pii|svc-audit⟭ src=⟬ip_address#2⟭ cs1Label=dest cs1=⟬hostname#1⟭ cs2Label=lag_ms cs2=121
⟬end⟭

⟬template⟭
family: logs
format: application log
language: en
fill_locale: en_US
domain: retail
appearance: Python logging line, color names, company named after a family
scenario: inventory feed of a jewellery and homeware chain, where rose gold, hazel and supplier names look like people but no entity is present
⟬text⟭
⟬date#1⟭ 05:30:00 INFO feed.sync: pulling supplier catalog from ⟬url#1⟭
⟬date#1⟭ 05:30:04 INFO feed.sync: ⟬trap:company_name|Tiffany⟭ gift line skipped, not contracted this season
⟬date#1⟭ 05:30:06 INFO feed.sync: 812 SKUs updated, finish=⟬trap:word_name|Rose⟭ gold replaced by finish=⟬trap:word_name|Hazel⟭ brass on 14 items
⟬date#1⟭ 05:30:07 WARN feed.sync: ⟬trap:indicator_non_pii|customer=none⟭ on 3 reserved lines, releasing stock
⟬date#1⟭ 05:30:09 INFO feed.sync: done in 9.1s, snapshot ⟬hash#1⟭
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: en
fill_locale: en_US
domain: government
appearance: Laravel log line, SQL error detail, PHP stack frames
scenario: Laravel error on a county voter registration form, whose duplicate key message prints the insert with the voter's SSN, license, birth date and address
⟬text⟭
[⟬date#1⟭ 09:22:14] production.ERROR: SQLSTATE[23000]: Integrity constraint violation: 1062 Duplicate entry '⟬us_ssn#1⟭' for key 'voters.ssn_unique' (Connection: mysql, SQL: insert into `voters` (`full_name`, `ssn`, `dl_number`, `dob`, `residence`, `registered_at`) values ("⟬person_name#1⟭", "⟬us_ssn#1⟭", "⟬us_driver_license#1⟭", "⟬birth_date#1⟭", "⟬postal_address#1⟭", "⟬date#1⟭ 09:22:14")) {"url":"⟬url#1⟭","ip":"⟬ip_address#1⟭","userId":null,"exception":"[object] (Illuminate\\Database\\UniqueConstraintViolationException(code: 23000))"}
[stacktrace]
#0 /var/www/voters/vendor/laravel/framework/src/Illuminate/Database/Connection.php(795): Illuminate\\Database\\Connection->runQueryCallback()
#1 /var/www/voters/vendor/laravel/framework/src/Illuminate/Database/Connection.php(555): Illuminate\\Database\\Connection->run()
#2 /var/www/voters/vendor/laravel/framework/src/Illuminate/Database/Query/Builder.php(3546): Illuminate\\Database\\Connection->insert()
#3 /var/www/voters/app/Services/RegistrationService.php(71): Illuminate\\Database\\Query\\Builder->insert()
#4 /var/www/voters/app/Http/Controllers/RegisterController.php(44): App\\Services\\RegistrationService->store()
#5 /var/www/voters/vendor/laravel/framework/src/Illuminate/Routing/Controller.php(54): App\\Http\\Controllers\\RegisterController->submit()
#6 /var/www/voters/vendor/laravel/framework/src/Illuminate/Routing/ControllerDispatcher.php(43): Illuminate\\Routing\\Controller->callAction()
#7 /var/www/voters/vendor/laravel/framework/src/Illuminate/Routing/Route.php(260): Illuminate\\Routing\\ControllerDispatcher->dispatch()
#8 /var/www/voters/vendor/laravel/framework/src/Illuminate/Routing/Router.php(808): Illuminate\\Routing\\Route->run()
#9 /var/www/voters/vendor/laravel/framework/src/Illuminate/Pipeline/Pipeline.php(141): Illuminate\\Routing\\Router->dispatchToRoute()
#10 /var/www/voters/public/index.php(51): Illuminate\\Foundation\\Http\\Kernel->handle()
#11 {main}

Previous exception: PDOException(code: 23000): SQLSTATE[23000]: Duplicate entry '⟬us_ssn#1⟭' for key 'voters.ssn_unique' at /var/www/voters/vendor/laravel/framework/src/Illuminate/Database/Connection.php:580
[previous exception] [object] (PDOException(code: 23000))
Precinct lookup was: county=⟬trap:word_name|Madison⟭ precinct=0417 clerk=⟬trap:indicator_non_pii|online-portal⟭
⟬end⟭

⟬template⟭
family: logs
format: test output
language: en
fill_locale: en_US
domain: travel
appearance: RSpec failure, inspect string, test fixture
scenario: RSpec failure of a passport expiry rule at a tour operator, showing the fixture traveler in an inspect string
⟬text⟭
Failures:

  1) PassportExpiryCheck blocks passports expiring within six months
     Failure/Error: expect(result).to be_blocked

       expected `#<Traveler name="⟬person_name#1⟭" passport="⟬us_passport#1⟭" expires="⟬date#1⟭" tour="⟬trap:word_name|Florence⟭ and Siena">.blocked?` to be truthy, got false
     # ./spec/services/passport_expiry_check_spec.rb:27:in `block (2 levels) in <top (required)>'

Finished in 0.418 seconds (files took 2.06 seconds to load)
12 examples, 1 failure

rspec ./spec/services/passport_expiry_check_spec.rb:21 # PassportExpiryCheck blocks passports expiring within six months
⟬end⟭

⟬template⟭
family: logs
format: access log
language: en
fill_locale: en_US
domain: fintech
appearance: HAProxy line, captured request header, password in a query string, secret under an innocuous key
scenario: HAProxy of a payments API capturing the Authorization and X-Client-Ref headers, with a legacy login that carries the password in the query string
⟬text⟭
⟬date#1⟭ 16:20:11 lb-1 haproxy[812]: ⟬ip_address#1⟭ 51422 [16:20:11.204] fe_api~ be_ledger/app03 0/0/1/44/45 200 812 - - ---- 88/41/3/1/0 {Bearer ⟬jwt#1⟭|⟬opaque_token#1⟭} "GET /v1/accounts/⟬customer_id#2⟭/balance HTTP/1.1"
⟬date#1⟭ 16:20:11 lb-1 haproxy[812]: ⟬ip_address#1⟭ 51423 [16:20:11.512] fe_api~ be_ledger/app01 0/0/1/71/72 201 304 - - ---- 88/41/2/0/0 {Bearer ⟬jwt#1⟭|⟬opaque_token#1⟭} "POST /v1/transfers HTTP/1.1"
⟬date#1⟭ 16:20:12 lb-1 haproxy[812]: ⟬ip_address#2⟭ 40188 [16:20:12.007] fe_api~ be_auth/auth02 0/0/1/120/121 200 410 - - ---- 90/42/1/0/0 {-|-} "GET /legacy/login?user=⟬person_name:handle#3⟭&password=⟬url_password#1⟭ HTTP/1.1"
⟬date#1⟭ 16:20:12 lb-1 haproxy[812]: ⟬ip_address#3⟭ 40190 [16:20:12.340] fe_api~ be_auth/auth02 0/0/1/118/119 401 96 - - ---- 91/42/1/0/0 {-|-} "GET /legacy/login?user=⟬trap:indicator_non_pii|sandbox⟭&password=⟬url_password#2⟭ HTTP/1.1"
⟬date#1⟭ 16:20:13 lb-1 haproxy[812]: ⟬ip_address#4⟭ 33012 [16:20:13.118] fe_api~ be_webhook/hook01 0/0/0/9/9 202 22 - - ---- 92/43/1/0/0 {Basic ⟬opaque_token#2⟭|-} "POST /hooks/ach/return HTTP/1.1"
⟬date#1⟭ 16:20:14 lb-1 haproxy[812]: ⟬ip_address#5⟭ 33114 [16:20:14.002] fe_api~ be_ledger/app02 0/0/1/38/39 200 1204 - - ---- 92/43/2/0/0 {Bearer ⟬jwt#2⟭|⟬uuid#1⟭} "GET /v1/statements?month=03&download_token=⟬opaque_token#3⟭ HTTP/1.1"
⟬date#1⟭ 16:20:14 lb-1 haproxy[812]: ⟬ip_address#6⟭ 60414 [16:20:14.610] fe_api~ be_ledger/app02 0/0/1/12/13 403 64 - - ---- 93/43/2/0/0 {Bearer ⟬jwt#3⟭|⟬order_number#1⟭} "GET /v1/accounts/⟬customer_id#7⟭/owners HTTP/1.1"
⟬date#1⟭ 16:20:15 lb-1 haproxy[812]: ⟬ip_address#7⟭ 41007 [16:20:15.206] fe_admin~ be_admin/adm01 0/0/1/88/89 200 3120 - - ---- 94/2/1/0/0 {Bearer ⟬jwt#4⟭|-} "GET /admin/customers?email=⟬email#8⟭ HTTP/1.1"
⟬date#1⟭ 16:20:16 lb-1 haproxy[812]: ⟬ip_address#7⟭ 41009 [16:20:16.019] fe_admin~ be_admin/adm01 0/0/1/64/65 200 2204 - - ---- 94/2/1/0/0 {Bearer ⟬jwt#4⟭|-} "GET /admin/customers/⟬customer_id#8⟭/kyc HTTP/1.1"
⟬date#1⟭ 16:20:18 lb-1 haproxy[812]: ⟬ip_address#8⟭ 52311 [16:20:18.450] fe_api~ be_kyc/kyc01 0/0/1/402/403 200 188 - - ---- 95/44/1/0/0 {Bearer ⟬opaque_token#4⟭|⟬opaque_token#5⟭} "POST /v1/kyc/verify HTTP/1.1"
⟬date#1⟭ 16:20:20 lb-1 haproxy[812]: ⟬ip_address#9⟭ 52402 [16:20:20.004] fe_api~ be_ledger/<NOSRV> 0/-1/-1/-1/0 503 212 - - SC-- 96/44/0/0/0 {-|-} "GET /v1/fx/rates HTTP/1.1"
⟬date#1⟭ 16:20:21 lb-1 haproxy[812]: ⟬ip_address#10⟭ 58120 [16:20:21.144] fe_api~ be_health/hc 0/0/0/1/1 200 2 - - ---- 96/44/1/0/0 {-|-} "GET /healthz HTTP/1.1"
⟬date#1⟭ 16:20:22 lb-1 haproxy[812]: ⟬ip_address#2⟭ 40244 [16:20:22.380] fe_api~ be_auth/auth01 0/0/1/115/116 200 410 - - ---- 96/44/1/0/0 {-|-} "GET /legacy/login?user=⟬email#11⟭&password=⟬url_password#3⟭ HTTP/1.1"
⟬date#1⟭ 16:20:23 lb-1 haproxy[812]: ⟬ip_address#1⟭ 51490 [16:20:23.611] fe_api~ be_ledger/app03 0/0/1/29/30 200 640 - - ---- 96/44/2/0/0 {Bearer ⟬jwt#1⟭|⟬opaque_token#1⟭} "GET /v1/transfers/⟬uuid#2⟭ HTTP/1.1"
⟬date#1⟭ 16:20:25 lb-1 haproxy[812]: ⟬ip_address#12⟭ 44018 [16:20:25.902] fe_api~ be_partner/p01 0/0/2/210/212 200 96 - - ---- 97/44/1/0/0 {Bearer ⟬opaque_token#6⟭|⟬order_number#2⟭} "POST /partner/v2/payouts/⟬uuid#3⟭/confirm?otp_ref=⟬uuid#4⟭ HTTP/1.1"
⟬date#1⟭ 16:20:26 lb-1 haproxy[812]: ⟬ip_address#13⟭ 44102 [16:20:26.118] fe_api~ be_auth/auth01 0/0/1/97/98 200 288 - - ---- 97/44/1/0/0 {Basic ⟬opaque_token#7⟭|-} "POST /oauth/token?grant_type=client_credentials HTTP/1.1"
⟬date#1⟭ 16:20:27 lb-1 haproxy[812]: ⟬ip_address#10⟭ 58190 [16:20:27.144] fe_api~ be_health/hc 0/0/0/1/1 200 2 - - ---- 97/44/1/0/0 {-|-} "GET /healthz HTTP/1.1"
⟬date#1⟭ 16:20:28 lb-1 haproxy[812]: ⟬ip_address#14⟭ 39004 [16:20:28.702] fe_api~ be_ledger/app01 0/0/1/55/56 200 980 - - ---- 98/45/2/0/0 {Bearer ⟬jwt#5⟭|⟬opaque_token#8⟭} "GET /v1/cards/⟬uuid#5⟭/transactions?limit=50 HTTP/1.1"
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: en
fill_locale: en_US
domain: SaaS
appearance: helm --debug output, YAML value, shell trace, release named after a person
scenario: Buildkite step upgrading a billing chart with helm --debug, which prints the user-supplied values and hooks with database password, signing key and service JWT
⟬text⟭
--- :helm: Upgrading billing-api
+ helm upgrade --install billing-api charts/billing-api --namespace prod --debug --set image.tag=⟬version#1⟭
history.go:56: [debug] getting history for release billing-api
upgrade.go:144: [debug] preparing upgrade for billing-api
Release "billing-api" has been upgraded. Happy Helming!
NAME: billing-api
LAST DEPLOYED: ⟬date#1⟭ 18:44:02
NAMESPACE: prod
STATUS: deployed
REVISION: 212
USER-SUPPLIED VALUES:
codename: ⟬trap:eponym|⦃given⦄⟭
database:
  host: ⟬hostname#1⟭
  user: ⟬trap:indicator_non_pii|billing_app⟭
  password: ⟬password#1⟭
invoicing:
  signing:
    kid: ⟬hash#1⟭
    value: ⟬opaque_token#1⟭
  owner: ⟬trap:indicator_non_pii|payments-team⟭
serviceAuth:
  audience: billing
  bearer: ⟬jwt#1⟭
mail:
  from: ⟬email:generic#1⟭
  relayPassword: ⟬trap:placeholder|${MAIL_RELAY_PASSWORD}⟭
HOOKS:
---
# Source: billing-api/templates/migrate-job.yaml
    command: ["./migrate", "--dsn", "postgres://billing_app:⟬url_password#1⟭@⟬hostname#1⟭:5432/billing"]
--- :white_check_mark: Smoke test
+ curl -fsS -H "Authorization: Bearer ⟬jwt#1⟭" ⟬url#1⟭
{"status":"ok"}
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: en
fill_locale: en_US
domain: healthcare
appearance: RFC 5424 syslog, structured data, audit trail, bulk export
scenario: FHIR server audit in RFC 5424 syslog during a nightly bulk export run by system clients, with resource counts and no patient reference
⟬text⟭
<86>1 ⟬date#1⟭ 22:00:01 fhir-1 audit 4112 BULK [client id="svc-bulk-export" scope="system/Patient.read"] kickoff accepted job=⟬uuid#1⟭
<86>1 ⟬date#1⟭ 22:00:02 fhir-1 audit 4112 BULK [client id="svc-bulk-export" scope="system/Observation.read"] kickoff accepted job=⟬uuid#1⟭
<86>1 ⟬date#1⟭ 22:04:19 fhir-1 audit 4112 BULK [client id="svc-bulk-export"] resource=Patient ndjson_lines=41822 ⟬trap:indicator_non_pii|patient_identifiers=tokenized⟭
<86>1 ⟬date#1⟭ 22:09:51 fhir-1 audit 4112 BULK [client id="svc-bulk-export"] resource=Observation ndjson_lines=902114 ⟬trap:indicator_non_pii|subject_reference=hashed⟭
<86>1 ⟬date#1⟭ 22:10:02 fhir-1 audit 4112 BULK [client id="svc-bulk-export"] manifest=⟬url#1⟭ checksum=⟬hash#1⟭
<85>1 ⟬date#1⟭ 22:12:40 fhir-1 audit 4112 AUTH [client id="svc-quality-reports" ip="⟬ip_address#1⟭"] token issued ⟬trap:indicator_non_pii|token_ttl=300⟭ ⟬trap:indicator_non_pii|user=none⟭
<85>1 ⟬date#1⟭ 22:12:43 fhir-1 audit 4112 READ [client id="svc-quality-reports"] GET Measure/hba1c-control 200
<85>1 ⟬date#1⟭ 22:12:47 fhir-1 audit 4112 READ [client id="svc-quality-reports"] GET MeasureReport?period=last-quarter 200 total=12
<85>1 ⟬date#1⟭ 22:30:00 fhir-1 audit 4112 CONFIG [client id="svc-terminology"] ValueSet updated version=⟬version#1⟭ source=⟬url#2⟭
<85>1 ⟬date#1⟭ 22:30:04 fhir-1 audit 4112 CONFIG [client id="svc-terminology"] ConceptMap reloaded loinc_to_local entries=8120
<84>1 ⟬date#1⟭ 22:45:17 fhir-2 audit 3880 AUTH [client id="svc-claims-feed" ip="⟬ip_address#2⟭"] token refused reason=expired_client_assertion ⟬trap:indicator_non_pii|owner=integration-team⟭
<85>1 ⟬date#1⟭ 22:46:02 fhir-2 audit 3880 AUTH [client id="svc-claims-feed" ip="⟬ip_address#2⟭"] token issued after rotation, kid=⟬hash#2⟭
<85>1 ⟬date#1⟭ 23:00:00 fhir-1 audit 4112 PURGE [client id="system"] bulk files older than 24h removed count=6
<85>1 ⟬date#1⟭ 23:30:00 fhir-1 audit 4112 CHAIN [client id="system"] segment ⟬uuid#2⟭ sealed, ⟬trap:eponym|Merkle⟭ root=⟬hash#3⟭
<85>1 ⟬date#1⟭ 23:30:03 fhir-1 audit 4112 CHAIN [client id="system"] forwarded to ⟬hostname#1⟭ lag_ms=210
<85>1 ⟬date#1⟭ 23:59:59 fhir-1 audit 4112 STATS [client id="system"] reads=944120 writes=0 denied=1 version=⟬version#2⟭
⟬end⟭

⟬template⟭
family: logs
format: application log
language: en
fill_locale: en_US
domain: travel
appearance: fixed-width message, sorter telegram, airport code
scenario: baggage sorter gateway at a regional airport, relaying routing telegrams with tag ranges and destinations only
⟬text⟭
⟬date#1⟭ 04:12:01 BSM-GW [sort-2] telegram BPM tagrange=0016 dest=CLT lane=07 count=44
⟬date#1⟭ 04:12:03 BSM-GW [sort-2] telegram BPM tagrange=0016 dest=AUS lane=11 count=19
⟬date#1⟭ 04:12:09 BSM-GW [sort-1] jam cleared belt=C3 duration_s=41 ⟬trap:indicator_non_pii|operator=shift-a⟭
⟬date#1⟭ 04:12:30 BSM-GW [sort-2] telegram BSM rejected, ⟬trap:indicator_non_pii|passenger_name=NONE⟭ tagrange=0017
⟬date#1⟭ 04:12:31 BSM-GW [sort-2] carousel ⟬trap:word_name|Sydney⟭ connection desk notified
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: en
fill_locale: en_US
domain: fintech
appearance: Node.js error, nested JSON, stack frames
scenario: Node error of a card issuing API, whose message embeds the JSON body sent to the tokenizer with PAN and security code
⟬text⟭
Error: tokenization failed, body {"pan":"⟬payment_card#1⟭","cvc":"⟬card_security_code#1⟭","cardholder":"⟬person_name#1⟭"}: gateway returned 502
    at TokenizerClient.tokenize (/srv/app/dist/tokenizer.js:88:13)
    at processTicksAndRejections (node:internal/process/task_queues:95:5)
    at async PaymentService.attachCard (/srv/app/dist/payment.service.js:41:17)
    at async /srv/app/dist/routes/cards.js:27:20
⟬end⟭

⟬template⟭
family: logs
format: test output
language: en
fill_locale: en_US
domain: SaaS
appearance: pytest verbose output, parametrized test ids, code identifier, stand-in values
scenario: verbose pytest run of a log scrubbing library, with parameter ids that name emails, tokens and users but only hold stand-ins, and no real entity
⟬text⟭
============================= test session starts ==============================
platform linux -- Python 3.11.7, pytest-8.0.0, pluggy-1.4.0 -- /opt/venv/bin/python
cachedir: .pytest_cache
rootdir: /builds/platform/scrubber
plugins: cov-4.1.0, xdist-3.5.0
collecting ... collected 58 items

tests/test_config.py::test_defaults PASSED                               [  1%]
tests/test_config.py::test_env_override PASSED                           [  3%]
tests/test_config.py::test_unknown_key_rejected PASSED                   [  5%]
tests/test_config.py::test_mask_char[*] PASSED                           [  6%]
tests/test_config.py::test_mask_char[#] PASSED                           [  8%]
tests/test_config.py::test_mask_char[x] PASSED                           [ 10%]
tests/test_patterns.py::test_email_pattern[⟬trap:indicator_non_pii|<email>⟭] PASSED      [ 12%]
tests/test_patterns.py::test_email_pattern[⟬trap:indicator_non_pii|email=NONE⟭] PASSED   [ 13%]
tests/test_patterns.py::test_email_pattern[⟬trap:email_lookalike|@types/node⟭] PASSED    [ 15%]
tests/test_patterns.py::test_email_pattern[⟬trap:email_lookalike|deploy@staging⟭] PASSED [ 17%]
tests/test_patterns.py::test_token_pattern[⟬trap:placeholder|<token>⟭] PASSED      [ 18%]
tests/test_patterns.py::test_token_pattern[⟬trap:placeholder|${API_TOKEN}⟭] PASSED [ 20%]
tests/test_patterns.py::test_token_pattern[⟬trap:placeholder|xxxx-xxxx⟭] PASSED    [ 22%]
tests/test_patterns.py::test_token_pattern[⟬trap:indicator_non_pii|token_ttl=3600⟭] PASSED [ 24%]
tests/test_patterns.py::test_password_pattern[⟬trap:placeholder|%(password)s⟭] PASSED    [ 25%]
tests/test_patterns.py::test_password_pattern[⟬trap:placeholder|********⟭] PASSED        [ 27%]
tests/test_patterns.py::test_password_pattern[⟬trap:indicator_non_pii|password_min_length=12⟭] PASSED [ 29%]
tests/test_patterns.py::test_user_pattern[⟬trap:indicator_non_pii|user=admin⟭] PASSED    [ 31%]
tests/test_patterns.py::test_user_pattern[⟬trap:indicator_non_pii|owner=platform-team⟭] PASSED [ 32%]
tests/test_patterns.py::test_user_pattern[⟬trap:indicator_non_pii|author=dependabot[bot]⟭] PASSED [ 34%]
tests/test_patterns.py::test_name_pattern[⟬trap:indicator_non_pii|<NAME>⟭] PASSED        [ 36%]
tests/test_patterns.py::test_name_pattern[⟬trap:indicator_non_pii|name=PERSON_0001⟭] PASSED [ 37%]
tests/test_rules.py::test_rule_order PASSED                              [ 39%]
tests/test_rules.py::test_rule_merge PASSED                              [ 41%]
tests/test_rules.py::test_rule_disable PASSED                            [ 43%]
tests/test_rules.py::⟬trap:code_identifier|test_levenshtein_near_match⟭ PASSED    [ 44%]
tests/test_rules.py::⟬trap:code_identifier|test_luhn_rejects_short_numbers⟭ PASSED [ 46%]
tests/test_rules.py::⟬trap:code_identifier|test_⦃family⦄_edge_case⟭ FAILED         [ 48%]
tests/test_rules.py::test_overlap_widest_wins PASSED                     [ 50%]
tests/test_stream.py::test_chunk_boundaries PASSED                       [ 51%]
tests/test_stream.py::test_utf8_split PASSED                             [ 53%]
tests/test_stream.py::test_flush_on_close PASSED                         [ 55%]
tests/test_stream.py::test_backpressure PASSED                           [ 56%]
tests/test_stream.py::test_large_line SKIPPED (slow)                     [ 58%]
tests/test_stream.py::test_binary_passthrough PASSED                     [ 60%]
tests/test_stream.py::test_gzip_input PASSED                             [ 62%]
tests/test_stream.py::test_ndjson_input PASSED                           [ 63%]
tests/test_cli.py::test_help PASSED                                      [ 65%]
tests/test_cli.py::test_version PASSED                                   [ 67%]
tests/test_cli.py::test_dry_run PASSED                                   [ 68%]
tests/test_cli.py::test_exit_code_on_match PASSED                        [ 70%]
tests/test_cli.py::test_report_json PASSED                               [ 72%]
tests/test_cli.py::test_report_sarif PASSED                              [ 74%]
tests/test_plugins.py::test_load_entry_points PASSED                     [ 75%]
tests/test_plugins.py::test_plugin_order PASSED                          [ 77%]
tests/test_plugins.py::test_plugin_failure_isolated PASSED               [ 79%]
tests/test_plugins.py::⟬trap:code_identifier|test_⦃family⦄_plugin_compat⟭ PASSED  [ 81%]
tests/test_metrics.py::test_counter_labels PASSED                        [ 82%]
tests/test_metrics.py::test_histogram_buckets PASSED                     [ 84%]
tests/test_metrics.py::test_exporter_disabled PASSED                     [ 86%]
tests/test_metrics.py::test_exporter_push PASSED                         [ 87%]
tests/test_docs.py::test_examples_run PASSED                             [ 89%]
tests/test_docs.py::test_links PASSED                                    [ 91%]
tests/test_docs.py::test_changelog PASSED                                [ 93%]
tests/test_perf.py::test_throughput SKIPPED (slow)                       [ 94%]
tests/test_perf.py::test_memory SKIPPED (slow)                           [ 96%]
tests/test_perf.py::test_startup PASSED                                  [ 98%]
tests/test_perf.py::test_regex_cache PASSED                              [100%]

=================================== FAILURES ===================================
__________________________ ⟬trap:code_identifier|test_⦃family⦄_edge_case⟭ ___________________________
E   AssertionError: expected the ⟬trap:eponym|Damerau⟭ variant, got plain distance
tests/test_rules.py:88: AssertionError
=========================== short test summary info ============================
FAILED tests/test_rules.py::⟬trap:code_identifier|test_⦃family⦄_edge_case⟭
================== 1 failed, 54 passed, 3 skipped in 4.11s ====================
⟬end⟭

⟬template⟭
family: logs
format: access log
language: en
fill_locale: en_US
domain: healthcare
appearance: Apache combined log, custom context field, token in a query string, JWT in a query string
scenario: Apache access of a patient portal with a debug context field copying the SSN used for matching, and lab result links carrying a JWT and an access code
⟬text⟭
⟬ip_address#1⟭ - - [⟬date#1⟭ 07:31:02 -0500] "GET /portal/ HTTP/1.1" 200 6120 "-" "Mozilla/5.0 (iPhone; CPU iPhone OS 17_3 like Mac OS X)" ctx="-"
⟬ip_address#1⟭ - - [⟬date#1⟭ 07:31:20 -0500] "POST /portal/register HTTP/1.1" 200 412 "⟬url#1⟭" "Mozilla/5.0 (iPhone; CPU iPhone OS 17_3 like Mac OS X)" ctx="dob=⟬birth_date#2⟭ ssn=⟬us_ssn#2⟭ last=⟬person_name:family#2⟭"
⟬ip_address#1⟭ - - [⟬date#1⟭ 07:31:21 -0500] "GET /portal/register/match?mrn=⟬customer_id#2⟭ HTTP/1.1" 200 304 "⟬url#1⟭" "Mozilla/5.0 (iPhone; CPU iPhone OS 17_3 like Mac OS X)" ctx="score=0.98"
⟬ip_address#1⟭ - - [⟬date#1⟭ 07:31:48 -0500] "POST /portal/register/password HTTP/1.1" 302 0 "⟬url#1⟭" "Mozilla/5.0 (iPhone; CPU iPhone OS 17_3 like Mac OS X)" ctx="pw=⟬password#1⟭"
⟬ip_address#2⟭ - - [⟬date#1⟭ 07:32:05 -0500] "GET /health HTTP/1.1" 200 2 "-" "ELB-HealthChecker/2.0" ctx="-"
⟬ip_address#3⟭ - - [⟬date#1⟭ 07:32:11 -0500] "GET /results/view?token=⟬jwt#1⟭ HTTP/1.1" 200 22100 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 14_2) Safari/605.1.15" ctx="-"
⟬ip_address#3⟭ - - [⟬date#1⟭ 07:32:29 -0500] "GET /results/download?doc=⟬uuid#1⟭&code=⟬opaque_token#1⟭ HTTP/1.1" 200 188204 "⟬url#2⟭" "Mozilla/5.0 (Macintosh; Intel Mac OS X 14_2) Safari/605.1.15" ctx="-"
⟬ip_address#4⟭ - ⟬person_name:handle#4⟭ [⟬date#1⟭ 07:33:02 -0500] "GET /staff/schedule HTTP/1.1" 200 8120 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Edge/121.0" ctx="-"
⟬ip_address#4⟭ - ⟬person_name:handle#4⟭ [⟬date#1⟭ 07:33:40 -0500] "GET /staff/chart/⟬customer_id#5⟭ HTTP/1.1" 200 41200 "⟬url#3⟭" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Edge/121.0" ctx="patient=⟬person_name#5⟭"
⟬ip_address#5⟭ - - [⟬date#1⟭ 07:34:12 -0500] "POST /portal/forms/insurance HTTP/1.1" 200 288 "⟬url#4⟭" "Mozilla/5.0 (Linux; Android 14) Chrome/120.0" ctx="subscriber=⟬person_name#6⟭ ssn=⟬us_ssn#6⟭ addr=⟬postal_address#6⟭"
⟬ip_address#6⟭ - - [⟬date#1⟭ 07:34:50 -0500] "GET /appointments/confirm?ref=⟬order_number#1⟭&sig=⟬opaque_token#2⟭ HTTP/1.1" 200 1204 "-" "Mozilla/5.0 (iPhone; CPU iPhone OS 16_7 like Mac OS X)" ctx="-"
⟬ip_address#7⟭ - - [⟬date#1⟭ 07:35:18 -0500] "GET /appointments/cancel?ref=⟬opaque_token#3⟭ HTTP/1.1" 200 980 "-" "Mozilla/5.0 (Linux; Android 13) Chrome/119.0" ctx="-"
⟬ip_address#2⟭ - - [⟬date#1⟭ 07:35:35 -0500] "GET /health HTTP/1.1" 200 2 "-" "ELB-HealthChecker/2.0" ctx="-"
⟬ip_address#8⟭ - - [⟬date#1⟭ 07:36:01 -0500] "GET /providers?specialty=cardiology&city=⟬trap:word_name|Charlotte⟭ HTTP/1.1" 200 5120 "-" "Mozilla/5.0 (compatible; Googlebot/2.1)" ctx="-"
⟬ip_address#8⟭ - - [⟬date#1⟭ 07:36:09 -0500] "GET /conditions/⟬trap:eponym|parkinsons-disease⟭ HTTP/1.1" 200 7204 "-" "Mozilla/5.0 (compatible; Googlebot/2.1)" ctx="-"
⟬ip_address#9⟭ - ⟬username#1⟭ [⟬date#1⟭ 07:37:44 -0500] "POST /api/hl7/push HTTP/1.1" 202 18 "-" "Mirth/⟬version#1⟭" ctx="batch=⟬uuid#2⟭"
⟬ip_address#10⟭ - - [⟬date#1⟭ 07:38:03 -0500] "GET /pharmacy/refill?rx=⟬order_number#2⟭&access_token=⟬jwt#2⟭ HTTP/1.1" 200 1820 "-" "HealthApp/⟬version#2⟭ (Android 14)" ctx="-"
⟬end⟭

⟬template⟭
family: logs
format: CI log
language: en
fill_locale: en_US
domain: retail
appearance: Jenkins pipeline stages, Playwright output, shell trace, test fixture, JWT in a job log, plate in a fixture
scenario: Jenkins end-to-end pipeline of a grocery store site, where a seed step and a failed Playwright run print a demo shopper's card, plate, address, password and a service JWT
⟬text⟭
Started by GitHub push by ⟬person_name:handle#1⟭
Obtained Jenkinsfile from git ⟬url#1⟭
[Pipeline] Start of Pipeline
[Pipeline] node
Running on ⟬hostname#1⟭ in /var/lib/jenkins/workspace/storefront-e2e
[Pipeline] { (Checkout)
[Pipeline] checkout
 > git rev-parse --resolve-git-dir /var/lib/jenkins/workspace/storefront-e2e/.git
 > git fetch --tags --force --progress -- origin +refs/heads/*:refs/remotes/origin/*
Checking out Revision ⟬git_sha#1⟭ (refs/remotes/origin/main)
Commit message: "curbside: keep the bay after a late arrival"
[Pipeline] } (Checkout)
[Pipeline] { (Install)
[Pipeline] sh
+ npm ci --no-audit
added 1412 packages in 38s
+ npx playwright install chromium
Downloading Chromium playwright build v1097 from ⟬url#2⟭
[Pipeline] } (Install)
[Pipeline] { (Seed staging)
[Pipeline] sh
+ node scripts/seed-staging.js --shopper demo --verbose
[seed] connecting to ⟬hostname#2⟭ as ⟬trap:indicator_non_pii|user=seed_runner⟭
[seed] api bearer ⟬jwt#1⟭
[seed] shopper created {"name":"⟬person_name#2⟭","email":"⟬email#2⟭","password":"⟬password#1⟭"}
[seed] default address {"street":"⟬postal_address:street#2⟭","city":"⟬city#2⟭","zip":"⟬postcode#2⟭"}
[seed] wallet {"number":"⟬payment_card#2⟭","cvc":"⟬card_security_code#2⟭"}
[seed] curbside vehicle {"plate":"⟬us_license_plate#2⟭","color":"⟬trap:word_name|Olive⟭"}
[seed] loyalty id ⟬customer_id#2⟭
[seed] done in 3.2s
[Pipeline] } (Seed staging)
[Pipeline] { (E2E)
[Pipeline] sh
+ BASE_URL=https://staging.groceryrun.example npx playwright test --reporter=line
Running 42 tests using 4 workers
[1/42] [chromium] › cart.spec.ts:12:5 › adds a bunch of bananas
[2/42] [chromium] › cart.spec.ts:28:5 › keeps the cart after login
[8/42] [chromium] › search.spec.ts:9:5 › finds ⟬trap:word_name|Ruby⟭ grapefruit
[17/42] [chromium] › checkout.spec.ts:44:5 › pays with the saved card
[23/42] [chromium] › curbside.spec.ts:31:5 › keeps the bay after a late arrival
  1) [chromium] › curbside.spec.ts:31:5 › keeps the bay after a late arrival

    Error: Timed out 5000ms waiting for expect(locator).toHaveText(expected)

    Locator: getByTestId('bay-status')
    Expected string: "Bay held for ⟬us_license_plate#2⟭"
    Received string: "Bay released"

      29 |   await page.getByLabel("Plate").fill(shopper.plate);
      30 |   await advanceClock(page, 16);
    > 31 |   await expect(page.getByTestId("bay-status")).toHaveText(`Bay held for ${shopper.plate}`);

    attachment #1: trace (application/zip)
    test-results/curbside-keeps-the-bay/trace.zip

[42/42] [chromium] › wishlist.spec.ts:7:5 › shares a list
  1 failed
  41 passed (2.4m)
[Pipeline] } (E2E)
[Pipeline] { (Notify)
[Pipeline] sh
+ curl -s -X POST -H "X-Client-Ref: ⟬opaque_token#1⟭" -d "{\"text\":\"e2e failed\"}" ⟬url#3⟭
ok
[Pipeline] } (Notify)
[Pipeline] End of Pipeline
ERROR: script returned exit code 1
Finished: FAILURE
⟬end⟭

⟬template⟭
family: logs
format: audit log
language: en
fill_locale: en_US
domain: government
appearance: sudo log, session line, command line, license in a command
scenario: sudo trail on a state records gateway, where an analyst queries a license and a passport on the command line
⟬text⟭
⟬date#1⟭ 21:14:05 recgw-2 sshd[3102]: Accepted publickey for ⟬person_name:handle#1⟭ from ⟬ip_address#1⟭ port 50122 ssh2
⟬date#1⟭ 21:14:31 recgw-2 sudo: ⟬person_name:handle#1⟭ : TTY=pts/2 ; PWD=⟬trap:indicator_non_pii|/opt/recgw⟭ ; USER=⟬trap:indicator_non_pii|root⟭ ; COMMAND=/opt/recgw/bin/query --dl "⟬us_driver_license#2⟭"
⟬date#1⟭ 21:14:31 recgw-2 sudo: pam_unix(sudo:session): session opened for user ⟬trap:indicator_non_pii|root⟭ by ⟬person_name:handle#1⟭(uid=1004)
⟬date#1⟭ 21:15:02 recgw-2 sudo: ⟬person_name:handle#1⟭ : TTY=pts/2 ; PWD=⟬trap:indicator_non_pii|/opt/recgw⟭ ; USER=⟬trap:indicator_non_pii|root⟭ ; COMMAND=/opt/recgw/bin/query --passport ⟬us_passport#3⟭ --reason ⟬ticket_id#1⟭
⟬date#1⟭ 21:15:02 recgw-2 sudo: pam_unix(sudo:session): session closed for user ⟬trap:indicator_non_pii|root⟭
⟬date#1⟭ 21:15:40 recgw-2 sshd[3102]: Disconnected from user ⟬person_name:handle#1⟭ ⟬ip_address#1⟭ port 50122
⟬end⟭

⟬template⟭
family: logs
format: application log
language: en
fill_locale: en_US
domain: fintech
appearance: JSON lines, structlog output, card without a key
scenario: structlog JSON of a payment switch, where a retry dumps the raw authorization fields, card and security code under neutral keys
⟬text⟭
{"event":"auth.request","level":"info","ts":"⟬date#1⟭ 12:01:44","merchant":"⟬customer_id#1⟭","amount":129.90,"trace":"⟬uuid#1⟭"}
{"event":"auth.timeout","level":"warning","ts":"⟬date#1⟭ 12:01:49","acquirer":"⟬hostname#1⟭","elapsed_ms":5002,"trace":"⟬uuid#1⟭"}
{"event":"auth.retry","level":"debug","ts":"⟬date#1⟭ 12:01:49","f2":"⟬payment_card#2⟭","f48":"⟬card_security_code#2⟭","trace":"⟬uuid#1⟭"}
{"event":"auth.response","level":"info","ts":"⟬date#1⟭ 12:01:50","code":"05","text":"do not honor","trace":"⟬uuid#1⟭"}
⟬end⟭

⟬template⟭
family: logs
format: stack trace
language: en
fill_locale: en_US
domain: SaaS
appearance: Django debug traceback, local variables, Python dict repr, secret under an innocuous key
scenario: Django traceback of a project management tool's billing page, with error reporting that lists local variables holding the POST body, a session value and an API secret
⟬text⟭
Internal Server Error: /billing/upgrade/
Traceback (most recent call last):
  File "/app/.venv/lib/python3.11/site-packages/django/core/handlers/exception.py", line 55, in inner
    response = get_response(request)
  File "/app/.venv/lib/python3.11/site-packages/django/core/handlers/base.py", line 197, in _get_response
    response = wrapped_callback(request, *callback_args, **callback_kwargs)
  File "/app/billing/views.py", line 92, in upgrade
    charge = gateway.charge(form.cleaned_data["number"], form.cleaned_data["cvc"], plan.price_cents)
  File "/app/billing/gateway.py", line 47, in charge
    raise GatewayError(response.json()["detail"])
billing.gateway.GatewayError: issuer unavailable

Local variables at /app/billing/views.py:92
  form.cleaned_data = {"plan": "team-annual", "number": "⟬payment_card#1⟭", "cvc": "⟬card_security_code#1⟭", "name_on_card": "⟬person_name#1⟭", "billing_zip": "⟬postcode#1⟭"}
  request.user = ⟬email#1⟭
  request.session = {"_auth_user_id": "⟬customer_id#1⟭", "ref": "⟬opaque_token#1⟭", "theme": "dark"}
  plan = <Plan: team-annual>
  gateway = <GatewayClient base=⟬url#1⟭ k=⟬opaque_token#2⟭>

Local variables at /app/billing/gateway.py:47
  response = <Response [503]>
  attempts = 3
  self.ref = ⟬order_number#1⟭
  self.timeout = 8
⟬end⟭

⟬template⟭
family: logs
format: test output
language: en
fill_locale: en_US
domain: healthcare
appearance: pytest assertion diff, Python dict repr, test fixture, captured log, birth date next to dates
scenario: pytest -vv run of a claims adjudication engine, whose long diffs and captured logs print member fixtures with SSN, birth date, address and phone beside ordinary service dates
⟬text⟭
============================= test session starts ==============================
platform linux -- Python 3.11.8, pytest-8.1.1, pluggy-1.4.0
rootdir: /srv/adjudication, configfile: pytest.ini
plugins: mock-3.12.0, freezegun-0.4.2
collected 87 items

tests/test_copay.py ................                                     [ 18%]
tests/test_deductible.py ..........                                      [ 29%]
tests/test_member_merge.py F.......                                      [ 39%]
tests/test_prior_auth.py ..........F...                                  [ 55%]
tests/test_remittance.py .......................................         [100%]

=================================== FAILURES ===================================
________________________ test_merge_keeps_latest_address ________________________

fixtures = {'old': <Member>, 'new': <Member>}

    def test_merge_keeps_latest_address(fixtures):
        merged = merge_members(fixtures["old"], fixtures["new"])
>       assert merged.as_dict() == EXPECTED_MERGED
E       AssertionError: assert {...} == {...}
E
E         Omitting 5 identical items, use -vvv to show
E         Differing items:
E         {"address": "⟬postal_address#1⟭"} != {"address": "⟬postal_address#2⟭"}
E         {"phone": "⟬phone#1⟭"} != {"phone": "⟬phone#2⟭"}
E
E         Full diff:
E           {
E         -  "address": "⟬postal_address#2⟭",
E         +  "address": "⟬postal_address#1⟭",
E            "dob": "⟬birth_date#1⟭",
E            "effective": "⟬date#2⟭",
E            "member_id": "⟬customer_id#1⟭",
E            "name": "⟬person_name#1⟭",
E         -  "phone": "⟬phone#2⟭",
E         +  "phone": "⟬phone#1⟭",
E            "ssn": "⟬us_ssn#1⟭",
E            "updated": "⟬date#1⟭",
E           }

tests/test_member_merge.py:41: AssertionError
----------------------------- Captured log call --------------------------------
INFO     adjudication.merge:merge.py:88 merging "⟬person_name#1⟭" records, service date ⟬date#3⟭
DEBUG    adjudication.merge:merge.py:91 old address kept for audit: ⟬postal_address#1⟭
WARNING  adjudication.merge:merge.py:103 two dates of birth seen: ⟬birth_date#1⟭ and ⟬birth_date#3⟭
______________________ test_prior_auth_requires_referral _______________________

    def test_prior_auth_requires_referral(claim_factory):
        claim = claim_factory(procedure="⟬trap:eponym|Mohs⟭ surgery", referral=None)
>       assert adjudicate(claim).status == "PENDED"
E       AssertionError: assert "PAID" == "PENDED"
E         - PENDED
E         + PAID

tests/test_prior_auth.py:62: AssertionError
---------------------------- Captured stdout call ------------------------------
claim_factory -> Claim(
    claimant="⟬person_name#4⟭",
    ssn="⟬us_ssn#4⟭",
    dob="⟬birth_date#4⟭",
    provider="⟬person_name#5⟭",
    facility="⟬company#5⟭",
    facility_address="⟬postal_address#5⟭",
    service_date="⟬date#3⟭",
    ⟬trap:indicator_non_pii|adjuster="auto-adjudicator"⟭,
)
=========================== short test summary info ============================
FAILED tests/test_member_merge.py::test_merge_keeps_latest_address
FAILED tests/test_prior_auth.py::test_prior_auth_requires_referral
========================= 2 failed, 85 passed in 7.63s =========================
⟬end⟭

⟬template⟭
family: logs
format: access log
language: en
fill_locale: en_US
domain: retail
appearance: Traefik access line, custom context field, plate in a context field, token in a query string
scenario: Traefik access of a pharmacy chain's pickup service, where curbside check-ins put the plate in a context field and refill links carry tokens
⟬text⟭
⟬ip_address#1⟭ - - [⟬date#1⟭ 17:05:12 -0400] "GET /pickup/start?order=⟬uuid#1⟭&t=⟬opaque_token#1⟭ HTTP/2.0" 200 3120 "-" "Mozilla/5.0 (iPhone; CPU iPhone OS 17_3 like Mac OS X)" 44 "⟬trap:email_lookalike|pickup@docker⟭" "http://web:8080" 12ms meta="-"
⟬ip_address#1⟭ - - [⟬date#1⟭ 17:05:40 -0400] "POST /pickup/arrived HTTP/2.0" 200 96 "⟬url#1⟭" "Mozilla/5.0 (iPhone; CPU iPhone OS 17_3 like Mac OS X)" 45 "⟬trap:email_lookalike|pickup@docker⟭" "http://web:8080" 31ms meta="plate=⟬us_license_plate#2⟭ spot=6"
⟬ip_address#2⟭ - - [⟬date#1⟭ 17:06:03 -0400] "GET /ping HTTP/1.1" 200 2 "-" "Go-http-client/1.1" 46 "⟬trap:email_lookalike|ping@internal⟭" "-" 0ms meta="-"
⟬ip_address#3⟭ - - [⟬date#1⟭ 17:06:11 -0400] "GET /refill/confirm?rx=⟬order_number#1⟭&token=⟬jwt#1⟭ HTTP/2.0" 200 2204 "-" "Mozilla/5.0 (Linux; Android 14) Chrome/120.0" 47 "⟬trap:email_lookalike|refill@docker⟭" "http://web:8080" 19ms meta="-"
⟬ip_address#3⟭ - - [⟬date#1⟭ 17:06:30 -0400] "POST /refill/confirm HTTP/2.0" 201 74 "⟬url#2⟭" "Mozilla/5.0 (Linux; Android 14) Chrome/120.0" 48 "⟬trap:email_lookalike|refill@docker⟭" "http://web:8080" 42ms meta="deliver_to=⟬postal_address#3⟭"
⟬ip_address#4⟭ - - [⟬date#1⟭ 17:06:52 -0400] "GET /stores/⟬trap:word_name|Savannah⟭ HTTP/2.0" 200 8120 "-" "Mozilla/5.0 (compatible; bingbot/2.0)" 49 "⟬trap:email_lookalike|web@docker⟭" "http://web:8080" 8ms meta="-"
⟬ip_address#5⟭ - ⟬username#1⟭ [⟬date#1⟭ 17:07:15 -0400] "GET /staff/pickup/board HTTP/2.0" 200 4410 "-" "Mozilla/5.0 (X11; Linux x86_64) Firefox/122.0" 50 "⟬trap:email_lookalike|staff@docker⟭" "http://staff:8081" 22ms meta="-"
⟬ip_address#5⟭ - ⟬username#1⟭ [⟬date#1⟭ 17:07:44 -0400] "POST /staff/pickup/⟬uuid#1⟭/handoff HTTP/2.0" 200 66 "⟬url#3⟭" "Mozilla/5.0 (X11; Linux x86_64) Firefox/122.0" 51 "⟬trap:email_lookalike|staff@docker⟭" "http://staff:8081" 17ms meta="id_shown=⟬us_driver_license#2⟭ customer=⟬person_name#2⟭"
⟬ip_address#6⟭ - - [⟬date#1⟭ 17:08:09 -0400] "POST /giftcards/activate HTTP/2.0" 200 58 "-" "POS/⟬version#1⟭" 52 "⟬trap:email_lookalike|pos@docker⟭" "http://pos:8082" 27ms meta="value=⟬opaque_token#2⟭"
⟬ip_address#6⟭ - - [⟬date#1⟭ 17:08:12 -0400] "POST /giftcards/batch-status HTTP/2.0" 200 58 "-" "POS/⟬version#1⟭" 53 "⟬trap:email_lookalike|pos@docker⟭" "http://pos:8082" 25ms meta="value=⟬uuid#2⟭"
⟬ip_address#7⟭ - - [⟬date#1⟭ 17:08:47 -0400] "GET /account/orders?session=⟬jwt#2⟭ HTTP/2.0" 200 5120 "⟬url#4⟭" "Mozilla/5.0 (Macintosh; Intel Mac OS X 14_2) Safari/605.1.15" 54 "⟬trap:email_lookalike|account@docker⟭" "http://web:8080" 15ms meta="-"
⟬ip_address#8⟭ - - [⟬date#1⟭ 17:09:03 -0400] "POST /pickup/arrived HTTP/2.0" 200 96 "⟬url#5⟭" "Mozilla/5.0 (Linux; Android 13) Chrome/119.0" 55 "⟬trap:email_lookalike|pickup@docker⟭" "http://web:8080" 29ms meta="plate=⟬us_license_plate#8⟭ spot=2 note=my husband ⟬person_name#8m⟭ will come in"
⟬ip_address#2⟭ - - [⟬date#1⟭ 17:09:33 -0400] "GET /ping HTTP/1.1" 200 2 "-" "Go-http-client/1.1" 56 "⟬trap:email_lookalike|ping@internal⟭" "-" 0ms meta="-"
⟬ip_address#9⟭ - - [⟬date#1⟭ 17:10:02 -0400] "GET /unsubscribe?u=⟬email#9⟭&sig=⟬opaque_token#3⟭ HTTP/2.0" 200 980 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/121.0" 57 "⟬trap:email_lookalike|web@docker⟭" "http://web:8080" 9ms meta="-"
⟬ip_address#10⟭ - - [⟬date#1⟭ 17:10:26 -0400] "POST /checkout/token HTTP/2.0" 200 112 "⟬url#6⟭" "Mozilla/5.0 (iPad; CPU OS 17_2 like Mac OS X) Safari/604.1" 58 "⟬trap:email_lookalike|checkout@docker⟭" "http://web:8080" 301ms meta="⟬payment_card#10⟭ ⟬card_security_code#10⟭"
⟬ip_address#10⟭ - - [⟬date#1⟭ 17:10:27 -0400] "GET /checkout/done?receipt=⟬invoice_number#1⟭ HTTP/2.0" 200 2600 "⟬url#6⟭" "Mozilla/5.0 (iPad; CPU OS 17_2 like Mac OS X) Safari/604.1" 59 "⟬trap:email_lookalike|checkout@docker⟭" "http://web:8080" 11ms meta="-"
⟬end⟭
