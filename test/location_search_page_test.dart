import 'package:flutter/material.dart';
import 'package:flutter_starter/forecast/forecast_api.dart';
import 'package:flutter_starter/location_search/location_search_api.dart';
import 'package:flutter_starter/main.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_dependencies.dart';

extension LocationSearch on WidgetTester {
  Future<void> submitSearch(String text) async {
    await enterText(find.byType(TextField), text);
    await testTextInput.receiveAction(TextInputAction.done);
  }
}

void main() {
  final validResultsJson = {
    'results': [
      {'name': 'Louisville', 'admin1': 'Kentucky', 'latitude': 38.25424, 'longitude': -85.75941},
      {'name': 'Louisville', 'admin1': 'Colorado', 'latitude': 38.77227, 'longitude': -88.50255},
    ]
  };

  final validForecastJson = {
    'hourly': {
      'time': [
        '2012-07-21T00:00:00',
        '2012-07-22T00:00:00',
        '2012-07-23T00:00:00',
        '2012-07-24T00:00:00',
        '2012-07-25T00:00:00',
      ],
      'temperature_2m': [
        30.0,
        31.0,
        32.0,
        33.0,
        34.0,
      ],
    },
  };

  final invalidResultsJson = {
    'results': [
      {'name': 1, 'region': 'Kentucky'},
      {'name': 2, 'region': 'Colorado'},
    ]
  };

  testWidgets('Search for locations', (WidgetTester tester) async {
    final testDependencies = await tester.pumpWithTestDependencies(const App());
    const searchApiUrl = 'https://geocoding-api.open-meteo.com/v1/search';
    const searchUrl = '$searchApiUrl?name=Louisville&count=10&language=en&format=json';

    expect(find.byType(TextField), findsOneWidget);

    testDependencies.stub((url: searchUrl, statusCode: 200, body: validResultsJson));

    await tester.submitSearch('Louisville');
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump();

    expect(find.text('Louisville'), findsNWidgets(3));
    expect(find.text('Colorado'), findsOneWidget);
    expect(find.text('Kentucky'), findsOneWidget);

    final lastRequest = testDependencies.lastRequest();
    expect(lastRequest, equals((method: 'GET', url: searchUrl, body: '')));
  });

  testWidgets('Search for locations, navigation to details', (WidgetTester tester) async {
    final testDependencies = await tester.pumpWithTestDependencies(const App());
    const searchUrl = '$searchApiUrl?name=Louisville&count=10&language=en&format=json';
    const forecastUrl =
        '$forecastApiUrl?latitude=38.77227&longitude=-88.50255&hourly=temperature_2m&timezone=auto';

    testDependencies.stub((url: searchUrl, statusCode: 200, body: validResultsJson)).stub(
        (url: forecastUrl, statusCode: 200, body: validForecastJson));

    await tester.submitSearch('Louisville');
    await tester.pumpAndSettle();

    await tester.tap(find.text('Colorado'));
    await tester.pumpAndSettle();

    expect(find.text('Louisville'), findsOneWidget);
    expect(find.text('5-DAY FORECAST'), findsOneWidget);
  });

  testWidgets('Search for locations, name URI encoding', (WidgetTester tester) async {
    final testDependencies = await tester.pumpWithTestDependencies(const App());

    testDependencies.stub((url: null, statusCode: 200, body: validResultsJson));

    await tester.submitSearch('Louisville Colorado');
    await tester.pumpAndSettle();

    final lastRequest = testDependencies.lastRequest();
    const uriEncodedName = 'Louisville%20Colorado';
    const expectedUrl = '$searchApiUrl?name=$uriEncodedName&count=10&language=en&format=json';
    expect(lastRequest?.url, equals(expectedUrl));
  });

  testWidgets('Search for locations, on http error', (WidgetTester tester) async {
    final testDependencies = await tester.pumpWithTestDependencies(const App());

    testDependencies.stub((url: null, statusCode: 400, body: validResultsJson));

    await tester.submitSearch('Louisville');
    await tester.pumpAndSettle();

    expect(find.text('Unexpected response from api'), findsOneWidget);
  });

  testWidgets('Search for locations, on invalid json', (WidgetTester tester) async {
    final testDependencies = await tester.pumpWithTestDependencies(const App());

    testDependencies.stub((url: null, statusCode: 200, body: invalidResultsJson));

    await tester.submitSearch('Louisville');
    await tester.pumpAndSettle();

    expect(find.text('Failed to parse response'), findsOneWidget);
  });
}
