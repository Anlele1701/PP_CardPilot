import { MigrationInterface, QueryRunner } from 'typeorm';

export class FixMerchantMccCandidateUniqueness1786160000000
  implements MigrationInterface
{
  name = 'FixMerchantMccCandidateUniqueness1786160000000';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`
      ALTER TABLE "merchant_mcc_candidates"
      DROP CONSTRAINT IF EXISTS "merchant_mcc_candidates_mcc_code_key"
    `);
    await queryRunner.query(`
      CREATE INDEX IF NOT EXISTS "idx_merchants_name_normalized"
      ON "merchants" ("name_normalized")
    `);
    await queryRunner.query(`
      CREATE INDEX IF NOT EXISTS "idx_merchant_mcc_candidates_merchant_status"
      ON "merchant_mcc_candidates" ("merchant_id", "status", "confidence_score" DESC)
    `);
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `DROP INDEX IF EXISTS "idx_merchant_mcc_candidates_merchant_status"`,
    );
    await queryRunner.query(
      `DROP INDEX IF EXISTS "idx_merchants_name_normalized"`,
    );
  }
}
