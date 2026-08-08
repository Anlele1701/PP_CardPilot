import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/local_transaction.dart';
import '../services/local_cashback_calculator.dart';

class TransactionLocalDataSource {
  TransactionLocalDataSource(this.database, {Uuid? uuid})
    : _uuid = uuid ?? const Uuid();

  final AppDatabase database;
  final Uuid _uuid;

  Stream<List<LocalTransaction>> watchTransactions(String profileId) {
    final transactions = database.localTransactions;
    final cards = database.localUserCards;
    final merchants = database.localMerchants;
    final calculations = database.localCashbackCalculations;
    final rules = database.rewardRulesCache;
    final query =
        database.select(transactions).join([
            innerJoin(cards, cards.id.equalsExp(transactions.userCardId)),
            leftOuterJoin(
              merchants,
              merchants.id.equalsExp(transactions.merchantId),
            ),
            leftOuterJoin(
              calculations,
              calculations.transactionId.equalsExp(transactions.id) &
                  calculations.calculationSource.equals('local'),
            ),
            leftOuterJoin(rules, rules.id.equalsExp(calculations.rewardRuleId)),
          ])
          ..where(
            transactions.profileId.equals(profileId) &
                transactions.deletedAtMs.isNull(),
          )
          ..orderBy([OrderingTerm.desc(transactions.transactionAtMs)]);

    return query.watch().map(
      (rows) => rows
          .map((row) {
            final transaction = row.readTable(transactions);
            final card = row.readTable(cards);
            final merchant = row.readTableOrNull(merchants);
            final calculation = row.readTableOrNull(calculations);
            final rewardRule = row.readTableOrNull(rules);
            return LocalTransaction(
              id: transaction.id,
              profileId: transaction.profileId,
              userCardId: transaction.userCardId,
              cardNickname: card.nickname,
              merchantId: transaction.merchantId,
              merchantName: merchant?.nameRaw ?? 'Unknown merchant',
              transactionAt: DateTime.fromMillisecondsSinceEpoch(
                transaction.transactionAtMs,
                isUtc: true,
              ).toLocal(),
              amountMinor: transaction.amountMinor,
              currency: transaction.currency,
              category: transaction.category,
              source: transaction.source,
              note: transaction.note,
              mccCode: transaction.mccCode,
              cashbackEstimatedMinor: transaction.cashbackEstimatedMinor,
              cashbackRatePpm: calculation?.appliedRatePpm,
              cashbackExplanation: calculation?.explanation,
              rewardRuleName: rewardRule?.name,
            );
          })
          .toList(growable: false),
    );
  }

  Future<void> create({
    required String profileId,
    required String transactionId,
    required TransactionDraft draft,
  }) async {
    final now = DateTime.now().toUtc().millisecondsSinceEpoch;
    await database.transaction(() async {
      final merchant = await _findOrCreateMerchant(profileId, draft, now);
      final estimate = await LocalCashbackCalculator(database).calculate(
        profileId: profileId,
        transactionId: transactionId,
        draft: draft,
      );
      await database
          .into(database.localTransactions)
          .insert(
            LocalTransactionsCompanion.insert(
              id: transactionId,
              profileId: profileId,
              userCardId: draft.userCardId,
              merchantId: Value(merchant.id),
              transactionAtMs: draft.transactionAt
                  .toUtc()
                  .millisecondsSinceEpoch,
              amountMinor: draft.amountMinor,
              mccCode: Value(draft.mccCode),
              mccSource: Value(draft.mccSource),
              category: Value(_nullableTrimmed(draft.category)),
              cashbackEstimatedMinor: Value(estimate.amountMinor),
              cashbackConfidencePpm: Value(estimate.confidencePpm),
              source: const Value('manual'),
              note: Value(_nullableTrimmed(draft.note)),
              createdAtMs: now,
              updatedAtMs: now,
              syncStatus: const Value('pending'),
            ),
          );
      await _replaceCalculation(
        profileId: profileId,
        transactionId: transactionId,
        userCardId: draft.userCardId,
        estimate: estimate,
        now: now,
      );
      await _enqueue(
        profileId: profileId,
        entityType: 'transaction',
        entityId: transactionId,
        operation: 'create',
        payload: _transactionPayload(draft, merchant.id),
        now: now,
      );
    });
  }

  Future<void> update({
    required String profileId,
    required String transactionId,
    required TransactionDraft draft,
  }) async {
    final now = DateTime.now().toUtc().millisecondsSinceEpoch;
    await database.transaction(() async {
      final existing = await _getTransaction(profileId, transactionId);
      if (existing == null) {
        throw StateError('The transaction no longer exists.');
      }
      final merchant = await _findOrCreateMerchant(profileId, draft, now);
      final estimate = await LocalCashbackCalculator(database).calculate(
        profileId: profileId,
        transactionId: transactionId,
        draft: draft,
      );
      await (database.update(database.localTransactions)..where(
            (row) =>
                row.id.equals(transactionId) & row.profileId.equals(profileId),
          ))
          .write(
            LocalTransactionsCompanion(
              userCardId: Value(draft.userCardId),
              merchantId: Value(merchant.id),
              transactionAtMs: Value(
                draft.transactionAt.toUtc().millisecondsSinceEpoch,
              ),
              amountMinor: Value(draft.amountMinor),
              mccCode: Value(draft.mccCode),
              mccSource: Value(draft.mccSource),
              category: Value(_nullableTrimmed(draft.category)),
              cashbackEstimatedMinor: Value(estimate.amountMinor),
              cashbackConfidencePpm: Value(estimate.confidencePpm),
              note: Value(_nullableTrimmed(draft.note)),
              updatedAtMs: Value(now),
              syncStatus: const Value('pending'),
            ),
          );
      await _replaceCalculation(
        profileId: profileId,
        transactionId: transactionId,
        userCardId: draft.userCardId,
        estimate: estimate,
        now: now,
      );
      await _enqueue(
        profileId: profileId,
        entityType: 'transaction',
        entityId: transactionId,
        operation: 'update',
        payload: _transactionPayload(draft, merchant.id),
        baseServerVersion: existing.serverVersion,
        now: now,
      );
    });
  }

  Future<void> delete({
    required String profileId,
    required String transactionId,
  }) async {
    final now = DateTime.now().toUtc().millisecondsSinceEpoch;
    await database.transaction(() async {
      final existing = await _getTransaction(profileId, transactionId);
      if (existing == null) {
        throw StateError('The transaction no longer exists.');
      }
      await (database.update(database.localTransactions)..where(
            (row) =>
                row.id.equals(transactionId) & row.profileId.equals(profileId),
          ))
          .write(
            LocalTransactionsCompanion(
              deletedAtMs: Value(now),
              updatedAtMs: Value(now),
              syncStatus: const Value('pending'),
            ),
          );
      await _enqueue(
        profileId: profileId,
        entityType: 'transaction',
        entityId: transactionId,
        operation: 'delete',
        payload: const {},
        baseServerVersion: existing.serverVersion,
        now: now,
      );
    });
  }

  Future<LocalMerchantRow> _findOrCreateMerchant(
    String profileId,
    TransactionDraft draft,
    int now,
  ) async {
    final rawName = draft.merchantName.trim();
    final normalizedName = rawName.toLowerCase();
    final serverMerchantId = draft.merchantServerId;
    final query = database.select(database.localMerchants)
      ..where(
        (row) =>
            row.profileId.equals(profileId) &
            row.deletedAtMs.isNull() &
            (serverMerchantId == null
                ? row.nameNormalized.equals(normalizedName)
                : row.serverMerchantId.equals(serverMerchantId)),
      )
      ..limit(1);
    final existing = await query.getSingleOrNull();
    if (existing != null) {
      return existing;
    }

    final merchantId = _uuid.v4();
    await database
        .into(database.localMerchants)
        .insert(
          LocalMerchantsCompanion.insert(
            id: merchantId,
            profileId: profileId,
            serverMerchantId: Value(serverMerchantId),
            nameRaw: rawName,
            nameNormalized: normalizedName,
            locationText: Value(draft.merchantLocation),
            createdAtMs: now,
            updatedAtMs: now,
            syncStatus: Value(serverMerchantId == null ? 'pending' : 'synced'),
          ),
        );
    if (serverMerchantId == null) {
      await _enqueue(
        profileId: profileId,
        entityType: 'merchant',
        entityId: merchantId,
        operation: 'create',
        payload: {'name': rawName, 'countryCode': 'VN'},
        now: now,
      );
    }
    return (database.select(
      database.localMerchants,
    )..where((row) => row.id.equals(merchantId))).getSingle();
  }

  Future<LocalTransactionRow?> _getTransaction(
    String profileId,
    String transactionId,
  ) {
    return (database.select(database.localTransactions)..where(
          (row) =>
              row.id.equals(transactionId) &
              row.profileId.equals(profileId) &
              row.deletedAtMs.isNull(),
        ))
        .getSingleOrNull();
  }

  Map<String, Object?> _transactionPayload(
    TransactionDraft draft,
    String merchantId,
  ) {
    return {
      'userCardId': draft.userCardId,
      'merchantId': merchantId,
      'merchantServerId': draft.merchantServerId,
      'transactionAt': draft.transactionAt.toUtc().toIso8601String(),
      'amountMinor': draft.amountMinor,
      'currency': 'VND',
      'mccCode': draft.mccCode,
      'mccSource': draft.mccSource,
      'category': _nullableTrimmed(draft.category),
      'source': 'manual',
      'note': _nullableTrimmed(draft.note),
    };
  }

  Future<void> _replaceCalculation({
    required String profileId,
    required String transactionId,
    required String userCardId,
    required CashbackEstimate estimate,
    required int now,
  }) async {
    await (database.delete(database.localCashbackCalculations)..where(
          (row) =>
              row.transactionId.equals(transactionId) &
              row.calculationSource.equals('local'),
        ))
        .go();
    await database
        .into(database.localCashbackCalculations)
        .insert(
          LocalCashbackCalculationsCompanion.insert(
            id: _uuid.v4(),
            profileId: profileId,
            transactionId: transactionId,
            userCardId: userCardId,
            rewardRuleId: Value(estimate.rewardRuleId),
            estimatedCashbackMinor: Value(estimate.amountMinor),
            appliedRatePpm: Value(estimate.appliedRatePpm),
            confidencePpm: Value(estimate.confidencePpm),
            explanation: Value(estimate.explanation),
            createdAtMs: now,
            updatedAtMs: now,
          ),
        );
  }

  Future<void> _enqueue({
    required String profileId,
    required String entityType,
    required String entityId,
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
            entityType: entityType,
            entityId: entityId,
            operation: operation,
            payloadJson: jsonEncode(payload),
            baseServerVersion: Value(baseServerVersion),
            idempotencyKey: operationId,
            nextAttemptAtMs: now,
            createdAtMs: now,
          ),
        );
  }

  String? _nullableTrimmed(String? value) {
    final trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }
}
