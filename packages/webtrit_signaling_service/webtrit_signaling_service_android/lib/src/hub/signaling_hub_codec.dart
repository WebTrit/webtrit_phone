import 'package:webtrit_signaling/webtrit_signaling.dart';
import 'package:webtrit_signaling_service_platform_interface/webtrit_signaling_service_platform_interface.dart';

const _tagConnecting = 'connecting';
const _tagConnected = 'connected';
const _tagConnectionFailed = 'connection_failed';
const _tagDisconnecting = 'disconnecting';
const _tagDisconnected = 'disconnected';
const _tagHandshakeReceived = 'handshake_received';
const _tagProtocolEvent = 'protocol_event';
const _tagExecuteResult = 'execute_result';
const _tagSubAck = 'sub_ack';

/// Encodes a [SignalingModuleEvent] into an isolate-safe [List] for transport
/// over a [SendPort].
///
/// This encoding is exhaustive for the current [SignalingModuleEvent]
/// hierarchy. If new event types are added, this method must be updated to
/// encode them.
List<dynamic> encodeHubEvent(SignalingModuleEvent event) {
  switch (event) {
    case SignalingConnecting():
      return [_tagConnecting];
    case SignalingConnected():
      return [_tagConnected];
    case SignalingConnectionFailed(:final error, :final isRepeated, :final recommendedReconnectDelay):
      return [_tagConnectionFailed, error.toString(), isRepeated, recommendedReconnectDelay.inMilliseconds];
    case SignalingDisconnecting():
      return [_tagDisconnecting];
    case SignalingDisconnected(:final code, :final reason, :final knownCode, :final recommendedReconnectDelay):
      return [_tagDisconnected, code, reason, knownCode.name, recommendedReconnectDelay?.inMilliseconds];
    case SignalingHandshakeReceived(:final handshake):
      return [_tagHandshakeReceived, _encodeHandshake(handshake)];
    case SignalingProtocolEvent(:final event):
      return [_tagProtocolEvent, event.toJson()];
  }
}

/// Decodes an isolate-safe [List] back into a [SignalingModuleEvent].
///
/// Returns null for unrecognised or malformed messages so that the hub
/// listener can skip them without crashing.
SignalingModuleEvent? decodeHubEvent(List<dynamic> msg) {
  if (msg.isEmpty) return null;
  final tag = msg[0];
  try {
    switch (tag) {
      case _tagConnecting:
        return SignalingConnecting();
      case _tagConnected:
        return SignalingConnected();
      case _tagConnectionFailed:
        final delayMs = msg[3] as int;
        return SignalingConnectionFailed(
          error: msg[1] as String,
          isRepeated: msg[2] as bool,
          recommendedReconnectDelay: Duration(milliseconds: delayMs),
        );
      case _tagDisconnecting:
        return SignalingDisconnecting();
      case _tagDisconnected:
        final delayMs = msg[4] as int?;
        final knownCodeName = msg[3] as String;
        final knownCode =
            SignalingDisconnectCode.values.asNameMap()[knownCodeName] ?? SignalingDisconnectCode.unmappedCode;
        return SignalingDisconnected(
          code: msg[1] as int?,
          reason: msg[2] as String?,
          knownCode: knownCode,
          recommendedReconnectDelay: delayMs != null ? Duration(milliseconds: delayMs) : null,
        );
      case _tagHandshakeReceived:
        final handshake = StateHandshake.fromJson(Map<String, dynamic>.from(msg[1] as Map));
        return SignalingHandshakeReceived(handshake: handshake);
      case _tagProtocolEvent:
        final event = Event.fromJson(Map<String, dynamic>.from(msg[1] as Map));
        return SignalingProtocolEvent(event: event);
      default:
        return null;
    }
  } catch (_) {
    return null;
  }
}

/// Encodes an execute result for transport from hub to subscriber.
List<dynamic> encodeExecuteResult(String correlationId, Object? error) => [
  _tagExecuteResult,
  correlationId,
  error?.toString(),
];

bool isExecuteResult(List<dynamic> msg) => msg.isNotEmpty && msg[0] == _tagExecuteResult;

({String correlationId, String? error}) decodeExecuteResult(List<dynamic> msg) =>
    (correlationId: msg[1] as String, error: msg[2] as String?);

/// Encodes a subscribe-ack sent by the hub to confirm a new subscriber's port is live.
List<dynamic> encodeSubAck() => [_tagSubAck];

bool isSubAck(List<dynamic> msg) => msg.isNotEmpty && msg[0] == _tagSubAck;

Map<String, dynamic> _encodeHandshake(StateHandshake h) {
  return {
    'handshake': StateHandshake.typeValue,
    'keepalive_interval': h.keepaliveInterval.inMilliseconds,
    'timestamp': h.timestamp,
    'registration': {
      'status': h.registration.status.name,
      if (h.registration.code != null) 'code': h.registration.code,
      if (h.registration.reason != null) 'reason': h.registration.reason,
    },
    'lines': h.lines.map((line) {
      if (line == null) return null;
      final encodedLogs = line.callLogs
          .whereType<CallEventLog>()
          .map((log) => [log.timestamp, log.callEvent.toJson()])
          .toList();
      return {'call_id': line.callId, 'call_logs': encodedLogs};
    }).toList(),
    'user_active_calls': <dynamic>[],
    'presence_contacts_info': <String, dynamic>{},
  };
}
