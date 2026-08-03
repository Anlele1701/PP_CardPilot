import 'package:cardpilot_app/core/result/result.dart';
import 'package:cardpilot_app/features/auth/domain/entities/credential_auth_result.dart';
import 'package:cardpilot_app/features/auth/domain/entities/social_auth_provider.dart';
import 'package:cardpilot_app/features/auth/domain/repositories/auth_repository.dart';

class FakeAuthRepository implements AuthRepository {
  FakeAuthRepository({
    this.credentialResult = const CredentialAuthResult(
      hasSession: true,
      requiresEmailConfirmation: false,
    ),
  });

  final CredentialAuthResult credentialResult;
  final requestedProviders = <SocialAuthProvider>[];

  String? signInEmail;
  String? signInPassword;
  String? signUpFullName;
  String? signUpEmail;
  String? signUpPassword;
  var signOutCallCount = 0;

  @override
  Future<Result<CredentialAuthResult>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    signInEmail = email;
    signInPassword = password;
    return Success(credentialResult);
  }

  @override
  Future<Result<bool>> signInWithSocialProvider(
    SocialAuthProvider provider,
  ) async {
    requestedProviders.add(provider);
    return const Success(true);
  }

  @override
  Future<Result<CredentialAuthResult>> signUpWithEmail({
    required String fullName,
    required String email,
    required String password,
  }) async {
    signUpFullName = fullName;
    signUpEmail = email;
    signUpPassword = password;
    return Success(credentialResult);
  }

  @override
  Future<Result<void>> signOut() async {
    signOutCallCount += 1;
    return const Success<void>(null);
  }
}
