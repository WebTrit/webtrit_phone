import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/theme/extension/theme_json_serializable.dart';

void main() {
  group('.toColor()', () {
    test('3 Digit HEX Values', () {
      expect('#ac9'.toColor(), const Color(0xFFAACC99));
      expect('#AC9'.toColor(), const Color(0xFFAACC99));
      expect('#F0f'.toColor(), const Color(0xFFFF00FF));
    });

    test('4 Digit HEX Values', () {
      expect('#0123'.toColor(), const Color(0x00112233));
      expect('#10C9'.toColor(), const Color(0x1100CC99));
      expect('#fF0f'.toColor(), const Color(0xFFFF00FF));
    });

    test('6 Digit HEX Values', () {
      expect('#ff0000'.toColor(), const Color(0xFFFF0000));
      expect('#FF0000'.toColor(), const Color(0xFFFF0000));
      expect('#fF0000'.toColor(), const Color(0xFFFF0000));
      expect('#123456'.toColor(), const Color(0xFF123456));
    });

    test('8 Digit HEX Values', () {
      expect('#ff000001'.toColor(), const Color(0xFF000001));
      expect('#FF000001'.toColor(), const Color(0xFF000001));
      expect('#fF00000F'.toColor(), const Color(0xFF00000F));
      expect('#12345678'.toColor(), const Color(0x12345678));
    });

    test('Incorrect Values', () {
      expect(() => ''.toColor(), throwsFormatException);
      expect(() => ' '.toColor(), throwsFormatException);
      expect(() => '  '.toColor(), throwsFormatException);
      expect(() => '   '.toColor(), throwsFormatException);
      expect(() => '    '.toColor(), throwsFormatException);
      expect(() => '     '.toColor(), throwsFormatException);
      expect(() => '      '.toColor(), throwsFormatException);
      expect(() => '       '.toColor(), throwsFormatException);
      expect(() => '        '.toColor(), throwsFormatException);
      expect(() => '         '.toColor(), throwsFormatException);
      expect(() => 'qwerty'.toColor(), throwsFormatException);
      expect(() => '#qwe'.toColor(), throwsFormatException);
      expect(() => '#fabz'.toColor(), throwsFormatException);
      expect(() => '#001122ZZ'.toColor(), throwsFormatException);
    });
  });

  group('.toCSSColorString()', () {
    test('8 Digit HEX Values', () {
      expect(const Color(0xFF000001).toCSSColorString(), '#ff000001'.toUpperCase());
      expect(const Color(0xFF000001).toCSSColorString(), '#FF000001'.toUpperCase());
      expect(const Color(0xFF00000F).toCSSColorString(), '#fF00000F'.toUpperCase());
      expect(const Color(0x12345678).toCSSColorString(), '#12345678'.toUpperCase());
    });
  });
}
