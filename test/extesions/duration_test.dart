import 'package:test/test.dart';

import 'package:webtrit_phone/extensions/extensions.dart';

void main() {
  test('.format() output two segment for Duration up to hour', () {
    expect('00:01', const Duration(seconds: 1).format());
    expect('59:59', const Duration(minutes: 59, seconds: 59).format());
  });

  test('.format() output three segment for Duration over hour', () {
    expect('01:00:00', const Duration(hours: 1).format());
    expect('100:00:00', const Duration(hours: 100).format());
  });
}
