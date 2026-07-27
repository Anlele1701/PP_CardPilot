# Template: PRD.md (Product Requirements Document)

> File này quy định cấu trúc cho `docs/PRD.md`.
> Mục tiêu: mô tả **sản phẩm làm gì** ở mức module/flow — input/output, UX flow, priority theo phase. KHÔNG viết chi tiết field/API (đó là việc của `SRS`/`ARCH-API`/`ARCH-DB`).

---

## Cấu trúc bắt buộc

```markdown
# Product Requirements Document (PRD)
# {Tên dự án} - {Mô tả 1 dòng}

**Version:** {X.X}
**Date:** {YYYY-MM-DD}
**Author:** {Team/Author}

---

## 1. Product Overview

### 1.1 Product Vision
<!-- 1 câu định vị sản phẩm -->

### 1.2 Problem Statement
<!-- Bullet list vấn đề người dùng đang gặp -->

### 1.3 Solution
<!-- Bullet list giải pháp tương ứng từng vấn đề -->

## 2. Product Modules
<!-- Mỗi module = 1 sub-section. Đây là phần QUAN TRỌNG NHẤT của PRD -->
<!-- Mỗi module PHẢI có: Input/Output cụ thể (không mô tả chung chung), bảng Feature × Priority × Phase nếu module có nhiều tính năng con -->
<!-- Nếu module đã có schema/entity thật trong repo, tham chiếu tên bảng/field thật thay vì đặt tên giả -->

### 2.1 {Module Name}

#### {Sub-section, VD: Login Methods / Input Fields}
| Field/Item | Type/Priority | Ghi chú |
|------------|---------------|---------|
| ... | ... | ... |

#### {Sub-section khác nếu cần, VD: Processing Pipeline}
```
{Input} → {Step 1} → {Step 2} → {Output}
```

<!-- Lặp lại ## 2.X cho mỗi module: liệt kê TẤT CẢ modules trong BRD #6 Core Features -->

## 3. Non-Functional Requirements
<!-- Bảng ngắn — chi tiết đầy đủ nằm ở SRS #4. Ở đây chỉ nêu mức tham chiếu nhanh -->

### 3.1 Performance
### 3.2 Scalability
### 3.3 Security
### 3.4 Accessibility

## 4. User Flows
<!-- Mỗi flow chính = 1 ASCII flow ngắn gọn -->
<!-- Đây KHÔNG phải screen-by-screen task breakdown (đó là việc của phase-detail) -->

### 4.1 {Flow name, VD: New User Onboarding}
```
{Step 1} → {Step 2} → {Step 3} → {Step 4}
```

## 5. Release Criteria
<!-- Checklist Must/Should/Nice-to-have theo Phase, khớp với docs/processes/deployment-phases.md -->

### Phase 1 — Must Have
- [ ] ...

### Phase 2 — Should Have
- [ ] ...

### Phase 3+ — Nice to Have
- [ ] ...
```

---

## Quy tắc viết

1. **Mỗi module phải có Input/Output rõ ràng** — không viết "hệ thống xử lý X", phải viết "Input: {...} → Output: {...}".
2. **Tham chiếu schema/entity thật** khi module đã có trong `apps/cardpilot-backend/src/database/migrations` hoặc domain entities — không đặt tên field khác với thực tế trong repo.
3. **Đánh dấu WIP rõ ràng** — nếu 1 module chưa chốt logic (VD: công thức tính điểm lên hạng), viết thẳng "(WIP — chưa chốt công thức)" thay vì mô tả mơ hồ như đã xong.
4. Section 2 (Product Modules) phải bao phủ đủ toàn bộ nhóm feature liệt kê ở `BRD` #6 — không thiếu, không thừa.
5. Section 5 (Release Criteria) phải khớp với `docs/processes/deployment-phases.md` — mỗi checkbox nên map được sang 1 hoặc nhiều Epic trong `phase-detail`.
6. Không lặp lại nội dung `SRS` (FR/NFR ID, priority chi tiết) — PRD mô tả UX/flow, SRS mô tả requirement có thể test được.
