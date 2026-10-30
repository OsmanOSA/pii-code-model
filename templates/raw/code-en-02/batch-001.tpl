⟬template⟭
family: code
format: .ts
language: en
fill_locale: en_GB
domain: logistics
appearance: test fixture, object literal, string literal, assertion
scenario: Jest spec for the courier onboarding service of a parcel locker network, written by a backend developer with an owner-driver copied from the depot pilot form
⟬text⟭
import { Test } from '@nestjs/testing';
import { CourierOnboardingService } from '../src/couriers/courier-onboarding.service';
import { RightToWorkClient } from '../src/compliance/right-to-work.client';
import { InMemoryCourierRepository } from './support/in-memory-courier.repository';

describe('CourierOnboardingService', () => {
  let service: CourierOnboardingService;
  const rtw = { verify: jest.fn().mockResolvedValue({ status: 'ok', checkedAt: '⟬date#1⟭' }) };

  beforeEach(async () => {
    const moduleRef = await Test.createTestingModule({
      providers: [
        CourierOnboardingService,
        { provide: RightToWorkClient, useValue: rtw },
        { provide: 'CourierRepository', useClass: InMemoryCourierRepository },
      ],
    }).compile();
    service = moduleRef.get(CourierOnboardingService);
    rtw.verify.mockClear();
  });

  // owner-driver from the depot pilot, copied from the paper onboarding form
  const applicant = {
    fullName: '⟬person_name#1⟭',
    mobile: '⟬phone#1⟭',
    email: '⟬email#1⟭',
    niNumber: '⟬uk_national_insurance_number#1⟭',
    drivingLicence: '⟬uk_driving_licence#1⟭',
    vehicle: { reg: '⟬uk_license_plate#1⟭', type: 'LWB_VAN', payloadKg: 1200 },
    depot: '⟬city#1⟭',
  };

  it('rejects a licence that does not match the surname', async () => {
    await expect(
      service.onboard({ ...applicant, drivingLicence: '⟬trap:placeholder|XXXXX000000XX0XX⟭' }),
    ).rejects.toThrow('licence_mismatch');
    expect(rtw.verify).not.toHaveBeenCalled();
  });

  it('stores the van against the courier and runs the right to work check', async () => {
    const courier = await service.onboard(applicant);
    expect(courier.vehicles[0].reg).toBe('⟬uk_license_plate#1⟭');
    expect(courier.status).toBe('PENDING_INDUCTION');
    expect(rtw.verify).toHaveBeenCalledWith('⟬uk_national_insurance_number#1⟭');
  });
});
⟬end⟭

⟬template⟭
family: code
format: .go
language: en
fill_locale: en_GB
domain: energy
appearance: table-driven test, struct literal, string literal, comment
scenario: table-driven Go test for the direct debit mandate validator of a smart tariff supplier, with rows built from beta sign-ups by the billing squad
⟬text⟭
package mandate

import (
	"errors"
	"testing"
	"time"
)

// Rows mirror four sign-ups from the smart tariff beta that broke the old
// validator. Keep the joint account case: two payers, one bank account.
func TestValidate(t *testing.T) {
	start := time.Date(2026, 11, 1, 0, 0, 0, 0, time.UTC)
	cases := []struct {
		label   string
		holder  string
		iban    string
		supply  string
		wantErr error
	}{
		{"single payer", "⟬person_name#1⟭", "⟬iban#1⟭", "⟬postal_address#1⟭", nil},
		{"joint account, second payer", "⟬person_name#2⟭", "⟬iban#1⟭", "⟬postal_address#1⟭", nil},
		{"holder left blank on the paper form", "", "⟬iban#3⟭", "⟬postal_address#3⟭", ErrHolderMissing},
		{"account closed before first collection", "⟬person_name#4⟭", "⟬iban#4⟭", "⟬postal_address#4⟭", ErrAccountClosed},
	}
	for _, tc := range cases {
		t.Run(tc.label, func(t *testing.T) {
			m := Mandate{Holder: tc.holder, IBAN: tc.iban, SupplyAddress: tc.supply, Start: start}
			if err := Validate(m); !errors.Is(err, tc.wantErr) {
				t.Fatalf("Validate(%q) = %v, want %v", tc.label, err, tc.wantErr)
			}
		})
	}
}

func TestValidateRejectsStartInThePast(t *testing.T) {
	m := Mandate{Holder: "⟬person_name#1⟭", IBAN: "⟬iban#1⟭", Start: time.Now().AddDate(0, 0, -3)}
	if err := Validate(m); !errors.Is(err, ErrStartDate) {
		t.Fatalf("got %v, want ErrStartDate", err)
	}
}
⟬end⟭

⟬template⟭
family: code
format: .java
language: en
fill_locale: en_GB
domain: travel
appearance: constant, test fixture, map literal, HTTP header, import
scenario: Spring Boot integration test of a charter airline booking API, kept by the QA automation engineer with a staging agent token and a sandbox card pasted in
⟬text⟭
package com.skylane.booking.api;

import static org.hamcrest.Matchers.endsWith;
import static org.hamcrest.Matchers.hasSize;
import static org.hamcrest.Matchers.is;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import com.fasterxml.⟬trap:library|jackson⟭.databind.ObjectMapper;
import com.skylane.booking.payment.Authorisation;
import com.skylane.booking.payment.PaymentGateway;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.TestPropertySource;
import org.springframework.test.web.servlet.MockMvc;

@SpringBootTest
@AutoConfigureMockMvc
@ActiveProfiles("it")
@TestPropertySource(properties = {
    "booking.agent.username=⟬username#1⟭",
    "psp.api-key=⟬trap:placeholder|${PSP_API_KEY}⟭",
    "⟬trap:indicator_non_pii|booking.passport.min-validity-days=180⟭"
})
class BookingControllerIT {

    // Minted against the staging IdP for the QA agent account, valid 30 days.
    // Run ./scripts/mint-token.sh when the suite starts returning 401.
    private static final String AGENT_TOKEN =
        "Bearer ⟬jwt#1⟭";

    @Autowired MockMvc mvc;
    @Autowired ObjectMapper mapper;
    @MockBean PaymentGateway gateway;

    private Map<String, Object> leadPassenger() {
        Map<String, Object> p = new LinkedHashMap<>();
        p.put("title", "Mrs");
        p.put("firstName", "⟬person_name:given#1f⟭");
        p.put("lastName", "⟬person_name:family#1⟭");
        p.put("dateOfBirth", "⟬birth_date#1⟭");
        p.put("nationality", "GBR");
        p.put("passportNumber", "⟬uk_passport#1⟭");
        p.put("passportExpiry", "⟬date#1⟭");
        p.put("email", "⟬email#1⟭");
        p.put("phone", "⟬phone#1⟭");
        return p;
    }

    private Map<String, Object> card() {
        // sandbox card from the PSP docs, any future expiry works
        return Map.of(
            "pan", "⟬payment_card#2⟭",
            "expiry", "09/29",
            "cvc", "⟬card_security_code#2⟭",
            "holder", "⟬person_name#2⟭");
    }

    @Test
    void createsBookingAndCapturesPayment() throws Exception {
        when(gateway.authorise(any())).thenReturn(Authorisation.approved("⟬order_number#1⟭"));
        Map<String, Object> body = Map.of(
            "flightId", "SL4471",
            "fareClass", "Y",
            "passengers", List.of(leadPassenger()),
            "payment", card());

        mvc.perform(post("/api/v2/bookings")
                .header("Authorization", AGENT_TOKEN)
                .contentType(MediaType.APPLICATION_JSON)
                .content(mapper.writeValueAsString(body)))
            .andExpect(status().isCreated())
            .andExpect(jsonPath("$.passengers", hasSize(1)))
            .andExpect(jsonPath("$.payment.pan", endsWith(last4("⟬payment_card#2⟭"))))
            .andExpect(jsonPath("$.payment.cvc").doesNotExist());
    }

    @Test
    void rejectsPassportExpiringBeforeReturn() throws Exception {
        Map<String, Object> pax = leadPassenger();
        pax.put("passportExpiry", "⟬date#2⟭");
        Map<String, Object> body = Map.of("flightId", "SL4471", "passengers", List.of(pax), "payment", card());

        mvc.perform(post("/api/v2/bookings")
                .header("Authorization", AGENT_TOKEN)
                .contentType(MediaType.APPLICATION_JSON)
                .content(mapper.writeValueAsString(body)))
            .andExpect(status().isUnprocessableEntity())
            .andExpect(jsonPath("$.errors[0].field", is("passengers[0].passportExpiry")));
    }

    @Test
    void refusesAnonymousLookup() throws Exception {
        mvc.perform(get("/api/v2/bookings/⟬order_number#1⟭")).andExpect(status().isUnauthorized());
    }

    private static String last4(String pan) {
        return pan.substring(pan.length() - 4);
    }
}
⟬end⟭

⟬template⟭
family: code
format: .cs
language: en
fill_locale: en_GB
domain: e-commerce
appearance: object initializer, string literal, comment
scenario: EF Core dev seed of a homeware marketplace, where the checkout team kept raw card rows to debug the legacy PAN path locally
⟬text⟭
using Marketplace.Domain.Customers;
using Marketplace.Domain.Payments;
using Marketplace.Domain.Sellers;
using Microsoft.EntityFrameworkCore;

namespace Marketplace.Infrastructure.Seed;

// Dev only. Do NOT point this at staging: the LegacyCard rows bypass the vault on
// purpose so we can step through the old PAN flow (see ⟬ticket_id#1⟭).
internal static class DevSeed
{
    public static void Apply(ModelBuilder b)
    {
        b.Entity<Seller>().HasData(
            new Seller { Id = 1, DisplayName = "⟬company#1⟭", ContactName = "⟬person_name#1⟭", ContactEmail = "⟬email#1⟭", PayoutIban = "⟬iban#1⟭", Bic = "⟬bic#1⟭" },
            new Seller { Id = 2, DisplayName = "⟬trap:company_name|⦃Family⦄ & Daughters Ceramics⟭", ContactName = "⟬person_name#2⟭", ContactEmail = "⟬email#2⟭", PayoutIban = "⟬iban#2⟭", Bic = "⟬bic#2⟭" });

        b.Entity<Customer>().HasData(
            new Customer { Id = 100, FullName = "⟬person_name#3⟭", Email = "⟬email#3⟭", DefaultAddress = "⟬postal_address#3⟭", MarketingOptIn = false },
            new Customer { Id = 101, FullName = "⟬person_name#4⟭", Email = "⟬email#4⟭", DefaultAddress = "⟬postal_address#4⟭", MarketingOptIn = true });

        b.Entity<LegacyCard>().HasData(
            new LegacyCard { Id = 9001, CustomerId = 100, Pan = "⟬payment_card#3⟭", ExpMonth = 4, ExpYear = 2028, Cvv = "⟬card_security_code#3⟭" },
            new LegacyCard { Id = 9002, CustomerId = 101, Pan = "⟬payment_card#4⟭", ExpMonth = 11, ExpYear = 2027, Cvv = null });

        b.Entity<BackOfficeUser>().HasData(
            new BackOfficeUser { Id = 1, ⟬trap:indicator_non_pii|Login = "admin"⟭, PasswordHash = "⟬hash#1⟭", MustRotate = true });
    }
}
⟬end⟭

⟬template⟭
family: code
format: .rb
language: en
fill_locale: en_GB
domain: education
appearance: hash literal, string literal, comment, interpolated string
scenario: Rails seed script for the demo tenant of a school management system, written by a developer so the sales team can show the payroll export
⟬text⟭
# db/seeds/demo_school.rb
# Demo tenant for sales calls. bin/rails runner db/seeds/demo_school.rb
# The payroll export validates ni_number, so the staff rows need well-formed ones.

school = School.find_or_create_by!(urn: "⟬customer_id#1⟭") do |s|
  s.name = "⟬trap:word_name|St Agnes⟭ Primary Academy"
  s.address = "⟬postal_address#1⟭"
  s.switchboard = "⟬phone#1⟭"
  s.phase = :primary
  s.trust = "⟬company#1⟭"
end

staff = [
  { title: "Mrs", first_name: "⟬person_name:given#2f⟭", last_name: "⟬person_name:family#2⟭", role: "Headteacher",
    ni_number: "⟬uk_national_insurance_number#2⟭", dob: "⟬birth_date#2⟭", started_on: "⟬date#3⟭" },
  { title: "Mr", first_name: "⟬person_name:given#3m⟭", last_name: "⟬person_name:family#3⟭", role: "⟬job_title#3⟭",
    ni_number: "⟬uk_national_insurance_number#3⟭", dob: "⟬birth_date#3⟭", started_on: "⟬date#1⟭" },
  { title: "Ms", first_name: "⟬person_name:given#4f⟭", last_name: "⟬person_name:family#4⟭", role: "SENCo",
    ni_number: "⟬uk_national_insurance_number#4⟭", dob: "⟬birth_date#4⟭", started_on: "⟬date#2⟭" },
]

staff.each do |attrs|
  StaffMember.find_or_create_by!(school: school, ni_number: attrs[:ni_number]) do |m|
    m.assign_attributes(attrs.except(:ni_number))
    m.email = "#{attrs[:first_name].downcase}.#{attrs[:last_name].downcase}@demo-school.example"
    m.password = ⟬trap:placeholder|ENV.fetch("DEMO_STAFF_PASSWORD")⟭
  end
end

# office contact shown in the parent portal footer
school.update!(office_email: "⟬email:generic#5⟭")

puts "Seeded #{school.name}: #{staff.size} staff, admin login ⟬trap:indicator_non_pii|demo-admin⟭"
⟬end⟭

⟬template⟭
family: code
format: .js
language: en
fill_locale: en_GB
domain: media
appearance: fallback default, commented config line, template literal, comment
scenario: CI release script of a video player SDK that tags the GitHub release and posts to Slack, with token fallbacks a maintainer added while org secrets were being migrated
⟬text⟭
#!/usr/bin/env node
// scripts/announce-release.js
// Tags the GitHub release of the player SDK and posts the changelog to #releases.
// Fallback tokens are temporary until the org secrets migration lands. - ⟬person_name:initial#1⟭
const { WebClient } = require('@slack/web-api');
const { Octokit } = require('@octokit/rest');
const { execSync } = require('child_process');

const slack = new WebClient(process.env.SLACK_BOT_TOKEN || '⟬slack_token#2⟭');
const octokit = new Octokit({ auth: process.env.GH_TOKEN || '⟬github_token#2⟭' });

const { version } = require('../package.json');
const prev = process.env.PREV_TAG || execSync('git describe --tags --abbrev=0 HEAD^').toString().trim();
const changelog = execSync(`git log --no-merges --pretty=format:"- %s" ${prev}..HEAD`).toString();

async function main() {
  await octokit.repos.createRelease({
    owner: 'northlight-media',
    repo: 'player-sdk',
    tag_name: `v${version}`,
    name: `player-sdk ${version}`,
    body: changelog,
  });

  // npm publish runs in the next job step; it reads web/.npmrc, which holds:
  // //registry.npmjs.org/:_authToken=⟬npm_token#2⟭

  await slack.chat.postMessage({
    channel: '#releases',
    text: `:package: player-sdk v${version} is out\n${changelog}\ncc <@⟬username#1⟭> for the app store notes`,
  });
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
⟬end⟭

⟬template⟭
family: code
format: .ts
language: en
fill_locale: en_GB
domain: e-commerce
appearance: constant, mocked response, assertion, comment
scenario: Jest test of a Next.js account orders route, where a frontend developer pasted the session token of the shared test shopper from the browser devtools
⟬text⟭
import { createMocks } from 'node-mocks-http';
import handler from '../../pages/api/account/orders';
import { prisma } from '../../lib/prisma';

jest.mock('../../lib/prisma', () => ({ prisma: { order: { findMany: jest.fn() } } }));

// session of the shared test shopper (⟬person_name#1⟭), copied from devtools > Application > Cookies
const TOKEN = '⟬jwt#1⟭';

describe('GET /api/account/orders', () => {
  afterEach(() => jest.resetAllMocks());

  it('returns the orders of the token subject only', async () => {
    (prisma.order.findMany as jest.Mock).mockResolvedValue([
      { id: '⟬order_number#1⟭', customerEmail: '⟬email#1⟭', totalPence: 4999, placedAt: '⟬date#1⟭' },
      { id: '⟬order_number#2⟭', customerEmail: '⟬email#1⟭', totalPence: 1250, placedAt: '⟬date#2⟭' },
    ]);
    const { req, res } = createMocks({ method: 'GET', headers: { authorization: `Bearer ${TOKEN}` } });

    await handler(req, res);

    expect(res._getStatusCode()).toBe(200);
    expect(prisma.order.findMany).toHaveBeenCalledWith({ where: { customerEmail: '⟬email#1⟭' }, orderBy: { placedAt: 'desc' } });
  });

  it('rejects a token whose signature was tampered with', async () => {
    const forged = TOKEN.slice(0, TOKEN.lastIndexOf('.') + 1) + 'c2lnbmF0dXJl';
    const { req, res } = createMocks({ method: 'GET', headers: { authorization: `Bearer ${forged}` } });

    await handler(req, res);

    expect(res._getStatusCode()).toBe(401);
    expect(prisma.order.findMany).not.toHaveBeenCalled();
  });
});
⟬end⟭

⟬template⟭
family: code
format: .go
language: en
fill_locale: en_GB
domain: logistics
appearance: constant, format string, comment
scenario: magefile of a fleet dispatch monorepo that writes the web console .npmrc, with token fallbacks a developer added for laptops without the vault agent
⟬text⟭
//go:build mage

package main

import (
	"fmt"
	"os"
	"path/filepath"

	"github.com/magefile/mage/mg"
	"github.com/magefile/mage/sh"
)

// Fallbacks for laptops without the vault agent; CI always sets both variables.
// TODO(⟬person_name:handle#1⟭): delete once everyone is on the dev container.
const (
	fallbackNpmToken    = "⟬npm_token#1⟭"
	fallbackGithubToken = "⟬github_token#1⟭"
)

func env(key, fallback string) string {
	if v := os.Getenv(key); v != "" {
		return v
	}
	return fallback
}

// Npmrc writes web/.npmrc so the dispatcher console can pull the private ⟬trap:email_lookalike|@fleetops/map-kit⟭ package.
func Npmrc() error {
	content := fmt.Sprintf("@fleetops:registry=https://npm.pkg.github.com\n//npm.pkg.github.com/:_authToken=%s\n//registry.npmjs.org/:_authToken=%s\n",
		env("GITHUB_TOKEN", fallbackGithubToken), env("NPM_TOKEN", fallbackNpmToken))
	return os.WriteFile(filepath.Join("web", ".npmrc"), []byte(content), 0o600)
}

// Web builds the console after the registry config is in place.
func Web() error {
	mg.Deps(Npmrc)
	if err := sh.RunV("npm", "--prefix", "web", "ci"); err != nil {
		return err
	}
	return sh.RunV("npm", "--prefix", "web", "run", "build")
}

// Tracker builds the Go tracking API for the depot gateways.
func Tracker() error {
	return sh.RunWith(map[string]string{"CGO_ENABLED": "0", "GOOS": "linux"},
		"go", "build", "-o", "bin/tracker", "./cmd/tracker")
}
⟬end⟭

⟬template⟭
family: code
format: .cs
language: en
fill_locale: en_GB
domain: travel
appearance: constructor argument, assertion
scenario: xUnit test of the advance passenger information builder of a ferry operator, written by the developer who fixed the document segment
⟬text⟭
using Ferries.Apis;
using Xunit;

public class ApisMessageBuilderTests
{
    [Fact]
    public void Doc_segment_carries_the_passport_number_and_expiry()
    {
        var pax = new Passenger("⟬person_name:family#1⟭", "⟬person_name:given#1m⟭", DateOnly.Parse("⟬birth_date#1⟭"), Sex.Male,
            new TravelDocument(DocType.Passport, "GBR", "⟬uk_passport#1⟭", DateOnly.Parse("⟬date#1⟭")));

        var doc = ApisMessageBuilder.DocSegment(pax);

        Assert.StartsWith("DOC+P+", doc);
        Assert.Contains("⟬uk_passport#1⟭", doc);
        Assert.DoesNotContain("⟬person_name:given#1⟭", doc);
    }
}
⟬end⟭

⟬template⟭
family: code
format: .rb
language: en
fill_locale: en_GB
domain: e-commerce
appearance: test factory, block value, comment
scenario: FactoryBot factories for the checkout specs of a Rails gift shop, written by a developer wiring in a new card gateway
⟬text⟭
# spec/factories/checkout.rb
FactoryBot.define do
  factory :billing_address do
    line1 { "⟬postal_address:street#1⟭" }
    town { "⟬city#1⟭" }
    postcode { "⟬postcode#1⟭" }
    country_code { "GB" }
  end

  factory :customer do
    name { "⟬person_name#1⟭" }
    email { "⟬email#1⟭" }
    phone { "⟬phone#1⟭" }
    billing_address
  end

  factory :card_payment do
    customer
    amount_pence { 2_499 }
    currency { "GBP" }
    # gateway sandbox card, approves any amount under 50 GBP
    card_number { '⟬payment_card#2⟭' }
    cvc { '⟬card_security_code#2⟭' }
    expiry { "12/30" }

    trait :declined do
      card_number { '⟬payment_card#3⟭' }
      cvc { '⟬card_security_code#3⟭' }
    end

    trait :needs_3ds do
      card_number { '⟬payment_card#4⟭' }
      after(:build) { |p| p.challenge_url = "https://⟬hostname#1⟭/3ds/#{p.reference}" }
    end
  end
end
⟬end⟭

⟬template⟭
family: code
format: .java
language: en
fill_locale: en_GB
domain: energy
appearance: constant, constructor argument, log line in comment, Javadoc
scenario: nightly dispatch job of a smart meter installer that books field engineers, left by the pilot team with a Slack bot token and a fallback engineer hard-coded
⟬text⟭
package uk.co.voltline.dispatch;

import com.slack.api.Slack;
import com.slack.api.methods.MethodsClient;
import com.slack.api.methods.SlackApiException;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Assigns tomorrow's smart meter installs to field engineers and posts a summary
 * to the regional channel. Triggered at 18:00 by the scheduler.
 *
 * <p>Routing runs ⟬trap:eponym|Dijkstra⟭ over the road graph cached by {@link RoadGraph};
 * travel time, not distance, is the weight.
 *
 * <p>Known issue: while the DVLA mock is on, engineers whose licence check is
 * pending still get jobs. The pilot engineer below is the fallback for the
 * Swindon patch until the second van arrives.
 */
public class DailyDispatchJob implements Runnable {

    private static final Logger log = LoggerFactory.getLogger(DailyDispatchJob.class);

    // TODO move to vault before go-live (pilot team)
    private static final String SLACK_BOT_TOKEN = "⟬slack_token#3⟭";
    private static final String CHANNEL = "#dispatch-south-west";

    private final JobRepository jobs;
    private final EngineerRepository engineers;
    private final RoadGraph graph;
    private final MethodsClient slack = Slack.getInstance().methods(SLACK_BOT_TOKEN);

    public DailyDispatchJob(JobRepository jobs, EngineerRepository engineers, RoadGraph graph) {
        this.jobs = jobs;
        this.engineers = engineers;
        this.graph = graph;
    }

    static Engineer pilotEngineer() {
        return new Engineer(
            "ENG-0412",
            "⟬person_name#1⟭",
            "⟬phone#1⟭",
            "⟬uk_driving_licence#1⟭",
            "⟬uk_license_plate#1⟭");
    }

    @Override
    public void run() {
        LocalDate day = LocalDate.now().plusDays(1);
        List<Job> pending = jobs.unassignedFor(day);
        int fallback = 0;
        for (Job job : pending) {
            Engineer e = engineers.nearestAvailable(graph, job.postcode(), day).orElse(null);
            if (e == null) {
                e = pilotEngineer();
                fallback++;
            }
            job.assignTo(e);
            log.info("job={} engineer={} van={}", job.id(), e.id(), e.vanReg());
        }
        post(String.format("%d installs booked for %s (%d on the fallback engineer)", pending.size(), day, fallback));
    }

    private void post(String text) {
        try {
            slack.chatPostMessage(r -> r.channel(CHANNEL).text(text));
        } catch (IOException | SlackApiException ex) {
            log.warn("slack post failed: {}", ex.getMessage());
        }
    }

    // Last bad run, pasted from Kibana:
    // ⟬date#1⟭ 18:00:04 WARN  DailyDispatchJob - licence check pending ⟬uk_driving_licence#2⟭ ⟬uk_license_plate#2⟭ assigned=7
}
⟬end⟭

⟬template⟭
family: code
format: .ts
language: en
fill_locale: en_GB
domain: media
appearance: fallback default, curl command in comment, constant
scenario: Express middleware guarding the embeddable preview player of a newsroom, with a local fallback secret and a token from the curl the developer tested with
⟬text⟭
import type { NextFunction, Request, Response } from 'express';
import jwt from 'jsonwebtoken';

const SECRET = process.env.EMBED_JWT_SECRET ?? '⟬opaque_token#1⟭';
const ⟬trap:indicator_non_pii|TOKEN_MAX_AGE = '2h'⟭;

// curl -i 'http://localhost:4000/embed/clip/9917?t=⟬jwt#1⟭'
export function requireEmbedToken(req: Request, res: Response, next: NextFunction) {
  const raw = (req.query.t as string | undefined) ?? req.get('x-embed-token');
  if (!raw) return res.status(401).json({ error: 'missing_token' });
  try {
    res.locals.embed = jwt.verify(raw, SECRET, { algorithms: ['HS256'], maxAge: TOKEN_MAX_AGE });
    return next();
  } catch {
    return res.status(403).json({ error: 'invalid_token' });
  }
}
⟬end⟭

⟬template⟭
family: code
format: .js
language: en
fill_locale: en_GB
domain: education
appearance: nested object, connection string, string literal, comment
scenario: MongoDB seed script of an online tutoring marketplace used for local runs and review apps, with tutor payroll and right to work data typed in by a developer
⟬text⟭
// seed/tutors.js (local and review apps only)
// usage: node seed/tutors.js --reset
'use strict';

const { MongoClient } = require('mongodb');
const bcrypt = require('bcryptjs');

const uri = process.env.MONGO_URL || 'mongodb://tutorly:⟬url_password#1⟭@localhost:27017/tutorly?authSource=admin';
const DEFAULT_PASSWORD = '⟬password#1⟭'; // every seeded account logs in with this

const tutors = [
  {
    _id: '⟬uuid#1⟭',
    name: { first: '⟬person_name:given#2⟭', last: '⟬person_name:family#2⟭' },
    email: '⟬email#2⟭',
    mobile: '⟬phone#2⟭',
    subjects: ['maths', 'physics'],
    keyStages: ['KS3', 'KS4', 'KS5'],
    bio: "Covers ⟬trap:eponym|Pythagoras⟭, trig and ⟬trap:eponym|Newton⟭'s laws up to A level.",
    rightToWork: { method: 'passport', documentNumber: '⟬uk_passport#2⟭', checkedOn: '⟬date#2⟭' },
    payroll: { niNumber: '⟬uk_national_insurance_number#2⟭', iban: '⟬iban#2⟭' },
    dbs: { certificate: '⟬trap:placeholder|000000000000⟭', updateService: true },
  },
  {
    _id: '⟬uuid#2⟭',
    name: { first: '⟬person_name:given#3⟭', last: '⟬person_name:family#3⟭' },
    email: '⟬email#3⟭',
    mobile: '⟬phone#3⟭',
    subjects: ['english'],
    keyStages: ['KS4'],
    bio: 'Former head of English at a comprehensive, GCSE resits a speciality.',
    rightToWork: { method: 'share_code', documentNumber: null, checkedOn: '⟬date#3⟭' },
    payroll: { niNumber: '⟬uk_national_insurance_number#3⟭', iban: '⟬iban#3⟭' },
  },
  {
    _id: '⟬uuid#3⟭',
    name: { first: '⟬person_name:given#4⟭', last: '⟬person_name:family#4⟭' },
    email: '⟬email#4⟭',
    mobile: null,
    subjects: ['chemistry', 'biology'],
    keyStages: ['KS5'],
    rightToWork: { method: 'passport', documentNumber: '⟬uk_passport#4⟭', checkedOn: '⟬date#1⟭' },
    payroll: { niNumber: '⟬uk_national_insurance_number#4⟭', iban: null }, // payouts not set up yet
  },
];

const families = [
  {
    guardian: { name: '⟬person_name#5⟭', email: '⟬email#5⟭', phone: '⟬phone#5⟭' },
    billingAddress: '⟬postal_address#5⟭',
    students: [{ firstName: '⟬person_name:given#6⟭', yearGroup: 10 }],
  },
  {
    guardian: { name: '⟬person_name#7⟭', email: '⟬email#7⟭', phone: '⟬phone#7⟭' },
    billingAddress: '⟬postal_address#7⟭',
    students: [
      { firstName: '⟬person_name:given#8⟭', yearGroup: 12 },
      { firstName: '⟬person_name:given#9⟭', yearGroup: 8 },
    ],
  },
];

const staff = [{ email: '⟬email:generic#10⟭', ⟬trap:indicator_non_pii|role: 'admin'⟭, label: 'Ops inbox' }];

async function main() {
  const client = new MongoClient(uri);
  await client.connect();
  const db = client.db();
  if (process.argv.includes('--reset')) {
    await Promise.all(['tutors', 'families', 'staff'].map((c) => db.collection(c).deleteMany({})));
  }
  const hash = await bcrypt.hash(DEFAULT_PASSWORD, 10);
  await db.collection('tutors').insertMany(tutors.map((t) => ({ ...t, passwordHash: hash })));
  await db.collection('families').insertMany(families.map((f) => ({ ...f, passwordHash: hash })));
  await db.collection('staff').insertMany(staff.map((s) => ({ ...s, passwordHash: hash })));
  console.log(`seeded ${tutors.length} tutors, ${families.length} families`);
  await client.close();
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
⟬end⟭

⟬template⟭
family: code
format: .go
language: en
fill_locale: en_GB
domain: travel
appearance: raw JSON string, query parameter, positional struct literal
scenario: Go test of a car hire desk client for the driving licence check service, with a canned response the developer recorded during the counter pilot
⟬text⟭
package licencecheck

import (
	"context"
	"fmt"
	"net/http"
	"net/http/httptest"
	"testing"
)

func TestCheck_ReturnsPointsAndHolder(t *testing.T) {
	srv := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		if got := r.URL.Query().Get("dln"); got != "⟬uk_driving_licence#1⟭" {
			t.Errorf("dln = %q", got)
		}
		w.Header().Set("Content-Type", "application/json")
		fmt.Fprint(w, `{"driver":{"name":"⟬person_name#1⟭","address":"⟬postal_address#1⟭"},"points":3,"endorsements":[{"code":"SP30","offenceDate":"⟬date#2⟭"}]}`)
	}))
	defer srv.Close()

	c := New(srv.URL, "⟬trap:placeholder|test-key⟭")
	res, err := c.Check(context.Background(), Hire{"⟬order_number#1⟭", "⟬uk_driving_licence#1⟭", "⟬uk_license_plate#1⟭"})
	if err != nil {
		t.Fatal(err)
	}
	if res.Points != 3 || !res.Eligible {
		t.Fatalf("unexpected result %+v", res)
	}
}
⟬end⟭

⟬template⟭
family: code
format: .cs
language: en
fill_locale: en_GB
domain: media
appearance: environment fallback, HTTP header, interpolated string, comment
scenario: .NET release tool of a broadcaster design system that publishes the UI kit to npm, drafts the GitHub release and posts to Slack, with tokens pasted from the old Jenkins job
⟬text⟭
// tools/ReleaseTool/Program.cs
// Publishes the UI kit to npm, drafts the GitHub release and tells #design-system.
// dotnet run --project tools/ReleaseTool -- 4.2.0
// Release captain this quarter: ⟬person_name#2⟭ <⟬email#2⟭>
using System.Diagnostics;
using System.Net.Http.Headers;
using System.Net.Http.Json;

var version = args.Length > 0 ? args[0] : throw new ArgumentException("usage: ReleaseTool <version>");
var distTag = version.Contains('-') ? "next" : "latest";

// Pasted from the old Jenkins job; the new runners do not set these yet.
var npmToken = Environment.GetEnvironmentVariable("NPM_TOKEN") ?? "⟬npm_token#1⟭";
var ghToken = Environment.GetEnvironmentVariable("GH_RELEASE_TOKEN") ?? "⟬github_token#1⟭";
var slackToken = Environment.GetEnvironmentVariable("SLACK_TOKEN") ?? "⟬slack_token#1⟭";

File.WriteAllText("packages/ui/.npmrc", $"//registry.npmjs.org/:_authToken={npmToken}\n");
Run("npm", $"publish packages/ui --access public --tag {distTag}");

using var http = new HttpClient();
http.DefaultRequestHeaders.UserAgent.ParseAdd("broadcast-ui-release/1.0");

var gh = new HttpRequestMessage(HttpMethod.Post, "https://api.github.com/repos/broadcast-ui/ui-kit/releases")
{
    Content = JsonContent.Create(new
    {
        tag_name = $"v{version}",
        name = $"UI kit {version}",
        draft = true,
        generate_release_notes = true,
    }),
};
gh.Headers.Authorization = new AuthenticationHeaderValue("Bearer", ghToken);
gh.Headers.Accept.Add(new MediaTypeWithQualityHeaderValue("application/vnd.github+json"));
var ghResponse = await http.SendAsync(gh);
ghResponse.EnsureSuccessStatusCode();
var release = await ghResponse.Content.ReadFromJsonAsync<Release>();

var slack = new HttpRequestMessage(HttpMethod.Post, "https://slack.com/api/chat.postMessage")
{
    Content = JsonContent.Create(new
    {
        channel = "#design-system",
        text = $"UI kit {version} is on npm ({distTag}). Draft release: {release?.HtmlUrl}",
    }),
};
slack.Headers.Authorization = new AuthenticationHeaderValue("Bearer", slackToken);
(await http.SendAsync(slack)).EnsureSuccessStatusCode();

Console.WriteLine($"done: {version}");

static void Run(string file, string arguments)
{
    using var p = Process.Start(new ProcessStartInfo(file, arguments) { UseShellExecute = false })
        ?? throw new InvalidOperationException($"could not start {file}");
    p.WaitForExit();
    if (p.ExitCode != 0)
    {
        throw new InvalidOperationException($"{file} {arguments} exited with {p.ExitCode}");
    }
}

record Release(string HtmlUrl);
⟬end⟭

⟬template⟭
family: code
format: .go
language: en
fill_locale: en_GB
domain: logistics
appearance: struct literal, connection string, JSON response
scenario: liveness and readiness handlers of a parcel tracking API, written by the platform engineer who set up the Kubernetes probes
⟬text⟭
// Package health exposes liveness and readiness for the parcel tracking API.
// Kubernetes probes hit /livez every 10s and /readyz every 5s.
package health

import (
	"context"
	"database/sql"
	"encoding/json"
	"net/http"
	"os"
	"time"

	"github.com/redis/go-redis/v9"
)

var (
	Version = "⟬version#1⟭"
	Commit  = "⟬git_sha#1⟭"
)

// The probe role only has SELECT on tracking.events; its password comes from PGPASSWORD.
const probeDSN = "postgres://healthcheck:⟬trap:placeholder|${PGPASSWORD}⟭@⟬hostname#1⟭:5432/tracking?sslmode=require"

type Checker struct {
	DB        *sql.DB
	Cache     *redis.Client
	ProbeUser string
}

func New(cache *redis.Client) (*Checker, error) {
	db, err := sql.Open("pgx", os.ExpandEnv(probeDSN))
	if err != nil {
		return nil, err
	}
	return &Checker{DB: db, Cache: cache, ⟬trap:indicator_non_pii|ProbeUser: "healthcheck"⟭}, nil
}

func (c *Checker) Live(w http.ResponseWriter, _ *http.Request) {
	w.WriteHeader(http.StatusOK)
}

func (c *Checker) Ready(w http.ResponseWriter, r *http.Request) {
	ctx, cancel := context.WithTimeout(r.Context(), 800*time.Millisecond)
	defer cancel()
	status := map[string]string{"db": "ok", "cache": "ok", "version": Version, "commit": Commit}
	code := http.StatusOK
	if err := c.DB.PingContext(ctx); err != nil {
		status["db"], code = err.Error(), http.StatusServiceUnavailable
	}
	if err := c.Cache.Ping(ctx).Err(); err != nil {
		status["cache"], code = err.Error(), http.StatusServiceUnavailable
	}
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(code)
	_ = json.NewEncoder(w).Encode(status)
}
⟬end⟭

⟬template⟭
family: code
format: .ts
language: en
fill_locale: en_GB
domain: travel
appearance: validation schema, regular expression, placeholder text, comment
scenario: Zod schema and field hints of a package holiday checkout, written by a frontend developer to share validation between the browser and the API
⟬text⟭
import { z } from 'zod';

/**
 * Lead passenger and payment schema for the package holiday checkout.
 * Shared by the React form and the Fastify handler so both reject the same input.
 * Formats follow the HMPO and DVLA guidance pages linked in ⟬ticket_id#1⟭.
 */

const UK_POSTCODE = /^[A-Z]{1,2}\d[A-Z\d]? ?\d[A-Z]{2}$/i;
const UK_PASSPORT = /^\d{9}$/;
const NI_NUMBER = /^(?!BG|GB|NK|KN|TN|NT|ZZ)[A-CEGHJ-PR-TW-Z]{2}\d{6}[A-D]$/;

// ⟬trap:eponym|Luhn⟭ mod 10, enough to catch typos before the PSP sees the card
export function ⟬trap:code_identifier|luhnValid⟭(digits: string): boolean {
  let sum = 0;
  let double = false;
  for (let i = digits.length - 1; i >= 0; i -= 1) {
    let d = Number(digits[i]);
    if (double) {
      d *= 2;
      if (d > 9) d -= 9;
    }
    sum += d;
    double = !double;
  }
  return sum % 10 === 0;
}

export const leadPassenger = z.object({
  title: z.enum(['Mr', 'Mrs', 'Ms', 'Miss', 'Mx', 'Dr']),
  firstName: z.string().min(1).max(40),
  lastName: z.string().min(1).max(40),
  dateOfBirth: z.string().regex(/^\d{2}\/\d{2}\/\d{4}$/),
  passportNumber: z.string().regex(UK_PASSPORT, 'Nine digits, as printed on the photo page'),
  postcode: z.string().regex(UK_POSTCODE),
  niNumber: z.string().regex(NI_NUMBER).optional(),
});

export const payment = z.object({
  cardNumber: z.string().transform((s) => s.replace(/\s+/g, '')).refine(⟬trap:code_identifier|luhnValid⟭, 'Check the card number'),
  expiry: z.string().regex(/^(0[1-9]|1[0-2])\/\d{2}$/),
  cvc: z.string().regex(/^\d{3,4}$/),
});

// Hints rendered as input placeholders; none of them is a real document.
export const fieldHints = {
  ⟬trap:indicator_non_pii|dateOfBirth: 'DD/MM/YYYY'⟭,
  passportNumber: '⟬trap:placeholder|123456789⟭',
  niNumber: '⟬trap:placeholder|QQ 12 34 56 C⟭',
  cardNumber: '⟬trap:placeholder|•••• •••• •••• ••••⟭',
  postcode: 'e.g. ⟬postcode#1⟭',
} as const;
⟬end⟭

⟬template⟭
family: code
format: .cs
language: en
fill_locale: en_GB
domain: energy
appearance: constant, configuration lookup, using directive
scenario: typed HTTP client registration with retries for a wholesale tariff API, written by a backend developer on the pricing team
⟬text⟭
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Http.Resilience;
using ⟬trap:library|Polly⟭;
using Pricing.Tariffs;

namespace Pricing.Api.Setup;

public static class TariffClientSetup
{
    private const string ⟬trap:indicator_non_pii|ApiKeyHeader = "X-Api-Key"⟭;

    public static IServiceCollection AddTariffClient(this IServiceCollection services, IConfiguration config)
    {
        var section = config.GetSection("TariffApi");

        services.AddHttpClient<ITariffClient, TariffClient>(client =>
            {
                client.BaseAddress = new Uri(section["BaseUrl"] ?? "⟬url#1⟭");
                client.DefaultRequestHeaders.Add(ApiKeyHeader, section["ApiKey"] ?? "⟬trap:placeholder|<set in user-secrets>⟭");
                client.Timeout = TimeSpan.FromSeconds(20);
            })
            .AddResilienceHandler("tariffs", pipeline =>
            {
                pipeline.AddRetry(new HttpRetryStrategyOptions
                {
                    MaxRetryAttempts = 4,
                    BackoffType = DelayBackoffType.Exponential,
                    UseJitter = true,
                });
                pipeline.AddTimeout(TimeSpan.FromSeconds(5));
            });

        return services;
    }
}
⟬end⟭

⟬template⟭
family: code
format: .rb
language: en
fill_locale: en_GB
domain: education
appearance: migration, comment
scenario: Rails migration adding right to work tracking to staff records, written by a developer after a request from the HR lead of a school trust
⟬text⟭
# Right to work fields, agreed with ⟬trap:initials|J.K.⟭ (HR) in ⟬ticket_id#1⟭.
# We keep the method and who checked, never a scan of the document.
# rtw_checked_by holds a staff handle such as ⟬username#1⟭.
class AddRightToWorkToStaffMembers < ActiveRecord::Migration[7.1]
  def change
    add_column :staff_members, :rtw_method, :string, null: false, default: "share_code"
    add_column :staff_members, :rtw_document_last4, :string, limit: 4
    add_column :staff_members, :rtw_checked_on, :date
    add_column :staff_members, :rtw_checked_by, :string
    add_index :staff_members, [:school_id, :rtw_checked_on]
  end
end
⟬end⟭

⟬template⟭
family: code
format: .java
language: en
fill_locale: en_GB
domain: media
appearance: constant, Javadoc, import, annotation
scenario: wire story deduplicator of a news site that merges agency copy with near-identical headlines, written by a developer on the content platform team
⟬text⟭
package uk.co.dailyledger.wire;

import com.fasterxml.⟬trap:library|jackson⟭.annotation.JsonIgnoreProperties;
import com.fasterxml.⟬trap:library|jackson⟭.databind.DeserializationFeature;
import com.fasterxml.⟬trap:library|jackson⟭.databind.ObjectMapper;
import java.io.IOException;
import java.text.Normalizer;
import java.time.Instant;
import java.util.List;
import java.util.Locale;
import org.apache.commons.text.similarity.LevenshteinDistance;

/**
 * Collapses agency stories whose headlines differ by a few characters
 * (a corrected typo, an updated figure) into one item.
 *
 * <p>Two headlines match when their normalised ⟬trap:eponym|Levenshtein⟭ distance is below
 * {@link #THRESHOLD}. The old rules in {@code ⟬trap:code_identifier|⦃Family⦄HeadlineRules⟭} stay
 * in place for the sports desk until they sign off on these.
 */
public final class WireDeduplicator {

    static final double THRESHOLD = 0.12;
    private static final String ⟬trap:indicator_non_pii|DEFAULT_BYLINE = "Staff Reporter"⟭;

    private final ObjectMapper mapper = new ObjectMapper()
        .configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false)
        .findAndRegisterModules();
    private final LevenshteinDistance distance = LevenshteinDistance.getDefaultInstance();

    @JsonIgnoreProperties(ignoreUnknown = true)
    public record WireItem(String id, String agency, String headline, String byline, Instant filedAt) {
        public String bylineOrDefault() {
            return byline == null || byline.isBlank() ? DEFAULT_BYLINE : byline;
        }
    }

    public WireItem parse(String json) throws IOException {
        return mapper.readValue(json, WireItem.class);
    }

    public boolean sameStory(WireItem a, WireItem b) {
        String x = normalise(a.headline());
        String y = normalise(b.headline());
        int longest = Math.max(x.length(), y.length());
        return longest > 0 && (double) distance.apply(x, y) / longest < THRESHOLD;
    }

    public List<WireItem> collapse(List<WireItem> items) {
        return items.stream()
            .filter(i -> items.stream().noneMatch(o -> o.filedAt().isAfter(i.filedAt()) && sameStory(o, i)))
            .toList();
    }

    private static String normalise(String headline) {
        return Normalizer.normalize(headline, Normalizer.Form.NFKD)
            .replaceAll("\\p{M}", "")
            .toLowerCase(Locale.UK)
            .replaceAll("[^a-z0-9 ]", " ")
            .trim();
    }
}
⟬end⟭
