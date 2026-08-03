# API Design Document
# CardPilot - Credit Card Cashback & Rewards Intelligence Platform

**Version:** 1.0
**Date:** 2026-07-22
**Base URL (local dev):** `http://localhost:3000/api/v1`
**Global prefix:** `/api` (set in `apps/cardpilot-backend/src/main.ts`)

URI versioning defaults to `v1`. Health is version-neutral at `/api/health`.

---

## 1. API Conventions

### 1.1 General Rules

- RESTful, JSON request/response bodies.
- UUID (v4) cho resource IDs, ngoại trừ `merchant_category_codes.code` (varchar(4), là chính MCC code).
- ISO 8601 cho mọi timestamp.
- Backend chạy trên **Fastify** (không phải Express) qua `@nestjs/platform-fastify`.

### 1.2 Response Format

Success and error responses use the global API envelope:

```json
// Success
{
  "responseStatus": { "code": "SUCCESS", "message": "Success" },
  "responseData": { "id": "uuid", "field": "value" }
}

// Error
{
  "responseStatus": { "code": "VALIDATION_ERROR", "message": "..." },
  "responseData": null
}
```

### 1.3 HTTP Status Codes

| Code | Usage |
|------|-------|
| 200 | Success |
| 201 | Created (đề xuất cho POST tạo resource — chưa có endpoint POST nào tồn tại hôm nay) |
| 400 | Bad Request (đề xuất — chưa có validation pipe nào implement) |
| 401 | Unauthorized (đề xuất — chưa có auth nào implement) |
| 404 | Not Found |
| 500 | Internal Server Error |

### 1.4 Authentication

Backend authorization chưa implement và endpoint hiện tại chưa yêu cầu
`Authorization`. Mobile đã dùng Supabase Auth; backend cần verify Supabase
Bearer token trước khi mở API dữ liệu user.

### 1.5 Rate Limiting

Chưa có — "—".

### 1.6 Request Context And Tracing

- Client may send `X-Request-ID`; backend generates one when absent.
- Versioned business endpoints require `X-Request-Datetime`.
- Health allows a missing request datetime.
- Responses echo the trace through `X-Request-ID` and `X-Response-ID`.

---

## 2. System APIs (Implemented)

### GET /api/v1

Trả thông tin metadata tĩnh của API.

**Response (200):**
```json
{
  "name": "CardPilot Backend",
  "description": "Backend API organized around clean architecture and DDD boundaries.",
  "version": "1.0.0",
  "architecture": "clean-architecture-ddd"
}
```

### GET /api/health

Health check — ping kết nối PostgreSQL qua `@nestjs/terminus`.

**Response (200):**
```json
{
  "status": "ok",
  "info": { "database": { "status": "up" } },
  "error": {},
  "details": { "database": { "status": "up" } }
}
```

---

## 3. Bank APIs (Implemented)

### GET /api/v1/banks

Returns banks ordered by name from PostgreSQL. Each item contains `id`,
`swiftCode`, `name`, and `shortName`; the global response interceptor wraps the
array in `responseData`.

The current implementation does **not** emit ETag, dataset version, or
`updatedAt`. Mobile may fetch it when the cache is empty, but reliable change
detection remains pending.

### GET /api/v1/reference-data/manifest (Proposed)

Returns server-owned versions and ETags for complete reference snapshots such
as banks, credit cards, MCCs, and reward rules. Dataset endpoints should accept
`If-None-Match` and may return `304 Not Modified`. This contract is required for
SQLite cache invalidation; see `mobile-sqlite.md`.

---

## 4. Auth/Profile Backend APIs (Planned)

Mobile authentication is already delegated to Supabase Auth. The backend still
needs Supabase token verification plus profile/bootstrap and sync APIs. The
legacy `/api/auth/register` and `/api/auth/login` proposals below should not be
implemented as password-accepting endpoints unless the auth architecture is
explicitly changed away from Supabase.

### POST /api/v1/auth/bootstrap (Planned)

Nhận Supabase access token qua `Authorization: Bearer <token>`, verify token,
sau đó tạo hoặc tải `public.users` tương ứng với `auth.users.id`. Endpoint này
không nhận password và không tự phát hành access/refresh token.

### Authentication operations owned by Supabase

Đăng ký email/password, đăng nhập, OAuth, refresh session, forgot-password và
sign-out hiện do `supabase_flutter` gọi Supabase Auth trực tiếp. Backend chỉ cần
Auth Guard verify Supabase Bearer token cho các API nghiệp vụ được bảo vệ.

Authentication endpoints do not own business-data synchronization.

### POST /api/v1/sync/claim-guest (Proposed)

Links an authenticated backend user to a client guest workspace and accepts an
idempotent initial profile/card snapshot.

### POST /api/v1/sync/push (Proposed)

Accepts ordered outbox operations with client UUID, idempotency key, payload
version, and optional base server version.

### GET /api/v1/sync/pull?cursor=... (Proposed)

Returns user-data changes after an opaque cursor plus the next cursor. Conflict,
retention, retry, and tombstone rules are defined in
[`mobile-sqlite.md`](./mobile-sqlite.md).

---

## 5. Card Management APIs (Planned)

Liên quan tới bảng `banks`, `credit_cards`, `user_cards`. Xem `SRS` FR-CARD-01→05.

| Method | Endpoint | Auth | Related Tables | Mô tả |
|--------|----------|------|-----------------|--------|
| GET | `/api/v1/banks` | Public (current) | `banks` (R) | Danh sách ngân hàng có sẵn; đã implement |
| GET | `/api/v1/credit-cards` | Bearer | `credit_cards` (R) | Danh sách sản phẩm thẻ, filter theo `bank_id` |
| GET | `/api/v1/user-cards` | Bearer | `user_cards` (R), `credit_cards` (R) | Danh sách thẻ user đã thêm |
| POST | `/api/v1/user-cards` | Bearer | `user_cards` (W) | Thêm thẻ: `{ credit_card_id, nickname, billing_cycle_day, is_default }` |
| PATCH | `/api/v1/user-cards/:id` | Bearer | `user_cards` (RW) | Sửa nickname/billing_cycle_day/is_default |
| DELETE | `/api/v1/user-cards/:id` | Bearer | `user_cards` (W) | Xoá thẻ (không cascade xoá `transactions`) |

---

## 6. Card Rule Management APIs (Planned)

Liên quan tới `reward_rules`, `reward_rule_mccs`. Xem `SRS` FR-RULE-01→05.

| Method | Endpoint | Auth | Related Tables | Mô tả |
|--------|----------|------|-----------------|--------|
| GET | `/api/credit-cards/:id/rules` | Bearer | `reward_rules` (R), `reward_rule_mccs` (R) | Xem rule đang active của 1 sản phẩm thẻ |
| POST | `/api/admin/reward-rules` | Admin | `reward_rules` (W) | Tạo rule mới cho 1 credit card |
| PATCH | `/api/admin/reward-rules/:id` | Admin | `reward_rules` (RW) | Sửa rule (rate, cap, effective dates, source_url) |
| POST | `/api/admin/reward-rules/:id/mccs` | Admin | `reward_rule_mccs` (W) | Gán MCC áp dụng cho rule (kèm `match_type`) |

---

## 7. MCC Management APIs (Planned)

Liên quan tới `merchant_category_codes`, `merchants`, `merchant_mcc_candidates`, `merchant_mcc_feedbacks`. Xem `SRS` FR-MCC-01→05.

| Method | Endpoint | Auth | Related Tables | Mô tả |
|--------|----------|------|-----------------|--------|
| GET | `/api/mcc` | Bearer | `merchant_category_codes` (R) | Danh sách MCC chuẩn |
| POST | `/api/admin/mcc` | Admin | `merchant_category_codes` (W) | Thêm/sửa MCC |
| GET | `/api/merchants/:id/mcc-candidates` | Bearer | `merchant_mcc_candidates` (R) | Xem suy luận MCC của 1 merchant |
| POST | `/api/merchants/:id/mcc-feedback` | Bearer | `merchant_mcc_feedbacks` (W) | User gửi phản hồi MCC sai |
| PATCH | `/api/admin/mcc-candidates/:id` | Admin | `merchant_mcc_candidates` (RW) | Duyệt/từ chối candidate |

---

## 8. Transaction Logging APIs (Planned)

Liên quan tới `transactions`, `cashback_calculations`. Xem `SRS` FR-TXN-01→06.

| Method | Endpoint | Auth | Related Tables | Mô tả |
|--------|----------|------|-----------------|--------|
| POST | `/api/transactions` | Bearer | `transactions` (W), `cashback_calculations` (W) | Ghi log giao dịch thủ công, trả về cashback ước tính ngay |
| GET | `/api/transactions` | Bearer | `transactions` (R) | Lịch sử giao dịch, filter theo thẻ/khoảng thời gian |
| GET | `/api/transactions/:id` | Bearer | `transactions` (R), `cashback_calculations` (R) | Chi tiết 1 giao dịch + cashback breakdown |

---

## 9. Dashboard APIs (Planned)

Xem `SRS` FR-DASH-01→05.

| Method | Endpoint | Auth | Related Tables | Mô tả |
|--------|----------|------|-----------------|--------|
| GET | `/api/dashboard/cashback-jars` | Bearer | `user_cards` (R), `reward_rules` (R), `cashback_calculations` (R) | Trạng thái hoàn tiền đã dùng/còn lại cho từng thẻ trong chu kỳ hiện tại |
| GET | `/api/dashboard/category-breakdown` | Bearer | `transactions` (R) | Phân bổ chi tiêu theo MCC/Category (cho pie chart) |
| GET | `/api/dashboard/forecast` | Bearer | `transactions` (R) | Dự đoán chi tiêu/hoàn tiền ngày/tháng/năm |
| GET | `/api/dashboard/card-recommendation` | Bearer | `user_cards` (R), `reward_rules` (R), `credit_cards` (R) | Gợi ý thẻ khác khi 1 category đã hết hạn mức hoàn tiền |

---

**Tài liệu liên quan:** [SRS](../SRS.md) · [Database Design](./database.md) · [System Architecture](./system.md)
