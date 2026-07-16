// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'qr_signin_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QrSigninState {

 QrSigninStatus get status; bool get cameraPermanentlyDenied; QrSigninParseError? get parseError; QrSigninParseResult? get detection;
/// Create a copy of QrSigninState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QrSigninStateCopyWith<QrSigninState> get copyWith => _$QrSigninStateCopyWithImpl<QrSigninState>(this as QrSigninState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QrSigninState&&(identical(other.status, status) || other.status == status)&&(identical(other.cameraPermanentlyDenied, cameraPermanentlyDenied) || other.cameraPermanentlyDenied == cameraPermanentlyDenied)&&(identical(other.parseError, parseError) || other.parseError == parseError)&&(identical(other.detection, detection) || other.detection == detection));
}


@override
int get hashCode => Object.hash(runtimeType,status,cameraPermanentlyDenied,parseError,detection);

@override
String toString() {
  return 'QrSigninState(status: $status, cameraPermanentlyDenied: $cameraPermanentlyDenied, parseError: $parseError, detection: $detection)';
}


}

/// @nodoc
abstract mixin class $QrSigninStateCopyWith<$Res>  {
  factory $QrSigninStateCopyWith(QrSigninState value, $Res Function(QrSigninState) _then) = _$QrSigninStateCopyWithImpl;
@useResult
$Res call({
 QrSigninStatus status, bool cameraPermanentlyDenied, QrSigninParseError? parseError, QrSigninParseResult? detection
});




}
/// @nodoc
class _$QrSigninStateCopyWithImpl<$Res>
    implements $QrSigninStateCopyWith<$Res> {
  _$QrSigninStateCopyWithImpl(this._self, this._then);

  final QrSigninState _self;
  final $Res Function(QrSigninState) _then;

/// Create a copy of QrSigninState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? cameraPermanentlyDenied = null,Object? parseError = freezed,Object? detection = freezed,}) {
  return _then(QrSigninState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as QrSigninStatus,cameraPermanentlyDenied: null == cameraPermanentlyDenied ? _self.cameraPermanentlyDenied : cameraPermanentlyDenied // ignore: cast_nullable_to_non_nullable
as bool,parseError: freezed == parseError ? _self.parseError : parseError // ignore: cast_nullable_to_non_nullable
as QrSigninParseError?,detection: freezed == detection ? _self.detection : detection // ignore: cast_nullable_to_non_nullable
as QrSigninParseResult?,
  ));
}

}


/// Adds pattern-matching-related methods to [QrSigninState].
extension QrSigninStatePatterns on QrSigninState {
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
