import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:webtrit_signaling/webtrit_signaling.dart';
import 'package:webtrit_signaling_service_platform_interface/webtrit_signaling_service_platform_interface.dart';

import 'package:webtrit_signaling_service/webtrit_signaling_service.dart';

// ---------------------------------------------------------------------------
// Fake platform implementation
// ---------------------------------------------------------------------------

class _FakePlatform extends Fake implements SignalingServicePlatform {
  final _eventsController = StreamController<SignalingModuleEvent>.broadcast();

  final List<SignalingServiceConfig> startedConfigs = [];
  final List<SignalingServiceMode> startedModes = [];
  int attachCount = 0;
  final List<Request> executedRequests = [];
  final List<SignalingServiceMode> updatedModes = [];
  final List<Function> incomingCallHandles = [];
  int disposeCount = 0;

  void inject(SignalingModuleEvent event) => _eventsController.add(event);

  @override
  Stream<SignalingModuleEvent> get events => _eventsController.stream;

  @override
  Future<void> start(
    SignalingServiceConfig config, {
    SignalingServiceMode mode = SignalingServiceMode.persistent,
  }) async {
    startedConfigs.add(config);
    startedModes.add(mode);
  }

  @override
  Future<void> attach() async => attachCount++;

  @override
  Future<void> execute(Request request) async => executedRequests.add(request);

  @override
  Future<void> updateMode(SignalingServiceMode mode) async => updatedModes.add(mode);

  @override
  Future<void> setIncomingCallHandler(Function callback) async => incomingCallHandles.add(callback);

  @override
  Future<void> dispose() async {
    disposeCount++;
    await _eventsController.close();
  }
}

// Platform needs a real token for verifyToken to accept it.
class _VerifiedFakePlatform extends _FakePlatform with MockPlatformInterfaceMixin {}

// ---------------------------------------------------------------------------
// Config fixture
// ---------------------------------------------------------------------------

const _kConfig = SignalingServiceConfig(coreUrl: 'wss://example.com', tenantId: 'tenant', token: 'tok');

Future<void> _dummyIncomingCallHandler(IncomingCallEvent event) async {}
Future<void> _anotherDummyHandler(IncomingCallEvent event) async {}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  late _VerifiedFakePlatform platform;
  late WebtritSignalingService service;

  setUp(() {
    platform = _VerifiedFakePlatform();
    SignalingServicePlatform.instance = platform;
    service = WebtritSignalingService();
  });

  // -------------------------------------------------------------------------
  // events delegation
  // -------------------------------------------------------------------------

  group('WebtritSignalingService -- events', () {
    test('events stream is a broadcast stream', () {
      expect(service.events.isBroadcast, isTrue);
    });

    test('events stream receives events injected into platform', () async {
      final received = <SignalingModuleEvent>[];
      service.events.listen(received.add);

      platform.inject(SignalingConnecting());
      platform.inject(SignalingConnected());
      await Future<void>.delayed(Duration.zero);

      expect(received.whereType<SignalingConnecting>(), hasLength(1));
      expect(received.whereType<SignalingConnected>(), hasLength(1));
    });
  });

  // -------------------------------------------------------------------------
  // start() delegation
  // -------------------------------------------------------------------------

  group('WebtritSignalingService -- start()', () {
    test('delegates to platform.start with given config', () async {
      await service.start(_kConfig);

      expect(platform.startedConfigs, hasLength(1));
      expect(platform.startedConfigs[0], same(_kConfig));
    });

    test('delegates default mode persistent to platform', () async {
      await service.start(_kConfig);

      expect(platform.startedModes[0], SignalingServiceMode.persistent);
    });

    test('delegates explicit pushBound mode to platform', () async {
      await service.start(_kConfig, mode: SignalingServiceMode.pushBound);

      expect(platform.startedModes[0], SignalingServiceMode.pushBound);
    });
  });

  // -------------------------------------------------------------------------
  // attach() delegation
  // -------------------------------------------------------------------------

  group('WebtritSignalingService -- attach()', () {
    test('delegates to platform.attach', () async {
      await service.attach();

      expect(platform.attachCount, 1);
    });

    test('calling attach twice increments counter', () async {
      await service.attach();
      await service.attach();

      expect(platform.attachCount, 2);
    });
  });

  // -------------------------------------------------------------------------
  // execute() delegation
  // -------------------------------------------------------------------------

  group('WebtritSignalingService -- execute()', () {
    test('delegates request to platform.execute', () async {
      final request = HangupRequest(transaction: 'tx-1', line: 1, callId: 'call-1');
      await service.execute(request);

      expect(platform.executedRequests, hasLength(1));
      expect(platform.executedRequests[0], same(request));
    });
  });

  // -------------------------------------------------------------------------
  // updateMode() delegation
  // -------------------------------------------------------------------------

  group('WebtritSignalingService -- updateMode()', () {
    test('delegates persistent mode to platform', () async {
      await service.updateMode(SignalingServiceMode.persistent);

      expect(platform.updatedModes, [SignalingServiceMode.persistent]);
    });

    test('delegates pushBound mode to platform', () async {
      await service.updateMode(SignalingServiceMode.pushBound);

      expect(platform.updatedModes, [SignalingServiceMode.pushBound]);
    });
  });

  // -------------------------------------------------------------------------
  // setIncomingCallHandler() delegation
  // -------------------------------------------------------------------------

  group('WebtritSignalingService -- setIncomingCallHandler()', () {
    test('delegates callback to platform', () async {
      await service.setIncomingCallHandler(_dummyIncomingCallHandler);

      expect(platform.incomingCallHandles, [_dummyIncomingCallHandler]);
    });

    test('delegates a different callback to platform', () async {
      await service.setIncomingCallHandler(_anotherDummyHandler);

      expect(platform.incomingCallHandles, [_anotherDummyHandler]);
    });
  });

  // -------------------------------------------------------------------------
  // dispose() delegation
  // -------------------------------------------------------------------------

  group('WebtritSignalingService -- dispose()', () {
    test('delegates to platform.dispose', () async {
      await service.dispose();

      expect(platform.disposeCount, 1);
    });
  });
}
