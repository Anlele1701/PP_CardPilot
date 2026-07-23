import 'package:cardpilot_ui/cardpilot_ui.dart' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth_providers.dart';
import '../../domain/entities/social_auth_provider.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginControllerProvider);
    final controller = ref.read(loginControllerProvider.notifier);
    final isLoading = state.status == LoginStatus.loading;

    ref.listen(loginControllerProvider, (previous, next) {
      if (next.status == LoginStatus.failure &&
          next.errorMessage != previous?.errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.errorMessage ?? 'Sign-in failed.')),
        );
      }
    });

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [ui.AppColors.skyTop, ui.AppColors.surface],
            stops: [0, 0.62],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(ui.AppSpacing.lg),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const _BrandMark(),
                    const SizedBox(height: ui.AppSpacing.xl),
                    Text(
                      'Welcome to CardPilot',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: ui.AppSpacing.sm),
                    Text(
                      'Sign in to keep your cards, rewards, and cashback '
                      'insights safely in sync.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: ui.AppSpacing.xxl),
                    ui.SocialAuthButton(
                      label: 'Continue with Google',
                      leading: const _GoogleMark(),
                      isLoading:
                          isLoading &&
                          state.activeProvider == SocialAuthProvider.google,
                      onPressed: isLoading
                          ? null
                          : () => controller.signIn(SocialAuthProvider.google),
                    ),
                    const SizedBox(height: ui.AppSpacing.md),
                    ui.SocialAuthButton(
                      label: 'Continue with Facebook',
                      leading: const _FacebookMark(),
                      isLoading:
                          isLoading &&
                          state.activeProvider == SocialAuthProvider.facebook,
                      onPressed: isLoading
                          ? null
                          : () =>
                                controller.signIn(SocialAuthProvider.facebook),
                    ),
                    if (state.status == LoginStatus.redirecting) ...[
                      const SizedBox(height: ui.AppSpacing.md),
                      Text(
                        'Complete sign-in in your browser, then return to '
                        'CardPilot.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                    const SizedBox(height: ui.AppSpacing.xl),
                    Text(
                      'By continuing, you agree to CardPilot’s Terms of '
                      'Service and Privacy Policy.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: ui.AppColors.muted,
                        height: 1.4,
                      ),
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

class _BrandMark extends StatelessWidget {
  const _BrandMark();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: ui.CardPilotLogo(
        width: 118,
        height: 104,
      ),
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
