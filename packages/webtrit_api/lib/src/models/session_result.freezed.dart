// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SessionResult _$SessionResultFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'otpProvisional':
      return SessionOtpProvisional.fromJson(json);
    case 'token':
      return SessionToken.fromJson(json);
    case 'data':
      return SessionData.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'SessionResult',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$SessionResult {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String otpId,
            OtpNotificationType? notificationType,
            String? fromEmail,
            String? tenantId)
        otpProvisional,
    required TResult Function(String token, String? tenantId) token,
    required TResult Function(Map<String, dynamic> data) data,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String otpId, OtpNotificationType? notificationType,
            String? fromEmail, String? tenantId)?
        otpProvisional,
    TResult? Function(String token, String? tenantId)? token,
    TResult? Function(Map<String, dynamic> data)? data,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String otpId, OtpNotificationType? notificationType,
            String? fromEmail, String? tenantId)?
        otpProvisional,
    TResult Function(String token, String? tenantId)? token,
    TResult Function(Map<String, dynamic> data)? data,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SessionOtpProvisional value) otpProvisional,
    required TResult Function(SessionToken value) token,
    required TResult Function(SessionData value) data,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SessionOtpProvisional value)? otpProvisional,
    TResult? Function(SessionToken value)? token,
    TResult? Function(SessionData value)? data,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SessionOtpProvisional value)? otpProvisional,
    TResult Function(SessionToken value)? token,
    TResult Function(SessionData value)? data,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionResultCopyWith<$Res> {
  factory $SessionResultCopyWith(
          SessionResult value, $Res Function(SessionResult) then) =
      _$SessionResultCopyWithImpl<$Res, SessionResult>;
}

/// @nodoc
class _$SessionResultCopyWithImpl<$Res, $Val extends SessionResult>
    implements $SessionResultCopyWith<$Res> {
  _$SessionResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$SessionOtpProvisionalCopyWith<$Res> {
  factory _$$SessionOtpProvisionalCopyWith(_$SessionOtpProvisional value,
          $Res Function(_$SessionOtpProvisional) then) =
      __$$SessionOtpProvisionalCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String otpId,
      OtpNotificationType? notificationType,
      String? fromEmail,
      String? tenantId});
}

/// @nodoc
class __$$SessionOtpProvisionalCopyWithImpl<$Res>
    extends _$SessionResultCopyWithImpl<$Res, _$SessionOtpProvisional>
    implements _$$SessionOtpProvisionalCopyWith<$Res> {
  __$$SessionOtpProvisionalCopyWithImpl(_$SessionOtpProvisional _value,
      $Res Function(_$SessionOtpProvisional) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? otpId = null,
    Object? notificationType = freezed,
    Object? fromEmail = freezed,
    Object? tenantId = freezed,
  }) {
    return _then(_$SessionOtpProvisional(
      otpId: null == otpId
          ? _value.otpId
          : otpId // ignore: cast_nullable_to_non_nullable
              as String,
      notificationType: freezed == notificationType
          ? _value.notificationType
          : notificationType // ignore: cast_nullable_to_non_nullable
              as OtpNotificationType?,
      fromEmail: freezed == fromEmail
          ? _value.fromEmail
          : fromEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      tenantId: freezed == tenantId
          ? _value.tenantId
          : tenantId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$SessionOtpProvisional implements SessionOtpProvisional {
  const _$SessionOtpProvisional(
      {required this.otpId,
      this.notificationType,
      this.fromEmail,
      this.tenantId,
      final String? $type})
      : $type = $type ?? 'otpProvisional';

  factory _$SessionOtpProvisional.fromJson(Map<String, dynamic> json) =>
      _$$SessionOtpProvisionalFromJson(json);

  @override
  final String otpId;
  @override
  final OtpNotificationType? notificationType;
  @override
  final String? fromEmail;
  @override
  final String? tenantId;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SessionResult.otpProvisional(otpId: $otpId, notificationType: $notificationType, fromEmail: $fromEmail, tenantId: $tenantId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionOtpProvisional &&
            (identical(other.otpId, otpId) || other.otpId == otpId) &&
            (identical(other.notificationType, notificationType) ||
                other.notificationType == notificationType) &&
            (identical(other.fromEmail, fromEmail) ||
                other.fromEmail == fromEmail) &&
            (identical(other.tenantId, tenantId) ||
                other.tenantId == tenantId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, otpId, notificationType, fromEmail, tenantId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionOtpProvisionalCopyWith<_$SessionOtpProvisional> get copyWith =>
      __$$SessionOtpProvisionalCopyWithImpl<_$SessionOtpProvisional>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String otpId,
            OtpNotificationType? notificationType,
            String? fromEmail,
            String? tenantId)
        otpProvisional,
    required TResult Function(String token, String? tenantId) token,
    required TResult Function(Map<String, dynamic> data) data,
  }) {
    return otpProvisional(otpId, notificationType, fromEmail, tenantId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String otpId, OtpNotificationType? notificationType,
            String? fromEmail, String? tenantId)?
        otpProvisional,
    TResult? Function(String token, String? tenantId)? token,
    TResult? Function(Map<String, dynamic> data)? data,
  }) {
    return otpProvisional?.call(otpId, notificationType, fromEmail, tenantId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String otpId, OtpNotificationType? notificationType,
            String? fromEmail, String? tenantId)?
        otpProvisional,
    TResult Function(String token, String? tenantId)? token,
    TResult Function(Map<String, dynamic> data)? data,
    required TResult orElse(),
  }) {
    if (otpProvisional != null) {
      return otpProvisional(otpId, notificationType, fromEmail, tenantId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SessionOtpProvisional value) otpProvisional,
    required TResult Function(SessionToken value) token,
    required TResult Function(SessionData value) data,
  }) {
    return otpProvisional(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SessionOtpProvisional value)? otpProvisional,
    TResult? Function(SessionToken value)? token,
    TResult? Function(SessionData value)? data,
  }) {
    return otpProvisional?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SessionOtpProvisional value)? otpProvisional,
    TResult Function(SessionToken value)? token,
    TResult Function(SessionData value)? data,
    required TResult orElse(),
  }) {
    if (otpProvisional != null) {
      return otpProvisional(this);
    }
    return orElse();
  }
}

abstract class SessionOtpProvisional implements SessionResult {
  const factory SessionOtpProvisional(
      {required final String otpId,
      final OtpNotificationType? notificationType,
      final String? fromEmail,
      final String? tenantId}) = _$SessionOtpProvisional;

  factory SessionOtpProvisional.fromJson(Map<String, dynamic> json) =
      _$SessionOtpProvisional.fromJson;

  String get otpId;
  OtpNotificationType? get notificationType;
  String? get fromEmail;
  String? get tenantId;
  @JsonKey(ignore: true)
  _$$SessionOtpProvisionalCopyWith<_$SessionOtpProvisional> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SessionTokenCopyWith<$Res> {
  factory _$$SessionTokenCopyWith(
          _$SessionToken value, $Res Function(_$SessionToken) then) =
      __$$SessionTokenCopyWithImpl<$Res>;
  @useResult
  $Res call({String token, String? tenantId});
}

/// @nodoc
class __$$SessionTokenCopyWithImpl<$Res>
    extends _$SessionResultCopyWithImpl<$Res, _$SessionToken>
    implements _$$SessionTokenCopyWith<$Res> {
  __$$SessionTokenCopyWithImpl(
      _$SessionToken _value, $Res Function(_$SessionToken) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
    Object? tenantId = freezed,
  }) {
    return _then(_$SessionToken(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
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
class _$SessionToken implements SessionToken {
  const _$SessionToken(
      {required this.token, this.tenantId, final String? $type})
      : $type = $type ?? 'token';

  factory _$SessionToken.fromJson(Map<String, dynamic> json) =>
      _$$SessionTokenFromJson(json);

  @override
  final String token;
  @override
  final String? tenantId;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SessionResult.token(token: $token, tenantId: $tenantId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionToken &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.tenantId, tenantId) ||
                other.tenantId == tenantId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, token, tenantId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionTokenCopyWith<_$SessionToken> get copyWith =>
      __$$SessionTokenCopyWithImpl<_$SessionToken>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String otpId,
            OtpNotificationType? notificationType,
            String? fromEmail,
            String? tenantId)
        otpProvisional,
    required TResult Function(String token, String? tenantId) token,
    required TResult Function(Map<String, dynamic> data) data,
  }) {
    return token(this.token, tenantId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String otpId, OtpNotificationType? notificationType,
            String? fromEmail, String? tenantId)?
        otpProvisional,
    TResult? Function(String token, String? tenantId)? token,
    TResult? Function(Map<String, dynamic> data)? data,
  }) {
    return token?.call(this.token, tenantId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String otpId, OtpNotificationType? notificationType,
            String? fromEmail, String? tenantId)?
        otpProvisional,
    TResult Function(String token, String? tenantId)? token,
    TResult Function(Map<String, dynamic> data)? data,
    required TResult orElse(),
  }) {
    if (token != null) {
      return token(this.token, tenantId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SessionOtpProvisional value) otpProvisional,
    required TResult Function(SessionToken value) token,
    required TResult Function(SessionData value) data,
  }) {
    return token(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SessionOtpProvisional value)? otpProvisional,
    TResult? Function(SessionToken value)? token,
    TResult? Function(SessionData value)? data,
  }) {
    return token?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SessionOtpProvisional value)? otpProvisional,
    TResult Function(SessionToken value)? token,
    TResult Function(SessionData value)? data,
    required TResult orElse(),
  }) {
    if (token != null) {
      return token(this);
    }
    return orElse();
  }
}

abstract class SessionToken implements SessionResult {
  const factory SessionToken(
      {required final String token, final String? tenantId}) = _$SessionToken;

  factory SessionToken.fromJson(Map<String, dynamic> json) =
      _$SessionToken.fromJson;

  String get token;
  String? get tenantId;
  @JsonKey(ignore: true)
  _$$SessionTokenCopyWith<_$SessionToken> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SessionDataCopyWith<$Res> {
  factory _$$SessionDataCopyWith(
          _$SessionData value, $Res Function(_$SessionData) then) =
      __$$SessionDataCopyWithImpl<$Res>;
  @useResult
  $Res call({Map<String, dynamic> data});
}

/// @nodoc
class __$$SessionDataCopyWithImpl<$Res>
    extends _$SessionResultCopyWithImpl<$Res, _$SessionData>
    implements _$$SessionDataCopyWith<$Res> {
  __$$SessionDataCopyWithImpl(
      _$SessionData _value, $Res Function(_$SessionData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$SessionData(
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$SessionData implements SessionData {
  const _$SessionData(
      {required final Map<String, dynamic> data, final String? $type})
      : _data = data,
        $type = $type ?? 'data';

  factory _$SessionData.fromJson(Map<String, dynamic> json) =>
      _$$SessionDataFromJson(json);

  final Map<String, dynamic> _data;
  @override
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'SessionResult.data(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionData &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionDataCopyWith<_$SessionData> get copyWith =>
      __$$SessionDataCopyWithImpl<_$SessionData>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String otpId,
            OtpNotificationType? notificationType,
            String? fromEmail,
            String? tenantId)
        otpProvisional,
    required TResult Function(String token, String? tenantId) token,
    required TResult Function(Map<String, dynamic> data) data,
  }) {
    return data(this.data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String otpId, OtpNotificationType? notificationType,
            String? fromEmail, String? tenantId)?
        otpProvisional,
    TResult? Function(String token, String? tenantId)? token,
    TResult? Function(Map<String, dynamic> data)? data,
  }) {
    return data?.call(this.data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String otpId, OtpNotificationType? notificationType,
            String? fromEmail, String? tenantId)?
        otpProvisional,
    TResult Function(String token, String? tenantId)? token,
    TResult Function(Map<String, dynamic> data)? data,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this.data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SessionOtpProvisional value) otpProvisional,
    required TResult Function(SessionToken value) token,
    required TResult Function(SessionData value) data,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SessionOtpProvisional value)? otpProvisional,
    TResult? Function(SessionToken value)? token,
    TResult? Function(SessionData value)? data,
  }) {
    return data?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SessionOtpProvisional value)? otpProvisional,
    TResult Function(SessionToken value)? token,
    TResult Function(SessionData value)? data,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class SessionData implements SessionResult {
  const factory SessionData({required final Map<String, dynamic> data}) =
      _$SessionData;

  factory SessionData.fromJson(Map<String, dynamic> json) =
      _$SessionData.fromJson;

  Map<String, dynamic> get data;
  @JsonKey(ignore: true)
  _$$SessionDataCopyWith<_$SessionData> get copyWith =>
      throw _privateConstructorUsedError;
}
