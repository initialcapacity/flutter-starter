import 'package:flutter/material.dart';
import 'package:flutter_starter/app_dependencies.dart';
import 'package:flutter_starter/forecast/forecast_api.dart';
import 'package:flutter_starter/forecast/forecast_page.dart';
import 'package:flutter_starter/prelude/http.dart';
import 'package:flutter_starter/widgets/http_future_builder.dart';

import 'location_search_api.dart';

final class LocationSearchPage extends StatefulWidget {
  const LocationSearchPage({super.key});

  @override
  State<LocationSearchPage> createState() => _LocationSearchPageState();
}

final class _LocationSearchPageState extends State<LocationSearchPage> {
  HttpFuture<Iterable<LocationJson>>? _searchFuture;
  final TextEditingController _searchTextEditController = TextEditingController();

  @override
  void dispose() {
    _searchTextEditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.inversePrimary,
        title: const Text('Location Search'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            color: colorScheme.secondaryContainer,
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: TextField(
              controller: _searchTextEditController,
              onSubmitted: (String value) => _startSearch(value),
              textInputAction: TextInputAction.search,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
                hintText: 'e.g. Boulder, Colorado',
              ),
            ),
          ),
          _searchResultsFutureWidget(),
        ],
      ),
    );
  }

  void _startSearch(String value) {
    setState(() {
      _searchFuture = searchLocation(context.appDependencies(), value);
    });
  }

  Widget _searchResultsFutureWidget() {
    if (_searchFuture == null) {
      return const Text('');
    }

    return HttpFutureBuilder(future: _searchFuture!, builder: _loadedWidget);
  }

  Widget _loadedWidget(BuildContext context, Iterable<LocationJson> locations) => Expanded(
        child: ListView(
          children: locations.map((location) => _searchResultRow(context, location)).toList(),
        ),
      );

  Widget _searchResultRow(BuildContext context, LocationJson location) {
    final theme = Theme.of(context);
    final borderColor = theme.colorScheme.outline.withOpacity(0.25);

    return ListTile(
      title: Text(location.name),
      titleTextStyle: theme.textTheme.titleMedium,
      subtitle: Text(location.region),
      subtitleTextStyle: theme.textTheme.labelMedium,
      trailing: const Icon(Icons.chevron_right),
      shape: Border(bottom: BorderSide(color: borderColor)),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (ctx) {
          final appDependencies = ctx.appDependencies();

          return ForecastPage(
            location,
            forecastFuture: fetchForecast(appDependencies, location),
          );
        }),
      ),
    );
  }
}
