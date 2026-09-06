import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/extensions/extensions.dart';

void main() {
  group('removeScheme', () {
    test('strips a scheme written with slashes', () {
      expect(
        Uri.parse('asset://assets/themes/app.config.json').removeScheme().toString(),
        'assets/themes/app.config.json',
      );
    });

    test('strips a scheme written with a single colon', () {
      expect(
        Uri.parse('asset:assets/themes/app.config.json').removeScheme().toString(),
        'assets/themes/app.config.json',
      );
    });

    test('leaves the payload after a single colon exactly as written', () {
      expect(Uri.parse('memory:SGVsbG8gd29ybGQ=').removeScheme().toString(), 'SGVsbG8gd29ybGQ=');
    });

    test('a payload written after slashes has already lost its capitals', () {
      // Not a wish but a fact of the URI itself, recorded so the constraint is
      // visible: what follows "//" is the authority and is case-folded on parse,
      // which is why case-sensitive payloads have to follow a single colon.
      expect(Uri.parse('memory://SGVsbG8=').toString(), 'memory://sgvsbg8=');
    });
  });
}
