import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/widgets/widgets.dart';

import '../helpers/helpers.dart';

void main() {
  const text = 'I agree to allow the app to access my contacts.';
  const checkboxKey = Key('agreementCheckbox');

  Widget wrap({required bool accepted, required ValueChanged<bool> onChanged}) {
    return MaterialApp(
      home: Scaffold(
        body: AgreementCheckbox(
          checkboxKey: checkboxKey,
          identifier: 'agreementCheckbox',
          text: text,
          agreementAccepted: accepted,
          onChanged: onChanged,
        ),
      ),
    );
  }

  testWidgets('the box says what is being agreed to and exposes its state', (tester) async {
    final handle = tester.ensureSemantics();

    await tester.pumpWidget(wrap(accepted: false, onChanged: (_) {}));

    // The sentence is a sibling widget, so without this the box would announce
    // as a bare "checkbox" with nothing to agree to.
    expect(
      tester.getSemantics(find.bySemanticsIdentifier('agreementCheckbox')),
      isSemantics(label: text, identifier: 'agreementCheckbox', hasCheckedState: true, isChecked: false),
    );

    handle.dispose();
  });

  testWidgets('activating it through semantics accepts the agreement', (tester) async {
    final handle = tester.ensureSemantics();

    var accepted = false;
    await tester.pumpWidget(wrap(accepted: false, onChanged: (value) => accepted = value));

    await tapViaSemantics(tester, find.bySemanticsIdentifier('agreementCheckbox'));

    expect(accepted, isTrue);

    handle.dispose();
  });

  testWidgets('tapping the sentence accepts the agreement, like the box itself', (tester) async {
    var accepted = false;
    await tester.pumpWidget(wrap(accepted: false, onChanged: (value) => accepted = value));

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
