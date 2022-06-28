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
    final TextButtonStyles? textButtonStyles = themeData.extension<TextButtonStyles>();

    return TextButtonsTable(
      minimumSize: Size.square(MediaQuery.of(context).size.width / 5),
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
