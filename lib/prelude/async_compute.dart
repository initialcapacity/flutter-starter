import 'dart:async';

abstract class AsyncCompute {
  Future<R> compute<M, R>(FutureOr<R> Function(M) callback, M message, {String? debugLabel});
}
