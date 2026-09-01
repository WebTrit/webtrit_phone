// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'page_background.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PageBackgroundSolid {

 String get color; String get type;
/// Create a copy of PageBackgroundSolid
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PageBackgroundSolidCopyWith<PageBackgroundSolid> get copyWith => _$PageBackgroundSolidCopyWithImpl<PageBackgroundSolid>(this as PageBackgroundSolid, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PageBackgroundSolid&&(identical(other.color, color) || other.color == color)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,color,type);

@override
String toString() {
  return 'PageBackgroundSolid(color: $color, type: $type)';
}


}

/// @nodoc
abstract mixin class $PageBackgroundSolidCopyWith<$Res>  {
  factory $PageBackgroundSolidCopyWith(PageBackgroundSolid value, $Res Function(PageBackgroundSolid) _then) = _$PageBackgroundSolidCopyWithImpl;
@useResult
$Res call({
 String color, String type
});




}
/// @nodoc
class _$PageBackgroundSolidCopyWithImpl<$Res>
    implements $PageBackgroundSolidCopyWith<$Res> {
  _$PageBackgroundSolidCopyWithImpl(this._self, this._then);

  final PageBackgroundSolid _self;
  final $Res Function(PageBackgroundSolid) _then;

/// Create a copy of PageBackgroundSolid
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? color = null,Object? type = null,}) {
  return _then(PageBackgroundSolid(
color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PageBackgroundSolid].
extension PageBackgroundSolidPatterns on PageBackgroundSolid {
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
mixin _$PageBackgroundGradient {

 List<String> get colors; List<double> get stops; double get beginX; double get beginY; double get endX; double get endY; String get type;
/// Create a copy of PageBackgroundGradient
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PageBackgroundGradientCopyWith<PageBackgroundGradient> get copyWith => _$PageBackgroundGradientCopyWithImpl<PageBackgroundGradient>(this as PageBackgroundGradient, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PageBackgroundGradient&&const DeepCollectionEquality().equals(other.colors, colors)&&const DeepCollectionEquality().equals(other.stops, stops)&&(identical(other.beginX, beginX) || other.beginX == beginX)&&(identical(other.beginY, beginY) || other.beginY == beginY)&&(identical(other.endX, endX) || other.endX == endX)&&(identical(other.endY, endY) || other.endY == endY)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(colors),const DeepCollectionEquality().hash(stops),beginX,beginY,endX,endY,type);

@override
String toString() {
  return 'PageBackgroundGradient(colors: $colors, stops: $stops, beginX: $beginX, beginY: $beginY, endX: $endX, endY: $endY, type: $type)';
}


}

/// @nodoc
abstract mixin class $PageBackgroundGradientCopyWith<$Res>  {
  factory $PageBackgroundGradientCopyWith(PageBackgroundGradient value, $Res Function(PageBackgroundGradient) _then) = _$PageBackgroundGradientCopyWithImpl;
@useResult
$Res call({
 List<String> colors, List<double> stops, double beginX, double beginY, double endX, double endY, String type
});




}
/// @nodoc
class _$PageBackgroundGradientCopyWithImpl<$Res>
    implements $PageBackgroundGradientCopyWith<$Res> {
  _$PageBackgroundGradientCopyWithImpl(this._self, this._then);

  final PageBackgroundGradient _self;
  final $Res Function(PageBackgroundGradient) _then;

/// Create a copy of PageBackgroundGradient
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? colors = null,Object? stops = null,Object? beginX = null,Object? beginY = null,Object? endX = null,Object? endY = null,Object? type = null,}) {
  return _then(PageBackgroundGradient(
colors: null == colors ? _self.colors : colors // ignore: cast_nullable_to_non_nullable
as List<String>,stops: null == stops ? _self.stops : stops // ignore: cast_nullable_to_non_nullable
as List<double>,beginX: null == beginX ? _self.beginX : beginX // ignore: cast_nullable_to_non_nullable
as double,beginY: null == beginY ? _self.beginY : beginY // ignore: cast_nullable_to_non_nullable
as double,endX: null == endX ? _self.endX : endX // ignore: cast_nullable_to_non_nullable
as double,endY: null == endY ? _self.endY : endY // ignore: cast_nullable_to_non_nullable
as double,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PageBackgroundGradient].
extension PageBackgroundGradientPatterns on PageBackgroundGradient {
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
mixin _$PageBackgroundImage {

 String get imageUrl; BoxFitConfig get fit; double get opacity; String get type;
/// Create a copy of PageBackgroundImage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PageBackgroundImageCopyWith<PageBackgroundImage> get copyWith => _$PageBackgroundImageCopyWithImpl<PageBackgroundImage>(this as PageBackgroundImage, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PageBackgroundImage&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.fit, fit) || other.fit == fit)&&(identical(other.opacity, opacity) || other.opacity == opacity)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,imageUrl,fit,opacity,type);

@override
String toString() {
  return 'PageBackgroundImage(imageUrl: $imageUrl, fit: $fit, opacity: $opacity, type: $type)';
}


}

/// @nodoc
abstract mixin class $PageBackgroundImageCopyWith<$Res>  {
  factory $PageBackgroundImageCopyWith(PageBackgroundImage value, $Res Function(PageBackgroundImage) _then) = _$PageBackgroundImageCopyWithImpl;
@useResult
$Res call({
 String imageUrl, BoxFitConfig fit, double opacity, String type
});




}
/// @nodoc
class _$PageBackgroundImageCopyWithImpl<$Res>
    implements $PageBackgroundImageCopyWith<$Res> {
  _$PageBackgroundImageCopyWithImpl(this._self, this._then);

  final PageBackgroundImage _self;
  final $Res Function(PageBackgroundImage) _then;

/// Create a copy of PageBackgroundImage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? imageUrl = null,Object? fit = null,Object? opacity = null,Object? type = null,}) {
  return _then(PageBackgroundImage(
imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,fit: null == fit ? _self.fit : fit // ignore: cast_nullable_to_non_nullable
as BoxFitConfig,opacity: null == opacity ? _self.opacity : opacity // ignore: cast_nullable_to_non_nullable
as double,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PageBackgroundImage].
extension PageBackgroundImagePatterns on PageBackgroundImage {
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
