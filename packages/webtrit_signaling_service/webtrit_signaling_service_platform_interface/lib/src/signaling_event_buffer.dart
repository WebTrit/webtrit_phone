import 'models/signaling_module_event.dart';

/// Maintains a session-scoped replay buffer for [SignalingModuleEvent] streams.
///
/// Encapsulates two rules shared across all platform implementations:
/// - [SignalingConnecting] clears the buffer (new session started).
/// - [SignalingProtocolEvent] items are never buffered -- they are transient
///   (ICE candidates, call requests/responses) and must be consumed live.
///
/// Call [onEvent] for every emitted event, then use [snapshot] to replay
/// buffered state to late subscribers.
class SignalingEventBuffer {
  final _buffer = <SignalingModuleEvent>[];

  /// Records [event] into the buffer according to the session buffer contract.
  void onEvent(SignalingModuleEvent event) {
    if (event is SignalingConnecting) _buffer.clear();
    if (event is! SignalingProtocolEvent) _buffer.add(event);
  }

  /// A snapshot of buffered events for replay to a new subscriber.
  List<SignalingModuleEvent> get snapshot => List<SignalingModuleEvent>.of(_buffer);

  /// Clears all buffered events.
  void clear() => _buffer.clear();
}
