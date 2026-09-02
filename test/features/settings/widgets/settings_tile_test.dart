import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/features/settings/widgets/settings_tile.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

void main() {
  Widget buildTestable({Widget? trailing, String? trailingLabel}) {
    return MaterialApp(
      home: Scaffold(
        body: SettingsTile(
          title: 'Voicemail',
          icon: Icons.voicemail,
          trailing: trailing,
          trailingLabel: trailingLabel,
          showSeparator: false,
          onTap: () {},
        ),
      ),
    );
  }

  testWidgets('speaks what its badge stands for, after its own title', (tester) async {
    // A tile merges its icon, title and trailing slot into a single node whose
    // name is assembled in the order the parts are drawn - which is what puts
    // the count behind the title. It is not the node's value: Android speaks a
    // value ahead of the name it belongs to.
    final handle = tester.ensureSemantics();

    await tester.pumpWidget(buildTestable(trailing: const CountBadge(count: 3), trailingLabel: '3 unread'));

    final data = tester.getSemantics(find.byType(ListTile)).getSemanticsData();
    expect(data.label, 'Voicemail\n3 unread');

    handle.dispose();
  });

  testWidgets('says nothing extra when it carries no badge', (tester) async {
    final handle = tester.ensureSemantics();

    await tester.pumpWidget(buildTestable());

    expect(tester.getSemantics(find.byType(ListTile)).getSemanticsData().label, 'Voicemail');

    handle.dispose();
  });
}
