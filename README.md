# CardPilot Monorepo (Nx)

This repo uses **Nx** to manage:

- `cardpilot-backend` — NestJS backend (`apps/cardpilot-backend`)
- `cardpilot-app` — Flutter app (`apps/cardpilot-mobile/apps/cardpilot_app`)
- `cardpilot-widgetbook` — UI preview app (`apps/cardpilot-mobile/apps/cardpilot_widgetbook`)
- `cardpilot-ui` — shared UI package (`apps/cardpilot-mobile/packages/cardpilot_ui`)

## Prerequisites

| Requirement | Recommended | Check               |
|-------------|-------------|---------------------|
| Node.js     | **22.x**    | `node -v`           |
| pnpm        | **10.28.0** | `pnpm -v`           |
| Flutter SDK | **3.41.9**  | `flutter --version` |
| Docker      | latest      | `docker --version`  |

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
```

This launches the infrastructure stack.

| Service  | Ports |
|----------|-------|
| Postgres | 5432  | 

### 6. Start development
Dev picker (select services with `space`), then Nx will open its built-in Terminal UI:

```bash
pnpm dev
```

Run everything directly (no picker):

```bash
pnpm run dev:all
```

This launches the ```CardPilot Dev CLI```, an interactive CLI for running services.
Backend (NestJS):

## Useful Nx commands

```bash
pnpm nx graph
pnpm nx show projects
pnpm nx serve cardpilot-backend
pnpm nx run cardpilot-app:run
```

## Further Reading
| Article                                                                             | Description                                               |
|-------------------------------------------------------------------------------------|-----------------------------------------------------------|
| `docs/GIT_COMMIT_CONVENTIONS.md`                                                    | Conventional Commits rules enforced by Husky + Commitlint |
| `docs/GIT_BRANCHING_STRATEGY.md`                                                    | Branch naming + PR + release flow                         |
| `docs/MOBILE_ARCHITECTURE.md`                                                       | Mobile architecture notes                                 |
| `docs/BACKEND_ARCHITECTURE.md`                                                      | Backend architecture notes                                |
| [CardPilot_ERD](https://dbdocs.io/lethanhduyan/Card-Pilot_ERD?view=table_structure) | Database Schema                                           |
