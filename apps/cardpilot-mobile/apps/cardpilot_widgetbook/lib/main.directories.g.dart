// dart format width=80
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cardpilot_widgetbook/use_cases/component_use_cases.dart'
    as _cardpilot_widgetbook_use_cases_component_use_cases;
import 'package:widgetbook/widgetbook.dart' as _widgetbook;

final directories = <_widgetbook.WidgetbookNode>[
  _widgetbook.WidgetbookCategory(
    name: 'Components',
    children: [
      _widgetbook.WidgetbookComponent(
        name: 'AppPrimaryButton',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Disabled',
            builder: _cardpilot_widgetbook_use_cases_component_use_cases
                .disabledPrimaryButton,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Enabled',
            builder: _cardpilot_widgetbook_use_cases_component_use_cases
                .enabledPrimaryButton,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Loading',
            builder: _cardpilot_widgetbook_use_cases_component_use_cases
                .loadingPrimaryButton,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'SocialAuthButton',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Enabled',
            builder: _cardpilot_widgetbook_use_cases_component_use_cases
                .enabledSocialAuthButton,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Loading',
            builder: _cardpilot_widgetbook_use_cases_component_use_cases
                .loadingSocialAuthButton,
          ),
        ],
      ),
    ],
  ),
];
