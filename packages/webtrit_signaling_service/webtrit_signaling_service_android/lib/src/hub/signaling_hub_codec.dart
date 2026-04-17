import 'package:logging/logging.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';
import 'package:webtrit_signaling_service_platform_interface/webtrit_signaling_service_platform_interface.dart';

final _logger = Logger('SignalingHubCodec');

const _tagConnecting = 'connecting';
const _tagConnected = 'connected';
const _tagConnectionFailed = 'connection_failed';
const _tagDisconnecting = 'disconnecting';
const _tagDisconnected = 'disconnected';
const _tagHandshakeReceived = 'handshake_received';
const _tagProtocolEvent = 'protocol_event';
const _tagExecuteResult = 'execute_result';
const _tagSubAck = 'sub_ack';
const _tagPong = 'pong';

const _executeErrorTypeKey = 'type';
const _executeErrorTypeMessage = 'message';
const _executeErrorTypeWebtritSignalingError = 'webtrit_signaling_error';
const _executeErrorTypeWebtritSignalingDisconnected = 'webtrit_signaling_disconnected';
const _executeErrorTypeWebtritSignalingUnknownMessage = 'webtrit_signaling_unknown_message';
const _executeErrorTypeWebtritSignalingUnknownResponse = 'webtrit_signaling_unknown_response';
const _executeErrorTypeWebtritSignalingTransactionTimeout = 'webtrit_signaling_transaction_timeout';
const _executeErrorTypeWebtritSignalingBadState = 'webtrit_signaling_bad_state';
const _executeErrorTypeWebtritSignalingKeepaliveTransactionTimeout = 'webtrit_signaling_keepalive_transaction_timeout';
const _executeErrorTypeWebtritSignalingTransactionUnavailable = 'webtrit_signaling_transaction_unavailable';
const _executeErrorTypeWebtritSignalingTransactionTerminateByDisconnect =
    'webtrit_signaling_transaction_terminate_by_disconnect';
const _executeErrorIdKey = 'id';
const _executeErrorCodeKey = 'code';
const _executeErrorReasonKey = 'reason';
const _executeErrorMessageKey = 'message';
const _executeErrorResponseKey = 'response';
const _executeErrorTransactionIdKey = 'transaction_id';
const _executeErrorStateErrorMessageKey = 'state_error_message';
const _executeErrorCloseCodeKey = 'close_code';
const _executeErrorCloseReasonKey = 'close_reason';

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
  } catch (e, s) {
    _logger.warning('decodeHubEvent: failed to decode tag=$tag msg=$msg', e, s);
    return null;
  }
}

/// Encodes an execute result for transport from hub to subscriber.
List<dynamic> encodeExecuteResult(String correlationId, Object? error) => [
  _tagExecuteResult,
  correlationId,
  _encodeExecuteError(error),
];

bool isExecuteResult(List<dynamic> msg) => msg.isNotEmpty && msg[0] == _tagExecuteResult;

({String correlationId, Object? error}) decodeExecuteResult(List<dynamic> msg) =>
    (correlationId: msg[1] as String, error: _decodeExecuteError(msg[2]));

/// Encodes a subscribe-ack sent by the hub to confirm a new subscriber's port is live.
List<dynamic> encodeSubAck() => [_tagSubAck];

bool isSubAck(List<dynamic> msg) => msg.isNotEmpty && msg[0] == _tagSubAck;

/// Encodes a pong reply sent by the hub in response to a [SignalingHubPingCommand].
List<dynamic> encodePong() => [_tagPong];

bool isPong(List<dynamic> msg) => msg.isNotEmpty && msg[0] == _tagPong;

/// Returns true when [entry] is an encoded [SignalingHandshakeReceived] event.
///
/// Used by [SignalingHub] to evict stale handshake entries from the session
/// buffer when a terminal call event ([HangupEvent] or [MissedCallEvent])
/// arrives — avoids exposing the private tag.
bool isHubEventHandshakeReceived(List<dynamic> entry) => entry.isNotEmpty && entry[0] == _tagHandshakeReceived;

Object? _encodeExecuteError(Object? error) {
  if (error == null) return null;
  if (error is WebtritSignalingErrorException) {
    return {
      _executeErrorTypeKey: _executeErrorTypeWebtritSignalingError,
      _executeErrorIdKey: error.id,
      _executeErrorCodeKey: error.code,
      _executeErrorReasonKey: error.reason,
    };
  }
  if (error is WebtritSignalingDisconnectedException) {
    return {_executeErrorTypeKey: _executeErrorTypeWebtritSignalingDisconnected, _executeErrorIdKey: error.id};
  }
  if (error is WebtritSignalingUnknownMessageException) {
    return {
      _executeErrorTypeKey: _executeErrorTypeWebtritSignalingUnknownMessage,
      _executeErrorIdKey: error.id,
      _executeErrorMessageKey: error.message,
    };
  }
  if (error is WebtritSignalingUnknownResponseException) {
    return {
      _executeErrorTypeKey: _executeErrorTypeWebtritSignalingUnknownResponse,
      _executeErrorIdKey: error.id,
      _executeErrorResponseKey: error.response,
    };
  }
  if (error is WebtritSignalingKeepaliveTransactionTimeoutException) {
    return {
      _executeErrorTypeKey: _executeErrorTypeWebtritSignalingKeepaliveTransactionTimeout,
      _executeErrorIdKey: error.id,
      _executeErrorTransactionIdKey: error.transactionId,
    };
  }
  if (error is WebtritSignalingTransactionTimeoutException) {
    return {
      _executeErrorTypeKey: _executeErrorTypeWebtritSignalingTransactionTimeout,
      _executeErrorIdKey: error.id,
      _executeErrorTransactionIdKey: error.transactionId,
    };
  }
  if (error is WebtritSignalingBadStateException) {
    return {
      _executeErrorTypeKey: _executeErrorTypeWebtritSignalingBadState,
      _executeErrorIdKey: error.id,
      _executeErrorStateErrorMessageKey: error.error.message.toString(),
    };
  }
  if (error is WebtritSignalingTransactionUnavailableException) {
    return {
      _executeErrorTypeKey: _executeErrorTypeWebtritSignalingTransactionUnavailable,
      _executeErrorIdKey: error.id,
      _executeErrorTransactionIdKey: error.transactionId,
    };
  }
  if (error is WebtritSignalingTransactionTerminateByDisconnectException) {
    return {
      _executeErrorTypeKey: _executeErrorTypeWebtritSignalingTransactionTerminateByDisconnect,
      _executeErrorIdKey: error.id,
      _executeErrorTransactionIdKey: error.transactionId,
      _executeErrorCloseCodeKey: error.closeCode,
      _executeErrorCloseReasonKey: error.closeReason,
    };
  }
  return {_executeErrorTypeKey: _executeErrorTypeMessage, _executeErrorReasonKey: error.toString()};
}

Object? _decodeExecuteError(Object? encodedError) {
  if (encodedError == null) return null;
  if (encodedError is String) {
    return Exception(encodedError);
  }
  if (encodedError is! Map) {
    return Exception(encodedError.toString());
  }

  final map = Map<String, dynamic>.from(encodedError);
  final type = map[_executeErrorTypeKey] as String?;
  switch (type) {
    case _executeErrorTypeWebtritSignalingError:
      final id = map[_executeErrorIdKey] as int?;
      final code = map[_executeErrorCodeKey] as int?;
      final reason = map[_executeErrorReasonKey] as String?;
      if (id == null || code == null || reason == null) {
        return Exception('Malformed webtrit_signaling_error execute payload: $map');
      }
      return WebtritSignalingErrorException(id, code, reason);
    case _executeErrorTypeWebtritSignalingDisconnected:
      final id = map[_executeErrorIdKey] as int?;
      if (id == null) return Exception('Malformed webtrit_signaling_disconnected execute payload: $map');
      return WebtritSignalingDisconnectedException(id);
    case _executeErrorTypeWebtritSignalingUnknownMessage:
      final id = map[_executeErrorIdKey] as int?;
      final message = map[_executeErrorMessageKey] as Map?;
      if (id == null || message == null) {
        return Exception('Malformed webtrit_signaling_unknown_message execute payload: $map');
      }
      return WebtritSignalingUnknownMessageException(id, Map<String, dynamic>.from(message));
    case _executeErrorTypeWebtritSignalingUnknownResponse:
      final id = map[_executeErrorIdKey] as int?;
      final response = map[_executeErrorResponseKey] as Map?;
      if (id == null || response == null) {
        return Exception('Malformed webtrit_signaling_unknown_response execute payload: $map');
      }
      return WebtritSignalingUnknownResponseException(id, Map<String, dynamic>.from(response));
    case _executeErrorTypeWebtritSignalingKeepaliveTransactionTimeout:
      final id = map[_executeErrorIdKey] as int?;
      final transactionId = map[_executeErrorTransactionIdKey] as String?;
      if (id == null || transactionId == null) {
        return Exception('Malformed webtrit_signaling_keepalive_transaction_timeout execute payload: $map');
      }
      return WebtritSignalingKeepaliveTransactionTimeoutException(id, transactionId);
    case _executeErrorTypeWebtritSignalingTransactionTimeout:
      final id = map[_executeErrorIdKey] as int?;
      final transactionId = map[_executeErrorTransactionIdKey] as String?;
      if (id == null || transactionId == null) {
        return Exception('Malformed webtrit_signaling_transaction_timeout execute payload: $map');
      }
      return WebtritSignalingTransactionTimeoutException(id, transactionId);
    case _executeErrorTypeWebtritSignalingBadState:
      final id = map[_executeErrorIdKey] as int?;
      final stateErrorMessage = map[_executeErrorStateErrorMessageKey] as String?;
      if (id == null || stateErrorMessage == null) {
        return Exception('Malformed webtrit_signaling_bad_state execute payload: $map');
      }
      return WebtritSignalingBadStateException(id, StateError(stateErrorMessage));
    case _executeErrorTypeWebtritSignalingTransactionUnavailable:
      final id = map[_executeErrorIdKey] as int?;
      final transactionId = map[_executeErrorTransactionIdKey] as String?;
      if (id == null || transactionId == null) {
        return Exception('Malformed webtrit_signaling_transaction_unavailable execute payload: $map');
      }
      return WebtritSignalingTransactionUnavailableException(id, transactionId);
    case _executeErrorTypeWebtritSignalingTransactionTerminateByDisconnect:
      final id = map[_executeErrorIdKey] as int?;
      final transactionId = map[_executeErrorTransactionIdKey] as String?;
      final closeCode = map[_executeErrorCloseCodeKey] as int?;
      final closeReason = map[_executeErrorCloseReasonKey] as String?;
      if (id == null || transactionId == null) {
        return Exception('Malformed webtrit_signaling_transaction_terminate_by_disconnect execute payload: $map');
      }
      return WebtritSignalingTransactionTerminateByDisconnectException(id, transactionId, closeCode, closeReason);
    case _executeErrorTypeMessage:
      final message = map[_executeErrorReasonKey] as String?;
      return Exception(message ?? 'Unknown execute error');
    default:
      return Exception(map[_executeErrorReasonKey] as String? ?? map.toString());
  }
}

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
    'presence_infos': h.presenceInfos.map((info) => info.toJson()).toList(),
    'dialog_infos': h.dialogInfos.map((info) => info.toJson()).toList(),
  };
}
