# Business Requirements Document (BRD)
# CardPilot - Credit Card Cashback & Rewards Intelligence Platform

**Version:** 1.0
**Date:** 2026-07-22
**Author:** CardPilot Team

> **Note on figures in this document**: numeric targets (users, engagement, revenue) are **draft placeholders** marked `TBD` or `Draft` — they have not been validated with stakeholders and must be revisited before being used for planning or reporting. Everything describing product scope and data model is grounded in the current repository (`apps/cardpilot-backend`, `apps/cardpilot-mobile`) as of this version's date.

---

## 1. Executive Summary

CardPilot giúp người dùng sở hữu nhiều thẻ tín dụng theo dõi chi tiêu và hạn mức hoàn tiền (cashback) của từng thẻ theo **MCC (Merchant Category Code)** trong thời gian thực. Thay vì phải tự nhớ hoặc tính tay "thẻ MSB Mdigi hoàn tiền ăn uống tối đa 300k/tháng, mình đã xài bao nhiêu rồi", CardPilot ghi nhận giao dịch, map với MCC, đối chiếu với rule hoàn tiền của từng thẻ, và cho biết còn bao nhiêu hạn mức hoàn tiền trong tháng — đồng thời gợi ý khi nên dùng thẻ khác hoặc mở thêm thẻ mới để không bỏ lỡ ưu đãi.

CardPilot vận hành theo mô hình **local-first**: Giai đoạn 1, ứng dụng mobile (Flutter) lưu dữ liệu cục bộ bằng SQLite, người dùng có thể dùng app mà không cần đăng ký tài khoản (không đồng bộ cloud, có quảng cáo). Người dùng đăng ký và đồng bộ sẽ có dữ liệu backed up trên PostgreSQL (Supabase) qua backend NestJS, mở khoá dashboard nâng cao và giảm quảng cáo theo cấp độ thành viên.

## 2. Business Objectives

### 2.1 Primary Objectives

- Cho người dùng biết **chính xác còn bao nhiêu hạn mức hoàn tiền** của từng thẻ trong chu kỳ hiện tại, theo từng MCC/category.
- Giảm việc phải tự tra cứu chính sách hoàn tiền của nhiều ngân hàng (MSB, TPBank, ...) bằng cách tập trung rule vào một nơi (`reward_rules`, `reward_rule_mccs`).
- Xây dựng và làm giàu dần một **bộ dữ liệu MCC cho merchant Việt Nam** (vd: Haidilao → MCC 5812) thông qua crawl + crowdsourced feedback từ chính người dùng.
- Tăng mức độ gắn bó người dùng qua cơ chế **membership/level** gắn với hành vi ghi log giao dịch (gamification), thay vì chỉ dựa vào tính năng đơn thuần.
- Cho phép dùng app **hoàn toàn không cần tài khoản** (local-only, có quảng cáo) để giảm rào cản dùng thử, đồng thời khuyến khích nâng cấp lên tài khoản có sync + nhiều tiện ích hơn.

### 2.2 Success Metrics (Draft — cần xác nhận với stakeholder)

| Metric | Phase 1 (MVP) | Phase 2 |
|--------|---------------|---------|
| Active users (local + synced) | TBD | TBD |
| % users chọn "Sign in & Sync" thay vì "Dùng thử/local" | TBD | TBD |
| Giao dịch được log trung bình / user / tháng | TBD | TBD |
| % giao dịch log thủ công so với qua OCR/receipt scan | 100% thủ công | Giảm dần khi OCR ra mắt |
| Số MCC candidate được verify qua feedback loop | TBD | TBD |

## 3. Business Model

CardPilot **không phải** nền tảng affiliate/thương mại — không có hoa hồng bán hàng. Mô hình doanh thu xoay quanh **quảng cáo** và **giới hạn tính năng theo cấp độ thành viên (membership tier)**.

### 3.1 Membership Tiers (Freemium, gamified)

| Tier | Quảng cáo | Dashboard | Giới hạn (theo bảng `memberships`) | Cách lên hạng |
|------|-----------|-----------|--------------------------------------|----------------|
| Bronze | Nhiều | Giới hạn (basic) | `max_cards`, `max_receipt_scans_per_month`, `max_cashback_calculations_per_month` thấp nhất | Mặc định khi tạo tài khoản |
| Gold | Giảm | Mở thêm widget | Giới hạn cao hơn Bronze | Tích điểm qua log giao dịch (WIP — công thức tính điểm chưa chốt) |
| Platinum | Giảm nhiều | Mở gần hết | Cao hơn Gold | WIP |
| Diamond | Rất ít | Đầy đủ | Cao hơn Platinum | WIP |
| Obsidian | Không quảng cáo | Đầy đủ + ưu tiên | Cao nhất (không giới hạn thực tế) | WIP |

> **Trạng thái hiện tại**: bảng `memberships` và `user_memberships` đã có trong schema (migration `1784410000000-create-initial-schema.ts`) nhưng **chưa có logic nào áp dụng giới hạn hoặc tính điểm lên hạng** trong code. Đây là backlog rõ ràng cho Phase 1/2 — xem `SRS` mục FR-MEMBER và `PRD` mục 2.2.

### 3.2 Local-only Mode (No Account)

Người dùng có thể bỏ qua đăng nhập (nút "Dùng thử" / "Skip"), dùng toàn bộ tính năng ghi log + dashboard cơ bản với dữ liệu chỉ lưu trên SQLite cục bộ. Đổi lại: hiển thị quảng cáo, không đồng bộ cloud, mất dữ liệu nếu gỡ app. Đây là chiến lược giảm rào cản onboarding — không ép người dùng tạo tài khoản để dùng thử giá trị cốt lõi.

### 3.3 Advertising

Tần suất/loại quảng cáo tỉ lệ nghịch với membership tier. Chi tiết nhà cung cấp quảng cáo, vị trí hiển thị: **TBD** (chưa có trong scope hiện tại của repo).

### 3.4 Future Monetization (Phase 3+, không cam kết)

- Gói Pro trả phí (bỏ qua yêu cầu tích điểm, unlock ngay Obsidian-tier features) — **TBD, chưa có quyết định**.

## 4. Target Users

### 4.1 Primary Persona

- **Đối tượng**: Người dùng Việt Nam sở hữu từ 2 thẻ tín dụng trở lên, quan tâm đến tối ưu hoàn tiền/điểm thưởng.
- **Hành vi**: Chủ động theo dõi chi tiêu, khó chịu khi phải tự nhớ hạn mức hoàn tiền của từng thẻ, thường xuyên kiểm tra app ngân hàng.
- **Pain point chính**:
  - "Tôi đã xài hết hạn mức hoàn tiền ăn uống của thẻ A chưa? Có nên chuyển sang thẻ B không?"
  - "Merchant này thuộc MCC nào? Ngân hàng tính hoàn tiền kiểu gì cho merchant đó?"
  - Chính sách hoàn tiền của ngân hàng thay đổi thường xuyên và không dễ tra cứu (khác biệt giữa MSB, TPBank, v.v.)

### 4.2 Secondary Persona (định hướng, chưa build)

- Người dùng muốn theo dõi **recurring bills/subscription** hàng tháng để không bị tính phí ngoài ý muốn (Phase 2).

## 5. User Roles & Permissions

CardPilot không có vai trò "Creator" hay affiliate như các nền tảng thương mại — chỉ có 2 nhóm vai trò:

### 5.1 User (End Consumer)

- Đăng ký / Đăng nhập / Quên mật khẩu / Đăng xuất
- Xem & chỉnh sửa thông tin cá nhân, xem membership level hiện tại
- CRUD thẻ tín dụng cá nhân (`user_cards`)
- Ghi log giao dịch (`transactions`), gửi feedback MCC (`merchant_mcc_feedbacks`) khi hệ thống đoán sai
- Xem dashboard: dự đoán chi tiêu, phân bổ theo MCC/category, tổng quan hoàn tiền theo từng thẻ
- Đồng bộ dữ liệu local (SQLite) lên cloud (Postgres/Supabase) qua nút "Sync" — hoặc dùng hoàn toàn local, không tài khoản

### 5.2 Admin

- Quản lý dữ liệu master: `banks`, `credit_cards`, `reward_rules`, `reward_rule_mccs`, `merchant_category_codes` (seed hoặc qua API admin-only)
- Duyệt/xử lý `merchant_mcc_candidates` và `merchant_mcc_feedbacks` (crowdsourced MCC mapping)
- Quản lý `memberships` (định nghĩa tier, giới hạn)

> **Trạng thái hiện tại**: Chưa có role/permission nào được implement trong backend (không có guard, không có RBAC). Đây là yêu cầu bắt buộc trước khi build bất kỳ API ghi dữ liệu nào — xem `SRS` FR-AUTH và `ARCH-API`.

## 6. Core Features

### 6.1 User Management

- Register Account (1 màn hình)
- Forgot Password (1 màn hình)
- Sign in (1 màn hình)
- Sign out
- Change User Information
- View User Information (bao gồm Membership Level hiện tại — mọi giao dịch user log được tính vào điểm lên hạng)

### 6.2 User Membership Management

- 4-5 cấp: Bronze, Gold, Platinum, Diamond, Obsidian
- Bronze: nhiều quảng cáo, dashboard giới hạn
- Lên hạng qua việc log giao dịch (WIP — công thức điểm chưa chốt, xem `PRD` #2.2)

### 6.3 Transaction Logging

- Phase 1: nhập tay (manual) — map với `user_card_id`, `merchant_id` (tuỳ chọn), `mcc_code`
- Phase 2: OCR quét hoá đơn tự động điền thông tin giao dịch (xem `ARCH-AI`)

### 6.4 Dashboard

- **Forecast chi tiêu** hàng ngày/tháng/năm và tiền hoàn (reward) dự kiến
  - Ví dụ nghiệp vụ cụ thể: user đã dùng hết hạn mức hoàn tiền của thẻ nhưng vẫn tiếp tục chi tiêu thêm ở category đó → hệ thống nhận diện và **gợi ý mở thêm thẻ khác** có ưu đãi phù hợp cho category còn lại trong tháng (xem `PRD` #2.4.1)
- **Biểu đồ tròn (pie chart)** phân bổ chi tiêu theo MCC/Category
- **"Hũ chi tiêu" (Cashback Jar/Pocket) theo từng thẻ đã liên kết** — một card component hiển thị hoàn tiền hiện tại của từng thẻ (đã dùng bao nhiêu / còn lại bao nhiêu trong hạn mức hoàn tiền tháng này) (xem `PRD` #2.4.2)
- Tổng quan sử dụng thẻ & hoàn tiền theo từng thẻ (WIP)

### 6.5 Card Management

- CRUD thẻ tín dụng của người dùng (chọn ngân hàng + sản phẩm thẻ có sẵn trong hệ thống, đặt nickname, billing cycle day)

### 6.6 Card Rule Management

- Quản lý rule hoàn tiền/điểm thưởng theo thẻ: tỷ lệ hoàn tiền, hạn mức tháng (`monthly_cap_amount`), MCC áp dụng, điều kiện tối thiểu
- **Thách thức nghiệp vụ**: chính sách ngân hàng (MSB, TPBank, ...) không có API công khai → phải thu thập thủ công/crawl, lưu `source_url` + `last_verified_at` để theo dõi độ mới của rule

### 6.7 MCC Management

- Quản lý bảng MCC chuẩn (`merchant_category_codes`) — chỉ Admin
- Quản lý merchant + MCC candidate crowdsourced (`merchants`, `merchant_mcc_candidates`) — vd: Haidilao → MCC 5812
- **Thách thức nghiệp vụ**: thông tin MCC của merchant Việt Nam không có nguồn chính thức → phải crawl web + học từ feedback người dùng (`merchant_mcc_feedbacks`)

## 7. Competitive Analysis (Draft)

| Tiêu chí | CardPilot | App ngân hàng (MSB/TPBank app...) | App quản lý chi tiêu chung (Money Lover, Spendee...) |
|----------|-----------|-------------------------------------|--------------------------------------------------------|
| Theo dõi hạn mức hoàn tiền theo MCC, đa ngân hàng | ✅ | ❌ (chỉ thẻ của ngân hàng đó) | ❌ |
| Gợi ý chuyển/thêm thẻ khi hết hạn mức ưu đãi | ✅ | ❌ | ❌ |
| Dùng offline-first, không bắt buộc tài khoản | ✅ | ❌ | Tuỳ app |
| OCR hoá đơn tự động (Phase 2) | ✅ (kế hoạch) | ❌ | Một số app có |
| Miễn phí có quảng cáo, tier cao giảm quảng cáo | ✅ | N/A | Tuỳ app |

## 8. Revenue Projections

**TBD.** Chưa có số liệu doanh thu/quảng cáo cụ thể được cung cấp. Khi có, bổ sung theo cấu trúc: `Phase | Timeline | Users | Monthly Revenue (Ads)`.

## 9. Constraints & Assumptions

### Constraints

- **Chính sách ngân hàng không có API công khai** — MSB, TPBank, v.v. cần thu thập thông tin thủ công, lưu vào `reward_rules`/`reward_rule_mccs` và duy trì độ mới (`last_verified_at`).
- **Dữ liệu MCC merchant Việt Nam** không có nguồn chính thức đầy đủ — cần crawl web + vòng lặp feedback người dùng.
- **Đồng bộ dữ liệu local ↔ cloud**: chưa có cơ chế xác định giao dịch hợp lệ (tránh gian lận điểm/hoàn tiền) khi user bấm "Sync" — cần thiết kế trước khi bật tính năng sync (xem `SRS` NFR liên quan đến data integrity).
- Team nhỏ, mobile-first, một backend monorepo (Nx) dùng chung cho tất cả context.

### Assumptions

- Người dùng sẵn sàng nhập tay giao dịch ở Phase 1 trước khi có OCR.
- Kiến trúc local-first (SQLite) chấp nhận được đánh đổi độ phức tạp đồng bộ để đổi lấy trải nghiệm offline tốt.
- Supabase Postgres tiếp tục là nơi lưu trữ dữ liệu nguồn (source of truth) cho tài khoản đã đăng ký.

## 10. Risks

| Risk | Impact | Probability | Mitigation |
|------|--------|-------------|------------|
| MCC map sai → tính hoàn tiền sai → mất lòng tin người dùng | Cao | Trung bình | Confidence score (`merchant_mcc_candidates.confidence_score`) + feedback loop (`merchant_mcc_feedbacks`) + admin review |
| Chính sách ngân hàng thay đổi mà rule không cập nhật kịp | Cao | Trung bình | `effective_from`/`effective_to`, `last_verified_at`, `source_url` trên `reward_rules` để theo dõi hết hạn |
| Xung đột dữ liệu khi sync local SQLite ↔ cloud Postgres | Trung bình | Cao (chưa có giải pháp) | Cần thiết kế chiến lược conflict resolution trước khi launch tính năng Sync (xem `ARCH-DB` #Local Cache Strategy) |
| Không có auth/RBAC ở backend hiện tại | Cao | Chắc chắn (hiện trạng) | Bắt buộc trước khi mở bất kỳ API ghi dữ liệu người dùng thật |
| Người dùng không đủ động lực ghi log thủ công (trước khi có OCR) | Trung bình | Trung bình | Gamification qua membership/level |

---

**Tài liệu liên quan:** [PRD](./PRD.md) · [SRS](./SRS.md) · [System Architecture](./architecture/system.md) · [Database Design](./architecture/database.md)
