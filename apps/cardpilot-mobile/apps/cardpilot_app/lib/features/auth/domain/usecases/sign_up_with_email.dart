import '../../../../core/result/result.dart';
import '../entities/credential_auth_result.dart';
import '../repositories/auth_repository.dart';

class SignUpWithEmail {
  const SignUpWithEmail(this.repository);

  final AuthRepository repository;

  Future<Result<CredentialAuthResult>> call({
    required String fullName,
    required String email,
    required String password,
  }) {
    return repository.signUpWithEmail(
      fullName: fullName.trim(),
      email: email.trim(),
      password: password,
    );
  }
}
