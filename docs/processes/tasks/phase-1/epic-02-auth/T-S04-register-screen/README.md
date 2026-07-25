# T-S04 — Register Screen

**Module (chủ đạo):** `MOBILE` — xem subtask cho breakdown (BE/MOBILE/QA)
**Phase:** 1
**Epic:** Epic 2 — Authentication & Authorization
**Status:** Backlog
**Prototype:** [prototype.html#view-s04](../../../../../prototypes/prototype.html#view-s04) — mở file, tự nhảy tới S04 (Register — Bronze Member)

## Mô tả

Form tạo tài khoản mới bằng email/password. Khi tạo thành công, user tự động được gán membership tier Bronze (cross-epic với Epic 3 — Membership).

## Acceptance Criteria

- [ ] Nhập email hợp lệ + password đạt độ mạnh tối thiểu (quy tắc cụ thể: TBD — cần Product/Security xác nhận độ dài/ký tự bắt buộc) + xác nhận password khớp → gọi `POST /api/auth/register` thành công, tự động đăng nhập, điều hướng Dashboard (S06)
- [ ] Email đã tồn tại → hiển thị inline error "Email đã được sử dụng", không tạo user trùng
- [ ] Email sai định dạng → nút Đăng ký disable / hiển thị lỗi ngay khi rời field (client-side validate trước khi gọi API)
- [ ] Đăng ký thành công → user mới có `user_memberships` record Bronze active ngay lập tức (verify qua `GET /api/users/me` trả đúng tier Bronze)
- [ ] Loading state khi đang gọi API, chặn double-submit

## Dependencies

- **Depends On (Task):** [T-MOBILE-001](../T-MOBILE-001-core-network-api-client/README.md)
- **Depends On (Phase Gate):** —

## Ref Docs

- [SRS — 3.1 FR-AUTH (FR-AUTH-01)](../../../../../SRS.md)
- [SRS — 3.2 FR-MEMBER (FR-MEMBER-02)](../../../../../SRS.md)
- [PRD — 2.1 User Management](../../../../../PRD.md#21-user-management)

## Subtasks

| ID | Module | Subtask | Status | File |
|----|--------|---------|--------|------|
| T-S04.1 | `BE` | Register API — POST /api/auth/register | Backlog | [T-S04.1-be-register-api.md](./T-S04.1-be-register-api.md) |
| T-S04.2 | `BE` | Gán membership Bronze mặc định khi tạo user | Backlog | [T-S04.2-be-gan-bronze-mac-dinh.md](./T-S04.2-be-gan-bronze-mac-dinh.md) |
| T-S04.3 | `MOBILE` | Register screen UI/logic | Backlog | [T-S04.3-mobile-register-screen.md](./T-S04.3-mobile-register-screen.md) |
| T-S04.4 | `QA` | Test case: email trùng, password yếu, thành công | Backlog | [T-S04.4-qa-register-tests.md](./T-S04.4-qa-register-tests.md) |

## Audit Trail

| Status | Created By | Created Date | Updated By | Updated Date | Reviewed/Approved By | Review Date | Ghi chú |
|--------|-----------|---------------|-----------|---------------|------------------------|--------------|---------|
| Backlog | TBD | 2026-07-25 | — | — | — | — | Chờ T-MOBILE-001 |

---
Index toàn backlog: [`../../../../tasks.md`](../../../../tasks.md)
