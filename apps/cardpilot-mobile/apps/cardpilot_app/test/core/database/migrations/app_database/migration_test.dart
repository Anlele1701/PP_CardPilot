// dart format width=80
// ignore_for_file: unused_local_variable, unused_import
import 'package:drift/drift.dart';
import 'package:drift_dev/api/migrations_native.dart';
import 'package:cardpilot_app/core/database/app_database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'generated/schema.dart';

import 'generated/schema_v1.dart' as v1;
import 'generated/schema_v2.dart' as v2;

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  late SchemaVerifier verifier;

  setUpAll(() {
    verifier = SchemaVerifier(GeneratedHelper());
  });

  group('simple database migrations', () {
    // These simple tests verify all possible schema updates with a simple (no
    // data) migration. This is a quick way to ensure that written database
    // migrations properly alter the schema.
    const versions = GeneratedHelper.versions;
    for (final (i, fromVersion) in versions.indexed) {
      group('from $fromVersion', () {
        for (final toVersion in versions.skip(i + 1)) {
          test('to $toVersion', () async {
            final schema = await verifier.schemaAt(fromVersion);
            final db = AppDatabase(schema.newConnection());
            await verifier.migrateAndValidate(db, toVersion);
            await db.close();
          });
        }
      });
    }
  });

  // The following template shows how to write tests ensuring your migrations
  // preserve existing data.
  // Testing this can be useful for migrations that change existing columns
  // (e.g. by alterating their type or constraints). Migrations that only add
  // tables or columns typically don't need these advanced tests. For more
  // information, see https://drift.simonbinder.eu/migrations/tests/#verifying-data-integrity
  // TODO: This generated template shows how these tests could be written. Adopt
  // it to your own needs when testing migrations with data integrity.
  test('migration from v1 to v2 does not corrupt data', () async {
    // Add data to insert into the old database, and the expected rows after the
    // migration.
    // TODO: Fill these lists
    final oldLocalProfilesData = <v1.LocalProfilesData>[];
    final expectedNewLocalProfilesData = <v2.LocalProfilesData>[];

    final oldAppSettingsData = <v1.AppSettingsData>[];
    final expectedNewAppSettingsData = <v2.AppSettingsData>[];

    final oldMembershipsCacheData = <v1.MembershipsCacheData>[];
    final expectedNewMembershipsCacheData = <v2.MembershipsCacheData>[];

    final oldBanksCacheData = <v1.BanksCacheData>[];
    final expectedNewBanksCacheData = <v2.BanksCacheData>[];

    final oldCreditCardsCacheData = <v1.CreditCardsCacheData>[];
    final expectedNewCreditCardsCacheData = <v2.CreditCardsCacheData>[];

    final oldMerchantCategoryCodesCacheData =
        <v1.MerchantCategoryCodesCacheData>[];
    final expectedNewMerchantCategoryCodesCacheData =
        <v2.MerchantCategoryCodesCacheData>[];

    final oldRewardRulesCacheData = <v1.RewardRulesCacheData>[];
    final expectedNewRewardRulesCacheData = <v2.RewardRulesCacheData>[];

    final oldRewardRuleMccsCacheData = <v1.RewardRuleMccsCacheData>[];
    final expectedNewRewardRuleMccsCacheData = <v2.RewardRuleMccsCacheData>[];

    final oldLocalUserCardsData = <v1.LocalUserCardsData>[];
    final expectedNewLocalUserCardsData = <v2.LocalUserCardsData>[];

    final oldSyncOutboxData = <v1.SyncOutboxData>[];
    final expectedNewSyncOutboxData = <v2.SyncOutboxData>[];

    final oldSyncStateData = <v1.SyncStateData>[];
    final expectedNewSyncStateData = <v2.SyncStateData>[];

    await verifier.testWithDataIntegrity(
      oldVersion: 1,
      newVersion: 2,
      createOld: v1.DatabaseAtV1.new,
      createNew: v2.DatabaseAtV2.new,
      openTestedDatabase: AppDatabase.new,
      createItems: (batch, oldDb) {
        batch.insertAll(oldDb.localProfiles, oldLocalProfilesData);
        batch.insertAll(oldDb.appSettings, oldAppSettingsData);
        batch.insertAll(oldDb.membershipsCache, oldMembershipsCacheData);
        batch.insertAll(oldDb.banksCache, oldBanksCacheData);
        batch.insertAll(oldDb.creditCardsCache, oldCreditCardsCacheData);
        batch.insertAll(
          oldDb.merchantCategoryCodesCache,
          oldMerchantCategoryCodesCacheData,
        );
        batch.insertAll(oldDb.rewardRulesCache, oldRewardRulesCacheData);
        batch.insertAll(oldDb.rewardRuleMccsCache, oldRewardRuleMccsCacheData);
        batch.insertAll(oldDb.localUserCards, oldLocalUserCardsData);
        batch.insertAll(oldDb.syncOutbox, oldSyncOutboxData);
        batch.insertAll(oldDb.syncState, oldSyncStateData);
      },
      validateItems: (newDb) async {
        expect(
          expectedNewLocalProfilesData,
          await newDb.select(newDb.localProfiles).get(),
        );
        expect(
          expectedNewAppSettingsData,
          await newDb.select(newDb.appSettings).get(),
        );
        expect(
          expectedNewMembershipsCacheData,
          await newDb.select(newDb.membershipsCache).get(),
        );
        expect(
          expectedNewBanksCacheData,
          await newDb.select(newDb.banksCache).get(),
        );
        expect(
          expectedNewCreditCardsCacheData,
          await newDb.select(newDb.creditCardsCache).get(),
        );
        expect(
          expectedNewMerchantCategoryCodesCacheData,
          await newDb.select(newDb.merchantCategoryCodesCache).get(),
        );
        expect(
          expectedNewRewardRulesCacheData,
          await newDb.select(newDb.rewardRulesCache).get(),
        );
        expect(
          expectedNewRewardRuleMccsCacheData,
          await newDb.select(newDb.rewardRuleMccsCache).get(),
        );
        expect(
          expectedNewLocalUserCardsData,
          await newDb.select(newDb.localUserCards).get(),
        );
        expect(
          expectedNewSyncOutboxData,
          await newDb.select(newDb.syncOutbox).get(),
        );
        expect(
          expectedNewSyncStateData,
          await newDb.select(newDb.syncState).get(),
        );
      },
    );
  });
}
