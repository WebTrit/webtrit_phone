// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contact_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ContactState {

 Contact? get contact; bool get deleted; List<PresenceInfo> get presenceInfo;
/// Create a copy of ContactState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContactStateCopyWith<ContactState> get copyWith => _$ContactStateCopyWithImpl<ContactState>(this as ContactState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContactState&&(identical(other.contact, contact) || other.contact == contact)&&(identical(other.deleted, deleted) || other.deleted == deleted)&&const DeepCollectionEquality().equals(other.presenceInfo, presenceInfo));
}


@override
int get hashCode => Object.hash(runtimeType,contact,deleted,const DeepCollectionEquality().hash(presenceInfo));

@override
String toString() {
  return 'ContactState(contact: $contact, deleted: $deleted, presenceInfo: $presenceInfo)';
}


}

/// @nodoc
abstract mixin class $ContactStateCopyWith<$Res>  {
  factory $ContactStateCopyWith(ContactState value, $Res Function(ContactState) _then) = _$ContactStateCopyWithImpl;
@useResult
$Res call({
 Contact? contact, bool deleted, List<PresenceInfo> presenceInfo
});




}
/// @nodoc
class _$ContactStateCopyWithImpl<$Res>
    implements $ContactStateCopyWith<$Res> {
  _$ContactStateCopyWithImpl(this._self, this._then);

  final ContactState _self;
  final $Res Function(ContactState) _then;

/// Create a copy of ContactState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? contact = freezed,Object? deleted = null,Object? presenceInfo = null,}) {
  return _then(ContactState(
contact: freezed == contact ? _self.contact : contact // ignore: cast_nullable_to_non_nullable
as Contact?,deleted: null == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as bool,presenceInfo: null == presenceInfo ? _self.presenceInfo : presenceInfo // ignore: cast_nullable_to_non_nullable
as List<PresenceInfo>,
  ));
}

}


/// Adds pattern-matching-related methods to [ContactState].
extension ContactStatePatterns on ContactState {
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
