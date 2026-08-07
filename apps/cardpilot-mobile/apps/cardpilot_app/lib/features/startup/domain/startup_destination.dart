import '../../initial_setup/domain/entities/access_mode.dart';
import '../../initial_setup/domain/entities/local_workspace.dart';

enum StartupRoute { signIn, setupProfile, home }

class StartupDestination {
  const StartupDestination({
    required this.route,
    this.accessMode,
    this.workspace,
  });

  final StartupRoute route;
  final AccessMode? accessMode;
  final LocalWorkspace? workspace;
}
