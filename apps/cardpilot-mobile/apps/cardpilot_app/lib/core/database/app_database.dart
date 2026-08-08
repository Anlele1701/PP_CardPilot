import 'package:drift/drift.dart';

import 'app_database.steps.dart';
import 'database_connection.dart';
import 'tables/profile_tables.dart';
import 'tables/reference_tables.dart';
import 'tables/sync_tables.dart';
import 'tables/transaction_tables.dart';
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
    MerchantMccCandidatesCache,
    MerchantBranchesCache,
    LocalUserCards,
    LocalMerchantMccContributions,
    SyncOutbox,
    SyncState,
    LocalMerchants,
    LocalTransactions,
    LocalCashbackCalculations,
    SyncConflicts,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  AppDatabase.defaults() : super(openCardPilotDatabase());

  @override
  int get schemaVersion => 5;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) async {
      await migrator.createAll();
    },
    onUpgrade: stepByStep(
      from1To2: (migrator, schema) async {
        await migrator.createTable(schema.localMerchants);
        await migrator.createTable(schema.localTransactions);
        await migrator.createTable(schema.localCashbackCalculations);
        await migrator.createTable(schema.syncConflicts);
        await migrator.createIndex(schema.idxLocalMerchantsProfileName);
        await migrator.createIndex(schema.uqLocalMerchantsServerId);
        await migrator.createIndex(schema.idxLocalTransactionsProfileDate);
        await migrator.createIndex(schema.idxLocalTransactionsCardDate);
        await migrator.createIndex(schema.idxLocalTransactionsProfileSync);
        await migrator.createIndex(schema.idxLocalCashbackProfileCard);
        await migrator.createIndex(schema.idxSyncConflictsUnresolved);
      },
      from2To3: (migrator, schema) async {
        await migrator.addColumn(
          schema.localUserCards,
          schema.localUserCards.creditLimitMinor,
        );
      },
      from3To4: (migrator, schema) async {
        await migrator.createTable(schema.merchantMccCandidatesCache);
        await migrator.createIndex(schema.idxMerchantMccCandidatesCacheName);
        await migrator.createIndex(schema.idxMerchantMccCandidatesCacheMcc);
      },
      from4To5: (migrator, schema) async {
        await migrator.addColumn(
          schema.merchantMccCandidatesCache,
          schema.merchantMccCandidatesCache.paymentType,
        );
        await migrator.createTable(schema.merchantBranchesCache);
        await migrator.createIndex(schema.idxMerchantBranchesCacheName);
        await migrator.createTable(schema.localMerchantMccContributions);
        await migrator.createIndex(
          schema.idxLocalMerchantMccContributionsProfileMerchant,
        );
      },
    ),
    beforeOpen: (_) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}
