import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/social_auth_provider.dart';
import '../../domain/entities/auth_user_identity.dart';

class SupabaseAuthDataSource {
  const SupabaseAuthDataSource({
    required this.client,
    required this.redirectUrl,
  });

  final SupabaseClient? client;
  final String redirectUrl;

  AuthUserIdentity? get currentUserIdentity {
    final user = client?.auth.currentUser;
    if (user == null) {
      return null;
    }

    final displayName = user.userMetadata?['full_name'];
    return AuthUserIdentity(
      id: user.id,
      email: user.email,
      displayName: displayName is String ? displayName : null,
    );
  }

  Future<AuthResponse> signInWithEmail({
    required String email,
    required String password,
  }) {
    final configuredClient = _configuredClient();
    return configuredClient.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<AuthResponse> signUpWithEmail({
    required String fullName,
    required String email,
    required String password,
  }) {
    final configuredClient = _configuredClient();
    return configuredClient.auth.signUp(
      email: email,
      password: password,
      data: {'full_name': fullName},
      emailRedirectTo: kIsWeb ? null : redirectUrl,
    );
  }

  Future<bool> signInWithSocialProvider(SocialAuthProvider provider) {
    final configuredClient = _configuredClient();

    return configuredClient.auth.signInWithOAuth(
      switch (provider) {
        SocialAuthProvider.google => OAuthProvider.google,
        SocialAuthProvider.facebook => OAuthProvider.facebook,
      },
      redirectTo: kIsWeb ? null : redirectUrl,
      authScreenLaunchMode: kIsWeb
          ? LaunchMode.platformDefault
          : LaunchMode.externalApplication,
    );
  }

  Future<void> signOut() {
    return _configuredClient().auth.signOut();
  }

  SupabaseClient _configuredClient() {
    final configuredClient = client;
    if (configuredClient == null) {
      throw const AuthConfigurationException();
    }
    return configuredClient;
  }
}

class AuthConfigurationException implements Exception {
  const AuthConfigurationException();
}
