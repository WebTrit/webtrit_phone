import 'dart:async';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';

// TODO(Serdun): Maybe chane location
import 'package:webtrit_phone/models/models.dart';

/// Abstract interface for managing signaling operations and state synchronization
/// between the client and a Webtrit signaling server.
abstract class SignalingService {
  /// Emits the full handshake state from the signaling server,
  /// including lines and registration status.
  Stream<StateHandshake> get onStateHandshake;

  /// Emits real-time signaling events (incoming/outgoing calls, updates, etc.).
  Stream<Event> get onEvent;

  /// Emits a simplified handshake state: number of lines and registration status.
  Stream<HandshakeSignalingState> get onHandshakeSignalingState;

  /// Emits current connection status: connecting, connected, disconnected, failure, etc.
  Stream<CallServiceState> get onStatus;

  set completeCall(Function(String) fn);

  set getLastConnectionStatus(CallServiceState Function() fn);

  set setGetLocalConnections(Future<List<CallkeepConnection>> Function()? fn);

  set setGetLocalConnectionByCallId(Future<CallkeepConnection?> Function(String callId)? fn);

  set setForceEndLocalConnection(Future<void> Function(String callId)? fn);

  set setGetCurrentUiActiveCalls(List<CallEntry> Function()? fn);

  /// Emits active calls currently managed by the signaling client.
  void reconnectInitiated([Duration delay = const Duration(seconds: 1), bool force = false]);

  /// Emits internal cleanup events for stale or orphaned calls
  /// that exist locally but are no longer present in the signaling state.
  Stream<SignalingInternalEvent> get onStaleCallCleanup;

  /// Indicates whether the signaling client is currently connected.
  bool get isConnected;

  /// Establishes a connection to the signaling server.
  ///
  /// If [force] is true, reconnects even if already connected.
  /// If the app is inactive or there is no connectivity, the connection attempt is skipped.
  Future<void> connect({bool force = false});

  /// Disconnects the signaling client and cleans up related resources.
  Future<void> disconnect();

  /// Sends a signaling [request] to the server.
  ///
  /// If the client is not connected, this call may be ignored or throw, depending on implementation.
  Future<void> execute(Request request);

  /// Updates the application lifecycle state.
  ///
  /// When [active] is false, the signaling client will disconnect.
  /// When [active] becomes true again, it may attempt to reconnect.
  void updateAppLifecycle(bool active);

  /// Cleans up all resources, closes streams, and disconnects the client.
  ///
  /// Should be called when the service is no longer needed.
  Future<void> dispose();
}

class HandshakeSignalingState {
  final Registration registration;
  final int linesCount;

  HandshakeSignalingState({
    required this.registration,
    required this.linesCount,
  });
}

class SignalingInternalEvent {
  final String callId;
  final int? line;
  final int code;
  final String reason;

  const SignalingInternalEvent({
    required this.callId,
    required this.line,
    required this.code,
    required this.reason,
  });
}

enum SignalingControlEventType {
  hangUp,
  decline,
}

class SignalingErrorEvent {
  final dynamic error;
  final StackTrace? stackTrace;

  const SignalingErrorEvent({
    required this.error,
    this.stackTrace,
  });
}

class PeerConnectionErrorEvent {
  final String callId;
  final String reason;

  const PeerConnectionErrorEvent({
    required this.callId,
    required this.reason,
  });
}
