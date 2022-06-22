import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

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

    return TextButtonsTable(
      minimumSize: Size.square(MediaQuery.of(context).size.width / 5),
      children: [
        const SizedBox(),
        TextButton(
          onPressed: onCallPressed,
          onLongPress: onCallLongPress,
          style: textButtonStyles?.callStart,
          child: Icon(
            video ? Icons.videocam : Icons.call,
            size: Theme.of(context).textTheme.headline2!.fontSize,
          ),
        ),
        TextButton(
          onPressed: onBackspacePressed,
          onLongPress: onBackspaceLongPress,
          style: textButtonStyles?.neutral,
          child: const Icon(
            Icons.backspace_outlined,
          ),
        ),
      ],
    );
  }
}
