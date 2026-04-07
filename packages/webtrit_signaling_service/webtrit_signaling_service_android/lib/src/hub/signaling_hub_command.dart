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
  static SignalingHubCommand? decode(Object? wire) {
    if (wire is! List || wire.isEmpty) return null;
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
      default:
        return null;
    }
  }
}

const _tagSubscribe = 'sub';
const _tagUnsubscribe = 'unsub';
const _tagExecute = 'exec';

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
