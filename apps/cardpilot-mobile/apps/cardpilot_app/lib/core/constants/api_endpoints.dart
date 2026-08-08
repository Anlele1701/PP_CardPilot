abstract final class ApiEndpoints {
  static const _apiV1 = '/api/v1';

  static const banks = '$_apiV1/banks';
  static const merchantCategoryCodes = '$_apiV1/merchant-category-codes';

  static String bankCreditCards(String bankId) {
    return '$_apiV1/banks/$bankId/credit-cards';
  }

  static String creditCardRewardRules(String creditCardId) {
    return '$_apiV1/credit-cards/$creditCardId/reward-rules';
  }

  static const merchantMccSuggestions = '$_apiV1/merchants/mcc-suggestions';
  static const merchants = '$_apiV1/merchants';
}
