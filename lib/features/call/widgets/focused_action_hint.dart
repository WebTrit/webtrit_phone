import 'package:flutter/material.dart';

import 'package:webtrit_phone/l10n/l10n.dart';

import '../view/call_screen_style.dart';

/// "Acting on: `<name>`" hint above the call action area.
///
/// Confirms which call the buttons below apply to and spells out the side
/// effect answering will have on the other calls ("`<name>` will be put on
/// hold" / "`<name>` will be ended"). Shown only with multiple calls; the
/// caller computes the affected names (see the answer-intent selection in
/// [CallControlEvent.answerFocused]).
class FocusedActionHint extends StatelessWidget {
  const FocusedActionHint({
    super.key,
    required this.focusedName,
    this.willBeHeldNames = const [],
    this.willBeEndedNames = const [],
    this.style,
  });

  final String focusedName;

  /// Names of the calls that will be put on hold when the focused one is
  /// answered. Ignored when [willBeHeldNames] is empty.
  final List<String> willBeHeldNames;

  /// Names of the calls that will be ended when the focused one is answered
  /// (only when none of the others can be held).
  final List<String> willBeEndedNames;

  final CallInfoStyle? style;

  @override
  Widget build(BuildContext context) {
    final baseStyle = style?.callStatus ?? const TextStyle();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            context.l10n.call_FocusedActionHint_actingOn(focusedName),
            style: baseStyle.copyWith(fontSize: 13, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          if (willBeHeldNames.isNotEmpty)
            Text(
              context.l10n.call_FocusedActionHint_willBeHeld(willBeHeldNames.join(', ')),
              style: baseStyle.copyWith(fontSize: 12),
              textAlign: TextAlign.center,
            )
          else if (willBeEndedNames.isNotEmpty)
            Text(
              context.l10n.call_FocusedActionHint_willBeEnded(willBeEndedNames.join(', ')),
              style: baseStyle.copyWith(fontSize: 12),
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }
}
