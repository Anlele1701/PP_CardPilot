# T-BE-001 — Structured logging

**Module (chủ đạo):** `BE`
**Phase:** 1
**Epic:** Epic 1 — Infrastructure & DevOps Hardening
**Status:** Ready
**Prototype:** — (không phải task màn hình)

## Mô tả

Thay Nest `Logger` mặc định bằng structured JSON logger (`nestjs-pino` hoặc `winston` — cần chọn 1 trước khi implement). Mỗi log entry phải có `request_id` xuyên suốt 1 request (đính kèm qua middleware/interceptor), `timestamp` ISO 8601, `level`, và `context` (tên module/service phát sinh log).

## Acceptance Criteria

- [ ] Mọi log output là JSON hợp lệ (parse được bằng `JSON.parse`), không còn dạng text tự do của Nest Logger mặc định
- [ ] 2 log entry cùng 1 HTTP request (VD: log lúc bắt đầu xử lý + log lúc trả response) có cùng giá trị `request_id`
- [ ] 2 request khác nhau (gọi song song) có `request_id` khác nhau — verify bằng cách gọi 2 request đồng thời và kiểm tra log
- [ ] Log level (`error`/`warn`/`info`/`debug`) cấu hình được qua biến môi trường, mặc định `info` ở production
- [ ] Không log thông tin nhạy cảm — kiểm tra request có `Authorization: Bearer <token>` và xác nhận token bị redact; nếu tương lai có endpoint nhận secret/password thì field đó cũng phải bị redact

## Dependencies

- **Depends On (Task):** —
- **Depends On (Phase Gate):** —

## Ref Docs

- [ARCH-SYS — Monitoring & Observability](../../../../../architecture/system.md)
- [SRS — NFR-SEC-06](../../../../../SRS.md)

## Subtasks

— (task này atomic trong 1 module `BE`, không tách subtask)

## Audit Trail

| Status | Created By | Created Date | Updated By | Updated Date | Reviewed/Approved By | Review Date | Ghi chú |
|--------|-----------|---------------|-----------|---------------|------------------------|--------------|---------|
| Ready | TBD | 2026-07-25 | — | — | — | — | Chọn `nestjs-pino` hay `winston` cần quyết định trước khi bắt đầu |

---
Index toàn backlog: [`../../../../tasks.md`](../../../../tasks.md)
