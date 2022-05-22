import 'package:flutter/material.dart';

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
    return TextButtonsTable(
      minimumSize: Size.square(MediaQuery.of(context).size.width / 5),
      children: [
        _buildKeyButton(context, '1', ''),
        _buildKeyButton(context, '2', 'A B C'),
        _buildKeyButton(context, '3', 'D E F'),
        _buildKeyButton(context, '4', 'G H I'),
        _buildKeyButton(context, '5', 'J K L'),
        _buildKeyButton(context, '6', 'M N O'),
        _buildKeyButton(context, '7', 'P Q R S'),
        _buildKeyButton(context, '8', 'T U V'),
        _buildKeyButton(context, '9', 'W X Y Z'),
        _buildKeyButton(context, '*', ''),
        _buildKeyButton(context, '0', '+'),
        _buildKeyButton(context, '#', ''),
      ],
    );
  }

  Widget _buildKeyButton(BuildContext context, String text, String subtext) {
    final themeData = Theme.of(context);
    final TextButtonStyles? textButtonStyles = themeData.extension<TextButtonStyles>();
    return TextButton(
      onPressed: () => onKeypadPressed(text),
      onLongPress: subtext.length != 1 ? null : () => onKeypadPressed(subtext),
      style: textButtonStyles?.neutral,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(fontSize: themeData.textTheme.headlineLarge?.fontSize),
          ),
          Builder(builder: (context) {
            final defaultTextStyle = DefaultTextStyle.of(context);
            var color = defaultTextStyle.style.color;
            if (color != null) {
              var opacity = color.opacity - 0.3;
              if (opacity < 0.2) {
                opacity = 0.2;
              }
              color = color.withOpacity(opacity);
            }
            return Text(
              subtext,
              style: themeData.textTheme.bodyMedium?.copyWith(
                color: color,
              ),
            );
          }),
        ],
      ),
    );
  }
}
