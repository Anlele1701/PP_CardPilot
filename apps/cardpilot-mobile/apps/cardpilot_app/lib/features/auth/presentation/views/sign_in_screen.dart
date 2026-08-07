import 'package:cardpilot_ui/cardpilot_ui.dart' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/notifications/app_toast.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../initial_setup/domain/entities/access_mode.dart';
import '../../../initial_setup/initial_setup_providers.dart';
import '../../auth_providers.dart';
import '../widgets/auth_form_validators.dart';
import '../widgets/auth_form_widgets.dart';
import '../widgets/auth_session_redirector.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    ref
        .read(loginControllerProvider.notifier)
        .signInWithEmail(
          email: _emailController.text,
          password: _passwordController.text,
        );
  }

  void _openSignUp() {
    ref.read(loginControllerProvider.notifier).reset();
    Navigator.of(context).pushReplacementNamed(AppRoutes.signUp);
  }

  Future<void> _continueAsGuest() async {
    FocusScope.of(context).unfocus();
    ref.read(loginControllerProvider.notifier).reset();

    final workspace = await ref
        .read(initialSetupRepositoryProvider)
        .loadActiveGuest();
    if (!mounted) {
      return;
    }

    if (workspace != null) {
      ref.read(initialSetupControllerProvider.notifier).restore(workspace);
      Navigator.of(
        context,
      ).pushNamedAndRemoveUntil(AppRoutes.home, (_) => false);
      return;
    }

    ref
        .read(initialSetupControllerProvider.notifier)
        .selectAccessMode(AccessMode.guest);
    Navigator.of(context).pushNamed(AppRoutes.setupProfile);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginControllerProvider);
    final controller = ref.read(loginControllerProvider.notifier);
    final isLoading = state.status == LoginStatus.loading;
    final isCredentialLoading =
        isLoading && state.activeAction == LoginAction.emailSignIn;

    ref.listen(loginControllerProvider, (previous, next) {
      if (next.status == LoginStatus.failure &&
          next.errorMessage != previous?.errorMessage) {
        AppToast.showError(
          context,
          next.errorMessage ?? 'Authentication failed.',
        );
      }
    });

    return AuthSessionRedirector(
      child: AuthPageScaffold(
        titlePrefix: 'Welcome ',
        titleAccent: 'back',
        subtitle: 'Sign in to keep your cards and rewards in sync.',
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                textInputAction: TextInputAction.done,
                autofillHints: const [AutofillHints.password],
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
                validator: AuthFormValidators.signInPassword,
                onFieldSubmitted: (_) => _submit(),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    AppToast.showInfo(
                      context,
                      'Password reset will be added next.',
                    );
                  },
                  child: const Text('Forgot password?'),
                ),
              ),
              const SizedBox(height: ui.AppSpacing.sm),
              AuthGradientButton(
                key: const Key('credential-submit-button'),
                label: 'Sign in',
                isLoading: isCredentialLoading,
                onPressed: isLoading ? null : _submit,
              ),
              const SizedBox(height: ui.AppSpacing.md),
              OutlinedButton.icon(
                key: const Key('continue-as-guest-button'),
                onPressed: isLoading ? null : _continueAsGuest,
                icon: const Icon(Icons.person_outline_rounded),
                label: const Text('Continue as guest'),
              ),
              const SizedBox(height: ui.AppSpacing.sm),

              const SizedBox(height: ui.AppSpacing.md),
              const AuthDivider(label: 'or sign in with'),
              const SizedBox(height: ui.AppSpacing.md),
              AuthSocialButtons(state: state, onPressed: controller.signIn),
              if (state.status == LoginStatus.redirecting) ...[
                const SizedBox(height: ui.AppSpacing.md),
                Text(
                  'Complete sign-in in your browser, then return to CardPilot.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
              const SizedBox(height: ui.AppSpacing.lg),
              AuthModePrompt(
                message: "Don't have an account?",
                actionLabel: 'Sign up',
                onPressed: isLoading ? null : _openSignUp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
