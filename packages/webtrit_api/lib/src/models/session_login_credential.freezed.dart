// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_login_credential.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SessionLoginCredential _$SessionLoginCredentialFromJson(
    Map<String, dynamic> json) {
  return _SessionLoginCredential.fromJson(json);
}

/// @nodoc
mixin _$SessionLoginCredential {
  String? get bundleId => throw _privateConstructorUsedError;
  AppType get type => throw _privateConstructorUsedError;
  String get identifier => throw _privateConstructorUsedError;
  String get login => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SessionLoginCredentialCopyWith<SessionLoginCredential> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionLoginCredentialCopyWith<$Res> {
  factory $SessionLoginCredentialCopyWith(SessionLoginCredential value,
          $Res Function(SessionLoginCredential) then) =
      _$SessionLoginCredentialCopyWithImpl<$Res, SessionLoginCredential>;
  @useResult
  $Res call(
      {String? bundleId,
      AppType type,
      String identifier,
      String login,
      String password});
}

/// @nodoc
class _$SessionLoginCredentialCopyWithImpl<$Res,
        $Val extends SessionLoginCredential>
    implements $SessionLoginCredentialCopyWith<$Res> {
  _$SessionLoginCredentialCopyWithImpl(this._value, this._then);

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
    Object? login = null,
    Object? password = null,
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
      login: null == login
          ? _value.login
          : login // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SessionLoginCredentialImplCopyWith<$Res>
    implements $SessionLoginCredentialCopyWith<$Res> {
  factory _$$SessionLoginCredentialImplCopyWith(
          _$SessionLoginCredentialImpl value,
          $Res Function(_$SessionLoginCredentialImpl) then) =
      __$$SessionLoginCredentialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? bundleId,
      AppType type,
      String identifier,
      String login,
      String password});
}

/// @nodoc
class __$$SessionLoginCredentialImplCopyWithImpl<$Res>
    extends _$SessionLoginCredentialCopyWithImpl<$Res,
        _$SessionLoginCredentialImpl>
    implements _$$SessionLoginCredentialImplCopyWith<$Res> {
  __$$SessionLoginCredentialImplCopyWithImpl(
      _$SessionLoginCredentialImpl _value,
      $Res Function(_$SessionLoginCredentialImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bundleId = freezed,
    Object? type = null,
    Object? identifier = null,
    Object? login = null,
    Object? password = null,
  }) {
    return _then(_$SessionLoginCredentialImpl(
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
      login: null == login
          ? _value.login
          : login // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$SessionLoginCredentialImpl implements _SessionLoginCredential {
  const _$SessionLoginCredentialImpl(
      {this.bundleId,
      required this.type,
      required this.identifier,
      required this.login,
      required this.password});

  factory _$SessionLoginCredentialImpl.fromJson(Map<String, dynamic> json) =>
      _$$SessionLoginCredentialImplFromJson(json);

  @override
  final String? bundleId;
  @override
  final AppType type;
  @override
  final String identifier;
  @override
  final String login;
  @override
  final String password;

  @override
  String toString() {
    return 'SessionLoginCredential(bundleId: $bundleId, type: $type, identifier: $identifier, login: $login, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionLoginCredentialImpl &&
            (identical(other.bundleId, bundleId) ||
                other.bundleId == bundleId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.identifier, identifier) ||
                other.identifier == identifier) &&
            (identical(other.login, login) || other.login == login) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, bundleId, type, identifier, login, password);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionLoginCredentialImplCopyWith<_$SessionLoginCredentialImpl>
      get copyWith => __$$SessionLoginCredentialImplCopyWithImpl<
          _$SessionLoginCredentialImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SessionLoginCredentialImplToJson(
      this,
    );
  }
}

abstract class _SessionLoginCredential implements SessionLoginCredential {
  const factory _SessionLoginCredential(
      {final String? bundleId,
      required final AppType type,
      required final String identifier,
      required final String login,
      required final String password}) = _$SessionLoginCredentialImpl;

  factory _SessionLoginCredential.fromJson(Map<String, dynamic> json) =
      _$SessionLoginCredentialImpl.fromJson;

  @override
  String? get bundleId;
  @override
  AppType get type;
  @override
  String get identifier;
  @override
  String get login;
  @override
  String get password;
  @override
  @JsonKey(ignore: true)
  _$$SessionLoginCredentialImplCopyWith<_$SessionLoginCredentialImpl>
      get copyWith => throw _privateConstructorUsedError;
}
