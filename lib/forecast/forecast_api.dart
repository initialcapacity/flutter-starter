import 'package:flutter_starter/location_search/location_search_api.dart';
import 'package:flutter_starter/networking/async_compute.dart';
import 'package:flutter_starter/networking/http.dart';
import 'package:flutter_starter/networking/http_client_provider.dart';
import 'package:flutter_starter/networking/json_decoder.dart';

final class ApiForecast {
  final ApiHourlyForecast hourly;

  const ApiForecast({
    required this.hourly,
  });

  factory ApiForecast.fromJson(JsonDecoder json) => ApiForecast(
        hourly: json.field('hourly', decode: ApiHourlyForecast.fromJson),
      );
}

final class ApiHourlyForecast {
  final Iterable<DateTime> time;
  final Iterable<double> temperature;

  const ApiHourlyForecast({
    required this.time,
    required this.temperature,
  });

  factory ApiHourlyForecast.fromJson(JsonDecoder json) => ApiHourlyForecast(
        time: json.valueArray<String>('time').map(DateTime.parse).toList(),
        temperature: json.valueArray<double>('temperature_2m'),
      );
}

const forecastApiUrl = 'https://api.open-meteo.com/v1/forecast';

HttpFuture<ApiForecast> fetchForecast(
  HttpClientProvider httpClientProvider,
  AsyncCompute asyncCompute,
  ApiLocation location,
) {
  final lat = location.latitude;
  final long = location.longitude;
  final query = 'latitude=$lat&longitude=$long&hourly=temperature_2m&timezone=auto';
  final url = Uri.parse('$forecastApiUrl?$query');

  return httpClientProvider.withHttpClient((client) async {
    final httpResult = await client.sendRequest(HttpMethod.get, url);

    return httpResult.expectStatusCode(200).tryParseJson(asyncCompute, ApiForecast.fromJson);
  });
}
