import 'package:flutter/material.dart';

import 'package:webtrit_phone/app/keys.dart';
import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class LinkifyAgreementCheckbox extends StatelessWidget {
  const LinkifyAgreementCheckbox({
    super.key,
    required this.agreementLink,
    required this.userAgreementAccepted,
    required this.onChanged,
    required this.onAgreementLinkTap,
  });

  final String agreementLink;
  final bool userAgreementAccepted;
  final Function(bool) onChanged;
  final Function() onAgreementLinkTap;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Row(
      children: [
        // Unlike the plain [AgreementCheckbox], this row cannot be merged
        // into a single control: the sentence hosts a link, and merging
        // would swallow the link's own activation. So the sentence keeps its
        // node and the box repeats it as its name - otherwise the box would
        // announce as a bare "checkbox" with nothing to agree to.
        SemanticAction(
          label: context.l10n.user_agreement_checkbox_text(context.l10n.user_agreement_agrement_link),
          identifier: userAgreementCheckboxId,
          child: Checkbox(
            key: userAgreementCheckboxKey,
            value: userAgreementAccepted,
            onChanged: (value) => onChanged(value ?? false),
            // No tap target override: Material sizes the box to the smallest
            // target that can be hit reliably, and shrinking it left the box
            // as the only way to agree here - the sentence beside it cannot
            // be merged in, because of the link.
          ),
        ),
        Expanded(
          // Tapping the sentence agrees as well, so the target is the width
          // of the row rather than one small box; the link keeps its own tap
          // and still opens. Kept out of the semantics tree on purpose: the
          // box above already offers this action under a name, and a second
          // nameless tap target beside it would be announced as one more
          // unlabelled control.
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            excludeFromSemantics: true,
            onTap: () => onChanged(!userAgreementAccepted),
            child: Linkify(
              text: context.l10n.user_agreement_checkbox_text(agreementLink),
              onOpen: (_) => onAgreementLinkTap(),
              style: LinkifyStyle(
                style: themeData.textTheme.labelLarge,
                linkStyle: themeData.textTheme.labelLarge?.copyWith(decoration: TextDecoration.underline, color: null),
              ),
              linkifiers: [UrlReplaceLinkifier(context.l10n.user_agreement_agrement_link)],
            ),
          ),
        ),
      ],
    );
  }
}
