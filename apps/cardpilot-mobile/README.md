# CardPilot Mobile

Flutter workspace for CardPilot’s mobile app, shared UI package, and component preview app.

## Projects

```text
apps/cardpilot-mobile/
  apps/
    cardpilot_app/         # Production Flutter app
    cardpilot_widgetbook/  # Widgetbook catalog for UI previews
  packages/
    cardpilot_ui/          # Shared design system and reusable components
```

## Responsibilities

- `cardpilot_app` owns app composition: screens, routing, feature state, data loading, and user flows.
- `cardpilot_ui` owns shared visual primitives: theme, spacing, colors, buttons, pagination, illustrations, and reusable page sections.
- `cardpilot_widgetbook` owns isolated previews for `cardpilot_ui` components and app-level mock compositions.

Keep full screens in `cardpilot_app`. The UI package should not define product screens such as `OnboardingScreen`; it should expose reusable components that app screens compose.

## Common Commands

From the repository root:

```bash
pnpm nx run cardpilot-app:run
pnpm nx run cardpilot-widgetbook:run
pnpm nx run cardpilot-app:analyze
pnpm nx run cardpilot-widgetbook:analyze
pnpm nx run cardpilot-ui:analyze
```

From an individual Flutter project:

```bash
cd apps/cardpilot-mobile/apps/cardpilot_app
flutter pub get
flutter analyze
flutter test
```

## Current Onboarding Flow

- `cardpilot_app/lib/features/onboarding/presentation/views/onboarding_screen.dart` is the app-owned screen.
- The screen reads onboarding state through Riverpod providers in `features/onboarding/onboarding_providers.dart`.
- The screen maps domain `OnboardingSlide` entities into `cardpilot_ui` `OnboardingSlideData`.
- The layout is composed from `cardpilot_ui` components such as `OnboardingPageView`, `OnboardingPagination`, and `AppPrimaryButton`.

## UI Package Rules

- Export shared components from `packages/cardpilot_ui/lib/cardpilot_ui.dart`.
- Keep reusable tokens in `src/theme/`.
- Keep reusable widgets in `src/components/`.
- Do not add navigation, Riverpod providers, backend calls, feature repositories, or app screens to `cardpilot_ui`.

## Widgetbook Rules

- Use Widgetbook to preview shared UI components in isolation.
- If a preview needs screen-like behavior, compose it locally in `cardpilot_widgetbook`; do not move that screen into `cardpilot_ui`.
- Keep mock data under `apps/cardpilot_widgetbook/lib/mocks/`.

## Widgetbook Cloud

Pushes to `develop` that change files under `apps/cardpilot-mobile/` trigger
`.github/workflows/widgetbook-cloud.yml`. The workflow generates Widgetbook
metadata, analyzes and tests the catalog, builds Flutter Web, and uploads the
result to Widgetbook Cloud.

Before enabling the workflow:

1. Import this GitHub repository as a Widgetbook Cloud project and set its
   default branch to `develop`.
2. Copy the project API key from Widgetbook Cloud.
3. Add it in GitHub under **Settings > Secrets and variables > Actions** as the
   repository secret `WIDGETBOOK_API_KEY`.
