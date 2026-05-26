import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/utils/interface_change_detector.dart';

void main() {
  group('InterfaceChangeDetector', () {
    test('first update with a live interface returns null (no previous)', () {
      final detector = InterfaceChangeDetector();
      expect(detector.update(ConnectivityResult.wifi), isNull);
    });

    test('same interface twice returns null', () {
      final detector = InterfaceChangeDetector();
      detector.update(ConnectivityResult.wifi);
      expect(detector.update(ConnectivityResult.wifi), isNull);
    });

    test('switch between two live interfaces returns the change', () {
      final detector = InterfaceChangeDetector();
      detector.update(ConnectivityResult.wifi);
      final change = detector.update(ConnectivityResult.mobile);
      expect(change, isNotNull);
      expect(change!.previous, ConnectivityResult.wifi);
      expect(change.current, ConnectivityResult.mobile);
    });

    test('drop+restore of the same interface is not a change', () {
      final detector = InterfaceChangeDetector();
      detector.update(ConnectivityResult.wifi);
      detector.update(ConnectivityResult.none);
      expect(detector.update(ConnectivityResult.wifi), isNull);
    });

    test('switch through a brief none is detected as a change', () {
      final detector = InterfaceChangeDetector();
      detector.update(ConnectivityResult.wifi);
      detector.update(ConnectivityResult.none);
      final change = detector.update(ConnectivityResult.mobile);
      expect(change, isNotNull);
      expect(change!.previous, ConnectivityResult.wifi);
      expect(change.current, ConnectivityResult.mobile);
    });

    test('rapid flap within the debounce window collapses to one change', () {
      var fakeNow = DateTime(2026, 1, 1, 12, 0, 0);
      final detector = InterfaceChangeDetector(
        debounce: const Duration(seconds: 2),
        now: () => fakeNow,
      );
      detector.update(ConnectivityResult.wifi);
      // First switch fires.
      expect(detector.update(ConnectivityResult.mobile), isNotNull);
      // Second switch within 2s is suppressed.
      fakeNow = fakeNow.add(const Duration(milliseconds: 500));
      expect(detector.update(ConnectivityResult.wifi), isNull);
      // Third switch still within 2s of the first - also suppressed.
      fakeNow = fakeNow.add(const Duration(milliseconds: 500));
      expect(detector.update(ConnectivityResult.mobile), isNull);
    });

    test('change after the debounce window fires again', () {
      var fakeNow = DateTime(2026, 1, 1, 12, 0, 0);
      final detector = InterfaceChangeDetector(
        debounce: const Duration(seconds: 2),
        now: () => fakeNow,
      );
      detector.update(ConnectivityResult.wifi);
      expect(detector.update(ConnectivityResult.mobile), isNotNull);
      fakeNow = fakeNow.add(const Duration(seconds: 3));
      final change = detector.update(ConnectivityResult.wifi);
      expect(change, isNotNull);
      expect(change!.previous, ConnectivityResult.mobile);
      expect(change.current, ConnectivityResult.wifi);
    });

    test('update with none does not modify the remembered primary', () {
      final detector = InterfaceChangeDetector();
      detector.update(ConnectivityResult.wifi);
      detector.update(ConnectivityResult.none);
      detector.update(ConnectivityResult.none);
      // wifi is still the last primary; switching to mobile is detected.
      final change = detector.update(ConnectivityResult.mobile);
      expect(change, isNotNull);
      expect(change!.previous, ConnectivityResult.wifi);
    });
  });
}
