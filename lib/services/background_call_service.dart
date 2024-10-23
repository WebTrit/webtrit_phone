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

class BackgroundCallHandler implements CallkeepBackgroundServiceDelegate {
  static late BackgroundCallHandler _instance;

  BackgroundCallHandler._(
    this._recentsRepository,
    this._callkeepBackgroundService,
    this.storage,
    this.certificates,
  );

  static Future<BackgroundCallHandler> init() async {
    await AppPreferences.init();
    await SecureStorage.init();
    await AppCertificates.init();

    final callkeepBackgroundService = CallkeepBackgroundService();
    final repository = RecentsRepository(appDatabase: await FCMIsolateDatabase.db());

    _instance = BackgroundCallHandler._(
      repository,
      callkeepBackgroundService,
      SecureStorage(),
      AppCertificates().trustedCertificates,
    );

    callkeepBackgroundService.setBackgroundServiceDelegate(_instance);

    return _instance;
  }

  factory BackgroundCallHandler() {
    return _instance;
  }

  get isPushNotificationIncomingCall => AppPreferences().getIncomingCallType() == IncomingCallType.pushNotification;

  get isSocketIncomingCall => AppPreferences().getIncomingCallType() == IncomingCallType.socket;

  final RecentsRepository _recentsRepository;
  final SecureStorage storage;
  final TrustedCertificates certificates;
  final CallkeepBackgroundService _callkeepBackgroundService;

  final List<Line?> _lines = [];
  final Connectivity _connectivity = Connectivity();

  WebtritSignalingClient? client;

  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  Function? _onCallCompletion;
  Function? _onCallAnswer;

  set onCallCompletion(Function? value) {
    _onCallCompletion = value;
  }

  set onCallAnswer(Function? value) {
    _onCallAnswer = value;
  }

  bool _isConnected = false;
  bool _isConnecting = false;

  void launch() async {
    if (_isConnecting) return;
    _isConnecting = true;
    _logger.info('launch');
    await _callkeepBackgroundService.endAllBackgroundCalls();
    await _initializeSignalClient();

    _monitorConnectivity();
  }

  Future<void> _initializeSignalClient() async {
    _logger.info('_initializeSignalClient');

    if (_isConnected) {
      _logger.info('Client is already connected. Skipping initialization.');
      return;
    }

    final signalingUrl = _parseCoreUrlToSignalingUrl(storage.readCoreUrl() ?? '');
    final token = storage.readToken();
    final tenantId = storage.readTenantId() ?? '';

    client = await WebtritSignalingClient.connect(
      signalingUrl,
      tenantId,
      token!,
      true,
      certs: certificates,
    );

    _isConnected = true;
    _isConnecting = false;

    client?.listen(
      onStateHandshake: _signalingInitialize,
      onEvent: _onSignalingEvent,
      onError: _onSignalingError,
      onDisconnect: _onSignalingDisconnect,
    );
  }

  void _monitorConnectivity() {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> result) {
      if (result.isNotEmpty && result.any((connectivityResult) => connectivityResult != ConnectivityResult.none)) {
        _reconnect();
      }
    });
  }

  Future<void> _reconnect() async {
    if (_isConnected) {
      _logger.info('Client is already connected. Skipping reconnection.');
      return;
    }

    _logger.info('Attempting to reconnect signaling client');
    try {
      await _initializeSignalClient();
      _logger.info('Reconnected successfully');
    } catch (e) {
      _logger.severe('Failed to reconnect', e);
    }
  }

  void _onSignalingError(error, [StackTrace? stackTrace]) {
    _logger.severe('_onErrorCallback', error, stackTrace);
    _isConnected = false;
    _onCallCompletion?.call();
  }

  void _onSignalingDisconnect(int? code, String? reason) {
    _logger.fine('_onSignalingDisconnect code: $code reason: $reason');
    _onCallCompletion?.call();
    _isConnected = false;
  }

  void _signalingInitialize(StateHandshake stateHandshake) {
    _lines.clear();
    _lines.addAll(stateHandshake.lines);

    for (final activeLine in stateHandshake.lines.whereType<Line>()) {
      for (final callLog in activeLine.callLogs) {
        if (callLog is CallEventLog) {
          _onSignalingEvent(callLog.callEvent);
        }
      }
    }
  }

  void _onSignalingEvent(Event event) {
    _logger.info('_onSignalingEvent $event');

    if (event is IncomingCallEvent) {
      _handleIncomingCall(event);
    } else if (event is HangupEvent) {
      _handleHangupCall(event);
    } else if (event is UnregisteredEvent) {
      _handleUnregisteredEvent(event);
    } else {
      _logger.warning('Unhandled signaling event $event');
    }
  }

  void _handleIncomingCall(IncomingCallEvent event) {
    final number = CallkeepHandle.number(event.caller);
    _callkeepBackgroundService.incomingCall(event.callId, number,
        displayName: event.callerDisplayName, hasVideo: false);
  }

  void _handleHangupCall(HangupEvent event) {
    _callkeepBackgroundService.endBackgroundCall(event.callId);
    CallkeepBackgroundService().finishActivity();

    _onCallCompletion?.call();
  }

  void _handleUnregisteredEvent(UnregisteredEvent event) {
    _callkeepBackgroundService.endAllBackgroundCalls();
  }

  Uri _parseCoreUrlToSignalingUrl(String coreUrl) {
    final uri = Uri.parse(coreUrl);
    return uri.replace(scheme: uri.scheme.endsWith('s') ? 'wss' : 'ws');
  }

  Future<void> _declineCall(String callId) async {
    final transaction = WebtritSignalingClient.generateTransactionId();
    final line = _lines.indexWhere((line) => line?.callId == callId);

    if (line != _kUndefinedLine) {
      final decline = DeclineRequest(
        transaction: transaction,
        line: line,
        callId: _lines[line]!.callId,
      );
      await client?.execute(decline);
    } else {
      _logger.warning('declineCall: callId not found $callId');
    }
  }

  Future<void> close() async {
    _logger.info('_close signaling client');
    _connectivitySubscription?.cancel();
    _isConnected = false;
    try {
      await client?.disconnect();
    } catch (e) {
      _logger.severe('Failed to disconnect client', e);
    }
  }

  @override
  void performServiceEndCall(String callId) => _declineCall(callId);

  @override
  void performServiceAnswerCall(String callId) => _onCallAnswer?.call();

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
    _logger.info('endCallReceived: $recent');
  }
}
