import 'dart:isolate';

/// Commands sent from a subscriber isolate to [SignalingHub].
///
/// All inter-isolate communication from subscriber to hub goes through one of
/// these three commands. Using a sealed class instead of raw
/// [Map<dynamic, dynamic>] makes the protocol explicit and exhaustively checked
/// by the compiler.
sealed class SignalingHubCommand {
  const SignalingHubCommand(this.consumerId);

  /// Identifies the subscriber sending this command.
  final String consumerId;
}

/// Registers [replyPort] as a subscriber in the hub.
///
/// The hub responds with a sub-ack followed by a session buffer replay so the
/// new subscriber receives the current connection state immediately.
class SignalingHubSubscribeCommand extends SignalingHubCommand {
  const SignalingHubSubscribeCommand({required String consumerId, required this.replyPort}) : super(consumerId);

  /// The port the hub uses to deliver events and execute results back to this
  /// subscriber.
  final SendPort replyPort;
}

/// Removes the subscriber from the hub.
///
/// The hub stops forwarding events to the subscriber's [SendPort] after
/// receiving this command.
class SignalingHubUnsubscribeCommand extends SignalingHubCommand {
  const SignalingHubUnsubscribeCommand({required String consumerId}) : super(consumerId);
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
}
