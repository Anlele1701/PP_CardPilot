import 'package:cardpilot_ui/cardpilot_ui.dart' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/routing/app_routes.dart';
import '../../../../core/constants/validation_messages.dart';
import '../../domain/entities/access_mode.dart';
import '../../initial_setup_providers.dart';

class ProfileSetupScreen extends ConsumerStatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  ConsumerState<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends ConsumerState<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _continue() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    ref
        .read(initialSetupControllerProvider.notifier)
        .saveDisplayName(_nameController.text);
    Navigator.of(context).pushNamed(AppRoutes.setupCard);
  }

  @override
  Widget build(BuildContext context) {
    final accessMode = ref.watch(
      initialSetupControllerProvider.select((state) => state.accessMode),
    );
    final isGuest = accessMode == AccessMode.guest;

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
                      'What should we call you?',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: ui.AppSpacing.sm),
                    Text(
                      isGuest
                          ? 'We will save this profile on your device.'
                          : 'This name will be used for your CardPilot profile.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: ui.AppSpacing.xl),
                    TextFormField(
                      controller: _nameController,
                      autofocus: true,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        labelText: 'Display name',
                        hintText: 'e.g. An',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        final name = value?.trim() ?? '';
                        if (name.isEmpty) {
                          return ValidationMessages.displayNameRequired;
                        }
                        if (name.length > 40) {
                          return ValidationMessages.displayNameTooLong;
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) => _continue(),
                    ),
                    const SizedBox(height: ui.AppSpacing.xl),
                    ui.AppPrimaryButton(
                      label: 'Continue',
                      onPressed: _continue,
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
