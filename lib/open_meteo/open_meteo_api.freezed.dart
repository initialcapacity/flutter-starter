// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'open_meteo_api.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Location _$LocationFromJson(Map<String, dynamic> json) {
  return _Location.fromJson(json);
}

/// @nodoc
mixin _$Location {
  String get name => throw _privateConstructorUsedError;

  double get latitude => throw _privateConstructorUsedError;

  double get longitude => throw _privateConstructorUsedError;

  @JsonKey(name: 'admin1')
  String get region => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LocationCopyWith<Location> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationCopyWith<$Res> {
  factory $LocationCopyWith(Location value, $Res Function(Location) then) = _$LocationCopyWithImpl<$Res, Location>;

  @useResult
  $Res call({String name, double latitude, double longitude, @JsonKey(name: 'admin1') String region});
}

/// @nodoc
class _$LocationCopyWithImpl<$Res, $Val extends Location> implements $LocationCopyWith<$Res> {
  _$LocationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;

  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? region = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      region: null == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LocationCopyWith<$Res> implements $LocationCopyWith<$Res> {
  factory _$$_LocationCopyWith(_$_Location value, $Res Function(_$_Location) then) = __$$_LocationCopyWithImpl<$Res>;

  @override
  @useResult
  $Res call({String name, double latitude, double longitude, @JsonKey(name: 'admin1') String region});
}

/// @nodoc
class __$$_LocationCopyWithImpl<$Res> extends _$LocationCopyWithImpl<$Res, _$_Location>
    implements _$$_LocationCopyWith<$Res> {
  __$$_LocationCopyWithImpl(_$_Location _value, $Res Function(_$_Location) _then) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? region = null,
  }) {
    return _then(_$_Location(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      region: null == region
          ? _value.region
          : region // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Location implements _Location {
  const _$_Location(
      {required this.name,
      required this.latitude,
      required this.longitude,
      @JsonKey(name: 'admin1') required this.region});

  factory _$_Location.fromJson(Map<String, dynamic> json) => _$$_LocationFromJson(json);

  @override
  final String name;
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  @JsonKey(name: 'admin1')
  final String region;

  @override
  String toString() {
    return 'Location(name: $name, latitude: $latitude, longitude: $longitude, region: $region)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Location &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.latitude, latitude) || other.latitude == latitude) &&
            (identical(other.longitude, longitude) || other.longitude == longitude) &&
            (identical(other.region, region) || other.region == region));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, latitude, longitude, region);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LocationCopyWith<_$_Location> get copyWith => __$$_LocationCopyWithImpl<_$_Location>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LocationToJson(
      this,
    );
  }
}

abstract class _Location implements Location {
  const factory _Location(
      {required final String name,
      required final double latitude,
      required final double longitude,
      @JsonKey(name: 'admin1') required final String region}) = _$_Location;

  factory _Location.fromJson(Map<String, dynamic> json) = _$_Location.fromJson;

  @override
  String get name;

  @override
  double get latitude;

  @override
  double get longitude;

  @override
  @JsonKey(name: 'admin1')
  String get region;

  @override
  @JsonKey(ignore: true)
  _$$_LocationCopyWith<_$_Location> get copyWith => throw _privateConstructorUsedError;
}

_LocationResults _$_LocationResultsFromJson(Map<String, dynamic> json) {
  return __LocationResults.fromJson(json);
}

/// @nodoc
mixin _$_LocationResults {
  List<Location> get results => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  _$LocationResultsCopyWith<_LocationResults> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$LocationResultsCopyWith<$Res> {
  factory _$LocationResultsCopyWith(_LocationResults value, $Res Function(_LocationResults) then) =
      __$LocationResultsCopyWithImpl<$Res, _LocationResults>;

  @useResult
  $Res call({List<Location> results});
}

/// @nodoc
class __$LocationResultsCopyWithImpl<$Res, $Val extends _LocationResults> implements _$LocationResultsCopyWith<$Res> {
  __$LocationResultsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;

  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? results = null,
  }) {
    return _then(_value.copyWith(
      results: null == results
          ? _value.results
          : results // ignore: cast_nullable_to_non_nullable
              as List<Location>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$__LocationResultsCopyWith<$Res> implements _$LocationResultsCopyWith<$Res> {
  factory _$$__LocationResultsCopyWith(_$__LocationResults value, $Res Function(_$__LocationResults) then) =
      __$$__LocationResultsCopyWithImpl<$Res>;

  @override
  @useResult
  $Res call({List<Location> results});
}

/// @nodoc
class __$$__LocationResultsCopyWithImpl<$Res> extends __$LocationResultsCopyWithImpl<$Res, _$__LocationResults>
    implements _$$__LocationResultsCopyWith<$Res> {
  __$$__LocationResultsCopyWithImpl(_$__LocationResults _value, $Res Function(_$__LocationResults) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? results = null,
  }) {
    return _then(_$__LocationResults(
      results: null == results
          ? _value._results
          : results // ignore: cast_nullable_to_non_nullable
              as List<Location>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$__LocationResults implements __LocationResults {
  const _$__LocationResults({required final List<Location> results}) : _results = results;

  factory _$__LocationResults.fromJson(Map<String, dynamic> json) => _$$__LocationResultsFromJson(json);

  final List<Location> _results;

  @override
  List<Location> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @override
  String toString() {
    return '_LocationResults(results: $results)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$__LocationResults &&
            const DeepCollectionEquality().equals(other._results, _results));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(_results));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$__LocationResultsCopyWith<_$__LocationResults> get copyWith =>
      __$$__LocationResultsCopyWithImpl<_$__LocationResults>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$__LocationResultsToJson(
      this,
    );
  }
}

abstract class __LocationResults implements _LocationResults {
  const factory __LocationResults({required final List<Location> results}) = _$__LocationResults;

  factory __LocationResults.fromJson(Map<String, dynamic> json) = _$__LocationResults.fromJson;

  @override
  List<Location> get results;

  @override
  @JsonKey(ignore: true)
  _$$__LocationResultsCopyWith<_$__LocationResults> get copyWith => throw _privateConstructorUsedError;
}
