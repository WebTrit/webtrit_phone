import 'package:flutter/material.dart';

class AgreementCheckbox extends StatelessWidget {
  const AgreementCheckbox({
    super.key,
    this.checkboxKey,
    required this.text,
    required this.agreementAccepted,
    required this.onChanged,
  });

  /// Anchor for the box itself. The row spans the full width, so a key on this
  /// widget would put a test tap in the middle of the sentence instead.
  final Key? checkboxKey;

  final String text;
  final bool agreementAccepted;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    // The whole row answers a tap, not just the box: the sentence is the
    // larger half of the target, and tapping it used to do nothing at all,
    // leaving the agreement declined with no hint why the screen would not
    // proceed.
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onChanged(!agreementAccepted),
      child: Row(
        children: [
          Transform.translate(
            offset: const Offset(-8, 0),
            child: Checkbox(
              key: checkboxKey,
              value: agreementAccepted,
              onChanged: (value) => onChanged(value ?? false),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
