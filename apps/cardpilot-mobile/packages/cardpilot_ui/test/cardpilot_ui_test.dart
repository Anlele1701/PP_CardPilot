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

  testWidgets('floating navigation reports tabs and its primary action', (
    tester,
  ) async {
    final selections = <int>[];

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: Scaffold(
          bottomNavigationBar: AppFloatingNavigationBar(
            selectedIndex: 0,
            onSelected: selections.add,
            items: const [
              AppNavigationItem(icon: Icons.home_outlined, label: 'Home'),
              AppNavigationItem(
                icon: Icons.credit_card_outlined,
                label: 'Cards',
              ),
              AppNavigationItem(
                icon: Icons.add_rounded,
                label: 'Add',
                isPrimaryAction: true,
              ),
              AppNavigationItem(
                icon: Icons.receipt_long_outlined,
                label: 'Transactions',
              ),
              AppNavigationItem(icon: Icons.person_outline, label: 'Profile'),
            ],
          ),
        ),
      ),
    );

    expect(find.byKey(const Key('navigation-item-0')), findsOneWidget);
    expect(find.byKey(const Key('navigation-item-3')), findsOneWidget);

    await tester.tap(find.byKey(const Key('navigation-item-1')));
    await tester.tap(find.byKey(const Key('primary-navigation-item')));

    expect(selections, [1, 2]);
  });
}
