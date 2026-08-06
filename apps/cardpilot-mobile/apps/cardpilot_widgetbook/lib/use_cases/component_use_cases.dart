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
  name: 'Home selected',
  type: ui.AppFloatingNavigationBar,
  path: '[Components]',
)
Widget homeSelectedNavigationBar(BuildContext context) {
  return const _NavigationBarPreview(initialIndex: 0);
}

@widgetbook.UseCase(
  name: 'Transactions selected',
  type: ui.AppFloatingNavigationBar,
  path: '[Components]',
)
Widget transactionsSelectedNavigationBar(BuildContext context) {
  return const _NavigationBarPreview(initialIndex: 3);
}

class _NavigationBarPreview extends StatefulWidget {
  const _NavigationBarPreview({required this.initialIndex});

  final int initialIndex;

  @override
  State<_NavigationBarPreview> createState() => _NavigationBarPreviewState();
}

class _NavigationBarPreviewState extends State<_NavigationBarPreview> {
  late int _selectedIndex = widget.initialIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [ui.AppColors.skyTop, Colors.white],
          ),
        ),
        child: Center(
          child: Text(
            'Selected: ${_items[_selectedIndex].label}',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
      ),
      bottomNavigationBar: ui.AppFloatingNavigationBar(
        items: _items,
        selectedIndex: _selectedIndex,
        onSelected: (index) {
          if (index != 2) {
            setState(() => _selectedIndex = index);
          }
        },
      ),
    );
  }
}

const _items = [
  ui.AppNavigationItem(
    icon: Icons.home_outlined,
    selectedIcon: Icons.home_rounded,
    label: 'Home',
  ),
  ui.AppNavigationItem(
    icon: Icons.credit_card_outlined,
    selectedIcon: Icons.credit_card_rounded,
    label: 'Cards',
  ),
  ui.AppNavigationItem(
    icon: Icons.add_rounded,
    label: 'Add',
    isPrimaryAction: true,
  ),
  ui.AppNavigationItem(
    icon: Icons.receipt_long_outlined,
    selectedIcon: Icons.receipt_long_rounded,
    label: 'Transactions',
  ),
  ui.AppNavigationItem(
    icon: Icons.person_outline_rounded,
    selectedIcon: Icons.person_rounded,
    label: 'Profile',
  ),
];

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
