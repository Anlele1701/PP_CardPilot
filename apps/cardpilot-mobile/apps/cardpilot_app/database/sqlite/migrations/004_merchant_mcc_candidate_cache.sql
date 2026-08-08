CREATE TABLE merchant_mcc_candidates_cache (
  id                       TEXT PRIMARY KEY NOT NULL,
  merchant_server_id       TEXT NOT NULL,
  merchant_name            TEXT NOT NULL,
  merchant_name_normalized TEXT NOT NULL,
  location_text            TEXT,
  mcc_code                 TEXT NOT NULL CHECK (length(mcc_code) = 4),
  mcc_description          TEXT,
  source                   TEXT NOT NULL,
  confidence_ppm           INTEGER CHECK (
    confidence_ppm IS NULL OR confidence_ppm BETWEEN 0 AND 1000000
  ),
  status                   TEXT NOT NULL,
  dataset_version          INTEGER NOT NULL DEFAULT 1
);

CREATE INDEX idx_merchant_mcc_candidates_cache_name
  ON merchant_mcc_candidates_cache (merchant_name_normalized);

CREATE INDEX idx_merchant_mcc_candidates_cache_mcc
  ON merchant_mcc_candidates_cache (mcc_code);
