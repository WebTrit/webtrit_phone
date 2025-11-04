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
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$LoginState {
  bool get processing => throw _privateConstructorUsedError;
  LoginMode? get mode => throw _privateConstructorUsedError;
  String? get coreUrl => throw _privateConstructorUsedError;
  String? get tenantId => throw _privateConstructorUsedError;
  WebtritSystemInfo? get systemInfo => throw _privateConstructorUsedError;
  List<LoginType>? get supportedLoginTypes =>
      throw _privateConstructorUsedError;
  (SessionOtpProvisional, DateTime)?
  get otpSigninSessionOtpProvisionalWithDateTime =>
      throw _privateConstructorUsedError;
  bool get passwordSigninPasswordInputObscureText =>
      throw _privateConstructorUsedError;
  (SessionOtpProvisional, DateTime)?
  get signupSessionOtpProvisionalWithDateTime =>
      throw _privateConstructorUsedError;
  String? get token => throw _privateConstructorUsedError;
  String? get userId =>
      throw _privateConstructorUsedError; // Used to represent an embedded launch page or a login type within tabbed navigation
  EmbeddedData? get embedded =>
      throw _privateConstructorUsedError; // Extras and callback data that returned from the embedded page
  Map<String, dynamic>? get embeddedExtras =>
      throw _privateConstructorUsedError;
  Map<String, dynamic>? get embeddedCallbackData =>
      throw _privateConstructorUsedError;
  Object? get embeddedRequestError => throw _privateConstructorUsedError;
  UrlInput get coreUrlInput => throw _privateConstructorUsedError;
  UserRefInput get otpSigninUserRefInput => throw _privateConstructorUsedError;
  CodeInput get otpSigninCodeInput => throw _privateConstructorUsedError;
  UserRefInput get passwordSigninUserRefInput =>
      throw _privateConstructorUsedError;
  PasswordInput get passwordSigninPasswordInput =>
      throw _privateConstructorUsedError;
  EmailInput get signupEmailInput => throw _privateConstructorUsedError;
  CodeInput get signupCodeInput => throw _privateConstructorUsedError;

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoginStateCopyWith<LoginState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginStateCopyWith<$Res> {
  factory $LoginStateCopyWith(
    LoginState value,
    $Res Function(LoginState) then,
  ) = _$LoginStateCopyWithImpl<$Res, LoginState>;
  @useResult
  $Res call({
    bool processing,
    LoginMode? mode,
    String? coreUrl,
    String? tenantId,
    WebtritSystemInfo? systemInfo,
    List<LoginType>? supportedLoginTypes,
    (SessionOtpProvisional, DateTime)?
    otpSigninSessionOtpProvisionalWithDateTime,
    bool passwordSigninPasswordInputObscureText,
    (SessionOtpProvisional, DateTime)? signupSessionOtpProvisionalWithDateTime,
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
    CodeInput signupCodeInput,
  });
}

/// @nodoc
class _$LoginStateCopyWithImpl<$Res, $Val extends LoginState>
    implements $LoginStateCopyWith<$Res> {
  _$LoginStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
    return _then(
      _value.copyWith(
            processing: null == processing
                ? _value.processing
                : processing // ignore: cast_nullable_to_non_nullable
                      as bool,
            mode: freezed == mode
                ? _value.mode
                : mode // ignore: cast_nullable_to_non_nullable
                      as LoginMode?,
            coreUrl: freezed == coreUrl
                ? _value.coreUrl
                : coreUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            tenantId: freezed == tenantId
                ? _value.tenantId
                : tenantId // ignore: cast_nullable_to_non_nullable
                      as String?,
            systemInfo: freezed == systemInfo
                ? _value.systemInfo
                : systemInfo // ignore: cast_nullable_to_non_nullable
                      as WebtritSystemInfo?,
            supportedLoginTypes: freezed == supportedLoginTypes
                ? _value.supportedLoginTypes
                : supportedLoginTypes // ignore: cast_nullable_to_non_nullable
                      as List<LoginType>?,
            otpSigninSessionOtpProvisionalWithDateTime:
                freezed == otpSigninSessionOtpProvisionalWithDateTime
                ? _value.otpSigninSessionOtpProvisionalWithDateTime
                : otpSigninSessionOtpProvisionalWithDateTime // ignore: cast_nullable_to_non_nullable
                      as (SessionOtpProvisional, DateTime)?,
            passwordSigninPasswordInputObscureText:
                null == passwordSigninPasswordInputObscureText
                ? _value.passwordSigninPasswordInputObscureText
                : passwordSigninPasswordInputObscureText // ignore: cast_nullable_to_non_nullable
                      as bool,
            signupSessionOtpProvisionalWithDateTime:
                freezed == signupSessionOtpProvisionalWithDateTime
                ? _value.signupSessionOtpProvisionalWithDateTime
                : signupSessionOtpProvisionalWithDateTime // ignore: cast_nullable_to_non_nullable
                      as (SessionOtpProvisional, DateTime)?,
            token: freezed == token
                ? _value.token
                : token // ignore: cast_nullable_to_non_nullable
                      as String?,
            userId: freezed == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String?,
            embedded: freezed == embedded
                ? _value.embedded
                : embedded // ignore: cast_nullable_to_non_nullable
                      as EmbeddedData?,
            embeddedExtras: freezed == embeddedExtras
                ? _value.embeddedExtras
                : embeddedExtras // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            embeddedCallbackData: freezed == embeddedCallbackData
                ? _value.embeddedCallbackData
                : embeddedCallbackData // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            embeddedRequestError: freezed == embeddedRequestError
                ? _value.embeddedRequestError
                : embeddedRequestError,
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LoginStateImplCopyWith<$Res>
    implements $LoginStateCopyWith<$Res> {
  factory _$$LoginStateImplCopyWith(
    _$LoginStateImpl value,
    $Res Function(_$LoginStateImpl) then,
  ) = __$$LoginStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool processing,
    LoginMode? mode,
    String? coreUrl,
    String? tenantId,
    WebtritSystemInfo? systemInfo,
    List<LoginType>? supportedLoginTypes,
    (SessionOtpProvisional, DateTime)?
    otpSigninSessionOtpProvisionalWithDateTime,
    bool passwordSigninPasswordInputObscureText,
    (SessionOtpProvisional, DateTime)? signupSessionOtpProvisionalWithDateTime,
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
    CodeInput signupCodeInput,
  });
}

/// @nodoc
class __$$LoginStateImplCopyWithImpl<$Res>
    extends _$LoginStateCopyWithImpl<$Res, _$LoginStateImpl>
    implements _$$LoginStateImplCopyWith<$Res> {
  __$$LoginStateImplCopyWithImpl(
    _$LoginStateImpl _value,
    $Res Function(_$LoginStateImpl) _then,
  ) : super(_value, _then);

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
    return _then(
      _$LoginStateImpl(
        processing: null == processing
            ? _value.processing
            : processing // ignore: cast_nullable_to_non_nullable
                  as bool,
        mode: freezed == mode
            ? _value.mode
            : mode // ignore: cast_nullable_to_non_nullable
                  as LoginMode?,
        coreUrl: freezed == coreUrl
            ? _value.coreUrl
            : coreUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        tenantId: freezed == tenantId
            ? _value.tenantId
            : tenantId // ignore: cast_nullable_to_non_nullable
                  as String?,
        systemInfo: freezed == systemInfo
            ? _value.systemInfo
            : systemInfo // ignore: cast_nullable_to_non_nullable
                  as WebtritSystemInfo?,
        supportedLoginTypes: freezed == supportedLoginTypes
            ? _value._supportedLoginTypes
            : supportedLoginTypes // ignore: cast_nullable_to_non_nullable
                  as List<LoginType>?,
        otpSigninSessionOtpProvisionalWithDateTime:
            freezed == otpSigninSessionOtpProvisionalWithDateTime
            ? _value.otpSigninSessionOtpProvisionalWithDateTime
            : otpSigninSessionOtpProvisionalWithDateTime // ignore: cast_nullable_to_non_nullable
                  as (SessionOtpProvisional, DateTime)?,
        passwordSigninPasswordInputObscureText:
            null == passwordSigninPasswordInputObscureText
            ? _value.passwordSigninPasswordInputObscureText
            : passwordSigninPasswordInputObscureText // ignore: cast_nullable_to_non_nullable
                  as bool,
        signupSessionOtpProvisionalWithDateTime:
            freezed == signupSessionOtpProvisionalWithDateTime
            ? _value.signupSessionOtpProvisionalWithDateTime
            : signupSessionOtpProvisionalWithDateTime // ignore: cast_nullable_to_non_nullable
                  as (SessionOtpProvisional, DateTime)?,
        token: freezed == token
            ? _value.token
            : token // ignore: cast_nullable_to_non_nullable
                  as String?,
        userId: freezed == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String?,
        embedded: freezed == embedded
            ? _value.embedded
            : embedded // ignore: cast_nullable_to_non_nullable
                  as EmbeddedData?,
        embeddedExtras: freezed == embeddedExtras
            ? _value._embeddedExtras
            : embeddedExtras // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        embeddedCallbackData: freezed == embeddedCallbackData
            ? _value._embeddedCallbackData
            : embeddedCallbackData // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        embeddedRequestError: freezed == embeddedRequestError
            ? _value.embeddedRequestError
            : embeddedRequestError,
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
      ),
    );
  }
}

/// @nodoc

class _$LoginStateImpl implements _LoginState {
  const _$LoginStateImpl({
    this.processing = false,
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
    this.signupCodeInput = const CodeInput.pure(),
  }) : _supportedLoginTypes = supportedLoginTypes,
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
  final (SessionOtpProvisional, DateTime)?
  otpSigninSessionOtpProvisionalWithDateTime;
  @override
  @JsonKey()
  final bool passwordSigninPasswordInputObscureText;
  @override
  final (SessionOtpProvisional, DateTime)?
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

  @override
  String toString() {
    return 'LoginState(processing: $processing, mode: $mode, coreUrl: $coreUrl, tenantId: $tenantId, systemInfo: $systemInfo, supportedLoginTypes: $supportedLoginTypes, otpSigninSessionOtpProvisionalWithDateTime: $otpSigninSessionOtpProvisionalWithDateTime, passwordSigninPasswordInputObscureText: $passwordSigninPasswordInputObscureText, signupSessionOtpProvisionalWithDateTime: $signupSessionOtpProvisionalWithDateTime, token: $token, userId: $userId, embedded: $embedded, embeddedExtras: $embeddedExtras, embeddedCallbackData: $embeddedCallbackData, embeddedRequestError: $embeddedRequestError, coreUrlInput: $coreUrlInput, otpSigninUserRefInput: $otpSigninUserRefInput, otpSigninCodeInput: $otpSigninCodeInput, passwordSigninUserRefInput: $passwordSigninUserRefInput, passwordSigninPasswordInput: $passwordSigninPasswordInput, signupEmailInput: $signupEmailInput, signupCodeInput: $signupCodeInput)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginStateImpl &&
            (identical(other.processing, processing) ||
                other.processing == processing) &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.coreUrl, coreUrl) || other.coreUrl == coreUrl) &&
            (identical(other.tenantId, tenantId) ||
                other.tenantId == tenantId) &&
            (identical(other.systemInfo, systemInfo) ||
                other.systemInfo == systemInfo) &&
            const DeepCollectionEquality().equals(
              other._supportedLoginTypes,
              _supportedLoginTypes,
            ) &&
            (identical(
                  other.otpSigninSessionOtpProvisionalWithDateTime,
                  otpSigninSessionOtpProvisionalWithDateTime,
                ) ||
                other.otpSigninSessionOtpProvisionalWithDateTime ==
                    otpSigninSessionOtpProvisionalWithDateTime) &&
            (identical(
                  other.passwordSigninPasswordInputObscureText,
                  passwordSigninPasswordInputObscureText,
                ) ||
                other.passwordSigninPasswordInputObscureText ==
                    passwordSigninPasswordInputObscureText) &&
            (identical(
                  other.signupSessionOtpProvisionalWithDateTime,
                  signupSessionOtpProvisionalWithDateTime,
                ) ||
                other.signupSessionOtpProvisionalWithDateTime ==
                    signupSessionOtpProvisionalWithDateTime) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.embedded, embedded) ||
                other.embedded == embedded) &&
            const DeepCollectionEquality().equals(
              other._embeddedExtras,
              _embeddedExtras,
            ) &&
            const DeepCollectionEquality().equals(
              other._embeddedCallbackData,
              _embeddedCallbackData,
            ) &&
            const DeepCollectionEquality().equals(
              other.embeddedRequestError,
              embeddedRequestError,
            ) &&
            (identical(other.coreUrlInput, coreUrlInput) ||
                other.coreUrlInput == coreUrlInput) &&
            (identical(other.otpSigninUserRefInput, otpSigninUserRefInput) ||
                other.otpSigninUserRefInput == otpSigninUserRefInput) &&
            (identical(other.otpSigninCodeInput, otpSigninCodeInput) ||
                other.otpSigninCodeInput == otpSigninCodeInput) &&
            (identical(
                  other.passwordSigninUserRefInput,
                  passwordSigninUserRefInput,
                ) ||
                other.passwordSigninUserRefInput ==
                    passwordSigninUserRefInput) &&
            (identical(
                  other.passwordSigninPasswordInput,
                  passwordSigninPasswordInput,
                ) ||
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
    signupCodeInput,
  ]);

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginStateImplCopyWith<_$LoginStateImpl> get copyWith =>
      __$$LoginStateImplCopyWithImpl<_$LoginStateImpl>(this, _$identity);
}

abstract class _LoginState implements LoginState {
  const factory _LoginState({
    final bool processing,
    final LoginMode? mode,
    final String? coreUrl,
    final String? tenantId,
    final WebtritSystemInfo? systemInfo,
    final List<LoginType>? supportedLoginTypes,
    final (SessionOtpProvisional, DateTime)?
    otpSigninSessionOtpProvisionalWithDateTime,
    final bool passwordSigninPasswordInputObscureText,
    final (SessionOtpProvisional, DateTime)?
    signupSessionOtpProvisionalWithDateTime,
    final String? token,
    final String? userId,
    final EmbeddedData? embedded,
    final Map<String, dynamic>? embeddedExtras,
    final Map<String, dynamic>? embeddedCallbackData,
    final Object? embeddedRequestError,
    final UrlInput coreUrlInput,
    final UserRefInput otpSigninUserRefInput,
    final CodeInput otpSigninCodeInput,
    final UserRefInput passwordSigninUserRefInput,
    final PasswordInput passwordSigninPasswordInput,
    final EmailInput signupEmailInput,
    final CodeInput signupCodeInput,
  }) = _$LoginStateImpl;

  @override
  bool get processing;
  @override
  LoginMode? get mode;
  @override
  String? get coreUrl;
  @override
  String? get tenantId;
  @override
  WebtritSystemInfo? get systemInfo;
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
  String? get userId; // Used to represent an embedded launch page or a login type within tabbed navigation
  @override
  EmbeddedData? get embedded; // Extras and callback data that returned from the embedded page
  @override
  Map<String, dynamic>? get embeddedExtras;
  @override
  Map<String, dynamic>? get embeddedCallbackData;
  @override
  Object? get embeddedRequestError;
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

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginStateImplCopyWith<_$LoginStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
