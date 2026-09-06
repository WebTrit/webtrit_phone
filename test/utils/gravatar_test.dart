import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/utils/utils.dart';

void main() {
  group('GravatarUrl.requestSize', () {
    test('rounds up to the next shared size', () {
      expect(GravatarUrl.requestSize(80), 128);
      expect(GravatarUrl.requestSize(129), 256);
      expect(GravatarUrl.requestSize(300), 512);
    });

    test('gives sizes that are close to each other the same url', () {
      // A list row at 120 and an app bar at 144 are both asked for as one size, so the
      // second one paints the picture the first already downloaded.
      expect(GravatarUrl.requestSize(144), GravatarUrl.requestSize(222));
    });

    test('caps at the largest shared size', () {
      expect(GravatarUrl.requestSize(9000), 2048);
    });
  });

  group('GravatarUrl.withSize', () {
    final gravatar = Uri.parse('https://www.gravatar.com/avatar/abc?d=404');

    test('asks for the size and keeps the other parameters', () {
      final url = GravatarUrl.withSize(gravatar, 256)!;

      expect(url.queryParameters['s'], '256');
      expect(url.queryParameters['d'], '404');
    });

    test('leaves a url that is not a gravatar alone', () {
      final other = Uri.parse('https://example.com/photo.png');

      expect(GravatarUrl.withSize(other, 256), other);
    });
  });
}
