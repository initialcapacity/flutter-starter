import 'package:flutter/widgets.dart' as widgets;
import 'package:flutter_starter/networking/async_compute.dart';
import 'package:flutter_starter/networking/http_client_provider.dart';
import 'package:flutter_starter/prelude/time_source.dart';
import 'package:provider/provider.dart';

final class AppDependencies {
  final HttpClientProvider httpClientProvider;
  final AsyncCompute asyncCompute;
  final TimeSource timeSource;

  AppDependencies(
      {required this.httpClientProvider, required this.asyncCompute, required this.timeSource});
}

extension AppDependenciesGetter on widgets.BuildContext {
  AppDependencies appDependencies() => Provider.of<AppDependencies>(this, listen: false);
}
