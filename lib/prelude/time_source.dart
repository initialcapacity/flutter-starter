abstract class TimeSource {
  DateTime now();
}

class SystemTimeSource implements TimeSource {
  @override
  DateTime now() => DateTime.now();
}
