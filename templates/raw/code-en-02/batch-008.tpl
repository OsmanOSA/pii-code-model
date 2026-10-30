⟬template⟭
family: code
format: .rb
language: en
fill_locale: en_GB
domain: e-commerce
appearance: email signature in heredoc, hash literal
scenario: Rails mailer that acknowledges trade orders of a furniture wholesaler, with the account manager's signature and the bank details for proforma payment hard-coded by a developer
⟬text⟭
# app/mailers/trade_order_mailer.rb
#
# Acknowledgement for trade (B2B) orders. Trade customers pay on proforma, so
# the email carries our bank details. The signature is the account manager's
# until the CRM sends one per account (⟬ticket_id#1⟭).
class TradeOrderMailer < ApplicationMailer
  default from: "⟬email:generic#1⟭", reply_to: "⟬email#2⟭"

  SIGNATURE = <<~TXT.freeze
    --
    ⟬person_name#2⟭
    Trade Account Manager, ⟬company#1⟭
    ⟬phone#2⟭ | ⟬email#2⟭
    ⟬postal_address#3⟭
  TXT

  BANK_DETAILS = {
    account_name: "⟬company#1⟭ Ltd",
    iban: "⟬iban#4⟭",
    bic: "⟬bic#4⟭",
    ⟬trap:indicator_non_pii|reference_format: "TRADE-<order number>"⟭,
  }.freeze

  def acknowledgement(order)
    @order = order
    @bank = BANK_DETAILS
    @signature = SIGNATURE
    attachments["proforma-#{order.number}.pdf"] = ProformaPdf.new(order, @bank).render
    mail(to: order.buyer_email, cc: order.account.accounts_payable_email,
         subject: "Order #{order.number} received, proforma attached")
  end
end
⟬end⟭

⟬template⟭
family: code
format: .ts
language: en
fill_locale: en_GB
domain: logistics
appearance: Markdown table in doc comment, connection string fallback
scenario: BullMQ worker of an online returns service that books van collections for bulky items, with the staging collection points listed in a Markdown table by the backend developer
⟬text⟭
// src/workers/collections.worker.ts
import { Job, Worker } from 'bullmq';
import IORedis from 'ioredis';
import { bookCollection } from '../carriers/van-network';

/**
 * Books van collections for returns too big for a locker drop-off.
 *
 * Staging collection points (the depot team knows these take parcels at any time):
 *
 * | point     | contact | address | van |
 * |-----------|---------|---------|-----|
 * | STG-NORTH | ⟬person_name#1⟭ | ⟬postal_address#1⟭ | ⟬uk_license_plate#1⟭ |
 * | STG-SOUTH | ⟬person_name#2⟭ | ⟬postal_address#2⟭ | ⟬uk_license_plate#2⟭ |
 *
 * The driver phones the contact on arrival: ⟬phone#1⟭ and ⟬phone#2⟭.
 */
const connection = new IORedis(process.env.REDIS_URL ?? 'redis://default:⟬url_password#1⟭@⟬hostname#1⟭:6379/2', {
  maxRetriesPerRequest: null,
});

type CollectionJob = { returnId: string; pointId: string; windowStart: string; windowEnd: string; parcels: number };

export const worker = new Worker<CollectionJob>(
  'collections',
  async (job: Job<CollectionJob>) => {
    const booking = await bookCollection({
      reference: job.data.returnId,
      point: job.data.pointId,
      window: [job.data.windowStart, job.data.windowEnd],
      parcels: job.data.parcels,
    });
    await job.updateProgress(100);
    return { bookingRef: booking.ref, van: booking.vehicleReg };
  },
  { connection, concurrency: 5, limiter: { max: 20, duration: 1000 } },
);

worker.on('failed', (job, err) => {
  console.error(`collection for ${job?.data.returnId} failed: ${err.message}`);
});
⟬end⟭

⟬template⟭
family: code
format: .java
language: en
fill_locale: en_GB
domain: travel
appearance: constructor arguments, helper method, assertion
scenario: JUnit tests of the ID document check for a young person's railcard sold by a rail ticket app, written by the developer who fixed an off-by-one in the age band
⟬text⟭
package uk.co.railhop.railcards;

import static org.assertj.core.api.Assertions.assertThat;

import java.time.Clock;
import java.time.LocalDate;
import java.time.ZoneId;
import org.junit.jupiter.api.Test;

class YouthRailcardEligibilityTest {

    private static final ZoneId LONDON = ZoneId.of("Europe/London");

    // Frozen on the purchase day of the support case that showed the off-by-one (⟬ticket_id#1⟭).
    private final Clock clock = Clock.fixed(LocalDate.of(2025, 9, 1).atStartOfDay(LONDON).toInstant(), LONDON);
    private final YouthRailcardEligibility eligibility = new YouthRailcardEligibility(clock);

    @Test
    void passportWithTheSameDateOfBirthRaisesNoDocumentProblem() {
        Applicant a = applicant("⟬person_name#1⟭", "⟬birth_date#1⟭",
            new IdDocument(IdType.PASSPORT, "⟬uk_passport#1⟭", "⟬birth_date#1⟭", "⟬date#1⟭"));

        assertThat(eligibility.documentProblems(a)).isEmpty();
    }

    @Test
    void drivingLicenceShowingAnotherDateOfBirthIsRejected() {
        Applicant a = applicant("⟬person_name#2⟭", "⟬birth_date#2⟭",
            new IdDocument(IdType.DRIVING_LICENCE, "⟬uk_driving_licence#2⟭", "⟬birth_date#3⟭", "⟬date#2⟭"));

        assertThat(eligibility.documentProblems(a)).containsExactly(Problem.DATE_OF_BIRTH_MISMATCH);
    }

    @Test
    void ageBandEndsTheDayBeforeTheTwentySixthBirthday() {
        LocalDate today = LocalDate.now(clock);

        assertThat(eligibility.inAgeBand(today.minusYears(26).plusDays(1))).isTrue();
        assertThat(eligibility.inAgeBand(today.minusYears(26))).isFalse();
    }

    private static Applicant applicant(String name, String dob, IdDocument document) {
        return new Applicant(name, LocalDate.parse(dob, Applicant.UK_DATE), document);
    }
}
⟬end⟭

⟬template⟭
family: code
format: .js
language: en
fill_locale: en_GB
domain: education
appearance: Knex seed rows, comment
scenario: Knex seed of a university accommodation office app with hall contracts and UK guarantors, written by a developer for local runs and review apps
⟬text⟭
// seeds/02_hall_contracts.js
// Local and review-app data for the accommodation office. UK guarantors need an
// NI number for the referencing check; international students use the
// university guarantor scheme instead. People agreed with ⟬person_name:initial#3⟭
// in the accommodation office, who uses the same ones in the training videos.

exports.seed = async function seed(knex) {
  await knex('guarantors').del();
  await knex('contracts').del();

  await knex('contracts').insert([
    { id: 1, student_id: '⟬customer_id#1⟭', hall: 'Riverside', room: 'B214', weeks: 42, weekly_rent_pence: 18900, starts_on: '2025-09-20' },
    { id: 2, student_id: '⟬customer_id#2⟭', hall: 'Riverside', room: 'B215', weeks: 42, weekly_rent_pence: 18900, starts_on: '2025-09-20' },
    { id: 3, student_id: '⟬customer_id#4⟭', hall: '⟬trap:eponym|Ruskin⟭ Court', room: 'G03', weeks: 51, weekly_rent_pence: 21450, starts_on: '2025-09-13' },
  ]);

  await knex('guarantors').insert([
    {
      contract_id: 1,
      full_name: '⟬person_name#5⟭',
      relationship: 'parent',
      email: '⟬email#5⟭',
      phone: '⟬phone#5⟭',
      address: '⟬postal_address#5⟭',
      ni_number: '⟬uk_national_insurance_number#5⟭',
      scheme: null,
    },
    {
      contract_id: 2,
      full_name: '⟬person_name#6⟭',
      relationship: 'grandparent',
      email: '⟬email#6⟭',
      phone: '⟬phone#6⟭',
      address: '⟬postal_address#6⟭',
      ni_number: '⟬uk_national_insurance_number#6⟭',
      scheme: null,
    },
    // international student: no UK guarantor, covered by the university scheme
    { contract_id: 3, full_name: null, relationship: null, email: null, phone: null, address: null, ni_number: null, scheme: 'UNI-GUARANTEE' },
  ]);
};
⟬end⟭

⟬template⟭
family: code
format: .rb
language: en
fill_locale: en_GB
domain: energy
appearance: let block, HTTP header, comment
scenario: RSpec request spec of the webhook through which a payment provider reports smart prepay top-ups, written by a developer with a sandbox callback replayed under a frozen clock
⟬text⟭
# spec/requests/webhooks/prepay_top_ups_spec.rb
require "rails_helper"

RSpec.describe "Prepay top-up webhook", type: :request do
  # The provider signs each callback as a JWT in X-Signature. This is a real
  # sandbox callback for a £20 top-up paid with the provider's test card
  # ⟬payment_card#1⟭ (any expiry, any CVC), replayed with the clock frozen.
  let(:signature) { "⟬jwt#1⟭" }
  let(:headers) { { "Content-Type" => "application/json", "X-Signature" => signature } }
  let(:payload) do
    {
      event: "topup.succeeded",
      meter_serial: "21E5012345",
      account_id: "⟬customer_id#1⟭",
      amount_pence: 2000,
      receipt_email: "⟬email#1⟭",
      paid_at: "2025-02-03T18:22:10Z",
    }
  end

  around { |example| travel_to(Time.utc(2025, 2, 3, 18, 22, 30)) { example.run } }

  it "credits the meter and emails the receipt" do
    expect { post "/webhooks/prepay/top_ups", params: payload.to_json, headers: headers }
      .to have_enqueued_job(MeterCreditJob).with("21E5012345", 2000)
      .and have_enqueued_mail(TopUpMailer, :receipt)

    expect(response).to have_http_status(:no_content)
  end

  it "rejects a callback whose body does not match the signed hash" do
    post "/webhooks/prepay/top_ups", params: payload.merge(amount_pence: 20_000).to_json, headers: headers

    expect(response).to have_http_status(:unauthorized)
    expect(MeterCreditJob).not_to have_been_enqueued
  end

  it "ignores a replay of the same top-up" do
    2.times { post "/webhooks/prepay/top_ups", params: payload.to_json, headers: headers }

    expect(MeterCreditJob).to have_been_enqueued.once
  end
end
⟬end⟭

⟬template⟭
family: code
format: .cs
language: en
fill_locale: en_GB
domain: education
appearance: config fallback, resource arguments, file content
scenario: Pulumi program of an edtech company that manages its GitHub repositories and their Actions secrets, with tokens left as fallbacks during the move from Terraform
⟬text⟭
using Pulumi;
using Pulumi.Github;
using Pulumi.Github.Inputs;

// Owns the repositories of the platform team and their Actions secrets.
// Run from the platform laptop: pulumi up -s prod
return await Deployment.RunAsync(() =>
{
    var config = new Config();

    // platform bot account; `pulumi config set --secret` was skipped during the
    // move from Terraform, see ⟬ticket_id#1⟭
    var github = new Provider("github", new ProviderArgs
    {
        Owner = "quillbox-learning",
        Token = config.Get("githubToken") ?? "⟬github_token#1⟭",
    });
    var npmToken = config.Get("npmToken") ?? "⟬npm_token#1⟭";

    foreach (var name in new[] { "reading-app", "teacher-dashboard", "content-player" })
    {
        var repo = new Repository(name, new RepositoryArgs
        {
            Name = name,
            Visibility = "private",
            DeleteBranchOnMerge = true,
            VulnerabilityAlerts = true,
        }, new CustomResourceOptions { Provider = github, Protect = true });

        new ActionsSecret($"{name}-npm-token", new ActionsSecretArgs
        {
            Repository = repo.Name,
            SecretName = "NPM_TOKEN",
            PlaintextValue = npmToken,
        }, new CustomResourceOptions { Provider = github });

        new RepositoryFile($"{name}-codeowners", new RepositoryFileArgs
        {
            Repository = repo.Name,
            File = ".github/CODEOWNERS",
            Content = "* ⟬trap:email_lookalike|@quillbox-learning/platform⟭\n",
            CommitMessage = "Managed by Pulumi",
            OverwriteOnCreate = true,
        }, new CustomResourceOptions { Provider = github });
    }

    new BranchProtection("content-player-main", new BranchProtectionArgs
    {
        RepositoryId = "content-player",
        Pattern = "main",
        RequiredPullRequestReviews = new[] { new BranchProtectionRequiredPullRequestReviewArgs { RequiredApprovingReviewCount = 1 } },
    }, new CustomResourceOptions { Provider = github });
});
⟬end⟭

⟬template⟭
family: code
format: .go
language: en
fill_locale: en_GB
domain: media
appearance: constant, map literal, Slack message
scenario: Lambda of a regional news group that alerts the news desk on Slack when an agency wire feed goes quiet, written by a developer with the agency tech desk contacts in a map
⟬text⟭
// Command wirewatch alerts the news desk when an agency wire feed has been
// silent for longer than usual. EventBridge runs it every five minutes.
package main

import (
	"context"
	"fmt"
	"time"

	"github.com/aws/aws-lambda-go/lambda"
	"github.com/slack-go/slack"
)

const slackToken = "⟬slack_token#1⟭" // newsdesk-alerts app, from the 2023 install

// Technical desk of each agency, from the contracts folder.
var agencyContacts = map[string]string{
	"PA":                               "⟬person_name#1⟭, ⟬phone#1⟭",
	"⟬trap:company_name|Reuters⟭": "⟬email:generic#2⟭",
	"AFP":                              "⟬person_name#3⟭ (⟬trap:initials|JPL⟭ on the rota), ⟬phone#3⟭",
}

var maxSilence = map[string]time.Duration{
	"PA":                               10 * time.Minute,
	"⟬trap:company_name|Reuters⟭": 15 * time.Minute,
	"AFP":                              20 * time.Minute,
}

func handler(ctx context.Context) error {
	last, err := lastItemTimes(ctx)
	if err != nil {
		return err
	}
	api := slack.New(slackToken)
	for agency, at := range last {
		silent := time.Since(at)
		if silent < maxSilence[agency] {
			continue
		}
		msg := fmt.Sprintf(":rotating_light: No %s copy for %s. Agency tech desk: %s", agency, silent.Round(time.Minute), agencyContacts[agency])
		if _, _, err := api.PostMessageContext(ctx, "#newsdesk", slack.MsgOptionText(msg, false)); err != nil {
			return err
		}
	}
	return nil
}

func main() { lambda.Start(handler) }
⟬end⟭

⟬template⟭
family: code
format: .java
language: en
fill_locale: en_GB
domain: e-commerce
appearance: Javadoc, bit operations
scenario: in-memory filter that tells the reviews service of an online grocer whether a customer already reviewed a product, written by a backend developer to spare the database
⟬text⟭
package com.basketful.reviews.dedupe;

import com.google.common.hash.Hashing;
import java.nio.charset.StandardCharsets;
import java.util.BitSet;

/**
 * Answers "has this customer already reviewed this product?" before the
 * database is hit. False positives fall through to the database check; false
 * negatives cannot happen.
 *
 * <p>The k positions come from the two 64-bit halves of one Murmur3 hash, the
 * ⟬trap:eponym|Kirsch-Mitzenmacher⟭ trick, instead of k separate hashes. Keys look like
 * {@code ⟬customer_id#1⟭ + "SKU-⟬trap:word_name|ROSE⟭-GOLD-KETTLE"}.
 */
public final class ReviewedFilter {

    private final BitSet bits;
    private final int size;
    private final int hashes;

    /** Sized for {@code expected} entries at false positive rate {@code fpp}. */
    public ReviewedFilter(long expected, double fpp) {
        this.size = (int) Math.ceil(-expected * Math.log(fpp) / (Math.log(2) * Math.log(2)));
        this.hashes = Math.max(1, (int) Math.round((double) size / expected * Math.log(2)));
        this.bits = new BitSet(size);
    }

    public void add(String customerId, String sku) {
        long[] h = halves(customerId, sku);
        for (int i = 0; i < hashes; i++) bits.set(index(h, i));
    }

    public boolean mightContain(String customerId, String sku) {
        long[] h = halves(customerId, sku);
        for (int i = 0; i < hashes; i++) {
            if (!bits.get(index(h, i))) return false;
        }
        return true;
    }

    /** Share of bits set, for the metrics endpoint: above half full the filter is rebuilt. */
    public double fillRatio() {
        return (double) bits.cardinality() / size;
    }

    private int index(long[] h, int i) {
        return (int) Math.floorMod(h[0] + i * h[1], (long) size);
    }

    private static long[] halves(String customerId, String sku) {
        byte[] hash = Hashing.murmur3_128().hashString(customerId + '\u0000' + sku, StandardCharsets.UTF_8).asBytes();
        long a = 0;
        long b = 0;
        for (int i = 0; i < 8; i++) {
            a = (a << 8) | (hash[i] & 0xff);
            b = (b << 8) | (hash[i + 8] & 0xff);
        }
        return new long[] {a, b};
    }
}
⟬end⟭

⟬template⟭
family: code
format: .js
language: en
fill_locale: en_GB
domain: energy
appearance: Express route, constants
scenario: Express route of an energy supplier's account page widget that shows the greenest hours to run appliances, written by a front-end developer with a cached call to an open carbon intensity API
⟬text⟭
// src/routes/carbon-widget.js
// "Greenest time to run your appliances" widget on the account page. Data comes
// from the open carbon intensity API, cached for 30 minutes per region because
// every account page load would otherwise call it.

const express = require('express');

const API = 'https://⟬hostname#1⟭';
const ⟬trap:indicator_non_pii|API_KEY = null⟭; // the API is open, nothing to rotate
const TTL_MS = 30 * 60 * 1000;
const cache = new Map();

async function forecast(regionId) {
  const hit = cache.get(regionId);
  if (hit && Date.now() - hit.at < TTL_MS) return hit.data;
  const from = `${new Date().toISOString().slice(0, 16)}Z`;
  const res = await fetch(`${API}/regional/intensity/${from}/fw24h/regionid/${regionId}`);
  if (!res.ok) throw new Error(`carbon intensity API answered ${res.status}`);
  const body = await res.json();
  const data = body.data.data.map((p) => ({ from: p.from, to: p.to, gco2: p.intensity.forecast, index: p.intensity.index }));
  cache.set(regionId, { at: Date.now(), data });
  return data;
}

function greenestWindow(points, hours = 3) {
  const size = hours * 2;
  let best = null;
  for (let i = 0; i + size <= points.length; i += 1) {
    const slice = points.slice(i, i + size);
    const avg = slice.reduce((sum, p) => sum + p.gco2, 0) / size;
    if (!best || avg < best.avg) best = { from: slice[0].from, to: slice[size - 1].to, avg: Math.round(avg) };
  }
  return best;
}

const router = express.Router();

router.get('/widgets/carbon/:regionId(\\d+)', async (req, res, next) => {
  try {
    const points = await forecast(req.params.regionId);
    res.set('Cache-Control', 'private, max-age=600').json({ window: greenestWindow(points), points });
  } catch (err) {
    next(err);
  }
});

module.exports = router;
⟬end⟭

⟬template⟭
family: code
format: .ts
language: en
fill_locale: en_GB
domain: logistics
appearance: discriminated union, reducer, comment
scenario: parcel tracking state of a delivery tracking page, folded from carrier events that arrive late or twice, written by a front-end developer on the post-purchase team
⟬text⟭
// src/tracking/state.ts
// Tracking state as the customer page shows it, folded from carrier events.
// Carriers send events out of order and twice; the reducer ignores anything
// older than the current state.

export type TrackingEvent =
  | { type: 'LABEL_CREATED'; at: string }
  | { type: 'COLLECTED'; at: string; depot: string }
  | { type: 'IN_TRANSIT'; at: string; depot: string }
  | { type: 'OUT_FOR_DELIVERY'; at: string; eta?: { from: string; to: string } }
  | { type: 'FAILED_ATTEMPT'; at: string; reason: 'NO_ACCESS' | 'NOBODY_HOME' | 'REFUSED'; nextAttempt?: string }
  | { type: 'DELIVERED'; at: string; signedBy: string; photoUrl?: string }
  | { type: 'RETURNED_TO_SENDER'; at: string };

export type TrackingState = { status: TrackingEvent['type']; lastUpdate: string; attempts: number; detail?: string };

const ORDER: TrackingEvent['type'][] = [
  'LABEL_CREATED', 'COLLECTED', 'IN_TRANSIT', 'OUT_FOR_DELIVERY', 'FAILED_ATTEMPT', 'DELIVERED', 'RETURNED_TO_SENDER',
];

// When nobody signs, carriers put a code in signedBy, e.g. ⟬trap:indicator_non_pii|signedBy: 'SAFE_PLACE'⟭.
// Signatory names never reach this module: the carrier adapters drop them.
const NO_SIGNATURE = new Set(['SAFE_PLACE', 'NEIGHBOUR', 'LOCKER']);

export function reduce(state: TrackingState | undefined, event: TrackingEvent): TrackingState {
  if (state && event.at < state.lastUpdate) return state;
  // a new delivery round after a failed attempt is the only step back allowed
  if (state && ORDER.indexOf(event.type) < ORDER.indexOf(state.status) && event.type !== 'OUT_FOR_DELIVERY') return state;

  const attempts = state?.attempts ?? 0;
  switch (event.type) {
    case 'FAILED_ATTEMPT':
      return { status: event.type, lastUpdate: event.at, attempts: attempts + 1, detail: event.reason };
    case 'DELIVERED':
      return {
        status: event.type,
        lastUpdate: event.at,
        attempts,
        detail: NO_SIGNATURE.has(event.signedBy) ? event.signedBy.toLowerCase().replace('_', ' ') : 'signed',
      };
    case 'COLLECTED':
    case 'IN_TRANSIT':
      return { status: event.type, lastUpdate: event.at, attempts, detail: event.depot };
    default:
      return { status: event.type, lastUpdate: event.at, attempts };
  }
}

export const fold = (events: TrackingEvent[]): TrackingState | undefined =>
  events
    .slice()
    .sort((a, b) => a.at.localeCompare(b.at))
    .reduce<TrackingState | undefined>(reduce, undefined);
⟬end⟭
