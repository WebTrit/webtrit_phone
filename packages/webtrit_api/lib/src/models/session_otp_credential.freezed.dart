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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SessionOtpCredential _$SessionOtpCredentialFromJson(Map<String, dynamic> json) {
  return _SessionOtpCredential.fromJson(json);
}

/// @nodoc
mixin _$SessionOtpCredential {
  String? get bundleId => throw _privateConstructorUsedError;
  AppType get type => throw _privateConstructorUsedError;
  String get identifier => throw _privateConstructorUsedError;
  String get userRef => throw _privateConstructorUsedError;

  /// Serializes this SessionOtpCredential to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SessionOtpCredential
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SessionOtpCredentialCopyWith<SessionOtpCredential> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionOtpCredentialCopyWith<$Res> {
  factory $SessionOtpCredentialCopyWith(SessionOtpCredential value,
          $Res Function(SessionOtpCredential) then) =
      _$SessionOtpCredentialCopyWithImpl<$Res, SessionOtpCredential>;
  @useResult
  $Res call(
      {String? bundleId, AppType type, String identifier, String userRef});
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

  /// Create a copy of SessionOtpCredential
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bundleId = freezed,
    Object? type = null,
    Object? identifier = null,
    Object? userRef = null,
  }) {
    return _then(_value.copyWith(
      bundleId: freezed == bundleId
          ? _value.bundleId
          : bundleId // ignore: cast_nullable_to_non_nullable
              as String?,
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
abstract class _$$SessionOtpCredentialImplCopyWith<$Res>
    implements $SessionOtpCredentialCopyWith<$Res> {
  factory _$$SessionOtpCredentialImplCopyWith(_$SessionOtpCredentialImpl value,
          $Res Function(_$SessionOtpCredentialImpl) then) =
      __$$SessionOtpCredentialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? bundleId, AppType type, String identifier, String userRef});
}

/// @nodoc
class __$$SessionOtpCredentialImplCopyWithImpl<$Res>
    extends _$SessionOtpCredentialCopyWithImpl<$Res, _$SessionOtpCredentialImpl>
    implements _$$SessionOtpCredentialImplCopyWith<$Res> {
  __$$SessionOtpCredentialImplCopyWithImpl(_$SessionOtpCredentialImpl _value,
      $Res Function(_$SessionOtpCredentialImpl) _then)
      : super(_value, _then);

  /// Create a copy of SessionOtpCredential
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bundleId = freezed,
    Object? type = null,
    Object? identifier = null,
    Object? userRef = null,
  }) {
    return _then(_$SessionOtpCredentialImpl(
      bundleId: freezed == bundleId
          ? _value.bundleId
          : bundleId // ignore: cast_nullable_to_non_nullable
              as String?,
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
class _$SessionOtpCredentialImpl implements _SessionOtpCredential {
  const _$SessionOtpCredentialImpl(
      {this.bundleId,
      required this.type,
      required this.identifier,
      required this.userRef});

  factory _$SessionOtpCredentialImpl.fromJson(Map<String, dynamic> json) =>
      _$$SessionOtpCredentialImplFromJson(json);

  @override
  final String? bundleId;
  @override
  final AppType type;
  @override
  final String identifier;
  @override
  final String userRef;

  @override
  String toString() {
    return 'SessionOtpCredential(bundleId: $bundleId, type: $type, identifier: $identifier, userRef: $userRef)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionOtpCredentialImpl &&
            (identical(other.bundleId, bundleId) ||
                other.bundleId == bundleId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.identifier, identifier) ||
                other.identifier == identifier) &&
            (identical(other.userRef, userRef) || other.userRef == userRef));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, bundleId, type, identifier, userRef);

  /// Create a copy of SessionOtpCredential
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionOtpCredentialImplCopyWith<_$SessionOtpCredentialImpl>
      get copyWith =>
          __$$SessionOtpCredentialImplCopyWithImpl<_$SessionOtpCredentialImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SessionOtpCredentialImplToJson(
      this,
    );
  }
}

abstract class _SessionOtpCredential implements SessionOtpCredential {
  const factory _SessionOtpCredential(
      {final String? bundleId,
      required final AppType type,
      required final String identifier,
      required final String userRef}) = _$SessionOtpCredentialImpl;

  factory _SessionOtpCredential.fromJson(Map<String, dynamic> json) =
      _$SessionOtpCredentialImpl.fromJson;

  @override
  String? get bundleId;
  @override
  AppType get type;
  @override
  String get identifier;
  @override
  String get userRef;

  /// Create a copy of SessionOtpCredential
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionOtpCredentialImplCopyWith<_$SessionOtpCredentialImpl>
      get copyWith => throw _privateConstructorUsedError;
}
