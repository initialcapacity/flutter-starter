sealed class HttpError {}

class HttpConnectionError implements HttpError {
  const HttpConnectionError(this.exception);

  final Exception exception;
}

class HttpUnexpectedStatusCodeError implements HttpError {
  const HttpUnexpectedStatusCodeError({required this.expected, required this.actual});

  final int expected;
  final int actual;
}

class HttpDeserializationError implements HttpError {}
