// Drift check constraints refer to their own column getter by design.
// ignore_for_file: recursive_getters

import 'package:drift/drift.dart';

import 'profile_tables.dart';
import 'user_data_tables.dart';

@DataClassName('LocalMerchantRow')
@TableIndex(
  name: 'idx_local_merchants_profile_name',
  columns: {#profileId, #nameNormalized},
)
@TableIndex.sql(
  'CREATE UNIQUE INDEX uq_local_merchants_server_id '
  'ON local_merchants (profile_id, server_merchant_id) '
  'WHERE server_merchant_id IS NOT NULL AND deleted_at_ms IS NULL',
)
class LocalMerchants extends Table {
  @override
  String get tableName => 'local_merchants';

  TextColumn get id => text()();
  TextColumn get profileId =>
      text().references(LocalProfiles, #id, onDelete: KeyAction.cascade)();
  TextColumn get serverMerchantId => text().nullable()();
  TextColumn get nameRaw => text()();
  TextColumn get nameNormalized => text()();
  TextColumn get locationText => text().nullable()();
  TextColumn get countryCode => text()
      .withDefault(const Constant('VN'))
      .check(countryCode.length.equals(2))();
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

@DataClassName('LocalTransactionRow')
@TableIndex(
  name: 'idx_local_transactions_profile_date',
  columns: {#profileId, #transactionAtMs},
)
@TableIndex(
  name: 'idx_local_transactions_card_date',
  columns: {#userCardId, #transactionAtMs},
)
@TableIndex(
  name: 'idx_local_transactions_profile_sync',
  columns: {#profileId, #syncStatus},
)
class LocalTransactions extends Table {
  @override
  String get tableName => 'local_transactions';

  TextColumn get id => text()();
  TextColumn get profileId =>
      text().references(LocalProfiles, #id, onDelete: KeyAction.cascade)();
  TextColumn get userCardId => text().references(LocalUserCards, #id)();
  TextColumn get merchantId =>
      text().nullable().references(LocalMerchants, #id)();
  IntColumn get transactionAtMs => integer()();
  IntColumn get amountMinor =>
      integer().check(amountMinor.isBiggerOrEqualValue(0))();
  TextColumn get currency => text()
      .withDefault(const Constant('VND'))
      .check(currency.length.equals(3))();
  TextColumn get mccCode =>
      text().nullable().check(mccCode.isNull() | mccCode.length.equals(4))();
  TextColumn get mccSource => text().nullable()();
  TextColumn get category => text().nullable()();
  IntColumn get cashbackEstimatedMinor => integer().nullable()();
  IntColumn get cashbackConfidencePpm => integer().nullable().check(
    cashbackConfidencePpm.isNull() |
        cashbackConfidencePpm.isBetweenValues(0, 1000000),
  )();
  TextColumn get source => text().withDefault(const Constant('manual'))();
  TextColumn get note => text().nullable()();
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

@DataClassName('LocalCashbackCalculationRow')
@TableIndex(
  name: 'idx_local_cashback_profile_card',
  columns: {#profileId, #userCardId, #createdAtMs},
)
class LocalCashbackCalculations extends Table {
  @override
  String get tableName => 'local_cashback_calculations';

  TextColumn get id => text()();
  TextColumn get profileId =>
      text().references(LocalProfiles, #id, onDelete: KeyAction.cascade)();
  TextColumn get transactionId =>
      text().references(LocalTransactions, #id, onDelete: KeyAction.cascade)();
  TextColumn get userCardId => text().references(LocalUserCards, #id)();
  TextColumn get rewardRuleId => text().nullable()();
  IntColumn get estimatedCashbackMinor => integer().nullable()();
  IntColumn get appliedRatePpm => integer().nullable().check(
    appliedRatePpm.isNull() | appliedRatePpm.isBiggerOrEqualValue(0),
  )();
  IntColumn get confidencePpm => integer().nullable().check(
    confidencePpm.isNull() | confidencePpm.isBetweenValues(0, 1000000),
  )();
  TextColumn get explanation => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('estimated'))();
  TextColumn get calculationSource => text()
      .withDefault(const Constant('local'))
      .check(calculationSource.isIn(const ['local', 'server']))();
  IntColumn get createdAtMs => integer()();
  IntColumn get updatedAtMs => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {transactionId, calculationSource},
  ];
}

@DataClassName('SyncConflictRow')
@TableIndex(
  name: 'idx_sync_conflicts_unresolved',
  columns: {#profileId, #resolvedAtMs, #detectedAtMs},
)
class SyncConflicts extends Table {
  @override
  String get tableName => 'sync_conflicts';

  TextColumn get id => text()();
  TextColumn get profileId =>
      text().references(LocalProfiles, #id, onDelete: KeyAction.cascade)();
  TextColumn get mutationId => text().unique()();
  TextColumn get entityType => text()();
  TextColumn get entityId => text()();
  TextColumn get localPayloadJson => text()();
  TextColumn get serverPayloadJson => text()();
  IntColumn get serverVersion =>
      integer().check(serverVersion.isBiggerOrEqualValue(1))();
  IntColumn get detectedAtMs => integer()();
  IntColumn get resolvedAtMs => integer().nullable()();
  TextColumn get resolution => text().nullable().check(
    resolution.isNull() |
        resolution.isIn(const ['keep_local', 'keep_server', 'merged']),
  )();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
