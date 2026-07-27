# T-BE-020 — Admin gán MCC cho rule

**Module (chủ đạo):** `BE`
**Phase:** 1
**Epic:** Epic 5 — Card Rule Management
**Status:** Backlog
**Prototype:** — (Admin API, chưa có Admin UI)

## Mô tả

`POST /api/admin/reward-rules/:id/mccs` — gán 1 hoặc nhiều MCC cho 1 reward rule, validate `match_type` (VD: `exact`/`category_group`).

## Acceptance Criteria

- [ ] Gán MCC hợp lệ (tồn tại trong `merchant_category_codes`) → tạo `reward_rule_mccs` record
- [ ] Gán MCC không tồn tại → `400`
- [ ] Gán trùng (cùng rule + cùng MCC + cùng match_type) → chặn theo constraint `uq_reward_rule_mccs_rule_mcc_match` đã có sẵn trong schema, trả lỗi rõ ràng thay vì lỗi DB thô

## Dependencies

- **Depends On (Task):** [T-BE-019.1](../T-BE-019-admin-crud-reward-rules/T-BE-019.1-post-create-rule.md)
- **Depends On (Phase Gate):** —

## Ref Docs

- [SRS — 3.6 FR-RULE (FR-RULE-02)](../../../../../SRS.md)
- [ARCH-DB — 2.2 Table Definitions](../../../../../architecture/database.md#22-table-definitions)

## Subtasks

— (task atomic trong 1 module `BE`, không tách subtask)

## Audit Trail

| Status | Created By | Created Date | Updated By | Updated Date | Reviewed/Approved By | Review Date | Ghi chú |
|--------|-----------|---------------|-----------|---------------|------------------------|--------------|---------|
| Backlog | TBD | 2026-07-25 | — | — | — | — | Chờ T-BE-019.1 |

---
Index toàn backlog: [`../../../../tasks.md`](../../../../tasks.md)
