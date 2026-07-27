# T-DEVOPS-001 — CI trên Pull Request

**Module (chủ đạo):** `DEVOPS`
**Phase:** 1
**Epic:** Epic 1 — Infrastructure & DevOps Hardening
**Status:** Ready
**Prototype:** — (không phải task màn hình)

## Mô tả

Thêm 1 GitHub Actions workflow mới (`.github/workflows/ci.yml` hoặc tương tự) chạy trên trigger `pull_request` (target `develop`/`main`), gồm 3 bước tuần tự: `pnpm lint` → `pnpm run test` → `pnpm run build`. Hiện tại repo chỉ có 2 workflow (`backend-deploy.yml`, `widgetbook-cloud.yml`) và cả hai chỉ chạy trên `push` vào `develop` — nghĩa là không có bước nào tự động chặn PR có lỗi lint/test/build trước khi merge.

## Acceptance Criteria

- [ ] Workflow mới trigger đúng trên `pull_request` nhắm tới `develop` và `main` — không trigger trên các nhánh khác
- [ ] Job fail (exit code ≠ 0) ở bất kỳ bước nào trong `pnpm lint`/`pnpm run test`/`pnpm run build` → PR hiển thị check "failed", không cho merge nếu branch protection bật required check
- [ ] Cả 2 project (`cardpilot-backend`, `cardpilot-mobile`) đều được lint/test/build trong workflow này (không chỉ backend)
- [ ] Không phá vỡ 2 workflow deploy hiện có (`backend-deploy.yml`, `widgetbook-cloud.yml`) — vẫn chạy đúng như cũ trên `push` tới `develop`

## Dependencies

- **Depends On (Task):** —
- **Depends On (Phase Gate):** —

## Ref Docs

- [PROC-CICD — Known Gap: chưa có CI trên Pull Request](../../../../../processes/devops-cicd.md)
- [SRS — NFR-MAINT-04](../../../../../SRS.md)

## Subtasks

— (task này atomic trong 1 module `DEVOPS`, không tách subtask)

## Audit Trail

| Status | Created By | Created Date | Updated By | Updated Date | Reviewed/Approved By | Review Date | Ghi chú |
|--------|-----------|---------------|-----------|---------------|------------------------|--------------|---------|
| Ready | TBD | 2026-07-25 | — | — | — | — | Không có blocker kỹ thuật — cần Tech Lead gán owner |

---
Index toàn backlog: [`../../../../tasks.md`](../../../../tasks.md)
