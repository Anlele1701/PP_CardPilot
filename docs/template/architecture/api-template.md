# Template: architecture/api.md (API Design Document)

> File này quy định cấu trúc cho `docs/architecture/api.md`.
> Mục tiêu: đặc tả request/response format cho mọi REST endpoint. Đây là tài liệu **contract-first** — mọi thay đổi API thật trong code nên được phản ánh lại đây trong cùng PR.

---

## Cấu trúc bắt buộc

```markdown
# API Design Document
# {Tên dự án} - {Mô tả 1 dòng}

**Version:** {X.X}
**Date:** {YYYY-MM-DD}
**Base URL:** `{scheme://host/prefix}`

---

## 1. API Conventions

### 1.1 General Rules
<!-- RESTful, JSON, encoding, date format, ID format, pagination style -->

### 1.2 Response Format
<!-- Success / Error / Paginated shape thật đang dùng trong code (hoặc dự kiến nếu global error handler chưa build) -->

### 1.3 HTTP Status Codes
| Code | Usage |
|------|-------|
| ... | ... |

### 1.4 Authentication
<!-- Ghi rõ nếu CHƯA có auth: "Chưa implement — mọi endpoint hiện tại không yêu cầu auth" -->

### 1.5 Rate Limiting
<!-- "—" nếu chưa có -->

### 1.6 Request Tracing
<!-- "—" nếu chưa có -->

---

## 2. {Bounded Context} APIs
<!-- 1 section cho mỗi bounded context / module, khớp với SRS #3 và PRD #2 -->
<!-- Mỗi endpoint: method + path, mô tả 1 dòng, request/response JSON mẫu -->
<!-- Đánh dấu rõ "(Implemented)" hoặc "(Planned)" ngay sau tiêu đề endpoint -->

### {METHOD} {/path} (Implemented | Planned)
{Mô tả 1 dòng}.

**Request:**
```json
{ }
```

**Response ({status}):**
```json
{ }
```

<!-- Lặp lại ## 2, ## 3, ... cho mỗi bounded context -->

---

## N. WebSocket Events (nếu có)
<!-- "—" nếu chưa có realtime -->
```

---

## Quy tắc viết

1. **Mọi endpoint phải ghi rõ trạng thái** `(Implemented)` hay `(Planned)` — lấy sự thật từ controller thật trong `apps/cardpilot-backend/src/contexts/*/presentation/http`, không suy đoán.
2. Request/Response mẫu phải dùng **field name thật** khớp với DTO/entity trong code (hoặc khớp với migration schema nếu API chưa build) — không đặt tên field khác đi "cho gọn".
3. Section phải nhóm theo **bounded context** (khớp cấu trúc `src/contexts/<context>`), không nhóm tuỳ ý theo UI screen.
4. Khi 1 endpoint thật đã tồn tại trong code, copy chính xác route (bao gồm global prefix, VD `/api/...`), method, và auth requirement — verify lại bằng cách đọc controller, không suy đoán từ tên tính năng.
5. Nếu global error handler / auth / rate limiting chưa tồn tại trong code, mục 1.2/1.4/1.5 phải nói rõ điều đó thay vì mô tả như đã có sẵn.
