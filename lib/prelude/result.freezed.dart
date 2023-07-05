// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Ok<T, E> {
  T get value => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OkCopyWith<T, E, Ok<T, E>> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OkCopyWith<T, E, $Res> {
  factory $OkCopyWith(Ok<T, E> value, $Res Function(Ok<T, E>) then) = _$OkCopyWithImpl<T, E, $Res, Ok<T, E>>;

  @useResult
  $Res call({T value});
}

/// @nodoc
class _$OkCopyWithImpl<T, E, $Res, $Val extends Ok<T, E>> implements $OkCopyWith<T, E, $Res> {
  _$OkCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;

  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
  }) {
    return _then(_value.copyWith(
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as T,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_OkCopyWith<T, E, $Res> implements $OkCopyWith<T, E, $Res> {
  factory _$$_OkCopyWith(_$_Ok<T, E> value, $Res Function(_$_Ok<T, E>) then) = __$$_OkCopyWithImpl<T, E, $Res>;

  @override
  @useResult
  $Res call({T value});
}

/// @nodoc
class __$$_OkCopyWithImpl<T, E, $Res> extends _$OkCopyWithImpl<T, E, $Res, _$_Ok<T, E>>
    implements _$$_OkCopyWith<T, E, $Res> {
  __$$_OkCopyWithImpl(_$_Ok<T, E> _value, $Res Function(_$_Ok<T, E>) _then) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = freezed,
  }) {
    return _then(_$_Ok<T, E>(
      freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$_Ok<T, E> implements _Ok<T, E> {
  const _$_Ok(this.value);

  @override
  final T value;

  @override
  String toString() {
    return 'Ok<$T, $E>(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Ok<T, E> &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(value));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OkCopyWith<T, E, _$_Ok<T, E>> get copyWith => __$$_OkCopyWithImpl<T, E, _$_Ok<T, E>>(this, _$identity);
}

abstract class _Ok<T, E> implements Ok<T, E> {
  const factory _Ok(final T value) = _$_Ok<T, E>;

  @override
  T get value;

  @override
  @JsonKey(ignore: true)
  _$$_OkCopyWith<T, E, _$_Ok<T, E>> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Err<T, E> {
  E get error => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ErrCopyWith<T, E, Err<T, E>> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ErrCopyWith<T, E, $Res> {
  factory $ErrCopyWith(Err<T, E> value, $Res Function(Err<T, E>) then) = _$ErrCopyWithImpl<T, E, $Res, Err<T, E>>;

  @useResult
  $Res call({E error});
}

/// @nodoc
class _$ErrCopyWithImpl<T, E, $Res, $Val extends Err<T, E>> implements $ErrCopyWith<T, E, $Res> {
  _$ErrCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;

  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as E,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ErrCopyWith<T, E, $Res> implements $ErrCopyWith<T, E, $Res> {
  factory _$$_ErrCopyWith(_$_Err<T, E> value, $Res Function(_$_Err<T, E>) then) = __$$_ErrCopyWithImpl<T, E, $Res>;

  @override
  @useResult
  $Res call({E error});
}

/// @nodoc
class __$$_ErrCopyWithImpl<T, E, $Res> extends _$ErrCopyWithImpl<T, E, $Res, _$_Err<T, E>>
    implements _$$_ErrCopyWith<T, E, $Res> {
  __$$_ErrCopyWithImpl(_$_Err<T, E> _value, $Res Function(_$_Err<T, E>) _then) : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
  }) {
    return _then(_$_Err<T, E>(
      freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as E,
    ));
  }
}

/// @nodoc

class _$_Err<T, E> implements _Err<T, E> {
  const _$_Err(this.error);

  @override
  final E error;

  @override
  String toString() {
    return 'Err<$T, $E>(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Err<T, E> &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ErrCopyWith<T, E, _$_Err<T, E>> get copyWith => __$$_ErrCopyWithImpl<T, E, _$_Err<T, E>>(this, _$identity);
}

abstract class _Err<T, E> implements Err<T, E> {
  const factory _Err(final E error) = _$_Err<T, E>;

  @override
  E get error;

  @override
  @JsonKey(ignore: true)
  _$$_ErrCopyWith<T, E, _$_Err<T, E>> get copyWith => throw _privateConstructorUsedError;
}
