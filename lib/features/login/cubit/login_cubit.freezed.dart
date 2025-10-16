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
  bool get processing;
  LoginMode? get mode;
  String? get coreUrl;
  String? get tenantId;
  WebtritSystemInfo? get systemInfo;
  List<LoginType>? get supportedLoginTypes;
  SessionOtpProvisionalWithDateTime?
      get otpSigninSessionOtpProvisionalWithDateTime;
  bool get passwordSigninPasswordInputObscureText;
  SessionOtpProvisionalWithDateTime?
      get signupSessionOtpProvisionalWithDateTime;
  String? get token;
  String?
      get userId; // Used to represent an embedded launch page or a login type within tabbed navigation
  EmbeddedData?
      get embedded; // Extras and callback data that returned from the embedded page
  Map<String, dynamic>? get embeddedExtras;
  Map<String, dynamic>? get embeddedCallbackData;
  Object? get embeddedRequestError;
  UrlInput get coreUrlInput;
  UserRefInput get otpSigninUserRefInput;
  CodeInput get otpSigninCodeInput;
  UserRefInput get passwordSigninUserRefInput;
  PasswordInput get passwordSigninPasswordInput;
  EmailInput get signupEmailInput;
  CodeInput get signupCodeInput;

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LoginStateCopyWith<LoginState> get copyWith =>
      _$LoginStateCopyWithImpl<LoginState>(this as LoginState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LoginState &&
            (identical(other.processing, processing) ||
                other.processing == processing) &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.coreUrl, coreUrl) || other.coreUrl == coreUrl) &&
            (identical(other.tenantId, tenantId) ||
                other.tenantId == tenantId) &&
            (identical(other.systemInfo, systemInfo) ||
                other.systemInfo == systemInfo) &&
            const DeepCollectionEquality()
                .equals(other.supportedLoginTypes, supportedLoginTypes) &&
            (identical(other.otpSigninSessionOtpProvisionalWithDateTime,
                    otpSigninSessionOtpProvisionalWithDateTime) ||
                other.otpSigninSessionOtpProvisionalWithDateTime ==
                    otpSigninSessionOtpProvisionalWithDateTime) &&
            (identical(other.passwordSigninPasswordInputObscureText, passwordSigninPasswordInputObscureText) ||
                other.passwordSigninPasswordInputObscureText ==
                    passwordSigninPasswordInputObscureText) &&
            (identical(other.signupSessionOtpProvisionalWithDateTime, signupSessionOtpProvisionalWithDateTime) ||
                other.signupSessionOtpProvisionalWithDateTime ==
                    signupSessionOtpProvisionalWithDateTime) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.embedded, embedded) ||
                other.embedded == embedded) &&
            const DeepCollectionEquality()
                .equals(other.embeddedExtras, embeddedExtras) &&
            const DeepCollectionEquality()
                .equals(other.embeddedCallbackData, embeddedCallbackData) &&
            const DeepCollectionEquality()
                .equals(other.embeddedRequestError, embeddedRequestError) &&
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
  int get hashCode => Object.hashAll([
        runtimeType,
        processing,
        mode,
        coreUrl,
        tenantId,
        systemInfo,
        const DeepCollectionEquality().hash(supportedLoginTypes),
        otpSigninSessionOtpProvisionalWithDateTime,
        passwordSigninPasswordInputObscureText,
        signupSessionOtpProvisionalWithDateTime,
        token,
        userId,
        embedded,
        const DeepCollectionEquality().hash(embeddedExtras),
        const DeepCollectionEquality().hash(embeddedCallbackData),
        const DeepCollectionEquality().hash(embeddedRequestError),
        coreUrlInput,
        otpSigninUserRefInput,
        otpSigninCodeInput,
        passwordSigninUserRefInput,
        passwordSigninPasswordInput,
        signupEmailInput,
        signupCodeInput
      ]);

  @override
  String toString() {
    return 'LoginState(processing: $processing, mode: $mode, coreUrl: $coreUrl, tenantId: $tenantId, systemInfo: $systemInfo, supportedLoginTypes: $supportedLoginTypes, otpSigninSessionOtpProvisionalWithDateTime: $otpSigninSessionOtpProvisionalWithDateTime, passwordSigninPasswordInputObscureText: $passwordSigninPasswordInputObscureText, signupSessionOtpProvisionalWithDateTime: $signupSessionOtpProvisionalWithDateTime, token: $token, userId: $userId, embedded: $embedded, embeddedExtras: $embeddedExtras, embeddedCallbackData: $embeddedCallbackData, embeddedRequestError: $embeddedRequestError, coreUrlInput: $coreUrlInput, otpSigninUserRefInput: $otpSigninUserRefInput, otpSigninCodeInput: $otpSigninCodeInput, passwordSigninUserRefInput: $passwordSigninUserRefInput, passwordSigninPasswordInput: $passwordSigninPasswordInput, signupEmailInput: $signupEmailInput, signupCodeInput: $signupCodeInput)';
  }
}

/// @nodoc
abstract mixin class $LoginStateCopyWith<$Res> {
  factory $LoginStateCopyWith(
          LoginState value, $Res Function(LoginState) _then) =
      _$LoginStateCopyWithImpl;
  @useResult
  $Res call(
      {bool processing,
      LoginMode? mode,
      String? coreUrl,
      String? tenantId,
      WebtritSystemInfo? systemInfo,
      List<LoginType>? supportedLoginTypes,
      SessionOtpProvisionalWithDateTime?
          otpSigninSessionOtpProvisionalWithDateTime,
      bool passwordSigninPasswordInputObscureText,
      SessionOtpProvisionalWithDateTime?
          signupSessionOtpProvisionalWithDateTime,
      String? token,
      String? userId,
      EmbeddedData? embedded,
      Map<String, dynamic>? embeddedExtras,
      Map<String, dynamic>? embeddedCallbackData,
      Object? embeddedRequestError,
      UrlInput coreUrlInput,
      UserRefInput otpSigninUserRefInput,
      CodeInput otpSigninCodeInput,
      UserRefInput passwordSigninUserRefInput,
      PasswordInput passwordSigninPasswordInput,
      EmailInput signupEmailInput,
      CodeInput signupCodeInput});
}

/// @nodoc
class _$LoginStateCopyWithImpl<$Res> implements $LoginStateCopyWith<$Res> {
  _$LoginStateCopyWithImpl(this._self, this._then);

  final LoginState _self;
  final $Res Function(LoginState) _then;

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? processing = null,
    Object? mode = freezed,
    Object? coreUrl = freezed,
    Object? tenantId = freezed,
    Object? systemInfo = freezed,
    Object? supportedLoginTypes = freezed,
    Object? otpSigninSessionOtpProvisionalWithDateTime = freezed,
    Object? passwordSigninPasswordInputObscureText = null,
    Object? signupSessionOtpProvisionalWithDateTime = freezed,
    Object? token = freezed,
    Object? userId = freezed,
    Object? embedded = freezed,
    Object? embeddedExtras = freezed,
    Object? embeddedCallbackData = freezed,
    Object? embeddedRequestError = freezed,
    Object? coreUrlInput = null,
    Object? otpSigninUserRefInput = null,
    Object? otpSigninCodeInput = null,
    Object? passwordSigninUserRefInput = null,
    Object? passwordSigninPasswordInput = null,
    Object? signupEmailInput = null,
    Object? signupCodeInput = null,
  }) {
    return _then(_self.copyWith(
      processing: null == processing
          ? _self.processing
          : processing // ignore: cast_nullable_to_non_nullable
              as bool,
      mode: freezed == mode
          ? _self.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as LoginMode?,
      coreUrl: freezed == coreUrl
          ? _self.coreUrl
          : coreUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      tenantId: freezed == tenantId
          ? _self.tenantId
          : tenantId // ignore: cast_nullable_to_non_nullable
              as String?,
      systemInfo: freezed == systemInfo
          ? _self.systemInfo
          : systemInfo // ignore: cast_nullable_to_non_nullable
              as WebtritSystemInfo?,
      supportedLoginTypes: freezed == supportedLoginTypes
          ? _self.supportedLoginTypes
          : supportedLoginTypes // ignore: cast_nullable_to_non_nullable
              as List<LoginType>?,
      otpSigninSessionOtpProvisionalWithDateTime: freezed ==
              otpSigninSessionOtpProvisionalWithDateTime
          ? _self.otpSigninSessionOtpProvisionalWithDateTime
          : otpSigninSessionOtpProvisionalWithDateTime // ignore: cast_nullable_to_non_nullable
              as SessionOtpProvisionalWithDateTime?,
      passwordSigninPasswordInputObscureText: null ==
              passwordSigninPasswordInputObscureText
          ? _self.passwordSigninPasswordInputObscureText
          : passwordSigninPasswordInputObscureText // ignore: cast_nullable_to_non_nullable
              as bool,
      signupSessionOtpProvisionalWithDateTime: freezed ==
              signupSessionOtpProvisionalWithDateTime
          ? _self.signupSessionOtpProvisionalWithDateTime
          : signupSessionOtpProvisionalWithDateTime // ignore: cast_nullable_to_non_nullable
              as SessionOtpProvisionalWithDateTime?,
      token: freezed == token
          ? _self.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      embedded: freezed == embedded
          ? _self.embedded
          : embedded // ignore: cast_nullable_to_non_nullable
              as EmbeddedData?,
      embeddedExtras: freezed == embeddedExtras
          ? _self.embeddedExtras
          : embeddedExtras // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      embeddedCallbackData: freezed == embeddedCallbackData
          ? _self.embeddedCallbackData
          : embeddedCallbackData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      embeddedRequestError: freezed == embeddedRequestError
          ? _self.embeddedRequestError
          : embeddedRequestError,
      coreUrlInput: null == coreUrlInput
          ? _self.coreUrlInput
          : coreUrlInput // ignore: cast_nullable_to_non_nullable
              as UrlInput,
      otpSigninUserRefInput: null == otpSigninUserRefInput
          ? _self.otpSigninUserRefInput
          : otpSigninUserRefInput // ignore: cast_nullable_to_non_nullable
              as UserRefInput,
      otpSigninCodeInput: null == otpSigninCodeInput
          ? _self.otpSigninCodeInput
          : otpSigninCodeInput // ignore: cast_nullable_to_non_nullable
              as CodeInput,
      passwordSigninUserRefInput: null == passwordSigninUserRefInput
          ? _self.passwordSigninUserRefInput
          : passwordSigninUserRefInput // ignore: cast_nullable_to_non_nullable
              as UserRefInput,
      passwordSigninPasswordInput: null == passwordSigninPasswordInput
          ? _self.passwordSigninPasswordInput
          : passwordSigninPasswordInput // ignore: cast_nullable_to_non_nullable
              as PasswordInput,
      signupEmailInput: null == signupEmailInput
          ? _self.signupEmailInput
          : signupEmailInput // ignore: cast_nullable_to_non_nullable
              as EmailInput,
      signupCodeInput: null == signupCodeInput
          ? _self.signupCodeInput
          : signupCodeInput // ignore: cast_nullable_to_non_nullable
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

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_LoginState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LoginState() when $default != null:
        return $default(_that);
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_LoginState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LoginState():
        return $default(_that);
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_LoginState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LoginState() when $default != null:
        return $default(_that);
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            bool processing,
            LoginMode? mode,
            String? coreUrl,
            String? tenantId,
            WebtritSystemInfo? systemInfo,
            List<LoginType>? supportedLoginTypes,
            SessionOtpProvisionalWithDateTime?
                otpSigninSessionOtpProvisionalWithDateTime,
            bool passwordSigninPasswordInputObscureText,
            SessionOtpProvisionalWithDateTime?
                signupSessionOtpProvisionalWithDateTime,
            String? token,
            String? userId,
            EmbeddedData? embedded,
            Map<String, dynamic>? embeddedExtras,
            Map<String, dynamic>? embeddedCallbackData,
            Object? embeddedRequestError,
            UrlInput coreUrlInput,
            UserRefInput otpSigninUserRefInput,
            CodeInput otpSigninCodeInput,
            UserRefInput passwordSigninUserRefInput,
            PasswordInput passwordSigninPasswordInput,
            EmailInput signupEmailInput,
            CodeInput signupCodeInput)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LoginState() when $default != null:
        return $default(
            _that.processing,
            _that.mode,
            _that.coreUrl,
            _that.tenantId,
            _that.systemInfo,
            _that.supportedLoginTypes,
            _that.otpSigninSessionOtpProvisionalWithDateTime,
            _that.passwordSigninPasswordInputObscureText,
            _that.signupSessionOtpProvisionalWithDateTime,
            _that.token,
            _that.userId,
            _that.embedded,
            _that.embeddedExtras,
            _that.embeddedCallbackData,
            _that.embeddedRequestError,
            _that.coreUrlInput,
            _that.otpSigninUserRefInput,
            _that.otpSigninCodeInput,
            _that.passwordSigninUserRefInput,
            _that.passwordSigninPasswordInput,
            _that.signupEmailInput,
            _that.signupCodeInput);
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            bool processing,
            LoginMode? mode,
            String? coreUrl,
            String? tenantId,
            WebtritSystemInfo? systemInfo,
            List<LoginType>? supportedLoginTypes,
            SessionOtpProvisionalWithDateTime?
                otpSigninSessionOtpProvisionalWithDateTime,
            bool passwordSigninPasswordInputObscureText,
            SessionOtpProvisionalWithDateTime?
                signupSessionOtpProvisionalWithDateTime,
            String? token,
            String? userId,
            EmbeddedData? embedded,
            Map<String, dynamic>? embeddedExtras,
            Map<String, dynamic>? embeddedCallbackData,
            Object? embeddedRequestError,
            UrlInput coreUrlInput,
            UserRefInput otpSigninUserRefInput,
            CodeInput otpSigninCodeInput,
            UserRefInput passwordSigninUserRefInput,
            PasswordInput passwordSigninPasswordInput,
            EmailInput signupEmailInput,
            CodeInput signupCodeInput)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LoginState():
        return $default(
            _that.processing,
            _that.mode,
            _that.coreUrl,
            _that.tenantId,
            _that.systemInfo,
            _that.supportedLoginTypes,
            _that.otpSigninSessionOtpProvisionalWithDateTime,
            _that.passwordSigninPasswordInputObscureText,
            _that.signupSessionOtpProvisionalWithDateTime,
            _that.token,
            _that.userId,
            _that.embedded,
            _that.embeddedExtras,
            _that.embeddedCallbackData,
            _that.embeddedRequestError,
            _that.coreUrlInput,
            _that.otpSigninUserRefInput,
            _that.otpSigninCodeInput,
            _that.passwordSigninUserRefInput,
            _that.passwordSigninPasswordInput,
            _that.signupEmailInput,
            _that.signupCodeInput);
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            bool processing,
            LoginMode? mode,
            String? coreUrl,
            String? tenantId,
            WebtritSystemInfo? systemInfo,
            List<LoginType>? supportedLoginTypes,
            SessionOtpProvisionalWithDateTime?
                otpSigninSessionOtpProvisionalWithDateTime,
            bool passwordSigninPasswordInputObscureText,
            SessionOtpProvisionalWithDateTime?
                signupSessionOtpProvisionalWithDateTime,
            String? token,
            String? userId,
            EmbeddedData? embedded,
            Map<String, dynamic>? embeddedExtras,
            Map<String, dynamic>? embeddedCallbackData,
            Object? embeddedRequestError,
            UrlInput coreUrlInput,
            UserRefInput otpSigninUserRefInput,
            CodeInput otpSigninCodeInput,
            UserRefInput passwordSigninUserRefInput,
            PasswordInput passwordSigninPasswordInput,
            EmailInput signupEmailInput,
            CodeInput signupCodeInput)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LoginState() when $default != null:
        return $default(
            _that.processing,
            _that.mode,
            _that.coreUrl,
            _that.tenantId,
            _that.systemInfo,
            _that.supportedLoginTypes,
            _that.otpSigninSessionOtpProvisionalWithDateTime,
            _that.passwordSigninPasswordInputObscureText,
            _that.signupSessionOtpProvisionalWithDateTime,
            _that.token,
            _that.userId,
            _that.embedded,
            _that.embeddedExtras,
            _that.embeddedCallbackData,
            _that.embeddedRequestError,
            _that.coreUrlInput,
            _that.otpSigninUserRefInput,
            _that.otpSigninCodeInput,
            _that.passwordSigninUserRefInput,
            _that.passwordSigninPasswordInput,
            _that.signupEmailInput,
            _that.signupCodeInput);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _LoginState implements LoginState {
  const _LoginState(
      {this.processing = false,
      this.mode,
      this.coreUrl,
      this.tenantId,
      this.systemInfo,
      final List<LoginType>? supportedLoginTypes,
      this.otpSigninSessionOtpProvisionalWithDateTime,
      this.passwordSigninPasswordInputObscureText = true,
      this.signupSessionOtpProvisionalWithDateTime,
      this.token,
      this.userId,
      this.embedded,
      final Map<String, dynamic>? embeddedExtras,
      final Map<String, dynamic>? embeddedCallbackData,
      this.embeddedRequestError,
      this.coreUrlInput = const UrlInput.pure(),
      this.otpSigninUserRefInput = const UserRefInput.pure(),
      this.otpSigninCodeInput = const CodeInput.pure(),
      this.passwordSigninUserRefInput = const UserRefInput.pure(),
      this.passwordSigninPasswordInput = const PasswordInput.pure(),
      this.signupEmailInput = const EmailInput.pure(),
      this.signupCodeInput = const CodeInput.pure()})
      : _supportedLoginTypes = supportedLoginTypes,
        _embeddedExtras = embeddedExtras,
        _embeddedCallbackData = embeddedCallbackData;

  @override
  @JsonKey()
  final bool processing;
  @override
  final LoginMode? mode;
  @override
  final String? coreUrl;
  @override
  final String? tenantId;
  @override
  final WebtritSystemInfo? systemInfo;
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
  final SessionOtpProvisionalWithDateTime?
      otpSigninSessionOtpProvisionalWithDateTime;
  @override
  @JsonKey()
  final bool passwordSigninPasswordInputObscureText;
  @override
  final SessionOtpProvisionalWithDateTime?
      signupSessionOtpProvisionalWithDateTime;
  @override
  final String? token;
  @override
  final String? userId;
// Used to represent an embedded launch page or a login type within tabbed navigation
  @override
  final EmbeddedData? embedded;
// Extras and callback data that returned from the embedded page
  final Map<String, dynamic>? _embeddedExtras;
// Extras and callback data that returned from the embedded page
  @override
  Map<String, dynamic>? get embeddedExtras {
    final value = _embeddedExtras;
    if (value == null) return null;
    if (_embeddedExtras is EqualUnmodifiableMapView) return _embeddedExtras;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, dynamic>? _embeddedCallbackData;
  @override
  Map<String, dynamic>? get embeddedCallbackData {
    final value = _embeddedCallbackData;
    if (value == null) return null;
    if (_embeddedCallbackData is EqualUnmodifiableMapView)
      return _embeddedCallbackData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final Object? embeddedRequestError;
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

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LoginStateCopyWith<_LoginState> get copyWith =>
      __$LoginStateCopyWithImpl<_LoginState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LoginState &&
            (identical(other.processing, processing) ||
                other.processing == processing) &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.coreUrl, coreUrl) || other.coreUrl == coreUrl) &&
            (identical(other.tenantId, tenantId) ||
                other.tenantId == tenantId) &&
            (identical(other.systemInfo, systemInfo) ||
                other.systemInfo == systemInfo) &&
            const DeepCollectionEquality()
                .equals(other._supportedLoginTypes, _supportedLoginTypes) &&
            (identical(other.otpSigninSessionOtpProvisionalWithDateTime,
                    otpSigninSessionOtpProvisionalWithDateTime) ||
                other.otpSigninSessionOtpProvisionalWithDateTime ==
                    otpSigninSessionOtpProvisionalWithDateTime) &&
            (identical(other.passwordSigninPasswordInputObscureText, passwordSigninPasswordInputObscureText) ||
                other.passwordSigninPasswordInputObscureText ==
                    passwordSigninPasswordInputObscureText) &&
            (identical(other.signupSessionOtpProvisionalWithDateTime, signupSessionOtpProvisionalWithDateTime) ||
                other.signupSessionOtpProvisionalWithDateTime ==
                    signupSessionOtpProvisionalWithDateTime) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.embedded, embedded) ||
                other.embedded == embedded) &&
            const DeepCollectionEquality()
                .equals(other._embeddedExtras, _embeddedExtras) &&
            const DeepCollectionEquality()
                .equals(other._embeddedCallbackData, _embeddedCallbackData) &&
            const DeepCollectionEquality()
                .equals(other.embeddedRequestError, embeddedRequestError) &&
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
  int get hashCode => Object.hashAll([
        runtimeType,
        processing,
        mode,
        coreUrl,
        tenantId,
        systemInfo,
        const DeepCollectionEquality().hash(_supportedLoginTypes),
        otpSigninSessionOtpProvisionalWithDateTime,
        passwordSigninPasswordInputObscureText,
        signupSessionOtpProvisionalWithDateTime,
        token,
        userId,
        embedded,
        const DeepCollectionEquality().hash(_embeddedExtras),
        const DeepCollectionEquality().hash(_embeddedCallbackData),
        const DeepCollectionEquality().hash(embeddedRequestError),
        coreUrlInput,
        otpSigninUserRefInput,
        otpSigninCodeInput,
        passwordSigninUserRefInput,
        passwordSigninPasswordInput,
        signupEmailInput,
        signupCodeInput
      ]);

  @override
  String toString() {
    return 'LoginState(processing: $processing, mode: $mode, coreUrl: $coreUrl, tenantId: $tenantId, systemInfo: $systemInfo, supportedLoginTypes: $supportedLoginTypes, otpSigninSessionOtpProvisionalWithDateTime: $otpSigninSessionOtpProvisionalWithDateTime, passwordSigninPasswordInputObscureText: $passwordSigninPasswordInputObscureText, signupSessionOtpProvisionalWithDateTime: $signupSessionOtpProvisionalWithDateTime, token: $token, userId: $userId, embedded: $embedded, embeddedExtras: $embeddedExtras, embeddedCallbackData: $embeddedCallbackData, embeddedRequestError: $embeddedRequestError, coreUrlInput: $coreUrlInput, otpSigninUserRefInput: $otpSigninUserRefInput, otpSigninCodeInput: $otpSigninCodeInput, passwordSigninUserRefInput: $passwordSigninUserRefInput, passwordSigninPasswordInput: $passwordSigninPasswordInput, signupEmailInput: $signupEmailInput, signupCodeInput: $signupCodeInput)';
  }
}

/// @nodoc
abstract mixin class _$LoginStateCopyWith<$Res>
    implements $LoginStateCopyWith<$Res> {
  factory _$LoginStateCopyWith(
          _LoginState value, $Res Function(_LoginState) _then) =
      __$LoginStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool processing,
      LoginMode? mode,
      String? coreUrl,
      String? tenantId,
      WebtritSystemInfo? systemInfo,
      List<LoginType>? supportedLoginTypes,
      SessionOtpProvisionalWithDateTime?
          otpSigninSessionOtpProvisionalWithDateTime,
      bool passwordSigninPasswordInputObscureText,
      SessionOtpProvisionalWithDateTime?
          signupSessionOtpProvisionalWithDateTime,
      String? token,
      String? userId,
      EmbeddedData? embedded,
      Map<String, dynamic>? embeddedExtras,
      Map<String, dynamic>? embeddedCallbackData,
      Object? embeddedRequestError,
      UrlInput coreUrlInput,
      UserRefInput otpSigninUserRefInput,
      CodeInput otpSigninCodeInput,
      UserRefInput passwordSigninUserRefInput,
      PasswordInput passwordSigninPasswordInput,
      EmailInput signupEmailInput,
      CodeInput signupCodeInput});
}

/// @nodoc
class __$LoginStateCopyWithImpl<$Res> implements _$LoginStateCopyWith<$Res> {
  __$LoginStateCopyWithImpl(this._self, this._then);

  final _LoginState _self;
  final $Res Function(_LoginState) _then;

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? processing = null,
    Object? mode = freezed,
    Object? coreUrl = freezed,
    Object? tenantId = freezed,
    Object? systemInfo = freezed,
    Object? supportedLoginTypes = freezed,
    Object? otpSigninSessionOtpProvisionalWithDateTime = freezed,
    Object? passwordSigninPasswordInputObscureText = null,
    Object? signupSessionOtpProvisionalWithDateTime = freezed,
    Object? token = freezed,
    Object? userId = freezed,
    Object? embedded = freezed,
    Object? embeddedExtras = freezed,
    Object? embeddedCallbackData = freezed,
    Object? embeddedRequestError = freezed,
    Object? coreUrlInput = null,
    Object? otpSigninUserRefInput = null,
    Object? otpSigninCodeInput = null,
    Object? passwordSigninUserRefInput = null,
    Object? passwordSigninPasswordInput = null,
    Object? signupEmailInput = null,
    Object? signupCodeInput = null,
  }) {
    return _then(_LoginState(
      processing: null == processing
          ? _self.processing
          : processing // ignore: cast_nullable_to_non_nullable
              as bool,
      mode: freezed == mode
          ? _self.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as LoginMode?,
      coreUrl: freezed == coreUrl
          ? _self.coreUrl
          : coreUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      tenantId: freezed == tenantId
          ? _self.tenantId
          : tenantId // ignore: cast_nullable_to_non_nullable
              as String?,
      systemInfo: freezed == systemInfo
          ? _self.systemInfo
          : systemInfo // ignore: cast_nullable_to_non_nullable
              as WebtritSystemInfo?,
      supportedLoginTypes: freezed == supportedLoginTypes
          ? _self._supportedLoginTypes
          : supportedLoginTypes // ignore: cast_nullable_to_non_nullable
              as List<LoginType>?,
      otpSigninSessionOtpProvisionalWithDateTime: freezed ==
              otpSigninSessionOtpProvisionalWithDateTime
          ? _self.otpSigninSessionOtpProvisionalWithDateTime
          : otpSigninSessionOtpProvisionalWithDateTime // ignore: cast_nullable_to_non_nullable
              as SessionOtpProvisionalWithDateTime?,
      passwordSigninPasswordInputObscureText: null ==
              passwordSigninPasswordInputObscureText
          ? _self.passwordSigninPasswordInputObscureText
          : passwordSigninPasswordInputObscureText // ignore: cast_nullable_to_non_nullable
              as bool,
      signupSessionOtpProvisionalWithDateTime: freezed ==
              signupSessionOtpProvisionalWithDateTime
          ? _self.signupSessionOtpProvisionalWithDateTime
          : signupSessionOtpProvisionalWithDateTime // ignore: cast_nullable_to_non_nullable
              as SessionOtpProvisionalWithDateTime?,
      token: freezed == token
          ? _self.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      embedded: freezed == embedded
          ? _self.embedded
          : embedded // ignore: cast_nullable_to_non_nullable
              as EmbeddedData?,
      embeddedExtras: freezed == embeddedExtras
          ? _self._embeddedExtras
          : embeddedExtras // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      embeddedCallbackData: freezed == embeddedCallbackData
          ? _self._embeddedCallbackData
          : embeddedCallbackData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      embeddedRequestError: freezed == embeddedRequestError
          ? _self.embeddedRequestError
          : embeddedRequestError,
      coreUrlInput: null == coreUrlInput
          ? _self.coreUrlInput
          : coreUrlInput // ignore: cast_nullable_to_non_nullable
              as UrlInput,
      otpSigninUserRefInput: null == otpSigninUserRefInput
          ? _self.otpSigninUserRefInput
          : otpSigninUserRefInput // ignore: cast_nullable_to_non_nullable
              as UserRefInput,
      otpSigninCodeInput: null == otpSigninCodeInput
          ? _self.otpSigninCodeInput
          : otpSigninCodeInput // ignore: cast_nullable_to_non_nullable
              as CodeInput,
      passwordSigninUserRefInput: null == passwordSigninUserRefInput
          ? _self.passwordSigninUserRefInput
          : passwordSigninUserRefInput // ignore: cast_nullable_to_non_nullable
              as UserRefInput,
      passwordSigninPasswordInput: null == passwordSigninPasswordInput
          ? _self.passwordSigninPasswordInput
          : passwordSigninPasswordInput // ignore: cast_nullable_to_non_nullable
              as PasswordInput,
      signupEmailInput: null == signupEmailInput
          ? _self.signupEmailInput
          : signupEmailInput // ignore: cast_nullable_to_non_nullable
              as EmailInput,
      signupCodeInput: null == signupCodeInput
          ? _self.signupCodeInput
          : signupCodeInput // ignore: cast_nullable_to_non_nullable
              as CodeInput,
    ));
  }
}

// dart format on
