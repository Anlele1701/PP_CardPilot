import 'package:cardpilot_app/core/notifications/app_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows a reusable toastification message', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return FilledButton(
                onPressed: () => AppToast.showSuccess(
                  context,
                  'Profile saved successfully.',
                ),
                child: const Text('Show toast'),
              );
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Show toast'));
    await tester.pumpAndSettle();

    expect(find.text('Profile saved successfully.'), findsOneWidget);

    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();
  });
}
