import { MigrationInterface, QueryRunner } from 'typeorm';

export class CreateReferenceDatasetVersions1785715200000
  implements MigrationInterface
{
  name = 'CreateReferenceDatasetVersions1785715200000';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`
      CREATE TABLE "reference_dataset_versions"
      (
        "dataset_key" varchar(64) PRIMARY KEY,
        "version"     bigint      NOT NULL DEFAULT 1,
        "updated_at"  timestamptz NOT NULL DEFAULT now(),
        CONSTRAINT "ck_reference_dataset_versions_positive"
          CHECK ("version" > 0)
      );

      INSERT INTO "reference_dataset_versions" ("dataset_key")
      VALUES
        ('memberships'),
        ('banks'),
        ('credit_cards'),
        ('merchant_category_codes'),
        ('reward_rules');

      CREATE FUNCTION bump_reference_dataset_version()
      RETURNS trigger
      LANGUAGE plpgsql
      AS $$
      BEGIN
        UPDATE "reference_dataset_versions"
        SET
          "version" = "version" + 1,
          "updated_at" = now()
        WHERE "dataset_key" = TG_ARGV[0];

        RETURN NULL;
      END;
      $$;

      CREATE TRIGGER "trg_memberships_bump_dataset_version"
      AFTER INSERT OR UPDATE OR DELETE OR TRUNCATE ON "memberships"
      FOR EACH STATEMENT
      EXECUTE FUNCTION bump_reference_dataset_version('memberships');

      CREATE TRIGGER "trg_banks_bump_dataset_version"
      AFTER INSERT OR UPDATE OR DELETE OR TRUNCATE ON "banks"
      FOR EACH STATEMENT
      EXECUTE FUNCTION bump_reference_dataset_version('banks');

      CREATE TRIGGER "trg_credit_cards_bump_dataset_version"
      AFTER INSERT OR UPDATE OR DELETE OR TRUNCATE ON "credit_cards"
      FOR EACH STATEMENT
      EXECUTE FUNCTION bump_reference_dataset_version('credit_cards');

      CREATE TRIGGER "trg_mcc_bump_dataset_version"
      AFTER INSERT OR UPDATE OR DELETE OR TRUNCATE
      ON "merchant_category_codes"
      FOR EACH STATEMENT
      EXECUTE FUNCTION bump_reference_dataset_version(
        'merchant_category_codes'
      );

      CREATE TRIGGER "trg_reward_rules_bump_dataset_version"
      AFTER INSERT OR UPDATE OR DELETE OR TRUNCATE ON "reward_rules"
      FOR EACH STATEMENT
      EXECUTE FUNCTION bump_reference_dataset_version('reward_rules');

      CREATE TRIGGER "trg_reward_rule_mccs_bump_dataset_version"
      AFTER INSERT OR UPDATE OR DELETE OR TRUNCATE ON "reward_rule_mccs"
      FOR EACH STATEMENT
      EXECUTE FUNCTION bump_reference_dataset_version('reward_rules');
    `);
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`
      DROP TRIGGER "trg_reward_rule_mccs_bump_dataset_version"
        ON "reward_rule_mccs";
      DROP TRIGGER "trg_reward_rules_bump_dataset_version"
        ON "reward_rules";
      DROP TRIGGER "trg_mcc_bump_dataset_version"
        ON "merchant_category_codes";
      DROP TRIGGER "trg_credit_cards_bump_dataset_version"
        ON "credit_cards";
      DROP TRIGGER "trg_banks_bump_dataset_version" ON "banks";
      DROP TRIGGER "trg_memberships_bump_dataset_version"
        ON "memberships";
      DROP FUNCTION bump_reference_dataset_version();
      DROP TABLE "reference_dataset_versions";
    `);
  }
}
