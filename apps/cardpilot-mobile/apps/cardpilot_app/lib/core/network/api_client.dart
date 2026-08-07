import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';

import 'api_exception.dart';

abstract interface class ApiClient {
  Future<T> get<T>(
    String path, {
    Map<String, Object?>? queryParameters,
    required T Function(Object? data) decode,
  });
}

class DioApiClient implements ApiClient {
  DioApiClient({
    required String baseUrl,
    Dio? dio,
    Uuid? uuid,
    DateTime Function()? now,
  }) : _baseUrl = baseUrl.trim(),
       _uuid = uuid ?? const Uuid(),
       _now = now ?? DateTime.now,
       dio = dio ?? Dio() {
    this.dio.options
      ..baseUrl = baseUrl.trim()
      ..connectTimeout = requestTimeout
      ..sendTimeout = requestTimeout
      ..receiveTimeout = requestTimeout;
  }

  static const requestTimeout = Duration(seconds: 30);

  final String _baseUrl;
  final Uuid _uuid;
  final DateTime Function() _now;
  final Dio dio;

  @override
  Future<T> get<T>(
    String path, {
    Map<String, Object?>? queryParameters,
    required T Function(Object? data) decode,
  }) async {
    if (_baseUrl.isEmpty) {
      throw const ApiException(
        code: 'API_NOT_CONFIGURED',
        message: 'API_BASE_URL is not configured.',
      );
    }

    final requestId = _uuid.v4();

    try {
      final response = await dio.get<Object?>(
        path,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            Headers.acceptHeader: Headers.jsonContentType,
            Headers.contentTypeHeader: Headers.jsonContentType,
            'x-request-id': requestId,
            'x-request-datetime': _now().toUtc().toIso8601String(),
          },
        ),
      );

      return _decodeEnvelope(
        response.data,
        decode: decode,
        statusCode: response.statusCode,
        traceId: response.headers.value('x-response-id') ?? requestId,
      );
    } on ApiException {
      rethrow;
    } on DioException catch (error) {
      throw _mapDioException(error, fallbackTraceId: requestId);
    } on FormatException catch (error) {
      throw ApiException(
        code: 'INVALID_API_RESPONSE',
        message: error.message,
        traceId: requestId,
      );
    }
  }

  T _decodeEnvelope<T>(
    Object? body, {
    required T Function(Object? data) decode,
    required int? statusCode,
    required String traceId,
  }) {
    if (body is! Map) {
      throw ApiException(
        code: 'INVALID_API_RESPONSE',
        message: 'The server returned an invalid response.',
        statusCode: statusCode,
        traceId: traceId,
      );
    }

    final envelope = Map<String, Object?>.from(body);
    final rawStatus = envelope['responseStatus'];
    if (rawStatus is! Map) {
      throw ApiException(
        code: 'INVALID_API_RESPONSE',
        message: 'The server response is missing responseStatus.',
        statusCode: statusCode,
        traceId: traceId,
      );
    }

    final responseStatus = Map<String, Object?>.from(rawStatus);
    final code = responseStatus['code'];
    final message = responseStatus['message'];
    if (code is! String || message is! String) {
      throw ApiException(
        code: 'INVALID_API_RESPONSE',
        message: 'The server returned an invalid response status.',
        statusCode: statusCode,
        traceId: traceId,
      );
    }

    if (code != 'SUCCESS') {
      throw ApiException(
        code: code,
        message: message,
        statusCode: statusCode,
        traceId: traceId,
      );
    }

    try {
      return decode(envelope['responseData']);
    } on ApiException {
      rethrow;
    } on Object {
      throw ApiException(
        code: 'INVALID_API_RESPONSE',
        message: 'The server returned data in an unexpected format.',
        statusCode: statusCode,
        traceId: traceId,
      );
    }
  }

  ApiException _mapDioException(
    DioException error, {
    required String fallbackTraceId,
  }) {
    final traceId =
        error.response?.headers.value('x-response-id') ?? fallbackTraceId;
    final type = error.type;

    if (type == DioExceptionType.connectionTimeout ||
        type == DioExceptionType.sendTimeout ||
        type == DioExceptionType.receiveTimeout) {
      return ApiException(
        code: 'NETWORK_TIMEOUT',
        message: 'The request timed out. Please try again.',
        statusCode: error.response?.statusCode,
        traceId: traceId,
      );
    }

    final errorBody = error.response?.data;
    if (errorBody is Map) {
      final envelope = Map<String, Object?>.from(errorBody);
      final rawStatus = envelope['responseStatus'];
      if (rawStatus is Map) {
        final responseStatus = Map<String, Object?>.from(rawStatus);
        final code = responseStatus['code'];
        final message = responseStatus['message'];
        if (code is String && message is String) {
          return ApiException(
            code: code,
            message: message,
            statusCode: error.response?.statusCode,
            traceId: traceId,
          );
        }
      }
    }

    if (type == DioExceptionType.connectionError ||
        type == DioExceptionType.unknown) {
      return ApiException(
        code: 'NETWORK_UNAVAILABLE',
        message: 'Could not connect to CardPilot. Check your connection.',
        statusCode: error.response?.statusCode,
        traceId: traceId,
      );
    }

    return ApiException(
      code: 'HTTP_ERROR',
      message: 'CardPilot could not complete the request.',
      statusCode: error.response?.statusCode,
      traceId: traceId,
    );
  }
}
