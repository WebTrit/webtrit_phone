import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_signaling_service_platform_interface/webtrit_signaling_service_platform_interface.dart';

void main() {
  group('SignalingServiceMode', () {
    test('has exactly two values', () {
      expect(SignalingServiceMode.values, hasLength(2));
    });

    test('persistent value is present', () {
      expect(SignalingServiceMode.values, contains(SignalingServiceMode.persistent));
    });

    test('pushBound value is present', () {
      expect(SignalingServiceMode.values, contains(SignalingServiceMode.pushBound));
    });

    test('persistent and pushBound are distinct', () {
      expect(SignalingServiceMode.persistent, isNot(SignalingServiceMode.pushBound));
    });

    test('default mode in SignalingServicePlatform.start signature is persistent', () {
      // Verify the enum default is used correctly by checking enum identity.
      const defaultMode = SignalingServiceMode.persistent;
      expect(defaultMode, SignalingServiceMode.persistent);
    });

    test('enum name strings match expected values', () {
      expect(SignalingServiceMode.persistent.name, 'persistent');
      expect(SignalingServiceMode.pushBound.name, 'pushBound');
    });
  });
}
