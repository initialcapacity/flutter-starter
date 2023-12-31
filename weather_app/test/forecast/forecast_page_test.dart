import 'package:weather_app/forecast/forecast_api.dart';
import 'package:weather_app/location_search/location_search_api.dart';
import 'package:weather_app/main.dart';
import 'package:flutter_test/flutter_test.dart';

import '../location_search/location_search_api_builders.dart';
import '../location_search/location_search_page_object.dart';
import '../test_dependencies.dart';
import 'forecast_api_builders.dart';
import 'forecast_page_object.dart';

void main() {
  testWidgets('Navigate to forecast from search', (WidgetTester tester) async {
    final testDependencies = await tester.pumpWithTestDependencies(const App());

    const searchUrl = '$searchApiUrl'
        '?name=Louisville'
        '&count=10'
        '&language=en'
        '&format=json';

    const forecastUrl = '$forecastApiUrl'
        '?latitude=38.77227'
        '&longitude=-88.50255'
        '&hourly=temperature_2m'
        '&timezone=auto';

    testDependencies.http.stub((
      url: searchUrl,
      statusCode: 200,
      body: buildLocationSearchJson(),
    )).stub((
      url: forecastUrl,
      statusCode: 200,
      body: buildForecastJson(),
    ));

    await tester.goToSearch();
    await tester.submitSearch('Louisville');

    await tester.tap(find.text('Colorado'));
    await tester.pumpAndSettle();

    expect(find.text('Louisville'), findsOneWidget);
    expect(find.text('5-DAY FORECAST'), findsOneWidget);
  });
}
