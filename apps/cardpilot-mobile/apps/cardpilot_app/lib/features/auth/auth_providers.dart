import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/config/app_config.dart';
import 'data/datasources/supabase_auth_data_source.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/entities/social_auth_provider.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/usecases/sign_in_with_social_provider.dart';

enum LoginStatus { idle, loading, redirecting, failure }

class LoginState {
  const LoginState({
    required this.status,
    this.activeProvider,
    this.errorMessage,
  });

  const LoginState.idle()
    : status = LoginStatus.idle,
      activeProvider = null,
      errorMessage = null;

  final LoginStatus status;
  final SocialAuthProvider? activeProvider;
  final String? errorMessage;
}

class LoginController extends Notifier<LoginState> {
  @override
  LoginState build() => const LoginState.idle();

  Future<void> signIn(SocialAuthProvider provider) async {
    if (state.status == LoginStatus.loading) {
      return;
    }

    state = LoginState(status: LoginStatus.loading, activeProvider: provider);

    final result = await ref.read(signInWithSocialProviderProvider)(provider);

    result.when(
      success: (_) {
        state = LoginState(
          status: LoginStatus.redirecting,
          activeProvider: provider,
        );
      },
      failure: (failure) {
        state = LoginState(
          status: LoginStatus.failure,
          activeProvider: provider,
          errorMessage: failure.message,
        );
      },
    );
  }
}

final supabaseAuthDataSourceProvider = Provider<SupabaseAuthDataSource>((ref) {
  return SupabaseAuthDataSource(
    client: AppConfig.isSupabaseConfigured ? Supabase.instance.client : null,
    redirectUrl: AppConfig.oauthRedirectUrl,
  );
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    dataSource: ref.watch(supabaseAuthDataSourceProvider),
  );
});

final signInWithSocialProviderProvider = Provider<SignInWithSocialProvider>((
  ref,
) {
  return SignInWithSocialProvider(ref.watch(authRepositoryProvider));
});

final loginControllerProvider =
    NotifierProvider.autoDispose<LoginController, LoginState>(
      LoginController.new,
    );
