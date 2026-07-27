# Template: processes/devops-cicd.md (DevOps & CI/CD Document)

> File này quy định cấu trúc cho `docs/processes/devops-cicd.md`.
> Mục tiêu: tài liệu hoá pipeline CI/CD, infra, và secrets handling **thật đang chạy** — mọi thứ ở đây phải verify được bằng cách đọc `.github/workflows/`, `compose.yaml`, `Dockerfile` thật.

---

## Cấu trúc bắt buộc

```markdown
# DevOps & CI/CD Document
# {Tên dự án} - {Mô tả 1 dòng}

**Version:** {X.X}
**Date:** {YYYY-MM-DD}

---

## 1. Infrastructure Overview

| Component | Hiện tại | Ghi chú |
|-----------|---------|---------|
| Local dev infra | ... | file thật: `compose.yaml` |
| Backend hosting | ... | ... |
| Backend image registry | ... | ... |
| Mobile UI preview hosting | ... | ... |
| Database | ... | ... |

## 2. Local Development Setup

### 2.1 Docker Compose
<!-- Copy service definitions THẬT từ compose.yaml, không thêm service chưa tồn tại -->

### 2.2 Dockerfile
<!-- Mô tả build stages thật -->

## 3. CI/CD Pipelines
<!-- 1 section cho mỗi workflow file thật trong .github/workflows/ -->

### 3.1 {workflow-file-name.yml}
| Trigger | Job(s) | Mô tả |
|---------|--------|--------|
| ... | ... | ... |

<!-- Lặp lại cho mỗi workflow. Nếu 1 workflow không có test/lint step, ghi rõ "Không chạy test/lint — chỉ build & deploy" thay vì giả định nó có -->

## 4. Git Hooks (Husky)
| Hook | Chạy gì |
|------|---------|
| pre-commit | ... |
| commit-msg | ... |

## 5. Environment & Secrets Management

| Biến | Dùng ở đâu | Bắt buộc | Ghi chú |
|------|-----------|----------|---------|
| ... | ... | ... | ... |

<!-- Nếu README hoặc tài liệu khác mô tả 1 cơ chế (VD: encryption tool) KHÔNG khớp với những gì thật sự có trong package.json/dependencies, ghi rõ mục "Known Documentation Gaps" bên dưới thay vì lặp lại mô tả sai -->

### Known Documentation Gaps
<!-- "—" nếu không có gì lệch -->

## 6. Disaster Recovery / Backup
<!-- Nếu chưa có chiến lược backup thật ngoài managed-service mặc định (VD: Supabase), ghi rõ "Dựa vào backup mặc định của {provider} — chưa có quy trình riêng" -->
```

---

## Quy tắc viết

1. **Mọi thông tin trong tài liệu này phải verify được bằng cách đọc file thật** (`.github/workflows/*.yml`, `compose.yaml`, `Dockerfile`, `.husky/*`, `package.json` scripts) — không mô tả pipeline "nên có" như thể đã tồn tại.
2. Khi phát hiện tài liệu khác (README, v.v.) mô tả sai lệch so với thực tế code (VD: nhắc tới script không tồn tại trong `package.json`), PHẢI ghi vào mục **Known Documentation Gaps** — không âm thầm bỏ qua và cũng không tự ý "sửa cho đúng" nếu chưa xác nhận với người giữ tài liệu gốc.
3. Không thêm bước pipeline (test/lint/security-scan) nếu workflow thật không có bước đó — nếu thiếu, đó là input tốt cho mục Risks/Backlog ở tài liệu khác, không phải lý do để viết sai ở đây.
4. Bảng Environment & Secrets phải liệt kê đúng biến từ `.env.example` + biến đọc trong code (`process.env.X`) — không thêm biến giả định.
