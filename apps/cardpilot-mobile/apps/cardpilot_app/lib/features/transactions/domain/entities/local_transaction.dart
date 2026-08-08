class LocalTransaction {
  const LocalTransaction({
    required this.id,
    required this.profileId,
    required this.userCardId,
    required this.cardNickname,
    required this.merchantName,
    required this.transactionAt,
    required this.amountMinor,
    required this.currency,
    required this.source,
    this.merchantId,
    this.category,
    this.note,
    this.mccCode,
    this.cashbackEstimatedMinor,
    this.cashbackRatePpm,
    this.cashbackExplanation,
    this.rewardRuleName,
  });

  final String id;
  final String profileId;
  final String userCardId;
  final String cardNickname;
  final String? merchantId;
  final String merchantName;
  final DateTime transactionAt;
  final int amountMinor;
  final String currency;
  final String? category;
  final String source;
  final String? note;
  final String? mccCode;
  final int? cashbackEstimatedMinor;
  final int? cashbackRatePpm;
  final String? cashbackExplanation;
  final String? rewardRuleName;
}

class TransactionDraft {
  const TransactionDraft({
    required this.userCardId,
    required this.merchantName,
    required this.transactionAt,
    required this.amountMinor,
    required this.mccCode,
    this.category,
    this.note,
    this.mccSource = 'manual',
    this.mccConfidencePpm,
    this.merchantServerId,
    this.merchantLocation,
  });

  final String userCardId;
  final String merchantName;
  final DateTime transactionAt;
  final int amountMinor;
  final String mccCode;
  final String mccSource;
  final int? mccConfidencePpm;
  final String? merchantServerId;
  final String? merchantLocation;
  final String? category;
  final String? note;
}
