# Software Requirements Specification (SRS)
# CardPilot - Credit Card Cashback & Rewards Intelligence Platform

**Version:** 1.0
**Date:** 2026-07-22

> Trạng thái implementation hiện tại (2026-07-22): backend chỉ có 3 endpoint (`GET /api`, `GET /api/health`, `GET /api/cards` — endpoint cuối là demo in-memory, không liên quan tới schema thật). Toàn bộ schema PostgreSQL (14 bảng) đã tồn tại qua migration `1784410000000-create-initial-schema.ts` nhưng chưa có application code nào đọc/ghi vào đó. Mobile app chỉ có flow Onboarding hoàn chỉnh; chưa có auth, network client, hay local database nào. Mọi FR dưới đây vẫn được liệt kê đầy đủ theo roadmap — cột **Trạng thái** cho biết mức độ đã implement.

---

## 1. Introduction

### 1.1 Purpose

Tài liệu này mô tả chi tiết yêu cầu chức năng (FR) và phi chức năng (NFR) của hệ thống CardPilot, làm cầu nối giữa `PRD` (business/UX) và các tài liệu kiến trúc (`ARCH-SYS`, `ARCH-API`, `ARCH-DB`, `ARCH-AI`).

### 1.2 Scope

CardPilot bao gồm:
- Mobile Application (Flutter — `apps/cardpilot-mobile/apps/cardpilot_app`)
- Backend API (NestJS + Fastify + TypeORM — `apps/cardpilot-backend`)
- Database (PostgreSQL qua Supabase; SQLite cục bộ trên thiết bị — kế hoạch)
- Widgetbook (ứng dụng preview UI nội bộ — `apps/cardpilot-mobile/apps/cardpilot_widgetbook`)

### 1.3 Definitions & Acronyms

| Term | Definition |
|------|-----------|
| MCC | Merchant Category Code — mã 4 chữ số phân loại ngành nghề merchant, dùng để xác định giao dịch có được hoàn tiền hay không |
| Cashback Jar/Pocket | Card component trên Dashboard hiển thị hạn mức hoàn tiền đã dùng/còn lại của 1 thẻ |
| Reward Rule | Quy tắc hoàn tiền/điểm thưởng gắn với 1 sản phẩm thẻ tín dụng (`reward_rules`) |
| MCC Candidate | Suy luận (có độ tin cậy) về MCC của 1 merchant, có thể do hệ thống đề xuất hoặc người dùng xác nhận |
| Membership Tier | Cấp độ thành viên (Bronze/Gold/Platinum/Diamond/Obsidian) quyết định giới hạn tính năng + mức quảng cáo |
| Local-only Mode | Chế độ dùng app không đăng nhập, dữ liệu chỉ lưu trên thiết bị (SQLite), không đồng bộ cloud |

---

## 2. System Overview

### 2.1 System Context Diagram

```
┌────────────┐        ┌──────────────────┐        ┌───────────────────────┐
│  End User  │───────▶│  CardPilot API   │───────▶│  PostgreSQL (Supabase) │
│  (Mobile)  │◀───────│  (NestJS/Fastify)│◀───────│                        │
└─────┬──────┘        └──────────────────┘        └───────────────────────┘
      │
      ▼
┌────────────┐
│   SQLite   │  (local cache — planned, chưa implement)
│ (on device)│
└────────────┘
```

Không có external payment/affiliate API nào trong scope (khác với các nền tảng thương mại) — external integration duy nhất hiện tại là chính PostgreSQL/Supabase (hosting), và các nguồn dữ liệu MCC/bank policy được thu thập thủ công (không qua API).

---

## 3. Functional Requirements

### 3.1 User Management & Auth Module (FR-AUTH)

| ID | Requirement | Priority | Phase | Trạng thái |
|----|-------------|----------|-------|-----------|
| FR-AUTH-01 | Hệ thống cho phép đăng ký tài khoản bằng email | P0 | 1 | Chưa implement |
| FR-AUTH-02 | Hệ thống cho phép đăng nhập | P0 | 1 | Chưa implement |
| FR-AUTH-03 | Hệ thống cho phép đăng xuất | P0 | 1 | Chưa implement |
| FR-AUTH-04 | Hệ thống cho phép quên mật khẩu / reset password | P0 | 1 | Chưa implement |
| FR-AUTH-05 | Hệ thống cho phép dùng app ở chế độ local-only không cần tài khoản (dữ liệu chỉ lưu SQLite, không sync, có quảng cáo) | P0 | 1 | Chưa implement |
| FR-AUTH-06 | User có thể xem/chỉnh sửa thông tin cá nhân (`full_name`, `born_date`) | P1 | 1 | Chưa implement |
| FR-AUTH-07 | User có thể xem membership level hiện tại | P0 | 1 | Chưa implement |
| FR-AUTH-08 | User ở chế độ local-only có thể đăng ký/đăng nhập để đồng bộ dữ liệu local lên cloud | P1 | 2 | Chưa implement — cần thiết kế conflict resolution trước (xem `ARCH-DB`) |
| FR-AUTH-09 | Hệ thống enforce phân quyền User/Admin cho các API ghi dữ liệu master (banks, credit_cards, reward_rules, merchant_category_codes) | P0 | 1 | Chưa implement — **bắt buộc trước khi mở API ghi dữ liệu thật** |

### 3.2 User Membership Module (FR-MEMBER)

| ID | Requirement | Priority | Phase | Trạng thái |
|----|-------------|----------|-------|-----------|
| FR-MEMBER-01 | Hệ thống định nghĩa tối thiểu 4-5 membership tier (Bronze, Gold, Platinum, Diamond, Obsidian) với giới hạn riêng (`max_cards`, `max_receipt_scans_per_month`, `max_cashback_calculations_per_month`) | P0 | 1 | Schema đã có (`memberships`), chưa có seed data/logic |
| FR-MEMBER-02 | User mới mặc định ở tier Bronze | P0 | 1 | Chưa implement |
| FR-MEMBER-03 | Hệ thống tích điểm cho user khi ghi log giao dịch, dùng để xét lên hạng | P1 | 2 | WIP — công thức tính điểm chưa chốt |
| FR-MEMBER-04 | Hệ thống enforce giới hạn tính năng theo tier hiện tại của user (VD: chặn thêm thẻ khi vượt `max_cards`) | P0 | 2 | Chưa implement |
| FR-MEMBER-05 | User Bronze thấy nhiều quảng cáo hơn; tier càng cao quảng cáo càng giảm | P1 | 2 | Chưa implement — chưa chọn nhà cung cấp quảng cáo |

### 3.3 Card Management Module (FR-CARD)

| ID | Requirement | Priority | Phase | Trạng thái |
|----|-------------|----------|-------|-----------|
| FR-CARD-01 | User có thể thêm thẻ tín dụng bằng cách chọn ngân hàng (`banks`) + sản phẩm thẻ (`credit_cards`) từ catalog có sẵn | P0 | 1 | Schema đã có, chưa có API/UI |
| FR-CARD-02 | User có thể đặt nickname, billing_cycle_day, is_default cho thẻ đã thêm (`user_cards`) | P0 | 1 | Chưa implement |
| FR-CARD-03 | User có thể sửa/xoá thẻ đã thêm; xoá thẻ không xoá lịch sử `transactions` liên quan | P1 | 1 | Chưa implement |
| FR-CARD-04 | User có thể xem danh sách thẻ đã thêm | P0 | 1 | Chưa implement |
| FR-CARD-05 | Hệ thống chặn thêm thẻ mới khi user đã đạt `max_cards` theo membership tier | P1 | 2 | Chưa implement — phụ thuộc FR-MEMBER-04 |

### 3.4 Card Rule Management Module (FR-RULE)

| ID | Requirement | Priority | Phase | Trạng thái |
|----|-------------|----------|-------|-----------|
| FR-RULE-01 | Admin có thể tạo/sửa reward rule cho 1 sản phẩm thẻ (`reward_rules`): loại thưởng, tỷ lệ hoàn tiền/điểm, hạn mức tháng, điều kiện tối thiểu, kênh áp dụng | P0 | 1 | Schema đã có, chưa có API Admin |
| FR-RULE-02 | Admin có thể map 1 reward rule với nhiều MCC (`reward_rule_mccs`, gồm `match_type`) | P0 | 1 | Chưa implement |
| FR-RULE-03 | Reward rule lưu `source_url` và `last_verified_at` để theo dõi độ mới của chính sách đã thu thập thủ công | P0 | 1 | Schema đã có |
| FR-RULE-04 | Reward rule có thể có `effective_from`/`effective_to` để biểu diễn chính sách có thời hạn | P1 | 1 | Schema đã có |
| FR-RULE-05 | User có thể xem (read-only) rule đang áp dụng cho từng thẻ mình sở hữu | P0 | 1 | Chưa implement |

### 3.5 MCC Management Module (FR-MCC)

| ID | Requirement | Priority | Phase | Trạng thái |
|----|-------------|----------|-------|-----------|
| FR-MCC-01 | Admin có thể CRUD bảng MCC chuẩn (`merchant_category_codes`) | P0 | 1 | Schema đã có, chưa có API |
| FR-MCC-02 | Hệ thống lưu merchant đã ghi nhận (`merchants`, có `name_normalized` để khớp trùng lặp) | P0 | 1 | Schema đã có |
| FR-MCC-03 | Hệ thống lưu suy luận MCC cho từng merchant kèm độ tin cậy (`merchant_mcc_candidates.confidence_score`) và trạng thái (`suggested`/`verified`/`rejected`) | P0 | 1 | Schema đã có |
| FR-MCC-04 | User có thể gửi feedback khi MCC suy luận sai (`merchant_mcc_feedbacks`) | P1 | 1 | Chưa implement |
| FR-MCC-05 | Admin có thể duyệt feedback, cập nhật `merchant_mcc_candidates.status`/`verified_count` | P1 | 1 | Chưa implement |

### 3.6 Transaction Logging Module (FR-TXN)

| ID | Requirement | Priority | Phase | Trạng thái |
|----|-------------|----------|-------|-----------|
| FR-TXN-01 | User có thể ghi log giao dịch thủ công: thẻ dùng, merchant, số tiền, ngày, ghi chú | P0 | 1 | Schema đã có (`transactions`), chưa có API/UI |
| FR-TXN-02 | Hệ thống tự suy luận `mcc_code` từ merchant đã nhập (dựa vào `merchant_mcc_candidates` có confidence cao nhất) | P1 | 1 | Chưa implement |
| FR-TXN-03 | Hệ thống tính `cashback_estimated_amount` dựa trên reward rule đang active của thẻ, lưu kết quả vào `cashback_calculations` kèm `confidence`/`explanation` | P0 | 1 | Chưa implement |
| FR-TXN-04 | Giao dịch mặc định có `source = 'manual'`; hệ thống phải hỗ trợ mở rộng nguồn khác (`ocr`, `import`) ở phase sau mà không đổi schema | P1 | 2 | Schema hỗ trợ sẵn (`source` là free-text) |
| FR-TXN-05 | (Phase 2) User có thể quét hoá đơn (OCR) để tự động điền thông tin giao dịch, xác nhận trước khi lưu | P1 | 2 | Chưa implement — xem `ARCH-AI` |
| FR-TXN-06 | (Phase 2) Hệ thống nhận diện giao dịch định kỳ (recurring bill/subscription) và cảnh báo trước chu kỳ tiếp theo | P2 | 2 | Chưa implement |

### 3.7 Dashboard Module (FR-DASH)

| ID | Requirement | Priority | Phase | Trạng thái |
|----|-------------|----------|-------|-----------|
| FR-DASH-01 | Hệ thống hiển thị "Cashback Jar/Pocket" cho từng thẻ: đã dùng / còn lại trong hạn mức hoàn tiền tháng | P0 | 1 | Chưa implement |
| FR-DASH-02 | Hệ thống hiển thị biểu đồ tròn phân bổ chi tiêu theo MCC/Category | P0 | 1 | Chưa implement |
| FR-DASH-03 | Hệ thống dự đoán chi tiêu ngày/tháng/năm dựa trên xu hướng giao dịch đã log | P1 | 2 | Chưa implement |
| FR-DASH-04 | Hệ thống cảnh báo khi 1 category/MCC đã vượt hạn mức hoàn tiền của thẻ đang dùng, và gợi ý thẻ khác phù hợp hơn (trong số thẻ đã có hoặc gợi ý mở thêm thẻ mới) | P1 | 2 | Chưa implement — tính năng dashboard cốt lõi |
| FR-DASH-05 | Hệ thống hiển thị tổng quan sử dụng & hoàn tiền so sánh giữa các thẻ | P2 | 2 | Chưa implement (WIP) |

---

## 4. Non-Functional Requirements

> Các target dưới đây là **đề xuất draft** cho một backend early-stage single-instance (chưa có benchmark thật) — cần điều chỉnh khi có traffic thật.

### 4.1 Performance (NFR-PERF)

| ID | Requirement | Target |
|----|-------------|--------|
| NFR-PERF-01 | API response time (P95), các endpoint CRUD đơn giản | < 300ms (Draft) |
| NFR-PERF-02 | Dashboard forecast/aggregation response time (P95) | < 1s (Draft) |
| NFR-PERF-03 | Local SQLite read cho màn hình Dashboard (khi có) | < 100ms |

### 4.2 Availability (NFR-AVAIL)

| ID | Requirement | Target |
|----|-------------|--------|
| NFR-AVAIL-01 | Backend uptime (Render, single instance, Phase 1) | Best-effort — chưa có SLA chính thức |
| NFR-AVAIL-02 | App phải hoạt động đầy đủ tính năng ghi log/dashboard khi offline (local-only mode) | Bắt buộc (P0) |

### 4.3 Security (NFR-SEC)

| ID | Requirement | Trạng thái |
|----|-------------|-----------|
| NFR-SEC-01 | Toàn bộ API traffic qua HTTPS | Phụ thuộc hosting (Render) — chưa verify cấu hình |
| NFR-SEC-02 | Không hardcode secrets; dùng biến môi trường (`DATABASE_URL`, `DIRECT_DATABASE_URL`) | Đã áp dụng |
| NFR-SEC-03 | SQL injection prevention qua parameterized query (TypeORM) | Áp dụng khi có entity/repository thật — hiện tại chưa có entity nào dùng TypeORM query builder |
| NFR-SEC-04 | API xác thực bằng access token (JWT hoặc tương đương) cho mọi endpoint ghi dữ liệu user | **Chưa implement — chặn Phase 1 release** |
| NFR-SEC-05 | Phân quyền Admin cho các API ghi dữ liệu master (`banks`, `credit_cards`, `reward_rules`, `merchant_category_codes`) | **Chưa implement** |
| NFR-SEC-06 | Dữ liệu tài chính nhạy cảm (giao dịch, số tiền) không log ra plaintext trong log hệ thống | Chưa có logging chuẩn hoá — hiện dùng Nest `Logger` mặc định |

### 4.4 Scalability (NFR-SCALE)

| ID | Requirement |
|----|-------------|
| NFR-SCALE-01 | Backend hiện tại: 1 instance trên Render, 1 Postgres instance (Supabase) — đủ cho Phase 1, chưa cần horizontal scaling |
| NFR-SCALE-02 | Khi cần scale: tách theo bounded context đã có sẵn (`contexts/*`) trước khi cân nhắc tách service vật lý |

### 4.5 Maintainability (NFR-MAINT)

| ID | Requirement | Trạng thái |
|----|-------------|-----------|
| NFR-MAINT-01 | Mọi thay đổi schema PostgreSQL phải đi qua TypeORM migration (`src/database/migrations`) | Đã là quy ước bắt buộc (xem `AGENTS.md`) |
| NFR-MAINT-02 | API documentation cập nhật theo `ARCH-API` mỗi khi thêm/đổi endpoint | Quy ước mới — cần tuân thủ từ đây |
| NFR-MAINT-03 | Test coverage: mỗi use case/domain entity mới nên có unit test tương ứng | Đã áp dụng cho `cards` demo context (`*.spec.ts`), cần duy trì khi build context thật |
| NFR-MAINT-04 | CI chạy lint + test trước khi merge | **Chưa có** — 2 workflow hiện tại (`backend-deploy.yml`, `widgetbook-cloud.yml`) chỉ build & deploy trên nhánh `develop`, không có bước lint/test trên PR (xem `PROC-CICD`) |

---

## 5. Interface Requirements

### 5.1 User Interfaces

| Nền tảng | Yêu cầu |
|----------|---------|
| Mobile (Flutter) | Android + iOS (qua Flutter), Material 3 theme (`AppTheme.light`/`AppTheme.dark`) |
| Offline mode | Bắt buộc — local-only mode phải dùng được toàn bộ tính năng log/dashboard cơ bản không cần mạng |
| Dark mode | Đã có `AppTheme.dark`, nhưng hiện chưa override custom `TextTheme` như bản light — cần hoàn thiện (xem `ARCH-DS` Known Gaps) |
| Đa ngôn ngữ | TBD — hiện chưa cấu hình `localizationsDelegates` |

### 5.2 External Interfaces

| Interface | Protocol | Trạng thái |
|-----------|----------|-----------|
| PostgreSQL (Supabase) | TCP (pg wire), qua TypeORM | Đã kết nối (runtime + migration CLI) |
| OCR / Receipt-scan provider | TBD | Chưa chọn nhà cung cấp — Phase 2 |
| Push notification (Android) | TBD (khả năng cao: Firebase Cloud Messaging) | Chưa tích hợp — Phase 2 |
| Nguồn dữ liệu chính sách ngân hàng | Thủ công (không có API chính thức) | Quy trình thu thập thủ công, xem `PRD` #2.6 |

### 5.3 Internal Interfaces (Service-to-Service)

N/A — backend hiện tại là **modular monolith** (1 service NestJS, nhiều bounded context nội bộ trong cùng process). Không có giao tiếp service-to-service qua mạng ở giai đoạn này. Nếu tách microservice trong tương lai, cập nhật mục này.

---

## 6. Data Requirements

### 6.1 Data Retention

| Data Type | Retention (đề xuất) | Storage |
|-----------|----------------------|---------|
| Tài khoản user (`users`) | Vô thời hạn (tới khi user yêu cầu xoá) | PostgreSQL |
| Giao dịch (`transactions`) | Vô thời hạn (dữ liệu tài chính cá nhân, user cần xem lại lịch sử dài hạn) | PostgreSQL + SQLite local |
| MCC feedback (`merchant_mcc_feedbacks`) | Vô thời hạn (dùng để cải thiện độ chính xác lâu dài) | PostgreSQL |
| Dữ liệu local chưa sync (SQLite) | Tới khi user đồng bộ hoặc gỡ app | SQLite on-device |

### 6.2 Data Privacy

| Requirement | Trạng thái |
|-------------|-----------|
| Người dùng local-only: dữ liệu không rời khỏi thiết bị | Theo thiết kế (chưa implement) |
| Xoá tài khoản → xoá toàn bộ dữ liệu liên quan trên cloud | Chưa thiết kế — **TBD**, cần xác định phạm vi cascade delete (đặc biệt với `transactions`, `cashback_calculations`) |
| Tuân thủ pháp lý Việt Nam về dữ liệu tài chính cá nhân | **TBD** — chưa có đánh giá pháp lý chính thức trong scope hiện tại |

---

## 7. Constraints

### 7.1 Technical Constraints

- Backend: NestJS + Fastify + TypeORM + PostgreSQL, deploy dạng Docker image lên Render.
- Mobile: Flutter, kiến trúc local-first — SQLite cục bộ (kế hoạch), sync 2 chiều với backend khi có tài khoản.
- Không dùng `synchronize: true` của TypeORM trong bất kỳ môi trường nào ngoài test cô lập — mọi thay đổi schema qua migration.

### 7.2 Business Constraints

- Chính sách hoàn tiền ngân hàng phải thu thập thủ công, không có SLA về độ mới của dữ liệu.
- Dữ liệu MCC cho merchant Việt Nam phụ thuộc vào crawl + crowdsource, không có nguồn chính thức.

### 7.3 Regulatory Constraints

**TBD** — chưa có đánh giá compliance chính thức (VD: quy định về lưu trữ dữ liệu tài chính cá nhân tại Việt Nam). Cần bổ sung trước khi launch tính năng sync cloud cho người dùng thật.

---

**Tài liệu liên quan:** [BRD](./BRD.md) · [PRD](./PRD.md) · [System Architecture](./architecture/system.md) · [API Design](./architecture/api.md) · [Database Design](./architecture/database.md)
