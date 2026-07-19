import { MigrationInterface, QueryRunner } from 'typeorm';

export class CreateInitialSchema1784410000000 implements MigrationInterface {
  name = 'CreateInitialSchema1784410000000';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`
      CREATE TABLE "users" (
        "id" uuid PRIMARY KEY,
        "email" varchar NOT NULL UNIQUE,
        "full_name" varchar,
        "born_date" timestamp,
        "method_login" varchar,
        "created_at" timestamptz DEFAULT now()
      );

      CREATE TABLE "memberships" (
        "id" uuid PRIMARY KEY,
        "name" varchar NOT NULL UNIQUE,
        "max_cards" integer,
        "max_receipt_scans_per_month" integer,
        "max_cashback_calculations_per_month" integer,
        "created_at" timestamptz DEFAULT now()
      );

      CREATE TABLE "user_memberships" (
        "id" uuid PRIMARY KEY,
        "user_id" uuid NOT NULL,
        "membership_id" uuid NOT NULL,
        "status" varchar NOT NULL,
        "started_at" timestamptz NOT NULL,
        "expired_at" timestamptz,
        "created_at" timestamptz DEFAULT now(),
        CONSTRAINT "fk_user_memberships_user" FOREIGN KEY ("user_id")
          REFERENCES "users" ("id") DEFERRABLE INITIALLY IMMEDIATE,
        CONSTRAINT "fk_user_memberships_membership" FOREIGN KEY ("membership_id")
          REFERENCES "memberships" ("id") DEFERRABLE INITIALLY IMMEDIATE
      );

      CREATE TABLE "banks" (
        "id" uuid PRIMARY KEY,
        "swift_code" varchar(20),
        "name" varchar(50) NOT NULL,
        "created_at" timestamptz DEFAULT now()
      );

      CREATE TABLE "credit_cards" (
        "id" uuid PRIMARY KEY,
        "bank_id" uuid NOT NULL,
        "name" varchar NOT NULL,
        "network" varchar,
        "card_type" varchar DEFAULT 'credit',
        "annual_fee" numeric(14,2),
        "source_url" text,
        "last_verified_at" timestamptz,
        "is_active" boolean DEFAULT true,
        "created_at" timestamptz DEFAULT now(),
        CONSTRAINT "fk_credit_cards_bank" FOREIGN KEY ("bank_id")
          REFERENCES "banks" ("id") DEFERRABLE INITIALLY IMMEDIATE
      );

      CREATE TABLE "user_cards" (
        "id" uuid PRIMARY KEY,
        "user_id" uuid NOT NULL,
        "credit_card_id" uuid NOT NULL,
        "nickname" varchar,
        "billing_cycle_day" integer,
        "is_default" boolean DEFAULT false,
        "has_annual_fee" boolean DEFAULT false,
        "created_at" timestamptz DEFAULT now(),
        CONSTRAINT "fk_user_cards_user" FOREIGN KEY ("user_id")
          REFERENCES "users" ("id") DEFERRABLE INITIALLY IMMEDIATE,
        CONSTRAINT "fk_user_cards_credit_card" FOREIGN KEY ("credit_card_id")
          REFERENCES "credit_cards" ("id") DEFERRABLE INITIALLY IMMEDIATE
      );

      CREATE TABLE "merchant_category_codes" (
        "code" varchar(4) PRIMARY KEY,
        "description" text NOT NULL,
        "category" varchar,
        "is_active" boolean DEFAULT true,
        "created_at" timestamptz DEFAULT now(),
        "updated_at" timestamptz DEFAULT now()
      );

      CREATE TABLE "merchants" (
        "id" uuid PRIMARY KEY,
        "name_raw" text NOT NULL,
        "name_normalized" text NOT NULL,
        "location_text" text,
        "country_code" varchar(2) DEFAULT 'VN',
        "created_at" timestamptz DEFAULT now()
      );

      CREATE TABLE "merchant_mcc_candidates" (
        "id" uuid PRIMARY KEY,
        "merchant_id" uuid NOT NULL,
        "mcc_code" varchar(4) NOT NULL,
        "source" varchar NOT NULL,
        "confidence_score" numeric(4,3) DEFAULT 0,
        "feedback_count" integer DEFAULT 0,
        "verified_count" integer DEFAULT 0,
        "status" varchar DEFAULT 'suggested',
        "last_observed_at" timestamptz,
        "created_at" timestamptz DEFAULT now(),
        CONSTRAINT "fk_merchant_mcc_candidates_merchant" FOREIGN KEY ("merchant_id")
          REFERENCES "merchants" ("id") DEFERRABLE INITIALLY IMMEDIATE,
        CONSTRAINT "fk_merchant_mcc_candidates_mcc" FOREIGN KEY ("mcc_code")
          REFERENCES "merchant_category_codes" ("code") DEFERRABLE INITIALLY IMMEDIATE,
        CONSTRAINT "uq_merchant_mcc_candidates_merchant_mcc" UNIQUE ("merchant_id", "mcc_code")
      );

      CREATE TABLE "transactions" (
        "id" uuid PRIMARY KEY,
        "user_id" uuid NOT NULL,
        "user_card_id" uuid NOT NULL,
        "merchant_id" uuid,
        "transaction_date" timestamptz NOT NULL,
        "amount" numeric(14,2) NOT NULL,
        "currency" varchar(3) NOT NULL DEFAULT 'VND',
        "mcc_code" varchar(4),
        "mcc_source" varchar,
        "category" varchar,
        "cashback_estimated_amount" numeric(14,2),
        "cashback_confidence" numeric(4,3),
        "source" varchar DEFAULT 'manual',
        "note" text,
        "created_at" timestamptz DEFAULT now(),
        CONSTRAINT "fk_transactions_user" FOREIGN KEY ("user_id")
          REFERENCES "users" ("id") DEFERRABLE INITIALLY IMMEDIATE,
        CONSTRAINT "fk_transactions_user_card" FOREIGN KEY ("user_card_id")
          REFERENCES "user_cards" ("id") DEFERRABLE INITIALLY IMMEDIATE,
        CONSTRAINT "fk_transactions_merchant" FOREIGN KEY ("merchant_id")
          REFERENCES "merchants" ("id") DEFERRABLE INITIALLY IMMEDIATE,
        CONSTRAINT "fk_transactions_mcc" FOREIGN KEY ("mcc_code")
          REFERENCES "merchant_category_codes" ("code") DEFERRABLE INITIALLY IMMEDIATE
      );

      CREATE TABLE "merchant_mcc_feedbacks" (
        "id" uuid PRIMARY KEY,
        "user_id" uuid NOT NULL,
        "merchant_id" uuid NOT NULL,
        "transaction_id" uuid,
        "suggested_mcc_code" varchar(4) NOT NULL,
        "evidence_type" varchar,
        "note" text,
        "status" varchar DEFAULT 'pending',
        "created_at" timestamptz DEFAULT now(),
        CONSTRAINT "fk_merchant_mcc_feedbacks_user" FOREIGN KEY ("user_id")
          REFERENCES "users" ("id") DEFERRABLE INITIALLY IMMEDIATE,
        CONSTRAINT "fk_merchant_mcc_feedbacks_merchant" FOREIGN KEY ("merchant_id")
          REFERENCES "merchants" ("id") DEFERRABLE INITIALLY IMMEDIATE,
        CONSTRAINT "fk_merchant_mcc_feedbacks_transaction" FOREIGN KEY ("transaction_id")
          REFERENCES "transactions" ("id") DEFERRABLE INITIALLY IMMEDIATE,
        CONSTRAINT "fk_merchant_mcc_feedbacks_mcc" FOREIGN KEY ("suggested_mcc_code")
          REFERENCES "merchant_category_codes" ("code") DEFERRABLE INITIALLY IMMEDIATE
      );

      CREATE INDEX "idx_merchant_mcc_feedbacks_merchant_mcc"
        ON "merchant_mcc_feedbacks" ("merchant_id", "suggested_mcc_code");
      CREATE INDEX "idx_merchant_mcc_feedbacks_user_merchant_transaction"
        ON "merchant_mcc_feedbacks" ("user_id", "merchant_id", "transaction_id");

      CREATE TABLE "reward_rules" (
        "id" uuid PRIMARY KEY,
        "credit_card_id" uuid NOT NULL,
        "name" varchar NOT NULL,
        "reward_type" varchar NOT NULL,
        "cashback_rate" numeric(6,4),
        "points_rate" numeric(10,4),
        "monthly_cap_amount" numeric(14,2),
        "minimum_transaction_amount" numeric(14,2),
        "minimum_monthly_spend" numeric(14,2),
        "eligible_channel" varchar DEFAULT 'any',
        "conditions_text" text,
        "effective_from" date,
        "effective_to" date,
        "source_url" text,
        "confidence" numeric(4,3),
        "last_verified_at" timestamptz,
        "is_active" boolean DEFAULT true,
        "created_at" timestamptz DEFAULT now(),
        CONSTRAINT "fk_reward_rules_credit_card" FOREIGN KEY ("credit_card_id")
          REFERENCES "credit_cards" ("id") DEFERRABLE INITIALLY IMMEDIATE
      );

      CREATE TABLE "reward_rule_mccs" (
        "id" uuid PRIMARY KEY,
        "reward_rule_id" uuid NOT NULL,
        "mcc_code" varchar(4) NOT NULL,
        "match_type" varchar NOT NULL,
        CONSTRAINT "fk_reward_rule_mccs_reward_rule" FOREIGN KEY ("reward_rule_id")
          REFERENCES "reward_rules" ("id") DEFERRABLE INITIALLY IMMEDIATE,
        CONSTRAINT "fk_reward_rule_mccs_mcc" FOREIGN KEY ("mcc_code")
          REFERENCES "merchant_category_codes" ("code") DEFERRABLE INITIALLY IMMEDIATE,
        CONSTRAINT "uq_reward_rule_mccs_rule_mcc_match" UNIQUE ("reward_rule_id", "mcc_code", "match_type")
      );

      CREATE TABLE "cashback_calculations" (
        "id" uuid PRIMARY KEY,
        "transaction_id" uuid NOT NULL,
        "user_card_id" uuid NOT NULL,
        "reward_rule_id" uuid,
        "estimated_cashback_amount" numeric(14,2),
        "applied_rate" numeric(6,4),
        "confidence" numeric(4,3),
        "explanation" text,
        "status" varchar DEFAULT 'estimated',
        "created_at" timestamptz DEFAULT now(),
        CONSTRAINT "fk_cashback_calculations_transaction" FOREIGN KEY ("transaction_id")
          REFERENCES "transactions" ("id") DEFERRABLE INITIALLY IMMEDIATE,
        CONSTRAINT "fk_cashback_calculations_user_card" FOREIGN KEY ("user_card_id")
          REFERENCES "user_cards" ("id") DEFERRABLE INITIALLY IMMEDIATE,
        CONSTRAINT "fk_cashback_calculations_reward_rule" FOREIGN KEY ("reward_rule_id")
          REFERENCES "reward_rules" ("id") DEFERRABLE INITIALLY IMMEDIATE
      );
    `);
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`
      DROP TABLE "cashback_calculations";
      DROP TABLE "reward_rule_mccs";
      DROP TABLE "reward_rules";
      DROP TABLE "merchant_mcc_feedbacks";
      DROP TABLE "transactions";
      DROP TABLE "merchant_mcc_candidates";
      DROP TABLE "merchants";
      DROP TABLE "merchant_category_codes";
      DROP TABLE "user_cards";
      DROP TABLE "credit_cards";
      DROP TABLE "banks";
      DROP TABLE "user_memberships";
      DROP TABLE "memberships";
      DROP TABLE "users";
    `);
  }
}
