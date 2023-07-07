import 'package:http/http.dart';

class AppDependencies {
  static final AppDependencies _shared = AppDependencies();
  static AppDependencies? testOverrides;

  factory AppDependencies() {
    return testOverrides ?? _shared;
  }

  Client getHttpClient() => Client();
}
