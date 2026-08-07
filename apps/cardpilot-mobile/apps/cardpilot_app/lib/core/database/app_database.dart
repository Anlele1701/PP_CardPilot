import 'package:drift/drift.dart';

import 'database_connection.dart';
import 'tables/profile_tables.dart';
import 'tables/reference_tables.dart';
import 'tables/sync_tables.dart';
import 'tables/user_data_tables.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    LocalProfiles,
    AppSettings,
    MembershipsCache,
    BanksCache,
    CreditCardsCache,
    MerchantCategoryCodesCache,
    RewardRulesCache,
    RewardRuleMccsCache,
    LocalUserCards,
    SyncOutbox,
    SyncState,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  AppDatabase.defaults() : super(openCardPilotDatabase());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) async {
      await migrator.createAll();
    },
    beforeOpen: (_) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}
