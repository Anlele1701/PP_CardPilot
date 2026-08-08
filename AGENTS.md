# AGENTS.md

This file contains repository-wide instructions for coding agents working on CardPilot.

## Repository overview

CardPilot is an Nx monorepo containing:

- `apps/cardpilot-backend`: NestJS + Fastify + TypeORM + PostgreSQL API.
- `apps/cardpilot-backend-e2e`: backend end-to-end tests.
- `apps/cardpilot-ocr-service`: FastAPI + PaddleOCR + VietOCR + PICK receipt OCR service.
- `apps/cardpilot-mobile/apps/cardpilot_app`: production Flutter application.
- `apps/cardpilot-mobile/apps/cardpilot_widgetbook`: Widgetbook preview application and preview-only mocks.
- `apps/cardpilot-mobile/packages/cardpilot_ui`: reusable Flutter design system and components.

## Mandatory context loading

Before planning or changing repository code, read these files completely:

- `README.md`
- Backend: `docs/BACKEND_ARCHITECTURE.md`
- Mobile: `docs/MOBILE_ARCHITECTURE.md`
- Mobile SQLite/cache/sync work: `docs/architecture/mobile-sqlite.md`
- Git conventions: `docs/GIT_COMMIT_CONVENTIONS.md`
- Branching: `docs/GIT_BRANCHING_STRATEGY.md`

Do not rely only on this `AGENTS.md`; it summarizes boundaries but does not replace the detailed documentation. Treat the documents above as the source of truth for architecture and repository workflow. If instructions conflict, follow the more specific document for its area and call out any unresolved conflict before changing code.

When new Markdown documents are added directly under `docs/`, inspect their titles and read any that apply to the task. For work that crosses backend, mobile, database, deployment, or Git workflow boundaries, reread every affected guide before implementation.

After reading the documentation:

1. Locate the existing implementation and tests for the affected area.
2. Confirm the proposed change respects the documented dependency direction and package ownership.
3. Prefer updating code to match the documented architecture. If the documentation is stale, update it in the same change and explain why.

## Toolchain

- Node.js 22.x
- pnpm 10.28.0; use pnpm, not npm or yarn.
- Nx 22.7.x; prefer Nx targets from the repository root.
- Flutter 3.41.9 stable.
- PostgreSQL for the backend; SQLite, if added, belongs to the mobile application and has its own schema/migration lifecycle.
- Python 3.10-3.12 for lightweight OCR lint/tests; the legacy ML runtime stays isolated in its Python 3.8 `linux/amd64` Docker image.
- Follow `docs/architecture/mobile-sqlite.md` for local-profile scoping, Drift
  migrations, reference-cache versioning, outbox writes, and sync contracts;
  do not copy PostgreSQL tables into Flutter without the documented mapping.

Install dependencies with `pnpm install`. Do not edit generated dependency folders such as `node_modules`, `.dart_tool`, `build`, or `dist`.

## Common commands

Run these from the repository root unless noted otherwise.

```bash
pnpm dev
pnpm dev:backend
pnpm dev:mobile
pnpm dev:ocr
pnpm infra
pnpm infra:down

pnpm nx run cardpilot-backend:lint
pnpm nx run cardpilot-backend:test
pnpm nx run cardpilot-backend:build

pnpm nx run cardpilot-ocr-service:lint
pnpm nx run cardpilot-ocr-service:test
pnpm nx run cardpilot-ocr-service:build

pnpm nx run cardpilot-app:analyze
pnpm nx run cardpilot-app:test
pnpm nx run cardpilot-widgetbook:analyze
pnpm nx run cardpilot-widgetbook:test
pnpm nx run cardpilot-ui:analyze
pnpm nx run cardpilot-ui:test

pnpm migration:show
pnpm migration:run
pnpm migration:revert
```

Use the narrowest relevant validation first. Before handing off a change, run the affected project's lint/analyze and tests, plus a production build when build or deployment behavior changed. Report anything that could not be run.

## Backend architecture

Backend code lives under `apps/cardpilot-backend/src` and follows bounded contexts with lightweight Clean Architecture and DDD.

- Put each business area under `contexts/<context-name>`.
- `presentation` handles transport and delegates to application use cases.
- `application` orchestrates use cases and depends on domain contracts.
- `domain` contains business rules and must not import NestJS, TypeORM, HTTP, or other infrastructure frameworks.
- `infrastructure` implements persistence and external integrations.
- Keep controllers thin and avoid business logic in Nest modules.
- Wire dependencies at module boundaries.

The API uses Fastify, has the global `/api` prefix, and must listen on `process.env.PORT` and host `0.0.0.0` in deployed environments. Preserve graceful shutdown hooks.

## Database and migrations

- The application runtime reads `DATABASE_URL`.
- TypeORM CLI migrations prefer `DIRECT_DATABASE_URL` and fall back to `DATABASE_URL`.
- Never commit real credentials or a `.env` file. Update `.env.example` with placeholders when adding configuration.
- Keep `synchronize: false` and `migrationsRun: false` outside deliberately isolated tests.
- Every PostgreSQL schema change must be represented by a TypeORM migration under `apps/cardpilot-backend/src/database/migrations`.
- Do not edit an already-applied migration to change production schema. Add a new migration.
- Review both `up` and `down` paths and avoid destructive schema/data changes unless the user explicitly requests them.
- Use the session-pooler URL for the deployed runtime when required; use the direct Supabase connection for migrations.

`pnpm infra` starts the local PostgreSQL container. Do not tear down its named volume unless the user explicitly asks to delete local database data.

## Flutter boundaries

### Production app

`cardpilot_app` owns app composition, routing, Riverpod providers, feature state, data access, use cases, repositories, and full product screens.

Feature dependencies should flow inward:

```text
presentation -> domain <- data
```

- Views render state and delegate actions.
- Domain code must not import Flutter UI, Riverpod, HTTP clients, or persistence libraries.
- Data models map external data into domain entities.
- Views must not call data sources directly.

### Shared UI package

`cardpilot_ui` is the source of truth for reusable visual primitives.

- Put tokens and themes in `lib/src/theme`.
- Put reusable widgets in `lib/src/components`.
- Export intended public APIs from `lib/cardpilot_ui.dart`.
- Components accept plain values and callbacks.
- Do not add routing, Riverpod, repositories, API calls, feature workflows, product screens, or preview mock data here.

### Widgetbook

`cardpilot_widgetbook` owns component use cases, preview-only mocks, and local screen-like compositions.

- Keep mock data under `lib/mocks`.
- Import and exercise public APIs from `cardpilot_ui` rather than reaching into its `lib/src` internals.
- When adding or changing a reusable component, update its Widgetbook use cases for important states such as enabled, disabled, loading, empty, and error where applicable.
- Do not move production state management or data access into Widgetbook.

## Code and change discipline

- Follow the existing TypeScript, Dart, ESLint, Prettier, and Flutter analyzer conventions.
- Prefer small, focused changes and preserve unrelated work in the working tree.
- Search for existing abstractions before introducing a new dependency or duplicate component.
- Add or update tests when behavior changes or a bug is fixed.
- Do not silently change public APIs, database contracts, environment variable names, ports, or routes.
- Do not commit generated build output, secrets, local IDE state, or local database files.
- Do not run destructive Git or database commands without explicit authorization.
- Do not commit, push, create a PR, or deploy unless the user explicitly requests it.

## Documentation expectations

Update documentation only when the change makes existing instructions inaccurate. Keep `README.md`, `.env.example`, and the relevant architecture guide consistent with executable commands and actual paths. Prefer comments that explain non-obvious decisions; do not add comments that merely restate code.
