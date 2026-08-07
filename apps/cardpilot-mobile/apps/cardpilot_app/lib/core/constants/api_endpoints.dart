abstract final class ApiEndpoints {
  static const _apiV1 = '/api/v1';

  static const banks = '$_apiV1/banks';

  static String bankCreditCards(String bankId) {
    return '$_apiV1/banks/$bankId/credit-cards';
  }
}
