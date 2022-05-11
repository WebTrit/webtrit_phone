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
mixin _$CallState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() signalingInProgress,
    required TResult Function(String reason) signalingFailure,
    required TResult Function() idle,
    required TResult Function(
            Direction direction,
            String callId,
            String number,
            bool video,
            DateTime createdTime,
            DateTime? acceptedTime,
            DateTime? hungUpTime,
            MediaStream? localStream,
            MediaStream? remoteStream)
        active,
    required TResult Function(String reason) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? signalingInProgress,
    TResult Function(String reason)? signalingFailure,
    TResult Function()? idle,
    TResult Function(
            Direction direction,
            String callId,
            String number,
            bool video,
            DateTime createdTime,
            DateTime? acceptedTime,
            DateTime? hungUpTime,
            MediaStream? localStream,
            MediaStream? remoteStream)?
        active,
    TResult Function(String reason)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? signalingInProgress,
    TResult Function(String reason)? signalingFailure,
    TResult Function()? idle,
    TResult Function(
            Direction direction,
            String callId,
            String number,
            bool video,
            DateTime createdTime,
            DateTime? acceptedTime,
            DateTime? hungUpTime,
            MediaStream? localStream,
            MediaStream? remoteStream)?
        active,
    TResult Function(String reason)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitialCallState value) initial,
    required TResult Function(SignalingInProgressCallState value)
        signalingInProgress,
    required TResult Function(SignalingFailureCallState value) signalingFailure,
    required TResult Function(IdleCallState value) idle,
    required TResult Function(ActiveCallState value) active,
    required TResult Function(FailureCallState value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(InitialCallState value)? initial,
    TResult Function(SignalingInProgressCallState value)? signalingInProgress,
    TResult Function(SignalingFailureCallState value)? signalingFailure,
    TResult Function(IdleCallState value)? idle,
    TResult Function(ActiveCallState value)? active,
    TResult Function(FailureCallState value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitialCallState value)? initial,
    TResult Function(SignalingInProgressCallState value)? signalingInProgress,
    TResult Function(SignalingFailureCallState value)? signalingFailure,
    TResult Function(IdleCallState value)? idle,
    TResult Function(ActiveCallState value)? active,
    TResult Function(FailureCallState value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CallStateCopyWith<$Res> {
  factory $CallStateCopyWith(CallState value, $Res Function(CallState) then) =
      _$CallStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$CallStateCopyWithImpl<$Res> implements $CallStateCopyWith<$Res> {
  _$CallStateCopyWithImpl(this._value, this._then);

  final CallState _value;
  // ignore: unused_field
  final $Res Function(CallState) _then;
}

/// @nodoc
abstract class $InitialCallStateCopyWith<$Res> {
  factory $InitialCallStateCopyWith(
          InitialCallState value, $Res Function(InitialCallState) then) =
      _$InitialCallStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$InitialCallStateCopyWithImpl<$Res> extends _$CallStateCopyWithImpl<$Res>
    implements $InitialCallStateCopyWith<$Res> {
  _$InitialCallStateCopyWithImpl(
      InitialCallState _value, $Res Function(InitialCallState) _then)
      : super(_value, (v) => _then(v as InitialCallState));

  @override
  InitialCallState get _value => super._value as InitialCallState;
}

/// @nodoc

class _$InitialCallState implements InitialCallState {
  const _$InitialCallState();

  @override
  String toString() {
    return 'CallState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is InitialCallState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() signalingInProgress,
    required TResult Function(String reason) signalingFailure,
    required TResult Function() idle,
    required TResult Function(
            Direction direction,
            String callId,
            String number,
            bool video,
            DateTime createdTime,
            DateTime? acceptedTime,
            DateTime? hungUpTime,
            MediaStream? localStream,
            MediaStream? remoteStream)
        active,
    required TResult Function(String reason) failure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? signalingInProgress,
    TResult Function(String reason)? signalingFailure,
    TResult Function()? idle,
    TResult Function(
            Direction direction,
            String callId,
            String number,
            bool video,
            DateTime createdTime,
            DateTime? acceptedTime,
            DateTime? hungUpTime,
            MediaStream? localStream,
            MediaStream? remoteStream)?
        active,
    TResult Function(String reason)? failure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? signalingInProgress,
    TResult Function(String reason)? signalingFailure,
    TResult Function()? idle,
    TResult Function(
            Direction direction,
            String callId,
            String number,
            bool video,
            DateTime createdTime,
            DateTime? acceptedTime,
            DateTime? hungUpTime,
            MediaStream? localStream,
            MediaStream? remoteStream)?
        active,
    TResult Function(String reason)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitialCallState value) initial,
    required TResult Function(SignalingInProgressCallState value)
        signalingInProgress,
    required TResult Function(SignalingFailureCallState value) signalingFailure,
    required TResult Function(IdleCallState value) idle,
    required TResult Function(ActiveCallState value) active,
    required TResult Function(FailureCallState value) failure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(InitialCallState value)? initial,
    TResult Function(SignalingInProgressCallState value)? signalingInProgress,
    TResult Function(SignalingFailureCallState value)? signalingFailure,
    TResult Function(IdleCallState value)? idle,
    TResult Function(ActiveCallState value)? active,
    TResult Function(FailureCallState value)? failure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitialCallState value)? initial,
    TResult Function(SignalingInProgressCallState value)? signalingInProgress,
    TResult Function(SignalingFailureCallState value)? signalingFailure,
    TResult Function(IdleCallState value)? idle,
    TResult Function(ActiveCallState value)? active,
    TResult Function(FailureCallState value)? failure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class InitialCallState implements CallState {
  const factory InitialCallState() = _$InitialCallState;
}

/// @nodoc
abstract class $SignalingInProgressCallStateCopyWith<$Res> {
  factory $SignalingInProgressCallStateCopyWith(
          SignalingInProgressCallState value,
          $Res Function(SignalingInProgressCallState) then) =
      _$SignalingInProgressCallStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$SignalingInProgressCallStateCopyWithImpl<$Res>
    extends _$CallStateCopyWithImpl<$Res>
    implements $SignalingInProgressCallStateCopyWith<$Res> {
  _$SignalingInProgressCallStateCopyWithImpl(
      SignalingInProgressCallState _value,
      $Res Function(SignalingInProgressCallState) _then)
      : super(_value, (v) => _then(v as SignalingInProgressCallState));

  @override
  SignalingInProgressCallState get _value =>
      super._value as SignalingInProgressCallState;
}

/// @nodoc

class _$SignalingInProgressCallState implements SignalingInProgressCallState {
  const _$SignalingInProgressCallState();

  @override
  String toString() {
    return 'CallState.signalingInProgress()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SignalingInProgressCallState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() signalingInProgress,
    required TResult Function(String reason) signalingFailure,
    required TResult Function() idle,
    required TResult Function(
            Direction direction,
            String callId,
            String number,
            bool video,
            DateTime createdTime,
            DateTime? acceptedTime,
            DateTime? hungUpTime,
            MediaStream? localStream,
            MediaStream? remoteStream)
        active,
    required TResult Function(String reason) failure,
  }) {
    return signalingInProgress();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? signalingInProgress,
    TResult Function(String reason)? signalingFailure,
    TResult Function()? idle,
    TResult Function(
            Direction direction,
            String callId,
            String number,
            bool video,
            DateTime createdTime,
            DateTime? acceptedTime,
            DateTime? hungUpTime,
            MediaStream? localStream,
            MediaStream? remoteStream)?
        active,
    TResult Function(String reason)? failure,
  }) {
    return signalingInProgress?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? signalingInProgress,
    TResult Function(String reason)? signalingFailure,
    TResult Function()? idle,
    TResult Function(
            Direction direction,
            String callId,
            String number,
            bool video,
            DateTime createdTime,
            DateTime? acceptedTime,
            DateTime? hungUpTime,
            MediaStream? localStream,
            MediaStream? remoteStream)?
        active,
    TResult Function(String reason)? failure,
    required TResult orElse(),
  }) {
    if (signalingInProgress != null) {
      return signalingInProgress();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitialCallState value) initial,
    required TResult Function(SignalingInProgressCallState value)
        signalingInProgress,
    required TResult Function(SignalingFailureCallState value) signalingFailure,
    required TResult Function(IdleCallState value) idle,
    required TResult Function(ActiveCallState value) active,
    required TResult Function(FailureCallState value) failure,
  }) {
    return signalingInProgress(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(InitialCallState value)? initial,
    TResult Function(SignalingInProgressCallState value)? signalingInProgress,
    TResult Function(SignalingFailureCallState value)? signalingFailure,
    TResult Function(IdleCallState value)? idle,
    TResult Function(ActiveCallState value)? active,
    TResult Function(FailureCallState value)? failure,
  }) {
    return signalingInProgress?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitialCallState value)? initial,
    TResult Function(SignalingInProgressCallState value)? signalingInProgress,
    TResult Function(SignalingFailureCallState value)? signalingFailure,
    TResult Function(IdleCallState value)? idle,
    TResult Function(ActiveCallState value)? active,
    TResult Function(FailureCallState value)? failure,
    required TResult orElse(),
  }) {
    if (signalingInProgress != null) {
      return signalingInProgress(this);
    }
    return orElse();
  }
}

abstract class SignalingInProgressCallState implements CallState {
  const factory SignalingInProgressCallState() = _$SignalingInProgressCallState;
}

/// @nodoc
abstract class $SignalingFailureCallStateCopyWith<$Res> {
  factory $SignalingFailureCallStateCopyWith(SignalingFailureCallState value,
          $Res Function(SignalingFailureCallState) then) =
      _$SignalingFailureCallStateCopyWithImpl<$Res>;
  $Res call({String reason});
}

/// @nodoc
class _$SignalingFailureCallStateCopyWithImpl<$Res>
    extends _$CallStateCopyWithImpl<$Res>
    implements $SignalingFailureCallStateCopyWith<$Res> {
  _$SignalingFailureCallStateCopyWithImpl(SignalingFailureCallState _value,
      $Res Function(SignalingFailureCallState) _then)
      : super(_value, (v) => _then(v as SignalingFailureCallState));

  @override
  SignalingFailureCallState get _value =>
      super._value as SignalingFailureCallState;

  @override
  $Res call({
    Object? reason = freezed,
  }) {
    return _then(SignalingFailureCallState(
      reason: reason == freezed
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SignalingFailureCallState implements SignalingFailureCallState {
  const _$SignalingFailureCallState({required this.reason});

  @override
  final String reason;

  @override
  String toString() {
    return 'CallState.signalingFailure(reason: $reason)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SignalingFailureCallState &&
            const DeepCollectionEquality().equals(other.reason, reason));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(reason));

  @JsonKey(ignore: true)
  @override
  $SignalingFailureCallStateCopyWith<SignalingFailureCallState> get copyWith =>
      _$SignalingFailureCallStateCopyWithImpl<SignalingFailureCallState>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() signalingInProgress,
    required TResult Function(String reason) signalingFailure,
    required TResult Function() idle,
    required TResult Function(
            Direction direction,
            String callId,
            String number,
            bool video,
            DateTime createdTime,
            DateTime? acceptedTime,
            DateTime? hungUpTime,
            MediaStream? localStream,
            MediaStream? remoteStream)
        active,
    required TResult Function(String reason) failure,
  }) {
    return signalingFailure(reason);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? signalingInProgress,
    TResult Function(String reason)? signalingFailure,
    TResult Function()? idle,
    TResult Function(
            Direction direction,
            String callId,
            String number,
            bool video,
            DateTime createdTime,
            DateTime? acceptedTime,
            DateTime? hungUpTime,
            MediaStream? localStream,
            MediaStream? remoteStream)?
        active,
    TResult Function(String reason)? failure,
  }) {
    return signalingFailure?.call(reason);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? signalingInProgress,
    TResult Function(String reason)? signalingFailure,
    TResult Function()? idle,
    TResult Function(
            Direction direction,
            String callId,
            String number,
            bool video,
            DateTime createdTime,
            DateTime? acceptedTime,
            DateTime? hungUpTime,
            MediaStream? localStream,
            MediaStream? remoteStream)?
        active,
    TResult Function(String reason)? failure,
    required TResult orElse(),
  }) {
    if (signalingFailure != null) {
      return signalingFailure(reason);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitialCallState value) initial,
    required TResult Function(SignalingInProgressCallState value)
        signalingInProgress,
    required TResult Function(SignalingFailureCallState value) signalingFailure,
    required TResult Function(IdleCallState value) idle,
    required TResult Function(ActiveCallState value) active,
    required TResult Function(FailureCallState value) failure,
  }) {
    return signalingFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(InitialCallState value)? initial,
    TResult Function(SignalingInProgressCallState value)? signalingInProgress,
    TResult Function(SignalingFailureCallState value)? signalingFailure,
    TResult Function(IdleCallState value)? idle,
    TResult Function(ActiveCallState value)? active,
    TResult Function(FailureCallState value)? failure,
  }) {
    return signalingFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitialCallState value)? initial,
    TResult Function(SignalingInProgressCallState value)? signalingInProgress,
    TResult Function(SignalingFailureCallState value)? signalingFailure,
    TResult Function(IdleCallState value)? idle,
    TResult Function(ActiveCallState value)? active,
    TResult Function(FailureCallState value)? failure,
    required TResult orElse(),
  }) {
    if (signalingFailure != null) {
      return signalingFailure(this);
    }
    return orElse();
  }
}

abstract class SignalingFailureCallState implements CallState {
  const factory SignalingFailureCallState({required final String reason}) =
      _$SignalingFailureCallState;

  String get reason => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SignalingFailureCallStateCopyWith<SignalingFailureCallState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IdleCallStateCopyWith<$Res> {
  factory $IdleCallStateCopyWith(
          IdleCallState value, $Res Function(IdleCallState) then) =
      _$IdleCallStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$IdleCallStateCopyWithImpl<$Res> extends _$CallStateCopyWithImpl<$Res>
    implements $IdleCallStateCopyWith<$Res> {
  _$IdleCallStateCopyWithImpl(
      IdleCallState _value, $Res Function(IdleCallState) _then)
      : super(_value, (v) => _then(v as IdleCallState));

  @override
  IdleCallState get _value => super._value as IdleCallState;
}

/// @nodoc

class _$IdleCallState with ReadyCallStateMixin implements IdleCallState {
  const _$IdleCallState();

  @override
  String toString() {
    return 'CallState.idle()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is IdleCallState);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() signalingInProgress,
    required TResult Function(String reason) signalingFailure,
    required TResult Function() idle,
    required TResult Function(
            Direction direction,
            String callId,
            String number,
            bool video,
            DateTime createdTime,
            DateTime? acceptedTime,
            DateTime? hungUpTime,
            MediaStream? localStream,
            MediaStream? remoteStream)
        active,
    required TResult Function(String reason) failure,
  }) {
    return idle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? signalingInProgress,
    TResult Function(String reason)? signalingFailure,
    TResult Function()? idle,
    TResult Function(
            Direction direction,
            String callId,
            String number,
            bool video,
            DateTime createdTime,
            DateTime? acceptedTime,
            DateTime? hungUpTime,
            MediaStream? localStream,
            MediaStream? remoteStream)?
        active,
    TResult Function(String reason)? failure,
  }) {
    return idle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? signalingInProgress,
    TResult Function(String reason)? signalingFailure,
    TResult Function()? idle,
    TResult Function(
            Direction direction,
            String callId,
            String number,
            bool video,
            DateTime createdTime,
            DateTime? acceptedTime,
            DateTime? hungUpTime,
            MediaStream? localStream,
            MediaStream? remoteStream)?
        active,
    TResult Function(String reason)? failure,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitialCallState value) initial,
    required TResult Function(SignalingInProgressCallState value)
        signalingInProgress,
    required TResult Function(SignalingFailureCallState value) signalingFailure,
    required TResult Function(IdleCallState value) idle,
    required TResult Function(ActiveCallState value) active,
    required TResult Function(FailureCallState value) failure,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(InitialCallState value)? initial,
    TResult Function(SignalingInProgressCallState value)? signalingInProgress,
    TResult Function(SignalingFailureCallState value)? signalingFailure,
    TResult Function(IdleCallState value)? idle,
    TResult Function(ActiveCallState value)? active,
    TResult Function(FailureCallState value)? failure,
  }) {
    return idle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitialCallState value)? initial,
    TResult Function(SignalingInProgressCallState value)? signalingInProgress,
    TResult Function(SignalingFailureCallState value)? signalingFailure,
    TResult Function(IdleCallState value)? idle,
    TResult Function(ActiveCallState value)? active,
    TResult Function(FailureCallState value)? failure,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class IdleCallState implements CallState, ReadyCallStateMixin {
  const factory IdleCallState() = _$IdleCallState;
}

/// @nodoc
abstract class $ActiveCallStateCopyWith<$Res> {
  factory $ActiveCallStateCopyWith(
          ActiveCallState value, $Res Function(ActiveCallState) then) =
      _$ActiveCallStateCopyWithImpl<$Res>;
  $Res call(
      {Direction direction,
      String callId,
      String number,
      bool video,
      DateTime createdTime,
      DateTime? acceptedTime,
      DateTime? hungUpTime,
      MediaStream? localStream,
      MediaStream? remoteStream});
}

/// @nodoc
class _$ActiveCallStateCopyWithImpl<$Res> extends _$CallStateCopyWithImpl<$Res>
    implements $ActiveCallStateCopyWith<$Res> {
  _$ActiveCallStateCopyWithImpl(
      ActiveCallState _value, $Res Function(ActiveCallState) _then)
      : super(_value, (v) => _then(v as ActiveCallState));

  @override
  ActiveCallState get _value => super._value as ActiveCallState;

  @override
  $Res call({
    Object? direction = freezed,
    Object? callId = freezed,
    Object? number = freezed,
    Object? video = freezed,
    Object? createdTime = freezed,
    Object? acceptedTime = freezed,
    Object? hungUpTime = freezed,
    Object? localStream = freezed,
    Object? remoteStream = freezed,
  }) {
    return _then(ActiveCallState(
      direction: direction == freezed
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as Direction,
      callId: callId == freezed
          ? _value.callId
          : callId // ignore: cast_nullable_to_non_nullable
              as String,
      number: number == freezed
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as String,
      video: video == freezed
          ? _value.video
          : video // ignore: cast_nullable_to_non_nullable
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
      localStream: localStream == freezed
          ? _value.localStream
          : localStream // ignore: cast_nullable_to_non_nullable
              as MediaStream?,
      remoteStream: remoteStream == freezed
          ? _value.remoteStream
          : remoteStream // ignore: cast_nullable_to_non_nullable
              as MediaStream?,
    ));
  }
}

/// @nodoc

class _$ActiveCallState
    with ReadyCallStateMixin, CallMixin
    implements ActiveCallState {
  const _$ActiveCallState(
      {required this.direction,
      required this.callId,
      required this.number,
      required this.video,
      required this.createdTime,
      this.acceptedTime,
      this.hungUpTime,
      this.localStream,
      this.remoteStream});

  @override
  final Direction direction;
  @override
  final String callId;
  @override
  final String number;
  @override
  final bool video;
  @override
  final DateTime createdTime;
  @override
  final DateTime? acceptedTime;
  @override
  final DateTime? hungUpTime;
  @override
  final MediaStream? localStream;
  @override
  final MediaStream? remoteStream;

  @override
  String toString() {
    return 'CallState.active(direction: $direction, callId: $callId, number: $number, video: $video, createdTime: $createdTime, acceptedTime: $acceptedTime, hungUpTime: $hungUpTime, localStream: $localStream, remoteStream: $remoteStream)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ActiveCallState &&
            const DeepCollectionEquality().equals(other.direction, direction) &&
            const DeepCollectionEquality().equals(other.callId, callId) &&
            const DeepCollectionEquality().equals(other.number, number) &&
            const DeepCollectionEquality().equals(other.video, video) &&
            const DeepCollectionEquality()
                .equals(other.createdTime, createdTime) &&
            const DeepCollectionEquality()
                .equals(other.acceptedTime, acceptedTime) &&
            const DeepCollectionEquality()
                .equals(other.hungUpTime, hungUpTime) &&
            const DeepCollectionEquality()
                .equals(other.localStream, localStream) &&
            const DeepCollectionEquality()
                .equals(other.remoteStream, remoteStream));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(direction),
      const DeepCollectionEquality().hash(callId),
      const DeepCollectionEquality().hash(number),
      const DeepCollectionEquality().hash(video),
      const DeepCollectionEquality().hash(createdTime),
      const DeepCollectionEquality().hash(acceptedTime),
      const DeepCollectionEquality().hash(hungUpTime),
      const DeepCollectionEquality().hash(localStream),
      const DeepCollectionEquality().hash(remoteStream));

  @JsonKey(ignore: true)
  @override
  $ActiveCallStateCopyWith<ActiveCallState> get copyWith =>
      _$ActiveCallStateCopyWithImpl<ActiveCallState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() signalingInProgress,
    required TResult Function(String reason) signalingFailure,
    required TResult Function() idle,
    required TResult Function(
            Direction direction,
            String callId,
            String number,
            bool video,
            DateTime createdTime,
            DateTime? acceptedTime,
            DateTime? hungUpTime,
            MediaStream? localStream,
            MediaStream? remoteStream)
        active,
    required TResult Function(String reason) failure,
  }) {
    return active(direction, callId, number, video, createdTime, acceptedTime,
        hungUpTime, localStream, remoteStream);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? signalingInProgress,
    TResult Function(String reason)? signalingFailure,
    TResult Function()? idle,
    TResult Function(
            Direction direction,
            String callId,
            String number,
            bool video,
            DateTime createdTime,
            DateTime? acceptedTime,
            DateTime? hungUpTime,
            MediaStream? localStream,
            MediaStream? remoteStream)?
        active,
    TResult Function(String reason)? failure,
  }) {
    return active?.call(direction, callId, number, video, createdTime,
        acceptedTime, hungUpTime, localStream, remoteStream);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? signalingInProgress,
    TResult Function(String reason)? signalingFailure,
    TResult Function()? idle,
    TResult Function(
            Direction direction,
            String callId,
            String number,
            bool video,
            DateTime createdTime,
            DateTime? acceptedTime,
            DateTime? hungUpTime,
            MediaStream? localStream,
            MediaStream? remoteStream)?
        active,
    TResult Function(String reason)? failure,
    required TResult orElse(),
  }) {
    if (active != null) {
      return active(direction, callId, number, video, createdTime, acceptedTime,
          hungUpTime, localStream, remoteStream);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitialCallState value) initial,
    required TResult Function(SignalingInProgressCallState value)
        signalingInProgress,
    required TResult Function(SignalingFailureCallState value) signalingFailure,
    required TResult Function(IdleCallState value) idle,
    required TResult Function(ActiveCallState value) active,
    required TResult Function(FailureCallState value) failure,
  }) {
    return active(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(InitialCallState value)? initial,
    TResult Function(SignalingInProgressCallState value)? signalingInProgress,
    TResult Function(SignalingFailureCallState value)? signalingFailure,
    TResult Function(IdleCallState value)? idle,
    TResult Function(ActiveCallState value)? active,
    TResult Function(FailureCallState value)? failure,
  }) {
    return active?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitialCallState value)? initial,
    TResult Function(SignalingInProgressCallState value)? signalingInProgress,
    TResult Function(SignalingFailureCallState value)? signalingFailure,
    TResult Function(IdleCallState value)? idle,
    TResult Function(ActiveCallState value)? active,
    TResult Function(FailureCallState value)? failure,
    required TResult orElse(),
  }) {
    if (active != null) {
      return active(this);
    }
    return orElse();
  }
}

abstract class ActiveCallState
    implements CallState, ReadyCallStateMixin, CallMixin {
  const factory ActiveCallState(
      {required final Direction direction,
      required final String callId,
      required final String number,
      required final bool video,
      required final DateTime createdTime,
      final DateTime? acceptedTime,
      final DateTime? hungUpTime,
      final MediaStream? localStream,
      final MediaStream? remoteStream}) = _$ActiveCallState;

  Direction get direction => throw _privateConstructorUsedError;
  String get callId => throw _privateConstructorUsedError;
  String get number => throw _privateConstructorUsedError;
  bool get video => throw _privateConstructorUsedError;
  DateTime get createdTime => throw _privateConstructorUsedError;
  DateTime? get acceptedTime => throw _privateConstructorUsedError;
  DateTime? get hungUpTime => throw _privateConstructorUsedError;
  MediaStream? get localStream => throw _privateConstructorUsedError;
  MediaStream? get remoteStream => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ActiveCallStateCopyWith<ActiveCallState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FailureCallStateCopyWith<$Res> {
  factory $FailureCallStateCopyWith(
          FailureCallState value, $Res Function(FailureCallState) then) =
      _$FailureCallStateCopyWithImpl<$Res>;
  $Res call({String reason});
}

/// @nodoc
class _$FailureCallStateCopyWithImpl<$Res> extends _$CallStateCopyWithImpl<$Res>
    implements $FailureCallStateCopyWith<$Res> {
  _$FailureCallStateCopyWithImpl(
      FailureCallState _value, $Res Function(FailureCallState) _then)
      : super(_value, (v) => _then(v as FailureCallState));

  @override
  FailureCallState get _value => super._value as FailureCallState;

  @override
  $Res call({
    Object? reason = freezed,
  }) {
    return _then(FailureCallState(
      reason: reason == freezed
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$FailureCallState with ReadyCallStateMixin implements FailureCallState {
  const _$FailureCallState({required this.reason});

  @override
  final String reason;

  @override
  String toString() {
    return 'CallState.failure(reason: $reason)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FailureCallState &&
            const DeepCollectionEquality().equals(other.reason, reason));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(reason));

  @JsonKey(ignore: true)
  @override
  $FailureCallStateCopyWith<FailureCallState> get copyWith =>
      _$FailureCallStateCopyWithImpl<FailureCallState>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() signalingInProgress,
    required TResult Function(String reason) signalingFailure,
    required TResult Function() idle,
    required TResult Function(
            Direction direction,
            String callId,
            String number,
            bool video,
            DateTime createdTime,
            DateTime? acceptedTime,
            DateTime? hungUpTime,
            MediaStream? localStream,
            MediaStream? remoteStream)
        active,
    required TResult Function(String reason) failure,
  }) {
    return failure(reason);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? signalingInProgress,
    TResult Function(String reason)? signalingFailure,
    TResult Function()? idle,
    TResult Function(
            Direction direction,
            String callId,
            String number,
            bool video,
            DateTime createdTime,
            DateTime? acceptedTime,
            DateTime? hungUpTime,
            MediaStream? localStream,
            MediaStream? remoteStream)?
        active,
    TResult Function(String reason)? failure,
  }) {
    return failure?.call(reason);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? signalingInProgress,
    TResult Function(String reason)? signalingFailure,
    TResult Function()? idle,
    TResult Function(
            Direction direction,
            String callId,
            String number,
            bool video,
            DateTime createdTime,
            DateTime? acceptedTime,
            DateTime? hungUpTime,
            MediaStream? localStream,
            MediaStream? remoteStream)?
        active,
    TResult Function(String reason)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(reason);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InitialCallState value) initial,
    required TResult Function(SignalingInProgressCallState value)
        signalingInProgress,
    required TResult Function(SignalingFailureCallState value) signalingFailure,
    required TResult Function(IdleCallState value) idle,
    required TResult Function(ActiveCallState value) active,
    required TResult Function(FailureCallState value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(InitialCallState value)? initial,
    TResult Function(SignalingInProgressCallState value)? signalingInProgress,
    TResult Function(SignalingFailureCallState value)? signalingFailure,
    TResult Function(IdleCallState value)? idle,
    TResult Function(ActiveCallState value)? active,
    TResult Function(FailureCallState value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InitialCallState value)? initial,
    TResult Function(SignalingInProgressCallState value)? signalingInProgress,
    TResult Function(SignalingFailureCallState value)? signalingFailure,
    TResult Function(IdleCallState value)? idle,
    TResult Function(ActiveCallState value)? active,
    TResult Function(FailureCallState value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class FailureCallState implements CallState, ReadyCallStateMixin {
  const factory FailureCallState({required final String reason}) =
      _$FailureCallState;

  String get reason => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FailureCallStateCopyWith<FailureCallState> get copyWith =>
      throw _privateConstructorUsedError;
}
