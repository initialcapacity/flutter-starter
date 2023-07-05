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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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

  Widget _singleSearchResultWidget(Location location) {
    return Row(children: [
      Text('${location.name}, ${location.region}'),
    ]);
  }

  Widget _searchResultsWidget(List<Location> locations) {
    return Column(
      children: locations.map((location) => _singleSearchResultWidget(location)).toList(),
    );
  }

  Widget _searchErrorWidget(HttpError error) => Text(error.message());

  Widget _loadingWidget() => const SizedBox(width: 32, height: 32, child: CircularProgressIndicator());

  Widget _searchResultsFutureWidget() {
    if (_searchFuture == null) {
      return const Text('');
    }

    return FutureBuilder(
      future: _searchFuture!,
      builder: (context, snapshot) => switch (snapshot.data) {
        Ok(value: var locations) => _searchResultsWidget(locations),
        Err(error: var err) => _searchErrorWidget(err),
        null => _loadingWidget(),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Weather Locations'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _searchTextEditController,
              onSubmitted: (String value) => _startSearch(value),
            ),
            _searchResultsFutureWidget(),
          ],
        ),
      ),
    );
  }
}
