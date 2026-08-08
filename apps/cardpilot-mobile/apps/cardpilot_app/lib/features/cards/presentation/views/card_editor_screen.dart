import 'package:cardpilot_ui/cardpilot_ui.dart' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/validation_messages.dart';
import '../../../../core/notifications/app_toast.dart';
import '../../../banks/bank_providers.dart';
import '../../../banks/domain/entities/bank.dart';
import '../../../credit_cards/credit_card_providers.dart';
import '../../../credit_cards/domain/entities/credit_card.dart';
import '../../../initial_setup/domain/entities/local_user_card.dart';
import '../../cards_providers.dart';

class CardEditorScreen extends ConsumerStatefulWidget {
  const CardEditorScreen({
    required this.profileId,
    this.initialCard,
    super.key,
  });

  final String profileId;
  final LocalUserCard? initialCard;

  bool get isEditing => initialCard != null;

  @override
  ConsumerState<CardEditorScreen> createState() => _CardEditorScreenState();
}

class _CardEditorScreenState extends ConsumerState<CardEditorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _bankFieldKey = GlobalKey<FormFieldState<String>>();
  final _creditCardFieldKey = GlobalKey<FormFieldState<String>>();
  late final TextEditingController _nicknameController;
  late final TextEditingController _creditLimitController;
  late final TextEditingController _billingDayController;

  String? _bankId;
  String? _bankName;
  String? _creditCardId;
  String? _creditCardLabel;

  @override
  void initState() {
    super.initState();
    final card = widget.initialCard;
    _bankId = card?.bankId;
    _bankName = card?.bankName;
    _creditCardId = card?.creditCardId;
    _nicknameController = TextEditingController(text: card?.nickname ?? '');
    _creditLimitController = TextEditingController(
      text: card == null || card.creditLimitMinor <= 0
          ? ''
          : card.creditLimitMinor.toString(),
    );
    _billingDayController = TextEditingController(
      text: (card?.billingCycleDay ?? 15).toString(),
    );
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _creditLimitController.dispose();
    _billingDayController.dispose();
    super.dispose();
  }

  Future<void> _chooseBank() async {
    final cachedBanks = ref
        .read(banksProvider)
        .when(
          data: (banks) => banks,
          error: (_, _) => const <Bank>[],
          loading: () => const <Bank>[],
        );
    final banks = cachedBanks.isNotEmpty
        ? cachedBanks
        : await ref.read(bankLoadControllerProvider.notifier).ensureLoaded();
    if (!mounted) {
      return;
    }
    if (banks == null || banks.isEmpty) {
      AppToast.showError(
        context,
        ref.read(bankLoadControllerProvider).errorMessage ??
            'Could not load banks. Please try again.',
      );
      return;
    }

    final bank = await showModalBottomSheet<Bank>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (sheetContext) => _CatalogSheet<Bank>(
        title: 'Choose your bank',
        items: banks,
        selectedId: _bankId,
        idOf: (item) => item.id,
        titleOf: (item) => item.displayName,
        subtitleOf: (item) => item.displayName == item.name ? null : item.name,
      ),
    );
    if (bank == null || !mounted) {
      return;
    }

    final changedBank = bank.id != _bankId;
    setState(() {
      _bankId = bank.id;
      _bankName = bank.displayName;
      if (changedBank) {
        _creditCardId = null;
        _creditCardLabel = null;
      }
    });
    _bankFieldKey.currentState?.didChange(bank.id);
    if (changedBank) {
      _creditCardFieldKey.currentState?.didChange(null);
    }
  }

  Future<void> _chooseCreditCard() async {
    final bankId = _bankId;
    if (bankId == null) {
      AppToast.showInfo(context, 'Choose a bank first.');
      return;
    }

    final cachedCards = ref
        .read(creditCardsProvider(bankId))
        .when(
          data: (cards) => cards,
          error: (_, _) => const <CreditCard>[],
          loading: () => const <CreditCard>[],
        );
    final cards = cachedCards.isNotEmpty
        ? cachedCards
        : await ref
              .read(creditCardLoadControllerProvider.notifier)
              .ensureLoaded(bankId);
    if (!mounted || _bankId != bankId) {
      return;
    }
    if (cards == null) {
      AppToast.showError(
        context,
        ref.read(creditCardLoadControllerProvider).errorMessage ??
            'Could not load cards. Please try again.',
      );
      return;
    }
    if (cards.isEmpty) {
      AppToast.showInfo(
        context,
        'No supported cards are available for $_bankName.',
      );
      return;
    }

    final card = await showModalBottomSheet<CreditCard>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (sheetContext) => _CatalogSheet<CreditCard>(
        title: 'Choose your card',
        items: cards,
        selectedId: _creditCardId,
        idOf: (item) => item.id,
        titleOf: (item) => item.name,
        subtitleOf: (item) => item.network,
      ),
    );
    if (card == null || !mounted) {
      return;
    }

    setState(() {
      _creditCardId = card.id;
      _creditCardLabel = card.displayName;
    });
    _creditCardFieldKey.currentState?.didChange(card.id);
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final bankId = _bankId;
    final bankName = _bankName;
    final creditCardId = _creditCardId;
    if (bankId == null || bankName == null || creditCardId == null) {
      return;
    }

    final controller = ref.read(userCardControllerProvider.notifier);
    final initialCard = widget.initialCard;
    final saved = initialCard == null
        ? await controller.create(
            profileId: widget.profileId,
            bankId: bankId,
            bankName: bankName,
            creditCardId: creditCardId,
            nickname: _nicknameController.text,
            billingCycleDay: int.parse(_billingDayController.text),
            creditLimitMinor: int.parse(_creditLimitController.text),
          )
        : await controller.update(
            profileId: widget.profileId,
            cardId: initialCard.id,
            bankId: bankId,
            bankName: bankName,
            creditCardId: creditCardId,
            nickname: _nicknameController.text,
            billingCycleDay: int.parse(_billingDayController.text),
            creditLimitMinor: int.parse(_creditLimitController.text),
          );
    if (!mounted) {
      return;
    }
    if (!saved) {
      AppToast.showError(
        context,
        ref.read(userCardControllerProvider).errorMessage ??
            'Could not save the card.',
      );
      return;
    }

    AppToast.showSuccess(
      context,
      widget.isEditing ? 'Card updated.' : 'Card created.',
    );
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(banksProvider);
    final bankId = _bankId;
    final cachedCards = bankId == null
        ? const AsyncValue<List<CreditCard>>.data([])
        : ref.watch(creditCardsProvider(bankId));
    final selectedCard = cachedCards.value
        ?.where((card) => card.id == _creditCardId)
        .firstOrNull;
    final mutationState = ref.watch(userCardControllerProvider);
    final bankLoadState = ref.watch(bankLoadControllerProvider);
    final cardLoadState = ref.watch(creditCardLoadControllerProvider);
    final isSaving = mutationState.status == UserCardMutationStatus.saving;
    final isLoadingBanks = bankLoadState.status == BankLoadStatus.loading;
    final isLoadingCards = cardLoadState.status == CreditCardLoadStatus.loading;

    return Scaffold(
      appBar: AppBar(title: Text(widget.isEditing ? 'Edit card' : 'Add card')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(ui.AppSpacing.lg),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  widget.isEditing
                      ? 'Update your card details'
                      : 'Connect another card',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: ui.AppSpacing.xl),
                FormField<String>(
                  key: _bankFieldKey,
                  initialValue: _bankId,
                  validator: (value) =>
                      value == null ? ValidationMessages.bankRequired : null,
                  builder: (field) => _PickerField(
                    key: const Key('card-editor-bank-picker'),
                    label: 'Bank',
                    value: _bankName ?? 'Select a bank',
                    errorText: field.errorText,
                    isLoading: isLoadingBanks,
                    enabled: !isSaving && !isLoadingBanks && !isLoadingCards,
                    onTap: _chooseBank,
                  ),
                ),
                const SizedBox(height: ui.AppSpacing.md),
                FormField<String>(
                  key: _creditCardFieldKey,
                  initialValue: _creditCardId,
                  validator: (value) => value == null
                      ? ValidationMessages.creditCardRequired
                      : null,
                  builder: (field) => _PickerField(
                    key: const Key('card-editor-credit-card-picker'),
                    label: 'Card',
                    value:
                        _creditCardLabel ??
                        selectedCard?.displayName ??
                        (_creditCardId == null
                            ? bankId == null
                                  ? 'Choose a bank first'
                                  : 'Select a card'
                            : 'Selected card'),
                    errorText: field.errorText,
                    isLoading: isLoadingCards,
                    enabled: bankId != null && !isSaving && !isLoadingCards,
                    onTap: _chooseCreditCard,
                  ),
                ),
                const SizedBox(height: ui.AppSpacing.md),
                TextFormField(
                  controller: _nicknameController,
                  enabled: !isSaving,
                  decoration: const InputDecoration(
                    labelText: 'Card nickname',
                    hintText: 'e.g. Everyday Visa',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => (value?.trim() ?? '').isEmpty
                      ? ValidationMessages.cardNicknameRequired
                      : null,
                ),
                const SizedBox(height: ui.AppSpacing.md),
                TextFormField(
                  controller: _creditLimitController,
                  enabled: !isSaving,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    labelText: 'Credit limit',
                    hintText: 'e.g. 20000000',
                    suffixText: 'VND',
                    helperText: 'Enter the total limit assigned by your bank.',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    final limit = int.tryParse(value ?? '');
                    return limit == null || limit <= 0
                        ? ValidationMessages.creditLimitPositive
                        : null;
                  },
                ),
                const SizedBox(height: ui.AppSpacing.md),
                TextFormField(
                  controller: _billingDayController,
                  enabled: !isSaving,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    labelText: 'Billing cycle day',
                    helperText: 'Enter a day from 1 to 31.',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    final day = int.tryParse(value ?? '');
                    return day == null || day < 1 || day > 31
                        ? ValidationMessages.billingDayOutOfRange
                        : null;
                  },
                ),
                const SizedBox(height: ui.AppSpacing.xl),
                ui.AppPrimaryButton(
                  label: widget.isEditing ? 'Save changes' : 'Create card',
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

class _PickerField extends StatelessWidget {
  const _PickerField({
    required this.label,
    required this.value,
    required this.errorText,
    required this.isLoading,
    required this.enabled,
    required this.onTap,
    super.key,
  });

  final String label;
  final String value;
  final String? errorText;
  final bool isLoading;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enabled ? onTap : null,
      borderRadius: BorderRadius.circular(4),
      child: InputDecorator(
        isEmpty: false,
        decoration: InputDecoration(
          labelText: label,
          errorText: errorText,
          enabled: enabled,
          border: const OutlineInputBorder(),
          suffixIcon: isLoading
              ? const Padding(
                  padding: EdgeInsets.all(14),
                  child: SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                )
              : const Icon(Icons.arrow_drop_down),
        ),
        child: Text(value),
      ),
    );
  }
}

class _CatalogSheet<T> extends StatelessWidget {
  const _CatalogSheet({
    required this.title,
    required this.items,
    required this.selectedId,
    required this.idOf,
    required this.titleOf,
    required this.subtitleOf,
  });

  final String title;
  final List<T> items;
  final String? selectedId;
  final String Function(T item) idOf;
  final String Function(T item) titleOf;
  final String? Function(T item) subtitleOf;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FractionallySizedBox(
        heightFactor: 0.72,
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
              child: Text(title, style: Theme.of(context).textTheme.titleLarge),
            ),
            const Divider(height: 1),
            Expanded(
              child: ListView.separated(
                itemCount: items.length,
                separatorBuilder: (_, _) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final item = items[index];
                  final id = idOf(item);
                  return ListTile(
                    title: Text(titleOf(item)),
                    subtitle: switch (subtitleOf(item)) {
                      final subtitle? => Text(subtitle),
                      null => null,
                    },
                    trailing: id == selectedId
                        ? const Icon(Icons.check_rounded)
                        : null,
                    onTap: () => Navigator.pop(context, item),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
