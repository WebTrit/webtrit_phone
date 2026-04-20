enum QueuedTerminationRequestType { hangup, decline }

class QueuedTerminationRequest {
  const QueuedTerminationRequest({required this.type, required this.callId, required this.line});

  final QueuedTerminationRequestType type;
  final String callId;
  final int? line;

  String get key => '${type.name}:$callId';
}
