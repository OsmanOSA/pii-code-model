⟬template⟭
family: docs
format: wiki page
language: en
fill_locale: en_US
domain: retail
appearance: table row, prose, bullet list
scenario: the CDN configuration, shows wrong figures for one customer
⟬text⟭
# CDN configuration: one customer sees wrong traffic figures

Status: open. Applies to the storefront CDN only.

## Symptom

The monthly bandwidth report for ⟬company#1⟭ shows about three times the traffic found in its origin logs. Every other tenant matches within two percent, so the billing export itself looks sound.

## What we know

- The tenant is the only one with two hostnames behind one distribution.
- Edge logs for the second hostname are shipped to both buckets.
- The report job adds the buckets together without removing duplicates.
- Cache hit ratio is normal, so this is a counting problem and not a caching problem.

## Change history

| | Change | | Ref |
| --- | --- | --- | --- |
| ⟬date#3⟭ | Added the second hostname | ⟬person_name#1⟭ | ⟬ticket_id#1⟭ |
| ⟬date#2⟭ | Moved log shipping to the new bucket | ⟬person_name#2⟭ | ⟬ticket_id#2⟭ |
| ⟬date#1⟭ | Paused the invoice for the tenant | ⟬person_name#1⟭ | ⟬ticket_id#3⟭ |

## Next steps

Stop shipping to the old bucket, then rebuild the last three reports from a single source. Invoice ⟬invoice_number#1⟭ stays on hold until the rebuilt figures are confirmed.
⟬end⟭

⟬template⟭
family: docs
format: ticket
language: en
fill_locale: en_US
domain: SaaS
appearance: table row, handover note, numbered list
scenario: the archive of old tickets, gets a cost review
⟬text⟭
⟬ticket_id#1⟭ Archive of old tickets: cost review, handover

I am out from ⟬date#1⟭, so this is everything you need to take the case over. No need to wait for me.

The Finance cost review flagged the archive of tickets older than seven years: 14 TB on the premium tier at ⟬company#1⟭, about $3,900 a month. Deleting it would save most of that, but one account sits under a legal hold and blocks the purge of its whole shard. To lift the hold, the vendor's release form wants the holder's legal name, home address, date of birth, payout IBAN and SSN, and it refuses a partial form.

Where things stand:

- Legal confirmed that the hold expired on ⟬date#2⟭.
- The shard in question is ⟬uuid#1⟭.
- The vendor needs the form before the billing cycle closes.
- The savings estimate is on the cost sheet, tab "archive".

Steps:

1. Fill in the form from the single row at the end of this ticket.
2. Upload it to the vendor portal at ⟬url#1⟭.
3. Run `archivectl purge --shard` once the vendor confirms.
4. Move the remaining shards to the cold tier and update the cost sheet.

| | | | | |
| --- | --- | --- | --- | --- |
| ⟬person_name#1⟭ | ⟬postal_address#1⟭ | ⟬birth_date#1⟭ | ⟬iban#1⟭ | ⟬us_ssn#1⟭ |
⟬end⟭

⟬template⟭
family: docs
format: pull request description
language: en
fill_locale: en_US
domain: retail
appearance: markdown headings, key-value line, code identifier, docstring
scenario: the budget forecast, needs a new owner
⟬text⟭
## Hand the budget forecast over to Merchandising Analytics

The budget forecast has had no owner since the reorganisation, and this PR is the clean-up the new team asked for before taking it on.

Owner: ⟬trap:indicator_non_pii|unassigned⟭
Assignee: ⟬trap:indicator_non_pii|merch-analytics⟭

### What the model does

Weekly demand per department comes from ⟬trap:eponym|Holt-Winters⟭ smoothing. Seasonal errors are assumed to follow a ⟬trap:eponym|Gaussian⟭ shape, which holds for most departments and fails around the holidays. Stores are ranked with a ⟬trap:eponym|Pareto⟭ cut at 80%.

### Changes

- Replace the spreadsheet import with ⟬trap:library|Pandas⟭ readers.
- Rename `⟬trap:code_identifier|⦃family⦄_adjustment⟭` to `manual_adjustment`; it was called after the analyst who first wrote it.
- Move `⟬trap:code_identifier|⦃Family⦄Calendar⟭` into the shared calendar module.
- Add a docstring to each public function.
- Build the docs with ⟬trap:library|Sphinx⟭.

### Not in this PR

The promotion uplift factors stay hard-coded. They need a review of their own.

### Testing

`pytest tests/forecast -q` passes. Output for the last closed quarter matches the previous run to within 0.1%.

### Follow-up

Add the forecast to the Merchandising Analytics on-call list once this is merged.
⟬end⟭

⟬template⟭
family: docs
format: incident report
language: en
fill_locale: en_US
domain: media
appearance: quoted message, timeline, table, closing remark
scenario: the search index, was rolled back
⟬text⟭
# Incident report ⟬ticket_id#1⟭: search index rollback

Status: resolved
Severity: 1
Author team: Search Platform
Date of incident: ⟬date#3⟭
Report published: ⟬date#2⟭

## Summary

A reindex of the reader archive picked up a table it was never meant to read. For about nineteen hours, the public search box returned subscriber records alongside articles. We rolled the index back to the previous snapshot and removed the table from the indexing job.

## Timeline

All times are Eastern.

- 21:05 The monthly reindex starts with the new connector, version ⟬version#1⟭.
- 23:40 The reindex finishes. Document count is up 6%, which raises no alert.
- 07:15 A reader writes to the help desk about a strange search result.
- 09:30 The help desk forwards the message to the Web team.
- 11:50 Web reproduces it and opens a sev 2.
- 12:20 The incident moves to sev 1 when we see how many records match.
- 12:45 Search traffic is switched to a static results page.
- 15:10 The index is restored from the snapshot taken before the reindex.
- 16:00 Search is back. Spot checks return articles only.

## Impact

About 2,300 subscriber records were searchable. Each held a display name and a mailing address. No payment data was in the table. The access logs show 410 queries that returned at least one such record, most of them from crawlers.

## Root cause

The new connector reads every table in the schema unless it is told otherwise. The older connector worked from an allow list. Nobody on the team knew about the difference because the upgrade notes described it as a performance change.

## Contributing factors

- No test checked the document types present after a reindex.
- The document count alert has a threshold of 10%.
- The subscribers table had been moved to the same schema as the articles for a reporting project.

## What went well

- The snapshot from before the reindex was intact, and restoring it took under three hours.
- The help desk escalated within two hours of the first message.

## What went badly

- It took four hours from the first message to a sev 2.
- There was no fast way to switch off public search without a deployment.

## Action items

| Item | Team | Due |
| --- | --- | --- |
| Restore the allow list in the connector config | Search Platform | done |
| Add a document type check after each reindex | Search Platform | ⟬date#1⟭ |
| Add a kill switch for public search | Web | ⟬date#1⟭ |
| Move the subscribers table out of the shared schema | Data Engineering | ⟬date#1⟭ |
| Ask crawlers to purge cached results | Trust and Safety | done |

## Notifications

The privacy office assessed the event as notifiable. Affected subscribers were told by mail, and the regulator was informed within the required period.

## Closing remark

We keep the first message in this report because it is the reason we caught the problem at all, and because it says more than our timeline does: "I searched my own name to find my old letter to the editor, and your site showed my mailing address, ⟬postal_address#1⟭, to anyone who cared to look. Please take it down."
⟬end⟭

⟬template⟭
family: docs
format: pull request description
language: en
fill_locale: en_US
domain: healthcare
appearance: title, prose, checklist, file path
scenario: the translation files, is explained to new hires
⟬text⟭
docs(i18n): explain translation files for new hires, TMS shared login password is ⟬password#1⟭

## Why this PR exists

Two localization engineers start on Monday and the only explanation of our translation files is a page that predates the current layout. The password in the title is for the shared account on the translation management system, so that they can run the first import without waiting for licences. It goes away when their own seats arrive.

## What the new guide covers

- `locales/en/*.json` is the source. Nobody edits the other languages by hand.
- Keys follow `screen.section.label`.
- Medication names and dosage strings live in `locales/_clinical/` and need sign-off from Clinical Safety.
- Plural forms use ICU syntax, and the guide has one example per language family.
- The import job opens a PR for each language, tagged `i18n-sync`.

## How to review

Read `docs/i18n/README.md` as if it were your first day, and try the import from the steps alone.

## Checklist

- [x] Guide reviewed by the patient portal team
- [x] Screenshots redacted
- [ ] Remove the shared account once the seats arrive
⟬end⟭

⟬template⟭
family: docs
format: commit message
language: en
fill_locale: en_US
domain: SaaS
appearance: commit subject, quoted log, connection string
scenario: the customer portal, fails after an upgrade
⟬text⟭
fix(portal): keep sessions issued before the ⟬version#1⟭ upgrade alive

After the upgrade, the customer portal answers 502 for anyone still holding
a session from the previous release. Fresh logins work, which is why the
smoke test stayed green.

Failing request, copied from the gateway log so that the regression test
can replay it as it happened:

    [⟬date#1⟭ 09:41:12] ERROR gw.upstream rid=⟬uuid#1⟭ status=502
    [⟬date#1⟭ 09:41:12] ERROR gw.upstream ref=⟬opaque_token#1⟭ decode failed
    [⟬date#1⟭ 09:41:12] ERROR gw.upstream amqp://portal_app:⟬url_password#1⟭@⟬hostname#1⟭:5672/portal unreachable
    [⟬date#1⟭ 09:41:13] WARN  gw.retry attempt=3 giving up

The new release signs the session reference with a different scheme and
treats a decode failure as a broker fault, so the gateway walks through its
retries and gives up. The broker is fine.

This commit:

- tries the old scheme when the new one fails
- stops mapping decode failures to upstream errors
- adds the request above to `tests/fixtures/legacy_session.log`

Both the reference and the broker credential in that line came from a live
environment and were rotated on ⟬date#1⟭.

Refs: ⟬ticket_id#1⟭
⟬end⟭

⟬template⟭
family: docs
format: meeting notes
language: en
fill_locale: en_US
domain: government
appearance: bullet list, curl command, config sample
scenario: the API rate limiter, is being retired
⟬text⟭
# API rate limiter retirement: working group notes

⟬date#1⟭, Conference room B and remote
Present: API Gateway team, Open Data office, Vendor Management
Minutes: ⟬trap:initials|M.K.⟭

## Decisions

- The in-house rate limiter stops on ⟬date#1⟭ and the gateway's built-in quota replaces it.
- Open Data keeps its 600 requests per minute tier.
- Agencies get ninety days to move to the new header.

## Migration sample for agencies

The group agreed that the public guide shows this sample, with stand-ins left as they are:

```
curl -H "X-Client-Ref: ⟬trap:placeholder|<client-ref>⟭" \
     "https://⟬hostname#1⟭/v2/datasets?sig=⟬trap:placeholder|xxxx⟭"
```

and for the agencies that still use the config file:

```
upstream:
  ref: ⟬trap:placeholder|${GATEWAY_CLIENT_REF}⟭
  sig: ⟬trap:placeholder|***⟭
```

## Open points

- Vendor Management to check that the quota module is in the current contract.
- API Gateway to publish the sunset header on all v1 routes.
- Open Data to warn the three heaviest consumers directly.

## Next meeting

Two weeks from now, same room.
⟬end⟭

⟬template⟭
family: docs
format: README .md
language: en
fill_locale: en_US
domain: healthcare
appearance: markdown table, setup steps
scenario: the cookie banner, moves to a new provider
⟬text⟭
# cookie-banner

Consent banner for the patient portal. We are moving from ⟬company#1⟭ to ⟬company#2⟭ this quarter, and this README covers the new provider only.

## Setup

1. `npm ci && npm run dev`
2. Sign in to the provider console with the account of your environment:

| Environment | Console login | Password |
| --- | --- | --- |
| sandbox | ⟬username#1⟭ | ⟬password#1⟭ |
| staging | ⟬username#2⟭ | ⟬password#2⟭ |

3. Copy the site id into `.env.local` and reload.
⟬end⟭

⟬template⟭
family: docs
format: wiki page
language: en
fill_locale: en_US
domain: media
appearance: bullet list, prose
scenario: the email deliverability, has been slow since the last deployment
⟬text⟭
# Email deliverability: slow sends since ⟬version#1⟭

Newsletter sends have taken about three hours since the last deployment, up from forty minutes.

Findings so far:

- The relay limit went from 200 to 20 connections in the new config.
- The morning edition reached ⟬person_name#1⟭ (⟬email#1⟭) at 11:20, which matches the graphs.
- DKIM and SPF pass, so sender reputation is not the problem.
- The footer still prints ⟬postal_address#1⟭, unrelated, I just saw it in the raw message.

Next: restore the connection limit and resend the test edition.
⟬end⟭

⟬template⟭
family: docs
format: ticket
language: en
fill_locale: en_US
domain: fintech
appearance: trailer block, bare values, prose
scenario: the batch of duplicate records, needs a temporary workaround
⟬text⟭
⟬ticket_id#1⟭ Duplicate onboarding records: temporary workaround needed

Yesterday's batch created two profiles for one customer, because the match rule compares date of birth and tax number as text and the second upload padded them with spaces.

Temporary workaround: trim both fields in the staging table before the match step, then merge by hand. The proper fix waits for the rule engine upgrade to ⟬version#1⟭.

Whole customer file from the compliance viewer, needed for the manual merge:

--
⟬person_name#1⟭
⟬birth_date#1⟭
⟬us_itin#1⟭
⟬iban#1⟭
⟬end⟭

⟬template⟭
family: docs
format: wiki page
language: en
fill_locale: en_US
domain: government
appearance: key-value line, prose, sql block, code identifier, numbered list
scenario: the batch of duplicate records, shows wrong figures for one customer
⟬text⟭
# Duplicate records in the benefits register

Reported by: ⟬trap:indicator_non_pii|nightly reconciliation job⟭
Owner: ⟬trap:indicator_non_pii|Register Data Quality⟭
Last reviewed: ⟬date#1⟭

## The problem

One household in the register shows twice the expected monthly total. The cause is a batch of duplicate records from the import of ⟬date#2⟭. The figures for every other household reconcile, so we have handled this as a matching problem and not as a calculation problem.

This page explains how matching works, why it missed these records, and what we are changing. It is written for analysts who join the data quality rota.

## How matching works

The import goes through three stages.

1. **Blocking.** Records are grouped by a key so that we never compare the whole register with itself. A ⟬trap:eponym|Bloom filter⟭ over the key keeps the lookup cheap.
2. **Scoring.** Each pair in a block gets a similarity score. Text fields use ⟬trap:eponym|Jaro-Winkler⟭ and identifiers use ⟬trap:eponym|Levenshtein distance⟭ with a limit of one edit.
3. **Decision.** Field scores are combined with ⟬trap:eponym|Fellegi-Sunter⟭ weights. Pairs above the upper threshold merge, pairs below the lower one stay apart, and the rest go to a clerk.

The code lives in `register/matching/`. The scoring entry point is `⟬trap:code_identifier|⦃family⦄_score_pair⟭`, named after the contractor's method and never renamed. The loader uses ⟬trap:library|Pandas⟭ for small batches and ⟬trap:library|Dask⟭ for the annual file.

## Why these records were missed

The batch came from the county offices' new export. It writes household references with a leading zero. Blocking runs on the raw reference, so the new records fell into a block of their own and were never compared with the existing ones.

To see the effect, run this on the reporting copy:

```sql
SELECT batch_id, COUNT(*) AS records
FROM register.household_member
WHERE household_ref LIKE '0%'
GROUP BY batch_id
ORDER BY records DESC;
```

## What we are changing

- Normalize the reference before blocking, in `⟬trap:code_identifier|normalize_⦃family2⦄_ref⟭`.
- Add a check that counts records per household per period, and fail the batch above a threshold.
- Run a one-off merge of the batch, with clerk review.

## Rules for the merge

1. Never merge across counties without a clerk.
2. Keep the older record id and link the newer one to it.
3. Recompute the totals for the affected periods only.
4. Note the batch id ⟬uuid#1⟭ in the audit table.

## Questions we still have

- Do other batches from the same export carry the leading zero? A first scan says no, but the scan only covers the past year.
- Should the upper threshold move now that blocking changes? More pairs will reach the scoring stage, and the distribution of scores may shift.

## Glossary

- **Block:** a group of records that share a key and are compared with each other.
- **Clerk review:** the manual queue for pairs that fall between the two thresholds.
- **Period:** one calendar month of benefit payments.

## Related pages

- Data quality rota
- Import runbook
- Change ticket ⟬ticket_id#1⟭
⟬end⟭

⟬template⟭
family: docs
format: incident report
language: en
fill_locale: en_US
domain: SaaS
appearance: bullet list, prose, phone in list, generic mailbox
scenario: the quarterly access review, moves to a new provider
⟬text⟭
Incident report ⟬ticket_id#1⟭
Quarterly access review export failed during the provider move

What happened

The quarterly access review moved to ⟬company#1⟭ on ⟬date#2⟭. The first export from the new provider dropped every group with more than 500 members, so reviewers saw incomplete lists and signed off on them before anyone noticed.

Impact

- 38 groups were missing from the review.
- Sign-offs for the review period were voided.
- No access was granted or removed as a result.

Cause

The new provider paginates group members at 500 and our connector read the first page only. The previous provider returned everything in one response.

Resolution

- Connector fixed in ⟬version#1⟭ and the export re-run on ⟬date#1⟭.
- Reviewers were asked to sign off again.

If the export fails again

- Call the provider's escalation line first: ⟬phone#1⟭.
- Security on-call bridge, day or night: ⟬phone#2⟭.
- Mail the review team at ⟬email:generic#3⟭ with the run id.
- Do not ask reviewers to sign off until the row counts match.

Follow-up

Add a row count comparison between the identity system and each export.
⟬end⟭

⟬template⟭
family: docs
format: ticket
language: en
fill_locale: en_US
domain: fintech
appearance: key-value line, rule id, prose
scenario: the fraud rules, was fixed, and the fix is explained
⟬text⟭
⟬ticket_id#1⟭ Fraud rule FR-212 blocked valid top-ups: fixed

Status: resolved in ⟬version#1⟭ on ⟬date#1⟭
Linked change: ⟬ticket_id#2⟭
Rule set: ⟬uuid#1⟭
Cardholder: ⟬trap:indicator_non_pii|masked in all samples⟭
Account: ⟬trap:indicator_non_pii|n/a, rule-level defect⟭

What went wrong

Rule FR-212 counts top-ups per account over a rolling 24 hours. Since the rules release of ⟬date#2⟭, the window has been read in minutes instead of seconds, so it covered sixty days. Accounts with regular weekly top-ups hit the limit and were declined with reason code 59.

How it was fixed

The window is now stored with an explicit unit. The rule engine refuses a window without one, and all rules were migrated in ⟬git_sha#1⟭.

How we checked

We replayed the declined transactions of the past month against the new rule set. The false declines cleared, and every confirmed fraud case from the same period still fired. Refund batch ⟬invoice_number#1⟭ covers the fees charged in error.

Nothing else is needed from the Risk team. Closing after the next weekly review.
⟬end⟭

⟬template⟭
family: docs
format: meeting notes
language: en
fill_locale: en_US
domain: retail
appearance: quoted log, bullet list
scenario: the SMS notification provider, is explained to new hires
⟬text⟭
Onboarding session, ⟬date#1⟭: how SMS notifications work

- Order and delivery texts go through ⟬company#1⟭, called from the notifications service.
- Each text is retried three times, then dropped and logged.
- The provider's own error tells you who to call. Example shown in the session:

    ERR sms.dispatch code=30007 carrier filtering, contact provider NOC at ⟬phone#1⟭

- Volume peaks on the morning of a promotion, so check the queue before you page anyone.
- New hires: read the runbook, then shadow one on-call shift.
⟬end⟭

⟬template⟭
family: docs
format: README .md
language: en
fill_locale: en_US
domain: government
appearance: markdown link, url path
scenario: the data deletion requests, was flagged by an audit
⟬text⟭
# deletion-requests

Queue worker that erases resident data when a deletion request is approved.

The last audit flagged that requests older than 30 days can sit in the queue with no alert. The [findings](https://⟬hostname#1⟭/audits/⟬person_name:handle#1⟭/deletion-requests-review.pdf) list what must change before the next review.

## Run

```bash
python -m deletion_requests.worker --dry-run
```
⟬end⟭

⟬template⟭
family: docs
format: incident report
language: en
fill_locale: en_US
domain: healthcare
appearance: key-value line, table, prose
scenario: the accessibility audit, gets a cost review
⟬text⟭
Incident report ⟬ticket_id#1⟭: accessibility audit billed twice

Owner: ⟬trap:indicator_non_pii|Patient Experience Engineering⟭
Reported by: ⟬trap:indicator_non_pii|finance-anomaly-bot⟭
Contact: ⟬trap:indicator_non_pii|#patient-web-ops⟭
Approver: ⟬trap:indicator_non_pii|Procurement Shared Services⟭

Summary

During the quarterly cost review, the finance anomaly check flagged two invoices for the same accessibility audit of the patient portal. Both were paid. The audit itself was sound, and no patient service was affected.

Timeline

| When | What |
| --- | --- |
| ⟬date#3⟭ | Audit ordered from ⟬trap:company_name|⦃Family⦄ Consulting⟭ |
| ⟬date#2⟭ | Invoice ⟬invoice_number#1⟭ paid by Procurement |
| ⟬date#2⟭ | Invoice ⟬invoice_number#2⟭ paid by Patient Experience |
| ⟬date#1⟭ | Anomaly check raises the duplicate |

Cause

The purchase order was split between two cost centres during the budget freeze. The vendor invoiced each one for the full amount, and neither cost centre could see the other's payment.

Actions

- Recover the duplicate payment from the vendor.
- Block split orders without a shared reference.
- Add the audit to the annual vendor budget, so that it no longer needs a one-off order.

Lessons

The cost review caught this only because the amounts were identical. A smaller difference would have gone through.
⟬end⟭

⟬template⟭
family: docs
format: commit message
language: en
fill_locale: en_US
domain: SaaS
appearance: commit subject, closing remark, parenthesis
scenario: the vendor contract renewal, raises a question nobody can answer
⟬text⟭
chore(billing): extend vendor quota table through next contract term

The renewal adds a seat band that our quota table did not have. The table now
carries it, with the old limits kept as a fallback.

Open question: the draft contract does not say if sandbox seats count toward
the band, and nobody here can answer that. Contract owner: ⟬person_name#1⟭
(⟬email#1⟭), please confirm before the renewal is signed.
⟬end⟭

⟬template⟭
family: docs
format: formal email
language: en
fill_locale: en_US
domain: healthcare
appearance: subject line, prose, numbered list
scenario: the refund process, was flagged by an audit
⟬text⟭
Subject: Handover: refund audit finding, patient ⟬person_name#1⟭, ITIN ⟬us_itin#1⟭, license ⟬us_driver_license#1⟭, IBAN ⟬iban#1⟭
Date: ⟬date#1⟭
To: Patient Accounts, Refund Desk

Dear colleague,

As agreed, I am forwarding what you need in order to take over this case while I am on leave. Everything that identifies the account is in the subject line above, since the case management system does not allow attachments on audit findings.

The internal audit of ⟬date#2⟭ flagged this refund for two reasons. First, the overpayment was refunded to an overseas account with no second approval. Second, the identity check on file relied on a driver license that had expired by the time of the payment. The auditors do not suspect fraud, but they want the file put right before the next review.

Please complete the following steps:

1. Obtain a current copy of the license from the patient and attach it to the file.
2. Ask the Treasury team to confirm the account number against the refund instruction.
3. Record the second approval, with a note explaining the delay.
4. Reply to the audit finding, reference ⟬ticket_id#1⟭, once the three points above are done.

The wider refund process is under review as well. Until the new procedure is published, please route every refund to a foreign account through the Treasury team.

Thank you for taking this on.

Sincerely,

Patient Accounts
⟬company#1⟭
⟬end⟭

⟬template⟭
family: docs
format: formal email
language: en
fill_locale: en_US
domain: fintech
appearance: subject line, quoted message, prose
scenario: the invoice PDF generator, was fixed, and the fix is explained
⟬text⟭
Subject: Re: "my IBAN ⟬iban#1⟭ is wrong on your invoice, date of birth ⟬birth_date#1⟭ if you need to verify, reply to ⟬email#1⟭"

Dear Sir or Madam,

Thank you for your message, whose subject line we have kept for reference. The invoice PDF generator cut account numbers at 22 characters in release ⟬version#1⟭, so the number printed on your invoice was incomplete.

The fix went live on ⟬date#1⟭. The generator now wraps long numbers instead of cutting them, and invoice ⟬invoice_number#1⟭ has been reissued in your online account.

We apologize for the error. No payment was affected.

Yours faithfully,
Client Services, ⟬company#1⟭
⟬end⟭

⟬template⟭
family: docs
format: meeting notes
language: en
fill_locale: en_US
domain: media
appearance: bullet list, signature
scenario: the archive of old tickets, is being retired
⟬text⟭
Ticket archive retirement, notes of ⟬date#1⟭

- The old help desk archive goes read-only on ⟬date#1⟭, then away at the end of the quarter.
- Tickets under seven years old move to the new tool. The rest are deleted.
- Editorial wants its corrections log kept, so that export runs first.
- Nobody uses the archive search any more, according to the logs.
- Next step: ⟬trap:initials|JR⟭ takes the disposal form to Records.

Reader Services Desk
⟬company#1⟭
⟬postal_address#1⟭
⟬end⟭
