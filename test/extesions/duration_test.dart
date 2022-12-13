import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/extensions/extensions.dart';

void main() {
  test('.format() output two segment for Duration up to hour', () {
    expect(const Duration(seconds: 1).format(), equals('00:01'));
    expect(const Duration(minutes: 59, seconds: 59).format(), equals('59:59'));
  });

  test('.format() output three segment for Duration over hour', () {
    expect(const Duration(hours: 1).format(), equals('01:00:00'));
    expect(const Duration(hours: 100).format(), equals('100:00:00'));
  });
}
