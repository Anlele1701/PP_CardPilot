import 'package:cardpilot_app/app/cardpilot_app.dart';
import 'package:cardpilot_app/features/startup/domain/startup_destination.dart';
import 'package:cardpilot_app/features/startup/startup_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders the authentication entry screen', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          startupDestinationProvider.overrideWith(
            (ref) async => const StartupDestination(route: StartupRoute.signIn),
          ),
        ],
        child: const CardPilotApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Welcome back'), findsOneWidget);
    expect(find.byKey(const Key('email-field')), findsOneWidget);
    expect(find.byKey(const Key('password-field')), findsOneWidget);
    expect(find.text('Google'), findsOneWidget);
  });

  testWidgets('can switch from sign in to account creation', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          startupDestinationProvider.overrideWith(
            (ref) async => const StartupDestination(route: StartupRoute.signIn),
          ),
        ],
        child: const CardPilotApp(),
      ),
    );
    await tester.pumpAndSettle();

    await tester.ensureVisible(
      find.byKey(const Key('switch-auth-mode-button')),
    );
    await tester.tap(find.byKey(const Key('switch-auth-mode-button')));
    await tester.pumpAndSettle();

    expect(find.text('Create your account'), findsOneWidget);
    expect(find.byKey(const Key('full-name-field')), findsOneWidget);
    expect(find.byKey(const Key('confirm-password-field')), findsOneWidget);
  });
}
