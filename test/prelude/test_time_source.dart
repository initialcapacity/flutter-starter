import 'package:flutter_starter/prelude/time_source.dart';

class TestTimeSource implements TimeSource {
  @override
  DateTime now() => DateTime.parse('2023-07-21T19:30:00');
}
