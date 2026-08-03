import 'package:cardpilot_app/core/routing/app_router.dart';
import 'package:cardpilot_ui/cardpilot_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('guest completes shared setup and opens the app shell', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: AppTheme.light,
          onGenerateRoute: const AppRouter().onGenerateRoute,
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Continue without an account'));
    await tester.pumpAndSettle();

    expect(find.text('Set up your profile'), findsOneWidget);
    await tester.enterText(find.byType(TextFormField), 'An');
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Card nickname'),
      'Everyday Visa',
    );
    await tester.tap(find.text('Create my card'));
    await tester.pumpAndSettle();

    expect(find.text('Welcome, An'), findsOneWidget);
    expect(find.byType(CalendarDatePicker), findsOneWidget);

    await tester.drag(find.byType(ListView).first, const Offset(0, -700));
    await tester.pumpAndSettle();
    expect(find.text('Everyday Visa'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Cards'), findsOneWidget);
    expect(find.text('Transactions'), findsOneWidget);
    expect(find.text('Add'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);

    await tester.tap(find.text('Cards'));
    await tester.pumpAndSettle();
    expect(find.text('Card management'), findsOneWidget);

    await tester.tap(find.text('Transactions'));
    await tester.pumpAndSettle();
    expect(find.text('No transactions yet'), findsOneWidget);

    await tester.tap(find.text('Add'));
    await tester.pumpAndSettle();
    expect(find.text('Scan a receipt'), findsOneWidget);
    expect(find.text('Add manually'), findsOneWidget);

    await tester.tap(find.text('Add manually'));
    await tester.pumpAndSettle();
    expect(
      find.text('Manual transaction entry is coming next.'),
      findsOneWidget,
    );

    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();
    expect(find.text('Guest · local-only'), findsOneWidget);
  });

  testWidgets('signed-in choice opens the authentication screen', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: AppTheme.light,
          onGenerateRoute: const AppRouter().onGenerateRoute,
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Sign in and sync'));
    await tester.pumpAndSettle();

    expect(find.text('Welcome back'), findsOneWidget);
    expect(find.text('Google'), findsOneWidget);
  });
}
