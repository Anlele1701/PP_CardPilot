# T-S08 — Card List Screen

**Module (chủ đạo):** `MOBILE` — xem subtask cho breakdown (BE/MOBILE)
**Phase:** 1
**Epic:** Epic 4 — Card Management
**Status:** Backlog
**Prototype:** [prototype.html#view-s08](../../../../../prototypes/prototype.html#view-s08) — mở file, tự nhảy tới S08 (danh sách thẻ đã sở hữu)

## Mô tả

Danh sách thẻ đã thêm, tap để sửa (điều hướng S07), vuốt/nút để xoá.

## Acceptance Criteria

- [ ] Hiển thị đúng toàn bộ `user_cards` của user hiện tại, thẻ `is_default=true` có dấu hiệu nhận biết riêng (badge/icon)
- [ ] Chưa có thẻ nào → empty state mời "Thêm thẻ đầu tiên", bấm vào điều hướng sang S07
- [ ] Tap vào 1 thẻ → điều hướng sang S07 ở chế độ Sửa, đúng thẻ đã chọn
- [ ] Xoá 1 thẻ → xác nhận (dialog) trước khi xoá thật, xoá xong danh sách cập nhật ngay không cần reload màn hình
- [ ] Xoá thẻ đang là `is_default=true` duy nhất → không tự động crash, danh sách còn lại không có default nào (hoặc gán default cho thẻ còn lại đầu tiên — quyết định cụ thể: TBD, cần UX xác nhận)

## Dependencies

- **Depends On (Task):** [T-MOBILE-001](../../epic-02-auth/T-MOBILE-001-core-network-api-client/README.md)
- **Depends On (Phase Gate):** —

## Ref Docs

- [SRS — 3.3 FR-CARD](../../../../../SRS.md)
- [PRD — 2.5 Card Management](../../../../../PRD.md#25-card-management)

## Subtasks

| ID | Module | Subtask | Status | File |
|----|--------|---------|--------|------|
| T-S08.1 | `BE` | GET /api/user-cards (list) | Backlog | [T-S08.1-be-list-user-cards.md](./T-S08.1-be-list-user-cards.md) |
| T-S08.2 | `BE` | DELETE /api/user-cards/:id | Backlog | [T-S08.2-be-delete-user-card.md](./T-S08.2-be-delete-user-card.md) |
| T-S08.3 | `MOBILE` | Card List screen UI/logic | Backlog | [T-S08.3-mobile-card-list-screen.md](./T-S08.3-mobile-card-list-screen.md) |

## Audit Trail

| Status | Created By | Created Date | Updated By | Updated Date | Reviewed/Approved By | Review Date | Ghi chú |
|--------|-----------|---------------|-----------|---------------|------------------------|--------------|---------|
| Backlog | TBD | 2026-07-25 | — | — | — | — | Chờ T-MOBILE-001 |

---
Index toàn backlog: [`../../../../tasks.md`](../../../../tasks.md)
