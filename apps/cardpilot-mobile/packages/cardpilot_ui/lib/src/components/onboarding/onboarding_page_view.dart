import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import 'onboarding_hero_illustrations.dart';
import 'onboarding_slide_data.dart';

class OnboardingPageView extends StatelessWidget {
  const OnboardingPageView({
    required this.controller,
    required this.slides,
    required this.onPageChanged,
    super.key,
  });

  final PageController controller;
  final List<OnboardingSlideData> slides;
  final ValueChanged<int> onPageChanged;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller,
      itemCount: slides.length,
      onPageChanged: onPageChanged,
      itemBuilder: (context, index) {
        final slide = slides[index];

        return Column(
          children: [
            Expanded(
              flex: 7,
              child: SizedBox.expand(
                child: OnboardingHeroIllustration(
                  illustration: slide.illustration,
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const _OnboardingLogoMark(),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      slide.title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 310),
                      child: Text(
                        slide.subtitle,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _OnboardingLogoMark extends StatelessWidget {
  const _OnboardingLogoMark();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 44,
      height: 44,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: AppColors.brandBlue.withValues(alpha: 0.16),
              blurRadius: 22,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(9),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.brandBlue, AppColors.brandGreen],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
