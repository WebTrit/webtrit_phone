import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ssl_certificates/ssl_certificates.dart';
import 'package:webtrit_signaling_service_platform_interface/webtrit_signaling_service_platform_interface.dart';

import 'package:webtrit_signaling_service_android/src/plugin.dart';

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
