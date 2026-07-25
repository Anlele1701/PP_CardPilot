# T-S01 — Splash Screen

**Module (chủ đạo):** `MOBILE` — xem subtask cho breakdown
**Phase:** 1
**Epic:** Epic 2 — Authentication & Authorization
**Status:** Backlog
**Prototype:** [prototype.html#view-s01](../../../../../prototypes/prototype.html#view-s01) — mở file, tự nhảy tới S01 (logo CardPilot, tap để vào Onboarding)

## Mô tả

Màn hình đầu tiên khi mở app: hiển thị logo, kiểm tra trạng thái đăng nhập (token còn hạn?) hoặc dữ liệu local-only đã có sẵn (local-only mode trước đó), rồi điều hướng tới Onboarding (S02, nếu chưa từng vào app) hoặc thẳng Dashboard (S06, nếu đã đăng nhập/đã ở local-only mode).

## Acceptance Criteria

- [ ] Mở app lần đầu (chưa có token, chưa có dữ liệu local) → điều hướng tới Onboarding (S02) sau khi check xong
- [ ] Mở app đã có token hợp lệ còn hạn → điều hướng thẳng tới Dashboard (S06), bỏ qua Onboarding/Login
- [ ] Mở app đang ở local-only mode (đã từng bấm "Dùng thử" trước đó, có dữ liệu SQLite local) → điều hướng thẳng tới Dashboard (S06) ở chế độ LOCAL GUEST
- [ ] Thời gian hiển thị Splash không quá 2 giây trong điều kiện mạng bình thường (check nhanh, không block UI lâu)
- [ ] Token hết hạn → điều hướng tới Login (S03), không crash

## Dependencies

- **Depends On (Task):** [T-MOBILE-001](../T-MOBILE-001-core-network-api-client/README.md)
- **Depends On (Phase Gate):** —

## Ref Docs

- [PRD — 2.1 User Management](../../../../../PRD.md#21-user-management)
- [deployment-phase-1.md — 2. Screens (S01)](../../../../deployment/deployment-phase-1.md)

## Subtasks

| ID | Module | Subtask | Status | File |
|----|--------|---------|--------|------|
| T-S01.1 | `MOBILE` | Splash logic: check token/local data → route | Backlog | [T-S01.1-mobile-splash-logic.md](./T-S01.1-mobile-splash-logic.md) |

## Audit Trail

| Status | Created By | Created Date | Updated By | Updated Date | Reviewed/Approved By | Review Date | Ghi chú |
|--------|-----------|---------------|-----------|---------------|------------------------|--------------|---------|
| Backlog | TBD | 2026-07-25 | — | — | — | — | Chờ T-MOBILE-001 |

---
Index toàn backlog: [`../../../../tasks.md`](../../../../tasks.md)
