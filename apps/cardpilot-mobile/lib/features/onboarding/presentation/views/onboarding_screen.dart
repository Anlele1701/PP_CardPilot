import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../onboarding_providers.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/onboarding_page_view.dart';
import '../widgets/onboarding_pagination.dart';

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
      // TODO(app): Replace with your real "after onboarding" route.
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Onboarding complete.')),
      );
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
              padding: const EdgeInsets.all(AppSpacing.lg),
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
              child: OnboardingPageView(
                controller: _pageController,
                slides: state.slides,
                onPageChanged: controller.setCurrentPage,
              ),
            ),
            SafeArea(
              top: false,
              child: Column(
                children: [
                  OnboardingPagination(
                    currentPage: state.currentPage,
                    pageCount: state.slides.length,
                  ),
                  if (state.isLastPage)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.lg,
                        AppSpacing.lg,
                        AppSpacing.lg,
                        AppSpacing.xl,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.brandBlue,
                            padding: const EdgeInsets.symmetric(
                              vertical: AppSpacing.md,
                            ),
                          ),
                          onPressed: _goNext,
                          child: const Text('Get started'),
                        ),
                      ),
                    )
                  else
                    const SizedBox(height: AppSpacing.xl),
                ],
              ),
            ),
          ],
        ),
      },
    );
  }
}
