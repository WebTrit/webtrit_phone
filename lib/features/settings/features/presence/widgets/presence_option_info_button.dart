import 'package:flutter/material.dart';

import 'package:webtrit_phone/widgets/widgets.dart';

/// Info button of a presence option: a press opens the explanation.
///
/// The explanation is a paragraph, and it used to be a tooltip on a bare
/// glyph: it answered a tap on the glyph alone, which is half the size a
/// target has to be, it was not offered as a control at all, and it showed for
/// ten seconds and then took itself away. A dialog stays until it is
/// dismissed, can be re-read, and is ordinary content for a screen reader.
class PresenceOptionInfoButton extends StatelessWidget {
  const PresenceOptionInfoButton({super.key, required this.option, required this.message});

  /// Caption of the option this button explains; it titles the explanation.
  final String option;

  final String message;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.info_outline),
      onPressed: () => AcknowledgeDialog.show(context, title: option, content: message),
    );
  }
}
