import '../../../initial_setup/domain/entities/local_user_card.dart';
import '../../domain/repositories/user_card_repository.dart';
import '../datasources/user_card_local_data_source.dart';

class UserCardRepositoryImpl implements UserCardRepository {
  const UserCardRepositoryImpl(this.localDataSource);

  final UserCardLocalDataSource localDataSource;

  @override
  Future<List<LocalUserCard>> create({
    required String profileId,
    required LocalUserCard card,
  }) {
    return localDataSource.create(profileId: profileId, card: card);
  }

  @override
  Future<List<LocalUserCard>> update({
    required String profileId,
    required LocalUserCard card,
  }) {
    return localDataSource.update(profileId: profileId, card: card);
  }

  @override
  Future<List<LocalUserCard>> delete({
    required String profileId,
    required String cardId,
  }) {
    return localDataSource.delete(profileId: profileId, cardId: cardId);
  }
}
