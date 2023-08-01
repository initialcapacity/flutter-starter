import 'dart:async';

import 'package:flutter/foundation.dart' as foundation;

abstract class AsyncCompute {
  Future<R> compute<M, R>(FutureOr<R> Function(M) callback, M message, {String? debugLabel});
}

class FoundationAsyncCompute implements AsyncCompute {
  @override
  Future<R> compute<M, R>(FutureOr<R> Function(M) callback, M message, {String? debugLabel}) {
    return foundation.compute<M, R>(callback, message, debugLabel: debugLabel);
  }
}
