import 'package:cardpilot_app/features/auth/auth_providers.dart';
import 'package:cardpilot_app/features/auth/domain/entities/credential_auth_result.dart';
import 'package:cardpilot_app/features/auth/presentation/views/sign_up_screen.dart';
import 'package:cardpilot_ui/cardpilot_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/fake_auth_repository.dart';

void main() {
  testWidgets('creates an email account and asks for email confirmation', (
    tester,
  ) async {
    final repository = FakeAuthRepository(
      credentialResult: const CredentialAuthResult(
        hasSession: false,
        requiresEmailConfirmation: true,
      ),
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: [authRepositoryProvider.overrideWithValue(repository)],
        child: MaterialApp(theme: AppTheme.light, home: const SignUpScreen()),
      ),
    );

    expect(find.text('Create your account'), findsOneWidget);

    await tester.enterText(
      find.byKey(const Key('full-name-field')),
      'Card Pilot',
    );
    await tester.enterText(
      find.byKey(const Key('email-field')),
      'new@example.com',
    );
    await tester.enterText(
      find.byKey(const Key('password-field')),
      'cardpilot123',
    );
    await tester.enterText(
      find.byKey(const Key('confirm-password-field')),
      'cardpilot123',
    );
    await tester.ensureVisible(find.byKey(const Key('terms-checkbox')));
    await tester.tap(find.byKey(const Key('terms-checkbox')));
    await tester.ensureVisible(
      find.byKey(const Key('credential-submit-button')),
    );
    await tester.tap(find.byKey(const Key('credential-submit-button')));
    await tester.pumpAndSettle();

    expect(repository.signUpFullName, 'Card Pilot');
    expect(repository.signUpEmail, 'new@example.com');
    expect(repository.signUpPassword, 'cardpilot123');
    expect(
      find.textContaining('Account created. Check your email'),
      findsOneWidget,
    );

    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();
  });
}
