class MerchantCategoryCode {
  const MerchantCategoryCode({
    required this.code,
    required this.description,
    this.category,
  });

  final String code;
  final String description;
  final String? category;
}

class RewardRuleMcc {
  const RewardRuleMcc({
    required this.id,
    required this.mccCode,
    required this.matchType,
  });

  final String id;
  final String mccCode;
  final String matchType;
}

class RewardRule {
  const RewardRule({
    required this.id,
    required this.creditCardId,
    required this.name,
    required this.rewardType,
    required this.eligibleChannel,
    required this.mccs,
    this.cashbackRate,
    this.pointsRate,
    this.monthlyCapAmount,
    this.minimumTransactionAmount,
    this.minimumMonthlySpend,
    this.conditionsText,
    this.effectiveFrom,
    this.effectiveTo,
    this.confidencePpm,
  });

  final String id;
  final String creditCardId;
  final String name;
  final String rewardType;
  final double? cashbackRate;
  final double? pointsRate;
  final int? monthlyCapAmount;
  final int? minimumTransactionAmount;
  final int? minimumMonthlySpend;
  final String eligibleChannel;
  final String? conditionsText;
  final DateTime? effectiveFrom;
  final DateTime? effectiveTo;
  final int? confidencePpm;
  final List<RewardRuleMcc> mccs;
}

class MerchantMccSuggestion {
  const MerchantMccSuggestion({
    required this.id,
    required this.merchantId,
    required this.merchantName,
    required this.mccCode,
    required this.paymentType,
    required this.source,
    required this.status,
    this.locationText,
    this.mccDescription,
    this.confidencePpm,
  });

  final String id;
  final String merchantId;
  final String merchantName;
  final String? locationText;
  final String mccCode;
  final String paymentType;
  final String? mccDescription;
  final String source;
  final int? confidencePpm;
  final String status;
}
