import 'package:flutter/semantics.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/features/keypad/view/keypad_view.dart';

import 'keypad_harness.dart';

void main() {
  late KeypadHarness harness;

  setUp(() => harness = KeypadHarness());
  tearDown(() => harness.release());

  /// The paste action as assistive technology addresses it: by the identifier
  /// its label hashes to.
  final pasteAction = CustomSemanticsAction.getIdentifier(const CustomSemanticsAction(label: 'Paste a number'));

  group('KeypadView - putting a number in without a long press', () {
    testWidgets('the field offers a named action that pastes the clipboard', (tester) async {
      final semantics = tester.ensureSemantics();
      harness.withClipboard('+380 (99) 123-45-67');
      await tester.pumpWidget(harness.build());

      expect(numberField(tester).getSemanticsData().customSemanticsActionIds, contains(pasteAction));

      final field = numberField(tester);
      field.owner!.performAction(field.id, SemanticsAction.customAction, pasteAction);
      await tester.pumpAndSettle();

      // What lands in the field is a number, not the punctuation around it.
      expect(find.text('+380991234567'), findsOneWidget);
      await teardownKeypad(tester);
      semantics.dispose();
    });

    testWidgets('with nothing on the clipboard it leaves the field alone', (tester) async {
      final semantics = tester.ensureSemantics();
      harness.withClipboard(null);
      // Start from a number already dialled: an empty field would look the same
      // whether the action did nothing or wiped what was there.
      await harness.keypadCubit.setValue('1001');
      await tester.pumpWidget(harness.build());

      final field = numberField(tester);
      field.owner!.performAction(field.id, SemanticsAction.customAction, pasteAction);
      await tester.pumpAndSettle();

      expect(numberField(tester).getSemanticsData().value, '1001');
      await teardownKeypad(tester);
      semantics.dispose();
    });

    testWidgets('the invisible area behind the field says nothing of its own', (tester) async {
      final semantics = tester.ensureSemantics();
      harness.withClipboard('1001');
      await tester.pumpWidget(harness.build());

      // The long press stays for a finger, but it no longer stretches the field
      // over the whole upper half of the screen.
      expect(numberField(tester).rect.height, lessThan(tester.getSize(find.byType(KeypadView)).height / 2));
      await teardownKeypad(tester);
      semantics.dispose();
    });
  });
}
