import 'package:webtrit_signaling/webtrit_signaling.dart';

/// Actions returned by [HandshakeProcessor.process] describing what the BLoC
/// should do after processing the signaling [StateHandshake].
sealed class HandshakeAction {
  const HandshakeAction();
}

/// Send a [HangupRequest] to the signaling server and stop processing.
///
/// Emitted when the Callkeep connection for the line is [CallkeepConnectionState.stateDisconnected]
/// and the latest call event is [AcceptedEvent] or [ProceedingEvent].
final class HangupSignalingAction extends HandshakeAction {
  const HangupSignalingAction({required this.line, required this.callId});

  final int? line;
  final String callId;
}

/// Send a [DeclineRequest] to the signaling server and stop processing.
///
/// Emitted when the Callkeep connection for the line is [CallkeepConnectionState.stateDisconnected]
/// and the latest call event is [IncomingCallEvent].
final class DeclineSignalingAction extends HandshakeAction {
  const DeclineSignalingAction({required this.line, required this.callId});

  final int? line;
  final String callId;
}

/// Re-negotiate WebRTC media for an already-accepted incoming call (WT-1167 Subtask 2).
///
/// Emitted when the handshake contains both [IncomingCallEvent] (oldest) and [AcceptedEvent]
/// (newest) for a line, the Callkeep connection is absent, and the call is not already in
/// the BLoC state. This covers the case of Android Activity recreation during an active call.
final class RestoreCallAction extends HandshakeAction {
  const RestoreCallAction({
    required this.line,
    required this.callId,
    required this.incomingCallEvent,
    required this.acceptedTime,
  });

  final int line;
  final String callId;
  final IncomingCallEvent incomingCallEvent;
  final DateTime acceptedTime;
}

/// Deliver an unanswered [IncomingCallEvent] to the BLoC signaling handler.
///
/// Emitted when the line's [callLogs] contains a single [CallEventLog] carrying
/// an [IncomingCallEvent] — the call has not been answered yet.
final class HandleIncomingCallAction extends HandshakeAction {
  const HandleIncomingCallAction({required this.event});

  final IncomingCallEvent event;
}

/// Call [Callkeep.endCall] for a local connection that is no longer present in
/// the signaling state.
final class EndLocalCallAction extends HandshakeAction {
  const EndLocalCallAction({required this.callId});

  final String callId;
}
