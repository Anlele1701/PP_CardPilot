import 'package:cardpilot_ui/cardpilot_ui.dart' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/notifications/app_toast.dart';
import '../../../../core/routing/app_routes.dart';
import '../../auth_providers.dart';
import '../widgets/auth_form_validators.dart';
import '../widgets/auth_form_widgets.dart';
import '../widgets/auth_session_redirector.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmation = true;
  bool _acceptedTerms = false;
  bool _showTermsError = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();

    final validForm = _formKey.currentState?.validate() ?? false;
    setState(() => _showTermsError = !_acceptedTerms);
    if (!validForm || !_acceptedTerms) {
      return;
    }

    ref
        .read(loginControllerProvider.notifier)
        .signUpWithEmail(
          fullName: _fullNameController.text,
          email: _emailController.text,
          password: _passwordController.text,
        );
  }

  void _openSignIn() {
    ref.read(loginControllerProvider.notifier).reset();
    Navigator.of(context).pushReplacementNamed(AppRoutes.signIn);
  }

  String? _validateConfirmation(String? value) {
    return AuthFormValidators.passwordConfirmation(
      value,
      _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginControllerProvider);
    final controller = ref.read(loginControllerProvider.notifier);
    final isLoading = state.status == LoginStatus.loading;
    final isCredentialLoading =
        isLoading && state.activeAction == LoginAction.emailSignUp;

    ref.listen(loginControllerProvider, (previous, next) {
      if (next.status == LoginStatus.failure &&
          next.errorMessage != previous?.errorMessage) {
        AppToast.showError(
          context,
          next.errorMessage ?? 'Authentication failed.',
        );
      } else if (next.status == LoginStatus.emailConfirmationRequired &&
          previous?.status != LoginStatus.emailConfirmationRequired) {
        AppToast.showSuccess(
          context,
          'Account created. Check your email and open the confirmation link, '
          'then return here to sign in.',
        );
      }
    });

    return AuthSessionRedirector(
      child: AuthPageScaffold(
        titlePrefix: 'Create your ',
        titleAccent: 'account',
        subtitle: 'Start maximizing your cashback and rewards today.',
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AuthTextField(
                key: const Key('full-name-field'),
                controller: _fullNameController,
                label: 'Full name',
                icon: Icons.person_outline_rounded,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.name],
                validator: AuthFormValidators.fullName,
              ),
              const SizedBox(height: ui.AppSpacing.md),
              AuthTextField(
                key: const Key('email-field'),
                controller: _emailController,
                label: 'Email address',
                icon: Icons.mail_outline_rounded,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.email],
                validator: AuthFormValidators.email,
              ),
              const SizedBox(height: ui.AppSpacing.md),
              AuthTextField(
                key: const Key('password-field'),
                controller: _passwordController,
                label: 'Password',
                icon: Icons.lock_outline_rounded,
                obscureText: _obscurePassword,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.newPassword],
                suffixIcon: IconButton(
                  tooltip: _obscurePassword ? 'Show password' : 'Hide password',
                  onPressed: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                ),
                validator: AuthFormValidators.signUpPassword,
              ),
              const SizedBox(height: ui.AppSpacing.xs),
              Text(
                'Use at least 8 characters with letters and numbers.',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: ui.AppColors.muted),
              ),
              const SizedBox(height: ui.AppSpacing.md),
              AuthTextField(
                key: const Key('confirm-password-field'),
                controller: _confirmPasswordController,
                label: 'Confirm password',
                icon: Icons.lock_outline_rounded,
                obscureText: _obscureConfirmation,
                textInputAction: TextInputAction.done,
                autofillHints: const [AutofillHints.newPassword],
                suffixIcon: IconButton(
                  tooltip: _obscureConfirmation
                      ? 'Show confirmation'
                      : 'Hide confirmation',
                  onPressed: () => setState(
                    () => _obscureConfirmation = !_obscureConfirmation,
                  ),
                  icon: Icon(
                    _obscureConfirmation
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                ),
                validator: _validateConfirmation,
                onFieldSubmitted: (_) => _submit(),
              ),
              const SizedBox(height: ui.AppSpacing.sm),
              AuthTermsAgreement(
                value: _acceptedTerms,
                showError: _showTermsError,
                onChanged: (value) {
                  setState(() {
                    _acceptedTerms = value;
                    _showTermsError = false;
                  });
                },
              ),
              const SizedBox(height: ui.AppSpacing.sm),
              AuthGradientButton(
                key: const Key('credential-submit-button'),
                label: 'Create account',
                isLoading: isCredentialLoading,
                onPressed: isLoading ? null : _submit,
              ),
              const SizedBox(height: ui.AppSpacing.md),
              const AuthDivider(label: 'or sign up with'),
              const SizedBox(height: ui.AppSpacing.md),
              AuthSocialButtons(state: state, onPressed: controller.signIn),
              const SizedBox(height: ui.AppSpacing.xs),
              AuthModePrompt(
                message: 'Already have an account?',
                actionLabel: 'Sign in',
                onPressed: isLoading ? null : _openSignIn,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
