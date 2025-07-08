import 'dart:async';

import 'package:logging/logging.dart';
import 'package:ssl_certificates/ssl_certificates.dart';
import 'package:webtrit_callkeep/webtrit_callkeep.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';

import 'package:webtrit_phone/data/data.dart';
import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/repositories.dart';
import 'package:webtrit_phone/services/services.dart';

final _logger = Logger('PushNotificationIsolateManager');

class PushNotificationIsolateManager implements CallkeepBackgroundServiceDelegate {
  PushNotificationIsolateManager({
    required CallLogsRepository callLogsRepository,
    required BackgroundPushNotificationService callkeep,
    required SecureStorage storage,
    required TrustedCertificates certificates,
  })  : _callLogsRepository = callLogsRepository,
        _callkeep = callkeep {
    _initSignalingService(storage, certificates);
    _callkeep.setBackgroundServiceDelegate(this);
    _subscribeToSignaling();
  }

  final CallLogsRepository _callLogsRepository;
  final BackgroundPushNotificationService _callkeep;
  late final SignalingService _signalingService;

  StreamSubscription<Event>? _eventSub;
  StreamSubscription<CallServiceState>? _statusSub;

  void _initSignalingService(SecureStorage storage, TrustedCertificates certificates) {
    _signalingService = RegularSignalingService(
      coreUrl: storage.readCoreUrl() ?? '',
      tenantId: storage.readTenantId() ?? '',
      token: storage.readToken() ?? '',
      logger: Logger('SignalingService: SignalingServicePushNotification'),
      trustedCertificates: certificates,
      force: true,
    );
    attachSignalingCallbacksAndListeners();
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
    _logger.info('Closing PushNotificationIsolateManager');
    await _eventSub?.cancel();
    await _statusSub?.cancel();
    await _signalingService.dispose();
  }

  Future<void> sync() async {
    _logger.info('Starting background call event service');
    await _signalingService.connect();
  }

  void _handleEvent(Event event) {
    _logger.info('Received event: ${event.runtimeType}');
    if (event is HangupEvent) {
      _handleHangupCall(event);
    } else if (event is UnregisteredEvent) {
      _handleUnregisteredEvent(event);
    }
  }

  void _handleStatus(CallServiceState state) {
    _logger.info('Received signaling status: ${state.signalingClientStatus}');
    if (state.signalingClientStatus == SignalingClientStatus.failure) {
      _handleSignalingError(state.lastSignalingClientConnectError ?? 'Unknown', null);
    }
  }

  void _handleHangupCall(HangupEvent event) async {
    _logger.info('Ending call: ${event.callId}');
    await _callkeep.endCall(event.callId);
  }

  void _handleSignalingError(error, [StackTrace? stackTrace]) async {
    _logger.severe('Signaling error: $error', error, stackTrace);
    await _callkeep.endCalls();
  }

  void _handleUnregisteredEvent(UnregisteredEvent event) async {
    _logger.info('Handling unregistered event: $event');
    await _callkeep.endCalls();
  }

  /// Do not execute the request to answer the call in this isolate.
  /// This isolate will open an activity that handles the handshake state for the incoming call,
  /// retrieves the local connection, and sends the answer request there.
  @override
  void performAnswerCall(String callId) async {
    _logger.info('Performing answer call for callId: $callId');
  }

  /// Execute the request to end the call in this isolate.
  /// And close notification.
  @override
  void performEndCall(String callId) async {
    final transaction = WebtritSignalingClient.generateTransactionId();
    final decline = DeclineRequest(transaction: transaction, line: 0, callId: callId);
    _logger.info('Performing end call for callId: $callId with transaction: $transaction');
    await _signalingService.execute(decline);
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
    try {
      _logger.info('Adding call log: $callId');
      await _callLogsRepository.add(call);
    } catch (e) {
      _logger.severe('Failed to add call log', e);
    }
    return;
  }
}
