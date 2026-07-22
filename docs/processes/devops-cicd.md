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

Chỉ có **2 workflow** trong `.github/workflows/` — cả hai đều là **deploy pipeline trên nhánh `develop`**, không có workflow lint/test chạy trên Pull Request.

### 3.1 `backend-deploy.yml` ("Build & Push Backend Image")

| Trigger | Job | Mô tả |
|---------|-----|--------|
| `push` to `develop` (path-filtered: `apps/cardpilot-backend/**`, `Dockerfile`, `package.json`, `pnpm-lock.yaml`, `nx.json`, `tsconfig.base.json`) + `workflow_dispatch` | `docker` | 1) Checkout → 2) Setup Buildx → 3) Login Docker Hub (`DOCKERHUB_USERNAME`/`DOCKERHUB_TOKEN`) → 4) Build & push image, tag **`:latest`** duy nhất (không có tag theo commit SHA/semver) → 5) POST tới `RENDER_DEPLOY_HOOK_URL` để trigger deploy trên Render |

> **Lưu ý phát hiện được**: path filter của workflow này tham chiếu tới `.github/workflows/dockerhub-backend.yml` — file này **không tồn tại** trong repo (workflow thật tên là `backend-deploy.yml`). Đây là dấu vết còn sót lại từ lần đổi tên file trước đó — không ảnh hưởng chức năng (path filter đó chỉ là 1 điều kiện trigger dư, không gây lỗi) nhưng nên dọn lại cho rõ ràng.

### 3.2 `widgetbook-cloud.yml` ("Deploy Widgetbook Cloud")

| Trigger | Job | Mô tả |
|---------|-----|--------|
| `push` to `develop` (path-filtered: `apps/cardpilot-mobile/**`) + `workflow_dispatch` | `build-and-deploy` (timeout 20 phút, concurrency group huỷ run cũ) | 1) Checkout (`fetch-depth: 0`) → 2) Setup Flutter `3.41.9` (stable, cache) → 3) `flutter pub get` → 4) `dart run build_runner build` → 5) `flutter analyze` → 6) `flutter test` → 7) `flutter build web --release` → 8) Activate `widgetbook_cli 3.15.0` → 9) Push build lên Widgetbook Cloud (`WIDGETBOOK_CLOUD_API_KEY`, guard fail-fast nếu thiếu secret) |

**Nhận xét**: đây là workflow duy nhất hiện tại có chạy `analyze`/`test` — nhưng chỉ cho mục đích build Widgetbook, không phải một CI gate riêng cho chất lượng code trước khi merge PR.

### Known Gap — chưa có CI trên Pull Request

Không có workflow nào chạy khi mở PR (`pull_request` trigger) — nghĩa là `pnpm lint`/`pnpm test`/`pnpm build` không tự động chạy trước khi merge. Việc đảm bảo chất lượng code trước merge hiện phụ thuộc hoàn toàn vào review thủ công + git hook `commit-msg` (xem mục 4). Đây là backlog rõ ràng nên cân nhắc sớm — xem `SRS` NFR-MAINT-04.

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

### Known Documentation Gaps

- `README.md` (bước "4. Setup environment variables") mô tả quy trình `.env.keys` + lệnh `pnpm encrypt` để giải mã biến môi trường ("Will be using encrypted... Get from owner host"). **Quy trình này không tồn tại trong code hiện tại**: không có script `encrypt` trong `package.json`, không có `@dotenvx/dotenvx`/`dotenv-vault` hay package encryption nào trong dependency tree, và `.gitignore` không hề nhắc tới `.env.keys`/`.env.vault`. Thực tế hiện tại chỉ dùng `.env` phẳng (qua `dotenv`) theo mẫu `.env.example`. Cần đội ngũ xác nhận: (a) tính năng encryption từng có nhưng đã gỡ, hay (b) README viết trước khi implement và chưa cập nhật lại. Cho tới khi xác nhận, làm theo `.env.example` thực tế, bỏ qua bước `pnpm encrypt` trong README.
- Không có secret nào cho auth provider (JWT secret, Supabase Auth key, v.v.) — vì auth chưa được implement (xem `SRS` FR-AUTH).

## 6. Disaster Recovery / Backup

Chưa có quy trình backup riêng ngoài cơ chế mặc định của Supabase (managed Postgres) — **TBD**, cần xác nhận tần suất/retention thật trong Supabase project dashboard trước khi có dữ liệu người dùng thật.

---

**Tài liệu liên quan:** [System Architecture](../architecture/system.md) · [Database Design](../architecture/database.md) · [Git Branching Strategy](../GIT_BRANCHING_STRATEGY.md) · [Git Commit Conventions](../GIT_COMMIT_CONVENTIONS.md)
