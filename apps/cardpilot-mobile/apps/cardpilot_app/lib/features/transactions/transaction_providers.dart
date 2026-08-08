import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../core/database/database_providers.dart';
import 'data/datasources/transaction_local_data_source.dart';
import 'data/repositories/transaction_repository_impl.dart';
import 'domain/entities/local_transaction.dart';
import 'domain/repositories/transaction_repository.dart';

enum TransactionMutationStatus { idle, saving, deleting, failure }

class TransactionMutationState {
  const TransactionMutationState({required this.status, this.errorMessage});

  const TransactionMutationState.idle()
    : status = TransactionMutationStatus.idle,
      errorMessage = null;

  final TransactionMutationStatus status;
  final String? errorMessage;
}

class TransactionController extends Notifier<TransactionMutationState> {
  @override
  TransactionMutationState build() => const TransactionMutationState.idle();

  Future<bool> create({
    required String profileId,
    required TransactionDraft draft,
  }) {
    return _mutate(
      () => ref
          .read(transactionRepositoryProvider)
          .create(
            profileId: profileId,
            transactionId: const Uuid().v4(),
            draft: draft,
          ),
    );
  }

  Future<bool> update({
    required String profileId,
    required String transactionId,
    required TransactionDraft draft,
  }) {
    return _mutate(
      () => ref
          .read(transactionRepositoryProvider)
          .update(
            profileId: profileId,
            transactionId: transactionId,
            draft: draft,
          ),
    );
  }

  Future<bool> delete({
    required String profileId,
    required String transactionId,
  }) async {
    state = const TransactionMutationState(
      status: TransactionMutationStatus.deleting,
    );
    try {
      await ref
          .read(transactionRepositoryProvider)
          .delete(profileId: profileId, transactionId: transactionId);
      state = const TransactionMutationState.idle();
      return true;
    } on Object catch (error) {
      return _fail(error, 'Could not delete the transaction.');
    }
  }

  Future<bool> _mutate(Future<void> Function() operation) async {
    state = const TransactionMutationState(
      status: TransactionMutationStatus.saving,
    );
    try {
      await operation();
      state = const TransactionMutationState.idle();
      return true;
    } on Object catch (error) {
      return _fail(error, 'Could not save the transaction.');
    }
  }

  bool _fail(Object error, String fallbackMessage) {
    state = TransactionMutationState(
      status: TransactionMutationStatus.failure,
      errorMessage: error is StateError
          ? error.message.toString()
          : fallbackMessage,
    );
    return false;
  }
}

final transactionLocalDataSourceProvider = Provider<TransactionLocalDataSource>(
  (ref) {
    return TransactionLocalDataSource(ref.watch(appDatabaseProvider));
  },
);

final transactionRepositoryProvider = Provider<TransactionRepository>((ref) {
  return TransactionRepositoryImpl(
    ref.watch(transactionLocalDataSourceProvider),
  );
});

final transactionsProvider =
    StreamProvider.family<List<LocalTransaction>, String>((ref, profileId) {
      return ref
          .watch(transactionRepositoryProvider)
          .watchTransactions(profileId);
    });

final transactionControllerProvider =
    NotifierProvider<TransactionController, TransactionMutationState>(
      TransactionController.new,
    );
