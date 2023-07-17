import 'dart:async';

import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

abstract class HttpClientProvider {
  T withHttpClient<T>(T Function(Client) block);
}

abstract class AsyncCompute {
  Future<R> compute<M, R>(FutureOr<R> Function(M) callback, M message, {String? debugLabel});
}

abstract class AppDependencies implements HttpClientProvider, AsyncCompute {}

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
