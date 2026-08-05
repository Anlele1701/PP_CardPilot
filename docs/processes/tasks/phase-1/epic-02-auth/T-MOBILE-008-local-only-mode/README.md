# T-MOBILE-008 — Local-only mode

**Module (chủ đạo):** `MOBILE`
**Phase:** 1
**Epic:** Epic 2 — Authentication & Authorization
**Status:** In Progress
**Prototype:** — (hành vi xuyên suốt nhiều màn hình — S01 Splash, S03 Login nút "Dùng thử", S12 Profile nút Sync — không phải 1 view riêng)

## Mô tả

Cho phép user bấm `Continue as guest` ở S03 Login mà không cần tài khoản. UI
hiện chọn `AccessMode.guest`, chạy shared profile/card setup rồi vào Home và
không gọi Supabase Auth. Profile/card aggregate hiện chỉ nằm trong memory; Drift/SQLite,
restart persistence và sync vẫn chưa implement.

## Acceptance Criteria

- [x] Proposed Drift architecture documented for review (typed joins, reactive queries, transactions, generated/tested migrations)
- [x] Bấm `Continue as guest` ở S03 → shared initial setup → Home, Profile hiển thị `Guest · local-only`
- [ ] Toàn bộ thao tác CRUD thẻ/giao dịch ở local-only mode ghi vào SQLite, không gọi API backend
- [ ] Thoát app và mở lại → dữ liệu local-only vẫn còn (persist qua SQLite, không mất khi restart app)
- [x] Domain/API ↔ SQLite mapping, ID strategy, physical types, sync metadata, and v1/v2 migration boundary are documented for review

## Dependencies

- **Depends On (Task):** —
- **Depends On (Phase Gate):** —

## Ref Docs

- [ARCH-DB — 3. Local Cache Schema (SQLite, Mobile)](../../../../../architecture/database.md)
- [Mobile SQLite Architecture Proposal](../../../../../architecture/mobile-sqlite.md)
- [BRD — 3.2 Local-only Mode (No Account)](../../../../../BRD.md)

## Subtasks

— (task atomic trong 1 module `MOBILE`, không tách subtask)

## Audit Trail

| Status | Created By | Created Date | Updated By | Updated Date | Reviewed/Approved By | Review Date | Ghi chú |
|--------|-----------|---------------|-----------|---------------|------------------------|--------------|---------|
| Backlog | TBD | 2026-07-25 | — | — | — | — | Không blocker cứng nhưng nên làm sau khi đã có S03 (nút "Dùng thử" nằm ở đó) |
| In Progress | CardPilot Team | 2026-07-25 | CardPilot Team | 2026-08-02 | — | — | Guest UI/setup complete; SQLite persistence remains |
| In Progress | CardPilot Team | 2026-07-25 | CardPilot Team | 2026-08-03 | — | — | Drift/SQLite schema, sync contracts, migrations, tests, and delivery slices proposed for review |

---
Index toàn backlog: [`../../../../tasks.md`](../../../../tasks.md)
