typedef JsonObject = Map<String, dynamic>;
typedef JsonArray<T> = List<T>;
typedef JsonObjectArray = JsonArray<JsonObject>;

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

JsonObject buildHourlyForecastJon({
  JsonArray<String>? time,
  JsonArray<double>? temperature,
}) =>
    {
      'time': time ??
          [
            '2012-07-21T00:00:00',
            '2012-07-22T00:00:00',
            '2012-07-23T00:00:00',
            '2012-07-24T00:00:00',
            '2012-07-25T00:00:00',
          ],
      'temperature_2m': temperature ??
          [
            30.0,
            31.0,
            32.0,
            33.0,
            34.0,
          ],
    };

JsonObject buildForecastJson({JsonObject? hourly}) => {
      'hourly': buildHourlyForecastJon(),
    };
