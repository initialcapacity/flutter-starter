import 'dart:async';

import 'package:flutter/foundation.dart' as foundation;
import 'package:http/http.dart';

class AppDependencies {
  const AppDependencies._create();

  static const AppDependencies _shared = AppDependencies._create();
  static AppDependencies? testOverrides;

  factory AppDependencies.shared() {
    return testOverrides ?? _shared;
  }

  T withHttpClient<T>(T Function(Client) block) {
    final client = Client();
    try {
      return block(client);
    } finally {
      client.close();
    }
  }

  Future<R> compute<M, R>(FutureOr<R> Function(M) callback, M message, {String? debugLabel}) {
    return foundation.compute<M, R>(callback, message, debugLabel: debugLabel);
  }
}
