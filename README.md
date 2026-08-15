# CardPilot Monorepo (Nx)

This repo uses **Nx** to manage:

- `cardpilot-backend` — NestJS backend (`apps/cardpilot-backend`)
- `cardpilot-ocr-service` — Vietnamese receipt OCR service (`apps/cardpilot-ocr-service`)
- `cardpilot-app` — Flutter app (`apps/cardpilot-mobile/apps/cardpilot_app`)
- `cardpilot-widgetbook` — UI preview app (`apps/cardpilot-mobile/apps/cardpilot_widgetbook`)
- `cardpilot-ui` — shared UI package (`apps/cardpilot-mobile/packages/cardpilot_ui`)

## Prerequisites

| Requirement | Recommended   | Check               |
| ----------- | ------------- | ------------------- |
| Node.js     | **22.x**      | `node -v`           |
| pnpm        | **10.28.0**   | `pnpm -v`           |
| Flutter SDK | **3.41.9**    | `flutter --version` |
| Docker      | latest        | `docker --version`  |
| Python      | **3.10–3.12** | `python3 --version` |

## Quickstart

### 1. Clone the repository

```bash
git clone https://github.com/Anlele1701/PP_CardPilot.git
cd PP_CardPilot
```

### 2. Set up Node.js + pnpm

```bash
corepack enable
corepack prepare pnpm@10.28.0 --activate

# pr
npm install -g pnpm@10.28.0
```

### 3. Install dependencies

```bash
pnpm install
```

### 4. Setup envinronemnt variables

Will be using encrypted,
Need `.env.keys` file in the repo root. Get from owner host.

```bash
pnpm encrypt
```

### 5. Infrastructure setup

```bash
pnpm infra
pnpm migration:run
```

This launches the infrastructure stack and applies pending database migrations.
The bank and merchant category code reference data is included in a data
migration, so each database receives it exactly once.

| Service     | Ports |
| ----------- | ----- |
| Postgres    | 5432  |
| OCR service | 8080  |

### 6. Start development

Dev picker (select services with `space`), then Nx will open its built-in Terminal UI:

```bash
pnpm dev
```

Run everything directly (no picker):

```bash
pnpm run dev:all
```

This launches the `CardPilot Dev CLI`, an interactive CLI for running services.
Backend (NestJS):

```bash
pnpm dev:backend
```

OCR service only:

```bash
pnpm dev:ocr
```

The first OCR build downloads approximately 1.1 GB of model checkpoints. Later
runs reuse Docker layers. Open `http://localhost:8080/docs` to submit a receipt.

### Mobile authentication configuration

The Flutter app currently authenticates directly with Supabase Auth. Create the
ignored file `apps/cardpilot-mobile/apps/cardpilot_app/.env` locally:

```dotenv
API_BASE_URL=https://cardpilot-backend.onrender.com
OCR_BASE_URL=http://localhost:3001
SUPABASE_URL=https://PROJECT_REF.supabase.co
SUPABASE_PUBLISHABLE_KEY=YOUR_PUBLISHABLE_KEY
```

The `cardpilot-app:run` Nx target passes this file through
`--dart-define-from-file=.env`. Do not commit real environment files or keys.
Native OAuth returns to the app through
`io.cardpilot.app://login-callback/`; configure the same redirect URL in
Supabase Auth. `API_BASE_URL` is the backend origin without the `/api` suffix;
the reusable mobile API client adds versioned paths such as `/api/v1/banks`.
`OCR_BASE_URL` points to the FastAPI OCR origin. Use `http://localhost:3001` for
the iOS Simulator and `http://10.0.2.2:3001` for the Android Emulator when the
service runs on the development Mac.

## Useful Nx commands

```bash
pnpm nx graph
pnpm nx show projects
pnpm nx serve cardpilot-backend
pnpm nx run cardpilot-ocr-service:serve
pnpm nx run cardpilot-ocr-service:test
pnpm nx run cardpilot-app:run
```

## Further Reading

| Article                                                                             | Description                                                                 |
| ----------------------------------------------------------------------------------- | --------------------------------------------------------------------------- |
| `docs/GIT_COMMIT_CONVENTIONS.md`                                                    | Conventional Commits rules enforced by Husky + Commitlint                   |
| `docs/GIT_BRANCHING_STRATEGY.md`                                                    | Branch naming + PR + release flow                                           |
| `docs/MOBILE_ARCHITECTURE.md`                                                       | Mobile architecture notes                                                   |
| `docs/BACKEND_ARCHITECTURE.md`                                                      | Backend architecture notes                                                  |
| `docs/MCC_MIGRATION_GUIDE.md`                                                       | MCC master data and reward-rule mapping workflow                            |
| `docs/CASHBACK_CALCULATION_FLOW.md`                                                 | Current local cashback calculation and persistence flow                     |
| [CardPilot_ERD](https://dbdocs.io/lethanhduyan/Card-Pilot_ERD?view=table_structure) | Database Schema                                                             |
| `docs/BRD.md`                                                                       | Business Requirements Document                                              |
| `docs/PRD.md`                                                                       | Product Requirements Document                                               |
| `docs/SRS.md`                                                                       | Software Requirements Specification                                         |
| `docs/architecture/system.md`                                                       | System architecture (bird-eye view)                                         |
| `docs/architecture/api.md`                                                          | API design (implemented + planned endpoints)                                |
| `docs/architecture/database.md`                                                     | Full ERD + table definitions (grounded in the real migration)               |
| `docs/architecture/mobile-sqlite.md`                                                | Implemented Drift schema v1 plus planned cache/sync and schema v2 evolution |
| `docs/architecture/design-system.md`                                                | `cardpilot_ui` design tokens + component inventory                          |
| `docs/architecture/ai.md`                                                           | AI/ML roadmap (OCR, forecasting, recommendation)                            |
| `docs/processes/deployment-phases.md`                                               | Phase 1/2 roadmap overview                                                  |
| `docs/processes/devops-cicd.md`                                                     | CI/CD pipelines, infra, secrets handling                                    |
| `docs/template/README.md`                                                           | Templates for every document type above                                     |
