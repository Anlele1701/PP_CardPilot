import 'package:cardpilot_app/core/routing/app_routes.dart';
import 'package:cardpilot_app/features/auth/auth_providers.dart';
import 'package:cardpilot_app/features/auth/domain/entities/social_auth_provider.dart';
import 'package:cardpilot_app/features/auth/presentation/views/sign_in_screen.dart';
import 'package:cardpilot_app/features/auth/presentation/views/sign_up_screen.dart';
import 'package:cardpilot_app/features/initial_setup/presentation/views/profile_setup_screen.dart';
import 'package:cardpilot_ui/cardpilot_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/fake_auth_repository.dart';

void main() {
  testWidgets('signs in with email and password', (tester) async {
    final repository = FakeAuthRepository();
    await _pumpAuthFlow(tester, repository);

    expect(find.text('Welcome back'), findsOneWidget);
    expect(
      tester.getSize(find.byKey(const Key('auth-page-background'))),
      tester.view.physicalSize / tester.view.devicePixelRatio,
    );

    await tester.enterText(
      find.byKey(const Key('email-field')),
      'pilot@example.com',
    );
    await tester.enterText(
      find.byKey(const Key('password-field')),
      'secret-password',
    );
    await tester.tap(find.byKey(const Key('credential-submit-button')));
    await tester.pumpAndSettle();

    expect(repository.signInEmail, 'pilot@example.com');
    expect(repository.signInPassword, 'secret-password');
  });

  testWidgets('opens a fresh sign-up form without sign-in values', (
    tester,
  ) async {
    final repository = FakeAuthRepository();
    await _pumpAuthFlow(tester, repository);

    await tester.enterText(
      find.byKey(const Key('email-field')),
      'existing@example.com',
    );
    await tester.enterText(
      find.byKey(const Key('password-field')),
      'existing-password',
    );
    await tester.ensureVisible(
      find.byKey(const Key('switch-auth-mode-button')),
    );
    await tester.tap(find.byKey(const Key('switch-auth-mode-button')));
    await tester.pumpAndSettle();

    expect(find.text('Create your account'), findsOneWidget);
    expect(_fieldText(tester, const Key('email-field')), isEmpty);
    expect(_fieldText(tester, const Key('password-field')), isEmpty);
  });

  testWidgets('starts Google sign-in and displays redirect guidance', (
    tester,
  ) async {
    final repository = FakeAuthRepository();
    await _pumpAuthFlow(tester, repository);

    await tester.ensureVisible(find.text('Google'));
    await tester.tap(find.text('Google'));
    await tester.pumpAndSettle();

    expect(repository.requestedProviders, [SocialAuthProvider.google]);
    expect(
      find.text('Complete sign-in in your browser, then return to CardPilot.'),
      findsOneWidget,
    );
  });

  testWidgets('continues as guest into the shared profile setup flow', (
    tester,
  ) async {
    final repository = FakeAuthRepository();
    await _pumpAuthFlow(tester, repository);

    await tester.ensureVisible(
      find.byKey(const Key('continue-as-guest-button')),
    );
    await tester.tap(find.byKey(const Key('continue-as-guest-button')));
    await tester.pumpAndSettle();

    expect(find.text('Set up your profile'), findsOneWidget);
    expect(
      find.text('We will save this profile on your device.'),
      findsOneWidget,
    );
  });
}

Future<void> _pumpAuthFlow(WidgetTester tester, FakeAuthRepository repository) {
  return tester.pumpWidget(
    ProviderScope(
      overrides: [authRepositoryProvider.overrideWithValue(repository)],
      child: MaterialApp(
        theme: AppTheme.light,
        initialRoute: AppRoutes.signIn,
        routes: {
          AppRoutes.signIn: (_) => const SignInScreen(),
          AppRoutes.signUp: (_) => const SignUpScreen(),
          AppRoutes.setupProfile: (_) => const ProfileSetupScreen(),
        },
      ),
    ),
  );
}

String _fieldText(WidgetTester tester, Key key) {
  final field = find.descendant(
    of: find.byKey(key),
    matching: find.byType(TextFormField),
  );
  return tester.widget<TextFormField>(field).controller?.text ?? '';
}
