import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../core/database/database_providers.dart';
import '../initial_setup/domain/entities/local_user_card.dart';
import '../initial_setup/initial_setup_providers.dart';
import 'data/datasources/user_card_local_data_source.dart';
import 'data/repositories/user_card_repository_impl.dart';
import 'domain/repositories/user_card_repository.dart';

enum UserCardMutationStatus { idle, saving, deleting, failure }

class UserCardMutationState {
  const UserCardMutationState({required this.status, this.errorMessage});

  const UserCardMutationState.idle()
    : status = UserCardMutationStatus.idle,
      errorMessage = null;

  final UserCardMutationStatus status;
  final String? errorMessage;
}

class UserCardController extends Notifier<UserCardMutationState> {
  @override
  UserCardMutationState build() => const UserCardMutationState.idle();

  Future<bool> create({
    required String profileId,
    required String bankId,
    required String bankName,
    required String creditCardId,
    required String nickname,
    required int billingCycleDay,
    required int creditLimitMinor,
  }) async {
    state = const UserCardMutationState(status: UserCardMutationStatus.saving);
    try {
      final cards = await ref
          .read(userCardRepositoryProvider)
          .create(
            profileId: profileId,
            card: LocalUserCard(
              id: const Uuid().v4(),
              bankId: bankId,
              creditCardId: creditCardId,
              bankName: bankName,
              nickname: nickname.trim(),
              billingCycleDay: billingCycleDay,
              creditLimitMinor: creditLimitMinor,
            ),
          );
      _finish(cards);
      return true;
    } on Object catch (error) {
      return _fail(error, 'Could not create the card.');
    }
  }

  Future<bool> update({
    required String profileId,
    required String cardId,
    required String bankId,
    required String bankName,
    required String creditCardId,
    required String nickname,
    required int billingCycleDay,
    required int creditLimitMinor,
  }) async {
    state = const UserCardMutationState(status: UserCardMutationStatus.saving);
    try {
      final cards = await ref
          .read(userCardRepositoryProvider)
          .update(
            profileId: profileId,
            card: LocalUserCard(
              id: cardId,
              bankId: bankId,
              creditCardId: creditCardId,
              bankName: bankName,
              nickname: nickname.trim(),
              billingCycleDay: billingCycleDay,
              creditLimitMinor: creditLimitMinor,
            ),
          );
      _finish(cards);
      return true;
    } on Object catch (error) {
      return _fail(error, 'Could not update the card.');
    }
  }

  Future<bool> delete({
    required String profileId,
    required String cardId,
  }) async {
    state = const UserCardMutationState(
      status: UserCardMutationStatus.deleting,
    );
    try {
      final cards = await ref
          .read(userCardRepositoryProvider)
          .delete(profileId: profileId, cardId: cardId);
      _finish(cards);
      return true;
    } on Object catch (error) {
      return _fail(error, 'Could not delete the card.');
    }
  }

  void _finish(List<LocalUserCard> cards) {
    ref.read(initialSetupControllerProvider.notifier).replaceCards(cards);
    state = const UserCardMutationState.idle();
  }

  bool _fail(Object error, String fallbackMessage) {
    state = UserCardMutationState(
      status: UserCardMutationStatus.failure,
      errorMessage: error is StateError
          ? error.message.toString()
          : fallbackMessage,
    );
    return false;
  }
}

final userCardLocalDataSourceProvider = Provider<UserCardLocalDataSource>((
  ref,
) {
  return UserCardLocalDataSource(ref.watch(appDatabaseProvider));
});

final userCardRepositoryProvider = Provider<UserCardRepository>((ref) {
  return UserCardRepositoryImpl(ref.watch(userCardLocalDataSourceProvider));
});

final userCardControllerProvider =
    NotifierProvider<UserCardController, UserCardMutationState>(
      UserCardController.new,
    );
