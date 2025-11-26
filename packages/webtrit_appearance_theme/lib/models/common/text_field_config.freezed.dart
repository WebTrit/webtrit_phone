// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'text_field_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TextFieldConfig {

 InputDecorationConfig? get decoration; TextStyleConfig? get style; String get textAlign; bool get showCursor; String get keyboardType; MaskConfig? get mask; InputBehaviorConfig? get behavior;
/// Create a copy of TextFieldConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TextFieldConfigCopyWith<TextFieldConfig> get copyWith => _$TextFieldConfigCopyWithImpl<TextFieldConfig>(this as TextFieldConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TextFieldConfig&&(identical(other.decoration, decoration) || other.decoration == decoration)&&(identical(other.style, style) || other.style == style)&&(identical(other.textAlign, textAlign) || other.textAlign == textAlign)&&(identical(other.showCursor, showCursor) || other.showCursor == showCursor)&&(identical(other.keyboardType, keyboardType) || other.keyboardType == keyboardType)&&(identical(other.mask, mask) || other.mask == mask)&&(identical(other.behavior, behavior) || other.behavior == behavior));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,decoration,style,textAlign,showCursor,keyboardType,mask,behavior);

@override
String toString() {
  return 'TextFieldConfig(decoration: $decoration, style: $style, textAlign: $textAlign, showCursor: $showCursor, keyboardType: $keyboardType, mask: $mask, behavior: $behavior)';
}


}

/// @nodoc
abstract mixin class $TextFieldConfigCopyWith<$Res>  {
  factory $TextFieldConfigCopyWith(TextFieldConfig value, $Res Function(TextFieldConfig) _then) = _$TextFieldConfigCopyWithImpl;
@useResult
$Res call({
 InputDecorationConfig? decoration, TextStyleConfig? style, String textAlign, bool showCursor, String keyboardType, MaskConfig? mask, InputBehaviorConfig? behavior
});




}
/// @nodoc
class _$TextFieldConfigCopyWithImpl<$Res>
    implements $TextFieldConfigCopyWith<$Res> {
  _$TextFieldConfigCopyWithImpl(this._self, this._then);

  final TextFieldConfig _self;
  final $Res Function(TextFieldConfig) _then;

/// Create a copy of TextFieldConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? decoration = freezed,Object? style = freezed,Object? textAlign = null,Object? showCursor = null,Object? keyboardType = null,Object? mask = freezed,Object? behavior = freezed,}) {
  return _then(TextFieldConfig(
decoration: freezed == decoration ? _self.decoration : decoration // ignore: cast_nullable_to_non_nullable
as InputDecorationConfig?,style: freezed == style ? _self.style : style // ignore: cast_nullable_to_non_nullable
as TextStyleConfig?,textAlign: null == textAlign ? _self.textAlign : textAlign // ignore: cast_nullable_to_non_nullable
as String,showCursor: null == showCursor ? _self.showCursor : showCursor // ignore: cast_nullable_to_non_nullable
as bool,keyboardType: null == keyboardType ? _self.keyboardType : keyboardType // ignore: cast_nullable_to_non_nullable
as String,mask: freezed == mask ? _self.mask : mask // ignore: cast_nullable_to_non_nullable
as MaskConfig?,behavior: freezed == behavior ? _self.behavior : behavior // ignore: cast_nullable_to_non_nullable
as InputBehaviorConfig?,
  ));
}

}


/// Adds pattern-matching-related methods to [TextFieldConfig].
extension TextFieldConfigPatterns on TextFieldConfig {
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
mixin _$InputBehaviorConfig {

 bool? get includePrefixInData;
/// Create a copy of InputBehaviorConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InputBehaviorConfigCopyWith<InputBehaviorConfig> get copyWith => _$InputBehaviorConfigCopyWithImpl<InputBehaviorConfig>(this as InputBehaviorConfig, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InputBehaviorConfig&&(identical(other.includePrefixInData, includePrefixInData) || other.includePrefixInData == includePrefixInData));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,includePrefixInData);

@override
String toString() {
  return 'InputBehaviorConfig(includePrefixInData: $includePrefixInData)';
}


}

/// @nodoc
abstract mixin class $InputBehaviorConfigCopyWith<$Res>  {
  factory $InputBehaviorConfigCopyWith(InputBehaviorConfig value, $Res Function(InputBehaviorConfig) _then) = _$InputBehaviorConfigCopyWithImpl;
@useResult
$Res call({
 bool? includePrefixInData
});




}
/// @nodoc
class _$InputBehaviorConfigCopyWithImpl<$Res>
    implements $InputBehaviorConfigCopyWith<$Res> {
  _$InputBehaviorConfigCopyWithImpl(this._self, this._then);

  final InputBehaviorConfig _self;
  final $Res Function(InputBehaviorConfig) _then;

/// Create a copy of InputBehaviorConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? includePrefixInData = freezed,}) {
  return _then(InputBehaviorConfig(
includePrefixInData: freezed == includePrefixInData ? _self.includePrefixInData : includePrefixInData // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [InputBehaviorConfig].
extension InputBehaviorConfigPatterns on InputBehaviorConfig {
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
