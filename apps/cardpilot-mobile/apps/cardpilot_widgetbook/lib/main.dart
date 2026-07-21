import 'package:cardpilot_ui/cardpilot_ui.dart' as ui;
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'mocks/onboarding_mocks.dart';

void main() {
  runApp(const CardPilotWidgetbook());
}

class CardPilotWidgetbook extends StatelessWidget {
  const CardPilotWidgetbook({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      addons: [
        ViewportAddon([
          IosViewports.iPhone13,
          IosViewports.iPhoneSE,
          AndroidViewports.samsungGalaxyS20,
          AndroidViewports.smallTablet,
        ]),
        MaterialThemeAddon(
          themes: [
            WidgetbookTheme(name: 'Light', data: ui.AppTheme.light),
            WidgetbookTheme(name: 'Dark', data: ui.AppTheme.dark),
          ],
        ),
      ],
      directories: [
        WidgetbookCategory(
          name: 'Components',
          children: [
            WidgetbookComponent(
              name: 'Primary button',
              useCases: [
                WidgetbookUseCase(
                  name: 'Enabled',
                  builder: (_) => _componentCanvas(
                    ui.AppPrimaryButton(label: 'Get started', onPressed: () {}),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'Disabled',
                  builder: (_) => _componentCanvas(
                    const ui.AppPrimaryButton(
                      label: 'Get started',
                      onPressed: null,
                    ),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'Loading',
                  builder: (_) => _componentCanvas(
                    ui.AppPrimaryButton(
                      label: 'Get started',
                      isLoading: true,
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'Onboarding pagination',
              useCases: List.generate(
                3,
                (index) => WidgetbookUseCase(
                  name: 'Page ${index + 1}',
                  builder: (_) => Center(
                    child: ui.OnboardingPagination(
                      currentPage: index,
                      pageCount: 3,
                    ),
                  ),
                ),
              ),
            ),
            WidgetbookComponent(
              name: 'Onboarding illustration',
              useCases: ui.OnboardingIllustration.values
                  .map(
                    (illustration) => WidgetbookUseCase(
                      name: illustration.name,
                      builder: (_) => Center(
                        child: SizedBox(
                          width: 390,
                          height: 360,
                          child: ui.OnboardingHeroIllustration(
                            illustration: illustration,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
        WidgetbookCategory(
          name: 'Screens',
          children: [
            WidgetbookComponent(
              name: 'Onboarding',
              useCases: [
                WidgetbookUseCase(
                  name: 'Interactive mock',
                  builder: (_) =>
                      const _OnboardingMockScreen(slides: onboardingMockSlides),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _OnboardingMockScreen extends StatefulWidget {
  const _OnboardingMockScreen({required this.slides});

  final List<ui.OnboardingSlideData> slides;

  @override
  State<_OnboardingMockScreen> createState() => _OnboardingMockScreenState();
}

class _OnboardingMockScreenState extends State<_OnboardingMockScreen> {
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

Widget _componentCanvas(Widget child) {
  return Scaffold(
    body: Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 320),
          child: child,
        ),
      ),
    ),
  );
}
