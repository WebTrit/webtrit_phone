import 'package:flutter_test/flutter_test.dart';

void main() {
  group('A group of tests', () {
    const awesome = true;

    setUp(() {
      // Additional setup goes here.
    });

    test('First Test', () {
      expect(awesome, isTrue);
    });
  });
}
