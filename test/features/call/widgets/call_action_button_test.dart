import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/features/call/widgets/call_action_button.dart';

void main() {
  Widget wrap(Widget child) {
    return MaterialApp(
      home: Scaffold(body: Center(child: child)),
    );
  }

  group('CallActionButton', () {
    testWidgets('renders the child, carries the tooltip and fires on tap', (tester) async {
      var pressed = false;
      await tester.pumpWidget(
        wrap(CallActionButton(label: 'Mute microphone', onPressed: () => pressed = true, child: const Icon(Icons.mic))),
      );

      expect(find.byTooltip('Mute microphone'), findsOneWidget);
      await tester.tap(find.byIcon(Icons.mic));
      expect(pressed, isTrue);
    });

    testWidgets('null onPressed renders the disabled state', (tester) async {
      await tester.pumpWidget(
        wrap(const CallActionButton(label: 'Hold call', onPressed: null, child: Icon(Icons.pause))),
      );

      final button = tester.widget<TextButton>(find.byType(TextButton));
      expect(button.onPressed, isNull);
    });
  });

  group('CallActionMenuButton', () {
    testWidgets('tap opens the menu with its items', (tester) async {
      await tester.pumpWidget(
        wrap(
          CallActionMenuButton<int>(
            label: 'Transfer',
            items: const [
              PopupMenuItem(value: 1, child: Text('Unattended transfer')),
              PopupMenuItem(value: 2, child: Text('Attended transfer')),
            ],
            child: const Icon(Icons.phone_forwarded),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.phone_forwarded));
      await tester.pumpAndSettle();

      expect(find.text('Unattended transfer'), findsOneWidget);
      expect(find.text('Attended transfer'), findsOneWidget);
    });
  });
}
