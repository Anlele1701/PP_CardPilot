import 'package:cardpilot_ui/cardpilot_ui.dart' as ui;
import 'package:flutter/material.dart';

import '../../../initial_setup/domain/entities/local_user_card.dart';
import '../../../initial_setup/domain/entities/local_workspace.dart';
import '../card_visual_style.dart';
import 'card_details_screen.dart';
import 'card_editor_screen.dart';

const _pagePadding = EdgeInsets.fromLTRB(
  ui.AppSpacing.lg,
  ui.AppSpacing.lg,
  ui.AppSpacing.lg,
  132,
);

class CardsPage extends StatelessWidget {
  const CardsPage({required this.workspace});

  final LocalWorkspace workspace;

  Future<void> _createCard(BuildContext context) {
    return Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (_) => CardEditorScreen(profileId: workspace.localId),
      ),
    );
  }

  Future<void> _openDetails(BuildContext context, LocalUserCard card) {
    return Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (_) => CardDetailsScreen(
          profileId: workspace.localId,
          card: card,
          cardCount: workspace.cards.length,
        ),
      ),
    );
  }

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
            for (final card in workspace.cards) ...[
              InkWell(
                key: Key('user-card-${card.id}'),
                onTap: () => _openDetails(context, card),
                borderRadius: BorderRadius.circular(22),
                child: _UserCardTile(card: card),
              ),
              const SizedBox(height: ui.AppSpacing.md),
            ],
            OutlinedButton.icon(
              key: const Key('add-card-button'),
              onPressed: () => _createCard(context),
              icon: const Icon(Icons.add),
              label: const Text('Add another card'),
            ),
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
        gradient: CardVisualStyle.gradientFor(card.id),
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
