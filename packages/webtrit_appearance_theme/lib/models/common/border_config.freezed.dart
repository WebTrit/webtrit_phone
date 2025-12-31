// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'border_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BorderConfig {

/// Border type:
/// - [`BorderTypeConfig.underline`]
/// - [`BorderTypeConfig.outline`]
/// - [`BorderTypeConfig.none`]
 BorderTypeConfig get type;/// Corner radius for outline borders.
 double? get borderRadius;/// Border color (hex string, e.g. `#000000`).
 String? get borderColor;/// Stroke width of the border.
 double? get borderWidth;
/// Create a copy of BorderConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BorderConfigCopyWith<BorderConfig> get copyWith => _$BorderConfigCopyWithImpl<BorderConfig>(this as BorderConfig, _$identity);

  /// Serializes this BorderConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BorderConfig&&(identical(other.type, type) || other.type == type)&&(identical(other.borderRadius, borderRadius) || other.borderRadius == borderRadius)&&(identical(other.borderColor, borderColor) || other.borderColor == borderColor)&&(identical(other.borderWidth, borderWidth) || other.borderWidth == borderWidth));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,borderRadius,borderColor,borderWidth);

@override
String toString() {
  return 'BorderConfig(type: $type, borderRadius: $borderRadius, borderColor: $borderColor, borderWidth: $borderWidth)';
}


}

/// @nodoc
abstract mixin class $BorderConfigCopyWith<$Res>  {
  factory $BorderConfigCopyWith(BorderConfig value, $Res Function(BorderConfig) _then) = _$BorderConfigCopyWithImpl;
@useResult
$Res call({
 BorderTypeConfig type, double? borderRadius, String? borderColor, double? borderWidth
});




}
/// @nodoc
class _$BorderConfigCopyWithImpl<$Res>
    implements $BorderConfigCopyWith<$Res> {
  _$BorderConfigCopyWithImpl(this._self, this._then);

  final BorderConfig _self;
  final $Res Function(BorderConfig) _then;

/// Create a copy of BorderConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? borderRadius = freezed,Object? borderColor = freezed,Object? borderWidth = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as BorderTypeConfig,borderRadius: freezed == borderRadius ? _self.borderRadius : borderRadius // ignore: cast_nullable_to_non_nullable
as double?,borderColor: freezed == borderColor ? _self.borderColor : borderColor // ignore: cast_nullable_to_non_nullable
as String?,borderWidth: freezed == borderWidth ? _self.borderWidth : borderWidth // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [BorderConfig].
extension BorderConfigPatterns on BorderConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BorderConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BorderConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BorderConfig value)  $default,){
final _that = this;
switch (_that) {
case _BorderConfig():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BorderConfig value)?  $default,){
final _that = this;
switch (_that) {
case _BorderConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BorderTypeConfig type,  double? borderRadius,  String? borderColor,  double? borderWidth)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BorderConfig() when $default != null:
return $default(_that.type,_that.borderRadius,_that.borderColor,_that.borderWidth);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BorderTypeConfig type,  double? borderRadius,  String? borderColor,  double? borderWidth)  $default,) {final _that = this;
switch (_that) {
case _BorderConfig():
return $default(_that.type,_that.borderRadius,_that.borderColor,_that.borderWidth);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BorderTypeConfig type,  double? borderRadius,  String? borderColor,  double? borderWidth)?  $default,) {final _that = this;
switch (_that) {
case _BorderConfig() when $default != null:
return $default(_that.type,_that.borderRadius,_that.borderColor,_that.borderWidth);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BorderConfig implements BorderConfig {
  const _BorderConfig({this.type = BorderTypeConfig.underline, this.borderRadius, this.borderColor, this.borderWidth});
  factory _BorderConfig.fromJson(Map<String, dynamic> json) => _$BorderConfigFromJson(json);

/// Border type:
/// - [`BorderTypeConfig.underline`]
/// - [`BorderTypeConfig.outline`]
/// - [`BorderTypeConfig.none`]
@override@JsonKey() final  BorderTypeConfig type;
/// Corner radius for outline borders.
@override final  double? borderRadius;
/// Border color (hex string, e.g. `#000000`).
@override final  String? borderColor;
/// Stroke width of the border.
@override final  double? borderWidth;

/// Create a copy of BorderConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BorderConfigCopyWith<_BorderConfig> get copyWith => __$BorderConfigCopyWithImpl<_BorderConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BorderConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BorderConfig&&(identical(other.type, type) || other.type == type)&&(identical(other.borderRadius, borderRadius) || other.borderRadius == borderRadius)&&(identical(other.borderColor, borderColor) || other.borderColor == borderColor)&&(identical(other.borderWidth, borderWidth) || other.borderWidth == borderWidth));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,borderRadius,borderColor,borderWidth);

@override
String toString() {
  return 'BorderConfig(type: $type, borderRadius: $borderRadius, borderColor: $borderColor, borderWidth: $borderWidth)';
}


}

/// @nodoc
abstract mixin class _$BorderConfigCopyWith<$Res> implements $BorderConfigCopyWith<$Res> {
  factory _$BorderConfigCopyWith(_BorderConfig value, $Res Function(_BorderConfig) _then) = __$BorderConfigCopyWithImpl;
@override @useResult
$Res call({
 BorderTypeConfig type, double? borderRadius, String? borderColor, double? borderWidth
});




}
/// @nodoc
class __$BorderConfigCopyWithImpl<$Res>
    implements _$BorderConfigCopyWith<$Res> {
  __$BorderConfigCopyWithImpl(this._self, this._then);

  final _BorderConfig _self;
  final $Res Function(_BorderConfig) _then;

/// Create a copy of BorderConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? borderRadius = freezed,Object? borderColor = freezed,Object? borderWidth = freezed,}) {
  return _then(_BorderConfig(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as BorderTypeConfig,borderRadius: freezed == borderRadius ? _self.borderRadius : borderRadius // ignore: cast_nullable_to_non_nullable
as double?,borderColor: freezed == borderColor ? _self.borderColor : borderColor // ignore: cast_nullable_to_non_nullable
as String?,borderWidth: freezed == borderWidth ? _self.borderWidth : borderWidth // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
