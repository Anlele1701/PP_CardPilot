# Backend Architecture

## Goal

The backend now follows a lightweight Clean Architecture + DDD layout inside `apps/cardpilot-backend/src`.

## Structure

```text
src/
  app/
    app.module.ts
  contexts/
    system/
      application/
      presentation/
      system.module.ts
    cards/
      application/
      domain/
      infrastructure/
      presentation/
      cards.module.ts
  shared/
    kernel/
      application/
      domain/
```

## Dependency Rule

Dependencies only move inward:

- `presentation` depends on `application`
- `application` depends on `domain`
- `infrastructure` depends on `domain` and is wired by Nest modules
- `domain` depends only on the shared kernel

`domain` must not import NestJS.
`application` can use NestJS only for orchestration concerns such as dependency injection.
`infrastructure` owns adapters such as persistence, queues, external APIs, and mappers.

## Bounded Contexts

Each business area should live under `src/contexts/<context-name>`.

Recommended shape:

```text
<context>/
  application/
    dto/
    commands/
    queries/
    use-cases/
  domain/
    entities/
    value-objects/
    repositories/
    services/
  infrastructure/
    persistence/
    messaging/
    integrations/
  presentation/
    http/
    events/
  <context>.module.ts
```

## How To Extend

1. Add a new bounded context under `src/contexts`.
2. Model invariants first in `domain`.
3. Define repository ports in `domain/repositories`.
4. Implement use cases in `application`.
5. Build adapters in `infrastructure` and wire them in the Nest module.
6. Keep controllers thin and delegate to use cases.
