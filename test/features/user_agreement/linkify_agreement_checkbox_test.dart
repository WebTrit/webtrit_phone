import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/user_agreement/widgets/linkify_agreement_checkbox.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

void main() {
  Widget wrap({bool accepted = false, ValueChanged<bool>? onChanged, VoidCallback? onLinkTap}) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: LinkifyAgreementCheckbox(
          agreementLink: 'https://example.com/terms',
          userAgreementAccepted: accepted,
          onChanged: onChanged ?? (_) {},
          onAgreementLinkTap: onLinkTap ?? () {},
        ),
      ),
    );
  }

  testWidgets('the box is big enough to be hit reliably', (tester) async {
    // The row cannot be merged into one control - the sentence hosts a link -
    // so the box is the only named target here, and shrinking its target left
    // it below the smallest size that can be hit reliably.
    await tester.pumpWidget(wrap());

    final box = tester.getSize(find.byKey(userAgreementCheckboxKey));
    expect(box.width, greaterThanOrEqualTo(kMinInteractiveDimension));
    expect(box.height, greaterThanOrEqualTo(kMinInteractiveDimension));
  });

  testWidgets('tapping the sentence agrees too', (tester) async {
    // The sentence spans most of the row; without this the only way to agree
    // is the small box at its left edge.
    bool? changed;
    await tester.pumpWidget(wrap(onChanged: (value) => changed = value));

    await tester.tapOnText(find.textRange.ofSubstring('consent'));
    await tester.pump();

    expect(changed, isTrue);
  });

  testWidgets('tapping the link opens it instead of agreeing', (tester) async {
    var opened = false;
    bool? changed;
    await tester.pumpWidget(wrap(onChanged: (value) => changed = value, onLinkTap: () => opened = true));

    await tester.tapOnText(find.textRange.ofSubstring('conditions'));
    await tester.pump();

    expect(opened, isTrue, reason: 'the link keeps its own tap');
    expect(changed, isNull, reason: 'and agreeing is not toggled behind it');
  });

  testWidgets('the row leaves no unnamed press target behind', (tester) async {
    final handle = tester.ensureSemantics();

    await tester.pumpWidget(wrap());

    // The sentence answers a tap as a convenience; the action it offers is
    // already exposed, under a name, by the box.
    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));

    handle.dispose();
  });
}
