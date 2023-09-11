// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AppLogined {
  String get coreUrl => throw _privateConstructorUsedError;
  String get tenantId => throw _privateConstructorUsedError;
  String get token => throw _privateConstructorUsedError;
}

/// @nodoc

class _$_AppLogined implements _AppLogined {
  const _$_AppLogined(
      {required this.coreUrl, required this.tenantId, required this.token});

  @override
  final String coreUrl;
  @override
  final String tenantId;
  @override
  final String token;

  @override
  String toString() {
    return 'AppLogined(coreUrl: $coreUrl, tenantId: $tenantId, token: $token)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppLogined &&
            (identical(other.coreUrl, coreUrl) || other.coreUrl == coreUrl) &&
            (identical(other.tenantId, tenantId) ||
                other.tenantId == tenantId) &&
            (identical(other.token, token) || other.token == token));
  }

  @override
  int get hashCode => Object.hash(runtimeType, coreUrl, tenantId, token);
}

abstract class _AppLogined implements AppLogined {
  const factory _AppLogined(
      {required final String coreUrl,
      required final String tenantId,
      required final String token}) = _$_AppLogined;

  @override
  String get coreUrl;
  @override
  String get tenantId;
  @override
  String get token;
}

/// @nodoc
mixin _$AppLogouted {}

/// @nodoc

class _$_AppLogouted implements _AppLogouted {
  const _$_AppLogouted();

  @override
  String toString() {
    return 'AppLogouted()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_AppLogouted);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

abstract class _AppLogouted implements AppLogouted {
  const factory _AppLogouted() = _$_AppLogouted;
}

/// @nodoc
mixin _$AppThemeSettingsChanged {
  ThemeSettings get value => throw _privateConstructorUsedError;
}

/// @nodoc

class _$_AppThemeSettingsChanged implements _AppThemeSettingsChanged {
  const _$_AppThemeSettingsChanged(this.value);

  @override
  final ThemeSettings value;

  @override
  String toString() {
    return 'AppThemeSettingsChanged(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppThemeSettingsChanged &&
            const DeepCollectionEquality().equals(other.value, value));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(value));
}

abstract class _AppThemeSettingsChanged implements AppThemeSettingsChanged {
  const factory _AppThemeSettingsChanged(final ThemeSettings value) =
      _$_AppThemeSettingsChanged;

  @override
  ThemeSettings get value;
}

/// @nodoc
mixin _$AppThemeModeChanged {
  ThemeMode get value => throw _privateConstructorUsedError;
}

/// @nodoc

class _$_AppThemeModeChanged implements _AppThemeModeChanged {
  const _$_AppThemeModeChanged(this.value);

  @override
  final ThemeMode value;

  @override
  String toString() {
    return 'AppThemeModeChanged(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppThemeModeChanged &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);
}

abstract class _AppThemeModeChanged implements AppThemeModeChanged {
  const factory _AppThemeModeChanged(final ThemeMode value) =
      _$_AppThemeModeChanged;

  @override
  ThemeMode get value;
}

/// @nodoc
mixin _$AppLocaleChanged {
  Locale get value => throw _privateConstructorUsedError;
}

/// @nodoc

class _$_AppLocaleChanged implements _AppLocaleChanged {
  const _$_AppLocaleChanged(this.value);

  @override
  final Locale value;

  @override
  String toString() {
    return 'AppLocaleChanged(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppLocaleChanged &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);
}

abstract class _AppLocaleChanged implements AppLocaleChanged {
  const factory _AppLocaleChanged(final Locale value) = _$_AppLocaleChanged;

  @override
  Locale get value;
}

/// @nodoc
mixin _$AppState {
  String? get coreUrl => throw _privateConstructorUsedError;
  String? get tenantId => throw _privateConstructorUsedError;
  String? get token => throw _privateConstructorUsedError;
  String? get webRegistrationInitialUrl => throw _privateConstructorUsedError;
  ThemeSettings get themeSettings => throw _privateConstructorUsedError;
  ThemeMode get themeMode => throw _privateConstructorUsedError;
  Locale get locale => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppStateCopyWith<AppState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppStateCopyWith<$Res> {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) then) =
      _$AppStateCopyWithImpl<$Res, AppState>;
  @useResult
  $Res call(
      {String? coreUrl,
      String? tenantId,
      String? token,
      String? webRegistrationInitialUrl,
      ThemeSettings themeSettings,
      ThemeMode themeMode,
      Locale locale});
}

/// @nodoc
class _$AppStateCopyWithImpl<$Res, $Val extends AppState>
    implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? coreUrl = freezed,
    Object? tenantId = freezed,
    Object? token = freezed,
    Object? webRegistrationInitialUrl = freezed,
    Object? themeSettings = freezed,
    Object? themeMode = null,
    Object? locale = null,
  }) {
    return _then(_value.copyWith(
      coreUrl: freezed == coreUrl
          ? _value.coreUrl
          : coreUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      tenantId: freezed == tenantId
          ? _value.tenantId
          : tenantId // ignore: cast_nullable_to_non_nullable
              as String?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      webRegistrationInitialUrl: freezed == webRegistrationInitialUrl
          ? _value.webRegistrationInitialUrl
          : webRegistrationInitialUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      themeSettings: freezed == themeSettings
          ? _value.themeSettings
          : themeSettings // ignore: cast_nullable_to_non_nullable
              as ThemeSettings,
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
      locale: null == locale
          ? _value.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as Locale,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AppStateCopyWith<$Res> implements $AppStateCopyWith<$Res> {
  factory _$$_AppStateCopyWith(
          _$_AppState value, $Res Function(_$_AppState) then) =
      __$$_AppStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? coreUrl,
      String? tenantId,
      String? token,
      String? webRegistrationInitialUrl,
      ThemeSettings themeSettings,
      ThemeMode themeMode,
      Locale locale});
}

/// @nodoc
class __$$_AppStateCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res, _$_AppState>
    implements _$$_AppStateCopyWith<$Res> {
  __$$_AppStateCopyWithImpl(
      _$_AppState _value, $Res Function(_$_AppState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? coreUrl = freezed,
    Object? tenantId = freezed,
    Object? token = freezed,
    Object? webRegistrationInitialUrl = freezed,
    Object? themeSettings = freezed,
    Object? themeMode = null,
    Object? locale = null,
  }) {
    return _then(_$_AppState(
      coreUrl: freezed == coreUrl
          ? _value.coreUrl
          : coreUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      tenantId: freezed == tenantId
          ? _value.tenantId
          : tenantId // ignore: cast_nullable_to_non_nullable
              as String?,
      token: freezed == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      webRegistrationInitialUrl: freezed == webRegistrationInitialUrl
          ? _value.webRegistrationInitialUrl
          : webRegistrationInitialUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      themeSettings: freezed == themeSettings
          ? _value.themeSettings
          : themeSettings // ignore: cast_nullable_to_non_nullable
              as ThemeSettings,
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
      locale: null == locale
          ? _value.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as Locale,
    ));
  }
}

/// @nodoc

class _$_AppState extends _AppState {
  const _$_AppState(
      {this.coreUrl,
      this.tenantId,
      this.token,
      this.webRegistrationInitialUrl,
      required this.themeSettings,
      required this.themeMode,
      required this.locale})
      : super._();

  @override
  final String? coreUrl;
  @override
  final String? tenantId;
  @override
  final String? token;
  @override
  final String? webRegistrationInitialUrl;
  @override
  final ThemeSettings themeSettings;
  @override
  final ThemeMode themeMode;
  @override
  final Locale locale;

  @override
  String toString() {
    return 'AppState(coreUrl: $coreUrl, tenantId: $tenantId, token: $token, webRegistrationInitialUrl: $webRegistrationInitialUrl, themeSettings: $themeSettings, themeMode: $themeMode, locale: $locale)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppState &&
            (identical(other.coreUrl, coreUrl) || other.coreUrl == coreUrl) &&
            (identical(other.tenantId, tenantId) ||
                other.tenantId == tenantId) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.webRegistrationInitialUrl,
                    webRegistrationInitialUrl) ||
                other.webRegistrationInitialUrl == webRegistrationInitialUrl) &&
            const DeepCollectionEquality()
                .equals(other.themeSettings, themeSettings) &&
            (identical(other.themeMode, themeMode) ||
                other.themeMode == themeMode) &&
            (identical(other.locale, locale) || other.locale == locale));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      coreUrl,
      tenantId,
      token,
      webRegistrationInitialUrl,
      const DeepCollectionEquality().hash(themeSettings),
      themeMode,
      locale);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AppStateCopyWith<_$_AppState> get copyWith =>
      __$$_AppStateCopyWithImpl<_$_AppState>(this, _$identity);
}

abstract class _AppState extends AppState {
  const factory _AppState(
      {final String? coreUrl,
      final String? tenantId,
      final String? token,
      final String? webRegistrationInitialUrl,
      required final ThemeSettings themeSettings,
      required final ThemeMode themeMode,
      required final Locale locale}) = _$_AppState;
  const _AppState._() : super._();

  @override
  String? get coreUrl;
  @override
  String? get tenantId;
  @override
  String? get token;
  @override
  String? get webRegistrationInitialUrl;
  @override
  ThemeSettings get themeSettings;
  @override
  ThemeMode get themeMode;
  @override
  Locale get locale;
  @override
  @JsonKey(ignore: true)
  _$$_AppStateCopyWith<_$_AppState> get copyWith =>
      throw _privateConstructorUsedError;
}
