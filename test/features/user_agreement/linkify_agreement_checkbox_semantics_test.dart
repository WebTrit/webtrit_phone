import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/features/user_agreement/widgets/linkify_agreement_checkbox.dart';
import 'package:webtrit_phone/l10n/l10n.dart';

import '../../helpers/helpers.dart';

void main() {
  const spokenName = 'I have read the The terms and conditions of the agreement and consent to its terms.';

  Widget wrap({
    bool accepted = false,
    ValueChanged<bool>? onChanged,
    VoidCallback? onLinkTap,
    TargetPlatform? platform,
  }) {
    return MaterialApp(
      theme: ThemeData(platform: platform),
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

  testWidgets('the box says what is being agreed to and answers a press', (tester) async {
    final handle = tester.ensureSemantics();

    await tester.pumpWidget(wrap());

    // The sentence is a node of its own - it hosts a link and cannot be
    // merged in - so the box has to repeat it, or it announces as a bare
    // "checkbox" with nothing to agree to.
    expectTapTargetSemantics(
      tester,
      find.bySemanticsIdentifier(userAgreementCheckboxId),
      label: spokenName,
      identifier: userAgreementCheckboxId,
    );

    handle.dispose();
  });

  testWidgets('agreeing and taking it back both work through semantics', (tester) async {
    final handle = tester.ensureSemantics();

    bool? changed;
    await tester.pumpWidget(wrap(onChanged: (value) => changed = value));
    await tapViaSemantics(tester, find.bySemanticsIdentifier(userAgreementCheckboxId));
    expect(changed, isTrue);

    await tester.pumpWidget(wrap(accepted: true, onChanged: (value) => changed = value));
    await tapViaSemantics(tester, find.bySemanticsIdentifier(userAgreementCheckboxId));
    expect(changed, isFalse, reason: 'taking consent back has to work the same way');

    handle.dispose();
  });

  testWidgets('the box is big enough to be hit reliably', (tester) async {
    // The row cannot be merged into one control, so this box is the only
    // target it offers.
    await tester.pumpWidget(wrap());

    final box = tester.getSize(find.byKey(userAgreementCheckboxKey));
    expect(box.width, greaterThanOrEqualTo(kMinInteractiveDimension));
    expect(box.height, greaterThanOrEqualTo(kMinInteractiveDimension));
  });

  testWidgets('and stays that size on a desktop-class platform', (tester) async {
    // A desktop browser reports one of these, and there Material's own
    // default would take the box below the size it takes to hit it.
    await tester.pumpWidget(wrap(platform: TargetPlatform.macOS));

    final box = tester.getSize(find.byKey(userAgreementCheckboxKey));
    expect(box.width, greaterThanOrEqualTo(kMinInteractiveDimension));
    expect(box.height, greaterThanOrEqualTo(kMinInteractiveDimension));
  });

  testWidgets('the link opens without touching the consent', (tester) async {
    var opened = false;
    bool? changed;
    await tester.pumpWidget(wrap(onChanged: (value) => changed = value, onLinkTap: () => opened = true));

    await tester.tapOnText(find.textRange.ofSubstring('conditions'));
    await tester.pump();

    expect(opened, isTrue);
    expect(changed, isNull, reason: 'reading the terms is not agreeing to them');
  });

  testWidgets('a tap beside the link does nothing at all', (tester) async {
    // The sentence deliberately answers no tap: its hit area follows the
    // glyphs, so a near miss on the link would otherwise flip a consent.
    bool? changed;
    var opened = false;
    await tester.pumpWidget(wrap(onChanged: (value) => changed = value, onLinkTap: () => opened = true));

    await tester.tapOnText(find.textRange.ofSubstring('consent'));
    await tester.pump();

    expect(changed, isNull);
    expect(opened, isFalse);
  });

  testWidgets('the row leaves no unnamed press target behind', (tester) async {
    final handle = tester.ensureSemantics();

    await tester.pumpWidget(wrap());

    await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));

    handle.dispose();
  });
}
