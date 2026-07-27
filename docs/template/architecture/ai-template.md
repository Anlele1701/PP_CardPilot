# Template: architecture/ai.md (AI/ML Architecture Document)

> File này quy định cấu trúc cho `docs/architecture/ai.md`.
> Mục tiêu: tài liệu hoá pipeline AI/ML dự kiến (OCR, forecasting, recommendation) — vì đây là roadmap chưa build, tài liệu này thiên về **thiết kế đề xuất**, phải ghi rõ trạng thái "Planned" xuyên suốt và tránh mô tả như đã tồn tại.

---

## Cấu trúc bắt buộc

```markdown
# AI/ML Architecture Document
# {Tên dự án} - {Mô tả 1 dòng}

**Version:** {X.X}
**Date:** {YYYY-MM-DD}
**Trạng thái tổng thể:** Planned (Phase {N}+) — chưa có code implementation tại thời điểm viết tài liệu này

---

## 1. AI Capabilities Overview
<!-- Bảng: Capability | Mục đích | Input | Output | Phase -->

| Capability | Mục đích | Input | Output | Phase |
|------------|----------|-------|--------|-------|
| ... | ... | ... | ... | ... |

## 2. {Capability 1} Pipeline
<!-- VD: Receipt OCR Pipeline, Spend Forecasting Pipeline, Card Recommendation Engine -->

### 2.1 Architecture
<!-- ASCII step-by-step: Input → Stage 1 → Stage 2 → ... → Output -->

### 2.2 Performance Targets (Draft)
<!-- Nếu chưa có benchmark thật, ghi rõ "Draft — cần đo lại khi có prototype" -->

### 2.3 Fallback Strategy
<!-- Khi model confidence thấp / lỗi → hành vi fallback là gì (VD: yêu cầu user nhập tay) -->

<!-- Lặp lại ## 2, ## 3 cho mỗi capability -->

## N. Cost Considerations (Draft)
<!-- Nếu chưa chọn nhà cung cấp/model, ghi "TBD — cần so sánh chi phí trước khi chọn provider" -->
```

---

## Quy tắc viết

1. Toàn bộ tài liệu này mặc định là **Planned** cho tới khi có code thật — mọi section phải giữ giọng văn "đề xuất"/"dự kiến", không viết như tính năng đã chạy.
2. Input/Output của mỗi pipeline phải khớp với **field thật đã có trong DB schema** nếu liên quan (VD: OCR pipeline phải map ra được field của bảng `transactions`: `amount`, `merchant_id`, `mcc_code`, `transaction_date`) — không tạo field mới không có trong schema mà không ghi chú "cần thêm migration mới".
3. Không copy nguyên số liệu latency/cost từ dự án khác — nếu chưa benchmark, ghi "Draft/TBD" kèm lý do.
4. Fallback Strategy là mục bắt buộc cho mọi pipeline liên quan tới dữ liệu tài chính (OCR, cashback calculation) — vì sai sót ảnh hưởng trực tiếp tới độ tin cậy của số liệu hiển thị cho user.
