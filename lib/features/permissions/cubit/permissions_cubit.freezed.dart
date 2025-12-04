// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'permissions_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PermissionsState {

 bool get initialRequestCompleted; bool get isPermanentlyDenied; bool get isRequesting; List<CallkeepSpecialPermissions> get missingSpecialPermissions; ManufacturerTip? get manufacturerTip; Object? get failure;
/// Create a copy of PermissionsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PermissionsStateCopyWith<PermissionsState> get copyWith => _$PermissionsStateCopyWithImpl<PermissionsState>(this as PermissionsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PermissionsState&&(identical(other.initialRequestCompleted, initialRequestCompleted) || other.initialRequestCompleted == initialRequestCompleted)&&(identical(other.isPermanentlyDenied, isPermanentlyDenied) || other.isPermanentlyDenied == isPermanentlyDenied)&&(identical(other.isRequesting, isRequesting) || other.isRequesting == isRequesting)&&const DeepCollectionEquality().equals(other.missingSpecialPermissions, missingSpecialPermissions)&&(identical(other.manufacturerTip, manufacturerTip) || other.manufacturerTip == manufacturerTip)&&const DeepCollectionEquality().equals(other.failure, failure));
}


@override
int get hashCode => Object.hash(runtimeType,initialRequestCompleted,isPermanentlyDenied,isRequesting,const DeepCollectionEquality().hash(missingSpecialPermissions),manufacturerTip,const DeepCollectionEquality().hash(failure));

@override
String toString() {
  return 'PermissionsState(initialRequestCompleted: $initialRequestCompleted, isPermanentlyDenied: $isPermanentlyDenied, isRequesting: $isRequesting, missingSpecialPermissions: $missingSpecialPermissions, manufacturerTip: $manufacturerTip, failure: $failure)';
}


}

/// @nodoc
abstract mixin class $PermissionsStateCopyWith<$Res>  {
  factory $PermissionsStateCopyWith(PermissionsState value, $Res Function(PermissionsState) _then) = _$PermissionsStateCopyWithImpl;
@useResult
$Res call({
 bool initialRequestCompleted, bool isPermanentlyDenied, bool isRequesting, List<CallkeepSpecialPermissions> missingSpecialPermissions, ManufacturerTip? manufacturerTip, Object? failure
});




}
/// @nodoc
class _$PermissionsStateCopyWithImpl<$Res>
    implements $PermissionsStateCopyWith<$Res> {
  _$PermissionsStateCopyWithImpl(this._self, this._then);

  final PermissionsState _self;
  final $Res Function(PermissionsState) _then;

/// Create a copy of PermissionsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? initialRequestCompleted = null,Object? isPermanentlyDenied = null,Object? isRequesting = null,Object? missingSpecialPermissions = null,Object? manufacturerTip = freezed,Object? failure = freezed,}) {
  return _then(PermissionsState(
initialRequestCompleted: null == initialRequestCompleted ? _self.initialRequestCompleted : initialRequestCompleted // ignore: cast_nullable_to_non_nullable
as bool,isPermanentlyDenied: null == isPermanentlyDenied ? _self.isPermanentlyDenied : isPermanentlyDenied // ignore: cast_nullable_to_non_nullable
as bool,isRequesting: null == isRequesting ? _self.isRequesting : isRequesting // ignore: cast_nullable_to_non_nullable
as bool,missingSpecialPermissions: null == missingSpecialPermissions ? _self.missingSpecialPermissions : missingSpecialPermissions // ignore: cast_nullable_to_non_nullable
as List<CallkeepSpecialPermissions>,manufacturerTip: freezed == manufacturerTip ? _self.manufacturerTip : manufacturerTip // ignore: cast_nullable_to_non_nullable
as ManufacturerTip?,failure: freezed == failure ? _self.failure : failure ,
  ));
}

}


/// Adds pattern-matching-related methods to [PermissionsState].
extension PermissionsStatePatterns on PermissionsState {
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
mixin _$ManufacturerTip {

 Manufacturer get manufacturer; bool get shown;
/// Create a copy of ManufacturerTip
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ManufacturerTipCopyWith<ManufacturerTip> get copyWith => _$ManufacturerTipCopyWithImpl<ManufacturerTip>(this as ManufacturerTip, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ManufacturerTip&&(identical(other.manufacturer, manufacturer) || other.manufacturer == manufacturer)&&(identical(other.shown, shown) || other.shown == shown));
}


@override
int get hashCode => Object.hash(runtimeType,manufacturer,shown);

@override
String toString() {
  return 'ManufacturerTip(manufacturer: $manufacturer, shown: $shown)';
}


}

/// @nodoc
abstract mixin class $ManufacturerTipCopyWith<$Res>  {
  factory $ManufacturerTipCopyWith(ManufacturerTip value, $Res Function(ManufacturerTip) _then) = _$ManufacturerTipCopyWithImpl;
@useResult
$Res call({
 Manufacturer manufacturer, bool shown
});




}
/// @nodoc
class _$ManufacturerTipCopyWithImpl<$Res>
    implements $ManufacturerTipCopyWith<$Res> {
  _$ManufacturerTipCopyWithImpl(this._self, this._then);

  final ManufacturerTip _self;
  final $Res Function(ManufacturerTip) _then;

/// Create a copy of ManufacturerTip
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? manufacturer = null,Object? shown = null,}) {
  return _then(ManufacturerTip(
manufacturer: null == manufacturer ? _self.manufacturer : manufacturer // ignore: cast_nullable_to_non_nullable
as Manufacturer,shown: null == shown ? _self.shown : shown // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ManufacturerTip].
extension ManufacturerTipPatterns on ManufacturerTip {
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
