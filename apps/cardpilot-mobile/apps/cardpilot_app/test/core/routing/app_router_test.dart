import 'package:cardpilot_app/core/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows the error screen for an unknown route', (tester) async {
    final navigatorKey = GlobalKey<NavigatorState>();

    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: navigatorKey,
        onGenerateRoute: const AppRouter().onGenerateRoute,
        home: const SizedBox.shrink(),
      ),
    );

    navigatorKey.currentState!.pushNamed('/missing');
    await tester.pumpAndSettle();

    expect(find.text('No Route was found'), findsOneWidget);
    expect(find.text('Sorry, no route was found!'), findsOneWidget);
    expect(find.text('Back to sign in'), findsOneWidget);
  });
}
