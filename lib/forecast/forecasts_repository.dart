import 'dart:collection';

import 'package:flutter_starter/forecast/forecast_api.dart';
import 'package:flutter_starter/location_search/location_search_api.dart';
import 'package:flutter_starter/networking/async_compute.dart';
import 'package:flutter_starter/networking/http.dart';
import 'package:flutter_starter/networking/http_client_provider.dart';

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
