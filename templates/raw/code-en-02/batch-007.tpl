⟬template⟭
family: code
format: .java
language: en
fill_locale: en_GB
domain: logistics
appearance: SQL INSERT in text block, JDBC parameters, assertion
scenario: JDBC test of the agency driver roster of a haulage firm, seeded by a developer from the agency onboarding sheet of a depot pilot, fuel cards included
⟬text⟭
package uk.co.haulwise.drivers.agency;

import static org.assertj.core.api.Assertions.assertThat;

import java.time.LocalDate;
import javax.sql.DataSource;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.JdbcTest;
import org.springframework.jdbc.core.JdbcTemplate;

@JdbcTest
class AgencyDriverDaoTest {

    // From the agency's onboarding sheet for the Daventry pilot, tidied so the
    // constraints pass. The fuel cards are the starter-pack cards the provider
    // posted to the depot.
    private static final String SEED = """
        INSERT INTO agency_drivers (agency_ref, mobile, ni_number, licence_number, licence_categories, fuel_card_pan, start_date) VALUES
          ('⟬customer_id#1⟭', '⟬phone#1⟭', '⟬uk_national_insurance_number#1⟭', '⟬uk_driving_licence#1⟭', 'B,C,CE', '⟬payment_card#1⟭', DATE '2025-03-03'),
          ('⟬customer_id#2⟭', '⟬phone#2⟭', '⟬uk_national_insurance_number#2⟭', '⟬uk_driving_licence#2⟭', 'B,C1', NULL, DATE '2025-03-10');
        """;

    @Autowired JdbcTemplate jdbc;
    @Autowired DataSource dataSource;
    AgencyDriverDao dao;

    @BeforeEach
    void seed() {
        jdbc.execute(SEED);
        jdbc.update("INSERT INTO people (agency_ref, full_name) VALUES (?, ?)", "⟬customer_id#1⟭", "⟬person_name#1⟭");
        jdbc.update("INSERT INTO people (agency_ref, full_name) VALUES (?, ?)", "⟬customer_id#2⟭", "⟬person_name#2⟭");
        dao = new AgencyDriverDao(dataSource);
    }

    @Test
    void onlyDriversWithCeCanBeRosteredOnArtics() {
        assertThat(dao.eligibleFor(VehicleClass.ARTIC, LocalDate.of(2025, 3, 12)))
            .extracting(AgencyDriver::fullName)
            .containsExactly("⟬person_name#1⟭");
    }

    @Test
    void driversWithoutAFuelCardAreFlaggedForTheDepot() {
        assertThat(dao.missingFuelCards()).extracting(AgencyDriver::agencyRef).containsExactly("⟬customer_id#2⟭");
    }

    @Test
    void lookupByNiNumberIgnoresSpaces() {
        String spaced = "⟬uk_national_insurance_number#2⟭".replaceAll("(..)(..)(..)(..)(.)", "$1 $2 $3 $4 $5");

        assertThat(dao.findByNiNumber(spaced)).map(AgencyDriver::agencyRef).contains("⟬customer_id#2⟭");
    }
}
⟬end⟭

⟬template⟭
family: code
format: .ts
language: en
fill_locale: en_GB
domain: education
appearance: test factory, params override
scenario: Fishery factories for staff records of a multi-academy trust HR app, written by a developer so the payroll export tests see every field filled
⟬text⟭
// test/factories/staff.ts
import { Factory } from 'fishery';
import type { StaffMember } from '../../src/hr/types';

// Defaults are one teacher from the trust's onboarding test pack, so the payroll
// export tests see every field filled. Override per test.
export const staffFactory = Factory.define<StaffMember>(({ sequence, params }) => ({
  id: `stf_${sequence}`,
  school: 'ASH',
  role: 'Teacher of Geography',
  legalName: '⟬person_name#1⟭',
  preferredName: '⟬person_name:given#1⟭',
  workEmail: '⟬email#1⟭',
  dateOfBirth: '⟬birth_date#1⟭',
  niNumber: '⟬uk_national_insurance_number#1⟭',
  startDate: '⟬date#1⟭',
  contract: { fte: 1, pattern: 'term-time', payScale: 'MPS', point: 4 },
  dbs: { level: 'enhanced', checkedOn: '⟬date#2⟭' },
  ...params,
}));

// Support assistant on a fixed-term contract, for the leavers tests.
export const fixedTermAssistant = staffFactory.params({
  role: 'Teaching assistant',
  legalName: '⟬person_name#2⟭',
  preferredName: '⟬person_name:given#2⟭',
  workEmail: '⟬email#2⟭',
  dateOfBirth: '⟬birth_date#2⟭',
  niNumber: '⟬uk_national_insurance_number#2⟭',
  contract: { fte: 0.6, pattern: 'term-time', payScale: 'NJC', point: 6, endsOn: '2026-07-22' },
});

// Starter whose NI number has been applied for but not issued yet.
export const awaitingNiNumber = staffFactory.params({
  legalName: '⟬person_name#3⟭',
  niNumber: null,
  ⟬trap:indicator_non_pii|niNumberStatus: 'applied'⟭,
});
⟬end⟭

⟬template⟭
family: code
format: .go
language: en
fill_locale: en_GB
domain: travel
appearance: constant, gRPC metadata, protobuf request literal
scenario: Go integration test of the chauffeur check of an airport transfer partner API, written by a QA engineer with the sandbox token of the QA account
⟬text⟭
package transfers_test

import (
	"context"
	"testing"

	"google.golang.org/grpc"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/credentials/insecure"
	"google.golang.org/grpc/metadata"
	"google.golang.org/grpc/status"

	pb "github.com/skyline-transfers/partner-api/gen/chauffeur/v1"
)

const sandboxAddr = "⟬hostname#1⟭:50051"

// Partner sandbox token issued to the QA account. It lasts a year, so the
// suite keeps working in CI without the partner's login flow.
const partnerJWT = "⟬jwt#1⟭"

func dial(t *testing.T) (pb.ChauffeurServiceClient, context.Context) {
	t.Helper()
	conn, err := grpc.NewClient(sandboxAddr, grpc.WithTransportCredentials(insecure.NewCredentials()))
	if err != nil {
		t.Fatal(err)
	}
	t.Cleanup(func() { conn.Close() })
	ctx := metadata.AppendToOutgoingContext(context.Background(), "authorization", "Bearer "+partnerJWT, "x-partner-id", "SKY-0042")
	return pb.NewChauffeurServiceClient(conn), ctx
}

func TestVerifyChauffeur(t *testing.T) {
	client, ctx := dial(t)

	res, err := client.Verify(ctx, &pb.VerifyRequest{
		Name:          "⟬person_name#1⟭",
		LicenceNumber: "⟬uk_driving_licence#1⟭",
		VehicleReg:    "⟬uk_license_plate#1⟭",
		Airport:       "LHR",
	})
	if err != nil {
		t.Fatalf("verify: %v", err)
	}
	if res.GetStatus() != pb.VerifyResponse_APPROVED {
		t.Errorf("status = %v, want APPROVED (reasons: %v)", res.GetStatus(), res.GetReasons())
	}
}

func TestVerifyChauffeurRejectsAVehicleRegisteredToAnotherDriver(t *testing.T) {
	client, ctx := dial(t)

	_, err := client.Verify(ctx, &pb.VerifyRequest{
		Name:          "⟬person_name#2⟭",
		LicenceNumber: "⟬uk_driving_licence#2⟭",
		VehicleReg:    "⟬uk_license_plate#1⟭",
		Airport:       "LGW",
	})
	if status.Code(err) != codes.FailedPrecondition {
		t.Fatalf("err = %v, want FailedPrecondition", err)
	}
}
⟬end⟭

⟬template⟭
family: code
format: .rb
language: en
fill_locale: en_GB
domain: travel
appearance: psql session in comment, migration
scenario: Rails migration of a cruise line that backfills guests' passport numbers into an encrypted column, with the query the auditors ran pasted in the header by the developer
⟬text⟭
# db/migrate/20250611093000_backfill_encrypted_passport_numbers.rb
#
# Moves guests' passport numbers from the plain column to the encrypted one
# (deterministic, so the APIS export can still look a guest up by number).
# Runs in batches and is safe to re-run.
#
# The case that started it, found by the auditors on ⟬date#1⟭:
#   cruise_prod=> SELECT id, full_name, email, passport_number FROM guests WHERE passport_number = '⟬uk_passport#1⟭';
#     id    | full_name | email | passport_number
#   --------+-----------+-------+-----------------
#    418822 | ⟬person_name#1⟭ | ⟬email#1⟭ | ⟬uk_passport#1⟭
#   (1 row)
class BackfillEncryptedPassportNumbers < ActiveRecord::Migration[7.1]
  disable_ddl_transaction!

  class Guest < ActiveRecord::Base
    self.table_name = "guests"
    encrypts :passport_no, deterministic: true
  end

  def up
    Guest.where(passport_no: nil).where.not(passport_number: nil).in_batches(of: 500) do |batch|
      batch.each { |guest| guest.update!(passport_no: guest.passport_number) }
      sleep 0.1 # keeps replica lag down during the sailing season
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration, "the plain column is dropped in the next migration"
  end
end
⟬end⟭

⟬template⟭
family: code
format: .js
language: en
fill_locale: en_GB
domain: logistics
appearance: module, sample output in comment
scenario: declaration builder of an international removals company for household moves leaving the UK, with the output for a test move pasted under it by the developer
⟬text⟭
// src/customs/transfer-of-residence.js
// Builds the transfer of residence declaration for household moves leaving
// the UK. The destination broker wants the main mover's passport and the
// previous UK address; we send this JSON and they file it.

const REQUIRED = ['moverName', 'passportNumber', 'previousAddress', 'destinationCity', 'arrivalDate'];

function buildDeclaration(move) {
  const missing = REQUIRED.filter((k) => !move[k]);
  if (missing.length) throw new Error(`declaration incomplete: ${missing.join(', ')}`);
  return {
    form: 'TOR1',
    declarant: { name: move.moverName, passport: move.passportNumber, nationality: move.nationality || 'GBR' },
    previous_residence: { address: move.previousAddress, since: move.residentSince },
    new_residence: { city: move.destinationCity, country: move.destinationCountry },
    goods: move.inventory.map((item) => ({ description: item.description, value_gbp: item.value, owned_since: item.ownedSince })),
    arrival: move.arrivalDate,
  };
}

module.exports = { buildDeclaration };

// node -e "console.log(JSON.stringify(require('./src/customs/transfer-of-residence').buildDeclaration(require('./fixtures/move-lyon.json')), null, 2))"
// {
//   "form": "TOR1",
//   "declarant": { "name": "⟬person_name#1⟭", "passport": "⟬uk_passport#1⟭", "nationality": "GBR" },
//   "previous_residence": { "address": "⟬postal_address#1⟭", "since": "⟬date#3⟭" },
//   "new_residence": { "city": "Lyon", "country": "FR" },
//   "goods": [{ "description": "Upright piano, ⟬trap:company_name|⦃Family⦄ & Sons⟭, 1962", "value_gbp": 1800, "owned_since": "⟬date#2⟭" }],
//   "arrival": "⟬date#1⟭"
// }
⟬end⟭

⟬template⟭
family: code
format: .rb
language: en
fill_locale: en_GB
domain: education
appearance: CSV heredoc, assertion
scenario: RSpec spec of the staff car park permit import of a secondary school, written by the school developer with the spreadsheet the site manager sends every September
⟬text⟭
# spec/lib/parking/permit_import_spec.rb
require "rails_helper"

RSpec.describe Parking::PermitImport do
  # Export of the office spreadsheet, as the site manager sends it each September.
  let(:csv) do
    <<~CSV
      Staff name,Reg,Second reg,Email,Blue badge
      "⟬person_name#1⟭",⟬uk_license_plate#1⟭,,⟬email#1⟭,no
      "⟬person_name#2⟭",⟬uk_license_plate#2⟭,⟬uk_license_plate#3⟭,⟬email#2⟭,yes
      "⟬person_name#4⟭",⟬trap:indicator_non_pii|TBC⟭,,⟬email#4⟭,no
    CSV
  end

  subject(:import) { described_class.new(csv, academic_year: "2025-26") }

  it "creates one permit per registration" do
    expect { import.call }.to change(Permit, :count).by(3)
    expect(Permit.pluck(:registration)).to contain_exactly("⟬uk_license_plate#1⟭", "⟬uk_license_plate#2⟭", "⟬uk_license_plate#3⟭")
  end

  it "normalises registrations so the barrier camera matches them" do
    import.call

    expect(Permit.find_by(email: "⟬email#1⟭").registration_normalised).to eq("⟬uk_license_plate#1⟭".delete(" ").upcase)
  end

  it "reports rows without a registration instead of failing" do
    expect(import.call.skipped).to eq([{ line: 4, name: "⟬person_name#4⟭", reason: "no registration" }])
  end

  it "gives blue badge holders a bay in the front car park" do
    import.call

    expect(Permit.where(email: "⟬email#2⟭").pluck(:zone).uniq).to eq(["front"])
  end
end
⟬end⟭

⟬template⟭
family: code
format: .cs
language: en
fill_locale: en_GB
domain: e-commerce
appearance: anonymous object, raw HTTP exchange in comment
scenario: client for the payouts partner of a craft marketplace, with the captured request that reproduced a name mismatch kept for the partner ticket by the developer
⟬text⟭
using System.Net.Http.Headers;
using System.Net.Http.Json;

namespace Makersmarket.Payouts;

/// <summary>
/// Client for the payouts partner. Sellers are paid weekly to the IBAN they
/// verified at onboarding; the partner authenticates us with a short-lived JWT
/// minted by <see cref="PartnerTokenSource"/>.
/// </summary>
public sealed class PayoutsClient(HttpClient http, PartnerTokenSource tokens)
{
    public async Task<PayoutReceipt> CreateAsync(SellerPayout payout, CancellationToken ct)
    {
        using var request = new HttpRequestMessage(HttpMethod.Post, "v2/payouts")
        {
            Content = JsonContent.Create(new
            {
                reference = payout.Reference,
                amount = new { value = payout.AmountPence, currency = "GBP" },
                beneficiary = new { name = payout.AccountHolder, iban = payout.Iban },
            }),
        };
        request.Headers.Authorization = new AuthenticationHeaderValue("Bearer", await tokens.GetAsync(ct));
        request.Headers.Add("Idempotency-Key", payout.Reference);

        using var response = await http.SendAsync(request, ct);
        response.EnsureSuccessStatusCode();
        return (await response.Content.ReadFromJsonAsync<PayoutReceipt>(ct))!;
    }
}

/*
Request that reproduced the 422 on ⟬date#1⟭, captured with Fiddler for ⟬ticket_id#1⟭:

POST /v2/payouts HTTP/1.1
Host: ⟬hostname#1⟭
Authorization: Bearer ⟬jwt#1⟭
Idempotency-Key: ⟬order_number#1⟭
Content-Type: application/json; charset=utf-8

{"reference":"⟬order_number#1⟭","amount":{"value":48210,"currency":"GBP"},"beneficiary":{"name":"⟬person_name#1⟭","iban":"⟬iban#1⟭"}}

HTTP/1.1 422 Unprocessable Entity
{"error":"beneficiary_name_mismatch","detail":"Name does not match the account holder on file"}
*/
⟬end⟭

⟬template⟭
family: code
format: .ts
language: en
fill_locale: en_GB
domain: travel
appearance: object literal, mocked return value, assertion
scenario: Vitest suite of the owner sign-up route of a holiday cottage letting site, written by a developer adding the payee name check before rental payouts
⟬text⟭
// app/api/owners/route.test.ts
import { beforeEach, describe, expect, it, vi } from 'vitest';
import { POST } from './route';
import * as bank from '@/lib/payee-check';
import * as db from '@/lib/db';

vi.mock('@/lib/payee-check');
vi.mock('@/lib/db');

const owner = {
  name: '⟬person_name#1⟭',
  email: '⟬email#1⟭',
  phone: '⟬phone#1⟭',
  property: { name: 'Gull Cottage', address: '⟬postal_address#1⟭', bedrooms: 3 },
  payout: { iban: '⟬iban#1⟭', accountHolder: '⟬person_name#1⟭' },
};

function post(body: unknown) {
  return POST(new Request('http://localhost/api/owners', { method: 'POST', body: JSON.stringify(body) }));
}

describe('POST /api/owners', () => {
  beforeEach(() => {
    vi.resetAllMocks();
    vi.mocked(db.createOwner).mockResolvedValue({ id: 'own_8812', ...owner });
  });

  it('creates the owner when the bank confirms the account holder', async () => {
    vi.mocked(bank.confirmPayee).mockResolvedValue({ match: 'full', checkedName: '⟬person_name#1⟭' });

    const res = await post(owner);

    expect(res.status).toBe(201);
    expect(db.createOwner).toHaveBeenCalledWith(expect.objectContaining({ payout: { iban: '⟬iban#1⟭', accountHolder: '⟬person_name#1⟭' } }));
  });

  it('asks the owner to confirm a close match and stores nothing', async () => {
    vi.mocked(bank.confirmPayee).mockResolvedValue({ match: 'close', checkedName: '⟬person_name#2⟭' });

    const res = await post(owner);

    expect(res.status).toBe(409);
    expect(await res.json()).toEqual({ error: 'payee_close_match', suggestedName: '⟬person_name#2⟭' });
    expect(db.createOwner).not.toHaveBeenCalled();
  });

  it('needs a phone number for the cleaning team', async () => {
    const { phone, ...withoutPhone } = owner;

    const res = await post(withoutPhone);

    expect(res.status).toBe(400);
    expect(phone).toBeTruthy();
  });
});
⟬end⟭

⟬template⟭
family: code
format: .go
language: en
fill_locale: en_GB
domain: media
appearance: git remote URL, constants, file path in doc comment
scenario: nightly command of a local news group that mirrors the story archive repo to cold storage, left running on an old editorial box with credentials in constants
⟬text⟭
// Command archive-mirror copies the newsroom archive repo (one Markdown file
// per published story since 2009) to the cold-storage bucket every night.
//
// It runs on the old editorial box from /home/⟬person_name:handle#1⟭/archive-mirror,
// where cron has called it since ⟬date#1⟭.
package main

import (
	"context"
	"log"
	"os"
	"os/exec"
	"path/filepath"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/credentials"
	"github.com/aws/aws-sdk-go-v2/feature/s3/manager"
	"github.com/aws/aws-sdk-go-v2/service/s3"
	"github.com/aws/aws-sdk-go-v2/service/s3/types"
)

const (
	repoURL = "https://⟬github_token#1⟭:x-oauth-basic@github.com/coastline-news/archive.git"
	bucket  = "coastline-archive-cold"
	workDir = "/var/tmp/archive-mirror"

	// archive-mirror IAM user, added when the box lost its instance role
	awsKeyID  = "⟬aws_access_key_id#1⟭"
	awsSecret = "⟬aws_secret_access_key#1⟭"
)

func main() {
	ctx := context.Background()
	if err := syncRepo(); err != nil {
		log.Fatalf("git: %v", err)
	}
	cfg, err := config.LoadDefaultConfig(ctx,
		config.WithRegion("eu-west-2"),
		config.WithCredentialsProvider(credentials.NewStaticCredentialsProvider(awsKeyID, awsSecret, "")))
	if err != nil {
		log.Fatal(err)
	}
	up := manager.NewUploader(s3.NewFromConfig(cfg))

	n := 0
	err = filepath.WalkDir(workDir, func(path string, d os.DirEntry, err error) error {
		if err != nil || d.IsDir() || filepath.Ext(path) != ".md" {
			return err
		}
		f, err := os.Open(path)
		if err != nil {
			return err
		}
		defer f.Close()
		key, _ := filepath.Rel(workDir, path)
		_, err = up.Upload(ctx, &s3.PutObjectInput{Bucket: aws.String(bucket), Key: aws.String(key), Body: f, StorageClass: types.StorageClassGlacierIr})
		n++
		return err
	})
	if err != nil {
		log.Fatalf("upload: %v", err)
	}
	log.Printf("mirrored %d stories to s3://%s", n, bucket)
}

func syncRepo() error {
	if _, err := os.Stat(filepath.Join(workDir, ".git")); os.IsNotExist(err) {
		return exec.Command("git", "clone", "--depth", "1", repoURL, workDir).Run()
	}
	return exec.Command("git", "-C", workDir, "pull", "--ff-only").Run()
}
⟬end⟭

⟬template⟭
family: code
format: .rb
language: en
fill_locale: en_GB
domain: e-commerce
appearance: environment fallback, Markdown heredoc, issue text in comment
scenario: Rake task of a homeware shop that opens a GitHub issue for each supplier feed that failed overnight, written by the developer who looks after the catalogue imports
⟬text⟭
# lib/tasks/catalogue.rake
require "octokit"

namespace :catalogue do
  desc "Open a GitHub issue for each supplier feed that failed last night"
  task report_failed_feeds: :environment do
    client = Octokit::Client.new(access_token: ENV.fetch("CATALOGUE_BOT_TOKEN", "⟬github_token#1⟭"))
    repo = "homeworks-shop/catalogue"

    FeedRun.failed.where(started_at: 1.day.ago..).includes(:supplier).find_each do |run|
      title = "Feed failed: #{run.supplier.name} (#{run.started_at.to_date})"
      next if client.search_issues("repo:#{repo} is:open in:title \"#{title}\"").total_count.positive?

      client.create_issue(repo, title, <<~MD, labels: ["feed", run.supplier.code])
        **Supplier:** #{run.supplier.name}
        **Contact:** #{run.supplier.contact_name} <#{run.supplier.contact_email}>
        **Error:** `#{run.error_class}` #{run.error_message.truncate(300)}
        **Rows rejected:** #{run.rejected_count} of #{run.total_count}

        Rerun with `bin/rails "catalogue:import[#{run.supplier.code}]"`.
      MD
    end
  end
end

# First run on ⟬date#1⟭ opened ⟬ticket_id#1⟭:
#   Feed failed: ⟬trap:company_name|⦃Family⦄ Lighting⟭ (2025-04-02)
#   **Contact:** ⟬person_name#1⟭ <⟬email#1⟭>
#   **Error:** `CSV::MalformedCSVError` Unclosed quoted field in line 218.
⟬end⟭

⟬template⟭
family: code
format: .ts
language: en
fill_locale: en_GB
domain: media
appearance: environment object, fallback default
scenario: CI build script of a broadcaster's web apps on a self-hosted runner, where the release manager pasted the registry and remote cache tokens for launch week
⟬text⟭
// scripts/ci-build.ts
// Builds the web apps on the self-hosted runner. The runner cannot read the
// org secrets yet, so the release manager pasted these in for launch week (⟬ticket_id#1⟭).
import { execSync } from 'node:child_process';

const env = {
  ...process.env,
  NODE_AUTH_TOKEN: process.env.NODE_AUTH_TOKEN || '⟬npm_token#1⟭',
  TURBO_API: 'https://⟬hostname#1⟭',
  TURBO_TEAM: 'tidewater-web',
  TURBO_TOKEN: process.env.TURBO_TOKEN || '⟬opaque_token#1⟭',
  ⟬trap:indicator_non_pii|TURBO_TOKEN_TTL: '3600'⟭,
};

const apps = process.argv.slice(2);
const filter = apps.length ? apps.map((a) => `--filter=${a}`).join(' ') : '--filter=...[origin/main]';

execSync('pnpm install --frozen-lockfile', { stdio: 'inherit', env });
execSync(`pnpm turbo run build test ${filter}`, { stdio: 'inherit', env });
⟬end⟭

⟬template⟭
family: code
format: .go
language: en
fill_locale: en_GB
domain: energy
appearance: fallback default, shell command in raw string
scenario: Dagger pipeline of an energy supplier's customer portal, where a developer hard-coded a read-only registry token until the runner environment is wired up
⟬text⟭
// ci/main.go: Dagger pipeline for the customer portal.
package main

import (
	"context"
	"fmt"
	"os"

	"dagger.io/dagger"
)

func main() {
	ctx := context.Background()
	client, err := dagger.Connect(ctx, dagger.WithLogOutput(os.Stderr))
	if err != nil {
		panic(err)
	}
	defer client.Close()

	npmToken := os.Getenv("NPM_TOKEN")
	if npmToken == "" {
		npmToken = "⟬npm_token#1⟭" // read-only, gridwise scope; the runner env is not wired yet
	}
	secret := client.SetSecret("npm-token", npmToken)

	src := client.Host().Directory(".", dagger.HostDirectoryOpts{Exclude: []string{"node_modules", ".next"}})
	build := client.Container().
		From("node:20-bookworm-slim").
		WithDirectory("/app", src).
		WithWorkdir("/app").
		WithSecretVariable("NPM_TOKEN", secret).
		WithExec([]string{"sh", "-c", `echo "//registry.npmjs.org/:_authToken=⟬trap:placeholder|${NPM_TOKEN}⟭" > .npmrc && npm ci`}).
		WithExec([]string{"npm", "run", "build"}).
		WithExec([]string{"npm", "test", "--", "--ci"})

	out, err := build.Stdout(ctx)
	if err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
	fmt.Print(out)
}
⟬end⟭

⟬template⟭
family: code
format: .java
language: en
fill_locale: en_GB
domain: education
appearance: constant, example call in comment
scenario: Spring service of a school trust that messages teachers on Slack when they are given a cover lesson, written by a developer during the cover manager trial
⟬text⟭
package uk.org.ashgrove.cover;

import com.slack.api.Slack;
import com.slack.api.methods.MethodsClient;
import com.slack.api.methods.SlackApiException;
import java.io.IOException;
import java.time.format.DateTimeFormatter;
import org.springframework.stereotype.Service;

/**
 * Messages a teacher on Slack when the cover manager assigns them a lesson.
 * Staff are matched to Slack users by their school email.
 */
@Service
public class CoverNotifier {

    // trust workspace bot, cover scope only. TODO: move to application-secrets.yml
    private static final String BOT_TOKEN = "⟬slack_token#1⟭";
    private static final DateTimeFormatter DAY = DateTimeFormatter.ofPattern("EEEE d MMMM");

    private final MethodsClient slack = Slack.getInstance().methods(BOT_TOKEN);

    public void notify(CoverAssignment a) throws IOException, SlackApiException {
        var user = slack.usersLookupByEmail(r -> r.email(a.coverTeacherEmail()));
        if (!user.isOk()) {
            throw new IllegalStateException("no Slack user for " + a.coverTeacherEmail() + ": " + user.getError());
        }
        String text = String.format("You are covering %s %s, period %d in %s (%s). Work is on the shared drive under %s.",
            a.className(), a.subject(), a.period(), a.room(), DAY.format(a.date()), a.absentTeacherCode());
        slack.chatPostMessage(r -> r.channel(user.getUser().getId()).text(text));
    }
}

// Sent during the trial on ⟬date#1⟭:
//   notify(new CoverAssignment("⟬email#1⟭", "10X2", "Geography", 3, "H12", LocalDate.parse("2025-01-14"), "⟬trap:initials|RMK⟭"))
//   -> DM to ⟬person_name#1⟭: "You are covering 10X2 Geography, period 3 in H12 (Tuesday 14 January). Work is on the shared drive under ⟬trap:initials|RMK⟭."
⟬end⟭

⟬template⟭
family: code
format: .js
language: en
fill_locale: en_GB
domain: media
appearance: constructor options, fallback default
scenario: Slack app with which the duty editor of a news site approves breaking news pushes, with the staging bot credentials left as fallbacks by the developer
⟬text⟭
// bolt/app.js: the duty editor approves breaking news pushes here before
// they go to the app's subscribers.
const { App } = require('@slack/bolt');
const { sendPush } = require('../push');

const app = new App({
  token: process.env.SLACK_BOT_TOKEN || '⟬slack_token#1⟭',
  signingSecret: process.env.SLACK_SIGNING_SECRET || '⟬opaque_token#1⟭',
});

const DUTY_EDITORS = new Set(['U02DUTYED1', 'U02DUTYED2', 'U04NIGHTDESK']);

function proposalBlocks(headline, url) {
  return [
    { type: 'section', text: { type: 'mrkdwn', text: `*Push proposed*\n${headline}\n<${url}>` } },
    {
      type: 'actions',
      elements: [{ type: 'button', style: 'primary', text: { type: 'plain_text', text: 'Send push' }, action_id: 'approve_push', value: JSON.stringify({ headline, url }) }],
    },
  ];
}

app.command('/push', async ({ command, ack, respond }) => {
  await ack();
  const [url, ...words] = command.text.trim().split(/\s+/);
  await respond({ response_type: 'in_channel', blocks: proposalBlocks(words.join(' '), url) });
});

app.action('approve_push', async ({ body, ack, respond }) => {
  await ack();
  if (!DUTY_EDITORS.has(body.user.id)) {
    await respond({ text: 'Only the duty editor can send a push.', response_type: 'ephemeral', replace_original: false });
    return;
  }
  const { headline, url } = JSON.parse(body.actions[0].value);
  const sent = await sendPush({ headline, url, audience: 'breaking' });
  await respond({ text: `Sent to ${sent.toLocaleString('en-GB')} devices by <@${body.user.id}>: ${headline}`, replace_original: true });
});

(async () => {
  await app.start(process.env.PORT || 3000);
  console.log('push approvals running');
})();
⟬end⟭

⟬template⟭
family: code
format: .cs
language: en
fill_locale: en_GB
domain: travel
appearance: XML in raw string literal, assertion
scenario: xUnit tests of the parser that reads OTA booking notifications in the channel manager of a seaside hotel group, with a sandbox booking trimmed to one room stay
⟬text⟭
using System.Xml.Linq;
using Harbourline.ChannelManager.Ota;
using Xunit;

namespace Harbourline.ChannelManager.Tests;

public class HotelResNotifParserTests
{
    // OTA_HotelResNotifRQ as the booking site posted it to the sandbox endpoint,
    // trimmed to one room stay. The guarantee card is how the hotel takes the
    // no-show fee, so the parser hands it to the vault and keeps only a token.
    private const string Booking = """
        <OTA_HotelResNotifRQ xmlns="http://www.opentravel.org/OTA/2003/05" Version="1.003" TimeStamp="2025-05-20T09:12:44Z">
          <HotelReservations>
            <HotelReservation CreateDateTime="2025-05-20T09:12:40Z" ResStatus="Commit">
              <UniqueID Type="14" ID="⟬order_number#1⟭"/>
              <RoomStays>
                <RoomStay>
                  <RoomTypes><RoomType RoomTypeCode="DBL-SEA"/></RoomTypes>
                  <TimeSpan Start="2025-07-11" End="2025-07-14"/>
                </RoomStay>
              </RoomStays>
              <ResGuests>
                <ResGuest>
                  <Profiles><ProfileInfo><Profile><Customer>
                    <PersonName><GivenName>⟬person_name:given#1⟭</GivenName><Surname>⟬person_name:family#1⟭</Surname></PersonName>
                    <Telephone PhoneNumber="⟬phone#1⟭"/>
                    <Email>⟬email#1⟭</Email>
                  </Customer></Profile></ProfileInfo></Profiles>
                </ResGuest>
              </ResGuests>
              <ResGlobalInfo>
                <Guarantee>
                  <GuaranteesAccepted><GuaranteeAccepted>
                    <PaymentCard CardCode="VI" CardNumber="⟬payment_card#1⟭" SeriesCode="⟬card_security_code#1⟭" ExpireDate="0827">
                      <CardHolderName>⟬person_name#1⟭</CardHolderName>
                    </PaymentCard>
                  </GuaranteeAccepted></GuaranteesAccepted>
                </Guarantee>
              </ResGlobalInfo>
            </HotelReservation>
          </HotelReservations>
        </OTA_HotelResNotifRQ>
        """;

    [Fact]
    public void Reads_the_guest_and_the_stay()
    {
        var res = HotelResNotifParser.Parse(XDocument.Parse(Booking), out _);

        Assert.Equal("⟬order_number#1⟭", res.ChannelReference);
        Assert.Equal("⟬person_name:family#1⟭", res.Guest.Surname);
        Assert.Equal("⟬email#1⟭", res.Guest.Email);
        Assert.Equal(new DateOnly(2025, 7, 11), res.Arrival);
        Assert.Equal(3, res.Nights);
    }

    [Fact]
    public void Hands_the_card_to_the_vault_and_keeps_only_a_token()
    {
        var res = HotelResNotifParser.Parse(XDocument.Parse(Booking), out var card);

        Assert.Equal("⟬payment_card#1⟭".Replace(" ", ""), card!.Pan);
        Assert.Null(res.Guarantee.Pan);
        Assert.DoesNotContain("⟬card_security_code#1⟭", res.ToString());
    }
}
⟬end⟭

⟬template⟭
family: code
format: .java
language: en
fill_locale: en_GB
domain: logistics
appearance: Javadoc, numeric constants
scenario: distance and geofence helpers used for depot arrival events of a van fleet tracking service, written by a backend developer on the telematics team
⟬text⟭
package uk.co.haulwise.tracking.geo;

/**
 * Distance and geofence checks for depot arrival events. Vans report every
 * 30 seconds; an arrival is logged when a van is inside the depot radius for
 * two consecutive reports.
 *
 * <p>The haversine formula is enough for radii of a few kilometres. Route
 * distances for the billing report use ⟬trap:eponym|Vincenty⟭'s inverse formula on
 * the WGS-84 ellipsoid, see {@link #vincentyMetres}.
 */
public final class Geo {

    private static final double EARTH_RADIUS_M = 6_371_008.8;
    private static final double A = 6_378_137.0;
    private static final double F = 1 / 298.257223563;
    private static final double B = (1 - F) * A;

    private Geo() {}

    public static double haversineMetres(double lat1, double lon1, double lat2, double lon2) {
        double dLat = Math.toRadians(lat2 - lat1);
        double dLon = Math.toRadians(lon2 - lon1);
        double h = Math.pow(Math.sin(dLat / 2), 2)
            + Math.cos(Math.toRadians(lat1)) * Math.cos(Math.toRadians(lat2)) * Math.pow(Math.sin(dLon / 2), 2);
        return 2 * EARTH_RADIUS_M * Math.asin(Math.sqrt(h));
    }

    /** Inverse formula; NaN when it does not converge (nearly antipodal points). */
    public static double vincentyMetres(double lat1, double lon1, double lat2, double lon2) {
        double u1 = Math.atan((1 - F) * Math.tan(Math.toRadians(lat1)));
        double u2 = Math.atan((1 - F) * Math.tan(Math.toRadians(lat2)));
        double l = Math.toRadians(lon2 - lon1);
        double sinU1 = Math.sin(u1), cosU1 = Math.cos(u1), sinU2 = Math.sin(u2), cosU2 = Math.cos(u2);
        double lambda = l, sinSigma, cosSigma, sigma, cosSqAlpha, cos2SigmaM;
        int iterations = 0;
        do {
            double sinLambda = Math.sin(lambda), cosLambda = Math.cos(lambda);
            sinSigma = Math.sqrt(Math.pow(cosU2 * sinLambda, 2) + Math.pow(cosU1 * sinU2 - sinU1 * cosU2 * cosLambda, 2));
            if (sinSigma == 0) return 0;
            cosSigma = sinU1 * sinU2 + cosU1 * cosU2 * cosLambda;
            sigma = Math.atan2(sinSigma, cosSigma);
            double sinAlpha = cosU1 * cosU2 * sinLambda / sinSigma;
            cosSqAlpha = 1 - sinAlpha * sinAlpha;
            cos2SigmaM = cosSqAlpha == 0 ? 0 : cosSigma - 2 * sinU1 * sinU2 / cosSqAlpha;
            double c = F / 16 * cosSqAlpha * (4 + F * (4 - 3 * cosSqAlpha));
            double previous = lambda;
            lambda = l + (1 - c) * F * sinAlpha
                * (sigma + c * sinSigma * (cos2SigmaM + c * cosSigma * (-1 + 2 * cos2SigmaM * cos2SigmaM)));
            if (Math.abs(lambda - previous) < 1e-12) break;
        } while (++iterations < 200);
        if (iterations >= 200) return Double.NaN;

        double uSq = cosSqAlpha * (A * A - B * B) / (B * B);
        double bigA = 1 + uSq / 16384 * (4096 + uSq * (-768 + uSq * (320 - 175 * uSq)));
        double bigB = uSq / 1024 * (256 + uSq * (-128 + uSq * (74 - 47 * uSq)));
        double deltaSigma = bigB * sinSigma * (cos2SigmaM + bigB / 4 * (cosSigma * (-1 + 2 * cos2SigmaM * cos2SigmaM)
            - bigB / 6 * cos2SigmaM * (-3 + 4 * sinSigma * sinSigma) * (-3 + 4 * cos2SigmaM * cos2SigmaM)));
        return B * bigA * (sigma - deltaSigma);
    }

    /** True when both of the last two fixes are inside the depot fence. */
    public static boolean arrived(Fix previous, Fix current, Depot depot) {
        return inside(previous, depot) && inside(current, depot);
    }

    private static boolean inside(Fix fix, Depot depot) {
        return fix != null && haversineMetres(fix.lat(), fix.lon(), depot.lat(), depot.lon()) <= depot.radiusMetres();
    }
}
⟬end⟭

⟬template⟭
family: code
format: .java
language: en
fill_locale: en_GB
domain: energy
appearance: health details, YAML in Javadoc
scenario: Spring Boot health indicator that reports the meter data hub down after two missed reading files, written by the platform engineer on call for the settlement systems
⟬text⟭
package uk.co.voltline.meterhub;

import java.time.Duration;
import java.time.Instant;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.actuate.health.Health;
import org.springframework.boot.actuate.health.HealthIndicator;
import org.springframework.stereotype.Component;

/**
 * Reports DOWN when the meter data hub has not delivered a reading file for
 * longer than the agreed window. The hub pushes every 30 minutes; one missed
 * push is normal during their maintenance, two is an incident.
 *
 * <pre>
 * meterhub:
 *   sftp-host: ⟬hostname#1⟭
 *   username: ⟬trap:placeholder|${METERHUB_USER}⟭
 *   password: ⟬trap:placeholder|${METERHUB_PASSWORD}⟭
 *   max-silence: 65m
 * </pre>
 */
@Component("meterHub")
public class MeterHubHealthIndicator implements HealthIndicator {

    private final ReadingFileLedger ledger;
    private final Duration maxSilence;

    public MeterHubHealthIndicator(ReadingFileLedger ledger, @Value("${meterhub.max-silence:65m}") Duration maxSilence) {
        this.ledger = ledger;
        this.maxSilence = maxSilence;
    }

    @Override
    public Health health() {
        Instant last = ledger.lastFileReceivedAt();
        if (last == null) {
            return Health.unknown().withDetail("reason", "no file received since start-up").build();
        }
        Duration silence = Duration.between(last, Instant.now());
        Health.Builder builder = silence.compareTo(maxSilence) > 0 ? Health.down() : Health.up();
        return builder
            .withDetail("lastFile", ledger.lastFileName())
            .withDetail("lastReceivedAt", last.toString())
            .withDetail("silenceMinutes", silence.toMinutes())
            .withDetail(⟬trap:indicator_non_pii|"user", "health-probe"⟭)
            .build();
    }
}
⟬end⟭

⟬template⟭
family: code
format: .js
language: en
fill_locale: en_GB
domain: logistics
appearance: regular expression, CLI script, ZPL example in comment
scenario: lint script that checks the ZPL label templates of a parcel hub before they reach the printers, written by the developer who maintains the warehouse system integration
⟬text⟭
// tools/zpl-lint.js
// Checks the ZPL label templates before they reach the printers in the hub:
// every field the WMS fills must exist in the template, and nothing may print
// outside the 4x6 inch label at 203 dpi.
//
// A field line in the templates looks like:
//   ^FO40,120^A0N,40,40^FD⟬trap:indicator_non_pii|Recipient: {{recipient_name}}⟭^FS

const fs = require('node:fs');

const LABEL_DOTS = { width: 812, height: 1218 };
const REQUIRED_FIELDS = ['recipient_name', 'address_lines', 'postcode', 'tracking_barcode', 'service'];
const FIELD = /\^FO(\d+),(\d+).*?\^FD(.*?)\^FS/g;
const PLACEHOLDER = /\{\{(\w+)\}\}/g;

function lint(zpl, name) {
  const problems = [];
  if (!zpl.startsWith('^XA') || !zpl.trimEnd().endsWith('^XZ')) problems.push('missing ^XA or ^XZ');
  const seen = new Set();
  for (const [, x, y, data] of zpl.matchAll(FIELD)) {
    if (Number(x) > LABEL_DOTS.width || Number(y) > LABEL_DOTS.height) problems.push(`field at ${x},${y} is off the label`);
    for (const [, field] of data.matchAll(PLACEHOLDER)) seen.add(field);
  }
  for (const field of REQUIRED_FIELDS) {
    if (!seen.has(field)) problems.push(`no {{${field}}} field`);
  }
  return problems.map((p) => `${name}: ${p}`);
}

const problems = process.argv.slice(2).flatMap((file) => lint(fs.readFileSync(file, 'utf8'), file));
problems.forEach((p) => console.error(p));
process.exit(problems.length ? 1 : 0);
⟬end⟭

⟬template⟭
family: code
format: .js
language: en
fill_locale: en_GB
domain: energy
appearance: tariff table, example in comment
scenario: annual cost estimate shown on the quote page of a domestic energy supplier, written by a developer on the sales journey team
⟬text⟭
// src/quote/annual-cost.js
// Estimated annual cost on the quote page: unit rates times expected
// consumption plus 365 days of standing charge, with VAT at 5% for domestic supply.
// Rates are in pence; the result is in pounds.

const VAT = 0.05;

const TARIFFS = [
  { code: 'FIX12-V3', name: 'Fixed 12M', elec: { unit: 24.11, standing: 46.36 }, gas: { unit: 5.89, standing: 29.62 }, exitFee: 75 },
  { code: 'FLEX-V7', name: 'Flexible', elec: { unit: 24.86, standing: 51.37 }, gas: { unit: 6.24, standing: 31.65 }, exitFee: 0 },
  { code: 'EV-NIGHT', name: '⟬trap:word_name|Ivy⟭ EV Night', elec: { unit: 27.2, night: 8.5, standing: 49.0 }, gas: null, exitFee: 0 },
];

function elecCost(elec, { elecKwh, nightShare = 0 }) {
  const units = elec.night
    ? elec.unit * elecKwh * (1 - nightShare) + elec.night * elecKwh * nightShare
    : elec.unit * elecKwh;
  return units + elec.standing * 365;
}

function annualCost(tariff, usage) {
  const gas = tariff.gas && usage.gasKwh ? tariff.gas.unit * usage.gasKwh + tariff.gas.standing * 365 : 0;
  return Math.round((elecCost(tariff.elec, usage) + gas) * (1 + VAT)) / 100;
}

function cheapest(usage) {
  return TARIFFS.filter((t) => (usage.gasKwh ? t.gas : true))
    .map((t) => ({ code: t.code, name: t.name, annual: annualCost(t, usage) }))
    .sort((a, b) => a.annual - b.annual);
}

module.exports = { annualCost, cheapest, TARIFFS };

// Typical medium use: cheapest({ elecKwh: 2700, gasKwh: 11500 })
// -> [{ code: 'FIX12-V3', name: 'Fixed 12M', annual: 1685.93 }, { code: 'FLEX-V7', name: 'Flexible', annual: 1776.44 }]
⟬end⟭

⟬template⟭
family: code
format: .cs
language: en
fill_locale: en_GB
domain: e-commerce
appearance: XML doc example URL, set initializer
scenario: output cache policy of a homeware storefront that drops tracking and personal query parameters from campaign links, written by a backend developer after the cache hit rate collapsed
⟬text⟭
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.OutputCaching;

namespace Homeworks.Storefront.Caching;

/// <summary>
/// Output cache policy for category and product pages. Campaign links arrive
/// with tracking parameters that would split the cache into one entry per
/// click, so they are left out of the cache key. Parameters that could carry
/// personal data are removed from the request before anything logs it.
/// </summary>
/// <example>
/// /c/lighting?sort=price&amp;utm_source=newsletter&amp;gclid=⟬hash#1⟭&amp;⟬trap:indicator_non_pii|email=%7B%7Bsubscriber.email%7D%7D⟭
/// is cached as /c/lighting?sort=price (that one came from a broken mail merge).
/// </example>
public sealed class CampaignAwareCachePolicy : IOutputCachePolicy
{
    private static readonly HashSet<string> Tracking = new(StringComparer.OrdinalIgnoreCase)
    {
        "utm_source", "utm_medium", "utm_campaign", "utm_content", "utm_term", "gclid", "fbclid", "msclkid", "mc_eid",
    };

    private static readonly HashSet<string> Personal = new(StringComparer.OrdinalIgnoreCase) { "email", "e", "name", "phone" };

    ValueTask IOutputCachePolicy.CacheRequestAsync(OutputCacheContext context, CancellationToken ct)
    {
        var request = context.HttpContext.Request;
        var kept = request.Query.Where(q => !Tracking.Contains(q.Key) && !Personal.Contains(q.Key)).ToList();
        if (request.Query.Any(q => Personal.Contains(q.Key)))
        {
            request.QueryString = QueryString.Create(kept);
        }
        context.EnableOutputCaching = HttpMethods.IsGet(request.Method) && !request.Cookies.ContainsKey(".Homeworks.Session");
        context.AllowCacheLookup = true;
        context.AllowCacheStorage = true;
        context.CacheVaryByRules.QueryKeys = kept.Select(q => q.Key).OrderBy(k => k).ToArray();
        context.ResponseExpirationTimeSpan = TimeSpan.FromMinutes(5);
        return ValueTask.CompletedTask;
    }

    ValueTask IOutputCachePolicy.ServeFromCacheAsync(OutputCacheContext context, CancellationToken ct) => ValueTask.CompletedTask;

    ValueTask IOutputCachePolicy.ServeResponseAsync(OutputCacheContext context, CancellationToken ct)
    {
        context.AllowCacheStorage &= context.HttpContext.Response.StatusCode == StatusCodes.Status200OK;
        return ValueTask.CompletedTask;
    }
}
⟬end⟭
