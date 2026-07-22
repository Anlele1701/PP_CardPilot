import 'package:cardpilot_ui/cardpilot_ui.dart' as ui;
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'main.directories.g.dart';

void main() {
  runApp(const CardPilotWidgetbook());
}

@widgetbook.App()
class CardPilotWidgetbook extends StatelessWidget {
  const CardPilotWidgetbook({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      addons: [
        ViewportAddon([
          IosViewports.iPhone13,
          IosViewports.iPhoneSE,
          AndroidViewports.samsungGalaxyS20,
          AndroidViewports.smallTablet,
        ]),
        MaterialThemeAddon(
          themes: [
            WidgetbookTheme(name: 'Light', data: ui.AppTheme.light),
            WidgetbookTheme(name: 'Dark', data: ui.AppTheme.dark),
          ],
        ),
      ],
      directories: directories,
    );
  }
}
