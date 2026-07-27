# AI/ML Architecture Document
# CardPilot - Credit Card Cashback & Rewards Intelligence Platform

**Version:** 1.0
**Date:** 2026-07-22
**Trạng thái tổng thể:** Planned (Phase 2+) — chưa có code implementation nào tại thời điểm viết tài liệu này. Không có dependency AI/ML nào (TensorFlow, OpenCV, OCR SDK, v.v.) trong `pubspec.yaml` hay `package.json` hiện tại.

---

## 1. AI Capabilities Overview

| Capability | Mục đích | Input | Output | Phase |
|------------|----------|-------|--------|-------|
| Receipt OCR | Tự động điền thông tin giao dịch từ ảnh hoá đơn | Ảnh hoá đơn (camera/gallery) | `amount`, `merchant` (raw text), `transaction_date` gợi ý | 2 |
| Image Preprocessing (OpenCV) | Tăng chất lượng ảnh trước khi OCR (crop, deskew, contrast) | Ảnh gốc | Ảnh đã chuẩn hoá | 2 |
| MCC Inference | Suy luận MCC từ tên merchant đã nhận diện | Merchant name (raw/normalized) | `mcc_code` gợi ý + `confidence_score` | 1 (rule/lookup-based) → 2 (model-based nếu cần) |
| Spend Forecast | Dự đoán chi tiêu ngày/tháng/năm | Lịch sử `transactions` | Số tiền dự đoán theo mốc thời gian | 2 |
| Card Recommendation | Gợi ý đổi/thêm thẻ khi hết hạn mức hoàn tiền | `user_cards`, `reward_rules`, chi tiêu hiện tại theo category | Danh sách thẻ đề xuất kèm lý do | 2 |
| Recurring Bill Detection | Phát hiện giao dịch định kỳ (subscription) | Lịch sử `transactions` | Danh sách bill định kỳ nghi ngờ + chu kỳ dự đoán | 2 |

---

## 2. Receipt OCR Pipeline (Planned)

### 2.1 Architecture

```
Ảnh hoá đơn (camera/gallery)
    │
    ▼
Preprocessing (OpenCV): crop, deskew, tăng contrast
    │
    ▼
OCR Engine (nhà cung cấp: TBD — on-device ML Kit / Tesseract, hoặc cloud OCR API)
    │
    ▼
Text Parsing: trích merchant name, amount, date từ raw text
    │
    ▼
MCC Inference: match merchant name (raw) → name_normalized → merchant_mcc_candidates
    │
    ▼
Preview cho user xác nhận (amount/merchant/date/mcc có thể sửa tay)
    │
    ▼
User xác nhận → tạo transactions + cashback_calculations (giống flow nhập tay)
```

### 2.2 Performance Targets (Draft)

| Stage | Target (Draft — cần đo lại khi có prototype) |
|-------|------------------------------------------------|
| Preprocessing | < 500ms trên thiết bị tầm trung |
| OCR + Parsing | < 3s |
| MCC Inference (lookup) | < 100ms |

### 2.3 Fallback Strategy

- OCR không đọc được / confidence thấp → hiển thị form nhập tay đã điền sẵn phần đọc được, để trống phần không chắc chắn, **luôn yêu cầu user xác nhận trước khi lưu** (không tự động lưu giao dịch từ OCR).
- MCC không suy luận được → để `mcc_code = null`, user có thể tự chọn hoặc bỏ qua; giao dịch vẫn được lưu nhưng không tính được cashback chính xác cho tới khi có MCC.

---

## 3. MCC Inference (Phase 1 rule-based → Phase 2+ model-based nếu cần)

### 3.1 Architecture (Phase 1 — không cần ML)

```
Merchant name (raw) → normalize (lowercase, bỏ dấu, bỏ ký tự đặc biệt) → name_normalized
    │
    ▼
So khớp với merchants.name_normalized đã có trong hệ thống (exact hoặc fuzzy match)
    │
    ▼
Nếu match → lấy merchant_mcc_candidates có confidence_score cao nhất, status = 'verified' ưu tiên hơn 'suggested'
    │
    ▼
Nếu không match → tạo merchants record mới, để merchant_mcc_candidates trống, chờ Admin/crowdsource bổ sung
```

> Phase 1 **không cần model ML** — chỉ cần string normalization + lookup table đã đủ để chạy MVP, vì phần lớn giá trị đến từ việc **xây dựng dữ liệu** (crawl + crowdsource), không phải thuật toán phức tạp.

### 3.2 Fallback Strategy

Không match được → giao dịch vẫn lưu bình thường, chỉ thiếu MCC (không chặn user). Đây là input để Admin ưu tiên bổ sung merchant đó vào hệ thống.

---

## 4. Spend Forecast Pipeline (Planned)

### 4.1 Architecture (đề xuất, đơn giản trước khi cần ML thật sự)

```
Lịch sử transactions (theo user_card, theo category/mcc) trong N chu kỳ gần nhất
    │
    ▼
Tính trung bình di động (moving average) hoặc trend tuyến tính đơn giản theo ngày trong chu kỳ hiện tại
    │
    ▼
Ngoại suy tới cuối chu kỳ (ngày/tháng/năm)
    │
    ▼
Đối chiếu với monthly_cap_amount còn lại của từng reward_rules áp dụng
    │
    ▼
Output: dự đoán tổng chi tiêu + dự đoán tiền hoàn, kèm cảnh báo nếu dự đoán vượt hạn mức hoàn tiền trước cuối chu kỳ
```

### 4.2 Performance Targets (Draft)
Tính toán hoàn toàn có thể chạy bằng aggregation SQL đơn giản (không cần ML) cho Phase 2 — chỉ cân nhắc model dự đoán phức tạp hơn (time-series ML) nếu heuristic đơn giản không đủ chính xác sau khi có dữ liệu thật.

### 4.3 Fallback Strategy
Không đủ lịch sử giao dịch (VD: user mới) → không hiển thị forecast, hiển thị thông báo "Cần thêm dữ liệu giao dịch để dự đoán chính xác hơn".

---

## 5. Card Recommendation Engine (Planned)

### 5.1 Architecture (Phase 2 — rule-based trước khi cân nhắc ML)

```
Xác định category/MCC mà user đã dùng hết monthly_cap_amount trên thẻ đang dùng
    │
    ▼
Tra reward_rules của các user_cards khác (đã có) xem có rule nào cho category đó còn hạn mức không
    │
    ▼
Nếu có → gợi ý "Dùng thẻ {X} cho category này thay vì thẻ {Y}"
Nếu không có thẻ nào phù hợp → tra credit_cards catalog (thẻ chưa sở hữu) có reward_rules tốt cho category đó → gợi ý "Cân nhắc mở thêm thẻ {Z}"
```

### 5.2 Fallback Strategy
Không có dữ liệu `reward_rules` đầy đủ cho category đó (do chưa thu thập chính sách ngân hàng) → không đưa ra gợi ý sai lệch, chỉ hiển thị cảnh báo hết hạn mức mà không kèm gợi ý thẻ cụ thể.

---

## 6. Recurring Bill Detection (Planned, Phase 2)

### 6.1 Architecture (đề xuất)
```
Nhóm transactions theo merchant_id (hoặc name_normalized) + user_card_id
    │
    ▼
Tìm pattern lặp lại theo chu kỳ ~30 ngày với amount tương tự (dung sai %)
    │
    ▼
Đánh dấu là "recurring candidate" → hiển thị cho user xác nhận là subscription
    │
    ▼
User xác nhận → nhắc nhở trước chu kỳ tiếp theo
```

---

## 7. Cost Considerations (Draft)

**TBD** — chưa chọn nhà cung cấp OCR (on-device vs cloud) nên chưa thể ước tính chi phí. Cần so sánh giữa:
- On-device OCR (VD: Google ML Kit Text Recognition) — miễn phí, không cần backend xử lý ảnh, nhưng độ chính xác với hoá đơn Việt Nam cần kiểm chứng.
- Cloud OCR API — chính xác hơn (có thể), nhưng phát sinh chi phí theo lượt gọi + cần upload ảnh (cân nhắc quyền riêng tư dữ liệu tài chính).

---

**Tài liệu liên quan:** [PRD](../PRD.md) #2.3, #2.4.1 · [SRS](../SRS.md) FR-TXN-05/06, FR-DASH-03/04 · [Database Design](./database.md)
