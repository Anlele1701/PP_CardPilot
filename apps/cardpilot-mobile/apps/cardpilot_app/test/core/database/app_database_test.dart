import 'dart:io';

import 'package:cardpilot_app/core/database/app_database.dart';
import 'package:cardpilot_app/features/initial_setup/data/datasources/initial_setup_local_data_source.dart';
import 'package:cardpilot_app/features/initial_setup/domain/entities/access_mode.dart';
import 'package:cardpilot_app/features/initial_setup/domain/entities/local_profile.dart';
import 'package:cardpilot_app/features/initial_setup/domain/entities/local_user_card.dart';
import 'package:cardpilot_app/features/initial_setup/domain/entities/local_workspace.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';

void main() {
  late Directory temporaryDirectory;
  late File databaseFile;

  setUp(() async {
    temporaryDirectory = await Directory.systemTemp.createTemp(
      'cardpilot-sqlite-test-',
    );
    databaseFile = File('${temporaryDirectory.path}/cardpilot.sqlite');
  });

  tearDown(() async {
    if (temporaryDirectory.existsSync()) {
      await temporaryDirectory.delete(recursive: true);
    }
  });

  test('creates schema v5 with valid foreign keys', () async {
    final database = AppDatabase(NativeDatabase(databaseFile));
    addTearDown(database.close);

    expect(database.schemaVersion, 5);
    final tables = await database
        .customSelect(
          "SELECT name FROM sqlite_schema WHERE type = 'table' ORDER BY name",
        )
        .get();
    final tableNames = tables.map((row) => row.read<String>('name')).toSet();

    expect(
      tableNames,
      containsAll({
        'app_settings',
        'banks_cache',
        'credit_cards_cache',
        'local_profiles',
        'local_merchants',
        'local_transactions',
        'local_cashback_calculations',
        'local_user_cards',
        'merchant_category_codes_cache',
        'merchant_mcc_candidates_cache',
        'merchant_branches_cache',
        'local_merchant_mcc_contributions',
        'memberships_cache',
        'reward_rule_mccs_cache',
        'reward_rules_cache',
        'sync_outbox',
        'sync_conflicts',
        'sync_state',
      }),
    );

    final foreignKeyErrors = await database
        .customSelect('PRAGMA foreign_key_check')
        .get();
    expect(foreignKeyErrors, isEmpty);
  });

  test(
    'persists and restores the active guest across database reopen',
    () async {
      const workspace = LocalWorkspace(
        localId: 'profile-guest',
        accessMode: AccessMode.guest,
        profile: LocalProfile(displayName: 'An'),
        cards: [
          LocalUserCard(
            id: 'card-guest',
            bankId: 'bank-acb',
            bankName: 'ACB',
            nickname: 'Everyday Visa',
            billingCycleDay: 15,
            creditLimitMinor: 20000000,
          ),
        ],
      );

      final firstDatabase = AppDatabase(NativeDatabase(databaseFile));
      final firstDataSource = InitialSetupLocalDataSource(
        database: firstDatabase,
        uuid: const Uuid(),
      );
      await firstDataSource.save(workspace);
      await firstDatabase.close();

      final reopenedDatabase = AppDatabase(NativeDatabase(databaseFile));
      addTearDown(reopenedDatabase.close);
      final reopenedDataSource = InitialSetupLocalDataSource(
        database: reopenedDatabase,
        uuid: const Uuid(),
      );

      final restored = await reopenedDataSource.loadActiveGuest();
      expect(restored?.localId, workspace.localId);
      expect(restored?.profile.displayName, 'An');
      expect(restored?.cards.single.id, 'card-guest');
      expect(restored?.cards.single.bankId, 'bank-acb');
      expect(restored?.cards.single.nickname, 'Everyday Visa');
      expect(restored?.cards.single.creditLimitMinor, 20000000);
    },
  );

  test(
    'restores only the authenticated profile matching the auth user',
    () async {
      final database = AppDatabase(NativeDatabase(databaseFile));
      addTearDown(database.close);
      final dataSource = InitialSetupLocalDataSource(database: database);

      await dataSource.save(
        const LocalWorkspace(
          localId: 'profile-a',
          accessMode: AccessMode.authenticated,
          profile: LocalProfile(
            displayName: 'Account A',
            authUserId: 'auth-a',
            email: 'a@example.com',
          ),
          cards: [
            LocalUserCard(
              id: 'card-a',
              bankId: 'bank-acb',
              bankName: 'ACB',
              nickname: 'A card',
              billingCycleDay: 5,
            ),
          ],
        ),
      );
      await dataSource.save(
        const LocalWorkspace(
          localId: 'profile-b',
          accessMode: AccessMode.authenticated,
          profile: LocalProfile(
            displayName: 'Account B',
            authUserId: 'auth-b',
            email: 'b@example.com',
          ),
          cards: [
            LocalUserCard(
              id: 'card-b',
              bankId: 'bank-mb',
              bankName: 'MB',
              nickname: 'B card',
              billingCycleDay: 20,
            ),
          ],
        ),
      );

      final accountA = await dataSource.loadForAuthUser('auth-a');
      final accountB = await dataSource.loadForAuthUser('auth-b');

      expect(accountA?.profile.displayName, 'Account A');
      expect(accountA?.cards.single.id, 'card-a');
      expect(accountB?.profile.displayName, 'Account B');
      expect(accountB?.cards.single.id, 'card-b');
    },
  );
}
