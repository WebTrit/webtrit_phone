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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AppLogined {
  String get coreUrl => throw _privateConstructorUsedError;
  String get tenantId => throw _privateConstructorUsedError;
  String get token => throw _privateConstructorUsedError;
  bool get silent => throw _privateConstructorUsedError;
}

/// @nodoc

class _$AppLoginedImpl implements _AppLogined {
  const _$AppLoginedImpl(
      {required this.coreUrl,
      required this.tenantId,
      required this.token,
      this.silent = false});

  @override
  final String coreUrl;
  @override
  final String tenantId;
  @override
  final String token;
  @override
  @JsonKey()
  final bool silent;

  @override
  String toString() {
    return 'AppLogined(coreUrl: $coreUrl, tenantId: $tenantId, token: $token, silent: $silent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppLoginedImpl &&
            (identical(other.coreUrl, coreUrl) || other.coreUrl == coreUrl) &&
            (identical(other.tenantId, tenantId) ||
                other.tenantId == tenantId) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.silent, silent) || other.silent == silent));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, coreUrl, tenantId, token, silent);
}

abstract class _AppLogined implements AppLogined {
  const factory _AppLogined(
      {required final String coreUrl,
      required final String tenantId,
      required final String token,
      final bool silent}) = _$AppLoginedImpl;

  @override
  String get coreUrl;
  @override
  String get tenantId;
  @override
  String get token;
  @override
  bool get silent;
}

/// @nodoc
mixin _$AppLogouted {}

/// @nodoc

class _$AppLogoutedImpl implements _AppLogouted {
  const _$AppLogoutedImpl();

  @override
  String toString() {
    return 'AppLogouted()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AppLogoutedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

abstract class _AppLogouted implements AppLogouted {
  const factory _AppLogouted() = _$AppLogoutedImpl;
}

/// @nodoc
mixin _$AppThemeSettingsChanged {
  ThemeSettings get value => throw _privateConstructorUsedError;
}

/// @nodoc

class _$AppThemeSettingsChangedImpl implements _AppThemeSettingsChanged {
  const _$AppThemeSettingsChangedImpl(this.value);

  @override
  final ThemeSettings value;

  @override
  String toString() {
    return 'AppThemeSettingsChanged(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppThemeSettingsChangedImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);
}

abstract class _AppThemeSettingsChanged implements AppThemeSettingsChanged {
  const factory _AppThemeSettingsChanged(final ThemeSettings value) =
      _$AppThemeSettingsChangedImpl;

  @override
  ThemeSettings get value;
}

/// @nodoc
mixin _$AppThemeModeChanged {
  ThemeMode get value => throw _privateConstructorUsedError;
}

/// @nodoc

class _$AppThemeModeChangedImpl implements _AppThemeModeChanged {
  const _$AppThemeModeChangedImpl(this.value);

  @override
  final ThemeMode value;

  @override
  String toString() {
    return 'AppThemeModeChanged(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppThemeModeChangedImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);
}

abstract class _AppThemeModeChanged implements AppThemeModeChanged {
  const factory _AppThemeModeChanged(final ThemeMode value) =
      _$AppThemeModeChangedImpl;

  @override
  ThemeMode get value;
}

/// @nodoc
mixin _$AppLocaleChanged {
  Locale get value => throw _privateConstructorUsedError;
}

/// @nodoc

class _$AppLocaleChangedImpl implements _AppLocaleChanged {
  const _$AppLocaleChangedImpl(this.value);

  @override
  final Locale value;

  @override
  String toString() {
    return 'AppLocaleChanged(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppLocaleChangedImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);
}

abstract class _AppLocaleChanged implements AppLocaleChanged {
  const factory _AppLocaleChanged(final Locale value) = _$AppLocaleChangedImpl;

  @override
  Locale get value;
}

/// @nodoc
mixin _$AppUserAgreementAccepted {}

/// @nodoc

class _$AppUserAgreementAcceptedImpl implements _AppUserAgreementAccepted {
  const _$AppUserAgreementAcceptedImpl();

  @override
  String toString() {
    return 'AppUserAgreementAccepted()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppUserAgreementAcceptedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

abstract class _AppUserAgreementAccepted implements AppUserAgreementAccepted {
  const factory _AppUserAgreementAccepted() = _$AppUserAgreementAcceptedImpl;
}

/// @nodoc
mixin _$AppState {
  String? get coreUrl => throw _privateConstructorUsedError;
  String? get tenantId => throw _privateConstructorUsedError;
  String? get token => throw _privateConstructorUsedError;
  ThemeSettings get themeSettings => throw _privateConstructorUsedError;
  ThemeMode get themeMode => throw _privateConstructorUsedError;
  Locale get locale => throw _privateConstructorUsedError;
  bool get userAgreementAccepted => throw _privateConstructorUsedError;

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
      ThemeSettings themeSettings,
      ThemeMode themeMode,
      Locale locale,
      bool userAgreementAccepted});

  $ThemeSettingsCopyWith<$Res> get themeSettings;
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
    Object? themeSettings = null,
    Object? themeMode = null,
    Object? locale = null,
    Object? userAgreementAccepted = null,
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
      themeSettings: null == themeSettings
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
      userAgreementAccepted: null == userAgreementAccepted
          ? _value.userAgreementAccepted
          : userAgreementAccepted // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ThemeSettingsCopyWith<$Res> get themeSettings {
    return $ThemeSettingsCopyWith<$Res>(_value.themeSettings, (value) {
      return _then(_value.copyWith(themeSettings: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AppStateImplCopyWith<$Res>
    implements $AppStateCopyWith<$Res> {
  factory _$$AppStateImplCopyWith(
          _$AppStateImpl value, $Res Function(_$AppStateImpl) then) =
      __$$AppStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? coreUrl,
      String? tenantId,
      String? token,
      ThemeSettings themeSettings,
      ThemeMode themeMode,
      Locale locale,
      bool userAgreementAccepted});

  @override
  $ThemeSettingsCopyWith<$Res> get themeSettings;
}

/// @nodoc
class __$$AppStateImplCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res, _$AppStateImpl>
    implements _$$AppStateImplCopyWith<$Res> {
  __$$AppStateImplCopyWithImpl(
      _$AppStateImpl _value, $Res Function(_$AppStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? coreUrl = freezed,
    Object? tenantId = freezed,
    Object? token = freezed,
    Object? themeSettings = null,
    Object? themeMode = null,
    Object? locale = null,
    Object? userAgreementAccepted = null,
  }) {
    return _then(_$AppStateImpl(
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
      themeSettings: null == themeSettings
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
      userAgreementAccepted: null == userAgreementAccepted
          ? _value.userAgreementAccepted
          : userAgreementAccepted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$AppStateImpl extends _AppState {
  const _$AppStateImpl(
      {this.coreUrl,
      this.tenantId,
      this.token,
      required this.themeSettings,
      required this.themeMode,
      required this.locale,
      required this.userAgreementAccepted})
      : super._();

  @override
  final String? coreUrl;
  @override
  final String? tenantId;
  @override
  final String? token;
  @override
  final ThemeSettings themeSettings;
  @override
  final ThemeMode themeMode;
  @override
  final Locale locale;
  @override
  final bool userAgreementAccepted;

  @override
  String toString() {
    return 'AppState(coreUrl: $coreUrl, tenantId: $tenantId, token: $token, themeSettings: $themeSettings, themeMode: $themeMode, locale: $locale, userAgreementAccepted: $userAgreementAccepted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppStateImpl &&
            (identical(other.coreUrl, coreUrl) || other.coreUrl == coreUrl) &&
            (identical(other.tenantId, tenantId) ||
                other.tenantId == tenantId) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.themeSettings, themeSettings) ||
                other.themeSettings == themeSettings) &&
            (identical(other.themeMode, themeMode) ||
                other.themeMode == themeMode) &&
            (identical(other.locale, locale) || other.locale == locale) &&
            (identical(other.userAgreementAccepted, userAgreementAccepted) ||
                other.userAgreementAccepted == userAgreementAccepted));
  }

  @override
  int get hashCode => Object.hash(runtimeType, coreUrl, tenantId, token,
      themeSettings, themeMode, locale, userAgreementAccepted);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppStateImplCopyWith<_$AppStateImpl> get copyWith =>
      __$$AppStateImplCopyWithImpl<_$AppStateImpl>(this, _$identity);
}

abstract class _AppState extends AppState {
  const factory _AppState(
      {final String? coreUrl,
      final String? tenantId,
      final String? token,
      required final ThemeSettings themeSettings,
      required final ThemeMode themeMode,
      required final Locale locale,
      required final bool userAgreementAccepted}) = _$AppStateImpl;
  const _AppState._() : super._();

  @override
  String? get coreUrl;
  @override
  String? get tenantId;
  @override
  String? get token;
  @override
  ThemeSettings get themeSettings;
  @override
  ThemeMode get themeMode;
  @override
  Locale get locale;
  @override
  bool get userAgreementAccepted;
  @override
  @JsonKey(ignore: true)
  _$$AppStateImplCopyWith<_$AppStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
