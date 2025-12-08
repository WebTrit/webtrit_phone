// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cdr.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CdrRecord {

 String get callId; String get callee; String get caller; DateTime get connectTime; String get direction; String get disconnectReason; DateTime get disconnectTime; int get duration; dynamic get recordingId; String get status;
/// Create a copy of CdrRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CdrRecordCopyWith<CdrRecord> get copyWith => _$CdrRecordCopyWithImpl<CdrRecord>(this as CdrRecord, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CdrRecord&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.callee, callee) || other.callee == callee)&&(identical(other.caller, caller) || other.caller == caller)&&(identical(other.connectTime, connectTime) || other.connectTime == connectTime)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.disconnectReason, disconnectReason) || other.disconnectReason == disconnectReason)&&(identical(other.disconnectTime, disconnectTime) || other.disconnectTime == disconnectTime)&&(identical(other.duration, duration) || other.duration == duration)&&const DeepCollectionEquality().equals(other.recordingId, recordingId)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,callId,callee,caller,connectTime,direction,disconnectReason,disconnectTime,duration,const DeepCollectionEquality().hash(recordingId),status);

@override
String toString() {
  return 'CdrRecord(callId: $callId, callee: $callee, caller: $caller, connectTime: $connectTime, direction: $direction, disconnectReason: $disconnectReason, disconnectTime: $disconnectTime, duration: $duration, recordingId: $recordingId, status: $status)';
}


}

/// @nodoc
abstract mixin class $CdrRecordCopyWith<$Res>  {
  factory $CdrRecordCopyWith(CdrRecord value, $Res Function(CdrRecord) _then) = _$CdrRecordCopyWithImpl;
@useResult
$Res call({
 String callId, String callee, String caller, DateTime connectTime, String direction, String disconnectReason, DateTime disconnectTime, int duration, dynamic recordingId, String status
});




}
/// @nodoc
class _$CdrRecordCopyWithImpl<$Res>
    implements $CdrRecordCopyWith<$Res> {
  _$CdrRecordCopyWithImpl(this._self, this._then);

  final CdrRecord _self;
  final $Res Function(CdrRecord) _then;

/// Create a copy of CdrRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? callId = null,Object? callee = null,Object? caller = null,Object? connectTime = null,Object? direction = null,Object? disconnectReason = null,Object? disconnectTime = null,Object? duration = null,Object? recordingId = freezed,Object? status = null,}) {
  return _then(CdrRecord(
callId: null == callId ? _self.callId : callId // ignore: cast_nullable_to_non_nullable
as String,callee: null == callee ? _self.callee : callee // ignore: cast_nullable_to_non_nullable
as String,caller: null == caller ? _self.caller : caller // ignore: cast_nullable_to_non_nullable
as String,connectTime: null == connectTime ? _self.connectTime : connectTime // ignore: cast_nullable_to_non_nullable
as DateTime,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String,disconnectReason: null == disconnectReason ? _self.disconnectReason : disconnectReason // ignore: cast_nullable_to_non_nullable
as String,disconnectTime: null == disconnectTime ? _self.disconnectTime : disconnectTime // ignore: cast_nullable_to_non_nullable
as DateTime,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,recordingId: freezed == recordingId ? _self.recordingId : recordingId // ignore: cast_nullable_to_non_nullable
as dynamic,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CdrRecord].
extension CdrRecordPatterns on CdrRecord {
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
mixin _$CdrHistoryResponse {

 List<CdrRecord> get items;
/// Create a copy of CdrHistoryResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CdrHistoryResponseCopyWith<CdrHistoryResponse> get copyWith => _$CdrHistoryResponseCopyWithImpl<CdrHistoryResponse>(this as CdrHistoryResponse, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CdrHistoryResponse&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'CdrHistoryResponse(items: $items)';
}


}

/// @nodoc
abstract mixin class $CdrHistoryResponseCopyWith<$Res>  {
  factory $CdrHistoryResponseCopyWith(CdrHistoryResponse value, $Res Function(CdrHistoryResponse) _then) = _$CdrHistoryResponseCopyWithImpl;
@useResult
$Res call({
 List<CdrRecord> items
});




}
/// @nodoc
class _$CdrHistoryResponseCopyWithImpl<$Res>
    implements $CdrHistoryResponseCopyWith<$Res> {
  _$CdrHistoryResponseCopyWithImpl(this._self, this._then);

  final CdrHistoryResponse _self;
  final $Res Function(CdrHistoryResponse) _then;

/// Create a copy of CdrHistoryResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,}) {
  return _then(CdrHistoryResponse(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<CdrRecord>,
  ));
}

}


/// Adds pattern-matching-related methods to [CdrHistoryResponse].
extension CdrHistoryResponsePatterns on CdrHistoryResponse {
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
