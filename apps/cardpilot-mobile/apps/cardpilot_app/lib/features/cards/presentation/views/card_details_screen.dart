import 'package:cardpilot_ui/cardpilot_ui.dart' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/notifications/app_toast.dart';
import '../../../credit_cards/credit_card_providers.dart';
import '../../../credit_cards/domain/entities/credit_card.dart';
import '../../../initial_setup/domain/entities/local_user_card.dart';
import '../../cards_providers.dart';
import '../card_visual_style.dart';
import 'card_editor_screen.dart';

class CardDetailsScreen extends ConsumerWidget {
  const CardDetailsScreen({
    required this.profileId,
    required this.card,
    required this.cardCount,
    super.key,
  });

  final String profileId;
  final LocalUserCard card;
  final int cardCount;

  Future<void> _edit(BuildContext context) async {
    final updated = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) =>
            CardEditorScreen(profileId: profileId, initialCard: card),
      ),
    );
    if (updated == true && context.mounted) {
      Navigator.pop(context);
    }
  }

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    if (cardCount <= 1) {
      AppToast.showInfo(context, 'Keep at least one card in your workspace.');
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete this card?'),
        content: Text(
          '“${card.nickname}” will be removed from this device. '
          'This change can be synced later.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) {
      return;
    }

    final deleted = await ref
        .read(userCardControllerProvider.notifier)
        .delete(profileId: profileId, cardId: card.id);
    if (!context.mounted) {
      return;
    }
    if (!deleted) {
      AppToast.showError(
        context,
        ref.read(userCardControllerProvider).errorMessage ??
            'Could not delete the card.',
      );
      return;
    }

    AppToast.showSuccess(context, 'Card deleted.');
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mutationState = ref.watch(userCardControllerProvider);
    final isDeleting = mutationState.status == UserCardMutationStatus.deleting;
    final bankId = card.bankId;
    final cachedCreditCards = bankId == null
        ? const <CreditCard>[]
        : ref
              .watch(creditCardsProvider(bankId))
              .when(
                data: (cards) => cards,
                error: (_, _) => const [],
                loading: () => const [],
              );
    final creditCard = cachedCreditCards
        .where((item) => item.id == card.creditCardId)
        .firstOrNull;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Card details'),
        actions: [
          IconButton(
            key: const Key('edit-card-button'),
            tooltip: 'Edit card',
            onPressed: isDeleting ? null : () => _edit(context),
            icon: const Icon(Icons.edit_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(ui.AppSpacing.lg),
          children: [
            Container(
              height: 190,
              padding: const EdgeInsets.all(ui.AppSpacing.lg),
              decoration: BoxDecoration(
                gradient: CardVisualStyle.gradientFor(card.id),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          card.bankName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.contactless_rounded,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    card.nickname,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: ui.AppSpacing.xs),
                  Text(
                    'Billing day ${card.billingCycleDay}',
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            const SizedBox(height: ui.AppSpacing.xl),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.account_balance_outlined),
                    title: const Text('Bank'),
                    subtitle: Text(card.bankName),
                  ),
                  const Divider(height: 1, indent: 56),
                  ListTile(
                    leading: const Icon(Icons.credit_card_outlined),
                    title: const Text('Card product'),
                    subtitle: Text(
                      creditCard?.displayName ??
                          card.creditCardId ??
                          'Not selected',
                    ),
                  ),
                  const Divider(height: 1, indent: 56),
                  ListTile(
                    leading: const Icon(Icons.badge_outlined),
                    title: const Text('Nickname'),
                    subtitle: Text(card.nickname),
                  ),
                  const Divider(height: 1, indent: 56),
                  ListTile(
                    leading: const Icon(Icons.calendar_month_outlined),
                    title: const Text('Billing cycle day'),
                    subtitle: Text('${card.billingCycleDay}'),
                  ),
                  const Divider(height: 1, indent: 56),
                  ListTile(
                    leading: const Icon(Icons.account_balance_wallet_outlined),
                    title: const Text('Credit limit'),
                    subtitle: Text(_formatVnd(card.creditLimitMinor)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: ui.AppSpacing.xl),
            OutlinedButton.icon(
              key: const Key('delete-card-button'),
              onPressed: isDeleting ? null : () => _delete(context, ref),
              icon: isDeleting
                  ? const SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.delete_outline),
              label: Text(isDeleting ? 'Deleting...' : 'Delete card'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.error,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _formatVnd(int amount) {
  final digits = amount.abs().toString();
  final grouped = digits.replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (_) => '.',
  );
  return '${amount < 0 ? '-' : ''}₫$grouped';
}
