import 'dart:math';

import 'forecast_api.dart';

final class ForecastPresenter {
  final Iterable<ForecastPresenterRow> rows;

  ForecastPresenter(this.rows);

  factory ForecastPresenter.present(Forecast forecast) {
    final rows = <ForecastPresenterRow>[];

    final temperatures = forecast.hourly.temperature.toList();
    final times = forecast.hourly.time.toList();
    final length = min(temperatures.length, times.length);

    for (var i = 0; i < length; i++) {
      rows.add(ForecastPresenterRow(
        time: times[i],
        temperature: temperatures[i],
      ));
    }

    return ForecastPresenter(rows);
  }
}

final class ForecastPresenterRow {
  final String time;
  final double temperature;

  ForecastPresenterRow({required this.time, required this.temperature});
}
