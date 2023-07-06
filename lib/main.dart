import 'package:flutter/material.dart';
import 'package:flutter_starter/prelude/result.dart';

import 'open_meteo/open_meteo_api.dart';
import 'prelude/http.dart' as http;
import 'prelude/http.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo.shade900,
          brightness: MediaQuery.of(context).platformBrightness,
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontWeight: FontWeight.w500, letterSpacing: 0.5),
        ),
        useMaterial3: true,
      ),
      home: const LocationsPage(),
    );
  }
}

class LocationsPage extends StatefulWidget {
  const LocationsPage({super.key});

  @override
  State<LocationsPage> createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  late HttpFuture<List<Location>>? _searchFuture;
  late TextEditingController _searchTextEditController;

  @override
  void initState() {
    super.initState();
    _searchFuture = null;
    _searchTextEditController = TextEditingController();
  }

  @override
  void dispose() {
    _searchTextEditController.dispose();
    super.dispose();
  }

  Future<void> _startSearch(String value) async {
    setState(() {
      _searchFuture = searchLocation(value);
    });
  }

  Widget _singleSearchResultWidget(BuildContext context, Location location) {
    var theme = Theme.of(context);
    var borderColor = theme.colorScheme.outline;

    return ListTile(
      title: Text(location.name),
      titleTextStyle: theme.textTheme.titleMedium,
      subtitle: Text(location.region),
      subtitleTextStyle: theme.textTheme.labelMedium,
      shape: Border(bottom: BorderSide(color: borderColor)),
    );
  }

  Widget _searchResultsWidget(BuildContext context, List<Location> locations) {
    return Expanded(
      child: ListView(
        children: locations.map((location) => _singleSearchResultWidget(context, location)).toList(),
      ),
    );
  }

  Widget _searchErrorWidget(HttpError error) => Text(error.message());

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
        Ok(value: var locations) => _searchResultsWidget(context, locations),
        Err(error: var err) => _searchErrorWidget(err),
        null => _loadingWidget(),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var colorScheme = theme.colorScheme;

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
}
