import 'package:cardpilot_ui/cardpilot_ui.dart' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/notifications/app_toast.dart';
import '../../../initial_setup/domain/entities/local_user_card.dart';
import '../../domain/entities/local_transaction.dart';
import '../../transaction_providers.dart';
import '../transaction_formatters.dart';
import 'transaction_editor_screen.dart';

class TransactionDetailsScreen extends ConsumerWidget {
  const TransactionDetailsScreen({
    required this.profileId,
    required this.cards,
    required this.transaction,
    super.key,
  });

  final String profileId;
  final List<LocalUserCard> cards;
  final LocalTransaction transaction;

  Future<void> _edit(BuildContext context) async {
    final updated = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => TransactionEditorScreen(
          profileId: profileId,
          cards: cards,
          initialTransaction: transaction,
        ),
      ),
    );
    if (updated == true && context.mounted) {
      Navigator.pop(context);
    }
  }

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete transaction?'),
        content: Text(
          '${formatVnd(transaction.amountMinor)} at '
          '${transaction.merchantName} will be removed.',
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
        .read(transactionControllerProvider.notifier)
        .delete(profileId: profileId, transactionId: transaction.id);
    if (!context.mounted) {
      return;
    }
    if (!deleted) {
      AppToast.showError(
        context,
        ref.read(transactionControllerProvider).errorMessage ??
            'Could not delete the transaction.',
      );
      return;
    }

    AppToast.showSuccess(context, 'Transaction deleted.');
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(transactionControllerProvider);
    final isDeleting = state.status == TransactionMutationStatus.deleting;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction details'),
        actions: [
          IconButton(
            key: const Key('edit-transaction-button'),
            tooltip: 'Edit transaction',
            onPressed: isDeleting ? null : () => _edit(context),
            icon: const Icon(Icons.edit_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(ui.AppSpacing.lg),
          children: [
            Text(
              formatVnd(transaction.amountMinor),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: ui.AppColors.ink,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: ui.AppSpacing.sm),
            Text(
              transaction.merchantName,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: ui.AppSpacing.xl),
            Card(
              child: Column(
                children: [
                  _DetailTile(
                    icon: Icons.credit_card_outlined,
                    label: 'Card',
                    value: transaction.cardNickname,
                  ),
                  const Divider(height: 1, indent: 56),
                  _DetailTile(
                    icon: Icons.calendar_month_outlined,
                    label: 'Date and time',
                    value: formatTransactionDate(transaction.transactionAt),
                  ),
                  const Divider(height: 1, indent: 56),
                  _DetailTile(
                    icon: Icons.category_outlined,
                    label: 'Category',
                    value: transaction.category ?? 'Uncategorized',
                  ),
                  const Divider(height: 1, indent: 56),
                  _DetailTile(
                    icon: Icons.tag_rounded,
                    label: 'Merchant Category Code',
                    value: transaction.mccCode == null
                        ? 'Not assigned'
                        : 'MCC ${transaction.mccCode}',
                  ),
                  const Divider(height: 1, indent: 56),
                  _DetailTile(
                    icon: Icons.savings_outlined,
                    label: 'Estimated cashback',
                    value: formatVnd(transaction.cashbackEstimatedMinor ?? 0),
                  ),
                  if (transaction.cashbackRatePpm != null) ...[
                    const Divider(height: 1, indent: 56),
                    _DetailTile(
                      icon: Icons.percent_rounded,
                      label: 'Applied rate',
                      value: _formatRate(transaction.cashbackRatePpm!),
                    ),
                  ],
                  if (transaction.rewardRuleName != null) ...[
                    const Divider(height: 1, indent: 56),
                    _DetailTile(
                      icon: Icons.rule_outlined,
                      label: 'Reward rule',
                      value: transaction.rewardRuleName!,
                    ),
                  ],
                  if (transaction.cashbackExplanation != null) ...[
                    const Divider(height: 1, indent: 56),
                    _DetailTile(
                      icon: Icons.info_outline_rounded,
                      label: 'Calculation',
                      value: transaction.cashbackExplanation!,
                    ),
                  ],
                  if ((transaction.note ?? '').isNotEmpty) ...[
                    const Divider(height: 1, indent: 56),
                    _DetailTile(
                      icon: Icons.notes_outlined,
                      label: 'Note',
                      value: transaction.note!,
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: ui.AppSpacing.xl),
            OutlinedButton.icon(
              key: const Key('delete-transaction-button'),
              onPressed: isDeleting ? null : () => _delete(context, ref),
              icon: isDeleting
                  ? const SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.delete_outline),
              label: Text(isDeleting ? 'Deleting...' : 'Delete transaction'),
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

String _formatRate(int ratePpm) {
  final percent = ratePpm / 10000;
  final formatted = percent == percent.roundToDouble()
      ? percent.toStringAsFixed(0)
      : percent.toStringAsFixed(2);
  return '$formatted%';
}

class _DetailTile extends StatelessWidget {
  const _DetailTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      subtitle: Text(value),
    );
  }
}
