import 'dart:math';

import 'package:flutter_starter/prelude/iterable.dart';
import 'package:intl/intl.dart';

import 'forecast_api.dart';

final class Forecast {
  final String today;
  final List<HourlyForecast> hourly;
  final List<DailyForecast> daily;

  Forecast({required this.today, required this.hourly, required this.daily});

  static final todayFormat = DateFormat.MMMMEEEEd();
  static final timeFormat = DateFormat.H();
  static final weekdayFormat = DateFormat.EEEE();

  factory Forecast.present(ForecastJson json) {
    final today = todayFormat.format(json.hourly.time.first);
    final now = DateTime.now();
    final hourlyStart = now.subtract(const Duration(hours: 1));
    final hourlyEnd = now.add(const Duration(hours: 23));

    final temperatures = json.hourly.temperature.toList();
    final times = json.hourly.time.toList();
    final length = min(temperatures.length, times.length);

    final allHourlyForecasts = <_RawHourlyForecast>[];
    for (var i = 0; i < length; i++) {
      allHourlyForecasts.add(_RawHourlyForecast(time: times[i], temperature: temperatures[i]));
    }

    final hourly = allHourlyForecasts
        .where((h) => h.time.isAfter(hourlyStart) && h.time.isBefore(hourlyEnd))
        .mapWithIndex(
          (index, h) => HourlyForecast(
            time: index == 0 ? 'Now' : timeFormat.format(h.time),
            temperature: _degrees(h.temperature),
          ),
        );

    final daily = List.generate(5, (dayOffset) {
      final dateWithOffset = now.add(Duration(days: dayOffset));
      final temperatures = allHourlyForecasts
          .where((f) => f.time.day == dateWithOffset.day)
          .map((f) => f.temperature);

      return DailyForecast(
        day: dayOffset == 0 ? 'Today' : weekdayFormat.format(dateWithOffset),
        min: _degrees(temperatures.min()),
        max: _degrees(temperatures.max()),
      );
    });

    return Forecast(today: today, hourly: hourly, daily: daily);
  }
}

String _degrees(double value) => '${value.round()}º';

final class _RawHourlyForecast {
  final DateTime time;
  final double temperature;

  _RawHourlyForecast({required this.time, required this.temperature});
}

final class HourlyForecast {
  final String time;
  final String temperature;

  HourlyForecast({required this.time, required this.temperature});
}

final class DailyForecast {
  final String day;
  final String min;
  final String max;

  DailyForecast({required this.day, required this.min, required this.max});
}
