// WebRTC Renegotiation Queue System
import 'dart:async';

class RenegotiationRequest {
  final String callId;
  final int? lineId;
  final DateTime timestamp;
  final int retryCount;
  final Completer<void> completer;

  RenegotiationRequest({
    required this.callId,
    required this.lineId,
    required this.timestamp,
    this.retryCount = 0,
    required this.completer,
  });

  RenegotiationRequest copyWith({
    int? retryCount,
  }) {
    return RenegotiationRequest(
      callId: callId,
      lineId: lineId,
      timestamp: timestamp,
      retryCount: retryCount ?? this.retryCount,
      completer: completer,
    );
  }
}
