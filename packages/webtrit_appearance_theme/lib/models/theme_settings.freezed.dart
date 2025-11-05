// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'theme_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ThemeSettings {
  ColorSchemeConfig get lightColorSchemeConfig;
  ColorSchemeConfig get darkColorSchemeConfig;
  ThemeWidgetConfig get themeWidgetLightConfig;
  ThemeWidgetConfig get themeWidgetDarkConfig;
  ThemePageConfig get themePageLightConfig;
  ThemePageConfig get themePageDarkConfig;

  /// Create a copy of ThemeSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ThemeSettingsCopyWith<ThemeSettings> get copyWith =>
      _$ThemeSettingsCopyWithImpl<ThemeSettings>(
          this as ThemeSettings, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ThemeSettings &&
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
                other.themePageDarkConfig == themePageDarkConfig));
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
      themePageDarkConfig);

  @override
  String toString() {
    return 'ThemeSettings(lightColorSchemeConfig: $lightColorSchemeConfig, darkColorSchemeConfig: $darkColorSchemeConfig, themeWidgetLightConfig: $themeWidgetLightConfig, themeWidgetDarkConfig: $themeWidgetDarkConfig, themePageLightConfig: $themePageLightConfig, themePageDarkConfig: $themePageDarkConfig)';
  }
}

/// @nodoc
abstract mixin class $ThemeSettingsCopyWith<$Res> {
  factory $ThemeSettingsCopyWith(
          ThemeSettings value, $Res Function(ThemeSettings) _then) =
      _$ThemeSettingsCopyWithImpl;
  @useResult
  $Res call(
      {ColorSchemeConfig lightColorSchemeConfig,
      ColorSchemeConfig darkColorSchemeConfig,
      ThemeWidgetConfig themeWidgetLightConfig,
      ThemeWidgetConfig themeWidgetDarkConfig,
      ThemePageConfig themePageLightConfig,
      ThemePageConfig themePageDarkConfig});
}

/// @nodoc
class _$ThemeSettingsCopyWithImpl<$Res>
    implements $ThemeSettingsCopyWith<$Res> {
  _$ThemeSettingsCopyWithImpl(this._self, this._then);

  final ThemeSettings _self;
  final $Res Function(ThemeSettings) _then;

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
  }) {
    return _then(ThemeSettings(
      lightColorSchemeConfig: null == lightColorSchemeConfig
          ? _self.lightColorSchemeConfig
          : lightColorSchemeConfig // ignore: cast_nullable_to_non_nullable
              as ColorSchemeConfig,
      darkColorSchemeConfig: null == darkColorSchemeConfig
          ? _self.darkColorSchemeConfig
          : darkColorSchemeConfig // ignore: cast_nullable_to_non_nullable
              as ColorSchemeConfig,
      themeWidgetLightConfig: null == themeWidgetLightConfig
          ? _self.themeWidgetLightConfig
          : themeWidgetLightConfig // ignore: cast_nullable_to_non_nullable
              as ThemeWidgetConfig,
      themeWidgetDarkConfig: null == themeWidgetDarkConfig
          ? _self.themeWidgetDarkConfig
          : themeWidgetDarkConfig // ignore: cast_nullable_to_non_nullable
              as ThemeWidgetConfig,
      themePageLightConfig: null == themePageLightConfig
          ? _self.themePageLightConfig
          : themePageLightConfig // ignore: cast_nullable_to_non_nullable
              as ThemePageConfig,
      themePageDarkConfig: null == themePageDarkConfig
          ? _self.themePageDarkConfig
          : themePageDarkConfig // ignore: cast_nullable_to_non_nullable
              as ThemePageConfig,
    ));
  }
}

/// Adds pattern-matching-related methods to [ThemeSettings].
extension ThemeSettingsPatterns on ThemeSettings {
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
