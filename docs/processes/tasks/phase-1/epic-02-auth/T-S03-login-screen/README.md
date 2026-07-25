# T-S03 — Login Screen

**Module (chủ đạo):** `MOBILE` — xem subtask cho breakdown (BE/MOBILE/QA)
**Phase:** 1
**Epic:** Epic 2 — Authentication & Authorization
**Status:** Backlog
**Prototype:** [prototype.html#view-s03](../../../../../prototypes/prototype.html#view-s03) — mở file, tự nhảy tới S03 (Login + nút "Dùng thử local")

## Mô tả

Đăng nhập bằng email/password, hoặc bấm "Dùng thử" (Skip) để vào local-only mode (xem T-MOBILE-008), hoặc bấm "Quên mật khẩu" sang S05.

## Acceptance Criteria

- [ ] Nhập đúng email/password đã đăng ký → gọi `POST /api/auth/login`, nhận access/refresh token, lưu vào secure storage, điều hướng sang Dashboard (S06)
- [ ] Nhập sai password hoặc email không tồn tại → hiển thị inline error dưới field password ("Email hoặc mật khẩu không đúng"), KHÔNG điều hướng, KHÔNG tiết lộ email có tồn tại hay không (tránh user enumeration)
- [ ] Trường email/password để trống → nút "Đăng nhập" bị disable, không cho gọi API
- [ ] Bấm "Dùng thử" (Skip) → vào thẳng Dashboard (S06) ở local-only mode (badge "LOCAL GUEST" theo đúng `enterGuestMode()` trong prototype), KHÔNG gọi API
- [ ] Bấm "Quên mật khẩu" → điều hướng sang S05
- [ ] Bấm "Đăng ký" (nếu có link) → điều hướng sang S04
- [ ] Loading state hiển thị khi đang gọi API (không cho bấm đúp nút Login trong lúc chờ response)

## Dependencies

- **Depends On (Task):** [T-MOBILE-001](../T-MOBILE-001-core-network-api-client/README.md)
- **Depends On (Phase Gate):** —

## Ref Docs

- [SRS — 3.1 FR-AUTH (FR-AUTH-02)](../../../../../SRS.md)
- [PRD — 2.1 User Management](../../../../../PRD.md#21-user-management)

## Subtasks

| ID | Module | Subtask | Status | File |
|----|--------|---------|--------|------|
| T-S03.1 | `BE` | Login API — POST /api/auth/login | Backlog | [T-S03.1-be-login-api.md](./T-S03.1-be-login-api.md) |
| T-S03.2 | `MOBILE` | Login screen UI/logic | Backlog | [T-S03.2-mobile-login-screen.md](./T-S03.2-mobile-login-screen.md) |
| T-S03.3 | `QA` | Test case: sai password, email không tồn tại, skip login | Backlog | [T-S03.3-qa-login-tests.md](./T-S03.3-qa-login-tests.md) |

## Audit Trail

| Status | Created By | Created Date | Updated By | Updated Date | Reviewed/Approved By | Review Date | Ghi chú |
|--------|-----------|---------------|-----------|---------------|------------------------|--------------|---------|
| Backlog | TBD | 2026-07-25 | — | — | — | — | Chờ T-MOBILE-001 |

---
Index toàn backlog: [`../../../../tasks.md`](../../../../tasks.md)
