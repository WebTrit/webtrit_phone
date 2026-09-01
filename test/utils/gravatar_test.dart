import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/utils/utils.dart';

void main() {
  group('gravatarRequestSize', () {
    test('rounds up to the next shared size', () {
      expect(gravatarRequestSize(80), 128);
      expect(gravatarRequestSize(129), 256);
      expect(gravatarRequestSize(300), 512);
    });

    test('gives sizes that are close to each other the same url', () {
      // A list row at 120 and an app bar at 144 are both asked for as one size, so the
      // second one paints the picture the first already downloaded.
      expect(gravatarRequestSize(144), gravatarRequestSize(222));
    });

    test('caps at the largest shared size', () {
      expect(gravatarRequestSize(9000), 2048);
    });
  });

  group('gravatarUrlWithSize', () {
    final gravatar = Uri.parse('https://www.gravatar.com/avatar/abc?d=404');

    test('asks for the size and keeps the other parameters', () {
      final url = gravatarUrlWithSize(gravatar, 256)!;

      expect(url.queryParameters['s'], '256');
      expect(url.queryParameters['d'], '404');
    });

    test('leaves a url that is not a gravatar alone', () {
      final other = Uri.parse('https://example.com/photo.png');

      expect(gravatarUrlWithSize(other, 256), other);
    });
  });
}
