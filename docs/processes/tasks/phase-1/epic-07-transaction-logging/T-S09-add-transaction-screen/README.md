# T-S09 — Add Transaction Screen

**Module (chủ đạo):** `MOBILE` — xem subtask cho breakdown (BE/AI/MOBILE/QA)
**Phase:** 1
**Epic:** Epic 7 — Transaction Logging
**Status:** Backlog
**Prototype:** [prototype.html#view-s09](../../../../../prototypes/prototype.html#view-s09) — mở file, tự nhảy tới S09 (Ghi log + Auto MCC + Realtime Cashback)

## Mô tả

**Ghi giao dịch & Gợi ý thẻ tối ưu (Killer Feature):**
Đây là tính năng cốt lõi giúp CardPilot chinh phục người dùng. Khi người dùng chuẩn bị chi tiêu hoặc vừa quẹt thẻ, họ mở màn hình `S09` để nhập số tiền (VD: `500,000đ`) và Tên thương nhân (VD: `"Shopee"`, `"Highlands Coffee"`, `"Grab"`, `"Winmart"`).

Hệ thống sẽ đồng thời:
1. Gợi ý tự động ngành hàng (MCC Code) thông qua AI Pipeline (`T-AI-001`).
2. Quét toàn bộ danh sách thẻ của User và tự động gợi ý **Thẻ mang lại Hoàn tiền (Cashback) cao nhất** kèm số tiền hoàn ước tính realtime ngay trên giao diện form trước khi người dùng bấm Lưu.
3. Khi bấm Lưu, giao dịch được ghi lại, cập nhật ngay vào Hũ hoàn tiền (Cashback Jar) trên Dashboard (`S06`).

## Acceptance Criteria & Edge Cases

- [ ] **Khởi tạo Form & Validate Thẻ:** Nếu User chưa có thẻ nào trong tài khoản (cả Server & Local), điều hướng nhẹ nhàng sang Màn hình Thêm Thẻ (`S07`) kèm thông báo: *"Bạn cần thêm ít nhất 1 thẻ tín dụng để ghi nhận giao dịch và nhận gợi ý hoàn tiền."*
- [ ] **AI Auto MCC Tag:** Khi người dùng nhập/thay đổi tên Merchant (debounce 300ms), tự động gọi AI lookup trả về MCC Tag (VD: `5812 - Ẩm thực`) hiển thị badge trực tiếp trên form (giống `txn-mcc-tag` trong Prototype).
- [ ] **Realtime Cashback Preview:** Khi người dùng nhập Số tiền và Chọn Thẻ (hoặc chọn Gợi ý Thẻ tối ưu từ hệ thống), giao diện tính toán & hiển thị ngay số tiền hoàn ước tính (VD: `+75,000đ hoàn tiền (15%)`).
- [ ] **Smart Card Recommendation Badge:** Tự động gắn badge ⭐ *"NÊN DÙNG THẺ NÀY"* bên cạnh dòng thẻ mang lại cashback tối đa và chưa vượt hạn mức hoàn tiền tháng này.
- [ ] **Validate Input:** Số tiền phải `> 0`. Ngày giao dịch mặc định là Hôm nay (không cho chọn ngày tương lai).
- [ ] **Offline / Guest Mode Support:** Nếu đang ở Local Guest Mode hoặc mất kết nối mạng, giao dịch được lưu trực tiếp vào cơ sở dữ liệu local (SQLite/Hive) và đưa vào hàng chờ Sync (Sync Queue).
- [ ] **Bảo mật & Phân quyền Backend:** Backend validate nghiêm ngặt `user_card_id` phải thuộc về chính `user_id` đang gọi API (ngăn ngừa IDOR vulnerability).

## Dependencies

- **Depends On (Task):** [T-S07.2](../../epic-04-card-management/T-S07-add-edit-card-screen/T-S07.2-be-create-update-user-cards.md), [T-AI-001](../../epic-06-mcc-management/T-AI-001-merchant-lookup-normalize/README.md)
- **Depends On (Phase Gate):** —

## Ref Docs

- [SRS — 3.7 FR-TXN (FR-TXN-01, 02, 03)](../../../../../SRS.md)
- [PRD — 2.3 Transaction Logging](../../../../../PRD.md#23-transaction-logging)
- [ARCH-MOBILE — Feature Layer & Network Client](../../../../../MOBILE_ARCHITECTURE.md#features)

## Subtasks

| ID | Module | Subtask | Status | File |
|----|--------|---------|--------|------|
| T-S09.1 | `BE` | POST /api/transactions — API tạo giao dịch & tính cashback chính thức | Backlog | [T-S09.1-be-post-transactions.md](./T-S09.1-be-post-transactions.md) |
| T-S09.2 | `AI` | MCC auto-inference — Gợi ý MCC từ tên thương nhân tiếng Việt | Backlog | [T-S09.2-ai-mcc-auto-inference.md](./T-S09.2-ai-mcc-auto-inference.md) |
| T-S09.3 | `BE` | Cashback calculation engine — Thuật toán quét rule & cap tháng | Backlog | [T-S09.3-be-cashback-calculation.md](./T-S09.3-be-cashback-calculation.md) |
| T-S09.4 | `MOBILE` | Add Transaction screen UI/logic (realtime preview + local queue) | Backlog | [T-S09.4-mobile-add-transaction-screen.md](./T-S09.4-mobile-add-transaction-screen.md) |
| T-S09.5 | `QA` | Test matrix: amount invalid, cashback cap hit, MCC fallback, offline mode | Backlog | [T-S09.5-qa-add-transaction-tests.md](./T-S09.5-qa-add-transaction-tests.md) |

## Audit Trail

| Status | Created By | Created Date | Updated By | Updated Date | Reviewed/Approved By | Review Date | Ghi chú |
|--------|-----------|---------------|-----------|---------------|------------------------|--------------|---------|
| Backlog | Senior PO | 2026-07-25 | Senior PO | 2026-07-25 | Senior PO | 2026-07-25 | Đã bổ sung chi tiết ngữ cảnh PO, Offline mode, Security IDOR check |

---
Index toàn backlog: [`../../../../tasks.md`](../../../../tasks.md)
