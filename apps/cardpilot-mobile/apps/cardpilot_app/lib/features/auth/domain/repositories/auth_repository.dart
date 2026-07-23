import '../../../../core/result/result.dart';
import '../entities/social_auth_provider.dart';

abstract interface class AuthRepository {
  Future<Result<bool>> signInWithSocialProvider(SocialAuthProvider provider);
}
