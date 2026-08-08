// Drift check constraints refer to their own column getter by design.
// ignore_for_file: recursive_getters

import 'package:drift/drift.dart';

@DataClassName('MembershipCacheRow')
class MembershipsCache extends Table {
  @override
  String get tableName => 'memberships_cache';

  TextColumn get id => text()();
  TextColumn get name => text().unique()();
  IntColumn get maxCards => integer().nullable()();
  IntColumn get maxReceiptScansPerMonth => integer().nullable()();
  IntColumn get maxCashbackCalculationsPerMonth => integer().nullable()();
  IntColumn get serverUpdatedAtMs => integer().nullable()();
  IntColumn get datasetVersion =>
      integer().check(datasetVersion.isBiggerOrEqualValue(1))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('BankCacheRow')
@TableIndex(name: 'idx_banks_cache_name', columns: {#name})
@TableIndex(name: 'idx_banks_cache_short_name', columns: {#shortName})
@TableIndex.sql(
  'CREATE UNIQUE INDEX uq_banks_cache_swift_code '
  'ON banks_cache (swift_code) WHERE swift_code IS NOT NULL',
)
class BanksCache extends Table {
  @override
  String get tableName => 'banks_cache';

  TextColumn get id => text()();
  TextColumn get swiftCode => text().nullable()();
  TextColumn get name => text()();
  TextColumn get shortName => text().nullable()();
  IntColumn get serverUpdatedAtMs => integer().nullable()();
  IntColumn get datasetVersion =>
      integer().check(datasetVersion.isBiggerOrEqualValue(1))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('CreditCardCacheRow')
@TableIndex(
  name: 'idx_credit_cards_cache_bank_active',
  columns: {#bankId, #isActive},
)
@TableIndex(name: 'idx_credit_cards_cache_name', columns: {#name})
class CreditCardsCache extends Table {
  @override
  String get tableName => 'credit_cards_cache';

  TextColumn get id => text()();
  TextColumn get bankId => text()();
  TextColumn get name => text()();
  TextColumn get network => text().nullable()();
  TextColumn get cardType => text().withDefault(const Constant('credit'))();
  TextColumn get annualFeeDecimal => text().nullable()();
  TextColumn get sourceUrl => text().nullable()();
  IntColumn get lastVerifiedAtMs => integer().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  IntColumn get serverUpdatedAtMs => integer().nullable()();
  IntColumn get datasetVersion =>
      integer().check(datasetVersion.isBiggerOrEqualValue(1))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('MerchantCategoryCodeCacheRow')
@TableIndex(
  name: 'idx_mcc_cache_category_active',
  columns: {#category, #isActive},
)
class MerchantCategoryCodesCache extends Table {
  @override
  String get tableName => 'merchant_category_codes_cache';

  TextColumn get code => text().withLength(min: 4, max: 4)();
  TextColumn get description => text()();
  TextColumn get category => text().nullable()();
  TextColumn get validPayment => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  IntColumn get serverUpdatedAtMs => integer().nullable()();
  IntColumn get datasetVersion =>
      integer().check(datasetVersion.isBiggerOrEqualValue(1))();

  @override
  Set<Column<Object>> get primaryKey => {code};
}

@DataClassName('RewardRuleCacheRow')
@TableIndex(
  name: 'idx_reward_rules_cache_card_active',
  columns: {#creditCardId, #isActive},
)
class RewardRulesCache extends Table {
  @override
  String get tableName => 'reward_rules_cache';

  TextColumn get id => text()();
  TextColumn get creditCardId => text()();
  TextColumn get name => text()();
  TextColumn get rewardType => text()();
  TextColumn get cashbackRateDecimal => text().nullable()();
  TextColumn get pointsRateDecimal => text().nullable()();
  TextColumn get monthlyCapAmountDecimal => text().nullable()();
  TextColumn get minimumTransactionDecimal => text().nullable()();
  TextColumn get minimumMonthlySpendDecimal => text().nullable()();
  TextColumn get eligibleChannel => text().withDefault(const Constant('any'))();
  TextColumn get conditionsText => text().nullable()();
  TextColumn get effectiveFrom => text().nullable()();
  TextColumn get effectiveTo => text().nullable()();
  TextColumn get sourceUrl => text().nullable()();
  IntColumn get confidencePpm => integer().nullable().check(
    confidencePpm.isNull() | confidencePpm.isBetweenValues(0, 1000000),
  )();
  IntColumn get lastVerifiedAtMs => integer().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  IntColumn get serverUpdatedAtMs => integer().nullable()();
  IntColumn get datasetVersion =>
      integer().check(datasetVersion.isBiggerOrEqualValue(1))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('RewardRuleMccCacheRow')
@TableIndex(name: 'idx_reward_rule_mccs_cache_mcc', columns: {#mccCode})
class RewardRuleMccsCache extends Table {
  @override
  String get tableName => 'reward_rule_mccs_cache';

  TextColumn get id => text()();
  TextColumn get rewardRuleId => text()();
  TextColumn get mccCode => text().withLength(min: 4, max: 4)();
  TextColumn get matchType => text()();
  IntColumn get datasetVersion =>
      integer().check(datasetVersion.isBiggerOrEqualValue(1))();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {rewardRuleId, mccCode, matchType},
  ];
}

@DataClassName('MerchantMccCandidateCacheRow')
@TableIndex(
  name: 'idx_merchant_mcc_candidates_cache_name',
  columns: {#merchantNameNormalized},
)
@TableIndex(name: 'idx_merchant_mcc_candidates_cache_mcc', columns: {#mccCode})
class MerchantMccCandidatesCache extends Table {
  @override
  String get tableName => 'merchant_mcc_candidates_cache';

  TextColumn get id => text()();
  TextColumn get merchantServerId => text()();
  TextColumn get merchantName => text()();
  TextColumn get merchantNameNormalized => text()();
  TextColumn get locationText => text().nullable()();
  TextColumn get mccCode => text().withLength(min: 4, max: 4)();
  TextColumn get mccDescription => text().nullable()();
  TextColumn get paymentType => text()
      .withDefault(const Constant('unknown'))
      .check(
        paymentType.isIn(const [
          'unknown',
          'in_store',
          'online',
          'shopee_food',
          'grab_food',
          'other',
        ]),
      )();
  TextColumn get source => text()();
  IntColumn get confidencePpm => integer().nullable().check(
    confidencePpm.isNull() | confidencePpm.isBetweenValues(0, 1000000),
  )();
  TextColumn get status => text()();
  IntColumn get datasetVersion => integer().withDefault(const Constant(1))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('MerchantBranchCacheRow')
@TableIndex(
  name: 'idx_merchant_branches_cache_name',
  columns: {#nameNormalized},
)
class MerchantBranchesCache extends Table {
  @override
  String get tableName => 'merchant_branches_cache';

  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get nameNormalized => text()();
  TextColumn get locationText => text().nullable()();
  IntColumn get datasetVersion => integer().withDefault(const Constant(1))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
