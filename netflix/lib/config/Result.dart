import 'package:netflix/Network/APIResponse.dart';

class Result<T> {
  Result._();

  factory Result.loading(bool isLoading) = Loading<T>;

  factory Result.success(T value) = SuccessState<T>;

  factory Result.error(ErrorResponse error) = ErrorState<T>;
}

class Loading<T> extends Result<T> {
  Loading(this.isLoading) : super._();
  final bool isLoading;
}


class ErrorState<T> extends Result<T> {
  ErrorState(this.error) : super._();
  final ErrorResponse error;
}

class SuccessState<T> extends Result<T> {
  SuccessState(this.value) : super._();
  final T value;
}
