// Drift check constraints refer to their own column getter by design.
// ignore_for_file: recursive_getters

import 'package:drift/drift.dart';

@DataClassName('LocalProfileRow')
@TableIndex(
  name: 'idx_local_profiles_sync_status',
  columns: {#syncStatus, #updatedAtMs},
)
@TableIndex.sql(
  'CREATE UNIQUE INDEX uq_local_profiles_auth_user '
  'ON local_profiles (auth_user_id) '
  'WHERE auth_user_id IS NOT NULL AND deleted_at_ms IS NULL',
)
@TableIndex.sql(
  'CREATE UNIQUE INDEX uq_local_profiles_server_user '
  'ON local_profiles (server_user_id) '
  'WHERE server_user_id IS NOT NULL AND deleted_at_ms IS NULL',
)
@TableIndex.sql(
  'CREATE UNIQUE INDEX uq_local_profiles_single_guest '
  'ON local_profiles (access_mode) '
  "WHERE access_mode = 'guest' AND deleted_at_ms IS NULL",
)
class LocalProfiles extends Table {
  @override
  String get tableName => 'local_profiles';

  TextColumn get id => text()();

  TextColumn get authUserId => text().nullable()();

  TextColumn get serverUserId => text().nullable()();

  TextColumn get accessMode =>
      text().check(accessMode.isIn(const ['guest', 'authenticated']))();

  TextColumn get email => text().nullable()();

  TextColumn get displayName => text().withLength(min: 1, max: 40)();

  IntColumn get bornDateAtMs => integer().nullable()();

  IntColumn get setupCompletedAtMs => integer().nullable()();

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

@DataClassName('AppSettingsRow')
@TableIndex(
  name: 'uq_app_settings_installation',
  columns: {#installationId},
  unique: true,
)
class AppSettings extends Table {
  @override
  String get tableName => 'app_settings';

  IntColumn get id =>
      integer().withDefault(const Constant(1)).check(id.equals(1))();

  TextColumn get installationId => text()();

  TextColumn get activeProfileId => text().nullable().references(
    LocalProfiles,
    #id,
    onDelete: KeyAction.setNull,
  )();

  IntColumn get createdAtMs => integer()();

  IntColumn get updatedAtMs => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
