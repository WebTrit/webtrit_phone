import 'dart:math';
import 'package:flutter/material.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

import 'keypad_style.dart';
import 'keypad_styles.dart';

export 'keypad_style.dart';
export 'keypad_styles.dart';

class Keypad extends StatelessWidget {
  const Keypad({
    super.key,
    required this.onKeypadPressed,
    this.style,
  });

  final void Function(String) onKeypadPressed;

  final KeypadStyle? style;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themed = theme.extension<KeypadStyles>()?.primary;
    final merged = KeypadStyle.merge(themed, style);

    final mediaQueryData = MediaQuery.of(context);
    final minimumDimension = min(
      mediaQueryData.size.width / 5,
      mediaQueryData.size.height / 7,
    );

    return TextButtonsTable(
      minimumSize: Size.square(minimumDimension),
      style: TextButtonsTableStyle(
        buttonStyle: merged.buttonStyle,
        minimumSize: Size.square(minimumDimension),
      ),
      children: [
        for (final k in KeypadKey.numbers)
          KeypadKeyButton(
            text: k.text,
            subtext: k.subtext,
            onKeyPressed: onKeypadPressed,
            style: merged.keyStyle,
          ),
      ],
    );
  }
}
