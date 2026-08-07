# MCC Migration Guide

Tài liệu này hướng dẫn thêm Merchant Category Code (MCC) mới và map MCC vào
reward rule trong PostgreSQL của CardPilot. Mọi thay đổi dữ liệu master phải đi
qua TypeORM migration; không sửa migration đã được apply ở bất kỳ môi trường
nào.

## 1. Phân biệt hai loại thay đổi

- Thêm MCC master mới: insert vào `merchant_category_codes` trước khi bảng khác
  tham chiếu tới code đó.
- Map MCC đã tồn tại vào rule: insert vào `reward_rule_mccs`; không insert lại
  MCC master.

`merchant_category_codes.code` là khóa chính `varchar(4)`. Bảng
`reward_rule_mccs` có foreign key tới code này và unique constraint trên bộ
`(reward_rule_id, mcc_code, match_type)`.

## 2. Chuẩn bị dữ liệu

Trước khi viết migration:

1. Xác nhận MCC gồm đúng bốn chữ số và tra mô tả từ nguồn Visa/Mastercard hoặc
   tài liệu ngân hàng có thể kiểm chứng.
2. Kiểm tra MCC đã tồn tại trong seed/migration hay chưa:

   ```bash
   rg '\["5262"|\("5262"' apps/cardpilot-backend/src/database/migrations
   ```

3. Với reward rule, lưu `source_url`, `effective_from`, `effective_to` và
   `last_verified_at` khi nguồn cung cấp các thông tin đó. Không suy đoán tỷ lệ,
   hạn mức hoặc MCC từ tên chương trình.
4. Xác định `match_type`: hiện dữ liệu dùng `eligible`; chỉ dùng giá trị khác
   khi application contract đã định nghĩa rõ.

## 3. Tạo migration

Chạy từ repository root:

```bash
pnpm migration:create add-mcc-5262
```

File được tạo tại:

```text
apps/cardpilot-backend/src/database/migrations/<timestamp>-add-mcc-5262.ts
```

Tên class và thuộc tính `name` phải giữ nguyên timestamp do TypeORM tạo.

## 4. Template thêm MCC master mới

Chỉ dùng template này sau khi đã xác nhận code chưa tồn tại. Không dùng
`ON CONFLICT DO UPDATE` để âm thầm ghi đè dữ liệu master thuộc migration cũ.

```ts
import { MigrationInterface, QueryRunner } from 'typeorm';

export class AddMcc5262<TIMESTAMP> implements MigrationInterface {
  name = 'AddMcc5262<TIMESTAMP>';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`
      INSERT INTO "merchant_category_codes"
        ("code", "description", "category", "is_active", "valid_payment")
      VALUES
        ('5262', 'Marketplaces', 'Retail outlet services', true, 'VM');
    `);
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`
      DELETE FROM "merchant_category_codes"
      WHERE "code" = '5262';
    `);
  }
}
```

Thay `<TIMESTAMP>` bằng timestamp thật trong tên file. `down()` sẽ thất bại nếu
MCC đã được dữ liệu khác tham chiếu; đây là hành vi an toàn hơn việc cascade và
xóa nhầm reward/transaction.

## 5. Template map MCC vào reward rule

MCC và reward rule phải tồn tại trước khi insert mapping:

```ts
import { MigrationInterface, QueryRunner } from 'typeorm';

const REWARD_RULE_ID = '00000000-0000-4000-8000-000000000000';

export class MapMcc5262ToRewardRule<TIMESTAMP> implements MigrationInterface {
  name = 'MapMcc5262ToRewardRule<TIMESTAMP>';

  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `
        INSERT INTO "reward_rule_mccs"
          ("id", "reward_rule_id", "mcc_code", "match_type")
        VALUES
          (gen_random_uuid(), $1::uuid, '5262', 'eligible')
        ON CONFLICT ("reward_rule_id", "mcc_code", "match_type")
          DO NOTHING
      `,
      [REWARD_RULE_ID],
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `
        DELETE FROM "reward_rule_mccs"
        WHERE "reward_rule_id" = $1::uuid
          AND "mcc_code" = '5262'
          AND "match_type" = 'eligible'
      `,
      [REWARD_RULE_ID],
    );
  }
}
```

Nếu cùng một thay đổi cần thêm MCC và mapping, thứ tự trong `up()` là MCC →
reward rule → mapping; thứ tự trong `down()` phải đảo lại: mapping → reward
rule → MCC.

## 6. Kiểm tra migration

Chạy PostgreSQL local và kiểm tra migration theo cả hai chiều:

```bash
pnpm infra
pnpm migration:show
pnpm migration:run
pnpm migration:revert
pnpm migration:run
```

Sau lần `run`, xác nhận MCC và mapping không bị nhân đôi. Chạy validation backend:

```bash
pnpm nx run cardpilot-backend:lint
pnpm nx run cardpilot-backend:test
pnpm nx run cardpilot-backend:build
```

Không chạy `migration:revert` trên database dùng chung hoặc production nếu chưa
xác định chính xác migration và dữ liệu phụ thuộc sẽ bị ảnh hưởng.
