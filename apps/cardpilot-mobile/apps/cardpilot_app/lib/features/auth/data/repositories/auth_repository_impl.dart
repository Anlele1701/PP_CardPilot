import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/app_failure.dart';
import '../../../../core/result/result.dart';
import '../../domain/entities/social_auth_provider.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/supabase_auth_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({required this.dataSource});

  final SupabaseAuthDataSource dataSource;

  @override
  Future<Result<bool>> signInWithSocialProvider(
    SocialAuthProvider provider,
  ) async {
    try {
      final launched = await dataSource.signInWithSocialProvider(provider);

      if (!launched) {
        return const Failure(
          AppFailure('Unable to open the sign-in page. Please try again.'),
        );
      }

      return const Success(true);
    } on AuthConfigurationException {
      return const Failure(
        AppFailure(
          'Supabase is not configured. Add SUPABASE_URL and '
          'SUPABASE_PUBLISHABLE_KEY.',
        ),
      );
    } on AuthException {
      return const Failure(
        AppFailure('Authentication could not be started. Please try again.'),
      );
    } on Exception {
      return const Failure(
        AppFailure('Unable to connect to the sign-in provider.'),
      );
    }
  }
}
