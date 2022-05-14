part of 'call_bloc.dart';

@freezed
class CallState with _$CallState {
  const factory CallState.initial() = InitialCallState;

  const factory CallState.signalingInProgress() = SignalingInProgressCallState;

  const factory CallState.signalingFailure({required String reason}) = SignalingFailureCallState;

  @With<ReadyCallStateMixin>()
  const factory CallState.idle() = IdleCallState;

  @With<ReadyCallStateMixin>()
  @With<CallMixin>()
  const factory CallState.active({
    required Direction direction,
    required String callId,
    required String number,
    required bool video,
    required DateTime createdTime,
    DateTime? acceptedTime,
    DateTime? hungUpTime,
    MediaStream? localStream,
    MediaStream? remoteStream,
  }) = ActiveCallState;

  @With<ReadyCallStateMixin>()
  const factory CallState.failure({required String reason}) = FailureCallState;
}

mixin ReadyCallStateMixin {}

mixin CallMixin {
  Direction get direction;

  DateTime? get acceptedTime;

  DateTime? get hungUpTime;

  bool get isIncoming => direction == Direction.incoming;

  bool get isOutgoing => direction == Direction.outgoing;

  bool get wasAccepted => acceptedTime != null;

  bool get wasHungUp => hungUpTime != null;
}
