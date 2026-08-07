import '../../../initial_setup/domain/entities/local_user_card.dart';

abstract interface class UserCardRepository {
  Future<List<LocalUserCard>> create({
    required String profileId,
    required LocalUserCard card,
  });

  Future<List<LocalUserCard>> update({
    required String profileId,
    required LocalUserCard card,
  });

  Future<List<LocalUserCard>> delete({
    required String profileId,
    required String cardId,
  });
}
