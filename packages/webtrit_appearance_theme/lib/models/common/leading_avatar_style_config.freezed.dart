// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leading_avatar_style_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LeadingAvatarStyleConfig {

 String? get backgroundColor; double? get radius; TextStyleConfig? get initialsTextStyle; IconDataConfig? get placeholderIcon; LoadingOverlayStyleConfig? get loading; SmartIndicatorStyleConfig? get smartIndicator; RegisteredBadgeStyleConfig? get registeredBadge; PresenceBadgeStyleConfig? get presenceBadge;
/// Create a copy of LeadingAvatarStyleConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LeadingAvatarStyleConfigCopyWith<LeadingAvatarStyleConfig> get copyWith => _$LeadingAvatarStyleConfigCopyWithImpl<LeadingAvatarStyleConfig>(this as LeadingAvatarStyleConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LeadingAvatarStyleConfig&&(identical(other.backgroundColor, backgroundColor) || other.backgroundColor == backgroundColor)&&(identical(other.radius, radius) || other.radius == radius)&&(identical(other.initialsTextStyle, initialsTextStyle) || other.initialsTextStyle == initialsTextStyle)&&(identical(other.placeholderIcon, placeholderIcon) || other.placeholderIcon == placeholderIcon)&&(identical(other.loading, loading) || other.loading == loading)&&(identical(other.smartIndicator, smartIndicator) || other.smartIndicator == smartIndicator)&&(identical(other.registeredBadge, registeredBadge) || other.registeredBadge == registeredBadge)&&(identical(other.presenceBadge, presenceBadge) || other.presenceBadge == presenceBadge));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,backgroundColor,radius,initialsTextStyle,placeholderIcon,loading,smartIndicator,registeredBadge,presenceBadge);

@override
String toString() {
  return 'LeadingAvatarStyleConfig(backgroundColor: $backgroundColor, radius: $radius, initialsTextStyle: $initialsTextStyle, placeholderIcon: $placeholderIcon, loading: $loading, smartIndicator: $smartIndicator, registeredBadge: $registeredBadge, presenceBadge: $presenceBadge)';
}


}

/// @nodoc
abstract mixin class $LeadingAvatarStyleConfigCopyWith<$Res>  {
  factory $LeadingAvatarStyleConfigCopyWith(LeadingAvatarStyleConfig value, $Res Function(LeadingAvatarStyleConfig) _then) = _$LeadingAvatarStyleConfigCopyWithImpl;
@useResult
$Res call({
 String? backgroundColor, double? radius, TextStyleConfig? initialsTextStyle, IconDataConfig? placeholderIcon, LoadingOverlayStyleConfig? loading, SmartIndicatorStyleConfig? smartIndicator, RegisteredBadgeStyleConfig? registeredBadge, PresenceBadgeStyleConfig? presenceBadge
});




}
/// @nodoc
class _$LeadingAvatarStyleConfigCopyWithImpl<$Res>
    implements $LeadingAvatarStyleConfigCopyWith<$Res> {
  _$LeadingAvatarStyleConfigCopyWithImpl(this._self, this._then);

  final LeadingAvatarStyleConfig _self;
  final $Res Function(LeadingAvatarStyleConfig) _then;

/// Create a copy of LeadingAvatarStyleConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? backgroundColor = freezed,Object? radius = freezed,Object? initialsTextStyle = freezed,Object? placeholderIcon = freezed,Object? loading = freezed,Object? smartIndicator = freezed,Object? registeredBadge = freezed,Object? presenceBadge = freezed,}) {
  return _then(LeadingAvatarStyleConfig(
backgroundColor: freezed == backgroundColor ? _self.backgroundColor : backgroundColor // ignore: cast_nullable_to_non_nullable
as String?,radius: freezed == radius ? _self.radius : radius // ignore: cast_nullable_to_non_nullable
as double?,initialsTextStyle: freezed == initialsTextStyle ? _self.initialsTextStyle : initialsTextStyle // ignore: cast_nullable_to_non_nullable
as TextStyleConfig?,placeholderIcon: freezed == placeholderIcon ? _self.placeholderIcon : placeholderIcon // ignore: cast_nullable_to_non_nullable
as IconDataConfig?,loading: freezed == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as LoadingOverlayStyleConfig?,smartIndicator: freezed == smartIndicator ? _self.smartIndicator : smartIndicator // ignore: cast_nullable_to_non_nullable
as SmartIndicatorStyleConfig?,registeredBadge: freezed == registeredBadge ? _self.registeredBadge : registeredBadge // ignore: cast_nullable_to_non_nullable
as RegisteredBadgeStyleConfig?,presenceBadge: freezed == presenceBadge ? _self.presenceBadge : presenceBadge // ignore: cast_nullable_to_non_nullable
as PresenceBadgeStyleConfig?,
  ));
}

}


/// Adds pattern-matching-related methods to [LeadingAvatarStyleConfig].
extension LeadingAvatarStyleConfigPatterns on LeadingAvatarStyleConfig {
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
mixin _$LoadingOverlayStyleConfig {

 bool get showByDefault; PaddingConfig get padding; double? get strokeWidth;
/// Create a copy of LoadingOverlayStyleConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadingOverlayStyleConfigCopyWith<LoadingOverlayStyleConfig> get copyWith => _$LoadingOverlayStyleConfigCopyWithImpl<LoadingOverlayStyleConfig>(this as LoadingOverlayStyleConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadingOverlayStyleConfig&&(identical(other.showByDefault, showByDefault) || other.showByDefault == showByDefault)&&(identical(other.padding, padding) || other.padding == padding)&&(identical(other.strokeWidth, strokeWidth) || other.strokeWidth == strokeWidth));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,showByDefault,padding,strokeWidth);

@override
String toString() {
  return 'LoadingOverlayStyleConfig(showByDefault: $showByDefault, padding: $padding, strokeWidth: $strokeWidth)';
}


}

/// @nodoc
abstract mixin class $LoadingOverlayStyleConfigCopyWith<$Res>  {
  factory $LoadingOverlayStyleConfigCopyWith(LoadingOverlayStyleConfig value, $Res Function(LoadingOverlayStyleConfig) _then) = _$LoadingOverlayStyleConfigCopyWithImpl;
@useResult
$Res call({
 bool showByDefault, PaddingConfig padding, double? strokeWidth
});




}
/// @nodoc
class _$LoadingOverlayStyleConfigCopyWithImpl<$Res>
    implements $LoadingOverlayStyleConfigCopyWith<$Res> {
  _$LoadingOverlayStyleConfigCopyWithImpl(this._self, this._then);

  final LoadingOverlayStyleConfig _self;
  final $Res Function(LoadingOverlayStyleConfig) _then;

/// Create a copy of LoadingOverlayStyleConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? showByDefault = null,Object? padding = null,Object? strokeWidth = freezed,}) {
  return _then(LoadingOverlayStyleConfig(
showByDefault: null == showByDefault ? _self.showByDefault : showByDefault // ignore: cast_nullable_to_non_nullable
as bool,padding: null == padding ? _self.padding : padding // ignore: cast_nullable_to_non_nullable
as PaddingConfig,strokeWidth: freezed == strokeWidth ? _self.strokeWidth : strokeWidth // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [LoadingOverlayStyleConfig].
extension LoadingOverlayStyleConfigPatterns on LoadingOverlayStyleConfig {
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
mixin _$SmartIndicatorStyleConfig {

 String? get backgroundColor; IconDataConfig? get icon; double? get sizeFactor;
/// Create a copy of SmartIndicatorStyleConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SmartIndicatorStyleConfigCopyWith<SmartIndicatorStyleConfig> get copyWith => _$SmartIndicatorStyleConfigCopyWithImpl<SmartIndicatorStyleConfig>(this as SmartIndicatorStyleConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SmartIndicatorStyleConfig&&(identical(other.backgroundColor, backgroundColor) || other.backgroundColor == backgroundColor)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.sizeFactor, sizeFactor) || other.sizeFactor == sizeFactor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,backgroundColor,icon,sizeFactor);

@override
String toString() {
  return 'SmartIndicatorStyleConfig(backgroundColor: $backgroundColor, icon: $icon, sizeFactor: $sizeFactor)';
}


}

/// @nodoc
abstract mixin class $SmartIndicatorStyleConfigCopyWith<$Res>  {
  factory $SmartIndicatorStyleConfigCopyWith(SmartIndicatorStyleConfig value, $Res Function(SmartIndicatorStyleConfig) _then) = _$SmartIndicatorStyleConfigCopyWithImpl;
@useResult
$Res call({
 String? backgroundColor, IconDataConfig? icon, double? sizeFactor
});




}
/// @nodoc
class _$SmartIndicatorStyleConfigCopyWithImpl<$Res>
    implements $SmartIndicatorStyleConfigCopyWith<$Res> {
  _$SmartIndicatorStyleConfigCopyWithImpl(this._self, this._then);

  final SmartIndicatorStyleConfig _self;
  final $Res Function(SmartIndicatorStyleConfig) _then;

/// Create a copy of SmartIndicatorStyleConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? backgroundColor = freezed,Object? icon = freezed,Object? sizeFactor = freezed,}) {
  return _then(SmartIndicatorStyleConfig(
backgroundColor: freezed == backgroundColor ? _self.backgroundColor : backgroundColor // ignore: cast_nullable_to_non_nullable
as String?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as IconDataConfig?,sizeFactor: freezed == sizeFactor ? _self.sizeFactor : sizeFactor // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [SmartIndicatorStyleConfig].
extension SmartIndicatorStyleConfigPatterns on SmartIndicatorStyleConfig {
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
mixin _$RegisteredBadgeStyleConfig {

 String? get registeredColor; String? get unregisteredColor; double? get sizeFactor;
/// Create a copy of RegisteredBadgeStyleConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisteredBadgeStyleConfigCopyWith<RegisteredBadgeStyleConfig> get copyWith => _$RegisteredBadgeStyleConfigCopyWithImpl<RegisteredBadgeStyleConfig>(this as RegisteredBadgeStyleConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisteredBadgeStyleConfig&&(identical(other.registeredColor, registeredColor) || other.registeredColor == registeredColor)&&(identical(other.unregisteredColor, unregisteredColor) || other.unregisteredColor == unregisteredColor)&&(identical(other.sizeFactor, sizeFactor) || other.sizeFactor == sizeFactor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,registeredColor,unregisteredColor,sizeFactor);

@override
String toString() {
  return 'RegisteredBadgeStyleConfig(registeredColor: $registeredColor, unregisteredColor: $unregisteredColor, sizeFactor: $sizeFactor)';
}


}

/// @nodoc
abstract mixin class $RegisteredBadgeStyleConfigCopyWith<$Res>  {
  factory $RegisteredBadgeStyleConfigCopyWith(RegisteredBadgeStyleConfig value, $Res Function(RegisteredBadgeStyleConfig) _then) = _$RegisteredBadgeStyleConfigCopyWithImpl;
@useResult
$Res call({
 String? registeredColor, String? unregisteredColor, double? sizeFactor
});




}
/// @nodoc
class _$RegisteredBadgeStyleConfigCopyWithImpl<$Res>
    implements $RegisteredBadgeStyleConfigCopyWith<$Res> {
  _$RegisteredBadgeStyleConfigCopyWithImpl(this._self, this._then);

  final RegisteredBadgeStyleConfig _self;
  final $Res Function(RegisteredBadgeStyleConfig) _then;

/// Create a copy of RegisteredBadgeStyleConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? registeredColor = freezed,Object? unregisteredColor = freezed,Object? sizeFactor = freezed,}) {
  return _then(RegisteredBadgeStyleConfig(
registeredColor: freezed == registeredColor ? _self.registeredColor : registeredColor // ignore: cast_nullable_to_non_nullable
as String?,unregisteredColor: freezed == unregisteredColor ? _self.unregisteredColor : unregisteredColor // ignore: cast_nullable_to_non_nullable
as String?,sizeFactor: freezed == sizeFactor ? _self.sizeFactor : sizeFactor // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [RegisteredBadgeStyleConfig].
extension RegisteredBadgeStyleConfigPatterns on RegisteredBadgeStyleConfig {
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
mixin _$PresenceBadgeStyleConfig {

 String? get availableColor; String? get unavailableColor; double? get sizeFactor;
/// Create a copy of PresenceBadgeStyleConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PresenceBadgeStyleConfigCopyWith<PresenceBadgeStyleConfig> get copyWith => _$PresenceBadgeStyleConfigCopyWithImpl<PresenceBadgeStyleConfig>(this as PresenceBadgeStyleConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PresenceBadgeStyleConfig&&(identical(other.availableColor, availableColor) || other.availableColor == availableColor)&&(identical(other.unavailableColor, unavailableColor) || other.unavailableColor == unavailableColor)&&(identical(other.sizeFactor, sizeFactor) || other.sizeFactor == sizeFactor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,availableColor,unavailableColor,sizeFactor);

@override
String toString() {
  return 'PresenceBadgeStyleConfig(availableColor: $availableColor, unavailableColor: $unavailableColor, sizeFactor: $sizeFactor)';
}


}

/// @nodoc
abstract mixin class $PresenceBadgeStyleConfigCopyWith<$Res>  {
  factory $PresenceBadgeStyleConfigCopyWith(PresenceBadgeStyleConfig value, $Res Function(PresenceBadgeStyleConfig) _then) = _$PresenceBadgeStyleConfigCopyWithImpl;
@useResult
$Res call({
 String? availableColor, String? unavailableColor, double? sizeFactor
});




}
/// @nodoc
class _$PresenceBadgeStyleConfigCopyWithImpl<$Res>
    implements $PresenceBadgeStyleConfigCopyWith<$Res> {
  _$PresenceBadgeStyleConfigCopyWithImpl(this._self, this._then);

  final PresenceBadgeStyleConfig _self;
  final $Res Function(PresenceBadgeStyleConfig) _then;

/// Create a copy of PresenceBadgeStyleConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? availableColor = freezed,Object? unavailableColor = freezed,Object? sizeFactor = freezed,}) {
  return _then(PresenceBadgeStyleConfig(
availableColor: freezed == availableColor ? _self.availableColor : availableColor // ignore: cast_nullable_to_non_nullable
as String?,unavailableColor: freezed == unavailableColor ? _self.unavailableColor : unavailableColor // ignore: cast_nullable_to_non_nullable
as String?,sizeFactor: freezed == sizeFactor ? _self.sizeFactor : sizeFactor // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [PresenceBadgeStyleConfig].
extension PresenceBadgeStyleConfigPatterns on PresenceBadgeStyleConfig {
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
