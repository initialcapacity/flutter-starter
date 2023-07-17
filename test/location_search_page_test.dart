import 'package:flutter/material.dart';
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

  final invalidResultsJson = {
    'results': [
      {'name': 1, 'region': 'Kentucky'},
      {'name': 2, 'region': 'Colorado'},
    ]
  };

  testWidgets('Search for locations', (WidgetTester tester) async {
    final testDependencies = await tester.pumpWithTestDependencies(const App());

    expect(find.byType(TextField), findsOneWidget);

    testDependencies.stub((statusCode: 200, body: validResultsJson));

    await tester.submitSearch('Louisville');
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump();

    expect(find.text('Louisville'), findsNWidgets(3));
    expect(find.text('Colorado'), findsOneWidget);
    expect(find.text('Kentucky'), findsOneWidget);

    final lastRequest = testDependencies.lastRequest();
    const apiUrl = 'https://geocoding-api.open-meteo.com';
    const expectedUrl = '$apiUrl/v1/search?name=Louisville&count=10&language=en&format=json';
    expect(lastRequest, equals((method: 'GET', url: expectedUrl, body: '')));
  });

  testWidgets('Search for locations, navigation to details', (WidgetTester tester) async {
    final testDependencies = await tester.pumpWithTestDependencies(const App());

    testDependencies.stub((statusCode: 200, body: validResultsJson));

    await tester.submitSearch('Louisville');
    await tester.pumpAndSettle();

    await tester.tap(find.text('Colorado'));
    await tester.pumpAndSettle();

    expect(find.text('Location Details'), findsOneWidget);
    expect(find.text('Louisville'), findsOneWidget);
    expect(find.text('Colorado'), findsOneWidget);
  });

  testWidgets('Search for locations, name URI encoding', (WidgetTester tester) async {
    final testDependencies = await tester.pumpWithTestDependencies(const App());

    testDependencies.stub((statusCode: 200, body: validResultsJson));

    await tester.submitSearch('Louisville Colorado');
    await tester.pumpAndSettle();

    final lastRequest = testDependencies.lastRequest();
    const uriEncodedName = 'Louisville%20Colorado';
    const apiUrl = 'https://geocoding-api.open-meteo.com';
    const expectedUrl = '$apiUrl/v1/search?name=$uriEncodedName&count=10&language=en&format=json';
    expect(lastRequest?.url, equals(expectedUrl));
  });

  testWidgets('Search for locations, on http error', (WidgetTester tester) async {
    final testDependencies = await tester.pumpWithTestDependencies(const App());

    testDependencies.stub((statusCode: 400, body: validResultsJson));

    await tester.submitSearch('Louisville');
    await tester.pumpAndSettle();

    expect(find.text('Unexpected response from api'), findsOneWidget);
  });

  testWidgets('Search for locations, on invalid json', (WidgetTester tester) async {
    final testDependencies = await tester.pumpWithTestDependencies(const App());

    testDependencies.stub((statusCode: 200, body: invalidResultsJson));

    await tester.submitSearch('Louisville');
    await tester.pumpAndSettle();

    expect(find.text('Failed to parse response'), findsOneWidget);
  });
}
