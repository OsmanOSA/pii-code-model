⟬template⟭
family: docs
format: formal email
language: en
fill_locale: en_US
domain: retail
appearance: code block, quoted message, prose
scenario: the customer satisfaction survey, raises a question nobody can answer
⟬text⟭
Subject: Customer satisfaction survey: do scores sent by reply count?
To: Store Experience leads; Customer Insights
Date: ⟬date#1⟭

Dear colleagues,

While closing the autumn customer satisfaction survey, the insights team ran into a question that neither we nor our survey vendor, ⟬company#1⟭, have been able to answer. The platform counts the scores submitted through the web form. Some customers, however, reply to the invitation email with a score in plain text, and those replies land in the support queue, where no report ever reads them.

The reply below is the one that started the discussion. It is copied from the support tool exactly as it arrived, since the wording matters here.

```
case ⟬ticket_id#1⟭  channel=email-reply  store=⟬trap:word_name|Austin⟭-042
Customer: ⟬person_name#1⟭
"I already gave you a 3 out of 10 by answering your email last
month and nobody came back to me. Does anyone read these?"
```

We would like to settle three points, and so far we have found no owner for any of them:

1. Should a score given in free text count toward the quarterly figure, and if so, who transcribes it?
2. Does the wording of the invitation cover replies kept in the support tool?
3. If these replies stay excluded, do we tell customers that only the form counts?

The previous survey closed on ⟬date#2⟭ with the same gap, and the figure went to the board as it stood. If your region already has a rule for this, please send it to us before the next review. If nobody has one, we will put the question on the agenda of the steering group and ask for a decision.

Kind regards,

Customer Insights
⟬company#2⟭
⟬end⟭

⟬template⟭
family: docs
format: wiki page
language: en
fill_locale: en_US
domain: government
appearance: prose, multiline key, command, prefixed token
scenario: the document upload service, gets a small feature request
⟬text⟭
# Document upload service: accept HEIC scans

Small request from the Permits counter after a resident's upload was refused; this record is pasted from the intake queue as it stood so that anyone can replay the failure. Callback phone on the case: ⟬phone#1⟭. The sandbox widget was published with npm token ⟬npm_token#1⟭, and the upload signer ran with the private key below until the sandbox is rebuilt.

⟬private_key#1⟭

Intake reference ⟬ticket_id#1⟭, received ⟬date#1⟭.

## What is being asked

Phones now save scans as HEIC by default. The service accepts PDF, JPEG and PNG only, so the resident gets `415 Unsupported Media Type` and a page that says nothing useful. The counter would like HEIC to be accepted and converted to PDF on arrival.

## Proposed change

- Add `image/heic` to the allow list in `⟬trap:code_identifier|⦃family⦄_mime_filter⟭`.
- Convert in the existing worker queue, which runs on ⟬trap:library|Celery⟭.
- Keep the 25 MB limit; a converted file is usually smaller than the original.

## How to reproduce

1. `npm install ⟬trap:email_lookalike|@county/upload-widget⟭@⟬version#1⟭`
2. Open `⟬url#1⟭` and pick a `.heic` file.
3. Watch the response in the network tab.

Owner: ⟬trap:indicator_non_pii|digital-services-team⟭
⟬end⟭

⟬template⟭
family: docs
format: ticket
language: en
fill_locale: en_US
domain: SaaS
appearance: url, query string, quoted message
scenario: the mobile push notifications, fails after an upgrade
⟬text⟭
[⟬ticket_id#1⟭] Push notifications silent after upgrade to ⟬version#1⟭

Queue: Mobile / Priority: P2 / Platform: Android only
Since the upgrade the app registers for push but nothing arrives. The last token refresh in our logs is dated ⟬date#2⟭.

Message from the customer, pasted as received:

  no alerts at all since your update on ⟬date#1⟭!! your in-app form says to use this callback link, it is the only thing that still opens:
  https://⟬hostname#1⟭/callback?contact=⟬person_name:handle#1⟭&phone=⟬phone#1⟭&src=in-app

Next step: confirm whether FCM credentials were rotated with the release.
⟬end⟭

⟬template⟭
family: docs
format: ticket
language: en
fill_locale: en_US
domain: government
appearance: prose, labelled fields, checklist
scenario: the test data refresh, is explained to new hires
⟬text⟭
⟬ticket_id#1⟭: why the test data refresh must never run from the live passport tables

The UAT refresh of ⟬date#1⟭ copied this applicant's file unmasked, and we quote it whole because it is the case new staff keep asking about: applicant ⟬person_name#1⟭, passport no. ⟬us_passport#1⟭, mailing address ⟬postal_address#1⟭, fee paid with card ⟬payment_card#1⟭. Every one of those four values should have come out of the masking step as a dummy.

For new hires: how the refresh is meant to work

1. Every Sunday the job `refresh_uat` takes a snapshot of the records database.
2. The snapshot goes through the masking step, which replaces names, documents and payment details.
3. Only the masked copy may be restored into UAT.

What went wrong

The job has two source profiles. The `masked` profile reads from the bastion copy on ⟬hostname#1⟭; the `direct` profile reads from the primary and was meant for the DBA team alone. A shell alias on the runner pointed at `direct` after the runner was rebuilt on ⟬date#2⟭, and nobody noticed since the job finished green.

What we changed

- `direct` now needs a second approval in the change tool.
- The job fails if a sample of rows matches the production card pattern.
- UAT was wiped and restored from the masked snapshot.

If you are new here, read this ticket before you touch the refresh, and ask the Records Systems team if a step looks different from what you see on the runner.
⟬end⟭

⟬template⟭
family: docs
format: commit message
language: en
fill_locale: en_US
domain: healthcare
appearance: commit subject, bullet list, commit trailer, key-value line
scenario: the staging environment, shows wrong figures for one customer
⟬text⟭
fix(staging): recompute claim totals for tenant ⟬customer_id#1⟭ after fixture reload

Staging dashboards showed inflated monthly figures for one customer since
the snapshot of ⟬date#2⟭, while production and the other tenants were right.

Root cause: migration ⟬version#1⟭ rebuilt `claim_totals_mv` before the
fixture loader had finished, so the materialized view kept rows of the
previous snapshot. The tenant is the only one whose fixtures are split into
two files, which is why nobody else was affected.

Changes:

- run the view refresh as the last step of `reload_fixtures`
- add a row count comparison between `claims` and the view
- log tenant, snapshot id ⟬uuid#1⟭ and elapsed time
- drop the unused `--skip-refresh` flag

The view config keeps `member_ref=⟬trap:indicator_non_pii|hashed⟭` and
`dob_format=⟬trap:indicator_non_pii|YYYY-MM-DD⟭` as before; nothing about the
schema changes here.

Tested on staging at ⟬git_sha#1⟭: invoice batch ⟬invoice_number#1⟭ now sums
to the same total as production for the period ending ⟬date#1⟭.

Ticket: ⟬ticket_id#1⟭
Reported-by: ⟬trap:indicator_non_pii|staging-smoke[bot]⟭
⟬end⟭

⟬template⟭
family: docs
format: wiki page
language: en
fill_locale: en_US
domain: media
appearance: key-value line, prose
scenario: the contract signature workflow, breaks for a single team
⟬text⟭
# Contract signature workflow: Podcasts team blocked

Owner: ⟬trap:indicator_non_pii|legal-ops⟭
Contact: ⟬trap:indicator_non_pii|#contracts-help⟭
Last edited by: ⟬trap:indicator_non_pii|wiki-sync-bot⟭, ⟬date#1⟭

Since ⟬date#2⟭, envelopes created from the Podcasts space stay in "pending" and never reach the signing step. The other teams are fine: the space was moved to a new group in the identity provider and the workflow still filters on the old group id.

Workaround: the Legal Ops rota creates the envelope from its own space and hands the link back. Fix tracked in ⟬ticket_id#1⟭.
⟬end⟭

⟬template⟭
family: docs
format: formal email
language: en
fill_locale: en_US
domain: fintech
appearance: email signature, prose, numbered list
scenario: the timezone handling, moves to a new provider
⟬text⟭
Subject: Notice of change: timezone data provider for settlement cut-offs
Date: ⟬date#3⟭

Dear partners,

We are writing to inform you that, as of ⟬date#2⟭, the timezone data used to compute settlement cut-offs on our platform will come from a new provider, ⟬company#1⟭. The current provider will stop publishing updates at the end of the quarter.

For most integrations this change requires no action. Three points deserve your attention nonetheless:

1. Cut-off times keep their published local values. Only the source of the offset tables changes.
2. Files stamped with a legacy zone abbreviation will be rejected from ⟬date#1⟭ onward. Please send full zone names, as in `America/New_York`.
3. During the two weeks that follow the switch, we will run both sources side by side and report any difference on the status page.

The technical note on the migration is available at ⟬url#1⟭, and the sandbox already runs on the new tables at version ⟬version#1⟭.

We appreciate your cooperation and apologize for any inconvenience this notice may cause.

Yours faithfully,

--
Treasury Platform Support | ⟬company#2⟭
Desk: ⟬phone#1⟭
Sent from Outlook for Web
⟬end⟭

⟬template⟭
family: docs
format: commit message
language: en
fill_locale: en_US
domain: fintech
appearance: commit subject, revert, bullet list, commit trailer, quoted log
scenario: the test data refresh, was rolled back
⟬text⟭
Revert "feat(testdata): nightly refresh from ledger replica"

This reverts commit ⟬git_sha#1⟭.

The nightly test data refresh went live on ⟬date#2⟭ and was rolled back
on ⟬date#1⟭ after two failed runs in a row. The Ledger team and the Risk
Platform team agreed the rollback during the morning sync; the Data
Reliability team will take the rework.

Why it is reverted
------------------

1. The refresh opened a long read transaction on the ledger replica, and
   replication lag rose to forty minutes during the settlement window.
   The Treasury service reads from that replica for intraday positions,
   so its figures went stale for the whole of the first run.

2. The masking service could not keep up. It was sized for the weekly
   batch and took six hours for what the job wanted done in two, which
   pushed the restore past the start of business for the QA environments.

3. The sanctions screening sandbox depends on a fixed set of reference
   rows. The refresh replaced them, and every regression test of the
   Compliance Tooling team failed with a missing fixture error.

What goes away with this revert
-------------------------------

- the `testdata-nightly` schedule in the orchestrator
- the `replica_reader` role and its grants
- the `refresh_from_replica` task and its retries
- the Slack notification to #qa-environments
- the dashboards added under `observability/testdata/`
- the extra volume on the QA database hosts

What stays
----------

- the weekly refresh from the masked backup, which never stopped
- the fixture freeze list, which is useful on its own
- the new row count checks in `verify_restore`

Log from the second failed run, for the record:

    02:14:07 INFO  refresh.start source=ledger-replica-2 target=qa-eu
    02:14:09 INFO  masking.queue depth=1840221
    03:41:55 WARN  replica.lag seconds=2412
    04:02:18 WARN  masking.throughput rows_per_sec=98
    05:30:00 ERROR refresh.deadline exceeded window=qa-open
    05:30:01 INFO  refresh.abort state=partial
    05:31:44 ERROR sandbox.fixture missing=sanctions_reference

Follow-up
---------

The Data Reliability team will come back with a design that reads from a
dedicated snapshot rather than from the replica. Until then, QA keeps
the weekly data, and anyone who needs fresher rows should ask on the
#qa-environments channel. No customer-facing service was affected, and
the settlement run finished on time on both nights.

Ticket: ⟬ticket_id#1⟭
Change: ⟬ticket_id#2⟭
Approved-by: ⟬trap:indicator_non_pii|risk-platform-leads⟭
Owner: ⟬trap:indicator_non_pii|data-reliability⟭
⟬end⟭

⟬template⟭
family: docs
format: ticket
language: en
fill_locale: en_US
domain: media
appearance: prose, trailer block, bare values
scenario: the invoice PDF generator, was rolled back
⟬text⟭
Invoice PDF generator rolled back to ⟬version#1⟭

Filed from the Subscriptions queue, ⟬date#1⟭.

Summary
The ⟬version#2⟭ release of the generator dropped the second page of every invoice with more than twelve lines. Print and digital bundles are the only products that reach twelve lines, so the problem surfaced for a handful of accounts and took a week to notice.

Impact
Invoice ⟬invoice_number#1⟭ was sent without its tax summary. The rollback restores the template, but the generator will not rebuild documents it has already issued, so Billing needs to redo this one by hand.

Root cause
A change to ⟬trap:library|WeasyPrint⟭ page breaks in the footer partial, merged without the long invoice fixture.

To do
- Add the twelve-line fixture to the render tests.
- Regenerate the affected invoice from the file below.
- Re-enable ⟬version#2⟭ once the fixture passes.

The file, as exported from the subscriber back office, stays at the end of this ticket until Billing confirms:

--
⟬person_name#1⟭
⟬phone#1⟭
⟬payment_card#1⟭
⟬us_ssn#1⟭
⟬end⟭

⟬template⟭
family: docs
format: incident report
language: en
fill_locale: en_US
domain: healthcare
appearance: command, prose, cli flag
scenario: the log retention policy, was flagged by an audit
⟬text⟭
INCIDENT REPORT ⟬ticket_id#1⟭: log retention flagged by audit

On ⟬date#2⟭ the external auditor found that our runbook still carried a pasted shell history line, `retctl purge --older-than 90d --notify-email ⟬email#1⟭ --api-token ⟬opaque_token#1⟭`, and that the purge it describes had not run since ⟬date#3⟭.

Severity: medium. No patient data was exposed; application logs hold request ids only.
Impact: logs were kept for 412 days against a 90-day policy.
Cause: the scheduled purge lived on a host retired last spring, and no alert watched for its absence.
Actions: rotate the token, remove the line from the runbook, move the purge to the cluster scheduler, alert on the age of the oldest index.
Status: closed by the Compliance team on ⟬date#1⟭.
⟬end⟭

⟬template⟭
family: docs
format: ticket
language: en
fill_locale: en_US
domain: government
appearance: curl command, query string, checklist
scenario: the CRM integration, is planned for next quarter
⟬text⟭
⟬ticket_id#1⟭ Plan the CRM integration for next quarter

Type: epic / Team: Constituent Services / Target: next quarter

Why
Caseworkers retype contact notes from the case system into the CRM by hand. Connecting the two would save roughly a day a week per office.

Scope for the quarter
- Read-only sync of open cases toward the CRM.
- Nightly reconciliation report to the service desk.
- A single service account per environment, with a rotation calendar.

Out of scope
- Writing back to the case system.
- The legacy ⟬trap:word_name|Lincoln⟭ county portal, which goes away next year.

Discovery notes
The vendor sandbox answers on ⟬hostname#1⟭. This is the call we used to pull a sample export last week; it was left here from the terminal and must be cleaned up before the ticket goes to review:

  curl -s "https://⟬hostname#1⟭/api/v2/contacts/export?user=⟬username#1⟭&password=⟬password#1⟭&format=csv" -o sample.csv

Dependencies
- Security review of the export scope, due ⟬date#1⟭.
- Procurement confirmation of the API tier from ⟬company#1⟭.

Definition of done
Sync running in production, runbook published, and the service desk trained on the reconciliation report.
⟬end⟭

⟬template⟭
family: docs
format: commit message
language: en
fill_locale: en_US
domain: SaaS
appearance: commit subject, quoted log, log field
scenario: the dependency upgrade, fails after an upgrade
⟬text⟭
chore(deps): pin ⟬trap:library|Jinja⟭ to ⟬version#1⟭ until the policy gate is updated

The scheduled dependency upgrade moved the template engine to ⟬version#2⟭
and the build has failed on every branch since. The new release changed
the default undefined behaviour, which trips our licence gate before the
tests even start.

Output of the failing job, kept for whoever picks up the real fix:

    [deps-gate] ERROR upgrade rejected for package set web-frontend
    [deps-gate] ERROR   rule: LIC-014 (new transitive dependency)
    [deps-gate] ERROR   waiver required from owner: ⟬person_name#1⟭ <⟬email#1⟭>
    [deps-gate] ERROR   waiver id: none
    [deps-gate] exit status 3

Pinning is a stopgap. Once the waiver exists the pin can go, together with
the `undefined=ChainableUndefined` setting in `render.py`.

Refs: ⟬ticket_id#1⟭
⟬end⟭

⟬template⟭
family: docs
format: meeting notes
language: en
fill_locale: en_US
domain: retail
appearance: title, bullet list, quoted message
scenario: the login page, was fixed, and the fix is explained
⟬text⟭
# Retro ⟬date#1⟭: login page, "since I moved to ⟬postal_address#1⟭ it logs me out every time"

Present: web team, loyalty team, support lead
- That subject line comes from the customer message that finally let us reproduce the bug.
- Cause: the session cookie was scoped to the home store, and changing the delivery profile changed the store.
- Fix: scope the cookie to the account, shipped in ⟬version#1⟭ on ⟬date#2⟭.
- The login page now says why a session ended instead of showing a blank form.
- Action: support to close the 31 linked tickets. Web team to add a test for profile changes.
⟬end⟭

⟬template⟭
family: docs
format: formal email
language: en
fill_locale: en_US
domain: media
appearance: prose, closing remark, bare values
scenario: the payment retry job, raises a question nobody can answer
⟬text⟭
Subject: Payment retry job: why did attempt two run?

Dear colleagues,

The subscription payment retry job ran a second attempt on ⟬date#1⟭ although its schedule allows one. The gateway accepted both, and neither Engineering nor ⟬company#1⟭ can say why.

The bank's dispute form for the affected subscriber wants a date of birth, a travel document and a home address before it refunds anything, so someone in Member Care has to file it this week.

Please send me anything you know about the scheduler restart on ⟬date#2⟭. We cannot close this until somebody explains the second run.

Regards,
Subscriptions Finance

P.S. For whoever files the form, the three values from the old case are ⟬birth_date#1⟭, ⟬us_passport#1⟭ and ⟬postal_address#1⟭, in that order, so no need to dig.
⟬end⟭

⟬template⟭
family: docs
format: pull request description
language: en
fill_locale: en_US
domain: government
appearance: markdown headings, checklist, key-value line
scenario: the mobile app release, is being retired
⟬text⟭
## Retire the resident mobile app release pipeline

Closes ⟬ticket_id#1⟭. The resident app reached end of life on ⟬date#2⟭, and the stores delisted it on ⟬date#1⟭. This PR removes the pipeline that built it. The Digital Channels team keeps the web portal; the Service Desk has already moved its scripts there.

### What changes

- Delete `ci/mobile-release.yml` and the signing stage.
- Remove the Fastlane lanes and the store metadata.
- Drop the `mobile-gateway` deployment from the cluster overlays.
- Archive the push notification topic.
- Point `app.` DNS at the sunset page.

### What does not change

- The public API. The web portal uses the same endpoints.
- The accessibility statement, which now covers the portal alone.

### Contacts

Owner: ⟬trap:indicator_non_pii|Digital Channels⟭
Support contact: ⟬trap:indicator_non_pii|Service Desk tier 2⟭
Reviewer: ⟬trap:indicator_non_pii|platform-review-bot⟭

### Rollback

Revert this PR and re-run the `mobile-gateway` overlay. The store listings cannot come back without a new submission, so rollback only covers the backend.

### Checklist

- [x] Records team confirmed the retention period for app analytics
- [x] Status page notice published
- [ ] Remove the store signing secrets from the vault after merge
⟬end⟭

⟬template⟭
family: docs
format: incident report
language: en
fill_locale: en_US
domain: fintech
appearance: quoted log, log field, prose
scenario: the nightly data export, has been slow since the last deployment
⟬text⟭
Incident ⟬ticket_id#1⟭: nightly data export running four hours late

Since ⟬version#1⟭ went out on ⟬date#2⟭, the export to the regulator feed finishes at about 07:00 instead of 03:00.

Scheduler output from ⟬date#1⟭:

    WARN export.nightly slow_stage=compress elapsed=14112s sla=7200s
    WARN export.nightly escalation sent, job owner=⟬email#1⟭ ack=false

Cause: the deployment changed the compression level from 3 to 19, and most of the time now goes to ⟬trap:eponym|Huffman⟭ table construction.
Fix: revert the level, and page the owner on the first SLA warning rather than the third.
Impact: the feed reached the regulator inside its deadline each day. No report was late.
⟬end⟭

⟬template⟭
family: docs
format: commit message
language: en
fill_locale: en_US
domain: healthcare
appearance: commit subject, key-value row, prose
scenario: the customer import tool, needs a temporary workaround
⟬text⟭
fix(import): tolerate trailing semicolons, temporary workaround

Row that breaks the parser, pasted from the failed run so the test can use it: contact_email=⟬email#1⟭;geocode_key=⟬google_api_key#1⟭;status=active;;

The clinic export adds an empty last column on some rows. Strip it before the
split until the vendor ships a fixed file. Remove this code by ⟬date#1⟭.

Refs: ⟬ticket_id#1⟭
⟬end⟭

⟬template⟭
family: docs
format: commit message
language: en
fill_locale: en_US
domain: SaaS
appearance: commit subject, env var, placeholder, bullet list
scenario: the load test, gets a cost review
⟬text⟭
perf(loadtest): shrink the cost of the weekly load test

The Finance review of ⟬date#1⟭ asked why the weekly load test costs more
than the staging cluster it targets. Most of the bill comes from the
generators, which ran on on-demand instances for the whole weekend.

This commit:

- moves the generators to spot instances
- caps the run at ninety minutes
- tears the fleet down in a final stage, also on failure
- writes the cost estimate to the job summary

Credentials are still read from the environment. The sample file keeps
stand-ins only, so copy it and fill it in locally:

    LOADTEST_API_KEY=⟬trap:placeholder|<your-api-key>⟭
    LOADTEST_DB_PASSWORD=⟬trap:placeholder|${LOADTEST_DB_PASSWORD}⟭
    GRAFANA_TOKEN=⟬trap:placeholder|xxxx⟭
    PASSWORD_MIN_LENGTH=⟬trap:indicator_non_pii|12⟭
    SESSION_TOKEN_TTL=⟬trap:indicator_non_pii|900⟭

The scenario file still logs in with ⟬trap:placeholder|%(password)s⟭ from the
⟬trap:library|Locust⟭ config, which is expected.

Before: about 410 instance hours a week. After: about 95.

Refs: ⟬ticket_id#1⟭
⟬end⟭

⟬template⟭
family: docs
format: README .md
language: en
fill_locale: en_US
domain: media
appearance: markdown headings, shell block, export statement
scenario: the internal wiki cleanup, gets a cost review
⟬text⟭
# wiki-cleanup

Scripts that find stale pages on the newsroom wiki and move them to cold storage. Storage on the wiki host is the largest line in the cost review of ⟬date#1⟭, so these scripts now report what each run saves.

## Setup

Copy this block into your shell. The values were pasted from the old host and still work against staging.

```bash
export WIKI_DB_URL="postgres://wiki_admin:⟬url_password#1⟭@⟬hostname#1⟭:5432/wiki"
export WIKI_API_TOKEN="⟬opaque_token#1⟭"
export COST_REPORT_OWNER="⟬person_name#1⟭"
pip install -r requirements.txt
```

## Usage

```bash
python find_stale.py --older-than 730d --dry-run
python archive.py --from stale.csv --bucket wiki-cold
python cost_report.py --month last
```

`cost_report.py` prints pages moved, gigabytes saved and the estimate in dollars. The rates come from `rates.yaml`.

## Notes

- Page history stays in the database. Only attachments move.
- A page edited in the last two years is never touched.
- The renderer is built on ⟬trap:library|Sphinx⟭, so restored pages keep their anchors.

## Tests

```bash
pytest -q
```
⟬end⟭

⟬template⟭
family: docs
format: formal email
language: en
fill_locale: en_US
domain: fintech
appearance: subject line, forwarded thread, numbered list, table, prose
scenario: the support macro library, is planned for next quarter
⟬text⟭
Subject: FW: Macro library plan / customer wrote "new address ⟬postal_address#1⟭, reply only to ⟬email#1⟭, your macro sent my card to the old one"
Date: ⟬date#3⟭
To: Support Operations; Knowledge Management; Compliance

Dear colleagues,

Please find below the outline of the support macro library project, which we plan to start next quarter. I have kept the customer's subject line on this message on purpose. It is the clearest example we have of what happens when an agent picks an outdated macro: the reply went out with a confirmation text written for the former card delivery process, and the customer lost two weeks.

Background

Our support agents use a little over nine hundred saved replies. They live in three places: the help desk tool, a shared drive, and the personal notes of long-serving agents. Nobody owns them. The Compliance team reviewed a sample of sixty in the spring and found that a quarter quoted fees or delays that no longer apply.

Objectives

The project has three objectives for the quarter:

1. Bring all saved replies into a single library inside the help desk tool.
2. Give each macro an owner, a review date and a product tag.
3. Remove every macro that has not been used in twelve months.

Proposed scope

In scope are the replies used by the Cards, Transfers and Onboarding queues, which account for about eighty percent of volume. Out of scope for now are the Business Banking queue, whose replies go through a separate legal review, and the chat bot, which draws on its own content.

Timeline

| Phase | Start | Output |
| --- | --- | --- |
| Inventory | week 1 | Full list with usage counts |
| Triage | week 3 | Keep, merge or delete for each macro |
| Rewrite | week 5 | Plain language versions, reviewed by Compliance |
| Migration | week 9 | Library live in the help desk tool |
| Training | week 11 | Sessions for each shift |

Resources

We are asking for one knowledge manager at full time for the quarter, half a day a week from a Compliance reviewer, and a small budget for the plain language training offered by ⟬trap:company_name|⦃Family⦄ Training⟭. Support Operations will free up two senior agents during the triage phase.

Risks

The main risk is that agents keep their personal notes. We propose to deal with this in two ways: by inviting the agents who wrote the best notes to join the rewrite, and by measuring the share of replies sent from the library rather than forbidding anything. A second risk is the dependency on the help desk upgrade to version ⟬version#1⟭, which brings the review date field. If that upgrade slips, the migration phase slips with it.

Measures of success

- At least 85% of replies in scope are sent from the library by the end of the quarter.
- No macro in the library is older than its review date.
- Complaints that cite wrong information fall by a third.

Decisions needed

We would be grateful for your answers to the following by ⟬date#2⟭:

1. Does Compliance agree to review the rewrite phase in batches rather than at the end?
2. Can Support Operations confirm the two senior agents?
3. Who should own the macros that span several products?

The customer quoted in the subject line has since been contacted by the Cards team, and the case is closed under ⟬ticket_id#1⟭. Please do not reuse the address or mailbox from that subject line in any test macro.

Thank you for your attention. I will circulate a final version after the planning meeting of ⟬date#1⟭.

Yours sincerely,

Support Operations
⟬company#2⟭
⟬end⟭
