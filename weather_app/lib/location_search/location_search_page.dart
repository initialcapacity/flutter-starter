import 'package:flutter/material.dart';
import 'package:weather_app/app_dependencies/app_dependencies.dart';
import 'package:weather_app/networking/http.dart';
import 'package:weather_app/widgets/http_future_builder.dart';

import 'location_search_api.dart';

final class LocationSearchPage extends StatefulWidget {
  final void Function(ApiLocation) onSelect;

  const LocationSearchPage({super.key, required this.onSelect});

  @override
  State<LocationSearchPage> createState() => _LocationSearchPageState();
}

final class _LocationSearchPageState extends State<LocationSearchPage> {
  HttpFuture<Iterable<ApiLocation>>? _searchFuture;
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

    return Container(
      padding: const EdgeInsets.all(16),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              child: TextField(
                controller: _searchTextEditController,
                onSubmitted: (String value) => _startSearch(value),
                autofocus: true,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: colorScheme.secondaryContainer.withOpacity(0.5),
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'e.g. Boulder, Colorado',
                ),
              ),
            ),
            _searchResultsFutureWidget(),
          ],
        ),
      ),
    );
  }

  void _startSearch(String value) {
    final appDependencies = context.appDependencies();
    setState(() {
      _searchFuture = searchLocation(
        appDependencies.httpClientProvider,
        appDependencies.asyncCompute,
        value,
      );
    });
  }

  Widget _searchResultsFutureWidget() {
    if (_searchFuture == null) {
      return const Text('');
    }

    return HttpFutureBuilder(future: _searchFuture!, builder: _loadedWidget);
  }

  Widget _loadedWidget(BuildContext context, Iterable<ApiLocation> locations) => Expanded(
        child: ListView(
          children: locations.map((location) => _searchResultRow(context, location)).toList(),
        ),
      );

  Widget _searchResultRow(BuildContext context, ApiLocation location) {
    final theme = Theme.of(context);
    final borderColor = theme.colorScheme.outline.withOpacity(0.15);

    return ListTile(
      title: Text(location.name),
      titleTextStyle: theme.textTheme.titleMedium,
      subtitle: Text(location.region),
      subtitleTextStyle: theme.textTheme.labelMedium,
      trailing: const Icon(Icons.add_circle_outline),
      shape: Border(bottom: BorderSide(color: borderColor)),
      onTap: () => widget.onSelect(location),
    );
  }
}
