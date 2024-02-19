import 'dart:math';

import 'package:flutter/material.dart';

import 'package:webtrit_phone/theme/theme.dart';
import 'package:webtrit_phone/widgets/widgets.dart';

class Actionpad extends StatelessWidget {
  const Actionpad({
    super.key,
    this.video = false,
    this.transfer = false,
    this.onCallPressed,
    this.onCallLongPress,
    this.onTransferPressed,
    this.onBackspacePressed,
    this.onBackspaceLongPress,
  });

  final bool video;
  final bool transfer;
  final VoidCallback? onCallPressed;
  final VoidCallback? onCallLongPress;
  final VoidCallback? onTransferPressed;
  final VoidCallback? onBackspacePressed;
  final VoidCallback? onBackspaceLongPress;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final TextButtonStyles? textButtonStyles = themeData.extension<TextButtonStyles>();

    final mediaQueryData = MediaQuery.of(context);
    final minimumDimension = min(mediaQueryData.size.width / 5, mediaQueryData.size.height / 7);

    return TextButtonsTable(
      minimumSize: Size.square(minimumDimension),
      children: [
        const SizedBox(),
        TextButton(
          onPressed: transfer ? onTransferPressed : onCallPressed,
          onLongPress: transfer ? null : onCallLongPress,
          style: transfer ? textButtonStyles?.callTransfer : textButtonStyles?.callStart,
          child: Icon(
            transfer
                ? Icons.phone_forwarded
                : video
                    ? Icons.videocam
                    : Icons.call,
            size: Theme.of(context).textTheme.displayMedium!.fontSize,
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
