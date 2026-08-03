import 'package:cardpilot_ui/cardpilot_ui.dart' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/notifications/app_toast.dart';
import '../../../../core/presentation/views/error_screen.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../auth/auth_providers.dart';
import '../../../initial_setup/domain/entities/access_mode.dart';
import '../../../initial_setup/domain/entities/local_user_card.dart';
import '../../../initial_setup/domain/entities/local_workspace.dart';
import '../../../initial_setup/initial_setup_providers.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;
  bool _isNavigatingToError = false;

  void _selectDestination(int index) {
    if (index == 3) {
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
                  leading: const Icon(Icons.document_scanner_outlined),
                  title: const Text('Scan a receipt'),
                  subtitle: const Text('OCR flow will be connected next.'),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _showComingSoon('Receipt scanning');
                  },
                ),
                ListTile(
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
      _DashboardPage(workspace: workspace),
      _CardManagementPage(cards: workspace.cards),
      const _TransactionManagementPage(),
      _ProfileManagementPage(workspace: workspace),
    ];
    final pageIndex = _selectedIndex == 4 ? 3 : _selectedIndex;

    return Scaffold(
      body: IndexedStack(index: pageIndex, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _selectDestination,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.credit_card_outlined),
            selectedIcon: Icon(Icons.credit_card_rounded),
            label: 'Cards',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long_rounded),
            label: 'Transactions',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_circle_outline_rounded),
            selectedIcon: Icon(Icons.add_circle_rounded),
            label: 'Add',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class _DashboardPage extends StatefulWidget {
  const _DashboardPage({required this.workspace});

  final LocalWorkspace workspace;

  @override
  State<_DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<_DashboardPage> {
  DateTime _selectedDate = DateUtils.dateOnly(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final firstCard = widget.workspace.cards.first;
    final isGuest = widget.workspace.accessMode == AccessMode.guest;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(ui.AppSpacing.lg),
          children: [
            Text(
              'Welcome, ${widget.workspace.profile.displayName}',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: ui.AppSpacing.sm),
            Text(
              'Here is your spending dashboard.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: ui.AppSpacing.lg),
            _AccessModeBanner(isGuest: isGuest),
            const SizedBox(height: ui.AppSpacing.lg),
            const Row(
              children: [
                Expanded(
                  child: _SummaryTile(
                    label: 'Monthly spend',
                    value: '₫0',
                    icon: Icons.payments_outlined,
                  ),
                ),
                SizedBox(width: ui.AppSpacing.md),
                Expanded(
                  child: _SummaryTile(
                    label: 'Cashback',
                    value: '₫0',
                    icon: Icons.savings_outlined,
                  ),
                ),
              ],
            ),
            const SizedBox(height: ui.AppSpacing.xl),
            Text(
              'Spending calendar',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: ui.AppSpacing.sm),
            Card(
              clipBehavior: Clip.antiAlias,
              child: CalendarDatePicker(
                initialDate: _selectedDate,
                firstDate: DateTime(2020),
                lastDate: DateTime(2100),
                onDateChanged: (date) {
                  setState(() => _selectedDate = date);
                },
              ),
            ),
            const SizedBox(height: ui.AppSpacing.sm),
            Text(
              'No spending recorded on '
              '${_selectedDate.day}/${_selectedDate.month}/'
              '${_selectedDate.year}.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: ui.AppSpacing.xl),
            Text(
              'Your first card',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: ui.AppSpacing.md),
            _UserCardTile(card: firstCard),
          ],
        ),
      ),
    );
  }
}

class _CardManagementPage extends StatelessWidget {
  const _CardManagementPage({required this.cards});

  final List<LocalUserCard> cards;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(ui.AppSpacing.lg),
          children: [
            Text(
              'Your cards',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: ui.AppSpacing.sm),
            Text(
              'Manage cards used for transactions and cashback tracking.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: ui.AppSpacing.lg),
            for (final card in cards) ...[
              _UserCardTile(card: card),
              const SizedBox(height: ui.AppSpacing.md),
            ],
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('Add another card'),
            ),
          ],
        ),
      ),
    );
  }
}

class _TransactionManagementPage extends StatelessWidget {
  const _TransactionManagementPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(ui.AppSpacing.lg),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.receipt_long_outlined, size: 64),
                const SizedBox(height: ui.AppSpacing.md),
                Text(
                  'No transactions yet',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: ui.AppSpacing.sm),
                const Text(
                  'Use the Add action to scan a receipt or enter a '
                  'transaction manually.',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileManagementPage extends ConsumerWidget {
  const _ProfileManagementPage({required this.workspace});

  final LocalWorkspace workspace;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isGuest = workspace.accessMode == AccessMode.guest;
    final signOutState = ref.watch(signOutControllerProvider);
    final isSigningOut = signOutState.status == SignOutStatus.loading;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(ui.AppSpacing.lg),
          children: [
            CircleAvatar(
              radius: 40,
              child: Text(
                workspace.profile.displayName.characters.first.toUpperCase(),
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            const SizedBox(height: ui.AppSpacing.md),
            Text(
              workspace.profile.displayName,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: ui.AppSpacing.xs),
            Text(
              isGuest ? 'Guest · local-only' : 'Signed in',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: ui.AppSpacing.xl),
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text('Personal information'),
              subtitle: const Text('Name and profile preferences'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.workspace_premium_outlined),
              title: const Text('Membership'),
              subtitle: const Text('Bronze'),
              onTap: () {},
            ),
            if (isGuest)
              const ListTile(
                leading: Icon(Icons.cloud_upload_outlined),
                title: Text('Sign in and sync'),
                subtitle: Text('Back up local data to your account'),
              ),
            if (!isGuest) ...[
              const SizedBox(height: ui.AppSpacing.lg),
              OutlinedButton.icon(
                onPressed: isSigningOut
                    ? null
                    : () => _confirmAndSignOut(context, ref),
                icon: isSigningOut
                    ? const SizedBox.square(
                        dimension: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.logout_rounded),
                label: Text(isSigningOut ? 'Signing out...' : 'Log out'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _confirmAndSignOut(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Log out?'),
          content: const Text(
            'You will need to sign in again to access your synced data.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Log out'),
            ),
          ],
        );
      },
    );

    if (confirmed != true || !context.mounted) {
      return;
    }

    final signedOut = await ref
        .read(signOutControllerProvider.notifier)
        .signOut();

    if (!context.mounted) {
      return;
    }

    if (!signedOut) {
      AppToast.showError(
        context,
        ref.read(signOutControllerProvider).errorMessage ??
            'Unable to sign out right now. Please try again.',
      );
      return;
    }

    Navigator.of(
      context,
    ).pushNamedAndRemoveUntil(AppRoutes.signIn, (route) => false);
  }
}

class _AccessModeBanner extends StatelessWidget {
  const _AccessModeBanner({required this.isGuest});

  final bool isGuest;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(ui.AppSpacing.md),
      decoration: BoxDecoration(
        color: ui.AppColors.skyTop,
        borderRadius: BorderRadius.circular(ui.AppSpacing.md),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            isGuest ? Icons.phone_iphone_rounded : Icons.cloud_done_outlined,
            color: ui.AppColors.brandBlue,
          ),
          const SizedBox(width: ui.AppSpacing.sm),
          Expanded(
            child: Text(
              isGuest
                  ? 'Local mode · Your data stays on this device. Sign in '
                        'later to back it up and sync.'
                  : 'Signed-in mode · Cloud sync will be connected to the '
                        'CardPilot backend next.',
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryTile extends StatelessWidget {
  const _SummaryTile({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(ui.AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: ui.AppSpacing.md),
            Text(value, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: ui.AppSpacing.xs),
            Text(label, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}

class _UserCardTile extends StatelessWidget {
  const _UserCardTile({required this.card});

  final LocalUserCard card;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(ui.AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [ui.AppColors.brandBlue, Color(0xFF1356C8)],
        ),
        borderRadius: BorderRadius.circular(ui.AppSpacing.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                card.bankName,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              const Icon(Icons.credit_card, color: Colors.white),
            ],
          ),
          const SizedBox(height: ui.AppSpacing.xl),
          Text(
            card.nickname,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: ui.AppSpacing.xs),
          Text(
            'Billing day ${card.billingCycleDay}',
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
