import '../entities/local_workspace.dart';

abstract interface class InitialSetupRepository {
  Future<void> save(LocalWorkspace workspace);

  Future<LocalWorkspace?> load();
}
