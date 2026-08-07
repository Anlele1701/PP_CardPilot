import 'package:cardpilot_app/core/routing/app_routes.dart';
import 'package:cardpilot_app/core/routing/app_router.dart';
import 'package:cardpilot_app/features/auth/auth_providers.dart';
import 'package:cardpilot_app/features/home/presentation/views/home_screen.dart';
import 'package:cardpilot_app/features/initial_setup/domain/entities/access_mode.dart';
import 'package:cardpilot_app/features/initial_setup/domain/entities/local_profile.dart';
import 'package:cardpilot_app/features/initial_setup/domain/entities/local_user_card.dart';
import 'package:cardpilot_app/features/initial_setup/domain/entities/local_workspace.dart';
import 'package:cardpilot_app/features/initial_setup/initial_setup_providers.dart';
import 'package:cardpilot_ui/cardpilot_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../auth/support/fake_auth_repository.dart';

void main() {
  testWidgets('redirects to the error screen when workspace is missing', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          initialRoute: AppRoutes.home,
          onGenerateRoute: AppRouter().onGenerateRoute,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('We couldn\'t load your workspace'), findsOneWidget);
    expect(find.text('Back to sign in'), findsOneWidget);

    await tester.tap(find.text('Back to sign in'));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('email-field')), findsOneWidget);
    expect(find.text('We couldn\'t load your workspace'), findsNothing);
  });

  testWidgets('logs a signed-in user out and clears the navigation stack', (
    tester,
  ) async {
    final repository = FakeAuthRepository();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(repository),
          initialSetupControllerProvider.overrideWith(
            _SignedInInitialSetupController.new,
          ),
        ],
        child: MaterialApp(
          theme: AppTheme.light,
          home: const HomeScreen(),
          routes: {
            AppRoutes.signIn: (_) =>
                const Scaffold(body: Center(child: Text('Signed out screen'))),
          },
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('navigation-item-4')));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(find.text('Log out'), 180);
    expect(find.text('Log out'), findsOneWidget);

    await tester.tap(find.text('Log out'));
    await tester.pumpAndSettle();
    expect(find.text('Log out?'), findsOneWidget);

    await tester.tap(find.widgetWithText(FilledButton, 'Log out'));
    await tester.pumpAndSettle();

    expect(repository.signOutCallCount, 1);
    expect(find.text('Signed out screen'), findsOneWidget);
  });

  testWidgets('uses the five-part shell and opens quick transaction actions', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          initialSetupControllerProvider.overrideWith(
            _SignedInInitialSetupController.new,
          ),
        ],
        child: MaterialApp(theme: AppTheme.light, home: const HomeScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Available Balance'), findsOneWidget);
    expect(find.byKey(const Key('premium-card')), findsOneWidget);
    await tester.scrollUntilVisible(
      find.byKey(const Key('spending-overview-card')),
      220,
    );
    expect(find.byKey(const Key('spending-overview-card')), findsOneWidget);
    expect(find.byKey(const Key('home-navigation-bar')), findsOneWidget);
    expect(find.byKey(const Key('navigation-item-0')), findsOneWidget);
    expect(find.byKey(const Key('navigation-item-1')), findsOneWidget);
    expect(find.byKey(const Key('primary-navigation-item')), findsOneWidget);
    expect(find.byKey(const Key('navigation-item-3')), findsOneWidget);
    expect(find.byKey(const Key('navigation-item-4')), findsOneWidget);

    await tester.tap(find.byKey(const Key('primary-navigation-item')));
    await tester.pumpAndSettle();

    expect(find.text('Add a transaction'), findsOneWidget);
    expect(find.byKey(const Key('scan-receipt-action')), findsOneWidget);
    expect(find.byKey(const Key('add-manually-action')), findsOneWidget);

    await tester.tap(find.byKey(const Key('scan-receipt-action')));
    await tester.pumpAndSettle();
    expect(find.text('Receipt scanning is coming next.'), findsOneWidget);

    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('navigation-item-3')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('transaction-filter-button')), findsOneWidget);

    await tester.tap(find.byKey(const Key('navigation-item-4')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('sync-now-button')), findsOneWidget);
  });
}

class _SignedInInitialSetupController extends InitialSetupController {
  @override
  InitialSetupState build() {
    return const InitialSetupState(
      status: InitialSetupStatus.completed,
      accessMode: AccessMode.authenticated,
      workspace: LocalWorkspace(
        localId: 'local-user',
        accessMode: AccessMode.authenticated,
        profile: LocalProfile(displayName: 'Card Pilot'),
        cards: [
          LocalUserCard(
            id: 'local-card',
            bankId: 'bank-acb',
            bankName: 'ACB',
            nickname: 'Everyday card',
            billingCycleDay: 15,
          ),
        ],
      ),
    );
  }
}
