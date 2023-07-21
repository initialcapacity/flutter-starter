import 'package:flutter/material.dart';
import 'package:flutter_starter/prelude/http.dart';
import 'package:flutter_starter/prelude/result.dart';

final class HttpFutureBuilder<T> extends StatelessWidget {
  final HttpFuture<T> future;
  final Widget Function(BuildContext context, T value) builder;

  const HttpFutureBuilder({super.key, required this.future, required this.builder});

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: future,
        builder: (context, snapshot) => switch (snapshot.data) {
          null => _loadingWidget(),
          Ok(value: final value) => builder(context, value),
          Err(error: final err) => _errorWidget(err),
        },
      );

  Widget _loadingWidget() => Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 128),
              child: const SizedBox(width: 32, height: 32, child: CircularProgressIndicator()),
            ),
          ],
        ),
      );

  Widget _errorWidget(HttpError error) => Container(
        padding: const EdgeInsets.fromLTRB(0, 64, 0, 0),
        child: Text(error.message()),
      );
}
