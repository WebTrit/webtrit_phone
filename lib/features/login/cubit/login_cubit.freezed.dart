// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LoginState {
  bool get processing => throw _privateConstructorUsedError;
  Object? get error => throw _privateConstructorUsedError;
  bool? get demo => throw _privateConstructorUsedError;
  String? get coreUrl => throw _privateConstructorUsedError;
  String? get tenantId => throw _privateConstructorUsedError;
  List<LoginType>? get supportedLoginTypes =>
      throw _privateConstructorUsedError;
  (
    SessionOtpProvisional,
    DateTime
  )? get otpSigninSessionOtpProvisionalWithDateTime =>
      throw _privateConstructorUsedError;
  bool get passwordSigninPasswordInputObscureText =>
      throw _privateConstructorUsedError;
  (
    SessionOtpProvisional,
    DateTime
  )? get signupSessionOtpProvisionalWithDateTime =>
      throw _privateConstructorUsedError;
  String? get token => throw _privateConstructorUsedError;
  UrlInput get coreUrlInput => throw _privateConstructorUsedError;
  UserRefInput get otpSigninUserRefInput => throw _privateConstructorUsedError;
  CodeInput get otpSigninCodeInput => throw _privateConstructorUsedError;
  UserRefInput get passwordSigninUserRefInput =>
      throw _privateConstructorUsedError;
  PasswordInput get passwordSigninPasswordInput =>
      throw _privateConstructorUsedError;
  EmailInput get signupEmailInput => throw _privateConstructorUsedError;
  CodeInput get signupCodeInput => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoginStateCopyWith<LoginState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginStateCopyWith<$Res> {
  factory $LoginStateCopyWith(
          LoginState value, $Res Function(LoginState) then) =
      _$LoginStateCopyWithImpl<$Res, LoginState>;
  @useResult
  $Res call(
      {bool processing,
      Object? error,
      bool? demo,
      String? coreUrl,
      String? tenantId,
      List<LoginType>? supportedLoginTypes,
      (
        SessionOtpProvisional,
        DateTime
      )? otpSigninSessionOtpProvisionalWithDateTime,
      bool passwordSigninPasswordInputObscureText,
      (
        SessionOtpProvisional,
        DateTime
      )? signupSessionOtpProvisionalWithDateTime,
      String? token,
      UrlInput coreUrlInput,
      UserRefInput otpSigninUserRefInput,
      CodeInput otpSigninCodeInput,
      UserRefInput passwordSigninUserRefInput,
      PasswordInput passwordSigninPasswordInput,
      EmailInput signupEmailInput,
      CodeInput signupCodeInput});
}

/// @nodoc
class _$LoginStateCopyWithImpl<$Res, $Val extends LoginState>
    implements $LoginStateCopyWith<$Res> {
  _$LoginStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? processing = null,
    Object? error = freezed,
    Object? demo = freezed,
    Object? coreUrl = freezed,
    Object? tenantId = freezed,
    Object? supportedLoginTypes = freezed,
    Object? otpSigninSessionOtpProvisionalWithDateTime = freezed,
    Object? passwordSigninPasswordInputObscureText = null,
    Object? signupSessionOtpProvisionalWithDateTime = freezed,
    Object? token = freezed,
    Object? coreUrlInput = null,
    Object? otpSigninUserRefInput = null,
    Object? otpSigninCodeInput = null,
    Object? passwordSigninUserRefInput = null,
    Object? passwordSigninPasswordInput = null,
    Object? signupEmailInput = null,
    Object? signupCodeInput = null,
  }) {
    return _then(_value.copyWith(
      processing: null == processing
          ? _value.processing
          : processing // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error ? _value.error : error,
      demo: freezed == demo
          ? _value.demo
          : demo // ignore: cast_nullable_to_non_nullable
              as bool?,
      coreUrl: freezed == coreUrl
          ? _value.coreUrl
          : coreUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      tenantId: freezed == tenantId
          ? _value.tenantId
          : tenantId // ignore: cast_nullable_to_non_nullable
              as String?,
      supportedLoginTypes: freezed == supportedLoginTypes
          ? _value.supportedLoginTypes
          : supportedLoginTypes // ignore: cast_nullable_to_non_nullable
              as List<LoginType>?,
      otpSigninSessionOtpProvisionalWithDateTime: freezed ==
              otpSigninSessionOtpProvisionalWithDateTime
          ? _value.otpSigninSessionOtpProvisionalWithDateTime
          : otpSigninSessionOtpProvisionalWithDateTime // ignore: cast_nullable_to_non_nullable
              as (SessionOtpProvisional, DateTime)?,
      passwordSigninPasswordInputObscureText: null ==
              passwordSigninPasswordInputObscureText
          ? _value.passwordSigninPasswordInputObscureText
          : passwordSigninPasswordInputObscureText // ignore: cast_nullable_to_non_nullable
              as bool,
      signupSessionOtpProvisionalWithDateTime: freezed ==
              signupSessionOtpProvisionalWithDateTime
          ? _value.signupSessionOtpProvisionalWithDateTime
          : signupSessionOtpProvisionalWithDateTime // ignore: cast_nullable_to_non_nullable
              as (SessionOtpProvisional, DateTime)?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      coreUrlInput: null == coreUrlInput
          ? _value.coreUrlInput
          : coreUrlInput // ignore: cast_nullable_to_non_nullable
              as UrlInput,
      otpSigninUserRefInput: null == otpSigninUserRefInput
          ? _value.otpSigninUserRefInput
          : otpSigninUserRefInput // ignore: cast_nullable_to_non_nullable
              as UserRefInput,
      otpSigninCodeInput: null == otpSigninCodeInput
          ? _value.otpSigninCodeInput
          : otpSigninCodeInput // ignore: cast_nullable_to_non_nullable
              as CodeInput,
      passwordSigninUserRefInput: null == passwordSigninUserRefInput
          ? _value.passwordSigninUserRefInput
          : passwordSigninUserRefInput // ignore: cast_nullable_to_non_nullable
              as UserRefInput,
      passwordSigninPasswordInput: null == passwordSigninPasswordInput
          ? _value.passwordSigninPasswordInput
          : passwordSigninPasswordInput // ignore: cast_nullable_to_non_nullable
              as PasswordInput,
      signupEmailInput: null == signupEmailInput
          ? _value.signupEmailInput
          : signupEmailInput // ignore: cast_nullable_to_non_nullable
              as EmailInput,
      signupCodeInput: null == signupCodeInput
          ? _value.signupCodeInput
          : signupCodeInput // ignore: cast_nullable_to_non_nullable
              as CodeInput,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoginStateImplCopyWith<$Res>
    implements $LoginStateCopyWith<$Res> {
  factory _$$LoginStateImplCopyWith(
          _$LoginStateImpl value, $Res Function(_$LoginStateImpl) then) =
      __$$LoginStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool processing,
      Object? error,
      bool? demo,
      String? coreUrl,
      String? tenantId,
      List<LoginType>? supportedLoginTypes,
      (
        SessionOtpProvisional,
        DateTime
      )? otpSigninSessionOtpProvisionalWithDateTime,
      bool passwordSigninPasswordInputObscureText,
      (
        SessionOtpProvisional,
        DateTime
      )? signupSessionOtpProvisionalWithDateTime,
      String? token,
      UrlInput coreUrlInput,
      UserRefInput otpSigninUserRefInput,
      CodeInput otpSigninCodeInput,
      UserRefInput passwordSigninUserRefInput,
      PasswordInput passwordSigninPasswordInput,
      EmailInput signupEmailInput,
      CodeInput signupCodeInput});
}

/// @nodoc
class __$$LoginStateImplCopyWithImpl<$Res>
    extends _$LoginStateCopyWithImpl<$Res, _$LoginStateImpl>
    implements _$$LoginStateImplCopyWith<$Res> {
  __$$LoginStateImplCopyWithImpl(
      _$LoginStateImpl _value, $Res Function(_$LoginStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? processing = null,
    Object? error = freezed,
    Object? demo = freezed,
    Object? coreUrl = freezed,
    Object? tenantId = freezed,
    Object? supportedLoginTypes = freezed,
    Object? otpSigninSessionOtpProvisionalWithDateTime = freezed,
    Object? passwordSigninPasswordInputObscureText = null,
    Object? signupSessionOtpProvisionalWithDateTime = freezed,
    Object? token = freezed,
    Object? coreUrlInput = null,
    Object? otpSigninUserRefInput = null,
    Object? otpSigninCodeInput = null,
    Object? passwordSigninUserRefInput = null,
    Object? passwordSigninPasswordInput = null,
    Object? signupEmailInput = null,
    Object? signupCodeInput = null,
  }) {
    return _then(_$LoginStateImpl(
      processing: null == processing
          ? _value.processing
          : processing // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error ? _value.error : error,
      demo: freezed == demo
          ? _value.demo
          : demo // ignore: cast_nullable_to_non_nullable
              as bool?,
      coreUrl: freezed == coreUrl
          ? _value.coreUrl
          : coreUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      tenantId: freezed == tenantId
          ? _value.tenantId
          : tenantId // ignore: cast_nullable_to_non_nullable
              as String?,
      supportedLoginTypes: freezed == supportedLoginTypes
          ? _value._supportedLoginTypes
          : supportedLoginTypes // ignore: cast_nullable_to_non_nullable
              as List<LoginType>?,
      otpSigninSessionOtpProvisionalWithDateTime: freezed ==
              otpSigninSessionOtpProvisionalWithDateTime
          ? _value.otpSigninSessionOtpProvisionalWithDateTime
          : otpSigninSessionOtpProvisionalWithDateTime // ignore: cast_nullable_to_non_nullable
              as (SessionOtpProvisional, DateTime)?,
      passwordSigninPasswordInputObscureText: null ==
              passwordSigninPasswordInputObscureText
          ? _value.passwordSigninPasswordInputObscureText
          : passwordSigninPasswordInputObscureText // ignore: cast_nullable_to_non_nullable
              as bool,
      signupSessionOtpProvisionalWithDateTime: freezed ==
              signupSessionOtpProvisionalWithDateTime
          ? _value.signupSessionOtpProvisionalWithDateTime
          : signupSessionOtpProvisionalWithDateTime // ignore: cast_nullable_to_non_nullable
              as (SessionOtpProvisional, DateTime)?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      coreUrlInput: null == coreUrlInput
          ? _value.coreUrlInput
          : coreUrlInput // ignore: cast_nullable_to_non_nullable
              as UrlInput,
      otpSigninUserRefInput: null == otpSigninUserRefInput
          ? _value.otpSigninUserRefInput
          : otpSigninUserRefInput // ignore: cast_nullable_to_non_nullable
              as UserRefInput,
      otpSigninCodeInput: null == otpSigninCodeInput
          ? _value.otpSigninCodeInput
          : otpSigninCodeInput // ignore: cast_nullable_to_non_nullable
              as CodeInput,
      passwordSigninUserRefInput: null == passwordSigninUserRefInput
          ? _value.passwordSigninUserRefInput
          : passwordSigninUserRefInput // ignore: cast_nullable_to_non_nullable
              as UserRefInput,
      passwordSigninPasswordInput: null == passwordSigninPasswordInput
          ? _value.passwordSigninPasswordInput
          : passwordSigninPasswordInput // ignore: cast_nullable_to_non_nullable
              as PasswordInput,
      signupEmailInput: null == signupEmailInput
          ? _value.signupEmailInput
          : signupEmailInput // ignore: cast_nullable_to_non_nullable
              as EmailInput,
      signupCodeInput: null == signupCodeInput
          ? _value.signupCodeInput
          : signupCodeInput // ignore: cast_nullable_to_non_nullable
              as CodeInput,
    ));
  }
}

/// @nodoc

class _$LoginStateImpl implements _LoginState {
  const _$LoginStateImpl(
      {this.processing = false,
      this.error,
      this.demo,
      this.coreUrl,
      this.tenantId,
      final List<LoginType>? supportedLoginTypes,
      this.otpSigninSessionOtpProvisionalWithDateTime,
      this.passwordSigninPasswordInputObscureText = true,
      this.signupSessionOtpProvisionalWithDateTime,
      this.token,
      this.coreUrlInput = const UrlInput.pure(),
      this.otpSigninUserRefInput = const UserRefInput.pure(),
      this.otpSigninCodeInput = const CodeInput.pure(),
      this.passwordSigninUserRefInput = const UserRefInput.pure(),
      this.passwordSigninPasswordInput = const PasswordInput.pure(),
      this.signupEmailInput = const EmailInput.pure(),
      this.signupCodeInput = const CodeInput.pure()})
      : _supportedLoginTypes = supportedLoginTypes;

  @override
  @JsonKey()
  final bool processing;
  @override
  final Object? error;
  @override
  final bool? demo;
  @override
  final String? coreUrl;
  @override
  final String? tenantId;
  final List<LoginType>? _supportedLoginTypes;
  @override
  List<LoginType>? get supportedLoginTypes {
    final value = _supportedLoginTypes;
    if (value == null) return null;
    if (_supportedLoginTypes is EqualUnmodifiableListView)
      return _supportedLoginTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final (
    SessionOtpProvisional,
    DateTime
  )? otpSigninSessionOtpProvisionalWithDateTime;
  @override
  @JsonKey()
  final bool passwordSigninPasswordInputObscureText;
  @override
  final (
    SessionOtpProvisional,
    DateTime
  )? signupSessionOtpProvisionalWithDateTime;
  @override
  final String? token;
  @override
  @JsonKey()
  final UrlInput coreUrlInput;
  @override
  @JsonKey()
  final UserRefInput otpSigninUserRefInput;
  @override
  @JsonKey()
  final CodeInput otpSigninCodeInput;
  @override
  @JsonKey()
  final UserRefInput passwordSigninUserRefInput;
  @override
  @JsonKey()
  final PasswordInput passwordSigninPasswordInput;
  @override
  @JsonKey()
  final EmailInput signupEmailInput;
  @override
  @JsonKey()
  final CodeInput signupCodeInput;

  @override
  String toString() {
    return 'LoginState(processing: $processing, error: $error, demo: $demo, coreUrl: $coreUrl, tenantId: $tenantId, supportedLoginTypes: $supportedLoginTypes, otpSigninSessionOtpProvisionalWithDateTime: $otpSigninSessionOtpProvisionalWithDateTime, passwordSigninPasswordInputObscureText: $passwordSigninPasswordInputObscureText, signupSessionOtpProvisionalWithDateTime: $signupSessionOtpProvisionalWithDateTime, token: $token, coreUrlInput: $coreUrlInput, otpSigninUserRefInput: $otpSigninUserRefInput, otpSigninCodeInput: $otpSigninCodeInput, passwordSigninUserRefInput: $passwordSigninUserRefInput, passwordSigninPasswordInput: $passwordSigninPasswordInput, signupEmailInput: $signupEmailInput, signupCodeInput: $signupCodeInput)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginStateImpl &&
            (identical(other.processing, processing) ||
                other.processing == processing) &&
            const DeepCollectionEquality().equals(other.error, error) &&
            (identical(other.demo, demo) || other.demo == demo) &&
            (identical(other.coreUrl, coreUrl) || other.coreUrl == coreUrl) &&
            (identical(other.tenantId, tenantId) ||
                other.tenantId == tenantId) &&
            const DeepCollectionEquality()
                .equals(other._supportedLoginTypes, _supportedLoginTypes) &&
            (identical(other.otpSigninSessionOtpProvisionalWithDateTime,
                    otpSigninSessionOtpProvisionalWithDateTime) ||
                other.otpSigninSessionOtpProvisionalWithDateTime ==
                    otpSigninSessionOtpProvisionalWithDateTime) &&
            (identical(other.passwordSigninPasswordInputObscureText,
                    passwordSigninPasswordInputObscureText) ||
                other.passwordSigninPasswordInputObscureText ==
                    passwordSigninPasswordInputObscureText) &&
            (identical(other.signupSessionOtpProvisionalWithDateTime,
                    signupSessionOtpProvisionalWithDateTime) ||
                other.signupSessionOtpProvisionalWithDateTime ==
                    signupSessionOtpProvisionalWithDateTime) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.coreUrlInput, coreUrlInput) ||
                other.coreUrlInput == coreUrlInput) &&
            (identical(other.otpSigninUserRefInput, otpSigninUserRefInput) ||
                other.otpSigninUserRefInput == otpSigninUserRefInput) &&
            (identical(other.otpSigninCodeInput, otpSigninCodeInput) ||
                other.otpSigninCodeInput == otpSigninCodeInput) &&
            (identical(other.passwordSigninUserRefInput, passwordSigninUserRefInput) ||
                other.passwordSigninUserRefInput ==
                    passwordSigninUserRefInput) &&
            (identical(other.passwordSigninPasswordInput, passwordSigninPasswordInput) ||
                other.passwordSigninPasswordInput ==
                    passwordSigninPasswordInput) &&
            (identical(other.signupEmailInput, signupEmailInput) ||
                other.signupEmailInput == signupEmailInput) &&
            (identical(other.signupCodeInput, signupCodeInput) ||
                other.signupCodeInput == signupCodeInput));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      processing,
      const DeepCollectionEquality().hash(error),
      demo,
      coreUrl,
      tenantId,
      const DeepCollectionEquality().hash(_supportedLoginTypes),
      otpSigninSessionOtpProvisionalWithDateTime,
      passwordSigninPasswordInputObscureText,
      signupSessionOtpProvisionalWithDateTime,
      token,
      coreUrlInput,
      otpSigninUserRefInput,
      otpSigninCodeInput,
      passwordSigninUserRefInput,
      passwordSigninPasswordInput,
      signupEmailInput,
      signupCodeInput);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginStateImplCopyWith<_$LoginStateImpl> get copyWith =>
      __$$LoginStateImplCopyWithImpl<_$LoginStateImpl>(this, _$identity);
}

abstract class _LoginState implements LoginState {
  const factory _LoginState(
      {final bool processing,
      final Object? error,
      final bool? demo,
      final String? coreUrl,
      final String? tenantId,
      final List<LoginType>? supportedLoginTypes,
      final (
        SessionOtpProvisional,
        DateTime
      )? otpSigninSessionOtpProvisionalWithDateTime,
      final bool passwordSigninPasswordInputObscureText,
      final (
        SessionOtpProvisional,
        DateTime
      )? signupSessionOtpProvisionalWithDateTime,
      final String? token,
      final UrlInput coreUrlInput,
      final UserRefInput otpSigninUserRefInput,
      final CodeInput otpSigninCodeInput,
      final UserRefInput passwordSigninUserRefInput,
      final PasswordInput passwordSigninPasswordInput,
      final EmailInput signupEmailInput,
      final CodeInput signupCodeInput}) = _$LoginStateImpl;

  @override
  bool get processing;
  @override
  Object? get error;
  @override
  bool? get demo;
  @override
  String? get coreUrl;
  @override
  String? get tenantId;
  @override
  List<LoginType>? get supportedLoginTypes;
  @override
  (SessionOtpProvisional, DateTime)?
      get otpSigninSessionOtpProvisionalWithDateTime;
  @override
  bool get passwordSigninPasswordInputObscureText;
  @override
  (SessionOtpProvisional, DateTime)?
      get signupSessionOtpProvisionalWithDateTime;
  @override
  String? get token;
  @override
  UrlInput get coreUrlInput;
  @override
  UserRefInput get otpSigninUserRefInput;
  @override
  CodeInput get otpSigninCodeInput;
  @override
  UserRefInput get passwordSigninUserRefInput;
  @override
  PasswordInput get passwordSigninPasswordInput;
  @override
  EmailInput get signupEmailInput;
  @override
  CodeInput get signupCodeInput;
  @override
  @JsonKey(ignore: true)
  _$$LoginStateImplCopyWith<_$LoginStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
