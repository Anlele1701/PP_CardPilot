# T-S13 — Edit Profile Screen

**Module (chủ đạo):** `MOBILE` — xem subtask cho breakdown (BE/MOBILE)
**Phase:** 1
**Epic:** Epic 3 — Membership & Profile
**Status:** Backlog
**Prototype:** [prototype.html#view-s13](../../../../../prototypes/prototype.html#view-s13) — mở file, tự nhảy tới S13

## Mô tả

Cho phép sửa `full_name`, `born_date`.

> **Gap ghi nhận**: `PATCH /api/users/me` đã có trong bảng endpoint của `ARCH-API`/`deployment-phase-1.md` mục 4 ("Sửa full_name/born_date") nhưng **chưa từng xuất hiện như 1 task riêng** trong Task Breakdown gốc — chỉ có `GET` được liệt kê (task cũ T-014/T-BE-012). Task này bổ sung phần bị thiếu đó.

## Acceptance Criteria

- [ ] Form pre-fill đúng `full_name`/`born_date` hiện tại (lấy từ `GET /api/users/me`, dùng lại data đã có ở S12, không cần gọi lại nếu đã cache)
- [ ] Sửa xong bấm Lưu → gọi `PATCH /api/users/me`, thành công → điều hướng quay lại Profile (S12) với dữ liệu mới
- [ ] `full_name` để trống → không cho lưu, hiển thị lỗi validate
- [ ] `born_date` chọn ngày trong tương lai → không cho lưu (validate hợp lý)
- [ ] Lưu thất bại (lỗi mạng) → hiển thị lỗi, không mất dữ liệu đã nhập trong form

## Dependencies

- **Depends On (Task):** [T-S12.1](../T-S12-profile-screen/T-S12.1-be-get-memberships-me.md)
- **Depends On (Phase Gate):** —

## Ref Docs

- [SRS — 3.2 FR-MEMBER](../../../../../SRS.md)
- [PRD — 2.1 User Management](../../../../../PRD.md#21-user-management)

## Subtasks

| ID | Module | Subtask | Status | File |
|----|--------|---------|--------|------|
| T-S13.1 | `BE` | PATCH /api/users/me (bổ sung — xem ghi chú Gap) | Backlog | [T-S13.1-be-patch-users-me.md](./T-S13.1-be-patch-users-me.md) |
| T-S13.2 | `MOBILE` | Edit Profile screen UI/logic | Backlog | [T-S13.2-mobile-edit-profile-screen.md](./T-S13.2-mobile-edit-profile-screen.md) |

## Audit Trail

| Status | Created By | Created Date | Updated By | Updated Date | Reviewed/Approved By | Review Date | Ghi chú |
|--------|-----------|---------------|-----------|---------------|------------------------|--------------|---------|
| Backlog | TBD | 2026-07-25 | — | — | — | — | Chờ T-S12.1 |

---
Index toàn backlog: [`../../../../tasks.md`](../../../../tasks.md)
