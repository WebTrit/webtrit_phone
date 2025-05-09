// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'external_page_access_token.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ExternalPageAccessToken _$ExternalPageAccessTokenFromJson(
    Map<String, dynamic> json) {
  return _ExternalPageAccessToken.fromJson(json);
}

/// @nodoc
mixin _$ExternalPageAccessToken {
  @JsonKey(name: 'access_token')
  String get accessToken => throw _privateConstructorUsedError;
  @JsonKey(name: 'refresh_token')
  String get refreshToken => throw _privateConstructorUsedError;
  @JsonKey(name: 'expires_at')
  DateTime get expiresAt => throw _privateConstructorUsedError;

  /// Serializes this ExternalPageAccessToken to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExternalPageAccessToken
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExternalPageAccessTokenCopyWith<ExternalPageAccessToken> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExternalPageAccessTokenCopyWith<$Res> {
  factory $ExternalPageAccessTokenCopyWith(ExternalPageAccessToken value,
          $Res Function(ExternalPageAccessToken) then) =
      _$ExternalPageAccessTokenCopyWithImpl<$Res, ExternalPageAccessToken>;
  @useResult
  $Res call(
      {@JsonKey(name: 'access_token') String accessToken,
      @JsonKey(name: 'refresh_token') String refreshToken,
      @JsonKey(name: 'expires_at') DateTime expiresAt});
}

/// @nodoc
class _$ExternalPageAccessTokenCopyWithImpl<$Res,
        $Val extends ExternalPageAccessToken>
    implements $ExternalPageAccessTokenCopyWith<$Res> {
  _$ExternalPageAccessTokenCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExternalPageAccessToken
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? refreshToken = null,
    Object? expiresAt = null,
  }) {
    return _then(_value.copyWith(
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
      expiresAt: null == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExternalPageAccessTokenImplCopyWith<$Res>
    implements $ExternalPageAccessTokenCopyWith<$Res> {
  factory _$$ExternalPageAccessTokenImplCopyWith(
          _$ExternalPageAccessTokenImpl value,
          $Res Function(_$ExternalPageAccessTokenImpl) then) =
      __$$ExternalPageAccessTokenImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'access_token') String accessToken,
      @JsonKey(name: 'refresh_token') String refreshToken,
      @JsonKey(name: 'expires_at') DateTime expiresAt});
}

/// @nodoc
class __$$ExternalPageAccessTokenImplCopyWithImpl<$Res>
    extends _$ExternalPageAccessTokenCopyWithImpl<$Res,
        _$ExternalPageAccessTokenImpl>
    implements _$$ExternalPageAccessTokenImplCopyWith<$Res> {
  __$$ExternalPageAccessTokenImplCopyWithImpl(
      _$ExternalPageAccessTokenImpl _value,
      $Res Function(_$ExternalPageAccessTokenImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExternalPageAccessToken
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? refreshToken = null,
    Object? expiresAt = null,
  }) {
    return _then(_$ExternalPageAccessTokenImpl(
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
      expiresAt: null == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$ExternalPageAccessTokenImpl implements _ExternalPageAccessToken {
  const _$ExternalPageAccessTokenImpl(
      {@JsonKey(name: 'access_token') required this.accessToken,
      @JsonKey(name: 'refresh_token') required this.refreshToken,
      @JsonKey(name: 'expires_at') required this.expiresAt});

  factory _$ExternalPageAccessTokenImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExternalPageAccessTokenImplFromJson(json);

  @override
  @JsonKey(name: 'access_token')
  final String accessToken;
  @override
  @JsonKey(name: 'refresh_token')
  final String refreshToken;
  @override
  @JsonKey(name: 'expires_at')
  final DateTime expiresAt;

  @override
  String toString() {
    return 'ExternalPageAccessToken(accessToken: $accessToken, refreshToken: $refreshToken, expiresAt: $expiresAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExternalPageAccessTokenImpl &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, accessToken, refreshToken, expiresAt);

  /// Create a copy of ExternalPageAccessToken
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExternalPageAccessTokenImplCopyWith<_$ExternalPageAccessTokenImpl>
      get copyWith => __$$ExternalPageAccessTokenImplCopyWithImpl<
          _$ExternalPageAccessTokenImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExternalPageAccessTokenImplToJson(
      this,
    );
  }
}

abstract class _ExternalPageAccessToken implements ExternalPageAccessToken {
  const factory _ExternalPageAccessToken(
          {@JsonKey(name: 'access_token') required final String accessToken,
          @JsonKey(name: 'refresh_token') required final String refreshToken,
          @JsonKey(name: 'expires_at') required final DateTime expiresAt}) =
      _$ExternalPageAccessTokenImpl;

  factory _ExternalPageAccessToken.fromJson(Map<String, dynamic> json) =
      _$ExternalPageAccessTokenImpl.fromJson;

  @override
  @JsonKey(name: 'access_token')
  String get accessToken;
  @override
  @JsonKey(name: 'refresh_token')
  String get refreshToken;
  @override
  @JsonKey(name: 'expires_at')
  DateTime get expiresAt;

  /// Create a copy of ExternalPageAccessToken
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExternalPageAccessTokenImplCopyWith<_$ExternalPageAccessTokenImpl>
      get copyWith => throw _privateConstructorUsedError;
}
