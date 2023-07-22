import 'package:flutter_starter/prelude/json_decoder.dart';

JsonObject buildLocationJson({
  String name = 'Louisville',
  String admin1 = 'Colorado',
  double latitude = 38.77227,
  double longitude = -88.50255,
}) =>
    {
      'name': name,
      'admin1': admin1,
      'latitude': latitude,
      'longitude': longitude,
    };

JsonObject buildLocationSearchJson({
  JsonObjectArray? results,
}) =>
    {
      'results': results ??
          [
            buildLocationJson(),
            buildLocationJson(admin1: 'Kentucky', latitude: 38.25424, longitude: -85.75941),
          ],
    };
