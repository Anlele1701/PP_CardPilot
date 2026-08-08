import '../../../../core/errors/app_failure.dart';
import '../../../../core/result/result.dart';
import '../entities/access_mode.dart';
import '../entities/local_profile.dart';
import '../entities/local_user_card.dart';
import '../entities/local_workspace.dart';
import '../repositories/initial_setup_repository.dart';

class CompleteInitialSetup {
  const CompleteInitialSetup(this.repository, {required this.generateId});

  final InitialSetupRepository repository;
  final String Function() generateId;

  Future<Result<LocalWorkspace>> call({
    required AccessMode accessMode,
    required String displayName,
    required String bankId,
    required String bankName,
    required String creditCardId,
    required String cardNickname,
    required int billingCycleDay,
    required int creditLimitMinor,
    String? authUserId,
    String? email,
  }) async {
    try {
      final workspace = LocalWorkspace(
        localId: generateId(),
        accessMode: accessMode,
        profile: LocalProfile(
          displayName: displayName.trim(),
          authUserId: authUserId,
          email: email,
        ),
        cards: [
          LocalUserCard(
            id: generateId(),
            bankId: bankId,
            creditCardId: creditCardId,
            bankName: bankName,
            nickname: cardNickname.trim(),
            billingCycleDay: billingCycleDay,
            creditLimitMinor: creditLimitMinor,
          ),
        ],
      );

      await repository.save(workspace);
      return Success(workspace);
    } on Exception {
      return const Failure(
        AppFailure('Could not finish setup. Please try again.'),
      );
    }
  }
}
