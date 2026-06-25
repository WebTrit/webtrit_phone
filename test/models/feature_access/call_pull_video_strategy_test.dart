import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/models/models.dart';

void main() {
  group('CallPullVideoStrategy.tryParse', () {
    test('parses known names', () {
      expect(CallPullVideoStrategy.tryParse('softMute'), CallPullVideoStrategy.softMute);
      expect(CallPullVideoStrategy.tryParse('hideVideo'), CallPullVideoStrategy.hideVideo);
    });

    test('returns null for null/unknown values', () {
      expect(CallPullVideoStrategy.tryParse(null), isNull);
      expect(CallPullVideoStrategy.tryParse(''), isNull);
      expect(CallPullVideoStrategy.tryParse('SoftMute'), isNull); // case-sensitive by enum name
      expect(CallPullVideoStrategy.tryParse('nope'), isNull);
    });
  });
}
