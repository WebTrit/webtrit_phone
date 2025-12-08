// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'network_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NetworkState {

 List<IncomingCallTypeModel> get incomingCallTypeModels; List<IncomingCallType> get incomingCallTypesRemainder; bool get smsFallbackEnabled;
/// Create a copy of NetworkState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NetworkStateCopyWith<NetworkState> get copyWith => _$NetworkStateCopyWithImpl<NetworkState>(this as NetworkState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworkState&&const DeepCollectionEquality().equals(other.incomingCallTypeModels, incomingCallTypeModels)&&const DeepCollectionEquality().equals(other.incomingCallTypesRemainder, incomingCallTypesRemainder)&&(identical(other.smsFallbackEnabled, smsFallbackEnabled) || other.smsFallbackEnabled == smsFallbackEnabled));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(incomingCallTypeModels),const DeepCollectionEquality().hash(incomingCallTypesRemainder),smsFallbackEnabled);

@override
String toString() {
  return 'NetworkState(incomingCallTypeModels: $incomingCallTypeModels, incomingCallTypesRemainder: $incomingCallTypesRemainder, smsFallbackEnabled: $smsFallbackEnabled)';
}


}

/// @nodoc
abstract mixin class $NetworkStateCopyWith<$Res>  {
  factory $NetworkStateCopyWith(NetworkState value, $Res Function(NetworkState) _then) = _$NetworkStateCopyWithImpl;
@useResult
$Res call({
 List<IncomingCallTypeModel> incomingCallTypeModels, List<IncomingCallType> incomingCallTypesRemainder, bool smsFallbackEnabled
});




}
/// @nodoc
class _$NetworkStateCopyWithImpl<$Res>
    implements $NetworkStateCopyWith<$Res> {
  _$NetworkStateCopyWithImpl(this._self, this._then);

  final NetworkState _self;
  final $Res Function(NetworkState) _then;

/// Create a copy of NetworkState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? incomingCallTypeModels = null,Object? incomingCallTypesRemainder = null,Object? smsFallbackEnabled = null,}) {
  return _then(NetworkState(
incomingCallTypeModels: null == incomingCallTypeModels ? _self.incomingCallTypeModels : incomingCallTypeModels // ignore: cast_nullable_to_non_nullable
as List<IncomingCallTypeModel>,incomingCallTypesRemainder: null == incomingCallTypesRemainder ? _self.incomingCallTypesRemainder : incomingCallTypesRemainder // ignore: cast_nullable_to_non_nullable
as List<IncomingCallType>,smsFallbackEnabled: null == smsFallbackEnabled ? _self.smsFallbackEnabled : smsFallbackEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [NetworkState].
extension NetworkStatePatterns on NetworkState {
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
