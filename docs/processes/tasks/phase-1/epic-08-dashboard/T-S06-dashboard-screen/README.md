# T-S06 — Dashboard Screen

**Module (chủ đạo):** `MOBILE` — xem subtask cho breakdown (BE/UI/MOBILE/QA)
**Phase:** 1
**Epic:** Epic 8 — Dashboard (Core)
**Status:** Backlog
**Prototype:** [prototype.html#view-s06](../../../../../prototypes/prototype.html#view-s06) — mở file, tự nhảy tới S06 (Cashback Jars, Category breakdown)

## Mô tả

**Trung Tâm Điều Khiển Tài Chính (Dashboard Screen):**
Màn hình Dashboard (`S06`) là trung tâm hiển thị tình hình hoàn tiền và chi tiêu tín dụng của người dùng. Màn hình giúp người dùng nhanh chóng biết được:
- Đã nhận bao nhiêu tiền cashback trong tháng trên tổng hạn mức tối đa của từng thẻ (Cashback Jars).
- Phân bổ chi tiêu theo danh mục (Pie Chart Breakdown).
- Truy cập nhanh vào tính năng Ghi giao dịch (`S09`) và Danh sách thẻ (`S08`).

## Acceptance Criteria & Edge Cases

- [ ] **Empty State (Chưa có thẻ):** Nếu tài khoản chưa có thẻ nào, hiển thị minh họa thân thiện + Nút *"Thêm thẻ đầu tiên của bạn"* hướng dẫn sang `S07`. Ẩn biểu đồ và hũ hoàn tiền trống để tránh làm rối mắt.
- [ ] **Zero-Transaction State (Đã có thẻ, chưa có giao dịch):** Mỗi thẻ hiển thị Hũ hoàn tiền ở mức `0đ / [Hạn mức cap]`. Phần Biểu đồ phân bổ chi tiêu hiển thị thông điệp *"Chưa có giao dịch nào trong tháng này. Hãy thêm giao dịch để xem phân tích."*
- [ ] **Đầy Đủ Dữ Liệu:** 
  * Mỗi thẻ hiển thị 1 Cashback Jar riêng: Số tiền đã hoàn, Hạn mức hoàn tối đa trong tháng (Cap), % Tiến độ kèm Progress Bar màu sắc tương ứng với thương hiệu ngân hàng.
  * Biểu đồ tròn thể hiện % chi tiêu theo từng Ngành hàng (Ẩm thực, Siêu thị, Di chuyển, Giải trí...).
- [ ] **Badge Mode Trực Quan:** Hiển thị rõ badge `"LOCAL GUEST"` (nếu đang ở chế độ dùng thử) hoặc `"SYNCED CLOUD"` (nếu đã đăng nhập tài khoản server) ở góc trên màn hình.
- [ ] **Cập Nhật Realtime (Reactive State Management):** Ngay sau khi người dùng ghi một giao dịch mới từ `S09` và quay lại Dashboard, dữ liệu Cashback Jar và Biểu đồ phải được cập nhật tức thì (thông qua Riverpod Provider invalidation), không bắt người dùng phải quẹt pull-to-refresh hay thoát app.
- [ ] **Bảo Vệ Lỗi API:** Nếu API Dashboard tạm thời gián đoạn, hiển thị card Error State với nút *"Thử lại"* thay vì làm sập toàn bộ giao diện app.

## Dependencies

- **Depends On (Task):** [T-MOBILE-001](../../epic-02-auth/T-MOBILE-001-core-network-api-client/README.md)
- **Depends On (Phase Gate):** —

## Ref Docs

- [SRS — 3.8 FR-DASH](../../../../../SRS.md)
- [PRD — 2.4 Dashboard](../../../../../PRD.md#24-dashboard)
- [ARCH-DS — Shared Components & Theme Tokens](../../../../../MOBILE_ARCHITECTURE.md#cardpilot_ui)

## Subtasks

| ID | Module | Subtask | Status | File |
|----|--------|---------|--------|------|
| T-S06.1 | `BE` | GET /api/dashboard/cashback-jars — API tính tổng tiền hoàn & progress cap | Backlog | [T-S06.1-be-cashback-jars-api.md](./T-S06.1-be-cashback-jars-api.md) |
| T-S06.2 | `BE` | GET /api/dashboard/category-breakdown — API phân bổ % chi tiêu theo MCC | Backlog | [T-S06.2-be-category-breakdown-api.md](./T-S06.2-be-category-breakdown-api.md) |
| T-S06.3 | `UI` | Cashback Jar component (phát triển trong `cardpilot_ui`) | Backlog | [T-S06.3-ui-cashback-jar-component.md](./T-S06.3-ui-cashback-jar-component.md) |
| T-S06.4 | `UI` | Category Pie Chart component (phát triển trong `cardpilot_ui`) | Backlog | [T-S06.4-ui-category-pie-chart.md](./T-S06.4-ui-category-pie-chart.md) |
| T-S06.5 | `MOBILE` | Dashboard screen assembly — Lắp ráp view, handle empty & guest mode state | Backlog | [T-S06.5-mobile-dashboard-screen.md](./T-S06.5-mobile-dashboard-screen.md) |
| T-S06.6 | `QA` | Test matrix: empty state, zero transactions, real-time invalidation | Backlog | [T-S06.6-qa-dashboard-tests.md](./T-S06.6-qa-dashboard-tests.md) |

## Audit Trail

| Status | Created By | Created Date | Updated By | Updated Date | Reviewed/Approved By | Review Date | Ghi chú |
|--------|-----------|---------------|-----------|---------------|------------------------|--------------|---------|
| Backlog | Senior PO | 2026-07-25 | Senior PO | 2026-07-25 | Senior PO | 2026-07-25 | Đã cập nhật chi tiết PO cho Cashback Jars, Reactive UI & Error handling |

---
Index toàn backlog: [`../../../../tasks.md`](../../../../tasks.md)
