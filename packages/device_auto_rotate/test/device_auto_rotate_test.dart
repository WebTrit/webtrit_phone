import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:device_auto_rotate/device_auto_rotate.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const MethodChannel channel = MethodChannel('device_auto_rotate');

  setUp(() {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
  });

  tearDown(() {
    debugDefaultTargetPlatformOverride = null;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  Future<Object?> mockTrueHandler(MethodCall methodCall) async {
    if (methodCall.method == 'isAutoRotateEnabled') {
      return true;
    }
    return null;
  }

  Future<Object?> mockFalseHandler(MethodCall methodCall) async {
    if (methodCall.method == 'isAutoRotateEnabled') {
      return false;
    }
    return null;
  }

  test('isEnabled returns true when native platform returns true', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      mockTrueHandler,
    );

    expect(await DeviceAutoRotate.isEnabled, true);
  });

  test('isEnabled returns false when native platform returns false', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      mockFalseHandler,
    );

    expect(await DeviceAutoRotate.isEnabled, false);
  });
}
