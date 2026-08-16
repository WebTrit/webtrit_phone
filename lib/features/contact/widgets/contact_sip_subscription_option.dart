import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

/// A switchable option of the contact card: a checkbox with its caption and an
/// info button that explains what turning it on does.
///
/// The presence option and the active-calls option are the same control with
/// different text, so they share one implementation here.
class ContactSipSubscriptionOption extends StatelessWidget {
  const ContactSipSubscriptionOption({
    super.key,
    required this.text,
    required this.info,
    required this.identifier,
    required this.infoIdentifier,
    required this.subscribed,
    required this.onChanged,
  });

  /// Caption of the option; it is also what names the checkbox.
  final String text;

  /// Longer explanation shown by the info button next to the option.
  final String info;

  /// Automation id of the option itself.
  final String identifier;

  /// Automation id of the info button next to it.
  final String infoIdentifier;

  final bool subscribed;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Row(
      children: [
        Expanded(
          // A row shorter than this is a target too small to hit reliably; the
          // caption is often a single line, so the height has to be asked for.
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 48),
            child: AgreementCheckbox(
              identifier: identifier,
              text: text,
              textStyle: themeData.textTheme.labelMedium,
              agreementAccepted: subscribed,
              onChanged: onChanged,
            ),
          ),
        ),
        _OptionInfoButton(option: text, message: info, identifier: infoIdentifier),
      ],
    );
  }
}

/// Info button of an option: a press opens the explanation.
///
/// The explanation is a paragraph, and it used to be a tooltip: it answered a
/// tap on the glyph alone, was not offered as a control at all, showed for ten
/// seconds and then took itself away with no way to bring it back. A dialog
/// stays until it is dismissed, can be re-read, and is ordinary content for a
/// screen reader.
class _OptionInfoButton extends StatelessWidget {
  const _OptionInfoButton({required this.option, required this.message, required this.identifier});

  /// Caption of the option, which titles the explanation.
  final String option;

  final String message;

  /// Automation id of the button.
  final String identifier;

  @override
  Widget build(BuildContext context) {
    return SemanticAction(
      label: context.l10n.contact_SemanticsLabel_optionInfo,
      identifier: identifier,
      child: IconButton(
        icon: const Icon(Icons.info_outline),
        onPressed: () => AcknowledgeDialog.show(context, title: option, content: message),
      ),
    );
  }
}
