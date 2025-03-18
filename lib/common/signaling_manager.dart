import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logging/logging.dart';
import 'package:ssl_certificates/ssl_certificates.dart';

import 'package:webtrit_phone/utils/utils.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';

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
    required TrustedCertificates certificates,
    this.onIncomingCall,
    this.onHangupCall,
    this.onUnregistered,
    this.onHandshake,
    this.onNoActiveLines,
    this.onError,
    this.onDisconnect,
    this.enableReconnect = false,
  }) : _certificates = certificates;

  final TrustedCertificates _certificates;
  final bool enableReconnect;
  final String coreUrl;
  final String tenantId;
  final String token;

  final void Function(IncomingCallEvent)? onIncomingCall;
  final void Function(HangupEvent)? onHangupCall;
  final void Function(UnregisteredEvent)? onUnregistered;
  final void Function(List<Line>)? onHandshake;
  final void Function(Object error, StackTrace? stack)? onError;
  final void Function()? onNoActiveLines;
  final void Function(int? code, String? reason)? onDisconnect;

  final List<Line> _lines = [];
  final Completer<void> _handshakeCompleter = Completer();

  WebtritSignalingClient? _client;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  bool _isConnected = false;

  Future<void> launch() async {
    await _connectClient();
    _monitorConnectivity();
  }

  Future<void> _connectClient() async {
    _logger.info('Connecting to signaling server...');
    if (_isConnected) return;

    _client = await WebtritSignalingClient.connect(
      WebtritSignalingUtils.parseCoreUrlToSignalingUrl(coreUrl),
      tenantId,
      token,
      true,
      certs: _certificates,
    );

    _isConnected = true;

    _client?.listen(
      onStateHandshake: _handleHandshake,
      onEvent: _handleEvent,
      onError: _handleError,
      onDisconnect: _handleDisconnect,
    );
  }

  void _handleHandshake(StateHandshake handshake) {
    _lines
      ..clear()
      ..addAll(handshake.lines.whereType<Line>());

    if (_lines.isEmpty) {
      return onNoActiveLines?.call();
    }

    try {
      for (final activeLine in _lines.whereType<Line>()) {
        // Retrieve the most recent call event from the core logs for the current line.
        final callEvent = activeLine.callLogs.whereType<CallEventLog>().map((log) => log.callEvent).firstOrNull;

        if (callEvent != null) {
          if (callEvent is IncomingCallEvent) {
            onIncomingCall?.call(callEvent);
            return;
          }
        } else {
          _logger.info('No call event found');
        }
      }
    } catch (e) {
      _logger.severe('Failed to handle handshake', e);
    }

    if (!_handshakeCompleter.isCompleted) _handshakeCompleter.complete();

    _logger.info('Handshake completed: $_lines');
  }

  void _monitorConnectivity() {
    _logger.info('Monitoring connectivity...');

    Timer? connectivityTimeout;
    int connectivityNoneCounter = 0;
    const int maxConnectivityNoneRepeats = 3;

    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((results) async {
      _logger.info('Connectivity changed: $results');

      connectivityTimeout?.cancel();

      if (results.any((r) => r == ConnectivityResult.none)) {
        connectivityNoneCounter++;
        _logger.warning('No internet connection detected ($connectivityNoneCounter/$maxConnectivityNoneRepeats)');

        if (connectivityNoneCounter >= maxConnectivityNoneRepeats) {
          _logger.severe('Max connectivity loss reached');
          onError?.call('Max connectivity loss reached', null);
          connectivityNoneCounter = 0;
          return;
        }

        connectivityTimeout = Timer(const Duration(seconds: 5), () {
          if (results.any((r) => r == ConnectivityResult.none)) {
            _logger.severe('Internet connection not restored within timeout');
            onError?.call('No internet connection', null);
          }
        });
      } else {
        connectivityNoneCounter = 0;

        if (enableReconnect) {
          await _reconnect();
        }
      }
    });
  }

  Future<void> _reconnect() async {
    if (_isConnected) return;

    _logger.info('Attempting to reconnect...');
    try {
      await _connectClient();
      _logger.info('Reconnected successfully');
    } catch (e, stack) {
      _logger.severe('Failed to reconnect', e, stack);
      onError?.call(e, stack);
    }
  }

  Future<void> declineCall(String callId) async =>
      _sendRequest(callId, (line, id, tx) => DeclineRequest(transaction: tx, line: line, callId: id));

  Future<void> hangupCall(String callId) async =>
      _sendRequest(callId, (line, id, tx) => HangupRequest(transaction: tx, line: line, callId: id));

  Future<void> acceptCall(String callId) async =>
      _sendRequest(callId, (line, id, tx) => AcceptRequest(transaction: tx, line: line, callId: id, jsep: {}));

  Future<void> _sendRequest(
    String callId,
    Request Function(int line, String callId, String tx) requestBuilder,
  ) async {
    final lineIndex = _lines.indexWhere((line) => line.callId == callId);
    if (lineIndex == -1) return;

    final request = requestBuilder(
      lineIndex,
      callId,
      WebtritSignalingClient.generateTransactionId(),
    );
    await _client?.execute(request);
  }

  void _handleEvent(Event event) {
    switch (event) {
      case IncomingCallEvent():
        onIncomingCall?.call(event);
        break;
      case HangupEvent _:
        onHangupCall?.call(event);
        break;
      case UnregisteredEvent():
        onUnregistered?.call(event);
        break;
    }
  }

  void _handleError(Object error, StackTrace? stack) {
    _logger.severe('Signaling error occurred', error, stack);
    onError?.call(error, stack);
  }

  void _handleDisconnect(int? code, String? reason) {
    _isConnected = false;
    onDisconnect?.call(code, reason);
  }

  Future<void> dispose() async {
    await _connectivitySubscription?.cancel();
    await _client?.disconnect();
    _isConnected = false;
  }
}
