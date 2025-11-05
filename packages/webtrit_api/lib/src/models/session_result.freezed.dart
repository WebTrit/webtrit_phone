// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
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
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SessionResult);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SessionResult()';
  }
}

/// @nodoc
class $SessionResultCopyWith<$Res> {
  $SessionResultCopyWith(SessionResult _, $Res Function(SessionResult) __);
}

/// Adds pattern-matching-related methods to [SessionResult].
extension SessionResultPatterns on SessionResult {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SessionOtpProvisional value)? otpProvisional,
    TResult Function(SessionToken value)? token,
    TResult Function(SessionData value)? data,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case SessionOtpProvisional() when otpProvisional != null:
        return otpProvisional(_that);
      case SessionToken() when token != null:
        return token(_that);
      case SessionData() when data != null:
        return data(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SessionOtpProvisional value) otpProvisional,
    required TResult Function(SessionToken value) token,
    required TResult Function(SessionData value) data,
  }) {
    final _that = this;
    switch (_that) {
      case SessionOtpProvisional():
        return otpProvisional(_that);
      case SessionToken():
        return token(_that);
      case SessionData():
        return data(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SessionOtpProvisional value)? otpProvisional,
    TResult? Function(SessionToken value)? token,
    TResult? Function(SessionData value)? data,
  }) {
    final _that = this;
    switch (_that) {
      case SessionOtpProvisional() when otpProvisional != null:
        return otpProvisional(_that);
      case SessionToken() when token != null:
        return token(_that);
      case SessionData() when data != null:
        return data(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String otpId, OtpNotificationType? notificationType,
            String? fromEmail, String? tenantId)?
        otpProvisional,
    TResult Function(String token, String? userId, String? tenantId)? token,
    TResult Function(Map<String, dynamic> data)? data,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case SessionOtpProvisional() when otpProvisional != null:
        return otpProvisional(_that.otpId, _that.notificationType,
            _that.fromEmail, _that.tenantId);
      case SessionToken() when token != null:
        return token(_that.token, _that.userId, _that.tenantId);
      case SessionData() when data != null:
        return data(_that.data);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String otpId,
            OtpNotificationType? notificationType,
            String? fromEmail,
            String? tenantId)
        otpProvisional,
    required TResult Function(String token, String? userId, String? tenantId)
        token,
    required TResult Function(Map<String, dynamic> data) data,
  }) {
    final _that = this;
    switch (_that) {
      case SessionOtpProvisional():
        return otpProvisional(_that.otpId, _that.notificationType,
            _that.fromEmail, _that.tenantId);
      case SessionToken():
        return token(_that.token, _that.userId, _that.tenantId);
      case SessionData():
        return data(_that.data);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String otpId, OtpNotificationType? notificationType,
            String? fromEmail, String? tenantId)?
        otpProvisional,
    TResult? Function(String token, String? userId, String? tenantId)? token,
    TResult? Function(Map<String, dynamic> data)? data,
  }) {
    final _that = this;
    switch (_that) {
      case SessionOtpProvisional() when otpProvisional != null:
        return otpProvisional(_that.otpId, _that.notificationType,
            _that.fromEmail, _that.tenantId);
      case SessionToken() when token != null:
        return token(_that.token, _that.userId, _that.tenantId);
      case SessionData() when data != null:
        return data(_that.data);
      case _:
        return null;
    }
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class SessionOtpProvisional implements SessionResult {
  const SessionOtpProvisional(
      {required this.otpId,
      this.notificationType,
      this.fromEmail,
      this.tenantId,
      final String? $type})
      : $type = $type ?? 'otpProvisional';
  factory SessionOtpProvisional.fromJson(Map<String, dynamic> json) =>
      _$SessionOtpProvisionalFromJson(json);

  final String otpId;
  final OtpNotificationType? notificationType;
  final String? fromEmail;
  final String? tenantId;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of SessionResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SessionOtpProvisionalCopyWith<SessionOtpProvisional> get copyWith =>
      _$SessionOtpProvisionalCopyWithImpl<SessionOtpProvisional>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SessionOtpProvisional &&
            (identical(other.otpId, otpId) || other.otpId == otpId) &&
            (identical(other.notificationType, notificationType) ||
                other.notificationType == notificationType) &&
            (identical(other.fromEmail, fromEmail) ||
                other.fromEmail == fromEmail) &&
            (identical(other.tenantId, tenantId) ||
                other.tenantId == tenantId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, otpId, notificationType, fromEmail, tenantId);

  @override
  String toString() {
    return 'SessionResult.otpProvisional(otpId: $otpId, notificationType: $notificationType, fromEmail: $fromEmail, tenantId: $tenantId)';
  }
}

/// @nodoc
abstract mixin class $SessionOtpProvisionalCopyWith<$Res>
    implements $SessionResultCopyWith<$Res> {
  factory $SessionOtpProvisionalCopyWith(SessionOtpProvisional value,
          $Res Function(SessionOtpProvisional) _then) =
      _$SessionOtpProvisionalCopyWithImpl;
  @useResult
  $Res call(
      {String otpId,
      OtpNotificationType? notificationType,
      String? fromEmail,
      String? tenantId});
}

/// @nodoc
class _$SessionOtpProvisionalCopyWithImpl<$Res>
    implements $SessionOtpProvisionalCopyWith<$Res> {
  _$SessionOtpProvisionalCopyWithImpl(this._self, this._then);

  final SessionOtpProvisional _self;
  final $Res Function(SessionOtpProvisional) _then;

  /// Create a copy of SessionResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? otpId = null,
    Object? notificationType = freezed,
    Object? fromEmail = freezed,
    Object? tenantId = freezed,
  }) {
    return _then(SessionOtpProvisional(
      otpId: null == otpId
          ? _self.otpId
          : otpId // ignore: cast_nullable_to_non_nullable
              as String,
      notificationType: freezed == notificationType
          ? _self.notificationType
          : notificationType // ignore: cast_nullable_to_non_nullable
              as OtpNotificationType?,
      fromEmail: freezed == fromEmail
          ? _self.fromEmail
          : fromEmail // ignore: cast_nullable_to_non_nullable
              as String?,
      tenantId: freezed == tenantId
          ? _self.tenantId
          : tenantId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class SessionToken implements SessionResult {
  const SessionToken(
      {required this.token, this.userId, this.tenantId, final String? $type})
      : $type = $type ?? 'token';
  factory SessionToken.fromJson(Map<String, dynamic> json) =>
      _$SessionTokenFromJson(json);

  final String token;
// Maintain backward compatibility by providing a default null value for userId, as older core versions do not utilize this field.
  final String? userId;
  final String? tenantId;

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of SessionResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SessionTokenCopyWith<SessionToken> get copyWith =>
      _$SessionTokenCopyWithImpl<SessionToken>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SessionToken &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.tenantId, tenantId) ||
                other.tenantId == tenantId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, token, userId, tenantId);

  @override
  String toString() {
    return 'SessionResult.token(token: $token, userId: $userId, tenantId: $tenantId)';
  }
}

/// @nodoc
abstract mixin class $SessionTokenCopyWith<$Res>
    implements $SessionResultCopyWith<$Res> {
  factory $SessionTokenCopyWith(
          SessionToken value, $Res Function(SessionToken) _then) =
      _$SessionTokenCopyWithImpl;
  @useResult
  $Res call({String token, String? userId, String? tenantId});
}

/// @nodoc
class _$SessionTokenCopyWithImpl<$Res> implements $SessionTokenCopyWith<$Res> {
  _$SessionTokenCopyWithImpl(this._self, this._then);

  final SessionToken _self;
  final $Res Function(SessionToken) _then;

  /// Create a copy of SessionResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? token = null,
    Object? userId = freezed,
    Object? tenantId = freezed,
  }) {
    return _then(SessionToken(
      token: null == token
          ? _self.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      userId: freezed == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      tenantId: freezed == tenantId
          ? _self.tenantId
          : tenantId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class SessionData implements SessionResult {
  const SessionData(
      {required final Map<String, dynamic> data, final String? $type})
      : _data = data,
        $type = $type ?? 'data';
  factory SessionData.fromJson(Map<String, dynamic> json) =>
      _$SessionDataFromJson(json);

  final Map<String, dynamic> _data;
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @JsonKey(name: 'runtimeType')
  final String $type;

  /// Create a copy of SessionResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SessionDataCopyWith<SessionData> get copyWith =>
      _$SessionDataCopyWithImpl<SessionData>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SessionData &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  @override
  String toString() {
    return 'SessionResult.data(data: $data)';
  }
}

/// @nodoc
abstract mixin class $SessionDataCopyWith<$Res>
    implements $SessionResultCopyWith<$Res> {
  factory $SessionDataCopyWith(
          SessionData value, $Res Function(SessionData) _then) =
      _$SessionDataCopyWithImpl;
  @useResult
  $Res call({Map<String, dynamic> data});
}

/// @nodoc
class _$SessionDataCopyWithImpl<$Res> implements $SessionDataCopyWith<$Res> {
  _$SessionDataCopyWithImpl(this._self, this._then);

  final SessionData _self;
  final $Res Function(SessionData) _then;

  /// Create a copy of SessionResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? data = null,
  }) {
    return _then(SessionData(
      data: null == data
          ? _self._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

// dart format on
