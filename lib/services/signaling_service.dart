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

  /// Emits a simplified handshake state containing the number of lines and registration status.
  Stream<HandshakeSignalingState> get onHandshakeSignalingState;

  /// Emits current connection status: connecting, connected, disconnected, failure, etc.
  Stream<CallServiceState> get onStatus;

  /// Emits internal events to clean up stale or orphaned calls
  /// that exist locally but are no longer present in the signaling state.
  Stream<SignalingInternalEvent> get onStaleCallCleanup;

  /// Indicates whether the signaling client is currently connected to the server.
  bool get isConnected;

  /// Initiates a reconnect attempt after an optional [delay].
  /// If [force] is true, reconnects even if already connected.
  void reconnect({Duration delay = const Duration(seconds: 1), bool force = false});

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
  
  /// Sets a callback to complete/end a local call by [callId].
  set onCompleteCall(void Function(String callId) callback);

  /// Sets a callback that returns the current signaling service state.
  set getLastConnectionStatus(CallServiceState Function() callback);

  /// Sets a provider callback that returns the list of all current local callkeep connections.
  set provideLocalConnections(Future<List<CallkeepConnection>> Function()? provider);

  /// Sets a provider callback that returns a local callkeep connection by [callId].
  set provideLocalConnectionByCallId(Future<CallkeepConnection?> Function(String callId)? provider);

  /// Sets a provider callback to force end a local callkeep connection by [callId].
  set provideForceEndLocalConnection(Future<void> Function(String callId)? provider);

  /// Sets a provider callback that returns the current list of active UI calls.
  set provideCurrentUiActiveCalls(List<CallEntry> Function()? provider);
}
