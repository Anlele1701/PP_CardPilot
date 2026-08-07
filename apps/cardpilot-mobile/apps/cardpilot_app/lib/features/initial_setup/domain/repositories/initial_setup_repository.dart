import '../entities/local_workspace.dart';

abstract interface class InitialSetupRepository {
  Future<void> save(LocalWorkspace workspace);

  Future<LocalWorkspace?> loadActiveGuest();

  Future<LocalWorkspace?> loadForAuthUser(String authUserId);
}
