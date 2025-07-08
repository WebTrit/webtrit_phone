import 'dart:async';

import 'package:logging/logging.dart';

import 'package:ssl_certificates/ssl_certificates.dart';
import 'package:webtrit_callkeep/webtrit_callkeep.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/services/services.dart';

import '../models/models.dart';

final _logger = Logger('SignalingForegroundIsolateManager');

class SignalingForegroundIsolateManager implements CallkeepBackgroundServiceDelegate {
  SignalingForegroundIsolateManager({
    required CallLogsRepository callLogsRepository,
    required BackgroundSignalingService callkeep,
    required SecureStorage storage,
    required TrustedCertificates certificates,
  })  : _callLogsRepository = callLogsRepository,
        _callkeep = callkeep {
    _initSignalingService(storage, certificates);
    _callkeep.setBackgroundServiceDelegate(this);
    _subscribeToSignaling();
  }

  final CallLogsRepository _callLogsRepository;
  final BackgroundSignalingService _callkeep;
  late final RegularSignalingService _signalingService;

  StreamSubscription<Event>? _eventSub;
  StreamSubscription<CallServiceState>? _statusSub;

  void _initSignalingService(SecureStorage storage, TrustedCertificates certificates) {
    _signalingService = RegularSignalingService(
      coreUrl: storage.readCoreUrl() ?? '',
      tenantId: storage.readTenantId() ?? '',
      token: storage.readToken() ?? '',
      trustedCertificates: certificates,
      logger: Logger('SignalingService: SignalingServicePersistent'),
      force: true,
    );
  }

  void attachSignalingCallbacksAndListeners() {
    _signalingService.provideLocalConnections = CallkeepConnections().getConnections;
    _signalingService.provideLocalConnectionByCallId = CallkeepConnections().getConnection;
  }

  void _subscribeToSignaling() {
    _eventSub = _signalingService.onEvent.listen(_handleEvent);
    _statusSub = _signalingService.onStatus.listen(_handleStatus);
  }

  Future<void> close() async {
    await _eventSub?.cancel();
    await _statusSub?.cancel();
    await _signalingService.dispose();
  }

  Future<void> sync(CallkeepServiceStatus status) async {
    _logger.info('onStart: $status');

    final mainSignalingStatus = (status.mainSignalingStatus == CallkeepSignalingStatus.connecting ||
        status.mainSignalingStatus == CallkeepSignalingStatus.connect);

    final isAppInBackground = (status.lifecycleEvent == CallkeepLifecycleEvent.onStop ||
        status.lifecycleEvent == CallkeepLifecycleEvent.onDestroy);

    if (isAppInBackground && !mainSignalingStatus) {
      await _signalingService.connect();
    } else {
      await _signalingService.dispose();
    }
  }

  void _handleEvent(Event event) {
    if (event is HangupEvent) {
      _handleHangupCall(event);
    } else if (event is UnregisteredEvent) {
      _handleUnregisteredEvent(event);
    } else if (event is IncomingCallEvent) {
      _handleIncomingCall(event);
    }
  }

  void _handleStatus(CallServiceState state) {
    if (state.signalingClientStatus == SignalingClientStatus.failure) {
      _handleSignalingError(state.lastSignalingClientConnectError ?? 'Unknown', null);
    }
    if (state.signalingClientStatus == SignalingClientStatus.disconnect) {
      _handleSignalingDisconnect(state.lastSignalingDisconnectCode, null);
    }
  }

  void _handleIncomingCall(IncomingCallEvent event) {
    try {
      _callkeep.incomingCall(
        event.callId,
        CallkeepHandle.number(event.caller),
        displayName: event.callerDisplayName,
        hasVideo: JsepValue.fromOptional(event.jsep)?.hasVideo ?? false,
      );
    } catch (e) {
      _handleExceptions(e);
    }
  }

  void _handleHangupCall(HangupEvent event) async {
    try {
      await _callkeep.endCall(event.callId);
    } catch (e) {
      _handleExceptions(e);
    }
  }

  void _handleSignalingError(error, [StackTrace? stackTrace]) async {
    _logger.warning('Signaling error: $error');
  }

  void _handleSignalingDisconnect(int? code, String? reason) async {
    _logger.warning('Signaling disconnected: $code $reason');
  }

  void _handleUnregisteredEvent(UnregisteredEvent event) async {
    try {
      await _callkeep.endCalls();
    } catch (e) {
      _handleExceptions(e);
    }
  }

  void _handleExceptions(e) {
    _logger.severe(e);
  }

  @override
  void performAnswerCall(String callId) {}

  @override
  void performEndCall(String callId) async {
    try {
      await _signalingService.execute(
        DeclineRequest(
          transaction: WebtritSignalingClient.generateTransactionId(),
          line: 0,
          callId: callId,
        ),
      );
    } catch (e) {
      _handleExceptions(e);
    }
  }

  @override
  Future<void> performReceivedCall(
    String callId,
    String number,
    DateTime createdTime,
    String? displayName,
    DateTime? acceptedTime,
    DateTime? hungUpTime, {
    bool video = false,
  }) async {
    NewCall call = (
      direction: CallDirection.incoming,
      number: number,
      video: video,
      username: displayName,
      createdTime: createdTime,
      acceptedTime: acceptedTime,
      hungUpTime: hungUpTime,
    );
    await _callLogsRepository.add(call);
  }
}
