import '../../../../core/errors/app_failure.dart';
import '../../../../core/network/api_exception.dart';
import '../../../../core/result/result.dart';
import '../../domain/entities/bank.dart';
import '../../domain/repositories/bank_repository.dart';
import '../datasources/bank_local_data_source.dart';
import '../datasources/bank_remote_data_source.dart';

class BankRepositoryImpl implements BankRepository {
  BankRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  final BankLocalDataSource localDataSource;
  final BankRemoteDataSource remoteDataSource;

  Future<Result<List<Bank>>>? _inFlightLoad;

  @override
  Stream<List<Bank>> watchBanks() => localDataSource.watchBanks();

  @override
  Future<Result<List<Bank>>> ensureBanksLoaded() {
    final activeLoad = _inFlightLoad;
    if (activeLoad != null) {
      return activeLoad;
    }

    final load = _loadBanks();
    _inFlightLoad = load;
    return load.whenComplete(() {
      if (identical(_inFlightLoad, load)) {
        _inFlightLoad = null;
      }
    });
  }

  Future<Result<List<Bank>>> _loadBanks() async {
    try {
      final cachedBanks = await localDataSource.getBanks();
      if (cachedBanks.isNotEmpty) {
        return Success(cachedBanks);
      }

      final remoteBanks = await remoteDataSource.fetchBanks();
      final banks = remoteBanks
          .map((bank) => bank.toDomain())
          .toList(growable: false);
      await localDataSource.replaceBootstrapSnapshot(banks);
      return Success(await localDataSource.getBanks());
    } on ApiException catch (error) {
      return Failure(AppFailure(_messageFor(error)));
    } on FormatException {
      return const Failure(
        AppFailure('The bank catalog returned by the server is invalid.'),
      );
    } on Exception {
      return const Failure(
        AppFailure('Could not load banks. Please try again.'),
      );
    }
  }
}

String _messageFor(ApiException error) {
  return switch (error.code) {
    'API_NOT_CONFIGURED' =>
      'CardPilot API is not configured. Add API_BASE_URL to the app .env file.',
    'NETWORK_TIMEOUT' => 'Loading banks timed out. Please try again.',
    'NETWORK_UNAVAILABLE' =>
      'Could not load banks. Check your connection and try again.',
    _ => error.message,
  };
}
