import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ssl_certificates/ssl_certificates.dart';
import 'package:webtrit_signaling_service_platform_interface/webtrit_signaling_service_platform_interface.dart';

import 'package:webtrit_signaling_service_android/src/plugin.dart';

/// Fake direct service that delays its first [start] call until [releaseStart]
/// is called, letting tests create a controlled overlap with a second call.
class _FakeDirectService extends WebtritSignalingServiceDirect {
  final _eventsStreamController = StreamController<SignalingModuleEvent>.broadcast();

  // Gate is kept here so [releaseStart] can complete it even after [start]
  // has already captured the reference and set [_gateConsumed].
  Completer<void>? _gate;
  bool _gateConsumed = false;

  void holdNextStart() {
    _gate = Completer<void>();
    _gateConsumed = false;
  }

  void releaseStart() => _gate?.complete();

  void emit(SignalingModuleEvent event) => _eventsStreamController.add(event);

  @override
  Future<void> start(
    SignalingServiceConfig config, {
    SignalingServiceMode mode = SignalingServiceMode.pushBound,
  }) async {
    // Only the first call is gated; subsequent calls pass through immediately.
    if (!_gateConsumed && _gate != null) {
      _gateConsumed = true;
      await _gate!.future;
    }
  }

  @override
  Stream<SignalingModuleEvent> get events => _eventsStreamController.stream;

  @override
  Future<void> stopService() async {}

  @override
  Future<void> dispose() async => _eventsStreamController.close();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const stopServiceChannel =
      'dev.flutter.pigeon.webtrit_signaling_service_android'
      '.PSignalingServiceHostApi.stopService';

  const connectChannel =
      'dev.flutter.pigeon.webtrit_signaling_service_android'
      '.PSignalingServiceHostApi.connect';

  group('WebtritSignalingServiceAndroid -- stopService()', () {
    late WebtritSignalingServiceAndroid plugin;

    setUp(() {
      plugin = WebtritSignalingServiceAndroid.forTesting();
    });

    tearDown(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMessageHandler(stopServiceChannel, null);
    });

    test('calls the host API stopService channel', () async {
      var called = false;
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMessageHandler(stopServiceChannel, (
        message,
      ) async {
        called = true;
        return const StandardMessageCodec().encodeMessage(<Object?>[null]);
      });

      await plugin.stopService();

      expect(called, isTrue);
    });

    test('does not call stopService channel on dispose', () async {
      var stopCalled = false;
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMessageHandler(stopServiceChannel, (
        message,
      ) async {
        stopCalled = true;
        return const StandardMessageCodec().encodeMessage(<Object?>[null]);
      });

      await plugin.dispose();

      expect(stopCalled, isFalse);
    });
  });

  group('WebtritSignalingServiceAndroid -- _onHubServiceDead()', () {
    const startServiceChannel =
        'dev.flutter.pigeon.webtrit_signaling_service_android'
        '.PSignalingServiceHostApi.startService';

    const testConfig = SignalingServiceConfig(
      coreUrl: 'https://example.com',
      tenantId: 'tenant',
      token: 'token',
      trustedCertificates: TrustedCertificates.empty,
    );

    late WebtritSignalingServiceAndroid plugin;

    setUp(() {
      plugin = WebtritSignalingServiceAndroid.forTesting();
    });

    tearDown(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMessageHandler(
        startServiceChannel,
        null,
      );
    });

    test('does not call startService in pushBound mode', () async {
      plugin.initStateForTesting(config: testConfig, mode: SignalingServiceMode.pushBound);

      var startCalled = false;
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMessageHandler(startServiceChannel, (
        message,
      ) async {
        startCalled = true;
        return const StandardMessageCodec().encodeMessage(<Object?>[null]);
      });

      await plugin.triggerOnServiceDeadForTesting();

      expect(startCalled, isFalse);
    });

    test('does not call startService when _isStopped is true', () async {
      const stopServiceChannel =
          'dev.flutter.pigeon.webtrit_signaling_service_android'
          '.PSignalingServiceHostApi.stopService';

      plugin.initStateForTesting(config: testConfig, mode: SignalingServiceMode.persistent);

      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMessageHandler(
        stopServiceChannel,
        (message) async => const StandardMessageCodec().encodeMessage(<Object?>[null]),
      );
      await plugin.stopService();
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMessageHandler(stopServiceChannel, null);

      var startCalled = false;
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMessageHandler(startServiceChannel, (
        message,
      ) async {
        startCalled = true;
        return const StandardMessageCodec().encodeMessage(<Object?>[null]);
      });

      await plugin.triggerOnServiceDeadForTesting();

      expect(startCalled, isFalse);
    });

    test('does not call startService when config is null', () async {
      var startCalled = false;
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMessageHandler(startServiceChannel, (
        message,
      ) async {
        startCalled = true;
        return const StandardMessageCodec().encodeMessage(<Object?>[null]);
      });

      await plugin.triggerOnServiceDeadForTesting();

      expect(startCalled, isFalse);
    });
  });

  group('WebtritSignalingServiceAndroid -- _startServiceToken (pushBound overlap)', () {
    const testConfig = SignalingServiceConfig(
      coreUrl: 'https://example.com',
      tenantId: 'tenant',
      token: 'token',
      trustedCertificates: TrustedCertificates.empty,
    );

    test('only the latest start attaches a forwarding subscription', () async {
      final fakeDirect = _FakeDirectService();
      final plugin = WebtritSignalingServiceAndroid.forTesting(directService: fakeDirect);

      // Hold the first start so the second overtakes it.
      fakeDirect.holdNextStart();

      final f1 = plugin.start(testConfig, mode: SignalingServiceMode.pushBound);
      // Yield so f1 reaches the suspension point inside _directService.start().
      await Future<void>.microtask(() {});

      // Second start — no gate, completes immediately and takes the token.
      final f2 = plugin.start(testConfig, mode: SignalingServiceMode.pushBound);
      await Future<void>.microtask(() {});

      // Release the gate so f1 can resume and detect that it was superseded.
      fakeDirect.releaseStart();
      await Future.wait([f1, f2]);

      // Only the second start should have attached a subscription.
      // An event emitted by the fake service must appear exactly once.
      final received = <SignalingModuleEvent>[];
      final sub = plugin.events.listen(received.add);
      fakeDirect.emit(SignalingConnecting());
      // Two async broadcast hops: fake stream → _eventsController → plugin.events.
      await Future<void>.delayed(Duration.zero);
      sub.cancel();

      expect(received.length, 1);
    });
  });

  group('WebtritSignalingServiceAndroid -- restoreService()', () {
    late WebtritSignalingServiceAndroid plugin;

    setUp(() {
      plugin = WebtritSignalingServiceAndroid.forTesting();
    });

    tearDown(() {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMessageHandler(connectChannel, null);
    });

    test('calls the host API connect channel', () async {
      var called = false;
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMessageHandler(connectChannel, (
        message,
      ) async {
        called = true;
        return const StandardMessageCodec().encodeMessage(<Object?>[null]);
      });

      await plugin.restoreService();

      expect(called, isTrue);
    });
  });
}
