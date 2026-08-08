import 'package:cardpilot_ui/cardpilot_ui.dart' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/merchant_directory.dart';
import '../../merchant_providers.dart';
import 'merchant_details_screen.dart';

class MerchantsPage extends ConsumerStatefulWidget {
  const MerchantsPage({
    required this.profileId,
    this.embedded = false,
    super.key,
  });

  final String profileId;
  final bool embedded;

  @override
  ConsumerState<MerchantsPage> createState() => _MerchantsPageState();
}

class _MerchantsPageState extends ConsumerState<MerchantsPage> {
  String _query = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(merchantDirectoryControllerProvider.notifier)
          .ensureLoaded(widget.profileId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(merchantDirectoryControllerProvider);
    final normalized = _query.trim().toLowerCase();
    final merchants = state.merchants
        .where((merchant) {
          if (normalized.isEmpty) return true;
          return merchant.name.toLowerCase().contains(normalized) ||
              merchant.branches.any(
                (branch) =>
                    (branch.locationText ?? '').toLowerCase().contains(
                      normalized,
                    ) ||
                    branch.mccMappings.any(
                      (mapping) => mapping.mccCode.contains(normalized),
                    ),
              );
        })
        .toList(growable: false);

    final content = RefreshIndicator(
      onRefresh: () => ref
          .read(merchantDirectoryControllerProvider.notifier)
          .retry(widget.profileId),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
          ui.AppSpacing.lg,
          ui.AppSpacing.md,
          ui.AppSpacing.lg,
          132,
        ),
        children: [
          if (!widget.embedded) ...[
            Text('Merchants', style: Theme.of(context).textTheme.headlineLarge),
            const SizedBox(height: ui.AppSpacing.xs),
            Text(
              'Explore branches and MCCs by payment type.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: ui.AppSpacing.lg),
          ],
          TextField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search_rounded),
              hintText: 'Search merchant, location or MCC',
            ),
            onChanged: (value) => setState(() => _query = value),
          ),
          const SizedBox(height: ui.AppSpacing.lg),
          if (state.status == MerchantDirectoryStatus.loading &&
              state.merchants.isEmpty)
            const Center(child: CircularProgressIndicator())
          else if (state.status == MerchantDirectoryStatus.failure &&
              state.merchants.isEmpty)
            _FailureState(
              message: state.errorMessage ?? 'Could not load merchants.',
              onRetry: () => ref
                  .read(merchantDirectoryControllerProvider.notifier)
                  .retry(widget.profileId),
            )
          else if (merchants.isEmpty)
            const _EmptyState()
          else
            ...merchants.map(
              (merchant) => Padding(
                padding: const EdgeInsets.only(bottom: ui.AppSpacing.sm),
                child: _MerchantTile(
                  merchant: merchant,
                  onTap: () => Navigator.of(context).push<void>(
                    MaterialPageRoute(
                      builder: (_) => MerchantDetailsScreen(
                        profileId: widget.profileId,
                        merchantKey: merchant.key,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );

    if (widget.embedded) return content;
    return Scaffold(body: SafeArea(child: content));
  }
}

class _MerchantTile extends StatelessWidget {
  const _MerchantTile({required this.merchant, required this.onTap});

  final MerchantDirectoryEntry merchant;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final mappingCount = merchant.branches.fold<int>(
      0,
      (total, branch) => total + branch.mccMappings.length,
    );
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          child: Text(merchant.name.characters.first.toUpperCase()),
        ),
        title: Text(merchant.name),
        subtitle: Text(
          '${merchant.branches.length} branch${merchant.branches.length == 1 ? '' : 'es'} · '
          '$mappingCount MCC mapping${mappingCount == 1 ? '' : 's'}',
        ),
        trailing: const Icon(Icons.chevron_right_rounded),
      ),
    );
  }
}

class _FailureState extends StatelessWidget {
  const _FailureState({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(Icons.cloud_off_rounded, size: 48),
        const SizedBox(height: ui.AppSpacing.sm),
        Text(message, textAlign: TextAlign.center),
        TextButton(onPressed: onRetry, child: const Text('Try again')),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: ui.AppSpacing.xl),
      child: Column(
        children: [
          Icon(Icons.storefront_outlined, size: 48),
          SizedBox(height: ui.AppSpacing.sm),
          Text('No merchants are available yet.'),
        ],
      ),
    );
  }
}
