# Template: SRS.md (Software Requirements Specification)

> File này quy định cấu trúc cho `docs/SRS.md`.
> Mục tiêu: liệt kê **requirement có thể test được** (FR/NFR có ID), interface requirements, data requirements. Đây là tài liệu kỹ thuật đầu tiên — cầu nối giữa `PRD` (business/UX) và `ARCH-*` (implementation).

---

## Cấu trúc bắt buộc

```markdown
# Software Requirements Specification (SRS)
# {Tên dự án} - {Mô tả 1 dòng}

**Version:** {X.X}
**Date:** {YYYY-MM-DD}

---

## 1. Introduction

### 1.1 Purpose
### 1.2 Scope
<!-- Liệt kê các thành phần hệ thống: mobile, backend, database, v.v. -->

### 1.3 Definitions & Acronyms

| Term | Definition |
|------|-----------|
| ... | ... |

---

## 2. System Overview

### 2.1 System Context Diagram
<!-- ASCII hoặc Mermaid: actor ↔ hệ thống ↔ external systems -->

---

## 3. Functional Requirements
<!-- Nhóm theo module, khớp 1-1 với PRD #2 Product Modules -->
<!-- Mỗi requirement có ID duy nhất: FR-{MODULE}-{NN} -->
<!-- Priority: P0 (bắt buộc) / P1 / P2 -->
<!-- Phase: số phase dự kiến implement, khớp với docs/processes/deployment-phases.md -->

### 3.1 {Module Name} (FR-{PREFIX})

| ID | Requirement | Priority | Phase |
|----|-------------|----------|-------|
| FR-{PREFIX}-01 | {Mô tả requirement, viết dạng "Hệ thống cho phép/enforce/validate ..."} | P0 | 1 |

<!-- Lặp lại ## 3.X cho mỗi module -->

---

## 4. Non-Functional Requirements

### 4.1 Performance (NFR-PERF)

| ID | Requirement | Target |
|----|-------------|--------|
| NFR-PERF-01 | ... | ... |

### 4.2 Availability (NFR-AVAIL)
### 4.3 Security (NFR-SEC)
### 4.4 Scalability (NFR-SCALE)
### 4.5 Maintainability (NFR-MAINT)

---

## 5. Interface Requirements

### 5.1 User Interfaces
<!-- Mobile app: OS support, offline mode, dark mode, v.v. -->

### 5.2 External Interfaces
<!-- Bảng: Interface | Protocol | Authentication | Rate Limit -->

### 5.3 Internal Interfaces (Service-to-Service)
<!-- Nếu monolith/đơn giản, ghi rõ "N/A — single backend service" thay vì bịa ra service graph không tồn tại -->

---

## 6. Data Requirements

### 6.1 Data Retention

| Data Type | Retention | Storage |
|-----------|-----------|---------|
| ... | ... | ... |

### 6.2 Data Privacy

| Requirement | Implementation |
|-------------|---------------|
| ... | ... |

---

## 7. Constraints

### 7.1 Technical Constraints
### 7.2 Business Constraints
### 7.3 Regulatory Constraints
```

---

## Quy tắc viết

1. **Mọi requirement phải có ID** theo format `FR-{PREFIX}-{NN}` / `NFR-{PREFIX}-{NN}`. ID này được các tài liệu khác (phase-detail Task Breakdown, PR description) tham chiếu ngược lại — không đổi ID sau khi đã dùng ở nơi khác, chỉ thêm mới.
2. **Requirement phải test được** — viết dạng hành vi quan sát được ("Hệ thống trả về 401 khi token hết hạn"), không viết mục tiêu mơ hồ ("Hệ thống phải an toàn").
3. **Priority & Phase bắt buộc** cho mọi FR — dùng để trace sang `docs/processes/deployment-phases.md` Module × Phase Matrix.
4. Nếu 1 module hiện tại **chưa có implementation** (chỉ có schema hoặc chỉ có kế hoạch), vẫn viết FR đầy đủ nhưng ghi Phase tương ứng (VD: Phase 1 nếu là MVP bắt buộc) — KHÔNG bỏ qua requirement chỉ vì chưa code.
5. Mục 5.3 (Internal Interfaces) — nếu kiến trúc là monolith/1 service, ghi rõ thay vì copy nguyên mẫu microservices từ dự án khác.
6. Mục 6 (Data Requirements) phải khớp với bảng thật trong `ARCH-DB` — không tạo loại dữ liệu (VD: "chat history") nếu không có trong schema hoặc roadmap.
