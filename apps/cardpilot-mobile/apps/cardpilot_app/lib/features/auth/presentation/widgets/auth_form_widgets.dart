import 'package:cardpilot_ui/cardpilot_ui.dart' as ui;
import 'package:flutter/material.dart';

import '../../../../core/constants/validation_messages.dart';
import '../../auth_providers.dart';
import '../../domain/entities/social_auth_provider.dart';

class AuthPageScaffold extends StatelessWidget {
  const AuthPageScaffold({
    required this.titlePrefix,
    required this.titleAccent,
    required this.subtitle,
    required this.child,
    super.key,
  });

  final String titlePrefix;
  final String titleAccent;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final headingStyle = Theme.of(context).textTheme.headlineMedium?.copyWith(
      color: ui.AppColors.ink,
      fontWeight: FontWeight.w800,
    );

    return Scaffold(
      body: SizedBox.expand(
        key: const Key('auth-page-background'),
        child: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                ui.AppColors.skyTop,
                ui.AppColors.surface,
                Color(0xFFE8FFF8),
              ],
              stops: [0, 0.5, 1],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                ui.AppSpacing.lg,
                72,
                ui.AppSpacing.lg,
                ui.AppSpacing.xl,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Center(
                        child: ui.CardPilotLogo(width: 112, height: 98),
                      ),
                      const SizedBox(height: ui.AppSpacing.lg),
                      Text.rich(
                        TextSpan(
                          text: titlePrefix,
                          children: [
                            TextSpan(
                              text: titleAccent,
                              style: headingStyle?.copyWith(
                                color: const Color(0xFF19C7A0),
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                        style: headingStyle,
                      ),
                      const SizedBox(height: ui.AppSpacing.sm),
                      Text(
                        subtitle,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: ui.AppColors.muted,
                        ),
                      ),
                      const SizedBox(height: ui.AppSpacing.xl),
                      child,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    required this.controller,
    required this.label,
    required this.icon,
    required this.validator,
    this.keyboardType,
    this.textInputAction,
    this.autofillHints,
    this.obscureText = false,
    this.suffixIcon,
    this.onFieldSubmitted,
    super.key,
  });

  final TextEditingController controller;
  final String label;
  final IconData icon;
  final FormFieldValidator<String> validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;
  final bool obscureText;
  final Widget? suffixIcon;
  final ValueChanged<String>? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      autofillHints: autofillHints,
      obscureText: obscureText,
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.88),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFDCE4EF)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFDCE4EF)),
        ),
      ),
    );
  }
}

class AuthGradientButton extends StatelessWidget {
  const AuthGradientButton({
    required this.label,
    required this.onPressed,
    required this.isLoading,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [ui.AppColors.brandBlue, Color(0xFF10CDA2)],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: Colors.transparent,
          disabledBackgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: ui.AppSpacing.md),
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox.square(
                dimension: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Text(label),
      ),
    );
  }
}

class AuthDivider extends StatelessWidget {
  const AuthDivider({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: ui.AppSpacing.md),
          child: Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: ui.AppColors.muted),
          ),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }
}

class AuthSocialButtons extends StatelessWidget {
  const AuthSocialButtons({
    required this.state,
    required this.onPressed,
    super.key,
  });

  final LoginState state;
  final ValueChanged<SocialAuthProvider> onPressed;

  @override
  Widget build(BuildContext context) {
    final isLoading = state.status == LoginStatus.loading;

    return Row(
      children: [
        Expanded(
          child: ui.SocialAuthButton(
            label: 'Google',
            leading: const _GoogleMark(),
            isLoading:
                isLoading && state.activeProvider == SocialAuthProvider.google,
            onPressed: isLoading
                ? null
                : () => onPressed(SocialAuthProvider.google),
          ),
        ),
        const SizedBox(width: ui.AppSpacing.sm),
        Expanded(
          child: ui.SocialAuthButton(
            label: 'Facebook',
            leading: const _FacebookMark(),
            isLoading:
                isLoading &&
                state.activeProvider == SocialAuthProvider.facebook,
            onPressed: isLoading
                ? null
                : () => onPressed(SocialAuthProvider.facebook),
          ),
        ),
      ],
    );
  }
}

class AuthModePrompt extends StatelessWidget {
  const AuthModePrompt({
    required this.message,
    required this.actionLabel,
    required this.onPressed,
    super.key,
  });

  final String message;
  final String actionLabel;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(message, style: Theme.of(context).textTheme.bodyMedium),
        TextButton(
          key: const Key('switch-auth-mode-button'),
          onPressed: onPressed,
          child: Text(actionLabel),
        ),
      ],
    );
  }
}

class AuthTermsAgreement extends StatelessWidget {
  const AuthTermsAgreement({
    required this.value,
    required this.showError,
    required this.onChanged,
    super.key,
  });

  final bool value;
  final bool showError;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Checkbox(
              key: const Key('terms-checkbox'),
              value: value,
              onChanged: (checked) => onChanged(checked ?? false),
            ),
            Expanded(
              child: Text.rich(
                TextSpan(
                  text: 'I agree to the ',
                  children: [
                    TextSpan(
                      text: 'Terms of Service',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const TextSpan(text: ' and '),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        ),
        if (showError)
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              ValidationMessages.termsRequired,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
      ],
    );
  }
}

class _GoogleMark extends StatelessWidget {
  const _GoogleMark();

  @override
  Widget build(BuildContext context) {
    return const _ProviderMark(
      backgroundColor: Colors.white,
      foregroundColor: Color(0xFF4285F4),
      borderColor: Color(0xFFD8E0EA),
      label: 'G',
    );
  }
}

class _FacebookMark extends StatelessWidget {
  const _FacebookMark();

  @override
  Widget build(BuildContext context) {
    return const _ProviderMark(
      backgroundColor: Color(0xFF1877F2),
      foregroundColor: Colors.white,
      label: 'f',
    );
  }
}

class _ProviderMark extends StatelessWidget {
  const _ProviderMark({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.label,
    this.borderColor,
  });

  final Color backgroundColor;
  final Color foregroundColor;
  final Color? borderColor;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 26,
      height: 26,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: borderColor == null ? null : Border.all(color: borderColor!),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          color: foregroundColor,
          fontSize: 16,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
