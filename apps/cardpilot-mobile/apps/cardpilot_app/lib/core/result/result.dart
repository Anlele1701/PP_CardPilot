import '../errors/app_failure.dart';

sealed class Result<T> {
  const Result();

  R when<R>({
    required R Function(T data) success,
    required R Function(AppFailure failure) failure,
  }) {
    final result = this;

    return switch (result) {
      Success<T>(:final data) => success(data),
      Failure<T>(failure: final appFailure) => failure(appFailure),
    };
  }
}

class Success<T> extends Result<T> {
  const Success(this.data);

  final T data;
}

class Failure<T> extends Result<T> {
  const Failure(this.failure);

  final AppFailure failure;
}
