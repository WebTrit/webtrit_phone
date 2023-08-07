// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_user_credential.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SessionUserCredential _$SessionUserCredentialFromJson(
    Map<String, dynamic> json) {
  return _SessionUserCredential.fromJson(json);
}

/// @nodoc
mixin _$SessionUserCredential {
  String? get bundleId => throw _privateConstructorUsedError;
  AppType get type => throw _privateConstructorUsedError;
  String get identifier => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SessionUserCredentialCopyWith<SessionUserCredential> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionUserCredentialCopyWith<$Res> {
  factory $SessionUserCredentialCopyWith(SessionUserCredential value,
          $Res Function(SessionUserCredential) then) =
      _$SessionUserCredentialCopyWithImpl<$Res, SessionUserCredential>;
  @useResult
  $Res call({String? bundleId, AppType type, String identifier, String email});
}

/// @nodoc
class _$SessionUserCredentialCopyWithImpl<$Res,
        $Val extends SessionUserCredential>
    implements $SessionUserCredentialCopyWith<$Res> {
  _$SessionUserCredentialCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bundleId = freezed,
    Object? type = null,
    Object? identifier = null,
    Object? email = null,
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
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SessionUserCredentialCopyWith<$Res>
    implements $SessionUserCredentialCopyWith<$Res> {
  factory _$$_SessionUserCredentialCopyWith(_$_SessionUserCredential value,
          $Res Function(_$_SessionUserCredential) then) =
      __$$_SessionUserCredentialCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? bundleId, AppType type, String identifier, String email});
}

/// @nodoc
class __$$_SessionUserCredentialCopyWithImpl<$Res>
    extends _$SessionUserCredentialCopyWithImpl<$Res, _$_SessionUserCredential>
    implements _$$_SessionUserCredentialCopyWith<$Res> {
  __$$_SessionUserCredentialCopyWithImpl(_$_SessionUserCredential _value,
      $Res Function(_$_SessionUserCredential) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bundleId = freezed,
    Object? type = null,
    Object? identifier = null,
    Object? email = null,
  }) {
    return _then(_$_SessionUserCredential(
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
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_SessionUserCredential implements _SessionUserCredential {
  const _$_SessionUserCredential(
      {this.bundleId,
      required this.type,
      required this.identifier,
      required this.email});

  factory _$_SessionUserCredential.fromJson(Map<String, dynamic> json) =>
      _$$_SessionUserCredentialFromJson(json);

  @override
  final String? bundleId;
  @override
  final AppType type;
  @override
  final String identifier;
  @override
  final String email;

  @override
  String toString() {
    return 'SessionUserCredential(bundleId: $bundleId, type: $type, identifier: $identifier, email: $email)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SessionUserCredential &&
            (identical(other.bundleId, bundleId) ||
                other.bundleId == bundleId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.identifier, identifier) ||
                other.identifier == identifier) &&
            (identical(other.email, email) || other.email == email));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, bundleId, type, identifier, email);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SessionUserCredentialCopyWith<_$_SessionUserCredential> get copyWith =>
      __$$_SessionUserCredentialCopyWithImpl<_$_SessionUserCredential>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SessionUserCredentialToJson(
      this,
    );
  }
}

abstract class _SessionUserCredential implements SessionUserCredential {
  const factory _SessionUserCredential(
      {final String? bundleId,
      required final AppType type,
      required final String identifier,
      required final String email}) = _$_SessionUserCredential;

  factory _SessionUserCredential.fromJson(Map<String, dynamic> json) =
      _$_SessionUserCredential.fromJson;

  @override
  String? get bundleId;
  @override
  AppType get type;
  @override
  String get identifier;
  @override
  String get email;
  @override
  @JsonKey(ignore: true)
  _$$_SessionUserCredentialCopyWith<_$_SessionUserCredential> get copyWith =>
      throw _privateConstructorUsedError;
}
