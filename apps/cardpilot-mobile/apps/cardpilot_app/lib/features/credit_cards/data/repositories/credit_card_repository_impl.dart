import '../../../../core/errors/app_failure.dart';
import '../../../../core/network/api_exception.dart';
import '../../../../core/result/result.dart';
import '../../domain/entities/credit_card.dart';
import '../../domain/repositories/credit_card_repository.dart';
import '../datasources/credit_card_local_data_source.dart';
import '../datasources/credit_card_remote_data_source.dart';

class CreditCardRepositoryImpl implements CreditCardRepository {
  CreditCardRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  final CreditCardLocalDataSource localDataSource;
  final CreditCardRemoteDataSource remoteDataSource;
  final Map<String, Future<Result<List<CreditCard>>>> _inFlightLoads = {};

  @override
  Stream<List<CreditCard>> watchCreditCards(String bankId) {
    return localDataSource.watchCreditCards(bankId);
  }

  @override
  Future<Result<List<CreditCard>>> ensureCreditCardsLoaded(String bankId) {
    final activeLoad = _inFlightLoads[bankId];
    if (activeLoad != null) {
      return activeLoad;
    }

    final load = _loadCreditCards(bankId);
    _inFlightLoads[bankId] = load;
    return load.whenComplete(() {
      if (identical(_inFlightLoads[bankId], load)) {
        _inFlightLoads.remove(bankId);
      }
    });
  }

  Future<Result<List<CreditCard>>> _loadCreditCards(String bankId) async {
    try {
      final cachedCreditCards = await localDataSource.getCreditCards(bankId);
      if (cachedCreditCards.isNotEmpty) {
        return Success(cachedCreditCards);
      }

      final remoteCreditCards = await remoteDataSource.fetchCreditCards(bankId);
      final creditCards = remoteCreditCards
          .map((creditCard) => creditCard.toDomain())
          .toList(growable: false);
      await localDataSource.replaceBootstrapSnapshot(bankId, creditCards);
      return Success(creditCards);
    } on ApiException catch (error) {
      return Failure(AppFailure(_messageFor(error)));
    } on FormatException {
      return const Failure(
        AppFailure('The card catalog returned by the server is invalid.'),
      );
    } on Exception {
      return const Failure(
        AppFailure('Could not load cards. Please try again.'),
      );
    }
  }
}

String _messageFor(ApiException error) {
  return switch (error.code) {
    'API_NOT_CONFIGURED' =>
      'CardPilot API is not configured. Add API_BASE_URL to the app .env file.',
    'NETWORK_TIMEOUT' => 'Loading cards timed out. Please try again.',
    'NETWORK_UNAVAILABLE' =>
      'Could not load cards. Check your connection and try again.',
    _ => error.message,
  };
}
