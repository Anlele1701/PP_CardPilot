# T-S06 — Dashboard Screen

**Module (chủ đạo):** `MOBILE` — xem subtask cho breakdown (BE/UI/MOBILE/QA)
**Phase:** 1
**Epic:** Epic 8 — Dashboard (Core)
**Status:** Backlog
**Prototype:** [prototype.html#view-s06](../../../../../prototypes/prototype.html#view-s06) — mở file, tự nhảy tới S06 (Cashback Jars, Category breakdown)

## Mô tả

Màn hình chính sau khi đăng nhập/vào local-only mode: danh sách Cashback Jar theo từng thẻ, biểu đồ tròn phân bổ chi tiêu theo category, empty state mời "Thêm thẻ đầu tiên" nếu chưa có thẻ nào.

## Acceptance Criteria

- [ ] Chưa có thẻ nào → empty state, nút dẫn sang Add Card (S07), không hiển thị Cashback Jar/Pie chart trống rỗng gây rối mắt
- [ ] Có ≥ 1 thẻ, chưa có giao dịch nào → Cashback Jar hiển thị 0/cap, Pie chart empty state riêng (khác message với "chưa có thẻ")
- [ ] Có giao dịch → mỗi thẻ hiển thị đúng 1 Cashback Jar: đã dùng bao nhiêu / cap bao nhiêu trong chu kỳ hiện tại, progress bar tỷ lệ đúng
- [ ] Pie chart hiển thị đúng tỷ lệ % chi tiêu theo category, tap vào 1 lát cắt (nếu có tương tác) hiển thị số tiền cụ thể
- [ ] Badge mode hiển thị đúng "LOCAL GUEST" (local-only) hoặc "SYNCED CLOUD" (đã đăng nhập) — theo đúng hành vi mô phỏng trong prototype
- [ ] Vừa log 1 giao dịch mới (từ S09) quay lại Dashboard → số liệu Cashback Jar cập nhật ngay, không cần thoát app/reload thủ công
- [ ] Loading/error state khi 2 API dashboard fail — không để trắng màn hình

## Dependencies

- **Depends On (Task):** [T-MOBILE-001](../../epic-02-auth/T-MOBILE-001-core-network-api-client/README.md)
- **Depends On (Phase Gate):** —

## Ref Docs

- [SRS — 3.8 FR-DASH](../../../../../SRS.md)
- [PRD — 2.4 Dashboard](../../../../../PRD.md#24-dashboard)

## Subtasks

| ID | Module | Subtask | Status | File |
|----|--------|---------|--------|------|
| T-S06.1 | `BE` | GET /api/dashboard/cashback-jars | Backlog | [T-S06.1-be-cashback-jars-api.md](./T-S06.1-be-cashback-jars-api.md) |
| T-S06.2 | `BE` | GET /api/dashboard/category-breakdown | Backlog | [T-S06.2-be-category-breakdown-api.md](./T-S06.2-be-category-breakdown-api.md) |
| T-S06.3 | `UI` | Cashback Jar component (cardpilot_ui) | Backlog | [T-S06.3-ui-cashback-jar-component.md](./T-S06.3-ui-cashback-jar-component.md) |
| T-S06.4 | `UI` | Category Pie Chart component (cardpilot_ui) | Backlog | [T-S06.4-ui-category-pie-chart.md](./T-S06.4-ui-category-pie-chart.md) |
| T-S06.5 | `MOBILE` | Dashboard screen assembly (empty state, mode badge) | Backlog | [T-S06.5-mobile-dashboard-screen.md](./T-S06.5-mobile-dashboard-screen.md) |
| T-S06.6 | `QA` | Test case: empty state, cập nhật realtime sau khi log giao dịch | Backlog | [T-S06.6-qa-dashboard-tests.md](./T-S06.6-qa-dashboard-tests.md) |

## Audit Trail

| Status | Created By | Created Date | Updated By | Updated Date | Reviewed/Approved By | Review Date | Ghi chú |
|--------|-----------|---------------|-----------|---------------|------------------------|--------------|---------|
| Backlog | TBD | 2026-07-25 | — | — | — | — | Chờ T-MOBILE-001 |

---
Index toàn backlog: [`../../../../tasks.md`](../../../../tasks.md)
