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

/// The default size for icons.
 double? get size;/// The default fill for icons (0.0 to 1.0).
/// Useful for variable fonts (e.g. Material Symbols).
 double? get fill;/// The default weight for icons (e.g. 400.0).
/// Useful for variable fonts.
 double? get weight;/// The default grade for icons.
/// Useful for variable fonts.
 double? get grade;/// The default optical size for icons.
/// Useful for variable fonts.
 double? get opticalSize;/// The default color for icons (hex string).
 String? get color;/// An opacity to apply to both explicit and default icon colors.
 double? get opacity;/// A list of shadows to apply to the icons.
 List<ShadowConfig>? get shadows;/// Whether to apply text scaling to the icons.
 bool? get applyTextScaling;
/// Create a copy of IconThemeDataConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IconThemeDataConfigCopyWith<IconThemeDataConfig> get copyWith => _$IconThemeDataConfigCopyWithImpl<IconThemeDataConfig>(this as IconThemeDataConfig, _$identity);

  /// Serializes this IconThemeDataConfig to a JSON map.
  Map<String, dynamic> toJson();


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
  return _then(_self.copyWith(
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IconThemeDataConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IconThemeDataConfig() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IconThemeDataConfig value)  $default,){
final _that = this;
switch (_that) {
case _IconThemeDataConfig():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IconThemeDataConfig value)?  $default,){
final _that = this;
switch (_that) {
case _IconThemeDataConfig() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double? size,  double? fill,  double? weight,  double? grade,  double? opticalSize,  String? color,  double? opacity,  List<ShadowConfig>? shadows,  bool? applyTextScaling)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IconThemeDataConfig() when $default != null:
return $default(_that.size,_that.fill,_that.weight,_that.grade,_that.opticalSize,_that.color,_that.opacity,_that.shadows,_that.applyTextScaling);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double? size,  double? fill,  double? weight,  double? grade,  double? opticalSize,  String? color,  double? opacity,  List<ShadowConfig>? shadows,  bool? applyTextScaling)  $default,) {final _that = this;
switch (_that) {
case _IconThemeDataConfig():
return $default(_that.size,_that.fill,_that.weight,_that.grade,_that.opticalSize,_that.color,_that.opacity,_that.shadows,_that.applyTextScaling);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double? size,  double? fill,  double? weight,  double? grade,  double? opticalSize,  String? color,  double? opacity,  List<ShadowConfig>? shadows,  bool? applyTextScaling)?  $default,) {final _that = this;
switch (_that) {
case _IconThemeDataConfig() when $default != null:
return $default(_that.size,_that.fill,_that.weight,_that.grade,_that.opticalSize,_that.color,_that.opacity,_that.shadows,_that.applyTextScaling);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _IconThemeDataConfig implements IconThemeDataConfig {
  const _IconThemeDataConfig({this.size, this.fill, this.weight, this.grade, this.opticalSize, this.color, this.opacity, final  List<ShadowConfig>? shadows, this.applyTextScaling}): _shadows = shadows;
  factory _IconThemeDataConfig.fromJson(Map<String, dynamic> json) => _$IconThemeDataConfigFromJson(json);

/// The default size for icons.
@override final  double? size;
/// The default fill for icons (0.0 to 1.0).
/// Useful for variable fonts (e.g. Material Symbols).
@override final  double? fill;
/// The default weight for icons (e.g. 400.0).
/// Useful for variable fonts.
@override final  double? weight;
/// The default grade for icons.
/// Useful for variable fonts.
@override final  double? grade;
/// The default optical size for icons.
/// Useful for variable fonts.
@override final  double? opticalSize;
/// The default color for icons (hex string).
@override final  String? color;
/// An opacity to apply to both explicit and default icon colors.
@override final  double? opacity;
/// A list of shadows to apply to the icons.
 final  List<ShadowConfig>? _shadows;
/// A list of shadows to apply to the icons.
@override List<ShadowConfig>? get shadows {
  final value = _shadows;
  if (value == null) return null;
  if (_shadows is EqualUnmodifiableListView) return _shadows;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Whether to apply text scaling to the icons.
@override final  bool? applyTextScaling;

/// Create a copy of IconThemeDataConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IconThemeDataConfigCopyWith<_IconThemeDataConfig> get copyWith => __$IconThemeDataConfigCopyWithImpl<_IconThemeDataConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IconThemeDataConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IconThemeDataConfig&&(identical(other.size, size) || other.size == size)&&(identical(other.fill, fill) || other.fill == fill)&&(identical(other.weight, weight) || other.weight == weight)&&(identical(other.grade, grade) || other.grade == grade)&&(identical(other.opticalSize, opticalSize) || other.opticalSize == opticalSize)&&(identical(other.color, color) || other.color == color)&&(identical(other.opacity, opacity) || other.opacity == opacity)&&const DeepCollectionEquality().equals(other._shadows, _shadows)&&(identical(other.applyTextScaling, applyTextScaling) || other.applyTextScaling == applyTextScaling));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,size,fill,weight,grade,opticalSize,color,opacity,const DeepCollectionEquality().hash(_shadows),applyTextScaling);

@override
String toString() {
  return 'IconThemeDataConfig(size: $size, fill: $fill, weight: $weight, grade: $grade, opticalSize: $opticalSize, color: $color, opacity: $opacity, shadows: $shadows, applyTextScaling: $applyTextScaling)';
}


}

/// @nodoc
abstract mixin class _$IconThemeDataConfigCopyWith<$Res> implements $IconThemeDataConfigCopyWith<$Res> {
  factory _$IconThemeDataConfigCopyWith(_IconThemeDataConfig value, $Res Function(_IconThemeDataConfig) _then) = __$IconThemeDataConfigCopyWithImpl;
@override @useResult
$Res call({
 double? size, double? fill, double? weight, double? grade, double? opticalSize, String? color, double? opacity, List<ShadowConfig>? shadows, bool? applyTextScaling
});




}
/// @nodoc
class __$IconThemeDataConfigCopyWithImpl<$Res>
    implements _$IconThemeDataConfigCopyWith<$Res> {
  __$IconThemeDataConfigCopyWithImpl(this._self, this._then);

  final _IconThemeDataConfig _self;
  final $Res Function(_IconThemeDataConfig) _then;

/// Create a copy of IconThemeDataConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? size = freezed,Object? fill = freezed,Object? weight = freezed,Object? grade = freezed,Object? opticalSize = freezed,Object? color = freezed,Object? opacity = freezed,Object? shadows = freezed,Object? applyTextScaling = freezed,}) {
  return _then(_IconThemeDataConfig(
size: freezed == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as double?,fill: freezed == fill ? _self.fill : fill // ignore: cast_nullable_to_non_nullable
as double?,weight: freezed == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double?,grade: freezed == grade ? _self.grade : grade // ignore: cast_nullable_to_non_nullable
as double?,opticalSize: freezed == opticalSize ? _self.opticalSize : opticalSize // ignore: cast_nullable_to_non_nullable
as double?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,opacity: freezed == opacity ? _self.opacity : opacity // ignore: cast_nullable_to_non_nullable
as double?,shadows: freezed == shadows ? _self._shadows : shadows // ignore: cast_nullable_to_non_nullable
as List<ShadowConfig>?,applyTextScaling: freezed == applyTextScaling ? _self.applyTextScaling : applyTextScaling // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}


/// @nodoc
mixin _$ShadowConfig {

/// Color of the shadow (hex string).
 String? get color;/// The displacement of the shadow.
 OffsetConfig? get offset;/// The blur radius of the shadow.
 double get blurRadius;
/// Create a copy of ShadowConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShadowConfigCopyWith<ShadowConfig> get copyWith => _$ShadowConfigCopyWithImpl<ShadowConfig>(this as ShadowConfig, _$identity);

  /// Serializes this ShadowConfig to a JSON map.
  Map<String, dynamic> toJson();


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


$OffsetConfigCopyWith<$Res>? get offset;

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
  return _then(_self.copyWith(
color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,offset: freezed == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as OffsetConfig?,blurRadius: null == blurRadius ? _self.blurRadius : blurRadius // ignore: cast_nullable_to_non_nullable
as double,
  ));
}
/// Create a copy of ShadowConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OffsetConfigCopyWith<$Res>? get offset {
    if (_self.offset == null) {
    return null;
  }

  return $OffsetConfigCopyWith<$Res>(_self.offset!, (value) {
    return _then(_self.copyWith(offset: value));
  });
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ShadowConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ShadowConfig() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ShadowConfig value)  $default,){
final _that = this;
switch (_that) {
case _ShadowConfig():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ShadowConfig value)?  $default,){
final _that = this;
switch (_that) {
case _ShadowConfig() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? color,  OffsetConfig? offset,  double blurRadius)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ShadowConfig() when $default != null:
return $default(_that.color,_that.offset,_that.blurRadius);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? color,  OffsetConfig? offset,  double blurRadius)  $default,) {final _that = this;
switch (_that) {
case _ShadowConfig():
return $default(_that.color,_that.offset,_that.blurRadius);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? color,  OffsetConfig? offset,  double blurRadius)?  $default,) {final _that = this;
switch (_that) {
case _ShadowConfig() when $default != null:
return $default(_that.color,_that.offset,_that.blurRadius);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _ShadowConfig implements ShadowConfig {
  const _ShadowConfig({this.color, this.offset, this.blurRadius = 0.0});
  factory _ShadowConfig.fromJson(Map<String, dynamic> json) => _$ShadowConfigFromJson(json);

/// Color of the shadow (hex string).
@override final  String? color;
/// The displacement of the shadow.
@override final  OffsetConfig? offset;
/// The blur radius of the shadow.
@override@JsonKey() final  double blurRadius;

/// Create a copy of ShadowConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShadowConfigCopyWith<_ShadowConfig> get copyWith => __$ShadowConfigCopyWithImpl<_ShadowConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ShadowConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ShadowConfig&&(identical(other.color, color) || other.color == color)&&(identical(other.offset, offset) || other.offset == offset)&&(identical(other.blurRadius, blurRadius) || other.blurRadius == blurRadius));
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
abstract mixin class _$ShadowConfigCopyWith<$Res> implements $ShadowConfigCopyWith<$Res> {
  factory _$ShadowConfigCopyWith(_ShadowConfig value, $Res Function(_ShadowConfig) _then) = __$ShadowConfigCopyWithImpl;
@override @useResult
$Res call({
 String? color, OffsetConfig? offset, double blurRadius
});


@override $OffsetConfigCopyWith<$Res>? get offset;

}
/// @nodoc
class __$ShadowConfigCopyWithImpl<$Res>
    implements _$ShadowConfigCopyWith<$Res> {
  __$ShadowConfigCopyWithImpl(this._self, this._then);

  final _ShadowConfig _self;
  final $Res Function(_ShadowConfig) _then;

/// Create a copy of ShadowConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? color = freezed,Object? offset = freezed,Object? blurRadius = null,}) {
  return _then(_ShadowConfig(
color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,offset: freezed == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as OffsetConfig?,blurRadius: null == blurRadius ? _self.blurRadius : blurRadius // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

/// Create a copy of ShadowConfig
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OffsetConfigCopyWith<$Res>? get offset {
    if (_self.offset == null) {
    return null;
  }

  return $OffsetConfigCopyWith<$Res>(_self.offset!, (value) {
    return _then(_self.copyWith(offset: value));
  });
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

  /// Serializes this OffsetConfig to a JSON map.
  Map<String, dynamic> toJson();


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
  return _then(_self.copyWith(
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OffsetConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OffsetConfig() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OffsetConfig value)  $default,){
final _that = this;
switch (_that) {
case _OffsetConfig():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OffsetConfig value)?  $default,){
final _that = this;
switch (_that) {
case _OffsetConfig() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double dx,  double dy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OffsetConfig() when $default != null:
return $default(_that.dx,_that.dy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double dx,  double dy)  $default,) {final _that = this;
switch (_that) {
case _OffsetConfig():
return $default(_that.dx,_that.dy);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double dx,  double dy)?  $default,) {final _that = this;
switch (_that) {
case _OffsetConfig() when $default != null:
return $default(_that.dx,_that.dy);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OffsetConfig implements OffsetConfig {
  const _OffsetConfig({this.dx = 0.0, this.dy = 0.0});
  factory _OffsetConfig.fromJson(Map<String, dynamic> json) => _$OffsetConfigFromJson(json);

@override@JsonKey() final  double dx;
@override@JsonKey() final  double dy;

/// Create a copy of OffsetConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OffsetConfigCopyWith<_OffsetConfig> get copyWith => __$OffsetConfigCopyWithImpl<_OffsetConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OffsetConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OffsetConfig&&(identical(other.dx, dx) || other.dx == dx)&&(identical(other.dy, dy) || other.dy == dy));
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
abstract mixin class _$OffsetConfigCopyWith<$Res> implements $OffsetConfigCopyWith<$Res> {
  factory _$OffsetConfigCopyWith(_OffsetConfig value, $Res Function(_OffsetConfig) _then) = __$OffsetConfigCopyWithImpl;
@override @useResult
$Res call({
 double dx, double dy
});




}
/// @nodoc
class __$OffsetConfigCopyWithImpl<$Res>
    implements _$OffsetConfigCopyWith<$Res> {
  __$OffsetConfigCopyWithImpl(this._self, this._then);

  final _OffsetConfig _self;
  final $Res Function(_OffsetConfig) _then;

/// Create a copy of OffsetConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dx = null,Object? dy = null,}) {
  return _then(_OffsetConfig(
dx: null == dx ? _self.dx : dx // ignore: cast_nullable_to_non_nullable
as double,dy: null == dy ? _self.dy : dy // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
