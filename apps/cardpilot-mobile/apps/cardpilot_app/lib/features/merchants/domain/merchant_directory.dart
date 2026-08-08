enum MerchantPaymentType {
  unknown('unknown', 'Unknown'),
  inStore('in_store', 'Pay directly'),
  online('online', 'Online'),
  shopeeFood('shopee_food', 'ShopeeFood'),
  grabFood('grab_food', 'GrabFood'),
  other('other', 'Other');

  const MerchantPaymentType(this.wireValue, this.label);

  final String wireValue;
  final String label;

  static MerchantPaymentType fromWire(String value) {
    return values.firstWhere(
      (item) => item.wireValue == value,
      orElse: () => MerchantPaymentType.unknown,
    );
  }
}

class MerchantMccMapping {
  const MerchantMccMapping({
    required this.id,
    required this.mccCode,
    required this.paymentType,
    required this.source,
    required this.status,
    this.mccDescription,
    this.confidencePpm,
    this.isLocalContribution = false,
    this.note,
  });

  final String id;
  final String mccCode;
  final String? mccDescription;
  final MerchantPaymentType paymentType;
  final String source;
  final String status;
  final int? confidencePpm;
  final bool isLocalContribution;
  final String? note;
}

class MerchantBranch {
  const MerchantBranch({
    required this.id,
    required this.name,
    required this.nameNormalized,
    required this.mccMappings,
    this.locationText,
  });

  final String id;
  final String name;
  final String nameNormalized;
  final String? locationText;
  final List<MerchantMccMapping> mccMappings;
}

class MerchantDirectoryEntry {
  const MerchantDirectoryEntry({
    required this.key,
    required this.name,
    required this.branches,
  });

  final String key;
  final String name;
  final List<MerchantBranch> branches;
}

class MerchantContributionDraft {
  const MerchantContributionDraft({
    required this.profileId,
    required this.branch,
    required this.mccCode,
    required this.paymentType,
    this.mccDescription,
    this.note,
  });

  final String profileId;
  final MerchantBranch branch;
  final String mccCode;
  final String? mccDescription;
  final MerchantPaymentType paymentType;
  final String? note;
}
