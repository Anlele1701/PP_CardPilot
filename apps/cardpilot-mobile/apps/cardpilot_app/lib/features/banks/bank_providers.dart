import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/database_providers.dart';
import '../../core/network/network_providers.dart';
import 'data/datasources/bank_local_data_source.dart';
import 'data/datasources/bank_remote_data_source.dart';
import 'data/repositories/bank_repository_impl.dart';
import 'domain/entities/bank.dart';
import 'domain/repositories/bank_repository.dart';

enum BankLoadStatus { idle, loading, failure }

class BankLoadState {
  const BankLoadState({required this.status, this.errorMessage});

  const BankLoadState.idle()
    : status = BankLoadStatus.idle,
      errorMessage = null;

  final BankLoadStatus status;
  final String? errorMessage;
}

class BankLoadController extends Notifier<BankLoadState> {
  @override
  BankLoadState build() => const BankLoadState.idle();

  Future<List<Bank>?> ensureLoaded() async {
    if (state.status == BankLoadStatus.loading) {
      return null;
    }

    state = const BankLoadState(status: BankLoadStatus.loading);
    final result = await ref.read(bankRepositoryProvider).ensureBanksLoaded();
    return result.when(
      success: (banks) {
        state = const BankLoadState.idle();
        return banks;
      },
      failure: (failure) {
        state = BankLoadState(
          status: BankLoadStatus.failure,
          errorMessage: failure.message,
        );
        return null;
      },
    );
  }
}

final bankLocalDataSourceProvider = Provider<BankLocalDataSource>((ref) {
  return BankLocalDataSource(ref.watch(appDatabaseProvider));
});

final bankRemoteDataSourceProvider = Provider<BankRemoteDataSource>((ref) {
  return BankRemoteDataSource(ref.watch(apiClientProvider));
});

final bankRepositoryProvider = Provider<BankRepository>((ref) {
  return BankRepositoryImpl(
    localDataSource: ref.watch(bankLocalDataSourceProvider),
    remoteDataSource: ref.watch(bankRemoteDataSourceProvider),
  );
});

final banksProvider = StreamProvider<List<Bank>>((ref) {
  return ref.watch(bankRepositoryProvider).watchBanks();
});

final bankLoadControllerProvider =
    NotifierProvider<BankLoadController, BankLoadState>(BankLoadController.new);
