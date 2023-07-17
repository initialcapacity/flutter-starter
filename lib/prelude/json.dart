import 'dart:convert';

/// Be careful with this class.
/// It will throw `TypeError` if casting fails.
/// See `http.dart` for safe handling.
final class JsonObject {
  final Map<String, dynamic> _values;

  JsonObject(this._values);

  /// This throws if the String is not a JSON object
  factory JsonObject.fromString(String json) =>
      JsonObject(jsonDecode(json) as Map<String, dynamic>);

  /// This throws if the object is not a Map<String, dynamic>
  factory JsonObject.fromValue(dynamic object) => JsonObject(object as Map<String, dynamic>);

  /// This throws if the value for the field is not of type T
  T field<T>(String name) => _values[name] as T;

  /// This throws if the field is not an array of objects that match the decoder
  Iterable<T> array<T>(String name, JsonDecode<T> decode) {
    return (_values[name] as List<dynamic>).map((e) => decode(JsonObject.fromValue(e))).toList();
  }
}

typedef JsonDecode<T> = T Function(JsonObject);
