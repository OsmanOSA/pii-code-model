⟬template⟭
family: code
format: .go
language: en
fill_locale: en_GB
domain: logistics
appearance: SQL in comment, raw SQL string
scenario: repository method of a same-day delivery dispatcher, with the psql repro a developer left above it while chasing a double-booked van
⟬text⟭
package dispatch

import "context"

// FindByVehicle returns the open shift for a van.
//
// Repro for the double-booking bug, against the read replica:
//   psql "$REPLICA_URL" -c "SELECT * FROM shifts WHERE vrm = '⟬uk_license_plate#1⟭' AND driver_licence = '⟬uk_driving_licence#1⟭'"
func (r *Repo) FindByVehicle(ctx context.Context, vrm string) (*Shift, error) {
	const q = `SELECT id, driver_licence, starts_at FROM shifts WHERE vrm = $1 AND ends_at IS NULL`
	var s Shift
	err := r.db.QueryRowContext(ctx, q, vrm).Scan(&s.ID, &s.DriverLicence, &s.StartsAt)
	return &s, err
}
⟬end⟭

⟬template⟭
family: code
format: .ts
language: en
fill_locale: en_GB
domain: e-commerce
appearance: JSDoc example, HTTP header
scenario: TypeScript client for a payment provider used by a marketplace, whose JSDoc example the integration developer filled with sandbox values
⟬text⟭
import type { Charge, ChargeRequest, Payout, PayoutRequest } from './types';
import { PaywiseError } from './errors';

/**
 * Thin client for the Paywise REST API: card charges, refunds and seller payouts.
 *
 * @example
 * const pay = new PaywiseClient({ secretKey: '⟬opaque_token#1⟭', sandbox: true });
 * await pay.charges.create({
 *   amount: 1999,
 *   currency: 'GBP',
 *   card: { number: '⟬payment_card#2⟭', expMonth: 12, expYear: 2029, cvc: '⟬card_security_code#2⟭' },
 *   receiptEmail: '⟬email#2⟭',
 * });
 * await pay.payouts.create({ sellerId: '⟬customer_id#3⟭', iban: '⟬iban#3⟭', amount: 15000 });
 */
export class PaywiseClient {
  private readonly baseUrl: string;

  constructor(private readonly opts: { secretKey: string; sandbox?: boolean }) {
    this.baseUrl = opts.sandbox ? 'https://sandbox.api.paywise.example/v1' : 'https://api.paywise.example/v1';
  }

  readonly charges = { create: (body: ChargeRequest) => this.post<Charge>('/charges', body) };
  readonly payouts = { create: (body: PayoutRequest) => this.post<Payout>('/payouts', body) };

  private async post<T>(path: string, body: unknown): Promise<T> {
    const res = await fetch(this.baseUrl + path, {
      method: 'POST',
      headers: { authorization: `Basic ${btoa(this.opts.secretKey + ':')}`, 'content-type': 'application/json' },
      body: JSON.stringify(body),
    });
    if (!res.ok) throw new PaywiseError(res.status, await res.text());
    return (await res.json()) as T;
  }
}
⟬end⟭

⟬template⟭
family: code
format: .java
language: en
fill_locale: en_GB
domain: travel
appearance: SQL INSERT, array literal, Javadoc
scenario: Flyway Java migration that seeds the loyalty members and passports the QA team uses on an airline user acceptance environment
⟬text⟭
package db.migration;

import java.sql.PreparedStatement;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import org.flywaydb.core.api.migration.BaseJavaMigration;
import org.flywaydb.core.api.migration.Context;

/**
 * Seeds the loyalty members the QA team uses on UAT. Lives under
 * db/migration-uat, which the production profile never loads.
 */
public class V12__seed_uat_members extends BaseJavaMigration {

    private static final DateTimeFormatter DOB = DateTimeFormatter.ofPattern("dd/MM/yyyy");

    private static final String INSERT_MEMBER =
        "INSERT INTO loyalty_member (member_no, title, given_name, family_name, date_of_birth, email, mobile, home_address, tier) "
        + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

    private static final String INSERT_DOCUMENT =
        "INSERT INTO travel_document (member_no, doc_type, doc_number, issuing_state, expires_on) VALUES (?, 'P', ?, 'GBR', ?)";

    private static final Object[][] MEMBERS = {
        {"⟬customer_id#1⟭", "Mrs", "⟬person_name:given#1f⟭", "⟬person_name:family#1⟭", "⟬birth_date#1⟭", "⟬email#1⟭", "⟬phone#1⟭", "⟬postal_address#1⟭", "GOLD"},
        {"⟬customer_id#2⟭", "Mr", "⟬person_name:given#2m⟭", "⟬person_name:family#2⟭", "⟬birth_date#2⟭", "⟬email#2⟭", "⟬phone#2⟭", "⟬postal_address#2⟭", "SILVER"},
        {"⟬customer_id#3⟭", "Dr", "⟬person_name:given#3⟭", "⟬person_name:family#3⟭", "⟬birth_date#3⟭", "⟬email#3⟭", null, "⟬postal_address#3⟭", "BLUE"},
    };

    private static final String[][] PASSPORTS = {
        {"⟬customer_id#1⟭", "⟬uk_passport#1⟭", "⟬date#1⟭"},
        {"⟬customer_id#2⟭", "⟬uk_passport#2⟭", "⟬date#2⟭"},
    };

    @Override
    public void migrate(Context context) throws Exception {
        try (PreparedStatement member = context.getConnection().prepareStatement(INSERT_MEMBER);
             PreparedStatement doc = context.getConnection().prepareStatement(INSERT_DOCUMENT)) {
            for (Object[] row : MEMBERS) {
                for (int i = 0; i < row.length; i++) {
                    Object value = row[i];
                    member.setObject(i + 1, i == 4 ? LocalDate.parse((String) value, DOB) : value);
                }
                member.addBatch();
            }
            member.executeBatch();

            for (String[] row : PASSPORTS) {
                doc.setString(1, row[0]);
                doc.setString(2, row[1]);
                doc.setObject(3, LocalDate.parse(row[2], DOB));
                doc.addBatch();
            }
            doc.executeBatch();
        }
    }

    @Override
    public boolean canExecuteInTransaction() {
        return true;
    }
}
⟬end⟭

⟬template⟭
family: code
format: .rb
language: en
fill_locale: en_GB
domain: media
appearance: commit trailer, environment fallback, heredoc example in comment
scenario: Rake task of a news site that publishes the comments widget to npm and drafts a GitHub release crediting co-authors, written by a developer on the audience team
⟬text⟭
# lib/tasks/embed_release.rake
#
# Releases the embeddable comments widget: publishes the bundle to npm, then
# drafts a GitHub release crediting everyone in the Co-authored-by trailers.
#
#   bin/rails "embed:release[2.8.0]"
require "octokit"
require "open3"

namespace :embed do
  desc "Publish the comments widget and draft the GitHub release"
  task :release, [:version] => :environment do |_t, args|
    version = args.fetch(:version)
    npm_token = ENV.fetch("NPM_TOKEN", '⟬npm_token#1⟭')
    github = Octokit::Client.new(access_token: ENV.fetch("GITHUB_TOKEN", '⟬github_token#1⟭'))

    Dir.chdir("widget") do
      File.write(".npmrc", "//registry.npmjs.org/:_authToken=#{npm_token}\n")
      system("npm", "version", version, "--no-git-tag-version", exception: true)
      system("npm", "publish", "--access", "public", exception: true)
    end

    previous = `git describe --tags --abbrev=0`.strip
    log, = Open3.capture2("git", "log", "--format=%B", "#{previous}..HEAD")
    credits = EmbedRelease.co_authors(log)
    github.create_release("stillwater-news/comments-widget", "v#{version}",
                          name: "Comments widget #{version}", draft: true,
                          body: "Thanks to #{credits.join(', ')}")
  end
end

module EmbedRelease
  TRAILER = /^Co-authored-by:\s*(?<name>.+?)\s*<(?<email>[^>]+)>\s*$/

  # EmbedRelease.co_authors(<<~MSG)
  #   Fix avatar fallback in dark mode
  #
  #   Co-authored-by: ⟬person_name#2⟭ <⟬email#2⟭>
  #   Co-authored-by: ⟬person_name#3⟭ <⟬email#3⟭>
  #   Signed-off-by: ⟬person_name#4⟭ <⟬email#4⟭>
  # MSG
  # => ["⟬person_name#2⟭", "⟬person_name#3⟭"]
  def self.co_authors(log)
    log.each_line.filter_map { |line| line.match(TRAILER)&.[](:name) }.uniq
  end
end
⟬end⟭

⟬template⟭
family: code
format: .js
language: en
fill_locale: en_GB
domain: energy
appearance: constant, HTTP header, comment
scenario: cron job of an energy flexibility trial that pulls half-hourly reads and posts a Slack summary, written by an analyst with the tokens pasted at the top
⟬text⟭
// jobs/daily-reads.js
// Pulls yesterday's half-hourly reads for the flexibility trial sites and posts a
// summary to #flex-trial. Runs from cron on the analytics box.
const axios = require('axios');

const ADAPTER = 'https://adapter.flex-trial.example/api/v2';
// access token from the adapter portal, valid until revoked; refresh flow is ⟬ticket_id#1⟭
const ACCESS = '⟬jwt#1⟭';
const SLACK = '⟬slack_token#1⟭';

const api = axios.create({
  baseURL: ADAPTER,
  timeout: 20000,
  headers: { Authorization: `Bearer ${ACCESS}`, 'X-Client-Ref': '⟬opaque_token#2⟭' },
});

async function main() {
  const day = new Date(Date.now() - 864e5).toISOString().slice(0, 10);
  const { data: sites } = await api.get('/sites', { params: { programme: 'flex-trial' } });
  let total = 0;
  const incomplete = [];
  for (const site of sites) {
    const { data } = await api.get(`/sites/${site.id}/reads`, { params: { date: day, granularity: 'PT30M' } });
    if (data.periods.length < 48) incomplete.push(site.id);
    total += data.periods.reduce((sum, p) => sum + p.kwh, 0);
  }
  await axios.post(
    'https://slack.com/api/chat.postMessage',
    { channel: '#flex-trial', text: `Reads for ${day}: ${sites.length} sites, ${total.toFixed(1)} kWh, incomplete: ${incomplete.join(' ') || 'none'}` },
    { headers: { Authorization: `Bearer ${SLACK}` } },
  );
}

main().catch((err) => {
  console.error(err.response?.data ?? err);
  process.exit(1);
});
⟬end⟭

⟬template⟭
family: code
format: .cs
language: en
fill_locale: en_GB
domain: education
appearance: anonymous object, integration test
scenario: integration tests of the dinner money top-up and leaver refund endpoints of a school payments app, written by a backend developer with WebApplicationFactory
⟬text⟭
using System.Net;
using System.Net.Http.Json;
using Microsoft.AspNetCore.Mvc.Testing;
using Xunit;

public class PaymentsEndpointTests : IClassFixture<WebApplicationFactory<Program>>
{
    private readonly HttpClient _client;

    public PaymentsEndpointTests(WebApplicationFactory<Program> factory) => _client = factory.CreateClient();

    [Fact]
    public async Task Parent_can_top_up_a_pupil_account_by_card()
    {
        var request = new
        {
            pupilRef = "⟬customer_id#1⟭",
            amountPence = 2000,
            payer = new { name = "⟬person_name#2⟭", email = "⟬email#2⟭" },
            card = new { number = "⟬payment_card#2⟭", expiry = "03/28", cvc = "⟬card_security_code#2⟭" },
        };

        var response = await _client.PostAsJsonAsync("/api/topups", request);

        Assert.Equal(HttpStatusCode.Created, response.StatusCode);
    }

    [Fact]
    public async Task Leaver_balance_goes_back_to_the_bank_account_on_file()
    {
        var request = new { pupilRef = "⟬customer_id#3⟭", reason = "leaver", refundTo = new { holder = "⟬person_name#4⟭", iban = "⟬iban#4⟭" } };

        var response = await _client.PostAsJsonAsync("/api/refunds", request);

        Assert.Equal(HttpStatusCode.Accepted, response.StatusCode);
        var result = await response.Content.ReadFromJsonAsync<RefundResult>();
        Assert.Equal("BANK_TRANSFER", result!.Method);
    }
}
⟬end⟭

⟬template⟭
family: code
format: .ts
language: en
fill_locale: en_GB
domain: logistics
appearance: form fill in e2e test, assertion
scenario: Playwright test of the branch portal of a van hire company that adds a second driver, written by a QA engineer
⟬text⟭
import { expect, test } from '@playwright/test';

test.describe('van hire: additional driver', () => {
  test.use({ storageState: 'e2e/.auth/branch-staff.json' });

  test('adds a second driver and runs the licence check', async ({ page }) => {
    await page.goto('/hires/⟬order_number#1⟭/drivers/new');

    await page.getByLabel('Full name').fill('⟬person_name#1⟭');
    await page.getByLabel('Email').fill('⟬email#1⟭');
    await page.getByLabel('Driving licence number').fill('⟬uk_driving_licence#1⟭');
    await page.getByLabel('National Insurance number').fill('⟬uk_national_insurance_number#1⟭');
    await page.getByRole('button', { name: 'Run licence check' }).click();
    await expect(page.getByTestId('licence-status')).toHaveText('Valid, 3 points');

    await page.getByLabel('Vehicle').selectOption({ label: '⟬uk_license_plate#2⟭ (Transit Custom L2)' });
    await page.getByRole('button', { name: 'Save driver' }).click();

    await expect(page.getByText('⟬person_name#1⟭ added to ⟬order_number#1⟭')).toBeVisible();
  });
});
⟬end⟭

⟬template⟭
family: code
format: .java
language: en
fill_locale: en_GB
domain: media
appearance: constant, Javadoc
scenario: Android configuration class of a podcast app whose in-app feedback files GitHub issues with an embedded token, committed by a mobile developer
⟬text⟭
package fm.tidewave.podcasts.feedback;

/**
 * In-app "Send feedback" files an issue in the private triage repo.
 * Fine-grained token, issues only, on that one repo (⟬person_name:initial#1⟭, ⟬date#1⟭).
 */
final class FeedbackConfig {
    static final String REPO = "tidewave/podcasts-triage";
    static final String TOKEN = "⟬github_token#1⟭";
    static final String ⟬trap:indicator_non_pii|TOKEN_SCOPE = "issues:write"⟭;
    static final String SUPPORT_MAILBOX = "⟬email:generic#2⟭";

    private FeedbackConfig() {}
}
⟬end⟭

⟬template⟭
family: code
format: .go
language: en
fill_locale: en_GB
domain: energy
appearance: raw JSON request body, HTTP header, struct literal
scenario: Go handler test for member sign-up at an electric car club run by an energy company, with a bearer token and a licence the developer typed in
⟬text⟭
package members

import (
	"net/http"
	"net/http/httptest"
	"strings"
	"testing"

	"github.com/voltshare/club/internal/store"
)

func TestSignupRunsLicenceCheck(t *testing.T) {
	checker := &fakeChecker{result: CheckResult{Valid: true, Points: 0}}
	h := NewHandler(store.NewMemory(), checker, Config{JWTSecret: []byte("⟬opaque_token#1⟭")})

	body := strings.NewReader(`{"name":"⟬person_name#1⟭","email":"⟬email#1⟭","licence":"⟬uk_driving_licence#1⟭","home_postcode":"⟬postcode#1⟭"}`)
	req := httptest.NewRequest(http.MethodPost, "/v1/members", body)
	req.Header.Set("Authorization", "Bearer ⟬jwt#1⟭")
	rec := httptest.NewRecorder()

	h.ServeHTTP(rec, req)

	if rec.Code != http.StatusCreated {
		t.Fatalf("status %d: %s", rec.Code, rec.Body)
	}
	if checker.calls != 1 || checker.lastLicence != "⟬uk_driving_licence#1⟭" {
		t.Errorf("checker = %+v", checker)
	}
}

func TestSignupWithoutTokenIsRejected(t *testing.T) {
	h := NewHandler(store.NewMemory(), &fakeChecker{}, Config{JWTSecret: []byte("⟬opaque_token#1⟭")})
	rec := httptest.NewRecorder()
	h.ServeHTTP(rec, httptest.NewRequest(http.MethodPost, "/v1/members", strings.NewReader(`{}`)))
	if rec.Code != http.StatusUnauthorized {
		t.Fatalf("status %d", rec.Code)
	}
}
⟬end⟭

⟬template⟭
family: code
format: .cs
language: en
fill_locale: en_GB
domain: travel
appearance: named argument, assertion
scenario: xUnit tests of the airport parking booking service that registers plates with the barrier cameras, written by the developer of the ANPR integration
⟬text⟭
namespace Parking.Bookings.Tests;

public class BookingServiceTests
{
    private readonly FakeAnprGateway _anpr = new();
    private readonly BookingService _service;

    public BookingServiceTests() => _service = new BookingService(_anpr, new FakePsp(), TimeProvider.System);

    [Fact]
    public async Task Booking_registers_the_plate_with_the_barrier_cameras()
    {
        var booking = await _service.BookAsync(new BookingRequest(
            Product: "Long stay T2",
            Plate: "⟬uk_license_plate#1⟭",
            Driver: "⟬person_name#1⟭",
            Email: "⟬email#1⟭",
            Mobile: "⟬phone#1⟭",
            Card: "⟬payment_card#1⟭",
            From: DateTime.Parse("⟬date#2⟭"),
            To: DateTime.Parse("⟬date#1⟭")));

        Assert.Contains("⟬uk_license_plate#1⟭", _anpr.Registered);
        Assert.Equal(BookingStatus.Confirmed, booking.Status);
    }

    [Fact]
    public async Task Plate_is_normalised_before_registration()
    {
        await _service.BookAsync(BookingRequest.Minimal("⟬uk_license_plate#2⟭".ToLowerInvariant(), "⟬payment_card#2⟭"));

        Assert.DoesNotContain(_anpr.Registered, p => p.Contains(' ') || p.Any(char.IsLower));
    }
}
⟬end⟭

⟬template⟭
family: code
format: .rb
language: en
fill_locale: en_GB
domain: education
appearance: factory attributes, stubbed HTTP request, assertion
scenario: RSpec job spec for the nightly sync of new teachers to a payroll provider, written by the developer integrating the provider API for a school trust
⟬text⟭
# spec/jobs/payroll_sync_job_spec.rb
require "rails_helper"

RSpec.describe PayrollSyncJob do
  let(:trust) { create(:trust, payroll_provider: "paycircle", payroll_company_ref: "⟬customer_id#1⟭") }
  let!(:teacher) do
    create(:staff_member,
           trust: trust,
           first_name: "⟬person_name:given#2⟭",
           last_name: "⟬person_name:family#2⟭",
           ni_number: "⟬uk_national_insurance_number#2⟭",
           sort_code: "30-96-26",
           account_number: "⟬bank_account_number#2⟭",
           rtw_document: "passport",
           rtw_document_number: "⟬uk_passport#2⟭",
           contract_start: Date.parse("⟬date#2⟭"))
  end

  let(:api) { "https://api.paycircle.example/v3/companies/⟬customer_id#1⟭/employees" }

  before do
    stub_request(:post, api)
      .with(headers: { "Authorization" => "Bearer ⟬opaque_token#3⟭" })
      .to_return(status: 201, body: { id: "emp_7Hq2", status: "pending" }.to_json,
                 headers: { "Content-Type" => "application/json" })
  end

  it "posts new starters with NI number and bank details, never the passport" do
    described_class.perform_now(trust.id)

    expect(WebMock).to(have_requested(:post, api).with do |req|
      body = JSON.parse(req.body)
      body["niNumber"] == "⟬uk_national_insurance_number#2⟭" &&
        body.dig("bank", "accountNumber") == "⟬bank_account_number#2⟭" &&
        !req.body.include?("⟬uk_passport#2⟭")
    end)
    expect(teacher.reload.payroll_ref).to eq("emp_7Hq2")
  end

  it "skips staff without an NI number and records an issue" do
    create(:staff_member, trust: trust, first_name: "⟬person_name:given#3⟭", last_name: "⟬person_name:family#3⟭", ni_number: nil)

    expect { described_class.perform_now(trust.id) }.to change(PayrollSyncIssue, :count).by(1)
    expect(PayrollSyncIssue.last.message).to include("⟬person_name:family#3⟭")
  end
end
⟬end⟭

⟬template⟭
family: code
format: .js
language: en
fill_locale: en_GB
domain: e-commerce
appearance: test table, template literal, curl command, git remote URL
scenario: Jest table for the pre-commit secret guard of an online shop monorepo, written by a security engineer with revoked tokens that keep their real shapes
⟬text⟭
// tools/secret-guard/__tests__/rules.test.js
// The pre-commit guard must flag every line in `flagged`. The tokens were revoked
// on ⟬date#1⟭; do not redact them, the rules need the real shapes.
const { scan } = require('../scan');

const flagged = [
  ['npm automation token in .npmrc', `//registry.npmjs.org/:_authToken=⟬npm_token#1⟭`],
  ['GitHub token in a remote URL', `git remote add origin https://x-access-token:⟬github_token#1⟭@github.com/shopfront/web.git`],
  ['Slack bot token in a constant', `const SLACK = '⟬slack_token#1⟭';`],
  ['npm token inline before a command', `NPM_TOKEN=⟬npm_token#2⟭ npm publish --access restricted`],
  ['GitHub token in a curl header', `curl -H "Authorization: token ⟬github_token#2⟭" https://api.github.com/user`],
  ['Slack token in JSON', `{"notify": {"slack": "⟬slack_token#2⟭"}}`],
];

const allowed = [
  ['env reference', 'NPM_TOKEN=⟬trap:placeholder|${NPM_TOKEN}⟭'],
  ['masked in logs', 'token: ⟬trap:placeholder|xoxb-****⟭'],
  ['TTL setting', '⟬trap:indicator_non_pii|SLACK_TOKEN_TTL=3600⟭'],
  ['header name only', '⟬trap:indicator_non_pii|api_key_header="X-Api-Key"⟭'],
  ['scoped package import', 'import { Button } from "⟬trap:email_lookalike|@shopfront/ui⟭";'],
];

describe('secret-guard rules', () => {
  test.each(flagged)('flags %s', (_label, line) => {
    expect(scan(line).length).toBeGreaterThan(0);
  });

  test.each(allowed)('allows %s', (_label, line) => {
    expect(scan(line)).toEqual([]);
  });

  test('reports the rule and column, never the secret', () => {
    const [finding] = scan(`token=⟬github_token#3⟭`);
    expect(finding).toMatchObject({ rule: 'github-token', column: 6 });
    expect(JSON.stringify(finding)).not.toContain('⟬github_token#3⟭');
  });
});
⟬end⟭

⟬template⟭
family: code
format: .ts
language: en
fill_locale: en_GB
domain: travel
appearance: localStorage value, form fill in e2e test
scenario: Cypress test of the online check-in of a cruise line, where a QA engineer reused a guest session token to skip the slow staging login
⟬text⟭
// cypress/e2e/checkin.cy.ts
describe('online check-in', () => {
  it('captures passport details for the lead guest', () => {
    // staging login takes 20s, so reuse the guest session token
    cy.visit('/checkin/⟬order_number#1⟭', {
      onBeforeLoad: (win) => win.localStorage.setItem('session', '⟬jwt#1⟭'),
    });
    cy.get('[name=givenNames]').type('⟬person_name:given#1⟭');
    cy.get('[name=surname]').type('⟬person_name:family#1⟭');
    cy.get('[name=dob]').type('⟬birth_date#1⟭');
    cy.get('[name=passportNo]').type('⟬uk_passport#1⟭');
    cy.contains('button', 'Continue').click();
    cy.contains('Boarding pass ready').should('be.visible');
  });
});
⟬end⟭

⟬template⟭
family: code
format: .go
language: en
fill_locale: en_GB
domain: e-commerce
appearance: flag help text, log output in comment, SQL string
scenario: one-off Go command of a craft marketplace that copies seller tax details into an encrypted table for the platform reporting rules, with the first dry-run output pasted at the bottom
⟬text⟭
// Command backfill-seller-tax copies NI numbers and payout IBANs from the legacy
// sellers table into the encrypted seller_tax_profile table used by the
// platform report to HMRC. Dry run unless -apply is set.
package main

import (
	"context"
	"database/sql"
	"flag"
	"log"
	"os"

	_ "github.com/jackc/pgx/v5/stdlib"
)

func main() {
	apply := flag.Bool("apply", false, "write rows instead of printing them")
	only := flag.String("seller", "", "limit to one seller id, e.g. ⟬customer_id#1⟭")
	flag.Parse()

	ctx := context.Background()
	db, err := sql.Open("pgx", os.Getenv("DATABASE_URL"))
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	rows, err := db.QueryContext(ctx, `SELECT id, legal_name, ni_number, payout_iban FROM sellers WHERE $1 = '' OR id = $1`, *only)
	if err != nil {
		log.Fatal(err)
	}
	defer rows.Close()

	for rows.Next() {
		var id, name, ni, iban string
		if err := rows.Scan(&id, &name, &ni, &iban); err != nil {
			log.Fatal(err)
		}
		if !*apply {
			log.Printf("would copy seller=%s name=%q ni=%s iban=%s", id, name, mask(ni), mask(iban))
			continue
		}
		if _, err := db.ExecContext(ctx, `INSERT INTO seller_tax_profile (seller_id, ni_enc, iban_enc) VALUES ($1, pgp_sym_encrypt($2, current_setting('app.kek')), pgp_sym_encrypt($3, current_setting('app.kek')))`, id, ni, iban); err != nil {
			log.Fatal(err)
		}
	}
}

func mask(s string) string {
	if len(s) <= 4 {
		return "****"
	}
	return "****" + s[len(s)-4:]
}

// First dry run, before mask() existed:
// ⟬date#1⟭ 09:14:51 would copy seller=⟬customer_id#1⟭ name="⟬person_name#1⟭" ni=⟬uk_national_insurance_number#1⟭ iban=⟬iban#1⟭
⟬end⟭

⟬template⟭
family: code
format: .cs
language: en
fill_locale: en_GB
domain: media
appearance: build parameter default, interpolated string, HTTP header
scenario: NUKE build of a podcast studio web app that writes the client .npmrc and reports to Slack, with both tokens pasted as parameter defaults to unblock a release
⟬text⟭
using System.Net.Http.Json;
using Nuke.Common;
using Nuke.Common.IO;
using Nuke.Common.Tools.DotNet;
using Nuke.Common.Tools.Npm;
using static Nuke.Common.Tools.DotNet.DotNetTasks;
using static Nuke.Common.Tools.Npm.NpmTasks;

class Build : NukeBuild
{
    public static int Main() => Execute<Build>(x => x.Publish);

    [Parameter] readonly string Configuration = "Release";
    // TODO: move both to the CI secret store; pasted here to unblock the ⟬date#1⟭ release
    [Parameter] readonly string NpmToken = "⟬npm_token#1⟭";
    [Parameter] readonly string SlackToken = "⟬slack_token#1⟭";

    AbsolutePath ClientApp => RootDirectory / "src" / "Studio.Web" / "ClientApp";

    Target Frontend => _ => _
        .Executes(() =>
        {
            (ClientApp / ".npmrc").WriteAllText($"//registry.npmjs.org/:_authToken={NpmToken}\n");
            NpmCi(s => s.SetProcessWorkingDirectory(ClientApp));
            NpmRun(s => s.SetProcessWorkingDirectory(ClientApp).SetCommand("build"));
        });

    Target Publish => _ => _
        .DependsOn(Frontend)
        .Executes(() => DotNetPublish(s => s
            .SetProject(RootDirectory / "src" / "Studio.Web")
            .SetConfiguration(Configuration)));

    Target Notify => _ => _
        .TriggeredBy(Publish)
        .AssuredAfterFailure()
        .Executes(async () =>
        {
            var outcome = IsSucceeding ? "passed" : "failed";
            using var http = new HttpClient();
            http.DefaultRequestHeaders.Authorization = new("Bearer", SlackToken);
            await http.PostAsJsonAsync("https://slack.com/api/chat.postMessage",
                new { channel = "#studio-builds", text = $"Studio.Web {Configuration} build {outcome}" });
        });
}
⟬end⟭

⟬template⟭
family: code
format: .js
language: en
fill_locale: en_GB
domain: education
appearance: require call, constant, route handler
scenario: Express route for the course catalogue search of a further education college, written by a backend developer
⟬text⟭
// routes/courses.js
const express = require('express');
const logger = require('⟬trap:library|morgan⟭');
const { createLogger, transports } = require('⟬trap:library|winston⟭');

const router = express.Router();
const log = createLogger({ level: process.env.LOG_LEVEL || 'info', transports: [new transports.Console()] });

const PAGE_SIZE = 20;
const ⟬trap:indicator_non_pii|DEFAULT_TUTOR = 'Staff'⟭;
const CAMPUSES = ['⟬trap:word_name|Albert⟭ Road', 'Riverside', 'Quayside'];

router.use(logger('tiny'));

router.get('/courses', async (req, res, next) => {
  try {
    const page = Math.max(1, Number(req.query.page) || 1);
    const q = String(req.query.q || '').trim().slice(0, 80);
    const campus = CAMPUSES.includes(req.query.campus) ? req.query.campus : undefined;
    const { rows, total } = await req.app.locals.catalogue.search({
      q,
      level: req.query.level, // gcse, a-level, access, adult
      campus,
      limit: PAGE_SIZE,
      offset: (page - 1) * PAGE_SIZE,
    });
    res.json({
      page,
      pages: Math.ceil(total / PAGE_SIZE),
      results: rows.map((c) => ({ code: c.code, title: c.title, tutor: c.tutor_display || DEFAULT_TUTOR, starts: c.starts_on })),
    });
  } catch (err) {
    log.error('course search failed', { q: req.query.q, err: err.message });
    next(err);
  }
});

module.exports = router;
⟬end⟭

⟬template⟭
family: code
format: .go
language: en
fill_locale: en_GB
domain: logistics
appearance: doc comment, function
scenario: delivery round planner of a regional parcel carrier using the savings heuristic, written by the routing engineer before road distances were wired in
⟬text⟭
// Package routing builds delivery rounds for the van fleet with the
// ⟬trap:eponym|Clarke-Wright⟭ savings heuristic. Rounds start and end at the depot
// and never exceed van capacity in parcels.
//
// ⟬trap:indicator_non_pii|Contact: #routing on Slack⟭
package routing

import (
	"math"
	"sort"
)

type Stop struct {
	ID       string
	Lat, Lon float64
	Parcels  int
}

type Round struct {
	Stops []Stop
	Load  int
}

type saving struct {
	i, j  int
	value float64
}

// Plan merges single-stop rounds in order of decreasing saving.
func Plan(depot Stop, stops []Stop, capacity int) []Round {
	n := len(stops)
	rounds := make([]*Round, n)
	owner := make([]int, n)
	for i, s := range stops {
		rounds[i] = &Round{Stops: []Stop{s}, Load: s.Parcels}
		owner[i] = i
	}

	var savings []saving
	for i := 0; i < n; i++ {
		for j := i + 1; j < n; j++ {
			v := dist(depot, stops[i]) + dist(depot, stops[j]) - dist(stops[i], stops[j])
			savings = append(savings, saving{i, j, v})
		}
	}
	sort.Slice(savings, func(a, b int) bool { return savings[a].value > savings[b].value })

	for _, s := range savings {
		ri, rj := owner[s.i], owner[s.j]
		if ri == rj || rounds[ri] == nil || rounds[rj] == nil {
			continue
		}
		a, b := rounds[ri], rounds[rj]
		if a.Load+b.Load > capacity || !endsWith(a, stops[s.i].ID) || !startsWith(b, stops[s.j].ID) {
			continue
		}
		a.Stops = append(a.Stops, b.Stops...)
		a.Load += b.Load
		for k := range owner {
			if owner[k] == rj {
				owner[k] = ri
			}
		}
		rounds[rj] = nil
	}

	var out []Round
	for _, r := range rounds {
		if r != nil {
			out = append(out, *r)
		}
	}
	return out
}

func endsWith(r *Round, id string) bool   { return r.Stops[len(r.Stops)-1].ID == id }
func startsWith(r *Round, id string) bool { return r.Stops[0].ID == id }

// dist is the great-circle distance in km; road distances replace it once the
// routing engine is deployed (⟬ticket_id#1⟭).
func dist(a, b Stop) float64 {
	const earthKm = 6371.0
	dLat := (b.Lat - a.Lat) * math.Pi / 180
	dLon := (b.Lon - a.Lon) * math.Pi / 180
	h := math.Sin(dLat/2)*math.Sin(dLat/2) +
		math.Cos(a.Lat*math.Pi/180)*math.Cos(b.Lat*math.Pi/180)*math.Sin(dLon/2)*math.Sin(dLon/2)
	return 2 * earthKm * math.Asin(math.Sqrt(h))
}
⟬end⟭

⟬template⟭
family: code
format: .rb
language: en
fill_locale: en_GB
domain: energy
appearance: require, environment fallback, route
scenario: tiny Sinatra backend for the public status page of an energy tariff comparison API, written by the on-call developer
⟬text⟭
# status.rb, backend of the public status page for the tariff comparison API
require "⟬trap:library|sinatra⟭"
require "⟬trap:library|faraday⟭"
require "json"

UPSTREAM = Faraday.new(url: ENV.fetch("TARIFF_API_URL", "⟬url#1⟭")) do |f|
  f.request :authorization, "Bearer", ENV.fetch("TARIFF_API_KEY", "⟬trap:placeholder|changeme⟭")
  f.options.timeout = 3
end

get "/status" do
  content_type :json
  healthy = (UPSTREAM.get("/health").status == 200 rescue false)
  { api: "ok", tariffs: healthy ? "ok" : "degraded", version: "⟬version#1⟭" }.to_json
end
⟬end⟭

⟬template⟭
family: code
format: .java
language: en
fill_locale: en_GB
domain: media
appearance: constant, Javadoc, comment
scenario: thumbnail generator of a news site image service with a resampling kernel ported from the old CMS, written by a developer on the content platform team
⟬text⟭
package uk.co.dailyledger.images;

import java.awt.image.BufferedImage;

/**
 * Builds article thumbnails at the widths the front end requests.
 * Downscaling uses a ⟬trap:eponym|Lanczos⟭-3 kernel: bilinear looked soft on chart labels.
 * Ported from {@code ⟬trap:code_identifier|⦃Family⦄Resampler⟭} in the old CMS, minus the colour bugs.
 */
public final class Thumbnailer {

    public static final int[] WIDTHS = {320, 640, 1280};
    static final String ⟬trap:indicator_non_pii|DEFAULT_CREDIT = "Photo: handout"⟭;
    private static final int A = 3;

    public BufferedImage resizeWidth(BufferedImage src, int width) {
        int height = Math.round((float) src.getHeight() * width / src.getWidth());
        BufferedImage out = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        double scale = (double) src.getWidth() / width;
        for (int y = 0; y < height; y++) {
            int sy = Math.min(src.getHeight() - 1, (int) (y * scale));
            for (int x = 0; x < width; x++) {
                double center = (x + 0.5) * scale;
                double r = 0, g = 0, b = 0, total = 0;
                for (int sx = (int) Math.floor(center - A * scale); sx <= (int) Math.ceil(center + A * scale); sx++) {
                    if (sx < 0 || sx >= src.getWidth()) continue;
                    double w = kernel((sx + 0.5 - center) / scale);
                    int rgb = src.getRGB(sx, sy);
                    r += w * ((rgb >> 16) & 0xff);
                    g += w * ((rgb >> 8) & 0xff);
                    b += w * (rgb & 0xff);
                    total += w;
                }
                out.setRGB(x, y, pack(r / total, g / total, b / total));
            }
        }
        return out;
    }

    public static String creditLine(String credit) {
        return credit == null || credit.isBlank() ? DEFAULT_CREDIT : credit;
    }

    static double kernel(double x) {
        if (x == 0) return 1;
        if (Math.abs(x) >= A) return 0;
        double px = Math.PI * x;
        return A * Math.sin(px) * Math.sin(px / A) / (px * px);
    }

    private static int pack(double r, double g, double b) {
        return (clamp(r) << 16) | (clamp(g) << 8) | clamp(b);
    }

    private static int clamp(double v) {
        return (int) Math.max(0, Math.min(255, Math.round(v)));
    }
}
⟬end⟭

⟬template⟭
family: code
format: .ts
language: en
fill_locale: en_GB
domain: travel
appearance: lookup table, constant, regular expression
scenario: aircraft seat layouts of a charter airline booking site, used to draw the seat map, written by a frontend developer
⟬text⟭
// seatmap/layouts.ts
export type Cabin = { rows: [number, number]; letters: string; exitRows?: number[] };

export const LAYOUTS: Record<string, { name: string; cabins: Cabin[] }> = {
  B738: { name: '⟬trap:company_name|Boeing⟭ 737-800', cabins: [{ rows: [1, 33], letters: 'ABC DEF', exitRows: [16, 17] }] },
  A320: { name: 'Airbus A320', cabins: [{ rows: [1, 30], letters: 'ABC DEF', exitRows: [11, 12] }] },
  F100: { name: '⟬trap:company_name|Fokker⟭ 100', cabins: [{ rows: [1, 22], letters: 'AC DEF' }] },
  E195: { name: 'Embraer 195', cabins: [{ rows: [1, 2], letters: 'AC DF' }, { rows: [3, 28], letters: 'AC DF', exitRows: [11] }] },
};

// seats held back for crew rest on long sectors
export const ⟬trap:indicator_non_pii|BLOCKED_SEAT_HOLDER = 'crew-rest'⟭;

export function seatIds(code: string): string[] {
  const layout = LAYOUTS[code];
  if (!layout) throw new Error(`unknown aircraft ${code}`);
  return layout.cabins.flatMap((c) => {
    const letters = c.letters.replace(/ /g, '').split('');
    const ids: string[] = [];
    for (let r = c.rows[0]; r <= c.rows[1]; r += 1) {
      if (r === 13) continue; // no row 13 on our fleet
      for (const l of letters) ids.push(`${r}${l}`);
    }
    return ids;
  });
}
⟬end⟭
