import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logging/logging.dart';
import 'package:ssl_certificates/ssl_certificates.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';

import 'package:webtrit_phone/bootstrap.dart';
import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';

const int _kUndefinedLine = -1;

final _logger = Logger('IsolateBackgroundCallHandler');

class BackgroundCallService implements CallkeepBackgroundServiceDelegate {
  BackgroundCallService._(
    this._recentsRepository,
    this._callkeep,
    this._storage,
    this._certificates,
    this._incomingCallType,
  );

  factory BackgroundCallService() => _instance;

  static late BackgroundCallService _instance;

  final RecentsRepository _recentsRepository;
  final SecureStorage _storage;
  final TrustedCertificates _certificates;
  final CallkeepBackgroundService _callkeep;
  final IncomingCallType _incomingCallType;

  final List<Line?> _lines = [];

  WebtritSignalingClient? _client;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  bool _isConnected = false;
  bool _isConnecting = false;

  static Future<BackgroundCallService> init(IncomingCallType type) async {
    await Future.wait([
      AppPreferences.init(),
      SecureStorage.init(),
      AppCertificates.init(),
    ]);

    final callkeep = CallkeepBackgroundService();
    final repository = RecentsRepository(appDatabase: await FCMIsolateDatabase.db());

    _instance = BackgroundCallService._(
      repository,
      callkeep,
      SecureStorage(),
      AppCertificates().trustedCertificates,
      type,
    );

    callkeep.setBackgroundServiceDelegate(_instance);
    return _instance;
  }

  bool get _isPushNotificationIncomingCall => _incomingCallType == IncomingCallType.pushNotification;

  void launch() async {
    if (_isConnecting) return;

    _isConnecting = true;
    _logger.info('Launching service');

    await Future.wait([
      _callkeep.endAllBackgroundCalls(),
      _initializeSignalClient(),
    ]);

    _monitorConnectivity();
  }

  Future<void> _initializeSignalClient() async {
    if (_isConnected) {
      _logger.info('Already connected. Skipping initialization.');
      return;
    }

    final signalingUrl = _parseCoreUrlToSignalingUrl(_storage.readCoreUrl() ?? '');
    final token = _storage.readToken();
    final tenantId = _storage.readTenantId() ?? '';

    _client = await WebtritSignalingClient.connect(
      signalingUrl,
      tenantId,
      token!,
      true,
      certs: _certificates,
    );

    _isConnected = true;
    _isConnecting = false;

    _client?.listen(
      onStateHandshake: _signalingInitialize,
      onEvent: _handleSignalingEvent,
      onError: _handleSignalingError,
      onDisconnect: _handleSignalingDisconnect,
    );
  }

  void _monitorConnectivity() {
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
      if (result.isNotEmpty && result.any((connectivityResult) => connectivityResult != ConnectivityResult.none)) {
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

  void _handleSignalingError(error, [StackTrace? stackTrace]) {
    _logger.severe('Signaling error', error, stackTrace);
    _isConnected = false;
    if (_isPushNotificationIncomingCall) {
      _callkeep.stopService();
    }
  }

  void _handleSignalingDisconnect(int? code, String? reason) {
    _logger.fine('Disconnected. Code: $code, Reason: $reason');
    _isConnected = false;
    if (_isPushNotificationIncomingCall) {
      _callkeep.stopService();
    }
  }

  void _signalingInitialize(StateHandshake stateHandshake) {
    final activeLines = stateHandshake.lines.whereType<Line>().toList();
    for (final activeLine in activeLines) {
      for (final callLog in activeLine.callLogs) {
        if (callLog is CallEventLog) {
          _handleSignalingEvent(callLog.callEvent);
        }
      }
    }
  }

  void _handleSignalingEvent(Event event) {
    _logger.info('Handling event: $event');

    if (event is IncomingCallEvent) {
      _handleIncomingCall(event);
    } else if (event is HangupEvent) {
      _handleHangupCall(event);
    } else if (event is UnregisteredEvent) {
      _handleUnregisteredEvent();
    } else {
      _logger.warning('Unhandled event: $event');
    }
  }

  void _handleIncomingCall(IncomingCallEvent event) {
    final number = CallkeepHandle.number(event.caller);
    _callkeep.incomingCall(event.callId, number, displayName: event.callerDisplayName, hasVideo: false);
  }

  void _handleHangupCall(HangupEvent event) {
    _callkeep.endBackgroundCall(event.callId);
    if (_isPushNotificationIncomingCall) {
      close();
    }
  }

  void _handleUnregisteredEvent() => _callkeep.endAllBackgroundCalls();

  Uri _parseCoreUrlToSignalingUrl(String coreUrl) {
    final uri = Uri.parse(coreUrl);
    return uri.replace(scheme: uri.scheme.endsWith('s') ? 'wss' : 'ws');
  }

  Future<void> close() async {
    _logger.info('Closing service');
    _connectivitySubscription?.cancel();
    _isConnected = false;

    try {
      await _client?.disconnect();
      if (_isPushNotificationIncomingCall) {
        await _callkeep.stopService();
      }
    } catch (e) {
      _logger.severe('Error closing service', e);
    }
  }

  @override
  void performServiceEndCall(String callId) async {
    final lineIndex = _lines.indexWhere((line) => line?.callId == callId);

    // Early return if the call ID is not found
    if (lineIndex == _kUndefinedLine) {
      _logger.warning('Call ID not found: $callId');
      if (_isPushNotificationIncomingCall) {
        close();
      }
      return;
    }

    // Retrieve the line once instead of accessing it multiple times
    final line = _lines[lineIndex];
    final decline = DeclineRequest(
      transaction: WebtritSignalingClient.generateTransactionId(),
      line: lineIndex,
      callId: line!.callId,
    );

    // Execute the decline request
    await _client?.execute(decline);

    // Close if push notification incoming call type
    if (_isPushNotificationIncomingCall) {
      close();
    }
  }

  @override
  void performServiceAnswerCall(String callId) {
    if (_isPushNotificationIncomingCall) {
      close();
    }
  }

  @override
  Future<void> endCallReceived(
    String callId,
    String number,
    DateTime createdTime,
    DateTime? acceptedTime,
    DateTime? hungUpTime, {
    bool video = false,
  }) async {
    final recent = Recent(
      direction: Direction.incoming,
      number: number,
      video: video,
      createdTime: createdTime,
      acceptedTime: acceptedTime,
      hungUpTime: hungUpTime,
    );
    await _recentsRepository.add(recent);
    _logger.info('End call received: $recent');
  }
}
