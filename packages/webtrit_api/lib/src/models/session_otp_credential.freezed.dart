// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_otp_credential.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SessionOtpCredential _$SessionOtpCredentialFromJson(Map<String, dynamic> json) {
  return _SessionOtpCredential.fromJson(json);
}

/// @nodoc
mixin _$SessionOtpCredential {
  AppType get type => throw _privateConstructorUsedError;
  String get identifier => throw _privateConstructorUsedError;
  String get userRef => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SessionOtpCredentialCopyWith<SessionOtpCredential> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionOtpCredentialCopyWith<$Res> {
  factory $SessionOtpCredentialCopyWith(SessionOtpCredential value,
          $Res Function(SessionOtpCredential) then) =
      _$SessionOtpCredentialCopyWithImpl<$Res, SessionOtpCredential>;
  @useResult
  $Res call({AppType type, String identifier, String userRef});
}

/// @nodoc
class _$SessionOtpCredentialCopyWithImpl<$Res,
        $Val extends SessionOtpCredential>
    implements $SessionOtpCredentialCopyWith<$Res> {
  _$SessionOtpCredentialCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? identifier = null,
    Object? userRef = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as AppType,
      identifier: null == identifier
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String,
      userRef: null == userRef
          ? _value.userRef
          : userRef // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SessionOtpCredentialCopyWith<$Res>
    implements $SessionOtpCredentialCopyWith<$Res> {
  factory _$$_SessionOtpCredentialCopyWith(_$_SessionOtpCredential value,
          $Res Function(_$_SessionOtpCredential) then) =
      __$$_SessionOtpCredentialCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AppType type, String identifier, String userRef});
}

/// @nodoc
class __$$_SessionOtpCredentialCopyWithImpl<$Res>
    extends _$SessionOtpCredentialCopyWithImpl<$Res, _$_SessionOtpCredential>
    implements _$$_SessionOtpCredentialCopyWith<$Res> {
  __$$_SessionOtpCredentialCopyWithImpl(_$_SessionOtpCredential _value,
      $Res Function(_$_SessionOtpCredential) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? identifier = null,
    Object? userRef = null,
  }) {
    return _then(_$_SessionOtpCredential(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as AppType,
      identifier: null == identifier
          ? _value.identifier
          : identifier // ignore: cast_nullable_to_non_nullable
              as String,
      userRef: null == userRef
          ? _value.userRef
          : userRef // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_SessionOtpCredential implements _SessionOtpCredential {
  const _$_SessionOtpCredential(
      {required this.type, required this.identifier, required this.userRef});

  factory _$_SessionOtpCredential.fromJson(Map<String, dynamic> json) =>
      _$$_SessionOtpCredentialFromJson(json);

  @override
  final AppType type;
  @override
  final String identifier;
  @override
  final String userRef;

  @override
  String toString() {
    return 'SessionOtpCredential(type: $type, identifier: $identifier, userRef: $userRef)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SessionOtpCredential &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.identifier, identifier) ||
                other.identifier == identifier) &&
            (identical(other.userRef, userRef) || other.userRef == userRef));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, type, identifier, userRef);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SessionOtpCredentialCopyWith<_$_SessionOtpCredential> get copyWith =>
      __$$_SessionOtpCredentialCopyWithImpl<_$_SessionOtpCredential>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SessionOtpCredentialToJson(
      this,
    );
  }
}

abstract class _SessionOtpCredential implements SessionOtpCredential {
  const factory _SessionOtpCredential(
      {required final AppType type,
      required final String identifier,
      required final String userRef}) = _$_SessionOtpCredential;

  factory _SessionOtpCredential.fromJson(Map<String, dynamic> json) =
      _$_SessionOtpCredential.fromJson;

  @override
  AppType get type;
  @override
  String get identifier;
  @override
  String get userRef;
  @override
  @JsonKey(ignore: true)
  _$$_SessionOtpCredentialCopyWith<_$_SessionOtpCredential> get copyWith =>
      throw _privateConstructorUsedError;
}
