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
mixin _$_AppLifecycleStateChanged {
  AppLifecycleState get state => throw _privateConstructorUsedError;
}

/// @nodoc

class _$__AppLifecycleStateChanged
    with DiagnosticableTreeMixin
    implements __AppLifecycleStateChanged {
  const _$__AppLifecycleStateChanged(this.state);

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$__AppLifecycleStateChanged &&
            (identical(other.state, state) || other.state == state));
  }

  @override
  int get hashCode => Object.hash(runtimeType, state);
}

abstract class __AppLifecycleStateChanged implements _AppLifecycleStateChanged {
  const factory __AppLifecycleStateChanged(final AppLifecycleState state) =
      _$__AppLifecycleStateChanged;

  @override
  AppLifecycleState get state;
}

/// @nodoc
mixin _$_ConnectivityResultChanged {
  ConnectivityResult get result => throw _privateConstructorUsedError;
}

/// @nodoc

class _$__ConnectivityResultChanged
    with DiagnosticableTreeMixin
    implements __ConnectivityResultChanged {
  const _$__ConnectivityResultChanged(this.result);

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$__ConnectivityResultChanged &&
            (identical(other.result, result) || other.result == result));
  }

  @override
  int get hashCode => Object.hash(runtimeType, result);
}

abstract class __ConnectivityResultChanged
    implements _ConnectivityResultChanged {
  const factory __ConnectivityResultChanged(final ConnectivityResult result) =
      _$__ConnectivityResultChanged;

  @override
  ConnectivityResult get result;
}

/// @nodoc
mixin _$_AudioSessionRouteChanged {}

/// @nodoc

class _$__AudioSessionRouteChanged
    with DiagnosticableTreeMixin
    implements __AudioSessionRouteChanged {
  const _$__AudioSessionRouteChanged();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_AudioSessionRouteChanged()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', '_AudioSessionRouteChanged'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$__AudioSessionRouteChanged);
  }

  @override
  int get hashCode => runtimeType.hashCode;
}

abstract class __AudioSessionRouteChanged implements _AudioSessionRouteChanged {
  const factory __AudioSessionRouteChanged() = _$__AudioSessionRouteChanged;
}

/// @nodoc
mixin _$_SignalingClientEvent {
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

class _$_SignalingClientEventConnectInitiated
    with DiagnosticableTreeMixin
    implements _SignalingClientEventConnectInitiated {
  const _$_SignalingClientEventConnectInitiated();

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SignalingClientEventConnectInitiated);
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
      _$_SignalingClientEventConnectInitiated;
}

/// @nodoc

class _$_SignalingClientEventDisconnectInitiated
    with DiagnosticableTreeMixin
    implements _SignalingClientEventDisconnectInitiated {
  const _$_SignalingClientEventDisconnectInitiated();

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SignalingClientEventDisconnectInitiated);
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
      _$_SignalingClientEventDisconnectInitiated;
}

/// @nodoc

class _$_SignalingClientEventDisconnected
    with DiagnosticableTreeMixin
    implements _SignalingClientEventDisconnected {
  const _$_SignalingClientEventDisconnected(this.code, this.reason);

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SignalingClientEventDisconnected &&
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
      _$_SignalingClientEventDisconnected;

  int? get code;
  String? get reason;
}

/// @nodoc
mixin _$_HandshakeSignalingEvent {
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

class _$_HandshakeSignalingEventState
    with DiagnosticableTreeMixin
    implements _HandshakeSignalingEventState {
  const _$_HandshakeSignalingEventState({required this.linesCount});

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HandshakeSignalingEventState &&
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
      _$_HandshakeSignalingEventState;

  @override
  int get linesCount;
}

/// @nodoc
mixin _$_CallSignalingEvent {
  int get line => throw _privateConstructorUsedError;
  CallIdValue get callId => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int line, CallIdValue callId, String callee,
            String caller, String? callerDisplayName, JsepValue? jsep)
        incoming,
    required TResult Function(int line, CallIdValue callId) ringing,
    required TResult Function(
            int line, CallIdValue callId, String callee, JsepValue? jsep)
        progress,
    required TResult Function(
            int line, CallIdValue callId, String? callee, JsepValue? jsep)
        accepted,
    required TResult Function(
            int line, CallIdValue callId, int code, String reason)
        hangup,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int line, CallIdValue callId, String callee,
            String caller, String? callerDisplayName, JsepValue? jsep)?
        incoming,
    TResult? Function(int line, CallIdValue callId)? ringing,
    TResult? Function(
            int line, CallIdValue callId, String callee, JsepValue? jsep)?
        progress,
    TResult? Function(
            int line, CallIdValue callId, String? callee, JsepValue? jsep)?
        accepted,
    TResult? Function(int line, CallIdValue callId, int code, String reason)?
        hangup,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int line, CallIdValue callId, String callee, String caller,
            String? callerDisplayName, JsepValue? jsep)?
        incoming,
    TResult Function(int line, CallIdValue callId)? ringing,
    TResult Function(
            int line, CallIdValue callId, String callee, JsepValue? jsep)?
        progress,
    TResult Function(
            int line, CallIdValue callId, String? callee, JsepValue? jsep)?
        accepted,
    TResult Function(int line, CallIdValue callId, int code, String reason)?
        hangup,
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
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_CallSignalingEventIncoming value)? incoming,
    TResult? Function(_CallSignalingEventRinging value)? ringing,
    TResult? Function(_CallSignalingEventProgress value)? progress,
    TResult? Function(_CallSignalingEventAccepted value)? accepted,
    TResult? Function(_CallSignalingEventHangup value)? hangup,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CallSignalingEventIncoming value)? incoming,
    TResult Function(_CallSignalingEventRinging value)? ringing,
    TResult Function(_CallSignalingEventProgress value)? progress,
    TResult Function(_CallSignalingEventAccepted value)? accepted,
    TResult Function(_CallSignalingEventHangup value)? hangup,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc

class _$_CallSignalingEventIncoming
    with DiagnosticableTreeMixin
    implements _CallSignalingEventIncoming {
  const _$_CallSignalingEventIncoming(
      {required this.line,
      required this.callId,
      required this.callee,
      required this.caller,
      this.callerDisplayName,
      this.jsep});

  @override
  final int line;
  @override
  final CallIdValue callId;
  @override
  final String callee;
  @override
  final String caller;
  @override
  final String? callerDisplayName;
  @override
  final JsepValue? jsep;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallSignalingEvent.incoming(line: $line, callId: $callId, callee: $callee, caller: $caller, callerDisplayName: $callerDisplayName, jsep: $jsep)';
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
      ..add(DiagnosticsProperty('jsep', jsep));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CallSignalingEventIncoming &&
            (identical(other.line, line) || other.line == line) &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.callee, callee) || other.callee == callee) &&
            (identical(other.caller, caller) || other.caller == caller) &&
            (identical(other.callerDisplayName, callerDisplayName) ||
                other.callerDisplayName == callerDisplayName) &&
            (identical(other.jsep, jsep) || other.jsep == jsep));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, line, callId, callee, caller, callerDisplayName, jsep);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int line, CallIdValue callId, String callee,
            String caller, String? callerDisplayName, JsepValue? jsep)
        incoming,
    required TResult Function(int line, CallIdValue callId) ringing,
    required TResult Function(
            int line, CallIdValue callId, String callee, JsepValue? jsep)
        progress,
    required TResult Function(
            int line, CallIdValue callId, String? callee, JsepValue? jsep)
        accepted,
    required TResult Function(
            int line, CallIdValue callId, int code, String reason)
        hangup,
  }) {
    return incoming(line, callId, callee, caller, callerDisplayName, jsep);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int line, CallIdValue callId, String callee,
            String caller, String? callerDisplayName, JsepValue? jsep)?
        incoming,
    TResult? Function(int line, CallIdValue callId)? ringing,
    TResult? Function(
            int line, CallIdValue callId, String callee, JsepValue? jsep)?
        progress,
    TResult? Function(
            int line, CallIdValue callId, String? callee, JsepValue? jsep)?
        accepted,
    TResult? Function(int line, CallIdValue callId, int code, String reason)?
        hangup,
  }) {
    return incoming?.call(
        line, callId, callee, caller, callerDisplayName, jsep);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int line, CallIdValue callId, String callee, String caller,
            String? callerDisplayName, JsepValue? jsep)?
        incoming,
    TResult Function(int line, CallIdValue callId)? ringing,
    TResult Function(
            int line, CallIdValue callId, String callee, JsepValue? jsep)?
        progress,
    TResult Function(
            int line, CallIdValue callId, String? callee, JsepValue? jsep)?
        accepted,
    TResult Function(int line, CallIdValue callId, int code, String reason)?
        hangup,
    required TResult orElse(),
  }) {
    if (incoming != null) {
      return incoming(line, callId, callee, caller, callerDisplayName, jsep);
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
      required final CallIdValue callId,
      required final String callee,
      required final String caller,
      final String? callerDisplayName,
      final JsepValue? jsep}) = _$_CallSignalingEventIncoming;

  @override
  int get line;
  @override
  CallIdValue get callId;
  String get callee;
  String get caller;
  String? get callerDisplayName;
  JsepValue? get jsep;
}

/// @nodoc

class _$_CallSignalingEventRinging
    with DiagnosticableTreeMixin
    implements _CallSignalingEventRinging {
  const _$_CallSignalingEventRinging(
      {required this.line, required this.callId});

  @override
  final int line;
  @override
  final CallIdValue callId;

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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CallSignalingEventRinging &&
            (identical(other.line, line) || other.line == line) &&
            (identical(other.callId, callId) || other.callId == callId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, line, callId);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int line, CallIdValue callId, String callee,
            String caller, String? callerDisplayName, JsepValue? jsep)
        incoming,
    required TResult Function(int line, CallIdValue callId) ringing,
    required TResult Function(
            int line, CallIdValue callId, String callee, JsepValue? jsep)
        progress,
    required TResult Function(
            int line, CallIdValue callId, String? callee, JsepValue? jsep)
        accepted,
    required TResult Function(
            int line, CallIdValue callId, int code, String reason)
        hangup,
  }) {
    return ringing(line, callId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int line, CallIdValue callId, String callee,
            String caller, String? callerDisplayName, JsepValue? jsep)?
        incoming,
    TResult? Function(int line, CallIdValue callId)? ringing,
    TResult? Function(
            int line, CallIdValue callId, String callee, JsepValue? jsep)?
        progress,
    TResult? Function(
            int line, CallIdValue callId, String? callee, JsepValue? jsep)?
        accepted,
    TResult? Function(int line, CallIdValue callId, int code, String reason)?
        hangup,
  }) {
    return ringing?.call(line, callId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int line, CallIdValue callId, String callee, String caller,
            String? callerDisplayName, JsepValue? jsep)?
        incoming,
    TResult Function(int line, CallIdValue callId)? ringing,
    TResult Function(
            int line, CallIdValue callId, String callee, JsepValue? jsep)?
        progress,
    TResult Function(
            int line, CallIdValue callId, String? callee, JsepValue? jsep)?
        accepted,
    TResult Function(int line, CallIdValue callId, int code, String reason)?
        hangup,
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
      required final CallIdValue callId}) = _$_CallSignalingEventRinging;

  @override
  int get line;
  @override
  CallIdValue get callId;
}

/// @nodoc

class _$_CallSignalingEventProgress
    with DiagnosticableTreeMixin
    implements _CallSignalingEventProgress {
  const _$_CallSignalingEventProgress(
      {required this.line,
      required this.callId,
      required this.callee,
      this.jsep});

  @override
  final int line;
  @override
  final CallIdValue callId;
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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CallSignalingEventProgress &&
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
    required TResult Function(int line, CallIdValue callId, String callee,
            String caller, String? callerDisplayName, JsepValue? jsep)
        incoming,
    required TResult Function(int line, CallIdValue callId) ringing,
    required TResult Function(
            int line, CallIdValue callId, String callee, JsepValue? jsep)
        progress,
    required TResult Function(
            int line, CallIdValue callId, String? callee, JsepValue? jsep)
        accepted,
    required TResult Function(
            int line, CallIdValue callId, int code, String reason)
        hangup,
  }) {
    return progress(line, callId, callee, jsep);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int line, CallIdValue callId, String callee,
            String caller, String? callerDisplayName, JsepValue? jsep)?
        incoming,
    TResult? Function(int line, CallIdValue callId)? ringing,
    TResult? Function(
            int line, CallIdValue callId, String callee, JsepValue? jsep)?
        progress,
    TResult? Function(
            int line, CallIdValue callId, String? callee, JsepValue? jsep)?
        accepted,
    TResult? Function(int line, CallIdValue callId, int code, String reason)?
        hangup,
  }) {
    return progress?.call(line, callId, callee, jsep);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int line, CallIdValue callId, String callee, String caller,
            String? callerDisplayName, JsepValue? jsep)?
        incoming,
    TResult Function(int line, CallIdValue callId)? ringing,
    TResult Function(
            int line, CallIdValue callId, String callee, JsepValue? jsep)?
        progress,
    TResult Function(
            int line, CallIdValue callId, String? callee, JsepValue? jsep)?
        accepted,
    TResult Function(int line, CallIdValue callId, int code, String reason)?
        hangup,
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
      required final CallIdValue callId,
      required final String callee,
      final JsepValue? jsep}) = _$_CallSignalingEventProgress;

  @override
  int get line;
  @override
  CallIdValue get callId;
  String get callee;
  JsepValue? get jsep;
}

/// @nodoc

class _$_CallSignalingEventAccepted
    with DiagnosticableTreeMixin
    implements _CallSignalingEventAccepted {
  const _$_CallSignalingEventAccepted(
      {required this.line, required this.callId, this.callee, this.jsep});

  @override
  final int line;
  @override
  final CallIdValue callId;
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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CallSignalingEventAccepted &&
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
    required TResult Function(int line, CallIdValue callId, String callee,
            String caller, String? callerDisplayName, JsepValue? jsep)
        incoming,
    required TResult Function(int line, CallIdValue callId) ringing,
    required TResult Function(
            int line, CallIdValue callId, String callee, JsepValue? jsep)
        progress,
    required TResult Function(
            int line, CallIdValue callId, String? callee, JsepValue? jsep)
        accepted,
    required TResult Function(
            int line, CallIdValue callId, int code, String reason)
        hangup,
  }) {
    return accepted(line, callId, callee, jsep);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int line, CallIdValue callId, String callee,
            String caller, String? callerDisplayName, JsepValue? jsep)?
        incoming,
    TResult? Function(int line, CallIdValue callId)? ringing,
    TResult? Function(
            int line, CallIdValue callId, String callee, JsepValue? jsep)?
        progress,
    TResult? Function(
            int line, CallIdValue callId, String? callee, JsepValue? jsep)?
        accepted,
    TResult? Function(int line, CallIdValue callId, int code, String reason)?
        hangup,
  }) {
    return accepted?.call(line, callId, callee, jsep);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int line, CallIdValue callId, String callee, String caller,
            String? callerDisplayName, JsepValue? jsep)?
        incoming,
    TResult Function(int line, CallIdValue callId)? ringing,
    TResult Function(
            int line, CallIdValue callId, String callee, JsepValue? jsep)?
        progress,
    TResult Function(
            int line, CallIdValue callId, String? callee, JsepValue? jsep)?
        accepted,
    TResult Function(int line, CallIdValue callId, int code, String reason)?
        hangup,
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
      required final CallIdValue callId,
      final String? callee,
      final JsepValue? jsep}) = _$_CallSignalingEventAccepted;

  @override
  int get line;
  @override
  CallIdValue get callId;
  String? get callee;
  JsepValue? get jsep;
}

/// @nodoc

class _$_CallSignalingEventHangup
    with DiagnosticableTreeMixin
    implements _CallSignalingEventHangup {
  const _$_CallSignalingEventHangup(
      {required this.line,
      required this.callId,
      required this.code,
      required this.reason});

  @override
  final int line;
  @override
  final CallIdValue callId;
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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CallSignalingEventHangup &&
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
    required TResult Function(int line, CallIdValue callId, String callee,
            String caller, String? callerDisplayName, JsepValue? jsep)
        incoming,
    required TResult Function(int line, CallIdValue callId) ringing,
    required TResult Function(
            int line, CallIdValue callId, String callee, JsepValue? jsep)
        progress,
    required TResult Function(
            int line, CallIdValue callId, String? callee, JsepValue? jsep)
        accepted,
    required TResult Function(
            int line, CallIdValue callId, int code, String reason)
        hangup,
  }) {
    return hangup(line, callId, code, reason);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int line, CallIdValue callId, String callee,
            String caller, String? callerDisplayName, JsepValue? jsep)?
        incoming,
    TResult? Function(int line, CallIdValue callId)? ringing,
    TResult? Function(
            int line, CallIdValue callId, String callee, JsepValue? jsep)?
        progress,
    TResult? Function(
            int line, CallIdValue callId, String? callee, JsepValue? jsep)?
        accepted,
    TResult? Function(int line, CallIdValue callId, int code, String reason)?
        hangup,
  }) {
    return hangup?.call(line, callId, code, reason);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int line, CallIdValue callId, String callee, String caller,
            String? callerDisplayName, JsepValue? jsep)?
        incoming,
    TResult Function(int line, CallIdValue callId)? ringing,
    TResult Function(
            int line, CallIdValue callId, String callee, JsepValue? jsep)?
        progress,
    TResult Function(
            int line, CallIdValue callId, String? callee, JsepValue? jsep)?
        accepted,
    TResult Function(int line, CallIdValue callId, int code, String reason)?
        hangup,
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
      required final CallIdValue callId,
      required final int code,
      required final String reason}) = _$_CallSignalingEventHangup;

  @override
  int get line;
  @override
  CallIdValue get callId;
  int get code;
  String get reason;
}

/// @nodoc
mixin _$_CallPushEvent {
  CallIdValue get callId => throw _privateConstructorUsedError;
  CallkeepHandle get handle => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  bool get video => throw _privateConstructorUsedError;
  CallkeepIncomingCallError? get error => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(CallIdValue callId, CallkeepHandle handle,
            String? displayName, bool video, CallkeepIncomingCallError? error)
        incoming,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(CallIdValue callId, CallkeepHandle handle,
            String? displayName, bool video, CallkeepIncomingCallError? error)?
        incoming,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(CallIdValue callId, CallkeepHandle handle,
            String? displayName, bool video, CallkeepIncomingCallError? error)?
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

class _$_CallPushEventIncoming
    with DiagnosticableTreeMixin
    implements _CallPushEventIncoming {
  const _$_CallPushEventIncoming(
      {required this.callId,
      required this.handle,
      this.displayName,
      required this.video,
      this.error});

  @override
  final CallIdValue callId;
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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CallPushEventIncoming &&
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
    required TResult Function(CallIdValue callId, CallkeepHandle handle,
            String? displayName, bool video, CallkeepIncomingCallError? error)
        incoming,
  }) {
    return incoming(callId, handle, displayName, video, error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(CallIdValue callId, CallkeepHandle handle,
            String? displayName, bool video, CallkeepIncomingCallError? error)?
        incoming,
  }) {
    return incoming?.call(callId, handle, displayName, video, error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(CallIdValue callId, CallkeepHandle handle,
            String? displayName, bool video, CallkeepIncomingCallError? error)?
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
      {required final CallIdValue callId,
      required final CallkeepHandle handle,
      final String? displayName,
      required final bool video,
      final CallkeepIncomingCallError? error}) = _$_CallPushEventIncoming;

  @override
  CallIdValue get callId;
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
    required TResult Function(UuidValue uuid) answered,
    required TResult Function(UuidValue uuid) ended,
    required TResult Function(UuidValue uuid, bool onHold) setHeld,
    required TResult Function(UuidValue uuid, bool muted) setMuted,
    required TResult Function(UuidValue uuid, String key) sentDTMF,
    required TResult Function(UuidValue uuid) cameraSwitched,
    required TResult Function(UuidValue uuid, bool enabled) cameraEnabled,
    required TResult Function(UuidValue uuid, bool enabled) speakerEnabled,
    required TResult Function(UuidValue uuid) failureApproved,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? line, String? generic, String? number, String? email,
            String? displayName, bool video)?
        started,
    TResult? Function(UuidValue uuid)? answered,
    TResult? Function(UuidValue uuid)? ended,
    TResult? Function(UuidValue uuid, bool onHold)? setHeld,
    TResult? Function(UuidValue uuid, bool muted)? setMuted,
    TResult? Function(UuidValue uuid, String key)? sentDTMF,
    TResult? Function(UuidValue uuid)? cameraSwitched,
    TResult? Function(UuidValue uuid, bool enabled)? cameraEnabled,
    TResult? Function(UuidValue uuid, bool enabled)? speakerEnabled,
    TResult? Function(UuidValue uuid)? failureApproved,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? line, String? generic, String? number, String? email,
            String? displayName, bool video)?
        started,
    TResult Function(UuidValue uuid)? answered,
    TResult Function(UuidValue uuid)? ended,
    TResult Function(UuidValue uuid, bool onHold)? setHeld,
    TResult Function(UuidValue uuid, bool muted)? setMuted,
    TResult Function(UuidValue uuid, String key)? sentDTMF,
    TResult Function(UuidValue uuid)? cameraSwitched,
    TResult Function(UuidValue uuid, bool enabled)? cameraEnabled,
    TResult Function(UuidValue uuid, bool enabled)? speakerEnabled,
    TResult Function(UuidValue uuid)? failureApproved,
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

class _$_CallControlEventStarted
    with DiagnosticableTreeMixin, CallControlEventStartedMixin
    implements _CallControlEventStarted {
  const _$_CallControlEventStarted(
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
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CallControlEventStarted &&
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
    required TResult Function(UuidValue uuid) answered,
    required TResult Function(UuidValue uuid) ended,
    required TResult Function(UuidValue uuid, bool onHold) setHeld,
    required TResult Function(UuidValue uuid, bool muted) setMuted,
    required TResult Function(UuidValue uuid, String key) sentDTMF,
    required TResult Function(UuidValue uuid) cameraSwitched,
    required TResult Function(UuidValue uuid, bool enabled) cameraEnabled,
    required TResult Function(UuidValue uuid, bool enabled) speakerEnabled,
    required TResult Function(UuidValue uuid) failureApproved,
  }) {
    return started(line, generic, number, email, displayName, video);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? line, String? generic, String? number, String? email,
            String? displayName, bool video)?
        started,
    TResult? Function(UuidValue uuid)? answered,
    TResult? Function(UuidValue uuid)? ended,
    TResult? Function(UuidValue uuid, bool onHold)? setHeld,
    TResult? Function(UuidValue uuid, bool muted)? setMuted,
    TResult? Function(UuidValue uuid, String key)? sentDTMF,
    TResult? Function(UuidValue uuid)? cameraSwitched,
    TResult? Function(UuidValue uuid, bool enabled)? cameraEnabled,
    TResult? Function(UuidValue uuid, bool enabled)? speakerEnabled,
    TResult? Function(UuidValue uuid)? failureApproved,
  }) {
    return started?.call(line, generic, number, email, displayName, video);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? line, String? generic, String? number, String? email,
            String? displayName, bool video)?
        started,
    TResult Function(UuidValue uuid)? answered,
    TResult Function(UuidValue uuid)? ended,
    TResult Function(UuidValue uuid, bool onHold)? setHeld,
    TResult Function(UuidValue uuid, bool muted)? setMuted,
    TResult Function(UuidValue uuid, String key)? sentDTMF,
    TResult Function(UuidValue uuid)? cameraSwitched,
    TResult Function(UuidValue uuid, bool enabled)? cameraEnabled,
    TResult Function(UuidValue uuid, bool enabled)? speakerEnabled,
    TResult Function(UuidValue uuid)? failureApproved,
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
      required final bool video}) = _$_CallControlEventStarted;

  int? get line;
  String? get generic;
  String? get number;
  String? get email;
  String? get displayName;
  bool get video;
}

/// @nodoc

class _$_CallControlEventAnswered
    with DiagnosticableTreeMixin
    implements _CallControlEventAnswered {
  const _$_CallControlEventAnswered(this.uuid);

  @override
  final UuidValue uuid;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallControlEvent.answered(uuid: $uuid)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CallControlEvent.answered'))
      ..add(DiagnosticsProperty('uuid', uuid));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CallControlEventAnswered &&
            (identical(other.uuid, uuid) || other.uuid == uuid));
  }

  @override
  int get hashCode => Object.hash(runtimeType, uuid);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? line, String? generic, String? number,
            String? email, String? displayName, bool video)
        started,
    required TResult Function(UuidValue uuid) answered,
    required TResult Function(UuidValue uuid) ended,
    required TResult Function(UuidValue uuid, bool onHold) setHeld,
    required TResult Function(UuidValue uuid, bool muted) setMuted,
    required TResult Function(UuidValue uuid, String key) sentDTMF,
    required TResult Function(UuidValue uuid) cameraSwitched,
    required TResult Function(UuidValue uuid, bool enabled) cameraEnabled,
    required TResult Function(UuidValue uuid, bool enabled) speakerEnabled,
    required TResult Function(UuidValue uuid) failureApproved,
  }) {
    return answered(uuid);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? line, String? generic, String? number, String? email,
            String? displayName, bool video)?
        started,
    TResult? Function(UuidValue uuid)? answered,
    TResult? Function(UuidValue uuid)? ended,
    TResult? Function(UuidValue uuid, bool onHold)? setHeld,
    TResult? Function(UuidValue uuid, bool muted)? setMuted,
    TResult? Function(UuidValue uuid, String key)? sentDTMF,
    TResult? Function(UuidValue uuid)? cameraSwitched,
    TResult? Function(UuidValue uuid, bool enabled)? cameraEnabled,
    TResult? Function(UuidValue uuid, bool enabled)? speakerEnabled,
    TResult? Function(UuidValue uuid)? failureApproved,
  }) {
    return answered?.call(uuid);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? line, String? generic, String? number, String? email,
            String? displayName, bool video)?
        started,
    TResult Function(UuidValue uuid)? answered,
    TResult Function(UuidValue uuid)? ended,
    TResult Function(UuidValue uuid, bool onHold)? setHeld,
    TResult Function(UuidValue uuid, bool muted)? setMuted,
    TResult Function(UuidValue uuid, String key)? sentDTMF,
    TResult Function(UuidValue uuid)? cameraSwitched,
    TResult Function(UuidValue uuid, bool enabled)? cameraEnabled,
    TResult Function(UuidValue uuid, bool enabled)? speakerEnabled,
    TResult Function(UuidValue uuid)? failureApproved,
    required TResult orElse(),
  }) {
    if (answered != null) {
      return answered(uuid);
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
  const factory _CallControlEventAnswered(final UuidValue uuid) =
      _$_CallControlEventAnswered;

  UuidValue get uuid;
}

/// @nodoc

class _$_CallControlEventEnded
    with DiagnosticableTreeMixin
    implements _CallControlEventEnded {
  const _$_CallControlEventEnded(this.uuid);

  @override
  final UuidValue uuid;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallControlEvent.ended(uuid: $uuid)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CallControlEvent.ended'))
      ..add(DiagnosticsProperty('uuid', uuid));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CallControlEventEnded &&
            (identical(other.uuid, uuid) || other.uuid == uuid));
  }

  @override
  int get hashCode => Object.hash(runtimeType, uuid);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? line, String? generic, String? number,
            String? email, String? displayName, bool video)
        started,
    required TResult Function(UuidValue uuid) answered,
    required TResult Function(UuidValue uuid) ended,
    required TResult Function(UuidValue uuid, bool onHold) setHeld,
    required TResult Function(UuidValue uuid, bool muted) setMuted,
    required TResult Function(UuidValue uuid, String key) sentDTMF,
    required TResult Function(UuidValue uuid) cameraSwitched,
    required TResult Function(UuidValue uuid, bool enabled) cameraEnabled,
    required TResult Function(UuidValue uuid, bool enabled) speakerEnabled,
    required TResult Function(UuidValue uuid) failureApproved,
  }) {
    return ended(uuid);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? line, String? generic, String? number, String? email,
            String? displayName, bool video)?
        started,
    TResult? Function(UuidValue uuid)? answered,
    TResult? Function(UuidValue uuid)? ended,
    TResult? Function(UuidValue uuid, bool onHold)? setHeld,
    TResult? Function(UuidValue uuid, bool muted)? setMuted,
    TResult? Function(UuidValue uuid, String key)? sentDTMF,
    TResult? Function(UuidValue uuid)? cameraSwitched,
    TResult? Function(UuidValue uuid, bool enabled)? cameraEnabled,
    TResult? Function(UuidValue uuid, bool enabled)? speakerEnabled,
    TResult? Function(UuidValue uuid)? failureApproved,
  }) {
    return ended?.call(uuid);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? line, String? generic, String? number, String? email,
            String? displayName, bool video)?
        started,
    TResult Function(UuidValue uuid)? answered,
    TResult Function(UuidValue uuid)? ended,
    TResult Function(UuidValue uuid, bool onHold)? setHeld,
    TResult Function(UuidValue uuid, bool muted)? setMuted,
    TResult Function(UuidValue uuid, String key)? sentDTMF,
    TResult Function(UuidValue uuid)? cameraSwitched,
    TResult Function(UuidValue uuid, bool enabled)? cameraEnabled,
    TResult Function(UuidValue uuid, bool enabled)? speakerEnabled,
    TResult Function(UuidValue uuid)? failureApproved,
    required TResult orElse(),
  }) {
    if (ended != null) {
      return ended(uuid);
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
  const factory _CallControlEventEnded(final UuidValue uuid) =
      _$_CallControlEventEnded;

  UuidValue get uuid;
}

/// @nodoc

class _$_CallControlEventSetHeld
    with DiagnosticableTreeMixin
    implements _CallControlEventSetHeld {
  const _$_CallControlEventSetHeld(this.uuid, this.onHold);

  @override
  final UuidValue uuid;
  @override
  final bool onHold;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallControlEvent.setHeld(uuid: $uuid, onHold: $onHold)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CallControlEvent.setHeld'))
      ..add(DiagnosticsProperty('uuid', uuid))
      ..add(DiagnosticsProperty('onHold', onHold));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CallControlEventSetHeld &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.onHold, onHold) || other.onHold == onHold));
  }

  @override
  int get hashCode => Object.hash(runtimeType, uuid, onHold);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? line, String? generic, String? number,
            String? email, String? displayName, bool video)
        started,
    required TResult Function(UuidValue uuid) answered,
    required TResult Function(UuidValue uuid) ended,
    required TResult Function(UuidValue uuid, bool onHold) setHeld,
    required TResult Function(UuidValue uuid, bool muted) setMuted,
    required TResult Function(UuidValue uuid, String key) sentDTMF,
    required TResult Function(UuidValue uuid) cameraSwitched,
    required TResult Function(UuidValue uuid, bool enabled) cameraEnabled,
    required TResult Function(UuidValue uuid, bool enabled) speakerEnabled,
    required TResult Function(UuidValue uuid) failureApproved,
  }) {
    return setHeld(uuid, onHold);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? line, String? generic, String? number, String? email,
            String? displayName, bool video)?
        started,
    TResult? Function(UuidValue uuid)? answered,
    TResult? Function(UuidValue uuid)? ended,
    TResult? Function(UuidValue uuid, bool onHold)? setHeld,
    TResult? Function(UuidValue uuid, bool muted)? setMuted,
    TResult? Function(UuidValue uuid, String key)? sentDTMF,
    TResult? Function(UuidValue uuid)? cameraSwitched,
    TResult? Function(UuidValue uuid, bool enabled)? cameraEnabled,
    TResult? Function(UuidValue uuid, bool enabled)? speakerEnabled,
    TResult? Function(UuidValue uuid)? failureApproved,
  }) {
    return setHeld?.call(uuid, onHold);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? line, String? generic, String? number, String? email,
            String? displayName, bool video)?
        started,
    TResult Function(UuidValue uuid)? answered,
    TResult Function(UuidValue uuid)? ended,
    TResult Function(UuidValue uuid, bool onHold)? setHeld,
    TResult Function(UuidValue uuid, bool muted)? setMuted,
    TResult Function(UuidValue uuid, String key)? sentDTMF,
    TResult Function(UuidValue uuid)? cameraSwitched,
    TResult Function(UuidValue uuid, bool enabled)? cameraEnabled,
    TResult Function(UuidValue uuid, bool enabled)? speakerEnabled,
    TResult Function(UuidValue uuid)? failureApproved,
    required TResult orElse(),
  }) {
    if (setHeld != null) {
      return setHeld(uuid, onHold);
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
      final UuidValue uuid, final bool onHold) = _$_CallControlEventSetHeld;

  UuidValue get uuid;
  bool get onHold;
}

/// @nodoc

class _$_CallControlEventSetMuted
    with DiagnosticableTreeMixin
    implements _CallControlEventSetMuted {
  const _$_CallControlEventSetMuted(this.uuid, this.muted);

  @override
  final UuidValue uuid;
  @override
  final bool muted;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallControlEvent.setMuted(uuid: $uuid, muted: $muted)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CallControlEvent.setMuted'))
      ..add(DiagnosticsProperty('uuid', uuid))
      ..add(DiagnosticsProperty('muted', muted));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CallControlEventSetMuted &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.muted, muted) || other.muted == muted));
  }

  @override
  int get hashCode => Object.hash(runtimeType, uuid, muted);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? line, String? generic, String? number,
            String? email, String? displayName, bool video)
        started,
    required TResult Function(UuidValue uuid) answered,
    required TResult Function(UuidValue uuid) ended,
    required TResult Function(UuidValue uuid, bool onHold) setHeld,
    required TResult Function(UuidValue uuid, bool muted) setMuted,
    required TResult Function(UuidValue uuid, String key) sentDTMF,
    required TResult Function(UuidValue uuid) cameraSwitched,
    required TResult Function(UuidValue uuid, bool enabled) cameraEnabled,
    required TResult Function(UuidValue uuid, bool enabled) speakerEnabled,
    required TResult Function(UuidValue uuid) failureApproved,
  }) {
    return setMuted(uuid, muted);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? line, String? generic, String? number, String? email,
            String? displayName, bool video)?
        started,
    TResult? Function(UuidValue uuid)? answered,
    TResult? Function(UuidValue uuid)? ended,
    TResult? Function(UuidValue uuid, bool onHold)? setHeld,
    TResult? Function(UuidValue uuid, bool muted)? setMuted,
    TResult? Function(UuidValue uuid, String key)? sentDTMF,
    TResult? Function(UuidValue uuid)? cameraSwitched,
    TResult? Function(UuidValue uuid, bool enabled)? cameraEnabled,
    TResult? Function(UuidValue uuid, bool enabled)? speakerEnabled,
    TResult? Function(UuidValue uuid)? failureApproved,
  }) {
    return setMuted?.call(uuid, muted);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? line, String? generic, String? number, String? email,
            String? displayName, bool video)?
        started,
    TResult Function(UuidValue uuid)? answered,
    TResult Function(UuidValue uuid)? ended,
    TResult Function(UuidValue uuid, bool onHold)? setHeld,
    TResult Function(UuidValue uuid, bool muted)? setMuted,
    TResult Function(UuidValue uuid, String key)? sentDTMF,
    TResult Function(UuidValue uuid)? cameraSwitched,
    TResult Function(UuidValue uuid, bool enabled)? cameraEnabled,
    TResult Function(UuidValue uuid, bool enabled)? speakerEnabled,
    TResult Function(UuidValue uuid)? failureApproved,
    required TResult orElse(),
  }) {
    if (setMuted != null) {
      return setMuted(uuid, muted);
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
      final UuidValue uuid, final bool muted) = _$_CallControlEventSetMuted;

  UuidValue get uuid;
  bool get muted;
}

/// @nodoc

class _$_CallControlEventSentDTMF
    with DiagnosticableTreeMixin
    implements _CallControlEventSentDTMF {
  const _$_CallControlEventSentDTMF(this.uuid, this.key);

  @override
  final UuidValue uuid;
  @override
  final String key;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallControlEvent.sentDTMF(uuid: $uuid, key: $key)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CallControlEvent.sentDTMF'))
      ..add(DiagnosticsProperty('uuid', uuid))
      ..add(DiagnosticsProperty('key', key));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CallControlEventSentDTMF &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.key, key) || other.key == key));
  }

  @override
  int get hashCode => Object.hash(runtimeType, uuid, key);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? line, String? generic, String? number,
            String? email, String? displayName, bool video)
        started,
    required TResult Function(UuidValue uuid) answered,
    required TResult Function(UuidValue uuid) ended,
    required TResult Function(UuidValue uuid, bool onHold) setHeld,
    required TResult Function(UuidValue uuid, bool muted) setMuted,
    required TResult Function(UuidValue uuid, String key) sentDTMF,
    required TResult Function(UuidValue uuid) cameraSwitched,
    required TResult Function(UuidValue uuid, bool enabled) cameraEnabled,
    required TResult Function(UuidValue uuid, bool enabled) speakerEnabled,
    required TResult Function(UuidValue uuid) failureApproved,
  }) {
    return sentDTMF(uuid, key);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? line, String? generic, String? number, String? email,
            String? displayName, bool video)?
        started,
    TResult? Function(UuidValue uuid)? answered,
    TResult? Function(UuidValue uuid)? ended,
    TResult? Function(UuidValue uuid, bool onHold)? setHeld,
    TResult? Function(UuidValue uuid, bool muted)? setMuted,
    TResult? Function(UuidValue uuid, String key)? sentDTMF,
    TResult? Function(UuidValue uuid)? cameraSwitched,
    TResult? Function(UuidValue uuid, bool enabled)? cameraEnabled,
    TResult? Function(UuidValue uuid, bool enabled)? speakerEnabled,
    TResult? Function(UuidValue uuid)? failureApproved,
  }) {
    return sentDTMF?.call(uuid, key);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? line, String? generic, String? number, String? email,
            String? displayName, bool video)?
        started,
    TResult Function(UuidValue uuid)? answered,
    TResult Function(UuidValue uuid)? ended,
    TResult Function(UuidValue uuid, bool onHold)? setHeld,
    TResult Function(UuidValue uuid, bool muted)? setMuted,
    TResult Function(UuidValue uuid, String key)? sentDTMF,
    TResult Function(UuidValue uuid)? cameraSwitched,
    TResult Function(UuidValue uuid, bool enabled)? cameraEnabled,
    TResult Function(UuidValue uuid, bool enabled)? speakerEnabled,
    TResult Function(UuidValue uuid)? failureApproved,
    required TResult orElse(),
  }) {
    if (sentDTMF != null) {
      return sentDTMF(uuid, key);
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
      final UuidValue uuid, final String key) = _$_CallControlEventSentDTMF;

  UuidValue get uuid;
  String get key;
}

/// @nodoc

class _$_CallControlEventCameraSwitched
    with DiagnosticableTreeMixin
    implements _CallControlEventCameraSwitched {
  const _$_CallControlEventCameraSwitched(this.uuid);

  @override
  final UuidValue uuid;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallControlEvent.cameraSwitched(uuid: $uuid)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CallControlEvent.cameraSwitched'))
      ..add(DiagnosticsProperty('uuid', uuid));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CallControlEventCameraSwitched &&
            (identical(other.uuid, uuid) || other.uuid == uuid));
  }

  @override
  int get hashCode => Object.hash(runtimeType, uuid);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? line, String? generic, String? number,
            String? email, String? displayName, bool video)
        started,
    required TResult Function(UuidValue uuid) answered,
    required TResult Function(UuidValue uuid) ended,
    required TResult Function(UuidValue uuid, bool onHold) setHeld,
    required TResult Function(UuidValue uuid, bool muted) setMuted,
    required TResult Function(UuidValue uuid, String key) sentDTMF,
    required TResult Function(UuidValue uuid) cameraSwitched,
    required TResult Function(UuidValue uuid, bool enabled) cameraEnabled,
    required TResult Function(UuidValue uuid, bool enabled) speakerEnabled,
    required TResult Function(UuidValue uuid) failureApproved,
  }) {
    return cameraSwitched(uuid);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? line, String? generic, String? number, String? email,
            String? displayName, bool video)?
        started,
    TResult? Function(UuidValue uuid)? answered,
    TResult? Function(UuidValue uuid)? ended,
    TResult? Function(UuidValue uuid, bool onHold)? setHeld,
    TResult? Function(UuidValue uuid, bool muted)? setMuted,
    TResult? Function(UuidValue uuid, String key)? sentDTMF,
    TResult? Function(UuidValue uuid)? cameraSwitched,
    TResult? Function(UuidValue uuid, bool enabled)? cameraEnabled,
    TResult? Function(UuidValue uuid, bool enabled)? speakerEnabled,
    TResult? Function(UuidValue uuid)? failureApproved,
  }) {
    return cameraSwitched?.call(uuid);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? line, String? generic, String? number, String? email,
            String? displayName, bool video)?
        started,
    TResult Function(UuidValue uuid)? answered,
    TResult Function(UuidValue uuid)? ended,
    TResult Function(UuidValue uuid, bool onHold)? setHeld,
    TResult Function(UuidValue uuid, bool muted)? setMuted,
    TResult Function(UuidValue uuid, String key)? sentDTMF,
    TResult Function(UuidValue uuid)? cameraSwitched,
    TResult Function(UuidValue uuid, bool enabled)? cameraEnabled,
    TResult Function(UuidValue uuid, bool enabled)? speakerEnabled,
    TResult Function(UuidValue uuid)? failureApproved,
    required TResult orElse(),
  }) {
    if (cameraSwitched != null) {
      return cameraSwitched(uuid);
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
  const factory _CallControlEventCameraSwitched(final UuidValue uuid) =
      _$_CallControlEventCameraSwitched;

  UuidValue get uuid;
}

/// @nodoc

class _$_CallControlEventCameraEnabled
    with DiagnosticableTreeMixin
    implements _CallControlEventCameraEnabled {
  const _$_CallControlEventCameraEnabled(this.uuid, this.enabled);

  @override
  final UuidValue uuid;
  @override
  final bool enabled;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallControlEvent.cameraEnabled(uuid: $uuid, enabled: $enabled)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CallControlEvent.cameraEnabled'))
      ..add(DiagnosticsProperty('uuid', uuid))
      ..add(DiagnosticsProperty('enabled', enabled));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CallControlEventCameraEnabled &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.enabled, enabled) || other.enabled == enabled));
  }

  @override
  int get hashCode => Object.hash(runtimeType, uuid, enabled);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? line, String? generic, String? number,
            String? email, String? displayName, bool video)
        started,
    required TResult Function(UuidValue uuid) answered,
    required TResult Function(UuidValue uuid) ended,
    required TResult Function(UuidValue uuid, bool onHold) setHeld,
    required TResult Function(UuidValue uuid, bool muted) setMuted,
    required TResult Function(UuidValue uuid, String key) sentDTMF,
    required TResult Function(UuidValue uuid) cameraSwitched,
    required TResult Function(UuidValue uuid, bool enabled) cameraEnabled,
    required TResult Function(UuidValue uuid, bool enabled) speakerEnabled,
    required TResult Function(UuidValue uuid) failureApproved,
  }) {
    return cameraEnabled(uuid, enabled);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? line, String? generic, String? number, String? email,
            String? displayName, bool video)?
        started,
    TResult? Function(UuidValue uuid)? answered,
    TResult? Function(UuidValue uuid)? ended,
    TResult? Function(UuidValue uuid, bool onHold)? setHeld,
    TResult? Function(UuidValue uuid, bool muted)? setMuted,
    TResult? Function(UuidValue uuid, String key)? sentDTMF,
    TResult? Function(UuidValue uuid)? cameraSwitched,
    TResult? Function(UuidValue uuid, bool enabled)? cameraEnabled,
    TResult? Function(UuidValue uuid, bool enabled)? speakerEnabled,
    TResult? Function(UuidValue uuid)? failureApproved,
  }) {
    return cameraEnabled?.call(uuid, enabled);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? line, String? generic, String? number, String? email,
            String? displayName, bool video)?
        started,
    TResult Function(UuidValue uuid)? answered,
    TResult Function(UuidValue uuid)? ended,
    TResult Function(UuidValue uuid, bool onHold)? setHeld,
    TResult Function(UuidValue uuid, bool muted)? setMuted,
    TResult Function(UuidValue uuid, String key)? sentDTMF,
    TResult Function(UuidValue uuid)? cameraSwitched,
    TResult Function(UuidValue uuid, bool enabled)? cameraEnabled,
    TResult Function(UuidValue uuid, bool enabled)? speakerEnabled,
    TResult Function(UuidValue uuid)? failureApproved,
    required TResult orElse(),
  }) {
    if (cameraEnabled != null) {
      return cameraEnabled(uuid, enabled);
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
          final UuidValue uuid, final bool enabled) =
      _$_CallControlEventCameraEnabled;

  UuidValue get uuid;
  bool get enabled;
}

/// @nodoc

class _$_CallControlEventSpeakerEnabled
    with DiagnosticableTreeMixin
    implements _CallControlEventSpeakerEnabled {
  const _$_CallControlEventSpeakerEnabled(this.uuid, this.enabled);

  @override
  final UuidValue uuid;
  @override
  final bool enabled;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallControlEvent.speakerEnabled(uuid: $uuid, enabled: $enabled)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CallControlEvent.speakerEnabled'))
      ..add(DiagnosticsProperty('uuid', uuid))
      ..add(DiagnosticsProperty('enabled', enabled));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CallControlEventSpeakerEnabled &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.enabled, enabled) || other.enabled == enabled));
  }

  @override
  int get hashCode => Object.hash(runtimeType, uuid, enabled);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? line, String? generic, String? number,
            String? email, String? displayName, bool video)
        started,
    required TResult Function(UuidValue uuid) answered,
    required TResult Function(UuidValue uuid) ended,
    required TResult Function(UuidValue uuid, bool onHold) setHeld,
    required TResult Function(UuidValue uuid, bool muted) setMuted,
    required TResult Function(UuidValue uuid, String key) sentDTMF,
    required TResult Function(UuidValue uuid) cameraSwitched,
    required TResult Function(UuidValue uuid, bool enabled) cameraEnabled,
    required TResult Function(UuidValue uuid, bool enabled) speakerEnabled,
    required TResult Function(UuidValue uuid) failureApproved,
  }) {
    return speakerEnabled(uuid, enabled);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? line, String? generic, String? number, String? email,
            String? displayName, bool video)?
        started,
    TResult? Function(UuidValue uuid)? answered,
    TResult? Function(UuidValue uuid)? ended,
    TResult? Function(UuidValue uuid, bool onHold)? setHeld,
    TResult? Function(UuidValue uuid, bool muted)? setMuted,
    TResult? Function(UuidValue uuid, String key)? sentDTMF,
    TResult? Function(UuidValue uuid)? cameraSwitched,
    TResult? Function(UuidValue uuid, bool enabled)? cameraEnabled,
    TResult? Function(UuidValue uuid, bool enabled)? speakerEnabled,
    TResult? Function(UuidValue uuid)? failureApproved,
  }) {
    return speakerEnabled?.call(uuid, enabled);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? line, String? generic, String? number, String? email,
            String? displayName, bool video)?
        started,
    TResult Function(UuidValue uuid)? answered,
    TResult Function(UuidValue uuid)? ended,
    TResult Function(UuidValue uuid, bool onHold)? setHeld,
    TResult Function(UuidValue uuid, bool muted)? setMuted,
    TResult Function(UuidValue uuid, String key)? sentDTMF,
    TResult Function(UuidValue uuid)? cameraSwitched,
    TResult Function(UuidValue uuid, bool enabled)? cameraEnabled,
    TResult Function(UuidValue uuid, bool enabled)? speakerEnabled,
    TResult Function(UuidValue uuid)? failureApproved,
    required TResult orElse(),
  }) {
    if (speakerEnabled != null) {
      return speakerEnabled(uuid, enabled);
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
          final UuidValue uuid, final bool enabled) =
      _$_CallControlEventSpeakerEnabled;

  UuidValue get uuid;
  bool get enabled;
}

/// @nodoc

class _$_CallControlEventFailureApproved
    with DiagnosticableTreeMixin
    implements _CallControlEventFailureApproved {
  const _$_CallControlEventFailureApproved(this.uuid);

  @override
  final UuidValue uuid;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallControlEvent.failureApproved(uuid: $uuid)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CallControlEvent.failureApproved'))
      ..add(DiagnosticsProperty('uuid', uuid));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CallControlEventFailureApproved &&
            (identical(other.uuid, uuid) || other.uuid == uuid));
  }

  @override
  int get hashCode => Object.hash(runtimeType, uuid);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int? line, String? generic, String? number,
            String? email, String? displayName, bool video)
        started,
    required TResult Function(UuidValue uuid) answered,
    required TResult Function(UuidValue uuid) ended,
    required TResult Function(UuidValue uuid, bool onHold) setHeld,
    required TResult Function(UuidValue uuid, bool muted) setMuted,
    required TResult Function(UuidValue uuid, String key) sentDTMF,
    required TResult Function(UuidValue uuid) cameraSwitched,
    required TResult Function(UuidValue uuid, bool enabled) cameraEnabled,
    required TResult Function(UuidValue uuid, bool enabled) speakerEnabled,
    required TResult Function(UuidValue uuid) failureApproved,
  }) {
    return failureApproved(uuid);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int? line, String? generic, String? number, String? email,
            String? displayName, bool video)?
        started,
    TResult? Function(UuidValue uuid)? answered,
    TResult? Function(UuidValue uuid)? ended,
    TResult? Function(UuidValue uuid, bool onHold)? setHeld,
    TResult? Function(UuidValue uuid, bool muted)? setMuted,
    TResult? Function(UuidValue uuid, String key)? sentDTMF,
    TResult? Function(UuidValue uuid)? cameraSwitched,
    TResult? Function(UuidValue uuid, bool enabled)? cameraEnabled,
    TResult? Function(UuidValue uuid, bool enabled)? speakerEnabled,
    TResult? Function(UuidValue uuid)? failureApproved,
  }) {
    return failureApproved?.call(uuid);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int? line, String? generic, String? number, String? email,
            String? displayName, bool video)?
        started,
    TResult Function(UuidValue uuid)? answered,
    TResult Function(UuidValue uuid)? ended,
    TResult Function(UuidValue uuid, bool onHold)? setHeld,
    TResult Function(UuidValue uuid, bool muted)? setMuted,
    TResult Function(UuidValue uuid, String key)? sentDTMF,
    TResult Function(UuidValue uuid)? cameraSwitched,
    TResult Function(UuidValue uuid, bool enabled)? cameraEnabled,
    TResult Function(UuidValue uuid, bool enabled)? speakerEnabled,
    TResult Function(UuidValue uuid)? failureApproved,
    required TResult orElse(),
  }) {
    if (failureApproved != null) {
      return failureApproved(uuid);
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
  const factory _CallControlEventFailureApproved(final UuidValue uuid) =
      _$_CallControlEventFailureApproved;

  UuidValue get uuid;
}

/// @nodoc
mixin _$_CallPerformEvent {
  UuidValue get uuid => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UuidValue uuid, CallkeepHandle handle,
            String? displayName, bool video)
        started,
    required TResult Function(UuidValue uuid) answered,
    required TResult Function(UuidValue uuid) ended,
    required TResult Function(UuidValue uuid, bool onHold) setHeld,
    required TResult Function(UuidValue uuid, bool muted) setMuted,
    required TResult Function(UuidValue uuid, String key) sentDTMF,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UuidValue uuid, CallkeepHandle handle,
            String? displayName, bool video)?
        started,
    TResult? Function(UuidValue uuid)? answered,
    TResult? Function(UuidValue uuid)? ended,
    TResult? Function(UuidValue uuid, bool onHold)? setHeld,
    TResult? Function(UuidValue uuid, bool muted)? setMuted,
    TResult? Function(UuidValue uuid, String key)? sentDTMF,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UuidValue uuid, CallkeepHandle handle, String? displayName,
            bool video)?
        started,
    TResult Function(UuidValue uuid)? answered,
    TResult Function(UuidValue uuid)? ended,
    TResult Function(UuidValue uuid, bool onHold)? setHeld,
    TResult Function(UuidValue uuid, bool muted)? setMuted,
    TResult Function(UuidValue uuid, String key)? sentDTMF,
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

class _$_CallPerformEventStarted extends _CallPerformEventStarted
    with DiagnosticableTreeMixin {
  _$_CallPerformEventStarted(this.uuid,
      {required this.handle, this.displayName, required this.video})
      : super._();

  @override
  final UuidValue uuid;
  @override
  final CallkeepHandle handle;
  @override
  final String? displayName;
  @override
  final bool video;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallPerformEvent.started(uuid: $uuid, handle: $handle, displayName: $displayName, video: $video)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', '_CallPerformEvent.started'))
      ..add(DiagnosticsProperty('uuid', uuid))
      ..add(DiagnosticsProperty('handle', handle))
      ..add(DiagnosticsProperty('displayName', displayName))
      ..add(DiagnosticsProperty('video', video));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CallPerformEventStarted &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.handle, handle) || other.handle == handle) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.video, video) || other.video == video));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, uuid, handle, displayName, video);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UuidValue uuid, CallkeepHandle handle,
            String? displayName, bool video)
        started,
    required TResult Function(UuidValue uuid) answered,
    required TResult Function(UuidValue uuid) ended,
    required TResult Function(UuidValue uuid, bool onHold) setHeld,
    required TResult Function(UuidValue uuid, bool muted) setMuted,
    required TResult Function(UuidValue uuid, String key) sentDTMF,
  }) {
    return started(uuid, handle, displayName, video);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UuidValue uuid, CallkeepHandle handle,
            String? displayName, bool video)?
        started,
    TResult? Function(UuidValue uuid)? answered,
    TResult? Function(UuidValue uuid)? ended,
    TResult? Function(UuidValue uuid, bool onHold)? setHeld,
    TResult? Function(UuidValue uuid, bool muted)? setMuted,
    TResult? Function(UuidValue uuid, String key)? sentDTMF,
  }) {
    return started?.call(uuid, handle, displayName, video);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UuidValue uuid, CallkeepHandle handle, String? displayName,
            bool video)?
        started,
    TResult Function(UuidValue uuid)? answered,
    TResult Function(UuidValue uuid)? ended,
    TResult Function(UuidValue uuid, bool onHold)? setHeld,
    TResult Function(UuidValue uuid, bool muted)? setMuted,
    TResult Function(UuidValue uuid, String key)? sentDTMF,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(uuid, handle, displayName, video);
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
  factory _CallPerformEventStarted(final UuidValue uuid,
      {required final CallkeepHandle handle,
      final String? displayName,
      required final bool video}) = _$_CallPerformEventStarted;
  _CallPerformEventStarted._() : super._();

  @override
  UuidValue get uuid;
  CallkeepHandle get handle;
  String? get displayName;
  bool get video;
}

/// @nodoc

class _$_CallPerformEventAnswered extends _CallPerformEventAnswered
    with DiagnosticableTreeMixin {
  _$_CallPerformEventAnswered(this.uuid) : super._();

  @override
  final UuidValue uuid;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallPerformEvent.answered(uuid: $uuid)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', '_CallPerformEvent.answered'))
      ..add(DiagnosticsProperty('uuid', uuid));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CallPerformEventAnswered &&
            (identical(other.uuid, uuid) || other.uuid == uuid));
  }

  @override
  int get hashCode => Object.hash(runtimeType, uuid);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UuidValue uuid, CallkeepHandle handle,
            String? displayName, bool video)
        started,
    required TResult Function(UuidValue uuid) answered,
    required TResult Function(UuidValue uuid) ended,
    required TResult Function(UuidValue uuid, bool onHold) setHeld,
    required TResult Function(UuidValue uuid, bool muted) setMuted,
    required TResult Function(UuidValue uuid, String key) sentDTMF,
  }) {
    return answered(uuid);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UuidValue uuid, CallkeepHandle handle,
            String? displayName, bool video)?
        started,
    TResult? Function(UuidValue uuid)? answered,
    TResult? Function(UuidValue uuid)? ended,
    TResult? Function(UuidValue uuid, bool onHold)? setHeld,
    TResult? Function(UuidValue uuid, bool muted)? setMuted,
    TResult? Function(UuidValue uuid, String key)? sentDTMF,
  }) {
    return answered?.call(uuid);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UuidValue uuid, CallkeepHandle handle, String? displayName,
            bool video)?
        started,
    TResult Function(UuidValue uuid)? answered,
    TResult Function(UuidValue uuid)? ended,
    TResult Function(UuidValue uuid, bool onHold)? setHeld,
    TResult Function(UuidValue uuid, bool muted)? setMuted,
    TResult Function(UuidValue uuid, String key)? sentDTMF,
    required TResult orElse(),
  }) {
    if (answered != null) {
      return answered(uuid);
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
  factory _CallPerformEventAnswered(final UuidValue uuid) =
      _$_CallPerformEventAnswered;
  _CallPerformEventAnswered._() : super._();

  @override
  UuidValue get uuid;
}

/// @nodoc

class _$_CallPerformEventEnded extends _CallPerformEventEnded
    with DiagnosticableTreeMixin {
  _$_CallPerformEventEnded(this.uuid) : super._();

  @override
  final UuidValue uuid;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallPerformEvent.ended(uuid: $uuid)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', '_CallPerformEvent.ended'))
      ..add(DiagnosticsProperty('uuid', uuid));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CallPerformEventEnded &&
            (identical(other.uuid, uuid) || other.uuid == uuid));
  }

  @override
  int get hashCode => Object.hash(runtimeType, uuid);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UuidValue uuid, CallkeepHandle handle,
            String? displayName, bool video)
        started,
    required TResult Function(UuidValue uuid) answered,
    required TResult Function(UuidValue uuid) ended,
    required TResult Function(UuidValue uuid, bool onHold) setHeld,
    required TResult Function(UuidValue uuid, bool muted) setMuted,
    required TResult Function(UuidValue uuid, String key) sentDTMF,
  }) {
    return ended(uuid);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UuidValue uuid, CallkeepHandle handle,
            String? displayName, bool video)?
        started,
    TResult? Function(UuidValue uuid)? answered,
    TResult? Function(UuidValue uuid)? ended,
    TResult? Function(UuidValue uuid, bool onHold)? setHeld,
    TResult? Function(UuidValue uuid, bool muted)? setMuted,
    TResult? Function(UuidValue uuid, String key)? sentDTMF,
  }) {
    return ended?.call(uuid);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UuidValue uuid, CallkeepHandle handle, String? displayName,
            bool video)?
        started,
    TResult Function(UuidValue uuid)? answered,
    TResult Function(UuidValue uuid)? ended,
    TResult Function(UuidValue uuid, bool onHold)? setHeld,
    TResult Function(UuidValue uuid, bool muted)? setMuted,
    TResult Function(UuidValue uuid, String key)? sentDTMF,
    required TResult orElse(),
  }) {
    if (ended != null) {
      return ended(uuid);
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
  factory _CallPerformEventEnded(final UuidValue uuid) =
      _$_CallPerformEventEnded;
  _CallPerformEventEnded._() : super._();

  @override
  UuidValue get uuid;
}

/// @nodoc

class _$_CallPerformEventSetHeld extends _CallPerformEventSetHeld
    with DiagnosticableTreeMixin {
  _$_CallPerformEventSetHeld(this.uuid, this.onHold) : super._();

  @override
  final UuidValue uuid;
  @override
  final bool onHold;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallPerformEvent.setHeld(uuid: $uuid, onHold: $onHold)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', '_CallPerformEvent.setHeld'))
      ..add(DiagnosticsProperty('uuid', uuid))
      ..add(DiagnosticsProperty('onHold', onHold));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CallPerformEventSetHeld &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.onHold, onHold) || other.onHold == onHold));
  }

  @override
  int get hashCode => Object.hash(runtimeType, uuid, onHold);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UuidValue uuid, CallkeepHandle handle,
            String? displayName, bool video)
        started,
    required TResult Function(UuidValue uuid) answered,
    required TResult Function(UuidValue uuid) ended,
    required TResult Function(UuidValue uuid, bool onHold) setHeld,
    required TResult Function(UuidValue uuid, bool muted) setMuted,
    required TResult Function(UuidValue uuid, String key) sentDTMF,
  }) {
    return setHeld(uuid, onHold);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UuidValue uuid, CallkeepHandle handle,
            String? displayName, bool video)?
        started,
    TResult? Function(UuidValue uuid)? answered,
    TResult? Function(UuidValue uuid)? ended,
    TResult? Function(UuidValue uuid, bool onHold)? setHeld,
    TResult? Function(UuidValue uuid, bool muted)? setMuted,
    TResult? Function(UuidValue uuid, String key)? sentDTMF,
  }) {
    return setHeld?.call(uuid, onHold);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UuidValue uuid, CallkeepHandle handle, String? displayName,
            bool video)?
        started,
    TResult Function(UuidValue uuid)? answered,
    TResult Function(UuidValue uuid)? ended,
    TResult Function(UuidValue uuid, bool onHold)? setHeld,
    TResult Function(UuidValue uuid, bool muted)? setMuted,
    TResult Function(UuidValue uuid, String key)? sentDTMF,
    required TResult orElse(),
  }) {
    if (setHeld != null) {
      return setHeld(uuid, onHold);
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
  factory _CallPerformEventSetHeld(final UuidValue uuid, final bool onHold) =
      _$_CallPerformEventSetHeld;
  _CallPerformEventSetHeld._() : super._();

  @override
  UuidValue get uuid;
  bool get onHold;
}

/// @nodoc

class _$_CallPerformEventSetMuted extends _CallPerformEventSetMuted
    with DiagnosticableTreeMixin {
  _$_CallPerformEventSetMuted(this.uuid, this.muted) : super._();

  @override
  final UuidValue uuid;
  @override
  final bool muted;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallPerformEvent.setMuted(uuid: $uuid, muted: $muted)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', '_CallPerformEvent.setMuted'))
      ..add(DiagnosticsProperty('uuid', uuid))
      ..add(DiagnosticsProperty('muted', muted));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CallPerformEventSetMuted &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.muted, muted) || other.muted == muted));
  }

  @override
  int get hashCode => Object.hash(runtimeType, uuid, muted);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UuidValue uuid, CallkeepHandle handle,
            String? displayName, bool video)
        started,
    required TResult Function(UuidValue uuid) answered,
    required TResult Function(UuidValue uuid) ended,
    required TResult Function(UuidValue uuid, bool onHold) setHeld,
    required TResult Function(UuidValue uuid, bool muted) setMuted,
    required TResult Function(UuidValue uuid, String key) sentDTMF,
  }) {
    return setMuted(uuid, muted);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UuidValue uuid, CallkeepHandle handle,
            String? displayName, bool video)?
        started,
    TResult? Function(UuidValue uuid)? answered,
    TResult? Function(UuidValue uuid)? ended,
    TResult? Function(UuidValue uuid, bool onHold)? setHeld,
    TResult? Function(UuidValue uuid, bool muted)? setMuted,
    TResult? Function(UuidValue uuid, String key)? sentDTMF,
  }) {
    return setMuted?.call(uuid, muted);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UuidValue uuid, CallkeepHandle handle, String? displayName,
            bool video)?
        started,
    TResult Function(UuidValue uuid)? answered,
    TResult Function(UuidValue uuid)? ended,
    TResult Function(UuidValue uuid, bool onHold)? setHeld,
    TResult Function(UuidValue uuid, bool muted)? setMuted,
    TResult Function(UuidValue uuid, String key)? sentDTMF,
    required TResult orElse(),
  }) {
    if (setMuted != null) {
      return setMuted(uuid, muted);
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
  factory _CallPerformEventSetMuted(final UuidValue uuid, final bool muted) =
      _$_CallPerformEventSetMuted;
  _CallPerformEventSetMuted._() : super._();

  @override
  UuidValue get uuid;
  bool get muted;
}

/// @nodoc

class _$_CallPerformEventSentDTMF extends _CallPerformEventSentDTMF
    with DiagnosticableTreeMixin {
  _$_CallPerformEventSentDTMF(this.uuid, this.key) : super._();

  @override
  final UuidValue uuid;
  @override
  final String key;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallPerformEvent.sentDTMF(uuid: $uuid, key: $key)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', '_CallPerformEvent.sentDTMF'))
      ..add(DiagnosticsProperty('uuid', uuid))
      ..add(DiagnosticsProperty('key', key));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CallPerformEventSentDTMF &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.key, key) || other.key == key));
  }

  @override
  int get hashCode => Object.hash(runtimeType, uuid, key);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UuidValue uuid, CallkeepHandle handle,
            String? displayName, bool video)
        started,
    required TResult Function(UuidValue uuid) answered,
    required TResult Function(UuidValue uuid) ended,
    required TResult Function(UuidValue uuid, bool onHold) setHeld,
    required TResult Function(UuidValue uuid, bool muted) setMuted,
    required TResult Function(UuidValue uuid, String key) sentDTMF,
  }) {
    return sentDTMF(uuid, key);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UuidValue uuid, CallkeepHandle handle,
            String? displayName, bool video)?
        started,
    TResult? Function(UuidValue uuid)? answered,
    TResult? Function(UuidValue uuid)? ended,
    TResult? Function(UuidValue uuid, bool onHold)? setHeld,
    TResult? Function(UuidValue uuid, bool muted)? setMuted,
    TResult? Function(UuidValue uuid, String key)? sentDTMF,
  }) {
    return sentDTMF?.call(uuid, key);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UuidValue uuid, CallkeepHandle handle, String? displayName,
            bool video)?
        started,
    TResult Function(UuidValue uuid)? answered,
    TResult Function(UuidValue uuid)? ended,
    TResult Function(UuidValue uuid, bool onHold)? setHeld,
    TResult Function(UuidValue uuid, bool muted)? setMuted,
    TResult Function(UuidValue uuid, String key)? sentDTMF,
    required TResult orElse(),
  }) {
    if (sentDTMF != null) {
      return sentDTMF(uuid, key);
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
  factory _CallPerformEventSentDTMF(final UuidValue uuid, final String key) =
      _$_CallPerformEventSentDTMF;
  _CallPerformEventSentDTMF._() : super._();

  @override
  UuidValue get uuid;
  String get key;
}

/// @nodoc
mixin _$_PeerConnectionEvent {
  UuidValue get uuid => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UuidValue uuid, RTCIceGatheringState state)
        iceGatheringStateChanged,
    required TResult Function(UuidValue uuid, RTCIceCandidate candidate)
        iceCandidateIdentified,
    required TResult Function(UuidValue uuid, MediaStream stream) streamAdded,
    required TResult Function(UuidValue uuid, MediaStream stream) streamRemoved,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UuidValue uuid, RTCIceGatheringState state)?
        iceGatheringStateChanged,
    TResult? Function(UuidValue uuid, RTCIceCandidate candidate)?
        iceCandidateIdentified,
    TResult? Function(UuidValue uuid, MediaStream stream)? streamAdded,
    TResult? Function(UuidValue uuid, MediaStream stream)? streamRemoved,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UuidValue uuid, RTCIceGatheringState state)?
        iceGatheringStateChanged,
    TResult Function(UuidValue uuid, RTCIceCandidate candidate)?
        iceCandidateIdentified,
    TResult Function(UuidValue uuid, MediaStream stream)? streamAdded,
    TResult Function(UuidValue uuid, MediaStream stream)? streamRemoved,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(
            _PeerConnectionEventIceGatheringStateChanged value)
        iceGatheringStateChanged,
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
    TResult? Function(_PeerConnectionEventIceGatheringStateChanged value)?
        iceGatheringStateChanged,
    TResult? Function(_PeerConnectionEventIceCandidateIdentified value)?
        iceCandidateIdentified,
    TResult? Function(_PeerConnectionEventStreamAdded value)? streamAdded,
    TResult? Function(_PeerConnectionEventStreamRemoved value)? streamRemoved,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_PeerConnectionEventIceGatheringStateChanged value)?
        iceGatheringStateChanged,
    TResult Function(_PeerConnectionEventIceCandidateIdentified value)?
        iceCandidateIdentified,
    TResult Function(_PeerConnectionEventStreamAdded value)? streamAdded,
    TResult Function(_PeerConnectionEventStreamRemoved value)? streamRemoved,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc

class _$_PeerConnectionEventIceGatheringStateChanged
    with DiagnosticableTreeMixin
    implements _PeerConnectionEventIceGatheringStateChanged {
  const _$_PeerConnectionEventIceGatheringStateChanged(this.uuid, this.state);

  @override
  final UuidValue uuid;
  @override
  final RTCIceGatheringState state;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_PeerConnectionEvent.iceGatheringStateChanged(uuid: $uuid, state: $state)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty(
          'type', '_PeerConnectionEvent.iceGatheringStateChanged'))
      ..add(DiagnosticsProperty('uuid', uuid))
      ..add(DiagnosticsProperty('state', state));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PeerConnectionEventIceGatheringStateChanged &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.state, state) || other.state == state));
  }

  @override
  int get hashCode => Object.hash(runtimeType, uuid, state);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UuidValue uuid, RTCIceGatheringState state)
        iceGatheringStateChanged,
    required TResult Function(UuidValue uuid, RTCIceCandidate candidate)
        iceCandidateIdentified,
    required TResult Function(UuidValue uuid, MediaStream stream) streamAdded,
    required TResult Function(UuidValue uuid, MediaStream stream) streamRemoved,
  }) {
    return iceGatheringStateChanged(uuid, state);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UuidValue uuid, RTCIceGatheringState state)?
        iceGatheringStateChanged,
    TResult? Function(UuidValue uuid, RTCIceCandidate candidate)?
        iceCandidateIdentified,
    TResult? Function(UuidValue uuid, MediaStream stream)? streamAdded,
    TResult? Function(UuidValue uuid, MediaStream stream)? streamRemoved,
  }) {
    return iceGatheringStateChanged?.call(uuid, state);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UuidValue uuid, RTCIceGatheringState state)?
        iceGatheringStateChanged,
    TResult Function(UuidValue uuid, RTCIceCandidate candidate)?
        iceCandidateIdentified,
    TResult Function(UuidValue uuid, MediaStream stream)? streamAdded,
    TResult Function(UuidValue uuid, MediaStream stream)? streamRemoved,
    required TResult orElse(),
  }) {
    if (iceGatheringStateChanged != null) {
      return iceGatheringStateChanged(uuid, state);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(
            _PeerConnectionEventIceGatheringStateChanged value)
        iceGatheringStateChanged,
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
    TResult? Function(_PeerConnectionEventIceGatheringStateChanged value)?
        iceGatheringStateChanged,
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
    TResult Function(_PeerConnectionEventIceGatheringStateChanged value)?
        iceGatheringStateChanged,
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
          final UuidValue uuid, final RTCIceGatheringState state) =
      _$_PeerConnectionEventIceGatheringStateChanged;

  @override
  UuidValue get uuid;
  RTCIceGatheringState get state;
}

/// @nodoc

class _$_PeerConnectionEventIceCandidateIdentified
    with DiagnosticableTreeMixin
    implements _PeerConnectionEventIceCandidateIdentified {
  const _$_PeerConnectionEventIceCandidateIdentified(this.uuid, this.candidate);

  @override
  final UuidValue uuid;
  @override
  final RTCIceCandidate candidate;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_PeerConnectionEvent.iceCandidateIdentified(uuid: $uuid, candidate: $candidate)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty(
          'type', '_PeerConnectionEvent.iceCandidateIdentified'))
      ..add(DiagnosticsProperty('uuid', uuid))
      ..add(DiagnosticsProperty('candidate', candidate));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PeerConnectionEventIceCandidateIdentified &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.candidate, candidate) ||
                other.candidate == candidate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, uuid, candidate);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UuidValue uuid, RTCIceGatheringState state)
        iceGatheringStateChanged,
    required TResult Function(UuidValue uuid, RTCIceCandidate candidate)
        iceCandidateIdentified,
    required TResult Function(UuidValue uuid, MediaStream stream) streamAdded,
    required TResult Function(UuidValue uuid, MediaStream stream) streamRemoved,
  }) {
    return iceCandidateIdentified(uuid, candidate);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UuidValue uuid, RTCIceGatheringState state)?
        iceGatheringStateChanged,
    TResult? Function(UuidValue uuid, RTCIceCandidate candidate)?
        iceCandidateIdentified,
    TResult? Function(UuidValue uuid, MediaStream stream)? streamAdded,
    TResult? Function(UuidValue uuid, MediaStream stream)? streamRemoved,
  }) {
    return iceCandidateIdentified?.call(uuid, candidate);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UuidValue uuid, RTCIceGatheringState state)?
        iceGatheringStateChanged,
    TResult Function(UuidValue uuid, RTCIceCandidate candidate)?
        iceCandidateIdentified,
    TResult Function(UuidValue uuid, MediaStream stream)? streamAdded,
    TResult Function(UuidValue uuid, MediaStream stream)? streamRemoved,
    required TResult orElse(),
  }) {
    if (iceCandidateIdentified != null) {
      return iceCandidateIdentified(uuid, candidate);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(
            _PeerConnectionEventIceGatheringStateChanged value)
        iceGatheringStateChanged,
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
    TResult? Function(_PeerConnectionEventIceGatheringStateChanged value)?
        iceGatheringStateChanged,
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
    TResult Function(_PeerConnectionEventIceGatheringStateChanged value)?
        iceGatheringStateChanged,
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
          final UuidValue uuid, final RTCIceCandidate candidate) =
      _$_PeerConnectionEventIceCandidateIdentified;

  @override
  UuidValue get uuid;
  RTCIceCandidate get candidate;
}

/// @nodoc

class _$_PeerConnectionEventStreamAdded
    with DiagnosticableTreeMixin
    implements _PeerConnectionEventStreamAdded {
  const _$_PeerConnectionEventStreamAdded(this.uuid, this.stream);

  @override
  final UuidValue uuid;
  @override
  final MediaStream stream;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_PeerConnectionEvent.streamAdded(uuid: $uuid, stream: $stream)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', '_PeerConnectionEvent.streamAdded'))
      ..add(DiagnosticsProperty('uuid', uuid))
      ..add(DiagnosticsProperty('stream', stream));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PeerConnectionEventStreamAdded &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.stream, stream) || other.stream == stream));
  }

  @override
  int get hashCode => Object.hash(runtimeType, uuid, stream);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UuidValue uuid, RTCIceGatheringState state)
        iceGatheringStateChanged,
    required TResult Function(UuidValue uuid, RTCIceCandidate candidate)
        iceCandidateIdentified,
    required TResult Function(UuidValue uuid, MediaStream stream) streamAdded,
    required TResult Function(UuidValue uuid, MediaStream stream) streamRemoved,
  }) {
    return streamAdded(uuid, stream);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UuidValue uuid, RTCIceGatheringState state)?
        iceGatheringStateChanged,
    TResult? Function(UuidValue uuid, RTCIceCandidate candidate)?
        iceCandidateIdentified,
    TResult? Function(UuidValue uuid, MediaStream stream)? streamAdded,
    TResult? Function(UuidValue uuid, MediaStream stream)? streamRemoved,
  }) {
    return streamAdded?.call(uuid, stream);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UuidValue uuid, RTCIceGatheringState state)?
        iceGatheringStateChanged,
    TResult Function(UuidValue uuid, RTCIceCandidate candidate)?
        iceCandidateIdentified,
    TResult Function(UuidValue uuid, MediaStream stream)? streamAdded,
    TResult Function(UuidValue uuid, MediaStream stream)? streamRemoved,
    required TResult orElse(),
  }) {
    if (streamAdded != null) {
      return streamAdded(uuid, stream);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(
            _PeerConnectionEventIceGatheringStateChanged value)
        iceGatheringStateChanged,
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
    TResult? Function(_PeerConnectionEventIceGatheringStateChanged value)?
        iceGatheringStateChanged,
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
    TResult Function(_PeerConnectionEventIceGatheringStateChanged value)?
        iceGatheringStateChanged,
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
          final UuidValue uuid, final MediaStream stream) =
      _$_PeerConnectionEventStreamAdded;

  @override
  UuidValue get uuid;
  MediaStream get stream;
}

/// @nodoc

class _$_PeerConnectionEventStreamRemoved
    with DiagnosticableTreeMixin
    implements _PeerConnectionEventStreamRemoved {
  const _$_PeerConnectionEventStreamRemoved(this.uuid, this.stream);

  @override
  final UuidValue uuid;
  @override
  final MediaStream stream;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_PeerConnectionEvent.streamRemoved(uuid: $uuid, stream: $stream)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', '_PeerConnectionEvent.streamRemoved'))
      ..add(DiagnosticsProperty('uuid', uuid))
      ..add(DiagnosticsProperty('stream', stream));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PeerConnectionEventStreamRemoved &&
            (identical(other.uuid, uuid) || other.uuid == uuid) &&
            (identical(other.stream, stream) || other.stream == stream));
  }

  @override
  int get hashCode => Object.hash(runtimeType, uuid, stream);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UuidValue uuid, RTCIceGatheringState state)
        iceGatheringStateChanged,
    required TResult Function(UuidValue uuid, RTCIceCandidate candidate)
        iceCandidateIdentified,
    required TResult Function(UuidValue uuid, MediaStream stream) streamAdded,
    required TResult Function(UuidValue uuid, MediaStream stream) streamRemoved,
  }) {
    return streamRemoved(uuid, stream);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UuidValue uuid, RTCIceGatheringState state)?
        iceGatheringStateChanged,
    TResult? Function(UuidValue uuid, RTCIceCandidate candidate)?
        iceCandidateIdentified,
    TResult? Function(UuidValue uuid, MediaStream stream)? streamAdded,
    TResult? Function(UuidValue uuid, MediaStream stream)? streamRemoved,
  }) {
    return streamRemoved?.call(uuid, stream);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UuidValue uuid, RTCIceGatheringState state)?
        iceGatheringStateChanged,
    TResult Function(UuidValue uuid, RTCIceCandidate candidate)?
        iceCandidateIdentified,
    TResult Function(UuidValue uuid, MediaStream stream)? streamAdded,
    TResult Function(UuidValue uuid, MediaStream stream)? streamRemoved,
    required TResult orElse(),
  }) {
    if (streamRemoved != null) {
      return streamRemoved(uuid, stream);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(
            _PeerConnectionEventIceGatheringStateChanged value)
        iceGatheringStateChanged,
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
    TResult? Function(_PeerConnectionEventIceGatheringStateChanged value)?
        iceGatheringStateChanged,
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
    TResult Function(_PeerConnectionEventIceGatheringStateChanged value)?
        iceGatheringStateChanged,
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
          final UuidValue uuid, final MediaStream stream) =
      _$_PeerConnectionEventStreamRemoved;

  @override
  UuidValue get uuid;
  MediaStream get stream;
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
      speaker: freezed == speaker
          ? _value.speaker
          : speaker // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CallStateCopyWith<$Res> implements $CallStateCopyWith<$Res> {
  factory _$$_CallStateCopyWith(
          _$_CallState value, $Res Function(_$_CallState) then) =
      __$$_CallStateCopyWithImpl<$Res>;
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
      bool? speaker});
}

/// @nodoc
class __$$_CallStateCopyWithImpl<$Res>
    extends _$CallStateCopyWithImpl<$Res, _$_CallState>
    implements _$$_CallStateCopyWith<$Res> {
  __$$_CallStateCopyWithImpl(
      _$_CallState _value, $Res Function(_$_CallState) _then)
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
    Object? speaker = freezed,
  }) {
    return _then(_$_CallState(
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
      speaker: freezed == speaker
          ? _value.speaker
          : speaker // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

class _$_CallState extends _CallState with DiagnosticableTreeMixin {
  const _$_CallState(
      {this.currentConnectivityResult,
      this.signalingClientStatus = SignalingClientStatus.disconnect,
      this.lastSignalingClientConnectError,
      this.lastSignalingClientDisconnectError,
      this.lastSignalingDisconnectCode,
      this.linesCount = 0,
      final List<ActiveCall> activeCalls = const [],
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
  final bool? speaker;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallState(currentConnectivityResult: $currentConnectivityResult, signalingClientStatus: $signalingClientStatus, lastSignalingClientConnectError: $lastSignalingClientConnectError, lastSignalingClientDisconnectError: $lastSignalingClientDisconnectError, lastSignalingDisconnectCode: $lastSignalingDisconnectCode, linesCount: $linesCount, activeCalls: $activeCalls, speaker: $speaker)';
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
      ..add(DiagnosticsProperty('speaker', speaker));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CallState &&
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
      speaker);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CallStateCopyWith<_$_CallState> get copyWith =>
      __$$_CallStateCopyWithImpl<_$_CallState>(this, _$identity);
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
      final bool? speaker}) = _$_CallState;
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
  bool? get speaker;
  @override
  @JsonKey(ignore: true)
  _$$_CallStateCopyWith<_$_CallState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ActiveCall {
  Direction get direction => throw _privateConstructorUsedError;
  int get line => throw _privateConstructorUsedError;
  CallIdValue get callId => throw _privateConstructorUsedError;
  CallkeepHandle get handle => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  bool get video => throw _privateConstructorUsedError;
  bool? get frontCamera => throw _privateConstructorUsedError;
  bool get held => throw _privateConstructorUsedError;
  bool get muted => throw _privateConstructorUsedError;
  DateTime get createdTime => throw _privateConstructorUsedError;
  DateTime? get acceptedTime => throw _privateConstructorUsedError;
  DateTime? get hungUpTime => throw _privateConstructorUsedError;
  Object? get failure => throw _privateConstructorUsedError;
  MediaStream? get localStream => throw _privateConstructorUsedError;
  MediaStream? get remoteStream => throw _privateConstructorUsedError;

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
      CallIdValue callId,
      CallkeepHandle handle,
      String? displayName,
      bool video,
      bool? frontCamera,
      bool held,
      bool muted,
      DateTime createdTime,
      DateTime? acceptedTime,
      DateTime? hungUpTime,
      Object? failure,
      MediaStream? localStream,
      MediaStream? remoteStream});
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
    Object? createdTime = null,
    Object? acceptedTime = freezed,
    Object? hungUpTime = freezed,
    Object? failure = freezed,
    Object? localStream = freezed,
    Object? remoteStream = freezed,
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
              as CallIdValue,
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
}

/// @nodoc
abstract class _$$_ActiveCallCopyWith<$Res>
    implements $ActiveCallCopyWith<$Res> {
  factory _$$_ActiveCallCopyWith(
          _$_ActiveCall value, $Res Function(_$_ActiveCall) then) =
      __$$_ActiveCallCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Direction direction,
      int line,
      CallIdValue callId,
      CallkeepHandle handle,
      String? displayName,
      bool video,
      bool? frontCamera,
      bool held,
      bool muted,
      DateTime createdTime,
      DateTime? acceptedTime,
      DateTime? hungUpTime,
      Object? failure,
      MediaStream? localStream,
      MediaStream? remoteStream});
}

/// @nodoc
class __$$_ActiveCallCopyWithImpl<$Res>
    extends _$ActiveCallCopyWithImpl<$Res, _$_ActiveCall>
    implements _$$_ActiveCallCopyWith<$Res> {
  __$$_ActiveCallCopyWithImpl(
      _$_ActiveCall _value, $Res Function(_$_ActiveCall) _then)
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
    Object? createdTime = null,
    Object? acceptedTime = freezed,
    Object? hungUpTime = freezed,
    Object? failure = freezed,
    Object? localStream = freezed,
    Object? remoteStream = freezed,
  }) {
    return _then(_$_ActiveCall(
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
              as CallIdValue,
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

class _$_ActiveCall extends _ActiveCall with DiagnosticableTreeMixin {
  const _$_ActiveCall(
      {required this.direction,
      required this.line,
      required this.callId,
      required this.handle,
      this.displayName,
      required this.video,
      this.frontCamera = true,
      this.held = false,
      this.muted = false,
      required this.createdTime,
      this.acceptedTime,
      this.hungUpTime,
      this.failure,
      this.localStream,
      this.remoteStream})
      : super._();

  @override
  final Direction direction;
  @override
  final int line;
  @override
  final CallIdValue callId;
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
  final DateTime createdTime;
  @override
  final DateTime? acceptedTime;
  @override
  final DateTime? hungUpTime;
  @override
  final Object? failure;
  @override
  final MediaStream? localStream;
  @override
  final MediaStream? remoteStream;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ActiveCall(direction: $direction, line: $line, callId: $callId, handle: $handle, displayName: $displayName, video: $video, frontCamera: $frontCamera, held: $held, muted: $muted, createdTime: $createdTime, acceptedTime: $acceptedTime, hungUpTime: $hungUpTime, failure: $failure, localStream: $localStream, remoteStream: $remoteStream)';
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
      ..add(DiagnosticsProperty('createdTime', createdTime))
      ..add(DiagnosticsProperty('acceptedTime', acceptedTime))
      ..add(DiagnosticsProperty('hungUpTime', hungUpTime))
      ..add(DiagnosticsProperty('failure', failure))
      ..add(DiagnosticsProperty('localStream', localStream))
      ..add(DiagnosticsProperty('remoteStream', remoteStream));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ActiveCall &&
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
            (identical(other.createdTime, createdTime) ||
                other.createdTime == createdTime) &&
            (identical(other.acceptedTime, acceptedTime) ||
                other.acceptedTime == acceptedTime) &&
            (identical(other.hungUpTime, hungUpTime) ||
                other.hungUpTime == hungUpTime) &&
            const DeepCollectionEquality().equals(other.failure, failure) &&
            (identical(other.localStream, localStream) ||
                other.localStream == localStream) &&
            (identical(other.remoteStream, remoteStream) ||
                other.remoteStream == remoteStream));
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
      createdTime,
      acceptedTime,
      hungUpTime,
      const DeepCollectionEquality().hash(failure),
      localStream,
      remoteStream);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ActiveCallCopyWith<_$_ActiveCall> get copyWith =>
      __$$_ActiveCallCopyWithImpl<_$_ActiveCall>(this, _$identity);
}

abstract class _ActiveCall extends ActiveCall {
  const factory _ActiveCall(
      {required final Direction direction,
      required final int line,
      required final CallIdValue callId,
      required final CallkeepHandle handle,
      final String? displayName,
      required final bool video,
      final bool? frontCamera,
      final bool held,
      final bool muted,
      required final DateTime createdTime,
      final DateTime? acceptedTime,
      final DateTime? hungUpTime,
      final Object? failure,
      final MediaStream? localStream,
      final MediaStream? remoteStream}) = _$_ActiveCall;
  const _ActiveCall._() : super._();

  @override
  Direction get direction;
  @override
  int get line;
  @override
  CallIdValue get callId;
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
  DateTime get createdTime;
  @override
  DateTime? get acceptedTime;
  @override
  DateTime? get hungUpTime;
  @override
  Object? get failure;
  @override
  MediaStream? get localStream;
  @override
  MediaStream? get remoteStream;
  @override
  @JsonKey(ignore: true)
  _$$_ActiveCallCopyWith<_$_ActiveCall> get copyWith =>
      throw _privateConstructorUsedError;
}
