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
PageBackground _$PageBackgroundFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'solid':
          return PageBackgroundSolid.fromJson(
            json
          );
                case 'gradient':
          return PageBackgroundGradient.fromJson(
            json
          );
                case 'image':
          return PageBackgroundImage.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'PageBackground',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$PageBackground {

 String get type;
/// Create a copy of PageBackground
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PageBackgroundCopyWith<PageBackground> get copyWith => _$PageBackgroundCopyWithImpl<PageBackground>(this as PageBackground, _$identity);

  /// Serializes this PageBackground to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PageBackground&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type);

@override
String toString() {
  return 'PageBackground(type: $type)';
}


}

/// @nodoc
abstract mixin class $PageBackgroundCopyWith<$Res>  {
  factory $PageBackgroundCopyWith(PageBackground value, $Res Function(PageBackground) _then) = _$PageBackgroundCopyWithImpl;
@useResult
$Res call({
 String type
});




}
/// @nodoc
class _$PageBackgroundCopyWithImpl<$Res>
    implements $PageBackgroundCopyWith<$Res> {
  _$PageBackgroundCopyWithImpl(this._self, this._then);

  final PageBackground _self;
  final $Res Function(PageBackground) _then;

/// Create a copy of PageBackground
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PageBackground].
extension PageBackgroundPatterns on PageBackground {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( PageBackgroundSolid value)?  solid,TResult Function( PageBackgroundGradient value)?  gradient,TResult Function( PageBackgroundImage value)?  image,required TResult orElse(),}){
final _that = this;
switch (_that) {
case PageBackgroundSolid() when solid != null:
return solid(_that);case PageBackgroundGradient() when gradient != null:
return gradient(_that);case PageBackgroundImage() when image != null:
return image(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( PageBackgroundSolid value)  solid,required TResult Function( PageBackgroundGradient value)  gradient,required TResult Function( PageBackgroundImage value)  image,}){
final _that = this;
switch (_that) {
case PageBackgroundSolid():
return solid(_that);case PageBackgroundGradient():
return gradient(_that);case PageBackgroundImage():
return image(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( PageBackgroundSolid value)?  solid,TResult? Function( PageBackgroundGradient value)?  gradient,TResult? Function( PageBackgroundImage value)?  image,}){
final _that = this;
switch (_that) {
case PageBackgroundSolid() when solid != null:
return solid(_that);case PageBackgroundGradient() when gradient != null:
return gradient(_that);case PageBackgroundImage() when image != null:
return image(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String color,  String type)?  solid,TResult Function( List<String> colors,  List<double> stops,  double beginX,  double beginY,  double endX,  double endY,  String type)?  gradient,TResult Function( String imageUrl,  BoxFitConfig fit,  double opacity,  String type)?  image,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PageBackgroundSolid() when solid != null:
return solid(_that.color,_that.type);case PageBackgroundGradient() when gradient != null:
return gradient(_that.colors,_that.stops,_that.beginX,_that.beginY,_that.endX,_that.endY,_that.type);case PageBackgroundImage() when image != null:
return image(_that.imageUrl,_that.fit,_that.opacity,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String color,  String type)  solid,required TResult Function( List<String> colors,  List<double> stops,  double beginX,  double beginY,  double endX,  double endY,  String type)  gradient,required TResult Function( String imageUrl,  BoxFitConfig fit,  double opacity,  String type)  image,}) {final _that = this;
switch (_that) {
case PageBackgroundSolid():
return solid(_that.color,_that.type);case PageBackgroundGradient():
return gradient(_that.colors,_that.stops,_that.beginX,_that.beginY,_that.endX,_that.endY,_that.type);case PageBackgroundImage():
return image(_that.imageUrl,_that.fit,_that.opacity,_that.type);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String color,  String type)?  solid,TResult? Function( List<String> colors,  List<double> stops,  double beginX,  double beginY,  double endX,  double endY,  String type)?  gradient,TResult? Function( String imageUrl,  BoxFitConfig fit,  double opacity,  String type)?  image,}) {final _that = this;
switch (_that) {
case PageBackgroundSolid() when solid != null:
return solid(_that.color,_that.type);case PageBackgroundGradient() when gradient != null:
return gradient(_that.colors,_that.stops,_that.beginX,_that.beginY,_that.endX,_that.endY,_that.type);case PageBackgroundImage() when image != null:
return image(_that.imageUrl,_that.fit,_that.opacity,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class PageBackgroundSolid implements PageBackground {
  const PageBackgroundSolid({required this.color, this.type = 'solid'});
  factory PageBackgroundSolid.fromJson(Map<String, dynamic> json) => _$PageBackgroundSolidFromJson(json);

 final  String color;
@override@JsonKey() final  String type;

/// Create a copy of PageBackground
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PageBackgroundSolidCopyWith<PageBackgroundSolid> get copyWith => _$PageBackgroundSolidCopyWithImpl<PageBackgroundSolid>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PageBackgroundSolidToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PageBackgroundSolid&&(identical(other.color, color) || other.color == color)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,color,type);

@override
String toString() {
  return 'PageBackground.solid(color: $color, type: $type)';
}


}

/// @nodoc
abstract mixin class $PageBackgroundSolidCopyWith<$Res> implements $PageBackgroundCopyWith<$Res> {
  factory $PageBackgroundSolidCopyWith(PageBackgroundSolid value, $Res Function(PageBackgroundSolid) _then) = _$PageBackgroundSolidCopyWithImpl;
@override @useResult
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

/// Create a copy of PageBackground
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? color = null,Object? type = null,}) {
  return _then(PageBackgroundSolid(
color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class PageBackgroundGradient implements PageBackground {
  const PageBackgroundGradient({required final  List<String> colors, final  List<double> stops = const <double>[], this.beginX = 0.0, this.beginY = 0.0, this.endX = 1.0, this.endY = 1.0, this.type = 'gradient'}): _colors = colors,_stops = stops;
  factory PageBackgroundGradient.fromJson(Map<String, dynamic> json) => _$PageBackgroundGradientFromJson(json);

 final  List<String> _colors;
 List<String> get colors {
  if (_colors is EqualUnmodifiableListView) return _colors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_colors);
}

// No default here, and none anywhere in the contract: a non-empty
// collection default crashes the schema generator, which hands the
// analyser's own objects to a literal writer that has no case for them.
// The value belongs where it is read anyway - a gradient with no stops is
// an even gradient, and saying so at the point of drawing is clearer than
// materialising a pair into every document that never asked for one.
 final  List<double> _stops;
// No default here, and none anywhere in the contract: a non-empty
// collection default crashes the schema generator, which hands the
// analyser's own objects to a literal writer that has no case for them.
// The value belongs where it is read anyway - a gradient with no stops is
// an even gradient, and saying so at the point of drawing is clearer than
// materialising a pair into every document that never asked for one.
@JsonKey() List<double> get stops {
  if (_stops is EqualUnmodifiableListView) return _stops;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stops);
}

@JsonKey() final  double beginX;
@JsonKey() final  double beginY;
@JsonKey() final  double endX;
@JsonKey() final  double endY;
@override@JsonKey() final  String type;

/// Create a copy of PageBackground
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PageBackgroundGradientCopyWith<PageBackgroundGradient> get copyWith => _$PageBackgroundGradientCopyWithImpl<PageBackgroundGradient>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PageBackgroundGradientToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PageBackgroundGradient&&const DeepCollectionEquality().equals(other._colors, _colors)&&const DeepCollectionEquality().equals(other._stops, _stops)&&(identical(other.beginX, beginX) || other.beginX == beginX)&&(identical(other.beginY, beginY) || other.beginY == beginY)&&(identical(other.endX, endX) || other.endX == endX)&&(identical(other.endY, endY) || other.endY == endY)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_colors),const DeepCollectionEquality().hash(_stops),beginX,beginY,endX,endY,type);

@override
String toString() {
  return 'PageBackground.gradient(colors: $colors, stops: $stops, beginX: $beginX, beginY: $beginY, endX: $endX, endY: $endY, type: $type)';
}


}

/// @nodoc
abstract mixin class $PageBackgroundGradientCopyWith<$Res> implements $PageBackgroundCopyWith<$Res> {
  factory $PageBackgroundGradientCopyWith(PageBackgroundGradient value, $Res Function(PageBackgroundGradient) _then) = _$PageBackgroundGradientCopyWithImpl;
@override @useResult
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

/// Create a copy of PageBackground
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? colors = null,Object? stops = null,Object? beginX = null,Object? beginY = null,Object? endX = null,Object? endY = null,Object? type = null,}) {
  return _then(PageBackgroundGradient(
colors: null == colors ? _self._colors : colors // ignore: cast_nullable_to_non_nullable
as List<String>,stops: null == stops ? _self._stops : stops // ignore: cast_nullable_to_non_nullable
as List<double>,beginX: null == beginX ? _self.beginX : beginX // ignore: cast_nullable_to_non_nullable
as double,beginY: null == beginY ? _self.beginY : beginY // ignore: cast_nullable_to_non_nullable
as double,endX: null == endX ? _self.endX : endX // ignore: cast_nullable_to_non_nullable
as double,endY: null == endY ? _self.endY : endY // ignore: cast_nullable_to_non_nullable
as double,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class PageBackgroundImage implements PageBackground {
  const PageBackgroundImage({required this.imageUrl, this.fit = BoxFitConfig.cover, this.opacity = 1.0, this.type = 'image'});
  factory PageBackgroundImage.fromJson(Map<String, dynamic> json) => _$PageBackgroundImageFromJson(json);

 final  String imageUrl;
@JsonKey() final  BoxFitConfig fit;
@JsonKey() final  double opacity;
@override@JsonKey() final  String type;

/// Create a copy of PageBackground
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PageBackgroundImageCopyWith<PageBackgroundImage> get copyWith => _$PageBackgroundImageCopyWithImpl<PageBackgroundImage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PageBackgroundImageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PageBackgroundImage&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.fit, fit) || other.fit == fit)&&(identical(other.opacity, opacity) || other.opacity == opacity)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,imageUrl,fit,opacity,type);

@override
String toString() {
  return 'PageBackground.image(imageUrl: $imageUrl, fit: $fit, opacity: $opacity, type: $type)';
}


}

/// @nodoc
abstract mixin class $PageBackgroundImageCopyWith<$Res> implements $PageBackgroundCopyWith<$Res> {
  factory $PageBackgroundImageCopyWith(PageBackgroundImage value, $Res Function(PageBackgroundImage) _then) = _$PageBackgroundImageCopyWithImpl;
@override @useResult
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

/// Create a copy of PageBackground
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? imageUrl = null,Object? fit = null,Object? opacity = null,Object? type = null,}) {
  return _then(PageBackgroundImage(
imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,fit: null == fit ? _self.fit : fit // ignore: cast_nullable_to_non_nullable
as BoxFitConfig,opacity: null == opacity ? _self.opacity : opacity // ignore: cast_nullable_to_non_nullable
as double,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
