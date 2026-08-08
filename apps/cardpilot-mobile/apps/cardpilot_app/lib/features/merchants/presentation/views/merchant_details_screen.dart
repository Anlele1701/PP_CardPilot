import 'package:cardpilot_ui/cardpilot_ui.dart' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/notifications/app_toast.dart';
import '../../../cashback_reference/domain/cashback_reference.dart';
import '../../domain/merchant_directory.dart';
import '../../merchant_providers.dart';

class MerchantDetailsScreen extends ConsumerWidget {
  const MerchantDetailsScreen({
    required this.profileId,
    required this.merchantKey,
    super.key,
  });

  final String profileId;
  final String merchantKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(merchantDirectoryControllerProvider);
    final matches = state.merchants.where((item) => item.key == merchantKey);
    if (matches.isEmpty) {
      return const Scaffold(body: Center(child: Text('Merchant not found.')));
    }
    final merchant = matches.first;
    return Scaffold(
      appBar: AppBar(title: Text(merchant.name)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          ui.AppSpacing.lg,
          ui.AppSpacing.md,
          ui.AppSpacing.lg,
          ui.AppSpacing.xl,
        ),
        children: [
          Text(
            'Branches and payment MCCs',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: ui.AppSpacing.xs),
          Text(
            'MCC may differ when you pay directly or through a delivery platform.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: ui.AppSpacing.lg),
          ...merchant.branches.map(
            (branch) => Padding(
              padding: const EdgeInsets.only(bottom: ui.AppSpacing.md),
              child: _BranchCard(
                branch: branch,
                onContribute: () =>
                    _showContributionSheet(context, ref, branch, state.mccs),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showContributionSheet(
    BuildContext context,
    WidgetRef ref,
    MerchantBranch branch,
    List<MerchantCategoryCode> mccs,
  ) async {
    final saved = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) =>
          _ContributionSheet(profileId: profileId, branch: branch, mccs: mccs),
    );
    if (saved == true && context.mounted) {
      AppToast.showSuccess(context, 'MCC contribution saved on this device.');
    }
  }
}

class _BranchCard extends StatelessWidget {
  const _BranchCard({required this.branch, required this.onContribute});

  final MerchantBranch branch;
  final VoidCallback onContribute;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(ui.AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Icon(Icons.location_on_outlined),
                const SizedBox(width: ui.AppSpacing.xs),
                Expanded(
                  child: Text(
                    branch.locationText?.trim().isNotEmpty == true
                        ? branch.locationText!
                        : 'Location not specified',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: ui.AppSpacing.sm),
            if (branch.mccMappings.isEmpty)
              const Text('No MCC has been recorded for this branch.')
            else
              ...branch.mccMappings.map(
                (mapping) => _MappingTile(mapping: mapping),
              ),
            const SizedBox(height: ui.AppSpacing.sm),
            OutlinedButton.icon(
              onPressed: onContribute,
              icon: const Icon(Icons.add_rounded),
              label: const Text('Contribute an MCC'),
            ),
          ],
        ),
      ),
    );
  }
}

class _MappingTile extends StatelessWidget {
  const _MappingTile({required this.mapping});

  final MerchantMccMapping mapping;

  @override
  Widget build(BuildContext context) {
    final description = mapping.mccDescription?.trim();
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.payments_outlined),
      title: Text('${mapping.paymentType.label} · MCC ${mapping.mccCode}'),
      subtitle: Text(
        [
          if (description?.isNotEmpty == true) description!,
          mapping.isLocalContribution
              ? 'Local contribution'
              : mapping.status == 'verified'
              ? 'Verified'
              : 'Suggested',
        ].join(' · '),
      ),
      trailing: mapping.isLocalContribution
          ? const Icon(Icons.phone_iphone_rounded, size: 20)
          : null,
    );
  }
}

class _ContributionSheet extends ConsumerStatefulWidget {
  const _ContributionSheet({
    required this.profileId,
    required this.branch,
    required this.mccs,
  });

  final String profileId;
  final MerchantBranch branch;
  final List<MerchantCategoryCode> mccs;

  @override
  ConsumerState<_ContributionSheet> createState() => _ContributionSheetState();
}

class _ContributionSheetState extends ConsumerState<_ContributionSheet> {
  final _noteController = TextEditingController();
  final _mccController = TextEditingController();
  MerchantCategoryCode? _selectedMcc;
  MerchantPaymentType _paymentType = MerchantPaymentType.inStore;
  bool _saving = false;

  @override
  void dispose() {
    _noteController.dispose();
    _mccController.dispose();
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
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Contribute an MCC',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: ui.AppSpacing.xs),
            Text(widget.branch.locationText ?? widget.branch.name),
            const SizedBox(height: ui.AppSpacing.lg),
            DropdownButtonFormField<MerchantPaymentType>(
              initialValue: _paymentType,
              decoration: const InputDecoration(labelText: 'Payment type'),
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
            TextField(
              controller: _mccController,
              keyboardType: TextInputType.number,
              maxLength: 4,
              decoration: InputDecoration(
                labelText: 'Merchant category code',
                hintText: 'For example, 5814',
                helperText: _selectedMcc?.description,
                suffixIcon: IconButton(
                  tooltip: 'Search MCC catalog',
                  onPressed: _saving ? null : _pickMcc,
                  icon: const Icon(Icons.search_rounded),
                ),
              ),
              onChanged: (value) {
                if (_selectedMcc?.code != value.trim()) {
                  setState(() => _selectedMcc = null);
                } else {
                  setState(() {});
                }
              },
            ),
            const SizedBox(height: ui.AppSpacing.md),
            TextField(
              controller: _noteController,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'Note (optional)',
                hintText: 'How did you verify this MCC?',
              ),
            ),
            const SizedBox(height: ui.AppSpacing.lg),
            FilledButton(
              onPressed: !_hasValidMcc || _saving ? null : _save,
              child: Text(_saving ? 'Saving...' : 'Save locally'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickMcc() async {
    final selected = await showModalBottomSheet<MerchantCategoryCode>(
      context: context,
      isScrollControlled: true,
      builder: (context) => _MccPicker(mccs: widget.mccs),
    );
    if (selected != null && mounted) {
      setState(() {
        _selectedMcc = selected;
        _mccController.text = selected.code;
      });
    }
  }

  Future<void> _save() async {
    final mccCode = _mccController.text.trim();
    if (!RegExp(r'^\d{4}$').hasMatch(mccCode)) return;
    setState(() => _saving = true);
    try {
      await ref
          .read(merchantDirectoryControllerProvider.notifier)
          .addContribution(
            MerchantContributionDraft(
              profileId: widget.profileId,
              branch: widget.branch,
              mccCode: mccCode,
              mccDescription: _selectedMcc?.description,
              paymentType: _paymentType,
              note: _noteController.text,
            ),
          );
      if (mounted) Navigator.pop(context, true);
    } on Object {
      if (mounted) {
        setState(() => _saving = false);
        AppToast.showError(context, 'Could not save the local contribution.');
      }
    }
  }

  bool get _hasValidMcc =>
      RegExp(r'^\d{4}$').hasMatch(_mccController.text.trim());
}

class _MccPicker extends StatefulWidget {
  const _MccPicker({required this.mccs});

  final List<MerchantCategoryCode> mccs;

  @override
  State<_MccPicker> createState() => _MccPickerState();
}

class _MccPickerState extends State<_MccPicker> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final query = _query.trim().toLowerCase();
    final filtered = widget.mccs.where(
      (mcc) =>
          mcc.code.contains(query) ||
          mcc.description.toLowerCase().contains(query),
    );
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(ui.AppSpacing.md),
        child: Column(
          children: [
            TextField(
              autofocus: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search_rounded),
                hintText: 'Search code or description',
              ),
              onChanged: (value) => setState(() => _query = value),
            ),
            const SizedBox(height: ui.AppSpacing.sm),
            Expanded(
              child: ListView(
                children: filtered
                    .map(
                      (mcc) => ListTile(
                        title: Text(mcc.code),
                        subtitle: Text(mcc.description),
                        onTap: () => Navigator.pop(context, mcc),
                      ),
                    )
                    .toList(growable: false),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
