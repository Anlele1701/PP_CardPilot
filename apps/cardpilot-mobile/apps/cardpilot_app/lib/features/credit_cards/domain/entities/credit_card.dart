class CreditCard {
  const CreditCard({
    required this.id,
    required this.bankId,
    required this.name,
    required this.cardType,
    this.network,
    this.annualFee,
    this.sourceUrl,
    this.lastVerifiedAt,
  });

  final String id;
  final String bankId;
  final String name;
  final String? network;
  final String cardType;
  final String? annualFee;
  final String? sourceUrl;
  final DateTime? lastVerifiedAt;

  String get displayName {
    final cardNetwork = network?.trim();
    return cardNetwork == null || cardNetwork.isEmpty
        ? name
        : '$name · $cardNetwork';
  }
}
