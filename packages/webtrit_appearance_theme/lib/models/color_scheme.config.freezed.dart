// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'color_scheme.config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ColorSchemeConfig _$ColorSchemeConfigFromJson(Map<String, dynamic> json) {
  return _ColorSchemeConfig.fromJson(json);
}

/// @nodoc
mixin _$ColorSchemeConfig {
  String get seedColor => throw _privateConstructorUsedError;
  ColorSchemeOverride get colorSchemeOverride =>
      throw _privateConstructorUsedError;

  /// Serializes this ColorSchemeConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ColorSchemeConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ColorSchemeConfigCopyWith<ColorSchemeConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ColorSchemeConfigCopyWith<$Res> {
  factory $ColorSchemeConfigCopyWith(
          ColorSchemeConfig value, $Res Function(ColorSchemeConfig) then) =
      _$ColorSchemeConfigCopyWithImpl<$Res, ColorSchemeConfig>;
  @useResult
  $Res call({String seedColor, ColorSchemeOverride colorSchemeOverride});

  $ColorSchemeOverrideCopyWith<$Res> get colorSchemeOverride;
}

/// @nodoc
class _$ColorSchemeConfigCopyWithImpl<$Res, $Val extends ColorSchemeConfig>
    implements $ColorSchemeConfigCopyWith<$Res> {
  _$ColorSchemeConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ColorSchemeConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? seedColor = null,
    Object? colorSchemeOverride = null,
  }) {
    return _then(_value.copyWith(
      seedColor: null == seedColor
          ? _value.seedColor
          : seedColor // ignore: cast_nullable_to_non_nullable
              as String,
      colorSchemeOverride: null == colorSchemeOverride
          ? _value.colorSchemeOverride
          : colorSchemeOverride // ignore: cast_nullable_to_non_nullable
              as ColorSchemeOverride,
    ) as $Val);
  }

  /// Create a copy of ColorSchemeConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ColorSchemeOverrideCopyWith<$Res> get colorSchemeOverride {
    return $ColorSchemeOverrideCopyWith<$Res>(_value.colorSchemeOverride,
        (value) {
      return _then(_value.copyWith(colorSchemeOverride: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ColorSchemeConfigImplCopyWith<$Res>
    implements $ColorSchemeConfigCopyWith<$Res> {
  factory _$$ColorSchemeConfigImplCopyWith(_$ColorSchemeConfigImpl value,
          $Res Function(_$ColorSchemeConfigImpl) then) =
      __$$ColorSchemeConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String seedColor, ColorSchemeOverride colorSchemeOverride});

  @override
  $ColorSchemeOverrideCopyWith<$Res> get colorSchemeOverride;
}

/// @nodoc
class __$$ColorSchemeConfigImplCopyWithImpl<$Res>
    extends _$ColorSchemeConfigCopyWithImpl<$Res, _$ColorSchemeConfigImpl>
    implements _$$ColorSchemeConfigImplCopyWith<$Res> {
  __$$ColorSchemeConfigImplCopyWithImpl(_$ColorSchemeConfigImpl _value,
      $Res Function(_$ColorSchemeConfigImpl) _then)
      : super(_value, _then);

  /// Create a copy of ColorSchemeConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? seedColor = null,
    Object? colorSchemeOverride = null,
  }) {
    return _then(_$ColorSchemeConfigImpl(
      seedColor: null == seedColor
          ? _value.seedColor
          : seedColor // ignore: cast_nullable_to_non_nullable
              as String,
      colorSchemeOverride: null == colorSchemeOverride
          ? _value.colorSchemeOverride
          : colorSchemeOverride // ignore: cast_nullable_to_non_nullable
              as ColorSchemeOverride,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$ColorSchemeConfigImpl implements _ColorSchemeConfig {
  const _$ColorSchemeConfigImpl(
      {this.seedColor = '#F95A14',
      this.colorSchemeOverride = const ColorSchemeOverride()});

  factory _$ColorSchemeConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$ColorSchemeConfigImplFromJson(json);

  @override
  @JsonKey()
  final String seedColor;
  @override
  @JsonKey()
  final ColorSchemeOverride colorSchemeOverride;

  @override
  String toString() {
    return 'ColorSchemeConfig(seedColor: $seedColor, colorSchemeOverride: $colorSchemeOverride)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ColorSchemeConfigImpl &&
            (identical(other.seedColor, seedColor) ||
                other.seedColor == seedColor) &&
            (identical(other.colorSchemeOverride, colorSchemeOverride) ||
                other.colorSchemeOverride == colorSchemeOverride));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, seedColor, colorSchemeOverride);

  /// Create a copy of ColorSchemeConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ColorSchemeConfigImplCopyWith<_$ColorSchemeConfigImpl> get copyWith =>
      __$$ColorSchemeConfigImplCopyWithImpl<_$ColorSchemeConfigImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ColorSchemeConfigImplToJson(
      this,
    );
  }
}

abstract class _ColorSchemeConfig implements ColorSchemeConfig {
  const factory _ColorSchemeConfig(
      {final String seedColor,
      final ColorSchemeOverride colorSchemeOverride}) = _$ColorSchemeConfigImpl;

  factory _ColorSchemeConfig.fromJson(Map<String, dynamic> json) =
      _$ColorSchemeConfigImpl.fromJson;

  @override
  String get seedColor;
  @override
  ColorSchemeOverride get colorSchemeOverride;

  /// Create a copy of ColorSchemeConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ColorSchemeConfigImplCopyWith<_$ColorSchemeConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ColorSchemeOverride _$ColorSchemeOverrideFromJson(Map<String, dynamic> json) {
  return _ColorSchemeOverride.fromJson(json);
}

/// @nodoc
mixin _$ColorSchemeOverride {
  String get primary => throw _privateConstructorUsedError;
  String get onPrimary => throw _privateConstructorUsedError;
  String get primaryContainer => throw _privateConstructorUsedError;
  String get onPrimaryContainer => throw _privateConstructorUsedError;
  String get primaryFixed => throw _privateConstructorUsedError;
  String get primaryFixedDim => throw _privateConstructorUsedError;
  String get onPrimaryFixed => throw _privateConstructorUsedError;
  String get onPrimaryFixedVariant => throw _privateConstructorUsedError;
  String get secondary => throw _privateConstructorUsedError;
  String get onSecondary => throw _privateConstructorUsedError;
  String get secondaryContainer => throw _privateConstructorUsedError;
  String get onSecondaryContainer => throw _privateConstructorUsedError;
  String get secondaryFixed => throw _privateConstructorUsedError;
  String get secondaryFixedDim => throw _privateConstructorUsedError;
  String get onSecondaryFixed => throw _privateConstructorUsedError;
  String get onSecondaryFixedVariant => throw _privateConstructorUsedError;
  String get tertiary => throw _privateConstructorUsedError;
  String get onTertiary => throw _privateConstructorUsedError;
  String get tertiaryContainer => throw _privateConstructorUsedError;
  String get onTertiaryContainer => throw _privateConstructorUsedError;
  String get tertiaryFixed => throw _privateConstructorUsedError;
  String get tertiaryFixedDim => throw _privateConstructorUsedError;
  String get onTertiaryFixed => throw _privateConstructorUsedError;
  String get onTertiaryFixedVariant => throw _privateConstructorUsedError;
  String get error => throw _privateConstructorUsedError;
  String get onError => throw _privateConstructorUsedError;
  String get errorContainer => throw _privateConstructorUsedError;
  String get onErrorContainer => throw _privateConstructorUsedError;
  String get outline => throw _privateConstructorUsedError;
  String get outlineVariant => throw _privateConstructorUsedError;
  String get surface => throw _privateConstructorUsedError;
  String get onSurface => throw _privateConstructorUsedError;
  String get surfaceDim => throw _privateConstructorUsedError;
  String get surfaceBright => throw _privateConstructorUsedError;
  String get surfaceContainerLowest => throw _privateConstructorUsedError;
  String get surfaceContainerLow => throw _privateConstructorUsedError;
  String get surfaceContainer => throw _privateConstructorUsedError;
  String get surfaceContainerHigh => throw _privateConstructorUsedError;
  String get surfaceContainerHighest => throw _privateConstructorUsedError;
  String get onSurfaceVariant => throw _privateConstructorUsedError;
  String get inverseSurface => throw _privateConstructorUsedError;
  String get onInverseSurface => throw _privateConstructorUsedError;
  String get inversePrimary => throw _privateConstructorUsedError;
  String get shadow => throw _privateConstructorUsedError;
  String get scrim => throw _privateConstructorUsedError;
  String get surfaceTint => throw _privateConstructorUsedError;

  /// Serializes this ColorSchemeOverride to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ColorSchemeOverride
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      {String primary,
      String onPrimary,
      String primaryContainer,
      String onPrimaryContainer,
      String primaryFixed,
      String primaryFixedDim,
      String onPrimaryFixed,
      String onPrimaryFixedVariant,
      String secondary,
      String onSecondary,
      String secondaryContainer,
      String onSecondaryContainer,
      String secondaryFixed,
      String secondaryFixedDim,
      String onSecondaryFixed,
      String onSecondaryFixedVariant,
      String tertiary,
      String onTertiary,
      String tertiaryContainer,
      String onTertiaryContainer,
      String tertiaryFixed,
      String tertiaryFixedDim,
      String onTertiaryFixed,
      String onTertiaryFixedVariant,
      String error,
      String onError,
      String errorContainer,
      String onErrorContainer,
      String outline,
      String outlineVariant,
      String surface,
      String onSurface,
      String surfaceDim,
      String surfaceBright,
      String surfaceContainerLowest,
      String surfaceContainerLow,
      String surfaceContainer,
      String surfaceContainerHigh,
      String surfaceContainerHighest,
      String onSurfaceVariant,
      String inverseSurface,
      String onInverseSurface,
      String inversePrimary,
      String shadow,
      String scrim,
      String surfaceTint});
}

/// @nodoc
class _$ColorSchemeOverrideCopyWithImpl<$Res, $Val extends ColorSchemeOverride>
    implements $ColorSchemeOverrideCopyWith<$Res> {
  _$ColorSchemeOverrideCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ColorSchemeOverride
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? primary = null,
    Object? onPrimary = null,
    Object? primaryContainer = null,
    Object? onPrimaryContainer = null,
    Object? primaryFixed = null,
    Object? primaryFixedDim = null,
    Object? onPrimaryFixed = null,
    Object? onPrimaryFixedVariant = null,
    Object? secondary = null,
    Object? onSecondary = null,
    Object? secondaryContainer = null,
    Object? onSecondaryContainer = null,
    Object? secondaryFixed = null,
    Object? secondaryFixedDim = null,
    Object? onSecondaryFixed = null,
    Object? onSecondaryFixedVariant = null,
    Object? tertiary = null,
    Object? onTertiary = null,
    Object? tertiaryContainer = null,
    Object? onTertiaryContainer = null,
    Object? tertiaryFixed = null,
    Object? tertiaryFixedDim = null,
    Object? onTertiaryFixed = null,
    Object? onTertiaryFixedVariant = null,
    Object? error = null,
    Object? onError = null,
    Object? errorContainer = null,
    Object? onErrorContainer = null,
    Object? outline = null,
    Object? outlineVariant = null,
    Object? surface = null,
    Object? onSurface = null,
    Object? surfaceDim = null,
    Object? surfaceBright = null,
    Object? surfaceContainerLowest = null,
    Object? surfaceContainerLow = null,
    Object? surfaceContainer = null,
    Object? surfaceContainerHigh = null,
    Object? surfaceContainerHighest = null,
    Object? onSurfaceVariant = null,
    Object? inverseSurface = null,
    Object? onInverseSurface = null,
    Object? inversePrimary = null,
    Object? shadow = null,
    Object? scrim = null,
    Object? surfaceTint = null,
  }) {
    return _then(_value.copyWith(
      primary: null == primary
          ? _value.primary
          : primary // ignore: cast_nullable_to_non_nullable
              as String,
      onPrimary: null == onPrimary
          ? _value.onPrimary
          : onPrimary // ignore: cast_nullable_to_non_nullable
              as String,
      primaryContainer: null == primaryContainer
          ? _value.primaryContainer
          : primaryContainer // ignore: cast_nullable_to_non_nullable
              as String,
      onPrimaryContainer: null == onPrimaryContainer
          ? _value.onPrimaryContainer
          : onPrimaryContainer // ignore: cast_nullable_to_non_nullable
              as String,
      primaryFixed: null == primaryFixed
          ? _value.primaryFixed
          : primaryFixed // ignore: cast_nullable_to_non_nullable
              as String,
      primaryFixedDim: null == primaryFixedDim
          ? _value.primaryFixedDim
          : primaryFixedDim // ignore: cast_nullable_to_non_nullable
              as String,
      onPrimaryFixed: null == onPrimaryFixed
          ? _value.onPrimaryFixed
          : onPrimaryFixed // ignore: cast_nullable_to_non_nullable
              as String,
      onPrimaryFixedVariant: null == onPrimaryFixedVariant
          ? _value.onPrimaryFixedVariant
          : onPrimaryFixedVariant // ignore: cast_nullable_to_non_nullable
              as String,
      secondary: null == secondary
          ? _value.secondary
          : secondary // ignore: cast_nullable_to_non_nullable
              as String,
      onSecondary: null == onSecondary
          ? _value.onSecondary
          : onSecondary // ignore: cast_nullable_to_non_nullable
              as String,
      secondaryContainer: null == secondaryContainer
          ? _value.secondaryContainer
          : secondaryContainer // ignore: cast_nullable_to_non_nullable
              as String,
      onSecondaryContainer: null == onSecondaryContainer
          ? _value.onSecondaryContainer
          : onSecondaryContainer // ignore: cast_nullable_to_non_nullable
              as String,
      secondaryFixed: null == secondaryFixed
          ? _value.secondaryFixed
          : secondaryFixed // ignore: cast_nullable_to_non_nullable
              as String,
      secondaryFixedDim: null == secondaryFixedDim
          ? _value.secondaryFixedDim
          : secondaryFixedDim // ignore: cast_nullable_to_non_nullable
              as String,
      onSecondaryFixed: null == onSecondaryFixed
          ? _value.onSecondaryFixed
          : onSecondaryFixed // ignore: cast_nullable_to_non_nullable
              as String,
      onSecondaryFixedVariant: null == onSecondaryFixedVariant
          ? _value.onSecondaryFixedVariant
          : onSecondaryFixedVariant // ignore: cast_nullable_to_non_nullable
              as String,
      tertiary: null == tertiary
          ? _value.tertiary
          : tertiary // ignore: cast_nullable_to_non_nullable
              as String,
      onTertiary: null == onTertiary
          ? _value.onTertiary
          : onTertiary // ignore: cast_nullable_to_non_nullable
              as String,
      tertiaryContainer: null == tertiaryContainer
          ? _value.tertiaryContainer
          : tertiaryContainer // ignore: cast_nullable_to_non_nullable
              as String,
      onTertiaryContainer: null == onTertiaryContainer
          ? _value.onTertiaryContainer
          : onTertiaryContainer // ignore: cast_nullable_to_non_nullable
              as String,
      tertiaryFixed: null == tertiaryFixed
          ? _value.tertiaryFixed
          : tertiaryFixed // ignore: cast_nullable_to_non_nullable
              as String,
      tertiaryFixedDim: null == tertiaryFixedDim
          ? _value.tertiaryFixedDim
          : tertiaryFixedDim // ignore: cast_nullable_to_non_nullable
              as String,
      onTertiaryFixed: null == onTertiaryFixed
          ? _value.onTertiaryFixed
          : onTertiaryFixed // ignore: cast_nullable_to_non_nullable
              as String,
      onTertiaryFixedVariant: null == onTertiaryFixedVariant
          ? _value.onTertiaryFixedVariant
          : onTertiaryFixedVariant // ignore: cast_nullable_to_non_nullable
              as String,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      onError: null == onError
          ? _value.onError
          : onError // ignore: cast_nullable_to_non_nullable
              as String,
      errorContainer: null == errorContainer
          ? _value.errorContainer
          : errorContainer // ignore: cast_nullable_to_non_nullable
              as String,
      onErrorContainer: null == onErrorContainer
          ? _value.onErrorContainer
          : onErrorContainer // ignore: cast_nullable_to_non_nullable
              as String,
      outline: null == outline
          ? _value.outline
          : outline // ignore: cast_nullable_to_non_nullable
              as String,
      outlineVariant: null == outlineVariant
          ? _value.outlineVariant
          : outlineVariant // ignore: cast_nullable_to_non_nullable
              as String,
      surface: null == surface
          ? _value.surface
          : surface // ignore: cast_nullable_to_non_nullable
              as String,
      onSurface: null == onSurface
          ? _value.onSurface
          : onSurface // ignore: cast_nullable_to_non_nullable
              as String,
      surfaceDim: null == surfaceDim
          ? _value.surfaceDim
          : surfaceDim // ignore: cast_nullable_to_non_nullable
              as String,
      surfaceBright: null == surfaceBright
          ? _value.surfaceBright
          : surfaceBright // ignore: cast_nullable_to_non_nullable
              as String,
      surfaceContainerLowest: null == surfaceContainerLowest
          ? _value.surfaceContainerLowest
          : surfaceContainerLowest // ignore: cast_nullable_to_non_nullable
              as String,
      surfaceContainerLow: null == surfaceContainerLow
          ? _value.surfaceContainerLow
          : surfaceContainerLow // ignore: cast_nullable_to_non_nullable
              as String,
      surfaceContainer: null == surfaceContainer
          ? _value.surfaceContainer
          : surfaceContainer // ignore: cast_nullable_to_non_nullable
              as String,
      surfaceContainerHigh: null == surfaceContainerHigh
          ? _value.surfaceContainerHigh
          : surfaceContainerHigh // ignore: cast_nullable_to_non_nullable
              as String,
      surfaceContainerHighest: null == surfaceContainerHighest
          ? _value.surfaceContainerHighest
          : surfaceContainerHighest // ignore: cast_nullable_to_non_nullable
              as String,
      onSurfaceVariant: null == onSurfaceVariant
          ? _value.onSurfaceVariant
          : onSurfaceVariant // ignore: cast_nullable_to_non_nullable
              as String,
      inverseSurface: null == inverseSurface
          ? _value.inverseSurface
          : inverseSurface // ignore: cast_nullable_to_non_nullable
              as String,
      onInverseSurface: null == onInverseSurface
          ? _value.onInverseSurface
          : onInverseSurface // ignore: cast_nullable_to_non_nullable
              as String,
      inversePrimary: null == inversePrimary
          ? _value.inversePrimary
          : inversePrimary // ignore: cast_nullable_to_non_nullable
              as String,
      shadow: null == shadow
          ? _value.shadow
          : shadow // ignore: cast_nullable_to_non_nullable
              as String,
      scrim: null == scrim
          ? _value.scrim
          : scrim // ignore: cast_nullable_to_non_nullable
              as String,
      surfaceTint: null == surfaceTint
          ? _value.surfaceTint
          : surfaceTint // ignore: cast_nullable_to_non_nullable
              as String,
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
      {String primary,
      String onPrimary,
      String primaryContainer,
      String onPrimaryContainer,
      String primaryFixed,
      String primaryFixedDim,
      String onPrimaryFixed,
      String onPrimaryFixedVariant,
      String secondary,
      String onSecondary,
      String secondaryContainer,
      String onSecondaryContainer,
      String secondaryFixed,
      String secondaryFixedDim,
      String onSecondaryFixed,
      String onSecondaryFixedVariant,
      String tertiary,
      String onTertiary,
      String tertiaryContainer,
      String onTertiaryContainer,
      String tertiaryFixed,
      String tertiaryFixedDim,
      String onTertiaryFixed,
      String onTertiaryFixedVariant,
      String error,
      String onError,
      String errorContainer,
      String onErrorContainer,
      String outline,
      String outlineVariant,
      String surface,
      String onSurface,
      String surfaceDim,
      String surfaceBright,
      String surfaceContainerLowest,
      String surfaceContainerLow,
      String surfaceContainer,
      String surfaceContainerHigh,
      String surfaceContainerHighest,
      String onSurfaceVariant,
      String inverseSurface,
      String onInverseSurface,
      String inversePrimary,
      String shadow,
      String scrim,
      String surfaceTint});
}

/// @nodoc
class __$$ColorSchemeOverrideImplCopyWithImpl<$Res>
    extends _$ColorSchemeOverrideCopyWithImpl<$Res, _$ColorSchemeOverrideImpl>
    implements _$$ColorSchemeOverrideImplCopyWith<$Res> {
  __$$ColorSchemeOverrideImplCopyWithImpl(_$ColorSchemeOverrideImpl _value,
      $Res Function(_$ColorSchemeOverrideImpl) _then)
      : super(_value, _then);

  /// Create a copy of ColorSchemeOverride
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? primary = null,
    Object? onPrimary = null,
    Object? primaryContainer = null,
    Object? onPrimaryContainer = null,
    Object? primaryFixed = null,
    Object? primaryFixedDim = null,
    Object? onPrimaryFixed = null,
    Object? onPrimaryFixedVariant = null,
    Object? secondary = null,
    Object? onSecondary = null,
    Object? secondaryContainer = null,
    Object? onSecondaryContainer = null,
    Object? secondaryFixed = null,
    Object? secondaryFixedDim = null,
    Object? onSecondaryFixed = null,
    Object? onSecondaryFixedVariant = null,
    Object? tertiary = null,
    Object? onTertiary = null,
    Object? tertiaryContainer = null,
    Object? onTertiaryContainer = null,
    Object? tertiaryFixed = null,
    Object? tertiaryFixedDim = null,
    Object? onTertiaryFixed = null,
    Object? onTertiaryFixedVariant = null,
    Object? error = null,
    Object? onError = null,
    Object? errorContainer = null,
    Object? onErrorContainer = null,
    Object? outline = null,
    Object? outlineVariant = null,
    Object? surface = null,
    Object? onSurface = null,
    Object? surfaceDim = null,
    Object? surfaceBright = null,
    Object? surfaceContainerLowest = null,
    Object? surfaceContainerLow = null,
    Object? surfaceContainer = null,
    Object? surfaceContainerHigh = null,
    Object? surfaceContainerHighest = null,
    Object? onSurfaceVariant = null,
    Object? inverseSurface = null,
    Object? onInverseSurface = null,
    Object? inversePrimary = null,
    Object? shadow = null,
    Object? scrim = null,
    Object? surfaceTint = null,
  }) {
    return _then(_$ColorSchemeOverrideImpl(
      primary: null == primary
          ? _value.primary
          : primary // ignore: cast_nullable_to_non_nullable
              as String,
      onPrimary: null == onPrimary
          ? _value.onPrimary
          : onPrimary // ignore: cast_nullable_to_non_nullable
              as String,
      primaryContainer: null == primaryContainer
          ? _value.primaryContainer
          : primaryContainer // ignore: cast_nullable_to_non_nullable
              as String,
      onPrimaryContainer: null == onPrimaryContainer
          ? _value.onPrimaryContainer
          : onPrimaryContainer // ignore: cast_nullable_to_non_nullable
              as String,
      primaryFixed: null == primaryFixed
          ? _value.primaryFixed
          : primaryFixed // ignore: cast_nullable_to_non_nullable
              as String,
      primaryFixedDim: null == primaryFixedDim
          ? _value.primaryFixedDim
          : primaryFixedDim // ignore: cast_nullable_to_non_nullable
              as String,
      onPrimaryFixed: null == onPrimaryFixed
          ? _value.onPrimaryFixed
          : onPrimaryFixed // ignore: cast_nullable_to_non_nullable
              as String,
      onPrimaryFixedVariant: null == onPrimaryFixedVariant
          ? _value.onPrimaryFixedVariant
          : onPrimaryFixedVariant // ignore: cast_nullable_to_non_nullable
              as String,
      secondary: null == secondary
          ? _value.secondary
          : secondary // ignore: cast_nullable_to_non_nullable
              as String,
      onSecondary: null == onSecondary
          ? _value.onSecondary
          : onSecondary // ignore: cast_nullable_to_non_nullable
              as String,
      secondaryContainer: null == secondaryContainer
          ? _value.secondaryContainer
          : secondaryContainer // ignore: cast_nullable_to_non_nullable
              as String,
      onSecondaryContainer: null == onSecondaryContainer
          ? _value.onSecondaryContainer
          : onSecondaryContainer // ignore: cast_nullable_to_non_nullable
              as String,
      secondaryFixed: null == secondaryFixed
          ? _value.secondaryFixed
          : secondaryFixed // ignore: cast_nullable_to_non_nullable
              as String,
      secondaryFixedDim: null == secondaryFixedDim
          ? _value.secondaryFixedDim
          : secondaryFixedDim // ignore: cast_nullable_to_non_nullable
              as String,
      onSecondaryFixed: null == onSecondaryFixed
          ? _value.onSecondaryFixed
          : onSecondaryFixed // ignore: cast_nullable_to_non_nullable
              as String,
      onSecondaryFixedVariant: null == onSecondaryFixedVariant
          ? _value.onSecondaryFixedVariant
          : onSecondaryFixedVariant // ignore: cast_nullable_to_non_nullable
              as String,
      tertiary: null == tertiary
          ? _value.tertiary
          : tertiary // ignore: cast_nullable_to_non_nullable
              as String,
      onTertiary: null == onTertiary
          ? _value.onTertiary
          : onTertiary // ignore: cast_nullable_to_non_nullable
              as String,
      tertiaryContainer: null == tertiaryContainer
          ? _value.tertiaryContainer
          : tertiaryContainer // ignore: cast_nullable_to_non_nullable
              as String,
      onTertiaryContainer: null == onTertiaryContainer
          ? _value.onTertiaryContainer
          : onTertiaryContainer // ignore: cast_nullable_to_non_nullable
              as String,
      tertiaryFixed: null == tertiaryFixed
          ? _value.tertiaryFixed
          : tertiaryFixed // ignore: cast_nullable_to_non_nullable
              as String,
      tertiaryFixedDim: null == tertiaryFixedDim
          ? _value.tertiaryFixedDim
          : tertiaryFixedDim // ignore: cast_nullable_to_non_nullable
              as String,
      onTertiaryFixed: null == onTertiaryFixed
          ? _value.onTertiaryFixed
          : onTertiaryFixed // ignore: cast_nullable_to_non_nullable
              as String,
      onTertiaryFixedVariant: null == onTertiaryFixedVariant
          ? _value.onTertiaryFixedVariant
          : onTertiaryFixedVariant // ignore: cast_nullable_to_non_nullable
              as String,
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
      onError: null == onError
          ? _value.onError
          : onError // ignore: cast_nullable_to_non_nullable
              as String,
      errorContainer: null == errorContainer
          ? _value.errorContainer
          : errorContainer // ignore: cast_nullable_to_non_nullable
              as String,
      onErrorContainer: null == onErrorContainer
          ? _value.onErrorContainer
          : onErrorContainer // ignore: cast_nullable_to_non_nullable
              as String,
      outline: null == outline
          ? _value.outline
          : outline // ignore: cast_nullable_to_non_nullable
              as String,
      outlineVariant: null == outlineVariant
          ? _value.outlineVariant
          : outlineVariant // ignore: cast_nullable_to_non_nullable
              as String,
      surface: null == surface
          ? _value.surface
          : surface // ignore: cast_nullable_to_non_nullable
              as String,
      onSurface: null == onSurface
          ? _value.onSurface
          : onSurface // ignore: cast_nullable_to_non_nullable
              as String,
      surfaceDim: null == surfaceDim
          ? _value.surfaceDim
          : surfaceDim // ignore: cast_nullable_to_non_nullable
              as String,
      surfaceBright: null == surfaceBright
          ? _value.surfaceBright
          : surfaceBright // ignore: cast_nullable_to_non_nullable
              as String,
      surfaceContainerLowest: null == surfaceContainerLowest
          ? _value.surfaceContainerLowest
          : surfaceContainerLowest // ignore: cast_nullable_to_non_nullable
              as String,
      surfaceContainerLow: null == surfaceContainerLow
          ? _value.surfaceContainerLow
          : surfaceContainerLow // ignore: cast_nullable_to_non_nullable
              as String,
      surfaceContainer: null == surfaceContainer
          ? _value.surfaceContainer
          : surfaceContainer // ignore: cast_nullable_to_non_nullable
              as String,
      surfaceContainerHigh: null == surfaceContainerHigh
          ? _value.surfaceContainerHigh
          : surfaceContainerHigh // ignore: cast_nullable_to_non_nullable
              as String,
      surfaceContainerHighest: null == surfaceContainerHighest
          ? _value.surfaceContainerHighest
          : surfaceContainerHighest // ignore: cast_nullable_to_non_nullable
              as String,
      onSurfaceVariant: null == onSurfaceVariant
          ? _value.onSurfaceVariant
          : onSurfaceVariant // ignore: cast_nullable_to_non_nullable
              as String,
      inverseSurface: null == inverseSurface
          ? _value.inverseSurface
          : inverseSurface // ignore: cast_nullable_to_non_nullable
              as String,
      onInverseSurface: null == onInverseSurface
          ? _value.onInverseSurface
          : onInverseSurface // ignore: cast_nullable_to_non_nullable
              as String,
      inversePrimary: null == inversePrimary
          ? _value.inversePrimary
          : inversePrimary // ignore: cast_nullable_to_non_nullable
              as String,
      shadow: null == shadow
          ? _value.shadow
          : shadow // ignore: cast_nullable_to_non_nullable
              as String,
      scrim: null == scrim
          ? _value.scrim
          : scrim // ignore: cast_nullable_to_non_nullable
              as String,
      surfaceTint: null == surfaceTint
          ? _value.surfaceTint
          : surfaceTint // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$ColorSchemeOverrideImpl implements _ColorSchemeOverride {
  const _$ColorSchemeOverrideImpl(
      {this.primary = '#5CACE3',
      this.onPrimary = '#FFFFFF',
      this.primaryContainer = '#B9E3F9',
      this.onPrimaryContainer = '#123752',
      this.primaryFixed = '#A5C6E4',
      this.primaryFixedDim = '#75A1C5',
      this.onPrimaryFixed = '#092D4A',
      this.onPrimaryFixedVariant = '#A5C6E4',
      this.secondary = '#123752',
      this.onSecondary = '#FFFFFF',
      this.secondaryContainer = '#EEF3F6',
      this.onSecondaryContainer = '#1F618F',
      this.secondaryFixed = '#848581',
      this.secondaryFixedDim = '#4C4D4A',
      this.onSecondaryFixed = '#30302F',
      this.onSecondaryFixedVariant = '#848581',
      this.tertiary = '#75B943',
      this.onTertiary = '#FFFFFF',
      this.tertiaryContainer = '#E1F7C1',
      this.onTertiaryContainer = '#2E5200',
      this.tertiaryFixed = '#B8E078',
      this.tertiaryFixedDim = '#8CC14E',
      this.onTertiaryFixed = '#224400',
      this.onTertiaryFixedVariant = '#B8E078',
      this.error = '#E74C3C',
      this.onError = '#FFFFFF',
      this.errorContainer = '#F5B7B1',
      this.onErrorContainer = '#8B1E13',
      this.outline = '#4C4D4A',
      this.outlineVariant = '#CDCFC9',
      this.surface = '#EEF3F6',
      this.onSurface = '#30302F',
      this.surfaceDim = '#DDE0E3',
      this.surfaceBright = '#FFFFFF',
      this.surfaceContainerLowest = '#F8FBFD',
      this.surfaceContainerLow = '#F0F3F5',
      this.surfaceContainer = '#EEF3F6',
      this.surfaceContainerHigh = '#E2E6E9',
      this.surfaceContainerHighest = '#DDE0E3',
      this.onSurfaceVariant = '#848581',
      this.inverseSurface = '#30302F',
      this.onInverseSurface = '#EEF3F6',
      this.inversePrimary = '#1F618F',
      this.shadow = '#000000',
      this.scrim = '#000000',
      this.surfaceTint = '#F95A14'});

  factory _$ColorSchemeOverrideImpl.fromJson(Map<String, dynamic> json) =>
      _$$ColorSchemeOverrideImplFromJson(json);

  @override
  @JsonKey()
  final String primary;
  @override
  @JsonKey()
  final String onPrimary;
  @override
  @JsonKey()
  final String primaryContainer;
  @override
  @JsonKey()
  final String onPrimaryContainer;
  @override
  @JsonKey()
  final String primaryFixed;
  @override
  @JsonKey()
  final String primaryFixedDim;
  @override
  @JsonKey()
  final String onPrimaryFixed;
  @override
  @JsonKey()
  final String onPrimaryFixedVariant;
  @override
  @JsonKey()
  final String secondary;
  @override
  @JsonKey()
  final String onSecondary;
  @override
  @JsonKey()
  final String secondaryContainer;
  @override
  @JsonKey()
  final String onSecondaryContainer;
  @override
  @JsonKey()
  final String secondaryFixed;
  @override
  @JsonKey()
  final String secondaryFixedDim;
  @override
  @JsonKey()
  final String onSecondaryFixed;
  @override
  @JsonKey()
  final String onSecondaryFixedVariant;
  @override
  @JsonKey()
  final String tertiary;
  @override
  @JsonKey()
  final String onTertiary;
  @override
  @JsonKey()
  final String tertiaryContainer;
  @override
  @JsonKey()
  final String onTertiaryContainer;
  @override
  @JsonKey()
  final String tertiaryFixed;
  @override
  @JsonKey()
  final String tertiaryFixedDim;
  @override
  @JsonKey()
  final String onTertiaryFixed;
  @override
  @JsonKey()
  final String onTertiaryFixedVariant;
  @override
  @JsonKey()
  final String error;
  @override
  @JsonKey()
  final String onError;
  @override
  @JsonKey()
  final String errorContainer;
  @override
  @JsonKey()
  final String onErrorContainer;
  @override
  @JsonKey()
  final String outline;
  @override
  @JsonKey()
  final String outlineVariant;
  @override
  @JsonKey()
  final String surface;
  @override
  @JsonKey()
  final String onSurface;
  @override
  @JsonKey()
  final String surfaceDim;
  @override
  @JsonKey()
  final String surfaceBright;
  @override
  @JsonKey()
  final String surfaceContainerLowest;
  @override
  @JsonKey()
  final String surfaceContainerLow;
  @override
  @JsonKey()
  final String surfaceContainer;
  @override
  @JsonKey()
  final String surfaceContainerHigh;
  @override
  @JsonKey()
  final String surfaceContainerHighest;
  @override
  @JsonKey()
  final String onSurfaceVariant;
  @override
  @JsonKey()
  final String inverseSurface;
  @override
  @JsonKey()
  final String onInverseSurface;
  @override
  @JsonKey()
  final String inversePrimary;
  @override
  @JsonKey()
  final String shadow;
  @override
  @JsonKey()
  final String scrim;
  @override
  @JsonKey()
  final String surfaceTint;

  @override
  String toString() {
    return 'ColorSchemeOverride(primary: $primary, onPrimary: $onPrimary, primaryContainer: $primaryContainer, onPrimaryContainer: $onPrimaryContainer, primaryFixed: $primaryFixed, primaryFixedDim: $primaryFixedDim, onPrimaryFixed: $onPrimaryFixed, onPrimaryFixedVariant: $onPrimaryFixedVariant, secondary: $secondary, onSecondary: $onSecondary, secondaryContainer: $secondaryContainer, onSecondaryContainer: $onSecondaryContainer, secondaryFixed: $secondaryFixed, secondaryFixedDim: $secondaryFixedDim, onSecondaryFixed: $onSecondaryFixed, onSecondaryFixedVariant: $onSecondaryFixedVariant, tertiary: $tertiary, onTertiary: $onTertiary, tertiaryContainer: $tertiaryContainer, onTertiaryContainer: $onTertiaryContainer, tertiaryFixed: $tertiaryFixed, tertiaryFixedDim: $tertiaryFixedDim, onTertiaryFixed: $onTertiaryFixed, onTertiaryFixedVariant: $onTertiaryFixedVariant, error: $error, onError: $onError, errorContainer: $errorContainer, onErrorContainer: $onErrorContainer, outline: $outline, outlineVariant: $outlineVariant, surface: $surface, onSurface: $onSurface, surfaceDim: $surfaceDim, surfaceBright: $surfaceBright, surfaceContainerLowest: $surfaceContainerLowest, surfaceContainerLow: $surfaceContainerLow, surfaceContainer: $surfaceContainer, surfaceContainerHigh: $surfaceContainerHigh, surfaceContainerHighest: $surfaceContainerHighest, onSurfaceVariant: $onSurfaceVariant, inverseSurface: $inverseSurface, onInverseSurface: $onInverseSurface, inversePrimary: $inversePrimary, shadow: $shadow, scrim: $scrim, surfaceTint: $surfaceTint)';
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
            (identical(other.primaryFixed, primaryFixed) ||
                other.primaryFixed == primaryFixed) &&
            (identical(other.primaryFixedDim, primaryFixedDim) ||
                other.primaryFixedDim == primaryFixedDim) &&
            (identical(other.onPrimaryFixed, onPrimaryFixed) ||
                other.onPrimaryFixed == onPrimaryFixed) &&
            (identical(other.onPrimaryFixedVariant, onPrimaryFixedVariant) ||
                other.onPrimaryFixedVariant == onPrimaryFixedVariant) &&
            (identical(other.secondary, secondary) ||
                other.secondary == secondary) &&
            (identical(other.onSecondary, onSecondary) ||
                other.onSecondary == onSecondary) &&
            (identical(other.secondaryContainer, secondaryContainer) ||
                other.secondaryContainer == secondaryContainer) &&
            (identical(other.onSecondaryContainer, onSecondaryContainer) ||
                other.onSecondaryContainer == onSecondaryContainer) &&
            (identical(other.secondaryFixed, secondaryFixed) ||
                other.secondaryFixed == secondaryFixed) &&
            (identical(other.secondaryFixedDim, secondaryFixedDim) ||
                other.secondaryFixedDim == secondaryFixedDim) &&
            (identical(other.onSecondaryFixed, onSecondaryFixed) ||
                other.onSecondaryFixed == onSecondaryFixed) &&
            (identical(other.onSecondaryFixedVariant, onSecondaryFixedVariant) ||
                other.onSecondaryFixedVariant == onSecondaryFixedVariant) &&
            (identical(other.tertiary, tertiary) ||
                other.tertiary == tertiary) &&
            (identical(other.onTertiary, onTertiary) ||
                other.onTertiary == onTertiary) &&
            (identical(other.tertiaryContainer, tertiaryContainer) ||
                other.tertiaryContainer == tertiaryContainer) &&
            (identical(other.onTertiaryContainer, onTertiaryContainer) ||
                other.onTertiaryContainer == onTertiaryContainer) &&
            (identical(other.tertiaryFixed, tertiaryFixed) ||
                other.tertiaryFixed == tertiaryFixed) &&
            (identical(other.tertiaryFixedDim, tertiaryFixedDim) ||
                other.tertiaryFixedDim == tertiaryFixedDim) &&
            (identical(other.onTertiaryFixed, onTertiaryFixed) ||
                other.onTertiaryFixed == onTertiaryFixed) &&
            (identical(other.onTertiaryFixedVariant, onTertiaryFixedVariant) ||
                other.onTertiaryFixedVariant == onTertiaryFixedVariant) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.onError, onError) || other.onError == onError) &&
            (identical(other.errorContainer, errorContainer) ||
                other.errorContainer == errorContainer) &&
            (identical(other.onErrorContainer, onErrorContainer) ||
                other.onErrorContainer == onErrorContainer) &&
            (identical(other.outline, outline) || other.outline == outline) &&
            (identical(other.outlineVariant, outlineVariant) ||
                other.outlineVariant == outlineVariant) &&
            (identical(other.surface, surface) || other.surface == surface) &&
            (identical(other.onSurface, onSurface) ||
                other.onSurface == onSurface) &&
            (identical(other.surfaceDim, surfaceDim) ||
                other.surfaceDim == surfaceDim) &&
            (identical(other.surfaceBright, surfaceBright) ||
                other.surfaceBright == surfaceBright) &&
            (identical(other.surfaceContainerLowest, surfaceContainerLowest) ||
                other.surfaceContainerLowest == surfaceContainerLowest) &&
            (identical(other.surfaceContainerLow, surfaceContainerLow) ||
                other.surfaceContainerLow == surfaceContainerLow) &&
            (identical(other.surfaceContainer, surfaceContainer) ||
                other.surfaceContainer == surfaceContainer) &&
            (identical(other.surfaceContainerHigh, surfaceContainerHigh) ||
                other.surfaceContainerHigh == surfaceContainerHigh) &&
            (identical(other.surfaceContainerHighest, surfaceContainerHighest) ||
                other.surfaceContainerHighest == surfaceContainerHighest) &&
            (identical(other.onSurfaceVariant, onSurfaceVariant) ||
                other.onSurfaceVariant == onSurfaceVariant) &&
            (identical(other.inverseSurface, inverseSurface) ||
                other.inverseSurface == inverseSurface) &&
            (identical(other.onInverseSurface, onInverseSurface) ||
                other.onInverseSurface == onInverseSurface) &&
            (identical(other.inversePrimary, inversePrimary) || other.inversePrimary == inversePrimary) &&
            (identical(other.shadow, shadow) || other.shadow == shadow) &&
            (identical(other.scrim, scrim) || other.scrim == scrim) &&
            (identical(other.surfaceTint, surfaceTint) || other.surfaceTint == surfaceTint));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        primary,
        onPrimary,
        primaryContainer,
        onPrimaryContainer,
        primaryFixed,
        primaryFixedDim,
        onPrimaryFixed,
        onPrimaryFixedVariant,
        secondary,
        onSecondary,
        secondaryContainer,
        onSecondaryContainer,
        secondaryFixed,
        secondaryFixedDim,
        onSecondaryFixed,
        onSecondaryFixedVariant,
        tertiary,
        onTertiary,
        tertiaryContainer,
        onTertiaryContainer,
        tertiaryFixed,
        tertiaryFixedDim,
        onTertiaryFixed,
        onTertiaryFixedVariant,
        error,
        onError,
        errorContainer,
        onErrorContainer,
        outline,
        outlineVariant,
        surface,
        onSurface,
        surfaceDim,
        surfaceBright,
        surfaceContainerLowest,
        surfaceContainerLow,
        surfaceContainer,
        surfaceContainerHigh,
        surfaceContainerHighest,
        onSurfaceVariant,
        inverseSurface,
        onInverseSurface,
        inversePrimary,
        shadow,
        scrim,
        surfaceTint
      ]);

  /// Create a copy of ColorSchemeOverride
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      {final String primary,
      final String onPrimary,
      final String primaryContainer,
      final String onPrimaryContainer,
      final String primaryFixed,
      final String primaryFixedDim,
      final String onPrimaryFixed,
      final String onPrimaryFixedVariant,
      final String secondary,
      final String onSecondary,
      final String secondaryContainer,
      final String onSecondaryContainer,
      final String secondaryFixed,
      final String secondaryFixedDim,
      final String onSecondaryFixed,
      final String onSecondaryFixedVariant,
      final String tertiary,
      final String onTertiary,
      final String tertiaryContainer,
      final String onTertiaryContainer,
      final String tertiaryFixed,
      final String tertiaryFixedDim,
      final String onTertiaryFixed,
      final String onTertiaryFixedVariant,
      final String error,
      final String onError,
      final String errorContainer,
      final String onErrorContainer,
      final String outline,
      final String outlineVariant,
      final String surface,
      final String onSurface,
      final String surfaceDim,
      final String surfaceBright,
      final String surfaceContainerLowest,
      final String surfaceContainerLow,
      final String surfaceContainer,
      final String surfaceContainerHigh,
      final String surfaceContainerHighest,
      final String onSurfaceVariant,
      final String inverseSurface,
      final String onInverseSurface,
      final String inversePrimary,
      final String shadow,
      final String scrim,
      final String surfaceTint}) = _$ColorSchemeOverrideImpl;

  factory _ColorSchemeOverride.fromJson(Map<String, dynamic> json) =
      _$ColorSchemeOverrideImpl.fromJson;

  @override
  String get primary;
  @override
  String get onPrimary;
  @override
  String get primaryContainer;
  @override
  String get onPrimaryContainer;
  @override
  String get primaryFixed;
  @override
  String get primaryFixedDim;
  @override
  String get onPrimaryFixed;
  @override
  String get onPrimaryFixedVariant;
  @override
  String get secondary;
  @override
  String get onSecondary;
  @override
  String get secondaryContainer;
  @override
  String get onSecondaryContainer;
  @override
  String get secondaryFixed;
  @override
  String get secondaryFixedDim;
  @override
  String get onSecondaryFixed;
  @override
  String get onSecondaryFixedVariant;
  @override
  String get tertiary;
  @override
  String get onTertiary;
  @override
  String get tertiaryContainer;
  @override
  String get onTertiaryContainer;
  @override
  String get tertiaryFixed;
  @override
  String get tertiaryFixedDim;
  @override
  String get onTertiaryFixed;
  @override
  String get onTertiaryFixedVariant;
  @override
  String get error;
  @override
  String get onError;
  @override
  String get errorContainer;
  @override
  String get onErrorContainer;
  @override
  String get outline;
  @override
  String get outlineVariant;
  @override
  String get surface;
  @override
  String get onSurface;
  @override
  String get surfaceDim;
  @override
  String get surfaceBright;
  @override
  String get surfaceContainerLowest;
  @override
  String get surfaceContainerLow;
  @override
  String get surfaceContainer;
  @override
  String get surfaceContainerHigh;
  @override
  String get surfaceContainerHighest;
  @override
  String get onSurfaceVariant;
  @override
  String get inverseSurface;
  @override
  String get onInverseSurface;
  @override
  String get inversePrimary;
  @override
  String get shadow;
  @override
  String get scrim;
  @override
  String get surfaceTint;

  /// Create a copy of ColorSchemeOverride
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ColorSchemeOverrideImplCopyWith<_$ColorSchemeOverrideImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
