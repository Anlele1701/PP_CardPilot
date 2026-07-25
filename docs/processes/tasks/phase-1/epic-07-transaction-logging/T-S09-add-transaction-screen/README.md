# T-S09 — Add Transaction Screen

**Module (chủ đạo):** `MOBILE` — xem subtask cho breakdown (BE/AI/MOBILE/QA)
**Phase:** 1
**Epic:** Epic 7 — Transaction Logging
**Status:** Backlog
**Prototype:** [prototype.html#view-s09](../../../../../prototypes/prototype.html#view-s09) — mở file, tự nhảy tới S09 (Ghi log + Auto MCC + Realtime Cashback)

## Mô tả

Chọn thẻ đã dùng, nhập merchant (gợi ý MCC tự động nếu match), số tiền, ngày, ghi chú — hiển thị ước tính cashback realtime khi đang nhập (giống preview trong prototype: nhập merchant + amount → thấy ngay số tiền hoàn dự kiến trước khi bấm Lưu).

## Acceptance Criteria

- [ ] Chọn thẻ từ danh sách `user_cards` hiện có (không cho log giao dịch nếu chưa có thẻ nào — điều hướng sang Add Card S07 trước)
- [ ] Nhập merchant → hệ thống tự động gợi ý MCC/category (dựa trên `T-AI-001` + inference), hiển thị tag MCC ngay trong form (giống `txn-mcc-tag` trong prototype)
- [ ] Nhập amount → cashback ước tính cập nhật realtime (client tính sơ bộ để hiển thị nhanh, hoặc gọi API preview — quyết định kỹ thuật cụ thể ở subtask BE)
- [ ] Bấm Lưu → gọi API tạo giao dịch thật, tính cashback chính thức, thành công → điều hướng về Dashboard (S06), Cashback Jar cập nhật ngay
- [ ] Amount ≤ 0 hoặc để trống → không cho lưu
- [ ] Chọn thẻ không thuộc về mình (trường hợp lỗi client) → BE chặn ở tầng API, không chỉ dựa vào validate client

## Dependencies

- **Depends On (Task):** [T-S07.2](../../epic-04-card-management/T-S07-add-edit-card-screen/T-S07.2-be-create-update-user-cards.md), [T-AI-001](../../epic-06-mcc-management/T-AI-001-merchant-lookup-normalize/README.md)
- **Depends On (Phase Gate):** —

## Ref Docs

- [SRS — 3.7 FR-TXN (FR-TXN-01, 02, 03)](../../../../../SRS.md)
- [PRD — 2.3 Transaction Logging](../../../../../PRD.md#23-transaction-logging)

## Subtasks

| ID | Module | Subtask | Status | File |
|----|--------|---------|--------|------|
| T-S09.1 | `BE` | POST /api/transactions | Backlog | [T-S09.1-be-post-transactions.md](./T-S09.1-be-post-transactions.md) |
| T-S09.2 | `AI` | MCC auto-inference khi tạo giao dịch | Backlog | [T-S09.2-ai-mcc-auto-inference.md](./T-S09.2-ai-mcc-auto-inference.md) |
| T-S09.3 | `BE` | Cashback calculation | Backlog | [T-S09.3-be-cashback-calculation.md](./T-S09.3-be-cashback-calculation.md) |
| T-S09.4 | `MOBILE` | Add Transaction screen UI/logic (realtime preview) | Backlog | [T-S09.4-mobile-add-transaction-screen.md](./T-S09.4-mobile-add-transaction-screen.md) |
| T-S09.5 | `QA` | Test case: amount invalid, cashback edge case, MCC sai | Backlog | [T-S09.5-qa-add-transaction-tests.md](./T-S09.5-qa-add-transaction-tests.md) |

## Audit Trail

| Status | Created By | Created Date | Updated By | Updated Date | Reviewed/Approved By | Review Date | Ghi chú |
|--------|-----------|---------------|-----------|---------------|------------------------|--------------|---------|
| Backlog | TBD | 2026-07-25 | — | — | — | — | Chờ T-S07.2, T-AI-001 |

---
Index toàn backlog: [`../../../../tasks.md`](../../../../tasks.md)
