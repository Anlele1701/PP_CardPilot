# Template: architecture/database.md (Database Design Document)

> File này quy định cấu trúc cho `docs/architecture/database.md`.
> Mục tiêu: ERD + table definitions **khớp 100% với migration thật** trong `apps/cardpilot-backend/src/database/migrations`. Đây là tài liệu bắt buộc phải đối chiếu code trước khi viết — không suy đoán schema.

---

## Cấu trúc bắt buộc

```markdown
# Database Design Document
# {Tên dự án} - {Mô tả 1 dòng}

**Version:** {X.X}
**Date:** {YYYY-MM-DD}

---

## 1. Database Strategy Overview

| Database | Type | Purpose | Trạng thái |
|----------|------|---------|-----------|
| PostgreSQL (Supabase) | Relational (OLTP) | Core business data — source of truth | Active |
| SQLite (on-device) | Embedded | Local-first cache trên mobile, offline-first | {Active / Planned} |

## 2. PostgreSQL - Core Schema

### 2.1 ERD Overview
<!-- Mermaid erDiagram, lấy TRỰC TIẾP từ migration file, không tự vẽ quan hệ tưởng tượng -->

```mermaid
erDiagram
```

### 2.2 Table Definitions
<!-- Copy SQL/field list TRỰC TIẾP từ migration file mới nhất — bao gồm type, default, constraint -->
<!-- Group theo domain area bằng comment, giống cách migration thật đã group -->

```sql
-- =============================================
-- {DOMAIN AREA}
-- =============================================
```

## 3. Local Cache Schema (SQLite, nếu có)
<!-- Chỉ viết nếu đã có code thật. Nếu chưa, ghi rõ "Chưa implement — xem BRD #Constraints cho open question về sync" -->

## 4. Data Migration Strategy
<!-- Lộ trình migration thật đã áp dụng / dự kiến — liệt kê theo file migration đã tồn tại -->

| Migration File | Mô tả |
|-----------------|--------|
| ... | ... |

### Backup Strategy
| Database | Backup Method | Frequency | Retention |
|----------|--------------|-----------|-----------|
| ... | ... | ... | ... |
```

---

## Quy tắc viết

1. **Không tự bịa cột/bảng.** Mọi field, type, default, constraint phải copy chính xác từ migration file thật (`apps/cardpilot-backend/src/database/migrations/*.ts`). Nếu tài liệu và code lệch nhau, code luôn thắng — sửa tài liệu, không sửa ngược.
2. Nếu 1 cột kiểu enum-like (`varchar` không có CHECK constraint), ghi chú rõ "chưa được enforce bằng DB constraint" thay vì liệt kê giá trị như enum chính thức.
3. ERD Mermaid phải phản ánh đúng FK thật (bao gồm cả FK nullable) — không thêm quan hệ suy luận nếu không có FK trong SQL.
4. Local Cache Schema (SQLite) — chỉ điền khi có code thật trong `cardpilot_app`. Nếu chưa, để nguyên placeholder ghi rõ "chưa implement" và trỏ sang tài liệu roadmap liên quan.
5. Mục 4 (Migration Strategy) phải liệt kê **từng migration file đang tồn tại thật** theo tên file, không tóm tắt chung chung "đã setup schema ban đầu".
