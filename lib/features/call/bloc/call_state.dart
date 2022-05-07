part of 'call_bloc.dart';

@freezed
class CallState with _$CallState {
  const factory CallState.initial() = InitialCallState;

  const factory CallState.attachInProgress() = AttachInProgressCallState;

  const factory CallState.attachFailure({required String reason}) = AttachFailureCallState;

  const factory CallState.idle() = IdleCallState;

  @With<Call>()
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

  const factory CallState.failure({required String reason}) = FailureCallState;
}

mixin Call {
  Direction get direction;

  DateTime? get acceptedTime;

  DateTime? get hungUpTime;

  bool get isIncoming => direction == Direction.incoming;

  bool get isOutgoing => direction == Direction.outgoing;

  bool get accepted => acceptedTime != null;

  bool get hungUp => hungUpTime != null;
}
