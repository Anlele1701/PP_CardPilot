import 'package:cardpilot_ui/cardpilot_ui.dart' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../onboarding_providers.dart';
import '../../domain/entities/onboarding_slide.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(onboardingControllerProvider.notifier).load();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _goNext() async {
    final state = ref.read(onboardingControllerProvider);

    if (state.isLastPage) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Onboarding complete.')));
      return;
    }

    await _pageController.nextPage(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingControllerProvider);
    final controller = ref.read(onboardingControllerProvider.notifier);

    return Scaffold(
      body: switch (state.status) {
        OnboardingStatus.initial || OnboardingStatus.loading => const SafeArea(
          child: Center(child: CircularProgressIndicator()),
        ),
        OnboardingStatus.failure => SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(ui.AppSpacing.lg),
              child: Text(
                state.errorMessage ?? 'Something went wrong.',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        OnboardingStatus.ready => Column(
          children: [
            Expanded(
              child: ui.OnboardingPageView(
                controller: _pageController,
                slides: state.slides.map(_toUiSlide).toList(),
                onPageChanged: controller.setCurrentPage,
              ),
            ),
            SafeArea(
              top: false,
              child: Column(
                children: [
                  ui.OnboardingPagination(
                    currentPage: state.currentPage,
                    pageCount: state.slides.length,
                  ),
                  if (state.isLastPage)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        ui.AppSpacing.lg,
                        ui.AppSpacing.lg,
                        ui.AppSpacing.lg,
                        ui.AppSpacing.xl,
                      ),
                      child: ui.AppPrimaryButton(
                        label: 'Get started',
                        onPressed: _goNext,
                      ),
                    )
                  else
                    const SizedBox(height: ui.AppSpacing.xl),
                ],
              ),
            ),
          ],
        ),
      },
    );
  }
}

ui.OnboardingSlideData _toUiSlide(OnboardingSlide slide) {
  return ui.OnboardingSlideData(
    title: slide.title,
    subtitle: slide.subtitle,
    illustration: switch (slide.illustration) {
      OnboardingIllustration.pilot => ui.OnboardingIllustration.pilot,
      OnboardingIllustration.cashback => ui.OnboardingIllustration.cashback,
      OnboardingIllustration.insights => ui.OnboardingIllustration.insights,
    },
  );
}
