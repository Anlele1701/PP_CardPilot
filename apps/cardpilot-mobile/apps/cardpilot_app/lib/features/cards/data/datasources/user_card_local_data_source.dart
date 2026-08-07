import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/database/app_database.dart';
import '../../../initial_setup/domain/entities/local_user_card.dart';

class UserCardLocalDataSource {
  UserCardLocalDataSource(this.database, {Uuid? uuid})
    : _uuid = uuid ?? const Uuid();

  final AppDatabase database;
  final Uuid _uuid;

  Future<List<LocalUserCard>> create({
    required String profileId,
    required LocalUserCard card,
  }) async {
    final now = DateTime.now().toUtc().millisecondsSinceEpoch;

    await database.transaction(() async {
      final existingCards = await _getRows(profileId);
      final isDefault = existingCards.isEmpty;
      await database
          .into(database.localUserCards)
          .insert(
            LocalUserCardsCompanion.insert(
              id: card.id,
              profileId: profileId,
              creditCardId: Value(card.creditCardId),
              bankId: Value(card.bankId),
              bankNameSnapshot: card.bankName,
              nickname: card.nickname,
              billingCycleDay: card.billingCycleDay,
              isDefault: Value(isDefault),
              createdAtMs: now,
              updatedAtMs: now,
              syncStatus: const Value('pending'),
            ),
          );
      await _enqueue(
        profileId: profileId,
        cardId: card.id,
        operation: 'create',
        payload: _cardPayload(card, isDefault: isDefault),
        now: now,
      );
    });

    return getCards(profileId);
  }

  Future<List<LocalUserCard>> update({
    required String profileId,
    required LocalUserCard card,
  }) async {
    final now = DateTime.now().toUtc().millisecondsSinceEpoch;

    await database.transaction(() async {
      final existing = await _getCard(profileId, card.id);
      if (existing == null) {
        throw StateError('The card no longer exists.');
      }

      await (database.update(database.localUserCards)..where(
            (row) => row.id.equals(card.id) & row.profileId.equals(profileId),
          ))
          .write(
            LocalUserCardsCompanion(
              creditCardId: Value(card.creditCardId),
              bankId: Value(card.bankId),
              bankNameSnapshot: Value(card.bankName),
              nickname: Value(card.nickname),
              billingCycleDay: Value(card.billingCycleDay),
              updatedAtMs: Value(now),
              syncStatus: const Value('pending'),
            ),
          );
      await _enqueue(
        profileId: profileId,
        cardId: card.id,
        operation: 'update',
        payload: _cardPayload(card, isDefault: existing.isDefault),
        baseServerVersion: existing.serverVersion,
        now: now,
      );
    });

    return getCards(profileId);
  }

  Future<List<LocalUserCard>> delete({
    required String profileId,
    required String cardId,
  }) async {
    final now = DateTime.now().toUtc().millisecondsSinceEpoch;

    await database.transaction(() async {
      final cards = await _getRows(profileId);
      if (cards.length <= 1) {
        throw StateError('Keep at least one card in your workspace.');
      }

      final card = cards.where((row) => row.id == cardId).firstOrNull;
      if (card == null) {
        throw StateError('The card no longer exists.');
      }

      await (database.update(database.localUserCards)..where(
            (row) => row.id.equals(cardId) & row.profileId.equals(profileId),
          ))
          .write(
            LocalUserCardsCompanion(
              deletedAtMs: Value(now),
              updatedAtMs: Value(now),
              isDefault: const Value(false),
              syncStatus: const Value('pending'),
            ),
          );
      await _enqueue(
        profileId: profileId,
        cardId: cardId,
        operation: 'delete',
        payload: const {},
        baseServerVersion: card.serverVersion,
        now: now,
      );

      if (card.isDefault) {
        final replacement = cards.firstWhere((row) => row.id != cardId);
        await (database.update(database.localUserCards)..where(
              (row) =>
                  row.id.equals(replacement.id) &
                  row.profileId.equals(profileId),
            ))
            .write(
              LocalUserCardsCompanion(
                isDefault: const Value(true),
                updatedAtMs: Value(now),
                syncStatus: const Value('pending'),
              ),
            );
        await _enqueue(
          profileId: profileId,
          cardId: replacement.id,
          operation: 'update',
          payload: {
            'bankId': replacement.bankId,
            'creditCardId': replacement.creditCardId,
            'nickname': replacement.nickname,
            'billingCycleDay': replacement.billingCycleDay,
            'isDefault': true,
          },
          baseServerVersion: replacement.serverVersion,
          now: now,
        );
      }
    });

    return getCards(profileId);
  }

  Future<List<LocalUserCard>> getCards(String profileId) async {
    return _toDomain(await _getRows(profileId));
  }

  Future<List<LocalUserCardRow>> _getRows(String profileId) {
    final query = database.select(database.localUserCards)
      ..where(
        (row) => row.profileId.equals(profileId) & row.deletedAtMs.isNull(),
      )
      ..orderBy([
        (row) => OrderingTerm.desc(row.isDefault),
        (row) => OrderingTerm.asc(row.createdAtMs),
      ]);
    return query.get();
  }

  Future<LocalUserCardRow?> _getCard(String profileId, String cardId) {
    final query = database.select(database.localUserCards)
      ..where(
        (row) =>
            row.id.equals(cardId) &
            row.profileId.equals(profileId) &
            row.deletedAtMs.isNull(),
      );
    return query.getSingleOrNull();
  }

  Map<String, Object?> _cardPayload(
    LocalUserCard card, {
    required bool isDefault,
  }) {
    return {
      'bankId': card.bankId,
      'creditCardId': card.creditCardId,
      'nickname': card.nickname,
      'billingCycleDay': card.billingCycleDay,
      'isDefault': isDefault,
    };
  }

  Future<void> _enqueue({
    required String profileId,
    required String cardId,
    required String operation,
    required Map<String, Object?> payload,
    required int now,
    int? baseServerVersion,
  }) {
    final operationId = _uuid.v4();
    return database
        .into(database.syncOutbox)
        .insert(
          SyncOutboxCompanion.insert(
            id: operationId,
            profileId: profileId,
            entityType: 'user_card',
            entityId: cardId,
            operation: operation,
            payloadJson: jsonEncode(payload),
            baseServerVersion: Value(baseServerVersion),
            idempotencyKey: operationId,
            nextAttemptAtMs: now,
            createdAtMs: now,
          ),
        );
  }

  List<LocalUserCard> _toDomain(List<LocalUserCardRow> rows) {
    return rows
        .map(
          (row) => LocalUserCard(
            id: row.id,
            bankId: row.bankId,
            creditCardId: row.creditCardId,
            bankName: row.bankNameSnapshot,
            nickname: row.nickname,
            billingCycleDay: row.billingCycleDay,
          ),
        )
        .toList(growable: false);
  }
}
