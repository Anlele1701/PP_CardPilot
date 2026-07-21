import 'package:cardpilot_widgetbook/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('starts the CardPilot widget catalog', (tester) async {
    await tester.pumpWidget(const CardPilotWidgetbook());

    expect(tester.takeException(), isNull);
  });
}
