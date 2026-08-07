import 'package:cardpilot_ui/cardpilot_ui.dart' as ui;
import 'package:flutter/material.dart';

const _pagePadding = EdgeInsets.fromLTRB(
  ui.AppSpacing.lg,
  ui.AppSpacing.lg,
  ui.AppSpacing.lg,
  132,
);

class TransactionsPage extends StatelessWidget {
  const TransactionsPage();

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
