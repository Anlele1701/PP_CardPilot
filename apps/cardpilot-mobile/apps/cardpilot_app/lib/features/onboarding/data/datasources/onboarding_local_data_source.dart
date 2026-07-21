import '../models/onboarding_slide_model.dart';
import '../../domain/entities/onboarding_slide.dart';

class OnboardingLocalDataSource {
  Future<List<OnboardingSlideModel>> getSlides() async {
    return const [
      OnboardingSlideModel(
        title: 'CardPilot',
        subtitle: 'Smart cashback tracking for smarter spending',
        illustration: OnboardingIllustration.pilot,
      ),
      OnboardingSlideModel(
        title: 'Track every card benefit',
        subtitle: 'Know which card gives you the best value before you pay.',
        illustration: OnboardingIllustration.cashback,
      ),
      OnboardingSlideModel(
        title: 'AI insights for your wallet',
        subtitle: 'Turn spending patterns into simple next-best actions.',
        illustration: OnboardingIllustration.insights,
      ),
    ];
  }
}
