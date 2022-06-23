import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/extensions/extensions.dart';

void main() {
  group('.initialism', () {
    test('return max three latter initialism', () {
      expect('Aaa Bbb Ccc Ddd'.initialism, 'ABC');
      expect('Aaa Bbb Ccc'.initialism, 'ABC');
      expect('Aaa Bbb'.initialism, 'AB');
      expect('Aaa'.initialism, 'A');
    });

    test('trim spaces', () {
      expect('  Aaa Bbb   Ccc Ddd  '.initialism, 'ABC');
      expect('  Aaa  Bbb   '.initialism, 'AB');
      expect(' Aaa '.initialism, 'A');
      expect('   '.initialism, '');
    });
  });
}
