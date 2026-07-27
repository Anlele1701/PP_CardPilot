# T-BE-021 — User xem rule của thẻ

**Module (chủ đạo):** `BE`
**Phase:** 1
**Epic:** Epic 5 — Card Rule Management
**Status:** Backlog
**Prototype:** — **Gap ghi nhận**: không có màn hình nào trong `deployment-phase-1.md` mục 2 (S01-S13) hiển thị rõ "danh sách rule hoàn tiền của thẻ" như 1 view riêng. Dữ liệu này nhiều khả năng nên hiển thị trong S07/S08 (chi tiết thẻ) nhưng chưa được đặc tả rõ — cần Product/Design xác nhận trước khi gán vào 1 subtask màn hình cụ thể. Giữ tạm là task độc lập.

## Mô tả

`GET /api/credit-cards/:id/rules` — trả rule đang active (`is_active=true`, trong hạn `effective_from`/`effective_to`) của 1 sản phẩm thẻ, để user biết đang được hoàn tiền bao nhiêu % cho category nào.

## Acceptance Criteria

- [ ] Chỉ trả rule `is_active=true` và ngày hiện tại nằm trong khoảng `effective_from`/`effective_to`
- [ ] Rule hết hạn hoặc chưa active → không xuất hiện trong response
- [ ] Mỗi rule trả kèm danh sách MCC áp dụng (join `reward_rule_mccs`)

## Dependencies

- **Depends On (Task):** [T-BE-019.1](../T-BE-019-admin-crud-reward-rules/T-BE-019.1-post-create-rule.md)
- **Depends On (Phase Gate):** —

## Ref Docs

- [SRS — 3.6 FR-RULE (FR-RULE-05)](../../../../../SRS.md)

## Subtasks

— (task atomic trong 1 module `BE`, không tách subtask)

## Audit Trail

| Status | Created By | Created Date | Updated By | Updated Date | Reviewed/Approved By | Review Date | Ghi chú |
|--------|-----------|---------------|-----------|---------------|------------------------|--------------|---------|
| Backlog | TBD | 2026-07-25 | — | — | — | — | Chờ T-BE-019.1; chưa rõ màn hình tiêu thụ — xem Gap ở trên |

---
Index toàn backlog: [`../../../../tasks.md`](../../../../tasks.md)
