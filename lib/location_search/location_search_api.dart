import 'package:flutter_starter/networking/async_compute.dart';
import 'package:flutter_starter/networking/http.dart';
import 'package:flutter_starter/networking/http_client_provider.dart';
import 'package:flutter_starter/networking/json_decoder.dart';

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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ApiLocation &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          region == other.region &&
          latitude == other.latitude &&
          longitude == other.longitude;

  @override
  int get hashCode => name.hashCode ^ region.hashCode ^ latitude.hashCode ^ longitude.hashCode;
}

const searchApiUrl = 'https://geocoding-api.open-meteo.com/v1/search';

HttpFuture<Iterable<ApiLocation>> searchLocation(
  HttpClientProvider httpClientProvider,
  AsyncCompute asyncCompute,
  String name,
) async {
  final nameParam = Uri.encodeComponent(name);
  final url = Uri.parse('$searchApiUrl?name=$nameParam&count=10&language=en&format=json');

  return httpClientProvider.withHttpClient((client) async {
    final httpResult = await client.sendRequest(HttpMethod.get, url);

    return httpResult
        .expectStatusCode(200)
        .tryParseJson(asyncCompute, (json) => json.objectArray('results', ApiLocation.fromJson));
  });
}
