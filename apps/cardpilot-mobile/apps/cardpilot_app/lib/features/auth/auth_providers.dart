import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/config/app_config.dart';
import '../../core/result/result.dart';
import 'data/datasources/supabase_auth_data_source.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/entities/credential_auth_result.dart';
import 'domain/entities/auth_user_identity.dart';
import 'domain/entities/social_auth_provider.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/usecases/sign_in_with_email.dart';
import 'domain/usecases/sign_in_with_social_provider.dart';
import 'domain/usecases/sign_up_with_email.dart';
import 'domain/usecases/sign_out.dart';

enum LoginStatus {
  idle,
  loading,
  redirecting,
  success,
  emailConfirmationRequired,
  failure,
}

enum LoginAction { emailSignIn, emailSignUp, social }

class LoginState {
  const LoginState({
    required this.status,
    this.activeAction,
    this.activeProvider,
    this.errorMessage,
  });

  const LoginState.idle()
    : status = LoginStatus.idle,
      activeAction = null,
      activeProvider = null,
      errorMessage = null;

  final LoginStatus status;
  final LoginAction? activeAction;
  final SocialAuthProvider? activeProvider;
  final String? errorMessage;
}

class LoginController extends Notifier<LoginState> {
  @override
  LoginState build() => const LoginState.idle();

  void reset() {
    state = const LoginState.idle();
  }

  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) {
    return _runCredentialAction(
      action: LoginAction.emailSignIn,
      request: () =>
          ref.read(signInWithEmailProvider)(email: email, password: password),
    );
  }

  Future<void> signUpWithEmail({
    required String fullName,
    required String email,
    required String password,
  }) {
    return _runCredentialAction(
      action: LoginAction.emailSignUp,
      request: () => ref.read(signUpWithEmailProvider)(
        fullName: fullName,
        email: email,
        password: password,
      ),
    );
  }

  Future<void> signIn(SocialAuthProvider provider) async {
    if (state.status == LoginStatus.loading) {
      return;
    }

    state = LoginState(
      status: LoginStatus.loading,
      activeAction: LoginAction.social,
      activeProvider: provider,
    );

    final result = await ref.read(signInWithSocialProviderProvider)(provider);

    result.when(
      success: (_) {
        state = LoginState(
          status: LoginStatus.redirecting,
          activeAction: LoginAction.social,
          activeProvider: provider,
        );
      },
      failure: (failure) {
        state = LoginState(
          status: LoginStatus.failure,
          activeAction: LoginAction.social,
          activeProvider: provider,
          errorMessage: failure.message,
        );
      },
    );
  }

  Future<void> _runCredentialAction({
    required LoginAction action,
    required Future<Result<CredentialAuthResult>> Function() request,
  }) async {
    if (state.status == LoginStatus.loading) {
      return;
    }

    state = LoginState(status: LoginStatus.loading, activeAction: action);
    final result = await request();

    result.when(
      success: (authResult) {
        state = LoginState(
          status: authResult.requiresEmailConfirmation
              ? LoginStatus.emailConfirmationRequired
              : LoginStatus.success,
          activeAction: action,
        );
      },
      failure: (failure) {
        state = LoginState(
          status: LoginStatus.failure,
          activeAction: action,
          errorMessage: failure.message,
        );
      },
    );
  }
}

enum SignOutStatus { idle, loading, failure }

class SignOutState {
  const SignOutState({required this.status, this.errorMessage});

  const SignOutState.idle() : status = SignOutStatus.idle, errorMessage = null;

  final SignOutStatus status;
  final String? errorMessage;
}

class SignOutController extends Notifier<SignOutState> {
  @override
  SignOutState build() => const SignOutState.idle();

  Future<bool> signOut() async {
    if (state.status == SignOutStatus.loading) {
      return false;
    }

    state = const SignOutState(status: SignOutStatus.loading);
    final result = await ref.read(signOutProvider)();

    return result.when(
      success: (_) {
        state = const SignOutState.idle();
        return true;
      },
      failure: (failure) {
        state = SignOutState(
          status: SignOutStatus.failure,
          errorMessage: failure.message,
        );
        return false;
      },
    );
  }

  void reset() {
    state = const SignOutState.idle();
  }
}

final supabaseAuthDataSourceProvider = Provider<SupabaseAuthDataSource>((ref) {
  return SupabaseAuthDataSource(
    client: AppConfig.isSupabaseConfigured ? Supabase.instance.client : null,
    redirectUrl: AppConfig.oauthRedirectUrl,
  );
});

final currentAuthUserProvider = Provider<AuthUserIdentity?>((ref) {
  return ref.watch(supabaseAuthDataSourceProvider).currentUserIdentity;
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

final signInWithEmailProvider = Provider<SignInWithEmail>((ref) {
  return SignInWithEmail(ref.watch(authRepositoryProvider));
});

final signUpWithEmailProvider = Provider<SignUpWithEmail>((ref) {
  return SignUpWithEmail(ref.watch(authRepositoryProvider));
});

final signOutProvider = Provider<SignOut>((ref) {
  return SignOut(ref.watch(authRepositoryProvider));
});

final loginControllerProvider =
    NotifierProvider.autoDispose<LoginController, LoginState>(
      LoginController.new,
    );

final signOutControllerProvider =
    NotifierProvider.autoDispose<SignOutController, SignOutState>(
      SignOutController.new,
    );
