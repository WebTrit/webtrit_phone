// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_action_credential.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserActionCredential _$UserActionCredentialFromJson(Map<String, dynamic> json) {
  return _UserActionCredential.fromJson(json);
}

/// @nodoc
mixin _$UserActionCredential {
  AppType get type => throw _privateConstructorUsedError;
  String get identifier => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get tenantId => throw _privateConstructorUsedError;
  String get action => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserActionCredentialCopyWith<UserActionCredential> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserActionCredentialCopyWith<$Res> {
  factory $UserActionCredentialCopyWith(UserActionCredential value,
          $Res Function(UserActionCredential) then) =
      _$UserActionCredentialCopyWithImpl<$Res, UserActionCredential>;
  @useResult
  $Res call(
      {AppType type,
      String identifier,
      String email,
      String tenantId,
      String action});
}

/// @nodoc
class _$UserActionCredentialCopyWithImpl<$Res,
        $Val extends UserActionCredential>
    implements $UserActionCredentialCopyWith<$Res> {
  _$UserActionCredentialCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? identifier = null,
    Object? email = null,
    Object? tenantId = null,
    Object? action = null,
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
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      tenantId: null == tenantId
          ? _value.tenantId
          : tenantId // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserActionCredentialCopyWith<$Res>
    implements $UserActionCredentialCopyWith<$Res> {
  factory _$$_UserActionCredentialCopyWith(_$_UserActionCredential value,
          $Res Function(_$_UserActionCredential) then) =
      __$$_UserActionCredentialCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AppType type,
      String identifier,
      String email,
      String tenantId,
      String action});
}

/// @nodoc
class __$$_UserActionCredentialCopyWithImpl<$Res>
    extends _$UserActionCredentialCopyWithImpl<$Res, _$_UserActionCredential>
    implements _$$_UserActionCredentialCopyWith<$Res> {
  __$$_UserActionCredentialCopyWithImpl(_$_UserActionCredential _value,
      $Res Function(_$_UserActionCredential) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? identifier = null,
    Object? email = null,
    Object? tenantId = null,
    Object? action = null,
  }) {
    return _then(_$_UserActionCredential(
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
      tenantId: null == tenantId
          ? _value.tenantId
          : tenantId // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_UserActionCredential implements _UserActionCredential {
  const _$_UserActionCredential(
      {required this.type,
      required this.identifier,
      required this.email,
      required this.tenantId,
      required this.action});

  factory _$_UserActionCredential.fromJson(Map<String, dynamic> json) =>
      _$$_UserActionCredentialFromJson(json);

  @override
  final AppType type;
  @override
  final String identifier;
  @override
  final String email;
  @override
  final String tenantId;
  @override
  final String action;

  @override
  String toString() {
    return 'UserActionCredential(type: $type, identifier: $identifier, email: $email, tenantId: $tenantId, action: $action)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserActionCredential &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.identifier, identifier) ||
                other.identifier == identifier) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.tenantId, tenantId) ||
                other.tenantId == tenantId) &&
            (identical(other.action, action) || other.action == action));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, type, identifier, email, tenantId, action);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserActionCredentialCopyWith<_$_UserActionCredential> get copyWith =>
      __$$_UserActionCredentialCopyWithImpl<_$_UserActionCredential>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserActionCredentialToJson(
      this,
    );
  }
}

abstract class _UserActionCredential implements UserActionCredential {
  const factory _UserActionCredential(
      {required final AppType type,
      required final String identifier,
      required final String email,
      required final String tenantId,
      required final String action}) = _$_UserActionCredential;

  factory _UserActionCredential.fromJson(Map<String, dynamic> json) =
      _$_UserActionCredential.fromJson;

  @override
  AppType get type;
  @override
  String get identifier;
  @override
  String get email;
  @override
  String get tenantId;
  @override
  String get action;
  @override
  @JsonKey(ignore: true)
  _$$_UserActionCredentialCopyWith<_$_UserActionCredential> get copyWith =>
      throw _privateConstructorUsedError;
}
