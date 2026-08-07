import '../../domain/entities/bank.dart';

class BankModel {
  const BankModel({
    required this.id,
    required this.name,
    this.swiftCode,
    this.shortName,
  });

  factory BankModel.fromJson(Object? json) {
    if (json is! Map) {
      throw const FormatException('A bank entry must be a JSON object.');
    }

    final map = Map<String, Object?>.from(json);
    final id = map['id'];
    final name = map['name'];
    final swiftCode = map['swiftCode'];
    final shortName = map['shortName'];

    if (id is! String || id.trim().isEmpty) {
      throw const FormatException('A bank entry is missing its id.');
    }
    if (name is! String || name.trim().isEmpty) {
      throw const FormatException('A bank entry is missing its name.');
    }
    if (swiftCode != null && swiftCode is! String) {
      throw const FormatException('A bank swiftCode must be a string.');
    }
    if (shortName != null && shortName is! String) {
      throw const FormatException('A bank shortName must be a string.');
    }

    return BankModel(
      id: id,
      name: name,
      swiftCode: swiftCode as String?,
      shortName: shortName as String?,
    );
  }

  final String id;
  final String? swiftCode;
  final String name;
  final String? shortName;

  Bank toDomain() {
    return Bank(id: id, swiftCode: swiftCode, name: name, shortName: shortName);
  }
}
