import 'dart:convert';

final class JsonObject {
  final Map<String, dynamic> _values;

  JsonObject(this._values);

  factory JsonObject.fromString(String json) =>
      JsonObject(jsonDecode(json) as Map<String, dynamic>);

  factory JsonObject.fromValue(dynamic object) =>
      JsonObject(object as Map<String, dynamic>);

  T field<T>(String name) => _values[name] as T;

  Iterable<T> array<T>(String name, JsonDecode<T> decode) {
    return (_values[name] as List<dynamic>).map((e) => decode(JsonObject.fromValue(e))).toList();
  }
}

typedef JsonDecode<T> = T Function(JsonObject);
