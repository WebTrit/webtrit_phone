// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_source.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ImageSource {

 String? get id; String? get uri; String get ref; ImageRenderSpec? get render; Metadata get metadata;
/// Create a copy of ImageSource
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImageSourceCopyWith<ImageSource> get copyWith => _$ImageSourceCopyWithImpl<ImageSource>(this as ImageSource, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImageSource&&(identical(other.id, id) || other.id == id)&&(identical(other.uri, uri) || other.uri == uri)&&(identical(other.ref, ref) || other.ref == ref)&&(identical(other.render, render) || other.render == render)&&(identical(other.metadata, metadata) || other.metadata == metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,uri,ref,render,metadata);

@override
String toString() {
  return 'ImageSource(id: $id, uri: $uri, ref: $ref, render: $render, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $ImageSourceCopyWith<$Res>  {
  factory $ImageSourceCopyWith(ImageSource value, $Res Function(ImageSource) _then) = _$ImageSourceCopyWithImpl;
@useResult
$Res call({
 String? id, String? uri,@JsonKey(name: r'$ref') String ref, ImageRenderSpec? render, Metadata metadata
});




}
/// @nodoc
class _$ImageSourceCopyWithImpl<$Res>
    implements $ImageSourceCopyWith<$Res> {
  _$ImageSourceCopyWithImpl(this._self, this._then);

  final ImageSource _self;
  final $Res Function(ImageSource) _then;

/// Create a copy of ImageSource
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? uri = freezed,Object? ref = null,Object? render = freezed,Object? metadata = null,}) {
  return _then(ImageSource(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,uri: freezed == uri ? _self.uri : uri // ignore: cast_nullable_to_non_nullable
as String?,ref: null == ref ? _self.ref : ref // ignore: cast_nullable_to_non_nullable
as String,render: freezed == render ? _self.render : render // ignore: cast_nullable_to_non_nullable
as ImageRenderSpec?,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Metadata,
  ));
}

}


/// Adds pattern-matching-related methods to [ImageSource].
extension ImageSourcePatterns on ImageSource {
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
mixin _$ImageRenderSpec {

 double? get scale; PaddingConfig? get padding; AlignmentConfig? get alignment; BoxFitConfig? get fit;
/// Create a copy of ImageRenderSpec
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImageRenderSpecCopyWith<ImageRenderSpec> get copyWith => _$ImageRenderSpecCopyWithImpl<ImageRenderSpec>(this as ImageRenderSpec, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImageRenderSpec&&(identical(other.scale, scale) || other.scale == scale)&&(identical(other.padding, padding) || other.padding == padding)&&(identical(other.alignment, alignment) || other.alignment == alignment)&&(identical(other.fit, fit) || other.fit == fit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,scale,padding,alignment,fit);

@override
String toString() {
  return 'ImageRenderSpec(scale: $scale, padding: $padding, alignment: $alignment, fit: $fit)';
}


}

/// @nodoc
abstract mixin class $ImageRenderSpecCopyWith<$Res>  {
  factory $ImageRenderSpecCopyWith(ImageRenderSpec value, $Res Function(ImageRenderSpec) _then) = _$ImageRenderSpecCopyWithImpl;
@useResult
$Res call({
 double? scale, PaddingConfig? padding, AlignmentConfig? alignment, BoxFitConfig? fit
});




}
/// @nodoc
class _$ImageRenderSpecCopyWithImpl<$Res>
    implements $ImageRenderSpecCopyWith<$Res> {
  _$ImageRenderSpecCopyWithImpl(this._self, this._then);

  final ImageRenderSpec _self;
  final $Res Function(ImageRenderSpec) _then;

/// Create a copy of ImageRenderSpec
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? scale = freezed,Object? padding = freezed,Object? alignment = freezed,Object? fit = freezed,}) {
  return _then(ImageRenderSpec(
scale: freezed == scale ? _self.scale : scale // ignore: cast_nullable_to_non_nullable
as double?,padding: freezed == padding ? _self.padding : padding // ignore: cast_nullable_to_non_nullable
as PaddingConfig?,alignment: freezed == alignment ? _self.alignment : alignment // ignore: cast_nullable_to_non_nullable
as AlignmentConfig?,fit: freezed == fit ? _self.fit : fit // ignore: cast_nullable_to_non_nullable
as BoxFitConfig?,
  ));
}

}


/// Adds pattern-matching-related methods to [ImageRenderSpec].
extension ImageRenderSpecPatterns on ImageRenderSpec {
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
