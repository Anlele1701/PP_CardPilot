import '../../../../core/result/result.dart';
import '../entities/credential_auth_result.dart';
import '../entities/social_auth_provider.dart';

abstract interface class AuthRepository {
  Future<Result<bool>> signInWithSocialProvider(SocialAuthProvider provider);

  Future<Result<CredentialAuthResult>> signInWithEmail({
    required String email,
    required String password,
  });

  Future<Result<CredentialAuthResult>> signUpWithEmail({
    required String fullName,
    required String email,
    required String password,
  });

  Future<Result<void>> signOut();
}
