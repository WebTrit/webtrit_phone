import 'dart:io';

import 'package:collection/collection.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/repositories/recents/recents_repository.dart';

import 'app/constants.dart';
import 'data/data.dart';

const int _kUndefinedLine = -1;

final _logger = Logger('BackgroundCallHandler');

class BackgroundCallHandler implements CallkeepAndroidServiceDelegate {
  BackgroundCallHandler(
    this._pendingCall,
    this._recentsRepository,
  );

  final RecentsRepository _recentsRepository;
  final PendingCall _pendingCall;

  final _callNotificationDelegate = CallkeepAndroidService();

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
    await _callNotificationDelegate.endAllCalls();
  }

  Future _initializeDependentResources() async {
    await PackageInfo.init();
    await SecureStorage.init();

    storage = SecureStorage();
    packageInfo = PackageInfo();
  }

  // TODO: Do single factory
  Future _initializeSignalClient() async {
    final signalingUrl = _parseCoreUrlToSignalingUrl(storage.readCoreUrl() ?? '');

    final token = storage.readToken();
    final tenantId = storage.readTenantId() ?? '';

    final httpClient = HttpClient();
    httpClient.connectionTimeout = kSignalingClientConnectionTimeout;

    final signalingClient = await WebtritSignalingClient.connect(
      signalingUrl,
      tenantId,
      token!,
      true,
    );
    client = signalingClient;
  }

  Future _setupListeners() async {
    _callNotificationDelegate.setAndroidServiceDelegate(this);
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
    if (event is IncomingCallEvent) {
      final number = CallkeepHandle.number(_pendingCall.handle);
      _callNotificationDelegate.incomingCall(event.callId, number, _pendingCall.displayName, _pendingCall.hasVideo);
    } else if (event is IceHangupEvent) {
      _callNotificationDelegate.endAllCalls();
    } else if (event is HangupEvent) {
      _callNotificationDelegate.endCall(event.callId);
    } else if (event is DecliningEvent) {
      _callNotificationDelegate.endCall(event.callId);
    } else if (event is UnregisteredEvent) {
      _callNotificationDelegate.endAllCalls();
    } else {
      _logger.warning('unhandled signaling event $event');
    }
  }

// TODO: Duplicate here and call_bloc.dart
  Uri _parseCoreUrlToSignalingUrl(String coreUrl) {
    final uri = Uri.parse(coreUrl);
    if (uri.scheme.endsWith('s')) {
      return uri.replace(scheme: 'wss');
    } else {
      return uri.replace(scheme: 'ws');
    }
  }

// TODO: Duplicate here and call_bloc.dart
  int? retrieveIdleLine(List<Line?> lines, String callId) {
    for (var line = 0; line < lines.length; line++) {
      if (lines.firstWhereOrNull((line) => line?.callId == callId) == null) {
        return line;
      }
    }
    return null;
  }

  void _declineCall(String callId) async {
    final transaction = WebtritSignalingClient.generateTransactionId();
    var line = retrieveIdleLine(_lines, callId) ?? _kUndefinedLine;

    if (line != _kUndefinedLine) {
      var uuid = _lines[line]?.callId ?? '';
      var decline = DeclineRequest(
        transaction: transaction,
        line: line,
        callId: uuid,
      );
      await client.execute(decline);
    }
    _close();
  }

  void _close() async {
    await client.disconnect();
  }

  @override
  void performServiceEndCall(String callId) {
    _declineCall(callId);
  }

  @override
  void endCallReceived(
    String callId,
    String number,
    bool video,
    DateTime createdTime,
    DateTime? acceptedTime,
    DateTime? hungUpTime,
  ) async {
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

  static bool parseString(
    String value, {
    bool defaultValue = false,
  }) {
    if (value.trim().toLowerCase() == 'true') {
      return true;
    } else if (value.trim().toLowerCase() == 'false') {
      return false;
    }
    return defaultValue;
  }
}
