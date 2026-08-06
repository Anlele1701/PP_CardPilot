# CardPilot Design System

**Package:** `apps/cardpilot-mobile/packages/cardpilot_ui`

**Live preview:** Widgetbook Cloud is deployed from `develop` through
`.github/workflows/widgetbook-cloud.yml`. The project URL is managed in
Widgetbook Cloud and is not committed here.

`cardpilot_ui` is intentionally small. It contains reusable brand, component,
and theme primitives only; product screens and runtime notification behavior
belong to `cardpilot_app`.

## Design tokens

### Colors

Source: `lib/src/theme/app_colors.dart`

```dart
brandBlue   = 0xFF1D7DFF
brandGreen  = 0xFF4BC879
ink         = 0xFF102033
muted       = 0xFF65758B
surface     = 0xFFFFFFFF
darkSurface = 0xFF0D1522
skyTop      = 0xFFDFF1FF
skyBottom   = 0xFFFFFFFF
```

### Spacing

Source: `lib/src/theme/app_spacing.dart`

```dart
xs  = 4.0
sm  = 8.0
md  = 16.0
lg  = 24.0
xl  = 32.0
xxl = 48.0
```

### Theme

- Material 3 is enabled for light and dark themes.
- Both color schemes are seeded by `AppColors.brandBlue`.
- Light theme defines CardPilot `headlineLarge` and `bodyLarge` typography.
- Dark theme currently uses the Material default text theme and remains a
  known consistency gap.

## Public component inventory

| Component | Public props | Widgetbook | Notes |
|-----------|--------------|------------|-------|
| `CardPilotLogo` | `width`, `height`, `fit` | No dedicated case | Loads `assets/brandings/cardpilot_logo.svg` from the UI package with an accessibility label |
| `AppPrimaryButton` | `label`, `onPressed`, `isLoading` | Enabled, Disabled, Loading | Full-width primary action; disables interaction while loading |
| `AppFloatingNavigationBar` | `items`, `selectedIndex`, `onSelected` | Home selected, Transactions selected | Floating glass surface with logo-colored selection treatments and one optional raised primary action |
| `SocialAuthButton` | `label`, `leading`, `onPressed`, `isLoading` | Enabled, Loading | Full-width outlined provider action with a caller-supplied provider icon |

The previous onboarding illustrations, page view, pagination, and slide-data
types were removed. Onboarding is no longer part of the current app route
graph. Runtime notifications are provided by the app-owned Toastification
adapter, not by `cardpilot_ui`.

## Public barrel

Apps must import public APIs through:

```dart
import 'package:cardpilot_ui/cardpilot_ui.dart';
```

Do not import files from `cardpilot_ui/lib/src` directly. The public barrel
currently exports:

- `CardPilotLogo`;
- `AppFloatingNavigationBar` and `AppNavigationItem`;
- `AppPrimaryButton`;
- `SocialAuthButton`;
- `AppColors`;
- `AppSpacing`;
- `AppTheme`.

## Assets

The declared package asset is:

```text
assets/brandings/cardpilot_logo.svg
```

The application launcher icon is app-owned at
`cardpilot_app/assets/icon.png` and generated through
`cardpilot_app/flutter_launcher_icons.yaml`; it is not a runtime UI-package
asset.

## File structure

```text
apps/cardpilot-mobile/packages/cardpilot_ui/
  assets/
    brandings/
      cardpilot_logo.svg
  lib/
    cardpilot_ui.dart
    src/
      brand/
        cardpilot_logo.dart
      components/
        app_primary_button.dart
        social_auth_button.dart
      theme/
        app_colors.dart
        app_spacing.dart
        app_theme.dart
```

## Ownership rules

- Keep routing, Riverpod, repositories, Supabase, Toastification, and product
  workflows out of this package.
- Add public exports deliberately through `cardpilot_ui.dart`.
- Add or update Widgetbook use cases for meaningful component states.
- Keep preview mocks in `cardpilot_widgetbook`, not in this package.
- Keep app launcher assets and platform configuration in `cardpilot_app`.

## Known gaps

- Dark theme does not yet mirror the custom light-theme typography.
- `CardPilotLogo` does not yet have a dedicated Widgetbook use case.
- The package has no shared input, card, badge, or chart primitives;
  current feature screens use app-owned Material widgets until reusable APIs
  stabilize.

---

**Related:** [Mobile Architecture](../MOBILE_ARCHITECTURE.md) ·
[PRD](../PRD.md)
