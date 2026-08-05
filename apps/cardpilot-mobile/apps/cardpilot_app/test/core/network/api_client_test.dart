import 'dart:convert';
import 'dart:typed_data';

import 'package:cardpilot_app/core/network/api_client.dart';
import 'package:cardpilot_app/core/network/api_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('configures requests and decodes a successful envelope', () async {
    final adapter = _FakeHttpClientAdapter((options) {
      return ResponseBody.fromString(
        jsonEncode({
          'responseStatus': {'code': 'SUCCESS', 'message': 'Success'},
          'responseData': {'value': 42},
        }),
        200,
        headers: {
          Headers.contentTypeHeader: [Headers.jsonContentType],
          'x-response-id': ['response-id'],
        },
      );
    });
    final dio = Dio()..httpClientAdapter = adapter;
    final client = DioApiClient(
      baseUrl: 'https://cardpilot.example',
      dio: dio,
      now: () => DateTime.utc(2026, 8, 5, 4, 3, 2),
    );

    final value = await client.get<int>(
      '/api/v1/banks',
      decode: (data) => (data! as Map)['value']! as int,
    );

    expect(value, 42);
    final request = adapter.lastRequest!;
    expect(request.uri.toString(), 'https://cardpilot.example/api/v1/banks');
    expect(request.connectTimeout, const Duration(seconds: 30));
    expect(request.sendTimeout, const Duration(seconds: 30));
    expect(request.receiveTimeout, const Duration(seconds: 30));
    expect(request.headers[Headers.acceptHeader], Headers.jsonContentType);
    expect(request.headers[Headers.contentTypeHeader], Headers.jsonContentType);
    expect(request.headers['x-request-id'], isNotEmpty);
    expect(request.headers['x-request-datetime'], '2026-08-05T04:03:02.000Z');
  });

  test('maps a non-success response envelope to ApiException', () async {
    final adapter = _FakeHttpClientAdapter(
      (_) => ResponseBody.fromString(
        jsonEncode({
          'responseStatus': {
            'code': 'MISSING_REQUEST_DATETIME',
            'message': 'Request datetime header is required',
          },
          'responseData': null,
        }),
        400,
        headers: {
          Headers.contentTypeHeader: [Headers.jsonContentType],
        },
      ),
    );
    final dio = Dio()..httpClientAdapter = adapter;
    final client = DioApiClient(baseUrl: 'https://cardpilot.example', dio: dio);

    await expectLater(
      client.get<Object?>('/api/v1/banks', decode: (data) => data),
      throwsA(
        isA<ApiException>()
            .having((error) => error.code, 'code', 'MISSING_REQUEST_DATETIME')
            .having((error) => error.statusCode, 'statusCode', 400),
      ),
    );
  });

  test('maps Dio timeouts to NETWORK_TIMEOUT', () async {
    final adapter = _ThrowingHttpClientAdapter(DioExceptionType.receiveTimeout);
    final dio = Dio()..httpClientAdapter = adapter;
    final client = DioApiClient(baseUrl: 'https://cardpilot.example', dio: dio);

    await expectLater(
      client.get<Object?>('/api/v1/banks', decode: (data) => data),
      throwsA(
        isA<ApiException>().having(
          (error) => error.code,
          'code',
          'NETWORK_TIMEOUT',
        ),
      ),
    );
  });

  test('reports a missing API_BASE_URL without sending a request', () async {
    final adapter = _FakeHttpClientAdapter(
      (_) => ResponseBody.fromString('{}', 200),
    );
    final dio = Dio()..httpClientAdapter = adapter;
    final client = DioApiClient(baseUrl: '', dio: dio);

    await expectLater(
      client.get<Object?>('/api/v1/banks', decode: (data) => data),
      throwsA(
        isA<ApiException>().having(
          (error) => error.code,
          'code',
          'API_NOT_CONFIGURED',
        ),
      ),
    );
    expect(adapter.lastRequest, isNull);
  });
}

class _FakeHttpClientAdapter implements HttpClientAdapter {
  _FakeHttpClientAdapter(this.handler);

  final ResponseBody Function(RequestOptions options) handler;
  RequestOptions? lastRequest;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    lastRequest = options;
    return handler(options);
  }

  @override
  void close({bool force = false}) {}
}

class _ThrowingHttpClientAdapter implements HttpClientAdapter {
  const _ThrowingHttpClientAdapter(this.type);

  final DioExceptionType type;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) {
    throw DioException(requestOptions: options, type: type);
  }

  @override
  void close({bool force = false}) {}
}
