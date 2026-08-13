import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/copy_to_clipboard.dart';

void main() {
  testWidgets('copying is offered as an action, not only behind a long press', (tester) async {
    final clipboard = <String>[];
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(SystemChannels.platform, (call) async {
      if (call.method == 'Clipboard.setData') clipboard.add((call.arguments as Map)['text'] as String);
      return null;
    });
    addTearDown(() => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(SystemChannels.platform, null));

    final handle = tester.ensureSemantics();

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const Scaffold(
          body: CopyToClipboard(data: '555001', child: Text('555001')),
        ),
      ),
    );

    // A long press is invisible to a screen reader: it announces nothing and
    // cannot be discovered. The same copy has to be reachable as a named
    // action on the node.
    final node = tester.getSemantics(find.text('555001'));
    final actions = node.getSemanticsData().customSemanticsActionIds!;
    final labels = actions.map((id) => CustomSemanticsAction.getAction(id)!.label).toList();
    expect(labels, contains('Copy to clipboard'));

    node.owner!.performAction(node.id, SemanticsAction.customAction, actions.first);
    await tester.pump();

    expect(clipboard, ['555001']);

    handle.dispose();
  });
}
