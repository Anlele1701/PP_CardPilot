import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/api_client.dart';
import '../domain/merchant_directory.dart';

class MerchantRemoteDataSource {
  const MerchantRemoteDataSource(this.apiClient);

  final ApiClient apiClient;

  Future<List<MerchantBranch>> fetchDirectory() {
    return apiClient.get(
      ApiEndpoints.merchants,
      decode: (data) {
        if (data is! List) {
          throw const FormatException('responseData must be a list.');
        }
        return data
            .map((item) {
              if (item is! Map) {
                throw const FormatException('Invalid merchant item.');
              }
              return _branchFromJson(Map<String, Object?>.from(item));
            })
            .toList(growable: false);
      },
    );
  }

  MerchantBranch _branchFromJson(Map<String, Object?> json) {
    final candidates = json['candidates'];
    if (candidates is! List) {
      throw const FormatException('Merchant candidates must be a list.');
    }
    return MerchantBranch(
      id: _string(json, 'id'),
      name: _string(json, 'name'),
      nameNormalized: _string(json, 'nameNormalized'),
      locationText: json['locationText'] as String?,
      mccMappings: candidates
          .map((item) {
            if (item is! Map) {
              throw const FormatException('Invalid merchant MCC candidate.');
            }
            final map = Map<String, Object?>.from(item);
            return MerchantMccMapping(
              id: _string(map, 'id'),
              mccCode: _string(map, 'mccCode'),
              mccDescription: map['mccDescription'] as String?,
              paymentType: MerchantPaymentType.fromWire(
                (map['paymentType'] as String?) ?? 'unknown',
              ),
              source: _string(map, 'source'),
              status: _string(map, 'status'),
              confidencePpm: _ppm(map['confidence']),
            );
          })
          .toList(growable: false),
    );
  }

  String _string(Map<String, Object?> json, String key) {
    final value = json[key];
    if (value is! String || value.isEmpty) {
      throw FormatException('$key must be a non-empty string.');
    }
    return value;
  }

  int? _ppm(Object? value) {
    if (value == null) return null;
    final parsed = double.tryParse(value.toString());
    if (parsed == null) throw const FormatException('Invalid confidence.');
    return (parsed * 1000000).round();
  }
}
