⟬template⟭
family: docs
format: ticket
language: en
fill_locale: en_US
domain: fintech
appearance: markdown headings, comment thread, quoted message, labelled fields
scenario: the pricing page, moves to a new provider
⟬text⟭
⟬ticket_id#1⟭ Move the pricing page to the new CMS provider

Type: Story
Priority: High
Component: Marketing Web
Requested by: Growth Marketing
Target: ⟬date#1⟭

## Description

The public pricing page is the last page still served by ⟬company#1⟭. That contract ends this quarter, and everything else on the marketing site already runs on ⟬company#2⟭.

The page is more than static content. It has:

- a fee calculator for card issuing and transfers
- a country selector that changes the fees shown
- a price alert form that stores subscriptions with the provider
- legal footnotes per region, reviewed by Compliance

## Why this ticket was reopened

The first migration attempt, on ⟬date#3⟭, copied the price alert subscribers along with the page. Some of them had opted out. Compliance asked us to stop and to handle the subscriber list as a data transfer of its own.

## Plan

1. Freeze content on the old page.
2. Export the fee tables to the new content model.
3. Rebuild the calculator as a component, with tests taken from the fee schedule.
4. Export only the subscribers with a valid consent record.
5. Delete the copied list at the new provider and get written confirmation.
6. Switch the pricing path over.
7. Cancel the old contract.

## Acceptance criteria

- Calculator output equals the fee schedule for all 41 countries.
- Legal footnotes match the approved text.
- No subscriber without consent exists at the new provider.
- The page loads in under two seconds on a mid-range phone.
- Redirects from the old URLs are in place.

## Risks

- A fee table changes during the freeze.
- The old provider's export API is rate limited to 60 calls an hour.

## Comments

**Web team:** Calculator component is ready behind a flag.

**Compliance:** The consent export looks right on the sample. We still need the deletion confirmation before we can sign.

**Growth Marketing:** Fine by us. The campaign can wait a week.

**Support:** One person wrote in about this and expects a direct answer once the list is clean. Please keep the ticket open until then.

## Closing remark

This is the message that made us reopen the ticket. It stays here until the reply has gone out:

> I opted out of your price alerts last year, and yesterday I got one from a company I never heard of. Please confirm that my details are gone from both places.
> Name: ⟬person_name#1⟭
> Email: ⟬email#1⟭
⟬end⟭

⟬template⟭
family: docs
format: wiki page
language: en
fill_locale: en_US
domain: retail
appearance: code block, yaml block, shell command, numbered list
scenario: the on-call rota, is being retired
⟬text⟭
# Retiring the stores on-call rota

Page maintained by Site Reliability. Last updated ⟬date#1⟭.

## Summary

The shared spreadsheet that has driven the stores on-call rota since the ⟬trap:word_name|Charlotte⟭ distribution center opened is being retired. From ⟬date#1⟭, schedules live in the paging tool. This page records what happens to the old rota, who signed it off, and what each team must do.

## Why we are doing this

- Swaps made in the spreadsheet never reached the paging tool.
- Two people were paged for the same alert on most weekends.
- Nobody could say who was on call for the point-of-sale systems on public holidays.
- Payroll needed the on-call allowance report, which had to be built by hand.

## What changes

| Before | After |
| --- | --- |
| Spreadsheet edited by team leads | Schedule edited in the paging tool |
| Swaps agreed in chat | Swaps recorded as overrides |
| Monthly allowance sheet | Report from the paging tool API |

## Final export

The last version of the rota goes to the records archive. The export below is the command that was agreed in the change review, and the approval is recorded on the command line so that it ends up in the archive header:

```bash
rotactl export \
  --schedule stores-primary \
  --format csv \
  --approved-by "⟬person_name#1⟭" \
  --out rota-final.csv
```

## Schedule definition

Each schedule in the paging tool now comes from this file, which is reviewed like code:

```yaml
schedule: stores-primary
timezone: America/New_York
rotation: weekly
handoff: "09:00"
owner: ⟬person_name#2⟭
escalation:
  - stores-secondary
  - retail-duty-manager
```

## What each team must do

1. Check that your people are in the right schedule.
2. Move any planned swap to an override before the switch.
3. Remove the spreadsheet link from your runbooks.
4. Tell your team that alerts now come from one sender.

## Allowance reporting

Payroll takes the monthly report on the first working day. The report counts hours on call and hours worked after a page, and it replaces the old sheet in full. Questions about the amounts go to Payroll and not to Site Reliability.

## After the switch

The spreadsheet becomes read-only on ⟬date#1⟭. It is deleted after ninety days, in line with the retention schedule.

## Known gaps

- The warehouse scanner team has no schedule yet. It stays on its current phone tree until its tool is replaced.
- Overrides do not sync back to calendars. A fix is on the vendor's roadmap for version ⟬version#1⟭.

## See also

- Paging tool quick start
- Incident severity guide
- Change record ⟬ticket_id#1⟭
⟬end⟭

⟬template⟭
family: docs
format: ticket
language: en
fill_locale: en_US
domain: retail
appearance: key-value line, library name, code identifier
scenario: the penetration test findings, gets a cost review
⟬text⟭
⟬ticket_id#1⟭ Pen test findings: estimate the cost of the fixes

Reporter: ⟬trap:indicator_non_pii|security-scanner⟭
Assignee: ⟬trap:indicator_non_pii|appsec-triage⟭

Finance wants a cost per finding before approving the remediation budget.

- PT-03: outdated ⟬trap:library|Jackson⟭ databind on the order service, half a day.
- PT-07: weak ⟬trap:eponym|Diffie-Hellman⟭ group on the legacy gateway, two days with testing.
- PT-11: `⟬trap:code_identifier|⦃family⦄_discount_override⟭` skips the role check, one day.

Estimates are due before the budget meeting on ⟬date#1⟭.
⟬end⟭

⟬template⟭
family: docs
format: formal email
language: en
fill_locale: en_US
domain: SaaS
appearance: salutation, table, company name, code identifier, numbered list
scenario: the office move, needs a new owner
⟬text⟭
Subject: Office move: project owner needed from next month
Date: ⟬date#2⟭
To: Workplace Steering Group

Dear ⟬trap:indicator_non_pii|all⟭,

The move to the new office is entering its last three months, and the project needs a new owner. The current arrangement ends at the close of this month, when the Workplace function passes to the Finance group. Until somebody is named, the register will read as follows:

Project owner: ⟬trap:indicator_non_pii|vacant⟭
Deputy: ⟬trap:indicator_non_pii|to be confirmed⟭

I am writing to summarize where the project stands, what the new owner would take on, and what we need from the steering group.

Where the project stands

The lease on the new floors was signed in the spring, and the fit-out is on schedule. The latest ⟬trap:eponym|Gantt chart⟭ is in the project folder. The two contractors are ⟬trap:company_name|⦃Family⦄ & Sons Removals⟭, who handle the physical move, and ⟬trap:company_name|⦃Family2⦄ Interiors⟭, who are responsible for furniture and meeting rooms.

The following milestones are confirmed:

| Milestone | Status |
| --- | --- |
| Network cabling | Complete |
| Furniture delivery | In progress |
| Meeting room equipment | Ordered |
| Security access system | Awaiting test |
| Move weekend | Planned for ⟬date#1⟭ |

Meeting rooms

The rooms on the new floors keep the names staff chose in the survey. The two large rooms are the ⟬trap:eponym|Hopper room⟭ and the ⟬trap:eponym|Curie room⟭, and the quiet rooms take their names from units of measure, among them ⟬trap:eponym|Ampere⟭ and ⟬trap:eponym|Kelvin⟭. Signage has been ordered, and booking calendars will be created in the week before the move.

Asset register

All laptops, screens and docking stations must be registered before the move. The Internal Tools team built a small application for this on ⟬trap:library|Flask⟭, and the nightly job `⟬trap:code_identifier|⦃family3⦄_asset_sync⟭` reconciles it with the purchasing system. The job has been reliable, but its maintainer is moving to another team, so the new owner should agree on support with Internal Tools.

What the new owner would take on

1. Chairing the weekly project meeting.
2. Approving contractor invoices up to the agreed budget.
3. Signing off the fit-out with the landlord.
4. Managing communication to staff before and after the move.
5. Closing the old office, including the return of keys and the final inspection.

We estimate that this requires about two days a week until the move, and one day a week for the month after it.

Budget

The project remains within budget. Contingency stands at nine percent of the total, and no call on it is expected. The largest open item is the cost of restoring the old office to its original condition, which depends on the final inspection.

Risks

The main risk is the absence of an owner during the final weeks, when decisions tend to be needed within a day. A second risk is the security access system, whose test has slipped twice. If it slips again, we will need temporary guards on the entrance for the first week.

What we need from you

Please let me know by the end of this week if you, or someone in your group, could take on the role. If no volunteer comes forward, I will ask the executive sponsor to nominate someone at the next meeting.

Thank you for your support over the past year.

Yours sincerely,

Workplace Programme Office
⟬company#1⟭
⟬end⟭

⟬template⟭
family: docs
format: wiki page
language: en
fill_locale: en_US
domain: healthcare
appearance: table row, prose
scenario: the webhook retries, breaks for a single team
⟬text⟭
# Webhook retries: Scheduling team affected

Retries stopped for one subscriber after the queue moved to ⟬version#1⟭. Its endpoint answers 409 on duplicates, and the worker treats 409 as final.

| Subscriber | Retry policy | Owner | Status |
| --- | --- | --- | --- |
| Lab results | exponential | ⟬email#1⟭ | healthy |
| Scheduling | none since ⟬date#1⟭ | ⟬email#2⟭ | broken |

Treat 409 as success for idempotent events. Tracked in ⟬ticket_id#1⟭.
⟬end⟭

⟬template⟭
family: docs
format: README .md
language: en
fill_locale: en_US
domain: government
appearance: markdown headings, table, shell block, closing remark, connection string
scenario: the database migration, gets a small feature request
⟬text⟭
# permits-migrate

Moves the permits database from the old cluster to the managed service, one table group at a time. The tool is used by the Land Records team and by the two county offices that still run their own copy.

## Status

| Table group | State | Last run |
| --- | --- | --- |
| applications | done | ⟬date#3⟭ |
| inspections | done | ⟬date#2⟭ |
| fees | in progress | ⟬date#1⟭ |
| attachments | not started | |

## Requirements

- Python 3.11
- Network access to both clusters, usually through `ssh ⟬trap:email_lookalike|$USER@bastion⟭`
- A migration role with read access on the source and write access on the target

## Install

```bash
python -m venv .venv
. .venv/bin/activate
pip install -r requirements.txt
```

## Usage

Check what would move:

```bash
python -m permits_migrate plan --group fees
```

Run the copy:

```bash
python -m permits_migrate run --group fees --batch-size 5000
```

Compare row counts and checksums:

```bash
python -m permits_migrate verify --group fees
```

## How it works

1. The tool takes a consistent snapshot of the group on the source.
2. It copies rows in primary key order, in batches.
3. It records the last key of each batch, so that an interrupted run can resume.
4. It replays changes made since the snapshot.
5. It compares row counts and checksums on both sides.

## Rollback

The source stays writable until the group is verified. To roll back, stop the tool and drop the group on the target. Nothing on the source is changed.

## Feature request: table filter

The Land Records team has asked for one small addition. Today a run always covers a whole group. When one table fails its checksum, the whole group has to be copied again. The request is an `--only-table` option for `run` and `verify`.

Proposed behaviour:

- `--only-table` takes a single table name.
- The tool refuses the option when the table has unverified foreign keys.
- The resume file records the table, so a resumed run stays limited to it.

Tracked in ⟬ticket_id#1⟭, with a target of version ⟬version#1⟭.

## Tests

```bash
pytest -q
```

The integration tests need Docker and start two throwaway databases.

## Support

Open a ticket with the Land Records queue. Include the group, the run id and the last lines of the log.

## One last thing

This is the line from the fees run, for reference, straight out of my terminal:

```bash
python -m permits_migrate run --group fees --dsn "postgres://migrator:⟬url_password#1⟭@⟬hostname#1⟭:5432/permits" -k '⟬password#1⟭'
```
⟬end⟭

⟬template⟭
family: docs
format: meeting notes
language: en
fill_locale: en_US
domain: fintech
appearance: code block, quoted message, action table, bullet list
scenario: the CI pipeline, fails after an upgrade
⟬text⟭
# Engineering sync: CI pipeline failures

Date: ⟬date#1⟭
Facilitator: Developer Experience rotation
Teams present: Payments API, Mobile SDK, Developer Experience, Partner Success

## Agenda

1. Status of the pipeline since the runner upgrade
2. Impact on partners
3. Decisions
4. Actions

## 1. Status

The CI runners moved to version ⟬version#1⟭ on ⟬date#2⟭. Since then:

- About 40% of pipelines on the Payments API repository fail at the integration stage.
- The Mobile SDK release pipeline has failed on every run.
- Web and documentation pipelines are unaffected.

Developer Experience traced the failures to the new default for service containers. They now run on a separate network, so tests that call `localhost` no longer reach the database. The Mobile SDK failure is a second problem: the signing step depends on a cache path that moved.

The group noted that the upgrade was announced, but the changelog entry was hard to find, and no one ran a pilot on a real repository.

## 2. Impact on partners

Partner Success reported that the SDK release planned for this week is blocked. One partner is waiting for that release to ship a fix to its own app, and has become anxious. The message that came in yesterday was read out to the group:

```
we were promised the SDK fix for this release and our store
submission closes on friday. nobody on your side has given me a
date. can someone with an actual answer get back to me today

⟬person_name#1⟭
⟬email#1⟭
⟬phone#1⟭
```

The group agreed that Partner Success should answer today, with an honest date, even if that date is a range.

## 3. Decisions

- Pin the Mobile SDK runners to the previous version until the release is out.
- Keep the new version everywhere else, and fix the tests rather than rolling back.
- Replace `localhost` with the service alias in the shared test template.
- Run a one-repository pilot for every future runner upgrade.

## 4. Actions

| Action | Team | When |
| --- | --- | --- |
| Pin Mobile SDK runners | Developer Experience | today |
| Publish the shared template fix | Developer Experience | tomorrow |
| Update Payments API tests | Payments API | end of the week |
| Reply to the partner | Partner Success | today |
| Write the pilot rule into the upgrade checklist | Developer Experience | next sprint |

## Parking lot

- Should we mirror the runner images ourselves?
- Flaky test report: raised again, to be handled in the quality guild.

## Next meeting

Same time next week, or sooner if the SDK pipeline is still red tomorrow morning.
⟬end⟭

⟬template⟭
family: docs
format: ticket
language: en
fill_locale: en_US
domain: retail
appearance: prose, labelled values
scenario: the refund process, is being retired
⟬text⟭
⟬ticket_id#1⟭ Old refund process: last open case blocks retirement

Record copied from the back office to reproduce the failure: customer ⟬person_name#1⟭, phone ⟬phone#1⟭, ship-to ⟬postal_address#1⟭, refund IBAN ⟬iban#1⟭, ITIN ⟬us_itin#1⟭, order ⟬order_number#1⟭.

The old refund process goes away on ⟬date#1⟭, but this case cannot be closed: saving it in the old screen fails with `REF-118 tax id format`, because the screen only accepts SSN patterns.

Steps: open the order, press Refund, press Save.
Needed: either a data fix for this one record, or an exception for the migration script.
⟬end⟭

⟬template⟭
family: docs
format: wiki page
language: en
fill_locale: en_US
domain: media
appearance: prose, bullet list, sql snippet
scenario: the reporting dashboard, needs a temporary workaround
⟬text⟭
# Audience dashboard: podcast figures workaround

The weekly audience dashboard has shown zeros for podcasts since ⟬date#1⟭, which ⟬person_name#1⟭ spotted before the Monday editorial meeting and has been patching by hand ever since. This page describes that patch so that anyone in Audience Data can run it.

## Cause

The hosting provider renamed a column in its daily export. Our loader ignores unknown columns, so the rows arrive without a play count and the dashboard reads them as zero.

## Workaround

Run this each morning after the load finishes, around 07:30:

```sql
UPDATE audience.podcast_daily
SET plays = raw.downloads_total
FROM staging.podcast_raw AS raw
WHERE raw.episode_id = audience.podcast_daily.episode_id
  AND audience.podcast_daily.plays = 0;
```

Then refresh the dashboard extract from the admin menu.

## Limits

- Figures before the rename are unaffected.
- The patch does not cover video podcasts, which come from another export.
- Do not run it twice in a row while the load is in progress.

## Removal

The loader fix is in review as ⟬ticket_id#1⟭. Delete this page when version ⟬version#1⟭ is live.
⟬end⟭

⟬template⟭
family: docs
format: meeting notes
language: en
fill_locale: en_US
domain: healthcare
appearance: code block, cli flag, bullet list
scenario: a client's security questionnaire, raises a question nobody can answer
⟬text⟭
Security questionnaire sync, ⟬date#1⟭

Teams: Compliance, Platform, Customer Success
Client: ⟬company#1⟭ (regional hospital group)

Status
- 212 questions in total, 187 answered from our standard pack.
- 18 need a line from Platform.
- 7 go to Legal.

To work on the open answers you need the client's portal. Their instructions, as sent:

```
portalctl login --tenant hospital-group --user ⟬username#1⟭ --password '⟬password#1⟭'
portalctl questionnaire pull --assignee "⟬person_name#1⟭" --status open
portalctl questionnaire push answers.yaml
```

The question nobody can answer
- Q148 asks where our backup provider stores encryption keys for archived patient records.
- Platform says the provider manages them. The provider's report does not cover archives.
- The contract is silent on the point.
- If we answer "unknown", the client may treat it as a critical gap.

Actions
- Customer Success asks the client for a one-week extension.
- Platform opens a case with the provider, ⟬ticket_id#1⟭.
- Compliance (⟬trap:initials|TW⟭) drafts a holding answer for Q148.
- Next sync on ⟬date#1⟭ if the provider answers sooner.
⟬end⟭

⟬template⟭
family: docs
format: pull request description
language: en
fill_locale: en_US
domain: SaaS
appearance: markdown link, mailto, presigned url, checklist, table
scenario: the disaster recovery drill, is planned for next quarter
⟬text⟭
## Add the disaster recovery drill plan for next quarter

This PR adds `docs/dr/drill-plan.md` and the scripts the drill needs. The drill is planned for next quarter, and the plan has to be approved before the change freeze.

Closes ⟬ticket_id#1⟭.

### For the reviewer

Please read this part first. [⟬person_name#1⟭](mailto:⟬email#1⟭) needs to time a restore this week and has no access to the backup account yet. Until the IAM role lands, use this link. It carries the access key id of the drill user, so please do not forward it:

https://s3.us-east-1.amazonaws.com/dr-drill-snapshots/latest.tar.zst?AWSAccessKeyId=⟬aws_access_key_id#1⟭&Expires=1893456000&Signature=⟬trap:placeholder|<ask-for-signature>⟭

Remove this section from the description before merging.

### Scope of the drill

We will simulate the loss of the primary region for the core product:

- API and web tier
- Primary database
- Object storage
- Background workers

Billing and the data warehouse are out of scope for this round. They are covered by the vendor's own failover test.

### Objectives

| Measure | Target | Last drill |
| --- | --- | --- |
| Recovery time | 60 minutes | 94 minutes |
| Recovery point | 5 minutes | 4 minutes |
| Customer notice sent | 15 minutes | 31 minutes |

These are targets, not measurements. The last drill's numbers come from the report of ⟬date#2⟭.

### What this PR changes

- Adds the drill plan and the runbook links.
- Adds `scripts/dr/promote_replica.sh`.
- Adds `scripts/dr/verify_restore.py`, which checks row counts against the last snapshot.
- Adds a dashboard definition for the drill.
- Updates the on-call guide.

### Drill timeline

1. T-14 days: tell customers about the maintenance window.
2. T-7 days: freeze infrastructure changes.
3. T-1 day: dry run of the scripts in staging.
4. T+0: cut traffic to the primary region.
5. T+10 minutes: promote the replica.
6. T+30 minutes: bring up workers.
7. T+45 minutes: run the verification script.
8. T+60 minutes: declare recovery.
9. T+4 hours: fail back.

### Roles

- Incident commander: the SRE on-call lead
- Scribe: a volunteer from Support Engineering
- Customer communication: the Status Page rota
- Observer: Internal Audit

### Risks

- A failed fail-back would leave us in the secondary region, which has less capacity.
- The promotion script has only run in staging.
- A real incident during the window cancels the drill.

### Testing

`scripts/dr/verify_restore.py` passes against a restored staging snapshot taken on ⟬date#1⟭.

### Checklist

- [x] Plan reviewed by SRE
- [x] Audit informed
- [ ] Change freeze dates confirmed
- [ ] Reviewer section removed
⟬end⟭

⟬template⟭
family: docs
format: ticket
language: en
fill_locale: en_US
domain: healthcare
appearance: json block, prose, steps
scenario: the customer import tool, shows wrong figures for one customer
⟬text⟭
⟬ticket_id#1⟭ Import tool: balance wrong for one patient account

Queue: Revenue Cycle Support
Found in: importer ⟬version#1⟭

After the import of ⟬date#1⟭ one account shows a balance of $18,420.00 where the source file says $1,842.00. Other accounts in the batch are correct. The record below was copied from the back office so that engineering can load it as it stands.

```json
{
  "patient": "⟬person_name#1⟭",
  "address": "⟬postal_address#1⟭",
  "ssn": "⟬us_ssn#1⟭",
  "card_on_file": "⟬payment_card#1⟭",
  "balance": "1842.00",
  "currency": "USD",
  "source": "batch-0412.csv"
}
```

Steps to reproduce

1. Put the record in a one-line batch file.
2. Run `importer load --dry-run` on the file.
3. Compare the computed balance with the source.

Suspected cause

The balance has a trailing zero after the decimal point, and this is the only row in the batch whose locale flag is empty. The parser may be dropping the point and then applying a default scale.

Please keep this ticket restricted: the record has not been masked.
⟬end⟭

⟬template⟭
family: docs
format: wiki page
language: en
fill_locale: en_US
domain: government
appearance: prose, bullet list
scenario: the report scheduler, fails after an upgrade
⟬text⟭
# Report scheduler failures after the platform upgrade

The Statistics Office scheduler has failed every Monday run since the platform upgrade to ⟬version#1⟭. The Reporting Services team found that the new runtime refuses the cron syntax used by the legacy jobs.

- Affected: the weekly labor bulletin and the county summary.
- Not affected: daily jobs, which use a plain interval.
- Workaround: the Operations Center triggers both reports by hand.
- Fix: Reporting Services rewrites the schedules, due ⟬date#1⟭.
⟬end⟭

⟬template⟭
family: docs
format: README .md
language: en
fill_locale: en_US
domain: retail
appearance: prose, api key, generic mailbox, shell block
scenario: the identity verification step, shows wrong figures for one customer
⟬text⟭
# id-verify

Sends the identity verification mail at checkout for age-restricted orders. To run it locally, use the shared SendGrid key `⟬sendgrid_api_key#1⟭` with the sender address `⟬email:generic#1⟭`; both are set up for the sandbox, and the fraud team reads that mailbox.

## Install

```bash
npm ci
npm install ⟬trap:email_lookalike|@sendgrid/mail⟭@⟬version#1⟭
cp .env.example .env
npm run dev
```

## Known issue

The verification report counts one customer's attempts twice whenever the first mail bounces, because the retry creates a new verification id. Totals are therefore too high for that customer in the weekly report. Until ⟬ticket_id#1⟭ is fixed, subtract bounced attempts when you read the report.

## Configuration

| Setting | Meaning |
| --- | --- |
| `VERIFY_TTL_MINUTES` | How long the link stays valid |
| `MAX_ATTEMPTS` | Attempts per order |
| `REPORT_DAY` | Day of the weekly report |

## Tests

```bash
npm test
```

The fixtures use made-up orders only. Add a fixture for each new bounce code.
⟬end⟭

⟬template⟭
family: docs
format: ticket
language: en
fill_locale: en_US
domain: media
appearance: quoted message, prose, bullet list
scenario: the outgoing mail relay, has been slow since the last deployment
⟬text⟭
⟬ticket_id#1⟭ Outgoing mail relay slow since last deployment

A subscriber wrote in on ⟬date#1⟭: "Anything your site sends to ⟬email#1⟭ takes about two hours to land now, including the sign-in link, which has expired by the time I get it." Support has seen the same complaint from a dozen readers this week.

Environment

- Relay version ⟬version#1⟭, deployed ⟬date#2⟭
- Two relay hosts behind the mail gateway
- Average queue age before the deployment: 40 seconds
- Average queue age now: 1 hour 50 minutes

What we checked

- Disk and CPU on the relay hosts are normal.
- The queue fills up during the morning edition and never drains.
- TLS handshakes to large mailbox providers take about 8 seconds each.

Likely cause

The new version verifies the full certificate chain on each connection and has lost its session cache. With a limit of 20 connections, that is enough to hold the queue back.

Next steps

- Restore the TLS session cache in the relay config.
- Raise the connection limit for the morning edition.
- Give transactional mail, such as sign-in links, a queue of its own.

Severity is high for sign-in links and low for newsletters.
⟬end⟭

⟬template⟭
family: docs
format: pull request description
language: en
fill_locale: en_US
domain: healthcare
appearance: key-value line, version, prose
scenario: the single sign-on setup, needs a temporary workaround
⟬text⟭
## Temporary workaround for the single sign-on clock skew

Refs ⟬ticket_id#1⟭. Identity provider ⟬version#1⟭ rejects assertions older than 30 seconds, and the nurse station terminals drift by up to a minute.

Sets the allowed skew to 90 seconds until the time sync fix ships.

SESSION_SECRET_ROTATION_DAYS=⟬trap:indicator_non_pii|30⟭
Assertion ID: ⟬uuid#1⟭ (failing sample, expired)

Revert after ⟬date#1⟭. Nothing else changes.
⟬end⟭

⟬template⟭
family: docs
format: commit message
language: en
fill_locale: en_US
domain: government
appearance: commit subject, commit trailer
scenario: the refund process, moves to a new provider
⟬text⟭
refactor(refunds): route tax refunds through the new payment provider

Replace the old batch file with the provider's API. Status polling stays in
place until the last batch of ⟬date#1⟭ has settled.

Refs: ⟬ticket_id#1⟭
Reviewed-by: <⟬email#1⟭>
Acked-by: <⟬email#2⟭>
⟬end⟭

⟬template⟭
family: docs
format: formal email
language: en
fill_locale: en_US
domain: fintech
appearance: email signature, prose
scenario: the database migration, breaks for a single team
⟬text⟭
Subject: Ledger database migration: Reconciliation team impact

Dear colleagues,

Following the migration of ⟬date#1⟭, the Reconciliation team can no longer run its end-of-day job, because a stored procedure was not carried over. All other teams are unaffected. We expect to restore it by tomorrow morning, and the team's reports will be produced by hand in the meantime.

Kind regards,

⟬person_name#1⟭
⟬job_title#1⟭, ⟬company#1⟭
⟬postal_address#1⟭
⟬email#1⟭
⟬end⟭

⟬template⟭
family: docs
format: ticket
language: en
fill_locale: en_US
domain: SaaS
appearance: placeholder, config sample, prose
scenario: the disaster recovery drill, is explained to new hires
⟬text⟭
⟬ticket_id#1⟭ Explain the disaster recovery drill to new hires

Add a short section to the onboarding guide. New hires should know that drills run twice a year and that they will fill in this file themselves on the day:

    DR_VAULT_TOKEN=⟬trap:placeholder|<your-vault-token>⟭
    DR_DB_PASSWORD=⟬trap:placeholder|${DR_DB_PASSWORD}⟭
    DR_SSH_KEY_PATH=⟬trap:placeholder|<path-to-key>⟭
    DR_TOKEN_TTL=⟬trap:indicator_non_pii|3600⟭

They must never commit real values to the guide. The real ones come from the vault during the drill.
⟬end⟭

⟬template⟭
family: docs
format: pull request description
language: en
fill_locale: en_US
domain: retail
appearance: table row, connection string, prose
scenario: the newsletter template, needs a new owner
⟬text⟭
## Newsletter template: handover to the Lifecycle team

This PR moves the template to `lifecycle/newsletter/`. The Web team no longer owns it. So that Lifecycle can start today without waiting for accounts:

| Item | Value |
| --- | --- |
| Email builder password | ⟬password#1⟭ |
| Preview database | postgres://newsletter:⟬url_password#1⟭@⟬hostname#1⟭:5432/preview |

Please rotate both once your own access is in place. Owner changes in `CODEOWNERS`.
⟬end⟭
