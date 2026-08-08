import { MigrationInterface, QueryRunner } from 'typeorm';

export class AddMerchantPaymentType1786170000000 implements MigrationInterface {
  name = 'AddMerchantPaymentType1786170000000';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`
      ALTER TABLE "merchant_mcc_candidates"
      ADD COLUMN "payment_type" varchar NOT NULL DEFAULT 'unknown'
    `);
    await queryRunner.query(`
      ALTER TABLE "merchant_mcc_candidates"
      ADD CONSTRAINT "chk_merchant_mcc_candidates_payment_type"
      CHECK ("payment_type" IN (
        'unknown', 'in_store', 'online', 'shopee_food', 'grab_food', 'other'
      ))
    `);
    await queryRunner.query(`
      ALTER TABLE "merchant_mcc_candidates"
      DROP CONSTRAINT IF EXISTS "uq_merchant_mcc_candidates_merchant_mcc"
    `);
    await queryRunner.query(`
      ALTER TABLE "merchant_mcc_candidates"
      ADD CONSTRAINT "uq_merchant_mcc_candidates_merchant_mcc_payment"
      UNIQUE ("merchant_id", "mcc_code", "payment_type")
    `);
    await queryRunner.query(`
      CREATE INDEX "idx_merchant_mcc_candidates_payment_type"
      ON "merchant_mcc_candidates"
        ("merchant_id", "payment_type", "status", "confidence_score" DESC)
    `);
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `DROP INDEX IF EXISTS "idx_merchant_mcc_candidates_payment_type"`,
    );
    await queryRunner.query(`
      ALTER TABLE "merchant_mcc_candidates"
      DROP CONSTRAINT IF EXISTS "chk_merchant_mcc_candidates_payment_type"
    `);
    await queryRunner.query(`
      ALTER TABLE "merchant_mcc_candidates"
      DROP CONSTRAINT IF EXISTS "uq_merchant_mcc_candidates_merchant_mcc_payment"
    `);
    await queryRunner.query(`
      ALTER TABLE "merchant_mcc_candidates"
      ADD CONSTRAINT "uq_merchant_mcc_candidates_merchant_mcc"
      UNIQUE ("merchant_id", "mcc_code")
    `);
    await queryRunner.query(`
      ALTER TABLE "merchant_mcc_candidates"
      DROP COLUMN "payment_type"
    `);
  }
}
