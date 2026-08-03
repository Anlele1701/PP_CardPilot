import '../../domain/entities/local_workspace.dart';
import '../../domain/repositories/initial_setup_repository.dart';
import '../datasources/initial_setup_memory_data_source.dart';

class InitialSetupRepositoryImpl implements InitialSetupRepository {
  const InitialSetupRepositoryImpl({required this.localDataSource});

  final InitialSetupMemoryDataSource localDataSource;

  @override
  Future<LocalWorkspace?> load() => localDataSource.load();

  @override
  Future<void> save(LocalWorkspace workspace) {
    return localDataSource.save(workspace);
  }
}
