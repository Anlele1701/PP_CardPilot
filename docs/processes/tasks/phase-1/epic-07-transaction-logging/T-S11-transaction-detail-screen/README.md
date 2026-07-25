# T-S11 — Transaction Detail Screen

**Module (chủ đạo):** `MOBILE` — xem subtask cho breakdown (BE/MOBILE/QA)
**Phase:** 1
**Epic:** Epic 7 — Transaction Logging
**Status:** Backlog
**Prototype:** [prototype.html#view-s11](../../../../../prototypes/prototype.html#view-s11) — mở file, tự nhảy tới S11 (phân tích cashback + báo sai MCC)

## Mô tả

Chi tiết 1 giao dịch + cashback ước tính đã tính, nút gửi feedback nếu MCC gán sai.

## Acceptance Criteria

- [ ] Hiển thị đầy đủ: merchant, amount, ngày, thẻ đã dùng, MCC/category đã gán, `estimated_cashback_amount` đã tính
- [ ] Bấm "Báo sai MCC" → chọn/nhập MCC đúng theo user nghĩ → gửi feedback, hiển thị xác nhận đã gửi
- [ ] Gửi feedback xong → không cho gửi lại feedback trùng cho cùng giao dịch đó (hoặc cho phép nhưng ghi đè — quyết định cụ thể: TBD, cần UX xác nhận)
- [ ] Giao dịch không thuộc về user hiện tại (thử truy cập trực tiếp qua ID) → BE trả `403`/`404`, mobile hiển thị lỗi phù hợp

## Dependencies

- **Depends On (Task):** [T-S10.1](../T-S10-transaction-history-screen/T-S10.1-be-get-transactions-list.md)
- **Depends On (Phase Gate):** —

## Ref Docs

- [SRS — 3.7 FR-TXN](../../../../../SRS.md)
- [SRS — 3.5 FR-MCC (FR-MCC-04)](../../../../../SRS.md)

## Subtasks

| ID | Module | Subtask | Status | File |
|----|--------|---------|--------|------|
| T-S11.1 | `BE` | GET /api/transactions/:id (detail) | Backlog | [T-S11.1-be-get-transaction-detail.md](./T-S11.1-be-get-transaction-detail.md) |
| T-S11.2 | `BE` | User feedback MCC — POST /api/merchants/:id/mcc-feedback | Backlog | [T-S11.2-be-user-feedback-mcc.md](./T-S11.2-be-user-feedback-mcc.md) |
| T-S11.3 | `MOBILE` | Transaction Detail screen UI/logic | Backlog | [T-S11.3-mobile-transaction-detail-screen.md](./T-S11.3-mobile-transaction-detail-screen.md) |
| T-S11.4 | `QA` | Test case: xem giao dịch người khác, gửi feedback | Backlog | [T-S11.4-qa-transaction-detail-tests.md](./T-S11.4-qa-transaction-detail-tests.md) |

## Audit Trail

| Status | Created By | Created Date | Updated By | Updated Date | Reviewed/Approved By | Review Date | Ghi chú |
|--------|-----------|---------------|-----------|---------------|------------------------|--------------|---------|
| Backlog | TBD | 2026-07-25 | — | — | — | — | Chờ T-S10.1 |

---
Index toàn backlog: [`../../../../tasks.md`](../../../../tasks.md)
