class Bank {
  const Bank({
    required this.id,
    required this.name,
    this.swiftCode,
    this.shortName,
  });

  final String id;
  final String? swiftCode;
  final String name;
  final String? shortName;

  String get displayName {
    final compactName = shortName?.trim();
    return compactName == null || compactName.isEmpty ? name : compactName;
  }
}
