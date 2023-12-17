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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ThemeSettings _$ThemeSettingsFromJson(Map<String, dynamic> json) {
  return _ThemeSettings.fromJson(json);
}

/// @nodoc
mixin _$ThemeSettings {
  Color get seedColor => throw _privateConstructorUsedError;
  ColorSchemeOverride? get lightColorSchemeOverride =>
      throw _privateConstructorUsedError;
  ColorSchemeOverride? get darkColorSchemeOverride =>
      throw _privateConstructorUsedError;
  List<CustomColor> get primaryGradientColors =>
      throw _privateConstructorUsedError;
  String? get fontFamily => throw _privateConstructorUsedError;
  ThemeSvgAsset get primaryOnboardingLogo => throw _privateConstructorUsedError;
  ThemeSvgAsset get secondaryOnboardingLogo =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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
      {Color seedColor,
      ColorSchemeOverride? lightColorSchemeOverride,
      ColorSchemeOverride? darkColorSchemeOverride,
      List<CustomColor> primaryGradientColors,
      String? fontFamily,
      ThemeSvgAsset primaryOnboardingLogo,
      ThemeSvgAsset secondaryOnboardingLogo});

  $ColorSchemeOverrideCopyWith<$Res>? get lightColorSchemeOverride;
  $ColorSchemeOverrideCopyWith<$Res>? get darkColorSchemeOverride;
}

/// @nodoc
class _$ThemeSettingsCopyWithImpl<$Res, $Val extends ThemeSettings>
    implements $ThemeSettingsCopyWith<$Res> {
  _$ThemeSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? seedColor = null,
    Object? lightColorSchemeOverride = freezed,
    Object? darkColorSchemeOverride = freezed,
    Object? primaryGradientColors = null,
    Object? fontFamily = freezed,
    Object? primaryOnboardingLogo = null,
    Object? secondaryOnboardingLogo = null,
  }) {
    return _then(_value.copyWith(
      seedColor: null == seedColor
          ? _value.seedColor
          : seedColor // ignore: cast_nullable_to_non_nullable
              as Color,
      lightColorSchemeOverride: freezed == lightColorSchemeOverride
          ? _value.lightColorSchemeOverride
          : lightColorSchemeOverride // ignore: cast_nullable_to_non_nullable
              as ColorSchemeOverride?,
      darkColorSchemeOverride: freezed == darkColorSchemeOverride
          ? _value.darkColorSchemeOverride
          : darkColorSchemeOverride // ignore: cast_nullable_to_non_nullable
              as ColorSchemeOverride?,
      primaryGradientColors: null == primaryGradientColors
          ? _value.primaryGradientColors
          : primaryGradientColors // ignore: cast_nullable_to_non_nullable
              as List<CustomColor>,
      fontFamily: freezed == fontFamily
          ? _value.fontFamily
          : fontFamily // ignore: cast_nullable_to_non_nullable
              as String?,
      primaryOnboardingLogo: null == primaryOnboardingLogo
          ? _value.primaryOnboardingLogo
          : primaryOnboardingLogo // ignore: cast_nullable_to_non_nullable
              as ThemeSvgAsset,
      secondaryOnboardingLogo: null == secondaryOnboardingLogo
          ? _value.secondaryOnboardingLogo
          : secondaryOnboardingLogo // ignore: cast_nullable_to_non_nullable
              as ThemeSvgAsset,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ColorSchemeOverrideCopyWith<$Res>? get lightColorSchemeOverride {
    if (_value.lightColorSchemeOverride == null) {
      return null;
    }

    return $ColorSchemeOverrideCopyWith<$Res>(_value.lightColorSchemeOverride!,
        (value) {
      return _then(_value.copyWith(lightColorSchemeOverride: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ColorSchemeOverrideCopyWith<$Res>? get darkColorSchemeOverride {
    if (_value.darkColorSchemeOverride == null) {
      return null;
    }

    return $ColorSchemeOverrideCopyWith<$Res>(_value.darkColorSchemeOverride!,
        (value) {
      return _then(_value.copyWith(darkColorSchemeOverride: value) as $Val);
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
      {Color seedColor,
      ColorSchemeOverride? lightColorSchemeOverride,
      ColorSchemeOverride? darkColorSchemeOverride,
      List<CustomColor> primaryGradientColors,
      String? fontFamily,
      ThemeSvgAsset primaryOnboardingLogo,
      ThemeSvgAsset secondaryOnboardingLogo});

  @override
  $ColorSchemeOverrideCopyWith<$Res>? get lightColorSchemeOverride;
  @override
  $ColorSchemeOverrideCopyWith<$Res>? get darkColorSchemeOverride;
}

/// @nodoc
class __$$ThemeSettingsImplCopyWithImpl<$Res>
    extends _$ThemeSettingsCopyWithImpl<$Res, _$ThemeSettingsImpl>
    implements _$$ThemeSettingsImplCopyWith<$Res> {
  __$$ThemeSettingsImplCopyWithImpl(
      _$ThemeSettingsImpl _value, $Res Function(_$ThemeSettingsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? seedColor = null,
    Object? lightColorSchemeOverride = freezed,
    Object? darkColorSchemeOverride = freezed,
    Object? primaryGradientColors = null,
    Object? fontFamily = freezed,
    Object? primaryOnboardingLogo = null,
    Object? secondaryOnboardingLogo = null,
  }) {
    return _then(_$ThemeSettingsImpl(
      seedColor: null == seedColor
          ? _value.seedColor
          : seedColor // ignore: cast_nullable_to_non_nullable
              as Color,
      lightColorSchemeOverride: freezed == lightColorSchemeOverride
          ? _value.lightColorSchemeOverride
          : lightColorSchemeOverride // ignore: cast_nullable_to_non_nullable
              as ColorSchemeOverride?,
      darkColorSchemeOverride: freezed == darkColorSchemeOverride
          ? _value.darkColorSchemeOverride
          : darkColorSchemeOverride // ignore: cast_nullable_to_non_nullable
              as ColorSchemeOverride?,
      primaryGradientColors: null == primaryGradientColors
          ? _value._primaryGradientColors
          : primaryGradientColors // ignore: cast_nullable_to_non_nullable
              as List<CustomColor>,
      fontFamily: freezed == fontFamily
          ? _value.fontFamily
          : fontFamily // ignore: cast_nullable_to_non_nullable
              as String?,
      primaryOnboardingLogo: null == primaryOnboardingLogo
          ? _value.primaryOnboardingLogo
          : primaryOnboardingLogo // ignore: cast_nullable_to_non_nullable
              as ThemeSvgAsset,
      secondaryOnboardingLogo: null == secondaryOnboardingLogo
          ? _value.secondaryOnboardingLogo
          : secondaryOnboardingLogo // ignore: cast_nullable_to_non_nullable
              as ThemeSvgAsset,
    ));
  }
}

/// @nodoc

@themeJsonSerializable
class _$ThemeSettingsImpl implements _ThemeSettings {
  const _$ThemeSettingsImpl(
      {required this.seedColor,
      this.lightColorSchemeOverride,
      this.darkColorSchemeOverride,
      required final List<CustomColor> primaryGradientColors,
      this.fontFamily,
      required this.primaryOnboardingLogo,
      required this.secondaryOnboardingLogo})
      : _primaryGradientColors = primaryGradientColors;

  factory _$ThemeSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ThemeSettingsImplFromJson(json);

  @override
  final Color seedColor;
  @override
  final ColorSchemeOverride? lightColorSchemeOverride;
  @override
  final ColorSchemeOverride? darkColorSchemeOverride;
  final List<CustomColor> _primaryGradientColors;
  @override
  List<CustomColor> get primaryGradientColors {
    if (_primaryGradientColors is EqualUnmodifiableListView)
      return _primaryGradientColors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_primaryGradientColors);
  }

  @override
  final String? fontFamily;
  @override
  final ThemeSvgAsset primaryOnboardingLogo;
  @override
  final ThemeSvgAsset secondaryOnboardingLogo;

  @override
  String toString() {
    return 'ThemeSettings(seedColor: $seedColor, lightColorSchemeOverride: $lightColorSchemeOverride, darkColorSchemeOverride: $darkColorSchemeOverride, primaryGradientColors: $primaryGradientColors, fontFamily: $fontFamily, primaryOnboardingLogo: $primaryOnboardingLogo, secondaryOnboardingLogo: $secondaryOnboardingLogo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ThemeSettingsImpl &&
            (identical(other.seedColor, seedColor) ||
                other.seedColor == seedColor) &&
            (identical(
                    other.lightColorSchemeOverride, lightColorSchemeOverride) ||
                other.lightColorSchemeOverride == lightColorSchemeOverride) &&
            (identical(
                    other.darkColorSchemeOverride, darkColorSchemeOverride) ||
                other.darkColorSchemeOverride == darkColorSchemeOverride) &&
            const DeepCollectionEquality()
                .equals(other._primaryGradientColors, _primaryGradientColors) &&
            (identical(other.fontFamily, fontFamily) ||
                other.fontFamily == fontFamily) &&
            (identical(other.primaryOnboardingLogo, primaryOnboardingLogo) ||
                other.primaryOnboardingLogo == primaryOnboardingLogo) &&
            (identical(
                    other.secondaryOnboardingLogo, secondaryOnboardingLogo) ||
                other.secondaryOnboardingLogo == secondaryOnboardingLogo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      seedColor,
      lightColorSchemeOverride,
      darkColorSchemeOverride,
      const DeepCollectionEquality().hash(_primaryGradientColors),
      fontFamily,
      primaryOnboardingLogo,
      secondaryOnboardingLogo);

  @JsonKey(ignore: true)
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
          {required final Color seedColor,
          final ColorSchemeOverride? lightColorSchemeOverride,
          final ColorSchemeOverride? darkColorSchemeOverride,
          required final List<CustomColor> primaryGradientColors,
          final String? fontFamily,
          required final ThemeSvgAsset primaryOnboardingLogo,
          required final ThemeSvgAsset secondaryOnboardingLogo}) =
      _$ThemeSettingsImpl;

  factory _ThemeSettings.fromJson(Map<String, dynamic> json) =
      _$ThemeSettingsImpl.fromJson;

  @override
  Color get seedColor;
  @override
  ColorSchemeOverride? get lightColorSchemeOverride;
  @override
  ColorSchemeOverride? get darkColorSchemeOverride;
  @override
  List<CustomColor> get primaryGradientColors;
  @override
  String? get fontFamily;
  @override
  ThemeSvgAsset get primaryOnboardingLogo;
  @override
  ThemeSvgAsset get secondaryOnboardingLogo;
  @override
  @JsonKey(ignore: true)
  _$$ThemeSettingsImplCopyWith<_$ThemeSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ColorSchemeOverride _$ColorSchemeOverrideFromJson(Map<String, dynamic> json) {
  return _ColorSchemeOverride.fromJson(json);
}

/// @nodoc
mixin _$ColorSchemeOverride {
  Color? get primary => throw _privateConstructorUsedError;
  Color? get onPrimary => throw _privateConstructorUsedError;
  Color? get primaryContainer => throw _privateConstructorUsedError;
  Color? get onPrimaryContainer => throw _privateConstructorUsedError;
  Color? get secondary => throw _privateConstructorUsedError;
  Color? get onSecondary => throw _privateConstructorUsedError;
  Color? get secondaryContainer => throw _privateConstructorUsedError;
  Color? get onSecondaryContainer => throw _privateConstructorUsedError;
  Color? get tertiary => throw _privateConstructorUsedError;
  Color? get onTertiary => throw _privateConstructorUsedError;
  Color? get tertiaryContainer => throw _privateConstructorUsedError;
  Color? get onTertiaryContainer => throw _privateConstructorUsedError;
  Color? get error => throw _privateConstructorUsedError;
  Color? get onError => throw _privateConstructorUsedError;
  Color? get errorContainer => throw _privateConstructorUsedError;
  Color? get onErrorContainer => throw _privateConstructorUsedError;
  Color? get outline => throw _privateConstructorUsedError;
  Color? get outlineVariant => throw _privateConstructorUsedError;
  Color? get background => throw _privateConstructorUsedError;
  Color? get onBackground => throw _privateConstructorUsedError;
  Color? get surface => throw _privateConstructorUsedError;
  Color? get onSurface => throw _privateConstructorUsedError;
  Color? get surfaceVariant => throw _privateConstructorUsedError;
  Color? get onSurfaceVariant => throw _privateConstructorUsedError;
  Color? get inverseSurface => throw _privateConstructorUsedError;
  Color? get onInverseSurface => throw _privateConstructorUsedError;
  Color? get inversePrimary => throw _privateConstructorUsedError;
  Color? get shadow => throw _privateConstructorUsedError;
  Color? get scrim => throw _privateConstructorUsedError;
  Color? get surfaceTint => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ColorSchemeOverrideCopyWith<ColorSchemeOverride> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ColorSchemeOverrideCopyWith<$Res> {
  factory $ColorSchemeOverrideCopyWith(
          ColorSchemeOverride value, $Res Function(ColorSchemeOverride) then) =
      _$ColorSchemeOverrideCopyWithImpl<$Res, ColorSchemeOverride>;
  @useResult
  $Res call(
      {Color? primary,
      Color? onPrimary,
      Color? primaryContainer,
      Color? onPrimaryContainer,
      Color? secondary,
      Color? onSecondary,
      Color? secondaryContainer,
      Color? onSecondaryContainer,
      Color? tertiary,
      Color? onTertiary,
      Color? tertiaryContainer,
      Color? onTertiaryContainer,
      Color? error,
      Color? onError,
      Color? errorContainer,
      Color? onErrorContainer,
      Color? outline,
      Color? outlineVariant,
      Color? background,
      Color? onBackground,
      Color? surface,
      Color? onSurface,
      Color? surfaceVariant,
      Color? onSurfaceVariant,
      Color? inverseSurface,
      Color? onInverseSurface,
      Color? inversePrimary,
      Color? shadow,
      Color? scrim,
      Color? surfaceTint});
}

/// @nodoc
class _$ColorSchemeOverrideCopyWithImpl<$Res, $Val extends ColorSchemeOverride>
    implements $ColorSchemeOverrideCopyWith<$Res> {
  _$ColorSchemeOverrideCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? primary = freezed,
    Object? onPrimary = freezed,
    Object? primaryContainer = freezed,
    Object? onPrimaryContainer = freezed,
    Object? secondary = freezed,
    Object? onSecondary = freezed,
    Object? secondaryContainer = freezed,
    Object? onSecondaryContainer = freezed,
    Object? tertiary = freezed,
    Object? onTertiary = freezed,
    Object? tertiaryContainer = freezed,
    Object? onTertiaryContainer = freezed,
    Object? error = freezed,
    Object? onError = freezed,
    Object? errorContainer = freezed,
    Object? onErrorContainer = freezed,
    Object? outline = freezed,
    Object? outlineVariant = freezed,
    Object? background = freezed,
    Object? onBackground = freezed,
    Object? surface = freezed,
    Object? onSurface = freezed,
    Object? surfaceVariant = freezed,
    Object? onSurfaceVariant = freezed,
    Object? inverseSurface = freezed,
    Object? onInverseSurface = freezed,
    Object? inversePrimary = freezed,
    Object? shadow = freezed,
    Object? scrim = freezed,
    Object? surfaceTint = freezed,
  }) {
    return _then(_value.copyWith(
      primary: freezed == primary
          ? _value.primary
          : primary // ignore: cast_nullable_to_non_nullable
              as Color?,
      onPrimary: freezed == onPrimary
          ? _value.onPrimary
          : onPrimary // ignore: cast_nullable_to_non_nullable
              as Color?,
      primaryContainer: freezed == primaryContainer
          ? _value.primaryContainer
          : primaryContainer // ignore: cast_nullable_to_non_nullable
              as Color?,
      onPrimaryContainer: freezed == onPrimaryContainer
          ? _value.onPrimaryContainer
          : onPrimaryContainer // ignore: cast_nullable_to_non_nullable
              as Color?,
      secondary: freezed == secondary
          ? _value.secondary
          : secondary // ignore: cast_nullable_to_non_nullable
              as Color?,
      onSecondary: freezed == onSecondary
          ? _value.onSecondary
          : onSecondary // ignore: cast_nullable_to_non_nullable
              as Color?,
      secondaryContainer: freezed == secondaryContainer
          ? _value.secondaryContainer
          : secondaryContainer // ignore: cast_nullable_to_non_nullable
              as Color?,
      onSecondaryContainer: freezed == onSecondaryContainer
          ? _value.onSecondaryContainer
          : onSecondaryContainer // ignore: cast_nullable_to_non_nullable
              as Color?,
      tertiary: freezed == tertiary
          ? _value.tertiary
          : tertiary // ignore: cast_nullable_to_non_nullable
              as Color?,
      onTertiary: freezed == onTertiary
          ? _value.onTertiary
          : onTertiary // ignore: cast_nullable_to_non_nullable
              as Color?,
      tertiaryContainer: freezed == tertiaryContainer
          ? _value.tertiaryContainer
          : tertiaryContainer // ignore: cast_nullable_to_non_nullable
              as Color?,
      onTertiaryContainer: freezed == onTertiaryContainer
          ? _value.onTertiaryContainer
          : onTertiaryContainer // ignore: cast_nullable_to_non_nullable
              as Color?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as Color?,
      onError: freezed == onError
          ? _value.onError
          : onError // ignore: cast_nullable_to_non_nullable
              as Color?,
      errorContainer: freezed == errorContainer
          ? _value.errorContainer
          : errorContainer // ignore: cast_nullable_to_non_nullable
              as Color?,
      onErrorContainer: freezed == onErrorContainer
          ? _value.onErrorContainer
          : onErrorContainer // ignore: cast_nullable_to_non_nullable
              as Color?,
      outline: freezed == outline
          ? _value.outline
          : outline // ignore: cast_nullable_to_non_nullable
              as Color?,
      outlineVariant: freezed == outlineVariant
          ? _value.outlineVariant
          : outlineVariant // ignore: cast_nullable_to_non_nullable
              as Color?,
      background: freezed == background
          ? _value.background
          : background // ignore: cast_nullable_to_non_nullable
              as Color?,
      onBackground: freezed == onBackground
          ? _value.onBackground
          : onBackground // ignore: cast_nullable_to_non_nullable
              as Color?,
      surface: freezed == surface
          ? _value.surface
          : surface // ignore: cast_nullable_to_non_nullable
              as Color?,
      onSurface: freezed == onSurface
          ? _value.onSurface
          : onSurface // ignore: cast_nullable_to_non_nullable
              as Color?,
      surfaceVariant: freezed == surfaceVariant
          ? _value.surfaceVariant
          : surfaceVariant // ignore: cast_nullable_to_non_nullable
              as Color?,
      onSurfaceVariant: freezed == onSurfaceVariant
          ? _value.onSurfaceVariant
          : onSurfaceVariant // ignore: cast_nullable_to_non_nullable
              as Color?,
      inverseSurface: freezed == inverseSurface
          ? _value.inverseSurface
          : inverseSurface // ignore: cast_nullable_to_non_nullable
              as Color?,
      onInverseSurface: freezed == onInverseSurface
          ? _value.onInverseSurface
          : onInverseSurface // ignore: cast_nullable_to_non_nullable
              as Color?,
      inversePrimary: freezed == inversePrimary
          ? _value.inversePrimary
          : inversePrimary // ignore: cast_nullable_to_non_nullable
              as Color?,
      shadow: freezed == shadow
          ? _value.shadow
          : shadow // ignore: cast_nullable_to_non_nullable
              as Color?,
      scrim: freezed == scrim
          ? _value.scrim
          : scrim // ignore: cast_nullable_to_non_nullable
              as Color?,
      surfaceTint: freezed == surfaceTint
          ? _value.surfaceTint
          : surfaceTint // ignore: cast_nullable_to_non_nullable
              as Color?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ColorSchemeOverrideImplCopyWith<$Res>
    implements $ColorSchemeOverrideCopyWith<$Res> {
  factory _$$ColorSchemeOverrideImplCopyWith(_$ColorSchemeOverrideImpl value,
          $Res Function(_$ColorSchemeOverrideImpl) then) =
      __$$ColorSchemeOverrideImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Color? primary,
      Color? onPrimary,
      Color? primaryContainer,
      Color? onPrimaryContainer,
      Color? secondary,
      Color? onSecondary,
      Color? secondaryContainer,
      Color? onSecondaryContainer,
      Color? tertiary,
      Color? onTertiary,
      Color? tertiaryContainer,
      Color? onTertiaryContainer,
      Color? error,
      Color? onError,
      Color? errorContainer,
      Color? onErrorContainer,
      Color? outline,
      Color? outlineVariant,
      Color? background,
      Color? onBackground,
      Color? surface,
      Color? onSurface,
      Color? surfaceVariant,
      Color? onSurfaceVariant,
      Color? inverseSurface,
      Color? onInverseSurface,
      Color? inversePrimary,
      Color? shadow,
      Color? scrim,
      Color? surfaceTint});
}

/// @nodoc
class __$$ColorSchemeOverrideImplCopyWithImpl<$Res>
    extends _$ColorSchemeOverrideCopyWithImpl<$Res, _$ColorSchemeOverrideImpl>
    implements _$$ColorSchemeOverrideImplCopyWith<$Res> {
  __$$ColorSchemeOverrideImplCopyWithImpl(_$ColorSchemeOverrideImpl _value,
      $Res Function(_$ColorSchemeOverrideImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? primary = freezed,
    Object? onPrimary = freezed,
    Object? primaryContainer = freezed,
    Object? onPrimaryContainer = freezed,
    Object? secondary = freezed,
    Object? onSecondary = freezed,
    Object? secondaryContainer = freezed,
    Object? onSecondaryContainer = freezed,
    Object? tertiary = freezed,
    Object? onTertiary = freezed,
    Object? tertiaryContainer = freezed,
    Object? onTertiaryContainer = freezed,
    Object? error = freezed,
    Object? onError = freezed,
    Object? errorContainer = freezed,
    Object? onErrorContainer = freezed,
    Object? outline = freezed,
    Object? outlineVariant = freezed,
    Object? background = freezed,
    Object? onBackground = freezed,
    Object? surface = freezed,
    Object? onSurface = freezed,
    Object? surfaceVariant = freezed,
    Object? onSurfaceVariant = freezed,
    Object? inverseSurface = freezed,
    Object? onInverseSurface = freezed,
    Object? inversePrimary = freezed,
    Object? shadow = freezed,
    Object? scrim = freezed,
    Object? surfaceTint = freezed,
  }) {
    return _then(_$ColorSchemeOverrideImpl(
      primary: freezed == primary
          ? _value.primary
          : primary // ignore: cast_nullable_to_non_nullable
              as Color?,
      onPrimary: freezed == onPrimary
          ? _value.onPrimary
          : onPrimary // ignore: cast_nullable_to_non_nullable
              as Color?,
      primaryContainer: freezed == primaryContainer
          ? _value.primaryContainer
          : primaryContainer // ignore: cast_nullable_to_non_nullable
              as Color?,
      onPrimaryContainer: freezed == onPrimaryContainer
          ? _value.onPrimaryContainer
          : onPrimaryContainer // ignore: cast_nullable_to_non_nullable
              as Color?,
      secondary: freezed == secondary
          ? _value.secondary
          : secondary // ignore: cast_nullable_to_non_nullable
              as Color?,
      onSecondary: freezed == onSecondary
          ? _value.onSecondary
          : onSecondary // ignore: cast_nullable_to_non_nullable
              as Color?,
      secondaryContainer: freezed == secondaryContainer
          ? _value.secondaryContainer
          : secondaryContainer // ignore: cast_nullable_to_non_nullable
              as Color?,
      onSecondaryContainer: freezed == onSecondaryContainer
          ? _value.onSecondaryContainer
          : onSecondaryContainer // ignore: cast_nullable_to_non_nullable
              as Color?,
      tertiary: freezed == tertiary
          ? _value.tertiary
          : tertiary // ignore: cast_nullable_to_non_nullable
              as Color?,
      onTertiary: freezed == onTertiary
          ? _value.onTertiary
          : onTertiary // ignore: cast_nullable_to_non_nullable
              as Color?,
      tertiaryContainer: freezed == tertiaryContainer
          ? _value.tertiaryContainer
          : tertiaryContainer // ignore: cast_nullable_to_non_nullable
              as Color?,
      onTertiaryContainer: freezed == onTertiaryContainer
          ? _value.onTertiaryContainer
          : onTertiaryContainer // ignore: cast_nullable_to_non_nullable
              as Color?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as Color?,
      onError: freezed == onError
          ? _value.onError
          : onError // ignore: cast_nullable_to_non_nullable
              as Color?,
      errorContainer: freezed == errorContainer
          ? _value.errorContainer
          : errorContainer // ignore: cast_nullable_to_non_nullable
              as Color?,
      onErrorContainer: freezed == onErrorContainer
          ? _value.onErrorContainer
          : onErrorContainer // ignore: cast_nullable_to_non_nullable
              as Color?,
      outline: freezed == outline
          ? _value.outline
          : outline // ignore: cast_nullable_to_non_nullable
              as Color?,
      outlineVariant: freezed == outlineVariant
          ? _value.outlineVariant
          : outlineVariant // ignore: cast_nullable_to_non_nullable
              as Color?,
      background: freezed == background
          ? _value.background
          : background // ignore: cast_nullable_to_non_nullable
              as Color?,
      onBackground: freezed == onBackground
          ? _value.onBackground
          : onBackground // ignore: cast_nullable_to_non_nullable
              as Color?,
      surface: freezed == surface
          ? _value.surface
          : surface // ignore: cast_nullable_to_non_nullable
              as Color?,
      onSurface: freezed == onSurface
          ? _value.onSurface
          : onSurface // ignore: cast_nullable_to_non_nullable
              as Color?,
      surfaceVariant: freezed == surfaceVariant
          ? _value.surfaceVariant
          : surfaceVariant // ignore: cast_nullable_to_non_nullable
              as Color?,
      onSurfaceVariant: freezed == onSurfaceVariant
          ? _value.onSurfaceVariant
          : onSurfaceVariant // ignore: cast_nullable_to_non_nullable
              as Color?,
      inverseSurface: freezed == inverseSurface
          ? _value.inverseSurface
          : inverseSurface // ignore: cast_nullable_to_non_nullable
              as Color?,
      onInverseSurface: freezed == onInverseSurface
          ? _value.onInverseSurface
          : onInverseSurface // ignore: cast_nullable_to_non_nullable
              as Color?,
      inversePrimary: freezed == inversePrimary
          ? _value.inversePrimary
          : inversePrimary // ignore: cast_nullable_to_non_nullable
              as Color?,
      shadow: freezed == shadow
          ? _value.shadow
          : shadow // ignore: cast_nullable_to_non_nullable
              as Color?,
      scrim: freezed == scrim
          ? _value.scrim
          : scrim // ignore: cast_nullable_to_non_nullable
              as Color?,
      surfaceTint: freezed == surfaceTint
          ? _value.surfaceTint
          : surfaceTint // ignore: cast_nullable_to_non_nullable
              as Color?,
    ));
  }
}

/// @nodoc

@themeJsonSerializable
class _$ColorSchemeOverrideImpl implements _ColorSchemeOverride {
  const _$ColorSchemeOverrideImpl(
      {this.primary,
      this.onPrimary,
      this.primaryContainer,
      this.onPrimaryContainer,
      this.secondary,
      this.onSecondary,
      this.secondaryContainer,
      this.onSecondaryContainer,
      this.tertiary,
      this.onTertiary,
      this.tertiaryContainer,
      this.onTertiaryContainer,
      this.error,
      this.onError,
      this.errorContainer,
      this.onErrorContainer,
      this.outline,
      this.outlineVariant,
      this.background,
      this.onBackground,
      this.surface,
      this.onSurface,
      this.surfaceVariant,
      this.onSurfaceVariant,
      this.inverseSurface,
      this.onInverseSurface,
      this.inversePrimary,
      this.shadow,
      this.scrim,
      this.surfaceTint});

  factory _$ColorSchemeOverrideImpl.fromJson(Map<String, dynamic> json) =>
      _$$ColorSchemeOverrideImplFromJson(json);

  @override
  final Color? primary;
  @override
  final Color? onPrimary;
  @override
  final Color? primaryContainer;
  @override
  final Color? onPrimaryContainer;
  @override
  final Color? secondary;
  @override
  final Color? onSecondary;
  @override
  final Color? secondaryContainer;
  @override
  final Color? onSecondaryContainer;
  @override
  final Color? tertiary;
  @override
  final Color? onTertiary;
  @override
  final Color? tertiaryContainer;
  @override
  final Color? onTertiaryContainer;
  @override
  final Color? error;
  @override
  final Color? onError;
  @override
  final Color? errorContainer;
  @override
  final Color? onErrorContainer;
  @override
  final Color? outline;
  @override
  final Color? outlineVariant;
  @override
  final Color? background;
  @override
  final Color? onBackground;
  @override
  final Color? surface;
  @override
  final Color? onSurface;
  @override
  final Color? surfaceVariant;
  @override
  final Color? onSurfaceVariant;
  @override
  final Color? inverseSurface;
  @override
  final Color? onInverseSurface;
  @override
  final Color? inversePrimary;
  @override
  final Color? shadow;
  @override
  final Color? scrim;
  @override
  final Color? surfaceTint;

  @override
  String toString() {
    return 'ColorSchemeOverride(primary: $primary, onPrimary: $onPrimary, primaryContainer: $primaryContainer, onPrimaryContainer: $onPrimaryContainer, secondary: $secondary, onSecondary: $onSecondary, secondaryContainer: $secondaryContainer, onSecondaryContainer: $onSecondaryContainer, tertiary: $tertiary, onTertiary: $onTertiary, tertiaryContainer: $tertiaryContainer, onTertiaryContainer: $onTertiaryContainer, error: $error, onError: $onError, errorContainer: $errorContainer, onErrorContainer: $onErrorContainer, outline: $outline, outlineVariant: $outlineVariant, background: $background, onBackground: $onBackground, surface: $surface, onSurface: $onSurface, surfaceVariant: $surfaceVariant, onSurfaceVariant: $onSurfaceVariant, inverseSurface: $inverseSurface, onInverseSurface: $onInverseSurface, inversePrimary: $inversePrimary, shadow: $shadow, scrim: $scrim, surfaceTint: $surfaceTint)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ColorSchemeOverrideImpl &&
            (identical(other.primary, primary) || other.primary == primary) &&
            (identical(other.onPrimary, onPrimary) ||
                other.onPrimary == onPrimary) &&
            (identical(other.primaryContainer, primaryContainer) ||
                other.primaryContainer == primaryContainer) &&
            (identical(other.onPrimaryContainer, onPrimaryContainer) ||
                other.onPrimaryContainer == onPrimaryContainer) &&
            (identical(other.secondary, secondary) ||
                other.secondary == secondary) &&
            (identical(other.onSecondary, onSecondary) ||
                other.onSecondary == onSecondary) &&
            (identical(other.secondaryContainer, secondaryContainer) ||
                other.secondaryContainer == secondaryContainer) &&
            (identical(other.onSecondaryContainer, onSecondaryContainer) ||
                other.onSecondaryContainer == onSecondaryContainer) &&
            (identical(other.tertiary, tertiary) ||
                other.tertiary == tertiary) &&
            (identical(other.onTertiary, onTertiary) ||
                other.onTertiary == onTertiary) &&
            (identical(other.tertiaryContainer, tertiaryContainer) ||
                other.tertiaryContainer == tertiaryContainer) &&
            (identical(other.onTertiaryContainer, onTertiaryContainer) ||
                other.onTertiaryContainer == onTertiaryContainer) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.onError, onError) || other.onError == onError) &&
            (identical(other.errorContainer, errorContainer) ||
                other.errorContainer == errorContainer) &&
            (identical(other.onErrorContainer, onErrorContainer) ||
                other.onErrorContainer == onErrorContainer) &&
            (identical(other.outline, outline) || other.outline == outline) &&
            (identical(other.outlineVariant, outlineVariant) ||
                other.outlineVariant == outlineVariant) &&
            (identical(other.background, background) ||
                other.background == background) &&
            (identical(other.onBackground, onBackground) ||
                other.onBackground == onBackground) &&
            (identical(other.surface, surface) || other.surface == surface) &&
            (identical(other.onSurface, onSurface) ||
                other.onSurface == onSurface) &&
            (identical(other.surfaceVariant, surfaceVariant) ||
                other.surfaceVariant == surfaceVariant) &&
            (identical(other.onSurfaceVariant, onSurfaceVariant) ||
                other.onSurfaceVariant == onSurfaceVariant) &&
            (identical(other.inverseSurface, inverseSurface) ||
                other.inverseSurface == inverseSurface) &&
            (identical(other.onInverseSurface, onInverseSurface) ||
                other.onInverseSurface == onInverseSurface) &&
            (identical(other.inversePrimary, inversePrimary) ||
                other.inversePrimary == inversePrimary) &&
            (identical(other.shadow, shadow) || other.shadow == shadow) &&
            (identical(other.scrim, scrim) || other.scrim == scrim) &&
            (identical(other.surfaceTint, surfaceTint) ||
                other.surfaceTint == surfaceTint));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        primary,
        onPrimary,
        primaryContainer,
        onPrimaryContainer,
        secondary,
        onSecondary,
        secondaryContainer,
        onSecondaryContainer,
        tertiary,
        onTertiary,
        tertiaryContainer,
        onTertiaryContainer,
        error,
        onError,
        errorContainer,
        onErrorContainer,
        outline,
        outlineVariant,
        background,
        onBackground,
        surface,
        onSurface,
        surfaceVariant,
        onSurfaceVariant,
        inverseSurface,
        onInverseSurface,
        inversePrimary,
        shadow,
        scrim,
        surfaceTint
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ColorSchemeOverrideImplCopyWith<_$ColorSchemeOverrideImpl> get copyWith =>
      __$$ColorSchemeOverrideImplCopyWithImpl<_$ColorSchemeOverrideImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ColorSchemeOverrideImplToJson(
      this,
    );
  }
}

abstract class _ColorSchemeOverride implements ColorSchemeOverride {
  const factory _ColorSchemeOverride(
      {final Color? primary,
      final Color? onPrimary,
      final Color? primaryContainer,
      final Color? onPrimaryContainer,
      final Color? secondary,
      final Color? onSecondary,
      final Color? secondaryContainer,
      final Color? onSecondaryContainer,
      final Color? tertiary,
      final Color? onTertiary,
      final Color? tertiaryContainer,
      final Color? onTertiaryContainer,
      final Color? error,
      final Color? onError,
      final Color? errorContainer,
      final Color? onErrorContainer,
      final Color? outline,
      final Color? outlineVariant,
      final Color? background,
      final Color? onBackground,
      final Color? surface,
      final Color? onSurface,
      final Color? surfaceVariant,
      final Color? onSurfaceVariant,
      final Color? inverseSurface,
      final Color? onInverseSurface,
      final Color? inversePrimary,
      final Color? shadow,
      final Color? scrim,
      final Color? surfaceTint}) = _$ColorSchemeOverrideImpl;

  factory _ColorSchemeOverride.fromJson(Map<String, dynamic> json) =
      _$ColorSchemeOverrideImpl.fromJson;

  @override
  Color? get primary;
  @override
  Color? get onPrimary;
  @override
  Color? get primaryContainer;
  @override
  Color? get onPrimaryContainer;
  @override
  Color? get secondary;
  @override
  Color? get onSecondary;
  @override
  Color? get secondaryContainer;
  @override
  Color? get onSecondaryContainer;
  @override
  Color? get tertiary;
  @override
  Color? get onTertiary;
  @override
  Color? get tertiaryContainer;
  @override
  Color? get onTertiaryContainer;
  @override
  Color? get error;
  @override
  Color? get onError;
  @override
  Color? get errorContainer;
  @override
  Color? get onErrorContainer;
  @override
  Color? get outline;
  @override
  Color? get outlineVariant;
  @override
  Color? get background;
  @override
  Color? get onBackground;
  @override
  Color? get surface;
  @override
  Color? get onSurface;
  @override
  Color? get surfaceVariant;
  @override
  Color? get onSurfaceVariant;
  @override
  Color? get inverseSurface;
  @override
  Color? get onInverseSurface;
  @override
  Color? get inversePrimary;
  @override
  Color? get shadow;
  @override
  Color? get scrim;
  @override
  Color? get surfaceTint;
  @override
  @JsonKey(ignore: true)
  _$$ColorSchemeOverrideImplCopyWith<_$ColorSchemeOverrideImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
