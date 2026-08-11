import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/widgets/keypad_key_button.dart';

import '../helpers/helpers.dart';

void main() {
  Widget wrap(Widget child) {
    return MaterialApp(
      home: Scaffold(body: Center(child: child)),
    );
  }

  testWidgets('digit key is one named node and semantic activation enters the digit once', (tester) async {
    final handle = tester.ensureSemantics();

    final pressed = <String>[];
    await tester.pumpWidget(wrap(KeypadKeyButton(text: '2', subtext: 'A B C', onKeyPressed: pressed.add)));

    final finder = find.bySemanticsIdentifier(keypadKeyId('2'));
    expectTapTargetSemantics(tester, finder, label: '2 A B C', identifier: keypadKeyId('2'), isButton: true);

    await tapViaSemantics(tester, finder);
    expect(pressed, ['2']);

    handle.dispose();
  });

  testWidgets('pointer input path still enters the digit exactly once', (tester) async {
    final pressed = <String>[];
    await tester.pumpWidget(wrap(KeypadKeyButton(text: '7', subtext: 'P Q R S', onKeyPressed: pressed.add)));

    await tester.tap(find.byType(KeypadKeyButton));
    await tester.pumpAndSettle();
    expect(pressed, ['7']);
  });

  testWidgets('zero key: semantic long press enters the plus', (tester) async {
    final handle = tester.ensureSemantics();

    final pressed = <String>[];
    await tester.pumpWidget(wrap(KeypadKeyButton(text: '0', subtext: '+', onKeyPressed: pressed.add)));

    final finder = find.bySemanticsIdentifier(keypadKeyId('0'));
    final node = tester.getSemantics(finder);
    expect(node.getSemanticsData().hasAction(SemanticsAction.longPress), isTrue);

    node.owner!.performAction(node.id, SemanticsAction.longPress);
    await tester.pump();
    expect(pressed, ['+']);

    await tapViaSemantics(tester, finder);
    expect(pressed, ['+', '0']);

    handle.dispose();
  });

  testWidgets('star and pound keys get readable stable ids', (tester) async {
    final handle = tester.ensureSemantics();

    await tester.pumpWidget(
      wrap(
        Row(
          children: [
            KeypadKeyButton(text: '*', subtext: '', onKeyPressed: (_) {}),
            KeypadKeyButton(text: '#', subtext: '', onKeyPressed: (_) {}),
          ],
        ),
      ),
    );

    expectTapTargetSemantics(tester, find.bySemanticsIdentifier(keypadKeyStarId), label: '*', isButton: true);
    expectTapTargetSemantics(tester, find.bySemanticsIdentifier(keypadKeyPoundId), label: '#', isButton: true);

    handle.dispose();
  });
}
