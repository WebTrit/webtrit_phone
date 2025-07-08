import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

import 'package:webtrit_signaling/webtrit_signaling.dart';
import 'package:ssl_certificates/ssl_certificates.dart';
import 'package:webtrit_callkeep/webtrit_callkeep.dart';

import 'package:webtrit_phone/app/constants.dart';
import 'package:webtrit_phone/app/notifications/models/notification.dart';

// TODO(Serdun): Maybe chane location
import 'package:webtrit_phone/features/call/models/models.dart';
import 'package:webtrit_phone/utils/utils.dart';
import 'package:webtrit_phone/models/models.dart';

import 'signaling_service.dart';

class RegularSignalingService implements SignalingService {
  RegularSignalingService({
    required this.coreUrl,
    required this.tenantId,
    required this.token,
    required this.force,
    required this.trustedCertificates,
    required this.logger,
    this.reconnectDelay = const Duration(seconds: 10),
    this.fastReconnectDelay = const Duration(seconds: 1),
    this.connectionTimeout = const Duration(seconds: 30),
    SignalingClientFactory signalingClientFactory = defaultSignalingClientFactory,
  }) {
    logger.info('SignalingService initialized with coreUrl: $coreUrl, tenantId: $tenantId');
    _signalingClientFactory = signalingClientFactory;
    _initialize();
  }

  final String coreUrl;
  final String tenantId;
  final String token;
  final bool force;
  final Logger logger;
  final TrustedCertificates trustedCertificates;

  final Duration reconnectDelay;
  final Duration fastReconnectDelay;
  final Duration connectionTimeout;

  bool _hasConnectivity = true;
  bool _appActive = true;

  bool get _canAttemptConnection => _hasConnectivity && _appActive;

  WebtritSignalingClient? _signalingClient;
  Timer? _signalingClientReconnectTimer;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  late final SignalingClientFactory _signalingClientFactory;

  final StreamController<StateHandshake> _stateHandshakeController = StreamController.broadcast();
  final StreamController<Event> _eventController = StreamController.broadcast();
  final StreamController<HandshakeSignalingState> _handshakeSignalingStateController = StreamController.broadcast();
  final StreamController<SignalingInternalEvent> _staleCallCleanupController = StreamController.broadcast();
  final StreamController<SignalingErrorEvent> _errorEventController = StreamController.broadcast();
  final StreamController<CallServiceState> _statusController = StreamController.broadcast();

  late Function(Notification) _submitNotification;
  late Function(String) _completeCall;
  late CallServiceState Function() _getLastConnectionStatus;

  Future<List<CallkeepConnection>> Function()? getLocalConnections;
  Future<CallkeepConnection?> Function(String callId)? getLocalConnectionByCallId;
  Future<void> Function(String callId)? forceEndLocalConnection;
  List<CallEntry> Function()? getCurrentUiActiveCalls;

  @override
  set onCompleteCall(void Function(String callId) callback) => _completeCall = callback;

  @override
  set getLastConnectionStatus(CallServiceState Function() callback) => _getLastConnectionStatus = callback;

  @override
  set provideLocalConnections(Future<List<CallkeepConnection>> Function()? provider) => getLocalConnections = provider;

  @override
  set provideLocalConnectionByCallId(Future<CallkeepConnection?> Function(String callId)? provider) =>
      getLocalConnectionByCallId = provider;

  @override
  set provideForceEndLocalConnection(Future<void> Function(String callId)? provider) =>
      forceEndLocalConnection = provider;

  @override
  set provideCurrentUiActiveCalls(List<CallEntry> Function()? provider) => getCurrentUiActiveCalls = provider;

  @visibleForTesting
  set testHasConnectivity(bool value) => _hasConnectivity = value;

  @visibleForTesting
  set testSignalingClient(WebtritSignalingClient? client) => _signalingClient = client;

  @override
  Stream<StateHandshake> get onStateHandshake => _stateHandshakeController.stream;

  @override
  Stream<Event> get onEvent => _eventController.stream;

  @override
  Stream<HandshakeSignalingState> get onHandshakeSignalingState => _handshakeSignalingStateController.stream;

  @override
  Stream<CallServiceState> get onStatus => _statusController.stream;

  @override
  Stream<SignalingInternalEvent> get onStaleCallCleanup => _staleCallCleanupController.stream;

  @override
  bool get isConnected => _signalingClient != null && _hasConnectivity;

  List<CallEntry> _callCurrentUiActiveCallsOrEmpty() {
    if (getCurrentUiActiveCalls == null) {
      logger.warning('[SignalingService] getCurrentUiActiveCalls not set, returning [].');
      return [];
    }
    return getCurrentUiActiveCalls!();
  }

  Future<List<CallkeepConnection>> _callGetLocalConnectionsOrEmpty() {
    if (getLocalConnections == null) {
      logger.warning('[SignalingService] getLocalConnections not set, returning [].');
      return Future.value([]);
    }
    return getLocalConnections!();
  }

  Future<CallkeepConnection?> _callGetLocalConnectionByCallIdOrNull(String callId) {
    if (getLocalConnectionByCallId == null) {
      logger.warning('[SignalingService] getLocalConnectionByCallId not set for callId=$callId, returning null.');
      return Future.value(null);
    }
    return getLocalConnectionByCallId!(callId);
  }

  Future<void> _callForceEndLocalConnectionOrEmpty(String callId) {
    if (forceEndLocalConnection == null) {
      logger.warning('[SignalingService] forceEndLocalConnection not set for callId=$callId, skipping.');
      return Future.value();
    }
    return forceEndLocalConnection!(callId);
  }

  // TODO(Serdun): Store status to first subscription
  void _initialize() async {
    _hasConnectivity = (await Connectivity().checkConnectivity()).first != ConnectivityResult.none;
    _statusController.add(_getLastConnectionStatus().copyWith(
      networkStatus: _hasConnectivity ? NetworkStatus.available : NetworkStatus.none,
    ));
  }

  @override
  void updateAppLifecycle(bool active) {
    _appActive = active;
    if (active) {
      reconnect(delay: fastReconnectDelay);
    } else if (!active && isConnected) {
      disconnect();
    }
  }

  @override
  Future<void> connect({bool force = false}) async {
    logger.info('Attempting to connect to signaling server: $coreUrl');

    _signalingClientReconnectTimer?.cancel();

    if (!_canAttemptConnection) {
      logger.info('Connect skipped (no connectivity or inactive app).');
      return;
    }

    _statusController.add(_getLastConnectionStatus().copyWith(
      signalingClientStatus: SignalingClientStatus.connecting,
    ));

    final signalingUrl = WebtritSignalingUtils.parseCoreUrlToSignalingUrl(coreUrl);

    try {
      await _signalingClient?.disconnect();

      _signalingClient = await _signalingClientFactory(
        url: signalingUrl,
        tenantId: tenantId,
        token: token,
        connectionTimeout: connectionTimeout,
        certs: trustedCertificates,
        force: force,
      );

      _signalingClient!.listen(
        onStateHandshake: _onSignalingStateHandshake,
        onEvent: _onSignalingEvent,
        onError: _onError,
        onDisconnect: _onDisconnect,
      );

      _statusController.add(_getLastConnectionStatus().copyWith(
        signalingClientStatus: SignalingClientStatus.connect,
      ));
      logger.info('Connected successfully.');
    } catch (e, s) {
      logger.warning('Connection failed: $e', e, s);
      final repeated = _getLastConnectionStatus().lastSignalingClientConnectError == e;
      if (repeated == false) _submitNotification(const SignalingConnectFailedNotification());

      _statusController.add(_getLastConnectionStatus().copyWith(
        signalingClientStatus: SignalingClientStatus.failure,
        lastSignalingClientConnectError: e,
      ));
      reconnect();
    }

    _connectivitySubscription ??= Connectivity().onConnectivityChanged.listen(_onConnectivityChanged);
  }

  @override
  Future<void> disconnect() async {
    if (_signalingClient == null) {
      return;
    }

    logger.info('Disconnecting from signaling server...');
    _statusController.add(_getLastConnectionStatus().copyWith(
      signalingClientStatus: SignalingClientStatus.disconnecting,
    ));
    try {
      await _signalingClient?.disconnect();
      _statusController.add(_getLastConnectionStatus().copyWith(
        signalingClientStatus: SignalingClientStatus.disconnect,
        registration: const Registration(status: RegistrationStatus.unregistered),
      ));
      logger.info('Disconnected successfully.');
    } catch (e) {
      logger.severe('Failed to disconnect: $e');
      _statusController.add(_getLastConnectionStatus().copyWith(
        signalingClientStatus: SignalingClientStatus.failure,
        lastSignalingClientConnectError: e,
      ));
    } finally {
      await _connectivitySubscription?.cancel();
      _signalingClientReconnectTimer?.cancel();
      _signalingClient = null;
      _connectivitySubscription = null;
      _signalingClientReconnectTimer = null;
    }
  }

  @override
  Future<void> execute(Request request) async {
    if (_signalingClient != null) {
      logger.info('Signaling request: $request _signalingClient: $_signalingClient');
      await _signalingClient?.execute(request);
    } else {
      logger.warning('Signaling client is not connected. Cannot execute request: $request');
    }
  }

  void _onSignalingEvent(Event event) {
    logger.fine('Received signaling event: $event _signalingClient: $_signalingClient');
    _eventController.add(event);
  }

  void _onDisconnect(int? rawCode, String? reason) {
    logger.info('__onSignalingClientEventDisconnected: code: $rawCode, reason: $reason');
    final disconnectCode = SignalingDisconnectCode.values.byCode(rawCode ?? -1);
    final repeated = disconnectCode.code == _getLastConnectionStatus().lastSignalingDisconnectCode;
    const registration = Registration(status: RegistrationStatus.registering);

    _statusController.add(_getLastConnectionStatus().copyWith(
      signalingClientStatus: SignalingClientStatus.disconnect,
      lastSignalingDisconnectCode: disconnectCode.code,
      registration: registration,
    ));

    Notification? notificationToShow;
    bool shouldReconnect = true;

    if (disconnectCode == SignalingDisconnectCode.appUnregisteredError) {
      const registration = CallServiceState(registration: Registration(status: RegistrationStatus.unregistered));
      _statusController.add(registration);
    } else if (disconnectCode == SignalingDisconnectCode.requestCallIdError) {
      _callCurrentUiActiveCallsOrEmpty().where((e) => e.wasHungUp).forEach((e) => _completeCall(e.callId));
    } else if (disconnectCode == SignalingDisconnectCode.controllerExitError) {
      logger.info('__onSignalingClientEventDisconnected: skipping expected system unregistration notification');
    } else if (disconnectCode == SignalingDisconnectCode.sessionMissedError) {
      notificationToShow = const SignalingSessionMissedNotification();
    } else if (disconnectCode.type == SignalingDisconnectCodeType.auxiliary) {
      logger.info('__onSignalingClientEventDisconnected: socket goes down');

      /// Fun facts
      /// - in case of network disconnection on android this section is evaluating faster than [_onConnectivityResultChanged].
      /// - also in case of network disconnection error code is protocolError instead of normalClosure by unknown reason
      /// so we need to handle it here as regular disconnection
      if (disconnectCode == SignalingDisconnectCode.protocolError) {
        shouldReconnect = false;
      } else {
        notificationToShow = SignalingDisconnectNotification(
          knownCode: disconnectCode,
          systemCode: rawCode,
          systemReason: reason,
        );
      }
    } else {
      notificationToShow = SignalingDisconnectNotification(
        knownCode: disconnectCode,
        systemCode: rawCode,
        systemReason: reason,
      );
    }

    _signalingClient = null;

    if (notificationToShow != null && !repeated) _submitNotification(notificationToShow);
    if (shouldReconnect) reconnect(delay: kSignalingClientReconnectDelay);
  }

  void _onError(dynamic error, StackTrace? stackTrace) {
    logger.severe('Signaling error: $error', error, stackTrace);

    _errorEventController.add(SignalingErrorEvent(
      error: error,
      stackTrace: stackTrace,
    ));
    _statusController.add(_getLastConnectionStatus().copyWith(
      signalingClientStatus: SignalingClientStatus.failure,
      lastSignalingClientConnectError: error,
    ));

    reconnect();
  }

  @override
  void reconnect({Duration delay = const Duration(seconds: 1), bool force = false}) {
    logger.info('Reconnect initiated.');

    _signalingClientReconnectTimer?.cancel();
    _signalingClientReconnectTimer = Timer(delay, () {
      final signalingRemains = _signalingClient != null;

      // Guard clause to prevent reconnection when the app is in the background.
      // Coz reconnect can be triggered by another action e.g conectivity change.
      if (_appActive == false && force == false) {
        logger.info('__onSignalingClientEventConnectInitiated: skipped due to appActive: $_appActive');
        return;
      }

      // Guard clause to prevent reconnection when there is no connectivity.
      // Coz reconnect can be triggered by another action e.g app lifecycle change.
      if (_hasConnectivity == false && force == false) {
        logger.info('__onSignalingClientEventConnectInitiated: skipped due to connectionActive: $isConnected');
        return;
      }

      // Guard clause to prevent reconnection when the signaling client is already connected.
      //
      // Can be triggered by switching from wifi to mobile data.
      // In this case, the connection is recovers automatically, and signaling wasnt disposed.
      //
      // Or if app resumes from background or native call screen durning active call,
      // in this case signaling wasnt disposed
      if (signalingRemains == true && force == false) {
        logger.info('__onSignalingClientEventConnectInitiated: skipped due signalingRemains: $signalingRemains');
        return;
      }

      logger.info('Reconnecting...');
      connect(force: force);
    });
  }

  void _onConnectivityChanged(List<ConnectivityResult> results) {
    _hasConnectivity = results.first != ConnectivityResult.none;
    logger.fine('Connectivity changed: hasConnectivity=$_hasConnectivity');

    _statusController.add(_getLastConnectionStatus().copyWith(
      networkStatus: _hasConnectivity ? NetworkStatus.available : NetworkStatus.none,
    ));

    if (_hasConnectivity) {
      reconnect(delay: fastReconnectDelay);
    } else {
      reconnect();
    }
  }

  /// Synchronizes local call state with the signaling server's handshake state.
  /// Terminates or updates local calls that no longer exist remotely,
  /// ensuring consistency between signaling and local Callkeep states.
  void _onSignalingStateHandshake(StateHandshake stateHandshake) async {
    logger.info('Received signaling state handshake: $stateHandshake');

    // Notify about lines count and registration state from signaling handshake event.
    _handshakeSignalingStateController.add(
      HandshakeSignalingState(
        registration: stateHandshake.registration,
        linesCount: stateHandshake.lines.length,
      ),
    );

    // Hang up all active calls that are not associated with any line
    // or guest line, indicating that they are no longer valid.
    //
    // This is needed to drop or retain calls after reconnecting to the signaling server
    activeCallsLoop:
    for (final activeCall in _callCurrentUiActiveCallsOrEmpty()) {
      // Ignore active calls that are already associated with a line or guest line
      //
      // If you have troubles with line position mismatch replace this with
      // following code that deal with it: https://gist.github.com/digiboridev/f7f1020731e8f247b5891983433bd159
      for (final line in [...stateHandshake.lines, stateHandshake.guestLine]) {
        if (line != null && line.callId == activeCall.callId) {
          continue activeCallsLoop;
        }
      }

      // Handles an outgoing active call that has not yet started, typically initiated
      // by the `continueStartCallIntent` callback of `CallkeepDelegate`.
      //
      // TODO: Implement a dedicated flag to confirm successful execution of
      // OutgoingCallRequest, ensuring reliable outgoing active call state tracking.
      if (activeCall.direction == CallDirection.outgoing &&
          activeCall.acceptedTime == null &&
          activeCall.hungUpTime == null) {
        continue activeCallsLoop;
      }

      // Emit signaling cleanup event for a stale or orphaned call.
      // This occurs when a locally tracked call is no longer present in the signaling state,
      // indicating it was likely terminated remotely or desynchronized.
      _staleCallCleanupController.add(SignalingInternalEvent(
        callId: activeCall.callId,
        line: activeCall.line,
        code: 487,
        reason: '::Handshake::Stale or orphaned call – signaling cleanup',
      ));
    }

    final lines = [...stateHandshake.lines, stateHandshake.guestLine].whereType<Line>();
    final localConnections = await _callGetLocalConnectionsOrEmpty();

    for (final activeLine in lines) {
      // Get the first call event from the call logs, if any
      final callEvent = activeLine.callLogs.whereType<CallEventLog>().map((log) => log.callEvent).firstOrNull;

      if (callEvent != null) {
        // Obtain the corresponding Callkeep connection for the line.
        // Callkeep maintains connection states even if the app's lifecycle has ended.
        final connection = await _callGetLocalConnectionByCallIdOrNull(callEvent.callId);

        logger.info(
          '::Handshake:: Connection for call: ${callEvent.callId}, s: ${connection?.state}',
        );

        // Check if the Callkeep connection exists and its state is `stateDisconnected`.
        // Indicates that the call has been terminated by the user or system (e.g., due to connectivity issues).
        // Synchronize the signaling state with the local state for such scenarios.
        if (connection?.state == CallkeepConnectionState.stateDisconnected) {
          // Handle outgoing or accepted calls. If the event is `AcceptedEvent` or `ProceedingEvent`,
          // initiate a hang-up request to align the signaling state.

          // Handle calls that should update signaling state:
          // - Outgoing calls in Accepted/Proceeding state (requires hang-up)
          // - Incoming calls that were missed/declined (requires decline)
          if (callEvent is AcceptedEvent || callEvent is ProceedingEvent || callEvent is IncomingCallEvent) {
            _eventController.add(callEvent);
            return;
          }
        }
      }

      if (activeLine.callLogs.length == 1) {
        final singleCallLog = activeLine.callLogs.first;
        if (singleCallLog is CallEventLog && singleCallLog.callEvent is IncomingCallEvent) {
          _eventController.add(singleCallLog.callEvent as IncomingCallEvent);
        } else {
          logger.fine('Line ${activeLine.callId} has a single call log, but it is not an IncomingCallEvent.');
        }
      } else {
        logger.fine('Line ${activeLine.callId} has multiple call logs, expected only one for incoming calls.');
      }
    }

    // Synchronize the signaling state with the local state for calls.
    // If a local connection exists that is not present in the signaling state, end the call to ensure consistency between the local and signaling states.
    for (var connection in localConnections) {
      if (!lines.map((e) => e.callId).contains(connection.callId)) {
        await _callForceEndLocalConnectionOrEmpty(connection.callId);
      }
    }
  }

  bool isConnectedNow() {
    return _signalingClient != null;
  }

  @override
  Future<void> dispose() async {
    if (_signalingClient == null) {
      return;
    }

    logger.info('Disposing SignalingService...');
    await disconnect();

    await _connectivitySubscription?.cancel();
    await _statusController.close();
    await _handshakeSignalingStateController.close();
    await _stateHandshakeController.close();
    await _eventController.close();
    await _staleCallCleanupController.close();
    await _errorEventController.close();
  }
}
