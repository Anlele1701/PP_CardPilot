import '../../../../core/errors/app_failure.dart';
import '../../../../core/result/result.dart';
import '../entities/access_mode.dart';
import '../entities/local_profile.dart';
import '../entities/local_user_card.dart';
import '../entities/local_workspace.dart';
import '../repositories/initial_setup_repository.dart';

class CompleteInitialSetup {
  const CompleteInitialSetup(this.repository);

  final InitialSetupRepository repository;

  Future<Result<LocalWorkspace>> call({
    required AccessMode accessMode,
    required String displayName,
    required String bankName,
    required String cardNickname,
    required int billingCycleDay,
  }) async {
    try {
      final workspace = LocalWorkspace(
        localId: 'local-${DateTime.now().microsecondsSinceEpoch}',
        accessMode: accessMode,
        profile: LocalProfile(displayName: displayName.trim()),
        cards: [
          LocalUserCard(
            bankName: bankName,
            nickname: cardNickname.trim(),
            billingCycleDay: billingCycleDay,
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
