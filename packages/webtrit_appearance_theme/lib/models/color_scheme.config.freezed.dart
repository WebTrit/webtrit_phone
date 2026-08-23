// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'color_scheme.config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ColorSchemeConfig {

 String get seedColor; ColorSchemeOverride get colorSchemeOverride;
/// Create a copy of ColorSchemeConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ColorSchemeConfigCopyWith<ColorSchemeConfig> get copyWith => _$ColorSchemeConfigCopyWithImpl<ColorSchemeConfig>(this as ColorSchemeConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ColorSchemeConfig&&(identical(other.seedColor, seedColor) || other.seedColor == seedColor)&&(identical(other.colorSchemeOverride, colorSchemeOverride) || other.colorSchemeOverride == colorSchemeOverride));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,seedColor,colorSchemeOverride);

@override
String toString() {
  return 'ColorSchemeConfig(seedColor: $seedColor, colorSchemeOverride: $colorSchemeOverride)';
}


}

/// @nodoc
abstract mixin class $ColorSchemeConfigCopyWith<$Res>  {
  factory $ColorSchemeConfigCopyWith(ColorSchemeConfig value, $Res Function(ColorSchemeConfig) _then) = _$ColorSchemeConfigCopyWithImpl;
@useResult
$Res call({
 String seedColor, ColorSchemeOverride colorSchemeOverride
});




}
/// @nodoc
class _$ColorSchemeConfigCopyWithImpl<$Res>
    implements $ColorSchemeConfigCopyWith<$Res> {
  _$ColorSchemeConfigCopyWithImpl(this._self, this._then);

  final ColorSchemeConfig _self;
  final $Res Function(ColorSchemeConfig) _then;

/// Create a copy of ColorSchemeConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? seedColor = null,Object? colorSchemeOverride = null,}) {
  return _then(ColorSchemeConfig(
seedColor: null == seedColor ? _self.seedColor : seedColor // ignore: cast_nullable_to_non_nullable
as String,colorSchemeOverride: null == colorSchemeOverride ? _self.colorSchemeOverride : colorSchemeOverride // ignore: cast_nullable_to_non_nullable
as ColorSchemeOverride,
  ));
}

}


/// Adds pattern-matching-related methods to [ColorSchemeConfig].
extension ColorSchemeConfigPatterns on ColorSchemeConfig {
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


/// @nodoc
mixin _$ColorSchemeOverride {

 String? get primary; String? get onPrimary; String? get primaryContainer; String? get onPrimaryContainer; String? get primaryFixed; String? get primaryFixedDim; String? get onPrimaryFixed; String? get onPrimaryFixedVariant; String? get secondary; String? get onSecondary; String? get secondaryContainer; String? get onSecondaryContainer; String? get secondaryFixed; String? get secondaryFixedDim; String? get onSecondaryFixed; String? get onSecondaryFixedVariant; String? get tertiary; String? get onTertiary; String? get tertiaryContainer; String? get onTertiaryContainer; String? get tertiaryFixed; String? get tertiaryFixedDim; String? get onTertiaryFixed; String? get onTertiaryFixedVariant; String? get error; String? get onError; String? get errorContainer; String? get onErrorContainer; String? get outline; String? get outlineVariant; String? get surface; String? get onSurface; String? get surfaceDim; String? get surfaceBright; String? get surfaceContainerLowest; String? get surfaceContainerLow; String? get surfaceContainer; String? get surfaceContainerHigh; String? get surfaceContainerHighest; String? get onSurfaceVariant; String? get inverseSurface; String? get onInverseSurface; String? get inversePrimary; String? get shadow; String? get scrim; String? get surfaceTint;
/// Create a copy of ColorSchemeOverride
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ColorSchemeOverrideCopyWith<ColorSchemeOverride> get copyWith => _$ColorSchemeOverrideCopyWithImpl<ColorSchemeOverride>(this as ColorSchemeOverride, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ColorSchemeOverride&&(identical(other.primary, primary) || other.primary == primary)&&(identical(other.onPrimary, onPrimary) || other.onPrimary == onPrimary)&&(identical(other.primaryContainer, primaryContainer) || other.primaryContainer == primaryContainer)&&(identical(other.onPrimaryContainer, onPrimaryContainer) || other.onPrimaryContainer == onPrimaryContainer)&&(identical(other.primaryFixed, primaryFixed) || other.primaryFixed == primaryFixed)&&(identical(other.primaryFixedDim, primaryFixedDim) || other.primaryFixedDim == primaryFixedDim)&&(identical(other.onPrimaryFixed, onPrimaryFixed) || other.onPrimaryFixed == onPrimaryFixed)&&(identical(other.onPrimaryFixedVariant, onPrimaryFixedVariant) || other.onPrimaryFixedVariant == onPrimaryFixedVariant)&&(identical(other.secondary, secondary) || other.secondary == secondary)&&(identical(other.onSecondary, onSecondary) || other.onSecondary == onSecondary)&&(identical(other.secondaryContainer, secondaryContainer) || other.secondaryContainer == secondaryContainer)&&(identical(other.onSecondaryContainer, onSecondaryContainer) || other.onSecondaryContainer == onSecondaryContainer)&&(identical(other.secondaryFixed, secondaryFixed) || other.secondaryFixed == secondaryFixed)&&(identical(other.secondaryFixedDim, secondaryFixedDim) || other.secondaryFixedDim == secondaryFixedDim)&&(identical(other.onSecondaryFixed, onSecondaryFixed) || other.onSecondaryFixed == onSecondaryFixed)&&(identical(other.onSecondaryFixedVariant, onSecondaryFixedVariant) || other.onSecondaryFixedVariant == onSecondaryFixedVariant)&&(identical(other.tertiary, tertiary) || other.tertiary == tertiary)&&(identical(other.onTertiary, onTertiary) || other.onTertiary == onTertiary)&&(identical(other.tertiaryContainer, tertiaryContainer) || other.tertiaryContainer == tertiaryContainer)&&(identical(other.onTertiaryContainer, onTertiaryContainer) || other.onTertiaryContainer == onTertiaryContainer)&&(identical(other.tertiaryFixed, tertiaryFixed) || other.tertiaryFixed == tertiaryFixed)&&(identical(other.tertiaryFixedDim, tertiaryFixedDim) || other.tertiaryFixedDim == tertiaryFixedDim)&&(identical(other.onTertiaryFixed, onTertiaryFixed) || other.onTertiaryFixed == onTertiaryFixed)&&(identical(other.onTertiaryFixedVariant, onTertiaryFixedVariant) || other.onTertiaryFixedVariant == onTertiaryFixedVariant)&&(identical(other.error, error) || other.error == error)&&(identical(other.onError, onError) || other.onError == onError)&&(identical(other.errorContainer, errorContainer) || other.errorContainer == errorContainer)&&(identical(other.onErrorContainer, onErrorContainer) || other.onErrorContainer == onErrorContainer)&&(identical(other.outline, outline) || other.outline == outline)&&(identical(other.outlineVariant, outlineVariant) || other.outlineVariant == outlineVariant)&&(identical(other.surface, surface) || other.surface == surface)&&(identical(other.onSurface, onSurface) || other.onSurface == onSurface)&&(identical(other.surfaceDim, surfaceDim) || other.surfaceDim == surfaceDim)&&(identical(other.surfaceBright, surfaceBright) || other.surfaceBright == surfaceBright)&&(identical(other.surfaceContainerLowest, surfaceContainerLowest) || other.surfaceContainerLowest == surfaceContainerLowest)&&(identical(other.surfaceContainerLow, surfaceContainerLow) || other.surfaceContainerLow == surfaceContainerLow)&&(identical(other.surfaceContainer, surfaceContainer) || other.surfaceContainer == surfaceContainer)&&(identical(other.surfaceContainerHigh, surfaceContainerHigh) || other.surfaceContainerHigh == surfaceContainerHigh)&&(identical(other.surfaceContainerHighest, surfaceContainerHighest) || other.surfaceContainerHighest == surfaceContainerHighest)&&(identical(other.onSurfaceVariant, onSurfaceVariant) || other.onSurfaceVariant == onSurfaceVariant)&&(identical(other.inverseSurface, inverseSurface) || other.inverseSurface == inverseSurface)&&(identical(other.onInverseSurface, onInverseSurface) || other.onInverseSurface == onInverseSurface)&&(identical(other.inversePrimary, inversePrimary) || other.inversePrimary == inversePrimary)&&(identical(other.shadow, shadow) || other.shadow == shadow)&&(identical(other.scrim, scrim) || other.scrim == scrim)&&(identical(other.surfaceTint, surfaceTint) || other.surfaceTint == surfaceTint));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,primary,onPrimary,primaryContainer,onPrimaryContainer,primaryFixed,primaryFixedDim,onPrimaryFixed,onPrimaryFixedVariant,secondary,onSecondary,secondaryContainer,onSecondaryContainer,secondaryFixed,secondaryFixedDim,onSecondaryFixed,onSecondaryFixedVariant,tertiary,onTertiary,tertiaryContainer,onTertiaryContainer,tertiaryFixed,tertiaryFixedDim,onTertiaryFixed,onTertiaryFixedVariant,error,onError,errorContainer,onErrorContainer,outline,outlineVariant,surface,onSurface,surfaceDim,surfaceBright,surfaceContainerLowest,surfaceContainerLow,surfaceContainer,surfaceContainerHigh,surfaceContainerHighest,onSurfaceVariant,inverseSurface,onInverseSurface,inversePrimary,shadow,scrim,surfaceTint]);

@override
String toString() {
  return 'ColorSchemeOverride(primary: $primary, onPrimary: $onPrimary, primaryContainer: $primaryContainer, onPrimaryContainer: $onPrimaryContainer, primaryFixed: $primaryFixed, primaryFixedDim: $primaryFixedDim, onPrimaryFixed: $onPrimaryFixed, onPrimaryFixedVariant: $onPrimaryFixedVariant, secondary: $secondary, onSecondary: $onSecondary, secondaryContainer: $secondaryContainer, onSecondaryContainer: $onSecondaryContainer, secondaryFixed: $secondaryFixed, secondaryFixedDim: $secondaryFixedDim, onSecondaryFixed: $onSecondaryFixed, onSecondaryFixedVariant: $onSecondaryFixedVariant, tertiary: $tertiary, onTertiary: $onTertiary, tertiaryContainer: $tertiaryContainer, onTertiaryContainer: $onTertiaryContainer, tertiaryFixed: $tertiaryFixed, tertiaryFixedDim: $tertiaryFixedDim, onTertiaryFixed: $onTertiaryFixed, onTertiaryFixedVariant: $onTertiaryFixedVariant, error: $error, onError: $onError, errorContainer: $errorContainer, onErrorContainer: $onErrorContainer, outline: $outline, outlineVariant: $outlineVariant, surface: $surface, onSurface: $onSurface, surfaceDim: $surfaceDim, surfaceBright: $surfaceBright, surfaceContainerLowest: $surfaceContainerLowest, surfaceContainerLow: $surfaceContainerLow, surfaceContainer: $surfaceContainer, surfaceContainerHigh: $surfaceContainerHigh, surfaceContainerHighest: $surfaceContainerHighest, onSurfaceVariant: $onSurfaceVariant, inverseSurface: $inverseSurface, onInverseSurface: $onInverseSurface, inversePrimary: $inversePrimary, shadow: $shadow, scrim: $scrim, surfaceTint: $surfaceTint)';
}


}

/// @nodoc
abstract mixin class $ColorSchemeOverrideCopyWith<$Res>  {
  factory $ColorSchemeOverrideCopyWith(ColorSchemeOverride value, $Res Function(ColorSchemeOverride) _then) = _$ColorSchemeOverrideCopyWithImpl;
@useResult
$Res call({
 String? primary, String? onPrimary, String? primaryContainer, String? onPrimaryContainer, String? primaryFixed, String? primaryFixedDim, String? onPrimaryFixed, String? onPrimaryFixedVariant, String? secondary, String? onSecondary, String? secondaryContainer, String? onSecondaryContainer, String? secondaryFixed, String? secondaryFixedDim, String? onSecondaryFixed, String? onSecondaryFixedVariant, String? tertiary, String? onTertiary, String? tertiaryContainer, String? onTertiaryContainer, String? tertiaryFixed, String? tertiaryFixedDim, String? onTertiaryFixed, String? onTertiaryFixedVariant, String? error, String? onError, String? errorContainer, String? onErrorContainer, String? outline, String? outlineVariant, String? surface, String? onSurface, String? surfaceDim, String? surfaceBright, String? surfaceContainerLowest, String? surfaceContainerLow, String? surfaceContainer, String? surfaceContainerHigh, String? surfaceContainerHighest, String? onSurfaceVariant, String? inverseSurface, String? onInverseSurface, String? inversePrimary, String? shadow, String? scrim, String? surfaceTint
});




}
/// @nodoc
class _$ColorSchemeOverrideCopyWithImpl<$Res>
    implements $ColorSchemeOverrideCopyWith<$Res> {
  _$ColorSchemeOverrideCopyWithImpl(this._self, this._then);

  final ColorSchemeOverride _self;
  final $Res Function(ColorSchemeOverride) _then;

/// Create a copy of ColorSchemeOverride
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? primary = freezed,Object? onPrimary = freezed,Object? primaryContainer = freezed,Object? onPrimaryContainer = freezed,Object? primaryFixed = freezed,Object? primaryFixedDim = freezed,Object? onPrimaryFixed = freezed,Object? onPrimaryFixedVariant = freezed,Object? secondary = freezed,Object? onSecondary = freezed,Object? secondaryContainer = freezed,Object? onSecondaryContainer = freezed,Object? secondaryFixed = freezed,Object? secondaryFixedDim = freezed,Object? onSecondaryFixed = freezed,Object? onSecondaryFixedVariant = freezed,Object? tertiary = freezed,Object? onTertiary = freezed,Object? tertiaryContainer = freezed,Object? onTertiaryContainer = freezed,Object? tertiaryFixed = freezed,Object? tertiaryFixedDim = freezed,Object? onTertiaryFixed = freezed,Object? onTertiaryFixedVariant = freezed,Object? error = freezed,Object? onError = freezed,Object? errorContainer = freezed,Object? onErrorContainer = freezed,Object? outline = freezed,Object? outlineVariant = freezed,Object? surface = freezed,Object? onSurface = freezed,Object? surfaceDim = freezed,Object? surfaceBright = freezed,Object? surfaceContainerLowest = freezed,Object? surfaceContainerLow = freezed,Object? surfaceContainer = freezed,Object? surfaceContainerHigh = freezed,Object? surfaceContainerHighest = freezed,Object? onSurfaceVariant = freezed,Object? inverseSurface = freezed,Object? onInverseSurface = freezed,Object? inversePrimary = freezed,Object? shadow = freezed,Object? scrim = freezed,Object? surfaceTint = freezed,}) {
  return _then(ColorSchemeOverride(
primary: freezed == primary ? _self.primary : primary // ignore: cast_nullable_to_non_nullable
as String?,onPrimary: freezed == onPrimary ? _self.onPrimary : onPrimary // ignore: cast_nullable_to_non_nullable
as String?,primaryContainer: freezed == primaryContainer ? _self.primaryContainer : primaryContainer // ignore: cast_nullable_to_non_nullable
as String?,onPrimaryContainer: freezed == onPrimaryContainer ? _self.onPrimaryContainer : onPrimaryContainer // ignore: cast_nullable_to_non_nullable
as String?,primaryFixed: freezed == primaryFixed ? _self.primaryFixed : primaryFixed // ignore: cast_nullable_to_non_nullable
as String?,primaryFixedDim: freezed == primaryFixedDim ? _self.primaryFixedDim : primaryFixedDim // ignore: cast_nullable_to_non_nullable
as String?,onPrimaryFixed: freezed == onPrimaryFixed ? _self.onPrimaryFixed : onPrimaryFixed // ignore: cast_nullable_to_non_nullable
as String?,onPrimaryFixedVariant: freezed == onPrimaryFixedVariant ? _self.onPrimaryFixedVariant : onPrimaryFixedVariant // ignore: cast_nullable_to_non_nullable
as String?,secondary: freezed == secondary ? _self.secondary : secondary // ignore: cast_nullable_to_non_nullable
as String?,onSecondary: freezed == onSecondary ? _self.onSecondary : onSecondary // ignore: cast_nullable_to_non_nullable
as String?,secondaryContainer: freezed == secondaryContainer ? _self.secondaryContainer : secondaryContainer // ignore: cast_nullable_to_non_nullable
as String?,onSecondaryContainer: freezed == onSecondaryContainer ? _self.onSecondaryContainer : onSecondaryContainer // ignore: cast_nullable_to_non_nullable
as String?,secondaryFixed: freezed == secondaryFixed ? _self.secondaryFixed : secondaryFixed // ignore: cast_nullable_to_non_nullable
as String?,secondaryFixedDim: freezed == secondaryFixedDim ? _self.secondaryFixedDim : secondaryFixedDim // ignore: cast_nullable_to_non_nullable
as String?,onSecondaryFixed: freezed == onSecondaryFixed ? _self.onSecondaryFixed : onSecondaryFixed // ignore: cast_nullable_to_non_nullable
as String?,onSecondaryFixedVariant: freezed == onSecondaryFixedVariant ? _self.onSecondaryFixedVariant : onSecondaryFixedVariant // ignore: cast_nullable_to_non_nullable
as String?,tertiary: freezed == tertiary ? _self.tertiary : tertiary // ignore: cast_nullable_to_non_nullable
as String?,onTertiary: freezed == onTertiary ? _self.onTertiary : onTertiary // ignore: cast_nullable_to_non_nullable
as String?,tertiaryContainer: freezed == tertiaryContainer ? _self.tertiaryContainer : tertiaryContainer // ignore: cast_nullable_to_non_nullable
as String?,onTertiaryContainer: freezed == onTertiaryContainer ? _self.onTertiaryContainer : onTertiaryContainer // ignore: cast_nullable_to_non_nullable
as String?,tertiaryFixed: freezed == tertiaryFixed ? _self.tertiaryFixed : tertiaryFixed // ignore: cast_nullable_to_non_nullable
as String?,tertiaryFixedDim: freezed == tertiaryFixedDim ? _self.tertiaryFixedDim : tertiaryFixedDim // ignore: cast_nullable_to_non_nullable
as String?,onTertiaryFixed: freezed == onTertiaryFixed ? _self.onTertiaryFixed : onTertiaryFixed // ignore: cast_nullable_to_non_nullable
as String?,onTertiaryFixedVariant: freezed == onTertiaryFixedVariant ? _self.onTertiaryFixedVariant : onTertiaryFixedVariant // ignore: cast_nullable_to_non_nullable
as String?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,onError: freezed == onError ? _self.onError : onError // ignore: cast_nullable_to_non_nullable
as String?,errorContainer: freezed == errorContainer ? _self.errorContainer : errorContainer // ignore: cast_nullable_to_non_nullable
as String?,onErrorContainer: freezed == onErrorContainer ? _self.onErrorContainer : onErrorContainer // ignore: cast_nullable_to_non_nullable
as String?,outline: freezed == outline ? _self.outline : outline // ignore: cast_nullable_to_non_nullable
as String?,outlineVariant: freezed == outlineVariant ? _self.outlineVariant : outlineVariant // ignore: cast_nullable_to_non_nullable
as String?,surface: freezed == surface ? _self.surface : surface // ignore: cast_nullable_to_non_nullable
as String?,onSurface: freezed == onSurface ? _self.onSurface : onSurface // ignore: cast_nullable_to_non_nullable
as String?,surfaceDim: freezed == surfaceDim ? _self.surfaceDim : surfaceDim // ignore: cast_nullable_to_non_nullable
as String?,surfaceBright: freezed == surfaceBright ? _self.surfaceBright : surfaceBright // ignore: cast_nullable_to_non_nullable
as String?,surfaceContainerLowest: freezed == surfaceContainerLowest ? _self.surfaceContainerLowest : surfaceContainerLowest // ignore: cast_nullable_to_non_nullable
as String?,surfaceContainerLow: freezed == surfaceContainerLow ? _self.surfaceContainerLow : surfaceContainerLow // ignore: cast_nullable_to_non_nullable
as String?,surfaceContainer: freezed == surfaceContainer ? _self.surfaceContainer : surfaceContainer // ignore: cast_nullable_to_non_nullable
as String?,surfaceContainerHigh: freezed == surfaceContainerHigh ? _self.surfaceContainerHigh : surfaceContainerHigh // ignore: cast_nullable_to_non_nullable
as String?,surfaceContainerHighest: freezed == surfaceContainerHighest ? _self.surfaceContainerHighest : surfaceContainerHighest // ignore: cast_nullable_to_non_nullable
as String?,onSurfaceVariant: freezed == onSurfaceVariant ? _self.onSurfaceVariant : onSurfaceVariant // ignore: cast_nullable_to_non_nullable
as String?,inverseSurface: freezed == inverseSurface ? _self.inverseSurface : inverseSurface // ignore: cast_nullable_to_non_nullable
as String?,onInverseSurface: freezed == onInverseSurface ? _self.onInverseSurface : onInverseSurface // ignore: cast_nullable_to_non_nullable
as String?,inversePrimary: freezed == inversePrimary ? _self.inversePrimary : inversePrimary // ignore: cast_nullable_to_non_nullable
as String?,shadow: freezed == shadow ? _self.shadow : shadow // ignore: cast_nullable_to_non_nullable
as String?,scrim: freezed == scrim ? _self.scrim : scrim // ignore: cast_nullable_to_non_nullable
as String?,surfaceTint: freezed == surfaceTint ? _self.surfaceTint : surfaceTint // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ColorSchemeOverride].
extension ColorSchemeOverridePatterns on ColorSchemeOverride {
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
