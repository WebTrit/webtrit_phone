import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/widgets/widgets.dart';

void main() {
  const text = 'I agree to allow the app to access my contacts.';
  const checkboxKey = Key('agreementCheckbox');

  Widget wrap({required bool accepted, required ValueChanged<bool> onChanged}) {
    return MaterialApp(
      home: Scaffold(
        body: AgreementCheckbox(
          checkboxKey: checkboxKey,
          text: text,
          agreementAccepted: accepted,
          onChanged: onChanged,
        ),
      ),
    );
  }

  testWidgets('tapping the sentence accepts the agreement, like the box itself', (tester) async {
    var accepted = false;
    await tester.pumpWidget(wrap(accepted: false, onChanged: (value) => accepted = value));

    // The sentence is the larger half of the row and used to be dead: a person
    // tapping it saw nothing happen and no reason why the screen would not go
    // on.
    await tester.tap(find.text(text));
    await tester.pump();

    expect(accepted, isTrue);
  });

  testWidgets('tapping the box itself still works', (tester) async {
    var accepted = false;
    await tester.pumpWidget(wrap(accepted: false, onChanged: (value) => accepted = value));

    await tester.tap(find.byKey(checkboxKey));
    await tester.pump();

    expect(accepted, isTrue);
  });

  testWidgets('tapping an accepted row takes the agreement back', (tester) async {
    var accepted = true;
    await tester.pumpWidget(wrap(accepted: true, onChanged: (value) => accepted = value));

    await tester.tap(find.text(text));
    await tester.pump();

    expect(accepted, isFalse);
  });
}
