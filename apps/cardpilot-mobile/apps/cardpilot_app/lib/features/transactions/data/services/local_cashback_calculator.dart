import 'dart:math' as math;

import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../../cashback_reference/data/cashback_reference_local_data_source.dart';
import '../../../cashback_reference/domain/cashback_reference.dart';
import '../../domain/entities/local_transaction.dart';

class CashbackEstimate {
  const CashbackEstimate({
    required this.amountMinor,
    required this.confidencePpm,
    required this.explanation,
    this.rewardRuleId,
    this.appliedRatePpm,
  });

  final String? rewardRuleId;
  final int amountMinor;
  final int? appliedRatePpm;
  final int confidencePpm;
  final String explanation;
}

class LocalCashbackCalculator {
  const LocalCashbackCalculator(this.database);

  final AppDatabase database;

  Future<CashbackEstimate> calculate({
    required String profileId,
    required String transactionId,
    required TransactionDraft draft,
  }) async {
    final card =
        await (database.select(database.localUserCards)..where(
              (row) =>
                  row.id.equals(draft.userCardId) &
                  row.profileId.equals(profileId) &
                  row.deletedAtMs.isNull(),
            ))
            .getSingleOrNull();
    final creditCardId = card?.creditCardId;
    if (card == null || creditCardId == null) {
      return _unavailable('This card is not linked to a card product.');
    }

    final rules = await CashbackReferenceLocalDataSource(
      database,
    ).getRules(creditCardId);
    if (rules.isEmpty) {
      return _unavailable(
        'No cached cashback rules are available for this card.',
      );
    }

    final cycle = _billingCycle(draft.transactionAt, card.billingCycleDay);
    final priorSpend = await _sumCycleSpend(
      card.id,
      transactionId,
      cycle.$1,
      cycle.$2,
    );
    final monthlySpend = priorSpend + draft.amountMinor;
    final candidates = <CashbackEstimate>[];

    for (final rule in rules) {
      final estimate = await _evaluateRule(
        rule: rule,
        cardId: card.id,
        transactionId: transactionId,
        draft: draft,
        monthlySpend: monthlySpend,
        cycleStart: cycle.$1,
        cycleEnd: cycle.$2,
      );
      if (estimate != null) candidates.add(estimate);
    }

    if (candidates.isEmpty) {
      return _unavailable(
        'MCC ${draft.mccCode} does not match an active cashback rule for this card.',
      );
    }
    candidates.sort((a, b) => b.amountMinor.compareTo(a.amountMinor));
    return candidates.first;
  }

  Future<CashbackEstimate?> _evaluateRule({
    required RewardRule rule,
    required String cardId,
    required String transactionId,
    required TransactionDraft draft,
    required int monthlySpend,
    required DateTime cycleStart,
    required DateTime cycleEnd,
  }) async {
    if (rule.rewardType != 'cashback' || rule.cashbackRate == null) return null;
    if (!_isEffective(rule, draft.transactionAt)) return null;
    if (rule.eligibleChannel.toLowerCase() != 'any') return null;

    final excluded = rule.mccs.any(
      (mapping) =>
          mapping.mccCode == draft.mccCode &&
          {'excluded', 'ineligible'}.contains(mapping.matchType.toLowerCase()),
    );
    if (excluded) return null;
    final eligibleMappings = rule.mccs.where(
      (mapping) =>
          !{'excluded', 'ineligible'}.contains(mapping.matchType.toLowerCase()),
    );
    if (eligibleMappings.isNotEmpty &&
        !eligibleMappings.any((mapping) => mapping.mccCode == draft.mccCode)) {
      return null;
    }

    final ratePpm = (rule.cashbackRate! * 1000000).round();
    final minimumTransaction = rule.minimumTransactionAmount ?? 0;
    if (draft.amountMinor < minimumTransaction) {
      return CashbackEstimate(
        rewardRuleId: rule.id,
        amountMinor: 0,
        appliedRatePpm: ratePpm,
        confidencePpm: _confidence(rule, draft),
        explanation:
            '${rule.name}: transaction is below the minimum of $minimumTransaction VND.',
      );
    }
    final minimumMonthlySpend = rule.minimumMonthlySpend ?? 0;
    if (monthlySpend < minimumMonthlySpend) {
      return CashbackEstimate(
        rewardRuleId: rule.id,
        amountMinor: 0,
        appliedRatePpm: ratePpm,
        confidencePpm: _confidence(rule, draft),
        explanation:
            '${rule.name}: current cycle spend has not reached $minimumMonthlySpend VND.',
      );
    }

    final rawAmount = (draft.amountMinor * ratePpm + 500000) ~/ 1000000;
    final cap = rule.monthlyCapAmount;
    var amount = rawAmount;
    var capText = '';
    if (cap != null) {
      final used = await _sumRuleCashback(
        cardId,
        transactionId,
        rule.id,
        cycleStart,
        cycleEnd,
      );
      final remaining = math.max(0, cap - used);
      amount = math.min(rawAmount, remaining);
      capText =
          ' Monthly cap remaining before this transaction: $remaining VND.';
    }

    final ratePercent = (rule.cashbackRate! * 100).toStringAsFixed(2);
    return CashbackEstimate(
      rewardRuleId: rule.id,
      amountMinor: amount,
      appliedRatePpm: ratePpm,
      confidencePpm: _confidence(rule, draft),
      explanation:
          '${rule.name}: $ratePercent% for MCC ${draft.mccCode}.$capText'
          '${rule.conditionsText == null ? '' : ' ${rule.conditionsText}'}',
    );
  }

  Future<int> _sumCycleSpend(
    String cardId,
    String excludedTransactionId,
    DateTime start,
    DateTime end,
  ) async {
    final rows =
        await (database.select(database.localTransactions)..where(
              (row) =>
                  row.userCardId.equals(cardId) &
                  row.id.equals(excludedTransactionId).not() &
                  row.deletedAtMs.isNull() &
                  row.transactionAtMs.isBiggerOrEqualValue(
                    start.toUtc().millisecondsSinceEpoch,
                  ) &
                  row.transactionAtMs.isSmallerThanValue(
                    end.toUtc().millisecondsSinceEpoch,
                  ),
            ))
            .get();
    return rows.fold<int>(0, (total, row) => total + row.amountMinor);
  }

  Future<int> _sumRuleCashback(
    String cardId,
    String excludedTransactionId,
    String ruleId,
    DateTime start,
    DateTime end,
  ) async {
    final transactions = database.localTransactions;
    final calculations = database.localCashbackCalculations;
    final rows =
        await (database.select(calculations).join([
              innerJoin(
                transactions,
                transactions.id.equalsExp(calculations.transactionId),
              ),
            ])..where(
              calculations.userCardId.equals(cardId) &
                  calculations.rewardRuleId.equals(ruleId) &
                  transactions.id.equals(excludedTransactionId).not() &
                  transactions.deletedAtMs.isNull() &
                  transactions.transactionAtMs.isBiggerOrEqualValue(
                    start.toUtc().millisecondsSinceEpoch,
                  ) &
                  transactions.transactionAtMs.isSmallerThanValue(
                    end.toUtc().millisecondsSinceEpoch,
                  ),
            ))
            .get();
    return rows.fold<int>(
      0,
      (total, row) =>
          total + (row.readTable(calculations).estimatedCashbackMinor ?? 0),
    );
  }

  bool _isEffective(RewardRule rule, DateTime transactionAt) {
    final day = DateTime(
      transactionAt.year,
      transactionAt.month,
      transactionAt.day,
    );
    final from = rule.effectiveFrom;
    final to = rule.effectiveTo;
    return (from == null || !day.isBefore(from)) &&
        (to == null || !day.isAfter(to));
  }

  int _confidence(RewardRule rule, TransactionDraft draft) {
    return math.min(
      rule.confidencePpm ?? 1000000,
      draft.mccConfidencePpm ?? 1000000,
    );
  }

  CashbackEstimate _unavailable(String explanation) {
    return CashbackEstimate(
      amountMinor: 0,
      confidencePpm: 0,
      explanation: explanation,
    );
  }

  (DateTime, DateTime) _billingCycle(DateTime date, int billingDay) {
    final boundary = _clampedDate(date.year, date.month, billingDay);
    return !date.isBefore(boundary)
        ? (boundary, _clampedDate(date.year, date.month + 1, billingDay))
        : (_clampedDate(date.year, date.month - 1, billingDay), boundary);
  }

  DateTime _clampedDate(int year, int month, int day) {
    final normalized = DateTime(year, month);
    final lastDay = DateTime(normalized.year, normalized.month + 1, 0).day;
    return DateTime(normalized.year, normalized.month, math.min(day, lastDay));
  }
}
