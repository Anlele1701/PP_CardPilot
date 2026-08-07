import { MigrationInterface, QueryRunner } from 'typeorm';

const MSB_CARD_IDS = [
  'c1111111-1111-1111-1111-111111111111',
  'c2222222-2222-2222-2222-222222222222',
  'c3333333-3333-3333-3333-333333333333',
  'c4444444-4444-4444-4444-444444444444',
] as const;

const MSB_REWARD_RULE_IDS = [
  'd1111111-1111-1111-1111-111111111111',
  'd1111112-1111-1111-1111-111111111111',
  'd1111113-1111-1111-1111-111111111111',
  'd2222221-2222-2222-2222-222222222222',
  'd3333331-3333-3333-3333-333333333333',
  'd4444441-4444-4444-4444-444444444444',
] as const;

export class SeedMsbBankData1786072168025 implements MigrationInterface {
  name = 'SeedMsbBankData1786072168025';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`
      DO $$
      BEGIN
        IF NOT EXISTS (
          SELECT 1 FROM "banks" WHERE "swift_code" = 'MCOBVNVX'
        ) THEN
          RAISE EXCEPTION 'MSB bank with swift_code MCOBVNVX is required';
        END IF;
      END
      $$;
    `);

    await queryRunner.query(`
      INSERT INTO "merchant_category_codes"
        ("code", "description", "category", "is_active", "valid_payment")
      VALUES
        ('5262', 'Marketplaces', 'Retail outlet services', true, 'VM')
      ON CONFLICT ("code") DO UPDATE SET
        "description" = EXCLUDED."description",
        "category" = EXCLUDED."category",
        "is_active" = EXCLUDED."is_active",
        "valid_payment" = EXCLUDED."valid_payment",
        "updated_at" = now();
    `);

    await queryRunner.query(`
      INSERT INTO "credit_cards"
        ("id", "bank_id", "name", "network", "card_type", "is_active", "last_verified_at")
      SELECT
        card."id"::uuid,
        bank."id",
        card."name",
        card."network",
        'credit',
        true,
        now()
      FROM "banks" bank
      CROSS JOIN (
        VALUES
          ('c1111111-1111-1111-1111-111111111111', 'MSB Mastercard mDigi', 'Mastercard'),
          ('c2222222-2222-2222-2222-222222222222', 'MSB Visa Travel', 'Visa'),
          ('c3333333-3333-3333-3333-333333333333', 'MSB Visa Online', 'Visa'),
          ('c4444444-4444-4444-4444-444444444444', 'MSB Visa Signature', 'Visa')
      ) AS card("id", "name", "network")
      WHERE bank."swift_code" = 'MCOBVNVX'
      ON CONFLICT ("id") DO UPDATE SET
        "bank_id" = EXCLUDED."bank_id",
        "name" = EXCLUDED."name",
        "network" = EXCLUDED."network",
        "card_type" = EXCLUDED."card_type",
        "is_active" = EXCLUDED."is_active",
        "last_verified_at" = EXCLUDED."last_verified_at",
        "updated_at" = now();
    `);

    // Source and effective dates were not supplied, so provenance fields remain
    // null instead of recording policy metadata that has not been verified.
    await queryRunner.query(`
      INSERT INTO "reward_rules"
        (
          "id",
          "credit_card_id",
          "name",
          "reward_type",
          "cashback_rate",
          "monthly_cap_amount",
          "minimum_monthly_spend",
          "eligible_channel",
          "conditions_text"
        )
      VALUES
        (
          'd1111111-1111-1111-1111-111111111111',
          'c1111111-1111-1111-1111-111111111111',
          'mDigi - Hoàn tiền Ẩm Thực 20%',
          'cashback', 0.2000, 300000.00, 0.00, 'any',
          'Khách hàng phải chọn danh mục Ẩm thực trên app MSB.'
        ),
        (
          'd1111112-1111-1111-1111-111111111111',
          'c1111111-1111-1111-1111-111111111111',
          'mDigi - Hoàn tiền Du Lịch 20%',
          'cashback', 0.2000, 300000.00, 0.00, 'any',
          'Khách hàng phải chọn danh mục Du lịch trên app MSB.'
        ),
        (
          'd1111113-1111-1111-1111-111111111111',
          'c1111111-1111-1111-1111-111111111111',
          'mDigi - Hoàn tiền Sản Phẩm Số 20%',
          'cashback', 0.2000, 300000.00, 0.00, 'any',
          'Khách hàng phải chọn danh mục Sản phẩm số trên app MSB.'
        ),
        (
          'd2222221-2222-2222-2222-222222222222',
          'c2222222-2222-2222-2222-222222222222',
          'Travel - Hoàn tiền Du lịch & Di chuyển 6%',
          'cashback', 0.0600, 600000.00, 0.00, 'any',
          'Bao gồm ăn uống ở nước ngoài, đặt phòng, vé máy bay, di chuyển.'
        ),
        (
          'd3333331-3333-3333-3333-333333333333',
          'c3333333-3333-3333-3333-333333333333',
          'Online - Hoàn tiền TMĐT (Shopee, Lazada)',
          'cashback', 0.1000, 300000.00, 0.00, 'online',
          'Chỉ áp dụng giao dịch trực tuyến trên các MCC được quy định (hoặc Gateway của Shopee/Lazada).'
        ),
        (
          'd4444441-4444-4444-4444-444444444444',
          'c4444444-4444-4444-4444-444444444444',
          'Signature - Hoàn 10% Đặc Quyền (Ẩm thực, Y tế, Giáo dục, Bảo hiểm)',
          'cashback', 0.1000, 1000000.00, 15000000.00, 'any',
          'Yêu cầu tổng chi tiêu trong tháng (từ mọi giao dịch) phải đạt tối thiểu 15 triệu VNĐ.'
        )
      ON CONFLICT ("id") DO UPDATE SET
        "credit_card_id" = EXCLUDED."credit_card_id",
        "name" = EXCLUDED."name",
        "reward_type" = EXCLUDED."reward_type",
        "cashback_rate" = EXCLUDED."cashback_rate",
        "monthly_cap_amount" = EXCLUDED."monthly_cap_amount",
        "minimum_monthly_spend" = EXCLUDED."minimum_monthly_spend",
        "eligible_channel" = EXCLUDED."eligible_channel",
        "conditions_text" = EXCLUDED."conditions_text",
        "is_active" = true,
        "updated_at" = now();
    `);

    await queryRunner.query(`
      INSERT INTO "reward_rule_mccs"
        ("id", "reward_rule_id", "mcc_code", "match_type")
      VALUES
        (gen_random_uuid(), 'd1111111-1111-1111-1111-111111111111', '5812', 'eligible'),
        (gen_random_uuid(), 'd1111111-1111-1111-1111-111111111111', '5813', 'eligible'),
        (gen_random_uuid(), 'd1111111-1111-1111-1111-111111111111', '5814', 'eligible'),
        (gen_random_uuid(), 'd1111112-1111-1111-1111-111111111111', '4722', 'eligible'),
        (gen_random_uuid(), 'd1111112-1111-1111-1111-111111111111', '7011', 'eligible'),
        (gen_random_uuid(), 'd1111113-1111-1111-1111-111111111111', '5815', 'eligible'),
        (gen_random_uuid(), 'd1111113-1111-1111-1111-111111111111', '5816', 'eligible'),
        (gen_random_uuid(), 'd1111113-1111-1111-1111-111111111111', '5817', 'eligible'),
        (gen_random_uuid(), 'd1111113-1111-1111-1111-111111111111', '5818', 'eligible'),
        (gen_random_uuid(), 'd1111113-1111-1111-1111-111111111111', '4899', 'eligible'),
        (gen_random_uuid(), 'd1111113-1111-1111-1111-111111111111', '7829', 'eligible'),
        (gen_random_uuid(), 'd1111113-1111-1111-1111-111111111111', '7841', 'eligible'),
        (gen_random_uuid(), 'd2222221-2222-2222-2222-222222222222', '5812', 'eligible'),
        (gen_random_uuid(), 'd2222221-2222-2222-2222-222222222222', '5813', 'eligible'),
        (gen_random_uuid(), 'd2222221-2222-2222-2222-222222222222', '5814', 'eligible'),
        (gen_random_uuid(), 'd2222221-2222-2222-2222-222222222222', '7011', 'eligible'),
        (gen_random_uuid(), 'd2222221-2222-2222-2222-222222222222', '4511', 'eligible'),
        (gen_random_uuid(), 'd2222221-2222-2222-2222-222222222222', '4582', 'eligible'),
        (gen_random_uuid(), 'd2222221-2222-2222-2222-222222222222', '4121', 'eligible'),
        (gen_random_uuid(), 'd2222221-2222-2222-2222-222222222222', '4131', 'eligible'),
        (gen_random_uuid(), 'd2222221-2222-2222-2222-222222222222', '4011', 'eligible'),
        (gen_random_uuid(), 'd2222221-2222-2222-2222-222222222222', '4111', 'eligible'),
        (gen_random_uuid(), 'd2222221-2222-2222-2222-222222222222', '4112', 'eligible'),
        (gen_random_uuid(), 'd2222221-2222-2222-2222-222222222222', '4789', 'eligible'),
        (gen_random_uuid(), 'd2222221-2222-2222-2222-222222222222', '4722', 'eligible'),
        (gen_random_uuid(), 'd2222221-2222-2222-2222-222222222222', '5309', 'eligible'),
        (gen_random_uuid(), 'd3333331-3333-3333-3333-333333333333', '5311', 'eligible'),
        (gen_random_uuid(), 'd3333331-3333-3333-3333-333333333333', '5262', 'eligible'),
        (gen_random_uuid(), 'd3333331-3333-3333-3333-333333333333', '5732', 'eligible'),
        (gen_random_uuid(), 'd3333331-3333-3333-3333-333333333333', '4814', 'eligible'),
        (gen_random_uuid(), 'd3333331-3333-3333-3333-333333333333', '5399', 'eligible'),
        (gen_random_uuid(), 'd3333331-3333-3333-3333-333333333333', '4900', 'eligible'),
        (gen_random_uuid(), 'd4444441-4444-4444-4444-444444444444', '5812', 'eligible'),
        (gen_random_uuid(), 'd4444441-4444-4444-4444-444444444444', '5814', 'eligible'),
        (gen_random_uuid(), 'd4444441-4444-4444-4444-444444444444', '8011', 'eligible'),
        (gen_random_uuid(), 'd4444441-4444-4444-4444-444444444444', '8062', 'eligible'),
        (gen_random_uuid(), 'd4444441-4444-4444-4444-444444444444', '5912', 'eligible'),
        (gen_random_uuid(), 'd4444441-4444-4444-4444-444444444444', '8211', 'eligible'),
        (gen_random_uuid(), 'd4444441-4444-4444-4444-444444444444', '8220', 'eligible'),
        (gen_random_uuid(), 'd4444441-4444-4444-4444-444444444444', '8299', 'eligible'),
        (gen_random_uuid(), 'd4444441-4444-4444-4444-444444444444', '6300', 'eligible')
      ON CONFLICT ("reward_rule_id", "mcc_code", "match_type") DO NOTHING;
    `);
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `DELETE FROM "reward_rule_mccs" WHERE "reward_rule_id" = ANY($1::uuid[])`,
      [MSB_REWARD_RULE_IDS],
    );

    await queryRunner.query(
      `DELETE FROM "reward_rules" WHERE "id" = ANY($1::uuid[])`,
      [MSB_REWARD_RULE_IDS],
    );

    await queryRunner.query(
      `DELETE FROM "credit_cards" WHERE "id" = ANY($1::uuid[])`,
      [MSB_CARD_IDS],
    );

    await queryRunner.query(
      `DELETE FROM "merchant_category_codes" WHERE "code" = '5262'`,
    );
  }
}
