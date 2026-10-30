⟬template⟭
family: code
format: .js
language: en
fill_locale: en_GB
domain: e-commerce
appearance: connection string in comment, fallback default, nested JSON in block comment
scenario: Node script of a furniture retailer that replays order webhooks stuck in the dead-letter table after a fulfilment outage, with one payload pasted at the bottom by the on-call developer
⟬text⟭
#!/usr/bin/env node
// scripts/replay-dead-letters.js
//
// Replays order webhooks that landed in the dead-letter table while the
// fulfilment API was down. Run from the bastion with prod read access:
//
//   DATABASE_URL=postgres://orders_ro:⟬url_password#1⟭@⟬hostname#1⟭:5432/orders node scripts/replay-dead-letters.js --since 2h
//
// Ask in #checkout-oncall before running it against more than 500 rows.

'use strict';

const { Client } = require('pg');
const Stripe = require('stripe');
const pLimit = require('p-limit');
const yargs = require('yargs/yargs');
const { hideBin } = require('yargs/helpers');

const argv = yargs(hideBin(process.argv))
  .option('since', { type: 'string', default: '1h' })
  .option('dry-run', { type: 'boolean', default: false })
  .option('concurrency', { type: 'number', default: 4 })
  .parse();

// TODO move to the secrets manager, this is the restricted key from the incident
const stripe = Stripe(process.env.STRIPE_KEY || '⟬stripe_secret_key#1⟭');
const FULFILMENT_URL = process.env.FULFILMENT_URL || 'https://⟬hostname#2⟭/v2/orders';

function parseInterval(text) {
  const match = /^(\d+)([mhd])$/.exec(text);
  if (!match) throw new Error(`bad --since value: ${text}`);
  const unit = { m: 'minutes', h: 'hours', d: 'days' }[match[2]];
  return `${match[1]} ${unit}`;
}

async function loadDeadLetters(db, since) {
  const { rows } = await db.query(
    `SELECT id, event_id, payload, attempts
       FROM webhook_dead_letters
      WHERE created_at > now() - $1::interval
        AND replayed_at IS NULL
      ORDER BY created_at`,
    [since],
  );
  return rows;
}

async function stillPaid(paymentIntentId) {
  const intent = await stripe.paymentIntents.retrieve(paymentIntentId);
  return intent.status === 'succeeded';
}

async function replay(row) {
  const res = await fetch(FULFILMENT_URL, {
    method: 'POST',
    headers: { 'content-type': 'application/json', 'x-replay-of': row.event_id },
    body: JSON.stringify(row.payload),
  });
  if (!res.ok) throw new Error(`fulfilment answered ${res.status} for ${row.event_id}`);
}

async function main() {
  const db = new Client({ connectionString: process.env.DATABASE_URL });
  await db.connect();
  const limit = pLimit(argv.concurrency);
  const rows = await loadDeadLetters(db, parseInterval(argv.since));
  console.log(`${rows.length} dead letters since ${argv.since}`);

  let replayed = 0;
  await Promise.all(rows.map((row) => limit(async () => {
    if (!(await stillPaid(row.payload.payment_intent))) {
      console.warn(`skip ${row.event_id}: payment no longer succeeded`);
      return;
    }
    if (argv['dry-run']) return;
    await replay(row);
    await db.query('UPDATE webhook_dead_letters SET replayed_at = now() WHERE id = $1', [row.id]);
    replayed += 1;
  })));

  console.log(`replayed ${replayed}/${rows.length}`);
  await db.end();
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});

/*
One of the rows from the outage, for reference. The legacy checkout still sent
the raw card on guest orders, see ⟬ticket_id#1⟭.

{
  "event_id": "evt_⟬hash#1⟭",
  "order": "⟬order_number#1⟭",
  "placed_at": "⟬date#1⟭",
  "payment_intent": "pi_⟬hash#2⟭",
  "guest": true,
  "customer": {
    "name": "⟬person_name#1⟭",
    "email": "⟬email#1⟭",
    "phone": "⟬phone#1⟭"
  },
  "ship_to": {
    "line1": "⟬postal_address:street#1⟭",
    "city": "⟬city#1⟭",
    "postcode": "⟬postcode#1⟭"
  },
  "legacy_card": { "number": "⟬payment_card#1⟭", "exp": "09/28" },
  "lines": [{ "sku": "LMP-OAK-120", "qty": 1, "price": 189.0 }]
}
*/
⟬end⟭

⟬template⟭
family: code
format: .rb
language: en
fill_locale: en_GB
domain: energy
appearance: console session in comment
scenario: ActiveJob of a domestic energy supplier that handles a failed direct debit, with the console call a billing developer used to reproduce a case from support
⟬text⟭
# app/jobs/direct_debit_failure_job.rb
class DirectDebitFailureJob < ApplicationJob
  queue_as :billing
  retry_on Bacs::TemporaryError, wait: :polynomially_longer, attempts: 5

  # reproduced with the ARUDD row from support:
  #   >> DirectDebitFailureJob.perform_now(DirectDebitMandate.find_by(account_number: "⟬bank_account_number#1⟭").id, "0")
  #   #<DirectDebitMandate holder: "⟬person_name#1⟭", iban: "⟬iban#1⟭", status: "active">
  def perform(mandate_id, reason_code)
    mandate = DirectDebitMandate.find(mandate_id)
    return if mandate.cancelled?

    BillingMailer.with(mandate: mandate, reason: Bacs.reason_for(reason_code)).payment_failed.deliver_later
    mandate.account.flag!(:payment_failed, source: "arudd")
  end
end
⟬end⟭

⟬template⟭
family: code
format: .java
language: en
fill_locale: en_GB
domain: logistics
appearance: constant, text block, Slack message text
scenario: scheduled Spring job of a freight forwarder that uploads the daily export manifest to the customs broker over SFTP, with the broker key inlined until the vault integration lands
⟬text⟭
package com.northgate.freight.customs;

import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.Session;
import com.slack.api.Slack;
import com.slack.api.methods.request.chat.ChatPostMessageRequest;
import java.io.ByteArrayInputStream;
import java.nio.charset.StandardCharsets;
import java.time.Clock;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Properties;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

/**
 * Uploads the daily export manifest to the customs broker's SFTP drop before
 * the 18:00 cut-off, then tells the export desk on Slack.
 *
 * <p>The broker only accepts key auth. Until the vault integration lands
 * (⟬ticket_id#1⟭) the key below is the one the broker registered for us.
 */
@Component
public class ManifestUploadJob {

    private static final Logger log = LoggerFactory.getLogger(ManifestUploadJob.class);
    private static final DateTimeFormatter FILE_DATE = DateTimeFormatter.BASIC_ISO_DATE;

    private static final String BROKER_HOST = "⟬hostname#1⟭";
    private static final int BROKER_PORT = 2222;
    private static final String BROKER_USER = "⟬username#1⟭";
    private static final String KNOWN_HOST = "[⟬hostname#1⟭]:2222 ⟬ssh_public_key#1⟭";
    private static final String KEY_PASSPHRASE = "⟬password#1⟭";
    private static final String BROKER_KEY = """
        ⟬private_key#1⟭
        """;

    private static final String SLACK_TOKEN = "⟬slack_token#1⟭";
    private static final String EXPORT_DESK_CHANNEL = "C04EXPORTDESK";

    private final ManifestRepository manifests;
    private final Clock clock;

    public ManifestUploadJob(ManifestRepository manifests, Clock clock) {
        this.manifests = manifests;
        this.clock = clock;
    }

    @Scheduled(cron = "0 30 17 * * MON-FRI", zone = "Europe/London")
    public void upload() throws Exception {
        LocalDate today = LocalDate.now(clock);
        List<ManifestLine> lines = manifests.linesFor(today);
        if (lines.isEmpty()) {
            log.info("no export lines for {}, nothing to send", today);
            return;
        }
        String fileName = "NGF_EXP_" + FILE_DATE.format(today) + ".csv";
        byte[] body = ManifestCsv.render(lines).getBytes(StandardCharsets.UTF_8);

        JSch jsch = new JSch();
        jsch.addIdentity("broker", BROKER_KEY.getBytes(StandardCharsets.US_ASCII), null,
            KEY_PASSPHRASE.getBytes(StandardCharsets.US_ASCII));
        jsch.setKnownHosts(new ByteArrayInputStream(KNOWN_HOST.getBytes(StandardCharsets.US_ASCII)));
        Session session = jsch.getSession(BROKER_USER, BROKER_HOST, BROKER_PORT);
        Properties config = new Properties();
        config.put("StrictHostKeyChecking", "yes");
        session.setConfig(config);
        session.connect(15_000);
        try {
            ChannelSftp sftp = (ChannelSftp) session.openChannel("sftp");
            sftp.connect();
            sftp.put(new ByteArrayInputStream(body), "/inbound/" + fileName);
            sftp.disconnect();
        } finally {
            session.disconnect();
        }
        log.info("uploaded {} ({} lines) to broker", fileName, lines.size());
        notifyDesk(fileName, lines.size());
    }

    private void notifyDesk(String fileName, int count) throws Exception {
        var request = ChatPostMessageRequest.builder()
            .channel(EXPORT_DESK_CHANNEL)
            .text(":ship: " + fileName + " sent to the broker with " + count + " lines. Queries to "
                + "⟬person_name#2⟭ on ⟬phone#2⟭ until 18:00.")
            .build();
        var response = Slack.getInstance().methods(SLACK_TOKEN).chatPostMessage(request);
        if (!response.isOk()) {
            log.warn("slack post failed: {}", response.getError());
        }
    }
}
⟬end⟭

⟬template⟭
family: code
format: .go
language: en
fill_locale: en_GB
domain: e-commerce
appearance: fuzz seed corpus, query string
scenario: Go fuzz test of the card number masking used by the logging middleware of an online pharmacy, seeded by a backend developer with numbers from an old support export
⟬text⟭
package redact

import "testing"

// Seeds are real-shaped numbers that pass the ⟬trap:eponym|Luhn⟭ check, with and without separators.
func FuzzMaskPAN(f *testing.F) {
	f.Add("⟬payment_card#1⟭")
	f.Add("card ⟬payment_card#2⟭ exp 0427 cvc ⟬card_security_code#2⟭")
	f.Add("ref=⟬order_number#1⟭&pan=⟬payment_card#3⟭&amt=4599")
	f.Add("no digits here")
	f.Fuzz(func(t *testing.T, in string) {
		if run := longestDigitRun(MaskPAN(in)); run >= 13 {
			t.Fatalf("a run of %d digits survived masking of %q", run, in)
		}
	})
}
⟬end⟭

⟬template⟭
family: code
format: .ts
language: en
fill_locale: en_GB
domain: logistics
appearance: decorator example, regular expression, object literal
scenario: NestJS DTO for the self check-in kiosk of a distribution centre where visiting HGV drivers register, written by the backend developer of the yard system
⟬text⟭
// src/yard/dto/check-in.dto.ts
import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { IsIn, IsOptional, IsPhoneNumber, Matches, MaxLength } from 'class-validator';

// DVLA licence number: 16 characters, surname first. Plates are current format only;
// foreign tractors go through the gatehouse, not the kiosk.
export const LICENCE_PATTERN = /^[A-Z9]{5}\d{6}[A-Z9]{2}\d[A-Z]{2}$/;
export const PLATE_PATTERN = /^[A-Z]{2}\d{2} ?[A-Z]{3}$/;

export class YardCheckInDto {
  @ApiProperty({ example: '⟬person_name#1⟭', description: 'As printed on the licence' })
  @MaxLength(80)
  driverName!: string;

  @ApiProperty({ example: '⟬uk_driving_licence#1⟭' })
  @Matches(LICENCE_PATTERN, { message: 'licence number is not in the DVLA format' })
  licenceNumber!: string;

  @ApiProperty({ example: '⟬date#1⟭', description: 'Photocard expiry (4b)' })
  licenceExpiry!: string;

  @ApiProperty({ example: '⟬phone#1⟭', description: 'Mobile the yard marshal texts when a door is free' })
  @IsPhoneNumber('GB')
  mobile!: string;

  @ApiProperty({ example: '⟬uk_license_plate#1⟭' })
  @Matches(PLATE_PATTERN)
  tractorRegistration!: string;

  @ApiPropertyOptional({ example: 'TR-40417', description: 'Trailer fleet number, not a plate' })
  @IsOptional()
  @MaxLength(20)
  trailerId?: string;

  @ApiProperty({ example: '⟬trap:company_name|⦃Family⦄ Haulage Ltd⟭' })
  @MaxLength(120)
  haulier!: string;

  @ApiProperty({ enum: ['collection', 'delivery', 'return'] })
  @IsIn(['collection', 'delivery', 'return'])
  purpose!: 'collection' | 'delivery' | 'return';

  @ApiProperty({ example: '⟬order_number#1⟭', description: 'Booking reference from the slot portal' })
  bookingRef!: string;
}

// Prefilled on the kiosk until the driver scans the licence.
export const KIOSK_DEFAULTS = { ⟬trap:indicator_non_pii|driverName: 'Visiting driver'⟭, purpose: 'delivery' } as const;
⟬end⟭

⟬template⟭
family: code
format: .cs
language: en
fill_locale: en_GB
domain: travel
appearance: XML doc example, constant, log line in comment
scenario: FluentValidation validator for the passport step of a package holiday booking app, written by a developer who fixed a validation message that logged the passport number
⟬text⟭
using FluentValidation;

namespace Sunvale.Booking.Travellers;

/// <summary>
/// Passport step of the booking flow. Most destinations want six months of validity
/// left on the return date; the table lives in <see cref="EntryRules"/>.
/// </summary>
/// <example>
/// Test traveller used by the booking journeys in UAT:
/// <code>
/// new PassportDetails("⟬person_name:given#1f⟭", "⟬person_name:family#1⟭", "⟬uk_passport#1⟭", DateOnly.Parse("⟬birth_date#1⟭"), DateOnly.Parse("⟬date#1⟭"), "GBR")
/// </code>
/// </example>
public sealed class PassportDetailsValidator : AbstractValidator<PassportDetails>
{
    public const int ⟬trap:indicator_non_pii|PassportMinValidityMonths = 6⟭;

    public PassportDetailsValidator(EntryRules rules, TimeProvider clock)
    {
        RuleFor(p => p.GivenNames).NotEmpty().MaximumLength(60);
        RuleFor(p => p.Surname).NotEmpty().MaximumLength(60);
        RuleFor(p => p.Number)
            .NotEmpty()
            .Matches("^[0-9]{9}$").When(p => p.IssuingCountry == "GBR")
            .WithMessage("A British passport number has nine digits.");
        RuleFor(p => p.DateOfBirth)
            .LessThan(DateOnly.FromDateTime(clock.GetUtcNow().UtcDateTime))
            .WithMessage("Date of birth must be in the past.");

        // The message used to interpolate the number. Seen in Seq before the fix:
        //   Validation failed for booking ⟬order_number#1⟭: Passport ⟬uk_passport#2⟭ expires too soon for this trip. traveller=⟬email#2⟭
        RuleFor(p => p)
            .Must((p, _, ctx) => rules.HasEnoughValidity(p.ExpiryDate, (DateOnly)ctx.RootContextData["returnDate"], PassportMinValidityMonths))
            .WithMessage("This passport expires too soon for the return date.")
            .WithName("ExpiryDate");
    }
}
⟬end⟭

⟬template⟭
family: code
format: .rb
language: en
fill_locale: en_GB
domain: e-commerce
appearance: URL credential, hash literal, comment
scenario: Capistrano deploy configuration of an online wine merchant, where a developer put tokens inline after the deploy key was revoked during the move to SSO
⟬text⟭
# config/deploy.rb
lock "~> 3.18.0"

set :application, "cellar-door"
# deploy key was revoked when the org moved to SSO, so the token rides in the URL for now
set :repo_url, "https://x-access-token:⟬github_token#1⟭@github.com/cellar-door-wines/shop.git"
set :branch, ENV.fetch("BRANCH", "main")
set :deploy_to, "/srv/cellar-door"
set :keep_releases, 5
set :ssh_options, { ⟬trap:indicator_non_pii|user: "deploy"⟭, forward_agent: false, keys: %w[~/.ssh/cellar_deploy] }

append :linked_files, "config/master.key", "config/database.yml"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "public/system", "storage"

# private packages for the storefront: the age gate and the en primeur
# reservations for the 2022 ⟬trap:word_name|Margaux⟭
set :default_env, {
  "NPM_TOKEN" => "⟬npm_token#1⟭",
  "NODE_ENV" => "production",
}

set :slackistrano, {
  klass: Slackistrano::CustomMessaging,
  channel: "#shop-deploys",
  token: "⟬slack_token#1⟭",
}

set :rbenv_ruby, File.read(".ruby-version").strip
set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"

namespace :deploy do
  desc "Warm the product cache after a release"
  task :warm_cache do
    on roles(:app) do
      within current_path do
        execute :bundle, :exec, :rails, "runner", "Catalogue::Warmer.call"
      end
    end
  end
  after :finishing, :warm_cache
end
⟬end⟭

⟬template⟭
family: code
format: .js
language: en
fill_locale: en_GB
domain: education
appearance: object literal, GraphQL variables, assertion
scenario: Supertest suite for the bursary application mutation of a further education college, written by a backend developer with a learner from the enrolment team's test list
⟬text⟭
// test/graphql/bursary-application.test.js
const request = require('supertest');
const { createApp } = require('../../src/app');
const { resetDb, signStaffToken } = require('../helpers');

const SUBMIT = /* GraphQL */ `
  mutation Submit($input: BursaryApplicationInput!) {
    submitBursaryApplication(input: $input) {
      reference
      status
      paymentMethod
    }
  }
`;

// learner from the enrolment team's test list, 19+ so the discretionary fund applies
const input = {
  learnerId: '⟬customer_id#1⟭',
  legalName: '⟬person_name#1⟭',
  dateOfBirth: '⟬birth_date#1⟭',
  niNumber: '⟬uk_national_insurance_number#1⟭',
  householdIncome: 21400,
  benefits: ['UNIVERSAL_CREDIT'],
  course: { code: 'ACC-L3-2401', start: '⟬date#1⟭' },
  payTo: { iban: '⟬iban#1⟭', accountHolder: '⟬person_name#1⟭' },
  evidence: ['uc-statement.pdf'],
};

const asStudentServices = (req) =>
  req.set('Authorization', `Bearer ${signStaffToken({ role: 'student-services' })}`);

describe('submitBursaryApplication', () => {
  let app;
  beforeAll(async () => {
    app = await createApp({ env: 'test' });
  });
  beforeEach(resetDb);

  it('creates the application and pays by bank transfer', async () => {
    const res = await asStudentServices(request(app).post('/graphql'))
      .send({ query: SUBMIT, variables: { input } });

    expect(res.body.errors).toBeUndefined();
    expect(res.body.data.submitBursaryApplication).toMatchObject({
      status: 'PENDING_EVIDENCE',
      paymentMethod: 'BANK_TRANSFER',
    });
  });

  it('refuses a second application with the same NI number', async () => {
    await asStudentServices(request(app).post('/graphql')).send({ query: SUBMIT, variables: { input } });
    const res = await asStudentServices(request(app).post('/graphql')).send({
      query: SUBMIT,
      variables: { input: { ...input, learnerId: '⟬customer_id#2⟭', legalName: '⟬person_name#2⟭' } },
    });

    expect(res.body.errors[0].message).toBe('An application already exists for this National Insurance number');
  });
});
⟬end⟭

⟬template⟭
family: code
format: .js
language: en
fill_locale: en_GB
domain: energy
appearance: curl command in comment
scenario: SMS reminder builder for smart meter installs, with the curl a developer used to try the messaging provider pasted in the header comment
⟬text⟭
// lib/sms/appointment-reminder.js
// Texts the customer the day before a smart meter install.
// Provider: POST /v1/messages, bearer auth with the service account token. Tried with:
//
//   curl -s https://⟬hostname#1⟭/v1/messages \
//     -H 'Authorization: Bearer ⟬jwt#1⟭' \
//     -H 'Content-Type: application/json' \
//     -d '{"to":"⟬phone#1⟭","body":"Your engineer arrives 8-12 at ⟬postal_address#1⟭"}'

const { format } = require('date-fns');

module.exports = function buildReminder(appointment) {
  const slot = appointment.slot === 'AM' ? '8am-12pm' : '12pm-6pm';
  return {
    to: appointment.contactPhone,
    body: `Your smart meter engineer arrives ${format(appointment.date, 'EEE d MMM')} between ${slot}. Reply MOVE to rebook.`,
  };
};
⟬end⟭

⟬template⟭
family: code
format: .java
language: en
fill_locale: en_GB
domain: media
appearance: constant under innocuous name, debug notes in comment
scenario: servlet filter of a regional newspaper paywall that lets signed gift links through, with the HMAC key in a one-letter constant and debug notes from the rollout at the bottom
⟬text⟭
package uk.co.harbourpress.paywall;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.time.Instant;
import java.util.HexFormat;
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

/**
 * Lets gift links through the paywall. A subscriber shares an article and the
 * link carries {@code e} (expiry, epoch seconds) and {@code sig}, an HMAC of the
 * path and expiry. Subscriber sessions are checked further down the chain.
 */
public class GiftLinkFilter extends HttpFilter {

    // same value as gift.k in the CMS config; rotate both together
    private static final byte[] K = "⟬opaque_token#1⟭".getBytes(StandardCharsets.UTF_8);

    @Override
    protected void doFilter(HttpServletRequest req, HttpServletResponse res, FilterChain chain)
            throws IOException, ServletException {
        String sig = req.getParameter("sig");
        String e = req.getParameter("e");
        if (sig == null || e == null) {
            chain.doFilter(req, res);
            return;
        }
        if (Instant.now().getEpochSecond() > Long.parseLong(e) || !valid(req.getRequestURI(), e, sig)) {
            res.sendRedirect("/subscribe?reason=gift-expired");
            return;
        }
        req.setAttribute("paywall.bypass", "gift");
        chain.doFilter(req, res);
    }

    private static boolean valid(String path, String expiry, String sig) {
        try {
            Mac mac = Mac.getInstance("HmacSHA256");
            mac.init(new SecretKeySpec(K, "HmacSHA256"));
            byte[] expected = mac.doFinal((path + "|" + expiry).getBytes(StandardCharsets.UTF_8));
            return MessageDigest.isEqual(expected, HexFormat.of().parseHex(sig));
        } catch (Exception ex) {
            return false;
        }
    }
}

// Rollout notes, ⟬date#1⟭:
// the link shared by ⟬email#1⟭ failed because the iOS share sheet sent
// ⟬jwt#1⟭
// as sig instead of the HMAC. Fixed in the app, see ⟬ticket_id#1⟭.
⟬end⟭

⟬template⟭
family: code
format: .ts
language: en
fill_locale: en_GB
domain: e-commerce
appearance: constant, mocked API response, assertion
scenario: Angular spec of the address autocomplete on the checkout of a furniture store, written by a frontend developer with mocked place search responses and the dev maps key
⟬text⟭
// src/app/checkout/address-lookup.service.spec.ts
import { TestBed } from '@angular/core/testing';
import { provideHttpClient } from '@angular/common/http';
import { HttpTestingController, provideHttpClientTesting } from '@angular/common/http/testing';
import { AddressLookupService, PLACES_KEY } from './address-lookup.service';

// Runs under the ⟬trap:library|Jasmine⟭ runner from the CLI. The key is the dev key,
// restricted to localhost referrers, so a leak would not matter much (it does).
const DEV_KEY = '⟬google_api_key#1⟭';

const AUTOCOMPLETE = {
  status: 'OK',
  predictions: [
    { place_id: 'ChIJ-1', description: '⟬postal_address#1⟭' },
    { place_id: 'ChIJ-2', description: '⟬postal_address#2⟭' },
    { place_id: 'ChIJ-3', description: '⟬trap:word_name|Victoria Road⟭, ⟬city#3⟭, UK' },
  ],
};

const DETAILS = {
  status: 'OK',
  result: {
    address_components: [
      { long_name: '⟬postal_address:street#1⟭', types: ['street_address'] },
      { long_name: '⟬city#1⟭', types: ['postal_town'] },
      { long_name: '⟬postcode#1⟭', types: ['postal_code'] },
      { long_name: 'United Kingdom', short_name: 'GB', types: ['country'] },
    ],
  },
};

describe('AddressLookupService', () => {
  let service: AddressLookupService;
  let http: HttpTestingController;

  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [
        provideHttpClient(),
        provideHttpClientTesting(),
        { provide: PLACES_KEY, useValue: DEV_KEY },
      ],
    });
    service = TestBed.inject(AddressLookupService);
    http = TestBed.inject(HttpTestingController);
  });

  afterEach(() => http.verify());

  it('sends the key and restricts results to the UK', () => {
    service.suggest('church rd').subscribe();
    const req = http.expectOne((r) => r.url.endsWith('/place/autocomplete/json'));
    expect(req.request.params.get('key')).toBe(DEV_KEY);
    expect(req.request.params.get('components')).toBe('country:gb');
    req.flush(AUTOCOMPLETE);
  });

  it('keeps only predictions with a house number', (done) => {
    service.suggest('road').subscribe((suggestions) => {
      expect(suggestions.map((s) => s.id)).toEqual(['ChIJ-1', 'ChIJ-2']);
      done();
    });
    http.expectOne(() => true).flush(AUTOCOMPLETE);
  });

  it('maps place details onto the delivery form', (done) => {
    service.details('ChIJ-1').subscribe((form) => {
      expect(form).toEqual({
        line1: '⟬postal_address:street#1⟭',
        town: '⟬city#1⟭',
        postcode: '⟬postcode#1⟭',
        country: 'GB',
      });
      done();
    });
    http.expectOne((r) => r.params.get('place_id') === 'ChIJ-1').flush(DETAILS);
  });

  it('surfaces quota errors so the form falls back to manual entry', (done) => {
    service.suggest('x').subscribe({
      error: (err) => {
        expect(err.message).toContain('OVER_QUERY_LIMIT');
        done();
      },
    });
    http.expectOne(() => true).flush({ status: 'OVER_QUERY_LIMIT', predictions: [] });
  });
});
⟬end⟭

⟬template⟭
family: code
format: .cs
language: en
fill_locale: en_GB
domain: logistics
appearance: positional seed rows, comment
scenario: EF Core configuration of the yard shunters of a distribution centre, seeded by a developer from the site vehicle list so the yard map works on day one
⟬text⟭
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Crossdock.Yard.Data.Configurations;

public class ShunterConfiguration : IEntityTypeConfiguration<Shunter>
{
    public void Configure(EntityTypeBuilder<Shunter> builder)
    {
        builder.ToTable("shunters");
        builder.HasKey(s => s.Id);
        builder.Property(s => s.Registration).HasMaxLength(8).IsRequired();
        builder.HasIndex(s => s.Registration).IsUnique();
        builder.Property(s => s.AssignedDriverLicence).HasMaxLength(16);

        // From the site vehicle list kept by the transport office at ⟬postal_address#5⟭.
        // Questions to ⟬person_name#6⟭ (⟬phone#6⟭). Contractor units from
        // ⟬trap:company_name|⦃Family⦄ & Sons Haulage⟭ are not seeded.
        builder.HasData(
            new Shunter(1, "⟬uk_license_plate#1⟭", "Terberg YT223", "DIRFT-1", "⟬uk_driving_licence#1⟭"),
            new Shunter(2, "⟬uk_license_plate#2⟭", "Terberg YT223", "DIRFT-1", null),
            new Shunter(3, "⟬uk_license_plate#3⟭", "Kalmar T2i", "DIRFT-1", "⟬uk_driving_licence#3⟭"),
            new Shunter(4, "⟬uk_license_plate#4⟭", "Kalmar T2i", "DIRFT-2", "⟬uk_driving_licence#4⟭"));
    }
}
⟬end⟭

⟬template⟭
family: code
format: .rb
language: en
fill_locale: en_GB
domain: travel
appearance: comment, CLI usage, console session in comment
scenario: one-off Rails runner script of a ferry operator that merges two duplicate profiles of a foot passenger, written by a support engineer after her call
⟬text⟭
# script/merge_duplicate_travellers.rb
#
# One-off: two profiles for ⟬person_name#1f⟭ after the app and the call centre
# both created one. She rang on Monday, confirmed the passport number on the
# phone and wants the app login kept.
#
#   bin/rails runner script/merge_duplicate_travellers.rb ⟬customer_id#1⟭ ⟬customer_id#2⟭
#
# Dry run by default, pass APPLY=1 to write.
#
# Checked in the console first, ⟬date#1⟭:
#   >> Traveller.where(passport_number: "⟬uk_passport#1⟭").pluck(:id, :email, :source)
#   => [["⟬customer_id#1⟭", "⟬email#1⟭", "app"], ["⟬customer_id#2⟭", "⟬email#3⟭", "call_centre"]]

keep_id, drop_id = ARGV
abort "usage: merge_duplicate_travellers.rb KEEP_ID DROP_ID" unless keep_id && drop_id

keep = Traveller.find(keep_id)
drop = Traveller.find(drop_id)

unless keep.passport_number == drop.passport_number
  abort "passports differ (#{keep.passport_number.last(3)} vs #{drop.passport_number.last(3)}), check by hand"
end

apply = ENV["APPLY"] == "1"
moved = Hash.new(0)

Traveller.transaction do
  drop.bookings.find_each do |booking|
    booking.update!(traveller: keep) if apply
    moved[:bookings] += 1
  end
  drop.loyalty_points.find_each do |entry|
    entry.update!(traveller: keep) if apply
    moved[:points] += 1
  end
  keep.update!(phone: drop.phone) if apply && keep.phone.blank?
  drop.update!(merged_into: keep, email: nil) if apply
  raise ActiveRecord::Rollback unless apply
end

puts "#{apply ? "merged" : "would merge"} #{drop_id} into #{keep_id}: #{moved.inspect}"
⟬end⟭

⟬template⟭
family: code
format: .go
language: en
fill_locale: en_GB
domain: logistics
appearance: test table, struct literal, expected header value
scenario: Go test of the upstream credentials of the package mirror used by the build agents of a parcel carrier, kept with the tokens of the old build box
⟬text⟭
package mirror

import (
	"net/http"
	"net/http/httptest"
	"testing"
)

// The mirror sits in front of npmjs and GitHub for the build agents of the
// depot apps. Upstream credentials come from the vault in prod; these are the
// ones from the old build box, kept so the tests exercise real token shapes.
func TestUpstreamAuth(t *testing.T) {
	cases := []struct {
		name     string
		path     string
		creds    Credentials
		wantAuth string
	}{
		{
			name:     "npm scoped package",
			path:     "/npm/⟬trap:email_lookalike|@depotline/scanner-ui⟭/-/scanner-ui-4.2.0.tgz",
			creds:    Credentials{NPM: "⟬npm_token#1⟭"},
			wantAuth: "Bearer ⟬npm_token#1⟭",
		},
		{
			name:     "go module from a private repo",
			path:     "/go/github.com/depotline/routing/@v/v1.9.3.zip",
			creds:    Credentials{GitHub: "⟬github_token#1⟭"},
			wantAuth: "Basic " + basic("x-access-token", "⟬github_token#1⟭"),
		},
		{
			name:     "public package goes out anonymous",
			path:     "/npm/left-pad",
			creds:    Credentials{},
			wantAuth: "",
		},
	}

	for _, tc := range cases {
		t.Run(tc.name, func(t *testing.T) {
			var got string
			upstream := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
				got = r.Header.Get("Authorization")
				w.WriteHeader(http.StatusOK)
			}))
			defer upstream.Close()

			m := New(Config{Upstream: upstream.URL, Credentials: tc.creds, ⟬trap:indicator_non_pii|User: "anonymous"⟭})
			rec := httptest.NewRecorder()
			m.ServeHTTP(rec, httptest.NewRequest(http.MethodGet, tc.path, nil))

			if got != tc.wantAuth {
				t.Errorf("upstream saw Authorization %q, want %q", got, tc.wantAuth)
			}
			if rec.Header().Get("Authorization") != "" {
				t.Error("credentials leaked back to the client")
			}
		})
	}
}
⟬end⟭

⟬template⟭
family: code
format: .rb
language: en
fill_locale: en_GB
domain: energy
appearance: usage example in comment, regular expression
scenario: model concern of an energy supplier that stores and masks NI numbers for the Warm Home Discount data match, written by the developer of the eligibility check
⟬text⟭
# app/models/concerns/masks_ni_number.rb
#
# The Warm Home Discount data match needs the NI number, so we keep it
# encrypted, but nobody needs to read it back in full.
#
#   account = Account.find_by(email: "⟬email#1⟭")
#   account.ni_number        # => "⟬uk_national_insurance_number#1⟭"
#   account.masked_ni_number # => "******" plus the last three characters
module MasksNiNumber
  extend ActiveSupport::Concern

  NI_FORMAT = /\A[A-CEGHJ-PR-TW-Z]{2}\d{6}[A-D]\z/

  included do
    encrypts :ni_number, deterministic: true
    validates :ni_number, format: { with: NI_FORMAT }, allow_blank: true
    before_validation { self.ni_number = ni_number&.delete(" ")&.upcase }
  end

  def masked_ni_number
    ni_number.presence && ("*" * 6) + ni_number[-3..]
  end
end
⟬end⟭

⟬template⟭
family: code
format: .ts
language: en
fill_locale: en_GB
domain: e-commerce
appearance: lint rule, string array, comment
scenario: custom ESLint rule of a marketplace monorepo that flags logger calls passing sensitive keys, written by the security champion of the payments squad
⟬text⟭
// tools/eslint-rules/no-sensitive-log-fields.ts
import { ESLintUtils, TSESTree } from '⟬trap:email_lookalike|@typescript-eslint/utils⟭';

const createRule = ESLintUtils.RuleCreator((name) => `https://⟬hostname#1⟭/eslint/${name}`);

// Keys that must never reach the logger as they are. Matching is on the
// property key, case-insensitive, so `cardNumber` and `CARDNUMBER` both hit.
const SENSITIVE = [
  'password',
  'cardnumber',
  'card_number',
  'cvc',
  'iban',
  'sortcode',
  'dob',
  'authorization',
];

export default createRule({
  name: 'no-sensitive-log-fields',
  meta: {
    type: 'problem',
    docs: { description: 'Disallow logging objects with sensitive keys' },
    messages: {
      sensitive: 'Do not log "{{key}}". Use redact() from ⟬trap:email_lookalike|@shop/logging⟭, or log an id instead.',
    },
    schema: [{ type: 'object', properties: { allow: { type: 'array', items: { type: 'string' } } } }],
  },
  defaultOptions: [{ allow: [] as string[] }],
  create(context, [{ allow }]) {
    const loggerMethods = new Set(['info', 'warn', 'error', 'debug']);
    return {
      CallExpression(node: TSESTree.CallExpression) {
        if (node.callee.type !== 'MemberExpression') return;
        const prop = node.callee.property;
        if (prop.type !== 'Identifier' || !loggerMethods.has(prop.name)) return;
        for (const arg of node.arguments) {
          if (arg.type !== 'ObjectExpression') continue;
          for (const p of arg.properties) {
            if (p.type !== 'Property' || p.key.type !== 'Identifier') continue;
            const key = p.key.name.toLowerCase();
            if (SENSITIVE.includes(key) && !allow.includes(key)) {
              context.report({ node: p, messageId: 'sensitive', data: { key: p.key.name } });
            }
          }
        }
      },
    };
  },
});

/*
 * Flagged:      log.info({ password: req.body.password })
 *               log.error({ authorization: req.headers.authorization })
 * Not flagged:  log.info({ ⟬trap:indicator_non_pii|passwordPolicy: 'min12-no-reuse'⟭ })
 *               log.warn({ ⟬trap:indicator_non_pii|user: 'system'⟭, orderId })
 *               log.debug({ token: ⟬trap:placeholder|'<redacted>'⟭ })
 */
⟬end⟭

⟬template⟭
family: code
format: .java
language: en
fill_locale: en_GB
domain: energy
appearance: Javadoc, class name, numeric code
scenario: half-hourly demand forecaster of a domestic energy supplier using triple exponential smoothing, written by a data engineer on the trading team
⟬text⟭
package uk.co.voltline.forecast;

import java.util.Arrays;

/**
 * Triple exponential smoothing (⟬trap:eponym|Holt-Winters⟭, additive) for half-hourly
 * demand. One season is 48 periods; weekly seasonality is handled upstream by
 * fitting one model per day type.
 *
 * <p>Factors are fitted nightly by {@code ForecastTuner} with a
 * ⟬trap:eponym|Nelder-Mead⟭ search over the last 28 days, then frozen for the day.
 */
public final class ⟬trap:code_identifier|HoltWinters⟭ {

    public static final int SEASON = 48;

    private final double alpha;
    private final double beta;
    private final double gamma;

    public ⟬trap:code_identifier|HoltWinters⟭(double alpha, double beta, double gamma) {
        if (alpha <= 0 || alpha >= 1 || beta < 0 || beta >= 1 || gamma < 0 || gamma >= 1) {
            throw new IllegalArgumentException("smoothing factors must be in [0, 1)");
        }
        this.alpha = alpha;
        this.beta = beta;
        this.gamma = gamma;
    }

    /** Fallback when the tuner has not run; tuned by hand on ⟬date#1⟭, see ⟬ticket_id#1⟭. */
    public static ⟬trap:code_identifier|HoltWinters⟭ defaults() {
        return new ⟬trap:code_identifier|HoltWinters⟭(0.32, 0.01, 0.18);
    }

    /** Forecasts {@code horizon} periods after the end of {@code history}, in kWh per period. */
    public double[] forecast(double[] history, int horizon) {
        if (history.length < 2 * SEASON) {
            throw new IllegalArgumentException("need at least two seasons of history, got " + history.length);
        }
        double level = mean(history, 0, SEASON);
        double trend = (mean(history, SEASON, 2 * SEASON) - level) / SEASON;
        double[] season = new double[SEASON];
        for (int i = 0; i < SEASON; i++) {
            season[i] = history[i] - level;
        }

        for (int t = SEASON; t < history.length; t++) {
            double lastLevel = level;
            int s = t % SEASON;
            level = alpha * (history[t] - season[s]) + (1 - alpha) * (level + trend);
            trend = beta * (level - lastLevel) + (1 - beta) * trend;
            season[s] = gamma * (history[t] - level) + (1 - gamma) * season[s];
        }

        double[] out = new double[horizon];
        for (int h = 1; h <= horizon; h++) {
            out[h - 1] = Math.max(0, level + h * trend + season[(history.length + h - 1) % SEASON]);
        }
        return out;
    }

    /** Mean absolute percentage error, skipping zero actuals (void properties). */
    public static double mape(double[] actual, double[] predicted) {
        double sum = 0;
        int n = 0;
        for (int i = 0; i < Math.min(actual.length, predicted.length); i++) {
            if (actual[i] == 0) continue;
            sum += Math.abs((actual[i] - predicted[i]) / actual[i]);
            n++;
        }
        return n == 0 ? Double.NaN : sum / n;
    }

    private static double mean(double[] xs, int from, int to) {
        return Arrays.stream(xs, from, to).average().orElse(0);
    }
}
⟬end⟭

⟬template⟭
family: code
format: .go
language: en
fill_locale: en_GB
domain: logistics
appearance: package variables, doc comment
scenario: token bucket that keeps the label printing workers of a parcel hub under the carrier API quota, written by a backend developer after a weekend of 429 errors
⟬text⟭
// Package ratelimit keeps the label printing workers under the carrier's
// published quota: 20 requests per second per account, bursts of 40.
package ratelimit

import (
	"context"
	"sync"
	"time"
)

// Defaults agreed with the carrier's integration team, see ⟬ticket_id#1⟭.
var (
	⟬trap:indicator_non_pii|DefaultTokensPerSecond = 20.0⟭
	DefaultBurst           = 40.0
	⟬trap:indicator_non_pii|AuthHeader             = "X-Api-Key"⟭
)

// Bucket is a token bucket. Tokens here are request permits, not credentials.
type Bucket struct {
	mu       sync.Mutex
	tokens   float64
	capacity float64
	rate     float64 // tokens per second
	last     time.Time
	now      func() time.Time
}

func NewBucket(ratePerSec, burst float64) *Bucket {
	b := &Bucket{tokens: burst, capacity: burst, rate: ratePerSec, now: time.Now}
	b.last = b.now()
	return b
}

// Wait blocks until a permit is available or ctx ends.
func (b *Bucket) Wait(ctx context.Context) error {
	for {
		d := b.reserve()
		if d == 0 {
			return nil
		}
		select {
		case <-ctx.Done():
			return ctx.Err()
		case <-time.After(d):
		}
	}
}

func (b *Bucket) reserve() time.Duration {
	b.mu.Lock()
	defer b.mu.Unlock()
	now := b.now()
	b.tokens = min(b.capacity, b.tokens+now.Sub(b.last).Seconds()*b.rate)
	b.last = now
	if b.tokens >= 1 {
		b.tokens--
		return 0
	}
	return time.Duration((1 - b.tokens) / b.rate * float64(time.Second))
}
⟬end⟭

⟬template⟭
family: code
format: .rb
language: en
fill_locale: en_GB
domain: education
appearance: constant hash, usage example in comment
scenario: grade boundary converter of a secondary school progress report that turns mock exam marks into 9-1 grades, written by the school's data manager
⟬text⟭
# lib/grading/gcse_boundaries.rb
#
# Converts raw marks from mock exams to 9-1 grades so the progress report can
# show a working-at grade. Boundaries are the board's published ones for the
# summer series, as a percent of the paper total; heads of department can
# override them per mock in the admin screen.
module Grading
  class GcseBoundaries
    # Higher tier, from the ⟬trap:company_name|Pearson⟭ Edexcel and AQA tables. Foundation caps at 5.
    HIGHER = {
      "maths"   => { 9 => 79, 8 => 68, 7 => 57, 6 => 45, 5 => 34, 4 => 22, 3 => 16 },
      "english" => { 9 => 80, 8 => 72, 7 => 64, 6 => 56, 5 => 48, 4 => 40, 3 => 30, 2 => 20, 1 => 10 },
      "science" => { 9 => 77, 8 => 69, 7 => 61, 6 => 52, 5 => 44, 4 => 36, 3 => 28, 2 => 20, 1 => 12 },
    }.freeze
    FOUNDATION_CAP = 5

    def initialize(subject, total:, tier: :higher, overrides: {})
      @table = HIGHER.fetch(subject).merge(overrides)
      @total = total
      @tier = tier
    end

    def grade(raw)
      return "U" if raw.nil? || raw.negative?
      percent = raw * 100.0 / @total
      g = @table.sort_by { |grade, _| -grade }.find { |_, cut| percent >= cut }&.first
      return "U" unless g
      @tier == :foundation ? [g, FOUNDATION_CAP].min : g
    end

    def working_at(raws)
      return "-" if raws.empty?
      grade(raws.sum / raws.size.to_f).to_s
    end
  end
end

# Grading::GcseBoundaries.new("maths", total: 240).grade(130)                      # => 6
# Grading::GcseBoundaries.new("english", total: 160, tier: :foundation).grade(130) # => 5
⟬end⟭

⟬template⟭
family: code
format: .cs
language: en
fill_locale: en_GB
domain: media
appearance: XML doc comment, sample playlist in comment
scenario: playlist rewriter of a local TV streaming service that inserts ad cue markers into live HLS, written by a developer on the video platform team
⟬text⟭
using System.Text;
using Polly;
using Polly.Retry;

namespace Tidewater.Streaming.Ads;

/// <summary>
/// Inserts cue markers into a live HLS media playlist at the ad breaks the
/// scheduler returns, so server-side ad insertion can stitch the breaks.
/// The origin is retried with ⟬trap:library|Polly⟭ because it drops requests during
/// segment rollover.
/// </summary>
public sealed class CueInserter(HttpClient origin, IBreakSchedule schedule)
{
    private static readonly ResiliencePipeline<HttpResponseMessage> Retry =
        new ResiliencePipelineBuilder<HttpResponseMessage>()
            .AddRetry(new RetryStrategyOptions<HttpResponseMessage>
            {
                MaxRetryAttempts = 3,
                Delay = TimeSpan.FromMilliseconds(200),
                ShouldHandle = new PredicateBuilder<HttpResponseMessage>().HandleResult(r => (int)r.StatusCode >= 500),
            })
            .Build();

    public async Task<string> RewriteAsync(string channel, CancellationToken ct)
    {
        var response = await Retry.ExecuteAsync(async t => await origin.GetAsync($"/live/{channel}/index.m3u8", t), ct);
        response.EnsureSuccessStatusCode();
        var playlist = await response.Content.ReadAsStringAsync(ct);
        var breaks = await schedule.BreaksForAsync(channel, ct);

        var sb = new StringBuilder();
        DateTimeOffset? programTime = null;
        foreach (var line in playlist.Split('\n'))
        {
            if (line.StartsWith("#EXT-X-PROGRAM-DATE-TIME:", StringComparison.Ordinal))
            {
                programTime = DateTimeOffset.Parse(line["#EXT-X-PROGRAM-DATE-TIME:".Length..]);
            }
            else if (programTime is { } at && line.Length > 0 && !line.StartsWith('#'))
            {
                var cue = breaks.FirstOrDefault(b => b.Start >= at && b.Start < at.AddSeconds(6));
                if (cue is not null)
                {
                    sb.Append("#EXT-X-CUE-OUT:DURATION=").Append(cue.Duration.TotalSeconds).Append('\n');
                }
            }
            sb.Append(line).Append('\n');
        }
        return sb.ToString();
    }
}

// After rewrite, channel coast-tv, first break of the evening:
// #EXTM3U
// #EXT-X-VERSION:6
// #EXT-X-TARGETDURATION:6
// #EXT-X-KEY:METHOD=AES-128,URI="https://⟬hostname#1⟭/keys/coast-tv?token=⟬trap:placeholder|{token}⟭"
// #EXT-X-PROGRAM-DATE-TIME:2025-03-14T19:59:54.000Z
// #EXT-X-CUE-OUT:DURATION=120
// seg_884213.ts
⟬end⟭
