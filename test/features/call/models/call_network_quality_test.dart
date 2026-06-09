import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/features/call/models/models.dart';

void main() {
  group('CallNetworkQualitySeverity.fromSlowlink', () {
    test('low hits and low loss -> mild', () {
      expect(CallNetworkQualitySeverity.fromSlowlink(hits: 1, lost: 0), CallNetworkQualitySeverity.mild);
      expect(CallNetworkQualitySeverity.fromSlowlink(hits: 1, lost: 9), CallNetworkQualitySeverity.mild);
    });

    test('escalates to moderate on repeated hits or moderate loss', () {
      expect(CallNetworkQualitySeverity.fromSlowlink(hits: 2, lost: 0), CallNetworkQualitySeverity.moderate);
      expect(CallNetworkQualitySeverity.fromSlowlink(hits: 1, lost: 10), CallNetworkQualitySeverity.moderate);
      expect(CallNetworkQualitySeverity.fromSlowlink(hits: 4, lost: 29), CallNetworkQualitySeverity.moderate);
    });

    test('escalates to severe on frequent hits or heavy loss', () {
      expect(CallNetworkQualitySeverity.fromSlowlink(hits: 5, lost: 0), CallNetworkQualitySeverity.severe);
      expect(CallNetworkQualitySeverity.fromSlowlink(hits: 1, lost: 30), CallNetworkQualitySeverity.severe);
      expect(CallNetworkQualitySeverity.fromSlowlink(hits: 9, lost: 100), CallNetworkQualitySeverity.severe);
    });
  });

  group('CallNetworkQuality', () {
    test('copyWith overrides only the given fields', () {
      const quality = CallNetworkQuality(
        severity: CallNetworkQualitySeverity.moderate,
        uplink: true,
        media: CallMediaKind.audio,
      );

      final recovered = quality.copyWith(recovered: true);

      expect(recovered.recovered, isTrue);
      expect(recovered.severity, CallNetworkQualitySeverity.moderate);
      expect(recovered.uplink, isTrue);
      expect(recovered.media, CallMediaKind.audio);
    });

    test('value equality includes recovered flag', () {
      const a = CallNetworkQuality(
        severity: CallNetworkQualitySeverity.mild,
        uplink: false,
        media: CallMediaKind.video,
      );
      const b = CallNetworkQuality(
        severity: CallNetworkQualitySeverity.mild,
        uplink: false,
        media: CallMediaKind.video,
      );

      expect(a, equals(b));
      expect(a, isNot(equals(a.copyWith(recovered: true))));
    });
  });
}
