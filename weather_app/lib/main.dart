import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/app_dependencies/app_dependencies.dart';
import 'package:weather_app/app_pages/app_pages.dart';
import 'package:weather_app/networking/async_compute.dart';
import 'package:weather_app/networking/http_client_provider.dart';
import 'package:weather_app/prelude/time_source.dart';

void main() {
  runApp(Provider(
    create: (_) => AppDependencies(
      httpClientProvider: ConcreteHttpClientProvider(),
      asyncCompute: FoundationAsyncCompute(),
      timeSource: SystemTimeSource(),
    ),
    child: const App(),
  ));
}

final class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.indigo.shade900,
      brightness: MediaQuery.of(context).platformBrightness,
    );

    const textTheme = TextTheme(
      titleLarge: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 0.5),
    );

    return MaterialApp(
      title: 'Weather',
      theme: ThemeData(
        colorScheme: colorScheme,
        textTheme: textTheme,
        snackBarTheme: SnackBarThemeData(
          actionBackgroundColor: colorScheme.tertiary.withOpacity(0.8),
          actionTextColor: colorScheme.onTertiary,
          closeIconColor: colorScheme.onTertiary,
          showCloseIcon: true,
        ),
        useMaterial3: true,
      ),
      home: const AppPages(),
    );
  }
}
