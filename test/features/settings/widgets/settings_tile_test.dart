import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/features/settings/widgets/settings_tile.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

void main() {
  Widget buildTestable({Widget? trailing, String? trailingValue}) {
    return MaterialApp(
      home: Scaffold(
        body: SettingsTile(
          title: 'Voicemail',
          icon: Icons.voicemail,
          trailing: trailing,
          trailingValue: trailingValue,
          showSeparator: false,
          onTap: () {},
        ),
      ),
    );
  }

  testWidgets('speaks what its badge stands for, after its own title', (tester) async {
    // A tile merges its icon, title and trailing slot into a single node, so a
    // badge left to speak for itself is read out inside the title.
    final handle = tester.ensureSemantics();

    await tester.pumpWidget(buildTestable(trailing: const CountBadge(count: 3), trailingValue: '3 unread'));

    final data = tester.getSemantics(find.bySemanticsLabel('Voicemail')).getSemanticsData();
    expect(data.label, 'Voicemail');
    expect(data.value, '3 unread');

    handle.dispose();
  });

  testWidgets('says nothing extra when it carries no badge', (tester) async {
    final handle = tester.ensureSemantics();

    await tester.pumpWidget(buildTestable());

    expect(tester.getSemantics(find.bySemanticsLabel('Voicemail')).getSemanticsData().value, isEmpty);

    handle.dispose();
  });
}
