import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/widgets/semantic_action.dart';

import '../helpers/helpers.dart';

void main() {
  Widget wrap(Widget child) {
    return MaterialApp(
      home: Scaffold(body: Center(child: child)),
    );
  }

  testWidgets('names a bare gesture target and merges label, identifier and tap into one node', (tester) async {
    final handle = tester.ensureSemantics();

    var tapped = false;
    await tester.pumpWidget(
      wrap(
        SemanticAction.button(
          label: 'Play',
          identifier: 'voicemailPlay',
          child: GestureDetector(
            onTap: () => tapped = true,
            child: const SizedBox(width: 48, height: 48, child: Icon(Icons.play_arrow)),
          ),
        ),
      ),
    );

    final finder = find.bySemanticsIdentifier('voicemailPlay');
    expectTapTargetSemantics(tester, finder, label: 'Play', identifier: 'voicemailPlay', isButton: true);

    await tester.tap(finder);
    expect(tapped, isTrue);

    handle.dispose();
  });

  testWidgets('keeps identifier on the same node as a button that forms its own semantics boundary', (tester) async {
    final handle = tester.ensureSemantics();

    await tester.pumpWidget(
      wrap(
        SemanticAction(
          label: 'Search',
          identifier: 'contactsSearch',
          child: IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        ),
      ),
    );

    // The identifier must resolve to the node that also carries the label and
    // the tap action - not to an empty wrapper node above the button.
    expectTapTargetSemantics(
      tester,
      find.bySemanticsIdentifier('contactsSearch'),
      label: 'Search',
      identifier: 'contactsSearch',
      isButton: true,
    );

    handle.dispose();
  });

  testWidgets('identifier-only usage preserves the existing visible label', (tester) async {
    final handle = tester.ensureSemantics();

    await tester.pumpWidget(
      wrap(
        SemanticAction(
          identifier: 'agreementAccept',
          child: TextButton(onPressed: () {}, child: const Text('Accept')),
        ),
      ),
    );

    expectTapTargetSemantics(
      tester,
      find.bySemanticsIdentifier('agreementAccept'),
      label: 'Accept',
      identifier: 'agreementAccept',
      isButton: true,
    );

    handle.dispose();
  });

  testWidgets('labeled controls meet the labeled tap target guideline', (tester) async {
    final handle = tester.ensureSemantics();

    await tester.pumpWidget(
      wrap(
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SemanticAction.button(
              label: 'Play',
              identifier: 'voicemailPlay',
              child: GestureDetector(
                onTap: () {},
                child: const SizedBox(width: 48, height: 48, child: Icon(Icons.play_arrow)),
              ),
            ),
            SemanticAction(
              label: 'Search',
              identifier: 'contactsSearch',
              child: IconButton(icon: const Icon(Icons.search), onPressed: () {}),
            ),
          ],
        ),
      ),
    );

    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));

    handle.dispose();
  });
}
