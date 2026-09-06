import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/widgets/widgets.dart';

void main() {
  Widget wrap(Widget inner) => MaterialApp(
    home: Scaffold(
      body: Semantics(container: true, button: true, label: 'Open the thing', onTap: () {}, child: inner),
    ),
  );

  testWidgets('the id joins the node above instead of forming one of its own', (tester) async {
    final handle = tester.ensureSemantics();

    await tester.pumpWidget(wrap(const SemanticIdOfAncestor(identifier: 'theThing', child: Icon(Icons.star))));

    // Name, id and press all on one node: that is the whole point of reaching
    // upwards instead of declaring a node here.
    expect(
      tester.getSemantics(find.bySemanticsIdentifier('theThing')),
      isSemantics(label: 'Open the thing', identifier: 'theThing', hasTapAction: true, isButton: true),
    );

    handle.dispose();
  });

  testWidgets('a plain Semantics id would land on a node of its own instead', (tester) async {
    final handle = tester.ensureSemantics();

    await tester.pumpWidget(wrap(Semantics(identifier: 'theThing', child: const Icon(Icons.star))));

    // The behaviour this widget exists to avoid: an identifier implicitly
    // introduces a node, and that node has neither the name nor the press.
    expect(
      tester.getSemantics(find.bySemanticsIdentifier('theThing')),
      isSemantics(label: '', identifier: 'theThing', hasTapAction: false),
    );

    handle.dispose();
  });
}
