// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LoginState {

 bool get processing; LoginMode? get mode; String? get coreUrl; String? get tenantId; WebtritSystemInfo? get systemInfo; List<LoginType>? get supportedLoginTypes; SessionOtpProvisionalWithDateTime? get otpSigninSessionOtpProvisionalWithDateTime; bool get passwordSigninPasswordInputObscureText; SessionOtpProvisionalWithDateTime? get signupSessionOtpProvisionalWithDateTime; String? get token; String? get userId; EmbeddedData? get embedded; Map<String, dynamic>? get embeddedExtras; Map<String, dynamic>? get embeddedCallbackData; Object? get embeddedRequestError; UrlInput get coreUrlInput; UserRefInput get otpSigninUserRefInput; CodeInput get otpSigninCodeInput; UserRefInput get passwordSigninUserRefInput; PasswordInput get passwordSigninPasswordInput; EmailInput get signupEmailInput; CodeInput get signupCodeInput;
/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginStateCopyWith<LoginState> get copyWith => _$LoginStateCopyWithImpl<LoginState>(this as LoginState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginState&&(identical(other.processing, processing) || other.processing == processing)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.coreUrl, coreUrl) || other.coreUrl == coreUrl)&&(identical(other.tenantId, tenantId) || other.tenantId == tenantId)&&(identical(other.systemInfo, systemInfo) || other.systemInfo == systemInfo)&&const DeepCollectionEquality().equals(other.supportedLoginTypes, supportedLoginTypes)&&(identical(other.otpSigninSessionOtpProvisionalWithDateTime, otpSigninSessionOtpProvisionalWithDateTime) || other.otpSigninSessionOtpProvisionalWithDateTime == otpSigninSessionOtpProvisionalWithDateTime)&&(identical(other.passwordSigninPasswordInputObscureText, passwordSigninPasswordInputObscureText) || other.passwordSigninPasswordInputObscureText == passwordSigninPasswordInputObscureText)&&(identical(other.signupSessionOtpProvisionalWithDateTime, signupSessionOtpProvisionalWithDateTime) || other.signupSessionOtpProvisionalWithDateTime == signupSessionOtpProvisionalWithDateTime)&&(identical(other.token, token) || other.token == token)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.embedded, embedded) || other.embedded == embedded)&&const DeepCollectionEquality().equals(other.embeddedExtras, embeddedExtras)&&const DeepCollectionEquality().equals(other.embeddedCallbackData, embeddedCallbackData)&&const DeepCollectionEquality().equals(other.embeddedRequestError, embeddedRequestError)&&(identical(other.coreUrlInput, coreUrlInput) || other.coreUrlInput == coreUrlInput)&&(identical(other.otpSigninUserRefInput, otpSigninUserRefInput) || other.otpSigninUserRefInput == otpSigninUserRefInput)&&(identical(other.otpSigninCodeInput, otpSigninCodeInput) || other.otpSigninCodeInput == otpSigninCodeInput)&&(identical(other.passwordSigninUserRefInput, passwordSigninUserRefInput) || other.passwordSigninUserRefInput == passwordSigninUserRefInput)&&(identical(other.passwordSigninPasswordInput, passwordSigninPasswordInput) || other.passwordSigninPasswordInput == passwordSigninPasswordInput)&&(identical(other.signupEmailInput, signupEmailInput) || other.signupEmailInput == signupEmailInput)&&(identical(other.signupCodeInput, signupCodeInput) || other.signupCodeInput == signupCodeInput));
}


@override
int get hashCode => Object.hashAll([runtimeType,processing,mode,coreUrl,tenantId,systemInfo,const DeepCollectionEquality().hash(supportedLoginTypes),otpSigninSessionOtpProvisionalWithDateTime,passwordSigninPasswordInputObscureText,signupSessionOtpProvisionalWithDateTime,token,userId,embedded,const DeepCollectionEquality().hash(embeddedExtras),const DeepCollectionEquality().hash(embeddedCallbackData),const DeepCollectionEquality().hash(embeddedRequestError),coreUrlInput,otpSigninUserRefInput,otpSigninCodeInput,passwordSigninUserRefInput,passwordSigninPasswordInput,signupEmailInput,signupCodeInput]);

@override
String toString() {
  return 'LoginState(processing: $processing, mode: $mode, coreUrl: $coreUrl, tenantId: $tenantId, systemInfo: $systemInfo, supportedLoginTypes: $supportedLoginTypes, otpSigninSessionOtpProvisionalWithDateTime: $otpSigninSessionOtpProvisionalWithDateTime, passwordSigninPasswordInputObscureText: $passwordSigninPasswordInputObscureText, signupSessionOtpProvisionalWithDateTime: $signupSessionOtpProvisionalWithDateTime, token: $token, userId: $userId, embedded: $embedded, embeddedExtras: $embeddedExtras, embeddedCallbackData: $embeddedCallbackData, embeddedRequestError: $embeddedRequestError, coreUrlInput: $coreUrlInput, otpSigninUserRefInput: $otpSigninUserRefInput, otpSigninCodeInput: $otpSigninCodeInput, passwordSigninUserRefInput: $passwordSigninUserRefInput, passwordSigninPasswordInput: $passwordSigninPasswordInput, signupEmailInput: $signupEmailInput, signupCodeInput: $signupCodeInput)';
}


}

/// @nodoc
abstract mixin class $LoginStateCopyWith<$Res>  {
  factory $LoginStateCopyWith(LoginState value, $Res Function(LoginState) _then) = _$LoginStateCopyWithImpl;
@useResult
$Res call({
 bool processing, LoginMode? mode, String? coreUrl, String? tenantId, WebtritSystemInfo? systemInfo, List<LoginType>? supportedLoginTypes, (SessionOtpProvisional, DateTime)? otpSigninSessionOtpProvisionalWithDateTime, bool passwordSigninPasswordInputObscureText, (SessionOtpProvisional, DateTime)? signupSessionOtpProvisionalWithDateTime, String? token, String? userId, EmbeddedData? embedded, Map<String, dynamic>? embeddedExtras, Map<String, dynamic>? embeddedCallbackData, Object? embeddedRequestError, UrlInput coreUrlInput, UserRefInput otpSigninUserRefInput, CodeInput otpSigninCodeInput, UserRefInput passwordSigninUserRefInput, PasswordInput passwordSigninPasswordInput, EmailInput signupEmailInput, CodeInput signupCodeInput
});




}
/// @nodoc
class _$LoginStateCopyWithImpl<$Res>
    implements $LoginStateCopyWith<$Res> {
  _$LoginStateCopyWithImpl(this._self, this._then);

  final LoginState _self;
  final $Res Function(LoginState) _then;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? processing = null,Object? mode = freezed,Object? coreUrl = freezed,Object? tenantId = freezed,Object? systemInfo = freezed,Object? supportedLoginTypes = freezed,Object? otpSigninSessionOtpProvisionalWithDateTime = freezed,Object? passwordSigninPasswordInputObscureText = null,Object? signupSessionOtpProvisionalWithDateTime = freezed,Object? token = freezed,Object? userId = freezed,Object? embedded = freezed,Object? embeddedExtras = freezed,Object? embeddedCallbackData = freezed,Object? embeddedRequestError = freezed,Object? coreUrlInput = null,Object? otpSigninUserRefInput = null,Object? otpSigninCodeInput = null,Object? passwordSigninUserRefInput = null,Object? passwordSigninPasswordInput = null,Object? signupEmailInput = null,Object? signupCodeInput = null,}) {
  return _then(LoginState(
processing: null == processing ? _self.processing : processing // ignore: cast_nullable_to_non_nullable
as bool,mode: freezed == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as LoginMode?,coreUrl: freezed == coreUrl ? _self.coreUrl : coreUrl // ignore: cast_nullable_to_non_nullable
as String?,tenantId: freezed == tenantId ? _self.tenantId : tenantId // ignore: cast_nullable_to_non_nullable
as String?,systemInfo: freezed == systemInfo ? _self.systemInfo : systemInfo // ignore: cast_nullable_to_non_nullable
as WebtritSystemInfo?,supportedLoginTypes: freezed == supportedLoginTypes ? _self.supportedLoginTypes : supportedLoginTypes // ignore: cast_nullable_to_non_nullable
as List<LoginType>?,otpSigninSessionOtpProvisionalWithDateTime: freezed == otpSigninSessionOtpProvisionalWithDateTime ? _self.otpSigninSessionOtpProvisionalWithDateTime : otpSigninSessionOtpProvisionalWithDateTime // ignore: cast_nullable_to_non_nullable
as (SessionOtpProvisional, DateTime)?,passwordSigninPasswordInputObscureText: null == passwordSigninPasswordInputObscureText ? _self.passwordSigninPasswordInputObscureText : passwordSigninPasswordInputObscureText // ignore: cast_nullable_to_non_nullable
as bool,signupSessionOtpProvisionalWithDateTime: freezed == signupSessionOtpProvisionalWithDateTime ? _self.signupSessionOtpProvisionalWithDateTime : signupSessionOtpProvisionalWithDateTime // ignore: cast_nullable_to_non_nullable
as (SessionOtpProvisional, DateTime)?,token: freezed == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,embedded: freezed == embedded ? _self.embedded : embedded // ignore: cast_nullable_to_non_nullable
as EmbeddedData?,embeddedExtras: freezed == embeddedExtras ? _self.embeddedExtras : embeddedExtras // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,embeddedCallbackData: freezed == embeddedCallbackData ? _self.embeddedCallbackData : embeddedCallbackData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,embeddedRequestError: freezed == embeddedRequestError ? _self.embeddedRequestError : embeddedRequestError ,coreUrlInput: null == coreUrlInput ? _self.coreUrlInput : coreUrlInput // ignore: cast_nullable_to_non_nullable
as UrlInput,otpSigninUserRefInput: null == otpSigninUserRefInput ? _self.otpSigninUserRefInput : otpSigninUserRefInput // ignore: cast_nullable_to_non_nullable
as UserRefInput,otpSigninCodeInput: null == otpSigninCodeInput ? _self.otpSigninCodeInput : otpSigninCodeInput // ignore: cast_nullable_to_non_nullable
as CodeInput,passwordSigninUserRefInput: null == passwordSigninUserRefInput ? _self.passwordSigninUserRefInput : passwordSigninUserRefInput // ignore: cast_nullable_to_non_nullable
as UserRefInput,passwordSigninPasswordInput: null == passwordSigninPasswordInput ? _self.passwordSigninPasswordInput : passwordSigninPasswordInput // ignore: cast_nullable_to_non_nullable
as PasswordInput,signupEmailInput: null == signupEmailInput ? _self.signupEmailInput : signupEmailInput // ignore: cast_nullable_to_non_nullable
as EmailInput,signupCodeInput: null == signupCodeInput ? _self.signupCodeInput : signupCodeInput // ignore: cast_nullable_to_non_nullable
as CodeInput,
  ));
}

}


/// Adds pattern-matching-related methods to [LoginState].
extension LoginStatePatterns on LoginState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({required TResult orElse(),}){
final _that = this;
switch (_that) {
case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(){
final _that = this;
switch (_that) {
case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({required TResult orElse(),}) {final _that = this;
switch (_that) {
case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>() {final _that = this;
switch (_that) {
case _:
  return null;

}
}

}

// dart format on
