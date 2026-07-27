# T-BE-022 — Admin CRUD MCC

**Module (chủ đạo):** `BE`
**Phase:** 1
**Epic:** Epic 6 — MCC Management
**Status:** Backlog
**Prototype:** — (Admin API, chưa có Admin UI)

## Mô tả

`POST /api/admin/mcc` — thêm/sửa mã MCC chuẩn (dùng khi cần bổ sung MCC ngoài bộ seed ban đầu).

## Acceptance Criteria

- [ ] Thêm MCC mới với `code` chưa tồn tại → tạo thành công
- [ ] Thêm MCC với `code` đã tồn tại → `409`, không tạo trùng
- [ ] User thường gọi endpoint này → `403`

## Dependencies

- **Depends On (Task):** [T-BE-009](../../epic-02-auth/T-BE-009-auth-guard-rbac/README.md), [T-DATA-004](../T-DATA-004-seed-mcc/README.md)
- **Depends On (Phase Gate):** —

## Ref Docs

- [SRS — 3.5 FR-MCC (FR-MCC-01)](../../../../../SRS.md)

## Subtasks

— (task atomic trong 1 module `BE`, không tách subtask)

## Audit Trail

| Status | Created By | Created Date | Updated By | Updated Date | Reviewed/Approved By | Review Date | Ghi chú |
|--------|-----------|---------------|-----------|---------------|------------------------|--------------|---------|
| Backlog | TBD | 2026-07-25 | — | — | — | — | Chờ T-BE-009, T-DATA-004 |

---
Index toàn backlog: [`../../../../tasks.md`](../../../../tasks.md)
