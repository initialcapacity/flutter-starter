import 'package:flutter_starter/app_dependencies.dart';
import 'package:flutter_starter/location_search/location_search_api.dart';
import 'package:flutter_starter/prelude/http.dart';
import 'package:flutter_starter/prelude/json.dart';

final class Forecast {
  final HourlyForecast hourly;

  const Forecast({
    required this.hourly,
  });

  factory Forecast.fromJson(JsonObject json) => Forecast(
        hourly: json.field('hourly', decode: HourlyForecast.fromJson),
      );
}

final class HourlyForecast {
  final Iterable<String> time;
  final Iterable<double> temperature;

  const HourlyForecast({
    required this.time,
    required this.temperature,
  });

  factory HourlyForecast.fromJson(JsonObject json) => HourlyForecast(
        time: json.valueArray<String>('time'),
        temperature: json.valueArray<double>('temperature_2m'),
      );
}

const _forecastApiUrl = 'https://api.open-meteo.com/v1/forecast';

HttpFuture<Forecast> fetchForecast(AppDependencies dependencies, Location location) {
  final lat = location.latitude;
  final long = location.longitude;
  final query = 'latitude=$lat&longitude=$long&hourly=temperature_2m';
  final url = Uri.parse('$_forecastApiUrl?$query');

  return dependencies.withHttpClient((client) async {
    final httpResult = await client.sendRequest(HttpMethod.get, url);

    return httpResult.expectStatusCode(200).tryParseJson(dependencies, Forecast.fromJson);
  });
}
