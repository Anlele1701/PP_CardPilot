# Documentation Templates

Mọi tài liệu thật trong `docs/` phải có 1 template tương ứng tại đây trước khi được viết. Khi thêm 1 loại tài liệu mới, tạo template trước, review cấu trúc, rồi mới viết nội dung.

## Mapping: Template → Tài liệu thật

| Template | Tài liệu thật | Mục đích |
|----------|----------------|----------|
| [BRD-template.md](./BRD-template.md) | [`../BRD.md`](../BRD.md) | Business Requirements — tại sao sản phẩm tồn tại |
| [PRD-template.md](./PRD-template.md) | [`../PRD.md`](../PRD.md) | Product Requirements — sản phẩm làm gì (module/flow) |
| [SRS-template.md](./SRS-template.md) | [`../SRS.md`](../SRS.md) | Software Requirements — FR/NFR có thể test được |
| [architecture/system-template.md](./architecture/system-template.md) | [`../architecture/system.md`](../architecture/system.md) | Kiến trúc toàn hệ thống (bird-eye view) |
| [architecture/api-template.md](./architecture/api-template.md) | [`../architecture/api.md`](../architecture/api.md) | Đặc tả REST API request/response |
| [architecture/database-template.md](./architecture/database-template.md) | [`../architecture/database.md`](../architecture/database.md) | ERD + table definitions (PostgreSQL + SQLite cache) |
| [architecture/design-system-template.md](./architecture/design-system-template.md) | [`../architecture/design-system.md`](../architecture/design-system.md) | Design tokens + component inventory (`cardpilot_ui`) |
| [architecture/ai-template.md](./architecture/ai-template.md) | [`../architecture/ai.md`](../architecture/ai.md) | Roadmap AI/ML (OCR, forecasting, recommendation) |
| [processes/deployment-phases-overview-template.md](./processes/deployment-phases-overview-template.md) | [`../processes/deployment-phases.md`](../processes/deployment-phases.md) | Roadmap tổng quan theo phase |
| [processes/phase-detail-template.md](./processes/phase-detail-template.md) | [`../processes/deployment/deployment-phase-N.md`](../processes/deployment/) | Chi tiết task/screen/API/ERD của 1 phase |
| [processes/devops-cicd-template.md](./processes/devops-cicd-template.md) | [`../processes/devops-cicd.md`](../processes/devops-cicd.md) | CI/CD pipeline, infra, secrets thật đang chạy |

`docs/GIT_BRANCHING_STRATEGY.md` và `docs/GIT_COMMIT_CONVENTIONS.md` đã có sẵn từ trước và không cần template riêng — chúng tự đủ ngắn gọn và ổn định để không cần khuôn mẫu.

## Quy tắc chung cho mọi template

1. **Không bịa dữ liệu.** Số liệu kinh doanh chưa xác nhận → `TBD`/`Draft`. Field/API/schema phải khớp với code thật trong repo, không suy đoán.
2. **Phân biệt rõ hiện trạng vs. kế hoạch.** Mọi tài liệu phải nêu rõ phần nào đã implement (grounded trong code) và phần nào là roadmap/WIP.
3. **Tài liệu tương ứng phải bám sát cấu trúc template** — nếu cần lệch cấu trúc cho phù hợp nội dung, cân nhắc sửa template trước, rồi mới cập nhật tài liệu thật, để cả hai không rời nhau.
4. **Cross-reference bằng ID/section number** — dùng quy ước `BRD #6.2`, `SRS FR-AUTH-03`, `ARCH-DB #2.2` giống cách `processes/phase-detail-template.md` mô tả.
