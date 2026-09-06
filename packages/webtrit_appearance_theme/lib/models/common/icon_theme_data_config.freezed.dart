// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'icon_theme_data_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IconThemeDataConfig {

 double? get size; double? get fill; double? get weight; double? get grade; double? get opticalSize; String? get color; double? get opacity; List<ShadowConfig>? get shadows; bool? get applyTextScaling;
/// Create a copy of IconThemeDataConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IconThemeDataConfigCopyWith<IconThemeDataConfig> get copyWith => _$IconThemeDataConfigCopyWithImpl<IconThemeDataConfig>(this as IconThemeDataConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IconThemeDataConfig&&(identical(other.size, size) || other.size == size)&&(identical(other.fill, fill) || other.fill == fill)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.grade, grade) || other.grade == grade)&&(identical(other.opticalSize, opticalSize) || other.opticalSize == opticalSize)&&(identical(other.color, color) || other.color == color)&&(identical(other.opacity, opacity) || other.opacity == opacity)&&const DeepCollectionEquality().equals(other.shadows, shadows)&&(identical(other.applyTextScaling, applyTextScaling) || other.applyTextScaling == applyTextScaling));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,size,fill,weight,grade,opticalSize,color,opacity,const DeepCollectionEquality().hash(shadows),applyTextScaling);

@override
String toString() {
  return 'IconThemeDataConfig(size: $size, fill: $fill, weight: $weight, grade: $grade, opticalSize: $opticalSize, color: $color, opacity: $opacity, shadows: $shadows, applyTextScaling: $applyTextScaling)';
}


}

/// @nodoc
abstract mixin class $IconThemeDataConfigCopyWith<$Res>  {
  factory $IconThemeDataConfigCopyWith(IconThemeDataConfig value, $Res Function(IconThemeDataConfig) _then) = _$IconThemeDataConfigCopyWithImpl;
@useResult
$Res call({
 double? size, double? fill, double? weight, double? grade, double? opticalSize, String? color, double? opacity, List<ShadowConfig>? shadows, bool? applyTextScaling
});




}
/// @nodoc
class _$IconThemeDataConfigCopyWithImpl<$Res>
    implements $IconThemeDataConfigCopyWith<$Res> {
  _$IconThemeDataConfigCopyWithImpl(this._self, this._then);

  final IconThemeDataConfig _self;
  final $Res Function(IconThemeDataConfig) _then;

/// Create a copy of IconThemeDataConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? size = freezed,Object? fill = freezed,Object? weight = freezed,Object? grade = freezed,Object? opticalSize = freezed,Object? color = freezed,Object? opacity = freezed,Object? shadows = freezed,Object? applyTextScaling = freezed,}) {
  return _then(IconThemeDataConfig(
size: freezed == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as double?,fill: freezed == fill ? _self.fill : fill // ignore: cast_nullable_to_non_nullable
as double?,weight: freezed == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double?,grade: freezed == grade ? _self.grade : grade // ignore: cast_nullable_to_non_nullable
as double?,opticalSize: freezed == opticalSize ? _self.opticalSize : opticalSize // ignore: cast_nullable_to_non_nullable
as double?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,opacity: freezed == opacity ? _self.opacity : opacity // ignore: cast_nullable_to_non_nullable
as double?,shadows: freezed == shadows ? _self.shadows : shadows // ignore: cast_nullable_to_non_nullable
as List<ShadowConfig>?,applyTextScaling: freezed == applyTextScaling ? _self.applyTextScaling : applyTextScaling // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [IconThemeDataConfig].
extension IconThemeDataConfigPatterns on IconThemeDataConfig {
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
mixin _$ShadowConfig {

 String? get color; OffsetConfig? get offset; double get blurRadius;
/// Create a copy of ShadowConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShadowConfigCopyWith<ShadowConfig> get copyWith => _$ShadowConfigCopyWithImpl<ShadowConfig>(this as ShadowConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ShadowConfig&&(identical(other.color, color) || other.color == color)&&(identical(other.offset, offset) || other.offset == offset)&&(identical(other.blurRadius, blurRadius) || other.blurRadius == blurRadius));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,color,offset,blurRadius);

@override
String toString() {
  return 'ShadowConfig(color: $color, offset: $offset, blurRadius: $blurRadius)';
}


}

/// @nodoc
abstract mixin class $ShadowConfigCopyWith<$Res>  {
  factory $ShadowConfigCopyWith(ShadowConfig value, $Res Function(ShadowConfig) _then) = _$ShadowConfigCopyWithImpl;
@useResult
$Res call({
 String? color, OffsetConfig? offset, double blurRadius
});




}
/// @nodoc
class _$ShadowConfigCopyWithImpl<$Res>
    implements $ShadowConfigCopyWith<$Res> {
  _$ShadowConfigCopyWithImpl(this._self, this._then);

  final ShadowConfig _self;
  final $Res Function(ShadowConfig) _then;

/// Create a copy of ShadowConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? color = freezed,Object? offset = freezed,Object? blurRadius = null,}) {
  return _then(ShadowConfig(
color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,offset: freezed == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as OffsetConfig?,blurRadius: null == blurRadius ? _self.blurRadius : blurRadius // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ShadowConfig].
extension ShadowConfigPatterns on ShadowConfig {
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
mixin _$OffsetConfig {

 double get dx; double get dy;
/// Create a copy of OffsetConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OffsetConfigCopyWith<OffsetConfig> get copyWith => _$OffsetConfigCopyWithImpl<OffsetConfig>(this as OffsetConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OffsetConfig&&(identical(other.dx, dx) || other.dx == dx)&&(identical(other.dy, dy) || other.dy == dy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dx,dy);

@override
String toString() {
  return 'OffsetConfig(dx: $dx, dy: $dy)';
}


}

/// @nodoc
abstract mixin class $OffsetConfigCopyWith<$Res>  {
  factory $OffsetConfigCopyWith(OffsetConfig value, $Res Function(OffsetConfig) _then) = _$OffsetConfigCopyWithImpl;
@useResult
$Res call({
 double dx, double dy
});




}
/// @nodoc
class _$OffsetConfigCopyWithImpl<$Res>
    implements $OffsetConfigCopyWith<$Res> {
  _$OffsetConfigCopyWithImpl(this._self, this._then);

  final OffsetConfig _self;
  final $Res Function(OffsetConfig) _then;

/// Create a copy of OffsetConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dx = null,Object? dy = null,}) {
  return _then(OffsetConfig(
dx: null == dx ? _self.dx : dx // ignore: cast_nullable_to_non_nullable
as double,dy: null == dy ? _self.dy : dy // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [OffsetConfig].
extension OffsetConfigPatterns on OffsetConfig {
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
