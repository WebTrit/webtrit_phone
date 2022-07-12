// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

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

class _$__AppLifecycleStateChanged implements __AppLifecycleStateChanged {
  const _$__AppLifecycleStateChanged(this.state);

  @override
  final AppLifecycleState state;

  @override
  String toString() {
    return '_AppLifecycleStateChanged(state: $state)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$__AppLifecycleStateChanged &&
            const DeepCollectionEquality().equals(other.state, state));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(state));
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

class _$__ConnectivityResultChanged implements __ConnectivityResultChanged {
  const _$__ConnectivityResultChanged(this.result);

  @override
  final ConnectivityResult result;

  @override
  String toString() {
    return '_ConnectivityResultChanged(result: $result)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$__ConnectivityResultChanged &&
            const DeepCollectionEquality().equals(other.result, result));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(result));
}

abstract class __ConnectivityResultChanged
    implements _ConnectivityResultChanged {
  const factory __ConnectivityResultChanged(final ConnectivityResult result) =
      _$__ConnectivityResultChanged;

  @override
  ConnectivityResult get result;
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
    TResult Function()? connectInitiated,
    TResult Function()? disconnectInitiated,
    TResult Function(int? code, String? reason)? disconnected,
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
    TResult Function(_SignalingClientEventConnectInitiated value)?
        connectInitiated,
    TResult Function(_SignalingClientEventDisconnectInitiated value)?
        disconnectInitiated,
    TResult Function(_SignalingClientEventDisconnected value)? disconnected,
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
    implements _SignalingClientEventConnectInitiated {
  const _$_SignalingClientEventConnectInitiated();

  @override
  String toString() {
    return '_SignalingClientEvent.connectInitiated()';
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
    TResult Function()? connectInitiated,
    TResult Function()? disconnectInitiated,
    TResult Function(int? code, String? reason)? disconnected,
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
    TResult Function(_SignalingClientEventConnectInitiated value)?
        connectInitiated,
    TResult Function(_SignalingClientEventDisconnectInitiated value)?
        disconnectInitiated,
    TResult Function(_SignalingClientEventDisconnected value)? disconnected,
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
    implements _SignalingClientEventDisconnectInitiated {
  const _$_SignalingClientEventDisconnectInitiated();

  @override
  String toString() {
    return '_SignalingClientEvent.disconnectInitiated()';
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
    TResult Function()? connectInitiated,
    TResult Function()? disconnectInitiated,
    TResult Function(int? code, String? reason)? disconnected,
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
    TResult Function(_SignalingClientEventConnectInitiated value)?
        connectInitiated,
    TResult Function(_SignalingClientEventDisconnectInitiated value)?
        disconnectInitiated,
    TResult Function(_SignalingClientEventDisconnected value)? disconnected,
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
    implements _SignalingClientEventDisconnected {
  const _$_SignalingClientEventDisconnected(this.code, this.reason);

  @override
  final int? code;
  @override
  final String? reason;

  @override
  String toString() {
    return '_SignalingClientEvent.disconnected(code: $code, reason: $reason)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SignalingClientEventDisconnected &&
            const DeepCollectionEquality().equals(other.code, code) &&
            const DeepCollectionEquality().equals(other.reason, reason));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(code),
      const DeepCollectionEquality().hash(reason));

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
    TResult Function()? connectInitiated,
    TResult Function()? disconnectInitiated,
    TResult Function(int? code, String? reason)? disconnected,
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
    TResult Function(_SignalingClientEventConnectInitiated value)?
        connectInitiated,
    TResult Function(_SignalingClientEventDisconnectInitiated value)?
        disconnectInitiated,
    TResult Function(_SignalingClientEventDisconnected value)? disconnected,
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
mixin _$_CallSignalingEvent {
  CallIdValue get callId => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(CallIdValue callId, String callee, String caller,
            String? callerDisplayName, JsepValue? jsep)
        incoming,
    required TResult Function(
            CallIdValue callId, String callee, JsepValue? jsep)
        answered,
    required TResult Function(CallIdValue callId, int code, String reason)
        hangup,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(CallIdValue callId, String callee, String caller,
            String? callerDisplayName, JsepValue? jsep)?
        incoming,
    TResult Function(CallIdValue callId, String callee, JsepValue? jsep)?
        answered,
    TResult Function(CallIdValue callId, int code, String reason)? hangup,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(CallIdValue callId, String callee, String caller,
            String? callerDisplayName, JsepValue? jsep)?
        incoming,
    TResult Function(CallIdValue callId, String callee, JsepValue? jsep)?
        answered,
    TResult Function(CallIdValue callId, int code, String reason)? hangup,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CallSignalingEventIncoming value) incoming,
    required TResult Function(_CallSignalingEventAnswered value) answered,
    required TResult Function(_CallSignalingEventHangup value) hangup,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_CallSignalingEventIncoming value)? incoming,
    TResult Function(_CallSignalingEventAnswered value)? answered,
    TResult Function(_CallSignalingEventHangup value)? hangup,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CallSignalingEventIncoming value)? incoming,
    TResult Function(_CallSignalingEventAnswered value)? answered,
    TResult Function(_CallSignalingEventHangup value)? hangup,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc

class _$_CallSignalingEventIncoming implements _CallSignalingEventIncoming {
  const _$_CallSignalingEventIncoming(
      {required this.callId,
      required this.callee,
      required this.caller,
      this.callerDisplayName,
      this.jsep});

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
  String toString() {
    return '_CallSignalingEvent.incoming(callId: $callId, callee: $callee, caller: $caller, callerDisplayName: $callerDisplayName, jsep: $jsep)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CallSignalingEventIncoming &&
            const DeepCollectionEquality().equals(other.callId, callId) &&
            const DeepCollectionEquality().equals(other.callee, callee) &&
            const DeepCollectionEquality().equals(other.caller, caller) &&
            const DeepCollectionEquality()
                .equals(other.callerDisplayName, callerDisplayName) &&
            const DeepCollectionEquality().equals(other.jsep, jsep));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(callId),
      const DeepCollectionEquality().hash(callee),
      const DeepCollectionEquality().hash(caller),
      const DeepCollectionEquality().hash(callerDisplayName),
      const DeepCollectionEquality().hash(jsep));

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(CallIdValue callId, String callee, String caller,
            String? callerDisplayName, JsepValue? jsep)
        incoming,
    required TResult Function(
            CallIdValue callId, String callee, JsepValue? jsep)
        answered,
    required TResult Function(CallIdValue callId, int code, String reason)
        hangup,
  }) {
    return incoming(callId, callee, caller, callerDisplayName, jsep);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(CallIdValue callId, String callee, String caller,
            String? callerDisplayName, JsepValue? jsep)?
        incoming,
    TResult Function(CallIdValue callId, String callee, JsepValue? jsep)?
        answered,
    TResult Function(CallIdValue callId, int code, String reason)? hangup,
  }) {
    return incoming?.call(callId, callee, caller, callerDisplayName, jsep);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(CallIdValue callId, String callee, String caller,
            String? callerDisplayName, JsepValue? jsep)?
        incoming,
    TResult Function(CallIdValue callId, String callee, JsepValue? jsep)?
        answered,
    TResult Function(CallIdValue callId, int code, String reason)? hangup,
    required TResult orElse(),
  }) {
    if (incoming != null) {
      return incoming(callId, callee, caller, callerDisplayName, jsep);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CallSignalingEventIncoming value) incoming,
    required TResult Function(_CallSignalingEventAnswered value) answered,
    required TResult Function(_CallSignalingEventHangup value) hangup,
  }) {
    return incoming(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_CallSignalingEventIncoming value)? incoming,
    TResult Function(_CallSignalingEventAnswered value)? answered,
    TResult Function(_CallSignalingEventHangup value)? hangup,
  }) {
    return incoming?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CallSignalingEventIncoming value)? incoming,
    TResult Function(_CallSignalingEventAnswered value)? answered,
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
      {required final CallIdValue callId,
      required final String callee,
      required final String caller,
      final String? callerDisplayName,
      final JsepValue? jsep}) = _$_CallSignalingEventIncoming;

  @override
  CallIdValue get callId;
  String get callee;
  String get caller;
  String? get callerDisplayName;
  JsepValue? get jsep;
}

/// @nodoc

class _$_CallSignalingEventAnswered implements _CallSignalingEventAnswered {
  const _$_CallSignalingEventAnswered(
      {required this.callId, required this.callee, this.jsep});

  @override
  final CallIdValue callId;
  @override
  final String callee;
  @override
  final JsepValue? jsep;

  @override
  String toString() {
    return '_CallSignalingEvent.answered(callId: $callId, callee: $callee, jsep: $jsep)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CallSignalingEventAnswered &&
            const DeepCollectionEquality().equals(other.callId, callId) &&
            const DeepCollectionEquality().equals(other.callee, callee) &&
            const DeepCollectionEquality().equals(other.jsep, jsep));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(callId),
      const DeepCollectionEquality().hash(callee),
      const DeepCollectionEquality().hash(jsep));

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(CallIdValue callId, String callee, String caller,
            String? callerDisplayName, JsepValue? jsep)
        incoming,
    required TResult Function(
            CallIdValue callId, String callee, JsepValue? jsep)
        answered,
    required TResult Function(CallIdValue callId, int code, String reason)
        hangup,
  }) {
    return answered(callId, callee, jsep);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(CallIdValue callId, String callee, String caller,
            String? callerDisplayName, JsepValue? jsep)?
        incoming,
    TResult Function(CallIdValue callId, String callee, JsepValue? jsep)?
        answered,
    TResult Function(CallIdValue callId, int code, String reason)? hangup,
  }) {
    return answered?.call(callId, callee, jsep);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(CallIdValue callId, String callee, String caller,
            String? callerDisplayName, JsepValue? jsep)?
        incoming,
    TResult Function(CallIdValue callId, String callee, JsepValue? jsep)?
        answered,
    TResult Function(CallIdValue callId, int code, String reason)? hangup,
    required TResult orElse(),
  }) {
    if (answered != null) {
      return answered(callId, callee, jsep);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CallSignalingEventIncoming value) incoming,
    required TResult Function(_CallSignalingEventAnswered value) answered,
    required TResult Function(_CallSignalingEventHangup value) hangup,
  }) {
    return answered(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_CallSignalingEventIncoming value)? incoming,
    TResult Function(_CallSignalingEventAnswered value)? answered,
    TResult Function(_CallSignalingEventHangup value)? hangup,
  }) {
    return answered?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CallSignalingEventIncoming value)? incoming,
    TResult Function(_CallSignalingEventAnswered value)? answered,
    TResult Function(_CallSignalingEventHangup value)? hangup,
    required TResult orElse(),
  }) {
    if (answered != null) {
      return answered(this);
    }
    return orElse();
  }
}

abstract class _CallSignalingEventAnswered implements _CallSignalingEvent {
  const factory _CallSignalingEventAnswered(
      {required final CallIdValue callId,
      required final String callee,
      final JsepValue? jsep}) = _$_CallSignalingEventAnswered;

  @override
  CallIdValue get callId;
  String get callee;
  JsepValue? get jsep;
}

/// @nodoc

class _$_CallSignalingEventHangup implements _CallSignalingEventHangup {
  const _$_CallSignalingEventHangup(
      {required this.callId, required this.code, required this.reason});

  @override
  final CallIdValue callId;
  @override
  final int code;
  @override
  final String reason;

  @override
  String toString() {
    return '_CallSignalingEvent.hangup(callId: $callId, code: $code, reason: $reason)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CallSignalingEventHangup &&
            const DeepCollectionEquality().equals(other.callId, callId) &&
            const DeepCollectionEquality().equals(other.code, code) &&
            const DeepCollectionEquality().equals(other.reason, reason));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(callId),
      const DeepCollectionEquality().hash(code),
      const DeepCollectionEquality().hash(reason));

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(CallIdValue callId, String callee, String caller,
            String? callerDisplayName, JsepValue? jsep)
        incoming,
    required TResult Function(
            CallIdValue callId, String callee, JsepValue? jsep)
        answered,
    required TResult Function(CallIdValue callId, int code, String reason)
        hangup,
  }) {
    return hangup(callId, code, reason);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(CallIdValue callId, String callee, String caller,
            String? callerDisplayName, JsepValue? jsep)?
        incoming,
    TResult Function(CallIdValue callId, String callee, JsepValue? jsep)?
        answered,
    TResult Function(CallIdValue callId, int code, String reason)? hangup,
  }) {
    return hangup?.call(callId, code, reason);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(CallIdValue callId, String callee, String caller,
            String? callerDisplayName, JsepValue? jsep)?
        incoming,
    TResult Function(CallIdValue callId, String callee, JsepValue? jsep)?
        answered,
    TResult Function(CallIdValue callId, int code, String reason)? hangup,
    required TResult orElse(),
  }) {
    if (hangup != null) {
      return hangup(callId, code, reason);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_CallSignalingEventIncoming value) incoming,
    required TResult Function(_CallSignalingEventAnswered value) answered,
    required TResult Function(_CallSignalingEventHangup value) hangup,
  }) {
    return hangup(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_CallSignalingEventIncoming value)? incoming,
    TResult Function(_CallSignalingEventAnswered value)? answered,
    TResult Function(_CallSignalingEventHangup value)? hangup,
  }) {
    return hangup?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_CallSignalingEventIncoming value)? incoming,
    TResult Function(_CallSignalingEventAnswered value)? answered,
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
      {required final CallIdValue callId,
      required final int code,
      required final String reason}) = _$_CallSignalingEventHangup;

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
    TResult Function(CallIdValue callId, CallkeepHandle handle,
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
    TResult Function(_CallPushEventIncoming value)? incoming,
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

class _$_CallPushEventIncoming implements _CallPushEventIncoming {
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
  String toString() {
    return '_CallPushEvent.incoming(callId: $callId, handle: $handle, displayName: $displayName, video: $video, error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CallPushEventIncoming &&
            const DeepCollectionEquality().equals(other.callId, callId) &&
            const DeepCollectionEquality().equals(other.handle, handle) &&
            const DeepCollectionEquality()
                .equals(other.displayName, displayName) &&
            const DeepCollectionEquality().equals(other.video, video) &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(callId),
      const DeepCollectionEquality().hash(handle),
      const DeepCollectionEquality().hash(displayName),
      const DeepCollectionEquality().hash(video),
      const DeepCollectionEquality().hash(error));

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
    TResult Function(CallIdValue callId, CallkeepHandle handle,
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
    TResult Function(_CallPushEventIncoming value)? incoming,
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
    required TResult Function(String? generic, String? number, String? email,
            String? displayName, bool video)
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
    TResult Function(String? generic, String? number, String? email,
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
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? generic, String? number, String? email,
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
    with CallControlEventStartedMixin
    implements _CallControlEventStarted {
  const _$_CallControlEventStarted(
      {this.generic,
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
  String toString() {
    return 'CallControlEvent.started(generic: $generic, number: $number, email: $email, displayName: $displayName, video: $video)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CallControlEventStarted &&
            const DeepCollectionEquality().equals(other.generic, generic) &&
            const DeepCollectionEquality().equals(other.number, number) &&
            const DeepCollectionEquality().equals(other.email, email) &&
            const DeepCollectionEquality()
                .equals(other.displayName, displayName) &&
            const DeepCollectionEquality().equals(other.video, video));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(generic),
      const DeepCollectionEquality().hash(number),
      const DeepCollectionEquality().hash(email),
      const DeepCollectionEquality().hash(displayName),
      const DeepCollectionEquality().hash(video));

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? generic, String? number, String? email,
            String? displayName, bool video)
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
    return started(generic, number, email, displayName, video);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String? generic, String? number, String? email,
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
  }) {
    return started?.call(generic, number, email, displayName, video);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? generic, String? number, String? email,
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
      return started(generic, number, email, displayName, video);
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
      {final String? generic,
      final String? number,
      final String? email,
      final String? displayName,
      required final bool video}) = _$_CallControlEventStarted;

  String? get generic;
  String? get number;
  String? get email;
  String? get displayName;
  bool get video;
}

/// @nodoc

class _$_CallControlEventAnswered implements _CallControlEventAnswered {
  const _$_CallControlEventAnswered(this.uuid);

  @override
  final UuidValue uuid;

  @override
  String toString() {
    return 'CallControlEvent.answered(uuid: $uuid)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CallControlEventAnswered &&
            const DeepCollectionEquality().equals(other.uuid, uuid));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(uuid));

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? generic, String? number, String? email,
            String? displayName, bool video)
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
    TResult Function(String? generic, String? number, String? email,
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
  }) {
    return answered?.call(uuid);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? generic, String? number, String? email,
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

class _$_CallControlEventEnded implements _CallControlEventEnded {
  const _$_CallControlEventEnded(this.uuid);

  @override
  final UuidValue uuid;

  @override
  String toString() {
    return 'CallControlEvent.ended(uuid: $uuid)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CallControlEventEnded &&
            const DeepCollectionEquality().equals(other.uuid, uuid));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(uuid));

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? generic, String? number, String? email,
            String? displayName, bool video)
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
    TResult Function(String? generic, String? number, String? email,
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
  }) {
    return ended?.call(uuid);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? generic, String? number, String? email,
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

class _$_CallControlEventSetHeld implements _CallControlEventSetHeld {
  const _$_CallControlEventSetHeld(this.uuid, this.onHold);

  @override
  final UuidValue uuid;
  @override
  final bool onHold;

  @override
  String toString() {
    return 'CallControlEvent.setHeld(uuid: $uuid, onHold: $onHold)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CallControlEventSetHeld &&
            const DeepCollectionEquality().equals(other.uuid, uuid) &&
            const DeepCollectionEquality().equals(other.onHold, onHold));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(uuid),
      const DeepCollectionEquality().hash(onHold));

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? generic, String? number, String? email,
            String? displayName, bool video)
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
    TResult Function(String? generic, String? number, String? email,
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
  }) {
    return setHeld?.call(uuid, onHold);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? generic, String? number, String? email,
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

class _$_CallControlEventSetMuted implements _CallControlEventSetMuted {
  const _$_CallControlEventSetMuted(this.uuid, this.muted);

  @override
  final UuidValue uuid;
  @override
  final bool muted;

  @override
  String toString() {
    return 'CallControlEvent.setMuted(uuid: $uuid, muted: $muted)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CallControlEventSetMuted &&
            const DeepCollectionEquality().equals(other.uuid, uuid) &&
            const DeepCollectionEquality().equals(other.muted, muted));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(uuid),
      const DeepCollectionEquality().hash(muted));

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? generic, String? number, String? email,
            String? displayName, bool video)
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
    TResult Function(String? generic, String? number, String? email,
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
  }) {
    return setMuted?.call(uuid, muted);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? generic, String? number, String? email,
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

class _$_CallControlEventSentDTMF implements _CallControlEventSentDTMF {
  const _$_CallControlEventSentDTMF(this.uuid, this.key);

  @override
  final UuidValue uuid;
  @override
  final String key;

  @override
  String toString() {
    return 'CallControlEvent.sentDTMF(uuid: $uuid, key: $key)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CallControlEventSentDTMF &&
            const DeepCollectionEquality().equals(other.uuid, uuid) &&
            const DeepCollectionEquality().equals(other.key, key));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(uuid),
      const DeepCollectionEquality().hash(key));

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? generic, String? number, String? email,
            String? displayName, bool video)
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
    TResult Function(String? generic, String? number, String? email,
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
  }) {
    return sentDTMF?.call(uuid, key);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? generic, String? number, String? email,
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
    implements _CallControlEventCameraSwitched {
  const _$_CallControlEventCameraSwitched(this.uuid);

  @override
  final UuidValue uuid;

  @override
  String toString() {
    return 'CallControlEvent.cameraSwitched(uuid: $uuid)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CallControlEventCameraSwitched &&
            const DeepCollectionEquality().equals(other.uuid, uuid));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(uuid));

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? generic, String? number, String? email,
            String? displayName, bool video)
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
    TResult Function(String? generic, String? number, String? email,
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
  }) {
    return cameraSwitched?.call(uuid);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? generic, String? number, String? email,
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
    implements _CallControlEventCameraEnabled {
  const _$_CallControlEventCameraEnabled(this.uuid, this.enabled);

  @override
  final UuidValue uuid;
  @override
  final bool enabled;

  @override
  String toString() {
    return 'CallControlEvent.cameraEnabled(uuid: $uuid, enabled: $enabled)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CallControlEventCameraEnabled &&
            const DeepCollectionEquality().equals(other.uuid, uuid) &&
            const DeepCollectionEquality().equals(other.enabled, enabled));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(uuid),
      const DeepCollectionEquality().hash(enabled));

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? generic, String? number, String? email,
            String? displayName, bool video)
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
    TResult Function(String? generic, String? number, String? email,
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
  }) {
    return cameraEnabled?.call(uuid, enabled);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? generic, String? number, String? email,
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
    implements _CallControlEventSpeakerEnabled {
  const _$_CallControlEventSpeakerEnabled(this.uuid, this.enabled);

  @override
  final UuidValue uuid;
  @override
  final bool enabled;

  @override
  String toString() {
    return 'CallControlEvent.speakerEnabled(uuid: $uuid, enabled: $enabled)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CallControlEventSpeakerEnabled &&
            const DeepCollectionEquality().equals(other.uuid, uuid) &&
            const DeepCollectionEquality().equals(other.enabled, enabled));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(uuid),
      const DeepCollectionEquality().hash(enabled));

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? generic, String? number, String? email,
            String? displayName, bool video)
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
    TResult Function(String? generic, String? number, String? email,
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
  }) {
    return speakerEnabled?.call(uuid, enabled);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? generic, String? number, String? email,
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
    implements _CallControlEventFailureApproved {
  const _$_CallControlEventFailureApproved(this.uuid);

  @override
  final UuidValue uuid;

  @override
  String toString() {
    return 'CallControlEvent.failureApproved(uuid: $uuid)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CallControlEventFailureApproved &&
            const DeepCollectionEquality().equals(other.uuid, uuid));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(uuid));

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? generic, String? number, String? email,
            String? displayName, bool video)
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
    TResult Function(String? generic, String? number, String? email,
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
  }) {
    return failureApproved?.call(uuid);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? generic, String? number, String? email,
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
    TResult Function(UuidValue uuid, CallkeepHandle handle, String? displayName,
            bool video)?
        started,
    TResult Function(UuidValue uuid)? answered,
    TResult Function(UuidValue uuid)? ended,
    TResult Function(UuidValue uuid, bool onHold)? setHeld,
    TResult Function(UuidValue uuid, bool muted)? setMuted,
    TResult Function(UuidValue uuid, String key)? sentDTMF,
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
    TResult Function(_CallPerformEventStarted value)? started,
    TResult Function(_CallPerformEventAnswered value)? answered,
    TResult Function(_CallPerformEventEnded value)? ended,
    TResult Function(_CallPerformEventSetHeld value)? setHeld,
    TResult Function(_CallPerformEventSetMuted value)? setMuted,
    TResult Function(_CallPerformEventSentDTMF value)? sentDTMF,
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

class _$_CallPerformEventStarted extends _CallPerformEventStarted {
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
  String toString() {
    return '_CallPerformEvent.started(uuid: $uuid, handle: $handle, displayName: $displayName, video: $video)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CallPerformEventStarted &&
            const DeepCollectionEquality().equals(other.uuid, uuid) &&
            const DeepCollectionEquality().equals(other.handle, handle) &&
            const DeepCollectionEquality()
                .equals(other.displayName, displayName) &&
            const DeepCollectionEquality().equals(other.video, video));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(uuid),
      const DeepCollectionEquality().hash(handle),
      const DeepCollectionEquality().hash(displayName),
      const DeepCollectionEquality().hash(video));

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
    TResult Function(UuidValue uuid, CallkeepHandle handle, String? displayName,
            bool video)?
        started,
    TResult Function(UuidValue uuid)? answered,
    TResult Function(UuidValue uuid)? ended,
    TResult Function(UuidValue uuid, bool onHold)? setHeld,
    TResult Function(UuidValue uuid, bool muted)? setMuted,
    TResult Function(UuidValue uuid, String key)? sentDTMF,
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
    TResult Function(_CallPerformEventStarted value)? started,
    TResult Function(_CallPerformEventAnswered value)? answered,
    TResult Function(_CallPerformEventEnded value)? ended,
    TResult Function(_CallPerformEventSetHeld value)? setHeld,
    TResult Function(_CallPerformEventSetMuted value)? setMuted,
    TResult Function(_CallPerformEventSentDTMF value)? sentDTMF,
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

class _$_CallPerformEventAnswered extends _CallPerformEventAnswered {
  _$_CallPerformEventAnswered(this.uuid) : super._();

  @override
  final UuidValue uuid;

  @override
  String toString() {
    return '_CallPerformEvent.answered(uuid: $uuid)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CallPerformEventAnswered &&
            const DeepCollectionEquality().equals(other.uuid, uuid));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(uuid));

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
    TResult Function(UuidValue uuid, CallkeepHandle handle, String? displayName,
            bool video)?
        started,
    TResult Function(UuidValue uuid)? answered,
    TResult Function(UuidValue uuid)? ended,
    TResult Function(UuidValue uuid, bool onHold)? setHeld,
    TResult Function(UuidValue uuid, bool muted)? setMuted,
    TResult Function(UuidValue uuid, String key)? sentDTMF,
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
    TResult Function(_CallPerformEventStarted value)? started,
    TResult Function(_CallPerformEventAnswered value)? answered,
    TResult Function(_CallPerformEventEnded value)? ended,
    TResult Function(_CallPerformEventSetHeld value)? setHeld,
    TResult Function(_CallPerformEventSetMuted value)? setMuted,
    TResult Function(_CallPerformEventSentDTMF value)? sentDTMF,
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

class _$_CallPerformEventEnded extends _CallPerformEventEnded {
  _$_CallPerformEventEnded(this.uuid) : super._();

  @override
  final UuidValue uuid;

  @override
  String toString() {
    return '_CallPerformEvent.ended(uuid: $uuid)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CallPerformEventEnded &&
            const DeepCollectionEquality().equals(other.uuid, uuid));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(uuid));

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
    TResult Function(UuidValue uuid, CallkeepHandle handle, String? displayName,
            bool video)?
        started,
    TResult Function(UuidValue uuid)? answered,
    TResult Function(UuidValue uuid)? ended,
    TResult Function(UuidValue uuid, bool onHold)? setHeld,
    TResult Function(UuidValue uuid, bool muted)? setMuted,
    TResult Function(UuidValue uuid, String key)? sentDTMF,
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
    TResult Function(_CallPerformEventStarted value)? started,
    TResult Function(_CallPerformEventAnswered value)? answered,
    TResult Function(_CallPerformEventEnded value)? ended,
    TResult Function(_CallPerformEventSetHeld value)? setHeld,
    TResult Function(_CallPerformEventSetMuted value)? setMuted,
    TResult Function(_CallPerformEventSentDTMF value)? sentDTMF,
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

class _$_CallPerformEventSetHeld extends _CallPerformEventSetHeld {
  _$_CallPerformEventSetHeld(this.uuid, this.onHold) : super._();

  @override
  final UuidValue uuid;
  @override
  final bool onHold;

  @override
  String toString() {
    return '_CallPerformEvent.setHeld(uuid: $uuid, onHold: $onHold)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CallPerformEventSetHeld &&
            const DeepCollectionEquality().equals(other.uuid, uuid) &&
            const DeepCollectionEquality().equals(other.onHold, onHold));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(uuid),
      const DeepCollectionEquality().hash(onHold));

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
    TResult Function(UuidValue uuid, CallkeepHandle handle, String? displayName,
            bool video)?
        started,
    TResult Function(UuidValue uuid)? answered,
    TResult Function(UuidValue uuid)? ended,
    TResult Function(UuidValue uuid, bool onHold)? setHeld,
    TResult Function(UuidValue uuid, bool muted)? setMuted,
    TResult Function(UuidValue uuid, String key)? sentDTMF,
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
    TResult Function(_CallPerformEventStarted value)? started,
    TResult Function(_CallPerformEventAnswered value)? answered,
    TResult Function(_CallPerformEventEnded value)? ended,
    TResult Function(_CallPerformEventSetHeld value)? setHeld,
    TResult Function(_CallPerformEventSetMuted value)? setMuted,
    TResult Function(_CallPerformEventSentDTMF value)? sentDTMF,
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

class _$_CallPerformEventSetMuted extends _CallPerformEventSetMuted {
  _$_CallPerformEventSetMuted(this.uuid, this.muted) : super._();

  @override
  final UuidValue uuid;
  @override
  final bool muted;

  @override
  String toString() {
    return '_CallPerformEvent.setMuted(uuid: $uuid, muted: $muted)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CallPerformEventSetMuted &&
            const DeepCollectionEquality().equals(other.uuid, uuid) &&
            const DeepCollectionEquality().equals(other.muted, muted));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(uuid),
      const DeepCollectionEquality().hash(muted));

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
    TResult Function(UuidValue uuid, CallkeepHandle handle, String? displayName,
            bool video)?
        started,
    TResult Function(UuidValue uuid)? answered,
    TResult Function(UuidValue uuid)? ended,
    TResult Function(UuidValue uuid, bool onHold)? setHeld,
    TResult Function(UuidValue uuid, bool muted)? setMuted,
    TResult Function(UuidValue uuid, String key)? sentDTMF,
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
    TResult Function(_CallPerformEventStarted value)? started,
    TResult Function(_CallPerformEventAnswered value)? answered,
    TResult Function(_CallPerformEventEnded value)? ended,
    TResult Function(_CallPerformEventSetHeld value)? setHeld,
    TResult Function(_CallPerformEventSetMuted value)? setMuted,
    TResult Function(_CallPerformEventSentDTMF value)? sentDTMF,
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

class _$_CallPerformEventSentDTMF extends _CallPerformEventSentDTMF {
  _$_CallPerformEventSentDTMF(this.uuid, this.key) : super._();

  @override
  final UuidValue uuid;
  @override
  final String key;

  @override
  String toString() {
    return '_CallPerformEvent.sentDTMF(uuid: $uuid, key: $key)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CallPerformEventSentDTMF &&
            const DeepCollectionEquality().equals(other.uuid, uuid) &&
            const DeepCollectionEquality().equals(other.key, key));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(uuid),
      const DeepCollectionEquality().hash(key));

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
    TResult Function(UuidValue uuid, CallkeepHandle handle, String? displayName,
            bool video)?
        started,
    TResult Function(UuidValue uuid)? answered,
    TResult Function(UuidValue uuid)? ended,
    TResult Function(UuidValue uuid, bool onHold)? setHeld,
    TResult Function(UuidValue uuid, bool muted)? setMuted,
    TResult Function(UuidValue uuid, String key)? sentDTMF,
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
    TResult Function(_CallPerformEventStarted value)? started,
    TResult Function(_CallPerformEventAnswered value)? answered,
    TResult Function(_CallPerformEventEnded value)? ended,
    TResult Function(_CallPerformEventSetHeld value)? setHeld,
    TResult Function(_CallPerformEventSetMuted value)? setMuted,
    TResult Function(_CallPerformEventSentDTMF value)? sentDTMF,
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
    TResult Function(UuidValue uuid, RTCIceGatheringState state)?
        iceGatheringStateChanged,
    TResult Function(UuidValue uuid, RTCIceCandidate candidate)?
        iceCandidateIdentified,
    TResult Function(UuidValue uuid, MediaStream stream)? streamAdded,
    TResult Function(UuidValue uuid, MediaStream stream)? streamRemoved,
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
    TResult Function(_PeerConnectionEventIceGatheringStateChanged value)?
        iceGatheringStateChanged,
    TResult Function(_PeerConnectionEventIceCandidateIdentified value)?
        iceCandidateIdentified,
    TResult Function(_PeerConnectionEventStreamAdded value)? streamAdded,
    TResult Function(_PeerConnectionEventStreamRemoved value)? streamRemoved,
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
    implements _PeerConnectionEventIceGatheringStateChanged {
  const _$_PeerConnectionEventIceGatheringStateChanged(this.uuid, this.state);

  @override
  final UuidValue uuid;
  @override
  final RTCIceGatheringState state;

  @override
  String toString() {
    return '_PeerConnectionEvent.iceGatheringStateChanged(uuid: $uuid, state: $state)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PeerConnectionEventIceGatheringStateChanged &&
            const DeepCollectionEquality().equals(other.uuid, uuid) &&
            const DeepCollectionEquality().equals(other.state, state));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(uuid),
      const DeepCollectionEquality().hash(state));

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
    TResult Function(UuidValue uuid, RTCIceGatheringState state)?
        iceGatheringStateChanged,
    TResult Function(UuidValue uuid, RTCIceCandidate candidate)?
        iceCandidateIdentified,
    TResult Function(UuidValue uuid, MediaStream stream)? streamAdded,
    TResult Function(UuidValue uuid, MediaStream stream)? streamRemoved,
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
    TResult Function(_PeerConnectionEventIceGatheringStateChanged value)?
        iceGatheringStateChanged,
    TResult Function(_PeerConnectionEventIceCandidateIdentified value)?
        iceCandidateIdentified,
    TResult Function(_PeerConnectionEventStreamAdded value)? streamAdded,
    TResult Function(_PeerConnectionEventStreamRemoved value)? streamRemoved,
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
    implements _PeerConnectionEventIceCandidateIdentified {
  const _$_PeerConnectionEventIceCandidateIdentified(this.uuid, this.candidate);

  @override
  final UuidValue uuid;
  @override
  final RTCIceCandidate candidate;

  @override
  String toString() {
    return '_PeerConnectionEvent.iceCandidateIdentified(uuid: $uuid, candidate: $candidate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PeerConnectionEventIceCandidateIdentified &&
            const DeepCollectionEquality().equals(other.uuid, uuid) &&
            const DeepCollectionEquality().equals(other.candidate, candidate));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(uuid),
      const DeepCollectionEquality().hash(candidate));

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
    TResult Function(UuidValue uuid, RTCIceGatheringState state)?
        iceGatheringStateChanged,
    TResult Function(UuidValue uuid, RTCIceCandidate candidate)?
        iceCandidateIdentified,
    TResult Function(UuidValue uuid, MediaStream stream)? streamAdded,
    TResult Function(UuidValue uuid, MediaStream stream)? streamRemoved,
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
    TResult Function(_PeerConnectionEventIceGatheringStateChanged value)?
        iceGatheringStateChanged,
    TResult Function(_PeerConnectionEventIceCandidateIdentified value)?
        iceCandidateIdentified,
    TResult Function(_PeerConnectionEventStreamAdded value)? streamAdded,
    TResult Function(_PeerConnectionEventStreamRemoved value)? streamRemoved,
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
    implements _PeerConnectionEventStreamAdded {
  const _$_PeerConnectionEventStreamAdded(this.uuid, this.stream);

  @override
  final UuidValue uuid;
  @override
  final MediaStream stream;

  @override
  String toString() {
    return '_PeerConnectionEvent.streamAdded(uuid: $uuid, stream: $stream)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PeerConnectionEventStreamAdded &&
            const DeepCollectionEquality().equals(other.uuid, uuid) &&
            const DeepCollectionEquality().equals(other.stream, stream));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(uuid),
      const DeepCollectionEquality().hash(stream));

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
    TResult Function(UuidValue uuid, RTCIceGatheringState state)?
        iceGatheringStateChanged,
    TResult Function(UuidValue uuid, RTCIceCandidate candidate)?
        iceCandidateIdentified,
    TResult Function(UuidValue uuid, MediaStream stream)? streamAdded,
    TResult Function(UuidValue uuid, MediaStream stream)? streamRemoved,
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
    TResult Function(_PeerConnectionEventIceGatheringStateChanged value)?
        iceGatheringStateChanged,
    TResult Function(_PeerConnectionEventIceCandidateIdentified value)?
        iceCandidateIdentified,
    TResult Function(_PeerConnectionEventStreamAdded value)? streamAdded,
    TResult Function(_PeerConnectionEventStreamRemoved value)? streamRemoved,
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
    implements _PeerConnectionEventStreamRemoved {
  const _$_PeerConnectionEventStreamRemoved(this.uuid, this.stream);

  @override
  final UuidValue uuid;
  @override
  final MediaStream stream;

  @override
  String toString() {
    return '_PeerConnectionEvent.streamRemoved(uuid: $uuid, stream: $stream)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PeerConnectionEventStreamRemoved &&
            const DeepCollectionEquality().equals(other.uuid, uuid) &&
            const DeepCollectionEquality().equals(other.stream, stream));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(uuid),
      const DeepCollectionEquality().hash(stream));

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
    TResult Function(UuidValue uuid, RTCIceGatheringState state)?
        iceGatheringStateChanged,
    TResult Function(UuidValue uuid, RTCIceCandidate candidate)?
        iceCandidateIdentified,
    TResult Function(UuidValue uuid, MediaStream stream)? streamAdded,
    TResult Function(UuidValue uuid, MediaStream stream)? streamRemoved,
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
    TResult Function(_PeerConnectionEventIceGatheringStateChanged value)?
        iceGatheringStateChanged,
    TResult Function(_PeerConnectionEventIceCandidateIdentified value)?
        iceCandidateIdentified,
    TResult Function(_PeerConnectionEventStreamAdded value)? streamAdded,
    TResult Function(_PeerConnectionEventStreamRemoved value)? streamRemoved,
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
  SignalingClientStatus get signalingClientStatus =>
      throw _privateConstructorUsedError;
  Object? get lastSignalingClientConnectError =>
      throw _privateConstructorUsedError;
  Object? get lastSignalingClientDisconnectError =>
      throw _privateConstructorUsedError;
  int? get lastSignalingDisconnectCode => throw _privateConstructorUsedError;
  List<ActiveCall> get activeCalls => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CallStateCopyWith<CallState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CallStateCopyWith<$Res> {
  factory $CallStateCopyWith(CallState value, $Res Function(CallState) then) =
      _$CallStateCopyWithImpl<$Res>;
  $Res call(
      {SignalingClientStatus signalingClientStatus,
      Object? lastSignalingClientConnectError,
      Object? lastSignalingClientDisconnectError,
      int? lastSignalingDisconnectCode,
      List<ActiveCall> activeCalls});
}

/// @nodoc
class _$CallStateCopyWithImpl<$Res> implements $CallStateCopyWith<$Res> {
  _$CallStateCopyWithImpl(this._value, this._then);

  final CallState _value;
  // ignore: unused_field
  final $Res Function(CallState) _then;

  @override
  $Res call({
    Object? signalingClientStatus = freezed,
    Object? lastSignalingClientConnectError = freezed,
    Object? lastSignalingClientDisconnectError = freezed,
    Object? lastSignalingDisconnectCode = freezed,
    Object? activeCalls = freezed,
  }) {
    return _then(_value.copyWith(
      signalingClientStatus: signalingClientStatus == freezed
          ? _value.signalingClientStatus
          : signalingClientStatus // ignore: cast_nullable_to_non_nullable
              as SignalingClientStatus,
      lastSignalingClientConnectError:
          lastSignalingClientConnectError == freezed
              ? _value.lastSignalingClientConnectError
              : lastSignalingClientConnectError,
      lastSignalingClientDisconnectError:
          lastSignalingClientDisconnectError == freezed
              ? _value.lastSignalingClientDisconnectError
              : lastSignalingClientDisconnectError,
      lastSignalingDisconnectCode: lastSignalingDisconnectCode == freezed
          ? _value.lastSignalingDisconnectCode
          : lastSignalingDisconnectCode // ignore: cast_nullable_to_non_nullable
              as int?,
      activeCalls: activeCalls == freezed
          ? _value.activeCalls
          : activeCalls // ignore: cast_nullable_to_non_nullable
              as List<ActiveCall>,
    ));
  }
}

/// @nodoc
abstract class _$$_CallStateCopyWith<$Res> implements $CallStateCopyWith<$Res> {
  factory _$$_CallStateCopyWith(
          _$_CallState value, $Res Function(_$_CallState) then) =
      __$$_CallStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {SignalingClientStatus signalingClientStatus,
      Object? lastSignalingClientConnectError,
      Object? lastSignalingClientDisconnectError,
      int? lastSignalingDisconnectCode,
      List<ActiveCall> activeCalls});
}

/// @nodoc
class __$$_CallStateCopyWithImpl<$Res> extends _$CallStateCopyWithImpl<$Res>
    implements _$$_CallStateCopyWith<$Res> {
  __$$_CallStateCopyWithImpl(
      _$_CallState _value, $Res Function(_$_CallState) _then)
      : super(_value, (v) => _then(v as _$_CallState));

  @override
  _$_CallState get _value => super._value as _$_CallState;

  @override
  $Res call({
    Object? signalingClientStatus = freezed,
    Object? lastSignalingClientConnectError = freezed,
    Object? lastSignalingClientDisconnectError = freezed,
    Object? lastSignalingDisconnectCode = freezed,
    Object? activeCalls = freezed,
  }) {
    return _then(_$_CallState(
      signalingClientStatus: signalingClientStatus == freezed
          ? _value.signalingClientStatus
          : signalingClientStatus // ignore: cast_nullable_to_non_nullable
              as SignalingClientStatus,
      lastSignalingClientConnectError:
          lastSignalingClientConnectError == freezed
              ? _value.lastSignalingClientConnectError
              : lastSignalingClientConnectError,
      lastSignalingClientDisconnectError:
          lastSignalingClientDisconnectError == freezed
              ? _value.lastSignalingClientDisconnectError
              : lastSignalingClientDisconnectError,
      lastSignalingDisconnectCode: lastSignalingDisconnectCode == freezed
          ? _value.lastSignalingDisconnectCode
          : lastSignalingDisconnectCode // ignore: cast_nullable_to_non_nullable
              as int?,
      activeCalls: activeCalls == freezed
          ? _value._activeCalls
          : activeCalls // ignore: cast_nullable_to_non_nullable
              as List<ActiveCall>,
    ));
  }
}

/// @nodoc

class _$_CallState extends _CallState {
  const _$_CallState(
      {this.signalingClientStatus = SignalingClientStatus.disconnect,
      this.lastSignalingClientConnectError,
      this.lastSignalingClientDisconnectError,
      this.lastSignalingDisconnectCode,
      final List<ActiveCall> activeCalls = const []})
      : _activeCalls = activeCalls,
        super._();

  @override
  @JsonKey()
  final SignalingClientStatus signalingClientStatus;
  @override
  final Object? lastSignalingClientConnectError;
  @override
  final Object? lastSignalingClientDisconnectError;
  @override
  final int? lastSignalingDisconnectCode;
  final List<ActiveCall> _activeCalls;
  @override
  @JsonKey()
  List<ActiveCall> get activeCalls {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_activeCalls);
  }

  @override
  String toString() {
    return 'CallState(signalingClientStatus: $signalingClientStatus, lastSignalingClientConnectError: $lastSignalingClientConnectError, lastSignalingClientDisconnectError: $lastSignalingClientDisconnectError, lastSignalingDisconnectCode: $lastSignalingDisconnectCode, activeCalls: $activeCalls)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CallState &&
            const DeepCollectionEquality()
                .equals(other.signalingClientStatus, signalingClientStatus) &&
            const DeepCollectionEquality().equals(
                other.lastSignalingClientConnectError,
                lastSignalingClientConnectError) &&
            const DeepCollectionEquality().equals(
                other.lastSignalingClientDisconnectError,
                lastSignalingClientDisconnectError) &&
            const DeepCollectionEquality().equals(
                other.lastSignalingDisconnectCode,
                lastSignalingDisconnectCode) &&
            const DeepCollectionEquality()
                .equals(other._activeCalls, _activeCalls));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(signalingClientStatus),
      const DeepCollectionEquality().hash(lastSignalingClientConnectError),
      const DeepCollectionEquality().hash(lastSignalingClientDisconnectError),
      const DeepCollectionEquality().hash(lastSignalingDisconnectCode),
      const DeepCollectionEquality().hash(_activeCalls));

  @JsonKey(ignore: true)
  @override
  _$$_CallStateCopyWith<_$_CallState> get copyWith =>
      __$$_CallStateCopyWithImpl<_$_CallState>(this, _$identity);
}

abstract class _CallState extends CallState {
  const factory _CallState(
      {final SignalingClientStatus signalingClientStatus,
      final Object? lastSignalingClientConnectError,
      final Object? lastSignalingClientDisconnectError,
      final int? lastSignalingDisconnectCode,
      final List<ActiveCall> activeCalls}) = _$_CallState;
  const _CallState._() : super._();

  @override
  SignalingClientStatus get signalingClientStatus;
  @override
  Object? get lastSignalingClientConnectError;
  @override
  Object? get lastSignalingClientDisconnectError;
  @override
  int? get lastSignalingDisconnectCode;
  @override
  List<ActiveCall> get activeCalls;
  @override
  @JsonKey(ignore: true)
  _$$_CallStateCopyWith<_$_CallState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ActiveCall {
  Direction get direction => throw _privateConstructorUsedError;
  CallIdValue get callId => throw _privateConstructorUsedError;
  CallkeepHandle get handle => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  bool get video => throw _privateConstructorUsedError;
  bool get held => throw _privateConstructorUsedError;
  bool get muted => throw _privateConstructorUsedError;
  DateTime get createdTime => throw _privateConstructorUsedError;
  DateTime? get acceptedTime => throw _privateConstructorUsedError;
  DateTime? get hungUpTime => throw _privateConstructorUsedError;
  Object? get failure => throw _privateConstructorUsedError;
  MediaStream? get localStream => throw _privateConstructorUsedError;
  MediaStream? get remoteStream => throw _privateConstructorUsedError;
  RTCPeerConnection? get peerConnection => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ActiveCallCopyWith<ActiveCall> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActiveCallCopyWith<$Res> {
  factory $ActiveCallCopyWith(
          ActiveCall value, $Res Function(ActiveCall) then) =
      _$ActiveCallCopyWithImpl<$Res>;
  $Res call(
      {Direction direction,
      CallIdValue callId,
      CallkeepHandle handle,
      String? displayName,
      bool video,
      bool held,
      bool muted,
      DateTime createdTime,
      DateTime? acceptedTime,
      DateTime? hungUpTime,
      Object? failure,
      MediaStream? localStream,
      MediaStream? remoteStream,
      RTCPeerConnection? peerConnection});
}

/// @nodoc
class _$ActiveCallCopyWithImpl<$Res> implements $ActiveCallCopyWith<$Res> {
  _$ActiveCallCopyWithImpl(this._value, this._then);

  final ActiveCall _value;
  // ignore: unused_field
  final $Res Function(ActiveCall) _then;

  @override
  $Res call({
    Object? direction = freezed,
    Object? callId = freezed,
    Object? handle = freezed,
    Object? displayName = freezed,
    Object? video = freezed,
    Object? held = freezed,
    Object? muted = freezed,
    Object? createdTime = freezed,
    Object? acceptedTime = freezed,
    Object? hungUpTime = freezed,
    Object? failure = freezed,
    Object? localStream = freezed,
    Object? remoteStream = freezed,
    Object? peerConnection = freezed,
  }) {
    return _then(_value.copyWith(
      direction: direction == freezed
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as Direction,
      callId: callId == freezed
          ? _value.callId
          : callId // ignore: cast_nullable_to_non_nullable
              as CallIdValue,
      handle: handle == freezed
          ? _value.handle
          : handle // ignore: cast_nullable_to_non_nullable
              as CallkeepHandle,
      displayName: displayName == freezed
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      video: video == freezed
          ? _value.video
          : video // ignore: cast_nullable_to_non_nullable
              as bool,
      held: held == freezed
          ? _value.held
          : held // ignore: cast_nullable_to_non_nullable
              as bool,
      muted: muted == freezed
          ? _value.muted
          : muted // ignore: cast_nullable_to_non_nullable
              as bool,
      createdTime: createdTime == freezed
          ? _value.createdTime
          : createdTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      acceptedTime: acceptedTime == freezed
          ? _value.acceptedTime
          : acceptedTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      hungUpTime: hungUpTime == freezed
          ? _value.hungUpTime
          : hungUpTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      failure: failure == freezed ? _value.failure : failure,
      localStream: localStream == freezed
          ? _value.localStream
          : localStream // ignore: cast_nullable_to_non_nullable
              as MediaStream?,
      remoteStream: remoteStream == freezed
          ? _value.remoteStream
          : remoteStream // ignore: cast_nullable_to_non_nullable
              as MediaStream?,
      peerConnection: peerConnection == freezed
          ? _value.peerConnection
          : peerConnection // ignore: cast_nullable_to_non_nullable
              as RTCPeerConnection?,
    ));
  }
}

/// @nodoc
abstract class _$$_ActiveCallCopyWith<$Res>
    implements $ActiveCallCopyWith<$Res> {
  factory _$$_ActiveCallCopyWith(
          _$_ActiveCall value, $Res Function(_$_ActiveCall) then) =
      __$$_ActiveCallCopyWithImpl<$Res>;
  @override
  $Res call(
      {Direction direction,
      CallIdValue callId,
      CallkeepHandle handle,
      String? displayName,
      bool video,
      bool held,
      bool muted,
      DateTime createdTime,
      DateTime? acceptedTime,
      DateTime? hungUpTime,
      Object? failure,
      MediaStream? localStream,
      MediaStream? remoteStream,
      RTCPeerConnection? peerConnection});
}

/// @nodoc
class __$$_ActiveCallCopyWithImpl<$Res> extends _$ActiveCallCopyWithImpl<$Res>
    implements _$$_ActiveCallCopyWith<$Res> {
  __$$_ActiveCallCopyWithImpl(
      _$_ActiveCall _value, $Res Function(_$_ActiveCall) _then)
      : super(_value, (v) => _then(v as _$_ActiveCall));

  @override
  _$_ActiveCall get _value => super._value as _$_ActiveCall;

  @override
  $Res call({
    Object? direction = freezed,
    Object? callId = freezed,
    Object? handle = freezed,
    Object? displayName = freezed,
    Object? video = freezed,
    Object? held = freezed,
    Object? muted = freezed,
    Object? createdTime = freezed,
    Object? acceptedTime = freezed,
    Object? hungUpTime = freezed,
    Object? failure = freezed,
    Object? localStream = freezed,
    Object? remoteStream = freezed,
    Object? peerConnection = freezed,
  }) {
    return _then(_$_ActiveCall(
      direction: direction == freezed
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as Direction,
      callId: callId == freezed
          ? _value.callId
          : callId // ignore: cast_nullable_to_non_nullable
              as CallIdValue,
      handle: handle == freezed
          ? _value.handle
          : handle // ignore: cast_nullable_to_non_nullable
              as CallkeepHandle,
      displayName: displayName == freezed
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      video: video == freezed
          ? _value.video
          : video // ignore: cast_nullable_to_non_nullable
              as bool,
      held: held == freezed
          ? _value.held
          : held // ignore: cast_nullable_to_non_nullable
              as bool,
      muted: muted == freezed
          ? _value.muted
          : muted // ignore: cast_nullable_to_non_nullable
              as bool,
      createdTime: createdTime == freezed
          ? _value.createdTime
          : createdTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      acceptedTime: acceptedTime == freezed
          ? _value.acceptedTime
          : acceptedTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      hungUpTime: hungUpTime == freezed
          ? _value.hungUpTime
          : hungUpTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      failure: failure == freezed ? _value.failure : failure,
      localStream: localStream == freezed
          ? _value.localStream
          : localStream // ignore: cast_nullable_to_non_nullable
              as MediaStream?,
      remoteStream: remoteStream == freezed
          ? _value.remoteStream
          : remoteStream // ignore: cast_nullable_to_non_nullable
              as MediaStream?,
      peerConnection: peerConnection == freezed
          ? _value.peerConnection
          : peerConnection // ignore: cast_nullable_to_non_nullable
              as RTCPeerConnection?,
    ));
  }
}

/// @nodoc

class _$_ActiveCall extends _ActiveCall {
  const _$_ActiveCall(
      {required this.direction,
      required this.callId,
      required this.handle,
      this.displayName,
      required this.video,
      this.held = false,
      this.muted = false,
      required this.createdTime,
      this.acceptedTime,
      this.hungUpTime,
      this.failure,
      this.localStream,
      this.remoteStream,
      this.peerConnection})
      : super._();

  @override
  final Direction direction;
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
  final RTCPeerConnection? peerConnection;

  @override
  String toString() {
    return 'ActiveCall(direction: $direction, callId: $callId, handle: $handle, displayName: $displayName, video: $video, held: $held, muted: $muted, createdTime: $createdTime, acceptedTime: $acceptedTime, hungUpTime: $hungUpTime, failure: $failure, localStream: $localStream, remoteStream: $remoteStream, peerConnection: $peerConnection)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ActiveCall &&
            const DeepCollectionEquality().equals(other.direction, direction) &&
            const DeepCollectionEquality().equals(other.callId, callId) &&
            const DeepCollectionEquality().equals(other.handle, handle) &&
            const DeepCollectionEquality()
                .equals(other.displayName, displayName) &&
            const DeepCollectionEquality().equals(other.video, video) &&
            const DeepCollectionEquality().equals(other.held, held) &&
            const DeepCollectionEquality().equals(other.muted, muted) &&
            const DeepCollectionEquality()
                .equals(other.createdTime, createdTime) &&
            const DeepCollectionEquality()
                .equals(other.acceptedTime, acceptedTime) &&
            const DeepCollectionEquality()
                .equals(other.hungUpTime, hungUpTime) &&
            const DeepCollectionEquality().equals(other.failure, failure) &&
            const DeepCollectionEquality()
                .equals(other.localStream, localStream) &&
            const DeepCollectionEquality()
                .equals(other.remoteStream, remoteStream) &&
            const DeepCollectionEquality()
                .equals(other.peerConnection, peerConnection));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(direction),
      const DeepCollectionEquality().hash(callId),
      const DeepCollectionEquality().hash(handle),
      const DeepCollectionEquality().hash(displayName),
      const DeepCollectionEquality().hash(video),
      const DeepCollectionEquality().hash(held),
      const DeepCollectionEquality().hash(muted),
      const DeepCollectionEquality().hash(createdTime),
      const DeepCollectionEquality().hash(acceptedTime),
      const DeepCollectionEquality().hash(hungUpTime),
      const DeepCollectionEquality().hash(failure),
      const DeepCollectionEquality().hash(localStream),
      const DeepCollectionEquality().hash(remoteStream),
      const DeepCollectionEquality().hash(peerConnection));

  @JsonKey(ignore: true)
  @override
  _$$_ActiveCallCopyWith<_$_ActiveCall> get copyWith =>
      __$$_ActiveCallCopyWithImpl<_$_ActiveCall>(this, _$identity);
}

abstract class _ActiveCall extends ActiveCall {
  const factory _ActiveCall(
      {required final Direction direction,
      required final CallIdValue callId,
      required final CallkeepHandle handle,
      final String? displayName,
      required final bool video,
      final bool held,
      final bool muted,
      required final DateTime createdTime,
      final DateTime? acceptedTime,
      final DateTime? hungUpTime,
      final Object? failure,
      final MediaStream? localStream,
      final MediaStream? remoteStream,
      final RTCPeerConnection? peerConnection}) = _$_ActiveCall;
  const _ActiveCall._() : super._();

  @override
  Direction get direction;
  @override
  CallIdValue get callId;
  @override
  CallkeepHandle get handle;
  @override
  String? get displayName;
  @override
  bool get video;
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
  RTCPeerConnection? get peerConnection;
  @override
  @JsonKey(ignore: true)
  _$$_ActiveCallCopyWith<_$_ActiveCall> get copyWith =>
      throw _privateConstructorUsedError;
}
