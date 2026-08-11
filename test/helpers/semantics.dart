import 'package:flutter/semantics.dart';
import 'package:flutter_test/flutter_test.dart';

/// Asserts that the control found by [finder] is exposed to assistive
/// technology as a single semantics node that carries the tap action
/// together with the given [label] and/or [identifier].
///
/// This is the accessibility contract every interactive control must meet:
/// name, automation id and action on the same node. A control whose label or
/// id lives on a different node than its action fails this matcher even
/// though it may look correct on screen.
///
/// The node's tooltip is asserted to be [tooltip] - empty by default, because
/// a stray tooltip merged in from a nested widget is spoken on top of the
/// label (appended to it on iOS) and is easy to miss otherwise.
///
/// Call within a `tester.ensureSemantics()` scope.
void expectTapTargetSemantics(
  WidgetTester tester,
  Finder finder, {
  String? label,
  String? identifier,
  bool? isButton,
  String tooltip = '',
}) {
  expect(
    tester.getSemantics(finder),
    isSemantics(label: label, identifier: identifier, tooltip: tooltip, hasTapAction: true, isButton: isButton),
  );
}

/// Activates the control found by [finder] the way assistive technology does:
/// through the tap action of its semantics node, not through a pointer event.
///
/// A pointer tap can succeed while the semantics path is broken (the node's
/// merged tap action pointing at a no-op), so activation tests must use this
/// instead of `tester.tap`.
Future<void> tapViaSemantics(WidgetTester tester, Finder finder) async {
  final node = tester.getSemantics(finder);
  expect(node.getSemanticsData().hasAction(SemanticsAction.tap), isTrue, reason: 'node has no tap action: $node');
  node.owner!.performAction(node.id, SemanticsAction.tap);
  await tester.pump();
}
