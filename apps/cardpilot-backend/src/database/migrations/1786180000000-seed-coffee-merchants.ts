import { MigrationInterface, QueryRunner } from 'typeorm';

const MERCHANT_IDS = [
  'e1000001-0000-4000-8000-000000000001',
  'e1000001-0000-4000-8000-000000000002',
  'e2000001-0000-4000-8000-000000000001',
  'e2000001-0000-4000-8000-000000000002',
  'e3000001-0000-4000-8000-000000000001',
  'e3000001-0000-4000-8000-000000000002',
] as const;

const SEED_SOURCE = 'curated_seed_178618';

export class SeedCoffeeMerchants1786180000000 implements MigrationInterface {
  name = 'SeedCoffeeMerchants1786180000000';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`
      DO $$
      BEGIN
        IF (
          SELECT count(*)
          FROM "merchant_category_codes"
          WHERE "code" IN ('5812', '5814')
        ) <> 2 THEN
          RAISE EXCEPTION 'MCC 5812 and 5814 are required before seeding coffee merchants';
        END IF;
      END
      $$;
    `);

    // These rows are representative branch profiles for development. They are
    // deliberately not marked as verified physical outlets.
    await queryRunner.query(`
      INSERT INTO "merchants"
        (
          "id",
          "name_raw",
          "name_normalized",
          "location_text",
          "country_code"
        )
      VALUES
        ('e1000001-0000-4000-8000-000000000001', 'Highlands Coffee', 'highlands coffee', 'Ho Chi Minh City · Branch profile', 'VN'),
        ('e1000001-0000-4000-8000-000000000002', 'Highlands Coffee', 'highlands coffee', 'Hanoi · Branch profile', 'VN'),
        ('e2000001-0000-4000-8000-000000000001', 'Starbucks', 'starbucks', 'Ho Chi Minh City · Branch profile', 'VN'),
        ('e2000001-0000-4000-8000-000000000002', 'Starbucks', 'starbucks', 'Hanoi · Branch profile', 'VN'),
        ('e3000001-0000-4000-8000-000000000001', 'Phuc Long Coffee & Tea', 'phuc long coffee tea', 'Ho Chi Minh City · Branch profile', 'VN'),
        ('e3000001-0000-4000-8000-000000000002', 'Phuc Long Coffee & Tea', 'phuc long coffee tea', 'Hanoi · Branch profile', 'VN')
      ON CONFLICT ("id") DO UPDATE SET
        "name_raw" = EXCLUDED."name_raw",
        "name_normalized" = EXCLUDED."name_normalized",
        "location_text" = EXCLUDED."location_text",
        "country_code" = EXCLUDED."country_code",
        "updated_at" = now();
    `);

    // MCC 5814 covers quick-service merchants including coffee shops.
    // Delivery-platform coding depends on the actual acquirer/gateway, so the
    // MCC 5812 mappings below intentionally carry lower confidence.
    await queryRunner.query(`
      INSERT INTO "merchant_mcc_candidates"
        (
          "id",
          "merchant_id",
          "mcc_code",
          "payment_type",
          "source",
          "confidence_score",
          "status"
        )
      VALUES
        ('f1000001-0000-4000-8000-000000000001', 'e1000001-0000-4000-8000-000000000001', '5814', 'in_store', '${SEED_SOURCE}', 0.700, 'suggested'),
        ('f1000001-0000-4000-8000-000000000002', 'e1000001-0000-4000-8000-000000000001', '5812', 'shopee_food', '${SEED_SOURCE}', 0.450, 'suggested'),
        ('f1000001-0000-4000-8000-000000000003', 'e1000001-0000-4000-8000-000000000001', '5812', 'grab_food', '${SEED_SOURCE}', 0.450, 'suggested'),
        ('f1000001-0000-4000-8000-000000000004', 'e1000001-0000-4000-8000-000000000002', '5814', 'in_store', '${SEED_SOURCE}', 0.700, 'suggested'),
        ('f1000001-0000-4000-8000-000000000005', 'e1000001-0000-4000-8000-000000000002', '5812', 'shopee_food', '${SEED_SOURCE}', 0.450, 'suggested'),
        ('f1000001-0000-4000-8000-000000000006', 'e1000001-0000-4000-8000-000000000002', '5812', 'grab_food', '${SEED_SOURCE}', 0.450, 'suggested'),

        ('f2000001-0000-4000-8000-000000000001', 'e2000001-0000-4000-8000-000000000001', '5814', 'in_store', '${SEED_SOURCE}', 0.700, 'suggested'),
        ('f2000001-0000-4000-8000-000000000002', 'e2000001-0000-4000-8000-000000000001', '5812', 'shopee_food', '${SEED_SOURCE}', 0.450, 'suggested'),
        ('f2000001-0000-4000-8000-000000000003', 'e2000001-0000-4000-8000-000000000001', '5812', 'grab_food', '${SEED_SOURCE}', 0.450, 'suggested'),
        ('f2000001-0000-4000-8000-000000000004', 'e2000001-0000-4000-8000-000000000002', '5814', 'in_store', '${SEED_SOURCE}', 0.700, 'suggested'),
        ('f2000001-0000-4000-8000-000000000005', 'e2000001-0000-4000-8000-000000000002', '5812', 'shopee_food', '${SEED_SOURCE}', 0.450, 'suggested'),
        ('f2000001-0000-4000-8000-000000000006', 'e2000001-0000-4000-8000-000000000002', '5812', 'grab_food', '${SEED_SOURCE}', 0.450, 'suggested'),

        ('f3000001-0000-4000-8000-000000000001', 'e3000001-0000-4000-8000-000000000001', '5814', 'in_store', '${SEED_SOURCE}', 0.700, 'suggested'),
        ('f3000001-0000-4000-8000-000000000002', 'e3000001-0000-4000-8000-000000000001', '5812', 'shopee_food', '${SEED_SOURCE}', 0.450, 'suggested'),
        ('f3000001-0000-4000-8000-000000000003', 'e3000001-0000-4000-8000-000000000001', '5812', 'grab_food', '${SEED_SOURCE}', 0.450, 'suggested'),
        ('f3000001-0000-4000-8000-000000000004', 'e3000001-0000-4000-8000-000000000002', '5814', 'in_store', '${SEED_SOURCE}', 0.700, 'suggested'),
        ('f3000001-0000-4000-8000-000000000005', 'e3000001-0000-4000-8000-000000000002', '5812', 'shopee_food', '${SEED_SOURCE}', 0.450, 'suggested'),
        ('f3000001-0000-4000-8000-000000000006', 'e3000001-0000-4000-8000-000000000002', '5812', 'grab_food', '${SEED_SOURCE}', 0.450, 'suggested')
      ON CONFLICT ("merchant_id", "mcc_code", "payment_type")
      DO UPDATE SET
        "source" = EXCLUDED."source",
        "confidence_score" = EXCLUDED."confidence_score",
        "status" = EXCLUDED."status",
        "updated_at" = now();
    `);
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `
        DELETE FROM "merchant_mcc_candidates"
        WHERE "merchant_id" = ANY($1::uuid[])
          AND "source" = $2
      `,
      [MERCHANT_IDS, SEED_SOURCE],
    );
    await queryRunner.query(
      `DELETE FROM "merchants" WHERE "id" = ANY($1::uuid[])`,
      [MERCHANT_IDS],
    );
  }
}
