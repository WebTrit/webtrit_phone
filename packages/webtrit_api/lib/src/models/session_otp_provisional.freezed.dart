// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_otp_provisional.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SessionOtpProvisional _$SessionOtpProvisionalFromJson(
    Map<String, dynamic> json) {
  return _SessionOtpProvisional.fromJson(json);
}

/// @nodoc
mixin _$SessionOtpProvisional {
  String get otpId => throw _privateConstructorUsedError;
  OtpNotificationType get notificationType =>
      throw _privateConstructorUsedError;
  String? get fromEmail => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SessionOtpProvisionalCopyWith<SessionOtpProvisional> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionOtpProvisionalCopyWith<$Res> {
  factory $SessionOtpProvisionalCopyWith(SessionOtpProvisional value,
          $Res Function(SessionOtpProvisional) then) =
      _$SessionOtpProvisionalCopyWithImpl<$Res, SessionOtpProvisional>;
  @useResult
  $Res call(
      {String otpId, OtpNotificationType notificationType, String? fromEmail});
}

/// @nodoc
class _$SessionOtpProvisionalCopyWithImpl<$Res,
        $Val extends SessionOtpProvisional>
    implements $SessionOtpProvisionalCopyWith<$Res> {
  _$SessionOtpProvisionalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? otpId = null,
    Object? notificationType = null,
    Object? fromEmail = freezed,
  }) {
    return _then(_value.copyWith(
      otpId: null == otpId
          ? _value.otpId
          : otpId // ignore: cast_nullable_to_non_nullable
              as String,
      notificationType: null == notificationType
          ? _value.notificationType
          : notificationType // ignore: cast_nullable_to_non_nullable
              as OtpNotificationType,
      fromEmail: freezed == fromEmail
          ? _value.fromEmail
          : fromEmail // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SessionOtpProvisionalCopyWith<$Res>
    implements $SessionOtpProvisionalCopyWith<$Res> {
  factory _$$_SessionOtpProvisionalCopyWith(_$_SessionOtpProvisional value,
          $Res Function(_$_SessionOtpProvisional) then) =
      __$$_SessionOtpProvisionalCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String otpId, OtpNotificationType notificationType, String? fromEmail});
}

/// @nodoc
class __$$_SessionOtpProvisionalCopyWithImpl<$Res>
    extends _$SessionOtpProvisionalCopyWithImpl<$Res, _$_SessionOtpProvisional>
    implements _$$_SessionOtpProvisionalCopyWith<$Res> {
  __$$_SessionOtpProvisionalCopyWithImpl(_$_SessionOtpProvisional _value,
      $Res Function(_$_SessionOtpProvisional) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? otpId = null,
    Object? notificationType = null,
    Object? fromEmail = freezed,
  }) {
    return _then(_$_SessionOtpProvisional(
      otpId: null == otpId
          ? _value.otpId
          : otpId // ignore: cast_nullable_to_non_nullable
              as String,
      notificationType: null == notificationType
          ? _value.notificationType
          : notificationType // ignore: cast_nullable_to_non_nullable
              as OtpNotificationType,
      fromEmail: freezed == fromEmail
          ? _value.fromEmail
          : fromEmail // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_SessionOtpProvisional implements _SessionOtpProvisional {
  const _$_SessionOtpProvisional(
      {required this.otpId, required this.notificationType, this.fromEmail});

  factory _$_SessionOtpProvisional.fromJson(Map<String, dynamic> json) =>
      _$$_SessionOtpProvisionalFromJson(json);

  @override
  final String otpId;
  @override
  final OtpNotificationType notificationType;
  @override
  final String? fromEmail;

  @override
  String toString() {
    return 'SessionOtpProvisional(otpId: $otpId, notificationType: $notificationType, fromEmail: $fromEmail)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SessionOtpProvisional &&
            (identical(other.otpId, otpId) || other.otpId == otpId) &&
            (identical(other.notificationType, notificationType) ||
                other.notificationType == notificationType) &&
            (identical(other.fromEmail, fromEmail) ||
                other.fromEmail == fromEmail));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, otpId, notificationType, fromEmail);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SessionOtpProvisionalCopyWith<_$_SessionOtpProvisional> get copyWith =>
      __$$_SessionOtpProvisionalCopyWithImpl<_$_SessionOtpProvisional>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SessionOtpProvisionalToJson(
      this,
    );
  }
}

abstract class _SessionOtpProvisional implements SessionOtpProvisional {
  const factory _SessionOtpProvisional(
      {required final String otpId,
      required final OtpNotificationType notificationType,
      final String? fromEmail}) = _$_SessionOtpProvisional;

  factory _SessionOtpProvisional.fromJson(Map<String, dynamic> json) =
      _$_SessionOtpProvisional.fromJson;

  @override
  String get otpId;
  @override
  OtpNotificationType get notificationType;
  @override
  String? get fromEmail;
  @override
  @JsonKey(ignore: true)
  _$$_SessionOtpProvisionalCopyWith<_$_SessionOtpProvisional> get copyWith =>
      throw _privateConstructorUsedError;
}
