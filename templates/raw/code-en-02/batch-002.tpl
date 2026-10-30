⟬template⟭
family: code
format: .rb
language: en
fill_locale: en_GB
domain: logistics
appearance: mailer preview, keyword argument, string literal
scenario: Rails mailer preview of the induction pack sent to new contract drivers of a same-day courier, written by the developer building the onboarding emails
⟬text⟭
# Preview at http://localhost:3000/rails/mailers/driver_induction_mailer
class DriverInductionMailerPreview < ActionMailer::Preview
  def welcome_pack
    driver = Driver.new(
      first_name: "⟬person_name:given#1⟭",
      last_name: "⟬person_name:family#1⟭",
      email: "⟬email#1⟭",
      licence_number: "⟬uk_driving_licence#1⟭",
      start_date: Date.parse("⟬date#1⟭")
    )
    van = Van.new(registration: "⟬uk_license_plate#1⟭", make: "Ford", model: "Transit Custom")
    depot = Depot.new(name: "⟬city#2⟭ North", address: "⟬postal_address#2⟭", gate_code: "⟬trap:placeholder|****⟭")
    buddy = Driver.new(first_name: "⟬person_name:given#3⟭", mobile: "⟬phone#3⟭")
    DriverInductionMailer.with(driver: driver, van: van, depot: depot, buddy: buddy).welcome_pack
  end

  def licence_check_failed
    driver = Driver.new(first_name: "⟬person_name:given#4⟭", email: "⟬email#4⟭", licence_number: "⟬uk_driving_licence#4⟭")
    DriverInductionMailer.with(driver: driver, reason: "endorsement IN10").licence_check_failed
  end
end
⟬end⟭

⟬template⟭
family: code
format: .java
language: en
fill_locale: en_GB
domain: e-commerce
appearance: exception message, comment
scenario: exception class of a grocery checkout whose old message carried the card number, with the Sentry event kept in a comment by the developer who fixed it
⟬text⟭
package com.basketly.checkout.payments;

// The message used to carry the PAN; Sentry still holds events like this one (⟬ticket_id#1⟭):
// CardDeclinedException: card ⟬payment_card#1⟭ cvc ⟬card_security_code#1⟭ declined for ⟬email#1⟭: DO_NOT_HONOUR
public class CardDeclinedException extends RuntimeException {
    private final String reasonCode;

    public CardDeclinedException(String last4, String reasonCode) {
        super("card ending " + last4 + " declined: " + reasonCode);
        this.reasonCode = reasonCode;
    }

    public String reasonCode() {
        return reasonCode;
    }
}
⟬end⟭

⟬template⟭
family: code
format: .ts
language: en
fill_locale: en_GB
domain: education
appearance: seed script, nested create, string literal, comment
scenario: Prisma seed of a university admissions portal with a mature applicant and a second applicant who uploaded a passport, written by a developer on the student systems team
⟬text⟭
// prisma/seed.ts, run with `npx prisma db seed`
import { ApplicationStatus, PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function main() {
  await prisma.application.deleteMany();
  await prisma.applicant.deleteMany();

  const mature = await prisma.applicant.create({
    data: {
      givenName: '⟬person_name:given#1⟭',
      familyName: '⟬person_name:family#1⟭',
      dateOfBirth: new Date('⟬birth_date#1⟭'),
      email: '⟬email#1⟭',
      phone: '⟬phone#1⟭',
      homeAddress: '⟬postal_address#1⟭',
      niNumber: '⟬uk_national_insurance_number#1⟭', // matched against Student Finance records
      feeStatus: 'HOME',
      applications: {
        create: [
          { course: 'BSc Nursing (Adult)', status: ApplicationStatus.OFFER_CONDITIONAL, submittedAt: new Date('⟬date#3⟭') },
          { course: 'BSc Paramedic Science', status: ApplicationStatus.REJECTED, submittedAt: new Date('⟬date#3⟭') },
        ],
      },
    },
  });

  const second = await prisma.applicant.create({
    data: {
      givenName: '⟬person_name:given#2⟭',
      familyName: '⟬person_name:family#2⟭',
      dateOfBirth: new Date('⟬birth_date#2⟭'),
      email: '⟬email#2⟭',
      feeStatus: 'HOME',
      idDocument: { create: { kind: 'PASSPORT', number: '⟬uk_passport#2⟭', expires: new Date('⟬date#1⟭') } },
      applications: { create: [{ course: 'MA Journalism', status: ApplicationStatus.SUBMITTED, submittedAt: new Date('⟬date#2⟭') }] },
    },
  });

  await prisma.staffUser.upsert({
    where: { email: '⟬email:generic#4⟭' },
    update: {},
    create: { email: '⟬email:generic#4⟭', ⟬trap:indicator_non_pii|name: 'Admissions Office'⟭, passwordHash: '⟬hash#1⟭' },
  });

  console.log(`seeded applicants ${mature.id} and ${second.id}`);
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(() => prisma.$disconnect());
⟬end⟭

⟬template⟭
family: code
format: .js
language: en
fill_locale: en_GB
domain: energy
appearance: test fixture, object literal
scenario: shared request bodies for the refund route tests of an EV charging app, written by a developer who needed one card refund and one bank transfer
⟬text⟭
// test/fixtures/refunds.js, shared by refunds.test.js and refunds.contract.test.js
module.exports = {
  cardRefund: { reason: 'charger_fault', kwhDelivered: 3.4, card: { number: '⟬payment_card#1⟭', cvc: '⟬card_security_code#1⟭', expiry: '08/28' } },
  transferRefund: { reason: 'overcharge', payout: { accountHolder: '⟬person_name#2⟭', iban: '⟬iban#2⟭' } },
  operatorKey: '⟬opaque_token#1⟭',
  sessionIds: ['⟬uuid#1⟭', '⟬uuid#2⟭'],
};
⟬end⟭

⟬template⟭
family: code
format: .cs
language: en
fill_locale: en_GB
domain: logistics
appearance: XML doc comment, CLI command, constant, HTTP header
scenario: background service of a parcel depot that posts sorter jams to Slack, with the bot token in a constant and a GitHub Packages token in a restore command left in the doc comment
⟬text⟭
using System.Net.Http.Headers;
using System.Net.Http.Json;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;

namespace Depot.Alerts;

/// <summary>
/// Polls the sorter PLC gateway and posts jams longer than two minutes to Slack.
/// </summary>
/// <remarks>
/// Depot.Plc comes from the private feed on GitHub Packages. Until the build agents get
/// the shared credentials, restore with:
/// <c>dotnet nuget add source https://nuget.pkg.github.com/depot-systems/index.json -n depot -u ci -p ⟬github_token#1⟭</c>
/// </remarks>
public sealed class SorterJamNotifier : BackgroundService
{
    private const string SlackToken = "⟬slack_token#1⟭";
    private const string Channel = "C04DEPOTOPS";
    private static readonly TimeSpan Threshold = TimeSpan.FromMinutes(2);

    private readonly ISorterGateway _gateway;
    private readonly HttpClient _http;
    private readonly ILogger<SorterJamNotifier> _log;

    public SorterJamNotifier(ISorterGateway gateway, HttpClient http, ILogger<SorterJamNotifier> log)
    {
        _gateway = gateway;
        _http = http;
        _log = log;
        _http.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", SlackToken);
    }

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        while (!stoppingToken.IsCancellationRequested)
        {
            foreach (var jam in await _gateway.ActiveJamsAsync(stoppingToken))
            {
                if (jam.Duration < Threshold || jam.Notified) continue;
                var text = $":rotating_light: Sorter {jam.LineId} jammed for {jam.Duration.TotalMinutes:F0} min at chute {jam.Chute}";
                var response = await _http.PostAsJsonAsync("https://slack.com/api/chat.postMessage", new { channel = Channel, text }, stoppingToken);
                _log.LogInformation("Slack post for {Line}: {Status}", jam.LineId, response.StatusCode);
                await _gateway.MarkNotifiedAsync(jam.Id, stoppingToken);
            }
            await Task.Delay(TimeSpan.FromSeconds(15), stoppingToken);
        }
    }
}
⟬end⟭

⟬template⟭
family: code
format: .rb
language: en
fill_locale: en_GB
domain: travel
appearance: request spec, HTTP header, nested hash, comment
scenario: RSpec request spec of a tour operator API that records passport and car hire driver details, with a long-lived agent token a developer generated for the suite
⟬text⟭
require "rails_helper"

RSpec.describe "PATCH /api/v1/bookings/:ref/travellers", type: :request do
  # Agent portal test user, exp ten years out. Regenerate with
  # bin/rails runner 'puts AgentToken.issue(agent_id: 42, ttl: 10.years)'
  let(:token) { "⟬jwt#1⟭" }
  let(:headers) { { "Authorization" => "Bearer #{token}", "Accept" => "application/json" } }
  let!(:booking) { create(:booking, reference: "⟬order_number#1⟭", departs_on: Date.parse("⟬date#2⟭")) }

  let(:lead) do
    {
      title: "Mr",
      given_names: "⟬person_name:given#1m⟭",
      surname: "⟬person_name:family#1⟭",
      date_of_birth: "⟬birth_date#1⟭",
      passport: { number: "⟬uk_passport#1⟭", issuing_country: "GBR", expires_on: "⟬date#1⟭" },
      car_hire_driver: { licence_number: "⟬uk_driving_licence#1⟭", licence_country: "GB" }
    }
  end

  it "stores the advance passenger data and the hire driver" do
    patch "/api/v1/bookings/#{booking.reference}/travellers", params: { travellers: [lead] }, headers: headers, as: :json

    expect(response).to have_http_status(:ok)
    traveller = booking.reload.travellers.first
    expect(traveller.passport_number).to eq("⟬uk_passport#1⟭")
    expect(traveller.driver_licence_number).to eq("⟬uk_driving_licence#1⟭")
  end

  it "rejects a call without the agent token" do
    patch "/api/v1/bookings/#{booking.reference}/travellers", params: { travellers: [lead] }, as: :json

    expect(response).to have_http_status(:unauthorized)
    expect(booking.reload.travellers).to be_empty
  end
end
⟬end⟭

⟬template⟭
family: code
format: .java
language: en
fill_locale: en_GB
domain: education
appearance: constructor argument, expected CSV line, assertion
scenario: JUnit test of the monthly payroll export for supply teachers of a multi-academy trust, written by the developer who added overseas payments
⟬text⟭
package org.oakfieldtrust.payroll.export;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

import java.math.BigDecimal;
import java.time.YearMonth;
import java.util.List;
import org.junit.jupiter.api.Test;

class SupplyStaffPayrollCsvTest {

    private static final YearMonth SEPTEMBER = YearMonth.of(2026, 9);
    private final PayrollCsvWriter writer = new PayrollCsvWriter();

    @Test
    void writesOneLinePerClaimWithBankDetails() {
        List<Claim> claims = List.of(
            new Claim("⟬person_name#1⟭", "⟬uk_national_insurance_number#1⟭", "20-45-77", "⟬bank_account_number#1⟭", new BigDecimal("1260.00")),
            new Claim("⟬person_name#2⟭", "⟬uk_national_insurance_number#2⟭", "40-11-62", "⟬bank_account_number#2⟭", new BigDecimal("315.50")));

        String csv = writer.write(SEPTEMBER, claims);

        assertThat(csv.lines()).containsExactly(
            "period,name,ni_number,sort_code,account_number,gross",
            "2026-09,⟬person_name#1⟭,⟬uk_national_insurance_number#1⟭,20-45-77,⟬bank_account_number#1⟭,1260.00",
            "2026-09,⟬person_name#2⟭,⟬uk_national_insurance_number#2⟭,40-11-62,⟬bank_account_number#2⟭,315.50");
    }

    @Test
    void overseasTeacherIsPaidByIbanAndFlaggedForTheManualRun() {
        Claim claim = Claim.overseas("⟬person_name#3⟭", "⟬uk_national_insurance_number#3⟭", "⟬iban#3⟭", new BigDecimal("640.00"));

        String csv = writer.write(SEPTEMBER, List.of(claim));

        assertThat(csv).contains("⟬iban#3⟭").endsWith(",MANUAL\n");
    }

    @Test
    void refusesAClaimWithoutNiNumber() {
        Claim claim = new Claim("⟬person_name#4⟭", null, "30-90-12", "⟬bank_account_number#4⟭", BigDecimal.TEN);

        assertThatThrownBy(() -> writer.write(SEPTEMBER, List.of(claim)))
            .isInstanceOf(MissingNiNumberException.class)
            .hasMessageContaining("⟬person_name#4⟭");
    }
}
⟬end⟭

⟬template⟭
family: code
format: .go
language: en
fill_locale: en_GB
domain: e-commerce
appearance: headerless CSV in string, test case
scenario: Go test of the timesheet importer for agency workers at an online retailer's fulfilment centres, with lines pasted from the agency SFTP drop
⟬text⟭
package timesheets

import (
	"strings"
	"testing"
)

// Exactly as it lands on the SFTP drop: CRLF, trailing comma, one line per
// shift, two lines for a double shift.
var agencyExport = strings.Join([]string{
	"⟬person_name#1⟭,⟬uk_national_insurance_number#1⟭,⟬phone#1⟭,20-32-06,⟬bank_account_number#1⟭,⟬date#3⟭,9.5,BHX2,",
	"⟬person_name#1⟭,⟬uk_national_insurance_number#1⟭,⟬phone#1⟭,20-32-06,⟬bank_account_number#1⟭,⟬date#2⟭,4.0,BHX2,",
	"⟬person_name#2⟭,⟬uk_national_insurance_number#2⟭,⟬phone#2⟭,60-83-71,⟬bank_account_number#2⟭,⟬date#2⟭,10,BHX2,",
	"⟬person_name#3⟭,,⟬phone#3⟭,30-99-50,⟬bank_account_number#3⟭,⟬date#1⟭,8,EMA1,",
}, "\r\n")

func TestParse(t *testing.T) {
	shifts, rejects, err := Parse(strings.NewReader(agencyExport))
	if err != nil {
		t.Fatal(err)
	}
	if len(shifts) != 3 {
		t.Fatalf("got %d shifts, want 3", len(shifts))
	}
	if len(rejects) != 1 || rejects[0].Reason != ReasonMissingNI {
		t.Fatalf("rejects = %+v", rejects)
	}
	if got := shifts[0].Hours + shifts[1].Hours; got != 13.5 {
		t.Errorf("double shift hours = %v, want 13.5", got)
	}
}

func TestParseRejectsHoursOverLimit(t *testing.T) {
	line := "⟬person_name#4⟭,⟬uk_national_insurance_number#4⟭,⟬phone#4⟭,20-32-06,⟬bank_account_number#4⟭,⟬date#1⟭,19,BHX2,"
	_, rejects, _ := Parse(strings.NewReader(line))
	if len(rejects) != 1 || rejects[0].Reason != ReasonHours {
		t.Fatalf("rejects = %+v", rejects)
	}
}
⟬end⟭

⟬template⟭
family: code
format: .ts
language: en
fill_locale: en_GB
domain: media
appearance: action input, mocked return value, environment variable, HTTP header
scenario: Jest test of a custom GitHub Action that announces preview deployments of a radio web player, written by a frontend engineer with real-looking inputs inlined
⟬text⟭
// __tests__/main.test.ts
import * as core from '@actions/core';
import * as github from '@actions/github';
import nock from 'nock';
import { run } from '../src/main';

jest.mock('@actions/core');

const inputs: Record<string, string> = {
  'github-token': '⟬github_token#1⟭',
  'slack-bot-token': '⟬slack_token#1⟭',
  'slack-channel': 'C02PREVIEWS',
  environment: 'preview',
};

describe('deploy-notify', () => {
  beforeEach(() => {
    (core.getInput as jest.Mock).mockImplementation((name: string) => inputs[name] ?? '');
    // id token GitHub hands the job for the OIDC exchange with the CDN
    (core.getIDToken as jest.Mock).mockResolvedValue('⟬jwt#1⟭');
    // the action also publishes a canary build of the player package
    process.env.NPM_TOKEN = '⟬npm_token#1⟭';
    github.context.payload = { pull_request: { number: 812, head: { sha: '⟬git_sha#1⟭' } } };
  });

  afterEach(() => nock.cleanAll());

  it('comments the preview URL and posts to Slack', async () => {
    const gh = nock('https://api.github.com')
      .post('/repos/signal-studio/web-player/issues/812/comments', (b) => b.body.includes('https://preview-812.'))
      .reply(201, { id: 1 });
    const slack = nock('https://slack.com')
      .post('/api/chat.postMessage')
      .matchHeader('authorization', 'Bearer ⟬slack_token#1⟭')
      .reply(200, { ok: true });

    await run();

    expect(core.setFailed).not.toHaveBeenCalled();
    expect(gh.isDone() && slack.isDone()).toBe(true);
  });

  it('fails when the OIDC exchange is refused', async () => {
    nock('https://cdn-auth.signal.example').post('/token').reply(403);

    await run();

    expect(core.setFailed).toHaveBeenCalledWith(expect.stringContaining('OIDC'));
  });
});
⟬end⟭

⟬template⟭
family: code
format: .js
language: en
fill_locale: en_GB
domain: media
appearance: environment fallback, set literal, sample output in comment
scenario: access review script that lists who can publish the npm packages of a broadcaster and flags leavers, written by a platform engineer for the quarterly audit
⟬text⟭
#!/usr/bin/env node
/**
 * Lists who can publish each package of our npm scope and flags maintainers who
 * left or are not in the release team. Output goes into the quarterly access review.
 *
 *   NPM_TOKEN=... GITHUB_TOKEN=... node tools/npm-owner-audit.js
 */
'use strict';

const fetch = require('node-fetch');

const NPM_TOKEN = process.env.NPM_TOKEN || '⟬npm_token#1⟭'; // read-only automation token
const GITHUB_TOKEN = process.env.GITHUB_TOKEN || '⟬github_token#1⟭';
const SCOPE = '⟬trap:email_lookalike|@signalfm⟭';

// leavers from the HR export of ⟬date#1⟭, by npm user
const LEAVERS = new Set(['⟬person_name:handle#2⟭', '⟬person_name:handle#3⟭']);

async function npm(path) {
  const res = await fetch(`https://registry.npmjs.org${path}`, { headers: { authorization: `Bearer ${NPM_TOKEN}` } });
  if (!res.ok) throw new Error(`${path}: ${res.status}`);
  return res.json();
}

async function releaseTeam() {
  const res = await fetch('https://api.github.com/orgs/signalfm/teams/release/members?per_page=100', {
    headers: { authorization: `token ${GITHUB_TOKEN}`, accept: 'application/vnd.github+json' },
  });
  return new Set((await res.json()).map((m) => m.login));
}

async function main() {
  const { objects } = await npm(`/-/v1/search?text=scope:${SCOPE.slice(1)}&size=250`);
  const team = await releaseTeam();
  for (const { package: pkg } of objects) {
    const doc = await npm(`/${encodeURIComponent(pkg.name)}`);
    for (const m of doc.maintainers) {
      const flag = LEAVERS.has(m.name) ? 'LEAVER' : team.has(m.name) ? '' : 'NOT_IN_TEAM';
      console.log([pkg.name, m.name, m.email, flag].join('  '));
    }
  }
}

main().catch((e) => {
  console.error(e);
  process.exit(1);
});

// last run:
// @signalfm/player-core  ⟬person_name:handle#2⟭  ⟬email#2⟭  LEAVER
// @signalfm/player-core  ⟬username#1⟭  ⟬email:generic#4⟭
// @signalfm/analytics  ⟬person_name:handle#5⟭  ⟬email#5⟭  NOT_IN_TEAM
⟬end⟭

⟬template⟭
family: code
format: .cs
language: en
fill_locale: en_GB
domain: travel
appearance: object initializer, assertion, string literal
scenario: NUnit test of the booking confirmation email of a hotel group, with a sample reservation a developer filled in for the car park and card-on-file checks
⟬text⟭
using Hotels.Notifications;
using NUnit.Framework;

[TestFixture]
public class ConfirmationEmailTests
{
    private static Reservation Sample() => new()
    {
        Reference = "⟬order_number#1⟭",
        Guest = new Guest
        {
            Title = "Ms",
            FullName = "⟬person_name#1f⟭",
            Email = "⟬email#1⟭",
            Mobile = "⟬phone#1⟭",
            PassportNumber = "⟬uk_passport#1⟭",
        },
        ArrivalDate = DateOnly.Parse("⟬date#2⟭"),
        Nights = 3,
        ParkingPlate = "⟬uk_license_plate#1⟭",
        Card = new CardOnFile("⟬payment_card#1⟭", "⟬card_security_code#1⟭", "05/29"),
        Property = new Property("⟬company#2⟭", "⟬postal_address#2⟭", "⟬phone#2⟭"),
    };

    [Test]
    public void Body_masks_the_card_and_leaves_out_the_passport()
    {
        var html = ConfirmationEmail.Render(Sample());

        Assert.That(html, Does.Contain("Dear Ms ⟬person_name:family#1⟭"));
        Assert.That(html, Does.Not.Contain("⟬payment_card#1⟭"));
        Assert.That(html, Does.Not.Contain("⟬uk_passport#1⟭"));
        Assert.That(html, Does.Contain("Car park: ⟬uk_license_plate#1⟭"));
    }

    [Test]
    public void Subject_carries_the_reference_only()
    {
        Assert.That(ConfirmationEmail.Subject(Sample()), Is.EqualTo("Your stay is confirmed (⟬order_number#1⟭)"));
    }
}
⟬end⟭

⟬template⟭
family: code
format: .java
language: en
fill_locale: en_GB
domain: logistics
appearance: Javadoc sample record, property default, log line
scenario: Kafka consumer of a van fleet operator that alerts the fleet desk about harsh driving, with a vendor sandbox record in the Javadoc and a Slack token as a property default
⟬text⟭
package io.roadgrid.telematics;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.slack.api.Slack;
import com.slack.api.methods.MethodsClient;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Component;

/**
 * Consumes harsh-driving events from {@code telematics.events.v3} and alerts the
 * fleet desk when a driver reaches three events in one shift.
 *
 * <p>Sample record value from the vendor sandbox, kept for the parser test:
 * <pre>{@code
 * {"vehicle":{"vrm":"⟬uk_license_plate#1⟭","unit":"TX-88412"},
 *  "driver":{"name":"⟬person_name#1⟭","licence":"⟬uk_driving_licence#1⟭"},
 *  "event":"HARSH_BRAKE","g":0.52,"day":"⟬date#1⟭","lat":52.4862,"lon":-1.8904}
 * }</pre>
 */
@Component
public class HarshDrivingConsumer {

    private static final Logger log = LoggerFactory.getLogger(HarshDrivingConsumer.class);
    private static final int THRESHOLD = 3;

    private final ObjectMapper mapper;
    private final ShiftCounter counter;
    private final MethodsClient slack;

    public HarshDrivingConsumer(ObjectMapper mapper, ShiftCounter counter,
                                @Value("${fleet.slack.token:⟬slack_token#2⟭}") String slackToken) {
        this.mapper = mapper;
        this.counter = counter;
        this.slack = Slack.getInstance().methods(slackToken);
    }

    @KafkaListener(topics = "telematics.events.v3", groupId = "fleet-desk")
    public void onEvent(String value) throws Exception {
        JsonNode node = mapper.readTree(value);
        String vrm = node.at("/vehicle/vrm").asText();
        String licence = node.at("/driver/licence").asText();
        int count = counter.increment(licence, node.at("/event").asText());
        if (count < THRESHOLD) {
            return;
        }
        String text = String.format("%s: %d harsh events this shift (driver %s, licence ending %s)",
            vrm, count, node.at("/driver/name").asText(), licence.substring(licence.length() - 4));
        slack.chatPostMessage(r -> r.channel("#fleet-desk").text(text));
        log.warn("threshold reached vrm={} count={}", vrm, count);
    }
}
⟬end⟭

⟬template⟭
family: code
format: .rb
language: en
fill_locale: en_GB
domain: energy
appearance: console session in comment, constant, model
scenario: Rails model for the priority services register of an energy supplier, with a console session pasted in the header by the developer chasing duplicate registrations
⟬text⟭
# app/models/priority_services_registration.rb
#
# Customers on the Priority Services Register get notice of planned outages and
# a password scheme for doorstep visits. Age eligibility is computed from
# date_of_birth, never stored as a flag.
#
# Chasing the duplicate registrations (⟬ticket_id#1⟭):
#
#   irb> PriorityServicesRegistration.where(account_number: "⟬customer_id#1⟭").pluck(:full_name, :date_of_birth, :phone)
#   => [["⟬person_name#1⟭", "⟬birth_date#1⟭", "⟬phone#1⟭"], ["⟬person_name#1⟭", "⟬birth_date#1⟭", "⟬phone#1⟭"]]
#   irb> PriorityServicesRegistration.last.refund_iban
#   => "⟬iban#1⟭"
#
class PriorityServicesRegistration < ApplicationRecord
  NEEDS = %w[medical_equipment visual_impairment hearing_impairment pensionable_age young_children].freeze
  ⟬trap:indicator_non_pii|DOORSTEP_PASSWORD_LENGTH = 6⟭

  belongs_to :account
  encrypts :date_of_birth, :phone, :doorstep_password
  encrypts :refund_iban

  validates :needs, presence: true
  validate :needs_are_known

  def pensionable_age?
    date_of_birth.present? && date_of_birth <= 66.years.ago.to_date
  end

  # Customers who moved abroad get refunds by bank transfer, see RefundRun.
  def refund_by_transfer?
    refund_iban.present? && !refund_iban.start_with?("GB")
  end

  private

  def needs_are_known
    unknown = Array(needs) - NEEDS
    errors.add(:needs, "unknown: #{unknown.join(', ')}") if unknown.any?
  end
end
⟬end⟭

⟬template⟭
family: code
format: .go
language: en
fill_locale: en_GB
domain: education
appearance: constant, struct literal, form value, comment
scenario: Go test of the LTI 1.3 launch handler of a maths homework tool, with an id token captured from the learning platform sandbox and re-signed for offline runs
⟬text⟭
package lti

import (
	"net/http"
	"net/http/httptest"
	"net/url"
	"strings"
	"testing"
	"time"
)

// Captured from the platform sandbox launch on ⟬date#1⟭ and re-signed with
// testdata/platform_key.pem so the signature check passes offline.
const idToken = "⟬jwt#1⟭"

func TestLaunchCreatesLearnerSession(t *testing.T) {
	tool := NewTool(Config{
		ClientID:  "⟬uuid#1⟭",
		Issuer:    "https://⟬hostname#1⟭",
		JWKSPath:  "testdata/platform_jwks.json",
		Now:       func() time.Time { return time.Unix(1767225600, 0) },
		ToolToken: "⟬opaque_token#1⟭",
	})
	form := url.Values{"id_token": {idToken}, "state": {"st-01"}}
	req := httptest.NewRequest(http.MethodPost, "/lti/launch", strings.NewReader(form.Encode()))
	req.Header.Set("Content-Type", "application/x-www-form-urlencoded")
	rec := httptest.NewRecorder()

	tool.Launch(rec, req)

	if rec.Code != http.StatusFound {
		t.Fatalf("status = %d", rec.Code)
	}
	s := tool.Sessions.Last()
	// claims inside idToken: sub, name, email, the course context and the Learner role
	if s.Email != "⟬email#2⟭" || s.Name != "⟬person_name#2⟭" {
		t.Errorf("session = %+v", s)
	}
	if s.Role != RoleLearner {
		t.Errorf("role = %v", s.Role)
	}
}
⟬end⟭

⟬template⟭
family: code
format: .js
language: en
fill_locale: en_GB
domain: travel
appearance: module export, host rule, environment fallback
scenario: configuration of the self-hosted Renovate runner of a rail booking platform, committed by a platform engineer with registry tokens inline
⟬text⟭
// config.js for the self-hosted Renovate runner of the booking platform repos.
// docker run --rm -v $PWD/config.js:/usr/src/app/config.js renovate/renovate
module.exports = {
  platform: 'github',
  endpoint: 'https://api.github.com/',
  token: process.env.RENOVATE_TOKEN || '⟬github_token#1⟭',
  gitAuthor: 'Renovate Bot <⟬email:generic#2⟭>',
  ⟬trap:indicator_non_pii|username: 'renovate[bot]'⟭,
  onboarding: false,
  requireConfig: 'optional',
  repositories: ['wayfarer-rail/booking-web', 'wayfarer-rail/booking-api', 'wayfarer-rail/fares-engine'],
  hostRules: [
    {
      hostType: 'npm',
      matchHost: 'registry.npmjs.org',
      token: '⟬npm_token#1⟭',
    },
    {
      hostType: 'docker',
      matchHost: 'ghcr.io',
      username: '⟬username#1⟭',
      password: '⟬github_token#3⟭',
    },
  ],
  packageRules: [
    { matchUpdateTypes: ['minor', 'patch'], matchCurrentVersion: '!/^0/', automerge: true },
    { matchPackageNames: ['@wayfarer/design-tokens'], schedule: ['before 6am on monday'] },
  ],
  prHourlyLimit: 4,
  timezone: 'Europe/London',
};
⟬end⟭

⟬template⟭
family: code
format: .ts
language: en
fill_locale: en_GB
domain: e-commerce
appearance: object literal, description string, environment fallback
scenario: feature flag definitions of a homeware storefront, kept by the web platform team with owners as team names and a hashing helper for rollouts
⟬text⟭
// src/flags/definitions.ts
// Flag definitions for the storefront. Owners are teams, not people, so a flag
// stays owned when someone moves on.
import type { FlagDefinition } from './types';

export const FLAGS: Record<string, FlagDefinition> = {
  'checkout.express-pay': {
    ⟬trap:indicator_non_pii|owner: 'checkout-squad'⟭,
    description: 'Show Apple Pay and Google Pay above the card form',
    rollout: { percent: 25, salt: '⟬hash#1⟭' },
    expires: '⟬date#1⟭',
  },
  'pdp.gold-swatches': {
    owner: 'merch-tech',
    description: 'Colour swatches for the ⟬trap:word_name|Rose⟭ gold and ⟬trap:word_name|Ruby⟭ ranges on product pages',
    rollout: { percent: 100 },
    expires: '⟬date#2⟭',
  },
  'search.typo-tolerance': {
    owner: 'search',
    description: 'Fuzzy matching with ⟬trap:eponym|Damerau-Levenshtein⟭ distance 1 for queries over 4 chars',
    rollout: { percent: 50, segments: ['returning'] },
    expires: '⟬date#3⟭',
  },
  'catalogue.stone-basins': {
    owner: 'merch-tech',
    description: 'Landing page for the ⟬trap:word_name|Pierre⟭ stone basin collection',
    rollout: { percent: 0 },
    expires: '⟬date#2⟭',
  },
};

export const SDK_KEY = process.env.FLAGS_SDK_KEY ?? '⟬trap:placeholder|<flags-sdk-key>⟭';

export function isEnabled(key: string, visitorId: string): boolean {
  const flag = FLAGS[key];
  if (!flag || Date.parse(flag.expires) < Date.now()) return false;
  const bucket = (hash32(`${flag.rollout.salt ?? key}:${visitorId}`) % 10000) / 100;
  return bucket < flag.rollout.percent;
}

function hash32(input: string): number {
  // FNV-1a, stable across Node and the edge runtime
  let h = 0x811c9dc5;
  for (let i = 0; i < input.length; i += 1) {
    h ^= input.charCodeAt(i);
    h = Math.imul(h, 0x01000193) >>> 0;
  }
  return h;
}
⟬end⟭

⟬template⟭
family: code
format: .go
language: en
fill_locale: en_GB
domain: energy
appearance: doc comment, struct, function
scenario: settlement package of an energy supplier that turns smart meter register reads into 48 half-hourly values, written by a data engineer
⟬text⟭
// Package halfhourly turns cumulative smart meter register reads into
// half-hourly consumption, filling gaps so settlement always gets 48 periods.
//
// ⟬trap:indicator_non_pii|Owner: settlement-data⟭ (see CODEOWNERS)
package halfhourly

import (
	"errors"
	"math"
	"sort"
	"time"
)

// Read is one cumulative register value as sent by the comms hub.
type Read struct {
	MeterID   string
	At        time.Time
	KWh       float64
	Estimated bool
}

var ErrNotMonotonic = errors.New("halfhourly: register went backwards")

// Periods returns the consumption of each half hour of the settlement day,
// interpolating linearly between surrounding reads. A ⟬trap:eponym|Kalman⟭ filter was
// tried in ⟬ticket_id#1⟭ and dropped: the settlement rules want a plain linear fill.
func Periods(reads []Read, day time.Time) ([48]float64, error) {
	var out [48]float64
	sort.Slice(reads, func(i, j int) bool { return reads[i].At.Before(reads[j].At) })
	for i := 1; i < len(reads); i++ {
		if reads[i].KWh < reads[i-1].KWh {
			return out, ErrNotMonotonic
		}
	}
	for p := 0; p < 48; p++ {
		start := day.Add(time.Duration(p) * 30 * time.Minute)
		out[p] = registerAt(reads, start.Add(30*time.Minute)) - registerAt(reads, start)
		if out[p] < 0 || math.IsNaN(out[p]) {
			out[p] = 0
		}
	}
	return out, nil
}

func registerAt(reads []Read, t time.Time) float64 {
	if len(reads) == 0 {
		return math.NaN()
	}
	if !t.After(reads[0].At) {
		return reads[0].KWh
	}
	for i := 1; i < len(reads); i++ {
		if !t.After(reads[i].At) {
			a, b := reads[i-1], reads[i]
			frac := float64(t.Sub(a.At)) / float64(b.At.Sub(a.At))
			return a.KWh + frac*(b.KWh-a.KWh)
		}
	}
	return reads[len(reads)-1].KWh
}
⟬end⟭

⟬template⟭
family: code
format: .cs
language: en
fill_locale: en_GB
domain: media
appearance: regex, raw string literal, comment
scenario: SubRip caption parser of a broadcaster on-demand platform, with a weather bulletin sample used by the tests, written by a developer on the playback team
⟬text⟭
using System.Globalization;
using System.Text.RegularExpressions;

namespace Media.Captions;

/// <summary>Parses SubRip (.srt) files uploaded with on-demand programmes.</summary>
public static partial class SrtParser
{
    [GeneratedRegex(@"^(\d{2}):(\d{2}):(\d{2}),(\d{3}) --> (\d{2}):(\d{2}):(\d{2}),(\d{3})")]
    private static partial Regex Timing();

    public static IReadOnlyList<Cue> Parse(string text)
    {
        var cues = new List<Cue>();
        var blocks = text.Replace("\r\n", "\n").Split("\n\n", StringSplitOptions.RemoveEmptyEntries);
        foreach (var block in blocks)
        {
            var lines = block.Trim().Split('\n');
            if (lines.Length < 3) continue; // TODO(⟬trap:initials|MK⟭): keep empty cues, the player needs them for timing
            var m = Timing().Match(lines[1]);
            if (!m.Success) throw new FormatException($"bad timing line: {lines[1]}");
            cues.Add(new Cue(int.Parse(lines[0], CultureInfo.InvariantCulture), ToSpan(m, 1), ToSpan(m, 5), string.Join('\n', lines[2..])));
        }
        return cues;
    }

    private static TimeSpan ToSpan(Match m, int g) =>
        new(0, int.Parse(m.Groups[g].Value), int.Parse(m.Groups[g + 1].Value), int.Parse(m.Groups[g + 2].Value), int.Parse(m.Groups[g + 3].Value));
}

public sealed record Cue(int Index, TimeSpan Start, TimeSpan End, string Text);

// Weather bulletin used by SrtParserTests.
internal static class Samples
{
    public const string Bulletin = """
        1
        00:00:01,000 --> 00:00:03,500
        Storm ⟬trap:word_name|Bella⟭ reaches the west coast tonight.

        2
        00:00:03,600 --> 00:00:06,000
        Gusts of up to 80 mph are expected inland.
        """;
}
⟬end⟭

⟬template⟭
family: code
format: .java
language: en
fill_locale: en_GB
domain: education
appearance: constant, Javadoc
scenario: password and session policy constants of a sixth form college student portal, agreed with the data protection officer and written by the lead developer
⟬text⟭
package uk.ac.northgate.portal.security;

import java.time.Duration;
import java.util.List;

/** Password and session rules for the student portal, agreed with the DPO. */
public final class SecurityPolicy {
    public static final int ⟬trap:indicator_non_pii|PASSWORD_MIN_LENGTH = 12⟭;
    public static final int LOCKOUT_ATTEMPTS = 5;
    public static final Duration SESSION_IDLE = Duration.ofMinutes(30);
    public static final String ⟬trap:indicator_non_pii|LOGIN_FIELD = "email"⟭;
    public static final String REMEMBER_ME_KEY = "⟬trap:placeholder|${portal.remember-me.key}⟭";
    public static final List<String> DENYLIST = List.of("password", "northgate", "letmein");

    private SecurityPolicy() {}
}
⟬end⟭

⟬template⟭
family: code
format: .js
language: en
fill_locale: en_GB
domain: travel
appearance: lookup table, template literal, sample output in comment
scenario: plain-text itinerary builder of a rail holiday company, used in confirmation emails and the app, written by a backend developer
⟬text⟭
// itinerary/format.js
// Builds the plain-text itinerary attached to confirmation emails and shown in the app.
'use strict';

const { DateTime } = require('luxon');

const STATIONS = {
  VIC: 'London ⟬trap:word_name|Victoria⟭',
  STP: 'London St Pancras International',
  BTN: 'Brighton',
  PNO: 'Paris Gare du Nord',
  FLR: '⟬trap:word_name|Florence⟭ Santa Maria Novella',
  MIL: 'Milano Centrale',
};

const DEFAULTS = { ⟬trap:indicator_non_pii|passengerLabel: 'Lead passenger'⟭, zone: 'Europe/London' };

function leg(segment, zone) {
  const dep = DateTime.fromISO(segment.departs, { zone });
  const arr = DateTime.fromISO(segment.arrives, { zone });
  const from = STATIONS[segment.from] ?? segment.from;
  const to = STATIONS[segment.to] ?? segment.to;
  return `${dep.toFormat('ccc d LLL HH:mm')}  ${from} -> ${to}  (arr ${arr.toFormat('HH:mm')}, coach ${segment.coach}, seat ${segment.seat})`;
}

function itinerary(trip) {
  const zone = trip.zone ?? DEFAULTS.zone;
  const lines = [`Trip ${trip.reference}`, `${trip.passengerLabel ?? DEFAULTS.passengerLabel} + ${trip.party - 1}`, ''];
  for (const s of trip.segments) lines.push(leg(s, zone));
  if (trip.notes) lines.push('', trip.notes);
  return lines.join('\n');
}

module.exports = { itinerary, STATIONS };

// node -e "console.log(require('./itinerary/format').itinerary(require('./fixtures/trip-rail.json')))"
// Trip ⟬order_number#1⟭
// Lead passenger + 1
//
// Fri 13 Mar 08:01  London St Pancras International -> Paris Gare du Nord  (arr 11:20, coach 12, seat 61)
⟬end⟭
