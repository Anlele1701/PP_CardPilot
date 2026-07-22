import 'package:cardpilot_app/app/cardpilot_app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders onboarding entry screen', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: CardPilotApp()));
    await tester.pumpAndSettle();

    expect(find.text('CardPilot'), findsWidgets);
    expect(
      find.text('Smart cashback tracking for smarter spending'),
      findsOneWidget,
    );
    expect(find.text('Get started'), findsNothing);
  });
}
