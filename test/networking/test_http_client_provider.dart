import 'dart:convert';

import 'package:flutter_starter/networking/http_client_provider.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

typedef TestHttpResponse = ({String? url, int statusCode, Map<String, dynamic> body});
typedef RecordedRequest = ({String method, String url, String body});

class TestHttpClientProvider implements HttpClientProvider {
  @override
  T withHttpClient<T>(T Function(Client client) block) => block(_httpClient);

  TestHttpClientProvider stub(TestHttpResponse response) {
    _responses.add(response);
    return this;
  }

  Iterable<RecordedRequest> recordedRequests() => _requests;

  RecordedRequest? lastRequest() => _requests.lastOrNull;

  final List<TestHttpResponse> _responses = [];
  final TestHttpResponse _defaultResponse = (
    url: null,
    statusCode: 503,
    body: {'error': 'Response not stubbed'},
  );
  final _requests = <RecordedRequest>[];

  // ignore: prefer_final_fields
  late MockClient _httpClient = MockClient((request) async {
    _requests.add((method: request.method, url: request.url.toString(), body: request.body));

    final response = _responses.firstWhere(
      (r) => r.url == null || r.url == request.url.toString(),
      orElse: () => _defaultResponse,
    );

    return Response(jsonEncode(response.body), response.statusCode);
  });
}
