-- Drift schema v3: store a user-entered credit limit in minor currency units.
-- Existing cards receive 0 and must be updated through the card editor before
-- CardPilot can calculate their available balance.

ALTER TABLE local_user_cards
ADD COLUMN credit_limit_minor INTEGER NOT NULL DEFAULT 0
CHECK (credit_limit_minor >= 0);
