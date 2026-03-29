import 'dart:async';

import 'package:logging/logging.dart';
import 'package:ssl_certificates/ssl_certificates.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';
import 'package:webtrit_signaling_service_platform_interface/webtrit_signaling_service_platform_interface.dart';

import 'constants.dart';
import 'signaling_client_factory.dart';

final _logger = Logger('SignalingModule');

/// Manages a single [WebtritSignalingClient] lifecycle and publishes typed
/// events via a broadcast stream.
///
/// Knows only the WebSocket protocol -- nothing about isolates, notifications,
/// or app lifecycle. Used directly in the main isolate on iOS.
class SignalingModule implements SignalingModuleInterface {
  SignalingModule({
    required this.coreUrl,
    required this.tenantId,
    required this.token,
    required this.trustedCertificates,
    required this.signalingClientFactory,
  });

  final String coreUrl;
  final String tenantId;
  final String token;
  final TrustedCertificates trustedCertificates;
  final SignalingClientFactory signalingClientFactory;

  final _controller = StreamController<SignalingModuleEvent>.broadcast();

  /// Events buffered since the last [connect] call. Cleared on every [connect]
  /// so that late subscribers receive only the current session's events.
  final List<SignalingModuleEvent> _sessionBuffer = [];

  WebtritSignalingClient? _client;
  bool _disposed = false;
  String? _lastConnectErrorString;

  @override
  Stream<SignalingModuleEvent> get events {
    final liveController = StreamController<SignalingModuleEvent>(sync: true);
    final liveSub = _controller.stream.listen(
      liveController.add,
      onError: liveController.addError,
      onDone: liveController.close,
    );
    liveController.onCancel = liveSub.cancel;
    for (final event in List<SignalingModuleEvent>.of(_sessionBuffer)) {
      liveController.add(event);
    }
    return liveController.stream;
  }

  @override
  bool get isConnected => _client != null;

  @override
  void connect() {
    if (_disposed) return;
    unawaited(_connectAsync());
  }

  @override
  Future<void> disconnect() async {
    final client = _client;
    if (client == null) return;
    _client = null;
    _emit(SignalingDisconnecting());
    try {
      await client.disconnect(SignalingDisconnectCode.goingAway.code);
    } catch (e, s) {
      _logger.warning('disconnect error', e, s);
    }
  }

  @override
  Future<void>? execute(Request request) {
    return _client?.execute(request);
  }

  @override
  Future<void> dispose() async {
    if (_disposed) return;
    _disposed = true;
    _sessionBuffer.clear();
    await disconnect();
    await _controller.close();
  }

  // ---------------------------------------------------------------------------
  // Internal
  // ---------------------------------------------------------------------------

  Future<void> _connectAsync() async {
    final existing = _client;
    if (existing != null) {
      _client = null;
      try {
        await existing.disconnect();
      } catch (e, s) {
        _logger.warning('_connectAsync pre-disconnect error', e, s);
      }
    }

    if (_disposed) return;

    _sessionBuffer.clear();
    _emit(SignalingConnecting());

    try {
      final url = _parseCoreUrlToSignalingUrl(coreUrl);
      final client = await signalingClientFactory(
        url: url,
        tenantId: tenantId,
        token: token,
        connectionTimeout: kSignalingClientConnectionTimeout,
        certs: trustedCertificates,
        force: true,
      );

      if (_disposed) {
        try {
          await client.disconnect(SignalingDisconnectCode.goingAway.code);
        } catch (e, s) {
          _logger.warning('_connectAsync dispose-disconnect error', e, s);
        }
        return;
      }

      client.listen(onStateHandshake: _onHandshake, onEvent: _onEvent, onError: _onError, onDisconnect: _onDisconnect);

      _client = client;
      _lastConnectErrorString = null;
      _emit(SignalingConnected());
    } catch (e, s) {
      if (_disposed) return;
      _logger.warning('_connectAsync failed', e, s);

      final errorString = e.toString();
      final isRepeated = _lastConnectErrorString == errorString;
      _lastConnectErrorString = errorString;

      _emit(
        SignalingConnectionFailed(
          error: e,
          isRepeated: isRepeated,
          recommendedReconnectDelay: kSignalingClientReconnectDelay,
        ),
      );
    }
  }

  void _onHandshake(StateHandshake handshake) {
    if (_disposed) return;
    _emit(SignalingHandshakeReceived(handshake: handshake));
  }

  void _onEvent(Event event) {
    if (_disposed) return;
    _emit(SignalingProtocolEvent(event: event));
  }

  void _onError(Object error, [StackTrace? stackTrace]) {
    if (_disposed) return;
    _logger.severe('_onError', error, stackTrace);
    _client = null;

    final errorString = error.toString();
    final isRepeated = _lastConnectErrorString == errorString;
    _lastConnectErrorString = errorString;

    _emit(
      SignalingConnectionFailed(
        error: error,
        isRepeated: isRepeated,
        recommendedReconnectDelay: kSignalingClientReconnectDelay,
      ),
    );
  }

  void _onDisconnect(int? code, String? reason) {
    if (_disposed) return;
    _client = null;

    final knownCode = SignalingDisconnectCode.values.byCode(code ?? -1);
    final recommendedDelay = _reconnectDelay(knownCode);

    _logger.fine('_onDisconnect code=$code reason=$reason knownCode=$knownCode delay=$recommendedDelay');

    _emit(
      SignalingDisconnected(
        code: code,
        reason: reason,
        knownCode: knownCode,
        recommendedReconnectDelay: recommendedDelay,
      ),
    );
  }

  Uri _parseCoreUrlToSignalingUrl(String coreUrl) {
    final uri = Uri.parse(coreUrl);
    return uri.replace(scheme: uri.scheme.endsWith('s') ? 'wss' : 'ws');
  }

  Duration? _reconnectDelay(SignalingDisconnectCode code) {
    if (code == SignalingDisconnectCode.controllerForceAttachClose) return Duration.zero;
    if (code == SignalingDisconnectCode.protocolError) return null;
    return kSignalingClientReconnectDelay;
  }

  void _emit(SignalingModuleEvent event) {
    if (_controller.isClosed) return;
    _sessionBuffer.add(event);
    _controller.add(event);
  }
}
