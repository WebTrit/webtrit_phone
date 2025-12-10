// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'microphone_status_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MicrophoneStatusState {

 bool? get microphonePermissionGranted;
/// Create a copy of MicrophoneStatusState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MicrophoneStatusStateCopyWith<MicrophoneStatusState> get copyWith => _$MicrophoneStatusStateCopyWithImpl<MicrophoneStatusState>(this as MicrophoneStatusState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MicrophoneStatusState&&(identical(other.microphonePermissionGranted, microphonePermissionGranted) || other.microphonePermissionGranted == microphonePermissionGranted));
}


@override
int get hashCode => Object.hash(runtimeType,microphonePermissionGranted);

@override
String toString() {
  return 'MicrophoneStatusState(microphonePermissionGranted: $microphonePermissionGranted)';
}


}

/// @nodoc
abstract mixin class $MicrophoneStatusStateCopyWith<$Res>  {
  factory $MicrophoneStatusStateCopyWith(MicrophoneStatusState value, $Res Function(MicrophoneStatusState) _then) = _$MicrophoneStatusStateCopyWithImpl;
@useResult
$Res call({
 bool? microphonePermissionGranted
});




}
/// @nodoc
class _$MicrophoneStatusStateCopyWithImpl<$Res>
    implements $MicrophoneStatusStateCopyWith<$Res> {
  _$MicrophoneStatusStateCopyWithImpl(this._self, this._then);

  final MicrophoneStatusState _self;
  final $Res Function(MicrophoneStatusState) _then;

/// Create a copy of MicrophoneStatusState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? microphonePermissionGranted = freezed,}) {
  return _then(MicrophoneStatusState(
microphonePermissionGranted: freezed == microphonePermissionGranted ? _self.microphonePermissionGranted : microphonePermissionGranted // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [MicrophoneStatusState].
extension MicrophoneStatusStatePatterns on MicrophoneStatusState {
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
