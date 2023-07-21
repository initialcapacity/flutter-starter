import 'package:flutter/material.dart';
import 'package:flutter_starter/location_search/location_search_api.dart';
import 'package:flutter_starter/prelude/http.dart';
import 'package:flutter_starter/widgets/http_future_builder.dart';
import 'package:flutter_starter/widgets/sliver_list.dart';

import 'forecast.dart';
import 'forecast_api.dart';

class ForecastPage extends StatelessWidget {
  const ForecastPage(this.location, {super.key, required this.forecastFuture});

  final LocationJson location;
  final HttpFuture<ForecastJson> forecastFuture;

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
      backgroundColor: colorScheme.secondaryContainer,
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
          SliverToBoxAdapter(
            child: Container(
              height: 50,
              alignment: Alignment.center,
              child: Text(
                location.region,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.titleMedium,
                textScaleFactor: 1.2,
              ),
            ),
          ),
          HttpFutureBuilder(future: forecastFuture, builder: _loadedWidget, useSlivers: true),
        ],
      ),
    );
  }

  Widget _loadedWidget(BuildContext context, ForecastJson forecastJson) {
    final forecast = Forecast.present(forecastJson);

    return sliverListFromList(forecast.hourly, _hourlyRow);
  }

  Widget _hourlyRow(BuildContext context, HourlyForecast hourly) {
    final theme = Theme.of(context);
    final borderColor = theme.colorScheme.outline;

    return ListTile(
      title: Text(hourly.time),
      titleTextStyle: theme.textTheme.titleMedium,
      subtitle: Text(hourly.temperature.toString()),
      subtitleTextStyle: theme.textTheme.labelMedium,
      shape: Border(bottom: BorderSide(color: borderColor)),
      tileColor: theme.colorScheme.background,
    );
  }
}
