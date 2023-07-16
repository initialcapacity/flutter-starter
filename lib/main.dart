import 'package:flutter/material.dart';

import 'location_search_page.dart';

void main() {
  runApp(const App());
}

final class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather',
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
      home: const LocationSearchPage(),
    );
  }
}
