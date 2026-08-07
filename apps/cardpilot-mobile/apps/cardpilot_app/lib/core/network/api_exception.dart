class ApiException implements Exception {
  const ApiException({
    required this.code,
    required this.message,
    this.statusCode,
    this.traceId,
  });

  final String code;
  final String message;
  final int? statusCode;
  final String? traceId;

  @override
  String toString() => 'ApiException($code, $message)';
}
