# T-S07 — Add/Edit Card Screen

**Module (chủ đạo):** `MOBILE` — xem subtask cho breakdown (BE/MOBILE/QA)
**Phase:** 1
**Epic:** Epic 4 — Card Management
**Status:** Backlog
**Prototype:** [prototype.html#view-s07](../../../../../prototypes/prototype.html#view-s07) — mở file, tự nhảy tới S07 (chọn Ngân hàng, sản phẩm thẻ, ngày sao kê)

## Mô tả

Chọn ngân hàng → chọn sản phẩm thẻ từ danh sách seed → nhập nickname, billing cycle day, is_default. Cùng 1 màn hình dùng cho cả Thêm mới và Sửa thẻ đã có.

## Acceptance Criteria

- [ ] Chọn ngân hàng → danh sách sản phẩm thẻ lọc đúng theo `bank_id` đã chọn
- [ ] Nhập nickname + billing cycle day (1-31) + is_default → bấm Lưu → gọi API tạo/sửa `user_cards`, thành công điều hướng về Card List (S08)
- [ ] Billing cycle day ngoài khoảng 1-31 → validate lỗi client-side, không cho lưu
- [ ] Thêm thẻ khi đã đạt `max_cards` theo tier hiện tại → hiển thị lỗi rõ ràng ("Đã đạt giới hạn N thẻ cho hạng {tier}"), không cho lưu, gợi ý nâng cấp tier (nếu có flow đó)
- [ ] Chế độ Sửa: pre-fill đúng dữ liệu thẻ hiện tại, không cho đổi `credit_card_id` gốc (chỉ sửa nickname/billing_cycle_day/is_default)
- [ ] Đặt `is_default = true` cho thẻ này → thẻ default cũ (nếu có) tự động bị bỏ default (chỉ 1 thẻ default tại 1 thời điểm)

## Dependencies

- **Depends On (Task):** [T-MOBILE-001](../../epic-02-auth/T-MOBILE-001-core-network-api-client/README.md)
- **Depends On (Phase Gate):** —

## Ref Docs

- [SRS — 3.3 FR-CARD](../../../../../SRS.md)
- [PRD — 2.5 Card Management](../../../../../PRD.md#25-card-management)

## Subtasks

| ID | Module | Subtask | Status | File |
|----|--------|---------|--------|------|
| T-S07.1 | `BE` | GET /api/banks, /api/credit-cards (catalog) | Backlog | [T-S07.1-be-catalog-apis.md](./T-S07.1-be-catalog-apis.md) |
| T-S07.2 | `BE` | POST + PATCH /api/user-cards (create/update) | Backlog | [T-S07.2-be-create-update-user-cards.md](./T-S07.2-be-create-update-user-cards.md) |
| T-S07.3 | `BE` | Enforce max_cards theo tier | Backlog | [T-S07.3-be-enforce-max-cards.md](./T-S07.3-be-enforce-max-cards.md) |
| T-S07.4 | `MOBILE` | Add/Edit Card screen UI/logic | Backlog | [T-S07.4-mobile-add-edit-card-screen.md](./T-S07.4-mobile-add-edit-card-screen.md) |
| T-S07.5 | `QA` | Test case: đạt max_cards, billing day invalid, đổi default | Backlog | [T-S07.5-qa-add-edit-card-tests.md](./T-S07.5-qa-add-edit-card-tests.md) |

## Audit Trail

| Status | Created By | Created Date | Updated By | Updated Date | Reviewed/Approved By | Review Date | Ghi chú |
|--------|-----------|---------------|-----------|---------------|------------------------|--------------|---------|
| Backlog | TBD | 2026-07-25 | — | — | — | — | Chờ T-MOBILE-001 |

---
Index toàn backlog: [`../../../../tasks.md`](../../../../tasks.md)
