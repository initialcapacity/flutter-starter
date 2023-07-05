import 'dart:convert';

import 'package:flutter_starter/prelude/result.dart';
import 'package:http/http.dart';

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

class HttpConnectionError implements HttpError {
  const HttpConnectionError(this.exception);

  final Exception exception;
}

class HttpUnexpectedStatusCodeError implements HttpError {
  const HttpUnexpectedStatusCodeError(this.expected, this.response);

  final int expected;
  final Response response;
}

class HttpDeserializationError implements HttpError {
  const HttpDeserializationError(this.exception, this.response);

  final Exception exception;
  final Response response;
}

extension HttpErrorMessage on HttpError {
  String message() => switch (this) {
        HttpConnectionError(exception: _) => 'There was an error connecting',
        HttpUnexpectedStatusCodeError(expected: _, response: _) => 'Unexpected response from api',
        HttpDeserializationError(exception: _) => 'Failed to parse response',
      };
}

typedef HttpResult<T> = Result<T, HttpError>;
typedef HttpFuture<T> = Future<HttpResult<T>>;

HttpFuture<Response> sendRequest(HttpMethod method, Uri url) async {
  final client = Client();

  try {
    final request = Request(method.toString(), url);
    final streamedResponse = await client.send(request);
    final response = await Response.fromStream(streamedResponse);

    return Ok(response);
  } on Exception catch (e) {
    return Err(HttpConnectionError(e));
  } finally {
    client.close();
  }
}

extension ResponseHandling on HttpResult<Response> {
  HttpResult<Response> expectStatusCode(int expected) => flatMapOk((response) {
        if (response.statusCode == expected) {
          return Ok(response);
        } else {
          return Err(HttpUnexpectedStatusCodeError(expected, response));
        }
      });

  HttpResult<T> tryParseJson<T>(T Function(Map<String, Object?>) decoder) => flatMapOk((response) {
        try {
          var json = jsonDecode(response.body);
          var object = decoder(json);
          return Ok(object);
        } on Exception catch (e) {
          return Err(HttpDeserializationError(e, response));
        }
      });
}
