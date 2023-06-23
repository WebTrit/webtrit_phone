// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_authorized_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SessionAuthorizedResponse _$SessionAuthorizedResponseFromJson(
    Map<String, dynamic> json) {
  return _SessionAuthorizedResponse.fromJson(json);
}

/// @nodoc
mixin _$SessionAuthorizedResponse {
  String get token => throw _privateConstructorUsedError;
  String get expiresAt => throw _privateConstructorUsedError;
  String? get tenantId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SessionAuthorizedResponseCopyWith<SessionAuthorizedResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionAuthorizedResponseCopyWith<$Res> {
  factory $SessionAuthorizedResponseCopyWith(SessionAuthorizedResponse value,
          $Res Function(SessionAuthorizedResponse) then) =
      _$SessionAuthorizedResponseCopyWithImpl<$Res, SessionAuthorizedResponse>;
  @useResult
  $Res call({String token, String expiresAt, String? tenantId});
}

/// @nodoc
class _$SessionAuthorizedResponseCopyWithImpl<$Res,
        $Val extends SessionAuthorizedResponse>
    implements $SessionAuthorizedResponseCopyWith<$Res> {
  _$SessionAuthorizedResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
    Object? expiresAt = null,
    Object? tenantId = freezed,
  }) {
    return _then(_value.copyWith(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      expiresAt: null == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as String,
      tenantId: freezed == tenantId
          ? _value.tenantId
          : tenantId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SessionAuthorizedResponseCopyWith<$Res>
    implements $SessionAuthorizedResponseCopyWith<$Res> {
  factory _$$_SessionAuthorizedResponseCopyWith(
          _$_SessionAuthorizedResponse value,
          $Res Function(_$_SessionAuthorizedResponse) then) =
      __$$_SessionAuthorizedResponseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String token, String expiresAt, String? tenantId});
}

/// @nodoc
class __$$_SessionAuthorizedResponseCopyWithImpl<$Res>
    extends _$SessionAuthorizedResponseCopyWithImpl<$Res,
        _$_SessionAuthorizedResponse>
    implements _$$_SessionAuthorizedResponseCopyWith<$Res> {
  __$$_SessionAuthorizedResponseCopyWithImpl(
      _$_SessionAuthorizedResponse _value,
      $Res Function(_$_SessionAuthorizedResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
    Object? expiresAt = null,
    Object? tenantId = freezed,
  }) {
    return _then(_$_SessionAuthorizedResponse(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      expiresAt: null == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as String,
      tenantId: freezed == tenantId
          ? _value.tenantId
          : tenantId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_SessionAuthorizedResponse implements _SessionAuthorizedResponse {
  const _$_SessionAuthorizedResponse(
      {required this.token, required this.expiresAt, this.tenantId});

  factory _$_SessionAuthorizedResponse.fromJson(Map<String, dynamic> json) =>
      _$$_SessionAuthorizedResponseFromJson(json);

  @override
  final String token;
  @override
  final String expiresAt;
  @override
  final String? tenantId;

  @override
  String toString() {
    return 'SessionAuthorizedResponse(token: $token, expiresAt: $expiresAt, tenantId: $tenantId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SessionAuthorizedResponse &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.tenantId, tenantId) ||
                other.tenantId == tenantId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, token, expiresAt, tenantId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SessionAuthorizedResponseCopyWith<_$_SessionAuthorizedResponse>
      get copyWith => __$$_SessionAuthorizedResponseCopyWithImpl<
          _$_SessionAuthorizedResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SessionAuthorizedResponseToJson(
      this,
    );
  }
}

abstract class _SessionAuthorizedResponse implements SessionAuthorizedResponse {
  const factory _SessionAuthorizedResponse(
      {required final String token,
      required final String expiresAt,
      final String? tenantId}) = _$_SessionAuthorizedResponse;

  factory _SessionAuthorizedResponse.fromJson(Map<String, dynamic> json) =
      _$_SessionAuthorizedResponse.fromJson;

  @override
  String get token;
  @override
  String get expiresAt;
  @override
  String? get tenantId;
  @override
  @JsonKey(ignore: true)
  _$$_SessionAuthorizedResponseCopyWith<_$_SessionAuthorizedResponse>
      get copyWith => throw _privateConstructorUsedError;
}
