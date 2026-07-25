# T-S05 — Forgot Password Screen

**Module (chủ đạo):** `MOBILE` — xem subtask cho breakdown (BE/MOBILE)
**Phase:** 1
**Epic:** Epic 2 — Authentication & Authorization
**Status:** Backlog
**Prototype:** [prototype.html#view-s05](../../../../../prototypes/prototype.html#view-s05) — mở file, tự nhảy tới S05 (gửi OTP khôi phục)

## Mô tả

Nhập email → gửi link/OTP reset password qua email.

## Acceptance Criteria

- [ ] Nhập email đã đăng ký → gọi `POST /api/auth/forgot-password`, hiển thị thông báo "Đã gửi email, kiểm tra hộp thư" — KHÔNG tiết lộ email có tồn tại hay không (cùng thông báo dù email không tồn tại, chống enumeration)
- [ ] Email sai định dạng → validate client-side trước khi gọi API
- [ ] Không giới hạn resend hợp lý (VD: chặn spam gửi lại liên tục trong vài chục giây) — cụ thể: TBD, cần xác nhận rate limit
- [ ] Có link/nút quay lại Login (S03)

## Dependencies

- **Depends On (Task):** [T-MOBILE-001](../T-MOBILE-001-core-network-api-client/README.md)
- **Depends On (Phase Gate):** —

## Ref Docs

- [SRS — 3.1 FR-AUTH (FR-AUTH-04)](../../../../../SRS.md)
- [PRD — 2.1 User Management](../../../../../PRD.md#21-user-management)

## Subtasks

| ID | Module | Subtask | Status | File |
|----|--------|---------|--------|------|
| T-S05.1 | `BE` | Forgot Password API — POST /api/auth/forgot-password | Backlog | [T-S05.1-be-forgot-password-api.md](./T-S05.1-be-forgot-password-api.md) |
| T-S05.2 | `MOBILE` | Forgot Password screen UI/logic | Backlog | [T-S05.2-mobile-forgot-password-screen.md](./T-S05.2-mobile-forgot-password-screen.md) |

## Audit Trail

| Status | Created By | Created Date | Updated By | Updated Date | Reviewed/Approved By | Review Date | Ghi chú |
|--------|-----------|---------------|-----------|---------------|------------------------|--------------|---------|
| Backlog | TBD | 2026-07-25 | — | — | — | — | Chờ T-MOBILE-001 |

---
Index toàn backlog: [`../../../../tasks.md`](../../../../tasks.md)
