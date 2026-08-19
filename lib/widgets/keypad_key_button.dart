// ignore_for_file: deprecated_member_use_from_same_package

import 'package:flutter/material.dart';

import 'package:webtrit_phone/app/keys.dart';

import 'keypad_key_style.dart';
import 'keypad_key_styles.dart';

export 'keypad_key_style.dart';
export 'keypad_key_styles.dart';

class KeypadKeyButton extends StatefulWidget {
  const KeypadKeyButton({
    super.key,
    required this.text,
    required this.subtext,
    required this.onKeyPressed,
    this.style,
    @Deprecated('Use style.textStyle instead') this.textFontSize,
    @Deprecated('Use style.textStyle instead') this.textColor,
    @Deprecated('Use style.subtextStyle instead') this.subtextFontSize,
  });

  static const _subextPadding = EdgeInsets.symmetric(horizontal: 8);

  /// Minimum alpha value applied when deriving subtext color.
  static const double _minAlphaValue = 0.2;

  /// Amount to reduce alpha from main text color for subtext.
  static const double _subtextAlphaReduction = 0.3;

  final String text;
  final String subtext;
  final void Function(String) onKeyPressed;

  final KeypadKeyStyle? style;

  @Deprecated('Use style.textStyle.fontSize instead')
  final double? textFontSize;

  @Deprecated('Use style.textStyle.color instead')
  final Color? textColor;

  @Deprecated('Use style.subtextStyle.fontSize instead')
  final double? subtextFontSize;

  @override
  State<KeypadKeyButton> createState() => _KeypadKeyButtonState();
}

class _KeypadKeyButtonState extends State<KeypadKeyButton> {
  /// Pointers currently pressing this key. A key can be struck by more than
  /// one finger at a time, and each strike owes its own character.
  final _activePointers = <int>{};

  /// Pointers whose strike has already entered the subtext, so their release
  /// must stay silent. Tracked per pointer rather than as one flag for the
  /// whole key: a finger that lands while another is still holding the
  /// subtext down is a strike of its own and still owes a text.
  final _subtextPointers = <int>{};

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themed = theme.extension<KeypadKeyStyles>()?.primary;

    final merged = KeypadKeyStyle.merge(themed, widget.style);

    final textStyle = (merged.textStyle ?? theme.textTheme.headlineLarge)?.copyWith(
      fontSize: widget.textFontSize ?? merged.textStyle?.fontSize,
      color: widget.textColor ?? merged.textStyle?.color,
      height: 1.0,
    );

    // Derive subtext color from text color with reduced opacity if not set.
    Color? derivedSubColor = textStyle?.color;
    if (derivedSubColor != null) {
      var a = derivedSubColor.a - KeypadKeyButton._subtextAlphaReduction;
      if (a < KeypadKeyButton._minAlphaValue) a = KeypadKeyButton._minAlphaValue;
      derivedSubColor = derivedSubColor.withValues(alpha: a);
    }

    final subStyle = (merged.subtextStyle ?? theme.textTheme.bodyMedium)?.copyWith(
      fontSize: widget.subtextFontSize ?? merged.subtextStyle?.fontSize,
      color: merged.subtextStyle?.color ?? derivedSubColor,
      height: 1.0,
    );

    final hasLongPress = widget.subtext.length == 1;

    // The pointer input stays on the Listener below; this node carries the
    // accessibility contract for the key. The subtree is excluded so the
    // decorative TextButton's no-op handler and the raw glyph texts do not
    // form nodes of their own - assistive-technology activation must reach
    // the same input path as a finger.
    return Semantics(
      identifier: keypadKeyId(widget.text),
      label: widget.subtext.isEmpty ? widget.text : '${widget.text} ${widget.subtext}',
      button: true,
      excludeSemantics: true,
      onTap: () => widget.onKeyPressed(widget.text),
      onLongPress: hasLongPress ? () => widget.onKeyPressed(widget.subtext) : null,
      child: Listener(
        key: Key(widget.text),
        onPointerDown: (event) {
          if (!hasLongPress) {
            widget.onKeyPressed(widget.text);
            return;
          }
          _activePointers.add(event.pointer);
        },
        // The subtext is entered by the long press below, which always fires
        // while the finger is still down. So a release already knows whether
        // its own strike produced one, and enters the text whenever it did
        // not - including when sliding off the key cancelled the long press.
        onPointerUp: hasLongPress
            ? (event) {
                if (!_activePointers.remove(event.pointer)) return;
                if (!_subtextPointers.remove(event.pointer)) widget.onKeyPressed(widget.text);
              }
            : null,
        // A press the platform takes away never reaches a release and enters
        // nothing; it still has to let go of the pointer it holds here.
        onPointerCancel: hasLongPress
            ? (event) {
                _activePointers.remove(event.pointer);
                _subtextPointers.remove(event.pointer);
              }
            : null,
        child: TextButton(
          onPressed: () {},
          onLongPress: hasLongPress
              ? () {
                  _subtextPointers.addAll(_activePointers);
                  widget.onKeyPressed(widget.subtext);
                }
              : null,
          style: merged.buttonStyle,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.text, style: textStyle),
              Padding(
                padding: KeypadKeyButton._subextPadding,
                child: Text(widget.subtext, style: subStyle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
