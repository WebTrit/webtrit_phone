import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/extensions/extensions.dart';

void main() {
  testWidgets('a message carries the shared id, so an assertion does not depend on its wording', (tester) async {
    final handle = tester.ensureSemantics();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) =>
                ElevatedButton(onPressed: () => context.showSnackBar('Wrong password'), child: const Text('show')),
          ),
        ),
      ),
    );

    await tester.tap(find.text('show'));
    await tester.pump();

    expect(
      tester.getSemantics(find.bySemanticsIdentifier(appSnackBarId)),
      isSemantics(identifier: appSnackBarId, label: 'Wrong password'),
    );

    handle.dispose();
  });
}
