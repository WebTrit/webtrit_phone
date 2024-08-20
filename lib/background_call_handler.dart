import 'package:logging/logging.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/recents/recents_repository.dart';

import 'data/data.dart';

const int _kUndefinedLine = -1;

final _logger = Logger('BackgroundCallHandler');

class BackgroundCallHandler implements CallkeepBackgroundServiceDelegate {
  BackgroundCallHandler(
    this._pendingCall,
    this._recentsRepository,
  );

  final RecentsRepository _recentsRepository;
  final PendingCall _pendingCall;

  final _callNotificationDelegate = CallkeepBackgroundService();

  late SecureStorage storage;
  late PackageInfo packageInfo;
  late WebtritSignalingClient client;

  final List<Line?> _lines = [];

  void init() async {
    await _cleanLocalConnections();
    await _initializeDependentResources();
    await _initializeSignalClient();
    await _setupListeners();
  }

  Future _cleanLocalConnections() async {
    await _callNotificationDelegate.endAllBackgroundCalls();
  }

  Future _initializeDependentResources() async {
    await PackageInfo.init();
    await SecureStorage.init();
    await AppCertificates.init();

    storage = SecureStorage();
    packageInfo = PackageInfo();
  }

  Future<void> _initializeSignalClient() async {
    final signalingUrl = _parseCoreUrlToSignalingUrl(storage.readCoreUrl() ?? '');
    final token = storage.readToken();
    final tenantId = storage.readTenantId() ?? '';

    final certificates = AppCertificates().trustedCertificates;
    client = await WebtritSignalingClient.connect(signalingUrl, tenantId, token!, true, certs: certificates);
  }

  Future<void> _setupListeners() async {
    _callNotificationDelegate.setBackgroundServiceDelegate(this);
    client.listen(
      onStateHandshake: _signalingInitialize,
      onEvent: _onSignalingEvent,
      onError: _onSignalingError,
      onDisconnect: _onSignalingDisconnect,
    );
  }

  void _onSignalingError(error, [StackTrace? stackTrace]) {
    _logger.severe('_onErrorCallback', error, stackTrace);
  }

  void _onSignalingDisconnect(int? code, String? reason) {
    _logger.fine('_onSignalingDisconnect code: $code reason: $reason');
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

    final eventHandlers = <Type, void Function(Event)>{
      IncomingCallEvent: (e) => _handleIncomingCall(e as IncomingCallEvent),
      HangupEvent: (e) => _handleHangupCall(e as HangupEvent),
      UnregisteredEvent: (e) => _handleUnregisteredEvent(e as UnregisteredEvent),
    };

    final handler = eventHandlers[event.runtimeType];
    if (handler != null) {
      handler(event);
    } else {
      _logger.warning('unhandled signaling event $event');
    }
  }

  void _handleIncomingCall(IncomingCallEvent event) {
    final number = CallkeepHandle.number(_pendingCall.handle);
    _callNotificationDelegate.incomingCall(
      event.callId,
      number,
      displayName: _pendingCall.displayName,
      hasVideo: _pendingCall.hasVideo,
    );
  }

  void _handleHangupCall(HangupEvent event) {
    // TODO (Serdun): If the decline event is not from the other side, the connection has already been closed in the Android ConnectionService, which might trigger a warning.
    // Improve the flow to ensure this method is called only when the connection is confirmed to exist.
    _callNotificationDelegate.endBackgroundCall(event.callId);

    // The hangup event is triggered when a call is either declined or the user hangs up.
    // This allows us to close the signaling connection for the current isolate.
    _close();
  }

  void _handleUnregisteredEvent(UnregisteredEvent event) {
    _callNotificationDelegate.endAllBackgroundCalls();
    _close();
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
      await client.execute(decline);
    } else {
      _logger.warning('declineCall: callId not found $callId');
    }
  }

  Future<void> _close() async {
    _logger.info('_close signaling client');

    try {
      await client.disconnect();
    } catch (e) {
      _logger.severe('Failed to disconnect client', e);
    }
  }

  @override
  void performServiceEndCall(String callId) {
    _declineCall(callId);
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
    _logger.info('endCallReceived: $recent');
  }
}
