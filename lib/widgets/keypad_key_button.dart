import 'package:flutter/material.dart';

class KeypadKeyButton extends StatelessWidget {
  const KeypadKeyButton({
    Key? key,
    required this.text,
    required this.subtext,
    required this.onKeyPressed,
    this.style,
    this.textFontSize,
    this.textColor,
    this.subtextFontSize,
  }) : super(key: key);

  final String text;
  final String subtext;

  final void Function(String) onKeyPressed;

  final ButtonStyle? style;

  final double? textFontSize;
  final Color? textColor;
  final double? subtextFontSize;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return TextButton(
      onPressed: () => onKeyPressed(text),
      onLongPress: subtext.length != 1 ? null : () => onKeyPressed(subtext),
      style: style,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: textFontSize ?? themeData.textTheme.headlineLarge?.fontSize,
              height: 1.0,
            ),
          ),
          Builder(builder: (context) {
            final defaultTextStyle = DefaultTextStyle.of(context);
            var color = textColor ?? defaultTextStyle.style.color;
            if (color != null) {
              var opacity = color.opacity - 0.3;
              if (opacity < 0.2) {
                opacity = 0.2;
              }
              color = color.withOpacity(opacity);
            }
            return Text(
              subtext,
              style: TextStyle(
                fontSize: themeData.textTheme.bodyMedium?.fontSize,
                color: color,
                height: 1.0,
              ),
            );
          }),
        ],
      ),
    );
  }
}
