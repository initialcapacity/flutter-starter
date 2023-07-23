import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_starter/app_dependencies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:provider/provider.dart';

typedef TestHttpResponse = ({String? url, int statusCode, Map<String, dynamic> body});
typedef RecordedRequest = ({String method, String url, String body});

final class TestDependencies implements AppDependencies {
  @override
  T withHttpClient<T>(T Function(Client) block) => block(_httpClient);

  @override
  Future<R> compute<M, R>(FutureOr<R> Function(M) callback, M message, {String? debugLabel}) async {
    return callback(message);
  }

  TestDependencies stub(TestHttpResponse response) {
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

  @override
  DateTime now() => DateTime.parse('2023-07-21T19:30:00');
}

extension WidgetTesterWithTestDependencies on WidgetTester {
  Future<TestDependencies> pumpWithTestDependencies(Widget widget) async {
    final testDependencies = TestDependencies();
    await pumpWidget(Provider<AppDependencies>(create: (_) => testDependencies, child: widget));
    return testDependencies;
  }
}
