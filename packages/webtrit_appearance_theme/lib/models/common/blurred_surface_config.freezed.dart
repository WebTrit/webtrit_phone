// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'blurred_surface_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BlurredSurfaceConfig {

 String? get color; double? get sigmaX; double? get sigmaY;
/// Create a copy of BlurredSurfaceConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BlurredSurfaceConfigCopyWith<BlurredSurfaceConfig> get copyWith => _$BlurredSurfaceConfigCopyWithImpl<BlurredSurfaceConfig>(this as BlurredSurfaceConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BlurredSurfaceConfig&&(identical(other.color, color) || other.color == color)&&(identical(other.sigmaX, sigmaX) || other.sigmaX == sigmaX)&&(identical(other.sigmaY, sigmaY) || other.sigmaY == sigmaY));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,color,sigmaX,sigmaY);

@override
String toString() {
  return 'BlurredSurfaceConfig(color: $color, sigmaX: $sigmaX, sigmaY: $sigmaY)';
}


}

/// @nodoc
abstract mixin class $BlurredSurfaceConfigCopyWith<$Res>  {
  factory $BlurredSurfaceConfigCopyWith(BlurredSurfaceConfig value, $Res Function(BlurredSurfaceConfig) _then) = _$BlurredSurfaceConfigCopyWithImpl;
@useResult
$Res call({
 String? color, double? sigmaX, double? sigmaY
});




}
/// @nodoc
class _$BlurredSurfaceConfigCopyWithImpl<$Res>
    implements $BlurredSurfaceConfigCopyWith<$Res> {
  _$BlurredSurfaceConfigCopyWithImpl(this._self, this._then);

  final BlurredSurfaceConfig _self;
  final $Res Function(BlurredSurfaceConfig) _then;

/// Create a copy of BlurredSurfaceConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? color = freezed,Object? sigmaX = freezed,Object? sigmaY = freezed,}) {
  return _then(BlurredSurfaceConfig(
color: freezed == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String?,sigmaX: freezed == sigmaX ? _self.sigmaX : sigmaX // ignore: cast_nullable_to_non_nullable
as double?,sigmaY: freezed == sigmaY ? _self.sigmaY : sigmaY // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [BlurredSurfaceConfig].
extension BlurredSurfaceConfigPatterns on BlurredSurfaceConfig {
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
