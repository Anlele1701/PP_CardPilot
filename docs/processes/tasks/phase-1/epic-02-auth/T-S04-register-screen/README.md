# T-S04 — Register Screen

**Module (chủ đạo):** `MOBILE` — xem subtask cho breakdown (BE/MOBILE/QA)
**Phase:** 1
**Epic:** Epic 2 — Authentication & Authorization
**Status:** In Progress
**Prototype:** [prototype.html#view-s04](../../../../../prototypes/prototype.html#view-s04) — mở file, tự nhảy tới S04 (Register — Bronze Member)

## Mô tả

Form tạo tài khoản mới bằng email/password. Khi tạo thành công, user tự động được gán membership tier Bronze (cross-epic với Epic 3 — Membership).

> **Current implementation:** `SignUpScreen` supports full name,
> email/password/confirmation, terms acceptance, shared validation, Supabase
> email sign-up, Google/Facebook OAuth, loading state, Toastification feedback,
> and navigation back to Sign in. Backend `users` bootstrap and Bronze
> membership assignment are not implemented.

## Acceptance Criteria

- [x] Mobile gửi email/password hợp lệ tới Supabase Auth; sau khi có session thì điều hướng qua shared initial setup hoặc Home theo trạng thái nghiệp vụ.
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
| T-S04.1 | `BE` | Bootstrap backend user from Supabase identity | Backlog | [T-S04.1-be-register-api.md](./T-S04.1-be-register-api.md) |
| T-S04.2 | `BE` | Gán membership Bronze mặc định khi tạo user | Backlog | [T-S04.2-be-gan-bronze-mac-dinh.md](./T-S04.2-be-gan-bronze-mac-dinh.md) |
| T-S04.3 | `MOBILE` | Register screen UI/logic | In Progress | [T-S04.3-mobile-register-screen.md](./T-S04.3-mobile-register-screen.md) |
| T-S04.4 | `QA` | Test case: email trùng, password yếu, thành công | Backlog | [T-S04.4-qa-register-tests.md](./T-S04.4-qa-register-tests.md) |

## Audit Trail

| Status | Created By | Created Date | Updated By | Updated Date | Reviewed/Approved By | Review Date | Ghi chú |
|--------|-----------|---------------|-----------|---------------|------------------------|--------------|---------|
| Backlog | TBD | 2026-07-25 | — | — | — | — | Chờ T-MOBILE-001 |
| In Progress | CardPilot Team | 2026-07-25 | CardPilot Team | 2026-08-02 | — | — | Mobile Supabase sign-up implemented; backend membership/bootstrap pending |

---
Index toàn backlog: [`../../../../tasks.md`](../../../../tasks.md)
