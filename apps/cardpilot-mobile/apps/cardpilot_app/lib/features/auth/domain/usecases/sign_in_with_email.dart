import '../../../../core/result/result.dart';
import '../entities/credential_auth_result.dart';
import '../repositories/auth_repository.dart';

class SignInWithEmail {
  const SignInWithEmail(this.repository);

  final AuthRepository repository;

  Future<Result<CredentialAuthResult>> call({
    required String email,
    required String password,
  }) {
    return repository.signInWithEmail(email: email.trim(), password: password);
  }
}
