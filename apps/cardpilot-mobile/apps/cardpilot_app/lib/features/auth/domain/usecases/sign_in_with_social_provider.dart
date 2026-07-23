import '../../../../core/result/result.dart';
import '../entities/social_auth_provider.dart';
import '../repositories/auth_repository.dart';

class SignInWithSocialProvider {
  const SignInWithSocialProvider(this.repository);

  final AuthRepository repository;

  Future<Result<bool>> call(SocialAuthProvider provider) {
    return repository.signInWithSocialProvider(provider);
  }
}
