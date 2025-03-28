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
  Completer<void>? _connectCompleter;

  WebtritSignalingClient? _client;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  bool _isConnected = false;

  final List<_PendingRequest> _pendingRequests = [];

  Future<void> launch() async {
    await _connectClient();
    _monitorConnectivity();
  }

  Future<void> _connectClient() async {
    _logger.info('Connecting to signaling server...');
    if (_isConnected) return;

    _connectCompleter = Completer<void>();
    try {
      _client = await WebtritSignalingClient.connect(
        WebtritSignalingUtils.parseCoreUrlToSignalingUrl(coreUrl),
        tenantId,
        token,
        true,
        certs: _certificates,
      );
      _isConnected = true;
      if (!(_connectCompleter?.isCompleted ?? true)) {
        _connectCompleter?.complete();
      }
    } catch (e) {
      if (!(_connectCompleter?.isCompleted ?? true)) {
        _connectCompleter?.completeError(e);
      }
    }

    _client?.listen(
      onStateHandshake: _handleHandshake,
      onEvent: _handleEvent,
      onError: (error, stackTrace) => onError?.call(error, stackTrace),
      onDisconnect: _handleDisconnect,
    );

    _executePendingRequests();
  }

  void _handleHandshake(StateHandshake handshake) {
    _lines
      ..clear()
      ..addAll(handshake.lines.whereType<Line>());

    if (_lines.isEmpty) {
      return onNoActiveLines?.call();
    }

    for (final activeLine in _lines.whereType<Line>()) {
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

  Future<bool> hasNetworkConnection() {
    return Connectivity().checkConnectivity().then((result) => !result.contains(ConnectivityResult.none));
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
    if (!_isConnected) {
      _logger.warning('Not connected. Queueing request for $callId');

      final completer = Completer<void>();
      final timeoutTimer = Timer(const Duration(seconds: 10), () {
        if (!completer.isCompleted) {
          completer.completeError(TimeoutException('Request timed out for $callId'));
          _pendingRequests.removeWhere((r) => r.completer == completer);
        }
      });

      _pendingRequests.add(
        _PendingRequest(
          callId: callId,
          requestBuilder: requestBuilder,
          completer: completer,
          timeoutTimer: timeoutTimer,
        ),
      );

      return completer.future;
    }

    final lineIndex = _lines.indexWhere((line) => line.callId == callId);
    if (lineIndex == -1) return;

    final request = requestBuilder(
      lineIndex,
      callId,
      WebtritSignalingClient.generateTransactionId(),
    );

    await _client?.execute(request);
  }

  void _executePendingRequests() {
    _logger.info('Executing ${_pendingRequests.length} pending requests...');
    for (final pending in List<_PendingRequest>.from(_pendingRequests)) {
      final lineIndex = _lines.indexWhere((line) => line.callId == pending.callId);
      if (lineIndex == -1) {
        pending.completer.completeError('Line not found for callId: ${pending.callId}');
        pending.timeoutTimer.cancel();
        _pendingRequests.remove(pending);
        continue;
      }

      final request = pending.requestBuilder(
        lineIndex,
        pending.callId,
        WebtritSignalingClient.generateTransactionId(),
      );

      _client?.execute(request).then((_) {
        pending.completer.complete();
      }).catchError((e, s) {
        pending.completer.completeError(e, s);
      }).whenComplete(() {
        pending.timeoutTimer.cancel();
        _pendingRequests.remove(pending);
      });
    }
  }

  void _handleEvent(Event event) {
    _logger.info('Received event: $event');
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

  void _handleDisconnect(int? code, String? reason) {
    _logger.warning('Disconnected from signaling server: $code, $reason');
    _isConnected = false;
    onDisconnect?.call(code, reason);
  }

  Future<void> dispose() async {
    if (_connectCompleter != null && !_connectCompleter!.isCompleted) {
      try {
        await _connectCompleter!.future.timeout(const Duration(seconds: 5));
      } catch (e, stack) {
        _logger.warning('Dispose timeout waiting for connectCompleter', e, stack);
      }
    }

    await _client?.disconnect();
    await _connectivitySubscription?.cancel();
    _isConnected = false;
    _pendingRequests.clear();
  }
}

class _PendingRequest {
  final String callId;
  final Request Function(int line, String callId, String tx) requestBuilder;
  final Completer<void> completer;
  final Timer timeoutTimer;

  _PendingRequest({
    required this.callId,
    required this.requestBuilder,
    required this.completer,
    required this.timeoutTimer,
  });
}
