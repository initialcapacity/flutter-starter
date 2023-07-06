import 'package:flutter/material.dart';
import 'package:flutter_starter/main.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_app_dependencies.dart';

void main() {
  var testDependencies = TestAppDependencies();

  testWidgets('Search for locations', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byType(TextField), findsOneWidget);

    testDependencies.stub((
      statusCode: 200,
      body: {
        'results': [
          {'name': 'Louisville', 'admin1': 'Kentucky', 'latitude': 38.25424, 'longitude': -85.75941},
          {
            'name': 'Louisville',
            'admin1': 'Colorado',
            'latitude': 38.77227,
            'longitude': -88.50255,
          },
        ]
      }
    ));

    await tester.enterText(find.byType(TextField), 'Louisville');
    await tester.testTextInput.receiveAction(TextInputAction.done);

    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump();

    expect(find.text('Louisville'), findsNWidgets(3));
    expect(find.text('Colorado'), findsOneWidget);
    expect(find.text('Kentucky'), findsOneWidget);
  });
}
