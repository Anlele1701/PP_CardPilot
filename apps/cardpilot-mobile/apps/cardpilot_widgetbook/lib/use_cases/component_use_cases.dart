import 'package:cardpilot_ui/cardpilot_ui.dart' as ui;
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Enabled',
  type: ui.AppPrimaryButton,
  path: '[Components]',
)
Widget enabledPrimaryButton(BuildContext context) {
  return _componentCanvas(
    ui.AppPrimaryButton(label: 'Get started', onPressed: () {}),
  );
}

@widgetbook.UseCase(
  name: 'Disabled',
  type: ui.AppPrimaryButton,
  path: '[Components]',
)
Widget disabledPrimaryButton(BuildContext context) {
  return _componentCanvas(
    const ui.AppPrimaryButton(label: 'Get started', onPressed: null),
  );
}

@widgetbook.UseCase(
  name: 'Loading',
  type: ui.AppPrimaryButton,
  path: '[Components]',
)
Widget loadingPrimaryButton(BuildContext context) {
  return _componentCanvas(
    ui.AppPrimaryButton(
      label: 'Get started',
      isLoading: true,
      onPressed: () {},
    ),
  );
}

@widgetbook.UseCase(
  name: 'Enabled',
  type: ui.SocialAuthButton,
  path: '[Components]',
)
Widget enabledSocialAuthButton(BuildContext context) {
  return _componentCanvas(
    ui.SocialAuthButton(
      label: 'Continue with Google',
      leading: const Icon(Icons.account_circle_outlined),
      onPressed: () {},
    ),
  );
}

@widgetbook.UseCase(
  name: 'Loading',
  type: ui.SocialAuthButton,
  path: '[Components]',
)
Widget loadingSocialAuthButton(BuildContext context) {
  return _componentCanvas(
    ui.SocialAuthButton(
      label: 'Continue with Google',
      leading: const Icon(Icons.account_circle_outlined),
      isLoading: true,
      onPressed: () {},
    ),
  );
}

Widget _componentCanvas(Widget child) {
  return Scaffold(
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 320),
          child: child,
        ),
      ),
    ),
  );
}
