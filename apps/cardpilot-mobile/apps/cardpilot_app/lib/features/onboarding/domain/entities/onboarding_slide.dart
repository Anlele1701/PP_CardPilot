class OnboardingSlide {
  const OnboardingSlide({
    required this.title,
    required this.subtitle,
    required this.illustration,
  });

  final String title;
  final String subtitle;
  final OnboardingIllustration illustration;
}

enum OnboardingIllustration { pilot, cashback, insights }
