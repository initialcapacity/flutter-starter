import 'package:flutter_starter/app_dependencies.dart';
import 'package:flutter_starter/prelude/http.dart';
import 'package:flutter_starter/prelude/json_decoder.dart';

final class ApiLocation {
  final String name;
  final String region;
  final double latitude;
  final double longitude;

  const ApiLocation({
    required this.name,
    required this.region,
    required this.latitude,
    required this.longitude,
  });

  factory ApiLocation.fromJson(JsonDecoder json) => ApiLocation(
        name: json.field('name'),
        region: json.field('admin1'),
        latitude: json.field('latitude'),
        longitude: json.field('longitude'),
      );
}

const searchApiUrl = 'https://geocoding-api.open-meteo.com/v1/search';

HttpFuture<Iterable<ApiLocation>> searchLocation(AppDependencies dependencies, String name) async {
  final nameParam = Uri.encodeComponent(name);
  final url = Uri.parse('$searchApiUrl?name=$nameParam&count=10&language=en&format=json');

  return dependencies.withHttpClient((client) async {
    final httpResult = await client.sendRequest(HttpMethod.get, url);

    return httpResult
        .expectStatusCode(200)
        .tryParseJson(dependencies, (json) => json.objectArray('results', ApiLocation.fromJson));
  });
}
