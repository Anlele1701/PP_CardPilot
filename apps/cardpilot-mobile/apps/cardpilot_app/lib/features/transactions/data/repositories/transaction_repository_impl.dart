import '../../domain/entities/local_transaction.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../datasources/transaction_local_data_source.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  const TransactionRepositoryImpl(this.localDataSource);

  final TransactionLocalDataSource localDataSource;

  @override
  Stream<List<LocalTransaction>> watchTransactions(String profileId) {
    return localDataSource.watchTransactions(profileId);
  }

  @override
  Future<void> create({
    required String profileId,
    required String transactionId,
    required TransactionDraft draft,
  }) {
    return localDataSource.create(
      profileId: profileId,
      transactionId: transactionId,
      draft: draft,
    );
  }

  @override
  Future<void> update({
    required String profileId,
    required String transactionId,
    required TransactionDraft draft,
  }) {
    return localDataSource.update(
      profileId: profileId,
      transactionId: transactionId,
      draft: draft,
    );
  }

  @override
  Future<void> delete({
    required String profileId,
    required String transactionId,
  }) {
    return localDataSource.delete(
      profileId: profileId,
      transactionId: transactionId,
    );
  }
}
