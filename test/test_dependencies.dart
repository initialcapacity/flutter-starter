import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_starter/app_dependencies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:provider/provider.dart';

typedef TestHttpResponse = ({int statusCode, Map<String, dynamic> body});
typedef RecordedRequest = ({String method, String url, String body});

class TestDependencies implements AppDependencies {
  @override
  T withHttpClient<T>(T Function(Client) block) => block(_httpClient);

  @override
  Future<R> compute<M, R>(FutureOr<R> Function(M) callback, M message, {String? debugLabel}) async {
    return callback(message);
  }

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

extension WidgetTesterWithTestDependencies on WidgetTester {
  Future<TestDependencies> pumpWithTestDependencies(Widget widget) async {
    final testDependencies = TestDependencies();
    await pumpWidget(Provider<AppDependencies>(create: (_) => testDependencies, child: widget));
    return testDependencies;
  }
}
