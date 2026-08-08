import 'dart:async';

import 'package:cardpilot_ui/cardpilot_ui.dart' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/validation_messages.dart';
import '../../../../core/notifications/app_toast.dart';
import '../../../cashback_reference/cashback_reference_providers.dart';
import '../../../cashback_reference/domain/cashback_reference.dart';
import '../../../initial_setup/domain/entities/local_user_card.dart';
import '../../../merchants/presentation/views/merchants_page.dart';
import '../../domain/entities/local_transaction.dart';
import '../../transaction_providers.dart';
import '../transaction_formatters.dart';

class TransactionEditorScreen extends ConsumerStatefulWidget {
  const TransactionEditorScreen({
    required this.profileId,
    required this.cards,
    this.initialTransaction,
    super.key,
  });

  final String profileId;
  final List<LocalUserCard> cards;
  final LocalTransaction? initialTransaction;

  bool get isEditing => initialTransaction != null;

  @override
  ConsumerState<TransactionEditorScreen> createState() =>
      _TransactionEditorScreenState();
}

class _TransactionEditorScreenState
    extends ConsumerState<TransactionEditorScreen> {
  static const _categories = [
    'Shopping',
    'Food & Dining',
    'Transport',
    'Bills',
    'Entertainment',
    'Other',
  ];

  final _formKey = GlobalKey<FormState>();
  final _mccFieldKey = GlobalKey<FormFieldState<String>>();
  late final TextEditingController _merchantController;
  late final TextEditingController _amountController;
  late final TextEditingController _noteController;
  late String? _cardId;
  late String? _category;
  late String? _mccCode;
  String _mccSource = 'manual';
  int? _mccConfidencePpm;
  String? _merchantServerId;
  String? _merchantLocation;
  Timer? _merchantDebounce;
  late DateTime _transactionAt;

  @override
  void initState() {
    super.initState();
    final transaction = widget.initialTransaction;
    _merchantController = TextEditingController(
      text: transaction?.merchantName ?? '',
    );
    _amountController = TextEditingController(
      text: transaction?.amountMinor.toString() ?? '',
    );
    _noteController = TextEditingController(text: transaction?.note ?? '');
    _cardId = transaction?.userCardId ?? widget.cards.firstOrNull?.id;
    _category = transaction?.category;
    _mccCode = transaction?.mccCode;
    _transactionAt = transaction?.transactionAt ?? DateTime.now();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadReferenceData());
  }

  @override
  void dispose() {
    _merchantController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    _merchantDebounce?.cancel();
    super.dispose();
  }

  LocalUserCard? get _selectedCard =>
      widget.cards.where((card) => card.id == _cardId).firstOrNull;

  Future<void> _loadReferenceData() async {
    final creditCardId = _selectedCard?.creditCardId;
    if (creditCardId == null || !mounted) return;
    await ref
        .read(cashbackReferenceControllerProvider.notifier)
        .ensureLoaded(creditCardId);
    if (!mounted) return;
    final state = ref.read(cashbackReferenceControllerProvider);
    if (state.status == CashbackReferenceStatus.failure) {
      AppToast.showError(
        context,
        state.errorMessage ?? 'Could not load MCC and reward data.',
      );
    }
  }

  void _onMerchantChanged(String value) {
    _merchantDebounce?.cancel();
    _merchantServerId = null;
    _merchantLocation = null;
    if (_mccSource == 'merchant_match') {
      setState(() {
        _mccCode = null;
        _mccSource = 'manual';
        _mccConfidencePpm = null;
      });
      _mccFieldKey.currentState?.didChange(null);
    }
    _merchantDebounce = Timer(const Duration(milliseconds: 500), () async {
      await ref
          .read(cashbackReferenceControllerProvider.notifier)
          .searchMerchant(value);
      if (!mounted || _merchantController.text.trim() != value.trim()) return;
      final suggestions = ref
          .read(cashbackReferenceControllerProvider)
          .merchantSuggestions;
      if (suggestions.length == 1) {
        _applySuggestion(suggestions.single);
      }
    });
  }

  Future<void> _chooseMcc() async {
    var state = ref.read(cashbackReferenceControllerProvider);
    if (state.mccs.isEmpty) {
      await _loadReferenceData();
      if (!mounted) return;
      state = ref.read(cashbackReferenceControllerProvider);
    }
    if (state.mccs.isEmpty) {
      AppToast.showError(context, 'No MCC data is available.');
      return;
    }

    final selection = await showModalBottomSheet<_MccSelection>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (_) => _MccPickerSheet(
        selectedCode: _mccCode,
        allMccs: state.mccs,
        eligibleMccs: state.eligibleMccs,
        merchantSuggestions: state.merchantSuggestions,
      ),
    );
    if (selection == null || !mounted) return;
    setState(() {
      _mccCode = selection.mccCode;
      _mccSource = selection.suggestion == null ? 'manual' : 'merchant_match';
      _mccConfidencePpm = selection.suggestion?.confidencePpm ?? 1000000;
      if (selection.suggestion != null) {
        _merchantServerId = selection.suggestion!.merchantId;
        _merchantLocation = selection.suggestion!.locationText;
        _merchantController.text = selection.suggestion!.merchantName;
      }
    });
    _mccFieldKey.currentState?.didChange(selection.mccCode);
  }

  void _applySuggestion(MerchantMccSuggestion suggestion) {
    setState(() {
      _merchantController.text = suggestion.merchantName;
      _mccCode = suggestion.mccCode;
      _mccSource = 'merchant_match';
      _mccConfidencePpm = suggestion.confidencePpm;
      _merchantServerId = suggestion.merchantId;
      _merchantLocation = suggestion.locationText;
    });
    _mccFieldKey.currentState?.didChange(suggestion.mccCode);
  }

  Future<void> _browseMerchants() {
    return Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(title: const Text('Merchant directory')),
          body: MerchantsPage(profileId: widget.profileId, embedded: true),
        ),
      ),
    );
  }

  Future<void> _chooseDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _transactionAt,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (date == null || !mounted) {
      return;
    }
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_transactionAt),
    );
    if (time == null || !mounted) {
      return;
    }

    setState(() {
      _transactionAt = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final cardId = _cardId;
    final amount = int.tryParse(_amountController.text);
    final mccCode = _mccCode;
    if (cardId == null || amount == null || amount <= 0 || mccCode == null) {
      return;
    }

    final draft = TransactionDraft(
      userCardId: cardId,
      merchantName: _merchantController.text,
      transactionAt: _transactionAt,
      amountMinor: amount,
      mccCode: mccCode,
      mccSource: _mccSource,
      mccConfidencePpm: _mccConfidencePpm,
      merchantServerId: _merchantServerId,
      merchantLocation: _merchantLocation,
      category: _category,
      note: _noteController.text,
    );
    final controller = ref.read(transactionControllerProvider.notifier);
    final initialTransaction = widget.initialTransaction;
    final saved = initialTransaction == null
        ? await controller.create(profileId: widget.profileId, draft: draft)
        : await controller.update(
            profileId: widget.profileId,
            transactionId: initialTransaction.id,
            draft: draft,
          );
    if (!mounted) {
      return;
    }
    if (!saved) {
      AppToast.showError(
        context,
        ref.read(transactionControllerProvider).errorMessage ??
            'Could not save the transaction.',
      );
      return;
    }

    AppToast.showSuccess(
      context,
      widget.isEditing ? 'Transaction updated.' : 'Transaction created.',
    );
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final mutationState = ref.watch(transactionControllerProvider);
    final referenceState = ref.watch(cashbackReferenceControllerProvider);
    final isSaving = mutationState.status == TransactionMutationStatus.saving;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing ? 'Edit transaction' : 'Add transaction'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(ui.AppSpacing.lg),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DropdownButtonFormField<String>(
                  initialValue: _cardId,
                  decoration: const InputDecoration(
                    labelText: 'Card',
                    border: OutlineInputBorder(),
                  ),
                  items: widget.cards
                      .map(
                        (card) => DropdownMenuItem(
                          value: card.id,
                          child: Text('${card.nickname} · ${card.bankName}'),
                        ),
                      )
                      .toList(growable: false),
                  onChanged: isSaving
                      ? null
                      : (value) {
                          setState(() {
                            _cardId = value;
                            _mccCode = null;
                            _mccSource = 'manual';
                            _merchantServerId = null;
                            _merchantLocation = null;
                          });
                          _mccFieldKey.currentState?.didChange(null);
                          _loadReferenceData();
                        },
                  validator: (value) => value == null
                      ? ValidationMessages.transactionCardRequired
                      : null,
                ),
                const SizedBox(height: ui.AppSpacing.md),
                TextFormField(
                  controller: _merchantController,
                  enabled: !isSaving,
                  textCapitalization: TextCapitalization.words,
                  onChanged: _onMerchantChanged,
                  decoration: const InputDecoration(
                    labelText: 'Merchant',
                    hintText: 'e.g. Highlands Coffee',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => (value?.trim() ?? '').isEmpty
                      ? ValidationMessages.merchantRequired
                      : null,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    key: const Key('browse-merchants-button'),
                    onPressed: isSaving ? null : _browseMerchants,
                    icon: const Icon(Icons.storefront_outlined, size: 18),
                    label: const Text('Browse merchants'),
                  ),
                ),
                if (referenceState.status ==
                    CashbackReferenceStatus.searching) ...[
                  const SizedBox(height: ui.AppSpacing.sm),
                  const LinearProgressIndicator(),
                ],
                if (referenceState.merchantSuggestions.isNotEmpty) ...[
                  const SizedBox(height: ui.AppSpacing.sm),
                  Text(
                    'Merchant matches',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(height: ui.AppSpacing.xs),
                  ...referenceState.merchantSuggestions
                      .take(3)
                      .map(
                        (suggestion) => ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.storefront_outlined),
                          title: Text(suggestion.merchantName),
                          subtitle: Text(
                            '${suggestion.locationText ?? 'All branches'} · '
                            'MCC ${suggestion.mccCode} · '
                            '${referenceState.eligibleMccs.any((mcc) => mcc.code == suggestion.mccCode) ? 'Eligible' : 'No matching card rule'}',
                          ),
                          onTap: () => _applySuggestion(suggestion),
                        ),
                      ),
                ],
                const SizedBox(height: ui.AppSpacing.md),
                FormField<String>(
                  key: _mccFieldKey,
                  initialValue: _mccCode,
                  validator: (value) =>
                      value == null ? ValidationMessages.mccRequired : null,
                  builder: (field) => InkWell(
                    key: const Key('transaction-mcc-picker'),
                    onTap: isSaving ? null : _chooseMcc,
                    child: InputDecorator(
                      isEmpty: false,
                      decoration: InputDecoration(
                        labelText: 'Merchant Category Code (MCC)',
                        errorText: field.errorText,
                        border: const OutlineInputBorder(),
                        suffixIcon:
                            referenceState.status ==
                                CashbackReferenceStatus.loading
                            ? const Padding(
                                padding: EdgeInsets.all(14),
                                child: SizedBox.square(
                                  dimension: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              )
                            : const Icon(Icons.arrow_drop_down),
                      ),
                      child: Text(
                        _mccCode == null
                            ? 'Choose an eligible or custom MCC'
                            : 'MCC $_mccCode',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: ui.AppSpacing.md),
                TextFormField(
                  controller: _amountController,
                  enabled: !isSaving,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    labelText: 'Amount',
                    suffixText: 'VND',
                    hintText: '50000',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    final amount = int.tryParse(value ?? '');
                    return amount == null || amount <= 0
                        ? ValidationMessages.transactionAmountPositive
                        : null;
                  },
                ),
                const SizedBox(height: ui.AppSpacing.md),
                DropdownButtonFormField<String>(
                  initialValue: _category,
                  decoration: const InputDecoration(
                    labelText: 'Category (optional)',
                    border: OutlineInputBorder(),
                  ),
                  items: _categories
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ),
                      )
                      .toList(growable: false),
                  onChanged: isSaving
                      ? null
                      : (value) => setState(() => _category = value),
                ),
                const SizedBox(height: ui.AppSpacing.md),
                InkWell(
                  key: const Key('transaction-date-field'),
                  onTap: isSaving ? null : _chooseDateTime,
                  borderRadius: BorderRadius.circular(4),
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Date and time',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.calendar_month_outlined),
                    ),
                    child: Text(formatTransactionDate(_transactionAt)),
                  ),
                ),
                const SizedBox(height: ui.AppSpacing.md),
                TextFormField(
                  controller: _noteController,
                  enabled: !isSaving,
                  minLines: 3,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: 'Note (optional)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: ui.AppSpacing.xl),
                ui.AppPrimaryButton(
                  label: widget.isEditing ? 'Save changes' : 'Add transaction',
                  isLoading: isSaving,
                  onPressed: _save,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MccSelection {
  const _MccSelection({required this.mccCode, this.suggestion});

  final String mccCode;
  final MerchantMccSuggestion? suggestion;
}

class _MccPickerSheet extends StatefulWidget {
  const _MccPickerSheet({
    required this.selectedCode,
    required this.allMccs,
    required this.eligibleMccs,
    required this.merchantSuggestions,
  });

  final String? selectedCode;
  final List<MerchantCategoryCode> allMccs;
  final List<MerchantCategoryCode> eligibleMccs;
  final List<MerchantMccSuggestion> merchantSuggestions;

  @override
  State<_MccPickerSheet> createState() => _MccPickerSheetState();
}

class _MccPickerSheetState extends State<_MccPickerSheet> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final query = _query.trim().toLowerCase();
    final eligibleCodes = widget.eligibleMccs.map((item) => item.code).toSet();
    final filtered = widget.allMccs
        .where((mcc) {
          return query.isEmpty ||
              mcc.code.contains(query) ||
              mcc.description.toLowerCase().contains(query) ||
              (mcc.category?.toLowerCase().contains(query) ?? false);
        })
        .toList(growable: false);

    return SafeArea(
      child: FractionallySizedBox(
        heightFactor: 0.88,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                ui.AppSpacing.lg,
                0,
                ui.AppSpacing.lg,
                ui.AppSpacing.md,
              ),
              child: Text(
                'Choose MCC',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: ui.AppSpacing.lg),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search code or description',
                  prefixIcon: Icon(Icons.search_rounded),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => setState(() => _query = value),
              ),
            ),
            const SizedBox(height: ui.AppSpacing.md),
            Expanded(
              child: ListView(
                children: [
                  if (query.isEmpty &&
                      widget.merchantSuggestions.isNotEmpty) ...[
                    const _PickerHeader('Merchant and branch suggestions'),
                    ...widget.merchantSuggestions.map(
                      (suggestion) => ListTile(
                        leading: const Icon(Icons.storefront_outlined),
                        title: Text(
                          '${suggestion.merchantName} · MCC ${suggestion.mccCode}',
                        ),
                        subtitle: Text(
                          '${suggestion.locationText ?? 'All branches'}'
                          '${suggestion.mccDescription == null ? '' : ' · ${suggestion.mccDescription}'} · '
                          '${eligibleCodes.contains(suggestion.mccCode) ? 'Eligible' : 'No matching card rule'}',
                        ),
                        trailing: suggestion.mccCode == widget.selectedCode
                            ? const Icon(Icons.check_rounded)
                            : null,
                        onTap: () => Navigator.pop(
                          context,
                          _MccSelection(
                            mccCode: suggestion.mccCode,
                            suggestion: suggestion,
                          ),
                        ),
                      ),
                    ),
                  ],
                  if (query.isEmpty && widget.eligibleMccs.isNotEmpty) ...[
                    const _PickerHeader('Eligible for the selected card'),
                    ...widget.eligibleMccs.map(
                      (mcc) => _MccTile(
                        mcc: mcc,
                        selected: mcc.code == widget.selectedCode,
                        eligible: true,
                      ),
                    ),
                  ],
                  const _PickerHeader('All MCCs'),
                  ...filtered.map(
                    (mcc) => _MccTile(
                      mcc: mcc,
                      selected: mcc.code == widget.selectedCode,
                      eligible: eligibleCodes.contains(mcc.code),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PickerHeader extends StatelessWidget {
  const _PickerHeader(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        ui.AppSpacing.lg,
        ui.AppSpacing.md,
        ui.AppSpacing.lg,
        ui.AppSpacing.xs,
      ),
      child: Text(label, style: Theme.of(context).textTheme.labelLarge),
    );
  }
}

class _MccTile extends StatelessWidget {
  const _MccTile({
    required this.mcc,
    required this.selected,
    required this.eligible,
  });

  final MerchantCategoryCode mcc;
  final bool selected;
  final bool eligible;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${mcc.code} · ${mcc.description}'),
      subtitle: Text(
        [
          if (eligible) 'Eligible for selected card',
          mcc.category,
        ].whereType<String>().join(' · '),
      ),
      trailing: selected ? const Icon(Icons.check_rounded) : null,
      onTap: () => Navigator.pop(context, _MccSelection(mccCode: mcc.code)),
    );
  }
}
