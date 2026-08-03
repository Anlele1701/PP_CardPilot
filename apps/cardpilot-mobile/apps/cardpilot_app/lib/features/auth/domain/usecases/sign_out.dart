import '../../../../core/result/result.dart';
import '../repositories/auth_repository.dart';

class SignOut {
  const SignOut(this.repository);

  final AuthRepository repository;

  Future<Result<void>> call() {
    return repository.signOut();
  }
}
