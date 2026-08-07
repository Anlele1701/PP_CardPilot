import 'dart:math' as math;

import 'package:cardpilot_ui/cardpilot_ui.dart' as ui;
import 'package:flutter/material.dart';

import '../../../initial_setup/domain/entities/local_user_card.dart';
import '../../../initial_setup/domain/entities/local_workspace.dart';

const _pagePadding = EdgeInsets.fromLTRB(
  ui.AppSpacing.lg,
  ui.AppSpacing.lg,
  ui.AppSpacing.lg,
  132,
);

class HomePage extends StatefulWidget {
  const HomePage({required this.workspace});

  final LocalWorkspace workspace;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
