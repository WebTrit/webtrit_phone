import '../abstract_requests.dart';

/// In-call app-to-app message. The server is a dumb relay: it forwards the
/// envelope to the peer's sessions without inspecting it. The concrete subtype
/// is selected by the inner `type` field; each message's typed contract lives
/// here. Requests are client->server only, so an unknown `type` is a genuine
/// programming error (unlike inbound events, there is no forward-compat case).
sealed class PeerMessageRequest extends CallRequest {
  const PeerMessageRequest({required super.transaction, required super.line, required super.callId});

  static const typeValue = 'peer_message';

  factory PeerMessageRequest.fromJson(Map<String, dynamic> json) {
    final requestTypeValue = json[Request.typeKey];
    if (requestTypeValue != typeValue) {
      throw ArgumentError.value(requestTypeValue, Request.typeKey, 'Not equal $typeValue');
    }

    return switch (json['type']) {
      MediaStatePeerMessageRequest.messageType => MediaStatePeerMessageRequest.fromJson(json),
      final other => throw ArgumentError.value(other, 'type', 'Unknown peer_message type'),
    };
  }
}

/// Local camera state to mirror on the peer (`data: {video: bool}`).
final class MediaStatePeerMessageRequest extends PeerMessageRequest {
  const MediaStatePeerMessageRequest({
    required super.transaction,
    required super.line,
    required super.callId,
    required this.video,
  });

  static const messageType = 'media_state';

  final bool video;

  @override
  List<Object?> get props => [...super.props, video];

  factory MediaStatePeerMessageRequest.fromJson(Map<String, dynamic> json) {
    return MediaStatePeerMessageRequest(
      transaction: json['transaction'],
      line: json['line'],
      callId: json['call_id'],
      video: json['data']['video'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      Request.typeKey: PeerMessageRequest.typeValue,
      'transaction': transaction,
      'line': line,
      'call_id': callId,
      'type': messageType,
      'data': {'video': video},
    };
  }
}
