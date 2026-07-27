# T-DATA-001 — Seed memberships

**Module (chủ đạo):** `DATA`
**Phase:** 1
**Epic:** Epic 3 — Membership & Profile
**Status:** Backlog
**Prototype:** — (không phải task màn hình — data seeding)

## Mô tả

Seed 4-5 tier (Bronze → Obsidian) vào bảng `memberships`, mỗi tier có giá trị cụ thể cho `max_cards`, `max_receipt_scans_per_month`, `max_cashback_calculations_per_month` — cần Product xác nhận con số cụ thể trước khi seed (hiện `BRD`/`SRS` chỉ nói "4-5 tier", chưa có bảng số liệu chính thức).

## Acceptance Criteria

- [ ] Có bảng số liệu cụ thể từng tier đã được Product duyệt (không tự bịa số) — đính kèm/link vào đây khi có
- [ ] Seed script tạo đúng số tier đã duyệt, chạy lại (re-run) không tạo trùng record (idempotent — dùng `upsert` theo tên tier)
- [ ] Tier thấp nhất (Bronze) là tier mặc định gán cho user mới (dùng bởi T-S04.2)
- [ ] Tên tier + giới hạn hiển thị đúng khi gọi `GET /api/memberships` (sau khi task Profile screen implement xong)

## Dependencies

- **Depends On (Task):** [T-BE-004](../../epic-02-auth/T-BE-004-consider-auth-provider/README.md)
- **Depends On (Phase Gate):** —

## Ref Docs

- [SRS — 3.2 FR-MEMBER (FR-MEMBER-01)](../../../../../SRS.md)
- [BRD — 3.1 Membership Tiers (Freemium, gamified)](../../../../../BRD.md)

## Subtasks

— (task atomic trong 1 module `DATA`, không tách subtask)

## Audit Trail

| Status | Created By | Created Date | Updated By | Updated Date | Reviewed/Approved By | Review Date | Ghi chú |
|--------|-----------|---------------|-----------|---------------|------------------------|--------------|---------|
| Backlog | TBD | 2026-07-25 | — | — | — | — | Chờ T-BE-004; BLOCKER thật sự là Product chưa chốt số liệu tier |

---
Index toàn backlog: [`../../../../tasks.md`](../../../../tasks.md)
