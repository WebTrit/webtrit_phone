import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

class AgreementCheckbox extends StatelessWidget {
  const AgreementCheckbox({
    super.key,
    required this.userAgreementAccepted,
    required this.onChanged,
    required this.onAgreementLinkTap,
  });

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
          child: RichText(
            text: TextSpan(
              text: context.l10n.permission_agreement_text1,
              style: themeData.textTheme.labelLarge,
              children: [
                TextSpan(
                  text: context.l10n.permission_agreement_text2,
                  style: themeData.textTheme.labelLarge?.copyWith(
                    color: themeData.colorScheme.primary,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = onAgreementLinkTap,
                ),
                TextSpan(
                  text: context.l10n.permission_agreement_text3,
                  style: themeData.textTheme.labelLarge,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
