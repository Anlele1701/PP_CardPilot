import 'package:cardpilot_ui/cardpilot_ui.dart' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/validation_messages.dart';
import '../../../../core/notifications/app_toast.dart';
import '../../../cashback_reference/domain/cashback_reference.dart';
import '../../domain/merchant_directory.dart';
import '../../merchant_providers.dart';
import 'merchant_details_screen.dart';

class MerchantsPage extends ConsumerStatefulWidget {
  const MerchantsPage({
    required this.profileId,
    this.embedded = false,
    this.selectionMode = false,
    super.key,
  });

  final String profileId;
  final bool embedded;
  final bool selectionMode;

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
          if (widget.selectionMode) ...[
            const SizedBox(height: ui.AppSpacing.sm),
            FilledButton.tonalIcon(
              key: const Key('create-new-merchant-button'),
              onPressed: _createMerchant,
              icon: const Icon(Icons.add_business_outlined),
              label: const Text('Create new merchant'),
            ),
          ],
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
                  onTap: () => _openMerchant(merchant),
                ),
              ),
            ),
        ],
      ),
    );

    if (widget.embedded) return content;
    return Scaffold(body: SafeArea(child: content));
  }

  Future<void> _openMerchant(MerchantDirectoryEntry merchant) async {
    final selection = await Navigator.of(context).push<MerchantSelection>(
      MaterialPageRoute(
        builder: (_) => MerchantDetailsScreen(
          profileId: widget.profileId,
          merchantKey: merchant.key,
          selectionMode: widget.selectionMode,
        ),
      ),
    );
    if (selection != null && mounted && widget.selectionMode) {
      Navigator.pop(context, selection);
    }
  }

  Future<void> _createMerchant() async {
    final draft = await showModalBottomSheet<LocalMerchantDraft>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (_) => _CreateMerchantSheet(
        profileId: widget.profileId,
        mccs: ref.read(merchantDirectoryControllerProvider).mccs,
      ),
    );
    if (draft == null || !mounted) return;
    try {
      final selection = await ref
          .read(merchantDirectoryControllerProvider.notifier)
          .createLocalMerchant(draft);
      if (mounted) Navigator.pop(context, selection);
    } on Object {
      if (mounted) {
        AppToast.showError(context, 'Could not save the local merchant.');
      }
    }
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

class _CreateMerchantSheet extends StatefulWidget {
  const _CreateMerchantSheet({required this.profileId, required this.mccs});

  final String profileId;
  final List<MerchantCategoryCode> mccs;

  @override
  State<_CreateMerchantSheet> createState() => _CreateMerchantSheetState();
}

class _CreateMerchantSheetState extends State<_CreateMerchantSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _mccController = TextEditingController();
  final _noteController = TextEditingController();
  MerchantPaymentType _paymentType = MerchantPaymentType.inStore;

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _mccController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        ui.AppSpacing.lg,
        0,
        ui.AppSpacing.lg,
        MediaQuery.viewInsetsOf(context).bottom + ui.AppSpacing.lg,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Create new merchant',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: ui.AppSpacing.xs),
            Text(
              'Add its payment MCC so this merchant can be reused in future transactions.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: ui.AppSpacing.lg),
            TextFormField(
              controller: _nameController,
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Merchant name',
                hintText: 'e.g. Local coffee shop',
                border: OutlineInputBorder(),
              ),
              validator: (value) => (value?.trim().isEmpty ?? true)
                  ? ValidationMessages.merchantRequired
                  : null,
            ),
            const SizedBox(height: ui.AppSpacing.md),
            TextFormField(
              controller: _locationController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Location (optional)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: ui.AppSpacing.md),
            DropdownButtonFormField<MerchantPaymentType>(
              initialValue: _paymentType,
              decoration: const InputDecoration(
                labelText: 'Payment type',
                border: OutlineInputBorder(),
              ),
              items: MerchantPaymentType.values
                  .where((item) => item != MerchantPaymentType.unknown)
                  .map(
                    (item) =>
                        DropdownMenuItem(value: item, child: Text(item.label)),
                  )
                  .toList(growable: false),
              onChanged: (value) {
                if (value != null) setState(() => _paymentType = value);
              },
            ),
            const SizedBox(height: ui.AppSpacing.md),
            TextFormField(
              controller: _mccController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLength: 4,
              decoration: InputDecoration(
                labelText: 'Merchant Category Code (MCC)',
                hintText: 'e.g. 5814',
                helperText: _selectedMccDescription,
                border: const OutlineInputBorder(),
              ),
              onChanged: (_) => setState(() {}),
              validator: (value) => RegExp(r'^\d{4}$').hasMatch(value ?? '')
                  ? null
                  : ValidationMessages.mccInvalid,
            ),
            const SizedBox(height: ui.AppSpacing.md),
            TextFormField(
              controller: _noteController,
              minLines: 2,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'MCC note (optional)',
                hintText: 'How did you identify this MCC?',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: ui.AppSpacing.lg),
            FilledButton(
              onPressed: _submit,
              child: const Text('Create and use merchant'),
            ),
          ],
        ),
      ),
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final location = _locationController.text.trim();
    final mccDescription = _selectedMccDescription;
    Navigator.pop(
      context,
      LocalMerchantDraft(
        profileId: widget.profileId,
        name: _nameController.text.trim(),
        locationText: location.isEmpty ? null : location,
        mccCode: _mccController.text,
        mccDescription: mccDescription,
        paymentType: _paymentType,
        note: _noteController.text,
      ),
    );
  }

  String? get _selectedMccDescription {
    final code = _mccController.text.trim();
    for (final mcc in widget.mccs) {
      if (mcc.code == code) return mcc.description;
    }
    return null;
  }
}
