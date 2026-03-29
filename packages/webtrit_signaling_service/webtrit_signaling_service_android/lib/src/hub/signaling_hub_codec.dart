import 'package:webtrit_signaling/webtrit_signaling.dart';
import 'package:webtrit_signaling_service_platform_interface/webtrit_signaling_service_platform_interface.dart';

// ---------------------------------------------------------------------------
// Type discriminators (hub -> subscriber, position [0])
// ---------------------------------------------------------------------------

const _kConnecting = 0;
const _kConnected = 1;
const _kConnectionFailed = 2;
const _kDisconnecting = 3;
const _kDisconnected = 4;
const _kHandshakeReceived = 5;
const _kProtocolEvent = 6;
const _kExecuteResult = 7;
const _kSubAck = 8;

// ---------------------------------------------------------------------------
// Encode SignalingModuleEvent -> List<dynamic>
// ---------------------------------------------------------------------------

List<dynamic>? encodeHubEvent(SignalingModuleEvent event) {
  switch (event) {
    case SignalingConnecting():
      return [_kConnecting];
    case SignalingConnected():
      return [_kConnected];
    case SignalingConnectionFailed(:final error, :final isRepeated, :final recommendedReconnectDelay):
      return [_kConnectionFailed, error.toString(), isRepeated, recommendedReconnectDelay.inMilliseconds];
    case SignalingDisconnecting():
      return [_kDisconnecting];
    case SignalingDisconnected(:final code, :final reason, :final knownCode, :final recommendedReconnectDelay):
      return [_kDisconnected, code, reason, knownCode.index, recommendedReconnectDelay?.inMilliseconds];
    case SignalingHandshakeReceived(:final handshake):
      return [_kHandshakeReceived, _encodeHandshake(handshake)];
    case SignalingProtocolEvent(:final event):
      return [_kProtocolEvent, event.toJson()];
  }
}

// ---------------------------------------------------------------------------
// Decode List<dynamic> -> SignalingModuleEvent
// ---------------------------------------------------------------------------

SignalingModuleEvent? decodeHubEvent(List<dynamic> msg) {
  if (msg.isEmpty) return null;
  final type = msg[0] as int;
  switch (type) {
    case _kConnecting:
      return SignalingConnecting();
    case _kConnected:
      return SignalingConnected();
    case _kConnectionFailed:
      final delayMs = msg[3] as int;
      return SignalingConnectionFailed(
        error: msg[1] as String,
        isRepeated: msg[2] as bool,
        recommendedReconnectDelay: Duration(milliseconds: delayMs),
      );
    case _kDisconnecting:
      return SignalingDisconnecting();
    case _kDisconnected:
      final delayMs = msg[4] as int?;
      return SignalingDisconnected(
        code: msg[1] as int?,
        reason: msg[2] as String?,
        knownCode: SignalingDisconnectCode.values[msg[3] as int],
        recommendedReconnectDelay: delayMs != null ? Duration(milliseconds: delayMs) : null,
      );
    case _kHandshakeReceived:
      try {
        final handshake = StateHandshake.fromJson(Map<String, dynamic>.from(msg[1] as Map));
        return SignalingHandshakeReceived(handshake: handshake);
      } catch (_) {
        return null;
      }
    case _kProtocolEvent:
      try {
        final event = Event.fromJson(Map<String, dynamic>.from(msg[1] as Map));
        return SignalingProtocolEvent(event: event);
      } catch (_) {
        return null;
      }
    default:
      return null;
  }
}

// ---------------------------------------------------------------------------
// Execute result helpers
// ---------------------------------------------------------------------------

List<dynamic> encodeExecuteResult(String correlationId, Object? error) => [
  _kExecuteResult,
  correlationId,
  error?.toString(),
];

bool isExecuteResult(List<dynamic> msg) => msg.isNotEmpty && msg[0] == _kExecuteResult;

({String correlationId, String? error}) decodeExecuteResult(List<dynamic> msg) =>
    (correlationId: msg[1] as String, error: msg[2] as String?);

// ---------------------------------------------------------------------------
// Sub-ack helpers (hub -> subscriber, confirms port is alive)
// ---------------------------------------------------------------------------

List<dynamic> encodeSubAck() => [_kSubAck];

bool isSubAck(List<dynamic> msg) => msg.isNotEmpty && msg[0] == _kSubAck;

// ---------------------------------------------------------------------------
// StateHandshake encoder
// ---------------------------------------------------------------------------

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
