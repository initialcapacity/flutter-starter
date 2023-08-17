sealed class Result<T, E> {}

final class Ok<T, E> implements Result<T, E> {
  const Ok(this.value);

  final T value;
}

final class Err<T, E> implements Result<T, E> {
  const Err(this.error);

  final E error;
}

extension ResultExtensions<T, E> on Result<T, E> {
  Result<NewT, E> mapOk<NewT>(NewT Function(T) mapping) => switch (this) {
        Ok(:final value) => Ok(mapping(value)),
        Err(:final error) => Err(error),
      };

  Result<NewT, E> flatMapOk<NewT>(Result<NewT, E> Function(T) mapping) => switch (this) {
        Ok(:final value) => mapping(value),
        Err(:final error) => Err(error),
      };

  Result<T, NewE> mapErr<NewE>(NewE Function(E) mapping) => switch (this) {
        Ok(:final value) => Ok(value),
        Err(:final error) => Err(mapping(error)),
      };

  Result<T, NewE> flatMapErr<NewE>(Result<T, NewE> Function(E) mapping) => switch (this) {
        Ok(:final value) => Ok(value),
        Err(:final error) => mapping(error),
      };

  T orElse(T Function(E) mapping) => switch (this) {
        Ok(:final value) => value,
        Err(:final error) => mapping(error),
      };

  bool isOkWith(T expectedValue) => switch (this) {
        Ok(:final value) => value == expectedValue,
        Err(error: _) => false,
      };

  bool isErrWith(E expectedError) => switch (this) {
        Ok(value: _) => false,
        Err(:final error) => error == expectedError,
      };
}
