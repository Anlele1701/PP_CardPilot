import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/api_client.dart';
import '../models/credit_card_model.dart';

class CreditCardRemoteDataSource {
  const CreditCardRemoteDataSource(this.apiClient);

  final ApiClient apiClient;

  Future<List<CreditCardModel>> fetchCreditCards(String bankId) {
    return apiClient.get<List<CreditCardModel>>(
      ApiEndpoints.bankCreditCards(bankId),
      decode: (data) {
        if (data is! List) {
          throw const FormatException(
            'responseData must be a list of credit cards.',
          );
        }

        final creditCards = data
            .map(CreditCardModel.fromJson)
            .toList(growable: false);
        if (creditCards.any((creditCard) => creditCard.bankId != bankId)) {
          throw const FormatException(
            'The credit card catalog contains a different bank.',
          );
        }
        return creditCards;
      },
    );
  }
}
