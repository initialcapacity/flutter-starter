import 'package:flutter/widgets.dart';
import 'package:flutter_starter/app_dependencies.dart';
import 'package:flutter_starter/prelude/time_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'networking/test_async_compute.dart';
import 'networking/test_http_client_provider.dart';
import 'prelude/test_time_source.dart';

final class TestDependencies {
  final TestHttpClientProvider http = TestHttpClientProvider();
  final TimeSource timeSource = TestTimeSource();

  AppDependencies buildAppDependencies() => AppDependencies(
        httpClientProvider: http,
        asyncCompute: TestAsyncCompute(),
        timeSource: timeSource,
      );
}

extension WidgetTesterWithTestDependencies on WidgetTester {
  Future<TestDependencies> pumpWithTestDependencies(Widget widget) async {
    final testDependencies = TestDependencies();
    final appDependencies = testDependencies.buildAppDependencies();

    await pumpWidget(Provider(create: (_) => appDependencies, child: widget));

    return testDependencies;
  }
}
