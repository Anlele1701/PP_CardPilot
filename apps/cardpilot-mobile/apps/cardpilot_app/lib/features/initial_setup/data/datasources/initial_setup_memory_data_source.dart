import '../../domain/entities/local_workspace.dart';

class InitialSetupMemoryDataSource {
  LocalWorkspace? _workspace;

  Future<void> save(LocalWorkspace workspace) async {
    _workspace = workspace;
  }

  Future<LocalWorkspace?> load() async => _workspace;
}
