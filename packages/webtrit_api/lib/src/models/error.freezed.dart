// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'error.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ErrorResponse _$ErrorResponseFromJson(Map<String, dynamic> json) {
  return _ErrorResponse.fromJson(json);
}

/// @nodoc
mixin _$ErrorResponse {
  String get code => throw _privateConstructorUsedError;
  List<ErrorRefining>? get refining => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ErrorResponseCopyWith<ErrorResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ErrorResponseCopyWith<$Res> {
  factory $ErrorResponseCopyWith(
          ErrorResponse value, $Res Function(ErrorResponse) then) =
      _$ErrorResponseCopyWithImpl<$Res, ErrorResponse>;
  @useResult
  $Res call({String code, List<ErrorRefining>? refining});
}

/// @nodoc
class _$ErrorResponseCopyWithImpl<$Res, $Val extends ErrorResponse>
    implements $ErrorResponseCopyWith<$Res> {
  _$ErrorResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? refining = freezed,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      refining: freezed == refining
          ? _value.refining
          : refining // ignore: cast_nullable_to_non_nullable
              as List<ErrorRefining>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ErrorResponseCopyWith<$Res>
    implements $ErrorResponseCopyWith<$Res> {
  factory _$$_ErrorResponseCopyWith(
          _$_ErrorResponse value, $Res Function(_$_ErrorResponse) then) =
      __$$_ErrorResponseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String code, List<ErrorRefining>? refining});
}

/// @nodoc
class __$$_ErrorResponseCopyWithImpl<$Res>
    extends _$ErrorResponseCopyWithImpl<$Res, _$_ErrorResponse>
    implements _$$_ErrorResponseCopyWith<$Res> {
  __$$_ErrorResponseCopyWithImpl(
      _$_ErrorResponse _value, $Res Function(_$_ErrorResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? refining = freezed,
  }) {
    return _then(_$_ErrorResponse(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      refining: freezed == refining
          ? _value._refining
          : refining // ignore: cast_nullable_to_non_nullable
              as List<ErrorRefining>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_ErrorResponse implements _ErrorResponse {
  const _$_ErrorResponse(
      {required this.code, final List<ErrorRefining>? refining})
      : _refining = refining;

  factory _$_ErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$$_ErrorResponseFromJson(json);

  @override
  final String code;
  final List<ErrorRefining>? _refining;
  @override
  List<ErrorRefining>? get refining {
    final value = _refining;
    if (value == null) return null;
    if (_refining is EqualUnmodifiableListView) return _refining;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ErrorResponse(code: $code, refining: $refining)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ErrorResponse &&
            (identical(other.code, code) || other.code == code) &&
            const DeepCollectionEquality().equals(other._refining, _refining));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, code, const DeepCollectionEquality().hash(_refining));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ErrorResponseCopyWith<_$_ErrorResponse> get copyWith =>
      __$$_ErrorResponseCopyWithImpl<_$_ErrorResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ErrorResponseToJson(
      this,
    );
  }
}

abstract class _ErrorResponse implements ErrorResponse {
  const factory _ErrorResponse(
      {required final String code,
      final List<ErrorRefining>? refining}) = _$_ErrorResponse;

  factory _ErrorResponse.fromJson(Map<String, dynamic> json) =
      _$_ErrorResponse.fromJson;

  @override
  String get code;
  @override
  List<ErrorRefining>? get refining;
  @override
  @JsonKey(ignore: true)
  _$$_ErrorResponseCopyWith<_$_ErrorResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

ErrorRefining _$ErrorRefiningFromJson(Map<String, dynamic> json) {
  return _ErrorRefining.fromJson(json);
}

/// @nodoc
mixin _$ErrorRefining {
  String get path => throw _privateConstructorUsedError;
  String get reason => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ErrorRefiningCopyWith<ErrorRefining> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ErrorRefiningCopyWith<$Res> {
  factory $ErrorRefiningCopyWith(
          ErrorRefining value, $Res Function(ErrorRefining) then) =
      _$ErrorRefiningCopyWithImpl<$Res, ErrorRefining>;
  @useResult
  $Res call({String path, String reason});
}

/// @nodoc
class _$ErrorRefiningCopyWithImpl<$Res, $Val extends ErrorRefining>
    implements $ErrorRefiningCopyWith<$Res> {
  _$ErrorRefiningCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = null,
    Object? reason = null,
  }) {
    return _then(_value.copyWith(
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ErrorRefiningCopyWith<$Res>
    implements $ErrorRefiningCopyWith<$Res> {
  factory _$$_ErrorRefiningCopyWith(
          _$_ErrorRefining value, $Res Function(_$_ErrorRefining) then) =
      __$$_ErrorRefiningCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String path, String reason});
}

/// @nodoc
class __$$_ErrorRefiningCopyWithImpl<$Res>
    extends _$ErrorRefiningCopyWithImpl<$Res, _$_ErrorRefining>
    implements _$$_ErrorRefiningCopyWith<$Res> {
  __$$_ErrorRefiningCopyWithImpl(
      _$_ErrorRefining _value, $Res Function(_$_ErrorRefining) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = null,
    Object? reason = null,
  }) {
    return _then(_$_ErrorRefining(
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_ErrorRefining implements _ErrorRefining {
  const _$_ErrorRefining({required this.path, required this.reason});

  factory _$_ErrorRefining.fromJson(Map<String, dynamic> json) =>
      _$$_ErrorRefiningFromJson(json);

  @override
  final String path;
  @override
  final String reason;

  @override
  String toString() {
    return 'ErrorRefining(path: $path, reason: $reason)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ErrorRefining &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, path, reason);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ErrorRefiningCopyWith<_$_ErrorRefining> get copyWith =>
      __$$_ErrorRefiningCopyWithImpl<_$_ErrorRefining>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ErrorRefiningToJson(
      this,
    );
  }
}

abstract class _ErrorRefining implements ErrorRefining {
  const factory _ErrorRefining(
      {required final String path,
      required final String reason}) = _$_ErrorRefining;

  factory _ErrorRefining.fromJson(Map<String, dynamic> json) =
      _$_ErrorRefining.fromJson;

  @override
  String get path;
  @override
  String get reason;
  @override
  @JsonKey(ignore: true)
  _$$_ErrorRefiningCopyWith<_$_ErrorRefining> get copyWith =>
      throw _privateConstructorUsedError;
}
