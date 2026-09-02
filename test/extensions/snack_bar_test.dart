import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/extensions/extensions.dart';

void main() {
  Future<void> pumpHost(WidgetTester tester, void Function(BuildContext context) show) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => ElevatedButton(onPressed: () => show(context), child: const Text('show')),
          ),
        ),
      ),
    );

    await tester.tap(find.text('show'));
    await tester.pump();
  }

  testWidgets('a message with something to do waits instead of timing out', (tester) async {
    await pumpHost(
      tester,
      (context) => context.showErrorSnackBar(
        'Failed',
        action: SnackBarAction(label: 'Retry', onPressed: () {}),
      ),
    );

    // Three seconds was not enough to notice the action, let alone reach it.
    await tester.pump(const Duration(seconds: 30));
    expect(find.text('Failed'), findsOneWidget);
    expect(find.byIcon(Icons.close), findsOneWidget);

    await tester.tap(find.byIcon(Icons.close));
    await tester.pumpAndSettle();
    expect(find.text('Failed'), findsNothing);
  });

  testWidgets('a message with nothing to do still goes away on its own', (tester) async {
    await pumpHost(tester, (context) => context.showSnackBar('Saved'));

    expect(find.text('Saved'), findsOneWidget);

    // The dismiss timer only starts once the bar has finished sliding in.
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();
    expect(find.text('Saved'), findsNothing);
  });
}
