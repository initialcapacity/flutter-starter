import 'package:flutter/material.dart';
import 'package:weather_app/networking/http.dart';
import 'package:weather_app/networking/http_error.dart';
import 'package:weather_app/prelude/result.dart';

final class HttpFutureBuilder<T> extends StatelessWidget {
  final HttpFuture<T> future;
  final Widget Function(BuildContext context, T value) builder;
  final bool useSlivers;

  const HttpFutureBuilder(
      {super.key, required this.future, required this.builder, this.useSlivers = false});

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: future,
        builder: (context, snapshot) => switch (snapshot.data) {
          null => _loadingWidget(),
          Ok(:final value) => builder(context, value),
          Err(:final error) => _errorWidget(error),
        },
      );

  Widget _loadingWidget() {
    if (useSlivers) {
      return SliverToBoxAdapter(child: _loadingWidgetWithoutSliver());
    } else {
      return _loadingWidgetWithoutSliver();
    }
  }

  Widget _loadingWidgetWithoutSliver() => Container(
        height: 160,
        alignment: Alignment.center,
        child: const SizedBox(width: 32, height: 32, child: CircularProgressIndicator()),
      );

  Widget _errorWidget(HttpError error) {
    if (useSlivers) {
      return SliverToBoxAdapter(child: _errorWidgetWithoutSliver(error));
    } else {
      return _errorWidgetWithoutSliver(error);
    }
  }

  Widget _errorWidgetWithoutSliver(HttpError error) => Container(
        height: 160,
        alignment: Alignment.center,
        child: Text(error.message()),
      );
}
