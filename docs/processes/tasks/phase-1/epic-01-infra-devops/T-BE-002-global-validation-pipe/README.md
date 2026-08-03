# T-BE-002 — Global validation pipe

**Module (chủ đạo):** `BE`
**Phase:** 1
**Epic:** Epic 1 — Infrastructure & DevOps Hardening
**Status:** Ready
**Prototype:** — (không phải task màn hình)

## Mô tả

Bật `ValidationPipe` toàn cục (`app.useGlobalPipes(new ValidationPipe({ whitelist: true, forbidNonWhitelisted: true, transform: true }))`) trong `main.ts`, dùng `class-validator`/`class-transformer` cho mọi DTO input của mọi endpoint.

## Acceptance Criteria

- [ ] Gửi request thiếu field bắt buộc trong DTO → trả `400 Bad Request` với message liệt kê rõ field nào thiếu, KHÔNG crash server
- [ ] Gửi field thừa không khai báo trong DTO → bị strip (whitelist) hoặc trả `400` (tuỳ cấu hình `forbidNonWhitelisted`), không lọt xuống tầng service
- [ ] Gửi đúng type nhưng sai định dạng (VD: email không hợp lệ, số âm cho field phải dương) → trả `400` với message theo đúng decorator validation (VD: `@IsEmail()`, `@Min(0)`)
- [ ] Áp dụng nhất quán cho route hiện có và mọi route mới — verify bằng một DTO test trên endpoint có input mà không cần khai báo pipe lại per-route

## Dependencies

- **Depends On (Task):** —
- **Depends On (Phase Gate):** —

## Ref Docs

- [ARCH-API — 1.2 Response Format](../../../../../architecture/api.md#12-response-format)

## Subtasks

— (task này atomic trong 1 module `BE`, không tách subtask)

## Audit Trail

| Status | Created By | Created Date | Updated By | Updated Date | Reviewed/Approved By | Review Date | Ghi chú |
|--------|-----------|---------------|-----------|---------------|------------------------|--------------|---------|
| Ready | TBD | 2026-07-25 | — | — | — | — | Không có blocker |

---
Index toàn backlog: [`../../../../tasks.md`](../../../../tasks.md)
