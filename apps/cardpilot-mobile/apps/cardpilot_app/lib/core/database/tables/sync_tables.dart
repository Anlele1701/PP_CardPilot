// Drift check constraints refer to their own column getter by design.
// ignore_for_file: recursive_getters

import 'package:drift/drift.dart';

import 'profile_tables.dart';

@DataClassName('SyncOutboxRow')
@TableIndex(
  name: 'idx_sync_outbox_ready',
  columns: {#profileId, #nextAttemptAtMs, #createdAtMs},
)
class SyncOutbox extends Table {
  @override
  String get tableName => 'sync_outbox';

  TextColumn get id => text()();
  TextColumn get profileId =>
      text().references(LocalProfiles, #id, onDelete: KeyAction.cascade)();
  TextColumn get entityType => text()();
  TextColumn get entityId => text()();
  TextColumn get operation =>
      text().check(operation.isIn(const ['create', 'update', 'delete']))();
  TextColumn get payloadJson => text()();
  IntColumn get payloadVersion => integer()
      .withDefault(const Constant(1))
      .check(payloadVersion.isBiggerOrEqualValue(1))();
  IntColumn get baseServerVersion => integer().nullable().check(
    baseServerVersion.isNull() | baseServerVersion.isBiggerOrEqualValue(1),
  )();
  TextColumn get idempotencyKey => text().unique()();
  IntColumn get attemptCount => integer()
      .withDefault(const Constant(0))
      .check(attemptCount.isBiggerOrEqualValue(0))();
  IntColumn get nextAttemptAtMs => integer()();
  TextColumn get lastErrorCode => text().nullable()();
  IntColumn get createdAtMs => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('SyncStateRow')
class SyncState extends Table {
  @override
  String get tableName => 'sync_state';

  TextColumn get scope => text()();
  TextColumn get cursor => text().nullable()();
  IntColumn get datasetVersion => integer().nullable().check(
    datasetVersion.isNull() | datasetVersion.isBiggerOrEqualValue(1),
  )();
  TextColumn get etag => text().nullable()();
  IntColumn get lastAttemptAtMs => integer().nullable()();
  IntColumn get lastSuccessAtMs => integer().nullable()();
  IntColumn get nextCheckAtMs => integer().nullable()();
  TextColumn get lastErrorCode => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {scope};
}
