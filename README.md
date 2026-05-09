# CardPilot Monorepo (Nx)

This repo uses **Nx** to manage:

- `cardpilot-backend` — NestJS backend (`apps/cardpilot-backend`)
- `cardpilot-mobile` — Flutter app (`apps/cardpilot-mobile`)

## Prereqs

- Node.js (recommended: LTS)
- Flutter SDK installed (`flutter --version`)

## Setup

```bash
pnpm install
```

## Run

Backend (NestJS):

```bash
pnpm run serve:backend
```

Mobile (Flutter):

```bash
pnpm run run:mobile
```

## Nx commands

```bash
nx graph
nx show projects
nx serve cardpilot-backend
nx run cardpilot-mobile:run
```

## Dev (Nx Terminal UI)

Dev picker (select services with `space`), then Nx will open its built-in Terminal UI:

```bash
pnpm dev
```

Run everything directly (no picker):

```bash
pnpm run dev:all
```

## Docker (Backend for Render)

Build locally:

```bash
docker build -t cardpilot-backend:local .
docker run --rm -p 3000:3000 -e PORT=3000 cardpilot-backend:local
```

Push to Docker Hub (example):

```bash
docker login
docker build -t <dockerhub_user>/cardpilot-backend:latest .
docker push <dockerhub_user>/cardpilot-backend:latest
```
