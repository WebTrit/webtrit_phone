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

  /// Everything Material puts around the box to reach a reliable tap target.
  /// Pulling the box back by it lines the drawn square up with the text and
  /// the button below instead of indenting it by its own padding.
  static const _boxPadding = (kMinInteractiveDimension - Checkbox.width) / 2;

  final String agreementLink;
  final bool userAgreementAccepted;
  final Function(bool) onChanged;
  final Function() onAgreementLinkTap;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Row(
      children: [
        Transform.translate(
          offset: const Offset(-_boxPadding, 0),
          // Unlike the plain [AgreementCheckbox], this row cannot be merged
          // into a single control: the sentence hosts a link, and merging
          // would swallow the link's own activation. So the sentence keeps its
          // node and the box repeats it as its name - otherwise the box would
          // announce as a bare "checkbox" with nothing to agree to.
          //
          // It also leaves the box as the only way to agree by touch. The
          // sentence cannot take a tap of its own: a tap that misses the link
          // by a few pixels - its hit area follows the glyphs, not the line -
          // would toggle a consent instead of opening the terms.
          child: SemanticAction(
            label: context.l10n.user_agreement_checkbox_text(context.l10n.user_agreement_agrement_link),
            identifier: userAgreementCheckboxId,
            child: Checkbox(
              key: userAgreementCheckboxKey,
              value: userAgreementAccepted,
              onChanged: (value) => onChanged(value ?? false),
              // Stated rather than left to the default: off mobile Material
              // shrinks the target below the size it takes to hit it, and
              // here that target is the only one the row offers.
              materialTapTargetSize: MaterialTapTargetSize.padded,
            ),
          ),
        ),
        Expanded(
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
      ],
    );
  }
}
