import '../../../../core/result/result.dart';
import '../entities/onboarding_slide.dart';

abstract interface class OnboardingRepository {
  Future<Result<List<OnboardingSlide>>> getSlides();
}
