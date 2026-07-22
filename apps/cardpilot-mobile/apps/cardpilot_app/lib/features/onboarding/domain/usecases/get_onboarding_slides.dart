import '../../../../core/result/result.dart';
import '../entities/onboarding_slide.dart';
import '../repositories/onboarding_repository.dart';

class GetOnboardingSlides {
  const GetOnboardingSlides(this.repository);

  final OnboardingRepository repository;

  Future<Result<List<OnboardingSlide>>> call() {
    return repository.getSlides();
  }
}
