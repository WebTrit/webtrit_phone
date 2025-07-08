import 'package:webtrit_signaling/webtrit_signaling.dart';

class HandshakeSignalingState {
  final Registration registration;
  final int linesCount;

  HandshakeSignalingState({
    required this.registration,
    required this.linesCount,
  });
}

class SignalingInternalEvent {
  final String callId;
  final int? line;
  final int code;
  final String reason;

  const SignalingInternalEvent({
    required this.callId,
    required this.line,
    required this.code,
    required this.reason,
  });
}

enum SignalingControlEventType {
  hangUp,
  decline,
}

class SignalingErrorEvent {
  final dynamic error;
  final StackTrace? stackTrace;

  const SignalingErrorEvent({
    required this.error,
    this.stackTrace,
  });
}

class PeerConnectionErrorEvent {
  final String callId;
  final String reason;

  const PeerConnectionErrorEvent({
    required this.callId,
    required this.reason,
  });
}
