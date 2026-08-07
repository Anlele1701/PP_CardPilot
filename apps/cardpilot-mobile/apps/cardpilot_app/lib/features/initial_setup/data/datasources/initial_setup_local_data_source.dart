import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/access_mode.dart';
import '../../domain/entities/local_profile.dart';
import '../../domain/entities/local_user_card.dart';
import '../../domain/entities/local_workspace.dart';

class InitialSetupLocalDataSource {
  InitialSetupLocalDataSource({required AppDatabase database, Uuid? uuid})
    : _database = database,
      _uuid = uuid ?? const Uuid();

  final AppDatabase _database;
  final Uuid _uuid;

  Future<void> save(LocalWorkspace workspace) async {
    final now = DateTime.now().toUtc().millisecondsSinceEpoch;

    await _database.transaction(() async {
      await _database
          .into(_database.localProfiles)
          .insertOnConflictUpdate(
            LocalProfilesCompanion.insert(
              id: workspace.localId,
              authUserId: Value(workspace.profile.authUserId),
              accessMode: workspace.accessMode.name,
              email: Value(workspace.profile.email),
              displayName: workspace.profile.displayName,
              setupCompletedAtMs: Value(now),
              createdAtMs: now,
              updatedAtMs: now,
              syncStatus: const Value('local_only'),
            ),
          );

      await (_database.delete(
        _database.localUserCards,
      )..where((card) => card.profileId.equals(workspace.localId))).go();

      for (var index = 0; index < workspace.cards.length; index += 1) {
        final card = workspace.cards[index];
        await _database
            .into(_database.localUserCards)
            .insert(
              LocalUserCardsCompanion.insert(
                id: card.id,
                profileId: workspace.localId,
                creditCardId: Value(card.creditCardId),
                bankId: Value(card.bankId),
                bankNameSnapshot: card.bankName,
                nickname: card.nickname,
                billingCycleDay: card.billingCycleDay,
                isDefault: Value(index == 0),
                createdAtMs: now,
                updatedAtMs: now,
                syncStatus: const Value('local_only'),
              ),
            );
      }

      final settings = await (_database.select(
        _database.appSettings,
      )..where((row) => row.id.equals(1))).getSingleOrNull();

      if (settings == null) {
        await _database
            .into(_database.appSettings)
            .insert(
              AppSettingsCompanion.insert(
                installationId: _uuid.v4(),
                activeProfileId: Value(workspace.localId),
                createdAtMs: now,
                updatedAtMs: now,
              ),
            );
      } else {
        await (_database.update(
          _database.appSettings,
        )..where((row) => row.id.equals(1))).write(
          AppSettingsCompanion(
            activeProfileId: Value(workspace.localId),
            updatedAtMs: Value(now),
          ),
        );
      }
    });
  }

  Future<LocalWorkspace?> loadActiveGuest() async {
    final settings = await (_database.select(
      _database.appSettings,
    )..where((row) => row.id.equals(1))).getSingleOrNull();
    final profileId = settings?.activeProfileId;
    if (profileId == null) {
      return null;
    }

    final workspace = await _loadProfile(profileId);
    return workspace?.accessMode == AccessMode.guest ? workspace : null;
  }

  Future<LocalWorkspace?> loadForAuthUser(String authUserId) async {
    final profile =
        await (_database.select(_database.localProfiles)..where(
              (row) =>
                  row.authUserId.equals(authUserId) & row.deletedAtMs.isNull(),
            ))
            .getSingleOrNull();
    if (profile == null) {
      return null;
    }

    await _activateProfile(profile.id);
    return _loadProfile(profile.id);
  }

  Future<void> _activateProfile(String profileId) async {
    final now = DateTime.now().toUtc().millisecondsSinceEpoch;
    await (_database.update(
      _database.appSettings,
    )..where((row) => row.id.equals(1))).write(
      AppSettingsCompanion(
        activeProfileId: Value(profileId),
        updatedAtMs: Value(now),
      ),
    );
  }

  Future<LocalWorkspace?> _loadProfile(String profileId) async {
    final profile =
        await (_database.select(_database.localProfiles)..where(
              (row) => row.id.equals(profileId) & row.deletedAtMs.isNull(),
            ))
            .getSingleOrNull();

    if (profile == null || profile.setupCompletedAtMs == null) {
      return null;
    }

    final cards =
        await (_database.select(_database.localUserCards)
              ..where(
                (row) =>
                    row.profileId.equals(profileId) & row.deletedAtMs.isNull(),
              )
              ..orderBy([(row) => OrderingTerm.asc(row.createdAtMs)]))
            .get();

    if (cards.isEmpty) {
      return null;
    }

    return LocalWorkspace(
      localId: profile.id,
      accessMode: AccessMode.values.byName(profile.accessMode),
      profile: LocalProfile(
        displayName: profile.displayName,
        authUserId: profile.authUserId,
        email: profile.email,
      ),
      cards: cards
          .map(
            (card) => LocalUserCard(
              id: card.id,
              creditCardId: card.creditCardId,
              bankId: card.bankId,
              bankName: card.bankNameSnapshot,
              nickname: card.nickname,
              billingCycleDay: card.billingCycleDay,
            ),
          )
          .toList(growable: false),
    );
  }
}
