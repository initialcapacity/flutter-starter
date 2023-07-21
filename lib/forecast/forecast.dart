import 'dart:math';

import 'package:intl/intl.dart';

import 'forecast_api.dart';

final class Forecast {
  final String today;
  final List<HourlyForecast> hourly;

  Forecast({required this.today, required this.hourly});

  static final todayFormat = DateFormat.yMMMEd();
  static final timeFormat = DateFormat.H();

  factory Forecast.present(ForecastJson json) {
    final today = todayFormat.format(json.hourly.time.first);
    final now = DateTime.now();
    final hourlyStart = now.subtract(const Duration(hours: 1));
    final hourlyEnd = now.add(const Duration(hours: 24));

    final temperatures = json.hourly.temperature.toList();
    final times = json.hourly.time.toList();
    final length = min(temperatures.length, times.length);

    final hourly = <HourlyForecast>[];

    for (var i = 0; i < length; i++) {
      if (times[i].isAfter(hourlyStart) && times[i].isBefore(hourlyEnd)) {
        hourly.add(HourlyForecast(
          time: timeFormat.format(times[i]),
          temperature: '${temperatures[i].floor()}ºC',
        ));
      }
    }

    return Forecast(today: today, hourly: hourly);
  }
}

final class HourlyForecast {
  final String time;
  final String temperature;

  HourlyForecast({required this.time, required this.temperature});
}

DateTime _tomorrowAtMidnight() {
  final now = DateTime.now();
  final tomorrowAtThisTime = now.add(const Duration(days: 1));
  final tomorrowAtMidnight =
      DateTime(tomorrowAtThisTime.year, tomorrowAtThisTime.month, tomorrowAtThisTime.day);

  return tomorrowAtMidnight;
}
