import '../../domain/entities/onboarding_slide.dart';

class OnboardingSlideModel {
  const OnboardingSlideModel({
    required this.title,
    required this.subtitle,
    required this.illustration,
  });

  final String title;
  final String subtitle;
  final OnboardingIllustration illustration;

  OnboardingSlide toEntity() {
    return OnboardingSlide(
      title: title,
      subtitle: subtitle,
      illustration: illustration,
    );
  }
}
