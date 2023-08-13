import 'package:flutter/material.dart';
import 'package:weather_app/app_dependencies/app_dependencies.dart';
import 'package:weather_app/location_search/location_search_api.dart';
import 'package:weather_app/networking/http.dart';
import 'package:weather_app/widgets/card_header.dart';
import 'package:weather_app/widgets/http_future_builder.dart';

import 'forecast.dart';
import 'forecast_api.dart';

final class LocationForecast {
  final ApiLocation location;
  final HttpFuture<ApiForecast> forecastFuture;

  LocationForecast(this.location, this.forecastFuture);
}

final class ForecastPage extends StatelessWidget {
  const ForecastPage(this.locationForecast, {super.key});

  final LocationForecast locationForecast;

  @override
  Widget build(BuildContext context) {
    final forecastFuture = locationForecast.forecastFuture;
    return HttpFutureBuilder(future: forecastFuture, builder: _loadedWidget);
  }

  Widget _loadedWidget(BuildContext context, ApiForecast forecastJson) {
    final appDependencies = context.appDependencies();
    final forecast = Forecast.present(
      appDependencies.timeSource,
      forecastJson,
    );

    return Column(children: [
      _hourlyListWidget(context, forecast),
      _dailyListWidget(context, forecast),
    ]);
  }

  Widget _hourlyListWidget(BuildContext context, Forecast forecast) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CardHeader(forecast.today),
          Card(
            color: colorScheme.secondaryContainer,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: forecast.hourly.map((hourly) => _hourlyWidget(context, hourly)).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _hourlyWidget(BuildContext context, HourlyForecast hourly) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(hourly.time, style: textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(hourly.temperature, style: textTheme.bodyLarge),
        ],
      ),
    );
  }

  Widget _dailyListWidget(BuildContext context, Forecast forecast) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const CardHeader('5-day forecast'),
          Card(
            color: colorScheme.secondaryContainer,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(children: forecast.daily.map((d) => _dailyWidget(context, d)).toList()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dailyWidget(BuildContext context, DailyForecast daily) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(daily.day, style: textTheme.titleMedium),
          ),
          SizedBox(
            width: 40,
            child: Text(daily.min, textAlign: TextAlign.start, style: textTheme.bodyLarge),
          ),
          SizedBox(
            width: 40,
            child: Text(daily.max, textAlign: TextAlign.end, style: textTheme.bodyLarge),
          ),
        ],
      ),
    );
  }
}
