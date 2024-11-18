import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logging/logging.dart';
import 'package:ssl_certificates/ssl_certificates.dart';

import 'package:webtrit_phone/utils/utils.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';

const int _kUndefinedLine = -1;

final _logger = Logger('SignalingManager');

/// The `SignalingManager` class manages signaling communication for real-time calls.
/// It handles initialization, connectivity monitoring, event handling, and sending requests.
/// This class connects to the signaling server using secure SSL certificates and provides
/// callbacks for incoming calls, hangups, disconnections, errors, and signaling events.
/// Automatic reconnection is supported based on network changes, ensuring seamless operation.
class SignalingManager {
  SignalingManager({
    required this.coreUrl,
    required this.tenantId,
    required this.token,
    this.onIncomingCallEvent,
    this.onHangupCallEvent,
    this.onUnregisteredEvent,
    this.onActiveLine,
    this.onError,
    this.onDisconnect,
    this.enableReconnect = false,
    required TrustedCertificates certificates,
  }) : _certificates = certificates;

  final TrustedCertificates _certificates;

  final bool enableReconnect;

  final String coreUrl;
  final String tenantId;
  final String token;

  final Function(IncomingCallEvent event)? onIncomingCallEvent;
  final Function(HangupEvent event)? onHangupCallEvent;
  final Function(UnregisteredEvent event)? onUnregisteredEvent;
  final Function(Object error, StackTrace? stackTrace)? onError;
  final Function(int? code, String? reason)? onDisconnect;
  final Function(int count)? onActiveLine;

  final List<Line?> _lines = [];

  WebtritSignalingClient? _client;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  bool _isConnected = false;

  // Starts the signaling service and monitors connectivity
  void launch() async {
    await _initializeSignalClient();
    _monitorConnectivity();
  }

  // Connects to the signaling serve
  Future<void> _initializeSignalClient() async {
    if (_isConnected) {
      _logger.info('Already connected. Skipping initialization.');
      return;
    }

    _client = await WebtritSignalingClient.connect(
      WebtritSignalingUtils.parseCoreUrlToSignalingUrl(coreUrl),
      tenantId,
      token,
      true,
      certs: _certificates,
    );

    _isConnected = true;

    _client?.listen(
      onStateHandshake: _signalingInitialize,
      onEvent: _handleSignalingEvent,
      onError: _handleSignalingError,
      onDisconnect: _handleSignalingDisconnect,
    );
  }

  void _monitorConnectivity() {
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
      if (enableReconnect &&
          result.isNotEmpty &&
          result.any((connectivityResult) => connectivityResult != ConnectivityResult.none)) {
        _reconnect();
      }
    });
  }

  Future<void> _reconnect() async {
    if (_isConnected) return;

    _logger.info('Reconnecting to signaling client');
    try {
      await _initializeSignalClient();
      _logger.info('Reconnected successfully');
    } catch (e) {
      _logger.severe('Reconnection failed', e);
    }
  }

  void _signalingInitialize(StateHandshake stateHandshake) {
    final activeLines = stateHandshake.lines.whereType<Line>().toList();

    onActiveLine?.call(activeLines.length);

    for (final activeLine in activeLines) {
      for (final callLog in activeLine.callLogs) {
        if (callLog is CallEventLog) {
          _handleSignalingEvent(callLog.callEvent);
        }
      }
    }
  }

  // Sends requests to decline calls.
  Future<void> declineRequest(String callId) async {
    final lineIndex = _lines.indexWhere((line) => line?.callId == callId);
    if (lineIndex == _kUndefinedLine) {
      _logger.warning('Call ID not found: $callId');
      return;
    }

    final line = _lines[lineIndex];
    final decline = DeclineRequest(
      transaction: WebtritSignalingClient.generateTransactionId(),
      line: lineIndex,
      callId: line!.callId,
    );

    await _client?.execute(decline);
  }

  void _handleSignalingEvent(Event event) {
    _logger.info('Handling event: $event');

    if (event is IncomingCallEvent) {
      onIncomingCallEvent?.call(event);
    } else if (event is HangupEvent) {
      onHangupCallEvent?.call(event);
    } else if (event is UnregisteredEvent) {
      onUnregisteredEvent?.call(event);
    } else {
      _logger.warning('Unhandled event: $event');
    }
  }

  void _handleSignalingError(error, [StackTrace? stackTrace]) {
    _logger.severe('Signaling error', error, stackTrace);
    onError?.call(error, stackTrace);
  }

  void _handleSignalingDisconnect(int? code, String? reason) {
    onDisconnect?.call(code, reason);
    _isConnected = false;
  }

  //  Cleans up resources and disconnects the client.
  Future<void> close() async {
    _logger.info('Closing service');
    _connectivitySubscription?.cancel();
    _isConnected = false;

    try {
      await _client?.disconnect();
    } catch (e) {
      _logger.severe('Error closing service', e);
    }
  }
}
