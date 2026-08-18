import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

/// Info button of a presence option: a press opens the explanation.
///
/// The explanation is a paragraph, and it used to be a tooltip on a bare
/// glyph: it answered a tap on the glyph alone, which is half the size a
/// target has to be, it was not offered as a control at all, and it showed for
/// ten seconds and then took itself away. A dialog stays until it is
/// dismissed, can be re-read, and is ordinary content for a screen reader.
class PresenceOptionInfoButton extends StatelessWidget {
  const PresenceOptionInfoButton({super.key, required this.option, required this.message, required this.identifier});

  /// Caption of the option this button explains: it titles the explanation,
  /// and the four options carry the same button, so it is also what keeps them
  /// apart when they are read out.
  final String option;

  final String message;

  /// Automation id of the button.
  final String identifier;

  @override
  Widget build(BuildContext context) {
    // Some of the captions end in a colon because of what they sit next to on
    // the screen; a title and a spoken name do not want it.
    final name = option.replaceFirst(RegExp(r':\s*$'), '');
    return SemanticAction(
      label: context.l10n.presenceSettings_SemanticsLabel_optionInfo(name),
      identifier: identifier,
      child: IconButton(
        icon: const Icon(Icons.info_outline),
        onPressed: () => AcknowledgeDialog.show(context, title: name, content: message),
      ),
    );
  }
}
