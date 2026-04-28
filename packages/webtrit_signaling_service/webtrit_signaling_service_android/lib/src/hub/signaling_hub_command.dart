import 'dart:isolate';

/// Typed commands sent from a subscriber to [SignalingHub].
///
/// Instances are NOT sent directly across isolate boundaries — only
/// isolate-safe primitives, [SendPort], [List], and [Map] values can cross
/// a [SendPort]. Use [SignalingHubCommand.encode] before sending and
/// [SignalingHubCommand.decode] on the receiving side to convert between
/// the typed API and the wire payload.
sealed class SignalingHubCommand {
  const SignalingHubCommand(this.consumerId);

  /// Identifies the subscriber sending this command.
  final String consumerId;

  /// Encodes this command to an isolate-safe [List] payload for [SendPort.send].
  List<Object?> encode();

  /// Decodes an isolate-safe [List] payload back to a typed [SignalingHubCommand].
  ///
  /// Returns null when [wire] is not a recognised command payload so the hub
  /// can log and ignore unexpected messages safely.
  ///
  /// Returns null (rather than throwing) on any malformed payload — wrong tag,
  /// missing fields, or unexpected field types.
  static SignalingHubCommand? decode(Object? wire) {
    if (wire is! List || wire.isEmpty) return null;
    try {
      final tag = wire[0];
      switch (tag) {
        case _tagSubscribe:
          if (wire.length < 3) return null;
          return SignalingHubSubscribeCommand(consumerId: wire[1] as String, replyPort: wire[2] as SendPort);
        case _tagUnsubscribe:
          if (wire.length < 2) return null;
          return SignalingHubUnsubscribeCommand(consumerId: wire[1] as String);
        case _tagExecute:
          if (wire.length < 4) return null;
          return SignalingHubExecuteCommand(
            consumerId: wire[1] as String,
            correlationId: wire[2] as String,
            request: Map<String, dynamic>.from(wire[3] as Map),
          );
        case _tagConnect:
          if (wire.length < 2) return null;
          return SignalingHubConnectCommand(consumerId: wire[1] as String);
        case _tagDisconnect:
          if (wire.length < 2) return null;
          return SignalingHubDisconnectCommand(consumerId: wire[1] as String);
        case _tagPing:
          if (wire.length < 2) return null;
          return SignalingHubPingCommand(consumerId: wire[1] as String);
        default:
          return null;
      }
    } on TypeError {
      return null;
    }
  }
}

/// Wire tag placed at index 0 of the encoded [List] to identify a [SignalingHubSubscribeCommand].
const _tagSubscribe = 'sub';

/// Wire tag placed at index 0 of the encoded [List] to identify a [SignalingHubUnsubscribeCommand].
const _tagUnsubscribe = 'unsub';

/// Wire tag placed at index 0 of the encoded [List] to identify a [SignalingHubExecuteCommand].
const _tagExecute = 'exec';

/// Wire tag placed at index 0 of the encoded [List] to identify a [SignalingHubConnectCommand].
const _tagConnect = 'connect';

/// Wire tag placed at index 0 of the encoded [List] to identify a [SignalingHubDisconnectCommand].
const _tagDisconnect = 'disconnect';

/// Wire tag placed at index 0 of the encoded [List] to identify a [SignalingHubPingCommand].
const _tagPing = 'ping';

/// Registers [replyPort] as a subscriber in the hub.
///
/// The hub responds with a sub-ack followed by a session buffer replay so the
/// new subscriber receives the current connection state immediately.
class SignalingHubSubscribeCommand extends SignalingHubCommand {
  const SignalingHubSubscribeCommand({required String consumerId, required this.replyPort}) : super(consumerId);

  /// The port the hub uses to deliver events and execute results back to this
  /// subscriber.
  final SendPort replyPort;

  @override
  List<Object?> encode() => [_tagSubscribe, consumerId, replyPort];
}

/// Removes the subscriber from the hub.
///
/// The hub stops forwarding events to the subscriber's [SendPort] after
/// receiving this command.
class SignalingHubUnsubscribeCommand extends SignalingHubCommand {
  const SignalingHubUnsubscribeCommand({required String consumerId}) : super(consumerId);

  @override
  List<Object?> encode() => [_tagUnsubscribe, consumerId];
}

/// Asks the hub to execute [request] on the active WebSocket connection and
/// reply with the result identified by [correlationId].
///
/// The hub sends an execute-result message back to the subscriber's [SendPort]
/// when the request completes or fails.
class SignalingHubExecuteCommand extends SignalingHubCommand {
  const SignalingHubExecuteCommand({required String consumerId, required this.correlationId, required this.request})
    : super(consumerId);

  /// Opaque ID used to match the execute result back to the pending completer.
  final String correlationId;

  /// JSON-serialised request payload forwarded to [WebtritSignalingClient].
  final Map<String, dynamic> request;

  @override
  List<Object?> encode() => [_tagExecute, consumerId, correlationId, request];
}

/// Asks the hub to call [SignalingModule.connect] on the background WebSocket.
///
/// Sent by [SignalingHubModule.connect] so the main isolate can trigger a
/// connection attempt without owning the WebSocket directly.
class SignalingHubConnectCommand extends SignalingHubCommand {
  const SignalingHubConnectCommand({required String consumerId}) : super(consumerId);

  @override
  List<Object?> encode() => [_tagConnect, consumerId];
}

/// Asks the hub to call [SignalingModule.disconnect] on the background WebSocket.
///
/// Sent by [SignalingHubModule.disconnect] so the main isolate can close the
/// connection. The background isolate will no longer schedule an auto-reconnect
/// after this — reconnect decisions belong to [SignalingReconnectController] in
/// the main isolate.
class SignalingHubDisconnectCommand extends SignalingHubCommand {
  const SignalingHubDisconnectCommand({required String consumerId}) : super(consumerId);

  @override
  List<Object?> encode() => [_tagDisconnect, consumerId];
}

/// Hub liveness probe sent by [SignalingHubClient] on a periodic timer.
///
/// The hub responds with a pong message ([encodePong] / [isPong]). When no
/// pong arrives within [SignalingHubClient._pongTimeout] the client treats the
/// hub as dead and closes its event stream, triggering hub-death recovery in
/// [HubConnectionManager].
class SignalingHubPingCommand extends SignalingHubCommand {
  const SignalingHubPingCommand({required String consumerId}) : super(consumerId);

  @override
  List<Object?> encode() => [_tagPing, consumerId];
}
