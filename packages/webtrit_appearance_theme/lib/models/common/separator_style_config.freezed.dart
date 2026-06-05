// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'separator_style_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SeparatorStyleConfig {

/// Whether to render the separator. `null` → shown (default).
 bool? get enabled;/// Separator color (hex string, e.g. `#CAC7D1`). `null` → theme default.
 String? get color;
/// Create a copy of SeparatorStyleConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeparatorStyleConfigCopyWith<SeparatorStyleConfig> get copyWith => _$SeparatorStyleConfigCopyWithImpl<SeparatorStyleConfig>(this as SeparatorStyleConfig, _$identity);

  /// Serializes this SeparatorStyleConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeparatorStyleConfig&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.color, color) || other.color == color));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,color);

@override
String toString() {
  return 'SeparatorStyleConfig(enabled: $enabled, color: $color)';
}


}

/// @nodoc
abstract mixin class $SeparatorStyleConfigCopyWith<$Res>  {
  factory $SeparatorStyleConfigCopyWith(SeparatorStyleConfig value, $Res Function(SeparatorStyleConfig) _then) = _$SeparatorStyleConfigCopyWithImpl;
@useResult
$Res call({
 bool? enabled, String? color
});




}
/// @nodoc
class _$SeparatorStyleConfigCopyWithImpl<$Res>
    implements $SeparatorStyleConfigCopyWith<$Res> {
  _$SeparatorStyleConfigCopyWithImpl(this._self, this._then);

  final SeparatorStyleConfig _self;
  final $Res Function(SeparatorStyleConfig) _then;

/// Create a copy of SeparatorStyleConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enabled = freezed,Object? color = freezed,}) {
  return _then(_self.copyWith(
enabled: freezed == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SeparatorStyleConfig].
extension SeparatorStyleConfigPatterns on SeparatorStyleConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SeparatorStyleConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SeparatorStyleConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SeparatorStyleConfig value)  $default,){
final _that = this;
switch (_that) {
case _SeparatorStyleConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SeparatorStyleConfig value)?  $default,){
final _that = this;
switch (_that) {
case _SeparatorStyleConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool? enabled,  String? color)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SeparatorStyleConfig() when $default != null:
return $default(_that.enabled,_that.color);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool? enabled,  String? color)  $default,) {final _that = this;
switch (_that) {
case _SeparatorStyleConfig():
return $default(_that.enabled,_that.color);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool? enabled,  String? color)?  $default,) {final _that = this;
switch (_that) {
case _SeparatorStyleConfig() when $default != null:
return $default(_that.enabled,_that.color);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SeparatorStyleConfig implements SeparatorStyleConfig {
  const _SeparatorStyleConfig({this.enabled, this.color});
  factory _SeparatorStyleConfig.fromJson(Map<String, dynamic> json) => _$SeparatorStyleConfigFromJson(json);

/// Whether to render the separator. `null` → shown (default).
@override final  bool? enabled;
/// Separator color (hex string, e.g. `#CAC7D1`). `null` → theme default.
@override final  String? color;

/// Create a copy of SeparatorStyleConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SeparatorStyleConfigCopyWith<_SeparatorStyleConfig> get copyWith => __$SeparatorStyleConfigCopyWithImpl<_SeparatorStyleConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SeparatorStyleConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SeparatorStyleConfig&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.color, color) || other.color == color));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,color);

@override
String toString() {
  return 'SeparatorStyleConfig(enabled: $enabled, color: $color)';
}


}

/// @nodoc
abstract mixin class _$SeparatorStyleConfigCopyWith<$Res> implements $SeparatorStyleConfigCopyWith<$Res> {
  factory _$SeparatorStyleConfigCopyWith(_SeparatorStyleConfig value, $Res Function(_SeparatorStyleConfig) _then) = __$SeparatorStyleConfigCopyWithImpl;
@override @useResult
$Res call({
 bool? enabled, String? color
});




}
/// @nodoc
class __$SeparatorStyleConfigCopyWithImpl<$Res>
    implements _$SeparatorStyleConfigCopyWith<$Res> {
  __$SeparatorStyleConfigCopyWithImpl(this._self, this._then);

  final _SeparatorStyleConfig _self;
  final $Res Function(_SeparatorStyleConfig) _then;

/// Create a copy of SeparatorStyleConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = freezed,Object? color = freezed,}) {
  return _then(_SeparatorStyleConfig(
enabled: freezed == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool?,color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
