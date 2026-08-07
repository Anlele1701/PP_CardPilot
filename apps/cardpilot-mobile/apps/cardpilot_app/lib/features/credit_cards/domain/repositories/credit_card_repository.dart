import '../../../../core/result/result.dart';
import '../entities/credit_card.dart';

abstract interface class CreditCardRepository {
  Stream<List<CreditCard>> watchCreditCards(String bankId);

  Future<Result<List<CreditCard>>> ensureCreditCardsLoaded(String bankId);
}
