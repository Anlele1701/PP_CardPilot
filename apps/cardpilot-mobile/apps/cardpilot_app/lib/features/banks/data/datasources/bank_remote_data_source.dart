import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/api_client.dart';
import '../models/bank_model.dart';

class BankRemoteDataSource {
  const BankRemoteDataSource(this.apiClient);

  final ApiClient apiClient;

  Future<List<BankModel>> fetchBanks() {
    return apiClient.get<List<BankModel>>(
      ApiEndpoints.banks,
      decode: (data) {
        if (data is! List) {
          throw const FormatException('responseData must be a list of banks.');
        }

        final banks = data.map(BankModel.fromJson).toList(growable: false);
        if (banks.isEmpty) {
          throw const FormatException('The bank catalog is empty.');
        }
        return banks;
      },
    );
  }
}
