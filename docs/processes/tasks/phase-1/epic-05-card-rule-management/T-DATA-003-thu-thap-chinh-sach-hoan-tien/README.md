# T-DATA-003 — Thu thập chính sách hoàn tiền

**Module (chủ đạo):** `DATA`
**Phase:** 1
**Epic:** Epic 5 — Card Rule Management
**Status:** Backlog
**Prototype:** — (không phải task màn hình — data seeding, không có UI)

## Mô tả

Thu thập thủ công rule hoàn tiền (cashback %, category/MCC áp dụng, hạn mức) của các thẻ đã seed ở `T-DATA-002`, lưu `source_url` để trace nguồn thông tin — dữ liệu tài chính hiển thị cho user, sai lệch ảnh hưởng trực tiếp tới độ tin cậy.

## Acceptance Criteria

- [ ] Mỗi rule thu thập có `source_url` trỏ tới trang chính sách công khai thật của ngân hàng/tổ chức phát hành thẻ (không bịa % hoàn tiền)
- [ ] Rule bao phủ tối thiểu các category/MCC phổ biến cho mỗi thẻ đã seed (ăn uống, mua sắm, xăng dầu — tối thiểu cụ thể: TBD, cần Product xác nhận)
- [ ] Có ghi chú ngày thu thập (chính sách hoàn tiền có thể thay đổi theo thời gian, cần biết dữ liệu "cũ" tới đâu)

## Dependencies

- **Depends On (Task):** [T-DATA-002](../../epic-04-card-management/T-DATA-002-thu-thap-banks-credit-cards/README.md)
- **Depends On (Phase Gate):** —

## Ref Docs

- [BRD — 6.6 Card Rule Management](../../../../../BRD.md)

## Subtasks

— (task atomic trong 1 module `DATA`, không tách subtask)

## Audit Trail

| Status | Created By | Created Date | Updated By | Updated Date | Reviewed/Approved By | Review Date | Ghi chú |
|--------|-----------|---------------|-----------|---------------|------------------------|--------------|---------|
| Backlog | TBD | 2026-07-25 | — | — | — | — | Chờ T-DATA-002 |

---
Index toàn backlog: [`../../../../tasks.md`](../../../../tasks.md)
