import 'package:weather_app/networking/json_decoder.dart';

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
