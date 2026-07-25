# T-BE-025 — Admin duyệt feedback

**Module (chủ đạo):** `BE`
**Phase:** 1
**Epic:** Epic 6 — MCC Management
**Status:** Backlog
**Prototype:** — (Admin API, chưa có Admin UI)

## Mô tả

PATCH cập nhật `merchant_mcc_candidates.status`/`verified_count` dựa trên feedback user đã gửi (từ `T-S11.2` — User feedback MCC ở Epic 7, Transaction Detail screen).

## Acceptance Criteria

- [ ] Admin xem được danh sách feedback user đã gửi cho từng merchant/candidate
- [ ] Duyệt feedback hợp lệ → `verified_count` tăng, có thể chuyển `status` sang `verified` nếu đạt ngưỡng (ngưỡng cụ thể: TBD — cần xác nhận, đề xuất ≥ 3 feedback trùng khớp)
- [ ] Từ chối feedback → `status` không đổi, ghi nhận đã xem xét (tránh admin duyệt lại nhiều lần cùng 1 feedback)

## Dependencies

- **Depends On (Task):** [T-BE-023](../T-BE-023-mcc-candidate-crud-admin/README.md), [T-S11.2](../../epic-07-transaction-logging/T-S11-transaction-detail-screen/T-S11.2-be-user-feedback-mcc.md)
- **Depends On (Phase Gate):** —

## Ref Docs

- [SRS — 3.5 FR-MCC (FR-MCC-05)](../../../../../SRS.md)

## Subtasks

— (task atomic trong 1 module `BE`, không tách subtask)

## Audit Trail

| Status | Created By | Created Date | Updated By | Updated Date | Reviewed/Approved By | Review Date | Ghi chú |
|--------|-----------|---------------|-----------|---------------|------------------------|--------------|---------|
| Backlog | TBD | 2026-07-25 | — | — | — | — | Chờ T-BE-023, T-S11.2; ngưỡng verified_count cần Product xác nhận |

---
Index toàn backlog: [`../../../../tasks.md`](../../../../tasks.md)
