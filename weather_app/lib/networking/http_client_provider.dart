import 'package:http/http.dart';

abstract class HttpClientProvider {
  T withHttpClient<T>(T Function(Client client) block);
}

class ConcreteHttpClientProvider implements HttpClientProvider {
  @override
  T withHttpClient<T>(T Function(Client) block) {
    final client = Client();
    try {
      return block(client);
    } finally {
      client.close();
    }
  }
}
