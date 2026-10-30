⟬template⟭
family: code
format: .js
language: en
fill_locale: en_GB
domain: e-commerce
appearance: recorded API response in comment, middleware
scenario: Express middleware of an online hardware store that requires an ID check before dispatching knives and solvents, with the vendor sandbox response kept in the header by the developer
⟬text⟭
// src/middleware/age-verification.js
//
// Knives, solvents and alcohol need a verified adult before dispatch. The ID
// check vendor matches the licence photo to a selfie and returns the date of
// birth; we keep the verdict and the check id, never the document number.
//
// Recorded sandbox response (POST /v2/checks), kept for the tests:
//
//   {
//     "check_id": "⟬uuid#1⟭",
//     "result": "clear",
//     "document": {
//       "type": "driving_licence",
//       "issuer": "DVLA",
//       "number": "⟬uk_driving_licence#1⟭",
//       "full_name": "⟬person_name#1⟭",
//       "date_of_birth": "⟬birth_date#1⟭",
//       "address": "⟬postal_address#1⟭"
//     },
//     "checked_at": "⟬date#1⟭"
//   }

const RESTRICTED = new Set(['knives', 'solvents', 'alcohol']);
const MIN_AGE = 18;

function ageOn(dob, day) {
  const d = new Date(dob);
  const age = day.getFullYear() - d.getFullYear();
  const beforeBirthday = day.getMonth() < d.getMonth() || (day.getMonth() === d.getMonth() && day.getDate() < d.getDate());
  return beforeBirthday ? age - 1 : age;
}

module.exports = function ageVerification(idCheck) {
  return async function verifyAge(req, res, next) {
    const { basket } = req.session;
    if (!basket.lines.some((line) => RESTRICTED.has(line.category))) return next();
    if (req.session.ageCheck?.result === 'clear') return next();

    const check = await idCheck.run({ documentImage: req.body.documentImage, selfie: req.body.selfie });
    if (check.result !== 'clear' || ageOn(check.document.date_of_birth, new Date()) < MIN_AGE) {
      return res.status(403).json({ error: 'age_not_verified', checkId: check.check_id });
    }
    req.session.ageCheck = { result: 'clear', checkId: check.check_id, at: check.checked_at };
    return next();
  };
};
⟬end⟭

⟬template⟭
family: code
format: .cs
language: en
fill_locale: en_GB
domain: logistics
appearance: constant, exception message in comment, stack trace
scenario: Hangfire job of a same-day courier that re-checks every driver licence each month and suspends failures, with an old exception pasted from the dashboard by the developer who fixed it
⟬text⟭
using Hangfire;
using Microsoft.Extensions.Logging;
using SlackNet;
using SlackNet.WebApi;

namespace Swiftdrop.Drivers.Jobs;

/// <summary>Monthly check of every active driver's licence against the DVLA view service.</summary>
public class LicenceRecheckJob(IDriverRepository drivers, ILicenceCheckClient dvla, ILogger<LicenceRecheckJob> log)
{
    // ops-alerts bot; the workspace admin will move it to Key Vault "soon"
    private static readonly ISlackApiClient Slack = new SlackServiceBuilder().UseApiToken("⟬slack_token#1⟭").GetApiClient();

    [AutomaticRetry(Attempts = 2)]
    public async Task RunAsync(CancellationToken ct)
    {
        var suspended = new List<string>();
        await foreach (var driver in drivers.ActiveAsync(ct))
        {
            var result = await dvla.CheckAsync(driver.LicenceNumber, driver.CheckCode, ct);
            if (result.Status == LicenceStatus.Valid && result.Points < 9)
                continue;

            driver.Suspend(SuspensionReason.LicenceCheck);
            suspended.Add(driver.Id);
            log.LogWarning("Driver {DriverId} suspended after licence check: {Status}, {Points} points", driver.Id, result.Status, result.Points);
        }
        await drivers.SaveAsync(ct);

        if (suspended.Count > 0)
        {
            await Slack.Chat.PostMessage(new Message
            {
                Channel = "#driver-ops",
                Text = $"{suspended.Count} drivers suspended after the monthly licence check: {string.Join(", ", suspended)}",
            });
        }
    }
}

// What the job threw before LicenceCheckException stopped carrying the number
// (from the Hangfire dashboard, ⟬ticket_id#1⟭):
//
// Swiftdrop.Drivers.LicenceCheckException: Licence ⟬uk_driving_licence#1⟭ for ⟬person_name#1⟭ returned REVOKED (check code expired)
//    at Swiftdrop.Drivers.Dvla.LicenceCheckClient.CheckAsync(String licenceNumber, String checkCode, CancellationToken ct)
//    at Swiftdrop.Drivers.Jobs.LicenceRecheckJob.RunAsync(CancellationToken ct)
⟬end⟭

⟬template⟭
family: code
format: .cs
language: en
fill_locale: en_GB
domain: education
appearance: object initializer, collection expression, assertion on CSV line
scenario: xUnit tests of the passenger manifest a secondary school sends to the coach operator for a ski trip, with a pupil and the trip leader typed in from the consent forms
⟬text⟭
using Hillcrest.Trips;
using Xunit;

namespace Hillcrest.Trips.Tests;

public class TripManifestTests
{
    // Year 9 ski trip: one pupil and the trip leader, typed in from the consent
    // forms for the operator's dry run on ⟬date#3⟭.
    private static Trip SkiTrip() => new()
    {
        Code = "SKI-Y9-AOSTA",
        Departs = new DateOnly(2026, 2, 14),
        Participants =
        [
            new Participant
            {
                Role = Role.Pupil,
                Surname = "⟬person_name:family#1⟭",
                Forenames = "⟬person_name:given#1f⟭",
                DateOfBirth = DateOnly.Parse("⟬birth_date#1⟭"),
                PassportNumber = "⟬uk_passport#1⟭",
                PassportExpiry = DateOnly.Parse("⟬date#1⟭"),
                EmergencyContactName = "⟬person_name#3⟭",
                EmergencyContactPhone = "⟬phone#3⟭",
                Medical = "Allergic to penicillin",
            },
            new Participant
            {
                Role = Role.Staff,
                Surname = "⟬person_name:family#2⟭",
                Forenames = "⟬person_name:given#2m⟭",
                DateOfBirth = DateOnly.Parse("⟬birth_date#2⟭"),
                PassportNumber = "⟬uk_passport#2⟭",
                PassportExpiry = DateOnly.Parse("⟬date#2⟭"),
                EmergencyContactName = "⟬person_name#4⟭",
                EmergencyContactPhone = "⟬phone#4⟭",
            },
        ],
    };

    [Fact]
    public void Staff_come_first_and_names_are_quoted()
    {
        var lines = TripManifest.ToCsv(SkiTrip()).Split(Environment.NewLine, StringSplitOptions.RemoveEmptyEntries);

        Assert.Equal("role,surname,forenames,dob,passport,passport_expiry,emergency_contact,emergency_phone", lines[0]);
        Assert.StartsWith("staff,\"⟬person_name:family#2⟭\"", lines[1]);
        Assert.StartsWith("pupil,\"⟬person_name:family#1⟭\"", lines[2]);
        Assert.Contains(",⟬uk_passport#1⟭,", lines[2]);
        Assert.EndsWith(",\"⟬person_name#3⟭\",⟬phone#3⟭", lines[2]);
    }

    [Fact]
    public void Nothing_medical_reaches_the_operator()
    {
        var csv = TripManifest.ToCsv(SkiTrip());

        Assert.DoesNotContain("penicillin", csv, StringComparison.OrdinalIgnoreCase);
    }

    [Fact]
    public void A_passport_expiring_before_return_is_flagged()
    {
        var trip = SkiTrip();
        trip.Participants[1].PassportExpiry = trip.Departs.AddDays(3);

        var problems = TripManifest.Validate(trip);

        Assert.Single(problems);
        Assert.Contains("⟬person_name:family#2⟭", problems[0]);
    }
}
⟬end⟭

⟬template⟭
family: code
format: .go
language: en
fill_locale: en_GB
domain: media
appearance: constant, struct tags, JSON in comment
scenario: Go client with which the sports desk of a news group submits press accreditation to stadium security, written by a developer with the integrator token and a dry-run batch in comments
⟬text⟭
package accreditation

import (
	"bytes"
	"context"
	"encoding/json"
	"fmt"
	"net/http"
)

// Stadium security wants passport details 72 hours before kick-off for every
// accredited reporter and photographer. The integrator issued a long-lived
// token; it sits here until the secrets store is wired in.
const venueToken = "⟬jwt#1⟭"

type Applicant struct {
	FullName    string `json:"full_name"`
	Outlet      string `json:"outlet"`
	Role        string `json:"role"` // reporter, photographer, broadcast
	Passport    string `json:"passport_number"`
	Nationality string `json:"nationality"`
	DOB         string `json:"date_of_birth"`
	Email       string `json:"email"`
}

type Client struct {
	BaseURL string
	HTTP    *http.Client
}

// Submit sends one batch per fixture. The venue answers 202 and emails the
// passes to each applicant once their check clears.
func (c *Client) Submit(ctx context.Context, fixture string, people []Applicant) error {
	body, err := json.Marshal(map[string]any{"fixture": fixture, "applicants": people})
	if err != nil {
		return err
	}
	req, err := http.NewRequestWithContext(ctx, http.MethodPost, c.BaseURL+"/v1/accreditation/batches", bytes.NewReader(body))
	if err != nil {
		return err
	}
	req.Header.Set("Authorization", "Bearer "+venueToken)
	req.Header.Set("Content-Type", "application/json")

	res, err := c.HTTP.Do(req)
	if err != nil {
		return err
	}
	defer res.Body.Close()
	if res.StatusCode != http.StatusAccepted {
		return fmt.Errorf("venue refused batch for %s: %s", fixture, res.Status)
	}
	return nil
}

// Dry run before the cup final, as logged:
//   {"fixture":"CUP-F","applicants":[{"full_name":"⟬person_name#1⟭","outlet":"Coastline Sport","role":"photographer","passport_number":"⟬uk_passport#1⟭","nationality":"GBR","date_of_birth":"⟬birth_date#1⟭","email":"⟬email#1⟭"}]}
⟬end⟭

⟬template⟭
family: code
format: .ts
language: en
fill_locale: en_GB
domain: energy
appearance: fallback default, example call in comment
scenario: helper of an EV charging network that asks the car park operator to waive parking while a car charges, written by a developer integrating a retail park site
⟬text⟭
// Asks the car park operator to waive the parking fee while a car charges on
// one of our bays. Their API keys the exemption on the registration the driver typed.
const OPERATOR_TOKEN = process.env.CARPARK_TOKEN ?? '⟬jwt#1⟭';

export async function waiveWhileCharging(session: ChargeSession): Promise<void> {
  await fetch(`https://⟬hostname#1⟭/v3/sites/${session.siteId}/exemptions`, {
    method: 'POST',
    headers: { authorization: `Bearer ${OPERATOR_TOKEN}`, 'content-type': 'application/json' },
    body: JSON.stringify({ vrm: session.vehicleReg, from: session.startedAt, until: session.endsAt }),
  });
}

// waiveWhileCharging({ siteId: 'BRS-07', vehicleReg: '⟬uk_license_plate#1⟭', startedAt: '2025-06-02T08:14:00Z', endsAt: '2025-06-02T10:14:00Z' })
⟬end⟭

⟬template⟭
family: code
format: .rb
language: en
fill_locale: en_GB
domain: e-commerce
appearance: log lines in comment, name in prose
scenario: Rails controller behind the "I'm here" button of a click and collect service, with production log lines a developer pasted after a store trial
⟬text⟭
# app/controllers/collect/arrivals_controller.rb
#
# "I'm here" button on the collection email. The customer types the car
# registration and the bay number; the store tablet shows them to the
# colleague who walks the order out.
module Collect
  class ArrivalsController < ApplicationController
    skip_before_action :authenticate_customer!
    before_action :load_order_from_signed_id

    def create
      arrival = @order.arrivals.create!(arrival_params.merge(arrived_at: Time.current))
      StoreChannel.broadcast_to(@order.store, type: "arrival", order: @order.number, reg: arrival.vehicle_reg, bay: arrival.bay)
      Rails.logger.info("[collect] arrival order=#{@order.number} reg=#{arrival.vehicle_reg} bay=#{arrival.bay}")
      head :created
    end

    private

    def arrival_params
      params.require(:arrival).permit(:vehicle_reg, :bay, :colour)
    end

    def load_order_from_signed_id
      @order = Order.find_signed!(params[:order_token], purpose: :collect)
    rescue ActiveSupport::MessageVerifier::InvalidSignature
      head :not_found
    end
  end
end

# Store trial, ⟬date#1⟭. From production.log:
# I, [2025-05-17T11:42:07.312 #1823]  INFO -- : [collect] arrival order=⟬order_number#1⟭ reg=⟬uk_license_plate#1⟭ bay=4
# I, [2025-05-17T11:42:07.330 #1823]  INFO -- : StoreChannel broadcast to store 112: {"order":"⟬order_number#1⟭","reg":"⟬uk_license_plate#1⟭","bay":"4"}
# Nobody came out because the tablet was asleep; ⟬person_name#1⟭ rang the store from bay 4 on ⟬phone#1⟭.
⟬end⟭

⟬template⟭
family: code
format: .go
language: en
fill_locale: en_GB
domain: energy
appearance: struct literal, test assertion
scenario: Go test of the bank transfer file for Smart Export Guarantee payouts of an energy supplier, written by the payments developer with two solar customers who asked for cash
⟬text⟭
package seg

import (
	"encoding/csv"
	"strings"
	"testing"
)

func TestWriteTreasuryFile(t *testing.T) {
	payouts := []Payout{
		{Account: "⟬customer_id#1⟭", Holder: "⟬person_name#1⟭", IBAN: "⟬iban#1⟭", Pence: 18342, Quarter: "2025Q2"},
		{Account: "⟬customer_id#2⟭", Holder: "⟬person_name#2⟭", IBAN: "⟬iban#2⟭", Pence: 960, Quarter: "2025Q2"},
	}

	var b strings.Builder
	if err := WriteTreasuryFile(&b, payouts); err != nil {
		t.Fatal(err)
	}
	rows, err := csv.NewReader(strings.NewReader(b.String())).ReadAll()
	if err != nil {
		t.Fatalf("treasury file is not valid CSV: %v", err)
	}

	if got := strings.Join(rows[0], ","); got != "beneficiary_name,iban,amount,reference" {
		t.Errorf("header = %q", got)
	}
	if rows[1][0] != "⟬person_name#1⟭" || rows[1][1] != "⟬iban#1⟭" || rows[1][2] != "183.42" {
		t.Errorf("first payout row = %q", rows[1])
	}
	if rows[2][2] != "9.60" || rows[2][3] != "SEG 2025Q2 ⟬customer_id#2⟭" {
		t.Errorf("second payout row = %q", rows[2])
	}
}
⟬end⟭

⟬template⟭
family: code
format: .java
language: en
fill_locale: en_GB
domain: education
appearance: constructor arguments, assertion
scenario: JUnit test of the processor that refunds overpaid tuition to the account the sponsor paid from, written by a developer in the finance systems team of a university
⟬text⟭
package ac.uk.northfield.finance.refunds;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

import java.math.BigDecimal;
import org.junit.jupiter.api.Test;

class TuitionRefundProcessorTest {

    private final TuitionRefundProcessor processor = new TuitionRefundProcessor(new BigDecimal("25.00"));

    // Student withdrew in week 3; the refund goes back to the account the sponsor paid from.
    private static Overpayment overpayment() {
        return new Overpayment(
            "⟬customer_id#1⟭",
            "⟬person_name#1⟭",
            "⟬email#1⟭",
            new BigDecimal("4250.00"),
            "⟬iban#1⟭",
            "⟬bic#1⟭");
    }

    @Test
    void paysTheSponsorAccountAndKeepsTheStudentReference() throws Exception {
        PaymentInstruction out = processor.process(overpayment());

        assertThat(out.creditorIban()).isEqualTo("⟬iban#1⟭");
        assertThat(out.amount()).isEqualByComparingTo("4250.00");
        assertThat(out.remittance()).isEqualTo("REFUND ⟬customer_id#1⟭");
        assertThat(out.notifyEmail()).isEqualTo("⟬email#1⟭");
    }

    @Test
    void skipsRefundsBelowTheBankFee() throws Exception {
        assertThat(processor.process(overpayment().withAmount(new BigDecimal("12.00")))).isNull();
    }

    @Test
    void refusesAnIbanThatFailsTheChecksum() {
        Overpayment bad = overpayment().withIban("⟬trap:placeholder|GB00 XXXX 0000 0000 0000 00⟭");

        assertThatThrownBy(() -> processor.process(bad))
            .isInstanceOf(InvalidIbanException.class)
            .hasMessageNotContaining("⟬iban#1⟭");
    }
}
⟬end⟭

⟬template⟭
family: code
format: .cs
language: en
fill_locale: en_GB
domain: energy
appearance: delimited records in raw string literal, assertion
scenario: xUnit tests of the parser for the Fuel Direct deduction schedule an energy supplier receives from the benefits agency, with two detail lines from the pilot file
⟬text⟭
using Voltline.Billing.FuelDirect;
using Xunit;

namespace Voltline.Billing.Tests.FuelDirect;

public class ScheduleParserTests
{
    // Two detail lines from the pilot schedule, with the header and the trailer
    // kept so the record count and the total line up.
    private const string Schedule = """
        H|FD|⟬date#2⟭|SUPPLIER 4471|000002
        D|⟬uk_national_insurance_number#1⟭|⟬person_name:family#1⟭|⟬person_name:given#1⟭|⟬postal_address#1⟭|GAS|00385|⟬date#1⟭
        D|⟬uk_national_insurance_number#2⟭|⟬person_name:family#2⟭|⟬person_name:given#2⟭|⟬postal_address#2⟭|ELEC|00385|⟬date#1⟭
        T|000002|00770
        """;

    [Fact]
    public void Reads_detail_lines_and_checks_the_trailer()
    {
        var schedule = ScheduleParser.Parse(Schedule);

        Assert.Equal(2, schedule.Deductions.Count);
        Assert.Equal("⟬uk_national_insurance_number#1⟭", schedule.Deductions[0].Nino);
        Assert.Equal(Fuel.Gas, schedule.Deductions[0].Fuel);
        Assert.Equal(3.85m, schedule.Deductions[0].WeeklyAmount);
    }

    [Fact]
    public void Matches_customers_on_nino_then_surname()
    {
        var accounts = new FakeAccounts(new Account("⟬customer_id#1⟭", "⟬uk_national_insurance_number#1⟭", "⟬person_name:family#1⟭"));

        var result = new DeductionMatcher(accounts).Match(ScheduleParser.Parse(Schedule));

        Assert.Equal("⟬customer_id#1⟭", Assert.Single(result.Matched).AccountId);
        Assert.Single(result.Unmatched); // the second line goes to the manual queue
    }

    [Fact]
    public void Rejects_a_schedule_whose_trailer_total_is_wrong()
    {
        var broken = Schedule.Replace("T|000002|00770", "T|000002|00771");

        Assert.Throws<ScheduleFormatException>(() => ScheduleParser.Parse(broken));
    }
}
⟬end⟭

⟬template⟭
family: code
format: .rb
language: en
fill_locale: en_GB
domain: media
appearance: let block, keyword arguments, mail matcher
scenario: RSpec spec of the IR35 status determination for freelance presenters and crew of a radio group, written by a developer on the contractor compliance project
⟬text⟭
# spec/services/ir35/status_determination_spec.rb
require "rails_helper"

RSpec.describe Ir35::StatusDetermination do
  # Breakfast presenter on a rolling contract: set hours in the studio, our kit,
  # no right to send a substitute. Inside IR35 every time.
  let(:presenter) do
    Contractor.new(
      name: "⟬person_name#1⟭",
      email: "⟬email#1⟭",
      ni_number: "⟬uk_national_insurance_number#1⟭",
      engaged_via: :personal_service_company,
      company_name: "⟬trap:company_name|⦃Family⦄ Media Ltd⟭",
      day_rate: 450,
    )
  end

  let(:engagement) do
    Engagement.new(
      contractor: presenter,
      programme: "Breakfast",
      ⟬trap:indicator_non_pii|owner: "talent-bookings"⟭,
      substitution_allowed: false,
      own_equipment: false,
      control_over_hours: :engager,
      mutuality_of_obligation: true,
    )
  end

  it "finds the breakfast presenter inside IR35" do
    result = described_class.call(engagement)

    expect(result.status).to eq(:inside)
    expect(result.reasons).to include(:no_substitution, :engager_controls_hours)
  end

  it "sends the statement to the presenter and to the agency" do
    expect { described_class.call(engagement) }
      .to have_enqueued_mail(Ir35Mailer, :determination_statement)
      .with(a_hash_including(to: ["⟬email#1⟭", "⟬email:generic#2⟭"]))
  end

  it "keeps the NI number out of the statement PDF" do
    pdf = described_class.call(engagement).statement_pdf

    expect(PDF::Reader.new(StringIO.new(pdf)).pages.map(&:text).join).not_to include("⟬uk_national_insurance_number#1⟭")
  end

  context "with a sound engineer who brings her own desk and may send a substitute" do
    let(:engineer) do
      Contractor.new(name: "⟬person_name#3f⟭", ni_number: "⟬uk_national_insurance_number#3⟭", engaged_via: :sole_trader, day_rate: 320)
    end

    it "is outside IR35" do
      e = Engagement.new(contractor: engineer, programme: "Live sessions", substitution_allowed: true,
                         own_equipment: true, control_over_hours: :contractor, mutuality_of_obligation: false)

      expect(described_class.call(e).status).to eq(:outside)
    end
  end
end
⟬end⟭

⟬template⟭
family: code
format: .cs
language: en
fill_locale: en_GB
domain: media
appearance: constant, commit trailers in comment, verbatim regex
scenario: nightly Azure Function of a newspaper that rebuilds the style guide changelog from commit trailers, written by a developer with a fine-grained token in a constant
⟬text⟭
using System.Net.Http.Headers;
using System.Net.Http.Json;
using System.Text.Json;
using System.Text.RegularExpressions;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Extensions.Logging;

namespace Ledger.StyleGuide.Sync;

/// <summary>
/// Rebuilds the "What changed" page of the newsroom style guide from the commits
/// on the style-guide repo. Each entry credits the editor who made the change
/// and anyone in a Co-authored-by or Signed-off-by trailer.
/// </summary>
public partial class ChangelogFunction(IHttpClientFactory http, IChangelogStore store, ILogger<ChangelogFunction> log)
{
    // fine-grained PAT, contents:read on ledger-newsroom/style-guide only.
    // TODO: Key Vault reference. local.settings.json is gitignored, this file is not.
    private const string GitHubToken = "⟬github_token#1⟭";

    [GeneratedRegex(@"^(Co-authored-by|Signed-off-by):\s*(?<name>.+?)\s*<(?<email>[^>]+)>\s*$", RegexOptions.Multiline)]
    private static partial Regex Trailer();

    [Function("RebuildChangelog")]
    public async Task RunAsync([TimerTrigger("0 15 2 * * *")] TimerInfo timer, CancellationToken ct)
    {
        var client = http.CreateClient("github");
        client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", GitHubToken);
        client.DefaultRequestHeaders.UserAgent.ParseAdd("ledger-styleguide-sync/1.0");

        var since = await store.LastSyncAsync(ct);
        var commits = await client.GetFromJsonAsync<JsonElement[]>(
            $"https://api.github.com/repos/ledger-newsroom/style-guide/commits?since={since:O}&per_page=100", ct) ?? [];

        var entries = commits.Select(ToEntry).OfType<ChangelogEntry>().ToList();
        await store.AppendAsync(entries, ct);
        log.LogInformation("Added {Count} changelog entries since {Since}", entries.Count, since);
    }

    internal static ChangelogEntry? ToEntry(JsonElement commit)
    {
        var detail = commit.GetProperty("commit");
        var message = detail.GetProperty("message").GetString() ?? "";
        var title = message.Split('\n')[0];
        if (title.StartsWith("chore", StringComparison.OrdinalIgnoreCase))
            return null;

        var credits = Trailer().Matches(message)
            .Select(m => m.Groups["name"].Value)
            .Where(name => !name.EndsWith("[bot]", StringComparison.Ordinal))
            .Prepend(detail.GetProperty("author").GetProperty("name").GetString()!)
            .Distinct()
            .ToList();
        return new ChangelogEntry(commit.GetProperty("sha").GetString()!, title, credits);
    }
}

/*
The commit the parser was written against (git log -1 on the style-guide repo):

commit ⟬git_sha#1⟭
Author: ⟬person_name#1⟭ <⟬email#1⟭>
Date:   ⟬date#1⟭

    Hyphenate "climate-related" in headlines, lower case in body copy

    Agreed at the Monday standards meeting.

    Co-authored-by: ⟬person_name#2⟭ <⟬email#2⟭>
    Co-authored-by: ⟬trap:indicator_non_pii|github-actions[bot]⟭ <⟬email:generic#3⟭>
    Signed-off-by: ⟬person_name#1⟭ <⟬email#1⟭>
*/
⟬end⟭

⟬template⟭
family: code
format: .js
language: en
fill_locale: en_GB
domain: energy
appearance: template literal in HTTP header, fallback default
scenario: CI pre-check of an energy supplier's front-end builds that fails fast when an agent cannot reach the private registries, with the read-only tokens of the hackathon laptops as fallbacks
⟬text⟭
#!/usr/bin/env node
// ci/check-registries.js: fail fast when a build agent cannot reach the private
// registries, instead of a ten-minute npm ci timeout. Tokens come from the agent
// env; the fallbacks are the read-only ones issued for the hackathon laptops.

const checks = [
  {
    ⟬trap:indicator_non_pii|name: 'npm (private scope)'⟭,
    url: 'https://registry.npmjs.org/⟬trap:email_lookalike|@voltline/tariff-ui⟭',
    headers: { Authorization: `Bearer ${process.env.NPM_TOKEN || '⟬npm_token#1⟭'}` },
  },
  {
    name: 'GitHub Packages',
    url: 'https://npm.pkg.github.com/⟬trap:email_lookalike|@voltline/meter-sdk⟭',
    headers: { Authorization: `token ${process.env.GH_PACKAGES_TOKEN || '⟬github_token#1⟭'}` },
  },
];

(async () => {
  let failed = 0;
  for (const c of checks) {
    const res = await fetch(c.url, { headers: { ...c.headers, accept: 'application/vnd.npm.install-v1+json' } })
      .catch((e) => ({ ok: false, status: e.code }));
    console.log(`${res.ok ? 'ok  ' : 'FAIL'} ${c.name} (${res.status})`);
    if (!res.ok) failed += 1;
  }
  process.exit(failed ? 1 : 0);
})();
⟬end⟭

⟬template⟭
family: code
format: .ts
language: en
fill_locale: en_GB
domain: travel
appearance: YAML in template literal, fallback default
scenario: install script of a ski holiday site that writes the Yarn registry auth before Vercel installs packages, added by a front-end developer for preview builds
⟬text⟭
// scripts/write-yarnrc.ts: Vercel runs the install before our env reaches the
// shell, so this is the install command and writes the registry auth first.
import { writeFileSync } from 'node:fs';

const token = process.env.NPM_AUTH_TOKEN ?? '⟬npm_token#1⟭'; // ⟬trap:initials|AK⟭: previews only, remove before launch

writeFileSync('.yarnrc.yml', `nodeLinker: node-modules
npmScopes:
  alpine-escapes:
    npmRegistryServer: "https://registry.npmjs.org"
    npmAuthToken: "${token}"
enableTelemetry: false
`);
console.log('wrote .yarnrc.yml for ⟬trap:email_lookalike|@alpine-escapes⟭');
⟬end⟭

⟬template⟭
family: code
format: .ts
language: en
fill_locale: en_GB
domain: media
appearance: headerless CSV in template literal, assertion
scenario: Vitest suite of the script that moves a magazine's legacy subscribers from the old fulfilment house export to the new billing provider, written by a developer on the subscriptions team
⟬text⟭
// scripts/migrate-legacy-subscribers.test.ts
import { describe, expect, it } from 'vitest';
import { parseLegacyRow, toBillingCustomer } from './migrate-legacy-subscribers';

// The old fulfilment house exported subscribers as headerless CSV: id, name,
// email, street, town, postcode, card, expiry, title, renewal. Lines from their sample file.
const SAMPLE = `⟬customer_id#1⟭,"⟬person_name#1⟭",⟬email#1⟭,"⟬postal_address:street#1⟭",⟬city#1⟭,⟬postcode#1⟭,⟬payment_card#1⟭,08/27,WKLY,"⟬date#1⟭"
⟬customer_id#2⟭,"⟬person_name#2⟭",⟬email#2⟭,"⟬postal_address:street#2⟭",⟬city#2⟭,⟬postcode#2⟭,⟬payment_card#2⟭,11/26,QTLY,"⟬date#2⟭"
⟬customer_id#3⟭,"⟬person_name#3⟭",⟬email#3⟭,"⟬postal_address:street#3⟭",⟬city#3⟭,⟬postcode#3⟭,,,GIFT,"⟬date#3⟭"`;

const rows = SAMPLE.split('\n');

describe('parseLegacyRow', () => {
  it('reads the columns in the fulfilment house order', () => {
    expect(parseLegacyRow(rows[0])).toMatchObject({
      legacyId: '⟬customer_id#1⟭',
      name: '⟬person_name#1⟭',
      email: '⟬email#1⟭',
      address: { line1: '⟬postal_address:street#1⟭', town: '⟬city#1⟭', postcode: '⟬postcode#1⟭' },
      title: 'WKLY',
    });
  });

  it('treats a row without a card as a gift subscription', () => {
    const third = parseLegacyRow(rows[2]);

    expect(third.card).toBeUndefined();
    expect(third.title).toBe('GIFT');
  });
});

describe('toBillingCustomer', () => {
  it('never passes the card number to the new provider', () => {
    const customer = toBillingCustomer(parseLegacyRow(rows[0]));

    expect(JSON.stringify(customer)).not.toContain('⟬payment_card#1⟭');
    expect(customer.paymentMethod).toEqual({ type: 'card_update_required', last4: expect.any(String) });
  });

  it('keeps the renewal date so nobody is charged early', () => {
    expect(toBillingCustomer(parseLegacyRow(rows[1])).renewsOn).toBe('⟬date#2⟭');
  });
});
⟬end⟭

⟬template⟭
family: code
format: .go
language: en
fill_locale: en_GB
domain: travel
appearance: package variable, Slack message in comment
scenario: decline alert for the single-use cards a tour operator issues to pay hotels, with a channel message pasted by the developer who still has to mask the card
⟬text⟭
package vcc

import (
	"context"
	"fmt"

	"github.com/slack-go/slack"
)

// Declines go to #hotel-payments so the desk can phone the property before the guest arrives.
var alerts = slack.New("⟬slack_token#1⟭")

func notifyDecline(ctx context.Context, b Booking, card Card, reason string) error {
	// TODO(⟬ticket_id#1⟭): only the last four should go out here
	text := fmt.Sprintf("VCC declined for %s at %s (%s): %s exp %s cvc %s, reason %q",
		b.Reference, b.HotelName, b.CheckIn.Format("02 Jan"), card.Number, card.Expiry, card.CVC, reason)
	_, _, err := alerts.PostMessageContext(ctx, "#hotel-payments", slack.MsgOptionText(text, false))
	return err
}

// In the channel on ⟬date#1⟭:
// VCC declined for ⟬order_number#1⟭ at Harbour View Hotel (14 Mar): ⟬payment_card#1⟭ exp 05/26 cvc ⟬card_security_code#1⟭, reason "do not honour"
⟬end⟭

⟬template⟭
family: code
format: .java
language: en
fill_locale: en_GB
domain: e-commerce
appearance: configuration properties record, YAML in Javadoc
scenario: Spring configuration properties of the card payments client of an online grocer, written by a backend developer so that a local run without secrets fails loudly
⟬text⟭
package com.basketful.checkout.payments;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import java.net.URI;
import java.time.Duration;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.context.properties.bind.DefaultValue;
import org.springframework.validation.annotation.Validated;

/**
 * Settings of the card payments client, bound from {@code checkout.payments.*}.
 *
 * <pre>
 * checkout:
 *   payments:
 *     base-url: https://⟬hostname#1⟭/v1
 *     api-key: ⟬trap:placeholder|${PAYMENTS_API_KEY}⟭
 *     webhook-secret: ⟬trap:placeholder|${PAYMENTS_WEBHOOK_SECRET}⟭
 *     timeout: 4s
 * </pre>
 *
 * Secrets come from the environment only. The defaults make a local run fail
 * loudly instead of charging a real card.
 */
@Validated
@ConfigurationProperties("checkout.payments")
public record PaymentsProperties(
        @DefaultValue("https://⟬hostname#2⟭/v1") URI baseUrl,
        @NotBlank @DefaultValue("⟬trap:placeholder|not-set⟭") String apiKey,
        @NotBlank @DefaultValue("⟬trap:placeholder|not-set⟭") String webhookSecret,
        ⟬trap:indicator_non_pii|@DefaultValue("X-Api-Key") String apiKeyHeader⟭,
        @DefaultValue("⟬stripe_publishable_key#1⟭") String publishableKey,
        @DefaultValue("4s") Duration timeout,
        @Min(0) @DefaultValue("2") int retries) {

    public boolean configured() {
        return !"not-set".equals(apiKey) && !"not-set".equals(webhookSecret);
    }

    @Override
    public String toString() {
        // never print the key, even at debug level
        return "PaymentsProperties[baseUrl=" + baseUrl + ", apiKey=⟬trap:placeholder|****⟭, timeout=" + timeout + ", retries=" + retries + "]";
    }
}
⟬end⟭

⟬template⟭
family: code
format: .js
language: en
fill_locale: en_GB
domain: e-commerce
appearance: service worker, constants, comment
scenario: service worker of a grocery web app that keeps the basket usable offline without caching account pages, written by a front-end developer after complaints from commuters
⟬text⟭
// public/sw.js
// Caches the app shell and product images so the basket still opens on a
// train. Account, checkout and session responses are never cached.

const VERSION = '⟬version#1⟭';
const SHELL_CACHE = `shell-${VERSION}`;
const IMAGE_CACHE = 'product-images-v3';
const SHELL = ['/', '/basket', '/offline.html', '/static/app.js', '/static/app.css'];
const NEVER_CACHE = [/^\/account/, /^\/checkout/, /^\/api\/session/];
const ⟬trap:indicator_non_pii|TOKEN_HEADER = 'X-Basket-Token'⟭;

self.addEventListener('install', (event) => {
  event.waitUntil(caches.open(SHELL_CACHE).then((cache) => cache.addAll(SHELL)));
  self.skipWaiting();
});

self.addEventListener('activate', (event) => {
  event.waitUntil(
    caches.keys().then((keys) =>
      Promise.all(keys.filter((k) => k.startsWith('shell-') && k !== SHELL_CACHE).map((k) => caches.delete(k))),
    ),
  );
  self.clients.claim();
});

self.addEventListener('fetch', (event) => {
  const url = new URL(event.request.url);
  if (event.request.method !== 'GET' || NEVER_CACHE.some((re) => re.test(url.pathname))) return;
  if (event.request.headers.has(TOKEN_HEADER)) return; // personalised basket, always from the network

  // product images, e.g. https://⟬hostname#1⟭/p/400/easy-peeler-⟬trap:word_name|clementines⟭-600g.webp
  if (url.hostname === '⟬hostname#1⟭') {
    event.respondWith(cacheFirst(IMAGE_CACHE, event.request));
    return;
  }
  if (SHELL.includes(url.pathname)) {
    event.respondWith(networkFirst(SHELL_CACHE, event.request));
  }
});

async function cacheFirst(name, request) {
  const cache = await caches.open(name);
  const hit = await cache.match(request);
  if (hit) return hit;
  const res = await fetch(request);
  if (res.ok) cache.put(request, res.clone());
  return res;
}

async function networkFirst(name, request) {
  const cache = await caches.open(name);
  try {
    const res = await fetch(request);
    cache.put(request, res.clone());
    return res;
  } catch {
    return (await cache.match(request)) || cache.match('/offline.html');
  }
}
⟬end⟭

⟬template⟭
family: code
format: .java
language: en
fill_locale: en_GB
domain: education
appearance: Javadoc, graph colouring
scenario: exam session planner of a secondary school that colours the clash graph of papers so that no candidate sits two at once, written by the school's data manager
⟬text⟭
package uk.org.ashgrove.exams;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * Assigns papers to exam sessions so that no candidate sits two papers at once,
 * by colouring the clash graph: papers are vertices, an edge joins two papers
 * that share a candidate, and each colour is a session.
 *
 * <p>Uses the ⟬trap:eponym|Welsh-Powell⟭ order (highest degree first), which is good
 * enough for 1,400 candidates; ⟬trap:eponym|Brélaz⟭'s DSatur was tried and saved one
 * session at most. Hall capacity is checked as papers are placed.
 */
public final class SessionPlanner {

    private final int sessionsAvailable;
    private final int hallSeats;

    public SessionPlanner(int sessionsAvailable, int hallSeats) {
        this.sessionsAvailable = sessionsAvailable;
        this.hallSeats = hallSeats;
    }

    /**
     * @param entries candidate number to the papers they sit, from the entries export
     * @return paper code to session index
     * @throws IllegalStateException when the papers do not fit in the available sessions
     */
    public Map<String, Integer> plan(Map<String, Set<String>> entries) {
        Map<String, Set<String>> clashes = new HashMap<>();
        Map<String, Integer> size = new HashMap<>();
        for (Set<String> papers : entries.values()) {
            for (String p : papers) {
                clashes.computeIfAbsent(p, k -> new HashSet<>());
                size.merge(p, 1, Integer::sum);
                for (String q : papers) {
                    if (!p.equals(q)) clashes.get(p).add(q);
                }
            }
        }

        List<String> order = new ArrayList<>(clashes.keySet());
        order.sort(Comparator.<String>comparingInt(p -> clashes.get(p).size()).reversed()
            .thenComparing(Comparator.naturalOrder()));

        Map<String, Integer> session = new LinkedHashMap<>();
        int[] seatsUsed = new int[sessionsAvailable];
        for (String paper : order) {
            Set<Integer> taken = new HashSet<>();
            for (String other : clashes.get(paper)) {
                Integer s = session.get(other);
                if (s != null) taken.add(s);
            }
            int chosen = -1;
            for (int s = 0; s < sessionsAvailable && chosen < 0; s++) {
                if (!taken.contains(s) && seatsUsed[s] + size.get(paper) <= hallSeats) chosen = s;
            }
            if (chosen < 0) {
                throw new IllegalStateException("no session left for " + paper + " (" + size.get(paper) + " candidates)");
            }
            session.put(paper, chosen);
            seatsUsed[chosen] += size.get(paper);
        }
        return session;
    }

    /** Candidates sitting more than {@code limit} papers on one day, for the access arrangements check. */
    public static List<String> heavyDays(Map<String, Set<String>> entries, Map<String, Integer> plan,
                                         int sessionsPerDay, int limit) {
        List<String> flagged = new ArrayList<>();
        entries.forEach((candidate, papers) -> {
            Map<Integer, Long> perDay = new HashMap<>();
            for (String p : papers) perDay.merge(plan.get(p) / sessionsPerDay, 1L, Long::sum);
            if (perDay.values().stream().anyMatch(n -> n > limit)) flagged.add(candidate);
        });
        return flagged;
    }
}
⟬end⟭

⟬template⟭
family: code
format: .js
language: en
fill_locale: en_GB
domain: education
appearance: module, comment
scenario: seating plan generator for mock exams in a school sports hall, written by the exams officer's developer colleague so a lost printout can be regenerated identically
⟬text⟭
// lib/seating.js
// Seating plans for the sports hall during mocks. Candidates are shuffled with
// a seeded ⟬trap:eponym|Fisher-Yates⟭ so a lost printout can be regenerated
// identically, then placed column by column so neighbours in the register do
// not end up side by side. Desk cards show candidate numbers, never names.

const ROW_LETTERS = 'ABCDEFGHJKLMNP'.split(''); // no I or O, they get misread on the desk cards

// Small seeded PRNG; Math.random cannot be replayed.
function mulberry32(seed) {
  let a = seed >>> 0;
  return function next() {
    a = (a + 0x6d2b79f5) >>> 0;
    let t = a;
    t = Math.imul(t ^ (t >>> 15), t | 1);
    t ^= t + Math.imul(t ^ (t >>> 7), t | 61);
    return ((t ^ (t >>> 14)) >>> 0) / 4294967296;
  };
}

function shuffle(items, seed) {
  const out = items.slice();
  const rand = mulberry32(seed);
  for (let i = out.length - 1; i > 0; i -= 1) {
    const j = Math.floor(rand() * (i + 1));
    [out[i], out[j]] = [out[j], out[i]];
  }
  return out;
}

function plan(candidates, { rows = 14, cols = 12, seed, extraTime = new Set() }) {
  if (candidates.length > rows * cols) {
    throw new Error(`hall holds ${rows * cols}, got ${candidates.length} candidates`);
  }
  // extra time candidates sit at the back so others leaving do not disturb them
  const back = candidates.filter((c) => extraTime.has(c));
  const rest = shuffle(candidates.filter((c) => !extraTime.has(c)), seed);
  const ordered = [...rest, ...back];

  return ordered.map((candidate, i) => {
    const col = Math.floor(i / rows);
    const row = i % rows;
    return { candidate, desk: `${ROW_LETTERS[row]}${col + 1}` };
  });
}

function toCsv(seats) {
  return ['candidate_no,desk', ...seats.map((s) => `${s.candidate},${s.desk}`)].join('\n');
}

module.exports = { plan, shuffle, toCsv };
⟬end⟭

⟬template⟭
family: code
format: .rb
language: en
fill_locale: en_GB
domain: travel
appearance: constant hash, view helper
scenario: view helper of a city break site that labels airports and shows flight times in each airport's local time, written by a developer on the search results page
⟬text⟭
# app/helpers/flight_times_helper.rb
module FlightTimesHelper
  AIRPORTS = {
    "LGW" => { city: "London", name: "Gatwick", tz: "Europe/London" },
    "BRS" => { city: "Bristol", name: "Bristol", tz: "Europe/London" },
    "LPL" => { city: "Liverpool", name: "⟬trap:eponym|John Lennon⟭", tz: "Europe/London" },
    "CDG" => { city: "⟬trap:word_name|Paris⟭", name: "⟬trap:eponym|Charles de Gaulle⟭", tz: "Europe/Paris" },
    "LDE" => { city: "⟬trap:word_name|Lourdes⟭", name: "Tarbes-Lourdes-Pyrénées", tz: "Europe/Paris" },
    "FLR" => { city: "⟬trap:word_name|Florence⟭", name: "Peretola", tz: "Europe/Rome" },
    "VCE" => { city: "Venice", name: "⟬trap:eponym|Marco Polo⟭", tz: "Europe/Rome" },
    "KEF" => { city: "Reykjavik", name: "Keflavik", tz: "Atlantic/Reykjavik" },
  }.freeze

  # "Dep 06:40 LGW, arr 10:05 FLR" in each airport's local time, with "+1"
  # when the arrival falls on the next local day.
  def flight_times(departs_at_utc, arrives_at_utc, from:, to:)
    dep = departs_at_utc.in_time_zone(AIRPORTS.fetch(from)[:tz])
    arr = arrives_at_utc.in_time_zone(AIRPORTS.fetch(to)[:tz])
    day_shift = (arr.to_date - dep.to_date).to_i
    suffix = day_shift.positive? ? " +#{day_shift}" : ""
    "Dep #{dep.strftime("%H:%M")} #{from}, arr #{arr.strftime("%H:%M")} #{to}#{suffix}"
  end

  def airport_label(code)
    airport = AIRPORTS[code] or return code
    return "#{airport[:city]} (#{code})" if airport[:city] == airport[:name]

    "#{airport[:city]} #{airport[:name]} (#{code})"
  end
end
⟬end⟭
