class LocalUserCard {
  const LocalUserCard({
    required this.id,
    required this.bankId,
    required this.bankName,
    required this.nickname,
    required this.billingCycleDay,
    this.creditCardId,
  });

  final String id;
  final String? bankId;
  final String? creditCardId;
  final String bankName;
  final String nickname;
  final int billingCycleDay;
}
