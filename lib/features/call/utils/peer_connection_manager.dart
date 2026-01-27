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
      ..onSignalingState = ((signalingState) => _onSignalingState(signalingState, observer, pcLogger))
      ..onConnectionState = ((signalingState) => _onConnectionState(signalingState, observer, pcLogger))
      ..onIceGatheringState = ((signalingState) => _onIceGatheringState(signalingState, observer, pcLogger))
      ..onIceConnectionState = ((signalingState) => _onIceConnectionState(signalingState, observer, pcLogger))
      ..onIceCandidate = ((iceCandidate) => _onIceCandidate(iceCandidate, observer, pcLogger))
      ..onAddStream = ((mediaStream) => _onAddStream(mediaStream, observer, pcLogger))
      ..onRemoveStream = ((mediaStream) => _onRemoveStream(mediaStream, observer, pcLogger))
      ..onAddTrack = ((mediaStream, mediaTrack) => _onAddTrack(mediaStream, mediaTrack, observer, pcLogger))
      ..onRemoveTrack = ((mediaStream, mediaTrack) => _onRemoveTrack(mediaStream, mediaTrack, observer, pcLogger))
      ..onDataChannel = ((dataChannel) => _onDataChannel(dataChannel, observer, pcLogger))
      ..onRenegotiationNeeded = (() => _onRenegotiationNeeded(peerConnection, observer, pcLogger))
      ..onTrack = ((trackEvent) => _onTrack(trackEvent, observer, pcLogger));
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

  void _initializeRtpMonitor(CallId callId, _ConnectionState state, RTCPeerConnection peerConnection) {
    try {
      state.stopRtpTrafficMonitor();

      if (monitorDelegatesFactory == null) return;

      final monitorLogger = Logger('$_logNamespace.Monitor.$callId');

      final delegates = monitorDelegatesFactory!(callId, monitorLogger);

      if (delegates.isEmpty) return;

      final monitor = RtpTrafficMonitor(
        peerConnection: peerConnection,
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

    final peerConnection = state.connection;
    if (peerConnection != null) {
      await _closePeerConnectionSafely(peerConnection, callId);
    }

    if (!state.completer.isCompleted) {
      state.completer.completeError(StateError('PeerConnection for $callId disposed before completion'));
      _logger.finer(() => 'disposePeerConnection($callId): completer completed with error');
    }
  }

  Future<void> _closePeerConnectionSafely(RTCPeerConnection peerConnection, CallId callId) async {
    try {
      await peerConnection.close();
      _logger.finer(() => 'disposePeerConnection($callId): peerConnection closed');
    } catch (e, st) {
      _logger.warning('disposePeerConnection($callId): peerConnection.close failed', e, st);
    }
  }

  void _onSignalingState(RTCSignalingState signalingState, PeerConnectionObserver observer, Logger logger) {
    logger.fine(() => 'onSignalingState state: ${signalingState.name}');
    observer.onSignalingState?.call(signalingState);
  }

  void _onConnectionState(RTCPeerConnectionState signalingState, PeerConnectionObserver observer, Logger logger) {
    logger.fine(() => 'onConnectionState state: ${signalingState.name}');
    observer.onConnectionState?.call(signalingState);
  }

  void _onIceGatheringState(RTCIceGatheringState signalingState, PeerConnectionObserver observer, Logger logger) {
    logger.fine(() => 'onIceGatheringState state: ${signalingState.name}');
    observer.onIceGatheringState?.call(signalingState);
  }

  void _onIceConnectionState(RTCIceConnectionState signalingState, PeerConnectionObserver observer, Logger logger) {
    logger.fine(() => 'onIceConnectionState state: ${signalingState.name}');
    observer.onIceConnectionState?.call(signalingState);
  }

  void _onIceCandidate(RTCIceCandidate iceCandidate, PeerConnectionObserver observer, Logger logger) {
    logger.fine(() => 'onIceCandidate candidate: $iceCandidate');
    observer.onIceCandidate?.call(iceCandidate);
  }

  void _onAddStream(MediaStream mediaStream, PeerConnectionObserver observer, Logger logger) {
    final streamData = {
      'streamId': mediaStream.id,
      'videoTracks': mediaStream
          .getVideoTracks()
          .map((t) => {'id': t.id, 'enabled': t.enabled, 'kind': t.kind, 'label': t.label})
          .toList(),
      'audioTracks': mediaStream
          .getAudioTracks()
          .map((t) => {'id': t.id, 'enabled': t.enabled, 'kind': t.kind, 'label': t.label})
          .toList(),
    };
    logger.logPretty(streamData, tag: 'onAddStream');

    observer.onAddStream?.call(mediaStream);
  }

  void _onRemoveStream(MediaStream mediaStream, PeerConnectionObserver observer, Logger logger) {
    logger.fine(() => 'onRemoveStream stream: $mediaStream');
    observer.onRemoveStream?.call(mediaStream);
  }

  void _onAddTrack(MediaStream stream, MediaStreamTrack mediaTrack, PeerConnectionObserver observer, Logger logger) {
    logger.fine(() => 'onAddTrack stream: $stream track: $mediaTrack');
    observer.onAddTrack?.call(stream, mediaTrack);
  }

  void _onRemoveTrack(MediaStream stream, MediaStreamTrack mediaTrack, PeerConnectionObserver observer, Logger logger) {
    logger.fine(() => 'onRemoveTrack stream: $stream track: $mediaTrack');
    observer.onRemoveTrack?.call(stream, mediaTrack);
  }

  void _onDataChannel(RTCDataChannel dataChannel, PeerConnectionObserver observer, Logger logger) {
    logger.fine(() => 'onDataChannel channel: $observer');
    observer.onDataChannel?.call(dataChannel);
  }

  void _onRenegotiationNeeded(RTCPeerConnection peerConnection, PeerConnectionObserver observer, Logger logger) {
    logger.fine(() => 'onRenegotiationNeeded');
    observer.onRenegotiationNeeded?.call(peerConnection);
  }

  void _onTrack(RTCTrackEvent trackEvent, PeerConnectionObserver observer, Logger logger) {
    logger.fine(() => 'onTrack $trackEvent');
    observer.onTrack?.call(trackEvent);
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
