import 'package:cardpilot_ui/cardpilot_ui.dart' as ui;
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../mocks/onboarding_mocks.dart';

@widgetbook.UseCase(
  name: 'Interactive mock',
  type: OnboardingMockScreen,
  path: '[Screens]',
)
Widget onboardingMockScreen(BuildContext context) {
  return const OnboardingMockScreen(slides: onboardingMockSlides);
}

class OnboardingMockScreen extends StatefulWidget {
  const OnboardingMockScreen({required this.slides, super.key});

  final List<ui.OnboardingSlideData> slides;

  @override
  State<OnboardingMockScreen> createState() => _OnboardingMockScreenState();
}

class _OnboardingMockScreenState extends State<OnboardingMockScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  bool get _isLastPage => _currentPage == widget.slides.length - 1;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _goNext() async {
    if (_isLastPage) {
      return;
    }

    await _pageController.nextPage(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ui.OnboardingPageView(
              controller: _pageController,
              slides: widget.slides,
              onPageChanged: (page) => setState(() => _currentPage = page),
            ),
          ),
          SafeArea(
            top: false,
            child: Column(
              children: [
                ui.OnboardingPagination(
                  currentPage: _currentPage,
                  pageCount: widget.slides.length,
                ),
                if (_isLastPage)
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
    );
  }
}
