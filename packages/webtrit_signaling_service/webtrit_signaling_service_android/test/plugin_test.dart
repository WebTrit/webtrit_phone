import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

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
