import 'package:flutter_starter/app_dependencies.dart';
import 'package:flutter_starter/location_search/location_search_api.dart';
import 'package:flutter_starter/prelude/http.dart';
import 'package:flutter_starter/prelude/json.dart';

final class ForecastJson {
  final HourlyForecastJson hourly;

  const ForecastJson({
    required this.hourly,
  });

  factory ForecastJson.fromJson(JsonObject json) => ForecastJson(
        hourly: json.field('hourly', decode: HourlyForecastJson.fromJson),
      );
}

final class HourlyForecastJson {
  final Iterable<DateTime> time;
  final Iterable<double> temperature;

  const HourlyForecastJson({
    required this.time,
    required this.temperature,
  });

  factory HourlyForecastJson.fromJson(JsonObject json) => HourlyForecastJson(
        time: json.valueArray<String>('time').map(DateTime.parse).toList(),
        temperature: json.valueArray<double>('temperature_2m'),
      );
}

const forecastApiUrl = 'https://api.open-meteo.com/v1/forecast';

HttpFuture<ForecastJson> fetchForecast(AppDependencies dependencies, LocationJson location) {
  final lat = location.latitude;
  final long = location.longitude;
  final query = 'latitude=$lat&longitude=$long&hourly=temperature_2m&timezone=auto';
  final url = Uri.parse('$forecastApiUrl?$query');

  return dependencies.withHttpClient((client) async {
    final httpResult = await client.sendRequest(HttpMethod.get, url);

    return httpResult.expectStatusCode(200).tryParseJson(dependencies, ForecastJson.fromJson);
  });
}
