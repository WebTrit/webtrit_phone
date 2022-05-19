import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/theme.dart';

class Actionpad extends StatelessWidget {
  final bool video;
  final VoidCallback? onCallPressed;
  final VoidCallback? onCallLongPress;
  final VoidCallback? onBackspacePressed;
  final VoidCallback? onBackspaceLongPress;

  const Actionpad({
    Key? key,
    this.video = false,
    this.onCallPressed,
    this.onCallLongPress,
    this.onBackspacePressed,
    this.onBackspaceLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final TextButtonStyles? textButtonStyles = themeData.extension<TextButtonStyles>();
    final actionRows = [
      TableRow(
        children: [
          Container(),
          Center(
            child: TextButton(
              onPressed: onCallPressed,
              onLongPress: onCallLongPress,
              style: TextButton.styleFrom(
                minimumSize: Size.square(MediaQuery.of(context).size.width / 4),
              ),
              child: Icon(
                video ? Icons.videocam : Icons.call,
                size: Theme.of(context).textTheme.headline2!.fontSize,
              ),
            ),
          ),
          Center(
            child: TextButton(
              onPressed: onBackspacePressed,
              onLongPress: onBackspaceLongPress,
              style: textButtonStyles?.neutral,
              child: const Icon(
                Icons.backspace_outlined,
              ),
            ),
          ),
        ],
      ),
    ];

    return TextButtonTheme(
      data: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: Size.square(MediaQuery.of(context).size.width / 5),
          shape: const CircleBorder(),
        ),
      ),
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: actionRows,
      ),
    );
  }
}
