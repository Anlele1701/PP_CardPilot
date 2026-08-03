# DevOps & CI/CD Document
# CardPilot - Credit Card Cashback & Rewards Intelligence Platform

**Version:** 1.0
**Date:** 2026-07-22

> Toàn bộ nội dung dưới đây được verify trực tiếp từ file thật trong repo (`compose.yaml`, `Dockerfile`, `.github/workflows/*.yml`, `.husky/*`, `package.json`, `nx.json`) — không có bước nào được suy đoán.

---

## 1. Infrastructure Overview

| Component | Hiện tại | Ghi chú |
|-----------|---------|---------|
| Local dev infra | Docker Compose — chỉ 1 service `postgres` | `compose.yaml`, khởi động bằng `pnpm infra` |
| Backend hosting | Render | Deploy qua deploy hook, trigger từ CI |
| Backend image registry | Docker Hub | `<DOCKERHUB_USERNAME>/cardpilot-backend:latest` |
| Mobile UI preview hosting | Widgetbook Cloud | Deploy tự động từ nhánh `develop` |
| Database | PostgreSQL — Supabase (production), `postgres:17-alpine` container (local dev) | `.env.example` |

## 2. Local Development Setup

### 2.1 Docker Compose (`compose.yaml`)

Chỉ có **1 service**: `postgres` (image `postgres:17-alpine`, `restart: unless-stopped`):
- Env: `POSTGRES_DB=${LOCAL_POSTGRES_DB:-cardpilot}`, `POSTGRES_USER=${LOCAL_POSTGRES_USER:-cardpilot}`, `POSTGRES_PASSWORD=${LOCAL_POSTGRES_PASSWORD:-cardpilot}`
- Port: `${LOCAL_POSTGRES_PORT:-5432}:5432`
- Volume: named volume `cardpilot_postgres_data`
- Healthcheck: `pg_isready -U $POSTGRES_USER -d $POSTGRES_DB` (interval 5s, timeout 5s, retries 10, start_period 5s)

Không có service nào khác (không cache/queue/AI service) — đúng với thực trạng "chưa build gì ngoài schema" đã ghi ở `ARCH-SYS`/`ARCH-DB`.

Lệnh: `pnpm infra` (= `docker compose up -d --wait --pull missing postgres`), `pnpm infra:down`, `pnpm infra:logs`.

### 2.2 Dockerfile (backend only)

Multi-stage build, chỉ build `cardpilot-backend`:
- **Stage `builder`**: `node:22-alpine`, bật Corepack + pin `pnpm@10.28.0`, copy `package.json`/`pnpm-lock.yaml`/`pnpm-workspace.yaml`/`nx.json`/`tsconfig.base.json`/`.prettierrc`/`.prettierignore` + `apps/` (tối ưu layer cache) → `pnpm install --frozen-lockfile` → `pnpm nx build cardpilot-backend` (output `dist/apps/cardpilot-backend`).
- **Stage `runner`**: `node:22-alpine`, `NODE_ENV=production`, copy `package.json`/`pnpm-lock.yaml` đã được prune (qua Nx target `prune-lockfile`) → `pnpm install --prod --frozen-lockfile` → copy `main.js`/`main.js.map` → `EXPOSE 3000` → `CMD ["node", "main.js"]`.
- Comment trong Dockerfile xác nhận: "Render sets $PORT, Nest uses process.env.PORT || 3000".

## 3. CI/CD Pipelines

`.github/workflows/cardpilot-pipeline.yml` là entry point tự động duy nhất. Workflow
này chạy cho Pull Request nhắm tới `develop`/`main` và cho `push` tới `develop`,
sau đó phát hiện path thay đổi để chỉ gọi các reusable workflow liên quan.

### 3.1 Thứ tự và fail-fast

```text
detect changes
  -> backend check (nếu backend bị ảnh hưởng)
  -> Flutter analyze (nếu mobile bị ảnh hưởng)
  -> quality gate
  -> database migrations (push develop, nếu migration bị ảnh hưởng)
  -> backend deploy (push develop, nếu backend image bị ảnh hưởng)
  -> Widgetbook Cloud (push develop, nếu mobile bị ảnh hưởng)
```

Các job được nối bằng `needs` và điều kiện kết quả. Khi một job bắt buộc bị
failed/cancelled, toàn bộ job phía sau bị skipped; ví dụ backend check thất bại
thì Flutter analyze, migration, backend deploy và Widgetbook Cloud đều không
khởi chạy. Job không liên quan tới path thay đổi được phép `skipped` và không
chặn job liên quan tiếp theo.

Trên Pull Request, pipeline chỉ chạy quality checks; migration và deploy chỉ
được phép chạy trên event `push` tới `develop`. Branch protection cần require
check `Quality gate` để chặn merge khi lint/test/build thất bại.

### 3.2 Reusable workflows

| Workflow               | Nội dung                                                          | Trigger trực tiếp   |
| ---------------------- | ----------------------------------------------------------------- | ------------------- |
| `backend-check.yml`    | Backend lint → test → build trong một job tuần tự                 | `workflow_dispatch` |
| `flutter-analyze.yml`  | Pub get, generate Widgetbook metadata, analyze ba Flutter project | `workflow_dispatch` |
| `db-migrations.yml`    | Build backend và chạy TypeORM migrations                          | `workflow_dispatch` |
| `backend-deploy.yml`   | Build/push Docker image `:latest`, sau đó trigger Render          | `workflow_dispatch` |
| `widgetbook-cloud.yml` | Generate, analyze, test, build web và upload Widgetbook Cloud     | `workflow_dispatch` |

Mỗi workflow trên cũng khai báo `workflow_call` để pipeline điều phối. Các lần
chạy thủ công qua `workflow_dispatch` là thao tác operator độc lập và không đi
qua quality gate tự động.

## 4. Git Hooks (Husky)

| Hook | Chạy gì |
|------|---------|
| `pre-commit` | Không làm gì (`# Intentionally light. Commit message is enforced in commit-msg.` + `true`) — không lint-staged, không test, không format check khi commit |
| `commit-msg` | `pnpm commitlint --edit "$1"` — enforce Conventional Commits qua `commitlint.config.cjs` (extends `@commitlint/config-conventional`, thêm rule `scope-case` phải kebab-case) |

Kích hoạt qua `"prepare": "husky"` trong `package.json` (chạy khi `pnpm install`). Xem thêm `docs/GIT_COMMIT_CONVENTIONS.md`.

## 5. Environment & Secrets Management

| Biến | Dùng ở đâu | Bắt buộc | Ghi chú |
|------|-----------|----------|---------|
| `DATABASE_URL` | Runtime backend (`app.module.ts`, `getOrThrow`) | Có (throw nếu thiếu) | Khuyến nghị dùng Supabase session pooler URL trên Render |
| `DIRECT_DATABASE_URL` | TypeORM CLI migration (`data-source.ts`) | Có (fallback về `DATABASE_URL` nếu thiếu) | Kết nối trực tiếp Supabase, chỉ dùng cho migration |
| `PORT` | `main.ts` | Không (default `3000`) | Render tự set `$PORT` khi deploy |
| `LOCAL_POSTGRES_DB/USER/PASSWORD/PORT` | `compose.yaml` (Postgres container local) | Không (có default `cardpilot`/`cardpilot`/`cardpilot`/`5432`) | Chỉ áp dụng cho dev local |
| `DOCKERHUB_USERNAME` / `DOCKERHUB_TOKEN` | GitHub Actions secret (`backend-deploy.yml`) | Có (CI) | Đăng nhập Docker Hub để push image |
| `RENDER_DEPLOY_HOOK_URL` | GitHub Actions secret (`backend-deploy.yml`) | Có (CI) | Trigger Render redeploy |
| `WIDGETBOOK_CLOUD_API_KEY` | GitHub Actions secret (`widgetbook-cloud.yml`) | Có (CI, guard fail-fast) | Push build lên Widgetbook Cloud |
| `SUPABASE_URL` | Flutter compile-time define (`--dart-define-from-file`) | Có (mobile auth) | Project URL; không hard-code trong source |
| `SUPABASE_PUBLISHABLE_KEY` | Flutter compile-time define (`--dart-define-from-file`) | Có (mobile auth) | Publishable/anon key; không dùng service-role key trong app |

### Known Documentation Gaps

- `README.md` (bước "4. Setup environment variables") mô tả quy trình `.env.keys` + lệnh `pnpm encrypt` để giải mã biến môi trường ("Will be using encrypted... Get from owner host"). **Quy trình này không tồn tại trong code hiện tại**: không có script `encrypt` trong `package.json`, không có `@dotenvx/dotenvx`/`dotenv-vault` hay package encryption nào trong dependency tree, và `.gitignore` không hề nhắc tới `.env.keys`/`.env.vault`. Thực tế hiện tại chỉ dùng `.env` phẳng (qua `dotenv`) theo mẫu `.env.example`. Cần đội ngũ xác nhận: (a) tính năng encryption từng có nhưng đã gỡ, hay (b) README viết trước khi implement và chưa cập nhật lại. Cho tới khi xác nhận, làm theo `.env.example` thực tế, bỏ qua bước `pnpm encrypt` trong README.
- Mobile auth đã dùng Supabase. File `.env` mobile phải được cấp ở local/CI và
  truyền bằng `--dart-define-from-file`; tuyệt đối không đưa Supabase
  `service_role` key vào Flutter bundle. Backend verification secret/config vẫn
  pending cho tới khi Auth Guard được implement.

## 6. Disaster Recovery / Backup

Chưa có quy trình backup riêng ngoài cơ chế mặc định của Supabase (managed Postgres) — **TBD**, cần xác nhận tần suất/retention thật trong Supabase project dashboard trước khi có dữ liệu người dùng thật.

---

**Tài liệu liên quan:** [System Architecture](../architecture/system.md) · [Database Design](../architecture/database.md) · [Git Branching Strategy](../GIT_BRANCHING_STRATEGY.md) · [Git Commit Conventions](../GIT_COMMIT_CONVENTIONS.md)
