sealed class HttpError {}

final class HttpConnectionError implements HttpError {
  const HttpConnectionError(this.exception);

  final Exception exception;
}

final class HttpUnexpectedStatusCodeError implements HttpError {
  const HttpUnexpectedStatusCodeError(this.expected, this.actual);

  final int expected;
  final int actual;
}

final class HttpDeserializationError implements HttpError {
  const HttpDeserializationError(this.error, this.responseBody);

  final TypeError error;
  final String responseBody;
}

extension HttpErrorMessage on HttpError {
  String message() => switch (this) {
        HttpConnectionError() => 'There was an error connecting',
        HttpUnexpectedStatusCodeError() => 'Unexpected response from api',
        HttpDeserializationError() => 'Failed to parse response',
      };
}
