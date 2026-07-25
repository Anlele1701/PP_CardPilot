# T-BE-010 — Refresh token storage

**Module (chủ đạo):** `BE`
**Phase:** 1
**Epic:** Epic 2 — Authentication & Authorization
**Status:** Backlog
**Prototype:** — (task backend/DB, không phải màn hình)

## Mô tả

Nếu T-BE-004 chọn JWT tự xây: migration tạo bảng `refresh_tokens` (`id` PK uuid, `user_id` FK → `users` CASCADE, `token_hash`, `expires_at`, `created_at`) để phục vụ revoke khi logout và refresh access token khi hết hạn.

## Acceptance Criteria

- [ ] Migration tạo bảng thành công, có FK `user_id → users(id) ON DELETE CASCADE`
- [ ] `token_hash` lưu bản băm (không lưu refresh token dạng plaintext trong DB)
- [ ] Xoá user → toàn bộ `refresh_tokens` liên quan tự động bị xoá (CASCADE), verify bằng test xoá user và query lại bảng
- [ ] Nếu T-BE-004 chọn Supabase Auth thay vì JWT tự xây → task này **không cần thực hiện**, đóng lại với ghi chú lý do

## Dependencies

- **Depends On (Task):** [T-BE-004](../T-BE-004-quyet-dinh-auth-provider/README.md) (điều kiện: chỉ áp dụng nếu chọn JWT tự xây)
- **Depends On (Phase Gate):** —

## Ref Docs

- [ARCH-DB — 2.2 Table Definitions](../../../../../architecture/database.md#22-table-definitions)

## Subtasks

— (task atomic trong 1 module `BE`, không tách subtask)

## Audit Trail

| Status | Created By | Created Date | Updated By | Updated Date | Reviewed/Approved By | Review Date | Ghi chú |
|--------|-----------|---------------|-----------|---------------|------------------------|--------------|---------|
| Backlog | TBD | 2026-07-25 | — | — | — | — | Chờ quyết định T-BE-004 (chỉ cần nếu JWT tự xây) |

---
Index toàn backlog: [`../../../../tasks.md`](../../../../tasks.md)
