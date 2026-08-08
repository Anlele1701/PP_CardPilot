# System Architecture Document

# CardPilot - Credit Card Cashback & Rewards Intelligence Platform

**Version:** 1.0
**Date:** 2026-07-22

---

## 1. High-Level Architecture

```
┌───────────────────────────────────────────────────────────────────┐
│                          CLIENT                                   │
│   ┌───────────────────────────┐                                   │
│   │  cardpilot_app (Flutter)  │                                   │
│   │  Android + iOS            │                                   │
│   │  Drift / SQLite local DB  │                                   │
│   │  Riverpod + Supabase Auth │                                   │
│   └─────────────┬─────────────┘                                   │
└─────────────────┼─────────────────────────────────────────────────┘
                  │ REST/HTTPS (only when signed in & synced)
                  ▼
┌───────────────────────────────────────────────────────────────────┐
│                    BACKEND (NestJS + Fastify)                     │
│                    Modular Monolith — global prefix `/api`        │
│  ┌────────────┐  ┌────────────┐  ┌────────────────────────────┐  │
│  │  system    │  │   banks    │  │ Planned: auth/users/cards,│  │
│  │  health +  │  │ GET /banks │  │ sync, transactions,       │  │
│  │  API info  │  │            │  │ cashback, MCC             │  │
│  └────────────┘  └────────────┘  └────────────────────────────┘  │
└───────────────┬───────────────────────────────┬───────────────────┘
                │ TypeORM (pg wire)             │ planned async jobs
                ▼                               ▼
┌─────────────────────────────────┐  ┌──────────────────────────────┐
│ PostgreSQL (Supabase-hosted)    │  │ OCR SERVICE                  │
│ users, cards, merchants,        │  │ FastAPI + PaddleOCR +        │
│ transactions, reward rules,     │  │ VietOCR + PICK               │
│ cashback calculations           │  │ POST /v1/receipts/scan       │
└─────────────────────────────────┘  └──────────────────────────────┘
```

> OCR service POC đã tồn tại trong monorepo và chạy độc lập qua Nx/Docker.
> NestJS chưa có queue/job endpoint gọi service này, nên đường orchestration
> phía trên vẫn là planned. Chưa có API Gateway, cache layer hoặc message queue.

**Tài liệu liên quan:**

- [Backend Architecture](../BACKEND_ARCHITECTURE.md) — chi tiết layer/folder structure NestJS
- [Mobile Architecture](../MOBILE_ARCHITECTURE.md) — chi tiết layer/folder structure Flutter
- [API Design](./api.md) — endpoint specs
- [Database Design](./database.md) — ERD, table definitions
- [Mobile SQLite Proposal](./mobile-sqlite.md) — local schema, cache, sync, and migrations

---

## 2. Bounded Context Architecture (Backend)

Backend áp dụng **Modular Monolith** với Clean Architecture + DDD (xem `BACKEND_ARCHITECTURE.md` cho chi tiết layer rule). Bounded context hiện tại:

| Context           | Trách nhiệm                                                                                          | Trạng thái                   |
| ----------------- | ---------------------------------------------------------------------------------------------------- | ---------------------------- |
| `system`          | API metadata (`GET /api`), health check DB connectivity (`GET /api/health`, dùng `@nestjs/terminus`) | Implemented                  |
| `banks`           | Read-only `GET /api/v1/banks` backed by TypeORM/PostgreSQL                                           | Implemented                  |
| `auth`            | Đăng ký/đăng nhập/đăng xuất/quên mật khẩu, JWT hoặc session                                          | Chưa tạo — Planned Phase 1   |
| `users`           | Quản lý profile, membership level                                                                    | Chưa tạo — Planned Phase 1   |
| `memberships`     | Định nghĩa tier, enforce giới hạn                                                                    | Chưa tạo — Planned Phase 1/2 |
| `card-management` | Catalog `credit_cards` và CRUD `user_cards`; `banks` read-only đã tách thành context riêng           | Chưa tạo — Planned Phase 1   |
| `card-rules`      | Quản lý `reward_rules`/`reward_rule_mccs`                                                            | Chưa tạo — Planned Phase 1   |
| `mcc`             | Quản lý `merchant_category_codes`/`merchants`/`merchant_mcc_candidates`/`merchant_mcc_feedbacks`     | Chưa tạo — Planned Phase 1   |
| `transactions`    | Ghi log giao dịch, tính `cashback_calculations`                                                      | Chưa tạo — Planned Phase 1   |

> Context demo `cards` cũ không còn được wire vào `AppModule`. Dùng tên
> `card-management` cho catalog/user-card behavior để phân biệt rõ với
> `banks`.

## 3. Client Architecture (Mobile)

Xem chi tiết đầy đủ tại `MOBILE_ARCHITECTURE.md`. Tóm tắt trạng thái:

| Layer                                                                               | Trạng thái                                                                                                                                   |
| ----------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------- |
| `app/` (MaterialApp, routing)                                                       | Implemented; initial route là Sign in, onboarding đã gỡ                                                                                      |
| `core/config`, `core/constants`, `core/errors`, `core/notifications`, `core/result` | Implemented; notifications dùng Toastification adapter                                                                                       |
| `core/routing`                                                                      | Implemented cho access, sign-in, sign-up, profile/card setup và Home                                                                         |
| `core/network` (API client)                                                         | Implemented với Dio, API envelope và typed errors                                                                                            |
| Local database (SQLite)                                                             | Implemented bằng Drift qua schema v5                                                                                                         |
| `features/auth`                                                                     | Mobile Supabase email/password, Google/Facebook OAuth, session redirect và sign-out đã implement; backend user bootstrap/token guard chưa có |
| `features/initial_setup`, `features/home`                                           | Shared guest/authenticated setup, Drift persistence và Home shell đã có                                                                      |
| `features/{cards, transactions, cashback}`                                          | Local-first cards, manual transactions và cashback estimate đã implement; OCR UI integration pending                                         |

## 4. Communication Patterns

### 4.1 Synchronous (REST)

```
Mobile App → Backend API (REST/HTTPS, khi đã đăng nhập & đồng bộ)
```

Không có gRPC. NestJS-to-OCR HTTP orchestration vẫn đang planned.

### 4.2 Internal OCR HTTP

```text
Planned: NestJS receipt-scan job -> cardpilot-ocr-service HTTP API
```

FastAPI service và contract đã tồn tại. Authentication, quota, queue, object
storage và scan-status API trong NestJS chưa được implement.

### 4.3 Local-first (Offline)

```
Mobile App ↔ Drift/SQLite (on-device) — Implemented
```

Khi user ở local-only mode, toàn bộ đọc/ghi user data chỉ diễn ra trên thiết
bị, không gọi API. Reference data có thể refresh từ public backend endpoint và
được lưu thành snapshot có version/ETag. Xem `mobile-sqlite.md`.

### 4.4 Asynchronous / Event-driven

Chưa có message queue/event bus. OCR production nên dùng job bất đồng bộ thay
vì giữ public mobile request mở trong suốt inference.

## 5. External Integrations

| System                                    | Purpose                                                         | Trạng thái                                                   |
| ----------------------------------------- | --------------------------------------------------------------- | ------------------------------------------------------------ |
| PostgreSQL (Supabase)                     | Lưu trữ dữ liệu nguồn (source of truth)                         | Integrated                                                   |
| Supabase Auth                             | Mobile email/password, Google/Facebook OAuth, persisted session | Integrated on mobile; backend verification/bootstrap planned |
| Docker Hub                                | Registry cho image backend (`cardpilot-backend:latest`)         | Integrated (CI)                                              |
| Render                                    | Hosting backend, trigger qua deploy hook                        | Integrated (CI)                                              |
| Widgetbook Cloud                          | Hosting bản preview UI components (`cardpilot_ui`)              | Integrated (CI)                                              |
| Self-hosted MC_OCR fork                   | Quét hoá đơn tiếng Việt thành transaction draft                 | Backend POC implemented; product integration pending         |
| Push notification (Android, khả năng FCM) | Thông báo nhắc nhở/cảnh báo hạn mức                             | Planned                                                      |
| Nguồn dữ liệu MCC/chính sách ngân hàng    | Crawl thủ công, không qua API                                   | Quy trình thủ công, không phải integration kỹ thuật          |

## 6. Data Flow: Transaction Logging & Cashback Calculation (Planned)

```
User nhập giao dịch (thủ công hoặc OCR)
    │
    ▼
Suy luận merchant → MCC (merchant_mcc_candidates, ưu tiên confidence cao nhất)
    │
    ▼
Tra reward_rules đang active của user_card đã chọn (theo effective_from/to, is_active)
    │
    ▼
Tính cashback_estimated_amount (đối chiếu monthly_cap_amount đã dùng trong chu kỳ)
    │
    ▼
Lưu transactions + cashback_calculations
    │
    ▼
Cập nhật Dashboard: Cashback Jar/Pocket, Category pie chart, Forecast
```

> Đây là data flow **thiết kế đề xuất** — chưa có code implementation. Xem `SRS` FR-TXN, FR-DASH cho requirement chi tiết.

## 7. Security Architecture

**Trạng thái backend hiện tại: chưa có authentication/authorization guard.**
Mobile đã xác thực trực tiếp với Supabase Auth, nhưng các endpoint backend hiện
có (`GET /api/v1`, `GET /api/health`, `GET /api/v1/banks`) chưa verify Supabase
access token và chưa bảo vệ dữ liệu user.

### 7.1 Authentication Flow

Mobile đã chọn Supabase Auth cho email/password và social OAuth. Supabase
Flutter persists and refreshes the session. Phần còn thiếu là backend verify
Bearer token, map `auth.users.id` sang bảng `users`, và bootstrap profile/business
data sau lần đăng nhập đầu tiên. Backend không được nhận hoặc tự xử lý password
từ mobile khi tiếp tục theo hướng này.

### 7.2 API Security Layers (Planned)

Chưa có: rate limiting, security headers, input validation (`class-validator`), global error handler, CORS config. Tất cả là backlog trước khi mở API cho dữ liệu người dùng thật.

### 7.3 Rate Limiting Strategy

Chưa có — "—".

## 8. Scalability Strategy

Giai đoạn hiện tại: 1 instance backend (Render) + 1 Postgres instance
(Supabase). OCR adapter serialize inference và chạy một Uvicorn worker mỗi
container; khi production cần scale bằng nhiều replica phía sau queue. Các
bounded context NestJS còn lại tiếp tục ở modular monolith.

## 9. Monitoring & Observability

| Tool                            | Trạng thái  | Ghi chú                                  |
| ------------------------------- | ----------- | ---------------------------------------- |
| Nest `Logger` (mặc định)        | Implemented | Chỉ log ra console, chưa structured JSON |
| `@nestjs/terminus` health check | Implemented | `GET /api/health` ping Postgres          |
| Structured logging (JSON)       | Planned     | Chưa build                               |
| Metrics (Prometheus/Grafana)    | Planned     | Chưa build                               |
| Error tracking (Sentry, v.v.)   | Planned     | Chưa chọn công cụ                        |

---

**Tài liệu liên quan:** [BRD](../BRD.md) · [PRD](../PRD.md) · [SRS](../SRS.md) · [API Design](./api.md) · [Database Design](./database.md) · [Mobile SQLite](./mobile-sqlite.md) · [AI Architecture](./ai.md) · [DevOps & CI/CD](../processes/devops-cicd.md)
