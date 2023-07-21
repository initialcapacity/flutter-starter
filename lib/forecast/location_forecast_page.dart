import 'package:flutter/material.dart';
import 'package:flutter_starter/location_search/location_search_api.dart';
import 'package:flutter_starter/prelude/http.dart';
import 'package:flutter_starter/widgets/http_future_builder.dart';

import 'forecast_api.dart';
import 'forecast_presenter.dart';

class LocationForecastPage extends StatelessWidget {
  const LocationForecastPage(this.location, {super.key, required this.forecastFuture});

  final Location location;
  final HttpFuture<Forecast> forecastFuture;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.inversePrimary,
        title: const Text('Location Details'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(location.name, style: textTheme.titleMedium),
          Text(location.region, style: textTheme.labelMedium),
          HttpFutureBuilder(future: forecastFuture, builder: _loadedWidget),
        ],
      ),
    );
  }

  Widget _loadedWidget(BuildContext context, Forecast forecast) {
    final presenter = ForecastPresenter.present(forecast);

    return Expanded(
      child: ListView(
        children: presenter.rows.map((row) => _forecastRow(context, row)).toList(),
      ),
    );
  }

  Widget _forecastRow(BuildContext context, ForecastPresenterRow row) {
    final theme = Theme.of(context);
    final borderColor = theme.colorScheme.outline;

    return ListTile(
      title: Text(row.time),
      titleTextStyle: theme.textTheme.titleMedium,
      subtitle: Text(row.temperature.toString()),
      subtitleTextStyle: theme.textTheme.labelMedium,
      shape: Border(bottom: BorderSide(color: borderColor)),
    );
  }
}
