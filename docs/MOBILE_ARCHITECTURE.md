# CardPilot Mobile Architecture

CardPilot Mobile uses a Flutter workspace with a production app, a shared UI package, and a Widgetbook preview app. The architecture keeps product screens and feature logic in the app while keeping the shared UI package focused on reusable visual components.

## Architecture Goals

- Keep app screens separate from shared UI primitives.
- Keep UI components reusable without depending on app state, routing, or data access.
- Group product code by feature so customer-facing areas remain discoverable.
- Keep business rules and data access outside widgets.
- Use Riverpod for feature state and dependency wiring.
- Make API, cache, and AI integrations replaceable without rewriting screens.

## Workspace Structure

```text
apps/cardpilot-mobile/
  apps/
    cardpilot_app/
      lib/
        main.dart
        app/
        core/
        features/
    cardpilot_widgetbook/
      lib/
        main.dart
        mocks/
  packages/
    cardpilot_ui/
      lib/
        cardpilot_ui.dart
        src/
          components/
          theme/
```

## Project Responsibilities

### `cardpilot_app`

The production Flutter application.

- Owns `MaterialApp`, routing, feature screens, providers, and app lifecycle.
- Owns feature state, use cases, repositories, and data sources.
- Composes shared `cardpilot_ui` components into full screens.
- Maps domain entities into UI package data objects when needed.

### `cardpilot_ui`

The shared design system and component package.

- Owns design tokens such as colors, spacing, and themes.
- Owns reusable components such as buttons, pagination, illustrations, and page sections.
- Exports public UI APIs from `lib/cardpilot_ui.dart`.
- Must not own product screens, routes, Riverpod providers, repositories, backend clients, or feature workflows.

### `cardpilot_widgetbook`

The isolated preview application for shared UI work.

- Shows `cardpilot_ui` components in controlled states.
- Uses mock data from `lib/mocks/`.
- Can compose local screen-like previews, but those previews stay in Widgetbook and are not exported by `cardpilot_ui`.

## App Folder Structure

```text
apps/cardpilot-mobile/apps/cardpilot_app/lib/
  main.dart
  app/
    cardpilot_app.dart
  core/
    config/
    errors/
    result/
    routing/
  features/
    onboarding/
      onboarding_providers.dart
      data/
        datasources/
        models/
        repositories/
      domain/
        entities/
        repositories/
        usecases/
      presentation/
        views/
        widgets/
```

## Shared UI Folder Structure

```text
apps/cardpilot-mobile/packages/cardpilot_ui/lib/
  cardpilot_ui.dart
  src/
    components/
      app_primary_button.dart
      onboarding/
        onboarding_hero_illustrations.dart
        onboarding_page_view.dart
        onboarding_pagination.dart
        onboarding_slide_data.dart
    theme/
      app_colors.dart
      app_spacing.dart
      app_theme.dart
```

## Layer Responsibilities

### `main.dart`

The smallest possible entry point. It wraps the app in `ProviderScope` and starts `CardPilotApp`.

### `app/`

Owns application-level composition.

- `cardpilot_app.dart` configures `MaterialApp`, theme, routing, and app-level behavior.
- App-level wiring should stay here unless it belongs to a specific feature.

### `core/`

Shared app infrastructure used across features.

- `config/`: app name, environment constants, backend URLs, feature flags.
- `errors/`: app-level failure objects.
- `result/`: success/failure wrappers for predictable error handling.
- `routing/`: route names and route generation.

Theme and design tokens live in `cardpilot_ui`, not in app `core`, when they are reusable UI primitives.

### `features/`

Each product area gets its own folder. Most future CardPilot work should go here.

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

Each feature can use `data`, `domain`, and `presentation` layers.

## Feature Layer Details

### `presentation/`

Contains feature UI and presentation state.

- `views/`: full app screens or pages.
- `widgets/`: feature-specific widgets that are not broadly reusable.
- Feature providers/controllers: Riverpod `Notifier`, `AsyncNotifier`, or providers that expose screen state and user actions.

Views should be mostly declarative. A view observes Riverpod state, renders the current state, and delegates actions to a controller/provider.

### `domain/`

Contains business concepts and rules.

- `entities/`: pure business objects.
- `repositories/`: abstract contracts that describe what data the feature needs.
- `usecases/`: specific business actions, such as `GetOnboardingSlides`.

The domain layer should not import Flutter UI, HTTP clients, local database packages, Riverpod, or platform-specific code.

### `data/`

Contains implementation details for retrieving and saving data.

- `datasources/`: remote APIs, local storage, secure storage, cache, or static data.
- `models/`: API/database DTOs and mapping into domain entities.
- `repositories/`: concrete implementations of domain repository contracts.

The data layer can know about APIs and persistence, but views should not call data sources directly.

## Dependency Direction

Dependencies should flow inward:

```text
presentation -> domain <- data
```

In practice:

- App screens depend on Riverpod providers/controllers and shared UI components.
- Providers/controllers depend on use cases.
- Use cases depend on repository interfaces.
- Repository implementations depend on data sources.
- Data models convert into domain entities.
- App screens map domain entities into `cardpilot_ui` data objects when shared components need UI-specific input.

This keeps business logic independent from Flutter layout and keeps shared UI independent from app workflows.

## Riverpod Rules

- Use providers to wire dependencies and expose feature state.
- Prefer immutable state objects for screen state.
- Keep provider/controller logic free of widget layout concerns.
- Avoid `BuildContext` in controllers unless there is a deliberate app-level reason.
- Do not put Riverpod dependencies in `cardpilot_ui`.

The current onboarding flow uses `NotifierProvider.autoDispose` in `features/onboarding/onboarding_providers.dart`.

## UI Package Rules

- Shared UI components should accept plain values and callbacks.
- Shared UI components may depend on Flutter and `cardpilot_ui` theme tokens.
- Shared UI components should not fetch data, navigate, read providers, or know feature routes.
- Full product screens belong in `cardpilot_app`, even when most of their children come from `cardpilot_ui`.
- Screen-like previews belong in `cardpilot_widgetbook`, not in `cardpilot_ui`.

This is why onboarding has an app-owned `OnboardingScreen` and shared UI-owned `OnboardingPageView`, `OnboardingPagination`, and `AppPrimaryButton`.

## API And Backend Integration

When CardPilot starts calling the NestJS backend, add shared API infrastructure under app `core/network/`, then connect it through feature data sources.

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

The backend should return JSON over REST. The mobile app should map API models into domain entities before data reaches providers/controllers.

## AI Feature Guidance

AI-related code should not be placed directly inside random screens. Treat AI as a feature or shared app capability depending on how it is used.

If AI is a user-facing area:

```text
features/
  ai_assistant/
    data/
    domain/
    presentation/
```

If AI becomes shared infrastructure for many app features:

```text
core/
  ai/
    ai_client.dart
    ai_prompt_builder.dart
    ai_response_parser.dart
```

Prefer starting with `features/ai_assistant/`. Move only truly shared app infrastructure into `core/ai/` later. Do not put AI workflow code in `cardpilot_ui`.

## Testing Strategy

Recommended app test placement:

```text
apps/cardpilot-mobile/apps/cardpilot_app/test/
  features/
    onboarding/
      presentation/
      domain/
      data/
```

Recommended UI package test placement:

```text
apps/cardpilot-mobile/packages/cardpilot_ui/test/
```

Testing priorities:

- Use case tests for business behavior.
- Provider/controller tests for loading, error, and action states.
- Widget tests for important customer flows in `cardpilot_app`.
- Component tests for reusable widgets in `cardpilot_ui`.
- Repository tests for API mapping and failure handling.

## Naming Conventions

- App screens end with `_screen.dart`.
- Riverpod state/controller files can be grouped in `<feature>_providers.dart` while features are small.
- Use cases use verb-first names, for example `get_cards.dart`.
- Repository contracts live in `domain/repositories`.
- Repository implementations live in `data/repositories` and end with `_impl.dart`.
- API or database DTOs live in `data/models` and end with `_model.dart`.
- Shared UI components should use product-neutral component names unless the concept is intentionally reusable across app surfaces.

## When Adding A New Feature

1. Create a folder under `cardpilot_app/lib/features/<feature_name>/`.
2. Add `domain/entities` for core objects.
3. Add `domain/repositories` for required data contracts.
4. Add `domain/usecases` for business actions.
5. Add `data/models`, `data/datasources`, and `data/repositories`.
6. Add `presentation/views` for app screens.
7. Add Riverpod providers/controllers for state and dependency wiring.
8. Register routes in `core/routing`.
9. Move only broadly reusable visual pieces into `cardpilot_ui`.
10. Add Widgetbook previews for reusable UI components.
11. Add tests for use cases and providers/controllers first.

## Practical Recommendation

Keep the boundaries simple and explicit: app screens own product flows; domain owns business concepts; data owns infrastructure; `cardpilot_ui` owns reusable visuals; Widgetbook owns previews. Add abstractions only when a feature needs them.
