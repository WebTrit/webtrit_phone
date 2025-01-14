// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'theme_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ThemeSettings _$ThemeSettingsFromJson(Map<String, dynamic> json) {
  return _ThemeSettings.fromJson(json);
}

/// @nodoc
mixin _$ThemeSettings {
// Colors scheme
  ColorSchemeConfig get lightColorSchemeConfig =>
      throw _privateConstructorUsedError;
  ColorSchemeConfig get darkColorSchemeConfig =>
      throw _privateConstructorUsedError; // Widgets config
  ThemeWidgetConfig get themeWidgetLightConfig =>
      throw _privateConstructorUsedError;
  ThemeWidgetConfig get themeWidgetDarkConfig =>
      throw _privateConstructorUsedError; // Pages config
  ThemePageConfig get themePageLightConfig =>
      throw _privateConstructorUsedError;
  ThemePageConfig get themePageDarkConfig =>
      throw _privateConstructorUsedError; // Feature access
  AppConfig? get appConfig => throw _privateConstructorUsedError;

  /// Serializes this ThemeSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ThemeSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ThemeSettingsCopyWith<ThemeSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThemeSettingsCopyWith<$Res> {
  factory $ThemeSettingsCopyWith(
          ThemeSettings value, $Res Function(ThemeSettings) then) =
      _$ThemeSettingsCopyWithImpl<$Res, ThemeSettings>;
  @useResult
  $Res call(
      {ColorSchemeConfig lightColorSchemeConfig,
      ColorSchemeConfig darkColorSchemeConfig,
      ThemeWidgetConfig themeWidgetLightConfig,
      ThemeWidgetConfig themeWidgetDarkConfig,
      ThemePageConfig themePageLightConfig,
      ThemePageConfig themePageDarkConfig,
      AppConfig? appConfig});

  $ColorSchemeConfigCopyWith<$Res> get lightColorSchemeConfig;
  $ColorSchemeConfigCopyWith<$Res> get darkColorSchemeConfig;
  $ThemeWidgetConfigCopyWith<$Res> get themeWidgetLightConfig;
  $ThemeWidgetConfigCopyWith<$Res> get themeWidgetDarkConfig;
  $ThemePageConfigCopyWith<$Res> get themePageLightConfig;
  $ThemePageConfigCopyWith<$Res> get themePageDarkConfig;
  $AppConfigCopyWith<$Res>? get appConfig;
}

/// @nodoc
class _$ThemeSettingsCopyWithImpl<$Res, $Val extends ThemeSettings>
    implements $ThemeSettingsCopyWith<$Res> {
  _$ThemeSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ThemeSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lightColorSchemeConfig = null,
    Object? darkColorSchemeConfig = null,
    Object? themeWidgetLightConfig = null,
    Object? themeWidgetDarkConfig = null,
    Object? themePageLightConfig = null,
    Object? themePageDarkConfig = null,
    Object? appConfig = freezed,
  }) {
    return _then(_value.copyWith(
      lightColorSchemeConfig: null == lightColorSchemeConfig
          ? _value.lightColorSchemeConfig
          : lightColorSchemeConfig // ignore: cast_nullable_to_non_nullable
              as ColorSchemeConfig,
      darkColorSchemeConfig: null == darkColorSchemeConfig
          ? _value.darkColorSchemeConfig
          : darkColorSchemeConfig // ignore: cast_nullable_to_non_nullable
              as ColorSchemeConfig,
      themeWidgetLightConfig: null == themeWidgetLightConfig
          ? _value.themeWidgetLightConfig
          : themeWidgetLightConfig // ignore: cast_nullable_to_non_nullable
              as ThemeWidgetConfig,
      themeWidgetDarkConfig: null == themeWidgetDarkConfig
          ? _value.themeWidgetDarkConfig
          : themeWidgetDarkConfig // ignore: cast_nullable_to_non_nullable
              as ThemeWidgetConfig,
      themePageLightConfig: null == themePageLightConfig
          ? _value.themePageLightConfig
          : themePageLightConfig // ignore: cast_nullable_to_non_nullable
              as ThemePageConfig,
      themePageDarkConfig: null == themePageDarkConfig
          ? _value.themePageDarkConfig
          : themePageDarkConfig // ignore: cast_nullable_to_non_nullable
              as ThemePageConfig,
      appConfig: freezed == appConfig
          ? _value.appConfig
          : appConfig // ignore: cast_nullable_to_non_nullable
              as AppConfig?,
    ) as $Val);
  }

  /// Create a copy of ThemeSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ColorSchemeConfigCopyWith<$Res> get lightColorSchemeConfig {
    return $ColorSchemeConfigCopyWith<$Res>(_value.lightColorSchemeConfig,
        (value) {
      return _then(_value.copyWith(lightColorSchemeConfig: value) as $Val);
    });
  }

  /// Create a copy of ThemeSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ColorSchemeConfigCopyWith<$Res> get darkColorSchemeConfig {
    return $ColorSchemeConfigCopyWith<$Res>(_value.darkColorSchemeConfig,
        (value) {
      return _then(_value.copyWith(darkColorSchemeConfig: value) as $Val);
    });
  }

  /// Create a copy of ThemeSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ThemeWidgetConfigCopyWith<$Res> get themeWidgetLightConfig {
    return $ThemeWidgetConfigCopyWith<$Res>(_value.themeWidgetLightConfig,
        (value) {
      return _then(_value.copyWith(themeWidgetLightConfig: value) as $Val);
    });
  }

  /// Create a copy of ThemeSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ThemeWidgetConfigCopyWith<$Res> get themeWidgetDarkConfig {
    return $ThemeWidgetConfigCopyWith<$Res>(_value.themeWidgetDarkConfig,
        (value) {
      return _then(_value.copyWith(themeWidgetDarkConfig: value) as $Val);
    });
  }

  /// Create a copy of ThemeSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ThemePageConfigCopyWith<$Res> get themePageLightConfig {
    return $ThemePageConfigCopyWith<$Res>(_value.themePageLightConfig, (value) {
      return _then(_value.copyWith(themePageLightConfig: value) as $Val);
    });
  }

  /// Create a copy of ThemeSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ThemePageConfigCopyWith<$Res> get themePageDarkConfig {
    return $ThemePageConfigCopyWith<$Res>(_value.themePageDarkConfig, (value) {
      return _then(_value.copyWith(themePageDarkConfig: value) as $Val);
    });
  }

  /// Create a copy of ThemeSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AppConfigCopyWith<$Res>? get appConfig {
    if (_value.appConfig == null) {
      return null;
    }

    return $AppConfigCopyWith<$Res>(_value.appConfig!, (value) {
      return _then(_value.copyWith(appConfig: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ThemeSettingsImplCopyWith<$Res>
    implements $ThemeSettingsCopyWith<$Res> {
  factory _$$ThemeSettingsImplCopyWith(
          _$ThemeSettingsImpl value, $Res Function(_$ThemeSettingsImpl) then) =
      __$$ThemeSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ColorSchemeConfig lightColorSchemeConfig,
      ColorSchemeConfig darkColorSchemeConfig,
      ThemeWidgetConfig themeWidgetLightConfig,
      ThemeWidgetConfig themeWidgetDarkConfig,
      ThemePageConfig themePageLightConfig,
      ThemePageConfig themePageDarkConfig,
      AppConfig? appConfig});

  @override
  $ColorSchemeConfigCopyWith<$Res> get lightColorSchemeConfig;
  @override
  $ColorSchemeConfigCopyWith<$Res> get darkColorSchemeConfig;
  @override
  $ThemeWidgetConfigCopyWith<$Res> get themeWidgetLightConfig;
  @override
  $ThemeWidgetConfigCopyWith<$Res> get themeWidgetDarkConfig;
  @override
  $ThemePageConfigCopyWith<$Res> get themePageLightConfig;
  @override
  $ThemePageConfigCopyWith<$Res> get themePageDarkConfig;
  @override
  $AppConfigCopyWith<$Res>? get appConfig;
}

/// @nodoc
class __$$ThemeSettingsImplCopyWithImpl<$Res>
    extends _$ThemeSettingsCopyWithImpl<$Res, _$ThemeSettingsImpl>
    implements _$$ThemeSettingsImplCopyWith<$Res> {
  __$$ThemeSettingsImplCopyWithImpl(
      _$ThemeSettingsImpl _value, $Res Function(_$ThemeSettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of ThemeSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lightColorSchemeConfig = null,
    Object? darkColorSchemeConfig = null,
    Object? themeWidgetLightConfig = null,
    Object? themeWidgetDarkConfig = null,
    Object? themePageLightConfig = null,
    Object? themePageDarkConfig = null,
    Object? appConfig = freezed,
  }) {
    return _then(_$ThemeSettingsImpl(
      lightColorSchemeConfig: null == lightColorSchemeConfig
          ? _value.lightColorSchemeConfig
          : lightColorSchemeConfig // ignore: cast_nullable_to_non_nullable
              as ColorSchemeConfig,
      darkColorSchemeConfig: null == darkColorSchemeConfig
          ? _value.darkColorSchemeConfig
          : darkColorSchemeConfig // ignore: cast_nullable_to_non_nullable
              as ColorSchemeConfig,
      themeWidgetLightConfig: null == themeWidgetLightConfig
          ? _value.themeWidgetLightConfig
          : themeWidgetLightConfig // ignore: cast_nullable_to_non_nullable
              as ThemeWidgetConfig,
      themeWidgetDarkConfig: null == themeWidgetDarkConfig
          ? _value.themeWidgetDarkConfig
          : themeWidgetDarkConfig // ignore: cast_nullable_to_non_nullable
              as ThemeWidgetConfig,
      themePageLightConfig: null == themePageLightConfig
          ? _value.themePageLightConfig
          : themePageLightConfig // ignore: cast_nullable_to_non_nullable
              as ThemePageConfig,
      themePageDarkConfig: null == themePageDarkConfig
          ? _value.themePageDarkConfig
          : themePageDarkConfig // ignore: cast_nullable_to_non_nullable
              as ThemePageConfig,
      appConfig: freezed == appConfig
          ? _value.appConfig
          : appConfig // ignore: cast_nullable_to_non_nullable
              as AppConfig?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ThemeSettingsImpl implements _ThemeSettings {
  const _$ThemeSettingsImpl(
      {this.lightColorSchemeConfig = const ColorSchemeConfig(),
      this.darkColorSchemeConfig = const ColorSchemeConfig(),
      this.themeWidgetLightConfig = const ThemeWidgetConfig(),
      this.themeWidgetDarkConfig = const ThemeWidgetConfig(),
      this.themePageLightConfig = const ThemePageConfig(),
      this.themePageDarkConfig = const ThemePageConfig(),
      this.appConfig});

  factory _$ThemeSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ThemeSettingsImplFromJson(json);

// Colors scheme
  @override
  @JsonKey()
  final ColorSchemeConfig lightColorSchemeConfig;
  @override
  @JsonKey()
  final ColorSchemeConfig darkColorSchemeConfig;
// Widgets config
  @override
  @JsonKey()
  final ThemeWidgetConfig themeWidgetLightConfig;
  @override
  @JsonKey()
  final ThemeWidgetConfig themeWidgetDarkConfig;
// Pages config
  @override
  @JsonKey()
  final ThemePageConfig themePageLightConfig;
  @override
  @JsonKey()
  final ThemePageConfig themePageDarkConfig;
// Feature access
  @override
  final AppConfig? appConfig;

  @override
  String toString() {
    return 'ThemeSettings(lightColorSchemeConfig: $lightColorSchemeConfig, darkColorSchemeConfig: $darkColorSchemeConfig, themeWidgetLightConfig: $themeWidgetLightConfig, themeWidgetDarkConfig: $themeWidgetDarkConfig, themePageLightConfig: $themePageLightConfig, themePageDarkConfig: $themePageDarkConfig, appConfig: $appConfig)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ThemeSettingsImpl &&
            (identical(other.lightColorSchemeConfig, lightColorSchemeConfig) ||
                other.lightColorSchemeConfig == lightColorSchemeConfig) &&
            (identical(other.darkColorSchemeConfig, darkColorSchemeConfig) ||
                other.darkColorSchemeConfig == darkColorSchemeConfig) &&
            (identical(other.themeWidgetLightConfig, themeWidgetLightConfig) ||
                other.themeWidgetLightConfig == themeWidgetLightConfig) &&
            (identical(other.themeWidgetDarkConfig, themeWidgetDarkConfig) ||
                other.themeWidgetDarkConfig == themeWidgetDarkConfig) &&
            (identical(other.themePageLightConfig, themePageLightConfig) ||
                other.themePageLightConfig == themePageLightConfig) &&
            (identical(other.themePageDarkConfig, themePageDarkConfig) ||
                other.themePageDarkConfig == themePageDarkConfig) &&
            (identical(other.appConfig, appConfig) ||
                other.appConfig == appConfig));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      lightColorSchemeConfig,
      darkColorSchemeConfig,
      themeWidgetLightConfig,
      themeWidgetDarkConfig,
      themePageLightConfig,
      themePageDarkConfig,
      appConfig);

  /// Create a copy of ThemeSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ThemeSettingsImplCopyWith<_$ThemeSettingsImpl> get copyWith =>
      __$$ThemeSettingsImplCopyWithImpl<_$ThemeSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ThemeSettingsImplToJson(
      this,
    );
  }
}

abstract class _ThemeSettings implements ThemeSettings {
  const factory _ThemeSettings(
      {final ColorSchemeConfig lightColorSchemeConfig,
      final ColorSchemeConfig darkColorSchemeConfig,
      final ThemeWidgetConfig themeWidgetLightConfig,
      final ThemeWidgetConfig themeWidgetDarkConfig,
      final ThemePageConfig themePageLightConfig,
      final ThemePageConfig themePageDarkConfig,
      final AppConfig? appConfig}) = _$ThemeSettingsImpl;

  factory _ThemeSettings.fromJson(Map<String, dynamic> json) =
      _$ThemeSettingsImpl.fromJson;

// Colors scheme
  @override
  ColorSchemeConfig get lightColorSchemeConfig;
  @override
  ColorSchemeConfig get darkColorSchemeConfig; // Widgets config
  @override
  ThemeWidgetConfig get themeWidgetLightConfig;
  @override
  ThemeWidgetConfig get themeWidgetDarkConfig; // Pages config
  @override
  ThemePageConfig get themePageLightConfig;
  @override
  ThemePageConfig get themePageDarkConfig; // Feature access
  @override
  AppConfig? get appConfig;

  /// Create a copy of ThemeSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ThemeSettingsImplCopyWith<_$ThemeSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
