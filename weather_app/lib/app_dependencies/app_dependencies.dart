import 'package:flutter/widgets.dart' as widgets;
import 'package:provider/provider.dart';
import 'package:weather_app/networking/async_compute.dart';
import 'package:weather_app/networking/http_client_provider.dart';
import 'package:weather_app/prelude/time_source.dart';

final class AppDependencies {
  final HttpClientProvider httpClientProvider;
  final AsyncCompute asyncCompute;
  final TimeSource timeSource;

  AppDependencies({
    required this.httpClientProvider,
    required this.asyncCompute,
    required this.timeSource,
  });
}

extension AppDependenciesGetter on widgets.BuildContext {
  AppDependencies appDependencies() => Provider.of<AppDependencies>(this, listen: false);
}
