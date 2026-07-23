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

@widgetbook.UseCase(
  name: 'Page 1',
  type: ui.OnboardingPagination,
  path: '[Components]',
)
Widget onboardingPaginationPageOne(BuildContext context) {
  return const Center(
    child: ui.OnboardingPagination(currentPage: 0, pageCount: 3),
  );
}

@widgetbook.UseCase(
  name: 'Page 2',
  type: ui.OnboardingPagination,
  path: '[Components]',
)
Widget onboardingPaginationPageTwo(BuildContext context) {
  return const Center(
    child: ui.OnboardingPagination(currentPage: 1, pageCount: 3),
  );
}

@widgetbook.UseCase(
  name: 'Page 3',
  type: ui.OnboardingPagination,
  path: '[Components]',
)
Widget onboardingPaginationPageThree(BuildContext context) {
  return const Center(
    child: ui.OnboardingPagination(currentPage: 2, pageCount: 3),
  );
}

@widgetbook.UseCase(
  name: 'Pilot',
  type: ui.OnboardingHeroIllustration,
  path: '[Components]',
)
Widget pilotOnboardingIllustration(BuildContext context) {
  return _illustrationCanvas(ui.OnboardingIllustration.pilot);
}

@widgetbook.UseCase(
  name: 'Cashback',
  type: ui.OnboardingHeroIllustration,
  path: '[Components]',
)
Widget cashbackOnboardingIllustration(BuildContext context) {
  return _illustrationCanvas(ui.OnboardingIllustration.cashback);
}

@widgetbook.UseCase(
  name: 'Insights',
  type: ui.OnboardingHeroIllustration,
  path: '[Components]',
)
Widget insightsOnboardingIllustration(BuildContext context) {
  return _illustrationCanvas(ui.OnboardingIllustration.insights);
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

Widget _illustrationCanvas(ui.OnboardingIllustration illustration) {
  return Center(
    child: SizedBox(
      width: 390,
      height: 360,
      child: ui.OnboardingHeroIllustration(illustration: illustration),
    ),
  );
}
