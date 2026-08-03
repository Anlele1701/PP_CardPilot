# CardPilot Mobile Architecture

CardPilot Mobile is a Flutter workspace containing a production app, a shared
UI package, and a Widgetbook preview app. Product workflows stay in the app;
only reusable visual primitives belong to `cardpilot_ui`.

## Current implementation status

The current app starts at Sign in and supports:

- email/password sign-in and sign-up through Supabase Auth;
- Google and Facebook OAuth through Supabase Auth;
- persisted Supabase sessions and deep-link return through
  `io.cardpilot.app://login-callback/`;
- local guest entry from Sign in or the access-choice screen;
- a shared initial setup flow for guest and authenticated users: display name,
  first card, then Home;
- a Home shell with Dashboard, Cards, Transactions, quick Add, and Profile;
- Supabase sign-out from Profile;
- reusable validation copy under `core/constants` and app notifications through
  `toastification` under `core/notifications`.

Initial setup data is still stored by an in-memory adapter. It does not survive
an app-process restart. SQLite, backend profile persistence, user-data sync,
forgot-password, and real Cards/Transactions/Dashboard APIs remain planned.

## Workspace responsibilities

### `cardpilot_app`

Owns product composition and behavior:

- `MaterialApp`, routes, lifecycle, and environment configuration;
- Riverpod providers/controllers;
- feature views, use cases, repositories, and data sources;
- Supabase Auth integration;
- future backend API, SQLite, and sync adapters;
- full product screens and feature-specific widgets.

### `cardpilot_ui`

Owns reusable visual primitives:

- `CardPilotLogo`;
- `AppPrimaryButton`;
- `SocialAuthButton`;
- colors, spacing, and light/dark themes.

Public APIs are exported by `lib/cardpilot_ui.dart`. The package must not own
routing, Riverpod, repositories, Supabase, Toastification, product workflows,
or preview-only mock data.

### `cardpilot_widgetbook`

Owns isolated previews for public `cardpilot_ui` components. Current use cases
cover enabled/disabled/loading states for `AppPrimaryButton` and
enabled/loading states for `SocialAuthButton`.

## Current folder structure

```text
apps/cardpilot-mobile/
  apps/
    cardpilot_app/
      lib/
        main.dart
        app/
          cardpilot_app.dart
        core/
          config/
          constants/
          errors/
          notifications/
          result/
          routing/
        features/
          access/
            presentation/
          auth/
            data/
            domain/
            presentation/
          initial_setup/
            data/
            domain/
            presentation/
          home/
            presentation/
    cardpilot_widgetbook/
      lib/
        main.dart
        use_cases/
  packages/
    cardpilot_ui/
      assets/
        brandings/
      lib/
        cardpilot_ui.dart
        src/
          brand/
          components/
          theme/
```

## Layer responsibilities

Feature dependencies flow inward:

```text
presentation -> domain <- data
```

### Presentation

- Views render Riverpod state and delegate user actions.
- Feature widgets may compose `cardpilot_ui` primitives.
- Views may navigate and display `AppToast`, but must not call a data source
  directly.

### Domain

- Entities contain business concepts without Flutter dependencies.
- Repository interfaces describe feature needs.
- Use cases represent actions such as email sign-in, sign-up, sign-out, and
  completing initial setup.
- Domain code must not import Flutter UI, Riverpod, Supabase, HTTP clients, or
  persistence packages.

### Data

- Data sources own external SDK or persistence calls.
- Repository implementations map SDK/API failures into `Result` and
  `AppFailure`.
- Supabase-specific classes stay in `features/auth/data`.
- Future Drift/SQLite classes stay in app data/infrastructure code, not in
  widgets or `cardpilot_ui`.

## Core responsibilities

| Folder | Current responsibility |
|--------|------------------------|
| `config/` | `AppConfig`, Supabase dart-defines, OAuth redirect URL |
| `constants/` | Shared validation messages |
| `errors/` | App-level failure representation |
| `notifications/` | `AppToast`, a thin app adapter over `toastification` |
| `result/` | Typed success/failure result wrapper |
| `routing/` | Named routes and route generation |

The current named routes are:

```text
/access
/login
/sign-up
/setup/profile
/setup/card
/home
/error
```

The initial route is `/login`. The removed onboarding carousel is no longer in
the application route graph.

## Authentication flow

```text
SignInScreen / SignUpScreen
  -> LoginController
  -> auth use case
  -> AuthRepository
  -> SupabaseAuthDataSource
  -> Supabase Auth
```

Supported credential flows:

- Email/password sign-in uses `signInWithPassword`.
- Email/password sign-up uses `signUp`; when email confirmation is required,
  the app shows a success toast and waits for the confirmation link.
- Google/Facebook use Supabase OAuth. On native platforms the provider opens an
  external browser and returns through the CardPilot deep link.
- `AuthSessionRedirector` observes Supabase auth-state changes and moves a
  valid session into authenticated initial setup.
- Profile sign-out calls Supabase `signOut()` through a dedicated use case and
  clears the navigation stack back to Sign in.

`supabase_flutter` persists the authentication session on device. This is
separate from CardPilot profile/business persistence, which is not yet backed
by SQLite or the NestJS API.

The mobile app currently authenticates directly with Supabase. The NestJS
backend still needs token verification/authorization and a bootstrap endpoint
to create or load the CardPilot `users` profile before user-owned cloud data is
enabled.

## Guest and shared initial setup

Guest and authenticated users share one setup workflow:

```text
Guest
  Sign in -> Continue as guest -> AccessMode.guest

Authenticated
  Supabase session -> AccessMode.authenticated

Both
  Profile setup -> First-card setup -> Home shell
```

`InitialSetupController` is intentionally not auto-disposed so its workspace
survives navigation into Home. `InitialSetupMemoryDataSource` is a temporary
adapter. Replacing it with Drift must not move persistence concerns into the
controller or screens.

## Notifications and validation

- Reusable validation text lives in
  `core/constants/validation_messages.dart`.
- Feature validators return those shared messages.
- Runtime success/error/info notifications use `AppToast`, backed by
  `toastification` with a consistent top-center, flat-colored presentation.
- Toastification is an app dependency, not a design-system component, so it is
  not exported from `cardpilot_ui` or previewed in Widgetbook.

## Local persistence and sync direction

SQLite is planned but not installed. The reviewed implementation proposal uses
Drift, one installation database, strict workspace scoping, reference-data
snapshots, and a transactional outbox:

```text
UI -> repository -> SQLite
                  ^
                  |
             sync service <-> NestJS API
```

The UI should read local repositories whether online or offline. A future sync
service will refresh reference data and upload guest/user mutations. PostgreSQL
and SQLite have separate migration lifecycles; the device schema maps shared
business identifiers while also owning workspaces, cache metadata, tombstones,
and outbox state that do not belong in PostgreSQL.

The implementation source of truth for this planned area is
[`docs/architecture/mobile-sqlite.md`](./architecture/mobile-sqlite.md). It
defines schema v1/v2, folder ownership, startup routing, ETag refresh, guest
claim, conflict handling, migration workflow, tests, and delivery slices.

## Shared UI rules

- Components accept plain values and callbacks.
- Components may depend on Flutter and `cardpilot_ui` tokens.
- Components must not fetch data, navigate, read providers, or know app routes.
- Full screens and feature-specific form widgets stay in `cardpilot_app`.
- Preview-only compositions and mocks stay in `cardpilot_widgetbook`.
- Add/update Widgetbook use cases whenever a public UI component gains an
  important state.

## Testing

Current coverage includes:

- auth use-case and widget tests;
- sign-in/sign-up form and guest-transition tests;
- shared initial-setup flow tests;
- Home/Profile logout tests;
- Toastification adapter tests;
- shared UI component tests;
- Widgetbook startup tests.

Run checks from the repository root:

```bash
pnpm nx run cardpilot-app:analyze
pnpm nx run cardpilot-app:test
pnpm nx run cardpilot-ui:analyze
pnpm nx run cardpilot-ui:test
pnpm nx run cardpilot-widgetbook:analyze
pnpm nx run cardpilot-widgetbook:test
```

## Adding a mobile feature

1. Create `features/<feature_name>` in `cardpilot_app`.
2. Define domain entities, repository contracts, and use cases.
3. Implement data sources/repositories for Supabase, backend API, or SQLite.
4. Wire dependencies with Riverpod.
5. Keep views declarative and delegate actions to controllers/use cases.
6. Register routes if the feature owns a full screen.
7. Move only broadly reusable visuals into `cardpilot_ui`.
8. Add Widgetbook use cases for public shared components.
9. Add narrow tests, then run the affected Nx analyze/test targets.
