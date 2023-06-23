// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_otp_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SessionOtpResponse _$SessionOtpResponseFromJson(Map<String, dynamic> json) {
  return _SessionOtpResponse.fromJson(json);
}

/// @nodoc
mixin _$SessionOtpResponse {
  String get otpId => throw _privateConstructorUsedError;
  OtpNotificationType? get notificationType =>
      throw _privateConstructorUsedError;
  String? get fromEmail => throw _privateConstructorUsedError;
  String? get tenantId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SessionOtpResponseCopyWith<SessionOtpResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionOtpResponseCopyWith<$Res> {
  factory $SessionOtpResponseCopyWith(
          SessionOtpResponse value, $Res Function(SessionOtpResponse) then) =
      _$SessionOtpResponseCopyWithImpl<$Res, SessionOtpResponse>;
  @useResult
  $Res call(
      {String otpId,
      OtpNotificationType? notificationType,
      String? fromEmail,
      String? tenantId});
}

/// @nodoc
class _$SessionOtpResponseCopyWithImpl<$Res, $Val extends SessionOtpResponse>
    implements $SessionOtpResponseCopyWith<$Res> {
  _$SessionOtpResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? otpId = null,
    Object? notificationType = freezed,
    Object? fromEmail = freezed,
    Object? tenantId = freezed,
  }) {
    return _then(_value.copyWith(
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SessionOtpResponseCopyWith<$Res>
    implements $SessionOtpResponseCopyWith<$Res> {
  factory _$$_SessionOtpResponseCopyWith(_$_SessionOtpResponse value,
          $Res Function(_$_SessionOtpResponse) then) =
      __$$_SessionOtpResponseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String otpId,
      OtpNotificationType? notificationType,
      String? fromEmail,
      String? tenantId});
}

/// @nodoc
class __$$_SessionOtpResponseCopyWithImpl<$Res>
    extends _$SessionOtpResponseCopyWithImpl<$Res, _$_SessionOtpResponse>
    implements _$$_SessionOtpResponseCopyWith<$Res> {
  __$$_SessionOtpResponseCopyWithImpl(
      _$_SessionOtpResponse _value, $Res Function(_$_SessionOtpResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? otpId = null,
    Object? notificationType = freezed,
    Object? fromEmail = freezed,
    Object? tenantId = freezed,
  }) {
    return _then(_$_SessionOtpResponse(
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
class _$_SessionOtpResponse implements _SessionOtpResponse {
  const _$_SessionOtpResponse(
      {required this.otpId,
      this.notificationType,
      this.fromEmail,
      this.tenantId});

  factory _$_SessionOtpResponse.fromJson(Map<String, dynamic> json) =>
      _$$_SessionOtpResponseFromJson(json);

  @override
  final String otpId;
  @override
  final OtpNotificationType? notificationType;
  @override
  final String? fromEmail;
  @override
  final String? tenantId;

  @override
  String toString() {
    return 'SessionOtpResponse(otpId: $otpId, notificationType: $notificationType, fromEmail: $fromEmail, tenantId: $tenantId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SessionOtpResponse &&
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
  _$$_SessionOtpResponseCopyWith<_$_SessionOtpResponse> get copyWith =>
      __$$_SessionOtpResponseCopyWithImpl<_$_SessionOtpResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SessionOtpResponseToJson(
      this,
    );
  }
}

abstract class _SessionOtpResponse implements SessionOtpResponse {
  const factory _SessionOtpResponse(
      {required final String otpId,
      final OtpNotificationType? notificationType,
      final String? fromEmail,
      final String? tenantId}) = _$_SessionOtpResponse;

  factory _SessionOtpResponse.fromJson(Map<String, dynamic> json) =
      _$_SessionOtpResponse.fromJson;

  @override
  String get otpId;
  @override
  OtpNotificationType? get notificationType;
  @override
  String? get fromEmail;
  @override
  String? get tenantId;
  @override
  @JsonKey(ignore: true)
  _$$_SessionOtpResponseCopyWith<_$_SessionOtpResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
