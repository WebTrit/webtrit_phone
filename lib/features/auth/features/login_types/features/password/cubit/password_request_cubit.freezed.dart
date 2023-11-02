// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'password_request_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PasswordRequestState {
  PasswordRequestStatus? get status => throw _privateConstructorUsedError;
  Exception? get error => throw _privateConstructorUsedError;
  String get coreUrl => throw _privateConstructorUsedError;
  String get tenantId => throw _privateConstructorUsedError;
  String? get token => throw _privateConstructorUsedError;
  LoginInput get loginInput => throw _privateConstructorUsedError;
  PasswordInput get passwordInput => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PasswordRequestStateCopyWith<PasswordRequestState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PasswordRequestStateCopyWith<$Res> {
  factory $PasswordRequestStateCopyWith(PasswordRequestState value,
          $Res Function(PasswordRequestState) then) =
      _$PasswordRequestStateCopyWithImpl<$Res, PasswordRequestState>;
  @useResult
  $Res call(
      {PasswordRequestStatus? status,
      Exception? error,
      String coreUrl,
      String tenantId,
      String? token,
      LoginInput loginInput,
      PasswordInput passwordInput});
}

/// @nodoc
class _$PasswordRequestStateCopyWithImpl<$Res,
        $Val extends PasswordRequestState>
    implements $PasswordRequestStateCopyWith<$Res> {
  _$PasswordRequestStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? error = freezed,
    Object? coreUrl = null,
    Object? tenantId = null,
    Object? token = freezed,
    Object? loginInput = null,
    Object? passwordInput = null,
  }) {
    return _then(_value.copyWith(
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PasswordRequestStatus?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as Exception?,
      coreUrl: null == coreUrl
          ? _value.coreUrl
          : coreUrl // ignore: cast_nullable_to_non_nullable
              as String,
      tenantId: null == tenantId
          ? _value.tenantId
          : tenantId // ignore: cast_nullable_to_non_nullable
              as String,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      loginInput: null == loginInput
          ? _value.loginInput
          : loginInput // ignore: cast_nullable_to_non_nullable
              as LoginInput,
      passwordInput: null == passwordInput
          ? _value.passwordInput
          : passwordInput // ignore: cast_nullable_to_non_nullable
              as PasswordInput,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PasswordRequestStateCopyWith<$Res>
    implements $PasswordRequestStateCopyWith<$Res> {
  factory _$$_PasswordRequestStateCopyWith(_$_PasswordRequestState value,
          $Res Function(_$_PasswordRequestState) then) =
      __$$_PasswordRequestStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PasswordRequestStatus? status,
      Exception? error,
      String coreUrl,
      String tenantId,
      String? token,
      LoginInput loginInput,
      PasswordInput passwordInput});
}

/// @nodoc
class __$$_PasswordRequestStateCopyWithImpl<$Res>
    extends _$PasswordRequestStateCopyWithImpl<$Res, _$_PasswordRequestState>
    implements _$$_PasswordRequestStateCopyWith<$Res> {
  __$$_PasswordRequestStateCopyWithImpl(_$_PasswordRequestState _value,
      $Res Function(_$_PasswordRequestState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? error = freezed,
    Object? coreUrl = null,
    Object? tenantId = null,
    Object? token = freezed,
    Object? loginInput = null,
    Object? passwordInput = null,
  }) {
    return _then(_$_PasswordRequestState(
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PasswordRequestStatus?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as Exception?,
      coreUrl: null == coreUrl
          ? _value.coreUrl
          : coreUrl // ignore: cast_nullable_to_non_nullable
              as String,
      tenantId: null == tenantId
          ? _value.tenantId
          : tenantId // ignore: cast_nullable_to_non_nullable
              as String,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      loginInput: null == loginInput
          ? _value.loginInput
          : loginInput // ignore: cast_nullable_to_non_nullable
              as LoginInput,
      passwordInput: null == passwordInput
          ? _value.passwordInput
          : passwordInput // ignore: cast_nullable_to_non_nullable
              as PasswordInput,
    ));
  }
}

/// @nodoc

class _$_PasswordRequestState extends _PasswordRequestState {
  const _$_PasswordRequestState(
      {this.status,
      this.error,
      required this.coreUrl,
      required this.tenantId,
      this.token,
      this.loginInput = const LoginInput.pure(),
      this.passwordInput = const PasswordInput.pure()})
      : super._();

  @override
  final PasswordRequestStatus? status;
  @override
  final Exception? error;
  @override
  final String coreUrl;
  @override
  final String tenantId;
  @override
  final String? token;
  @override
  @JsonKey()
  final LoginInput loginInput;
  @override
  @JsonKey()
  final PasswordInput passwordInput;

  @override
  String toString() {
    return 'PasswordRequestState(status: $status, error: $error, coreUrl: $coreUrl, tenantId: $tenantId, token: $token, loginInput: $loginInput, passwordInput: $passwordInput)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PasswordRequestState &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.coreUrl, coreUrl) || other.coreUrl == coreUrl) &&
            (identical(other.tenantId, tenantId) ||
                other.tenantId == tenantId) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.loginInput, loginInput) ||
                other.loginInput == loginInput) &&
            (identical(other.passwordInput, passwordInput) ||
                other.passwordInput == passwordInput));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, error, coreUrl, tenantId,
      token, loginInput, passwordInput);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PasswordRequestStateCopyWith<_$_PasswordRequestState> get copyWith =>
      __$$_PasswordRequestStateCopyWithImpl<_$_PasswordRequestState>(
          this, _$identity);
}

abstract class _PasswordRequestState extends PasswordRequestState {
  const factory _PasswordRequestState(
      {final PasswordRequestStatus? status,
      final Exception? error,
      required final String coreUrl,
      required final String tenantId,
      final String? token,
      final LoginInput loginInput,
      final PasswordInput passwordInput}) = _$_PasswordRequestState;
  const _PasswordRequestState._() : super._();

  @override
  PasswordRequestStatus? get status;
  @override
  Exception? get error;
  @override
  String get coreUrl;
  @override
  String get tenantId;
  @override
  String? get token;
  @override
  LoginInput get loginInput;
  @override
  PasswordInput get passwordInput;
  @override
  @JsonKey(ignore: true)
  _$$_PasswordRequestStateCopyWith<_$_PasswordRequestState> get copyWith =>
      throw _privateConstructorUsedError;
}
