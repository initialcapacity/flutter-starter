import 'package:flutter_starter/app_dependencies.dart';
import 'package:http/http.dart';

import 'json.dart';
import 'result.dart';

enum HttpMethod {
  get,
  post,
  put,
  delete;

  @override
  String toString() => switch (this) {
        get => 'GET',
        post => 'POST',
        put => 'PUT',
        delete => 'DELETE',
      };
}

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

typedef HttpResult<T> = Result<T, HttpError>;
typedef HttpFuture<T> = Future<HttpResult<T>>;

extension SendRequest on Client {
  HttpFuture<Response> sendRequest(HttpMethod method, Uri url) async {
    try {
      final request = Request(method.toString(), url);
      final streamedResponse = await send(request);
      final response = await Response.fromStream(streamedResponse);

      return Ok(response);
    } on Exception catch (e) {
      return Err(HttpConnectionError(e));
    }
  }
}

extension ResponseHandling on HttpResult<Response> {
  HttpResult<Response> expectStatusCode(int expected) => flatMapOk((response) {
        if (response.statusCode == expected) {
          return Ok(response);
        } else {
          return Err(HttpUnexpectedStatusCodeError(expected, response.statusCode));
        }
      });

  HttpFuture<T> tryParseJson<T>(AsyncCompute async, JsonDecode<T> decode) async {
    return switch (this) {
      Ok(value: final response) => async.compute(
          (response) {
            try {
              final jsonObject = JsonObject.fromString(response.body);
              final object = decode(jsonObject);
              return Ok(object);
            } on TypeError catch (e) {
              return Err(HttpDeserializationError(e, response.body));
            }
          },
          response,
        ),
      Err(error: final error) => Future.value(Err(error)),
    };
  }
}
