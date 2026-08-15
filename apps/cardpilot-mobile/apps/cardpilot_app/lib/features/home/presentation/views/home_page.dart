import 'dart:math' as math;

import 'package:cardpilot_ui/cardpilot_ui.dart' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../cards/presentation/card_visual_style.dart';
import '../../../cards/presentation/views/card_details_screen.dart';
import '../../../initial_setup/domain/entities/local_user_card.dart';
import '../../../initial_setup/domain/entities/local_workspace.dart';
import '../../../transactions/domain/entities/local_transaction.dart';
import '../../../transactions/presentation/transaction_formatters.dart';
import '../../../transactions/presentation/views/transaction_details_screen.dart';
import '../../../transactions/transaction_providers.dart';

const _pagePadding = EdgeInsets.fromLTRB(
  ui.AppSpacing.lg,
  ui.AppSpacing.lg,
  ui.AppSpacing.lg,
  132,
);

class HomePage extends ConsumerStatefulWidget {
  const HomePage({required this.workspace, super.key});

  final LocalWorkspace workspace;

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  String? _selectedCardId;

  LocalUserCard get _selectedCard {
    return widget.workspace.cards.firstWhere(
      (card) => card.id == _selectedCardId,
      orElse: () => widget.workspace.cards.first,
    );
  }

  Future<void> _handleCardTap(LocalUserCard card) async {
    if (card.id != _selectedCard.id) {
      setState(() => _selectedCardId = card.id);
      return;
    }

    await Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (_) => CardDetailsScreen(
          profileId: widget.workspace.localId,
          card: card,
          cardCount: widget.workspace.cards.length,
        ),
      ),
    );
  }

  Future<void> _openTransaction(LocalTransaction transaction) {
    return Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (_) => TransactionDetailsScreen(
          profileId: widget.workspace.localId,
          cards: widget.workspace.cards,
          transaction: transaction,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final transactionState = ref.watch(
      transactionsProvider(widget.workspace.localId),
    );
    final transactions = transactionState.value ?? const <LocalTransaction>[];
    final summaries = widget.workspace.cards
        .map((card) => _CreditUsage.forCard(card, transactions))
        .toList(growable: false);
    final currentTransactions = _transactionsInCurrentCycles(
      widget.workspace.cards,
      transactions,
    );
    final selectedUsage = summaries.firstWhere(
      (summary) => summary.cardId == _selectedCard.id,
    );
    final totalLimit = widget.workspace.cards.fold<int>(
      0,
      (total, card) => total + card.creditLimitMinor,
    );
    final availableLimit = summaries.fold<int>(
      0,
      (total, summary) => total + summary.availableMinor,
    );
    final totalSpent = summaries.fold<int>(
      0,
      (total, summary) => total + summary.spentMinor,
    );
    final totalCashback = summaries.fold<int>(
      0,
      (total, summary) => total + summary.cashbackMinor,
    );
    final utilization = totalLimit <= 0
        ? 0.0
        : (totalSpent / totalLimit).clamp(0.0, 1.0);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: _pagePadding,
          children: [
            _HomeHeader(displayName: widget.workspace.profile.displayName),
            const SizedBox(height: ui.AppSpacing.xl),
            const Text(
              'Estimated Remaining Limit',
              style: TextStyle(color: ui.AppColors.muted, fontSize: 13),
            ),
            const SizedBox(height: ui.AppSpacing.xs),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    formatVnd(availableLimit),
                    style: const TextStyle(
                      color: ui.AppColors.ink,
                      fontSize: 38,
                      height: 1,
                      letterSpacing: -1.2,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const ui.CardPilotMascot(width: 104, height: 68),
              ],
            ),
            const SizedBox(height: ui.AppSpacing.sm),
            _UsageStatus(
              isLoading: transactionState.isLoading,
              hasMissingLimit: widget.workspace.cards.any(
                (card) => card.creditLimitMinor <= 0,
              ),
              totalSpent: totalSpent,
              utilization: utilization,
            ),
            const SizedBox(height: ui.AppSpacing.lg),
            _SectionHeader(
              title: 'Your cards',
              trailing: widget.workspace.cards.length == 1
                  ? '1 card'
                  : '${widget.workspace.cards.length} cards',
            ),
            const SizedBox(height: ui.AppSpacing.sm),
            Text(
              'Tap a card to bring it forward. Tap the active card again to view details.',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: ui.AppColors.muted),
            ),
            const SizedBox(height: ui.AppSpacing.md),
            _CardStack(
              cards: widget.workspace.cards,
              selectedCard: _selectedCard,
              selectedUsage: selectedUsage,
              onCardTap: _handleCardTap,
            ),
            const SizedBox(height: ui.AppSpacing.lg),
            _InsightsGrid(
              spentMinor: totalSpent,
              cashbackMinor: totalCashback,
              transactionCount: currentTransactions.length,
              utilization: utilization,
            ),
            const SizedBox(height: ui.AppSpacing.md),
            _CashbackByCardChart(
              cards: widget.workspace.cards,
              summaries: summaries,
              totalCashbackMinor: totalCashback,
            ),
            const SizedBox(height: ui.AppSpacing.md),
            _CreditUtilizationChart(
              cards: widget.workspace.cards,
              summaries: summaries,
            ),
            const SizedBox(height: ui.AppSpacing.md),
            _SpendingOverviewCard(transactions: currentTransactions),
            const SizedBox(height: ui.AppSpacing.md),
            _RecentActivityCard(
              transactions: transactions,
              onTransactionTap: _openTransaction,
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader({required this.displayName});

  final String displayName;

  @override
  Widget build(BuildContext context) {
    return Row(
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
              displayName.characters.first.toUpperCase(),
              style: const TextStyle(
                color: ui.AppColors.ink,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        const SizedBox(width: ui.AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi, $displayName',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: ui.AppColors.ink,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Text(
                'Here is your current spending picture.',
                style: TextStyle(color: ui.AppColors.muted, fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _UsageStatus extends StatelessWidget {
  const _UsageStatus({
    required this.isLoading,
    required this.hasMissingLimit,
    required this.totalSpent,
    required this.utilization,
  });

  final bool isLoading;
  final bool hasMissingLimit;
  final int totalSpent;
  final double utilization;

  @override
  Widget build(BuildContext context) {
    final message = hasMissingLimit
        ? 'Add limits to every card for a complete overview'
        : isLoading
        ? 'Calculating current billing cycles'
        : '${formatVnd(totalSpent)} used · ${(utilization * 100).round()}% of total limit';
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.insights_rounded,
              color: ui.AppColors.brandTeal,
              size: 16,
            ),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                message,
                style: const TextStyle(
                  color: ui.AppColors.brandTeal,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.trailing});

  final String title;
  final String trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: ui.AppColors.ink,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Text(
          trailing,
          style: const TextStyle(
            color: ui.AppColors.brandBlue,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _CardStack extends StatelessWidget {
  const _CardStack({
    required this.cards,
    required this.selectedCard,
    required this.selectedUsage,
    required this.onCardTap,
  });

  final List<LocalUserCard> cards;
  final LocalUserCard selectedCard;
  final _CreditUsage selectedUsage;
  final ValueChanged<LocalUserCard> onCardTap;

  @override
  Widget build(BuildContext context) {
    const cardHeight = 184.0;
    const exposedHeight = 52.0;
    final orderedCards = [
      ...cards.where((card) => card.id != selectedCard.id),
      selectedCard,
    ];
    final stackHeight = cardHeight + exposedHeight * (cards.length - 1);

    return SizedBox(
      height: stackHeight,
      child: Stack(
        children: [
          for (var index = 0; index < orderedCards.length; index++)
            AnimatedPositioned(
              key: ValueKey('home-card-position-${orderedCards[index].id}'),
              duration: const Duration(milliseconds: 360),
              curve: Curves.easeOutCubic,
              top: exposedHeight * index,
              left: 0,
              right: 0,
              height: cardHeight,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => onCardTap(orderedCards[index]),
                child: _StackedCard(
                  card: orderedCards[index],
                  usage: orderedCards[index].id == selectedCard.id
                      ? selectedUsage
                      : null,
                  isSelected: orderedCards[index].id == selectedCard.id,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _StackedCard extends StatelessWidget {
  const _StackedCard({
    required this.card,
    required this.usage,
    required this.isSelected,
  });

  final LocalUserCard card;
  final _CreditUsage? usage;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final currentUsage = usage;
    return Container(
      key: isSelected
          ? const Key('premium-card')
          : Key('stacked-card-${card.id}'),
      padding: const EdgeInsets.all(ui.AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: CardVisualStyle.gradientFor(card.id),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white.withValues(alpha: 0.28)),
        boxShadow: [
          BoxShadow(
            color: ui.AppColors.brandBlue.withValues(alpha: 0.18),
            blurRadius: 24,
            offset: const Offset(0, 10),
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
                  '${card.nickname} · ${card.bankName}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const Icon(Icons.contactless_rounded, color: Colors.white),
            ],
          ),
          if (isSelected && currentUsage != null) ...[
            const Spacer(),
            Text(
              'Current cycle · ${_formatShortDate(currentUsage.periodStart)} – '
              '${_formatShortDate(currentUsage.periodEnd.subtract(const Duration(days: 1)))}',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.72),
                fontSize: 11,
              ),
            ),
            const SizedBox(height: ui.AppSpacing.sm),
            Row(
              children: [
                Expanded(
                  child: _CardMetric(
                    label: 'Available',
                    value: formatVnd(currentUsage.availableMinor),
                  ),
                ),
                Expanded(
                  child: _CardMetric(
                    label: 'Used this cycle',
                    value: formatVnd(currentUsage.spentMinor),
                  ),
                ),
              ],
            ),
          ],
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
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
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

class _InsightsGrid extends StatelessWidget {
  const _InsightsGrid({
    required this.spentMinor,
    required this.cashbackMinor,
    required this.transactionCount,
    required this.utilization,
  });

  final int spentMinor;
  final int cashbackMinor;
  final int transactionCount;
  final double utilization;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: ui.AppSpacing.sm,
      mainAxisSpacing: ui.AppSpacing.sm,
      childAspectRatio: 1.55,
      children: [
        _InsightTile(
          icon: Icons.payments_outlined,
          label: 'Cycle spending',
          value: formatVnd(spentMinor),
          color: ui.AppColors.brandBlue,
        ),
        _InsightTile(
          key: const Key('cashback-progress-card'),
          icon: Icons.savings_outlined,
          label: 'Est. cashback',
          value: formatVnd(cashbackMinor),
          color: ui.AppColors.brandTeal,
        ),
        _InsightTile(
          icon: Icons.receipt_long_outlined,
          label: 'Transactions',
          value: '$transactionCount',
          color: const Color(0xFF7B61FF),
        ),
        _InsightTile(
          icon: Icons.donut_large_rounded,
          label: 'Limit used',
          value: '${(utilization * 100).round()}%',
          color: const Color(0xFFFF7A59),
        ),
      ],
    );
  }
}

class _InsightTile extends StatelessWidget {
  const _InsightTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    super.key,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(ui.AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: color, size: 22),
            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: ui.AppColors.ink,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: ui.AppColors.muted, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}

class _CashbackByCardChart extends StatelessWidget {
  const _CashbackByCardChart({
    required this.cards,
    required this.summaries,
    required this.totalCashbackMinor,
  });

  final List<LocalUserCard> cards;
  final List<_CreditUsage> summaries;
  final int totalCashbackMinor;

  @override
  Widget build(BuildContext context) {
    final cashbackByCard = [
      for (final card in cards)
        (
          card: card,
          amount: summaries
              .firstWhere((summary) => summary.cardId == card.id)
              .cashbackMinor,
        ),
    ];
    final highestCashback = cashbackByCard.fold<int>(
      0,
      (highest, item) => math.max(highest, item.amount),
    );

    return Card(
      key: const Key('cashback-by-card-chart'),
      child: Padding(
        padding: const EdgeInsets.all(ui.AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: ui.AppColors.brandTeal.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.savings_outlined,
                    color: ui.AppColors.brandTeal,
                  ),
                ),
                const SizedBox(width: ui.AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Cashback by card',
                        style: TextStyle(
                          color: ui.AppColors.ink,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${formatVnd(totalCashbackMinor)} estimated this cycle',
                        style: const TextStyle(
                          color: ui.AppColors.brandTeal,
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: ui.AppSpacing.lg),
            for (final item in cashbackByCard) ...[
              _CashbackBar(
                card: item.card,
                amountMinor: item.amount,
                fraction: highestCashback == 0
                    ? 0.0
                    : item.amount / highestCashback,
              ),
              if (item != cashbackByCard.last)
                const SizedBox(height: ui.AppSpacing.md),
            ],
            if (totalCashbackMinor == 0) ...[
              const SizedBox(height: ui.AppSpacing.md),
              const Text(
                'Cashback will appear after a transaction has a confirmed MCC and matching reward rule.',
                style: TextStyle(color: ui.AppColors.muted, fontSize: 11),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _CashbackBar extends StatelessWidget {
  const _CashbackBar({
    required this.card,
    required this.amountMinor,
    required this.fraction,
  });

  final LocalUserCard card;
  final int amountMinor;
  final double fraction;

  @override
  Widget build(BuildContext context) {
    final color = CardVisualStyle.gradientFor(card.id).colors.first;
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 7),
            Expanded(
              child: Text(
                '${card.nickname} · ${card.bankName}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: ui.AppColors.ink,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              formatVnd(amountMinor),
              style: const TextStyle(
                color: ui.AppColors.ink,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 7),
        _AnimatedProgressBar(value: fraction, color: color),
      ],
    );
  }
}

class _CreditUtilizationChart extends StatelessWidget {
  const _CreditUtilizationChart({required this.cards, required this.summaries});

  final List<LocalUserCard> cards;
  final List<_CreditUsage> summaries;

  @override
  Widget build(BuildContext context) {
    return Card(
      key: const Key('credit-utilization-chart'),
      child: Padding(
        padding: const EdgeInsets.all(ui.AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Credit limit usage',
              style: TextStyle(
                color: ui.AppColors.ink,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Amount used compared with each card limit',
              style: TextStyle(color: ui.AppColors.muted, fontSize: 12),
            ),
            const SizedBox(height: ui.AppSpacing.lg),
            for (final card in cards) ...[
              _CreditUtilizationRow(
                card: card,
                usage: summaries.firstWhere(
                  (summary) => summary.cardId == card.id,
                ),
              ),
              if (card != cards.last) const SizedBox(height: ui.AppSpacing.lg),
            ],
          ],
        ),
      ),
    );
  }
}

class _CreditUtilizationRow extends StatelessWidget {
  const _CreditUtilizationRow({required this.card, required this.usage});

  final LocalUserCard card;
  final _CreditUsage usage;

  @override
  Widget build(BuildContext context) {
    final hasLimit = card.creditLimitMinor > 0;
    final rawUtilization = hasLimit
        ? usage.spentMinor / card.creditLimitMinor
        : 0.0;
    final progress = rawUtilization.clamp(0.0, 1.0);
    final isHighUsage = rawUtilization >= 0.8;
    final isOverLimit = rawUtilization > 1;
    final color = isOverLimit
        ? Theme.of(context).colorScheme.error
        : isHighUsage
        ? const Color(0xFFFF8A3D)
        : CardVisualStyle.gradientFor(card.id).colors.first;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                '${card.nickname} · ${card.bankName}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: ui.AppColors.ink,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Text(
              hasLimit ? '${(rawUtilization * 100).round()}%' : 'No limit',
              style: TextStyle(
                color: hasLimit ? color : ui.AppColors.muted,
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          hasLimit
              ? '${formatVnd(usage.spentMinor)} used of ${formatVnd(card.creditLimitMinor)}'
              : '${formatVnd(usage.spentMinor)} used · Add a credit limit',
          style: const TextStyle(color: ui.AppColors.muted, fontSize: 11),
        ),
        const SizedBox(height: 8),
        _AnimatedProgressBar(value: progress, color: color, height: 9),
        if (isHighUsage && hasLimit) ...[
          const SizedBox(height: 6),
          Text(
            isOverLimit
                ? 'Spending is above the configured credit limit.'
                : 'You have used at least 80% of this card limit.',
            style: TextStyle(color: color, fontSize: 10),
          ),
        ],
      ],
    );
  }
}

class _AnimatedProgressBar extends StatelessWidget {
  const _AnimatedProgressBar({
    required this.value,
    required this.color,
    this.height = 7,
  });

  final double value;
  final Color color;
  final double height;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: value),
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeOutCubic,
      builder: (context, animatedValue, _) => ClipRRect(
        borderRadius: BorderRadius.circular(height),
        child: LinearProgressIndicator(
          value: animatedValue,
          minHeight: height,
          backgroundColor: ui.AppColors.appBackground,
          valueColor: AlwaysStoppedAnimation(color),
        ),
      ),
    );
  }
}

class _SpendingOverviewCard extends StatelessWidget {
  const _SpendingOverviewCard({required this.transactions});

  final List<LocalTransaction> transactions;

  @override
  Widget build(BuildContext context) {
    final categories = _categoryTotals(transactions);
    final total = categories.fold<int>(0, (sum, item) => sum + item.amount);

    return Card(
      key: const Key('spending-overview-card'),
      child: Padding(
        padding: const EdgeInsets.all(ui.AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Spending Overview',
              style: TextStyle(
                color: ui.AppColors.ink,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Across the current billing cycle of each card',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: ui.AppColors.muted),
            ),
            const SizedBox(height: ui.AppSpacing.lg),
            if (categories.isEmpty)
              const _EmptyInsight(
                icon: Icons.pie_chart_outline_rounded,
                message: 'Add a transaction to see where your money goes.',
              )
            else
              for (final item in categories) ...[
                _CategoryBar(
                  category: item,
                  fraction: total == 0 ? 0 : item.amount / total,
                ),
                if (item != categories.last)
                  const SizedBox(height: ui.AppSpacing.md),
              ],
          ],
        ),
      ),
    );
  }
}

class _CategoryBar extends StatelessWidget {
  const _CategoryBar({required this.category, required this.fraction});

  final _CategorySpend category;
  final double fraction;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                category.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: ui.AppColors.ink,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              formatVnd(category.amount),
              style: const TextStyle(
                color: ui.AppColors.ink,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 7),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: fraction,
            minHeight: 7,
            backgroundColor: ui.AppColors.appBackground,
            valueColor: AlwaysStoppedAnimation(category.color),
          ),
        ),
      ],
    );
  }
}

class _RecentActivityCard extends StatelessWidget {
  const _RecentActivityCard({
    required this.transactions,
    required this.onTransactionTap,
  });

  final List<LocalTransaction> transactions;
  final ValueChanged<LocalTransaction> onTransactionTap;

  @override
  Widget build(BuildContext context) {
    final recent = [...transactions]
      ..sort((a, b) => b.transactionAt.compareTo(a.transactionAt));
    final visible = recent.take(3).toList(growable: false);

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: ui.AppSpacing.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(
                ui.AppSpacing.lg,
                ui.AppSpacing.sm,
                ui.AppSpacing.lg,
                ui.AppSpacing.sm,
              ),
              child: Text(
                'Recent activity',
                style: TextStyle(
                  color: ui.AppColors.ink,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            if (visible.isEmpty)
              const Padding(
                padding: EdgeInsets.all(ui.AppSpacing.lg),
                child: _EmptyInsight(
                  icon: Icons.receipt_long_outlined,
                  message: 'Your latest transactions will appear here.',
                ),
              )
            else
              for (final transaction in visible)
                ListTile(
                  onTap: () => onTransactionTap(transaction),
                  leading: Container(
                    width: 42,
                    height: 42,
                    decoration: const BoxDecoration(
                      color: ui.AppColors.appBackground,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.storefront_outlined,
                      color: ui.AppColors.brandBlue,
                    ),
                  ),
                  title: Text(
                    transaction.merchantName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    '${transaction.cardNickname} · ${_formatShortDate(transaction.transactionAt)}',
                  ),
                  trailing: Text(
                    '-${formatVnd(transaction.amountMinor)}',
                    style: const TextStyle(
                      color: ui.AppColors.ink,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}

class _EmptyInsight extends StatelessWidget {
  const _EmptyInsight({required this.icon, required this.message});

  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: ui.AppColors.muted),
        const SizedBox(width: ui.AppSpacing.sm),
        Expanded(
          child: Text(
            message,
            style: const TextStyle(color: ui.AppColors.muted, fontSize: 12),
          ),
        ),
      ],
    );
  }
}

class _CreditUsage {
  const _CreditUsage({
    required this.cardId,
    required this.spentMinor,
    required this.availableMinor,
    required this.cashbackMinor,
    required this.periodStart,
    required this.periodEnd,
  });

  factory _CreditUsage.forCard(
    LocalUserCard card,
    List<LocalTransaction> transactions,
  ) {
    final cycle = _billingCycle(DateTime.now(), card.billingCycleDay);
    final cycleTransactions = transactions.where(
      (transaction) =>
          transaction.userCardId == card.id &&
          !transaction.transactionAt.isBefore(cycle.$1) &&
          transaction.transactionAt.isBefore(cycle.$2),
    );
    final spent = cycleTransactions.fold<int>(
      0,
      (total, transaction) => total + transaction.amountMinor,
    );
    final cashback = cycleTransactions.fold<int>(
      0,
      (total, transaction) => total + (transaction.cashbackEstimatedMinor ?? 0),
    );

    return _CreditUsage(
      cardId: card.id,
      spentMinor: spent,
      availableMinor: math.max(0, card.creditLimitMinor - spent),
      cashbackMinor: cashback,
      periodStart: cycle.$1,
      periodEnd: cycle.$2,
    );
  }

  final String cardId;
  final int spentMinor;
  final int availableMinor;
  final int cashbackMinor;
  final DateTime periodStart;
  final DateTime periodEnd;
}

class _CategorySpend {
  const _CategorySpend({
    required this.name,
    required this.amount,
    required this.color,
  });

  final String name;
  final int amount;
  final Color color;
}

List<LocalTransaction> _transactionsInCurrentCycles(
  List<LocalUserCard> cards,
  List<LocalTransaction> transactions,
) {
  final cardsById = {for (final card in cards) card.id: card};
  final now = DateTime.now();
  return transactions
      .where((transaction) {
        final card = cardsById[transaction.userCardId];
        if (card == null) return false;
        final cycle = _billingCycle(now, card.billingCycleDay);
        return !transaction.transactionAt.isBefore(cycle.$1) &&
            transaction.transactionAt.isBefore(cycle.$2);
      })
      .toList(growable: false);
}

List<_CategorySpend> _categoryTotals(List<LocalTransaction> transactions) {
  const colors = [
    ui.AppColors.brandBlue,
    ui.AppColors.brandTeal,
    Color(0xFF7B61FF),
    Color(0xFFFF7A59),
  ];
  final totals = <String, int>{};
  for (final transaction in transactions) {
    final rawCategory = transaction.category?.trim();
    final category = rawCategory == null || rawCategory.isEmpty
        ? 'Other'
        : rawCategory;
    totals.update(
      category,
      (amount) => amount + transaction.amountMinor,
      ifAbsent: () => transaction.amountMinor,
    );
  }
  final sorted = totals.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));
  return [
    for (var index = 0; index < math.min(4, sorted.length); index++)
      _CategorySpend(
        name: sorted[index].key,
        amount: sorted[index].value,
        color: colors[index],
      ),
  ];
}

(DateTime, DateTime) _billingCycle(DateTime now, int billingDay) {
  final currentBoundary = _clampedDate(now.year, now.month, billingDay);
  if (!now.isBefore(currentBoundary)) {
    return (currentBoundary, _clampedDate(now.year, now.month + 1, billingDay));
  }
  return (_clampedDate(now.year, now.month - 1, billingDay), currentBoundary);
}

DateTime _clampedDate(int year, int month, int day) {
  final normalizedMonth = DateTime(year, month);
  final lastDay = DateTime(
    normalizedMonth.year,
    normalizedMonth.month + 1,
    0,
  ).day;
  return DateTime(
    normalizedMonth.year,
    normalizedMonth.month,
    math.min(day, lastDay),
  );
}

String _formatShortDate(DateTime date) {
  return '${date.day.toString().padLeft(2, '0')}/'
      '${date.month.toString().padLeft(2, '0')}';
}
