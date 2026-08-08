import '../../../core/constants/api_endpoints.dart';
import '../../../core/network/api_client.dart';
import '../domain/cashback_reference.dart';

class CashbackReferenceRemoteDataSource {
  const CashbackReferenceRemoteDataSource(this.apiClient);

  final ApiClient apiClient;

  Future<List<MerchantCategoryCode>> fetchMccs() {
    return apiClient.get(
      ApiEndpoints.merchantCategoryCodes,
      decode: (data) => _list(data, _mccFromJson),
    );
  }

  Future<List<RewardRule>> fetchRewardRules(String creditCardId) {
    return apiClient.get(
      ApiEndpoints.creditCardRewardRules(creditCardId),
      decode: (data) => _list(data, _rewardRuleFromJson),
    );
  }

  Future<List<MerchantMccSuggestion>> fetchMerchantSuggestions(String query) {
    return apiClient.get(
      ApiEndpoints.merchantMccSuggestions,
      queryParameters: {'query': query},
      decode: (data) => _list(data, _suggestionFromJson),
    );
  }

  List<T> _list<T>(Object? data, T Function(Map<String, Object?>) decode) {
    if (data is! List) {
      throw const FormatException('responseData must be a list.');
    }
    return data
        .map((item) {
          if (item is! Map) throw const FormatException('Invalid list item.');
          return decode(Map<String, Object?>.from(item));
        })
        .toList(growable: false);
  }

  MerchantCategoryCode _mccFromJson(Map<String, Object?> json) {
    return MerchantCategoryCode(
      code: _string(json, 'code'),
      description: _string(json, 'description'),
      category: json['category'] as String?,
    );
  }

  RewardRule _rewardRuleFromJson(Map<String, Object?> json) {
    final rawMccs = json['mccs'];
    if (rawMccs is! List) throw const FormatException('Invalid rule MCCs.');
    return RewardRule(
      id: _string(json, 'id'),
      creditCardId: _string(json, 'creditCardId'),
      name: _string(json, 'name'),
      rewardType: _string(json, 'rewardType'),
      cashbackRate: _double(json['cashbackRate']),
      pointsRate: _double(json['pointsRate']),
      monthlyCapAmount: _money(json['monthlyCapAmount']),
      minimumTransactionAmount: _money(json['minimumTransactionAmount']),
      minimumMonthlySpend: _money(json['minimumMonthlySpend']),
      eligibleChannel: _string(json, 'eligibleChannel'),
      conditionsText: json['conditionsText'] as String?,
      effectiveFrom: _date(json['effectiveFrom']),
      effectiveTo: _date(json['effectiveTo']),
      confidencePpm: _ppm(json['confidence']),
      mccs: rawMccs
          .map((item) {
            if (item is! Map) throw const FormatException('Invalid rule MCC.');
            final map = Map<String, Object?>.from(item);
            return RewardRuleMcc(
              id: _string(map, 'id'),
              mccCode: _string(map, 'mccCode'),
              matchType: _string(map, 'matchType'),
            );
          })
          .toList(growable: false),
    );
  }

  MerchantMccSuggestion _suggestionFromJson(Map<String, Object?> json) {
    return MerchantMccSuggestion(
      id: _string(json, 'candidateId'),
      merchantId: _string(json, 'merchantId'),
      merchantName: _string(json, 'merchantName'),
      locationText: json['locationText'] as String?,
      mccCode: _string(json, 'mccCode'),
      mccDescription: json['mccDescription'] as String?,
      paymentType: (json['paymentType'] as String?) ?? 'unknown',
      source: _string(json, 'source'),
      confidencePpm: _ppm(json['confidence']),
      status: _string(json, 'status'),
    );
  }

  String _string(Map<String, Object?> json, String key) {
    final value = json[key];
    if (value is! String) throw FormatException('$key must be a string.');
    return value;
  }

  double? _double(Object? value) => value == null
      ? null
      : double.tryParse(value.toString()) ??
            (throw const FormatException('Invalid decimal.'));

  int? _money(Object? value) => value == null
      ? null
      : double.tryParse(value.toString())?.round() ??
            (throw const FormatException('Invalid money amount.'));

  int? _ppm(Object? value) {
    final decimal = _double(value);
    return decimal == null ? null : (decimal * 1000000).round();
  }

  DateTime? _date(Object? value) =>
      value is String && value.isNotEmpty ? DateTime.tryParse(value) : null;
}
