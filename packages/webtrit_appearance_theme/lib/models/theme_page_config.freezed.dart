// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'theme_page_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ThemePageConfig {
  LoginPageConfig get login;
  AboutPageConfig get about;
  CallPageConfig get dialing;
  KeypadPageConfig get keypad;

  /// Create a copy of ThemePageConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ThemePageConfigCopyWith<ThemePageConfig> get copyWith =>
      _$ThemePageConfigCopyWithImpl<ThemePageConfig>(
          this as ThemePageConfig, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ThemePageConfig &&
            (identical(other.login, login) || other.login == login) &&
            (identical(other.about, about) || other.about == about) &&
            (identical(other.dialing, dialing) || other.dialing == dialing) &&
            (identical(other.keypad, keypad) || other.keypad == keypad));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, login, about, dialing, keypad);

  @override
  String toString() {
    return 'ThemePageConfig(login: $login, about: $about, dialing: $dialing, keypad: $keypad)';
  }
}

/// @nodoc
abstract mixin class $ThemePageConfigCopyWith<$Res> {
  factory $ThemePageConfigCopyWith(
          ThemePageConfig value, $Res Function(ThemePageConfig) _then) =
      _$ThemePageConfigCopyWithImpl;
  @useResult
  $Res call(
      {LoginPageConfig login,
      AboutPageConfig about,
      CallPageConfig dialing,
      KeypadPageConfig keypad});
}

/// @nodoc
class _$ThemePageConfigCopyWithImpl<$Res>
    implements $ThemePageConfigCopyWith<$Res> {
  _$ThemePageConfigCopyWithImpl(this._self, this._then);

  final ThemePageConfig _self;
  final $Res Function(ThemePageConfig) _then;

  /// Create a copy of ThemePageConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? login = null,
    Object? about = null,
    Object? dialing = null,
    Object? keypad = null,
  }) {
    return _then(ThemePageConfig(
      login: null == login
          ? _self.login
          : login // ignore: cast_nullable_to_non_nullable
              as LoginPageConfig,
      about: null == about
          ? _self.about
          : about // ignore: cast_nullable_to_non_nullable
              as AboutPageConfig,
      dialing: null == dialing
          ? _self.dialing
          : dialing // ignore: cast_nullable_to_non_nullable
              as CallPageConfig,
      keypad: null == keypad
          ? _self.keypad
          : keypad // ignore: cast_nullable_to_non_nullable
              as KeypadPageConfig,
    ));
  }
}

/// Adds pattern-matching-related methods to [ThemePageConfig].
extension ThemePageConfigPatterns on ThemePageConfig {
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
  TResult maybeMap<TResult extends Object?>({
    required TResult orElse(),
  }) {
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>() {
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>() {
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>() {
    final _that = this;
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }
}

/// @nodoc
mixin _$LoginPageConfig {
  LoginModeSelectPageConfig get modeSelect;
  LoginSwitchPageConfig get switchPage;
  LoginOtpSigninVerifyScreenPageConfig get otpSigninVerify;
  LoginSignupVerifyScreenPageConfig get signupVerify;

  /// Create a copy of LoginPageConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LoginPageConfigCopyWith<LoginPageConfig> get copyWith =>
      _$LoginPageConfigCopyWithImpl<LoginPageConfig>(
          this as LoginPageConfig, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LoginPageConfig &&
            (identical(other.modeSelect, modeSelect) ||
                other.modeSelect == modeSelect) &&
            (identical(other.switchPage, switchPage) ||
                other.switchPage == switchPage) &&
            (identical(other.otpSigninVerify, otpSigninVerify) ||
                other.otpSigninVerify == otpSigninVerify) &&
            (identical(other.signupVerify, signupVerify) ||
                other.signupVerify == signupVerify));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, modeSelect, switchPage, otpSigninVerify, signupVerify);

  @override
  String toString() {
    return 'LoginPageConfig(modeSelect: $modeSelect, switchPage: $switchPage, otpSigninVerify: $otpSigninVerify, signupVerify: $signupVerify)';
  }
}

/// @nodoc
abstract mixin class $LoginPageConfigCopyWith<$Res> {
  factory $LoginPageConfigCopyWith(
          LoginPageConfig value, $Res Function(LoginPageConfig) _then) =
      _$LoginPageConfigCopyWithImpl;
  @useResult
  $Res call(
      {LoginModeSelectPageConfig modeSelect,
      LoginSwitchPageConfig switchPage,
      LoginOtpSigninVerifyScreenPageConfig otpSigninVerify,
      LoginSignupVerifyScreenPageConfig signupVerify});
}

/// @nodoc
class _$LoginPageConfigCopyWithImpl<$Res>
    implements $LoginPageConfigCopyWith<$Res> {
  _$LoginPageConfigCopyWithImpl(this._self, this._then);

  final LoginPageConfig _self;
  final $Res Function(LoginPageConfig) _then;

  /// Create a copy of LoginPageConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? modeSelect = null,
    Object? switchPage = null,
    Object? otpSigninVerify = null,
    Object? signupVerify = null,
  }) {
    return _then(LoginPageConfig(
      modeSelect: null == modeSelect
          ? _self.modeSelect
          : modeSelect // ignore: cast_nullable_to_non_nullable
              as LoginModeSelectPageConfig,
      switchPage: null == switchPage
          ? _self.switchPage
          : switchPage // ignore: cast_nullable_to_non_nullable
              as LoginSwitchPageConfig,
      otpSigninVerify: null == otpSigninVerify
          ? _self.otpSigninVerify
          : otpSigninVerify // ignore: cast_nullable_to_non_nullable
              as LoginOtpSigninVerifyScreenPageConfig,
      signupVerify: null == signupVerify
          ? _self.signupVerify
          : signupVerify // ignore: cast_nullable_to_non_nullable
              as LoginSignupVerifyScreenPageConfig,
    ));
  }
}

/// Adds pattern-matching-related methods to [LoginPageConfig].
extension LoginPageConfigPatterns on LoginPageConfig {
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
  TResult maybeMap<TResult extends Object?>({
    required TResult orElse(),
  }) {
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>() {
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>() {
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>() {
    final _that = this;
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }
}

/// @nodoc
mixin _$LoginOtpSigninVerifyScreenPageConfig {
  int get countdownRepeatIntervalSeconds;

  /// Create a copy of LoginOtpSigninVerifyScreenPageConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LoginOtpSigninVerifyScreenPageConfigCopyWith<
          LoginOtpSigninVerifyScreenPageConfig>
      get copyWith => _$LoginOtpSigninVerifyScreenPageConfigCopyWithImpl<
              LoginOtpSigninVerifyScreenPageConfig>(
          this as LoginOtpSigninVerifyScreenPageConfig, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LoginOtpSigninVerifyScreenPageConfig &&
            (identical(other.countdownRepeatIntervalSeconds,
                    countdownRepeatIntervalSeconds) ||
                other.countdownRepeatIntervalSeconds ==
                    countdownRepeatIntervalSeconds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, countdownRepeatIntervalSeconds);

  @override
  String toString() {
    return 'LoginOtpSigninVerifyScreenPageConfig(countdownRepeatIntervalSeconds: $countdownRepeatIntervalSeconds)';
  }
}

/// @nodoc
abstract mixin class $LoginOtpSigninVerifyScreenPageConfigCopyWith<$Res> {
  factory $LoginOtpSigninVerifyScreenPageConfigCopyWith(
          LoginOtpSigninVerifyScreenPageConfig value,
          $Res Function(LoginOtpSigninVerifyScreenPageConfig) _then) =
      _$LoginOtpSigninVerifyScreenPageConfigCopyWithImpl;
  @useResult
  $Res call({int countdownRepeatIntervalSeconds});
}

/// @nodoc
class _$LoginOtpSigninVerifyScreenPageConfigCopyWithImpl<$Res>
    implements $LoginOtpSigninVerifyScreenPageConfigCopyWith<$Res> {
  _$LoginOtpSigninVerifyScreenPageConfigCopyWithImpl(this._self, this._then);

  final LoginOtpSigninVerifyScreenPageConfig _self;
  final $Res Function(LoginOtpSigninVerifyScreenPageConfig) _then;

  /// Create a copy of LoginOtpSigninVerifyScreenPageConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? countdownRepeatIntervalSeconds = null,
  }) {
    return _then(LoginOtpSigninVerifyScreenPageConfig(
      countdownRepeatIntervalSeconds: null == countdownRepeatIntervalSeconds
          ? _self.countdownRepeatIntervalSeconds
          : countdownRepeatIntervalSeconds // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [LoginOtpSigninVerifyScreenPageConfig].
extension LoginOtpSigninVerifyScreenPageConfigPatterns
    on LoginOtpSigninVerifyScreenPageConfig {
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
  TResult maybeMap<TResult extends Object?>({
    required TResult orElse(),
  }) {
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>() {
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>() {
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>() {
    final _that = this;
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }
}

/// @nodoc
mixin _$LoginSignupVerifyScreenPageConfig {
  int get countdownRepeatIntervalSeconds;

  /// Create a copy of LoginSignupVerifyScreenPageConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LoginSignupVerifyScreenPageConfigCopyWith<LoginSignupVerifyScreenPageConfig>
      get copyWith => _$LoginSignupVerifyScreenPageConfigCopyWithImpl<
              LoginSignupVerifyScreenPageConfig>(
          this as LoginSignupVerifyScreenPageConfig, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LoginSignupVerifyScreenPageConfig &&
            (identical(other.countdownRepeatIntervalSeconds,
                    countdownRepeatIntervalSeconds) ||
                other.countdownRepeatIntervalSeconds ==
                    countdownRepeatIntervalSeconds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, countdownRepeatIntervalSeconds);

  @override
  String toString() {
    return 'LoginSignupVerifyScreenPageConfig(countdownRepeatIntervalSeconds: $countdownRepeatIntervalSeconds)';
  }
}

/// @nodoc
abstract mixin class $LoginSignupVerifyScreenPageConfigCopyWith<$Res> {
  factory $LoginSignupVerifyScreenPageConfigCopyWith(
          LoginSignupVerifyScreenPageConfig value,
          $Res Function(LoginSignupVerifyScreenPageConfig) _then) =
      _$LoginSignupVerifyScreenPageConfigCopyWithImpl;
  @useResult
  $Res call({int countdownRepeatIntervalSeconds});
}

/// @nodoc
class _$LoginSignupVerifyScreenPageConfigCopyWithImpl<$Res>
    implements $LoginSignupVerifyScreenPageConfigCopyWith<$Res> {
  _$LoginSignupVerifyScreenPageConfigCopyWithImpl(this._self, this._then);

  final LoginSignupVerifyScreenPageConfig _self;
  final $Res Function(LoginSignupVerifyScreenPageConfig) _then;

  /// Create a copy of LoginSignupVerifyScreenPageConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? countdownRepeatIntervalSeconds = null,
  }) {
    return _then(LoginSignupVerifyScreenPageConfig(
      countdownRepeatIntervalSeconds: null == countdownRepeatIntervalSeconds
          ? _self.countdownRepeatIntervalSeconds
          : countdownRepeatIntervalSeconds // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// Adds pattern-matching-related methods to [LoginSignupVerifyScreenPageConfig].
extension LoginSignupVerifyScreenPageConfigPatterns
    on LoginSignupVerifyScreenPageConfig {
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
  TResult maybeMap<TResult extends Object?>({
    required TResult orElse(),
  }) {
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>() {
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>() {
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>() {
    final _that = this;
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }
}

/// @nodoc
mixin _$LoginModeSelectPageConfig {
  OverlayStyleModel? get systemUiOverlayStyle;
  ImageSource? get mainLogo;
  ElevatedButtonStyleType get buttonLoginStyleType;
  ElevatedButtonStyleType get buttonSignupStyleType;

  /// Create a copy of LoginModeSelectPageConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LoginModeSelectPageConfigCopyWith<LoginModeSelectPageConfig> get copyWith =>
      _$LoginModeSelectPageConfigCopyWithImpl<LoginModeSelectPageConfig>(
          this as LoginModeSelectPageConfig, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LoginModeSelectPageConfig &&
            (identical(other.systemUiOverlayStyle, systemUiOverlayStyle) ||
                other.systemUiOverlayStyle == systemUiOverlayStyle) &&
            (identical(other.mainLogo, mainLogo) ||
                other.mainLogo == mainLogo) &&
            (identical(other.buttonLoginStyleType, buttonLoginStyleType) ||
                other.buttonLoginStyleType == buttonLoginStyleType) &&
            (identical(other.buttonSignupStyleType, buttonSignupStyleType) ||
                other.buttonSignupStyleType == buttonSignupStyleType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, systemUiOverlayStyle, mainLogo,
      buttonLoginStyleType, buttonSignupStyleType);

  @override
  String toString() {
    return 'LoginModeSelectPageConfig(systemUiOverlayStyle: $systemUiOverlayStyle, mainLogo: $mainLogo, buttonLoginStyleType: $buttonLoginStyleType, buttonSignupStyleType: $buttonSignupStyleType)';
  }
}

/// @nodoc
abstract mixin class $LoginModeSelectPageConfigCopyWith<$Res> {
  factory $LoginModeSelectPageConfigCopyWith(LoginModeSelectPageConfig value,
          $Res Function(LoginModeSelectPageConfig) _then) =
      _$LoginModeSelectPageConfigCopyWithImpl;
  @useResult
  $Res call(
      {OverlayStyleModel? systemUiOverlayStyle,
      ImageSource? mainLogo,
      ElevatedButtonStyleType buttonLoginStyleType,
      ElevatedButtonStyleType buttonSignupStyleType});
}

/// @nodoc
class _$LoginModeSelectPageConfigCopyWithImpl<$Res>
    implements $LoginModeSelectPageConfigCopyWith<$Res> {
  _$LoginModeSelectPageConfigCopyWithImpl(this._self, this._then);

  final LoginModeSelectPageConfig _self;
  final $Res Function(LoginModeSelectPageConfig) _then;

  /// Create a copy of LoginModeSelectPageConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? systemUiOverlayStyle = freezed,
    Object? mainLogo = freezed,
    Object? buttonLoginStyleType = null,
    Object? buttonSignupStyleType = null,
  }) {
    return _then(LoginModeSelectPageConfig(
      systemUiOverlayStyle: freezed == systemUiOverlayStyle
          ? _self.systemUiOverlayStyle
          : systemUiOverlayStyle // ignore: cast_nullable_to_non_nullable
              as OverlayStyleModel?,
      mainLogo: freezed == mainLogo
          ? _self.mainLogo
          : mainLogo // ignore: cast_nullable_to_non_nullable
              as ImageSource?,
      buttonLoginStyleType: null == buttonLoginStyleType
          ? _self.buttonLoginStyleType
          : buttonLoginStyleType // ignore: cast_nullable_to_non_nullable
              as ElevatedButtonStyleType,
      buttonSignupStyleType: null == buttonSignupStyleType
          ? _self.buttonSignupStyleType
          : buttonSignupStyleType // ignore: cast_nullable_to_non_nullable
              as ElevatedButtonStyleType,
    ));
  }
}

/// Adds pattern-matching-related methods to [LoginModeSelectPageConfig].
extension LoginModeSelectPageConfigPatterns on LoginModeSelectPageConfig {
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
  TResult maybeMap<TResult extends Object?>({
    required TResult orElse(),
  }) {
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>() {
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>() {
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>() {
    final _that = this;
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }
}

/// @nodoc
mixin _$LoginSwitchPageConfig {
  ImageSource? get mainLogo;

  /// Create a copy of LoginSwitchPageConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LoginSwitchPageConfigCopyWith<LoginSwitchPageConfig> get copyWith =>
      _$LoginSwitchPageConfigCopyWithImpl<LoginSwitchPageConfig>(
          this as LoginSwitchPageConfig, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LoginSwitchPageConfig &&
            (identical(other.mainLogo, mainLogo) ||
                other.mainLogo == mainLogo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, mainLogo);

  @override
  String toString() {
    return 'LoginSwitchPageConfig(mainLogo: $mainLogo)';
  }
}

/// @nodoc
abstract mixin class $LoginSwitchPageConfigCopyWith<$Res> {
  factory $LoginSwitchPageConfigCopyWith(LoginSwitchPageConfig value,
          $Res Function(LoginSwitchPageConfig) _then) =
      _$LoginSwitchPageConfigCopyWithImpl;
  @useResult
  $Res call({ImageSource? mainLogo});
}

/// @nodoc
class _$LoginSwitchPageConfigCopyWithImpl<$Res>
    implements $LoginSwitchPageConfigCopyWith<$Res> {
  _$LoginSwitchPageConfigCopyWithImpl(this._self, this._then);

  final LoginSwitchPageConfig _self;
  final $Res Function(LoginSwitchPageConfig) _then;

  /// Create a copy of LoginSwitchPageConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mainLogo = freezed,
  }) {
    return _then(LoginSwitchPageConfig(
      mainLogo: freezed == mainLogo
          ? _self.mainLogo
          : mainLogo // ignore: cast_nullable_to_non_nullable
              as ImageSource?,
    ));
  }
}

/// Adds pattern-matching-related methods to [LoginSwitchPageConfig].
extension LoginSwitchPageConfigPatterns on LoginSwitchPageConfig {
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
  TResult maybeMap<TResult extends Object?>({
    required TResult orElse(),
  }) {
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>() {
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>() {
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>() {
    final _that = this;
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }
}

/// @nodoc
mixin _$AboutPageConfig {
  ImageSource? get mainLogo;
  Metadata get metadata;

  /// Create a copy of AboutPageConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AboutPageConfigCopyWith<AboutPageConfig> get copyWith =>
      _$AboutPageConfigCopyWithImpl<AboutPageConfig>(
          this as AboutPageConfig, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AboutPageConfig &&
            (identical(other.mainLogo, mainLogo) ||
                other.mainLogo == mainLogo) &&
            (identical(other.metadata, metadata) ||
                other.metadata == metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, mainLogo, metadata);

  @override
  String toString() {
    return 'AboutPageConfig(mainLogo: $mainLogo, metadata: $metadata)';
  }
}

/// @nodoc
abstract mixin class $AboutPageConfigCopyWith<$Res> {
  factory $AboutPageConfigCopyWith(
          AboutPageConfig value, $Res Function(AboutPageConfig) _then) =
      _$AboutPageConfigCopyWithImpl;
  @useResult
  $Res call({ImageSource? mainLogo, Metadata metadata});
}

/// @nodoc
class _$AboutPageConfigCopyWithImpl<$Res>
    implements $AboutPageConfigCopyWith<$Res> {
  _$AboutPageConfigCopyWithImpl(this._self, this._then);

  final AboutPageConfig _self;
  final $Res Function(AboutPageConfig) _then;

  /// Create a copy of AboutPageConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mainLogo = freezed,
    Object? metadata = null,
  }) {
    return _then(AboutPageConfig(
      mainLogo: freezed == mainLogo
          ? _self.mainLogo
          : mainLogo // ignore: cast_nullable_to_non_nullable
              as ImageSource?,
      metadata: null == metadata
          ? _self.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Metadata,
    ));
  }
}

/// Adds pattern-matching-related methods to [AboutPageConfig].
extension AboutPageConfigPatterns on AboutPageConfig {
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
  TResult maybeMap<TResult extends Object?>({
    required TResult orElse(),
  }) {
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>() {
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>() {
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>() {
    final _that = this;
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }
}

/// @nodoc
mixin _$CallPageConfig {
  OverlayStyleModel? get systemUiOverlayStyle;
  AppBarStyleConfig? get appBarStyle;
  CallPageInfoConfig? get callInfo;
  CallPageActionsConfig? get actions;

  /// Create a copy of CallPageConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CallPageConfigCopyWith<CallPageConfig> get copyWith =>
      _$CallPageConfigCopyWithImpl<CallPageConfig>(
          this as CallPageConfig, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CallPageConfig &&
            (identical(other.systemUiOverlayStyle, systemUiOverlayStyle) ||
                other.systemUiOverlayStyle == systemUiOverlayStyle) &&
            (identical(other.appBarStyle, appBarStyle) ||
                other.appBarStyle == appBarStyle) &&
            (identical(other.callInfo, callInfo) ||
                other.callInfo == callInfo) &&
            (identical(other.actions, actions) || other.actions == actions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, systemUiOverlayStyle, appBarStyle, callInfo, actions);

  @override
  String toString() {
    return 'CallPageConfig(systemUiOverlayStyle: $systemUiOverlayStyle, appBarStyle: $appBarStyle, callInfo: $callInfo, actions: $actions)';
  }
}

/// @nodoc
abstract mixin class $CallPageConfigCopyWith<$Res> {
  factory $CallPageConfigCopyWith(
          CallPageConfig value, $Res Function(CallPageConfig) _then) =
      _$CallPageConfigCopyWithImpl;
  @useResult
  $Res call(
      {OverlayStyleModel? systemUiOverlayStyle,
      AppBarStyleConfig? appBarStyle,
      CallPageInfoConfig? callInfo,
      CallPageActionsConfig? actions});
}

/// @nodoc
class _$CallPageConfigCopyWithImpl<$Res>
    implements $CallPageConfigCopyWith<$Res> {
  _$CallPageConfigCopyWithImpl(this._self, this._then);

  final CallPageConfig _self;
  final $Res Function(CallPageConfig) _then;

  /// Create a copy of CallPageConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? systemUiOverlayStyle = freezed,
    Object? appBarStyle = freezed,
    Object? callInfo = freezed,
    Object? actions = freezed,
  }) {
    return _then(CallPageConfig(
      systemUiOverlayStyle: freezed == systemUiOverlayStyle
          ? _self.systemUiOverlayStyle
          : systemUiOverlayStyle // ignore: cast_nullable_to_non_nullable
              as OverlayStyleModel?,
      appBarStyle: freezed == appBarStyle
          ? _self.appBarStyle
          : appBarStyle // ignore: cast_nullable_to_non_nullable
              as AppBarStyleConfig?,
      callInfo: freezed == callInfo
          ? _self.callInfo
          : callInfo // ignore: cast_nullable_to_non_nullable
              as CallPageInfoConfig?,
      actions: freezed == actions
          ? _self.actions
          : actions // ignore: cast_nullable_to_non_nullable
              as CallPageActionsConfig?,
    ));
  }
}

/// Adds pattern-matching-related methods to [CallPageConfig].
extension CallPageConfigPatterns on CallPageConfig {
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
  TResult maybeMap<TResult extends Object?>({
    required TResult orElse(),
  }) {
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>() {
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>() {
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>() {
    final _that = this;
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }
}

/// @nodoc
mixin _$CallPageActionsConfig {
  ElevatedButtonWidgetConfig get callStart;
  ElevatedButtonWidgetConfig get hangup;
  ElevatedButtonWidgetConfig get transfer;
  ElevatedButtonWidgetConfig get camera;
  ElevatedButtonWidgetConfig get muted;
  ElevatedButtonWidgetConfig get speaker;
  ElevatedButtonWidgetConfig get held;
  ElevatedButtonWidgetConfig get swap;
  ElevatedButtonWidgetConfig get key;

  /// Create a copy of CallPageActionsConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CallPageActionsConfigCopyWith<CallPageActionsConfig> get copyWith =>
      _$CallPageActionsConfigCopyWithImpl<CallPageActionsConfig>(
          this as CallPageActionsConfig, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CallPageActionsConfig &&
            (identical(other.callStart, callStart) ||
                other.callStart == callStart) &&
            (identical(other.hangup, hangup) || other.hangup == hangup) &&
            (identical(other.transfer, transfer) ||
                other.transfer == transfer) &&
            (identical(other.camera, camera) || other.camera == camera) &&
            (identical(other.muted, muted) || other.muted == muted) &&
            (identical(other.speaker, speaker) || other.speaker == speaker) &&
            (identical(other.held, held) || other.held == held) &&
            (identical(other.swap, swap) || other.swap == swap) &&
            (identical(other.key, key) || other.key == key));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, callStart, hangup, transfer,
      camera, muted, speaker, held, swap, key);

  @override
  String toString() {
    return 'CallPageActionsConfig(callStart: $callStart, hangup: $hangup, transfer: $transfer, camera: $camera, muted: $muted, speaker: $speaker, held: $held, swap: $swap, key: $key)';
  }
}

/// @nodoc
abstract mixin class $CallPageActionsConfigCopyWith<$Res> {
  factory $CallPageActionsConfigCopyWith(CallPageActionsConfig value,
          $Res Function(CallPageActionsConfig) _then) =
      _$CallPageActionsConfigCopyWithImpl;
  @useResult
  $Res call(
      {ElevatedButtonWidgetConfig callStart,
      ElevatedButtonWidgetConfig hangup,
      ElevatedButtonWidgetConfig transfer,
      ElevatedButtonWidgetConfig camera,
      ElevatedButtonWidgetConfig muted,
      ElevatedButtonWidgetConfig speaker,
      ElevatedButtonWidgetConfig held,
      ElevatedButtonWidgetConfig swap,
      ElevatedButtonWidgetConfig key});
}

/// @nodoc
class _$CallPageActionsConfigCopyWithImpl<$Res>
    implements $CallPageActionsConfigCopyWith<$Res> {
  _$CallPageActionsConfigCopyWithImpl(this._self, this._then);

  final CallPageActionsConfig _self;
  final $Res Function(CallPageActionsConfig) _then;

  /// Create a copy of CallPageActionsConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? callStart = null,
    Object? hangup = null,
    Object? transfer = null,
    Object? camera = null,
    Object? muted = null,
    Object? speaker = null,
    Object? held = null,
    Object? swap = null,
    Object? key = null,
  }) {
    return _then(CallPageActionsConfig(
      callStart: null == callStart
          ? _self.callStart
          : callStart // ignore: cast_nullable_to_non_nullable
              as ElevatedButtonWidgetConfig,
      hangup: null == hangup
          ? _self.hangup
          : hangup // ignore: cast_nullable_to_non_nullable
              as ElevatedButtonWidgetConfig,
      transfer: null == transfer
          ? _self.transfer
          : transfer // ignore: cast_nullable_to_non_nullable
              as ElevatedButtonWidgetConfig,
      camera: null == camera
          ? _self.camera
          : camera // ignore: cast_nullable_to_non_nullable
              as ElevatedButtonWidgetConfig,
      muted: null == muted
          ? _self.muted
          : muted // ignore: cast_nullable_to_non_nullable
              as ElevatedButtonWidgetConfig,
      speaker: null == speaker
          ? _self.speaker
          : speaker // ignore: cast_nullable_to_non_nullable
              as ElevatedButtonWidgetConfig,
      held: null == held
          ? _self.held
          : held // ignore: cast_nullable_to_non_nullable
              as ElevatedButtonWidgetConfig,
      swap: null == swap
          ? _self.swap
          : swap // ignore: cast_nullable_to_non_nullable
              as ElevatedButtonWidgetConfig,
      key: null == key
          ? _self.key
          : key // ignore: cast_nullable_to_non_nullable
              as ElevatedButtonWidgetConfig,
    ));
  }
}

/// Adds pattern-matching-related methods to [CallPageActionsConfig].
extension CallPageActionsConfigPatterns on CallPageActionsConfig {
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
  TResult maybeMap<TResult extends Object?>({
    required TResult orElse(),
  }) {
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>() {
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>() {
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>() {
    final _that = this;
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }
}

/// @nodoc
mixin _$CallPageInfoConfig {
  TextStyleConfig? get usernameTextStyle;
  TextStyleConfig? get numberTextStyle;
  TextStyleConfig? get callStatusTextStyle;
  TextStyleConfig? get processingStatusTextStyle;

  /// Create a copy of CallPageInfoConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CallPageInfoConfigCopyWith<CallPageInfoConfig> get copyWith =>
      _$CallPageInfoConfigCopyWithImpl<CallPageInfoConfig>(
          this as CallPageInfoConfig, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CallPageInfoConfig &&
            (identical(other.usernameTextStyle, usernameTextStyle) ||
                other.usernameTextStyle == usernameTextStyle) &&
            (identical(other.numberTextStyle, numberTextStyle) ||
                other.numberTextStyle == numberTextStyle) &&
            (identical(other.callStatusTextStyle, callStatusTextStyle) ||
                other.callStatusTextStyle == callStatusTextStyle) &&
            (identical(other.processingStatusTextStyle,
                    processingStatusTextStyle) ||
                other.processingStatusTextStyle == processingStatusTextStyle));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, usernameTextStyle,
      numberTextStyle, callStatusTextStyle, processingStatusTextStyle);

  @override
  String toString() {
    return 'CallPageInfoConfig(usernameTextStyle: $usernameTextStyle, numberTextStyle: $numberTextStyle, callStatusTextStyle: $callStatusTextStyle, processingStatusTextStyle: $processingStatusTextStyle)';
  }
}

/// @nodoc
abstract mixin class $CallPageInfoConfigCopyWith<$Res> {
  factory $CallPageInfoConfigCopyWith(
          CallPageInfoConfig value, $Res Function(CallPageInfoConfig) _then) =
      _$CallPageInfoConfigCopyWithImpl;
  @useResult
  $Res call(
      {TextStyleConfig? usernameTextStyle,
      TextStyleConfig? numberTextStyle,
      TextStyleConfig? callStatusTextStyle,
      TextStyleConfig? processingStatusTextStyle});
}

/// @nodoc
class _$CallPageInfoConfigCopyWithImpl<$Res>
    implements $CallPageInfoConfigCopyWith<$Res> {
  _$CallPageInfoConfigCopyWithImpl(this._self, this._then);

  final CallPageInfoConfig _self;
  final $Res Function(CallPageInfoConfig) _then;

  /// Create a copy of CallPageInfoConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? usernameTextStyle = freezed,
    Object? numberTextStyle = freezed,
    Object? callStatusTextStyle = freezed,
    Object? processingStatusTextStyle = freezed,
  }) {
    return _then(CallPageInfoConfig(
      usernameTextStyle: freezed == usernameTextStyle
          ? _self.usernameTextStyle
          : usernameTextStyle // ignore: cast_nullable_to_non_nullable
              as TextStyleConfig?,
      numberTextStyle: freezed == numberTextStyle
          ? _self.numberTextStyle
          : numberTextStyle // ignore: cast_nullable_to_non_nullable
              as TextStyleConfig?,
      callStatusTextStyle: freezed == callStatusTextStyle
          ? _self.callStatusTextStyle
          : callStatusTextStyle // ignore: cast_nullable_to_non_nullable
              as TextStyleConfig?,
      processingStatusTextStyle: freezed == processingStatusTextStyle
          ? _self.processingStatusTextStyle
          : processingStatusTextStyle // ignore: cast_nullable_to_non_nullable
              as TextStyleConfig?,
    ));
  }
}

/// Adds pattern-matching-related methods to [CallPageInfoConfig].
extension CallPageInfoConfigPatterns on CallPageInfoConfig {
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
  TResult maybeMap<TResult extends Object?>({
    required TResult orElse(),
  }) {
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>() {
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>() {
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>() {
    final _that = this;
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }
}

/// @nodoc
mixin _$KeypadPageConfig {
  OverlayStyleModel? get systemUiOverlayStyle;
  TextFieldConfig? get textField;
  TextFieldConfig? get contactName;
  KeypadStyleConfig? get keypad;
  ActionPadWidgetConfig? get actionpad;

  /// Create a copy of KeypadPageConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $KeypadPageConfigCopyWith<KeypadPageConfig> get copyWith =>
      _$KeypadPageConfigCopyWithImpl<KeypadPageConfig>(
          this as KeypadPageConfig, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is KeypadPageConfig &&
            (identical(other.systemUiOverlayStyle, systemUiOverlayStyle) ||
                other.systemUiOverlayStyle == systemUiOverlayStyle) &&
            (identical(other.textField, textField) ||
                other.textField == textField) &&
            (identical(other.contactName, contactName) ||
                other.contactName == contactName) &&
            (identical(other.keypad, keypad) || other.keypad == keypad) &&
            (identical(other.actionpad, actionpad) ||
                other.actionpad == actionpad));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, systemUiOverlayStyle, textField,
      contactName, keypad, actionpad);

  @override
  String toString() {
    return 'KeypadPageConfig(systemUiOverlayStyle: $systemUiOverlayStyle, textField: $textField, contactName: $contactName, keypad: $keypad, actionpad: $actionpad)';
  }
}

/// @nodoc
abstract mixin class $KeypadPageConfigCopyWith<$Res> {
  factory $KeypadPageConfigCopyWith(
          KeypadPageConfig value, $Res Function(KeypadPageConfig) _then) =
      _$KeypadPageConfigCopyWithImpl;
  @useResult
  $Res call(
      {OverlayStyleModel? systemUiOverlayStyle,
      TextFieldConfig? textField,
      TextFieldConfig? contactName,
      KeypadStyleConfig? keypad,
      ActionPadWidgetConfig? actionpad});
}

/// @nodoc
class _$KeypadPageConfigCopyWithImpl<$Res>
    implements $KeypadPageConfigCopyWith<$Res> {
  _$KeypadPageConfigCopyWithImpl(this._self, this._then);

  final KeypadPageConfig _self;
  final $Res Function(KeypadPageConfig) _then;

  /// Create a copy of KeypadPageConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? systemUiOverlayStyle = freezed,
    Object? textField = freezed,
    Object? contactName = freezed,
    Object? keypad = freezed,
    Object? actionpad = freezed,
  }) {
    return _then(KeypadPageConfig(
      systemUiOverlayStyle: freezed == systemUiOverlayStyle
          ? _self.systemUiOverlayStyle
          : systemUiOverlayStyle // ignore: cast_nullable_to_non_nullable
              as OverlayStyleModel?,
      textField: freezed == textField
          ? _self.textField
          : textField // ignore: cast_nullable_to_non_nullable
              as TextFieldConfig?,
      contactName: freezed == contactName
          ? _self.contactName
          : contactName // ignore: cast_nullable_to_non_nullable
              as TextFieldConfig?,
      keypad: freezed == keypad
          ? _self.keypad
          : keypad // ignore: cast_nullable_to_non_nullable
              as KeypadStyleConfig?,
      actionpad: freezed == actionpad
          ? _self.actionpad
          : actionpad // ignore: cast_nullable_to_non_nullable
              as ActionPadWidgetConfig?,
    ));
  }
}

/// Adds pattern-matching-related methods to [KeypadPageConfig].
extension KeypadPageConfigPatterns on KeypadPageConfig {
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
  TResult maybeMap<TResult extends Object?>({
    required TResult orElse(),
  }) {
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

  @optionalTypeArgs
  TResult map<TResult extends Object?>() {
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

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>() {
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

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    required TResult orElse(),
  }) {
    final _that = this;
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

  @optionalTypeArgs
  TResult when<TResult extends Object?>() {
    final _that = this;
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

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>() {
    final _that = this;
    switch (_that) {
      case _:
        return null;
    }
  }
}

// dart format on
