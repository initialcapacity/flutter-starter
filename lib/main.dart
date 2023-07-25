import 'package:flutter/material.dart';
import 'package:flutter_starter/app_pages/app_pages.dart';
import 'package:provider/provider.dart';

import 'app_dependencies.dart';

void main() {
  runApp(Provider<AppDependencies>(
    create: (_) => DefaultAppDependencies(),
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
          behavior: SnackBarBehavior.floating,
        ),
        useMaterial3: true,
      ),
      home: const AppPages(),
    );
  }
}
