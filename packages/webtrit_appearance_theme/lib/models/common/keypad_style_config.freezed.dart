// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'keypad_style_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KeypadStyleConfig {

 TextStyleConfig? get textStyle; TextStyleConfig? get subtextStyle; double? get spacing; double? get padding;
/// Create a copy of KeypadStyleConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KeypadStyleConfigCopyWith<KeypadStyleConfig> get copyWith => _$KeypadStyleConfigCopyWithImpl<KeypadStyleConfig>(this as KeypadStyleConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KeypadStyleConfig&&(identical(other.textStyle, textStyle) || other.textStyle == textStyle)&&(identical(other.subtextStyle, subtextStyle) || other.subtextStyle == subtextStyle)&&(identical(other.spacing, spacing) || other.spacing == spacing)&&(identical(other.padding, padding) || other.padding == padding));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,textStyle,subtextStyle,spacing,padding);

@override
String toString() {
  return 'KeypadStyleConfig(textStyle: $textStyle, subtextStyle: $subtextStyle, spacing: $spacing, padding: $padding)';
}


}

/// @nodoc
abstract mixin class $KeypadStyleConfigCopyWith<$Res>  {
  factory $KeypadStyleConfigCopyWith(KeypadStyleConfig value, $Res Function(KeypadStyleConfig) _then) = _$KeypadStyleConfigCopyWithImpl;
@useResult
$Res call({
 TextStyleConfig? textStyle, TextStyleConfig? subtextStyle, double? spacing, double? padding
});




}
/// @nodoc
class _$KeypadStyleConfigCopyWithImpl<$Res>
    implements $KeypadStyleConfigCopyWith<$Res> {
  _$KeypadStyleConfigCopyWithImpl(this._self, this._then);

  final KeypadStyleConfig _self;
  final $Res Function(KeypadStyleConfig) _then;

/// Create a copy of KeypadStyleConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? textStyle = freezed,Object? subtextStyle = freezed,Object? spacing = freezed,Object? padding = freezed,}) {
  return _then(KeypadStyleConfig(
textStyle: freezed == textStyle ? _self.textStyle : textStyle // ignore: cast_nullable_to_non_nullable
as TextStyleConfig?,subtextStyle: freezed == subtextStyle ? _self.subtextStyle : subtextStyle // ignore: cast_nullable_to_non_nullable
as TextStyleConfig?,spacing: freezed == spacing ? _self.spacing : spacing // ignore: cast_nullable_to_non_nullable
as double?,padding: freezed == padding ? _self.padding : padding // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [KeypadStyleConfig].
extension KeypadStyleConfigPatterns on KeypadStyleConfig {
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
