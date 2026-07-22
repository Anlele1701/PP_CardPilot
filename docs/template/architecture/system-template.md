# Template: architecture/system.md (System Architecture Document)

> File này quy định cấu trúc cho `docs/architecture/system.md`.
> Mục tiêu: bird-eye view toàn hệ thống (client ↔ backend ↔ storage ↔ external) — không đi sâu vào 1 layer cụ thể (đó là việc của `BACKEND_ARCHITECTURE.md`/`MOBILE_ARCHITECTURE.md`).

---

## Cấu trúc bắt buộc

```markdown
# System Architecture Document
# {Tên dự án} - {Mô tả 1 dòng}

**Version:** {X.X}
**Date:** {YYYY-MM-DD}

---

## 1. High-Level Architecture
<!-- 1 diagram duy nhất (ASCII hoặc Mermaid) thể hiện toàn bộ hệ thống: Client → Backend → Storage → External -->
<!-- Chỉ vẽ những gì THỰC SỰ tồn tại trong repo hôm nay + rõ ràng đánh dấu phần "Planned" -->

## 2. Service/Module Architecture
<!-- Nếu là modular monolith (bounded contexts), liệt kê theo context thay vì "service" -->
<!-- Mỗi context: Responsibility table -->

### 2.1 {Context Name}
| Responsibility | Description |
|---------------|-------------|
| ... | ... |

## 3. Communication Patterns
<!-- Client ↔ Backend, Backend ↔ Storage, Backend ↔ External -->
<!-- Nếu chưa có async/event (Kafka, queue), ghi rõ "Chưa có — mọi giao tiếp hiện tại là REST đồng bộ" thay vì bịa ra -->

## 4. External Integrations
<!-- Bảng: External System | Purpose | Trạng thái (Integrated / Planned) -->

| System | Purpose | Trạng thái |
|--------|---------|-----------|
| ... | ... | Integrated / Planned |

## 5. Data Flow Diagrams
<!-- 1-2 flow quan trọng nhất của sản phẩm, dạng ASCII step-by-step -->

## 6. Security Architecture
<!-- Auth flow, API security layers, rate limiting -->
<!-- QUAN TRỌNG: nếu auth CHƯA implement, ghi rõ "Chưa implement — xem SRS FR-AUTH cho requirement dự kiến" thay vì mô tả như đã có -->

### 6.1 Authentication Flow
### 6.2 API Security Layers
### 6.3 Rate Limiting Strategy

## 7. Scalability Strategy
<!-- Chỉ viết cho quy mô THỰC TẾ đang nhắm tới — không copy chiến lược Kubernetes/sharding nếu dự án đang ở giai đoạn Docker Compose 1 instance -->

## 8. Monitoring & Observability

### Tools (by Phase)
| Tool | Phase | Purpose |
|------|-------|---------|
| ... | ... | ... |

### Logging Standards
| Aspect | Standard |
|--------|----------|
| ... | ... |
```

---

## Quy tắc viết

1. **Chỉ mô tả những gì tồn tại + roadmap đã thống nhất** — không thêm thành phần kiến trúc "cho tương lai xa" không nằm trong bất kỳ phase nào của `docs/processes/deployment-phases.md`.
2. Mọi mục an ninh/scaling **phải đối chiếu với code thật** trước khi viết là "đã có" — nếu chưa có (VD: chưa có guard/RBAC), ghi rõ trạng thái "Chưa implement" kèm tham chiếu SRS requirement tương ứng.
3. Không lặp lại nội dung chi tiết đã có ở `BACKEND_ARCHITECTURE.md` / `MOBILE_ARCHITECTURE.md` — chỉ link tới, tài liệu này là tầng trên (cross-cutting), không phải nơi giải thích lại toàn bộ folder structure của từng app.
4. Diagram ở mục 1 phải là **logical view** — không lẫn chi tiết deployment infra (đó là việc của `PROC-CICD`).
