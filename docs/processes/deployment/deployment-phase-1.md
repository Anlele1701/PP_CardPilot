# Phase 1 - MVP: Local-first + Core Tracking
# CardPilot

**Status:** In Progress (schema tồn tại qua migration, application layer chưa build)
**Timeline:** TBD — chưa có cam kết thời gian chính thức
**Goal:** Cho phép user thêm thẻ tín dụng, ghi log giao dịch thủ công, và xem tình trạng hoàn tiền theo từng thẻ (Cashback Jar) + phân bổ chi tiêu theo MCC — hoàn toàn dùng được ở chế độ local-only (không cần tài khoản)
**User Scale:** TBD

---

## 1. Technology Stack

| Component | Technology |
|-----------|-----------|
| Mobile | Flutter (Riverpod `^3.0.0`, Clean Architecture theo feature) |
| Backend | NestJS `11.x` + Fastify adapter + TypeORM, modular monolith với bounded contexts |
| Database | PostgreSQL 17 (Supabase-hosted production, `postgres:17-alpine` local dev qua Docker Compose) |
| Auth | Supabase Auth trên mobile; backend Auth Guard và bootstrap `auth.users` → `public.users` còn pending |
| Local storage | Drift/SQLite proposed; schema v1 and implementation slices await review (`ARCH-SQLITE`) |
| Infra | Docker Compose (Postgres local), Render (backend hosting), Docker Hub (image registry) |
| CI/CD | GitHub Actions — build & deploy trên `develop` (chưa có CI trên PR) |

---

## 2. Screens

| # | Screen | Mô tả | Depends On |
|---|--------|--------|-----------|
| S01 | Splash | Planned; hiện app vào thẳng Sign in và dùng session redirector | — |
| S02 | Onboarding carousel | Đã xoá theo quyết định sản phẩm; không nằm trong flow hiện tại | — |
| S03 | Login | Supabase email/password + Google/Facebook OAuth, Continue as guest, forgot-password placeholder | — |
| S04 | Register | Supabase email/password + Google/Facebook OAuth | S03 |
| S05 | Forgot Password | Nhập email → gửi link/OTP reset | S03 |
| S06 | Dashboard (Home) | Danh sách Cashback Jar theo từng thẻ, biểu đồ tròn Category, empty state mời "Thêm thẻ đầu tiên" nếu chưa có thẻ | S03 hoặc S04 (hoặc Skip) |
| S07 | Add/Edit Card | Chọn ngân hàng → chọn sản phẩm thẻ → nhập nickname, billing cycle day, is_default | S06 |
| S08 | Card List | Danh sách thẻ đã thêm, tap để sửa/xoá | S06 |
| S09 | Add Transaction | Chọn thẻ đã dùng, nhập merchant (gợi ý MCC nếu match), số tiền, ngày, ghi chú | S06 |
| S10 | Transaction History | Danh sách giao dịch đã log, filter theo thẻ/khoảng thời gian | S06 |
| S11 | Transaction Detail | Chi tiết giao dịch + cashback ước tính, nút gửi feedback MCC nếu sai | S10 |
| S12 | Profile | Xem thông tin cá nhân + membership level hiện tại, nút Đăng xuất | S06 |
| S13 | Edit Profile | Sửa `full_name`, `born_date` | S12 |

---

## 3. Database / ERD

### 3.1. ERD Reference

| Source | Section | Mô tả |
|--------|---------|--------|
| **ARCH-DB** | #2.1, #2.2 | ERD Overview + Table Definitions đầy đủ (toàn bộ 14 bảng đã tồn tại qua 1 migration) |
| **SRS** | FR-AUTH-01→09, FR-MEMBER-01→02, FR-CARD-01→04, FR-RULE-01→05, FR-MCC-01→05, FR-TXN-01→04, FR-DASH-01→02 | Phase 1 functional requirements |
| **BRD** | #6.1→6.7 | Core Features driving data model |
| **ARCH-SQLITE** | `architecture/mobile-sqlite.md` | Mobile schema v1/v2, cache, sync, migrations, and tests |

> Toàn bộ schema Postgres của Phase 1 **đã tồn tại** qua migration `1784410000000-create-initial-schema.ts`. Supabase Auth đã được chọn nên CardPilot không tạo bảng `refresh_tokens` riêng; vẫn cần chốt migration/mapping cho `auth.users.id` ↔ `public.users.id` nếu schema hiện tại chưa đáp ứng flow bootstrap.

### 3.2. ERD Diagram

Xem đầy đủ tại `ARCH-DB` #2.1. Subset các bảng dùng trong Phase 1 = **toàn bộ 14 bảng** (không có bảng nào bị hoãn sang Phase 2 — `merchant_mcc_candidates`/`merchant_mcc_feedbacks` có schema và CRUD cơ bản ở Phase 1, chỉ có phần **tự động hoá qua OCR** là hoãn sang Phase 2).

### 3.3. Tables / Entities

| # | Table / Entity | Change Type | Mô tả | Ref |
|---|----------------|-------------|--------|-----|
| T01-T14 | Toàn bộ 14 bảng (`users`, `memberships`, `user_memberships`, `banks`, `credit_cards`, `user_cards`, `merchant_category_codes`, `merchants`, `merchant_mcc_candidates`, `transactions`, `merchant_mcc_feedbacks`, `reward_rules`, `reward_rule_mccs`, `cashback_calculations`) | Existing (đã tạo qua migration, chưa có application code) | Xem field đầy đủ tại `ARCH-DB` #2.2 | ARCH-DB #2.2 |
| T15 | Custom `refresh_tokens` | Not required | Supabase Auth quản lý refresh-token lifecycle | — | — |

### 3.4. Indexes & Constraints

Xem đầy đủ tại `ARCH-DB` #2.2 — migration hiện tại đã có index trên `merchant_mcc_feedbacks` (`idx_merchant_mcc_feedbacks_merchant_mcc`, `idx_merchant_mcc_feedbacks_user_merchant_transaction`) và các UNIQUE constraint (`uq_merchant_mcc_candidates_merchant_mcc`, `uq_reward_rule_mccs_rule_mcc_match`). Đề xuất bổ sung khi build application layer:

| Table | Index đề xuất | Mục đích |
|-------|------------------|----------|
| `transactions` | `idx_transactions_user_card_date` trên `(user_card_id, transaction_date DESC)` | Query lịch sử giao dịch theo thẻ, sắp xếp mới nhất |
| `user_cards` | `idx_user_cards_user` trên `(user_id)` | Query danh sách thẻ của 1 user |
| `cashback_calculations` | `idx_cashback_calculations_user_card` trên `(user_card_id, created_at DESC)` | Tính tổng hoàn tiền đã dùng trong chu kỳ cho Cashback Jar |

### 3.5. Migration Notes

- **Create order** (đã áp dụng): `users` → `memberships` → `user_memberships` → `banks` → `credit_cards` → `user_cards` → `merchant_category_codes` → `merchants` → `merchant_mcc_candidates` → `transactions` → `merchant_mcc_feedbacks` → `reward_rules` → `reward_rule_mccs` → `cashback_calculations`.
- **Seed data cần thiết cho Phase 1**:
  - `memberships`: 4-5 record (Bronze/Gold/Platinum/Diamond/Obsidian) với giá trị `max_cards`/`max_receipt_scans_per_month`/`max_cashback_calculations_per_month`.
  - `banks` + `credit_cards`: thu thập thủ công ít nhất vài ngân hàng phổ biến (VD: MSB, TPBank) + sản phẩm thẻ chính.
  - `merchant_category_codes`: seed bảng MCC chuẩn (danh sách công khai theo ISO 18245).
  - `reward_rules` + `reward_rule_mccs`: thu thập thủ công chính sách hoàn tiền tương ứng các thẻ đã seed.
- **Breaking changes**: N/A (schema Phase 1 là schema khởi tạo).

### 3.6. Local Database Strategy (Mobile SQLite)

Drift/SQLite schema v1 is proposed for Phase 1 because guest profile and card
data must survive restart. Implement the workspace/profile/card/reference-cache
foundation from `ARCH-SQLITE` first. Network sync may land later, but outbox and
identity decisions must be reviewed before distributing the first schema so the
upgrade path does not lose guest data.

### 3.7. Cache Strategy (Backend)

Chưa cần — traffic thấp ở Phase 1, chưa có Redis/cache layer nào trong scope.

---

## 4. API Endpoints

> Phần lớn endpoint dưới đây là **Planned**. Hiện backend đã có `GET /api/v1`, `GET /api/health` và `GET /api/v1/banks`; mobile auth gọi Supabase trực tiếp.

### Auth / Sync

| Method | Endpoint | Auth | Related Tables | Mô tả |
|--------|----------|------|-----------------|--------|
| POST | `/api/v1/auth/bootstrap` | Supabase Bearer | `users` (RW) | Planned: verify token, tạo/tải backend user idempotently |
| POST | `/api/v1/auth/sync` | Supabase Bearer | `transactions` (W), `user_cards` (W) | Planned: đồng bộ dữ liệu local → cloud lần đầu đăng nhập |

Register, login, OAuth, refresh, forgot-password và logout thuộc Supabase Auth,
không phải password/session endpoint do CardPilot backend phát hành.

### User & Membership (3)

| Method | Endpoint | Auth | Related Tables | Mô tả |
|--------|----------|------|-----------------|--------|
| GET | `/api/v1/users/me` | Supabase Bearer | `users` (R), `user_memberships` (R), `memberships` (R) | Thông tin user + membership tier hiện tại |
| PATCH | `/api/v1/users/me` | Supabase Bearer | `users` (RW) | Sửa `full_name`/`born_date` |
| GET | `/api/v1/memberships` | Supabase Bearer | `memberships` (R) | Danh sách tier + giới hạn (hiển thị lộ trình lên hạng) |

### Card Management (6)

| Method | Endpoint | Auth | Related Tables | Mô tả |
|--------|----------|------|-----------------|--------|
| GET | `/api/v1/banks` | Public (current) | `banks` (R) | Danh sách ngân hàng; đã implement |
| GET | `/api/credit-cards` | Bearer | `credit_cards` (R) | Danh sách sản phẩm thẻ, filter theo bank |
| GET | `/api/user-cards` | Bearer | `user_cards` (R) | Danh sách thẻ user đã thêm |
| POST | `/api/user-cards` | Bearer | `user_cards` (W) | Thêm thẻ |
| PATCH | `/api/user-cards/:id` | Bearer | `user_cards` (RW) | Sửa nickname/billing_cycle_day/is_default |
| DELETE | `/api/user-cards/:id` | Bearer | `user_cards` (W) | Xoá thẻ |

### Card Rule Management (4, Admin)

| Method | Endpoint | Auth | Related Tables | Mô tả |
|--------|----------|------|-----------------|--------|
| GET | `/api/credit-cards/:id/rules` | Bearer | `reward_rules` (R), `reward_rule_mccs` (R) | User xem rule active của thẻ |
| POST | `/api/admin/reward-rules` | Admin | `reward_rules` (W) | Tạo rule |
| PATCH | `/api/admin/reward-rules/:id` | Admin | `reward_rules` (RW) | Sửa rule |
| POST | `/api/admin/reward-rules/:id/mccs` | Admin | `reward_rule_mccs` (W) | Gán MCC cho rule |

### MCC Management (5)

| Method | Endpoint | Auth | Related Tables | Mô tả |
|--------|----------|------|-----------------|--------|
| GET | `/api/mcc` | Bearer | `merchant_category_codes` (R) | Danh sách MCC chuẩn |
| POST | `/api/admin/mcc` | Admin | `merchant_category_codes` (W) | Thêm/sửa MCC |
| GET | `/api/merchants/:id/mcc-candidates` | Bearer | `merchant_mcc_candidates` (R) | Xem suy luận MCC của merchant |
| POST | `/api/merchants/:id/mcc-feedback` | Bearer | `merchant_mcc_feedbacks` (W) | Gửi feedback MCC sai |
| PATCH | `/api/admin/mcc-candidates/:id` | Admin | `merchant_mcc_candidates` (RW) | Duyệt/từ chối candidate |

### Transaction Logging (3)

| Method | Endpoint | Auth | Related Tables | Mô tả |
|--------|----------|------|-----------------|--------|
| POST | `/api/transactions` | Bearer | `transactions` (W), `cashback_calculations` (W) | Ghi log giao dịch thủ công + tính cashback ngay |
| GET | `/api/transactions` | Bearer | `transactions` (R) | Lịch sử giao dịch |
| GET | `/api/transactions/:id` | Bearer | `transactions` (R), `cashback_calculations` (R) | Chi tiết giao dịch |

### Dashboard (2)

| Method | Endpoint | Auth | Related Tables | Mô tả |
|--------|----------|------|-----------------|--------|
| GET | `/api/dashboard/cashback-jars` | Bearer | `user_cards` (R), `reward_rules` (R), `cashback_calculations` (R) | Dữ liệu Cashback Jar theo thẻ |
| GET | `/api/dashboard/category-breakdown` | Bearer | `transactions` (R) | Dữ liệu pie chart theo Category/MCC |

> **Convention**: `(R)` = Read, `(W)` = Write, `(RW)` = Read + Write

**Total: 28 endpoints (Planned)**
**Cumulative (Phase 1): 28 endpoints + 3 endpoint hiện có (system/demo) = 31**

---

## 5. Task Breakdown

### Epic 1: Infrastructure & DevOps Hardening

| ID | Task | Mô tả | Deps | DB Migration | Ref Docs |
|----|------|--------|------|--------------|----------|
| T-001 | CI trên Pull Request | Thêm GitHub Actions workflow chạy `pnpm lint` + `pnpm run test` + `pnpm run build` khi mở PR vào `develop`/`main` (hiện chưa có — 2 workflow hiện tại chỉ chạy khi push `develop`) | — | — | PROC-CICD Known Gap, SRS NFR-MAINT-04 |
| T-002 | Structured logging | Thay Nest `Logger` mặc định bằng structured JSON logger (VD: nestjs-pino hoặc winston), gắn request_id | — | — | ARCH-SYS #9, SRS NFR-SEC-06 |
| T-003 | Global validation pipe | Bật `ValidationPipe` toàn cục (`class-validator`/`class-transformer`) cho mọi DTO input | — | — | ARCH-API #1.2 |
| T-004 | Global error handler | Chuẩn hoá response lỗi theo format đề xuất ở `ARCH-API` #1.2 | T-003 | — | ARCH-API #1.2 |

### Epic 2: Authentication & Authorization

| ID | Task | Mô tả | Deps | DB Migration | Ref Docs |
|----|------|--------|------|--------------|----------|
| T-005 | Auth provider decision | Supabase Auth đã được chọn trên mobile; còn chốt backend identity mapping | — | Có thể cần migration mapping identity | ARCH-SYS #7.1, SRS FR-AUTH |
| T-006 | User bootstrap API | Verify Supabase Bearer token, tạo/tải `public.users` idempotently | T-005 | Tuỳ kết quả identity mapping | SRS FR-AUTH-01 |
| T-007 | Mobile login | Đã gọi Supabase Auth trực tiếp; backend không nhận password/phát token | T-005 | — | SRS FR-AUTH-02 |
| T-008 | Mobile logout | Đã dùng Supabase `signOut()`; custom backend endpoint không cần ở kiến trúc hiện tại | T-005 | — | SRS FR-AUTH-03 |
| T-009 | Forgot Password | Mobile/Supabase Auth integration còn pending; UI hiện là placeholder | T-005 | — | SRS FR-AUTH-04 |
| T-010 | Auth Guard + RBAC | Verify Supabase Bearer token cho route cần login; `RolesGuard` phân biệt User/Admin | T-005 | — | SRS FR-AUTH-09, NFR-SEC-04/05 |
| T-011 | Custom refresh token storage | Not required; Supabase Auth quản lý refresh token | T-005 | — | ARCH-DB |

### Epic 3: Membership

| ID | Task | Mô tả | Deps | DB Migration | Ref Docs |
|----|------|--------|------|--------------|----------|
| T-012 | Seed memberships | Seed 4-5 tier (Bronze→Obsidian) với giá trị giới hạn cụ thể (cần Product quyết định số cụ thể) | T-005 | seed script (không phải schema migration) | SRS FR-MEMBER-01 |
| T-013 | Gán Bronze mặc định | Khi tạo user mới → tự động tạo `user_memberships` record với `membership_id` = Bronze, `status='active'` | T-006, T-012 | — | SRS FR-MEMBER-02 |
| T-014 | GET /api/memberships + /api/users/me | Trả thông tin tier hiện tại cho user | T-013 | — | SRS FR-MEMBER, ARCH-API #(User) |

### Epic 4: Card Management

| ID | Task | Mô tả | Deps | DB Migration | Ref Docs |
|----|------|--------|------|--------------|----------|
| T-015 | Thu thập dữ liệu banks + credit_cards | Thu thập thủ công thông tin ngân hàng + sản phẩm thẻ phổ biến tại VN, seed vào `banks`/`credit_cards` | — | seed script | BRD #6.6, PRD #2.6 |
| T-016 | GET /api/banks, /api/credit-cards | List API, filter theo bank_id | T-010, T-015 | — | ARCH-API #(Card Management) |
| T-017 | CRUD /api/user-cards | Thêm/sửa/xoá/list thẻ user, validate `credit_card_id` tồn tại | T-016 | — | SRS FR-CARD-01→04 |
| T-018 | Enforce max_cards | Chặn thêm thẻ khi vượt `memberships.max_cards` của user | T-013, T-017 | — | SRS FR-CARD-05, FR-MEMBER-04 |

### Epic 5: Card Rule Management

| ID | Task | Mô tả | Deps | DB Migration | Ref Docs |
|----|------|--------|------|--------------|----------|
| T-019 | Thu thập chính sách hoàn tiền | Thu thập thủ công rule hoàn tiền của các thẻ đã seed (T-015), lưu `source_url` | T-015 | seed script | BRD #6.6 |
| T-020 | Admin CRUD reward_rules | POST/PATCH `/api/admin/reward-rules` | T-010, T-019 | — | SRS FR-RULE-01, 03, 04 |
| T-021 | Admin gán MCC cho rule | POST `/api/admin/reward-rules/:id/mccs` — validate `match_type` | T-020 | — | SRS FR-RULE-02 |
| T-022 | User xem rule của thẻ | GET `/api/credit-cards/:id/rules` — chỉ trả rule `is_active=true` và trong hạn `effective_from/to` | T-020 | — | SRS FR-RULE-05 |

### Epic 6: MCC Management

| ID | Task | Mô tả | Deps | DB Migration | Ref Docs |
|----|------|--------|------|--------------|----------|
| T-023 | Seed merchant_category_codes | Seed danh sách MCC chuẩn (theo bảng công khai ISO 18245) | — | seed script | PRD #2.7 |
| T-024 | Admin CRUD MCC | POST `/api/admin/mcc` | T-010, T-023 | — | SRS FR-MCC-01 |
| T-025 | Merchant lookup + normalize | Khi nhập merchant mới → tạo `merchants` record, tính `name_normalized` | — | — | ARCH-AI #3.1 |
| T-026 | MCC candidate CRUD (Admin) | Xem/duyệt `merchant_mcc_candidates` | T-025 | — | SRS FR-MCC-03 |
| T-027 | User feedback MCC | POST `/api/merchants/:id/mcc-feedback` | T-025 | — | SRS FR-MCC-04 |
| T-028 | Admin duyệt feedback | PATCH cập nhật `merchant_mcc_candidates.status`/`verified_count` từ feedback | T-026, T-027 | — | SRS FR-MCC-05 |

### Epic 7: Transaction Logging

| ID | Task | Mô tả | Deps | DB Migration | Ref Docs |
|----|------|--------|------|--------------|----------|
| T-029 | POST /api/transactions | Ghi `transactions`: validate user_card thuộc về user, amount > 0 | T-017 | — | SRS FR-TXN-01 |
| T-030 | MCC auto-inference | Trong lúc tạo transaction: lookup `merchant_mcc_candidates` theo `merchant_id`, ưu tiên confidence cao nhất + status='verified' | T-026, T-029 | — | SRS FR-TXN-02, ARCH-AI #3.1 |
| T-031 | Cashback calculation | Match `reward_rules` active của `user_card`, tính `estimated_cashback_amount` (đối chiếu `monthly_cap_amount` đã dùng trong chu kỳ hiện tại), ghi `cashback_calculations` | T-022, T-030 | — | SRS FR-TXN-03 |
| T-032 | GET /api/transactions, /:id | List + detail giao dịch | T-029 | — | SRS FR-TXN |

### Epic 8: Dashboard

| ID | Task | Mô tả | Deps | DB Migration | Ref Docs |
|----|------|--------|------|--------------|----------|
| T-033 | GET /api/dashboard/cashback-jars | Aggregate: SUM(`cashback_calculations.estimated_cashback_amount`) theo `user_card_id` trong chu kỳ hiện tại, so với `monthly_cap_amount` | T-031 | — | SRS FR-DASH-01 |
| T-034 | GET /api/dashboard/category-breakdown | Aggregate `transactions` theo `category`/`mcc_code` | T-032 | — | SRS FR-DASH-02 |
| T-035 | Mobile: Cashback Jar component | `cardpilot_ui` component mới, hiển thị progress bar đã dùng/còn lại | T-033 | — | ARCH-DS |
| T-036 | Mobile: Category Pie Chart | Component biểu đồ tròn | T-034 | — | PRD #2.4.3 |

### Epic 9: Mobile App (Flutter)

| ID | Task | Mô tả | Deps | DB Migration | Ref Docs |
|----|------|--------|------|--------------|----------|
| T-037 | `core/network` — API client | Thêm HTTP client (`dio`), interceptor gắn Bearer token, base URL config trong `core/config` | T-010 | — | ARCH-MOBILE, PRD #2.1 |
| T-038 | Auth screens (S03-S05) | Login/Register/Forgot Password, dùng `AppPrimaryButton` có sẵn | T-006, T-007, T-009, T-037 | — | PRD #2.1 |
| T-039 | Xác nhận flow Onboarding | Team quyết định giữ hay bỏ carousel onboarding hiện có trước khi nối vào Login — xem mâu thuẫn đã ghi ở `PRD` #2.1 | — | — | PRD #2.1 |
| T-040 | Dashboard screen (S06) | Feature `features/dashboard/` — Cashback Jar list + Pie chart, empty state | T-035, T-036, T-037 | — | PRD #2.4 |
| T-041 | Card screens (S07-S08) | Feature `features/cards/` — add/edit/list card | T-017, T-037 | — | PRD #2.5 |
| T-042 | Transaction screens (S09-S11) | Feature `features/transactions/` — add/list/detail, hiển thị cashback ước tính | T-029, T-032, T-037 | — | PRD #2.3 |
| T-043 | Profile screens (S12-S13) | Feature `features/profile/` — view/edit info, hiển thị membership | T-014, T-037 | — | PRD #2.1, #2.2 |
| T-044 | Local-only mode | Cho phép Skip login, dữ liệu lưu SQLite cục bộ (chọn `sqflite`/`drift`) | T-039 | — (SQLite riêng, không phải Postgres migration) | ARCH-DB #3, BRD #3.2 |

---

## 6. Dependency Graph

```
INFRA (Epic 1) ─────────────────────────────────────────────┐
  T-001, T-002, T-003 → T-004                                │
                                                              │
AUTH (Epic 2)                                                │
  T-005 → T-006 → T-007 → T-008                              │
                       └──→ T-010 (Guard/RBAC) ◄── dùng bởi mọi Epic sau
                  T-005 → T-011 (nếu JWT tự xây)
  T-006 → T-009

MEMBERSHIP (Epic 3)
  T-012 → T-013 (◄── T-006) → T-014

CARD MANAGEMENT (Epic 4)
  T-015 → T-016 (◄── T-010) → T-017 → T-018 (◄── T-013)

CARD RULE (Epic 5)
  T-015 → T-019 → T-020 (◄── T-010) → T-021
                             └──→ T-022

MCC (Epic 6)
  T-023 → T-024 (◄── T-010)
  T-025 → T-026 → T-027 → T-028

TRANSACTION LOGGING (Epic 7)
  T-017 → T-029 → T-030 (◄── T-026) → T-031 (◄── T-022) → T-032

DASHBOARD (Epic 8)
  T-031 → T-033 → T-035
  T-032 → T-034 → T-036

MOBILE (Epic 9)
  T-010 → T-037 → T-038 (◄── T-006,007,009)
                → T-039
                → T-040 (◄── T-035, T-036)
                → T-041 (◄── T-017)
                → T-042 (◄── T-029, T-032)
                → T-043 (◄── T-014)
          T-039 → T-044

CRITICAL PATH: T-005 → T-006 → T-007 → T-010 → T-037 → T-038/T-040/T-041/T-042/T-043
```

---

## 7. Tham Chiếu Tài Liệu

| Tài liệu | Sections liên quan |
|-----------|-------------------|
| **BRD** | #2 (Objectives), #5 (User Roles), #6.1-6.7 (Core Features) |
| **PRD** | #2.1-2.7 (toàn bộ modules), #4 (User Flows), #5 Phase 1 Must Have |
| **SRS** | FR-AUTH-01→09, FR-MEMBER-01→02, FR-CARD-01→05, FR-RULE-01→05, FR-MCC-01→05, FR-TXN-01→04, FR-DASH-01→02 |
| **ARCH-SYS** | #2 (Bounded Context), #7 (Security) |
| **ARCH-API** | #4-9 (Card/Rule/MCC/Transaction/Dashboard Planned APIs) |
| **ARCH-DB** | #2 (ERD, Table Definitions) |
| **ARCH-DS** | Component Inventory (Cashback Jar mới cần thêm) |
| **PROC-CICD** | #3 (CI/CD hiện tại), Known Gap (CI trên PR) |
