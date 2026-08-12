import 'package:flutter/material.dart';

import 'package:webtrit_phone/widgets/widgets.dart';

class AgreementCheckbox extends StatelessWidget {
  const AgreementCheckbox({
    super.key,
    this.checkboxKey,
    this.identifier,
    required this.text,
    required this.agreementAccepted,
    required this.onChanged,
  });

  /// Anchor for the box itself. The row spans the full width, so a key on this
  /// widget would make a test tap land on the sentence instead of the box.
  final Key? checkboxKey;

  final String? identifier;

  final String text;
  final bool agreementAccepted;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    // The box and the sentence are one control: the box holds the state, the
    // sentence gives it its name, and the whole row answers a tap. Naming the
    // box alone would say the sentence twice and leave the text area silent
    // under an exploring finger; merging without making the row tappable would
    // be worse still - the row would advertise a target that only the small
    // box at its left edge actually answers.
    return SemanticAction(
      identifier: identifier,
      child: GestureDetector(
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
      ),
    );
  }
}
