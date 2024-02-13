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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AppLifecycleStateChanged {
  AppLifecycleState get state => throw _privateConstructorUsedError;
}

/// @nodoc

class _$_AppLifecycleStateChangedImpl
    with DiagnosticableTreeMixin
    implements __AppLifecycleStateChanged {
  const _$_AppLifecycleStateChangedImpl(this.state);

  @override
  final AppLifecycleState state;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_AppLifecycleStateChanged(state: $state)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', '_AppLifecycleStateChanged'))
      ..add(DiagnosticsProperty('state', state));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppLifecycleStateChangedImpl &&
            (identical(other.state, state) || other.state == state));
  }

  @override
  int get hashCode => Object.hash(runtimeType, state);
}

abstract class __AppLifecycleStateChanged implements _AppLifecycleStateChanged {
  const factory __AppLifecycleStateChanged(final AppLifecycleState state) =
      _$_AppLifecycleStateChangedImpl;

  @override
  AppLifecycleState get state;
}

/// @nodoc
mixin _$ConnectivityResultChanged {
  ConnectivityResult get result => throw _privateConstructorUsedError;
}

/// @nodoc

class _$_ConnectivityResultChangedImpl
    with DiagnosticableTreeMixin
    implements __ConnectivityResultChanged {
  const _$_ConnectivityResultChangedImpl(this.result);

  @override
  final ConnectivityResult result;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_ConnectivityResultChanged(result: $result)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', '_ConnectivityResultChanged'))
      ..add(DiagnosticsProperty('result', result));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ConnectivityResultChangedImpl &&
            (identical(other.result, result) || other.result == result));
  }

  @override
  int get hashCode => Object.hash(runtimeType, result);
}

abstract class __ConnectivityResultChanged
    implements _ConnectivityResultChanged {
  const factory __ConnectivityResultChanged(final ConnectivityResult result) =
      _$_ConnectivityResultChangedImpl;

  @override
  ConnectivityResult get result;
}

/// @nodoc
mixin _$NavigatorMediaDevicesChange {}

/// @nodoc

class _$_NavigatorMediaDevicesChangeImpl
    with DiagnosticableTreeMixin
    implements __NavigatorMediaDevicesChange {
  const _$_NavigatorMediaDevicesChangeImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_NavigatorMediaDevicesChange()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', '_NavigatorMediaDevicesChange'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NavigatorMediaDevicesChangeImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

abstract class __NavigatorMediaDevicesChange
    implements _NavigatorMediaDevicesChange {
  const factory __NavigatorMediaDevicesChange() =
      _$_NavigatorMediaDevicesChangeImpl;
}

/// @nodoc
mixin _$SignalingClientEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() connectInitiated,
    required TResult Function() disconnectInitiated,
    required TResult Function(int? code, String? reason) disconnected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? connectInitiated,
    TResult? Function()? disconnectInitiated,
    TResult? Function(int? code, String? reason)? disconnected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? connectInitiated,
    TResult Function()? disconnectInitiated,
    TResult Function(int? code, String? reason)? disconnected,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SignalingClientEventConnectInitiated value)
        connectInitiated,
    required TResult Function(_SignalingClientEventDisconnectInitiated value)
        disconnectInitiated,
    required TResult Function(_SignalingClientEventDisconnected value)
        disconnected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SignalingClientEventConnectInitiated value)?
        connectInitiated,
    TResult? Function(_SignalingClientEventDisconnectInitiated value)?
        disconnectInitiated,
    TResult? Function(_SignalingClientEventDisconnected value)? disconnected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SignalingClientEventConnectInitiated value)?
        connectInitiated,
    TResult Function(_SignalingClientEventDisconnectInitiated value)?
        disconnectInitiated,
    TResult Function(_SignalingClientEventDisconnected value)? disconnected,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc

class _$SignalingClientEventConnectInitiatedImpl
    with DiagnosticableTreeMixin
    implements _SignalingClientEventConnectInitiated {
  const _$SignalingClientEventConnectInitiatedImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_SignalingClientEvent.connectInitiated()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
        DiagnosticsProperty('type', '_SignalingClientEvent.connectInitiated'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignalingClientEventConnectInitiatedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() connectInitiated,
    required TResult Function() disconnectInitiated,
    required TResult Function(int? code, String? reason) disconnected,
  }) {
    return connectInitiated();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? connectInitiated,
    TResult? Function()? disconnectInitiated,
    TResult? Function(int? code, String? reason)? disconnected,
  }) {
    return connectInitiated?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? connectInitiated,
    TResult Function()? disconnectInitiated,
    TResult Function(int? code, String? reason)? disconnected,
    required TResult orElse(),
  }) {
    if (connectInitiated != null) {
      return connectInitiated();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SignalingClientEventConnectInitiated value)
        connectInitiated,
    required TResult Function(_SignalingClientEventDisconnectInitiated value)
        disconnectInitiated,
    required TResult Function(_SignalingClientEventDisconnected value)
        disconnected,
  }) {
    return connectInitiated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SignalingClientEventConnectInitiated value)?
        connectInitiated,
    TResult? Function(_SignalingClientEventDisconnectInitiated value)?
        disconnectInitiated,
    TResult? Function(_SignalingClientEventDisconnected value)? disconnected,
  }) {
    return connectInitiated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SignalingClientEventConnectInitiated value)?
        connectInitiated,
    TResult Function(_SignalingClientEventDisconnectInitiated value)?
        disconnectInitiated,
    TResult Function(_SignalingClientEventDisconnected value)? disconnected,
    required TResult orElse(),
  }) {
    if (connectInitiated != null) {
      return connectInitiated(this);
    }
    return orElse();
  }
}

abstract class _SignalingClientEventConnectInitiated
    implements _SignalingClientEvent {
  const factory _SignalingClientEventConnectInitiated() =
      _$SignalingClientEventConnectInitiatedImpl;
}

/// @nodoc

class _$SignalingClientEventDisconnectInitiatedImpl
    with DiagnosticableTreeMixin
    implements _SignalingClientEventDisconnectInitiated {
  const _$SignalingClientEventDisconnectInitiatedImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_SignalingClientEvent.disconnectInitiated()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty(
        'type', '_SignalingClientEvent.disconnectInitiated'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignalingClientEventDisconnectInitiatedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() connectInitiated,
    required TResult Function() disconnectInitiated,
    required TResult Function(int? code, String? reason) disconnected,
  }) {
    return disconnectInitiated();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? connectInitiated,
    TResult? Function()? disconnectInitiated,
    TResult? Function(int? code, String? reason)? disconnected,
  }) {
    return disconnectInitiated?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? connectInitiated,
    TResult Function()? disconnectInitiated,
    TResult Function(int? code, String? reason)? disconnected,
    required TResult orElse(),
  }) {
    if (disconnectInitiated != null) {
      return disconnectInitiated();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SignalingClientEventConnectInitiated value)
        connectInitiated,
    required TResult Function(_SignalingClientEventDisconnectInitiated value)
        disconnectInitiated,
    required TResult Function(_SignalingClientEventDisconnected value)
        disconnected,
  }) {
    return disconnectInitiated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SignalingClientEventConnectInitiated value)?
        connectInitiated,
    TResult? Function(_SignalingClientEventDisconnectInitiated value)?
        disconnectInitiated,
    TResult? Function(_SignalingClientEventDisconnected value)? disconnected,
  }) {
    return disconnectInitiated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SignalingClientEventConnectInitiated value)?
        connectInitiated,
    TResult Function(_SignalingClientEventDisconnectInitiated value)?
        disconnectInitiated,
    TResult Function(_SignalingClientEventDisconnected value)? disconnected,
    required TResult orElse(),
  }) {
    if (disconnectInitiated != null) {
      return disconnectInitiated(this);
    }
    return orElse();
  }
}

abstract class _SignalingClientEventDisconnectInitiated
    implements _SignalingClientEvent {
  const factory _SignalingClientEventDisconnectInitiated() =
      _$SignalingClientEventDisconnectInitiatedImpl;
}

/// @nodoc

class _$SignalingClientEventDisconnectedImpl
    with DiagnosticableTreeMixin
    implements _SignalingClientEventDisconnected {
  const _$SignalingClientEventDisconnectedImpl(this.code, this.reason);

  @override
  final int? code;
  @override
  final String? reason;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_SignalingClientEvent.disconnected(code: $code, reason: $reason)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', '_SignalingClientEvent.disconnected'))
      ..add(DiagnosticsProperty('code', code))
      ..add(DiagnosticsProperty('reason', reason));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignalingClientEventDisconnectedImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @override
  int get hashCode => Object.hash(runtimeType, code, reason);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() connectInitiated,
    required TResult Function() disconnectInitiated,
    required TResult Function(int? code, String? reason) disconnected,
  }) {
    return disconnected(code, reason);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? connectInitiated,
    TResult? Function()? disconnectInitiated,
    TResult? Function(int? code, String? reason)? disconnected,
  }) {
    return disconnected?.call(code, reason);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? connectInitiated,
    TResult Function()? disconnectInitiated,
    TResult Function(int? code, String? reason)? disconnected,
    required TResult orElse(),
  }) {
    if (disconnected != null) {
      return disconnected(code, reason);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SignalingClientEventConnectInitiated value)
        connectInitiated,
    required TResult Function(_SignalingClientEventDisconnectInitiated value)
        disconnectInitiated,
    required TResult Function(_SignalingClientEventDisconnected value)
        disconnected,
  }) {
    return disconnected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_SignalingClientEventConnectInitiated value)?
        connectInitiated,
    TResult? Function(_SignalingClientEventDisconnectInitiated value)?
        disconnectInitiated,
    TResult? Function(_SignalingClientEventDisconnected value)? disconnected,
  }) {
    return disconnected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SignalingClientEventConnectInitiated value)?
        connectInitiated,
    TResult Function(_SignalingClientEventDisconnectInitiated value)?
        disconnectInitiated,
    TResult Function(_SignalingClientEventDisconnected value)? disconnected,
    required TResult orElse(),
  }) {
    if (disconnected != null) {
      return disconnected(this);
    }
    return orElse();
  }
}

abstract class _SignalingClientEventDisconnected
    implements _SignalingClientEvent {
  const factory _SignalingClientEventDisconnected(
          final int? code, final String? reason) =
      _$SignalingClientEventDisconnectedImpl;

  int? get code;
  String? get reason;
}

/// @nodoc
mixin _$HandshakeSignalingEvent {
  int get linesCount => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int linesCount) state,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int linesCount)? state,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int linesCount)? state,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_HandshakeSignalingEventState value) state,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_HandshakeSignalingEventState value)? state,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_HandshakeSignalingEventState value)? state,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc

class _$HandshakeSignalingEventStateImpl
    with DiagnosticableTreeMixin
    implements _HandshakeSignalingEventState {
  const _$HandshakeSignalingEventStateImpl({required this.linesCount});

  @override
  final int linesCount;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_HandshakeSignalingEvent.state(linesCount: $linesCount)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', '_HandshakeSignalingEvent.state'))
      ..add(DiagnosticsProperty('linesCount', linesCount));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HandshakeSignalingEventStateImpl &&
            (identical(other.linesCount, linesCount) ||
                other.linesCount == linesCount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, linesCount);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int linesCount) state,
  }) {
    return state(linesCount);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int linesCount)? state,
  }) {
    return state?.call(linesCount);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int linesCount)? state,
    required TResult orElse(),
  }) {
    if (state != null) {
      return state(linesCount);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_HandshakeSignalingEventState value) state,
  }) {
    return state(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_HandshakeSignalingEventState value)? state,
  }) {
    return state?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_HandshakeSignalingEventState value)? state,
    required TResult orElse(),
  }) {
    if (state != null) {
      return state(this);
    }
    return orElse();
  }
}

abstract class _HandshakeSignalingEventState
    implements _HandshakeSignalingEvent {
  const factory _HandshakeSignalingEventState({required final int linesCount}) =
      _$HandshakeSignalingEventStateImpl;

  @override
  int get linesCount;
}

/// @nodoc
mixin _$CallSignalingEvent {
  int get line => throw _privateConstructorUsedError;
  String get callId => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            int line,
            String callId,
            String callee,
            String caller,
            String? callerDisplayName,
            String? referredBy,
            String? replaceCallId,
            bool? isFocus,
            JsepValue? jsep)
        incoming,
    required TResult Function(int line, String callId) ringing,
    required TResult Function(
            int line, String callId, String callee, JsepValue? jsep)
        progress,
    required TResult Function(
            int line, String callId, String? callee, JsepValue? jsep)
        accepted,
    required TResult Function(int line, String callId, int code, String reason)
        hangup,
    required TResult Function(
            int line,
            String callId,
            String callee,
            String caller,
            String? callerDisplayName,
            String? referredBy,
            String? replaceCallId,
            bool? isFocus,
            JsepValue? jsep)
        updating,
    required TResult Function(int line, String callId) updated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            int line,
            String callId,
            String callee,
            String caller,
            String? callerDisplayName,
            String? referredBy,
            String? replaceCallId,
            bool? isFocus,
            JsepValue? jsep)?
        incoming,
    TResult? Function(int line, String callId)? ringing,
    TResult? Function(int line, String callId, String callee, JsepValue? jsep)?
        progress,
    TResult? Function(int line, String callId, String? callee, JsepValue? jsep)?
        accepted,
    TResult? Function(int line, String callId, int code, String reason)? hangup,
    TResult? Function(
            int line,
            String callId,
            String callee,
            String caller,
            String? callerDisplayName,
            String? referredBy,
            String? replaceCallId,
            bool? isFocus,
            JsepValue? jsep)?
        updating,
    TResult? Function(int line, String callId)? updated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            int line,
            String callId,
            String callee,
            String caller,
            String? callerDisplayName,
            String? referredBy,
            String? replaceCallId,
            bool? isFocus,
            JsepValue? jsep)?
        incoming,
    TResult Function(int line, String callId)? ringing,
    TResult Function(int line, String callId, String callee, JsepValue? jsep)?
        progress,
    TResult Function(int line, String callId, String? callee, JsepValue? jsep)?
        accepted,
    TResult Function(int line, String callId, int code, String reason)? hangup,
    TResult Function(
            int line,
            String callId,
            String callee,
            String caller,
            String? callerDisplayName,
            String? referredBy,
            String? replaceCallId,
            bool? isFocus,
            JsepValue? jsep)?
        updating,
    TResult Function(int line, String callId)? updated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CallSignalingEventIncoming value) incoming,
    required TResult Function(_CallSignalingEventRinging value) ringing,
    required TResult Function(_CallSignalingEventProgress value) progress,
    required TResult Function(_CallSignalingEventAccepted value) accepted,
    required TResult Function(_CallSignalingEventHangup value) hangup,
    required TResult Function(_CallSignalingEventUpdating value) updating,
    required TResult Function(_CallSignalingEventUpdated value) updated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CallSignalingEventIncoming value)? incoming,
    TResult? Function(_CallSignalingEventRinging value)? ringing,
    TResult? Function(_CallSignalingEventProgress value)? progress,
    TResult? Function(_CallSignalingEventAccepted value)? accepted,
    TResult? Function(_CallSignalingEventHangup value)? hangup,
    TResult? Function(_CallSignalingEventUpdating value)? updating,
    TResult? Function(_CallSignalingEventUpdated value)? updated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CallSignalingEventIncoming value)? incoming,
    TResult Function(_CallSignalingEventRinging value)? ringing,
    TResult Function(_CallSignalingEventProgress value)? progress,
    TResult Function(_CallSignalingEventAccepted value)? accepted,
    TResult Function(_CallSignalingEventHangup value)? hangup,
    TResult Function(_CallSignalingEventUpdating value)? updating,
    TResult Function(_CallSignalingEventUpdated value)? updated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc

class _$CallSignalingEventIncomingImpl
    with DiagnosticableTreeMixin
    implements _CallSignalingEventIncoming {
  const _$CallSignalingEventIncomingImpl(
      {required this.line,
      required this.callId,
      required this.callee,
      required this.caller,
      this.callerDisplayName,
      this.referredBy,
      this.replaceCallId,
      this.isFocus,
      this.jsep});

  @override
  final int line;
  @override
  final String callId;
  @override
  final String callee;
  @override
  final String caller;
  @override
  final String? callerDisplayName;
  @override
  final String? referredBy;
  @override
  final String? replaceCallId;
  @override
  final bool? isFocus;
  @override
  final JsepValue? jsep;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallSignalingEvent.incoming(line: $line, callId: $callId, callee: $callee, caller: $caller, callerDisplayName: $callerDisplayName, referredBy: $referredBy, replaceCallId: $replaceCallId, isFocus: $isFocus, jsep: $jsep)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', '_CallSignalingEvent.incoming'))
      ..add(DiagnosticsProperty('line', line))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('callee', callee))
      ..add(DiagnosticsProperty('caller', caller))
      ..add(DiagnosticsProperty('callerDisplayName', callerDisplayName))
      ..add(DiagnosticsProperty('referredBy', referredBy))
      ..add(DiagnosticsProperty('replaceCallId', replaceCallId))
      ..add(DiagnosticsProperty('isFocus', isFocus))
      ..add(DiagnosticsProperty('jsep', jsep));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallSignalingEventIncomingImpl &&
            (identical(other.line, line) || other.line == line) &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.callee, callee) || other.callee == callee) &&
            (identical(other.caller, caller) || other.caller == caller) &&
            (identical(other.callerDisplayName, callerDisplayName) ||
                other.callerDisplayName == callerDisplayName) &&
            (identical(other.referredBy, referredBy) ||
                other.referredBy == referredBy) &&
            (identical(other.replaceCallId, replaceCallId) ||
                other.replaceCallId == replaceCallId) &&
            (identical(other.isFocus, isFocus) || other.isFocus == isFocus) &&
            (identical(other.jsep, jsep) || other.jsep == jsep));
  }

  @override
  int get hashCode => Object.hash(runtimeType, line, callId, callee, caller,
      callerDisplayName, referredBy, replaceCallId, isFocus, jsep);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            int line,
            String callId,
            String callee,
            String caller,
            String? callerDisplayName,
            String? referredBy,
            String? replaceCallId,
            bool? isFocus,
            JsepValue? jsep)
        incoming,
    required TResult Function(int line, String callId) ringing,
    required TResult Function(
            int line, String callId, String callee, JsepValue? jsep)
        progress,
    required TResult Function(
            int line, String callId, String? callee, JsepValue? jsep)
        accepted,
    required TResult Function(int line, String callId, int code, String reason)
        hangup,
    required TResult Function(
            int line,
            String callId,
            String callee,
            String caller,
            String? callerDisplayName,
            String? referredBy,
            String? replaceCallId,
            bool? isFocus,
            JsepValue? jsep)
        updating,
    required TResult Function(int line, String callId) updated,
  }) {
    return incoming(line, callId, callee, caller, callerDisplayName, referredBy,
        replaceCallId, isFocus, jsep);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            int line,
            String callId,
            String callee,
            String caller,
            String? callerDisplayName,
            String? referredBy,
            String? replaceCallId,
            bool? isFocus,
            JsepValue? jsep)?
        incoming,
    TResult? Function(int line, String callId)? ringing,
    TResult? Function(int line, String callId, String callee, JsepValue? jsep)?
        progress,
    TResult? Function(int line, String callId, String? callee, JsepValue? jsep)?
        accepted,
    TResult? Function(int line, String callId, int code, String reason)? hangup,
    TResult? Function(
            int line,
            String callId,
            String callee,
            String caller,
            String? callerDisplayName,
            String? referredBy,
            String? replaceCallId,
            bool? isFocus,
            JsepValue? jsep)?
        updating,
    TResult? Function(int line, String callId)? updated,
  }) {
    return incoming?.call(line, callId, callee, caller, callerDisplayName,
        referredBy, replaceCallId, isFocus, jsep);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            int line,
            String callId,
            String callee,
            String caller,
            String? callerDisplayName,
            String? referredBy,
            String? replaceCallId,
            bool? isFocus,
            JsepValue? jsep)?
        incoming,
    TResult Function(int line, String callId)? ringing,
    TResult Function(int line, String callId, String callee, JsepValue? jsep)?
        progress,
    TResult Function(int line, String callId, String? callee, JsepValue? jsep)?
        accepted,
    TResult Function(int line, String callId, int code, String reason)? hangup,
    TResult Function(
            int line,
            String callId,
            String callee,
            String caller,
            String? callerDisplayName,
            String? referredBy,
            String? replaceCallId,
            bool? isFocus,
            JsepValue? jsep)?
        updating,
    TResult Function(int line, String callId)? updated,
    required TResult orElse(),
  }) {
    if (incoming != null) {
      return incoming(line, callId, callee, caller, callerDisplayName,
          referredBy, replaceCallId, isFocus, jsep);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CallSignalingEventIncoming value) incoming,
    required TResult Function(_CallSignalingEventRinging value) ringing,
    required TResult Function(_CallSignalingEventProgress value) progress,
    required TResult Function(_CallSignalingEventAccepted value) accepted,
    required TResult Function(_CallSignalingEventHangup value) hangup,
    required TResult Function(_CallSignalingEventUpdating value) updating,
    required TResult Function(_CallSignalingEventUpdated value) updated,
  }) {
    return incoming(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CallSignalingEventIncoming value)? incoming,
    TResult? Function(_CallSignalingEventRinging value)? ringing,
    TResult? Function(_CallSignalingEventProgress value)? progress,
    TResult? Function(_CallSignalingEventAccepted value)? accepted,
    TResult? Function(_CallSignalingEventHangup value)? hangup,
    TResult? Function(_CallSignalingEventUpdating value)? updating,
    TResult? Function(_CallSignalingEventUpdated value)? updated,
  }) {
    return incoming?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CallSignalingEventIncoming value)? incoming,
    TResult Function(_CallSignalingEventRinging value)? ringing,
    TResult Function(_CallSignalingEventProgress value)? progress,
    TResult Function(_CallSignalingEventAccepted value)? accepted,
    TResult Function(_CallSignalingEventHangup value)? hangup,
    TResult Function(_CallSignalingEventUpdating value)? updating,
    TResult Function(_CallSignalingEventUpdated value)? updated,
    required TResult orElse(),
  }) {
    if (incoming != null) {
      return incoming(this);
    }
    return orElse();
  }
}

abstract class _CallSignalingEventIncoming implements _CallSignalingEvent {
  const factory _CallSignalingEventIncoming(
      {required final int line,
      required final String callId,
      required final String callee,
      required final String caller,
      final String? callerDisplayName,
      final String? referredBy,
      final String? replaceCallId,
      final bool? isFocus,
      final JsepValue? jsep}) = _$CallSignalingEventIncomingImpl;

  @override
  int get line;
  @override
  String get callId;
  String get callee;
  String get caller;
  String? get callerDisplayName;
  String? get referredBy;
  String? get replaceCallId;
  bool? get isFocus;
  JsepValue? get jsep;
}

/// @nodoc

class _$CallSignalingEventRingingImpl
    with DiagnosticableTreeMixin
    implements _CallSignalingEventRinging {
  const _$CallSignalingEventRingingImpl(
      {required this.line, required this.callId});

  @override
  final int line;
  @override
  final String callId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallSignalingEvent.ringing(line: $line, callId: $callId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', '_CallSignalingEvent.ringing'))
      ..add(DiagnosticsProperty('line', line))
      ..add(DiagnosticsProperty('callId', callId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallSignalingEventRingingImpl &&
            (identical(other.line, line) || other.line == line) &&
            (identical(other.callId, callId) || other.callId == callId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, line, callId);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            int line,
            String callId,
            String callee,
            String caller,
            String? callerDisplayName,
            String? referredBy,
            String? replaceCallId,
            bool? isFocus,
            JsepValue? jsep)
        incoming,
    required TResult Function(int line, String callId) ringing,
    required TResult Function(
            int line, String callId, String callee, JsepValue? jsep)
        progress,
    required TResult Function(
            int line, String callId, String? callee, JsepValue? jsep)
        accepted,
    required TResult Function(int line, String callId, int code, String reason)
        hangup,
    required TResult Function(
            int line,
            String callId,
            String callee,
            String caller,
            String? callerDisplayName,
            String? referredBy,
            String? replaceCallId,
            bool? isFocus,
            JsepValue? jsep)
        updating,
    required TResult Function(int line, String callId) updated,
  }) {
    return ringing(line, callId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            int line,
            String callId,
            String callee,
            String caller,
            String? callerDisplayName,
            String? referredBy,
            String? replaceCallId,
            bool? isFocus,
            JsepValue? jsep)?
        incoming,
    TResult? Function(int line, String callId)? ringing,
    TResult? Function(int line, String callId, String callee, JsepValue? jsep)?
        progress,
    TResult? Function(int line, String callId, String? callee, JsepValue? jsep)?
        accepted,
    TResult? Function(int line, String callId, int code, String reason)? hangup,
    TResult? Function(
            int line,
            String callId,
            String callee,
            String caller,
            String? callerDisplayName,
            String? referredBy,
            String? replaceCallId,
            bool? isFocus,
            JsepValue? jsep)?
        updating,
    TResult? Function(int line, String callId)? updated,
  }) {
    return ringing?.call(line, callId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            int line,
            String callId,
            String callee,
            String caller,
            String? callerDisplayName,
            String? referredBy,
            String? replaceCallId,
            bool? isFocus,
            JsepValue? jsep)?
        incoming,
    TResult Function(int line, String callId)? ringing,
    TResult Function(int line, String callId, String callee, JsepValue? jsep)?
        progress,
    TResult Function(int line, String callId, String? callee, JsepValue? jsep)?
        accepted,
    TResult Function(int line, String callId, int code, String reason)? hangup,
    TResult Function(
            int line,
            String callId,
            String callee,
            String caller,
            String? callerDisplayName,
            String? referredBy,
            String? replaceCallId,
            bool? isFocus,
            JsepValue? jsep)?
        updating,
    TResult Function(int line, String callId)? updated,
    required TResult orElse(),
  }) {
    if (ringing != null) {
      return ringing(line, callId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CallSignalingEventIncoming value) incoming,
    required TResult Function(_CallSignalingEventRinging value) ringing,
    required TResult Function(_CallSignalingEventProgress value) progress,
    required TResult Function(_CallSignalingEventAccepted value) accepted,
    required TResult Function(_CallSignalingEventHangup value) hangup,
    required TResult Function(_CallSignalingEventUpdating value) updating,
    required TResult Function(_CallSignalingEventUpdated value) updated,
  }) {
    return ringing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CallSignalingEventIncoming value)? incoming,
    TResult? Function(_CallSignalingEventRinging value)? ringing,
    TResult? Function(_CallSignalingEventProgress value)? progress,
    TResult? Function(_CallSignalingEventAccepted value)? accepted,
    TResult? Function(_CallSignalingEventHangup value)? hangup,
    TResult? Function(_CallSignalingEventUpdating value)? updating,
    TResult? Function(_CallSignalingEventUpdated value)? updated,
  }) {
    return ringing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CallSignalingEventIncoming value)? incoming,
    TResult Function(_CallSignalingEventRinging value)? ringing,
    TResult Function(_CallSignalingEventProgress value)? progress,
    TResult Function(_CallSignalingEventAccepted value)? accepted,
    TResult Function(_CallSignalingEventHangup value)? hangup,
    TResult Function(_CallSignalingEventUpdating value)? updating,
    TResult Function(_CallSignalingEventUpdated value)? updated,
    required TResult orElse(),
  }) {
    if (ringing != null) {
      return ringing(this);
    }
    return orElse();
  }
}

abstract class _CallSignalingEventRinging implements _CallSignalingEvent {
  const factory _CallSignalingEventRinging(
      {required final int line,
      required final String callId}) = _$CallSignalingEventRingingImpl;

  @override
  int get line;
  @override
  String get callId;
}

/// @nodoc

class _$CallSignalingEventProgressImpl
    with DiagnosticableTreeMixin
    implements _CallSignalingEventProgress {
  const _$CallSignalingEventProgressImpl(
      {required this.line,
      required this.callId,
      required this.callee,
      this.jsep});

  @override
  final int line;
  @override
  final String callId;
  @override
  final String callee;
  @override
  final JsepValue? jsep;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallSignalingEvent.progress(line: $line, callId: $callId, callee: $callee, jsep: $jsep)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', '_CallSignalingEvent.progress'))
      ..add(DiagnosticsProperty('line', line))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('callee', callee))
      ..add(DiagnosticsProperty('jsep', jsep));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallSignalingEventProgressImpl &&
            (identical(other.line, line) || other.line == line) &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.callee, callee) || other.callee == callee) &&
            (identical(other.jsep, jsep) || other.jsep == jsep));
  }

  @override
  int get hashCode => Object.hash(runtimeType, line, callId, callee, jsep);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            int line,
            String callId,
            String callee,
            String caller,
            String? callerDisplayName,
            String? referredBy,
            String? replaceCallId,
            bool? isFocus,
            JsepValue? jsep)
        incoming,
    required TResult Function(int line, String callId) ringing,
    required TResult Function(
            int line, String callId, String callee, JsepValue? jsep)
        progress,
    required TResult Function(
            int line, String callId, String? callee, JsepValue? jsep)
        accepted,
    required TResult Function(int line, String callId, int code, String reason)
        hangup,
    required TResult Function(
            int line,
            String callId,
            String callee,
            String caller,
            String? callerDisplayName,
            String? referredBy,
            String? replaceCallId,
            bool? isFocus,
            JsepValue? jsep)
        updating,
    required TResult Function(int line, String callId) updated,
  }) {
    return progress(line, callId, callee, jsep);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            int line,
            String callId,
            String callee,
            String caller,
            String? callerDisplayName,
            String? referredBy,
            String? replaceCallId,
            bool? isFocus,
            JsepValue? jsep)?
        incoming,
    TResult? Function(int line, String callId)? ringing,
    TResult? Function(int line, String callId, String callee, JsepValue? jsep)?
        progress,
    TResult? Function(int line, String callId, String? callee, JsepValue? jsep)?
        accepted,
    TResult? Function(int line, String callId, int code, String reason)? hangup,
    TResult? Function(
            int line,
            String callId,
            String callee,
            String caller,
            String? callerDisplayName,
            String? referredBy,
            String? replaceCallId,
            bool? isFocus,
            JsepValue? jsep)?
        updating,
    TResult? Function(int line, String callId)? updated,
  }) {
    return progress?.call(line, callId, callee, jsep);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            int line,
            String callId,
            String callee,
            String caller,
            String? callerDisplayName,
            String? referredBy,
            String? replaceCallId,
            bool? isFocus,
            JsepValue? jsep)?
        incoming,
    TResult Function(int line, String callId)? ringing,
    TResult Function(int line, String callId, String callee, JsepValue? jsep)?
        progress,
    TResult Function(int line, String callId, String? callee, JsepValue? jsep)?
        accepted,
    TResult Function(int line, String callId, int code, String reason)? hangup,
    TResult Function(
            int line,
            String callId,
            String callee,
            String caller,
            String? callerDisplayName,
            String? referredBy,
            String? replaceCallId,
            bool? isFocus,
            JsepValue? jsep)?
        updating,
    TResult Function(int line, String callId)? updated,
    required TResult orElse(),
  }) {
    if (progress != null) {
      return progress(line, callId, callee, jsep);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CallSignalingEventIncoming value) incoming,
    required TResult Function(_CallSignalingEventRinging value) ringing,
    required TResult Function(_CallSignalingEventProgress value) progress,
    required TResult Function(_CallSignalingEventAccepted value) accepted,
    required TResult Function(_CallSignalingEventHangup value) hangup,
    required TResult Function(_CallSignalingEventUpdating value) updating,
    required TResult Function(_CallSignalingEventUpdated value) updated,
  }) {
    return progress(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CallSignalingEventIncoming value)? incoming,
    TResult? Function(_CallSignalingEventRinging value)? ringing,
    TResult? Function(_CallSignalingEventProgress value)? progress,
    TResult? Function(_CallSignalingEventAccepted value)? accepted,
    TResult? Function(_CallSignalingEventHangup value)? hangup,
    TResult? Function(_CallSignalingEventUpdating value)? updating,
    TResult? Function(_CallSignalingEventUpdated value)? updated,
  }) {
    return progress?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CallSignalingEventIncoming value)? incoming,
    TResult Function(_CallSignalingEventRinging value)? ringing,
    TResult Function(_CallSignalingEventProgress value)? progress,
    TResult Function(_CallSignalingEventAccepted value)? accepted,
    TResult Function(_CallSignalingEventHangup value)? hangup,
    TResult Function(_CallSignalingEventUpdating value)? updating,
    TResult Function(_CallSignalingEventUpdated value)? updated,
    required TResult orElse(),
  }) {
    if (progress != null) {
      return progress(this);
    }
    return orElse();
  }
}

abstract class _CallSignalingEventProgress implements _CallSignalingEvent {
  const factory _CallSignalingEventProgress(
      {required final int line,
      required final String callId,
      required final String callee,
      final JsepValue? jsep}) = _$CallSignalingEventProgressImpl;

  @override
  int get line;
  @override
  String get callId;
  String get callee;
  JsepValue? get jsep;
}

/// @nodoc

class _$CallSignalingEventAcceptedImpl
    with DiagnosticableTreeMixin
    implements _CallSignalingEventAccepted {
  const _$CallSignalingEventAcceptedImpl(
      {required this.line, required this.callId, this.callee, this.jsep});

  @override
  final int line;
  @override
  final String callId;
  @override
  final String? callee;
  @override
  final JsepValue? jsep;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallSignalingEvent.accepted(line: $line, callId: $callId, callee: $callee, jsep: $jsep)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', '_CallSignalingEvent.accepted'))
      ..add(DiagnosticsProperty('line', line))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('callee', callee))
      ..add(DiagnosticsProperty('jsep', jsep));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallSignalingEventAcceptedImpl &&
            (identical(other.line, line) || other.line == line) &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.callee, callee) || other.callee == callee) &&
            (identical(other.jsep, jsep) || other.jsep == jsep));
  }

  @override
  int get hashCode => Object.hash(runtimeType, line, callId, callee, jsep);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            int line,
            String callId,
            String callee,
            String caller,
            String? callerDisplayName,
            String? referredBy,
            String? replaceCallId,
            bool? isFocus,
            JsepValue? jsep)
        incoming,
    required TResult Function(int line, String callId) ringing,
    required TResult Function(
            int line, String callId, String callee, JsepValue? jsep)
        progress,
    required TResult Function(
            int line, String callId, String? callee, JsepValue? jsep)
        accepted,
    required TResult Function(int line, String callId, int code, String reason)
        hangup,
    required TResult Function(
            int line,
            String callId,
            String callee,
            String caller,
            String? callerDisplayName,
            String? referredBy,
            String? replaceCallId,
            bool? isFocus,
            JsepValue? jsep)
        updating,
    required TResult Function(int line, String callId) updated,
  }) {
    return accepted(line, callId, callee, jsep);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            int line,
            String callId,
            String callee,
            String caller,
            String? callerDisplayName,
            String? referredBy,
            String? replaceCallId,
            bool? isFocus,
            JsepValue? jsep)?
        incoming,
    TResult? Function(int line, String callId)? ringing,
    TResult? Function(int line, String callId, String callee, JsepValue? jsep)?
        progress,
    TResult? Function(int line, String callId, String? callee, JsepValue? jsep)?
        accepted,
    TResult? Function(int line, String callId, int code, String reason)? hangup,
    TResult? Function(
            int line,
            String callId,
            String callee,
            String caller,
            String? callerDisplayName,
            String? referredBy,
            String? replaceCallId,
            bool? isFocus,
            JsepValue? jsep)?
        updating,
    TResult? Function(int line, String callId)? updated,
  }) {
    return accepted?.call(line, callId, callee, jsep);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            int line,
            String callId,
            String callee,
            String caller,
            String? callerDisplayName,
            String? referredBy,
            String? replaceCallId,
            bool? isFocus,
            JsepValue? jsep)?
        incoming,
    TResult Function(int line, String callId)? ringing,
    TResult Function(int line, String callId, String callee, JsepValue? jsep)?
        progress,
    TResult Function(int line, String callId, String? callee, JsepValue? jsep)?
        accepted,
    TResult Function(int line, String callId, int code, String reason)? hangup,
    TResult Function(
            int line,
            String callId,
            String callee,
            String caller,
            String? callerDisplayName,
            String? referredBy,
            String? replaceCallId,
            bool? isFocus,
            JsepValue? jsep)?
        updating,
    TResult Function(int line, String callId)? updated,
    required TResult orElse(),
  }) {
    if (accepted != null) {
      return accepted(line, callId, callee, jsep);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CallSignalingEventIncoming value) incoming,
    required TResult Function(_CallSignalingEventRinging value) ringing,
    required TResult Function(_CallSignalingEventProgress value) progress,
    required TResult Function(_CallSignalingEventAccepted value) accepted,
    required TResult Function(_CallSignalingEventHangup value) hangup,
    required TResult Function(_CallSignalingEventUpdating value) updating,
    required TResult Function(_CallSignalingEventUpdated value) updated,
  }) {
    return accepted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CallSignalingEventIncoming value)? incoming,
    TResult? Function(_CallSignalingEventRinging value)? ringing,
    TResult? Function(_CallSignalingEventProgress value)? progress,
    TResult? Function(_CallSignalingEventAccepted value)? accepted,
    TResult? Function(_CallSignalingEventHangup value)? hangup,
    TResult? Function(_CallSignalingEventUpdating value)? updating,
    TResult? Function(_CallSignalingEventUpdated value)? updated,
  }) {
    return accepted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CallSignalingEventIncoming value)? incoming,
    TResult Function(_CallSignalingEventRinging value)? ringing,
    TResult Function(_CallSignalingEventProgress value)? progress,
    TResult Function(_CallSignalingEventAccepted value)? accepted,
    TResult Function(_CallSignalingEventHangup value)? hangup,
    TResult Function(_CallSignalingEventUpdating value)? updating,
    TResult Function(_CallSignalingEventUpdated value)? updated,
    required TResult orElse(),
  }) {
    if (accepted != null) {
      return accepted(this);
    }
    return orElse();
  }
}

abstract class _CallSignalingEventAccepted implements _CallSignalingEvent {
  const factory _CallSignalingEventAccepted(
      {required final int line,
      required final String callId,
      final String? callee,
      final JsepValue? jsep}) = _$CallSignalingEventAcceptedImpl;

  @override
  int get line;
  @override
  String get callId;
  String? get callee;
  JsepValue? get jsep;
}

/// @nodoc

class _$CallSignalingEventHangupImpl
    with DiagnosticableTreeMixin
    implements _CallSignalingEventHangup {
  const _$CallSignalingEventHangupImpl(
      {required this.line,
      required this.callId,
      required this.code,
      required this.reason});

  @override
  final int line;
  @override
  final String callId;
  @override
  final int code;
  @override
  final String reason;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallSignalingEvent.hangup(line: $line, callId: $callId, code: $code, reason: $reason)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', '_CallSignalingEvent.hangup'))
      ..add(DiagnosticsProperty('line', line))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('code', code))
      ..add(DiagnosticsProperty('reason', reason));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallSignalingEventHangupImpl &&
            (identical(other.line, line) || other.line == line) &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @override
  int get hashCode => Object.hash(runtimeType, line, callId, code, reason);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            int line,
            String callId,
            String callee,
            String caller,
            String? callerDisplayName,
            String? referredBy,
            String? replaceCallId,
            bool? isFocus,
            JsepValue? jsep)
        incoming,
    required TResult Function(int line, String callId) ringing,
    required TResult Function(
            int line, String callId, String callee, JsepValue? jsep)
        progress,
    required TResult Function(
            int line, String callId, String? callee, JsepValue? jsep)
        accepted,
    required TResult Function(int line, String callId, int code, String reason)
        hangup,
    required TResult Function(
            int line,
            String callId,
            String callee,
            String caller,
            String? callerDisplayName,
            String? referredBy,
            String? replaceCallId,
            bool? isFocus,
            JsepValue? jsep)
        updating,
    required TResult Function(int line, String callId) updated,
  }) {
    return hangup(line, callId, code, reason);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            int line,
            String callId,
            String callee,
            String caller,
            String? callerDisplayName,
            String? referredBy,
            String? replaceCallId,
            bool? isFocus,
            JsepValue? jsep)?
        incoming,
    TResult? Function(int line, String callId)? ringing,
    TResult? Function(int line, String callId, String callee, JsepValue? jsep)?
        progress,
    TResult? Function(int line, String callId, String? callee, JsepValue? jsep)?
        accepted,
    TResult? Function(int line, String callId, int code, String reason)? hangup,
    TResult? Function(
            int line,
            String callId,
            String callee,
            String caller,
            String? callerDisplayName,
            String? referredBy,
            String? replaceCallId,
            bool? isFocus,
            JsepValue? jsep)?
        updating,
    TResult? Function(int line, String callId)? updated,
  }) {
    return hangup?.call(line, callId, code, reason);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            int line,
            String callId,
            String callee,
            String caller,
            String? callerDisplayName,
            String? referredBy,
            String? replaceCallId,
            bool? isFocus,
            JsepValue? jsep)?
        incoming,
    TResult Function(int line, String callId)? ringing,
    TResult Function(int line, String callId, String callee, JsepValue? jsep)?
        progress,
    TResult Function(int line, String callId, String? callee, JsepValue? jsep)?
        accepted,
    TResult Function(int line, String callId, int code, String reason)? hangup,
    TResult Function(
            int line,
            String callId,
            String callee,
            String caller,
            String? callerDisplayName,
            String? referredBy,
            String? replaceCallId,
            bool? isFocus,
            JsepValue? jsep)?
        updating,
    TResult Function(int line, String callId)? updated,
    required TResult orElse(),
  }) {
    if (hangup != null) {
      return hangup(line, callId, code, reason);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CallSignalingEventIncoming value) incoming,
    required TResult Function(_CallSignalingEventRinging value) ringing,
    required TResult Function(_CallSignalingEventProgress value) progress,
    required TResult Function(_CallSignalingEventAccepted value) accepted,
    required TResult Function(_CallSignalingEventHangup value) hangup,
    required TResult Function(_CallSignalingEventUpdating value) updating,
    required TResult Function(_CallSignalingEventUpdated value) updated,
  }) {
    return hangup(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CallSignalingEventIncoming value)? incoming,
    TResult? Function(_CallSignalingEventRinging value)? ringing,
    TResult? Function(_CallSignalingEventProgress value)? progress,
    TResult? Function(_CallSignalingEventAccepted value)? accepted,
    TResult? Function(_CallSignalingEventHangup value)? hangup,
    TResult? Function(_CallSignalingEventUpdating value)? updating,
    TResult? Function(_CallSignalingEventUpdated value)? updated,
  }) {
    return hangup?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CallSignalingEventIncoming value)? incoming,
    TResult Function(_CallSignalingEventRinging value)? ringing,
    TResult Function(_CallSignalingEventProgress value)? progress,
    TResult Function(_CallSignalingEventAccepted value)? accepted,
    TResult Function(_CallSignalingEventHangup value)? hangup,
    TResult Function(_CallSignalingEventUpdating value)? updating,
    TResult Function(_CallSignalingEventUpdated value)? updated,
    required TResult orElse(),
  }) {
    if (hangup != null) {
      return hangup(this);
    }
    return orElse();
  }
}

abstract class _CallSignalingEventHangup implements _CallSignalingEvent {
  const factory _CallSignalingEventHangup(
      {required final int line,
      required final String callId,
      required final int code,
      required final String reason}) = _$CallSignalingEventHangupImpl;

  @override
  int get line;
  @override
  String get callId;
  int get code;
  String get reason;
}

/// @nodoc

class _$CallSignalingEventUpdatingImpl
    with DiagnosticableTreeMixin
    implements _CallSignalingEventUpdating {
  const _$CallSignalingEventUpdatingImpl(
      {required this.line,
      required this.callId,
      required this.callee,
      required this.caller,
      this.callerDisplayName,
      this.referredBy,
      this.replaceCallId,
      this.isFocus,
      this.jsep});

  @override
  final int line;
  @override
  final String callId;
  @override
  final String callee;
  @override
  final String caller;
  @override
  final String? callerDisplayName;
  @override
  final String? referredBy;
  @override
  final String? replaceCallId;
  @override
  final bool? isFocus;
  @override
  final JsepValue? jsep;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallSignalingEvent.updating(line: $line, callId: $callId, callee: $callee, caller: $caller, callerDisplayName: $callerDisplayName, referredBy: $referredBy, replaceCallId: $replaceCallId, isFocus: $isFocus, jsep: $jsep)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', '_CallSignalingEvent.updating'))
      ..add(DiagnosticsProperty('line', line))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('callee', callee))
      ..add(DiagnosticsProperty('caller', caller))
      ..add(DiagnosticsProperty('callerDisplayName', callerDisplayName))
      ..add(DiagnosticsProperty('referredBy', referredBy))
      ..add(DiagnosticsProperty('replaceCallId', replaceCallId))
      ..add(DiagnosticsProperty('isFocus', isFocus))
      ..add(DiagnosticsProperty('jsep', jsep));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallSignalingEventUpdatingImpl &&
            (identical(other.line, line) || other.line == line) &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.callee, callee) || other.callee == callee) &&
            (identical(other.caller, caller) || other.caller == caller) &&
            (identical(other.callerDisplayName, callerDisplayName) ||
                other.callerDisplayName == callerDisplayName) &&
            (identical(other.referredBy, referredBy) ||
                other.referredBy == referredBy) &&
            (identical(other.replaceCallId, replaceCallId) ||
                other.replaceCallId == replaceCallId) &&
            (identical(other.isFocus, isFocus) || other.isFocus == isFocus) &&
            (identical(other.jsep, jsep) || other.jsep == jsep));
  }

  @override
  int get hashCode => Object.hash(runtimeType, line, callId, callee, caller,
      callerDisplayName, referredBy, replaceCallId, isFocus, jsep);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            int line,
            String callId,
            String callee,
            String caller,
            String? callerDisplayName,
            String? referredBy,
            String? replaceCallId,
            bool? isFocus,
            JsepValue? jsep)
        incoming,
    required TResult Function(int line, String callId) ringing,
    required TResult Function(
            int line, String callId, String callee, JsepValue? jsep)
        progress,
    required TResult Function(
            int line, String callId, String? callee, JsepValue? jsep)
        accepted,
    required TResult Function(int line, String callId, int code, String reason)
        hangup,
    required TResult Function(
            int line,
            String callId,
            String callee,
            String caller,
            String? callerDisplayName,
            String? referredBy,
            String? replaceCallId,
            bool? isFocus,
            JsepValue? jsep)
        updating,
    required TResult Function(int line, String callId) updated,
  }) {
    return updating(line, callId, callee, caller, callerDisplayName, referredBy,
        replaceCallId, isFocus, jsep);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            int line,
            String callId,
            String callee,
            String caller,
            String? callerDisplayName,
            String? referredBy,
            String? replaceCallId,
            bool? isFocus,
            JsepValue? jsep)?
        incoming,
    TResult? Function(int line, String callId)? ringing,
    TResult? Function(int line, String callId, String callee, JsepValue? jsep)?
        progress,
    TResult? Function(int line, String callId, String? callee, JsepValue? jsep)?
        accepted,
    TResult? Function(int line, String callId, int code, String reason)? hangup,
    TResult? Function(
            int line,
            String callId,
            String callee,
            String caller,
            String? callerDisplayName,
            String? referredBy,
            String? replaceCallId,
            bool? isFocus,
            JsepValue? jsep)?
        updating,
    TResult? Function(int line, String callId)? updated,
  }) {
    return updating?.call(line, callId, callee, caller, callerDisplayName,
        referredBy, replaceCallId, isFocus, jsep);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            int line,
            String callId,
            String callee,
            String caller,
            String? callerDisplayName,
            String? referredBy,
            String? replaceCallId,
            bool? isFocus,
            JsepValue? jsep)?
        incoming,
    TResult Function(int line, String callId)? ringing,
    TResult Function(int line, String callId, String callee, JsepValue? jsep)?
        progress,
    TResult Function(int line, String callId, String? callee, JsepValue? jsep)?
        accepted,
    TResult Function(int line, String callId, int code, String reason)? hangup,
    TResult Function(
            int line,
            String callId,
            String callee,
            String caller,
            String? callerDisplayName,
            String? referredBy,
            String? replaceCallId,
            bool? isFocus,
            JsepValue? jsep)?
        updating,
    TResult Function(int line, String callId)? updated,
    required TResult orElse(),
  }) {
    if (updating != null) {
      return updating(line, callId, callee, caller, callerDisplayName,
          referredBy, replaceCallId, isFocus, jsep);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CallSignalingEventIncoming value) incoming,
    required TResult Function(_CallSignalingEventRinging value) ringing,
    required TResult Function(_CallSignalingEventProgress value) progress,
    required TResult Function(_CallSignalingEventAccepted value) accepted,
    required TResult Function(_CallSignalingEventHangup value) hangup,
    required TResult Function(_CallSignalingEventUpdating value) updating,
    required TResult Function(_CallSignalingEventUpdated value) updated,
  }) {
    return updating(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CallSignalingEventIncoming value)? incoming,
    TResult? Function(_CallSignalingEventRinging value)? ringing,
    TResult? Function(_CallSignalingEventProgress value)? progress,
    TResult? Function(_CallSignalingEventAccepted value)? accepted,
    TResult? Function(_CallSignalingEventHangup value)? hangup,
    TResult? Function(_CallSignalingEventUpdating value)? updating,
    TResult? Function(_CallSignalingEventUpdated value)? updated,
  }) {
    return updating?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CallSignalingEventIncoming value)? incoming,
    TResult Function(_CallSignalingEventRinging value)? ringing,
    TResult Function(_CallSignalingEventProgress value)? progress,
    TResult Function(_CallSignalingEventAccepted value)? accepted,
    TResult Function(_CallSignalingEventHangup value)? hangup,
    TResult Function(_CallSignalingEventUpdating value)? updating,
    TResult Function(_CallSignalingEventUpdated value)? updated,
    required TResult orElse(),
  }) {
    if (updating != null) {
      return updating(this);
    }
    return orElse();
  }
}

abstract class _CallSignalingEventUpdating implements _CallSignalingEvent {
  const factory _CallSignalingEventUpdating(
      {required final int line,
      required final String callId,
      required final String callee,
      required final String caller,
      final String? callerDisplayName,
      final String? referredBy,
      final String? replaceCallId,
      final bool? isFocus,
      final JsepValue? jsep}) = _$CallSignalingEventUpdatingImpl;

  @override
  int get line;
  @override
  String get callId;
  String get callee;
  String get caller;
  String? get callerDisplayName;
  String? get referredBy;
  String? get replaceCallId;
  bool? get isFocus;
  JsepValue? get jsep;
}

/// @nodoc

class _$CallSignalingEventUpdatedImpl
    with DiagnosticableTreeMixin
    implements _CallSignalingEventUpdated {
  const _$CallSignalingEventUpdatedImpl(
      {required this.line, required this.callId});

  @override
  final int line;
  @override
  final String callId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallSignalingEvent.updated(line: $line, callId: $callId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', '_CallSignalingEvent.updated'))
      ..add(DiagnosticsProperty('line', line))
      ..add(DiagnosticsProperty('callId', callId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallSignalingEventUpdatedImpl &&
            (identical(other.line, line) || other.line == line) &&
            (identical(other.callId, callId) || other.callId == callId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, line, callId);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            int line,
            String callId,
            String callee,
            String caller,
            String? callerDisplayName,
            String? referredBy,
            String? replaceCallId,
            bool? isFocus,
            JsepValue? jsep)
        incoming,
    required TResult Function(int line, String callId) ringing,
    required TResult Function(
            int line, String callId, String callee, JsepValue? jsep)
        progress,
    required TResult Function(
            int line, String callId, String? callee, JsepValue? jsep)
        accepted,
    required TResult Function(int line, String callId, int code, String reason)
        hangup,
    required TResult Function(
            int line,
            String callId,
            String callee,
            String caller,
            String? callerDisplayName,
            String? referredBy,
            String? replaceCallId,
            bool? isFocus,
            JsepValue? jsep)
        updating,
    required TResult Function(int line, String callId) updated,
  }) {
    return updated(line, callId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            int line,
            String callId,
            String callee,
            String caller,
            String? callerDisplayName,
            String? referredBy,
            String? replaceCallId,
            bool? isFocus,
            JsepValue? jsep)?
        incoming,
    TResult? Function(int line, String callId)? ringing,
    TResult? Function(int line, String callId, String callee, JsepValue? jsep)?
        progress,
    TResult? Function(int line, String callId, String? callee, JsepValue? jsep)?
        accepted,
    TResult? Function(int line, String callId, int code, String reason)? hangup,
    TResult? Function(
            int line,
            String callId,
            String callee,
            String caller,
            String? callerDisplayName,
            String? referredBy,
            String? replaceCallId,
            bool? isFocus,
            JsepValue? jsep)?
        updating,
    TResult? Function(int line, String callId)? updated,
  }) {
    return updated?.call(line, callId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            int line,
            String callId,
            String callee,
            String caller,
            String? callerDisplayName,
            String? referredBy,
            String? replaceCallId,
            bool? isFocus,
            JsepValue? jsep)?
        incoming,
    TResult Function(int line, String callId)? ringing,
    TResult Function(int line, String callId, String callee, JsepValue? jsep)?
        progress,
    TResult Function(int line, String callId, String? callee, JsepValue? jsep)?
        accepted,
    TResult Function(int line, String callId, int code, String reason)? hangup,
    TResult Function(
            int line,
            String callId,
            String callee,
            String caller,
            String? callerDisplayName,
            String? referredBy,
            String? replaceCallId,
            bool? isFocus,
            JsepValue? jsep)?
        updating,
    TResult Function(int line, String callId)? updated,
    required TResult orElse(),
  }) {
    if (updated != null) {
      return updated(line, callId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CallSignalingEventIncoming value) incoming,
    required TResult Function(_CallSignalingEventRinging value) ringing,
    required TResult Function(_CallSignalingEventProgress value) progress,
    required TResult Function(_CallSignalingEventAccepted value) accepted,
    required TResult Function(_CallSignalingEventHangup value) hangup,
    required TResult Function(_CallSignalingEventUpdating value) updating,
    required TResult Function(_CallSignalingEventUpdated value) updated,
  }) {
    return updated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CallSignalingEventIncoming value)? incoming,
    TResult? Function(_CallSignalingEventRinging value)? ringing,
    TResult? Function(_CallSignalingEventProgress value)? progress,
    TResult? Function(_CallSignalingEventAccepted value)? accepted,
    TResult? Function(_CallSignalingEventHangup value)? hangup,
    TResult? Function(_CallSignalingEventUpdating value)? updating,
    TResult? Function(_CallSignalingEventUpdated value)? updated,
  }) {
    return updated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CallSignalingEventIncoming value)? incoming,
    TResult Function(_CallSignalingEventRinging value)? ringing,
    TResult Function(_CallSignalingEventProgress value)? progress,
    TResult Function(_CallSignalingEventAccepted value)? accepted,
    TResult Function(_CallSignalingEventHangup value)? hangup,
    TResult Function(_CallSignalingEventUpdating value)? updating,
    TResult Function(_CallSignalingEventUpdated value)? updated,
    required TResult orElse(),
  }) {
    if (updated != null) {
      return updated(this);
    }
    return orElse();
  }
}

abstract class _CallSignalingEventUpdated implements _CallSignalingEvent {
  const factory _CallSignalingEventUpdated(
      {required final int line,
      required final String callId}) = _$CallSignalingEventUpdatedImpl;

  @override
  int get line;
  @override
  String get callId;
}

/// @nodoc
mixin _$CallPushEvent {
  String get callId => throw _privateConstructorUsedError;
  CallkeepHandle get handle => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  bool get video => throw _privateConstructorUsedError;
  CallkeepIncomingCallError? get error => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String callId, CallkeepHandle handle,
            String? displayName, bool video, CallkeepIncomingCallError? error)
        incoming,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String callId, CallkeepHandle handle, String? displayName,
            bool video, CallkeepIncomingCallError? error)?
        incoming,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String callId, CallkeepHandle handle, String? displayName,
            bool video, CallkeepIncomingCallError? error)?
        incoming,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CallPushEventIncoming value) incoming,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CallPushEventIncoming value)? incoming,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CallPushEventIncoming value)? incoming,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc

class _$CallPushEventIncomingImpl
    with DiagnosticableTreeMixin
    implements _CallPushEventIncoming {
  const _$CallPushEventIncomingImpl(
      {required this.callId,
      required this.handle,
      this.displayName,
      required this.video,
      this.error});

  @override
  final String callId;
  @override
  final CallkeepHandle handle;
  @override
  final String? displayName;
  @override
  final bool video;
  @override
  final CallkeepIncomingCallError? error;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallPushEvent.incoming(callId: $callId, handle: $handle, displayName: $displayName, video: $video, error: $error)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', '_CallPushEvent.incoming'))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('handle', handle))
      ..add(DiagnosticsProperty('displayName', displayName))
      ..add(DiagnosticsProperty('video', video))
      ..add(DiagnosticsProperty('error', error));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallPushEventIncomingImpl &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.handle, handle) || other.handle == handle) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.video, video) || other.video == video) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, callId, handle, displayName, video, error);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String callId, CallkeepHandle handle,
            String? displayName, bool video, CallkeepIncomingCallError? error)
        incoming,
  }) {
    return incoming(callId, handle, displayName, video, error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String callId, CallkeepHandle handle, String? displayName,
            bool video, CallkeepIncomingCallError? error)?
        incoming,
  }) {
    return incoming?.call(callId, handle, displayName, video, error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String callId, CallkeepHandle handle, String? displayName,
            bool video, CallkeepIncomingCallError? error)?
        incoming,
    required TResult orElse(),
  }) {
    if (incoming != null) {
      return incoming(callId, handle, displayName, video, error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CallPushEventIncoming value) incoming,
  }) {
    return incoming(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CallPushEventIncoming value)? incoming,
  }) {
    return incoming?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CallPushEventIncoming value)? incoming,
    required TResult orElse(),
  }) {
    if (incoming != null) {
      return incoming(this);
    }
    return orElse();
  }
}

abstract class _CallPushEventIncoming implements _CallPushEvent {
  const factory _CallPushEventIncoming(
      {required final String callId,
      required final CallkeepHandle handle,
      final String? displayName,
      required final bool video,
      final CallkeepIncomingCallError? error}) = _$CallPushEventIncomingImpl;

  @override
  String get callId;
  @override
  CallkeepHandle get handle;
  @override
  String? get displayName;
  @override
  bool get video;
  @override
  CallkeepIncomingCallError? get error;
}

/// @nodoc
mixin _$CallControlEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? line, String? generic, String? number,
            String? email, String? displayName, bool video)
        started,
    required TResult Function(String callId) answered,
    required TResult Function(String callId) ended,
    required TResult Function(String callId, bool onHold) setHeld,
    required TResult Function(String callId, bool muted) setMuted,
    required TResult Function(String callId, String key) sentDTMF,
    required TResult Function(String callId) cameraSwitched,
    required TResult Function(String callId, bool enabled) cameraEnabled,
    required TResult Function(String callId, bool enabled) speakerEnabled,
    required TResult Function(String callId) failureApproved,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? line, String? generic, String? number, String? email,
            String? displayName, bool video)?
        started,
    TResult? Function(String callId)? answered,
    TResult? Function(String callId)? ended,
    TResult? Function(String callId, bool onHold)? setHeld,
    TResult? Function(String callId, bool muted)? setMuted,
    TResult? Function(String callId, String key)? sentDTMF,
    TResult? Function(String callId)? cameraSwitched,
    TResult? Function(String callId, bool enabled)? cameraEnabled,
    TResult? Function(String callId, bool enabled)? speakerEnabled,
    TResult? Function(String callId)? failureApproved,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? line, String? generic, String? number, String? email,
            String? displayName, bool video)?
        started,
    TResult Function(String callId)? answered,
    TResult Function(String callId)? ended,
    TResult Function(String callId, bool onHold)? setHeld,
    TResult Function(String callId, bool muted)? setMuted,
    TResult Function(String callId, String key)? sentDTMF,
    TResult Function(String callId)? cameraSwitched,
    TResult Function(String callId, bool enabled)? cameraEnabled,
    TResult Function(String callId, bool enabled)? speakerEnabled,
    TResult Function(String callId)? failureApproved,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CallControlEventStarted value) started,
    required TResult Function(_CallControlEventAnswered value) answered,
    required TResult Function(_CallControlEventEnded value) ended,
    required TResult Function(_CallControlEventSetHeld value) setHeld,
    required TResult Function(_CallControlEventSetMuted value) setMuted,
    required TResult Function(_CallControlEventSentDTMF value) sentDTMF,
    required TResult Function(_CallControlEventCameraSwitched value)
        cameraSwitched,
    required TResult Function(_CallControlEventCameraEnabled value)
        cameraEnabled,
    required TResult Function(_CallControlEventSpeakerEnabled value)
        speakerEnabled,
    required TResult Function(_CallControlEventFailureApproved value)
        failureApproved,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CallControlEventStarted value)? started,
    TResult? Function(_CallControlEventAnswered value)? answered,
    TResult? Function(_CallControlEventEnded value)? ended,
    TResult? Function(_CallControlEventSetHeld value)? setHeld,
    TResult? Function(_CallControlEventSetMuted value)? setMuted,
    TResult? Function(_CallControlEventSentDTMF value)? sentDTMF,
    TResult? Function(_CallControlEventCameraSwitched value)? cameraSwitched,
    TResult? Function(_CallControlEventCameraEnabled value)? cameraEnabled,
    TResult? Function(_CallControlEventSpeakerEnabled value)? speakerEnabled,
    TResult? Function(_CallControlEventFailureApproved value)? failureApproved,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CallControlEventStarted value)? started,
    TResult Function(_CallControlEventAnswered value)? answered,
    TResult Function(_CallControlEventEnded value)? ended,
    TResult Function(_CallControlEventSetHeld value)? setHeld,
    TResult Function(_CallControlEventSetMuted value)? setMuted,
    TResult Function(_CallControlEventSentDTMF value)? sentDTMF,
    TResult Function(_CallControlEventCameraSwitched value)? cameraSwitched,
    TResult Function(_CallControlEventCameraEnabled value)? cameraEnabled,
    TResult Function(_CallControlEventSpeakerEnabled value)? speakerEnabled,
    TResult Function(_CallControlEventFailureApproved value)? failureApproved,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc

class _$CallControlEventStartedImpl
    with DiagnosticableTreeMixin, CallControlEventStartedMixin
    implements _CallControlEventStarted {
  const _$CallControlEventStartedImpl(
      {this.line,
      this.generic,
      this.number,
      this.email,
      this.displayName,
      required this.video})
      : assert(!(generic == null && number == null && email == null),
            'one of generic, number or email parameters must be assign'),
        assert(
            (generic != null && number == null && email == null) ||
                (generic == null && number != null && email == null) ||
                (generic == null && number == null && email != null),
            'only one of generic, number or email parameters must be assign');

  @override
  final int? line;
  @override
  final String? generic;
  @override
  final String? number;
  @override
  final String? email;
  @override
  final String? displayName;
  @override
  final bool video;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallControlEvent.started(line: $line, generic: $generic, number: $number, email: $email, displayName: $displayName, video: $video)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CallControlEvent.started'))
      ..add(DiagnosticsProperty('line', line))
      ..add(DiagnosticsProperty('generic', generic))
      ..add(DiagnosticsProperty('number', number))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('displayName', displayName))
      ..add(DiagnosticsProperty('video', video));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallControlEventStartedImpl &&
            (identical(other.line, line) || other.line == line) &&
            (identical(other.generic, generic) || other.generic == generic) &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.video, video) || other.video == video));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, line, generic, number, email, displayName, video);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? line, String? generic, String? number,
            String? email, String? displayName, bool video)
        started,
    required TResult Function(String callId) answered,
    required TResult Function(String callId) ended,
    required TResult Function(String callId, bool onHold) setHeld,
    required TResult Function(String callId, bool muted) setMuted,
    required TResult Function(String callId, String key) sentDTMF,
    required TResult Function(String callId) cameraSwitched,
    required TResult Function(String callId, bool enabled) cameraEnabled,
    required TResult Function(String callId, bool enabled) speakerEnabled,
    required TResult Function(String callId) failureApproved,
  }) {
    return started(line, generic, number, email, displayName, video);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? line, String? generic, String? number, String? email,
            String? displayName, bool video)?
        started,
    TResult? Function(String callId)? answered,
    TResult? Function(String callId)? ended,
    TResult? Function(String callId, bool onHold)? setHeld,
    TResult? Function(String callId, bool muted)? setMuted,
    TResult? Function(String callId, String key)? sentDTMF,
    TResult? Function(String callId)? cameraSwitched,
    TResult? Function(String callId, bool enabled)? cameraEnabled,
    TResult? Function(String callId, bool enabled)? speakerEnabled,
    TResult? Function(String callId)? failureApproved,
  }) {
    return started?.call(line, generic, number, email, displayName, video);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? line, String? generic, String? number, String? email,
            String? displayName, bool video)?
        started,
    TResult Function(String callId)? answered,
    TResult Function(String callId)? ended,
    TResult Function(String callId, bool onHold)? setHeld,
    TResult Function(String callId, bool muted)? setMuted,
    TResult Function(String callId, String key)? sentDTMF,
    TResult Function(String callId)? cameraSwitched,
    TResult Function(String callId, bool enabled)? cameraEnabled,
    TResult Function(String callId, bool enabled)? speakerEnabled,
    TResult Function(String callId)? failureApproved,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(line, generic, number, email, displayName, video);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CallControlEventStarted value) started,
    required TResult Function(_CallControlEventAnswered value) answered,
    required TResult Function(_CallControlEventEnded value) ended,
    required TResult Function(_CallControlEventSetHeld value) setHeld,
    required TResult Function(_CallControlEventSetMuted value) setMuted,
    required TResult Function(_CallControlEventSentDTMF value) sentDTMF,
    required TResult Function(_CallControlEventCameraSwitched value)
        cameraSwitched,
    required TResult Function(_CallControlEventCameraEnabled value)
        cameraEnabled,
    required TResult Function(_CallControlEventSpeakerEnabled value)
        speakerEnabled,
    required TResult Function(_CallControlEventFailureApproved value)
        failureApproved,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CallControlEventStarted value)? started,
    TResult? Function(_CallControlEventAnswered value)? answered,
    TResult? Function(_CallControlEventEnded value)? ended,
    TResult? Function(_CallControlEventSetHeld value)? setHeld,
    TResult? Function(_CallControlEventSetMuted value)? setMuted,
    TResult? Function(_CallControlEventSentDTMF value)? sentDTMF,
    TResult? Function(_CallControlEventCameraSwitched value)? cameraSwitched,
    TResult? Function(_CallControlEventCameraEnabled value)? cameraEnabled,
    TResult? Function(_CallControlEventSpeakerEnabled value)? speakerEnabled,
    TResult? Function(_CallControlEventFailureApproved value)? failureApproved,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CallControlEventStarted value)? started,
    TResult Function(_CallControlEventAnswered value)? answered,
    TResult Function(_CallControlEventEnded value)? ended,
    TResult Function(_CallControlEventSetHeld value)? setHeld,
    TResult Function(_CallControlEventSetMuted value)? setMuted,
    TResult Function(_CallControlEventSentDTMF value)? sentDTMF,
    TResult Function(_CallControlEventCameraSwitched value)? cameraSwitched,
    TResult Function(_CallControlEventCameraEnabled value)? cameraEnabled,
    TResult Function(_CallControlEventSpeakerEnabled value)? speakerEnabled,
    TResult Function(_CallControlEventFailureApproved value)? failureApproved,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _CallControlEventStarted
    implements CallControlEvent, CallControlEventStartedMixin {
  const factory _CallControlEventStarted(
      {final int? line,
      final String? generic,
      final String? number,
      final String? email,
      final String? displayName,
      required final bool video}) = _$CallControlEventStartedImpl;

  int? get line;
  String? get generic;
  String? get number;
  String? get email;
  String? get displayName;
  bool get video;
}

/// @nodoc

class _$CallControlEventAnsweredImpl
    with DiagnosticableTreeMixin
    implements _CallControlEventAnswered {
  const _$CallControlEventAnsweredImpl(this.callId);

  @override
  final String callId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallControlEvent.answered(callId: $callId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CallControlEvent.answered'))
      ..add(DiagnosticsProperty('callId', callId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallControlEventAnsweredImpl &&
            (identical(other.callId, callId) || other.callId == callId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callId);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? line, String? generic, String? number,
            String? email, String? displayName, bool video)
        started,
    required TResult Function(String callId) answered,
    required TResult Function(String callId) ended,
    required TResult Function(String callId, bool onHold) setHeld,
    required TResult Function(String callId, bool muted) setMuted,
    required TResult Function(String callId, String key) sentDTMF,
    required TResult Function(String callId) cameraSwitched,
    required TResult Function(String callId, bool enabled) cameraEnabled,
    required TResult Function(String callId, bool enabled) speakerEnabled,
    required TResult Function(String callId) failureApproved,
  }) {
    return answered(callId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? line, String? generic, String? number, String? email,
            String? displayName, bool video)?
        started,
    TResult? Function(String callId)? answered,
    TResult? Function(String callId)? ended,
    TResult? Function(String callId, bool onHold)? setHeld,
    TResult? Function(String callId, bool muted)? setMuted,
    TResult? Function(String callId, String key)? sentDTMF,
    TResult? Function(String callId)? cameraSwitched,
    TResult? Function(String callId, bool enabled)? cameraEnabled,
    TResult? Function(String callId, bool enabled)? speakerEnabled,
    TResult? Function(String callId)? failureApproved,
  }) {
    return answered?.call(callId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? line, String? generic, String? number, String? email,
            String? displayName, bool video)?
        started,
    TResult Function(String callId)? answered,
    TResult Function(String callId)? ended,
    TResult Function(String callId, bool onHold)? setHeld,
    TResult Function(String callId, bool muted)? setMuted,
    TResult Function(String callId, String key)? sentDTMF,
    TResult Function(String callId)? cameraSwitched,
    TResult Function(String callId, bool enabled)? cameraEnabled,
    TResult Function(String callId, bool enabled)? speakerEnabled,
    TResult Function(String callId)? failureApproved,
    required TResult orElse(),
  }) {
    if (answered != null) {
      return answered(callId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CallControlEventStarted value) started,
    required TResult Function(_CallControlEventAnswered value) answered,
    required TResult Function(_CallControlEventEnded value) ended,
    required TResult Function(_CallControlEventSetHeld value) setHeld,
    required TResult Function(_CallControlEventSetMuted value) setMuted,
    required TResult Function(_CallControlEventSentDTMF value) sentDTMF,
    required TResult Function(_CallControlEventCameraSwitched value)
        cameraSwitched,
    required TResult Function(_CallControlEventCameraEnabled value)
        cameraEnabled,
    required TResult Function(_CallControlEventSpeakerEnabled value)
        speakerEnabled,
    required TResult Function(_CallControlEventFailureApproved value)
        failureApproved,
  }) {
    return answered(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CallControlEventStarted value)? started,
    TResult? Function(_CallControlEventAnswered value)? answered,
    TResult? Function(_CallControlEventEnded value)? ended,
    TResult? Function(_CallControlEventSetHeld value)? setHeld,
    TResult? Function(_CallControlEventSetMuted value)? setMuted,
    TResult? Function(_CallControlEventSentDTMF value)? sentDTMF,
    TResult? Function(_CallControlEventCameraSwitched value)? cameraSwitched,
    TResult? Function(_CallControlEventCameraEnabled value)? cameraEnabled,
    TResult? Function(_CallControlEventSpeakerEnabled value)? speakerEnabled,
    TResult? Function(_CallControlEventFailureApproved value)? failureApproved,
  }) {
    return answered?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CallControlEventStarted value)? started,
    TResult Function(_CallControlEventAnswered value)? answered,
    TResult Function(_CallControlEventEnded value)? ended,
    TResult Function(_CallControlEventSetHeld value)? setHeld,
    TResult Function(_CallControlEventSetMuted value)? setMuted,
    TResult Function(_CallControlEventSentDTMF value)? sentDTMF,
    TResult Function(_CallControlEventCameraSwitched value)? cameraSwitched,
    TResult Function(_CallControlEventCameraEnabled value)? cameraEnabled,
    TResult Function(_CallControlEventSpeakerEnabled value)? speakerEnabled,
    TResult Function(_CallControlEventFailureApproved value)? failureApproved,
    required TResult orElse(),
  }) {
    if (answered != null) {
      return answered(this);
    }
    return orElse();
  }
}

abstract class _CallControlEventAnswered implements CallControlEvent {
  const factory _CallControlEventAnswered(final String callId) =
      _$CallControlEventAnsweredImpl;

  String get callId;
}

/// @nodoc

class _$CallControlEventEndedImpl
    with DiagnosticableTreeMixin
    implements _CallControlEventEnded {
  const _$CallControlEventEndedImpl(this.callId);

  @override
  final String callId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallControlEvent.ended(callId: $callId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CallControlEvent.ended'))
      ..add(DiagnosticsProperty('callId', callId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallControlEventEndedImpl &&
            (identical(other.callId, callId) || other.callId == callId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callId);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? line, String? generic, String? number,
            String? email, String? displayName, bool video)
        started,
    required TResult Function(String callId) answered,
    required TResult Function(String callId) ended,
    required TResult Function(String callId, bool onHold) setHeld,
    required TResult Function(String callId, bool muted) setMuted,
    required TResult Function(String callId, String key) sentDTMF,
    required TResult Function(String callId) cameraSwitched,
    required TResult Function(String callId, bool enabled) cameraEnabled,
    required TResult Function(String callId, bool enabled) speakerEnabled,
    required TResult Function(String callId) failureApproved,
  }) {
    return ended(callId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? line, String? generic, String? number, String? email,
            String? displayName, bool video)?
        started,
    TResult? Function(String callId)? answered,
    TResult? Function(String callId)? ended,
    TResult? Function(String callId, bool onHold)? setHeld,
    TResult? Function(String callId, bool muted)? setMuted,
    TResult? Function(String callId, String key)? sentDTMF,
    TResult? Function(String callId)? cameraSwitched,
    TResult? Function(String callId, bool enabled)? cameraEnabled,
    TResult? Function(String callId, bool enabled)? speakerEnabled,
    TResult? Function(String callId)? failureApproved,
  }) {
    return ended?.call(callId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? line, String? generic, String? number, String? email,
            String? displayName, bool video)?
        started,
    TResult Function(String callId)? answered,
    TResult Function(String callId)? ended,
    TResult Function(String callId, bool onHold)? setHeld,
    TResult Function(String callId, bool muted)? setMuted,
    TResult Function(String callId, String key)? sentDTMF,
    TResult Function(String callId)? cameraSwitched,
    TResult Function(String callId, bool enabled)? cameraEnabled,
    TResult Function(String callId, bool enabled)? speakerEnabled,
    TResult Function(String callId)? failureApproved,
    required TResult orElse(),
  }) {
    if (ended != null) {
      return ended(callId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CallControlEventStarted value) started,
    required TResult Function(_CallControlEventAnswered value) answered,
    required TResult Function(_CallControlEventEnded value) ended,
    required TResult Function(_CallControlEventSetHeld value) setHeld,
    required TResult Function(_CallControlEventSetMuted value) setMuted,
    required TResult Function(_CallControlEventSentDTMF value) sentDTMF,
    required TResult Function(_CallControlEventCameraSwitched value)
        cameraSwitched,
    required TResult Function(_CallControlEventCameraEnabled value)
        cameraEnabled,
    required TResult Function(_CallControlEventSpeakerEnabled value)
        speakerEnabled,
    required TResult Function(_CallControlEventFailureApproved value)
        failureApproved,
  }) {
    return ended(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CallControlEventStarted value)? started,
    TResult? Function(_CallControlEventAnswered value)? answered,
    TResult? Function(_CallControlEventEnded value)? ended,
    TResult? Function(_CallControlEventSetHeld value)? setHeld,
    TResult? Function(_CallControlEventSetMuted value)? setMuted,
    TResult? Function(_CallControlEventSentDTMF value)? sentDTMF,
    TResult? Function(_CallControlEventCameraSwitched value)? cameraSwitched,
    TResult? Function(_CallControlEventCameraEnabled value)? cameraEnabled,
    TResult? Function(_CallControlEventSpeakerEnabled value)? speakerEnabled,
    TResult? Function(_CallControlEventFailureApproved value)? failureApproved,
  }) {
    return ended?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CallControlEventStarted value)? started,
    TResult Function(_CallControlEventAnswered value)? answered,
    TResult Function(_CallControlEventEnded value)? ended,
    TResult Function(_CallControlEventSetHeld value)? setHeld,
    TResult Function(_CallControlEventSetMuted value)? setMuted,
    TResult Function(_CallControlEventSentDTMF value)? sentDTMF,
    TResult Function(_CallControlEventCameraSwitched value)? cameraSwitched,
    TResult Function(_CallControlEventCameraEnabled value)? cameraEnabled,
    TResult Function(_CallControlEventSpeakerEnabled value)? speakerEnabled,
    TResult Function(_CallControlEventFailureApproved value)? failureApproved,
    required TResult orElse(),
  }) {
    if (ended != null) {
      return ended(this);
    }
    return orElse();
  }
}

abstract class _CallControlEventEnded implements CallControlEvent {
  const factory _CallControlEventEnded(final String callId) =
      _$CallControlEventEndedImpl;

  String get callId;
}

/// @nodoc

class _$CallControlEventSetHeldImpl
    with DiagnosticableTreeMixin
    implements _CallControlEventSetHeld {
  const _$CallControlEventSetHeldImpl(this.callId, this.onHold);

  @override
  final String callId;
  @override
  final bool onHold;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallControlEvent.setHeld(callId: $callId, onHold: $onHold)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CallControlEvent.setHeld'))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('onHold', onHold));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallControlEventSetHeldImpl &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.onHold, onHold) || other.onHold == onHold));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callId, onHold);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? line, String? generic, String? number,
            String? email, String? displayName, bool video)
        started,
    required TResult Function(String callId) answered,
    required TResult Function(String callId) ended,
    required TResult Function(String callId, bool onHold) setHeld,
    required TResult Function(String callId, bool muted) setMuted,
    required TResult Function(String callId, String key) sentDTMF,
    required TResult Function(String callId) cameraSwitched,
    required TResult Function(String callId, bool enabled) cameraEnabled,
    required TResult Function(String callId, bool enabled) speakerEnabled,
    required TResult Function(String callId) failureApproved,
  }) {
    return setHeld(callId, onHold);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? line, String? generic, String? number, String? email,
            String? displayName, bool video)?
        started,
    TResult? Function(String callId)? answered,
    TResult? Function(String callId)? ended,
    TResult? Function(String callId, bool onHold)? setHeld,
    TResult? Function(String callId, bool muted)? setMuted,
    TResult? Function(String callId, String key)? sentDTMF,
    TResult? Function(String callId)? cameraSwitched,
    TResult? Function(String callId, bool enabled)? cameraEnabled,
    TResult? Function(String callId, bool enabled)? speakerEnabled,
    TResult? Function(String callId)? failureApproved,
  }) {
    return setHeld?.call(callId, onHold);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? line, String? generic, String? number, String? email,
            String? displayName, bool video)?
        started,
    TResult Function(String callId)? answered,
    TResult Function(String callId)? ended,
    TResult Function(String callId, bool onHold)? setHeld,
    TResult Function(String callId, bool muted)? setMuted,
    TResult Function(String callId, String key)? sentDTMF,
    TResult Function(String callId)? cameraSwitched,
    TResult Function(String callId, bool enabled)? cameraEnabled,
    TResult Function(String callId, bool enabled)? speakerEnabled,
    TResult Function(String callId)? failureApproved,
    required TResult orElse(),
  }) {
    if (setHeld != null) {
      return setHeld(callId, onHold);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CallControlEventStarted value) started,
    required TResult Function(_CallControlEventAnswered value) answered,
    required TResult Function(_CallControlEventEnded value) ended,
    required TResult Function(_CallControlEventSetHeld value) setHeld,
    required TResult Function(_CallControlEventSetMuted value) setMuted,
    required TResult Function(_CallControlEventSentDTMF value) sentDTMF,
    required TResult Function(_CallControlEventCameraSwitched value)
        cameraSwitched,
    required TResult Function(_CallControlEventCameraEnabled value)
        cameraEnabled,
    required TResult Function(_CallControlEventSpeakerEnabled value)
        speakerEnabled,
    required TResult Function(_CallControlEventFailureApproved value)
        failureApproved,
  }) {
    return setHeld(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CallControlEventStarted value)? started,
    TResult? Function(_CallControlEventAnswered value)? answered,
    TResult? Function(_CallControlEventEnded value)? ended,
    TResult? Function(_CallControlEventSetHeld value)? setHeld,
    TResult? Function(_CallControlEventSetMuted value)? setMuted,
    TResult? Function(_CallControlEventSentDTMF value)? sentDTMF,
    TResult? Function(_CallControlEventCameraSwitched value)? cameraSwitched,
    TResult? Function(_CallControlEventCameraEnabled value)? cameraEnabled,
    TResult? Function(_CallControlEventSpeakerEnabled value)? speakerEnabled,
    TResult? Function(_CallControlEventFailureApproved value)? failureApproved,
  }) {
    return setHeld?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CallControlEventStarted value)? started,
    TResult Function(_CallControlEventAnswered value)? answered,
    TResult Function(_CallControlEventEnded value)? ended,
    TResult Function(_CallControlEventSetHeld value)? setHeld,
    TResult Function(_CallControlEventSetMuted value)? setMuted,
    TResult Function(_CallControlEventSentDTMF value)? sentDTMF,
    TResult Function(_CallControlEventCameraSwitched value)? cameraSwitched,
    TResult Function(_CallControlEventCameraEnabled value)? cameraEnabled,
    TResult Function(_CallControlEventSpeakerEnabled value)? speakerEnabled,
    TResult Function(_CallControlEventFailureApproved value)? failureApproved,
    required TResult orElse(),
  }) {
    if (setHeld != null) {
      return setHeld(this);
    }
    return orElse();
  }
}

abstract class _CallControlEventSetHeld implements CallControlEvent {
  const factory _CallControlEventSetHeld(
      final String callId, final bool onHold) = _$CallControlEventSetHeldImpl;

  String get callId;
  bool get onHold;
}

/// @nodoc

class _$CallControlEventSetMutedImpl
    with DiagnosticableTreeMixin
    implements _CallControlEventSetMuted {
  const _$CallControlEventSetMutedImpl(this.callId, this.muted);

  @override
  final String callId;
  @override
  final bool muted;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallControlEvent.setMuted(callId: $callId, muted: $muted)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CallControlEvent.setMuted'))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('muted', muted));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallControlEventSetMutedImpl &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.muted, muted) || other.muted == muted));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callId, muted);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? line, String? generic, String? number,
            String? email, String? displayName, bool video)
        started,
    required TResult Function(String callId) answered,
    required TResult Function(String callId) ended,
    required TResult Function(String callId, bool onHold) setHeld,
    required TResult Function(String callId, bool muted) setMuted,
    required TResult Function(String callId, String key) sentDTMF,
    required TResult Function(String callId) cameraSwitched,
    required TResult Function(String callId, bool enabled) cameraEnabled,
    required TResult Function(String callId, bool enabled) speakerEnabled,
    required TResult Function(String callId) failureApproved,
  }) {
    return setMuted(callId, muted);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? line, String? generic, String? number, String? email,
            String? displayName, bool video)?
        started,
    TResult? Function(String callId)? answered,
    TResult? Function(String callId)? ended,
    TResult? Function(String callId, bool onHold)? setHeld,
    TResult? Function(String callId, bool muted)? setMuted,
    TResult? Function(String callId, String key)? sentDTMF,
    TResult? Function(String callId)? cameraSwitched,
    TResult? Function(String callId, bool enabled)? cameraEnabled,
    TResult? Function(String callId, bool enabled)? speakerEnabled,
    TResult? Function(String callId)? failureApproved,
  }) {
    return setMuted?.call(callId, muted);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? line, String? generic, String? number, String? email,
            String? displayName, bool video)?
        started,
    TResult Function(String callId)? answered,
    TResult Function(String callId)? ended,
    TResult Function(String callId, bool onHold)? setHeld,
    TResult Function(String callId, bool muted)? setMuted,
    TResult Function(String callId, String key)? sentDTMF,
    TResult Function(String callId)? cameraSwitched,
    TResult Function(String callId, bool enabled)? cameraEnabled,
    TResult Function(String callId, bool enabled)? speakerEnabled,
    TResult Function(String callId)? failureApproved,
    required TResult orElse(),
  }) {
    if (setMuted != null) {
      return setMuted(callId, muted);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CallControlEventStarted value) started,
    required TResult Function(_CallControlEventAnswered value) answered,
    required TResult Function(_CallControlEventEnded value) ended,
    required TResult Function(_CallControlEventSetHeld value) setHeld,
    required TResult Function(_CallControlEventSetMuted value) setMuted,
    required TResult Function(_CallControlEventSentDTMF value) sentDTMF,
    required TResult Function(_CallControlEventCameraSwitched value)
        cameraSwitched,
    required TResult Function(_CallControlEventCameraEnabled value)
        cameraEnabled,
    required TResult Function(_CallControlEventSpeakerEnabled value)
        speakerEnabled,
    required TResult Function(_CallControlEventFailureApproved value)
        failureApproved,
  }) {
    return setMuted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CallControlEventStarted value)? started,
    TResult? Function(_CallControlEventAnswered value)? answered,
    TResult? Function(_CallControlEventEnded value)? ended,
    TResult? Function(_CallControlEventSetHeld value)? setHeld,
    TResult? Function(_CallControlEventSetMuted value)? setMuted,
    TResult? Function(_CallControlEventSentDTMF value)? sentDTMF,
    TResult? Function(_CallControlEventCameraSwitched value)? cameraSwitched,
    TResult? Function(_CallControlEventCameraEnabled value)? cameraEnabled,
    TResult? Function(_CallControlEventSpeakerEnabled value)? speakerEnabled,
    TResult? Function(_CallControlEventFailureApproved value)? failureApproved,
  }) {
    return setMuted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CallControlEventStarted value)? started,
    TResult Function(_CallControlEventAnswered value)? answered,
    TResult Function(_CallControlEventEnded value)? ended,
    TResult Function(_CallControlEventSetHeld value)? setHeld,
    TResult Function(_CallControlEventSetMuted value)? setMuted,
    TResult Function(_CallControlEventSentDTMF value)? sentDTMF,
    TResult Function(_CallControlEventCameraSwitched value)? cameraSwitched,
    TResult Function(_CallControlEventCameraEnabled value)? cameraEnabled,
    TResult Function(_CallControlEventSpeakerEnabled value)? speakerEnabled,
    TResult Function(_CallControlEventFailureApproved value)? failureApproved,
    required TResult orElse(),
  }) {
    if (setMuted != null) {
      return setMuted(this);
    }
    return orElse();
  }
}

abstract class _CallControlEventSetMuted implements CallControlEvent {
  const factory _CallControlEventSetMuted(
      final String callId, final bool muted) = _$CallControlEventSetMutedImpl;

  String get callId;
  bool get muted;
}

/// @nodoc

class _$CallControlEventSentDTMFImpl
    with DiagnosticableTreeMixin
    implements _CallControlEventSentDTMF {
  const _$CallControlEventSentDTMFImpl(this.callId, this.key);

  @override
  final String callId;
  @override
  final String key;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallControlEvent.sentDTMF(callId: $callId, key: $key)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CallControlEvent.sentDTMF'))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('key', key));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallControlEventSentDTMFImpl &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.key, key) || other.key == key));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callId, key);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? line, String? generic, String? number,
            String? email, String? displayName, bool video)
        started,
    required TResult Function(String callId) answered,
    required TResult Function(String callId) ended,
    required TResult Function(String callId, bool onHold) setHeld,
    required TResult Function(String callId, bool muted) setMuted,
    required TResult Function(String callId, String key) sentDTMF,
    required TResult Function(String callId) cameraSwitched,
    required TResult Function(String callId, bool enabled) cameraEnabled,
    required TResult Function(String callId, bool enabled) speakerEnabled,
    required TResult Function(String callId) failureApproved,
  }) {
    return sentDTMF(callId, key);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? line, String? generic, String? number, String? email,
            String? displayName, bool video)?
        started,
    TResult? Function(String callId)? answered,
    TResult? Function(String callId)? ended,
    TResult? Function(String callId, bool onHold)? setHeld,
    TResult? Function(String callId, bool muted)? setMuted,
    TResult? Function(String callId, String key)? sentDTMF,
    TResult? Function(String callId)? cameraSwitched,
    TResult? Function(String callId, bool enabled)? cameraEnabled,
    TResult? Function(String callId, bool enabled)? speakerEnabled,
    TResult? Function(String callId)? failureApproved,
  }) {
    return sentDTMF?.call(callId, key);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? line, String? generic, String? number, String? email,
            String? displayName, bool video)?
        started,
    TResult Function(String callId)? answered,
    TResult Function(String callId)? ended,
    TResult Function(String callId, bool onHold)? setHeld,
    TResult Function(String callId, bool muted)? setMuted,
    TResult Function(String callId, String key)? sentDTMF,
    TResult Function(String callId)? cameraSwitched,
    TResult Function(String callId, bool enabled)? cameraEnabled,
    TResult Function(String callId, bool enabled)? speakerEnabled,
    TResult Function(String callId)? failureApproved,
    required TResult orElse(),
  }) {
    if (sentDTMF != null) {
      return sentDTMF(callId, key);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CallControlEventStarted value) started,
    required TResult Function(_CallControlEventAnswered value) answered,
    required TResult Function(_CallControlEventEnded value) ended,
    required TResult Function(_CallControlEventSetHeld value) setHeld,
    required TResult Function(_CallControlEventSetMuted value) setMuted,
    required TResult Function(_CallControlEventSentDTMF value) sentDTMF,
    required TResult Function(_CallControlEventCameraSwitched value)
        cameraSwitched,
    required TResult Function(_CallControlEventCameraEnabled value)
        cameraEnabled,
    required TResult Function(_CallControlEventSpeakerEnabled value)
        speakerEnabled,
    required TResult Function(_CallControlEventFailureApproved value)
        failureApproved,
  }) {
    return sentDTMF(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CallControlEventStarted value)? started,
    TResult? Function(_CallControlEventAnswered value)? answered,
    TResult? Function(_CallControlEventEnded value)? ended,
    TResult? Function(_CallControlEventSetHeld value)? setHeld,
    TResult? Function(_CallControlEventSetMuted value)? setMuted,
    TResult? Function(_CallControlEventSentDTMF value)? sentDTMF,
    TResult? Function(_CallControlEventCameraSwitched value)? cameraSwitched,
    TResult? Function(_CallControlEventCameraEnabled value)? cameraEnabled,
    TResult? Function(_CallControlEventSpeakerEnabled value)? speakerEnabled,
    TResult? Function(_CallControlEventFailureApproved value)? failureApproved,
  }) {
    return sentDTMF?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CallControlEventStarted value)? started,
    TResult Function(_CallControlEventAnswered value)? answered,
    TResult Function(_CallControlEventEnded value)? ended,
    TResult Function(_CallControlEventSetHeld value)? setHeld,
    TResult Function(_CallControlEventSetMuted value)? setMuted,
    TResult Function(_CallControlEventSentDTMF value)? sentDTMF,
    TResult Function(_CallControlEventCameraSwitched value)? cameraSwitched,
    TResult Function(_CallControlEventCameraEnabled value)? cameraEnabled,
    TResult Function(_CallControlEventSpeakerEnabled value)? speakerEnabled,
    TResult Function(_CallControlEventFailureApproved value)? failureApproved,
    required TResult orElse(),
  }) {
    if (sentDTMF != null) {
      return sentDTMF(this);
    }
    return orElse();
  }
}

abstract class _CallControlEventSentDTMF implements CallControlEvent {
  const factory _CallControlEventSentDTMF(
      final String callId, final String key) = _$CallControlEventSentDTMFImpl;

  String get callId;
  String get key;
}

/// @nodoc

class _$CallControlEventCameraSwitchedImpl
    with DiagnosticableTreeMixin
    implements _CallControlEventCameraSwitched {
  const _$CallControlEventCameraSwitchedImpl(this.callId);

  @override
  final String callId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallControlEvent.cameraSwitched(callId: $callId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CallControlEvent.cameraSwitched'))
      ..add(DiagnosticsProperty('callId', callId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallControlEventCameraSwitchedImpl &&
            (identical(other.callId, callId) || other.callId == callId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callId);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? line, String? generic, String? number,
            String? email, String? displayName, bool video)
        started,
    required TResult Function(String callId) answered,
    required TResult Function(String callId) ended,
    required TResult Function(String callId, bool onHold) setHeld,
    required TResult Function(String callId, bool muted) setMuted,
    required TResult Function(String callId, String key) sentDTMF,
    required TResult Function(String callId) cameraSwitched,
    required TResult Function(String callId, bool enabled) cameraEnabled,
    required TResult Function(String callId, bool enabled) speakerEnabled,
    required TResult Function(String callId) failureApproved,
  }) {
    return cameraSwitched(callId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? line, String? generic, String? number, String? email,
            String? displayName, bool video)?
        started,
    TResult? Function(String callId)? answered,
    TResult? Function(String callId)? ended,
    TResult? Function(String callId, bool onHold)? setHeld,
    TResult? Function(String callId, bool muted)? setMuted,
    TResult? Function(String callId, String key)? sentDTMF,
    TResult? Function(String callId)? cameraSwitched,
    TResult? Function(String callId, bool enabled)? cameraEnabled,
    TResult? Function(String callId, bool enabled)? speakerEnabled,
    TResult? Function(String callId)? failureApproved,
  }) {
    return cameraSwitched?.call(callId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? line, String? generic, String? number, String? email,
            String? displayName, bool video)?
        started,
    TResult Function(String callId)? answered,
    TResult Function(String callId)? ended,
    TResult Function(String callId, bool onHold)? setHeld,
    TResult Function(String callId, bool muted)? setMuted,
    TResult Function(String callId, String key)? sentDTMF,
    TResult Function(String callId)? cameraSwitched,
    TResult Function(String callId, bool enabled)? cameraEnabled,
    TResult Function(String callId, bool enabled)? speakerEnabled,
    TResult Function(String callId)? failureApproved,
    required TResult orElse(),
  }) {
    if (cameraSwitched != null) {
      return cameraSwitched(callId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CallControlEventStarted value) started,
    required TResult Function(_CallControlEventAnswered value) answered,
    required TResult Function(_CallControlEventEnded value) ended,
    required TResult Function(_CallControlEventSetHeld value) setHeld,
    required TResult Function(_CallControlEventSetMuted value) setMuted,
    required TResult Function(_CallControlEventSentDTMF value) sentDTMF,
    required TResult Function(_CallControlEventCameraSwitched value)
        cameraSwitched,
    required TResult Function(_CallControlEventCameraEnabled value)
        cameraEnabled,
    required TResult Function(_CallControlEventSpeakerEnabled value)
        speakerEnabled,
    required TResult Function(_CallControlEventFailureApproved value)
        failureApproved,
  }) {
    return cameraSwitched(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CallControlEventStarted value)? started,
    TResult? Function(_CallControlEventAnswered value)? answered,
    TResult? Function(_CallControlEventEnded value)? ended,
    TResult? Function(_CallControlEventSetHeld value)? setHeld,
    TResult? Function(_CallControlEventSetMuted value)? setMuted,
    TResult? Function(_CallControlEventSentDTMF value)? sentDTMF,
    TResult? Function(_CallControlEventCameraSwitched value)? cameraSwitched,
    TResult? Function(_CallControlEventCameraEnabled value)? cameraEnabled,
    TResult? Function(_CallControlEventSpeakerEnabled value)? speakerEnabled,
    TResult? Function(_CallControlEventFailureApproved value)? failureApproved,
  }) {
    return cameraSwitched?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CallControlEventStarted value)? started,
    TResult Function(_CallControlEventAnswered value)? answered,
    TResult Function(_CallControlEventEnded value)? ended,
    TResult Function(_CallControlEventSetHeld value)? setHeld,
    TResult Function(_CallControlEventSetMuted value)? setMuted,
    TResult Function(_CallControlEventSentDTMF value)? sentDTMF,
    TResult Function(_CallControlEventCameraSwitched value)? cameraSwitched,
    TResult Function(_CallControlEventCameraEnabled value)? cameraEnabled,
    TResult Function(_CallControlEventSpeakerEnabled value)? speakerEnabled,
    TResult Function(_CallControlEventFailureApproved value)? failureApproved,
    required TResult orElse(),
  }) {
    if (cameraSwitched != null) {
      return cameraSwitched(this);
    }
    return orElse();
  }
}

abstract class _CallControlEventCameraSwitched implements CallControlEvent {
  const factory _CallControlEventCameraSwitched(final String callId) =
      _$CallControlEventCameraSwitchedImpl;

  String get callId;
}

/// @nodoc

class _$CallControlEventCameraEnabledImpl
    with DiagnosticableTreeMixin
    implements _CallControlEventCameraEnabled {
  const _$CallControlEventCameraEnabledImpl(this.callId, this.enabled);

  @override
  final String callId;
  @override
  final bool enabled;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallControlEvent.cameraEnabled(callId: $callId, enabled: $enabled)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CallControlEvent.cameraEnabled'))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('enabled', enabled));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallControlEventCameraEnabledImpl &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.enabled, enabled) || other.enabled == enabled));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callId, enabled);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? line, String? generic, String? number,
            String? email, String? displayName, bool video)
        started,
    required TResult Function(String callId) answered,
    required TResult Function(String callId) ended,
    required TResult Function(String callId, bool onHold) setHeld,
    required TResult Function(String callId, bool muted) setMuted,
    required TResult Function(String callId, String key) sentDTMF,
    required TResult Function(String callId) cameraSwitched,
    required TResult Function(String callId, bool enabled) cameraEnabled,
    required TResult Function(String callId, bool enabled) speakerEnabled,
    required TResult Function(String callId) failureApproved,
  }) {
    return cameraEnabled(callId, enabled);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? line, String? generic, String? number, String? email,
            String? displayName, bool video)?
        started,
    TResult? Function(String callId)? answered,
    TResult? Function(String callId)? ended,
    TResult? Function(String callId, bool onHold)? setHeld,
    TResult? Function(String callId, bool muted)? setMuted,
    TResult? Function(String callId, String key)? sentDTMF,
    TResult? Function(String callId)? cameraSwitched,
    TResult? Function(String callId, bool enabled)? cameraEnabled,
    TResult? Function(String callId, bool enabled)? speakerEnabled,
    TResult? Function(String callId)? failureApproved,
  }) {
    return cameraEnabled?.call(callId, enabled);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? line, String? generic, String? number, String? email,
            String? displayName, bool video)?
        started,
    TResult Function(String callId)? answered,
    TResult Function(String callId)? ended,
    TResult Function(String callId, bool onHold)? setHeld,
    TResult Function(String callId, bool muted)? setMuted,
    TResult Function(String callId, String key)? sentDTMF,
    TResult Function(String callId)? cameraSwitched,
    TResult Function(String callId, bool enabled)? cameraEnabled,
    TResult Function(String callId, bool enabled)? speakerEnabled,
    TResult Function(String callId)? failureApproved,
    required TResult orElse(),
  }) {
    if (cameraEnabled != null) {
      return cameraEnabled(callId, enabled);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CallControlEventStarted value) started,
    required TResult Function(_CallControlEventAnswered value) answered,
    required TResult Function(_CallControlEventEnded value) ended,
    required TResult Function(_CallControlEventSetHeld value) setHeld,
    required TResult Function(_CallControlEventSetMuted value) setMuted,
    required TResult Function(_CallControlEventSentDTMF value) sentDTMF,
    required TResult Function(_CallControlEventCameraSwitched value)
        cameraSwitched,
    required TResult Function(_CallControlEventCameraEnabled value)
        cameraEnabled,
    required TResult Function(_CallControlEventSpeakerEnabled value)
        speakerEnabled,
    required TResult Function(_CallControlEventFailureApproved value)
        failureApproved,
  }) {
    return cameraEnabled(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CallControlEventStarted value)? started,
    TResult? Function(_CallControlEventAnswered value)? answered,
    TResult? Function(_CallControlEventEnded value)? ended,
    TResult? Function(_CallControlEventSetHeld value)? setHeld,
    TResult? Function(_CallControlEventSetMuted value)? setMuted,
    TResult? Function(_CallControlEventSentDTMF value)? sentDTMF,
    TResult? Function(_CallControlEventCameraSwitched value)? cameraSwitched,
    TResult? Function(_CallControlEventCameraEnabled value)? cameraEnabled,
    TResult? Function(_CallControlEventSpeakerEnabled value)? speakerEnabled,
    TResult? Function(_CallControlEventFailureApproved value)? failureApproved,
  }) {
    return cameraEnabled?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CallControlEventStarted value)? started,
    TResult Function(_CallControlEventAnswered value)? answered,
    TResult Function(_CallControlEventEnded value)? ended,
    TResult Function(_CallControlEventSetHeld value)? setHeld,
    TResult Function(_CallControlEventSetMuted value)? setMuted,
    TResult Function(_CallControlEventSentDTMF value)? sentDTMF,
    TResult Function(_CallControlEventCameraSwitched value)? cameraSwitched,
    TResult Function(_CallControlEventCameraEnabled value)? cameraEnabled,
    TResult Function(_CallControlEventSpeakerEnabled value)? speakerEnabled,
    TResult Function(_CallControlEventFailureApproved value)? failureApproved,
    required TResult orElse(),
  }) {
    if (cameraEnabled != null) {
      return cameraEnabled(this);
    }
    return orElse();
  }
}

abstract class _CallControlEventCameraEnabled implements CallControlEvent {
  const factory _CallControlEventCameraEnabled(
          final String callId, final bool enabled) =
      _$CallControlEventCameraEnabledImpl;

  String get callId;
  bool get enabled;
}

/// @nodoc

class _$CallControlEventSpeakerEnabledImpl
    with DiagnosticableTreeMixin
    implements _CallControlEventSpeakerEnabled {
  const _$CallControlEventSpeakerEnabledImpl(this.callId, this.enabled);

  @override
  final String callId;
  @override
  final bool enabled;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallControlEvent.speakerEnabled(callId: $callId, enabled: $enabled)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CallControlEvent.speakerEnabled'))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('enabled', enabled));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallControlEventSpeakerEnabledImpl &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.enabled, enabled) || other.enabled == enabled));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callId, enabled);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? line, String? generic, String? number,
            String? email, String? displayName, bool video)
        started,
    required TResult Function(String callId) answered,
    required TResult Function(String callId) ended,
    required TResult Function(String callId, bool onHold) setHeld,
    required TResult Function(String callId, bool muted) setMuted,
    required TResult Function(String callId, String key) sentDTMF,
    required TResult Function(String callId) cameraSwitched,
    required TResult Function(String callId, bool enabled) cameraEnabled,
    required TResult Function(String callId, bool enabled) speakerEnabled,
    required TResult Function(String callId) failureApproved,
  }) {
    return speakerEnabled(callId, enabled);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? line, String? generic, String? number, String? email,
            String? displayName, bool video)?
        started,
    TResult? Function(String callId)? answered,
    TResult? Function(String callId)? ended,
    TResult? Function(String callId, bool onHold)? setHeld,
    TResult? Function(String callId, bool muted)? setMuted,
    TResult? Function(String callId, String key)? sentDTMF,
    TResult? Function(String callId)? cameraSwitched,
    TResult? Function(String callId, bool enabled)? cameraEnabled,
    TResult? Function(String callId, bool enabled)? speakerEnabled,
    TResult? Function(String callId)? failureApproved,
  }) {
    return speakerEnabled?.call(callId, enabled);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? line, String? generic, String? number, String? email,
            String? displayName, bool video)?
        started,
    TResult Function(String callId)? answered,
    TResult Function(String callId)? ended,
    TResult Function(String callId, bool onHold)? setHeld,
    TResult Function(String callId, bool muted)? setMuted,
    TResult Function(String callId, String key)? sentDTMF,
    TResult Function(String callId)? cameraSwitched,
    TResult Function(String callId, bool enabled)? cameraEnabled,
    TResult Function(String callId, bool enabled)? speakerEnabled,
    TResult Function(String callId)? failureApproved,
    required TResult orElse(),
  }) {
    if (speakerEnabled != null) {
      return speakerEnabled(callId, enabled);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CallControlEventStarted value) started,
    required TResult Function(_CallControlEventAnswered value) answered,
    required TResult Function(_CallControlEventEnded value) ended,
    required TResult Function(_CallControlEventSetHeld value) setHeld,
    required TResult Function(_CallControlEventSetMuted value) setMuted,
    required TResult Function(_CallControlEventSentDTMF value) sentDTMF,
    required TResult Function(_CallControlEventCameraSwitched value)
        cameraSwitched,
    required TResult Function(_CallControlEventCameraEnabled value)
        cameraEnabled,
    required TResult Function(_CallControlEventSpeakerEnabled value)
        speakerEnabled,
    required TResult Function(_CallControlEventFailureApproved value)
        failureApproved,
  }) {
    return speakerEnabled(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CallControlEventStarted value)? started,
    TResult? Function(_CallControlEventAnswered value)? answered,
    TResult? Function(_CallControlEventEnded value)? ended,
    TResult? Function(_CallControlEventSetHeld value)? setHeld,
    TResult? Function(_CallControlEventSetMuted value)? setMuted,
    TResult? Function(_CallControlEventSentDTMF value)? sentDTMF,
    TResult? Function(_CallControlEventCameraSwitched value)? cameraSwitched,
    TResult? Function(_CallControlEventCameraEnabled value)? cameraEnabled,
    TResult? Function(_CallControlEventSpeakerEnabled value)? speakerEnabled,
    TResult? Function(_CallControlEventFailureApproved value)? failureApproved,
  }) {
    return speakerEnabled?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CallControlEventStarted value)? started,
    TResult Function(_CallControlEventAnswered value)? answered,
    TResult Function(_CallControlEventEnded value)? ended,
    TResult Function(_CallControlEventSetHeld value)? setHeld,
    TResult Function(_CallControlEventSetMuted value)? setMuted,
    TResult Function(_CallControlEventSentDTMF value)? sentDTMF,
    TResult Function(_CallControlEventCameraSwitched value)? cameraSwitched,
    TResult Function(_CallControlEventCameraEnabled value)? cameraEnabled,
    TResult Function(_CallControlEventSpeakerEnabled value)? speakerEnabled,
    TResult Function(_CallControlEventFailureApproved value)? failureApproved,
    required TResult orElse(),
  }) {
    if (speakerEnabled != null) {
      return speakerEnabled(this);
    }
    return orElse();
  }
}

abstract class _CallControlEventSpeakerEnabled implements CallControlEvent {
  const factory _CallControlEventSpeakerEnabled(
          final String callId, final bool enabled) =
      _$CallControlEventSpeakerEnabledImpl;

  String get callId;
  bool get enabled;
}

/// @nodoc

class _$CallControlEventFailureApprovedImpl
    with DiagnosticableTreeMixin
    implements _CallControlEventFailureApproved {
  const _$CallControlEventFailureApprovedImpl(this.callId);

  @override
  final String callId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallControlEvent.failureApproved(callId: $callId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CallControlEvent.failureApproved'))
      ..add(DiagnosticsProperty('callId', callId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallControlEventFailureApprovedImpl &&
            (identical(other.callId, callId) || other.callId == callId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callId);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? line, String? generic, String? number,
            String? email, String? displayName, bool video)
        started,
    required TResult Function(String callId) answered,
    required TResult Function(String callId) ended,
    required TResult Function(String callId, bool onHold) setHeld,
    required TResult Function(String callId, bool muted) setMuted,
    required TResult Function(String callId, String key) sentDTMF,
    required TResult Function(String callId) cameraSwitched,
    required TResult Function(String callId, bool enabled) cameraEnabled,
    required TResult Function(String callId, bool enabled) speakerEnabled,
    required TResult Function(String callId) failureApproved,
  }) {
    return failureApproved(callId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? line, String? generic, String? number, String? email,
            String? displayName, bool video)?
        started,
    TResult? Function(String callId)? answered,
    TResult? Function(String callId)? ended,
    TResult? Function(String callId, bool onHold)? setHeld,
    TResult? Function(String callId, bool muted)? setMuted,
    TResult? Function(String callId, String key)? sentDTMF,
    TResult? Function(String callId)? cameraSwitched,
    TResult? Function(String callId, bool enabled)? cameraEnabled,
    TResult? Function(String callId, bool enabled)? speakerEnabled,
    TResult? Function(String callId)? failureApproved,
  }) {
    return failureApproved?.call(callId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? line, String? generic, String? number, String? email,
            String? displayName, bool video)?
        started,
    TResult Function(String callId)? answered,
    TResult Function(String callId)? ended,
    TResult Function(String callId, bool onHold)? setHeld,
    TResult Function(String callId, bool muted)? setMuted,
    TResult Function(String callId, String key)? sentDTMF,
    TResult Function(String callId)? cameraSwitched,
    TResult Function(String callId, bool enabled)? cameraEnabled,
    TResult Function(String callId, bool enabled)? speakerEnabled,
    TResult Function(String callId)? failureApproved,
    required TResult orElse(),
  }) {
    if (failureApproved != null) {
      return failureApproved(callId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CallControlEventStarted value) started,
    required TResult Function(_CallControlEventAnswered value) answered,
    required TResult Function(_CallControlEventEnded value) ended,
    required TResult Function(_CallControlEventSetHeld value) setHeld,
    required TResult Function(_CallControlEventSetMuted value) setMuted,
    required TResult Function(_CallControlEventSentDTMF value) sentDTMF,
    required TResult Function(_CallControlEventCameraSwitched value)
        cameraSwitched,
    required TResult Function(_CallControlEventCameraEnabled value)
        cameraEnabled,
    required TResult Function(_CallControlEventSpeakerEnabled value)
        speakerEnabled,
    required TResult Function(_CallControlEventFailureApproved value)
        failureApproved,
  }) {
    return failureApproved(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CallControlEventStarted value)? started,
    TResult? Function(_CallControlEventAnswered value)? answered,
    TResult? Function(_CallControlEventEnded value)? ended,
    TResult? Function(_CallControlEventSetHeld value)? setHeld,
    TResult? Function(_CallControlEventSetMuted value)? setMuted,
    TResult? Function(_CallControlEventSentDTMF value)? sentDTMF,
    TResult? Function(_CallControlEventCameraSwitched value)? cameraSwitched,
    TResult? Function(_CallControlEventCameraEnabled value)? cameraEnabled,
    TResult? Function(_CallControlEventSpeakerEnabled value)? speakerEnabled,
    TResult? Function(_CallControlEventFailureApproved value)? failureApproved,
  }) {
    return failureApproved?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CallControlEventStarted value)? started,
    TResult Function(_CallControlEventAnswered value)? answered,
    TResult Function(_CallControlEventEnded value)? ended,
    TResult Function(_CallControlEventSetHeld value)? setHeld,
    TResult Function(_CallControlEventSetMuted value)? setMuted,
    TResult Function(_CallControlEventSentDTMF value)? sentDTMF,
    TResult Function(_CallControlEventCameraSwitched value)? cameraSwitched,
    TResult Function(_CallControlEventCameraEnabled value)? cameraEnabled,
    TResult Function(_CallControlEventSpeakerEnabled value)? speakerEnabled,
    TResult Function(_CallControlEventFailureApproved value)? failureApproved,
    required TResult orElse(),
  }) {
    if (failureApproved != null) {
      return failureApproved(this);
    }
    return orElse();
  }
}

abstract class _CallControlEventFailureApproved implements CallControlEvent {
  const factory _CallControlEventFailureApproved(final String callId) =
      _$CallControlEventFailureApprovedImpl;

  String get callId;
}

/// @nodoc
mixin _$CallPerformEvent {
  String get callId => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String callId, CallkeepHandle handle,
            String? displayName, bool video)
        started,
    required TResult Function(String callId) answered,
    required TResult Function(String callId) ended,
    required TResult Function(String callId, bool onHold) setHeld,
    required TResult Function(String callId, bool muted) setMuted,
    required TResult Function(String callId, String key) sentDTMF,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String callId, CallkeepHandle handle, String? displayName,
            bool video)?
        started,
    TResult? Function(String callId)? answered,
    TResult? Function(String callId)? ended,
    TResult? Function(String callId, bool onHold)? setHeld,
    TResult? Function(String callId, bool muted)? setMuted,
    TResult? Function(String callId, String key)? sentDTMF,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String callId, CallkeepHandle handle, String? displayName,
            bool video)?
        started,
    TResult Function(String callId)? answered,
    TResult Function(String callId)? ended,
    TResult Function(String callId, bool onHold)? setHeld,
    TResult Function(String callId, bool muted)? setMuted,
    TResult Function(String callId, String key)? sentDTMF,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CallPerformEventStarted value) started,
    required TResult Function(_CallPerformEventAnswered value) answered,
    required TResult Function(_CallPerformEventEnded value) ended,
    required TResult Function(_CallPerformEventSetHeld value) setHeld,
    required TResult Function(_CallPerformEventSetMuted value) setMuted,
    required TResult Function(_CallPerformEventSentDTMF value) sentDTMF,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CallPerformEventStarted value)? started,
    TResult? Function(_CallPerformEventAnswered value)? answered,
    TResult? Function(_CallPerformEventEnded value)? ended,
    TResult? Function(_CallPerformEventSetHeld value)? setHeld,
    TResult? Function(_CallPerformEventSetMuted value)? setMuted,
    TResult? Function(_CallPerformEventSentDTMF value)? sentDTMF,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CallPerformEventStarted value)? started,
    TResult Function(_CallPerformEventAnswered value)? answered,
    TResult Function(_CallPerformEventEnded value)? ended,
    TResult Function(_CallPerformEventSetHeld value)? setHeld,
    TResult Function(_CallPerformEventSetMuted value)? setMuted,
    TResult Function(_CallPerformEventSentDTMF value)? sentDTMF,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc

class _$CallPerformEventStartedImpl extends _CallPerformEventStarted
    with DiagnosticableTreeMixin {
  _$CallPerformEventStartedImpl(this.callId,
      {required this.handle, this.displayName, required this.video})
      : super._();

  @override
  final String callId;
  @override
  final CallkeepHandle handle;
  @override
  final String? displayName;
  @override
  final bool video;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallPerformEvent.started(callId: $callId, handle: $handle, displayName: $displayName, video: $video)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', '_CallPerformEvent.started'))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('handle', handle))
      ..add(DiagnosticsProperty('displayName', displayName))
      ..add(DiagnosticsProperty('video', video));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallPerformEventStartedImpl &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.handle, handle) || other.handle == handle) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.video, video) || other.video == video));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, callId, handle, displayName, video);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String callId, CallkeepHandle handle,
            String? displayName, bool video)
        started,
    required TResult Function(String callId) answered,
    required TResult Function(String callId) ended,
    required TResult Function(String callId, bool onHold) setHeld,
    required TResult Function(String callId, bool muted) setMuted,
    required TResult Function(String callId, String key) sentDTMF,
  }) {
    return started(callId, handle, displayName, video);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String callId, CallkeepHandle handle, String? displayName,
            bool video)?
        started,
    TResult? Function(String callId)? answered,
    TResult? Function(String callId)? ended,
    TResult? Function(String callId, bool onHold)? setHeld,
    TResult? Function(String callId, bool muted)? setMuted,
    TResult? Function(String callId, String key)? sentDTMF,
  }) {
    return started?.call(callId, handle, displayName, video);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String callId, CallkeepHandle handle, String? displayName,
            bool video)?
        started,
    TResult Function(String callId)? answered,
    TResult Function(String callId)? ended,
    TResult Function(String callId, bool onHold)? setHeld,
    TResult Function(String callId, bool muted)? setMuted,
    TResult Function(String callId, String key)? sentDTMF,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(callId, handle, displayName, video);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CallPerformEventStarted value) started,
    required TResult Function(_CallPerformEventAnswered value) answered,
    required TResult Function(_CallPerformEventEnded value) ended,
    required TResult Function(_CallPerformEventSetHeld value) setHeld,
    required TResult Function(_CallPerformEventSetMuted value) setMuted,
    required TResult Function(_CallPerformEventSentDTMF value) sentDTMF,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CallPerformEventStarted value)? started,
    TResult? Function(_CallPerformEventAnswered value)? answered,
    TResult? Function(_CallPerformEventEnded value)? ended,
    TResult? Function(_CallPerformEventSetHeld value)? setHeld,
    TResult? Function(_CallPerformEventSetMuted value)? setMuted,
    TResult? Function(_CallPerformEventSentDTMF value)? sentDTMF,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CallPerformEventStarted value)? started,
    TResult Function(_CallPerformEventAnswered value)? answered,
    TResult Function(_CallPerformEventEnded value)? ended,
    TResult Function(_CallPerformEventSetHeld value)? setHeld,
    TResult Function(_CallPerformEventSetMuted value)? setMuted,
    TResult Function(_CallPerformEventSentDTMF value)? sentDTMF,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _CallPerformEventStarted extends _CallPerformEvent {
  factory _CallPerformEventStarted(final String callId,
      {required final CallkeepHandle handle,
      final String? displayName,
      required final bool video}) = _$CallPerformEventStartedImpl;
  _CallPerformEventStarted._() : super._();

  @override
  String get callId;
  CallkeepHandle get handle;
  String? get displayName;
  bool get video;
}

/// @nodoc

class _$CallPerformEventAnsweredImpl extends _CallPerformEventAnswered
    with DiagnosticableTreeMixin {
  _$CallPerformEventAnsweredImpl(this.callId) : super._();

  @override
  final String callId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallPerformEvent.answered(callId: $callId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', '_CallPerformEvent.answered'))
      ..add(DiagnosticsProperty('callId', callId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallPerformEventAnsweredImpl &&
            (identical(other.callId, callId) || other.callId == callId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callId);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String callId, CallkeepHandle handle,
            String? displayName, bool video)
        started,
    required TResult Function(String callId) answered,
    required TResult Function(String callId) ended,
    required TResult Function(String callId, bool onHold) setHeld,
    required TResult Function(String callId, bool muted) setMuted,
    required TResult Function(String callId, String key) sentDTMF,
  }) {
    return answered(callId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String callId, CallkeepHandle handle, String? displayName,
            bool video)?
        started,
    TResult? Function(String callId)? answered,
    TResult? Function(String callId)? ended,
    TResult? Function(String callId, bool onHold)? setHeld,
    TResult? Function(String callId, bool muted)? setMuted,
    TResult? Function(String callId, String key)? sentDTMF,
  }) {
    return answered?.call(callId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String callId, CallkeepHandle handle, String? displayName,
            bool video)?
        started,
    TResult Function(String callId)? answered,
    TResult Function(String callId)? ended,
    TResult Function(String callId, bool onHold)? setHeld,
    TResult Function(String callId, bool muted)? setMuted,
    TResult Function(String callId, String key)? sentDTMF,
    required TResult orElse(),
  }) {
    if (answered != null) {
      return answered(callId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CallPerformEventStarted value) started,
    required TResult Function(_CallPerformEventAnswered value) answered,
    required TResult Function(_CallPerformEventEnded value) ended,
    required TResult Function(_CallPerformEventSetHeld value) setHeld,
    required TResult Function(_CallPerformEventSetMuted value) setMuted,
    required TResult Function(_CallPerformEventSentDTMF value) sentDTMF,
  }) {
    return answered(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CallPerformEventStarted value)? started,
    TResult? Function(_CallPerformEventAnswered value)? answered,
    TResult? Function(_CallPerformEventEnded value)? ended,
    TResult? Function(_CallPerformEventSetHeld value)? setHeld,
    TResult? Function(_CallPerformEventSetMuted value)? setMuted,
    TResult? Function(_CallPerformEventSentDTMF value)? sentDTMF,
  }) {
    return answered?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CallPerformEventStarted value)? started,
    TResult Function(_CallPerformEventAnswered value)? answered,
    TResult Function(_CallPerformEventEnded value)? ended,
    TResult Function(_CallPerformEventSetHeld value)? setHeld,
    TResult Function(_CallPerformEventSetMuted value)? setMuted,
    TResult Function(_CallPerformEventSentDTMF value)? sentDTMF,
    required TResult orElse(),
  }) {
    if (answered != null) {
      return answered(this);
    }
    return orElse();
  }
}

abstract class _CallPerformEventAnswered extends _CallPerformEvent {
  factory _CallPerformEventAnswered(final String callId) =
      _$CallPerformEventAnsweredImpl;
  _CallPerformEventAnswered._() : super._();

  @override
  String get callId;
}

/// @nodoc

class _$CallPerformEventEndedImpl extends _CallPerformEventEnded
    with DiagnosticableTreeMixin {
  _$CallPerformEventEndedImpl(this.callId) : super._();

  @override
  final String callId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallPerformEvent.ended(callId: $callId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', '_CallPerformEvent.ended'))
      ..add(DiagnosticsProperty('callId', callId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallPerformEventEndedImpl &&
            (identical(other.callId, callId) || other.callId == callId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callId);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String callId, CallkeepHandle handle,
            String? displayName, bool video)
        started,
    required TResult Function(String callId) answered,
    required TResult Function(String callId) ended,
    required TResult Function(String callId, bool onHold) setHeld,
    required TResult Function(String callId, bool muted) setMuted,
    required TResult Function(String callId, String key) sentDTMF,
  }) {
    return ended(callId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String callId, CallkeepHandle handle, String? displayName,
            bool video)?
        started,
    TResult? Function(String callId)? answered,
    TResult? Function(String callId)? ended,
    TResult? Function(String callId, bool onHold)? setHeld,
    TResult? Function(String callId, bool muted)? setMuted,
    TResult? Function(String callId, String key)? sentDTMF,
  }) {
    return ended?.call(callId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String callId, CallkeepHandle handle, String? displayName,
            bool video)?
        started,
    TResult Function(String callId)? answered,
    TResult Function(String callId)? ended,
    TResult Function(String callId, bool onHold)? setHeld,
    TResult Function(String callId, bool muted)? setMuted,
    TResult Function(String callId, String key)? sentDTMF,
    required TResult orElse(),
  }) {
    if (ended != null) {
      return ended(callId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CallPerformEventStarted value) started,
    required TResult Function(_CallPerformEventAnswered value) answered,
    required TResult Function(_CallPerformEventEnded value) ended,
    required TResult Function(_CallPerformEventSetHeld value) setHeld,
    required TResult Function(_CallPerformEventSetMuted value) setMuted,
    required TResult Function(_CallPerformEventSentDTMF value) sentDTMF,
  }) {
    return ended(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CallPerformEventStarted value)? started,
    TResult? Function(_CallPerformEventAnswered value)? answered,
    TResult? Function(_CallPerformEventEnded value)? ended,
    TResult? Function(_CallPerformEventSetHeld value)? setHeld,
    TResult? Function(_CallPerformEventSetMuted value)? setMuted,
    TResult? Function(_CallPerformEventSentDTMF value)? sentDTMF,
  }) {
    return ended?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CallPerformEventStarted value)? started,
    TResult Function(_CallPerformEventAnswered value)? answered,
    TResult Function(_CallPerformEventEnded value)? ended,
    TResult Function(_CallPerformEventSetHeld value)? setHeld,
    TResult Function(_CallPerformEventSetMuted value)? setMuted,
    TResult Function(_CallPerformEventSentDTMF value)? sentDTMF,
    required TResult orElse(),
  }) {
    if (ended != null) {
      return ended(this);
    }
    return orElse();
  }
}

abstract class _CallPerformEventEnded extends _CallPerformEvent {
  factory _CallPerformEventEnded(final String callId) =
      _$CallPerformEventEndedImpl;
  _CallPerformEventEnded._() : super._();

  @override
  String get callId;
}

/// @nodoc

class _$CallPerformEventSetHeldImpl extends _CallPerformEventSetHeld
    with DiagnosticableTreeMixin {
  _$CallPerformEventSetHeldImpl(this.callId, this.onHold) : super._();

  @override
  final String callId;
  @override
  final bool onHold;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallPerformEvent.setHeld(callId: $callId, onHold: $onHold)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', '_CallPerformEvent.setHeld'))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('onHold', onHold));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallPerformEventSetHeldImpl &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.onHold, onHold) || other.onHold == onHold));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callId, onHold);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String callId, CallkeepHandle handle,
            String? displayName, bool video)
        started,
    required TResult Function(String callId) answered,
    required TResult Function(String callId) ended,
    required TResult Function(String callId, bool onHold) setHeld,
    required TResult Function(String callId, bool muted) setMuted,
    required TResult Function(String callId, String key) sentDTMF,
  }) {
    return setHeld(callId, onHold);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String callId, CallkeepHandle handle, String? displayName,
            bool video)?
        started,
    TResult? Function(String callId)? answered,
    TResult? Function(String callId)? ended,
    TResult? Function(String callId, bool onHold)? setHeld,
    TResult? Function(String callId, bool muted)? setMuted,
    TResult? Function(String callId, String key)? sentDTMF,
  }) {
    return setHeld?.call(callId, onHold);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String callId, CallkeepHandle handle, String? displayName,
            bool video)?
        started,
    TResult Function(String callId)? answered,
    TResult Function(String callId)? ended,
    TResult Function(String callId, bool onHold)? setHeld,
    TResult Function(String callId, bool muted)? setMuted,
    TResult Function(String callId, String key)? sentDTMF,
    required TResult orElse(),
  }) {
    if (setHeld != null) {
      return setHeld(callId, onHold);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CallPerformEventStarted value) started,
    required TResult Function(_CallPerformEventAnswered value) answered,
    required TResult Function(_CallPerformEventEnded value) ended,
    required TResult Function(_CallPerformEventSetHeld value) setHeld,
    required TResult Function(_CallPerformEventSetMuted value) setMuted,
    required TResult Function(_CallPerformEventSentDTMF value) sentDTMF,
  }) {
    return setHeld(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CallPerformEventStarted value)? started,
    TResult? Function(_CallPerformEventAnswered value)? answered,
    TResult? Function(_CallPerformEventEnded value)? ended,
    TResult? Function(_CallPerformEventSetHeld value)? setHeld,
    TResult? Function(_CallPerformEventSetMuted value)? setMuted,
    TResult? Function(_CallPerformEventSentDTMF value)? sentDTMF,
  }) {
    return setHeld?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CallPerformEventStarted value)? started,
    TResult Function(_CallPerformEventAnswered value)? answered,
    TResult Function(_CallPerformEventEnded value)? ended,
    TResult Function(_CallPerformEventSetHeld value)? setHeld,
    TResult Function(_CallPerformEventSetMuted value)? setMuted,
    TResult Function(_CallPerformEventSentDTMF value)? sentDTMF,
    required TResult orElse(),
  }) {
    if (setHeld != null) {
      return setHeld(this);
    }
    return orElse();
  }
}

abstract class _CallPerformEventSetHeld extends _CallPerformEvent {
  factory _CallPerformEventSetHeld(final String callId, final bool onHold) =
      _$CallPerformEventSetHeldImpl;
  _CallPerformEventSetHeld._() : super._();

  @override
  String get callId;
  bool get onHold;
}

/// @nodoc

class _$CallPerformEventSetMutedImpl extends _CallPerformEventSetMuted
    with DiagnosticableTreeMixin {
  _$CallPerformEventSetMutedImpl(this.callId, this.muted) : super._();

  @override
  final String callId;
  @override
  final bool muted;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallPerformEvent.setMuted(callId: $callId, muted: $muted)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', '_CallPerformEvent.setMuted'))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('muted', muted));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallPerformEventSetMutedImpl &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.muted, muted) || other.muted == muted));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callId, muted);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String callId, CallkeepHandle handle,
            String? displayName, bool video)
        started,
    required TResult Function(String callId) answered,
    required TResult Function(String callId) ended,
    required TResult Function(String callId, bool onHold) setHeld,
    required TResult Function(String callId, bool muted) setMuted,
    required TResult Function(String callId, String key) sentDTMF,
  }) {
    return setMuted(callId, muted);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String callId, CallkeepHandle handle, String? displayName,
            bool video)?
        started,
    TResult? Function(String callId)? answered,
    TResult? Function(String callId)? ended,
    TResult? Function(String callId, bool onHold)? setHeld,
    TResult? Function(String callId, bool muted)? setMuted,
    TResult? Function(String callId, String key)? sentDTMF,
  }) {
    return setMuted?.call(callId, muted);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String callId, CallkeepHandle handle, String? displayName,
            bool video)?
        started,
    TResult Function(String callId)? answered,
    TResult Function(String callId)? ended,
    TResult Function(String callId, bool onHold)? setHeld,
    TResult Function(String callId, bool muted)? setMuted,
    TResult Function(String callId, String key)? sentDTMF,
    required TResult orElse(),
  }) {
    if (setMuted != null) {
      return setMuted(callId, muted);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CallPerformEventStarted value) started,
    required TResult Function(_CallPerformEventAnswered value) answered,
    required TResult Function(_CallPerformEventEnded value) ended,
    required TResult Function(_CallPerformEventSetHeld value) setHeld,
    required TResult Function(_CallPerformEventSetMuted value) setMuted,
    required TResult Function(_CallPerformEventSentDTMF value) sentDTMF,
  }) {
    return setMuted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CallPerformEventStarted value)? started,
    TResult? Function(_CallPerformEventAnswered value)? answered,
    TResult? Function(_CallPerformEventEnded value)? ended,
    TResult? Function(_CallPerformEventSetHeld value)? setHeld,
    TResult? Function(_CallPerformEventSetMuted value)? setMuted,
    TResult? Function(_CallPerformEventSentDTMF value)? sentDTMF,
  }) {
    return setMuted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CallPerformEventStarted value)? started,
    TResult Function(_CallPerformEventAnswered value)? answered,
    TResult Function(_CallPerformEventEnded value)? ended,
    TResult Function(_CallPerformEventSetHeld value)? setHeld,
    TResult Function(_CallPerformEventSetMuted value)? setMuted,
    TResult Function(_CallPerformEventSentDTMF value)? sentDTMF,
    required TResult orElse(),
  }) {
    if (setMuted != null) {
      return setMuted(this);
    }
    return orElse();
  }
}

abstract class _CallPerformEventSetMuted extends _CallPerformEvent {
  factory _CallPerformEventSetMuted(final String callId, final bool muted) =
      _$CallPerformEventSetMutedImpl;
  _CallPerformEventSetMuted._() : super._();

  @override
  String get callId;
  bool get muted;
}

/// @nodoc

class _$CallPerformEventSentDTMFImpl extends _CallPerformEventSentDTMF
    with DiagnosticableTreeMixin {
  _$CallPerformEventSentDTMFImpl(this.callId, this.key) : super._();

  @override
  final String callId;
  @override
  final String key;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallPerformEvent.sentDTMF(callId: $callId, key: $key)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', '_CallPerformEvent.sentDTMF'))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('key', key));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallPerformEventSentDTMFImpl &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.key, key) || other.key == key));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callId, key);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String callId, CallkeepHandle handle,
            String? displayName, bool video)
        started,
    required TResult Function(String callId) answered,
    required TResult Function(String callId) ended,
    required TResult Function(String callId, bool onHold) setHeld,
    required TResult Function(String callId, bool muted) setMuted,
    required TResult Function(String callId, String key) sentDTMF,
  }) {
    return sentDTMF(callId, key);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String callId, CallkeepHandle handle, String? displayName,
            bool video)?
        started,
    TResult? Function(String callId)? answered,
    TResult? Function(String callId)? ended,
    TResult? Function(String callId, bool onHold)? setHeld,
    TResult? Function(String callId, bool muted)? setMuted,
    TResult? Function(String callId, String key)? sentDTMF,
  }) {
    return sentDTMF?.call(callId, key);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String callId, CallkeepHandle handle, String? displayName,
            bool video)?
        started,
    TResult Function(String callId)? answered,
    TResult Function(String callId)? ended,
    TResult Function(String callId, bool onHold)? setHeld,
    TResult Function(String callId, bool muted)? setMuted,
    TResult Function(String callId, String key)? sentDTMF,
    required TResult orElse(),
  }) {
    if (sentDTMF != null) {
      return sentDTMF(callId, key);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CallPerformEventStarted value) started,
    required TResult Function(_CallPerformEventAnswered value) answered,
    required TResult Function(_CallPerformEventEnded value) ended,
    required TResult Function(_CallPerformEventSetHeld value) setHeld,
    required TResult Function(_CallPerformEventSetMuted value) setMuted,
    required TResult Function(_CallPerformEventSentDTMF value) sentDTMF,
  }) {
    return sentDTMF(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CallPerformEventStarted value)? started,
    TResult? Function(_CallPerformEventAnswered value)? answered,
    TResult? Function(_CallPerformEventEnded value)? ended,
    TResult? Function(_CallPerformEventSetHeld value)? setHeld,
    TResult? Function(_CallPerformEventSetMuted value)? setMuted,
    TResult? Function(_CallPerformEventSentDTMF value)? sentDTMF,
  }) {
    return sentDTMF?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CallPerformEventStarted value)? started,
    TResult Function(_CallPerformEventAnswered value)? answered,
    TResult Function(_CallPerformEventEnded value)? ended,
    TResult Function(_CallPerformEventSetHeld value)? setHeld,
    TResult Function(_CallPerformEventSetMuted value)? setMuted,
    TResult Function(_CallPerformEventSentDTMF value)? sentDTMF,
    required TResult orElse(),
  }) {
    if (sentDTMF != null) {
      return sentDTMF(this);
    }
    return orElse();
  }
}

abstract class _CallPerformEventSentDTMF extends _CallPerformEvent {
  factory _CallPerformEventSentDTMF(final String callId, final String key) =
      _$CallPerformEventSentDTMFImpl;
  _CallPerformEventSentDTMF._() : super._();

  @override
  String get callId;
  String get key;
}

/// @nodoc
mixin _$PeerConnectionEvent {
  String get callId => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String callId, RTCSignalingState state)
        signalingStateChanged,
    required TResult Function(String callId, RTCPeerConnectionState state)
        connectionStateChanged,
    required TResult Function(String callId, RTCIceGatheringState state)
        iceGatheringStateChanged,
    required TResult Function(String callId, RTCIceConnectionState state)
        iceConnectionStateChanged,
    required TResult Function(String callId, RTCIceCandidate candidate)
        iceCandidateIdentified,
    required TResult Function(String callId, MediaStream stream) streamAdded,
    required TResult Function(String callId, MediaStream stream) streamRemoved,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String callId, RTCSignalingState state)?
        signalingStateChanged,
    TResult? Function(String callId, RTCPeerConnectionState state)?
        connectionStateChanged,
    TResult? Function(String callId, RTCIceGatheringState state)?
        iceGatheringStateChanged,
    TResult? Function(String callId, RTCIceConnectionState state)?
        iceConnectionStateChanged,
    TResult? Function(String callId, RTCIceCandidate candidate)?
        iceCandidateIdentified,
    TResult? Function(String callId, MediaStream stream)? streamAdded,
    TResult? Function(String callId, MediaStream stream)? streamRemoved,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String callId, RTCSignalingState state)?
        signalingStateChanged,
    TResult Function(String callId, RTCPeerConnectionState state)?
        connectionStateChanged,
    TResult Function(String callId, RTCIceGatheringState state)?
        iceGatheringStateChanged,
    TResult Function(String callId, RTCIceConnectionState state)?
        iceConnectionStateChanged,
    TResult Function(String callId, RTCIceCandidate candidate)?
        iceCandidateIdentified,
    TResult Function(String callId, MediaStream stream)? streamAdded,
    TResult Function(String callId, MediaStream stream)? streamRemoved,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PeerConnectionEventSignalingStateChanged value)
        signalingStateChanged,
    required TResult Function(_PeerConnectionEventConnectionStateChanged value)
        connectionStateChanged,
    required TResult Function(
            _PeerConnectionEventIceGatheringStateChanged value)
        iceGatheringStateChanged,
    required TResult Function(
            _PeerConnectionEventIceConnectionStateChanged value)
        iceConnectionStateChanged,
    required TResult Function(_PeerConnectionEventIceCandidateIdentified value)
        iceCandidateIdentified,
    required TResult Function(_PeerConnectionEventStreamAdded value)
        streamAdded,
    required TResult Function(_PeerConnectionEventStreamRemoved value)
        streamRemoved,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PeerConnectionEventSignalingStateChanged value)?
        signalingStateChanged,
    TResult? Function(_PeerConnectionEventConnectionStateChanged value)?
        connectionStateChanged,
    TResult? Function(_PeerConnectionEventIceGatheringStateChanged value)?
        iceGatheringStateChanged,
    TResult? Function(_PeerConnectionEventIceConnectionStateChanged value)?
        iceConnectionStateChanged,
    TResult? Function(_PeerConnectionEventIceCandidateIdentified value)?
        iceCandidateIdentified,
    TResult? Function(_PeerConnectionEventStreamAdded value)? streamAdded,
    TResult? Function(_PeerConnectionEventStreamRemoved value)? streamRemoved,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PeerConnectionEventSignalingStateChanged value)?
        signalingStateChanged,
    TResult Function(_PeerConnectionEventConnectionStateChanged value)?
        connectionStateChanged,
    TResult Function(_PeerConnectionEventIceGatheringStateChanged value)?
        iceGatheringStateChanged,
    TResult Function(_PeerConnectionEventIceConnectionStateChanged value)?
        iceConnectionStateChanged,
    TResult Function(_PeerConnectionEventIceCandidateIdentified value)?
        iceCandidateIdentified,
    TResult Function(_PeerConnectionEventStreamAdded value)? streamAdded,
    TResult Function(_PeerConnectionEventStreamRemoved value)? streamRemoved,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc

class _$PeerConnectionEventSignalingStateChangedImpl
    with DiagnosticableTreeMixin
    implements _PeerConnectionEventSignalingStateChanged {
  const _$PeerConnectionEventSignalingStateChangedImpl(this.callId, this.state);

  @override
  final String callId;
  @override
  final RTCSignalingState state;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_PeerConnectionEvent.signalingStateChanged(callId: $callId, state: $state)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty(
          'type', '_PeerConnectionEvent.signalingStateChanged'))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('state', state));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PeerConnectionEventSignalingStateChangedImpl &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.state, state) || other.state == state));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callId, state);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String callId, RTCSignalingState state)
        signalingStateChanged,
    required TResult Function(String callId, RTCPeerConnectionState state)
        connectionStateChanged,
    required TResult Function(String callId, RTCIceGatheringState state)
        iceGatheringStateChanged,
    required TResult Function(String callId, RTCIceConnectionState state)
        iceConnectionStateChanged,
    required TResult Function(String callId, RTCIceCandidate candidate)
        iceCandidateIdentified,
    required TResult Function(String callId, MediaStream stream) streamAdded,
    required TResult Function(String callId, MediaStream stream) streamRemoved,
  }) {
    return signalingStateChanged(callId, state);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String callId, RTCSignalingState state)?
        signalingStateChanged,
    TResult? Function(String callId, RTCPeerConnectionState state)?
        connectionStateChanged,
    TResult? Function(String callId, RTCIceGatheringState state)?
        iceGatheringStateChanged,
    TResult? Function(String callId, RTCIceConnectionState state)?
        iceConnectionStateChanged,
    TResult? Function(String callId, RTCIceCandidate candidate)?
        iceCandidateIdentified,
    TResult? Function(String callId, MediaStream stream)? streamAdded,
    TResult? Function(String callId, MediaStream stream)? streamRemoved,
  }) {
    return signalingStateChanged?.call(callId, state);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String callId, RTCSignalingState state)?
        signalingStateChanged,
    TResult Function(String callId, RTCPeerConnectionState state)?
        connectionStateChanged,
    TResult Function(String callId, RTCIceGatheringState state)?
        iceGatheringStateChanged,
    TResult Function(String callId, RTCIceConnectionState state)?
        iceConnectionStateChanged,
    TResult Function(String callId, RTCIceCandidate candidate)?
        iceCandidateIdentified,
    TResult Function(String callId, MediaStream stream)? streamAdded,
    TResult Function(String callId, MediaStream stream)? streamRemoved,
    required TResult orElse(),
  }) {
    if (signalingStateChanged != null) {
      return signalingStateChanged(callId, state);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PeerConnectionEventSignalingStateChanged value)
        signalingStateChanged,
    required TResult Function(_PeerConnectionEventConnectionStateChanged value)
        connectionStateChanged,
    required TResult Function(
            _PeerConnectionEventIceGatheringStateChanged value)
        iceGatheringStateChanged,
    required TResult Function(
            _PeerConnectionEventIceConnectionStateChanged value)
        iceConnectionStateChanged,
    required TResult Function(_PeerConnectionEventIceCandidateIdentified value)
        iceCandidateIdentified,
    required TResult Function(_PeerConnectionEventStreamAdded value)
        streamAdded,
    required TResult Function(_PeerConnectionEventStreamRemoved value)
        streamRemoved,
  }) {
    return signalingStateChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PeerConnectionEventSignalingStateChanged value)?
        signalingStateChanged,
    TResult? Function(_PeerConnectionEventConnectionStateChanged value)?
        connectionStateChanged,
    TResult? Function(_PeerConnectionEventIceGatheringStateChanged value)?
        iceGatheringStateChanged,
    TResult? Function(_PeerConnectionEventIceConnectionStateChanged value)?
        iceConnectionStateChanged,
    TResult? Function(_PeerConnectionEventIceCandidateIdentified value)?
        iceCandidateIdentified,
    TResult? Function(_PeerConnectionEventStreamAdded value)? streamAdded,
    TResult? Function(_PeerConnectionEventStreamRemoved value)? streamRemoved,
  }) {
    return signalingStateChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PeerConnectionEventSignalingStateChanged value)?
        signalingStateChanged,
    TResult Function(_PeerConnectionEventConnectionStateChanged value)?
        connectionStateChanged,
    TResult Function(_PeerConnectionEventIceGatheringStateChanged value)?
        iceGatheringStateChanged,
    TResult Function(_PeerConnectionEventIceConnectionStateChanged value)?
        iceConnectionStateChanged,
    TResult Function(_PeerConnectionEventIceCandidateIdentified value)?
        iceCandidateIdentified,
    TResult Function(_PeerConnectionEventStreamAdded value)? streamAdded,
    TResult Function(_PeerConnectionEventStreamRemoved value)? streamRemoved,
    required TResult orElse(),
  }) {
    if (signalingStateChanged != null) {
      return signalingStateChanged(this);
    }
    return orElse();
  }
}

abstract class _PeerConnectionEventSignalingStateChanged
    implements _PeerConnectionEvent {
  const factory _PeerConnectionEventSignalingStateChanged(
          final String callId, final RTCSignalingState state) =
      _$PeerConnectionEventSignalingStateChangedImpl;

  @override
  String get callId;
  RTCSignalingState get state;
}

/// @nodoc

class _$PeerConnectionEventConnectionStateChangedImpl
    with DiagnosticableTreeMixin
    implements _PeerConnectionEventConnectionStateChanged {
  const _$PeerConnectionEventConnectionStateChangedImpl(
      this.callId, this.state);

  @override
  final String callId;
  @override
  final RTCPeerConnectionState state;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_PeerConnectionEvent.connectionStateChanged(callId: $callId, state: $state)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty(
          'type', '_PeerConnectionEvent.connectionStateChanged'))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('state', state));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PeerConnectionEventConnectionStateChangedImpl &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.state, state) || other.state == state));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callId, state);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String callId, RTCSignalingState state)
        signalingStateChanged,
    required TResult Function(String callId, RTCPeerConnectionState state)
        connectionStateChanged,
    required TResult Function(String callId, RTCIceGatheringState state)
        iceGatheringStateChanged,
    required TResult Function(String callId, RTCIceConnectionState state)
        iceConnectionStateChanged,
    required TResult Function(String callId, RTCIceCandidate candidate)
        iceCandidateIdentified,
    required TResult Function(String callId, MediaStream stream) streamAdded,
    required TResult Function(String callId, MediaStream stream) streamRemoved,
  }) {
    return connectionStateChanged(callId, state);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String callId, RTCSignalingState state)?
        signalingStateChanged,
    TResult? Function(String callId, RTCPeerConnectionState state)?
        connectionStateChanged,
    TResult? Function(String callId, RTCIceGatheringState state)?
        iceGatheringStateChanged,
    TResult? Function(String callId, RTCIceConnectionState state)?
        iceConnectionStateChanged,
    TResult? Function(String callId, RTCIceCandidate candidate)?
        iceCandidateIdentified,
    TResult? Function(String callId, MediaStream stream)? streamAdded,
    TResult? Function(String callId, MediaStream stream)? streamRemoved,
  }) {
    return connectionStateChanged?.call(callId, state);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String callId, RTCSignalingState state)?
        signalingStateChanged,
    TResult Function(String callId, RTCPeerConnectionState state)?
        connectionStateChanged,
    TResult Function(String callId, RTCIceGatheringState state)?
        iceGatheringStateChanged,
    TResult Function(String callId, RTCIceConnectionState state)?
        iceConnectionStateChanged,
    TResult Function(String callId, RTCIceCandidate candidate)?
        iceCandidateIdentified,
    TResult Function(String callId, MediaStream stream)? streamAdded,
    TResult Function(String callId, MediaStream stream)? streamRemoved,
    required TResult orElse(),
  }) {
    if (connectionStateChanged != null) {
      return connectionStateChanged(callId, state);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PeerConnectionEventSignalingStateChanged value)
        signalingStateChanged,
    required TResult Function(_PeerConnectionEventConnectionStateChanged value)
        connectionStateChanged,
    required TResult Function(
            _PeerConnectionEventIceGatheringStateChanged value)
        iceGatheringStateChanged,
    required TResult Function(
            _PeerConnectionEventIceConnectionStateChanged value)
        iceConnectionStateChanged,
    required TResult Function(_PeerConnectionEventIceCandidateIdentified value)
        iceCandidateIdentified,
    required TResult Function(_PeerConnectionEventStreamAdded value)
        streamAdded,
    required TResult Function(_PeerConnectionEventStreamRemoved value)
        streamRemoved,
  }) {
    return connectionStateChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PeerConnectionEventSignalingStateChanged value)?
        signalingStateChanged,
    TResult? Function(_PeerConnectionEventConnectionStateChanged value)?
        connectionStateChanged,
    TResult? Function(_PeerConnectionEventIceGatheringStateChanged value)?
        iceGatheringStateChanged,
    TResult? Function(_PeerConnectionEventIceConnectionStateChanged value)?
        iceConnectionStateChanged,
    TResult? Function(_PeerConnectionEventIceCandidateIdentified value)?
        iceCandidateIdentified,
    TResult? Function(_PeerConnectionEventStreamAdded value)? streamAdded,
    TResult? Function(_PeerConnectionEventStreamRemoved value)? streamRemoved,
  }) {
    return connectionStateChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PeerConnectionEventSignalingStateChanged value)?
        signalingStateChanged,
    TResult Function(_PeerConnectionEventConnectionStateChanged value)?
        connectionStateChanged,
    TResult Function(_PeerConnectionEventIceGatheringStateChanged value)?
        iceGatheringStateChanged,
    TResult Function(_PeerConnectionEventIceConnectionStateChanged value)?
        iceConnectionStateChanged,
    TResult Function(_PeerConnectionEventIceCandidateIdentified value)?
        iceCandidateIdentified,
    TResult Function(_PeerConnectionEventStreamAdded value)? streamAdded,
    TResult Function(_PeerConnectionEventStreamRemoved value)? streamRemoved,
    required TResult orElse(),
  }) {
    if (connectionStateChanged != null) {
      return connectionStateChanged(this);
    }
    return orElse();
  }
}

abstract class _PeerConnectionEventConnectionStateChanged
    implements _PeerConnectionEvent {
  const factory _PeerConnectionEventConnectionStateChanged(
          final String callId, final RTCPeerConnectionState state) =
      _$PeerConnectionEventConnectionStateChangedImpl;

  @override
  String get callId;
  RTCPeerConnectionState get state;
}

/// @nodoc

class _$PeerConnectionEventIceGatheringStateChangedImpl
    with DiagnosticableTreeMixin
    implements _PeerConnectionEventIceGatheringStateChanged {
  const _$PeerConnectionEventIceGatheringStateChangedImpl(
      this.callId, this.state);

  @override
  final String callId;
  @override
  final RTCIceGatheringState state;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_PeerConnectionEvent.iceGatheringStateChanged(callId: $callId, state: $state)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty(
          'type', '_PeerConnectionEvent.iceGatheringStateChanged'))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('state', state));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PeerConnectionEventIceGatheringStateChangedImpl &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.state, state) || other.state == state));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callId, state);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String callId, RTCSignalingState state)
        signalingStateChanged,
    required TResult Function(String callId, RTCPeerConnectionState state)
        connectionStateChanged,
    required TResult Function(String callId, RTCIceGatheringState state)
        iceGatheringStateChanged,
    required TResult Function(String callId, RTCIceConnectionState state)
        iceConnectionStateChanged,
    required TResult Function(String callId, RTCIceCandidate candidate)
        iceCandidateIdentified,
    required TResult Function(String callId, MediaStream stream) streamAdded,
    required TResult Function(String callId, MediaStream stream) streamRemoved,
  }) {
    return iceGatheringStateChanged(callId, state);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String callId, RTCSignalingState state)?
        signalingStateChanged,
    TResult? Function(String callId, RTCPeerConnectionState state)?
        connectionStateChanged,
    TResult? Function(String callId, RTCIceGatheringState state)?
        iceGatheringStateChanged,
    TResult? Function(String callId, RTCIceConnectionState state)?
        iceConnectionStateChanged,
    TResult? Function(String callId, RTCIceCandidate candidate)?
        iceCandidateIdentified,
    TResult? Function(String callId, MediaStream stream)? streamAdded,
    TResult? Function(String callId, MediaStream stream)? streamRemoved,
  }) {
    return iceGatheringStateChanged?.call(callId, state);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String callId, RTCSignalingState state)?
        signalingStateChanged,
    TResult Function(String callId, RTCPeerConnectionState state)?
        connectionStateChanged,
    TResult Function(String callId, RTCIceGatheringState state)?
        iceGatheringStateChanged,
    TResult Function(String callId, RTCIceConnectionState state)?
        iceConnectionStateChanged,
    TResult Function(String callId, RTCIceCandidate candidate)?
        iceCandidateIdentified,
    TResult Function(String callId, MediaStream stream)? streamAdded,
    TResult Function(String callId, MediaStream stream)? streamRemoved,
    required TResult orElse(),
  }) {
    if (iceGatheringStateChanged != null) {
      return iceGatheringStateChanged(callId, state);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PeerConnectionEventSignalingStateChanged value)
        signalingStateChanged,
    required TResult Function(_PeerConnectionEventConnectionStateChanged value)
        connectionStateChanged,
    required TResult Function(
            _PeerConnectionEventIceGatheringStateChanged value)
        iceGatheringStateChanged,
    required TResult Function(
            _PeerConnectionEventIceConnectionStateChanged value)
        iceConnectionStateChanged,
    required TResult Function(_PeerConnectionEventIceCandidateIdentified value)
        iceCandidateIdentified,
    required TResult Function(_PeerConnectionEventStreamAdded value)
        streamAdded,
    required TResult Function(_PeerConnectionEventStreamRemoved value)
        streamRemoved,
  }) {
    return iceGatheringStateChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PeerConnectionEventSignalingStateChanged value)?
        signalingStateChanged,
    TResult? Function(_PeerConnectionEventConnectionStateChanged value)?
        connectionStateChanged,
    TResult? Function(_PeerConnectionEventIceGatheringStateChanged value)?
        iceGatheringStateChanged,
    TResult? Function(_PeerConnectionEventIceConnectionStateChanged value)?
        iceConnectionStateChanged,
    TResult? Function(_PeerConnectionEventIceCandidateIdentified value)?
        iceCandidateIdentified,
    TResult? Function(_PeerConnectionEventStreamAdded value)? streamAdded,
    TResult? Function(_PeerConnectionEventStreamRemoved value)? streamRemoved,
  }) {
    return iceGatheringStateChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PeerConnectionEventSignalingStateChanged value)?
        signalingStateChanged,
    TResult Function(_PeerConnectionEventConnectionStateChanged value)?
        connectionStateChanged,
    TResult Function(_PeerConnectionEventIceGatheringStateChanged value)?
        iceGatheringStateChanged,
    TResult Function(_PeerConnectionEventIceConnectionStateChanged value)?
        iceConnectionStateChanged,
    TResult Function(_PeerConnectionEventIceCandidateIdentified value)?
        iceCandidateIdentified,
    TResult Function(_PeerConnectionEventStreamAdded value)? streamAdded,
    TResult Function(_PeerConnectionEventStreamRemoved value)? streamRemoved,
    required TResult orElse(),
  }) {
    if (iceGatheringStateChanged != null) {
      return iceGatheringStateChanged(this);
    }
    return orElse();
  }
}

abstract class _PeerConnectionEventIceGatheringStateChanged
    implements _PeerConnectionEvent {
  const factory _PeerConnectionEventIceGatheringStateChanged(
          final String callId, final RTCIceGatheringState state) =
      _$PeerConnectionEventIceGatheringStateChangedImpl;

  @override
  String get callId;
  RTCIceGatheringState get state;
}

/// @nodoc

class _$PeerConnectionEventIceConnectionStateChangedImpl
    with DiagnosticableTreeMixin
    implements _PeerConnectionEventIceConnectionStateChanged {
  const _$PeerConnectionEventIceConnectionStateChangedImpl(
      this.callId, this.state);

  @override
  final String callId;
  @override
  final RTCIceConnectionState state;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_PeerConnectionEvent.iceConnectionStateChanged(callId: $callId, state: $state)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty(
          'type', '_PeerConnectionEvent.iceConnectionStateChanged'))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('state', state));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PeerConnectionEventIceConnectionStateChangedImpl &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.state, state) || other.state == state));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callId, state);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String callId, RTCSignalingState state)
        signalingStateChanged,
    required TResult Function(String callId, RTCPeerConnectionState state)
        connectionStateChanged,
    required TResult Function(String callId, RTCIceGatheringState state)
        iceGatheringStateChanged,
    required TResult Function(String callId, RTCIceConnectionState state)
        iceConnectionStateChanged,
    required TResult Function(String callId, RTCIceCandidate candidate)
        iceCandidateIdentified,
    required TResult Function(String callId, MediaStream stream) streamAdded,
    required TResult Function(String callId, MediaStream stream) streamRemoved,
  }) {
    return iceConnectionStateChanged(callId, state);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String callId, RTCSignalingState state)?
        signalingStateChanged,
    TResult? Function(String callId, RTCPeerConnectionState state)?
        connectionStateChanged,
    TResult? Function(String callId, RTCIceGatheringState state)?
        iceGatheringStateChanged,
    TResult? Function(String callId, RTCIceConnectionState state)?
        iceConnectionStateChanged,
    TResult? Function(String callId, RTCIceCandidate candidate)?
        iceCandidateIdentified,
    TResult? Function(String callId, MediaStream stream)? streamAdded,
    TResult? Function(String callId, MediaStream stream)? streamRemoved,
  }) {
    return iceConnectionStateChanged?.call(callId, state);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String callId, RTCSignalingState state)?
        signalingStateChanged,
    TResult Function(String callId, RTCPeerConnectionState state)?
        connectionStateChanged,
    TResult Function(String callId, RTCIceGatheringState state)?
        iceGatheringStateChanged,
    TResult Function(String callId, RTCIceConnectionState state)?
        iceConnectionStateChanged,
    TResult Function(String callId, RTCIceCandidate candidate)?
        iceCandidateIdentified,
    TResult Function(String callId, MediaStream stream)? streamAdded,
    TResult Function(String callId, MediaStream stream)? streamRemoved,
    required TResult orElse(),
  }) {
    if (iceConnectionStateChanged != null) {
      return iceConnectionStateChanged(callId, state);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PeerConnectionEventSignalingStateChanged value)
        signalingStateChanged,
    required TResult Function(_PeerConnectionEventConnectionStateChanged value)
        connectionStateChanged,
    required TResult Function(
            _PeerConnectionEventIceGatheringStateChanged value)
        iceGatheringStateChanged,
    required TResult Function(
            _PeerConnectionEventIceConnectionStateChanged value)
        iceConnectionStateChanged,
    required TResult Function(_PeerConnectionEventIceCandidateIdentified value)
        iceCandidateIdentified,
    required TResult Function(_PeerConnectionEventStreamAdded value)
        streamAdded,
    required TResult Function(_PeerConnectionEventStreamRemoved value)
        streamRemoved,
  }) {
    return iceConnectionStateChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PeerConnectionEventSignalingStateChanged value)?
        signalingStateChanged,
    TResult? Function(_PeerConnectionEventConnectionStateChanged value)?
        connectionStateChanged,
    TResult? Function(_PeerConnectionEventIceGatheringStateChanged value)?
        iceGatheringStateChanged,
    TResult? Function(_PeerConnectionEventIceConnectionStateChanged value)?
        iceConnectionStateChanged,
    TResult? Function(_PeerConnectionEventIceCandidateIdentified value)?
        iceCandidateIdentified,
    TResult? Function(_PeerConnectionEventStreamAdded value)? streamAdded,
    TResult? Function(_PeerConnectionEventStreamRemoved value)? streamRemoved,
  }) {
    return iceConnectionStateChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PeerConnectionEventSignalingStateChanged value)?
        signalingStateChanged,
    TResult Function(_PeerConnectionEventConnectionStateChanged value)?
        connectionStateChanged,
    TResult Function(_PeerConnectionEventIceGatheringStateChanged value)?
        iceGatheringStateChanged,
    TResult Function(_PeerConnectionEventIceConnectionStateChanged value)?
        iceConnectionStateChanged,
    TResult Function(_PeerConnectionEventIceCandidateIdentified value)?
        iceCandidateIdentified,
    TResult Function(_PeerConnectionEventStreamAdded value)? streamAdded,
    TResult Function(_PeerConnectionEventStreamRemoved value)? streamRemoved,
    required TResult orElse(),
  }) {
    if (iceConnectionStateChanged != null) {
      return iceConnectionStateChanged(this);
    }
    return orElse();
  }
}

abstract class _PeerConnectionEventIceConnectionStateChanged
    implements _PeerConnectionEvent {
  const factory _PeerConnectionEventIceConnectionStateChanged(
          final String callId, final RTCIceConnectionState state) =
      _$PeerConnectionEventIceConnectionStateChangedImpl;

  @override
  String get callId;
  RTCIceConnectionState get state;
}

/// @nodoc

class _$PeerConnectionEventIceCandidateIdentifiedImpl
    with DiagnosticableTreeMixin
    implements _PeerConnectionEventIceCandidateIdentified {
  const _$PeerConnectionEventIceCandidateIdentifiedImpl(
      this.callId, this.candidate);

  @override
  final String callId;
  @override
  final RTCIceCandidate candidate;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_PeerConnectionEvent.iceCandidateIdentified(callId: $callId, candidate: $candidate)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty(
          'type', '_PeerConnectionEvent.iceCandidateIdentified'))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('candidate', candidate));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PeerConnectionEventIceCandidateIdentifiedImpl &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.candidate, candidate) ||
                other.candidate == candidate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callId, candidate);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String callId, RTCSignalingState state)
        signalingStateChanged,
    required TResult Function(String callId, RTCPeerConnectionState state)
        connectionStateChanged,
    required TResult Function(String callId, RTCIceGatheringState state)
        iceGatheringStateChanged,
    required TResult Function(String callId, RTCIceConnectionState state)
        iceConnectionStateChanged,
    required TResult Function(String callId, RTCIceCandidate candidate)
        iceCandidateIdentified,
    required TResult Function(String callId, MediaStream stream) streamAdded,
    required TResult Function(String callId, MediaStream stream) streamRemoved,
  }) {
    return iceCandidateIdentified(callId, candidate);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String callId, RTCSignalingState state)?
        signalingStateChanged,
    TResult? Function(String callId, RTCPeerConnectionState state)?
        connectionStateChanged,
    TResult? Function(String callId, RTCIceGatheringState state)?
        iceGatheringStateChanged,
    TResult? Function(String callId, RTCIceConnectionState state)?
        iceConnectionStateChanged,
    TResult? Function(String callId, RTCIceCandidate candidate)?
        iceCandidateIdentified,
    TResult? Function(String callId, MediaStream stream)? streamAdded,
    TResult? Function(String callId, MediaStream stream)? streamRemoved,
  }) {
    return iceCandidateIdentified?.call(callId, candidate);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String callId, RTCSignalingState state)?
        signalingStateChanged,
    TResult Function(String callId, RTCPeerConnectionState state)?
        connectionStateChanged,
    TResult Function(String callId, RTCIceGatheringState state)?
        iceGatheringStateChanged,
    TResult Function(String callId, RTCIceConnectionState state)?
        iceConnectionStateChanged,
    TResult Function(String callId, RTCIceCandidate candidate)?
        iceCandidateIdentified,
    TResult Function(String callId, MediaStream stream)? streamAdded,
    TResult Function(String callId, MediaStream stream)? streamRemoved,
    required TResult orElse(),
  }) {
    if (iceCandidateIdentified != null) {
      return iceCandidateIdentified(callId, candidate);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PeerConnectionEventSignalingStateChanged value)
        signalingStateChanged,
    required TResult Function(_PeerConnectionEventConnectionStateChanged value)
        connectionStateChanged,
    required TResult Function(
            _PeerConnectionEventIceGatheringStateChanged value)
        iceGatheringStateChanged,
    required TResult Function(
            _PeerConnectionEventIceConnectionStateChanged value)
        iceConnectionStateChanged,
    required TResult Function(_PeerConnectionEventIceCandidateIdentified value)
        iceCandidateIdentified,
    required TResult Function(_PeerConnectionEventStreamAdded value)
        streamAdded,
    required TResult Function(_PeerConnectionEventStreamRemoved value)
        streamRemoved,
  }) {
    return iceCandidateIdentified(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PeerConnectionEventSignalingStateChanged value)?
        signalingStateChanged,
    TResult? Function(_PeerConnectionEventConnectionStateChanged value)?
        connectionStateChanged,
    TResult? Function(_PeerConnectionEventIceGatheringStateChanged value)?
        iceGatheringStateChanged,
    TResult? Function(_PeerConnectionEventIceConnectionStateChanged value)?
        iceConnectionStateChanged,
    TResult? Function(_PeerConnectionEventIceCandidateIdentified value)?
        iceCandidateIdentified,
    TResult? Function(_PeerConnectionEventStreamAdded value)? streamAdded,
    TResult? Function(_PeerConnectionEventStreamRemoved value)? streamRemoved,
  }) {
    return iceCandidateIdentified?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PeerConnectionEventSignalingStateChanged value)?
        signalingStateChanged,
    TResult Function(_PeerConnectionEventConnectionStateChanged value)?
        connectionStateChanged,
    TResult Function(_PeerConnectionEventIceGatheringStateChanged value)?
        iceGatheringStateChanged,
    TResult Function(_PeerConnectionEventIceConnectionStateChanged value)?
        iceConnectionStateChanged,
    TResult Function(_PeerConnectionEventIceCandidateIdentified value)?
        iceCandidateIdentified,
    TResult Function(_PeerConnectionEventStreamAdded value)? streamAdded,
    TResult Function(_PeerConnectionEventStreamRemoved value)? streamRemoved,
    required TResult orElse(),
  }) {
    if (iceCandidateIdentified != null) {
      return iceCandidateIdentified(this);
    }
    return orElse();
  }
}

abstract class _PeerConnectionEventIceCandidateIdentified
    implements _PeerConnectionEvent {
  const factory _PeerConnectionEventIceCandidateIdentified(
          final String callId, final RTCIceCandidate candidate) =
      _$PeerConnectionEventIceCandidateIdentifiedImpl;

  @override
  String get callId;
  RTCIceCandidate get candidate;
}

/// @nodoc

class _$PeerConnectionEventStreamAddedImpl
    with DiagnosticableTreeMixin
    implements _PeerConnectionEventStreamAdded {
  const _$PeerConnectionEventStreamAddedImpl(this.callId, this.stream);

  @override
  final String callId;
  @override
  final MediaStream stream;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_PeerConnectionEvent.streamAdded(callId: $callId, stream: $stream)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', '_PeerConnectionEvent.streamAdded'))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('stream', stream));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PeerConnectionEventStreamAddedImpl &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.stream, stream) || other.stream == stream));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callId, stream);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String callId, RTCSignalingState state)
        signalingStateChanged,
    required TResult Function(String callId, RTCPeerConnectionState state)
        connectionStateChanged,
    required TResult Function(String callId, RTCIceGatheringState state)
        iceGatheringStateChanged,
    required TResult Function(String callId, RTCIceConnectionState state)
        iceConnectionStateChanged,
    required TResult Function(String callId, RTCIceCandidate candidate)
        iceCandidateIdentified,
    required TResult Function(String callId, MediaStream stream) streamAdded,
    required TResult Function(String callId, MediaStream stream) streamRemoved,
  }) {
    return streamAdded(callId, stream);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String callId, RTCSignalingState state)?
        signalingStateChanged,
    TResult? Function(String callId, RTCPeerConnectionState state)?
        connectionStateChanged,
    TResult? Function(String callId, RTCIceGatheringState state)?
        iceGatheringStateChanged,
    TResult? Function(String callId, RTCIceConnectionState state)?
        iceConnectionStateChanged,
    TResult? Function(String callId, RTCIceCandidate candidate)?
        iceCandidateIdentified,
    TResult? Function(String callId, MediaStream stream)? streamAdded,
    TResult? Function(String callId, MediaStream stream)? streamRemoved,
  }) {
    return streamAdded?.call(callId, stream);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String callId, RTCSignalingState state)?
        signalingStateChanged,
    TResult Function(String callId, RTCPeerConnectionState state)?
        connectionStateChanged,
    TResult Function(String callId, RTCIceGatheringState state)?
        iceGatheringStateChanged,
    TResult Function(String callId, RTCIceConnectionState state)?
        iceConnectionStateChanged,
    TResult Function(String callId, RTCIceCandidate candidate)?
        iceCandidateIdentified,
    TResult Function(String callId, MediaStream stream)? streamAdded,
    TResult Function(String callId, MediaStream stream)? streamRemoved,
    required TResult orElse(),
  }) {
    if (streamAdded != null) {
      return streamAdded(callId, stream);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PeerConnectionEventSignalingStateChanged value)
        signalingStateChanged,
    required TResult Function(_PeerConnectionEventConnectionStateChanged value)
        connectionStateChanged,
    required TResult Function(
            _PeerConnectionEventIceGatheringStateChanged value)
        iceGatheringStateChanged,
    required TResult Function(
            _PeerConnectionEventIceConnectionStateChanged value)
        iceConnectionStateChanged,
    required TResult Function(_PeerConnectionEventIceCandidateIdentified value)
        iceCandidateIdentified,
    required TResult Function(_PeerConnectionEventStreamAdded value)
        streamAdded,
    required TResult Function(_PeerConnectionEventStreamRemoved value)
        streamRemoved,
  }) {
    return streamAdded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PeerConnectionEventSignalingStateChanged value)?
        signalingStateChanged,
    TResult? Function(_PeerConnectionEventConnectionStateChanged value)?
        connectionStateChanged,
    TResult? Function(_PeerConnectionEventIceGatheringStateChanged value)?
        iceGatheringStateChanged,
    TResult? Function(_PeerConnectionEventIceConnectionStateChanged value)?
        iceConnectionStateChanged,
    TResult? Function(_PeerConnectionEventIceCandidateIdentified value)?
        iceCandidateIdentified,
    TResult? Function(_PeerConnectionEventStreamAdded value)? streamAdded,
    TResult? Function(_PeerConnectionEventStreamRemoved value)? streamRemoved,
  }) {
    return streamAdded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PeerConnectionEventSignalingStateChanged value)?
        signalingStateChanged,
    TResult Function(_PeerConnectionEventConnectionStateChanged value)?
        connectionStateChanged,
    TResult Function(_PeerConnectionEventIceGatheringStateChanged value)?
        iceGatheringStateChanged,
    TResult Function(_PeerConnectionEventIceConnectionStateChanged value)?
        iceConnectionStateChanged,
    TResult Function(_PeerConnectionEventIceCandidateIdentified value)?
        iceCandidateIdentified,
    TResult Function(_PeerConnectionEventStreamAdded value)? streamAdded,
    TResult Function(_PeerConnectionEventStreamRemoved value)? streamRemoved,
    required TResult orElse(),
  }) {
    if (streamAdded != null) {
      return streamAdded(this);
    }
    return orElse();
  }
}

abstract class _PeerConnectionEventStreamAdded implements _PeerConnectionEvent {
  const factory _PeerConnectionEventStreamAdded(
          final String callId, final MediaStream stream) =
      _$PeerConnectionEventStreamAddedImpl;

  @override
  String get callId;
  MediaStream get stream;
}

/// @nodoc

class _$PeerConnectionEventStreamRemovedImpl
    with DiagnosticableTreeMixin
    implements _PeerConnectionEventStreamRemoved {
  const _$PeerConnectionEventStreamRemovedImpl(this.callId, this.stream);

  @override
  final String callId;
  @override
  final MediaStream stream;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_PeerConnectionEvent.streamRemoved(callId: $callId, stream: $stream)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', '_PeerConnectionEvent.streamRemoved'))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('stream', stream));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PeerConnectionEventStreamRemovedImpl &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.stream, stream) || other.stream == stream));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callId, stream);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String callId, RTCSignalingState state)
        signalingStateChanged,
    required TResult Function(String callId, RTCPeerConnectionState state)
        connectionStateChanged,
    required TResult Function(String callId, RTCIceGatheringState state)
        iceGatheringStateChanged,
    required TResult Function(String callId, RTCIceConnectionState state)
        iceConnectionStateChanged,
    required TResult Function(String callId, RTCIceCandidate candidate)
        iceCandidateIdentified,
    required TResult Function(String callId, MediaStream stream) streamAdded,
    required TResult Function(String callId, MediaStream stream) streamRemoved,
  }) {
    return streamRemoved(callId, stream);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String callId, RTCSignalingState state)?
        signalingStateChanged,
    TResult? Function(String callId, RTCPeerConnectionState state)?
        connectionStateChanged,
    TResult? Function(String callId, RTCIceGatheringState state)?
        iceGatheringStateChanged,
    TResult? Function(String callId, RTCIceConnectionState state)?
        iceConnectionStateChanged,
    TResult? Function(String callId, RTCIceCandidate candidate)?
        iceCandidateIdentified,
    TResult? Function(String callId, MediaStream stream)? streamAdded,
    TResult? Function(String callId, MediaStream stream)? streamRemoved,
  }) {
    return streamRemoved?.call(callId, stream);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String callId, RTCSignalingState state)?
        signalingStateChanged,
    TResult Function(String callId, RTCPeerConnectionState state)?
        connectionStateChanged,
    TResult Function(String callId, RTCIceGatheringState state)?
        iceGatheringStateChanged,
    TResult Function(String callId, RTCIceConnectionState state)?
        iceConnectionStateChanged,
    TResult Function(String callId, RTCIceCandidate candidate)?
        iceCandidateIdentified,
    TResult Function(String callId, MediaStream stream)? streamAdded,
    TResult Function(String callId, MediaStream stream)? streamRemoved,
    required TResult orElse(),
  }) {
    if (streamRemoved != null) {
      return streamRemoved(callId, stream);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_PeerConnectionEventSignalingStateChanged value)
        signalingStateChanged,
    required TResult Function(_PeerConnectionEventConnectionStateChanged value)
        connectionStateChanged,
    required TResult Function(
            _PeerConnectionEventIceGatheringStateChanged value)
        iceGatheringStateChanged,
    required TResult Function(
            _PeerConnectionEventIceConnectionStateChanged value)
        iceConnectionStateChanged,
    required TResult Function(_PeerConnectionEventIceCandidateIdentified value)
        iceCandidateIdentified,
    required TResult Function(_PeerConnectionEventStreamAdded value)
        streamAdded,
    required TResult Function(_PeerConnectionEventStreamRemoved value)
        streamRemoved,
  }) {
    return streamRemoved(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_PeerConnectionEventSignalingStateChanged value)?
        signalingStateChanged,
    TResult? Function(_PeerConnectionEventConnectionStateChanged value)?
        connectionStateChanged,
    TResult? Function(_PeerConnectionEventIceGatheringStateChanged value)?
        iceGatheringStateChanged,
    TResult? Function(_PeerConnectionEventIceConnectionStateChanged value)?
        iceConnectionStateChanged,
    TResult? Function(_PeerConnectionEventIceCandidateIdentified value)?
        iceCandidateIdentified,
    TResult? Function(_PeerConnectionEventStreamAdded value)? streamAdded,
    TResult? Function(_PeerConnectionEventStreamRemoved value)? streamRemoved,
  }) {
    return streamRemoved?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PeerConnectionEventSignalingStateChanged value)?
        signalingStateChanged,
    TResult Function(_PeerConnectionEventConnectionStateChanged value)?
        connectionStateChanged,
    TResult Function(_PeerConnectionEventIceGatheringStateChanged value)?
        iceGatheringStateChanged,
    TResult Function(_PeerConnectionEventIceConnectionStateChanged value)?
        iceConnectionStateChanged,
    TResult Function(_PeerConnectionEventIceCandidateIdentified value)?
        iceCandidateIdentified,
    TResult Function(_PeerConnectionEventStreamAdded value)? streamAdded,
    TResult Function(_PeerConnectionEventStreamRemoved value)? streamRemoved,
    required TResult orElse(),
  }) {
    if (streamRemoved != null) {
      return streamRemoved(this);
    }
    return orElse();
  }
}

abstract class _PeerConnectionEventStreamRemoved
    implements _PeerConnectionEvent {
  const factory _PeerConnectionEventStreamRemoved(
          final String callId, final MediaStream stream) =
      _$PeerConnectionEventStreamRemovedImpl;

  @override
  String get callId;
  MediaStream get stream;
}

/// @nodoc
mixin _$CallScreenEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() didPush,
    required TResult Function() didPop,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? didPush,
    TResult? Function()? didPop,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? didPush,
    TResult Function()? didPop,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CallScreenEventDidPush value) didPush,
    required TResult Function(_CallScreenEventDidPop value) didPop,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CallScreenEventDidPush value)? didPush,
    TResult? Function(_CallScreenEventDidPop value)? didPop,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CallScreenEventDidPush value)? didPush,
    TResult Function(_CallScreenEventDidPop value)? didPop,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc

class _$CallScreenEventDidPushImpl
    with DiagnosticableTreeMixin
    implements _CallScreenEventDidPush {
  _$CallScreenEventDidPushImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallScreenEvent.didPush()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'CallScreenEvent.didPush'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallScreenEventDidPushImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() didPush,
    required TResult Function() didPop,
  }) {
    return didPush();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? didPush,
    TResult? Function()? didPop,
  }) {
    return didPush?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? didPush,
    TResult Function()? didPop,
    required TResult orElse(),
  }) {
    if (didPush != null) {
      return didPush();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CallScreenEventDidPush value) didPush,
    required TResult Function(_CallScreenEventDidPop value) didPop,
  }) {
    return didPush(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CallScreenEventDidPush value)? didPush,
    TResult? Function(_CallScreenEventDidPop value)? didPop,
  }) {
    return didPush?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CallScreenEventDidPush value)? didPush,
    TResult Function(_CallScreenEventDidPop value)? didPop,
    required TResult orElse(),
  }) {
    if (didPush != null) {
      return didPush(this);
    }
    return orElse();
  }
}

abstract class _CallScreenEventDidPush implements CallScreenEvent {
  factory _CallScreenEventDidPush() = _$CallScreenEventDidPushImpl;
}

/// @nodoc

class _$CallScreenEventDidPopImpl
    with DiagnosticableTreeMixin
    implements _CallScreenEventDidPop {
  _$CallScreenEventDidPopImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallScreenEvent.didPop()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'CallScreenEvent.didPop'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallScreenEventDidPopImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() didPush,
    required TResult Function() didPop,
  }) {
    return didPop();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? didPush,
    TResult? Function()? didPop,
  }) {
    return didPop?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? didPush,
    TResult Function()? didPop,
    required TResult orElse(),
  }) {
    if (didPop != null) {
      return didPop();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CallScreenEventDidPush value) didPush,
    required TResult Function(_CallScreenEventDidPop value) didPop,
  }) {
    return didPop(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CallScreenEventDidPush value)? didPush,
    TResult? Function(_CallScreenEventDidPop value)? didPop,
  }) {
    return didPop?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CallScreenEventDidPush value)? didPush,
    TResult Function(_CallScreenEventDidPop value)? didPop,
    required TResult orElse(),
  }) {
    if (didPop != null) {
      return didPop(this);
    }
    return orElse();
  }
}

abstract class _CallScreenEventDidPop implements CallScreenEvent {
  factory _CallScreenEventDidPop() = _$CallScreenEventDidPopImpl;
}

/// @nodoc
mixin _$CallState {
  ConnectivityResult? get currentConnectivityResult =>
      throw _privateConstructorUsedError;
  SignalingClientStatus get signalingClientStatus =>
      throw _privateConstructorUsedError;
  Object? get lastSignalingClientConnectError =>
      throw _privateConstructorUsedError;
  Object? get lastSignalingClientDisconnectError =>
      throw _privateConstructorUsedError;
  int? get lastSignalingDisconnectCode => throw _privateConstructorUsedError;
  int get linesCount => throw _privateConstructorUsedError;
  List<ActiveCall> get activeCalls => throw _privateConstructorUsedError;
  bool? get minimized => throw _privateConstructorUsedError;
  bool? get speaker => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CallStateCopyWith<CallState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CallStateCopyWith<$Res> {
  factory $CallStateCopyWith(CallState value, $Res Function(CallState) then) =
      _$CallStateCopyWithImpl<$Res, CallState>;
  @useResult
  $Res call(
      {ConnectivityResult? currentConnectivityResult,
      SignalingClientStatus signalingClientStatus,
      Object? lastSignalingClientConnectError,
      Object? lastSignalingClientDisconnectError,
      int? lastSignalingDisconnectCode,
      int linesCount,
      List<ActiveCall> activeCalls,
      bool? minimized,
      bool? speaker});
}

/// @nodoc
class _$CallStateCopyWithImpl<$Res, $Val extends CallState>
    implements $CallStateCopyWith<$Res> {
  _$CallStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentConnectivityResult = freezed,
    Object? signalingClientStatus = null,
    Object? lastSignalingClientConnectError = freezed,
    Object? lastSignalingClientDisconnectError = freezed,
    Object? lastSignalingDisconnectCode = freezed,
    Object? linesCount = null,
    Object? activeCalls = null,
    Object? minimized = freezed,
    Object? speaker = freezed,
  }) {
    return _then(_value.copyWith(
      currentConnectivityResult: freezed == currentConnectivityResult
          ? _value.currentConnectivityResult
          : currentConnectivityResult // ignore: cast_nullable_to_non_nullable
              as ConnectivityResult?,
      signalingClientStatus: null == signalingClientStatus
          ? _value.signalingClientStatus
          : signalingClientStatus // ignore: cast_nullable_to_non_nullable
              as SignalingClientStatus,
      lastSignalingClientConnectError:
          freezed == lastSignalingClientConnectError
              ? _value.lastSignalingClientConnectError
              : lastSignalingClientConnectError,
      lastSignalingClientDisconnectError:
          freezed == lastSignalingClientDisconnectError
              ? _value.lastSignalingClientDisconnectError
              : lastSignalingClientDisconnectError,
      lastSignalingDisconnectCode: freezed == lastSignalingDisconnectCode
          ? _value.lastSignalingDisconnectCode
          : lastSignalingDisconnectCode // ignore: cast_nullable_to_non_nullable
              as int?,
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
      speaker: freezed == speaker
          ? _value.speaker
          : speaker // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
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
      {ConnectivityResult? currentConnectivityResult,
      SignalingClientStatus signalingClientStatus,
      Object? lastSignalingClientConnectError,
      Object? lastSignalingClientDisconnectError,
      int? lastSignalingDisconnectCode,
      int linesCount,
      List<ActiveCall> activeCalls,
      bool? minimized,
      bool? speaker});
}

/// @nodoc
class __$$CallStateImplCopyWithImpl<$Res>
    extends _$CallStateCopyWithImpl<$Res, _$CallStateImpl>
    implements _$$CallStateImplCopyWith<$Res> {
  __$$CallStateImplCopyWithImpl(
      _$CallStateImpl _value, $Res Function(_$CallStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentConnectivityResult = freezed,
    Object? signalingClientStatus = null,
    Object? lastSignalingClientConnectError = freezed,
    Object? lastSignalingClientDisconnectError = freezed,
    Object? lastSignalingDisconnectCode = freezed,
    Object? linesCount = null,
    Object? activeCalls = null,
    Object? minimized = freezed,
    Object? speaker = freezed,
  }) {
    return _then(_$CallStateImpl(
      currentConnectivityResult: freezed == currentConnectivityResult
          ? _value.currentConnectivityResult
          : currentConnectivityResult // ignore: cast_nullable_to_non_nullable
              as ConnectivityResult?,
      signalingClientStatus: null == signalingClientStatus
          ? _value.signalingClientStatus
          : signalingClientStatus // ignore: cast_nullable_to_non_nullable
              as SignalingClientStatus,
      lastSignalingClientConnectError:
          freezed == lastSignalingClientConnectError
              ? _value.lastSignalingClientConnectError
              : lastSignalingClientConnectError,
      lastSignalingClientDisconnectError:
          freezed == lastSignalingClientDisconnectError
              ? _value.lastSignalingClientDisconnectError
              : lastSignalingClientDisconnectError,
      lastSignalingDisconnectCode: freezed == lastSignalingDisconnectCode
          ? _value.lastSignalingDisconnectCode
          : lastSignalingDisconnectCode // ignore: cast_nullable_to_non_nullable
              as int?,
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
      speaker: freezed == speaker
          ? _value.speaker
          : speaker // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

class _$CallStateImpl extends _CallState with DiagnosticableTreeMixin {
  const _$CallStateImpl(
      {this.currentConnectivityResult,
      this.signalingClientStatus = SignalingClientStatus.disconnect,
      this.lastSignalingClientConnectError,
      this.lastSignalingClientDisconnectError,
      this.lastSignalingDisconnectCode,
      this.linesCount = 0,
      final List<ActiveCall> activeCalls = const [],
      this.minimized,
      this.speaker})
      : _activeCalls = activeCalls,
        super._();

  @override
  final ConnectivityResult? currentConnectivityResult;
  @override
  @JsonKey()
  final SignalingClientStatus signalingClientStatus;
  @override
  final Object? lastSignalingClientConnectError;
  @override
  final Object? lastSignalingClientDisconnectError;
  @override
  final int? lastSignalingDisconnectCode;
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
  final bool? speaker;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallState(currentConnectivityResult: $currentConnectivityResult, signalingClientStatus: $signalingClientStatus, lastSignalingClientConnectError: $lastSignalingClientConnectError, lastSignalingClientDisconnectError: $lastSignalingClientDisconnectError, lastSignalingDisconnectCode: $lastSignalingDisconnectCode, linesCount: $linesCount, activeCalls: $activeCalls, minimized: $minimized, speaker: $speaker)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CallState'))
      ..add(DiagnosticsProperty(
          'currentConnectivityResult', currentConnectivityResult))
      ..add(DiagnosticsProperty('signalingClientStatus', signalingClientStatus))
      ..add(DiagnosticsProperty(
          'lastSignalingClientConnectError', lastSignalingClientConnectError))
      ..add(DiagnosticsProperty('lastSignalingClientDisconnectError',
          lastSignalingClientDisconnectError))
      ..add(DiagnosticsProperty(
          'lastSignalingDisconnectCode', lastSignalingDisconnectCode))
      ..add(DiagnosticsProperty('linesCount', linesCount))
      ..add(DiagnosticsProperty('activeCalls', activeCalls))
      ..add(DiagnosticsProperty('minimized', minimized))
      ..add(DiagnosticsProperty('speaker', speaker));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallStateImpl &&
            (identical(other.currentConnectivityResult,
                    currentConnectivityResult) ||
                other.currentConnectivityResult == currentConnectivityResult) &&
            (identical(other.signalingClientStatus, signalingClientStatus) ||
                other.signalingClientStatus == signalingClientStatus) &&
            const DeepCollectionEquality().equals(
                other.lastSignalingClientConnectError,
                lastSignalingClientConnectError) &&
            const DeepCollectionEquality().equals(
                other.lastSignalingClientDisconnectError,
                lastSignalingClientDisconnectError) &&
            (identical(other.lastSignalingDisconnectCode,
                    lastSignalingDisconnectCode) ||
                other.lastSignalingDisconnectCode ==
                    lastSignalingDisconnectCode) &&
            (identical(other.linesCount, linesCount) ||
                other.linesCount == linesCount) &&
            const DeepCollectionEquality()
                .equals(other._activeCalls, _activeCalls) &&
            (identical(other.minimized, minimized) ||
                other.minimized == minimized) &&
            (identical(other.speaker, speaker) || other.speaker == speaker));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      currentConnectivityResult,
      signalingClientStatus,
      const DeepCollectionEquality().hash(lastSignalingClientConnectError),
      const DeepCollectionEquality().hash(lastSignalingClientDisconnectError),
      lastSignalingDisconnectCode,
      linesCount,
      const DeepCollectionEquality().hash(_activeCalls),
      minimized,
      speaker);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CallStateImplCopyWith<_$CallStateImpl> get copyWith =>
      __$$CallStateImplCopyWithImpl<_$CallStateImpl>(this, _$identity);
}

abstract class _CallState extends CallState {
  const factory _CallState(
      {final ConnectivityResult? currentConnectivityResult,
      final SignalingClientStatus signalingClientStatus,
      final Object? lastSignalingClientConnectError,
      final Object? lastSignalingClientDisconnectError,
      final int? lastSignalingDisconnectCode,
      final int linesCount,
      final List<ActiveCall> activeCalls,
      final bool? minimized,
      final bool? speaker}) = _$CallStateImpl;
  const _CallState._() : super._();

  @override
  ConnectivityResult? get currentConnectivityResult;
  @override
  SignalingClientStatus get signalingClientStatus;
  @override
  Object? get lastSignalingClientConnectError;
  @override
  Object? get lastSignalingClientDisconnectError;
  @override
  int? get lastSignalingDisconnectCode;
  @override
  int get linesCount;
  @override
  List<ActiveCall> get activeCalls;
  @override
  bool? get minimized;
  @override
  bool? get speaker;
  @override
  @JsonKey(ignore: true)
  _$$CallStateImplCopyWith<_$CallStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ActiveCall {
  Direction get direction => throw _privateConstructorUsedError;
  int get line => throw _privateConstructorUsedError;
  String get callId => throw _privateConstructorUsedError;
  CallkeepHandle get handle => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  bool get video => throw _privateConstructorUsedError;
  bool? get frontCamera => throw _privateConstructorUsedError;
  bool get held => throw _privateConstructorUsedError;
  bool get muted => throw _privateConstructorUsedError;
  bool get updating => throw _privateConstructorUsedError;
  DateTime get createdTime => throw _privateConstructorUsedError;
  DateTime? get acceptedTime => throw _privateConstructorUsedError;
  DateTime? get hungUpTime => throw _privateConstructorUsedError;
  Object? get failure => throw _privateConstructorUsedError;
  RTCVideoRenderers get renderers => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
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
      {Direction direction,
      int line,
      String callId,
      CallkeepHandle handle,
      String? displayName,
      bool video,
      bool? frontCamera,
      bool held,
      bool muted,
      bool updating,
      DateTime createdTime,
      DateTime? acceptedTime,
      DateTime? hungUpTime,
      Object? failure,
      RTCVideoRenderers renderers});
}

/// @nodoc
class _$ActiveCallCopyWithImpl<$Res, $Val extends ActiveCall>
    implements $ActiveCallCopyWith<$Res> {
  _$ActiveCallCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? direction = null,
    Object? line = null,
    Object? callId = null,
    Object? handle = null,
    Object? displayName = freezed,
    Object? video = null,
    Object? frontCamera = freezed,
    Object? held = null,
    Object? muted = null,
    Object? updating = null,
    Object? createdTime = null,
    Object? acceptedTime = freezed,
    Object? hungUpTime = freezed,
    Object? failure = freezed,
    Object? renderers = null,
  }) {
    return _then(_value.copyWith(
      direction: null == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as Direction,
      line: null == line
          ? _value.line
          : line // ignore: cast_nullable_to_non_nullable
              as int,
      callId: null == callId
          ? _value.callId
          : callId // ignore: cast_nullable_to_non_nullable
              as String,
      handle: null == handle
          ? _value.handle
          : handle // ignore: cast_nullable_to_non_nullable
              as CallkeepHandle,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      video: null == video
          ? _value.video
          : video // ignore: cast_nullable_to_non_nullable
              as bool,
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
      createdTime: null == createdTime
          ? _value.createdTime
          : createdTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      acceptedTime: freezed == acceptedTime
          ? _value.acceptedTime
          : acceptedTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      hungUpTime: freezed == hungUpTime
          ? _value.hungUpTime
          : hungUpTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      failure: freezed == failure ? _value.failure : failure,
      renderers: null == renderers
          ? _value.renderers
          : renderers // ignore: cast_nullable_to_non_nullable
              as RTCVideoRenderers,
    ) as $Val);
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
      {Direction direction,
      int line,
      String callId,
      CallkeepHandle handle,
      String? displayName,
      bool video,
      bool? frontCamera,
      bool held,
      bool muted,
      bool updating,
      DateTime createdTime,
      DateTime? acceptedTime,
      DateTime? hungUpTime,
      Object? failure,
      RTCVideoRenderers renderers});
}

/// @nodoc
class __$$ActiveCallImplCopyWithImpl<$Res>
    extends _$ActiveCallCopyWithImpl<$Res, _$ActiveCallImpl>
    implements _$$ActiveCallImplCopyWith<$Res> {
  __$$ActiveCallImplCopyWithImpl(
      _$ActiveCallImpl _value, $Res Function(_$ActiveCallImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? direction = null,
    Object? line = null,
    Object? callId = null,
    Object? handle = null,
    Object? displayName = freezed,
    Object? video = null,
    Object? frontCamera = freezed,
    Object? held = null,
    Object? muted = null,
    Object? updating = null,
    Object? createdTime = null,
    Object? acceptedTime = freezed,
    Object? hungUpTime = freezed,
    Object? failure = freezed,
    Object? renderers = null,
  }) {
    return _then(_$ActiveCallImpl(
      direction: null == direction
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as Direction,
      line: null == line
          ? _value.line
          : line // ignore: cast_nullable_to_non_nullable
              as int,
      callId: null == callId
          ? _value.callId
          : callId // ignore: cast_nullable_to_non_nullable
              as String,
      handle: null == handle
          ? _value.handle
          : handle // ignore: cast_nullable_to_non_nullable
              as CallkeepHandle,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      video: null == video
          ? _value.video
          : video // ignore: cast_nullable_to_non_nullable
              as bool,
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
      createdTime: null == createdTime
          ? _value.createdTime
          : createdTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      acceptedTime: freezed == acceptedTime
          ? _value.acceptedTime
          : acceptedTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      hungUpTime: freezed == hungUpTime
          ? _value.hungUpTime
          : hungUpTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      failure: freezed == failure ? _value.failure : failure,
      renderers: null == renderers
          ? _value.renderers
          : renderers // ignore: cast_nullable_to_non_nullable
              as RTCVideoRenderers,
    ));
  }
}

/// @nodoc

class _$ActiveCallImpl extends _ActiveCall with DiagnosticableTreeMixin {
  _$ActiveCallImpl(
      {required this.direction,
      required this.line,
      required this.callId,
      required this.handle,
      this.displayName,
      required this.video,
      this.frontCamera = true,
      this.held = false,
      this.muted = false,
      this.updating = false,
      required this.createdTime,
      this.acceptedTime,
      this.hungUpTime,
      this.failure,
      required this.renderers})
      : super._();

  @override
  final Direction direction;
  @override
  final int line;
  @override
  final String callId;
  @override
  final CallkeepHandle handle;
  @override
  final String? displayName;
  @override
  final bool video;
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
  final DateTime createdTime;
  @override
  final DateTime? acceptedTime;
  @override
  final DateTime? hungUpTime;
  @override
  final Object? failure;
  @override
  final RTCVideoRenderers renderers;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ActiveCall(direction: $direction, line: $line, callId: $callId, handle: $handle, displayName: $displayName, video: $video, frontCamera: $frontCamera, held: $held, muted: $muted, updating: $updating, createdTime: $createdTime, acceptedTime: $acceptedTime, hungUpTime: $hungUpTime, failure: $failure, renderers: $renderers)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ActiveCall'))
      ..add(DiagnosticsProperty('direction', direction))
      ..add(DiagnosticsProperty('line', line))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('handle', handle))
      ..add(DiagnosticsProperty('displayName', displayName))
      ..add(DiagnosticsProperty('video', video))
      ..add(DiagnosticsProperty('frontCamera', frontCamera))
      ..add(DiagnosticsProperty('held', held))
      ..add(DiagnosticsProperty('muted', muted))
      ..add(DiagnosticsProperty('updating', updating))
      ..add(DiagnosticsProperty('createdTime', createdTime))
      ..add(DiagnosticsProperty('acceptedTime', acceptedTime))
      ..add(DiagnosticsProperty('hungUpTime', hungUpTime))
      ..add(DiagnosticsProperty('failure', failure))
      ..add(DiagnosticsProperty('renderers', renderers));
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
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.video, video) || other.video == video) &&
            (identical(other.frontCamera, frontCamera) ||
                other.frontCamera == frontCamera) &&
            (identical(other.held, held) || other.held == held) &&
            (identical(other.muted, muted) || other.muted == muted) &&
            (identical(other.updating, updating) ||
                other.updating == updating) &&
            (identical(other.createdTime, createdTime) ||
                other.createdTime == createdTime) &&
            (identical(other.acceptedTime, acceptedTime) ||
                other.acceptedTime == acceptedTime) &&
            (identical(other.hungUpTime, hungUpTime) ||
                other.hungUpTime == hungUpTime) &&
            const DeepCollectionEquality().equals(other.failure, failure) &&
            (identical(other.renderers, renderers) ||
                other.renderers == renderers));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      direction,
      line,
      callId,
      handle,
      displayName,
      video,
      frontCamera,
      held,
      muted,
      updating,
      createdTime,
      acceptedTime,
      hungUpTime,
      const DeepCollectionEquality().hash(failure),
      renderers);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ActiveCallImplCopyWith<_$ActiveCallImpl> get copyWith =>
      __$$ActiveCallImplCopyWithImpl<_$ActiveCallImpl>(this, _$identity);
}

abstract class _ActiveCall extends ActiveCall {
  factory _ActiveCall(
      {required final Direction direction,
      required final int line,
      required final String callId,
      required final CallkeepHandle handle,
      final String? displayName,
      required final bool video,
      final bool? frontCamera,
      final bool held,
      final bool muted,
      final bool updating,
      required final DateTime createdTime,
      final DateTime? acceptedTime,
      final DateTime? hungUpTime,
      final Object? failure,
      required final RTCVideoRenderers renderers}) = _$ActiveCallImpl;
  _ActiveCall._() : super._();

  @override
  Direction get direction;
  @override
  int get line;
  @override
  String get callId;
  @override
  CallkeepHandle get handle;
  @override
  String? get displayName;
  @override
  bool get video;
  @override
  bool? get frontCamera;
  @override
  bool get held;
  @override
  bool get muted;
  @override
  bool get updating;
  @override
  DateTime get createdTime;
  @override
  DateTime? get acceptedTime;
  @override
  DateTime? get hungUpTime;
  @override
  Object? get failure;
  @override
  RTCVideoRenderers get renderers;
  @override
  @JsonKey(ignore: true)
  _$$ActiveCallImplCopyWith<_$ActiveCallImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
