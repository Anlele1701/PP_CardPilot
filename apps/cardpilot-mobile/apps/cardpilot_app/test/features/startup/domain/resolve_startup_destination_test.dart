import 'package:cardpilot_app/features/auth/domain/entities/auth_user_identity.dart';
import 'package:cardpilot_app/features/initial_setup/domain/entities/access_mode.dart';
import 'package:cardpilot_app/features/initial_setup/domain/entities/local_profile.dart';
import 'package:cardpilot_app/features/initial_setup/domain/entities/local_user_card.dart';
import 'package:cardpilot_app/features/initial_setup/domain/entities/local_workspace.dart';
import 'package:cardpilot_app/features/initial_setup/domain/repositories/initial_setup_repository.dart';
import 'package:cardpilot_app/features/startup/domain/resolve_startup_destination.dart';
import 'package:cardpilot_app/features/startup/domain/startup_destination.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('restores a completed authenticated profile to Home', () async {
    const workspace = LocalWorkspace(
      localId: 'profile-a',
      accessMode: AccessMode.authenticated,
      profile: LocalProfile(displayName: 'Account A', authUserId: 'auth-a'),
      cards: [
        LocalUserCard(
          id: 'card-a',
          bankId: 'bank-acb',
          bankName: 'ACB',
          nickname: 'Everyday',
          billingCycleDay: 15,
        ),
      ],
    );
    final repository = _FakeInitialSetupRepository(
      authenticatedWorkspace: workspace,
    );

    final destination = await ResolveStartupDestination(repository)(
      const AuthUserIdentity(id: 'auth-a'),
    );

    expect(destination.route, StartupRoute.home);
    expect(destination.workspace, same(workspace));
  });

  test(
    'sends an authenticated user without a local profile to setup',
    () async {
      final destination = await ResolveStartupDestination(
        _FakeInitialSetupRepository(),
      )(const AuthUserIdentity(id: 'new-auth-user'));

      expect(destination.route, StartupRoute.setupProfile);
      expect(destination.accessMode, AccessMode.authenticated);
    },
  );

  test('restores a completed guest to Home', () async {
    const workspace = LocalWorkspace(
      localId: 'guest',
      accessMode: AccessMode.guest,
      profile: LocalProfile(displayName: 'Guest'),
      cards: [
        LocalUserCard(
          id: 'guest-card',
          bankId: 'bank-mb',
          bankName: 'MB',
          nickname: 'Guest card',
          billingCycleDay: 20,
        ),
      ],
    );

    final destination = await ResolveStartupDestination(
      _FakeInitialSetupRepository(guestWorkspace: workspace),
    )(null);

    expect(destination.route, StartupRoute.home);
    expect(destination.workspace, same(workspace));
  });
}

class _FakeInitialSetupRepository implements InitialSetupRepository {
  _FakeInitialSetupRepository({
    this.guestWorkspace,
    this.authenticatedWorkspace,
  });

  final LocalWorkspace? guestWorkspace;
  final LocalWorkspace? authenticatedWorkspace;

  @override
  Future<LocalWorkspace?> loadActiveGuest() async => guestWorkspace;

  @override
  Future<LocalWorkspace?> loadForAuthUser(String authUserId) async {
    return authenticatedWorkspace;
  }

  @override
  Future<void> save(LocalWorkspace workspace) async {}
}
