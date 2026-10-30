⟬template⟭
family: docs
format: README .md
language: en
fill_locale: en_US
domain: fintech
appearance: connection string, env var, prose
scenario: the laptop replacement programme, raises a question nobody can answer
⟬text⟭
# laptop-refresh

Tracks the laptop replacement programme for the trading floor and back office.

## Setup

The database password is part of the URL, so export it as it stands:

    export ASSET_DB_URL=postgres://refresh:⟬url_password#1⟭@⟬hostname#1⟭:5432/assets

Then run `python refresh.py report`.

## Open question

Nobody has been able to say whether contractor laptops are in scope. The report leaves them out for now.
⟬end⟭

⟬template⟭
family: docs
format: formal email
language: en
fill_locale: en_US
domain: fintech
appearance: code block, cli flag, handover note
scenario: the payment retry job, fails after an upgrade
⟬text⟭
Subject: Handover: payment retry failure after the upgrade

Dear colleague,

Since the upgrade to ⟬version#1⟭, the payment retry job has failed for one account. I am away from tomorrow, so here is all you need to rerun it once the patch lands:

```
retryctl rerun --holder "⟬person_name#1⟭" --iban ⟬iban#1⟭ --ssn ⟬us_ssn#1⟭ --mail-to "⟬postal_address#1⟭"
```

The job stops at the tax check because the new version wants the SSN without dashes. Please confirm with Treasury before you run it.

Best regards,
Payment Operations
⟬end⟭

⟬template⟭
family: docs
format: ticket
language: en
fill_locale: en_US
domain: healthcare
appearance: key-value line, library name, code identifier
scenario: the feature flag cleanup, has been slow since the last deployment
⟬text⟭
⟬ticket_id#1⟭ Feature flag cleanup job slow since ⟬version#1⟭

Assignee: ⟬trap:indicator_non_pii|flag-cleanup-bot⟭

The weekly cleanup used to take ten minutes and now runs for over an hour. Each stale flag triggers a full read from ⟬trap:library|Cassandra⟭ because `⟬trap:code_identifier|⦃family⦄_flag_evaluator⟭` lost its local cache in the last deployment.

Suggested fix: restore the cache and add a ⟬trap:eponym|Bloom filter⟭ in front of the lookup.
⟬end⟭

⟬template⟭
family: docs
format: meeting notes
language: en
fill_locale: en_US
domain: government
appearance: subject line, numbered list, prose
scenario: the document upload service, breaks for a single team
⟬text⟭
Subject: Notes, upload service sync, Vital Records scans stuck (test case ⟬postal_address#1⟭ / ⟬iban#1⟭)
Date: ⟬date#1⟭
Attending: Document Services, Vital Records, Network Operations
Notes: ⟬trap:initials|DB⟭

1. Where we are

Vital Records has not been able to upload scans since ⟬date#2⟭. All other offices upload normally. The uploads reach about 90% and then stop with a timeout.

2. What Document Services found

Vital Records is the only team that sends multi-page TIFF files. Its files average 80 MB, against 5 MB elsewhere. The proxy in front of the service was replaced last month, and its body timeout is 60 seconds.

3. What Network Operations found

The office link is shared with the phone system, and upload speed falls during counter hours. A large file cannot finish inside the timeout.

4. Decisions

- Raise the proxy timeout to five minutes for the upload route.
- Do not change the file size limit.
- Vital Records keeps scanning during the fix and holds the files locally.

5. Actions

- Network Operations changes the timeout this week.
- Document Services adds a progress indicator to the page.
- Vital Records tests with one large file and reports back.

Next sync once the timeout change is live.
⟬end⟭

⟬template⟭
family: docs
format: commit message
language: en
fill_locale: en_US
domain: media
appearance: commit subject, commit trailer, library name
scenario: the internal wiki cleanup, is being retired
⟬text⟭
chore(wiki): remove the cleanup scripts, the wiki moves to ⟬trap:library|Hugo⟭

Drops `⟬trap:code_identifier|⦃family⦄_link_checker⟭` and the stale page report.
The static site has its own link check, so neither is needed.

Author: ⟬trap:indicator_non_pii|dependabot[bot]⟭
Refs: ⟬ticket_id#1⟭
⟬end⟭

⟬template⟭
family: docs
format: wiki page
language: en
fill_locale: en_US
domain: SaaS
appearance: title, prose, table, bullet list
scenario: the payment retry job, was rolled back
⟬text⟭
# Payment retry job rollback (owner: ⟬email#1⟭)

Applies to the subscription billing service. Rolled back on ⟬date#1⟭.

## What happened

Version ⟬version#1⟭ of the job moved retries from a fixed schedule to a ⟬trap:eponym|Fibonacci⟭ backoff based on the decline code. A bug in the mapping treated soft declines as final, so about 1,200 invoices were marked uncollectible after their first failure.

## What we did

| Step | Result |
| --- | --- |
| Paused the job | No further invoices affected |
| Rolled back to ⟬version#2⟭ | Fixed schedule restored |
| Reopened the invoices | Retries resumed the next morning |

## What is left

- Add decline code fixtures from the gateway documentation.
- Compare recovered revenue with the previous month.
- Plan the backoff change again, behind a flag.

## How to tell if it happens again

The dashboard panel "uncollectible per hour" should stay near zero. It turns ⟬trap:word_name|amber⟭ above 5 an hour, and an alert fires above 20.
⟬end⟭

⟬template⟭
family: docs
format: ticket
language: en
fill_locale: en_US
domain: healthcare
appearance: bullet list, labelled fields, prose
scenario: the login page, shows wrong figures for one customer
⟬text⟭
⟬ticket_id#1⟭ Login page shows the wrong appointment count for one clinic

Summary

The banner on the staff login page says "312 appointments today" for the ⟬trap:word_name|Madison⟭ clinic, while the scheduling system shows 31. The other clinics look fine.

People and status

- Reported by: ⟬email#1⟭
- Approved for investigation by: ⟬email#2⟭
- Owner: ⟬email#3⟭
- Status: in progress since ⟬date#1⟭

Findings

The banner reads a cached counter. This clinic has two locations under one parent id, and the cache key ignores the location, so writes from each location add to the same counter. Since each refresh adds to the count instead of replacing it, the figure climbs during the day.

Next steps

Add the location to the cache key, clear the existing keys, and add a test with a clinic that has two locations. The banner is informational, so there is no impact on actual scheduling.
⟬end⟭

⟬template⟭
family: docs
format: wiki page
language: en
fill_locale: en_US
domain: media
appearance: prose, command, bullet list
scenario: the load test, was fixed, and the fix is explained
⟬text⟭
# Load test for the video player: fixed

To run the test as it now stands, start `loadgen run --as ⟬email#1⟭ --k ⟬google_api_key#1⟭ --profile evening-peak` from the bastion, which is how the Streaming team has run it since the fix on ⟬date#1⟭.

## What was wrong

The test reported 8,000 concurrent viewers, but the origin only saw about 3,000. The generators shared one session cookie, so the player treated them as a single viewer on many devices and served most requests from the local cache.

## The fix

- Each virtual viewer now gets a session of its own.
- The cache is bypassed for the manifest request, as it is on a real first play.
- Viewers now arrive as a ⟬trap:eponym|Poisson⟭ process rather than all at once.
- The run reports origin requests next to generator requests.

## How to read the results

If the two figures differ by more than ten percent, the run is not valid. Check the session setup before you trust the latency numbers.

## Limits

The test does not model ad insertion. That remains on the list for ⟬ticket_id#1⟭.
⟬end⟭

⟬template⟭
family: docs
format: pull request description
language: en
fill_locale: en_US
domain: fintech
appearance: key-value line, markdown headings, checklist
scenario: the contract signature workflow, fails after an upgrade
⟬text⟭
## Fix envelope status mapping after the e-sign SDK upgrade

Owner: ⟬trap:indicator_non_pii|contracts-platform⟭
Reviewer: ⟬trap:indicator_non_pii|renovate[bot]⟭
Escalation contact: ⟬trap:indicator_non_pii|#lending-oncall⟭

### Problem

Since ⟬trap:email_lookalike|@esign/sdk⟭ moved to ⟬version#1⟭, signed loan contracts stay in `PENDING`. The callback now sends `completed` where it used to send `signed`, and our mapping falls through to the default.

### Changes

- Map both values during the transition.
- Log unknown statuses as errors.
- Add a contract test using the provider's sample payloads.
- Reprocess the envelopes received since ⟬date#1⟭.

### Risk

Low. The change only widens the mapping. The reprocessing job is idempotent.

### Checklist

- [x] Unit tests
- [x] Tested in sandbox
- [ ] Lending Operations told about the reprocessing window
⟬end⟭

⟬template⟭
family: docs
format: commit message
language: en
fill_locale: en_US
domain: retail
appearance: commit subject, git config line, bullet list
scenario: the customer portal, was flagged by an audit
⟬text⟭
fix(portal): strip embedded remote credentials from the build image

The audit of the customer portal image found this line in the build layer,
pasted here so the scanner rule can be tested against the real shape:
remote.origin.url=https://⟬github_token#1⟭@⟬hostname#1⟭/portal/storefront.git

The value came from a `git clone` in the Dockerfile. It persisted in
`.git/config` and shipped to production with the image, although nothing
at runtime reads it.

This commit:

- switches the clone to a build secret mount
- removes `.git` from the final stage
- adds a scanner rule that fails the build on a remote URL with userinfo
- documents the rule in `docs/build.md`

The value was revoked on ⟬date#1⟭, before this commit, so the line above no
longer grants anything.

Audit finding: ⟬ticket_id#1⟭
⟬end⟭

⟬template⟭
family: docs
format: meeting notes
language: en
fill_locale: en_US
domain: government
appearance: bullet list, quoted signature, labelled fields
scenario: the CRM integration, needs a new owner
⟬text⟭
CRM integration working group
Notes of ⟬date#1⟭

Present: Constituent Services, IT Applications, Records

Item 1: ownership
The integration has had no owner since the IT reorganisation. IT Applications keeps the servers running but will not take on the data mapping. Constituent Services uses it daily and is the natural owner, though it lacks technical staff.

Proposal: Constituent Services owns the service, and IT Applications provides a named contact for changes. To be confirmed by both directors.

Item 2: open defects
- Duplicate contacts after each nightly sync.
- Case notes cut at 4,000 characters.
- Sync failures are visible to nobody until a caseworker complains.

Item 3: why this keeps coming up
A resident's complaint was read to the group, since it shows the cost of having no owner. The resident moved, told us twice, and is still getting letters at the old address. The last lines of the message are kept here so that Records can correct the entry:

> Please use these from now on.
> Mailing address: ⟬postal_address#1⟭
> Phone: ⟬phone#1⟭
> Email: ⟬email#1⟭
⟬end⟭

⟬template⟭
family: docs
format: ticket
language: en
fill_locale: en_US
domain: government
appearance: quoted log, log field, prose
scenario: the contract signature workflow, was fixed, and the fix is explained
⟬text⟭
⟬ticket_id#1⟭ Vendor contract stuck at signature: fixed in ⟬version#1⟭

The whole vendor file was rejected with this error, quoted from the workflow log:

    ERROR sign.validate vendor=⟬person_name#1⟭ ssn=⟬us_ssn#1⟭ itin=⟬us_itin#1⟭ iban=⟬iban#1⟭ reason=two_tax_ids

Sole proprietors may hold both numbers on file, but the validator allowed only one. The fix accepts both and sends the SSN to the signature step. Contract released on ⟬date#1⟭.
⟬end⟭

⟬template⟭
family: docs
format: ticket
language: en
fill_locale: en_US
domain: SaaS
appearance: table row, labelled headers, prose
scenario: the password reset flow, shows wrong figures for one customer
⟬text⟭
⟬ticket_id#1⟭ Password reset report: wrong count for one customer

Reset requests for this account show as 1,204 in the admin report over thirty days. The auth logs show 12. The record below comes straight from the back office, so that the report query can be run against it.

| Name | Email | Billing address | Payout IBAN |
| --- | --- | --- | --- |
| ⟬person_name#1⟭ | ⟬email#1⟭ | ⟬postal_address#1⟭ | ⟬iban#1⟭ |

Observed

The report joins reset events to the billing table. This customer has a hundred billing contacts, so each reset is counted once per contact.

Expected

One row per reset event, whatever the number of billing contacts.

Proposed change

Count distinct event ids in the report query, and add a fixture with several billing contacts. The figures shown to customers are not affected, since the report is internal.

Priority: medium. Reported on ⟬date#1⟭ by the Customer Success team.
⟬end⟭

⟬template⟭
family: docs
format: ticket
language: en
fill_locale: en_US
domain: SaaS
appearance: quoted message, prose, table, comment thread
scenario: the accessibility audit, is planned for next quarter
⟬text⟭
⟬ticket_id#1⟭ Accessibility audit for next quarter

A customer wrote to us on ⟬date#2⟭: "I use a screen reader every working day, and your invoice page is the one place I cannot get past. My name is ⟬person_name#1⟭ and my work email is ⟬email#1⟭. Please write to me when this is fixed, and I am happy to test it for you." This request is why the audit moved up the roadmap, and the name and email are kept here because the customer has agreed to be contacted for testing.

## Goal

Run an external accessibility audit of the core product next quarter, fix the blocking issues, and publish an updated conformance statement.

## Scope

In scope:

- Sign-in and account settings
- Dashboard
- Invoices and billing
- Reports
- The public help center

Out of scope for now:

- The mobile apps, which get their own audit
- Embedded third-party widgets, apart from a list of known gaps

## Standard

We will audit against WCAG 2.2 level AA, using a sample of pages agreed with the vendor. The audit combines automated checks, manual review and sessions with assistive technology users.

## Plan

| Phase | When | Output |
| --- | --- | --- |
| Vendor selection | Month 1 | Signed statement of work |
| Internal fixes | Month 1 | Known issues cleared |
| Audit | Month 2 | Findings report |
| Remediation | Month 2-3 | Fixes shipped |
| Retest | Month 3 | Updated statement |

## Vendor selection

We have quotes from ⟬trap:company_name|⦃Family⦄ Access⟭ and ⟬company#2⟭. The comparison sheet lists rates, sample sizes and whether users of assistive technology take part. The procurement review needs two weeks.

## Internal work before the audit

- Fix the invoice table, which has no header cells.
- Add visible focus to the sidebar.
- Label every icon button.
- Check the color contrast of status badges.
- Run the automated checks in CI.

## Customer testing

The customer quoted above has offered to test. Customer Success will arrange it, and it should happen after the invoice fix ships. The session must be paid for, like any other research session.

## Risks

- Remediation competes with the billing migration for the same engineers.
- Findings in the design system would touch every page.

## Definition of done

- No blocking or serious findings left on the retest.
- Conformance statement published.
- Accessibility checks added to the release checklist.

## Comments

**Design:** We can give one designer to this for the quarter.

**Billing team:** The invoice table fix fits into the next sprint.

**Legal:** Please send us the statement before publication.

**Customer Success:** I will reply to the customer this week with a rough date.
⟬end⟭

⟬template⟭
family: docs
format: pull request description
language: en
fill_locale: en_US
domain: SaaS
appearance: bullet list, labelled fields, markdown headings
scenario: the mobile app release, fails after an upgrade
⟬text⟭
## Unblock the mobile release after the toolchain upgrade

### Context

The release build has failed since the toolchain moved to ⟬version#1⟭. The new compiler rejects two deprecated build flags, and the crash reporting plugin has no release for this version yet.

### People

- Author: ⟬person_name#1⟭
- Reviewer: ⟬person_name#2⟭
- Release manager: ⟬person_name:initial#3⟭
- Approved by: ⟬person_name#4⟭

### Changes

- Remove the two deprecated flags.
- Pin the crash reporting plugin to the last working version.
- Move the build cache key to include the toolchain version.

### Testing

Built and installed on both platforms. Smoke test passed on ⟬date#1⟭.

### Follow-up

Unpin the plugin when the vendor ships support, tracked in ⟬ticket_id#1⟭.
⟬end⟭

⟬template⟭
family: docs
format: wiki page
language: en
fill_locale: en_US
domain: healthcare
appearance: footer, connection string, prose
scenario: the single sign-on setup, moves to a new provider
⟬text⟭
# Single sign-on: move to ⟬company#1⟭

Clinical applications move in three waves, starting ⟬date#1⟭. The electronic chart goes last, after the night shift pilot. Staff keep their usernames, and multi-factor enrolment is required before each wave.

Old provider stays up for thirty days as a fallback.

---
Page footer, added by the old template:
Identity on-call phone: ⟬phone#1⟭
Legacy directory bind password is in this URL: ldaps://sso-bind:⟬url_password#1⟭@⟬hostname#1⟭:636
⟬end⟭

⟬template⟭
family: docs
format: ticket
language: en
fill_locale: en_US
domain: media
appearance: library name, code identifier, prose
scenario: the onboarding checklist, raises a question nobody can answer
⟬text⟭
⟬ticket_id#1⟭ Onboarding checklist: which setup step still applies?

The checklist tells new developers to install the ⟬trap:library|Jenkins⟭ agent and the ⟬trap:library|Mockito⟭ fixtures and to run `⟬trap:code_identifier|⦃family⦄_bootstrap⟭`. Nobody can tell if that script is still needed, and it isn't in any repository we can find.

Should we remove the step? No team claims it.
⟬end⟭

⟬template⟭
family: docs
format: formal email
language: en
fill_locale: en_US
domain: government
appearance: email signature, prose, numbered list
scenario: the webhook retries, shows wrong figures for one customer
⟬text⟭
Subject: Grant portal webhook retries: inflated payment count

Dear colleagues,

We are writing to let you know of an error affecting one grant recipient's figures in the portal. Since ⟬date#2⟭, the payment notifications sent to that recipient's system have been retried after a successful delivery, and its dashboard counts each retry as a payment.

The Treasury records are correct. No payment was made twice.

We propose the following steps:

1. Disable automatic retries for this recipient until the fix is live.
2. Add a delivery id to each notification, so that a repeated one can be ignored.
3. Rebuild the dashboard figures from the Treasury records.

The fix is planned for ⟬date#1⟭. Please tell us if another recipient reports similar figures.

With kind regards,

⟬person_name#1⟭
⟬job_title#1⟭
Office of Grants Management
⟬email#1⟭
⟬phone#1⟭
⟬end⟭

⟬template⟭
family: docs
format: README .md
language: en
fill_locale: en_US
domain: fintech
appearance: markdown headings, shell block, closing remark
scenario: the quarterly planning, is being retired
⟬text⟭
# q-plan

Scripts that built the quarterly planning deck for the Finance leadership team. The quarterly planning process is being retired in favor of a rolling forecast, so this repository is frozen. It stays online for reference until the audit of the current fiscal year ends.

## What it did

- Pulled headcount from the HR export.
- Pulled actuals from the ledger reporting views.
- Filled the slide template and uploaded it to the shared drive.

## Setup

```bash
python -m venv .venv
. .venv/bin/activate
pip install -r requirements.txt
python qplan.py --quarter last --dry-run
```

## Output

Files land in `out/`, one per department. Nothing is written back to the ledger.

## Status

No new features. Bugs are fixed only if they block the audit.

## Last note

If you need a rerun for the auditors, the reporting view still expects the old read-only account. Its login is `⟬username#1⟭`, and the password is ⟬password#1⟭.
⟬end⟭

⟬template⟭
family: docs
format: README .md
language: en
fill_locale: en_US
domain: retail
appearance: markdown table, key-value line, version
scenario: the data deletion requests, moves to a new provider
⟬text⟭
# deletion-bridge

Forwards customer data deletion requests from the storefront to the new privacy provider. The old provider's queue closes on ⟬date#1⟭.

Maintainer: ⟬trap:indicator_non_pii|privacy-engineering⟭
Customer data in this repository: ⟬trap:indicator_non_pii|none⟭

## Compatibility

| Component | Version | Since |
| --- | --- | --- |
| Bridge | ⟬version#1⟭ | ⟬date#2⟭ |
| Provider SDK | ⟬version#2⟭ | ⟬date#2⟭ |
| Queue schema | ⟬version#3⟭ | ⟬date#3⟭ |

## Sample event

Request ⟬uuid#1⟭ for customer ⟬customer_id#1⟭, order ⟬order_number#1⟭, was accepted in ticket ⟬ticket_id#1⟭. Events carry identifiers only.

## Run

```bash
npm ci
npm start
```

## Migration status

Requests older than the switch stay with the old provider until they close. New requests go to the new provider only. A daily job compares both queues, and differences go to `reports/`.

## Tests

`npm test` covers the event mapping and the retry path.
⟬end⟭
