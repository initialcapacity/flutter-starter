import 'package:flutter_starter/prelude/http_error.dart';
import 'package:flutter_starter/prelude/result.dart';
import 'package:http/http.dart' as http;

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

Future<Result<http.Response, HttpError>> sendRequest(HttpMethod method, Uri url) async {
  final client = http.Client();

  try {
    final request = http.Request(method.toString(), url);
    final streamedResponse = await client.send(request);
    final response = await http.Response.fromStream(streamedResponse);

    return Ok(response);
  } on Exception catch (e) {
    return Err(HttpConnectionError(e));
  } finally {
    client.close();
  }
}
