import 'package:cardpilot_ui/cardpilot_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders the primary button', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: Scaffold(
          body: AppPrimaryButton(label: 'Continue', onPressed: () {}),
        ),
      ),
    );

    expect(find.text('Continue'), findsOneWidget);
  });
}
