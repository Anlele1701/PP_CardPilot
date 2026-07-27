# Template: BRD.md (Business Requirements Document)

> File này quy định cấu trúc cho `docs/BRD.md`.
> Mục tiêu: mô tả **tại sao** sản phẩm tồn tại — business objectives, business model, user roles, risk — KHÔNG đi vào chi tiết kỹ thuật (đó là việc của `PRD`/`SRS`/`ARCH-*`).

---

## Cấu trúc bắt buộc

```markdown
# Business Requirements Document (BRD)
# {Tên dự án} - {Mô tả 1 dòng}

**Version:** {X.X}
**Date:** {YYYY-MM-DD}
**Author:** {Team/Author}

> **Note on figures in this document**: đánh dấu rõ figures nào là `TBD`/`Draft` (chưa được stakeholder xác nhận) so với figures được suy ra trực tiếp từ repository (schema, code hiện có).

---

## 1. Executive Summary
<!-- 1 đoạn: sản phẩm là gì, giải quyết vấn đề gì, khác biệt cốt lõi -->

## 2. Business Objectives

### 2.1 Primary Objectives
<!-- Bullet list — mục tiêu kinh doanh, không phải feature list -->

### 2.2 Success Metrics
<!-- Bảng theo Phase. Nếu số liệu chưa có, ghi rõ "TBD" — KHÔNG bịa số -->

| Metric | Phase 1 | Phase 2 | ... |
|--------|---------|---------|-----|
| ... | ... | ... | ... |

## 3. Business Model
<!-- Cách sản phẩm tạo ra giá trị/doanh thu: subscription, ads, membership tier, affiliate, v.v. -->
<!-- Nếu có bảng tier/pricing, luôn tham chiếu ngược lại field thật trong DB schema nếu có (VD: `memberships.max_cards`) -->

### 3.1 {Revenue stream 1}
### 3.2 {Revenue stream 2, nếu có}

> Đánh dấu rõ mục nào là **trạng thái hiện tại đã có trong code/schema** và mục nào là **kế hoạch/WIP chưa implement**.

## 4. Target Users

### 4.1 Primary Persona
<!-- Nhân khẩu học, hành vi, pain point cụ thể (viết như câu nói trực tiếp của user nếu có) -->

### 4.2 Secondary Persona (nếu có)

## 5. User Roles & Permissions
<!-- Liệt kê từng role, quyền hạn tương ứng -->
<!-- Đánh dấu rõ role nào ĐÃ có RBAC/guard trong code, role nào CHƯA (chỉ là kế hoạch) -->

### 5.1 {Role 1}
### 5.2 {Role 2}

## 6. Core Features
<!-- Liệt kê feature theo nhóm lớn (module), khớp với PRD #2 Product Modules -->
<!-- Mỗi feature: mô tả ngắn, kèm ghi chú nếu tính năng đụng tới bảng DB cụ thể -->
<!-- Nếu có business challenge/constraint đặc thù (VD: data phải crawl thủ công), ghi ngay dưới feature đó -->

### 6.1 {Feature group 1}
### 6.2 {Feature group 2}

## 7. Competitive Analysis
<!-- Bảng so sánh với đối thủ/giải pháp thay thế -->
<!-- Đánh dấu Draft nếu chưa có nghiên cứu thị trường chính thức -->

| Tiêu chí | {Sản phẩm} | {Đối thủ 1} | {Đối thủ 2} |
|----------|-----------|-------------|-------------|
| ... | ... | ... | ... |

## 8. Revenue Projections
<!-- Bảng Phase | Timeline | Users | Monthly Revenue -->
<!-- Nếu không có số liệu, ghi "TBD" toàn bộ bảng — KHÔNG bịa số để "cho đẹp" -->

## 9. Constraints & Assumptions

### Constraints
<!-- Ràng buộc thực tế: kỹ thuật, pháp lý, nguồn lực, dữ liệu -->

### Assumptions
<!-- Giả định đang dùng để lập kế hoạch -->

## 10. Risks

| Risk | Impact | Probability | Mitigation |
|------|--------|-------------|------------|
| ... | ... | ... | ... |

---

**Tài liệu liên quan:** [PRD](../PRD.md) · [SRS](../SRS.md) · [System Architecture](../architecture/system.md)
```

---

## Quy tắc viết

1. **Không bịa số liệu kinh doanh** (users, revenue, growth %). Nếu chưa có, ghi `TBD` hoặc `Draft` kèm ghi chú "cần xác nhận với stakeholder".
2. **Business, không phải kỹ thuật** — không viết field name, API endpoint, class name ở đây (đưa vào `PRD`/`SRS`/`ARCH-*`). Ngoại lệ: có thể **tham chiếu tên bảng DB** khi nó trực tiếp thể hiện business rule (VD: "membership tier giới hạn theo `memberships.max_cards`").
3. Luôn phân biệt rõ **hiện trạng đã implement** (grounded trong code/schema thật) và **kế hoạch/WIP** — dùng ghi chú "> **Trạng thái hiện tại**: ..." ngay dưới mục liên quan.
4. Mục 6 (Core Features) phải khớp 1-1 với cấu trúc module ở `PRD` #2 — không tạo thêm nhóm feature ở đây mà PRD không có.
5. Giữ văn phong business — người đọc là product owner/stakeholder, không phải engineer.
