import 'dart:math';

import 'package:flutter/material.dart';

import 'package:webtrit_phone/models/models.dart';
import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class Keypad extends StatelessWidget {
  const Keypad({
    Key? key,
    required this.onKeypadPressed,
  }) : super(key: key);

  final void Function(String) onKeypadPressed;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final textButtonStyles = themeData.extension<TextButtonStyles>();

    final mediaQueryData = MediaQuery.of(context);
    final minimumDimension = min(mediaQueryData.size.width / 5, mediaQueryData.size.height / 7);

    return TextButtonsTable(
      minimumSize: Size.square(minimumDimension),
      children: [
        for (final k in KeypadKey.numbers)
          KeypadKeyButton(
            text: k.text,
            subtext: k.subtext,
            onKeyPressed: (v) => onKeypadPressed(v),
            style: textButtonStyles?.neutral,
          ),
      ],
    );
  }
}
