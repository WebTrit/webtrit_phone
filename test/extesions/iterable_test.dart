import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/extensions/extensions.dart';

void main() {
  test('.readableJoin()', () {
    expect(<String?>[].readableJoin(), equals(''));
    expect(<String?>[null].readableJoin(), equals(''));
    expect(<String?>[null, null].readableJoin(), equals(''));
    expect(<String?>[null, ' ', null, ''].readableJoin(), equals(''));
    expect(<String?>[null, 'qwe', null, 'asd', null].readableJoin(), equals('qwe asd'));
    expect(<String?>['1', '2', '3'].readableJoin(), equals('1 2 3'));
    expect(<String?>['a', null, 'b', null, 'c'].readableJoin('_'), equals('a_b_c'));
  });
}
