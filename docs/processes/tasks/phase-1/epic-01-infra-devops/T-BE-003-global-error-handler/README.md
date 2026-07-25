# T-BE-003 — Global error handler

**Module (chủ đạo):** `BE`
**Phase:** 1
**Epic:** Epic 1 — Infrastructure & DevOps Hardening
**Status:** Backlog
**Prototype:** — (không phải task màn hình)

## Mô tả

Thêm 1 `ExceptionFilter` toàn cục, chuẩn hoá MỌI response lỗi (validation error từ T-BE-002, lỗi nghiệp vụ throw chủ động, lỗi không lường trước) về cùng 1 shape JSON theo `ARCH-API` #1.2, gồm tối thiểu: `statusCode`, `message`, `error` (tên loại lỗi), `path`, `timestamp`.

## Acceptance Criteria

- [ ] Lỗi validation (từ T-BE-002) đi qua filter này và trả đúng shape chuẩn, không còn shape mặc định của Nest
- [ ] Lỗi nghiệp vụ chủ động throw (VD: `NotFoundException`, `ForbiddenException`) giữ đúng status code tương ứng nhưng vẫn theo shape chuẩn
- [ ] Lỗi không lường trước (unhandled exception, VD: null reference) → trả `500` với message chung chung an toàn (KHÔNG leak stack trace/nội dung lỗi thật ra response ở production), nhưng log đầy đủ chi tiết lỗi thật ở server (dùng logger từ T-BE-001)
- [ ] `path` trong response khớp đúng URL request đã gọi

## Dependencies

- **Depends On (Task):** [T-BE-002](../T-BE-002-global-validation-pipe/README.md)
- **Depends On (Phase Gate):** —

## Ref Docs

- [ARCH-API — 1.2 Response Format](../../../../../architecture/api.md#12-response-format)

## Subtasks

— (task này atomic trong 1 module `BE`, không tách subtask)

## Audit Trail

| Status | Created By | Created Date | Updated By | Updated Date | Reviewed/Approved By | Review Date | Ghi chú |
|--------|-----------|---------------|-----------|---------------|------------------------|--------------|---------|
| Backlog | TBD | 2026-07-25 | — | — | — | — | Chờ T-BE-002 |

---
Index toàn backlog: [`../../../../tasks.md`](../../../../tasks.md)
