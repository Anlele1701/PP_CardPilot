import 'package:cardpilot_ui/cardpilot_ui.dart' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/notifications/app_toast.dart';
import '../../../../core/presentation/views/error_screen.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../cards/presentation/views/cards_page.dart';
import '../../../initial_setup/initial_setup_providers.dart';
import 'home_page.dart';
import 'profile_page.dart';
import 'transactions_page.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  static const _navigationItems = [
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

  int _selectedIndex = 0;
  bool _isNavigatingToError = false;

  void _selectDestination(int index) {
    if (index == 2) {
      _showQuickAdd();
      return;
    }

    setState(() => _selectedIndex = index);
  }

  void _showQuickAdd() {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: ui.AppSpacing.md),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Add a transaction',
                  style: Theme.of(sheetContext).textTheme.titleLarge,
                ),
                const SizedBox(height: ui.AppSpacing.sm),
                ListTile(
                  key: const Key('scan-receipt-action'),
                  leading: const Icon(Icons.document_scanner_outlined),
                  title: const Text('Scan a receipt'),
                  subtitle: const Text('OCR flow will be connected next.'),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _showComingSoon('Receipt scanning');
                  },
                ),
                ListTile(
                  key: const Key('add-manually-action'),
                  leading: const Icon(Icons.edit_note_rounded),
                  title: const Text('Add manually'),
                  subtitle: const Text('Enter amount, merchant and card.'),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _showComingSoon('Manual transaction entry');
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showComingSoon(String feature) {
    AppToast.showInfo(context, '$feature is coming next.');
  }

  @override
  Widget build(BuildContext context) {
    final workspace = ref.watch(initialSetupControllerProvider).workspace;

    if (workspace == null) {
      if (!_isNavigatingToError) {
        _isNavigatingToError = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) {
            return;
          }

          Navigator.of(context).pushReplacementNamed(
            AppRoutes.error,
            arguments: const ErrorScreenArguments(
              title: 'We couldn\'t load your workspace',
              description:
                  'Your workspace is missing or unavailable. Return to '
                  'sign in and set up CardPilot again.',
              actionLabel: 'Back to sign in',
              actionRoute: AppRoutes.signIn,
            ),
          );
        });
      }

      return const SizedBox.shrink();
    }

    final pages = [
      HomePage(workspace: workspace),
      CardsPage(workspace: workspace),
      const TransactionsPage(),
      ProfilePage(workspace: workspace),
    ];
    final pageIndex = switch (_selectedIndex) {
      0 => 0,
      1 => 1,
      3 => 2,
      4 => 3,
      _ => 0,
    };

    return Scaffold(
      extendBody: true,
      body: IndexedStack(index: pageIndex, children: pages),
      bottomNavigationBar: ui.AppFloatingNavigationBar(
        key: const Key('home-navigation-bar'),
        items: _navigationItems,
        selectedIndex: _selectedIndex,
        onSelected: _selectDestination,
      ),
    );
  }
}
