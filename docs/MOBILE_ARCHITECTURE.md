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
- a five-item Home shell with Dashboard, Cards, a centered quick Add action,
  Transactions, and Profile on a floating glass navigation bar;
- `Transactions | Merchants` sections inside the Transactions destination;
- Supabase sign-out from Profile;
- reusable validation copy under `core/constants` and app notifications through
  `toastification` under `core/notifications`.
- Drift-backed SQLite schema v1 for local profiles, installation settings,
  reference caches, user cards, outbox, and sync state;
- durable guest/authenticated initial setup and startup restoration based on
  the active guest or the current Supabase auth user ID;
- lazy bank bootstrap from `GET /api/v1/banks`: Card Setup reads SQLite first
  and only downloads the catalog when `banks_cache` is empty.
- a cache-first Merchant directory grouped by normalized brand, with branch,
  payment-type MCC details and profile-scoped local MCC contributions.

Initial setup profile/card data now survives app-process restarts in
`cardpilot.sqlite`. Backend profile persistence, user-data sync,
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
- `AppFloatingNavigationBar` and `AppNavigationItem`;
- `SocialAuthButton`;
- colors, spacing, and light/dark themes.

Public APIs are exported by `lib/cardpilot_ui.dart`. The package must not own
routing, Riverpod, repositories, Supabase, Toastification, product workflows,
or preview-only mock data.

### `cardpilot_widgetbook`

Owns isolated previews for public `cardpilot_ui` components. Current use cases
cover enabled/disabled/loading states for `AppPrimaryButton`, enabled/loading
states for `SocialAuthButton`, and Home/Transactions selections for the
floating navigation bar.

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
          database/
            tables/
          errors/
          network/
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
          banks/
            data/
            domain/
          initial_setup/
            data/
            domain/
            presentation/
          startup/
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

| Folder           | Current responsibility                                                             |
| ---------------- | ---------------------------------------------------------------------------------- |
| `config/`        | `AppConfig`, API/Supabase dart-defines, OAuth redirect URL                         |
| `constants/`     | Shared validation messages                                                         |
| `network/`       | Reusable Dio client, API envelope decoding, request metadata, and typed API errors |
| `errors/`        | App-level failure representation                                                   |
| `notifications/` | `AppToast`, a thin app adapter over `toastification`                               |
| `result/`        | Typed success/failure result wrapper                                               |
| `routing/`       | Named routes and route generation                                                  |

The current named routes are:

```text
/startup
/login
/sign-up
/setup/profile
/setup/card
/home
/error
```

The initial route is `/startup`. It resolves the current Supabase session and
local profile before replacing itself with Home, setup, or Sign in. The removed
onboarding carousel is no longer in the application route graph.

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
survives navigation into Home. Initial setup persistence stays in the Drift
local datasource; persistence concerns do not move into controllers or screens.

## Notifications and validation

- Reusable validation text lives in
  `core/constants/validation_messages.dart`.
- Feature validators return those shared messages.
- Runtime success/error/info notifications use `AppToast`, backed by
  `toastification` with a consistent top-center, flat-colored presentation.
- Toastification is an app dependency, not a design-system component, so it is
  not exported from `cardpilot_ui` or previewed in Widgetbook.

## Local persistence and sync direction

SQLite schema v1 is implemented with Drift. It uses one installation database,
strict `profile_id` scoping, reference-data cache tables, and a transactional
outbox schema:

```text
UI -> repository -> SQLite
                  ^
                  |
             sync service <-> NestJS API
```

Initial setup now reads and writes through its Drift local datasource. Other
product features must progressively move to local repositories so the UI reads
SQLite whether online or offline. A future sync service will refresh reference
data and upload guest/user mutations. PostgreSQL and SQLite have separate
migration lifecycles; the device schema maps shared business identifiers while
also owning active-profile state, cache metadata, tombstones, and outbox state
that do not belong in PostgreSQL.

Card Setup is the first cache-backed reference-data consumer. Its bank picker
watches `banks_cache`; a populated cache opens immediately without a network
request. An empty cache triggers one shared in-flight request to
`GET /api/v1/banks`, validates the complete response, replaces the cache in one
transaction, and then opens the picker. The bootstrap stores
`dataset_version = 1` on bank rows but deliberately does not create a
`sync_state` version. Dataset comparison and refresh of an existing cache are
reserved for the future user-triggered `Sync Now` flow.

The Merchants section under Transactions lazily calls `GET /api/v1/merchants`
the first time it is opened, stores the complete branch snapshot in
`merchant_branches_cache` and
`merchant_mcc_candidates_cache`, then renders from SQLite. A merchant brand is
a UI grouping by `name_normalized`; each cloud merchant row remains a branch.
MCC mappings include a separate payment type so direct payment and food-
delivery channels are not conflated. Contributions are stored only in
`local_merchant_mcc_contributions`, scoped by local profile, and deliberately
do not enter `sync_outbox` until a backend review/sync contract exists.
The manual transaction form also exposes a `Browse merchants` shortcut to the
same directory without duplicating its data or state management.

The implementation source of truth for this planned area is
[`docs/architecture/mobile-sqlite.md`](./architecture/mobile-sqlite.md). It
documents the implemented schema v1 and startup routing plus the planned schema
v2, ETag refresh, guest claim, conflict handling, and delivery slices.

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
