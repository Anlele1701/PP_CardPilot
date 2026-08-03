# T-BE-004 — Quyết định auth provider

**Module (chủ đạo):** `BE`
**Phase:** 1
**Epic:** Epic 2 — Authentication & Authorization
**Status:** In Progress
**Prototype:** — (task quyết định kiến trúc, không phải màn hình)

## Mô tả

Chốt 1 trong 2 hướng: (a) JWT tự xây trong NestJS (`@nestjs/jwt`, cần thêm cột `password_hash` vào `users` + bảng `refresh_tokens`), hoặc (b) Supabase Auth (không cần tự quản lý password hash/refresh token, nhưng ràng buộc vào Supabase). Đây là **task foundational** — mọi task trong Epic 2/3/4/5/6 và mọi màn hình cần login đều phụ thuộc gián tiếp vào quyết định này (qua T-BE-009 Auth Guard).

**Decision implemented on mobile:** use Supabase Auth. Flutter now supports
email/password, Google/Facebook OAuth, persisted sessions, and sign-out through
`supabase_flutter`. The task remains In Progress until the team specifies and
implements backend token verification plus `auth.users.id` ↔ `public.users.id`
bootstrap/mapping.

## Acceptance Criteria

- [x] Có văn bản quyết định trong `ARCH-SYS` #7.1: mobile uses Supabase Auth
- [ ] Nếu chọn JWT tự xây: xác nhận cần thêm migration cột `password_hash` vào `users` + bảng `refresh_tokens` (xem T-BE-010)
- [ ] Nếu chọn Supabase Auth: xác nhận flow map `auth.users` (Supabase) ↔ bảng `users` hiện có trong schema như thế nào (id sync ra sao)
- [ ] Quyết định được thông báo cho toàn bộ team trước khi bất kỳ ai bắt đầu T-BE-005/006/007/008/009/010

## Dependencies

- **Depends On (Task):** —
- **Depends On (Phase Gate):** —

## Ref Docs

- [ARCH-SYS — 7. Security Architecture](../../../../../architecture/system.md)
- [SRS — 3.1 FR-AUTH](../../../../../SRS.md)

## Subtasks

— (task quyết định, không tách subtask theo module)

## Audit Trail

| Status | Created By | Created Date | Updated By | Updated Date | Reviewed/Approved By | Review Date | Ghi chú |
|--------|-----------|---------------|-----------|---------------|------------------------|--------------|---------|
| Ready | TBD | 2026-07-25 | — | — | — | — | Quyết định chặn toàn bộ Epic 2/3/4/5/6 và mọi màn hình cần login — ưu tiên cao nhất |
| In Progress | CardPilot Team | 2026-07-25 | CardPilot Team | 2026-08-02 | — | — | Supabase chosen/mobile integrated; backend identity mapping pending |

---
Index toàn backlog: [`../../../../tasks.md`](../../../../tasks.md)
