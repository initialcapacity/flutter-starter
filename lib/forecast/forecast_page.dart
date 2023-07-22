import 'package:flutter/material.dart';
import 'package:flutter_starter/app_dependencies.dart';
import 'package:flutter_starter/location_search/location_search_api.dart';
import 'package:flutter_starter/prelude/http.dart';
import 'package:flutter_starter/widgets/card_header.dart';
import 'package:flutter_starter/widgets/http_future_builder.dart';

import 'forecast.dart';
import 'forecast_api.dart';

class ForecastPage extends StatelessWidget {
  const ForecastPage(this.location, {super.key, required this.forecastFuture});

  final ApiLocation location;
  final HttpFuture<ApiForecast> forecastFuture;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final title = location.name;

    final titleScale = switch (title.length) {
      > 22 => 1.2,
      > 18 => 1.3,
      _ => 1.5,
    };

    final additionalTitleScale = switch (title.length) {
      > 26 => 0.9,
      _ => null,
    };

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            expandedHeight: 160,
            backgroundColor: colorScheme.primaryContainer,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                title,
                style: textTheme.titleLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textScaleFactor: additionalTitleScale,
              ),
              expandedTitleScale: titleScale,
            ),
          ),
          HttpFutureBuilder(future: forecastFuture, builder: _loadedWidget, useSlivers: true),
        ],
      ),
    );
  }

  Widget _loadedWidget(BuildContext context, ApiForecast forecastJson) {
    final appDependencies = context.appDependencies();
    final forecast = Forecast.present(appDependencies, forecastJson);

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return switch (index) {
            0 => _hourlyListWidget(context, forecast),
            _ => _dailyListWidget(context, forecast),
          };
        },
        childCount: 2,
      ),
    );
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
