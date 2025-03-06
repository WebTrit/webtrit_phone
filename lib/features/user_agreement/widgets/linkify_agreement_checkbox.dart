import 'package:flutter/material.dart';

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
        Transform.translate(
          offset: const Offset(-8, 0),
          child: Checkbox(
            value: userAgreementAccepted,
            onChanged: (value) => onChanged(value ?? false),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
        Expanded(
          child: Linkify(
            text: context.l10n.user_agreement_checkbox_text(agreementLink),
            onOpen: (_) => onAgreementLinkTap(),
            style: LinkifyStyle(
              style: themeData.textTheme.labelLarge,
              linkStyle: themeData.textTheme.labelLarge?.copyWith(
                decoration: TextDecoration.underline,
                color: null,
              ),
            ),
            linkifiers: [UrlReplaceLinkifier(context.l10n.user_agreement_agrement_link)],
          ),
        ),
      ],
    );
  }
}
