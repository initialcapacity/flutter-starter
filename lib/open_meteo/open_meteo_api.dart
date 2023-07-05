import 'package:flutter_starter/prelude/http.dart';
import 'package:flutter_starter/prelude/http.dart' as http;
import 'package:flutter_starter/prelude/result.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'open_meteo_api.freezed.dart';
part 'open_meteo_api.g.dart';

@freezed
class Location with _$Location {
  const factory Location({
    required String name,
    required double latitude,
    required double longitude,
    @JsonKey(name: 'admin1') required String region,
  }) = _Location;

  factory Location.fromJson(Map<String, Object?> json) => _$LocationFromJson(json);
}

@freezed
class _LocationResults with _$_LocationResults {
  const factory _LocationResults({
    required List<Location> results,
  }) = __LocationResults;

  factory _LocationResults.fromJson(Map<String, Object?> json) => _$_LocationResultsFromJson(json);
}

HttpFuture<List<Location>> searchLocation(String name) async {
  var nameParam = Uri.encodeComponent(name);
  var url =
      Uri.parse('https://geocoding-api.open-meteo.com/v1/search?name=$nameParam&count=10&language=en&format=json');

  var httpResult = await http.sendRequest(HttpMethod.get, url);

  return httpResult
      .expectStatusCode(200)
      .tryParseJson<_LocationResults>(_LocationResults.fromJson)
      .mapOk((it) => it.results);
}
