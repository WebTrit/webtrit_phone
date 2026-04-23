import 'dart:async';

import 'package:fake_async/fake_async.dart';
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
  Object? executeError;
  final List<SignalingServiceMode> updatedModes = [];
  final List<Function> incomingCallHandles = [];
  final List<SignalingModuleFactory> moduleFactories = [];
  int disposeCount = 0;
  int stopServiceCount = 0;
  int restoreServiceCount = 0;

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
  Future<void> execute(Request request) async {
    if (executeError != null) throw executeError!;
    executedRequests.add(request);
  }

  @override
  Future<void> updateMode(SignalingServiceMode mode) async => updatedModes.add(mode);

  @override
  Future<void> setIncomingCallHandler(Function callback) async => incomingCallHandles.add(callback);

  @override
  Future<void> setModuleFactory(SignalingModuleFactory factory) async => moduleFactories.add(factory);

  @override
  Future<void> dispose() async {
    disposeCount++;
    await _eventsController.close();
  }

  @override
  Future<void> stopService() async => stopServiceCount++;

  @override
  Future<void> restoreService() async => restoreServiceCount++;
}

class _VerifiedFakePlatform extends _FakePlatform with MockPlatformInterfaceMixin {}

// ---------------------------------------------------------------------------
// Config fixture
// ---------------------------------------------------------------------------

const _kConfig = SignalingServiceConfig(coreUrl: 'wss://example.com', tenantId: 'tenant', token: 'tok');

Future<void> _dummyHandler(IncomingCallEvent event) async {}
Future<void> _anotherHandler(IncomingCallEvent event) async {}
SignalingModule _dummyFactory(SignalingServiceConfig _) => throw UnimplementedError();

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  late _VerifiedFakePlatform platform;

  setUp(() {
    platform = _VerifiedFakePlatform();
    SignalingServicePlatform.instance = platform;
  });

  // -------------------------------------------------------------------------
  // events
  // -------------------------------------------------------------------------

  group('WebtritSignalingService -- events', () {
    test('stream is broadcast', () {
      final service = WebtritSignalingService(config: _kConfig);
      expect(service.events.isBroadcast, isTrue);
    });

    test('forwards events from the platform', () async {
      final service = WebtritSignalingService(config: _kConfig);
      final received = <SignalingModuleEvent>[];
      service.events.listen(received.add);

      platform.inject(SignalingConnecting());
      platform.inject(SignalingConnected());
      await Future<void>.delayed(Duration.zero);

      expect(received.whereType<SignalingConnecting>(), hasLength(1));
      expect(received.whereType<SignalingConnected>(), hasLength(1));

      await service.dispose();
    });
  });

  // -------------------------------------------------------------------------
  // connect() / isConnected
  // -------------------------------------------------------------------------

  group('WebtritSignalingService -- connect()', () {
    test('calls platform.start with the config from the constructor', () async {
      final service = WebtritSignalingService(config: _kConfig);
      service.connect();
      await Future<void>.delayed(Duration.zero);

      expect(platform.startedConfigs, [_kConfig]);
      await service.dispose();
    });

    test('uses persistent mode by default', () async {
      final service = WebtritSignalingService(config: _kConfig);
      service.connect();
      await Future<void>.delayed(Duration.zero);

      expect(platform.startedModes, [SignalingServiceMode.persistent]);
      await service.dispose();
    });

    test('uses the mode passed to the constructor', () async {
      final service = WebtritSignalingService(config: _kConfig, mode: SignalingServiceMode.pushBound);
      service.connect();
      await Future<void>.delayed(Duration.zero);

      expect(platform.startedModes, [SignalingServiceMode.pushBound]);
      await service.dispose();
    });

    test('is idempotent while start is pending', () async {
      final service = WebtritSignalingService(config: _kConfig);
      service.connect();
      service.connect();
      service.connect();
      await Future<void>.delayed(Duration.zero);

      expect(platform.startedConfigs, hasLength(1));
      await service.dispose();
    });

    test('is idempotent while already connected', () async {
      final service = WebtritSignalingService(config: _kConfig);
      service.connect();
      await Future<void>.delayed(Duration.zero);
      platform.inject(SignalingConnected());
      await Future<void>.delayed(Duration.zero);

      service.connect();
      await Future<void>.delayed(Duration.zero);

      expect(platform.startedConfigs, hasLength(1));
      await service.dispose();
    });

    test('isConnected becomes true after SignalingConnected event', () async {
      final service = WebtritSignalingService(config: _kConfig);
      expect(service.isConnected, isFalse);

      platform.inject(SignalingConnected());
      await Future<void>.delayed(Duration.zero);

      expect(service.isConnected, isTrue);
      await service.dispose();
    });

    test('isConnected becomes false after SignalingDisconnected', () async {
      final service = WebtritSignalingService(config: _kConfig);
      platform.inject(SignalingConnected());
      await Future<void>.delayed(Duration.zero);
      expect(service.isConnected, isTrue);

      platform.inject(
        SignalingDisconnected(
          code: null,
          reason: null,
          knownCode: SignalingDisconnectCode.normalClosure,
          recommendedReconnectDelay: null,
        ),
      );
      await Future<void>.delayed(Duration.zero);

      expect(service.isConnected, isFalse);
      await service.dispose();
    });
  });

  // -------------------------------------------------------------------------
  // disconnect() — no-op
  // -------------------------------------------------------------------------

  group('WebtritSignalingService -- disconnect()', () {
    test('is a no-op and does not call platform.dispose', () async {
      final service = WebtritSignalingService(config: _kConfig);
      await service.disconnect();

      expect(platform.disposeCount, 0);
      await service.dispose();
    });
  });

  // -------------------------------------------------------------------------
  // execute()
  // -------------------------------------------------------------------------

  group('WebtritSignalingService -- execute()', () {
    test('queues requests when not connected and flushes on connect', () async {
      final service = WebtritSignalingService(config: _kConfig);
      final request = HangupRequest(transaction: 'tx-1', line: 1, callId: 'call-1');

      unawaited(service.execute(request)!);
      expect(platform.executedRequests, isEmpty);

      platform.inject(SignalingConnected());
      await Future<void>.delayed(Duration.zero);

      expect(platform.executedRequests, [request]);
      await service.dispose();
    });

    test('executes immediately when connected', () async {
      final service = WebtritSignalingService(config: _kConfig);
      platform.inject(SignalingConnected());
      await Future<void>.delayed(Duration.zero);

      final request = HangupRequest(transaction: 'tx-1', line: 1, callId: 'call-1');
      await service.execute(request)!;

      expect(platform.executedRequests, [request]);
      await service.dispose();
    });
  });

  // -------------------------------------------------------------------------
  // dispose()
  // -------------------------------------------------------------------------

  group('WebtritSignalingService -- dispose()', () {
    test('calls platform.dispose', () async {
      final service = WebtritSignalingService(config: _kConfig);
      await service.dispose();

      expect(platform.disposeCount, 1);
    });

    test('fails queued requests on dispose', () async {
      final service = WebtritSignalingService(config: _kConfig);
      final request = HangupRequest(transaction: 'tx-1', line: 1, callId: 'call-1');
      final future = service.execute(request)!;
      // Register the error handler before dispose() calls failAll so the
      // future error is not treated as unhandled.
      final expectation = expectLater(future, throwsA(isA<NotConnectedException>()));

      await service.dispose();
      await expectation;
    });
  });

  // -------------------------------------------------------------------------
  // Static methods
  // -------------------------------------------------------------------------

  group('WebtritSignalingService -- static setup', () {
    test('setModuleFactory delegates to platform', () async {
      await WebtritSignalingService.setModuleFactory(_dummyFactory);
      expect(platform.moduleFactories, [_dummyFactory]);
    });

    test('setIncomingCallHandler delegates to platform', () async {
      await WebtritSignalingService.setIncomingCallHandler(_dummyHandler);
      expect(platform.incomingCallHandles, [_dummyHandler]);
    });

    test('setIncomingCallHandler with different callback', () async {
      await WebtritSignalingService.setIncomingCallHandler(_anotherHandler);
      expect(platform.incomingCallHandles, [_anotherHandler]);
    });

    test('attach delegates to platform', () async {
      await WebtritSignalingService.attach();
      expect(platform.attachCount, 1);
    });

    test('updateMode persistent delegates to platform', () async {
      await WebtritSignalingService.updateMode(SignalingServiceMode.persistent);
      expect(platform.updatedModes, [SignalingServiceMode.persistent]);
    });

    test('updateMode pushBound delegates to platform', () async {
      await WebtritSignalingService.updateMode(SignalingServiceMode.pushBound);
      expect(platform.updatedModes, [SignalingServiceMode.pushBound]);
    });

    test('stopService delegates to platform', () async {
      await WebtritSignalingService.stopService();
      expect(platform.stopServiceCount, 1);
    });

    test('restoreService delegates to platform', () async {
      await WebtritSignalingService.restoreService();
      expect(platform.restoreServiceCount, 1);
    });
  });

  // -------------------------------------------------------------------------
  // execute() — ghost state detection (Bug #3 / WT-1403 3rd protection layer)
  //
  // "Ghost state": main-isolate _isConnected=true while the FGS SignalingModule
  // has _client=null. The FGS hub throws NotConnectedException across the
  // isolate boundary; WebtritSignalingService.execute() detects it, resets
  // _isConnected, and calls connect() to recover.
  // -------------------------------------------------------------------------

  group('WebtritSignalingService -- execute() ghost state detection', () {
    // _executeWithRetry retries NotConnectedException up to maxRetryCount (3)
    // times with a 2-second backoff. We use fakeAsync to skip those delays.
    // Total timer budget: 3 retries × 2 s = 6 s → elapse 7 s to be safe.

    test('NotConnectedException resets isConnected to false', () {
      fakeAsync((async) {
        final service = WebtritSignalingService(config: _kConfig);
        service.connect();
        async.flushMicrotasks();
        platform.inject(SignalingConnected());
        async.flushMicrotasks();
        expect(service.isConnected, isTrue);

        platform.executeError = NotConnectedException('ghost state');
        final request = HangupRequest(transaction: 'tx-ghost', line: 1, callId: 'call-ghost');
        service.execute(request)!.ignore();

        async.elapse(const Duration(seconds: 7));

        expect(service.isConnected, isFalse);

        service.dispose();
        async.flushMicrotasks();
      });
    });

    test('NotConnectedException triggers connect() to recover', () {
      fakeAsync((async) {
        final service = WebtritSignalingService(config: _kConfig);
        service.connect();
        async.flushMicrotasks();
        expect(platform.startedConfigs, hasLength(1));

        platform.inject(SignalingConnected());
        async.flushMicrotasks();

        platform.executeError = NotConnectedException('ghost state');
        final request = HangupRequest(transaction: 'tx-ghost', line: 1, callId: 'call-ghost');
        service.execute(request)!.ignore();

        async.elapse(const Duration(seconds: 7));

        // connect() was called again after ghost state detected
        expect(platform.startedConfigs, hasLength(2));

        service.dispose();
        async.flushMicrotasks();
      });
    });

    test('NotConnectedException is rethrown to the caller', () {
      fakeAsync((async) {
        final service = WebtritSignalingService(config: _kConfig);
        platform.inject(SignalingConnected());
        async.flushMicrotasks();

        platform.executeError = NotConnectedException('ghost state');
        final request = HangupRequest(transaction: 'tx-ghost', line: 1, callId: 'call-ghost');

        Object? caught;
        service
            .execute(request)!
            .then(
              (_) {},
              onError: (Object e, StackTrace _) {
                caught = e;
              },
            );

        async.elapse(const Duration(seconds: 7));

        expect(caught, isA<NotConnectedException>());

        service.dispose();
        async.flushMicrotasks();
      });
    });

    test('successful execute does not trigger reconnect', () async {
      final service = WebtritSignalingService(config: _kConfig);
      service.connect();
      await Future<void>.delayed(Duration.zero);
      platform.inject(SignalingConnected());
      await Future<void>.delayed(Duration.zero);

      final request = HangupRequest(transaction: 'tx-1', line: 1, callId: 'call-1');
      await service.execute(request)!;

      expect(platform.startedConfigs, hasLength(1));
      await service.dispose();
    });

    test('non-NotConnectedException is rethrown without triggering reconnect', () async {
      final service = WebtritSignalingService(config: _kConfig);
      service.connect();
      await Future<void>.delayed(Duration.zero);
      platform.inject(SignalingConnected());
      await Future<void>.delayed(Duration.zero);

      platform.executeError = Exception('transport error');
      final request = HangupRequest(transaction: 'tx-1', line: 1, callId: 'call-1');

      await expectLater(service.execute(request)!, throwsA(isA<Exception>()));

      expect(service.isConnected, isTrue);
      expect(platform.startedConfigs, hasLength(1));
      await service.dispose();
    });
  });
}
