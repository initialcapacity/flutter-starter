

sealed class Result<T, E> {}

class Ok<T, E> implements Result<T, E> {
  const Ok(this.value);

  final T value;
}

class Err<T, E> implements Result<T, E> {
  const Err(this.error);

  final E error;
}

extension ResultExtensions<T, E> on Result<T, E> {
  Result<NewT, E> mapOk<NewT>(NewT Function(T) mapping) => switch (this) {
        Ok(value: var v) => Ok(mapping(v)),
        Err(error: var e) => Err(e),
      };

  Result<NewT, E> flatMapOk<NewT>(Result<NewT, E> Function(T) mapping) => switch (this) {
        Ok(value: var v) => mapping(v),
        Err(error: var e) => Err(e),
      };

  Result<T, NewE> mapErr<NewE>(NewE Function(E) mapping) => switch (this) {
        Ok(value: var v) => Ok(v),
        Err(error: var e) => Err(mapping(e)),
      };

  Result<T, NewE> flatMapErr<NewE>(Result<T, NewE> Function(E) mapping) => switch (this) {
        Ok(value: var v) => Ok(v),
        Err(error: var e) => mapping(e),
      };

  T orElse(T Function(E) mapping) => switch (this) {
        Ok(value: var v) => v,
        Err(error: var e) => mapping(e),
      };

  bool isOkWith(T value) => switch (this) {
        Ok(value: var v) => v == value,
        Err(error: _) => false,
      };

  bool isErrWith(E error) => switch (this) {
        Ok(value: _) => false,
        Err(error: var e) => e == error,
      };
}
