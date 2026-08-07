import 'dart:math' as math;

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

const _pagePadding = EdgeInsets.fromLTRB(
  ui.AppSpacing.lg,
  ui.AppSpacing.lg,
  ui.AppSpacing.lg,
  132,
);

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
      _DashboardPage(workspace: workspace),
      _CardManagementPage(cards: workspace.cards),
      const _TransactionManagementPage(),
      _ProfileManagementPage(workspace: workspace),
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

class _DashboardPage extends StatefulWidget {
  const _DashboardPage({required this.workspace});

  final LocalWorkspace workspace;

  @override
  State<_DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<_DashboardPage> {
  @override
  Widget build(BuildContext context) {
    final firstCard = widget.workspace.cards.first;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: _pagePadding,
          children: [
            Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      widget.workspace.profile.displayName.characters.first
                          .toUpperCase(),
                      style: const TextStyle(
                        color: ui.AppColors.ink,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: ui.AppSpacing.sm),
                Expanded(
                  child: Text(
                    'Hi, ${widget.workspace.profile.displayName}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: ui.AppColors.ink,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: ui.AppSpacing.xl),
            const Text(
              'Available Balance',
              style: TextStyle(color: ui.AppColors.muted, fontSize: 13),
            ),
            const SizedBox(height: ui.AppSpacing.xs),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    '₫0',
                    style: TextStyle(
                      color: ui.AppColors.ink,
                      fontSize: 38,
                      height: 1,
                      letterSpacing: -1.2,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                ui.CardPilotMascot(width: 104, height: 68),
              ],
            ),
            const SizedBox(height: ui.AppSpacing.sm),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.trending_up_rounded,
                      color: ui.AppColors.brandTeal,
                      size: 16,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Ready for your first transaction',
                      style: TextStyle(
                        color: ui.AppColors.brandTeal,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: ui.AppSpacing.lg),
            _PremiumCard(card: firstCard),
            const SizedBox(height: ui.AppSpacing.md),
            const _CashbackProgressCard(),
            const SizedBox(height: ui.AppSpacing.md),
            const _SpendingOverviewCard(),
          ],
        ),
      ),
    );
  }
}

class _PremiumCard extends StatelessWidget {
  const _PremiumCard({required this.card});

  final LocalUserCard card;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('premium-card'),
      height: 168,
      padding: const EdgeInsets.all(ui.AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF075DE7), Color(0xFF078CD7), Color(0xFF17C79E)],
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: ui.AppColors.brandBlue.withValues(alpha: 0.20),
            blurRadius: 26,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  card.nickname,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Icon(Icons.contactless_rounded, color: Colors.white),
              const SizedBox(width: ui.AppSpacing.sm),
              Container(
                width: 34,
                height: 22,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFC34D),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ],
          ),
          const SizedBox(height: ui.AppSpacing.sm),
          Text(
            card.bankName,
            style: TextStyle(color: Colors.white.withValues(alpha: 0.82)),
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: _CardMetric(
                  label: 'Billing cycle',
                  value: 'Day ${card.billingCycleDay}',
                ),
              ),
              const Expanded(
                child: _CardMetric(label: 'Monthly spend', value: '₫0'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CardMetric extends StatelessWidget {
  const _CardMetric({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.70),
            fontSize: 11,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _CashbackProgressCard extends StatelessWidget {
  const _CashbackProgressCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      key: const Key('cashback-progress-card'),
      child: Padding(
        padding: const EdgeInsets.all(ui.AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Cashback Progress',
                    style: TextStyle(
                      color: ui.AppColors.ink,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                _SmallPill(label: 'View all', onTap: () {}),
              ],
            ),
            const SizedBox(height: ui.AppSpacing.md),
            const Text(
              '₫0 earned',
              style: TextStyle(
                color: ui.AppColors.brandTeal,
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Start spending to track your monthly cashback.',
              style: TextStyle(color: ui.AppColors.muted, fontSize: 12),
            ),
            const SizedBox(height: ui.AppSpacing.md),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: const LinearProgressIndicator(
                value: 0,
                minHeight: 7,
                backgroundColor: ui.AppColors.softBlue,
                valueColor: AlwaysStoppedAnimation(ui.AppColors.brandTeal),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SpendingOverviewCard extends StatelessWidget {
  const _SpendingOverviewCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      key: const Key('spending-overview-card'),
      child: Padding(
        padding: const EdgeInsets.all(ui.AppSpacing.lg),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Spending Overview',
                    style: TextStyle(
                      color: ui.AppColors.ink,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                _SmallPill(label: 'This month', onTap: () {}),
              ],
            ),
            const SizedBox(height: ui.AppSpacing.lg),
            Row(
              children: [
                SizedBox(
                  width: 116,
                  height: 116,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CustomPaint(
                        size: const Size.square(116),
                        painter: const _SpendingRingPainter(),
                      ),
                      const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '₫0',
                            style: TextStyle(
                              color: ui.AppColors.ink,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            'Total spent',
                            style: TextStyle(
                              color: ui.AppColors.muted,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: ui.AppSpacing.lg),
                const Expanded(
                  child: Column(
                    children: [
                      _SpendingLegend(
                        color: ui.AppColors.brandBlue,
                        label: 'Shopping',
                      ),
                      _SpendingLegend(
                        color: ui.AppColors.brandTeal,
                        label: 'Food & Dining',
                      ),
                      _SpendingLegend(
                        color: Color(0xFF7B61FF),
                        label: 'Transport',
                      ),
                      _SpendingLegend(
                        color: Color(0xFFDCE8F7),
                        label: 'Others',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SmallPill extends StatelessWidget {
  const _SmallPill({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: ui.AppColors.appBackground,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: ui.AppColors.ink,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _SpendingLegend extends StatelessWidget {
  const _SpendingLegend({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 7),
          Expanded(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: ui.AppColors.muted, fontSize: 11),
            ),
          ),
          const Text(
            '₫0',
            style: TextStyle(
              color: ui.AppColors.ink,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _SpendingRingPainter extends CustomPainter {
  const _SpendingRingPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final stroke = size.width * 0.13;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..shader = const SweepGradient(
        colors: [
          ui.AppColors.brandBlue,
          Color(0xFF7B61FF),
          ui.AppColors.brandTeal,
          ui.AppColors.brandBlue,
        ],
      ).createShader(rect);
    canvas.drawArc(
      Rect.fromCircle(center: size.center(Offset.zero), radius: 46),
      -math.pi / 2,
      math.pi * 2,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _CardManagementPage extends StatelessWidget {
  const _CardManagementPage({required this.cards});

  final List<LocalUserCard> cards;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: _pagePadding,
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
        child: Padding(
          padding: _pagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Transactions',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                  OutlinedButton.icon(
                    key: const Key('transaction-filter-button'),
                    onPressed: () {},
                    icon: const Icon(Icons.tune_rounded),
                    label: const Text('Filter'),
                  ),
                ],
              ),
              Expanded(
                child: Center(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(ui.AppSpacing.xl),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 72,
                            height: 72,
                            decoration: const BoxDecoration(
                              color: ui.AppColors.softBlue,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.receipt_long_outlined,
                              color: ui.AppColors.brandBlue,
                              size: 34,
                            ),
                          ),
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
                            style: TextStyle(color: ui.AppColors.muted),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
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
          padding: _pagePadding,
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
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.person_outline),
                    title: const Text('Personal information'),
                    subtitle: const Text('Name and profile preferences'),
                    onTap: () {},
                  ),
                  const Divider(height: 1, indent: 56),
                  ListTile(
                    leading: const Icon(Icons.workspace_premium_outlined),
                    title: const Text('Membership'),
                    subtitle: const Text('Bronze'),
                    onTap: () {},
                  ),
                  const Divider(height: 1, indent: 56),
                  ListTile(
                    key: const Key('sync-now-button'),
                    leading: const Icon(Icons.sync_rounded),
                    title: const Text('Sync now'),
                    subtitle: const Text(
                      'Refresh common data and sync your changes',
                    ),
                    onTap: () => AppToast.showInfo(
                      context,
                      'Sync will be connected in the next phase.',
                    ),
                  ),
                  const Divider(height: 1, indent: 56),
                  ListTile(
                    leading: const Icon(Icons.settings_outlined),
                    title: const Text('App settings'),
                    subtitle: const Text(
                      'Appearance, notifications and privacy',
                    ),
                    onTap: () {},
                  ),
                  if (isGuest) ...[
                    const Divider(height: 1, indent: 56),
                    const ListTile(
                      leading: Icon(Icons.cloud_upload_outlined),
                      title: Text('Sign in and sync'),
                      subtitle: Text('Back up local data to your account'),
                    ),
                  ],
                ],
              ),
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

class _UserCardTile extends StatelessWidget {
  const _UserCardTile({required this.card});

  final LocalUserCard card;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(ui.AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF075DE7), Color(0xFF078CD7), Color(0xFF17C79E)],
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: ui.AppColors.brandBlue.withValues(alpha: 0.18),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
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
