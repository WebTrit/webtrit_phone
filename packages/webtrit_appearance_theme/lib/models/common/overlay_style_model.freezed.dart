// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'overlay_style_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OverlayStyleModel {

 String? get systemNavigationBarColor; String? get systemNavigationBarIconBrightness; String? get statusBarIconBrightness; String? get statusBarBrightness;
/// Create a copy of OverlayStyleModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OverlayStyleModelCopyWith<OverlayStyleModel> get copyWith => _$OverlayStyleModelCopyWithImpl<OverlayStyleModel>(this as OverlayStyleModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OverlayStyleModel&&(identical(other.systemNavigationBarColor, systemNavigationBarColor) || other.systemNavigationBarColor == systemNavigationBarColor)&&(identical(other.systemNavigationBarIconBrightness, systemNavigationBarIconBrightness) || other.systemNavigationBarIconBrightness == systemNavigationBarIconBrightness)&&(identical(other.statusBarIconBrightness, statusBarIconBrightness) || other.statusBarIconBrightness == statusBarIconBrightness)&&(identical(other.statusBarBrightness, statusBarBrightness) || other.statusBarBrightness == statusBarBrightness));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,systemNavigationBarColor,systemNavigationBarIconBrightness,statusBarIconBrightness,statusBarBrightness);

@override
String toString() {
  return 'OverlayStyleModel(systemNavigationBarColor: $systemNavigationBarColor, systemNavigationBarIconBrightness: $systemNavigationBarIconBrightness, statusBarIconBrightness: $statusBarIconBrightness, statusBarBrightness: $statusBarBrightness)';
}


}

/// @nodoc
abstract mixin class $OverlayStyleModelCopyWith<$Res>  {
  factory $OverlayStyleModelCopyWith(OverlayStyleModel value, $Res Function(OverlayStyleModel) _then) = _$OverlayStyleModelCopyWithImpl;
@useResult
$Res call({
 String? systemNavigationBarColor, String? systemNavigationBarIconBrightness, String? statusBarIconBrightness, String? statusBarBrightness
});




}
/// @nodoc
class _$OverlayStyleModelCopyWithImpl<$Res>
    implements $OverlayStyleModelCopyWith<$Res> {
  _$OverlayStyleModelCopyWithImpl(this._self, this._then);

  final OverlayStyleModel _self;
  final $Res Function(OverlayStyleModel) _then;

/// Create a copy of OverlayStyleModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? systemNavigationBarColor = freezed,Object? systemNavigationBarIconBrightness = freezed,Object? statusBarIconBrightness = freezed,Object? statusBarBrightness = freezed,}) {
  return _then(OverlayStyleModel(
systemNavigationBarColor: freezed == systemNavigationBarColor ? _self.systemNavigationBarColor : systemNavigationBarColor // ignore: cast_nullable_to_non_nullable
as String?,systemNavigationBarIconBrightness: freezed == systemNavigationBarIconBrightness ? _self.systemNavigationBarIconBrightness : systemNavigationBarIconBrightness // ignore: cast_nullable_to_non_nullable
as String?,statusBarIconBrightness: freezed == statusBarIconBrightness ? _self.statusBarIconBrightness : statusBarIconBrightness // ignore: cast_nullable_to_non_nullable
as String?,statusBarBrightness: freezed == statusBarBrightness ? _self.statusBarBrightness : statusBarBrightness // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OverlayStyleModel].
extension OverlayStyleModelPatterns on OverlayStyleModel {
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
