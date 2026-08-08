import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../domain/cashback_reference.dart';

class CashbackReferenceLocalDataSource {
  const CashbackReferenceLocalDataSource(this.database);

  static const _datasetVersion = 1;
  final AppDatabase database;

  Future<List<MerchantCategoryCode>> getMccs() async {
    final rows =
        await (database.select(database.merchantCategoryCodesCache)
              ..where((row) => row.isActive.equals(true))
              ..orderBy([(row) => OrderingTerm.asc(row.code)]))
            .get();
    return rows
        .map(
          (row) => MerchantCategoryCode(
            code: row.code,
            description: row.description,
            category: row.category,
          ),
        )
        .toList(growable: false);
  }

  Future<void> replaceMccs(List<MerchantCategoryCode> items) async {
    if (items.isEmpty) return;
    await database.transaction(() async {
      await database.delete(database.merchantCategoryCodesCache).go();
      await database.batch((batch) {
        batch.insertAll(
          database.merchantCategoryCodesCache,
          items
              .map(
                (item) => MerchantCategoryCodesCacheCompanion.insert(
                  code: item.code,
                  description: item.description,
                  category: Value(item.category),
                  datasetVersion: _datasetVersion,
                ),
              )
              .toList(growable: false),
        );
      });
    });
  }

  Future<List<RewardRule>> getRules(String creditCardId) async {
    final rules =
        await (database.select(database.rewardRulesCache)..where(
              (row) =>
                  row.creditCardId.equals(creditCardId) &
                  row.isActive.equals(true),
            ))
            .get();
    if (rules.isEmpty) return const [];
    final ids = rules.map((rule) => rule.id).toList(growable: false);
    final mappings = await (database.select(
      database.rewardRuleMccsCache,
    )..where((row) => row.rewardRuleId.isIn(ids))).get();
    return rules
        .map(
          (row) => RewardRule(
            id: row.id,
            creditCardId: row.creditCardId,
            name: row.name,
            rewardType: row.rewardType,
            cashbackRate: double.tryParse(row.cashbackRateDecimal ?? ''),
            pointsRate: double.tryParse(row.pointsRateDecimal ?? ''),
            monthlyCapAmount: _money(row.monthlyCapAmountDecimal),
            minimumTransactionAmount: _money(row.minimumTransactionDecimal),
            minimumMonthlySpend: _money(row.minimumMonthlySpendDecimal),
            eligibleChannel: row.eligibleChannel,
            conditionsText: row.conditionsText,
            effectiveFrom: DateTime.tryParse(row.effectiveFrom ?? ''),
            effectiveTo: DateTime.tryParse(row.effectiveTo ?? ''),
            confidencePpm: row.confidencePpm,
            mccs: mappings
                .where((mapping) => mapping.rewardRuleId == row.id)
                .map(
                  (mapping) => RewardRuleMcc(
                    id: mapping.id,
                    mccCode: mapping.mccCode,
                    matchType: mapping.matchType,
                  ),
                )
                .toList(growable: false),
          ),
        )
        .toList(growable: false);
  }

  Future<void> replaceRules(String creditCardId, List<RewardRule> rules) async {
    await database.transaction(() async {
      final oldRules = await (database.select(
        database.rewardRulesCache,
      )..where((row) => row.creditCardId.equals(creditCardId))).get();
      final oldIds = oldRules.map((rule) => rule.id).toList(growable: false);
      if (oldIds.isNotEmpty) {
        await (database.delete(
          database.rewardRuleMccsCache,
        )..where((row) => row.rewardRuleId.isIn(oldIds))).go();
      }
      await (database.delete(
        database.rewardRulesCache,
      )..where((row) => row.creditCardId.equals(creditCardId))).go();
      if (rules.isEmpty) return;
      await database.batch((batch) {
        batch.insertAll(
          database.rewardRulesCache,
          rules.map(_ruleCompanion).toList(growable: false),
        );
        batch.insertAll(
          database.rewardRuleMccsCache,
          rules
              .expand(
                (rule) => rule.mccs.map(
                  (mapping) => _mappingCompanion(rule.id, mapping),
                ),
              )
              .toList(growable: false),
        );
      });
    });
  }

  Future<void> cacheSuggestions(List<MerchantMccSuggestion> items) async {
    if (items.isEmpty) return;
    await database.batch((batch) {
      batch.insertAllOnConflictUpdate(
        database.merchantMccCandidatesCache,
        items
            .map(
              (item) => MerchantMccCandidatesCacheCompanion.insert(
                id: item.id,
                merchantServerId: item.merchantId,
                merchantName: item.merchantName,
                merchantNameNormalized: item.merchantName.toLowerCase().trim(),
                locationText: Value(item.locationText),
                mccCode: item.mccCode,
                mccDescription: Value(item.mccDescription),
                paymentType: Value(item.paymentType),
                source: item.source,
                confidencePpm: Value(item.confidencePpm),
                status: item.status,
              ),
            )
            .toList(growable: false),
      );
    });
  }

  Future<List<MerchantMccSuggestion>> getSuggestions(String query) async {
    final normalized = query.toLowerCase().trim();
    if (normalized.length < 2) return const [];
    final rows =
        await (database.select(database.merchantMccCandidatesCache)
              ..where((row) => row.merchantNameNormalized.contains(normalized))
              ..orderBy([(row) => OrderingTerm.desc(row.confidencePpm)]))
            .get();
    return rows
        .map(
          (row) => MerchantMccSuggestion(
            id: row.id,
            merchantId: row.merchantServerId,
            merchantName: row.merchantName,
            locationText: row.locationText,
            mccCode: row.mccCode,
            mccDescription: row.mccDescription,
            paymentType: row.paymentType,
            source: row.source,
            confidencePpm: row.confidencePpm,
            status: row.status,
          ),
        )
        .toList(growable: false);
  }

  RewardRulesCacheCompanion _ruleCompanion(RewardRule rule) {
    return RewardRulesCacheCompanion.insert(
      id: rule.id,
      creditCardId: rule.creditCardId,
      name: rule.name,
      rewardType: rule.rewardType,
      cashbackRateDecimal: Value(rule.cashbackRate?.toString()),
      pointsRateDecimal: Value(rule.pointsRate?.toString()),
      monthlyCapAmountDecimal: Value(rule.monthlyCapAmount?.toString()),
      minimumTransactionDecimal: Value(
        rule.minimumTransactionAmount?.toString(),
      ),
      minimumMonthlySpendDecimal: Value(rule.minimumMonthlySpend?.toString()),
      eligibleChannel: Value(rule.eligibleChannel),
      conditionsText: Value(rule.conditionsText),
      effectiveFrom: Value(rule.effectiveFrom?.toIso8601String()),
      effectiveTo: Value(rule.effectiveTo?.toIso8601String()),
      confidencePpm: Value(rule.confidencePpm),
      datasetVersion: _datasetVersion,
    );
  }

  RewardRuleMccsCacheCompanion _mappingCompanion(
    String ruleId,
    RewardRuleMcc mapping,
  ) {
    return RewardRuleMccsCacheCompanion.insert(
      id: mapping.id,
      rewardRuleId: ruleId,
      mccCode: mapping.mccCode,
      matchType: mapping.matchType,
      datasetVersion: _datasetVersion,
    );
  }

  int? _money(String? value) => double.tryParse(value ?? '')?.round();
}
