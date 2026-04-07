import 'package:flutter_test/flutter_test.dart';
import 'package:webtrit_signaling_service_platform_interface/webtrit_signaling_service_platform_interface.dart';

import 'package:webtrit_signaling_service_android/src/messages.g.dart';
import 'package:webtrit_signaling_service_android/src/mode_mapping.dart';

void main() {
  // ---------------------------------------------------------------------------
  // signalingModeToNative -- coverage for every enum value
  // ---------------------------------------------------------------------------

  group('signalingModeToNative', () {
    test('persistent maps to PSignalingServiceMode.persistent', () {
      expect(signalingModeToNative(SignalingServiceMode.persistent), PSignalingServiceMode.persistent);
    });

    test('pushBound maps to PSignalingServiceMode.pushBound', () {
      expect(signalingModeToNative(SignalingServiceMode.pushBound), PSignalingServiceMode.pushBound);
    });

    test('covers every SignalingServiceMode value', () {
      for (final mode in SignalingServiceMode.values) {
        expect(() => signalingModeToNative(mode), returnsNormally);
      }
    });

    test('result enum count matches source enum count', () {
      final nativeValues = SignalingServiceMode.values.map(signalingModeToNative).toSet();
      expect(nativeValues, hasLength(SignalingServiceMode.values.length));
    });

    test('mapping is injective -- no two source values map to the same native value', () {
      final mapped = SignalingServiceMode.values.map(signalingModeToNative).toList();
      final distinct = mapped.toSet();
      expect(distinct.length, mapped.length);
    });
  });

  // ---------------------------------------------------------------------------
  // PSignalingServiceMode -- Pigeon-generated enum sanity
  // ---------------------------------------------------------------------------

  group('PSignalingServiceMode', () {
    test('has exactly two values', () {
      expect(PSignalingServiceMode.values, hasLength(2));
    });

    test('persistent has index 0', () {
      expect(PSignalingServiceMode.persistent.index, 0);
    });

    test('pushBound has index 1', () {
      expect(PSignalingServiceMode.pushBound.index, 1);
    });

    test('values are distinct', () {
      expect(PSignalingServiceMode.persistent, isNot(PSignalingServiceMode.pushBound));
    });

    test('can be retrieved by index via values list', () {
      expect(PSignalingServiceMode.values[0], PSignalingServiceMode.persistent);
      expect(PSignalingServiceMode.values[1], PSignalingServiceMode.pushBound);
    });
  });
}
