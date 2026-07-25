# T-MOBILE-001 — core/network — API client

**Module (chủ đạo):** `MOBILE`
**Phase:** 1
**Epic:** Epic 2 — Authentication & Authorization
**Status:** Backlog
**Prototype:** — (hạ tầng dùng chung, không phải 1 màn hình cụ thể)

## Mô tả

Thêm HTTP client (`dio`) trong `core/network`, interceptor tự động gắn header `Authorization: Bearer <token>` (đọc từ secure storage), base URL đọc từ `core/config`. **Đây là task foundational** — mọi màn hình cần gọi API (S03-S13, trừ S01/S02 vốn không gọi API) đều `Depends On` task này.

## Acceptance Criteria

- [ ] Mọi request qua client này tự động có header `Authorization` nếu đã có token lưu trong secure storage; không có token thì gửi request không kèm header (không throw lỗi)
- [ ] Response `401` → interceptor tự động thử refresh token 1 lần (nếu có `T-BE-010`/refresh flow), fail thì clear token local và điều hướng về Login (S03)
- [ ] Base URL đổi được qua build config (dev/staging/prod) mà không sửa code
- [ ] Timeout request có cấu hình mặc định hợp lý (không treo vô hạn khi mất mạng) — verify bằng cách tắt mạng và gọi 1 API, xác nhận có error trả về trong thời gian timeout đã cấu hình

## Dependencies

- **Depends On (Task):** [T-BE-009](../T-BE-009-auth-guard-rbac/README.md)
- **Depends On (Phase Gate):** —

## Ref Docs

- [ARCH-MOBILE](../../../../../MOBILE_ARCHITECTURE.md)
- [PRD — 2.1 User Management](../../../../../PRD.md#21-user-management)

## Subtasks

— (task atomic trong 1 module `MOBILE`, không tách subtask)

## Audit Trail

| Status | Created By | Created Date | Updated By | Updated Date | Reviewed/Approved By | Review Date | Ghi chú |
|--------|-----------|---------------|-----------|---------------|------------------------|--------------|---------|
| Backlog | TBD | 2026-07-25 | — | — | — | — | Chờ T-BE-009 — block mọi màn hình gọi API (S03-S13) |

---
Index toàn backlog: [`../../../../tasks.md`](../../../../tasks.md)
