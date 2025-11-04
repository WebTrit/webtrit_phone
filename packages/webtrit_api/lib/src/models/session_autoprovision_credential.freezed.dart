// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_autoprovision_credential.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SessionAutoProvisionCredential _$SessionAutoProvisionCredentialFromJson(
  Map<String, dynamic> json,
) {
  return _SessionAutoProvisionCredential.fromJson(json);
}

/// @nodoc
mixin _$SessionAutoProvisionCredential {
  String? get bundleId => throw _privateConstructorUsedError;
  AppType get type => throw _privateConstructorUsedError;
  String get identifier => throw _privateConstructorUsedError;
  String get configToken => throw _privateConstructorUsedError;

  /// Serializes this SessionAutoProvisionCredential to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SessionAutoProvisionCredential
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SessionAutoProvisionCredentialCopyWith<SessionAutoProvisionCredential>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionAutoProvisionCredentialCopyWith<$Res> {
  factory $SessionAutoProvisionCredentialCopyWith(
    SessionAutoProvisionCredential value,
    $Res Function(SessionAutoProvisionCredential) then,
  ) =
      _$SessionAutoProvisionCredentialCopyWithImpl<
        $Res,
        SessionAutoProvisionCredential
      >;
  @useResult
  $Res call({
    String? bundleId,
    AppType type,
    String identifier,
    String configToken,
  });
}

/// @nodoc
class _$SessionAutoProvisionCredentialCopyWithImpl<
  $Res,
  $Val extends SessionAutoProvisionCredential
>
    implements $SessionAutoProvisionCredentialCopyWith<$Res> {
  _$SessionAutoProvisionCredentialCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SessionAutoProvisionCredential
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bundleId = freezed,
    Object? type = null,
    Object? identifier = null,
    Object? configToken = null,
  }) {
    return _then(
      _value.copyWith(
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
            configToken: null == configToken
                ? _value.configToken
                : configToken // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SessionAutoProvisionCredentialImplCopyWith<$Res>
    implements $SessionAutoProvisionCredentialCopyWith<$Res> {
  factory _$$SessionAutoProvisionCredentialImplCopyWith(
    _$SessionAutoProvisionCredentialImpl value,
    $Res Function(_$SessionAutoProvisionCredentialImpl) then,
  ) = __$$SessionAutoProvisionCredentialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? bundleId,
    AppType type,
    String identifier,
    String configToken,
  });
}

/// @nodoc
class __$$SessionAutoProvisionCredentialImplCopyWithImpl<$Res>
    extends
        _$SessionAutoProvisionCredentialCopyWithImpl<
          $Res,
          _$SessionAutoProvisionCredentialImpl
        >
    implements _$$SessionAutoProvisionCredentialImplCopyWith<$Res> {
  __$$SessionAutoProvisionCredentialImplCopyWithImpl(
    _$SessionAutoProvisionCredentialImpl _value,
    $Res Function(_$SessionAutoProvisionCredentialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SessionAutoProvisionCredential
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bundleId = freezed,
    Object? type = null,
    Object? identifier = null,
    Object? configToken = null,
  }) {
    return _then(
      _$SessionAutoProvisionCredentialImpl(
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
        configToken: null == configToken
            ? _value.configToken
            : configToken // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$SessionAutoProvisionCredentialImpl
    implements _SessionAutoProvisionCredential {
  const _$SessionAutoProvisionCredentialImpl({
    this.bundleId,
    required this.type,
    required this.identifier,
    required this.configToken,
  });

  factory _$SessionAutoProvisionCredentialImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$SessionAutoProvisionCredentialImplFromJson(json);

  @override
  final String? bundleId;
  @override
  final AppType type;
  @override
  final String identifier;
  @override
  final String configToken;

  @override
  String toString() {
    return 'SessionAutoProvisionCredential(bundleId: $bundleId, type: $type, identifier: $identifier, configToken: $configToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionAutoProvisionCredentialImpl &&
            (identical(other.bundleId, bundleId) ||
                other.bundleId == bundleId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.identifier, identifier) ||
                other.identifier == identifier) &&
            (identical(other.configToken, configToken) ||
                other.configToken == configToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, bundleId, type, identifier, configToken);

  /// Create a copy of SessionAutoProvisionCredential
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionAutoProvisionCredentialImplCopyWith<
    _$SessionAutoProvisionCredentialImpl
  >
  get copyWith =>
      __$$SessionAutoProvisionCredentialImplCopyWithImpl<
        _$SessionAutoProvisionCredentialImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SessionAutoProvisionCredentialImplToJson(this);
  }
}

abstract class _SessionAutoProvisionCredential
    implements SessionAutoProvisionCredential {
  const factory _SessionAutoProvisionCredential({
    final String? bundleId,
    required final AppType type,
    required final String identifier,
    required final String configToken,
  }) = _$SessionAutoProvisionCredentialImpl;

  factory _SessionAutoProvisionCredential.fromJson(Map<String, dynamic> json) =
      _$SessionAutoProvisionCredentialImpl.fromJson;

  @override
  String? get bundleId;
  @override
  AppType get type;
  @override
  String get identifier;
  @override
  String get configToken;

  /// Create a copy of SessionAutoProvisionCredential
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionAutoProvisionCredentialImplCopyWith<
    _$SessionAutoProvisionCredentialImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}
