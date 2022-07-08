// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'login_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LoginState {
  int get tabIndex => throw _privateConstructorUsedError;
  LoginStatus get status => throw _privateConstructorUsedError;
  Object? get error => throw _privateConstructorUsedError;
  String? get coreUrl => throw _privateConstructorUsedError;
  String? get otpId => throw _privateConstructorUsedError;
  String? get token => throw _privateConstructorUsedError;
  UrlInput get coreUrlInput => throw _privateConstructorUsedError;
  PhoneInput get phoneInput => throw _privateConstructorUsedError;
  CodeInput get codeInput => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoginStateCopyWith<LoginState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginStateCopyWith<$Res> {
  factory $LoginStateCopyWith(
          LoginState value, $Res Function(LoginState) then) =
      _$LoginStateCopyWithImpl<$Res>;
  $Res call(
      {int tabIndex,
      LoginStatus status,
      Object? error,
      String? coreUrl,
      String? otpId,
      String? token,
      UrlInput coreUrlInput,
      PhoneInput phoneInput,
      CodeInput codeInput});
}

/// @nodoc
class _$LoginStateCopyWithImpl<$Res> implements $LoginStateCopyWith<$Res> {
  _$LoginStateCopyWithImpl(this._value, this._then);

  final LoginState _value;
  // ignore: unused_field
  final $Res Function(LoginState) _then;

  @override
  $Res call({
    Object? tabIndex = freezed,
    Object? status = freezed,
    Object? error = freezed,
    Object? coreUrl = freezed,
    Object? otpId = freezed,
    Object? token = freezed,
    Object? coreUrlInput = freezed,
    Object? phoneInput = freezed,
    Object? codeInput = freezed,
  }) {
    return _then(_value.copyWith(
      tabIndex: tabIndex == freezed
          ? _value.tabIndex
          : tabIndex // ignore: cast_nullable_to_non_nullable
              as int,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as LoginStatus,
      error: error == freezed ? _value.error : error,
      coreUrl: coreUrl == freezed
          ? _value.coreUrl
          : coreUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      otpId: otpId == freezed
          ? _value.otpId
          : otpId // ignore: cast_nullable_to_non_nullable
              as String?,
      token: token == freezed
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      coreUrlInput: coreUrlInput == freezed
          ? _value.coreUrlInput
          : coreUrlInput // ignore: cast_nullable_to_non_nullable
              as UrlInput,
      phoneInput: phoneInput == freezed
          ? _value.phoneInput
          : phoneInput // ignore: cast_nullable_to_non_nullable
              as PhoneInput,
      codeInput: codeInput == freezed
          ? _value.codeInput
          : codeInput // ignore: cast_nullable_to_non_nullable
              as CodeInput,
    ));
  }
}

/// @nodoc
abstract class _$$_LoginStateCopyWith<$Res>
    implements $LoginStateCopyWith<$Res> {
  factory _$$_LoginStateCopyWith(
          _$_LoginState value, $Res Function(_$_LoginState) then) =
      __$$_LoginStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {int tabIndex,
      LoginStatus status,
      Object? error,
      String? coreUrl,
      String? otpId,
      String? token,
      UrlInput coreUrlInput,
      PhoneInput phoneInput,
      CodeInput codeInput});
}

/// @nodoc
class __$$_LoginStateCopyWithImpl<$Res> extends _$LoginStateCopyWithImpl<$Res>
    implements _$$_LoginStateCopyWith<$Res> {
  __$$_LoginStateCopyWithImpl(
      _$_LoginState _value, $Res Function(_$_LoginState) _then)
      : super(_value, (v) => _then(v as _$_LoginState));

  @override
  _$_LoginState get _value => super._value as _$_LoginState;

  @override
  $Res call({
    Object? tabIndex = freezed,
    Object? status = freezed,
    Object? error = freezed,
    Object? coreUrl = freezed,
    Object? otpId = freezed,
    Object? token = freezed,
    Object? coreUrlInput = freezed,
    Object? phoneInput = freezed,
    Object? codeInput = freezed,
  }) {
    return _then(_$_LoginState(
      tabIndex: tabIndex == freezed
          ? _value.tabIndex
          : tabIndex // ignore: cast_nullable_to_non_nullable
              as int,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as LoginStatus,
      error: error == freezed ? _value.error : error,
      coreUrl: coreUrl == freezed
          ? _value.coreUrl
          : coreUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      otpId: otpId == freezed
          ? _value.otpId
          : otpId // ignore: cast_nullable_to_non_nullable
              as String?,
      token: token == freezed
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      coreUrlInput: coreUrlInput == freezed
          ? _value.coreUrlInput
          : coreUrlInput // ignore: cast_nullable_to_non_nullable
              as UrlInput,
      phoneInput: phoneInput == freezed
          ? _value.phoneInput
          : phoneInput // ignore: cast_nullable_to_non_nullable
              as PhoneInput,
      codeInput: codeInput == freezed
          ? _value.codeInput
          : codeInput // ignore: cast_nullable_to_non_nullable
              as CodeInput,
    ));
  }
}

/// @nodoc

class _$_LoginState implements _LoginState {
  const _$_LoginState(
      {this.tabIndex = 0,
      this.status = LoginStatus.input,
      this.error,
      this.coreUrl,
      this.otpId,
      this.token,
      this.coreUrlInput = const UrlInput.pure(),
      this.phoneInput = const PhoneInput.pure(),
      this.codeInput = const CodeInput.pure()});

  @override
  @JsonKey()
  final int tabIndex;
  @override
  @JsonKey()
  final LoginStatus status;
  @override
  final Object? error;
  @override
  final String? coreUrl;
  @override
  final String? otpId;
  @override
  final String? token;
  @override
  @JsonKey()
  final UrlInput coreUrlInput;
  @override
  @JsonKey()
  final PhoneInput phoneInput;
  @override
  @JsonKey()
  final CodeInput codeInput;

  @override
  String toString() {
    return 'LoginState(tabIndex: $tabIndex, status: $status, error: $error, coreUrl: $coreUrl, otpId: $otpId, token: $token, coreUrlInput: $coreUrlInput, phoneInput: $phoneInput, codeInput: $codeInput)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LoginState &&
            const DeepCollectionEquality().equals(other.tabIndex, tabIndex) &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            const DeepCollectionEquality().equals(other.coreUrl, coreUrl) &&
            const DeepCollectionEquality().equals(other.otpId, otpId) &&
            const DeepCollectionEquality().equals(other.token, token) &&
            const DeepCollectionEquality()
                .equals(other.coreUrlInput, coreUrlInput) &&
            const DeepCollectionEquality()
                .equals(other.phoneInput, phoneInput) &&
            const DeepCollectionEquality().equals(other.codeInput, codeInput));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(tabIndex),
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(error),
      const DeepCollectionEquality().hash(coreUrl),
      const DeepCollectionEquality().hash(otpId),
      const DeepCollectionEquality().hash(token),
      const DeepCollectionEquality().hash(coreUrlInput),
      const DeepCollectionEquality().hash(phoneInput),
      const DeepCollectionEquality().hash(codeInput));

  @JsonKey(ignore: true)
  @override
  _$$_LoginStateCopyWith<_$_LoginState> get copyWith =>
      __$$_LoginStateCopyWithImpl<_$_LoginState>(this, _$identity);
}

abstract class _LoginState implements LoginState {
  const factory _LoginState(
      {final int tabIndex,
      final LoginStatus status,
      final Object? error,
      final String? coreUrl,
      final String? otpId,
      final String? token,
      final UrlInput coreUrlInput,
      final PhoneInput phoneInput,
      final CodeInput codeInput}) = _$_LoginState;

  @override
  int get tabIndex;
  @override
  LoginStatus get status;
  @override
  Object? get error;
  @override
  String? get coreUrl;
  @override
  String? get otpId;
  @override
  String? get token;
  @override
  UrlInput get coreUrlInput;
  @override
  PhoneInput get phoneInput;
  @override
  CodeInput get codeInput;
  @override
  @JsonKey(ignore: true)
  _$$_LoginStateCopyWith<_$_LoginState> get copyWith =>
      throw _privateConstructorUsedError;
}
