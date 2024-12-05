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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SessionUserCredential _$SessionUserCredentialFromJson(
    Map<String, dynamic> json) {
  return _SessionUserCredential.fromJson(json);
}

/// @nodoc
mixin _$SessionUserCredential {
  String? get bundleId => throw _privateConstructorUsedError;
  AppType get type => throw _privateConstructorUsedError;
  String get identifier => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;

  /// Serializes this SessionUserCredential to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SessionUserCredential
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SessionUserCredentialCopyWith<SessionUserCredential> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionUserCredentialCopyWith<$Res> {
  factory $SessionUserCredentialCopyWith(SessionUserCredential value,
          $Res Function(SessionUserCredential) then) =
      _$SessionUserCredentialCopyWithImpl<$Res, SessionUserCredential>;
  @useResult
  $Res call({String? bundleId, AppType type, String identifier, String? email});
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

  /// Create a copy of SessionUserCredential
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bundleId = freezed,
    Object? type = null,
    Object? identifier = null,
    Object? email = freezed,
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
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SessionUserCredentialImplCopyWith<$Res>
    implements $SessionUserCredentialCopyWith<$Res> {
  factory _$$SessionUserCredentialImplCopyWith(
          _$SessionUserCredentialImpl value,
          $Res Function(_$SessionUserCredentialImpl) then) =
      __$$SessionUserCredentialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? bundleId, AppType type, String identifier, String? email});
}

/// @nodoc
class __$$SessionUserCredentialImplCopyWithImpl<$Res>
    extends _$SessionUserCredentialCopyWithImpl<$Res,
        _$SessionUserCredentialImpl>
    implements _$$SessionUserCredentialImplCopyWith<$Res> {
  __$$SessionUserCredentialImplCopyWithImpl(_$SessionUserCredentialImpl _value,
      $Res Function(_$SessionUserCredentialImpl) _then)
      : super(_value, _then);

  /// Create a copy of SessionUserCredential
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bundleId = freezed,
    Object? type = null,
    Object? identifier = null,
    Object? email = freezed,
  }) {
    return _then(_$SessionUserCredentialImpl(
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
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$SessionUserCredentialImpl implements _SessionUserCredential {
  const _$SessionUserCredentialImpl(
      {this.bundleId,
      required this.type,
      required this.identifier,
      this.email});

  factory _$SessionUserCredentialImpl.fromJson(Map<String, dynamic> json) =>
      _$$SessionUserCredentialImplFromJson(json);

  @override
  final String? bundleId;
  @override
  final AppType type;
  @override
  final String identifier;
  @override
  final String? email;

  @override
  String toString() {
    return 'SessionUserCredential(bundleId: $bundleId, type: $type, identifier: $identifier, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionUserCredentialImpl &&
            (identical(other.bundleId, bundleId) ||
                other.bundleId == bundleId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.identifier, identifier) ||
                other.identifier == identifier) &&
            (identical(other.email, email) || other.email == email));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, bundleId, type, identifier, email);

  /// Create a copy of SessionUserCredential
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionUserCredentialImplCopyWith<_$SessionUserCredentialImpl>
      get copyWith => __$$SessionUserCredentialImplCopyWithImpl<
          _$SessionUserCredentialImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SessionUserCredentialImplToJson(
      this,
    );
  }
}

abstract class _SessionUserCredential implements SessionUserCredential {
  const factory _SessionUserCredential(
      {final String? bundleId,
      required final AppType type,
      required final String identifier,
      final String? email}) = _$SessionUserCredentialImpl;

  factory _SessionUserCredential.fromJson(Map<String, dynamic> json) =
      _$SessionUserCredentialImpl.fromJson;

  @override
  String? get bundleId;
  @override
  AppType get type;
  @override
  String get identifier;
  @override
  String? get email;

  /// Create a copy of SessionUserCredential
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionUserCredentialImplCopyWith<_$SessionUserCredentialImpl>
      get copyWith => throw _privateConstructorUsedError;
}
