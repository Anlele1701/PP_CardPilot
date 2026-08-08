ALTER TABLE merchant_mcc_candidates_cache
ADD COLUMN payment_type TEXT NOT NULL DEFAULT 'unknown'
CHECK (payment_type IN (
  'unknown', 'in_store', 'online', 'shopee_food', 'grab_food', 'other'
));

CREATE TABLE merchant_branches_cache (
  id TEXT NOT NULL PRIMARY KEY,
  name TEXT NOT NULL,
  name_normalized TEXT NOT NULL,
  location_text TEXT,
  dataset_version INTEGER NOT NULL DEFAULT 1
);

CREATE INDEX idx_merchant_branches_cache_name
ON merchant_branches_cache (name_normalized);

CREATE TABLE local_merchant_mcc_contributions (
  id TEXT NOT NULL PRIMARY KEY,
  profile_id TEXT NOT NULL REFERENCES local_profiles(id) ON DELETE CASCADE,
  merchant_server_id TEXT NOT NULL,
  merchant_name_snapshot TEXT NOT NULL,
  location_text TEXT,
  mcc_code TEXT NOT NULL CHECK (length(mcc_code) = 4),
  mcc_description_snapshot TEXT,
  payment_type TEXT NOT NULL CHECK (payment_type IN (
    'unknown', 'in_store', 'online', 'shopee_food', 'grab_food', 'other'
  )),
  note TEXT,
  created_at_ms INTEGER NOT NULL,
  updated_at_ms INTEGER NOT NULL,
  UNIQUE (profile_id, merchant_server_id, mcc_code, payment_type)
);

CREATE INDEX idx_local_merchant_mcc_contributions_profile_merchant
ON local_merchant_mcc_contributions (profile_id, merchant_server_id);
