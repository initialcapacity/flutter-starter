import 'package:http/http.dart';

class AppDependencies {
  static final AppDependencies _shared = AppDependencies();
  static AppDependencies? testOverrides;

  factory AppDependencies() {
    return testOverrides ?? _shared;
  }

  T withHttpClient<T>(T Function(Client) block) {
    var client = Client();
    try {
      return block(client);
    } finally {
      client.close();
    }
  }
}
