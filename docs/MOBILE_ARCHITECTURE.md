# CardPilot Mobile Architecture

CardPilot Mobile uses a feature-first MVVM architecture with lightweight Clean Architecture boundaries. The goal is to keep screens easy to build now while making the project safe to grow into many customer-facing features, API integrations, and AI-powered workflows later.

## Architecture Goals

- Keep UI code separate from business rules and data access.
- Group files by product feature so large areas stay discoverable.
- Make API, cache, and AI integrations replaceable without rewriting screens.
- Keep ViewModels testable without depending directly on Flutter widgets.
- Avoid heavy framework choices too early while leaving room to adopt Riverpod or another DI/state tool later.

## Current Folder Structure

```text
lib/
  main.dart
  app/
    cardpilot_app.dart
    app_dependencies.dart
  core/
    config/
    constants/
    errors/
    result/
    routing/
    theme/
  features/
    onboarding/
      data/
        datasources/
        models/
        repositories/
      domain/
        entities/
        repositories/
        usecases/
      presentation/
        viewmodels/
        views/
        widgets/
```

## Layer Responsibilities

### `main.dart`

The smallest possible entry point. It only starts the Flutter app.

### `app/`

Owns application-level wiring.

- `cardpilot_app.dart` configures `MaterialApp`, themes, routes, and app-level behavior.
- `app_dependencies.dart` creates dependencies and passes them into features.

For now, dependencies are wired manually. When the app grows, this file can be replaced or backed by Riverpod, GetIt, Injectable, or another dependency injection approach.

### `core/`

Shared infrastructure used across many features.

- `config/`: app name, environment constants, backend URLs, feature flags.
- `constants/`: spacing, durations, breakpoints, shared values.
- `errors/`: app-level failure objects.
- `result/`: success/failure wrappers for predictable error handling.
- `routing/`: route names and route generation.
- `theme/`: colors, typography, light/dark themes.

Keep `core/` small. If code only belongs to one feature, it should stay inside that feature instead of becoming global too early.

### `features/`

Each product area gets its own folder. This is where most future CardPilot work should go.

Examples:

```text
features/
  auth/
  onboarding/
  cards/
  transactions/
  cashback/
  ai_assistant/
  profile/
```

Each feature follows the same internal layers: `data`, `domain`, and `presentation`.

## Feature Layer Details

### `presentation/`

Contains everything related to the UI.

- `views/`: full screens or pages.
- `widgets/`: feature-specific reusable widgets.
- `viewmodels/`: MVVM state and user actions.

The View should be mostly declarative. It observes the ViewModel and renders the current state. The ViewModel handles loading, state transitions, validation, and calling use cases.

### `domain/`

Contains business concepts and rules.

- `entities/`: pure business objects.
- `repositories/`: abstract contracts that describe what data the feature needs.
- `usecases/`: specific business actions, such as `GetOnboardingSlides`.

The domain layer should not import Flutter UI, HTTP clients, local database packages, or platform-specific code.

### `data/`

Contains implementation details for retrieving and saving data.

- `datasources/`: remote APIs, local storage, secure storage, cache, or static data.
- `models/`: API/database DTOs and mapping into domain entities.
- `repositories/`: concrete implementations of domain repository contracts.

The data layer can know about APIs and persistence, but the UI should not call data sources directly.

## Dependency Direction

Dependencies should flow inward:

```text
presentation -> domain <- data
```

In practice:

- Views depend on ViewModels.
- ViewModels depend on use cases.
- Use cases depend on repository interfaces.
- Repository implementations depend on data sources.
- Data models convert into domain entities.

This keeps business logic independent from the UI and makes it easier to test or replace infrastructure later.

## MVVM Rules

- A View owns layout and user interaction widgets.
- A ViewModel owns screen state and user actions.
- A ViewModel should expose simple state fields or immutable state objects.
- A ViewModel should not know about widget layout, `BuildContext`, or navigation details unless there is a deliberate reason.
- A View should not call repositories or data sources directly.

Current state management uses `ChangeNotifier` because it is built into Flutter and keeps the initial project lightweight. If state gets more complex, prefer moving to Riverpod before ViewModels become difficult to compose.

## API And Backend Integration

When CardPilot starts calling the NestJS backend, add shared API infrastructure under `core/network/`, then connect it through feature data sources.

Suggested future structure:

```text
core/
  network/
    api_client.dart
    api_exception.dart
    auth_interceptor.dart

features/
  cards/
    data/
      datasources/
        cards_remote_data_source.dart
      models/
        card_model.dart
      repositories/
        cards_repository_impl.dart
```

The backend should return JSON over REST. The mobile app should map API models into domain entities before the data reaches ViewModels.

## AI Feature Guidance

AI-related code should not be placed directly inside random screens. Treat AI as a feature or shared capability depending on how it is used.

If AI is a user-facing area:

```text
features/
  ai_assistant/
    data/
    domain/
    presentation/
```

If AI becomes shared infrastructure for many features:

```text
core/
  ai/
    ai_client.dart
    ai_prompt_builder.dart
    ai_response_parser.dart
```

Prefer starting with `features/ai_assistant/`. Move only truly shared primitives into `core/ai/` later.

## Testing Strategy

Recommended test placement:

```text
test/
  features/
    onboarding/
      presentation/
      domain/
      data/
```

Testing priorities:

- Use case tests for business behavior.
- ViewModel tests for loading, error, and action states.
- Widget tests for important customer flows.
- Repository tests for API mapping and failure handling.

## Naming Conventions

- Screens end with `_screen.dart`.
- ViewModels end with `_view_model.dart`.
- Use cases use verb-first names, for example `get_cards.dart`.
- Repository contracts live in `domain/repositories`.
- Repository implementations live in `data/repositories` and end with `_impl.dart`.
- API or database DTOs live in `data/models` and end with `_model.dart`.

## When Adding A New Feature

1. Create a folder under `features/<feature_name>/`.
2. Add `domain/entities` for core objects.
3. Add `domain/repositories` for required data contracts.
4. Add `domain/usecases` for business actions.
5. Add `data/models`, `data/datasources`, and `data/repositories`.
6. Add `presentation/viewmodels`, `presentation/views`, and `presentation/widgets`.
7. Register dependencies in `app/app_dependencies.dart`.
8. Register routes in `core/routing`.
9. Add tests for ViewModels and use cases first.

## Practical Recommendation

This architecture is intentionally not too heavy. CardPilot is early, so the best move is to keep the boundaries clean without creating unnecessary abstractions. Add structure when a feature needs it, not before. The main rule is simple: screens should not know how data is fetched, and data sources should not know how screens are built.
