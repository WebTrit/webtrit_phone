import 'package:flutter/material.dart';

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
    required this.subscribed,
    required this.onChanged,
  });

  /// Caption of the option; it is also what names the checkbox.
  final String text;

  /// Longer explanation shown by the info button next to the option.
  final String info;

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
              text: text,
              textStyle: themeData.textTheme.labelMedium,
              agreementAccepted: subscribed,
              onChanged: onChanged,
            ),
          ),
        ),
        _OptionInfoButton(message: info),
      ],
    );
  }
}

/// Info button of an option: a press shows the explanation, which used to
/// answer only a tap on the glyph itself and was not offered as a control at
/// all - so nothing announced it and nothing could activate it.
class _OptionInfoButton extends StatefulWidget {
  const _OptionInfoButton({required this.message});

  final String message;

  @override
  State<_OptionInfoButton> createState() => _OptionInfoButtonState();
}

class _OptionInfoButtonState extends State<_OptionInfoButton> {
  final _tooltipKey = GlobalKey<TooltipState>();

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Tooltip(
      key: _tooltipKey,
      message: widget.message,
      triggerMode: TooltipTriggerMode.manual,
      showDuration: const Duration(seconds: 10),
      textStyle: themeData.textTheme.labelSmall?.copyWith(color: themeData.colorScheme.onSecondary),
      child: IconButton(
        icon: const Icon(Icons.info_outline),
        onPressed: () => _tooltipKey.currentState?.ensureTooltipVisible(),
      ),
    );
  }
}
