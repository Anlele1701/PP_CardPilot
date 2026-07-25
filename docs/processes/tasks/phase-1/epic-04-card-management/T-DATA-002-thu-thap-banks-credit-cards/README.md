# T-DATA-002 — Thu thập dữ liệu banks + credit_cards

**Module (chủ đạo):** `DATA`
**Phase:** 1
**Epic:** Epic 4 — Card Management
**Status:** Ready
**Prototype:** — (không phải task màn hình — data seeding)

## Mô tả

Thu thập thủ công thông tin ngân hàng + sản phẩm thẻ tín dụng phổ biến tại Việt Nam, seed vào bảng `banks`/`credit_cards`.

## Acceptance Criteria

- [ ] Tối thiểu N ngân hàng phổ biến tại VN (cụ thể: TBD — cần Product xác nhận số lượng tối thiểu cho MVP, đề xuất ≥ 5) với đầy đủ tên + logo/asset nếu cần hiển thị
- [ ] Mỗi bank có ≥ 1 sản phẩm thẻ tín dụng chính trong `credit_cards`, đủ field để hiển thị ở S07 (tên sản phẩm, hạng thẻ)
- [ ] Seed script idempotent (chạy lại không tạo trùng)
- [ ] Dữ liệu có nguồn tham khảo ghi chú lại (không bịa tên ngân hàng/sản phẩm không tồn tại thật)

## Dependencies

- **Depends On (Task):** —
- **Depends On (Phase Gate):** —

## Ref Docs

- [BRD — 6.5 Card Management](../../../../../BRD.md)
- [PRD — 2.5 Card Management](../../../../../PRD.md#25-card-management)

## Subtasks

— (task atomic trong 1 module `DATA`, không tách subtask)

## Audit Trail

| Status | Created By | Created Date | Updated By | Updated Date | Reviewed/Approved By | Review Date | Ghi chú |
|--------|-----------|---------------|-----------|---------------|------------------------|--------------|---------|
| Ready | TBD | 2026-07-25 | — | — | — | — | Không blocker — có thể bắt đầu song song với Epic 2 |

---
Index toàn backlog: [`../../../../tasks.md`](../../../../tasks.md)
