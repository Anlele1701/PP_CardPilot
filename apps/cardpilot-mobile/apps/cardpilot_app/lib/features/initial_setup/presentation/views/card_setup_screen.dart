import 'package:cardpilot_ui/cardpilot_ui.dart' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/notifications/app_toast.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/constants/validation_messages.dart';
import '../../../banks/bank_providers.dart';
import '../../../banks/domain/entities/bank.dart';
import '../../initial_setup_providers.dart';

class CardSetupScreen extends ConsumerStatefulWidget {
  const CardSetupScreen({super.key});

  @override
  ConsumerState<CardSetupScreen> createState() => _CardSetupScreenState();
}

class _CardSetupScreenState extends ConsumerState<CardSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nicknameController = TextEditingController();
  final _billingDayController = TextEditingController(text: '15');
  Bank? _selectedBank;

  @override
  void dispose() {
    _nicknameController.dispose();
    _billingDayController.dispose();
    super.dispose();
  }

  Future<void> _createCard() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final selectedBank = _selectedBank;
    if (selectedBank == null) {
      return;
    }

    final completed = await ref
        .read(initialSetupControllerProvider.notifier)
        .complete(
          bankId: selectedBank.id,
          bankName: selectedBank.displayName,
          cardNickname: _nicknameController.text,
          billingCycleDay: int.parse(_billingDayController.text),
        );

    if (!mounted) {
      return;
    }

    if (completed) {
      Navigator.of(
        context,
      ).pushNamedAndRemoveUntil(AppRoutes.home, (route) => false);
      return;
    }

    final message =
        ref.read(initialSetupControllerProvider).errorMessage ??
        'Could not create your card.';
    AppToast.showError(context, message);
  }

  Future<void> _chooseBank(FormFieldState<Bank> field) async {
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
      final message =
          ref.read(bankLoadControllerProvider).errorMessage ??
          'Could not load banks. Please try again.';
      AppToast.showError(context, message);
      return;
    }

    final selectedBank = await showModalBottomSheet<Bank>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (sheetContext) {
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
                  child: Text(
                    'Choose your bank',
                    style: Theme.of(sheetContext).textTheme.titleLarge,
                  ),
                ),
                const Divider(height: 1),
                Expanded(
                  child: ListView.separated(
                    itemCount: banks.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final bank = banks[index];
                      final showsFullName = bank.displayName != bank.name;
                      return ListTile(
                        key: Key('bank-option-${bank.id}'),
                        title: Text(bank.displayName),
                        subtitle: showsFullName ? Text(bank.name) : null,
                        trailing: bank.id == _selectedBank?.id
                            ? const Icon(Icons.check_rounded)
                            : null,
                        onTap: () => Navigator.pop(context, bank),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (selectedBank != null && mounted) {
      setState(() => _selectedBank = selectedBank);
      field.didChange(selectedBank);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(initialSetupControllerProvider);
    ref.watch(banksProvider);
    final bankLoadState = ref.watch(bankLoadControllerProvider);
    final isSaving = state.status == InitialSetupStatus.saving;
    final isLoadingBanks = bankLoadState.status == BankLoadStatus.loading;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(ui.AppSpacing.lg),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Start with one card',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: ui.AppSpacing.sm),
                    Text(
                      'We will use it to prepare your cashback dashboard.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: ui.AppSpacing.xl),
                    FormField<Bank>(
                      initialValue: _selectedBank,
                      validator: (bank) =>
                          bank == null ? ValidationMessages.bankRequired : null,
                      builder: (field) {
                        final enabled = !isSaving && !isLoadingBanks;
                        return Semantics(
                          button: true,
                          child: InkWell(
                            key: const Key('bank-picker-field'),
                            borderRadius: BorderRadius.circular(4),
                            onTap: enabled ? () => _chooseBank(field) : null,
                            child: InputDecorator(
                              // The placeholder below is visible content, so the
                              // decorator must keep its label floated.
                              isEmpty: false,
                              decoration: InputDecoration(
                                labelText: 'Bank',
                                errorText: field.errorText,
                                enabled: enabled,
                                border: const OutlineInputBorder(),
                                suffixIcon: isLoadingBanks
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
                                _selectedBank?.displayName ?? 'Select a bank',
                              ),
                            ),
                          ),
                        );
                      },
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
                      validator: (value) {
                        if ((value?.trim() ?? '').isEmpty) {
                          return ValidationMessages.cardNicknameRequired;
                        }
                        return null;
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
                        if (day == null || day < 1 || day > 31) {
                          return ValidationMessages.billingDayOutOfRange;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: ui.AppSpacing.xl),
                    ui.AppPrimaryButton(
                      label: 'Create my card',
                      isLoading: isSaving,
                      onPressed: _createCard,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
