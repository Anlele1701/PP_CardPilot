# T-S02 — Onboarding Screen

**Module (chủ đạo):** `MOBILE` — xem subtask cho breakdown
**Phase:** 1
**Epic:** Epic 2 — Authentication & Authorization
**Status:** Ready
**Prototype:** [prototype.html#view-s02](../../../../../prototypes/prototype.html#view-s02) — mở file, tự nhảy tới S02

## Mô tả

Carousel 3 slide giới thiệu giá trị cốt lõi của app, hiển thị sau Splash (S01) nếu là lần đầu mở app.

> **⚠️ Mâu thuẫn chưa giải quyết (ghi nhận từ `PRD` #2.1 và `deployment-phase-1.md`)**: yêu cầu gốc của sản phẩm là "No onboarding screen", nhưng carousel này **đã được build** trong code hiện tại. Task này phải giải quyết mâu thuẫn đó TRƯỚC khi coi là "Done" — không chỉ là chỉnh sửa UI.

## Acceptance Criteria

- [ ] **Quyết định rõ ràng** (cần Product xác nhận): giữ carousel onboarding hay bỏ hẳn theo đúng yêu cầu gốc "No onboarding screen" — ghi quyết định + lý do vào đây trước khi đóng task
- [ ] Nếu giữ: 3 slide hiển thị đúng nội dung giá trị app, vuốt qua lại được, nút "Bỏ qua"/"Tiếp tục" hoạt động, slide cuối dẫn tới Login (S03)
- [ ] Nếu bỏ: Splash (S01) điều hướng thẳng tới Login (S03) cho user lần đầu, xoá code carousel không dùng
- [ ] Onboarding chỉ hiển thị 1 lần (lần đầu mở app) — mở lại app sau đó không thấy lại carousel

## Dependencies

- **Depends On (Task):** —
- **Depends On (Phase Gate):** —

## Ref Docs

- [PRD — 2.1 User Management (ghi nhận mâu thuẫn onboarding)](../../../../../PRD.md#21-user-management)
- [PRD — 4.1 New User Onboarding](../../../../../PRD.md)

## Subtasks

| ID | Module | Subtask | Status | File |
|----|--------|---------|--------|------|
| T-S02.1 | `MOBILE` | Carousel onboarding (giữ) hoặc gỡ bỏ + điều hướng thẳng Login | Backlog | [T-S02.1-mobile-onboarding-flow.md](./T-S02.1-mobile-onboarding-flow.md) |

## Audit Trail

| Status | Created By | Created Date | Updated By | Updated Date | Reviewed/Approved By | Review Date | Ghi chú |
|--------|-----------|---------------|-----------|---------------|------------------------|--------------|---------|
| Ready | TBD | 2026-07-25 | — | — | — | — | Quyết định team cần chốt sớm — không có blocker kỹ thuật để bắt đầu thảo luận |

---
Index toàn backlog: [`../../../../tasks.md`](../../../../tasks.md)
