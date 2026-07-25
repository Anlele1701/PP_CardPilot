# T-DATA-004 — Seed merchant_category_codes

**Module (chủ đạo):** `DATA`
**Phase:** 1
**Epic:** Epic 6 — MCC Management
**Status:** Ready
**Prototype:** — (không phải task màn hình — data seeding)

## Mô tả

Seed danh sách MCC (Merchant Category Code) chuẩn vào bảng `merchant_category_codes`, theo bảng công khai ISO 18245.

## Acceptance Criteria

- [ ] Seed đầy đủ các MCC phổ biến cần cho category hiển thị ở Dashboard (ăn uống, mua sắm, xăng dầu, giải trí, ...) — tối thiểu đủ để demo Category Pie Chart (S06) có dữ liệu ý nghĩa
- [ ] Mỗi MCC có `code`, `category` (nhóm hiển thị cho user, VD "Ăn uống" thay vì tên kỹ thuật MCC), `description`
- [ ] Seed script idempotent

## Dependencies

- **Depends On (Task):** —
- **Depends On (Phase Gate):** —

## Ref Docs

- [PRD — 2.7 MCC Management](../../../../../PRD.md#27-mcc-management)

## Subtasks

— (task atomic trong 1 module `DATA`, không tách subtask)

## Audit Trail

| Status | Created By | Created Date | Updated By | Updated Date | Reviewed/Approved By | Review Date | Ghi chú |
|--------|-----------|---------------|-----------|---------------|------------------------|--------------|---------|
| Ready | TBD | 2026-07-25 | — | — | — | — | Không blocker |

---
Index toàn backlog: [`../../../../tasks.md`](../../../../tasks.md)
