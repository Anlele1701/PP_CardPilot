import 'dart:typed_data';

import 'package:dio/dio.dart';

import '../domain/receipt_scan_draft.dart';

class ReceiptScanException implements Exception {
  const ReceiptScanException(this.message);

  final String message;

  @override
  String toString() => message;
}

class ReceiptScanRemoteDataSource {
  ReceiptScanRemoteDataSource({required String baseUrl, Dio? dio})
    : _baseUrl = baseUrl.trim(),
      dio = dio ?? Dio() {
    this.dio.options
      ..baseUrl = _baseUrl
      ..connectTimeout = const Duration(seconds: 30)
      ..sendTimeout = const Duration(seconds: 30)
      ..receiveTimeout = const Duration(seconds: 120);
  }

  final String _baseUrl;
  final Dio dio;

  Future<ReceiptScanDraft> scan({
    required Uint8List bytes,
    required String fileName,
    required String contentType,
  }) async {
    if (_baseUrl.isEmpty) {
      throw const ReceiptScanException('OCR_BASE_URL is not configured.');
    }

    try {
      final response = await dio.post<Object?>(
        '/v1/receipts/scan',
        data: FormData.fromMap({
          'image': MultipartFile.fromBytes(
            bytes,
            filename: fileName,
            contentType: _mediaType(contentType),
          ),
        }),
      );
      return _decode(response.data);
    } on ReceiptScanException {
      rethrow;
    } on DioException catch (error) {
      final detail = _errorDetail(error.response?.data);
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.sendTimeout ||
          error.type == DioExceptionType.receiveTimeout) {
        throw const ReceiptScanException(
          'Receipt scanning timed out. Please try again.',
        );
      }
      throw ReceiptScanException(
        detail ?? 'Could not scan the receipt. Check the OCR service.',
      );
    } on Object {
      throw const ReceiptScanException(
        'The OCR service returned an invalid response.',
      );
    }
  }

  ReceiptScanDraft _decode(Object? data) {
    if (data is! Map) {
      throw const ReceiptScanException('Invalid receipt scan response.');
    }
    final json = Map<String, Object?>.from(data);
    final fields = _map(json['fields']);
    final merchant = _map(fields['merchant']);
    final address = _map(fields['address']);
    final occurredAt = _map(fields['occurred_at']);
    final total = _map(fields['total']);
    final money = _map(total['value']);
    final amount = money['amount'];
    final warnings = json['warnings'];

    final parsedOccurredAt = DateTime.tryParse(
      _string(occurredAt['value']) ?? '',
    );
    return ReceiptScanDraft(
      scanId: _string(json['scan_id']) ?? '',
      processingMs: _int(json['processing_ms']) ?? 0,
      merchant: _string(merchant['value']),
      address: _string(address['value']),
      occurredAt: parsedOccurredAt?.toLocal(),
      amountMinor: amount is num
          ? amount.round()
          : num.tryParse(amount?.toString() ?? '')?.round(),
      currency: _string(money['currency']),
      merchantConfidencePpm: _confidencePpm(merchant['confidence']),
      totalConfidencePpm: _confidencePpm(total['confidence']),
      warnings: warnings is List
          ? warnings.whereType<String>().toList(growable: false)
          : const [],
    );
  }

  Map<String, Object?> _map(Object? value) {
    return value is Map ? Map<String, Object?>.from(value) : const {};
  }

  String? _string(Object? value) =>
      value is String && value.trim().isNotEmpty ? value.trim() : null;

  int? _int(Object? value) =>
      value is int ? value : int.tryParse(value?.toString() ?? '');

  int? _confidencePpm(Object? value) {
    if (value is! num) return null;
    return (value.clamp(0, 1) * 1000000).round();
  }

  String? _errorDetail(Object? data) {
    if (data is! Map) return null;
    final detail = data['detail'];
    if (detail is String && detail.trim().isNotEmpty) return detail.trim();
    return null;
  }

  DioMediaType _mediaType(String contentType) {
    final parts = contentType.split('/');
    return DioMediaType(parts.first, parts.length > 1 ? parts[1] : 'jpeg');
  }
}
