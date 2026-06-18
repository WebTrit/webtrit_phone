import '../abstract_events.dart';

/// In-call app-to-app message relayed by the server between the two parties of a
/// call (the server forwards it opaquely, see PeerMessageRequest). The concrete
/// subtype is selected by the inner `type` field; the typed contract for each
/// message lives here, not in the presentation layer. Unknown/malformed types
/// decode to [UnknownPeerMessageEvent] so an older client never crashes on a
/// message kind it does not understand.
sealed class PeerMessageEvent extends CallEvent {
  const PeerMessageEvent({super.transaction, required super.line, required super.callId, this.sender});

  /// Number of the remote party that sent the message.
  final String? sender;

  static const typeValue = 'peer_message';

  factory PeerMessageEvent.fromJson(Map<String, dynamic> json) {
    final eventTypeValue = json[Event.typeKey];
    if (eventTypeValue != typeValue) {
      throw ArgumentError.value(eventTypeValue, Event.typeKey, 'Not equal $typeValue');
    }

    final data = json['data'];
    return switch (json['type']) {
      MediaStatePeerMessageEvent.messageType when data is Map<String, dynamic> && data['video'] is bool =>
        MediaStatePeerMessageEvent.fromJson(json),
      _ => UnknownPeerMessageEvent.fromJson(json),
    };
  }
}

/// Remote camera state during a call (`data: {video: bool}`). Lets the peer
/// reflect a camera on/off change without SDP renegotiation - the only channel
/// that works while the call is still ringing.
final class MediaStatePeerMessageEvent extends PeerMessageEvent {
  const MediaStatePeerMessageEvent({
    super.transaction,
    required super.line,
    required super.callId,
    super.sender,
    required this.video,
  });

  static const messageType = 'media_state';

  final bool video;

  @override
  List<Object?> get props => [...super.props, sender, video];

  @override
  Map<String, dynamic> toJson() => {
    ...callBaseJson(PeerMessageEvent.typeValue),
    'type': messageType,
    'data': {'video': video},
    if (sender != null) 'sender': sender,
  };

  factory MediaStatePeerMessageEvent.fromJson(Map<String, dynamic> json) {
    return MediaStatePeerMessageEvent(
      transaction: json['transaction'],
      line: json['line'],
      callId: json['call_id'],
      sender: json['sender'],
      video: json['data']['video'],
    );
  }
}

/// Any peer_message whose `type` this client build does not handle (or whose
/// `data` is malformed for a known type). Carried raw so callers can log/ignore
/// it without the decoder failing.
final class UnknownPeerMessageEvent extends PeerMessageEvent {
  const UnknownPeerMessageEvent({
    super.transaction,
    required super.line,
    required super.callId,
    super.sender,
    this.type,
    this.data,
  });

  final String? type;
  final Map<String, dynamic>? data;

  @override
  List<Object?> get props => [...super.props, sender, type, data];

  @override
  Map<String, dynamic> toJson() => {
    ...callBaseJson(PeerMessageEvent.typeValue),
    if (type != null) 'type': type,
    if (data != null) 'data': data,
    if (sender != null) 'sender': sender,
  };

  factory UnknownPeerMessageEvent.fromJson(Map<String, dynamic> json) {
    return UnknownPeerMessageEvent(
      transaction: json['transaction'],
      line: json['line'],
      callId: json['call_id'],
      sender: json['sender'],
      type: json['type'],
      data: json['data'],
    );
  }
}
