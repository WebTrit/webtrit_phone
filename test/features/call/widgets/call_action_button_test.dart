import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/features/call/widgets/call_action_button.dart';

import '../../../helpers/helpers.dart';

void main() {
  Widget wrap(Widget child) {
    return MaterialApp(
      home: Scaffold(body: Center(child: child)),
    );
  }

  group('CallActionButton', () {
    testWidgets('label, identifier and tap live on one node; semantic activation fires', (tester) async {
      final handle = tester.ensureSemantics();

      var pressed = false;
      await tester.pumpWidget(
        wrap(
          CallActionButton(
            label: 'Mute',
            identifier: 'callActionsMute',
            onPressed: () => pressed = true,
            child: const Icon(Icons.mic),
          ),
        ),
      );

      final finder = find.bySemanticsIdentifier('callActionsMute');
      expectTapTargetSemantics(tester, finder, label: 'Mute', identifier: 'callActionsMute', isButton: true);

      await tapViaSemantics(tester, finder);
      expect(pressed, isTrue);

      handle.dispose();
    });

    testWidgets('disabled button exposes no tap action', (tester) async {
      final handle = tester.ensureSemantics();

      await tester.pumpWidget(
        wrap(
          const CallActionButton(
            label: 'Hold call',
            identifier: 'callActionsHold',
            onPressed: null,
            child: Icon(Icons.pause),
          ),
        ),
      );

      final node = tester.getSemantics(find.bySemanticsIdentifier('callActionsHold'));
      expect(node, isSemantics(label: 'Hold call', hasTapAction: false));

      handle.dispose();
    });
  });

  group('CallActionMenuButton', () {
    testWidgets('semantic activation opens the menu', (tester) async {
      final handle = tester.ensureSemantics();

      await tester.pumpWidget(
        wrap(
          CallActionMenuButton<int>(
            label: 'Transfer current call',
            identifier: 'callActionsTransferMenu',
            items: const [
              PopupMenuItem(value: 1, child: Text('Unattended transfer')),
              PopupMenuItem(value: 2, child: Text('Attended transfer')),
            ],
            child: const Icon(Icons.phone_forwarded),
          ),
        ),
      );

      final finder = find.bySemanticsIdentifier('callActionsTransferMenu');
      expectTapTargetSemantics(
        tester,
        finder,
        label: 'Transfer current call',
        identifier: 'callActionsTransferMenu',
        isButton: true,
      );

      await tapViaSemantics(tester, finder);
      await tester.pumpAndSettle();

      expect(find.text('Unattended transfer'), findsOneWidget);
      expect(find.text('Attended transfer'), findsOneWidget);

      handle.dispose();
    });

    testWidgets('the built-in "Show menu" tooltip does not leak into the node or the long press', (tester) async {
      final handle = tester.ensureSemantics();

      await tester.pumpWidget(
        wrap(
          CallActionMenuButton<int>(
            label: 'Change audio device',
            identifier: 'callActionsAudioDevice',
            items: const [PopupMenuItem(value: 1, child: Text('Speaker'))],
            child: const Icon(Icons.volume_up),
          ),
        ),
      );

      // The trigger carries its own name only: the popup button's default
      // tooltip is spoken on top of the label (appended to it on iOS).
      expectTapTargetSemantics(
        tester,
        find.bySemanticsIdentifier('callActionsAudioDevice'),
        label: 'Change audio device',
        isButton: true,
      );

      // ... and the visual long press shows that name too, not "Show menu".
      final gesture = await tester.startGesture(tester.getCenter(find.byIcon(Icons.volume_up)));
      await tester.pump(const Duration(seconds: 1));
      await gesture.up();
      await tester.pump();
      expect(find.text('Change audio device'), findsOneWidget);

      await tester.pumpAndSettle();
      handle.dispose();
    });

    testWidgets('a trigger with an empty menu advertises no action', (tester) async {
      final handle = tester.ensureSemantics();

      await tester.pumpWidget(
        wrap(
          const CallActionMenuButton<int>(
            label: 'Transfer',
            identifier: 'callActionsTransferMenu',
            items: [],
            child: Icon(Icons.phone_forwarded),
          ),
        ),
      );

      final node = tester.getSemantics(find.bySemanticsIdentifier('callActionsTransferMenu'));
      expect(node, isSemantics(label: 'Transfer', hasTapAction: false));

      handle.dispose();
    });

    testWidgets('pointer tap opens the menu as well', (tester) async {
      await tester.pumpWidget(
        wrap(
          CallActionMenuButton<int>(
            label: 'Change audio device',
            items: const [PopupMenuItem(value: 1, child: Text('Speaker'))],
            child: const Icon(Icons.volume_up),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.volume_up));
      await tester.pumpAndSettle();

      expect(find.text('Speaker'), findsOneWidget);
    });
  });
}
