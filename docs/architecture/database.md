# Database Design Document
# CardPilot - Credit Card Cashback & Rewards Intelligence Platform

**Version:** 1.0
**Date:** 2026-07-22

> Toàn bộ schema dưới đây được copy trực tiếp từ migration thật: `apps/cardpilot-backend/src/database/migrations/1784410000000-create-initial-schema.ts` (migration duy nhất tồn tại tại thời điểm viết tài liệu này). Chưa có TypeORM entity class nào trong code — `AppModule` bật `autoLoadEntities: true` nhưng hiện không có gì để load. Coi migration này là **nguồn sự thật duy nhất** cho DB schema.

---

## 1. Database Strategy Overview

| Database | Type | Purpose | Trạng thái |
|----------|------|---------|-----------|
| PostgreSQL (Supabase-hosted) | Relational (OLTP) | Toàn bộ dữ liệu nghiệp vụ — source of truth | Active (schema tồn tại, chưa có application code đọc/ghi) |
| SQLite (on-device, Flutter) | Embedded | Cache cục bộ cho chế độ local-first / offline | Planned — chưa có dependency (`sqflite`/`drift`/...) nào trong `pubspec.yaml` |

Kết nối runtime dùng `DATABASE_URL` (khuyến nghị Supabase session pooler); migration CLI dùng `DIRECT_DATABASE_URL` (kết nối trực tiếp, fallback về `DATABASE_URL` nếu không có) — xem `apps/cardpilot-backend/src/database/data-source.ts`.

---

## 2. PostgreSQL - Core Schema

### 2.1 ERD Overview

```mermaid
erDiagram
    users ||--o{ user_memberships : "has"
    memberships ||--o{ user_memberships : "assigned via"
    users ||--o{ user_cards : "owns"
    banks ||--o{ credit_cards : "issues"
    credit_cards ||--o{ user_cards : "instance of"
    credit_cards ||--o{ reward_rules : "has"
    reward_rules ||--o{ reward_rule_mccs : "applies to"
    merchant_category_codes ||--o{ reward_rule_mccs : "matched by"
    merchant_category_codes ||--o{ merchant_mcc_candidates : "candidate for"
    merchants ||--o{ merchant_mcc_candidates : "has"
    users ||--o{ transactions : "logs"
    user_cards ||--o{ transactions : "used in"
    merchants ||--o{ transactions : "at (nullable)"
    merchant_category_codes ||--o{ transactions : "mcc (nullable)"
    users ||--o{ merchant_mcc_feedbacks : "submits"
    merchants ||--o{ merchant_mcc_feedbacks : "about"
    transactions ||--o{ merchant_mcc_feedbacks : "evidence (nullable)"
    merchant_category_codes ||--o{ merchant_mcc_feedbacks : "suggests"
    transactions ||--o{ cashback_calculations : "computed for"
    user_cards ||--o{ cashback_calculations : "on card"
    reward_rules ||--o{ cashback_calculations : "applied rule (nullable)"

    users {
        uuid id PK
        varchar email UK
        varchar full_name
        timestamp born_date
        varchar method_login
        timestamptz created_at
    }
    memberships {
        uuid id PK
        varchar name UK
        integer max_cards
        integer max_receipt_scans_per_month
        integer max_cashback_calculations_per_month
        timestamptz created_at
    }
    user_memberships {
        uuid id PK
        uuid user_id FK
        uuid membership_id FK
        varchar status
        timestamptz started_at
        timestamptz expired_at
        timestamptz created_at
    }
    banks {
        uuid id PK
        varchar swift_code
        varchar name
        timestamptz created_at
    }
    credit_cards {
        uuid id PK
        uuid bank_id FK
        varchar name
        varchar network
        varchar card_type
        numeric annual_fee
        text source_url
        timestamptz last_verified_at
        boolean is_active
        timestamptz created_at
    }
    user_cards {
        uuid id PK
        uuid user_id FK
        uuid credit_card_id FK
        varchar nickname
        integer billing_cycle_day
        boolean is_default
        boolean has_annual_fee
        timestamptz created_at
    }
    merchant_category_codes {
        varchar code PK
        text description
        varchar category
        boolean is_active
        timestamptz created_at
        timestamptz updated_at
    }
    merchants {
        uuid id PK
        text name_raw
        text name_normalized
        text location_text
        varchar country_code
        timestamptz created_at
    }
    merchant_mcc_candidates {
        uuid id PK
        uuid merchant_id FK
        varchar mcc_code FK
        varchar source
        numeric confidence_score
        integer feedback_count
        integer verified_count
        varchar status
        timestamptz last_observed_at
        timestamptz created_at
    }
    transactions {
        uuid id PK
        uuid user_id FK
        uuid user_card_id FK
        uuid merchant_id FK
        timestamptz transaction_date
        numeric amount
        varchar currency
        varchar mcc_code FK
        varchar mcc_source
        varchar category
        numeric cashback_estimated_amount
        numeric cashback_confidence
        varchar source
        text note
        timestamptz created_at
    }
    merchant_mcc_feedbacks {
        uuid id PK
        uuid user_id FK
        uuid merchant_id FK
        uuid transaction_id FK
        varchar suggested_mcc_code FK
        varchar evidence_type
        text note
        varchar status
        timestamptz created_at
    }
    reward_rules {
        uuid id PK
        uuid credit_card_id FK
        varchar name
        varchar reward_type
        numeric cashback_rate
        numeric points_rate
        numeric monthly_cap_amount
        numeric minimum_transaction_amount
        numeric minimum_monthly_spend
        varchar eligible_channel
        text conditions_text
        date effective_from
        date effective_to
        text source_url
        numeric confidence
        timestamptz last_verified_at
        boolean is_active
        timestamptz created_at
    }
    reward_rule_mccs {
        uuid id PK
        uuid reward_rule_id FK
        varchar mcc_code FK
        varchar match_type
    }
    cashback_calculations {
        uuid id PK
        uuid transaction_id FK
        uuid user_card_id FK
        uuid reward_rule_id FK
        numeric estimated_cashback_amount
        numeric applied_rate
        numeric confidence
        text explanation
        varchar status
        timestamptz created_at
    }
```

### 2.2 Table Definitions

Copy nguyên trạng từ migration `1784410000000-create-initial-schema.ts` (thứ tự tạo bảng = thứ tự dependency FK):

```sql
-- =============================================
-- USERS & MEMBERSHIP
-- =============================================

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

-- =============================================
-- CARDS
-- =============================================

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

-- =============================================
-- MCC & MERCHANTS
-- =============================================

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

-- =============================================
-- TRANSACTIONS
-- =============================================

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

-- =============================================
-- REWARD RULES & CASHBACK
-- =============================================

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
```

### 2.3 Ghi chú thiết kế quan trọng

- **Không có cột nào được enforce bằng Postgres CHECK/enum** ngoài FK constraints. Các cột "trông giống enum" hiện tại chỉ là `varchar` tự do: `user_memberships.status`, `credit_cards.network`/`card_type`, `merchant_mcc_candidates.source`/`status`, `transactions.mcc_source`/`source`, `merchant_mcc_feedbacks.evidence_type`/`status`, `reward_rules.reward_type`/`eligible_channel`, `reward_rule_mccs.match_type`, `cashback_calculations.status`. Khi build application layer, cân nhắc thêm CHECK constraint hoặc validate ở tầng service để tránh giá trị rác.
- `merchant_category_codes.code` là PK dạng `varchar(4)` (chính MCC code, VD "5812"), không phải UUID — khác với mọi bảng khác.
- Không có cột `updated_at` ở hầu hết các bảng (ngoại trừ `merchant_category_codes`) — cân nhắc bổ sung nếu cần audit thay đổi.
- Tất cả FK dùng `DEFERRABLE INITIALLY IMMEDIATE`.
- `transactions.source` mặc định `'manual'` — thiết kế đã chừa chỗ cho nguồn khác (`ocr`, `import`, ...) ở Phase 2 mà không cần đổi schema.

---

## 3. Local Cache Schema (SQLite, Mobile)

**Chưa implement.** `apps/cardpilot-mobile/apps/cardpilot_app/pubspec.yaml` hiện không khai báo `sqflite`/`drift`/`hive`/`isar` hay bất kỳ thư viện local-database nào — mọi dữ liệu trong app (kể cả onboarding slides) hiện là hardcode in-memory, không persist qua restart.

Khi implement local-first mode (`BRD` #9 Constraints), cần thiết kế tối thiểu:

| Local Table (đề xuất) | Map với bảng Postgres | Ghi chú |
|--------------------------|--------------------------|---------|
| `local_transactions` | `transactions` | Ghi trước khi có mạng; đánh dấu `is_synced` |
| `local_cashback_calculations` | `cashback_calculations` | Có thể tính lại tại chỗ (client-side) nếu đã cache `reward_rules` liên quan |
| `local_user_cards` | `user_cards` | Cache thẻ user đã thêm |
| `local_reward_rules_cache` | `reward_rules` + `reward_rule_mccs` | Cache read-only, refresh định kỳ khi có mạng |

**Open question chưa có lời giải** (xem `BRD` #9, `SRS` FR-AUTH-08): cơ chế xác định giao dịch hợp lệ khi đồng bộ (tránh user chỉnh sửa local rồi sync để gian lận điểm thưởng/level), và chiến lược xử lý xung đột (conflict resolution) khi cùng 1 giao dịch tồn tại cả local lẫn cloud. Phải giải quyết trước khi bật tính năng "Sync" cho người dùng thật.

---

## 4. Data Migration Strategy

| Migration File | Mô tả |
|-----------------|--------|
| `1784410000000-create-initial-schema.ts` | Migration duy nhất — tạo toàn bộ 14 bảng (users → memberships → user_memberships → banks → credit_cards → user_cards → merchant_category_codes → merchants → merchant_mcc_candidates → transactions → merchant_mcc_feedbacks → reward_rules → reward_rule_mccs → cashback_calculations) theo đúng thứ tự dependency FK, kèm indexes trên `merchant_mcc_feedbacks`. `down()` drop toàn bộ theo thứ tự ngược lại. |

Chạy migration qua:
```bash
pnpm migration:show
pnpm migration:run
pnpm migration:revert
```
(dùng `apps/cardpilot-backend/src/database/data-source.ts` làm DataSource — ưu tiên `DIRECT_DATABASE_URL`, fallback `DATABASE_URL`.)

### Backup Strategy

Chưa có quy trình backup riêng — phụ thuộc backup mặc định của Supabase (managed Postgres). Chưa có tài liệu/kiểm chứng về tần suất & retention thật của backup Supabase cho project này — **TBD**, cần xác nhận trong Supabase dashboard của dự án.

---

**Tài liệu liên quan:** [SRS](../SRS.md) · [API Design](./api.md) · [System Architecture](./system.md)
