# T-S10 — Transaction History Screen

**Module (chủ đạo):** `MOBILE` — xem subtask cho breakdown (BE/MOBILE)
**Phase:** 1
**Epic:** Epic 7 — Transaction Logging
**Status:** Backlog
**Prototype:** [prototype.html#view-s10](../../../../../prototypes/prototype.html#view-s10) — mở file, tự nhảy tới S10 (lịch sử + bộ lọc thẻ/danh mục)

## Mô tả

Danh sách giao dịch đã log, filter theo thẻ/khoảng thời gian.

## Acceptance Criteria

- [ ] Hiển thị danh sách giao dịch mới nhất trước (sort theo `transaction_date DESC`)
- [ ] Filter theo 1 thẻ cụ thể → chỉ hiển thị giao dịch của thẻ đó
- [ ] Filter theo khoảng thời gian → chỉ hiển thị giao dịch trong khoảng đã chọn
- [ ] Chưa có giao dịch nào (hoặc filter ra rỗng) → empty state phù hợp (khác message cho "chưa từng có giao dịch" vs "không có kết quả filter")
- [ ] Tap vào 1 giao dịch → điều hướng sang Transaction Detail (S11)
- [ ] Danh sách dài → phân trang/lazy load, không load hết 1 lần gây lag

## Dependencies

- **Depends On (Task):** [T-MOBILE-001](../../epic-02-auth/T-MOBILE-001-core-network-api-client/README.md)
- **Depends On (Phase Gate):** —

## Ref Docs

- [SRS — 3.7 FR-TXN](../../../../../SRS.md)
- [PRD — 2.3 Transaction Logging](../../../../../PRD.md#23-transaction-logging)

## Subtasks

| ID | Module | Subtask | Status | File |
|----|--------|---------|--------|------|
| T-S10.1 | `BE` | GET /api/transactions (list, filter card/date) | Backlog | [T-S10.1-be-get-transactions-list.md](./T-S10.1-be-get-transactions-list.md) |
| T-S10.2 | `MOBILE` | Transaction History screen UI/logic | Backlog | [T-S10.2-mobile-transaction-history-screen.md](./T-S10.2-mobile-transaction-history-screen.md) |

## Audit Trail

| Status | Created By | Created Date | Updated By | Updated Date | Reviewed/Approved By | Review Date | Ghi chú |
|--------|-----------|---------------|-----------|---------------|------------------------|--------------|---------|
| Backlog | TBD | 2026-07-25 | — | — | — | — | Chờ T-MOBILE-001 |

---
Index toàn backlog: [`../../../../tasks.md`](../../../../tasks.md)
