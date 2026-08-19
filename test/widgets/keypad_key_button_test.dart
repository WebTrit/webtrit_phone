import 'package:flutter/gestures.dart';
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

  group('zero key pointer input', () {
    const beforeThePlus = Duration(milliseconds: 50);
    final pastThePlus = kLongPressTimeout + const Duration(milliseconds: 100);
    final zeroKey = find.byType(KeypadKeyButton);

    Future<List<String>> pumpZeroKey(WidgetTester tester) async {
      final entered = <String>[];
      await tester.pumpWidget(wrap(KeypadKeyButton(text: '0', subtext: '+', onKeyPressed: entered.add)));
      return entered;
    }

    testWidgets('a quick tap enters the zero', (tester) async {
      final entered = await pumpZeroKey(tester);

      final press = await tester.pressOn(zeroKey);
      await press.hold(beforeThePlus);
      await press.lift();

      expect(entered, ['0']);
    });

    testWidgets('holding for the plus enters the plus and nothing else', (tester) async {
      final entered = await pumpZeroKey(tester);

      final press = await tester.pressOn(zeroKey);
      await press.hold(pastThePlus);
      await press.lift();

      expect(entered, ['+']);
    });

    testWidgets('sliding off the key before the plus fires still enters the zero', (tester) async {
      final entered = await pumpZeroKey(tester);

      final press = await tester.pressOn(zeroKey);
      await press.hold(beforeThePlus);
      await press.slideOff();
      await press.hold(pastThePlus);
      await press.lift();

      expect(entered, ['0']);
    });

    testWidgets('sliding off after the plus fired adds nothing', (tester) async {
      final entered = await pumpZeroKey(tester);

      final press = await tester.pressOn(zeroKey);
      await press.hold(pastThePlus);
      await press.slideOff();
      await press.lift();

      expect(entered, ['+']);
    });

    testWidgets('a press taken away by the platform enters nothing', (tester) async {
      final entered = await pumpZeroKey(tester);

      final press = await tester.pressOn(zeroKey);
      await press.hold(beforeThePlus);
      await press.takenOverByPlatform();

      expect(entered, isEmpty);
    });

    testWidgets('a press taken away leaves the next one working', (tester) async {
      final entered = await pumpZeroKey(tester);

      final taken = await tester.pressOn(zeroKey);
      await taken.hold(beforeThePlus);
      await taken.takenOverByPlatform();

      final press = await tester.pressOn(zeroKey);
      await press.hold(beforeThePlus);
      await press.lift();

      expect(entered, ['0']);
    });

    testWidgets('a finger landing while the plus is held enters its own zero', (tester) async {
      final entered = await pumpZeroKey(tester);

      final held = await tester.pressOn(zeroKey, pointer: 1);
      await held.hold(pastThePlus);

      final second = await tester.pressOn(zeroKey, pointer: 2);
      await second.hold(beforeThePlus);
      await second.lift();
      await held.lift();

      expect(entered, ['+', '0']);
    });

    testWidgets('two strikes that overlap enter two zeros', (tester) async {
      final entered = await pumpZeroKey(tester);

      final first = await tester.pressOn(zeroKey, pointer: 1);
      final second = await tester.pressOn(zeroKey, pointer: 2);
      await first.lift();
      await second.lift();

      expect(entered, ['0', '0']);
    });
  });

  testWidgets('a digit key is entered even when the strike slides off it', (tester) async {
    final entered = <String>[];
    await tester.pumpWidget(wrap(KeypadKeyButton(text: '5', subtext: 'J K L', onKeyPressed: entered.add)));

    final press = await tester.pressOn(find.byType(KeypadKeyButton));
    await press.slideOff();
    await press.lift();

    expect(entered, ['5']);
  });
}
