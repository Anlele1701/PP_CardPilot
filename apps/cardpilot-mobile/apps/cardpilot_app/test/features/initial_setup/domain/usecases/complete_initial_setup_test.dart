import 'package:cardpilot_app/features/initial_setup/domain/entities/access_mode.dart';
import 'package:cardpilot_app/features/initial_setup/domain/entities/local_workspace.dart';
import 'package:cardpilot_app/features/initial_setup/domain/repositories/initial_setup_repository.dart';
import 'package:cardpilot_app/features/initial_setup/domain/usecases/complete_initial_setup.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('creates a workspace for guest and authenticated modes', () async {
    for (final accessMode in AccessMode.values) {
      final repository = _FakeInitialSetupRepository();
      final completeInitialSetup = CompleteInitialSetup(repository);

      final result = await completeInitialSetup(
        accessMode: accessMode,
        displayName: '  An  ',
        bankName: 'ACB',
        cardNickname: '  Everyday Visa  ',
        billingCycleDay: 15,
      );

      final workspace = result.when(
        success: (data) => data,
        failure: (failure) => throw TestFailure(failure.message),
      );

      expect(workspace.localId, startsWith('local-'));
      expect(workspace.accessMode, accessMode);
      expect(workspace.profile.displayName, 'An');
      expect(workspace.cards.single.bankName, 'ACB');
      expect(workspace.cards.single.nickname, 'Everyday Visa');
      expect(workspace.cards.single.billingCycleDay, 15);
      expect(repository.savedWorkspace, same(workspace));
    }
  });
}

class _FakeInitialSetupRepository implements InitialSetupRepository {
  LocalWorkspace? savedWorkspace;

  @override
  Future<LocalWorkspace?> load() async => savedWorkspace;

  @override
  Future<void> save(LocalWorkspace workspace) async {
    savedWorkspace = workspace;
  }
}
