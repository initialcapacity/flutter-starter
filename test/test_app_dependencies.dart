import 'dart:convert';

import 'package:flutter_starter/app_dependencies.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

typedef TestHttpResponse = ({int statusCode, Map<String, dynamic> body});
typedef RecordedRequest = ({String method, String url, String body});

class TestAppDependencies implements AppDependencies {
  TestAppDependencies() {
    AppDependencies.testOverrides = this;
  }

  @override
  T withHttpClient<T>(T Function(Client) block) => block(_httpClient);

  void stub(TestHttpResponse response) {
    _response = response;
  }

  Iterable<RecordedRequest> recordedRequests() => _requests;

  RecordedRequest? lastRequest() => _requests.lastOrNull;

  TestHttpResponse _response = (statusCode: 503, body: {'error': 'Response not stubbed'});
  final _requests = <RecordedRequest>[];

  // ignore: prefer_final_fields
  late MockClient _httpClient = MockClient((request) async {
    _requests.add((method: request.method, url: request.url.toString(), body: request.body));
    return Response(jsonEncode(_response.body), _response.statusCode);
  });
}
