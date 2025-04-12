import 'package:toeic/utils/app_exception.dart';

sealed class Result<T> {
  const Result();

  const factory Result.ok(T value) = Ok<T>;
  const factory Result.error(AppException error) = Error<T>;
}

final class Ok<T> extends Result<T> {
  final T value;
  const Ok(this.value);

  @override
  String toString() => 'Ok($value)';
}

final class Error<T> extends Result<T> {
  final AppException error;
  const Error(this.error);

  @override
  String toString() => 'Error: $error';
}
