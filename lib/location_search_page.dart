import 'package:flutter/material.dart';
import 'package:flutter_starter/app_dependencies.dart';
import 'package:flutter_starter/location_details_page.dart';

import 'open_meteo/open_meteo_api.dart';
import 'prelude/http.dart';
import 'prelude/result.dart';

final class LocationSearchPage extends StatefulWidget {
  const LocationSearchPage({super.key});

  @override
  State<LocationSearchPage> createState() => _LocationSearchPageState();
}

final class _LocationSearchPageState extends State<LocationSearchPage> {
  HttpFuture<Iterable<Location>>? _searchFuture;
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
        title: const Text('Weather Locations'),
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

  Widget _singleSearchResultWidget(BuildContext context, Location location) {
    final theme = Theme.of(context);
    final borderColor = theme.colorScheme.outline;

    return ListTile(
      title: Text(location.name),
      titleTextStyle: theme.textTheme.titleMedium,
      subtitle: Text(location.region),
      subtitleTextStyle: theme.textTheme.labelMedium,
      shape: Border(bottom: BorderSide(color: borderColor)),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => LocationDetailsPage(location)),
      ),
    );
  }

  Widget _searchResultsWidget(BuildContext context, Iterable<Location> locations) {
    return Expanded(
      child: ListView(
        children:
            locations.map((location) => _singleSearchResultWidget(context, location)).toList(),
      ),
    );
  }

  Widget _searchErrorWidget(HttpError error) => Container(
        padding: const EdgeInsets.fromLTRB(0, 64, 0, 0),
        child: Text(error.message()),
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

  Widget _searchResultsFutureWidget() {
    if (_searchFuture == null) {
      return const Text('');
    }

    return FutureBuilder(
      future: _searchFuture!,
      builder: (context, snapshot) => switch (snapshot.data) {
        Ok(value: final locations) => _searchResultsWidget(context, locations),
        Err(error: final err) => _searchErrorWidget(err),
        null => _loadingWidget(),
      },
    );
  }
}
