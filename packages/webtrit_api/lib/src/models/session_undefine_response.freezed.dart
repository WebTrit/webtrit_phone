// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_undefine_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SessionUndefineResponse _$SessionUndefineResponseFromJson(
    Map<String, dynamic> json) {
  return _SessionUndefineResponse.fromJson(json);
}

/// @nodoc
mixin _$SessionUndefineResponse {
  Map<String, dynamic> get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SessionUndefineResponseCopyWith<SessionUndefineResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionUndefineResponseCopyWith<$Res> {
  factory $SessionUndefineResponseCopyWith(SessionUndefineResponse value,
          $Res Function(SessionUndefineResponse) then) =
      _$SessionUndefineResponseCopyWithImpl<$Res, SessionUndefineResponse>;
  @useResult
  $Res call({Map<String, dynamic> data});
}

/// @nodoc
class _$SessionUndefineResponseCopyWithImpl<$Res,
        $Val extends SessionUndefineResponse>
    implements $SessionUndefineResponseCopyWith<$Res> {
  _$SessionUndefineResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SessionUndefineResponseCopyWith<$Res>
    implements $SessionUndefineResponseCopyWith<$Res> {
  factory _$$_SessionUndefineResponseCopyWith(_$_SessionUndefineResponse value,
          $Res Function(_$_SessionUndefineResponse) then) =
      __$$_SessionUndefineResponseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, dynamic> data});
}

/// @nodoc
class __$$_SessionUndefineResponseCopyWithImpl<$Res>
    extends _$SessionUndefineResponseCopyWithImpl<$Res,
        _$_SessionUndefineResponse>
    implements _$$_SessionUndefineResponseCopyWith<$Res> {
  __$$_SessionUndefineResponseCopyWithImpl(_$_SessionUndefineResponse _value,
      $Res Function(_$_SessionUndefineResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$_SessionUndefineResponse(
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_SessionUndefineResponse implements _SessionUndefineResponse {
  const _$_SessionUndefineResponse({required final Map<String, dynamic> data})
      : _data = data;

  factory _$_SessionUndefineResponse.fromJson(Map<String, dynamic> json) =>
      _$$_SessionUndefineResponseFromJson(json);

  final Map<String, dynamic> _data;
  @override
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @override
  String toString() {
    return 'SessionUndefineResponse(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SessionUndefineResponse &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SessionUndefineResponseCopyWith<_$_SessionUndefineResponse>
      get copyWith =>
          __$$_SessionUndefineResponseCopyWithImpl<_$_SessionUndefineResponse>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SessionUndefineResponseToJson(
      this,
    );
  }
}

abstract class _SessionUndefineResponse implements SessionUndefineResponse {
  const factory _SessionUndefineResponse(
      {required final Map<String, dynamic> data}) = _$_SessionUndefineResponse;

  factory _SessionUndefineResponse.fromJson(Map<String, dynamic> json) =
      _$_SessionUndefineResponse.fromJson;

  @override
  Map<String, dynamic> get data;
  @override
  @JsonKey(ignore: true)
  _$$_SessionUndefineResponseCopyWith<_$_SessionUndefineResponse>
      get copyWith => throw _privateConstructorUsedError;
}
