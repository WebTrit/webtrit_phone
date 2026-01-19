import 'dart:async';

import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:logging/logging.dart';
import 'package:webtrit_phone/extensions/extensions.dart';

import 'peer_connection_factory.dart';
import 'rtp_traffic_monitor.dart';

const _logNamespace = 'PeerConnectionManager';
final _logger = Logger('$_logNamespace.Manager');

/// Alias for the call unique identifier to make signatures clearer.
typedef CallId = String;

typedef RtpMonitorDelegatesFactory = List<RtpTrafficMonitorDelegate> Function(CallId callId, Logger logger);

/// Internal state container for managing the lifecycle of a single WebRTC connection.
///
/// It combines a [Completer] (async barrier) and a direct [connection] reference
/// to handle race conditions during rapid creation and disposal.
class _ConnectionState {
  /// Async barrier for methods waiting for the connection (e.g., `retrieve`).
  final Completer<RTCPeerConnection> completer = Completer();

  /// Direct reference to the connection.
  ///
  /// Populated only when [PeerConnectionManager.complete] is called.
  /// Allows [dispose] to close the connection synchronously without waiting
  /// for the [completer] if it is pending.
  RTCPeerConnection? connection;

  /// Optional per-call video flow monitor.
  RtpTrafficMonitor? rtpTrafficMonitor;

  /// Stops the monitor
  void stopRtpTrafficMonitor() {
    rtpTrafficMonitor?.stop();
    rtpTrafficMonitor = null;
  }
}

/// Manages the lifecycle of [RTCPeerConnection] instances.
///
/// Handles async creation barriers and safe disposal to prevent race conditions.
final class PeerConnectionManager {
  PeerConnectionManager({
    this.factory = const DefaultPeerConnectionFactory(),
    this.monitorDelegatesFactory,
    Duration retrieveTimeout = const Duration(seconds: 5),
  }) : _retrieveTimeout = retrieveTimeout;

  final PeerConnectionFactory factory;
  final RtpMonitorDelegatesFactory? monitorDelegatesFactory;
  final Duration _retrieveTimeout;

  final _states = <CallId, _ConnectionState>{};

  /// Tracks active disposal futures.
  ///
  /// Acts as a "Disposal Barrier": [createPeerConnection] checks this map
  /// to ensure hardware resources are released before creating a new connection.
  final _pendingDisposals = <CallId, Future<void>>{};

  /// Reserves a slot for a call. Must be called before [retrieve].
  void add(CallId callId) {
    if (_states.containsKey(callId)) {
      _logger.finer(() => 'add($callId): state already exists');
      return;
    }
    final state = _ConnectionState();
    // Prevent unhandled future error if the completer completes with an error later.
    state.completer.future.ignore();
    _states[callId] = state;

    _logger.finer(() => 'add($callId): state created');
  }

  /// Creates and configures a new PeerConnection using the factory.
  ///
  /// **Disposal Barrier:** If a connection with [callId] is currently being disposed,
  /// this method waits for the disposal to complete before creating the new connection.
  ///
  /// Does NOT automatically complete the barrier; [complete] must be called separately.
  Future<RTCPeerConnection> createPeerConnection(CallId callId, {required PeerConnectionObserver observer}) async {
    // BARRIER: Check if this callId is currently cleaning up
    if (_pendingDisposals.containsKey(callId)) {
      _logger.info('createPeerConnection($callId): waiting for pending disposal barrier...');
      try {
        await _pendingDisposals[callId];
      } catch (e, st) {
        // Errors from the *previous* call's disposal are ignored to allow
        // the *new* call creation to proceed.
        _logger.warning('createPeerConnection($callId): pending disposal completed with error (ignored)', e, st);
      }
    }

    // Delegates creation to the factory.
    // The factory instance encapsulates the configuration (e.g. ICE servers)
    // ensuring consistency across all connections managed by this instance.
    final peerConnection = await factory.create();

    // Create a scoped logger for the PeerConnection itself
    // Structure: WebRTC.PC.<CallId>
    final pcLogger = Logger('$_logNamespace.PC.$callId');

    return peerConnection
      ..onSignalingState = ((s) => _onSignalingState(s, observer, pcLogger))
      ..onConnectionState = ((s) => _onConnectionState(s, observer, pcLogger))
      ..onIceGatheringState = ((s) => _onIceGatheringState(s, observer, pcLogger))
      ..onIceConnectionState = ((s) => _onIceConnectionState(s, observer, pcLogger))
      ..onIceCandidate = ((c) => _onIceCandidate(c, observer, pcLogger))
      ..onAddStream = ((s) => _onAddStream(s, observer, pcLogger))
      ..onRemoveStream = ((s) => _onRemoveStream(s, observer, pcLogger))
      ..onAddTrack = ((s, t) => _onAddTrack(s, t, observer, pcLogger))
      ..onRemoveTrack = ((s, t) => _onRemoveTrack(s, t, observer, pcLogger))
      ..onDataChannel = ((c) => _onDataChannel(c, observer, pcLogger))
      ..onRenegotiationNeeded = (() => _onRenegotiationNeeded(peerConnection, observer, pcLogger))
      ..onTrack = ((e) => _onTrack(e, observer, pcLogger));
  }

  /// Completes the barrier for [callId] with the created [pc].
  void complete(CallId callId, RTCPeerConnection pc) {
    final state = _states[callId];

    // If state is missing, dispose() was called while PC was being created.
    if (state == null) {
      _logger.warning('complete($callId): no state found. Closing orphan PC.');
      pc.close();
      return;
    }

    if (state.completer.isCompleted) {
      _logger.finer(() => 'complete($callId): already completed');
      return;
    }

    state.connection = pc;
    state.completer.complete(pc);

    _initializeRtpMonitor(callId, state, pc);

    _logger.finer(() => 'complete($callId): completed');
  }

  /// Completes the barrier with an error if it hasn't completed yet.
  void completeError(CallId callId, Object error, [StackTrace? st]) {
    final state = _states[callId];
    if (state == null || state.completer.isCompleted) {
      _logger.finer(() => 'completeError($callId): skipped');
      return;
    }

    // Stop monitor if it was started.
    state.stopRtpTrafficMonitor();

    state.completer.completeError(error, st);
    _logger.finer(() => 'completeError($callId): completed with error: $error');
  }

  /// Alias for [completeError].
  void conditionalCompleteError(CallId callId, Object error, [StackTrace? st]) {
    completeError(callId, error, st);
  }

  /// Retrieves the PeerConnection. Waits if it is being created.
  Future<RTCPeerConnection?> retrieve(CallId callId, {bool allowWaiting = true}) async {
    final state = _states[callId];
    if (state == null) {
      _logger.finer(() => 'retrieve($callId): no state');
      return null;
    }

    if (!state.completer.isCompleted && !allowWaiting) {
      _logger.finer(() => 'retrieve($callId): not completed and allowWaiting=false');
      return null;
    }

    try {
      return await state.completer.future.timeout(
        _retrieveTimeout,
        onTimeout: () => throw TimeoutException('retrieve($callId) timed out after $_retrieveTimeout'),
      );
    } catch (e, st) {
      _logger.finer(() => 'retrieve($callId): failed: $e', e, st);
      rethrow;
    }
  }

  /// Disposes the connection for [callId].
  ///
  /// This method is async, but it removes the state synchronously to prevent usage.
  /// It returns a Future that completes when the underlying PeerConnection is actually closed.
  Future<void> disposePeerConnection(CallId callId) async {
    final state = _states.remove(callId);
    if (state == null) return;

    // Create the disposal task
    final disposalFuture = _performDispose(state, callId);

    // Register the task in the barrier
    _pendingDisposals[callId] = disposalFuture;

    // Ensure cleanup of the barrier map when done
    disposalFuture.whenComplete(() {
      _pendingDisposals.remove(callId);
    });

    // Wait for the disposal to actually finish
    await disposalFuture;
  }

  /// Disposes all managed connections safely with a timeout.
  ///
  /// Waits for all connections to close, but guarantees return after [timeout]
  /// to prevent blocking the application (e.g., if the native WebRTC layer hangs).
  Future<void> dispose() async {
    final ids = _states.keys.toList();

    // Combine currently pending disposals and new disposal tasks into one list
    final allFutures = <Future<void>>[..._pendingDisposals.values, ...ids.map((id) => disposePeerConnection(id))];

    if (allFutures.isEmpty) {
      _logger.finer('dispose(): nothing to dispose');
      return;
    }

    try {
      _logger.finer('dispose(): waiting for ${allFutures.length} connections to close...');

      // Wait for all with a timeout to prevent deadlocks on Bloc close
      await Future.wait(allFutures).timeout(const Duration(seconds: 2));

      _logger.finer('dispose(): done gracefully');
    } catch (e) {
      // Handles TimeoutException or other errors during disposal
      _logger.warning('dispose(): finish forced (timeout or error)', e);
    }
  }

  void _initializeRtpMonitor(CallId callId, _ConnectionState state, RTCPeerConnection pc) {
    try {
      state.stopRtpTrafficMonitor();

      if (monitorDelegatesFactory == null) return;

      final monitorLogger = Logger('$_logNamespace.Monitor.$callId');

      final delegates = monitorDelegatesFactory!(callId, monitorLogger);

      if (delegates.isEmpty) return;

      final monitor = RtpTrafficMonitor(
        peerConnection: pc,
        delegates: delegates,
        checkInterval: const Duration(seconds: 2),
      );

      state.rtpTrafficMonitor = monitor;
      monitor.start();

      _logger.finer(() => 'RtpTrafficMonitor started for $callId');
    } catch (e, st) {
      _logger.warning('Failed to start RTP monitor for $callId', e, st);
    }
  }

  /// Helper method that performs the actual disposal logic.
  Future<void> _performDispose(_ConnectionState state, CallId callId) async {
    state.stopRtpTrafficMonitor();

    final pc = state.connection;
    if (pc != null) {
      await _closePeerConnectionSafely(pc, callId);
    }

    if (!state.completer.isCompleted) {
      state.completer.completeError(StateError('PeerConnection for $callId disposed before completion'));
      _logger.finer(() => 'disposePeerConnection($callId): completer completed with error');
    }
  }

  Future<void> _closePeerConnectionSafely(RTCPeerConnection pc, CallId callId) async {
    try {
      await pc.close();
      _logger.finer(() => 'disposePeerConnection($callId): pc closed');
    } catch (e, st) {
      _logger.warning('disposePeerConnection($callId): pc.close failed', e, st);
    }
  }

  void _onSignalingState(RTCSignalingState s, PeerConnectionObserver o, Logger l) {
    l.fine(() => 'onSignalingState state: ${s.name}');
    o.onSignalingState?.call(s);
  }

  void _onConnectionState(RTCPeerConnectionState s, PeerConnectionObserver o, Logger l) {
    l.fine(() => 'onConnectionState state: ${s.name}');
    o.onConnectionState?.call(s);
  }

  void _onIceGatheringState(RTCIceGatheringState s, PeerConnectionObserver o, Logger l) {
    l.fine(() => 'onIceGatheringState state: ${s.name}');
    o.onIceGatheringState?.call(s);
  }

  void _onIceConnectionState(RTCIceConnectionState s, PeerConnectionObserver o, Logger l) {
    l.fine(() => 'onIceConnectionState state: ${s.name}');
    o.onIceConnectionState?.call(s);
  }

  void _onIceCandidate(RTCIceCandidate c, PeerConnectionObserver o, Logger l) {
    l.fine(() => 'onIceCandidate candidate: ${c.toString()}');
    o.onIceCandidate?.call(c);
  }

  void _onAddStream(MediaStream s, PeerConnectionObserver o, Logger l) {
    final streamData = {
      'streamId': s.id,
      'videoTracks': s
          .getVideoTracks()
          .map((t) => {'id': t.id, 'enabled': t.enabled, 'kind': t.kind, 'label': t.label})
          .toList(),
      'audioTracks': s
          .getAudioTracks()
          .map((t) => {'id': t.id, 'enabled': t.enabled, 'kind': t.kind, 'label': t.label})
          .toList(),
    };

    l.logPretty('onAddStream', streamData);

    o.onAddStream?.call(s);
  }

  void _onRemoveStream(MediaStream s, PeerConnectionObserver o, Logger l) {
    l.fine(() => 'onRemoveStream stream: ${s.toString()}');
    o.onRemoveStream?.call(s);
  }

  void _onAddTrack(MediaStream s, MediaStreamTrack t, PeerConnectionObserver o, Logger l) {
    l.fine(() => 'onAddTrack stream: ${s.toString()} track: ${t.toString()}');
    o.onAddTrack?.call(s, t);
  }

  void _onRemoveTrack(MediaStream s, MediaStreamTrack t, PeerConnectionObserver o, Logger l) {
    l.fine(() => 'onRemoveTrack stream: ${s.toString()} track: ${t.toString()}');
    o.onRemoveTrack?.call(s, t);
  }

  void _onDataChannel(RTCDataChannel c, PeerConnectionObserver o, Logger l) {
    l.fine(() => 'onDataChannel channel: $c');
    o.onDataChannel?.call(c);
  }

  void _onRenegotiationNeeded(RTCPeerConnection pc, PeerConnectionObserver o, Logger l) {
    l.fine(() => 'onRenegotiationNeeded');
    o.onRenegotiationNeeded?.call(pc);
  }

  void _onTrack(RTCTrackEvent e, PeerConnectionObserver o, Logger l) {
    l.fine(() => 'onTrack ${e.toString()}');
    o.onTrack?.call(e);
  }
}

/// Callbacks to handle RTCPeerConnection events.
class PeerConnectionObserver {
  const PeerConnectionObserver({
    this.onSignalingState,
    this.onConnectionState,
    this.onIceGatheringState,
    this.onIceConnectionState,
    this.onIceCandidate,
    this.onAddStream,
    this.onRemoveStream,
    this.onAddTrack,
    this.onRemoveTrack,
    this.onDataChannel,
    this.onRenegotiationNeeded,
    this.onTrack,
  });

  final void Function(RTCSignalingState state)? onSignalingState;
  final void Function(RTCPeerConnectionState state)? onConnectionState;
  final void Function(RTCIceGatheringState state)? onIceGatheringState;
  final void Function(RTCIceConnectionState state)? onIceConnectionState;
  final void Function(RTCIceCandidate candidate)? onIceCandidate;
  final void Function(MediaStream stream)? onAddStream;
  final void Function(MediaStream stream)? onRemoveStream;
  final void Function(MediaStream stream, MediaStreamTrack track)? onAddTrack;
  final void Function(MediaStream stream, MediaStreamTrack track)? onRemoveTrack;
  final void Function(RTCDataChannel channel)? onDataChannel;
  final void Function(RTCPeerConnection peerConnection)? onRenegotiationNeeded;
  final void Function(RTCTrackEvent event)? onTrack;
}
