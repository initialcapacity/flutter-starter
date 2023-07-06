import 'dart:convert';

import 'package:flutter_starter/main.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

typedef TestHttpResponse = ({int statusCode, Map<String, dynamic> body});

class TestAppDependencies implements AppDependencies {
  TestAppDependencies() {
    AppDependencies.testOverrides = this;
  }

  late MockClient httpClient = MockClient(handler);

  TestHttpResponse _response = (statusCode: 503, body: {'error': 'Response not stubbed'});

  @override
  Client getHttpClient() => httpClient;

  void stub(TestHttpResponse response) {
    _response = response;
  }

  Future<Response> handler(Request request) async {
    return Response(jsonEncode(_response.body), _response.statusCode);
  }
}
