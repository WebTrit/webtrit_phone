// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CallState {

 CallServiceState get callServiceState; AppLifecycleState? get currentAppLifecycleState; int get linesCount; List<ActiveCall> get activeCalls; bool? get minimized; bool? get speakerOnBeforeMinimize; CallAudioDevice? get audioDevice; List<CallAudioDevice> get availableAudioDevices;
/// Create a copy of CallState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallStateCopyWith<CallState> get copyWith => _$CallStateCopyWithImpl<CallState>(this as CallState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallState&&(identical(other.callServiceState, callServiceState) || other.callServiceState == callServiceState)&&(identical(other.currentAppLifecycleState, currentAppLifecycleState) || other.currentAppLifecycleState == currentAppLifecycleState)&&(identical(other.linesCount, linesCount) || other.linesCount == linesCount)&&const DeepCollectionEquality().equals(other.activeCalls, activeCalls)&&(identical(other.minimized, minimized) || other.minimized == minimized)&&(identical(other.speakerOnBeforeMinimize, speakerOnBeforeMinimize) || other.speakerOnBeforeMinimize == speakerOnBeforeMinimize)&&(identical(other.audioDevice, audioDevice) || other.audioDevice == audioDevice)&&const DeepCollectionEquality().equals(other.availableAudioDevices, availableAudioDevices));
}


@override
int get hashCode => Object.hash(runtimeType,callServiceState,currentAppLifecycleState,linesCount,const DeepCollectionEquality().hash(activeCalls),minimized,speakerOnBeforeMinimize,audioDevice,const DeepCollectionEquality().hash(availableAudioDevices));

@override
String toString() {
  return 'CallState(callServiceState: $callServiceState, currentAppLifecycleState: $currentAppLifecycleState, linesCount: $linesCount, activeCalls: $activeCalls, minimized: $minimized, speakerOnBeforeMinimize: $speakerOnBeforeMinimize, audioDevice: $audioDevice, availableAudioDevices: $availableAudioDevices)';
}


}

/// @nodoc
abstract mixin class $CallStateCopyWith<$Res>  {
  factory $CallStateCopyWith(CallState value, $Res Function(CallState) _then) = _$CallStateCopyWithImpl;
@useResult
$Res call({
 CallServiceState callServiceState, AppLifecycleState? currentAppLifecycleState, int linesCount, List<ActiveCall> activeCalls, bool? minimized, bool? speakerOnBeforeMinimize, CallAudioDevice? audioDevice, List<CallAudioDevice> availableAudioDevices
});




}
/// @nodoc
class _$CallStateCopyWithImpl<$Res>
    implements $CallStateCopyWith<$Res> {
  _$CallStateCopyWithImpl(this._self, this._then);

  final CallState _self;
  final $Res Function(CallState) _then;

/// Create a copy of CallState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? callServiceState = null,Object? currentAppLifecycleState = freezed,Object? linesCount = null,Object? activeCalls = null,Object? minimized = freezed,Object? speakerOnBeforeMinimize = freezed,Object? audioDevice = freezed,Object? availableAudioDevices = null,}) {
  return _then(CallState(
callServiceState: null == callServiceState ? _self.callServiceState : callServiceState // ignore: cast_nullable_to_non_nullable
as CallServiceState,currentAppLifecycleState: freezed == currentAppLifecycleState ? _self.currentAppLifecycleState : currentAppLifecycleState // ignore: cast_nullable_to_non_nullable
as AppLifecycleState?,linesCount: null == linesCount ? _self.linesCount : linesCount // ignore: cast_nullable_to_non_nullable
as int,activeCalls: null == activeCalls ? _self.activeCalls : activeCalls // ignore: cast_nullable_to_non_nullable
as List<ActiveCall>,minimized: freezed == minimized ? _self.minimized : minimized // ignore: cast_nullable_to_non_nullable
as bool?,speakerOnBeforeMinimize: freezed == speakerOnBeforeMinimize ? _self.speakerOnBeforeMinimize : speakerOnBeforeMinimize // ignore: cast_nullable_to_non_nullable
as bool?,audioDevice: freezed == audioDevice ? _self.audioDevice : audioDevice // ignore: cast_nullable_to_non_nullable
as CallAudioDevice?,availableAudioDevices: null == availableAudioDevices ? _self.availableAudioDevices : availableAudioDevices // ignore: cast_nullable_to_non_nullable
as List<CallAudioDevice>,
  ));
}

}


/// Adds pattern-matching-related methods to [CallState].
extension CallStatePatterns on CallState {
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
mixin _$ActiveCall {

 CallDirection get direction; int? get line; String get callId; CallkeepHandle get handle; DateTime get createdTime; bool get video; CallProcessingStatus get processingStatus; bool? get frontCamera; bool get held; bool get muted; bool get updating; JsepValue? get incomingOffer; String? get displayName; String? get fromReferId; String? get fromReplaces; String? get fromNumber; DateTime? get acceptedTime; DateTime? get hungUpTime; Transfer? get transfer; Object? get failure; MediaStream? get localStream; MediaStream? get remoteStream;
/// Create a copy of ActiveCall
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ActiveCallCopyWith<ActiveCall> get copyWith => _$ActiveCallCopyWithImpl<ActiveCall>(this as ActiveCall, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ActiveCall&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.line, line) || other.line == line)&&(identical(other.callId, callId) || other.callId == callId)&&(identical(other.handle, handle) || other.handle == handle)&&(identical(other.createdTime, createdTime) || other.createdTime == createdTime)&&(identical(other.video, video) || other.video == video)&&(identical(other.processingStatus, processingStatus) || other.processingStatus == processingStatus)&&(identical(other.frontCamera, frontCamera) || other.frontCamera == frontCamera)&&(identical(other.held, held) || other.held == held)&&(identical(other.muted, muted) || other.muted == muted)&&(identical(other.updating, updating) || other.updating == updating)&&(identical(other.incomingOffer, incomingOffer) || other.incomingOffer == incomingOffer)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.fromReferId, fromReferId) || other.fromReferId == fromReferId)&&(identical(other.fromReplaces, fromReplaces) || other.fromReplaces == fromReplaces)&&(identical(other.fromNumber, fromNumber) || other.fromNumber == fromNumber)&&(identical(other.acceptedTime, acceptedTime) || other.acceptedTime == acceptedTime)&&(identical(other.hungUpTime, hungUpTime) || other.hungUpTime == hungUpTime)&&(identical(other.transfer, transfer) || other.transfer == transfer)&&const DeepCollectionEquality().equals(other.failure, failure)&&(identical(other.localStream, localStream) || other.localStream == localStream)&&(identical(other.remoteStream, remoteStream) || other.remoteStream == remoteStream));
}


@override
int get hashCode => Object.hashAll([runtimeType,direction,line,callId,handle,createdTime,video,processingStatus,frontCamera,held,muted,updating,incomingOffer,displayName,fromReferId,fromReplaces,fromNumber,acceptedTime,hungUpTime,transfer,const DeepCollectionEquality().hash(failure),localStream,remoteStream]);

@override
String toString() {
  return 'ActiveCall(direction: $direction, line: $line, callId: $callId, handle: $handle, createdTime: $createdTime, video: $video, processingStatus: $processingStatus, frontCamera: $frontCamera, held: $held, muted: $muted, updating: $updating, incomingOffer: $incomingOffer, displayName: $displayName, fromReferId: $fromReferId, fromReplaces: $fromReplaces, fromNumber: $fromNumber, acceptedTime: $acceptedTime, hungUpTime: $hungUpTime, transfer: $transfer, failure: $failure, localStream: $localStream, remoteStream: $remoteStream)';
}


}

/// @nodoc
abstract mixin class $ActiveCallCopyWith<$Res>  {
  factory $ActiveCallCopyWith(ActiveCall value, $Res Function(ActiveCall) _then) = _$ActiveCallCopyWithImpl;
@useResult
$Res call({
 CallDirection direction, int? line, String callId, CallkeepHandle handle, DateTime createdTime, bool video, CallProcessingStatus processingStatus, bool? frontCamera, bool held, bool muted, bool updating, JsepValue? incomingOffer, String? displayName, String? fromReferId, String? fromReplaces, String? fromNumber, DateTime? acceptedTime, DateTime? hungUpTime, Transfer? transfer, Object? failure, MediaStream? localStream, MediaStream? remoteStream
});




}
/// @nodoc
class _$ActiveCallCopyWithImpl<$Res>
    implements $ActiveCallCopyWith<$Res> {
  _$ActiveCallCopyWithImpl(this._self, this._then);

  final ActiveCall _self;
  final $Res Function(ActiveCall) _then;

/// Create a copy of ActiveCall
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? direction = null,Object? line = freezed,Object? callId = null,Object? handle = null,Object? createdTime = null,Object? video = null,Object? processingStatus = null,Object? frontCamera = freezed,Object? held = null,Object? muted = null,Object? updating = null,Object? incomingOffer = freezed,Object? displayName = freezed,Object? fromReferId = freezed,Object? fromReplaces = freezed,Object? fromNumber = freezed,Object? acceptedTime = freezed,Object? hungUpTime = freezed,Object? transfer = freezed,Object? failure = freezed,Object? localStream = freezed,Object? remoteStream = freezed,}) {
  return _then(ActiveCall(
direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as CallDirection,line: freezed == line ? _self.line : line // ignore: cast_nullable_to_non_nullable
as int?,callId: null == callId ? _self.callId : callId // ignore: cast_nullable_to_non_nullable
as String,handle: null == handle ? _self.handle : handle // ignore: cast_nullable_to_non_nullable
as CallkeepHandle,createdTime: null == createdTime ? _self.createdTime : createdTime // ignore: cast_nullable_to_non_nullable
as DateTime,video: null == video ? _self.video : video // ignore: cast_nullable_to_non_nullable
as bool,processingStatus: null == processingStatus ? _self.processingStatus : processingStatus // ignore: cast_nullable_to_non_nullable
as CallProcessingStatus,frontCamera: freezed == frontCamera ? _self.frontCamera : frontCamera // ignore: cast_nullable_to_non_nullable
as bool?,held: null == held ? _self.held : held // ignore: cast_nullable_to_non_nullable
as bool,muted: null == muted ? _self.muted : muted // ignore: cast_nullable_to_non_nullable
as bool,updating: null == updating ? _self.updating : updating // ignore: cast_nullable_to_non_nullable
as bool,incomingOffer: freezed == incomingOffer ? _self.incomingOffer : incomingOffer // ignore: cast_nullable_to_non_nullable
as JsepValue?,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,fromReferId: freezed == fromReferId ? _self.fromReferId : fromReferId // ignore: cast_nullable_to_non_nullable
as String?,fromReplaces: freezed == fromReplaces ? _self.fromReplaces : fromReplaces // ignore: cast_nullable_to_non_nullable
as String?,fromNumber: freezed == fromNumber ? _self.fromNumber : fromNumber // ignore: cast_nullable_to_non_nullable
as String?,acceptedTime: freezed == acceptedTime ? _self.acceptedTime : acceptedTime // ignore: cast_nullable_to_non_nullable
as DateTime?,hungUpTime: freezed == hungUpTime ? _self.hungUpTime : hungUpTime // ignore: cast_nullable_to_non_nullable
as DateTime?,transfer: freezed == transfer ? _self.transfer : transfer // ignore: cast_nullable_to_non_nullable
as Transfer?,failure: freezed == failure ? _self.failure : failure ,localStream: freezed == localStream ? _self.localStream : localStream // ignore: cast_nullable_to_non_nullable
as MediaStream?,remoteStream: freezed == remoteStream ? _self.remoteStream : remoteStream // ignore: cast_nullable_to_non_nullable
as MediaStream?,
  ));
}

}


/// Adds pattern-matching-related methods to [ActiveCall].
extension ActiveCallPatterns on ActiveCall {
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
mixin _$CallAudioDevice {

 CallAudioDeviceType get type; String? get id; String? get name;
/// Create a copy of CallAudioDevice
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CallAudioDeviceCopyWith<CallAudioDevice> get copyWith => _$CallAudioDeviceCopyWithImpl<CallAudioDevice>(this as CallAudioDevice, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CallAudioDevice&&(identical(other.type, type) || other.type == type)&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,type,id,name);

@override
String toString() {
  return 'CallAudioDevice(type: $type, id: $id, name: $name)';
}


}

/// @nodoc
abstract mixin class $CallAudioDeviceCopyWith<$Res>  {
  factory $CallAudioDeviceCopyWith(CallAudioDevice value, $Res Function(CallAudioDevice) _then) = _$CallAudioDeviceCopyWithImpl;
@useResult
$Res call({
 CallAudioDeviceType type, String? id, String? name
});




}
/// @nodoc
class _$CallAudioDeviceCopyWithImpl<$Res>
    implements $CallAudioDeviceCopyWith<$Res> {
  _$CallAudioDeviceCopyWithImpl(this._self, this._then);

  final CallAudioDevice _self;
  final $Res Function(CallAudioDevice) _then;

/// Create a copy of CallAudioDevice
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? id = freezed,Object? name = freezed,}) {
  return _then(CallAudioDevice(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CallAudioDeviceType,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CallAudioDevice].
extension CallAudioDevicePatterns on CallAudioDevice {
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
