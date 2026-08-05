-- CardPilot mobile SQLite schema v2 (review draft).
-- Apply after 001_initial_local_schema.sql.

PRAGMA foreign_keys = ON;

BEGIN IMMEDIATE;

CREATE TABLE local_merchants (
  id                TEXT PRIMARY KEY NOT NULL,
  profile_id        TEXT NOT NULL,
  server_merchant_id TEXT,
  name_raw          TEXT NOT NULL,
  name_normalized   TEXT NOT NULL,
  location_text     TEXT,
  country_code      TEXT NOT NULL DEFAULT 'VN'
    CHECK (length(country_code) = 2),
  created_at_ms     INTEGER NOT NULL,
  updated_at_ms     INTEGER NOT NULL,
  deleted_at_ms     INTEGER,
  sync_status       TEXT NOT NULL DEFAULT 'local_only'
    CHECK (sync_status IN (
      'local_only', 'pending', 'synced', 'failed', 'conflict'
    )),
  server_version    INTEGER,
  last_synced_at_ms INTEGER,
  FOREIGN KEY (profile_id)
    REFERENCES local_profiles (id) ON DELETE CASCADE,
  CHECK (server_version IS NULL OR server_version >= 1)
);

CREATE INDEX idx_local_merchants_profile_name
  ON local_merchants (profile_id, name_normalized);

CREATE UNIQUE INDEX uq_local_merchants_server_id
  ON local_merchants (profile_id, server_merchant_id)
  WHERE server_merchant_id IS NOT NULL AND deleted_at_ms IS NULL;

CREATE TABLE local_transactions (
  id                         TEXT PRIMARY KEY NOT NULL,
  profile_id                 TEXT NOT NULL,
  user_card_id               TEXT NOT NULL,
  merchant_id                TEXT,
  transaction_at_ms          INTEGER NOT NULL,
  amount_minor               INTEGER NOT NULL CHECK (amount_minor >= 0),
  currency                   TEXT NOT NULL DEFAULT 'VND'
    CHECK (length(currency) = 3),
  mcc_code                   TEXT CHECK (mcc_code IS NULL OR length(mcc_code) = 4),
  mcc_source                 TEXT,
  category                   TEXT,
  cashback_estimated_minor   INTEGER,
  cashback_confidence_ppm    INTEGER
    CHECK (
      cashback_confidence_ppm IS NULL OR
      cashback_confidence_ppm BETWEEN 0 AND 1000000
    ),
  source                     TEXT NOT NULL DEFAULT 'manual',
  note                       TEXT,
  created_at_ms              INTEGER NOT NULL,
  updated_at_ms              INTEGER NOT NULL,
  deleted_at_ms              INTEGER,
  sync_status                TEXT NOT NULL DEFAULT 'local_only'
    CHECK (sync_status IN (
      'local_only', 'pending', 'synced', 'failed', 'conflict'
    )),
  server_version             INTEGER,
  last_synced_at_ms          INTEGER,
  FOREIGN KEY (profile_id)
    REFERENCES local_profiles (id) ON DELETE CASCADE,
  FOREIGN KEY (user_card_id)
    REFERENCES local_user_cards (id),
  FOREIGN KEY (merchant_id)
    REFERENCES local_merchants (id),
  CHECK (server_version IS NULL OR server_version >= 1)
);

CREATE INDEX idx_local_transactions_profile_date
  ON local_transactions (profile_id, transaction_at_ms DESC);

CREATE INDEX idx_local_transactions_card_date
  ON local_transactions (user_card_id, transaction_at_ms DESC);

CREATE INDEX idx_local_transactions_profile_sync
  ON local_transactions (profile_id, sync_status);

CREATE TABLE local_cashback_calculations (
  id                         TEXT PRIMARY KEY NOT NULL,
  profile_id                 TEXT NOT NULL,
  transaction_id             TEXT NOT NULL,
  user_card_id               TEXT NOT NULL,
  reward_rule_id             TEXT,
  estimated_cashback_minor   INTEGER,
  applied_rate_ppm           INTEGER
    CHECK (applied_rate_ppm IS NULL OR applied_rate_ppm >= 0),
  confidence_ppm             INTEGER
    CHECK (confidence_ppm IS NULL OR confidence_ppm BETWEEN 0 AND 1000000),
  explanation                TEXT,
  status                     TEXT NOT NULL DEFAULT 'estimated',
  calculation_source         TEXT NOT NULL DEFAULT 'local'
    CHECK (calculation_source IN ('local', 'server')),
  created_at_ms              INTEGER NOT NULL,
  updated_at_ms              INTEGER NOT NULL,
  FOREIGN KEY (profile_id)
    REFERENCES local_profiles (id) ON DELETE CASCADE,
  FOREIGN KEY (transaction_id)
    REFERENCES local_transactions (id) ON DELETE CASCADE,
  FOREIGN KEY (user_card_id)
    REFERENCES local_user_cards (id),
  UNIQUE (transaction_id, calculation_source)
);

CREATE INDEX idx_local_cashback_profile_card
  ON local_cashback_calculations (profile_id, user_card_id, created_at_ms DESC);

-- Stores both versions when optimistic concurrency rejects a local mutation.
-- Resolution is explicit; neither side is silently discarded.
CREATE TABLE sync_conflicts (
  id                    TEXT PRIMARY KEY NOT NULL,
  profile_id            TEXT NOT NULL,
  mutation_id           TEXT NOT NULL,
  entity_type           TEXT NOT NULL,
  entity_id             TEXT NOT NULL,
  local_payload_json    TEXT NOT NULL,
  server_payload_json   TEXT NOT NULL,
  server_version        INTEGER NOT NULL CHECK (server_version >= 1),
  detected_at_ms        INTEGER NOT NULL,
  resolved_at_ms        INTEGER,
  resolution            TEXT
    CHECK (resolution IS NULL OR resolution IN (
      'keep_local', 'keep_server', 'merged'
    )),
  FOREIGN KEY (profile_id)
    REFERENCES local_profiles (id) ON DELETE CASCADE,
  UNIQUE (mutation_id)
);

CREATE INDEX idx_sync_conflicts_unresolved
  ON sync_conflicts (profile_id, resolved_at_ms, detected_at_ms);

COMMIT;
