import '../../auth/domain/entities/auth_user_identity.dart';
import '../../initial_setup/domain/entities/access_mode.dart';
import '../../initial_setup/domain/repositories/initial_setup_repository.dart';
import 'startup_destination.dart';

class ResolveStartupDestination {
  const ResolveStartupDestination(this.repository);

  final InitialSetupRepository repository;

  Future<StartupDestination> call(AuthUserIdentity? authUser) async {
    if (authUser != null) {
      final workspace = await repository.loadForAuthUser(authUser.id);
      if (workspace != null) {
        return StartupDestination(
          route: StartupRoute.home,
          accessMode: AccessMode.authenticated,
          workspace: workspace,
        );
      }

      return const StartupDestination(
        route: StartupRoute.setupProfile,
        accessMode: AccessMode.authenticated,
      );
    }

    final guestWorkspace = await repository.loadActiveGuest();
    if (guestWorkspace != null) {
      return StartupDestination(
        route: StartupRoute.home,
        accessMode: AccessMode.guest,
        workspace: guestWorkspace,
      );
    }

    return const StartupDestination(route: StartupRoute.signIn);
  }
}
