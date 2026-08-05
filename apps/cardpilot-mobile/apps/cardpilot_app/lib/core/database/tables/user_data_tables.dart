// Drift check constraints refer to their own column getter by design.
// ignore_for_file: recursive_getters

import 'package:drift/drift.dart';

import 'profile_tables.dart';

@DataClassName('LocalUserCardRow')
@TableIndex(
  name: 'idx_local_user_cards_profile_active',
  columns: {#profileId, #deletedAtMs},
)
@TableIndex.sql(
  'CREATE UNIQUE INDEX uq_local_user_cards_default '
  'ON local_user_cards (profile_id) '
  'WHERE is_default = 1 AND deleted_at_ms IS NULL',
)
class LocalUserCards extends Table {
  @override
  String get tableName => 'local_user_cards';

  TextColumn get id => text()();
  TextColumn get profileId =>
      text().references(LocalProfiles, #id, onDelete: KeyAction.cascade)();
  TextColumn get creditCardId => text().nullable()();
  TextColumn get bankId => text().nullable()();
  TextColumn get bankNameSnapshot => text()();
  TextColumn get nickname => text().withLength(min: 1)();
  IntColumn get billingCycleDay =>
      integer().check(billingCycleDay.isBetweenValues(1, 31))();
  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();
  BoolColumn get hasAnnualFee => boolean().withDefault(const Constant(false))();
  IntColumn get createdAtMs => integer()();
  IntColumn get updatedAtMs => integer()();
  IntColumn get deletedAtMs => integer().nullable()();
  TextColumn get syncStatus => text()
      .withDefault(const Constant('local_only'))
      .check(
        syncStatus.isIn(const [
          'local_only',
          'pending',
          'synced',
          'failed',
          'conflict',
        ]),
      )();
  IntColumn get serverVersion => integer().nullable().check(
    serverVersion.isNull() | serverVersion.isBiggerOrEqualValue(1),
  )();
  IntColumn get lastSyncedAtMs => integer().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
