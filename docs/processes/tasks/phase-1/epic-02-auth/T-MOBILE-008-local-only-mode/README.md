# T-MOBILE-008 — Local-only mode

**Module (chủ đạo):** `MOBILE`
**Phase:** 1
**Epic:** Epic 2 — Authentication & Authorization
**Status:** Backlog
**Prototype:** — (hành vi xuyên suốt nhiều màn hình — S01 Splash, S03 Login nút "Dùng thử", S12 Profile nút Sync — không phải 1 view riêng)

## Mô tả

Cho phép user bấm "Dùng thử" (Skip) ở S03 Login → vào thẳng Dashboard (S06) mà không cần tài khoản, dữ liệu lưu SQLite cục bộ (chọn package `sqflite`/`drift` — quyết định kỹ thuật thuộc task này). Không cần đồng bộ 2 chiều lên cloud trong Phase 1 (đó là Phase 2), nhưng schema local phải tương thích để nâng cấp sau mà không mất dữ liệu.

## Acceptance Criteria

- [ ] Chọn xong `sqflite` hoặc `drift`, ghi rõ lý do (nhu cầu query aggregation cho Cashback Jar cần join/group phức tạp)
- [ ] Bấm "Dùng thử" ở S03 → vào Dashboard (S06) ngay, badge mode hiển thị "LOCAL GUEST" (theo đúng hành vi mô phỏng trong prototype `enterGuestMode()`)
- [ ] Toàn bộ thao tác CRUD thẻ/giao dịch ở local-only mode ghi vào SQLite, không gọi API backend
- [ ] Thoát app và mở lại → dữ liệu local-only vẫn còn (persist qua SQLite, không mất khi restart app)
- [ ] Schema SQLite local đặt tên field/table tương thích để map sang API backend khi user quyết định đăng nhập đồng bộ (không cần đặt lại tên field ở Phase 2)

## Dependencies

- **Depends On (Task):** —
- **Depends On (Phase Gate):** —

## Ref Docs

- [ARCH-DB — 3. Local Cache Schema (SQLite, Mobile)](../../../../../architecture/database.md)
- [BRD — 3.2 Local-only Mode (No Account)](../../../../../BRD.md)

## Subtasks

— (task atomic trong 1 module `MOBILE`, không tách subtask)

## Audit Trail

| Status | Created By | Created Date | Updated By | Updated Date | Reviewed/Approved By | Review Date | Ghi chú |
|--------|-----------|---------------|-----------|---------------|------------------------|--------------|---------|
| Backlog | TBD | 2026-07-25 | — | — | — | — | Không blocker cứng nhưng nên làm sau khi đã có S03 (nút "Dùng thử" nằm ở đó) |

---
Index toàn backlog: [`../../../../tasks.md`](../../../../tasks.md)
