import 'dart:collection';

import 'package:flutter_starter/app_dependencies.dart';
import 'package:flutter_starter/forecast/forecast_api.dart';
import 'package:flutter_starter/location_search/location_search_api.dart';
import 'package:flutter_starter/prelude/http.dart';

class ForecastsRepository {
  final AppDependencies dependencies;
  final Map<ApiLocation, HttpFuture<ApiForecast>> _cache = HashMap();

  ForecastsRepository(this.dependencies);

  HttpFuture<ApiForecast> fetch(ApiLocation location) {
    final cached = _cache[location];
    if (cached != null) {
      return cached;
    }

    final newValue = fetchForecast(dependencies, location);
    _cache[location] = newValue;
    return newValue;
  }
}
