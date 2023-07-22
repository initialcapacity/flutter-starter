import 'package:flutter/material.dart';
import 'package:flutter_starter/location_search/location_search_api.dart';
import 'package:flutter_starter/main.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_dependencies.dart';
import 'location_search_api_builders.dart';
import 'location_search_page_object.dart';

void main() {
  testWidgets('Search for locations', (WidgetTester tester) async {
    final testDependencies = await tester.pumpWithTestDependencies(const App());
    const searchApiUrl = 'https://geocoding-api.open-meteo.com/v1/search';
    const searchUrl = '$searchApiUrl?name=Louisville&count=10&language=en&format=json';

    expect(find.byType(TextField), findsOneWidget);

    testDependencies.stub((
      url: searchUrl,
      statusCode: 200,
      body: buildLocationSearchJson(),
    ));

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

  testWidgets('Search for locations, name URI encoding', (WidgetTester tester) async {
    final testDependencies = await tester.pumpWithTestDependencies(const App());

    testDependencies.stub((url: null, statusCode: 200, body: buildLocationSearchJson()));

    await tester.submitSearch('Louisville Colorado');
    await tester.pumpAndSettle();

    final lastRequest = testDependencies.lastRequest();
    const uriEncodedName = 'Louisville%20Colorado';
    const expectedUrl = '$searchApiUrl?name=$uriEncodedName&count=10&language=en&format=json';
    expect(lastRequest?.url, equals(expectedUrl));
  });

  testWidgets('Search for locations, on http error', (WidgetTester tester) async {
    final testDependencies = await tester.pumpWithTestDependencies(const App());

    testDependencies.stub((url: null, statusCode: 400, body: buildLocationSearchJson()));

    await tester.submitSearch('Louisville');
    await tester.pumpAndSettle();

    expect(find.text('Unexpected response from api'), findsOneWidget);
  });

  testWidgets('Search for locations, on invalid json', (WidgetTester tester) async {
    final invalidResultsJson = {
      'results': [
        {'name': 1, 'region': 'Kentucky'},
        {'name': 2, 'region': 'Colorado'},
      ]
    };

    final testDependencies = await tester.pumpWithTestDependencies(const App());

    testDependencies.stub((url: null, statusCode: 200, body: invalidResultsJson));

    await tester.submitSearch('Louisville');
    await tester.pumpAndSettle();

    expect(find.text('Failed to parse response'), findsOneWidget);
  });
}
