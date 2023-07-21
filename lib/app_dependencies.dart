import 'dart:async';

import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/widgets.dart';
import 'package:flutter_starter/prelude/async_compute.dart';
import 'package:flutter_starter/prelude/http.dart' as http;
import 'package:http/http.dart';
import 'package:provider/provider.dart';

abstract class AppDependencies implements http.HttpClientProvider, AsyncCompute {}

final class DefaultAppDependencies implements AppDependencies {
  @override
  T withHttpClient<T>(T Function(Client) block) {
    final client = Client();
    try {
      return block(client);
    } finally {
      client.close();
    }
  }

  @override
  Future<R> compute<M, R>(FutureOr<R> Function(M) callback, M message, {String? debugLabel}) {
    return foundation.compute<M, R>(callback, message, debugLabel: debugLabel);
  }
}

extension AppDependenciesGetter on BuildContext {
  AppDependencies appDependencies() => Provider.of<AppDependencies>(this, listen: false);
}
