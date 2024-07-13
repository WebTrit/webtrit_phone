// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'demo_credential.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DemoCredential _$DemoCredentialFromJson(Map<String, dynamic> json) {
  return _DemoCredential.fromJson(json);
}

/// @nodoc
mixin _$DemoCredential {
  AppType get type => throw _privateConstructorUsedError;
  String get identifier => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get tenantId => throw _privateConstructorUsedError;
  String get action => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DemoCredentialCopyWith<DemoCredential> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DemoCredentialCopyWith<$Res> {
  factory $DemoCredentialCopyWith(
          DemoCredential value, $Res Function(DemoCredential) then) =
      _$DemoCredentialCopyWithImpl<$Res, DemoCredential>;
  @useResult
  $Res call(
      {AppType type,
      String identifier,
      String email,
      String tenantId,
      String action});
}

/// @nodoc
class _$DemoCredentialCopyWithImpl<$Res, $Val extends DemoCredential>
    implements $DemoCredentialCopyWith<$Res> {
  _$DemoCredentialCopyWithImpl(this._value, this._then);

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
abstract class _$$DemoCredentialImplCopyWith<$Res>
    implements $DemoCredentialCopyWith<$Res> {
  factory _$$DemoCredentialImplCopyWith(_$DemoCredentialImpl value,
          $Res Function(_$DemoCredentialImpl) then) =
      __$$DemoCredentialImplCopyWithImpl<$Res>;
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
class __$$DemoCredentialImplCopyWithImpl<$Res>
    extends _$DemoCredentialCopyWithImpl<$Res, _$DemoCredentialImpl>
    implements _$$DemoCredentialImplCopyWith<$Res> {
  __$$DemoCredentialImplCopyWithImpl(
      _$DemoCredentialImpl _value, $Res Function(_$DemoCredentialImpl) _then)
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
    return _then(_$DemoCredentialImpl(
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
class _$DemoCredentialImpl implements _DemoCredential {
  const _$DemoCredentialImpl(
      {required this.type,
      required this.identifier,
      required this.email,
      required this.tenantId,
      required this.action});

  factory _$DemoCredentialImpl.fromJson(Map<String, dynamic> json) =>
      _$$DemoCredentialImplFromJson(json);

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
    return 'DemoCredential(type: $type, identifier: $identifier, email: $email, tenantId: $tenantId, action: $action)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DemoCredentialImpl &&
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
  _$$DemoCredentialImplCopyWith<_$DemoCredentialImpl> get copyWith =>
      __$$DemoCredentialImplCopyWithImpl<_$DemoCredentialImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DemoCredentialImplToJson(
      this,
    );
  }
}

abstract class _DemoCredential implements DemoCredential {
  const factory _DemoCredential(
      {required final AppType type,
      required final String identifier,
      required final String email,
      required final String tenantId,
      required final String action}) = _$DemoCredentialImpl;

  factory _DemoCredential.fromJson(Map<String, dynamic> json) =
      _$DemoCredentialImpl.fromJson;

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
  _$$DemoCredentialImplCopyWith<_$DemoCredentialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
