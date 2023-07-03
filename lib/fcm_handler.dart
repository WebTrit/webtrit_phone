import 'dart:io';

import 'package:collection/collection.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logging/logging.dart';

import 'package:webtrit_callkeep/webtrit_callkeep.dart';
import 'package:webtrit_phone/utils/utils.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';

import 'app/constants.dart';
import 'data/data.dart';

const int _kUndefinedLine = -1;

class FCMHandler implements CallkeepAndroidServiceDelegate {
  FCMHandler({
    required this.logger,
  });

  final _callNotificationDelegate = CallkeepAndroidService();
  final Logger logger;

  late SecureStorage storage;
  late PackageInfo packageInfo;
  late WebtritSignalingClient client;

  late String callId;
  late UuidValue uuid;
  late CallkeepHandle handleValue;
  late String displayName;
  late bool hasVideo;

  final List<Line?> _lines = [];

  Future execute(RemoteMessage message) async {
    final isAndroid = PlatformInfo().isAndroid;
    if (isAndroid) {
      _executeAndroidPart(message);
    }
  }

  void _executeAndroidPart(RemoteMessage message) async {
    await _initializeDependentResources();
    await _initializeIncomingParam(message.data);
    await _initializeSignalClient();
    await _setupListeners();
  }

  Future _initializeDependentResources() async {
    await PackageInfo.init();
    await SecureStorage.init();

    storage = SecureStorage();
    packageInfo = PackageInfo();
  }

  Future _initializeIncomingParam(Map<String, dynamic> data) async {
// TODO: ADD logic for handle different handler types
    callId = data[CallDataConst.callId];
    uuid = const Uuid().v5obj(Uuid.NAMESPACE_OID, callId);
    handleValue = CallkeepHandle.number(data[CallDataConst.handleValue]);
    displayName = data[CallDataConst.displayName];
    hasVideo = BoolHelper.parseString(data[CallDataConst.hasVideo]);
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
      onEvent: _signalingEvent,
      onError: (_, __) {},
      onDisconnect: (_, __) {},
    );
  }

  void _signalingEvent(Event event) {
    if (event is HangupEvent) {
      _callNotificationDelegate.hungUp(
        event.callId,
        uuid,
      );
      _close();
    }
  }

  void _signalingInitialize(StateHandshake stateHandshake) {
    _lines.clear();
    _lines.addAll(stateHandshake.lines);

    final connections = _lines.where((element) => element?.callId == callId);
    if (connections.isNotEmpty) {
      _callNotificationDelegate.incomingCall(
        callId,
        uuid,
        handleValue,
        displayName,
        hasVideo,
      );
    } else {
      _callNotificationDelegate.hungUp(
        callId,
        uuid,
      );
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
  int? retrieveIdleLine(List<Line?> lines, UuidValue current) {
    for (var line = 0; line < lines.length; line++) {
      if (lines.firstWhereOrNull((line) => line?.callId == current.uuid) == null) {
        return line;
      }
    }
    return null;
  }

  void _declineCall(UuidValue callId) async {
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
  void performServiceEndCall(UuidValue uuid) {
    _declineCall(uuid);
  }
}
