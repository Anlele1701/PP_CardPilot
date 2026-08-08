import '../entities/local_transaction.dart';

abstract interface class TransactionRepository {
  Stream<List<LocalTransaction>> watchTransactions(String profileId);

  Future<void> create({
    required String profileId,
    required String transactionId,
    required TransactionDraft draft,
  });

  Future<void> update({
    required String profileId,
    required String transactionId,
    required TransactionDraft draft,
  });

  Future<void> delete({
    required String profileId,
    required String transactionId,
  });
}
