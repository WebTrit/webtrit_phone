import 'dart:async';

import 'package:flutter/widgets.dart' hide Notification;

import 'package:logging/logging.dart';
import 'package:ssl_certificates/ssl_certificates.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/notifications/notifications.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/utils/utils.dart';

import '../bloc/call_state.dart';
import '../models/models.dart';

final _logger = Logger('SignalingModule');

/// Interface that [SignalingModule] uses to interact with the outside world.
///
/// Typed callbacks keep the module decoupled from private BLoC event classes,
/// making it possible to instantiate and test [SignalingModule] independently
/// via a [FakeSignalingModuleDelegate] without constructing a [CallBloc].
abstract interface class SignalingModuleDelegate {
  CallState get currentState;
  bool get isModuleClosed;

  void requestConnect();

  void requestDisconnect();

  void notifyDisconnected(int? code, String? reason);

  void onStateHandshake(StateHandshake stateHandshake);

  void onSignalingEvent(Event event);

  void dispatchRegistrationChange(RegistrationStatus status, {int? code, String? reason});

  void dispatchCompleteCall(String callId);

  void showNotification(Notification notification);
}

/// Owns the [WebtritSignalingClient] lifecycle and reconnect timer.
class SignalingModule {
  SignalingModule({
    required String coreUrl,
    required String tenantId,
    required String token,
    required TrustedCertificates trustedCertificates,
    required SignalingClientFactory signalingClientFactory,
    SignalingModuleDelegate? delegate,
  }) : _coreUrl = coreUrl,
       _tenantId = tenantId,
       _token = token,
       _trustedCertificates = trustedCertificates,
       _signalingClientFactory = signalingClientFactory {
    if (delegate != null) _delegate = delegate;
  }

  late SignalingModuleDelegate _delegate;
  final String _coreUrl;
  final String _tenantId;
  final String _token;
  final TrustedCertificates _trustedCertificates;
  final SignalingClientFactory _signalingClientFactory;

  WebtritSignalingClient? _client;
  Timer? _reconnectTimer;

  WebtritSignalingClient? get signalingClient => _client;

  void attachDelegate(SignalingModuleDelegate delegate) {
    _delegate = delegate;
  }

  /// Cancels any pending reconnect timer and schedules a new connect attempt
  /// after [delay].  The attempt is skipped when the app is backgrounded,
  /// connectivity is absent, or the signaling client is already connected —
  /// unless [force] is set.
  void reconnect({Duration delay = kSignalingClientFastReconnectDelay, bool force = false}) {
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(delay, () {
      final appActive = _delegate.currentState.currentAppLifecycleState == AppLifecycleState.resumed;
      final connectionActive = _delegate.currentState.callServiceState.networkStatus != NetworkStatus.none;
      final signalingRemains = _client != null;

      _logger.info(
        'SignalingModule.reconnect timer callback after $delay, '
        'isClosed: ${_delegate.isModuleClosed}, appActive: $appActive, '
        'connectionActive: $connectionActive',
      );

      if (_delegate.isModuleClosed) return;

      if (!appActive && !force) {
        _logger.info('SignalingModule.reconnect: skipped — app not active');
        return;
      }

      if (!connectionActive && !force) {
        _logger.info('SignalingModule.reconnect: skipped — no connectivity');
        return;
      }

      if (signalingRemains && !force) {
        _logger.info('SignalingModule.reconnect: skipped — client already connected');
        return;
      }

      _delegate.requestConnect();
    });
  }

  /// Cancels the reconnect timer and schedules a disconnect.
  void disconnect() {
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
    _delegate.requestDisconnect();
  }

  /// Establishes a new [WebtritSignalingClient] connection.
  ///
  /// Called from the BLoC's [_SignalingClientEvent.connectInitiated] handler.
  /// [emit] and [isEmitDone] are forwarded from the BLoC's [Emitter] so that
  /// state updates reach the BLoC stream while keeping this class free of
  /// direct Bloc/Emitter dependencies (which simplifies testing).
  Future<void> performConnect(void Function(CallState) emit, bool Function() isEmitDone) async {
    emit(
      _delegate.currentState.copyWith(
        callServiceState: _delegate.currentState.callServiceState.copyWith(
          signalingClientStatus: SignalingClientStatus.connecting,
          lastSignalingClientDisconnectError: null,
        ),
      ),
    );

    try {
      {
        final signalingClient = _client;
        if (signalingClient != null) {
          _client = null;
          await signalingClient.disconnect();
        }
      }

      if (isEmitDone()) return;

      final signalingUrl = WebtritSignalingUtils.parseCoreUrlToSignalingUrl(_coreUrl);

      final signalingClient = await _signalingClientFactory(
        url: signalingUrl,
        tenantId: _tenantId,
        token: _token,
        connectionTimeout: kSignalingClientConnectionTimeout,
        certs: _trustedCertificates,
        force: true,
      );

      if (isEmitDone()) {
        await signalingClient.disconnect(SignalingDisconnectCode.goingAway.code);
        return;
      }

      signalingClient.listen(
        onStateHandshake: _onStateHandshake,
        onEvent: _onEvent,
        onError: _onError,
        onDisconnect: _onDisconnect,
      );
      _client = signalingClient;

      emit(
        _delegate.currentState.copyWith(
          callServiceState: _delegate.currentState.callServiceState.copyWith(
            signalingClientStatus: SignalingClientStatus.connect,
            lastSignalingClientConnectError: null,
            lastSignalingDisconnectCode: null,
          ),
        ),
      );
    } on Error {
      rethrow;
    } catch (e, s) {
      if (isEmitDone()) return;
      _logger.warning('SignalingModule.performConnect', e, s);

      // toString is important to compare low level exceptions like SocketException, HttpException, TlsException etc.
      final repeated =
          _delegate.currentState.callServiceState.lastSignalingClientConnectError.toString() == e.toString();
      if (!repeated) {
        _delegate.showNotification(const SignalingConnectFailedNotification());
      }

      emit(
        _delegate.currentState.copyWith(
          callServiceState: _delegate.currentState.callServiceState.copyWith(
            signalingClientStatus: SignalingClientStatus.failure,
            lastSignalingClientConnectError: e,
          ),
        ),
      );

      reconnect(delay: kSignalingClientReconnectDelay);
    }
  }

  /// Tears down the current [WebtritSignalingClient] connection.
  ///
  /// Called from the BLoC's [_SignalingClientEvent.disconnectInitiated] handler.
  Future<void> performDisconnect(void Function(CallState) emit, bool Function() isEmitDone) async {
    emit(
      _delegate.currentState.copyWith(
        callServiceState: _delegate.currentState.callServiceState.copyWith(
          signalingClientStatus: SignalingClientStatus.disconnecting,
          lastSignalingClientConnectError: null,
        ),
      ),
    );

    try {
      final signalingClient = _client;
      if (signalingClient != null) {
        _client = null;
        await signalingClient.disconnect();
      }

      if (isEmitDone()) return;

      emit(
        _delegate.currentState.copyWith(
          callServiceState: _delegate.currentState.callServiceState.copyWith(
            signalingClientStatus: SignalingClientStatus.disconnect,
            lastSignalingClientDisconnectError: null,
            lastSignalingDisconnectCode: null,
          ),
        ),
      );
    } on Error {
      rethrow;
    } catch (e, s) {
      if (isEmitDone()) return;
      _logger.warning('SignalingModule.performDisconnect', e, s);

      emit(
        _delegate.currentState.copyWith(
          callServiceState: _delegate.currentState.callServiceState.copyWith(
            signalingClientStatus: SignalingClientStatus.failure,
            lastSignalingClientDisconnectError: e,
          ),
        ),
      );
    }
  }

  /// Processes a server-initiated disconnect (WebSocket close frame).
  ///
  /// Called from the BLoC's [_SignalingClientEvent.disconnected] handler.
  Future<void> handleDisconnected(
    int? code,
    String? reason,
    void Function(CallState) emit,
    bool Function() isEmitDone,
  ) async {
    final disconnectCode = SignalingDisconnectCode.values.byCode(code ?? -1);
    final repeated = code == _delegate.currentState.callServiceState.lastSignalingDisconnectCode;

    CallState newState = _delegate.currentState.copyWith(
      callServiceState: _delegate.currentState.callServiceState.copyWith(
        signalingClientStatus: SignalingClientStatus.disconnect,
        lastSignalingDisconnectCode: code,
      ),
    );
    Notification? notificationToShow;
    bool shouldReconnect = true;

    if (disconnectCode == SignalingDisconnectCode.appUnregisteredError) {
      _delegate.dispatchRegistrationChange(RegistrationStatus.unregistered);

      newState = _delegate.currentState.copyWith(
        callServiceState: _delegate.currentState.callServiceState.copyWith(
          signalingClientStatus: SignalingClientStatus.disconnect,
          lastSignalingDisconnectCode: code,
        ),
      );
    } else if (disconnectCode == SignalingDisconnectCode.requestCallIdError) {
      _delegate.currentState.activeCalls
          .where((e) => e.wasHungUp)
          .forEach((e) => _delegate.dispatchCompleteCall(e.callId));
    } else if (disconnectCode == SignalingDisconnectCode.controllerExitError) {
      _logger.info('handleDisconnected: skipping expected system unregistration notification');
    } else if (disconnectCode == SignalingDisconnectCode.controllerForceAttachClose) {
      // Server closed the connection because a duplicate signaling session was detected
      // (e.g. background push isolate still connected when main engine reconnects).
      // Reconnect silently: don't set lastSignalingDisconnectCode so connectIssue is never shown.
      _logger.warning(
        'handleDisconnected: signaling race detected — '
        'server force-closed duplicate session (code=$code, reason="$reason"). '
        'Reconnecting silently without showing connectIssue.',
      );
      newState = _delegate.currentState.copyWith(
        callServiceState: _delegate.currentState.callServiceState.copyWith(
          signalingClientStatus: SignalingClientStatus.disconnect,
          lastSignalingDisconnectCode: null,
        ),
      );
    } else if (disconnectCode == SignalingDisconnectCode.sessionMissedError) {
      notificationToShow = const SignalingSessionMissedNotification();
    } else if (disconnectCode.type == SignalingDisconnectCodeType.auxiliary) {
      _logger.info('handleDisconnected: socket goes down');

      /// Fun facts
      /// - in case of network disconnection on android this section is evaluating faster than [_onConnectivityResultChanged].
      /// - also in case of network disconnection error code is protocolError instead of normalClosure by unknown reason
      /// so we need to handle it here as regular disconnection
      if (disconnectCode == SignalingDisconnectCode.protocolError) {
        shouldReconnect = false;
      } else {
        notificationToShow = SignalingDisconnectNotification(
          knownCode: disconnectCode,
          systemCode: code,
          systemReason: reason,
        );
      }
    } else {
      notificationToShow = SignalingDisconnectNotification(
        knownCode: disconnectCode,
        systemCode: code,
        systemReason: reason,
      );
    }

    emit(newState);
    _client = null;
    if (notificationToShow != null && !repeated) _delegate.showNotification(notificationToShow);
    if (shouldReconnect) {
      final reconnectDelay = disconnectCode == SignalingDisconnectCode.controllerForceAttachClose
          ? kSignalingClientFastReconnectDelay
          : kSignalingClientReconnectDelay;
      reconnect(delay: reconnectDelay);
    }
  }

  /// Cancels the reconnect timer and disconnects the signaling client.
  Future<void> dispose() async {
    _reconnectTimer?.cancel();
    final client = _client;
    _client = null;
    await client?.disconnect();
  }

  void _onStateHandshake(StateHandshake stateHandshake) => _delegate.onStateHandshake(stateHandshake);

  void _onEvent(Event event) => _delegate.onSignalingEvent(event);

  void _onError(Object error, [StackTrace? stackTrace]) {
    _logger.severe('SignalingModule._onError', error, stackTrace);

    /// Important to reconnect on errors, especially on keepalive timeout and network issues.
    reconnect(force: true);
  }

  void _onDisconnect(int? code, String? reason) => _delegate.notifyDisconnected(code, reason);
}
