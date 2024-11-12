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
mixin _$RegistrationChange {
  Registration get registration => throw _privateConstructorUsedError;
}

/// @nodoc

class _$_RegistrationChangeImpl
    with DiagnosticableTreeMixin
    implements __RegistrationChange {
  const _$_RegistrationChangeImpl({required this.registration});

  @override
  final Registration registration;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_RegistrationChange(registration: $registration)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', '_RegistrationChange'))
      ..add(DiagnosticsProperty('registration', registration));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RegistrationChangeImpl &&
            (identical(other.registration, registration) ||
                other.registration == registration));
  }

  @override
  int get hashCode => Object.hash(runtimeType, registration);
}

abstract class __RegistrationChange implements _RegistrationChange {
  const factory __RegistrationChange(
      {required final Registration registration}) = _$_RegistrationChangeImpl;

  @override
  Registration get registration;
}

/// @nodoc
mixin _$ResetStateEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() completeCalls,
    required TResult Function(String callId) completeCall,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? completeCalls,
    TResult? Function(String callId)? completeCall,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? completeCalls,
    TResult Function(String callId)? completeCall,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ResetStateEventCompleteCalls value)
        completeCalls,
    required TResult Function(_ResetStateEventCompleteCall value) completeCall,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ResetStateEventCompleteCalls value)? completeCalls,
    TResult? Function(_ResetStateEventCompleteCall value)? completeCall,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ResetStateEventCompleteCalls value)? completeCalls,
    TResult Function(_ResetStateEventCompleteCall value)? completeCall,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc

class _$ResetStateEventCompleteCallsImpl
    with DiagnosticableTreeMixin
    implements _ResetStateEventCompleteCalls {
  const _$ResetStateEventCompleteCallsImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_ResetStateEvent.completeCalls()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DiagnosticsProperty('type', '_ResetStateEvent.completeCalls'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResetStateEventCompleteCallsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() completeCalls,
    required TResult Function(String callId) completeCall,
  }) {
    return completeCalls();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? completeCalls,
    TResult? Function(String callId)? completeCall,
  }) {
    return completeCalls?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? completeCalls,
    TResult Function(String callId)? completeCall,
    required TResult orElse(),
  }) {
    if (completeCalls != null) {
      return completeCalls();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ResetStateEventCompleteCalls value)
        completeCalls,
    required TResult Function(_ResetStateEventCompleteCall value) completeCall,
  }) {
    return completeCalls(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ResetStateEventCompleteCalls value)? completeCalls,
    TResult? Function(_ResetStateEventCompleteCall value)? completeCall,
  }) {
    return completeCalls?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ResetStateEventCompleteCalls value)? completeCalls,
    TResult Function(_ResetStateEventCompleteCall value)? completeCall,
    required TResult orElse(),
  }) {
    if (completeCalls != null) {
      return completeCalls(this);
    }
    return orElse();
  }
}

abstract class _ResetStateEventCompleteCalls implements _ResetStateEvent {
  const factory _ResetStateEventCompleteCalls() =
      _$ResetStateEventCompleteCallsImpl;
}

/// @nodoc

class _$ResetStateEventCompleteCallImpl
    with DiagnosticableTreeMixin
    implements _ResetStateEventCompleteCall {
  const _$ResetStateEventCompleteCallImpl(this.callId);

  @override
  final String callId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_ResetStateEvent.completeCall(callId: $callId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', '_ResetStateEvent.completeCall'))
      ..add(DiagnosticsProperty('callId', callId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResetStateEventCompleteCallImpl &&
            (identical(other.callId, callId) || other.callId == callId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callId);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() completeCalls,
    required TResult Function(String callId) completeCall,
  }) {
    return completeCall(callId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? completeCalls,
    TResult? Function(String callId)? completeCall,
  }) {
    return completeCall?.call(callId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? completeCalls,
    TResult Function(String callId)? completeCall,
    required TResult orElse(),
  }) {
    if (completeCall != null) {
      return completeCall(callId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ResetStateEventCompleteCalls value)
        completeCalls,
    required TResult Function(_ResetStateEventCompleteCall value) completeCall,
  }) {
    return completeCall(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ResetStateEventCompleteCalls value)? completeCalls,
    TResult? Function(_ResetStateEventCompleteCall value)? completeCall,
  }) {
    return completeCall?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ResetStateEventCompleteCalls value)? completeCalls,
    TResult Function(_ResetStateEventCompleteCall value)? completeCall,
    required TResult orElse(),
  }) {
    if (completeCall != null) {
      return completeCall(this);
    }
    return orElse();
  }
}

abstract class _ResetStateEventCompleteCall implements _ResetStateEvent {
  const factory _ResetStateEventCompleteCall(final String callId) =
      _$ResetStateEventCompleteCallImpl;

  String get callId;
}

/// @nodoc
mixin _$SignalingClientEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool reconnecting) connectInitiated,
    required TResult Function() disconnectInitiated,
    required TResult Function(int? code, String? reason, bool afterReconnect)
        disconnected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool reconnecting)? connectInitiated,
    TResult? Function()? disconnectInitiated,
    TResult? Function(int? code, String? reason, bool afterReconnect)?
        disconnected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool reconnecting)? connectInitiated,
    TResult Function()? disconnectInitiated,
    TResult Function(int? code, String? reason, bool afterReconnect)?
        disconnected,
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
  const _$SignalingClientEventConnectInitiatedImpl({this.reconnecting = false});

  @override
  @JsonKey()
  final bool reconnecting;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_SignalingClientEvent.connectInitiated(reconnecting: $reconnecting)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
          DiagnosticsProperty('type', '_SignalingClientEvent.connectInitiated'))
      ..add(DiagnosticsProperty('reconnecting', reconnecting));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignalingClientEventConnectInitiatedImpl &&
            (identical(other.reconnecting, reconnecting) ||
                other.reconnecting == reconnecting));
  }

  @override
  int get hashCode => Object.hash(runtimeType, reconnecting);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool reconnecting) connectInitiated,
    required TResult Function() disconnectInitiated,
    required TResult Function(int? code, String? reason, bool afterReconnect)
        disconnected,
  }) {
    return connectInitiated(reconnecting);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool reconnecting)? connectInitiated,
    TResult? Function()? disconnectInitiated,
    TResult? Function(int? code, String? reason, bool afterReconnect)?
        disconnected,
  }) {
    return connectInitiated?.call(reconnecting);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool reconnecting)? connectInitiated,
    TResult Function()? disconnectInitiated,
    TResult Function(int? code, String? reason, bool afterReconnect)?
        disconnected,
    required TResult orElse(),
  }) {
    if (connectInitiated != null) {
      return connectInitiated(reconnecting);
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
  const factory _SignalingClientEventConnectInitiated(
      {final bool reconnecting}) = _$SignalingClientEventConnectInitiatedImpl;

  bool get reconnecting;
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
    required TResult Function(bool reconnecting) connectInitiated,
    required TResult Function() disconnectInitiated,
    required TResult Function(int? code, String? reason, bool afterReconnect)
        disconnected,
  }) {
    return disconnectInitiated();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool reconnecting)? connectInitiated,
    TResult? Function()? disconnectInitiated,
    TResult? Function(int? code, String? reason, bool afterReconnect)?
        disconnected,
  }) {
    return disconnectInitiated?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool reconnecting)? connectInitiated,
    TResult Function()? disconnectInitiated,
    TResult Function(int? code, String? reason, bool afterReconnect)?
        disconnected,
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
  const _$SignalingClientEventDisconnectedImpl(this.code, this.reason,
      {this.afterReconnect = false});

  @override
  final int? code;
  @override
  final String? reason;
  @override
  @JsonKey()
  final bool afterReconnect;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_SignalingClientEvent.disconnected(code: $code, reason: $reason, afterReconnect: $afterReconnect)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', '_SignalingClientEvent.disconnected'))
      ..add(DiagnosticsProperty('code', code))
      ..add(DiagnosticsProperty('reason', reason))
      ..add(DiagnosticsProperty('afterReconnect', afterReconnect));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignalingClientEventDisconnectedImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.afterReconnect, afterReconnect) ||
                other.afterReconnect == afterReconnect));
  }

  @override
  int get hashCode => Object.hash(runtimeType, code, reason, afterReconnect);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool reconnecting) connectInitiated,
    required TResult Function() disconnectInitiated,
    required TResult Function(int? code, String? reason, bool afterReconnect)
        disconnected,
  }) {
    return disconnected(code, reason, afterReconnect);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool reconnecting)? connectInitiated,
    TResult? Function()? disconnectInitiated,
    TResult? Function(int? code, String? reason, bool afterReconnect)?
        disconnected,
  }) {
    return disconnected?.call(code, reason, afterReconnect);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool reconnecting)? connectInitiated,
    TResult Function()? disconnectInitiated,
    TResult Function(int? code, String? reason, bool afterReconnect)?
        disconnected,
    required TResult orElse(),
  }) {
    if (disconnected != null) {
      return disconnected(code, reason, afterReconnect);
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
          final int? code, final String? reason, {final bool afterReconnect}) =
      _$SignalingClientEventDisconnectedImpl;

  int? get code;
  String? get reason;
  bool get afterReconnect;
}

/// @nodoc
mixin _$HandshakeSignalingEvent {
  Registration get registration => throw _privateConstructorUsedError;
  int get linesCount => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Registration registration, int linesCount) state,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Registration registration, int linesCount)? state,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Registration registration, int linesCount)? state,
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
  const _$HandshakeSignalingEventStateImpl(
      {required this.registration, required this.linesCount});

  @override
  final Registration registration;
  @override
  final int linesCount;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_HandshakeSignalingEvent.state(registration: $registration, linesCount: $linesCount)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', '_HandshakeSignalingEvent.state'))
      ..add(DiagnosticsProperty('registration', registration))
      ..add(DiagnosticsProperty('linesCount', linesCount));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HandshakeSignalingEventStateImpl &&
            (identical(other.registration, registration) ||
                other.registration == registration) &&
            (identical(other.linesCount, linesCount) ||
                other.linesCount == linesCount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, registration, linesCount);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Registration registration, int linesCount) state,
  }) {
    return state(registration, linesCount);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Registration registration, int linesCount)? state,
  }) {
    return state?.call(registration, linesCount);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Registration registration, int linesCount)? state,
    required TResult orElse(),
  }) {
    if (state != null) {
      return state(registration, linesCount);
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
  const factory _HandshakeSignalingEventState(
      {required final Registration registration,
      required final int linesCount}) = _$HandshakeSignalingEventStateImpl;

  @override
  Registration get registration;
  @override
  int get linesCount;
}

/// @nodoc
mixin _$CallSignalingEvent {
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
    required TResult Function(int line, String referId, String referTo,
            String? referredBy, String? replaceCallId)
        transfer,
    required TResult Function(
            int line,
            String callId,
            String? notify,
            SubscriptionState? subscriptionState,
            String? contentType,
            String content)
        notify,
    required TResult Function() registering,
    required TResult Function() registered,
    required TResult Function(int code, String reason) registrationFailed,
    required TResult Function() unregistering,
    required TResult Function() unregistered,
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
    TResult? Function(int line, String referId, String referTo,
            String? referredBy, String? replaceCallId)?
        transfer,
    TResult? Function(
            int line,
            String callId,
            String? notify,
            SubscriptionState? subscriptionState,
            String? contentType,
            String content)?
        notify,
    TResult? Function()? registering,
    TResult? Function()? registered,
    TResult? Function(int code, String reason)? registrationFailed,
    TResult? Function()? unregistering,
    TResult? Function()? unregistered,
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
    TResult Function(int line, String referId, String referTo,
            String? referredBy, String? replaceCallId)?
        transfer,
    TResult Function(
            int line,
            String callId,
            String? notify,
            SubscriptionState? subscriptionState,
            String? contentType,
            String content)?
        notify,
    TResult Function()? registering,
    TResult Function()? registered,
    TResult Function(int code, String reason)? registrationFailed,
    TResult Function()? unregistering,
    TResult Function()? unregistered,
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
    required TResult Function(_CallSignalingEventTransfer value) transfer,
    required TResult Function(_CallSignalingEventNotify value) notify,
    required TResult Function(_CallSignalingEventRegistering value) registering,
    required TResult Function(_CallSignalingEventRegistered value) registered,
    required TResult Function(_CallSignalingEventRegisterationFailed value)
        registrationFailed,
    required TResult Function(_CallSignalingEventUnregistering value)
        unregistering,
    required TResult Function(_CallSignalingEventUnregistered value)
        unregistered,
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
    TResult? Function(_CallSignalingEventTransfer value)? transfer,
    TResult? Function(_CallSignalingEventNotify value)? notify,
    TResult? Function(_CallSignalingEventRegistering value)? registering,
    TResult? Function(_CallSignalingEventRegistered value)? registered,
    TResult? Function(_CallSignalingEventRegisterationFailed value)?
        registrationFailed,
    TResult? Function(_CallSignalingEventUnregistering value)? unregistering,
    TResult? Function(_CallSignalingEventUnregistered value)? unregistered,
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
    TResult Function(_CallSignalingEventTransfer value)? transfer,
    TResult Function(_CallSignalingEventNotify value)? notify,
    TResult Function(_CallSignalingEventRegistering value)? registering,
    TResult Function(_CallSignalingEventRegistered value)? registered,
    TResult Function(_CallSignalingEventRegisterationFailed value)?
        registrationFailed,
    TResult Function(_CallSignalingEventUnregistering value)? unregistering,
    TResult Function(_CallSignalingEventUnregistered value)? unregistered,
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
    required TResult Function(int line, String referId, String referTo,
            String? referredBy, String? replaceCallId)
        transfer,
    required TResult Function(
            int line,
            String callId,
            String? notify,
            SubscriptionState? subscriptionState,
            String? contentType,
            String content)
        notify,
    required TResult Function() registering,
    required TResult Function() registered,
    required TResult Function(int code, String reason) registrationFailed,
    required TResult Function() unregistering,
    required TResult Function() unregistered,
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
    TResult? Function(int line, String referId, String referTo,
            String? referredBy, String? replaceCallId)?
        transfer,
    TResult? Function(
            int line,
            String callId,
            String? notify,
            SubscriptionState? subscriptionState,
            String? contentType,
            String content)?
        notify,
    TResult? Function()? registering,
    TResult? Function()? registered,
    TResult? Function(int code, String reason)? registrationFailed,
    TResult? Function()? unregistering,
    TResult? Function()? unregistered,
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
    TResult Function(int line, String referId, String referTo,
            String? referredBy, String? replaceCallId)?
        transfer,
    TResult Function(
            int line,
            String callId,
            String? notify,
            SubscriptionState? subscriptionState,
            String? contentType,
            String content)?
        notify,
    TResult Function()? registering,
    TResult Function()? registered,
    TResult Function(int code, String reason)? registrationFailed,
    TResult Function()? unregistering,
    TResult Function()? unregistered,
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
    required TResult Function(_CallSignalingEventTransfer value) transfer,
    required TResult Function(_CallSignalingEventNotify value) notify,
    required TResult Function(_CallSignalingEventRegistering value) registering,
    required TResult Function(_CallSignalingEventRegistered value) registered,
    required TResult Function(_CallSignalingEventRegisterationFailed value)
        registrationFailed,
    required TResult Function(_CallSignalingEventUnregistering value)
        unregistering,
    required TResult Function(_CallSignalingEventUnregistered value)
        unregistered,
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
    TResult? Function(_CallSignalingEventTransfer value)? transfer,
    TResult? Function(_CallSignalingEventNotify value)? notify,
    TResult? Function(_CallSignalingEventRegistering value)? registering,
    TResult? Function(_CallSignalingEventRegistered value)? registered,
    TResult? Function(_CallSignalingEventRegisterationFailed value)?
        registrationFailed,
    TResult? Function(_CallSignalingEventUnregistering value)? unregistering,
    TResult? Function(_CallSignalingEventUnregistered value)? unregistered,
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
    TResult Function(_CallSignalingEventTransfer value)? transfer,
    TResult Function(_CallSignalingEventNotify value)? notify,
    TResult Function(_CallSignalingEventRegistering value)? registering,
    TResult Function(_CallSignalingEventRegistered value)? registered,
    TResult Function(_CallSignalingEventRegisterationFailed value)?
        registrationFailed,
    TResult Function(_CallSignalingEventUnregistering value)? unregistering,
    TResult Function(_CallSignalingEventUnregistered value)? unregistered,
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

  int get line;
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
    required TResult Function(int line, String referId, String referTo,
            String? referredBy, String? replaceCallId)
        transfer,
    required TResult Function(
            int line,
            String callId,
            String? notify,
            SubscriptionState? subscriptionState,
            String? contentType,
            String content)
        notify,
    required TResult Function() registering,
    required TResult Function() registered,
    required TResult Function(int code, String reason) registrationFailed,
    required TResult Function() unregistering,
    required TResult Function() unregistered,
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
    TResult? Function(int line, String referId, String referTo,
            String? referredBy, String? replaceCallId)?
        transfer,
    TResult? Function(
            int line,
            String callId,
            String? notify,
            SubscriptionState? subscriptionState,
            String? contentType,
            String content)?
        notify,
    TResult? Function()? registering,
    TResult? Function()? registered,
    TResult? Function(int code, String reason)? registrationFailed,
    TResult? Function()? unregistering,
    TResult? Function()? unregistered,
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
    TResult Function(int line, String referId, String referTo,
            String? referredBy, String? replaceCallId)?
        transfer,
    TResult Function(
            int line,
            String callId,
            String? notify,
            SubscriptionState? subscriptionState,
            String? contentType,
            String content)?
        notify,
    TResult Function()? registering,
    TResult Function()? registered,
    TResult Function(int code, String reason)? registrationFailed,
    TResult Function()? unregistering,
    TResult Function()? unregistered,
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
    required TResult Function(_CallSignalingEventTransfer value) transfer,
    required TResult Function(_CallSignalingEventNotify value) notify,
    required TResult Function(_CallSignalingEventRegistering value) registering,
    required TResult Function(_CallSignalingEventRegistered value) registered,
    required TResult Function(_CallSignalingEventRegisterationFailed value)
        registrationFailed,
    required TResult Function(_CallSignalingEventUnregistering value)
        unregistering,
    required TResult Function(_CallSignalingEventUnregistered value)
        unregistered,
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
    TResult? Function(_CallSignalingEventTransfer value)? transfer,
    TResult? Function(_CallSignalingEventNotify value)? notify,
    TResult? Function(_CallSignalingEventRegistering value)? registering,
    TResult? Function(_CallSignalingEventRegistered value)? registered,
    TResult? Function(_CallSignalingEventRegisterationFailed value)?
        registrationFailed,
    TResult? Function(_CallSignalingEventUnregistering value)? unregistering,
    TResult? Function(_CallSignalingEventUnregistered value)? unregistered,
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
    TResult Function(_CallSignalingEventTransfer value)? transfer,
    TResult Function(_CallSignalingEventNotify value)? notify,
    TResult Function(_CallSignalingEventRegistering value)? registering,
    TResult Function(_CallSignalingEventRegistered value)? registered,
    TResult Function(_CallSignalingEventRegisterationFailed value)?
        registrationFailed,
    TResult Function(_CallSignalingEventUnregistering value)? unregistering,
    TResult Function(_CallSignalingEventUnregistered value)? unregistered,
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

  int get line;
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
    required TResult Function(int line, String referId, String referTo,
            String? referredBy, String? replaceCallId)
        transfer,
    required TResult Function(
            int line,
            String callId,
            String? notify,
            SubscriptionState? subscriptionState,
            String? contentType,
            String content)
        notify,
    required TResult Function() registering,
    required TResult Function() registered,
    required TResult Function(int code, String reason) registrationFailed,
    required TResult Function() unregistering,
    required TResult Function() unregistered,
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
    TResult? Function(int line, String referId, String referTo,
            String? referredBy, String? replaceCallId)?
        transfer,
    TResult? Function(
            int line,
            String callId,
            String? notify,
            SubscriptionState? subscriptionState,
            String? contentType,
            String content)?
        notify,
    TResult? Function()? registering,
    TResult? Function()? registered,
    TResult? Function(int code, String reason)? registrationFailed,
    TResult? Function()? unregistering,
    TResult? Function()? unregistered,
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
    TResult Function(int line, String referId, String referTo,
            String? referredBy, String? replaceCallId)?
        transfer,
    TResult Function(
            int line,
            String callId,
            String? notify,
            SubscriptionState? subscriptionState,
            String? contentType,
            String content)?
        notify,
    TResult Function()? registering,
    TResult Function()? registered,
    TResult Function(int code, String reason)? registrationFailed,
    TResult Function()? unregistering,
    TResult Function()? unregistered,
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
    required TResult Function(_CallSignalingEventTransfer value) transfer,
    required TResult Function(_CallSignalingEventNotify value) notify,
    required TResult Function(_CallSignalingEventRegistering value) registering,
    required TResult Function(_CallSignalingEventRegistered value) registered,
    required TResult Function(_CallSignalingEventRegisterationFailed value)
        registrationFailed,
    required TResult Function(_CallSignalingEventUnregistering value)
        unregistering,
    required TResult Function(_CallSignalingEventUnregistered value)
        unregistered,
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
    TResult? Function(_CallSignalingEventTransfer value)? transfer,
    TResult? Function(_CallSignalingEventNotify value)? notify,
    TResult? Function(_CallSignalingEventRegistering value)? registering,
    TResult? Function(_CallSignalingEventRegistered value)? registered,
    TResult? Function(_CallSignalingEventRegisterationFailed value)?
        registrationFailed,
    TResult? Function(_CallSignalingEventUnregistering value)? unregistering,
    TResult? Function(_CallSignalingEventUnregistered value)? unregistered,
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
    TResult Function(_CallSignalingEventTransfer value)? transfer,
    TResult Function(_CallSignalingEventNotify value)? notify,
    TResult Function(_CallSignalingEventRegistering value)? registering,
    TResult Function(_CallSignalingEventRegistered value)? registered,
    TResult Function(_CallSignalingEventRegisterationFailed value)?
        registrationFailed,
    TResult Function(_CallSignalingEventUnregistering value)? unregistering,
    TResult Function(_CallSignalingEventUnregistered value)? unregistered,
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

  int get line;
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
    required TResult Function(int line, String referId, String referTo,
            String? referredBy, String? replaceCallId)
        transfer,
    required TResult Function(
            int line,
            String callId,
            String? notify,
            SubscriptionState? subscriptionState,
            String? contentType,
            String content)
        notify,
    required TResult Function() registering,
    required TResult Function() registered,
    required TResult Function(int code, String reason) registrationFailed,
    required TResult Function() unregistering,
    required TResult Function() unregistered,
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
    TResult? Function(int line, String referId, String referTo,
            String? referredBy, String? replaceCallId)?
        transfer,
    TResult? Function(
            int line,
            String callId,
            String? notify,
            SubscriptionState? subscriptionState,
            String? contentType,
            String content)?
        notify,
    TResult? Function()? registering,
    TResult? Function()? registered,
    TResult? Function(int code, String reason)? registrationFailed,
    TResult? Function()? unregistering,
    TResult? Function()? unregistered,
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
    TResult Function(int line, String referId, String referTo,
            String? referredBy, String? replaceCallId)?
        transfer,
    TResult Function(
            int line,
            String callId,
            String? notify,
            SubscriptionState? subscriptionState,
            String? contentType,
            String content)?
        notify,
    TResult Function()? registering,
    TResult Function()? registered,
    TResult Function(int code, String reason)? registrationFailed,
    TResult Function()? unregistering,
    TResult Function()? unregistered,
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
    required TResult Function(_CallSignalingEventTransfer value) transfer,
    required TResult Function(_CallSignalingEventNotify value) notify,
    required TResult Function(_CallSignalingEventRegistering value) registering,
    required TResult Function(_CallSignalingEventRegistered value) registered,
    required TResult Function(_CallSignalingEventRegisterationFailed value)
        registrationFailed,
    required TResult Function(_CallSignalingEventUnregistering value)
        unregistering,
    required TResult Function(_CallSignalingEventUnregistered value)
        unregistered,
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
    TResult? Function(_CallSignalingEventTransfer value)? transfer,
    TResult? Function(_CallSignalingEventNotify value)? notify,
    TResult? Function(_CallSignalingEventRegistering value)? registering,
    TResult? Function(_CallSignalingEventRegistered value)? registered,
    TResult? Function(_CallSignalingEventRegisterationFailed value)?
        registrationFailed,
    TResult? Function(_CallSignalingEventUnregistering value)? unregistering,
    TResult? Function(_CallSignalingEventUnregistered value)? unregistered,
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
    TResult Function(_CallSignalingEventTransfer value)? transfer,
    TResult Function(_CallSignalingEventNotify value)? notify,
    TResult Function(_CallSignalingEventRegistering value)? registering,
    TResult Function(_CallSignalingEventRegistered value)? registered,
    TResult Function(_CallSignalingEventRegisterationFailed value)?
        registrationFailed,
    TResult Function(_CallSignalingEventUnregistering value)? unregistering,
    TResult Function(_CallSignalingEventUnregistered value)? unregistered,
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

  int get line;
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
    required TResult Function(int line, String referId, String referTo,
            String? referredBy, String? replaceCallId)
        transfer,
    required TResult Function(
            int line,
            String callId,
            String? notify,
            SubscriptionState? subscriptionState,
            String? contentType,
            String content)
        notify,
    required TResult Function() registering,
    required TResult Function() registered,
    required TResult Function(int code, String reason) registrationFailed,
    required TResult Function() unregistering,
    required TResult Function() unregistered,
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
    TResult? Function(int line, String referId, String referTo,
            String? referredBy, String? replaceCallId)?
        transfer,
    TResult? Function(
            int line,
            String callId,
            String? notify,
            SubscriptionState? subscriptionState,
            String? contentType,
            String content)?
        notify,
    TResult? Function()? registering,
    TResult? Function()? registered,
    TResult? Function(int code, String reason)? registrationFailed,
    TResult? Function()? unregistering,
    TResult? Function()? unregistered,
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
    TResult Function(int line, String referId, String referTo,
            String? referredBy, String? replaceCallId)?
        transfer,
    TResult Function(
            int line,
            String callId,
            String? notify,
            SubscriptionState? subscriptionState,
            String? contentType,
            String content)?
        notify,
    TResult Function()? registering,
    TResult Function()? registered,
    TResult Function(int code, String reason)? registrationFailed,
    TResult Function()? unregistering,
    TResult Function()? unregistered,
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
    required TResult Function(_CallSignalingEventTransfer value) transfer,
    required TResult Function(_CallSignalingEventNotify value) notify,
    required TResult Function(_CallSignalingEventRegistering value) registering,
    required TResult Function(_CallSignalingEventRegistered value) registered,
    required TResult Function(_CallSignalingEventRegisterationFailed value)
        registrationFailed,
    required TResult Function(_CallSignalingEventUnregistering value)
        unregistering,
    required TResult Function(_CallSignalingEventUnregistered value)
        unregistered,
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
    TResult? Function(_CallSignalingEventTransfer value)? transfer,
    TResult? Function(_CallSignalingEventNotify value)? notify,
    TResult? Function(_CallSignalingEventRegistering value)? registering,
    TResult? Function(_CallSignalingEventRegistered value)? registered,
    TResult? Function(_CallSignalingEventRegisterationFailed value)?
        registrationFailed,
    TResult? Function(_CallSignalingEventUnregistering value)? unregistering,
    TResult? Function(_CallSignalingEventUnregistered value)? unregistered,
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
    TResult Function(_CallSignalingEventTransfer value)? transfer,
    TResult Function(_CallSignalingEventNotify value)? notify,
    TResult Function(_CallSignalingEventRegistering value)? registering,
    TResult Function(_CallSignalingEventRegistered value)? registered,
    TResult Function(_CallSignalingEventRegisterationFailed value)?
        registrationFailed,
    TResult Function(_CallSignalingEventUnregistering value)? unregistering,
    TResult Function(_CallSignalingEventUnregistered value)? unregistered,
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

  int get line;
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
    required TResult Function(int line, String referId, String referTo,
            String? referredBy, String? replaceCallId)
        transfer,
    required TResult Function(
            int line,
            String callId,
            String? notify,
            SubscriptionState? subscriptionState,
            String? contentType,
            String content)
        notify,
    required TResult Function() registering,
    required TResult Function() registered,
    required TResult Function(int code, String reason) registrationFailed,
    required TResult Function() unregistering,
    required TResult Function() unregistered,
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
    TResult? Function(int line, String referId, String referTo,
            String? referredBy, String? replaceCallId)?
        transfer,
    TResult? Function(
            int line,
            String callId,
            String? notify,
            SubscriptionState? subscriptionState,
            String? contentType,
            String content)?
        notify,
    TResult? Function()? registering,
    TResult? Function()? registered,
    TResult? Function(int code, String reason)? registrationFailed,
    TResult? Function()? unregistering,
    TResult? Function()? unregistered,
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
    TResult Function(int line, String referId, String referTo,
            String? referredBy, String? replaceCallId)?
        transfer,
    TResult Function(
            int line,
            String callId,
            String? notify,
            SubscriptionState? subscriptionState,
            String? contentType,
            String content)?
        notify,
    TResult Function()? registering,
    TResult Function()? registered,
    TResult Function(int code, String reason)? registrationFailed,
    TResult Function()? unregistering,
    TResult Function()? unregistered,
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
    required TResult Function(_CallSignalingEventTransfer value) transfer,
    required TResult Function(_CallSignalingEventNotify value) notify,
    required TResult Function(_CallSignalingEventRegistering value) registering,
    required TResult Function(_CallSignalingEventRegistered value) registered,
    required TResult Function(_CallSignalingEventRegisterationFailed value)
        registrationFailed,
    required TResult Function(_CallSignalingEventUnregistering value)
        unregistering,
    required TResult Function(_CallSignalingEventUnregistered value)
        unregistered,
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
    TResult? Function(_CallSignalingEventTransfer value)? transfer,
    TResult? Function(_CallSignalingEventNotify value)? notify,
    TResult? Function(_CallSignalingEventRegistering value)? registering,
    TResult? Function(_CallSignalingEventRegistered value)? registered,
    TResult? Function(_CallSignalingEventRegisterationFailed value)?
        registrationFailed,
    TResult? Function(_CallSignalingEventUnregistering value)? unregistering,
    TResult? Function(_CallSignalingEventUnregistered value)? unregistered,
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
    TResult Function(_CallSignalingEventTransfer value)? transfer,
    TResult Function(_CallSignalingEventNotify value)? notify,
    TResult Function(_CallSignalingEventRegistering value)? registering,
    TResult Function(_CallSignalingEventRegistered value)? registered,
    TResult Function(_CallSignalingEventRegisterationFailed value)?
        registrationFailed,
    TResult Function(_CallSignalingEventUnregistering value)? unregistering,
    TResult Function(_CallSignalingEventUnregistered value)? unregistered,
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

  int get line;
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
    required TResult Function(int line, String referId, String referTo,
            String? referredBy, String? replaceCallId)
        transfer,
    required TResult Function(
            int line,
            String callId,
            String? notify,
            SubscriptionState? subscriptionState,
            String? contentType,
            String content)
        notify,
    required TResult Function() registering,
    required TResult Function() registered,
    required TResult Function(int code, String reason) registrationFailed,
    required TResult Function() unregistering,
    required TResult Function() unregistered,
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
    TResult? Function(int line, String referId, String referTo,
            String? referredBy, String? replaceCallId)?
        transfer,
    TResult? Function(
            int line,
            String callId,
            String? notify,
            SubscriptionState? subscriptionState,
            String? contentType,
            String content)?
        notify,
    TResult? Function()? registering,
    TResult? Function()? registered,
    TResult? Function(int code, String reason)? registrationFailed,
    TResult? Function()? unregistering,
    TResult? Function()? unregistered,
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
    TResult Function(int line, String referId, String referTo,
            String? referredBy, String? replaceCallId)?
        transfer,
    TResult Function(
            int line,
            String callId,
            String? notify,
            SubscriptionState? subscriptionState,
            String? contentType,
            String content)?
        notify,
    TResult Function()? registering,
    TResult Function()? registered,
    TResult Function(int code, String reason)? registrationFailed,
    TResult Function()? unregistering,
    TResult Function()? unregistered,
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
    required TResult Function(_CallSignalingEventTransfer value) transfer,
    required TResult Function(_CallSignalingEventNotify value) notify,
    required TResult Function(_CallSignalingEventRegistering value) registering,
    required TResult Function(_CallSignalingEventRegistered value) registered,
    required TResult Function(_CallSignalingEventRegisterationFailed value)
        registrationFailed,
    required TResult Function(_CallSignalingEventUnregistering value)
        unregistering,
    required TResult Function(_CallSignalingEventUnregistered value)
        unregistered,
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
    TResult? Function(_CallSignalingEventTransfer value)? transfer,
    TResult? Function(_CallSignalingEventNotify value)? notify,
    TResult? Function(_CallSignalingEventRegistering value)? registering,
    TResult? Function(_CallSignalingEventRegistered value)? registered,
    TResult? Function(_CallSignalingEventRegisterationFailed value)?
        registrationFailed,
    TResult? Function(_CallSignalingEventUnregistering value)? unregistering,
    TResult? Function(_CallSignalingEventUnregistered value)? unregistered,
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
    TResult Function(_CallSignalingEventTransfer value)? transfer,
    TResult Function(_CallSignalingEventNotify value)? notify,
    TResult Function(_CallSignalingEventRegistering value)? registering,
    TResult Function(_CallSignalingEventRegistered value)? registered,
    TResult Function(_CallSignalingEventRegisterationFailed value)?
        registrationFailed,
    TResult Function(_CallSignalingEventUnregistering value)? unregistering,
    TResult Function(_CallSignalingEventUnregistered value)? unregistered,
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

  int get line;
  String get callId;
}

/// @nodoc

class _$CallSignalingEventTransferImpl
    with DiagnosticableTreeMixin
    implements _CallSignalingEventTransfer {
  const _$CallSignalingEventTransferImpl(
      {required this.line,
      required this.referId,
      required this.referTo,
      required this.referredBy,
      required this.replaceCallId});

  @override
  final int line;
  @override
  final String referId;
  @override
  final String referTo;
  @override
  final String? referredBy;
  @override
  final String? replaceCallId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallSignalingEvent.transfer(line: $line, referId: $referId, referTo: $referTo, referredBy: $referredBy, replaceCallId: $replaceCallId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', '_CallSignalingEvent.transfer'))
      ..add(DiagnosticsProperty('line', line))
      ..add(DiagnosticsProperty('referId', referId))
      ..add(DiagnosticsProperty('referTo', referTo))
      ..add(DiagnosticsProperty('referredBy', referredBy))
      ..add(DiagnosticsProperty('replaceCallId', replaceCallId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallSignalingEventTransferImpl &&
            (identical(other.line, line) || other.line == line) &&
            (identical(other.referId, referId) || other.referId == referId) &&
            (identical(other.referTo, referTo) || other.referTo == referTo) &&
            (identical(other.referredBy, referredBy) ||
                other.referredBy == referredBy) &&
            (identical(other.replaceCallId, replaceCallId) ||
                other.replaceCallId == replaceCallId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, line, referId, referTo, referredBy, replaceCallId);

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
    required TResult Function(int line, String referId, String referTo,
            String? referredBy, String? replaceCallId)
        transfer,
    required TResult Function(
            int line,
            String callId,
            String? notify,
            SubscriptionState? subscriptionState,
            String? contentType,
            String content)
        notify,
    required TResult Function() registering,
    required TResult Function() registered,
    required TResult Function(int code, String reason) registrationFailed,
    required TResult Function() unregistering,
    required TResult Function() unregistered,
  }) {
    return transfer(line, referId, referTo, referredBy, replaceCallId);
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
    TResult? Function(int line, String referId, String referTo,
            String? referredBy, String? replaceCallId)?
        transfer,
    TResult? Function(
            int line,
            String callId,
            String? notify,
            SubscriptionState? subscriptionState,
            String? contentType,
            String content)?
        notify,
    TResult? Function()? registering,
    TResult? Function()? registered,
    TResult? Function(int code, String reason)? registrationFailed,
    TResult? Function()? unregistering,
    TResult? Function()? unregistered,
  }) {
    return transfer?.call(line, referId, referTo, referredBy, replaceCallId);
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
    TResult Function(int line, String referId, String referTo,
            String? referredBy, String? replaceCallId)?
        transfer,
    TResult Function(
            int line,
            String callId,
            String? notify,
            SubscriptionState? subscriptionState,
            String? contentType,
            String content)?
        notify,
    TResult Function()? registering,
    TResult Function()? registered,
    TResult Function(int code, String reason)? registrationFailed,
    TResult Function()? unregistering,
    TResult Function()? unregistered,
    required TResult orElse(),
  }) {
    if (transfer != null) {
      return transfer(line, referId, referTo, referredBy, replaceCallId);
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
    required TResult Function(_CallSignalingEventTransfer value) transfer,
    required TResult Function(_CallSignalingEventNotify value) notify,
    required TResult Function(_CallSignalingEventRegistering value) registering,
    required TResult Function(_CallSignalingEventRegistered value) registered,
    required TResult Function(_CallSignalingEventRegisterationFailed value)
        registrationFailed,
    required TResult Function(_CallSignalingEventUnregistering value)
        unregistering,
    required TResult Function(_CallSignalingEventUnregistered value)
        unregistered,
  }) {
    return transfer(this);
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
    TResult? Function(_CallSignalingEventTransfer value)? transfer,
    TResult? Function(_CallSignalingEventNotify value)? notify,
    TResult? Function(_CallSignalingEventRegistering value)? registering,
    TResult? Function(_CallSignalingEventRegistered value)? registered,
    TResult? Function(_CallSignalingEventRegisterationFailed value)?
        registrationFailed,
    TResult? Function(_CallSignalingEventUnregistering value)? unregistering,
    TResult? Function(_CallSignalingEventUnregistered value)? unregistered,
  }) {
    return transfer?.call(this);
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
    TResult Function(_CallSignalingEventTransfer value)? transfer,
    TResult Function(_CallSignalingEventNotify value)? notify,
    TResult Function(_CallSignalingEventRegistering value)? registering,
    TResult Function(_CallSignalingEventRegistered value)? registered,
    TResult Function(_CallSignalingEventRegisterationFailed value)?
        registrationFailed,
    TResult Function(_CallSignalingEventUnregistering value)? unregistering,
    TResult Function(_CallSignalingEventUnregistered value)? unregistered,
    required TResult orElse(),
  }) {
    if (transfer != null) {
      return transfer(this);
    }
    return orElse();
  }
}

abstract class _CallSignalingEventTransfer implements _CallSignalingEvent {
  const factory _CallSignalingEventTransfer(
      {required final int line,
      required final String referId,
      required final String referTo,
      required final String? referredBy,
      required final String? replaceCallId}) = _$CallSignalingEventTransferImpl;

  int get line;
  String get referId;
  String get referTo;
  String? get referredBy;
  String? get replaceCallId;
}

/// @nodoc

class _$CallSignalingEventNotifyImpl
    with DiagnosticableTreeMixin
    implements _CallSignalingEventNotify {
  const _$CallSignalingEventNotifyImpl(
      {required this.line,
      required this.callId,
      required this.notify,
      required this.subscriptionState,
      required this.contentType,
      required this.content});

  @override
  final int line;
  @override
  final String callId;
  @override
  final String? notify;
  @override
  final SubscriptionState? subscriptionState;
  @override
  final String? contentType;
  @override
  final String content;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallSignalingEvent.notify(line: $line, callId: $callId, notify: $notify, subscriptionState: $subscriptionState, contentType: $contentType, content: $content)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', '_CallSignalingEvent.notify'))
      ..add(DiagnosticsProperty('line', line))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('notify', notify))
      ..add(DiagnosticsProperty('subscriptionState', subscriptionState))
      ..add(DiagnosticsProperty('contentType', contentType))
      ..add(DiagnosticsProperty('content', content));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallSignalingEventNotifyImpl &&
            (identical(other.line, line) || other.line == line) &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.notify, notify) || other.notify == notify) &&
            (identical(other.subscriptionState, subscriptionState) ||
                other.subscriptionState == subscriptionState) &&
            (identical(other.contentType, contentType) ||
                other.contentType == contentType) &&
            (identical(other.content, content) || other.content == content));
  }

  @override
  int get hashCode => Object.hash(runtimeType, line, callId, notify,
      subscriptionState, contentType, content);

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
    required TResult Function(int line, String referId, String referTo,
            String? referredBy, String? replaceCallId)
        transfer,
    required TResult Function(
            int line,
            String callId,
            String? notify,
            SubscriptionState? subscriptionState,
            String? contentType,
            String content)
        notify,
    required TResult Function() registering,
    required TResult Function() registered,
    required TResult Function(int code, String reason) registrationFailed,
    required TResult Function() unregistering,
    required TResult Function() unregistered,
  }) {
    return notify(
        line, callId, this.notify, subscriptionState, contentType, content);
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
    TResult? Function(int line, String referId, String referTo,
            String? referredBy, String? replaceCallId)?
        transfer,
    TResult? Function(
            int line,
            String callId,
            String? notify,
            SubscriptionState? subscriptionState,
            String? contentType,
            String content)?
        notify,
    TResult? Function()? registering,
    TResult? Function()? registered,
    TResult? Function(int code, String reason)? registrationFailed,
    TResult? Function()? unregistering,
    TResult? Function()? unregistered,
  }) {
    return notify?.call(
        line, callId, this.notify, subscriptionState, contentType, content);
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
    TResult Function(int line, String referId, String referTo,
            String? referredBy, String? replaceCallId)?
        transfer,
    TResult Function(
            int line,
            String callId,
            String? notify,
            SubscriptionState? subscriptionState,
            String? contentType,
            String content)?
        notify,
    TResult Function()? registering,
    TResult Function()? registered,
    TResult Function(int code, String reason)? registrationFailed,
    TResult Function()? unregistering,
    TResult Function()? unregistered,
    required TResult orElse(),
  }) {
    if (notify != null) {
      return notify(
          line, callId, this.notify, subscriptionState, contentType, content);
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
    required TResult Function(_CallSignalingEventTransfer value) transfer,
    required TResult Function(_CallSignalingEventNotify value) notify,
    required TResult Function(_CallSignalingEventRegistering value) registering,
    required TResult Function(_CallSignalingEventRegistered value) registered,
    required TResult Function(_CallSignalingEventRegisterationFailed value)
        registrationFailed,
    required TResult Function(_CallSignalingEventUnregistering value)
        unregistering,
    required TResult Function(_CallSignalingEventUnregistered value)
        unregistered,
  }) {
    return notify(this);
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
    TResult? Function(_CallSignalingEventTransfer value)? transfer,
    TResult? Function(_CallSignalingEventNotify value)? notify,
    TResult? Function(_CallSignalingEventRegistering value)? registering,
    TResult? Function(_CallSignalingEventRegistered value)? registered,
    TResult? Function(_CallSignalingEventRegisterationFailed value)?
        registrationFailed,
    TResult? Function(_CallSignalingEventUnregistering value)? unregistering,
    TResult? Function(_CallSignalingEventUnregistered value)? unregistered,
  }) {
    return notify?.call(this);
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
    TResult Function(_CallSignalingEventTransfer value)? transfer,
    TResult Function(_CallSignalingEventNotify value)? notify,
    TResult Function(_CallSignalingEventRegistering value)? registering,
    TResult Function(_CallSignalingEventRegistered value)? registered,
    TResult Function(_CallSignalingEventRegisterationFailed value)?
        registrationFailed,
    TResult Function(_CallSignalingEventUnregistering value)? unregistering,
    TResult Function(_CallSignalingEventUnregistered value)? unregistered,
    required TResult orElse(),
  }) {
    if (notify != null) {
      return notify(this);
    }
    return orElse();
  }
}

abstract class _CallSignalingEventNotify implements _CallSignalingEvent {
  const factory _CallSignalingEventNotify(
      {required final int line,
      required final String callId,
      required final String? notify,
      required final SubscriptionState? subscriptionState,
      required final String? contentType,
      required final String content}) = _$CallSignalingEventNotifyImpl;

  int get line;
  String get callId;
  String? get notify;
  SubscriptionState? get subscriptionState;
  String? get contentType;
  String get content;
}

/// @nodoc

class _$CallSignalingEventRegisteringImpl
    with DiagnosticableTreeMixin
    implements _CallSignalingEventRegistering {
  const _$CallSignalingEventRegisteringImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallSignalingEvent.registering()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DiagnosticsProperty('type', '_CallSignalingEvent.registering'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallSignalingEventRegisteringImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

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
    required TResult Function(int line, String referId, String referTo,
            String? referredBy, String? replaceCallId)
        transfer,
    required TResult Function(
            int line,
            String callId,
            String? notify,
            SubscriptionState? subscriptionState,
            String? contentType,
            String content)
        notify,
    required TResult Function() registering,
    required TResult Function() registered,
    required TResult Function(int code, String reason) registrationFailed,
    required TResult Function() unregistering,
    required TResult Function() unregistered,
  }) {
    return registering();
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
    TResult? Function(int line, String referId, String referTo,
            String? referredBy, String? replaceCallId)?
        transfer,
    TResult? Function(
            int line,
            String callId,
            String? notify,
            SubscriptionState? subscriptionState,
            String? contentType,
            String content)?
        notify,
    TResult? Function()? registering,
    TResult? Function()? registered,
    TResult? Function(int code, String reason)? registrationFailed,
    TResult? Function()? unregistering,
    TResult? Function()? unregistered,
  }) {
    return registering?.call();
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
    TResult Function(int line, String referId, String referTo,
            String? referredBy, String? replaceCallId)?
        transfer,
    TResult Function(
            int line,
            String callId,
            String? notify,
            SubscriptionState? subscriptionState,
            String? contentType,
            String content)?
        notify,
    TResult Function()? registering,
    TResult Function()? registered,
    TResult Function(int code, String reason)? registrationFailed,
    TResult Function()? unregistering,
    TResult Function()? unregistered,
    required TResult orElse(),
  }) {
    if (registering != null) {
      return registering();
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
    required TResult Function(_CallSignalingEventTransfer value) transfer,
    required TResult Function(_CallSignalingEventNotify value) notify,
    required TResult Function(_CallSignalingEventRegistering value) registering,
    required TResult Function(_CallSignalingEventRegistered value) registered,
    required TResult Function(_CallSignalingEventRegisterationFailed value)
        registrationFailed,
    required TResult Function(_CallSignalingEventUnregistering value)
        unregistering,
    required TResult Function(_CallSignalingEventUnregistered value)
        unregistered,
  }) {
    return registering(this);
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
    TResult? Function(_CallSignalingEventTransfer value)? transfer,
    TResult? Function(_CallSignalingEventNotify value)? notify,
    TResult? Function(_CallSignalingEventRegistering value)? registering,
    TResult? Function(_CallSignalingEventRegistered value)? registered,
    TResult? Function(_CallSignalingEventRegisterationFailed value)?
        registrationFailed,
    TResult? Function(_CallSignalingEventUnregistering value)? unregistering,
    TResult? Function(_CallSignalingEventUnregistered value)? unregistered,
  }) {
    return registering?.call(this);
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
    TResult Function(_CallSignalingEventTransfer value)? transfer,
    TResult Function(_CallSignalingEventNotify value)? notify,
    TResult Function(_CallSignalingEventRegistering value)? registering,
    TResult Function(_CallSignalingEventRegistered value)? registered,
    TResult Function(_CallSignalingEventRegisterationFailed value)?
        registrationFailed,
    TResult Function(_CallSignalingEventUnregistering value)? unregistering,
    TResult Function(_CallSignalingEventUnregistered value)? unregistered,
    required TResult orElse(),
  }) {
    if (registering != null) {
      return registering(this);
    }
    return orElse();
  }
}

abstract class _CallSignalingEventRegistering implements _CallSignalingEvent {
  const factory _CallSignalingEventRegistering() =
      _$CallSignalingEventRegisteringImpl;
}

/// @nodoc

class _$CallSignalingEventRegisteredImpl
    with DiagnosticableTreeMixin
    implements _CallSignalingEventRegistered {
  const _$CallSignalingEventRegisteredImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallSignalingEvent.registered()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DiagnosticsProperty('type', '_CallSignalingEvent.registered'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallSignalingEventRegisteredImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

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
    required TResult Function(int line, String referId, String referTo,
            String? referredBy, String? replaceCallId)
        transfer,
    required TResult Function(
            int line,
            String callId,
            String? notify,
            SubscriptionState? subscriptionState,
            String? contentType,
            String content)
        notify,
    required TResult Function() registering,
    required TResult Function() registered,
    required TResult Function(int code, String reason) registrationFailed,
    required TResult Function() unregistering,
    required TResult Function() unregistered,
  }) {
    return registered();
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
    TResult? Function(int line, String referId, String referTo,
            String? referredBy, String? replaceCallId)?
        transfer,
    TResult? Function(
            int line,
            String callId,
            String? notify,
            SubscriptionState? subscriptionState,
            String? contentType,
            String content)?
        notify,
    TResult? Function()? registering,
    TResult? Function()? registered,
    TResult? Function(int code, String reason)? registrationFailed,
    TResult? Function()? unregistering,
    TResult? Function()? unregistered,
  }) {
    return registered?.call();
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
    TResult Function(int line, String referId, String referTo,
            String? referredBy, String? replaceCallId)?
        transfer,
    TResult Function(
            int line,
            String callId,
            String? notify,
            SubscriptionState? subscriptionState,
            String? contentType,
            String content)?
        notify,
    TResult Function()? registering,
    TResult Function()? registered,
    TResult Function(int code, String reason)? registrationFailed,
    TResult Function()? unregistering,
    TResult Function()? unregistered,
    required TResult orElse(),
  }) {
    if (registered != null) {
      return registered();
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
    required TResult Function(_CallSignalingEventTransfer value) transfer,
    required TResult Function(_CallSignalingEventNotify value) notify,
    required TResult Function(_CallSignalingEventRegistering value) registering,
    required TResult Function(_CallSignalingEventRegistered value) registered,
    required TResult Function(_CallSignalingEventRegisterationFailed value)
        registrationFailed,
    required TResult Function(_CallSignalingEventUnregistering value)
        unregistering,
    required TResult Function(_CallSignalingEventUnregistered value)
        unregistered,
  }) {
    return registered(this);
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
    TResult? Function(_CallSignalingEventTransfer value)? transfer,
    TResult? Function(_CallSignalingEventNotify value)? notify,
    TResult? Function(_CallSignalingEventRegistering value)? registering,
    TResult? Function(_CallSignalingEventRegistered value)? registered,
    TResult? Function(_CallSignalingEventRegisterationFailed value)?
        registrationFailed,
    TResult? Function(_CallSignalingEventUnregistering value)? unregistering,
    TResult? Function(_CallSignalingEventUnregistered value)? unregistered,
  }) {
    return registered?.call(this);
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
    TResult Function(_CallSignalingEventTransfer value)? transfer,
    TResult Function(_CallSignalingEventNotify value)? notify,
    TResult Function(_CallSignalingEventRegistering value)? registering,
    TResult Function(_CallSignalingEventRegistered value)? registered,
    TResult Function(_CallSignalingEventRegisterationFailed value)?
        registrationFailed,
    TResult Function(_CallSignalingEventUnregistering value)? unregistering,
    TResult Function(_CallSignalingEventUnregistered value)? unregistered,
    required TResult orElse(),
  }) {
    if (registered != null) {
      return registered(this);
    }
    return orElse();
  }
}

abstract class _CallSignalingEventRegistered implements _CallSignalingEvent {
  const factory _CallSignalingEventRegistered() =
      _$CallSignalingEventRegisteredImpl;
}

/// @nodoc

class _$CallSignalingEventRegisterationFailedImpl
    with DiagnosticableTreeMixin
    implements _CallSignalingEventRegisterationFailed {
  const _$CallSignalingEventRegisterationFailedImpl(this.code, this.reason);

  @override
  final int code;
  @override
  final String reason;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallSignalingEvent.registrationFailed(code: $code, reason: $reason)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
          DiagnosticsProperty('type', '_CallSignalingEvent.registrationFailed'))
      ..add(DiagnosticsProperty('code', code))
      ..add(DiagnosticsProperty('reason', reason));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallSignalingEventRegisterationFailedImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @override
  int get hashCode => Object.hash(runtimeType, code, reason);

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
    required TResult Function(int line, String referId, String referTo,
            String? referredBy, String? replaceCallId)
        transfer,
    required TResult Function(
            int line,
            String callId,
            String? notify,
            SubscriptionState? subscriptionState,
            String? contentType,
            String content)
        notify,
    required TResult Function() registering,
    required TResult Function() registered,
    required TResult Function(int code, String reason) registrationFailed,
    required TResult Function() unregistering,
    required TResult Function() unregistered,
  }) {
    return registrationFailed(code, reason);
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
    TResult? Function(int line, String referId, String referTo,
            String? referredBy, String? replaceCallId)?
        transfer,
    TResult? Function(
            int line,
            String callId,
            String? notify,
            SubscriptionState? subscriptionState,
            String? contentType,
            String content)?
        notify,
    TResult? Function()? registering,
    TResult? Function()? registered,
    TResult? Function(int code, String reason)? registrationFailed,
    TResult? Function()? unregistering,
    TResult? Function()? unregistered,
  }) {
    return registrationFailed?.call(code, reason);
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
    TResult Function(int line, String referId, String referTo,
            String? referredBy, String? replaceCallId)?
        transfer,
    TResult Function(
            int line,
            String callId,
            String? notify,
            SubscriptionState? subscriptionState,
            String? contentType,
            String content)?
        notify,
    TResult Function()? registering,
    TResult Function()? registered,
    TResult Function(int code, String reason)? registrationFailed,
    TResult Function()? unregistering,
    TResult Function()? unregistered,
    required TResult orElse(),
  }) {
    if (registrationFailed != null) {
      return registrationFailed(code, reason);
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
    required TResult Function(_CallSignalingEventTransfer value) transfer,
    required TResult Function(_CallSignalingEventNotify value) notify,
    required TResult Function(_CallSignalingEventRegistering value) registering,
    required TResult Function(_CallSignalingEventRegistered value) registered,
    required TResult Function(_CallSignalingEventRegisterationFailed value)
        registrationFailed,
    required TResult Function(_CallSignalingEventUnregistering value)
        unregistering,
    required TResult Function(_CallSignalingEventUnregistered value)
        unregistered,
  }) {
    return registrationFailed(this);
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
    TResult? Function(_CallSignalingEventTransfer value)? transfer,
    TResult? Function(_CallSignalingEventNotify value)? notify,
    TResult? Function(_CallSignalingEventRegistering value)? registering,
    TResult? Function(_CallSignalingEventRegistered value)? registered,
    TResult? Function(_CallSignalingEventRegisterationFailed value)?
        registrationFailed,
    TResult? Function(_CallSignalingEventUnregistering value)? unregistering,
    TResult? Function(_CallSignalingEventUnregistered value)? unregistered,
  }) {
    return registrationFailed?.call(this);
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
    TResult Function(_CallSignalingEventTransfer value)? transfer,
    TResult Function(_CallSignalingEventNotify value)? notify,
    TResult Function(_CallSignalingEventRegistering value)? registering,
    TResult Function(_CallSignalingEventRegistered value)? registered,
    TResult Function(_CallSignalingEventRegisterationFailed value)?
        registrationFailed,
    TResult Function(_CallSignalingEventUnregistering value)? unregistering,
    TResult Function(_CallSignalingEventUnregistered value)? unregistered,
    required TResult orElse(),
  }) {
    if (registrationFailed != null) {
      return registrationFailed(this);
    }
    return orElse();
  }
}

abstract class _CallSignalingEventRegisterationFailed
    implements _CallSignalingEvent {
  const factory _CallSignalingEventRegisterationFailed(
          final int code, final String reason) =
      _$CallSignalingEventRegisterationFailedImpl;

  int get code;
  String get reason;
}

/// @nodoc

class _$CallSignalingEventUnregisteringImpl
    with DiagnosticableTreeMixin
    implements _CallSignalingEventUnregistering {
  const _$CallSignalingEventUnregisteringImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallSignalingEvent.unregistering()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DiagnosticsProperty('type', '_CallSignalingEvent.unregistering'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallSignalingEventUnregisteringImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

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
    required TResult Function(int line, String referId, String referTo,
            String? referredBy, String? replaceCallId)
        transfer,
    required TResult Function(
            int line,
            String callId,
            String? notify,
            SubscriptionState? subscriptionState,
            String? contentType,
            String content)
        notify,
    required TResult Function() registering,
    required TResult Function() registered,
    required TResult Function(int code, String reason) registrationFailed,
    required TResult Function() unregistering,
    required TResult Function() unregistered,
  }) {
    return unregistering();
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
    TResult? Function(int line, String referId, String referTo,
            String? referredBy, String? replaceCallId)?
        transfer,
    TResult? Function(
            int line,
            String callId,
            String? notify,
            SubscriptionState? subscriptionState,
            String? contentType,
            String content)?
        notify,
    TResult? Function()? registering,
    TResult? Function()? registered,
    TResult? Function(int code, String reason)? registrationFailed,
    TResult? Function()? unregistering,
    TResult? Function()? unregistered,
  }) {
    return unregistering?.call();
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
    TResult Function(int line, String referId, String referTo,
            String? referredBy, String? replaceCallId)?
        transfer,
    TResult Function(
            int line,
            String callId,
            String? notify,
            SubscriptionState? subscriptionState,
            String? contentType,
            String content)?
        notify,
    TResult Function()? registering,
    TResult Function()? registered,
    TResult Function(int code, String reason)? registrationFailed,
    TResult Function()? unregistering,
    TResult Function()? unregistered,
    required TResult orElse(),
  }) {
    if (unregistering != null) {
      return unregistering();
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
    required TResult Function(_CallSignalingEventTransfer value) transfer,
    required TResult Function(_CallSignalingEventNotify value) notify,
    required TResult Function(_CallSignalingEventRegistering value) registering,
    required TResult Function(_CallSignalingEventRegistered value) registered,
    required TResult Function(_CallSignalingEventRegisterationFailed value)
        registrationFailed,
    required TResult Function(_CallSignalingEventUnregistering value)
        unregistering,
    required TResult Function(_CallSignalingEventUnregistered value)
        unregistered,
  }) {
    return unregistering(this);
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
    TResult? Function(_CallSignalingEventTransfer value)? transfer,
    TResult? Function(_CallSignalingEventNotify value)? notify,
    TResult? Function(_CallSignalingEventRegistering value)? registering,
    TResult? Function(_CallSignalingEventRegistered value)? registered,
    TResult? Function(_CallSignalingEventRegisterationFailed value)?
        registrationFailed,
    TResult? Function(_CallSignalingEventUnregistering value)? unregistering,
    TResult? Function(_CallSignalingEventUnregistered value)? unregistered,
  }) {
    return unregistering?.call(this);
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
    TResult Function(_CallSignalingEventTransfer value)? transfer,
    TResult Function(_CallSignalingEventNotify value)? notify,
    TResult Function(_CallSignalingEventRegistering value)? registering,
    TResult Function(_CallSignalingEventRegistered value)? registered,
    TResult Function(_CallSignalingEventRegisterationFailed value)?
        registrationFailed,
    TResult Function(_CallSignalingEventUnregistering value)? unregistering,
    TResult Function(_CallSignalingEventUnregistered value)? unregistered,
    required TResult orElse(),
  }) {
    if (unregistering != null) {
      return unregistering(this);
    }
    return orElse();
  }
}

abstract class _CallSignalingEventUnregistering implements _CallSignalingEvent {
  const factory _CallSignalingEventUnregistering() =
      _$CallSignalingEventUnregisteringImpl;
}

/// @nodoc

class _$CallSignalingEventUnregisteredImpl
    with DiagnosticableTreeMixin
    implements _CallSignalingEventUnregistered {
  const _$CallSignalingEventUnregisteredImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallSignalingEvent.unregistered()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DiagnosticsProperty('type', '_CallSignalingEvent.unregistered'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallSignalingEventUnregisteredImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

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
    required TResult Function(int line, String referId, String referTo,
            String? referredBy, String? replaceCallId)
        transfer,
    required TResult Function(
            int line,
            String callId,
            String? notify,
            SubscriptionState? subscriptionState,
            String? contentType,
            String content)
        notify,
    required TResult Function() registering,
    required TResult Function() registered,
    required TResult Function(int code, String reason) registrationFailed,
    required TResult Function() unregistering,
    required TResult Function() unregistered,
  }) {
    return unregistered();
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
    TResult? Function(int line, String referId, String referTo,
            String? referredBy, String? replaceCallId)?
        transfer,
    TResult? Function(
            int line,
            String callId,
            String? notify,
            SubscriptionState? subscriptionState,
            String? contentType,
            String content)?
        notify,
    TResult? Function()? registering,
    TResult? Function()? registered,
    TResult? Function(int code, String reason)? registrationFailed,
    TResult? Function()? unregistering,
    TResult? Function()? unregistered,
  }) {
    return unregistered?.call();
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
    TResult Function(int line, String referId, String referTo,
            String? referredBy, String? replaceCallId)?
        transfer,
    TResult Function(
            int line,
            String callId,
            String? notify,
            SubscriptionState? subscriptionState,
            String? contentType,
            String content)?
        notify,
    TResult Function()? registering,
    TResult Function()? registered,
    TResult Function(int code, String reason)? registrationFailed,
    TResult Function()? unregistering,
    TResult Function()? unregistered,
    required TResult orElse(),
  }) {
    if (unregistered != null) {
      return unregistered();
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
    required TResult Function(_CallSignalingEventTransfer value) transfer,
    required TResult Function(_CallSignalingEventNotify value) notify,
    required TResult Function(_CallSignalingEventRegistering value) registering,
    required TResult Function(_CallSignalingEventRegistered value) registered,
    required TResult Function(_CallSignalingEventRegisterationFailed value)
        registrationFailed,
    required TResult Function(_CallSignalingEventUnregistering value)
        unregistering,
    required TResult Function(_CallSignalingEventUnregistered value)
        unregistered,
  }) {
    return unregistered(this);
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
    TResult? Function(_CallSignalingEventTransfer value)? transfer,
    TResult? Function(_CallSignalingEventNotify value)? notify,
    TResult? Function(_CallSignalingEventRegistering value)? registering,
    TResult? Function(_CallSignalingEventRegistered value)? registered,
    TResult? Function(_CallSignalingEventRegisterationFailed value)?
        registrationFailed,
    TResult? Function(_CallSignalingEventUnregistering value)? unregistering,
    TResult? Function(_CallSignalingEventUnregistered value)? unregistered,
  }) {
    return unregistered?.call(this);
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
    TResult Function(_CallSignalingEventTransfer value)? transfer,
    TResult Function(_CallSignalingEventNotify value)? notify,
    TResult Function(_CallSignalingEventRegistering value)? registering,
    TResult Function(_CallSignalingEventRegistered value)? registered,
    TResult Function(_CallSignalingEventRegisterationFailed value)?
        registrationFailed,
    TResult Function(_CallSignalingEventUnregistering value)? unregistering,
    TResult Function(_CallSignalingEventUnregistered value)? unregistered,
    required TResult orElse(),
  }) {
    if (unregistered != null) {
      return unregistered(this);
    }
    return orElse();
  }
}

abstract class _CallSignalingEventUnregistered implements _CallSignalingEvent {
  const factory _CallSignalingEventUnregistered() =
      _$CallSignalingEventUnregisteredImpl;
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
    required TResult Function(String callId) blindTransferInitiated,
    required TResult Function(String callId) attendedTransferInitiated,
    required TResult Function(String number) blindTransferSubmitted,
    required TResult Function(ActiveCall referorCall, ActiveCall replaceCall)
        attendedTransferSubmitted,
    required TResult Function(String callId, String referId)
        attendedRequestDeclined,
    required TResult Function(String referId, String referTo)
        attendedRequestApproved,
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
    TResult? Function(String callId)? blindTransferInitiated,
    TResult? Function(String callId)? attendedTransferInitiated,
    TResult? Function(String number)? blindTransferSubmitted,
    TResult? Function(ActiveCall referorCall, ActiveCall replaceCall)?
        attendedTransferSubmitted,
    TResult? Function(String callId, String referId)? attendedRequestDeclined,
    TResult? Function(String referId, String referTo)? attendedRequestApproved,
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
    TResult Function(String callId)? blindTransferInitiated,
    TResult Function(String callId)? attendedTransferInitiated,
    TResult Function(String number)? blindTransferSubmitted,
    TResult Function(ActiveCall referorCall, ActiveCall replaceCall)?
        attendedTransferSubmitted,
    TResult Function(String callId, String referId)? attendedRequestDeclined,
    TResult Function(String referId, String referTo)? attendedRequestApproved,
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
    required TResult Function(_CallControlEventBlindTransferInitiated value)
        blindTransferInitiated,
    required TResult Function(_CallControlEventAttendedTransferInitiated value)
        attendedTransferInitiated,
    required TResult Function(_CallControlEventBlindTransferSubmitted value)
        blindTransferSubmitted,
    required TResult Function(_CallControlEventAttendedTransferSubmitted value)
        attendedTransferSubmitted,
    required TResult Function(_CallControlEventAttendedRequestDeclined value)
        attendedRequestDeclined,
    required TResult Function(_CallControlEventAttendedRequestApproved value)
        attendedRequestApproved,
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
    TResult? Function(_CallControlEventBlindTransferInitiated value)?
        blindTransferInitiated,
    TResult? Function(_CallControlEventAttendedTransferInitiated value)?
        attendedTransferInitiated,
    TResult? Function(_CallControlEventBlindTransferSubmitted value)?
        blindTransferSubmitted,
    TResult? Function(_CallControlEventAttendedTransferSubmitted value)?
        attendedTransferSubmitted,
    TResult? Function(_CallControlEventAttendedRequestDeclined value)?
        attendedRequestDeclined,
    TResult? Function(_CallControlEventAttendedRequestApproved value)?
        attendedRequestApproved,
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
    TResult Function(_CallControlEventBlindTransferInitiated value)?
        blindTransferInitiated,
    TResult Function(_CallControlEventAttendedTransferInitiated value)?
        attendedTransferInitiated,
    TResult Function(_CallControlEventBlindTransferSubmitted value)?
        blindTransferSubmitted,
    TResult Function(_CallControlEventAttendedTransferSubmitted value)?
        attendedTransferSubmitted,
    TResult Function(_CallControlEventAttendedRequestDeclined value)?
        attendedRequestDeclined,
    TResult Function(_CallControlEventAttendedRequestApproved value)?
        attendedRequestApproved,
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
    required TResult Function(String callId) blindTransferInitiated,
    required TResult Function(String callId) attendedTransferInitiated,
    required TResult Function(String number) blindTransferSubmitted,
    required TResult Function(ActiveCall referorCall, ActiveCall replaceCall)
        attendedTransferSubmitted,
    required TResult Function(String callId, String referId)
        attendedRequestDeclined,
    required TResult Function(String referId, String referTo)
        attendedRequestApproved,
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
    TResult? Function(String callId)? blindTransferInitiated,
    TResult? Function(String callId)? attendedTransferInitiated,
    TResult? Function(String number)? blindTransferSubmitted,
    TResult? Function(ActiveCall referorCall, ActiveCall replaceCall)?
        attendedTransferSubmitted,
    TResult? Function(String callId, String referId)? attendedRequestDeclined,
    TResult? Function(String referId, String referTo)? attendedRequestApproved,
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
    TResult Function(String callId)? blindTransferInitiated,
    TResult Function(String callId)? attendedTransferInitiated,
    TResult Function(String number)? blindTransferSubmitted,
    TResult Function(ActiveCall referorCall, ActiveCall replaceCall)?
        attendedTransferSubmitted,
    TResult Function(String callId, String referId)? attendedRequestDeclined,
    TResult Function(String referId, String referTo)? attendedRequestApproved,
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
    required TResult Function(_CallControlEventBlindTransferInitiated value)
        blindTransferInitiated,
    required TResult Function(_CallControlEventAttendedTransferInitiated value)
        attendedTransferInitiated,
    required TResult Function(_CallControlEventBlindTransferSubmitted value)
        blindTransferSubmitted,
    required TResult Function(_CallControlEventAttendedTransferSubmitted value)
        attendedTransferSubmitted,
    required TResult Function(_CallControlEventAttendedRequestDeclined value)
        attendedRequestDeclined,
    required TResult Function(_CallControlEventAttendedRequestApproved value)
        attendedRequestApproved,
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
    TResult? Function(_CallControlEventBlindTransferInitiated value)?
        blindTransferInitiated,
    TResult? Function(_CallControlEventAttendedTransferInitiated value)?
        attendedTransferInitiated,
    TResult? Function(_CallControlEventBlindTransferSubmitted value)?
        blindTransferSubmitted,
    TResult? Function(_CallControlEventAttendedTransferSubmitted value)?
        attendedTransferSubmitted,
    TResult? Function(_CallControlEventAttendedRequestDeclined value)?
        attendedRequestDeclined,
    TResult? Function(_CallControlEventAttendedRequestApproved value)?
        attendedRequestApproved,
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
    TResult Function(_CallControlEventBlindTransferInitiated value)?
        blindTransferInitiated,
    TResult Function(_CallControlEventAttendedTransferInitiated value)?
        attendedTransferInitiated,
    TResult Function(_CallControlEventBlindTransferSubmitted value)?
        blindTransferSubmitted,
    TResult Function(_CallControlEventAttendedTransferSubmitted value)?
        attendedTransferSubmitted,
    TResult Function(_CallControlEventAttendedRequestDeclined value)?
        attendedRequestDeclined,
    TResult Function(_CallControlEventAttendedRequestApproved value)?
        attendedRequestApproved,
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
    required TResult Function(String callId) blindTransferInitiated,
    required TResult Function(String callId) attendedTransferInitiated,
    required TResult Function(String number) blindTransferSubmitted,
    required TResult Function(ActiveCall referorCall, ActiveCall replaceCall)
        attendedTransferSubmitted,
    required TResult Function(String callId, String referId)
        attendedRequestDeclined,
    required TResult Function(String referId, String referTo)
        attendedRequestApproved,
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
    TResult? Function(String callId)? blindTransferInitiated,
    TResult? Function(String callId)? attendedTransferInitiated,
    TResult? Function(String number)? blindTransferSubmitted,
    TResult? Function(ActiveCall referorCall, ActiveCall replaceCall)?
        attendedTransferSubmitted,
    TResult? Function(String callId, String referId)? attendedRequestDeclined,
    TResult? Function(String referId, String referTo)? attendedRequestApproved,
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
    TResult Function(String callId)? blindTransferInitiated,
    TResult Function(String callId)? attendedTransferInitiated,
    TResult Function(String number)? blindTransferSubmitted,
    TResult Function(ActiveCall referorCall, ActiveCall replaceCall)?
        attendedTransferSubmitted,
    TResult Function(String callId, String referId)? attendedRequestDeclined,
    TResult Function(String referId, String referTo)? attendedRequestApproved,
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
    required TResult Function(_CallControlEventBlindTransferInitiated value)
        blindTransferInitiated,
    required TResult Function(_CallControlEventAttendedTransferInitiated value)
        attendedTransferInitiated,
    required TResult Function(_CallControlEventBlindTransferSubmitted value)
        blindTransferSubmitted,
    required TResult Function(_CallControlEventAttendedTransferSubmitted value)
        attendedTransferSubmitted,
    required TResult Function(_CallControlEventAttendedRequestDeclined value)
        attendedRequestDeclined,
    required TResult Function(_CallControlEventAttendedRequestApproved value)
        attendedRequestApproved,
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
    TResult? Function(_CallControlEventBlindTransferInitiated value)?
        blindTransferInitiated,
    TResult? Function(_CallControlEventAttendedTransferInitiated value)?
        attendedTransferInitiated,
    TResult? Function(_CallControlEventBlindTransferSubmitted value)?
        blindTransferSubmitted,
    TResult? Function(_CallControlEventAttendedTransferSubmitted value)?
        attendedTransferSubmitted,
    TResult? Function(_CallControlEventAttendedRequestDeclined value)?
        attendedRequestDeclined,
    TResult? Function(_CallControlEventAttendedRequestApproved value)?
        attendedRequestApproved,
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
    TResult Function(_CallControlEventBlindTransferInitiated value)?
        blindTransferInitiated,
    TResult Function(_CallControlEventAttendedTransferInitiated value)?
        attendedTransferInitiated,
    TResult Function(_CallControlEventBlindTransferSubmitted value)?
        blindTransferSubmitted,
    TResult Function(_CallControlEventAttendedTransferSubmitted value)?
        attendedTransferSubmitted,
    TResult Function(_CallControlEventAttendedRequestDeclined value)?
        attendedRequestDeclined,
    TResult Function(_CallControlEventAttendedRequestApproved value)?
        attendedRequestApproved,
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
    required TResult Function(String callId) blindTransferInitiated,
    required TResult Function(String callId) attendedTransferInitiated,
    required TResult Function(String number) blindTransferSubmitted,
    required TResult Function(ActiveCall referorCall, ActiveCall replaceCall)
        attendedTransferSubmitted,
    required TResult Function(String callId, String referId)
        attendedRequestDeclined,
    required TResult Function(String referId, String referTo)
        attendedRequestApproved,
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
    TResult? Function(String callId)? blindTransferInitiated,
    TResult? Function(String callId)? attendedTransferInitiated,
    TResult? Function(String number)? blindTransferSubmitted,
    TResult? Function(ActiveCall referorCall, ActiveCall replaceCall)?
        attendedTransferSubmitted,
    TResult? Function(String callId, String referId)? attendedRequestDeclined,
    TResult? Function(String referId, String referTo)? attendedRequestApproved,
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
    TResult Function(String callId)? blindTransferInitiated,
    TResult Function(String callId)? attendedTransferInitiated,
    TResult Function(String number)? blindTransferSubmitted,
    TResult Function(ActiveCall referorCall, ActiveCall replaceCall)?
        attendedTransferSubmitted,
    TResult Function(String callId, String referId)? attendedRequestDeclined,
    TResult Function(String referId, String referTo)? attendedRequestApproved,
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
    required TResult Function(_CallControlEventBlindTransferInitiated value)
        blindTransferInitiated,
    required TResult Function(_CallControlEventAttendedTransferInitiated value)
        attendedTransferInitiated,
    required TResult Function(_CallControlEventBlindTransferSubmitted value)
        blindTransferSubmitted,
    required TResult Function(_CallControlEventAttendedTransferSubmitted value)
        attendedTransferSubmitted,
    required TResult Function(_CallControlEventAttendedRequestDeclined value)
        attendedRequestDeclined,
    required TResult Function(_CallControlEventAttendedRequestApproved value)
        attendedRequestApproved,
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
    TResult? Function(_CallControlEventBlindTransferInitiated value)?
        blindTransferInitiated,
    TResult? Function(_CallControlEventAttendedTransferInitiated value)?
        attendedTransferInitiated,
    TResult? Function(_CallControlEventBlindTransferSubmitted value)?
        blindTransferSubmitted,
    TResult? Function(_CallControlEventAttendedTransferSubmitted value)?
        attendedTransferSubmitted,
    TResult? Function(_CallControlEventAttendedRequestDeclined value)?
        attendedRequestDeclined,
    TResult? Function(_CallControlEventAttendedRequestApproved value)?
        attendedRequestApproved,
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
    TResult Function(_CallControlEventBlindTransferInitiated value)?
        blindTransferInitiated,
    TResult Function(_CallControlEventAttendedTransferInitiated value)?
        attendedTransferInitiated,
    TResult Function(_CallControlEventBlindTransferSubmitted value)?
        blindTransferSubmitted,
    TResult Function(_CallControlEventAttendedTransferSubmitted value)?
        attendedTransferSubmitted,
    TResult Function(_CallControlEventAttendedRequestDeclined value)?
        attendedRequestDeclined,
    TResult Function(_CallControlEventAttendedRequestApproved value)?
        attendedRequestApproved,
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
    required TResult Function(String callId) blindTransferInitiated,
    required TResult Function(String callId) attendedTransferInitiated,
    required TResult Function(String number) blindTransferSubmitted,
    required TResult Function(ActiveCall referorCall, ActiveCall replaceCall)
        attendedTransferSubmitted,
    required TResult Function(String callId, String referId)
        attendedRequestDeclined,
    required TResult Function(String referId, String referTo)
        attendedRequestApproved,
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
    TResult? Function(String callId)? blindTransferInitiated,
    TResult? Function(String callId)? attendedTransferInitiated,
    TResult? Function(String number)? blindTransferSubmitted,
    TResult? Function(ActiveCall referorCall, ActiveCall replaceCall)?
        attendedTransferSubmitted,
    TResult? Function(String callId, String referId)? attendedRequestDeclined,
    TResult? Function(String referId, String referTo)? attendedRequestApproved,
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
    TResult Function(String callId)? blindTransferInitiated,
    TResult Function(String callId)? attendedTransferInitiated,
    TResult Function(String number)? blindTransferSubmitted,
    TResult Function(ActiveCall referorCall, ActiveCall replaceCall)?
        attendedTransferSubmitted,
    TResult Function(String callId, String referId)? attendedRequestDeclined,
    TResult Function(String referId, String referTo)? attendedRequestApproved,
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
    required TResult Function(_CallControlEventBlindTransferInitiated value)
        blindTransferInitiated,
    required TResult Function(_CallControlEventAttendedTransferInitiated value)
        attendedTransferInitiated,
    required TResult Function(_CallControlEventBlindTransferSubmitted value)
        blindTransferSubmitted,
    required TResult Function(_CallControlEventAttendedTransferSubmitted value)
        attendedTransferSubmitted,
    required TResult Function(_CallControlEventAttendedRequestDeclined value)
        attendedRequestDeclined,
    required TResult Function(_CallControlEventAttendedRequestApproved value)
        attendedRequestApproved,
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
    TResult? Function(_CallControlEventBlindTransferInitiated value)?
        blindTransferInitiated,
    TResult? Function(_CallControlEventAttendedTransferInitiated value)?
        attendedTransferInitiated,
    TResult? Function(_CallControlEventBlindTransferSubmitted value)?
        blindTransferSubmitted,
    TResult? Function(_CallControlEventAttendedTransferSubmitted value)?
        attendedTransferSubmitted,
    TResult? Function(_CallControlEventAttendedRequestDeclined value)?
        attendedRequestDeclined,
    TResult? Function(_CallControlEventAttendedRequestApproved value)?
        attendedRequestApproved,
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
    TResult Function(_CallControlEventBlindTransferInitiated value)?
        blindTransferInitiated,
    TResult Function(_CallControlEventAttendedTransferInitiated value)?
        attendedTransferInitiated,
    TResult Function(_CallControlEventBlindTransferSubmitted value)?
        blindTransferSubmitted,
    TResult Function(_CallControlEventAttendedTransferSubmitted value)?
        attendedTransferSubmitted,
    TResult Function(_CallControlEventAttendedRequestDeclined value)?
        attendedRequestDeclined,
    TResult Function(_CallControlEventAttendedRequestApproved value)?
        attendedRequestApproved,
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
    required TResult Function(String callId) blindTransferInitiated,
    required TResult Function(String callId) attendedTransferInitiated,
    required TResult Function(String number) blindTransferSubmitted,
    required TResult Function(ActiveCall referorCall, ActiveCall replaceCall)
        attendedTransferSubmitted,
    required TResult Function(String callId, String referId)
        attendedRequestDeclined,
    required TResult Function(String referId, String referTo)
        attendedRequestApproved,
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
    TResult? Function(String callId)? blindTransferInitiated,
    TResult? Function(String callId)? attendedTransferInitiated,
    TResult? Function(String number)? blindTransferSubmitted,
    TResult? Function(ActiveCall referorCall, ActiveCall replaceCall)?
        attendedTransferSubmitted,
    TResult? Function(String callId, String referId)? attendedRequestDeclined,
    TResult? Function(String referId, String referTo)? attendedRequestApproved,
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
    TResult Function(String callId)? blindTransferInitiated,
    TResult Function(String callId)? attendedTransferInitiated,
    TResult Function(String number)? blindTransferSubmitted,
    TResult Function(ActiveCall referorCall, ActiveCall replaceCall)?
        attendedTransferSubmitted,
    TResult Function(String callId, String referId)? attendedRequestDeclined,
    TResult Function(String referId, String referTo)? attendedRequestApproved,
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
    required TResult Function(_CallControlEventBlindTransferInitiated value)
        blindTransferInitiated,
    required TResult Function(_CallControlEventAttendedTransferInitiated value)
        attendedTransferInitiated,
    required TResult Function(_CallControlEventBlindTransferSubmitted value)
        blindTransferSubmitted,
    required TResult Function(_CallControlEventAttendedTransferSubmitted value)
        attendedTransferSubmitted,
    required TResult Function(_CallControlEventAttendedRequestDeclined value)
        attendedRequestDeclined,
    required TResult Function(_CallControlEventAttendedRequestApproved value)
        attendedRequestApproved,
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
    TResult? Function(_CallControlEventBlindTransferInitiated value)?
        blindTransferInitiated,
    TResult? Function(_CallControlEventAttendedTransferInitiated value)?
        attendedTransferInitiated,
    TResult? Function(_CallControlEventBlindTransferSubmitted value)?
        blindTransferSubmitted,
    TResult? Function(_CallControlEventAttendedTransferSubmitted value)?
        attendedTransferSubmitted,
    TResult? Function(_CallControlEventAttendedRequestDeclined value)?
        attendedRequestDeclined,
    TResult? Function(_CallControlEventAttendedRequestApproved value)?
        attendedRequestApproved,
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
    TResult Function(_CallControlEventBlindTransferInitiated value)?
        blindTransferInitiated,
    TResult Function(_CallControlEventAttendedTransferInitiated value)?
        attendedTransferInitiated,
    TResult Function(_CallControlEventBlindTransferSubmitted value)?
        blindTransferSubmitted,
    TResult Function(_CallControlEventAttendedTransferSubmitted value)?
        attendedTransferSubmitted,
    TResult Function(_CallControlEventAttendedRequestDeclined value)?
        attendedRequestDeclined,
    TResult Function(_CallControlEventAttendedRequestApproved value)?
        attendedRequestApproved,
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
    required TResult Function(String callId) blindTransferInitiated,
    required TResult Function(String callId) attendedTransferInitiated,
    required TResult Function(String number) blindTransferSubmitted,
    required TResult Function(ActiveCall referorCall, ActiveCall replaceCall)
        attendedTransferSubmitted,
    required TResult Function(String callId, String referId)
        attendedRequestDeclined,
    required TResult Function(String referId, String referTo)
        attendedRequestApproved,
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
    TResult? Function(String callId)? blindTransferInitiated,
    TResult? Function(String callId)? attendedTransferInitiated,
    TResult? Function(String number)? blindTransferSubmitted,
    TResult? Function(ActiveCall referorCall, ActiveCall replaceCall)?
        attendedTransferSubmitted,
    TResult? Function(String callId, String referId)? attendedRequestDeclined,
    TResult? Function(String referId, String referTo)? attendedRequestApproved,
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
    TResult Function(String callId)? blindTransferInitiated,
    TResult Function(String callId)? attendedTransferInitiated,
    TResult Function(String number)? blindTransferSubmitted,
    TResult Function(ActiveCall referorCall, ActiveCall replaceCall)?
        attendedTransferSubmitted,
    TResult Function(String callId, String referId)? attendedRequestDeclined,
    TResult Function(String referId, String referTo)? attendedRequestApproved,
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
    required TResult Function(_CallControlEventBlindTransferInitiated value)
        blindTransferInitiated,
    required TResult Function(_CallControlEventAttendedTransferInitiated value)
        attendedTransferInitiated,
    required TResult Function(_CallControlEventBlindTransferSubmitted value)
        blindTransferSubmitted,
    required TResult Function(_CallControlEventAttendedTransferSubmitted value)
        attendedTransferSubmitted,
    required TResult Function(_CallControlEventAttendedRequestDeclined value)
        attendedRequestDeclined,
    required TResult Function(_CallControlEventAttendedRequestApproved value)
        attendedRequestApproved,
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
    TResult? Function(_CallControlEventBlindTransferInitiated value)?
        blindTransferInitiated,
    TResult? Function(_CallControlEventAttendedTransferInitiated value)?
        attendedTransferInitiated,
    TResult? Function(_CallControlEventBlindTransferSubmitted value)?
        blindTransferSubmitted,
    TResult? Function(_CallControlEventAttendedTransferSubmitted value)?
        attendedTransferSubmitted,
    TResult? Function(_CallControlEventAttendedRequestDeclined value)?
        attendedRequestDeclined,
    TResult? Function(_CallControlEventAttendedRequestApproved value)?
        attendedRequestApproved,
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
    TResult Function(_CallControlEventBlindTransferInitiated value)?
        blindTransferInitiated,
    TResult Function(_CallControlEventAttendedTransferInitiated value)?
        attendedTransferInitiated,
    TResult Function(_CallControlEventBlindTransferSubmitted value)?
        blindTransferSubmitted,
    TResult Function(_CallControlEventAttendedTransferSubmitted value)?
        attendedTransferSubmitted,
    TResult Function(_CallControlEventAttendedRequestDeclined value)?
        attendedRequestDeclined,
    TResult Function(_CallControlEventAttendedRequestApproved value)?
        attendedRequestApproved,
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
    required TResult Function(String callId) blindTransferInitiated,
    required TResult Function(String callId) attendedTransferInitiated,
    required TResult Function(String number) blindTransferSubmitted,
    required TResult Function(ActiveCall referorCall, ActiveCall replaceCall)
        attendedTransferSubmitted,
    required TResult Function(String callId, String referId)
        attendedRequestDeclined,
    required TResult Function(String referId, String referTo)
        attendedRequestApproved,
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
    TResult? Function(String callId)? blindTransferInitiated,
    TResult? Function(String callId)? attendedTransferInitiated,
    TResult? Function(String number)? blindTransferSubmitted,
    TResult? Function(ActiveCall referorCall, ActiveCall replaceCall)?
        attendedTransferSubmitted,
    TResult? Function(String callId, String referId)? attendedRequestDeclined,
    TResult? Function(String referId, String referTo)? attendedRequestApproved,
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
    TResult Function(String callId)? blindTransferInitiated,
    TResult Function(String callId)? attendedTransferInitiated,
    TResult Function(String number)? blindTransferSubmitted,
    TResult Function(ActiveCall referorCall, ActiveCall replaceCall)?
        attendedTransferSubmitted,
    TResult Function(String callId, String referId)? attendedRequestDeclined,
    TResult Function(String referId, String referTo)? attendedRequestApproved,
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
    required TResult Function(_CallControlEventBlindTransferInitiated value)
        blindTransferInitiated,
    required TResult Function(_CallControlEventAttendedTransferInitiated value)
        attendedTransferInitiated,
    required TResult Function(_CallControlEventBlindTransferSubmitted value)
        blindTransferSubmitted,
    required TResult Function(_CallControlEventAttendedTransferSubmitted value)
        attendedTransferSubmitted,
    required TResult Function(_CallControlEventAttendedRequestDeclined value)
        attendedRequestDeclined,
    required TResult Function(_CallControlEventAttendedRequestApproved value)
        attendedRequestApproved,
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
    TResult? Function(_CallControlEventBlindTransferInitiated value)?
        blindTransferInitiated,
    TResult? Function(_CallControlEventAttendedTransferInitiated value)?
        attendedTransferInitiated,
    TResult? Function(_CallControlEventBlindTransferSubmitted value)?
        blindTransferSubmitted,
    TResult? Function(_CallControlEventAttendedTransferSubmitted value)?
        attendedTransferSubmitted,
    TResult? Function(_CallControlEventAttendedRequestDeclined value)?
        attendedRequestDeclined,
    TResult? Function(_CallControlEventAttendedRequestApproved value)?
        attendedRequestApproved,
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
    TResult Function(_CallControlEventBlindTransferInitiated value)?
        blindTransferInitiated,
    TResult Function(_CallControlEventAttendedTransferInitiated value)?
        attendedTransferInitiated,
    TResult Function(_CallControlEventBlindTransferSubmitted value)?
        blindTransferSubmitted,
    TResult Function(_CallControlEventAttendedTransferSubmitted value)?
        attendedTransferSubmitted,
    TResult Function(_CallControlEventAttendedRequestDeclined value)?
        attendedRequestDeclined,
    TResult Function(_CallControlEventAttendedRequestApproved value)?
        attendedRequestApproved,
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
    required TResult Function(String callId) blindTransferInitiated,
    required TResult Function(String callId) attendedTransferInitiated,
    required TResult Function(String number) blindTransferSubmitted,
    required TResult Function(ActiveCall referorCall, ActiveCall replaceCall)
        attendedTransferSubmitted,
    required TResult Function(String callId, String referId)
        attendedRequestDeclined,
    required TResult Function(String referId, String referTo)
        attendedRequestApproved,
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
    TResult? Function(String callId)? blindTransferInitiated,
    TResult? Function(String callId)? attendedTransferInitiated,
    TResult? Function(String number)? blindTransferSubmitted,
    TResult? Function(ActiveCall referorCall, ActiveCall replaceCall)?
        attendedTransferSubmitted,
    TResult? Function(String callId, String referId)? attendedRequestDeclined,
    TResult? Function(String referId, String referTo)? attendedRequestApproved,
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
    TResult Function(String callId)? blindTransferInitiated,
    TResult Function(String callId)? attendedTransferInitiated,
    TResult Function(String number)? blindTransferSubmitted,
    TResult Function(ActiveCall referorCall, ActiveCall replaceCall)?
        attendedTransferSubmitted,
    TResult Function(String callId, String referId)? attendedRequestDeclined,
    TResult Function(String referId, String referTo)? attendedRequestApproved,
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
    required TResult Function(_CallControlEventBlindTransferInitiated value)
        blindTransferInitiated,
    required TResult Function(_CallControlEventAttendedTransferInitiated value)
        attendedTransferInitiated,
    required TResult Function(_CallControlEventBlindTransferSubmitted value)
        blindTransferSubmitted,
    required TResult Function(_CallControlEventAttendedTransferSubmitted value)
        attendedTransferSubmitted,
    required TResult Function(_CallControlEventAttendedRequestDeclined value)
        attendedRequestDeclined,
    required TResult Function(_CallControlEventAttendedRequestApproved value)
        attendedRequestApproved,
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
    TResult? Function(_CallControlEventBlindTransferInitiated value)?
        blindTransferInitiated,
    TResult? Function(_CallControlEventAttendedTransferInitiated value)?
        attendedTransferInitiated,
    TResult? Function(_CallControlEventBlindTransferSubmitted value)?
        blindTransferSubmitted,
    TResult? Function(_CallControlEventAttendedTransferSubmitted value)?
        attendedTransferSubmitted,
    TResult? Function(_CallControlEventAttendedRequestDeclined value)?
        attendedRequestDeclined,
    TResult? Function(_CallControlEventAttendedRequestApproved value)?
        attendedRequestApproved,
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
    TResult Function(_CallControlEventBlindTransferInitiated value)?
        blindTransferInitiated,
    TResult Function(_CallControlEventAttendedTransferInitiated value)?
        attendedTransferInitiated,
    TResult Function(_CallControlEventBlindTransferSubmitted value)?
        blindTransferSubmitted,
    TResult Function(_CallControlEventAttendedTransferSubmitted value)?
        attendedTransferSubmitted,
    TResult Function(_CallControlEventAttendedRequestDeclined value)?
        attendedRequestDeclined,
    TResult Function(_CallControlEventAttendedRequestApproved value)?
        attendedRequestApproved,
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
    required TResult Function(String callId) blindTransferInitiated,
    required TResult Function(String callId) attendedTransferInitiated,
    required TResult Function(String number) blindTransferSubmitted,
    required TResult Function(ActiveCall referorCall, ActiveCall replaceCall)
        attendedTransferSubmitted,
    required TResult Function(String callId, String referId)
        attendedRequestDeclined,
    required TResult Function(String referId, String referTo)
        attendedRequestApproved,
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
    TResult? Function(String callId)? blindTransferInitiated,
    TResult? Function(String callId)? attendedTransferInitiated,
    TResult? Function(String number)? blindTransferSubmitted,
    TResult? Function(ActiveCall referorCall, ActiveCall replaceCall)?
        attendedTransferSubmitted,
    TResult? Function(String callId, String referId)? attendedRequestDeclined,
    TResult? Function(String referId, String referTo)? attendedRequestApproved,
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
    TResult Function(String callId)? blindTransferInitiated,
    TResult Function(String callId)? attendedTransferInitiated,
    TResult Function(String number)? blindTransferSubmitted,
    TResult Function(ActiveCall referorCall, ActiveCall replaceCall)?
        attendedTransferSubmitted,
    TResult Function(String callId, String referId)? attendedRequestDeclined,
    TResult Function(String referId, String referTo)? attendedRequestApproved,
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
    required TResult Function(_CallControlEventBlindTransferInitiated value)
        blindTransferInitiated,
    required TResult Function(_CallControlEventAttendedTransferInitiated value)
        attendedTransferInitiated,
    required TResult Function(_CallControlEventBlindTransferSubmitted value)
        blindTransferSubmitted,
    required TResult Function(_CallControlEventAttendedTransferSubmitted value)
        attendedTransferSubmitted,
    required TResult Function(_CallControlEventAttendedRequestDeclined value)
        attendedRequestDeclined,
    required TResult Function(_CallControlEventAttendedRequestApproved value)
        attendedRequestApproved,
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
    TResult? Function(_CallControlEventBlindTransferInitiated value)?
        blindTransferInitiated,
    TResult? Function(_CallControlEventAttendedTransferInitiated value)?
        attendedTransferInitiated,
    TResult? Function(_CallControlEventBlindTransferSubmitted value)?
        blindTransferSubmitted,
    TResult? Function(_CallControlEventAttendedTransferSubmitted value)?
        attendedTransferSubmitted,
    TResult? Function(_CallControlEventAttendedRequestDeclined value)?
        attendedRequestDeclined,
    TResult? Function(_CallControlEventAttendedRequestApproved value)?
        attendedRequestApproved,
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
    TResult Function(_CallControlEventBlindTransferInitiated value)?
        blindTransferInitiated,
    TResult Function(_CallControlEventAttendedTransferInitiated value)?
        attendedTransferInitiated,
    TResult Function(_CallControlEventBlindTransferSubmitted value)?
        blindTransferSubmitted,
    TResult Function(_CallControlEventAttendedTransferSubmitted value)?
        attendedTransferSubmitted,
    TResult Function(_CallControlEventAttendedRequestDeclined value)?
        attendedRequestDeclined,
    TResult Function(_CallControlEventAttendedRequestApproved value)?
        attendedRequestApproved,
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
    required TResult Function(String callId) blindTransferInitiated,
    required TResult Function(String callId) attendedTransferInitiated,
    required TResult Function(String number) blindTransferSubmitted,
    required TResult Function(ActiveCall referorCall, ActiveCall replaceCall)
        attendedTransferSubmitted,
    required TResult Function(String callId, String referId)
        attendedRequestDeclined,
    required TResult Function(String referId, String referTo)
        attendedRequestApproved,
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
    TResult? Function(String callId)? blindTransferInitiated,
    TResult? Function(String callId)? attendedTransferInitiated,
    TResult? Function(String number)? blindTransferSubmitted,
    TResult? Function(ActiveCall referorCall, ActiveCall replaceCall)?
        attendedTransferSubmitted,
    TResult? Function(String callId, String referId)? attendedRequestDeclined,
    TResult? Function(String referId, String referTo)? attendedRequestApproved,
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
    TResult Function(String callId)? blindTransferInitiated,
    TResult Function(String callId)? attendedTransferInitiated,
    TResult Function(String number)? blindTransferSubmitted,
    TResult Function(ActiveCall referorCall, ActiveCall replaceCall)?
        attendedTransferSubmitted,
    TResult Function(String callId, String referId)? attendedRequestDeclined,
    TResult Function(String referId, String referTo)? attendedRequestApproved,
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
    required TResult Function(_CallControlEventBlindTransferInitiated value)
        blindTransferInitiated,
    required TResult Function(_CallControlEventAttendedTransferInitiated value)
        attendedTransferInitiated,
    required TResult Function(_CallControlEventBlindTransferSubmitted value)
        blindTransferSubmitted,
    required TResult Function(_CallControlEventAttendedTransferSubmitted value)
        attendedTransferSubmitted,
    required TResult Function(_CallControlEventAttendedRequestDeclined value)
        attendedRequestDeclined,
    required TResult Function(_CallControlEventAttendedRequestApproved value)
        attendedRequestApproved,
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
    TResult? Function(_CallControlEventBlindTransferInitiated value)?
        blindTransferInitiated,
    TResult? Function(_CallControlEventAttendedTransferInitiated value)?
        attendedTransferInitiated,
    TResult? Function(_CallControlEventBlindTransferSubmitted value)?
        blindTransferSubmitted,
    TResult? Function(_CallControlEventAttendedTransferSubmitted value)?
        attendedTransferSubmitted,
    TResult? Function(_CallControlEventAttendedRequestDeclined value)?
        attendedRequestDeclined,
    TResult? Function(_CallControlEventAttendedRequestApproved value)?
        attendedRequestApproved,
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
    TResult Function(_CallControlEventBlindTransferInitiated value)?
        blindTransferInitiated,
    TResult Function(_CallControlEventAttendedTransferInitiated value)?
        attendedTransferInitiated,
    TResult Function(_CallControlEventBlindTransferSubmitted value)?
        blindTransferSubmitted,
    TResult Function(_CallControlEventAttendedTransferSubmitted value)?
        attendedTransferSubmitted,
    TResult Function(_CallControlEventAttendedRequestDeclined value)?
        attendedRequestDeclined,
    TResult Function(_CallControlEventAttendedRequestApproved value)?
        attendedRequestApproved,
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

class _$CallControlEventBlindTransferInitiatedImpl
    with DiagnosticableTreeMixin
    implements _CallControlEventBlindTransferInitiated {
  const _$CallControlEventBlindTransferInitiatedImpl(this.callId);

  @override
  final String callId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallControlEvent.blindTransferInitiated(callId: $callId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty(
          'type', 'CallControlEvent.blindTransferInitiated'))
      ..add(DiagnosticsProperty('callId', callId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallControlEventBlindTransferInitiatedImpl &&
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
    required TResult Function(String callId) blindTransferInitiated,
    required TResult Function(String callId) attendedTransferInitiated,
    required TResult Function(String number) blindTransferSubmitted,
    required TResult Function(ActiveCall referorCall, ActiveCall replaceCall)
        attendedTransferSubmitted,
    required TResult Function(String callId, String referId)
        attendedRequestDeclined,
    required TResult Function(String referId, String referTo)
        attendedRequestApproved,
  }) {
    return blindTransferInitiated(callId);
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
    TResult? Function(String callId)? blindTransferInitiated,
    TResult? Function(String callId)? attendedTransferInitiated,
    TResult? Function(String number)? blindTransferSubmitted,
    TResult? Function(ActiveCall referorCall, ActiveCall replaceCall)?
        attendedTransferSubmitted,
    TResult? Function(String callId, String referId)? attendedRequestDeclined,
    TResult? Function(String referId, String referTo)? attendedRequestApproved,
  }) {
    return blindTransferInitiated?.call(callId);
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
    TResult Function(String callId)? blindTransferInitiated,
    TResult Function(String callId)? attendedTransferInitiated,
    TResult Function(String number)? blindTransferSubmitted,
    TResult Function(ActiveCall referorCall, ActiveCall replaceCall)?
        attendedTransferSubmitted,
    TResult Function(String callId, String referId)? attendedRequestDeclined,
    TResult Function(String referId, String referTo)? attendedRequestApproved,
    required TResult orElse(),
  }) {
    if (blindTransferInitiated != null) {
      return blindTransferInitiated(callId);
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
    required TResult Function(_CallControlEventBlindTransferInitiated value)
        blindTransferInitiated,
    required TResult Function(_CallControlEventAttendedTransferInitiated value)
        attendedTransferInitiated,
    required TResult Function(_CallControlEventBlindTransferSubmitted value)
        blindTransferSubmitted,
    required TResult Function(_CallControlEventAttendedTransferSubmitted value)
        attendedTransferSubmitted,
    required TResult Function(_CallControlEventAttendedRequestDeclined value)
        attendedRequestDeclined,
    required TResult Function(_CallControlEventAttendedRequestApproved value)
        attendedRequestApproved,
  }) {
    return blindTransferInitiated(this);
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
    TResult? Function(_CallControlEventBlindTransferInitiated value)?
        blindTransferInitiated,
    TResult? Function(_CallControlEventAttendedTransferInitiated value)?
        attendedTransferInitiated,
    TResult? Function(_CallControlEventBlindTransferSubmitted value)?
        blindTransferSubmitted,
    TResult? Function(_CallControlEventAttendedTransferSubmitted value)?
        attendedTransferSubmitted,
    TResult? Function(_CallControlEventAttendedRequestDeclined value)?
        attendedRequestDeclined,
    TResult? Function(_CallControlEventAttendedRequestApproved value)?
        attendedRequestApproved,
  }) {
    return blindTransferInitiated?.call(this);
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
    TResult Function(_CallControlEventBlindTransferInitiated value)?
        blindTransferInitiated,
    TResult Function(_CallControlEventAttendedTransferInitiated value)?
        attendedTransferInitiated,
    TResult Function(_CallControlEventBlindTransferSubmitted value)?
        blindTransferSubmitted,
    TResult Function(_CallControlEventAttendedTransferSubmitted value)?
        attendedTransferSubmitted,
    TResult Function(_CallControlEventAttendedRequestDeclined value)?
        attendedRequestDeclined,
    TResult Function(_CallControlEventAttendedRequestApproved value)?
        attendedRequestApproved,
    required TResult orElse(),
  }) {
    if (blindTransferInitiated != null) {
      return blindTransferInitiated(this);
    }
    return orElse();
  }
}

abstract class _CallControlEventBlindTransferInitiated
    implements CallControlEvent {
  const factory _CallControlEventBlindTransferInitiated(final String callId) =
      _$CallControlEventBlindTransferInitiatedImpl;

  String get callId;
}

/// @nodoc

class _$CallControlEventAttendedTransferInitiatedImpl
    with DiagnosticableTreeMixin
    implements _CallControlEventAttendedTransferInitiated {
  const _$CallControlEventAttendedTransferInitiatedImpl(this.callId);

  @override
  final String callId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallControlEvent.attendedTransferInitiated(callId: $callId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty(
          'type', 'CallControlEvent.attendedTransferInitiated'))
      ..add(DiagnosticsProperty('callId', callId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallControlEventAttendedTransferInitiatedImpl &&
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
    required TResult Function(String callId) blindTransferInitiated,
    required TResult Function(String callId) attendedTransferInitiated,
    required TResult Function(String number) blindTransferSubmitted,
    required TResult Function(ActiveCall referorCall, ActiveCall replaceCall)
        attendedTransferSubmitted,
    required TResult Function(String callId, String referId)
        attendedRequestDeclined,
    required TResult Function(String referId, String referTo)
        attendedRequestApproved,
  }) {
    return attendedTransferInitiated(callId);
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
    TResult? Function(String callId)? blindTransferInitiated,
    TResult? Function(String callId)? attendedTransferInitiated,
    TResult? Function(String number)? blindTransferSubmitted,
    TResult? Function(ActiveCall referorCall, ActiveCall replaceCall)?
        attendedTransferSubmitted,
    TResult? Function(String callId, String referId)? attendedRequestDeclined,
    TResult? Function(String referId, String referTo)? attendedRequestApproved,
  }) {
    return attendedTransferInitiated?.call(callId);
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
    TResult Function(String callId)? blindTransferInitiated,
    TResult Function(String callId)? attendedTransferInitiated,
    TResult Function(String number)? blindTransferSubmitted,
    TResult Function(ActiveCall referorCall, ActiveCall replaceCall)?
        attendedTransferSubmitted,
    TResult Function(String callId, String referId)? attendedRequestDeclined,
    TResult Function(String referId, String referTo)? attendedRequestApproved,
    required TResult orElse(),
  }) {
    if (attendedTransferInitiated != null) {
      return attendedTransferInitiated(callId);
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
    required TResult Function(_CallControlEventBlindTransferInitiated value)
        blindTransferInitiated,
    required TResult Function(_CallControlEventAttendedTransferInitiated value)
        attendedTransferInitiated,
    required TResult Function(_CallControlEventBlindTransferSubmitted value)
        blindTransferSubmitted,
    required TResult Function(_CallControlEventAttendedTransferSubmitted value)
        attendedTransferSubmitted,
    required TResult Function(_CallControlEventAttendedRequestDeclined value)
        attendedRequestDeclined,
    required TResult Function(_CallControlEventAttendedRequestApproved value)
        attendedRequestApproved,
  }) {
    return attendedTransferInitiated(this);
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
    TResult? Function(_CallControlEventBlindTransferInitiated value)?
        blindTransferInitiated,
    TResult? Function(_CallControlEventAttendedTransferInitiated value)?
        attendedTransferInitiated,
    TResult? Function(_CallControlEventBlindTransferSubmitted value)?
        blindTransferSubmitted,
    TResult? Function(_CallControlEventAttendedTransferSubmitted value)?
        attendedTransferSubmitted,
    TResult? Function(_CallControlEventAttendedRequestDeclined value)?
        attendedRequestDeclined,
    TResult? Function(_CallControlEventAttendedRequestApproved value)?
        attendedRequestApproved,
  }) {
    return attendedTransferInitiated?.call(this);
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
    TResult Function(_CallControlEventBlindTransferInitiated value)?
        blindTransferInitiated,
    TResult Function(_CallControlEventAttendedTransferInitiated value)?
        attendedTransferInitiated,
    TResult Function(_CallControlEventBlindTransferSubmitted value)?
        blindTransferSubmitted,
    TResult Function(_CallControlEventAttendedTransferSubmitted value)?
        attendedTransferSubmitted,
    TResult Function(_CallControlEventAttendedRequestDeclined value)?
        attendedRequestDeclined,
    TResult Function(_CallControlEventAttendedRequestApproved value)?
        attendedRequestApproved,
    required TResult orElse(),
  }) {
    if (attendedTransferInitiated != null) {
      return attendedTransferInitiated(this);
    }
    return orElse();
  }
}

abstract class _CallControlEventAttendedTransferInitiated
    implements CallControlEvent {
  const factory _CallControlEventAttendedTransferInitiated(
      final String callId) = _$CallControlEventAttendedTransferInitiatedImpl;

  String get callId;
}

/// @nodoc

class _$CallControlEventBlindTransferSubmittedImpl
    with DiagnosticableTreeMixin
    implements _CallControlEventBlindTransferSubmitted {
  const _$CallControlEventBlindTransferSubmittedImpl({required this.number});

  @override
  final String number;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallControlEvent.blindTransferSubmitted(number: $number)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty(
          'type', 'CallControlEvent.blindTransferSubmitted'))
      ..add(DiagnosticsProperty('number', number));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallControlEventBlindTransferSubmittedImpl &&
            (identical(other.number, number) || other.number == number));
  }

  @override
  int get hashCode => Object.hash(runtimeType, number);

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
    required TResult Function(String callId) blindTransferInitiated,
    required TResult Function(String callId) attendedTransferInitiated,
    required TResult Function(String number) blindTransferSubmitted,
    required TResult Function(ActiveCall referorCall, ActiveCall replaceCall)
        attendedTransferSubmitted,
    required TResult Function(String callId, String referId)
        attendedRequestDeclined,
    required TResult Function(String referId, String referTo)
        attendedRequestApproved,
  }) {
    return blindTransferSubmitted(number);
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
    TResult? Function(String callId)? blindTransferInitiated,
    TResult? Function(String callId)? attendedTransferInitiated,
    TResult? Function(String number)? blindTransferSubmitted,
    TResult? Function(ActiveCall referorCall, ActiveCall replaceCall)?
        attendedTransferSubmitted,
    TResult? Function(String callId, String referId)? attendedRequestDeclined,
    TResult? Function(String referId, String referTo)? attendedRequestApproved,
  }) {
    return blindTransferSubmitted?.call(number);
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
    TResult Function(String callId)? blindTransferInitiated,
    TResult Function(String callId)? attendedTransferInitiated,
    TResult Function(String number)? blindTransferSubmitted,
    TResult Function(ActiveCall referorCall, ActiveCall replaceCall)?
        attendedTransferSubmitted,
    TResult Function(String callId, String referId)? attendedRequestDeclined,
    TResult Function(String referId, String referTo)? attendedRequestApproved,
    required TResult orElse(),
  }) {
    if (blindTransferSubmitted != null) {
      return blindTransferSubmitted(number);
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
    required TResult Function(_CallControlEventBlindTransferInitiated value)
        blindTransferInitiated,
    required TResult Function(_CallControlEventAttendedTransferInitiated value)
        attendedTransferInitiated,
    required TResult Function(_CallControlEventBlindTransferSubmitted value)
        blindTransferSubmitted,
    required TResult Function(_CallControlEventAttendedTransferSubmitted value)
        attendedTransferSubmitted,
    required TResult Function(_CallControlEventAttendedRequestDeclined value)
        attendedRequestDeclined,
    required TResult Function(_CallControlEventAttendedRequestApproved value)
        attendedRequestApproved,
  }) {
    return blindTransferSubmitted(this);
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
    TResult? Function(_CallControlEventBlindTransferInitiated value)?
        blindTransferInitiated,
    TResult? Function(_CallControlEventAttendedTransferInitiated value)?
        attendedTransferInitiated,
    TResult? Function(_CallControlEventBlindTransferSubmitted value)?
        blindTransferSubmitted,
    TResult? Function(_CallControlEventAttendedTransferSubmitted value)?
        attendedTransferSubmitted,
    TResult? Function(_CallControlEventAttendedRequestDeclined value)?
        attendedRequestDeclined,
    TResult? Function(_CallControlEventAttendedRequestApproved value)?
        attendedRequestApproved,
  }) {
    return blindTransferSubmitted?.call(this);
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
    TResult Function(_CallControlEventBlindTransferInitiated value)?
        blindTransferInitiated,
    TResult Function(_CallControlEventAttendedTransferInitiated value)?
        attendedTransferInitiated,
    TResult Function(_CallControlEventBlindTransferSubmitted value)?
        blindTransferSubmitted,
    TResult Function(_CallControlEventAttendedTransferSubmitted value)?
        attendedTransferSubmitted,
    TResult Function(_CallControlEventAttendedRequestDeclined value)?
        attendedRequestDeclined,
    TResult Function(_CallControlEventAttendedRequestApproved value)?
        attendedRequestApproved,
    required TResult orElse(),
  }) {
    if (blindTransferSubmitted != null) {
      return blindTransferSubmitted(this);
    }
    return orElse();
  }
}

abstract class _CallControlEventBlindTransferSubmitted
    implements CallControlEvent {
  const factory _CallControlEventBlindTransferSubmitted(
          {required final String number}) =
      _$CallControlEventBlindTransferSubmittedImpl;

  String get number;
}

/// @nodoc

class _$CallControlEventAttendedTransferSubmittedImpl
    with DiagnosticableTreeMixin
    implements _CallControlEventAttendedTransferSubmitted {
  const _$CallControlEventAttendedTransferSubmittedImpl(
      {required this.referorCall, required this.replaceCall});

  @override
  final ActiveCall referorCall;
  @override
  final ActiveCall replaceCall;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallControlEvent.attendedTransferSubmitted(referorCall: $referorCall, replaceCall: $replaceCall)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty(
          'type', 'CallControlEvent.attendedTransferSubmitted'))
      ..add(DiagnosticsProperty('referorCall', referorCall))
      ..add(DiagnosticsProperty('replaceCall', replaceCall));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallControlEventAttendedTransferSubmittedImpl &&
            (identical(other.referorCall, referorCall) ||
                other.referorCall == referorCall) &&
            (identical(other.replaceCall, replaceCall) ||
                other.replaceCall == replaceCall));
  }

  @override
  int get hashCode => Object.hash(runtimeType, referorCall, replaceCall);

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
    required TResult Function(String callId) blindTransferInitiated,
    required TResult Function(String callId) attendedTransferInitiated,
    required TResult Function(String number) blindTransferSubmitted,
    required TResult Function(ActiveCall referorCall, ActiveCall replaceCall)
        attendedTransferSubmitted,
    required TResult Function(String callId, String referId)
        attendedRequestDeclined,
    required TResult Function(String referId, String referTo)
        attendedRequestApproved,
  }) {
    return attendedTransferSubmitted(referorCall, replaceCall);
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
    TResult? Function(String callId)? blindTransferInitiated,
    TResult? Function(String callId)? attendedTransferInitiated,
    TResult? Function(String number)? blindTransferSubmitted,
    TResult? Function(ActiveCall referorCall, ActiveCall replaceCall)?
        attendedTransferSubmitted,
    TResult? Function(String callId, String referId)? attendedRequestDeclined,
    TResult? Function(String referId, String referTo)? attendedRequestApproved,
  }) {
    return attendedTransferSubmitted?.call(referorCall, replaceCall);
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
    TResult Function(String callId)? blindTransferInitiated,
    TResult Function(String callId)? attendedTransferInitiated,
    TResult Function(String number)? blindTransferSubmitted,
    TResult Function(ActiveCall referorCall, ActiveCall replaceCall)?
        attendedTransferSubmitted,
    TResult Function(String callId, String referId)? attendedRequestDeclined,
    TResult Function(String referId, String referTo)? attendedRequestApproved,
    required TResult orElse(),
  }) {
    if (attendedTransferSubmitted != null) {
      return attendedTransferSubmitted(referorCall, replaceCall);
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
    required TResult Function(_CallControlEventBlindTransferInitiated value)
        blindTransferInitiated,
    required TResult Function(_CallControlEventAttendedTransferInitiated value)
        attendedTransferInitiated,
    required TResult Function(_CallControlEventBlindTransferSubmitted value)
        blindTransferSubmitted,
    required TResult Function(_CallControlEventAttendedTransferSubmitted value)
        attendedTransferSubmitted,
    required TResult Function(_CallControlEventAttendedRequestDeclined value)
        attendedRequestDeclined,
    required TResult Function(_CallControlEventAttendedRequestApproved value)
        attendedRequestApproved,
  }) {
    return attendedTransferSubmitted(this);
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
    TResult? Function(_CallControlEventBlindTransferInitiated value)?
        blindTransferInitiated,
    TResult? Function(_CallControlEventAttendedTransferInitiated value)?
        attendedTransferInitiated,
    TResult? Function(_CallControlEventBlindTransferSubmitted value)?
        blindTransferSubmitted,
    TResult? Function(_CallControlEventAttendedTransferSubmitted value)?
        attendedTransferSubmitted,
    TResult? Function(_CallControlEventAttendedRequestDeclined value)?
        attendedRequestDeclined,
    TResult? Function(_CallControlEventAttendedRequestApproved value)?
        attendedRequestApproved,
  }) {
    return attendedTransferSubmitted?.call(this);
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
    TResult Function(_CallControlEventBlindTransferInitiated value)?
        blindTransferInitiated,
    TResult Function(_CallControlEventAttendedTransferInitiated value)?
        attendedTransferInitiated,
    TResult Function(_CallControlEventBlindTransferSubmitted value)?
        blindTransferSubmitted,
    TResult Function(_CallControlEventAttendedTransferSubmitted value)?
        attendedTransferSubmitted,
    TResult Function(_CallControlEventAttendedRequestDeclined value)?
        attendedRequestDeclined,
    TResult Function(_CallControlEventAttendedRequestApproved value)?
        attendedRequestApproved,
    required TResult orElse(),
  }) {
    if (attendedTransferSubmitted != null) {
      return attendedTransferSubmitted(this);
    }
    return orElse();
  }
}

abstract class _CallControlEventAttendedTransferSubmitted
    implements CallControlEvent {
  const factory _CallControlEventAttendedTransferSubmitted(
          {required final ActiveCall referorCall,
          required final ActiveCall replaceCall}) =
      _$CallControlEventAttendedTransferSubmittedImpl;

  ActiveCall get referorCall;
  ActiveCall get replaceCall;
}

/// @nodoc

class _$CallControlEventAttendedRequestDeclinedImpl
    with DiagnosticableTreeMixin
    implements _CallControlEventAttendedRequestDeclined {
  const _$CallControlEventAttendedRequestDeclinedImpl(
      {required this.callId, required this.referId});

  @override
  final String callId;
  @override
  final String referId;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallControlEvent.attendedRequestDeclined(callId: $callId, referId: $referId)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty(
          'type', 'CallControlEvent.attendedRequestDeclined'))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('referId', referId));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallControlEventAttendedRequestDeclinedImpl &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.referId, referId) || other.referId == referId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callId, referId);

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
    required TResult Function(String callId) blindTransferInitiated,
    required TResult Function(String callId) attendedTransferInitiated,
    required TResult Function(String number) blindTransferSubmitted,
    required TResult Function(ActiveCall referorCall, ActiveCall replaceCall)
        attendedTransferSubmitted,
    required TResult Function(String callId, String referId)
        attendedRequestDeclined,
    required TResult Function(String referId, String referTo)
        attendedRequestApproved,
  }) {
    return attendedRequestDeclined(callId, referId);
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
    TResult? Function(String callId)? blindTransferInitiated,
    TResult? Function(String callId)? attendedTransferInitiated,
    TResult? Function(String number)? blindTransferSubmitted,
    TResult? Function(ActiveCall referorCall, ActiveCall replaceCall)?
        attendedTransferSubmitted,
    TResult? Function(String callId, String referId)? attendedRequestDeclined,
    TResult? Function(String referId, String referTo)? attendedRequestApproved,
  }) {
    return attendedRequestDeclined?.call(callId, referId);
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
    TResult Function(String callId)? blindTransferInitiated,
    TResult Function(String callId)? attendedTransferInitiated,
    TResult Function(String number)? blindTransferSubmitted,
    TResult Function(ActiveCall referorCall, ActiveCall replaceCall)?
        attendedTransferSubmitted,
    TResult Function(String callId, String referId)? attendedRequestDeclined,
    TResult Function(String referId, String referTo)? attendedRequestApproved,
    required TResult orElse(),
  }) {
    if (attendedRequestDeclined != null) {
      return attendedRequestDeclined(callId, referId);
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
    required TResult Function(_CallControlEventBlindTransferInitiated value)
        blindTransferInitiated,
    required TResult Function(_CallControlEventAttendedTransferInitiated value)
        attendedTransferInitiated,
    required TResult Function(_CallControlEventBlindTransferSubmitted value)
        blindTransferSubmitted,
    required TResult Function(_CallControlEventAttendedTransferSubmitted value)
        attendedTransferSubmitted,
    required TResult Function(_CallControlEventAttendedRequestDeclined value)
        attendedRequestDeclined,
    required TResult Function(_CallControlEventAttendedRequestApproved value)
        attendedRequestApproved,
  }) {
    return attendedRequestDeclined(this);
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
    TResult? Function(_CallControlEventBlindTransferInitiated value)?
        blindTransferInitiated,
    TResult? Function(_CallControlEventAttendedTransferInitiated value)?
        attendedTransferInitiated,
    TResult? Function(_CallControlEventBlindTransferSubmitted value)?
        blindTransferSubmitted,
    TResult? Function(_CallControlEventAttendedTransferSubmitted value)?
        attendedTransferSubmitted,
    TResult? Function(_CallControlEventAttendedRequestDeclined value)?
        attendedRequestDeclined,
    TResult? Function(_CallControlEventAttendedRequestApproved value)?
        attendedRequestApproved,
  }) {
    return attendedRequestDeclined?.call(this);
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
    TResult Function(_CallControlEventBlindTransferInitiated value)?
        blindTransferInitiated,
    TResult Function(_CallControlEventAttendedTransferInitiated value)?
        attendedTransferInitiated,
    TResult Function(_CallControlEventBlindTransferSubmitted value)?
        blindTransferSubmitted,
    TResult Function(_CallControlEventAttendedTransferSubmitted value)?
        attendedTransferSubmitted,
    TResult Function(_CallControlEventAttendedRequestDeclined value)?
        attendedRequestDeclined,
    TResult Function(_CallControlEventAttendedRequestApproved value)?
        attendedRequestApproved,
    required TResult orElse(),
  }) {
    if (attendedRequestDeclined != null) {
      return attendedRequestDeclined(this);
    }
    return orElse();
  }
}

abstract class _CallControlEventAttendedRequestDeclined
    implements CallControlEvent {
  const factory _CallControlEventAttendedRequestDeclined(
          {required final String callId, required final String referId}) =
      _$CallControlEventAttendedRequestDeclinedImpl;

  String get callId;
  String get referId;
}

/// @nodoc

class _$CallControlEventAttendedRequestApprovedImpl
    with DiagnosticableTreeMixin
    implements _CallControlEventAttendedRequestApproved {
  const _$CallControlEventAttendedRequestApprovedImpl(
      {required this.referId, required this.referTo});

  @override
  final String referId;
  @override
  final String referTo;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CallControlEvent.attendedRequestApproved(referId: $referId, referTo: $referTo)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty(
          'type', 'CallControlEvent.attendedRequestApproved'))
      ..add(DiagnosticsProperty('referId', referId))
      ..add(DiagnosticsProperty('referTo', referTo));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallControlEventAttendedRequestApprovedImpl &&
            (identical(other.referId, referId) || other.referId == referId) &&
            (identical(other.referTo, referTo) || other.referTo == referTo));
  }

  @override
  int get hashCode => Object.hash(runtimeType, referId, referTo);

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
    required TResult Function(String callId) blindTransferInitiated,
    required TResult Function(String callId) attendedTransferInitiated,
    required TResult Function(String number) blindTransferSubmitted,
    required TResult Function(ActiveCall referorCall, ActiveCall replaceCall)
        attendedTransferSubmitted,
    required TResult Function(String callId, String referId)
        attendedRequestDeclined,
    required TResult Function(String referId, String referTo)
        attendedRequestApproved,
  }) {
    return attendedRequestApproved(referId, referTo);
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
    TResult? Function(String callId)? blindTransferInitiated,
    TResult? Function(String callId)? attendedTransferInitiated,
    TResult? Function(String number)? blindTransferSubmitted,
    TResult? Function(ActiveCall referorCall, ActiveCall replaceCall)?
        attendedTransferSubmitted,
    TResult? Function(String callId, String referId)? attendedRequestDeclined,
    TResult? Function(String referId, String referTo)? attendedRequestApproved,
  }) {
    return attendedRequestApproved?.call(referId, referTo);
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
    TResult Function(String callId)? blindTransferInitiated,
    TResult Function(String callId)? attendedTransferInitiated,
    TResult Function(String number)? blindTransferSubmitted,
    TResult Function(ActiveCall referorCall, ActiveCall replaceCall)?
        attendedTransferSubmitted,
    TResult Function(String callId, String referId)? attendedRequestDeclined,
    TResult Function(String referId, String referTo)? attendedRequestApproved,
    required TResult orElse(),
  }) {
    if (attendedRequestApproved != null) {
      return attendedRequestApproved(referId, referTo);
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
    required TResult Function(_CallControlEventBlindTransferInitiated value)
        blindTransferInitiated,
    required TResult Function(_CallControlEventAttendedTransferInitiated value)
        attendedTransferInitiated,
    required TResult Function(_CallControlEventBlindTransferSubmitted value)
        blindTransferSubmitted,
    required TResult Function(_CallControlEventAttendedTransferSubmitted value)
        attendedTransferSubmitted,
    required TResult Function(_CallControlEventAttendedRequestDeclined value)
        attendedRequestDeclined,
    required TResult Function(_CallControlEventAttendedRequestApproved value)
        attendedRequestApproved,
  }) {
    return attendedRequestApproved(this);
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
    TResult? Function(_CallControlEventBlindTransferInitiated value)?
        blindTransferInitiated,
    TResult? Function(_CallControlEventAttendedTransferInitiated value)?
        attendedTransferInitiated,
    TResult? Function(_CallControlEventBlindTransferSubmitted value)?
        blindTransferSubmitted,
    TResult? Function(_CallControlEventAttendedTransferSubmitted value)?
        attendedTransferSubmitted,
    TResult? Function(_CallControlEventAttendedRequestDeclined value)?
        attendedRequestDeclined,
    TResult? Function(_CallControlEventAttendedRequestApproved value)?
        attendedRequestApproved,
  }) {
    return attendedRequestApproved?.call(this);
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
    TResult Function(_CallControlEventBlindTransferInitiated value)?
        blindTransferInitiated,
    TResult Function(_CallControlEventAttendedTransferInitiated value)?
        attendedTransferInitiated,
    TResult Function(_CallControlEventBlindTransferSubmitted value)?
        blindTransferSubmitted,
    TResult Function(_CallControlEventAttendedTransferSubmitted value)?
        attendedTransferSubmitted,
    TResult Function(_CallControlEventAttendedRequestDeclined value)?
        attendedRequestDeclined,
    TResult Function(_CallControlEventAttendedRequestApproved value)?
        attendedRequestApproved,
    required TResult orElse(),
  }) {
    if (attendedRequestApproved != null) {
      return attendedRequestApproved(this);
    }
    return orElse();
  }
}

abstract class _CallControlEventAttendedRequestApproved
    implements CallControlEvent {
  const factory _CallControlEventAttendedRequestApproved(
          {required final String referId, required final String referTo}) =
      _$CallControlEventAttendedRequestApprovedImpl;

  String get referId;
  String get referTo;
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
    required TResult Function(String callId, bool enabled) setSpeaker,
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
    TResult? Function(String callId, bool enabled)? setSpeaker,
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
    TResult Function(String callId, bool enabled)? setSpeaker,
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
    required TResult Function(_CallPerformEventSetSpeaker value) setSpeaker,
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
    TResult? Function(_CallPerformEventSetSpeaker value)? setSpeaker,
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
    TResult Function(_CallPerformEventSetSpeaker value)? setSpeaker,
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
    required TResult Function(String callId, bool enabled) setSpeaker,
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
    TResult? Function(String callId, bool enabled)? setSpeaker,
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
    TResult Function(String callId, bool enabled)? setSpeaker,
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
    required TResult Function(_CallPerformEventSetSpeaker value) setSpeaker,
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
    TResult? Function(_CallPerformEventSetSpeaker value)? setSpeaker,
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
    TResult Function(_CallPerformEventSetSpeaker value)? setSpeaker,
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
    required TResult Function(String callId, bool enabled) setSpeaker,
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
    TResult? Function(String callId, bool enabled)? setSpeaker,
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
    TResult Function(String callId, bool enabled)? setSpeaker,
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
    required TResult Function(_CallPerformEventSetSpeaker value) setSpeaker,
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
    TResult? Function(_CallPerformEventSetSpeaker value)? setSpeaker,
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
    TResult Function(_CallPerformEventSetSpeaker value)? setSpeaker,
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
    required TResult Function(String callId, bool enabled) setSpeaker,
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
    TResult? Function(String callId, bool enabled)? setSpeaker,
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
    TResult Function(String callId, bool enabled)? setSpeaker,
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
    required TResult Function(_CallPerformEventSetSpeaker value) setSpeaker,
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
    TResult? Function(_CallPerformEventSetSpeaker value)? setSpeaker,
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
    TResult Function(_CallPerformEventSetSpeaker value)? setSpeaker,
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
    required TResult Function(String callId, bool enabled) setSpeaker,
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
    TResult? Function(String callId, bool enabled)? setSpeaker,
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
    TResult Function(String callId, bool enabled)? setSpeaker,
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
    required TResult Function(_CallPerformEventSetSpeaker value) setSpeaker,
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
    TResult? Function(_CallPerformEventSetSpeaker value)? setSpeaker,
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
    TResult Function(_CallPerformEventSetSpeaker value)? setSpeaker,
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
    required TResult Function(String callId, bool enabled) setSpeaker,
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
    TResult? Function(String callId, bool enabled)? setSpeaker,
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
    TResult Function(String callId, bool enabled)? setSpeaker,
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
    required TResult Function(_CallPerformEventSetSpeaker value) setSpeaker,
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
    TResult? Function(_CallPerformEventSetSpeaker value)? setSpeaker,
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
    TResult Function(_CallPerformEventSetSpeaker value)? setSpeaker,
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
    required TResult Function(String callId, bool enabled) setSpeaker,
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
    TResult? Function(String callId, bool enabled)? setSpeaker,
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
    TResult Function(String callId, bool enabled)? setSpeaker,
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
    required TResult Function(_CallPerformEventSetSpeaker value) setSpeaker,
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
    TResult? Function(_CallPerformEventSetSpeaker value)? setSpeaker,
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
    TResult Function(_CallPerformEventSetSpeaker value)? setSpeaker,
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

class _$CallPerformEventSetSpeakerImpl extends _CallPerformEventSetSpeaker
    with DiagnosticableTreeMixin {
  _$CallPerformEventSetSpeakerImpl(this.callId, this.enabled) : super._();

  @override
  final String callId;
  @override
  final bool enabled;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return '_CallPerformEvent.setSpeaker(callId: $callId, enabled: $enabled)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', '_CallPerformEvent.setSpeaker'))
      ..add(DiagnosticsProperty('callId', callId))
      ..add(DiagnosticsProperty('enabled', enabled));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallPerformEventSetSpeakerImpl &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.enabled, enabled) || other.enabled == enabled));
  }

  @override
  int get hashCode => Object.hash(runtimeType, callId, enabled);

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
    required TResult Function(String callId, bool enabled) setSpeaker,
  }) {
    return setSpeaker(callId, enabled);
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
    TResult? Function(String callId, bool enabled)? setSpeaker,
  }) {
    return setSpeaker?.call(callId, enabled);
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
    TResult Function(String callId, bool enabled)? setSpeaker,
    required TResult orElse(),
  }) {
    if (setSpeaker != null) {
      return setSpeaker(callId, enabled);
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
    required TResult Function(_CallPerformEventSetSpeaker value) setSpeaker,
  }) {
    return setSpeaker(this);
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
    TResult? Function(_CallPerformEventSetSpeaker value)? setSpeaker,
  }) {
    return setSpeaker?.call(this);
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
    TResult Function(_CallPerformEventSetSpeaker value)? setSpeaker,
    required TResult orElse(),
  }) {
    if (setSpeaker != null) {
      return setSpeaker(this);
    }
    return orElse();
  }
}

abstract class _CallPerformEventSetSpeaker extends _CallPerformEvent {
  factory _CallPerformEventSetSpeaker(final String callId, final bool enabled) =
      _$CallPerformEventSetSpeakerImpl;
  _CallPerformEventSetSpeaker._() : super._();

  @override
  String get callId;
  bool get enabled;
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
  RegistrationStatus get registrationStatus =>
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
      {ConnectivityResult? currentConnectivityResult,
      RegistrationStatus registrationStatus,
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

  /// Create a copy of CallState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentConnectivityResult = freezed,
    Object? registrationStatus = null,
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
      registrationStatus: null == registrationStatus
          ? _value.registrationStatus
          : registrationStatus // ignore: cast_nullable_to_non_nullable
              as RegistrationStatus,
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
      RegistrationStatus registrationStatus,
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

  /// Create a copy of CallState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentConnectivityResult = freezed,
    Object? registrationStatus = null,
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
      registrationStatus: null == registrationStatus
          ? _value.registrationStatus
          : registrationStatus // ignore: cast_nullable_to_non_nullable
              as RegistrationStatus,
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
      this.registrationStatus = RegistrationStatus.registering,
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
  final RegistrationStatus registrationStatus;
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
    return 'CallState(currentConnectivityResult: $currentConnectivityResult, registrationStatus: $registrationStatus, signalingClientStatus: $signalingClientStatus, lastSignalingClientConnectError: $lastSignalingClientConnectError, lastSignalingClientDisconnectError: $lastSignalingClientDisconnectError, lastSignalingDisconnectCode: $lastSignalingDisconnectCode, linesCount: $linesCount, activeCalls: $activeCalls, minimized: $minimized, speaker: $speaker)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CallState'))
      ..add(DiagnosticsProperty(
          'currentConnectivityResult', currentConnectivityResult))
      ..add(DiagnosticsProperty('registrationStatus', registrationStatus))
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
            (identical(other.registrationStatus, registrationStatus) ||
                other.registrationStatus == registrationStatus) &&
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
      registrationStatus,
      signalingClientStatus,
      const DeepCollectionEquality().hash(lastSignalingClientConnectError),
      const DeepCollectionEquality().hash(lastSignalingClientDisconnectError),
      lastSignalingDisconnectCode,
      linesCount,
      const DeepCollectionEquality().hash(_activeCalls),
      minimized,
      speaker);

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
      {final ConnectivityResult? currentConnectivityResult,
      final RegistrationStatus registrationStatus,
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
  RegistrationStatus get registrationStatus;
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

  /// Create a copy of CallState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
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
  ActiveCallStatus? get status => throw _privateConstructorUsedError;

  /// If the call is result of a refer request, the id should be provided.
  String? get fromReferId => throw _privateConstructorUsedError;
  bool get video => throw _privateConstructorUsedError;
  bool? get frontCamera => throw _privateConstructorUsedError;
  bool get held => throw _privateConstructorUsedError;
  bool get muted => throw _privateConstructorUsedError;
  bool get updating => throw _privateConstructorUsedError;
  DateTime get createdTime => throw _privateConstructorUsedError;
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
      {Direction direction,
      int line,
      String callId,
      CallkeepHandle handle,
      String? displayName,
      ActiveCallStatus? status,
      String? fromReferId,
      bool video,
      bool? frontCamera,
      bool held,
      bool muted,
      bool updating,
      DateTime createdTime,
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
    Object? line = null,
    Object? callId = null,
    Object? handle = null,
    Object? displayName = freezed,
    Object? status = freezed,
    Object? fromReferId = freezed,
    Object? video = null,
    Object? frontCamera = freezed,
    Object? held = null,
    Object? muted = null,
    Object? updating = null,
    Object? createdTime = null,
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
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ActiveCallStatus?,
      fromReferId: freezed == fromReferId
          ? _value.fromReferId
          : fromReferId // ignore: cast_nullable_to_non_nullable
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
      {Direction direction,
      int line,
      String callId,
      CallkeepHandle handle,
      String? displayName,
      ActiveCallStatus? status,
      String? fromReferId,
      bool video,
      bool? frontCamera,
      bool held,
      bool muted,
      bool updating,
      DateTime createdTime,
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
    Object? line = null,
    Object? callId = null,
    Object? handle = null,
    Object? displayName = freezed,
    Object? status = freezed,
    Object? fromReferId = freezed,
    Object? video = null,
    Object? frontCamera = freezed,
    Object? held = null,
    Object? muted = null,
    Object? updating = null,
    Object? createdTime = null,
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
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ActiveCallStatus?,
      fromReferId: freezed == fromReferId
          ? _value.fromReferId
          : fromReferId // ignore: cast_nullable_to_non_nullable
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

class _$ActiveCallImpl extends _ActiveCall with DiagnosticableTreeMixin {
  _$ActiveCallImpl(
      {required this.direction,
      required this.line,
      required this.callId,
      required this.handle,
      this.displayName,
      this.status,
      this.fromReferId,
      required this.video,
      this.frontCamera = true,
      this.held = false,
      this.muted = false,
      this.updating = false,
      required this.createdTime,
      this.acceptedTime,
      this.hungUpTime,
      this.transfer,
      this.failure,
      this.localStream,
      this.remoteStream})
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
  final ActiveCallStatus? status;

  /// If the call is result of a refer request, the id should be provided.
  @override
  final String? fromReferId;
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
  final Transfer? transfer;
  @override
  final Object? failure;
  @override
  final MediaStream? localStream;
  @override
  final MediaStream? remoteStream;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ActiveCall(direction: $direction, line: $line, callId: $callId, handle: $handle, displayName: $displayName, status: $status, fromReferId: $fromReferId, video: $video, frontCamera: $frontCamera, held: $held, muted: $muted, updating: $updating, createdTime: $createdTime, acceptedTime: $acceptedTime, hungUpTime: $hungUpTime, transfer: $transfer, failure: $failure, localStream: $localStream, remoteStream: $remoteStream)';
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
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('fromReferId', fromReferId))
      ..add(DiagnosticsProperty('video', video))
      ..add(DiagnosticsProperty('frontCamera', frontCamera))
      ..add(DiagnosticsProperty('held', held))
      ..add(DiagnosticsProperty('muted', muted))
      ..add(DiagnosticsProperty('updating', updating))
      ..add(DiagnosticsProperty('createdTime', createdTime))
      ..add(DiagnosticsProperty('acceptedTime', acceptedTime))
      ..add(DiagnosticsProperty('hungUpTime', hungUpTime))
      ..add(DiagnosticsProperty('transfer', transfer))
      ..add(DiagnosticsProperty('failure', failure))
      ..add(DiagnosticsProperty('localStream', localStream))
      ..add(DiagnosticsProperty('remoteStream', remoteStream));
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
            (identical(other.status, status) || other.status == status) &&
            (identical(other.fromReferId, fromReferId) ||
                other.fromReferId == fromReferId) &&
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
        displayName,
        status,
        fromReferId,
        video,
        frontCamera,
        held,
        muted,
        updating,
        createdTime,
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
      {required final Direction direction,
      required final int line,
      required final String callId,
      required final CallkeepHandle handle,
      final String? displayName,
      final ActiveCallStatus? status,
      final String? fromReferId,
      required final bool video,
      final bool? frontCamera,
      final bool held,
      final bool muted,
      final bool updating,
      required final DateTime createdTime,
      final DateTime? acceptedTime,
      final DateTime? hungUpTime,
      final Transfer? transfer,
      final Object? failure,
      final MediaStream? localStream,
      final MediaStream? remoteStream}) = _$ActiveCallImpl;
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
  ActiveCallStatus? get status;

  /// If the call is result of a refer request, the id should be provided.
  @override
  String? get fromReferId;
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
