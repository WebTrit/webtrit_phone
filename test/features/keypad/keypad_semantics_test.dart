import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/app/keys.dart';

import 'keypad_harness.dart';

void main() {
  late KeypadHarness harness;

  setUp(() => harness = KeypadHarness());
  tearDown(() => harness.release());

  group('KeypadView - what a screen reader gets', () {
    testWidgets('the number field says what it is and what is in it', (tester) async {
      final semantics = tester.ensureSemantics();
      await tester.pumpWidget(harness.build());

      // It looks like plain text on the screen, so without a name of its own a
      // screen reader would announce nothing but "edit box".
      final data = numberField(tester).getSemanticsData();
      expect(data.label, 'Phone number');
      expect(data.identifier, keypadNumberInputId);
      expect(data.flagsCollection.isTextField, isTrue);

      await tester.tap(find.bySemanticsIdentifier(keypadKeyId('1')));
      await tester.tap(find.bySemanticsIdentifier(keypadKeyId('0')));
      await tester.pump();

      // The number that has been dialled is the value of that same node, so it
      // is read out with the field rather than found somewhere else.
      expect(numberField(tester).getSemanticsData().value, '10');
      await teardownKeypad(tester);
      semantics.dispose();
    });

    testWidgets('nothing on the screen offers a press without saying what it does', (tester) async {
      final semantics = tester.ensureSemantics();
      await tester.pumpWidget(harness.build());

      await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));

      await teardownKeypad(tester);
      semantics.dispose();
    });
  });
}
