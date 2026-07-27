# T-AI-001 — Merchant lookup + normalize

**Module (chủ đạo):** `AI`
**Phase:** 1
**Epic:** Epic 6 — MCC Management
**Status:** Ready
**Prototype:** — (logic backend, không phải màn hình — nhưng là task foundational được S09 Add Transaction phụ thuộc)

## Mô tả

Khi user nhập tên merchant mới lúc log giao dịch (S09) → tạo `merchants` record nếu chưa tồn tại, tính `name_normalized` (lowercase, bỏ dấu, bỏ ký tự đặc biệt) để phục vụ so khớp MCC (`T-BE-023`) và inference sau này (`AI-002` ở Epic 7). **Task foundational** — dùng chung bởi cả nhánh Admin MCC (Epic 6) và Transaction Logging (Epic 7, task `T-S09`).

## Acceptance Criteria

- [ ] 2 tên merchant chỉ khác dấu/hoa-thường (VD: "Highlands Coffee" vs "highlands coffee" vs "HIGHLANDS COFFEE") → cùng 1 `name_normalized`, không tạo 2 record `merchants` khác nhau
- [ ] Merchant đã tồn tại (theo `name_normalized`) → tái sử dụng record cũ, không tạo trùng
- [ ] Merchant hoàn toàn mới → tạo record mới, `name_normalized` tính đúng ngay lần đầu

## Dependencies

- **Depends On (Task):** —
- **Depends On (Phase Gate):** —

## Ref Docs

- [ARCH-AI — 3. MCC Inference (Phase 1 rule-based)](../../../../../architecture/ai.md)
- [ARCH-DB — 2.2 Table Definitions](../../../../../architecture/database.md#22-table-definitions)

## Subtasks

— (task atomic trong 1 module `AI`, không tách subtask)

## Audit Trail

| Status | Created By | Created Date | Updated By | Updated Date | Reviewed/Approved By | Review Date | Ghi chú |
|--------|-----------|---------------|-----------|---------------|------------------------|--------------|---------|
| Ready | TBD | 2026-07-25 | — | — | — | — | Không blocker — nền tảng cho cả Epic 6 (Admin MCC) và Epic 7 (Transaction Logging, T-S09) |

---
Index toàn backlog: [`../../../../tasks.md`](../../../../tasks.md)
