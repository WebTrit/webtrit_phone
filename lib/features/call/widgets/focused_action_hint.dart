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
    this.hintStyle,
  });

  final String focusedName;

  /// Names of the calls that will be put on hold when the focused one is
  /// answered. Ignored when [willBeHeldNames] is empty.
  final List<String> willBeHeldNames;

  /// Names of the calls that will be ended when the focused one is answered
  /// (only when none of the others can be held).
  final List<String> willBeEndedNames;

  final CallInfoStyle? style;

  /// Pill and highlight colors from the themed palette (theme JSONs).
  final FocusedActionHintStyle? hintStyle;

  /// Builds a span for [text] with the [highlight] substring emphasized via
  /// [emphasis]. The localized templates inline the names as plain text, so
  /// the name is found by substring rather than by splitting the template.
  TextSpan _highlightedSpan(String text, String highlight, TextStyle base, TextStyle emphasis) {
    final index = text.indexOf(highlight);
    if (index < 0) return TextSpan(text: text, style: base);
    return TextSpan(
      style: base,
      children: [
        TextSpan(text: text.substring(0, index)),
        TextSpan(text: highlight, style: emphasis),
        TextSpan(text: text.substring(index + highlight.length)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final baseStyle = style?.callStatus ?? const TextStyle();
    final actingOnStyle = baseStyle.copyWith(fontSize: 13);
    final focusedNameStyle = actingOnStyle.copyWith(fontWeight: FontWeight.w700);
    final sideEffectStyle = baseStyle.copyWith(fontSize: 12);
    // Colors come from the themed palette (FocusedActionHintStyle, fed by the
    // theme JSONs); the fallbacks derive from the ambient scheme/text color.
    final affectedNameStyle = sideEffectStyle.copyWith(
      color: hintStyle?.affectedName ?? sideEffectStyle.color,
      fontWeight: FontWeight.w600,
    );
    final backgroundColor = hintStyle?.background ?? Theme.of(context).colorScheme.scrim.withValues(alpha: 0.25);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(14)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text.rich(
            _highlightedSpan(
              context.l10n.call_FocusedActionHint_actingOn(focusedName),
              focusedName,
              actingOnStyle,
              focusedNameStyle,
            ),
            textAlign: TextAlign.center,
          ),
          if (willBeHeldNames.isNotEmpty)
            Text.rich(
              _highlightedSpan(
                context.l10n.call_FocusedActionHint_willBeHeld(willBeHeldNames.join(', ')),
                willBeHeldNames.join(', '),
                sideEffectStyle,
                affectedNameStyle,
              ),
              textAlign: TextAlign.center,
            )
          else if (willBeEndedNames.isNotEmpty)
            Text.rich(
              _highlightedSpan(
                context.l10n.call_FocusedActionHint_willBeEnded(willBeEndedNames.join(', ')),
                willBeEndedNames.join(', '),
                sideEffectStyle,
                affectedNameStyle,
              ),
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }
}
