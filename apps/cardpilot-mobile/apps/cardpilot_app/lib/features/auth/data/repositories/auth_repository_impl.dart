import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/app_failure.dart';
import '../../../../core/result/result.dart';
import '../../domain/entities/credential_auth_result.dart';
import '../../domain/entities/social_auth_provider.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/supabase_auth_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({required this.dataSource});

  final SupabaseAuthDataSource dataSource;

  @override
  Future<Result<CredentialAuthResult>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dataSource.signInWithEmail(
        email: email,
        password: password,
      );
      return Success(
        CredentialAuthResult(
          hasSession: response.session != null,
          requiresEmailConfirmation: false,
        ),
      );
    } on AuthConfigurationException {
      return const Failure(AppFailure(_configurationMessage));
    } on AuthException catch (exception) {
      return Failure(AppFailure(_authMessage(exception)));
    } on Exception {
      return const Failure(
        AppFailure('Unable to sign in right now. Please try again.'),
      );
    }
  }

  @override
  Future<Result<CredentialAuthResult>> signUpWithEmail({
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      final response = await dataSource.signUpWithEmail(
        fullName: fullName,
        email: email,
        password: password,
      );
      return Success(
        CredentialAuthResult(
          hasSession: response.session != null,
          requiresEmailConfirmation: response.session == null,
        ),
      );
    } on AuthConfigurationException {
      return const Failure(AppFailure(_configurationMessage));
    } on AuthException catch (exception) {
      return Failure(AppFailure(_authMessage(exception)));
    } on Exception {
      return const Failure(
        AppFailure('Unable to create your account right now.'),
      );
    }
  }

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
      return const Failure(AppFailure(_configurationMessage));
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

  @override
  Future<Result<void>> signOut() async {
    try {
      await dataSource.signOut();
      return const Success<void>(null);
    } on AuthConfigurationException {
      return const Failure(AppFailure(_configurationMessage));
    } on AuthException {
      return const Failure(
        AppFailure('Unable to sign out right now. Please try again.'),
      );
    } on Exception {
      return const Failure(
        AppFailure('Unable to sign out right now. Please try again.'),
      );
    }
  }
}

const _configurationMessage =
    'Supabase is not configured. Add SUPABASE_URL and '
    'SUPABASE_PUBLISHABLE_KEY.';

String _authMessage(AuthException exception) {
  return switch (exception.code) {
    'invalid_credentials' => 'Email or password is incorrect.',
    'email_not_confirmed' => 'Confirm your email before signing in.',
    'user_already_exists' => 'An account already exists for this email.',
    'weak_password' => 'Choose a stronger password and try again.',
    _ => exception.message,
  };
}
