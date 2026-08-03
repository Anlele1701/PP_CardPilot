# Product Requirements Document (PRD)
# CardPilot - Credit Card Cashback & Rewards Intelligence Platform

**Version:** 1.0
**Date:** 2026-07-22
**Author:** CardPilot Team

---

## 1. Product Overview

### 1.1 Product Vision

CardPilot = "Đồng phi công" cho ví thẻ tín dụng của bạn — luôn biết chính xác còn bao nhiêu hạn mức hoàn tiền của từng thẻ, trước khi bạn quẹt thẻ tiếp.

### 1.2 Problem Statement

- Người dùng sở hữu nhiều thẻ tín dụng không nhớ nổi hạn mức hoàn tiền theo từng category/MCC của từng thẻ (VD: MSB Mdigi hoàn tiền ăn uống tối đa 300k/tháng).
- Người dùng vẫn tiếp tục chi tiêu ở 1 category sau khi đã dùng hết hạn mức hoàn tiền của thẻ đang dùng, mà không biết nên đổi sang thẻ khác hoặc mở thêm thẻ mới.
- Việc tra cứu merchant thuộc MCC nào để biết có được hoàn tiền hay không là thủ công, không có nguồn tra cứu tiếng Việt đáng tin cậy.
- Ghi log chi tiêu thủ công tốn công, không có động lực duy trì lâu dài.

### 1.3 Solution

- **Card Rule Management**: tập trung rule hoàn tiền của từng thẻ (tỷ lệ, hạn mức tháng, MCC áp dụng) vào một nơi.
- **Transaction Logging + MCC mapping**: ghi log giao dịch, map merchant → MCC, tính hoàn tiền dự kiến theo rule của thẻ đã dùng.
- **Dashboard dự đoán**: cảnh báo khi gần/đã vượt hạn mức hoàn tiền, gợi ý đổi/thêm thẻ.
- **Membership gamification**: khuyến khích ghi log đều đặn bằng cơ chế lên hạng.
- **Local-first**: dùng được ngay không cần tài khoản; đăng ký để đồng bộ cloud và mở khoá tiện ích.

## 2. Product Modules

### 2.1 User Management

| Screen | Mô tả | Priority | Phase |
|--------|-------|----------|-------|
| Register Account | 1 màn hình — tạo tài khoản mới | P0 | 1 |
| Forgot Password | 1 màn hình — reset mật khẩu | P0 | 1 |
| Sign in | 1 màn hình — đăng nhập, có nút "Dùng thử/Skip" vào chế độ local-only | P0 | 1 |
| Sign out | Đăng xuất, giữ dữ liệu local nếu có | P0 | 1 |
| Change User Information | Form chỉnh sửa profile | P1 | 1 |
| View User Information | Xem thông tin cá nhân + Membership Level hiện tại | P0 | 1 |

> **Trạng thái hiện tại**: Flutter app vào thẳng Sign in; onboarding carousel đã được gỡ. Mobile đã hỗ trợ Supabase email/password, Google/Facebook OAuth, sign-out và nút `Continue as guest`. Cả guest và authenticated user dùng chung `initial_setup`: nhập display name → tạo thẻ đầu tiên → Home shell. Persistence nghiệp vụ hiện là in-memory prototype; SQLite, backend user bootstrap và cloud sync vẫn chưa implement. Forgot-password hiện mới là thông báo placeholder.

### 2.2 User Membership Management

| Item | Mô tả |
|------|-------|
| Số cấp | 4-5 cấp: Bronze, Gold, Platinum, Diamond, Obsidian |
| Bronze (mặc định) | Nhiều quảng cáo, dashboard giới hạn theo `memberships.max_cards`/`max_receipt_scans_per_month`/`max_cashback_calculations_per_month` |
| Cách lên hạng | Tích điểm qua việc ghi log giao dịch (**WIP** — công thức tính điểm/ngưỡng lên hạng chưa chốt) |
| Giới hạn theo tier | Số thẻ tối đa, số lượt quét hoá đơn/tháng, số lượt tính cashback/tháng — đã có field trong bảng `memberships`, **chưa có logic enforce** |

### 2.3 Transaction Logging

#### Input (Phase 1 — nhập tay)
| Field | Mô tả | Bảng liên quan |
|-------|-------|-----------------|
| user_card_id | Thẻ dùng để giao dịch | `user_cards` |
| merchant | Tên merchant (tự do nhập, hoặc chọn từ gợi ý đã có) | `merchants` |
| amount, currency | Số tiền, đơn vị tiền tệ | `transactions` |
| transaction_date | Ngày giao dịch | `transactions` |
| mcc_code (tuỳ chọn, có thể tự suy luận từ merchant) | Mã MCC | `merchant_category_codes`, `merchant_mcc_candidates` |
| note | Ghi chú | `transactions` |

#### Processing Pipeline (dự kiến)
```
Nhập giao dịch → Suy luận MCC từ merchant (merchant_mcc_candidates, ưu tiên confidence cao nhất)
→ Match reward_rules còn hiệu lực của thẻ đã chọn → Tính cashback_estimated_amount
→ Lưu transactions + cashback_calculations → Cập nhật dashboard
```

#### Output
- Giao dịch được lưu, hiển thị trong lịch sử.
- Ước tính hoàn tiền (`cashback_estimated_amount`, `cashback_confidence`) hiển thị ngay sau khi log.
- Nếu user thấy MCC suy luận sai → gửi feedback (`merchant_mcc_feedbacks`) để cải thiện độ chính xác lần sau.

#### Phase 2 — OCR
- Quét hoá đơn → tự động điền `amount`, `merchant`, `transaction_date` → user xác nhận trước khi lưu (xem `ARCH-AI`).

### 2.4 Dashboard

#### 2.4.1 Spend Forecast & Card Recommendation

**Input**: lịch sử `transactions` trong chu kỳ hiện tại của từng `user_card`, `reward_rules.monthly_cap_amount` áp dụng.

**Output**:
- Dự đoán chi tiêu còn lại trong ngày/tháng/năm theo xu hướng hiện tại.
- Dự đoán tiền hoàn (reward) dự kiến nhận được trong chu kỳ.
- **Kịch bản cụ thể** (theo yêu cầu sản phẩm): nếu user đã dùng hết hạn mức hoàn tiền (`monthly_cap_amount`) của 1 category/MCC trên thẻ đang dùng nhưng vẫn tiếp tục chi tiêu ở category đó → hệ thống cảnh báo "Đã hết hạn mức hoàn tiền cho {category} trên thẻ {X}" và **gợi ý thẻ khác** (trong số `user_cards` hiện có, hoặc gợi ý thêm thẻ mới từ catalog `credit_cards`) có `reward_rules` phù hợp hơn cho category đó.

> **Trạng thái hiện tại**: Chưa có logic nào được implement — đây là tính năng dashboard cốt lõi cần ưu tiên cao ở Phase 1/2. Engine gợi ý thẻ (recommend) ở mức đơn giản (rule-based, so sánh `reward_rules` hiện có) trước khi cân nhắc ML.

#### 2.4.2 Cashback Jar/Pocket theo từng thẻ

Một **card component** hiển thị "hũ chi tiêu" (jar/pocket) cho từng thẻ tín dụng đã liên kết (`user_cards`), mỗi hũ thể hiện tình trạng hoàn tiền hiện tại của thẻ đó:

| Thành phần hiển thị | Nguồn dữ liệu |
|----------------------|----------------|
| Tên/nickname thẻ | `user_cards.nickname`, `credit_cards.name` |
| Hạn mức hoàn tiền tháng này (tổng) | `reward_rules.monthly_cap_amount` |
| Đã dùng bao nhiêu trong hạn mức | SUM(`cashback_calculations.estimated_cashback_amount`) trong chu kỳ hiện tại |
| Còn lại bao nhiêu | Hạn mức − Đã dùng |
| Thanh tiến trình (progress bar) | % đã dùng / hạn mức |

Danh sách "hũ" xếp theo thẻ, cuộn ngang hoặc dạng list trên Dashboard — mỗi hũ là 1 card component độc lập, tái sử dụng được (đặt trong `cardpilot_ui` khi đã ổn định về UI).

#### 2.4.3 Category Breakdown

- Biểu đồ tròn (pie chart) phân bổ chi tiêu theo MCC/Category trong chu kỳ đã chọn (tuần/tháng/năm).

#### 2.4.4 Card Usage & Refund Summary (WIP)

- Tổng quan chi tiêu + hoàn tiền theo từng thẻ, so sánh giữa các thẻ.

### 2.5 Card Management

| Action | Mô tả |
|--------|-------|
| Add card | Chọn ngân hàng (`banks`) → chọn sản phẩm thẻ (`credit_cards`) → đặt nickname, billing cycle day, đánh dấu is_default |
| Edit card | Sửa nickname, billing cycle day, is_default |
| Delete card | Xoá thẻ (giữ nguyên `transactions` lịch sử — không cascade xoá giao dịch) |
| List cards | Xem danh sách thẻ đã thêm |

> Giới hạn số thẻ tối đa theo membership tier (`memberships.max_cards`) — **WIP**, chưa enforce trong code.

### 2.6 Card Rule Management

| Action | Mô tả | Vai trò |
|--------|-------|---------|
| Xem rule của thẻ | Xem tỷ lệ hoàn tiền/điểm, hạn mức tháng, MCC áp dụng, điều kiện tối thiểu | User |
| Quản lý rule master data | Thêm/sửa `reward_rules` + `reward_rule_mccs` cho từng `credit_cards` | Admin |

**Thách thức nghiệp vụ** (theo `BRD` #6.6): chính sách ngân hàng (MSB, TPBank, ...) không có API công khai. Quy trình đề xuất:
1. Thu thập thủ công từ trang chính sách của ngân hàng → lưu `source_url`.
2. Ghi `effective_from`/`effective_to` khi chính sách có thời hạn.
3. Định kỳ re-verify, cập nhật `last_verified_at`; rule quá hạn re-verify cần cảnh báo Admin.

### 2.7 MCC Management

| Action | Mô tả | Vai trò |
|--------|-------|---------|
| Quản lý MCC chuẩn | CRUD `merchant_category_codes` | Admin |
| Xem merchant → MCC candidate | Xem `merchants` + `merchant_mcc_candidates` (kèm confidence_score) | Admin |
| Duyệt candidate | Chuyển `status` từ `suggested` → `verified`/`rejected` | Admin |
| Gửi feedback MCC | User báo sai MCC cho 1 merchant (`merchant_mcc_feedbacks`) | User |
| Duyệt feedback | Admin xem xét feedback, cập nhật `merchant_mcc_candidates` tương ứng | Admin |

**Thách thức nghiệp vụ**: dữ liệu MCC theo merchant Việt Nam (VD: Haidilao → MCC 5812) không có nguồn chính thức — cần crawl web + học dần từ feedback người dùng (crowdsourced loop).

## 3. Non-Functional Requirements

Chi tiết đầy đủ tại `SRS` #4. Tóm tắt:

### 3.1 Performance
Chưa có benchmark chính thức (backend hiện tại chỉ có 3 endpoint demo/health) — xem `SRS` NFR-PERF cho target đề xuất.

### 3.2 Scalability
Giai đoạn hiện tại: single Postgres instance (Supabase), single backend instance (Render). Chưa cần chiến lược scale ngang.

### 3.3 Security
**Chưa có authentication/authorization nào được implement** trong backend hiện tại (không guard, không JWT, không RBAC). Đây là yêu cầu chặn trước khi launch bất kỳ tính năng ghi dữ liệu người dùng thật nào — xem `SRS` FR-AUTH.

### 3.4 Accessibility
Chưa có yêu cầu chính thức (VD: WCAG level, đa ngôn ngữ) — **TBD**.

## 4. User Flows

### 4.1 New User Onboarding
```
Mở app → Sign in →
[Email/password hoặc Google/Facebook] → Supabase xác thực → Initial setup
[Continue as guest] → Initial setup local-only
Initial setup → Nhập display name → Tạo thẻ đầu tiên → Home shell
```

> Shared initial setup và Home shell đã implement bằng in-memory repository để kiểm tra UX. Dữ liệu chưa tồn tại sau khi app process bị đóng. Thiết kế Drift/SQLite để thay adapter này nằm tại [`architecture/mobile-sqlite.md`](./architecture/mobile-sqlite.md) và đang chờ review.

### 4.2 Add First Card
```
Dashboard (chưa có thẻ) → "Thêm thẻ" → Chọn ngân hàng → Chọn sản phẩm thẻ →
Đặt nickname + billing cycle day → Lưu → Dashboard hiện "hũ" cashback cho thẻ mới
```

### 4.3 Log Transaction (Manual)
```
"Thêm giao dịch" → Chọn thẻ đã dùng → Nhập merchant → Hệ thống gợi ý MCC (nếu có candidate) →
Nhập số tiền + ngày → Lưu → Hiển thị hoàn tiền ước tính ngay lập tức → Cập nhật "hũ" cashback của thẻ đó
```

### 4.4 Sync Local → Cloud
```
User dùng local-only bấm "Đăng nhập/Đăng ký" từ Settings →
Xác thực tài khoản → Hệ thống đối chiếu transactions local (SQLite) với cloud (Postgres) →
[Outbox + idempotency + optimistic conflict handling theo mobile SQLite proposal] →
Đồng bộ thành công → Tiếp tục dùng app với dữ liệu đã hợp nhất
```

> Flow 4.4 đã có kiến trúc đề xuất nhưng chưa implement. Các quyết định còn cần
> duyệt gồm workspace topology, encryption/backup, backend dataset version,
> server version, idempotency retention và conflict UX; xem
> `architecture/mobile-sqlite.md`.

## 5. Release Criteria

### Phase 1 — Must Have
- [ ] Đăng ký/Đăng nhập/Đăng xuất/Quên mật khẩu
- [ ] Chế độ dùng local-only không cần tài khoản (có quảng cáo)
- [ ] CRUD thẻ tín dụng cá nhân (`user_cards`)
- [ ] Ghi log giao dịch thủ công
- [ ] Card Rule Management: seed `reward_rules`/`reward_rule_mccs` cho ít nhất vài thẻ phổ biến
- [ ] MCC Management: seed `merchant_category_codes` chuẩn + cơ chế crowdsource `merchant_mcc_candidates`/`merchant_mcc_feedbacks` cơ bản
- [ ] Dashboard: Cashback Jar/Pocket theo thẻ + Category pie chart
- [ ] Membership: hiển thị level hiện tại (chưa cần enforce giới hạn)

### Phase 2 — Should Have
- [ ] Spend Forecast + Recommend Additional Card
- [ ] OCR quét hoá đơn
- [ ] Recurring bills/subscription tracking
- [ ] Push notification (Android)
- [ ] Enforce giới hạn theo membership tier + công thức lên hạng
- [ ] Cơ chế sync local ↔ cloud có conflict resolution

### Phase 3+ — Nice to Have
- [ ] TensorFlow/OpenCV nhận diện hình ảnh hoá đơn nâng cao (preview trước khi OCR parse)
- [ ] Card Usage & Refund Summary nâng cao (so sánh đa thẻ, xu hướng dài hạn)
- [ ] Gói Pro trả phí (nếu được quyết định — xem `BRD` #3.4)

---

**Tài liệu liên quan:** [BRD](./BRD.md) · [SRS](./SRS.md) · [API Design](./architecture/api.md) · [Database Design](./architecture/database.md) · [AI Architecture](./architecture/ai.md)
