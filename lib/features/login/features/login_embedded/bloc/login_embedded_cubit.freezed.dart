// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_embedded_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LoginEmbeddedState {
  bool get processing => throw _privateConstructorUsedError;
  String? get coreUrl => throw _privateConstructorUsedError;
  SessionResult? get result => throw _privateConstructorUsedError;
  String? get tenantId => throw _privateConstructorUsedError;
  String? get token => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;
  (
    SessionOtpProvisional,
    DateTime
  )? get signupSessionOtpProvisionalWithDateTime =>
      throw _privateConstructorUsedError;

  /// Create a copy of LoginEmbeddedState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoginEmbeddedStateCopyWith<LoginEmbeddedState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginEmbeddedStateCopyWith<$Res> {
  factory $LoginEmbeddedStateCopyWith(
          LoginEmbeddedState value, $Res Function(LoginEmbeddedState) then) =
      _$LoginEmbeddedStateCopyWithImpl<$Res, LoginEmbeddedState>;
  @useResult
  $Res call(
      {bool processing,
      String? coreUrl,
      SessionResult? result,
      String? tenantId,
      String? token,
      String? userId,
      (
        SessionOtpProvisional,
        DateTime
      )? signupSessionOtpProvisionalWithDateTime});

  $SessionResultCopyWith<$Res>? get result;
}

/// @nodoc
class _$LoginEmbeddedStateCopyWithImpl<$Res, $Val extends LoginEmbeddedState>
    implements $LoginEmbeddedStateCopyWith<$Res> {
  _$LoginEmbeddedStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginEmbeddedState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? processing = null,
    Object? coreUrl = freezed,
    Object? result = freezed,
    Object? tenantId = freezed,
    Object? token = freezed,
    Object? userId = freezed,
    Object? signupSessionOtpProvisionalWithDateTime = freezed,
  }) {
    return _then(_value.copyWith(
      processing: null == processing
          ? _value.processing
          : processing // ignore: cast_nullable_to_non_nullable
              as bool,
      coreUrl: freezed == coreUrl
          ? _value.coreUrl
          : coreUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as SessionResult?,
      tenantId: freezed == tenantId
          ? _value.tenantId
          : tenantId // ignore: cast_nullable_to_non_nullable
              as String?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      signupSessionOtpProvisionalWithDateTime: freezed ==
              signupSessionOtpProvisionalWithDateTime
          ? _value.signupSessionOtpProvisionalWithDateTime
          : signupSessionOtpProvisionalWithDateTime // ignore: cast_nullable_to_non_nullable
              as (SessionOtpProvisional, DateTime)?,
    ) as $Val);
  }

  /// Create a copy of LoginEmbeddedState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SessionResultCopyWith<$Res>? get result {
    if (_value.result == null) {
      return null;
    }

    return $SessionResultCopyWith<$Res>(_value.result!, (value) {
      return _then(_value.copyWith(result: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LoginCustomSigninStateImplCopyWith<$Res>
    implements $LoginEmbeddedStateCopyWith<$Res> {
  factory _$$LoginCustomSigninStateImplCopyWith(
          _$LoginCustomSigninStateImpl value,
          $Res Function(_$LoginCustomSigninStateImpl) then) =
      __$$LoginCustomSigninStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool processing,
      String? coreUrl,
      SessionResult? result,
      String? tenantId,
      String? token,
      String? userId,
      (
        SessionOtpProvisional,
        DateTime
      )? signupSessionOtpProvisionalWithDateTime});

  @override
  $SessionResultCopyWith<$Res>? get result;
}

/// @nodoc
class __$$LoginCustomSigninStateImplCopyWithImpl<$Res>
    extends _$LoginEmbeddedStateCopyWithImpl<$Res, _$LoginCustomSigninStateImpl>
    implements _$$LoginCustomSigninStateImplCopyWith<$Res> {
  __$$LoginCustomSigninStateImplCopyWithImpl(
      _$LoginCustomSigninStateImpl _value,
      $Res Function(_$LoginCustomSigninStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoginEmbeddedState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? processing = null,
    Object? coreUrl = freezed,
    Object? result = freezed,
    Object? tenantId = freezed,
    Object? token = freezed,
    Object? userId = freezed,
    Object? signupSessionOtpProvisionalWithDateTime = freezed,
  }) {
    return _then(_$LoginCustomSigninStateImpl(
      processing: null == processing
          ? _value.processing
          : processing // ignore: cast_nullable_to_non_nullable
              as bool,
      coreUrl: freezed == coreUrl
          ? _value.coreUrl
          : coreUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as SessionResult?,
      tenantId: freezed == tenantId
          ? _value.tenantId
          : tenantId // ignore: cast_nullable_to_non_nullable
              as String?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      signupSessionOtpProvisionalWithDateTime: freezed ==
              signupSessionOtpProvisionalWithDateTime
          ? _value.signupSessionOtpProvisionalWithDateTime
          : signupSessionOtpProvisionalWithDateTime // ignore: cast_nullable_to_non_nullable
              as (SessionOtpProvisional, DateTime)?,
    ));
  }
}

/// @nodoc

class _$LoginCustomSigninStateImpl implements _LoginCustomSigninState {
  const _$LoginCustomSigninStateImpl(
      {this.processing = false,
      this.coreUrl,
      this.result,
      this.tenantId,
      this.token,
      this.userId,
      this.signupSessionOtpProvisionalWithDateTime});

  @override
  @JsonKey()
  final bool processing;
  @override
  final String? coreUrl;
  @override
  final SessionResult? result;
  @override
  final String? tenantId;
  @override
  final String? token;
  @override
  final String? userId;
  @override
  final (
    SessionOtpProvisional,
    DateTime
  )? signupSessionOtpProvisionalWithDateTime;

  @override
  String toString() {
    return 'LoginEmbeddedState(processing: $processing, coreUrl: $coreUrl, result: $result, tenantId: $tenantId, token: $token, userId: $userId, signupSessionOtpProvisionalWithDateTime: $signupSessionOtpProvisionalWithDateTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginCustomSigninStateImpl &&
            (identical(other.processing, processing) ||
                other.processing == processing) &&
            (identical(other.coreUrl, coreUrl) || other.coreUrl == coreUrl) &&
            (identical(other.result, result) || other.result == result) &&
            (identical(other.tenantId, tenantId) ||
                other.tenantId == tenantId) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.signupSessionOtpProvisionalWithDateTime,
                    signupSessionOtpProvisionalWithDateTime) ||
                other.signupSessionOtpProvisionalWithDateTime ==
                    signupSessionOtpProvisionalWithDateTime));
  }

  @override
  int get hashCode => Object.hash(runtimeType, processing, coreUrl, result,
      tenantId, token, userId, signupSessionOtpProvisionalWithDateTime);

  /// Create a copy of LoginEmbeddedState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginCustomSigninStateImplCopyWith<_$LoginCustomSigninStateImpl>
      get copyWith => __$$LoginCustomSigninStateImplCopyWithImpl<
          _$LoginCustomSigninStateImpl>(this, _$identity);
}

abstract class _LoginCustomSigninState implements LoginEmbeddedState {
  const factory _LoginCustomSigninState(
          {final bool processing,
          final String? coreUrl,
          final SessionResult? result,
          final String? tenantId,
          final String? token,
          final String? userId,
          final (
            SessionOtpProvisional,
            DateTime
          )? signupSessionOtpProvisionalWithDateTime}) =
      _$LoginCustomSigninStateImpl;

  @override
  bool get processing;
  @override
  String? get coreUrl;
  @override
  SessionResult? get result;
  @override
  String? get tenantId;
  @override
  String? get token;
  @override
  String? get userId;
  @override
  (SessionOtpProvisional, DateTime)?
      get signupSessionOtpProvisionalWithDateTime;

  /// Create a copy of LoginEmbeddedState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginCustomSigninStateImplCopyWith<_$LoginCustomSigninStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
