import '../../domain/entities/local_workspace.dart';
import '../../domain/repositories/initial_setup_repository.dart';
import '../datasources/initial_setup_local_data_source.dart';

class InitialSetupRepositoryImpl implements InitialSetupRepository {
  const InitialSetupRepositoryImpl({required this.localDataSource});

  final InitialSetupLocalDataSource localDataSource;

  @override
  Future<LocalWorkspace?> loadActiveGuest() {
    return localDataSource.loadActiveGuest();
  }

  @override
  Future<LocalWorkspace?> loadForAuthUser(String authUserId) {
    return localDataSource.loadForAuthUser(authUserId);
  }

  @override
  Future<void> save(LocalWorkspace workspace) {
    return localDataSource.save(workspace);
  }
}
