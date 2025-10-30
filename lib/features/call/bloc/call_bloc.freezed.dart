// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CallState {
  CallServiceState get callServiceState => throw _privateConstructorUsedError;
  AppLifecycleState? get currentAppLifecycleState =>
      throw _privateConstructorUsedError;
  int get linesCount => throw _privateConstructorUsedError;
  List<ActiveCall> get activeCalls => throw _privateConstructorUsedError;
  bool? get minimized => throw _privateConstructorUsedError;
  bool? get speakerOnBeforeMinimize => throw _privateConstructorUsedError;
  CallAudioDevice? get audioDevice => throw _privateConstructorUsedError;
  List<CallAudioDevice> get availableAudioDevices =>
      throw _privateConstructorUsedError;

  /// Create a copy of CallState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CallStateCopyWith<CallState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CallStateCopyWith<$Res> {
  factory $CallStateCopyWith(CallState value, $Res Function(CallState) then) =
      _$CallStateCopyWithImpl<$Res, CallState>;
  @useResult
  $Res call(
      {CallServiceState callServiceState,
      AppLifecycleState? currentAppLifecycleState,
      int linesCount,
      List<ActiveCall> activeCalls,
      bool? minimized,
      bool? speakerOnBeforeMinimize,
      CallAudioDevice? audioDevice,
      List<CallAudioDevice> availableAudioDevices});

  $CallServiceStateCopyWith<$Res> get callServiceState;
  $CallAudioDeviceCopyWith<$Res>? get audioDevice;
}

/// @nodoc
class _$CallStateCopyWithImpl<$Res, $Val extends CallState>
    implements $CallStateCopyWith<$Res> {
  _$CallStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CallState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? callServiceState = null,
    Object? currentAppLifecycleState = freezed,
    Object? linesCount = null,
    Object? activeCalls = null,
    Object? minimized = freezed,
    Object? speakerOnBeforeMinimize = freezed,
    Object? audioDevice = freezed,
    Object? availableAudioDevices = null,
  }) {
    return _then(_value.copyWith(
      callServiceState: null == callServiceState
          ? _value.callServiceState
          : callServiceState // ignore: cast_nullable_to_non_nullable
              as CallServiceState,
      currentAppLifecycleState: freezed == currentAppLifecycleState
          ? _value.currentAppLifecycleState
          : currentAppLifecycleState // ignore: cast_nullable_to_non_nullable
              as AppLifecycleState?,
      linesCount: null == linesCount
          ? _value.linesCount
          : linesCount // ignore: cast_nullable_to_non_nullable
              as int,
      activeCalls: null == activeCalls
          ? _value.activeCalls
          : activeCalls // ignore: cast_nullable_to_non_nullable
              as List<ActiveCall>,
      minimized: freezed == minimized
          ? _value.minimized
          : minimized // ignore: cast_nullable_to_non_nullable
              as bool?,
      speakerOnBeforeMinimize: freezed == speakerOnBeforeMinimize
          ? _value.speakerOnBeforeMinimize
          : speakerOnBeforeMinimize // ignore: cast_nullable_to_non_nullable
              as bool?,
      audioDevice: freezed == audioDevice
          ? _value.audioDevice
          : audioDevice // ignore: cast_nullable_to_non_nullable
              as CallAudioDevice?,
      availableAudioDevices: null == availableAudioDevices
          ? _value.availableAudioDevices
          : availableAudioDevices // ignore: cast_nullable_to_non_nullable
              as List<CallAudioDevice>,
    ) as $Val);
  }

  /// Create a copy of CallState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CallServiceStateCopyWith<$Res> get callServiceState {
    return $CallServiceStateCopyWith<$Res>(_value.callServiceState, (value) {
      return _then(_value.copyWith(callServiceState: value) as $Val);
    });
  }

  /// Create a copy of CallState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CallAudioDeviceCopyWith<$Res>? get audioDevice {
    if (_value.audioDevice == null) {
      return null;
    }

    return $CallAudioDeviceCopyWith<$Res>(_value.audioDevice!, (value) {
      return _then(_value.copyWith(audioDevice: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CallStateImplCopyWith<$Res>
    implements $CallStateCopyWith<$Res> {
  factory _$$CallStateImplCopyWith(
          _$CallStateImpl value, $Res Function(_$CallStateImpl) then) =
      __$$CallStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {CallServiceState callServiceState,
      AppLifecycleState? currentAppLifecycleState,
      int linesCount,
      List<ActiveCall> activeCalls,
      bool? minimized,
      bool? speakerOnBeforeMinimize,
      CallAudioDevice? audioDevice,
      List<CallAudioDevice> availableAudioDevices});

  @override
  $CallServiceStateCopyWith<$Res> get callServiceState;
  @override
  $CallAudioDeviceCopyWith<$Res>? get audioDevice;
}

/// @nodoc
class __$$CallStateImplCopyWithImpl<$Res>
    extends _$CallStateCopyWithImpl<$Res, _$CallStateImpl>
    implements _$$CallStateImplCopyWith<$Res> {
  __$$CallStateImplCopyWithImpl(
      _$CallStateImpl _value, $Res Function(_$CallStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CallState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? callServiceState = null,
    Object? currentAppLifecycleState = freezed,
    Object? linesCount = null,
    Object? activeCalls = null,
    Object? minimized = freezed,
    Object? speakerOnBeforeMinimize = freezed,
    Object? audioDevice = freezed,
    Object? availableAudioDevices = null,
  }) {
    return _then(_$CallStateImpl(
      callServiceState: null == callServiceState
          ? _value.callServiceState
          : callServiceState // ignore: cast_nullable_to_non_nullable
              as CallServiceState,
      currentAppLifecycleState: freezed == currentAppLifecycleState
          ? _value.currentAppLifecycleState
          : currentAppLifecycleState // ignore: cast_nullable_to_non_nullable
              as AppLifecycleState?,
      linesCount: null == linesCount
          ? _value.linesCount
          : linesCount // ignore: cast_nullable_to_non_nullable
              as int,
      activeCalls: null == activeCalls
          ? _value._activeCalls
          : activeCalls // ignore: cast_nullable_to_non_nullable
              as List<ActiveCall>,
      minimized: freezed == minimized
          ? _value.minimized
          : minimized // ignore: cast_nullable_to_non_nullable
              as bool?,
      speakerOnBeforeMinimize: freezed == speakerOnBeforeMinimize
          ? _value.speakerOnBeforeMinimize
          : speakerOnBeforeMinimize // ignore: cast_nullable_to_non_nullable
              as bool?,
      audioDevice: freezed == audioDevice
          ? _value.audioDevice
          : audioDevice // ignore: cast_nullable_to_non_nullable
              as CallAudioDevice?,
      availableAudioDevices: null == availableAudioDevices
          ? _value._availableAudioDevices
          : availableAudioDevices // ignore: cast_nullable_to_non_nullable
              as List<CallAudioDevice>,
    ));
  }
}

/// @nodoc

class _$CallStateImpl extends _CallState {
  const _$CallStateImpl(
      {this.callServiceState = const CallServiceState(),
      this.currentAppLifecycleState,
      this.linesCount = 0,
      final List<ActiveCall> activeCalls = const [],
      this.minimized,
      this.speakerOnBeforeMinimize,
      this.audioDevice,
      final List<CallAudioDevice> availableAudioDevices = const []})
      : _activeCalls = activeCalls,
        _availableAudioDevices = availableAudioDevices,
        super._();

  @override
  @JsonKey()
  final CallServiceState callServiceState;
  @override
  final AppLifecycleState? currentAppLifecycleState;
  @override
  @JsonKey()
  final int linesCount;
  final List<ActiveCall> _activeCalls;
  @override
  @JsonKey()
  List<ActiveCall> get activeCalls {
    if (_activeCalls is EqualUnmodifiableListView) return _activeCalls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_activeCalls);
  }

  @override
  final bool? minimized;
  @override
  final bool? speakerOnBeforeMinimize;
  @override
  final CallAudioDevice? audioDevice;
  final List<CallAudioDevice> _availableAudioDevices;
  @override
  @JsonKey()
  List<CallAudioDevice> get availableAudioDevices {
    if (_availableAudioDevices is EqualUnmodifiableListView)
      return _availableAudioDevices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableAudioDevices);
  }

  @override
  String toString() {
    return 'CallState(callServiceState: $callServiceState, currentAppLifecycleState: $currentAppLifecycleState, linesCount: $linesCount, activeCalls: $activeCalls, minimized: $minimized, speakerOnBeforeMinimize: $speakerOnBeforeMinimize, audioDevice: $audioDevice, availableAudioDevices: $availableAudioDevices)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallStateImpl &&
            (identical(other.callServiceState, callServiceState) ||
                other.callServiceState == callServiceState) &&
            (identical(
                    other.currentAppLifecycleState, currentAppLifecycleState) ||
                other.currentAppLifecycleState == currentAppLifecycleState) &&
            (identical(other.linesCount, linesCount) ||
                other.linesCount == linesCount) &&
            const DeepCollectionEquality()
                .equals(other._activeCalls, _activeCalls) &&
            (identical(other.minimized, minimized) ||
                other.minimized == minimized) &&
            (identical(
                    other.speakerOnBeforeMinimize, speakerOnBeforeMinimize) ||
                other.speakerOnBeforeMinimize == speakerOnBeforeMinimize) &&
            (identical(other.audioDevice, audioDevice) ||
                other.audioDevice == audioDevice) &&
            const DeepCollectionEquality()
                .equals(other._availableAudioDevices, _availableAudioDevices));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      callServiceState,
      currentAppLifecycleState,
      linesCount,
      const DeepCollectionEquality().hash(_activeCalls),
      minimized,
      speakerOnBeforeMinimize,
      audioDevice,
      const DeepCollectionEquality().hash(_availableAudioDevices));

  /// Create a copy of CallState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CallStateImplCopyWith<_$CallStateImpl> get copyWith =>
      __$$CallStateImplCopyWithImpl<_$CallStateImpl>(this, _$identity);
}

abstract class _CallState extends CallState {
  const factory _CallState(
      {final CallServiceState callServiceState,
      final AppLifecycleState? currentAppLifecycleState,
      final int linesCount,
      final List<ActiveCall> activeCalls,
      final bool? minimized,
      final bool? speakerOnBeforeMinimize,
      final CallAudioDevice? audioDevice,
      final List<CallAudioDevice> availableAudioDevices}) = _$CallStateImpl;
  const _CallState._() : super._();

  @override
  CallServiceState get callServiceState;
  @override
  AppLifecycleState? get currentAppLifecycleState;
  @override
  int get linesCount;
  @override
  List<ActiveCall> get activeCalls;
  @override
  bool? get minimized;
  @override
  bool? get speakerOnBeforeMinimize;
  @override
  CallAudioDevice? get audioDevice;
  @override
  List<CallAudioDevice> get availableAudioDevices;

  /// Create a copy of CallState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CallStateImplCopyWith<_$CallStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ActiveCall {
  CallDirection get direction => throw _privateConstructorUsedError;
  int? get line => throw _privateConstructorUsedError;
  String get callId => throw _privateConstructorUsedError;
  CallkeepHandle get handle => throw _privateConstructorUsedError;
  DateTime get createdTime => throw _privateConstructorUsedError;
  bool get video => throw _privateConstructorUsedError;
  CallProcessingStatus get processingStatus =>
      throw _privateConstructorUsedError;
  bool? get frontCamera => throw _privateConstructorUsedError;
  bool get held => throw _privateConstructorUsedError;
  bool get muted => throw _privateConstructorUsedError;
  bool get updating => throw _privateConstructorUsedError;
  JsepValue? get incomingOffer => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  String? get fromReferId => throw _privateConstructorUsedError;
  String? get fromReplaces => throw _privateConstructorUsedError;
  String? get fromNumber => throw _privateConstructorUsedError;
  DateTime? get acceptedTime => throw _privateConstructorUsedError;
  DateTime? get hungUpTime => throw _privateConstructorUsedError;
  Transfer? get transfer => throw _privateConstructorUsedError;
  Object? get failure => throw _privateConstructorUsedError;
  MediaStream? get localStream => throw _privateConstructorUsedError;
  MediaStream? get remoteStream => throw _privateConstructorUsedError;

  /// Create a copy of ActiveCall
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActiveCallCopyWith<ActiveCall> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActiveCallCopyWith<$Res> {
  factory $ActiveCallCopyWith(
          ActiveCall value, $Res Function(ActiveCall) then) =
      _$ActiveCallCopyWithImpl<$Res, ActiveCall>;
  @useResult
  $Res call(
      {CallDirection direction,
      int? line,
      String callId,
      CallkeepHandle handle,
      DateTime createdTime,
      bool video,
      CallProcessingStatus processingStatus,
      bool? frontCamera,
      bool held,
      bool muted,
      bool updating,
      JsepValue? incomingOffer,
      String? displayName,
      String? fromReferId,
      String? fromReplaces,
      String? fromNumber,
      DateTime? acceptedTime,
      DateTime? hungUpTime,
      Transfer? transfer,
      Object? failure,
      MediaStream? localStream,
      MediaStream? remoteStream});

  $TransferCopyWith<$Res>? get transfer;
}

/// @nodoc
class _$ActiveCallCopyWithImpl<$Res, $Val extends ActiveCall>
    implements $ActiveCallCopyWith<$Res> {
  _$ActiveCallCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ActiveCall
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? direction = null,
    Object? line = freezed,
    Object? callId = null,
    Object? handle = null,
    Object? createdTime = null,
    Object? video = null,
    Object? processingStatus = null,
    Object? frontCamera = freezed,
    Object? held = null,
    Object? muted = null,
    Object? updating = null,
    Object? incomingOffer = freezed,
    Object? displayName = freezed,
    Object? fromReferId = freezed,
    Object? fromReplaces = freezed,
    Object? fromNumber = freezed,
    Object? acceptedTime = freezed,
    Object? hungUpTime = freezed,
    Object? transfer = freezed,
    Object? failure = freezed,
    Object? localStream = freezed,
    Object? remoteStream = freezed,
  }) {
    return _then(_value.copyWith(
      direction: null == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as CallDirection,
      line: freezed == line
          ? _value.line
          : line // ignore: cast_nullable_to_non_nullable
              as int?,
      callId: null == callId
          ? _value.callId
          : callId // ignore: cast_nullable_to_non_nullable
              as String,
      handle: null == handle
          ? _value.handle
          : handle // ignore: cast_nullable_to_non_nullable
              as CallkeepHandle,
      createdTime: null == createdTime
          ? _value.createdTime
          : createdTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      video: null == video
          ? _value.video
          : video // ignore: cast_nullable_to_non_nullable
              as bool,
      processingStatus: null == processingStatus
          ? _value.processingStatus
          : processingStatus // ignore: cast_nullable_to_non_nullable
              as CallProcessingStatus,
      frontCamera: freezed == frontCamera
          ? _value.frontCamera
          : frontCamera // ignore: cast_nullable_to_non_nullable
              as bool?,
      held: null == held
          ? _value.held
          : held // ignore: cast_nullable_to_non_nullable
              as bool,
      muted: null == muted
          ? _value.muted
          : muted // ignore: cast_nullable_to_non_nullable
              as bool,
      updating: null == updating
          ? _value.updating
          : updating // ignore: cast_nullable_to_non_nullable
              as bool,
      incomingOffer: freezed == incomingOffer
          ? _value.incomingOffer
          : incomingOffer // ignore: cast_nullable_to_non_nullable
              as JsepValue?,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      fromReferId: freezed == fromReferId
          ? _value.fromReferId
          : fromReferId // ignore: cast_nullable_to_non_nullable
              as String?,
      fromReplaces: freezed == fromReplaces
          ? _value.fromReplaces
          : fromReplaces // ignore: cast_nullable_to_non_nullable
              as String?,
      fromNumber: freezed == fromNumber
          ? _value.fromNumber
          : fromNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      acceptedTime: freezed == acceptedTime
          ? _value.acceptedTime
          : acceptedTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      hungUpTime: freezed == hungUpTime
          ? _value.hungUpTime
          : hungUpTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      transfer: freezed == transfer
          ? _value.transfer
          : transfer // ignore: cast_nullable_to_non_nullable
              as Transfer?,
      failure: freezed == failure ? _value.failure : failure,
      localStream: freezed == localStream
          ? _value.localStream
          : localStream // ignore: cast_nullable_to_non_nullable
              as MediaStream?,
      remoteStream: freezed == remoteStream
          ? _value.remoteStream
          : remoteStream // ignore: cast_nullable_to_non_nullable
              as MediaStream?,
    ) as $Val);
  }

  /// Create a copy of ActiveCall
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TransferCopyWith<$Res>? get transfer {
    if (_value.transfer == null) {
      return null;
    }

    return $TransferCopyWith<$Res>(_value.transfer!, (value) {
      return _then(_value.copyWith(transfer: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ActiveCallImplCopyWith<$Res>
    implements $ActiveCallCopyWith<$Res> {
  factory _$$ActiveCallImplCopyWith(
          _$ActiveCallImpl value, $Res Function(_$ActiveCallImpl) then) =
      __$$ActiveCallImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {CallDirection direction,
      int? line,
      String callId,
      CallkeepHandle handle,
      DateTime createdTime,
      bool video,
      CallProcessingStatus processingStatus,
      bool? frontCamera,
      bool held,
      bool muted,
      bool updating,
      JsepValue? incomingOffer,
      String? displayName,
      String? fromReferId,
      String? fromReplaces,
      String? fromNumber,
      DateTime? acceptedTime,
      DateTime? hungUpTime,
      Transfer? transfer,
      Object? failure,
      MediaStream? localStream,
      MediaStream? remoteStream});

  @override
  $TransferCopyWith<$Res>? get transfer;
}

/// @nodoc
class __$$ActiveCallImplCopyWithImpl<$Res>
    extends _$ActiveCallCopyWithImpl<$Res, _$ActiveCallImpl>
    implements _$$ActiveCallImplCopyWith<$Res> {
  __$$ActiveCallImplCopyWithImpl(
      _$ActiveCallImpl _value, $Res Function(_$ActiveCallImpl) _then)
      : super(_value, _then);

  /// Create a copy of ActiveCall
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? direction = null,
    Object? line = freezed,
    Object? callId = null,
    Object? handle = null,
    Object? createdTime = null,
    Object? video = null,
    Object? processingStatus = null,
    Object? frontCamera = freezed,
    Object? held = null,
    Object? muted = null,
    Object? updating = null,
    Object? incomingOffer = freezed,
    Object? displayName = freezed,
    Object? fromReferId = freezed,
    Object? fromReplaces = freezed,
    Object? fromNumber = freezed,
    Object? acceptedTime = freezed,
    Object? hungUpTime = freezed,
    Object? transfer = freezed,
    Object? failure = freezed,
    Object? localStream = freezed,
    Object? remoteStream = freezed,
  }) {
    return _then(_$ActiveCallImpl(
      direction: null == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as CallDirection,
      line: freezed == line
          ? _value.line
          : line // ignore: cast_nullable_to_non_nullable
              as int?,
      callId: null == callId
          ? _value.callId
          : callId // ignore: cast_nullable_to_non_nullable
              as String,
      handle: null == handle
          ? _value.handle
          : handle // ignore: cast_nullable_to_non_nullable
              as CallkeepHandle,
      createdTime: null == createdTime
          ? _value.createdTime
          : createdTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      video: null == video
          ? _value.video
          : video // ignore: cast_nullable_to_non_nullable
              as bool,
      processingStatus: null == processingStatus
          ? _value.processingStatus
          : processingStatus // ignore: cast_nullable_to_non_nullable
              as CallProcessingStatus,
      frontCamera: freezed == frontCamera
          ? _value.frontCamera
          : frontCamera // ignore: cast_nullable_to_non_nullable
              as bool?,
      held: null == held
          ? _value.held
          : held // ignore: cast_nullable_to_non_nullable
              as bool,
      muted: null == muted
          ? _value.muted
          : muted // ignore: cast_nullable_to_non_nullable
              as bool,
      updating: null == updating
          ? _value.updating
          : updating // ignore: cast_nullable_to_non_nullable
              as bool,
      incomingOffer: freezed == incomingOffer
          ? _value.incomingOffer
          : incomingOffer // ignore: cast_nullable_to_non_nullable
              as JsepValue?,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      fromReferId: freezed == fromReferId
          ? _value.fromReferId
          : fromReferId // ignore: cast_nullable_to_non_nullable
              as String?,
      fromReplaces: freezed == fromReplaces
          ? _value.fromReplaces
          : fromReplaces // ignore: cast_nullable_to_non_nullable
              as String?,
      fromNumber: freezed == fromNumber
          ? _value.fromNumber
          : fromNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      acceptedTime: freezed == acceptedTime
          ? _value.acceptedTime
          : acceptedTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      hungUpTime: freezed == hungUpTime
          ? _value.hungUpTime
          : hungUpTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      transfer: freezed == transfer
          ? _value.transfer
          : transfer // ignore: cast_nullable_to_non_nullable
              as Transfer?,
      failure: freezed == failure ? _value.failure : failure,
      localStream: freezed == localStream
          ? _value.localStream
          : localStream // ignore: cast_nullable_to_non_nullable
              as MediaStream?,
      remoteStream: freezed == remoteStream
          ? _value.remoteStream
          : remoteStream // ignore: cast_nullable_to_non_nullable
              as MediaStream?,
    ));
  }
}

/// @nodoc

class _$ActiveCallImpl extends _ActiveCall {
  _$ActiveCallImpl(
      {required this.direction,
      required this.line,
      required this.callId,
      required this.handle,
      required this.createdTime,
      required this.video,
      required this.processingStatus,
      this.frontCamera = true,
      this.held = false,
      this.muted = false,
      this.updating = false,
      this.incomingOffer,
      this.displayName,
      this.fromReferId,
      this.fromReplaces,
      this.fromNumber,
      this.acceptedTime,
      this.hungUpTime,
      this.transfer,
      this.failure,
      this.localStream,
      this.remoteStream})
      : super._();

  @override
  final CallDirection direction;
  @override
  final int? line;
  @override
  final String callId;
  @override
  final CallkeepHandle handle;
  @override
  final DateTime createdTime;
  @override
  final bool video;
  @override
  final CallProcessingStatus processingStatus;
  @override
  @JsonKey()
  final bool? frontCamera;
  @override
  @JsonKey()
  final bool held;
  @override
  @JsonKey()
  final bool muted;
  @override
  @JsonKey()
  final bool updating;
  @override
  final JsepValue? incomingOffer;
  @override
  final String? displayName;
  @override
  final String? fromReferId;
  @override
  final String? fromReplaces;
  @override
  final String? fromNumber;
  @override
  final DateTime? acceptedTime;
  @override
  final DateTime? hungUpTime;
  @override
  final Transfer? transfer;
  @override
  final Object? failure;
  @override
  final MediaStream? localStream;
  @override
  final MediaStream? remoteStream;

  @override
  String toString() {
    return 'ActiveCall(direction: $direction, line: $line, callId: $callId, handle: $handle, createdTime: $createdTime, video: $video, processingStatus: $processingStatus, frontCamera: $frontCamera, held: $held, muted: $muted, updating: $updating, incomingOffer: $incomingOffer, displayName: $displayName, fromReferId: $fromReferId, fromReplaces: $fromReplaces, fromNumber: $fromNumber, acceptedTime: $acceptedTime, hungUpTime: $hungUpTime, transfer: $transfer, failure: $failure, localStream: $localStream, remoteStream: $remoteStream)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActiveCallImpl &&
            (identical(other.direction, direction) ||
                other.direction == direction) &&
            (identical(other.line, line) || other.line == line) &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.handle, handle) || other.handle == handle) &&
            (identical(other.createdTime, createdTime) ||
                other.createdTime == createdTime) &&
            (identical(other.video, video) || other.video == video) &&
            (identical(other.processingStatus, processingStatus) ||
                other.processingStatus == processingStatus) &&
            (identical(other.frontCamera, frontCamera) ||
                other.frontCamera == frontCamera) &&
            (identical(other.held, held) || other.held == held) &&
            (identical(other.muted, muted) || other.muted == muted) &&
            (identical(other.updating, updating) ||
                other.updating == updating) &&
            (identical(other.incomingOffer, incomingOffer) ||
                other.incomingOffer == incomingOffer) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.fromReferId, fromReferId) ||
                other.fromReferId == fromReferId) &&
            (identical(other.fromReplaces, fromReplaces) ||
                other.fromReplaces == fromReplaces) &&
            (identical(other.fromNumber, fromNumber) ||
                other.fromNumber == fromNumber) &&
            (identical(other.acceptedTime, acceptedTime) ||
                other.acceptedTime == acceptedTime) &&
            (identical(other.hungUpTime, hungUpTime) ||
                other.hungUpTime == hungUpTime) &&
            (identical(other.transfer, transfer) ||
                other.transfer == transfer) &&
            const DeepCollectionEquality().equals(other.failure, failure) &&
            (identical(other.localStream, localStream) ||
                other.localStream == localStream) &&
            (identical(other.remoteStream, remoteStream) ||
                other.remoteStream == remoteStream));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        direction,
        line,
        callId,
        handle,
        createdTime,
        video,
        processingStatus,
        frontCamera,
        held,
        muted,
        updating,
        incomingOffer,
        displayName,
        fromReferId,
        fromReplaces,
        fromNumber,
        acceptedTime,
        hungUpTime,
        transfer,
        const DeepCollectionEquality().hash(failure),
        localStream,
        remoteStream
      ]);

  /// Create a copy of ActiveCall
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActiveCallImplCopyWith<_$ActiveCallImpl> get copyWith =>
      __$$ActiveCallImplCopyWithImpl<_$ActiveCallImpl>(this, _$identity);
}

abstract class _ActiveCall extends ActiveCall {
  factory _ActiveCall(
      {required final CallDirection direction,
      required final int? line,
      required final String callId,
      required final CallkeepHandle handle,
      required final DateTime createdTime,
      required final bool video,
      required final CallProcessingStatus processingStatus,
      final bool? frontCamera,
      final bool held,
      final bool muted,
      final bool updating,
      final JsepValue? incomingOffer,
      final String? displayName,
      final String? fromReferId,
      final String? fromReplaces,
      final String? fromNumber,
      final DateTime? acceptedTime,
      final DateTime? hungUpTime,
      final Transfer? transfer,
      final Object? failure,
      final MediaStream? localStream,
      final MediaStream? remoteStream}) = _$ActiveCallImpl;
  _ActiveCall._() : super._();

  @override
  CallDirection get direction;
  @override
  int? get line;
  @override
  String get callId;
  @override
  CallkeepHandle get handle;
  @override
  DateTime get createdTime;
  @override
  bool get video;
  @override
  CallProcessingStatus get processingStatus;
  @override
  bool? get frontCamera;
  @override
  bool get held;
  @override
  bool get muted;
  @override
  bool get updating;
  @override
  JsepValue? get incomingOffer;
  @override
  String? get displayName;
  @override
  String? get fromReferId;
  @override
  String? get fromReplaces;
  @override
  String? get fromNumber;
  @override
  DateTime? get acceptedTime;
  @override
  DateTime? get hungUpTime;
  @override
  Transfer? get transfer;
  @override
  Object? get failure;
  @override
  MediaStream? get localStream;
  @override
  MediaStream? get remoteStream;

  /// Create a copy of ActiveCall
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActiveCallImplCopyWith<_$ActiveCallImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CallAudioDevice {
  CallAudioDeviceType get type => throw _privateConstructorUsedError;
  String? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  /// Create a copy of CallAudioDevice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CallAudioDeviceCopyWith<CallAudioDevice> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CallAudioDeviceCopyWith<$Res> {
  factory $CallAudioDeviceCopyWith(
          CallAudioDevice value, $Res Function(CallAudioDevice) then) =
      _$CallAudioDeviceCopyWithImpl<$Res, CallAudioDevice>;
  @useResult
  $Res call({CallAudioDeviceType type, String? id, String? name});
}

/// @nodoc
class _$CallAudioDeviceCopyWithImpl<$Res, $Val extends CallAudioDevice>
    implements $CallAudioDeviceCopyWith<$Res> {
  _$CallAudioDeviceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CallAudioDevice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as CallAudioDeviceType,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CallAudioDeviceImplCopyWith<$Res>
    implements $CallAudioDeviceCopyWith<$Res> {
  factory _$$CallAudioDeviceImplCopyWith(_$CallAudioDeviceImpl value,
          $Res Function(_$CallAudioDeviceImpl) then) =
      __$$CallAudioDeviceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({CallAudioDeviceType type, String? id, String? name});
}

/// @nodoc
class __$$CallAudioDeviceImplCopyWithImpl<$Res>
    extends _$CallAudioDeviceCopyWithImpl<$Res, _$CallAudioDeviceImpl>
    implements _$$CallAudioDeviceImplCopyWith<$Res> {
  __$$CallAudioDeviceImplCopyWithImpl(
      _$CallAudioDeviceImpl _value, $Res Function(_$CallAudioDeviceImpl) _then)
      : super(_value, _then);

  /// Create a copy of CallAudioDevice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_$CallAudioDeviceImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as CallAudioDeviceType,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$CallAudioDeviceImpl extends _CallAudioDevice {
  _$CallAudioDeviceImpl({required this.type, this.id, this.name}) : super._();

  @override
  final CallAudioDeviceType type;
  @override
  final String? id;
  @override
  final String? name;

  @override
  String toString() {
    return 'CallAudioDevice(type: $type, id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallAudioDeviceImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, type, id, name);

  /// Create a copy of CallAudioDevice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CallAudioDeviceImplCopyWith<_$CallAudioDeviceImpl> get copyWith =>
      __$$CallAudioDeviceImplCopyWithImpl<_$CallAudioDeviceImpl>(
          this, _$identity);
}

abstract class _CallAudioDevice extends CallAudioDevice {
  factory _CallAudioDevice(
      {required final CallAudioDeviceType type,
      final String? id,
      final String? name}) = _$CallAudioDeviceImpl;
  _CallAudioDevice._() : super._();

  @override
  CallAudioDeviceType get type;
  @override
  String? get id;
  @override
  String? get name;

  /// Create a copy of CallAudioDevice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CallAudioDeviceImplCopyWith<_$CallAudioDeviceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
