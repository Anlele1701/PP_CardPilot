# Mobile SQLite Architecture Proposal

**Status:** Proposed — review before implementation

**Owner:** Mobile, with backend API support

**Target:** CardPilot native Flutter app (iOS and Android)

**Date:** 2026-08-03

This document defines the proposed local persistence and sync architecture for
`apps/cardpilot-mobile/apps/cardpilot_app`. It is intentionally more detailed
than the database overview so implementation can be split into reviewable
changes without inventing schema or sync rules along the way.

No SQLite dependency or generated database code exists yet. This proposal does
not describe behavior that is already implemented.

## 1. Goals and non-goals

### Goals

- Preserve guest profile and card data across app restarts.
- Make SQLite the read source for mobile product screens, online or offline.
- Cache shared reference data such as banks, credit-card products, MCCs, and
  reward rules so screens do not fetch the same dataset repeatedly.
- Allow a guest workspace to be linked to a Supabase-authenticated account
  without changing client-generated business IDs.
- Queue local mutations and retry them safely when backend sync is available.
- Keep Flutter screens, Riverpod controllers, and domain entities independent
  from Drift.
- Give PostgreSQL and SQLite separate, tested migration lifecycles.

### Non-goals for the first implementation slice

- Real-time multi-device sync.
- Automatic conflict resolution for every business field.
- Background execution while the operating system has suspended the app.
- Copying all PostgreSQL tables and columns to the phone.
- Using SQLite as an authentication-session store. Supabase owns auth session
  persistence; CardPilot SQLite owns profile and business data only.
- Storing authoritative membership or cashback decisions on the device.

## 2. Decisions proposed for approval

| Decision | Proposal | Reason |
|----------|----------|--------|
| Database library | `drift` + `drift_flutter` | Typed queries, transactions, reactive streams, migration tooling, and in-memory tests |
| Database topology | One `cardpilot.sqlite` database per app installation | Reference caches are shared; workspace scoping prevents account data leakage |
| Local primary keys | UUID v4 strings generated before insert | The same ID can be retried and uploaded idempotently |
| Time storage | UTC Unix epoch milliseconds in SQLite | Stable comparison and no local-time ambiguity; convert only at UI/API boundaries |
| Money storage | Integer minor units plus ISO currency | Avoid floating-point rounding; VND currently has exponent 0 |
| Rates | Scaled integers where local calculation is needed | Avoid `double` drift; document the scale per column |
| Reference refresh | Server-owned dataset version and HTTP ETag, full snapshot replacement | Detects updates and deletions without timestamp gaps |
| User-data sync | Transactional outbox | A successful local write cannot be lost between entity write and queueing |
| Conflict detection | Server integer version / optimistic concurrency | Device clocks cannot safely decide the winning write |
| Deletes | Tombstone until acknowledged by server | Prevents a deleted record from reappearing after pull |
| Generated Drift code | Commit generated `.g.dart`, schema snapshots, and migration helpers | Builds remain deterministic and migration history is reviewable |
| Encryption | Do not claim plain SQLite is encrypted; make encryption/privacy a production gate | Financial data is sensitive and platform file protection differs by OS |

### Why the SQLite schema is not an exact PostgreSQL copy

PostgreSQL is the cloud source of truth. Mobile has additional concerns that do
not belong in the server schema: workspaces, pending mutations, retry state,
dataset ETags, cached snapshots, tombstones, and local display snapshots.
Conversely, admin/audit tables do not all need to be stored on a phone.

The schemas should share identifiers and business meaning, not necessarily
identical physical column names or types. Mapping belongs in the data layer.

## 3. Dependency and data flow

```text
Flutter view
  -> Riverpod controller
  -> use case
  -> domain repository interface
  -> repository implementation
       -> local Drift data source / DAO  (always available)
       -> backend API data source        (when authenticated and online)
  -> sync coordinator
       -> reads sync_outbox
       -> calls NestJS API with Supabase Bearer token
       -> applies server responses to Drift
```

Rules:

- Views and controllers never import Drift classes.
- Domain entities never contain `Value<T>`, companions, SQL column types, ETag,
  retry counts, or other persistence details.
- Repository implementations map Drift rows and API DTOs into domain entities.
- Product screens observe repository streams backed by SQLite. A sync refresh
  changes SQLite, which causes the streams to emit new state.
- A remote response is never written directly into Riverpod screen state; it is
  normalized into SQLite first.

## 4. Proposed location in the mobile app

```text
apps/cardpilot-mobile/apps/cardpilot_app/
  build.yaml
  drift_schemas/
    drift_schema_v1.json
  lib/
    core/
      database/
        app_database.dart
        app_database.g.dart              # generated and committed
        app_database.steps.dart          # generated migration helper
        database_connection.dart
        converters/
          date_time_converter.dart
          sync_status_converter.dart
        tables/
          workspace_tables.dart
          reference_tables.dart
          user_data_tables.dart
          sync_tables.dart
        daos/
          workspace_dao.dart
          reference_data_dao.dart
          user_card_dao.dart
          sync_dao.dart
    features/
      initial_setup/
        data/
          datasources/
            initial_setup_local_data_source.dart
          mappers/
            local_workspace_mapper.dart
      banks/
        data/
          datasources/
            bank_local_data_source.dart
            bank_remote_data_source.dart
      sync/
        application/
          sync_coordinator.dart
        data/
          sync_api_data_source.dart
  test/
    core/database/
      app_database_test.dart
      migrations/
```

`core/database` owns the physical database and reusable DAOs. Feature data
layers own business mapping. The sync coordinator belongs to the production app,
not `cardpilot_ui` and not Widgetbook.

## 5. Database lifecycle

1. `AppDatabase` is created once at the app composition root and exposed through
   a non-auto-dispose Riverpod provider.
2. `driftDatabase(name: 'cardpilot')` opens the native database away from the UI
   isolate through `drift_flutter` defaults.
3. `PRAGMA foreign_keys = ON` runs in `beforeOpen` on every open.
4. Recommended native settings are `journal_mode = WAL` and a bounded
   `busy_timeout`; verify them on supported iOS/Android versions before release.
5. Providers invalidate/close the database only when the app container is
   disposed, not when a screen is popped.
6. Tests inject an in-memory query executor. No production test should open the
   developer's real database file.

The first production schema uses `schemaVersion = 1`. Never use a destructive
fallback such as dropping all tables when an upgrade fails. Once a build has
been distributed, every schema change increments `schemaVersion` and includes a
tested step-by-step migration.

## 6. Physical schema

SQLite booleans are represented by integer-backed Drift boolean columns. All
timestamps ending in `_at_ms` are UTC epoch milliseconds. UUIDs are `TEXT`.

### 6.1 Schema v1 — foundation, setup, cards, and reference cache

#### `local_workspaces`

Represents a local data boundary. A guest workspace can later be linked to a
Supabase user without changing the workspace ID or child record IDs.

| Column | Type | Constraints / meaning |
|--------|------|-----------------------|
| `id` | TEXT | PK, client UUID |
| `access_mode` | TEXT | `guest` or `authenticated` |
| `auth_user_id` | TEXT nullable | Supabase `auth.users.id`; unique when present |
| `is_active` | INTEGER | Boolean; only one active workspace per installation |
| `created_at_ms` | INTEGER | Required |
| `updated_at_ms` | INTEGER | Required |
| `last_opened_at_ms` | INTEGER | Required |

Indexes and constraints:

- unique partial index on `auth_user_id WHERE auth_user_id IS NOT NULL`;
- unique partial index on `is_active WHERE is_active = 1`;
- check `access_mode IN ('guest', 'authenticated')`.

#### `local_profiles`

Maps the current `LocalProfile` to a durable row and leaves room for backend
identity after bootstrap.

| Column | Type | Constraints / meaning |
|--------|------|-----------------------|
| `workspace_id` | TEXT | PK, FK → `local_workspaces.id` ON DELETE CASCADE |
| `server_user_id` | TEXT nullable | `public.users.id`, unique when present |
| `email` | TEXT nullable | Snapshot for authenticated account display |
| `display_name` | TEXT | Required, max 40 enforced in domain/UI |
| `born_date_at_ms` | INTEGER nullable | Date normalized at mapper boundary |
| `setup_completed_at_ms` | INTEGER nullable | Null means setup is incomplete |
| `created_at_ms` | INTEGER | Required |
| `updated_at_ms` | INTEGER | Required, changes on local edit |
| `deleted_at_ms` | INTEGER nullable | Tombstone |
| `sync_status` | TEXT | `local_only`, `pending`, `synced`, `failed`, `conflict` |
| `server_version` | INTEGER nullable | Optimistic concurrency version |
| `last_synced_at_ms` | INTEGER nullable | Diagnostics/UI only |

#### `banks_cache`

Read-only snapshot from `GET /api/v1/banks`.

| Column | Type | Constraints / meaning |
|--------|------|-----------------------|
| `id` | TEXT | PK, PostgreSQL bank UUID |
| `swift_code` | TEXT nullable | Unique when present |
| `name` | TEXT | Required |
| `short_name` | TEXT nullable | Display/search alias |
| `server_updated_at_ms` | INTEGER nullable | Server audit value if exposed |
| `dataset_version` | TEXT | Manifest version that produced this row |

Indexes: `name`, `short_name`, and unique partial `swift_code`.

#### `credit_cards_cache`

Read-only catalog of card products. This table is added in schema v1 even if
the backend endpoint lands after the initial SQLite foundation.

| Column | Type | Constraints / meaning |
|--------|------|-----------------------|
| `id` | TEXT | PK, PostgreSQL credit-card UUID |
| `bank_id` | TEXT | FK → `banks_cache.id` |
| `name` | TEXT | Required |
| `network` | TEXT nullable | Visa, Mastercard, etc. |
| `card_type` | TEXT | Defaults to `credit` |
| `annual_fee_decimal` | TEXT nullable | Exact server decimal string until currency contract is explicit |
| `source_url` | TEXT nullable | Reference source |
| `last_verified_at_ms` | INTEGER nullable | Server verification time |
| `is_active` | INTEGER | Boolean |
| `server_updated_at_ms` | INTEGER nullable | Server audit value if exposed |
| `dataset_version` | TEXT | Manifest version |

Indexes: `(bank_id, is_active)` and normalized `name` search when required.

`annual_fee` currently has no currency column in PostgreSQL. Do not silently
assume VND in a mapper. Confirm the server contract before using this value for
calculation; until then store the exact decimal string for display only.

#### `local_user_cards`

Durable replacement for the card portion of `LocalWorkspace`.

| Column | Type | Constraints / meaning |
|--------|------|-----------------------|
| `id` | TEXT | PK, client UUID |
| `workspace_id` | TEXT | FK → `local_workspaces.id` ON DELETE CASCADE |
| `credit_card_id` | TEXT nullable | Catalog product ID when selected |
| `bank_id` | TEXT nullable | Catalog bank ID when known |
| `bank_name_snapshot` | TEXT | Required for offline display and custom `Other` bank |
| `nickname` | TEXT | Required |
| `billing_cycle_day` | INTEGER | Check 1–31 |
| `is_default` | INTEGER | Boolean |
| `has_annual_fee` | INTEGER | Boolean |
| `created_at_ms` | INTEGER | Required |
| `updated_at_ms` | INTEGER | Required |
| `deleted_at_ms` | INTEGER nullable | Tombstone |
| `sync_status` | TEXT | Same enum as profile |
| `server_version` | INTEGER nullable | Optimistic concurrency version |
| `last_synced_at_ms` | INTEGER nullable | Diagnostics/UI only |

Do not add a foreign key from user data to reference-cache rows. A full cache
snapshot replacement or server-side catalog deletion must not delete or make a
user's card unreadable. IDs plus display snapshots provide a stable bridge.

Indexes:

- `(workspace_id, deleted_at_ms)` for active card lists;
- `(workspace_id, is_default)`;
- partial unique index allowing at most one non-deleted default card per
  workspace.

#### `sync_outbox`

Stores user-generated mutations that have not been acknowledged by backend.

| Column | Type | Constraints / meaning |
|--------|------|-----------------------|
| `id` | TEXT | PK, mutation UUID |
| `workspace_id` | TEXT | FK → workspace ON DELETE CASCADE |
| `entity_type` | TEXT | `profile`, `user_card`, later `transaction` |
| `entity_id` | TEXT | Client business ID |
| `operation` | TEXT | `create`, `update`, or `delete` |
| `payload_json` | TEXT | Versioned API payload; never auth tokens |
| `payload_version` | INTEGER | Starts at 1 |
| `base_server_version` | INTEGER nullable | Version edited by the client |
| `idempotency_key` | TEXT | Unique; sent unchanged on every retry |
| `attempt_count` | INTEGER | Starts at 0 |
| `next_attempt_at_ms` | INTEGER | Retry scheduler |
| `last_error_code` | TEXT nullable | Safe diagnostic code, not raw secrets |
| `created_at_ms` | INTEGER | FIFO ordering |

Indexes: unique `idempotency_key` and
`(workspace_id, next_attempt_at_ms, created_at_ms)`.

For repeated unsent updates to the same entity, the repository may compact
operations in the same transaction, but it must preserve these semantics:

- create + update → one create with latest payload;
- create + delete before first push → remove entity and queued create locally;
- synced update + delete → retain a delete operation;
- an in-flight operation is immutable until its response is applied.

#### `sync_state`

One row per sync scope or reference dataset.

| Column | Type | Constraints / meaning |
|--------|------|-----------------------|
| `scope` | TEXT | PK, e.g. `reference:banks`, `user:<workspace>:cards` |
| `cursor` | TEXT nullable | Opaque server pull cursor |
| `dataset_version` | TEXT nullable | Reference snapshot version |
| `etag` | TEXT nullable | HTTP ETag |
| `last_attempt_at_ms` | INTEGER nullable | Diagnostics |
| `last_success_at_ms` | INTEGER nullable | TTL calculation |
| `next_check_at_ms` | INTEGER nullable | Avoid request on every rebuild/resume |
| `last_error_code` | TEXT nullable | Safe diagnostic code |

### 6.2 Schema v2 — transactions and reward intelligence

Schema v2 should only be introduced when transaction screens are implemented.
It adds:

| Table | Important fields | Notes |
|-------|------------------|-------|
| `merchant_category_codes_cache` | `code`, `description`, `category`, `valid_payment`, `is_active`, dataset metadata | Full reference snapshot |
| `reward_rules_cache` | server ID, card ID, rates/caps as exact strings or documented scaled integers, effective dates, active flag | Server-owned |
| `reward_rule_mccs_cache` | rule ID, MCC code, match type | Composite uniqueness matching server |
| `local_merchants` | client ID, optional server ID, raw/normalized name, location, country, sync columns | User-generated/local lookup |
| `local_transactions` | client ID, workspace/card/merchant IDs, timestamp, `amount_minor`, currency, MCC/category, estimate, source, note, sync columns | User-owned; FK to local card |
| `local_cashback_calculations` | transaction ID, optional server rule ID, amount minor, scaled rate/confidence, explanation, status | Local estimate, server may replace |
| `sync_conflicts` | mutation ID, entity identity, local/server JSON, server version, detected/resolved timestamps | Never silently discard a conflict |

Transaction indexes must at minimum cover:

- `(workspace_id, transaction_at_ms DESC)`;
- `(user_card_id, transaction_at_ms DESC)`;
- `(workspace_id, sync_status)`;
- unique `(workspace_id, id)`.

## 7. Domain-to-storage mapping

The current domain model needs small changes during implementation:

| Current domain value | SQLite mapping | Required code change |
|----------------------|----------------|----------------------|
| `LocalWorkspace.localId` | `local_workspaces.id` | Generate UUID v4 instead of timestamp-prefixed ID |
| `LocalWorkspace.accessMode` | `local_workspaces.access_mode` | Enum ↔ stable lowercase string converter |
| `LocalProfile.displayName` | `local_profiles.display_name` | No UI change |
| `LocalUserCard.bankName` | `bank_name_snapshot` | Add optional `bankId` and `creditCardId` later |
| `LocalUserCard.nickname` | `nickname` | Add a client `id` before persistence |
| `LocalUserCard.billingCycleDay` | `billing_cycle_day` | Preserve 1–31 validation in domain and DB |

`InitialSetupRepository` can keep its `save/load` contract for the first slice,
but the implementation changes from memory to Drift. `save(workspace)` must
write workspace, profile, first card, and any required outbox records in one
database transaction.

After card management grows beyond initial setup, introduce card-specific
repository methods instead of growing `InitialSetupRepository` into a generic
database service.

## 8. Startup and routing behavior

Proposed startup decision sequence:

```text
open SQLite
  -> read Supabase current session
  -> find workspace linked to auth_user_id, if session exists
       -> found + setup complete: activate workspace -> Home
       -> found + setup incomplete: activate -> Setup
       -> not found: create/link authenticated workspace -> bootstrap/pull -> Setup or Home
  -> no Supabase session
       -> active guest workspace + setup complete: Home as guest
       -> active guest workspace + setup incomplete: Setup
       -> otherwise: Sign in / Continue as guest
```

This lookup replaces the current behavior where a restored Supabase session can
send a previously configured user through profile setup again.

Account isolation requirements:

- Every user-data query requires `workspace_id` explicitly.
- Switching Supabase accounts switches the active workspace; it never rewrites
  another workspace's rows.
- Logout clears the Supabase session and deactivates/locks the authenticated
  workspace from UI access. It does not silently delete financial data.
- Provide an explicit “Remove local data from this device” action before
  production release.

## 9. Reference-data refresh

The existing `GET /api/v1/banks` response has no dataset version or ETag, so the
mobile client cannot reliably distinguish “unchanged” from “server updated or
deleted a row”. `updated_at` polling alone also misses deletions.

### Required backend contract

Proposed manifest endpoint:

```http
GET /api/v1/reference-data/manifest
```

```json
{
  "responseStatus": { "code": "SUCCESS", "message": "Success" },
  "responseData": {
    "datasets": {
      "banks": {
        "version": "sha256:...",
        "etag": "\"banks-sha256-...\"",
        "updatedAt": "2026-08-03T00:00:00.000Z"
      },
      "creditCards": {
        "version": "sha256:...",
        "etag": "\"credit-cards-sha256-...\"",
        "updatedAt": "2026-08-03T00:00:00.000Z"
      }
    }
  }
}
```

Dataset endpoints should accept `If-None-Match` and return `304 Not Modified`
when possible. A version must represent the complete active snapshot, including
deletions.

### Mobile refresh algorithm

1. Read cached rows immediately.
2. If cache is empty, fetch the full dataset before the selection screen needs
   it; show retry/error if no stale cache exists.
3. If cache exists and `next_check_at_ms` is in the future, use it without a
   network call.
4. When TTL expires (initial recommendation: 24 hours), fetch the manifest or
   revalidate with ETag.
5. If unchanged/304, only update `sync_state` timestamps.
6. If changed, fetch the complete snapshot and in one SQLite transaction:
   delete/replace cached rows in FK-safe order, insert the new rows, and update
   `dataset_version`/ETag.
7. If refresh fails, retain stale cache, record a safe error code, and retry
   with exponential backoff plus jitter.

Do not clear a usable cache before a replacement response has been fully parsed
and validated.

## 10. User-data sync and guest claim

### Local write rule

For a synchronizable mutation, one Drift transaction must:

1. insert/update/tombstone the entity;
2. set `sync_status = pending`;
3. insert or compact its outbox operation.

If any step fails, all steps roll back. UI success means the local transaction
committed; it does not mean cloud sync already succeeded.

### Proposed backend endpoints

| Endpoint | Purpose |
|----------|---------|
| `POST /api/v1/auth/bootstrap` | Verify Supabase token and create/load backend user |
| `POST /api/v1/sync/claim-guest` | Associate a guest workspace and upload its initial snapshot idempotently |
| `POST /api/v1/sync/push` | Accept ordered mutation batches |
| `GET /api/v1/sync/pull?cursor=...` | Return server changes and next opaque cursor |

Example push operation:

```json
{
  "deviceId": "uuid",
  "workspaceId": "uuid",
  "operations": [
    {
      "idempotencyKey": "uuid",
      "entityType": "user_card",
      "entityId": "uuid",
      "operation": "update",
      "baseServerVersion": 3,
      "clientOccurredAt": "2026-08-03T10:00:00.000Z",
      "payloadVersion": 1,
      "payload": {
        "nickname": "Everyday Visa",
        "billingCycleDay": 15
      }
    }
  ]
}
```

The backend must persist idempotency results so a retry returns the same logical
result instead of creating duplicates.

### Sync order

1. Bootstrap authenticated backend user.
2. Claim/link guest workspace if applicable.
3. Push profile.
4. Push cards.
5. Push merchants and transactions when schema v2 exists.
6. Pull server changes using the last cursor.
7. Apply the response and remove acknowledged outbox records in one local
   transaction.

### Retry policy

- Retry network errors, timeouts, `429`, and retryable `5xx`.
- Respect `Retry-After`.
- Use exponential backoff with jitter and a maximum delay.
- Do not automatically retry validation/auth/permission errors until their
  cause changes.
- Refresh Supabase session on `401` through the auth layer, then retry at most
  once to avoid loops.
- Trigger foreground sync after local writes, app resume, sign-in, and network
  reconnection. Background scheduling is a later optimization.

## 11. Conflict policy

The current PostgreSQL tables have `updated_at`, but a robust multi-device sync
contract should add a monotonically increasing integer `version` for mutable
user records. Comparing device timestamps is not sufficient because clocks can
be wrong.

| Data | Policy |
|------|--------|
| Reference data | Server snapshot always wins |
| Membership | Server always wins |
| Cashback award/official calculation | Server always wins; local value is estimate only |
| Transaction create | Client UUID + idempotency key deduplicates |
| Profile/card update | Require `baseServerVersion`; stale write returns conflict |
| Delete | Tombstone locally and on server until all required sync retention passes |

For the MVP, do not silently overwrite a profile/card conflict. Store both
versions in `sync_conflicts` (schema v2 or earlier if multi-device sync ships
sooner), mark the entity `conflict`, and expose a resolution flow or a clearly
documented server-wins decision.

## 12. Security, privacy, backup, and logout

- SQLite must never contain Supabase access/refresh tokens or service-role keys.
- Plain SQLite is not application-level encryption. Before storing real
  financial history in production, decide whether platform data protection is
  sufficient or SQLCipher is required, and test migration/backup behavior.
- Disable or carefully configure Android cloud backup for sensitive database
  files; review iOS file-protection class.
- Redact profile, payload JSON, tokens, and transaction notes from logs.
- Database files, WAL/SHM files, exported debug copies, and local `.env` files
  must not be committed.
- Logout hides/deactivates authenticated workspace data. Destructive removal is
  an explicit user action with confirmation.
- Database corruption recovery must first preserve/export diagnostic metadata
  when safe; never default to deleting unsynced guest data.

## 13. Drift setup and migration workflow

Packages proposed for the implementation PR:

```yaml
dependencies:
  drift: <compatible version>
  drift_flutter: <compatible version>
  uuid: <compatible version>

dev_dependencies:
  build_runner: <compatible version>
  drift_dev: <compatible version>
```

Resolve compatible current versions with Flutter's package solver in the
implementation branch rather than copying stale versions from this document.

Configure `build.yaml` with the database path and keep schemas under
`drift_schemas/`. From `apps/cardpilot-mobile/apps/cardpilot_app`:

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
dart run drift_dev make-migrations
flutter test test/core/database
```

Migration rules:

1. Define v1 tables and set `schemaVersion = 1`.
2. Run `dart run drift_dev make-migrations` and commit the v1 schema snapshot,
   generated helper, generated tests, and `.g.dart` output.
3. For every later physical schema change, increment `schemaVersion` exactly
   once and rerun `make-migrations`.
4. Fill the generated step function; do not reference only current-schema table
   objects when migrating an older schema.
5. Test upgrade from every supported old version and verify data survives.
6. Run foreign-key checks after complex migrations.
7. Never modify an already-released schema snapshot to pretend history changed.

## 14. Required tests

### Database and DAO tests

- Create v1 schema in memory and enable foreign keys.
- Save/load a guest workspace across database reopen.
- Save profile + first card atomically.
- Reject billing-cycle days outside 1–31 at database/domain boundaries.
- Enforce one active workspace and one default card per workspace.
- Verify every user query is scoped by workspace.
- Replace a reference snapshot atomically and remove server-deleted cache rows.
- Preserve `bank_name_snapshot` when a bank disappears from cache.
- Commit entity mutation and outbox item together; roll both back on error.
- Compact safe outbox operation sequences without changing behavior.

### Migration tests

- Validate generated schema v1.
- For every future version, migrate from each supported prior version.
- Seed representative rows before upgrade and assert no data loss afterward.
- Run `PRAGMA foreign_key_check` after migration.

### Repository/controller/widget tests

- Restored guest workspace routes to Home instead of Sign in/setup.
- Restored authenticated session plus completed local profile routes to Home.
- Different Supabase accounts never read each other's workspace data.
- Empty cache + offline shows retry; stale cache + offline remains usable.
- Logout hides authenticated workspace and does not delete it.

## 15. Implementation slices

### Slice 1 — SQLite foundation and initial setup persistence

- Add Drift dependencies, database connection, schema v1, and migration tests.
- Generate UUIDs for workspace/card IDs.
- Replace `InitialSetupMemoryDataSource` with a Drift local data source.
- Restore workspace during startup and route correctly.
- Keep sync fields/outbox schema present, but no network sync yet.

**Done when:** guest profile and first card survive a full app restart and all
existing initial-setup tests pass against SQLite.

### Slice 2 — Bank reference cache

- Add mobile backend API client if not already available.
- Add bank local/remote data sources and repository.
- Replace hard-coded bank list in `CardSetupScreen` with cached data.
- Initially fetch when empty; implement stale-cache behavior.
- Add backend manifest/ETag support before claiming change detection is done.

**Done when:** bank selection loads immediately from SQLite after the first
successful fetch and refreshes only when dataset version changes or TTL expires.

### Slice 3 — User-card local repository

- Split card operations out of `InitialSetupRepository`.
- Support list/add/edit/tombstone/default-card operations as reactive queries.
- Add transactional outbox writes.

### Slice 4 — Backend bootstrap and guest claim

- Implement Supabase token verification/Auth Guard.
- Finalize `auth.users.id` ↔ `public.users.id` mapping.
- Implement idempotent bootstrap and guest claim contracts.
- Push profile/cards and apply acknowledgements.

### Slice 5 — Pull sync and conflicts

- Add server version columns/contracts and opaque pull cursor.
- Implement push/pull coordinator, retries, and conflict persistence.
- Add sync status UI and explicit retry.

### Slice 6 — Transactions and reward caches

- Ship schema v2 through a tested migration.
- Add MCC/reward snapshots, local transactions, cashback estimates, and their
  sync operations.

## 16. Review checklist and blockers

Approve or change these before Slice 1:

- [ ] Confirm Drift as the mobile SQLite abstraction.
- [ ] Confirm one database with strict `workspace_id` scoping instead of one
      database file per account.
- [ ] Confirm client UUID v4 IDs.
- [ ] Confirm UTC epoch-millisecond timestamps.
- [ ] Confirm integer minor units for transaction money.
- [ ] Confirm generated Drift files and schema snapshots are committed.
- [ ] Decide whether v1 ships `sync_outbox` immediately or adds it in v2.
- [ ] Decide production encryption/backup requirements.

Backend blockers before reliable cache/sync:

- [ ] Add dataset version or ETag contract for banks and later reference data.
- [ ] Expose server `updatedAt` consistently in DTOs where needed.
- [ ] Decide annual-fee currency representation.
- [ ] Finalize Supabase identity mapping.
- [ ] Add optimistic concurrency `version` for mutable user data.
- [ ] Define push/pull pagination, retention, and idempotency duration.

## Related documents

- [Mobile Architecture](../MOBILE_ARCHITECTURE.md)
- [Database Design](./database.md)
- [API Design](./api.md)
- [System Architecture](./system.md)
- [SRS](../SRS.md)
