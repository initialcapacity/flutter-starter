import 'package:flutter_starter/prelude/http.dart';
import 'package:flutter_starter/prelude/result.dart';
import 'package:http/http.dart';

typedef Location = ({String name, String region, double latitude, double longitude});

Location _locationFromJson(Map<String, dynamic> json) => (
      name: json['name'] as String,
      region: json['admin1'] as String,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
    );

typedef _LocationResults = ({List<Location> results});

_LocationResults _locationResultsFromJson(Map<String, dynamic> json) =>
    (results: (json['results'] as List<dynamic>).map((e) => _locationFromJson(e as Map<String, dynamic>)).toList());

const apiUrl = 'https://geocoding-api.open-meteo.com';

HttpFuture<List<Location>> searchLocation(Client client, String name) async {
  final nameParam = Uri.encodeComponent(name);
  final url = Uri.parse('$apiUrl/v1/search?name=$nameParam&count=10&language=en&format=json');
  final httpResult = await client.sendRequest(HttpMethod.get, url);

  return httpResult.expectStatusCode(200).tryParseJson(_locationResultsFromJson).mapOk((it) => it.results);
}
