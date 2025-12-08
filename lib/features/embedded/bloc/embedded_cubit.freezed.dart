// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'embedded_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EmbeddedState {

 Map<String, dynamic> get payload; String get currentUrl; bool get canGoBack; EmbeddedIntents? get intent;
/// Create a copy of EmbeddedState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmbeddedStateCopyWith<EmbeddedState> get copyWith => _$EmbeddedStateCopyWithImpl<EmbeddedState>(this as EmbeddedState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmbeddedState&&const DeepCollectionEquality().equals(other.payload, payload)&&(identical(other.currentUrl, currentUrl) || other.currentUrl == currentUrl)&&(identical(other.canGoBack, canGoBack) || other.canGoBack == canGoBack)&&(identical(other.intent, intent) || other.intent == intent));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(payload),currentUrl,canGoBack,intent);

@override
String toString() {
  return 'EmbeddedState(payload: $payload, currentUrl: $currentUrl, canGoBack: $canGoBack, intent: $intent)';
}


}

/// @nodoc
abstract mixin class $EmbeddedStateCopyWith<$Res>  {
  factory $EmbeddedStateCopyWith(EmbeddedState value, $Res Function(EmbeddedState) _then) = _$EmbeddedStateCopyWithImpl;
@useResult
$Res call({
 Map<String, dynamic> payload, String currentUrl, bool canGoBack, EmbeddedIntents? intent
});




}
/// @nodoc
class _$EmbeddedStateCopyWithImpl<$Res>
    implements $EmbeddedStateCopyWith<$Res> {
  _$EmbeddedStateCopyWithImpl(this._self, this._then);

  final EmbeddedState _self;
  final $Res Function(EmbeddedState) _then;

/// Create a copy of EmbeddedState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? payload = null,Object? currentUrl = null,Object? canGoBack = null,Object? intent = freezed,}) {
  return _then(EmbeddedState(
payload: null == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,currentUrl: null == currentUrl ? _self.currentUrl : currentUrl // ignore: cast_nullable_to_non_nullable
as String,canGoBack: null == canGoBack ? _self.canGoBack : canGoBack // ignore: cast_nullable_to_non_nullable
as bool,intent: freezed == intent ? _self.intent : intent // ignore: cast_nullable_to_non_nullable
as EmbeddedIntents?,
  ));
}

}


/// Adds pattern-matching-related methods to [EmbeddedState].
extension EmbeddedStatePatterns on EmbeddedState {
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
