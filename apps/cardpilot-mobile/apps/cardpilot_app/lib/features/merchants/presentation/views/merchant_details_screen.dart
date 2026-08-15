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
    this.selectionMode = false,
    super.key,
  });

  final String profileId;
  final String merchantKey;
  final bool selectionMode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(merchantDirectoryControllerProvider);
    final matches = state.merchants.where((item) => item.key == merchantKey);
    if (matches.isEmpty) {
      return const Scaffold(body: Center(child: Text('Merchant not found.')));
    }
    final merchant = matches.first;
    final groupedMappings = <String, List<_BranchMapping>>{};
    for (final branch in merchant.branches) {
      for (final mapping in branch.mccMappings) {
        groupedMappings
            .putIfAbsent(mapping.mccCode, () => [])
            .add(_BranchMapping(branch: branch, mapping: mapping));
      }
    }
    final mccGroups = groupedMappings.entries.toList()
      ..sort((left, right) => left.key.compareTo(right.key));

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
            selectionMode ? 'Choose a payment MCC' : 'Payment MCCs',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: ui.AppSpacing.xs),
          Text(
            selectionMode
                ? 'Choose the branch and payment type used for this transaction.'
                : 'Grouped by MCC. Each entry shows where and how that MCC applies.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: ui.AppSpacing.lg),
          if (mccGroups.isEmpty)
            const Card(
              child: Padding(
                padding: EdgeInsets.all(ui.AppSpacing.lg),
                child: Text(
                  'No MCC has been recorded for this merchant yet.',
                  textAlign: TextAlign.center,
                ),
              ),
            )
          else
            ...mccGroups.map(
              (group) => Padding(
                padding: const EdgeInsets.only(bottom: ui.AppSpacing.md),
                child: _MccGroupCard(
                  mccCode: group.key,
                  usages: group.value,
                  onSelected: selectionMode
                      ? (usage) => Navigator.pop(
                          context,
                          MerchantSelection(
                            merchantName: usage.branch.name,
                            merchantServerId:
                                usage.branch.localMerchantId == null
                                ? usage.branch.id
                                : null,
                            localMerchantId: usage.branch.localMerchantId,
                            locationText: usage.branch.locationText,
                            mccCandidate: usage.mapping,
                          ),
                        )
                      : null,
                ),
              ),
            ),
          if (!selectionMode) ...[
            const SizedBox(height: ui.AppSpacing.sm),
            OutlinedButton.icon(
              onPressed: () => _showContributionSheet(
                context,
                ref,
                merchant.branches,
                state.mccs,
              ),
              icon: const Icon(Icons.add_rounded),
              label: const Text('Contribute an MCC'),
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _showContributionSheet(
    BuildContext context,
    WidgetRef ref,
    List<MerchantBranch> branches,
    List<MerchantCategoryCode> mccs,
  ) async {
    if (branches.isEmpty) {
      AppToast.showError(context, 'No branch is available for contribution.');
      return;
    }
    final saved = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => _ContributionSheet(
        profileId: profileId,
        branches: branches,
        mccs: mccs,
      ),
    );
    if (saved == true && context.mounted) {
      AppToast.showSuccess(context, 'MCC contribution saved on this device.');
    }
  }
}

class _BranchMapping {
  const _BranchMapping({required this.branch, required this.mapping});

  final MerchantBranch branch;
  final MerchantMccMapping mapping;
}

class _MccGroupCard extends StatelessWidget {
  const _MccGroupCard({
    required this.mccCode,
    required this.usages,
    this.onSelected,
  });

  final String mccCode;
  final List<_BranchMapping> usages;
  final ValueChanged<_BranchMapping>? onSelected;

  @override
  Widget build(BuildContext context) {
    final description = usages
        .map((item) => item.mapping.mccDescription?.trim())
        .whereType<String>()
        .where((value) => value.isNotEmpty)
        .firstOrNull;
    final sortedUsages = [...usages]
      ..sort((left, right) {
        final paymentComparison = left.mapping.paymentType.label.compareTo(
          right.mapping.paymentType.label,
        );
        if (paymentComparison != 0) return paymentComparison;
        return _branchLabel(left.branch).compareTo(_branchLabel(right.branch));
      });

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(ui.AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Icon(Icons.tag_rounded),
                const SizedBox(width: ui.AppSpacing.xs),
                Expanded(
                  child: Text(
                    'MCC $mccCode',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ],
            ),
            if (description != null) ...[
              const SizedBox(height: ui.AppSpacing.xs),
              Text(
                description,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: ui.AppColors.muted),
              ),
            ],
            const SizedBox(height: ui.AppSpacing.sm),
            ...sortedUsages.map(
              (usage) => _MappingTile(
                usage: usage,
                onTap: onSelected == null ? null : () => onSelected!(usage),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MappingTile extends StatelessWidget {
  const _MappingTile({required this.usage, this.onTap});

  final _BranchMapping usage;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final mapping = usage.mapping;
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.payments_outlined),
      title: Text(mapping.paymentType.label),
      subtitle: Text(
        [
          _branchLabel(usage.branch),
          mapping.isLocalContribution
              ? 'Local contribution'
              : mapping.status == 'verified'
              ? 'Verified'
              : 'Suggested',
        ].join(' · '),
      ),
      trailing: onTap != null
          ? const Icon(Icons.chevron_right_rounded)
          : mapping.isLocalContribution
          ? const Icon(Icons.phone_iphone_rounded, size: 20)
          : null,
    );
  }
}

String _branchLabel(MerchantBranch branch) {
  final location = branch.locationText?.trim();
  return location?.isNotEmpty == true ? location! : 'Location not specified';
}

class _ContributionSheet extends ConsumerStatefulWidget {
  const _ContributionSheet({
    required this.profileId,
    required this.branches,
    required this.mccs,
  });

  final String profileId;
  final List<MerchantBranch> branches;
  final List<MerchantCategoryCode> mccs;

  @override
  ConsumerState<_ContributionSheet> createState() => _ContributionSheetState();
}

class _ContributionSheetState extends ConsumerState<_ContributionSheet> {
  final _noteController = TextEditingController();
  final _mccController = TextEditingController();
  MerchantCategoryCode? _selectedMcc;
  late MerchantBranch _selectedBranch;
  MerchantPaymentType _paymentType = MerchantPaymentType.inStore;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _selectedBranch = widget.branches.first;
  }

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
            const SizedBox(height: ui.AppSpacing.lg),
            DropdownButtonFormField<String>(
              initialValue: _selectedBranch.id,
              decoration: const InputDecoration(labelText: 'Branch'),
              items: widget.branches
                  .map(
                    (branch) => DropdownMenuItem(
                      value: branch.id,
                      child: Text(
                        _branchLabel(branch),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                  .toList(growable: false),
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  _selectedBranch = widget.branches.firstWhere(
                    (branch) => branch.id == value,
                  );
                });
              },
            ),
            const SizedBox(height: ui.AppSpacing.md),
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
              branch: _selectedBranch,
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
