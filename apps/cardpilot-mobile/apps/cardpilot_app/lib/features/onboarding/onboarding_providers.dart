import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/datasources/onboarding_local_data_source.dart';
import 'data/repositories/onboarding_repository_impl.dart';
import 'domain/entities/onboarding_slide.dart';
import 'domain/repositories/onboarding_repository.dart';
import 'domain/usecases/get_onboarding_slides.dart';

enum OnboardingStatus { initial, loading, ready, failure }

class OnboardingState {
  const OnboardingState({
    required this.status,
    required this.slides,
    required this.currentPage,
    this.errorMessage,
  });

  const OnboardingState.initial()
    : status = OnboardingStatus.initial,
      slides = const [],
      currentPage = 0,
      errorMessage = null;

  final OnboardingStatus status;
  final List<OnboardingSlide> slides;
  final int currentPage;
  final String? errorMessage;

  bool get isLastPage => slides.isNotEmpty && currentPage == slides.length - 1;

  OnboardingState copyWith({
    OnboardingStatus? status,
    List<OnboardingSlide>? slides,
    int? currentPage,
    String? errorMessage,
  }) {
    return OnboardingState(
      status: status ?? this.status,
      slides: slides ?? this.slides,
      currentPage: currentPage ?? this.currentPage,
      errorMessage: errorMessage,
    );
  }
}

class OnboardingController extends Notifier<OnboardingState> {
  @override
  OnboardingState build() => const OnboardingState.initial();

  Future<void> load() async {
    if (state.status == OnboardingStatus.loading || state.slides.isNotEmpty) {
      return;
    }

    state = state.copyWith(status: OnboardingStatus.loading);

    final result = await ref.read(getOnboardingSlidesProvider)();

    result.when(
      success: (loadedSlides) {
        state = state.copyWith(
          status: OnboardingStatus.ready,
          slides: loadedSlides,
          currentPage: 0,
          errorMessage: null,
        );
      },
      failure: (failure) {
        state = state.copyWith(
          status: OnboardingStatus.failure,
          errorMessage: failure.message,
        );
      },
    );
  }

  void setCurrentPage(int page) {
    if (page == state.currentPage) {
      return;
    }
    state = state.copyWith(currentPage: page);
  }
}

final onboardingLocalDataSourceProvider = Provider<OnboardingLocalDataSource>(
  (ref) => OnboardingLocalDataSource(),
);

final onboardingRepositoryProvider = Provider<OnboardingRepository>((ref) {
  return OnboardingRepositoryImpl(
    localDataSource: ref.watch(onboardingLocalDataSourceProvider),
  );
});

final getOnboardingSlidesProvider = Provider<GetOnboardingSlides>((ref) {
  return GetOnboardingSlides(ref.watch(onboardingRepositoryProvider));
});

final onboardingControllerProvider =
    NotifierProvider.autoDispose<OnboardingController, OnboardingState>(
      OnboardingController.new,
    );
