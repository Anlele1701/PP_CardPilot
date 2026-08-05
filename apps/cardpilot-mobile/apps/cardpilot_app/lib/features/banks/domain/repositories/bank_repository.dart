import '../../../../core/result/result.dart';
import '../entities/bank.dart';

abstract interface class BankRepository {
  Stream<List<Bank>> watchBanks();

  Future<Result<List<Bank>>> ensureBanksLoaded();
}
