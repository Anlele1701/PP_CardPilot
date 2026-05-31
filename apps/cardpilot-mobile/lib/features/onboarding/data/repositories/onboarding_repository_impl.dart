import '../../../../core/errors/app_failure.dart';
import '../../../../core/result/result.dart';
import '../../domain/entities/onboarding_slide.dart';
import '../../domain/repositories/onboarding_repository.dart';
import '../datasources/onboarding_local_data_source.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  const OnboardingRepositoryImpl({required this.localDataSource});

  final OnboardingLocalDataSource localDataSource;

  @override
  Future<Result<List<OnboardingSlide>>> getSlides() async {
    try {
      final models = await localDataSource.getSlides();

      return Success(models.map((model) => model.toEntity()).toList());
    } on Exception {
      return const Failure(AppFailure('Unable to load onboarding content.'));
    }
  }
}
