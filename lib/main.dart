import 'package:flutter/material.dart';
import 'package:flutter_starter/prelude/result.dart';

import 'prelude/http.dart' as http;

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
  String _searchResult = '';

  late TextEditingController _searchTextEditController;

  @override
  void initState() {
    super.initState();
    _searchTextEditController = TextEditingController();
  }

  @override
  void dispose() {
    _searchTextEditController.dispose();
    super.dispose();
  }

  Future<void> _startSearch(String value) async {
    // TODO uri encode value

    var apiResult = await http.sendRequest(http.HttpMethod.get,
        Uri.parse('https://geocoding-api.open-meteo.com/v1/search?name=$value&count=10&language=en&format=json'));

    var newSearchResult = apiResult.mapOk((response) => response.body).orElse((_) => 'There was an error');

    setState(() {
      _searchResult = newSearchResult;
    });
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
            Text('Search result: $_searchResult'),
          ],
        ),
      ),
    );
  }
}
