import 'package:cardpilot_ui/cardpilot_ui.dart' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/notifications/app_toast.dart';
import '../../../initial_setup/domain/entities/local_workspace.dart';
import '../../../merchants/presentation/views/merchants_page.dart';
import '../../domain/entities/local_transaction.dart';
import '../../transaction_providers.dart';
import '../transaction_formatters.dart';
import 'transaction_details_screen.dart';
import 'transaction_editor_screen.dart';

class TransactionsPage extends ConsumerStatefulWidget {
  const TransactionsPage({required this.workspace, super.key});

  final LocalWorkspace workspace;

  @override
  ConsumerState<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends ConsumerState<TransactionsPage> {
  static const _transactionsSection = 0;
  static const _merchantsSection = 1;

  int _selectedSection = _transactionsSection;

  Future<void> _create(BuildContext context) {
    return Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (_) => TransactionEditorScreen(
          profileId: widget.workspace.localId,
          cards: widget.workspace.cards,
        ),
      ),
    );
  }

  Future<void> _openDetails(
    BuildContext context,
    LocalTransaction transaction,
  ) {
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
    final transactions = ref.watch(
      transactionsProvider(widget.workspace.localId),
    );
    final showingTransactions = _selectedSection == _transactionsSection;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                ui.AppSpacing.lg,
                ui.AppSpacing.lg,
                ui.AppSpacing.lg,
                0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          showingTransactions ? 'Transactions' : 'Merchants',
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ),
                      if (showingTransactions)
                        OutlinedButton.icon(
                          key: const Key('transaction-filter-button'),
                          onPressed: () => AppToast.showInfo(
                            context,
                            'Transaction filters are coming next.',
                          ),
                          icon: const Icon(Icons.tune_rounded),
                          label: const Text('Filter'),
                        ),
                    ],
                  ),
                  const SizedBox(height: ui.AppSpacing.md),
                  SegmentedButton<int>(
                    key: const Key('transaction-section-picker'),
                    segments: const [
                      ButtonSegment(
                        value: _transactionsSection,
                        icon: Icon(Icons.receipt_long_outlined),
                        label: Text('Transactions'),
                      ),
                      ButtonSegment(
                        value: _merchantsSection,
                        icon: Icon(Icons.storefront_outlined),
                        label: Text('Merchants'),
                      ),
                    ],
                    selected: {_selectedSection},
                    showSelectedIcon: false,
                    onSelectionChanged: (selection) {
                      setState(() => _selectedSection = selection.single);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: ui.AppSpacing.sm),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                switchInCurve: Curves.easeOutCubic,
                switchOutCurve: Curves.easeInCubic,
                child: showingTransactions
                    ? Padding(
                        key: const ValueKey('transactions-section'),
                        padding: const EdgeInsets.fromLTRB(
                          ui.AppSpacing.lg,
                          ui.AppSpacing.sm,
                          ui.AppSpacing.lg,
                          132,
                        ),
                        child: transactions.when(
                          loading: () =>
                              const Center(child: CircularProgressIndicator()),
                          error: (_, _) => const Center(
                            child: Text('Could not load transactions.'),
                          ),
                          data: (items) => items.isEmpty
                              ? _EmptyTransactions(
                                  onAdd: () => _create(context),
                                )
                              : ListView.separated(
                                  itemCount: items.length,
                                  separatorBuilder: (_, _) =>
                                      const SizedBox(height: ui.AppSpacing.sm),
                                  itemBuilder: (context, index) {
                                    final transaction = items[index];
                                    return Card(
                                      child: ListTile(
                                        key: Key(
                                          'transaction-${transaction.id}',
                                        ),
                                        onTap: () =>
                                            _openDetails(context, transaction),
                                        leading: Container(
                                          width: 44,
                                          height: 44,
                                          decoration: const BoxDecoration(
                                            color: ui.AppColors.softBlue,
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.receipt_long_outlined,
                                            color: ui.AppColors.brandBlue,
                                          ),
                                        ),
                                        title: Text(transaction.merchantName),
                                        subtitle: Text(
                                          '${transaction.cardNickname} · '
                                          '${formatTransactionDate(transaction.transactionAt)}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        trailing: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              formatVnd(
                                                transaction.amountMinor,
                                              ),
                                              style: const TextStyle(
                                                color: ui.AppColors.ink,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                            Text(
                                              '+${formatVnd(transaction.cashbackEstimatedMinor ?? 0)}',
                                              style: const TextStyle(
                                                color: ui.AppColors.brandTeal,
                                                fontSize: 11,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                        ),
                      )
                    : MerchantsPage(
                        key: const ValueKey('merchants-section'),
                        profileId: widget.workspace.localId,
                        embedded: true,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyTransactions extends StatelessWidget {
  const _EmptyTransactions({required this.onAdd});

  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Center(
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
                'Use the Add action to scan a receipt or enter a transaction '
                'manually.',
                textAlign: TextAlign.center,
                style: TextStyle(color: ui.AppColors.muted),
              ),
              const SizedBox(height: ui.AppSpacing.lg),
              FilledButton.icon(
                key: const Key('empty-add-transaction-button'),
                onPressed: onAdd,
                icon: const Icon(Icons.add_rounded),
                label: const Text('Add manually'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
