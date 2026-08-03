# T-S12 — Profile Screen

**Module (chủ đạo):** `MOBILE` — xem subtask cho breakdown (BE/MOBILE/QA)
**Phase:** 1
**Epic:** Epic 3 — Membership & Profile
**Status:** In Progress
**Prototype:** [prototype.html#view-s12](../../../../../prototypes/prototype.html#view-s12) — mở file, tự nhảy tới S12

## Mô tả

Xem thông tin cá nhân + membership tier hiện tại, nút Đăng xuất, nút "Đăng nhập để đồng bộ" (nếu đang ở local-only mode — hành vi Sync thật thuộc Phase 2, ở Phase 1 chỉ hiển thị nút/trạng thái).

> **Current implementation:** Profile is currently a page inside the Home
> shell. It shows the in-memory setup display name, guest/signed-in state,
> Bronze placeholder, and guest sync placeholder. Authenticated logout calls
> Supabase `signOut()` through repository/use-case/controller layers, confirms
> the action, and clears navigation back to Sign in. Real profile/membership
> API data is pending.

## Acceptance Criteria

- [ ] Hiển thị đúng `full_name`, `email`, membership tier hiện tại (tên tier + hạn mức đã dùng nếu có) lấy từ `GET /api/users/me`
- [x] Authenticated user bấm "Đăng xuất" → gọi Supabase `signOut()`, xoá session local do SDK quản lý và điều hướng về Login (S03).
- [ ] Nếu đang ở local-only mode: hiển thị badge "LOCAL GUEST" và nút "Đăng nhập để đồng bộ" (chỉ hiển thị nút — hành vi bấm vào chưa cần hoàn chỉnh ở Phase 1, xem `deployment-phase-2.md` cho Sync thật)
- [ ] Bấm vào mục thông tin cá nhân → điều hướng sang Edit Profile (S13)
- [ ] Loading/error state khi `GET /api/users/me` fail (VD: mất mạng) — hiển thị retry, không crash trắng màn hình

## Dependencies

- **Depends On (Task):** [T-MOBILE-001](../../epic-02-auth/T-MOBILE-001-core-network-api-client/README.md)
- **Depends On (Phase Gate):** —

## Ref Docs

- [SRS — 3.2 FR-MEMBER](../../../../../SRS.md)
- [PRD — 2.2 User Membership Management](../../../../../PRD.md#22-user-membership-management)

## Subtasks

| ID | Module | Subtask | Status | File |
|----|--------|---------|--------|------|
| T-S12.1 | `BE` | GET /api/memberships + /api/users/me | Backlog | [T-S12.1-be-get-memberships-me.md](./T-S12.1-be-get-memberships-me.md) |
| T-S12.2 | `BE` | Custom backend logout endpoint | Not Required | [T-S12.2-be-logout-api.md](./T-S12.2-be-logout-api.md) |
| T-S12.3 | `MOBILE` | Profile screen UI/logic | In Progress | [T-S12.3-mobile-profile-screen.md](./T-S12.3-mobile-profile-screen.md) |
| T-S12.4 | `QA` | Test case: hiển thị đúng tier, logout, lỗi mạng | Backlog | [T-S12.4-qa-profile-tests.md](./T-S12.4-qa-profile-tests.md) |

## Audit Trail

| Status | Created By | Created Date | Updated By | Updated Date | Reviewed/Approved By | Review Date | Ghi chú |
|--------|-----------|---------------|-----------|---------------|------------------------|--------------|---------|
| Backlog | TBD | 2026-07-25 | — | — | — | — | Chờ T-MOBILE-001 |
| In Progress | CardPilot Team | 2026-07-25 | CardPilot Team | 2026-08-02 | — | — | Profile shell and Supabase logout implemented; real profile API pending |

---
Index toàn backlog: [`../../../../tasks.md`](../../../../tasks.md)
