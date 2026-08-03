# T-S02 — Onboarding Screen

**Module (chủ đạo):** `MOBILE` — xem subtask cho breakdown
**Phase:** 1
**Epic:** Epic 2 — Authentication & Authorization
**Status:** Done
**Prototype:** [prototype.html#view-s02](../../../../../prototypes/prototype.html#view-s02) — mở file, tự nhảy tới S02

## Mô tả

Quyết định sản phẩm đã được áp dụng: bỏ carousel onboarding và vào thẳng Sign
in. Code, route, shared UI onboarding components và Widgetbook cases liên quan
đã được xoá.

## Acceptance Criteria

- [x] **Quyết định rõ ràng**: bỏ carousel; app bắt đầu tại Sign in
- [ ] Nếu giữ: 3 slide hiển thị đúng nội dung giá trị app, vuốt qua lại được, nút "Bỏ qua"/"Tiếp tục" hoạt động, slide cuối dẫn tới Login (S03)
- [x] Nếu bỏ: initial route điều hướng thẳng tới Login (S03), xoá code carousel không dùng
- [x] Không còn onboarding state cần persist hoặc hiển thị lại

## Dependencies

- **Depends On (Task):** —
- **Depends On (Phase Gate):** —

## Ref Docs

- [PRD — 2.1 User Management (ghi nhận mâu thuẫn onboarding)](../../../../../PRD.md#21-user-management)
- [PRD — 4.1 New User Onboarding](../../../../../PRD.md)

## Subtasks

| ID | Module | Subtask | Status | File |
|----|--------|---------|--------|------|
| T-S02.1 | `MOBILE` | Gỡ onboarding + điều hướng thẳng Login | Done | [T-S02.1-mobile-onboarding-flow.md](./T-S02.1-mobile-onboarding-flow.md) |

## Audit Trail

| Status | Created By | Created Date | Updated By | Updated Date | Reviewed/Approved By | Review Date | Ghi chú |
|--------|-----------|---------------|-----------|---------------|------------------------|--------------|---------|
| Ready | TBD | 2026-07-25 | — | — | — | — | Quyết định team cần chốt sớm — không có blocker kỹ thuật để bắt đầu thảo luận |
| Done | CardPilot Team | 2026-07-25 | CardPilot Team | 2026-08-02 | — | — | Chọn no-onboarding; initial route là `/login` |

---
Index toàn backlog: [`../../../../tasks.md`](../../../../tasks.md)
