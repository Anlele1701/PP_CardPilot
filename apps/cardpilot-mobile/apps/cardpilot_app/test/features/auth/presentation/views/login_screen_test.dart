import 'package:cardpilot_app/core/result/result.dart';
import 'package:cardpilot_app/features/auth/auth_providers.dart';
import 'package:cardpilot_app/features/auth/domain/entities/social_auth_provider.dart';
import 'package:cardpilot_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:cardpilot_app/features/auth/presentation/views/login_screen.dart';
import 'package:cardpilot_ui/cardpilot_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('starts Google sign-in and displays redirect guidance', (
    tester,
  ) async {
    final repository = _FakeAuthRepository();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [authRepositoryProvider.overrideWithValue(repository)],
        child: MaterialApp(theme: AppTheme.light, home: const LoginScreen()),
      ),
    );

    expect(find.text('Welcome to CardPilot'), findsOneWidget);
    expect(find.text('Continue with Google'), findsOneWidget);
    expect(find.text('Continue with Facebook'), findsOneWidget);

    await tester.tap(find.text('Continue with Google'));
    await tester.pumpAndSettle();

    expect(repository.requestedProviders, [SocialAuthProvider.google]);
    expect(
      find.text('Complete sign-in in your browser, then return to CardPilot.'),
      findsOneWidget,
    );
  });
}

class _FakeAuthRepository implements AuthRepository {
  final requestedProviders = <SocialAuthProvider>[];

  @override
  Future<Result<bool>> signInWithSocialProvider(
    SocialAuthProvider provider,
  ) async {
    requestedProviders.add(provider);
    return const Success(true);
  }
}
