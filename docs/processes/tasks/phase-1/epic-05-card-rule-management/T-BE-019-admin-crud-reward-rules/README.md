# T-BE-019 — Admin CRUD reward_rules

**Module (chủ đạo):** `BE` — xem subtask
**Phase:** 1
**Epic:** Epic 5 — Card Rule Management
**Status:** Backlog
**Prototype:** — (Admin API, dự án chưa có Admin UI/module `FE` — xem `../../../../tasks.md` mục Module Legend)

## Mô tả

`POST`/`PATCH /api/admin/reward-rules` — tạo/sửa rule hoàn tiền cho 1 `credit_card`. Chỉ role Admin gọi được.

## Acceptance Criteria

- [ ] Admin tạo rule mới → `reward_rules` record được tạo với `credit_card_id`, `cashback_percent`, `monthly_cap_amount`, `effective_from`/`effective_to`, `is_active`
- [ ] User thường (không phải Admin) gọi endpoint này → `403` (qua `T-BE-009` RolesGuard)
- [ ] Sửa rule đổi `effective_to` về quá khứ → rule ngừng hiển thị cho user ngay (verify qua T-BE-021)
- [ ] `cashback_percent`/`monthly_cap_amount` âm hoặc > giới hạn hợp lý (VD: > 100% cho percent) → `400`

## Dependencies

- **Depends On (Task):** [T-BE-009](../../epic-02-auth/T-BE-009-auth-guard-rbac/README.md), [T-DATA-003](../T-DATA-003-thu-thap-chinh-sach-hoan-tien/README.md)
- **Depends On (Phase Gate):** —

## Ref Docs

- [SRS — 3.6 FR-RULE (FR-RULE-01, 03, 04)](../../../../../SRS.md)

## Subtasks

| ID | Module | Subtask | Status | File |
|----|--------|---------|--------|------|
| T-BE-019.1 | `BE` | POST /api/admin/reward-rules (create) | Backlog | [T-BE-019.1-post-create-rule.md](./T-BE-019.1-post-create-rule.md) |
| T-BE-019.2 | `BE` | PATCH /api/admin/reward-rules/:id (update) | Backlog | [T-BE-019.2-patch-update-rule.md](./T-BE-019.2-patch-update-rule.md) |

## Audit Trail

| Status | Created By | Created Date | Updated By | Updated Date | Reviewed/Approved By | Review Date | Ghi chú |
|--------|-----------|---------------|-----------|---------------|------------------------|--------------|---------|
| Backlog | TBD | 2026-07-25 | — | — | — | — | Chờ T-BE-009, T-DATA-003 |

---
Index toàn backlog: [`../../../../tasks.md`](../../../../tasks.md)

> **Gap ghi nhận**: `reward_rules` chưa có Admin UI (dự án không có module `FE`) — Admin thao tác qua gọi API trực tiếp (Postman/script) cho tới khi có quyết định xây Admin Portal.
