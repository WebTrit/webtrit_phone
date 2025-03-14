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
    this.onStateHandshake,
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
  final Function(List<Line> lines)? onStateHandshake;

  final List<Line?> _lines = [];

  final Completer<void> _stateHandshakeCompleter = Completer<void>();

  WebtritSignalingClient? _client;
  bool _isConnected = false;

  // Starts the signaling service and monitors connectivity
  void launch() async {
    return _initializeSignalClient();
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
      onStateHandshake: _handleStateHandshake,
      onEvent: handleSignalingEvent,
      onError: _handleSignalingError,
      onDisconnect: _handleSignalingDisconnect,
    );
  }

  void _handleStateHandshake(StateHandshake stateHandshake) async {
    final activeLines = stateHandshake.lines.whereType<Line>().toList();

    _lines
      ..clear()
      ..addAll(activeLines);

    onStateHandshake?.call(activeLines);
    _logger.info('State handshake: $stateHandshake');

    if (!_stateHandshakeCompleter.isCompleted) {
      _stateHandshakeCompleter.complete();
    }
  }

  // Sends requests to decline calls.

  Future<void> declineRequest(String callId) {
    _logger.info('declineRequest Declining call: $callId line: $_lines is connected: $_isConnected client: $_client');
    return _handleRequest(
      callId,
      (lineIndex, callId, transaction) => DeclineRequest(
        transaction: transaction,
        line: lineIndex,
        callId: callId,
      ),
    );
  }

  Future<void> hangUpRequest(String callId) async {
    await _handleRequest(
      callId,
      (lineIndex, callId, transaction) => HangupRequest(
        transaction: transaction,
        line: lineIndex,
        callId: callId,
      ),
    );
  }

  Future<void> _handleRequest(
    String callId,
    dynamic Function(int lineIndex, String callId, String transaction) requestConstructor, {
    Duration timeout = const Duration(seconds: 5),
  }) async {
    try {
      if (!_stateHandshakeCompleter.isCompleted) {
        await _stateHandshakeCompleter.future.timeout(
          timeout,
          onTimeout: () {
            throw TimeoutException('Handshake initialization timeout after ${timeout.inSeconds}s');
          },
        );
      }

      final lineIndex = _lines.indexWhere((line) => line?.callId == callId);
      if (lineIndex == _kUndefinedLine) {
        _logger.warning('Call ID not found: $callId');
        return;
      }

      final line = _lines[lineIndex]!;
      final transactionId = WebtritSignalingClient.generateTransactionId();

      final request = requestConstructor(lineIndex, line.callId, transactionId);
      await _client?.execute(request);
    } on TimeoutException catch (e) {
      _logger.severe('Timeout during request handling: $e');
      onError?.call(e, null);
    } catch (error, stackTrace) {
      _logger.severe('Unexpected error in request handling', error, stackTrace);
      onError?.call(error, stackTrace);
    }
  }

  void handleSignalingEvent(Event event) {
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

    return _client?.disconnect();
  }
}
