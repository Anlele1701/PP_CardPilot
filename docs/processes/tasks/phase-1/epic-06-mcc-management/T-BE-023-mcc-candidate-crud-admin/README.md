# T-BE-023 — MCC candidate CRUD (Admin)

**Module (chủ đạo):** `BE`
**Phase:** 1
**Epic:** Epic 6 — MCC Management
**Status:** Backlog
**Prototype:** — (Admin API, chưa có Admin UI)

## Mô tả

Xem/duyệt `merchant_mcc_candidates` — Admin xác nhận suy luận MCC nào là đúng cho 1 merchant (candidate được tạo tự động bởi `T-AI-001`/quá trình inference).

## Acceptance Criteria

- [ ] Admin xem được danh sách candidate theo trạng thái (`pending`/`verified`/`rejected`)
- [ ] Admin duyệt (`verified`) 1 candidate → candidate đó được ưu tiên dùng khi inference MCC tự động cho giao dịch tương lai (dùng bởi `AI-002` ở Epic 7)
- [ ] User thường gọi endpoint này → `403`

## Dependencies

- **Depends On (Task):** [T-AI-001](../T-AI-001-merchant-lookup-normalize/README.md)
- **Depends On (Phase Gate):** —

## Ref Docs

- [SRS — 3.5 FR-MCC (FR-MCC-03)](../../../../../SRS.md)

## Subtasks

— (task atomic trong 1 module `BE`, không tách subtask)

## Audit Trail

| Status | Created By | Created Date | Updated By | Updated Date | Reviewed/Approved By | Review Date | Ghi chú |
|--------|-----------|---------------|-----------|---------------|------------------------|--------------|---------|
| Backlog | TBD | 2026-07-25 | — | — | — | — | Chờ T-AI-001 |

---
Index toàn backlog: [`../../../../tasks.md`](../../../../tasks.md)
