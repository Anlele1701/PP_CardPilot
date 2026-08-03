# T-BE-009 — Auth Guard + RBAC

**Module (chủ đạo):** `BE`
**Phase:** 1
**Epic:** Epic 2 — Authentication & Authorization
**Status:** Backlog
**Prototype:** — (task nền tảng, không phải màn hình)

## Mô tả

Middleware/Guard xác thực Bearer token (`AuthGuard`) áp dụng cho mọi route cần login, cộng thêm `RolesGuard` (decorator `@Roles('user' | 'admin')`) để phân biệt quyền User/Admin. **Đây là task foundational quan trọng nhất Epic 2** — gần như mọi task khác trong toàn bộ backlog Phase 1 (Card Management, Card Rule Management, MCC Management, Transaction Logging, Dashboard, và mọi màn hình sau khi đăng nhập) đều `Depends On` task này thay vì tự làm lại guard riêng.

## Acceptance Criteria

- [ ] Request không có header `Authorization: Bearer <token>` tới route được đánh dấu cần auth → trả `401 Unauthorized`
- [ ] Token hết hạn hoặc invalid signature → trả `401 Unauthorized`, message phân biệt được với case thiếu token (phục vụ mobile tự động refresh token)
- [ ] Route đánh dấu `@Roles('admin')` mà user thường (role `user`) gọi vào → trả `403 Forbidden`
- [ ] Route public (VD: `GET /api/health`, `GET /api/v1/banks`) vẫn hoạt động bình thường không bị guard chặn
- [ ] `request.user` được populate đúng thông tin user (tối thiểu `id`, `role`) để các controller phía sau dùng được ngay, không cần decode token lại

## Dependencies

- **Depends On (Task):** [T-BE-004](../T-BE-004-quyet-dinh-auth-provider/README.md) (cần chốt Supabase claim và identity mapping để test end-to-end)
- **Depends On (Phase Gate):** —

## Ref Docs

- [SRS — 3.1 FR-AUTH (FR-AUTH-09, NFR-SEC-04/05)](../../../../../SRS.md)

## Subtasks

— (task atomic trong 1 module `BE`, không tách subtask)

## Audit Trail

| Status | Created By | Created Date | Updated By | Updated Date | Reviewed/Approved By | Review Date | Ghi chú |
|--------|-----------|---------------|-----------|---------------|------------------------|--------------|---------|
| Backlog | TBD | 2026-07-25 | — | — | — | — | Chờ chốt Supabase claim/identity mapping — critical path cho API nghiệp vụ được bảo vệ |

---
Index toàn backlog: [`../../../../tasks.md`](../../../../tasks.md)
