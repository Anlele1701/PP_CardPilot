import '../../domain/entities/credit_card.dart';

class CreditCardModel {
  const CreditCardModel({
    required this.id,
    required this.bankId,
    required this.name,
    required this.cardType,
    this.network,
    this.annualFee,
    this.sourceUrl,
    this.lastVerifiedAt,
  });

  factory CreditCardModel.fromJson(Object? json) {
    if (json is! Map) {
      throw const FormatException('A credit card entry must be an object.');
    }

    final map = Map<String, Object?>.from(json);
    final id = map['id'];
    final bankId = map['bankId'];
    final name = map['name'];
    final network = map['network'];
    final cardType = map['cardType'];
    final annualFee = map['annualFee'];
    final sourceUrl = map['sourceUrl'];
    final lastVerifiedAt = map['lastVerifiedAt'];

    if (id is! String || id.trim().isEmpty) {
      throw const FormatException('A credit card entry is missing its id.');
    }
    if (bankId is! String || bankId.trim().isEmpty) {
      throw const FormatException('A credit card entry is missing its bankId.');
    }
    if (name is! String || name.trim().isEmpty) {
      throw const FormatException('A credit card entry is missing its name.');
    }
    if (cardType is! String || cardType.trim().isEmpty) {
      throw const FormatException(
        'A credit card entry is missing its cardType.',
      );
    }
    if (network != null && network is! String) {
      throw const FormatException('A credit card network must be a string.');
    }
    if (annualFee != null && annualFee is! String) {
      throw const FormatException('A credit card annualFee must be a string.');
    }
    if (sourceUrl != null && sourceUrl is! String) {
      throw const FormatException('A credit card sourceUrl must be a string.');
    }
    if (lastVerifiedAt != null && lastVerifiedAt is! String) {
      throw const FormatException(
        'A credit card lastVerifiedAt must be a string.',
      );
    }
    final parsedLastVerifiedAt = lastVerifiedAt == null
        ? null
        : DateTime.tryParse(lastVerifiedAt as String);
    if (lastVerifiedAt != null && parsedLastVerifiedAt == null) {
      throw const FormatException(
        'A credit card lastVerifiedAt must be ISO-8601.',
      );
    }

    return CreditCardModel(
      id: id,
      bankId: bankId,
      name: name,
      network: network as String?,
      cardType: cardType,
      annualFee: annualFee as String?,
      sourceUrl: sourceUrl as String?,
      lastVerifiedAt: parsedLastVerifiedAt,
    );
  }

  final String id;
  final String bankId;
  final String name;
  final String? network;
  final String cardType;
  final String? annualFee;
  final String? sourceUrl;
  final DateTime? lastVerifiedAt;

  CreditCard toDomain() {
    return CreditCard(
      id: id,
      bankId: bankId,
      name: name,
      network: network,
      cardType: cardType,
      annualFee: annualFee,
      sourceUrl: sourceUrl,
      lastVerifiedAt: lastVerifiedAt,
    );
  }
}
