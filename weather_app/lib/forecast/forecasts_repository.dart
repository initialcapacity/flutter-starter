import 'dart:collection';

import 'package:weather_app/forecast/forecast_api.dart';
import 'package:weather_app/location_search/location_search_api.dart';
import 'package:weather_app/networking/async_compute.dart';
import 'package:weather_app/networking/http.dart';
import 'package:weather_app/networking/http_client_provider.dart';

class ForecastsRepository {
  final HttpClientProvider httpClientProvider;
  final AsyncCompute asyncCompute;
  final Map<ApiLocation, HttpFuture<ApiForecast>> _cache = HashMap();

  ForecastsRepository(this.httpClientProvider, this.asyncCompute);

  HttpFuture<ApiForecast> fetch(ApiLocation location) {
    final cached = _cache[location];
    if (cached != null) {
      return cached;
    }

    final newValue = fetchForecast(
      httpClientProvider,
      asyncCompute,
      location,
    );
    _cache[location] = newValue;
    return newValue;
  }
}
