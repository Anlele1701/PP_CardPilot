import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/database_providers.dart';
import '../../core/network/network_providers.dart';
import 'data/datasources/credit_card_local_data_source.dart';
import 'data/datasources/credit_card_remote_data_source.dart';
import 'data/repositories/credit_card_repository_impl.dart';
import 'domain/entities/credit_card.dart';
import 'domain/repositories/credit_card_repository.dart';

enum CreditCardLoadStatus { idle, loading, failure }

class CreditCardLoadState {
  const CreditCardLoadState({required this.status, this.errorMessage});

  const CreditCardLoadState.idle()
    : status = CreditCardLoadStatus.idle,
      errorMessage = null;

  final CreditCardLoadStatus status;
  final String? errorMessage;
}

class CreditCardLoadController extends Notifier<CreditCardLoadState> {
  @override
  CreditCardLoadState build() => const CreditCardLoadState.idle();

  Future<List<CreditCard>?> ensureLoaded(String bankId) async {
    if (state.status == CreditCardLoadStatus.loading) {
      return null;
    }

    state = const CreditCardLoadState(status: CreditCardLoadStatus.loading);
    final result = await ref
        .read(creditCardRepositoryProvider)
        .ensureCreditCardsLoaded(bankId);
    return result.when(
      success: (creditCards) {
        state = const CreditCardLoadState.idle();
        return creditCards;
      },
      failure: (failure) {
        state = CreditCardLoadState(
          status: CreditCardLoadStatus.failure,
          errorMessage: failure.message,
        );
        return null;
      },
    );
  }
}

final creditCardLocalDataSourceProvider = Provider<CreditCardLocalDataSource>((
  ref,
) {
  return CreditCardLocalDataSource(ref.watch(appDatabaseProvider));
});

final creditCardRemoteDataSourceProvider = Provider<CreditCardRemoteDataSource>(
  (ref) {
    return CreditCardRemoteDataSource(ref.watch(apiClientProvider));
  },
);

final creditCardRepositoryProvider = Provider<CreditCardRepository>((ref) {
  return CreditCardRepositoryImpl(
    localDataSource: ref.watch(creditCardLocalDataSourceProvider),
    remoteDataSource: ref.watch(creditCardRemoteDataSourceProvider),
  );
});

final creditCardsProvider = StreamProvider.family<List<CreditCard>, String>((
  ref,
  bankId,
) {
  return ref.watch(creditCardRepositoryProvider).watchCreditCards(bankId);
});

final creditCardLoadControllerProvider =
    NotifierProvider<CreditCardLoadController, CreditCardLoadState>(
      CreditCardLoadController.new,
    );
