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
│   │  SQLite local cache       │ ◀─ Planned, not yet built        │
│   │  (Riverpod state)         │                                   │
│   └─────────────┬─────────────┘                                   │
└─────────────────┼─────────────────────────────────────────────────┘
                  │ REST/HTTPS (only when signed in & synced)
                  ▼
┌───────────────────────────────────────────────────────────────────┐
│                    BACKEND (NestJS + Fastify)                     │
│                    Modular Monolith — global prefix `/api`        │
│  ┌────────────┐  ┌─────────────────────────────────────────────┐  │
│  │  system    │  │  cards (demo scaffold — GET /cards only)    │  │
│  │  (health,  │  │                                             │  │
│  │  api info) │  │  Planned contexts: auth, users, memberships,│  │
│  │            │  │  cards (real), transactions, cashback, mcc  │  │
│  └────────────┘  └─────────────────────────────────────────────┘  │
└─────────────────────────────┬─────────────────────────────────────┘
                              │ TypeORM (pg wire)
                              ▼
┌───────────────────────────────────────────────────────────────────┐
│              PostgreSQL (Supabase-hosted)                         │
│  users, memberships, user_memberships, banks, credit_cards,       │
│  user_cards, merchant_category_codes, merchants,                  │
│  merchant_mcc_candidates, merchant_mcc_feedbacks, transactions,   │
│  reward_rules, reward_rule_mccs, cashback_calculations            │
└───────────────────────────────────────────────────────────────────┘
```

> Diagram này là **logical view** hiện trạng thật (2026-07-22). Không có API Gateway, cache layer, message queue, hay AI service nào tồn tại trong code hôm nay — những thành phần đó chỉ là roadmap (xem `ARCH-AI`, `PROC-CICD`).

**Tài liệu liên quan:**
- [Backend Architecture](../BACKEND_ARCHITECTURE.md) — chi tiết layer/folder structure NestJS
- [Mobile Architecture](../MOBILE_ARCHITECTURE.md) — chi tiết layer/folder structure Flutter
- [API Design](./api.md) — endpoint specs
- [Database Design](./database.md) — ERD, table definitions

---

## 2. Bounded Context Architecture (Backend)

Backend áp dụng **Modular Monolith** với Clean Architecture + DDD (xem `BACKEND_ARCHITECTURE.md` cho chi tiết layer rule). Bounded context hiện tại:

| Context | Trách nhiệm | Trạng thái |
|---------|-------------|-----------|
| `system` | API metadata (`GET /api`), health check DB connectivity (`GET /api/health`, dùng `@nestjs/terminus`) | Implemented |
| `cards` | **Demo scaffold** — `GET /cards` trả 2 thẻ hardcode trong memory. Không liên quan tới bảng `credit_cards`/`user_cards` thật | Implemented (nhưng là demo, không phải feature thật) |
| `auth` | Đăng ký/đăng nhập/đăng xuất/quên mật khẩu, JWT hoặc session | Chưa tạo — Planned Phase 1 |
| `users` | Quản lý profile, membership level | Chưa tạo — Planned Phase 1 |
| `memberships` | Định nghĩa tier, enforce giới hạn | Chưa tạo — Planned Phase 1/2 |
| `cards` (thật) | CRUD `banks`/`credit_cards`/`user_cards` — cần đặt tên context khác để tránh trùng với demo hiện tại (VD: `card-management`) | Chưa tạo — Planned Phase 1 |
| `card-rules` | Quản lý `reward_rules`/`reward_rule_mccs` | Chưa tạo — Planned Phase 1 |
| `mcc` | Quản lý `merchant_category_codes`/`merchants`/`merchant_mcc_candidates`/`merchant_mcc_feedbacks` | Chưa tạo — Planned Phase 1 |
| `transactions` | Ghi log giao dịch, tính `cashback_calculations` | Chưa tạo — Planned Phase 1 |

> **Khuyến nghị đặt tên**: khi build context "cards" thật (CRUD `user_cards`), đổi tên hoặc gộp để tránh nhầm lẫn với context `cards` demo hiện tại — xem ghi chú tương tự ở `ARCH-API`.

## 3. Client Architecture (Mobile)

Xem chi tiết đầy đủ tại `MOBILE_ARCHITECTURE.md`. Tóm tắt trạng thái:

| Layer | Trạng thái |
|-------|-----------|
| `app/` (MaterialApp, routing) | Implemented (routing hiện chỉ có 1 route: onboarding) |
| `core/config`, `core/errors`, `core/result` | Implemented (tối giản) |
| `core/routing` | Implemented, nhưng chỉ có 1 route thật (`/`) |
| `core/network` (API client) | **Chưa tồn tại** — chưa có HTTP client nào (không `dio`, không `http`) trong `pubspec.yaml` |
| Local database (SQLite) | **Chưa tồn tại** — không có `sqflite`/`drift`/`hive` nào được khai báo |
| `features/onboarding` | Implemented đầy đủ (domain/data/presentation + Riverpod controller) |
| `features/{auth, cards, transactions, cashback, membership}` | **Chưa tồn tại** — chỉ là roadmap |

## 4. Communication Patterns

### 4.1 Synchronous (REST)
```
Mobile App → Backend API (REST/HTTPS, khi đã đăng nhập & đồng bộ)
```
Không có gRPC, không có giao tiếp service-to-service (single-process monolith).

### 4.2 Local-first (Offline)
```
Mobile App ↔ SQLite (on-device) — Planned, chưa implement
```
Khi user ở local-only mode, toàn bộ đọc/ghi chỉ diễn ra trên thiết bị, không gọi API.

### 4.3 Asynchronous / Event-driven

Chưa có — không có message queue/event bus nào trong scope hiện tại. Nếu tương lai cần (VD: xử lý OCR bất đồng bộ), bổ sung mục này.

## 5. External Integrations

| System | Purpose | Trạng thái |
|--------|---------|-----------|
| PostgreSQL (Supabase) | Lưu trữ dữ liệu nguồn (source of truth) | Integrated |
| Docker Hub | Registry cho image backend (`cardpilot-backend:latest`) | Integrated (CI) |
| Render | Hosting backend, trigger qua deploy hook | Integrated (CI) |
| Widgetbook Cloud | Hosting bản preview UI components (`cardpilot_ui`) | Integrated (CI) |
| OCR/Receipt-scan provider | Quét hoá đơn tự động | Planned — chưa chọn nhà cung cấp |
| Push notification (Android, khả năng FCM) | Thông báo nhắc nhở/cảnh báo hạn mức | Planned |
| Nguồn dữ liệu MCC/chính sách ngân hàng | Crawl thủ công, không qua API | Quy trình thủ công, không phải integration kỹ thuật |

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

**Trạng thái hiện tại: không có authentication/authorization nào được implement.** Mọi endpoint hiện có (`GET /api`, `GET /api/health`, `GET /api/cards`) không yêu cầu token, không có guard.

### 7.1 Authentication Flow (Planned)
Chưa thiết kế chi tiết — cần quyết định: tự xây JWT trong NestJS, hay dùng Supabase Auth (Supabase đã là nơi lưu Postgres, nên tận dụng Supabase Auth là lựa chọn hợp lý để giảm công sức, nhưng **chưa có quyết định chính thức**). Xem `SRS` FR-AUTH.

### 7.2 API Security Layers (Planned)
Chưa có: rate limiting, security headers, input validation (`class-validator`), global error handler, CORS config. Tất cả là backlog trước khi mở API cho dữ liệu người dùng thật.

### 7.3 Rate Limiting Strategy
Chưa có — "—".

## 8. Scalability Strategy

Giai đoạn hiện tại (Phase 1): 1 instance backend (Render) + 1 Postgres instance (Supabase). Không cần chiến lược scale ngang. Khi cần, tách theo bounded context đã phân chia sẵn trong `src/contexts/` trước khi cân nhắc tách microservice vật lý (nguyên tắc tương tự Trendify's Backend Architecture Scaling Path, nhưng ở quy mô nhỏ hơn nhiều).

## 9. Monitoring & Observability

| Tool | Trạng thái | Ghi chú |
|------|-----------|---------|
| Nest `Logger` (mặc định) | Implemented | Chỉ log ra console, chưa structured JSON |
| `@nestjs/terminus` health check | Implemented | `GET /api/health` ping Postgres |
| Structured logging (JSON) | Planned | Chưa build |
| Metrics (Prometheus/Grafana) | Planned | Chưa build |
| Error tracking (Sentry, v.v.) | Planned | Chưa chọn công cụ |

---

**Tài liệu liên quan:** [BRD](../BRD.md) · [PRD](../PRD.md) · [SRS](../SRS.md) · [API Design](./api.md) · [Database Design](./database.md) · [AI Architecture](./ai.md) · [DevOps & CI/CD](../processes/devops-cicd.md)
