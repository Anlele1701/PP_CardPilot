import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/social_auth_provider.dart';

class SupabaseAuthDataSource {
  const SupabaseAuthDataSource({
    required this.client,
    required this.redirectUrl,
  });

  final SupabaseClient? client;
  final String redirectUrl;

  Future<bool> signInWithSocialProvider(SocialAuthProvider provider) {
    final configuredClient = client;

    if (configuredClient == null) {
      throw const AuthConfigurationException();
    }

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
}

class AuthConfigurationException implements Exception {
  const AuthConfigurationException();
}
