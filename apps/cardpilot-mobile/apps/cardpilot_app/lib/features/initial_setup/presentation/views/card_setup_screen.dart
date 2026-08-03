import 'package:cardpilot_ui/cardpilot_ui.dart' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/notifications/app_toast.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/constants/validation_messages.dart';
import '../../initial_setup_providers.dart';

class CardSetupScreen extends ConsumerStatefulWidget {
  const CardSetupScreen({super.key});

  @override
  ConsumerState<CardSetupScreen> createState() => _CardSetupScreenState();
}

class _CardSetupScreenState extends ConsumerState<CardSetupScreen> {
  static const _banks = ['ACB', 'Techcombank', 'VPBank', 'MB', 'Other'];

  final _formKey = GlobalKey<FormState>();
  final _nicknameController = TextEditingController();
  final _billingDayController = TextEditingController(text: '15');
  String _selectedBank = _banks.first;

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

    final completed = await ref
        .read(initialSetupControllerProvider.notifier)
        .complete(
          bankName: _selectedBank,
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

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(initialSetupControllerProvider);
    final isSaving = state.status == InitialSetupStatus.saving;

    return Scaffold(
      appBar: AppBar(title: const Text('Add your first card')),
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
                    DropdownButtonFormField<String>(
                      initialValue: _selectedBank,
                      decoration: const InputDecoration(
                        labelText: 'Bank',
                        border: OutlineInputBorder(),
                      ),
                      items: _banks
                          .map(
                            (bank) => DropdownMenuItem(
                              value: bank,
                              child: Text(bank),
                            ),
                          )
                          .toList(),
                      onChanged: isSaving
                          ? null
                          : (value) {
                              if (value != null) {
                                setState(() => _selectedBank = value);
                              }
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
