⟬template⟭
family: code
format: .cs
language: en
fill_locale: en_GB
domain: logistics
appearance: constant, positional record argument, assertion
scenario: integration tests of the start-shift endpoint of a courier driver app, written by a backend developer with a dev-signed driver token pasted in
⟬text⟭
using System.Net;
using System.Net.Http.Headers;
using System.Net.Http.Json;
using Couriers.Api.Shifts;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Testing;

namespace Couriers.Api.Tests;

public class StartShiftTests(WebApplicationFactory<Program> factory) : IClassFixture<WebApplicationFactory<Program>>
{
    // driver app token for the pilot test driver, signed with the dev key from appsettings.Development.json
    private const string DriverJwt = "⟬jwt#1⟭";

    [Fact]
    public async Task Shift_starts_when_licence_and_van_match_the_roster()
    {
        var client = factory.CreateClient();
        client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", DriverJwt);

        var res = await client.PostAsJsonAsync("/v1/shifts", new StartShift("⟬uk_license_plate#1⟭", "⟬uk_driving_licence#1⟭", OdometerMiles: 48211, Lat: 51.4545, Lon: -2.5879));

        Assert.Equal(HttpStatusCode.Created, res.StatusCode);
    }

    [Fact]
    public async Task Shift_is_refused_for_a_van_rostered_to_someone_else()
    {
        var client = factory.CreateClient();
        client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", DriverJwt);

        var res = await client.PostAsJsonAsync("/v1/shifts", new StartShift("⟬uk_license_plate#2⟭", "⟬uk_driving_licence#1⟭", 1200, 51.45, -2.58));

        Assert.Equal(HttpStatusCode.Conflict, res.StatusCode);
        var problem = await res.Content.ReadFromJsonAsync<ProblemDetails>();
        Assert.Contains("⟬uk_license_plate#2⟭", problem!.Detail);
    }
}
⟬end⟭

⟬template⟭
family: code
format: .ts
language: en
fill_locale: en_GB
domain: media
appearance: schema default, comment
scenario: validated environment module of a newsroom Slack bot, where a developer put working tokens as defaults so the bot starts locally without a .env file
⟬text⟭
// src/env.ts
// Validated environment for the newsroom bot. Defaults are for local runs only.
import { z } from 'zod';

const schema = z.object({
  NODE_ENV: z.enum(['development', 'test', 'production']).default('development'),
  PORT: z.coerce.number().default(3000),
  SLACK_BOT_TOKEN: z.string().startsWith('xox').default('⟬slack_token#1⟭'),
  SLACK_SIGNING_SECRET: z.string().min(32).default('⟬opaque_token#2⟭'),
  GITHUB_TOKEN: z.string().default('⟬github_token#1⟭'), // corrections repo, issues only
  NPM_TOKEN: z.string().default('⟬npm_token#1⟭'), // used by /release-widget
  ⟬trap:indicator_non_pii|TOKEN_CACHE_TTL: z.coerce.number().default(900)⟭,
  CORRECTIONS_REPO: z.string().default('ledger-newsroom/corrections'),
});

export const env = schema.parse(process.env);
export type Env = z.infer<typeof schema>;
⟬end⟭

⟬template⟭
family: code
format: .java
language: en
fill_locale: en_GB
domain: education
appearance: builder call, stub matcher, assertion, Javadoc
scenario: WireMock contract tests of the client that submits enhanced DBS checks for new staff of a school trust, written by the developer of the safeguarding module
⟬text⟭
package uk.org.brightpath.safeguarding.dbs;

import static com.github.tomakehurst.wiremock.client.WireMock.aResponse;
import static com.github.tomakehurst.wiremock.client.WireMock.equalTo;
import static com.github.tomakehurst.wiremock.client.WireMock.matchingJsonPath;
import static com.github.tomakehurst.wiremock.client.WireMock.okJson;
import static com.github.tomakehurst.wiremock.client.WireMock.post;
import static com.github.tomakehurst.wiremock.client.WireMock.stubFor;
import static org.assertj.core.api.Assertions.assertThat;

import com.github.tomakehurst.wiremock.junit5.WireMockRuntimeInfo;
import com.github.tomakehurst.wiremock.junit5.WireMockTest;
import java.time.LocalDate;
import java.util.List;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

/**
 * Contract tests for the umbrella body client that submits enhanced DBS checks
 * for new staff. Identity follows route 1: a passport plus further documents.
 */
@WireMockTest
class DbsSubmissionClientTest {

    private DbsSubmissionClient client;

    @BeforeEach
    void setUp(WireMockRuntimeInfo wm) {
        client = new DbsSubmissionClient(wm.getHttpBaseUrl(), "⟬opaque_token#1⟭");
    }

    private Applicant applicant() {
        return Applicant.builder()
            .title("Ms")
            .forenames("⟬person_name:given#1f⟭")
            .surname("⟬person_name:family#1⟭")
            .dateOfBirth(LocalDate.parse("⟬birth_date#1⟭", Applicant.UK_DATE))
            .niNumber("⟬uk_national_insurance_number#1⟭")
            .currentAddress("⟬postal_address#1⟭", LocalDate.parse("⟬date#4⟭", Applicant.UK_DATE))
            .previousAddress("⟬postal_address#3⟭", LocalDate.parse("⟬date#5⟭", Applicant.UK_DATE))
            .documents(List.of(
                new IdDocument(IdDocument.Type.PASSPORT, "⟬uk_passport#1⟭", "GBR"),
                new IdDocument(IdDocument.Type.DRIVING_LICENCE, "⟬uk_driving_licence#1⟭", "GBR"),
                new IdDocument(IdDocument.Type.UTILITY_BILL, null, null)))
            .role("Teaching assistant, regulated activity with children")
            .build();
    }

    @Test
    void submitsRouteOneDocumentsAndReturnsTheReference() {
        stubFor(post("/api/v2/applications")
            .withHeader("X-Api-Key", equalTo("⟬opaque_token#1⟭"))
            .withRequestBody(matchingJsonPath("$.applicant.niNumber", equalTo("⟬uk_national_insurance_number#1⟭")))
            .withRequestBody(matchingJsonPath("$.documents[0].number", equalTo("⟬uk_passport#1⟭")))
            .willReturn(okJson("{\"reference\":\"E0012874431\",\"status\":\"SUBMITTED\"}")));

        Submission s = client.submit(applicant());

        assertThat(s.reference()).isEqualTo("E0012874431");
        assertThat(s.status()).isEqualTo(Status.SUBMITTED);
    }

    @Test
    void rejectionsCarryTheUmbrellaBodyReason() {
        stubFor(post("/api/v2/applications").willReturn(aResponse().withStatus(422)
            .withBody("{\"errors\":[{\"field\":\"previousAddress\",\"message\":\"gap of more than 3 months\"}]}")));

        assertThat(client.submit(applicant()).errors())
            .extracting(DbsError::field)
            .containsExactly("previousAddress");
    }

    @Test
    void logsNeverContainDocumentNumbers() {
        stubFor(post("/api/v2/applications").willReturn(okJson("{\"reference\":\"E1\",\"status\":\"SUBMITTED\"}")));
        LogCapture logs = LogCapture.forClass(DbsSubmissionClient.class);

        client.submit(applicant());

        assertThat(logs.text()).doesNotContain("⟬uk_passport#1⟭", "⟬uk_driving_licence#1⟭", "⟬uk_national_insurance_number#1⟭");
    }
}
⟬end⟭

⟬template⟭
family: code
format: .go
language: en
fill_locale: en_GB
domain: travel
appearance: raw GDS record, assertion
scenario: Go test of the PNR parser used by the group travel desk of a tour operator, with a booking record pasted from the GDS terminal emulator
⟬text⟭
package pnr

import (
	"strings"
	"testing"
)

// Raw PNR as the terminal emulator returns it for the group desk.
// Element numbers and spacing matter: do not reformat.
const sample = `
RP/LONU12345/LONU12345            AA/SU  ⟬date#2⟭/1012Z   ⟬order_number#1⟭
  1.⟬person_name:family#1f⟭/⟬person_name:given#1⟭ MS   2.⟬person_name:family#2m⟭/⟬person_name:given#2⟭ MR
  3  BA 117 Y 14NOV 5 LHRJFK HK2  0830 1120  *1A/E*
  4 AP ⟬phone#1⟭ M
  5 APE ⟬email#1⟭
  6 SSR DOCS BA HK1 P/GBR/⟬uk_passport#1⟭/GBR/⟬birth_date#1⟭/F/⟬date#1⟭/⟬person_name:family#1⟭/⟬person_name:given#1⟭/P1
  7 SSR DOCS BA HK1 P/GBR/⟬uk_passport#2⟭/GBR/⟬birth_date#2⟭/M/⟬date#1⟭/⟬person_name:family#2⟭/⟬person_name:given#2⟭/P2
  8 FP CC⟬payment_card#3⟭/0829
  9 RM SEATS REQ TOGETHER - CALLED ⟬trap:initials|JM⟭ AT DESK
`

func TestParsePassengersAndDocs(t *testing.T) {
	p, err := Parse(strings.NewReader(sample))
	if err != nil {
		t.Fatal(err)
	}
	if len(p.Passengers) != 2 {
		t.Fatalf("passengers = %d", len(p.Passengers))
	}
	lead := p.Passengers[0]
	if lead.Surname != "⟬person_name:family#1⟭" || lead.Doc.Number != "⟬uk_passport#1⟭" {
		t.Errorf("lead = %+v", lead)
	}
	if p.Contact.Email != "⟬email#1⟭" {
		t.Errorf("email = %q", p.Contact.Email)
	}
}

func TestFormOfPaymentIsMaskedOnParse(t *testing.T) {
	p, _ := Parse(strings.NewReader(sample))
	if strings.Contains(p.FormOfPayment, "⟬payment_card#3⟭") {
		t.Fatal("card number kept in clear")
	}
	if !strings.HasSuffix(p.FormOfPayment, "/0829") {
		t.Errorf("fop = %q", p.FormOfPayment)
	}
}
⟬end⟭

⟬template⟭
family: code
format: .rb
language: en
fill_locale: en_GB
domain: media
appearance: factory attributes, assertion
scenario: RSpec spec of the monthly payment batch for freelance contributors of a regional news group, written by the developer who added overseas payees
⟬text⟭
# spec/services/contributor_payments/batch_builder_spec.rb
require "rails_helper"

RSpec.describe ContributorPayments::BatchBuilder do
  let(:month) { Date.new(2026, 9, 1) }
  let(:uk) do
    create(:contributor, legal_name: "⟬person_name#1⟭", email: "⟬email#1⟭",
                         ni_number: "⟬uk_national_insurance_number#1⟭",
                         sort_code: "08-90-61", account_number: "⟬bank_account_number#1⟭")
  end
  let(:abroad) do
    create(:contributor, legal_name: "⟬person_name#2⟭", email: "⟬email#2⟭", iban: "⟬iban#2⟭", country: "⟬country#2⟭")
  end

  before do
    create(:commission, contributor: uk, fee_pence: 45_000, published_on: Date.new(2026, 9, 3), slug: "flood-defences-explainer")
    create(:commission, contributor: uk, fee_pence: 12_500, published_on: Date.new(2026, 9, 21), slug: "council-budget-live")
    create(:commission, contributor: abroad, fee_pence: 30_000, published_on: Date.new(2026, 9, 14), slug: "housing-photo-essay")
  end

  subject(:lines) { described_class.new(month: month).lines }

  it "pays UK contributors by Faster Payments on sort code and account" do
    line = lines.find { |l| l.contributor_id == uk.id }
    expect(line.scheme).to eq("FPS")
    expect(line.account).to eq("08-90-61 ⟬bank_account_number#1⟭")
    expect(line.amount_pence).to eq(57_500)
  end

  it "pays overseas contributors on IBAN" do
    line = lines.find { |l| l.contributor_id == abroad.id }
    expect(line).to have_attributes(scheme: "SEPA", account: "⟬iban#2⟭", payee: "⟬person_name#2⟭")
  end

  it "puts the month in the payment reference" do
    expect(lines.map(&:reference).uniq).to eq(["LEDGER SEP 2026"])
  end

  it "leaves out contributors with nothing published that month" do
    create(:contributor, legal_name: "⟬person_name#3⟭", email: "⟬email#3⟭")
    expect(lines.size).to eq(2)
  end
end
⟬end⟭

⟬template⟭
family: code
format: .js
language: en
fill_locale: en_GB
domain: energy
appearance: environment fallback, workflow input
scenario: one-off script of an energy price comparison team that dispatches the tariff data workflow, passing a registry token as a workflow input
⟬text⟭
// scripts/trigger-tariff-refresh.js
// Kicks the tariff-data workflow after the regulator publishes the new cap. Needs actions:write.
const { Octokit } = require('@octokit/rest');

const octokit = new Octokit({ auth: process.env.GH_TOKEN || '⟬github_token#1⟭' });

octokit.actions
  .createWorkflowDispatch({ owner: 'gridwise', repo: 'tariff-data', workflow_id: 'refresh.yml', ref: 'main', inputs: { npm_token: '⟬npm_token#1⟭', cap_period: process.argv[2] } })
  .then(() => console.log('dispatched'))
  .catch((err) => {
    console.error(err.status, err.message);
    process.exit(1);
  });
⟬end⟭

⟬template⟭
family: code
format: .cs
language: en
fill_locale: en_GB
domain: travel
appearance: static field, aligned rows in comment
scenario: weekly SEPA payment run of a tour operator to European hotel suppliers, with sandbox bank rows a finance developer pasted after the onboarding call
⟬text⟭
namespace Wanderly.Finance.Payments;

/// <summary>
/// Weekly payment run to hotel and transfer suppliers. EUR suppliers go out as SEPA
/// credit transfers in a pain.001 file built by <see cref="Pain001Writer"/>.
/// </summary>
public sealed class SupplierPaymentRun(ISupplierLedger ledger, Pain001Writer writer, TimeProvider clock)
{
    // Account the run is paid from. Prod reads it from config; this is the sandbox one.
    private static readonly Account DebtorAccount = new("Wanderly Travel Ltd", "⟬iban#1⟭", "⟬bic#1⟭");

    public async Task<string> BuildAsync(CancellationToken ct)
    {
        var due = await ledger.DueInvoicesAsync(clock.GetUtcNow().Date.AddDays(3), ct);
        var payments = due
            .GroupBy(i => i.SupplierId)
            .Select(g => new CreditTransfer(
                Creditor: g.First().SupplierName,
                Iban: g.First().Iban,
                Bic: g.First().Bic,
                Amount: g.Sum(i => i.AmountEur),
                RemittanceInfo: string.Join(" ", g.Select(i => i.InvoiceNumber))))
            .ToList();
        return writer.Write(DebtorAccount, payments);
    }
}

// Sandbox rows from the bank onboarding call with ⟬person_name#2⟭ (⟬email#2⟭):
//   ⟬company#3⟭   ⟬iban#3⟭   ⟬bic#3⟭   ⟬invoice_number#3⟭   1240.00 EUR
//   ⟬company#4⟭   ⟬iban#4⟭   ⟬bic#4⟭   ⟬invoice_number#4⟭    310.50 EUR
⟬end⟭

⟬template⟭
family: code
format: .ts
language: en
fill_locale: en_GB
domain: e-commerce
appearance: test fixture, object literal, assertion
scenario: Vitest suite for seller onboarding on a handmade goods marketplace, written by a developer adding the NI number rule for sole traders
⟬text⟭
import { describe, expect, it } from 'vitest';
import { sellerApplication } from '../src/onboarding/schema';
import { submitApplication } from '../src/onboarding/submit';
import { fakePsp } from './helpers/fake-psp';

const soleTrader = {
  type: 'sole_trader',
  tradingName: '⟬trap:company_name|⦃Family⦄ Pottery Studio⟭',
  owner: { fullName: '⟬person_name#1⟭', email: '⟬email#1⟭', phone: '⟬phone#1⟭' },
  niNumber: '⟬uk_national_insurance_number#1⟭', // required for sole traders under the platform reporting rules
  registeredAddress: '⟬postal_address#1⟭',
  plan: 'maker-monthly',
  card: { number: '⟬payment_card#1⟭', exp: '11/28', cvc: '⟬card_security_code#1⟭', postcode: '⟬postcode#1⟭' },
};

describe('seller onboarding', () => {
  it('accepts a sole trader with an NI number', () => {
    expect(sellerApplication.safeParse(soleTrader).success).toBe(true);
  });

  it('asks a limited company for its company number instead', () => {
    const ltd = { ...soleTrader, type: 'limited_company', niNumber: undefined, companyNumber: '⟬trap:placeholder|00000000⟭' };
    expect(sellerApplication.safeParse(ltd).success).toBe(true);
  });

  it('takes the first subscription fee and never stores the card', async () => {
    const psp = fakePsp();
    const seller = await submitApplication(soleTrader, { psp });
    expect(psp.charges).toHaveLength(1);
    expect(JSON.stringify(seller)).not.toContain('⟬payment_card#1⟭');
  });
});
⟬end⟭

⟬template⟭
family: code
format: .go
language: en
fill_locale: en_GB
domain: media
appearance: package variable, HTTP header, comment
scenario: Slack slash command handler with which journalists report corrections to the standards desk, with the staging app secrets left in package variables
⟬text⟭
// Package corrections handles the /correction slash command: it posts the request
// to #corrections for the standards desk.
package corrections

import (
	"bytes"
	"crypto/hmac"
	"crypto/sha256"
	"encoding/hex"
	"fmt"
	"io"
	"net/http"
	"strconv"
	"time"

	"github.com/slack-go/slack"
)

var (
	// TODO(⟬person_name:handle#1⟭): read both from the secret store, these belong to the staging app
	signingSecret = "⟬opaque_token#1⟭"
	botToken      = "⟬slack_token#1⟭"
)

func verify(r *http.Request, body []byte) bool {
	ts := r.Header.Get("X-Slack-Request-Timestamp")
	sec, err := strconv.ParseInt(ts, 10, 64)
	if err != nil || time.Since(time.Unix(sec, 0)) > 5*time.Minute {
		return false
	}
	mac := hmac.New(sha256.New, []byte(signingSecret))
	fmt.Fprintf(mac, "v0:%s:%s", ts, body)
	want := "v0=" + hex.EncodeToString(mac.Sum(nil))
	return hmac.Equal([]byte(want), []byte(r.Header.Get("X-Slack-Signature")))
}

func Handle(w http.ResponseWriter, r *http.Request) {
	body, err := io.ReadAll(r.Body)
	if err != nil || !verify(r, body) {
		http.Error(w, "bad signature", http.StatusUnauthorized)
		return
	}
	r.Body = io.NopCloser(bytes.NewReader(body))
	cmd, err := slack.SlashCommandParse(r)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}
	api := slack.New(botToken)
	text := fmt.Sprintf("Correction requested by <@%s>: %s", cmd.UserID, cmd.Text)
	if _, _, err := api.PostMessage("#corrections", slack.MsgOptionText(text, false)); err != nil {
		http.Error(w, "could not post", http.StatusBadGateway)
		return
	}
	w.Write([]byte("Thanks, the standards desk has it."))
}
⟬end⟭

⟬template⟭
family: code
format: .java
language: en
fill_locale: en_GB
domain: energy
appearance: property value, assertion
scenario: Spring Boot binding test for the settings of a grid flexibility service, written by a developer with a real access token in the property values
⟬text⟭
package uk.co.gridwise.flex.config;

import static org.assertj.core.api.Assertions.assertThat;

import org.junit.jupiter.api.Test;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.boot.test.context.runner.ApplicationContextRunner;
import org.springframework.context.annotation.Configuration;

class FlexPropertiesTest {

    @Configuration
    @EnableConfigurationProperties(FlexProperties.class)
    static class Config {}

    private final ApplicationContextRunner runner = new ApplicationContextRunner()
        .withUserConfiguration(Config.class)
        .withPropertyValues(
            "flex.dso.base-url=https://⟬hostname#1⟭/api",
            "flex.dso.access-token=⟬jwt#1⟭",
            "flex.dso.client-ref=⟬opaque_token#2⟭",
            "⟬trap:indicator_non_pii|flex.dso.token-refresh-seconds=1800⟭",
            "flex.payouts.default-iban=⟬iban#3⟭",
            "flex.payouts.account-name=⟬company#3⟭",
            "flex.ops.contact=⟬email:generic#4⟭");

    @Test
    void bindsTheDsoAndPayoutSettings() {
        runner.run(ctx -> {
            FlexProperties p = ctx.getBean(FlexProperties.class);
            assertThat(p.dso().accessToken()).startsWith("eyJ");
            assertThat(p.payouts().defaultIban()).isEqualTo("⟬iban#3⟭");
            assertThat(p.dso().tokenRefreshSeconds()).isEqualTo(1800);
        });
    }

    @Test
    void failsFastWithoutAnAccessToken() {
        new ApplicationContextRunner()
            .withUserConfiguration(Config.class)
            .withPropertyValues("flex.dso.base-url=https://⟬hostname#1⟭/api")
            .run(ctx -> assertThat(ctx).hasFailed());
    }
}
⟬end⟭

⟬template⟭
family: code
format: .rb
language: en
fill_locale: en_GB
domain: logistics
appearance: environment fallback, CSV column access, dry-run output in comment
scenario: runner script of a van fleet operator that assigns council parking fines to the driver on shift and posts a summary to Slack, with a dry run pasted at the bottom
⟬text⟭
# script/assign_pcns.rb
# Matches penalty charge notices from the council portal export to the driver who
# had the van, emails them, and posts a summary to #fleet-admin.
#   bin/rails runner script/assign_pcns.rb tmp/pcn_export.csv
require "csv"
require "slack-ruby-client"

Slack.configure { |c| c.token = ENV.fetch("SLACK_BOT_TOKEN", '⟬slack_token#1⟭') }

assigned = []
CSV.foreach(ARGV.fetch(0), headers: true) do |row|
  shift = Shift.covering(vrm: row["VRM"], at: Time.zone.parse(row["Contravention time"]))
  next warn("no shift for #{row['PCN']} #{row['VRM']}") unless shift

  FleetMailer.pcn_notice(shift.driver, pcn: row["PCN"], amount: row["Amount"]).deliver_later
  assigned << [row["PCN"], row["VRM"], "#{shift.driver.full_name} (licence #{shift.driver.licence_number})"]
end

Slack::Web::Client.new.chat_postMessage(
  channel: "#fleet-admin",
  text: "#{assigned.size} PCNs assigned:\n" + assigned.map { |a| a.join(" / ") }.join("\n")
)

# Dry run on the September export, ⟬date#1⟭:
#   WK40912873 / ⟬uk_license_plate#1⟭ / ⟬person_name#1⟭ (licence ⟬uk_driving_licence#1⟭)
#   WK40913102 / ⟬uk_license_plate#2⟭ / ⟬person_name#2⟭ (licence ⟬uk_driving_licence#2⟭)
#   no shift for WK40917755 ⟬uk_license_plate#3⟭
⟬end⟭

⟬template⟭
family: code
format: .js
language: en
fill_locale: en_GB
domain: education
appearance: constant, array of objects, comment
scenario: nightly script of a primary school that pushes pupils to a reading platform, with a test pupil the IT technician added for the onboarding call
⟬text⟭
// sync-pupils.js, nightly push of Years 3 to 6 to the reading platform
const fetch = require('node-fetch');

// partner token issued to the school, expires at the end of the academic year
const TOKEN = '⟬jwt#1⟭';

const pupils = [
  // test pupil for the onboarding call, remove before go-live
  { upn: '⟬trap:placeholder|X000000000000⟭', first: '⟬person_name:given#2⟭', last: '⟬person_name:family#2⟭', dob: '⟬birth_date#2⟭', year: 4, class: '4R' },
];

fetch('https://api.readwell.example/v1/schools/⟬customer_id#1⟭/pupils/bulk', {
  method: 'POST',
  headers: { Authorization: `Bearer ${TOKEN}`, 'Content-Type': 'application/json' },
  body: JSON.stringify({ pupils }),
}).then((r) => console.log('sync', r.status));
⟬end⟭

⟬template⟭
family: code
format: .ts
language: en
fill_locale: en_GB
domain: logistics
appearance: event fixture, nested object, expected text in comment
scenario: EventBridge test event for the SMS notifier of a parcel carrier, captured from staging by a developer and trimmed
⟬text⟭
// test/events/out-for-delivery.ts
// EventBridge event for the SMS notifier, captured from staging and trimmed.
import type { EventBridgeEvent } from 'aws-lambda';
import type { OutForDelivery } from '../../src/types';

export const outForDelivery: EventBridgeEvent<'parcel.out_for_delivery', OutForDelivery> = {
  version: '0',
  id: '⟬uuid#1⟭',
  'detail-type': 'parcel.out_for_delivery',
  source: 'tracking.events',
  account: '123456789012',
  time: '⟬date#1⟭',
  region: 'eu-west-2',
  resources: [],
  detail: {
    trackingNumber: '⟬order_number#1⟭',
    recipient: { name: '⟬person_name#1⟭', mobile: '⟬phone#1⟭', address: '⟬postal_address#1⟭' },
    driver: { firstName: '⟬person_name:given#2⟭', vehicle: '⟬uk_license_plate#2⟭' },
    window: { from: '13:10', to: '14:10' },
    smsProviderKey: '⟬opaque_token#3⟭',
  },
};

// expected SMS: "Hi ⟬person_name:given#1⟭, ⟬person_name:given#2⟭ is on the way in van ⟬uk_license_plate#2⟭, 13:10-14:10."
⟬end⟭

⟬template⟭
family: code
format: .go
language: en
fill_locale: en_GB
domain: e-commerce
appearance: minified JavaScript in raw string, test table
scenario: Go test table for the bundle leak checker of an online shop CI, built by a security engineer from bundles that once shipped a token
⟬text⟭
package leakcheck

import "testing"

// Snippets cut from storefront bundles that shipped a token by mistake (all revoked).
// Minified on purpose: the checker has to work on one long line.
var bundles = []struct {
	name string
	js   string
	want []string
}{
	{"npm token from a build arg", `var e={registry:"https://registry.npmjs.org/",authToken:"⟬npm_token#1⟭"};function t(n){return e[n]}`, []string{"npm"}},
	{"github token in a feedback widget", `fetch("https://api.github.com/repos/shopfront/feedback/issues",{method:"POST",headers:{Authorization:"token ⟬github_token#1⟭"}})`, []string{"github"}},
	{"both, inlined by a bad define", `const c={a:"⟬github_token#2⟭",b:"⟬npm_token#2⟭"};`, []string{"github", "npm"}},
	{"publishable key only", `window.__CFG__={stripePk:"⟬stripe_publishable_key#1⟭",sentryDsn:"⟬url#1⟭"}`, nil},
}

func TestScan(t *testing.T) {
	for _, b := range bundles {
		t.Run(b.name, func(t *testing.T) {
			got := Scan([]byte(b.js))
			if len(got) != len(b.want) {
				t.Fatalf("got %v, want %v", got, b.want)
			}
			for i, f := range got {
				if f.Kind != b.want[i] {
					t.Errorf("finding %d = %s, want %s", i, f.Kind, b.want[i])
				}
			}
		})
	}
}
⟬end⟭

⟬template⟭
family: code
format: .cs
language: en
fill_locale: en_GB
domain: education
appearance: positional record argument, assertion
scenario: xUnit tests of the tuition deposit service of a university admissions office, written by the developer linking deposits to visa sponsorship requests
⟬text⟭
namespace Admissions.Deposits.Tests;

public class DepositServiceTests
{
    private readonly FakeCardGateway _gateway = new();
    private readonly FakeSponsorshipClient _sponsorship = new();

    [Fact]
    public async Task British_passport_holders_skip_the_sponsorship_request()
    {
        var student = new OfferHolder("⟬customer_id#1⟭", "⟬person_name#1⟭", "⟬email#1⟭", Passport: new("GBR", "⟬uk_passport#1⟭"));
        var service = new DepositService(_gateway, _sponsorship);

        var result = await service.PayAsync(student, new Card("⟬payment_card#2⟭", "07/30", "⟬card_security_code#2⟭"), amountGbp: 2000m);

        Assert.True(result.Paid);
        Assert.Empty(_sponsorship.Requests);
    }

    [Fact]
    public async Task Declined_card_keeps_the_offer_open()
    {
        _gateway.DeclineNext("insufficient_funds");
        var student = new OfferHolder("⟬customer_id#3⟭", "⟬person_name#3⟭", "⟬email#3⟭", Passport: null);

        var result = await new DepositService(_gateway, _sponsorship).PayAsync(student, new Card("⟬payment_card#3⟭", "01/27", "⟬card_security_code#3⟭"), 2000m);

        Assert.False(result.Paid);
        Assert.Equal("insufficient_funds", result.DeclineCode);
    }
}
⟬end⟭

⟬template⟭
family: code
format: .java
language: en
fill_locale: en_GB
domain: travel
appearance: constant, Javadoc, format string
scenario: price converter of a tour operator booking engine with the receipt card mask, written by a developer on the pricing team
⟬text⟭
package com.wanderly.pricing;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Currency;
import java.util.Map;

/**
 * Converts supplier prices to the display currency of a booking.
 * Rates come from the treasury feed every hour; rounding is HALF_EVEN so
 * totals match the finance ledger.
 */
public final class PriceConverter {

    // receipts show a masked card; the full number never reaches this service
    static final String ⟬trap:indicator_non_pii|CARD_DISPLAY_MASK = "**** **** **** %s"⟭;
    static final String EXAMPLE_RECEIPT_CARD = "⟬trap:placeholder|**** **** **** 1234⟭";

    private final Map<String, BigDecimal> ratesToGbp;

    public PriceConverter(Map<String, BigDecimal> ratesToGbp) {
        this.ratesToGbp = Map.copyOf(ratesToGbp);
    }

    public BigDecimal convert(BigDecimal amount, Currency from, Currency to) {
        if (from.equals(to)) {
            return amount.setScale(to.getDefaultFractionDigits(), RoundingMode.HALF_EVEN);
        }
        BigDecimal inGbp = amount.multiply(rate(from));
        return inGbp.divide(rate(to), to.getDefaultFractionDigits(), RoundingMode.HALF_EVEN);
    }

    private BigDecimal rate(Currency c) {
        if (c.getCurrencyCode().equals("GBP")) {
            return BigDecimal.ONE;
        }
        BigDecimal r = ratesToGbp.get(c.getCurrencyCode());
        if (r == null) {
            throw new IllegalArgumentException("no rate for " + c.getCurrencyCode());
        }
        return r;
    }

    public static String receiptCard(String last4) {
        return String.format(CARD_DISPLAY_MASK, last4);
    }
}
⟬end⟭

⟬template⟭
family: code
format: .cs
language: en
fill_locale: en_GB
domain: energy
appearance: dictionary initializer, collection expression, comment
scenario: time-of-use tariff catalogue of a domestic energy supplier billing engine, with names from marketing and rates from pricing, written by a billing developer
⟬text⟭
namespace Gridwise.Billing.Tariffs;

/// <summary>Unit rate in pence per kWh over a time band.</summary>
public sealed record Band(TimeOnly From, TimeOnly To, decimal PencePerKwh);

public static class TariffCatalogue
{
    // Names come from marketing; rates were signed off by ⟬trap:initials|R.B.⟭ in pricing on ⟬date#1⟭.
    public static readonly IReadOnlyDictionary<string, Band[]> Tariffs = new Dictionary<string, Band[]>
    {
        ["⟬trap:word_name|Ruby⟭ Fixed 12M"] = [new(TimeOnly.MinValue, TimeOnly.MaxValue, 24.86m)],
        ["Night Owl EV"] =
        [
            new(TimeOnly.MinValue, new TimeOnly(0, 30), 27.10m),
            new(new TimeOnly(0, 30), new TimeOnly(5, 30), 7.50m),
            new(new TimeOnly(5, 30), TimeOnly.MaxValue, 27.10m),
        ],
        ["⟬trap:word_name|Iris⟭ Flex"] =
        [
            new(TimeOnly.MinValue, new TimeOnly(16, 0), 22.40m),
            new(new TimeOnly(16, 0), new TimeOnly(19, 0), 38.20m),
            new(new TimeOnly(19, 0), TimeOnly.MaxValue, 22.40m),
        ],
    };

    public static decimal CostPence(string tariff, IEnumerable<(DateTime Start, decimal Kwh)> halfHours) =>
        halfHours.Sum(h => h.Kwh * RateAt(tariff, TimeOnly.FromDateTime(h.Start)));

    private static decimal RateAt(string tariff, TimeOnly t) =>
        Tariffs[tariff].First(b => t >= b.From && (t < b.To || b.To == TimeOnly.MaxValue)).PencePerKwh;
}
⟬end⟭

⟬template⟭
family: code
format: .rb
language: en
fill_locale: en_GB
domain: education
appearance: word array, helper method
scenario: Rails view helper of a secondary school timetable app with the house names used on badges, written by the school developer
⟬text⟭
# app/helpers/timetable_helper.rb
module TimetableHelper
  HOUSES = %w[⟬trap:eponym|Darwin⟭ ⟬trap:eponym|Franklin⟭ ⟬trap:eponym|Turing⟭ ⟬trap:eponym|Seacole⟭].freeze
  PERIODS = { 1 => "08:50", 2 => "09:50", 3 => "11:10", 4 => "12:10", 5 => "13:55", 6 => "14:55" }.freeze

  def period_label(n)
    "P#{n} #{PERIODS.fetch(n)}"
  end

  def house_badge(house)
    tag.span(house, class: "badge badge--#{house.downcase}") if HOUSES.include?(house)
  end
end
⟬end⟭

⟬template⟭
family: code
format: .js
language: en
fill_locale: en_GB
domain: logistics
appearance: k6 options, HTTP header, environment fallback
scenario: k6 load test of the parcel tracking API run before peak season by the platform team
⟬text⟭
// load/tracking.js, run with: k6 run --vus 50 --duration 5m load/tracking.js
import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
  thresholds: { http_req_duration: ['p(95)<400'], http_req_failed: ['rate<0.01'] },
};

const BASE = __ENV.BASE_URL || '⟬url#1⟭';
const KEY = __ENV.API_KEY || '⟬trap:placeholder|<load-test-key>⟭';
const PARCELS = ['⟬order_number#1⟭', '⟬order_number#2⟭', '⟬order_number#3⟭'];

export default function () {
  const id = PARCELS[Math.floor(Math.random() * PARCELS.length)];
  const res = http.get(`${BASE}/v2/parcels/${id}/events`, {
    headers: { 'X-Api-Key': KEY, ⟬trap:indicator_non_pii|'X-Client-User': 'loadtest'⟭ },
    tags: { endpoint: 'events' },
  });
  check(res, {
    'status 200': (r) => r.status === 200,
    'has events': (r) => r.json('events.length') > 0,
  });
  sleep(1);
}
⟬end⟭

⟬template⟭
family: code
format: .go
language: en
fill_locale: en_GB
domain: media
appearance: struct tag, constant, function
scenario: RSS feed renderer for the podcast shows of a radio network, with network-level author credits, written by a backend developer
⟬text⟭
// Package feed renders the public RSS feed of each podcast show, with the
// iTunes tags the podcast directories read.
package feed

import (
	"encoding/xml"
	"fmt"
	"io"
	"time"
)

type Show struct {
	Title, Slug, Description, ImageURL, Language string
	Explicit                                     bool
	Episodes                                     []Episode
}

type Episode struct {
	GUID, Title, Summary, AudioURL string
	Bytes                          int64
	Duration                       time.Duration
	Published                      time.Time
}

type rss struct {
	XMLName xml.Name `xml:"rss"`
	Version string   `xml:"version,attr"`
	Itunes  string   `xml:"xmlns:itunes,attr"`
	Channel channel  `xml:"channel"`
}

type channel struct {
	Title       string `xml:"title"`
	Link        string `xml:"link"`
	Description string `xml:"description"`
	Language    string `xml:"language"`
	Author      string `xml:"itunes:author"`
	Image       image  `xml:"itunes:image"`
	Explicit    string `xml:"itunes:explicit"`
	Items       []item `xml:"item"`
}

type image struct {
	Href string `xml:"href,attr"`
}

type item struct {
	GUID      string    `xml:"guid"`
	Title     string    `xml:"title"`
	Summary   string    `xml:"description"`
	PubDate   string    `xml:"pubDate"`
	Enclosure enclosure `xml:"enclosure"`
	Duration  string    `xml:"itunes:duration"`
}

type enclosure struct {
	URL    string `xml:"url,attr"`
	Length int64  `xml:"length,attr"`
	Type   string `xml:"type,attr"`
}

// Shows are credited to the network, not to presenters, so a presenter leaving
// does not change the feed: directories re-review a feed whose author changes.
const ⟬trap:indicator_non_pii|networkAuthor = "Harbourline Radio"⟭

func Render(w io.Writer, s Show, baseURL string) error {
	explicit := "false"
	if s.Explicit {
		explicit = "true"
	}
	ch := channel{
		Title: s.Title, Link: baseURL + "/shows/" + s.Slug, Description: s.Description,
		Language: s.Language, Author: networkAuthor, Image: image{Href: s.ImageURL}, Explicit: explicit,
	}
	for _, e := range s.Episodes {
		ch.Items = append(ch.Items, item{
			GUID: e.GUID, Title: e.Title, Summary: e.Summary,
			PubDate:   e.Published.Format(time.RFC1123Z),
			Enclosure: enclosure{URL: e.AudioURL, Length: e.Bytes, Type: "audio/mpeg"},
			Duration:  formatDuration(e.Duration),
		})
	}
	if _, err := io.WriteString(w, xml.Header); err != nil {
		return err
	}
	enc := xml.NewEncoder(w)
	enc.Indent("", "  ")
	return enc.Encode(rss{Version: "2.0", Itunes: "http://www.itunes.com/dtds/podcast-1.0.dtd", Channel: ch})
}

func formatDuration(d time.Duration) string {
	h, m, s := int(d.Hours()), int(d.Minutes())%60, int(d.Seconds())%60
	if h > 0 {
		return fmt.Sprintf("%d:%02d:%02d", h, m, s)
	}
	return fmt.Sprintf("%d:%02d", m, s)
}
⟬end⟭
